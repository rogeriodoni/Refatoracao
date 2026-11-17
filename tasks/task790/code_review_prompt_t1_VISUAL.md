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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (6488 linhas total):

*-- Linhas 115 a 123:
115:     *==========================================================================
116:     PROCEDURE Init()
117:     *==========================================================================
118:         THIS.Caption = "Produtos"
119:         RETURN DODEFAULT()
120:     ENDPROC
121: 
122:     *==========================================================================
123:     * Destroy - Libera cursores e recursos

*-- Linhas 204 a 279:
204:     *==========================================================================
205:     * ConfigurarCabecalho - Faixa cinza do topo (CLAUDE.md regra #11) e bloco
206:     * canonico de Saida/Encerrar (CLAUDE.md regra #10), ambos na raiz do form
207:     * (este form usa abas visiveis, Tabs=.T., sem o truque PageFrame.Top=-29
208:     * das telas CRUD - entao nao ha compensacao de +29 a aplicar aqui).
209:     *==========================================================================
210:     PROTECTED PROCEDURE ConfigurarCabecalho()
211:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
212:         WITH THIS.cnt_4c_Cabecalho
213:             .Top           = 0
214:             .Left          = 0
215:             .Width         = THIS.Width
216:             .Height        = 80
217:             .BackColor     = RGB(100, 100, 100)
218:             .BorderWidth   = 0
219:             .SpecialEffect = 0
220:             .Visible     = .T.
221:         ENDWITH
222: 
223:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
224:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
225:             .Top       = 15
226:             .Left      = 10
227:             .Width     = THIS.cnt_4c_Cabecalho.Width - 20
228:             .Height    = 40
229:             .FontName  = "Tahoma"
230:             .FontSize  = 16
231:             .FontBold  = .T.
232:             .BackStyle = 0
233:             .ForeColor = RGB(0, 0, 0)
234:             .AutoSize  = .F.
235:             .WordWrap  = .T.
236:             .Caption   = THIS.Caption
237:         ENDWITH
238: 
239:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
240:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
241:             .Top       = 18
242:             .Left      = 10
243:             .Width     = THIS.cnt_4c_Cabecalho.Width - 20
244:             .Height    = 46
245:             .FontName  = "Tahoma"
246:             .FontSize  = 16
247:             .FontBold  = .T.
248:             .BackStyle = 0
249:             .ForeColor = RGB(255, 255, 255)
250:             .AutoSize  = .F.
251:             .WordWrap  = .T.
252:             .Caption   = THIS.Caption
253:         ENDWITH
254: 
255:         *-- cnt_4c_Saida: padrao canonico (CLAUDE.md regra #10), prevalece
256:         *-- sobre a posicao do botao "Retornar" (OK.btnSair) do SCX legado.
257:         THIS.AddObject("cnt_4c_Saida", "Container")
258:         WITH THIS.cnt_4c_Saida
259:             .Top         = 0
260:             .Left        = 917
261:             .Width       = 90
262:             .Height      = 85
263:             .BackStyle   = 0
264:             .BorderWidth = 0
265:             .Visible     = .T.
266:         ENDWITH
267: 
268:         THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
269:         WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
270:             .Left            = 5
271:             .Top             = 5
272:             .Width           = 75
273:             .Height          = 75
274:             .Caption         = "Encerrar"
275:             .FontName        = "Comic Sans MS"
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
278:             .FontSize        = 8
279:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 285 a 315:
285:             .WordWrap        = .T.
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
287:         ENDWITH
288:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
289:     ENDPROC
290: 
291:     *==========================================================================
292:     * ConfigurarBotoes - Containers vazios para os botoes de acao da tela
293:     * (toolbar superior e inferior do legado, Top=81 e Top=359).
294:     *==========================================================================
295:     PROTECTED PROCEDURE ConfigurarBotoes()
296:         THIS.AddObject("cnt_4c_Botoes", "Container")
297:         WITH THIS.cnt_4c_Botoes
298:             .Top         = 81
299:             .Left        =  542
300:             .Width       = THIS.Width - 14
301:             .Height      = 40
302:             .BackStyle   = 0
303:             .BorderWidth = 0
304:             .Visible     = .T.
305:         ENDWITH
306: 
307:         THIS.AddObject("cnt_4c_BotoesAcao", "Container")
308:         WITH THIS.cnt_4c_BotoesAcao
309:             .Top         = 359
310:             .Left        = 7
311:             .Width       = THIS.Width - 14
312:             .Height      = 40
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.

*-- Linhas 327 a 369:
327:     PROTECTED PROCEDURE ConfigurarPageFrame()
328:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
329:         WITH THIS.pgf_4c_Paginas
330:             .Top       = 403
331:             .Left      = 7
332:             .Width     = 1035
333:             .Height    = 198
334:             .Tabs      = .T.
335:             .PageCount = 4
336:             .Visible   = .F.
337:         ENDWITH
338: 
339:         WITH THIS.pgf_4c_Paginas.Page1
340:             .Caption   = "Dados do Produto"
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .BackColor = RGB(255, 255, 255)
344:             .ForeColor = RGB(90, 90, 90)
345:         ENDWITH
346: 
347:         WITH THIS.pgf_4c_Paginas.Page2
348:             .Caption   = "Dados da Movimenta" + CHR(231) + CHR(227) + "o"
349:             .FontName  = "Tahoma"
350:             .FontSize  = 8
351:             .BackColor = RGB(255, 255, 255)
352:             .ForeColor = RGB(90, 90, 90)
353:         ENDWITH
354: 
355:         WITH THIS.pgf_4c_Paginas.Page3
356:             .Caption   = "Dados Fiscais"
357:             .FontName  = "Tahoma"
358:             .FontSize  = 8
359:             .BackColor = RGB(255, 255, 255)
360:             .ForeColor = RGB(90, 90, 90)
361:         ENDWITH
362: 
363:         WITH THIS.pgf_4c_Paginas.Page4
364:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
365:             .FontName  = "Tahoma"
366:             .FontSize  = 8
367:             .BackColor = RGB(255, 255, 255)
368:             .ForeColor = RGB(90, 90, 90)
369:         ENDWITH

*-- Linhas 399 a 596:
399:         *-- cnt_4c_Codigos (cntCodigos no legado) -----------------------------
400:         loc_oPag.AddObject("cnt_4c_Codigos", "Container")
401:         WITH loc_oPag.cnt_4c_Codigos
402:             .Top         = -2
403:             .Left        = 10
404:             .Width       = 67
405:             .Height      = 45
406:             .BackStyle   = 0
407:             .BorderWidth = 0
408:             .Visible     = .T.
409:         ENDWITH
410: 
411:         loc_oPag.cnt_4c_Codigos.AddObject("txt_4c_Codigos", "TextBox")
412:         WITH loc_oPag.cnt_4c_Codigos.txt_4c_Codigos
413:             .Top           = 20
414:             .Left          = 3
415:             .Width         = 61
416:             .Height        = 23
417:             .FontBold      = .T.
418:             .FontSize      = 10
419:             .SpecialEffect = 1
420:             .ForeColor     = RGB(36, 84, 155)
421:             .Value         = THIS.this_cMascnum
422:             .ToolTipText   = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o"
423:         ENDWITH
424: 
425:         loc_oPag.cnt_4c_Codigos.AddObject("lbl_4c_LblCodigos", "Label")
426:         WITH loc_oPag.cnt_4c_Codigos.lbl_4c_LblCodigos
427:             .Top       = 3
428:             .Left      = 3
429:             .Width     = 58
430:             .Height    = 15
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .FontBold  = .F.
434:             .Alignment = 0
435:             .BackStyle = 0
436:             .ForeColor = RGB(90, 90, 90)
437:             .Caption   = "C" + CHR(243) + "digo"
438:         ENDWITH
439: 
440:         *-- cnt_4c_TabDs (cntTabDs no legado) ----------------------------------
441:         loc_oPag.AddObject("cnt_4c_TabDs", "Container")
442:         WITH loc_oPag.cnt_4c_TabDs
443:             .Top         = -2
444:             .Left        = 77
445:             .Width       = 86
446:             .Height      = 45
447:             .BackStyle   = 0
448:             .BorderWidth = 0
449:             .Visible     = .T.
450:         ENDWITH
451: 
452:         loc_oPag.cnt_4c_TabDs.AddObject("lbl_4c_LblTabDes", "Label")
453:         WITH loc_oPag.cnt_4c_TabDs.lbl_4c_LblTabDes
454:             .Top       = 3
455:             .Left      = 3
456:             .Width     = 78
457:             .Height    = 15
458:             .FontName  = "Tahoma"
459:             .FontSize  = 8
460:             .FontBold  = .F.
461:             .Alignment = 0
462:             .BackStyle = 0
463:             .ForeColor = RGB(90, 90, 90)
464:             .Caption   = "Tb. Varia" + CHR(231) + CHR(227) + "o"
465:         ENDWITH
466: 
467:         loc_oPag.cnt_4c_TabDs.AddObject("txt_4c_TabDes", "TextBox")
468:         WITH loc_oPag.cnt_4c_TabDs.txt_4c_TabDes
469:             .Top           = 20
470:             .Left          = 3
471:             .Width         = 80
472:             .Height        = 23
473:             .SpecialEffect = 1
474:             .Value         = THIS.this_cTabds
475:             .ToolTipText   = "Tabela de Desconto"
476:         ENDWITH
477: 
478:         *-- cnt_4c_TpFats (cntTpFats no legado) --------------------------------
479:         loc_oPag.AddObject("cnt_4c_TpFats", "Container")
480:         WITH loc_oPag.cnt_4c_TpFats
481:             .Top         = -2
482:             .Left        = 163
483:             .Width       = 41
484:             .Height      = 45
485:             .BackStyle   = 0
486:             .BorderWidth = 0
487:             .Visible     = .T.
488:         ENDWITH
489: 
490:         loc_oPag.cnt_4c_TpFats.AddObject("txt_4c_TpFats", "TextBox")
491:         WITH loc_oPag.cnt_4c_TpFats.txt_4c_TpFats
492:             .Top           = 20
493:             .Left          = 3
494:             .Width         = 29
495:             .Height        = 23
496:             .Format        = "K"
497:             .MaxLength     = 3
498:             .SpecialEffect = 1
499:             .Value         = THIS.this_cTpfats
500:             .ToolTipText   = "Tipo de Faturamento"
501:         ENDWITH
502: 
503:         loc_oPag.cnt_4c_TpFats.AddObject("lbl_4c_LblTpFats", "Label")
504:         WITH loc_oPag.cnt_4c_TpFats.lbl_4c_LblTpFats
505:             .Top       = 3
506:             .Left      = 3
507:             .Width     = 36
508:             .Height    = 15
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .FontBold  = .F.
512:             .Alignment = 0
513:             .BackStyle = 0
514:             .ForeColor = RGB(90, 90, 90)
515:             .Caption   = "Tp.Fat"
516:         ENDWITH
517: 
518:         *-- cnt_4c_Moedas (cntMoedas no legado) ---------------------------------
519:         loc_oPag.AddObject("cnt_4c_Moedas", "Container")
520:         WITH loc_oPag.cnt_4c_Moedas
521:             .Top         = -2
522:             .Left        = 204
523:             .Width       = 35
524:             .Height      = 45
525:             .BackStyle   = 0
526:             .BorderWidth = 0
527:             .Visible     = .T.
528:         ENDWITH
529: 
530:         loc_oPag.cnt_4c_Moedas.AddObject("txt_4c_Moedas", "TextBox")
531:         WITH loc_oPag.cnt_4c_Moedas.txt_4c_Moedas
532:             .Top           = 20
533:             .Left          = 3
534:             .Width         = 29
535:             .Height        = 23
536:             .Format        = "K"
537:             .MaxLength     = 3
538:             .SpecialEffect = 1
539:             .Value         = THIS.this_cMoeits
540:             .ToolTipText   = "Moeda dos Itens"
541:         ENDWITH
542: 
543:         loc_oPag.cnt_4c_Moedas.AddObject("lbl_4c_LblMoedas", "Label")
544:         WITH loc_oPag.cnt_4c_Moedas.lbl_4c_LblMoedas
545:             .Top       = 3
546:             .Left      = 3
547:             .Width     = 29
548:             .Height    = 15
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .FontBold  = .F.
552:             .Alignment = 0
553:             .BackStyle = 0
554:             .ForeColor = RGB(90, 90, 90)
555:             .Caption   = "Moe"
556:         ENDWITH
557: 
558:         *-- cnt_4c_Origem (cntOrigem no legado) --------------------------------
559:         loc_oPag.AddObject("cnt_4c_Origem", "Container")
560:         WITH loc_oPag.cnt_4c_Origem
561:             .Top           = 43
562:             .Left          = 10
563:             .Width         = 456
564:             .Height        = 42
565:             .BackStyle     = 0
566:             .BorderWidth   = 0
567:             .SpecialEffect = 2
568:             .BackColor     = RGB(240, 240, 240)
569:             .BorderColor   = RGB(90, 90, 90)
570:             .Visible     = .T.
571:         ENDWITH
572: 
573:         loc_oPag.cnt_4c_Origem.AddObject("lbl_4c_Origem", "Label")
574:         WITH loc_oPag.cnt_4c_Origem.lbl_4c_Origem
575:             .Top       = 3
576:             .Left      = 3
577:             .Width     = 43
578:             .Height    = 15
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .FontBold  = .T.
582:             .Alignment = 0
583:             .BackStyle = 0
584:             .ForeColor = RGB(90, 90, 90)
585:             .Caption   = "Origem"
586:         ENDWITH
587: 
588:         loc_oPag.cnt_4c_Origem.AddObject("txt_4c_GrupoOs", "TextBox")
589:         WITH loc_oPag.cnt_4c_Origem.txt_4c_GrupoOs
590:             .Top               = 20
591:             .Left              = 3
592:             .Width             = 80
593:             .Height            = 21
594:             .FontBold          = .T.
595:             .Alignment         = 1
596:             .ReadOnly          = .T.

*-- Linhas 602 a 667:
602: 
603:         loc_oPag.cnt_4c_Origem.AddObject("txt_4c_ContaOs", "TextBox")
604:         WITH loc_oPag.cnt_4c_Origem.txt_4c_ContaOs
605:             .Top               = 20
606:             .Left              = 84
607:             .Width             = 80
608:             .Height            = 21
609:             .ReadOnly          = .T.
610:             .SpecialEffect     = 1
611:             .DisabledBackColor = RGB(255, 255, 255)
612:             .Value             = THIS.this_cContaos
613:             .ToolTipText       = "Conta de Origem"
614:         ENDWITH
615: 
616:         loc_oPag.cnt_4c_Origem.AddObject("txt_4c_DContaOs", "TextBox")
617:         WITH loc_oPag.cnt_4c_Origem.txt_4c_DContaOs
618:             .Top               = 20
619:             .Left              = 165
620:             .Width             = 290
621:             .Height            = 21
622:             .ReadOnly          = .T.
623:             .SpecialEffect     = 1
624:             .DisabledBackColor = RGB(255, 255, 255)
625:             .Value             = THIS.this_cDContaos
626:             .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o da Conta de Origem"
627:         ENDWITH
628: 
629:         *-- cnt_4c_Destino (cntDestino no legado) ------------------------------
630:         loc_oPag.AddObject("cnt_4c_Destino", "Container")
631:         WITH loc_oPag.cnt_4c_Destino
632:             .Top           = 85
633:             .Left          = 10
634:             .Width         = 456
635:             .Height        = 42
636:             .BackStyle     = 0
637:             .BorderWidth   = 0
638:             .SpecialEffect = 2
639:             .BackColor     = RGB(240, 240, 240)
640:             .BorderColor   = RGB(90, 90, 90)
641:             .Visible     = .T.
642:         ENDWITH
643: 
644:         loc_oPag.cnt_4c_Destino.AddObject("lbl_4c_Destino", "Label")
645:         WITH loc_oPag.cnt_4c_Destino.lbl_4c_Destino
646:             .Top       = 3
647:             .Left      = 3
648:             .Width     = 45
649:             .Height    = 15
650:             .FontName  = "Tahoma"
651:             .FontSize  = 8
652:             .FontBold  = .T.
653:             .Alignment = 0
654:             .BackStyle = 0
655:             .ForeColor = RGB(90, 90, 90)
656:             .Caption   = "Destino"
657:         ENDWITH
658: 
659:         loc_oPag.cnt_4c_Destino.AddObject("txt_4c_GrupoDs", "TextBox")
660:         WITH loc_oPag.cnt_4c_Destino.txt_4c_GrupoDs
661:             .Top               = 20
662:             .Left              = 3
663:             .Width             = 80
664:             .Height            = 21
665:             .FontBold          = .T.
666:             .Alignment         = 1
667:             .ReadOnly          = .T.

*-- Linhas 673 a 784:
673: 
674:         loc_oPag.cnt_4c_Destino.AddObject("txt_4c_ContaDs", "TextBox")
675:         WITH loc_oPag.cnt_4c_Destino.txt_4c_ContaDs
676:             .Top               = 20
677:             .Left              = 84
678:             .Width             = 80
679:             .Height            = 21
680:             .ReadOnly          = .T.
681:             .SpecialEffect     = 1
682:             .DisabledBackColor = RGB(255, 255, 255)
683:             .Value             = THIS.this_cContads
684:             .ToolTipText       = "Conta de Destino"
685:         ENDWITH
686: 
687:         loc_oPag.cnt_4c_Destino.AddObject("txt_4c_DContaDs", "TextBox")
688:         WITH loc_oPag.cnt_4c_Destino.txt_4c_DContaDs
689:             .Top               = 20
690:             .Left              = 165
691:             .Width             = 290
692:             .Height            = 21
693:             .ReadOnly          = .T.
694:             .SpecialEffect     = 1
695:             .DisabledBackColor = RGB(255, 255, 255)
696:             .Value             = THIS.this_cDContads
697:             .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o da Conta de Destino"
698:         ENDWITH
699: 
700:         *-- cnt_4c_EmpDes (cntEmpDes no legado) --------------------------------
701:         loc_oPag.AddObject("cnt_4c_EmpDes", "Container")
702:         WITH loc_oPag.cnt_4c_EmpDes
703:             .Top         = -2
704:             .Left        = 240
705:             .Width       = 37
706:             .Height      = 45
707:             .BackStyle   = 0
708:             .BorderWidth = 0
709:             .Visible     = .T.
710:         ENDWITH
711: 
712:         loc_oPag.cnt_4c_EmpDes.AddObject("lbl_4c_EmpDs", "Label")
713:         WITH loc_oPag.cnt_4c_EmpDes.lbl_4c_EmpDs
714:             .Top       = 3
715:             .Left      = 3
716:             .Width     = 26
717:             .Height    = 15
718:             .FontName  = "Tahoma"
719:             .FontSize  = 8
720:             .FontBold  = .F.
721:             .Alignment = 0
722:             .BackStyle = 0
723:             .ForeColor = RGB(90, 90, 90)
724:             .Caption   = "Dest."
725:         ENDWITH
726: 
727:         loc_oPag.cnt_4c_EmpDes.AddObject("txt_4c_EmpDs", "TextBox")
728:         WITH loc_oPag.cnt_4c_EmpDes.txt_4c_EmpDs
729:             .Top           = 20
730:             .Left          = 3
731:             .Width         = 31
732:             .Height        = 23
733:             .SpecialEffect = 1
734:             .Value         = THIS.this_cEmpds
735:             .ToolTipText   = "Empresa de Destino"
736:         ENDWITH
737: 
738:         *-- cnt_4c_LPrecos (cntLPrecos no legado) ------------------------------
739:         loc_oPag.AddObject("cnt_4c_LPrecos", "Container")
740:         WITH loc_oPag.cnt_4c_LPrecos
741:             .Top         = -2
742:             .Left        = 277
743:             .Width       = 223
744:             .Height      = 45
745:             .BackStyle   = 0
746:             .BorderWidth = 0
747:             .BackColor   = RGB(240, 240, 240)
748:             .BorderColor = RGB(90, 90, 90)
749:             .Visible     = .T.
750:         ENDWITH
751: 
752:         loc_oPag.cnt_4c_LPrecos.AddObject("txt_4c_LPrecos", "TextBox")
753:         WITH loc_oPag.cnt_4c_LPrecos.txt_4c_LPrecos
754:             .Top           = 20
755:             .Left          = 3
756:             .Width         = 217
757:             .Height        = 23
758:             .FontName      = "Tahoma"
759:             .Format        = "K"
760:             .MaxLength     = 30
761:             .SpecialEffect = 1
762:             .ForeColor     = RGB(90, 90, 90)
763:             .Value         = THIS.this_cLPrecos
764:             .ToolTipText   = "Lista de Pre" + CHR(231) + "os"
765:         ENDWITH
766: 
767:         loc_oPag.cnt_4c_LPrecos.AddObject("lbl_4c_LPrecos", "Label")
768:         WITH loc_oPag.cnt_4c_LPrecos.lbl_4c_LPrecos
769:             .Top       = 3
770:             .Left      = 3
771:             .Width     = 115
772:             .Height    = 15
773:             .FontName  = "Tahoma"
774:             .FontSize  = 8
775:             .FontBold  = .F.
776:             .Alignment = 0
777:             .BackStyle = 0
778:             .ForeColor = RGB(90, 90, 90)
779:             .Caption   = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
780:         ENDWITH
781:     ENDPROC
782: 
783:     *==========================================================================
784:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;

*-- Linhas 880 a 889:
880:     PROTECTED PROCEDURE ConfigurarGridDados()
881:         THIS.AddObject("grd_4c_Dados", "Grid")
882:         WITH THIS.grd_4c_Dados
883:             .Top               = 122
884:             .Left              = 7
885:             .Width             = 1035
886:             .Height            = 233
887:             .ColumnCount       = 22
888:             .RecordSource      = "cursor_4c_Itens"
889:             .FontName          = "Courier New"

*-- Linhas 913 a 1166:
913:             .Header1.FontName  = "Arial"
914:             .Header1.FontSize  = 8
915:             .Header1.Alignment = 2
916:             .Header1.Caption   = "Produto"
917:         ENDWITH
918: 
919:         *-- Column2: FATOR
920:         WITH THIS.grd_4c_Dados.Column2
921:             .ControlSource     = "cursor_4c_Itens.fators"
922:             .Width             = 50
923:             .InputMask         = "99999.999"
924:             .Header1.Alignment = 2
925:             .Header1.Caption   = "Fator"
926:         ENDWITH
927: 
928:         *-- Column3: OPERACAO (Format=M -> InputMask eh a LISTA, regra #24)
929:         WITH THIS.grd_4c_Dados.Column3
930:             .ControlSource     = "cursor_4c_Itens.opers"
931:             .Width             = 14
932:             .Format            = "M"
933:             .InputMask         = "E,S"
934:             .Header1.Caption   = "Op"
935:         ENDWITH
936: 
937:         *-- Column4: QTD
938:         WITH THIS.grd_4c_Dados.Column4
939:             .ControlSource     = "cursor_4c_Itens.qtds"
940:             .Width             = 64
941:             .InputMask         = "99999.999"
942:             .Header1.Alignment = 2
943:             .Header1.Caption   = "Qtd."
944:         ENDWITH
945: 
946:         *-- Column5: PESO
947:         WITH THIS.grd_4c_Dados.Column5
948:             .ControlSource     = "cursor_4c_Itens.pesos"
949:             .Width             = 60
950:             .InputMask         = "99999.999"
951:             .Header1.Alignment = 2
952:             .Header1.Caption   = "Peso"
953:         ENDWITH
954: 
955:         *-- Column6: VALOR
956:         WITH THIS.grd_4c_Dados.Column6
957:             .ControlSource     = "cursor_4c_Itens.units"
958:             .Width             = 90
959:             .InputMask         = "99999999.99"
960:             .Header1.Alignment = 2
961:             .Header1.Caption   = "Valor"
962:         ENDWITH
963: 
964:         *-- Column7: MOEDA
965:         WITH THIS.grd_4c_Dados.Column7
966:             .ControlSource     = "cursor_4c_Itens.moedas"
967:             .Width             = 24
968:             .Header1.Alignment = 2
969:             .Header1.Caption   = "Moe"
970:         ENDWITH
971: 
972:         *-- Column8: TOTAL
973:         WITH THIS.grd_4c_Dados.Column8
974:             .ControlSource     = "cursor_4c_Itens.totas"
975:             .Width             = 107
976:             .InputMask         = "9999999999.99"
977:             .Header1.Alignment = 2
978:             .Header1.Caption   = "Total"
979:         ENDWITH
980: 
981:         *-- Column9: pesotot
982:         WITH THIS.grd_4c_Dados.Column9
983:             .ControlSource     = "cursor_4c_Itens.tpesos"
984:             .Width             = 64
985:             .InputMask         = "9999999.99"
986:             .Header1.Alignment = 2
987:             .Header1.Caption   = "Total Peso"
988:         ENDWITH
989: 
990:         *-- Column10: item (numero sequencial, sem legenda no legado)
991:         WITH THIS.grd_4c_Dados.Column10
992:             .ControlSource     = "cursor_4c_Itens.citens"
993:             .Width             = 31
994:             .InputMask         = "9999"
995:             .Header1.Caption   = ""
996:         ENDWITH
997: 
998:         *-- Column11: UNIDADE
999:         WITH THIS.grd_4c_Dados.Column11
1000:             .ControlSource     = "cursor_4c_Itens.cunis"
1001:             .Width             = 30
1002:             .Header1.Alignment = 2
1003:             .Header1.Caption   = "Uni"
1004:         ENDWITH
1005: 
1006:         *-- Column12: UNIPESO (desabilitada, igual ao legado)
1007:         WITH THIS.grd_4c_Dados.Column12
1008:             .ControlSource     = "cursor_4c_Itens.cunips"
1009:             .Width             = 31
1010:             .Enabled           = .F.
1011:             .Header1.Alignment = 2
1012:             .Header1.Caption   = "Uni"
1013:         ENDWITH
1014: 
1015:         *-- Column13: PEDIDO
1016:         WITH THIS.grd_4c_Dados.Column13
1017:             .ControlSource     = "cursor_4c_Itens.abrevis"
1018:             .Width             = 40
1019:             .Header1.Alignment = 2
1020:             .Header1.Caption   = "Ped"
1021:         ENDWITH
1022: 
1023:         *-- Column14: DESCRS
1024:         WITH THIS.grd_4c_Dados.Column14
1025:             .ControlSource     = "cursor_4c_Itens.dpros"
1026:             .Width             = 290
1027:             .Header1.Alignment = 2
1028:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1029:         ENDWITH
1030: 
1031:         *-- Column15: cor
1032:         WITH THIS.grd_4c_Dados.Column15
1033:             .ControlSource     = "cursor_4c_Itens.codcors"
1034:             .Width             = 24
1035:             .Header1.Alignment = 2
1036:             .Header1.Caption   = "Cor"
1037:         ENDWITH
1038: 
1039:         *-- Column16: Local
1040:         WITH THIS.grd_4c_Dados.Column16
1041:             .ControlSource     = "cursor_4c_Itens.locals"
1042:             .Width             = 80
1043:             .Header1.Alignment = 2
1044:             .Header1.Caption   = "Local"
1045:         ENDWITH
1046: 
1047:         *-- Column17: Comprimento
1048:         WITH THIS.grd_4c_Dados.Column17
1049:             .ControlSource     = "cursor_4c_Itens.compris"
1050:             .Width             = 50
1051:             .InputMask         = "9999.99"
1052:             .Header1.Alignment = 2
1053:             .Header1.Caption   = "Compr."
1054:         ENDWITH
1055: 
1056:         *-- Column18: LocalO
1057:         WITH THIS.grd_4c_Dados.Column18
1058:             .ControlSource     = "cursor_4c_Itens.localos"
1059:             .Width             = 80
1060:             .Header1.Alignment = 2
1061:             .Header1.Caption   = "Local Ori"
1062:         ENDWITH
1063: 
1064:         *-- Column19: Tamanho
1065:         WITH THIS.grd_4c_Dados.Column19
1066:             .ControlSource     = "cursor_4c_Itens.codtams"
1067:             .Width             = 35
1068:             .Header1.Alignment = 2
1069:             .Header1.Caption   = "Tam."
1070:         ENDWITH
1071: 
1072:         *-- Column20: Reserva (ReadOnly, igual ao legado)
1073:         WITH THIS.grd_4c_Dados.Column20
1074:             .ControlSource     = "cursor_4c_Itens.qtreservas"
1075:             .Width             = 64
1076:             .ReadOnly          = .T.
1077:             .InputMask         = "999999.999"
1078:             .Header1.Alignment = 2
1079:             .Header1.Caption   = "Reserva"
1080:         ENDWITH
1081: 
1082:         *-- Column21 (Presente) e Column22 (O.S.): CheckBox de coluna.
1083:         *-- Aqui so o BIND e a largura/header. O AddObject do CheckBox roda
1084:         *-- DEPOIS, em InstalarCheckBoxesGrade(), porque Column.AddObject de
1085:         *-- CheckBox ESTOURA enquanto a coluna estiver ligada (pelo auto-bind
1086:         *-- do RecordSource) a um campo de outro tipo: com ColumnCount = 22 o
1087:         *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
1088:         *-- adicionar um controle numerico ali da
1089:         *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
1090:         *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
1091:         *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
1092:         *-- simplesmente nao abre - sem erro na tela e sem log.
1093:         WITH THIS.grd_4c_Dados.Column21
1094:             .ControlSource     = "cursor_4c_Itens.ckpresente"
1095:             .Width             = 50
1096:             .Header1.Alignment = 2
1097:             .Header1.Caption   = "Presente"
1098:         ENDWITH
1099: 
1100:         WITH THIS.grd_4c_Dados.Column22
1101:             .ControlSource     = "cursor_4c_Itens.servicos"
1102:             .Width             = 50
1103:             .Header1.Alignment = 2
1104:             .Header1.Caption   = "O.S."
1105:         ENDWITH
1106: 
1107:         *-- Todas as colunas ja estao bindadas: agora os CheckBox.
1108:         THIS.InstalarCheckBoxesGrade()
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
1113:     * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
1114:     * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
1115:     * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
1116:     * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
1117:     *
1118:     * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
1119:     * fechar o alias destroi os objetos postos na Column, entao a instalacao
1120:     * tem de poder rodar de novo sem duplicar o AddObject.
1121:     *==========================================================================
1122:     PROTECTED PROCEDURE InstalarCheckBoxesGrade()
1123:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1124:             RETURN
1125:         ENDIF
1126: 
1127:         IF THIS.grd_4c_Dados.ColumnCount < 22
1128:             RETURN
1129:         ENDIF
1130: 
1131:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column21, "chk_4c_Presente")
1132:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column22, "chk_4c_Servico")
1133:     ENDPROC
1134: 
1135:     *==========================================================================
1136:     * InstalarCheckBoxColuna - Poe UM CheckBox numa Column. Propriedades: so
1137:     * as que o VFP9 de fato aplica em controle de Column criado em runtime
1138:     * (Caption/Alignment/ReadOnly/Visible/FontName/FontSize/Value). Top/Left/
1139:     * Width/Height sao DESCARTADAS nesse contexto - escrever a geometria do
1140:     * dump aqui eh codigo morto que sugere area clicavel calibrada.
1141:     *==========================================================================
1142:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNomeChk)
1143:         IF VARTYPE(par_oColuna) <> "O" OR VARTYPE(par_cNomeChk) <> "C"
1144:             RETURN
1145:         ENDIF
1146: 
1147:         IF !PEMSTATUS(par_oColuna, par_cNomeChk, 5)
1148:             par_oColuna.AddObject(par_cNomeChk, "CheckBox")
1149:         ENDIF
1150: 
1151:         *-- Membro alcancado por NOME: EVALUATE para ler, STORE para atribuir
1152:         *-- (Column nao eh colecao por chave - regra #34).
1153:         STORE ""   TO ("par_oColuna." + par_cNomeChk + ".Caption")
1154:         STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Alignment")
1155:         STORE .F.  TO ("par_oColuna." + par_cNomeChk + ".ReadOnly")
1156:         STORE .T.  TO ("par_oColuna." + par_cNomeChk + ".Visible")
1157:         STORE "Courier New" TO ("par_oColuna." + par_cNomeChk + ".FontName")
1158:         STORE 9    TO ("par_oColuna." + par_cNomeChk + ".FontSize")
1159:         STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Value")
1160: 
1161:         *-- Sparse = .F. senao o CheckBox so aparece na linha ativa;
1162:         *-- CurrentControl com o NOME do objeto, senao a coluna segue
1163:         *-- desenhando o Text1 dela (regra #18).
1164:         par_oColuna.Sparse         = .F.
1165:         par_oColuna.CurrentControl = par_cNomeChk
1166:     ENDPROC

*-- Linhas 1176 a 1261:
1176:         LOCAL loc_oCnt
1177:         loc_oCnt = THIS.cnt_4c_Botoes
1178: 
1179:         loc_oCnt.AddObject("cmd_4c_BtnTotItens", "CommandButton")
1180:         WITH loc_oCnt.cmd_4c_BtnTotItens
1181:             .Left            = 7
1182:             .Top             = 0
1183:             .Width           = 102
1184:             .Height          = 40
1185:             .FontName        = "Comic Sans MS"
1186:             .FontBold        = .T.
1187:             .FontItalic      = .T.
1188:             .FontSize        = 8
1189:             .WordWrap        = .T.
1190:             .ForeColor       = RGB(90, 90, 90)
1191:             .BackColor       = RGB(255, 255, 255)
1192:             .Themes          = .T.
1193:             .PicturePosition = 1
1194:             .MousePointer    = 15
1195:             .Caption         = "Total de Produtos"
1196:             .ToolTipText     = "Total dos Produtos"
1197:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1198:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1199:         ENDWITH
1200:         BINDEVENT(loc_oCnt.cmd_4c_BtnTotItens, "Click", THIS, "BtnTotItensClick")
1201: 
1202:         loc_oCnt.AddObject("cmd_4c_BtnCotacao", "CommandButton")
1203:         WITH loc_oCnt.cmd_4c_BtnCotacao
1204:             .Left            = 109
1205:             .Top             = 0
1206:             .Width           = 102
1207:             .Height          = 40
1208:             .FontName        = "Comic Sans MS"
1209:             .FontBold        = .T.
1210:             .FontItalic      = .T.
1211:             .FontSize        = 8
1212:             .WordWrap        = .T.
1213:             .ForeColor       = RGB(90, 90, 90)
1214:             .BackColor       = RGB(255, 255, 255)
1215:             .Themes          = .T.
1216:             .PicturePosition = 1
1217:             .MousePointer    = 15
1218:             .Caption         = "C" + CHR(226) + "mbio de Produtos"
1219:             .ToolTipText     = "Edita os Valores de Cota" + CHR(231) + CHR(227) + "o das Moedas"
1220:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
1221:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
1222:         ENDWITH
1223:         BINDEVENT(loc_oCnt.cmd_4c_BtnCotacao, "Click", THIS, "BtnCotacaoClick")
1224: 
1225:         loc_oCnt.AddObject("cmd_4c_BtnAltImps", "CommandButton")
1226:         WITH loc_oCnt.cmd_4c_BtnAltImps
1227:             .Left            = 211
1228:             .Top             = 0
1229:             .Width           = 102
1230:             .Height          = 40
1231:             .FontName        = "Comic Sans MS"
1232:             .FontBold        = .T.
1233:             .FontItalic      = .T.
1234:             .FontSize        = 8
1235:             .WordWrap        = .T.
1236:             .ForeColor       = RGB(90, 90, 90)
1237:             .BackColor       = RGB(255, 255, 255)
1238:             .Themes          = .T.
1239:             .PicturePosition = 1
1240:             .MousePointer    = 15
1241:             .Caption         = "Alterar Impostos"
1242:             .ToolTipText     = "Alterar Impostos"
1243:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1244:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1245:         ENDWITH
1246:         BINDEVENT(loc_oCnt.cmd_4c_BtnAltImps, "Click", THIS, "BtnAltImpsClick")
1247: 
1248:         loc_oCnt.AddObject("chk_4c_BtnVerImps", "CheckBox")
1249:         WITH loc_oCnt.chk_4c_BtnVerImps
1250:             .Left            = 313
1251:             .Top             = 0
1252:             .Width           = 102
1253:             .Height          = 40
1254:             .Style           = 1
1255:             .Alignment       = 2
1256:             *-- CheckBox.Value SEMPRE numerico (0/1). O SCX legado declara
1257:             *-- Value = .F., mas misturar Logico e Numerico no mesmo controle
1258:             *-- estoura "Operator/operand type mismatch" na primeira
1259:             *-- comparacao com 0/1 feita em outro metodo.
1260:             .Value           = 0
1261:             .FontName        = "Comic Sans MS"

*-- Linhas 1268 a 1730:
1268:             .Themes          = .T.
1269:             .PicturePosition = 1
1270:             .MousePointer    = 15
1271:             .Caption         = "Visualizar Impostos"
1272:             .ToolTipText     = "Visualizar Impostos"
1273:             .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
1274:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
1275:         ENDWITH
1276:         BINDEVENT(loc_oCnt.chk_4c_BtnVerImps, "Click", THIS, "BtnVerImpsClick")
1277: 
1278:         loc_oCnt.AddObject("cmd_4c_BtnRecImps", "CommandButton")
1279:         WITH loc_oCnt.cmd_4c_BtnRecImps
1280:             .Left            = 414
1281:             .Top             = 0
1282:             .Width           = 102
1283:             .Height          = 40
1284:             .FontName        = "Comic Sans MS"
1285:             .FontBold        = .T.
1286:             .FontItalic      = .T.
1287:             .FontSize        = 8
1288:             .WordWrap        = .T.
1289:             .ForeColor       = RGB(90, 90, 90)
1290:             .BackColor       = RGB(255, 255, 255)
1291:             .Themes          = .T.
1292:             .PicturePosition = 1
1293:             .MousePointer    = 15
1294:             .Caption         = "Recalcular Impostos"
1295:             .ToolTipText     = "Recalcular Impostos"
1296:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1297:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1298:         ENDWITH
1299:         BINDEVENT(loc_oCnt.cmd_4c_BtnRecImps, "Click", THIS, "BtnRecImpsClick")
1300: 
1301:         loc_oCnt.AddObject("cmd_4c_Btndevolu", "CommandButton")
1302:         WITH loc_oCnt.cmd_4c_Btndevolu
1303:             .Left            = 517
1304:             .Top             = 0
1305:             .Width           = 102
1306:             .Height          = 40
1307:             .FontName        = "Comic Sans MS"
1308:             .FontBold        = .T.
1309:             .FontItalic      = .T.
1310:             .FontSize        = 8
1311:             .WordWrap        = .T.
1312:             .ForeColor       = RGB(90, 90, 90)
1313:             .BackColor       = RGB(255, 255, 255)
1314:             .Themes          = .T.
1315:             .PicturePosition = 1
1316:             .MousePointer    = 15
1317:             .Caption         = "Devolu" + CHR(231) + CHR(227) + "o"
1318:             .ToolTipText     = "Devolu" + CHR(231) + CHR(227) + "o"
1319:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1320:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1321:         ENDWITH
1322:         BINDEVENT(loc_oCnt.cmd_4c_Btndevolu, "Click", THIS, "BtndevoluClick")
1323: 
1324:         loc_oCnt.AddObject("cmd_4c_BtnIteSub", "CommandButton")
1325:         WITH loc_oCnt.cmd_4c_BtnIteSub
1326:             .Left            = 618
1327:             .Top             = 0
1328:             .Width           = 102
1329:             .Height          = 40
1330:             .FontName        = "Comic Sans MS"
1331:             .FontBold        = .T.
1332:             .FontItalic      = .T.
1333:             .FontSize        = 8
1334:             .WordWrap        = .T.
1335:             .ForeColor       = RGB(90, 90, 90)
1336:             .BackColor       = RGB(255, 255, 255)
1337:             .Themes          = .T.
1338:             .PicturePosition = 1
1339:             .MousePointer    = 15
1340:             .Caption         = "Itens Subn" + CHR(237) + "vel"
1341:             .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1342:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1343:         ENDWITH
1344:         BINDEVENT(loc_oCnt.cmd_4c_BtnIteSub, "Click", THIS, "BtnIteSubClick")
1345: 
1346:         loc_oCnt.AddObject("cmd_4c_CmdXml", "CommandButton")
1347:         WITH loc_oCnt.cmd_4c_CmdXml
1348:             .Left            = 720
1349:             .Top             = 0
1350:             .Width           = 102
1351:             .Height          = 40
1352:             .FontName        = "Comic Sans MS"
1353:             .FontBold        = .T.
1354:             .FontItalic      = .T.
1355:             .FontSize        = 7
1356:             .WordWrap        = .T.
1357:             .ForeColor       = RGB(90, 90, 90)
1358:             .BackColor       = RGB(255, 255, 255)
1359:             .Themes          = .T.
1360:             .PicturePosition = 1
1361:             .MousePointer    = 15
1362:             .Caption         = "Importar XML"
1363:             .ToolTipText     = "Importar XML"
1364:             .Picture         = gc_4c_CaminhoIcones + "images.jpg"
1365:             .DisabledPicture = gc_4c_CaminhoIcones + "images.jpg"
1366:         ENDWITH
1367:         BINDEVENT(loc_oCnt.cmd_4c_CmdXml, "Click", THIS, "CmdXmlClick")
1368: 
1369:         loc_oCnt.AddObject("cmd_4c_Btncarregar", "CommandButton")
1370:         WITH loc_oCnt.cmd_4c_Btncarregar
1371:             .Left            = 822
1372:             .Top             = 0
1373:             .Width           = 102
1374:             .Height          = 40
1375:             .FontName        = "Comic Sans MS"
1376:             .FontBold        = .T.
1377:             .FontItalic      = .T.
1378:             .FontSize        = 8
1379:             .WordWrap        = .T.
1380:             .ForeColor       = RGB(90, 90, 90)
1381:             .BackColor       = RGB(255, 255, 255)
1382:             .Themes          = .T.
1383:             .PicturePosition = 1
1384:             .MousePointer    = 15
1385:             .Caption         = "Carrega Cadastro"
1386:             .ToolTipText     = "Carregar Cadastro"
1387:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1388:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1389:         ENDWITH
1390:         BINDEVENT(loc_oCnt.cmd_4c_Btncarregar, "Click", THIS, "BtncarregarClick")
1391: 
1392:         loc_oCnt.AddObject("cmd_4c_BtnRetCash", "CommandButton")
1393:         WITH loc_oCnt.cmd_4c_BtnRetCash
1394:             .Left            = 924
1395:             .Top             = 0
1396:             .Width           = 102
1397:             .Height          = 40
1398:             .FontName        = "Comic Sans MS"
1399:             .FontBold        = .T.
1400:             .FontItalic      = .T.
1401:             .FontSize        = 8
1402:             .WordWrap        = .T.
1403:             .ForeColor       = RGB(90, 90, 90)
1404:             .BackColor       = RGB(255, 255, 255)
1405:             .Themes          = .T.
1406:             .PicturePosition = 1
1407:             .MousePointer    = 15
1408:             .Caption         = "Retorna B" + CHR(244) + "nus"
1409:             .ToolTipText     = "Retorna B" + CHR(244) + "nus"
1410:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1411:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1412:         ENDWITH
1413:         BINDEVENT(loc_oCnt.cmd_4c_BtnRetCash, "Click", THIS, "BtnRetCashClick")
1414:     ENDPROC
1415: 
1416:     *==========================================================================
1417:     * ConfigurarBotoesAcao - Preenche cnt_4c_BotoesAcao (Top=359 no legado).
1418:     *==========================================================================
1419:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1420:         LOCAL loc_oCnt
1421:         loc_oCnt = THIS.cnt_4c_BotoesAcao
1422: 
1423:         loc_oCnt.AddObject("cmd_4c_BtnCadPro", "CommandButton")
1424:         WITH loc_oCnt.cmd_4c_BtnCadPro
1425:             .Left            = 39
1426:             .Top             = 0
1427:             .Width           = 100
1428:             .Height          = 40
1429:             .FontName        = "Tahoma"
1430:             .FontBold        = .T.
1431:             .FontItalic      = .T.
1432:             .FontSize        = 7
1433:             .WordWrap        = .T.
1434:             .ForeColor       = RGB(90, 90, 90)
1435:             .BackColor       = RGB(255, 255, 255)
1436:             .Themes          = .T.
1437:             .PicturePosition = 1
1438:             .MousePointer    = 15
1439:             .Caption         = "Ca\<dastro de Produtos"
1440:             .ToolTipText     = "Cadastro de Produtos"
1441:             .Picture         = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
1442:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
1443:         ENDWITH
1444:         BINDEVENT(loc_oCnt.cmd_4c_BtnCadPro, "Click", THIS, "BtnCadProClick")
1445: 
1446:         loc_oCnt.AddObject("cmd_4c_BtnPApaga", "CommandButton")
1447:         WITH loc_oCnt.cmd_4c_BtnPApaga
1448:             .Left            = 139
1449:             .Top             = 0
1450:             .Width           = 100
1451:             .Height          = 40
1452:             .FontName        = "Tahoma"
1453:             .FontBold        = .T.
1454:             .FontItalic      = .T.
1455:             .FontSize        = 7
1456:             .WordWrap        = .T.
1457:             .ForeColor       = RGB(90, 90, 90)
1458:             .BackColor       = RGB(255, 255, 255)
1459:             .Themes          = .T.
1460:             .PicturePosition = 1
1461:             .MousePointer    = 15
1462:             .Caption         = "E\<xclus" + CHR(227) + "o de Produtos"
1463:             .ToolTipText     = "Apagar Produto da Grade"
1464:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1465:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1466:         ENDWITH
1467:         BINDEVENT(loc_oCnt.cmd_4c_BtnPApaga, "Click", THIS, "BtnPApagaClick")
1468: 
1469:         loc_oCnt.AddObject("cmd_4c_BtnCompos", "CommandButton")
1470:         WITH loc_oCnt.cmd_4c_BtnCompos
1471:             .Left            = 239
1472:             .Top             = 0
1473:             .Width           = 100
1474:             .Height          = 40
1475:             .FontName        = "Tahoma"
1476:             .FontBold        = .T.
1477:             .FontItalic      = .T.
1478:             .FontSize        = 7
1479:             .WordWrap        = .T.
1480:             .ForeColor       = RGB(90, 90, 90)
1481:             .BackColor       = RGB(255, 255, 255)
1482:             .Themes          = .T.
1483:             .PicturePosition = 1
1484:             .MousePointer    = 15
1485:             .Caption         = "Carregar Compo\<si" + CHR(231) + CHR(227) + "o"
1486:             .ToolTipText     = "Componentes"
1487:             .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
1488:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
1489:         ENDWITH
1490:         BINDEVENT(loc_oCnt.cmd_4c_BtnCompos, "Click", THIS, "BtnComposClick")
1491: 
1492:         loc_oCnt.AddObject("cmd_4c_BtnAltPrecos", "CommandButton")
1493:         WITH loc_oCnt.cmd_4c_BtnAltPrecos
1494:             .Left            = 339
1495:             .Top             = 0
1496:             .Width           = 100
1497:             .Height          = 40
1498:             .FontName        = "Tahoma"
1499:             .FontBold        = .T.
1500:             .FontItalic      = .T.
1501:             .FontSize        = 7
1502:             .WordWrap        = .T.
1503:             .ForeColor       = RGB(90, 90, 90)
1504:             .BackColor       = RGB(255, 255, 255)
1505:             .Themes          = .T.
1506:             .PicturePosition = 1
1507:             .MousePointer    = 15
1508:             .Caption         = "Al\<tera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
1509:             .ToolTipText     = "Alterar Pre" + CHR(231) + "os"
1510:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1511:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1512:         ENDWITH
1513:         BINDEVENT(loc_oCnt.cmd_4c_BtnAltPrecos, "Click", THIS, "BtnAltPrecosClick")
1514: 
1515:         loc_oCnt.AddObject("cmd_4c_BtnPBuscas", "CommandButton")
1516:         WITH loc_oCnt.cmd_4c_BtnPBuscas
1517:             .Left            = 439
1518:             .Top             = 0
1519:             .Width           = 100
1520:             .Height          = 40
1521:             .FontName        = "Tahoma"
1522:             .FontBold        = .T.
1523:             .FontItalic      = .T.
1524:             .FontSize        = 7
1525:             .WordWrap        = .T.
1526:             .ForeColor       = RGB(90, 90, 90)
1527:             .BackColor       = RGB(255, 255, 255)
1528:             .Themes          = .T.
1529:             .PicturePosition = 1
1530:             .MousePointer    = 15
1531:             .Caption         = "Proc\<ura de Produtos"
1532:             .ToolTipText     = "Procurar Produtos"
1533:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
1534:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
1535:         ENDWITH
1536:         BINDEVENT(loc_oCnt.cmd_4c_BtnPBuscas, "Click", THIS, "BtnPBuscasClick")
1537: 
1538:         loc_oCnt.AddObject("cmd_4c_BtnPedido", "CommandButton")
1539:         WITH loc_oCnt.cmd_4c_BtnPedido
1540:             .Left            = 539
1541:             .Top             = 0
1542:             .Width           = 100
1543:             .Height          = 40
1544:             .FontName        = "Tahoma"
1545:             .FontBold        = .T.
1546:             .FontItalic      = .T.
1547:             .FontSize        = 7
1548:             .WordWrap        = .T.
1549:             .ForeColor       = RGB(90, 90, 90)
1550:             .BackColor       = RGB(255, 255, 255)
1551:             .Themes          = .T.
1552:             .PicturePosition = 1
1553:             .MousePointer    = 15
1554:             .Caption         = "Informar Pedido"
1555:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
1556:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
1557:         ENDWITH
1558:         BINDEVENT(loc_oCnt.cmd_4c_BtnPedido, "Click", THIS, "BtnPedidoClick")
1559: 
1560:         loc_oCnt.AddObject("cmd_4c_Btnsubcp", "CommandButton")
1561:         WITH loc_oCnt.cmd_4c_Btnsubcp
1562:             .Left            = 639
1563:             .Top             = 0
1564:             .Width           = 100
1565:             .Height          = 40
1566:             .FontName        = "Tahoma"
1567:             .FontBold        = .T.
1568:             .FontItalic      = .T.
1569:             .FontSize        = 7
1570:             .WordWrap        = .T.
1571:             .ForeColor       = RGB(90, 90, 90)
1572:             .BackColor       = RGB(255, 255, 255)
1573:             .Themes          = .T.
1574:             .PicturePosition = 1
1575:             .MousePointer    = 15
1576:             .Caption         = "\<Substituir Composi" + CHR(231) + CHR(227) + "o"
1577:             .ToolTipText     = "Componentes"
1578:             .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
1579:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
1580:         ENDWITH
1581:         BINDEVENT(loc_oCnt.cmd_4c_Btnsubcp, "Click", THIS, "BtnsubcpClick")
1582: 
1583:         loc_oCnt.AddObject("cmd_4c_BtnDet", "CommandButton")
1584:         WITH loc_oCnt.cmd_4c_BtnDet
1585:             .Left            = 639
1586:             .Top             = 0
1587:             .Width           = 100
1588:             .Height          = 40
1589:             .FontName        = "Tahoma"
1590:             .FontBold        = .T.
1591:             .FontItalic      = .T.
1592:             .FontSize        = 7
1593:             .ForeColor       = RGB(90, 90, 90)
1594:             .BackColor       = RGB(255, 255, 255)
1595:             .Themes          = .T.
1596:             .PicturePosition = 1
1597:             .MousePointer    = 15
1598:             .Caption         = "Detalhes"
1599:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1600:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1601:         ENDWITH
1602:         BINDEVENT(loc_oCnt.cmd_4c_BtnDet, "Click", THIS, "BtnDetClick")
1603: 
1604:         *-- cmd_4c_BtnOptFin e cmd_4c_BtnDesc ocupam o MESMO Left=746 no SCX legado
1605:         *-- (feature mutuamente exclusiva por configuracao da operacao) -
1606:         *-- transcrito literal do dump, sem inventar posicao nova.
1607:         loc_oCnt.AddObject("cmd_4c_BtnOptFin", "CommandButton")
1608:         WITH loc_oCnt.cmd_4c_BtnOptFin
1609:             .Left            = 739
1610:             .Top             = 0
1611:             .Width           = 100
1612:             .Height          = 40
1613:             .FontName        = "Tahoma"
1614:             .FontBold        = .T.
1615:             .FontItalic      = .T.
1616:             .FontSize        = 7
1617:             .ForeColor       = RGB(90, 90, 90)
1618:             .BackColor       = RGB(255, 255, 255)
1619:             .Themes          = .T.
1620:             .PicturePosition = 1
1621:             .MousePointer    = 15
1622:             .Caption         = "Finalidade"
1623:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
1624:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1625:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1626:         ENDWITH
1627:         BINDEVENT(loc_oCnt.cmd_4c_BtnOptFin, "Click", THIS, "BtnOptFinClick")
1628: 
1629:         loc_oCnt.AddObject("cmd_4c_BtnDesc", "CommandButton")
1630:         WITH loc_oCnt.cmd_4c_BtnDesc
1631:             .Left            = 739
1632:             .Top             = 0
1633:             .Width           = 100
1634:             .Height          = 40
1635:             .FontName        = "Tahoma"
1636:             .FontBold        = .T.
1637:             .FontItalic      = .T.
1638:             .FontSize        = 7
1639:             .ForeColor       = RGB(90, 90, 90)
1640:             .BackColor       = RGB(255, 255, 255)
1641:             .Themes          = .T.
1642:             .PicturePosition = 1
1643:             .MousePointer    = 15
1644:             .Caption         = "Descontos"
1645:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
1646:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1647:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1648:         ENDWITH
1649:         BINDEVENT(loc_oCnt.cmd_4c_BtnDesc, "Click", THIS, "BtnDescClick")
1650: 
1651:         loc_oCnt.AddObject("cmd_4c_BtnLocDes", "CommandButton")
1652:         WITH loc_oCnt.cmd_4c_BtnLocDes
1653:             .Left            = 839
1654:             .Top             = 0
1655:             .Width           = 100
1656:             .Height          = 40
1657:             .FontName        = "Tahoma"
1658:             .FontBold        = .T.
1659:             .FontItalic      = .T.
1660:             .FontSize        = 7
1661:             .ForeColor       = RGB(90, 90, 90)
1662:             .BackColor       = RGB(255, 255, 255)
1663:             .Themes          = .T.
1664:             .PicturePosition = 1
1665:             .MousePointer    = 15
1666:             .Caption         = "Local. Destino"
1667:             .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Destino do Produto"
1668:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1669:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1670:         ENDWITH
1671:         BINDEVENT(loc_oCnt.cmd_4c_BtnLocDes, "Click", THIS, "BtnLocDesClick")
1672: 
1673:         loc_oCnt.AddObject("cmd_4c_BtnLocOri", "CommandButton")
1674:         WITH loc_oCnt.cmd_4c_BtnLocOri
1675:             .Left            = 939
1676:             .Top             = 0
1677:             .Width           = 100
1678:             .Height          = 40
1679:             .FontName        = "Tahoma"
1680:             .FontBold        = .T.
1681:             .FontItalic      = .T.
1682:             .FontSize        = 7
1683:             .ForeColor       = RGB(90, 90, 90)
1684:             .BackColor       = RGB(255, 255, 255)
1685:             .Themes          = .T.
1686:             .PicturePosition = 1
1687:             .MousePointer    = 15
1688:             .Caption         = "Local. Origem"
1689:             .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Origem do Produto"
1690:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1691:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1692:         ENDWITH
1693:         BINDEVENT(loc_oCnt.cmd_4c_BtnLocOri, "Click", THIS, "BtnLocOriClick")
1694:     ENDPROC
1695: 
1696:     *==========================================================================
1697:     * ReaplicarVisibilidadeInicial - TornarControlesVisiveis forca Visible=.T.
1698:     * em tudo; aqui escondemos de volta os botoes que o SCX legado declara
1699:     * Visible=.F. por padrao (toggle condicional a configuracao da operacao,
1700:     * ainda nao conectada nesta fase).
1701:     *==========================================================================
1702:     PROTECTED PROCEDURE ReaplicarVisibilidadeInicial()
1703:         THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Visible    = .F.
1704:         THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Visible      = .F.
1705:         THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Visible     = .F.
1706:         THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Visible     = .F.
1707:         THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Visible     = .F.
1708:         THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Visible    = .F.
1709:         THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Visible     = .F.
1710:         THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Visible    = .F.
1711:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Visible  = .F.
1712:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Visible     = .F.
1713: 
1714:         *-- Page1 (pgProds): controles que o SCX legado declara Visible = .F.
1715:         WITH THIS.pgf_4c_Paginas.Page1
1716:             .cnt_4c_Obs.Visible        = .F.
1717:             .img_4c_ImgProds.Visible   = .F.
1718:             .txt_4c_Valors.Visible     = .F.
1719:             .lbl_4c_LblValors.Visible  = .F.
1720:             .txt_4c_CodCors.Visible    = .F.
1721:             .lbl_4c_LblCodCors.Visible = .F.
1722:             .txt_4c_CodTams.Visible    = .F.
1723:             .lbl_4c_LblCodTams.Visible = .F.
1724:             .txt_4c_GerDIfors.Visible  = .F.
1725:             .lbl_4c_Label15.Visible    = .F.
1726:         ENDWITH
1727: 
1728:         *-- Page4 (pgPrecos): a grade de precificacao nasce oculta no legado.
1729:         *-- Mesmo nome do grid principal (eh o que o mapeamento do form manda),
1730:         *-- mas outro PAI - o caminho completo nao deixa ambiguidade.

*-- Linhas 1747 a 1776:
1747:         loc_lTemLinha = USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") ;
1748:                         AND RECCOUNT("cursor_4c_Itens") > 0
1749: 
1750:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCadPro.Enabled    = loc_lEdicao AND loc_lTemLinha
1751:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPApaga.Enabled    = loc_lEdicao AND loc_lTemLinha
1752:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCompos.Enabled    = loc_lEdicao AND loc_lTemLinha
1753:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnAltPrecos.Enabled = loc_lEdicao AND loc_lTemLinha
1754:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPedido.Enabled    = loc_lEdicao AND loc_lTemLinha
1755:         THIS.cnt_4c_BotoesAcao.cmd_4c_Btnsubcp.Enabled     = loc_lTemLinha
1756:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Enabled       = loc_lTemLinha
1757:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnOptFin.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1758:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDesc.Enabled      = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1759:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocOri.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1760:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1761:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled   = .T.
1762: 
1763:         THIS.cnt_4c_Botoes.cmd_4c_BtnIteSub.Enabled    = loc_lEdicao
1764:         THIS.cnt_4c_Botoes.cmd_4c_CmdXml.Enabled       = loc_lEdicao
1765:         THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Enabled  = loc_lEdicao
1766:         THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Enabled  = loc_lEdicao
1767:         THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Enabled   = loc_lEdicao
1768:         THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Enabled   = loc_lEdicao AND loc_lTemLinha
1769:         THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Enabled   = loc_lTemLinha
1770:         THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Enabled    = loc_lTemLinha
1771:         THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Enabled   = loc_lEdicao
1772:         THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Enabled   = loc_lTemLinha
1773:     ENDPROC
1774: 
1775:     *==========================================================================
1776:     * AlternarPagina - PUBLIC (chamado de fora pelo TesteAutomatico e pelo

*-- Linhas 1922 a 1934:
1922:         GO TOP
1923: 
1924:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1925:             *-- Reinstala os CheckBox de coluna antes de repintar: se algo
1926:             *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
1927:             *-- alias, os objetos postos nas Columns foram destruidos. A
1928:             *-- instalacao eh idempotente.
1929:             THIS.InstalarCheckBoxesGrade()
1930:             THIS.grd_4c_Dados.Refresh()
1931:         ENDIF
1932:     ENDPROC
1933: 
1934:     *==========================================================================

*-- Linhas 1964 a 1973:
1964:     *==========================================================================
1965:     * AplicarModoNaGrade - Espelha o par fwGrade/fwGradeR do legado. No legado sao
1966:     * duas grades mutuamente exclusivas sobre o MESMO cursor, e o proprio
1967:     * legado alinha a segunda na posicao da primeira (".Left = fwGrade.Left /
1968:     * .Top = fwGrade.Top / .Height = fwGrade.Height"), isto eh: visualmente
1969:     * eh UMA grade que alterna entre editavel e somente-leitura.
1970:     *
1971:     * Legado: fwGrade  (editavel)      -> INSERIR, ou ALTERAR com AltEtiqs # 1
1972:     *         fwGradeR (somente-leit.) -> EXCLUIR/CONSULTAR, ou ALTERAR com
1973:     *                                     AltEtiqs = 1

*-- Linhas 2860 a 2881:
2860:         *-- cnt_4c_Obs (cntObs no legado) - painel flutuante da observacao ---
2861:         loc_oPag.AddObject("cnt_4c_Obs", "Container")
2862:         WITH loc_oPag.cnt_4c_Obs
2863:             .Top         = 1
2864:             .Left        = 194
2865:             .Width       = 792
2866:             .Height      = 171
2867:             .BackStyle   = 1
2868:             .BackColor   = RGB(255, 255, 255)
2869:             .BorderWidth = 0
2870:             .Visible     = .F.
2871:         ENDWITH
2872: 
2873:         loc_oPag.cnt_4c_Obs.AddObject("obj_4c_GetObs", "EditBox")
2874:         WITH loc_oPag.cnt_4c_Obs.obj_4c_GetObs
2875:             .Top           = 4
2876:             .Left          = 2
2877:             .Width         = 788
2878:             .Height        = 163
2879:             .FontName      = "Tahoma"
2880:             .FontSize      = 8
2881:             .SpecialEffect = 1

*-- Linhas 2887 a 2938:
2887:         *-- shp_4c_Shape4 - moldura da area da imagem do produto -------------
2888:         loc_oPag.AddObject("shp_4c_Shape4", "Shape")
2889:         WITH loc_oPag.shp_4c_Shape4
2890:             .Top           = 2
2891:             .Left          = 2
2892:             .Width         = 192
2893:             .Height        = 167
2894:             .BackStyle     = 0
2895:             .BorderWidth   = 2
2896:             .SpecialEffect = 0
2897:             .Visible       = .T.
2898:         ENDWITH
2899: 
2900:         *-- shp_4c_Shape1 - moldura do bloco "Procurar" ----------------------
2901:         loc_oPag.AddObject("shp_4c_Shape1", "Shape")
2902:         WITH loc_oPag.shp_4c_Shape1
2903:             .Top           = 130
2904:             .Left          = 660
2905:             .Width         = 286
2906:             .Height        = 35
2907:             .BackStyle     = 0
2908:             .BorderWidth   = 2
2909:             .SpecialEffect = 0
2910:             .Visible       = .T.
2911:         ENDWITH
2912: 
2913:         *-- Descricao do produto (editavel so com AltDescs = 1) --------------
2914:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
2915:         WITH loc_oPag.lbl_4c_Label2
2916:             .Top       = 2
2917:             .Left      = 202
2918:             .Width     = 60
2919:             .Height    = 15
2920:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
2921:             .FontName  = "Tahoma"
2922:             .FontSize  = 8
2923:             .AutoSize  = .F.
2924:             .Alignment = 0
2925:             .BackStyle = 0
2926:             .ForeColor = RGB(90, 90, 90)
2927:             .Visible   = .T.
2928:         ENDWITH
2929: 
2930:         loc_oPag.AddObject("txt_4c_DPros", "TextBox")
2931:         WITH loc_oPag.txt_4c_DPros
2932:             .Top               = 14
2933:             .Left              = 202
2934:             .Width             = 288
2935:             .Height            = 21
2936:             .FontName          = "Courier New"
2937:             .FontSize          = 8
2938:             .Format            = "K!"

*-- Linhas 2949 a 2976:
2949:         ENDWITH
2950: 
2951:         *-- Preco atual (exibicao - vem de SigCdPro, nao eh coluna do item) --
2952:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
2953:         WITH loc_oPag.lbl_4c_Label1
2954:             .Top       = 72
2955:             .Left      = 202
2956:             .Width     = 60
2957:             .Height    = 15
2958:             .Caption   = "Pre" + CHR(231) + "o Atual"
2959:             .FontName  = "Tahoma"
2960:             .FontSize  = 8
2961:             .AutoSize  = .F.
2962:             .Alignment = 0
2963:             .BackStyle = 0
2964:             .ForeColor = RGB(90, 90, 90)
2965:             .Visible   = .T.
2966:         ENDWITH
2967: 
2968:         loc_oPag.AddObject("txt_4c_PVens", "TextBox")
2969:         WITH loc_oPag.txt_4c_PVens
2970:             .Top               = 84
2971:             .Left              = 202
2972:             .Width             = 100
2973:             .Height            = 21
2974:             .FontName          = "Courier New"
2975:             .FontSize          = 8
2976:             .Alignment         = 3

*-- Linhas 2986 a 3013:
2986:         ENDWITH
2987: 
2988:         *-- Valor pago (invisivel no legado) ---------------------------------
2989:         loc_oPag.AddObject("lbl_4c_LblValors", "Label")
2990:         WITH loc_oPag.lbl_4c_LblValors
2991:             .Top       = 72
2992:             .Left      = 664
2993:             .Width     = 53
2994:             .Height    = 15
2995:             .Caption   = "Valor Pago"
2996:             .FontName  = "Tahoma"
2997:             .FontSize  = 8
2998:             .AutoSize  = .F.
2999:             .Alignment = 0
3000:             .BackStyle = 0
3001:             .ForeColor = RGB(90, 90, 90)
3002:             .Visible   = .F.
3003:         ENDWITH
3004: 
3005:         loc_oPag.AddObject("txt_4c_Valors", "TextBox")
3006:         WITH loc_oPag.txt_4c_Valors
3007:             .Top           = 84
3008:             .Left          = 664
3009:             .Width         = 98
3010:             .Height        = 21
3011:             .FontName      = "Courier New"
3012:             .FontSize      = 8
3013:             .Value         = 0

*-- Linhas 3022 a 3049:
3022:         ENDWITH
3023: 
3024:         *-- Observacao do item (abre o painel flutuante cnt_4c_Obs no Click) -
3025:         loc_oPag.AddObject("lbl_4c_LblObs", "Label")
3026:         WITH loc_oPag.lbl_4c_LblObs
3027:             .Top       = 36
3028:             .Left      = 462
3029:             .Width     = 115
3030:             .Height    = 15
3031:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
3032:             .FontName  = "Tahoma"
3033:             .FontSize  = 8
3034:             .AutoSize  = .F.
3035:             .Alignment = 0
3036:             .BackStyle = 0
3037:             .ForeColor = RGB(90, 90, 90)
3038:             .Visible   = .T.
3039:         ENDWITH
3040: 
3041:         loc_oPag.AddObject("obj_4c_GetObs", "EditBox")
3042:         WITH loc_oPag.obj_4c_GetObs
3043:             .Top           = 49
3044:             .Left          = 462
3045:             .Width         = 392
3046:             .Height        = 21
3047:             .FontName      = "Courier New"
3048:             .FontSize      = 8
3049:             .Margin        = 2

*-- Linhas 3056 a 3083:
3056:         ENDWITH
3057: 
3058:         *-- Codigo de barras do item (somente leitura) -----------------------
3059:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
3060:         WITH loc_oPag.lbl_4c_Label5
3061:             .Top       = 36
3062:             .Left      = 202
3063:             .Width     = 35
3064:             .Height    = 15
3065:             .Caption   = "Barra"
3066:             .FontName  = "Tahoma"
3067:             .FontSize  = 8
3068:             .AutoSize  = .F.
3069:             .Alignment = 0
3070:             .BackStyle = 0
3071:             .ForeColor = RGB(90, 90, 90)
3072:             .Visible   = .T.
3073:         ENDWITH
3074: 
3075:         loc_oPag.AddObject("txt_4c_Barras", "TextBox")
3076:         WITH loc_oPag.txt_4c_Barras
3077:             .Top               = 49
3078:             .Left              = 202
3079:             .Width             = 108
3080:             .Height            = 21
3081:             .FontName          = "Courier New"
3082:             .FontSize          = 8
3083:             .Alignment         = 3

*-- Linhas 3092 a 3119:
3092:         ENDWITH
3093: 
3094:         *-- Documento (notas) ------------------------------------------------
3095:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
3096:         WITH loc_oPag.lbl_4c_Label7
3097:             .Top       = 36
3098:             .Left      = 311
3099:             .Width     = 56
3100:             .Height    = 15
3101:             .Caption   = "Documento"
3102:             .FontName  = "Tahoma"
3103:             .FontSize  = 8
3104:             .AutoSize  = .F.
3105:             .Alignment = 0
3106:             .BackStyle = 0
3107:             .ForeColor = RGB(90, 90, 90)
3108:             .Visible   = .T.
3109:         ENDWITH
3110: 
3111:         loc_oPag.AddObject("txt_4c_Docs", "TextBox")
3112:         WITH loc_oPag.txt_4c_Docs
3113:             .Top               = 49
3114:             .Left              = 311
3115:             .Width             = 67
3116:             .Height            = 21
3117:             .FontName          = "Courier New"
3118:             .FontSize          = 8
3119:             .Alignment         = 3

*-- Linhas 3129 a 3156:
3129:         ENDWITH
3130: 
3131:         *-- Numero do lote ---------------------------------------------------
3132:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
3133:         WITH loc_oPag.lbl_4c_Label8
3134:             .Top       = 36
3135:             .Left      = 380
3136:             .Width     = 63
3137:             .Height    = 15
3138:             .Caption   = "N" + CHR(250) + "mero Lote"
3139:             .FontName  = "Tahoma"
3140:             .FontSize  = 8
3141:             .AutoSize  = .F.
3142:             .Alignment = 0
3143:             .BackStyle = 0
3144:             .ForeColor = RGB(90, 90, 90)
3145:             .Visible   = .T.
3146:         ENDWITH
3147: 
3148:         loc_oPag.AddObject("txt_4c_Lotes", "TextBox")
3149:         WITH loc_oPag.txt_4c_Lotes
3150:             .Top               = 49
3151:             .Left              = 380
3152:             .Width             = 80
3153:             .Height            = 21
3154:             .FontName          = "Courier New"
3155:             .FontSize          = 8
3156:             .Alignment         = 3

*-- Linhas 3168 a 3177:
3168:         *-- Moeda do preco atual ---------------------------------------------
3169:         loc_oPag.AddObject("txt_4c_MoeVs", "TextBox")
3170:         WITH loc_oPag.txt_4c_MoeVs
3171:             .Top               = 84
3172:             .Left              = 303
3173:             .Width             = 31
3174:             .Height            = 21
3175:             .FontName          = "Tahoma"
3176:             .FontSize          = 8
3177:             .MaxLength         = 3

*-- Linhas 3188 a 3215:
3188:         ENDWITH
3189: 
3190:         *-- Grupo de venda (exibicao) ----------------------------------------
3191:         loc_oPag.AddObject("lbl_4c_Label11", "Label")
3192:         WITH loc_oPag.lbl_4c_Label11
3193:             .Top       = 2
3194:             .Left      = 491
3195:             .Width     = 80
3196:             .Height    = 15
3197:             .Caption   = "Grupo de Venda"
3198:             .FontName  = "Tahoma"
3199:             .FontSize  = 8
3200:             .AutoSize  = .F.
3201:             .Alignment = 0
3202:             .BackStyle = 0
3203:             .ForeColor = RGB(90, 90, 90)
3204:             .Visible   = .T.
3205:         ENDWITH
3206: 
3207:         loc_oPag.AddObject("txt_4c_GVendas", "TextBox")
3208:         WITH loc_oPag.txt_4c_GVendas
3209:             .Top               = 14
3210:             .Left              = 491
3211:             .Width             = 261
3212:             .Height            = 21
3213:             .FontName          = "Courier New"
3214:             .FontSize          = 8
3215:             .Alignment         = 3

*-- Linhas 3225 a 3253:
3225:         ENDWITH
3226: 
3227:         *-- Desconto em valor ------------------------------------------------
3228:         loc_oPag.AddObject("lbl_4c_LblVDescs", "Label")
3229:         WITH loc_oPag.lbl_4c_LblVDescs
3230:             .Top       = 72
3231:             .Left      = 487
3232:             .Width     = 74
3233:             .Height    = 15
3234:             .Caption   = "Valor Desconto"
3235:             .FontName  = "Tahoma"
3236:             .FontSize  = 8
3237:             .FontBold  = .F.
3238:             .AutoSize  = .F.
3239:             .Alignment = 0
3240:             .BackStyle = 0
3241:             .ForeColor = RGB(90, 90, 90)
3242:             .Visible   = .T.
3243:         ENDWITH
3244: 
3245:         loc_oPag.AddObject("txt_4c_VDescs", "TextBox")
3246:         WITH loc_oPag.txt_4c_VDescs
3247:             .Top               = 84
3248:             .Left              = 487
3249:             .Width             = 92
3250:             .Height            = 21
3251:             .FontName          = "Courier New"
3252:             .FontSize          = 8
3253:             .Alignment         = 3

*-- Linhas 3262 a 3290:
3262:         ENDWITH
3263: 
3264:         *-- Desconto em percentual -------------------------------------------
3265:         loc_oPag.AddObject("lbl_4c_LblPDescs", "Label")
3266:         WITH loc_oPag.lbl_4c_LblPDescs
3267:             .Top       = 72
3268:             .Left      = 581
3269:             .Width     = 61
3270:             .Height    = 15
3271:             .Caption   = "% Desconto"
3272:             .FontName  = "Tahoma"
3273:             .FontSize  = 8
3274:             .FontBold  = .F.
3275:             .AutoSize  = .F.
3276:             .Alignment = 0
3277:             .BackStyle = 0
3278:             .ForeColor = RGB(90, 90, 90)
3279:             .Visible   = .T.
3280:         ENDWITH
3281: 
3282:         loc_oPag.AddObject("txt_4c_PDescs", "TextBox")
3283:         WITH loc_oPag.txt_4c_PDescs
3284:             .Top               = 84
3285:             .Left              = 581
3286:             .Width             = 79
3287:             .Height            = 21
3288:             .FontName          = "Courier New"
3289:             .FontSize          = 8
3290:             .Alignment         = 3

*-- Linhas 3301 a 3310:
3301:         *-- Observacoes do pedido (exibicao) ---------------------------------
3302:         loc_oPag.AddObject("obj_4c_GetObsPes", "EditBox")
3303:         WITH loc_oPag.obj_4c_GetObsPes
3304:             .Top           = 107
3305:             .Left          = 202
3306:             .Width         = 200
3307:             .Height        = 21
3308:             .FontName      = "Courier New"
3309:             .FontSize      = 8
3310:             .Margin        = 2

*-- Linhas 3318 a 3327:
3318: 
3319:         loc_oPag.AddObject("obj_4c_GetObsPeds", "EditBox")
3320:         WITH loc_oPag.obj_4c_GetObsPeds
3321:             .Top           = 107
3322:             .Left          = 404
3323:             .Width         = 200
3324:             .Height        = 21
3325:             .FontName      = "Courier New"
3326:             .FontSize      = 8
3327:             .Margin        = 2

*-- Linhas 3334 a 3361:
3334:         ENDWITH
3335: 
3336:         *-- Cor e Tamanho (nascem invisiveis, como no legado) ----------------
3337:         loc_oPag.AddObject("lbl_4c_LblCodCors", "Label")
3338:         WITH loc_oPag.lbl_4c_LblCodCors
3339:             .Top       = 2
3340:             .Left      = 753
3341:             .Width     = 19
3342:             .Height    = 15
3343:             .Caption   = "Cor"
3344:             .FontName  = "Tahoma"
3345:             .FontSize  = 8
3346:             .AutoSize  = .F.
3347:             .Alignment = 0
3348:             .BackStyle = 0
3349:             .ForeColor = RGB(90, 90, 90)
3350:             .Visible   = .F.
3351:         ENDWITH
3352: 
3353:         loc_oPag.AddObject("txt_4c_CodCors", "TextBox")
3354:         WITH loc_oPag.txt_4c_CodCors
3355:             .Top           = 14
3356:             .Left          = 753
3357:             .Width         = 36
3358:             .Height        = 21
3359:             .FontName      = "Courier New"
3360:             .FontSize      = 8
3361:             .Alignment     = 3

*-- Linhas 3368 a 3395:
3368:             .Visible       = .F.
3369:         ENDWITH
3370: 
3371:         loc_oPag.AddObject("lbl_4c_LblCodTams", "Label")
3372:         WITH loc_oPag.lbl_4c_LblCodTams
3373:             .Top       = 2
3374:             .Left      = 790
3375:             .Width     = 22
3376:             .Height    = 15
3377:             .Caption   = "Tam"
3378:             .FontName  = "Tahoma"
3379:             .FontSize  = 8
3380:             .AutoSize  = .F.
3381:             .Alignment = 0
3382:             .BackStyle = 0
3383:             .ForeColor = RGB(90, 90, 90)
3384:             .Visible   = .F.
3385:         ENDWITH
3386: 
3387:         loc_oPag.AddObject("txt_4c_CodTams", "TextBox")
3388:         WITH loc_oPag.txt_4c_CodTams
3389:             .Top           = 14
3390:             .Left          = 790
3391:             .Width         = 36
3392:             .Height        = 21
3393:             .FontName      = "Courier New"
3394:             .FontSize      = 8
3395:             .Alignment     = 3

*-- Linhas 3405 a 3442:
3405:         *-- cnt_4c_Reffs - referencia do fornecedor (exibicao) ---------------
3406:         loc_oPag.AddObject("cnt_4c_Reffs", "Container")
3407:         WITH loc_oPag.cnt_4c_Reffs
3408:             .Top         = 66
3409:             .Left        = 332
3410:             .Width       = 154
3411:             .Height      = 41
3412:             .BackStyle   = 0
3413:             .BorderWidth = 0
3414:             .BorderColor = RGB(36, 84, 155)
3415:             .Visible     = .T.
3416:         ENDWITH
3417: 
3418:         loc_oPag.cnt_4c_Reffs.AddObject("lbl_4c_LblReffs", "Label")
3419:         WITH loc_oPag.cnt_4c_Reffs.lbl_4c_LblReffs
3420:             .Top       = 5
3421:             .Left      = 3
3422:             .Width     = 130
3423:             .Height    = 15
3424:             .Caption   = "Refer" + CHR(234) + "ncia do Fornecedor"
3425:             .FontName  = "Tahoma"
3426:             .FontSize  = 8
3427:             .AutoSize  = .F.
3428:             .Alignment = 0
3429:             .BackStyle = 0
3430:             .ForeColor = RGB(90, 90, 90)
3431:             .Visible   = .T.
3432:         ENDWITH
3433: 
3434:         loc_oPag.cnt_4c_Reffs.AddObject("txt_4c_Reffs", "TextBox")
3435:         WITH loc_oPag.cnt_4c_Reffs.txt_4c_Reffs
3436:             .Top               = 18
3437:             .Left              = 3
3438:             .Width             = 150
3439:             .Height            = 21
3440:             .FontName          = "Tahoma"
3441:             .FontSize          = 8
3442:             .Value             = ""

*-- Linhas 3453 a 3480:
3453:         ENDWITH
3454: 
3455:         *-- Saldo / Baixa / Resta / Peso medio -------------------------------
3456:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
3457:         WITH loc_oPag.lbl_4c_Label4
3458:             .Top       = 72
3459:             .Left      = 765
3460:             .Width     = 35
3461:             .Height    = 15
3462:             .Caption   = "Saldo"
3463:             .FontName  = "Tahoma"
3464:             .FontSize  = 8
3465:             .AutoSize  = .F.
3466:             .Alignment = 0
3467:             .BackStyle = 0
3468:             .ForeColor = RGB(90, 90, 90)
3469:             .Visible   = .T.
3470:         ENDWITH
3471: 
3472:         loc_oPag.AddObject("txt_4c_Saldo", "TextBox")
3473:         WITH loc_oPag.txt_4c_Saldo
3474:             .Top           = 84
3475:             .Left          = 765
3476:             .Width         = 89
3477:             .Height        = 21
3478:             .FontName      = "Courier New"
3479:             .FontSize      = 8
3480:             .FontBold      = .F.

*-- Linhas 3488 a 3515:
3488:             .Visible       = .T.
3489:         ENDWITH
3490: 
3491:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
3492:         WITH loc_oPag.lbl_4c_Label6
3493:             .Top       = 111
3494:             .Left      = 606
3495:             .Width     = 35
3496:             .Height    = 15
3497:             .Caption   = "Baixa"
3498:             .FontName  = "Tahoma"
3499:             .FontSize  = 8
3500:             .AutoSize  = .F.
3501:             .Alignment = 0
3502:             .BackStyle = 0
3503:             .ForeColor = RGB(90, 90, 90)
3504:             .Visible   = .T.
3505:         ENDWITH
3506: 
3507:         loc_oPag.AddObject("txt_4c_Qtbaixa", "TextBox")
3508:         WITH loc_oPag.txt_4c_Qtbaixa
3509:             .Top           = 107
3510:             .Left          = 640
3511:             .Width         = 89
3512:             .Height        = 21
3513:             .FontName      = "Courier New"
3514:             .FontSize      = 8
3515:             .FontBold      = .F.

*-- Linhas 3522 a 3549:
3522:             .Visible       = .T.
3523:         ENDWITH
3524: 
3525:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
3526:         WITH loc_oPag.lbl_4c_Label9
3527:             .Top       = 112
3528:             .Left      = 729
3529:             .Width     = 35
3530:             .Height    = 15
3531:             .Caption   = "Resta"
3532:             .FontName  = "Tahoma"
3533:             .FontSize  = 8
3534:             .AutoSize  = .F.
3535:             .Alignment = 0
3536:             .BackStyle = 0
3537:             .ForeColor = RGB(90, 90, 90)
3538:             .Visible   = .T.
3539:         ENDWITH
3540: 
3541:         loc_oPag.AddObject("txt_4c_Qtresta", "TextBox")
3542:         WITH loc_oPag.txt_4c_Qtresta
3543:             .Top           = 107
3544:             .Left          = 765
3545:             .Width         = 89
3546:             .Height        = 21
3547:             .FontName      = "Courier New"
3548:             .FontSize      = 8
3549:             .FontBold      = .F.

*-- Linhas 3556 a 3583:
3556:             .Visible       = .T.
3557:         ENDWITH
3558: 
3559:         loc_oPag.AddObject("lbl_4c_Label13", "Label")
3560:         WITH loc_oPag.lbl_4c_Label13
3561:             .Top       = 72
3562:             .Left      = 857
3563:             .Width     = 60
3564:             .Height    = 15
3565:             .Caption   = "Peso M" + CHR(233) + "dio"
3566:             .FontName  = "Tahoma"
3567:             .FontSize  = 8
3568:             .AutoSize  = .F.
3569:             .Alignment = 0
3570:             .BackStyle = 0
3571:             .ForeColor = RGB(90, 90, 90)
3572:             .Visible   = .T.
3573:         ENDWITH
3574: 
3575:         loc_oPag.AddObject("txt_4c_Peso", "TextBox")
3576:         WITH loc_oPag.txt_4c_Peso
3577:             .Top           = 84
3578:             .Left          = 857
3579:             .Width         = 89
3580:             .Height        = 21
3581:             .FontName      = "Courier New"
3582:             .FontSize      = 8
3583:             .FontBold      = .F.

*-- Linhas 3592 a 3619:
3592:         ENDWITH
3593: 
3594:         *-- Conferencia por codigo: Produto + Qtde ---------------------------
3595:         loc_oPag.AddObject("lbl_4c_Label10", "Label")
3596:         WITH loc_oPag.lbl_4c_Label10
3597:             .Top       = 2
3598:             .Left      = 827
3599:             .Width     = 40
3600:             .Height    = 15
3601:             .Caption   = "Produto"
3602:             .FontName  = "Tahoma"
3603:             .FontSize  = 8
3604:             .AutoSize  = .F.
3605:             .Alignment = 0
3606:             .BackStyle = 0
3607:             .ForeColor = RGB(90, 90, 90)
3608:             .Visible   = .T.
3609:         ENDWITH
3610: 
3611:         loc_oPag.AddObject("txt_4c__prod", "TextBox")
3612:         WITH loc_oPag.txt_4c__prod
3613:             .Top               = 14
3614:             .Left              = 827
3615:             .Width             = 123
3616:             .Height            = 21
3617:             .FontName          = "Courier New"
3618:             .FontSize          = 8
3619:             .Alignment         = 3

*-- Linhas 3627 a 3655:
3627:             .Visible           = .T.
3628:         ENDWITH
3629: 
3630:         loc_oPag.AddObject("lbl_4c_Label12", "Label")
3631:         WITH loc_oPag.lbl_4c_Label12
3632:             .Top       = 36
3633:             .Left      = 858
3634:             .Width     = 26
3635:             .Height    = 15
3636:             .Caption   = "Qtde"
3637:             .FontName  = "Tahoma"
3638:             .FontSize  = 8
3639:             .FontBold  = .F.
3640:             .AutoSize  = .F.
3641:             .Alignment = 0
3642:             .BackStyle = 0
3643:             .ForeColor = RGB(90, 90, 90)
3644:             .Visible   = .T.
3645:         ENDWITH
3646: 
3647:         loc_oPag.AddObject("txt_4c__qtd", "TextBox")
3648:         WITH loc_oPag.txt_4c__qtd
3649:             .Top               = 49
3650:             .Left              = 858
3651:             .Width             = 79
3652:             .Height            = 21
3653:             .FontName          = "Courier New"
3654:             .FontSize          = 8
3655:             .Alignment         = 3

*-- Linhas 3666 a 3741:
3666:         *-- Imagem do produto (sobre shp_4c_Shape4; nasce invisivel) ---------
3667:         loc_oPag.AddObject("img_4c_ImgProds", "Image")
3668:         WITH loc_oPag.img_4c_ImgProds
3669:             .Top         = 4
3670:             .Left        = 4
3671:             .Width       = 188
3672:             .Height      = 163
3673:             .Stretch     = 1
3674:             .ToolTipText = "Imagem do Produto [Duplo Click Para Zoom]"
3675:             .Visible     = .F.
3676:         ENDWITH
3677: 
3678:         *-- Bloco "Procurar" (obj_4c_Opt_Busca + txt_4c_Busca) ---------------
3679:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
3680:         WITH loc_oPag.lbl_4c_Label3
3681:             .Top       = 140
3682:             .Left      = 675
3683:             .Width     = 43
3684:             .Height    = 15
3685:             .Caption   = "Procurar"
3686:             .FontName  = "Tahoma"
3687:             .FontSize  = 8
3688:             .AutoSize  = .F.
3689:             .Alignment = 0
3690:             .BackStyle = 0
3691:             .ForeColor = RGB(90, 90, 90)
3692:             .Visible   = .T.
3693:         ENDWITH
3694: 
3695:         loc_oPag.AddObject("obj_4c_Opt_Busca", "OptionGroup")
3696:         WITH loc_oPag.obj_4c_Opt_Busca
3697:             .Top         = 135
3698:             .Left        = 713
3699:             .Width       = 119
3700:             .Height      = 25
3701:             .ButtonCount = 2
3702:             .BackStyle   = 0
3703:             .BorderStyle = 0
3704:             .AutoSize    = .F.
3705:             .Value       = 1
3706:             .Visible     = .T.
3707:             WITH .Buttons(1)
3708:                 .Caption   = "Barras"
3709:                 .Top       = 5
3710:                 .Left      = 5
3711:                 .Width     = 49
3712:                 .Height    = 15
3713:                 .FontName  = "Tahoma"
3714:                 .FontSize  = 8
3715:                 .AutoSize  = .F.
3716:                 .BackStyle = 0
3717:                 .ForeColor = RGB(90, 90, 90)
3718:             ENDWITH
3719:             WITH .Buttons(2)
3720:                 .Caption   = "Produto"
3721:                 .Top       = 5
3722:                 .Left      = 58
3723:                 .Width     = 56
3724:                 .Height    = 15
3725:                 .FontName  = "Tahoma"
3726:                 .FontSize  = 8
3727:                 .AutoSize  = .F.
3728:                 .BackStyle = 0
3729:                 .ForeColor = RGB(90, 90, 90)
3730:             ENDWITH
3731:         ENDWITH
3732: 
3733:         loc_oPag.AddObject("txt_4c_Busca", "TextBox")
3734:         WITH loc_oPag.txt_4c_Busca
3735:             .Top               = 136
3736:             .Left              = 830
3737:             .Width             = 108
3738:             .Height            = 23
3739:             .FontName          = "Tahoma"
3740:             .FontSize          = 8
3741:             .Alignment         = 3

*-- Linhas 3752 a 3766:
3752:         ENDWITH
3753: 
3754:         *-- Codigo pai (composicao) e fornecedor -----------------------------
3755:         loc_oPag.AddObject("lbl_4c_Label14", "Label")
3756:         WITH loc_oPag.lbl_4c_Label14
3757:             .Top       = 127
3758:             .Left      = 202
3759:             .Width     = 42
3760:             .Height    = 15
3761:             .Caption   = "Cod. Pai"
3762:             .FontName  = "Tahoma"
3763:             .FontSize  = 8
3764:             .AutoSize  = .F.
3765:             .Alignment = 0
3766:             .BackStyle = 0

*-- Linhas 3775 a 3784:
3775:         *-- com ControlSource em citem2, que eh outra coisa.
3776:         loc_oPag.AddObject("txt_4c_Conjunts", "TextBox")
3777:         WITH loc_oPag.txt_4c_Conjunts
3778:             .Top               = 140
3779:             .Left              = 202
3780:             .Width             = 55
3781:             .Height            = 21
3782:             .FontName          = "Courier New"
3783:             .FontSize          = 8
3784:             .Alignment         = 3

*-- Linhas 3793 a 3820:
3793:             .Visible           = .T.
3794:         ENDWITH
3795: 
3796:         loc_oPag.AddObject("lbl_4c_Label15", "Label")
3797:         WITH loc_oPag.lbl_4c_Label15
3798:             .Top       = 127
3799:             .Left      = 260
3800:             .Width     = 60
3801:             .Height    = 15
3802:             .Caption   = "Fornecedor"
3803:             .FontName  = "Tahoma"
3804:             .FontSize  = 8
3805:             .AutoSize  = .F.
3806:             .Alignment = 0
3807:             .BackStyle = 0
3808:             .ForeColor = RGB(90, 90, 90)
3809:             .Visible   = .F.
3810:         ENDWITH
3811: 
3812:         loc_oPag.AddObject("txt_4c_GerDIfors", "TextBox")
3813:         WITH loc_oPag.txt_4c_GerDIfors
3814:             .Top               = 140
3815:             .Left              = 260
3816:             .Width             = 261
3817:             .Height            = 21
3818:             .FontName          = "Courier New"
3819:             .FontSize          = 8
3820:             .Alignment         = 3

*-- Linhas 3871 a 3880:
3871: 
3872:         loc_oPag.AddObject("cnt_4c_Item", "Container")
3873:         WITH loc_oPag.cnt_4c_Item
3874:             .Top           = -6
3875:             .Left          = 2
3876:             .Width         = 973
3877:             .Height        = 151
3878:             .BackStyle     = 0
3879:             .BorderWidth   = 0
3880:             .SpecialEffect = 2

*-- Linhas 3888 a 3912:
3888:         *-- Moldura do bloco de Importacao -----------------------------------
3889:         loc_oCnt.AddObject("shp_4c_Shape1", "Shape")
3890:         WITH loc_oCnt.shp_4c_Shape1
3891:             .Top         = 63
3892:             .Left        = 802
3893:             .Width       = 163
3894:             .Height      = 84
3895:             .BackStyle   = 0
3896:             .BorderStyle = 1
3897:             .BorderColor = RGB(90, 90, 90)
3898:             .Visible     = .T.
3899:         ENDWITH
3900: 
3901:         *-- Linha 1: produto, descricao, classificacao fiscal e Obs2 ---------
3902:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFCPros", 7, 9, 45, "Produto")
3903: 
3904:         loc_oCnt.AddObject("txt_4c_FCPros", "TextBox")
3905:         WITH loc_oCnt.txt_4c_FCPros
3906:             .Top           = 21
3907:             .Left          = 9
3908:             .Width         = 108
3909:             .Height        = 21
3910:             .FontName      = "Tahoma"
3911:             .FontSize      = 8
3912:             .Format        = "K!"

*-- Linhas 3922 a 3931:
3922: 
3923:         loc_oCnt.AddObject("txt_4c_FDPros", "TextBox")
3924:         WITH loc_oCnt.txt_4c_FDPros
3925:             .Top               = 21
3926:             .Left              = 119
3927:             .Width             = 303
3928:             .Height            = 21
3929:             .FontName          = "Courier New"
3930:             .FontSize          = 8
3931:             .MaxLength         = 65

*-- Linhas 3939 a 3953:
3939:             .Visible           = .T.
3940:         ENDWITH
3941: 
3942:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFClFis", 7, 424, 100, ;
3943:                                   "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
3944: 
3945:         loc_oCnt.AddObject("txt_4c_FClFis", "TextBox")
3946:         WITH loc_oCnt.txt_4c_FClFis
3947:             .Top           = 21
3948:             .Left          = 424
3949:             .Width         = 89
3950:             .Height        = 21
3951:             .FontName      = "Tahoma"
3952:             .FontSize      = 8
3953:             .Value         = ""

*-- Linhas 3963 a 3972:
3963: 
3964:         loc_oCnt.AddObject("txt_4c_FDlFis", "TextBox")
3965:         WITH loc_oCnt.txt_4c_FDlFis
3966:             .Top           = 21
3967:             .Left          = 515
3968:             .Width         = 216
3969:             .Height        = 21
3970:             .FontName      = "Tahoma"
3971:             .FontSize      = 8
3972:             .Value         = ""

*-- Linhas 3978 a 3991:
3978:             .Visible       = .T.
3979:         ENDWITH
3980: 
3981:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label16", 7, 732, 30, "Obs2")
3982: 
3983:         loc_oCnt.AddObject("obj_4c_GetObs", "EditBox")
3984:         WITH loc_oCnt.obj_4c_GetObs
3985:             .Top           = 21
3986:             .Left          = 732
3987:             .Width         = 235
3988:             .Height        = 21
3989:             .FontName      = "Tahoma"
3990:             .FontSize      = 8
3991:             .SpecialEffect = 1

*-- Linhas 3997 a 4035:
3997:         ENDWITH
3998: 
3999:         *-- Linha 2: total, IPI, ICMS, ICMS-ST, situacao tributaria ----------
4000:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFTotal", 48, 10, 35, "Total")
4001:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FTotal", 61, 10, 112, ;
4002:                                     "999,999,999.99", "cursor_4c_Itens.totas")
4003: 
4004:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFPipis", 48, 124, 35, "%IPI")
4005:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FPipis", 61, 124, 48, ;
4006:                                     "99.99", "cursor_4c_Itens.aliqs")
4007: 
4008:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFVipis", 48, 174, 16, "IPI")
4009:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FVipis", 61, 174, 97, ;
4010:                                     "9999,999.99", "cursor_4c_Itens.valipis")
4011: 
4012:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFPIcms", 48, 273, 40, "%ICMS")
4013:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FPIcms", 61, 273, 48, ;
4014:                                     "99.99", "cursor_4c_Itens.aliqicms")
4015: 
4016:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFVIcms", 48, 323, 27, "ICMS")
4017:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FVIcms", 61, 323, 98, ;
4018:                                     "9999,999.99", "cursor_4c_Itens.icms")
4019: 
4020:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFIcmsS", 48, 424, 88, ;
4021:                                   "ICMS Substitui" + CHR(231) + CHR(227) + "o")
4022:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FIcmsS", 61, 424, 96, ;
4023:                                     "9999,999.99", "cursor_4c_Itens.icmss")
4024: 
4025:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label1", 48, 532, 14, "ST")
4026: 
4027:         loc_oCnt.AddObject("txt_4c_SitTrI", "TextBox")
4028:         WITH loc_oCnt.txt_4c_SitTrI
4029:             .Top           = 61
4030:             .Left          = 524
4031:             .Width         = 43
4032:             .Height        = 21
4033:             .FontName      = "Tahoma"
4034:             .FontSize      = 8
4035:             .Alignment     = 3

