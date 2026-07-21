# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDQUERYS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS

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
  DeleteMark = .F.
  ControlSource = "TmpCabec.Obs"
  ControlSource = "TmpItens.Obs"
Select TmpCabec
	.Column1.ControlSource = 'TmpCabec.Flag'
	.Column2.ControlSource = 'TmpCabec.Dopes'
	.Column3.ControlSource = 'TmpCabec.Numes'
	.Column4.ControlSource = 'TmpCabec.Datas'
	.Column5.ControlSource = 'Iif(IsNull(TmpCabec.Entregas), {}, TmpCabec.Entregas)'
	.Column6.ControlSource = 'TmpCabec.Peso'
	.Column7.ControlSource = 'TmpCabec.Contav'
	.Column8.ControlSource = 'TmpCabec.Conta'
	.Column9.ControlSource = 'Iif(Empty(TmpCabec.Obs ), " ", "*")'
	.Column10.ControlSource = 'TmpCabec.Notas'
ThisForm.getCliente.ControlSource = [TmpCabec.DConta]
	.Column1.ControlSource = 'TmpItens.Cpros'
	.Column6.ControlSource = 'TmpItens.CodCors'
	.Column7.ControlSource = 'TmpItens.CodTams'
	.Column2.ControlSource = 'TmpItens.Qtds'
	.Column3.ControlSource = 'TmpItens.Saldo'
	.Column4.ControlSource = 'TmpItens.Peso'
	.Column5.ControlSource = 'Iif(Empty(TmpItens.Obs ), " ", "*")'
	.Column8.ControlSource = 'TmpItens.Reffs'
Select TmpItens
Select TmpCabec
Select TmpItens
	Select TmpCabec
	Select TmpCabec
Select TmpCabec
lcQuery = [Select * From SigCdCeg Where TpCads <> 1]
If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpCeg') < 1
Select CrSigTempd
Select TmpCeg
		Select CrSigTempd
	Select CrSigTempd
If !ThisForm.Podatamgr2.UpDate('CrSigTempd')
lcQuery = [Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ]+;
		[Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ] +;
