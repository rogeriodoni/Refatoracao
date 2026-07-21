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
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2209 linhas total):

*-- Linhas 60 a 68:
60:     *==========================================================================
61:         LOCAL loc_lSucesso, loc_oErro
62:         loc_lSucesso = .F.
63:         THIS.Caption = "Processamento de NF-e"
64:         TRY
65:             SET NULL ON
66:             IF USED("csOperacoes")
67:                 USE IN csOperacoes
68:             ENDIF

*-- Linhas 110 a 773:
110:     *==========================================================================
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:     *==========================================================================
113:         LOCAL loc_cCaption, loc_oCnt
114:         loc_cCaption = "Processamento de NF-e"
115:         THIS.AddObject("cnt_4c_Sombra", "Container")
116:         loc_oCnt = THIS.cnt_4c_Sombra
117:         WITH loc_oCnt
118:             .Top         = 0
119:             .Left        = 0
120:             .Width       = 1004
121:             .Height      = 80
122:             .BorderWidth = 0
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:         ENDWITH
126:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
127:         WITH loc_oCnt.lbl_4c_Sombra
128:             .AutoSize  = .F.
129:             .FontBold  = .T.
130:             .FontName  = "Tahoma"
131:             .FontSize  = 18
132:             .WordWrap  = .T.
133:             .BackStyle = 0
134:             .ForeColor = RGB(0, 0, 0)
135:             .Caption   = loc_cCaption
136:             .Height    = 40
137:             .Left      = 10
138:             .Top       = 18
139:             .Width     = THIS.Width
140:         ENDWITH
141:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oCnt.lbl_4c_Titulo
143:             .AutoSize  = .F.
144:             .FontBold  = .T.
145:             .FontName  = "Tahoma"
146:             .FontSize  = 18
147:             .WordWrap  = .T.
148:             .BackStyle = 0
149:             .ForeColor = RGB(255, 255, 255)
150:             .Caption   = loc_cCaption
151:             .Height    = 46
152:             .Left      = 10
153:             .Top       = 17
154:             .Width     = THIS.Width
155:         ENDWITH
156:     ENDPROC
157: 
158:     *==========================================================================
159:     PROTECTED PROCEDURE ConfigurarOperacoes()
160:     *==========================================================================
161:         LOCAL loc_oCnt, loc_oOpt
162: 
163:         THIS.AddObject("cnt_4c_Operacoes", "Container")
164:         loc_oCnt = THIS.cnt_4c_Operacoes
165:         WITH loc_oCnt
166:             .Top         = 83
167:             .Left        = 4
168:             .Width       = 824
169:             .Height      = 161
170:             .BorderWidth = 1
171:             .BackStyle   = 1
172:             .BackColor   = RGB(240, 240, 240)
173:         ENDWITH
174: 
175:         *-- Labels descritivos
176:         loc_oCnt.AddObject("lbl_4c_LblEmpresa", "Label")
177:         WITH loc_oCnt.lbl_4c_LblEmpresa
178:             .AutoSize  = .F.
179:             .BackStyle = 0
180:             .Caption   = "Empresa :"
181:             .FontName  = "Tahoma"
182:             .FontSize  = 8
183:             .Height    = 15
184:             .Left      = 35
185:             .Top       = 6
186:             .Width     = 55
187:         ENDWITH
188: 
189:         loc_oCnt.AddObject("lbl_4c_LblSerie", "Label")
190:         WITH loc_oCnt.lbl_4c_LblSerie
191:             .AutoSize  = .F.
192:             .BackStyle = 0
193:             .Caption   = "S" + CHR(233) + "rie :"
194:             .FontName  = "Tahoma"
195:             .FontSize  = 8
196:             .Height    = 15
197:             .Left      = 135
198:             .Top       = 6
199:             .Width     = 40
200:         ENDWITH
201: 
202:         loc_oCnt.AddObject("lbl_4c_LblDtEmis", "Label")
203:         WITH loc_oCnt.lbl_4c_LblDtEmis
204:             .AutoSize  = .F.
205:             .BackStyle = 0
206:             .Caption   = "Data de Emiss" + CHR(227) + "o :"
207:             .FontName  = "Tahoma"
208:             .FontSize  = 8
209:             .Height    = 15
210:             .Left      = 223
211:             .Top       = 6
212:             .Width     = 105
213:         ENDWITH
214: 
215:         loc_oCnt.AddObject("lbl_4c_LblAte", "Label")
216:         WITH loc_oCnt.lbl_4c_LblAte
217:             .AutoSize  = .F.
218:             .BackStyle = 0
219:             .Caption   = CHR(224)
220:             .FontName  = "Tahoma"
221:             .FontSize  = 8
222:             .Height    = 15
223:             .Left      = 416
224:             .Top       = 6
225:             .Width     = 10
226:         ENDWITH
227: 
228:         loc_oCnt.AddObject("lbl_4c_LblNotas", "Label")
229:         WITH loc_oCnt.lbl_4c_LblNotas
230:             .AutoSize  = .F.
231:             .BackStyle = 0
232:             .Caption   = "Notas Fiscais :"
233:             .FontName  = "Tahoma"
234:             .FontSize  = 8
235:             .Height    = 15
236:             .Left      = 14
237:             .Top       = 33
238:             .Width     = 75
239:         ENDWITH
240: 
241:         loc_oCnt.AddObject("lbl_4c_LblMovimento", "Label")
242:         WITH loc_oCnt.lbl_4c_LblMovimento
243:             .AutoSize  = .F.
244:             .BackStyle = 0
245:             .Caption   = "Movimento :"
246:             .FontName  = "Tahoma"
247:             .FontSize  = 8
248:             .Height    = 15
249:             .Left      = 517
250:             .Top       = 6
251:             .Width     = 61
252:         ENDWITH
253: 
254:         loc_oCnt.AddObject("lbl_4c_LblAmbiente", "Label")
255:         WITH loc_oCnt.lbl_4c_LblAmbiente
256:             .AutoSize  = .F.
257:             .BackStyle = 0
258:             .Caption   = "Ambiente :"
259:             .FontName  = "Tahoma"
260:             .FontSize  = 8
261:             .Height    = 15
262:             .Left      = 31
263:             .Top       = 59
264:             .Width     = 54
265:         ENDWITH
266: 
267:         loc_oCnt.AddObject("lbl_4c_LblVersao", "Label")
268:         WITH loc_oCnt.lbl_4c_LblVersao
269:             .AutoSize  = .F.
270:             .BackStyle = 0
271:             .Caption   = "Vers" + CHR(227) + "o: 2.0.4"
272:             .FontName  = "Tahoma"
273:             .FontSize  = 8
274:             .Height    = 15
275:             .Left      = 283
276:             .Top       = 61
277:             .Width     = 100
278:         ENDWITH
279: 
280:         loc_oCnt.AddObject("lbl_4c_LblImpressao", "Label")
281:         WITH loc_oCnt.lbl_4c_LblImpressao
282:             .AutoSize  = .F.
283:             .BackStyle = 0
284:             .Caption   = "Impress" + CHR(227) + "o :"
285:             .FontName  = "Tahoma"
286:             .FontSize  = 8
287:             .Height    = 15
288:             .Left      = 499
289:             .Top       = 59
290:             .Width     = 65
291:         ENDWITH
292: 
293:         loc_oCnt.AddObject("lbl_4c_LblSituacao", "Label")
294:         WITH loc_oCnt.lbl_4c_LblSituacao
295:             .AutoSize  = .F.
296:             .BackStyle = 0
297:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
298:             .FontName  = "Tahoma"
299:             .FontSize  = 8
300:             .Height    = 15
301:             .Left      = 35
302:             .Top       = 83
303:             .Width     = 50
304:         ENDWITH
305: 
306:         loc_oCnt.AddObject("lbl_4c_LblRegime", "Label")
307:         WITH loc_oCnt.lbl_4c_LblRegime
308:             .AutoSize  = .F.
309:             .BackStyle = 0
310:             .Caption   = "Regime Tribut" + CHR(225) + "rio :"
311:             .FontName  = "Tahoma"
312:             .FontSize  = 8
313:             .Height    = 15
314:             .Left      = 465
315:             .Top       = 83
316:             .Width     = 93
317:         ENDWITH
318: 
319:         loc_oCnt.AddObject("lbl_4c_LblAcao", "Label")
320:         WITH loc_oCnt.lbl_4c_LblAcao
321:             .AutoSize  = .F.
322:             .BackStyle = 0
323:             .Caption   = "A" + CHR(231) + CHR(227) + "o :"
324:             .FontName  = "Tahoma"
325:             .FontSize  = 8
326:             .Height    = 15
327:             .Left      = 52
328:             .Top       = 107
329:             .Width     = 33
330:         ENDWITH
331: 
332:         loc_oCnt.AddObject("lbl_4c_LblInuDe", "Label")
333:         WITH loc_oCnt.lbl_4c_LblInuDe
334:             .AutoSize  = .F.
335:             .BackStyle = 0
336:             .Caption   = "Inutilizar de :"
337:             .FontName  = "Tahoma"
338:             .FontSize  = 8
339:             .Height    = 15
340:             .Left      = 493
341:             .Top       = 108
342:             .Width     = 75
343:         ENDWITH
344: 
345:         loc_oCnt.AddObject("lbl_4c_LblInuAte", "Label")
346:         WITH loc_oCnt.lbl_4c_LblInuAte
347:             .AutoSize  = .F.
348:             .BackStyle = 0
349:             .Caption   = CHR(224)
350:             .FontName  = "Tahoma"
351:             .FontSize  = 8
352:             .Height    = 15
353:             .Left      = 672
354:             .Top       = 108
355:             .Width     = 10
356:         ENDWITH
357: 
358:         loc_oCnt.AddObject("lbl_4c_LblConting", "Label")
359:         WITH loc_oCnt.lbl_4c_LblConting
360:             .AutoSize  = .F.
361:             .BackStyle = 0
362:             .Caption   = "Conting" + CHR(234) + "ncia :"
363:             .FontName  = "Tahoma"
364:             .FontSize  = 8
365:             .Height    = 15
366:             .Left      = 14
367:             .Top       = 146
368:             .Width     = 75
369:         ENDWITH
370: 
371:         *-- TextBoxes de filtro
372:         loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
373:         WITH loc_oCnt.txt_4c_Emps
374:             .FontName      = "Tahoma"
375:             .FontSize      = 8
376:             .Height        = 23
377:             .Left          = 93
378:             .Top           = 2
379:             .Width         = 34
380:             .MaxLength     = 3
381:             .SpecialEffect = 1
382:         ENDWITH
383: 
384:         loc_oCnt.AddObject("txt_4c_Series", "TextBox")
385:         WITH loc_oCnt.txt_4c_Series
386:             .FontName      = "Tahoma"
387:             .FontSize      = 8
388:             .Height        = 23
389:             .Left          = 178
390:             .Top           = 2
391:             .Width         = 34
392:             .MaxLength     = 3
393:             .SpecialEffect = 1
394:         ENDWITH
395: 
396:         loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
397:         WITH loc_oCnt.txt_4c_DtIni
398:             .FontName      = "Tahoma"
399:             .FontSize      = 8
400:             .Height        = 23
401:             .Left          = 331
402:             .Top           = 2
403:             .Width         = 82
404:             .Value         = {}
405:             .SpecialEffect = 1
406:         ENDWITH
407: 
408:         loc_oCnt.AddObject("txt_4c_DtFin", "TextBox")
409:         WITH loc_oCnt.txt_4c_DtFin
410:             .FontName      = "Tahoma"
411:             .FontSize      = 8
412:             .Height        = 23
413:             .Left          = 428
414:             .Top           = 2
415:             .Width         = 82
416:             .Value         = {}
417:             .SpecialEffect = 1
418:         ENDWITH
419: 
420:         loc_oCnt.AddObject("txt_4c_Arquivos", "TextBox")
421:         WITH loc_oCnt.txt_4c_Arquivos
422:             .FontName      = "Tahoma"
423:             .FontSize      = 8
424:             .Height        = 23
425:             .Left          = 93
426:             .Top           = 29
427:             .Width         = 636
428:             .ReadOnly      = .T.
429:             .SpecialEffect = 1
430:         ENDWITH
431: 
432:         loc_oCnt.AddObject("txt_4c_InuIni", "TextBox")
433:         WITH loc_oCnt.txt_4c_InuIni
434:             .FontName      = "Tahoma"
435:             .FontSize      = 8
436:             .Height        = 23
437:             .Left          = 572
438:             .Top           = 104
439:             .Width         = 91
440:             .SpecialEffect = 1
441:         ENDWITH
442: 
443:         loc_oCnt.AddObject("txt_4c_InuFim", "TextBox")
444:         WITH loc_oCnt.txt_4c_InuFim
445:             .FontName      = "Tahoma"
446:             .FontSize      = 8
447:             .Height        = 23
448:             .Left          = 687
449:             .Top           = 104
450:             .Width         = 91
451:             .SpecialEffect = 1
452:         ENDWITH
453: 
454:         loc_oCnt.AddObject("txt_4c_IniContin", "TextBox")
455:         WITH loc_oCnt.txt_4c_IniContin
456:             .FontName      = "Tahoma"
457:             .FontSize      = 8
458:             .Height        = 20
459:             .Left          = 361
460:             .Top           = 141
461:             .Width         = 80
462:             .Value         = {}
463:             .SpecialEffect = 1
464:         ENDWITH
465: 
466:         *-- ComboBox Regime Tributario
467:         loc_oCnt.AddObject("cmb_4c_Regime", "ComboBox")
468:         WITH loc_oCnt.cmb_4c_Regime
469:             .FontName      = "Tahoma"
470:             .FontSize      = 8
471:             .Height        = 22
472:             .Left          = 572
473:             .Top           = 79
474:             .Width         = 206
475:             .RowSourceType = 1
476:             .RowSource     = "Simples Nacional,Lucro Presumido,Lucro Real,Lucro Arbitrado"
477:             .Style         = 2
478:         ENDWITH
479: 
480:         *-- CheckBoxes
481:         loc_oCnt.AddObject("chk_4c_OptArq", "CheckBox")
482:         WITH loc_oCnt.chk_4c_OptArq
483:             .Caption   = "Usar TXT-ALT"
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .Height    = 17
487:             .Left      = 566
488:             .Top       = 129
489:             .Width     = 103
490:             .Value     = 0
491:             .BackStyle = 0
492:         ENDWITH
493: 
494:         loc_oCnt.AddObject("chk_4c_HVerao", "CheckBox")
495:         WITH loc_oCnt.chk_4c_HVerao
496:             .Caption   = "Hor" + CHR(225) + "rio de Ver" + CHR(227) + "o"
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .Height    = 17
500:             .Left      = 682
501:             .Top       = 128
502:             .Width     = 121
503:             .Value     = 0
504:             .BackStyle = 0
505:         ENDWITH
506: 
507:         loc_oCnt.AddObject("chk_4c_Venc", "CheckBox")
508:         WITH loc_oCnt.chk_4c_Venc
509:             .Caption   = "Venc Futuros"
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .Height    = 17
513:             .Left      = 726
514:             .Top       = 58
515:             .Width     = 121
516:             .Value     = 0
517:             .BackStyle = 0
518:         ENDWITH
519: 
520:         loc_oCnt.AddObject("chk_4c_OptSub", "CheckBox")
521:         WITH loc_oCnt.chk_4c_OptSub
522:             .Caption   = "Subst. C" + CHR(243) + "digo do Produto por Refer" + CHR(234) + "ncia"
523:             .FontName  = "Tahoma"
524:             .FontSize  = 8
525:             .Height    = 15
526:             .Left      = 566
527:             .Top       = 145
528:             .Width     = 215
529:             .Value     = 0
530:             .BackStyle = 0
531:         ENDWITH
532: 
533:         *-- Botao "..." inutilizacao (oculto por padrao)
534:         loc_oCnt.AddObject("cmd_4c_Inu", "CommandButton")
535:         WITH loc_oCnt.cmd_4c_Inu
536:             .Caption = "..."
537:             .Height  = 22
538:             .Left    = 779
539:             .Top     = 105
540:             .Width   = 29
541:             .Visible = .F.
542:         ENDWITH
543: 
544:         *-- OptionGroups com WITH ANINHADO
545:         loc_oCnt.AddObject("opt_4c_Processados", "OptionGroup")
546:         loc_oOpt = loc_oCnt.opt_4c_Processados
547:         WITH loc_oOpt
548:             .ButtonCount = 2
549:             .Top         = 83
550:             .Left        = 89
551:             .Width       = 235
552:             .Height      = 17
553:             .BackStyle   = 0
554:             .BorderStyle = 0
555:             .Value       = 1
556:             WITH .Buttons(1)
557:                 .Caption   = "N" + CHR(227) + "o Processados"
558:                 .Width     = 115
559:                 .Left      = 0
560:                 .FontName  = "Tahoma"
561:                 .FontSize  = 8
562:                 .BackStyle = 0
563:             ENDWITH
564:             WITH .Buttons(2)
565:                 .Caption   = "J" + CHR(225) + " Processados"
566:                 .Width     = 115
567:                 .Left      = 118
568:                 .FontName  = "Tahoma"
569:                 .FontSize  = 8
570:                 .BackStyle = 0
571:             ENDWITH
572:         ENDWITH
573: 
574:         loc_oCnt.AddObject("opt_4c_Tipos", "OptionGroup")
575:         loc_oOpt = loc_oCnt.opt_4c_Tipos
576:         WITH loc_oOpt
577:             .ButtonCount = 2
578:             .Top         = 6
579:             .Left        = 590
580:             .Width       = 142
581:             .Height      = 15
582:             .BackStyle   = 0
583:             .BorderStyle = 0
584:             .Value       = 1
585:             WITH .Buttons(1)
586:                 .Caption   = "Sa" + CHR(237) + "da"
587:                 .Width     = 65
588:                 .Left      = 0
589:                 .FontName  = "Tahoma"
590:                 .FontSize  = 8
591:                 .BackStyle = 0
592:             ENDWITH
593:             WITH .Buttons(2)
594:                 .Caption   = "Entrada"
595:                 .Width     = 65
596:                 .Left      = 68
597:                 .FontName  = "Tahoma"
598:                 .FontSize  = 8
599:                 .BackStyle = 0
600:             ENDWITH
601:         ENDWITH
602: 
603:         loc_oCnt.AddObject("opt_4c_Ambiente", "OptionGroup")
604:         loc_oOpt = loc_oCnt.opt_4c_Ambiente
605:         WITH loc_oOpt
606:             .ButtonCount = 2
607:             .Top         = 54
608:             .Left        = 89
609:             .Width       = 173
610:             .Height      = 25
611:             .BackStyle   = 0
612:             .BorderStyle = 0
613:             .Value       = 1
614:             WITH .Buttons(1)
615:                 .Caption   = "Produ" + CHR(231) + CHR(227) + "o"
616:                 .Width     = 85
617:                 .Left      = 0
618:                 .FontName  = "Tahoma"
619:                 .FontSize  = 8
620:                 .BackStyle = 0
621:             ENDWITH
622:             WITH .Buttons(2)
623:                 .Caption   = "Homologa" + CHR(231) + CHR(227) + "o"
624:                 .Width     = 85
625:                 .Left      = 88
626:                 .FontName  = "Tahoma"
627:                 .FontSize  = 8
628:                 .BackStyle = 0
629:             ENDWITH
630:         ENDWITH
631: 
632:         loc_oCnt.AddObject("opt_4c_Impressao", "OptionGroup")
633:         loc_oOpt = loc_oCnt.opt_4c_Impressao
634:         WITH loc_oOpt
635:             .ButtonCount = 3
636:             .Top         = 59
637:             .Left        = 569
638:             .Width       = 151
639:             .Height      = 15
640:             .BackStyle   = 0
641:             .BorderStyle = 0
642:             .Value       = 1
643:             WITH .Buttons(1)
644:                 .Caption   = "Retrato"
645:                 .Width     = 48
646:                 .Left      = 0
647:                 .FontName  = "Tahoma"
648:                 .FontSize  = 8
649:                 .BackStyle = 0
650:             ENDWITH
651:             WITH .Buttons(2)
652:                 .Caption   = "Paisagem"
653:                 .Width     = 55
654:                 .Left      = 50
655:                 .FontName  = "Tahoma"
656:                 .FontSize  = 8
657:                 .BackStyle = 0
658:             ENDWITH
659:             WITH .Buttons(3)
660:                 .Caption   = "Sem"
661:                 .Width     = 44
662:                 .Left      = 107
663:                 .FontName  = "Tahoma"
664:                 .FontSize  = 8
665:                 .BackStyle = 0
666:             ENDWITH
667:         ENDWITH
668: 
669:         loc_oCnt.AddObject("opt_4c_Acao", "OptionGroup")
670:         loc_oOpt = loc_oCnt.opt_4c_Acao
671:         WITH loc_oOpt
672:             .ButtonCount = 7
673:             .Top         = 101
674:             .Left        = 92
675:             .Width       = 397
676:             .Height      = 38
677:             .BackStyle   = 0
678:             .BorderStyle = 0
679:             .Value       = 1
680:             WITH .Buttons(1)
681:                 .Caption   = "Enviar"
682:                 .Width     = 55
683:                 .Left      = 0
684:                 .FontName  = "Tahoma"
685:                 .FontSize  = 8
686:                 .BackStyle = 0
687:             ENDWITH
688:             WITH .Buttons(2)
689:                 .Caption   = "Consultar"
690:                 .Width     = 60
691:                 .Left      = 57
692:                 .FontName  = "Tahoma"
693:                 .FontSize  = 8
694:                 .BackStyle = 0
695:             ENDWITH
696:             WITH .Buttons(3)
697:                 .Caption   = "Cancelar"
698:                 .Width     = 58
699:                 .Left      = 119
700:                 .FontName  = "Tahoma"
701:                 .FontSize  = 8
702:                 .BackStyle = 0
703:             ENDWITH
704:             WITH .Buttons(4)
705:                 .Caption   = "Inutilizar"
706:                 .Width     = 60
707:                 .Left      = 179
708:                 .FontName  = "Tahoma"
709:                 .FontSize  = 8
710:                 .BackStyle = 0
711:             ENDWITH
712:             WITH .Buttons(5)
713:                 .Caption   = "PDF"
714:                 .Width     = 36
715:                 .Left      = 241
716:                 .FontName  = "Tahoma"
717:                 .FontSize  = 8
718:                 .BackStyle = 0
719:             ENDWITH
720:             WITH .Buttons(6)
721:                 .Caption   = "E-mail"
722:                 .Width     = 48
723:                 .Left      = 279
724:                 .FontName  = "Tahoma"
725:                 .FontSize  = 8
726:                 .BackStyle = 0
727:             ENDWITH
728:             WITH .Buttons(7)
729:                 .Caption   = "Status"
730:                 .Width     = 48
731:                 .Left      = 329
732:                 .FontName  = "Tahoma"
733:                 .FontSize  = 8
734:                 .BackStyle = 0
735:             ENDWITH
736:         ENDWITH
737: 
738:         loc_oCnt.AddObject("opt_4c_Contin", "OptionGroup")
739:         loc_oOpt = loc_oCnt.opt_4c_Contin
740:         WITH loc_oOpt
741:             .ButtonCount = 3
742:             .Top         = 140
743:             .Left        = 92
744:             .Width       = 258
745:             .Height      = 21
746:             .BackStyle   = 0
747:             .BorderStyle = 0
748:             .Value       = 1
749:             WITH .Buttons(1)
750:                 .Caption   = "Nenhuma"
751:                 .Width     = 75
752:                 .Left      = 0
753:                 .FontName  = "Tahoma"
754:                 .FontSize  = 8
755:                 .BackStyle = 0
756:             ENDWITH
757:             WITH .Buttons(2)
758:                 .Caption   = "EPEC"
759:                 .Width     = 52
760:                 .Left      = 77
761:                 .FontName  = "Tahoma"
762:                 .FontSize  = 8
763:                 .BackStyle = 0
764:             ENDWITH
765:             WITH .Buttons(3)
766:                 .Caption   = "SCAN/SVC"
767:                 .Width     = 75
768:                 .Left      = 131
769:                 .FontName  = "Tahoma"
770:                 .FontSize  = 8
771:                 .BackStyle = 0
772:             ENDWITH
773:         ENDWITH

