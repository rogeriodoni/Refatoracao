# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [ALINHAMENTO] Botao 'cmd_4c_Imprimir' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [FONTNAME-ERRADO] Linha 1434: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1455: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1475: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1505: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2623 linhas total):

*-- Linhas 100 a 145:
100:         THIS.AddObject("cnt_4c_Sombra", "Container")
101:         loc_oCnt = THIS.cnt_4c_Sombra
102:         WITH loc_oCnt
103:             .Top        = 0
104:             .Left       = 0
105:             .Width      = THIS.Width
106:             .Height     = 80
107:             .BorderWidth= 0
108:             .BackColor  = RGB(100,100,100)
109:             .Visible    = .T.
110:             .AddObject("lbl_4c_LblSombra", "Label")
111:             WITH .lbl_4c_LblSombra
112:                 .FontBold      = .T.
113:                 .FontName      = "Tahoma"
114:                 .FontSize      = 18
115:                 .FontUnderline = .F.
116:                 .WordWrap      = .T.
117:                 .Alignment     = 0
118:                 .AutoSize      = .F.
119:                 .BackStyle     = 0
120:                 .Caption       = THIS.Parent.Caption
121:                 .Height        = 40
122:                 .Left          = 10
123:                 .Top           = 18
124:                 .Width         = THIS.Width
125:                 .ForeColor     = RGB(0,0,0)
126:                 .Visible       = .T.
127:             ENDWITH
128:             .AddObject("lbl_4c_LblTitulo", "Label")
129:             WITH .lbl_4c_LblTitulo
130:                 .FontBold   = .T.
131:                 .FontName   = "Tahoma"
132:                 .FontSize   = 18
133:                 .WordWrap   = .T.
134:                 .Alignment  = 0
135:                 .AutoSize   = .F.
136:                 .BackStyle  = 0
137:                 .Caption    = THIS.Parent.Caption
138:                 .Height     = 46
139:                 .Left       = 10
140:                 .Top        = 17
141:                 .Width      = THIS.Width
142:                 .ForeColor  = RGB(255,255,255)
143:                 .Visible    = .T.
144:             ENDWITH
145:         ENDWITH

