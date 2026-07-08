# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 384: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 548: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp1.prg) - TRECHOS RELEVANTES PARA PASS GRID (1043 linhas total):

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

*-- Linhas 344 a 628:
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
526:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDistribAfterRowColChange")
527:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus",  THIS, "GrdCol3GotFocus")
528:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GrdCol3LostFocus")
529:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus",  THIS, "GrdCol5GotFocus")
530:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdCol5LostFocus")
531:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus",  THIS, "GrdCol8GotFocus")
532:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GrdCol8LostFocus")
533:     ENDPROC
534: 
535:     *==========================================================================
536:     * ConfigurarGradeResumo - Grid de resumo com 6 colunas (grdResumo)
537:     * Exibe cursor_4c_Resumo: totais agrupados por componente
538:     *==========================================================================
539:     PROTECTED PROCEDURE ConfigurarGradeResumo()
540:         THIS.AddObject("grd_4c_Resumo", "Grid")
541: 
542:         WITH THIS.grd_4c_Resumo
543:             .Top               = 481
544:             .Left              = 38
545:             .Width             = 446
546:             .Height            = 114
547:             .ColumnCount       = 6
548:             .RecordSource      = "cursor_4c_Resumo"
549:             .RecordMark        = .F.
550:             .DeleteMark        = .F.
551:             .ReadOnly          = .T.
552:             .ScrollBars        = 2
553:             .GridLines         = 1
554:             .RowHeight         = 16
555:             .HeaderHeight      = 16
556:             .AllowHeaderSizing = .F.
557:             .AllowRowSizing    = .F.
558:             .FontName          = "Verdana"
559:             .FontSize          = 8
560:             .Themes            = .F.
561: 
562:             WITH .Column1
563:                 .Width         = 108
564:                 .ControlSource = "cursor_4c_Resumo.CMats"
565:                 .Header1.Caption = "Componente"
566:                 .Header1.FontName = "Tahoma"
567:                 .Header1.FontSize = 8
568:                 .Header1.Alignment = 2
569:             ENDWITH
570: 
571:             WITH .Column2
572:                 .Width         = 80
573:                 .ControlSource = "cursor_4c_Resumo.Qtds"
574:                 .Header1.Caption = "Qtde (1)"
575:                 .Header1.FontName = "Tahoma"
576:                 .Header1.FontSize = 8
577:                 .Header1.Alignment = 2
578:             ENDWITH
579: 
580:             WITH .Column3
581:                 .Width         = 31
582:                 .ControlSource = "cursor_4c_Resumo.CUnis"
583:                 .Header1.Caption = "Unid."
584:                 .Header1.FontName = "Tahoma"
585:                 .Header1.FontSize = 8
586:                 .Header1.Alignment = 2
587:             ENDWITH
588: 
589:             WITH .Column4
590:                 .Width         = 80
591:                 .ControlSource = "cursor_4c_Resumo.Peso2s"
592:                 .Header1.Caption = "Qtde (2)"
593:                 .Header1.FontName = "Tahoma"
594:                 .Header1.FontSize = 8
595:                 .Header1.Alignment = 2
596:             ENDWITH
597: 
598:             WITH .Column5
599:                 .Width         = 31
600:                 .ControlSource = "cursor_4c_Resumo.CUniPs"
601:                 .Header1.Caption = "Unid."
602:                 .Header1.FontName = "Tahoma"
603:                 .Header1.FontSize = 8
604:                 .Header1.Alignment = 2
605:             ENDWITH
606: 
607:             WITH .Column6
608:                 .Width         = 80
609:                 .ControlSource = "cursor_4c_Resumo.Pesos"
610:                 .Header1.Caption = "Peso Fabr."
611:                 .Header1.FontName = "Tahoma"
612:                 .Header1.FontSize = 8
613:                 .Header1.Alignment = 2
614:             ENDWITH
615: 
616:             .Visible = .T.
617:         ENDWITH
618:     ENDPROC
619: 
620:     *==========================================================================
621:     * ConfigurarCamposExtras - Label+TextBox descricao e TextBox total peso
622:     * Say2 "Descricao :" + Get_descr (descricao da linha corrente do grid)
623:     * getTotPeso (soma PsFaseAnt calculada em InicializarDistrib)
624:     *==========================================================================
625:     PROTECTED PROCEDURE ConfigurarCamposExtras()
626:         THIS.AddObject("lbl_4c_Label2", "Label")
627:         WITH THIS.lbl_4c_Label2
628:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "

*-- Linhas 726 a 796:
726:     * BackColor 12713983 = RGB(255,255,193) pale-yellow do legado
727:     *==========================================================================
728:     PROCEDURE BtnAlterarClick()
729:         WITH THIS.grd_4c_Dados
730:             .Column3.ReadOnly  = .F.
731:             .Column3.BackColor = RGB(255, 255, 193)
732:             .Column5.ReadOnly  = .F.
733:             .Column5.BackColor = RGB(255, 255, 193)
734:             .Column8.ReadOnly  = .F.
735:             .Column8.BackColor = RGB(255, 255, 193)
736:             .Refresh()
737:         ENDWITH
738:         THIS.this_oBusinessObject.HabilitarAlteracao()
739:         THIS.grd_4c_Dados.Column5.SetFocus()
740:     ENDPROC
741: 
742:     *==========================================================================
743:     * BtnIncluirClick - Reinicializa distribuicao a partir de xNensi
744:     *
745:     * SIGPDMP1 legado nao possui botao Incluir explicito; a "inclusao" ocorre
746:     * automaticamente no Init quando pcEscolha = "INSERIR" via reconstrucao
747:     * do cursor TmpDistrib percorrendo xNensi.Visivel = .F.. Este metodo
748:     * replica essa logica: recarrega cursor_4c_Distrib e cursor_4c_Resumo do
749:     * xNensi compartilhado pelo form pai e refresca grids e totalizador.
750:     *==========================================================================
751:     PROCEDURE BtnIncluirClick()
752:         LOCAL loc_cTitulo
753:         loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
754:         THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
755:         THIS.this_oBusinessObject.InicializarResumo()
756:         THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
757:         THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
758:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
759:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
760:         ENDIF
761:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
762:             THIS.grd_4c_Dados.Refresh()
763:         ENDIF
764:         IF VARTYPE(THIS.grd_4c_Resumo) = "O"
765:             THIS.grd_4c_Resumo.Refresh()
766:         ENDIF
767:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
768:             THIS.txt_4c_Descr.Refresh()
769:         ENDIF
770:     ENDPROC
771: 
772:     *==========================================================================
773:     * BtnVisualizarClick - Restaura grid para modo somente-leitura
774:     *
775:     * Operacao inversa de BtnAlterarClick: ReadOnly = .T. e BackColor branco
776:     * nas colunas Pesos/Qtds/Peso2s, e desliga flag this_lLiberaAlteracao no
777:     * BO para que SalvarAlteracoes nao persista nada em xNensi.
778:     *==========================================================================
779:     PROCEDURE BtnVisualizarClick()
780:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
781:             WITH THIS.grd_4c_Dados
782:                 .Column3.ReadOnly  = .T.
783:                 .Column3.BackColor = RGB(255, 255, 255)
784:                 .Column5.ReadOnly  = .T.
785:                 .Column5.BackColor = RGB(255, 255, 255)
786:                 .Column8.ReadOnly  = .T.
787:                 .Column8.BackColor = RGB(255, 255, 255)
788:                 .Refresh()
789:             ENDWITH
790:         ENDIF
791:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
792:             THIS.this_oBusinessObject.this_lLiberaAlteracao = .F.
793:         ENDIF
794:     ENDPROC
795: 
796:     *==========================================================================

*-- Linhas 814 a 836:
814:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
815:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
816:         ENDIF
817:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
818:             THIS.grd_4c_Dados.Refresh()
819:         ENDIF
820:         IF VARTYPE(THIS.grd_4c_Resumo) = "O"
821:             THIS.grd_4c_Resumo.Refresh()
822:         ENDIF
823:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
824:             THIS.txt_4c_Descr.Refresh()
825:         ENDIF
826:     ENDPROC
827: 
828:     *==========================================================================
829:     * BtnOkClick - Persiste alteracoes em xNensi e fecha o form
830:     *==========================================================================
831:     PROCEDURE BtnOkClick()
832:         THIS.this_oBusinessObject.SalvarAlteracoes()
833: 
834:         IF USED("xNensi")
835:             SELECT xNensi
836:             SET ORDER TO Editar