*-- Linhas 4055 a 4064:
4055: 
4056:         loc_oCnt.AddObject("txt_4c_Cfop", "TextBox")
4057:         WITH loc_oCnt.txt_4c_Cfop
4058:             .Top           = 84
4059:             .Left          = 524
4060:             .Width         = 43
4061:             .Height        = 21
4062:             .FontName      = "Tahoma"
4063:             .FontSize      = 8
4064:             .Alignment     = 3

*-- Linhas 4074 a 4124:
4074:         ENDWITH
4075: 
4076:         *-- Linha 4: base de calculo, PIS, COFINS, ISS, IRRF, INSS, CSSL, II -
4077:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label5", 111, 13, 67, ;
4078:                                   "Base C" + CHR(225) + "lculos")
4079:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VBc", 124, 10, 108, ;
4080:                                     "999,999,999.99", "cursor_4c_Itens.valbases")
4081: 
4082:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label6", 111, 124, 18, "PIS")
4083:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vpis", 124, 121, 95, ;
4084:                                     "999,999.99", "cursor_4c_Itens.vpis")
4085: 
4086:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label9", 111, 221, 40, "COFINS")
4087:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vcof", 124, 218, 95, ;
4088:                                     "999,999.99", "cursor_4c_Itens.vcofins")
4089: 
4090:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label13", 111, 318, 18, "ISS")
4091:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VIss", 124, 315, 95, ;
4092:                                     "999,999.99", "cursor_4c_Itens.iss")
4093: 
4094:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label8", 111, 415, 26, "IRRF")
4095:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VIrrf", 124, 412, 95, ;
4096:                                     "999,999.99", "cursor_4c_Itens.irrf")
4097: 
4098:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label10", 111, 512, 25, "INSS")
4099:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VInss", 124, 509, 95, ;
4100:                                     "999,999.99", "cursor_4c_Itens.inss")
4101: 
4102:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label12", 111, 609, 26, "CSSL")
4103:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VCssl", 124, 606, 95, ;
4104:                                     "999,999.99", "cursor_4c_Itens.cssl")
4105: 
4106:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label11", 111, 706, 10, "II")
4107:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vii", 124, 703, 95, ;
4108:                                     "999,999.99", "cursor_4c_Itens.taxaiis")
4109: 
4110:         *-- Bloco Importacao: os TRES unicos campos digitaveis desta pagina --
4111:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label4", 49, 804, 60, ;
4112:                                   "Importa" + CHR(231) + CHR(227) + "o ")
4113:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label7", 69, 806, 44, ;
4114:                                   "N Adi" + CHR(231) + CHR(227) + "o")
4115: 
4116:         loc_oCnt.AddObject("txt_4c_NAdis", "TextBox")
4117:         WITH loc_oCnt.txt_4c_NAdis
4118:             .Top               = 84
4119:             .Left              = 806
4120:             .Width             = 31
4121:             .Height            = 21
4122:             .FontName          = "Tahoma"
4123:             .FontSize          = 8
4124:             .Alignment         = 3