*-- Linhas 781 a 802:
781:         THIS.AddObject("cnt_4c_Grade", "Container")
782:         loc_oCnt = THIS.cnt_4c_Grade
783:         WITH loc_oCnt
784:             .Top         = 247
785:             .Left        = 50
786:             .Width       = 820
787:             .Height      = 344
788:             .BorderWidth = 1
789:             .BackStyle   = 1
790:             .BackColor   = RGB(220, 220, 220)
791:         ENDWITH
792: 
793:         loc_oCnt.AddObject("grd_4c_Operacoes", "Grid")
794:         loc_oGrd = loc_oCnt.grd_4c_Operacoes
795:         WITH loc_oGrd
796:             .Top           = 1
797:             .Left          = 3
798:             .Width         = 813
799:             .Height        = 340
800:             .ColumnCount   = 9
801:             .RecordSource  = "csOperacoes"
802:             .ReadOnly      = .T.

*-- Linhas 811 a 830:
811:             .FontSize      = 8
812:         ENDWITH
813: 
814:         *-- Column1: selecao (CheckBox com Sparse=.F.)
815:         WITH loc_oGrd.Column1
816:             .Width         = 25
817:             .ReadOnly      = .F.
818:             .ControlSource = "csOperacoes.SelImp"
819:         ENDWITH
820:         WITH loc_oGrd.Column1.Header1
821:             .Caption = ""
822:         ENDWITH
823:         loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
824:         WITH loc_oGrd.Column1.chk_4c_SelImp
825:             .Caption   = ""
826:             .Width     = 22
827:             .Height    = 17
828:             .BackStyle = 0
829:         ENDWITH
830:         loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"

