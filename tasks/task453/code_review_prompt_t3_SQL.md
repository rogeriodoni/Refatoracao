# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODIGOS, CPROS, CBARS, LNDIF, ETIQS, TIPOS, OCORRENCIA, AUTOS, CODBARRAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODIGOS, CPROS, CBARS, LNDIF, ETIQS, TIPOS, OCORRENCIA, AUTOS, CODBARRAS

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formint.prg) - TRECHOS RELEVANTES PARA PASS SQL (4277 linhas total):

*-- Linhas 521 a 552:
521:         * Width=905 (12+905=917=cnt_4c_Saida.Left - sem sobreposicao)
522:         * HeaderHeight=0: botoes acima servem como cabecalhos visuais
523:         * ColumnCount FORA do WITH (Problem 36)
524:         * ControlSource/DynamicBackColor: vinculados em CarregarLista() (Problem 32)
525:         * Colunas: codigos/datainis/datafims/contas/localis/localfs/grupos/cggruis/usuars/encerras
526:         * Larguras: 62+78+75+143+81+82+69+69+78+168 = 905
527:         *----------------------------------------------------------------------
528:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
529:         loc_oPagina.grd_4c_Dados.ColumnCount = 10
530:         WITH loc_oPagina.grd_4c_Dados
531:             .Top           = 174
532:             .Left          = 12
533:             .Width         = 905
534:             .Height        = 446
535:             .RecordSource  = ""
536:             .ReadOnly      = .T.
537:             .DeleteMark    = .F.
538:             .RecordMark    = .F.
539:             .GridLines     = 1
540:             .GridLineWidth = 1
541:             .GridLineColor = RGB(200, 200, 200)
542:             .HeaderHeight  = 0
543:             .RowHeight     = 20
544:             .FontName      = "Tahoma"
545:             .FontSize      = 9
546:             .ScrollBars    = 2
547:             .Visible       = .T.
548:             WITH .Column1
549:                 .Width     = 62
550:                 .Resizable = .F.
551:                 .Alignment = 0
552:             ENDWITH

*-- Linhas 1631 a 1649:
1631:             .FontName    = "Tahoma"
1632:             .FontSize    = 9
1633:             .GridLines   = 1
1634:             .DeleteMark  = .F.
1635:             .RecordMark  = .F.
1636:             .HeaderHeight = 21
1637:             .RowHeight    = 20
1638:         ENDWITH
1639: 
1640:         WITH loc_oGrid.Column1
1641:             .Width = 120
1642:             .ReadOnly = .T.
1643:             .Header1.Caption = "Produto"
1644:         ENDWITH
1645:         WITH loc_oGrid.Column2
1646:             .Width = 80 
1647:             .ReadOnly = .T.
1648:             .Header1.Caption = "Data"
1649:         ENDWITH

*-- Linhas 2365 a 2395:
2365:                 ELSE
2366:                     LOCAL loc_oGrid
2367:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
2368:                     *-- Vincular cursor ao grid (Problem 32: ControlSource apos RecordSource)
2369:                     loc_oGrid.ColumnCount = 10
2370:                     loc_oGrid.RecordSource           = "cursor_4c_Dados"
2371:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
2372:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datainis"
2373:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.datafims"
2374:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contas"
2375:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.localis"
2376:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.localfs"
2377:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.grupos"
2378:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.cggruis"
2379:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.usuars"
2380:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.encerras"
2381:                     *-- Problem 6/32: Headers DEVEM ser redefinidos apos RecordSource
2382:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
2383:                     loc_oGrid.Column2.Header1.Caption  = "Inicial"
2384:                     loc_oGrid.Column3.Header1.Caption  = "Final"
2385:                     loc_oGrid.Column4.Header1.Caption  = "Conta"
2386:                     loc_oGrid.Column5.Header1.Caption  = "Local Ini."
2387:                     loc_oGrid.Column6.Header1.Caption  = "Local Fin."
2388:                     loc_oGrid.Column7.Header1.Caption  = "Grupo"
2389:                     loc_oGrid.Column8.Header1.Caption  = "Gde.Grupo"
2390:                     loc_oGrid.Column9.Header1.Caption  = "Usu" + CHR(225) + "rio"
2391:                     loc_oGrid.Column10.Header1.Caption = "Encerrado"
2392:                     *-- Larguras aproximadas do original
2393:                     loc_oGrid.Column1.Width  = 60
2394:                     loc_oGrid.Column2.Width  = 75
2395:                     loc_oGrid.Column3.Width  = 75