*-- Linhas 858 a 923:
858:     *-- Handlers GotFocus/LostFocus para colunas editaveis (When/Valid do legado)
859: 
860:     PROCEDURE GrdCol3GotFocus()
861:         THIS.this_nAntValue = THIS.grd_4c_Dados.Column3.Text1.Value
862:     ENDPROC
863: 
864:     PROCEDURE GrdCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
865:         IF THIS.grd_4c_Dados.Column3.Text1.Value <> THIS.this_nAntValue
866:             THIS.this_oBusinessObject.MarcarModificado()
867:         ENDIF
868:     ENDPROC
869: 
870:     PROCEDURE GrdCol5GotFocus()
871:         THIS.this_nAntValue = THIS.grd_4c_Dados.Column5.Text1.Value
872:     ENDPROC
873: 
874:     PROCEDURE GrdCol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
875:         IF THIS.grd_4c_Dados.Column5.Text1.Value <> THIS.this_nAntValue
876:             THIS.this_oBusinessObject.MarcarModificado()
877:         ENDIF
878:     ENDPROC
879: 
880:     PROCEDURE GrdCol8GotFocus()
881:         THIS.this_nAntValue = THIS.grd_4c_Dados.Column8.Text1.Value
882:     ENDPROC
883: 
884:     PROCEDURE GrdCol8LostFocus(par_nKeyCode, par_nShiftAltCtrl)
885:         IF THIS.grd_4c_Dados.Column8.Text1.Value <> THIS.this_nAntValue
886:             THIS.this_oBusinessObject.MarcarModificado()
887:         ENDIF
888:     ENDPROC
889: 
890:     *==========================================================================
891:     * CarregarLista - Recarrega cursores de distribuicao e resumo e refresca grids
892:     * Equivale ao bloco de carga do Init para uso apos alteracoes externas.
893:     *==========================================================================
894:     PROCEDURE CarregarLista()
895:         LOCAL loc_cTitulo
896:         loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
897:         THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
898:         THIS.this_oBusinessObject.InicializarResumo()
899:         THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
900:         THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
901:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
902:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
903:         ENDIF
904:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
905:             THIS.grd_4c_Dados.Refresh()
906:         ENDIF
907:         IF VARTYPE(THIS.grd_4c_Resumo) = "O"
908:             THIS.grd_4c_Resumo.Refresh()
909:         ENDIF
910:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
911:             THIS.txt_4c_Descr.Refresh()
912:         ENDIF
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * FormParaBO - Sincroniza propriedades de controle do form para o BO
917:     * O BO gerencia cursor_4c_Distrib diretamente; apenas sincroniza estado.
918:     *==========================================================================
919:     PROTECTED PROCEDURE FormParaBO()
920:         THIS.this_oBusinessObject.this_nTotPeso         = THIS.this_nTotPeso
921:         THIS.this_oBusinessObject.this_lLiberaAlteracao = THIS.this_lLiberaAlteracao
922:     ENDPROC
923: 

*-- Linhas 941 a 960:
941:     * par_lHabilitar = .F. -> colunas somente-leitura (branco)
942:     *==========================================================================
943:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
944:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
945:             WITH THIS.grd_4c_Dados
946:                 .Column3.ReadOnly = !par_lHabilitar
947:                 .Column5.ReadOnly = !par_lHabilitar
948:                 .Column8.ReadOnly = !par_lHabilitar
949:                 IF par_lHabilitar
950:                     .Column3.BackColor = RGB(255, 255, 193)
951:                     .Column5.BackColor = RGB(255, 255, 193)
952:                     .Column8.BackColor = RGB(255, 255, 193)
953:                 ELSE
954:                     .Column3.BackColor = RGB(255, 255, 255)
955:                     .Column5.BackColor = RGB(255, 255, 255)
956:                     .Column8.BackColor = RGB(255, 255, 255)
957:                 ENDIF
958:                 .Refresh()
959:             ENDWITH
960:         ENDIF

*-- Linhas 1022 a 1043:
1022:     * grid principal como comportamento neutro.
1023:     *==========================================================================
1024:     PROCEDURE BtnBuscarClick()
1025:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1026:             IF USED("cursor_4c_Distrib") AND !EOF("cursor_4c_Distrib")
1027:                 SELECT cursor_4c_Distrib
1028:                 GO TOP
1029:             ENDIF
1030:             THIS.grd_4c_Dados.Refresh()
1031:         ENDIF
1032:     ENDPROC
1033: 
1034:     *==========================================================================
1035:     * Destroy - Libera BO e referencia ao form pai
1036:     *==========================================================================
1037:     PROCEDURE Destroy()
1038:         THIS.this_oBusinessObject = .NULL.
1039:         THIS.this_oFormPai        = .NULL.
1040:         DODEFAULT()
1041:     ENDPROC
1042: 
1043: ENDDEFINE

