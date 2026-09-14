# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 384: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 561: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp1.prg) - TRECHOS RELEVANTES PARA PASS GRID (1064 linhas total):

*-- Linhas 123 a 142:
123:             THIS.TornarControlesVisiveis(THIS)
124: 
125:             *-- Caption dinamico do header Industrializacao (ParentForm.ParentForm.Titulo no legado)
126:             IF !EMPTY(loc_cTitulo) AND VARTYPE(THIS.grd_4c_Dados) = "O"
127:                 THIS.grd_4c_Dados.Column1.Header1.Caption = loc_cTitulo
128:             ENDIF
129: 
130:             *-- Botao Alterar visivel somente no modo INSERIR (replica logica fChecaAcesso do legado)
131:             IF VARTYPE(THIS.cmd_4c_Alterar) = "O"
132:                 THIS.cmd_4c_Alterar.Visible = INLIST(ALLTRIM(THIS.this_cEscolha), "INSERIR")
133:             ENDIF
134: 
135:             loc_lSucesso = .T.
136: 
137:         CATCH TO loc_oErro
138:             MsgErro(loc_oErro.Message, "Erro")
139:         ENDTRY
140: 
141:         RETURN loc_lSucesso
142:     ENDPROC

*-- Linhas 319 a 337:
319:     * OK) no topo. O bloco inferior (descricao + totais + resumo) eh agrupado
320:     * em ConfigurarPaginaDados().
321:     *
322:     *  - grd_4c_Dados   : grid de componentes (Grade no legado, 11 colunas)
323:     *  - cmd_4c_Alterar : libera edicao das colunas (botao Alterar)
324:     *  - cmd_4c_Ok      : persiste alteracoes e fecha (botao ok)
325:     *
326:     * O form NAO tem botoes CRUD (Incluir/Visualizar/Excluir/Buscar/Encerrar)
327:     * porque o legado nao tem - paridade funcional 100% com SIGPDMP1.SCX.
328:     *==========================================================================
329:     PROTECTED PROCEDURE ConfigurarPaginaLista()
330:         THIS.ConfigurarGradeDistrib()
331:         THIS.ConfigurarBotoes()
332:     ENDPROC
333: 
334:     *==========================================================================
335:     * ConfigurarPaginaDados - Setup visual da area "dados/detalhes" do form
336:     *
337:     * Em forms CRUD, ConfigurarPaginaDados configura a Page2 com campos de