*-- Linhas 2719 a 2787:
2719:                 MsgAviso("Nenhum invent" + CHR(225) + "rio selecionado", ;
2720:                     "Formint.CarregarGradeTratamento")
2721:             ELSE
2722:                 loc_cSQL = "SELECT a.Produto, a.Datatrans AS Datas, a.Barras, a.Barra2s AS BarraNovos," + ;
2723:                     " a.Apurado, a.Estoque, a.Falta AS Faltas, a.Ocorrencia," + ;
2724:                     " a.Tipos, a.PesReals, a.CCustos, a.Obs, a.Obs2s," + ;
2725:                     " a.Usuars, a.CIdChaves, a.Emps, a.Codigos" + ;
2726:                     " FROM SigIvTrT a" + ;
2727:                     " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
2728:                     " AND a.Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
2729:                     " ORDER BY a.Barras"
2730: 
2731:                 *-- Fechar cursor temporario de chamada anterior, se existir
2732:                 IF USED("cursor_4c_TratamentoTemp")
2733:                     USE IN cursor_4c_TratamentoTemp
2734:                 ENDIF
2735: 
2736:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TratamentoTemp")
2737: 
2738:                 IF loc_nResult < 0
2739:                     MostrarErro("Erro ao carregar itens:" + CHR(13) + ;
2740:                         CapturarErroSQL(), "Formint.CarregarGradeTratamento")
2741:                 ELSE
2742:                     loc_oPg3  = THIS.pgf_4c_Paginas.Page3
2743:                     loc_oGrid = loc_oPg3.grd_4c_Dados
2744: 
2745:                     IF USED("cursor_4c_Tratamento")
2746:                         *-- Grid ja vinculado: repopular sem fechar o RecordSource cursor
2747:                         SELECT cursor_4c_Tratamento
2748:                         ZAP
2749:                         APPEND FROM DBF(DBF("cursor_4c_TratamentoTemp"))
2750:                         USE IN cursor_4c_TratamentoTemp
2751:                         SELECT cursor_4c_Tratamento
2752:                         GO TOP
2753:                         loc_oGrid.Refresh()
2754:                     ELSE
2755:                         *-- Primeira carga: copiar via SELECT para evitar SQLEXEC direto ao cursor do Grid
2756:                         SELECT * FROM cursor_4c_TratamentoTemp INTO CURSOR cursor_4c_Tratamento READWRITE
2757:                         USE IN cursor_4c_TratamentoTemp
2758:                         SELECT cursor_4c_Tratamento
2759:                         GO TOP
2760:                         *-- Vincular cursor ao grid (somente na primeira carga)
2761:                         loc_oGrid.ColumnCount = 10
2762:                         loc_oGrid.RecordSource = "cursor_4c_Tratamento"
2763:                         loc_oGrid.Column1.ControlSource  = "cursor_4c_Tratamento.Produto"
2764:                         loc_oGrid.Column2.ControlSource  = "cursor_4c_Tratamento.Datas"
2765:                         loc_oGrid.Column3.ControlSource  = "cursor_4c_Tratamento.Barras"
2766:                         loc_oGrid.Column4.ControlSource  = "cursor_4c_Tratamento.BarraNovos"
2767:                         loc_oGrid.Column5.ControlSource  = "cursor_4c_Tratamento.Apurado"
2768:                         loc_oGrid.Column6.ControlSource  = "cursor_4c_Tratamento.Estoque"
2769:                         loc_oGrid.Column7.ControlSource  = "cursor_4c_Tratamento.Faltas"
2770:                         loc_oGrid.Column8.ControlSource  = "cursor_4c_Tratamento.Ocorrencia"
2771:                         loc_oGrid.Column9.ControlSource  = "cursor_4c_Tratamento.Tipos"
2772:                         loc_oGrid.Column10.ControlSource = "cursor_4c_Tratamento.PesReals"
2773: 
2774:                         *-- Headers DEVEM ser redefinidos apos RecordSource (VFP9 reseta para nome do campo)
2775:                         loc_oGrid.Column1.Header1.Caption  = "Produto"
2776:                         loc_oGrid.Column2.Header1.Caption  = "Data"
2777:                         loc_oGrid.Column3.Header1.Caption  = "Barra"
2778:                         loc_oGrid.Column4.Header1.Caption  = "Barra Novo"
2779:                         loc_oGrid.Column5.Header1.Caption  = "Apurado"
2780:                         loc_oGrid.Column6.Header1.Caption  = "Estoque"
2781:                         loc_oGrid.Column7.Header1.Caption  = "Diferen" + CHR(231) + "a"
2782:                         loc_oGrid.Column8.Header1.Caption  = "Ocorrencia"
2783:                         loc_oGrid.Column9.Header1.Caption  = "T"
2784:                         loc_oGrid.Column10.Header1.Caption = "Dif. Peso"
2785:                     ENDIF
2786: 
2787:                     IF loc_nResult >= 0

*-- Linhas 2801 a 2819:
2801:                         loc_nTotCOc = 0
2802:                         loc_nTotSOc = 0
2803:                         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
2804:                             SELECT cursor_4c_Tratamento
2805:                             GO TOP
2806:                             SCAN
2807:                                 IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia))
2808:                                     loc_nTotCOc = loc_nTotCOc + 1
2809:                                 ELSE
2810:                                     loc_nTotSOc = loc_nTotSOc + 1
2811:                                 ENDIF
2812:                             ENDSCAN
2813:                         ENDIF
2814: 
2815:                         WITH loc_oPg3.cnt_4c__CCusto1.cnt_4c__Total
2816:                             .txt_4c_TotCOc.Value = loc_nTotCOc
2817:                             .txt_4c_TotSOc.Value = loc_nTotSOc
2818:                             .Visible     = .T.
2819:                         ENDWITH

*-- Linhas 2931 a 2949:
2931:     *===========================================================================
2932:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2933:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2934:             SELECT cursor_4c_Dados
2935:             THIS.this_nCodigoSel    = cursor_4c_Dados.codigos
2936:             THIS.this_cCIdChavesSel = ALLTRIM(cursor_4c_Dados.cidchaves)
2937:         ENDIF
2938:     ENDPROC
2939: 
2940:     *===========================================================================
2941:     * FormatarGridLista - Aplica formatacao visual ao grid da lista
2942:     *===========================================================================
2943:     PROCEDURE FormatarGridLista(par_oGrid)
2944:         IF VARTYPE(par_oGrid) = "O"
2945:             par_oGrid.FontName = "Tahoma"
2946:             par_oGrid.FontSize = 9
2947:             par_oGrid.SetAll("DynamicBackColor", ;
2948:                 "IIF(MOD(RECNO('cursor_4c_Dados'),2)=0,RGB(240,245,255),RGB(255,255,255))", ;
2949:                 "Column")

*-- Linhas 2964 a 2986:
2964:                 MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
2965:                     "Sele" + CHR(231) + CHR(227) + "o")
2966:             ELSE
2967:                 loc_cSQL = "SELECT TOP 1 GesInd FROM SigCdPam" + ;
2968:                            " WHERE emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
2969:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
2970:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
2971:                     SELECT cursor_4c_Pam
2972:                     loc_nGesInd = TratarNulo(GesInd, "N")
2973:                 ENDIF
2974:                 IF USED("cursor_4c_Pam")
2975:                     USE IN cursor_4c_Pam
2976:                 ENDIF
2977: 
2978:                 IF loc_nGesInd = 1
2979:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReInr.prg"
2980:                 ELSE
2981:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReIr1.prg"
2982:                 ENDIF
2983: 
2984:                 IF FILE(loc_cFormPath)
2985:                     DO FORM (loc_cFormPath) WITH THIS.this_nCodigoSel
2986:                 ELSE

*-- Linhas 3148 a 3280:
3148:         LOCAL loc_oGrid
3149:         TRY
3150:             IF USED("cursor_4c_Dados")
3151:                 SELECT cursor_4c_Dados
3152:                 INDEX ON codigos TAG _proc
3153:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3154:                 loc_oGrid.SetFocus()
3155:                 loc_oGrid.ActiveColumn = 1
3156:             ENDIF
3157:         CATCH TO loException
3158:             MsgErro("Erro ao ordenar por processo:" + CHR(13) + loException.Message, ;
3159:                 "Formint.CmdProcessoClick")
3160:         ENDTRY
3161:     ENDPROC
3162: 
3163:     *===========================================================================
3164:     * CmdPeriodoClick - Ordena grid por periodo (datainis)
3165:     *===========================================================================
3166:     PROCEDURE CmdPeriodoClick()
3167:         LOCAL loc_oGrid
3168:         TRY
3169:             IF USED("cursor_4c_Dados")
3170:                 SELECT cursor_4c_Dados
3171:                 INDEX ON DTOS(datainis) TAG _perio
3172:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3173:                 loc_oGrid.SetFocus()
3174:                 loc_oGrid.ActiveColumn = 2
3175:             ENDIF
3176:         CATCH TO loException
3177:             MsgErro("Erro ao ordenar por per" + CHR(237) + "odo:" + CHR(13) + loException.Message, ;
3178:                 "Formint.CmdPeriodoClick")
3179:         ENDTRY
3180:     ENDPROC
3181: 
3182:     *===========================================================================
3183:     * CmdEstoqueClick - Ordena grid por estoque (contas)
3184:     *===========================================================================
3185:     PROCEDURE CmdEstoqueClick()
3186:         LOCAL loc_oGrid
3187:         TRY
3188:             IF USED("cursor_4c_Dados")
3189:                 SELECT cursor_4c_Dados
3190:                 INDEX ON ALLTRIM(contas) TAG _esto
3191:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3192:                 loc_oGrid.SetFocus()
3193:                 loc_oGrid.ActiveColumn = 4
3194:             ENDIF
3195:         CATCH TO loException
3196:             MsgErro("Erro ao ordenar por estoque:" + CHR(13) + loException.Message, ;
3197:                 "Formint.CmdEstoqueClick")
3198:         ENDTRY
3199:     ENDPROC
3200: 
3201:     *===========================================================================
3202:     * CmdLocalClick - Ordena grid por local inicial (localis)
3203:     *===========================================================================
3204:     PROCEDURE CmdLocalClick()
3205:         LOCAL loc_oGrid
3206:         TRY
3207:             IF USED("cursor_4c_Dados")
3208:                 SELECT cursor_4c_Dados
3209:                 INDEX ON ALLTRIM(localis) TAG _loca
3210:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3211:                 loc_oGrid.SetFocus()
3212:                 loc_oGrid.ActiveColumn = 5
3213:             ENDIF
3214:         CATCH TO loException
3215:             MsgErro("Erro ao ordenar por local:" + CHR(13) + loException.Message, ;
3216:                 "Formint.CmdLocalClick")
3217:         ENDTRY
3218:     ENDPROC
3219: 
3220:     *===========================================================================
3221:     * CmdGrupoClick - Ordena grid por grupo (grupos)
3222:     *===========================================================================
3223:     PROCEDURE CmdGrupoClick()
3224:         LOCAL loc_oGrid
3225:         TRY
3226:             IF USED("cursor_4c_Dados")
3227:                 SELECT cursor_4c_Dados
3228:                 INDEX ON ALLTRIM(grupos) TAG _gru
3229:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3230:                 loc_oGrid.SetFocus()
3231:                 loc_oGrid.ActiveColumn = 7
3232:             ENDIF
3233:         CATCH TO loException
3234:             MsgErro("Erro ao ordenar por grupo:" + CHR(13) + loException.Message, ;
3235:                 "Formint.CmdGrupoClick")
3236:         ENDTRY
3237:     ENDPROC
3238: 
3239:     *===========================================================================
3240:     * CmdGGrupoClick - Ordena grid por grande grupo (cggruis)
3241:     *===========================================================================
3242:     PROCEDURE CmdGGrupoClick()
3243:         LOCAL loc_oGrid
3244:         TRY
3245:             IF USED("cursor_4c_Dados")
3246:                 SELECT cursor_4c_Dados
3247:                 INDEX ON ALLTRIM(cggruis) TAG _ggru
3248:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3249:                 loc_oGrid.SetFocus()
3250:                 loc_oGrid.ActiveColumn = 8
3251:             ENDIF
3252:         CATCH TO loException
3253:             MsgErro("Erro ao ordenar por grande grupo:" + CHR(13) + loException.Message, ;
3254:                 "Formint.CmdGGrupoClick")
3255:         ENDTRY
3256:     ENDPROC
3257: 
3258:     *===========================================================================
3259:     * CmdUsuarioClick - Ordena grid por usuario (usuars)
3260:     *===========================================================================
3261:     PROCEDURE CmdUsuarioClick()
3262:         LOCAL loc_oGrid
3263:         TRY
3264:             IF USED("cursor_4c_Dados")
3265:                 SELECT cursor_4c_Dados
3266:                 INDEX ON ALLTRIM(usuars) TAG _usu
3267:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3268:                 loc_oGrid.SetFocus()
3269:                 loc_oGrid.ActiveColumn = 9
3270:             ENDIF
3271:         CATCH TO loException
3272:             MsgErro("Erro ao ordenar por usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;
3273:                 "Formint.CmdUsuarioClick")
3274:         ENDTRY
3275:     ENDPROC
3276: 
3277:     *===========================================================================
3278:     * Destroy - Libera recursos ao fechar
3279:     *===========================================================================
3280:     PROCEDURE Destroy()

