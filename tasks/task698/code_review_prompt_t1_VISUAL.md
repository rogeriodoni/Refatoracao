# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4064 linhas total):

*-- Linhas 249 a 268:
249:         TRY
250:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
251:             WITH THIS.pgf_4c_Paginas
252:                 .Top         = -29
253:                 .Left        = 0
254:                 .Width       = THIS.Width
255:                 .Height      = THIS.Height + 29
256:                 .PageCount   = 2
257:                 .Tabs        = .F.
258:                 .BorderWidth = 0
259: 
260:                 .Page1.Caption = "Filtro"
261:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
262: 
263:                 .Page2.Caption = "Hist" + CHR(243) + "rico"
264:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
265:                 .Page2.Enabled = .F.
266:             ENDWITH
267:         CATCH TO loc_oErro
268:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 284 a 305:
284: 
285:             loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
286:             WITH loc_oPag1.cnt_4c_Cabecalho
287:                 .Top         = 0 + 29
288:                 .Left        = 0
289:                 .Width       = THIS.Width
290:                 .Height      = 80
291:                 .BorderWidth = 0
292:                 .BackStyle   = 1
293:                 .BackColor   = RGB(100, 100, 100)
294:                 .Visible     = .T.
295:             ENDWITH
296: 
297:             loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
298:             WITH loc_oPag2.cnt_4c_Cabecalho
299:                 .Top         = 0 + 29
300:                 .Left        = 0
301:                 .Width       = THIS.Width
302:                 .Height      = 80
303:                 .BorderWidth = 0
304:                 .BackStyle   = 1
305:                 .BackColor   = RGB(100, 100, 100)

*-- Linhas 314 a 367:
314: 
315:     *--------------------------------------------------------------------------
316:     * ConfigurarPaginaFiltro - Preenche o cabecalho da Page1 (Filtro) com
317:     * o titulo do formulario (lbl_4c_Sombra atras, lbl_4c_Titulo na frente)
318:     *--------------------------------------------------------------------------
319:     PROTECTED PROCEDURE ConfigurarPaginaFiltro()
320:         LOCAL loc_oCab, loc_oPag1, loc_oErro
321:         TRY
322:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
323:             loc_oCab  = loc_oPag1.cnt_4c_Cabecalho
324: 
325:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
326:             WITH loc_oCab.lbl_4c_Sombra
327:                 .AutoSize  = .F.
328:                 .FontBold  = .T.
329:                 .FontName  = "Tahoma"
330:                 .FontSize  = 18
331:                 .BackStyle = 0
332:                 .Alignment = 0
333:                 .Caption   = THIS.Caption
334:                 .Height    = 40
335:                 .Left      = 10
336:                 .Top       = 18
337:                 .Width     = THIS.Width - 20
338:                 .ForeColor = RGB(0, 0, 0)
339:             ENDWITH
340: 
341:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
342:             WITH loc_oCab.lbl_4c_Titulo
343:                 .AutoSize  = .F.
344:                 .FontBold  = .T.
345:                 .FontName  = "Tahoma"
346:                 .FontSize  = 18
347:                 .BackStyle = 0
348:                 .Alignment = 0
349:                 .Caption   = THIS.Caption
350:                 .Height    = 46
351:                 .Left      = 10
352:                 .Top       = 17
353:                 .Width     = THIS.Width - 20
354:                 .ForeColor = RGB(255, 255, 255)
355:             ENDWITH
356: 
357:             *-- Shape1 (decorativo, sem preenchimento nem borda no SCX legado;
358:             *-- BorderColor transcrito do dump, inerte com BorderStyle = 0)
359:             loc_oPag1.AddObject("shp_4c_Shape1", "Shape")
360:             WITH loc_oPag1.shp_4c_Shape1
361:                 .Top         = 10 + 29
362:                 .Left        = 816
363:                 .Width       = 173
364:                 .Height      = 110
365:                 .BackStyle   = 0
366:                 .BorderStyle = 0
367:                 .BorderColor = RGB(136, 189, 188)

*-- Linhas 386 a 468:
386:         TRY
387:             par_oPagina.AddObject("cnt_4c_Origem", "Container")
388:             WITH par_oPagina.cnt_4c_Origem
389:                 .Top         = 277 + 29
390:                 .Left        = 230
391:                 .Width       = 539
392:                 .Height      = 50
393:                 .BackStyle   = 0
394:                 .BorderWidth = 1
395:                 .BorderColor = RGB(90, 90, 90)
396:                 .TabIndex    = 1
397:                 .Visible     = .T.
398:             ENDWITH
399:             loc_oOrig = par_oPagina.cnt_4c_Origem
400: 
401:             loc_oOrig.AddObject("lbl_4c_Label2", "Label")
402:             WITH loc_oOrig.lbl_4c_Label2
403:                 .AutoSize  = .F.
404:                 .BackStyle = 0
405:                 .Alignment = 0
406:                 .FontSize  = 8
407:                 .Caption   = "Conta"
408:                 .Left      = 5
409:                 .Top       = 4
410:                 .Width     = 60
411:                 .Height    = 14
412:                 .ForeColor = RGB(90, 90, 90)
413:                 .TabIndex  = 1
414:             ENDWITH
415: 
416:             loc_oOrig.AddObject("lbl_4c__CPF", "Label")
417:             WITH loc_oOrig.lbl_4c__CPF
418:                 .AutoSize  = .F.
419:                 .BackStyle = 0
420:                 .Alignment = 0
421:                 .FontSize  = 8
422:                 .Caption   = "CPF / CNPJ"
423:                 .Left      = 90
424:                 .Top       = 4
425:                 .Width     = 90
426:                 .Height    = 14
427:                 .ForeColor = RGB(90, 90, 90)
428:                 .TabIndex  = 3
429:             ENDWITH
430: 
431:             loc_oOrig.AddObject("lbl_4c__dConta", "Label")
432:             WITH loc_oOrig.lbl_4c__dConta
433:                 .AutoSize  = .F.
434:                 .BackStyle = 0
435:                 .Alignment = 0
436:                 .FontSize  = 8
437:                 .Caption   = "Nome"
438:                 .Left      = 243
439:                 .Top       = 4
440:                 .Width     = 60
441:                 .Height    = 14
442:                 .ForeColor = RGB(90, 90, 90)
443:                 .TabIndex  = 5
444:             ENDWITH
445: 
446:             loc_oOrig.AddObject("txt_4c__Conta", "TextBox")
447:             WITH loc_oOrig.txt_4c__Conta
448:                 .Left          = 5
449:                 .Top           = 18
450:                 .Width         = 82
451:                 .Height        = 21
452:                 .MaxLength     = 10
453:                 .SpecialEffect = 1
454:                 .ForeColor     = RGB(0, 0, 0)
455:                 .BorderColor   = RGB(100, 100, 100)
456:                 .Value         = ""
457:                 .TabIndex      = 2
458:             ENDWITH
459: 
460:             loc_oOrig.AddObject("txt_4c__Cpf", "TextBox")
461:             WITH loc_oOrig.txt_4c__Cpf
462:                 .Left          = 90
463:                 .Top           = 18
464:                 .Width         = 150
465:                 .Height        = 21
466:                 .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
467:                 .MaxLength     = 20
468:                 .SpecialEffect = 1

