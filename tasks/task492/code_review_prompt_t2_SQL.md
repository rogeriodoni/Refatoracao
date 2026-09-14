# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NDOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IGUA, REALPREVS, LNPOS, OPECANCS, PROGRAMAS, OPERACAOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOTI.prg) - TRECHOS RELEVANTES PARA PASS SQL (4435 linhas total):

*-- Linhas 346 a 364:
346:             .HighlightBackColor = RGB(255, 255, 255)
347:             .HighlightForeColor = RGB(15, 41, 104)
348:             .HighlightStyle     = 2
349:             .DeleteMark         = .F.
350:             .RecordMark         = .F.
351:             .RowHeight          = 16
352:             .ScrollBars         = 2
353:             .GridLines          = 3
354:             .ReadOnly           = .T.
355:             .Visible            = .T.
356:         ENDWITH
357: 
358:         WITH loc_oGrid.Column1
359:             .Width           = 60
360:             .Alignment       = 0
361:             .Header1.Caption = "N" + CHR(186)
362:             .Resizable       = .T.
363:         ENDWITH
364: 

*-- Linhas 2465 a 2485:
2465:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2466:                         loc_oGrid.ColumnCount = 3
2467:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2468:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ndopes"
2469:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
2470:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Opers"
2471:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(186)
2472:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2473:                         loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2474:                         THIS.FormatarGridLista(loc_oGrid)
2475:                     ENDIF
2476:                 ENDIF
2477:             CATCH TO loc_oErro
2478:                 MsgErro(loc_oErro.Message, "FormOTI.CarregarLista")
2479:                 loc_lResultado = .F.
2480:             ENDTRY
2481:         ENDIF
2482: 
2483:         RETURN loc_lResultado
2484:     ENDPROC
2485: 

*-- Linhas 2519 a 2538:
2519: 
2520:         TRY
2521:             *-- Gerar pr" + CHR(243) + "ximo Ndope via MAX+1
2522:             loc_nResult = SQLEXEC(gnConnHandle, ;
2523:                 "SELECT ISNULL(MAX(Ndopes),0)+1 AS ProxNdope FROM SigOpOpe", ;
2524:                 "cursor_4c_NdopeTmp")
2525:             IF loc_nResult > 0 AND !EOF("cursor_4c_NdopeTmp")
2526:                 loc_nNdope = cursor_4c_NdopeTmp.ProxNdope
2527:             ELSE
2528:                 loc_nNdope = 1
2529:             ENDIF
2530:             IF USED("cursor_4c_NdopeTmp")
2531:                 USE IN cursor_4c_NdopeTmp
2532:             ENDIF
2533: 
2534:             THIS.this_oBusinessObject.NovoRegistro()
2535:             THIS.this_oBusinessObject.this_nNdopes = loc_nNdope
2536:             THIS.LimparCampos()
2537:             THIS.this_cModoAtual = "INCLUIR"
2538:             THIS.HabilitarCampos(.T.)

*-- Linhas 2565 a 2583:
2565:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2566:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
2567:             ELSE
2568:                 SELECT cursor_4c_Dados
2569:                 loc_nNdopes = cursor_4c_Dados.Ndopes
2570:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2571:                     THIS.this_cModoAtual = "VISUALIZAR"
2572:                     THIS.HabilitarCampos(.F.)
2573:                     THIS.AjustarBotoesPorModo()
2574:                     THIS.BOParaForm()
2575:                     THIS.pgf_4c_Paginas.ActivePage = 2
2576:                     loc_lResultado = .T.
2577:                 ELSE
2578:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "FormOTI")
2579:                 ENDIF
2580:             ENDIF
2581:         CATCH TO loc_oErro
2582:             MsgErro(loc_oErro.Message, "FormOTI.BtnVisualizarClick")
2583:         ENDTRY

*-- Linhas 2595 a 2613:
2595:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2596:                 MsgAviso("Selecione um registro na lista.", "Alterar")
2597:             ELSE
2598:                 SELECT cursor_4c_Dados
2599:                 loc_nNdopes = cursor_4c_Dados.Ndopes
2600:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2601:                     THIS.this_oBusinessObject.EditarRegistro()
2602:                     THIS.this_cModoAtual = "ALTERAR"
2603:                     THIS.HabilitarCampos(.T.)
2604:                     THIS.AjustarBotoesPorModo()
2605:                     THIS.BOParaForm()
2606:                     THIS.pgf_4c_Paginas.ActivePage = 2
2607:                     loc_lResultado = .T.
2608:                 ELSE
2609:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "FormOTI")
2610:                 ENDIF
2611:             ENDIF
2612:         CATCH TO loc_oErro
2613:             MsgErro(loc_oErro.Message, "FormOTI.BtnAlterarClick")