*-- Linhas 3311 a 3329:
3311:         LOCAL loc_oCnt
3312: 
3313:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3314:             SELECT cursor_4c_Tratamento
3315: 
3316:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3317:             WITH loc_oCnt
3318:                 .Visible             = .T.
3319:                 .txt_4c_DPro.Value   = TratarNulo(cursor_4c_Tratamento.Produto,  "C")
3320:                 .txt_4c_CCusto.Value = TratarNulo(cursor_4c_Tratamento.CCustos,  "C")
3321:                 .txt_4c_Dif.Value    = TratarNulo(cursor_4c_Tratamento.Faltas,   "N")
3322:                 .txt_4c_Usuars.Value = TratarNulo(cursor_4c_Tratamento.Usuars,   "C")
3323:                 .txt_4c_PesReal.Value = TratarNulo(cursor_4c_Tratamento.PesReals, "N")
3324:                 .edt_4c_ObsCnt1.Value = TratarNulo(cursor_4c_Tratamento.Obs, "C")
3325:                 .Refresh()
3326:             ENDWITH
3327: 
3328:             WITH THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3329:                 .Column8.ReadOnly       = .F.

*-- Linhas 3537 a 3597:
3537:             IF loc_cCaption = "\<Grava" OR loc_cCaption = "Grava"
3538:                 *-- Validar: todo lancamento com Ocorrencia deve ter Obs
3539:                 IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3540:                     SELECT cursor_4c_Tratamento
3541:                     GO TOP
3542:                     SCAN
3543:                         IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) AND ;
3544:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs)) AND ;
3545:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs2s))
3546:                             MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
3547:                                 "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
3548:                                 "Valida" + CHR(231) + CHR(227) + "o")
3549:                             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3550:                             loc_lValido = .F.
3551:                             EXIT
3552:                         ENDIF
3553:                     ENDSCAN
3554: 
3555:                     IF loc_lValido
3556:                         *-- Gravar cada linha na tabela SigIvTrT
3557:                         SELECT cursor_4c_Tratamento
3558:                         GO TOP
3559:                         SCAN
3560:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3561:                                 " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
3562:                                 ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
3563:                                 ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
3564:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3565:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3566:                                 " AND CIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.CIdChaves))
3567:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3568:                             IF loc_nResult < 0
3569:                                 MostrarErro("Erro ao gravar item:" + CHR(13) + ;
3570:                                     CapturarErroSQL(), "Formint.BtnSairCntClick")
3571:                                 loc_lValido = .F.
3572:                                 EXIT
3573:                             ENDIF
3574:                         ENDSCAN
3575:                     ENDIF
3576: 
3577:                     IF loc_lValido
3578:                     *-- Marcar inventario como tratado
3579:                     loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3580:                         " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3581:                         " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3582:                     SQLEXEC(gnConnHandle, loc_cSQL)
3583: 
3584:                     MsgInfo("Tratamento gravado com sucesso!", "Tratamento")
3585:                     loc_lResultado = .T.
3586:                     ENDIF
3587:                 ENDIF
3588:             ELSE
3589:                 loc_lResultado = .T.
3590:             ENDIF
3591: 
3592:             IF loc_lResultado
3593:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .F.
3594:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible     = .F.
3595:                 THIS.pgf_4c_Paginas.ActivePage = 1
3596:                 THIS.this_cModoAtual = "LISTA"
3597:                 THIS.CarregarLista()

