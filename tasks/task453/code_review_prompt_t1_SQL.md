# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (11)
- [GRID-SQL] Campo 'Produto' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Datas' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'BarraNovos' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Apurado' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Estoque' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Faltas' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Ocorrencia' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Tipos' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'PesReals' usado em ControlSource de cursor_4c_Tratamento mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODIGOS, CPROS, CBARS, LNDIF, ETIQS, TIPOS, OCORRENCIA, AUTOS, CODBARRAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SMOEDAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODIGOS, CPROS, CBARS, LNDIF, ETIQS, TIPOS, OCORRENCIA, AUTOS, CODBARRAS

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
  ControlSource = "crSigCdBal.grupos"
  ControlSource = "crSigCdBal.datafims"
  ControlSource = "crSigCdBal.datainis"
  ControlSource = "crSigCdBal.codigos"
  ControlSource = "crSigCdBal.localfs"
  ControlSource = "crSigCdBal.localis"
  ControlSource = "crSigCdBal.iforfs"
  ControlSource = "crSigCdBal.iforis"
  ControlSource = "crSigCdBal.cgrufs"
  ControlSource = "crSigCdBal.cggrufs"
  ControlSource = "crSigCdBal.cgruis"
  ControlSource = "crSigCdBal.cggruis"
  ControlSource = "crSigCdBal.precofs"
  ControlSource = "crSigCdBal.precois"
  ControlSource = "crSigCdBal.contas"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "cstratamento.peso2s"
  ControlSource = "cstratamento.ccusto2s"
  ControlSource = "cstratamento.barra2s"
  ControlSource = "cstratamento.ocor2s"
  ControlSource = "csTratamento.dpros"
  ControlSource = "csTratamento.PesReals"
  ControlSource = "cstratamento.pesos"
  ControlSource = "csTratamento.cCusto2S"
  ControlSource = "csTratamento.cCustoS"
  ControlSource = "cstratamento.difpesos"
Select CrSigMvCcr
Insert Into CrSigMvCcr (VOpers,NOpers, NLancs, VLancs, Opers, Grupos, Contas, Moedas, Cotacaos, Valors, Emps, Datas,;
Select CrSigMvCcr
lcQryBal  = [Select * From SigCdBal Where Emps = ?_Empr Order By Codigos ]
If ThisForm.poDataMgr.SqlExecute([Select GesInd,GrupoCCbs,MoeCCbs,GrupoRecs,GrupoPags,ContaRecs,ContaPags From SigCdPam ],'CrSigCdPam') < 1
Select CrSigCdPam
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdMoe ],'CrSigCdMoe') < 1
Select CrSigCdMoe
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot') < 1
Select CrSigCdCot
If ThisForm.poDataMgr.SqlExecute([Select * From SigBaOco ],'CrSigBaOco') < 1
Select CrSigBaOco
Select CrSigCdBal
Select CsTratamento
	.Column1.ControlSource = 'CsTratamento.Produto'
	.Column2.ControlSource = 'CsTratamento.Datas'
	.Column3.ControlSource = 'CsTratamento.Barras'
	.Column4.ControlSource = 'CsTratamento.Barra2s'
	.Column5.ControlSource = 'CsTratamento.Apurado'
	.Column6.ControlSource = 'CsTratamento.Estoque'
	.Column7.ControlSource = 'CsTratamento.Difs'
	.Column8.ControlSource = 'CsTratamento.Ocorrencia'
	.Column9.ControlSource = 'CsTratamento.Tipos'
	.Column10.ControlSource = 'CsTratamento.DifPesos'