*-- Linhas 2626 a 2644:
2626:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2627:                 MsgAviso("Selecione um registro na lista.", "Excluir")
2628:             ELSE
2629:                 SELECT cursor_4c_Dados
2630:                 loc_nNdopes   = cursor_4c_Dados.Ndopes
2631:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o selecionada?", "Excluir")
2632:                 IF loc_lConfirma
2633:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2634:                         IF THIS.this_oBusinessObject.Excluir()
2635:                             MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!", "Excluir")
2636:                             THIS.CarregarLista()
2637:                             loc_lResultado = .T.
2638:                         ELSE
2639:                             MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o.", "FormOTI")
2640:                         ENDIF
2641:                     ELSE
2642:                         MsgErro("Erro ao localizar registro para exclus" + CHR(227) + "o.", "FormOTI")
2643:                     ENDIF
2644:                 ENDIF

*-- Linhas 2658 a 2695:
2658: 
2659:         TRY
2660:             LOCAL loc_nResult
2661:             loc_nResult = SQLEXEC(gnConnHandle, ;
2662:                 "SELECT Ndopes, Dopes, Opers FROM SigOpOpe ORDER BY Dopes", ;
2663:                 "cursor_4c_BuscaOpe")
2664: 
2665:             IF loc_nResult > 0
2666:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2667:             ENDIF
2668: 
2669:             IF VARTYPE(loc_oBusca) = "O"
2670:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
2671:                 loc_oBusca.mAddColuna("Ndopes", "", "N" + CHR(186))
2672:                 loc_oBusca.mAddColuna("Dopes",  "", "Descri" + CHR(231) + CHR(227) + "o")
2673:                 loc_oBusca.mAddColuna("Opers",  "", "Opera" + CHR(231) + CHR(227) + "o")
2674:                 loc_oBusca.Show()
2675: 
2676:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
2677:                     loc_nNdope = cursor_4c_BuscaOpe.Ndopes
2678:                     THIS.CarregarLista()
2679:                     IF USED("cursor_4c_Dados")
2680:                         SELECT cursor_4c_Dados
2681:                         LOCATE FOR cursor_4c_Dados.Ndopes = loc_nNdope
2682:                     ENDIF
2683:                     loc_lResultado = .T.
2684:                 ENDIF
2685: 
2686:                 loc_oBusca.Release()
2687:             ENDIF
2688:         CATCH TO loc_oErro
2689:             MsgErro(loc_oErro.Message, "FormOTI.BtnBuscarClick")
2690:         ENDTRY
2691: 
2692:         IF USED("cursor_4c_BuscaOpe")
2693:             USE IN cursor_4c_BuscaOpe
2694:         ENDIF
2695: 

*-- Linhas 3644 a 3673:
3644:             ENDIF
3645: 
3646:             *-- Testa match exato
3647:             loc_cSQL    = "SELECT TOP 1 Operacaos FROM SigCdOpt WHERE Operacaos = " + EscaparSQL(loc_cOpdepo)
3648:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpt")
3649:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaOpt")
3650:                 RETURN
3651:             ENDIF
3652: 
3653:             *-- Sem match exato - abre picker com todos registros
3654:             IF USED("cursor_4c_BuscaOpt")
3655:                 USE IN cursor_4c_BuscaOpt
3656:             ENDIF
3657:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
3658:                 "SELECT Operacaos, Descrs FROM SigCdOpt ORDER BY Operacaos", ;
3659:                 "cursor_4c_BuscaOpt")
3660:             IF VARTYPE(loc_oBusca) = "O"
3661:                 loc_oBusca.mAddColuna("Operacaos", "", "C" + CHR(243) + "digo")
3662:                 loc_oBusca.mAddColuna("Descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
3663:                 loc_oBusca.Show()
3664:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
3665:                     loc_oPg2.txt_4c_Opdepo.Value = ALLTRIM(cursor_4c_BuscaOpt.Operacaos)
3666:                 ELSE
3667:                     loc_oPg2.txt_4c_Opdepo.Value = ""
3668:                 ENDIF
3669:                 loc_oBusca.Release()
3670:             ENDIF
3671: 
3672:         CATCH TO loc_oErro
3673:             MsgErro(loc_oErro.Message, "FormOTI.ValidarOpdepo")

*-- Linhas 3693 a 3715:
3693:                 RETURN
3694:             ENDIF
3695: 
3696:             loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE RealPrevs <> 2"
3697:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeR")
3698: 
3699:             IF loc_nResult > 0
3700:                 SELECT cursor_4c_TmpOpeR
3701:                 LOCATE FOR ALLTRIM(cursor_4c_TmpOpeR.Dopes) == ALLTRIM(loc_cDopReal)
3702:                 IF FOUND("cursor_4c_TmpOpeR")
3703:                     loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR.Dopes)
3704:                 ELSE
3705:                     GO TOP IN cursor_4c_TmpOpeR
3706:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3707:                     IF VARTYPE(loc_oBusca) = "O"
3708:                         loc_oBusca.this_cCursorDestino = "cursor_4c_TmpOpeR"
3709:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
3710:                         loc_oBusca.Show()
3711:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpOpeR")
3712:                             loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR.Dopes)
3713:                         ELSE
3714:                             loc_oPg2.txt_4c_DopReal.Value = ""
3715:                         ENDIF

