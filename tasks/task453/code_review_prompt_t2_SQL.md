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

### FORM (C:\4c\projeto\app\forms\cadastros\Formint.prg) - TRECHOS RELEVANTES PARA PASS SQL (4280 linhas total):

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

*-- Linhas 2719 a 2789:
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
2755:                         *-- Primeira carga: precisa do cursor com nome correto
2756:                         USE IN cursor_4c_TratamentoTemp
2757:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tratamento")
2758:                         IF loc_nResult < 0
2759:                             MostrarErro("Erro ao carregar itens:" + CHR(13) + ;
2760:                                 CapturarErroSQL(), "Formint.CarregarGradeTratamento")
2761:                         ELSE
2762:                             *-- Vincular cursor ao grid (somente na primeira carga)
2763:                             loc_oGrid.ColumnCount = 10
2764:                             loc_oGrid.RecordSource = "cursor_4c_Tratamento"
2765:                             loc_oGrid.Column1.ControlSource  = "cursor_4c_Tratamento.Produto"
2766:                             loc_oGrid.Column2.ControlSource  = "cursor_4c_Tratamento.Datas"
2767:                             loc_oGrid.Column3.ControlSource  = "cursor_4c_Tratamento.Barras"
2768:                             loc_oGrid.Column4.ControlSource  = "cursor_4c_Tratamento.BarraNovos"
2769:                             loc_oGrid.Column5.ControlSource  = "cursor_4c_Tratamento.Apurado"
2770:                             loc_oGrid.Column6.ControlSource  = "cursor_4c_Tratamento.Estoque"
2771:                             loc_oGrid.Column7.ControlSource  = "cursor_4c_Tratamento.Faltas"
2772:                             loc_oGrid.Column8.ControlSource  = "cursor_4c_Tratamento.Ocorrencia"
2773:                             loc_oGrid.Column9.ControlSource  = "cursor_4c_Tratamento.Tipos"
2774:                             loc_oGrid.Column10.ControlSource = "cursor_4c_Tratamento.PesReals"
2775: 
2776:                             *-- Headers DEVEM ser redefinidos apos RecordSource (VFP9 reseta para nome do campo)
2777:                             loc_oGrid.Column1.Header1.Caption  = "Produto"
2778:                             loc_oGrid.Column2.Header1.Caption  = "Data"
2779:                             loc_oGrid.Column3.Header1.Caption  = "Barra"
2780:                             loc_oGrid.Column4.Header1.Caption  = "Barra Novo"
2781:                             loc_oGrid.Column5.Header1.Caption  = "Apurado"
2782:                             loc_oGrid.Column6.Header1.Caption  = "Estoque"
2783:                             loc_oGrid.Column7.Header1.Caption  = "Diferen" + CHR(231) + "a"
2784:                             loc_oGrid.Column8.Header1.Caption  = "Ocorrencia"
2785:                             loc_oGrid.Column9.Header1.Caption  = "T"
2786:                             loc_oGrid.Column10.Header1.Caption = "Dif. Peso"
2787:                         ENDIF
2788:                     ENDIF
2789: 

*-- Linhas 2801 a 2825:
2801:                         ENDIF
2802: 
2803:                         *-- Calcular totais iniciais de ocorrencias
2804:                         loc_nTotCOc = 0
2805:                         loc_nTotSOc = 0
2806:                         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
2807:                             SELECT cursor_4c_Tratamento
2808:                             GO TOP
2809:                             SCAN
2810:                                 IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia))
2811:                                     loc_nTotCOc = loc_nTotCOc + 1
2812:                                 ELSE
2813:                                     loc_nTotSOc = loc_nTotSOc + 1
2814:                                 ENDIF
2815:                             ENDSCAN
2816:                         ENDIF
2817: 
2818:                         WITH loc_oPg3.cnt_4c__CCusto1.cnt_4c__Total
2819:                             .txt_4c_TotCOc.Value = loc_nTotCOc
2820:                             .txt_4c_TotSOc.Value = loc_nTotSOc
2821:                             .Visible     = .T.
2822:                         ENDWITH
2823: 
2824:                         *-- Exibir grid e painel de controles
2825:                         loc_oPg3.cnt_4c__CCusto1.Visible = .T.