*-- Linhas 837 a 929:
837:             .ControlSource = "csOperacoes.Dopes"
838:         ENDWITH
839:         WITH loc_oGrd.Column2.Header1
840:             .Caption = "C" + CHR(243) + "digo"
841:         ENDWITH
842: 
843:         *-- Column3: Emissao (Datas)
844:         WITH loc_oGrd.Column3
845:             .Width         = 80
846:             .ReadOnly      = .T.
847:             .ControlSource = "csOperacoes.Datas"
848:         ENDWITH
849:         WITH loc_oGrd.Column3.Header1
850:             .Caption = "Emiss" + CHR(227) + "o"
851:         ENDWITH
852: 
853:         *-- Column4: Valor (Valos)
854:         WITH loc_oGrd.Column4
855:             .Width         = 100
856:             .ReadOnly      = .T.
857:             .ControlSource = "csOperacoes.Valos"
858:         ENDWITH
859:         WITH loc_oGrd.Column4.Header1
860:             .Caption = "Valor"
861:         ENDWITH
862: 
863:         *-- Column5: Nota Fiscal (Notas)
864:         WITH loc_oGrd.Column5
865:             .Width         = 80
866:             .ReadOnly      = .T.
867:             .ControlSource = "csOperacoes.Notas"
868:         ENDWITH
869:         WITH loc_oGrd.Column5.Header1
870:             .Caption = "Nota Fiscal"
871:         ENDWITH
872: 
873:         *-- Column6: Serie (Series)
874:         WITH loc_oGrd.Column6
875:             .Width         = 50
876:             .ReadOnly      = .T.
877:             .ControlSource = "csOperacoes.Series"
878:         ENDWITH
879:         WITH loc_oGrd.Column6.Header1
880:             .Caption = "S" + CHR(233) + "rie"
881:         ENDWITH
882: 
883:         *-- Column7: Movimentacao (Tipos)
884:         WITH loc_oGrd.Column7
885:             .Width         = 95
886:             .ReadOnly      = .T.
887:             .ControlSource = "csOperacoes.Tipos"
888:         ENDWITH
889:         WITH loc_oGrd.Column7.Header1
890:             .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
891:         ENDWITH
892: 
893:         *-- Column8: Empresa (Emps)
894:         WITH loc_oGrd.Column8
895:             .Width         = 50
896:             .ReadOnly      = .T.
897:             .ControlSource = "csOperacoes.Emps"
898:         ENDWITH
899:         WITH loc_oGrd.Column8.Header1
900:             .Caption = "Emp"
901:         ENDWITH
902: 
903:         *-- Column9: Status (stats)
904:         WITH loc_oGrd.Column9
905:             .Width         = 148
906:             .ReadOnly      = .T.
907:             .ControlSource = "csOperacoes.stats"
908:         ENDWITH
909:         WITH loc_oGrd.Column9.Header1
910:             .Caption = "Stat"
911:         ENDWITH
912:     ENDPROC
913: 
914:     *==========================================================================
915:     PROTECTED PROCEDURE ConfigurarBotoesForm()
916:     *==========================================================================
917:         *-- Botao Selecionar
918:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
919:         WITH THIS.cmd_4c_Selecionar
920:             .Top             = 83
921:             .Left            = 843
922:             .Width           = 75
923:             .Height          = 75
924:             .Caption         = "\<Selecionar"
925:             .Picture         = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
926:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
927:             .PicturePosition = 7
928:             .FontName        = "Tahoma"
929:             .FontBold        = .T.