*-- Linhas 3742 a 3764:
3742:                 RETURN
3743:             ENDIF
3744: 
3745:             loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE OpeCancs = 1"
3746:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCanc")
3747: 
3748:             IF loc_nResult > 0
3749:                 SELECT cursor_4c_TmpCanc
3750:                 LOCATE FOR ALLTRIM(cursor_4c_TmpCanc.Dopes) == ALLTRIM(loc_cDopCanc)
3751:                 IF FOUND("cursor_4c_TmpCanc")
3752:                     loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc.Dopes)
3753:                 ELSE
3754:                     GO TOP IN cursor_4c_TmpCanc
3755:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3756:                     IF VARTYPE(loc_oBusca) = "O"
3757:                         loc_oBusca.this_cCursorDestino = "cursor_4c_TmpCanc"
3758:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
3759:                         loc_oBusca.Show()
3760:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpCanc")
3761:                             loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc.Dopes)
3762:                         ELSE
3763:                             loc_oPg2.txt_4c_DopCanc.Value = ""
3764:                         ENDIF

*-- Linhas 3832 a 3853:
3832:                 RETURN
3833:             ENDIF
3834: 
3835:             loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
3836:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
3837:             IF loc_nResult > 0
3838:                 SELECT cursor_4c_BuscaMoe
3839:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaMoe.CMoes) == ALLTRIM(loc_cMoeda)
3840:                 IF FOUND("cursor_4c_BuscaMoe")
3841:                     loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3842:                 ELSE
3843:                     GO TOP IN cursor_4c_BuscaMoe
3844:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3845:                     IF VARTYPE(loc_oBusca) = "O"
3846:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoe"
3847:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
3848:                         loc_oBusca.mAddColuna("DMoes", "", "Moeda")
3849:                         loc_oBusca.Show()
3850:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
3851:                             loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3852:                         ELSE
3853:                             loc_oPg2.txt_4c_Moeda.Value = ""

*-- Linhas 3914 a 3933:
3914:                 RETURN
3915:             ENDIF
3916: 
3917:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
3918:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr1")
3919:             IF loc_nResult > 0
3920:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3921:                 IF VARTYPE(loc_oBusca) = "O"
3922:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr1"
3923:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3924:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3925:                     loc_oBusca.Show()
3926:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr1")
3927:                         loc_oPg2.txt_4c_GrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Codigos)
3928:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
3929:                             loc_oPg2.txt_4c_DGrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Descrs)
3930:                         ENDIF
3931:                     ELSE
3932:                         loc_oPg2.txt_4c_GrpCad1.Value = ""
3933:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)

*-- Linhas 3977 a 3996:
3977:                 RETURN
3978:             ENDIF
3979: 
3980:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
3981:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr2")
3982:             IF loc_nResult > 0
3983:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3984:                 IF VARTYPE(loc_oBusca) = "O"
3985:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr2"
3986:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3987:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3988:                     loc_oBusca.Show()
3989:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
3990:                         loc_oPg2.txt_4c_GrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
3991:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
3992:                             loc_oPg2.txt_4c_DGrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
3993:                         ENDIF
3994:                     ELSE
3995:                         loc_oPg2.txt_4c_GrpCad2.Value = ""
3996:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)