*-- Linhas 2934 a 2952:
2934:     *===========================================================================
2935:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2936:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2937:             SELECT cursor_4c_Dados
2938:             THIS.this_nCodigoSel    = cursor_4c_Dados.codigos
2939:             THIS.this_cCIdChavesSel = ALLTRIM(cursor_4c_Dados.cidchaves)
2940:         ENDIF
2941:     ENDPROC
2942: 
2943:     *===========================================================================
2944:     * FormatarGridLista - Aplica formatacao visual ao grid da lista
2945:     *===========================================================================
2946:     PROCEDURE FormatarGridLista(par_oGrid)
2947:         IF VARTYPE(par_oGrid) = "O"
2948:             par_oGrid.FontName = "Tahoma"
2949:             par_oGrid.FontSize = 9
2950:             par_oGrid.SetAll("DynamicBackColor", ;
2951:                 "IIF(MOD(RECNO('cursor_4c_Dados'),2)=0,RGB(240,245,255),RGB(255,255,255))", ;
2952:                 "Column")

*-- Linhas 2967 a 2989:
2967:                 MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
2968:                     "Sele" + CHR(231) + CHR(227) + "o")
2969:             ELSE
2970:                 loc_cSQL = "SELECT TOP 1 GesInd FROM SigCdPam" + ;
2971:                            " WHERE emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
2972:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
2973:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
2974:                     SELECT cursor_4c_Pam
2975:                     loc_nGesInd = TratarNulo(GesInd, "N")
2976:                 ENDIF
2977:                 IF USED("cursor_4c_Pam")
2978:                     USE IN cursor_4c_Pam
2979:                 ENDIF
2980: 
2981:                 IF loc_nGesInd = 1
2982:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReInr.prg"
2983:                 ELSE
2984:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReIr1.prg"
2985:                 ENDIF
2986: 
2987:                 IF FILE(loc_cFormPath)
2988:                     DO FORM (loc_cFormPath) WITH THIS.this_nCodigoSel
2989:                 ELSE