*-- Linhas 939 a 953:
939:         ENDWITH
940: 
941:         *-- Botao Limpar (desabilitado ate selecionar)
942:         THIS.AddObject("cmd_4c_BtnLimpar", "CommandButton")
943:         WITH THIS.cmd_4c_BtnLimpar
944:             .Top             = 162
945:             .Left            = 843
946:             .Width           = 75
947:             .Height          = 37
948:             .Caption         = "Limpar"
949:             .Picture         = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
950:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
951:             .PicturePosition = 13
952:             .FontName        = "Tahoma"
953:             .FontBold        = .T.

*-- Linhas 962 a 976:
962:         ENDWITH
963: 
964:         *-- Botao Processar (desabilitado ate selecionar)
965:         THIS.AddObject("cmd_4c_BtnCopiar", "CommandButton")
966:         WITH THIS.cmd_4c_BtnCopiar
967:             .Top             = 202
968:             .Left            = 843
969:             .Width           = 75
970:             .Height          = 37
971:             .Caption         = "Processar"
972:             .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
973:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
974:             .PicturePosition = 13
975:             .FontName        = "Tahoma"
976:             .FontBold        = .T.

*-- Linhas 985 a 999:
985:         ENDWITH
986: 
987:         *-- Botao Encerrar
988:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
989:         WITH THIS.cmd_4c_Encerrar
990:             .Top             = 499
991:             .Left            = 917
992:             .Width           = 75
993:             .Height          = 75
994:             .Caption         = "Encerrar"
995:             .Cancel          = .T.
996:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
997:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
998:             .PicturePosition = 7
999:             .FontName        = "Tahoma"

