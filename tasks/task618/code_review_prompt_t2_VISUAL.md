# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [ALINHAMENTO] Botao 'cmd_4c_Cancelar' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaLin' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4152 linhas total):

*-- Linhas 186 a 194:
186:         LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
187:         loc_lSucesso = .F.
188: 
189:         THIS.Caption = IIF(THIS.this_lReservaAuto, ;
190:             "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
191:             "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
192:         THIS.this_cTituloForm = THIS.Caption
193: 
194:         TRY

*-- Linhas 262 a 271:
262:         THIS.AddObject("pgf_4c_1", "PageFrame")
263: 
264:         WITH THIS.pgf_4c_1
265:             .Top       = -27
266:             .Left      = -1
267:             .Width     = 804
268:             .Height    = 635
269:             .PageCount = 6
270:             .Tabs      = .F.
271:         ENDWITH

*-- Linhas 279 a 328:
279:         loc_oCab = loc_oPag1.cnt_4c_Sombra
280: 
281:         WITH loc_oCab
282:             .Top         = -1
283:             .Left        = 0
284:             .Width       = THIS.Width
285:             .Height      = 80
286:             .BackColor   = RGB(100, 100, 100)
287:             .BackStyle   = 1
288:             .BorderWidth = 0
289:             .SpecialEffect = 0
290:         ENDWITH
291: 
292:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
293:         WITH loc_oCab.lbl_4c_LblSombra
294:             .AutoSize  = .F.
295:             .Top       = 18
296:             .Left      = 10
297:             .Width     = 769
298:             .Height    = 40
299:             .FontName  = "Tahoma"
300:             .FontSize  = 16
301:             .FontBold  = .T.
302:             .Alignment = 0
303:             .BackStyle = 0
304:             .WordWrap  = .T.
305:             .ForeColor = RGB(0, 0, 0)
306:             .Caption   = ""
307:         ENDWITH
308: 
309:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
310:         WITH loc_oCab.lbl_4c_LblTitulo
311:             .AutoSize  = .F.
312:             .Top       = 17
313:             .Left      = 10
314:             .Width     = 769
315:             .Height    = 46
316:             .FontName  = "Tahoma"
317:             .FontSize  = 16
318:             .FontBold  = .T.
319:             .Alignment = 0
320:             .BackStyle = 0
321:             .WordWrap  = .T.
322:             .ForeColor = RGB(255, 255, 255)
323:             .Caption   = ""
324:         ENDWITH
325:     ENDPROC
326: 
327:     *--------------------------------------------------------------------------
328:     * ConfigurarPaginaLista - completa a Page1 (SIGPRGLX.PageDados.Page1 no

*-- Linhas 350 a 358:
350:     * this_lPermiteAjustarPrioridade - "If fChecaAcesso('SIGPRGLO',
351:     * 'PRIORIDADE')" do legado (Init, Container1/Container3.GradeDisp):
352:     * controla se a coluna Prior das grades de resumo eh editavel e se
353:     * cmd_4c_SelEstoque fica visivel.
354:     *--------------------------------------------------------------------------
355:     PROTECTED FUNCTION this_lPermiteAjustarPrioridade()
356:         RETURN fChecaAcesso("SIGPRGLO", "PRIORIDADE")
357:     ENDFUNC
358: 

*-- Linhas 408 a 471:
408:         loc_oPag1.grd_4c_Dados.RecordSource = "TmpFinalg"
409: 
410:         WITH loc_oPag1.grd_4c_Dados
411:             .Top         = 173
412:             .Left        = 52
413:             .Width       = 586
414:             .Height      = 173
415:             .RecordMark   = .F.
416:             .DeleteMark   = .F.
417:             .ReadOnly     = .F.
418: 
419:             .Column1.ControlSource = "TmpFinalg.Cpros"
420:             .Column1.Header1.Caption = "Produto"
421:             .Column1.Width = 90
422:             .Column1.ReadOnly = .T.
423: 
424:             .Column2.ControlSource = "TmpFinalg.CodCors"
425:             .Column2.Header1.Caption = "Cor"
426:             .Column2.Width = 50
427:             .Column2.ReadOnly = .T.
428: 
429:             .Column3.ControlSource = "TmpFinalg.Flag"
430:             .Column3.Header1.Caption = ""
431:             .Column3.Width = 30
432: 
433:             .Column4.ControlSource = "TmpFinalg.Qtds"
434:             .Column4.Header1.Caption = "N" + CHR(250) + "mero"
435:             .Column4.Width = 60
436:             .Column4.ReadOnly = .T.
437: 
438:             .Column5.ControlSource = "TmpFinalg.Saldo"
439:             .Column5.Header1.Caption = "Qtde Pedido"
440:             .Column5.Width = 70
441:             .Column5.ReadOnly = .T.
442: 
443:             .Column6.ControlSource = "TmpFinalg.Produzir"
444:             .Column6.Header1.Caption = "Produzir"
445:             .Column6.Width = 70
446:             .Column6.ReadOnly = .T.
447: 
448:             .Column7.ControlSource = "TmpFinalg.Fabrs"
449:             .Column7.Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
450:             .Column7.Width = 80
451:             .Column7.ReadOnly = .F.
452:             .Column7.DynamicBackColor = "RGB(255,255,204)"
453: 
454:             .Column8.ControlSource = "TmpFinalg.Produzir2"
455:             .Column8.Header1.Caption = "Produzir Estq"
456:             .Column8.Width = 80
457:             .Column8.ReadOnly = .T.
458:             .Column8.DynamicForeColor = "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"
459: 
460:             .Column9.ControlSource = "TmpFinalg.CodTams"
461:             .Column9.Header1.Caption = "Tam"
462:             .Column9.Width = 40
463:             .Column9.ReadOnly = .T.
464: 
465:             .Column10.ControlSource = "TmpFinalg.Estoque"
466:             .Column10.Header1.Caption = "Qtd Estoque"
467:             .Column10.Width = 76
468:             .Column10.ReadOnly = .F.
469:         ENDWITH
470: 
471:         *-- GotFocus -> Column7.SetFocus SO nas colunas que o legado redireciona

*-- Linhas 498 a 853:
498:         loc_oPag1.AddObject("cnt_4c_Container3", "Container")
499:         loc_oCnt = loc_oPag1.cnt_4c_Container3
500:         WITH loc_oCnt
501:             .Top = 371
502:             .Left = 50
503:             .Width = 363
504:             .Height = 186
505:             .BackStyle = 0
506:             .BorderWidth = 0
507:         ENDWITH
508: 
509:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
510:         WITH loc_oCnt.lbl_4c_Label1
511:             .AutoSize = .F.
512:             .Top = 1
513:             .Left = 0
514:             .Width = 363
515:             .Height = 16
516:             .FontBold = .T.
517:             .BackStyle = 0
518:             .ForeColor = RGB(90, 90, 90)
519:             .Caption = "Estoque Dispon" + CHR(237) + "vel"
520:         ENDWITH
521: 
522:         loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")
523: 
524:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
525:         *-- antes de o bloco abaixo acessar .Column1..Column6.
526:         loc_oCnt.grd_4c_DispGrupo.RecordSource = ""
527:         loc_oCnt.grd_4c_DispGrupo.ColumnCount = 6
528:         loc_oCnt.grd_4c_DispGrupo.RecordSource = "cursor_4c_TmpSaldg"
529: 
530:         WITH loc_oCnt.grd_4c_DispGrupo
531:             .Top = 15
532:             .Left = 3
533:             .Width = 358
534:             .Height = 147
535:             .RecordMark = .F.
536:             .DeleteMark = .F.
537:             .ReadOnly = .T.
538: 
539:             *-- Headers transcritos de SIGPRGLX.PageDados.Page1.Container3.
540:             *-- GradeDisp (dump task618, linhas 1215-1340): "Atual" (Saldo) e
541:             *-- "Utilizado" (Saldo-Disps) - nao "Saldo"/"Reservado".
542:             .Column1.ControlSource = "cursor_4c_TmpSaldg.Grupos"
543:             .Column1.Header1.Caption = "Grupo"
544:             .Column2.ControlSource = "cursor_4c_TmpSaldg.Estos"
545:             .Column2.Header1.Caption = "Conta"
546:             .Column3.ControlSource = "cursor_4c_TmpSaldg.Saldo"
547:             .Column3.Header1.Caption = "Atual"
548:             .Column4.ControlSource = "cursor_4c_TmpSaldg.Saldo - cursor_4c_TmpSaldg.Disps"
549:             .Column4.Header1.Caption = "Utilizado"
550:             .Column5.ControlSource = "cursor_4c_TmpSaldg.Disps"
551:             .Column5.Header1.Caption = "Disponivel"
552:             .Column6.ControlSource = "cursor_4c_TmpSaldg.Priors"
553:             .Column6.Header1.Caption = "Prior"
554:             .Column6.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
555:         ENDWITH
556:         BINDEVENT(loc_oCnt.grd_4c_DispGrupo.Column6.Text1, "KeyPress", THIS, "GradeDispGrupoColumn6LostFocus")
557: 
558:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
559:         WITH loc_oCnt.lbl_4c_Label2
560:             .AutoSize = .F.
561:             .Top = 163
562:             .Left = 128
563:             .Width = 42
564:             .Height = 17
565:             .FontBold = .T.
566:             .BackStyle = 0
567:             .ForeColor = RGB(90, 90, 90)
568:             .Caption = "Totais :"
569:         ENDWITH
570: 
571:         loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
572:         WITH loc_oCnt.txt_4c_Tot_Qtd
573:             .Top = 161
574:             .Left = 174
575:             .Width = 58
576:             .Height = 19
577:             .InputMask = "999,999.99"
578:             .ReadOnly = .T.
579:             .Value = 0
580:         ENDWITH
581:         loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
582:         WITH loc_oCnt.txt_4c_Tot_Est
583:             .Top = 161
584:             .Left = 234
585:             .Width = 58
586:             .Height = 19
587:             .InputMask = "999,999.99"
588:             .ReadOnly = .T.
589:             .Value = 0
590:         ENDWITH
591:         loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
592:         WITH loc_oCnt.txt_4c_Tot_Prz
593:             .Top = 161
594:             .Left = 292
595:             .Width = 58
596:             .Height = 19
597:             .InputMask = "999,999.99"
598:             .ReadOnly = .T.
599:             .Value = 0
600:         ENDWITH
601: 
602:         *-- Container1 "Estoque Em Producao" (fase, TmpFabr) ---------------
603:         loc_oPag1.AddObject("cnt_4c_Container1", "Container")
604:         loc_oCnt = loc_oPag1.cnt_4c_Container1
605:         WITH loc_oCnt
606:             .Top = 371
607:             .Left = 418
608:             .Width = 308
609:             .Height = 136
610:             .BackStyle = 0
611:             .BorderWidth = 0
612:         ENDWITH
613: 
614:         loc_oCnt.AddObject("lbl_4c_label12", "Label")
615:         WITH loc_oCnt.lbl_4c_label12
616:             .AutoSize = .F.
617:             .Top = 1
618:             .Left = 1
619:             .Width = 305
620:             .Height = 16
621:             .FontBold = .T.
622:             .BackStyle = 0
623:             .ForeColor = RGB(90, 90, 90)
624:             .Caption = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
625:         ENDWITH
626: 
627:         loc_oCnt.AddObject("grd_4c_DispFase", "Grid")
628: 
629:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
630:         *-- antes de o bloco abaixo acessar .Column1..Column6.
631:         loc_oCnt.grd_4c_DispFase.RecordSource = ""
632:         loc_oCnt.grd_4c_DispFase.ColumnCount = 6
633:         loc_oCnt.grd_4c_DispFase.RecordSource = "cursor_4c_TmpFabr"
634: 
635:         WITH loc_oCnt.grd_4c_DispFase
636:             .Top = 15
637:             .Left = 2
638:             .Width = 303
639:             .Height = 99
640:             .RecordMark = .F.
641:             .DeleteMark = .F.
642:             .ReadOnly = .T.
643: 
644:             .Column1.ControlSource = "cursor_4c_TmpFabr.Fases"
645:             .Column1.Header1.Caption = "Fase"
646:             .Column2.ControlSource = "cursor_4c_TmpFabr.Qtds"
647:             .Column2.Header1.Caption = "Quantidade"
648:             .Column3.ControlSource = "cursor_4c_TmpFabr.Disps"
649:             .Column3.Header1.Caption = "Disponivel"
650:             .Column4.ControlSource = "cursor_4c_TmpFabr.Priors"
651:             .Column4.Header1.Caption = "Prior"
652:             .Column4.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
653:             .Column5.ControlSource = ""
654:             .Column5.Header1.Caption = ""
655:             .Column6.ControlSource = "cursor_4c_TmpFabr.Nops"
656:             .Column6.Header1.Caption = "Nop"
657:             .Column6.Visible = .F.
658:         ENDWITH
659:         BINDEVENT(loc_oCnt.grd_4c_DispFase.Column4.Text1, "KeyPress", THIS, "GradeDispFaseColumn4LostFocus")
660: 
661:         loc_oCnt.AddObject("lbl_4c_label22", "Label")
662:         WITH loc_oCnt.lbl_4c_label22
663:             .AutoSize = .F.
664:             .Top = 115
665:             .Left = 102
666:             .Width = 42
667:             .Height = 17
668:             .FontBold = .T.
669:             .BackStyle = 0
670:             .ForeColor = RGB(90, 90, 90)
671:             .Caption = "Totais :"
672:         ENDWITH
673:         loc_oCnt.AddObject("txt_4c_tot_qtd2", "TextBox")
674:         WITH loc_oCnt.txt_4c_tot_qtd2
675:             .Top = 113
676:             .Left = 145
677:             .Width = 61
678:             .Height = 19
679:             .InputMask = "999,999.99"
680:             .ReadOnly = .T.
681:             .Value = 0
682:         ENDWITH
683:         loc_oCnt.AddObject("txt_4c_tot_est2", "TextBox")
684:         WITH loc_oCnt.txt_4c_tot_est2
685:             .Top = 113
686:             .Left = 207
687:             .Width = 61
688:             .Height = 19
689:             .InputMask = "999,999.99"
690:             .ReadOnly = .T.
691:             .Value = 0
692:         ENDWITH
693: 
694:         *-- Container5 "Periodo/Referencia Analisada" ----------------------
695:         loc_oPag1.AddObject("cnt_4c_Container5", "Container")
696:         loc_oCnt = loc_oPag1.cnt_4c_Container5
697:         WITH loc_oCnt
698:             .Top = 129
699:             .Left = 36
700:             .Width = 727
701:             .Height = 40
702:             .BackStyle = 0
703:             .BorderWidth = 0
704:         ENDWITH
705: 
706:         loc_oCnt.AddObject("lbl_4c_LabPeriodo", "Label")
707:         WITH loc_oCnt.lbl_4c_LabPeriodo
708:             .AutoSize = .F.
709:             .Top = 2
710:             .Left = 8
711:             .Width = 105
712:             .Height = 15
713:             .BackStyle = 0
714:             .ForeColor = RGB(90, 90, 90)
715:             .Caption = "Per" + CHR(237) + "odo:"
716:         ENDWITH
717:         loc_oCnt.AddObject("lbl_4c_LabProduto", "Label")
718:         WITH loc_oCnt.lbl_4c_LabProduto
719:             .AutoSize = .F.
720:             .Top = 18
721:             .Left = 8
722:             .Width = 127
723:             .Height = 15
724:             .BackStyle = 0
725:             .ForeColor = RGB(90, 90, 90)
726:             .Caption = "Refer" + CHR(234) + "ncia Analisada :"
727:         ENDWITH
728:         loc_oCnt.AddObject("txt_4c_Cpros", "TextBox")
729:         WITH loc_oCnt.txt_4c_Cpros
730:             .Top = 16
731:             .Left = 141
732:             .Width = 108
733:             .Height = 19
734:             .ReadOnly = .T.
735:             .ControlSource = "TmpFinalg.Cpros"
736:         ENDWITH
737:         loc_oCnt.AddObject("lbl_4c_label13", "Label")
738:         WITH loc_oCnt.lbl_4c_label13
739:             .AutoSize = .F.
740:             .Top = 18
741:             .Left = 269
742:             .Width = 83
743:             .Height = 15
744:             .BackStyle = 0
745:             .ForeColor = RGB(90, 90, 90)
746:             .Caption = "Qtde Vendida :"
747:         ENDWITH
748:         loc_oCnt.AddObject("txt_4c_Tot_Venda", "TextBox")
749:         WITH loc_oCnt.txt_4c_Tot_Venda
750:             .Top = 17
751:             .Left = 349
752:             .Width = 80
753:             .Height = 19
754:             .InputMask = "999,999.99"
755:             .ReadOnly = .T.
756:             .ControlSource = "TmpFinalg.TotVenda"
757:         ENDWITH
758:         loc_oCnt.AddObject("lbl_4c_label23", "Label")
759:         WITH loc_oCnt.lbl_4c_label23
760:             .AutoSize = .F.
761:             .Top = 18
762:             .Left = 448
763:             .Width = 164
764:             .Height = 15
765:             .BackStyle = 0
766:             .ForeColor = RGB(90, 90, 90)
767:             .Caption = "Qtde M" + CHR(237) + "nima Para Produ" + CHR(231) + CHR(227) + "o :"
768:         ENDWITH
769:         loc_oCnt.AddObject("txt_4c_Minima", "TextBox")
770:         WITH loc_oCnt.txt_4c_Minima
771:             .Top = 17
772:             .Left = 623
773:             .Width = 80
774:             .Height = 19
775:             .InputMask = "999,999.99"
776:             .ReadOnly = .T.
777:             .ControlSource = "TmpFinalg.QtdMins"
778:         ENDWITH
779: 
780:         *-- Imagem do produto corrente (SigCdPro.FigJpgs) ------------------
781:         loc_oPag1.AddObject("img_4c_FigJpg", "Image")
782:         WITH loc_oPag1.img_4c_FigJpg
783:             .Top = 255
784:             .Left = 646
785:             .Width = 122
786:             .Height = 89
787:             .Stretch = 1
788:             .Visible = .F.
789:         ENDWITH
790:         BINDEVENT(loc_oPag1.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgPage1DblClick")
791: 
792:         *-- Totais gerais da pagina (soma de TmpFinalg) --------------------
793:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
794:         WITH loc_oPag1.lbl_4c_Label1
795:             .AutoSize = .F.
796:             .Top = 348
797:             .Left = 224
798:             .Width = 42
799:             .Height = 17
800:             .FontBold = .T.
801:             .BackStyle = 0
802:             .ForeColor = RGB(90, 90, 90)
803:             .Caption = "Totais :"
804:         ENDWITH
805:         loc_oPag1.AddObject("txt_4c_Tot_Qtd", "TextBox")
806:         WITH loc_oPag1.txt_4c_Tot_Qtd
807:             .Top = 346
808:             .Left = 271
809:             .Width = 67
810:             .Height = 19
811:             .InputMask = "999,999.99"
812:             .ReadOnly = .T.
813:             .Value = 0
814:         ENDWITH
815:         loc_oPag1.AddObject("txt_4c_Tot_prdc", "TextBox")
816:         WITH loc_oPag1.txt_4c_Tot_prdc
817:             .Top = 346
818:             .Left = 339
819:             .Width = 67
820:             .Height = 19
821:             .InputMask = "999,999.99"
822:             .ReadOnly = .T.
823:             .Value = 0
824:         ENDWITH
825:         loc_oPag1.AddObject("txt_4c_Tot_Est", "TextBox")
826:         WITH loc_oPag1.txt_4c_Tot_Est
827:             .Top = 346
828:             .Left = 407
829:             .Width = 68
830:             .Height = 19
831:             .InputMask = "999,999.99"
832:             .ReadOnly = .T.
833:             .Value = 0
834:         ENDWITH
835:         loc_oPag1.AddObject("txt_4c_Tot_Prz", "TextBox")
836:         WITH loc_oPag1.txt_4c_Tot_Prz
837:             .Top = 346
838:             .Left = 476
839:             .Width = 67
840:             .Height = 19
841:             .InputMask = "999,999.99"
842:             .ReadOnly = .T.
843:             .Value = 0
844:         ENDWITH
845:         loc_oPag1.AddObject("txt_4c_Tot_prze", "TextBox")
846:         WITH loc_oPag1.txt_4c_Tot_prze
847:             .Top = 346
848:             .Left = 543
849:             .Width = 75
850:             .Height = 19
851:             .InputMask = "999,999.99"
852:             .ReadOnly = .T.
853:             .Value = 0

*-- Linhas 859 a 948:
859:         *-- exibe por tipo de estoque (TipoEstos) e o restante dos Click
860:         *-- (Processar/TotLinha/Alteraqtd/Pedras/Cancelar) entra na fase de
861:         *-- eventos/handlers.
862:         loc_oPag1.AddObject("cmd_4c_Pedras", "CommandButton")
863:         WITH loc_oPag1.cmd_4c_Pedras
864:             .Top     = 2
865:             .Left    = 348
866:             .Width   = 75
867:             .Height  = 75
868:             .Caption = "\<Requisi" + CHR(231) + CHR(245) + "es"
869:             .Visible = .F.
870:         ENDWITH
871:         BINDEVENT(loc_oPag1.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")
872: 
873:         loc_oPag1.AddObject("cmd_4c_SelEstoque", "CommandButton")
874:         WITH loc_oPag1.cmd_4c_SelEstoque
875:             .Top     = 2
876:             .Left    = 423
877:             .Width   = 75
878:             .Height  = 75
879:             .Caption = "\<Estoques"
880:             .Visible = THIS.this_lPermiteAjustarPrioridade()
881:         ENDWITH
882:         BINDEVENT(loc_oPag1.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
883: 
884:         loc_oPag1.AddObject("cmd_4c_Disponivel", "CommandButton")
885:         WITH loc_oPag1.cmd_4c_Disponivel
886:             .Top     = 2
887:             .Left    = 498
888:             .Width   = 75
889:             .Height  = 75
890:             .Caption = "\<Disponiveis"
891:             .Visible = .F.
892:         ENDWITH
893:         BINDEVENT(loc_oPag1.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
894: 
895:         loc_oPag1.AddObject("cmd_4c_TotLinha", "CommandButton")
896:         WITH loc_oPag1.cmd_4c_TotLinha
897:             .Top     = 2
898:             .Left    = 573
899:             .Width   = 75
900:             .Height  = 75
901:             .Caption = "\<Total/Linhas"
902:         ENDWITH
903:         BINDEVENT(loc_oPag1.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")
904: 
905:         loc_oPag1.AddObject("cmd_4c_Processar", "CommandButton")
906:         WITH loc_oPag1.cmd_4c_Processar
907:             .Top     = 2
908:             .Left    = 648
909:             .Width   = 75
910:             .Height  = 75
911:             .Caption = "\<Processar"
912:         ENDWITH
913:         BINDEVENT(loc_oPag1.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
914: 
915:         loc_oPag1.AddObject("cmd_4c_Cancelar", "CommandButton")
916:         WITH loc_oPag1.cmd_4c_Cancelar
917:             .Top     = 2
918:             .Left    = 723
919:             .Width   = 75
920:             .Height  = 75
921:             .Caption = "Encerrar"
922:         ENDWITH
923:         BINDEVENT(loc_oPag1.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
924: 
925:         loc_oPag1.AddObject("cmd_4c_Alteraqtd", "CommandButton")
926:         WITH loc_oPag1.cmd_4c_Alteraqtd
927:             .Top     = 189
928:             .Left    = 687
929:             .Width   = 40
930:             .Height  = 40
931:             .Caption = ""
932:         ENDWITH
933:         BINDEVENT(loc_oPag1.cmd_4c_Alteraqtd, "Click", THIS, "BtnAlteraqtdClick")
934:     ENDPROC
935: 
936:     *--------------------------------------------------------------------------
937:     * ConfigurarPaginaDados - completa a Page2 (SIGPRGLX.PageDados.Page2 no
938:     * legado) com a grade de selecao de linha (GradeItens -> grd_4c_Dados,
939:     * ligada ao cursor TmpFinal do legado), os totais GERAL (Label1 "Totais :"
940:     * + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc, azul) e SELECIONADO (Label2 "Qtd
941:     * Selecionada :" + Tot_sEst/Tot_sPrc, vermelho), a imagem do produto
942:     * corrente (img_4c_FigJpg), a observacao do item (obj_4c_ObsItens +
943:     * lbl_4c_Txt_ObsItens) e o botao Cancelar/Voltar - ver
944:     * tasks/task618/SigPrGlx_form_codigo_fonte.txt linhas 2386-2924.
945:     *
946:     * Page2 NAO tem nenhum campo de lookup (F4/fwBuscaExt) no legado - todas
947:     * as colunas da grade sao ReadOnly (dados ja resolvidos na Page1) ou
948:     * quantidade editavel validada por faixa (Column7/Column10.Valid, fase

*-- Linhas 997 a 1006:
997:         loc_oPag2.grd_4c_Dados.RecordSource = "TmpFinal"
998: 
999:         WITH loc_oPag2.grd_4c_Dados
1000:             .Top          = 181
1001:             .Left         = 53
1002:             .Width        = 703
1003:             .Height       = 189
1004:             .FontName     = "Tahoma"
1005:             .FontSize     = 8
1006:             .AllowHeaderSizing = .F.

*-- Linhas 1012 a 1068:
1012:             .ReadOnly     = .F.
1013: 
1014:             .Column1.ControlSource = "TmpFinal.Cpros"
1015:             .Column1.Header1.Caption = "Produto"
1016:             .Column1.Width = 108
1017:             .Column1.ReadOnly = .T.
1018: 
1019:             .Column2.ControlSource = "TmpFinal.CodCors"
1020:             .Column2.Header1.Caption = "Cor"
1021:             .Column2.Width = 38
1022:             .Column2.ReadOnly = .T.
1023: 
1024:             .Column3.ControlSource = "TmpFinal.Dopes"
1025:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1026:             .Column3.Width = 150
1027:             .Column3.ReadOnly = .T.
1028: 
1029:             .Column4.ControlSource = "TmpFinal.Numes"
1030:             .Column4.Header1.Caption = "N" + CHR(250) + "mero"
1031:             .Column4.Width = 47
1032:             .Column4.ReadOnly = .T.
1033: 
1034:             .Column5.ControlSource = "TmpFinal.Saldo"
1035:             .Column5.Header1.Caption = "Quantidade"
1036:             .Column5.Width = 65
1037:             .Column5.ReadOnly = .T.
1038: 
1039:             .Column6.ControlSource = "TmpFinal.Produzir"
1040:             .Column6.Header1.Caption = "Produzir"
1041:             .Column6.Width = 65
1042:             .Column6.ReadOnly = .T.
1043: 
1044:             .Column7.ControlSource = "TmpFinal.Estoque"
1045:             .Column7.Header1.Caption = "Estoque"
1046:             .Column7.Width = 65
1047:             .Column7.ReadOnly = .F.
1048:             .Column7.BackColor = RGB(255, 255, 204)
1049:             .Column7.Text1.FontBold = .T.
1050:             .Column7.Text1.BackColor = RGB(255, 255, 204)
1051: 
1052:             .Column8.ControlSource = [IIF(!EMPTY(TmpFinal.Obsps), "*", "")]
1053:             .Column8.Header1.Caption = "Obs"
1054:             .Column8.Width = 21
1055:             .Column8.ReadOnly = .T.
1056: 
1057:             .Column9.ControlSource = "TmpFinal.CodTams"
1058:             .Column9.Header1.Caption = "Tam"
1059:             .Column9.Width = 38
1060:             .Column9.ReadOnly = .T.
1061: 
1062:             .Column10.ControlSource = "TmpFinal.Fabrs"
1063:             .Column10.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
1064:             .Column10.Width = 65
1065:             .Column10.ReadOnly = .F.
1066:             .Column10.BackColor = RGB(255, 255, 204)
1067:             .Column10.Text1.FontBold = .T.
1068:             .Column10.Text1.BackColor = RGB(255, 255, 204)

*-- Linhas 1098 a 1166:
1098:         *-- total GERAL em azul). Parte 2 (Label2/Tot_sEst/Tot_sPrc = total
1099:         *-- SELECIONADO em vermelho, ImgFigJpg, ObsItens, Txt_ObsItens e o
1100:         *-- botao Cancelar) vem a seguir.
1101:         loc_oPag2.AddObject("lbl_4c_Label1", "Label")
1102:         WITH loc_oPag2.lbl_4c_Label1
1103:             .AutoSize  = .F.
1104:             .Top       = 372
1105:             .Left      = 403
1106:             .Width     = 42
1107:             .Height    = 17
1108:             .FontName  = "Tahoma"
1109:             .FontSize  = 8
1110:             .FontBold  = .T.
1111:             .BackStyle = 0
1112:             .ForeColor = RGB(90, 90, 90)
1113:             .Caption   = "Totais :"
1114:         ENDWITH
1115: 
1116:         loc_oPag2.AddObject("txt_4c_Tot_Qtd", "TextBox")
1117:         WITH loc_oPag2.txt_4c_Tot_Qtd
1118:             .Top       = 370
1119:             .Left      = 449
1120:             .Width     = 68
1121:             .Height    = 19
1122:             .FontBold  = .T.
1123:             .InputMask = "999,999.99"
1124:             .Margin    = 0
1125:             .ReadOnly  = .T.
1126:             .ForeColor = RGB(0, 0, 255)
1127:             .Value     = 0
1128:         ENDWITH
1129: 
1130:         loc_oPag2.AddObject("txt_4c_Tot_Est", "TextBox")
1131:         WITH loc_oPag2.txt_4c_Tot_Est
1132:             .Top       = 370
1133:             .Left      = 516
1134:             .Width     = 67
1135:             .Height    = 19
1136:             .FontBold  = .T.
1137:             .InputMask = "999,999.99"
1138:             .Margin    = 0
1139:             .ReadOnly  = .T.
1140:             .ForeColor = RGB(0, 0, 255)
1141:             .Value     = 0
1142:         ENDWITH
1143: 
1144:         loc_oPag2.AddObject("txt_4c_Tot_prc", "TextBox")
1145:         WITH loc_oPag2.txt_4c_Tot_prc
1146:             .Top       = 370
1147:             .Left      = 581
1148:             .Width     = 67
1149:             .Height    = 19
1150:             .FontBold  = .T.
1151:             .InputMask = "999,999.99"
1152:             .Margin    = 0
1153:             .ReadOnly  = .T.
1154:             .ForeColor = RGB(0, 0, 255)
1155:             .Value     = 0
1156:         ENDWITH
1157: 
1158:         loc_oPag2.AddObject("txt_4c_Tot_Prz", "TextBox")
1159:         WITH loc_oPag2.txt_4c_Tot_Prz
1160:             .Top       = 370
1161:             .Left      = 648
1162:             .Width     = 67
1163:             .Height    = 19
1164:             .FontBold  = .T.
1165:             .InputMask = "999,999.99"
1166:             .Margin    = 0

*-- Linhas 1173 a 1213:
1173:         *-- Label2/Tot_sEst/Tot_sPrc = "Qtd Selecionada" (Estoque/Producao
1174:         *-- somados pelo usuario nas sub-paginas 4/5/6), em VERMELHO para
1175:         *-- destacar do total GERAL (Label1, em azul) acima.
1176:         loc_oPag2.AddObject("lbl_4c_Label2", "Label")
1177:         WITH loc_oPag2.lbl_4c_Label2
1178:             .AutoSize  = .F.
1179:             .Top       = 164
1180:             .Left      = 383
1181:             .Width     = 119
1182:             .Height    = 15
1183:             .FontName  = "Tahoma"
1184:             .FontSize  = 8
1185:             .FontBold  = .T.
1186:             .BackStyle = 0
1187:             .ForeColor = RGB(90, 90, 90)
1188:             .Caption   = "Qtd Selecionada : "
1189:         ENDWITH
1190: 
1191:         loc_oPag2.AddObject("txt_4c_Tot_sEst", "TextBox")
1192:         WITH loc_oPag2.txt_4c_Tot_sEst
1193:             .Top       = 162
1194:             .Left      = 501
1195:             .Width     = 67
1196:             .Height    = 19
1197:             .FontBold  = .T.
1198:             .InputMask = "999,999.99"
1199:             .Margin    = 0
1200:             .ReadOnly  = .T.
1201:             .ForeColor = RGB(255, 0, 0)
1202:             .Value     = 0
1203:         ENDWITH
1204: 
1205:         loc_oPag2.AddObject("txt_4c_Tot_sPrc", "TextBox")
1206:         WITH loc_oPag2.txt_4c_Tot_sPrc
1207:             .Top       = 162
1208:             .Left      = 567
1209:             .Width     = 67
1210:             .Height    = 19
1211:             .FontBold  = .T.
1212:             .InputMask = "999,999.99"
1213:             .Margin    = 0

*-- Linhas 1221 a 1314:
1221:         *-- como no legado (Visible=.F.) - so aparece quando ha figura.
1222:         loc_oPag2.AddObject("img_4c_FigJpg", "Image")
1223:         WITH loc_oPag2.img_4c_FigJpg
1224:             .Top         = 394
1225:             .Left        = 73
1226:             .Width       = 135
1227:             .Height      = 92
1228:             .Stretch     = 1
1229:             .Visible     = .F.
1230:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
1231:         ENDWITH
1232: 
1233:         *-- Observacao do item corrente (TmpFinal.Obsps) - EditBox somente
1234:         *-- leitura, com label de titulo que a fase de eventos atualiza com
1235:         *-- o codigo do produto (Txt_ObsItens.Caption, no AfterRowColChange).
1236:         loc_oPag2.AddObject("lbl_4c_Txt_ObsItens", "Label")
1237:         WITH loc_oPag2.lbl_4c_Txt_ObsItens
1238:             .AutoSize  = .F.
1239:             .Top       = 400
1240:             .Left      = 221
1241:             .Width     = 119
1242:             .Height    = 17
1243:             .FontName  = "Tahoma"
1244:             .FontSize  = 8
1245:             .WordWrap  = .T.
1246:             .BackStyle = 0
1247:             .ForeColor = RGB(90, 90, 90)
1248:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
1249:         ENDWITH
1250: 
1251:         loc_oPag2.AddObject("obj_4c_ObsItens", "EditBox")
1252:         WITH loc_oPag2.obj_4c_ObsItens
1253:             .Top            = 415
1254:             .Left           = 221
1255:             .Width          = 396
1256:             .Height         = 69
1257:             .ReadOnly       = .T.
1258:             .ControlSource  = "TmpFinal.Obsps"
1259:         ENDWITH
1260: 
1261:         *-- Cancelar/Voltar da Page2 (volta para a grade principal - Page1 -
1262:         *-- apos validar que Estoque/Producao selecionados fecham com o que
1263:         *-- foi reservado nas sub-paginas; validacao real na fase de eventos).
1264:         loc_oPag2.AddObject("cmd_4c_Cancelar", "CommandButton")
1265:         WITH loc_oPag2.cmd_4c_Cancelar
1266:             .Top         = 12
1267:             .Left        = 704
1268:             .Width       = 75
1269:             .Height      = 75
1270:             .FontBold    = .T.
1271:             .FontItalic  = .T.
1272:             .FontName    = "Comic Sans MS"
1273:             .FontSize    = 8
1274:             .WordWrap    = .T.
1275:             .Cancel      = .T.
1276:             .Caption     = "Voltar"
1277:             .ForeColor   = RGB(90, 90, 90)
1278:             .BackColor   = RGB(255, 255, 255)
1279:             .Themes      = .T.
1280:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1281:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1282:         ENDWITH
1283:         BINDEVENT(loc_oPag2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarPage2Click")
1284:     ENDPROC
1285: 
1286: 
1287:     *--------------------------------------------------------------------------
1288:     * ConfigurarPaginaTotaisLinha - Page3 (SIGPRGLX.PageDados.Page3): grade
1289:     * de totais consolidados por linha de produto (GradeLinhas -> TmpLinha no
1290:     * legado, alimentada pelo Click de cmd_4c_TotLinha). Toda a grade eh
1291:     * somente-leitura no legado (Grid.ReadOnly = .T.), portanto NAO tem
1292:     * lookup - nao ha onde digitar codigo para o picker resolver.
1293:     *
1294:     * Posicoes/Top/Left transcritas da secao "PROPRIEDADES DE:
1295:     * SIGPRGLX.PageDados.Page3.*" do dump legado, SEM compensacao de
1296:     * PageFrame (mesmo criterio das Fases 3-5 deste form, cujo
1297:     * pgf_4c_1.Top = -27 veio cru do SCX).
1298:     *
1299:     * cursor_4c_Linhas eh o cursor de apoio desta grade (TmpLinha no legado) -
1300:     * a estrutura aqui tem de bater EXATAMENTE com a do SELECT que a popula
1301:     * depois (regra do cursor de apoio / APPEND FROM casa por NOME).
1302:     *--------------------------------------------------------------------------
1303:     PROTECTED PROCEDURE ConfigurarPaginaTotaisLinha()
1304:         LOCAL loc_oPag3, loc_nCol
1305: 
1306:         loc_oPag3 = THIS.pgf_4c_1.Page3
1307: 
1308:         WITH loc_oPag3
1309:             .Caption   = "Totais por Linha"
1310:             .FontBold  = .T.
1311:             .ForeColor = RGB(0, 128, 192)
1312:             .Enabled   = .F.
1313:         ENDWITH
1314: 

*-- Linhas 1321 a 1348:
1321:         SET NULL OFF
1322: 
1323:         *-- Titulo da sub-tela (Label2 + Shape4 no legado) ------------------
1324:         loc_oPag3.AddObject("lbl_4c_Label2", "Label")
1325:         WITH loc_oPag3.lbl_4c_Label2
1326:             .AutoSize   = .F.
1327:             .Top        = 147
1328:             .Left       = 173
1329:             .Width      = 157
1330:             .Height     = 25
1331:             .FontName   = "Tahoma"
1332:             .FontSize   = 14
1333:             .FontBold   = .T.
1334:             .FontItalic = .T.
1335:             .BackStyle  = 0
1336:             .ForeColor  = RGB(90, 90, 90)
1337:             .Caption    = "Totais por Linha"
1338:         ENDWITH
1339: 
1340:         loc_oPag3.AddObject("shp_4c_Shape4", "Shape")
1341:         WITH loc_oPag3.shp_4c_Shape4
1342:             .Top         = 169
1343:             .Left        = 168
1344:             .Width       = 437
1345:             .Height      = 2
1346:             .BorderWidth = 1
1347:         ENDWITH
1348: 

*-- Linhas 1356 a 1365:
1356:         loc_oPag3.grd_4c_Linhas.RecordSource = "cursor_4c_Linhas"
1357: 
1358:         WITH loc_oPag3.grd_4c_Linhas
1359:             .Top          = 181
1360:             .Left         = 167
1361:             .Width        = 438
1362:             .Height       = 292
1363:             .FontName     = "Tahoma"
1364:             .FontSize     = 8
1365:             .AllowHeaderSizing = .F.

*-- Linhas 1373 a 1420:
1373:             .ReadOnly     = .T.
1374: 
1375:             .Column1.ControlSource = "cursor_4c_Linhas.Linhas"
1376:             .Column1.Header1.Caption = "Linha"
1377:             .Column1.Width     = 84
1378:             .Column1.Movable   = .F.
1379:             .Column1.Resizable = .F.
1380:             .Column1.Sparse    = .F.
1381:             .Column1.ReadOnly  = .T.
1382:             .Column1.ForeColor = RGB(36, 84, 155)
1383: 
1384:             .Column2.ControlSource = "cursor_4c_Linhas.Saldo"
1385:             .Column2.Header1.Caption = "Quantidade"
1386:             .Column2.Width     = 80
1387:             .Column2.Movable   = .F.
1388:             .Column2.Resizable = .F.
1389:             .Column2.Sparse    = .F.
1390:             .Column2.ReadOnly  = .T.
1391:             .Column2.Text1.InputMask = "999,999.99"
1392:             .Column2.Text1.MaxLength = 10
1393: 
1394:             .Column3.ControlSource = "cursor_4c_Linhas.Estoque"
1395:             .Column3.Header1.Caption = "Estoque"
1396:             .Column3.Width     = 80
1397:             .Column3.Movable   = .F.
1398:             .Column3.Resizable = .F.
1399:             .Column3.Sparse    = .F.
1400:             .Column3.ReadOnly  = .T.
1401:             .Column3.Text1.InputMask = "999,999.99"
1402:             .Column3.Text1.MaxLength = 10
1403: 
1404:             .Column4.ControlSource = "cursor_4c_Linhas.Fabrs"
1405:             .Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
1406:             .Column4.Width     = 80
1407:             .Column4.Movable   = .F.
1408:             .Column4.Resizable = .F.
1409:             .Column4.Sparse    = .F.
1410:             .Column4.ReadOnly  = .T.
1411:             .Column4.Text1.InputMask = "999,999.99"
1412:             .Column4.Text1.MaxLength = 10
1413: 
1414:             .Column5.ControlSource = "cursor_4c_Linhas.Produzir"
1415:             .Column5.Header1.Caption = "Produzir"
1416:             .Column5.Width     = 80
1417:             .Column5.Movable   = .F.
1418:             .Column5.Resizable = .F.
1419:             .Column5.Sparse    = .F.
1420:             .Column5.ReadOnly  = .T.

*-- Linhas 1430 a 1469:
1430:                 .ForeColor = RGB(36, 84, 155)
1431:             ENDWITH
1432:         ENDFOR
1433: 
1434:         *-- Voltar (CancelaLin) --------------------------------------------
1435:         loc_oPag3.AddObject("cmd_4c_CancelaLin", "CommandButton")
1436:         WITH loc_oPag3.cmd_4c_CancelaLin
1437:             .Top         = 12
1438:             .Left        = 704
1439:             .Width       = 75
1440:             .Height      = 75
1441:             .FontName    = "Comic Sans MS"
1442:             .FontSize    = 8
1443:             .FontBold    = .T.
1444:             .FontItalic  = .T.
1445:             .WordWrap    = .T.
1446:             .Cancel      = .T.
1447:             .Caption     = "Voltar"
1448:             .ForeColor   = RGB(90, 90, 90)
1449:             .BackColor   = RGB(255, 255, 255)
1450:             .Themes      = .T.
1451:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1452:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1453:         ENDWITH
1454:         BINDEVENT(loc_oPag3.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLinClick")
1455:     ENDPROC
1456: 
1457:     *--------------------------------------------------------------------------
1458:     * ConfigurarPaginaEstoque - Page4 (SIGPRGLX.PageDados.Page4, "Selecionar
1459:     * Estoque"): grade de saldo disponivel POR GRUPO/CONTA (GradeDisp ->
1460:     * TmpDisp no legado, montado pelo Click de cmd_4c_SelEstoque a partir de
1461:     * TmpSaldG) mais os totalizadores Qtde Pedida / Qtde Selecionada.
1462:     *
1463:     * No legado as Pages 4 e 5 compartilham o MESMO alias TmpDisp, recriado
1464:     * com estruturas DIFERENTES a cada clique (Page4 traz Grupo/Conta/Prior,
1465:     * Page5 traz Produto/Cor/Tam). Aqui cada grade recebe o SEU cursor
1466:     * (cursor_4c_DispEstoque / cursor_4c_DispTamanho): manter o alias
1467:     * compartilhado obrigaria a derrubar o alias ligado a outra grade, o que
1468:     * zera o ColumnCount dela e a deixa morta pelo resto da vida do form.
1469:     * Divergencia de CODIGO (PILAR 3) - o que o usuario ve eh identico.

*-- Linhas 1478 a 1486:
1478:         loc_oPag4 = THIS.pgf_4c_1.Page4
1479: 
1480:         WITH loc_oPag4
1481:             .Caption    = "Selecionar Estoque"
1482:             .FontBold   = .T.
1483:             .FontItalic = .T.
1484:             .ForeColor  = RGB(0, 128, 192)
1485:             .Enabled    = .F.
1486:         ENDWITH

*-- Linhas 1495 a 1534:
1495:         SET NULL OFF
1496: 
1497:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1498:         loc_oPag4.AddObject("lbl_4c_Label1", "Label")
1499:         WITH loc_oPag4.lbl_4c_Label1
1500:             .AutoSize   = .F.
1501:             .Top        = 138
1502:             .Left       = 197
1503:             .Width      = 184
1504:             .Height     = 25
1505:             .FontName   = "Tahoma"
1506:             .FontSize   = 14
1507:             .FontBold   = .T.
1508:             .FontItalic = .T.
1509:             .BackStyle  = 0
1510:             .ForeColor  = RGB(90, 90, 90)
1511:             .Caption    = "Selecionar Estoque"
1512:         ENDWITH
1513: 
1514:         loc_oPag4.AddObject("shp_4c_Shape4", "Shape")
1515:         WITH loc_oPag4.shp_4c_Shape4
1516:             .Top         = 159
1517:             .Left        = 191
1518:             .Width       = 370
1519:             .Height      = 2
1520:             .BorderWidth = 1
1521:         ENDWITH
1522: 
1523:         *-- Produto da linha corrente da grade principal (TmpFinalg.Cpros -
1524:         *-- mesmo cursor literal usado em grd_4c_Dados.RecordSource da Page1,
1525:         *-- NAO o cursor_4c_Dados renomeado que nunca chegou a existir aqui).
1526:         loc_oPag4.AddObject("txt_4c_Cpros", "TextBox")
1527:         WITH loc_oPag4.txt_4c_Cpros
1528:             .Top           = 138
1529:             .Left          = 479
1530:             .Width         = 80
1531:             .Height        = 19
1532:             .FontBold      = .T.
1533:             .Margin        = 0
1534:             .ReadOnly      = .T.

*-- Linhas 1546 a 1555:
1546:         loc_oPag4.grd_4c_DispEstoque.RecordSource = "cursor_4c_DispEstoque"
1547: 
1548:         WITH loc_oPag4.grd_4c_DispEstoque
1549:             .Top          = 169
1550:             .Left         = 191
1551:             .Width        = 370
1552:             .Height       = 244
1553:             .FontSize     = 8
1554:             .AllowHeaderSizing = .F.
1555:             .AllowRowSizing    = .F.

*-- Linhas 1564 a 1600:
1564:             .ReadOnly     = .F.
1565: 
1566:             .Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
1567:             .Column1.Header1.Caption = "Grupo"
1568:             .Column1.Width     = 80
1569:             .Column1.Movable   = .F.
1570:             .Column1.Resizable = .F.
1571:             .Column1.ReadOnly  = .T.
1572: 
1573:             .Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
1574:             .Column2.Header1.Caption = "Conta"
1575:             .Column2.Width     = 80
1576:             .Column2.Movable   = .F.
1577:             .Column2.Resizable = .F.
1578:             .Column2.ReadOnly  = .T.
1579: 
1580:             .Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
1581:             .Column3.Header1.Caption = "Prior"
1582:             .Column3.Width     = 24
1583:             .Column3.Movable   = .F.
1584:             .Column3.Resizable = .F.
1585:             .Column3.ReadOnly  = .T.
1586: 
1587:             .Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
1588:             .Column4.Header1.Caption = "Disponivel"
1589:             .Column4.Width     = 75
1590:             .Column4.Movable   = .F.
1591:             .Column4.Resizable = .F.
1592:             .Column4.ReadOnly  = .T.
1593: 
1594:             .Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
1595:             .Column5.Header1.Caption = "Utilizar"
1596:             .Column5.Width     = 75
1597:             .Column5.Movable   = .F.
1598:             .Column5.Resizable = .F.
1599:             .Column5.ReadOnly  = .F.
1600:             .Column5.Text1.FontBold = .T.

*-- Linhas 1612 a 1711:
1612:         ENDFOR
1613: 
1614:         *-- Totalizadores da selecao ----------------------------------------
1615:         loc_oPag4.AddObject("lbl_4c_Label2", "Label")
1616:         WITH loc_oPag4.lbl_4c_Label2
1617:             .AutoSize  = .F.
1618:             .Top       = 418
1619:             .Left      = 220
1620:             .Width     = 82
1621:             .Height    = 16
1622:             .FontName  = "Tahoma"
1623:             .FontSize  = 8
1624:             .BackStyle = 0
1625:             .ForeColor = RGB(90, 90, 90)
1626:             .Caption   = "Qtde Pedida : "
1627:         ENDWITH
1628: 
1629:         loc_oPag4.AddObject("lbl_4c_Label3", "Label")
1630:         WITH loc_oPag4.lbl_4c_Label3
1631:             .AutoSize  = .F.
1632:             .Top       = 437
1633:             .Left      = 192
1634:             .Width     = 110
1635:             .Height    = 16
1636:             .FontName  = "Tahoma"
1637:             .FontSize  = 8
1638:             .BackStyle = 0
1639:             .ForeColor = RGB(90, 90, 90)
1640:             .Caption   = "Qtde Selecionada : "
1641:         ENDWITH
1642: 
1643:         loc_oPag4.AddObject("txt_4c_Qt_pedida", "TextBox")
1644:         WITH loc_oPag4.txt_4c_Qt_pedida
1645:             .Top       = 413
1646:             .Left      = 312
1647:             .Width     = 67
1648:             .Height    = 23
1649:             .InputMask = "9,999.99"
1650:             .ReadOnly  = .T.
1651:             .Value     = 0
1652:         ENDWITH
1653: 
1654:         loc_oPag4.AddObject("txt_4c_Qt_Selec", "TextBox")
1655:         WITH loc_oPag4.txt_4c_Qt_Selec
1656:             .Top       = 436
1657:             .Left      = 312
1658:             .Width     = 67
1659:             .Height    = 23
1660:             .Alignment = 3
1661:             .InputMask = "9,999.99"
1662:             .ReadOnly  = .T.
1663:             .Value     = 0
1664:         ENDWITH
1665: 
1666:         *-- Voltar (CancelaDisp) --------------------------------------------
1667:         loc_oPag4.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1668:         WITH loc_oPag4.cmd_4c_CancelaDisp
1669:             .Top         = 12
1670:             .Left        = 704
1671:             .Width       = 75
1672:             .Height      = 75
1673:             .FontName    = "Comic Sans MS"
1674:             .FontSize    = 8
1675:             .FontBold    = .T.
1676:             .FontItalic  = .T.
1677:             .WordWrap    = .T.
1678:             .Cancel      = .T.
1679:             .Caption     = "Voltar"
1680:             .ForeColor   = RGB(90, 90, 90)
1681:             .BackColor   = RGB(255, 255, 255)
1682:             .Themes      = .T.
1683:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1684:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1685:         ENDWITH
1686:         BINDEVENT(loc_oPag4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage4Click")
1687:     ENDPROC
1688: 
1689:     *--------------------------------------------------------------------------
1690:     * ConfigurarPaginaTamanhos - Page5 (SIGPRGLX.PageDados.Page5,
1691:     * "Disponivel/Tamanho"): grade do saldo disponivel QUEBRADO POR TAMANHO
1692:     * (GradeDisp -> TmpDisp no legado, montado pelo Click de
1693:     * cmd_4c_Disponivel a partir de TmpSaldo) mais os mesmos totalizadores
1694:     * Qtde Pedida / Qtde Selecionada da Page4.
1695:     *
1696:     * Cursor proprio (cursor_4c_DispTamanho) pelo motivo explicado em
1697:     * ConfigurarPaginaEstoque. Unica coluna editavel: "Utilizar" (Column5) -
1698:     * as demais sao ReadOnly, portanto esta pagina nao tem lookup.
1699:     *--------------------------------------------------------------------------
1700:     PROTECTED PROCEDURE ConfigurarPaginaTamanhos()
1701:         LOCAL loc_oPag5, loc_nCol
1702: 
1703:         loc_oPag5 = THIS.pgf_4c_1.Page5
1704: 
1705:         WITH loc_oPag5
1706:             .Caption   = "Disponivel/Tamanho"
1707:             .FontBold  = .T.
1708:             .ForeColor = RGB(0, 128, 192)
1709:             .Enabled   = .F.
1710:         ENDWITH
1711: 

*-- Linhas 1717 a 1753:
1717:         ENDIF
1718:         SET NULL OFF
1719: 
1720:         loc_oPag5.AddObject("lbl_4c_Label1", "Label")
1721:         WITH loc_oPag5.lbl_4c_Label1
1722:             .AutoSize   = .F.
1723:             .Top        = 150
1724:             .Left       = 246
1725:             .Width      = 205
1726:             .Height     = 25
1727:             .FontName   = "Tahoma"
1728:             .FontSize   = 14
1729:             .FontBold   = .T.
1730:             .FontItalic = .T.
1731:             .BackStyle  = 0
1732:             .ForeColor  = RGB(90, 90, 90)
1733:             .Caption    = "Selecionar Tamanhos"
1734:         ENDWITH
1735: 
1736:         loc_oPag5.AddObject("shp_4c_Shape4", "Shape")
1737:         WITH loc_oPag5.shp_4c_Shape4
1738:             .Top         = 171
1739:             .Left        = 240
1740:             .Width       = 328
1741:             .Height      = 2
1742:             .BorderWidth = 1
1743:         ENDWITH
1744: 
1745:         loc_oPag5.AddObject("txt_4c_Cpros", "TextBox")
1746:         WITH loc_oPag5.txt_4c_Cpros
1747:             .Top           = 151
1748:             .Left          = 486
1749:             .Width         = 80
1750:             .Height        = 19
1751:             .FontBold      = .T.
1752:             .Margin        = 0
1753:             .ReadOnly      = .T.

*-- Linhas 1764 a 1773:
1764:         loc_oPag5.grd_4c_DispTamanho.RecordSource = "cursor_4c_DispTamanho"
1765: 
1766:         WITH loc_oPag5.grd_4c_DispTamanho
1767:             .Top          = 181
1768:             .Left         = 239
1769:             .Width        = 327
1770:             .Height       = 228
1771:             .FontName     = "Tahoma"
1772:             .FontSize     = 8
1773:             .AllowHeaderSizing = .F.

*-- Linhas 1781 a 1819:
1781:             .ReadOnly     = .F.
1782: 
1783:             .Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
1784:             .Column1.Header1.Caption = "Produto"
1785:             .Column1.Width     = 80
1786:             .Column1.Movable   = .F.
1787:             .Column1.Resizable = .F.
1788:             .Column1.ReadOnly  = .T.
1789: 
1790:             .Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
1791:             .Column2.Header1.Caption = "Cor"
1792:             .Column2.Width     = 38
1793:             .Column2.Movable   = .F.
1794:             .Column2.Resizable = .F.
1795:             .Column2.ReadOnly  = .T.
1796:             .Column2.Text1.FontBold = .T.
1797: 
1798:             .Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
1799:             .Column3.Header1.Caption = "Tam"
1800:             .Column3.Width     = 24
1801:             .Column3.Movable   = .F.
1802:             .Column3.Resizable = .F.
1803:             .Column3.ReadOnly  = .T.
1804:             .Column3.Text1.FontBold = .T.
1805: 
1806:             .Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
1807:             .Column4.Header1.Caption = "Disponivel"
1808:             .Column4.Width     = 75
1809:             .Column4.Movable   = .F.
1810:             .Column4.Resizable = .F.
1811:             .Column4.ReadOnly  = .T.
1812: 
1813:             .Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
1814:             .Column5.Header1.Caption = "Utilizar"
1815:             .Column5.Width     = 75
1816:             .Column5.Movable   = .F.
1817:             .Column5.Resizable = .F.
1818:             .Column5.ReadOnly  = .F.
1819:             .Column5.Text1.FontBold = .T.

*-- Linhas 1830 a 1918:
1830:             ENDWITH
1831:         ENDFOR
1832: 
1833:         loc_oPag5.AddObject("lbl_4c_Label2", "Label")
1834:         WITH loc_oPag5.lbl_4c_Label2
1835:             .AutoSize  = .F.
1836:             .Top       = 415
1837:             .Left      = 289
1838:             .Width     = 82
1839:             .Height    = 16
1840:             .FontName  = "Tahoma"
1841:             .FontSize  = 8
1842:             .BackStyle = 0
1843:             .ForeColor = RGB(90, 90, 90)
1844:             .Caption   = "Qtde Pedida : "
1845:         ENDWITH
1846: 
1847:         loc_oPag5.AddObject("lbl_4c_Label3", "Label")
1848:         WITH loc_oPag5.lbl_4c_Label3
1849:             .AutoSize  = .F.
1850:             .Top       = 434
1851:             .Left      = 261
1852:             .Width     = 110
1853:             .Height    = 16
1854:             .FontName  = "Tahoma"
1855:             .FontSize  = 8
1856:             .BackStyle = 0
1857:             .ForeColor = RGB(90, 90, 90)
1858:             .Caption   = "Qtde Selecionada : "
1859:         ENDWITH
1860: 
1861:         loc_oPag5.AddObject("txt_4c_Qt_pedida", "TextBox")
1862:         WITH loc_oPag5.txt_4c_Qt_pedida
1863:             .Top       = 410
1864:             .Left      = 379
1865:             .Width     = 67
1866:             .Height    = 23
1867:             .InputMask = "9,999.99"
1868:             .ReadOnly  = .T.
1869:             .Value     = 0
1870:         ENDWITH
1871: 
1872:         loc_oPag5.AddObject("txt_4c_Qt_Selec", "TextBox")
1873:         WITH loc_oPag5.txt_4c_Qt_Selec
1874:             .Top       = 433
1875:             .Left      = 379
1876:             .Width     = 67
1877:             .Height    = 23
1878:             .Alignment = 3
1879:             .InputMask = "9,999.99"
1880:             .ReadOnly  = .T.
1881:             .Value     = 0
1882:         ENDWITH
1883: 
1884:         loc_oPag5.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1885:         WITH loc_oPag5.cmd_4c_CancelaDisp
1886:             .Top         = 12
1887:             .Left        = 704
1888:             .Width       = 75
1889:             .Height      = 75
1890:             .FontName    = "Comic Sans MS"
1891:             .FontSize    = 8
1892:             .FontBold    = .T.
1893:             .FontItalic  = .T.
1894:             .WordWrap    = .T.
1895:             .Cancel      = .T.
1896:             .Caption     = "Voltar"
1897:             .ForeColor   = RGB(90, 90, 90)
1898:             .BackColor   = RGB(255, 255, 255)
1899:             .Themes      = .T.
1900:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1901:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1902:         ENDWITH
1903:         BINDEVENT(loc_oPag5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage5Click")
1904:     ENDPROC
1905: 
1906:     *--------------------------------------------------------------------------
1907:     * ConfigurarPaginaRequisicao - Page6 (SIGPRGLX.PageDados.Page6,
1908:     * "Requisicao"): "Requisicao Manual de Material" (GradePedra -> SelPedra
1909:     * no legado, aberta pelo Click de cmd_4c_Pedras). Esta eh a UNICA pagina
1910:     * do form que tem campo de lookup - as duas colunas de produto
1911:     * (Column1 "Produto" = material requisitado e Column5 "Produto" =
1912:     * material substituto) tem Valid que abre o picker de SigCdPro:
1913:     *
1914:     *   SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid (linha 8093)
1915:     *   SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid (linha 8176)
1916:     *   CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
1917:     *                'CPros', This.Value, 'Selecao', 1000)
1918:     *     -> mAddColuna('CPros','','Codigo') / mAddColuna('DPros','','Descricao')

*-- Linhas 1934 a 1942:
1934:         loc_oPag6 = THIS.pgf_4c_1.Page6
1935: 
1936:         WITH loc_oPag6
1937:             .Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
1938:             .FontBold  = .T.
1939:             .ForeColor = RGB(0, 128, 192)
1940:             .Enabled   = .F.
1941:         ENDWITH
1942: 

*-- Linhas 1962 a 1999:
1962:         ENDIF
1963: 
1964:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1965:         loc_oPag6.AddObject("lbl_4c_Label1", "Label")
1966:         WITH loc_oPag6.lbl_4c_Label1
1967:             .AutoSize   = .F.
1968:             .Top        = 168
1969:             .Left       = 132
1970:             .Width      = 294
1971:             .Height     = 25
1972:             .FontName   = "Tahoma"
1973:             .FontSize   = 14
1974:             .FontBold   = .T.
1975:             .FontItalic = .T.
1976:             .BackStyle  = 0
1977:             .ForeColor  = RGB(90, 90, 90)
1978:             .Caption    = "Requisi" + CHR(231) + CHR(227) + "o Manual de Material"
1979:         ENDWITH
1980: 
1981:         loc_oPag6.AddObject("shp_4c_Shape4", "Shape")
1982:         WITH loc_oPag6.shp_4c_Shape4
1983:             .Top         = 189
1984:             .Left        = 119
1985:             .Width       = 500
1986:             .Height      = 2
1987:             .BorderWidth = 1
1988:         ENDWITH
1989: 
1990:         *-- Produto da linha corrente da grade principal (TmpFinalg.Cpros) --
1991:         loc_oPag6.AddObject("txt_4c_Cpros", "TextBox")
1992:         WITH loc_oPag6.txt_4c_Cpros
1993:             .Top           = 169
1994:             .Left          = 487
1995:             .Width         = 80
1996:             .Height        = 19
1997:             .FontBold      = .T.
1998:             .Margin        = 0
1999:             .ReadOnly      = .T.

*-- Linhas 2011 a 2020:
2011:         loc_oPag6.grd_4c_Pedra.RecordSource = "cursor_4c_Requisicao"
2012: 
2013:         WITH loc_oPag6.grd_4c_Pedra
2014:             .Top          = 197
2015:             .Left         = 119
2016:             .Width        = 500
2017:             .Height       = 261
2018:             .FontSize     = 8
2019:             .RowHeight    = 16
2020:             .ScrollBars   = 2

*-- Linhas 2026 a 2084:
2026:             .ReadOnly     = .F.
2027: 
2028:             .Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
2029:             .Column1.Header1.Caption = "Produto"
2030:             .Column1.Width     = 80
2031:             .Column1.Movable   = .F.
2032:             .Column1.Resizable = .F.
2033:             .Column1.ReadOnly  = .F.
2034:             .Column1.Text1.BorderStyle = 0
2035:             .Column1.Text1.Margin      = 0
2036:             .Column1.Text1.MaxLength   = 14
2037:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
2038:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
2039:             .Column1.Text1.ToolTipText = "F4 ou duplo clique: buscar produto"
2040: 
2041:             .Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
2042:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2043:             .Column2.Width     = 200
2044:             .Column2.Movable   = .F.
2045:             .Column2.Resizable = .F.
2046:             .Column2.ReadOnly  = .T.
2047:             .Column2.Text1.FontBold    = .T.
2048:             .Column2.Text1.BorderStyle = 0
2049:             .Column2.Text1.Margin      = 0
2050:             .Column2.Text1.ReadOnly    = .T.
2051:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
2052:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
2053: 
2054:             .Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
2055:             .Column3.Header1.Caption = "Uni"
2056:             .Column3.Width     = 30
2057:             .Column3.Movable   = .F.
2058:             .Column3.Resizable = .F.
2059:             .Column3.ReadOnly  = .T.
2060:             .Column3.Text1.FontBold    = .T.
2061:             .Column3.Text1.BorderStyle = 0
2062:             .Column3.Text1.Margin      = 0
2063:             .Column3.Text1.ReadOnly    = .T.
2064:             .Column3.Text1.ForeColor   = RGB(0, 0, 0)
2065:             .Column3.Text1.BackColor   = RGB(255, 255, 255)
2066: 
2067:             .Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
2068:             .Column4.Header1.Caption = "Qtde"
2069:             .Column4.Width     = 75
2070:             .Column4.Movable   = .F.
2071:             .Column4.Resizable = .F.
2072:             .Column4.ReadOnly  = .F.
2073:             .Column4.Text1.BorderStyle = 0
2074:             .Column4.Text1.Margin      = 0
2075:             .Column4.Text1.ForeColor   = RGB(0, 0, 0)
2076:             .Column4.Text1.BackColor   = RGB(255, 255, 255)
2077: 
2078:             .Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
2079:             .Column5.Header1.Caption = "Produto"
2080:             .Column5.Width     = 80
2081:             .Column5.Movable   = .F.
2082:             .Column5.Resizable = .F.
2083:             .Column5.ReadOnly  = .F.
2084:             .Column5.Text1.BorderStyle = 0

*-- Linhas 2109 a 2148:
2109: 
2110:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "KeyPress", THIS, "GrdPedraSubstitutoKeyPress")
2111:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "DblClick", THIS, "GrdPedraSubstitutoDblClick")
2112: 
2113:         *-- Voltar (CancelaDisp) --------------------------------------------
2114:         loc_oPag6.AddObject("cmd_4c_CancelaDisp", "CommandButton")
2115:         WITH loc_oPag6.cmd_4c_CancelaDisp
2116:             .Top         = 12
2117:             .Left        = 704
2118:             .Width       = 75
2119:             .Height      = 75
2120:             .FontName    = "Comic Sans MS"
2121:             .FontSize    = 8
2122:             .FontBold    = .T.
2123:             .FontItalic  = .T.
2124:             .WordWrap    = .T.
2125:             .Cancel      = .T.
2126:             .Caption     = "Voltar"
2127:             .ForeColor   = RGB(90, 90, 90)
2128:             .BackColor   = RGB(255, 255, 255)
2129:             .Themes      = .T.
2130:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2131:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2132:         ENDWITH
2133:         BINDEVENT(loc_oPag6.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage6Click")
2134:     ENDPROC
2135: 
2136:     *--------------------------------------------------------------------------
2137:     * GrdPedraProdutoKeyPress / GrdPedraProdutoDblClick - gatilhos do lookup
2138:     * do MATERIAL REQUISITADO (GradePedra.Column1.Text1.Valid no legado).
2139:     * PUBLIC (sem PROTECTED): BINDEVENT so enxerga metodo publico.
2140:     * LPARAMETERS obrigatorio - sem ele o primeiro keystroke estoura
2141:     * "No PARAMETER statement is found".
2142:     *--------------------------------------------------------------------------
2143:     PROCEDURE GrdPedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2144: 
2145:         *-- Guarda obrigatoria: sem ela o picker abriria a CADA tecla
2146:         *-- digitada e o usuario nao conseguiria terminar o codigo.
2147:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2148:             RETURN

*-- Linhas 2723 a 2731:
2723:     PROTECTED PROCEDURE AtualizarVisibilidadeDisponivel()
2724:         LOCAL loc_nTipoEsto
2725: 
2726:         THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.
2727: 
2728:         IF !THIS.this_lReservaAuto
2729:             RETURN
2730:         ENDIF
2731:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")

*-- Linhas 2741 a 2749:
2741:         loc_nTipoEsto = THIS.this_oBusinessObject.ObterTipoEstoqueProduto(ALLTRIM(TmpFinalg.Cpros))
2742: 
2743:         IF INLIST(loc_nTipoEsto, 3, 4)
2744:             THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
2745:         ENDIF
2746:     ENDPROC
2747: 
2748:     *--------------------------------------------------------------------------
2749:     * GradeItensPage1Column8LostFocus - desarma o gate de liberacao manual

*-- Linhas 2843 a 2851:
2843:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0)
2844:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0) - TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2845:             .txt_4c_Tot_Prz.Value = TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2846:             .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel " + ALLTRIM(TmpFinalg.Cpros) + ;
2847:                 IIF(!EMPTY(TmpFinalg.CodCors), " Cor:" + ALLTRIM(TmpFinalg.CodCors), "") + ;
2848:                 IIF(!EMPTY(TmpFinalg.CodTams), " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2849:             .grd_4c_DispGrupo.Refresh()
2850:             .Visible     = .T.
2851:         ENDWITH

*-- Linhas 3036 a 3044:
3036: 
3037:         loc_oPag2 = THIS.pgf_4c_1.Page2
3038:         loc_oPag2.obj_4c_ObsItens.Refresh()
3039:         loc_oPag2.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
3040: 
3041:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3042:             loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb6_" + SYS(3) + ".jpg"
3043:             loc_oPag2.img_4c_FigJpg.Picture = ""
3044:             loc_oPag2.img_4c_FigJpg.Visible = .F.

*-- Linhas 3158 a 3179:
3158:     *--------------------------------------------------------------------------
3159:     * TornarControlesVisiveis - torna visiveis todos os controles criados via
3160:     * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame e
3161:     * Controls de Container recursivamente. cmd_4c_Pedras/SelEstoque/
3162:     * Disponivel nascem Visible=.F. no SCX legado (so aparecem conforme o
3163:     * TipoEstos do produto corrente - logica da fase de eventos) e por isso
3164:     * sao filtrados aqui, senao esta rotina reabre os tres incondicionalmente.
3165:     *--------------------------------------------------------------------------
3166:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3167:         LOCAL loc_nI, loc_oObjeto, loc_nP
3168: 
3169:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3170:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3171: 
3172:             IF VARTYPE(loc_oObjeto) = "O"
3173:                 IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_PEDRAS", ;
3174:                         "CMD_4C_SELESTOQUE", "CMD_4C_DISPONIVEL", "IMG_4C_FIGJPG")
3175:                     LOOP
3176:                 ENDIF
3177: 
3178:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3179:                     loc_oObjeto.Visible = .T.

*-- Linhas 3290 a 3333:
3290:         *-- Movable/Resizable/Sparse de TODAS as colunas (medido no VFP9 -
3291:         *-- regra do Problema 48/Pattern #180) - reconfigurar na mesma
3292:         *-- ordem de ConfigurarPaginaTotaisLinha.
3293:         loc_oGrid.Column1.Header1.Caption = "Linha"
3294:         loc_oGrid.Column1.Width     = 84
3295:         loc_oGrid.Column1.Movable   = .F.
3296:         loc_oGrid.Column1.Resizable = .F.
3297:         loc_oGrid.Column1.Sparse    = .F.
3298:         loc_oGrid.Column1.ReadOnly  = .T.
3299:         loc_oGrid.Column1.ForeColor = RGB(36, 84, 155)
3300: 
3301:         loc_oGrid.Column2.Header1.Caption = "Quantidade"
3302:         loc_oGrid.Column2.Width     = 80
3303:         loc_oGrid.Column2.Movable   = .F.
3304:         loc_oGrid.Column2.Resizable = .F.
3305:         loc_oGrid.Column2.Sparse    = .F.
3306:         loc_oGrid.Column2.ReadOnly  = .T.
3307:         loc_oGrid.Column2.Text1.InputMask = "999,999.99"
3308:         loc_oGrid.Column2.Text1.MaxLength = 10
3309: 
3310:         loc_oGrid.Column3.Header1.Caption = "Estoque"
3311:         loc_oGrid.Column3.Width     = 80
3312:         loc_oGrid.Column3.Movable   = .F.
3313:         loc_oGrid.Column3.Resizable = .F.
3314:         loc_oGrid.Column3.Sparse    = .F.
3315:         loc_oGrid.Column3.ReadOnly  = .T.
3316:         loc_oGrid.Column3.Text1.InputMask = "999,999.99"
3317:         loc_oGrid.Column3.Text1.MaxLength = 10
3318: 
3319:         loc_oGrid.Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
3320:         loc_oGrid.Column4.Width     = 80
3321:         loc_oGrid.Column4.Movable   = .F.
3322:         loc_oGrid.Column4.Resizable = .F.
3323:         loc_oGrid.Column4.Sparse    = .F.
3324:         loc_oGrid.Column4.ReadOnly  = .T.
3325:         loc_oGrid.Column4.Text1.InputMask = "999,999.99"
3326:         loc_oGrid.Column4.Text1.MaxLength = 10
3327: 
3328:         loc_oGrid.Column5.Header1.Caption = "Produzir"
3329:         loc_oGrid.Column5.Width     = 80
3330:         loc_oGrid.Column5.Movable   = .F.
3331:         loc_oGrid.Column5.Resizable = .F.
3332:         loc_oGrid.Column5.Sparse    = .F.
3333:         loc_oGrid.Column5.ReadOnly  = .T.

*-- Linhas 3401 a 3421:
3401:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3402:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3403:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaEstoque.
3404:         loc_oGrid.Column1.Header1.Caption = "Grupo"
3405:         loc_oGrid.Column1.Width     = 80
3406:         loc_oGrid.Column1.ReadOnly  = .T.
3407:         loc_oGrid.Column2.Header1.Caption = "Conta"
3408:         loc_oGrid.Column2.Width     = 80
3409:         loc_oGrid.Column2.ReadOnly  = .T.
3410:         loc_oGrid.Column3.Header1.Caption = "Prior"
3411:         loc_oGrid.Column3.Width     = 24
3412:         loc_oGrid.Column3.ReadOnly  = .T.
3413:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3414:         loc_oGrid.Column4.Width     = 75
3415:         loc_oGrid.Column4.ReadOnly  = .T.
3416:         loc_oGrid.Column5.Header1.Caption = "Utilizar"
3417:         loc_oGrid.Column5.Width     = 75
3418:         loc_oGrid.Column5.ReadOnly  = .F.
3419:         loc_oGrid.Column5.Text1.FontBold = .T.
3420: 
3421:         WITH THIS.pgf_4c_1.Page4

*-- Linhas 3484 a 3506:
3484:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3485:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3486:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaTamanhos.
3487:         loc_oGrid.Column1.Header1.Caption = "Produto"
3488:         loc_oGrid.Column1.Width     = 80
3489:         loc_oGrid.Column1.ReadOnly  = .T.
3490:         loc_oGrid.Column2.Header1.Caption = "Cor"
3491:         loc_oGrid.Column2.Width     = 38
3492:         loc_oGrid.Column2.ReadOnly  = .T.
3493:         loc_oGrid.Column2.Text1.FontBold = .T.
3494:         loc_oGrid.Column3.Header1.Caption = "Tam"
3495:         loc_oGrid.Column3.Width     = 24
3496:         loc_oGrid.Column3.ReadOnly  = .T.
3497:         loc_oGrid.Column3.Text1.FontBold = .T.
3498:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3499:         loc_oGrid.Column4.Width     = 75
3500:         loc_oGrid.Column4.ReadOnly  = .T.
3501:         loc_oGrid.Column5.Header1.Caption = "Utilizar"
3502:         loc_oGrid.Column5.Width     = 75
3503:         loc_oGrid.Column5.ReadOnly  = .F.
3504:         loc_oGrid.Column5.Text1.FontBold = .T.
3505: 
3506:         WITH THIS.pgf_4c_1.Page5

*-- Linhas 3830 a 3838:
3830:     * unica vez em SigPrGlxBO.Init:
3831:     *
3832:     *   Thisform.SigKey = CrSigCdPac.sigKeys                 -> BO.this_cSigKey
3833:     *   lab_periodo.Caption = 'Periodo: '+Alltrim(Str(
3834:     *       CrSigCdPac.nMeses,2))+' meses'                   -> BO.this_nPacNMeses
3835:     *   Pedras.Visible = .f.                                 -> BO.this_cPamDop*
3836:     *   If Not Empty(crSigCdPam.DopEmphs) And Not Empty(DopReqcs)
3837:     *      And Not Empty(DopPedcs) And Not Empty(DopComps)
3838:     *      And Not ThisForm.Reserva -> Pedras.Visible = .t.

*-- Linhas 3851 a 3892:
3851:             loc_oPag1 = THIS.pgf_4c_1.Page1
3852: 
3853:             *-- Titulo da tela e os dois labels da faixa do cabecalho
3854:             THIS.Caption = IIF(THIS.this_lReservaAuto, ;
3855:                 "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
3856:                 "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
3857:             THIS.this_cTituloForm = THIS.Caption
3858:             loc_oPag1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
3859:             loc_oPag1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
3860: 
3861:             IF VARTYPE(loc_oBO) = "O"
3862:                 *-- "Periodo: NN meses" (SigCdPac.nmeses). O legado monta o
3863:                 *-- rotulo INTEIRO aqui; o Caption posto em
3864:                 *-- ConfigurarPaginaLista eh so o texto base de projeto.
3865:                 loc_oPag1.cnt_4c_Container5.lbl_4c_LabPeriodo.Caption = ;
3866:                     "Per" + CHR(237) + "odo: " + ALLTRIM(STR(loc_oBO.this_nPacNMeses, 2)) + " meses"
3867: 
3868:                 *-- "Requisicoes" (cmd_4c_Pedras): so com as QUATRO operacoes
3869:                 *-- de requisicao configuradas em SigCdPam e fora do modo
3870:                 *-- Reserva.
3871:                 loc_lTemPedras = !EMPTY(loc_oBO.this_cPamDopEmphs) AND ;
3872:                                  !EMPTY(loc_oBO.this_cPamDopReqcs) AND ;
3873:                                  !EMPTY(loc_oBO.this_cPamDopPedcs) AND ;
3874:                                  !EMPTY(loc_oBO.this_cPamDopComps) AND ;
3875:                                  !THIS.this_lReservaAuto
3876:                 loc_oPag1.cmd_4c_Pedras.Visible = loc_lTemPedras
3877:             ELSE
3878:                 loc_oPag1.cmd_4c_Pedras.Visible = .F.
3879:             ENDIF
3880: 
3881:             *-- "Estoques" (cmd_4c_SelEstoque): mesma condicao de acesso que
3882:             *-- libera a coluna Prior das grades de resumo.
3883:             loc_oPag1.cmd_4c_SelEstoque.Visible = THIS.this_lPermiteAjustarPrioridade()
3884: 
3885:             *-- "Disponiveis" (cmd_4c_Disponivel) nasce oculto e eh decidido
3886:             *-- por item em AtualizarVisibilidadeDisponivel().
3887:             loc_oPag1.cmd_4c_Disponivel.Visible = .F.
3888:         CATCH TO loc_oErro
3889:             MsgErro(loc_oErro.Message + CHR(13) + ;
3890:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3891:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
3892:         ENDTRY

*-- Linhas 3963 a 3980:
3963:                     .Column9.Width  = 40
3964:                     .Column10.Width = 76
3965: 
3966:                     .Column1.Header1.Caption  = "Produto"
3967:                     .Column2.Header1.Caption  = "Cor"
3968:                     .Column3.Header1.Caption  = ""
3969:                     .Column4.Header1.Caption  = "N" + CHR(250) + "mero"
3970:                     .Column5.Header1.Caption  = "Qtde Pedido"
3971:                     .Column6.Header1.Caption  = "Produzir"
3972:                     .Column7.Header1.Caption  = "Qtd Produ" + CHR(231) + CHR(227) + "o"
3973:                     .Column8.Header1.Caption  = "Produzir Estq"
3974:                     .Column9.Header1.Caption  = "Tam"
3975:                     .Column10.Header1.Caption = "Qtd Estoque"
3976: 
3977:                     *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid
3978:                     *-- propaga para as colunas e sobrescreveria): so Fabrs
3979:                     *-- (7) e Estoque (10) sao digitaveis no legado.
3980:                     .ReadOnly = .F.

*-- Linhas 4099 a 4123:
4099:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", "Aten" + CHR(231) + CHR(227) + "o")
4100:             ELSE
4101:                 IF THIS.FormParaBO()
4102:                     THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled    = .F.
4103:                     THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled   = .F.
4104:                     THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled   = .F.
4105:                     THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled     = .F.
4106: 
4107:                     loc_lSucesso = THIS.this_oBusinessObject.Processar()
4108: 
4109:                     IF loc_lSucesso
4110:                         MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
4111:                             "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
4112:                             " gerada.", "Confirmar")
4113:                         loc_lFechar = .T.
4114:                     ELSE
4115:                         THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled  = .T.
4116:                         THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled = THIS.this_lPermiteAjustarPrioridade()
4117:                         THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled = .T.
4118:                         THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled   = .T.
4119: 
4120:                         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
4121:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Processar")
4122:                         ENDIF
4123:                     ENDIF

