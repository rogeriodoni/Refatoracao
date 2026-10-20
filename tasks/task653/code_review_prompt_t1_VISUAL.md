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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCbl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2052 linhas total):

*-- Linhas 124 a 174:
124: 
125:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH THIS.cnt_4c_Cabecalho
127:             .Top         = 0
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackStyle   = 1
132:             .BackColor   = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible     = .T.
135:         ENDWITH
136:         loc_oCab = THIS.cnt_4c_Cabecalho
137: 
138:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oCab.lbl_4c_Sombra
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = loc_oCab.Width - 20
143:             .Height    = 40
144:             .AutoSize  = .F.
145:             .WordWrap  = .T.
146:             .Alignment = 0
147:             .BackStyle = 0
148:             .FontBold  = .T.
149:             .FontName  = "Tahoma"
150:             .FontSize  = 18
151:             .ForeColor = RGB(0, 0, 0)
152:             .Caption   = THIS.Caption
153:         ENDWITH
154: 
155:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
156:         WITH loc_oCab.lbl_4c_Titulo
157:             .Top       = 17
158:             .Left      = 10
159:             .Width     = loc_oCab.Width - 20
160:             .Height    = 46
161:             .AutoSize  = .F.
162:             .WordWrap  = .T.
163:             .Alignment = 0
164:             .BackStyle = 0
165:             .FontBold  = .T.
166:             .FontName  = "Tahoma"
167:             .FontSize  = 18
168:             .ForeColor = RGB(255, 255, 255)
169:             .Caption   = THIS.Caption
170:         ENDWITH
171:     ENDPROC
172: 
173:     *--------------------------------------------------------------------------
174:     * ConfigurarBotoes - Container do grupo Confirmar/Encerrar (replica

*-- Linhas 183 a 207:
183:     PROTECTED PROCEDURE ConfigurarBotoes()
184:         THIS.AddObject("cnt_4c_Botoes", "Container")
185:         WITH THIS.cnt_4c_Botoes
186:             .Top         = -2
187:             .Left        = 643
188:             .Width       = 160
189:             .Height      = 85
190:             .BackStyle   = 0
191:             .BorderWidth = 0
192:             .Visible     = .T.
193:         ENDWITH
194: 
195:         *-- Command1 (cmdOk) do cmdGsalva legado - "Confirma a Configuracao do Boleto?"
196:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirmar", "CommandButton")
197:         WITH THIS.cnt_4c_Botoes.cmd_4c_Confirmar
198:             .Top             = 5
199:             .Left            = 5
200:             .Width           = 75
201:             .Height          = 75
202:             .Caption         = "Confirmar"
203:             .ToolTipText     = "Confirmar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
205:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
206:             .FontName        = "Comic Sans MS"
207:             .FontBold        = .T.

*-- Linhas 218 a 233:
218:         ENDWITH
219: 
220:         *-- Command2 (cmdCancelar) do cmdGsalva legado - "Deseja Abandonar as Alteracoes Realizadas?"
221:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
222:         WITH THIS.cnt_4c_Botoes.cmd_4c_Encerrar
223:             .Top             = 5
224:             .Left            = 80
225:             .Width           = 75
226:             .Height          = 75
227:             .Cancel          = .T.
228:             .Caption         = "Encerrar"
229:             .ToolTipText     = "[ESC] Cancelar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
231:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
232:             .FontName        = "Comic Sans MS"
233:             .FontBold        = .T.

*-- Linhas 248 a 257:
248:         *-- BtnEncerrarClick delega para BtnCancelarClick, que guarda o corpo
249:         *-- do Click legado: o objeto do SCX chama-se cmdCancelar mas tem
250:         *-- Caption "Encerrar" (PILAR 1 - a legenda eh a do legado).
251:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
252:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
253:     ENDPROC
254: 
255:     *--------------------------------------------------------------------------
256:     * ConfigurarPaginaDados - Campos de posicionamento de impressao do boleto
257:     * (linha x coluna de cada bloco), transcritos do SIGOPCBL.SCX direto no

*-- Linhas 275 a 1376:
275:     *--------------------------------------------------------------------------
276:     PROTECTED PROCEDURE ConfigurarPaginaDados()
277:         *-- Secao "Cabecalho"
278:         THIS.AddObject("lbl_4c_Label27", "Label")
279:         WITH THIS.lbl_4c_Label27
280:             .Top       = 119
281:             .Left      = 122
282:             .Width     = 60
283:             .Height    = 15
284:             .Alignment = 0
285:             .BackStyle = 0
286:             .FontBold  = .T.
287:             .FontName  = "Tahoma"
288:             .FontSize  = 8
289:             .ForeColor = RGB(90, 90, 90)
290:             .Caption   = "Cabe" + CHR(231) + "alho"
291:             .Visible   = .T.
292:         ENDWITH
293: 
294:         THIS.AddObject("shp_4c_Shape1", "Shape")
295:         WITH THIS.shp_4c_Shape1
296:             .Top        = 135
297:             .Left       = 109
298:             .Width      = 570
299:             .Height     = 2
300:             .BackStyle  = 1
301:             .BackColor  = RGB(192, 192, 192)
302:             .BorderStyle = 0
303:             .Visible    = .T.
304:         ENDWITH
305: 
306:         *-- Local de Pagamento (nlnlocals x ncllocals)
307:         THIS.AddObject("lbl_4c_Label1", "Label")
308:         WITH THIS.lbl_4c_Label1
309:             .Top       = 142
310:             .Left      = 109
311:             .Width     = 98
312:             .Height    = 15
313:             .Alignment = 0
314:             .BackStyle = 0
315:             .FontName  = "Tahoma"
316:             .FontSize  = 8
317:             .ForeColor = RGB(90, 90, 90)
318:             .Caption   = "Local de Pagamento"
319:             .Visible   = .T.
320:         ENDWITH
321: 
322:         THIS.AddObject("txt_4c_Text1", "TextBox")
323:         WITH THIS.txt_4c_Text1
324:             .Top       = 156
325:             .Left      = 109
326:             .Width     = 41
327:             .Height    = 18
328:             .Value     = 0
329:             .InputMask = "999.99"
330:             .FontName  = "Tahoma"
331:             .FontSize  = 8
332:             .Visible   = .T.
333:             .Format    = "K"
334:         ENDWITH
335: 
336:         THIS.AddObject("lbl_4c_Label2", "Label")
337:         WITH THIS.lbl_4c_Label2
338:             .Top       = 158
339:             .Left      = 151
340:             .Width     = 8
341:             .Height    = 15
342:             .Alignment = 0
343:             .BackStyle = 0
344:             .FontName  = "Tahoma"
345:             .FontSize  = 8
346:             .ForeColor = RGB(90, 90, 90)
347:             .Caption   = "x"
348:             .Visible   = .T.
349:         ENDWITH
350: 
351:         THIS.AddObject("txt_4c_Text2", "TextBox")
352:         WITH THIS.txt_4c_Text2
353:             .Top       = 156
354:             .Left      = 158
355:             .Width     = 41
356:             .Height    = 18
357:             .Value     = 0
358:             .InputMask = "999.99"
359:             .FontName  = "Tahoma"
360:             .FontSize  = 8
361:             .Visible   = .T.
362:             .Format    = "K"
363:         ENDWITH
364: 
365:         *-- Vencimento (nlndtvencs x ncldtvencs)
366:         THIS.AddObject("lbl_4c_Label3", "Label")
367:         WITH THIS.lbl_4c_Label3
368:             .Top       = 142
369:             .Left      = 235
370:             .Width     = 57
371:             .Height    = 15
372:             .Alignment = 0
373:             .BackStyle = 0
374:             .FontName  = "Tahoma"
375:             .FontSize  = 8
376:             .ForeColor = RGB(90, 90, 90)
377:             .Caption   = "Vencimento"
378:             .Visible   = .T.
379:         ENDWITH
380: 
381:         THIS.AddObject("txt_4c_Text3", "TextBox")
382:         WITH THIS.txt_4c_Text3
383:             .Top       = 156
384:             .Left      = 235
385:             .Width     = 41
386:             .Height    = 18
387:             .Value     = 0
388:             .InputMask = "999.99"
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .Visible   = .T.
392:             .Format    = "K"
393:         ENDWITH
394: 
395:         THIS.AddObject("lbl_4c_Label4", "Label")
396:         WITH THIS.lbl_4c_Label4
397:             .Top       = 158
398:             .Left      = 277
399:             .Width     = 8
400:             .Height    = 15
401:             .Alignment = 0
402:             .BackStyle = 0
403:             .FontName  = "Tahoma"
404:             .FontSize  = 8
405:             .ForeColor = RGB(90, 90, 90)
406:             .Caption   = "x"
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         THIS.AddObject("txt_4c_Text4", "TextBox")
411:         WITH THIS.txt_4c_Text4
412:             .Top       = 156
413:             .Left      = 284
414:             .Width     = 41
415:             .Height    = 18
416:             .Value     = 0
417:             .InputMask = "999.99"
418:             .FontName  = "Tahoma"
419:             .FontSize  = 8
420:             .Visible   = .T.
421:             .Format    = "K"
422:         ENDWITH
423: 
424:         *-- Data Documento (nlndtdocs x ncldtdocs)
425:         THIS.AddObject("lbl_4c_Label5", "Label")
426:         WITH THIS.lbl_4c_Label5
427:             .Top       = 142
428:             .Left      = 342
429:             .Width     = 82
430:             .Height    = 15
431:             .Alignment = 0
432:             .BackStyle = 0
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .ForeColor = RGB(90, 90, 90)
436:             .Caption   = "Data Documento"
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         THIS.AddObject("txt_4c_Text5", "TextBox")
441:         WITH THIS.txt_4c_Text5
442:             .Top       = 156
443:             .Left      = 342
444:             .Width     = 41
445:             .Height    = 18
446:             .Value     = 0
447:             .InputMask = "999.99"
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .Visible   = .T.
451:             .Format    = "K"
452:         ENDWITH
453: 
454:         THIS.AddObject("lbl_4c_Label6", "Label")
455:         WITH THIS.lbl_4c_Label6
456:             .Top       = 158
457:             .Left      = 384
458:             .Width     = 8
459:             .Height    = 15
460:             .Alignment = 0
461:             .BackStyle = 0
462:             .FontName  = "Tahoma"
463:             .FontSize  = 8
464:             .ForeColor = RGB(90, 90, 90)
465:             .Caption   = "x"
466:             .Visible   = .T.
467:         ENDWITH
468: 
469:         THIS.AddObject("txt_4c_Text6", "TextBox")
470:         WITH THIS.txt_4c_Text6
471:             .Top       = 156
472:             .Left      = 391
473:             .Width     = 41
474:             .Height    = 18
475:             .Value     = 0
476:             .InputMask = "999.99"
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .Visible   = .T.
480:             .Format    = "K"
481:         ENDWITH
482: 
483:         *-- Numero do Documento (nlnnrdocs x nclnrdocs)
484:         THIS.AddObject("lbl_4c_Label7", "Label")
485:         WITH THIS.lbl_4c_Label7
486:             .Top       = 142
487:             .Left      = 452
488:             .Width     = 86
489:             .Height    = 15
490:             .Alignment = 0
491:             .BackStyle = 0
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .ForeColor = RGB(90, 90, 90)
495:             .Caption   = "N" + CHR(186) + " do Documento"
496:             .Visible   = .T.
497:         ENDWITH
498: 
499:         THIS.AddObject("txt_4c_Text7", "TextBox")
500:         WITH THIS.txt_4c_Text7
501:             .Top       = 156
502:             .Left      = 452
503:             .Width     = 41
504:             .Height    = 18
505:             .Value     = 0
506:             .InputMask = "999.99"
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .Visible   = .T.
510:             .Format    = "K"
511:         ENDWITH
512: 
513:         THIS.AddObject("lbl_4c_Label8", "Label")
514:         WITH THIS.lbl_4c_Label8
515:             .Top       = 158
516:             .Left      = 494
517:             .Width     = 8
518:             .Height    = 15
519:             .Alignment = 0
520:             .BackStyle = 0
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .ForeColor = RGB(90, 90, 90)
524:             .Caption   = "x"
525:             .Visible   = .T.
526:         ENDWITH
527: 
528:         THIS.AddObject("txt_4c_Text8", "TextBox")
529:         WITH THIS.txt_4c_Text8
530:             .Top       = 156
531:             .Left      = 501
532:             .Width     = 41
533:             .Height    = 18
534:             .Value     = 0
535:             .InputMask = "999.99"
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .Visible   = .T.
539:             .Format    = "K"
540:         ENDWITH
541: 
542:         *-- Valor do Documento (nlnvldocs x nclvldocs)
543:         THIS.AddObject("lbl_4c_Label9", "Label")
544:         WITH THIS.lbl_4c_Label9
545:             .Top       = 142
546:             .Left      = 562
547:             .Width     = 98
548:             .Height    = 15
549:             .Alignment = 0
550:             .BackStyle = 0
551:             .FontName  = "Tahoma"
552:             .FontSize  = 8
553:             .ForeColor = RGB(90, 90, 90)
554:             .Caption   = "Valor do Documento"
555:             .Visible   = .T.
556:         ENDWITH
557: 
558:         THIS.AddObject("txt_4c_Text9", "TextBox")
559:         WITH THIS.txt_4c_Text9
560:             .Top       = 157
561:             .Left      = 562
562:             .Width     = 41
563:             .Height    = 18
564:             .Value     = 0
565:             .InputMask = "999.99"
566:             .FontName  = "Tahoma"
567:             .FontSize  = 8
568:             .Visible   = .T.
569:             .Format    = "K"
570:         ENDWITH
571: 
572:         THIS.AddObject("lbl_4c_Label10", "Label")
573:         WITH THIS.lbl_4c_Label10
574:             .Top       = 158
575:             .Left      = 604
576:             .Width     = 8
577:             .Height    = 15
578:             .Alignment = 0
579:             .BackStyle = 0
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(90, 90, 90)
583:             .Caption   = "x"
584:             .Visible   = .T.
585:         ENDWITH
586: 
587:         THIS.AddObject("txt_4c_Text10", "TextBox")
588:         WITH THIS.txt_4c_Text10
589:             .Top       = 157
590:             .Left      = 611
591:             .Width     = 41
592:             .Height    = 18
593:             .Value     = 0
594:             .InputMask = "999.99"
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .Visible   = .T.
598:             .Format    = "K"
599:         ENDWITH
600: 
601:         *-- Secao "Texto de Responsabilidade do Cedente"
602:         THIS.AddObject("lbl_4c_Label28", "Label")
603:         WITH THIS.lbl_4c_Label28
604:             .Top       = 183
605:             .Left      = 122
606:             .Width     = 221
607:             .Height    = 15
608:             .Alignment = 0
609:             .BackStyle = 0
610:             .FontBold  = .T.
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .ForeColor = RGB(90, 90, 90)
614:             .Caption   = "Texto de Responsabilidade do Cedente"
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         THIS.AddObject("shp_4c_Shape2", "Shape")
619:         WITH THIS.shp_4c_Shape2
620:             .Top        = 199
621:             .Left       = 109
622:             .Width      = 570
623:             .Height     = 2
624:             .BackStyle  = 1
625:             .BackColor  = RGB(192, 192, 192)
626:             .BorderStyle = 0
627:             .Visible    = .T.
628:         ENDWITH
629: 
630:         *-- Texto (nlntxtcds x ncltxtcds) + Numero de Colunas/Linhas (ntxtcols/ntxtlins)
631:         THIS.AddObject("lbl_4c_Label11", "Label")
632:         WITH THIS.lbl_4c_Label11
633:             .Top       = 206
634:             .Left      = 122
635:             .Width     = 30
636:             .Height    = 15
637:             .Alignment = 0
638:             .BackStyle = 0
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .ForeColor = RGB(90, 90, 90)
642:             .Caption   = "Texto"
643:             .Visible   = .T.
644:         ENDWITH
645: 
646:         THIS.AddObject("txt_4c_Text11", "TextBox")
647:         WITH THIS.txt_4c_Text11
648:             .Top       = 221
649:             .Left      = 122
650:             .Width     = 41
651:             .Height    = 18
652:             .Value     = 0
653:             .InputMask = "999.99"
654:             .FontName  = "Tahoma"
655:             .FontSize  = 8
656:             .Visible   = .T.
657:             .Format    = "K"
658:         ENDWITH
659: 
660:         THIS.AddObject("lbl_4c_Label12", "Label")
661:         WITH THIS.lbl_4c_Label12
662:             .Top       = 222
663:             .Left      = 164
664:             .Width     = 8
665:             .Height    = 15
666:             .Alignment = 0
667:             .BackStyle = 0
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8
670:             .ForeColor = RGB(90, 90, 90)
671:             .Caption   = "x"
672:             .Visible   = .T.
673:         ENDWITH
674: 
675:         THIS.AddObject("txt_4c_Text12", "TextBox")
676:         WITH THIS.txt_4c_Text12
677:             .Top       = 221
678:             .Left      = 171
679:             .Width     = 41
680:             .Height    = 18
681:             .Value     = 0
682:             .InputMask = "999.99"
683:             .FontName  = "Tahoma"
684:             .FontSize  = 8
685:             .Visible   = .T.
686:             .Format    = "K"
687:         ENDWITH
688: 
689:         THIS.AddObject("lbl_4c_Label30", "Label")
690:         WITH THIS.lbl_4c_Label30
691:             .Top       = 206
692:             .Left      = 232
693:             .Width     = 55
694:             .Height    = 15
695:             .Alignment = 0
696:             .BackStyle = 0
697:             .FontName  = "Tahoma"
698:             .FontSize  = 8
699:             .ForeColor = RGB(90, 90, 90)
700:             .Caption   = "N" + CHR(186) + " Colunas"
701:             .Visible   = .T.
702:         ENDWITH
703: 
704:         THIS.AddObject("txt_4c_Text13", "TextBox")
705:         WITH THIS.txt_4c_Text13
706:             .Top       = 221
707:             .Left      = 232
708:             .Width     = 41
709:             .Height    = 18
710:             .Value     = 0
711:             .InputMask = "999"
712:             .FontName  = "Tahoma"
713:             .FontSize  = 8
714:             .Visible   = .T.
715:             .Format    = "K"
716:         ENDWITH
717: 
718:         THIS.AddObject("lbl_4c_Label29", "Label")
719:         WITH THIS.lbl_4c_Label29
720:             .Top       = 206
721:             .Left      = 308
722:             .Width     = 47
723:             .Height    = 15
724:             .Alignment = 0
725:             .BackStyle = 0
726:             .FontName  = "Tahoma"
727:             .FontSize  = 8
728:             .ForeColor = RGB(90, 90, 90)
729:             .Caption   = "N" + CHR(186) + " Linhas"
730:             .Visible   = .T.
731:         ENDWITH
732: 
733:         THIS.AddObject("txt_4c_Text14", "TextBox")
734:         WITH THIS.txt_4c_Text14
735:             .Top       = 221
736:             .Left      = 308
737:             .Width     = 41
738:             .Height    = 18
739:             .Value     = 0
740:             .InputMask = "999"
741:             .FontName  = "Tahoma"
742:             .FontSize  = 8
743:             .Visible   = .T.
744:             .Format    = "K"
745:         ENDWITH
746: 
747:         *-- Secao "Sacado" - Razao Social (nlnrazclis x nclrazclis)
748:         THIS.AddObject("lbl_4c_Label31", "Label")
749:         WITH THIS.lbl_4c_Label31
750:             .Top       = 248
751:             .Left      = 122
752:             .Width     = 43
753:             .Height    = 15
754:             .Alignment = 0
755:             .BackStyle = 0
756:             .FontBold  = .T.
757:             .FontName  = "Tahoma"
758:             .FontSize  = 8
759:             .ForeColor = RGB(90, 90, 90)
760:             .Caption   = "Sacado"
761:             .Visible   = .T.
762:         ENDWITH
763: 
764:         THIS.AddObject("shp_4c_Shape3", "Shape")
765:         WITH THIS.shp_4c_Shape3
766:             .Top        = 264
767:             .Left       = 109
768:             .Width      = 570
769:             .Height     = 2
770:             .BackStyle  = 1
771:             .BackColor  = RGB(192, 192, 192)
772:             .BorderStyle = 0
773:             .Visible    = .T.
774:         ENDWITH
775: 
776:         THIS.AddObject("lbl_4c_Label13", "Label")
777:         WITH THIS.lbl_4c_Label13
778:             .Top       = 271
779:             .Left      = 122
780:             .Width     = 62
781:             .Height    = 15
782:             .Alignment = 0
783:             .BackStyle = 0
784:             .FontName  = "Tahoma"
785:             .FontSize  = 8
786:             .ForeColor = RGB(90, 90, 90)
787:             .Caption   = "Raz" + CHR(227) + "o Social"
788:             .Visible   = .T.
789:         ENDWITH
790: 
791:         THIS.AddObject("txt_4c_Text15", "TextBox")
792:         WITH THIS.txt_4c_Text15
793:             .Top       = 286
794:             .Left      = 122
795:             .Width     = 41
796:             .Height    = 18
797:             .Value     = 0
798:             .InputMask = "999.99"
799:             .FontName  = "Tahoma"
800:             .FontSize  = 8
801:             .Visible   = .T.
802:             .Format    = "K"
803:         ENDWITH
804: 
805:         THIS.AddObject("lbl_4c_Label14", "Label")
806:         WITH THIS.lbl_4c_Label14
807:             .Top       = 287
808:             .Left      = 164
809:             .Width     = 8
810:             .Height    = 15
811:             .Alignment = 0
812:             .BackStyle = 0
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .ForeColor = RGB(90, 90, 90)
816:             .Caption   = "x"
817:             .Visible   = .T.
818:         ENDWITH
819: 
820:         THIS.AddObject("txt_4c_Text16", "TextBox")
821:         WITH THIS.txt_4c_Text16
822:             .Top       = 286
823:             .Left      = 171
824:             .Width     = 41
825:             .Height    = 18
826:             .Value     = 0
827:             .InputMask = "999.99"
828:             .FontName  = "Tahoma"
829:             .FontSize  = 8
830:             .Visible   = .T.
831:             .Format    = "K"
832:         ENDWITH
833: 
834:         *-- Sacado: C.G.C./C.P.F. (nlncgcclis x nclcgcclis)
835:         THIS.AddObject("lbl_4c_Label15", "Label")
836:         WITH THIS.lbl_4c_Label15
837:             .Top       = 271
838:             .Left      = 232
839:             .Width     = 70
840:             .Height    = 15
841:             .Alignment = 0
842:             .BackStyle = 0
843:             .FontName  = "Tahoma"
844:             .FontSize  = 8
845:             .ForeColor = RGB(90, 90, 90)
846:             .Caption   = "C.G.C./C.P.F."
847:             .Visible   = .T.
848:         ENDWITH
849: 
850:         THIS.AddObject("txt_4c_Text17", "TextBox")
851:         WITH THIS.txt_4c_Text17
852:             .Top       = 286
853:             .Left      = 232
854:             .Width     = 41
855:             .Height    = 18
856:             .Value     = 0
857:             .InputMask = "999.99"
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .Visible   = .T.
861:             .Format    = "K"
862:         ENDWITH
863: 
864:         THIS.AddObject("lbl_4c_Label16", "Label")
865:         WITH THIS.lbl_4c_Label16
866:             .Top       = 287
867:             .Left      = 274
868:             .Width     = 8
869:             .Height    = 15
870:             .Alignment = 0
871:             .BackStyle = 0
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .ForeColor = RGB(90, 90, 90)
875:             .Caption   = "x"
876:             .Visible   = .T.
877:         ENDWITH
878: 
879:         THIS.AddObject("txt_4c_Text18", "TextBox")
880:         WITH THIS.txt_4c_Text18
881:             .Top       = 286
882:             .Left      = 281
883:             .Width     = 41
884:             .Height    = 18
885:             .Value     = 0
886:             .InputMask = "999.99"
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .Visible   = .T.
890:             .Format    = "K"
891:         ENDWITH
892: 
893:         *-- Sacado: Endereco (nlnendcobs x nclendcobs)
894:         THIS.AddObject("lbl_4c_Label17", "Label")
895:         WITH THIS.lbl_4c_Label17
896:             .Top       = 271
897:             .Left      = 342
898:             .Width     = 47
899:             .Height    = 15
900:             .Alignment = 0
901:             .BackStyle = 0
902:             .FontName  = "Tahoma"
903:             .FontSize  = 8
904:             .ForeColor = RGB(90, 90, 90)
905:             .Caption   = "Endere" + CHR(231) + "o"
906:             .Visible   = .T.
907:         ENDWITH
908: 
909:         THIS.AddObject("txt_4c_Text19", "TextBox")
910:         WITH THIS.txt_4c_Text19
911:             .Top       = 286
912:             .Left      = 342
913:             .Width     = 41
914:             .Height    = 18
915:             .Value     = 0
916:             .InputMask = "999.99"
917:             .FontName  = "Tahoma"
918:             .FontSize  = 8
919:             .Visible   = .T.
920:             .Format    = "K"
921:         ENDWITH
922: 
923:         THIS.AddObject("lbl_4c_Label18", "Label")
924:         WITH THIS.lbl_4c_Label18
925:             .Top       = 287
926:             .Left      = 394
927:             .Width     = 9
928:             .Height    = 15
929:             .Alignment = 0
930:             .BackStyle = 0
931:             .FontName  = "Tahoma"
932:             .FontSize  = 8
933:             .ForeColor = RGB(90, 90, 90)
934:             .Caption   = "x"
935:             .Visible   = .T.
936:         ENDWITH
937: 
938:         THIS.AddObject("lbl_4c_Label36", "Label")
939:         WITH THIS.lbl_4c_Label36
940:             .Top       = 288
941:             .Left      = 384
942:             .Width     = 8
943:             .Height    = 15
944:             .Alignment = 0
945:             .BackStyle = 0
946:             .FontName  = "Tahoma"
947:             .FontSize  = 8
948:             .ForeColor = RGB(90, 90, 90)
949:             .Caption   = "x"
950:             .Visible   = .T.
951:         ENDWITH
952: 
953:         THIS.AddObject("txt_4c_Text20", "TextBox")
954:         WITH THIS.txt_4c_Text20
955:             .Top       = 286
956:             .Left      = 391
957:             .Width     = 41
958:             .Height    = 18
959:             .Value     = 0
960:             .InputMask = "999.99"
961:             .FontName  = "Tahoma"
962:             .FontSize  = 8
963:             .Visible   = .T.
964:             .Format    = "K"
965:         ENDWITH
966: 
967:         *-- Sacado: Bairro (nlnbaicobs x nclbaicobs)
968:         THIS.AddObject("lbl_4c_Label19", "Label")
969:         WITH THIS.lbl_4c_Label19
970:             .Top       = 271
971:             .Left      = 452
972:             .Width     = 30
973:             .Height    = 15
974:             .Alignment = 0
975:             .BackStyle = 0
976:             .FontName  = "Tahoma"
977:             .FontSize  = 8
978:             .ForeColor = RGB(90, 90, 90)
979:             .Caption   = "Bairro"
980:             .Visible   = .T.
981:         ENDWITH
982: 
983:         THIS.AddObject("txt_4c_Text21", "TextBox")
984:         WITH THIS.txt_4c_Text21
985:             .Top       = 286
986:             .Left      = 452
987:             .Width     = 41
988:             .Height    = 18
989:             .Value     = 0
990:             .InputMask = "999.99"
991:             .FontName  = "Tahoma"
992:             .FontSize  = 8
993:             .Visible   = .T.
994:             .Format    = "K"
995:         ENDWITH
996: 
997:         THIS.AddObject("lbl_4c_Label20", "Label")
998:         WITH THIS.lbl_4c_Label20
999:             .Top       = 287
1000:             .Left      = 494
1001:             .Width     = 8
1002:             .Height    = 15
1003:             .Alignment = 0
1004:             .BackStyle = 0
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:             .ForeColor = RGB(90, 90, 90)
1008:             .Caption   = "x"
1009:             .Visible   = .T.
1010:         ENDWITH
1011: 
1012:         THIS.AddObject("txt_4c_Text22", "TextBox")
1013:         WITH THIS.txt_4c_Text22
1014:             .Top       = 286
1015:             .Left      = 501
1016:             .Width     = 41
1017:             .Height    = 18
1018:             .Value     = 0
1019:             .InputMask = "999.99"
1020:             .FontName  = "Tahoma"
1021:             .FontSize  = 8
1022:             .Visible   = .T.
1023:             .Format    = "K"
1024:         ENDWITH
1025: 
1026:         *-- Sacado: Cidade (nlncidcobs x nclcidcobs)
1027:         THIS.AddObject("lbl_4c_Label21", "Label")
1028:         WITH THIS.lbl_4c_Label21
1029:             .Top       = 306
1030:             .Left      = 122
1031:             .Width     = 35
1032:             .Height    = 15
1033:             .Alignment = 0
1034:             .BackStyle = 0
1035:             .FontName  = "Tahoma"
1036:             .FontSize  = 8
1037:             .ForeColor = RGB(90, 90, 90)
1038:             .Caption   = "Cidade"
1039:             .Visible   = .T.
1040:         ENDWITH
1041: 
1042:         THIS.AddObject("txt_4c_Text23", "TextBox")
1043:         WITH THIS.txt_4c_Text23
1044:             .Top       = 320
1045:             .Left      = 122
1046:             .Width     = 41
1047:             .Height    = 18
1048:             .Value     = 0
1049:             .InputMask = "999.99"
1050:             .FontName  = "Tahoma"
1051:             .FontSize  = 8
1052:             .Visible   = .T.
1053:             .Format    = "K"
1054:         ENDWITH
1055: 
1056:         THIS.AddObject("lbl_4c_Label22", "Label")
1057:         WITH THIS.lbl_4c_Label22
1058:             .Top       = 321
1059:             .Left      = 164
1060:             .Width     = 8
1061:             .Height    = 15
1062:             .Alignment = 0
1063:             .BackStyle = 0
1064:             .FontName  = "Tahoma"
1065:             .FontSize  = 8
1066:             .ForeColor = RGB(90, 90, 90)
1067:             .Caption   = "x"
1068:             .Visible   = .T.
1069:         ENDWITH
1070: 
1071:         THIS.AddObject("txt_4c_Text24", "TextBox")
1072:         WITH THIS.txt_4c_Text24
1073:             .Top       = 320
1074:             .Left      = 171
1075:             .Width     = 41
1076:             .Height    = 18
1077:             .Value     = 0
1078:             .InputMask = "999.99"
1079:             .FontName  = "Tahoma"
1080:             .FontSize  = 8
1081:             .Visible   = .T.
1082:             .Format    = "K"
1083:         ENDWITH
1084: 
1085:         *-- Sacado: U.F. (nlnestcobs x nclestcobs)
1086:         THIS.AddObject("lbl_4c_Label23", "Label")
1087:         WITH THIS.lbl_4c_Label23
1088:             .Top       = 306
1089:             .Left      = 232
1090:             .Width     = 23
1091:             .Height    = 15
1092:             .Alignment = 0
1093:             .BackStyle = 0
1094:             .FontName  = "Tahoma"
1095:             .FontSize  = 8
1096:             .ForeColor = RGB(90, 90, 90)
1097:             .Caption   = "U.F."
1098:             .Visible   = .T.
1099:         ENDWITH
1100: 
1101:         THIS.AddObject("txt_4c_Text25", "TextBox")
1102:         WITH THIS.txt_4c_Text25
1103:             .Top       = 320
1104:             .Left      = 232
1105:             .Width     = 41
1106:             .Height    = 18
1107:             .Value     = 0
1108:             .InputMask = "999.99"
1109:             .FontName  = "Tahoma"
1110:             .FontSize  = 8
1111:             .Visible   = .T.
1112:             .Format    = "K"
1113:         ENDWITH
1114: 
1115:         THIS.AddObject("lbl_4c_Label24", "Label")
1116:         WITH THIS.lbl_4c_Label24
1117:             .Top       = 321
1118:             .Left      = 274
1119:             .Width     = 8
1120:             .Height    = 15
1121:             .Alignment = 0
1122:             .BackStyle = 0
1123:             .FontName  = "Tahoma"
1124:             .FontSize  = 8
1125:             .ForeColor = RGB(90, 90, 90)
1126:             .Caption   = "x"
1127:             .Visible   = .T.
1128:         ENDWITH
1129: 
1130:         THIS.AddObject("txt_4c_Text26", "TextBox")
1131:         WITH THIS.txt_4c_Text26
1132:             .Top       = 320
1133:             .Left      = 282
1134:             .Width     = 41
1135:             .Height    = 18
1136:             .Value     = 0
1137:             .InputMask = "999.99"
1138:             .FontName  = "Tahoma"
1139:             .FontSize  = 8
1140:             .Visible   = .T.
1141:             .Format    = "K"
1142:         ENDWITH
1143: 
1144:         *-- Sacado: C.E.P. (nlncepcobs x nclcepcobs)
1145:         THIS.AddObject("lbl_4c_Label25", "Label")
1146:         WITH THIS.lbl_4c_Label25
1147:             .Top       = 306
1148:             .Left      = 342
1149:             .Width     = 33
1150:             .Height    = 15
1151:             .Alignment = 0
1152:             .BackStyle = 0
1153:             .FontName  = "Tahoma"
1154:             .FontSize  = 8
1155:             .ForeColor = RGB(90, 90, 90)
1156:             .Caption   = "C.E.P."
1157:             .Visible   = .T.
1158:         ENDWITH
1159: 
1160:         THIS.AddObject("txt_4c_Text27", "TextBox")
1161:         WITH THIS.txt_4c_Text27
1162:             .Top       = 320
1163:             .Left      = 342
1164:             .Width     = 41
1165:             .Height    = 18
1166:             .Value     = 0
1167:             .InputMask = "999.99"
1168:             .FontName  = "Tahoma"
1169:             .FontSize  = 8
1170:             .Visible   = .T.
1171:             .Format    = "K"
1172:         ENDWITH
1173: 
1174:         THIS.AddObject("lbl_4c_Label26", "Label")
1175:         WITH THIS.lbl_4c_Label26
1176:             .Top       = 321
1177:             .Left      = 384
1178:             .Width     = 8
1179:             .Height    = 15
1180:             .Alignment = 0
1181:             .BackStyle = 0
1182:             .FontName  = "Tahoma"
1183:             .FontSize  = 8
1184:             .ForeColor = RGB(90, 90, 90)
1185:             .Caption   = "x"
1186:             .Visible   = .T.
1187:         ENDWITH
1188: 
1189:         THIS.AddObject("txt_4c_Text28", "TextBox")
1190:         WITH THIS.txt_4c_Text28
1191:             .Top       = 320
1192:             .Left      = 391
1193:             .Width     = 41
1194:             .Height    = 18
1195:             .Value     = 0
1196:             .InputMask = "999.99"
1197:             .FontName  = "Tahoma"
1198:             .FontSize  = 8
1199:             .Visible   = .T.
1200:             .Format    = "K"
1201:         ENDWITH
1202: 
1203:         *-- Secao "Impressora / Fonte"
1204:         THIS.AddObject("lbl_4c_Label35", "Label")
1205:         WITH THIS.lbl_4c_Label35
1206:             .Top       = 348
1207:             .Left      = 122
1208:             .Width     = 112
1209:             .Height    = 15
1210:             .Alignment = 0
1211:             .BackStyle = 0
1212:             .FontBold  = .T.
1213:             .FontName  = "Tahoma"
1214:             .FontSize  = 8
1215:             .ForeColor = RGB(90, 90, 90)
1216:             .Caption   = "Impressora / Fonte"
1217:             .Visible   = .T.
1218:         ENDWITH
1219: 
1220:         THIS.AddObject("shp_4c_Shape4", "Shape")
1221:         WITH THIS.shp_4c_Shape4
1222:             .Top        = 364
1223:             .Left       = 109
1224:             .Width      = 262
1225:             .Height     = 2
1226:             .BackStyle  = 1
1227:             .BackColor  = RGB(192, 192, 192)
1228:             .BorderStyle = 0
1229:             .Visible    = .T.
1230:         ENDWITH
1231: 
1232:         *-- Nome da Impressora (cnomeimps) - validado em Text29LostFocus
1233:         THIS.AddObject("lbl_4c_Label32", "Label")
1234:         WITH THIS.lbl_4c_Label32
1235:             .Top       = 371
1236:             .Left      = 122
1237:             .Width     = 101
1238:             .Height    = 15
1239:             .Alignment = 0
1240:             .BackStyle = 0
1241:             .FontName  = "Tahoma"
1242:             .FontSize  = 8
1243:             .ForeColor = RGB(90, 90, 90)
1244:             .Caption   = "Nome da Impressora"
1245:             .Visible   = .T.
1246:         ENDWITH
1247: 
1248:         THIS.AddObject("txt_4c_Text29", "TextBox")
1249:         WITH THIS.txt_4c_Text29
1250:             .Top       = 384
1251:             .Left      = 122
1252:             .Width     = 240
1253:             .Height    = 18
1254:             .Value     = ""
1255:             .MaxLength = 128
1256:             .FontName  = "Tahoma"
1257:             .FontSize  = 8
1258:             .Visible   = .T.
1259:             .Format    = "K"
1260:         ENDWITH
1261:         BINDEVENT(THIS.txt_4c_Text29, "LostFocus", THIS, "Text29LostFocus")
1262: 
1263:         *-- Fonte Padrao (cfontepdrs) - validada em Text30LostFocus
1264:         THIS.AddObject("lbl_4c_Label33", "Label")
1265:         WITH THIS.lbl_4c_Label33
1266:             .Top       = 404
1267:             .Left      = 122
1268:             .Width     = 67
1269:             .Height    = 15
1270:             .Alignment = 0
1271:             .BackStyle = 0
1272:             .FontName  = "Tahoma"
1273:             .FontSize  = 8
1274:             .ForeColor = RGB(90, 90, 90)
1275:             .Caption   = "Fonte Padr" + CHR(227) + "o"
1276:             .Visible   = .T.
1277:         ENDWITH
1278: 
1279:         THIS.AddObject("txt_4c_Text30", "TextBox")
1280:         WITH THIS.txt_4c_Text30
1281:             .Top       = 418
1282:             .Left      = 122
1283:             .Width     = 192
1284:             .Height    = 18
1285:             .Value     = ""
1286:             .MaxLength = 128
1287:             .FontName  = "Tahoma"
1288:             .FontSize  = 8
1289:             .Visible   = .T.
1290:             .Format    = "K"
1291:         ENDWITH
1292:         BINDEVENT(THIS.txt_4c_Text30, "LostFocus", THIS, "Text30LostFocus")
1293: 
1294:         *-- Tamanho da fonte (ntamfontes) - atualizado automaticamente por Text30LostFocus
1295:         THIS.AddObject("lbl_4c_Label34", "Label")
1296:         WITH THIS.lbl_4c_Label34
1297:             .Top       = 404
1298:             .Left      = 323
1299:             .Width     = 46
1300:             .Height    = 15
1301:             .Alignment = 0
1302:             .BackStyle = 0
1303:             .FontName  = "Tahoma"
1304:             .FontSize  = 8
1305:             .ForeColor = RGB(90, 90, 90)
1306:             .Caption   = "Tamanho"
1307:             .Visible   = .T.
1308:         ENDWITH
1309: 
1310:         THIS.AddObject("txt_4c_Text31", "TextBox")
1311:         WITH THIS.txt_4c_Text31
1312:             .Top       = 418
1313:             .Left      = 323
1314:             .Width     = 41
1315:             .Height    = 18
1316:             .Value     = 0
1317:             .InputMask = "999"
1318:             .FontName  = "Tahoma"
1319:             .FontSize  = 8
1320:             .Visible   = .T.
1321:             .Format    = "K"
1322:         ENDWITH
1323: 
1324:         *-- Secao "Folha" - Tamanho da Folha (ctamfolha, fwget no legado)
1325:         THIS.AddObject("lbl_4c_Label39", "Label")
1326:         WITH THIS.lbl_4c_Label39
1327:             .Top       = 446
1328:             .Left      = 126
1329:             .Width     = 32
1330:             .Height    = 15
1331:             .Alignment = 0
1332:             .BackStyle = 0
1333:             .FontBold  = .T.
1334:             .FontName  = "Tahoma"
1335:             .FontSize  = 8
1336:             .ForeColor = RGB(90, 90, 90)
1337:             .Caption   = "Folha"
1338:             .Visible   = .T.
1339:         ENDWITH
1340: 
1341:         THIS.AddObject("shp_4c_Shape5", "Shape")
1342:         WITH THIS.shp_4c_Shape5
1343:             .Top        = 462
1344:             .Left       = 109
1345:             .Width      = 262
1346:             .Height     = 2
1347:             .BackStyle  = 1
1348:             .BackColor  = RGB(192, 192, 192)
1349:             .BorderStyle = 0
1350:             .Visible    = .T.
1351:         ENDWITH
1352: 
1353:         THIS.AddObject("lbl_4c_Label38", "Label")
1354:         WITH THIS.lbl_4c_Label38
1355:             .Top       = 468
1356:             .Left      = 125
1357:             .Width     = 75
1358:             .Height    = 15
1359:             .Alignment = 0
1360:             .BackStyle = 0
1361:             .FontName  = "Tahoma"
1362:             .FontSize  = 8
1363:             .ForeColor = RGB(90, 90, 90)
1364:             .Caption   = "Tamanho Folha"
1365:             .Visible   = .T.
1366:         ENDWITH
1367: 
1368:         THIS.AddObject("txt_4c_Text40", "TextBox")
1369:         WITH THIS.txt_4c_Text40
1370:             .Top       = 481
1371:             .Left      = 124
1372:             .Width     = 244
1373:             .Height    = 19
1374:             .Value     = ""
1375:             .MaxLength = 50
1376:             .FontName  = "Tahoma"

*-- Linhas 1955 a 1963:
1955:     * Unico caminho de saida da tela (form OPERACIONAL flat, sem Page2/Dados
1956:     * para "cancelar a edicao" - abandonar aqui EH fechar). O nome segue o
1957:     * objeto do legado, cmdCancelar; o CommandButton que o dispara chama-se
1958:     * cmd_4c_Encerrar porque "Encerrar" eh a Caption que o SCX declara em
1959:     * Command2 (regra PILAR 1 - a legenda eh a do legado).
1960:     *
1961:     * Recusar a confirmacao mantem a tela aberta, igual ao legado (nao ha
1962:     * ELSE no If dele).
1963:     *--------------------------------------------------------------------------

*-- Linhas 1979 a 1987:
1979:     * O objeto do SCX legado tem duas identidades: Name = "cmdCancelar" (de
1980:     * onde sai BtnCancelarClick, que guarda o corpo transcrito do Click) e
1981:     * Caption = "Encerrar" (de onde sai o nome do controle migrado,
1982:     * cmd_4c_Encerrar, e este metodo). Nao ha dois comportamentos: esta tela
1983:     * eh FLAT, sem Page2/modo de edicao, entao "abandonar as alteracoes" e
1984:     * "encerrar" sao a mesma acao - por isso aqui se DELEGA em vez de
1985:     * duplicar a logica (dois corpos iguais divergiriam na primeira mudanca).
1986:     *
1987:     * Os dois nomes existem porque as duas convencoes do projeto apontam para


### BO (C:\4c\projeto\app\classes\SigOpCblBO.prg):
*====================================================================
* SIGOPCBLBO.prg
*
* Business Object para Configuracao de Boletos Bancarios
* Tabela: SigCnFBl (registro unico de configuracao de impressao)
* Herda de: BusinessBase
* Form legado: SIGOPCBL.SCX
*====================================================================

DEFINE CLASS SigOpCblBO AS BusinessBase

	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica)

	*-- Identificacao / auditoria do registro
	this_cEmps       = ""   && cemps char(3) - empresa
	this_dDatas      = {}   && ddatas datetime - data da configuracao
	this_cHoras      = ""   && choras char(8) - hora da configuracao
	this_cUsuarios   = ""   && cusuarios char(20) - usuario que configurou
	this_cFpags      = ""   && fpags char(12) - forma de pagamento

	*-- Texto de responsabilidade do cedente e local de pagamento
	this_cTxtcds     = ""   && ctxtcds text - texto de responsabilidade do cedente
	this_cLocals     = ""   && clocals char(100) - texto do local de pagamento
	this_nNtxtlins   = 0    && ntxtlins numeric(3,0) - numero de linhas do texto do cedente
	this_nNtxtcols   = 0    && ntxtcols numeric(3,0) - numero de colunas do texto do cedente

	*-- Posicao de impressao (linha/coluna) - Local de Pagamento
	this_nNlnlocals  = 0    && nlnlocals numeric(5,2) - linha de impressao do local de pagamento
	this_nNcllocals  = 0    && ncllocals numeric(5,2) - coluna de impressao do local de pagamento

	*-- Posicao de impressao (linha/coluna) - Vencimento
	this_nNlndtvencs = 0    && nlndtvencs numeric(5,2) - linha de impressao do vencimento
	this_nNcldtvencs = 0    && ncldtvencs numeric(5,2) - coluna de impressao do vencimento

	*-- Posicao de impressao (linha/coluna) - Data do Documento
	this_nNlndtdocs  = 0    && nlndtdocs numeric(5,2) - linha de impressao da data do documento
	this_nNcldtdocs  = 0    && ncldtdocs numeric(5,2) - coluna de impressao da data do documento

	*-- Posicao de impressao (linha/coluna) - Numero do Documento
	this_nNlnnrdocs  = 0    && nlnnrdocs numeric(5,2) - linha de impressao do numero do documento
	this_nNclnrdocs  = 0    && nclnrdocs numeric(5,2) - coluna de impressao do numero do documento

	*-- Posicao de impressao (linha/coluna) - Valor do Documento
	this_nNlnvldocs  = 0    && nlnvldocs numeric(5,2) - linha de impressao do valor do documento
	this_nNclvldocs  = 0    && nclvldocs numeric(5,2) - coluna de impressao do valor do documento

	*-- Posicao de impressao (linha/coluna) - Texto do Cedente
	this_nNlntxtcds  = 0    && nlntxtcds numeric(5,2) - linha de impressao do texto do cedente
	this_nNcltxtcds  = 0    && ncltxtcds numeric(5,2) - coluna de impressao do texto do cedente

	*-- Posicao de impressao (linha/coluna) - Sacado: Razao Social
	this_nNlnrazclis = 0    && nlnrazclis numeric(5,2) - linha de impressao da razao social
	this_nNclrazclis = 0    && nclrazclis numeric(5,2) - coluna de impressao da razao social

	*-- Posicao de impressao (linha/coluna) - Sacado: C.G.C./C.P.F.
	this_nNlncgcclis = 0    && nlncgcclis numeric(5,2) - linha de impressao do CGC/CPF
	this_nNclcgcclis = 0    && nclcgcclis numeric(5,2) - coluna de impressao do CGC/CPF

	*-- Posicao de impressao (linha/coluna) - Sacado: Endereco
	this_nNlnendcobs = 0    && nlnendcobs numeric(5,2) - linha de impressao do endereco
	this_nNclendcobs = 0    && nclendcobs numeric(5,2) - coluna de impressao do endereco

	*-- Posicao de impressao (linha/coluna) - Sacado: Bairro
	this_nNlnbaicobs = 0    && nlnbaicobs numeric(5,2) - linha de impressao do bairro
	this_nNclbaicobs = 0    && nclbaicobs numeric(5,2) - coluna de impressao do bairro

	*-- Posicao de impressao (linha/coluna) - Sacado: Cidade
	this_nNlncidcobs = 0    && nlncidcobs numeric(5,2) - linha de impressao da cidade
	this_nNclcidcobs = 0    && nclcidcobs numeric(5,2) - coluna de impressao da cidade

	*-- Posicao de impressao (linha/coluna) - Sacado: U.F.
	this_nNlnestcobs = 0    && nlnestcobs numeric(5,2) - linha de impressao da UF
	this_nNclestcobs = 0    && nclestcobs numeric(5,2) - coluna de impressao da UF

	*-- Posicao de impressao (linha/coluna) - Sacado: C.E.P.
	this_nNlncepcobs = 0    && nlncepcobs numeric(5,2) - linha de impressao do CEP
	this_nNclcepcobs = 0    && nclcepcobs numeric(5,2) - coluna de impressao do CEP

	*-- Impressora / Fonte padrao
	this_cNomeimps   = ""   && cnomeimps char(128) - nome da impressora padrao
	this_cFontepdrs  = ""   && cfontepdrs char(128) - fonte padrao de impressao
	this_nTamfontes  = 0    && ntamfontes numeric(3,0) - tamanho da fonte padrao

	*-- Tamanho da folha (driver/codigo/descricao concatenados)
	this_cTamfolha   = ""   && ctamfolha char(50) - tamanho de folha configurado na impressora

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCnFBl"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves eh a PK real de SigCnFBl (constraint
	* sigcnfbl_cidchaves em docs\schema.sql), usada pelo RegistrarAuditoria
	* herdado da BusinessBase.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
	ENDPROC

	*====================================================================
	* CarregarRegistroUnico - Replica o Init legado: "Select * From SigCnFBl"
	* + "Go Top" + "If Eof() / Append Blank / EndIf". SigCnFBl eh tabela de
	* configuracao UNICA (um boleto por empresa) - se ja existe o registro,
	* carrega e entra em modo EDICAO; se a tabela estiver vazia (1a execucao
	* no ambiente), entra em modo INCLUSAO com os defaults da classe (equivalente
	* ao Append Blank do legado, que cria a linha em branco no cursor).
	*====================================================================
	PROCEDURE CarregarRegistroUnico()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT * FROM SigCnFBl"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Dados") > 0
					SELECT cursor_4c_Dados
					GO TOP
					THIS.CarregarDoCursor("cursor_4c_Dados")
					THIS.EditarRegistro()
				ELSE
					THIS.NovoRegistro()
				ENDIF
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao carregar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia as 40 colunas de SigCnFBl (par_cAliasCursor)
	* para as properties do BO.
	*
	* Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
	* [[feedback_tratarnulo_2o_arg_eh_valor_padrao]]: o 2o argumento de
	* TratarNulo() eh o VALOR PADRAO do tipo da coluna, nunca um codigo de
	* tipo - "" para char, 0 para numeric, {} para date/datetime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
				THIS.this_cEmps       = TratarNulo(cemps, "")
				THIS.this_dDatas      = TratarNulo(ddatas, {})
				THIS.this_cHoras      = TratarNulo(choras, "")
				THIS.this_cUsuarios   = TratarNulo(cusuarios, "")
				THIS.this_cFpags      = TratarNulo(fpags, "")

				THIS.this_cTxtcds     = TratarNulo(ctxtcds, "")
				THIS.this_cLocals     = TratarNulo(clocals, "")
				THIS.this_nNtxtlins   = TratarNulo(ntxtlins, 0)
				THIS.this_nNtxtcols   = TratarNulo(ntxtcols, 0)

				THIS.this_nNlnlocals  = TratarNulo(nlnlocals, 0)
				THIS.this_nNcllocals  = TratarNulo(ncllocals, 0)

				THIS.this_nNlndtvencs = TratarNulo(nlndtvencs, 0)
				THIS.this_nNcldtvencs = TratarNulo(ncldtvencs, 0)

				THIS.this_nNlndtdocs  = TratarNulo(nlndtdocs, 0)
				THIS.this_nNcldtdocs  = TratarNulo(ncldtdocs, 0)

				THIS.this_nNlnnrdocs  = TratarNulo(nlnnrdocs, 0)
				THIS.this_nNclnrdocs  = TratarNulo(nclnrdocs, 0)

				THIS.this_nNlnvldocs  = TratarNulo(nlnvldocs, 0)
				THIS.this_nNclvldocs  = TratarNulo(nclvldocs, 0)

				THIS.this_nNlntxtcds  = TratarNulo(nlntxtcds, 0)
				THIS.this_nNcltxtcds  = TratarNulo(ncltxtcds, 0)

				THIS.this_nNlnrazclis = TratarNulo(nlnrazclis, 0)
				THIS.this_nNclrazclis = TratarNulo(nclrazclis, 0)

				THIS.this_nNlncgcclis = TratarNulo(nlncgcclis, 0)
				THIS.this_nNclcgcclis = TratarNulo(nclcgcclis, 0)

				THIS.this_nNlnendcobs = TratarNulo(nlnendcobs, 0)
				THIS.this_nNclendcobs = TratarNulo(nclendcobs, 0)

				THIS.this_nNlnbaicobs = TratarNulo(nlnbaicobs, 0)
				THIS.this_nNclbaicobs = TratarNulo(nclbaicobs, 0)

				THIS.this_nNlncidcobs = TratarNulo(nlncidcobs, 0)
				THIS.this_nNclcidcobs = TratarNulo(nclcidcobs, 0)

				THIS.this_nNlnestcobs = TratarNulo(nlnestcobs, 0)
				THIS.this_nNclestcobs = TratarNulo(nclestcobs, 0)

				THIS.this_nNlncepcobs = TratarNulo(nlncepcobs, 0)
				THIS.this_nNclcepcobs = TratarNulo(nclcepcobs, 0)

				THIS.this_cNomeimps   = TratarNulo(cnomeimps, "")
				THIS.this_cFontepdrs  = TratarNulo(cfontepdrs, "")
				THIS.this_nTamfontes  = TratarNulo(ntamfontes, 0)

				THIS.this_cTamfolha   = TratarNulo(ctamfolha, "")

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - grava a configuracao de boletos quando ainda nao existe
	* nenhum registro em SigCnFBl (tabela de configuracao unica - Init do
	* legado faz Append Blank so quando a tabela esta vazia).
	*
	* Regra CLAUDE.md #22 - cidchaves (PK Fortyus) nunca vai em branco,
	* senao um segundo registro colidiria no indice unico; gerar com
	* fUniqueIds() quando a property ainda nao tem valor.
	*
	* Os campos de auditoria (Datas/Horas/Usuarios) sao preenchidos aqui
	* na gravacao, igual ao legado (cmdOk.Click: m.dDatas = Date(),
	* m.cHoras = Time(), m.cUsuarios = m.Usuar).
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .F.

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			THIS.this_dDatas = DATE()
			THIS.this_cHoras = TIME()
			IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuarios, ""))) AND TYPE("gc_4c_UsuarioLogado") = "C"
				THIS.this_cUsuarios = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCnFBl (" + ;
				"cidchaves, cemps, ddatas, choras, cusuarios, fpags, " + ;
				"ctxtcds, clocals, ntxtlins, ntxtcols, " + ;
				"nlnlocals, ncllocals, nlndtvencs, ncldtvencs, " + ;
				"nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs, " + ;
				"nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, " + ;
				"nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis, " + ;
				"nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs, " + ;
				"nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs, " + ;
				"nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs, " + ;
				"ntamfontes, ctamfolha) VALUES (" + ;
				EscaparSQL(THIS.this_cCidchaves) + ", " + EscaparSQL(THIS.this_cEmps) + ", " + ;
				FormatarDataSQL(THIS.this_dDatas) + ", " + EscaparSQL(THIS.this_cHoras) + ", " + ;
				EscaparSQL(THIS.this_cUsuarios) + ", " + EscaparSQL(THIS.this_cFpags) + ", "

			loc_cSQL = loc_cSQL + ;
				EscaparSQL(THIS.this_cTxtcds) + ", " + EscaparSQL(THIS.this_cLocals) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNtxtlins, 0) + ", " + FormatarNumeroSQL(THIS.this_nNtxtcols, 0) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnlocals, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcllocals, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlndtvencs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcldtvencs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlndtdocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcldtdocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnnrdocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclnrdocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnvldocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclvldocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlntxtcds, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcltxtcds, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlnrazclis, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclrazclis, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlncgcclis, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcgcclis, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnendcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclendcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnbaicobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclbaicobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlncidcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcidcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnestcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclestcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlncepcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcepcobs, 2) + ", " + ;
				EscaparSQL(THIS.this_cNomeimps) + ", " + EscaparSQL(THIS.this_cFontepdrs) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nTamfontes, 0) + ", " + EscaparSQL(THIS.this_cTamfolha) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao gravar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
				THIS.this_lErroExibido = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
			THIS.this_lErroExibido = .T.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - grava alteracoes na configuracao de boletos ja existente
	* (caminho normal: SigCnFBl tem sempre um unico registro, confirmado
	* pelo Init legado que aparece apos o primeiro Confirmar).
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .F.

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.

		TRY
			THIS.this_dDatas = DATE()
			THIS.this_cHoras = TIME()
			IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuarios, ""))) AND TYPE("gc_4c_UsuarioLogado") = "C"
				THIS.this_cUsuarios = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)
			ENDIF

			loc_cSQL = "UPDATE SigCnFBl SET " + ;
				"cemps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
				"ddatas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
				"choras = " + EscaparSQL(THIS.this_cHoras) + ", " + ;
				"cusuarios = " + EscaparSQL(THIS.this_cUsuarios) + ", " + ;
				"fpags = " + EscaparSQL(THIS.this_cFpags) + ", "

			loc_cSQL = loc_cSQL + ;
				"ctxtcds = " + EscaparSQL(THIS.this_cTxtcds) + ", " + ;
				"clocals = " + EscaparSQL(THIS.this_cLocals) + ", " + ;
				"ntxtlins = " + FormatarNumeroSQL(THIS.this_nNtxtlins, 0) + ", " + ;
				"ntxtcols = " + FormatarNumeroSQL(THIS.this_nNtxtcols, 0) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnlocals = " + FormatarNumeroSQL(THIS.this_nNlnlocals, 2) + ", " + ;
				"ncllocals = " + FormatarNumeroSQL(THIS.this_nNcllocals, 2) + ", " + ;
				"nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlndtvencs, 2) + ", " + ;
				"ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNcldtvencs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlndtdocs = " + FormatarNumeroSQL(THIS.this_nNlndtdocs, 2) + ", " + ;
				"ncldtdocs = " + FormatarNumeroSQL(THIS.this_nNcldtdocs, 2) + ", " + ;
				"nlnnrdocs = " + FormatarNumeroSQL(THIS.this_nNlnnrdocs, 2) + ", " + ;
				"nclnrdocs = " + FormatarNumeroSQL(THIS.this_nNclnrdocs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnvldocs = " + FormatarNumeroSQL(THIS.this_nNlnvldocs, 2) + ", " + ;
				"nclvldocs = " + FormatarNumeroSQL(THIS.this_nNclvldocs, 2) + ", " + ;
				"nlntxtcds = " + FormatarNumeroSQL(THIS.this_nNlntxtcds, 2) + ", " + ;
				"ncltxtcds = " + FormatarNumeroSQL(THIS.this_nNcltxtcds, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnrazclis, 2) + ", " + ;
				"nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclrazclis, 2) + ", " + ;
				"nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlncgcclis, 2) + ", " + ;
				"nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclcgcclis, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnendcobs, 2) + ", " + ;
				"nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclendcobs, 2) + ", " + ;
				"nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnbaicobs, 2) + ", " + ;
				"nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclbaicobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlncidcobs, 2) + ", " + ;
				"nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclcidcobs, 2) + ", " + ;
				"nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnestcobs, 2) + ", " + ;
				"nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclestcobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlncepcobs, 2) + ", " + ;
				"nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclcepcobs, 2) + ", " + ;
				"cnomeimps = " + EscaparSQL(THIS.this_cNomeimps) + ", " + ;
				"cfontepdrs = " + EscaparSQL(THIS.this_cFontepdrs) + ", "

			loc_cSQL = loc_cSQL + ;
				"ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamfontes, 0) + ", " + ;
				"ctamfolha = " + EscaparSQL(THIS.this_cTamfolha) + ;
				" WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao atualizar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
				THIS.this_lErroExibido = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
			THIS.this_lErroExibido = .T.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SincronizarTamanhoFolhaSigCqMat - replica o update de SigCqMat feito
	* dentro do cmdOk.Click legado, APOS o Update de crSigCnFBL:
	*
	*   lcQuery = [Select * ] + [From SigCqMat]
	*   If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigCqMat') < 1)
	*       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
	*       Return 0
	*   EndIf
	*   If (Not Eof('csSigCqMat') And Not IsEmpty(m.lcTamFolha))
	*       lcQuery = [Update SigCqMat Set ctamanho=']+m.lcTamFolha+[']
	*       ... SqlExecute ...
	*   EndIf
	*
	* SigCqMat eh tabela de OUTRO modulo (controle de qualidade) - nao faz
	* parte do schema de SigCnFBl, mas o legado sincroniza o tamanho de
	* folha configurado aqui com o registro de la, quando ele existe.
	*====================================================================
	PROCEDURE SincronizarTamanhoFolhaSigCqMat(par_cTamFolha)
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .T.

		TRY
			IF USED("cursor_4c_SigCqMat")
				USE IN cursor_4c_SigCqMat
			ENDIF

			loc_cSQL = "SELECT * FROM SigCqMat"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCqMat")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_SigCqMat") > 0 AND !EMPTY(par_cTamFolha)
					loc_cSQL = "UPDATE SigCqMat SET ctamanho = " + EscaparSQL(par_cTamFolha)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

					IF loc_nResultado < 0
						MostrarErro("Favor Reinicializar o Processo!!!", ;
							"Falha na Conex" + CHR(227) + "o (SigCqMat)")
						loc_lSucesso = .F.
					ENDIF
				ENDIF
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!", ;
					"Falha na Conex" + CHR(227) + "o (SigCqMat)")
				loc_lSucesso = .F.
			ENDIF

			IF USED("cursor_4c_SigCqMat")
				USE IN cursor_4c_SigCqMat
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