*-- Linhas 151 a 627:
151:         LOCAL loc_o
152: 
153:         *-- Label "Filtros" (titulo secao)
154:         THIS.AddObject("lbl_4c_SecFiltros", "Label")
155:         WITH THIS.lbl_4c_SecFiltros
156:             .FontBold  = .T.
157:             .FontName  = "Tahoma"
158:             .FontSize  = 12
159:             .BackStyle = 0
160:             .Caption   = "Filtros"
161:             .Height    = 21
162:             .Left      = 11
163:             .Top       = 94
164:             .AutoSize  = .T.
165:             .ForeColor = RGB(90,90,90)
166:             .Visible   = .T.
167:         ENDWITH
168: 
169:         *-- ----------------------------------------------------------------
170:         *-- ROW 1: Fornecedor (Top=88)
171:         *-- ----------------------------------------------------------------
172:         THIS.AddObject("lbl_4c_Fornecedor", "Label")
173:         WITH THIS.lbl_4c_Fornecedor
174:             .AutoSize  = .T.
175:             .FontName  = "Tahoma"
176:             .FontSize  = 8
177:             .BackStyle = 0
178:             .Caption   = "Fornecedor :"
179:             .Height    = 15
180:             .Left      = 79
181:             .Top       = 92
182:             .ForeColor = RGB(90,90,90)
183:             .Visible   = .T.
184:         ENDWITH
185: 
186:         THIS.AddObject("txt_4c_CFornecs", "TextBox")
187:         WITH THIS.txt_4c_CFornecs
188:             .FontName      = "Tahoma"
189:             .FontSize      = 8
190:             .BorderStyle   = 1
191:             .Format        = "K!"
192:             .Height        = 23
193:             .Left          = 145
194:             .MaxLength     = 10
195:             .SpecialEffect = 1
196:             .Top           = 88
197:             .Width         = 80
198:             .ForeColor     = RGB(0,0,0)
199:             .Visible       = .T.
200:         ENDWITH
201: 
202:         THIS.AddObject("txt_4c_DFornecs", "TextBox")
203:         WITH THIS.txt_4c_DFornecs
204:             .FontName      = "Tahoma"
205:             .FontSize      = 8
206:             .BorderStyle   = 1
207:             .Format        = "K"
208:             .Height        = 23
209:             .Left          = 228
210:             .MaxLength     = 40
211:             .SpecialEffect = 1
212:             .Top           = 88
213:             .Width         = 197
214:             .ReadOnly      = .T.
215:             .ForeColor     = RGB(0,0,0)
216:             .Visible       = .T.
217:         ENDWITH
218: 
219:         *-- ----------------------------------------------------------------
220:         *-- ROW 2: Grande Grupo (Top=113)
221:         *-- ----------------------------------------------------------------
222:         THIS.AddObject("lbl_4c_MercI", "Label")
223:         WITH THIS.lbl_4c_MercI
224:             .FontName  = "Tahoma"
225:             .FontSize  = 8
226:             .BackStyle = 0
227:             .Caption   = "Grande Grupo :"
228:             .Height    = 15
229:             .Left      = 67
230:             .Top       = 117
231:             .AutoSize  = .T.
232:             .ForeColor = RGB(90,90,90)
233:             .Visible   = .T.
234:         ENDWITH
235: 
236:         THIS.AddObject("txt_4c_MercI", "TextBox")
237:         WITH THIS.txt_4c_MercI
238:             .BorderStyle   = 1
239:             .Height        = 23
240:             .Left          = 145
241:             .MaxLength     = 3
242:             .SpecialEffect = 1
243:             .Top           = 113
244:             .Width         = 31
245:             .ForeColor     = RGB(0,0,0)
246:             .Visible       = .T.
247:         ENDWITH
248: 
249:         THIS.AddObject("lbl_4c_AteMercI", "Label")
250:         WITH THIS.lbl_4c_AteMercI
251:             .FontName  = "Tahoma"
252:             .FontSize  = 8
253:             .BackStyle = 0
254:             .Caption   = "at" + CHR(233)
255:             .Left      = 179
256:             .Top       = 117
257:             .AutoSize  = .T.
258:             .ForeColor = RGB(90,90,90)
259:             .Visible   = .T.
260:         ENDWITH
261: 
262:         THIS.AddObject("txt_4c_MercF", "TextBox")
263:         WITH THIS.txt_4c_MercF
264:             .BorderStyle   = 1
265:             .Height        = 23
266:             .Left          = 198
267:             .MaxLength     = 3
268:             .SpecialEffect = 1
269:             .Top           = 113
270:             .Width         = 31
271:             .ForeColor     = RGB(0,0,0)
272:             .Visible       = .T.
273:         ENDWITH
274: 
275:         *-- ----------------------------------------------------------------
276:         *-- ROW 3: Grupo (Top=138)
277:         *-- ----------------------------------------------------------------
278:         THIS.AddObject("lbl_4c_CGrui", "Label")
279:         WITH THIS.lbl_4c_CGrui
280:             .FontName  = "Tahoma"
281:             .FontSize  = 8
282:             .BackStyle = 0
283:             .Caption   = "Grupo :"
284:             .Height    = 15
285:             .Left      = 105
286:             .Top       = 142
287:             .AutoSize  = .T.
288:             .ForeColor = RGB(90,90,90)
289:             .Visible   = .T.
290:         ENDWITH
291: 
292:         THIS.AddObject("txt_4c_CGrui", "TextBox")
293:         WITH THIS.txt_4c_CGrui
294:             .BorderStyle   = 1
295:             .Height        = 23
296:             .Left          = 145
297:             .MaxLength     = 3
298:             .SpecialEffect = 1
299:             .Top           = 138
300:             .Width         = 31
301:             .ForeColor     = RGB(0,0,0)
302:             .Visible       = .T.
303:         ENDWITH
304: 
305:         THIS.AddObject("lbl_4c_AteCGrui", "Label")
306:         WITH THIS.lbl_4c_AteCGrui
307:             .FontName  = "Tahoma"
308:             .FontSize  = 8
309:             .BackStyle = 0
310:             .Caption   = "at" + CHR(233)
311:             .Left      = 179
312:             .Top       = 142
313:             .AutoSize  = .T.
314:             .ForeColor = RGB(90,90,90)
315:             .Visible   = .T.
316:         ENDWITH
317: 
318:         THIS.AddObject("txt_4c_CGruf", "TextBox")
319:         WITH THIS.txt_4c_CGruf
320:             .BorderStyle   = 1
321:             .Height        = 23
322:             .Left          = 198
323:             .MaxLength     = 3
324:             .SpecialEffect = 1
325:             .Top           = 138
326:             .Width         = 31
327:             .ForeColor     = RGB(0,0,0)
328:             .Visible       = .T.
329:         ENDWITH
330: 
331:         *-- ----------------------------------------------------------------
332:         *-- ROW 4: Subgrupo (Top=163)
333:         *-- ----------------------------------------------------------------
334:         THIS.AddObject("lbl_4c_SGruI", "Label")
335:         WITH THIS.lbl_4c_SGruI
336:             .FontName  = "Tahoma"
337:             .FontSize  = 8
338:             .BackStyle = 0
339:             .Caption   = "Subgrupo :"
340:             .Height    = 15
341:             .Left      = 88
342:             .Top       = 167
343:             .AutoSize  = .T.
344:             .ForeColor = RGB(90,90,90)
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         THIS.AddObject("txt_4c_SGruI", "TextBox")
349:         WITH THIS.txt_4c_SGruI
350:             .BorderStyle   = 1
351:             .Height        = 23
352:             .Left          = 145
353:             .MaxLength     = 6
354:             .SpecialEffect = 1
355:             .Top           = 163
356:             .Width         = 52
357:             .ForeColor     = RGB(0,0,0)
358:             .Visible       = .T.
359:         ENDWITH
360: 
361:         THIS.AddObject("lbl_4c_AteSGruI", "Label")
362:         WITH THIS.lbl_4c_AteSGruI
363:             .FontName  = "Tahoma"
364:             .FontSize  = 8
365:             .BackStyle = 0
366:             .Caption   = "at" + CHR(233)
367:             .Left      = 201
368:             .Top       = 167
369:             .AutoSize  = .T.
370:             .ForeColor = RGB(90,90,90)
371:             .Visible   = .T.
372:         ENDWITH
373: 
374:         THIS.AddObject("txt_4c_SGruF", "TextBox")
375:         WITH THIS.txt_4c_SGruF
376:             .BorderStyle   = 1
377:             .Height        = 23
378:             .Left          = 220
379:             .MaxLength     = 6
380:             .SpecialEffect = 1
381:             .Top           = 163
382:             .Width         = 52
383:             .ForeColor     = RGB(0,0,0)
384:             .Visible       = .T.
385:         ENDWITH
386: 
387:         *-- ----------------------------------------------------------------
388:         *-- ROW 5: Unidade (Top=189)
389:         *-- ----------------------------------------------------------------
390:         THIS.AddObject("lbl_4c_CUniI", "Label")
391:         WITH THIS.lbl_4c_CUniI
392:             .FontName  = "Tahoma"
393:             .FontSize  = 8
394:             .BackStyle = 0
395:             .Caption   = "Unidade :"
396:             .Height    = 15
397:             .Left      = 95
398:             .Top       = 193
399:             .AutoSize  = .T.
400:             .ForeColor = RGB(90,90,90)
401:             .Visible   = .T.
402:         ENDWITH
403: 
404:         THIS.AddObject("txt_4c_CUniI", "TextBox")
405:         WITH THIS.txt_4c_CUniI
406:             .BorderStyle   = 1
407:             .Height        = 23
408:             .Left          = 145
409:             .MaxLength     = 3
410:             .SpecialEffect = 1
411:             .Top           = 189
412:             .Width         = 31
413:             .ForeColor     = RGB(0,0,0)
414:             .Visible       = .T.
415:         ENDWITH
416: 
417:         THIS.AddObject("lbl_4c_AteCUniI", "Label")
418:         WITH THIS.lbl_4c_AteCUniI
419:             .FontName  = "Tahoma"
420:             .FontSize  = 8
421:             .BackStyle = 0
422:             .Caption   = "at" + CHR(233)
423:             .Left      = 179
424:             .Top       = 193
425:             .AutoSize  = .T.
426:             .ForeColor = RGB(90,90,90)
427:             .Visible   = .T.
428:         ENDWITH
429: 
430:         THIS.AddObject("txt_4c_CUnif", "TextBox")
431:         WITH THIS.txt_4c_CUnif
432:             .BorderStyle   = 1
433:             .Height        = 23
434:             .Left          = 198
435:             .MaxLength     = 3
436:             .SpecialEffect = 1
437:             .Top           = 189
438:             .Width         = 31
439:             .ForeColor     = RGB(0,0,0)
440:             .Visible       = .T.
441:         ENDWITH
442: 
443:         *-- ----------------------------------------------------------------
444:         *-- ROW 6: Moeda (Top=213)
445:         *-- ----------------------------------------------------------------
446:         THIS.AddObject("lbl_4c_MoeI", "Label")
447:         WITH THIS.lbl_4c_MoeI
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .BackStyle = 0
451:             .Caption   = "Moeda :"
452:             .Height    = 15
453:             .Left      = 102
454:             .Top       = 217
455:             .AutoSize  = .T.
456:             .ForeColor = RGB(90,90,90)
457:             .Visible   = .T.
458:         ENDWITH
459: 
460:         THIS.AddObject("txt_4c_MoeI", "TextBox")
461:         WITH THIS.txt_4c_MoeI
462:             .BorderStyle   = 1
463:             .Height        = 23
464:             .Left          = 145
465:             .MaxLength     = 3
466:             .SpecialEffect = 1
467:             .Top           = 213
468:             .Width         = 31
469:             .ForeColor     = RGB(0,0,0)
470:             .Visible       = .T.
471:         ENDWITH
472: 
473:         THIS.AddObject("lbl_4c_AteMoeI", "Label")
474:         WITH THIS.lbl_4c_AteMoeI
475:             .FontName  = "Tahoma"
476:             .FontSize  = 8
477:             .BackStyle = 0
478:             .Caption   = "at" + CHR(233)
479:             .Left      = 179
480:             .Top       = 217
481:             .AutoSize  = .T.
482:             .ForeColor = RGB(90,90,90)
483:             .Visible   = .T.
484:         ENDWITH
485: 
486:         THIS.AddObject("txt_4c_MoeF", "TextBox")
487:         WITH THIS.txt_4c_MoeF
488:             .BorderStyle   = 1
489:             .Height        = 23
490:             .Left          = 198
491:             .MaxLength     = 3
492:             .SpecialEffect = 1
493:             .Top           = 213
494:             .Width         = 31
495:             .ForeColor     = RGB(0,0,0)
496:             .Visible       = .T.
497:         ENDWITH
498: 
499:         *-- ----------------------------------------------------------------
500:         *-- RIGHT COLUMN: Linha (Top=88)
501:         *-- ----------------------------------------------------------------
502:         THIS.AddObject("lbl_4c_LinhI", "Label")
503:         WITH THIS.lbl_4c_LinhI
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .BackStyle = 0
507:             .Caption   = "Linha :"
508:             .Height    = 15
509:             .Left      = 503
510:             .Top       = 92
511:             .AutoSize  = .T.
512:             .ForeColor = RGB(90,90,90)
513:             .Visible   = .T.
514:         ENDWITH
515: 
516:         THIS.AddObject("txt_4c_LinhI", "TextBox")
517:         WITH THIS.txt_4c_LinhI
518:             .BorderStyle   = 1
519:             .Format        = "K"
520:             .Height        = 23
521:             .Left          = 539
522:             .MaxLength     = 10
523:             .SpecialEffect = 1
524:             .Top           = 88
525:             .Width         = 84
526:             .ForeColor     = RGB(0,0,0)
527:             .Visible       = .T.
528:         ENDWITH
529: 
530:         THIS.AddObject("lbl_4c_AteLinhI", "Label")
531:         WITH THIS.lbl_4c_AteLinhI
532:             .FontName  = "Tahoma"
533:             .FontSize  = 8
534:             .BackStyle = 0
535:             .Caption   = "at" + CHR(233)
536:             .Left      = 627
537:             .Top       = 92
538:             .AutoSize  = .T.
539:             .ForeColor = RGB(90,90,90)
540:             .Visible   = .T.
541:         ENDWITH
542: 
543:         THIS.AddObject("txt_4c_LinhF", "TextBox")
544:         WITH THIS.txt_4c_LinhF
545:             .BorderStyle   = 1
546:             .Format        = "K"
547:             .Height        = 23
548:             .Left          = 649
549:             .MaxLength     = 10
550:             .SpecialEffect = 1
551:             .Top           = 88
552:             .Width         = 84
553:             .ForeColor     = RGB(0,0,0)
554:             .Visible       = .T.
555:         ENDWITH
556: 
557:         *-- RIGHT COLUMN: Grupo Venda/Colecao (Top=113)
558:         THIS.AddObject("lbl_4c_ColI", "Label")
559:         WITH THIS.lbl_4c_ColI
560:             .FontName  = "Tahoma"
561:             .FontSize  = 8
562:             .BackStyle = 0
563:             .Caption   = "Grupo Venda :"
564:             .Height    = 15
565:             .Left      = 466
566:             .Top       = 117
567:             .AutoSize  = .T.
568:             .ForeColor = RGB(90,90,90)
569:             .Visible   = .T.
570:         ENDWITH
571: 
572:         THIS.AddObject("txt_4c_ColI", "TextBox")
573:         WITH THIS.txt_4c_ColI
574:             .BorderStyle   = 1
575:             .Format        = "K"
576:             .Height        = 23
577:             .Left          = 539
578:             .MaxLength     = 10
579:             .SpecialEffect = 1
580:             .Top           = 113
581:             .Width         = 84
582:             .ForeColor     = RGB(0,0,0)
583:             .Visible       = .T.
584:         ENDWITH
585: 
586:         THIS.AddObject("lbl_4c_AteColI", "Label")
587:         WITH THIS.lbl_4c_AteColI
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .BackStyle = 0
591:             .Caption   = "at" + CHR(233)
592:             .Left      = 627
593:             .Top       = 117
594:             .AutoSize  = .T.
595:             .ForeColor = RGB(90,90,90)
596:             .Visible   = .T.
597:         ENDWITH
598: 
599:         THIS.AddObject("txt_4c_ColF", "TextBox")
600:         WITH THIS.txt_4c_ColF
601:             .BorderStyle   = 1
602:             .Format        = "K"
603:             .Height        = 23
604:             .Left          = 649
605:             .MaxLength     = 10
606:             .SpecialEffect = 1
607:             .Top           = 113
608:             .Width         = 84
609:             .ForeColor     = RGB(0,0,0)
610:             .Visible       = .T.
611:         ENDWITH
612: 
613:         *-- RIGHT COLUMN: Markup (Top=138)
614:         THIS.AddObject("lbl_4c_MrkI", "Label")
615:         WITH THIS.lbl_4c_MrkI
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8
618:             .BackStyle = 0
619:             .Caption   = "Markup :"
620:             .Height    = 15
621:             .Left      = 493
622:             .Top       = 142
623:             .AutoSize  = .T.
624:             .ForeColor = RGB(90,90,90)
625:             .Visible   = .T.
626:         ENDWITH
627: 