*-- Linhas 3151 a 3406:
3151:         LOCAL loc_oGrid
3152:         TRY
3153:             IF USED("cursor_4c_Dados")
3154:                 SELECT cursor_4c_Dados
3155:                 INDEX ON codigos TAG _proc
3156:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3157:                 loc_oGrid.SetFocus()
3158:                 loc_oGrid.ActiveColumn = 1
3159:             ENDIF
3160:         CATCH TO loException
3161:             MsgErro("Erro ao ordenar por processo:" + CHR(13) + loException.Message, ;
3162:                 "Formint.CmdProcessoClick")
3163:         ENDTRY
3164:     ENDPROC
3165: 
3166:     *===========================================================================
3167:     * CmdPeriodoClick - Ordena grid por periodo (datainis)
3168:     *===========================================================================
3169:     PROCEDURE CmdPeriodoClick()
3170:         LOCAL loc_oGrid
3171:         TRY
3172:             IF USED("cursor_4c_Dados")
3173:                 SELECT cursor_4c_Dados
3174:                 INDEX ON DTOS(datainis) TAG _perio
3175:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3176:                 loc_oGrid.SetFocus()
3177:                 loc_oGrid.ActiveColumn = 2
3178:             ENDIF
3179:         CATCH TO loException
3180:             MsgErro("Erro ao ordenar por per" + CHR(237) + "odo:" + CHR(13) + loException.Message, ;
3181:                 "Formint.CmdPeriodoClick")
3182:         ENDTRY
3183:     ENDPROC
3184: 
3185:     *===========================================================================
3186:     * CmdEstoqueClick - Ordena grid por estoque (contas)
3187:     *===========================================================================
3188:     PROCEDURE CmdEstoqueClick()
3189:         LOCAL loc_oGrid
3190:         TRY
3191:             IF USED("cursor_4c_Dados")
3192:                 SELECT cursor_4c_Dados
3193:                 INDEX ON ALLTRIM(contas) TAG _esto
3194:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3195:                 loc_oGrid.SetFocus()
3196:                 loc_oGrid.ActiveColumn = 4
3197:             ENDIF
3198:         CATCH TO loException
3199:             MsgErro("Erro ao ordenar por estoque:" + CHR(13) + loException.Message, ;
3200:                 "Formint.CmdEstoqueClick")
3201:         ENDTRY
3202:     ENDPROC
3203: 
3204:     *===========================================================================
3205:     * CmdLocalClick - Ordena grid por local inicial (localis)
3206:     *===========================================================================
3207:     PROCEDURE CmdLocalClick()
3208:         LOCAL loc_oGrid
3209:         TRY
3210:             IF USED("cursor_4c_Dados")
3211:                 SELECT cursor_4c_Dados
3212:                 INDEX ON ALLTRIM(localis) TAG _loca
3213:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3214:                 loc_oGrid.SetFocus()
3215:                 loc_oGrid.ActiveColumn = 5
3216:             ENDIF
3217:         CATCH TO loException
3218:             MsgErro("Erro ao ordenar por local:" + CHR(13) + loException.Message, ;
3219:                 "Formint.CmdLocalClick")
3220:         ENDTRY
3221:     ENDPROC
3222: 
3223:     *===========================================================================
3224:     * CmdGrupoClick - Ordena grid por grupo (grupos)
3225:     *===========================================================================
3226:     PROCEDURE CmdGrupoClick()
3227:         LOCAL loc_oGrid
3228:         TRY
3229:             IF USED("cursor_4c_Dados")
3230:                 SELECT cursor_4c_Dados
3231:                 INDEX ON ALLTRIM(grupos) TAG _gru
3232:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3233:                 loc_oGrid.SetFocus()
3234:                 loc_oGrid.ActiveColumn = 7
3235:             ENDIF
3236:         CATCH TO loException
3237:             MsgErro("Erro ao ordenar por grupo:" + CHR(13) + loException.Message, ;
3238:                 "Formint.CmdGrupoClick")
3239:         ENDTRY
3240:     ENDPROC
3241: 
3242:     *===========================================================================
3243:     * CmdGGrupoClick - Ordena grid por grande grupo (cggruis)
3244:     *===========================================================================
3245:     PROCEDURE CmdGGrupoClick()
3246:         LOCAL loc_oGrid
3247:         TRY
3248:             IF USED("cursor_4c_Dados")
3249:                 SELECT cursor_4c_Dados
3250:                 INDEX ON ALLTRIM(cggruis) TAG _ggru
3251:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3252:                 loc_oGrid.SetFocus()
3253:                 loc_oGrid.ActiveColumn = 8
3254:             ENDIF
3255:         CATCH TO loException
3256:             MsgErro("Erro ao ordenar por grande grupo:" + CHR(13) + loException.Message, ;
3257:                 "Formint.CmdGGrupoClick")
3258:         ENDTRY
3259:     ENDPROC
3260: 
3261:     *===========================================================================
3262:     * CmdUsuarioClick - Ordena grid por usuario (usuars)
3263:     *===========================================================================
3264:     PROCEDURE CmdUsuarioClick()
3265:         LOCAL loc_oGrid
3266:         TRY
3267:             IF USED("cursor_4c_Dados")
3268:                 SELECT cursor_4c_Dados
3269:                 INDEX ON ALLTRIM(usuars) TAG _usu
3270:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3271:                 loc_oGrid.SetFocus()
3272:                 loc_oGrid.ActiveColumn = 9
3273:             ENDIF
3274:         CATCH TO loException
3275:             MsgErro("Erro ao ordenar por usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;
3276:                 "Formint.CmdUsuarioClick")
3277:         ENDTRY
3278:     ENDPROC
3279: 
3280:     *===========================================================================
3281:     * Destroy - Libera recursos ao fechar
3282:     *===========================================================================
3283:     PROCEDURE Destroy()
3284:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3285:             THIS.this_oBusinessObject = .NULL.
3286:         ENDIF
3287: 
3288:         IF USED("cursor_4c_Dados")
3289:             USE IN cursor_4c_Dados
3290:         ENDIF
3291:         IF USED("cursor_4c_Tratamento")
3292:             USE IN cursor_4c_Tratamento
3293:         ENDIF
3294:         IF USED("cursor_4c_TratamentoTemp")
3295:             USE IN cursor_4c_TratamentoTemp
3296:         ENDIF
3297:         IF USED("cursor_4c_Ocorr")
3298:             USE IN cursor_4c_Ocorr
3299:         ENDIF
3300:         IF USED("CrSigCdBal")
3301:             USE IN CrSigCdBal
3302:         ENDIF
3303:         IF USED("CsTratamento")
3304:             USE IN CsTratamento
3305:         ENDIF
3306: 
3307:         DODEFAULT()
3308:     ENDPROC
3309: 
3310:     *===========================================================================
3311:     * GrdBalancoAfterRowColChange - Exibe painel de controles com dados do item
3312:     *===========================================================================
3313:     PROCEDURE GrdBalancoAfterRowColChange(par_nColIndex)
3314:         LOCAL loc_oCnt
3315: 
3316:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3317:             SELECT cursor_4c_Tratamento
3318: 
3319:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3320:             WITH loc_oCnt
3321:                 .Visible             = .T.
3322:                 .txt_4c_DPro.Value   = TratarNulo(cursor_4c_Tratamento.Produto,  "C")
3323:                 .txt_4c_CCusto.Value = TratarNulo(cursor_4c_Tratamento.CCustos,  "C")
3324:                 .txt_4c_Dif.Value    = TratarNulo(cursor_4c_Tratamento.Faltas,   "N")
3325:                 .txt_4c_Usuars.Value = TratarNulo(cursor_4c_Tratamento.Usuars,   "C")
3326:                 .txt_4c_PesReal.Value = TratarNulo(cursor_4c_Tratamento.PesReals, "N")
3327:                 .edt_4c_ObsCnt1.Value = TratarNulo(cursor_4c_Tratamento.Obs, "C")
3328:                 .Refresh()
3329:             ENDWITH
3330: 
3331:             WITH THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3332:                 .Column8.ReadOnly       = .F.
3333:                 .Column8.Text1.ReadOnly = .F.
3334:                 .Refresh()
3335:             ENDWITH
3336:         ENDIF
3337:     ENDPROC
3338: 
3339:     *===========================================================================
3340:     * GrdColOcorWhen - Salva valor atual antes da edicao (Column8)
3341:     *===========================================================================
3342:     PROCEDURE GrdColOcorWhen()
3343:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3344:             THIS.this_cOldValue = ALLTRIM(TratarNulo(cursor_4c_Tratamento.Ocorrencia, "C"))
3345:         ENDIF
3346:     ENDPROC
3347: 
3348:     *===========================================================================
3349:     * GrdColOcorValid - Valida e abre lookup de Ocorrencia (Column8)
3350:     *===========================================================================
3351:     PROCEDURE GrdColOcorValid()
3352:         LOCAL loc_lResultado, loc_oGrid, loc_cOcor
3353:         loc_lResultado = .T.
3354: 
3355:         TRY
3356:             loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3357:             loc_cOcor = ALLTRIM(loc_oGrid.Column8.Text1.Value)
3358: 
3359:             WITH THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3360:                 .cmd_4c_BarraNovo.Visible = .F.
3361:             ENDWITH
3362: 
3363:             IF !EMPTY(loc_cOcor) AND loc_cOcor != THIS.this_cOldValue
3364:                 loc_lResultado = THIS.AbrirLookupOcorrencia("O", "<>", loc_cOcor, ;
3365:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1)
3366:             ENDIF
3367: 
3368:             *-- Atualizar usuario no painel
3369:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3370:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.txt_4c_Usuars.Value = ;
3371:                     ALLTRIM(gc_4c_UsuarioLogado)
3372:             ENDIF
3373:         CATCH TO loException
3374:             MsgErro("Erro em GrdColOcorValid:" + CHR(13) + ;
3375:                 loException.Message + CHR(13) + ;
3376:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3377:                 "Formint.GrdColOcorValid")
3378:             loc_lResultado = .F.
3379:         ENDTRY
3380: 
3381:         RETURN loc_lResultado
3382:     ENDPROC
3383: 
3384:     *===========================================================================
3385:     * GrdColOcorLostFocus - Atualiza contadores apos saida do campo (Column8)
3386:     *===========================================================================
3387:     PROCEDURE GrdColOcorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3388:         LOCAL loc_cNovo, loc_oTotal, loc_nCOc, loc_nSOc
3389: 
3390:         TRY
3391:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3392:                 loc_cNovo  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.Value)
3393:                 loc_oTotal = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cnt_4c__Total
3394:                 loc_nCOc   = loc_oTotal.txt_4c_TotCOc.Value
3395:                 loc_nSOc   = loc_oTotal.txt_4c_TotSOc.Value
3396: 
3397:                 IF !EMPTY(THIS.this_cOldValue) AND EMPTY(loc_cNovo)
3398:                     loc_nCOc = loc_nCOc - 1
3399:                     loc_nSOc = loc_nSOc + 1
3400:                 ELSE
3401:                     IF EMPTY(THIS.this_cOldValue) AND !EMPTY(loc_cNovo)
3402:                         loc_nCOc = loc_nCOc + 1
3403:                         loc_nSOc = loc_nSOc - 1
3404:                     ENDIF
3405:                 ENDIF
3406: 