*-- Linhas 4133 a 4147:
4133:             .Visible           = .T.
4134:         ENDWITH
4135: 
4136:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label2", 69, 875, 59, ;
4137:                                   "Item Adi" + CHR(231) + CHR(227) + "o")
4138: 
4139:         loc_oCnt.AddObject("txt_4c_NIAdis", "TextBox")
4140:         WITH loc_oCnt.txt_4c_NIAdis
4141:             .Top               = 84
4142:             .Left              = 876
4143:             .Width             = 31
4144:             .Height            = 21
4145:             .FontName          = "Tahoma"
4146:             .FontSize          = 8
4147:             .Alignment         = 3

*-- Linhas 4156 a 4170:
4156:             .Visible           = .T.
4157:         ENDWITH
4158: 
4159:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label3", 108, 806, 121, ;
4160:                                   "C Fabricante Estrangeiro")
4161: 
4162:         loc_oCnt.AddObject("txt_4c_Codfabs", "TextBox")
4163:         WITH loc_oCnt.txt_4c_Codfabs
4164:             .Top               = 123
4165:             .Left              = 806
4166:             .Width             = 155
4167:             .Height            = 21
4168:             .FontName          = "Tahoma"
4169:             .FontSize          = 8
4170:             .Alignment         = 0

*-- Linhas 4196 a 4208:
4196:         par_oPai.AddObject(par_cNome, "Label")
4197: 
4198:         WITH EVALUATE("par_oPai." + par_cNome)
4199:             .Top       = par_nTop
4200:             .Left      = par_nLeft
4201:             .Width     = par_nWidth
4202:             .Height    = 15
4203:             .Caption   = par_cCaption
4204:             .FontName  = "Tahoma"
4205:             .FontSize  = 8
4206:             .FontBold  = .F.
4207:             .AutoSize  = .F.
4208:             .Alignment = 0

*-- Linhas 4227 a 4236:
4227:         par_oPai.AddObject(par_cNome, "TextBox")
4228: 
4229:         WITH EVALUATE("par_oPai." + par_cNome)
4230:             .Top           = par_nTop
4231:             .Left          = par_nLeft
4232:             .Width         = par_nWidth
4233:             .Height        = 21
4234:             .FontName      = "Tahoma"
4235:             .FontSize      = 8
4236:             .Alignment     = 3

*-- Linhas 4284 a 4293:
4284:         loc_oGrd = loc_oPag.grd_4c_Dados
4285: 
4286:         WITH loc_oGrd
4287:             .Top                = 9
4288:             .Left               = 7
4289:             .Width              = 416
4290:             .Height             = 131
4291:             .ColumnCount        = 4
4292:             .DeleteMark         = .F.
4293:             .RecordMark         = .F.

*-- Linhas 4306 a 4348:
4306:             .Resizable       = .F.
4307:             .ReadOnly        = .T.
4308:             .FontName        = "Courier New"
4309:             .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
4310:             .Visible         = .T.
4311:         ENDWITH
4312: 
4313:         WITH loc_oGrd.Column2
4314:             .ControlSource   = "cursor_4c_Precos.tabds"
4315:             .Width           = 80
4316:             .Movable         = .F.
4317:             .Resizable       = .F.
4318:             .ReadOnly        = .T.
4319:             .FontName        = "Courier New"
4320:             .Header1.Caption = "Tab.Varia" + CHR(231) + CHR(227) + "o"
4321:             .Visible         = .T.
4322:         ENDWITH
4323: 
4324:         WITH loc_oGrd.Column3
4325:             .ControlSource   = "cursor_4c_Precos.units"
4326:             .Width           = 70
4327:             .Movable         = .F.
4328:             .Resizable       = .F.
4329:             .ReadOnly        = .T.
4330:             .FontName        = "Courier New"
4331:             .InputMask       = "9999,999.99"
4332:             .Header1.Caption = "Unit" + CHR(225) + "rio"
4333:             .Visible         = .T.
4334:         ENDWITH
4335: 
4336:         WITH loc_oGrd.Column4
4337:             .ControlSource   = "cursor_4c_Precos.moedas"
4338:             .Width           = 30
4339:             .Movable         = .F.
4340:             .Resizable       = .F.
4341:             .ReadOnly        = .T.
4342:             .FontName        = "Courier New"
4343:             .Header1.Caption = "Moe"
4344:             .Visible         = .T.
4345:         ENDWITH
4346: 
4347:         WITH loc_oGrd
4348:             .FontName = "Courier New"