Select CrSigCdBal
Select CrSigCdBal
Select CrSigCdBal
lStrQuery = [Select * From SigIvTrT Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Tratamento') < 1
Select Tratamento
		lStrQuery = [Select a.*,b.DPros,b.PCuss ]+;
					[From SigIvTrB a, SigCdPro b ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Balanco') < 1
		Select Balanco
		lStrQuery = [Select a.Emps,a.Codigos,a.CBars,a.CPros,a.Qtds,a.pesos,a.Datas,a.CodCors,a.CodTams,a.Grupos,a.Contas,]+;
					[From SigIvTrE a, SigCdPro b ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Etiqueta') < 1
		Select Etiqueta
		lStrQuery = [Select a.*,a.CIdChaves,b.DPros,b.PCuss ]+;
					[From SigIvTrH a ]+;
					[Left Join SigCdPro b On b.CPros = a.CPros ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Historico') < 1
		Select Historico
		Select a.CPros As Produto, ;
		From Balanco a ;
		Select a.CPros as Produto, a.CBars as Barras, ;
		  From Etiqueta a ;
			  (Select b.CPros + Str(b.CBars,14) as ProBar From Historico b Where Not Empty(CBars)) ;
		Select a.CPros As Produto,a.CBars As Barras,000000000.00 As Estoque,(a.Qtds) As Apurado,000000000.00 As EstPeso,(a.Pesos) As ApurPeso,a.Obs,;
		From Historico a ;
			(Select b.CPros + Str(b.CBars,14) As ProBar From Etiqueta b)) ;
		Select a.CPros As Produto,a.CBars As Barras,000000000.00 As Estoque,(a.Qtds) As Apurado,000000000.00 As EstPeso,(a.Pesos) As ApurPeso,a.Obs,a.Ocors,;
		From Historico a ;
		Select TmpDifSaldo
			Insert Into Tratamento From MemVar
			Select TmpDifSaldo
		Select TmpBarNaoLidas
			Insert Into Tratamento From MemVar
			Select TmpBarNaoLidas
		Select TmpBarLidas
			Insert Into Tratamento From MemVar
			Select TmpBarLidas
		Select Tratamento
		If !ThisForm.poDataMgr.Update('Tratamento')
Select CsTratamento
lStrQuery = [Select a.*,b.CPros,b.DPros,b.CGrus,b.Moecs ]+;
			[From SigIvTrT a ]+;
			[Left Join SigCdPro b On b.CPros = a.Produto ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Tratamento') < 1
Select Tratamento
	Select * From CrSigMvCcr Into Cursor TmpMccr ReadWrite
	Select TmpMccr
	Select * From CrSigMvCcr Into Cursor TmpExtor ReadWrite
	Select TmpExtor
	Select Tratamento
		loBarra.Update(.T.)
		=Seek('O' + Tratamento.Ocorrencia,'CrSigBaOco','Codigos')
		=Seek(Nvl(Tratamento.MoeCs,''),'CrSigCdMoe','CMoes')
			Insert Into TmpMccr From MemVar
		lStrQuery = [Select Emps,Etiqs,TpOperas,Moedas,DtBases ]+;
					[From SigPrCtb ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpTcBal') < 1
		Select TmpTcBal
			=Seek('O' + TmpTcBal.TpOperas,'CrSigBaOco','Codigos')
				Insert Into TmpExtor From MemVar
		Insert Into CrSigPrCtb From MemVar
		Select Tratamento
	Select Grupos, Contas, Moedas, SGrupos, SContas, SMoedas, Sum(Valors) as Valors, Cotacaos, SCotacaos ;
	  From TmpMccr ;
	Select Dados
		Insert Into CrSigMvCcr From MemVar
		Select CrSigMvCcr
	Select Grupos, Contas, Moedas, SGrupos, SContas, SMoedas, Vencs, Sum(Valors) as Valors, Cotacaos, SCotacaos ;
	  From TmpMccr ;
	Select Dados
		Insert Into CrSigMvCcr From MemVar
		Select CrSigMvCcr
	ThisForm.poDataMgr.Update('CrSigCdBal')
	ThisForm.poDataMgr.Update('CrSigPrCtb')
	ThisForm.poDataMgr.Update('CrSigMvCcr')
	ThisForm.poDataMgr.Update('CrSigMvSlc')
	ThisForm.poDataMgr.Update('CrSigOpClS')
Select CrSigCdBal
lStrQuery = [Select * From SigIvTrB Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Balanco') < 1
Select Balanco
lStrQuery = [Select * From SigIvTrE Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Etiqueta') < 1
Select Etiqueta
lStrQuery = [Select * From SigIvTrH Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Historico') < 1
Select Historico
lStrQuery = [Select * From SigIvTrT Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Tratamento') < 1
Select Tratamento
Select CrSigCdBal
	lStrQuery = [Select CBars,CPros,Pesos From SigOpEtq Where CBars = ]+Alltrim(Str(lcProd,14))+[ ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
	Select TmpEti
		lStrQuery = [Select CPros,PCuss From SigCdPro Where CPros = ']+TmpEti.CPros+[' ]
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
	Select CsTratamento
	Select Codigos,Descrs From CrSigBaOco Where Tipos = 'J' Into Cursor CsOcorr ReadWrite
	Select CsOcorr
	If Seek(This.Value,'CsOcorr','Codigos')
lStrQuery = [Select * From SigIvTrB Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Balanco') < 1
Select Balanco
lStrQuery = [Select * From SigIvTrE Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Etiqueta') < 1
Select Etiqueta
lStrQuery = [Select * From SigIvTrH Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Historico') < 1
Select Historico
lStrQuery = [Select a.*,b.DPros,c.Pesos ]+;
			[From SigIvTrT a ]+;
			[Left Join SigCdPro b On b.CPros = a.Produto ]+;
			[Left Join SigOpEtq c On c.CBars = a.Barras ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Tratamento') < 1
Select Tratamento
Select CsTratamento
Select Tratamento
	loBarra.Update(.T.)
	=Seek(m.Barras,'Etiqueta','CBars')
	Insert Into CsTratamento From MemVar
	Select Tratamento
Select CsTratamento
	Select Codigos,Descrs From CrSigBaOco Where Tipos = 'O' Into Cursor CsOcorr ReadWrite
	Select CsOcorr
	If Seek(This.Value,'CsOcorr','Codigos')
			Select Codigos,Descrs From CrSigBaOco Where Tipos = 'O' And Autos <> 'S' Into Cursor CsOcorr ReadWrite
			Select CsOcorr
			If Seek(This.Value,'CsOcorr','Codigos')
		=Seek('O' + This.Value,'CrSigBaOco','Codigos')
	Select Codigos, Descrs From CrSigBaOco Where Tipos = 'O' And Autos = 'S' Into Cursor CsOcorr ReadWrite
	Select CsOcorr
	If Seek(This.Value,'CsOcorr','Codigos')
Select Codigos,Operacaos From CrSigBaOco Where Tipos = 'O' Into Cursor CsOcorr ReadWrite
Select CsOcorr
If Seek(This.Parent.GetTOcor.Value,'CsOcorr','Codigos')
		Select CrSigBaOco
		=Seek('O' + This.Parent.GetTOcor.Value,'CrSigBaOco','Codigos')
		lStrQuery = [Select * From SigIvTrE Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CIdChaves ]
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Etiqueta') < 1
		Select Etiqueta
		lStrQuery = [Select a.*,b.EmpOs As EtiEmp,b.Grupos As EtiGru,b.Contas As EtiCon,b.Datas As EtiDat,]+;
					[From SigIvTrT a ]+;
					[Left Join SigOpEtq b On b.CBars = a.Barras ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpTratam') < 1
		Select TmpTratam
		Select TmpTratam
			loBarra.Update(.T.)
			=Seek(TmpTratam.Barras,'Etiqueta','CBars')
			lStrQuery = [Select CodBarras,Emps,Dopes,Numes ]+;
						[From SigMvHst ]+;
			If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpHis') < 1
			Select TmpHis
					Select TmpTratam
					Insert Into Tratamento From MemVar
					Select TmpTratam
					Insert Into Tratamento From MemVar
		ThisForm.poDataMgr.Update('Tratamento')
	lStrQuery = [Select EmpOs,CBars,CPros,Pesos,Datas,Qtds From SigOpEtq Where CBars = ]+Alltrim(Str(lcProd,14))+[ ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
	Select TmpEti
		If Seek(lcProd,'Etiqueta','CBars') Or Seek(lcProd,'CsTratamento','Barras')
		lStrQuery = [Select CPros,DPros,PCuss From SigCdPro Where CPros = ']+TmpEti.CPros+[' ]
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
	Select CsTratamento
	Select CsEtiqueta
	Select Codigos,Descrs From CrSigBaOco Where Tipos = 'O' Into Cursor CsOcorr ReadWrite
	If Seek(This.Value,'CsOcorr','Codigos')
	Select CsTratamento
	Select CsTratamento
		Select Tratamento
		If Seek(CsTratamento.CItens,'Tratamento','CItens')
	Select CsTratamento
		Insert Into Tratamento From MemVar
		Select CsTratamento
	Select CsEtiqueta
		Insert Into Etiqueta From MemVar
		Select CsEtiqueta
	ThisForm.poDataMgr.Update('Tratamento')
	ThisForm.poDataMgr.Update('Etiqueta')
	Select CsTratamento
	If !Seek(lcProd,'CsTratamento','Barras')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formint.prg) - TRECHOS RELEVANTES PARA PASS SQL (4201 linhas total):

*-- Linhas 515 a 546:
515:         * Width=905 (12+905=917=cnt_4c_Saida.Left - sem sobreposicao)
516:         * HeaderHeight=0: botoes acima servem como cabecalhos visuais
517:         * ColumnCount FORA do WITH (Problem 36)
518:         * ControlSource/DynamicBackColor: vinculados em CarregarLista() (Problem 32)
519:         * Colunas: codigos/datainis/datafims/contas/localis/localfs/grupos/cggruis/usuars/encerras
520:         * Larguras: 62+78+75+143+81+82+69+69+78+168 = 905
521:         *----------------------------------------------------------------------
522:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
523:         loc_oPagina.grd_4c_Dados.ColumnCount = 10
524:         WITH loc_oPagina.grd_4c_Dados
525:             .Top           = 174
526:             .Left          = 12
527:             .Width         = 905
528:             .Height        = 446
529:             .RecordSource  = ""
530:             .ReadOnly      = .T.
531:             .DeleteMark    = .F.
532:             .RecordMark    = .F.
533:             .GridLines     = 1
534:             .GridLineWidth = 1
535:             .GridLineColor = RGB(200, 200, 200)
536:             .HeaderHeight  = 0
537:             .RowHeight     = 20
538:             .FontName      = "Tahoma"
539:             .FontSize      = 9
540:             .ScrollBars    = 2
541:             .Visible       = .T.
542:             WITH .Column1
543:                 .Width     = 62
544:                 .Resizable = .F.
545:                 .Alignment = 0
546:             ENDWITH

*-- Linhas 1625 a 1643:
1625:             .FontName    = "Tahoma"
1626:             .FontSize    = 9
1627:             .GridLines   = 1
1628:             .DeleteMark  = .F.
1629:             .RecordMark  = .F.
1630:             .HeaderHeight = 21
1631:             .RowHeight    = 20
1632:         ENDWITH
1633: 
1634:         WITH loc_oGrid.Column1
1635:             .Width = 120
1636:             .ReadOnly = .T.
1637:             .Header1.Caption = "Produto"
1638:         ENDWITH
1639:         WITH loc_oGrid.Column2
1640:             .Width = 80 
1641:             .ReadOnly = .T.
1642:             .Header1.Caption = "Data"
1643:         ENDWITH

*-- Linhas 2359 a 2389:
2359:                 ELSE
2360:                     LOCAL loc_oGrid
2361:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
2362:                     *-- Vincular cursor ao grid (Problem 32: ControlSource apos RecordSource)
2363:                     loc_oGrid.ColumnCount = 10
2364:                     loc_oGrid.RecordSource           = "cursor_4c_Dados"
2365:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
2366:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datainis"
2367:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.datafims"
2368:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contas"
2369:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.localis"
2370:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.localfs"
2371:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.grupos"
2372:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.cggruis"
2373:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.usuars"
2374:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.encerras"
2375:                     *-- Problem 6/32: Headers DEVEM ser redefinidos apos RecordSource
2376:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
2377:                     loc_oGrid.Column2.Header1.Caption  = "Inicial"
2378:                     loc_oGrid.Column3.Header1.Caption  = "Final"
2379:                     loc_oGrid.Column4.Header1.Caption  = "Conta"
2380:                     loc_oGrid.Column5.Header1.Caption  = "Local Ini."
2381:                     loc_oGrid.Column6.Header1.Caption  = "Local Fin."
2382:                     loc_oGrid.Column7.Header1.Caption  = "Grupo"
2383:                     loc_oGrid.Column8.Header1.Caption  = "Gde.Grupo"
2384:                     loc_oGrid.Column9.Header1.Caption  = "Usu" + CHR(225) + "rio"
2385:                     loc_oGrid.Column10.Header1.Caption = "Encerrado"
2386:                     *-- Larguras aproximadas do original
2387:                     loc_oGrid.Column1.Width  = 60
2388:                     loc_oGrid.Column2.Width  = 75
2389:                     loc_oGrid.Column3.Width  = 75

*-- Linhas 2711 a 2786:
2711:         TRY
2712:             IF THIS.this_nCodigoSel <= 0
2713:                 MsgAviso("Nenhum invent" + CHR(225) + "rio selecionado", ;
2714:                     "Formint.CarregarGradeTratamento")
2715:             ELSE
2716:                 IF USED("cursor_4c_Tratamento")
2717:                     USE IN cursor_4c_Tratamento
2718:                 ENDIF
2719: 
2720:                 loc_cSQL = "SELECT a.Produto, a.Datas, a.Barras, a.BarraNovos," + ;
2721:                     " a.Apurado, a.Estoque, a.Faltas, a.Ocorrencia," + ;
2722:                     " a.Tipos, a.PesReals, a.CCustos, a.Obs, a.Obs2s," + ;
2723:                     " a.Usuars, a.CIdChaves, a.Emps, a.Codigos" + ;
2724:                     " FROM SigIvTrB a" + ;
2725:                     " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
2726:                     " AND a.Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
2727:                     " ORDER BY a.Barras"
2728: 
2729:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tratamento")
2730: 
2731:                 IF loc_nResult < 0
2732:                     MostrarErro("Erro ao carregar itens:" + CHR(13) + ;
2733:                         CapturarErroSQL(), "Formint.CarregarGradeTratamento")
2734:                 ELSE
2735:                     loc_oPg3  = THIS.pgf_4c_Paginas.Page3
2736:                     loc_oGrid = loc_oPg3.grd_4c_Dados
2737: 
2738:                     *-- Vincular cursor ao grid
2739:                     loc_oGrid.ColumnCount = 10
2740:                     loc_oGrid.RecordSource = "cursor_4c_Tratamento"
2741:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Tratamento.Produto"
2742:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Tratamento.Datas"
2743:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Tratamento.Barras"
2744:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Tratamento.BarraNovos"
2745:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Tratamento.Apurado"
2746:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Tratamento.Estoque"
2747:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Tratamento.Faltas"
2748:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Tratamento.Ocorrencia"
2749:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Tratamento.Tipos"
2750:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Tratamento.PesReals"
2751: 
2752:                     *-- Ajuste dinamico da coluna Dif.Peso (trtporpeso)
2753:                     LOCAL loc_nTrtPeso
2754:                     loc_nTrtPeso = 0
2755:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2756:                         loc_nTrtPeso = TratarNulo(cursor_4c_Dados.trtporpeso, "N")
2757:                     ENDIF
2758:                     IF loc_nTrtPeso = 1
2759:                         loc_oGrid.Column10.Width = 70
2760:                     ELSE
2761:                         loc_oGrid.Column10.Width = 0
2762:                     ENDIF
2763: 
2764:                     *-- Calcular totais iniciais de ocorrencias
2765:                     loc_nTotCOc = 0
2766:                     loc_nTotSOc = 0
2767:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
2768:                         SELECT cursor_4c_Tratamento
2769:                         GO TOP
2770:                         SCAN
2771:                             IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia))
2772:                                 loc_nTotCOc = loc_nTotCOc + 1
2773:                             ELSE
2774:                                 loc_nTotSOc = loc_nTotSOc + 1
2775:                             ENDIF
2776:                         ENDSCAN
2777:                     ENDIF
2778: 
2779:                     WITH loc_oPg3.cnt_4c__CCusto1.cnt_4c__Total
2780:                         .txt_4c_TotCOc.Value = loc_nTotCOc
2781:                         .txt_4c_TotSOc.Value = loc_nTotSOc
2782:                         .Visible     = .T.
2783:                     ENDWITH
2784: 
2785:                     *-- Exibir grid e painel de controles
2786:                     loc_oPg3.cnt_4c__CCusto1.Visible = .T.

*-- Linhas 2894 a 2912:
2894:     *===========================================================================
2895:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2896:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2897:             SELECT cursor_4c_Dados
2898:             THIS.this_nCodigoSel    = cursor_4c_Dados.codigos
2899:             THIS.this_cCIdChavesSel = ALLTRIM(cursor_4c_Dados.cidchaves)
2900:         ENDIF
2901:     ENDPROC
2902: 
2903:     *===========================================================================
2904:     * FormatarGridLista - Aplica formatacao visual ao grid da lista
2905:     *===========================================================================
2906:     PROCEDURE FormatarGridLista(par_oGrid)
2907:         IF VARTYPE(par_oGrid) = "O"
2908:             par_oGrid.FontName = "Tahoma"
2909:             par_oGrid.FontSize = 9
2910:             par_oGrid.SetAll("DynamicBackColor", ;
2911:                 "IIF(MOD(RECNO('cursor_4c_Dados'),2)=0,RGB(240,245,255),RGB(255,255,255))", ;
2912:                 "Column")

*-- Linhas 2927 a 2949:
2927:                 MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
2928:                     "Sele" + CHR(231) + CHR(227) + "o")
2929:             ELSE
2930:                 loc_cSQL = "SELECT TOP 1 GesInd FROM SigCdPam" + ;
2931:                            " WHERE emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
2932:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
2933:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
2934:                     SELECT cursor_4c_Pam
2935:                     loc_nGesInd = TratarNulo(GesInd, "N")
2936:                 ENDIF
2937:                 IF USED("cursor_4c_Pam")
2938:                     USE IN cursor_4c_Pam
2939:                 ENDIF
2940: 
2941:                 IF loc_nGesInd = 1
2942:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReInr.prg"
2943:                 ELSE
2944:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReIr1.prg"
2945:                 ENDIF
2946: 
2947:                 IF FILE(loc_cFormPath)
2948:                     DO FORM (loc_cFormPath) WITH THIS.this_nCodigoSel
2949:                 ELSE

*-- Linhas 3111 a 3363:
3111:         LOCAL loc_oGrid
3112:         TRY
3113:             IF USED("cursor_4c_Dados")
3114:                 SELECT cursor_4c_Dados
3115:                 INDEX ON codigos TAG _proc
3116:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3117:                 loc_oGrid.SetFocus()
3118:                 loc_oGrid.ActiveColumn = 1
3119:             ENDIF
3120:         CATCH TO loException
3121:             MsgErro("Erro ao ordenar por processo:" + CHR(13) + loException.Message, ;
3122:                 "Formint.CmdProcessoClick")
3123:         ENDTRY
3124:     ENDPROC
3125: 
3126:     *===========================================================================
3127:     * CmdPeriodoClick - Ordena grid por periodo (datainis)
3128:     *===========================================================================
3129:     PROCEDURE CmdPeriodoClick()
3130:         LOCAL loc_oGrid
3131:         TRY
3132:             IF USED("cursor_4c_Dados")
3133:                 SELECT cursor_4c_Dados
3134:                 INDEX ON DTOS(datainis) TAG _perio
3135:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3136:                 loc_oGrid.SetFocus()
3137:                 loc_oGrid.ActiveColumn = 2
3138:             ENDIF
3139:         CATCH TO loException
3140:             MsgErro("Erro ao ordenar por per" + CHR(237) + "odo:" + CHR(13) + loException.Message, ;
3141:                 "Formint.CmdPeriodoClick")
3142:         ENDTRY
3143:     ENDPROC
3144: 
3145:     *===========================================================================
3146:     * CmdEstoqueClick - Ordena grid por estoque (contas)
3147:     *===========================================================================
3148:     PROCEDURE CmdEstoqueClick()
3149:         LOCAL loc_oGrid
3150:         TRY
3151:             IF USED("cursor_4c_Dados")
3152:                 SELECT cursor_4c_Dados
3153:                 INDEX ON ALLTRIM(contas) TAG _esto
3154:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3155:                 loc_oGrid.SetFocus()
3156:                 loc_oGrid.ActiveColumn = 4
3157:             ENDIF
3158:         CATCH TO loException
3159:             MsgErro("Erro ao ordenar por estoque:" + CHR(13) + loException.Message, ;
3160:                 "Formint.CmdEstoqueClick")
3161:         ENDTRY
3162:     ENDPROC
3163: 
3164:     *===========================================================================
3165:     * CmdLocalClick - Ordena grid por local inicial (localis)
3166:     *===========================================================================
3167:     PROCEDURE CmdLocalClick()
3168:         LOCAL loc_oGrid
3169:         TRY
3170:             IF USED("cursor_4c_Dados")
3171:                 SELECT cursor_4c_Dados
3172:                 INDEX ON ALLTRIM(localis) TAG _loca
3173:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3174:                 loc_oGrid.SetFocus()
3175:                 loc_oGrid.ActiveColumn = 5
3176:             ENDIF
3177:         CATCH TO loException
3178:             MsgErro("Erro ao ordenar por local:" + CHR(13) + loException.Message, ;
3179:                 "Formint.CmdLocalClick")
3180:         ENDTRY
3181:     ENDPROC
3182: 
3183:     *===========================================================================
3184:     * CmdGrupoClick - Ordena grid por grupo (grupos)
3185:     *===========================================================================
3186:     PROCEDURE CmdGrupoClick()
3187:         LOCAL loc_oGrid
3188:         TRY
3189:             IF USED("cursor_4c_Dados")
3190:                 SELECT cursor_4c_Dados
3191:                 INDEX ON ALLTRIM(grupos) TAG _gru
3192:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3193:                 loc_oGrid.SetFocus()
3194:                 loc_oGrid.ActiveColumn = 7
3195:             ENDIF
3196:         CATCH TO loException
3197:             MsgErro("Erro ao ordenar por grupo:" + CHR(13) + loException.Message, ;
3198:                 "Formint.CmdGrupoClick")
3199:         ENDTRY
3200:     ENDPROC
3201: 
3202:     *===========================================================================
3203:     * CmdGGrupoClick - Ordena grid por grande grupo (cggruis)
3204:     *===========================================================================
3205:     PROCEDURE CmdGGrupoClick()
3206:         LOCAL loc_oGrid
3207:         TRY
3208:             IF USED("cursor_4c_Dados")
3209:                 SELECT cursor_4c_Dados
3210:                 INDEX ON ALLTRIM(cggruis) TAG _ggru
3211:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3212:                 loc_oGrid.SetFocus()
3213:                 loc_oGrid.ActiveColumn = 8
3214:             ENDIF
3215:         CATCH TO loException
3216:             MsgErro("Erro ao ordenar por grande grupo:" + CHR(13) + loException.Message, ;
3217:                 "Formint.CmdGGrupoClick")
3218:         ENDTRY
3219:     ENDPROC
3220: 
3221:     *===========================================================================
3222:     * CmdUsuarioClick - Ordena grid por usuario (usuars)
3223:     *===========================================================================
3224:     PROCEDURE CmdUsuarioClick()
3225:         LOCAL loc_oGrid
3226:         TRY
3227:             IF USED("cursor_4c_Dados")
3228:                 SELECT cursor_4c_Dados
3229:                 INDEX ON ALLTRIM(usuars) TAG _usu
3230:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3231:                 loc_oGrid.SetFocus()
3232:                 loc_oGrid.ActiveColumn = 9
3233:             ENDIF
3234:         CATCH TO loException
3235:             MsgErro("Erro ao ordenar por usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;
3236:                 "Formint.CmdUsuarioClick")
3237:         ENDTRY
3238:     ENDPROC
3239: 
3240:     *===========================================================================
3241:     * Destroy - Libera recursos ao fechar
3242:     *===========================================================================
3243:     PROCEDURE Destroy()
3244:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3245:             THIS.this_oBusinessObject = .NULL.
3246:         ENDIF
3247: 
3248:         IF USED("cursor_4c_Dados")
3249:             USE IN cursor_4c_Dados
3250:         ENDIF
3251:         IF USED("cursor_4c_Tratamento")
3252:             USE IN cursor_4c_Tratamento
3253:         ENDIF
3254:         IF USED("cursor_4c_Ocorr")
3255:             USE IN cursor_4c_Ocorr
3256:         ENDIF
3257:         IF USED("CrSigCdBal")
3258:             USE IN CrSigCdBal
3259:         ENDIF
3260:         IF USED("CsTratamento")
3261:             USE IN CsTratamento
3262:         ENDIF
3263: 
3264:         DODEFAULT()
3265:     ENDPROC
3266: 
3267:     *===========================================================================
3268:     * GrdBalancoAfterRowColChange - Exibe painel de controles com dados do item
3269:     *===========================================================================
3270:     PROCEDURE GrdBalancoAfterRowColChange(par_nColIndex)
3271:         LOCAL loc_oCnt
3272: 
3273:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3274:             SELECT cursor_4c_Tratamento
3275: 
3276:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3277:             WITH loc_oCnt
3278:                 .Visible             = .T.
3279:                 .txt_4c_DPro.Value   = TratarNulo(cursor_4c_Tratamento.Produto,  "C")
3280:                 .txt_4c_CCusto.Value = TratarNulo(cursor_4c_Tratamento.CCustos,  "C")
3281:                 .txt_4c_Dif.Value    = TratarNulo(cursor_4c_Tratamento.Faltas,   "N")
3282:                 .txt_4c_Usuars.Value = TratarNulo(cursor_4c_Tratamento.Usuars,   "C")
3283:                 .txt_4c_PesReal.Value = TratarNulo(cursor_4c_Tratamento.PesReals, "N")
3284:                 .edt_4c_ObsCnt1.Value = TratarNulo(cursor_4c_Tratamento.Obs, "C")
3285:                 .Refresh()
3286:             ENDWITH
3287: 
3288:             WITH THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3289:                 .Column8.ReadOnly       = .F.
3290:                 .Column8.Text1.ReadOnly = .F.
3291:                 .Refresh()
3292:             ENDWITH
3293:         ENDIF
3294:     ENDPROC
3295: 
3296:     *===========================================================================
3297:     * GrdColOcorWhen - Salva valor atual antes da edicao (Column8)
3298:     *===========================================================================
3299:     PROCEDURE GrdColOcorWhen()
3300:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3301:             THIS.this_cOldValue = ALLTRIM(TratarNulo(cursor_4c_Tratamento.Ocorrencia, "C"))
3302:         ENDIF
3303:     ENDPROC
3304: 
3305:     *===========================================================================
3306:     * GrdColOcorValid - Valida e abre lookup de Ocorrencia (Column8)
3307:     *===========================================================================
3308:     PROCEDURE GrdColOcorValid()
3309:         LOCAL loc_lResultado, loc_oGrid, loc_cOcor
3310:         loc_lResultado = .T.
3311: 
3312:         TRY
3313:             loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3314:             loc_cOcor = ALLTRIM(loc_oGrid.Column8.Text1.Value)
3315: 
3316:             WITH THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3317:                 .cmd_4c_BarraNovo.Visible = .F.
3318:             ENDWITH
3319: 
3320:             IF !EMPTY(loc_cOcor) AND loc_cOcor != THIS.this_cOldValue
3321:                 loc_lResultado = THIS.AbrirLookupOcorrencia("O", "<>", loc_cOcor, ;
3322:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1)
3323:             ENDIF
3324: 
3325:             *-- Atualizar usuario no painel
3326:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3327:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.txt_4c_Usuars.Value = ;
3328:                     ALLTRIM(gc_4c_UsuarioLogado)
3329:             ENDIF
3330:         CATCH TO loException
3331:             MsgErro("Erro em GrdColOcorValid:" + CHR(13) + ;
3332:                 loException.Message + CHR(13) + ;
3333:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3334:                 "Formint.GrdColOcorValid")
3335:             loc_lResultado = .F.
3336:         ENDTRY
3337: 
3338:         RETURN loc_lResultado
3339:     ENDPROC
3340: 
3341:     *===========================================================================
3342:     * GrdColOcorLostFocus - Atualiza contadores apos saida do campo (Column8)
3343:     *===========================================================================
3344:     PROCEDURE GrdColOcorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3345:         LOCAL loc_cNovo, loc_oTotal, loc_nCOc, loc_nSOc
3346: 
3347:         TRY
3348:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3349:                 loc_cNovo  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.Value)
3350:                 loc_oTotal = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cnt_4c__Total
3351:                 loc_nCOc   = loc_oTotal.txt_4c_TotCOc.Value
3352:                 loc_nSOc   = loc_oTotal.txt_4c_TotSOc.Value
3353: 
3354:                 IF !EMPTY(THIS.this_cOldValue) AND EMPTY(loc_cNovo)
3355:                     loc_nCOc = loc_nCOc - 1
3356:                     loc_nSOc = loc_nSOc + 1
3357:                 ELSE
3358:                     IF EMPTY(THIS.this_cOldValue) AND !EMPTY(loc_cNovo)
3359:                         loc_nCOc = loc_nCOc + 1
3360:                         loc_nSOc = loc_nSOc - 1
3361:                     ENDIF
3362:                 ENDIF
3363: 

*-- Linhas 3494 a 3557:
3494:         TRY
3495:             loc_cCaption = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption)
3496: 
3497:             IF loc_cCaption = "\<Grava" OR loc_cCaption = "Grava"
3498:                 *-- Validar: todo lancamento com Ocorrencia deve ter Obs
3499:                 IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3500:                     SELECT cursor_4c_Tratamento
3501:                     GO TOP
3502:                     SCAN
3503:                         IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) AND ;
3504:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs)) AND ;
3505:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs2s))
3506:                             MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
3507:                                 "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
3508:                                 "Valida" + CHR(231) + CHR(227) + "o")
3509:                             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3510:                             loc_lValido = .F.
3511:                             EXIT
3512:                         ENDIF
3513:                     ENDSCAN
3514: 
3515:                     IF loc_lValido
3516:                         *-- Gravar cada linha na tabela SigIvTrB
3517:                         SELECT cursor_4c_Tratamento
3518:                         GO TOP
3519:                         SCAN
3520:                             loc_cSQL = "UPDATE SigIvTrB SET" + ;
3521:                                 " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
3522:                                 ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
3523:                                 ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
3524:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3525:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3526:                                 " AND CIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.CIdChaves))
3527:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3528:                             IF loc_nResult < 0
3529:                                 MostrarErro("Erro ao gravar item:" + CHR(13) + ;
3530:                                     CapturarErroSQL(), "Formint.BtnSairCntClick")
3531:                                 loc_lValido = .F.
3532:                                 EXIT
3533:                             ENDIF
3534:                         ENDSCAN
3535:                     ENDIF
3536: 
3537:                     IF loc_lValido
3538:                     *-- Marcar inventario como tratado
3539:                     loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3540:                         " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3541:                         " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3542:                     SQLEXEC(gnConnHandle, loc_cSQL)
3543: 
3544:                     MsgInfo("Tratamento gravado com sucesso!", "Tratamento")
3545:                     loc_lResultado = .T.
3546:                     ENDIF
3547:                 ENDIF
3548:             ELSE
3549:                 loc_lResultado = .T.
3550:             ENDIF
3551: 
3552:             IF loc_lResultado
3553:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .F.
3554:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible     = .F.
3555:                 THIS.pgf_4c_Paginas.ActivePage = 1
3556:                 THIS.this_cModoAtual = "LISTA"
3557:                 THIS.CarregarLista()

*-- Linhas 3603 a 3626:
3603:         LOCAL loc_oCnt2, loc_cObs2s
3604:         TRY
3605:             loc_oCnt2 = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
3606:             loc_cObs2s = ALLTRIM(loc_oCnt2.edt_4c_BNObs.Value)
3607: 
3608:             IF !EMPTY(loc_cObs2s) AND USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3609:                 SELECT cursor_4c_Tratamento
3610:                 REPLACE cursor_4c_Tratamento.Obs2s WITH loc_cObs2s
3611:                 REPLACE cursor_4c_Tratamento.BarraNovos WITH ALLTRIM(loc_oCnt2.txt_4c_GetBarNovo.Value)
3612:             ENDIF
3613: 
3614:             loc_oCnt2.Visible = .F.
3615:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3616:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3617:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3618:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3619:         CATCH TO loException
3620:             MsgErro("Erro em BtnBNSairClick:" + CHR(13) + loException.Message, ;
3621:                 "Formint.BtnBNSairClick")
3622:         ENDTRY
3623:     ENDPROC
3624: 
3625:     *===========================================================================
3626:     * GetTOcorCntTratValid - Lookup de Ocorrencia no painel TratOcor (Tipos='O')

*-- Linhas 3660 a 3710:
3660: 
3661:             IF EMPTY(loc_cOcor)
3662:                 MsgAviso("Informe a Ocorr" + CHR(234) + "ncia para o Tratamento.", ;
3663:                     "Campo Obrigat" + CHR(243) + "rio")
3664:             ELSE
3665:                 IF !USED("cursor_4c_Tratamento") OR RECCOUNT("cursor_4c_Tratamento") = 0
3666:                     MsgAviso("Nenhum item para tratar.", "Tratamento")
3667:                 ELSE
3668:                     SELECT cursor_4c_Tratamento
3669:                     GO TOP
3670:                     SCAN
3671:                         LOCAL loc_lAplicar
3672:                         loc_lAplicar = .F.
3673: 
3674:                         DO CASE
3675:                         CASE loc_nSemOcor = 1   && Lidos
3676:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "L")
3677:                         CASE loc_nSemOcor = 2   && Nao lidos
3678:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "N")
3679:                         CASE loc_nSemOcor = 3   && Saldos
3680:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "S")
3681:                         OTHERWISE
3682:                             loc_lAplicar = .T.
3683:                         ENDCASE
3684: 
3685:                         IF loc_cTipos = "Entrada"
3686:                             loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas < 0)
3687:                         ELSE
3688:                             IF loc_cTipos = "Sa" + CHR(237) + "da"
3689:                                 loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas > 0)
3690:                             ENDIF
3691:                         ENDIF
3692: 
3693:                         IF loc_lAplicar
3694:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3695:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3696:                         ENDIF
3697:                     ENDSCAN
3698: 
3699:                     loc_oCnt.Visible = .F.
3700:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3701:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3702:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3703:                     loc_lResultado = .T.
3704:                 ENDIF
3705:             ENDIF
3706:         CATCH TO loException
3707:             MsgErro("Erro em BtnTratOcorClick:" + CHR(13) + ;
3708:                 loException.Message + CHR(13) + ;
3709:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3710:                 "Formint.BtnTratOcorClick")

