# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NDOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CLASSES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS

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
  ControlSource = "crSigOpOpe.dopereals"
  ControlSource = "crSigOpOpe.dopes"
  ControlSource = ""
  ControlSource = "crSigOpOpe.ndopes"
  ControlSource = "crSigOpOpe.DiasVcto"
  ControlSource = "crSigOpOpe.DadosPgs"
  ControlSource = "crSigOpOpe.CampoNfs"
  ControlSource = "crSigOpOpe.opdepos"
  ControlSource = "crSigOpOpe.hists"
  ControlSource = "crSigOpOpe.blqccs"
  ControlSource = "crSigOpOpe.Pendencias"
  ControlSource = "crSigOpOpe.QtdBols"
  ControlSource = "crSigOpOpe.realprevs"
  ControlSource = "crSigOpOpe.EmiPorDesp"
  ControlSource = "crSigOpOpe.valprev"
  ControlSource = "crSigOpOpe.TpHists"
  ControlSource = "crSigOpOpe.titauts"
  ControlSource = "crSigOpOpe.identifics"
  ControlSource = "crSigOpOpe.txt01"
  ControlSource = "crSigOpOpe.txt02"
  ControlSource = "crSigOpOpe.Jobs"
  ControlSource = "crSigOpOpe.impdocs"
  ControlSource = "crSigOpOpe.txt03"
  ControlSource = "crSigOpOpe.txt04"
  ControlSource = "crSigOpOpe.grupo1s"
  ControlSource = "crSigOpOpe.grupo2s"
  ControlSource = "crSigOpOpe.grupo3s"
  ControlSource = "crSigOpOpe.grupo4s"
  ControlSource = "crSigOpOpe.impbols"
  ControlSource = "crSigOpOpe.grpcad3s"
  ControlSource = "crSigOpOpe.grpcad2s"
  ControlSource = "crSigOpOpe.grpcad4s"
  ControlSource = "crSigOpOpe.grpcad1s"
  ControlSource = "crSigOpOpe.Compets"
  ControlSource = "crSigOpOpe.AltTrans"
  ControlSource = "crSigOpOpe.cnMascaras"
  ControlSource = "crSigOpOpe.OutTits"
  ControlSource = "crSigOpOpe.juros"
  ControlSource = "crSigOpOpe.FiltContas"
  ControlSource = "crSigOpOpe.dopCancs"
  ControlSource = "crSigOpOpe.class1s"
  ControlSource = "crSigOpOpe.class2s"
  ControlSource = "crSigOpOpe.class3s"
  ControlSource = "crSigOpOpe.class4s"
  ControlSource = "crSigOpOpe.Limcres"
  ControlSource = "crSigOpOpe.Moedas"
  ControlSource = "crSigOpOpe.VlrLimApv"
  ControlSource = "crSigOpOpe.congvs"
  ControlSource = "crSigOpOpe.opeCancs"
  ControlSource = "crSigOpOpe.BlqTits"
  ControlSource = "crSigOpOpe.espobrigs"
  ControlSource = "crSigOpOpe.LancCCEs"
  ControlSource = "crSigOpOpe.LancCCAs"
  ControlSource = "crSigOpOpe.obsobrigs"
  ControlSource = "crSigOpOpe.ObrigC1"
  ControlSource = "crSigOpOpe.ObrigC2"
  ControlSource = "crSigOpOpe.ObrigC3"
  ControlSource = "crSigOpOpe.ObrigC4"
  ControlSource = "crSigOpOpe.obrCompet"
  ControlSource = "crSigOpOpe.Pastas"
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpOpe'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdPrg'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpOpe'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdPrg'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpOpe'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdPrg'),1,-1)
SELECT crSigOpOpe
select crSigOpOpe
	SELECT crSigCdGcr
	SELECT crSigCdGcr
	SELECT crSigCdGcr
	SELECT crSigCdGcr
Select crSigOpOpe
	SELECT crSigOpOpe
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves, barraforms  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
		Insert Into crSigCdPrg ( Descricaos, Parametros, Programas, pkChaves  ) ;
	SELECT CRSigOpOpe
	DELETE
Select crSigOpOpe
	ThisForm.podatamgr.SqlExecute([Select * From SigOpOpe Where RealPrevs <> 2],'TmpOpe')
	Select TmpOpe
	If !Seek( This.Value )
select crSigOpOpe
select CRSigOpOpe
select crSigOpOpe
select crSigOpOpe
select crSigOpOpe
	ThisForm.podatamgr.SqlExecute([Select * From SigOpOpe Where OpeCancs = 1],'TmpOpe')
	Select TmpOpe
	If !Seek( This.Value )
	ThisForm.podatamgr.SqlExecute([Select * From SigCdCss Where LEN(RTRIM(classes))=1],'TmpCss')
	Select TmpCss
	If !Seek( This.Value )
	ThisForm.podatamgr.SqlExecute([Select * From SigCdCss Where LEN(RTRIM(classes))=1],'TmpCss')
	Select TmpCss
	If !Seek( This.Value )
	ThisForm.podatamgr.SqlExecute([Select * From SigCdCss Where LEN(RTRIM(classes))=1],'TmpCss')
	Select TmpCss
	If !Seek( This.Value )
	ThisForm.podatamgr.SqlExecute([Select * From SigCdCss Where LEN(RTRIM(classes))=1],'TmpCss')
	Select TmpCss
	If !Seek( This.Value )

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOTI.prg) - TRECHOS RELEVANTES PARA PASS SQL (4416 linhas total):

*-- Linhas 343 a 361:
343:             .HighlightBackColor = RGB(255, 255, 255)
344:             .HighlightForeColor = RGB(15, 41, 104)
345:             .HighlightStyle     = 2
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .RowHeight          = 16
349:             .ScrollBars         = 2
350:             .GridLines          = 3
351:             .ReadOnly           = .T.
352:             .Visible            = .T.
353:         ENDWITH
354: 
355:         WITH loc_oGrid.Column1
356:             .Width           = 60
357:             .Alignment       = 0
358:             .Header1.Caption = "N" + CHR(186)
359:             .Resizable       = .T.
360:         ENDWITH
361: 