*-- Linhas 344 a 653:
344:     *                     cursor_4c_Distrib.CDescs)
345:     *  - txt_4c_TotPeso : total de peso da fase anterior calculado pelo BO
346:     *                     (getTotPeso no legado)
347:     *  - grd_4c_Resumo  : grid de resumo com totais agrupados por componente
348:     *                     (grdResumo no legado, 6 colunas, ReadOnly)
349:     *
350:     * Ordem importa: ConfigurarCamposExtras() cria os controles flutuantes
351:     * (labels/textboxes) que ficam visualmente sobre/abaixo do grid principal;
352:     * ConfigurarGradeResumo() cria o grid de totais no rodape do form.
353:     *==========================================================================
354:     PROTECTED PROCEDURE ConfigurarPaginaDados()
355:         THIS.ConfigurarCamposExtras()
356:         THIS.ConfigurarGradeResumo()
357:     ENDPROC
358: 
359:     *==========================================================================
360:     * AlternarPagina - Form OPERACIONAL SIGPDMP1 nao possui PageFrame Page1/
361:     * Page2 nem alternancia entre modos LISTA/DADOS. Este metodo existe para
362:     * compatibilidade com a estrutura padrao da pipeline de migracao; apenas
363:     * garante o foco na grade principal quando chamado.
364:     *==========================================================================
365:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
366:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
367:             THIS.grd_4c_Dados.SetFocus()
368:         ENDIF
369:     ENDPROC
370: 
371:     *==========================================================================
372:     * ConfigurarGradeDistrib - Grid principal (Grade) com 11 colunas
373:     * Cols 3 (Pesos), 5 (Qtds), 8 (Peso2s) tornam-se editaveis apos Alterar
374:     *==========================================================================
375:     PROTECTED PROCEDURE ConfigurarGradeDistrib()
376:         THIS.AddObject("grd_4c_Dados", "Grid")
377: 
378:         WITH THIS.grd_4c_Dados
379:             .Top         = 125
380:             .Left        = 38
381:             .Width       = 724
382:             .Height      = 329
383:             .ColumnCount = 11
384:             .RecordSource = "cursor_4c_Distrib"
385:             .RecordMark  = .F.
386:             .DeleteMark  = .F.
387:             .ReadOnly    = .F.
388:             .ScrollBars  = 2
389:             .GridLines   = 1
390:             .RowHeight   = 16
391:             .FontName    = "Verdana"
392:             .FontSize    = 8
393:             .Themes      = .F.
394: 
395:             *-- ColumnOrder replica a ordem visual do original (SCX usava ColumnOrder para rearranjar)
396:             *-- Visual: Industrializacao | Componente | Descricao | Cor | Tam. | Unid. | Qtde(1) | Unid.(2) | Qtde(2) | Peso Fabr. | Lote
397: 
398:             WITH .Column1
399:                 .ColumnOrder   = 1
400:                 .Width         = 83
401:                 .ReadOnly      = .T.
402:                 .ControlSource = "cursor_4c_Distrib.Nops"
403:                 .FontName      = "Courier New"
404:                 .FontSize      = 9
405:                 .InputMask     = "9999999999"
406:                 .Alignment     = 3
407:                 .Header1.Caption = "Industrializa" + CHR(231) + CHR(227) + "o"
408:                 .Header1.FontName = "Tahoma"
409:                 .Header1.FontSize = 9
410:                 .Header1.Alignment = 2
411:             ENDWITH
412: 
413:             WITH .Column2
414:                 .ColumnOrder   = 2
415:                 .Width         = 100
416:                 .ReadOnly      = .T.
417:                 .ControlSource = "cursor_4c_Distrib.CMats"
418:                 .Header1.Caption = "Componente"
419:                 .Header1.FontName = "Tahoma"
420:                 .Header1.FontSize = 9
421:                 .Header1.Alignment = 2
422:             ENDWITH
423: 
424:             WITH .Column3
425:                 .ColumnOrder   = 10
426:                 .Width         = 80
427:                 .ReadOnly      = .T.
428:                 .ControlSource = "cursor_4c_Distrib.Pesos"
429:                 .Header1.Caption = "Peso Fabr."
430:                 .Header1.FontName = "Tahoma"
431:                 .Header1.FontSize = 9
432:                 .Header1.Alignment = 2
433:             ENDWITH
434: 
435:             WITH .Column4
436:                 .ColumnOrder   = 6
437:                 .Width         = 31
438:                 .ReadOnly      = .T.
439:                 .ControlSource = "cursor_4c_Distrib.CUnis"
440:                 .Header1.Caption = "Unid."
441:                 .Header1.FontName = "Tahoma"
442:                 .Header1.FontSize = 9
443:                 .Header1.Alignment = 2
444:             ENDWITH
445: 
446:             WITH .Column5
447:                 .ColumnOrder   = 7
448:                 .Width         = 80
449:                 .ReadOnly      = .T.
450:                 .ControlSource = "cursor_4c_Distrib.Qtds"
451:                 .Header1.Caption = "Qtde (1)"
452:                 .Header1.FontName = "Tahoma"
453:                 .Header1.FontSize = 9
454:                 .Header1.Alignment = 2
455:             ENDWITH
456: 
457:             WITH .Column6
458:                 .ColumnOrder   = 3
459:                 .Width         = 50
460:                 .ReadOnly      = .T.
461:                 .ControlSource = "cursor_4c_Distrib.CDescs"
462:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
463:                 .Header1.FontName = "Tahoma"
464:                 .Header1.FontSize = 9
465:                 .Header1.Alignment = 2
466:             ENDWITH
467: 
468:             WITH .Column7
469:                 .ColumnOrder   = 11
470:                 .Width         = 80
471:                 .ReadOnly      = .T.
472:                 .ControlSource = "cursor_4c_Distrib.nLotes"
473:                 .Header1.Caption = "Lote"
474:                 .Header1.FontName = "Tahoma"
475:                 .Header1.FontSize = 9
476:                 .Header1.Alignment = 2
477:             ENDWITH
478: 
479:             WITH .Column8
480:                 .ColumnOrder   = 9
481:                 .Width         = 70
482:                 .ReadOnly      = .T.
483:                 .ControlSource = "cursor_4c_Distrib.Peso2s"
484:                 .Header1.Caption = "Qtde (2)"
485:                 .Header1.FontName = "Tahoma"
486:                 .Header1.FontSize = 9
487:                 .Header1.Alignment = 2
488:             ENDWITH
489: 
490:             WITH .Column9
491:                 .ColumnOrder   = 8
492:                 .Width         = 31
493:                 .ReadOnly      = .T.
494:                 .ControlSource = "cursor_4c_Distrib.cUniPs"
495:                 .Header1.Caption = "Unid."
496:                 .Header1.FontName = "Tahoma"
497:                 .Header1.FontSize = 9
498:                 .Header1.Alignment = 2
499:             ENDWITH
500: 
501:             WITH .Column10
502:                 .ColumnOrder   = 4
503:                 .Width         = 38
504:                 .ReadOnly      = .T.
505:                 .ControlSource = "cursor_4c_Distrib.CodCors"
506:                 .Header1.Caption = "Cor"
507:                 .Header1.FontName = "Tahoma"
508:                 .Header1.FontSize = 9
509:                 .Header1.Alignment = 2
510:             ENDWITH
511: 
512:             WITH .Column11
513:                 .ColumnOrder   = 5
514:                 .Width         = 38
515:                 .ReadOnly      = .T.
516:                 .ControlSource = "cursor_4c_Distrib.CodTams"
517:                 .Header1.Caption = "Tam."
518:                 .Header1.FontName = "Tahoma"
519:                 .Header1.FontSize = 9
520:                 .Header1.Alignment = 2
521:             ENDWITH
522: 
523:             .Visible = .T.
524:         ENDWITH
525: 
526:         *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
527:         THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Distrib.Nops"
528:         THIS.grd_4c_Dados.Column2.ControlSource  = "cursor_4c_Distrib.CMats"
529:         THIS.grd_4c_Dados.Column3.ControlSource  = "cursor_4c_Distrib.Pesos"
530:         THIS.grd_4c_Dados.Column4.ControlSource  = "cursor_4c_Distrib.CUnis"
531:         THIS.grd_4c_Dados.Column5.ControlSource  = "cursor_4c_Distrib.Qtds"
532:         THIS.grd_4c_Dados.Column6.ControlSource  = "cursor_4c_Distrib.CDescs"
533:         THIS.grd_4c_Dados.Column7.ControlSource  = "cursor_4c_Distrib.nLotes"
534:         THIS.grd_4c_Dados.Column8.ControlSource  = "cursor_4c_Distrib.Peso2s"
535:         THIS.grd_4c_Dados.Column9.ControlSource  = "cursor_4c_Distrib.cUniPs"
536:         THIS.grd_4c_Dados.Column10.ControlSource = "cursor_4c_Distrib.CodCors"
537:         THIS.grd_4c_Dados.Column11.ControlSource = "cursor_4c_Distrib.CodTams"
538: 
539:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDistribAfterRowColChange")
540:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus",  THIS, "GrdCol3GotFocus")
541:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GrdCol3LostFocus")
542:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus",  THIS, "GrdCol5GotFocus")
543:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdCol5LostFocus")
544:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus",  THIS, "GrdCol8GotFocus")
545:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GrdCol8LostFocus")
546:     ENDPROC
547: 
548:     *==========================================================================
549:     * ConfigurarGradeResumo - Grid de resumo com 6 colunas (grdResumo)
550:     * Exibe cursor_4c_Resumo: totais agrupados por componente
551:     *==========================================================================
552:     PROTECTED PROCEDURE ConfigurarGradeResumo()
553:         THIS.AddObject("grd_4c_Resumo", "Grid")
554: 
555:         WITH THIS.grd_4c_Resumo
556:             .Top               = 481
557:             .Left              = 38
558:             .Width             = 446
559:             .Height            = 114
560:             .ColumnCount       = 6
561:             .RecordSource      = "cursor_4c_Resumo"
562:             .RecordMark        = .F.
563:             .DeleteMark        = .F.
564:             .ReadOnly          = .T.
565:             .ScrollBars        = 2
566:             .GridLines         = 1
567:             .RowHeight         = 16
568:             .HeaderHeight      = 16
569:             .AllowHeaderSizing = .F.
570:             .AllowRowSizing    = .F.
571:             .FontName          = "Verdana"
572:             .FontSize          = 8
573:             .Themes            = .F.
574: 
575:             WITH .Column1
576:                 .Width         = 108
577:                 .ControlSource = "cursor_4c_Resumo.CMats"
578:                 .Header1.Caption = "Componente"
579:                 .Header1.FontName = "Tahoma"
580:                 .Header1.FontSize = 8
581:                 .Header1.Alignment = 2
582:             ENDWITH
583: 
584:             WITH .Column2
585:                 .Width         = 80
586:                 .ControlSource = "cursor_4c_Resumo.Qtds"
587:                 .Header1.Caption = "Qtde (1)"
588:                 .Header1.FontName = "Tahoma"
589:                 .Header1.FontSize = 8
590:                 .Header1.Alignment = 2
591:             ENDWITH
592: 
593:             WITH .Column3
594:                 .Width         = 31
595:                 .ControlSource = "cursor_4c_Resumo.CUnis"
596:                 .Header1.Caption = "Unid."
597:                 .Header1.FontName = "Tahoma"
598:                 .Header1.FontSize = 8
599:                 .Header1.Alignment = 2
600:             ENDWITH
601: 
602:             WITH .Column4
603:                 .Width         = 80
604:                 .ControlSource = "cursor_4c_Resumo.Peso2s"
605:                 .Header1.Caption = "Qtde (2)"
606:                 .Header1.FontName = "Tahoma"
607:                 .Header1.FontSize = 8
608:                 .Header1.Alignment = 2
609:             ENDWITH
610: 
611:             WITH .Column5
612:                 .Width         = 31
613:                 .ControlSource = "cursor_4c_Resumo.CUniPs"
614:                 .Header1.Caption = "Unid."
615:                 .Header1.FontName = "Tahoma"
616:                 .Header1.FontSize = 8
617:                 .Header1.Alignment = 2
618:             ENDWITH
619: 
620:             WITH .Column6
621:                 .Width         = 80
622:                 .ControlSource = "cursor_4c_Resumo.Pesos"
623:                 .Header1.Caption = "Peso Fabr."
624:                 .Header1.FontName = "Tahoma"
625:                 .Header1.FontSize = 8
626:                 .Header1.Alignment = 2
627:             ENDWITH
628: 
629:             .Visible = .T.
630:         ENDWITH
631: 
632:         *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
633:         THIS.grd_4c_Resumo.Column1.ControlSource = "cursor_4c_Resumo.CMats"
634:         THIS.grd_4c_Resumo.Column2.ControlSource = "cursor_4c_Resumo.Qtds"
635:         THIS.grd_4c_Resumo.Column3.ControlSource = "cursor_4c_Resumo.CUnis"
636:         THIS.grd_4c_Resumo.Column4.ControlSource = "cursor_4c_Resumo.Peso2s"
637:         THIS.grd_4c_Resumo.Column5.ControlSource = "cursor_4c_Resumo.CUniPs"
638:         THIS.grd_4c_Resumo.Column6.ControlSource = "cursor_4c_Resumo.Pesos"
639:     ENDPROC
640: 
641:     *==========================================================================
642:     * ConfigurarCamposExtras - Label+TextBox descricao e TextBox total peso
643:     * Say2 "Descricao :" + Get_descr (descricao da linha corrente do grid)
644:     * getTotPeso (soma PsFaseAnt calculada em InicializarDistrib)
645:     *==========================================================================
646:     PROTECTED PROCEDURE ConfigurarCamposExtras()
647:         THIS.AddObject("lbl_4c_Label2", "Label")
648:         WITH THIS.lbl_4c_Label2
649:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
650:             .Top       = 458
651:             .Left      = 71
652:             .FontName  = "Tahoma"
653:             .FontSize  = 8