*-- Linhas 3537 a 3600:
3537:         TRY
3538:             loc_cCaption = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption)
3539: 
3540:             IF loc_cCaption = "\<Grava" OR loc_cCaption = "Grava"
3541:                 *-- Validar: todo lancamento com Ocorrencia deve ter Obs
3542:                 IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3543:                     SELECT cursor_4c_Tratamento
3544:                     GO TOP
3545:                     SCAN
3546:                         IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) AND ;
3547:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs)) AND ;
3548:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs2s))
3549:                             MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
3550:                                 "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
3551:                                 "Valida" + CHR(231) + CHR(227) + "o")
3552:                             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3553:                             loc_lValido = .F.
3554:                             EXIT
3555:                         ENDIF
3556:                     ENDSCAN
3557: 
3558:                     IF loc_lValido
3559:                         *-- Gravar cada linha na tabela SigIvTrT
3560:                         SELECT cursor_4c_Tratamento
3561:                         GO TOP
3562:                         SCAN
3563:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3564:                                 " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
3565:                                 ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
3566:                                 ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
3567:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3568:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3569:                                 " AND CIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.CIdChaves))
3570:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3571:                             IF loc_nResult < 0
3572:                                 MostrarErro("Erro ao gravar item:" + CHR(13) + ;
3573:                                     CapturarErroSQL(), "Formint.BtnSairCntClick")
3574:                                 loc_lValido = .F.
3575:                                 EXIT
3576:                             ENDIF
3577:                         ENDSCAN
3578:                     ENDIF
3579: 
3580:                     IF loc_lValido
3581:                     *-- Marcar inventario como tratado
3582:                     loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3583:                         " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3584:                         " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3585:                     SQLEXEC(gnConnHandle, loc_cSQL)
3586: 
3587:                     MsgInfo("Tratamento gravado com sucesso!", "Tratamento")
3588:                     loc_lResultado = .T.
3589:                     ENDIF
3590:                 ENDIF
3591:             ELSE
3592:                 loc_lResultado = .T.
3593:             ENDIF
3594: 
3595:             IF loc_lResultado
3596:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .F.
3597:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible     = .F.
3598:                 THIS.pgf_4c_Paginas.ActivePage = 1
3599:                 THIS.this_cModoAtual = "LISTA"
3600:                 THIS.CarregarLista()

*-- Linhas 3655 a 3678:
3655:         LOCAL loc_oCnt2, loc_cObs2s
3656:         TRY
3657:             loc_oCnt2 = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
3658:             loc_cObs2s = ALLTRIM(loc_oCnt2.edt_4c_BNObs.Value)
3659: 
3660:             IF !EMPTY(loc_cObs2s) AND USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3661:                 SELECT cursor_4c_Tratamento
3662:                 REPLACE cursor_4c_Tratamento.Obs2s WITH loc_cObs2s
3663:                 REPLACE cursor_4c_Tratamento.BarraNovos WITH ALLTRIM(loc_oCnt2.txt_4c_GetBarNovo.Value)
3664:             ENDIF
3665: 
3666:             loc_oCnt2.Visible = .F.
3667:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3668:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3669:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3670:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3671:         CATCH TO loException
3672:             MsgErro("Erro em BtnBNSairClick:" + CHR(13) + loException.Message, ;
3673:                 "Formint.BtnBNSairClick")
3674:         ENDTRY
3675:     ENDPROC
3676: 
3677:     *===========================================================================
3678:     * GetTOcorCntTratValid - Lookup de Ocorrencia no painel TratOcor (Tipos='O')

*-- Linhas 3721 a 3771:
3721: 
3722:             IF EMPTY(loc_cOcor)
3723:                 MsgAviso("Informe a Ocorr" + CHR(234) + "ncia para o Tratamento.", ;
3724:                     "Campo Obrigat" + CHR(243) + "rio")
3725:             ELSE
3726:                 IF !USED("cursor_4c_Tratamento") OR RECCOUNT("cursor_4c_Tratamento") = 0
3727:                     MsgAviso("Nenhum item para tratar.", "Tratamento")
3728:                 ELSE
3729:                     SELECT cursor_4c_Tratamento
3730:                     GO TOP
3731:                     SCAN
3732:                         LOCAL loc_lAplicar
3733:                         loc_lAplicar = .F.
3734: 
3735:                         DO CASE
3736:                         CASE loc_nSemOcor = 1   && Lidos
3737:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "L")
3738:                         CASE loc_nSemOcor = 2   && Nao lidos
3739:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "N")
3740:                         CASE loc_nSemOcor = 3   && Saldos
3741:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "S")
3742:                         OTHERWISE
3743:                             loc_lAplicar = .T.
3744:                         ENDCASE
3745: 
3746:                         IF loc_cTipos = "Entrada"
3747:                             loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas < 0)
3748:                         ELSE
3749:                             IF loc_cTipos = "Sa" + CHR(237) + "da"
3750:                                 loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas > 0)
3751:                             ENDIF
3752:                         ENDIF
3753: 
3754:                         IF loc_lAplicar
3755:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3756:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3757:                         ENDIF
3758:                     ENDSCAN
3759: 
3760:                     loc_oCnt.Visible = .F.
3761:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3762:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3763:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3764:                     loc_lResultado = .T.
3765:                 ENDIF
3766:             ENDIF
3767:         CATCH TO loException
3768:             MsgErro("Erro em BtnTratOcorClick:" + CHR(13) + ;
3769:                 loException.Message + CHR(13) + ;
3770:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3771:                 "Formint.BtnTratOcorClick")