*-- Linhas 2462 a 2482:
2462:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2463:                         loc_oGrid.ColumnCount = 3
2464:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2465:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ndopes"
2466:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
2467:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Opers"
2468:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(186)
2469:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2470:                         loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2471:                         THIS.FormatarGridLista(loc_oGrid)
2472:                     ENDIF
2473:                 ENDIF
2474:             CATCH TO loc_oErro
2475:                 MsgErro(loc_oErro.Message, "FormOTI.CarregarLista")
2476:                 loc_lResultado = .F.
2477:             ENDTRY
2478:         ENDIF
2479: 
2480:         RETURN loc_lResultado
2481:     ENDPROC
2482: 

*-- Linhas 2516 a 2535:
2516: 
2517:         TRY
2518:             *-- Gerar pr" + CHR(243) + "ximo Ndope via MAX+1
2519:             loc_nResult = SQLEXEC(gnConnHandle, ;
2520:                 "SELECT ISNULL(MAX(Ndopes),0)+1 AS ProxNdope FROM SigOpOpe", ;
2521:                 "cursor_4c_NdopeTmp")
2522:             IF loc_nResult > 0 AND !EOF("cursor_4c_NdopeTmp")
2523:                 loc_nNdope = cursor_4c_NdopeTmp.ProxNdope
2524:             ELSE
2525:                 loc_nNdope = 1
2526:             ENDIF
2527:             IF USED("cursor_4c_NdopeTmp")
2528:                 USE IN cursor_4c_NdopeTmp
2529:             ENDIF
2530: 
2531:             THIS.this_oBusinessObject.NovoRegistro()
2532:             THIS.this_oBusinessObject.this_nNdopes = loc_nNdope
2533:             THIS.LimparCampos()
2534:             THIS.this_cModoAtual = "INCLUIR"
2535:             THIS.HabilitarCampos(.T.)

*-- Linhas 2562 a 2580:
2562:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2563:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
2564:             ELSE
2565:                 SELECT cursor_4c_Dados
2566:                 loc_nNdopes = cursor_4c_Dados.Ndopes
2567:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2568:                     THIS.this_cModoAtual = "VISUALIZAR"
2569:                     THIS.HabilitarCampos(.F.)
2570:                     THIS.AjustarBotoesPorModo()
2571:                     THIS.BOParaForm()
2572:                     THIS.pgf_4c_Paginas.ActivePage = 2
2573:                     loc_lResultado = .T.
2574:                 ELSE
2575:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "FormOTI")
2576:                 ENDIF
2577:             ENDIF
2578:         CATCH TO loc_oErro
2579:             MsgErro(loc_oErro.Message, "FormOTI.BtnVisualizarClick")
2580:         ENDTRY

*-- Linhas 2592 a 2610:
2592:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2593:                 MsgAviso("Selecione um registro na lista.", "Alterar")
2594:             ELSE
2595:                 SELECT cursor_4c_Dados
2596:                 loc_nNdopes = cursor_4c_Dados.Ndopes
2597:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2598:                     THIS.this_oBusinessObject.EditarRegistro()
2599:                     THIS.this_cModoAtual = "ALTERAR"
2600:                     THIS.HabilitarCampos(.T.)
2601:                     THIS.AjustarBotoesPorModo()
2602:                     THIS.BOParaForm()
2603:                     THIS.pgf_4c_Paginas.ActivePage = 2
2604:                     loc_lResultado = .T.
2605:                 ELSE
2606:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "FormOTI")
2607:                 ENDIF
2608:             ENDIF
2609:         CATCH TO loc_oErro
2610:             MsgErro(loc_oErro.Message, "FormOTI.BtnAlterarClick")

*-- Linhas 2623 a 2641:
2623:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2624:                 MsgAviso("Selecione um registro na lista.", "Excluir")
2625:             ELSE
2626:                 SELECT cursor_4c_Dados
2627:                 loc_nNdopes   = cursor_4c_Dados.Ndopes
2628:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o selecionada?", "Excluir")
2629:                 IF loc_lConfirma
2630:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2631:                         IF THIS.this_oBusinessObject.Excluir()
2632:                             MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!", "Excluir")
2633:                             THIS.CarregarLista()
2634:                             loc_lResultado = .T.
2635:                         ELSE
2636:                             MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o.", "FormOTI")
2637:                         ENDIF
2638:                     ELSE
2639:                         MsgErro("Erro ao localizar registro para exclus" + CHR(227) + "o.", "FormOTI")
2640:                     ENDIF
2641:                 ENDIF

*-- Linhas 2655 a 2696:
2655: 
2656:         TRY
2657:             LOCAL loc_nResult
2658:             loc_nResult = SQLEXEC(gnConnHandle, ;
2659:                 "SELECT Ndopes, Dopes, Opers FROM SigOpOpe ORDER BY Dopes", ;
2660:                 "cursor_4c_BuscaOpe")
2661: 
2662:             IF loc_nResult > 0
2663:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2664:             ENDIF
2665: 
2666:             IF VARTYPE(loc_oBusca) = "O"
2667:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
2668:                 loc_oBusca.mAddColuna("Ndopes", "", "N" + CHR(186))
2669:                 loc_oBusca.mAddColuna("Dopes",  "", "Descri" + CHR(231) + CHR(227) + "o")
2670:                 loc_oBusca.mAddColuna("Opers",  "", "Opera" + CHR(231) + CHR(227) + "o")
2671:                 loc_oBusca.Show()
2672: 
2673:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
2674:                     loc_nNdope = cursor_4c_BuscaOpe.Ndopes
2675:                     IF THIS.this_oBusinessObject.Buscar("Ndopes = " + FormatarNumeroSQL(loc_nNdope))
2676:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2677:                         loc_oGrid.ColumnCount = 3
2678:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2679:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ndopes"
2680:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
2681:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Opers"
2682:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(186)
2683:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2684:                         loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2685:                         THIS.FormatarGridLista(loc_oGrid)
2686:                         loc_lResultado = .T.
2687:                     ENDIF
2688:                 ENDIF
2689: 
2690:                 loc_oBusca.Release()
2691:             ENDIF
2692:         CATCH TO loc_oErro
2693:             MsgErro(loc_oErro.Message, "FormOTI.BtnBuscarClick")
2694:         ENDTRY
2695: 
2696:         IF USED("cursor_4c_BuscaOpe")