*-- Linhas 747 a 817:
747:     * BackColor 12713983 = RGB(255,255,193) pale-yellow do legado
748:     *==========================================================================
749:     PROCEDURE BtnAlterarClick()
750:         WITH THIS.grd_4c_Dados
751:             .Column3.ReadOnly  = .F.
752:             .Column3.BackColor = RGB(255, 255, 193)
753:             .Column5.ReadOnly  = .F.
754:             .Column5.BackColor = RGB(255, 255, 193)
755:             .Column8.ReadOnly  = .F.
756:             .Column8.BackColor = RGB(255, 255, 193)
757:             .Refresh()
758:         ENDWITH
759:         THIS.this_oBusinessObject.HabilitarAlteracao()
760:         THIS.grd_4c_Dados.Column5.SetFocus()
761:     ENDPROC
762: 
763:     *==========================================================================
764:     * BtnIncluirClick - Reinicializa distribuicao a partir de xNensi
765:     *
766:     * SIGPDMP1 legado nao possui botao Incluir explicito; a "inclusao" ocorre
767:     * automaticamente no Init quando pcEscolha = "INSERIR" via reconstrucao
768:     * do cursor TmpDistrib percorrendo xNensi.Visivel = .F.. Este metodo
769:     * replica essa logica: recarrega cursor_4c_Distrib e cursor_4c_Resumo do
770:     * xNensi compartilhado pelo form pai e refresca grids e totalizador.
771:     *==========================================================================
772:     PROCEDURE BtnIncluirClick()
773:         LOCAL loc_cTitulo
774:         loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
775:         THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
776:         THIS.this_oBusinessObject.InicializarResumo()
777:         THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
778:         THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
779:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
780:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
781:         ENDIF
782:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
783:             THIS.grd_4c_Dados.Refresh()
784:         ENDIF
785:         IF VARTYPE(THIS.grd_4c_Resumo) = "O"
786:             THIS.grd_4c_Resumo.Refresh()
787:         ENDIF
788:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
789:             THIS.txt_4c_Descr.Refresh()
790:         ENDIF
791:     ENDPROC
792: 
793:     *==========================================================================
794:     * BtnVisualizarClick - Restaura grid para modo somente-leitura
795:     *
796:     * Operacao inversa de BtnAlterarClick: ReadOnly = .T. e BackColor branco
797:     * nas colunas Pesos/Qtds/Peso2s, e desliga flag this_lLiberaAlteracao no
798:     * BO para que SalvarAlteracoes nao persista nada em xNensi.
799:     *==========================================================================
800:     PROCEDURE BtnVisualizarClick()
801:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
802:             WITH THIS.grd_4c_Dados
803:                 .Column3.ReadOnly  = .T.
804:                 .Column3.BackColor = RGB(255, 255, 255)
805:                 .Column5.ReadOnly  = .T.
806:                 .Column5.BackColor = RGB(255, 255, 255)
807:                 .Column8.ReadOnly  = .T.
808:                 .Column8.BackColor = RGB(255, 255, 255)
809:                 .Refresh()
810:             ENDWITH
811:         ENDIF
812:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
813:             THIS.this_oBusinessObject.this_lLiberaAlteracao = .F.
814:         ENDIF
815:     ENDPROC
816: 
817:     *==========================================================================