*-- Linhas 633 a 657:
633:             .Format        = "K"
634:             .Height        = 23
635:             .InputMask     = "999.99"
636:             .Left          = 539
637:             .MaxLength     = 0
638:             .SpecialEffect = 1
639:             .Top           = 138
640:             .Width         = 84
641:             .ForeColor     = RGB(0,0,0)
642:             .Visible       = .T.
643:         ENDWITH
644: 
645:         THIS.AddObject("lbl_4c_AteMrkI", "Label")
646:         WITH THIS.lbl_4c_AteMrkI
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .BackStyle = 0
650:             .Caption   = "at" + CHR(233)
651:             .Left      = 627
652:             .Top       = 142
653:             .AutoSize  = .T.
654:             .ForeColor = RGB(90,90,90)
655:             .Visible   = .T.
656:         ENDWITH
657: 

*-- Linhas 663 a 689:
663:             .Format        = "K"
664:             .Height        = 23
665:             .InputMask     = "999.99"
666:             .Left          = 649
667:             .MaxLength     = 0
668:             .SpecialEffect = 1
669:             .Top           = 138
670:             .Width         = 84
671:             .ForeColor     = RGB(0,0,0)
672:             .Visible       = .T.
673:         ENDWITH
674: 
675:         *-- RIGHT COLUMN: Encargo (Top=163)
676:         THIS.AddObject("lbl_4c_EncI", "Label")
677:         WITH THIS.lbl_4c_EncI
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .BackStyle = 0
681:             .Caption   = "Encargo :"
682:             .Height    = 15
683:             .Left      = 486
684:             .Top       = 167
685:             .AutoSize  = .T.
686:             .ForeColor = RGB(90,90,90)
687:             .Visible   = .T.
688:         ENDWITH
689: 