*-- Linhas 474 a 483:
474: 
475:             loc_oOrig.AddObject("txt_4c__DConta", "TextBox")
476:             WITH loc_oOrig.txt_4c__DConta
477:                 .Left          = 243
478:                 .Top           = 18
479:                 .Width         = 290
480:                 .Height        = 21
481:                 .MaxLength     = 50
482:                 .SpecialEffect = 1
483:                 .ForeColor     = RGB(0, 0, 0)

*-- Linhas 489 a 521:
489:             loc_oOrig.AddObject("obj_4c_OptFiltro", "OptionGroup")
490:             WITH loc_oOrig.obj_4c_OptFiltro
491:                 .ButtonCount = 2
492:                 .Top         = -2
493:                 .Left        = 282
494:                 .Width       = 93
495:                 .Height      = 19
496:                 .BackStyle   = 0
497:                 .Value       = 1
498:                 .TabIndex    = 7
499:                 WITH .Buttons(1)
500:                     .Caption   = "\<Lista"
501:                     .FontName        = "Comic Sans MS"
502:                     .FontSize  = 8
503:                     .Height    = 15
504:                     .Left      = 5
505:                     .Top       = 5
506:                     .Width     = 45
507:                     .Style     = 0
508:                     .BackStyle = 0
509:                 ENDWITH
510:                 WITH .Buttons(2)
511:                     .Caption   = "\<Filtro"
512:                     .FontName        = "Comic Sans MS"
513:                     .FontSize  = 8
514:                     .Height    = 15
515:                     .Left      = 48
516:                     .Top       = 5
517:                     .Width     = 45
518:                     .Style     = 0
519:                     .BackStyle = 0
520:                 ENDWITH
521:             ENDWITH

*-- Linhas 547 a 561:
547:     PROTECTED PROCEDURE ConfigurarBotoesFiltro(par_oPagina)
548:         LOCAL loc_oErro
549:         TRY
550:             par_oPagina.AddObject("cmd_4c_Ok", "CommandButton")
551:             WITH par_oPagina.cmd_4c_Ok
552:                 .Top             = 4 + 29
553:                 .Left            = 849
554:                 .Width           = 75
555:                 .Height          = 75
556:                 .Caption         = "Processar"
557:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
558:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
559:                 .FontName        = "Tahoma"
560:                 .FontBold        = .T.
561:                 .FontItalic      = .T.

*-- Linhas 569 a 583:
569:                 .WordWrap        = .T.
570:             ENDWITH
571: 
572:             par_oPagina.AddObject("cmd_4c_Cancelar", "CommandButton")
573:             WITH par_oPagina.cmd_4c_Cancelar
574:                 .Top             = 4 + 29
575:                 .Left            = 924
576:                 .Width           = 75
577:                 .Height          = 75
578:                 .Caption         = "Encerrar"
579:                 .Cancel          = .T.
580:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
581:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
582:                 .FontName        = "Tahoma"
583:                 .FontBold        = .T.

*-- Linhas 592 a 601:
592:                 .WordWrap        = .T.
593:             ENDWITH
594: 
595:             BINDEVENT(par_oPagina.cmd_4c_Ok,        "Click", THIS, "CmdOkClick")
596:             BINDEVENT(par_oPagina.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
597:         CATCH TO loc_oErro
598:             MsgErro(loc_oErro.Message + CHR(13) + ;
599:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
600:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarBotoesFiltro")
601:         ENDTRY

*-- Linhas 611 a 646:
611:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
612:             loc_oCab  = loc_oPag2.cnt_4c_Cabecalho
613: 
614:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
615:             WITH loc_oCab.lbl_4c_Sombra
616:                 .AutoSize  = .F.
617:                 .FontBold  = .T.
618:                 .FontName  = "Tahoma"
619:                 .FontSize  = 18
620:                 .BackStyle = 0
621:                 .Alignment = 0
622:                 .Caption   = THIS.Caption
623:                 .Height    = 40
624:                 .Left      = 10
625:                 .Top       = 18
626:                 .Width     = THIS.Width - 20
627:                 .ForeColor = RGB(0, 0, 0)
628:             ENDWITH
629: 
630:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
631:             WITH loc_oCab.lbl_4c_Titulo
632:                 .AutoSize  = .F.
633:                 .FontBold  = .T.
634:                 .FontName  = "Tahoma"
635:                 .FontSize  = 18
636:                 .BackStyle = 0
637:                 .Alignment = 0
638:                 .Caption   = THIS.Caption
639:                 .Height    = 46
640:                 .Left      = 10
641:                 .Top       = 17
642:                 .Width     = THIS.Width - 20
643:                 .ForeColor = RGB(255, 255, 255)
644:             ENDWITH
645: 
646:             THIS.ConfigurarPeriodoHistorico(loc_oPag2)

*-- Linhas 664 a 673:
664:         TRY
665:             par_oPagina.AddObject("cnt_4c__periodo", "Container")
666:             WITH par_oPagina.cnt_4c__periodo
667:                 .Top           = 8 + 29
668:                 .Left          = 647
669:                 .Width         = 230
670:                 .Height        = 67
671:                 .BackStyle     = 1
672:                 .BackColor     = RGB(255, 255, 255)
673:                 .BorderWidth   = 1

*-- Linhas 680 a 740:
680:             *-- Label1: o dump declara AutoSize = .T., mas AutoSize eh no-op em
681:             *-- Label criado por AddObject (regra #23) - fica .F. com a
682:             *-- Width/Height que o Form Designer calculou (123x15)
683:             loc_oPer.AddObject("lbl_4c_Label1", "Label")
684:             WITH loc_oPer.lbl_4c_Label1
685:                 .AutoSize  = .F.
686:                 .FontBold  = .T.
687:                 .FontName  = "Tahoma"
688:                 .FontSize  = 8
689:                 .BackStyle = 0
690:                 .Alignment = 0
691:                 .Caption   = "Filtro Por Vencimento"
692:                 .Left      = 20
693:                 .Top       = 7
694:                 .Width     = 123
695:                 .Height    = 15
696:                 .ForeColor = RGB(90, 90, 90)
697:                 .TabIndex  = 1
698:             ENDWITH
699: 
700:             loc_oPer.AddObject("lbl_4c_Label2", "Label")
701:             WITH loc_oPer.lbl_4c_Label2
702:                 .AutoSize  = .F.
703:                 .FontName  = "Tahoma"
704:                 .FontSize  = 8
705:                 .BackStyle = 0
706:                 .Alignment = 0
707:                 .Caption   = "at" + CHR(233)
708:                 .Left      = 105
709:                 .Top       = 33
710:                 .Width     = 20
711:                 .Height    = 14
712:                 .ForeColor = RGB(90, 90, 90)
713:                 .TabIndex  = 12
714:             ENDWITH
715: 
716:             loc_oPer.AddObject("txt_4c_Dt_inicial", "TextBox")
717:             WITH loc_oPer.txt_4c_Dt_inicial
718:                 .Alignment     = 3
719:                 .Value         = ConverterParaData(THIS.this_oBusinessObject.this_dDataInicial)
720:                 .Left          = 20
721:                 .Top           = 29
722:                 .Width         = 80
723:                 .Height        = 21
724:                 .SpecialEffect = 1
725:                 .ForeColor     = RGB(0, 0, 0)
726:                 .BorderColor   = RGB(100, 100, 100)
727:                 .TabIndex      = 6
728:             ENDWITH
729: 
730:             loc_oPer.AddObject("txt_4c_Dt_final", "TextBox")
731:             WITH loc_oPer.txt_4c_Dt_final
732:                 .Alignment     = 3
733:                 .Value         = ConverterParaData(THIS.this_oBusinessObject.this_dDataFinal)
734:                 .Left          = 129
735:                 .Top           = 29
736:                 .Width         = 80
737:                 .Height        = 21
738:                 .SpecialEffect = 1
739:                 .ForeColor     = RGB(0, 0, 0)
740:                 .BorderColor   = RGB(100, 100, 100)

*-- Linhas 816 a 825:
816:         TRY
817:             par_oPagina.AddObject("cnt_4c__Followup", "Container")
818:             WITH par_oPagina.cnt_4c__Followup
819:                 .Top           = 514 + 29
820:                 .Left          = 10
821:                 .Width         = 558
822:                 .Height        = 27
823:                 .BackStyle     = 1
824:                 .BackColor     = RGB(255, 255, 255)
825:                 .BorderWidth   = 1

*-- Linhas 831 a 860:
831: 
832:             *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
833:             *-- #23) - fica .F. com a Width/Height do SCX (44x15)
834:             loc_oFup.AddObject("lbl_4c_Label1", "Label")
835:             WITH loc_oFup.lbl_4c_Label1
836:                 .AutoSize  = .F.
837:                 .FontName  = "Tahoma"
838:                 .FontSize  = 8
839:                 .BackStyle = 0
840:                 .Alignment = 0
841:                 .Caption   = "Followup"
842:                 .Left      = 8
843:                 .Top       = 6
844:                 .Width     = 44
845:                 .Height    = 15
846:                 .ForeColor = RGB(90, 90, 90)
847:             ENDWITH
848: 
849:             loc_oFup.AddObject("txt_4c_UltFollowup", "TextBox")
850:             WITH loc_oFup.txt_4c_UltFollowup
851:                 .FontName      = "Tahoma"
852:                 .FontSize      = 8
853:                 .Height        = 20
854:                 .Left          = 62
855:                 .Top           = 3
856:                 .Width         = 492
857:                 .Margin        = 1
858:                 .SpecialEffect = 1
859:                 .BorderColor   = RGB(100, 100, 100)
860:                 .ReadOnly      = .T.

*-- Linhas 880 a 982:
880:         TRY
881:             par_oPagina.AddObject("cnt_4c_Emitente", "Container")
882:             WITH par_oPagina.cnt_4c_Emitente
883:                 .Top         = 543 + 29
884:                 .Left        = 10
885:                 .Width       = 558
886:                 .Height      = 53
887:                 .BackStyle   = 0
888:                 .BorderWidth = 1
889:                 .BorderColor = RGB(90, 90, 90)
890:                 .TabIndex    = 1
891:                 .Visible     = .T.
892:             ENDWITH
893:             loc_oEmi = par_oPagina.cnt_4c_Emitente
894: 
895:             *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
896:             *-- #23) - fica .F. com a Width/Height do SCX (137x15)
897:             loc_oEmi.AddObject("lbl_4c_Label1", "Label")
898:             WITH loc_oEmi.lbl_4c_Label1
899:                 .AutoSize  = .F.
900:                 .FontName  = "Tahoma"
901:                 .FontSize  = 8
902:                 .BackStyle = 0
903:                 .Alignment = 0
904:                 .Caption   = "Filtro por Conta do Emitente"
905:                 .Left      = 5
906:                 .Top       = 0
907:                 .Width     = 137
908:                 .Height    = 15
909:                 .ForeColor = RGB(90, 90, 90)
910:             ENDWITH
911: 
912:             loc_oEmi.AddObject("lbl_4c_Label2", "Label")
913:             WITH loc_oEmi.lbl_4c_Label2
914:                 .AutoSize  = .F.
915:                 .FontName  = "Tahoma"
916:                 .FontSize  = 8
917:                 .BackStyle = 0
918:                 .Alignment = 0
919:                 .Caption   = "Conta"
920:                 .Left      = 5
921:                 .Top       = 14
922:                 .Width     = 60
923:                 .Height    = 14
924:                 .ForeColor = RGB(90, 90, 90)
925:                 .TabIndex  = 1
926:             ENDWITH
927: 
928:             loc_oEmi.AddObject("lbl_4c__CPF", "Label")
929:             WITH loc_oEmi.lbl_4c__CPF
930:                 .AutoSize  = .F.
931:                 .FontName  = "Tahoma"
932:                 .FontSize  = 8
933:                 .BackStyle = 0
934:                 .Alignment = 0
935:                 .Caption   = "CPF / CNPJ"
936:                 .Left      = 90
937:                 .Top       = 14
938:                 .Width     = 90
939:                 .Height    = 14
940:                 .ForeColor = RGB(90, 90, 90)
941:                 .TabIndex  = 3
942:             ENDWITH
943: 
944:             loc_oEmi.AddObject("lbl_4c__dConta", "Label")
945:             WITH loc_oEmi.lbl_4c__dConta
946:                 .AutoSize  = .F.
947:                 .FontName  = "Tahoma"
948:                 .FontSize  = 8
949:                 .BackStyle = 0
950:                 .Alignment = 0
951:                 .Caption   = "Nome"
952:                 .Left      = 243
953:                 .Top       = 14
954:                 .Width     = 60
955:                 .Height    = 14
956:                 .ForeColor = RGB(90, 90, 90)
957:                 .TabIndex  = 5
958:             ENDWITH
959: 
960:             loc_oEmi.AddObject("txt_4c__Conta", "TextBox")
961:             WITH loc_oEmi.txt_4c__Conta
962:                 .Left          = 5
963:                 .Top           = 28
964:                 .Width         = 82
965:                 .Height        = 21
966:                 .MaxLength     = 10
967:                 .SpecialEffect = 1
968:                 .ForeColor     = RGB(0, 0, 0)
969:                 .BorderColor   = RGB(100, 100, 100)
970:                 .Value         = ""
971:                 .TabIndex      = 2
972:             ENDWITH
973: 
974:             loc_oEmi.AddObject("txt_4c__Cpf", "TextBox")
975:             WITH loc_oEmi.txt_4c__Cpf
976:                 .Left          = 90
977:                 .Top           = 28
978:                 .Width         = 150
979:                 .Height        = 21
980:                 .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
981:                 .MaxLength     = 20
982:                 .SpecialEffect = 1

*-- Linhas 988 a 997:
988: 
989:             loc_oEmi.AddObject("txt_4c__DConta", "TextBox")
990:             WITH loc_oEmi.txt_4c__DConta
991:                 .Left          = 243
992:                 .Top           = 28
993:                 .Width         = 311
994:                 .Height        = 23
995:                 .MaxLength     = 50
996:                 .SpecialEffect = 1
997:                 .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1890 a 1898:
1890: 
1891:         THIS.this_lFiltrado = !EMPTY(loc_cConta)
1892: 
1893:         THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + loc_cConta + " - " + ;
1894:             loc_cDConta + " / " + loc_cCpf
1895: 
1896:         TRY
1897:             *-- Legado: .Historico.Cnt_periodo.Visible = .f. - o historico por
1898:             *-- conta (ramo 1 de CarregarDados) ignora o periodo de vencimento,

*-- Linhas 1926 a 1948:
1926:     *   grd_4c_Prorrog   <- GradeProrrog    ( 1 coluna,  SigChea)
1927:     *
1928:     * Geometria/fontes/larguras transcritas do dump do SCX legado. Top recebe
1929:     * a compensacao +29 do pgf_4c_Paginas.Top = -29.
1930:     * RecordSource/ControlSource NAO sao definidos aqui: os cursores so existem
1931:     * depois de CarregarDados, e ControlSource de cursor inexistente derruba o
1932:     * Init. O vinculo mora em VincularGrade*, chamado por CarregarDados.
1933:     *--------------------------------------------------------------------------
1934:     PROTECTED PROCEDURE ConfigurarGradesHistorico()
1935:         LOCAL loc_oPagina, loc_oErro
1936:         TRY
1937:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1938: 
1939:             *-- GradeCheque: Top=124 Left=8 Width=981 Height=228 (dump legado)
1940:             loc_oPagina.AddObject("grd_4c_Cheque", "Grid")
1941:             WITH loc_oPagina.grd_4c_Cheque
1942:                 .Top                = 124 + 29
1943:                 .Left               = 8
1944:                 .Width              = 981
1945:                 .Height             = 228
1946:                 .HeaderHeight       = 0
1947:                 .ColumnCount        = 12
1948:                 .FontName           = "Tahoma"

*-- Linhas 1986 a 1995:
1986:             *-- GradeMovimenta: Top=359 Left=8 Width=858 Height=147 (dump legado)
1987:             loc_oPagina.AddObject("grd_4c_Movimenta", "Grid")
1988:             WITH loc_oPagina.grd_4c_Movimenta
1989:                 .Top                = 359 + 29
1990:                 .Left               = 8
1991:                 .Width              = 858
1992:                 .Height             = 147
1993:                 .HeaderHeight       = 0
1994:                 .ColumnCount        = 9
1995:                 .FontName           = "Tahoma"

*-- Linhas 2019 a 2028:
2019:             *-- GradeProrrog: Top=359 Left=875 Width=114 Height=146 (dump legado)
2020:             loc_oPagina.AddObject("grd_4c_Prorrog", "Grid")
2021:             WITH loc_oPagina.grd_4c_Prorrog
2022:                 .Top                = 359 + 29
2023:                 .Left               = 875
2024:                 .Width              = 114
2025:                 .Height             = 146
2026:                 .ColumnCount        = 1
2027:                 .FontName           = "Tahoma"
2028:                 .FontSize           = 8

*-- Linhas 2111 a 2244:
2111:             WITH loc_oPagina.cmg_4c_Botoes
2112:                 .AutoSize      = .F.
2113:                 .ButtonCount   = 8
2114:                 .Top           = 29
2115:                 .Left          = 30
2116:                 .Width         = 610
2117:                 .Height        = 85
2118:                 .BackStyle     = 0
2119:                 .BorderStyle   = 0
2120:                 .SpecialEffect = 1
2121:                 .BorderColor   = RGB(90, 90, 90)
2122:                 .Themes        = .F.
2123:                 .Value         = 0
2124:                 .Visible       = .T.
2125: 
2126:                 *-- Command1 = Relatorio
2127:                 WITH .Buttons(1)
2128:                     .Top             = 5
2129:                     .Left            = 230
2130:                     .Width           = 75
2131:                     .Height          = 75
2132:                     .Caption         = "Relat" + CHR(243) + "rio"
2133:                     .FontName        = "Comic Sans MS"
2134:                     .FontSize        = 8
2135:                     .ToolTipText     = "[F6] Relat" + CHR(243) + "rio"
2136:                     .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2137:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2138:                     .PicturePosition = 13
2139:                 ENDWITH
2140: 
2141:                 *-- Command2 = Procurar ("Busca")
2142:                 WITH .Buttons(2)
2143:                     .Top             = 5
2144:                     .Left            = 155
2145:                     .Width           = 75
2146:                     .Height          = 75
2147:                     .Caption         = "Busca"
2148:                     .FontName        = "Comic Sans MS"
2149:                     .FontSize        = 8
2150:                     .ToolTipText     = "[F5] Busca Cheques"
2151:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
2152:                     .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
2153:                     .PicturePosition = 13
2154:                 ENDWITH
2155: 
2156:                 *-- Command3 = Prorroga
2157:                 WITH .Buttons(3)
2158:                     .Top             = 5
2159:                     .Left            = 305
2160:                     .Width           = 75
2161:                     .Height          = 75
2162:                     .Caption         = "Prorroga" + CHR(231) + CHR(227) + "o"
2163:                     .FontName        = "Comic Sans MS"
2164:                     .FontSize        = 8
2165:                     .ToolTipText     = "[F7] Prorroga" + CHR(231) + CHR(227) + "o"
2166:                     .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2167:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2168:                     .PicturePosition = 13
2169:                     .WordWrap        = .T.
2170:                 ENDWITH
2171: 
2172:                 *-- Command4 = FollowUp (clientes)
2173:                 WITH .Buttons(4)
2174:                     .Top             = 5
2175:                     .Left            = 380
2176:                     .Width           = 75
2177:                     .Height          = 75
2178:                     .Caption         = "Followup Clientes"
2179:                     .FontName        = "Comic Sans MS"
2180:                     .FontSize        = 8
2181:                     .ToolTipText     = "[F8] Followup Cliente"
2182:                     .WordWrap        = .T.
2183:                     .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2184:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2185:                     .PicturePosition = 7
2186:                 ENDWITH
2187: 
2188:                 *-- Command5 = Carteira
2189:                 WITH .Buttons(5)
2190:                     .Top             = 5
2191:                     .Left            = 530
2192:                     .Width           = 75
2193:                     .Height          = 75
2194:                     .Caption         = "Carteira"
2195:                     .FontName        = "Comic Sans MS"
2196:                     .FontSize        = 8
2197:                     .ToolTipText     = "[F11]Carteira"
2198:                     .Picture         = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
2199:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
2200:                     .PicturePosition = 13
2201:                 ENDWITH
2202: 
2203:                 *-- Command6 = Protocolo
2204:                 WITH .Buttons(6)
2205:                     .Top             = 5
2206:                     .Left            = 455
2207:                     .Width           = 75
2208:                     .Height          = 75
2209:                     .Caption         = "Protocolo"
2210:                     .FontName        = "Comic Sans MS"
2211:                     .FontSize        = 8
2212:                     .ToolTipText     = "[F9]Protocolo"
2213:                     .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2214:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2215:                     .PicturePosition = 13
2216:                 ENDWITH
2217: 
2218:                 *-- Command7 = Documento ("Movimento")
2219:                 WITH .Buttons(7)
2220:                     .Top             = 5
2221:                     .Left            = 80
2222:                     .Width           = 75
2223:                     .Height          = 75
2224:                     .Caption         = "Movimento"
2225:                     .FontName        = "Comic Sans MS"
2226:                     .FontSize        = 8
2227:                     .ToolTipText     = "[F4] Movimenta" + CHR(231) + CHR(227) + "o"
2228:                     .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
2229:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
2230:                     .PicturePosition = 13
2231:                 ENDWITH
2232: 
2233:                 *-- Command8 = followUpChq (followup do cheque)
2234:                 WITH .Buttons(8)
2235:                     .Top             = 5
2236:                     .Left            = 5
2237:                     .Width           = 75
2238:                     .Height          = 75
2239:                     .Caption         = "Followup Cheques"
2240:                     .FontName        = "Comic Sans MS"
2241:                     .FontSize        = 8
2242:                     .ToolTipText     = "[F3] FollowUp Cheques"
2243:                     .WordWrap        = .T.
2244:                     .Picture         = gc_4c_CaminhoIcones + "cheque.png"

*-- Linhas 2265 a 2290:
2265:             WITH loc_oPagina.cmg_4c_Saida
2266:                 .AutoSize      = .F.
2267:                 .ButtonCount   = 1
2268:                 .Top           = 29
2269:                 .Left          = 917
2270:                 .Width         = 90
2271:                 .Height        = 85
2272:                 .BackStyle     = 0
2273:                 .BorderStyle   = 0
2274:                 .SpecialEffect = 1
2275:                 .BorderColor   = RGB(136, 189, 188)
2276:                 .Themes        = .F.
2277:                 .Value         = 1
2278:                 .Visible       = .T.
2279: 
2280:                 WITH .Buttons(1)
2281:                     .Top             = 5
2282:                     .Left            = 5
2283:                     .Width           = 75
2284:                     .Height          = 75
2285:                     .Caption         = "Encerrar"
2286:                     .FontName        = "Comic Sans MS"
2287:                     .FontSize        = 8
2288:                     .Cancel          = .T.
2289:                     .ToolTipText     = "<ESC> Sair"
2290:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 2765 a 2784:
2765:             .Column11.Width = 150
2766:             .Column12.Width = 80
2767: 
2768:             .Column1.Header1.Caption  = "Vencimento"
2769:             .Column2.Header1.Caption  = "Bco"
2770:             .Column3.Header1.Caption  = "Ag" + CHR(234) + "ncia"
2771:             .Column4.Header1.Caption  = "Conta"
2772:             .Column5.Header1.Caption  = "N" + CHR(250) + "mero"
2773:             .Column6.Header1.Caption  = "Valor"
2774:             .Column7.Header1.Caption  = "Grupo Carteira"
2775:             .Column8.Header1.Caption  = "Conta Carteira"
2776:             .Column9.Header1.Caption  = "Emp"
2777:             .Column10.Header1.Caption = "Arquivo"
2778:             .Column11.Header1.Caption = CHR(218) + "ltimo Movimento"
2779:             .Column12.Header1.Caption = "Emiss" + CHR(227) + "o"
2780: 
2781:             *-- Colunas 7..10 somente leitura (dump legado). Column.ReadOnly vem
2782:             *-- DEPOIS de Grid.ReadOnly, que propaga para as colunas
2783:             .Column7.ReadOnly  = .T.
2784:             .Column8.ReadOnly  = .T.

*-- Linhas 2844 a 2860:
2844:             .Column8.Width = 90
2845:             .Column9.Width = 90
2846: 
2847:             .Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2848:             .Column2.Header1.Caption = "Alinea"
2849:             .Column3.Header1.Caption = "Entrada"
2850:             .Column4.Header1.Caption = "Grupo/Origem"
2851:             .Column5.Header1.Caption = "Conta/Origem"
2852:             .Column6.Header1.Caption = "Grupo/Destino"
2853:             .Column7.Header1.Caption = "Conta/Destino"
2854:             .Column8.Header1.Caption = "Lote"
2855:             .Column9.Header1.Caption = "Protocolo"
2856: 
2857:             *-- Dump legado: Column8 e Column9 declaram apenas Movable = .F.;
2858:             *-- so as sete primeiras travam tambem o Resizable
2859:             .Column8.Resizable = .T.
2860:             .Column9.Resizable = .T.

*-- Linhas 2874 a 2882:
2874:             .RecordSource            = "cursor_4c_Prorrog"
2875:             .Column1.ControlSource   = "TTOD(cursor_4c_Prorrog.Vencs)"
2876:             .Column1.Width           = 83
2877:             .Column1.Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
2878:         ENDWITH
2879:     ENDPROC
2880: 
2881:     *--------------------------------------------------------------------------
2882:     * IndexarCursorCheque - Os dez TAGs + SET ORDER usados por CarregarDados

*-- Linhas 2976 a 2984:
2976:                 THIS.this_oBusinessObject.this_cCaptionAtual = ;
2977:                     "Hist" + CHR(243) + "rico de Cheques de: " + ;
2978:                     ALLTRIM(THIS.this_oBusinessObject.this_cIClis) + " - " + loc_cRclis + " / " + loc_cCpfs
2979:                 THIS.Caption = THIS.this_oBusinessObject.this_cCaptionAtual
2980:             ENDIF
2981: 
2982:             *-- Documento.Enabled (legado: Do Case com ChkRegister('SigCdPgr',
2983:             *-- laCampo1) / ChkRegister('SigMvCab', laCampo3 - EmpDopNums
2984:             *-- recalculado) / ChkRegister('SigMvCab', laCampo4 - EmpDopNums

*-- Linhas 3690 a 3698:
3690:                 THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = ;
3691:                     loc_oBO.this_cUltimoFollowup
3692:                 IF !EMPTY(loc_oBO.this_cCaptionAtual)
3693:                     THIS.Caption = loc_oBO.this_cCaptionAtual
3694:                 ENDIF
3695: 
3696:                 loc_oOrig.txt_4c__Conta.Refresh
3697:                 loc_oOrig.txt_4c__DConta.Refresh
3698:                 loc_oOrig.txt_4c__Cpf.Refresh

*-- Linhas 3846 a 3854:
3846:     *   .Filtro.Origem.Get_conta.Value  = ''
3847:     *   .Filtro.Origem.Get_Dconta.Value = ''
3848:     *   .Filtro.Origem.Get_Cpf.Value    = ''
3849:     *   ThisForm.Caption = 'Historico de Cheques'
3850:     * mais o periodo default do Init legado (Date() ate 31/12 do ano corrente;
3851:     * no acesso CARTEIRA, o vencimento do cheque recebido).
3852:     *
3853:     * PROTECTED porque FormBase declara este hook PROTECTED.
3854:     *--------------------------------------------------------------------------

*-- Linhas 3922 a 3931:
3922:                     THIS.AjustarBotoesHistorico()
3923:                 ELSE
3924:                     THIS.this_cModoAtual = "LISTA"
3925:                     loc_oPg1.cmd_4c_Ok.Enabled       = .T.
3926:                     loc_oPg1.cmd_4c_Cancelar.Enabled = .T.
3927:                 ENDIF
3928: 
3929:                 *-- Reaplica a cascata do When - os campos seguem editaveis nos
3930:                 *-- dois modos (o Historico tem o filtro de Emitente e o
3931:                 *-- periodo), o que troca eh a pagina ativa


### BO (C:\4c\projeto\app\classes\SigOpChiBO.prg):
*============================================================================
* SigOpChiBO.prg - Business Object para Historico de Cheques
*
* Tabela principal : SigChe    (PK: Nums char(8) - numero sequencial do cheque)
* Tabela detalhe    : SigCqChm (FK: Nums - movimentos/followup do cheque)
* Lookup conta      : SigCdCli (PK: Iclis, desc: Rclis, doc: Cpfs)
*
* Form OPERACIONAL (consulta/historico) - sem Inserir/Atualizar/Excluir.
* Filtra cheques por conta (Origem) ou por conta do Emitente, dentro de um
* periodo de vencimento, e exibe tres grades: Cheque, Movimentacao e
* Prorrogacoes, alem do ultimo Followup registrado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpChiBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigChe (todas as colunas - cheque selecionado
    * na GradeCheque da pagina Historico). Nums eh char(8) NO BANCO - NUNCA
    * numerico (conferido em docs/schema.sql: CONSTRAINT sigche_nums PK em
    * [nums] char(8)).
    *==========================================================================
    this_cNums      = ""    && char(8)  - PK do cheque selecionado na grade
    this_cEmps      = ""    && char(3)  - Empresa do cheque selecionado
    this_cBancos    = ""    && char(3)
    this_cAgencias  = ""    && char(4)
    this_lAutos     = .F.   && bit
    this_cConCarts  = ""    && char(10) - Conta Carteira
    this_cConOrigs  = ""    && char(10) - Conta Origem
    this_cConRes    = ""    && char(10)
    this_cContas    = ""    && char(10)
    this_cCopchs    = ""    && char(15)
    this_dDatas     = {}    && datetime
    this_dDataTrans = {}    && datetime
    this_cFpags     = ""    && char(12)
    this_cGrClis    = ""    && char(10) - Grupo do cliente
    this_cGruCarts  = ""    && char(10) - Grupo Carteira
    this_cGruOrigs  = ""    && char(10) - Grupo Origem
    this_cGrupos    = ""    && char(10)
    this_cGrures    = ""    && char(10)
    this_cGrvends   = ""    && char(10)
    this_cIClis     = ""    && char(10) - Codigo do cliente/conta
    this_cLeituras  = ""    && char(34)
    this_cLocals    = ""    && char(10)
    this_nNalineas  = 0     && numeric(3,0)
    this_cNCheques  = ""    && char(6)
    this_cNContas   = ""    && char(10)
    this_cNotas     = ""    && char(6)
    this_nNtrans    = 0     && numeric(6,0)
    this_cNumeros   = ""    && char(6)
    this_cNumolds   = ""    && char(8)
    this_nNumos     = 0     && numeric(8,0)
    this_cProtocolos = ""   && char(8)
    this_cUMovs     = ""    && char(15) - Ultimo Movimento
    this_nValors    = 0     && numeric(11,2)
    this_nValpags   = 0     && numeric(11,2)
    this_dVencs     = {}    && datetime
    this_cVends     = ""    && char(10)
    this_dDtEmis    = {}    && datetime
    this_dDtAlts    = {}    && datetime
    this_cContat    = ""    && char(10)
    this_cGrupot    = ""    && char(10)
    this_nCotas     = 0     && numeric(11,4)
    this_cMoeds     = ""    && char(3)
    this_nTipoBlq   = 0     && numeric(1,0)
    this_cCustodia  = ""    && char(4)

    *==========================================================================
    * Filtro por Conta de Origem (Pagina.Filtro.Origem)
    *==========================================================================
    this_cContaOrigem     = ""    && Iclis digitado/selecionado
    this_cDContaOrigem    = ""    && Rclis (descricao/nome da conta)
    this_cCpfOrigem       = ""    && Cpfs (CPF/CNPJ da conta)
    this_nTipoFiltroOrigem = 1    && optFiltro.Value: 1=Conta exata, 2=Com Filtro (LIKE)

    *==========================================================================
    * Filtro por Conta do Emitente (Pagina.Historico.Emitente)
    *==========================================================================
    this_cContaEmitente   = ""    && Iclis do emitente
    this_cDContaEmitente  = ""    && Rclis do emitente
    this_cCpfEmitente     = ""    && Cpfs do emitente

    *==========================================================================
    * Filtro por Periodo de Vencimento (Cnt_periodo)
    *==========================================================================
    this_dDataInicial = {}    && Dt_inicial.Value
    this_dDataFinal   = {}    && Dt_final.Value

    *==========================================================================
    * Estado de acesso e navegacao
    *==========================================================================
    this_cAcesso      = "TOTAL"    && Parametro pcAcesso recebido na abertura
    this_lAcesso      = .T.        && INLIST(this_cAcesso,'TOTAL','CARTEIRA')
    this_lFiltrado    = .F.        && .T. quando a Lista foi filtrada por uma conta
    this_cCaptionAtual = ""        && Caption dinamico ("Historico de Cheques de: ...")
    this_cUltimoFollowup = ""      && Texto do ultimo followup do cheque selecionado

    *==========================================================================
    * Alias dos cursores usados pelas grades e pelos lookups
    *==========================================================================
    this_cCursorCheque      = "cursor_4c_Cheque"       && GradeCheque      (SigChe)
    this_cCursorMovimento   = "cursor_4c_Movimento"    && GradeMovimenta   (SigCqChm)
    this_cCursorProrrog     = "cursor_4c_Prorrog"      && GradeProrrog     (prorrogacoes)
    this_cCursorChequeMov   = "cursor_4c_ChequeMov"    && Detalhe do cheque selecionado
    this_cCursorCliente     = "cursor_4c_Cliente"      && Lookup SigCdCli (conta/emitente)
    this_cCursorProtocolo   = "cursor_4c_Protocolo"    && TempChq (impressao de protocolo)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "Nums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do cheque selecionado
    * na GradeCheque, usada por RegistrarAuditoria (via BusinessBase) caso
    * algum passo futuro do historico precise identificar o registro.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigChe para as
    * propriedades do BO. Alimentado pelo cursor que fica posicionado no
    * cheque corrente da GradeCheque (Pagina.Historico) apos o usuario
    * selecionar uma linha - equivalente ao acesso direto a crSigChe.<col>
    * que o legado faz em Grupo_op.Click (Relatorio/Documento/Prorroga/
    * FollowUp/Protocolo/Carteira) e em GradeCheque.AfterRowColChange.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cNums       = TratarNulo(Nums, "C")
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_cBancos     = TratarNulo(Bancos, "C")
            THIS.this_cAgencias   = TratarNulo(Agencias, "C")
            THIS.this_lAutos      = ConverterParaLogico(Autos)
            THIS.this_cConCarts   = TratarNulo(ConCarts, "C")
            THIS.this_cConOrigs   = TratarNulo(ConOrigs, "C")
            THIS.this_cConRes     = TratarNulo(ConRes, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cCopchs     = TratarNulo(Copchs, "C")
            THIS.this_dDatas      = ConverterParaData(Datas)
            THIS.this_dDataTrans  = ConverterParaData(DataTrans)
            THIS.this_cFpags      = TratarNulo(Fpags, "C")
            THIS.this_cGrClis     = TratarNulo(GrClis, "C")
            THIS.this_cGruCarts   = TratarNulo(GruCarts, "C")
            THIS.this_cGruOrigs   = TratarNulo(GruOrigs, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cGrures     = TratarNulo(Grures, "C")
            THIS.this_cGrvends    = TratarNulo(Grvends, "C")
            THIS.this_cIClis      = TratarNulo(Iclis, "C")
            THIS.this_cLeituras   = TratarNulo(Leituras, "C")
            THIS.this_cLocals     = TratarNulo(Locals, "C")
            THIS.this_nNalineas   = NVL(Nalineas, 0)
            THIS.this_cNCheques   = TratarNulo(NCheques, "C")
            THIS.this_cNContas    = TratarNulo(NContas, "C")
            THIS.this_cNotas      = TratarNulo(Notas, "C")
            THIS.this_nNtrans     = NVL(Ntrans, 0)
            THIS.this_cNumeros    = TratarNulo(Numeros, "C")
            THIS.this_cNumolds    = TratarNulo(Numolds, "C")
            THIS.this_nNumos      = NVL(Numos, 0)
            THIS.this_cProtocolos = TratarNulo(Protocolos, "C")
            THIS.this_cUMovs      = TratarNulo(UMovs, "C")
            THIS.this_nValors     = NVL(Valors, 0)
            THIS.this_nValpags    = NVL(Valpags, 0)
            THIS.this_dVencs      = ConverterParaData(Vencs)
            THIS.this_cVends      = TratarNulo(Vends, "C")
            THIS.this_dDtEmis     = ConverterParaData(DtEmis)
            THIS.this_dDtAlts     = ConverterParaData(DtAlts)
            THIS.this_cContat     = TratarNulo(Contat, "C")
            THIS.this_cGrupot     = TratarNulo(Grupot, "C")
            THIS.this_nCotas      = NVL(Cotas, 0)
            THIS.this_cMoeds      = TratarNulo(Moeds, "C")
            THIS.this_nTipoBlq    = NVL(TipoBlq, 0)
            THIS.this_cCustodia   = TratarNulo(Custodia, "C")

            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * SigOpChi (Historico de Cheques) eh um form de CONSULTA: o legado
    * (SIGOPCHI) nao faz Insert/Update/Delete em SigChe por esta tela - o
    * usuario apenas filtra por conta/periodo e navega para os formularios
    * de detalhe (SigOpChr, SigOpChb, SigOpChp, SigOpFlp, SigOpChc), que sao
    * os responsaveis por qualquer gravacao. Por isso o comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao)
    * ja eh o correto para este BO.
    *==========================================================================

ENDDEFINE