*-- Linhas 1013 a 1027:
1013:     *==========================================================================
1014:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
1015:     *==========================================================================
1016:         THIS.AddObject("cmd_4c_MarcaTudo", "CommandButton")
1017:         WITH THIS.cmd_4c_MarcaTudo
1018:             .Top             = 264
1019:             .Left            = 873
1020:             .Width           = 75
1021:             .Height          = 55
1022:             .Caption         = "Marca Tudo"
1023:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1024:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1025:             .PicturePosition = 13
1026:             .FontName        = "Tahoma"
1027:             .FontBold        = .T.

*-- Linhas 1035 a 1049:
1035:             .Enabled         = .F.
1036:         ENDWITH
1037: 
1038:         THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
1039:         WITH THIS.cmd_4c_Desmarcar
1040:             .Top             = 322
1041:             .Left            = 873
1042:             .Width           = 75
1043:             .Height          = 55
1044:             .Caption         = "Desmarcar"
1045:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1046:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1047:             .PicturePosition = 13
1048:             .FontName        = "Tahoma"
1049:             .FontBold        = .T.

*-- Linhas 1057 a 1071:
1057:             .Enabled         = .F.
1058:         ENDWITH
1059: 
1060:         THIS.AddObject("cmd_4c_Documentos", "CommandButton")
1061:         WITH THIS.cmd_4c_Documentos
1062:             .Top             = 380
1063:             .Left            = 873
1064:             .Width           = 75
1065:             .Height          = 55
1066:             .Caption         = "Documentos"
1067:             .Picture         = gc_4c_CaminhoIcones + "cadastro_consultar_26.jpg"
1068:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_consultar_26.jpg"
1069:             .PicturePosition = 13
1070:             .FontName        = "Tahoma"
1071:             .FontBold        = .T.