*-- Linhas 695 a 719:
695:             .Format        = "K"
696:             .Height        = 23
697:             .InputMask     = "999.99"
698:             .Left          = 539
699:             .MaxLength     = 0
700:             .SpecialEffect = 1
701:             .Top           = 163
702:             .Width         = 84
703:             .ForeColor     = RGB(0,0,0)
704:             .Visible       = .T.
705:         ENDWITH
706: 
707:         THIS.AddObject("lbl_4c_AteEncI", "Label")
708:         WITH THIS.lbl_4c_AteEncI
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .BackStyle = 0
712:             .Caption   = "at" + CHR(233)
713:             .Left      = 627
714:             .Top       = 167
715:             .AutoSize  = .T.
716:             .ForeColor = RGB(90,90,90)
717:             .Visible   = .T.
718:         ENDWITH
719: 

*-- Linhas 725 a 751:
725:             .Format        = "K"
726:             .Height        = 23
727:             .InputMask     = "999.99"
728:             .Left          = 649
729:             .MaxLength     = 0
730:             .SpecialEffect = 1
731:             .Top           = 163
732:             .Width         = 84
733:             .ForeColor     = RGB(0,0,0)
734:             .Visible       = .T.
735:         ENDWITH
736: 
737:         *-- RIGHT COLUMN: Variacao % + Feitio (Top=189)
738:         THIS.AddObject("lbl_4c_Variacao", "Label")
739:         WITH THIS.lbl_4c_Variacao
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .BackStyle = 0
743:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
744:             .Height    = 15
745:             .Left      = 456
746:             .Top       = 193
747:             .AutoSize  = .T.
748:             .ForeColor = RGB(90,90,90)
749:             .Visible   = .T.
750:         ENDWITH
751: 

*-- Linhas 757 a 795:
757:             .Format        = "K"
758:             .Height        = 23
759:             .InputMask     = "999.99"
760:             .Left          = 539
761:             .MaxLength     = 0
762:             .SpecialEffect = 1
763:             .Top           = 189
764:             .Width         = 80
765:             .ForeColor     = RGB(0,0,0)
766:             .Visible       = .T.
767:         ENDWITH
768: 
769:         THIS.AddObject("lbl_4c_Feitio", "Label")
770:         WITH THIS.lbl_4c_Feitio
771:             .FontName  = "Tahoma"
772:             .FontSize  = 8
773:             .BackStyle = 0
774:             .Caption   = "C" + CHR(243) + "digo MKP : "
775:             .Height    = 15
776:             .Left      = 639
777:             .Top       = 193
778:             .AutoSize  = .T.
779:             .ForeColor = RGB(90,90,90)
780:             .Visible   = .T.
781:         ENDWITH
782: 
783:         THIS.AddObject("txt_4c_Feitio", "TextBox")
784:         WITH THIS.txt_4c_Feitio
785:             .BorderStyle   = 1
786:             .Height        = 23
787:             .Left          = 709
788:             .MaxLength     = 2
789:             .SpecialEffect = 1
790:             .Top           = 189
791:             .Width         = 24
792:             .ForeColor     = RGB(0,0,0)
793:             .Visible       = .T.
794:         ENDWITH
795:     ENDPROC

*-- Linhas 803 a 913:
803:             .ButtonCount = 2
804:             .Value       = 1
805:             .Height      = 26
806:             .Left        = 234
807:             .Top         = 211
808:             .Width       = 106
809:             .BackStyle   = 0
810:             .Visible     = .T.
811:             .Buttons(1).Caption     = "\<Ideal"
812:             .Buttons(1).Left        = 5
813:             .Buttons(1).Top         = 5
814:             .Buttons(1).AutoSize    = .T.
815:             .Buttons(1).Themes      = .F.
816:             .Buttons(2).Caption     = "\<Venda"
817:             .Buttons(2).Left        = 53
818:             .Buttons(2).Top         = 6
819:             .Buttons(2).AutoSize    = .T.
820:             .Buttons(2).Themes      = .F.
821:         ENDWITH
822: 
823:         *-- OptionGroup Situacao (Left=536, Top=214)
824:         THIS.AddObject("lbl_4c_Situacao", "Label")
825:         WITH THIS.lbl_4c_Situacao
826:             .FontName  = "Tahoma"
827:             .FontSize  = 8
828:             .BackStyle = 0
829:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
830:             .Left      = 486
831:             .Top       = 217
832:             .AutoSize  = .T.
833:             .ForeColor = RGB(90,90,90)
834:             .Visible   = .T.
835:         ENDWITH
836: 
837:         THIS.AddObject("opg_4c_Situacao", "OptionGroup")
838:         WITH THIS.opg_4c_Situacao
839:             .ButtonCount = 3
840:             .Value       = 3
841:             .Height      = 21
842:             .Left        = 536
843:             .Top         = 214
844:             .Width       = 189
845:             .BackStyle   = 0
846:             .Visible     = .T.
847:             .Buttons(1).Caption     = "\<Ativos"
848:             .Buttons(1).Left        = 5
849:             .Buttons(1).Top         = 3
850:             .Buttons(1).AutoSize    = .T.
851:             .Buttons(1).Themes      = .F.
852:             .Buttons(2).Caption     = "\<Inativos"
853:             .Buttons(2).Left        = 59
854:             .Buttons(2).Top         = 2
855:             .Buttons(2).AutoSize    = .F.
856:             .Buttons(2).Themes      = .F.
857:             .Buttons(3).FontName    = "Tahoma"
858:             .Buttons(3).FontSize    = 8
859:             .Buttons(3).Caption     = "\<Todos"
860:             .Buttons(3).Height      = 17
861:             .Buttons(3).Left        = 125
862:             .Buttons(3).Top         = 2
863:             .Buttons(3).Width       = 61
864:             .Buttons(3).AutoSize    = .F.
865:             .Buttons(3).ForeColor   = RGB(90,90,90)
866:             .Buttons(3).Themes      = .F.
867:         ENDWITH
868: 
869:         *-- OptionGroup Compra (Left=536, Top=234)
870:         THIS.AddObject("lbl_4c_Compra", "Label")
871:         WITH THIS.lbl_4c_Compra
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .BackStyle = 0
875:             .Caption   = "Compra :"
876:             .Left      = 490
877:             .Top       = 237
878:             .AutoSize  = .T.
879:             .ForeColor = RGB(90,90,90)
880:             .Visible   = .T.
881:         ENDWITH
882: 
883:         THIS.AddObject("opg_4c_Compra", "OptionGroup")
884:         WITH THIS.opg_4c_Compra
885:             .ButtonCount = 3
886:             .Value       = 3
887:             .Height      = 21
888:             .Left        = 536
889:             .Top         = 234
890:             .Width       = 204
891:             .BackStyle   = 0
892:             .Visible     = .T.
893:             .Buttons(1).Caption     = "\<Comprar"
894:             .Buttons(1).Left        = 5
895:             .Buttons(1).Top         = 3
896:             .Buttons(1).AutoSize    = .T.
897:             .Buttons(1).Themes      = .F.
898:             .Buttons(2).Caption     = "\<N" + CHR(227) + "o Comprar"
899:             .Buttons(2).Left        = 67
900:             .Buttons(2).Top         = 3
901:             .Buttons(2).AutoSize    = .T.
902:             .Buttons(2).Themes      = .F.
903:             .Buttons(3).FontName    = "Tahoma"
904:             .Buttons(3).FontSize    = 8
905:             .Buttons(3).Caption     = "\<Todos"
906:             .Buttons(3).Height      = 17
907:             .Buttons(3).Left        = 152
908:             .Buttons(3).Top         = 2
909:             .Buttons(3).Width       = 61
910:             .Buttons(3).ForeColor   = RGB(90,90,90)
911:             .Buttons(3).AutoSize    = .F.
912:             .Buttons(3).Themes      = .F.
913:         ENDWITH

