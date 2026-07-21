# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [FONTNAME-ERRADO] Linha 181: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 194: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 211: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 318: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 331: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 341: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2175 linhas total):

*-- Linhas 62 a 71:
62:             THIS.ConfigurarGrade()
63:             THIS.CarregarLista()
64: 
65:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67: 
68:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
69:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
70:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")
71: 

*-- Linhas 115 a 158:
115:     *==========================================================================
116:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH THIS.cnt_4c_Cabecalho
118:             .Top         = 0
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackStyle   = 1
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125: 
126:             .AddObject("lbl_4c_Sombra", "Label")
127:             WITH .lbl_4c_Sombra
128:                 .Top       = 18
129:                 .Left      = 10
130:                 .Width     = THIS.Width
131:                 .Height    = 40
132:                 .AutoSize  = .F.
133:                 .FontName  = "Tahoma"
134:                 .FontSize  = 18
135:                 .FontBold  = .T.
136:                 .BackStyle = 0
137:                 .ForeColor = RGB(0, 0, 0)
138:                 .Caption   = THIS.Caption
139:             ENDWITH
140: 
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .Top       = 17
144:                 .Left      = 10
145:                 .Width     = THIS.Width
146:                 .Height    = 46
147:                 .AutoSize  = .F.
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 18
150:                 .FontBold  = .T.
151:                 .BackStyle = 0
152:                 .ForeColor = RGB(255, 255, 255)
153:                 .Caption   = THIS.Caption
154:             ENDWITH
155:         ENDWITH
156:     ENDPROC
157: 
158:     *==========================================================================

*-- Linhas 165 a 220:
165:             .BorderStyle   = 0
166:             .SpecialEffect = 1
167:             .Themes        = .F.
168:             .Top           = 0
169:             .Left          = 765
170:             .Width         = 235
171:             .Height        = 85
172: 
173:             WITH .Buttons(1)
174:                 .Top        = 5
175:                 .Left       = 5
176:                 .Width      = 75
177:                 .Height     = 75
178:                 .FontBold   = .T.
179:                 .FontItalic = .T.
180:                 .Caption    = "Processar"
181:                 .FontName        = "Comic Sans MS"
182:                 .FontSize        = 8
183:                 .ForeColor  = RGB(90, 90, 90)
184:                 .BackColor  = RGB(255, 255, 255)
185:                 .Themes     = .F.
186:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
187:             ENDWITH
188: 
189:             WITH .Buttons(2)
190:                 .Top        = 5
191:                 .Left       = 80
192:                 .Width      = 75
193:                 .Height     = 75
194:                 .FontName   = "Comic Sans MS"
195:                 .FontSize   = 8
196:                 .FontBold   = .T.
197:                 .FontItalic = .T.
198:                 .Caption    = "Atualizar"
199:                 .ForeColor  = RGB(90, 90, 90)
200:                 .BackColor  = RGB(255, 255, 255)
201:                 .Themes     = .F.
202:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
203:                 .Enabled    = .F.
204:             ENDWITH
205: 
206:             WITH .Buttons(3)
207:                 .Top        = 5
208:                 .Left       = 155
209:                 .Width      = 75
210:                 .Height     = 75
211:                 .FontName   = "Comic Sans MS"
212:                 .FontSize   = 8
213:                 .FontBold   = .T.
214:                 .FontItalic = .T.
215:                 .Caption    = "Encerrar"
216:                 .WordWrap        = .T.
217:                 .ForeColor  = RGB(90, 90, 90)
218:                 .BackColor  = RGB(255, 255, 255)
219:                 .Themes     = .F.
220:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 227 a 816:
227:     PROTECTED PROCEDURE ConfigurarFiltros()
228:     *==========================================================================
229:         *-- Grupo de Produto (inicio/fim)
230:         THIS.AddObject("lbl_4c_GrupoP", "Label")
231:         WITH THIS.lbl_4c_GrupoP
232:             .Top      = 113
233:             .Left     = 69
234:             .Width    = 94
235:             .Height   = 15
236:             .FontName = "Tahoma"
237:             .FontSize = 8
238:             .BackStyle = 0
239:             .Caption  = "Grupo de Produto :"
240:         ENDWITH
241: 
242:         THIS.AddObject("txt_4c_GrupoIni", "TextBox")
243:         WITH THIS.txt_4c_GrupoIni
244:             .Top       = 109
245:             .Left      = 165
246:             .Width     = 31
247:             .Height    = 23
248:             .FontName  = "Tahoma"
249:             .FontSize  = 8
250:             .MaxLength = 3
251:             .InputMask = "XXX"
252:         ENDWITH
253: 
254:         THIS.AddObject("lbl_4c_GrupoAte", "Label")
255:         WITH THIS.lbl_4c_GrupoAte
256:             .Top      = 113
257:             .Left     = 203
258:             .Width    = 18
259:             .Height   = 15
260:             .FontName = "Tahoma"
261:             .FontSize = 8
262:             .BackStyle = 0
263:             .Caption  = "at" + CHR(233)
264:         ENDWITH
265: 
266:         THIS.AddObject("txt_4c_GrupoFim", "TextBox")
267:         WITH THIS.txt_4c_GrupoFim
268:             .Top       = 109
269:             .Left      = 228
270:             .Width     = 31
271:             .Height    = 23
272:             .FontName  = "Tahoma"
273:             .FontSize  = 8
274:             .MaxLength = 3
275:             .InputMask = "XXX"
276:         ENDWITH
277: 
278:         *-- CheckBox Ignorar Componentes
279:         THIS.AddObject("chk_4c_Ignorar", "CheckBox")
280:         WITH THIS.chk_4c_Ignorar
281:             .Top      = 112
282:             .Left     = 609
283:             .Width    = 123
284:             .Height   = 15
285:             .FontName = "Tahoma"
286:             .FontSize = 8
287:             .BackStyle = 0
288:             .Caption  = "Ignorar Componentes"
289:             .Value    = 0
290:         ENDWITH
291: 
292:         *-- Reajuste por: (label) + OptionGroup tipo
293:         THIS.AddObject("lbl_4c_ReajustePor", "Label")
294:         WITH THIS.lbl_4c_ReajustePor
295:             .Top      = 139
296:             .Left     = 92
297:             .Width    = 71
298:             .Height   = 15
299:             .FontName = "Tahoma"
300:             .FontSize = 8
301:             .BackStyle = 0
302:             .Caption  = "Reajuste por :"
303:         ENDWITH
304: 
305:         THIS.AddObject("opt_4c_Tipo", "OptionGroup")
306:         WITH THIS.opt_4c_Tipo
307:             .Top         = 134
308:             .Left        = 159
309:             .Width       = 208
310:             .Height      = 24
311:             .ButtonCount = 3
312:             .BackStyle   = 0
313:             .BorderStyle = 0
314:             .Value       = 1
315: 
316:             WITH .Buttons(1)
317:                 .Caption  = "Varia" + CHR(231) + CHR(227) + "o %"
318:                 .FontName        = "Comic Sans MS"
319:                 .FontSize        = 8
320:                 .Width    = 68
321:                 .Height   = 18
322:                 .Left     = 2
323:                 .Top      = 2
324:             ENDWITH
325:             WITH .Buttons(2)
326:                 .Caption  = "MarkUp"
327:                 .Width    = 62
328:                 .Height   = 18
329:                 .Left     = 72
330:                 .Top      = 2
331:                 .FontName = "Comic Sans MS"
332:                 .FontSize = 8
333:             ENDWITH
334:             WITH .Buttons(3)
335:                 .Caption  = "C" + CHR(226) + "mbio"
336:                 .WordWrap        = .T.
337:                 .Width    = 60
338:                 .Height   = 18
339:                 .Left     = 136
340:                 .Top      = 2
341:                 .FontName = "Comic Sans MS"
342:                 .FontSize = 8
343:             ENDWITH
344:         ENDWITH
345: 
346:         *-- CheckBox Incluir Custos (tipo 1 apenas)
347:         THIS.AddObject("chk_4c_IncCusts", "CheckBox")
348:         WITH THIS.chk_4c_IncCusts
349:             .Top      = 139
350:             .Left     = 609
351:             .Width    = 83
352:             .Height   = 15
353:             .FontName = "Tahoma"
354:             .FontSize = 8
355:             .BackStyle = 0
356:             .Caption  = "Incluir Custos"
357:             .Value    = 0
358:         ENDWITH
359: 
360:         *-- Grupo de Venda / Colecao
361:         THIS.AddObject("lbl_4c_GrupoV", "Label")
362:         WITH THIS.lbl_4c_GrupoV
363:             .Top      = 113
364:             .Left     = 399
365:             .Width    = 86
366:             .Height   = 15
367:             .FontName = "Tahoma"
368:             .FontSize = 8
369:             .BackStyle = 0
370:             .Caption  = "Grupo de Venda :"
371:         ENDWITH
372: 
373:         THIS.AddObject("txt_4c_Colecao", "TextBox")
374:         WITH THIS.txt_4c_Colecao
375:             .Top       = 109
376:             .Left      = 487
377:             .Width     = 94
378:             .Height    = 23
379:             .FontName  = "Tahoma"
380:             .FontSize  = 8
381:             .MaxLength = 10
382:             .InputMask = "XXXXXXXXXX"
383:         ENDWITH
384: 
385:         *-- Variacao de Preco (tipo 1)
386:         THIS.AddObject("lbl_4c_Variacao", "Label")
387:         WITH THIS.lbl_4c_Variacao
388:             .Top      = 139
389:             .Left     = 390
390:             .Width    = 95
391:             .Height   = 15
392:             .FontName = "Tahoma"
393:             .FontSize = 8
394:             .BackStyle = 0
395:             .Caption  = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
396:         ENDWITH
397: 
398:         THIS.AddObject("txt_4c_Variacao", "TextBox")
399:         WITH THIS.txt_4c_Variacao
400:             .Top       = 135
401:             .Left      = 487
402:             .Width     = 94
403:             .Height    = 23
404:             .FontName  = "Tahoma"
405:             .FontSize  = 8
406:             .InputMask = "999999.99"
407:         ENDWITH
408: 
409:         THIS.AddObject("lbl_4c_Pct", "Label")
410:         WITH THIS.lbl_4c_Pct
411:             .Top      = 139
412:             .Left     = 585
413:             .Width    = 13
414:             .Height   = 15
415:             .FontName = "Tahoma"
416:             .FontSize = 8
417:             .BackStyle = 0
418:             .Caption  = "%"
419:         ENDWITH
420: 
421:         *-- Moeda (tipo 2)
422:         THIS.AddObject("lbl_4c_Moeda", "Label")
423:         WITH THIS.lbl_4c_Moeda
424:             .Top      = 139
425:             .Left     = 444
426:             .Width    = 41
427:             .Height   = 15
428:             .FontName = "Tahoma"
429:             .FontSize = 8
430:             .BackStyle = 0
431:             .Caption  = "Moeda :"
432:         ENDWITH
433: 
434:         THIS.AddObject("txt_4c_Moeda", "TextBox")
435:         WITH THIS.txt_4c_Moeda
436:             .Top       = 135
437:             .Left      = 487
438:             .Width     = 31
439:             .Height    = 23
440:             .FontName  = "Tahoma"
441:             .FontSize  = 8
442:             .MaxLength = 3
443:             .InputMask = "XXX"
444:         ENDWITH
445: 
446:         *-- Fator de Custo
447:         THIS.AddObject("lbl_4c_FatorCusto", "Label")
448:         WITH THIS.lbl_4c_FatorCusto
449:             .Top      = 165
450:             .Left     = 85
451:             .Width    = 78
452:             .Height   = 15
453:             .FontName = "Tahoma"
454:             .FontSize = 8
455:             .BackStyle = 0
456:             .Caption  = "Fator de Custo:"
457:         ENDWITH
458: 
459:         THIS.AddObject("txt_4c_Fator", "TextBox")
460:         WITH THIS.txt_4c_Fator
461:             .Top       = 161
462:             .Left      = 165
463:             .Width     = 73
464:             .Height    = 23
465:             .FontName  = "Tahoma"
466:             .FontSize  = 8
467:             .InputMask = "99999.999"
468:         ENDWITH
469: 
470:         THIS.AddObject("txt_4c_MoeCusto", "TextBox")
471:         WITH THIS.txt_4c_MoeCusto
472:             .Top       = 161
473:             .Left      = 241
474:             .Width     = 31
475:             .Height    = 23
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .MaxLength = 3
479:             .InputMask = "XXX"
480:         ENDWITH
481: 
482:         *-- MarkUp (tipo 2)
483:         THIS.AddObject("lbl_4c_MarkUp", "Label")
484:         WITH THIS.lbl_4c_MarkUp
485:             .Top      = 165
486:             .Left     = 440
487:             .Width    = 45
488:             .Height   = 15
489:             .FontName = "Tahoma"
490:             .FontSize = 8
491:             .BackStyle = 0
492:             .Caption  = "MarkUp :"
493:         ENDWITH
494: 
495:         THIS.AddObject("txt_4c_MarkUp1", "TextBox")
496:         WITH THIS.txt_4c_MarkUp1
497:             .Top       = 161
498:             .Left      = 487
499:             .Width     = 52
500:             .Height    = 23
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8
503:             .InputMask = "9999.99"
504:         ENDWITH
505: 
506:         THIS.AddObject("lbl_4c_Para", "Label")
507:         WITH THIS.lbl_4c_Para
508:             .Top      = 165
509:             .Left     = 547
510:             .Width    = 24
511:             .Height   = 15
512:             .FontName = "Tahoma"
513:             .FontSize = 8
514:             .BackStyle = 0
515:             .Caption  = "para"
516:         ENDWITH
517: 
518:         THIS.AddObject("txt_4c_MarkUp2", "TextBox")
519:         WITH THIS.txt_4c_MarkUp2
520:             .Top       = 161
521:             .Left      = 580
522:             .Width     = 52
523:             .Height    = 23
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .InputMask = "9999.99"
527:         ENDWITH
528: 
529:         *-- Promocao + Limpar
530:         THIS.AddObject("lbl_4c_Promo", "Label")
531:         WITH THIS.lbl_4c_Promo
532:             .Top      = 191
533:             .Left     = 107
534:             .Width    = 56
535:             .Height   = 15
536:             .FontName = "Tahoma"
537:             .FontSize = 8
538:             .BackStyle = 0
539:             .Caption  = "Promo" + CHR(231) + CHR(227) + "o :"
540:         ENDWITH
541: 
542:         THIS.AddObject("txt_4c_Promo", "TextBox")
543:         WITH THIS.txt_4c_Promo
544:             .Top       = 187
545:             .Left      = 165
546:             .Width     = 185
547:             .Height    = 23
548:             .FontName  = "Tahoma"
549:             .FontSize  = 8
550:             .MaxLength = 25
551:         ENDWITH
552: 
553:         THIS.AddObject("chk_4c_Limpar", "CheckBox")
554:         WITH THIS.chk_4c_Limpar
555:             .Top      = 191
556:             .Left     = 362
557:             .Width    = 157
558:             .Height   = 15
559:             .FontName = "Tahoma"
560:             .FontSize = 8
561:             .BackStyle = 0
562:             .Caption  = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
563:             .Value    = 0
564:         ENDWITH
565: 
566:         *-- Fornecedor (codigo + descricao)
567:         THIS.AddObject("lbl_4c_Fornecedor", "Label")
568:         WITH THIS.lbl_4c_Fornecedor
569:             .Top      = 216
570:             .Left     = 99
571:             .Width    = 64
572:             .Height   = 15
573:             .FontName = "Tahoma"
574:             .FontSize = 8
575:             .BackStyle = 0
576:             .Caption  = "Fornecedor :"
577:         ENDWITH
578: 
579:         THIS.AddObject("txt_4c_Conta", "TextBox")
580:         WITH THIS.txt_4c_Conta
581:             .Top       = 213
582:             .Left      = 165
583:             .Width     = 80
584:             .Height    = 23
585:             .FontName  = "Tahoma"
586:             .FontSize  = 8
587:             .MaxLength = 10
588:         ENDWITH
589: 
590:         THIS.AddObject("txt_4c_DConta", "TextBox")
591:         WITH THIS.txt_4c_DConta
592:             .Top       = 213
593:             .Left      = 248
594:             .Width     = 290
595:             .Height    = 23
596:             .FontName  = "Tahoma"
597:             .FontSize  = 8
598:             .MaxLength = 50
599:         ENDWITH
600: 
601:         *-- Secao de Moedas auxiliares (tipo 2)
602:         THIS.AddObject("lbl_4c_Moeda1", "Label")
603:         WITH THIS.lbl_4c_Moeda1
604:             .Top      = 244
605:             .Left     = 51
606:             .Width    = 112
607:             .Height   = 15
608:             .FontName = "Tahoma"
609:             .FontSize = 8
610:             .BackStyle = 0
611:             .Caption  = "Moeda Custo Compo. :"
612:         ENDWITH
613: 
614:         THIS.AddObject("txt_4c_MoeCs", "TextBox")
615:         WITH THIS.txt_4c_MoeCs
616:             .Top       = 240
617:             .Left      = 165
618:             .Width     = 31
619:             .Height    = 23
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8
622:             .MaxLength = 3
623:             .InputMask = "XXX"
624:         ENDWITH
625: 
626:         THIS.AddObject("lbl_4c_Moeda2", "Label")
627:         WITH THIS.lbl_4c_Moeda2
628:             .Top      = 270
629:             .Left     = 64
630:             .Width    = 99
631:             .Height   = 15
632:             .FontName = "Tahoma"
633:             .FontSize = 8
634:             .BackStyle = 0
635:             .Caption  = "Moeda Custo Total :"
636:         ENDWITH
637: 
638:         THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
639:         WITH THIS.txt_4c_MoeCusFs
640:             .Top       = 266
641:             .Left      = 165
642:             .Width     = 31
643:             .Height    = 23
644:             .FontName  = "Tahoma"
645:             .FontSize  = 8
646:             .MaxLength = 3
647:             .InputMask = "XXX"
648:         ENDWITH
649: 
650:         THIS.AddObject("lbl_4c_Moeda4", "Label")
651:         WITH THIS.lbl_4c_Moeda4
652:             .Top      = 244
653:             .Left     = 320
654:             .Width    = 98
655:             .Height   = 15
656:             .FontName = "Tahoma"
657:             .FontSize = 8
658:             .BackStyle = 0
659:             .Caption  = "Moeda Pre" + CHR(231) + "o Ideal :"
660:         ENDWITH
661: 
662:         THIS.AddObject("txt_4c_Moedas", "TextBox")
663:         WITH THIS.txt_4c_Moedas
664:             .Top       = 240
665:             .Left      = 420
666:             .Width     = 31
667:             .Height    = 23
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8
670:             .MaxLength = 3
671:             .InputMask = "XXX"
672:         ENDWITH
673: 
674:         THIS.AddObject("lbl_4c_Moeda3", "Label")
675:         WITH THIS.lbl_4c_Moeda3
676:             .Top      = 244
677:             .Left     = 531
678:             .Width    = 35
679:             .Height   = 15
680:             .FontName = "Tahoma"
681:             .FontSize = 8
682:             .BackStyle = 0
683:             .Caption  = "Feitio :"
684:         ENDWITH
685: 
686:         THIS.AddObject("txt_4c_CFtios", "TextBox")
687:         WITH THIS.txt_4c_CFtios
688:             .Top       = 240
689:             .Left      = 568
690:             .Width     = 31
691:             .Height    = 23
692:             .FontName  = "Tahoma"
693:             .FontSize  = 8
694:             .MaxLength = 2
695:             .InputMask = "XX"
696:         ENDWITH
697: 
698:         THIS.AddObject("lbl_4c_Moeda5", "Label")
699:         WITH THIS.lbl_4c_Moeda5
700:             .Top      = 270
701:             .Left     = 319
702:             .Width    = 99
703:             .Height   = 15
704:             .FontName = "Tahoma"
705:             .FontSize = 8
706:             .BackStyle = 0
707:             .Caption  = "Moeda Pre" + CHR(231) + "o Atual :"
708:         ENDWITH
709: 
710:         THIS.AddObject("txt_4c_MoeVs", "TextBox")
711:         WITH THIS.txt_4c_MoeVs
712:             .Top       = 266
713:             .Left      = 420
714:             .Width     = 31
715:             .Height    = 23
716:             .FontName  = "Tahoma"
717:             .FontSize  = 8
718:             .MaxLength = 3
719:             .InputMask = "XXX"
720:         ENDWITH
721: 
722:         *-- CheckBox Auditado (modo edicao manual no grid)
723:         THIS.AddObject("chk_4c_Auditado", "CheckBox")
724:         WITH THIS.chk_4c_Auditado
725:             .Top        = 307
726:             .Left       = 763
727:             .Width      = 75
728:             .Height     = 75
729:             .FontName   = "Tahoma"
730:             .FontBold   = .T.
731:             .FontItalic = .T.
732:             .FontSize   = 8
733:             .BackStyle  = 0
734:             .Caption    = "Pro\<dutos"
735:             .Value      = 0
736:             .Style      = 1
737:             .ForeColor  = RGB(90, 90, 90)
738:             .BackColor  = RGB(255, 255, 255)
739:             .Themes     = .F.
740:             .Picture    = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
741:         ENDWITH
742: 
743:         *-- Borda/Shape em volta da foto do produto
744:         THIS.AddObject("shp_4c_Foto", "Shape")
745:         WITH THIS.shp_4c_Foto
746:             .Top         = 414
747:             .Left        = 763
748:             .Width       = 205
749:             .Height      = 140
750:             .BorderColor = RGB(90, 90, 90)
751:             .BorderWidth = 1
752:             .FillStyle   = 1
753:             .BackStyle   = 0
754:         ENDWITH
755: 
756:         *-- Imagem do produto
757:         THIS.AddObject("img_4c_Foto", "Image")
758:         WITH THIS.img_4c_Foto
759:             .Top     = 415
760:             .Left    = 764
761:             .Width   = 203
762:             .Height  = 138
763:             .Visible = .F.
764:         ENDWITH
765:     ENDPROC
766: 
767:     *==========================================================================
768:     PROTECTED PROCEDURE ConfigurarGrade()
769:     *==========================================================================
770:         THIS.AddObject("grd_4c_Dados", "Grid")
771:         WITH THIS.grd_4c_Dados
772:             .Top           = 307
773:             .Left          = 31
774:             .Width         = 725
775:             .Height        = 247
776:             .ColumnCount   = 5
777:             .FontName      = "Tahoma"
778:             .FontSize      = 8
779:             .DeleteMark    = .F.
780:             .RecordMark    = .F.
781:             .GridLines     = 3
782:             .GridLineWidth = 1
783:             .HeaderHeight  = 17
784:             .RowHeight     = 17
785:             .ScrollBars    = 3
786:             *-- Coluna 1: CheckBox de selecao
787:             WITH .Column1
788:                 .Width      = 25
789:                 .Movable    = .F.
790:                 .Resizable  = .F.
791:                 .Sparse     = .F.
792:                 .AddObject("Check1", "CheckBox")
793:                 .Check1.Caption = ""
794:                 .Check1.Value   = 0
795:                 .CurrentControl = "Check1"
796:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
797:                 WITH .Header1
798:                     .Caption = ""
799:                     .Tag     = "1"
800:                 ENDWITH
801:             ENDWITH
802: 
803:             *-- Coluna 2: Codigo do produto
804:             WITH .Column2
805:                 .Width         = 110
806:                 .Movable       = .F.
807:                 .Resizable     = .F.
808:                 .ReadOnly      = .T.
809:                 .ControlSource = "cursor_4c_Produtos.CPros"
810:                 WITH .Header1
811:                     .Caption = "Produto"
812:                 ENDWITH
813:                 WITH .Text1
814:                     .FontName = "Verdana"
815:                     .FontSize = 8
816:                 ENDWITH

*-- Linhas 824 a 832:
824:                 .ReadOnly      = .T.
825:                 .ControlSource = "cursor_4c_Produtos.DPros"
826:                 WITH .Header1
827:                     .Caption = "Descri" + CHR(231) + CHR(227) + "o"
828:                 ENDWITH
829:                 WITH .Text1
830:                     .FontName = "Verdana"
831:                     .FontSize = 8
832:                 ENDWITH

*-- Linhas 841 a 849:
841:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
842:                 .Alignment     = 3
843:                 WITH .Header1
844:                     .Caption = "Pre" + CHR(231) + "o Anterior"
845:                 ENDWITH
846:                 WITH .Text1
847:                     .FontName  = "Verdana"
848:                     .FontSize  = 8
849:                     .InputMask = "999,999.99"

*-- Linhas 859 a 867:
859:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
860:                 .Alignment     = 3
861:                 WITH .Header1
862:                     .Caption = "Pre" + CHR(231) + "o Atual"
863:                     IF !THIS.this_lLibValAtu
864:                         .Picture = gc_4c_CaminhoIcones + "LOCK.BMP"
865:                     ENDIF
866:                 ENDWITH
867:                 WITH .Text1

*-- Linhas 933 a 958:
933: 
934:     PROCEDURE BOParaForm()
935:         WITH THIS.this_oBusinessObject
936:             THIS.opt_4c_Tipo.Value     = .this_nTipo
937:             THIS.txt_4c_GrupoIni.Value = .this_cGrupoInicio
938:             THIS.txt_4c_GrupoFim.Value = .this_cGrupoFim
939:             THIS.txt_4c_Colecao.Value  = .this_cColecao
940:             THIS.txt_4c_Conta.Value    = .this_cConta
941:             THIS.txt_4c_DConta.Value   = .this_cDConta
942:             THIS.txt_4c_Promo.Value    = .this_cPromo
943:             THIS.txt_4c_Variacao.Value = .this_nVariacao
944:             THIS.txt_4c_Moeda.Value    = .this_cMoeda
945:             THIS.txt_4c_MarkUp1.Value  = .this_nMarkUp1
946:             THIS.txt_4c_MarkUp2.Value  = .this_nMarkUp2
947:             THIS.txt_4c_Fator.Value    = .this_nFator
948:             THIS.txt_4c_MoeCusto.Value = .this_cMoeCusto
949:             THIS.txt_4c_MoeCs.Value    = .this_cMoeCs
950:             THIS.txt_4c_MoeCusFs.Value = .this_cMoeCusFs
951:             THIS.txt_4c_Moedas.Value   = .this_cMoedas
952:             THIS.txt_4c_CFtios.Value   = .this_cCFtios
953:             THIS.txt_4c_MoeVs.Value    = .this_cMoeVs
954:         ENDWITH
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * BtnProcessarClick - Calcula novos precos e preenche o grid

*-- Linhas 1187 a 1266:
1187: 
1188:         DO CASE
1189:         CASE loc_nTipo = 1
1190:             THIS.lbl_4c_Variacao.Visible  = .T.
1191:             THIS.txt_4c_Variacao.Visible  = .T.
1192:             THIS.lbl_4c_Pct.Visible       = .T.
1193:             THIS.chk_4c_IncCusts.Visible  = .T.
1194:             THIS.lbl_4c_Moeda.Visible     = .F.
1195:             THIS.txt_4c_Moeda.Visible     = .F.
1196:             THIS.lbl_4c_MarkUp.Visible    = .F.
1197:             THIS.txt_4c_MarkUp1.Visible   = .F.
1198:             THIS.lbl_4c_Para.Visible      = .F.
1199:             THIS.txt_4c_MarkUp2.Visible   = .F.
1200:             THIS.lbl_4c_FatorCusto.Visible = .F.
1201:             THIS.txt_4c_Fator.Visible     = .F.
1202:             THIS.txt_4c_MoeCusto.Visible  = .F.
1203:             THIS.lbl_4c_Moeda1.Visible    = .F.
1204:             THIS.txt_4c_MoeCs.Visible     = .F.
1205:             THIS.lbl_4c_Moeda2.Visible    = .F.
1206:             THIS.txt_4c_MoeCusFs.Visible  = .F.
1207:             THIS.lbl_4c_Moeda4.Visible    = .F.
1208:             THIS.txt_4c_Moedas.Visible    = .F.
1209:             THIS.lbl_4c_Moeda3.Visible    = .F.
1210:             THIS.txt_4c_CFtios.Visible    = .F.
1211:             THIS.lbl_4c_Moeda5.Visible    = .F.
1212:             THIS.txt_4c_MoeVs.Visible     = .F.
1213: 
1214:         CASE loc_nTipo = 2
1215:             THIS.lbl_4c_Variacao.Visible  = .F.
1216:             THIS.txt_4c_Variacao.Visible  = .F.
1217:             THIS.lbl_4c_Pct.Visible       = .F.
1218:             THIS.chk_4c_IncCusts.Visible  = .F.
1219:             THIS.lbl_4c_Moeda.Visible     = .T.
1220:             THIS.txt_4c_Moeda.Visible     = .T.
1221:             THIS.lbl_4c_MarkUp.Visible    = .T.
1222:             THIS.txt_4c_MarkUp1.Visible   = .T.
1223:             THIS.lbl_4c_Para.Visible      = .T.
1224:             THIS.txt_4c_MarkUp2.Visible   = .T.
1225:             THIS.lbl_4c_FatorCusto.Visible = .T.
1226:             THIS.txt_4c_Fator.Visible     = .T.
1227:             THIS.txt_4c_MoeCusto.Visible  = .T.
1228:             THIS.lbl_4c_Moeda1.Visible    = .T.
1229:             THIS.txt_4c_MoeCs.Visible     = .T.
1230:             THIS.lbl_4c_Moeda2.Visible    = .T.
1231:             THIS.txt_4c_MoeCusFs.Visible  = .T.
1232:             THIS.lbl_4c_Moeda4.Visible    = .T.
1233:             THIS.txt_4c_Moedas.Visible    = .T.
1234:             THIS.lbl_4c_Moeda3.Visible    = .T.
1235:             THIS.txt_4c_CFtios.Visible    = .T.
1236:             THIS.lbl_4c_Moeda5.Visible    = .T.
1237:             THIS.txt_4c_MoeVs.Visible     = .T.
1238: 
1239:         CASE loc_nTipo = 3
1240:             THIS.lbl_4c_Variacao.Visible  = .F.
1241:             THIS.txt_4c_Variacao.Visible  = .F.
1242:             THIS.lbl_4c_Pct.Visible       = .F.
1243:             THIS.chk_4c_IncCusts.Visible  = .F.
1244:             THIS.lbl_4c_Moeda.Visible     = .F.
1245:             THIS.txt_4c_Moeda.Visible     = .F.
1246:             THIS.lbl_4c_MarkUp.Visible    = .F.
1247:             THIS.txt_4c_MarkUp1.Visible   = .F.
1248:             THIS.lbl_4c_Para.Visible      = .F.
1249:             THIS.txt_4c_MarkUp2.Visible   = .F.
1250:             THIS.lbl_4c_FatorCusto.Visible = .F.
1251:             THIS.txt_4c_Fator.Visible     = .F.
1252:             THIS.txt_4c_MoeCusto.Visible  = .F.
1253:             THIS.lbl_4c_Moeda1.Visible    = .F.
1254:             THIS.txt_4c_MoeCs.Visible     = .F.
1255:             THIS.lbl_4c_Moeda2.Visible    = .F.
1256:             THIS.txt_4c_MoeCusFs.Visible  = .F.
1257:             THIS.lbl_4c_Moeda4.Visible    = .F.
1258:             THIS.txt_4c_Moedas.Visible    = .F.
1259:             THIS.lbl_4c_Moeda3.Visible    = .F.
1260:             THIS.txt_4c_CFtios.Visible    = .F.
1261:             THIS.lbl_4c_Moeda5.Visible    = .F.
1262:             THIS.txt_4c_MoeVs.Visible     = .F.
1263:         ENDCASE
1264: 
1265:         THIS.Refresh()
1266:     ENDPROC

*-- Linhas 1998 a 2007:
1998:         ENDIF
1999: 
2000:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
2001:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
2002:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
2003:         ENDIF
2004: 
2005:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2006:             SELECT cursor_4c_Produtos
2007:             GO TOP