*-- Linhas 1079 a 1093:
1079:             .Enabled         = .F.
1080:         ENDWITH
1081: 
1082:         THIS.AddObject("cmd_4c_ImpDSimpl", "CommandButton")
1083:         WITH THIS.cmd_4c_ImpDSimpl
1084:             .Top             = 438
1085:             .Left            = 873
1086:             .Width           = 75
1087:             .Height          = 55
1088:             .Caption         = "Imp. Simpl."
1089:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1090:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1091:             .PicturePosition = 13
1092:             .FontName        = "Tahoma"
1093:             .FontBold        = .T.

*-- Linhas 1110 a 1148:
1110:         THIS.AddObject("cnt_4c_Inu", "Container")
1111:         loc_oCnt = THIS.cnt_4c_Inu
1112:         WITH loc_oCnt
1113:             .Top         = 156
1114:             .Left        = 203
1115:             .Width       = 504
1116:             .Height      = 392
1117:             .Visible     = .F.
1118:             .BorderWidth = 2
1119:             .BackStyle   = 1
1120:             .BackColor   = RGB(245, 245, 245)
1121:         ENDWITH
1122: 
1123:         loc_oCnt.AddObject("lbl_4c_TituloInu", "Label")
1124:         WITH loc_oCnt.lbl_4c_TituloInu
1125:             .AutoSize  = .F.
1126:             .Caption   = "Notas Fiscais para Inutilizar"
1127:             .FontName  = "Tahoma"
1128:             .FontSize  = 10
1129:             .FontBold  = .T.
1130:             .BackStyle = 0
1131:             .Height    = 20
1132:             .Left      = 10
1133:             .Top       = 5
1134:             .Width     = 380
1135:         ENDWITH
1136: 
1137:         loc_oCnt.AddObject("cmd_4c_BtnCancelaInu", "CommandButton")
1138:         WITH loc_oCnt.cmd_4c_BtnCancelaInu
1139:             .Top             = 28
1140:             .Left            = 408
1141:             .Width           = 75
1142:             .Height          = 75
1143:             .Caption         = "Encerrar"
1144:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1145:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1146:             .PicturePosition = 7
1147:             .FontName        = "Tahoma"
1148:             .FontBold        = .T.