*-- Linhas 4641 a 4653:
4641:                 *-- negativo (legado: If crTpmMvItn.ValDescs < 0)
4642:                 SELECT cursor_4c_Itens
4643:                 IF TratarNulo(cursor_4c_Itens.valdescs, 0) < 0
4644:                     loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Acr" + CHR(233) + "scimo"
4645:                     loc_oPag.lbl_4c_LblPDescs.Caption = "%Acr" + CHR(233) + "scimo"
4646:                 ELSE
4647:                     loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Desconto"
4648:                     loc_oPag.lbl_4c_LblPDescs.Caption = "% Desconto"
4649:                 ENDIF
4650: 
4651:                 *-- Painel fiscal: os dois campos que nao sao coluna do item
4652:                 WITH loc_oFis
4653:                     .txt_4c_FClFis.Value = ALLTRIM(loc_cClFis)

*-- Linhas 4755 a 4764:
4755:             .cnt_4c_Reffs.txt_4c_Reffs.Value = ""
4756:             .img_4c_ImgProds.Picture = ""
4757:             .img_4c_ImgProds.Visible = .F.
4758:             .lbl_4c_LblVDescs.Caption = "Valor Desconto"
4759:             .lbl_4c_LblPDescs.Caption = "% Desconto"
4760:         ENDWITH
4761: 
4762:         WITH THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
4763:             .txt_4c_FClFis.Value = ""
4764:             .txt_4c_FDlFis.Value = ""