*-- Linhas 3648 a 3677:
3648:             ENDIF
3649: 
3650:             *-- Testa match exato
3651:             loc_cSQL    = "SELECT TOP 1 Operacaos FROM SigCdOpt WHERE Operacaos = " + EscaparSQL(loc_cOpdepo)
3652:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpt")
3653:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaOpt")
3654:                 RETURN
3655:             ENDIF
3656: 
3657:             *-- Sem match exato - abre picker com todos registros
3658:             IF USED("cursor_4c_BuscaOpt")
3659:                 USE IN cursor_4c_BuscaOpt
3660:             ENDIF
3661:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
3662:                 "SELECT Operacaos, Descrs FROM SigCdOpt ORDER BY Operacaos", ;
3663:                 "cursor_4c_BuscaOpt")
3664:             IF VARTYPE(loc_oBusca) = "O"
3665:                 loc_oBusca.mAddColuna("Operacaos", "", "C" + CHR(243) + "digo")
3666:                 loc_oBusca.mAddColuna("Descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
3667:                 loc_oBusca.Show()
3668:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
3669:                     loc_oPg2.txt_4c_Opdepo.Value = ALLTRIM(cursor_4c_BuscaOpt.Operacaos)
3670:                 ELSE
3671:                     loc_oPg2.txt_4c_Opdepo.Value = ""
3672:                 ENDIF
3673:                 loc_oBusca.Release()
3674:             ENDIF
3675: 
3676:         CATCH TO loc_oErro
3677:             MsgErro(loc_oErro.Message, "FormOTI.ValidarOpdepo")

*-- Linhas 3697 a 3722:
3697:                 RETURN
3698:             ENDIF
3699: 
3700:             loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE RealPrevs <> 2 AND Dopes = " + EscaparSQL(loc_cDopReal)
3701:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeR")
3702: 
3703:             IF loc_nResult > 0 AND !EOF("cursor_4c_TmpOpeR")
3704:                 loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR.Dopes)
3705:             ELSE
3706:                 loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE RealPrevs <> 2"
3707:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeR2")
3708:                 IF loc_nResult > 0
3709:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3710:                     IF VARTYPE(loc_oBusca) = "O"
3711:                         loc_oBusca.this_cCursorDestino = "cursor_4c_TmpOpeR2"
3712:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
3713:                         loc_oBusca.Show()
3714:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpOpeR2")
3715:                             loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR2.Dopes)
3716:                         ELSE
3717:                             loc_oPg2.txt_4c_DopReal.Value = ""
3718:                         ENDIF
3719:                         loc_oBusca.Release()
3720:                     ENDIF
3721:                 ENDIF
3722:             ENDIF

*-- Linhas 3748 a 3773:
3748:                 RETURN
3749:             ENDIF
3750: 
3751:             loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE OpeCancs = 1 AND Dopes = " + EscaparSQL(loc_cDopCanc)
3752:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCanc")
3753: 
3754:             IF loc_nResult > 0 AND !EOF("cursor_4c_TmpCanc")
3755:                 loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc.Dopes)
3756:             ELSE
3757:                 loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE OpeCancs = 1"
3758:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCanc2")
3759:                 IF loc_nResult > 0
3760:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3761:                     IF VARTYPE(loc_oBusca) = "O"
3762:                         loc_oBusca.this_cCursorDestino = "cursor_4c_TmpCanc2"
3763:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
3764:                         loc_oBusca.Show()
3765:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpCanc2")
3766:                             loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc2.Dopes)
3767:                         ELSE
3768:                             loc_oPg2.txt_4c_DopCanc.Value = ""
3769:                         ENDIF
3770:                         loc_oBusca.Release()
3771:                     ENDIF
3772:                 ENDIF
3773:             ENDIF

*-- Linhas 3835 a 3862:
3835:                 RETURN
3836:             ENDIF
3837: 
3838:             loc_cSQL    = "SELECT TOP 1 CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda)
3839:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
3840:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaMoe")
3841:                 loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3842:             ELSE
3843:                 IF USED("cursor_4c_BuscaMoe")
3844:                     USE IN cursor_4c_BuscaMoe
3845:                 ENDIF
3846:                 loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
3847:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
3848:                 IF loc_nResult > 0
3849:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3850:                     IF VARTYPE(loc_oBusca) = "O"
3851:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoe"
3852:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
3853:                         loc_oBusca.mAddColuna("DMoes", "", "Moeda")
3854:                         loc_oBusca.Show()
3855:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
3856:                             loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3857:                         ELSE
3858:                             loc_oPg2.txt_4c_Moeda.Value = ""
3859:                         ENDIF
3860:                         loc_oBusca.Release()
3861:                     ENDIF
3862:                 ENDIF

*-- Linhas 3915 a 3934:
3915:                 RETURN
3916:             ENDIF
3917: 
3918:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
3919:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr1")
3920:             IF loc_nResult > 0
3921:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3922:                 IF VARTYPE(loc_oBusca) = "O"
3923:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr1"
3924:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3925:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3926:                     loc_oBusca.Show()
3927:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr1")
3928:                         loc_oPg2.txt_4c_GrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Codigos)
3929:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
3930:                             loc_oPg2.txt_4c_DGrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Descrs)
3931:                         ENDIF
3932:                     ELSE
3933:                         loc_oPg2.txt_4c_GrpCad1.Value = ""
3934:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)

*-- Linhas 3974 a 3993:
3974:                 RETURN
3975:             ENDIF
3976: 
3977:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
3978:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr2")
3979:             IF loc_nResult > 0
3980:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3981:                 IF VARTYPE(loc_oBusca) = "O"
3982:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr2"
3983:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3984:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3985:                     loc_oBusca.Show()
3986:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
3987:                         loc_oPg2.txt_4c_GrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
3988:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
3989:                             loc_oPg2.txt_4c_DGrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
3990:                         ENDIF
3991:                     ELSE
3992:                         loc_oPg2.txt_4c_GrpCad2.Value = ""
3993:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)

*-- Linhas 4033 a 4052:
4033:                 RETURN
4034:             ENDIF
4035: 
4036:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
4037:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr3")
4038:             IF loc_nResult > 0
4039:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4040:                 IF VARTYPE(loc_oBusca) = "O"
4041:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr3"
4042:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4043:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4044:                     loc_oBusca.Show()
4045:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr3")
4046:                         loc_oPg2.txt_4c_GrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Codigos)
4047:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
4048:                             loc_oPg2.txt_4c_DGrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Descrs)
4049:                         ENDIF
4050:                     ELSE
4051:                         loc_oPg2.txt_4c_GrpCad3.Value = ""
4052:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)