*-- Linhas 1155 a 1169:
1155:             .MousePointer    = 15
1156:         ENDWITH
1157: 
1158:         loc_oCnt.AddObject("cmd_4c_BtnProcInu", "CommandButton")
1159:         WITH loc_oCnt.cmd_4c_BtnProcInu
1160:             .Top             = 105
1161:             .Left            = 408
1162:             .Width           = 75
1163:             .Height          = 75
1164:             .Caption         = "Processar"
1165:             .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
1166:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
1167:             .PicturePosition = 7
1168:             .FontName        = "Tahoma"
1169:             .FontBold        = .T.

*-- Linhas 1179 a 1188:
1179:         loc_oCnt.AddObject("grd_4c_Inu", "Grid")
1180:         loc_oGrd = loc_oCnt.grd_4c_Inu
1181:         WITH loc_oGrd
1182:             .Top           = 28
1183:             .Left          = 17
1184:             .Width         = 382
1185:             .Height        = 355
1186:             .ColumnCount   = 6
1187:             .ReadOnly      = .F.
1188:             .GridLines     = 1

*-- Linhas 1200 a 1277:
1200:             .Width = 35
1201:         ENDWITH
1202:         WITH loc_oGrd.Column1.Header1
1203:             .Caption = "Emp"
1204:         ENDWITH
1205:         WITH loc_oGrd.Column2
1206:             .Width = 40
1207:         ENDWITH
1208:         WITH loc_oGrd.Column2.Header1
1209:             .Caption = "S" + CHR(233) + "rie"
1210:         ENDWITH
1211:         WITH loc_oGrd.Column3
1212:             .Width = 70
1213:         ENDWITH
1214:         WITH loc_oGrd.Column3.Header1
1215:             .Caption = "Nota Inicial"
1216:         ENDWITH
1217:         WITH loc_oGrd.Column4
1218:             .Width = 70
1219:         ENDWITH
1220:         WITH loc_oGrd.Column4.Header1
1221:             .Caption = "Nota Final"
1222:         ENDWITH
1223:         WITH loc_oGrd.Column5
1224:             .Width = 105
1225:         ENDWITH
1226:         WITH loc_oGrd.Column5.Header1
1227:             .Caption = "CPF/CNPJ"
1228:         ENDWITH
1229:         WITH loc_oGrd.Column6
1230:             .Width = 62
1231:         ENDWITH
1232:         WITH loc_oGrd.Column6.Header1
1233:             .Caption = ""
1234:         ENDWITH
1235:         loc_oGrd.Column6.AddObject("chk_4c_SelInu", "CheckBox")
1236:         WITH loc_oGrd.Column6.chk_4c_SelInu
1237:             .Caption   = ""
1238:             .Width     = 60
1239:             .Height    = 17
1240:             .BackStyle = 0
1241:         ENDWITH
1242:         loc_oGrd.Column6.CurrentControl = "chk_4c_SelInu"
1243:         loc_oGrd.Column6.Sparse         = .F.
1244:     ENDPROC
1245: 
1246:     *==========================================================================
1247:     * TornarControlesVisiveis: torna visiveis todos os controles de nivel raiz,
1248:     * exceto os containers gerenciados individualmente (INLIST). cnt_4c_Inu e
1249:     * cmd_4c_Inu sao reocultados explicitamente apos o loop.
1250:     *==========================================================================
1251:     PROCEDURE TornarControlesVisiveis()
1252:         LOCAL loc_oErro, loc_oCtrl, loc_cNome
1253:         TRY
1254:             FOR EACH loc_oCtrl IN THIS.Controls
1255:                 IF VARTYPE(loc_oCtrl) = "O"
1256:                     loc_cNome = LOWER(loc_oCtrl.Name)
1257:                     IF INLIST(loc_cNome, "cnt_4c_sombra", "cnt_4c_grade")
1258:                         *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
1259:                         IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1260:                             THIS.TornarControlesVisiveis(loc_oControl)
1261:                         ENDIF
1262:                         LOOP
1263:                     ENDIF
1264:                     loc_oCtrl.Visible = .T.
1265:                 ENDIF
1266:             ENDFOR
1267:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1268:                 THIS.cnt_4c_Inu.Visible = .F.
1269:             ENDIF
1270:             IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
1271:                 IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1272:                     THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = .F.
1273:                 ENDIF
1274:             ENDIF
1275:         CATCH TO loc_oErro
1276:             MsgErro(loc_oErro.Message, "Erro TornarControlesVisiveis")
1277:         ENDTRY

*-- Linhas 1298 a 1307:
1298:                     THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1299:                 ENDIF
1300:             ENDIF
1301:             IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
1302:                 THIS.cmd_4c_Selecionar.Enabled = .T.
1303:             ENDIF
1304:         CATCH TO loc_oErro
1305:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
1306:         ENDTRY
1307:     ENDPROC

*-- Linhas 1324 a 1333:
1324:                     ENDIF
1325:                     THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
1326:                 ENDIF
1327:                 IF PEMSTATUS(THIS.cnt_4c_Inu, "cmd_4c_BtnProcInu", 5)
1328:                     THIS.cnt_4c_Inu.cmd_4c_BtnProcInu.Enabled = ;
1329:                         (USED("csInutil") AND RECCOUNT("csInutil") > 0)
1330:                 ENDIF
1331:                 THIS.cnt_4c_Inu.ZOrder(0)
1332:             ENDIF
1333:         CATCH TO loc_oErro