*-- Linhas 3655 a 3673:
3655:             loc_cObs2s = ALLTRIM(loc_oCnt2.edt_4c_BNObs.Value)
3656: 
3657:             IF !EMPTY(loc_cObs2s) AND USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3658:                 SELECT cursor_4c_Tratamento
3659:                 REPLACE cursor_4c_Tratamento.Obs2s WITH loc_cObs2s
3660:                 REPLACE cursor_4c_Tratamento.BarraNovos WITH ALLTRIM(loc_oCnt2.txt_4c_GetBarNovo.Value)
3661:             ENDIF
3662: 
3663:             loc_oCnt2.Visible = .F.
3664:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3665:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3666:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3667:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3668:         CATCH TO loException
3669:             MsgErro("Erro em BtnBNSairClick:" + CHR(13) + loException.Message, ;
3670:                 "Formint.BtnBNSairClick")
3671:         ENDTRY
3672:     ENDPROC
3673: 

*-- Linhas 3723 a 3741:
3723:                 IF !USED("cursor_4c_Tratamento") OR RECCOUNT("cursor_4c_Tratamento") = 0
3724:                     MsgAviso("Nenhum item para tratar.", "Tratamento")
3725:                 ELSE
3726:                     SELECT cursor_4c_Tratamento
3727:                     GO TOP
3728:                     SCAN
3729:                         LOCAL loc_lAplicar
3730:                         loc_lAplicar = .F.
3731: 
3732:                         DO CASE
3733:                         CASE loc_nSemOcor = 1   && Lidos
3734:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "L")
3735:                         CASE loc_nSemOcor = 2   && Nao lidos
3736:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "N")
3737:                         CASE loc_nSemOcor = 3   && Saldos
3738:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "S")
3739:                         OTHERWISE
3740:                             loc_lAplicar = .T.
3741:                         ENDCASE

*-- Linhas 3838 a 3886:
3838: 
3839:                 IF loc_lConfirmar
3840:                     *-- Verificar operacao da ocorrencia na SigBaOco
3841:                     loc_cSQL = "SELECT TOP 1 Operacaos FROM SigBaOco" + ;
3842:                         " WHERE Tipos = 'O' AND Autos = 'S'" + ;
3843:                         " AND Codigos = " + EscaparSQL(loc_cOcor)
3844:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3845: 
3846:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3847:                         SELECT cursor_4c_Tratamento
3848:                         GO TOP
3849:                         SCAN
3850:                             LOCAL loc_cCidChave, loc_cBarras
3851:                             loc_cCidChave = ALLTRIM(cursor_4c_Tratamento.CIdChaves)
3852:                             loc_cBarras   = ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras))
3853: 
3854:                             *-- Aplicar ocorrencia no cursor local
3855:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3856:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3857: 
3858:                             *-- Gravar na tabela SigIvTrT
3859:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3860:                                 " Ocorrencia = " + EscaparSQL(loc_cOcor) + ;
3861:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3862:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3863:                                 " AND CIdChaves = " + EscaparSQL(loc_cCidChave)
3864:                             SQLEXEC(gnConnHandle, loc_cSQL)
3865:                         ENDSCAN
3866: 
3867:                         *-- Marcar inventario como tratado
3868:                         loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3869:                             " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3870:                             " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3871:                         SQLEXEC(gnConnHandle, loc_cSQL)
3872: 
3873:                         IF USED("cursor_4c_Ocorr")
3874:                             USE IN cursor_4c_Ocorr
3875:                         ENDIF
3876: 
3877:                         MsgInfo("Baixa Autom" + CHR(225) + "tica aplicada com sucesso!", ;
3878:                             "Baixa Autom" + CHR(225) + "tica")
3879: 
3880:                         loc_oCnt.Visible = .F.
3881:                         THIS.pgf_4c_Paginas.ActivePage = 1
3882:                         THIS.this_cModoAtual = "LISTA"
3883:                         THIS.CarregarLista()
3884:                         loc_lResultado = .T.
3885:                     ENDIF
3886:                 ENDIF