*-- Linhas 3841 a 3889:
3841: 
3842:                 IF loc_lConfirmar
3843:                     *-- Verificar operacao da ocorrencia na SigBaOco
3844:                     loc_cSQL = "SELECT TOP 1 Operacaos FROM SigBaOco" + ;
3845:                         " WHERE Tipos = 'O' AND Autos = 'S'" + ;
3846:                         " AND Codigos = " + EscaparSQL(loc_cOcor)
3847:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3848: 
3849:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3850:                         SELECT cursor_4c_Tratamento
3851:                         GO TOP
3852:                         SCAN
3853:                             LOCAL loc_cCidChave, loc_cBarras
3854:                             loc_cCidChave = ALLTRIM(cursor_4c_Tratamento.CIdChaves)
3855:                             loc_cBarras   = ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras))
3856: 
3857:                             *-- Aplicar ocorrencia no cursor local
3858:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3859:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3860: 
3861:                             *-- Gravar na tabela SigIvTrT
3862:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3863:                                 " Ocorrencia = " + EscaparSQL(loc_cOcor) + ;
3864:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3865:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3866:                                 " AND CIdChaves = " + EscaparSQL(loc_cCidChave)
3867:                             SQLEXEC(gnConnHandle, loc_cSQL)
3868:                         ENDSCAN
3869: 
3870:                         *-- Marcar inventario como tratado
3871:                         loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3872:                             " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3873:                             " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3874:                         SQLEXEC(gnConnHandle, loc_cSQL)
3875: 
3876:                         IF USED("cursor_4c_Ocorr")
3877:                             USE IN cursor_4c_Ocorr
3878:                         ENDIF
3879: 
3880:                         MsgInfo("Baixa Autom" + CHR(225) + "tica aplicada com sucesso!", ;
3881:                             "Baixa Autom" + CHR(225) + "tica")
3882: 
3883:                         loc_oCnt.Visible = .F.
3884:                         THIS.pgf_4c_Paginas.ActivePage = 1
3885:                         THIS.this_cModoAtual = "LISTA"
3886:                         THIS.CarregarLista()
3887:                         loc_lResultado = .T.
3888:                     ENDIF
3889:                 ENDIF