*-- Linhas 920 a 1063:
920:         THIS.AddObject("lin_4c_Sep", "Line")
921:         WITH THIS.lin_4c_Sep
922:             .Height = 0
923:             .Left   = 13
924:             .Top    = 258
925:             .Width  = 738
926:             .Visible= .T.
927:         ENDWITH
928: 
929:         *-- Label "Dados" (titulo secao)
930:         THIS.AddObject("lbl_4c_SecDados", "Label")
931:         WITH THIS.lbl_4c_SecDados
932:             .FontBold  = .T.
933:             .FontName  = "Tahoma"
934:             .FontSize  = 12
935:             .BackStyle = 0
936:             .Caption   = "Dados"
937:             .Height    = 21
938:             .Left      = 12
939:             .Top       = 270
940:             .AutoSize  = .T.
941:             .ForeColor = RGB(90,90,90)
942:             .Visible   = .T.
943:         ENDWITH
944: 
945:         *-- Label "Recalcula :" e OptionGroup Recalc (8 opcoes)
946:         THIS.AddObject("lbl_4c_Recalcula", "Label")
947:         WITH THIS.lbl_4c_Recalcula
948:             .FontName  = "Tahoma"
949:             .FontSize  = 8
950:             .BackStyle = 0
951:             .Caption   = "Recalcula :"
952:             .Left      = 89
953:             .Top       = 263
954:             .AutoSize  = .T.
955:             .ForeColor = RGB(90,90,90)
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         THIS.AddObject("opg_4c_Recalc", "OptionGroup")
960:         WITH THIS.opg_4c_Recalc
961:             .ButtonCount = 8
962:             .Value       = 1
963:             .Height      = 41
964:             .Left        = 142
965:             .Top         = 258
966:             .Width       = 439
967:             .BackStyle   = 0
968:             .Visible     = .T.
969:             *-- Row 1: Composicao, Custo Venda, Ambos, Peso Componentes
970:             .Buttons(1).FontName    = "Tahoma"
971:             .Buttons(1).FontSize    = 8
972:             .Buttons(1).Caption     = "\<Composi" + CHR(231) + CHR(227) + "o"
973:             .Buttons(1).Left        = 5
974:             .Buttons(1).Top         = 5
975:             .Buttons(1).AutoSize    = .T.
976:             .Buttons(1).ForeColor   = RGB(90,90,90)
977:             .Buttons(1).Themes      = .F.
978:             .Buttons(2).FontName    = "Tahoma"
979:             .Buttons(2).FontSize    = 8
980:             .Buttons(2).Caption     = "Custo \<Venda"
981:             .Buttons(2).Left        = 98
982:             .Buttons(2).Top         = 5
983:             .Buttons(2).AutoSize    = .T.
984:             .Buttons(2).ForeColor   = RGB(90,90,90)
985:             .Buttons(2).Themes      = .F.
986:             .Buttons(3).FontName    = "Tahoma"
987:             .Buttons(3).FontSize    = 8
988:             .Buttons(3).Caption     = "\<Ambos"
989:             .Buttons(3).Height      = 15
990:             .Buttons(3).Left        = 213
991:             .Buttons(3).Top         = 5
992:             .Buttons(3).Width       = 50
993:             .Buttons(3).AutoSize    = .T.
994:             .Buttons(3).ForeColor   = RGB(90,90,90)
995:             .Buttons(3).Themes      = .F.
996:             .Buttons(4).FontName    = "Tahoma"
997:             .Buttons(4).FontSize    = 8
998:             .Buttons(4).Caption     = "Peso Componentes"
999:             .Buttons(4).Height      = 15
1000:             .Buttons(4).Left        = 312
1001:             .Buttons(4).Top         = 4
1002:             .Buttons(4).Width       = 110
1003:             .Buttons(4).AutoSize    = .T.
1004:             .Buttons(4).ForeColor   = RGB(90,90,90)
1005:             .Buttons(4).Themes      = .F.
1006:             *-- Row 2: Cambio, Cambio Inteiros, Markup Custo, Markup Venda
1007:             .Buttons(5).FontName    = "Tahoma"
1008:             .Buttons(5).FontSize    = 8
1009:             .Buttons(5).Caption     = "C" + CHR(226) + "m\<bio"
1010:             .Buttons(5).Height      = 15
1011:             .Buttons(5).Left        = 5
1012:             .Buttons(5).Top         = 23
1013:             .Buttons(5).Width       = 53
1014:             .Buttons(5).AutoSize    = .T.
1015:             .Buttons(5).ForeColor   = RGB(90,90,90)
1016:             .Buttons(5).Themes      = .F.
1017:             .Buttons(6).FontName    = "Tahoma"
1018:             .Buttons(6).FontSize    = 8
1019:             .Buttons(6).Caption     = "C" + CHR(226) + "mbio (Inteiros)"
1020:             .Buttons(6).Height      = 15
1021:             .Buttons(6).Left        = 98
1022:             .Buttons(6).Top         = 23
1023:             .Buttons(6).Width       = 101
1024:             .Buttons(6).AutoSize    = .T.
1025:             .Buttons(6).ForeColor   = RGB(90,90,90)
1026:             .Buttons(6).Themes      = .F.
1027:             .Buttons(7).FontName    = "Tahoma"
1028:             .Buttons(7).FontSize    = 8
1029:             .Buttons(7).Caption     = "Markup Custo"
1030:             .Buttons(7).Height      = 15
1031:             .Buttons(7).Left        = 213
1032:             .Buttons(7).Top         = 23
1033:             .Buttons(7).Width       = 84
1034:             .Buttons(7).AutoSize    = .T.
1035:             .Buttons(7).ForeColor   = RGB(90,90,90)
1036:             .Buttons(7).Themes      = .F.
1037:             .Buttons(8).FontName    = "Tahoma"
1038:             .Buttons(8).FontSize    = 8
1039:             .Buttons(8).Caption     = "Markup Venda"
1040:             .Buttons(8).Height      = 15
1041:             .Buttons(8).Left        = 312
1042:             .Buttons(8).Top         = 22
1043:             .Buttons(8).Width       = 86
1044:             .Buttons(8).AutoSize    = .T.
1045:             .Buttons(8).ForeColor   = RGB(90,90,90)
1046:             .Buttons(8).Themes      = .F.
1047:         ENDWITH
1048: 
1049:         *-- Reajuste (Left=148, Top=300)
1050:         THIS.AddObject("lbl_4c_Reajuste", "Label")
1051:         WITH THIS.lbl_4c_Reajuste
1052:             .FontName  = "Tahoma"
1053:             .FontSize  = 8
1054:             .BackStyle = 0
1055:             .Caption   = "Reajuste :"
1056:             .Height    = 15
1057:             .Left      = 91
1058:             .Top       = 304
1059:             .AutoSize  = .T.
1060:             .ForeColor = RGB(90,90,90)
1061:             .Visible   = .T.
1062:         ENDWITH
1063: 

*-- Linhas 1069 a 1095:
1069:             .Format        = "K"
1070:             .Height        = 23
1071:             .InputMask     = "999,999.999"
1072:             .Left          = 148
1073:             .MaxLength     = 0
1074:             .SpecialEffect = 1
1075:             .Top           = 300
1076:             .Width         = 80
1077:             .ForeColor     = RGB(0,0,0)
1078:             .Visible       = .T.
1079:         ENDWITH
1080: 
1081:         *-- Novo Markup % (Left=148, Top=326)
1082:         THIS.AddObject("lbl_4c_NMrk", "Label")
1083:         WITH THIS.lbl_4c_NMrk
1084:             .FontName  = "Tahoma"
1085:             .FontSize  = 8
1086:             .BackStyle = 0
1087:             .Caption   = "Novo Markup :"
1088:             .Height    = 15
1089:             .Left      = 71
1090:             .Top       = 330
1091:             .AutoSize  = .T.
1092:             .ForeColor = RGB(90,90,90)
1093:             .Visible   = .T.
1094:         ENDWITH
1095: 

*-- Linhas 1101 a 1127:
1101:             .Format        = "K"
1102:             .Height        = 23
1103:             .InputMask     = "999,999.99"
1104:             .Left          = 148
1105:             .MaxLength     = 0
1106:             .SpecialEffect = 1
1107:             .Top           = 326
1108:             .Width         = 80
1109:             .ForeColor     = RGB(0,0,0)
1110:             .Visible       = .T.
1111:         ENDWITH
1112: 
1113:         *-- Novo Encargo (Left=326, Top=300)
1114:         THIS.AddObject("lbl_4c_Encargo", "Label")
1115:         WITH THIS.lbl_4c_Encargo
1116:             .FontName  = "Tahoma"
1117:             .FontSize  = 8
1118:             .BackStyle = 0
1119:             .Caption   = "Novo Encargo : "
1120:             .Height    = 15
1121:             .Left      = 245
1122:             .Top       = 304
1123:             .AutoSize  = .T.
1124:             .ForeColor = RGB(90,90,90)
1125:             .Visible   = .T.
1126:         ENDWITH
1127: 

*-- Linhas 1133 a 1211:
1133:             .Format        = "K"
1134:             .Height        = 23
1135:             .InputMask     = "999,999.99"
1136:             .Left          = 326
1137:             .MaxLength     = 0
1138:             .SpecialEffect = 1
1139:             .Top           = 300
1140:             .Width         = 80
1141:             .ForeColor     = RGB(0,0,0)
1142:             .Visible       = .T.
1143:         ENDWITH
1144: 
1145:         *-- Atualiza Val.Venda (Left=544, Top=298)
1146:         THIS.AddObject("lbl_4c_PVen", "Label")
1147:         WITH THIS.lbl_4c_PVen
1148:             .FontName  = "Tahoma"
1149:             .FontSize  = 8
1150:             .BackStyle = 0
1151:             .Caption   = "Atualiza Val.Venda :"
1152:             .Height    = 15
1153:             .Left      = 448
1154:             .Top       = 304
1155:             .AutoSize  = .T.
1156:             .ForeColor = RGB(90,90,90)
1157:             .Visible   = .T.
1158:         ENDWITH
1159: 
1160:         THIS.AddObject("opg_4c_PVen", "OptionGroup")
1161:         WITH THIS.opg_4c_PVen
1162:             .ButtonCount = 2
1163:             .Value       = 2
1164:             .Height      = 27
1165:             .Left        = 544
1166:             .Top         = 298
1167:             .Width       = 102
1168:             .BackStyle   = 0
1169:             .Visible     = .T.
1170:             .Buttons(1).Caption     = "\<Sim"
1171:             .Buttons(1).Left        = 5
1172:             .Buttons(1).Top         = 5
1173:             .Buttons(1).AutoSize    = .T.
1174:             .Buttons(1).Themes      = .F.
1175:             .Buttons(2).Caption     = "\<N" + CHR(227) + "o"
1176:             .Buttons(2).Height      = 17
1177:             .Buttons(2).Left        = 53
1178:             .Buttons(2).Top         = 5
1179:             .Buttons(2).Width       = 44
1180:             .Buttons(2).AutoSize    = .F.
1181:             .Buttons(2).Themes      = .F.
1182:         ENDWITH
1183: 
1184:         *-- Novo MKP code (Left=326, Top=326)
1185:         THIS.AddObject("lbl_4c_NewMkp", "Label")
1186:         WITH THIS.lbl_4c_NewMkp
1187:             .FontName  = "Tahoma"
1188:             .FontSize  = 8
1189:             .BackStyle = 0
1190:             .Caption   = "Novo MKP : "
1191:             .Height    = 15
1192:             .Left      = 264
1193:             .Top       = 330
1194:             .AutoSize  = .T.
1195:             .ForeColor = RGB(90,90,90)
1196:             .Visible   = .T.
1197:         ENDWITH
1198: 
1199:         THIS.AddObject("txt_4c_NewMkp", "TextBox")
1200:         WITH THIS.txt_4c_NewMkp
1201:             .BorderStyle   = 1
1202:             .Height        = 23
1203:             .Left          = 326
1204:             .MaxLength     = 2
1205:             .SpecialEffect = 1
1206:             .Top           = 326
1207:             .Width         = 24
1208:             .ForeColor     = RGB(0,0,0)
1209:             .Visible       = .T.
1210:         ENDWITH
1211:     ENDPROC

*-- Linhas 1231 a 1260:
1231:             .FontName      = "Tahoma"
1232:             .FontSize      = 8
1233:             .Height        = 244
1234:             .Left          = 12
1235:             .RowHeight     = 16
1236:             .ScrollBars    = 2
1237:             .Top           = 351
1238:             .Width         = 935
1239:             .RecordMark    = .F.
1240:             .DeleteMark    = .F.
1241:             .Visible       = .T.
1242: 
1243:             *-- Column1: Checkbox (lMarca)
1244:             .Column1.Alignment     = 3
1245:             .Column1.Width         = 17
1246:             .Column1.Movable       = .F.
1247:             .Column1.Resizable     = .F.
1248:             .Column1.Sparse        = .F.
1249:             .Column1.Header1.Caption   = ""
1250:             .Column1.Header1.Alignment = 2
1251:             .Column1.Header1.ForeColor = RGB(36,84,155)
1252:             .Column1.RemoveObject("Text1")
1253:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
1254:             WITH .Column1.chk_4c_Marca
1255:                 .Caption = ""
1256:                 .Width   = 17
1257:                 .Height  = 17
1258:                 .Value   = 0
1259:                 .Visible = .T.
1260:             ENDWITH

*-- Linhas 1268 a 1276:
1268:             .Column2.Movable       = .F.
1269:             .Column2.Resizable     = .F.
1270:             .Column2.ControlSource = "cursor_4c_Dados.CPros"
1271:             .Column2.Header1.Caption   = "Produto"
1272:             .Column2.Header1.Alignment = 2
1273:             .Column2.Header1.ForeColor = RGB(36,84,155)
1274:             .Column2.Text1.BorderStyle = 0
1275:             .Column2.Text1.Margin      = 0
1276:             .Column2.Text1.ReadOnly    = .T.

*-- Linhas 1282 a 1303:
1282:             .Column3.Movable       = .F.
1283:             .Column3.Resizable     = .F.
1284:             .Column3.ControlSource = "cursor_4c_Dados.DPros"
1285:             .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1286:             .Column3.Header1.Alignment = 2
1287:             .Column3.Header1.ForeColor = RGB(36,84,155)
1288:             .Column3.Text1.Margin      = 0
1289:             .Column3.Text1.ReadOnly    = .T.
1290: 
1291:             *-- Column4: ValAnt (Venda Ant.)
1292:             .Column4.FontName      = "Tahoma"
1293:             .Column4.FontSize      = 8
1294:             .Column4.Width         = 80
1295:             .Column4.Movable       = .F.
1296:             .Column4.Resizable     = .F.
1297:             .Column4.ControlSource = "cursor_4c_Dados.ValAnt"
1298:             .Column4.Header1.Caption   = "Venda Ant."
1299:             .Column4.Header1.Alignment = 2
1300:             .Column4.Header1.ForeColor = RGB(36,84,155)
1301:             WITH .Column4.Text1
1302:                 .InputMask  = "999,999,999.99"
1303:                 .Margin     = 0

*-- Linhas 1311 a 1319:
1311:             .Column5.Movable       = .F.
1312:             .Column5.Resizable     = .F.
1313:             .Column5.ControlSource = "cursor_4c_Dados.ValAtu"
1314:             .Column5.Header1.Caption   = "Venda Atual"
1315:             .Column5.Header1.Alignment = 2
1316:             .Column5.Header1.ForeColor = RGB(36,84,155)
1317:             WITH .Column5.Text1
1318:                 .InputMask  = "999,999,999.99"
1319:                 .Margin     = 0

*-- Linhas 1328 a 1336:
1328:             .Column6.Resizable     = .F.
1329:             .Column6.ReadOnly      = .T.
1330:             .Column6.ControlSource = "cursor_4c_Dados.PVarias"
1331:             .Column6.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1332:             .Column6.Header1.Alignment = 2
1333:             .Column6.Header1.ForeColor = RGB(36,84,155)
1334:             WITH .Column6.Text1
1335:                 .BorderStyle = 0
1336:                 .Margin      = 0

*-- Linhas 1348 a 1356:
1348:             .Column7.Resizable     = .F.
1349:             .Column7.ReadOnly      = .T.
1350:             .Column7.ControlSource = "cursor_4c_Dados.CustoAfs"
1351:             .Column7.Header1.Caption   = "Custo Ant."
1352:             .Column7.Header1.Alignment = 2
1353:             WITH .Column7.Text1
1354:                 .BorderStyle = 0
1355:                 .Margin      = 0
1356:                 .ReadOnly    = .T.

*-- Linhas 1367 a 1375:
1367:             .Column8.Resizable     = .F.
1368:             .Column8.ReadOnly      = .T.
1369:             .Column8.ControlSource = "cursor_4c_Dados.CustoFs"
1370:             .Column8.Header1.Caption   = "Custo Atual"
1371:             .Column8.Header1.Alignment = 2
1372:             WITH .Column8.Text1
1373:                 .BorderStyle = 0
1374:                 .Margin      = 0
1375:                 .ReadOnly    = .T.

*-- Linhas 1386 a 1394:
1386:             .Column9.Resizable     = .F.
1387:             .Column9.ReadOnly      = .T.
1388:             .Column9.ControlSource = "cursor_4c_Dados.CVarias"
1389:             .Column9.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1390:             .Column9.Header1.Alignment = 2
1391:             WITH .Column9.Text1
1392:                 .BorderStyle = 0
1393:                 .Margin      = 0
1394:                 .ReadOnly    = .T.

*-- Linhas 1408 a 1545:
1408:         WITH THIS.img_4c_FigJpg
1409:             .Stretch = 1
1410:             .Height  = 190
1411:             .Left    = 764
1412:             .Top     = 128
1413:             .Width   = 223
1414:             .Visible = .F.
1415:         ENDWITH
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     PROTECTED PROCEDURE ConfigurarBotoes
1420:     *==========================================================================
1421:         LOCAL loc_cIco
1422: 
1423:         loc_cIco = gc_4c_CaminhoIcones
1424: 
1425:         *-- Botao Imprimir (Left=700, Top=3)
1426:         THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
1427:         WITH THIS.cmd_4c_Imprimir
1428:             .Top        = 3
1429:             .Left       = 700
1430:             .Height     = 75
1431:             .Width      = 60
1432:             .FontBold   = .T.
1433:             .FontItalic = .T.
1434:             .FontName   = "Comic Sans MS"
1435:             .FontSize   = 8
1436:             .WordWrap   = .T.
1437:             .Picture    = loc_cIco + "geral_impressora_normal_60.jpg"
1438:             .Caption    = "\<Imprimir"
1439:             .ForeColor  = RGB(90,90,90)
1440:             .BackColor  = RGB(255,255,255)
1441:             .Themes     = .T.
1442:             .Enabled    = .F.
1443:             .Visible    = fChecaAcesso("SigPrCcp", "IMPRIMIR")
1444:         ENDWITH
1445: 
1446:         *-- Botao Processar (Left=767, Top=5)
1447:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
1448:         WITH THIS.cmd_4c_Processar
1449:             .Top        = 5
1450:             .Left       = 767
1451:             .Height     = 75
1452:             .Width      = 75
1453:             .FontBold   = .T.
1454:             .FontItalic = .T.
1455:             .FontName   = "Comic Sans MS"
1456:             .FontSize   = 8
1457:             .WordWrap   = .T.
1458:             .Picture    = loc_cIco + "geral_processar_60.jpg"
1459:             .Caption    = "\<Processar"
1460:             .ForeColor  = RGB(90,90,90)
1461:             .BackColor  = RGB(255,255,255)
1462:             .Themes     = .T.
1463:             .Visible    = .T.
1464:         ENDWITH
1465: 
1466:         *-- Botao Atualizar (Left=843, Top=5)
1467:         THIS.AddObject("cmd_4c_Atualizar", "CommandButton")
1468:         WITH THIS.cmd_4c_Atualizar
1469:             .Top        = 5
1470:             .Left       = 843
1471:             .Height     = 75
1472:             .Width      = 75
1473:             .FontBold   = .T.
1474:             .FontItalic = .T.
1475:             .FontName   = "Comic Sans MS"
1476:             .FontSize   = 8
1477:             .WordWrap   = .T.
1478:             .Picture    = loc_cIco + "cadastro_salvar_60.jpg"
1479:             .Caption    = "\<Atualizar"
1480:             .ForeColor  = RGB(90,90,90)
1481:             .BackColor  = RGB(255,255,255)
1482:             .Themes     = .T.
1483:             .Enabled    = .F.
1484:             .Visible    = .T.
1485:         ENDWITH
1486: 
1487:         *-- Container Encerrar canonico (Left=917)
1488:         THIS.AddObject("cnt_4c_Saida", "Container")
1489:         WITH THIS.cnt_4c_Saida
1490:             .Top        = 0
1491:             .Left       = 917
1492:             .Height     = 85
1493:             .Width      = 90
1494:             .BackStyle  = 0
1495:             .BorderWidth= 0
1496:             .Visible    = .T.
1497:             .AddObject("cmd_4c_Encerrar", "CommandButton")
1498:             WITH .cmd_4c_Encerrar
1499:                 .Top        = 5
1500:                 .Left       = 917
1501:                 .Height     = 75
1502:                 .Width      = 75
1503:                 .FontBold   = .T.
1504:                 .FontItalic = .T.
1505:                 .FontName   = "Comic Sans MS"
1506:                 .FontSize   = 8
1507:                 .WordWrap   = .T.
1508:                 .Picture    = loc_cIco + "cadastro_sair_60.jpg"
1509:                 .Caption    = "Encerrar"
1510:                 .ForeColor  = RGB(90,90,90)
1511:                 .BackColor  = RGB(255,255,255)
1512:                 .Cancel     = .T.
1513:                 .Visible    = .T.
1514:             ENDWITH
1515:         ENDWITH
1516: 
1517:         *-- Botao Selecionar Tudo (Left=955, Top=433)
1518:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1519:         WITH THIS.cmd_4c_SelTudo
1520:             .Top      = 433
1521:             .Left     = 955
1522:             .Height   = 26
1523:             .Width    = 26
1524:             .Picture  = loc_cIco + "geral_marcar_26.jpg"
1525:             .Caption  = ""
1526:             .TabStop  = .F.
1527:             .ToolTipText = "Selecionar Tudo"
1528:             .Themes   = .T.
1529:             .Visible  = .T.
1530:         ENDWITH
1531: 
1532:         *-- Botao Desmarcar Tudo (Left=955, Top=473)
1533:         THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
1534:         WITH THIS.cmd_4c_Desmarcar
1535:             .Top      = 473
1536:             .Left     = 955
1537:             .Height   = 26
1538:             .Width    = 26
1539:             .Picture  = loc_cIco + "cadastro_excluir_26.jpg"
1540:             .Caption  = ""
1541:             .TabStop  = .F.
1542:             .ToolTipText = "Desmarcar Tudo"
1543:             .Themes   = .T.
1544:             .Visible  = .T.
1545:         ENDWITH