*-- Linhas 835 a 857:
835:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
836:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
837:         ENDIF
838:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
839:             THIS.grd_4c_Dados.Refresh()
840:         ENDIF
841:         IF VARTYPE(THIS.grd_4c_Resumo) = "O"
842:             THIS.grd_4c_Resumo.Refresh()
843:         ENDIF
844:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
845:             THIS.txt_4c_Descr.Refresh()
846:         ENDIF
847:     ENDPROC
848: 
849:     *==========================================================================
850:     * BtnOkClick - Persiste alteracoes em xNensi e fecha o form
851:     *==========================================================================
852:     PROCEDURE BtnOkClick()
853:         THIS.this_oBusinessObject.SalvarAlteracoes()
854: 
855:         IF USED("xNensi")
856:             SELECT xNensi
857:             SET ORDER TO Editar

*-- Linhas 879 a 944:
879:     *-- Handlers GotFocus/LostFocus para colunas editaveis (When/Valid do legado)
880: 
881:     PROCEDURE GrdCol3GotFocus()
882:         THIS.this_nAntValue = THIS.grd_4c_Dados.Column3.Text1.Value
883:     ENDPROC
884: 
885:     PROCEDURE GrdCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
886:         IF THIS.grd_4c_Dados.Column3.Text1.Value <> THIS.this_nAntValue
887:             THIS.this_oBusinessObject.MarcarModificado()
888:         ENDIF
889:     ENDPROC
890: 
891:     PROCEDURE GrdCol5GotFocus()
892:         THIS.this_nAntValue = THIS.grd_4c_Dados.Column5.Text1.Value
893:     ENDPROC
894: 
895:     PROCEDURE GrdCol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
896:         IF THIS.grd_4c_Dados.Column5.Text1.Value <> THIS.this_nAntValue
897:             THIS.this_oBusinessObject.MarcarModificado()
898:         ENDIF
899:     ENDPROC
900: 
901:     PROCEDURE GrdCol8GotFocus()
902:         THIS.this_nAntValue = THIS.grd_4c_Dados.Column8.Text1.Value
903:     ENDPROC
904: 
905:     PROCEDURE GrdCol8LostFocus(par_nKeyCode, par_nShiftAltCtrl)
906:         IF THIS.grd_4c_Dados.Column8.Text1.Value <> THIS.this_nAntValue
907:             THIS.this_oBusinessObject.MarcarModificado()
908:         ENDIF
909:     ENDPROC
910: 
911:     *==========================================================================
912:     * CarregarLista - Recarrega cursores de distribuicao e resumo e refresca grids
913:     * Equivale ao bloco de carga do Init para uso apos alteracoes externas.
914:     *==========================================================================
915:     PROCEDURE CarregarLista()
916:         LOCAL loc_cTitulo
917:         loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
918:         THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
919:         THIS.this_oBusinessObject.InicializarResumo()
920:         THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
921:         THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
922:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
923:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
924:         ENDIF
925:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
926:             THIS.grd_4c_Dados.Refresh()
927:         ENDIF
928:         IF VARTYPE(THIS.grd_4c_Resumo) = "O"
929:             THIS.grd_4c_Resumo.Refresh()
930:         ENDIF
931:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
932:             THIS.txt_4c_Descr.Refresh()
933:         ENDIF
934:     ENDPROC
935: 
936:     *==========================================================================
937:     * FormParaBO - Sincroniza propriedades de controle do form para o BO
938:     * O BO gerencia cursor_4c_Distrib diretamente; apenas sincroniza estado.
939:     *==========================================================================
940:     PROTECTED PROCEDURE FormParaBO()
941:         THIS.this_oBusinessObject.this_nTotPeso         = THIS.this_nTotPeso
942:         THIS.this_oBusinessObject.this_lLiberaAlteracao = THIS.this_lLiberaAlteracao
943:     ENDPROC
944: 