*-- Linhas 6026 a 6034:
6026:     *==========================================================================
6027:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
6028:         IF par_nKeyCode = -4
6029:             IF THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled
6030:                 NODEFAULT
6031:                 THIS.BtnPBuscasClick()
6032:                 RETURN
6033:             ENDIF
6034:         ENDIF


### BO (C:\4c\projeto\app\classes\sigopproBO.prg):
*====================================================================
* sigopproBO.prg
*
* Business Object para o painel de Produtos (FormSigOpPro)
* Form OPERACIONAL embutido na tela de Movimentacao (Entrada/Saida)
* Entidade principal: Item de Movimentacao - tabela SigMvItn
* Cursor de trabalho repassado pelo form pai: crTpmMvItn/TprMvCab
* Chave primaria: cidchaves char(20)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigopproBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvItn)
    this_nAqtds              = 0     && aqtds numeric(9,3)
    this_nCitens             = 0     && citens numeric(10,0)
    this_nCodbarras          = 0     && codbarras numeric(14,0)
    this_cCpros              = ""    && cpros char(14)
    this_cCunis              = ""    && cunis char(3)
    this_dDatatrans          = {}    && datatrans datetime NULL
    this_nDescvals           = 0     && descvals numeric(7,2)
    this_cDopes              = ""    && dopes char(20)
    this_cDpros              = ""    && dpros char(65)
    this_cEmps               = ""    && emps char(3)
    this_lEtiesps            = .F.   && etiesps bit
    this_nFators             = 0     && fators numeric(8,3)
    this_nFatvals            = 0     && fatvals numeric(15,6)
    this_lFvals              = .F.   && fvals bit
    this_lIconfs             = .F.   && iconfs bit
    this_cLocals             = ""    && locals char(10)
    this_cMoedas             = ""    && moedas char(3)
    this_cMoefats            = ""    && moefats char(3)
    this_nMoevals            = 0     && moevals numeric(15,6)
    this_cNotas              = ""    && notas char(6)
    this_cNrcons             = ""    && nrcons char(10)
    this_nNtrans             = 0     && ntrans numeric(6,0)
    this_nNumes              = 0     && numes numeric(6,0)
    this_nNumolds            = 0     && numolds numeric(6,0)
    this_cObs                = ""    && obs text NULL
    this_cOpers              = ""    && opers char(1)
    this_nPesos              = 0     && pesos numeric(9,3)
    this_nQtbaixas           = 0     && qtbaixas numeric(9,3)
    this_nQtbxprods          = 0     && qtbxprods numeric(9,3)
    this_nQtds               = 0     && qtds numeric(9,3)
    this_nQtprods            = 0     && qtprods numeric(9,3)
    this_nTotas              = 0     && totas numeric(11,2)
    this_nTpesos             = 0     && tpesos numeric(11,2)
    this_nUnitembs           = 0     && unitembs numeric(11,4)
    this_nUnits              = 0     && units numeric(15,6)
    this_nUnivals            = 0     && univals numeric(15,6)
    this_nVcoms              = 0     && vcoms numeric(8,2)
    this_nAliqs              = 0     && aliqs numeric(4,2)
    this_cSitribs            = ""    && sitribs char(2)
    this_cTpipis             = ""    && tpipis char(1)
    this_nValipis            = 0     && valipis numeric(11,2)
    this_nAliqicms           = 0     && aliqicms numeric(5,2)
    this_nValdescs           = 0     && valdescs numeric(9,2)
    this_cEmpos              = ""    && empos char(3)
    this_cMoevs              = ""    && moevs char(3)
    this_nUtilizas            = 0     && utilizas numeric(4,0)
    this_nNcodigos           = 0     && ncodigos numeric(10,0)
    this_nQtreservas         = 0     && qtreservas numeric(9,3)
    this_cCidchaves          = ""    && cidchaves char(20) - PK
    this_nNlotes             = 0     && nlotes numeric(10,0)
    this_dDtalts             = {}    && dtalts datetime NULL
    this_cEmpdopnums         = ""    && empdopnums char(29)
    this_nBaseicms           = 0     && baseicms numeric(11,2)
    this_lChksubn            = .F.   && chksubn bit
    this_nUnit2s             = 0     && unit2s numeric(15,6)
    this_cUsulibs            = ""    && usulibs char(10)
    this_nValrats            = 0     && valrats numeric(14,6)
    this_nCodlprecs          = 0     && codlprecs numeric(6,0)
    this_cCunips             = ""    && cunips char(3)
    this_cMotdscs            = ""    && motdscs char(10)
    this_cTipos              = ""    && tipos char(1)
    this_nUnitinfs           = 0     && unitinfs numeric(14,6)
    this_cCpro2s             = ""    && cpro2s char(50)
    this_cAbrevis            = ""    && abrevis char(3)
    this_nBcicmss            = 0     && bcicmss numeric(15,2)
    this_nBcipis             = 0     && bcipis numeric(15,2)
    this_nIcms               = 0     && icms numeric(15,2)
    this_nIcmss              = 0     && icmss numeric(15,2)
    this_nPdescs             = 0     && pdescs numeric(5,2)
    this_nNchvtbds           = 0     && nchvtbds numeric(6,0)
    this_nIdpro              = 0     && idpro numeric(10,0)
    this_nUnitorigs          = 0     && unitorigs numeric(14,6)
    this_cOrigmercs          = ""    && origmercs char(1)
    this_nBaseicm2s          = 0     && baseicm2s numeric(11,2)
    this_nBaseicm3s          = 0     && baseicm3s numeric(11,2)
    this_nBaseipi2s          = 0     && baseipi2s numeric(11,2)
    this_nBaseipi3s          = 0     && baseipi3s numeric(11,2)
    this_cCfops              = ""    && cfops char(10)
    this_nRatdacs            = 0     && ratdacs numeric(11,2)
    this_nRatfrts            = 0     && ratfrts numeric(11,2)
    this_nRaticmds           = 0     && raticmds numeric(11,2)
    this_nRaticms            = 0     && raticms numeric(11,2)
    this_nRatsegs            = 0     && ratsegs numeric(11,2)
    this_cSittricms          = ""    && sittricms char(3)
    this_nAliqiis            = 0     && aliqiis numeric(4,2)
    this_nCitem2             = 0     && citem2 numeric(10,0)
    this_nTaxaiis            = 0     && taxaiis numeric(11,2)
    this_nVcofins            = 0     && vcofins numeric(11,2)
    this_nVpis               = 0     && vpis numeric(11,2)
    this_nAliqorigs          = 0     && aliqorigs numeric(4,2)
    this_lLcancelas          = .F.   && lcancelas bit
    this_nCompris            = 0     && compris numeric(6,2)
    this_cCodfabs            = ""    && codfabs char(60)
    this_nNadis              = 0     && nadis numeric(3,0)
    this_nNiadis             = 0     && niadis numeric(3,0)
    this_nAliqcofs           = 0     && aliqcofs numeric(4,2)
    this_nAliqpis            = 0     && aliqpis numeric(4,2)
    this_nCssl               = 0     && cssl numeric(11,2)
    this_nInss               = 0     && inss numeric(11,2)
    this_nIrrf               = 0     && irrf numeric(11,2)
    this_nIss                = 0     && iss numeric(11,2)
    this_nValbases           = 0     && valbases numeric(11,2)
    this_cLocalos            = ""    && localos char(10)
    this_nPfcpst             = 0     && pfcpst numeric(5,2)
    this_nVfcpst             = 0     && vfcpst numeric(11,2)
    this_cOb2s               = ""    && ob2s char(100)
    this_cPedidoweb          = ""    && pedidoweb char(50)
    this_nQtresres           = 0     && qtresres numeric(9,3)
    this_nBarraref           = 0     && barraref numeric(14,0)
    this_cItemped            = ""    && itemped char(4)
    this_cNumeronota         = ""    && numeronota char(10)
    this_cDopesorig          = ""    && dopesorig char(20)
    this_cChaveexterna       = ""    && chaveexterna char(33)
    this_nCkpresente         = 0     && ckpresente numeric(1,0)
    this_cGravacao           = ""    && gravacao char(20)
    this_cIfors              = ""    && ifors char(10)
    this_cPropriedades       = ""    && propriedades nvarchar(40) NULL
    this_cUnidade1           = ""    && unidade1 nvarchar(15) NULL
    this_cResultado1         = ""    && resultado1 nvarchar(15) NULL
    this_cValorMinimo        = ""    && valorMinimo nvarchar(15) NULL
    this_cValorMaximo        = ""    && valorMaximo nvarchar(15) NULL
    this_cMetodoReferencia1  = ""    && metodoReferencia1 nvarchar(15) NULL

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "sigopproBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia uma linha de SigMvItn (cursor populado
    * por SQLEXEC) para as properties da entidade. NAO e PROTECTED
    * (regra #51 - BusinessBase declara publico).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nAqtds        = TratarNulo(aqtds, 0)
            THIS.this_nCitens       = TratarNulo(citens, 0)
            THIS.this_nCodbarras    = TratarNulo(codbarras, 0)
            THIS.this_cCpros        = TratarNulo(cpros, "")
            THIS.this_cCunis        = TratarNulo(cunis, "")
            THIS.this_dDatatrans    = TratarNulo(datatrans, {})
            THIS.this_nDescvals     = TratarNulo(descvals, 0)
            THIS.this_cDopes        = TratarNulo(dopes, "")
            THIS.this_cDpros        = TratarNulo(dpros, "")
            THIS.this_cEmps         = TratarNulo(emps, "")
            THIS.this_lEtiesps      = IIF(VARTYPE(etiesps) = "L", etiesps, (NVL(etiesps, 0) = 1))
            THIS.this_nFators       = TratarNulo(fators, 0)
            THIS.this_nFatvals      = TratarNulo(fatvals, 0)
            THIS.this_lFvals        = IIF(VARTYPE(fvals) = "L", fvals, (NVL(fvals, 0) = 1))
            THIS.this_lIconfs       = IIF(VARTYPE(iconfs) = "L", iconfs, (NVL(iconfs, 0) = 1))
            THIS.this_cLocals       = TratarNulo(locals, "")
            THIS.this_cMoedas       = TratarNulo(moedas, "")
            THIS.this_cMoefats      = TratarNulo(moefats, "")
            THIS.this_nMoevals      = TratarNulo(moevals, 0)
            THIS.this_cNotas        = TratarNulo(notas, "")
            THIS.this_cNrcons       = TratarNulo(nrcons, "")
            THIS.this_nNtrans       = TratarNulo(ntrans, 0)
            THIS.this_nNumes        = TratarNulo(numes, 0)
            THIS.this_nNumolds      = TratarNulo(numolds, 0)
            THIS.this_cObs          = TratarNulo(obs, "")
            THIS.this_cOpers        = TratarNulo(opers, "")
            THIS.this_nPesos        = TratarNulo(pesos, 0)
            THIS.this_nQtbaixas     = TratarNulo(qtbaixas, 0)
            THIS.this_nQtbxprods    = TratarNulo(qtbxprods, 0)
            THIS.this_nQtds         = TratarNulo(qtds, 0)
            THIS.this_nQtprods      = TratarNulo(qtprods, 0)
            THIS.this_nTotas        = TratarNulo(totas, 0)
            THIS.this_nTpesos       = TratarNulo(tpesos, 0)
            THIS.this_nUnitembs     = TratarNulo(unitembs, 0)
            THIS.this_nUnits        = TratarNulo(units, 0)
            THIS.this_nUnivals      = TratarNulo(univals, 0)
            THIS.this_nVcoms        = TratarNulo(vcoms, 0)
            THIS.this_nAliqs        = TratarNulo(aliqs, 0)
            THIS.this_cSitribs      = TratarNulo(sitribs, "")
            THIS.this_cTpipis       = TratarNulo(tpipis, "")
            THIS.this_nValipis      = TratarNulo(valipis, 0)
            THIS.this_nAliqicms     = TratarNulo(aliqicms, 0)
            THIS.this_nValdescs     = TratarNulo(valdescs, 0)
            THIS.this_cEmpos        = TratarNulo(empos, "")
            THIS.this_cMoevs        = TratarNulo(moevs, "")
            THIS.this_nUtilizas     = TratarNulo(utilizas, 0)
            THIS.this_nNcodigos     = TratarNulo(ncodigos, 0)
            THIS.this_nQtreservas   = TratarNulo(qtreservas, 0)
            THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
            THIS.this_nNlotes       = TratarNulo(nlotes, 0)
            THIS.this_dDtalts       = TratarNulo(dtalts, {})
            THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
            THIS.this_nBaseicms     = TratarNulo(baseicms, 0)
            THIS.this_lChksubn      = IIF(VARTYPE(chksubn) = "L", chksubn, (NVL(chksubn, 0) = 1))
            THIS.this_nUnit2s       = TratarNulo(unit2s, 0)
            THIS.this_cUsulibs      = TratarNulo(usulibs, "")
            THIS.this_nValrats      = TratarNulo(valrats, 0)
            THIS.this_nCodlprecs    = TratarNulo(codlprecs, 0)
            THIS.this_cCunips       = TratarNulo(cunips, "")
            THIS.this_cMotdscs      = TratarNulo(motdscs, "")
            THIS.this_cTipos        = TratarNulo(tipos, "")
            THIS.this_nUnitinfs     = TratarNulo(unitinfs, 0)
            THIS.this_cCpro2s       = TratarNulo(cpro2s, "")
            THIS.this_cAbrevis      = TratarNulo(abrevis, "")
            THIS.this_nBcicmss      = TratarNulo(bcicmss, 0)
            THIS.this_nBcipis       = TratarNulo(bcipis, 0)
            THIS.this_nIcms         = TratarNulo(icms, 0)
            THIS.this_nIcmss        = TratarNulo(icmss, 0)
            THIS.this_nPdescs       = TratarNulo(pdescs, 0)
            THIS.this_nNchvtbds     = TratarNulo(nchvtbds, 0)
            THIS.this_nIdpro        = TratarNulo(idpro, 0)
            THIS.this_nUnitorigs    = TratarNulo(unitorigs, 0)
            THIS.this_cOrigmercs    = TratarNulo(origmercs, "")
            THIS.this_nBaseicm2s    = TratarNulo(baseicm2s, 0)
            THIS.this_nBaseicm3s    = TratarNulo(baseicm3s, 0)
            THIS.this_nBaseipi2s    = TratarNulo(baseipi2s, 0)
            THIS.this_nBaseipi3s    = TratarNulo(baseipi3s, 0)
            THIS.this_cCfops        = TratarNulo(cfops, "")
            THIS.this_nRatdacs      = TratarNulo(ratdacs, 0)
            THIS.this_nRatfrts      = TratarNulo(ratfrts, 0)
            THIS.this_nRaticmds     = TratarNulo(raticmds, 0)
            THIS.this_nRaticms      = TratarNulo(raticms, 0)
            THIS.this_nRatsegs      = TratarNulo(ratsegs, 0)
            THIS.this_cSittricms    = TratarNulo(sittricms, "")
            THIS.this_nAliqiis      = TratarNulo(aliqiis, 0)
            THIS.this_nCitem2       = TratarNulo(citem2, 0)
            THIS.this_nTaxaiis      = TratarNulo(taxaiis, 0)
            THIS.this_nVcofins      = TratarNulo(vcofins, 0)
            THIS.this_nVpis         = TratarNulo(vpis, 0)
            THIS.this_nAliqorigs    = TratarNulo(aliqorigs, 0)
            THIS.this_lLcancelas    = IIF(VARTYPE(lcancelas) = "L", lcancelas, (NVL(lcancelas, 0) = 1))
            THIS.this_nCompris      = TratarNulo(compris, 0)
            THIS.this_cCodfabs      = TratarNulo(codfabs, "")
            THIS.this_nNadis        = TratarNulo(nadis, 0)
            THIS.this_nNiadis       = TratarNulo(niadis, 0)
            THIS.this_nAliqcofs     = TratarNulo(aliqcofs, 0)
            THIS.this_nAliqpis      = TratarNulo(aliqpis, 0)
            THIS.this_nCssl         = TratarNulo(cssl, 0)
            THIS.this_nInss         = TratarNulo(inss, 0)
            THIS.this_nIrrf         = TratarNulo(irrf, 0)
            THIS.this_nIss          = TratarNulo(iss, 0)
            THIS.this_nValbases     = TratarNulo(valbases, 0)
            THIS.this_cLocalos      = TratarNulo(localos, "")
            THIS.this_nPfcpst       = TratarNulo(pfcpst, 0)
            THIS.this_nVfcpst       = TratarNulo(vfcpst, 0)
            THIS.this_cOb2s         = TratarNulo(ob2s, "")
            THIS.this_cPedidoweb    = TratarNulo(pedidoweb, "")
            THIS.this_nQtresres     = TratarNulo(qtresres, 0)
            THIS.this_nBarraref     = TratarNulo(barraref, 0)
            THIS.this_cItemped      = TratarNulo(itemped, "")
            THIS.this_cNumeronota   = TratarNulo(numeronota, "")
            THIS.this_cDopesorig    = TratarNulo(dopesorig, "")
            THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")
            THIS.this_nCkpresente   = TratarNulo(ckpresente, 0)
            THIS.this_cGravacao     = TratarNulo(gravacao, "")
            THIS.this_cIfors        = TratarNulo(ifors, "")
            THIS.this_cPropriedades       = TratarNulo(propriedades, "")
            THIS.this_cUnidade1           = TratarNulo(unidade1, "")
            THIS.this_cResultado1         = TratarNulo(resultado1, "")
            THIS.this_cValorMinimo        = TratarNulo(valorMinimo, "")
            THIS.this_cValorMaximo        = TratarNulo(valorMaximo, "")
            THIS.this_cMetodoReferencia1  = TratarNulo(metodoReferencia1, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Monta a chave POSICIONAL empdopnums
    * char(29), igual ao legado (SIGMVSBN: Emps + Dopes + Str(Numes,6)).
    * Regra #42: o padding FAZ PARTE da chave - PADR explicito nas
    * partes (Emps char(3) + Dopes char(20) + 6 = 29). ALLTRIM nas
    * partes encurta a chave, ela nunca casa e o SELECT devolve ZERO
    * linhas em silencio.
    *====================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes

        loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

        RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
    ENDFUNC

    *====================================================================
    * CarregarItens - Le os itens de UMA movimentacao (empdopnums) para
    * um cursor TEMPORARIO. Equivale ao AddCursor('SigMvItn', ...) que o
    * legado herda do form pai de Movimentacao.
    *
    * NUNCA faz SQLEXEC sobre o alias ligado a grade: isso FECHA e RECRIA
    * o alias, zera o ColumnCount e a grade vira um retangulo branco
    * (sem erro e sem log). O chamador recarrega o alias da grade com
    * SELECT/ZAP/APPEND FROM DBF() a partir deste cursor temporario.
    *
    * par_cEmpDopNums - chave char(29) da movimentacao (ver
    *                   MontarChaveEmpDopNums)
    * par_cCursorTmp  - alias do cursor temporario de destino
    *====================================================================
    FUNCTION CarregarItens(par_cEmpDopNums, par_cCursorTmp)
        LOCAL loc_cSQL, loc_cCursor, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorTmp) = "C" AND !EMPTY(par_cCursorTmp), ;
                           ALLTRIM(par_cCursorTmp), "cursor_4c_ItensTmp")

        IF VARTYPE(par_cEmpDopNums) <> "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
                                      "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- Alias do cursor temporario fechado antes do SQLEXEC; o guard
            *-- testa o BUFFERING, nunca so o USED (regra #52).
            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF

            *-- Lista de colunas EXPLICITA e identica a do CREATE CURSOR do
            *-- form: o APPEND FROM DBF() casa os campos por NOME.
            loc_cSQL = "SELECT aqtds, citens, codbarras, cpros, cunis," + ;
                       " datatrans, descvals, dopes, dpros, emps," + ;
                       " etiesps, fators, fatvals, fvals, iconfs," + ;
                       " locals, moedas, moefats, moevals, notas," + ;
                       " nrcons, ntrans, numes, numolds, obs," + ;
                       " opers, pesos, qtbaixas, qtbxprods, qtds," + ;
                       " qtprods, totas, tpesos, unitembs, units," + ;
                       " univals, vcoms, aliqs, sitribs, tpipis," + ;
                       " valipis, aliqicms, valdescs, empos, moevs," + ;
                       " utilizas, ncodigos, qtreservas, cidchaves, nlotes," + ;
                       " dtalts, empdopnums, baseicms, chksubn, unit2s," + ;
                       " usulibs, valrats, codlprecs, cunips, motdscs," + ;
                       " tipos, unitinfs, cpro2s, abrevis, bcicmss," + ;
                       " bcipis, icms, icmss, pdescs, nchvtbds," + ;
                       " idpro, unitorigs, origmercs, baseicm2s, baseicm3s," + ;
                       " baseipi2s, baseipi3s, cfops, ratdacs, ratfrts," + ;
                       " raticmds, raticms, ratsegs, sittricms, aliqiis," + ;
                       " citem2, taxaiis, vcofins, vpis, aliqorigs," + ;
                       " lcancelas, compris, codfabs, nadis, niadis," + ;
                       " aliqcofs, aliqpis, cssl, inss, irrf," + ;
                       " iss, valbases, localos, pfcpst, vfcpst," + ;
                       " ob2s, pedidoweb, qtresres, barraref, itemped," + ;
                       " numeronota, dopesorig, chaveexterna, ckpresente," + ;
                       " gravacao, ifors, propriedades, unidade1, resultado1," + ;
                       " valorMinimo, valorMaximo, metodoReferencia1" + ;
                       " FROM SigMvItn" + ;
                       " WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                            CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, ;
                            "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                        CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
                        "sigopproBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
    * nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *====================================================================
    * Inserir - INSERT completo em SigMvItn. cidchaves (PK Fortyus) e
    * gerada aqui se ainda vazia (regra #22 - fUniqueIds(), NUNCA string
    * vazia, senao o 2o registro colide no indice unico).
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cCidchaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvItn (
                    aqtds, citens, codbarras, cpros, cunis, datatrans,
                    descvals, dopes, dpros, emps, etiesps, fators,
                    fatvals, fvals, iconfs, locals, moedas, moefats,
                    moevals, notas, nrcons, ntrans, numes, numolds,
                    obs, opers, pesos, qtbaixas, qtbxprods, qtds,
                    qtprods, totas, tpesos, unitembs, units, univals,
                    vcoms, aliqs, sitribs, tpipis, valipis, aliqicms,
                    valdescs, empos, moevs, utilizas, ncodigos, qtreservas,
                    cidchaves, nlotes, dtalts, empdopnums, baseicms, chksubn,
                    unit2s, usulibs, valrats, codlprecs, cunips, motdscs,
                    tipos, unitinfs, cpro2s, abrevis, bcicmss, bcipis,
                    icms, icmss, pdescs, nchvtbds, idpro, unitorigs,
                    origmercs, baseicm2s, baseicm3s, baseipi2s, baseipi3s, cfops,
                    ratdacs, ratfrts, raticmds, raticms, ratsegs, sittricms,
                    aliqiis, citem2, taxaiis, vcofins, vpis, aliqorigs,
                    lcancelas, compris, codfabs, nadis, niadis, aliqcofs,
                    aliqpis, cssl, inss, irrf, iss, valbases,
                    localos, pfcpst, vfcpst, ob2s, pedidoweb, qtresres,
                    barraref, itemped, numeronota, dopesorig, chaveexterna, ckpresente,
                    gravacao, ifors, propriedades, unidade1, resultado1, valorMinimo,
                    valorMaximo, metodoReferencia1
                )
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    <<IIF(THIS.this_lFvals, 1, 0)>>,
                    <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
                    <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE completo em SigMvItn pela PK cidchaves.
    * cidchaves identifica o registro e NAO entra no SET.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvItn SET
                    aqtds        = <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    citens       = <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    codbarras    = <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    cpros        = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    cunis        = <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    datatrans    = <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    descvals     = <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    dopes        = <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    dpros        = <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    emps         = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    etiesps      = <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    fators       = <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    fatvals      = <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    fvals        = <<IIF(THIS.this_lFvals, 1, 0)>>,
                    iconfs       = <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    moedas       = <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    moefats      = <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    moevals      = <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    notas        = <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    nrcons       = <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    numes        = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    obs          = <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    opers        = <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    pesos        = <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    qtbaixas     = <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    qtbxprods    = <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    qtds         = <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    qtprods      = <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    totas        = <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    tpesos       = <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    unitembs     = <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    units        = <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    univals      = <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    vcoms        = <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    aliqs        = <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    sitribs      = <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    tpipis       = <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    valipis      = <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    aliqicms     = <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    moevs        = <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    utilizas     = <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    ncodigos     = <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    qtreservas   = <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    nlotes       = <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    dtalts       = <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    baseicms     = <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    chksubn      = <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    unit2s       = <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    usulibs      = <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    valrats      = <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    codlprecs    = <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    cunips       = <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    motdscs      = <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    tipos        = <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    unitinfs     = <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    cpro2s       = <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    abrevis      = <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    bcicmss      = <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    bcipis       = <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    icms         = <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    icmss        = <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    pdescs       = <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    nchvtbds     = <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    idpro        = <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    unitorigs    = <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    origmercs    = <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    baseicm2s    = <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    baseicm3s    = <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    baseipi2s    = <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    baseipi3s    = <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    cfops        = <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    ratdacs      = <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    ratfrts      = <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    raticmds     = <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    raticms      = <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    ratsegs      = <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    sittricms    = <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    aliqiis      = <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    citem2       = <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    taxaiis      = <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    aliqorigs    = <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    lcancelas    = <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    compris      = <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    codfabs      = <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    nadis        = <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    niadis       = <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    aliqcofs     = <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    cssl         = <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    inss         = <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    irrf         = <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    iss          = <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    valbases     = <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    localos      = <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    pfcpst       = <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    vfcpst       = <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    ob2s         = <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    pedidoweb    = <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    qtresres     = <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    barraref     = <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    itemped      = <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    numeronota   = <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    dopesorig    = <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    ckpresente   = <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    gravacao     = <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    ifors        = <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    propriedades = <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    unidade1     = <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    resultado1   = <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    valorMinimo  = <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    valorMaximo  = <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    metodoReferencia1 = <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