*-- Linhas 1360 a 1381:
1360:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1361:     *==========================================================================
1362:         LOCAL loc_oGrd
1363:         BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
1364:         BINDEVENT(THIS.cmd_4c_BtnLimpar,  "Click", THIS, "BtnLimparClick")
1365:         BINDEVENT(THIS.cmd_4c_BtnCopiar,  "Click", THIS, "BtnCopiarClick")
1366:         BINDEVENT(THIS.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
1367:         BINDEVENT(THIS.cmd_4c_MarcaTudo,  "Click", THIS, "BtnMarcaTudoClick")
1368:         BINDEVENT(THIS.cmd_4c_Desmarcar,  "Click", THIS, "BtnDesmarcarClick")
1369:         BINDEVENT(THIS.cmd_4c_Documentos, "Click", THIS, "BtnDocumentosClick")
1370:         BINDEVENT(THIS.cmd_4c_ImpDSimpl,  "Click", THIS, "BtnImpDSimplClick")
1371:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnCancelaInu, "Click", THIS, "BtnCancelaInuClick")
1372:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnProcInu,    "Click", THIS, "BtnProcInuClick")
1373:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Emps,    "KeyPress", THIS, "EmpsLostFocus")
1374:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Series,  "KeyPress", THIS, "SeriesLostFocus")
1375:         BINDEVENT(THIS.cnt_4c_Operacoes.opt_4c_Acao, "InteractiveChange", THIS, "AcaoInteractiveChange")
1376:         BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_Inu,  "Click", THIS, "CmdInuClick")
1377:         loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Operacoes
1378:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "MouseUp",  THIS, "GridChkMouseUp")
1379:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "KeyPress", THIS, "GridChkKeyPress")
1380:     ENDPROC
1381: 

*-- Linhas 1615 a 1624:
1615:     ENDPROC
1616: 
1617:     PROCEDURE AcaoInteractiveChange()
1618:         IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1619:             THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;
1620:                 INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
1621:         ENDIF
1622:     ENDPROC
1623: 
1624:     PROCEDURE CmdInuClick()

*-- Linhas 1792 a 1812:
1792:         ENDIF
1793:     ENDPROC
1794: 
1795:     *-- MouseUp no CheckBox de selecao: toggle SelImp do registro corrente
1796:     PROCEDURE GridChkMouseUp
1797:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
1798:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1799:             m.SelImp = (NOT csOperacoes.SelImp)
1800:             SELECT csOperacoes
1801:             GATHER MEMVAR FIELDS SelImp
1802:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1803:         ENDIF
1804:         NODEFAULT
1805:     ENDPROC
1806: 
1807:     *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
1808:     PROCEDURE GridChkKeyPress
1809:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1810:         IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
1811:             m.SelImp = (NOT csOperacoes.SelImp)
1812:             SELECT csOperacoes

*-- Linhas 1821 a 1829:
1821:             ZAP IN csOperacoes
1822:         ENDIF
1823:         THIS.HabilitarControles(.T.)
1824:         THIS.cmd_4c_ImpDSimpl.Enabled = .F.
1825:         THIS.Refresh()
1826:     ENDPROC
1827: 
1828:     PROCEDURE HabilitarControles(par_lHabilitar)
1829:         WITH THIS.cnt_4c_Operacoes

*-- Linhas 1838 a 1852:
1838:             .opt_4c_Processados.Buttons(2).Enabled = par_lHabilitar
1839:             .Visible     = .T.
1840:         ENDWITH
1841:         THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
1842:         THIS.cmd_4c_BtnLimpar.Enabled  = !par_lHabilitar
1843:         THIS.cmd_4c_BtnCopiar.Enabled  = !par_lHabilitar
1844:         THIS.cmd_4c_MarcaTudo.Enabled  = !par_lHabilitar
1845:         THIS.cmd_4c_Desmarcar.Enabled  = !par_lHabilitar
1846:         THIS.cmd_4c_Documentos.Enabled = !par_lHabilitar
1847:         THIS.cmd_4c_ImpDSimpl.Enabled  = !par_lHabilitar
1848:     ENDPROC
1849: 
1850:     *==========================================================================
1851:     * Eventos CRUD adaptados ao contexto OPERACIONAL de processamento de NFe.
1852:     * Em forms de processamento fiscal, as semanticas CRUD tradicionais mapeiam

*-- Linhas 1958 a 1966:
1958:     *--------------------------------------------------------------------------
1959:     * FormParaBO - Copia TODOS os valores da UI para o Business Object.
1960:     * Cobre os 3 blocos de propriedades: parametros de sele" + CHR(231) + CHR(227) + "o
1961:     * (empresa/serie/datas/acao), flags/checkboxes e o registro corrente
1962:     * de csOperacoes (linha selecionada no grid).
1963:     *--------------------------------------------------------------------------
1964:     PROCEDURE FormParaBO()
1965:         LOCAL loc_oBO, loc_oCnt
1966:         loc_oBO = THIS.this_oBusinessObject

*-- Linhas 1994 a 2002:
1994:             ENDIF
1995:         ENDIF
1996: 
1997:         *-- Bloco 2: flags/checkboxes (Value NUMERICO 0/1 -> LOGICAL no BO)
1998:         loc_oBO.this_lHVerao  = (loc_oCnt.chk_4c_HVerao.Value = 1)
1999:         loc_oBO.this_lVenc    = (loc_oCnt.chk_4c_Venc.Value = 1)
2000:         loc_oBO.this_lOptSub  = (loc_oCnt.chk_4c_OptSub.Value = 1)
2001:         loc_oBO.this_lOptArq  = (loc_oCnt.chk_4c_OptArq.Value = 1)
2002: 

*-- Linhas 2065 a 2073:
2065:         loc_oCnt.txt_4c_Arquivos.Value = loc_oBO.this_cArquivos
2066:         loc_oCnt.txt_4c_IniContin.Value = loc_oBO.this_dIniContin
2067: 
2068:         *-- Bloco 2: flags/checkboxes (LOGICAL BO -> NUMERICO 0/1 CheckBox)
2069:         loc_oCnt.chk_4c_HVerao.Value = IIF(loc_oBO.this_lHVerao, 1, 0)
2070:         loc_oCnt.chk_4c_Venc.Value   = IIF(loc_oBO.this_lVenc, 1, 0)
2071:         loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)
2072:         loc_oCnt.chk_4c_OptArq.Value = IIF(loc_oBO.this_lOptArq, 1, 0)
2073: 

