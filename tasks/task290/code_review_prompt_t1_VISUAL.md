# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 268: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 291: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1733 linhas total):

*-- Linhas 128 a 136:
128:                                            CHR(227) + "o por Tipo"
129:                         ENDIF
130:                     ENDIF
131:                     THIS.Caption = loc_cCaption
132: 
133:                     *-- Imagem de fundo
134:                     THIS.ConfigurarPageFrame()
135: 
136:                     *-- Calcular visibilidade do chk_pedra (antes de criar controles)

*-- Linhas 145 a 154:
145: 
146:                     *-- Montar estrutura visual do form
147:                     THIS.ConfigurarCabecalho()
148:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
149:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
150:                     THIS.ConfigurarShape()
151:                     THIS.ConfigurarPaginaLista()
152:                     THIS.TornarControlesVisiveis()
153:                     THIS.PopularCamposIniciais()
154:                     THIS.ConfigurarEventos()

*-- Linhas 184 a 249:
184:     PROTECTED PROCEDURE ConfigurarCabecalho()
185:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
186:         WITH THIS.cnt_4c_Cabecalho
187:             .Top         = 0
188:             .Left        = 0
189:             .Width       = THIS.Width
190:             .Height      = 80
191:             .BackStyle   = 1
192:             .BackColor   = RGB(100,100,100)
193:             .BorderWidth = 0
194:             .Visible     = .T.
195: 
196:             .AddObject("lbl_4c_Sombra", "Label")
197:             WITH .lbl_4c_Sombra
198:                 .AutoSize      = .F.
199:                 .FontBold      = .T.
200:                 .FontName      = "Tahoma"
201:                 .FontSize      = 18
202:                 .FontUnderline = .F.
203:                 .WordWrap      = .T.
204:                 .Alignment     = 0
205:                 .BackStyle     = 0
206:                 .Height        = 40
207:                 .Left          = 10
208:                 .Top           = 18
209:                 .Width         = THIS.Width
210:                 .ForeColor     = RGB(0,0,0)
211:                 .Caption       = THIS.Caption
212:                 .Visible       = .T.
213:             ENDWITH
214: 
215:             .AddObject("lbl_4c_Titulo", "Label")
216:             WITH .lbl_4c_Titulo
217:                 .AutoSize      = .F.
218:                 .FontBold      = .T.
219:                 .FontName      = "Tahoma"
220:                 .FontSize      = 18
221:                 .FontUnderline = .F.
222:                 .WordWrap      = .T.
223:                 .Alignment     = 0
224:                 .BackStyle     = 0
225:                 .Height        = 46
226:                 .Left          = 10
227:                 .Top           = 17
228:                 .Width         = THIS.Width
229:                 .ForeColor     = RGB(255,255,255)
230:                 .Caption       = THIS.Caption
231:                 .Visible       = .T.
232:             ENDWITH
233:         ENDWITH
234:     ENDPROC
235: 
236:     *--------------------------------------------------------------------------
237:     * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
238:     * Top=7, Left=486, Height=110, Width=173
239:     *--------------------------------------------------------------------------
240:     PROTECTED PROCEDURE ConfigurarShape()
241:         THIS.AddObject("shp_4c_Shape3", "Shape")
242:         WITH THIS.shp_4c_Shape3
243:             .Top         = 7
244:             .Left        = 486
245:             .Height      = 110
246:             .Width       = 173
247:             .BackStyle   = 0
248:             .BorderStyle = 0
249:             .BorderColor = RGB(90,90,90)

*-- Linhas 257 a 299:
257:     * Cancelar : Top=3, Left=603, 75x75
258:     *--------------------------------------------------------------------------
259:     PROTECTED PROCEDURE ConfigurarBotoes()
260:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
261:         WITH THIS.cmd_4c_Processar
262:             .Top             = 3
263:             .Left            = 528
264:             .Height          = 75
265:             .Width           = 75
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .FontName        = "Comic Sans MS"
269:             .FontSize        = 8
270:             .WordWrap        = .T.
271:             .Caption         = "Processar"
272:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
273:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
274:             .ForeColor       = RGB(90,90,90)
275:             .BackColor       = RGB(255,255,255)
276:             .Themes          = .T.
277:             .PicturePosition = 13
278:             .SpecialEffect   = 0
279:             .MousePointer    = 15
280:             .Visible         = .T.
281:         ENDWITH
282: 
283:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
284:         WITH THIS.cmd_4c_Cancelar
285:             .Top             = 3
286:             .Left            = 603
287:             .Height          = 75
288:             .Width           = 75
289:             .FontBold        = .T.
290:             .FontItalic      = .T.
291:             .FontName        = "Comic Sans MS"
292:             .FontSize        = 8
293:             .WordWrap        = .T.
294:             .Caption         = "Encerrar"
295:             .Cancel          = .T.
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .ForeColor       = RGB(90,90,90)
299:             .BackColor       = RGB(255,255,255)