If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpEstoque') < 1
Select TmpEstoque
	Select TmpSaldo
	If Not Seek(TmpEstoque.Cpros + TmpEstoque.CodCors + TmpEstoque.CodTams)
		Insert Into TmpSaldo ( CPros, CodCors, CodTams, Saldo, Disps );
	Insert Into TmpSaldg ( Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps );
	lcQuery = [Select EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEest') < 1)
	Select TempEest
		Select TempEestI
				lcQuery = [Select * ] + ;
						    [From SigMvIts ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
				Select TempEsti2
					Select TmpSaldo
					If Not Seek(TempEestI.Cpros)
						Insert Into TmpSaldo (Cpros) Value (TempEestI.CPros)
					Select TmpSaldg
					If !Seek( TempEest.Emps + TempEest.GrupoOs + TempEest.ContaOs + TempEesti.Cpros )
						Insert Into TmpSaldg ( Emps, Grupos, Estos, Cpros, Priors )  ;
					Select TempEsti2
						Select TmpSaldo
						If Not Seek(TempEsti2.Cpros + TempEsti2.CodCors + TempEsti2.CodTams)
							Insert Into TmpSaldo (Cpros, CodCors, CodTams) ;
						Select TmpSaldg
						If !Seek( TempEest.Emps + TempEest.GrupoOs + TempEest.ContaOs + TempEsti2.Cpros + TempEsti2.CodCors + TempEsti2.CodTams )
							Insert Into TmpSaldg ( Emps, Grupos, Estos, Cpros, CodCors, CodTams, Priors ) Value ;
Select TmpItens
	Select TmpCabec
	Select TmpOper
	Select TmpItens
		If (TmpOper.ChkObs <> 1 and Not IsEmpty(TmpItens.Obs)) Or Not Seek(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, 'TmpSaldo') Or ;
			=Seek(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, 'TmpSaldo')
		Insert Into TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
Select TmpSaldo
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
	lcSql = [Select a.Nops, a.Cpros, a.CodCors, a.CodTams, sum(a.Qtds) as Qtds From SigOpPic a, SigCdNec b ]+;
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpOpi')
	Select TmpOpi
		Select TmpSaldo
		If Not Seek(TmpOpi.Cpros + TmpOpi.CodCors + TmpOpi.CodTams)
			Insert Into TmpSaldo ( CPros, CodCors, CodTams );
		Insert Into TmpFabr (Nops, Cpros, CodCors, CodTams, Qtds, Priors) Values ;
		lcSql = [Select GrupoDs From SigPdMvf Where Nops = ]+Str(TmpOpi.Nops,10)+[ Order by CidChaves Desc ]
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpMfas')
		Select TmpMfas
		If Seek(TmpOpi.Cpros + TmpOpi.CodCors + TmpOpi.CodTams,'TmpFinal','Cpros')
	Select TmpSaldo
			Select TmpFabr
			=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
	Select Cpros, CodCors, CodTams, Linhas, Sum(Qtds) as Qtds, sum(Saldo) as Saldo, sum(Estoque) as Estoque,;
		sum(Produzir) as Produzir, sum(Fabrs) as Fabrs From TmpFinal ;
		lcSql = [Select a.cpros, a.qtds, b.Caixas, b.copers, b.opers, a.opers ]+;
				[From SigMvItn a, SigCdOpe b, SigMvCab c ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEest')
		Select cpros, Sum(qtds*Iif(( Caixas=1 and copers=1) or (caixas<>1 and opers=1) Or (caixas<>1 and opers=3 and opers='E'),1,-1)) as Qtds ;
		From LocalEest Group by 1 Into cursor Vendas ReadWrite
		Select Vendas
	Select TmpFinalG
	Select Selecao
		lcSql = [Select QtMinFabs From SigCdPro Where Cpros = ']+Selecao.Cpros+[']
		ThisForm.PodataMgr.Sqlexecute(lcSql,'CrSigCdPro')
		If Used('Vendas') And Seek(m.Cpros,'Vendas','Cpros')
		Select TmpFinalG
Select TmpItens

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1499 linhas total):

*-- Linhas 305 a 323:
305:                 .HighlightBackColor = RGB(255, 255, 255)
306:                 .HighlightForeColor = RGB(15, 41, 104)
307:                 .HighlightStyle    = 2
308:                 .DeleteMark        = .F.
309:                 .RecordMark        = .F.
310:                 .RowHeight         = 17
311:                 .ScrollBars        = 2
312:                 .AllowHeaderSizing = .F.
313:                 .AllowRowSizing    = .F.
314:                 .ReadOnly          = .T.
315:                 .Themes            = .F.
316: 
317:                 IF USED("TmpCabec")
318:                     .RecordSource = "TmpCabec"
319:                 ENDIF
320: 
321:                 *-- Column1: CheckBox de selecao (Flag) - Width=17
322:                 WITH .Column1
323:                     .Width     = 17

*-- Linhas 333 a 500:
333:                     .CurrentControl = "Check1"
334:                     .Sparse         = .F.
335:                     .ReadOnly       = .F.
336:                     .ControlSource  = "TmpCabec.Flag"
337:                     .Header1.Caption   = ""
338:                     .Header1.Alignment = 2
339:                     .Header1.FontName  = "Verdana"
340:                     .Header1.FontSize  = 8
341:                     .Header1.ForeColor = RGB(36, 84, 155)
342:                 ENDWITH
343: 
344:                 *-- Column2: Dopes (Movimentacao) - Width=156, header verde = ord padrao
345:                 WITH .Column2
346:                     .Width     = 156
347:                     .Movable   = .F.
348:                     .Resizable = .F.
349:                     .ReadOnly  = .T.
350:                     IF USED("TmpCabec")
351:                         .ControlSource = "TmpCabec.Dopes"
352:                     ENDIF
353:                     .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
354:                     .Header1.BackColor = RGB(220, 255, 220)
355:                     .Header1.Alignment = 2
356:                     .Header1.FontName  = "Verdana"
357:                     .Header1.FontSize  = 8
358:                     .Header1.ForeColor = RGB(36, 84, 155)
359:                 ENDWITH
360: 
361:                 *-- Column3: Numes (Numero) - Width=70
362:                 WITH .Column3
363:                     .Width     = 70
364:                     .Movable   = .F.
365:                     .Resizable = .F.
366:                     .ReadOnly  = .T.
367:                     IF USED("TmpCabec")
368:                         .ControlSource = "TmpCabec.Numes"
369:                     ENDIF
370:                     .Header1.Caption   = "N" + CHR(250) + "mero"
371:                     .Header1.Alignment = 2
372:                     .Header1.FontName  = "Verdana"
373:                     .Header1.FontSize  = 8
374:                     .Header1.ForeColor = RGB(36, 84, 155)
375:                 ENDWITH
376: 
377:                 *-- Column4: Datas (Emissao) - Width=70
378:                 WITH .Column4
379:                     .Width     = 70
380:                     .Movable   = .F.
381:                     .Resizable = .F.
382:                     .ReadOnly  = .T.
383:                     IF USED("TmpCabec")
384:                         .ControlSource = "TmpCabec.Datas"
385:                     ENDIF
386:                     .Header1.Caption   = "Emiss" + CHR(227) + "o"
387:                     .Header1.Alignment = 2
388:                     .Header1.FontName  = "Verdana"
389:                     .Header1.FontSize  = 8
390:                     .Header1.ForeColor = RGB(36, 84, 155)
391:                 ENDWITH
392: 
393:                 *-- Column5: Entregas - Width=70, IIF para data nula
394:                 WITH .Column5
395:                     .Width     = 70
396:                     .Movable   = .F.
397:                     .Resizable = .F.
398:                     .ReadOnly  = .T.
399:                     IF USED("TmpCabec")
400:                         .ControlSource = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
401:                     ENDIF
402:                     .Header1.Caption   = "Entrega"
403:                     .Header1.BackColor = RGB(192, 192, 192)
404:                     .Header1.Alignment = 2
405:                     .Header1.FontName  = "Verdana"
406:                     .Header1.FontSize  = 8
407:                     .Header1.ForeColor = RGB(36, 84, 155)
408:                 ENDWITH
409: 
410:                 *-- Column6: Peso - Width=90, InputMask numerico
411:                 WITH .Column6
412:                     .Width     = 90
413:                     .Movable   = .F.
414:                     .Resizable = .F.
415:                     .ReadOnly  = .T.
416:                     .InputMask = "999,999.99"
417:                     IF USED("TmpCabec")
418:                         .ControlSource = "TmpCabec.Peso"
419:                     ENDIF
420:                     .Header1.Caption   = "Peso"
421:                     .Header1.Alignment = 2
422:                     .Header1.FontName  = "Verdana"
423:                     .Header1.FontSize  = 8
424:                     .Header1.ForeColor = RGB(36, 84, 155)
425:                 ENDWITH
426: 
427:                 *-- Column7: Contav (Responsavel) - Width=90
428:                 WITH .Column7
429:                     .Width     = 90
430:                     .Movable   = .F.
431:                     .Resizable = .F.
432:                     .ReadOnly  = .T.
433:                     IF USED("TmpCabec")
434:                         .ControlSource = "TmpCabec.Contav"
435:                     ENDIF
436:                     .Header1.Caption   = "Respons" + CHR(225) + "vel"
437:                     .Header1.Alignment = 2
438:                     .Header1.FontName  = "Verdana"
439:                     .Header1.FontSize  = 8
440:                     .Header1.ForeColor = RGB(36, 84, 155)
441:                 ENDWITH
442: 
443:                 *-- Column8: Conta (codigo do cliente) - Width=90
444:                 *-- ORIGINAL: Column8 = TmpCabec.Conta (NAO DConta!)
445:                 WITH .Column8
446:                     .Width     = 90
447:                     .Movable   = .F.
448:                     .Resizable = .F.
449:                     .ReadOnly  = .T.
450:                     IF USED("TmpCabec")
451:                         .ControlSource = "TmpCabec.Conta"
452:                     ENDIF
453:                     .Header1.Caption   = "Cliente"
454:                     .Header1.Alignment = 2
455:                     .Header1.FontName  = "Verdana"
456:                     .Header1.FontSize  = 8
457:                     .Header1.ForeColor = RGB(36, 84, 155)
458:                 ENDWITH
459: 
460:                 *-- Column9: Obs indicator (*) - Width=44, FontBold, FontSize=12
461:                 WITH .Column9
462:                     .Width     = 44
463:                     .FontBold  = .T.
464:                     .FontSize  = 12
465:                     .Alignment = 2
466:                     .Movable   = .F.
467:                     .Resizable = .F.
468:                     .ReadOnly  = .T.
469:                     IF USED("TmpCabec")
470:                         .ControlSource = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
471:                     ENDIF
472:                     .Header1.Caption   = "Obs"
473:                     .Header1.Alignment = 2
474:                     .Header1.FontName  = "Verdana"
475:                     .Header1.FontSize  = 8
476:                     .Header1.ForeColor = RGB(36, 84, 155)
477:                 ENDWITH
478: 
479:                 *-- Column10: Notas (Doc.) - Width=52
480:                 WITH .Column10
481:                     .Width     = 52
482:                     .Movable   = .F.
483:                     .Resizable = .F.
484:                     IF USED("TmpCabec")
485:                         .ControlSource = "TmpCabec.Notas"
486:                     ENDIF
487:                     .Header1.Caption   = "Doc."
488:                     .Header1.Alignment = 2
489:                 ENDWITH
490:             ENDWITH
491: 
492:         CATCH TO loc_oErro
493:             MsgErro("Erro em ConfigurarGradeOperacao: " + loc_oErro.Message + ;
494:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
495:         ENDTRY
496:     ENDPROC
497: 
498:     *==========================================================================
499:     PROTECTED PROCEDURE ConfigurarPaginaDados
500:     *==========================================================================

*-- Linhas 518 a 536:
518:                 .ScrollBars  = 2
519:                 .BorderStyle = 1
520:                 IF USED("TmpCabec")
521:                     .ControlSource = "TmpCabec.Obs"
522:                 ENDIF
523:             ENDWITH
524: 
525:             *-- Label "Cliente :" (Label6 do legado)
526:             *-- Top=317, Left=5, Width=42, Height=15, AutoSize=.T.
527:             THIS.AddObject("lbl_4c_Label6", "Label")
528:             WITH THIS.lbl_4c_Label6
529:                 .Top       = 317
530:                 .Left      = 5
531:                 .Width     = 42
532:                 .Height    = 15
533:                 .AutoSize  = .T.
534:                 .Caption   = "Cliente :"
535:                 .FontName  = "Tahoma"
536:                 .FontSize  = 8

*-- Linhas 554 a 572:
554:                 .ReadOnly      = .T.
555:                 .SpecialEffect = 1
556:                 IF USED("TmpCabec")
557:                     .ControlSource = "TmpCabec.DConta"
558:                 ENDIF
559:             ENDWITH
560: 
561:             *-- Grade de itens da operacao corrente (GradeItens do legado)
562:             THIS.ConfigurarGradeItens()
563: 
564:             *-- Label "Observacao do Item : " (Txt_ObsItens do legado)
565:             *-- Top=532, Left=5, Width=146, Height=15, FontBold=.T., FontName=Verdana
566:             THIS.AddObject("lbl_4c_TxtObsItens", "Label")
567:             WITH THIS.lbl_4c_TxtObsItens
568:                 .Top       = 532
569:                 .Left      = 5
570:                 .Width     = 146
571:                 .Height    = 15
572:                 .AutoSize  = .T.

*-- Linhas 594 a 612:
594:                 .ScrollBars  = 2
595:                 .BorderStyle = 1
596:                 IF USED("TmpItens")
597:                     .ControlSource = "TmpItens.Obs"
598:                 ENDIF
599:             ENDWITH
600: 
601:         CATCH TO loc_oErro
602:             MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErro.Message + ;
603:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
604:         ENDTRY
605:     ENDPROC
606: 
607:     *==========================================================================
608:     PROTECTED PROCEDURE ConfigurarGradeItens
609:     *==========================================================================
610:         *-- GradeItens: Top=339, Left=5, Width=737, Height=191, 8 colunas
611:         *-- Exibe itens (TmpItens) filtrados pela operacao corrente de TmpCabec
612:         LOCAL loc_oErro

*-- Linhas 627 a 787:
627:                 .HighlightBackColor = RGB(255, 255, 255)
628:                 .HighlightForeColor = RGB(15, 41, 104)
629:                 .HighlightStyle    = 2
630:                 .DeleteMark        = .F.
631:                 .RecordMark        = .F.
632:                 .RowHeight         = 17
633:                 .ScrollBars        = 2
634:                 .AllowHeaderSizing = .F.
635:                 .AllowRowSizing    = .F.
636:                 .ReadOnly          = .T.
637:                 .Themes            = .F.
638: 
639:                 IF USED("TmpItens")
640:                     .RecordSource = "TmpItens"
641:                 ENDIF
642: 
643:                 *-- Column1: Cpros (Produto) - Width=120, ColumnOrder=1
644:                 WITH .Column1
645:                     .Width     = 120
646:                     .Movable   = .F.
647:                     .Resizable = .F.
648:                     .ReadOnly  = .T.
649:                     IF USED("TmpItens")
650:                         .ControlSource = "TmpItens.Cpros"
651:                     ENDIF
652:                     .Header1.Caption   = "Produto"
653:                     .Header1.Alignment = 2
654:                     .Header1.FontName  = "Verdana"
655:                     .Header1.FontSize  = 8
656:                     .Header1.ForeColor = RGB(36, 84, 155)
657:                 ENDWITH
658: 
659:                 *-- Column2: Qtds (Quantidade) - Width=90, ColumnOrder=5
660:                 WITH .Column2
661:                     .Width       = 90
662:                     .ColumnOrder = 5
663:                     .Movable     = .F.
664:                     .Resizable   = .F.
665:                     .ReadOnly    = .T.
666:                     IF USED("TmpItens")
667:                         .ControlSource = "TmpItens.Qtds"
668:                     ENDIF
669:                     .Header1.Caption   = "Quantidade"
670:                     .Header1.Alignment = 2
671:                     .Header1.FontName  = "Verdana"
672:                     .Header1.FontSize  = 8
673:                     .Header1.ForeColor = RGB(36, 84, 155)
674:                 ENDWITH
675: 
676:                 *-- Column3: Saldo (Saldo) - Width=118, ColumnOrder=6
677:                 WITH .Column3
678:                     .Width       = 118
679:                     .ColumnOrder = 6
680:                     .Movable     = .F.
681:                     .Resizable   = .F.
682:                     .ReadOnly    = .T.
683:                     IF USED("TmpItens")
684:                         .ControlSource = "TmpItens.Saldo"
685:                     ENDIF
686:                     .Header1.Caption   = "Saldo"
687:                     .Header1.Alignment = 2
688:                     .Header1.FontName  = "Verdana"
689:                     .Header1.FontSize  = 8
690:                     .Header1.ForeColor = RGB(36, 84, 155)
691:                 ENDWITH
692: 
693:                 *-- Column4: Peso (Peso) - Width=100, ColumnOrder=7
694:                 WITH .Column4
695:                     .Width       = 100
696:                     .ColumnOrder = 7
697:                     .Movable     = .F.
698:                     .Resizable   = .F.
699:                     .ReadOnly    = .T.
700:                     IF USED("TmpItens")
701:                         .ControlSource = "TmpItens.Peso"
702:                     ENDIF
703:                     .Header1.Caption   = "Peso"
704:                     .Header1.Alignment = 2
705:                     .Header1.FontName  = "Verdana"
706:                     .Header1.FontSize  = 8
707:                     .Header1.ForeColor = RGB(36, 84, 155)
708:                 ENDWITH
709: 
710:                 *-- Column5: Obs indicator (*) - Width=44, FontBold, ColumnOrder=8
711:                 WITH .Column5
712:                     .Width       = 44
713:                     .ColumnOrder = 8
714:                     .FontBold    = .T.
715:                     .FontSize    = 12
716:                     .Alignment   = 2
717:                     .Movable     = .F.
718:                     .Resizable   = .F.
719:                     .ReadOnly    = .T.
720:                     IF USED("TmpItens")
721:                         .ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
722:                     ENDIF
723:                     .Header1.Caption   = "Obs"
724:                     .Header1.Alignment = 2
725:                     .Header1.FontName  = "Verdana"
726:                     .Header1.FontSize  = 8
727:                     .Header1.ForeColor = RGB(36, 84, 155)
728:                 ENDWITH
729: 
730:                 *-- Column6: CodCors (Cor) - Width=38, ColumnOrder=3
731:                 WITH .Column6
732:                     .Width       = 38
733:                     .ColumnOrder = 3
734:                     .Movable     = .F.
735:                     .Resizable   = .F.
736:                     .ReadOnly    = .T.
737:                     IF USED("TmpItens")
738:                         .ControlSource = "TmpItens.CodCors"
739:                     ENDIF
740:                     .Header1.Caption   = "Cor"
741:                     .Header1.Alignment = 2
742:                     .Header1.FontName  = "Verdana"
743:                     .Header1.FontSize  = 8
744:                     .Header1.ForeColor = RGB(36, 84, 155)
745:                 ENDWITH
746: 
747:                 *-- Column7: CodTams (Tam) - Width=38, ColumnOrder=4
748:                 WITH .Column7
749:                     .Width       = 38
750:                     .ColumnOrder = 4
751:                     .Movable     = .F.
752:                     .Resizable   = .F.
753:                     .ReadOnly    = .T.
754:                     IF USED("TmpItens")
755:                         .ControlSource = "TmpItens.CodTams"
756:                     ENDIF
757:                     .Header1.Caption   = "Tam"
758:                     .Header1.Alignment = 2
759:                     .Header1.FontName  = "Verdana"
760:                     .Header1.FontSize  = 8
761:                     .Header1.ForeColor = RGB(36, 84, 155)
762:                 ENDWITH
763: 
764:                 *-- Column8: Reffs (Ref. Fornecedor) - Width=150, ColumnOrder=2
765:                 WITH .Column8
766:                     .Width       = 150
767:                     .ColumnOrder = 2
768:                     .Movable     = .F.
769:                     .Resizable   = .F.
770:                     .ReadOnly    = .T.
771:                     IF USED("TmpItens")
772:                         .ControlSource = "TmpItens.Reffs"
773:                     ENDIF
774:                     .Header1.Caption   = "Ref. Fornecedor"
775:                     .Header1.Alignment = 2
776:                 ENDWITH
777:             ENDWITH
778: 
779:             BINDEVENT(THIS.grd_4c_GradeItens, "AfterRowColChange", ;
780:                       THIS, "GrdItensAfterRowColChange")
781: 
782:         CATCH TO loc_oErro
783:             MsgErro("Erro em ConfigurarGradeItens: " + loc_oErro.Message + ;
784:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
785:         ENDTRY
786:     ENDPROC
787: 

*-- Linhas 1301 a 1319:
1301:                 loc_lSucesso = .F.
1302:             ENDIF
1303: 
1304:             SELECT TmpCabec
1305:             THIS.this_oBusinessObject.this_lFlag    = TmpCabec.Flag
1306:             THIS.this_oBusinessObject.this_cEmps    = NVL(TmpCabec.Emps,  "")
1307:             THIS.this_oBusinessObject.this_cDopes   = ALLTRIM(NVL(TmpCabec.Dopes, ""))
1308:             THIS.this_oBusinessObject.this_nNumes   = NVL(TmpCabec.Numes, 0)
1309:             THIS.this_oBusinessObject.this_dDatas   = NVL(TmpCabec.Datas, {})
1310:             THIS.this_oBusinessObject.this_dEntregas = NVL(TmpCabec.Entregas, {})
1311:             THIS.this_oBusinessObject.this_nPeso    = NVL(TmpCabec.Peso,  0)
1312:             THIS.this_oBusinessObject.this_cContav  = ALLTRIM(NVL(TmpCabec.Contav, ""))
1313:             THIS.this_oBusinessObject.this_cConta   = ALLTRIM(NVL(TmpCabec.Conta,  ""))
1314:             THIS.this_oBusinessObject.this_cDConta  = ALLTRIM(NVL(TmpCabec.DConta, ""))
1315:             THIS.this_oBusinessObject.this_cObs     = ALLTRIM(NVL(TmpCabec.Obs,    ""))
1316:             THIS.this_oBusinessObject.this_cNotas   = ALLTRIM(NVL(TmpCabec.Notas,  ""))
1317:             THIS.this_oBusinessObject.this_cJobs    = ALLTRIM(NVL(TmpCabec.Jobs,   ""))
1318: 
1319:             loc_lSucesso = .T.

*-- Linhas 1400 a 1418:
1400:                 GO TOP IN TmpCabec
1401:             ENDIF
1402:             IF USED("TmpItens")
1403:                 SELECT TmpItens
1404:                 SET KEY TO
1405:                 GO TOP
1406:             ENDIF
1407:             THIS.BOParaForm()
1408: 
1409:         CATCH TO loc_oErro
1410:             MsgErro("Erro em LimparCampos: " + loc_oErro.Message + ;
1411:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
1412:         ENDTRY
1413:     ENDPROC
1414: 
1415:     *==========================================================================
1416:     PROCEDURE BtnBuscarClick
1417:     *==========================================================================
1418:         *-- OPERACIONAL: "Buscar" = re-carregar/sincronizar visualizacao


### BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):
*==============================================================================
* SIGPRGL2BO.PRG
* Business Object para Operacoes Selecionadas (SIGPRGL2)
* Herda de BusinessBase
* Processa operacoes selecionadas e gera OPs
*==============================================================================

DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Conexao e sessao
    this_oConexao    = .NULL.   && poDataMgr - conexao principal
    this_oConexao2   = .NULL.   && poDataMgr2 - conexao para update/commit
    this_oFormPai    = .NULL.   && referencia ao form pai

    *-- Parametros recebidos na abertura
    this_lReserva      = .F.    && reserva automatica
    this_nEmphPdr      = 0      && empresa padrao do gerente
    this_lAutomatico   = .F.    && processamento automatico
    this_nNumeroDaOp   = 0      && numero da OP a gerar
    this_cPorDestino   = ""     && por destino (de PorDestino do form pai)

    *-- Estado de ordenacao do grid de operacoes
    this_cOrdConta = ""         && 'EMPDOPNUM' ou 'ENTREGA'

    *-- Estado do processamento
    this_lProcessado              = .F.   && .T. apos Processar executado com sucesso
    this_nContadorSelecionadas    = 0     && qtd de operacoes com Flag=.T.

    *-- Dados do registro corrente do TmpCabec
    this_lFlag     = .F.   && checkbox de selecao
    this_cEmps     = ""    && empresa
    this_cDopes    = ""    && tipo de operacao
    this_nNumes    = 0     && numero da operacao
    this_dDatas    = {}    && data de emissao
    this_dEntregas = {}    && data de entrega
    this_nPeso     = 0     && peso total
    this_cContav   = ""    && codigo do responsavel
    this_cConta    = ""    && codigo do cliente
    this_cDConta   = ""    && descricao do cliente
    this_cObs      = ""    && observacao da operacao
    this_cNotas    = ""    && documento fiscal
    this_cJobs     = ""    && codigo do JOB
    this_cGrupoDs  = ""    && grupo de destino
    this_cContaDs  = ""    && conta de destino

    *--------------------------------------------------------------------------
    * INIT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_lProcessado     = .F.
            THIS.this_cMensagemErro   = ""

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContexto - recebe parametros do form pai
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarContexto(par_oFormPai, par_oConexao, par_oConexao2, ;
                                  par_lReserva, par_nEmphPdr, par_lAutomatico, ;
                                  par_nNumeroDaOp, par_cPorDestino)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_oFormPai    = par_oFormPai
            THIS.this_oConexao    = par_oConexao
            THIS.this_oConexao2   = par_oConexao2
            THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
            THIS.this_nEmphPdr    = IIF(VARTYPE(par_nEmphPdr)    = "N", par_nEmphPdr,    0)
            THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
            THIS.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroDaOp) = "N", par_nNumeroDaOp, 0)
            THIS.this_cPorDestino = IIF(VARTYPE(par_cPorDestino) = "C", ALLTRIM(par_cPorDestino), "")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ConfigurarContexto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarGrade - aplica ordenacao em TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarGrade()
        LOCAL loc_lSucesso, loc_cOrdConta

        loc_lSucesso  = .F.

        TRY
            loc_cOrdConta = UPPER(IIF(VARTYPE(THIS.this_cOrdConta) = "C", THIS.this_cOrdConta, ""))

            IF USED("TmpCabec")
                SELECT TmpCabec
                IF !EMPTY(loc_cOrdConta) AND INLIST(loc_cOrdConta, "ENTREGA", "EMPDOPNUM")
                    SET ORDER TO &loc_cOrdConta.
                ELSE
                    SET ORDER TO EmpDopNum
                    THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.OrdenarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOrdemMovimentacao - ordena TmpCabec por EmpDopNum
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOrdemMovimentacao()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "EMPDOPNUM"
                SELECT TmpCabec
                SET ORDER TO EmpDopNum
                GO TOP
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DefinirOrdemMovimentacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOrdemEntrega - ordena TmpCabec por Entrega
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOrdemEntrega()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "ENTREGA"
                SELECT TmpCabec
                SET ORDER TO Entrega
                GO TOP
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DefinirOrdemEntrega")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarItens - filtra TmpItens para o registro corrente de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE SincronizarItens()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpItens") AND USED("TmpCabec") AND !EOF("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.SincronizarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - marca Flag=.T. em todos os registros de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .T. IN TmpCabec
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.SelecionarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - marca Flag=.F. em todos os registros de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .F. IN TmpCabec
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DesmarcarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecao - verifica operacoes selecionadas (Flag=.T.) e mesmo JOB
    * Retorna .T. se valido; .F. com mensagem em this_cMensagemErro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSelecao()
        LOCAL loc_lSucesso, loc_nContador, loc_cJob

        loc_lSucesso = .F.
        THIS.this_cMensagemErro        = ""
        THIS.this_nContadorSelecionadas = 0

        TRY
            IF !USED("TmpCabec")
                THIS.this_cMensagemErro = "Cursor TmpCabec n" + CHR(227) + "o est" + CHR(225) + ;
                                          " dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT TmpCabec
            SET ORDER TO EmpDopNum

            loc_nContador = 0
            GO TOP
            loc_cJob = TmpCabec.Jobs

            SCAN FOR Flag
                loc_nContador = loc_nContador + 1
                IF loc_cJob <> TmpCabec.Jobs
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + ;
                        " permitido gerar OPs de opera" + CHR(231) + CHR(245) + ;
                        "es com Jobs diferentes."
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            THIS.this_nContadorSelecionadas = loc_nContador

            IF loc_nContador = 0
                THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ValidarSelecao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarOperacoes - logica principal do botao Processar
    * Calcula estoque disponivel, monta TmpFinal, abre form de continuidade
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOperacoes()
        LOCAL loc_lSucesso, loc_cCidQuerys, loc_cQuery
        LOCAL loc_pEdI, loc_pEdF, loc_pItn
        LOCAL loc_nEstoque, loc_nProduzir, loc_nSaldo, loc_xBaixa

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lProcessado   = .F.

        TRY
            *-- 1. Validar selecao
            IF !THIS.ValidarSelecao()
                loc_lSucesso = .F.
            ENDIF

            *-- 2. IDs unicos para cursores temporarios no SQL Server
            loc_cCidQuerys = fUniqueIds()

            *-- 3. Carregar centros de estoque (SigCdCeg sem tipo 1)
            loc_cQuery = "Select * From SigCdCeg Where TpCads <> 1"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCeg") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpCeg)")
                loc_lSucesso = .F.
            ENDIF

            *-- 4. Popular CrSigTempd com dados de prioridade de estoque
            IF USED("CrSigTempd")
                USE IN CrSigTempd
            ENDIF
            SET NULL ON
            CREATE CURSOR CrSigTempd (Grupos C(10), Contas C(10), CodObs N(3,0), ;
                                      Emps C(3), CidChaves C(64), CidQuerys C(20))
            SET NULL OFF

            SELECT TmpCeg
            IF RECCOUNT() > 0
                SCAN
                    SELECT CrSigTempd
                    APPEND BLANK
                    REPLACE Grupos    WITH TmpCeg.Grupos, ;
                            Contas    WITH TmpCeg.Contas, ;
                            CodObs    WITH TmpCeg.Priors, ;
                            Emps      WITH TmpCeg.Emps, ;
                            CidChaves WITH fUniqueIds(), ;
                            CidQuerys WITH loc_cCidQuerys
                ENDSCAN
            ELSE
                SELECT CrSigTempd
                APPEND BLANK
                REPLACE Grupos    WITH crSigCdPam.GrupoEsts, ;
                        Contas    WITH crSigCdPam.ContaEsts, ;
                        CodObs    WITH 1, ;
                        Emps      WITH go_4c_Sistema.cCodEmpresa, ;
                        CidChaves WITH fUniqueIds(), ;
                        CidQuerys WITH loc_cCidQuerys
            ENDIF

            *-- 5. Persistir CrSigTempd no SQL Server
            SELECT CrSigTempd
            SCAN
                loc_cQuery = "INSERT INTO SigTempd (Grupos, Contas, CodObs, Emps, " + ;
                             "CidChaves, CidQuerys, Dpros) VALUES (" + ;
                             EscaparSQL(CrSigTempd.Grupos)    + ", " + ;
                             EscaparSQL(CrSigTempd.Contas)    + ", " + ;
                             FormatarNumeroSQL(CrSigTempd.CodObs, 0) + ", " + ;
                             EscaparSQL(CrSigTempd.Emps)      + ", " + ;
                             EscaparSQL(CrSigTempd.CidChaves) + ", " + ;
                             EscaparSQL(CrSigTempd.CidQuerys) + ", " + ;
                             "' ')"
                IF SQLEXEC(gnConnHandle, loc_cQuery) < 1
                    MsgErro("Favor reinicializar o processo.", ;
                            "Falha ao persistir SigTempd")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- 6. Carregar estoque disponivel (SigMvEst + SigTempd - UNION)
            loc_cQuery = "Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b " + ;
                         "Where a.Grupos = b.Grupos And a.Estos = b.Contas And " + ;
                               "a.Emps = b.Emps And a.Sqtds > 0 " + ;
                         "Union " + ;
                         "Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b " + ;
                         "Where a.Grupos = b.Grupos And b.Contas = '' And " + ;
                               "a.Emps = b.Emps And a.Sqtds > 0"

            IF USED("TmpEstoque")
                USE IN TmpEstoque
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpEstoque") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpEstoque)")
                loc_lSucesso = .F.
            ENDIF

            *-- Limpar registro temporario no SQL Server
            SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuerys))

            *-- 7. Criar cursores de saldo disponivel
            SET NULL ON
            CREATE CURSOR TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
                                    Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
                                    CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), ;
                                    Priors N(2,0), Reservs N(12,3))
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
            SET NULL OFF

            *-- 8. Consolidar estoques por produto/cor/tam em TmpSaldo e TmpSaldg
            SELECT TmpEstoque
            SCAN
                SELECT TmpSaldo
                IF !SEEK(TmpEstoque.CPros + TmpEstoque.CodCors + TmpEstoque.CodTams)
                    INSERT INTO TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                               VALUES   (TmpEstoque.CPros, TmpEstoque.CodCors, ;
                                         TmpEstoque.CodTams, 0, 0)
                ENDIF
                REPLACE Saldo WITH Saldo + TmpEstoque.Sqtds, ;
                        Disps WITH Disps + TmpEstoque.Sqtds IN TmpSaldo

                INSERT INTO TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, ;
                                      Saldo, Disps, Priors, Emps) ;
                           VALUES    (TmpEstoque.Grupos, TmpEstoque.Estos, ;
                                      TmpEstoque.CPros, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                                      TmpEstoque.Sqtds, TmpEstoque.Sqtds, ;
                                      TmpEstoque.Priors, TmpEstoque.Emps)
            ENDSCAN

            *-- 9. Carregar operacao de transferencia de reservas (SigCdOpe)
            IF USED("crSigCdOpe")
                USE IN crSigCdOpe
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                    EscaparSQL(crSigCdPam.TransfRes), "crSigCdOpe")

            *-- 10. Descontar estoques ja reservados em andamento
            IF !EMPTY(crSigCdPam.TransfRes) AND !EOF("crSigCdOpe") AND (crSigCdOpe.Estoqs <> 1)
                loc_pEdI = go_4c_Sistema.cCodEmpresa + crSigCdPam.TransfRes + STR(0, 6)
                loc_pEdF = go_4c_Sistema.cCodEmpresa + crSigCdPam.TransfRes + STR(999999, 6)

                loc_cQuery = "Select EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes " + ;
                             "From SigMvCab " + ;
                             "Where EmpDopNums Between " + EscaparSQL(loc_pEdI) + ;
                             " And " + EscaparSQL(loc_pEdF) + ;
                             " Order By EmpDopNums"

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cQuery, "TempEest") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (TempEest)")
                    loc_lSucesso = .F.
                ENDIF

                SELECT TempEest
                SCAN
                    loc_cEdn = TempEest.EmpDopNums
                    IF USED("TempEestI")
                        USE IN TempEestI
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                            EscaparSQL(loc_cEdn), "TempEestI")

                    SELECT TempEestI
                    SCAN
                        IF (Qtds - QtBaixas > 0)
                            loc_pItn = TempEestI.CItens

                            loc_cQuery = "Select * " + ;
                                         "From SigMvIts " + ;
                                         "Where EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                         " And CItens = " + FormatarNumeroSQL(loc_pItn, 0)

                            IF USED("TempEsti2")
                                USE IN TempEsti2
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TempEsti2") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (TempEsti2)")
                                loc_lSucesso = .F.
                            ENDIF

                            SELECT TempEsti2
                            GO TOP

                            IF EOF("TempEsti2")
                                SELECT TmpSaldo
                                IF !SEEK(TempEestI.CPros)
                                    INSERT INTO TmpSaldo (CPros) VALUES (TempEestI.CPros)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (TempEestI.Qtds - TempEestI.QtBaixas), ;
                                        Disps WITH Disps - (TempEestI.Qtds - TempEestI.QtBaixas)

                                SELECT TmpSaldg
                                SET ORDER TO GruEstPro
                                IF !SEEK(TempEest.Emps + TempEest.GrupoOs + ;
                                         TempEest.ContaOs + TempEestI.CPros)
                                    INSERT INTO TmpSaldg (Emps, Grupos, Estos, CPros, Priors) ;
                                               VALUES   (TempEest.Emps, TempEest.GrupoOs, ;
                                                         TempEest.ContaOs, TempEestI.CPros, 99)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (TempEestI.Qtds - TempEestI.QtBaixas), ;
                                        Disps WITH Disps - (TempEestI.Qtds - TempEestI.QtBaixas)
                            ELSE
                                SELECT TempEsti2
                                SCAN
                                    loc_nSaldo = TempEsti2.Qtds - TempEsti2.QtBaixas

                                    SELECT TmpSaldo
                                    IF !SEEK(TempEsti2.CPros + TempEsti2.CodCors + TempEsti2.CodTams)
                                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                                   VALUES   (TempEsti2.CPros, ;
                                                             TempEsti2.CodCors, TempEsti2.CodTams)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldo, ;
                                            Disps WITH Disps - loc_nSaldo

                                    SELECT TmpSaldg
                                    SET ORDER TO GruEstPro
                                    IF !SEEK(TempEest.Emps + TempEest.GrupoOs + ;
                                             TempEest.ContaOs + TempEsti2.CPros + ;
                                             TempEsti2.CodCors + TempEsti2.CodTams)
                                        INSERT INTO TmpSaldg (Emps, Grupos, Estos, ;
                                                              CPros, CodCors, CodTams, Priors) ;
                                                   VALUES   (TempEest.Emps, TempEest.GrupoOs, ;
                                                             TempEest.ContaOs, TempEsti2.CPros, ;
                                                             TempEsti2.CodCors, TempEsti2.CodTams, 99)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldo, ;
                                            Disps WITH Disps - loc_nSaldo
                                ENDSCAN
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- 11. Montar TmpFinal com itens das operacoes selecionadas
            SET NULL ON
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6,0), CPros C(14), ;
                                    Qtds N(10,3), Peso N(9,3), Saldo N(10,3), ;
                                    Estoque N(10,3), Produzir N(10,3), ;
                                    Obs M NULL, Obsps M NULL, ;
                                    Datas D NULL, Entregas D NULL, ;
                                    CodCors C(4), CodTams C(4), Linhas C(10), ;
                                    Citens N(10,0), Reffs C(40), Notas C(6), ;
                                    Dpros C(40), GrupoDs C(10), ContaDs C(10), ;
                                    KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SELECT TmpItens
            SET KEY TO
            SET ORDER TO CPros

            SCAN
                SELECT TmpCabec
                SEEK TmpItens.Emps + TmpItens.Dopes + STR(TmpItens.Numes, 6)
                IF !Flag
                    LOOP
                ENDIF

                SELECT TmpOper
                SEEK TmpItens.Dopes

                SELECT TmpItens
                IF (Saldo > 0)
                    loc_nEstoque  = 0
                    loc_nProduzir = 0

                    IF (TmpOper.ChkObs <> 1 AND !EMPTY(TmpItens.Obs)) OR ;
                       !SEEK(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, "TmpSaldo") OR ;
                       EMPTY(crSigCdPam.TransfRes) OR ;
                       (TmpOper.Reservas = 2 AND !THIS.this_lReserva) OR ;
                       TmpSaldo.Disps < 0
                        loc_nProduzir = TmpItens.Saldo
                    ELSE
                        =SEEK(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, "TmpSaldo")
                        loc_nEstoque = TmpSaldo.Disps
                        IF (TmpSaldo.Disps >= TmpItens.Saldo)
                            REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - TmpItens.Saldo
                        ELSE
                            loc_nProduzir = TmpItens.Saldo - TmpSaldo.Disps
                            REPLACE TmpSaldo.Disps WITH 0
                        ENDIF
                    ENDIF

                    IF USED("crSigCdPro")
                        USE IN crSigCdPro
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPro WHERE CPros = " + ;
                            EscaparSQL(TmpItens.CPros), "crSigCdPro")

                    INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, ;
                                          Estoque, Produzir, Obsps, Obs, Datas, Entregas, ;
                                          CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                          Dpros, GrupoDs, ContaDs, Jobs) ;
                               VALUES   (TmpItens.Emps, TmpItens.Dopes, TmpItens.Numes, ;
                                          TmpItens.CPros, TmpItens.Qtds, TmpItens.Peso, ;
                                          TmpItens.Saldo, TmpItens.Saldo - loc_nProduzir, ;
                                          loc_nProduzir, NVL(TmpItens.Obs, ""), ;
                                          NVL(TmpCabec.Obs, ""), ;
                                          NVL(TmpCabec.Datas, CTOD("")), ;
                                          NVL(TmpCabec.Entregas, CTOD("")), ;
                                          TmpItens.CodCors, TmpItens.CodTams, ;
                                          TmpItens.Linhas, TmpItens.CItens, ;
                                          crSigCdPro.Reffs, TmpItens.Notas, ;
                                          TmpItens.Dpros, TmpCabec.GrupoDs, ;
                                          TmpCabec.ContaDs, TmpCabec.Jobs)
                ENDIF
            ENDSCAN

            *-- 12. Distribuir diferenca de saldo entre grupos (TmpSaldg)
            SELECT TmpSaldo
            SCAN
                IF Saldo # Disps
                    loc_xBaixa = Saldo - Disps
                    SELECT TmpSaldg
                    SET ORDER TO CPros
                    =SEEK(TmpSaldo.CPros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE CPros = TmpSaldo.CPros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                        IF TmpSaldg.Disps >= loc_xBaixa
                            REPLACE TmpSaldg.Disps WITH TmpSaldg.Disps - loc_xBaixa
                            loc_xBaixa = 0
                        ELSE
                            loc_xBaixa = loc_xBaixa - TmpSaldg.Disps
                            REPLACE TmpSaldg.Disps WITH 0
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            *-- 13. Se DopEsts configurado: calcular estoque em fabricacao
            IF !EMPTY(crSigCdPac.DopEsts)
                THIS.ProcessarFabrico(loc_cCidQuerys)
            ENDIF

            *-- 14. Restaurar filtro de TmpItens para sincronismo com TmpCabec
            SELECT TmpItens
            SET ORDER TO EmpDopNum
            SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
            GO TOP

            THIS.this_lProcessado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ProcessarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarFabrico - calcula estoque em fabricacao e monta TmpFinalG
    * Chamado internamente por ProcessarOperacoes quando DopEsts nao vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarFabrico(par_cCidQuerys)
        LOCAL loc_lSucesso, loc_cSql, loc_llFalse, loc_llData
        LOCAL loc_nEstoque, loc_nProduzir, loc_xBaixa, loc_cEdn

        loc_lSucesso = .F.
        loc_llFalse  = .F.

        TRY
            SET NULL ON
            CREATE CURSOR TmpFabr (Priors N(2,0), Nops N(10,0), Fases C(10), ;
                                   CPros C(14), CodCors C(4), CodTams C(4), ;
                                   Qtds N(10,3), Disps N(12,3), Reservs N(12,3))
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG CPros
            SET NULL OFF

            loc_cSql = "Select a.Nops, a.Cpros, a.CodCors, a.CodTams, sum(a.Qtds) as Qtds " + ;
                       "From SigOpPic a, SigCdNec b " + ;
                       "Where a.Dopes = " + EscaparSQL(crSigCdPac.DopEsts) + ;
                       " And a.EmpDopNops = b.EmpDnps And b.Chksubn = 0" + ;
                       " And a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " group by a.Nops, a.Cpros, a.CodCors, a.CodTams"

            IF USED("TmpOpi")
                USE IN TmpOpi
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")

            SELECT TmpOpi
            SCAN
                SELECT TmpSaldo
                IF !SEEK(TmpOpi.CPros + TmpOpi.CodCors + TmpOpi.CodTams)
                    INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                               VALUES   (TmpOpi.CPros, TmpOpi.CodCors, TmpOpi.CodTams)
                ENDIF
                REPLACE Fabrs  WITH Fabrs  + TmpOpi.Qtds, ;
                        DispFs WITH DispFs + TmpOpi.Qtds IN TmpSaldo

                INSERT INTO TmpFabr (Nops, CPros, CodCors, CodTams, Qtds, Priors) ;
                           VALUES   (TmpOpi.Nops, TmpOpi.CPros, TmpOpi.CodCors, ;
                                     TmpOpi.CodTams, TmpOpi.Qtds, 0)

                loc_cSql = "Select GrupoDs From SigPdMvf Where Nops = " + ;
                           TRANSFORM(TmpOpi.Nops) + " Order by CidChaves Desc"
                IF USED("TmpMfas")
                    USE IN TmpMfas
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "TmpMfas")

                SELECT TmpMfas
                GO TOP
                REPLACE Fases WITH TmpMfas.GrupoDs IN TmpFabr

                loc_nEstoque  = 0
                loc_nProduzir = 0

                IF SEEK(TmpOpi.CPros + TmpOpi.CodCors + TmpOpi.CodTams, "TmpFinal", "CPros")
                    IF TmpSaldo.Fabrs >= TmpFinal.Produzir
                        loc_nEstoque  = TmpFinal.Produzir
                        loc_nProduzir = 0
                        REPLACE TmpSaldo.DispFs WITH TmpSaldo.DispFs - TmpFinal.Produzir IN TmpSaldo
                    ELSE
                        loc_nEstoque  = TmpSaldo.Fabrs
                        loc_nProduzir = TmpFinal.Produzir - TmpSaldo.Fabrs
                        REPLACE DispFs WITH 0 IN TmpSaldo
                    ENDIF
                    REPLACE Produzir WITH loc_nProduzir, ;
                            Fabrs    WITH loc_nEstoque IN TmpFinal
                ENDIF
            ENDSCAN

            *-- Distribuir fabricacao por grupo (TmpFabr)
            SELECT TmpSaldo
            SCAN
                IF Fabrs # DispFs
                    loc_xBaixa = Fabrs - DispFs
                    SELECT TmpFabr
                    SET ORDER TO CPros
                    =SEEK(TmpSaldo.CPros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE CPros = TmpSaldo.CPros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                        IF (TmpFabr.Qtds - TmpFabr.Disps) >= loc_xBaixa
                            REPLACE TmpFabr.Disps WITH TmpFabr.Disps + loc_xBaixa IN TmpFabr
                            loc_xBaixa = 0
                        ELSE
                            loc_xBaixa = loc_xBaixa - (TmpFabr.Qtds - TmpFabr.Disps)
                            REPLACE TmpFabr.Disps WITH Qtds IN TmpFabr
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            *-- Montar TmpFinalG (agrupado por produto/cor/tam)
            SET NULL ON
            CREATE CURSOR TmpFinalG (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
                                     Linhas C(10), Qtds N(10,3), Saldo N(10,3), ;
                                     Estoque N(10,3), Produzir N(10,3), Fabrs N(10,3), ;
                                     Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
                                     KeySelM L, KeySelMP L, UsuLibs C(10))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SELECT CPros, CodCors, CodTams, Linhas, ;
                   SUM(Qtds)     AS Qtds, ;
                   SUM(Saldo)    AS Saldo, ;
                   SUM(Estoque)  AS Estoque, ;
                   SUM(Produzir) AS Produzir, ;
                   SUM(Fabrs)    AS Fabrs ;
            FROM TmpFinal ;
            INTO CURSOR Selecao ;
            GROUP BY CPros, CodCors, CodTams, Linhas

            *-- Historico de vendas (se nMeses configurado)
            IF crSigCdPac.nMeses > 0
                loc_llData = GOMONTH(DATE(), -crSigCdPac.nMeses)

                loc_cSql = "Select a.cpros, a.qtds, b.Caixas, b.copers, b.opers, a.opers " + ;
                           "From SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                           "Where a.EmpDopNums = c.EmpDopNums And a.Emps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + " And c.datas >= " + ;
                           FormatarDataSQL(loc_llData) + ;
                           " And a.dopes = b.dopes and b.tipoops in(4,5)"

                IF USED("LocalEest")
                    USE IN LocalEest
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "LocalEest")

                SELECT CPros, ;
                       SUM(Qtds * IIF((Caixas = 1 AND copers = 1) OR ;
                                      (Caixas <> 1 AND Opers = 1) OR ;
                                      (Caixas <> 1 AND Opers = 3), 1, -1)) AS Qtds ;
                FROM LocalEest ;
                GROUP BY CPros ;
                INTO CURSOR Vendas READWRITE

                SELECT Vendas
                INDEX ON CPros TAG CPros
            ENDIF

            *-- Popular TmpFinalG
            SELECT TmpFinalG
            SCATTER MEMVAR BLANK

            SELECT Selecao
            SCAN
                SCATTER MEMVAR
                m.flag = "+"

                loc_cSql = "Select QtMinFabs From SigCdPro Where Cpros = " + EscaparSQL(Selecao.CPros)
                IF USED("CrSigCdPro")
                    USE IN CrSigCdPro
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "CrSigCdPro")

                m.QtdMins = 0
                IF (crSigCdPac.GerPcps = 2 AND !THIS.this_lReserva) OR ;
                   (crSigCdPac.GerPcps <> 2 AND THIS.this_lReserva)
                    m.QtdMins = crSigCdPro.QtMinFabs
                ENDIF

                IF USED("Vendas") AND SEEK(m.CPros, "Vendas", "CPros")
                    m.TotVenda = Vendas.Qtds
                ELSE
                    m.TotVenda = 0
                ENDIF

                m.Produzir2 = IIF(m.QtdMins > 0 AND m.Produzir > 0 AND ;
                                  m.Produzir < m.QtdMins, ;
                                  m.QtdMins - m.Produzir, 0)

                SELECT TmpFinalG
                APPEND BLANK
                GATHER MEMVAR
            ENDSCAN

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ProcessarFabrico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO com o registro corrente
    * par_cAliasCursor: alias do cursor fonte (TmpCabec)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_lFlag     = NVL(Flag,     .F.)
                THIS.this_cEmps     = ALLTRIM(NVL(Emps,     ""))
                THIS.this_cDopes    = ALLTRIM(NVL(Dopes,    ""))
                THIS.this_nNumes    = NVL(Numes,    0)
                THIS.this_dDatas    = NVL(Datas,    {})
                THIS.this_dEntregas = NVL(Entregas, {})
                THIS.this_nPeso     = NVL(Peso,     0)
                THIS.this_cContav   = ALLTRIM(NVL(Contav,   ""))
                THIS.this_cConta    = ALLTRIM(NVL(Conta,    ""))
                THIS.this_cDConta   = ALLTRIM(NVL(DConta,   ""))
                THIS.this_cObs      = NVL(Obs,      "")
                THIS.this_cNotas    = ALLTRIM(NVL(Notas,    ""))
                THIS.this_cJobs     = ALLTRIM(NVL(Jobs,     ""))
                THIS.this_cGrupoDs  = ALLTRIM(NVL(GrupoDs,  ""))
                THIS.this_cContaDs  = ALLTRIM(NVL(ContaDs,  ""))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave no formato EmpDopNum (C(29))
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmps) + ;
               ALLTRIM(THIS.this_cDopes) + ;
               STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigMvCab com as propriedades correntes
    * Executa auditoria apos gravacao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigMvCab (" + ;
                       "Emps, Dopes, Numes, EmpDopNums, " + ;
                       "Datas, Entregas, PbRus, " + ;
                       "Contav, IClis, NEmps, " + ;
                       "Notas, Jobs, GrupoDs, ContaDs, Obses" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
                       EscaparSQL(THIS.this_cContav) + ", " + ;
                       EscaparSQL(THIS.this_cConta) + ", " + ;
                       EscaparSQL(THIS.this_cDConta) + ", " + ;
                       EscaparSQL(THIS.this_cNotas) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cObs) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Inserir: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab com as propriedades correntes
    * Executa auditoria apos gravacao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            loc_cSQL = "UPDATE SigMvCab SET " + ;
                       "Datas = "    + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       "Entregas = " + FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
                       "PbRus = "    + FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
                       "Contav = "   + EscaparSQL(THIS.this_cContav) + ", " + ;
                       "IClis = "    + EscaparSQL(THIS.this_cConta) + ", " + ;
                       "NEmps = "    + EscaparSQL(THIS.this_cDConta) + ", " + ;
                       "Notas = "    + EscaparSQL(THIS.this_cNotas) + ", " + ;
                       "Jobs = "     + EscaparSQL(THIS.this_cJobs) + ", " + ;
                       "GrupoDs = "  + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       "ContaDs = "  + EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       "Obses = "    + EscaparSQL(THIS.this_cObs) + ", " + ;
                       "DtAlts = GETDATE() " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Atualizar: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigMvCab pela chave EmpDopNums
    * Executa auditoria apos exclusao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigMvCab " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em ExecutarExclusao: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EncerrarForm - libera referencia ao form pai e restaura Enabled
    *--------------------------------------------------------------------------
    PROCEDURE EncerrarForm()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O" AND !ISNULL(THIS.this_oFormPai)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.EncerrarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpa referencias ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oConexao  = .NULL.
        THIS.this_oConexao2 = .NULL.
        THIS.this_oFormPai  = .NULL.
    ENDPROC

ENDDEFINE