*-- Linhas 4040 a 4059:
4040:                 RETURN
4041:             ENDIF
4042: 
4043:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
4044:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr3")
4045:             IF loc_nResult > 0
4046:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4047:                 IF VARTYPE(loc_oBusca) = "O"
4048:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr3"
4049:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4050:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4051:                     loc_oBusca.Show()
4052:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr3")
4053:                         loc_oPg2.txt_4c_GrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Codigos)
4054:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
4055:                             loc_oPg2.txt_4c_DGrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Descrs)
4056:                         ENDIF
4057:                     ELSE
4058:                         loc_oPg2.txt_4c_GrpCad3.Value = ""
4059:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)

*-- Linhas 4103 a 4122:
4103:                 RETURN
4104:             ENDIF
4105: 
4106:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
4107:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr4")
4108:             IF loc_nResult > 0
4109:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4110:                 IF VARTYPE(loc_oBusca) = "O"
4111:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr4"
4112:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4113:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4114:                     loc_oBusca.Show()
4115:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr4")
4116:                         loc_oPg2.txt_4c_GrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Codigos)
4117:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
4118:                             loc_oPg2.txt_4c_DGrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Descrs)
4119:                         ENDIF
4120:                     ELSE
4121:                         loc_oPg2.txt_4c_GrpCad4.Value = ""
4122:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)

*-- Linhas 4155 a 4176:
4155:                 RETURN
4156:             ENDIF
4157: 
4158:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4159:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss1")
4160:             IF loc_nResult > 0
4161:                 SELECT cursor_4c_BuscaCss1
4162:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss1.Classes) == ALLTRIM(loc_cCod)
4163:                 IF FOUND("cursor_4c_BuscaCss1")
4164:                     loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
4165:                 ELSE
4166:                     GO TOP IN cursor_4c_BuscaCss1
4167:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4168:                     IF VARTYPE(loc_oBusca) = "O"
4169:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss1"
4170:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4171:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4172:                         loc_oBusca.Show()
4173:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss1")
4174:                             loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
4175:                         ELSE
4176:                             loc_oPg2.txt_4c_Class1.Value = ""

*-- Linhas 4208 a 4229:
4208:                 RETURN
4209:             ENDIF
4210: 
4211:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4212:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss2")
4213:             IF loc_nResult > 0
4214:                 SELECT cursor_4c_BuscaCss2
4215:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss2.Classes) == ALLTRIM(loc_cCod)
4216:                 IF FOUND("cursor_4c_BuscaCss2")
4217:                     loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
4218:                 ELSE
4219:                     GO TOP IN cursor_4c_BuscaCss2
4220:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4221:                     IF VARTYPE(loc_oBusca) = "O"
4222:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss2"
4223:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4224:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4225:                         loc_oBusca.Show()
4226:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss2")
4227:                             loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
4228:                         ELSE
4229:                             loc_oPg2.txt_4c_Class2.Value = ""

*-- Linhas 4261 a 4282:
4261:                 RETURN
4262:             ENDIF
4263: 
4264:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4265:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss3")
4266:             IF loc_nResult > 0
4267:                 SELECT cursor_4c_BuscaCss3
4268:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss3.Classes) == ALLTRIM(loc_cCod)
4269:                 IF FOUND("cursor_4c_BuscaCss3")
4270:                     loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
4271:                 ELSE
4272:                     GO TOP IN cursor_4c_BuscaCss3
4273:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4274:                     IF VARTYPE(loc_oBusca) = "O"
4275:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss3"
4276:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4277:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4278:                         loc_oBusca.Show()
4279:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss3")
4280:                             loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
4281:                         ELSE
4282:                             loc_oPg2.txt_4c_Class3.Value = ""

*-- Linhas 4314 a 4335:
4314:                 RETURN
4315:             ENDIF
4316: 
4317:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4318:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss4")
4319:             IF loc_nResult > 0
4320:                 SELECT cursor_4c_BuscaCss4
4321:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss4.Classes) == ALLTRIM(loc_cCod)
4322:                 IF FOUND("cursor_4c_BuscaCss4")
4323:                     loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
4324:                 ELSE
4325:                     GO TOP IN cursor_4c_BuscaCss4
4326:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4327:                     IF VARTYPE(loc_oBusca) = "O"
4328:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss4"
4329:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4330:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4331:                         loc_oBusca.Show()
4332:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss4")
4333:                             loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
4334:                         ELSE
4335:                             loc_oPg2.txt_4c_Class4.Value = ""


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
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (dopes C(20), opers C(2), ndopes N(10,0))
                    SET NULL OFF
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