*-- Linhas 3927 a 3950:
3927:                     USE IN cursor_4c_Ocorr
3928:                 ENDIF
3929: 
3930:                 loc_cSQL = "SELECT TOP 1 CBars, CPros, Pesos FROM SigOpEtq" + ;
3931:                     " WHERE CBars = " + EscaparSQL(loc_cBarra)
3932:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3933: 
3934:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Ocorr") > 0
3935:                     SELECT cursor_4c_Ocorr
3936:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra.Value = ;
3937:                         ALLTRIM(cursor_4c_Ocorr.CBars)
3938:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.cmd_4c_CntInsere.Enabled = .T.
3939:                 ELSE
3940:                     MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + "o encontrado!", ;
3941:                         "Barra Inv" + CHR(225) + "lida")
3942:                     loc_lResultado = .F.
3943:                 ENDIF
3944: 
3945:                 IF USED("cursor_4c_Ocorr")
3946:                     USE IN cursor_4c_Ocorr
3947:                 ENDIF
3948:             ENDIF
3949:         CATCH TO loException
3950:             MsgErro("Erro em GetIBarraValid:" + CHR(13) + loException.Message, ;

*-- Linhas 4002 a 4033:
4002: 
4003:             IF EMPTY(loc_cBarra)
4004:                 MsgAviso("Informe o C" + CHR(243) + "digo de Barra.", "Campo Obrigat" + CHR(243) + "rio")
4005:             ELSE
4006:                 *-- Inserir no cursor local (ReadWrite permite APPEND BLANK)
4007:                 IF USED("cursor_4c_Tratamento")
4008:                     SELECT cursor_4c_Tratamento
4009:                     APPEND BLANK
4010:                     REPLACE cursor_4c_Tratamento.Emps       WITH ALLTRIM(go_4c_Sistema.cCodEmpresa)
4011:                     REPLACE cursor_4c_Tratamento.Codigos    WITH THIS.this_nCodigoSel
4012:                     REPLACE cursor_4c_Tratamento.Barras     WITH VAL(loc_cBarra)
4013:                     REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
4014:                     REPLACE cursor_4c_Tratamento.Obs        WITH loc_cObs
4015:                     REPLACE cursor_4c_Tratamento.Tipos      WITH "L"
4016:                     REPLACE cursor_4c_Tratamento.Apurado    WITH 1
4017:                     REPLACE cursor_4c_Tratamento.Estoque    WITH 0
4018:                     REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
4019: 
4020:                     THIS.this_nCItens = THIS.this_nCItens + 1
4021: 
4022:                     *-- Limpar campos para proximo item
4023:                     loc_oCnt.txt_4c_IBarra.Value = ""
4024:                     loc_oCnt.txt_4c_IOcor.Value  = ""
4025:                     loc_oCnt.edt_4c_IBObs.Value  = ""
4026:                     loc_oCnt.cmd_4c_CntInsere.Enabled = .F.
4027:                     loc_oCnt.txt_4c_IBarra.SetFocus()
4028: 
4029:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
4030:                     loc_lResultado = .T.
4031:                 ENDIF
4032:             ENDIF
4033:         CATCH TO loException

*-- Linhas 4058 a 4081:
4058: 
4059:         TRY
4060:             loc_oPr    = THIS.pgf_4c_Paginas.Page3.cnt_4c__Procurar
4061:             loc_cBarra = ALLTRIM(loc_oPr.txt_4c_GetBusca.Value)
4062: 
4063:             IF !EMPTY(loc_cBarra) AND USED("cursor_4c_Tratamento")
4064:                 SELECT cursor_4c_Tratamento
4065:                 GO TOP
4066:                 LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras)) = loc_cBarra
4067:                 IF FOUND()
4068:                     *-- Mostrar grid e painel, ocultar procurar
4069:                     loc_oPr.Visible = .F.
4070:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .T.
4071:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible    = .T.
4072:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
4073:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
4074:                 ELSE
4075:                     MsgAviso("Barra '" + loc_cBarra + "' n" + CHR(227) + "o encontrada.", ;
4076:                         "Busca")
4077:                 ENDIF
4078:             ENDIF
4079:         CATCH TO loException
4080:             MsgErro("Erro em GetBuscaValid:" + CHR(13) + loException.Message, ;
4081:                 "Formint.GetBuscaValid")


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