*-- Linhas 4092 a 4111:
4092:                 RETURN
4093:             ENDIF
4094: 
4095:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
4096:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr4")
4097:             IF loc_nResult > 0
4098:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4099:                 IF VARTYPE(loc_oBusca) = "O"
4100:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr4"
4101:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4102:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4103:                     loc_oBusca.Show()
4104:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr4")
4105:                         loc_oPg2.txt_4c_GrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Codigos)
4106:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
4107:                             loc_oPg2.txt_4c_DGrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Descrs)
4108:                         ENDIF
4109:                     ELSE
4110:                         loc_oPg2.txt_4c_GrpCad4.Value = ""
4111:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)

*-- Linhas 4140 a 4167:
4140:                 RETURN
4141:             ENDIF
4142: 
4143:             loc_cSQL    = "SELECT TOP 1 Classes FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 AND Classes = " + EscaparSQL(loc_cCod)
4144:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss1")
4145:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaCss1")
4146:                 loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
4147:             ELSE
4148:                 IF USED("cursor_4c_BuscaCss1")
4149:                     USE IN cursor_4c_BuscaCss1
4150:                 ENDIF
4151:                 loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4152:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss1")
4153:                 IF loc_nResult > 0
4154:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4155:                     IF VARTYPE(loc_oBusca) = "O"
4156:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss1"
4157:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4158:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4159:                         loc_oBusca.Show()
4160:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss1")
4161:                             loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
4162:                         ELSE
4163:                             loc_oPg2.txt_4c_Class1.Value = ""
4164:                         ENDIF
4165:                         loc_oBusca.Release()
4166:                     ENDIF
4167:                 ENDIF

*-- Linhas 4191 a 4218:
4191:                 RETURN
4192:             ENDIF
4193: 
4194:             loc_cSQL    = "SELECT TOP 1 Classes FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 AND Classes = " + EscaparSQL(loc_cCod)
4195:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss2")
4196:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaCss2")
4197:                 loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
4198:             ELSE
4199:                 IF USED("cursor_4c_BuscaCss2")
4200:                     USE IN cursor_4c_BuscaCss2
4201:                 ENDIF
4202:                 loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4203:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss2")
4204:                 IF loc_nResult > 0
4205:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4206:                     IF VARTYPE(loc_oBusca) = "O"
4207:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss2"
4208:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4209:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4210:                         loc_oBusca.Show()
4211:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss2")
4212:                             loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
4213:                         ELSE
4214:                             loc_oPg2.txt_4c_Class2.Value = ""
4215:                         ENDIF
4216:                         loc_oBusca.Release()
4217:                     ENDIF
4218:                 ENDIF

*-- Linhas 4242 a 4269:
4242:                 RETURN
4243:             ENDIF
4244: 
4245:             loc_cSQL    = "SELECT TOP 1 Classes FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 AND Classes = " + EscaparSQL(loc_cCod)
4246:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss3")
4247:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaCss3")
4248:                 loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
4249:             ELSE
4250:                 IF USED("cursor_4c_BuscaCss3")
4251:                     USE IN cursor_4c_BuscaCss3
4252:                 ENDIF
4253:                 loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4254:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss3")
4255:                 IF loc_nResult > 0
4256:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4257:                     IF VARTYPE(loc_oBusca) = "O"
4258:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss3"
4259:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4260:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4261:                         loc_oBusca.Show()
4262:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss3")
4263:                             loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
4264:                         ELSE
4265:                             loc_oPg2.txt_4c_Class3.Value = ""
4266:                         ENDIF
4267:                         loc_oBusca.Release()
4268:                     ENDIF
4269:                 ENDIF

*-- Linhas 4293 a 4320:
4293:                 RETURN
4294:             ENDIF
4295: 
4296:             loc_cSQL    = "SELECT TOP 1 Classes FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 AND Classes = " + EscaparSQL(loc_cCod)
4297:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss4")
4298:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaCss4")
4299:                 loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
4300:             ELSE
4301:                 IF USED("cursor_4c_BuscaCss4")
4302:                     USE IN cursor_4c_BuscaCss4
4303:                 ENDIF
4304:                 loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4305:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss4")
4306:                 IF loc_nResult > 0
4307:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4308:                     IF VARTYPE(loc_oBusca) = "O"
4309:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss4"
4310:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4311:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4312:                         loc_oBusca.Show()
4313:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss4")
4314:                             loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
4315:                         ELSE
4316:                             loc_oPg2.txt_4c_Class4.Value = ""
4317:                         ENDIF
4318:                         loc_oBusca.Release()
4319:                     ENDIF
4320:                 ENDIF


### BO (C:\4c\projeto\app\classes\OTIBO.prg):
*==============================================================================
* OTIBO.prg - Business Object para Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos
* Tabela principal: SigOpOpe (PK: dopes char(20))
* Tabela secund" + CHR(225) + "ria: SigCdPrg (acessos por opera" + CHR(231) + CHR(227) + "o)
* Migrado de: sigCDOTI.SCX
*==============================================================================