*-- Linhas 3924 a 3947:
3924:                     USE IN cursor_4c_Ocorr
3925:                 ENDIF
3926: 
3927:                 loc_cSQL = "SELECT TOP 1 CBars, CPros, Pesos FROM SigOpEtq" + ;
3928:                     " WHERE CBars = " + EscaparSQL(loc_cBarra)
3929:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3930: 
3931:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Ocorr") > 0
3932:                     SELECT cursor_4c_Ocorr
3933:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra.Value = ;
3934:                         ALLTRIM(cursor_4c_Ocorr.CBars)
3935:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.cmd_4c_CntInsere.Enabled = .T.
3936:                 ELSE
3937:                     MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + "o encontrado!", ;
3938:                         "Barra Inv" + CHR(225) + "lida")
3939:                     loc_lResultado = .F.
3940:                 ENDIF
3941: 
3942:                 IF USED("cursor_4c_Ocorr")
3943:                     USE IN cursor_4c_Ocorr
3944:                 ENDIF
3945:             ENDIF
3946:         CATCH TO loException
3947:             MsgErro("Erro em GetIBarraValid:" + CHR(13) + loException.Message, ;

*-- Linhas 4002 a 4020:
4002:             ELSE
4003:                 *-- Inserir no cursor local (ReadWrite permite APPEND BLANK)
4004:                 IF USED("cursor_4c_Tratamento")
4005:                     SELECT cursor_4c_Tratamento
4006:                     APPEND BLANK
4007:                     REPLACE cursor_4c_Tratamento.Emps       WITH ALLTRIM(go_4c_Sistema.cCodEmpresa)
4008:                     REPLACE cursor_4c_Tratamento.Codigos    WITH THIS.this_nCodigoSel
4009:                     REPLACE cursor_4c_Tratamento.Barras     WITH VAL(loc_cBarra)
4010:                     REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
4011:                     REPLACE cursor_4c_Tratamento.Obs        WITH loc_cObs
4012:                     REPLACE cursor_4c_Tratamento.Tipos      WITH "L"
4013:                     REPLACE cursor_4c_Tratamento.Apurado    WITH 1
4014:                     REPLACE cursor_4c_Tratamento.Estoque    WITH 0
4015:                     REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
4016: 
4017:                     THIS.this_nCItens = THIS.this_nCItens + 1
4018: 
4019:                     *-- Limpar campos para proximo item
4020:                     loc_oCnt.txt_4c_IBarra.Value = ""

*-- Linhas 4058 a 4076:
4058:             loc_cBarra = ALLTRIM(loc_oPr.txt_4c_GetBusca.Value)
4059: 
4060:             IF !EMPTY(loc_cBarra) AND USED("cursor_4c_Tratamento")
4061:                 SELECT cursor_4c_Tratamento
4062:                 GO TOP
4063:                 LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras)) = loc_cBarra
4064:                 IF FOUND()
4065:                     *-- Mostrar grid e painel, ocultar procurar
4066:                     loc_oPr.Visible = .F.
4067:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .T.
4068:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible    = .T.
4069:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
4070:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
4071:                 ELSE
4072:                     MsgAviso("Barra '" + loc_cBarra + "' n" + CHR(227) + "o encontrada.", ;
4073:                         "Busca")
4074:                 ENDIF
4075:             ENDIF
4076:         CATCH TO loException


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
                loc_cSQL = "SELECT TOP 1 a.Valos" + ;
                           " FROM SigCdCot a" + ;
                           " WHERE a.CMoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                           " ORDER BY a.Datas DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cambio")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cambio") > 0
                    SELECT cursor_4c_Cambio
                    loc_nCotacao = TratarNulo(Valos, "N")
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