*-- Linhas 3771 a 3819:
3771: 
3772:                 IF loc_lConfirmar
3773:                     *-- Verificar operacao da ocorrencia na SigBaOco
3774:                     loc_cSQL = "SELECT TOP 1 Operacaos FROM SigBaOco" + ;
3775:                         " WHERE Tipos = 'O' AND Autos = 'S'" + ;
3776:                         " AND Codigos = " + EscaparSQL(loc_cOcor)
3777:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3778: 
3779:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3780:                         SELECT cursor_4c_Tratamento
3781:                         GO TOP
3782:                         SCAN
3783:                             LOCAL loc_cCidChave, loc_cBarras
3784:                             loc_cCidChave = ALLTRIM(cursor_4c_Tratamento.CIdChaves)
3785:                             loc_cBarras   = ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras))
3786: 
3787:                             *-- Aplicar ocorrencia no cursor local
3788:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3789:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3790: 
3791:                             *-- Gravar na tabela SigIvTrB
3792:                             loc_cSQL = "UPDATE SigIvTrB SET" + ;
3793:                                 " Ocorrencia = " + EscaparSQL(loc_cOcor) + ;
3794:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3795:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3796:                                 " AND CIdChaves = " + EscaparSQL(loc_cCidChave)
3797:                             SQLEXEC(gnConnHandle, loc_cSQL)
3798:                         ENDSCAN
3799: 
3800:                         *-- Marcar inventario como tratado
3801:                         loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3802:                             " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3803:                             " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3804:                         SQLEXEC(gnConnHandle, loc_cSQL)
3805: 
3806:                         IF USED("cursor_4c_Ocorr")
3807:                             USE IN cursor_4c_Ocorr
3808:                         ENDIF
3809: 
3810:                         MsgInfo("Baixa Autom" + CHR(225) + "tica aplicada com sucesso!", ;
3811:                             "Baixa Autom" + CHR(225) + "tica")
3812: 
3813:                         loc_oCnt.Visible = .F.
3814:                         THIS.pgf_4c_Paginas.ActivePage = 1
3815:                         THIS.this_cModoAtual = "LISTA"
3816:                         THIS.CarregarLista()
3817:                         loc_lResultado = .T.
3818:                     ENDIF
3819:                 ENDIF