*-- Linhas 1563 a 1584:
1563:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1564:     *==========================================================================
1565:         *-- Botoes de acao
1566:         BINDEVENT(THIS.cmd_4c_Processar, "Click",  THIS, "BtnProcessarClick")
1567:         BINDEVENT(THIS.cmd_4c_Atualizar, "Click",  THIS, "BtnAtualizarClick")
1568:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1569:         BINDEVENT(THIS.cmd_4c_Imprimir,  "Click",  THIS, "BtnImprimirClick")
1570:         BINDEVENT(THIS.cmd_4c_SelTudo,   "Click",  THIS, "BtnSelTudoClick")
1571:         BINDEVENT(THIS.cmd_4c_Desmarcar, "Click",  THIS, "BtnDesmarcarClick")
1572: 
1573:         *-- Grid
1574:         BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")
1575: 
1576:         *-- Imagem
1577:         BINDEVENT(THIS.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")
1578: 
1579:         *-- Opc Recalc (para atualizar estado dos campos)
1580:         BINDEVENT(THIS.opg_4c_Recalc, "InteractiveChange", THIS, "OpcRecalcMudou")
1581: 
1582:         *-- Fornecedor lookup
1583:         BINDEVENT(THIS.txt_4c_CFornecs, "DblClick",   THIS, "AbrirBuscaFornecedor")
1584:         BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress",   THIS, "TeclaFornecedor")

*-- Linhas 1730 a 1750:
1730:                 ENDIF
1731:                 SET ORDER TO CPros
1732:                 GO TOP
1733:             ENDIF
1734:             THIS.cmd_4c_Atualizar.Enabled = .T.
1735:             THIS.cmd_4c_Imprimir.Enabled  = .T.
1736:             THIS.grd_4c_Produto.Refresh
1737:         ENDIF
1738:     ENDPROC
1739: 
1740:     PROCEDURE BtnAtualizarClick
1741:         THIS.this_oBusinessObject.AtualizarPrecos(.F.)
1742:     ENDPROC
1743: 
1744:     PROCEDURE BtnEncerrarClick
1745:         THIS.Release()
1746:     ENDPROC
1747: 
1748:     PROCEDURE BtnImprimirClick
1749:         DO FORM SigPrCcr
1750:     ENDPROC

*-- Linhas 2298 a 2318:
2298:             ZAP
2299:             THIS.grd_4c_Produto.Refresh
2300:         ENDIF
2301:         THIS.this_oBusinessObject.this_lProcessado = .F.
2302:         THIS.cmd_4c_Atualizar.Enabled = .F.
2303:         THIS.cmd_4c_Imprimir.Enabled  = .F.
2304:     ENDPROC
2305: 
2306:     *==========================================================================
2307:     * CarregarLista - Override de FormBase (form OPERACIONAL nao tem lista CRUD)
2308:     *==========================================================================
2309:     PROCEDURE CarregarLista
2310:         RETURN
2311:     ENDPROC
2312: 
2313:     *==========================================================================
2314:     * AjustarBotoesPorModo - Override de FormBase. Em OPERACIONAL o controle
2315:     * de estado dos botoes eh feito por AtualizarEstadoCampos() em funcao do
2316:     * flag this_lProcessado do BO.
2317:     *==========================================================================
2318:     PROCEDURE AjustarBotoesPorModo

*-- Linhas 2469 a 2489:
2469:         THIS.img_4c_FigJpg.Picture = ""
2470: 
2471:         *-- Reset do estado de processamento
2472:         THIS.this_oBusinessObject.this_lProcessado = .F.
2473:         THIS.cmd_4c_Atualizar.Enabled = .F.
2474:         THIS.cmd_4c_Imprimir.Enabled  = .F.
2475: 
2476:         THIS.AtualizarEstadoCampos()
2477:     ENDPROC
2478: 
2479:     *==========================================================================
2480:     * FormParaBO - Copia TODOS os valores dos controles do form para o BO
2481:     * antes de qualquer operacao (Processar, AtualizarPrecos).
2482:     *==========================================================================
2483:     PROCEDURE FormParaBO
2484:         LOCAL loc_oBO
2485:         loc_oBO = THIS.this_oBusinessObject
2486: 
2487:         *-- Fornecedor
2488:         loc_oBO.this_cFornecs  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
2489:         loc_oBO.this_cDFornecs = ALLTRIM(THIS.txt_4c_DFornecs.Value)