*-- Linhas 319 a 403:
319:         *-- Container1 legado: Tipo de O.P.
320:         THIS.AddObject("cnt_4c_TipoOp", "Container")
321:         WITH THIS.cnt_4c_TipoOp
322:             .Top         = 164
323:             .Left        = 139
324:             .Width       = 346
325:             .Height      = 25
326:             .BackStyle   = 0
327:             .BorderWidth = 0
328:             .Enabled     = THIS.this_lGerPorTp
329:             .Visible     = .T.
330:         ENDWITH
331: 
332:         *-- Opera_ao legado: codigo + faixa i/f
333:         THIS.AddObject("cnt_4c_Operacao", "Container")
334:         WITH THIS.cnt_4c_Operacao
335:             .Top         = 191
336:             .Left        = 139
337:             .Width       = 350
338:             .Height      = 25
339:             .BackStyle   = 0
340:             .BorderWidth = 0
341:             .Visible     = .T.
342:         ENDWITH
343: 
344:         *-- Conta legado: grupo/conta/descricao para filtro de movimentacao
345:         THIS.AddObject("cnt_4c_Conta", "Container")
346:         WITH THIS.cnt_4c_Conta
347:             .Top         = 218
348:             .Left        = 139
349:             .Width       = 553
350:             .Height      = 25
351:             .BackStyle   = 0
352:             .BorderWidth = 0
353:             .Visible     = .T.
354:         ENDWITH
355: 
356:         *-- Responsavel legado: grupo/conta/descricao do vendedor
357:         THIS.AddObject("cnt_4c_Responsavel", "Container")
358:         WITH THIS.cnt_4c_Responsavel
359:             .Top         = 245
360:             .Left        = 139
361:             .Width       = 553
362:             .Height      = 25
363:             .BackStyle   = 0
364:             .BorderWidth = 0
365:             .Visible     = .T.
366:         ENDWITH
367: 
368:         *-- Empresa legado: cd_empresa + ds_empresa + Chec_pedra
369:         THIS.AddObject("cnt_4c_Empresa", "Container")
370:         WITH THIS.cnt_4c_Empresa
371:             .Top         = 272
372:             .Left        = 138
373:             .Width       = 553
374:             .Height      = 25
375:             .BackStyle   = 0
376:             .BorderWidth = 0
377:             .Visible     = .T.
378:         ENDWITH
379: 
380:         *-- Cnt_Previsao legado: data previsao entrega + data geracao
381:         *-- Oculto no modo Reserva (legacy: ThisForm.Cnt_Previsao.Visible = .F.)
382:         THIS.AddObject("cnt_4c_Previsao", "Container")
383:         WITH THIS.cnt_4c_Previsao
384:             .Top         = 309
385:             .Left        = 7
386:             .Width       = 660
387:             .Height      = 33
388:             .BackStyle   = 0
389:             .BorderWidth = 0
390:             .Visible     = NOT THIS.this_lReserva
391:             .Visible     = .T.
392:         ENDWITH
393: 
394:         *-- Cnt_Op legado: numero da OP manual (visivel apenas em GlobAutos=2 e !Reserva)
395:         THIS.AddObject("cnt_4c_Op", "Container")
396:         WITH THIS.cnt_4c_Op
397:             .Top         = 313
398:             .Left        = 478
399:             .Width       = 130
400:             .Height      = 25
401:             .BackStyle   = 0
402:             .BorderWidth = 0
403:             .Visible     = loc_lGlobAutos2

*-- Linhas 409 a 607:
409:     * ConfigurarCamposForm - labels e textboxes de data diretamente no form
410:     *--------------------------------------------------------------------------
411:     PROTECTED PROCEDURE ConfigurarCamposForm()
412:         THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
413:         WITH THIS.lbl_4c_PeriodoEmissao
414:             .AutoSize  = .F.
415:             .BackStyle = 0
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .ForeColor = RGB(90,90,90)
419:             .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
420:             .Height    = 15
421:             .Left      = 32
422:             .Top       = 115
423:             .Width     = 101
424:         ENDWITH
425: 
426:         THIS.AddObject("txt_4c_Dataei", "TextBox")
427:         WITH THIS.txt_4c_Dataei
428:             .Alignment     = 3
429:             .Value         = {}
430:             .Format        = "K"
431:             .Height        = 23
432:             .Left          = 142
433:             .Top           = 111
434:             .Width         = 80
435:             .SpecialEffect = 1
436:             .FontName      = "Tahoma"
437:             .FontSize      = 8
438:         ENDWITH
439: 
440:         THIS.AddObject("lbl_4c_Ate1", "Label")
441:         WITH THIS.lbl_4c_Ate1
442:             .AutoSize  = .F.
443:             .BackStyle = 0
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .ForeColor = RGB(90,90,90)
447:             .Caption   = "at" + CHR(233)
448:             .Height    = 15
449:             .Left      = 227
450:             .Top       = 115
451:             .Width     = 18
452:         ENDWITH
453: 
454:         THIS.AddObject("txt_4c_Dataef", "TextBox")
455:         WITH THIS.txt_4c_Dataef
456:             .Alignment     = 3
457:             .Value         = {}
458:             .Format        = "K"
459:             .Height        = 23
460:             .Left          = 255
461:             .Top           = 111
462:             .Width         = 80
463:             .SpecialEffect = 1
464:             .FontName      = "Tahoma"
465:             .FontSize      = 8
466:         ENDWITH
467: 
468:         THIS.AddObject("lbl_4c_PrevEntrega", "Label")
469:         WITH THIS.lbl_4c_PrevEntrega
470:             .AutoSize  = .F.
471:             .BackStyle = 0
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .ForeColor = RGB(90,90,90)
475:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
476:             .Height    = 15
477:             .Left      = 27
478:             .Top       = 142
479:             .Width     = 106
480:         ENDWITH
481: 
482:         THIS.AddObject("txt_4c_Datapi", "TextBox")
483:         WITH THIS.txt_4c_Datapi
484:             .Alignment     = 3
485:             .Value         = {}
486:             .Format        = "K"
487:             .Height        = 23
488:             .Left          = 142
489:             .Top           = 138
490:             .Width         = 80
491:             .SpecialEffect = 1
492:             .FontName      = "Tahoma"
493:             .FontSize      = 8
494:         ENDWITH
495: 
496:         THIS.AddObject("lbl_4c_Ate2", "Label")
497:         WITH THIS.lbl_4c_Ate2
498:             .AutoSize  = .F.
499:             .BackStyle = 0
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .ForeColor = RGB(90,90,90)
503:             .Caption   = "at" + CHR(233)
504:             .Height    = 15
505:             .Left      = 227
506:             .Top       = 142
507:             .Width     = 18
508:         ENDWITH
509: 
510:         THIS.AddObject("txt_4c_Datapf", "TextBox")
511:         WITH THIS.txt_4c_Datapf
512:             .Alignment     = 3
513:             .Value         = {}
514:             .Format        = "K"
515:             .Height        = 23
516:             .Left          = 254
517:             .Top           = 138
518:             .Width         = 80
519:             .SpecialEffect = 1
520:             .FontName      = "Tahoma"
521:             .FontSize      = 8
522:         ENDWITH
523: 
524:         THIS.AddObject("lbl_4c_TipoOp", "Label")
525:         WITH THIS.lbl_4c_TipoOp
526:             .AutoSize  = .F.
527:             .BackStyle = 0
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .ForeColor = RGB(90,90,90)
531:             .Caption   = "Tipo de O.P.:"
532:             .Height    = 15
533:             .Left      = 67
534:             .Top       = 169
535:             .Width     = 66
536:         ENDWITH
537: 
538:         THIS.AddObject("lbl_4c_Movimentacao", "Label")
539:         WITH THIS.lbl_4c_Movimentacao
540:             .AutoSize  = .F.
541:             .BackStyle = 0
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .ForeColor = RGB(90,90,90)
545:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
546:             .Height    = 15
547:             .Left      = 55
548:             .Top       = 196
549:             .Width     = 78
550:         ENDWITH
551: 
552:         THIS.AddObject("lbl_4c_LblConta", "Label")
553:         WITH THIS.lbl_4c_LblConta
554:             .AutoSize  = .F.
555:             .BackStyle = 0
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .ForeColor = RGB(90,90,90)
559:             .Caption   = "Conta :"
560:             .Height    = 15
561:             .Left      = 139
562:             .Top       = 223
563:             .Width     = 38
564:         ENDWITH
565: 
566:         THIS.AddObject("lbl_4c_Vendedor", "Label")
567:         WITH THIS.lbl_4c_Vendedor
568:             .AutoSize  = .F.
569:             .BackStyle = 0
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:             .ForeColor = RGB(90,90,90)
573:             .Caption   = "Vendedor :"
574:             .Height    = 15
575:             .Left      = 78
576:             .Top       = 250
577:             .Width     = 55
578:         ENDWITH
579: 
580:         THIS.AddObject("lbl_4c_LblEmpresa", "Label")
581:         WITH THIS.lbl_4c_LblEmpresa
582:             .AutoSize  = .F.
583:             .BackStyle = 0
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .ForeColor = RGB(90,90,90)
587:             .Caption   = "Empresa :"
588:             .Height    = 15
589:             .Left      = 83
590:             .Top       = 277
591:             .Width     = 50
592:         ENDWITH
593:     ENDPROC
594: 
595:     *--------------------------------------------------------------------------
596:     * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
597:     *--------------------------------------------------------------------------
598:     PROTECTED PROCEDURE ConfigurarContainerTipoOp()
599:         THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
600:         WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
601:             .Left          = 3
602:             .Top           = 1
603:             .Width         = 80
604:             .Height        = 23
605:             .MaxLength     = 10
606:             .FontName      = "Courier New"
607:             .FontSize      = 9

*-- Linhas 616 a 687:
616:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
617:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
618:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
619:             .Left          = 3
620:             .Top           = 1
621:             .Width         = 151
622:             .Height        = 23
623:             .MaxLength     = 20
624:             .FontName      = "Courier New"
625:             .FontSize      = 9
626:             .Margin        = 2
627:             .SpecialEffect = 1
628:         ENDWITH
629: 
630:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
631:         WITH THIS.cnt_4c_Operacao.lbl_4c_De
632:             .AutoSize  = .F.
633:             .BackStyle = 0
634:             .FontName  = "Tahoma"
635:             .FontSize  = 8
636:             .ForeColor = RGB(90,90,90)
637:             .Caption   = "de"
638:             .Height    = 15
639:             .Left      = 180
640:             .Top       = 5
641:             .Width     = 14
642:         ENDWITH
643: 
644:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
645:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
646:             .Alignment     = 3
647:             .Value         = 0
648:             .Format        = "K"
649:             .Height        = 23
650:             .InputMask     = "999999"
651:             .Left          = 201
652:             .Top           = 1
653:             .Width         = 55
654:             .MaxLength     = 6
655:             .SpecialEffect = 1
656:             .FontName      = "Courier New"
657:             .FontSize      = 9
658:         ENDWITH
659: 
660:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_AteOp", "Label")
661:         WITH THIS.cnt_4c_Operacao.lbl_4c_AteOp
662:             .AutoSize  = .F.
663:             .BackStyle = 0
664:             .FontName  = "Tahoma"
665:             .FontSize  = 8
666:             .ForeColor = RGB(90,90,90)
667:             .Caption   = "at" + CHR(233)
668:             .Height    = 15
669:             .Left      = 262
670:             .Top       = 4
671:             .Width     = 18
672:         ENDWITH
673: 
674:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaof", "TextBox")
675:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaof
676:             .Alignment     = 3
677:             .Value         = 0
678:             .Format        = "K"
679:             .Height        = 23
680:             .InputMask     = "999999"
681:             .Left          = 286
682:             .Top           = 1
683:             .Width         = 55
684:             .MaxLength     = 6
685:             .SpecialEffect = 1
686:             .FontName      = "Courier New"
687:             .FontSize      = 9

*-- Linhas 694 a 725:
694:     PROTECTED PROCEDURE ConfigurarContainerConta()
695:         THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
696:         WITH THIS.cnt_4c_Conta.txt_4c_Grupo
697:             .Left          = 3
698:             .Top           = 1
699:             .Width         = 80
700:             .Height        = 23
701:             .SpecialEffect = 1
702:             .FontName      = "Tahoma"
703:             .FontSize      = 8
704:         ENDWITH
705: 
706:         THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
707:         WITH THIS.cnt_4c_Conta.txt_4c_Conta
708:             .Left          = 86
709:             .Top           = 1
710:             .Width         = 80
711:             .Height        = 23
712:             .SpecialEffect = 1
713:             .FontName      = "Tahoma"
714:             .FontSize      = 8
715:         ENDWITH
716: 
717:         THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
718:         WITH THIS.cnt_4c_Conta.txt_4c_Dconta
719:             .Left          = 170
720:             .Top           = 1
721:             .Width         = 360
722:             .Height        = 23
723:             .SpecialEffect = 1
724:             .FontName      = "Tahoma"
725:             .FontSize      = 8

*-- Linhas 732 a 763:
732:     PROTECTED PROCEDURE ConfigurarContainerResponsavel()
733:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
734:         WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
735:             .Left          = 3
736:             .Top           = 1
737:             .Width         = 80
738:             .Height        = 23
739:             .SpecialEffect = 1
740:             .FontName      = "Tahoma"
741:             .FontSize      = 8
742:         ENDWITH
743: 
744:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
745:         WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
746:             .Left          = 86
747:             .Top           = 1
748:             .Width         = 80
749:             .Height        = 23
750:             .SpecialEffect = 1
751:             .FontName      = "Tahoma"
752:             .FontSize      = 8
753:         ENDWITH
754: 
755:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
756:         WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
757:             .Left          = 170
758:             .Top           = 1
759:             .Width         = 360
760:             .Height        = 23
761:             .SpecialEffect = 1
762:             .FontName      = "Tahoma"
763:             .FontSize      = 8

*-- Linhas 770 a 779:
770:     PROTECTED PROCEDURE ConfigurarContainerEmpresa()
771:         THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
772:         WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
773:             .Left          = 4
774:             .Top           = 1
775:             .Width         = 31
776:             .Height        = 23
777:             .InputMask     = "XXX"
778:             .MaxLength     = 3
779:             .Format        = "k"

*-- Linhas 787 a 908:
787: 
788:         THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
789:         WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
790:             .Left          = 38
791:             .Top           = 1
792:             .Width         = 282
793:             .Height        = 23
794:             .MaxLength     = 40
795:             .Format        = "K"
796:             .FontName      = "Courier New"
797:             .FontSize      = 9
798:             .SpecialEffect = 1
799:         ENDWITH
800: 
801:         THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
802:         WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
803:             .Left      = 330
804:             .Top       = 5
805:             .Height    = 15
806:             .Width     = 124
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .BackStyle = 0
810:             .Caption   = "N" + CHR(227) + "o Empenhar Pedras"
811:             .Value     = 0
812:             .ForeColor = RGB(90,90,90)
813:             .Visible   = .F.
814:         ENDWITH
815:     ENDPROC
816: 
817:     *--------------------------------------------------------------------------
818:     * ConfigurarContainerPrevisao - data previsao entrega + data geracao
819:     *--------------------------------------------------------------------------
820:     PROTECTED PROCEDURE ConfigurarContainerPrevisao()
821:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
822:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
823:             .AutoSize  = .F.
824:             .BackStyle = 0
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .ForeColor = RGB(90,90,90)
828:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
829:             .Height    = 15
830:             .Left      = 7
831:             .Top       = 9
832:             .Width     = 106
833:         ENDWITH
834: 
835:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
836:         WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
837:             .Alignment     = 3
838:             .Value         = {}
839:             .Format        = "K"
840:             .Height        = 23
841:             .Left          = 134
842:             .Top           = 5
843:             .Width         = 80
844:             .SpecialEffect = 1
845:             .FontName      = "Tahoma"
846:             .FontSize      = 8
847:         ENDWITH
848: 
849:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
850:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
851:             .AutoSize  = .F.
852:             .BackStyle = 0
853:             .FontName  = "Tahoma"
854:             .FontSize  = 8
855:             .ForeColor = RGB(90,90,90)
856:             .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
857:             .Height    = 15
858:             .Left      = 244
859:             .Top       = 9
860:             .Width     = 90
861:         ENDWITH
862: 
863:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Geracao", "TextBox")
864:         WITH THIS.cnt_4c_Previsao.txt_4c_Geracao
865:             .Alignment     = 3
866:             .Value         = {}
867:             .Format        = "K"
868:             .Height        = 23
869:             .Left          = 353
870:             .Top           = 5
871:             .Width         = 80
872:             .SpecialEffect = 1
873:             .FontName      = "Tahoma"
874:             .FontSize      = 8
875:         ENDWITH
876:     ENDPROC
877: 
878:     *--------------------------------------------------------------------------
879:     * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
880:     *--------------------------------------------------------------------------
881:     PROTECTED PROCEDURE ConfigurarContainerOp()
882:         THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
883:         WITH THIS.cnt_4c_Op.lbl_4c_LblNop
884:             .AutoSize  = .F.
885:             .BackStyle = 0
886:             .FontName  = "Tahoma"
887:             .FontSize  = 8
888:             .ForeColor = RGB(90,90,90)
889:             .Caption   = "N" + CHR(186) + " da O.P.:"
890:             .Height    = 15
891:             .Left      = 0
892:             .Top       = 5
893:             .Width     = 58
894:         ENDWITH
895: 
896:         THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
897:         WITH THIS.cnt_4c_Op.txt_4c_Nop
898:             .Alignment     = 3
899:             .Value         = 0
900:             .Height        = 23
901:             .InputMask     = "999999"
902:             .Left          = 71
903:             .Top           = 1
904:             .Width         = 59
905:             .MaxLength     = 6
906:             .SpecialEffect = 1
907:             .FontName      = "Tahoma"
908:             .FontSize      = 8

*-- Linhas 1012 a 1020:
1012:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
1013:             ENDIF
1014: 
1015:             *-- Visibilidade do checkbox pedras
1016:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
1017: 
1018:             *-- Pre-selecionar tipo de OP se GerPorTp e houver apenas 1 tipo disponivel
1019:             IF THIS.this_lGerPorTp AND ;
1020:                USED("cursor_4c_CrTmpTpGop") AND ;

*-- Linhas 1032 a 1041:
1032:     * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
1033:     *--------------------------------------------------------------------------
1034:     PROTECTED PROCEDURE ConfigurarEventos()
1035:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1036:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
1037:         BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
1038:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
1039:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
1040:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
1041:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")

*-- Linhas 1171 a 1198:
1171:         LOCAL loc_oErro
1172:         TRY
1173:             WITH THIS.this_oBusinessObject
1174:                 THIS.txt_4c_Dataei.Value = .this_dDataei
1175:                 THIS.txt_4c_Dataef.Value = .this_dDataef
1176:                 THIS.txt_4c_Datapi.Value = .this_dDatapi
1177:                 THIS.txt_4c_Datapf.Value = .this_dDatapf
1178:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
1179:                 THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
1180:                 THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
1181:                 THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
1182:                 THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
1183:                 THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDConta
1184:                 THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
1185:                 THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
1186:                 THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDContaResp
1187:                 THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCodEmpresa
1188:                 THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
1189:                 THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpenharPedras
1190:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTipoGerOP
1191:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
1192:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
1193:                 THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNumeroOP
1194:             ENDWITH
1195:         CATCH TO loc_oErro
1196:             MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
1197:         ENDTRY
1198:     ENDPROC

*-- Linhas 1205 a 1214:
1205:         loc_cModo  = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
1206:         loc_lEditar = (loc_cModo = "ENTRADA")
1207: 
1208:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1209:             THIS.cmd_4c_Processar.Enabled = loc_lEditar
1210:         ENDIF
1211:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1212:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)
1213:         ENDIF
1214:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)