*-- Linhas 3857 a 3880:
3857:                     USE IN cursor_4c_Ocorr
3858:                 ENDIF
3859: 
3860:                 loc_cSQL = "SELECT TOP 1 CBars, CPros, Pesos FROM SigOpEtq" + ;
3861:                     " WHERE CBars = " + EscaparSQL(loc_cBarra)
3862:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3863: 
3864:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Ocorr") > 0
3865:                     SELECT cursor_4c_Ocorr
3866:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra.Value = ;
3867:                         ALLTRIM(cursor_4c_Ocorr.CBars)
3868:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.cmd_4c_CntInsere.Enabled = .T.
3869:                 ELSE
3870:                     MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + "o encontrado!", ;
3871:                         "Barra Inv" + CHR(225) + "lida")
3872:                     loc_lResultado = .F.
3873:                 ENDIF
3874: 
3875:                 IF USED("cursor_4c_Ocorr")
3876:                     USE IN cursor_4c_Ocorr
3877:                 ENDIF
3878:             ENDIF
3879:         CATCH TO loException
3880:             MsgErro("Erro em GetIBarraValid:" + CHR(13) + loException.Message, ;

*-- Linhas 3923 a 3954:
3923: 
3924:             IF EMPTY(loc_cBarra)
3925:                 MsgAviso("Informe o C" + CHR(243) + "digo de Barra.", "Campo Obrigat" + CHR(243) + "rio")
3926:             ELSE
3927:                 *-- Inserir no cursor local (ReadWrite permite APPEND BLANK)
3928:                 IF USED("cursor_4c_Tratamento")
3929:                     SELECT cursor_4c_Tratamento
3930:                     APPEND BLANK
3931:                     REPLACE cursor_4c_Tratamento.Emps       WITH ALLTRIM(go_4c_Sistema.cCodEmpresa)
3932:                     REPLACE cursor_4c_Tratamento.Codigos    WITH THIS.this_nCodigoSel
3933:                     REPLACE cursor_4c_Tratamento.Barras     WITH VAL(loc_cBarra)
3934:                     REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3935:                     REPLACE cursor_4c_Tratamento.Obs        WITH loc_cObs
3936:                     REPLACE cursor_4c_Tratamento.Tipos      WITH "L"
3937:                     REPLACE cursor_4c_Tratamento.Apurado    WITH 1
3938:                     REPLACE cursor_4c_Tratamento.Estoque    WITH 0
3939:                     REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3940: 
3941:                     THIS.this_nCItens = THIS.this_nCItens + 1
3942: 
3943:                     *-- Limpar campos para proximo item
3944:                     loc_oCnt.txt_4c_IBarra.Value = ""
3945:                     loc_oCnt.txt_4c_IOcor.Value  = ""
3946:                     loc_oCnt.edt_4c_IBObs.Value  = ""
3947:                     loc_oCnt.cmd_4c_CntInsere.Enabled = .F.
3948:                     loc_oCnt.txt_4c_IBarra.SetFocus()
3949: 
3950:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3951:                     loc_lResultado = .T.
3952:                 ENDIF
3953:             ENDIF
3954:         CATCH TO loException

*-- Linhas 3979 a 4002:
3979: 
3980:         TRY
3981:             loc_oPr    = THIS.pgf_4c_Paginas.Page3.cnt_4c__Procurar
3982:             loc_cBarra = ALLTRIM(loc_oPr.txt_4c_GetBusca.Value)
3983: 
3984:             IF !EMPTY(loc_cBarra) AND USED("cursor_4c_Tratamento")
3985:                 SELECT cursor_4c_Tratamento
3986:                 GO TOP
3987:                 LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras)) = loc_cBarra
3988:                 IF FOUND()
3989:                     *-- Mostrar grid e painel, ocultar procurar
3990:                     loc_oPr.Visible = .F.
3991:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .T.
3992:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible    = .T.
3993:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3994:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
3995:                 ELSE
3996:                     MsgAviso("Barra '" + loc_cBarra + "' n" + CHR(227) + "o encontrada.", ;
3997:                         "Busca")
3998:                 ENDIF
3999:             ENDIF
4000:         CATCH TO loException
4001:             MsgErro("Erro em GetBuscaValid:" + CHR(13) + loException.Message, ;
4002:                 "Formint.GetBuscaValid")