DEFINE CLASS OTIBO AS BusinessBase

    *-- Identifica" + CHR(231) + CHR(227) + "o do registro
    this_cDopes      = ""   && dopes      PK char(20) - descri" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o
    this_nNdopes     = 0    && ndopes     auto-gerado numeric(10,0)
    this_cOpers      = "CR" && opers      CR=cr" + CHR(233) + "dito / DB=d" + CHR(233) + "bito char(2)
    this_nOpeCancs   = 0    && opecancs   0=Ativo / 1=Cancelado numeric(1,0)

    *-- Opera" + CHR(231) + CHR(245) + "es relacionadas
    this_cDopereals  = ""   && dopereals  opera" + CHR(231) + CHR(227) + "o Realizado char(20)
    this_cDopCancs   = ""   && dopcancs   opera" + CHR(231) + CHR(227) + "o Cancelamento char(20)
    this_cOpdepos    = ""   && opdepos    opera" + CHR(231) + CHR(227) + "o Dep" + CHR(243) + "sito char(15)

    *-- Hist" + CHR(243) + "rico e texto
    this_cHists      = ""   && hists      hist" + CHR(243) + "rico padr" + CHR(227) + "o char(30)
    this_nTpHists    = 2    && tphists    tipo hist" + CHR(243) + "rico numeric(1,0)
    this_cIdentifics = ""   && identifics identificador char(1)
    this_cPastas     = ""   && pastas     caminho pasta (text NULL)

    *-- Configura" + CHR(231) + CHR(227) + "o do t" + CHR(237) + "tulo
    this_nDiasVcto   = 0    && diasvcto   dias vencimento numeric(2,0)
    this_nQtdBols    = 0    && qtdbols    qtd vias boleto numeric(2,0)
    this_cCnMascaras = ""   && cnmascaras m" + CHR(225) + "scara NF char(10)
    this_nJuros      = 0    && juros      juros di" + CHR(225) + "rio (%) numeric(4,2)
    this_cMoedas     = ""   && moedas     moeda totalizador char(3)
    this_nVlrLimApv  = 0    && vlrlimapv  valor limite aprova" + CHR(231) + CHR(227) + "o numeric(11,2)

    *-- Op" + CHR(231) + CHR(245) + "es (OptionGroups, valor 1-indexed)
    this_nDadosPgs   = 1    && dadospgs   dados pagamento numeric(1,0)
    this_nCampoNfs   = 1    && camponfs   campo NF numeric(1,0)
    this_nBlqccs     = 2    && blqccs     bloquear C/C numeric(1,0)
    this_nPendencias = 1    && pendencias pend" + CHR(234) + "ncias numeric(1,0)
    this_nRealprevs  = 1    && realprevs  real/previsto numeric(1,0)
    this_nEmiPorDesp = 2    && emipordesp emitente=portador numeric(1,0)
    this_nValprev    = 2    && valprev    valor previsto numeric(1,0)
    this_nTitauts    = 1    && titauts    n" + CHR(186) + " t" + CHR(237) + "tulo autom" + CHR(225) + "tico numeric(1,0)
    this_nImpbols    = 2    && impbols    imprime boleto numeric(1,0)
    this_nCompets    = 1    && compets    compet" + CHR(234) + "ncia numeric(1,0)
    this_nAltTrans   = 1    && alttrans   realizar apenas autorizados numeric(1,0)
    this_nOutTits    = 2    && outtits    outros t" + CHR(237) + "tulos auto numeric(1,0)
    this_nFiltContas = 2    && filtcontas filtra conta p/ grupo numeric(1,0)
    this_nJobs       = 2    && jobs       jobs numeric(1,0)
    this_nImpdocs    = 2    && impdocs    imprime documento numeric(1,0)
    this_nLimcres    = 2    && limcres    checar limite cr" + CHR(233) + "dito numeric(1,0)

    *-- Grupos padr" + CHR(227) + "o
    this_cGrupo1s    = ""   && grupo1s    emitente char(10)
    this_cGrupo2s    = ""   && grupo2s    portador char(10)
    this_cGrupo3s    = ""   && grupo3s    centro de custo char(10)
    this_cGrupo4s    = ""   && grupo4s    agente cobrador char(10)

    *-- Grupos cadastrais
    this_cGrpCad1s   = ""   && grpcad1s   grupo cadastral 1 char(10)
    this_cGrpCad2s   = ""   && grpcad2s   grupo cadastral 2 char(10)
    this_cGrpCad3s   = ""   && grpcad3s   grupo cadastral 3 char(10)
    this_cGrpCad4s   = ""   && grpcad4s   grupo cadastral 4 char(10)
    this_cDGrpCad1s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 1
    this_cDGrpCad2s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 2
    this_cDGrpCad3s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 3
    this_cDGrpCad4s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 4

    *-- Classes cont" + CHR(225) + "beis char(1) - armazenadas como char no banco
    this_cClass1s    = ""   && class1s    classe cont" + CHR(225) + "bil 1 char(1)
    this_cClass2s    = ""   && class2s    classe cont" + CHR(225) + "bil 2 char(1)
    this_cClass3s    = ""   && class3s    classe cont" + CHR(225) + "bil 3 char(1)
    this_cClass4s    = ""   && class4s    classe cont" + CHR(225) + "bil 4 char(1)

    *-- T" + CHR(237) + "tulos dos campos
    this_cTxt01      = ""   && txt01      t" + CHR(237) + "tulo campo emitente char(15)
    this_cTxt02      = ""   && txt02      t" + CHR(237) + "tulo campo portador char(15)
    this_cTxt03      = ""   && txt03      t" + CHR(237) + "tulo campo centro custo char(15)
    this_cTxt04      = ""   && txt04      t" + CHR(237) + "tulo campo agente cobrador char(15)

    *-- Checkboxes (l" + CHR(243) + "gico; congvs=bit no banco, demais=numeric 0/1)
    this_lCongvs     = .F.  && congvs     bit NOT NULL
    this_lBlqTits    = .F.  && blqtits    numeric(1,0) NOT NULL
    this_lEspobrigs  = .F.  && espobrigs  numeric(1,0) NOT NULL
    this_lLancCCEs   = .F.  && lancCCEs   numeric(1,0) NOT NULL
    this_lLancCCAs   = .F.  && lancCCAs   numeric(1,0) NOT NULL
    this_lObsobrigs  = .F.  && obsobrigs  numeric(1,0) NOT NULL
    this_lObrigC1    = .F.  && obrigc1    numeric(1,0) NOT NULL
    this_lObrigC2    = .F.  && obrigc2    numeric(1,0) NOT NULL
    this_lObrigC3    = .F.  && obrigc3    numeric(1,0) NOT NULL
    this_lObrigC4    = .F.  && obrigc4    numeric(1,0) NOT NULL
    this_lObrCompet  = .F.  && obrcompet  numeric(1,0) NOT NULL

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpOpe"
            THIS.this_cCampoChave = "NDopes"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(TRANSFORM(THIS.this_nNdopes))
    ENDPROC

    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE UPPER(dopes) LIKE '%" + UPPER(par_cFiltro) + "%'"
            ENDIF

            loc_cSQL = "SELECT dopes, opers, ndopes FROM SigOpOpe" + loc_cWhere + " ORDER BY dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (dopes C(20), opers C(2), ndopes N(10,0))
                ENDIF
                IF !EOF("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(par_nCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Reg")

            IF loc_nResult >= 0 AND !EOF("cursor_4c_Reg")
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Reg")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.CarregarPorCodigo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cDopes      = ALLTRIM(dopes)
            THIS.this_nNdopes     = ndopes
            THIS.this_cOpers      = ALLTRIM(opers)
            THIS.this_nOpeCancs   = opecancs
            THIS.this_cDopereals  = ALLTRIM(dopereals)
            THIS.this_cDopCancs   = ALLTRIM(dopcancs)
            THIS.this_cOpdepos    = ALLTRIM(opdepos)
            THIS.this_cHists      = ALLTRIM(hists)
            THIS.this_nTpHists    = tphists
            THIS.this_cIdentifics = ALLTRIM(identifics)
            THIS.this_cPastas     = IIF(ISNULL(pastas), "", ALLTRIM(pastas))
            THIS.this_nDiasVcto   = diasvcto
            THIS.this_nQtdBols    = qtdbols
            THIS.this_cCnMascaras = ALLTRIM(cnmascaras)
            THIS.this_nJuros      = juros
            THIS.this_cMoedas     = ALLTRIM(moedas)
            THIS.this_nVlrLimApv  = vlrlimapv
            THIS.this_nDadosPgs   = dadospgs
            THIS.this_nCampoNfs   = camponfs
            THIS.this_nBlqccs     = blqccs
            THIS.this_nPendencias = pendencias
            THIS.this_nRealprevs  = realprevs
            THIS.this_nEmiPorDesp = emipordesp
            THIS.this_nValprev    = valprev
            THIS.this_nTitauts    = titauts
            THIS.this_nImpbols    = impbols
            THIS.this_nCompets    = compets
            THIS.this_nAltTrans   = alttrans
            THIS.this_nOutTits    = outtits
            THIS.this_nFiltContas = filtcontas
            THIS.this_nJobs       = jobs
            THIS.this_nImpdocs    = impdocs
            THIS.this_nLimcres    = limcres
            THIS.this_cGrupo1s    = ALLTRIM(grupo1s)
            THIS.this_cGrupo2s    = ALLTRIM(grupo2s)
            THIS.this_cGrupo3s    = ALLTRIM(grupo3s)
            THIS.this_cGrupo4s    = ALLTRIM(grupo4s)
            THIS.this_cGrpCad1s   = ALLTRIM(grpcad1s)
            THIS.this_cGrpCad2s   = ALLTRIM(grpcad2s)
            THIS.this_cGrpCad3s   = ALLTRIM(grpcad3s)
            THIS.this_cGrpCad4s   = ALLTRIM(grpcad4s)
            THIS.this_cClass1s    = ALLTRIM(class1s)
            THIS.this_cClass2s    = ALLTRIM(class2s)
            THIS.this_cClass3s    = ALLTRIM(class3s)
            THIS.this_cClass4s    = ALLTRIM(class4s)
            THIS.this_cTxt01      = ALLTRIM(txt01)
            THIS.this_cTxt02      = ALLTRIM(txt02)
            THIS.this_cTxt03      = ALLTRIM(txt03)
            THIS.this_cTxt04      = ALLTRIM(txt04)
            THIS.this_lCongvs     = (congvs <> 0)
            THIS.this_lBlqTits    = (blqtits <> 0)
            THIS.this_lEspobrigs  = (espobrigs <> 0)
            THIS.this_lLancCCEs   = (lancCCEs <> 0)
            THIS.this_lLancCCAs   = (lancCCAs <> 0)
            THIS.this_lObsobrigs  = (obsobrigs <> 0)
            THIS.this_lObrigC1    = (obrigc1 <> 0)
            THIS.this_lObrigC2    = (obrigc2 <> 0)
            THIS.this_lObrigC3    = (obrigc3 <> 0)
            THIS.this_lObrigC4    = (obrigc4 <> 0)
            THIS.this_lObrCompet  = (obrcompet <> 0)

            THIS.this_cDGrpCad1s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad1s)
            THIS.this_cDGrpCad2s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad2s)
            THIS.this_cDGrpCad3s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad3s)
            THIS.this_cDGrpCad4s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad4s)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ValidarDados()
    *==========================================================================
        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF THIS.this_nRealprevs = 2 AND EMPTY(THIS.this_cDopereals)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Realizado obrigat" + CHR(243) + "ria quando tipo Previsto.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION VerificarCodigoDuplicado()
    *==========================================================================
        LOCAL loc_nCount, loc_nResult
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigOpOpe WHERE dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes)), ;
                "cursor_4c_Dup")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Dup")
                loc_nCount = cursor_4c_Dup.total
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN (loc_nCount > 0)
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterProximoNdopes()
    *==========================================================================
        LOCAL loc_nProximo, loc_nResult
        loc_nProximo = 1

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ndopes),0)+1 AS proximo FROM SigOpOpe", ;
                "cursor_4c_NxtN")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_NxtN")
                loc_nProximo = cursor_4c_NxtN.proximo
            ENDIF
            IF USED("cursor_4c_NxtN")
                USE IN cursor_4c_NxtN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nProximo
    ENDPROC

    *==========================================================================
    FUNCTION BuscarDescricaoGrpCad(par_cCodigo)
    *==========================================================================
        LOCAL loc_cDescr, loc_nResult
        loc_cDescr = ""

        IF EMPTY(par_cCodigo)
            RETURN ""
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_Gcr")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Gcr")
                loc_cDescr = ALLTRIM(cursor_4c_Gcr.descrs)
            ENDIF
            IF USED("cursor_4c_Gcr")
                USE IN cursor_4c_Gcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescr
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InserirSigCdPrgSeNaoExiste(par_cProg, par_cParam, par_cDesc, par_cBarraForms)
    *==========================================================================
        LOCAL loc_nCount, loc_nResult, loc_cSQL
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigCdPrg " + ;
                "WHERE Programas = " + EscaparSQL(par_cProg) + ;
                " AND RTRIM(Parametros) = " + EscaparSQL(RTRIM(par_cParam)), ;
                "cursor_4c_ChkPrg")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_ChkPrg")
                loc_nCount = cursor_4c_ChkPrg.total
            ENDIF
            IF USED("cursor_4c_ChkPrg")
                USE IN cursor_4c_ChkPrg
            ENDIF

            IF loc_nCount = 0
                loc_cSQL = "INSERT INTO SigCdPrg " + ;
                    "(Descricaos, Parametros, Programas, pkChaves, barraforms, barrapict) VALUES (" + ;
                    EscaparSQL(par_cDesc)       + ", " + ;
                    EscaparSQL(par_cParam)      + ", " + ;
                    EscaparSQL(par_cProg)       + ", " + ;
                    EscaparSQL(fUniqueIds())    + ", " + ;
                    EscaparSQL(par_cBarraForms) + ", " + ;
                    "''" + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarEntradasSigCdPrg(par_cDopes, par_nNdopes)
    *==========================================================================
        LOCAL loc_cProg, loc_cDesc, loc_cBarra
        loc_cProg  = "C" + PADL(TRANSFORM(par_nNdopes), 8, "0")
        loc_cDesc  = "Menu - Financeiro - T" + CHR(237) + "tulos - " + PROPER(ALLTRIM(par_cDopes))
        loc_cBarra = "SIGPGTIT WITH '" + ALLTRIM(par_cDopes) + "'"

        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "",          loc_cDesc,                                                                               loc_cBarra)
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "INSERIR",   loc_cDesc + " - [Inserir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAR",   loc_cDesc + " - [Alterar]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "EXCLUIR",   loc_cDesc + " - [Excluir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAR",    loc_cDesc + " - [Listar]",                                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TITULO",    loc_cDesc + " - [T" + CHR(237) + "tulo]",                                               "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OCORR",     loc_cDesc + " - [Ocorr" + CHR(234) + "ncias]",                                          "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTDATAS",  loc_cDesc + " - [Alterar Datas]",                                                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBVENCS",  loc_cDesc + " - [N" + CHR(227) + "o Checa Vcto. X Emiss" + CHR(227) + "o]",             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFREAL",   loc_cDesc + " - [Transfere para C/C]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAGERAL",loc_cDesc + " - [Lista Geral]",                                                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFPREV",   loc_cDesc + " - [Transfere p/ Previs" + CHR(227) + "o]",                                "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTCC",     loc_cDesc + " - [Altera Centro de Custo]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CANCELA",   loc_cDesc + " - [Cancelamento do T" + CHR(237) + "tulo ]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "PRORROGAR", loc_cDesc + " - [Prorrogar T" + CHR(237) + "tulo ]",                                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CONFERIR",  loc_cDesc + " - [Conferir T" + CHR(237) + "tulo ]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAAGC", loc_cDesc + " - [Altera Agente Cobrador]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "AUTOBLQ",   loc_cDesc + " - [Inibir Alerta de Fora do Per" + CHR(237) + "odo]",                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIMPADTT",  loc_cDesc + " - [Desmarca Transporte]",                                                 "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "SUBSTITUI", loc_cDesc + " - [Substitui" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulo]",      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUP",  loc_cDesc + " - [Follow up de Conta]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUPI", loc_cDesc + " - [Follow up de Lan" + CHR(231) + "amento]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLOQVENCS", loc_cDesc + " - [Bloqueio de T" + CHR(237) + "tulos Vencidos]",                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTARQCON", loc_cDesc + " - [Altera Arq. Relac. na Consulta]",                                      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLQDTLANC", loc_cDesc + " - [N" + CHR(227) + "o Altera Data de Lan" + CHR(231) + "amento]",         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "MULTIAPROV",loc_cDesc + " - [Permite Aprovar Mais de um T" + CHR(237) + "tulo]",                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "APVVLRSUP", loc_cDesc + " - [Permite Aprovar Um T" + CHR(237) + "tulo Com Valor Acima do Permitido.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAVENC",loc_cDesc + " - [Permite Prorrogar o Vencimento.]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OUTRESPONS",loc_cDesc + " - [Permite Aprovar T" + CHR(237) + "tulos de Outros Respons" + CHR(225) + "veis.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OBSRESUMO", loc_cDesc + " - [Observa" + CHR(231) + CHR(227) + "o resumida.]",                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBAPROV",  loc_cDesc + " - [Permite Alterar T" + CHR(237) + "tulos Aprovados.]",                   "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBCARTAO", loc_cDesc + " - [Libera Visualizar Cart" + CHR(245) + "es.]",                           "")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_nNdopes = THIS.ObterProximoNdopes()

            loc_cSQL = "INSERT INTO SigOpOpe (" + ;
                "dopes, ndopes, ordes, datas, opers, " + ;
                "opdepos, hists, tphists, fixgrupes, grupoeps, identifics, " + ;
                "titauts, txt01, txt02, txt03, txt04, impbols, " + ;
                "grupo1s, grupo2s, grupo3s, grupo4s, " + ;
                "grpcad1s, grpcad2s, grpcad3s, grpcad4s, " + ;
                "valprev, qtdbols, compets, congvs, " + ;
                "dopereals, pendencias, realprevs, blqccs, alttrans, bloqueios, " + ;
                "impdocs, cnmascaras, dopcancs, opecancs, " + ;
                "blqtits, outtits, soldocs, camponfs, dadospgs, espobrigs, " + ;
                "juros, filtcontas, lancCCAs, lancCCEs, obsobrigs, jobs, " + ;
                "class1s, class2s, class3s, class4s, buscanome, " + ;
                "diasvcto, emipordesp, limcres, moedas, obrcompet, " + ;
                "obrigc1, obrigc2, obrigc3, obrigc4, " + ;
                "pastas, vlrlimapv, InibEmpHst, edthists, rateiocf" + ;
                ") VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdopes)        + ", " + ;
                "0, GETDATE(), "                           + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpers))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpdepos))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cHists))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpHists)       + ", " + ;
                "0, '', "                                  + ;
                EscaparSQL(ALLTRIM(THIS.this_cIdentifics))  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTitauts)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt01))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt02))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt03))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt04))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpbols)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nValprev)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdBols)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nCompets)       + ", " + ;
                IIF(THIS.this_lCongvs,   "1", "0")         + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopereals))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPendencias)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nRealprevs)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqccs)        + ", " + ;
                FormatarNumeroSQL(THIS.this_nAltTrans)      + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nImpdocs)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCnMascaras))  + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopCancs))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOpeCancs)      + ", " + ;
                IIF(THIS.this_lBlqTits,   "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nOutTits)       + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nCampoNfs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nDadosPgs)      + ", " + ;
                IIF(THIS.this_lEspobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJuros)         + ", " + ;
                FormatarNumeroSQL(THIS.this_nFiltContas)    + ", " + ;
                IIF(THIS.this_lLancCCAs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lLancCCEs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lObsobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJobs)          + ", " + ;
                EscaparSQL(THIS.this_cClass1s)              + ", " + ;
                EscaparSQL(THIS.this_cClass2s)              + ", " + ;
                EscaparSQL(THIS.this_cClass3s)              + ", " + ;
                EscaparSQL(THIS.this_cClass4s)              + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nDiasVcto)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmiPorDesp)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLimcres)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoedas))      + ", " + ;
                IIF(THIS.this_lObrCompet, "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC1,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC2,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC3,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC4,   "1", "0")        + ", " + ;
                IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrLimApv)    + ", " + ;
                "0, 0, 0)"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOpe SET " + ;
                "opers       = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))      + ", " + ;
                "opdepos     = " + EscaparSQL(ALLTRIM(THIS.this_cOpdepos))    + ", " + ;
                "hists       = " + EscaparSQL(ALLTRIM(THIS.this_cHists))      + ", " + ;
                "tphists     = " + FormatarNumeroSQL(THIS.this_nTpHists)      + ", " + ;
                "identifics  = " + EscaparSQL(ALLTRIM(THIS.this_cIdentifics)) + ", " + ;
                "titauts     = " + FormatarNumeroSQL(THIS.this_nTitauts)      + ", " + ;
                "txt01       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt01))      + ", " + ;
                "txt02       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt02))      + ", " + ;
                "txt03       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt03))      + ", " + ;
                "txt04       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt04))      + ", " + ;
                "impbols     = " + FormatarNumeroSQL(THIS.this_nImpbols)      + ", " + ;
                "grupo1s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))    + ", " + ;
                "grupo2s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))    + ", " + ;
                "grupo3s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))    + ", " + ;
                "grupo4s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))    + ", " + ;
                "grpcad1s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))   + ", " + ;
                "grpcad2s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))   + ", " + ;
                "grpcad3s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))   + ", " + ;
                "grpcad4s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))   + ", " + ;
                "valprev     = " + FormatarNumeroSQL(THIS.this_nValprev)      + ", " + ;
                "qtdbols     = " + FormatarNumeroSQL(THIS.this_nQtdBols)      + ", " + ;
                "compets     = " + FormatarNumeroSQL(THIS.this_nCompets)      + ", " + ;
                "congvs      = " + IIF(THIS.this_lCongvs,   "1", "0")        + ", " + ;
                "dopereals   = " + EscaparSQL(ALLTRIM(THIS.this_cDopereals))  + ", " + ;
                "pendencias  = " + FormatarNumeroSQL(THIS.this_nPendencias)   + ", " + ;
                "realprevs   = " + FormatarNumeroSQL(THIS.this_nRealprevs)    + ", " + ;
                "blqccs      = " + FormatarNumeroSQL(THIS.this_nBlqccs)       + ", " + ;
                "alttrans    = " + FormatarNumeroSQL(THIS.this_nAltTrans)     + ", " + ;
                "impdocs     = " + FormatarNumeroSQL(THIS.this_nImpdocs)      + ", " + ;
                "cnmascaras  = " + EscaparSQL(ALLTRIM(THIS.this_cCnMascaras)) + ", " + ;
                "dopcancs    = " + EscaparSQL(ALLTRIM(THIS.this_cDopCancs))   + ", " + ;
                "blqtits     = " + IIF(THIS.this_lBlqTits,   "1", "0")       + ", " + ;
                "outtits     = " + FormatarNumeroSQL(THIS.this_nOutTits)      + ", " + ;
                "camponfs    = " + FormatarNumeroSQL(THIS.this_nCampoNfs)     + ", " + ;
                "dadospgs    = " + FormatarNumeroSQL(THIS.this_nDadosPgs)     + ", " + ;
                "espobrigs   = " + IIF(THIS.this_lEspobrigs, "1", "0")       + ", " + ;
                "juros       = " + FormatarNumeroSQL(THIS.this_nJuros)        + ", " + ;
                "filtcontas  = " + FormatarNumeroSQL(THIS.this_nFiltContas)   + ", " + ;
                "lancCCAs    = " + IIF(THIS.this_lLancCCAs,  "1", "0")       + ", " + ;
                "lancCCEs    = " + IIF(THIS.this_lLancCCEs,  "1", "0")       + ", " + ;
                "obsobrigs   = " + IIF(THIS.this_lObsobrigs, "1", "0")       + ", " + ;
                "jobs        = " + FormatarNumeroSQL(THIS.this_nJobs)         + ", " + ;
                "class1s     = " + EscaparSQL(THIS.this_cClass1s)             + ", " + ;
                "class2s     = " + EscaparSQL(THIS.this_cClass2s)             + ", " + ;
                "class3s     = " + EscaparSQL(THIS.this_cClass3s)             + ", " + ;
                "class4s     = " + EscaparSQL(THIS.this_cClass4s)             + ", " + ;
                "diasvcto    = " + FormatarNumeroSQL(THIS.this_nDiasVcto)     + ", " + ;
                "emipordesp  = " + FormatarNumeroSQL(THIS.this_nEmiPorDesp)   + ", " + ;
                "limcres     = " + FormatarNumeroSQL(THIS.this_nLimcres)      + ", " + ;
                "moedas      = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas))     + ", " + ;
                "obrcompet   = " + IIF(THIS.this_lObrCompet, "1", "0")       + ", " + ;
                "obrigc1     = " + IIF(THIS.this_lObrigC1,   "1", "0")       + ", " + ;
                "obrigc2     = " + IIF(THIS.this_lObrigC2,   "1", "0")       + ", " + ;
                "obrigc3     = " + IIF(THIS.this_lObrigC3,   "1", "0")       + ", " + ;
                "obrigc4     = " + IIF(THIS.this_lObrigC4,   "1", "0")       + ", " + ;
                "pastas      = " + IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                "vlrlimapv   = " + FormatarNumeroSQL(THIS.this_nVlrLimApv)   + ;
                " WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes)))
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.ExecutarExclusao")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursors[8], loc_i
        loc_aCursors[1] = "cursor_4c_Dados"
        loc_aCursors[2] = "cursor_4c_Reg"
        loc_aCursors[3] = "cursor_4c_Dup"
        loc_aCursors[4] = "cursor_4c_NxtN"
        loc_aCursors[5] = "cursor_4c_Gcr"
        loc_aCursors[6] = "cursor_4c_ChkPrg"
        loc_aCursors[7] = "cursor_4c_Lista"
        loc_aCursors[8] = "cursor_4c_Busca"
        FOR loc_i = 1 TO 8
            IF USED(loc_aCursors[loc_i])
                USE IN (loc_aCursors[loc_i])
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE

