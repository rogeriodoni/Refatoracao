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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3822 linhas total):

*-- Linhas 41 a 49:
41: * Container cnt_4c_Cadastro (legado: PageFrame "Cadastro", pagina
42: * unica "Dados", Top=155/Left=59/Width=701/Height=421 em
43: * pag_resultado) replicado como Container simples com Top compensado
44: * (+29 do PageFrame.Top=-29). Todos os TextBoxes desta aba sao
45: * somente-leitura (legado: Get_codfor/Get_nome/Get_end/Get_bairro/...
46: * tem Procedure When / Return(.F.) - nunca recebem foco, so exibem o
47: * resultado da consulta). Populados pelo BOParaForm nas Fases 7-8.
48: *==============================================================================
49: 

*-- Linhas 225 a 243:
225:         loc_oPgf = THIS.pgf_4c_Paginas
226: 
227:         loc_oPgf.PageCount = 2
228:         loc_oPgf.Top       = -29
229:         loc_oPgf.Left      = 0
230:         loc_oPgf.Width     = THIS.Width
231:         loc_oPgf.Height    = THIS.Height + 29
232:         loc_oPgf.TabIndex  = 1
233:         loc_oPgf.Tabs      = .F.
234: 
235:         loc_oPgf.Page1.Caption = "Consulta"
236:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
237: 
238:         loc_oPgf.Page2.Caption = "Resultado"
239:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
240: 
241:         loc_oPgf.Visible    = .T.
242:         loc_oPgf.ActivePage = 1
243:     ENDPROC

*-- Linhas 260 a 314:
260:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
261:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
262:         WITH loc_oCab
263:             .Top           = 29
264:             .Left          = 0
265:             .Width         = THIS.Width
266:             .Height        = 80
267:             .BorderWidth   = 0
268:             .SpecialEffect = 0
269:             .BackColor     = RGB(100, 100, 100)
270: 
271:             .AddObject("lbl_4c_Sombra", "Label")
272:             WITH .lbl_4c_Sombra
273:                 .Top       = 15
274:                 .Left      = 10
275:                 .Width     = THIS.Width
276:                 .Height    = 40
277:                 .FontName  = "Tahoma"
278:                 .FontSize  = 16
279:                 .FontBold  = .T.
280:                 .WordWrap  = .T.
281:                 .Alignment = 0
282:                 .BackStyle = 0
283:                 .ForeColor = RGB(0, 0, 0)
284:                 .Caption   = THIS.Caption
285:             ENDWITH
286: 
287:             .AddObject("lbl_4c_Titulo", "Label")
288:             WITH .lbl_4c_Titulo
289:                 .Top       = 18
290:                 .Left      = 10
291:                 .Width     = THIS.Width
292:                 .Height    = 46
293:                 .FontName  = "Tahoma"
294:                 .FontSize  = 16
295:                 .FontBold  = .T.
296:                 .WordWrap  = .T.
297:                 .Alignment = 0
298:                 .BackStyle = 0
299:                 .ForeColor = RGB(255, 255, 255)
300:                 .Caption   = THIS.Caption
301:             ENDWITH
302:         ENDWITH
303: 
304:         *-- Container do CommandGroup grp_operacao (legado: Left=554, Top=-1,
305:         *-- Width=254, Height=110, ButtonCount=3).
306:         loc_oPag.AddObject("cnt_4c_Botoes", "Container")
307:         WITH loc_oPag.cnt_4c_Botoes
308:             .Top         = 29
309:             .Left        =  542
310:             .Width       = 254
311:             .Height      = 85
312:             .BackStyle   = 0
313:             .BorderWidth = 0
314:             .Visible     = .T.

*-- Linhas 324 a 333:
324:         *-- a navegacao entre paginas (AlternarPagina) ja fica funcional.
325:         loc_oPag.cnt_4c_Botoes.AddObject("cmg_4c_Operacao", "CommandGroup")
326:         WITH loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao
327:             .Top         = 0
328:             .Left        = 0
329:             .Width       = 254
330:             .Height      = 85
331:             .ButtonCount = 3
332:             .BackStyle   = 0
333:             .BorderStyle = 0

*-- Linhas 339 a 379:
339:             *-- eh do bloco CRUD canonico do frmcadastro, e este form eh
340:             *-- OPERACIONAL - o SCX declara Tahoma nos tres botoes.
341:             WITH .Buttons(3)
342:                 .Caption    = "Dados " + CHR(60) + "Cadastrais"
343:                 .Top        = 5
344:                 .Left       = 16
345:                 .Width      = 75
346:                 .Height     = 75
347:                 .FontName   = "Tahoma"
348:                 .FontSize   = 8
349:                 .WordWrap   = .T.
350:                 .ForeColor  = RGB(90, 90, 90)
351:                 .BackColor  = RGB(255, 255, 255)
352:                 .Themes     = .F.
353:                 .Picture    = gc_4c_CaminhoIcones + "geral_usuarios_60.jpg"
354:             ENDWITH
355: 
356:             WITH .Buttons(1)
357:                 .Caption    = CHR(60) + "Movimenta" + CHR(231) + CHR(227) + "o"
358:                 .Top        = 5
359:                 .Left       = 92
360:                 .Width      = 75
361:                 .Height     = 75
362:                 .FontName   = "Tahoma"
363:                 .FontSize   = 7
364:                 .WordWrap   = .T.
365:                 .ForeColor  = RGB(90, 90, 90)
366:                 .BackColor  = RGB(255, 255, 255)
367:                 .Themes     = .F.
368:                 .Picture    = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
369:             ENDWITH
370: 
371:             WITH .Buttons(2)
372:                 .Caption    = "Encerrar"
373:                 .Top        = 5
374:                 .Left       = 168
375:                 .Width      = 75
376:                 .Height     = 75
377:                 .FontName   = "Tahoma"
378:                 .FontSize   = 8
379:                 .WordWrap   = .T.

*-- Linhas 401 a 705:
401:         *-- CLAUDE.md "fAcessoEmpresa() NAO EXISTE").
402:         loc_oPag.AddObject("shp_4c_Shp_principal", "Shape")
403:         WITH loc_oPag.shp_4c_Shp_principal
404:             .Top           = 296
405:             .Left          = 92
406:             .Width         = 615
407:             .Height        = 69
408:             .BackStyle     = 0
409:             .SpecialEffect = 1
410:         ENDWITH
411: 
412:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
413:         WITH loc_oPag.lbl_4c_Label2
414:             .Top       = 313
415:             .Left      = 146
416:             .Width     = 51
417:             .Height    = 28
418:             .FontName  = "Tahoma"
419:             .FontSize  = 8
420:             .WordWrap  = .T.
421:             .Alignment = 1
422:             .BackStyle = 0
423:             .ForeColor = RGB(90, 90, 90)
424:             .Caption   = "An" + CHR(225) + "lise de Vendas :"
425:         ENDWITH
426: 
427:         loc_oPag.AddObject("obj_4c_Opt_Analise", "OptionGroup")
428:         WITH loc_oPag.obj_4c_Opt_Analise
429:             .Top           = 309
430:             .Left          = 214
431:             .Width         = 56
432:             .Height        = 46
433:             .ButtonCount   = 2
434:             .BackStyle     = 0
435:             .SpecialEffect = 1
436:             .BorderColor   = RGB(136, 188, 189)
437:             .Value         = 2
438: 
439:             WITH .Buttons(1)
440:                 .Caption   = "Sim"
441:                 .FontName  = "Verdana"
442:                 .FontSize  = 8
443:                 .BackStyle = 0
444:                 .Top       = 5
445:                 .Left      = 7
446:                 .Width     = 42
447:                 .Height    = 17
448:                 .ForeColor = RGB(36, 84, 155)
449:             ENDWITH
450: 
451:             WITH .Buttons(2)
452:                 .Caption   = "N" + CHR(227) + "o"
453:                 .FontName  = "Verdana"
454:                 .FontSize  = 8
455:                 .BackStyle = 0
456:                 .Top       = 22
457:                 .Left      = 7
458:                 .Width     = 42
459:                 .Height    = 17
460:                 .ForeColor = RGB(36, 84, 155)
461:             ENDWITH
462:         ENDWITH
463:         BINDEVENT(loc_oPag.obj_4c_Opt_Analise, "InteractiveChange", THIS, "OptAnaliseChange")
464: 
465:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
466:         WITH loc_oPag.lbl_4c_Label1
467:             .Top       = 309
468:             .Left      = 296
469:             .Width     = 45
470:             .Height    = 15
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .Alignment = 0
474:             .BackStyle = 0
475:             .ForeColor = RGB(90, 90, 90)
476:             .Caption   = "Per" + CHR(237) + "odo :"
477:         ENDWITH
478: 
479:         loc_oPag.AddObject("txt_4c_Datai", "TextBox")
480:         WITH loc_oPag.txt_4c_Datai
481:             .Top      = 306
482:             .Left     = 368
483:             .Width    = 88
484:             .Height   = 23
485:             .FontName = "Courier New"
486:             .Alignment = 3
487:             .Value    = {}
488:             .Format   = "K!"
489:         ENDWITH
490:         BINDEVENT(loc_oPag.txt_4c_Datai, "KeyPress", THIS, "ValidarDataI")
491: 
492:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
493:         WITH loc_oPag.lbl_4c_Label7
494:             .Top       = 309
495:             .Left      = 349
496:             .Width     = 14
497:             .Height    = 15
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8
500:             .Alignment = 0
501:             .BackStyle = 0
502:             .ForeColor = RGB(90, 90, 90)
503:             .Caption   = "de"
504:         ENDWITH
505: 
506:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
507:         WITH loc_oPag.lbl_4c_Label6
508:             .Top       = 334
509:             .Left      = 346
510:             .Width     = 18
511:             .Height    = 15
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .Alignment = 0
515:             .BackStyle = 0
516:             .ForeColor = RGB(90, 90, 90)
517:             .Caption   = "at" + CHR(233)
518:         ENDWITH
519: 
520:         loc_oPag.AddObject("txt_4c_Dataf", "TextBox")
521:         WITH loc_oPag.txt_4c_Dataf
522:             .Top      = 332
523:             .Left     = 368
524:             .Width    = 88
525:             .Height   = 23
526:             .FontName = "Courier New"
527:             .Alignment = 3
528:             .Value    = {}
529:             .Format   = "K!"
530:         ENDWITH
531:         BINDEVENT(loc_oPag.txt_4c_Dataf, "KeyPress", THIS, "ValidarDataF")
532: 
533:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
534:         WITH loc_oPag.lbl_4c_Label3
535:             .Top       = 310
536:             .Left      = 511
537:             .Width     = 41
538:             .Height    = 15
539:             .FontName  = "Tahoma"
540:             .FontSize  = 8
541:             .Alignment = 0
542:             .BackStyle = 0
543:             .ForeColor = RGB(90, 90, 90)
544:             .Caption   = "Moeda :"
545:         ENDWITH
546: 
547:         loc_oPag.AddObject("txt_4c_Moeda", "TextBox")
548:         WITH loc_oPag.txt_4c_Moeda
549:             .Top        = 306
550:             .Left       = 555
551:             .Width      = 36
552:             .Height     = 23
553:             .FontName   = "Courier New"
554:             .FontItalic = .F.
555:             .Alignment  = 0
556:             .Format     = "K"
557:             .InputMask  = "!!!"
558:             .MaxLength  = 3
559:             .Value      = ""
560:         ENDWITH
561:         BINDEVENT(loc_oPag.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
562: 
563:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
564:         WITH loc_oPag.lbl_4c_Label5
565:             .Top       = 336
566:             .Left      = 502
567:             .Width     = 50
568:             .Height    = 15
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .Alignment = 0
572:             .BackStyle = 0
573:             .ForeColor = RGB(90, 90, 90)
574:             .Caption   = "Empresa :"
575:         ENDWITH
576: 
577:         loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
578:         WITH loc_oPag.txt_4c_Empresa
579:             .Top       = 332
580:             .Left      = 555
581:             .Width     = 36
582:             .Height    = 23
583:             .FontName  = "Courier New"
584:             .Alignment = 3
585:             .Value     = ""
586:             .MaxLength   = 3
587:         ENDWITH
588:         BINDEVENT(loc_oPag.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")
589: 
590:         *-- Container Origem - Grupo/Conta do fornecedor pesquisado
591:         loc_oPag.AddObject("cnt_4c_Origem", "Container")
592:         WITH loc_oPag.cnt_4c_Origem
593:             .Top       = 239
594:             .Left      = 92
595:             .Width     = 615
596:             .Height    = 40
597:             .BackStyle = 0
598: 
599:             .AddObject("lbl_4c__Origem1", "Label")
600:             WITH .lbl_4c__Origem1
601:                 .Top       = 2
602:                 .Left      = 6
603:                 .FontBold  = .T.
604:                 .FontSize  = 8
605:                 .BackStyle = 0
606:                 .ForeColor = RGB(90, 90, 90)
607:                 .Caption   = "Grupo / Conta"
608:             ENDWITH
609: 
610:             .AddObject("lbl_4c_Label1", "Label")
611:             WITH .lbl_4c_Label1
612:                 .Top       = 17
613:                 .Left      = 87
614:                 .Width     = 11
615:                 .Height    = 15
616:                 .FontBold  = .T.
617:                 .Caption   = " : "
618:             ENDWITH
619: 
620:             .AddObject("txt_4c_Grupo", "TextBox")
621:             WITH .txt_4c_Grupo
622:                 .Top       = 15
623:                 .Left      = 7
624:                 .Width     = 80
625:                 .Height    = 21
626:                 .FontBold  = .T.
627:                 .Alignment = 3
628:                 .Margin    = 0
629:                 .InputMask = "XXXXXXXXXX"
630:                 .MaxLength = 10
631:                 .DisabledBackColor = RGB(255, 255, 255)
632:                 .Value     = ""
633:             ENDWITH
634:             BINDEVENT(.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
635: 
636:             .AddObject("lbl_4c_Label2", "Label")
637:             WITH .lbl_4c_Label2
638:                 .Top       = 2
639:                 .Left      = 107
640:                 .FontBold  = .F.
641:                 .FontSize  = 8
642:                 .BackStyle = 0
643:                 .ForeColor = RGB(90, 90, 90)
644:                 .Caption   = "Conta"
645:             ENDWITH
646: 
647:             .AddObject("txt_4c_Conta", "TextBox")
648:             WITH .txt_4c_Conta
649:                 .Top       = 15
650:                 .Left      = 97
651:                 .Width     = 80
652:                 .Height    = 21
653:                 .Margin    = 0
654:                 .InputMask = "XXXXXXXXXX"
655:                 .MaxLength = 10
656:                 .DisabledBackColor = RGB(255, 255, 255)
657:                 .Value     = ""
658:             ENDWITH
659:             BINDEVENT(.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
660: 
661:             .AddObject("lbl_4c__CPF", "Label")
662:             WITH .lbl_4c__CPF
663:                 .Top       = 2
664:                 .Left      = 183
665:                 .FontBold  = .F.
666:                 .FontSize  = 8
667:                 .BackStyle = 0
668:                 .ForeColor = RGB(90, 90, 90)
669:                 .Caption   = "CPF / CGC"
670:             ENDWITH
671: 
672:             .AddObject("txt_4c_Cpf", "TextBox")
673:             WITH .txt_4c_Cpf
674:                 .Top       = 15
675:                 .Left      = 181
676:                 .Width     = 146
677:                 .Height    = 21
678:                 .Margin    = 0
679:                 .InputMask = "XXXXXXXXXXXXXXXXXXXX"
680:                 .MaxLength = 20
681:                 .DisabledBackColor = RGB(255, 255, 255)
682:                 .Value     = ""
683:             ENDWITH
684:             BINDEVENT(.txt_4c_Cpf, "KeyPress", THIS, "ValidarCpf")
685: 
686:             .AddObject("lbl_4c__dConta", "Label")
687:             WITH .lbl_4c__dConta
688:                 .Top       = 2
689:                 .Left      = 332
690:                 .FontBold  = .F.
691:                 .FontSize  = 8
692:                 .BackStyle = 0
693:                 .ForeColor = RGB(90, 90, 90)
694:                 .Caption   = "Nome"
695:             ENDWITH
696: 
697:             .AddObject("txt_4c_Dconta", "TextBox")
698:             WITH .txt_4c_Dconta
699:                 .Top       = 15
700:                 .Left      = 330
701:                 .Width     = 278
702:                 .Height    = 21
703:                 .Margin    = 0
704:                 .InputMask = REPLICATE("X", 40)
705:                 .MaxLength = 40

*-- Linhas 730 a 775:
730:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
731:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
732:         WITH loc_oCab
733:             .Top           = 29
734:             .Left          = 0
735:             .Width         = THIS.Width
736:             .Height        = 80
737:             .BorderWidth   = 0
738:             .SpecialEffect = 0
739:             .BackColor     = RGB(100, 100, 100)
740: 
741:             .AddObject("lbl_4c_Sombra", "Label")
742:             WITH .lbl_4c_Sombra
743:                 .Top       = 15
744:                 .Left      = 10
745:                 .Width     = THIS.Width
746:                 .Height    = 40
747:                 .FontName  = "Tahoma"
748:                 .FontSize  = 16
749:                 .FontBold  = .T.
750:                 .WordWrap  = .T.
751:                 .Alignment = 0
752:                 .BackStyle = 0
753:                 .ForeColor = RGB(0, 0, 0)
754:                 .Caption   = THIS.Caption
755:             ENDWITH
756: 
757:             .AddObject("lbl_4c_Titulo", "Label")
758:             WITH .lbl_4c_Titulo
759:                 .Top       = 18
760:                 .Left      = 10
761:                 .Width     = THIS.Width
762:                 .Height    = 46
763:                 .FontName  = "Tahoma"
764:                 .FontSize  = 16
765:                 .FontBold  = .T.
766:                 .WordWrap  = .T.
767:                 .Alignment = 0
768:                 .BackStyle = 0
769:                 .ForeColor = RGB(255, 255, 255)
770:                 .Caption   = THIS.Caption
771:             ENDWITH
772:         ENDWITH
773: 
774:         *-- cnt_4c_Cadastro - Cadastro.Dados do legado (dados cadastrais do
775:         *-- fornecedor pesquisado). PageFrame "Cadastro" legado tem

*-- Linhas 782 a 1099:
782:         *-- restante dos campos/foto entram na Fase 6/8).
783:         loc_oPag.AddObject("cnt_4c_Cadastro", "Container")
784:         WITH loc_oPag.cnt_4c_Cadastro
785:             .Top         = 184
786:             .Left        = 59
787:             .Width       = 701
788:             .Height      = 421
789:             .BackStyle   = 0
790:             .BorderWidth = 0
791: 
792:             *-- Shape1 legado - moldura ao redor de Codigo/Nome
793:             .AddObject("shp_4c_Dados", "Shape")
794:             WITH .shp_4c_Dados
795:                 .Top    = 16
796:                 .Left   = 24
797:                 .Width  = 384
798:                 .Height = 68
799:             ENDWITH
800: 
801:             *-- shpFigura legado - moldura ao redor da foto do
802:             *-- fornecedor (olebcFigura/ImgFigJpg entram na Fase 6/8)
803:             .AddObject("shp_4c_Figura", "Shape")
804:             WITH .shp_4c_Figura
805:                 .Top    = 16
806:                 .Left   = 489
807:                 .Width  = 184
808:                 .Height = 144
809:             ENDWITH
810: 
811:             *-- Say1 "Codigo : " / Get_codfor
812:             .AddObject("lbl_4c_Codigo", "Label")
813:             WITH .lbl_4c_Codigo
814:                 .Top       = 28
815:                 .Left      = 54
816:                 .Width     = 60
817:                 .Height    = 15
818:                 .Alignment = 0
819:                 .BackStyle = 0
820:                 .ForeColor = RGB(90, 90, 90)
821:                 .Caption   = "C" + CHR(243) + "digo :"
822:             ENDWITH
823: 
824:             .AddObject("txt_4c_CodFor", "TextBox")
825:             WITH .txt_4c_CodFor
826:                 .Top      = 25
827:                 .Left     = 101
828:                 .Width    = 80
829:                 .Height   = 21
830:                 .Value    = ""
831:                 .ReadOnly = .T.
832:                 .TabStop  = .F.
833:             ENDWITH
834: 
835:             *-- Say2 "Nome : " / Get_nome
836:             .AddObject("lbl_4c_Nome", "Label")
837:             WITH .lbl_4c_Nome
838:                 .Top       = 54
839:                 .Left      = 60
840:                 .Width     = 45
841:                 .Height    = 15
842:                 .Alignment = 0
843:                 .BackStyle = 0
844:                 .ForeColor = RGB(90, 90, 90)
845:                 .Caption   = "Nome :"
846:             ENDWITH
847: 
848:             .AddObject("txt_4c_Nome", "TextBox")
849:             WITH .txt_4c_Nome
850:                 .Top      = 51
851:                 .Left     = 101
852:                 .Width    = 290
853:                 .Height   = 21
854:                 .Value    = ""
855:                 .ReadOnly = .T.
856:                 .TabStop  = .F.
857:             ENDWITH
858: 
859:             *-- Say3 "Endereco : " / Get_end
860:             .AddObject("lbl_4c_End", "Label")
861:             WITH .lbl_4c_End
862:                 .Top       = 100
863:                 .Left      = 41
864:                 .Width     = 70
865:                 .Height    = 15
866:                 .Alignment = 0
867:                 .BackStyle = 0
868:                 .ForeColor = RGB(90, 90, 90)
869:                 .Caption   = "Endere" + CHR(231) + "o :"
870:             ENDWITH
871: 
872:             .AddObject("txt_4c_End", "TextBox")
873:             WITH .txt_4c_End
874:                 .Top      = 95
875:                 .Left     = 101
876:                 .Width    = 290
877:                 .Height   = 21
878:                 .Value    = ""
879:                 .ReadOnly = .T.
880:                 .TabStop  = .F.
881:             ENDWITH
882: 
883:             *-- Say4 "Bairro : " / Get_bairro
884:             .AddObject("lbl_4c_Bairro", "Label")
885:             WITH .lbl_4c_Bairro
886:                 .Top       = 127
887:                 .Left      = 58
888:                 .Width     = 53
889:                 .Height    = 15
890:                 .Alignment = 0
891:                 .BackStyle = 0
892:                 .ForeColor = RGB(90, 90, 90)
893:                 .Caption   = "Bairro :"
894:             ENDWITH
895: 
896:             .AddObject("txt_4c_Bairro", "TextBox")
897:             WITH .txt_4c_Bairro
898:                 .Top      = 124
899:                 .Left     = 101
900:                 .Width    = 150
901:                 .Height   = 21
902:                 .Value    = ""
903:                 .ReadOnly = .T.
904:                 .TabStop  = .F.
905:             ENDWITH
906: 
907:             *-- Say5 "Cep : " (TextBox Get_cep entra na Fase 6/8)
908:             .AddObject("lbl_4c_Cep", "Label")
909:             WITH .lbl_4c_Cep
910:                 .Top       = 127
911:                 .Left      = 328
912:                 .Width     = 34
913:                 .Height    = 15
914:                 .Alignment = 0
915:                 .BackStyle = 0
916:                 .ForeColor = RGB(90, 90, 90)
917:                 .Caption   = "Cep :"
918:             ENDWITH
919: 
920:             *-- Say6 "Cidade : " (TextBox Get_cid entra na Fase 6/8)
921:             .AddObject("lbl_4c_Cidade", "Label")
922:             WITH .lbl_4c_Cidade
923:                 .Top       = 154
924:                 .Left      = 53
925:                 .Width     = 58
926:                 .Height    = 15
927:                 .Alignment = 0
928:                 .BackStyle = 0
929:                 .ForeColor = RGB(90, 90, 90)
930:                 .Caption   = "Cidade :"
931:             ENDWITH
932: 
933:             *-- Say7 "Estado : " (TextBox Get_est entra na Fase 6/8)
934:             .AddObject("lbl_4c_Estado", "Label")
935:             WITH .lbl_4c_Estado
936:                 .Top       = 154
937:                 .Left      = 314
938:                 .Width     = 58
939:                 .Height    = 15
940:                 .Alignment = 0
941:                 .BackStyle = 0
942:                 .ForeColor = RGB(90, 90, 90)
943:                 .Caption   = "Estado :"
944:             ENDWITH
945: 
946:             *-- Say8 "Telefone 1 : " / Get_tel1
947:             .AddObject("lbl_4c_Tel1", "Label")
948:             WITH .lbl_4c_Tel1
949:                 .Top       = 182
950:                 .Left      = 35
951:                 .Width     = 76
952:                 .Height    = 15
953:                 .Alignment = 0
954:                 .BackStyle = 0
955:                 .ForeColor = RGB(90, 90, 90)
956:                 .Caption   = "Telefone 1 :"
957:             ENDWITH
958: 
959:             .AddObject("txt_4c_Tel1", "TextBox")
960:             WITH .txt_4c_Tel1
961:                 .Top      = 179
962:                 .Left     = 101
963:                 .Width    = 150
964:                 .Height   = 21
965:                 .Value    = ""
966:                 .ReadOnly = .T.
967:                 .TabStop  = .F.
968:             ENDWITH
969: 
970:             *-- Say9 "Telefone 2 : " / Get_tel2
971:             .AddObject("lbl_4c_Tel2", "Label")
972:             WITH .lbl_4c_Tel2
973:                 .Top       = 210
974:                 .Left      = 35
975:                 .Width     = 76
976:                 .Height    = 15
977:                 .Alignment = 0
978:                 .BackStyle = 0
979:                 .ForeColor = RGB(90, 90, 90)
980:                 .Caption   = "Telefone 2 :"
981:             ENDWITH
982: 
983:             .AddObject("txt_4c_Tel2", "TextBox")
984:             WITH .txt_4c_Tel2
985:                 .Top      = 207
986:                 .Left     = 101
987:                 .Width    = 150
988:                 .Height   = 21
989:                 .Value    = ""
990:                 .ReadOnly = .T.
991:                 .TabStop  = .F.
992:             ENDWITH
993: 
994:             *-- Say10 "Fax : " / Get_fax
995:             .AddObject("lbl_4c_Fax", "Label")
996:             WITH .lbl_4c_Fax
997:                 .Top       = 237
998:                 .Left      = 68
999:                 .Width     = 35
1000:                 .Height    = 15
1001:                 .Alignment = 0
1002:                 .BackStyle = 0
1003:                 .ForeColor = RGB(90, 90, 90)
1004:                 .Caption   = "Fax :"
1005:             ENDWITH
1006: 
1007:             .AddObject("txt_4c_Fax", "TextBox")
1008:             WITH .txt_4c_Fax
1009:                 .Top      = 234
1010:                 .Left     = 101
1011:                 .Width    = 150
1012:                 .Height   = 21
1013:                 .Value    = ""
1014:                 .ReadOnly = .T.
1015:                 .TabStop  = .F.
1016:             ENDWITH
1017: 
1018:             *-- Say11 "C.G.C : " / Get_cgc
1019:             .AddObject("lbl_4c_Cgc", "Label")
1020:             WITH .lbl_4c_Cgc
1021:                 .Top       = 182
1022:                 .Left      = 318
1023:                 .Width     = 44
1024:                 .Height    = 15
1025:                 .Alignment = 0
1026:                 .BackStyle = 0
1027:                 .ForeColor = RGB(90, 90, 90)
1028:                 .Caption   = "C.G.C :"
1029:             ENDWITH
1030: 
1031:             .AddObject("txt_4c_Cgc", "TextBox")
1032:             WITH .txt_4c_Cgc
1033:                 .Top      = 179
1034:                 .Left     = 362
1035:                 .Width    = 150
1036:                 .Height   = 21
1037:                 .Value    = ""
1038:                 .ReadOnly = .T.
1039:                 .TabStop  = .F.
1040:             ENDWITH
1041: 
1042:             *-- Say12 "I.E. : " / Get_ie
1043:             .AddObject("lbl_4c_Ie", "Label")
1044:             WITH .lbl_4c_Ie
1045:                 .Top       = 210
1046:                 .Left      = 329
1047:                 .Width     = 33
1048:                 .Height    = 15
1049:                 .Alignment = 0
1050:                 .BackStyle = 0
1051:                 .ForeColor = RGB(90, 90, 90)
1052:                 .Caption   = "I.E. :"
1053:             ENDWITH
1054: 
1055:             .AddObject("txt_4c_Ie", "TextBox")
1056:             WITH .txt_4c_Ie
1057:                 .Top      = 207
1058:                 .Left     = 362
1059:                 .Width    = 150
1060:                 .Height   = 21
1061:                 .Value    = ""
1062:                 .ReadOnly = .T.
1063:                 .TabStop  = .F.
1064:             ENDWITH
1065: 
1066:             *-- Get_cep (label lbl_4c_Cep ja criada na Fase 5)
1067:             .AddObject("txt_4c_Cep", "TextBox")
1068:             WITH .txt_4c_Cep
1069:                 .Top      = 124
1070:                 .Left     = 362
1071:                 .Width    = 73
1072:                 .Height   = 21
1073:                 .Value    = ""
1074:                 .ReadOnly = .T.
1075:                 .TabStop  = .F.
1076:             ENDWITH
1077: 
1078:             *-- Get_cid (label lbl_4c_Cidade ja criada na Fase 5)
1079:             .AddObject("txt_4c_Cid", "TextBox")
1080:             WITH .txt_4c_Cid
1081:                 .Top      = 151
1082:                 .Left     = 101
1083:                 .Width    = 185
1084:                 .Height   = 21
1085:                 .Value    = ""
1086:                 .ReadOnly = .T.
1087:                 .TabStop  = .F.
1088:             ENDWITH
1089: 
1090:             *-- Get_est (label lbl_4c_Estado ja criada na Fase 5)
1091:             .AddObject("txt_4c_Est", "TextBox")
1092:             WITH .txt_4c_Est
1093:                 .Top      = 151
1094:                 .Left     = 362
1095:                 .Width    = 24
1096:                 .Height   = 21
1097:                 .Value    = ""
1098:                 .ReadOnly = .T.
1099:                 .TabStop  = .F.

*-- Linhas 1107 a 1166:
1107:             *-- legado quando TmpPro/figjpgs vem vazio.
1108:             .AddObject("img_4c_Figura", "Image")
1109:             WITH .img_4c_Figura
1110:                 .Top      = 20
1111:                 .Left     = 494
1112:                 .Width    = 174
1113:                 .Height   = 136
1114:                 .Stretch  = 1
1115:                 .Visible  = .F.
1116:             ENDWITH
1117: 
1118:             .AddObject("lbl_4c_MsgFoto", "Label")
1119:             WITH .lbl_4c_MsgFoto
1120:                 .Top       = 64
1121:                 .Left      = 518
1122:                 .Width     = 111
1123:                 .Height    = 15
1124:                 .Alignment = 0
1125:                 .BackStyle = 0
1126:                 .ForeColor = RGB(90, 90, 90)
1127:                 .Caption   = "Foto n" + CHR(227) + "o dispon" + CHR(237) + "vel"
1128:             ENDWITH
1129:         ENDWITH
1130: 
1131:         *-- Container dos botoes de acao da Page2 (grp_operacao/Cmd_MudaFor/
1132:         *-- Cmd_MudaMov do legado).
1133:         loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
1134:         WITH loc_oPag.cnt_4c_BotoesAcao
1135:             .Top         = 29
1136:             .Left        = 716
1137:             .Width       = 160
1138:             .Height      = 110
1139:             .BackStyle   = 0
1140:             .BorderWidth = 0
1141:             .Visible     = .T.
1142:         ENDWITH
1143: 
1144:         *-- grp_operacao (legado: Left=716,Top=-1,W=90,H=110,ButtonCount=1)
1145:         *-- - botao unico "Voltar" (Click legado: If ThisForm.Automatico /
1146:         *-- ThisForm.Release / Else / ThisForm.Fld_Principal.ActivePage=1).
1147:         loc_oPag.cnt_4c_BotoesAcao.AddObject("cmg_4c_Operacao", "CommandGroup")
1148:         WITH loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao
1149:             .Top         = 0
1150:             .Left        = 0
1151:             .Width       = 90
1152:             .Height      = 85
1153:             .ButtonCount = 1
1154:             .BackStyle   = 0
1155:             .BorderStyle = 0
1156:             .Themes      = .F.
1157: 
1158:             WITH .Buttons(1)
1159:                 .Caption    = "Voltar"
1160:                 .Top        = 5
1161:                 .Left       = 5
1162:                 .Width      = 75
1163:                 .Height     = 75
1164:                 .FontName   = "Comic Sans MS"
1165:                 .FontBold   = .T.
1166:                 .FontItalic = .T.

*-- Linhas 1177 a 1209:
1177:         *-- Cmd_MudaFor / Cmd_MudaMov (legado: Top=101,Left=629/671,W=50,
1178:         *-- H=50,ButtonCount=1 cada) - alternam a exibicao entre a
1179:         *-- sub-pagina Cadastro e a sub-pagina Movimento/Result da Page2
1180:         *-- (Top compensado +29 pelo PageFrame.Top=-29). Os containers
1181:         *-- Cadastro/Result ainda nao existem (entram quando as paginas
1182:         *-- internas forem construidas) - os handlers ja alternam a
1183:         *-- visibilidade entre os dois botoes, igual ao legado
1184:         *-- (Cmd_MudaFor.Click/Cmd_MudaMov.Click trocam Enabled/Visible um
1185:         *-- do outro); a troca de Cadastro.Visible/Result.Visible eh
1186:         *-- concluida quando esses containers existirem.
1187:         loc_oPag.AddObject("cmg_4c_MudaFor", "CommandGroup")
1188:         WITH loc_oPag.cmg_4c_MudaFor
1189:             .Top         = 130
1190:             .Left        = 629
1191:             .Width       = 50
1192:             .Height      = 50
1193:             .ButtonCount = 1
1194:             .BackStyle   = 0
1195:             .BorderStyle = 0
1196:             .Themes      = .F.
1197:             .Visible     = .F.
1198: 
1199:             *-- Legado Cmd_MudaFor.Command1 (cmd_cadastro): botao SO de icone,
1200:             *-- Caption vazio, ToolTipText "Dados Cadastrais", Verdana 8.
1201:             WITH .Buttons(1)
1202:                 .Caption     = ""
1203:                 .Top         = 5
1204:                 .Left        = 5
1205:                 .Width       = 40
1206:                 .Height      = 40
1207:                 .FontName    = "Verdana"
1208:                 .FontSize    = 8
1209:                 .WordWrap    = .T.

*-- Linhas 1219 a 1241:
1219: 
1220:         loc_oPag.AddObject("cmg_4c_MudaMov", "CommandGroup")
1221:         WITH loc_oPag.cmg_4c_MudaMov
1222:             .Top         = 130
1223:             .Left        = 671
1224:             .Width       = 50
1225:             .Height      = 50
1226:             .ButtonCount = 1
1227:             .BackStyle   = 0
1228:             .BorderStyle = 0
1229:             .Themes      = .F.
1230: 
1231:             *-- Legado Cmd_MudaMov.Command1 (cmd_movimenta): idem, ToolTipText
1232:             *-- "Movimentacao".
1233:             WITH .Buttons(1)
1234:                 .Caption     = ""
1235:                 .Top         = 5
1236:                 .Left        = 5
1237:                 .Width       = 40
1238:                 .Height      = 40
1239:                 .FontName    = "Verdana"
1240:                 .FontSize    = 8
1241:                 .WordWrap    = .T.

*-- Linhas 1263 a 1271:
1263:     * Conserto): ActivePage eh o PageOrder, nao a ordem de declaracao, e eh o
1264:     * PageOrder que o usuario ve na fileira de abas.
1265:     *
1266:     * Top do PageFrame compensado (+29 pelo pgf_4c_Paginas.Top = -29): legado
1267:     * 157 -> 186. Dentro dele os Tops sao relativos a cada Page e vao CRUS do
1268:     * dump, sem compensacao.
1269:     *
1270:     * Os grids sao ligados aos cursores AQUI porque os 8 cursores locais ja
1271:     * existem neste ponto: o BO eh instanciado no inicio de InicializarForm e

*-- Linhas 1280 a 1318:
1280: 
1281:         WITH loc_oPgf
1282:             .PageCount = 5
1283:             .Top       = 186
1284:             .Left      = 59
1285:             .Width     = 701
1286:             .Height    = 421
1287:             .Tabs      = .T.
1288: 
1289:             .Page1.Caption   = "Saldo"
1290:             .Page1.FontName  = "Tahoma"
1291:             .Page1.FontSize  = 8
1292:             .Page1.BackColor = RGB(255, 255, 255)
1293:             .Page1.ForeColor = RGB(90, 90, 90)
1294: 
1295:             .Page2.Caption   = "Pend" + CHR(234) + "ncias"
1296:             .Page2.FontName  = "Tahoma"
1297:             .Page2.FontSize  = 8
1298:             .Page2.BackColor = RGB(255, 255, 255)
1299:             .Page2.ForeColor = RGB(90, 90, 90)
1300: 
1301:             .Page3.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1302:             .Page3.FontName  = "Tahoma"
1303:             .Page3.FontSize  = 8
1304:             .Page3.BackColor = RGB(255, 255, 255)
1305:             .Page3.ForeColor = RGB(90, 90, 90)
1306: 
1307:             .Page4.Caption   = "Estoque"
1308:             .Page4.FontName  = "Tahoma"
1309:             .Page4.FontSize  = 8
1310:             .Page4.BackColor = RGB(255, 255, 255)
1311:             .Page4.ForeColor = RGB(90, 90, 90)
1312: 
1313:             .Page5.Caption   = "Consertos"
1314:             .Page5.FontName  = "Tahoma"
1315:             .Page5.FontSize  = 8
1316:             .Page5.BackColor = RGB(255, 255, 255)
1317:             .Page5.ForeColor = RGB(90, 90, 90)
1318:         ENDWITH

*-- Linhas 1362 a 1480:
1362:         *-- shp_historico / shp_saldo / Shape1 - molduras do legado
1363:         par_oPage.AddObject("shp_4c_MoldHistorico", "Shape")
1364:         WITH par_oPage.shp_4c_MoldHistorico
1365:             .Top           = 21
1366:             .Left          = 9
1367:             .Width         = 664
1368:             .Height        = 233
1369:             .BackStyle     = 0
1370:             .SpecialEffect = 1
1371:         ENDWITH
1372: 
1373:         par_oPage.AddObject("shp_4c_MoldSaldo", "Shape")
1374:         WITH par_oPage.shp_4c_MoldSaldo
1375:             .Top           = 267
1376:             .Left          = 9
1377:             .Width         = 165
1378:             .Height        = 125
1379:             .BackStyle     = 0
1380:             .SpecialEffect = 1
1381:         ENDWITH
1382: 
1383:         par_oPage.AddObject("shp_4c_MoldHists", "Shape")
1384:         WITH par_oPage.shp_4c_MoldHists
1385:             .Top           = 267
1386:             .Left          = 182
1387:             .Width         = 411
1388:             .Height        = 59
1389:             .BackStyle     = 0
1390:             .SpecialEffect = 1
1391:         ENDWITH
1392: 
1393:         *-- Labels (AutoSize = .F. + Width/Height explicitos: AutoSize eh
1394:         *-- no-op em Label criado por AddObject)
1395:         par_oPage.AddObject("lbl_4c_TitHistorico", "Label")
1396:         WITH par_oPage.lbl_4c_TitHistorico
1397:             .Top        = 6
1398:             .Left       = 14
1399:             .Width      = 141
1400:             .Height     = 15
1401:             .AutoSize   = .F.
1402:             .FontName   = "Tahoma"
1403:             .FontSize   = 8
1404:             .FontBold   = .T.
1405:             .FontItalic = .T.
1406:             .BackStyle  = 0
1407:             .Alignment  = 0
1408:             .ForeColor  = RGB(90, 90, 90)
1409:             .Caption    = "Hist" + CHR(243) + "rico Conta Corrente"
1410:         ENDWITH
1411: 
1412:         par_oPage.AddObject("lbl_4c_TitSaldo", "Label")
1413:         WITH par_oPage.lbl_4c_TitSaldo
1414:             .Top        = 254
1415:             .Left       = 13
1416:             .Width      = 96
1417:             .Height     = 15
1418:             .AutoSize   = .F.
1419:             .FontName   = "Tahoma"
1420:             .FontSize   = 8
1421:             .FontBold   = .T.
1422:             .FontItalic = .T.
1423:             .BackStyle  = 0
1424:             .Alignment  = 0
1425:             .ForeColor  = RGB(90, 90, 90)
1426:             .Caption    = "Saldo por Moeda"
1427:         ENDWITH
1428: 
1429:         par_oPage.AddObject("lbl_4c_TitHists", "Label")
1430:         WITH par_oPage.lbl_4c_TitHists
1431:             .Top        = 254
1432:             .Left       = 192
1433:             .Width      = 52
1434:             .Height     = 15
1435:             .AutoSize   = .F.
1436:             .FontName   = "Tahoma"
1437:             .FontSize   = 8
1438:             .FontBold   = .T.
1439:             .FontItalic = .T.
1440:             .BackStyle  = 0
1441:             .Alignment  = 0
1442:             .ForeColor  = RGB(90, 90, 90)
1443:             .Caption    = "Hist" + CHR(243) + "rico"
1444:         ENDWITH
1445: 
1446:         *-- Grades. A configuracao das COLUNAS fica em
1447:         *-- ConfigurarGradesSaldo(), porque o legado a refaz a cada clique em
1448:         *-- Movimentacao (o numero de colunas depende da permissao de SALDO).
1449:         par_oPage.AddObject("grd_4c_Historico", "Grid")
1450:         WITH par_oPage.grd_4c_Historico
1451:             .Top    = 27
1452:             .Left   = 14
1453:             .Width  = 653
1454:             .Height = 220
1455:             .RecordMark   = .F.
1456:             .DeleteMark   = .F.
1457:         ENDWITH
1458: 
1459:         par_oPage.AddObject("grd_4c_Saldo", "Grid")
1460:         WITH par_oPage.grd_4c_Saldo
1461:             .Top    = 274
1462:             .Left   = 14
1463:             .Width  = 156
1464:             .Height = 112
1465:             .RecordMark   = .F.
1466:             .DeleteMark   = .F.
1467:         ENDWITH
1468: 
1469:         *-- Get_Hists / Get_Hist2s: exibem o historico da linha corrente da
1470:         *-- grade. ReadOnly porque o When do legado devolve .F. (o campo
1471:         *-- nunca recebe foco).
1472:         par_oPage.AddObject("txt_4c_Hists", "TextBox")
1473:         WITH par_oPage.txt_4c_Hists
1474:             .Top           = 276
1475:             .Left          = 187
1476:             .Width         = 401
1477:             .Height        = 23
1478:             .FontName      = "Tahoma"
1479:             .FontSize      = 8
1480:             .ReadOnly      = .T.

*-- Linhas 1486 a 1495:
1486: 
1487:         par_oPage.AddObject("txt_4c_Hist2s", "TextBox")
1488:         WITH par_oPage.txt_4c_Hist2s
1489:             .Top           = 299
1490:             .Left          = 187
1491:             .Width         = 401
1492:             .Height        = 23
1493:             .FontName      = "Tahoma"
1494:             .FontSize      = 8
1495:             .ReadOnly      = .T.

*-- Linhas 1501 a 1526:
1501: 
1502:         *-- btnImprimir: abre o relatorio SigReCgc do fornecedor (legado:
1503:         *-- "Do Form SigReCgc With Get_Grupo.Value, Get_Conta.Value")
1504:         par_oPage.AddObject("cmd_4c_ImprimirExtrato", "CommandButton")
1505:         WITH par_oPage.cmd_4c_ImprimirExtrato
1506:             .Top             = 277
1507:             .Left            = 618
1508:             .Width           = 40
1509:             .Height          = 40
1510:             .FontName        = "Verdana"
1511:             .FontSize        = 8
1512:             .WordWrap        = .T.
1513:             .Caption         = ""
1514:             .ToolTipText     = "Imprimir"
1515:             .ForeColor       = RGB(36, 84, 155)
1516:             .BackColor       = RGB(255, 255, 255)
1517:             .Themes          = .T.
1518:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1519:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1520:         ENDWITH
1521:         BINDEVENT(par_oPage.cmd_4c_ImprimirExtrato, "Click", THIS, "BtnImprimirExtratoClick")
1522: 
1523:         BINDEVENT(par_oPage.grd_4c_Saldo, "AfterRowColChange", THIS, "GradeSaldoAfterRowColChange")
1524:         BINDEVENT(par_oPage.grd_4c_Historico, "AfterRowColChange", THIS, "GradeHistoricoAfterRowColChange")
1525: 
1526:         THIS.ConfigurarGradesSaldo()

*-- Linhas 1623 a 1631:
1623: 
1624:         *-- moldura e titulo acompanham o numero de colunas (legado)
1625:         loc_oPage.shp_4c_MoldSaldo.Width = IIF(loc_lSaldo, 165, 165 - 94)
1626:         loc_oPage.lbl_4c_TitSaldo.Caption = IIF(loc_lSaldo, "Saldo por Moeda", "Moedas")
1627:     ENDPROC
1628: 
1629:     *==========================================================================
1630:     * ConfigurarColunaResultado - aplica de uma vez as propriedades que toda
1631:     * coluna de grade de resultado recebe. A Width eh atribuida DEPOIS do

*-- Linhas 1650 a 1658:
1650:                 .InputMask = par_cMask
1651:             ENDIF
1652: 
1653:             .Header1.Caption   = par_cCaption
1654:             .Header1.Alignment = par_nAlinhaHeader
1655:             .Header1.FontName  = "Tahoma"
1656:             .Header1.FontSize  = 8
1657:             .Header1.ForeColor = RGB(90, 90, 90)
1658: 

*-- Linhas 1676 a 1715:
1676: 
1677:         par_oPage.AddObject("shp_4c_MoldPendencias", "Shape")
1678:         WITH par_oPage.shp_4c_MoldPendencias
1679:             .Top           = 17
1680:             .Left          = 9
1681:             .Width         = 663
1682:             .Height        = 199
1683:             .BackStyle     = 0
1684:             .SpecialEffect = 1
1685:         ENDWITH
1686: 
1687:         par_oPage.AddObject("lbl_4c_TitPendencias", "Label")
1688:         WITH par_oPage.lbl_4c_TitPendencias
1689:             .Top        = 3
1690:             .Left       = 20
1691:             .Width      = 66
1692:             .Height     = 15
1693:             .AutoSize   = .F.
1694:             .FontName   = "Tahoma"
1695:             .FontSize   = 8
1696:             .FontBold   = .T.
1697:             .FontItalic = .T.
1698:             .BackStyle  = 0
1699:             .Alignment  = 0
1700:             .ForeColor  = RGB(90, 90, 90)
1701:             .Caption    = "Pend" + CHR(234) + "ncias"
1702:         ENDWITH
1703: 
1704:         par_oPage.AddObject("grd_4c_Pendente", "Grid")
1705:         loc_oGrd = par_oPage.grd_4c_Pendente
1706:         loc_oGrd.ColumnCount  = 4
1707:         loc_oGrd.RecordSource = "cursor_4c_Parcela"
1708:         WITH loc_oGrd
1709:             .Top               = 23
1710:             .Left              = 14
1711:             .Width             = 652
1712:             .Height            = 184
1713:             .AllowHeaderSizing = .F.
1714:             .AllowRowSizing    = .F.
1715:             THIS.FormatarGradeResultado(loc_oGrd)

*-- Linhas 1735 a 1744:
1735:         loc_oGrd.ColumnCount  = 5
1736:         loc_oGrd.RecordSource = "cursor_4c_Parcela"
1737:         WITH loc_oGrd
1738:             .Top               = 222
1739:             .Left              = 5
1740:             .Width             = 557
1741:             .Height            = 166
1742:             .AllowHeaderSizing = .F.
1743:             .AllowRowSizing    = .F.
1744:             THIS.FormatarGradeResultado(loc_oGrd)

*-- Linhas 1772 a 1804:
1772:     PROTECTED PROCEDURE ConfigurarAbaMovimentacao(par_oPage)
1773:         LOCAL loc_oGrd
1774: 
1775:         par_oPage.AddObject("lbl_4c_TitProdutos", "Label")
1776:         WITH par_oPage.lbl_4c_TitProdutos
1777:             .Top        = 30
1778:             .Left       = 3
1779:             .Width      = 59
1780:             .Height     = 15
1781:             .AutoSize   = .F.
1782:             .FontName   = "Tahoma"
1783:             .FontSize   = 8
1784:             .FontBold   = .T.
1785:             .FontItalic = .T.
1786:             .BackStyle  = 0
1787:             .Alignment  = 0
1788:             .ForeColor  = RGB(90, 90, 90)
1789:             .Caption    = " Produtos "
1790:         ENDWITH
1791: 
1792:         *-- Grd_Produto: 10 colunas, ColumnOrder do legado
1793:         par_oPage.AddObject("grd_4c_Produto", "Grid")
1794:         loc_oGrd = par_oPage.grd_4c_Produto
1795:         loc_oGrd.ColumnCount  = 10
1796:         loc_oGrd.RecordSource = "cursor_4c_ProdFor"
1797:         WITH loc_oGrd
1798:             .Top          = 44
1799:             .Left         = 2
1800:             .Width        = 690
1801:             .Height       = 106
1802:             THIS.FormatarGradeResultado(loc_oGrd)
1803:             .RowHeight    = 17
1804:             .Highlight    = .T.

*-- Linhas 1854 a 1899:
1854:         *-- shp_produto / lbl_produto + Grd_Resumo (total por operacao)
1855:         par_oPage.AddObject("shp_4c_MoldResumo", "Shape")
1856:         WITH par_oPage.shp_4c_MoldResumo
1857:             .Top           = 173
1858:             .Left          = 10
1859:             .Width         = 329
1860:             .Height        = 127
1861:             .BackStyle     = 0
1862:             .SpecialEffect = 1
1863:             .BorderColor   = RGB(136, 188, 189)
1864:         ENDWITH
1865: 
1866:         par_oPage.AddObject("lbl_4c_TitResumo", "Label")
1867:         WITH par_oPage.lbl_4c_TitResumo
1868:             .Top        = 160
1869:             .Left       = 11
1870:             .Width      = 116
1871:             .Height     = 15
1872:             .AutoSize   = .F.
1873:             .FontName   = "Tahoma"
1874:             .FontSize   = 8
1875:             .FontBold   = .T.
1876:             .FontItalic = .T.
1877:             .BackStyle  = 0
1878:             .Alignment  = 0
1879:             .ForeColor  = RGB(90, 90, 90)
1880:             .Caption    = " Total por Opera" + CHR(231) + CHR(227) + "o "
1881:         ENDWITH
1882: 
1883:         *-- No SCX as Columns de grd_resumo ficaram com ControlSource VAZIO e
1884:         *-- os Text1 internos apontando para um alias "dbproduto" que nao
1885:         *-- existe neste form (residuo de copia de outra grade). As ligacoes
1886:         *-- abaixo vem dos captions dos headers e da estrutura de dbResumo -
1887:         *-- deixar o ControlSource vazio exibiria a grade em branco.
1888:         par_oPage.AddObject("grd_4c_Resumo", "Grid")
1889:         loc_oGrd = par_oPage.grd_4c_Resumo
1890:         loc_oGrd.ColumnCount  = 3
1891:         loc_oGrd.RecordSource = "cursor_4c_Resumo"
1892:         WITH loc_oGrd
1893:             .Top          = 180
1894:             .Left         = 14
1895:             .Width        = 320
1896:             .Height       = 113
1897:             THIS.FormatarGradeResultado(loc_oGrd)
1898:             .Highlight    = .T.
1899:             .HighlightRow = .T.

*-- Linhas 1915 a 1938:
1915:         *-- Shape2 + Grd_OperaProd (operacoes do produto selecionado)
1916:         par_oPage.AddObject("shp_4c_MoldOperaProd", "Shape")
1917:         WITH par_oPage.shp_4c_MoldOperaProd
1918:             .Top           = 152
1919:             .Left          = 337
1920:             .Width         = 332
1921:             .Height        = 93
1922:             .BackStyle     = 0
1923:             .SpecialEffect = 1
1924:             .BorderColor   = RGB(136, 188, 189)
1925:         ENDWITH
1926: 
1927:         par_oPage.AddObject("grd_4c_OperaProd", "Grid")
1928:         loc_oGrd = par_oPage.grd_4c_OperaProd
1929:         loc_oGrd.ColumnCount  = 3
1930:         loc_oGrd.RecordSource = "cursor_4c_OperaProd"
1931:         WITH loc_oGrd
1932:             .Top            = 154
1933:             .Left           = 340
1934:             .Width          = 324
1935:             .Height         = 88
1936:             THIS.FormatarGradeResultado(loc_oGrd)
1937:             .RowHeight      = 17
1938:             .Highlight      = .T.

*-- Linhas 1957 a 2052:
1957: 
1958:         *-- Mensagem1 / Mensagem2: aparecem quando a Analise de Vendas NAO foi
1959:         *-- pedida (Opt_Analise = 2), no lugar das duas grades de totais
1960:         par_oPage.AddObject("lbl_4c_Mensagem1", "Label")
1961:         WITH par_oPage.lbl_4c_Mensagem1
1962:             .Top       = 195
1963:             .Left      = 370
1964:             .Width     = 269
1965:             .Height    = 17
1966:             .AutoSize  = .F.
1967:             .BackStyle = 0
1968:             .ForeColor = RGB(255, 0, 0)
1969:             .Caption   = "N" + CHR(227) + "o foi executada a An" + CHR(225) + ;
1970:                          "lise de Vendas..."
1971:         ENDWITH
1972: 
1973:         par_oPage.AddObject("lbl_4c_Mensagem2", "Label")
1974:         WITH par_oPage.lbl_4c_Mensagem2
1975:             .Top       = 230
1976:             .Left      = 32
1977:             .Width     = 230
1978:             .Height    = 17
1979:             .AutoSize  = .F.
1980:             .BackStyle = 0
1981:             .ForeColor = RGB(255, 0, 0)
1982:             .Caption   = "N" + CHR(227) + "o foi executada a An" + CHR(225) + ;
1983:                          "lise de Vendas..."
1984:         ENDWITH
1985: 
1986:         *-- Imprimir: abre o painel ImprimeOpcoes
1987:         par_oPage.AddObject("cmd_4c_ImprimirMov", "CommandButton")
1988:         WITH par_oPage.cmd_4c_ImprimirMov
1989:             .Top             = 255
1990:             .Left            = 342
1991:             .Width           = 40
1992:             .Height          = 40
1993:             .FontName        = "Verdana"
1994:             .FontSize        = 8
1995:             .WordWrap        = .T.
1996:             .Caption         = ""
1997:             .ToolTipText     = "Imprimir"
1998:             .ForeColor       = RGB(36, 84, 155)
1999:             .BackColor       = RGB(255, 255, 255)
2000:             .Themes          = .T.
2001:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2002:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2003:         ENDWITH
2004:         BINDEVENT(par_oPage.cmd_4c_ImprimirMov, "Click", THIS, "BtnImprimirMovClick")
2005: 
2006:         *-- OptSituas: filtro de situacao da grade de produtos
2007:         par_oPage.AddObject("obj_4c_OptSituas", "OptionGroup")
2008:         WITH par_oPage.obj_4c_OptSituas
2009:             .ButtonCount   = 3
2010:             .Top           = 9
2011:             .Left          = 434
2012:             .Width         = 197
2013:             .Height        = 26
2014:             .BackStyle     = 0
2015:             .SpecialEffect = 1
2016:             .Value         = 3
2017: 
2018:             WITH .Buttons(1)
2019:                 .Caption   = "Ativo"
2020:                 .Top       = 5
2021:                 .Left      = 9
2022:                 .Width     = 43
2023:                 .Height    = 15
2024:                 .AutoSize  = .F.
2025:                 .BackStyle = 0
2026:                 .FontName  = "Tahoma"
2027:                 .FontSize  = 8
2028:                 .ForeColor = RGB(90, 90, 90)
2029:             ENDWITH
2030: 
2031:             WITH .Buttons(2)
2032:                 .Caption   = "Inativo"
2033:                 .Top       = 5
2034:                 .Left      = 66
2035:                 .Width     = 52
2036:                 .Height    = 15
2037:                 .AutoSize  = .F.
2038:                 .BackStyle = 0
2039:                 .FontName  = "Tahoma"
2040:                 .FontSize  = 8
2041:                 .ForeColor = RGB(90, 90, 90)
2042:             ENDWITH
2043: 
2044:             WITH .Buttons(3)
2045:                 .Caption   = "Ambos"
2046:                 .Top       = 5
2047:                 .Left      = 130
2048:                 .Width     = 50
2049:                 .Height    = 15
2050:                 .AutoSize  = .F.
2051:                 .BackStyle = 0
2052:                 .FontName  = "Tahoma"

*-- Linhas 2070 a 2109:
2070: 
2071:         par_oPage.AddObject("shp_4c_MoldEstoque", "Shape")
2072:         WITH par_oPage.shp_4c_MoldEstoque
2073:             .Top           = 27
2074:             .Left          = 13
2075:             .Width         = 239
2076:             .Height        = 360
2077:             .BackStyle     = 0
2078:             .SpecialEffect = 1
2079:         ENDWITH
2080: 
2081:         par_oPage.AddObject("lbl_4c_TitEstoque", "Label")
2082:         WITH par_oPage.lbl_4c_TitEstoque
2083:             .Top        = 13
2084:             .Left       = 22
2085:             .Width      = 133
2086:             .Height     = 15
2087:             .AutoSize   = .F.
2088:             .FontName   = "Tahoma"
2089:             .FontSize   = 8
2090:             .FontBold   = .T.
2091:             .FontItalic = .T.
2092:             .BackStyle  = 0
2093:             .Alignment  = 0
2094:             .ForeColor  = RGB(90, 90, 90)
2095:             .Caption    = "Produtos em seu poder"
2096:         ENDWITH
2097: 
2098:         par_oPage.AddObject("grd_4c_EstoqueProd", "Grid")
2099:         loc_oGrd = par_oPage.grd_4c_EstoqueProd
2100:         loc_oGrd.ColumnCount  = 2
2101:         loc_oGrd.RecordSource = "cursor_4c_Estoque"
2102:         WITH loc_oGrd
2103:             .Top          = 34
2104:             .Left         = 18
2105:             .Width        = 229
2106:             .Height       = 346
2107:             THIS.FormatarGradeResultado(loc_oGrd)
2108:             .Highlight    = .T.
2109:             .HighlightRow = .T.

*-- Linhas 2122 a 2160:
2122: 
2123:         par_oPage.AddObject("shp_4c_MoldFoto", "Shape")
2124:         WITH par_oPage.shp_4c_MoldFoto
2125:             .Top           = 27
2126:             .Left          = 251
2127:             .Width         = 181
2128:             .Height        = 138
2129:             .BackStyle     = 0
2130:             .SpecialEffect = 1
2131:         ENDWITH
2132: 
2133:         par_oPage.AddObject("img_4c_FotoProduto", "Image")
2134:         WITH par_oPage.img_4c_FotoProduto
2135:             .Top     = 32
2136:             .Left    = 255
2137:             .Width   = 172
2138:             .Height  = 129
2139:             .Stretch = 1
2140:             .Enabled = .F.
2141:             .Visible = .F.
2142:         ENDWITH
2143: 
2144:         par_oPage.AddObject("lbl_4c_MsgFotoProduto", "Label")
2145:         WITH par_oPage.lbl_4c_MsgFotoProduto
2146:             .Top       = 90
2147:             .Left      = 260
2148:             .Width     = 109
2149:             .Height    = 16
2150:             .AutoSize  = .F.
2151:             .FontBold  = .T.
2152:             .FontSize  = 8
2153:             .BackStyle = 0
2154:             .ForeColor = RGB(90, 90, 90)
2155:             .Caption   = "Foto n" + CHR(227) + "o dispon" + CHR(237) + "vel"
2156:             .Visible   = .F.
2157:         ENDWITH
2158:     ENDPROC
2159: 
2160:     *==========================================================================

*-- Linhas 2166 a 2205:
2166: 
2167:         par_oPage.AddObject("shp_4c_MoldConserto", "Shape")
2168:         WITH par_oPage.shp_4c_MoldConserto
2169:             .Top           = 27
2170:             .Left          = 7
2171:             .Width         = 663
2172:             .Height        = 289
2173:             .BackStyle     = 0
2174:             .SpecialEffect = 1
2175:         ENDWITH
2176: 
2177:         par_oPage.AddObject("lbl_4c_TitConserto", "Label")
2178:         WITH par_oPage.lbl_4c_TitConserto
2179:             .Top        = 12
2180:             .Left       = 17
2181:             .Width      = 122
2182:             .Height     = 15
2183:             .AutoSize   = .F.
2184:             .FontName   = "Tahoma"
2185:             .FontSize   = 8
2186:             .FontBold   = .T.
2187:             .FontItalic = .T.
2188:             .BackStyle  = 0
2189:             .Alignment  = 0
2190:             .ForeColor  = RGB(90, 90, 90)
2191:             .Caption    = "Consertos Pendentes"
2192:         ENDWITH
2193: 
2194:         par_oPage.AddObject("grd_4c_Conserto", "Grid")
2195:         loc_oGrd = par_oPage.grd_4c_Conserto
2196:         loc_oGrd.ColumnCount  = 4
2197:         loc_oGrd.RecordSource = "cursor_4c_Conserto"
2198:         WITH loc_oGrd
2199:             .Top          = 37
2200:             .Left         = 11
2201:             .Width        = 654
2202:             .Height       = 275
2203:             THIS.FormatarGradeResultado(loc_oGrd)
2204:             .Highlight    = .T.
2205:             .HighlightRow = .T.

*-- Linhas 2238 a 2355:
2238:         par_oPag.AddObject("cnt_4c_ImprimeOpcoes", "Container")
2239:         loc_oCnt = par_oPag.cnt_4c_ImprimeOpcoes
2240:         WITH loc_oCnt
2241:             .Top           = 270
2242:             .Left          = 263
2243:             .Width         = 291
2244:             .Height        = 127
2245:             .BackStyle     = 1
2246:             .BackColor     = RGB(255, 255, 255)
2247:             .SpecialEffect = 0
2248:             .BorderWidth   = 1
2249:         ENDWITH
2250: 
2251:         loc_oCnt.AddObject("cmd_4c_VisualizarOpc", "CommandButton")
2252:         WITH loc_oCnt.cmd_4c_VisualizarOpc
2253:             .Top             = 8
2254:             .Left            = 164
2255:             .Width           = 40
2256:             .Height          = 40
2257:             .FontName        = "Verdana"
2258:             .FontSize        = 8
2259:             .WordWrap        = .T.
2260:             .Caption         = ""
2261:             .ToolTipText     = "Visualizar"
2262:             .ForeColor       = RGB(36, 84, 155)
2263:             .BackColor       = RGB(255, 255, 255)
2264:             .Themes          = .T.
2265:             .Picture         = gc_4c_CaminhoIcones + "kghostview.ico"
2266:             .DisabledPicture = gc_4c_CaminhoIcones + "kghostview.ico"
2267:         ENDWITH
2268:         BINDEVENT(loc_oCnt.cmd_4c_VisualizarOpc, "Click", THIS, "BtnVisualizarOpcoesClick")
2269: 
2270:         loc_oCnt.AddObject("cmd_4c_ImprimirOpc", "CommandButton")
2271:         WITH loc_oCnt.cmd_4c_ImprimirOpc
2272:             .Top             = 8
2273:             .Left            = 204
2274:             .Width           = 40
2275:             .Height          = 40
2276:             .FontName        = "Verdana"
2277:             .FontSize        = 8
2278:             .WordWrap        = .T.
2279:             .Caption         = ""
2280:             .ToolTipText     = "Imprimir"
2281:             .ForeColor       = RGB(36, 84, 155)
2282:             .BackColor       = RGB(255, 255, 255)
2283:             .Themes          = .T.
2284:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2285:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2286:         ENDWITH
2287:         BINDEVENT(loc_oCnt.cmd_4c_ImprimirOpc, "Click", THIS, "BtnImprimirOpcoesClick")
2288: 
2289:         loc_oCnt.AddObject("cmd_4c_SairOpc", "CommandButton")
2290:         WITH loc_oCnt.cmd_4c_SairOpc
2291:             .Top             = 8
2292:             .Left            = 244
2293:             .Width           = 40
2294:             .Height          = 40
2295:             .FontName        = "Verdana"
2296:             .FontSize        = 8
2297:             .WordWrap        = .T.
2298:             .Caption         = ""
2299:             .Cancel          = .T.
2300:             .ToolTipText     = "Sair"
2301:             .ForeColor       = RGB(36, 84, 155)
2302:             .BackColor       = RGB(255, 255, 255)
2303:             .Themes          = .T.
2304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2305:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
2306:         ENDWITH
2307:         BINDEVENT(loc_oCnt.cmd_4c_SairOpc, "Click", THIS, "BtnSairOpcoesClick")
2308: 
2309:         loc_oCnt.AddObject("obj_4c_Opcao", "OptionGroup")
2310:         WITH loc_oCnt.obj_4c_Opcao
2311:             .ButtonCount   = 3
2312:             .Top           = 53
2313:             .Left          = 49
2314:             .Width         = 191
2315:             .Height        = 64
2316:             .BackStyle     = 0
2317:             .BorderStyle   = 1
2318:             .SpecialEffect = 1
2319:             .Value         = 1
2320: 
2321:             WITH .Buttons(1)
2322:                 .Caption   = "Produto Selecionado"
2323:                 .Top       = 5
2324:                 .Left      = 5
2325:                 .Width     = 116
2326:                 .Height    = 15
2327:                 .AutoSize  = .F.
2328:                 .BackStyle = 0
2329:                 .FontName  = "Tahoma"
2330:                 .FontSize  = 8
2331:                 .ForeColor = RGB(90, 90, 90)
2332:             ENDWITH
2333: 
2334:             WITH .Buttons(2)
2335:                 .Caption   = "Todos os Produtos"
2336:                 .Top       = 24
2337:                 .Left      = 5
2338:                 .Width     = 107
2339:                 .Height    = 15
2340:                 .AutoSize  = .F.
2341:                 .BackStyle = 0
2342:                 .FontName  = "Tahoma"
2343:                 .FontSize  = 8
2344:                 .ForeColor = RGB(90, 90, 90)
2345:             ENDWITH
2346: 
2347:             WITH .Buttons(3)
2348:                 .Caption   = "Todos com Movimenta" + CHR(231) + CHR(227) + "o"
2349:                 .Top       = 43
2350:                 .Left      = 5
2351:                 .Width     = 141
2352:                 .Height    = 15
2353:                 .AutoSize  = .F.
2354:                 .BackStyle = 0
2355:                 .FontName  = "Tahoma"

*-- Linhas 2588 a 2608:
2588:             *-- grades de totais x mensagens (legado: If lnAnalise = 1)
2589:             loc_oMov.grd_4c_Resumo.Visible    = loc_lAnalise
2590:             loc_oMov.grd_4c_OperaProd.Visible = loc_lAnalise
2591:             loc_oMov.lbl_4c_Mensagem1.Visible = !loc_lAnalise
2592:             loc_oMov.lbl_4c_Mensagem2.Visible = !loc_lAnalise
2593: 
2594:             *-- _TitMoeda do legado: a moeda do filtro entra entre parenteses
2595:             *-- no caption das tres colunas de valor
2596:             loc_cTitMoeda = ""
2597:             IF !EMPTY(ALLTRIM(loc_oPag1.txt_4c_Moeda.Value))
2598:                 loc_cTitMoeda = "(" + ALLTRIM(loc_oPag1.txt_4c_Moeda.Value) + ")"
2599:             ENDIF
2600: 
2601:             loc_oMov.grd_4c_Produto.Column6.Header1.Caption   = "Total Vendas" + loc_cTitMoeda
2602:             loc_oMov.grd_4c_OperaProd.Column2.Header1.Caption = "Valor Total" + loc_cTitMoeda
2603:             loc_oMov.grd_4c_Resumo.Column2.Header1.Caption    = "Valor Total" + loc_cTitMoeda
2604: 
2605:             THIS.AtualizarFotoFornecedor()
2606:             THIS.AtualizarGrades()
2607: 
2608:             loc_oRes.ActivePage = 1

*-- Linhas 2719 a 2742:
2719:             loc_oCad.shp_4c_Figura.Visible  = .F.
2720:             loc_oCad.img_4c_Figura.Visible  = .F.
2721:             loc_oCad.img_4c_Figura.Picture  = ""
2722:             loc_oCad.lbl_4c_MsgFoto.Visible = .F.
2723:             RETURN
2724:         ENDIF
2725: 
2726:         loc_oCad.shp_4c_Figura.Visible = .T.
2727:         loc_cArquivo = THIS.this_oBusinessObject.ObterArquivoFotoFornecedor()
2728: 
2729:         IF EMPTY(loc_cArquivo)
2730:             loc_oCad.img_4c_Figura.Visible  = .F.
2731:             loc_oCad.img_4c_Figura.Picture  = ""
2732:             loc_oCad.lbl_4c_MsgFoto.Visible = .T.
2733:         ELSE
2734:             CLEAR RESOURCES
2735:             loc_oCad.img_4c_Figura.Picture  = loc_cArquivo
2736:             loc_oCad.img_4c_Figura.Visible  = .T.
2737:             loc_oCad.lbl_4c_MsgFoto.Visible = .F.
2738:         ENDIF
2739:     ENDPROC
2740: 
2741:     *==========================================================================
2742:     * BtnCadastroClick - botao "Dados Cadastrais" do grp_operacao (Page1).

*-- Linhas 2912 a 2925:
2912:             IF EMPTY(loc_cArquivo)
2913:                 loc_oPage.img_4c_FotoProduto.Visible    = .F.
2914:                 loc_oPage.img_4c_FotoProduto.Picture    = ""
2915:                 loc_oPage.lbl_4c_MsgFotoProduto.Visible = .T.
2916:             ELSE
2917:                 CLEAR RESOURCES
2918:                 loc_oPage.img_4c_FotoProduto.Picture    = loc_cArquivo
2919:                 loc_oPage.img_4c_FotoProduto.Visible    = .T.
2920:                 loc_oPage.lbl_4c_MsgFotoProduto.Visible = .F.
2921:             ENDIF
2922:         CATCH TO loc_oErro
2923:             MsgErro(loc_oErro.Message + CHR(13) + ;
2924:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao carregar a foto")
2925:         ENDTRY

*-- Linhas 3164 a 3193:
3164:             *-- Buttons(3) = cmd_cadastro no legado
3165:             loc_oGrupo.Buttons(3).Visible = .F.
3166:             loc_oGrupo.Buttons(3).Enabled = .F.
3167:             loc_oGrupo.Buttons(1).Left    = loc_oGrupo.Buttons(1).Left - 81
3168:             loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
3169:             loc_oGrupo.Width              = loc_oGrupo.Width - 81
3170:             loc_oGrupo.Left               = loc_oGrupo.Left  + 81
3171:         ENDIF
3172: 
3173:         IF !fChecaAcesso("SIGOPCGC", "MOVIMENTA")
3174:             loc_oPag2.cmg_4c_MudaMov.Visible = .F.
3175:             loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
3176:             loc_oPag2.cmg_4c_MudaFor.Visible = .F.
3177:             loc_oPag2.cmg_4c_MudaFor.Enabled = .F.
3178: 
3179:             *-- Buttons(1) = cmd_movimenta no legado
3180:             loc_oGrupo.Buttons(1).Visible = .F.
3181:             loc_oGrupo.Buttons(1).Enabled = .F.
3182:             loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
3183:             loc_oGrupo.Width              = loc_oGrupo.Width - 81
3184:             loc_oGrupo.Left               = loc_oGrupo.Left  + 81
3185:         ENDIF
3186: 
3187:         IF !fChecaAcesso("SIGOPCGC", "IMPRIMIR")
3188:             loc_oPag2.pgf_4c_Result.Page1.cmd_4c_ImprimirExtrato.Visible = .F.
3189:         ENDIF
3190:     ENDPROC
3191: 
3192:     *==========================================================================
3193:     * OptAnaliseChange - InteractiveChange de obj_4c_Opt_Analise (Page1).

*-- Linhas 3326 a 3335:
3326:                 IF VARTYPE(loc_oBusca) = "O"
3327:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeda"
3328:                     loc_oBusca.this_cTitulo        = "Moedas"
3329:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Moedas"
3330:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Moedas"
3331:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3332:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3333:                     loc_oBusca.Show()
3334:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3335:                         SELECT cursor_4c_BuscaMoeda

*-- Linhas 3441 a 3450:
3441:                 IF VARTYPE(loc_oBusca) = "O"
3442:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
3443:                     loc_oBusca.this_cTitulo        = loc_cTitulo
3444:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
3445:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
3446:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
3447:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
3448:                     loc_oBusca.Show()
3449:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
3450:                         SELECT cursor_4c_BuscaEmp

*-- Linhas 3508 a 3526:
3508:                     "cursor_4c_GrpVal")
3509:                 IF loc_nResult > 0 AND USED("cursor_4c_GrpVal") AND !EOF("cursor_4c_GrpVal")
3510:                     IF cursor_4c_GrpVal.tpcads = 1
3511:                         loc_oOrigem.txt_4c_Dconta.Left  = 326
3512:                         loc_oOrigem.txt_4c_Dconta.Width = 278
3513:                         loc_oOrigem.lbl_4c__dConta.Left = 329
3514:                         loc_oOrigem.txt_4c_Cpf.Visible   = .T.
3515:                         loc_oOrigem.lbl_4c__CPF.Visible  = .T.
3516:                     ELSE
3517:                         loc_oOrigem.txt_4c_Dconta.Left  = 177
3518:                         loc_oOrigem.txt_4c_Dconta.Width = 427
3519:                         loc_oOrigem.lbl_4c__dConta.Left = 180
3520:                         loc_oOrigem.txt_4c_Cpf.Visible   = .F.
3521:                         loc_oOrigem.lbl_4c__CPF.Visible  = .F.
3522:                     ENDIF
3523:                 ENDIF
3524:                 IF USED("cursor_4c_GrpVal")
3525:                     USE IN cursor_4c_GrpVal
3526:                 ENDIF

*-- Linhas 3743 a 3762:
3743:         loc_oCad = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cadastro
3744: 
3745:         WITH THIS.this_oBusinessObject
3746:             loc_oCad.txt_4c_CodFor.Value = .this_cCodFor
3747:             loc_oCad.txt_4c_Nome.Value   = .this_cNome
3748:             loc_oCad.txt_4c_End.Value    = .this_cEnd
3749:             loc_oCad.txt_4c_Bairro.Value = .this_cBairro
3750:             loc_oCad.txt_4c_Cep.Value    = .this_cCep
3751:             loc_oCad.txt_4c_Cid.Value    = .this_cCid
3752:             loc_oCad.txt_4c_Est.Value    = .this_cEst
3753:             loc_oCad.txt_4c_Tel1.Value   = .this_cTel1
3754:             loc_oCad.txt_4c_Tel2.Value   = .this_cTel2
3755:             loc_oCad.txt_4c_Fax.Value    = .this_cFax
3756:             loc_oCad.txt_4c_Cgc.Value    = .this_cCgc
3757:             loc_oCad.txt_4c_Ie.Value     = .this_cIe
3758:         ENDWITH
3759:     ENDPROC
3760: 
3761:     *==========================================================================
3762:     * TornarControlesVisiveis - Torna visiveis os controles criados via

*-- Linhas 3788 a 3802:
3788:             *--   CNT_4C_IMPRIMEOPCOES  - painel de opcoes de impressao
3789:             *--   GRD_4C_PENDENTEOCULTA - Grid1 do legado, nunca exibida
3790:             *--   IMG_4C_FIGURA / IMG_4C_FOTOPRODUTO - so com foto disponivel
3791:             *--   LBL_4C_MSGFOTO / LBL_4C_MSGFOTOPRODUTO - so SEM foto
3792:             *--   LBL_4C_MENSAGEM1 / 2 - so sem Analise de Vendas
3793:             loc_lPularVisible = INLIST(UPPER(loc_oObjeto.Name), ;
3794:                 "CMG_4C_MUDAFOR", "CMG_4C_MUDAMOV", "PGF_4C_RESULT", ;
3795:                 "CNT_4C_IMPRIMEOPCOES", "GRD_4C_PENDENTEOCULTA", ;
3796:                 "IMG_4C_FIGURA", "IMG_4C_FOTOPRODUTO", "LBL_4C_MSGFOTO", ;
3797:                 "LBL_4C_MSGFOTOPRODUTO", "LBL_4C_MENSAGEM1", "LBL_4C_MENSAGEM2")
3798: 
3799:             IF !loc_lPularVisible AND PEMSTATUS(loc_oObjeto, "Visible", 5)
3800:                 loc_oObjeto.Visible = .T.
3801:             ENDIF
3802: 