### BO (C:\4c\projeto\app\classes\intBO.prg):
*==============================================================================
* intBO.prg - Business Object para Tratamento de Invent?rio (SIGCDBAL)
* Herda de: BusinessBase
* Tabela principal: SIGCDBAL
* PK: cidchaves (char 20)
*==============================================================================
DEFINE CLASS intBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SIGCDBAL
    *--------------------------------------------------------------------------
    this_cCIdChaves  = ""    && cidchaves char(20) - chave prim?ria
    this_nCodigos    = 0     && codigos numeric(4,0) - c?digo do invent?rio
    this_cEmps       = ""    && emps char(3) - empresa
    this_dDataInis   = {}    && datainis datetime - data inicial do invent?rio
    this_dDataFims   = {}    && datafims datetime - data final do invent?rio
    this_dDataTrans  = {}    && datatrans datetime - data da transa??o
    this_dDtBases    = {}    && dtbases datetime - data base
    this_cGrupos     = ""    && grupos char(10) - grupo principal
    this_cLocalis    = ""    && localis char(10) - local inicial
    this_cLocalfs    = ""    && localfs char(10) - local final
    this_cLocals     = ""    && locals char(10) - local
    this_cIforis     = ""    && iforis char(10) - fornecedor inicial
    this_cIforfs     = ""    && iforfs char(10) - fornecedor final
    this_cCgruis     = ""    && cgruis char(3) - c?digo grupo inicial
    this_cCgrufs     = ""    && cgrufs char(3) - c?digo grupo final
    this_cCggruis    = ""    && cggruis char(3) - c?digo grande grupo inicial
    this_cCggrufs    = ""    && cggrufs char(3) - c?digo grande grupo final
    this_nPrecois    = 0     && precois numeric(8,2) - pre?o inicial
    this_nPrecofs    = 0     && precofs numeric(8,2) - pre?o final
    this_cContas     = ""    && contas char(10) - conta
    this_cUsuars     = ""    && usuars char(10) - usu?rio
    this_cColecoesi  = ""    && colecoesi char(10) - cole??o inicial
    this_cColecoesf  = ""    && colecoesf char(10) - cole??o final
    this_cCprosi     = ""    && cprosi char(14) - produto inicial (barra)
    this_cCprosf     = ""    && cprosf char(14) - produto final (barra)
    this_cSgrusi     = ""    && sgrusi char(6) - sub-grupo inicial
    this_cSgrusf     = ""    && sgrusf char(6) - sub-grupo final
    this_cCfinpsi    = ""    && cfinpsi char(3) - fin press inicial
    this_cCfinpsf    = ""    && cfinpsf char(3) - fin press final
    this_nNTrans     = 0     && ntrans numeric(6,0) - n?mero da transa??o
    this_nAgrupas    = 0     && agrupas numeric(1,0) - agrupar
    this_nSepEstqs   = 0     && sepestqs numeric(1,0) - separar estoques
    this_nTrtPorPeso = 0     && trtporpeso numeric(1,0) - tratamento por peso
    this_nLeitGructa = 0     && leitgructa numeric(1,0) - leitura por grupo conta
    this_nFilBarras  = 0     && filbarras numeric(1,0) - filtrar por barras
    this_cMFilGGrp   = ""    && mfilggrp memo - filtro grande grupos
    this_cMFilGrupo  = ""    && mfilgrupo memo - filtro grupos
    this_cObs        = ""    && obs memo - observa??o

    *-- Campos calculados / controle
    this_lEncerras   = .F.   && encerras bit - invent?rio encerrado
    this_lTratas     = .F.   && tratas bit - invent?rio tratado

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDBAL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista inventarios da empresa atual
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " ORDER BY codigos, cidchaves"
            ELSE
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
                           " ORDER BY codigos, cidchaves"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega inventario pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorNumero - Carrega inventario pelo codigos + empresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
                       " AND emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCIdChaves   = TratarNulo(cidchaves,    "C")
            THIS.this_nCodigos     = TratarNulo(codigos,      "N")
            THIS.this_cEmps        = TratarNulo(emps,         "C")
            THIS.this_cGrupos      = TratarNulo(grupos,       "C")
            THIS.this_cContas      = TratarNulo(contas,       "C")
            THIS.this_dDtBases     = TratarNulo(dtbases,      "D")
            THIS.this_dDataInis    = TratarNulo(datainis,     "D")
            THIS.this_dDataFims    = TratarNulo(datafims,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,    "D")
            THIS.this_lEncerras    = (TratarNulo(encerras,    "N") = 1)
            THIS.this_lTratas      = (TratarNulo(tratas,      "N") = 1)
            THIS.this_nAgrupas     = TratarNulo(agrupas,      "N")
            THIS.this_nSepEstqs    = TratarNulo(sepestqs,     "N")
            THIS.this_nTrtPorPeso  = TratarNulo(trtporpeso,   "N")
            THIS.this_nLeitGructa  = TratarNulo(leitgructa,   "N")
            THIS.this_nFilBarras   = TratarNulo(filbarras,    "N")
            THIS.this_cLocalis     = TratarNulo(localis,      "C")
            THIS.this_cLocalfs     = TratarNulo(localfs,      "C")
            THIS.this_cLocals      = TratarNulo(locals,       "C")
            THIS.this_cIforis      = TratarNulo(iforis,       "C")
            THIS.this_cIforfs      = TratarNulo(iforfs,       "C")
            THIS.this_cCgruis      = TratarNulo(cgruis,       "C")
            THIS.this_cCgrufs      = TratarNulo(cgrufs,       "C")
            THIS.this_cCggruis     = TratarNulo(cggruis,      "C")
            THIS.this_cCggrufs     = TratarNulo(cggrufs,      "C")
            THIS.this_cColecoesi   = TratarNulo(colecoesi,    "C")
            THIS.this_cColecoesf   = TratarNulo(colecoesf,    "C")
            THIS.this_cCprosi      = TratarNulo(cprosi,       "C")
            THIS.this_cCprosf      = TratarNulo(cprosf,       "C")
            THIS.this_cSgrusi      = TratarNulo(sgrusi,       "C")
            THIS.this_cSgrusf      = TratarNulo(sgrusf,       "C")
            THIS.this_cCfinpsi     = TratarNulo(cfinpsi,      "C")
            THIS.this_cCfinpsf     = TratarNulo(cfinpsf,      "C")
            THIS.this_nPrecois     = TratarNulo(precois,      "N")
            THIS.this_nPrecofs     = TratarNulo(precofs,      "N")
            THIS.this_nNTrans      = TratarNulo(ntrans,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,       "C")
            *-- Campos TEXT/memo (podem nao estar no cursor de listagem)
            IF !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
                THIS.this_cMFilGGrp  = TratarNulo(mfilggrp,  "C")
                THIS.this_cMFilGrupo = TratarNulo(mfilgrupo, "C")
                THIS.this_cObs       = TratarNulo(obs,       "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
                       " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nCodigo = cursor_4c_ProxCod.prox_cod
            ENDIF

            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        ENDTRY

        RETURN loc_nCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            *-- Gerar chave UUID e proximo codigo sequencial
            THIS.this_cCIdChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCIdChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCIdChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
                IF loc_nCodigo = 0
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
                    loc_lSucesso = .F.
                ELSE
                    THIS.this_nCodigos = loc_nCodigo
                    THIS.this_cEmps    = loc_cEmp
                    THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

                    loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
                               " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
                               " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
                               " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                               " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                               " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                               " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                               ") VALUES (" + ;
                               EscaparSQL(THIS.this_cCIdChaves) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                               EscaparSQL(THIS.this_cEmps) + "," + ;
                               EscaparSQL(THIS.this_cGrupos) + "," + ;
                               EscaparSQL(THIS.this_cContas) + "," + ;
                               FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                               FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                               FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                               IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                               IIF(THIS.this_lTratas, "1", "0") + "," + ;
                               FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                               FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                               FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                               EscaparSQL(THIS.this_cLocalis) + "," + ;
                               EscaparSQL(THIS.this_cLocalfs) + "," + ;
                               EscaparSQL(THIS.this_cIforis) + "," + ;
                               EscaparSQL(THIS.this_cIforfs) + "," + ;
                               EscaparSQL(THIS.this_cCgruis) + "," + ;
                               EscaparSQL(THIS.this_cCgrufs) + "," + ;
                               EscaparSQL(THIS.this_cCggruis) + "," + ;
                               EscaparSQL(THIS.this_cCggrufs) + "," + ;
                               EscaparSQL(THIS.this_cColecoesi) + "," + ;
                               EscaparSQL(THIS.this_cColecoesf) + "," + ;
                               EscaparSQL(THIS.this_cCprosi) + "," + ;
                               EscaparSQL(THIS.this_cCprosf) + "," + ;
                               EscaparSQL(THIS.this_cSgrusi) + "," + ;
                               EscaparSQL(THIS.this_cSgrusf) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nNTrans) + "," + ;
                               EscaparSQL(THIS.this_cLocals) + "," + ;
                               EscaparSQL(THIS.this_cUsuars) + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " dtbases = " + FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                       " datainis = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                       " datafims = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                       " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                       " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
                       " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                       " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                       " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                       " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                       " filbarras = " + FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                       " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
                       " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
                       " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
                       " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
                       " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
                       " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
                       " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
                       " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
                       " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
                       " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
                       " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
                       " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
                       " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
                       " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                       " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                       " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                       " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                       " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do inventario e registros filhos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
        loc_lSucesso = .F.
        loc_nCodigos = THIS.this_nCodigos
        loc_cEmps    = ALLTRIM(THIS.this_cEmps)

        TRY
            *-- Remover registros filhos: SigIvTrB (itens do balanco)
            loc_cSQL = "DELETE FROM SigIvTrB" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrH (historico de leitura)
            loc_cSQL = "DELETE FROM SigIvTrH" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrE (etiquetas)
            loc_cSQL = "DELETE FROM SigIvTrE" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover o inventario principal
            loc_cSQL = "DELETE FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEncerramento - Marca/desmarca inventario como encerrado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
                       " datafims = " + FormatarDataSQL(par_dDatafim) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lEncerras = par_lEncerrar
                THIS.this_dDataFims = par_dDatafim
                THIS.RegistrarAuditoria("ENCERRAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTratamento - Marca inventario como tratado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTratamento(par_lTratar)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " tratas = " + IIF(par_lTratar, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lTratas = par_lTratar
                THIS.RegistrarAuditoria("TRATAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao marcar tratamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao marcar tratamento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Obtem cotacao de cambio para uma moeda
    * Substitui fCarregarCambio() do legado (nao portada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCambio(par_nValor, par_cMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_nCotacao, loc_nValorConv
        loc_nCotacao  = 1
        loc_nValorConv = par_nValor

        TRY
            IF !EMPTY(ALLTRIM(par_cMoeda)) AND ALLTRIM(par_cMoeda) <> "RS" AND ALLTRIM(par_cMoeda) <> "BRL"
                loc_cSQL = "SELECT TOP 1 a.Cotacaos" + ;
                           " FROM SigCdCot a" + ;
                           " INNER JOIN SigCdMoe b ON b.SMoedas = a.SMoedas" + ;
                           " WHERE b.SMoedas = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                           " ORDER BY a.Datas DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cambio")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cambio") > 0
                    SELECT cursor_4c_Cambio
                    loc_nCotacao = TratarNulo(Cotacaos, "N")
                    IF loc_nCotacao > 0
                        loc_nValorConv = par_nValor * loc_nCotacao
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Cambio")
                    USE IN cursor_4c_Cambio
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar c" + CHR(226) + "mbio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Cambio")
                USE IN cursor_4c_Cambio
            ENDIF
        ENDTRY

        RETURN loc_nValorConv
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Verifica se grupo de estoque eh valido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lValido
        loc_lValido = .F.

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupos))
                loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
                    loc_lValido = .T.
                ENDIF

                IF USED("cursor_4c_ValGru")
                    USE IN cursor_4c_ValGru
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValGru")
                USE IN cursor_4c_ValGru
            ENDIF
        ENDTRY

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