*-- Linhas 962 a 981:
962:     * par_lHabilitar = .F. -> colunas somente-leitura (branco)
963:     *==========================================================================
964:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
965:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
966:             WITH THIS.grd_4c_Dados
967:                 .Column3.ReadOnly = !par_lHabilitar
968:                 .Column5.ReadOnly = !par_lHabilitar
969:                 .Column8.ReadOnly = !par_lHabilitar
970:                 IF par_lHabilitar
971:                     .Column3.BackColor = RGB(255, 255, 193)
972:                     .Column5.BackColor = RGB(255, 255, 193)
973:                     .Column8.BackColor = RGB(255, 255, 193)
974:                 ELSE
975:                     .Column3.BackColor = RGB(255, 255, 255)
976:                     .Column5.BackColor = RGB(255, 255, 255)
977:                     .Column8.BackColor = RGB(255, 255, 255)
978:                 ENDIF
979:                 .Refresh()
980:             ENDWITH
981:         ENDIF

*-- Linhas 1043 a 1064:
1043:     * grid principal como comportamento neutro.
1044:     *==========================================================================
1045:     PROCEDURE BtnBuscarClick()
1046:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1047:             IF USED("cursor_4c_Distrib") AND !EOF("cursor_4c_Distrib")
1048:                 SELECT cursor_4c_Distrib
1049:                 GO TOP
1050:             ENDIF
1051:             THIS.grd_4c_Dados.Refresh()
1052:         ENDIF
1053:     ENDPROC
1054: 
1055:     *==========================================================================
1056:     * Destroy - Libera BO e referencia ao form pai
1057:     *==========================================================================
1058:     PROCEDURE Destroy()
1059:         THIS.this_oBusinessObject = .NULL.
1060:         THIS.this_oFormPai        = .NULL.
1061:         DODEFAULT()
1062:     ENDPROC
1063: 
1064: ENDDEFINE

