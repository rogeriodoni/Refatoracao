# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 224: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 247: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReInv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1643 linhas total):

*-- Linhas 48 a 56:
48:         loc_lSucesso   = .F.
49:         loc_lContinuar = .T.
50:         TRY
51:             THIS.Caption = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
52: 
53:             IF TYPE("gc_4c_CaminhoIcones") = "U"
54:                 gc_4c_CaminhoIcones = ""
55:             ENDIF
56:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 89 a 98:
89: 
90:                 THIS.LimparCampos()
91: 
92:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
93:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
94: 
95:                 THIS.Visible = .T.
96:                 loc_lSucesso = .T.
97:             ENDIF
98: 

*-- Linhas 111 a 149:
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH THIS.cnt_4c_Cabecalho
114:             .Top         = 0
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackStyle   = 1
119:             .BackColor   = RGB(100, 100, 100)
120:             .BorderWidth = 0
121:             .Visible     = .T.
122: 
123:             .AddObject("lbl_4c_Sombra", "Label")
124:             WITH .lbl_4c_Sombra
125:                 .Top       = 22
126:                 .Left      = 22
127:                 .Width     = THIS.Width
128:                 .Height    = 30
129:                 .Caption   = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
130:                 .FontName  = "Tahoma"
131:                 .FontSize  = 14
132:                 .FontBold  = .T.
133:                 .ForeColor = RGB(0, 0, 0)
134:                 .BackStyle = 0
135:                 .Visible   = .T.
136:             ENDWITH
137: 
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Top       = 20
141:                 .Left      = 20
142:                 .Width     = THIS.Width
143:                 .Height    = 30
144:                 .Caption   = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 14
147:                 .FontBold  = .T.
148:                 .ForeColor = RGB(255, 255, 255)
149:                 .BackStyle = 0

*-- Linhas 160 a 185:
160:     PROTECTED PROCEDURE ConfigurarBotoes()
161:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
162:         WITH THIS.cmg_4c_Botoes
163:             .Top           = 0
164:             .Left          = 529
165:             .Width         = 273
166:             .Height        = 80
167:             .ButtonCount   = 4
168:             .BackStyle     = 0
169:             .BorderStyle   = 0
170:             .BorderColor   = RGB(136, 189, 188)
171:             .SpecialEffect = 1
172:             .Themes        = .F.
173:             .Visible       = .T.
174: 
175:             WITH .Buttons(1)
176:                 .Top             = 5
177:                 .Left            = 5
178:                 .Width           = 65
179:                 .Height          = 70
180:                 .Caption         = "Visualizar"
181:                 .FontBold        = .T.
182:                 .FontItalic      = .T.
183:                 .BackColor       = RGB(255, 255, 255)
184:                 .ForeColor       = RGB(90, 90, 90)
185:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 193 a 207:
193:             ENDWITH
194: 
195:             WITH .Buttons(2)
196:                 .Top             = 5
197:                 .Left            = 71
198:                 .Width           = 65
199:                 .Height          = 70
200:                 .Caption         = "Imprimir"
201:                 .FontName        = "Comic Sans MS"
202:                 .FontBold        = .T.
203:                 .FontItalic      = .T.
204:                 .FontSize        = 8
205:                 .BackColor       = RGB(255, 255, 255)
206:                 .ForeColor       = RGB(90, 90, 90)
207:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 216 a 230:
216: 
217:             *-- Botao 3: Gera Inventario TXT (equivalente ao Command1 do legado)
218:             WITH .Buttons(3)
219:                 .Top             = 5
220:                 .Left            = 137
221:                 .Width           = 65
222:                 .Height          = 70
223:                 .Caption         = "Gera TXT"
224:                 .FontName        = "Comic Sans MS"
225:                 .FontBold        = .T.
226:                 .FontItalic      = .T.
227:                 .FontSize        = 8
228:                 .BackColor       = RGB(255, 255, 255)
229:                 .ForeColor       = RGB(90, 90, 90)
230:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 238 a 253:
238:             ENDWITH
239: 
240:             WITH .Buttons(4)
241:                 .Top             = 5
242:                 .Left            = 203
243:                 .Width           = 65
244:                 .Height          = 70
245:                 .Caption         = "Encerrar"
246:                 .Cancel          = .T.
247:                 .FontName        = "Comic Sans MS"
248:                 .FontBold        = .T.
249:                 .FontItalic      = .T.
250:                 .FontSize        = 8
251:                 .BackColor       = RGB(255, 255, 255)
252:                 .ForeColor       = RGB(90, 90, 90)
253:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 271 a 286:
271:         loc_lVendaVisivel = .T.
272: 
273:         *-- Label Empresa
274:         THIS.AddObject("lbl_4c_Empresa", "Label")
275:         WITH THIS.lbl_4c_Empresa
276:             .AutoSize  = .T.
277:             .FontName  = "Tahoma"
278:             .FontSize  = 8
279:             .Caption   = "Empresa :"
280:             .Left      = 164
281:             .Top       = 160
282:             .ForeColor = RGB(90, 90, 90)
283:             .BackStyle = 0
284:             .Visible   = .T.
285:         ENDWITH
286: 

*-- Linhas 292 a 304:
292:             .Format        = "K!"
293:             .Height        = 25
294:             .InputMask     = "XXX"
295:             .Left          = 219
296:             .MaxLength     = 3
297:             .SpecialEffect = 1
298:             .TabIndex      = 1
299:             .Top           = 156
300:             .Width         = 31
301:             .Visible       = .T.
302:         ENDWITH
303:         BINDEVENT(THIS.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
304:         BINDEVENT(THIS.txt_4c_CdEmpresa, "DblClick", THIS, "EmpresaDblClick")

*-- Linhas 310 a 613:
310:             .BorderStyle   = 1
311:             .Format        = "K"
312:             .Height        = 25
313:             .Left          = 252
314:             .MaxLength     = 40
315:             .SpecialEffect = 1
316:             .TabIndex      = 2
317:             .Top           = 156
318:             .Width         = 290
319:             .Visible       = .T.
320:         ENDWITH
321:         BINDEVENT(THIS.txt_4c_DsEmpresa, "When", THIS, "WhenDsEmpresa")
322: 
323:         *-- Label Inventario
324:         THIS.AddObject("lbl_4c_Inventario", "Label")
325:         WITH THIS.lbl_4c_Inventario
326:             .AutoSize  = .T.
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .Caption   = "Invent" + CHR(225) + "rio :"
330:             .Left      = 155
331:             .Top       = 185
332:             .ForeColor = RGB(90, 90, 90)
333:             .BackStyle = 0
334:             .Visible   = .T.
335:         ENDWITH
336: 
337:         *-- Shape agrupador de Inventario
338:         THIS.AddObject("shp_4c_Inv", "Shape")
339:         WITH THIS.shp_4c_Inv
340:             .Top           = 185
341:             .Left          = 219
342:             .Height        = 58
343:             .Width         = 243
344:             .BackStyle     = 0
345:             .BorderWidth   = 1
346:             .SpecialEffect = 1
347:             .Visible       = .T.
348:         ENDWITH
349: 
350:         *-- ChkInv1: Proprio (Value=1)
351:         THIS.AddObject("chk_4c_Inv1", "CheckBox")
352:         WITH THIS.chk_4c_Inv1
353:             .AutoSize  = .T.
354:             .FontName  = "Tahoma"
355:             .FontSize  = 8
356:             .Alignment = 0
357:             .BackStyle = 0
358:             .Caption   = "Pr" + CHR(243) + "prio"
359:             .Value     = 1
360:             .Left      = 223
361:             .Top       = 189
362:             .ForeColor = RGB(90, 90, 90)
363:             .TabIndex  = 3
364:             .Visible   = .T.
365:         ENDWITH
366: 
367:         *-- ChkInv2: Produto proprio em poder de terceiros
368:         THIS.AddObject("chk_4c_Inv2", "CheckBox")
369:         WITH THIS.chk_4c_Inv2
370:             .AutoSize  = .T.
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8
373:             .Alignment = 0
374:             .BackStyle = 0
375:             .Caption   = "Produto pr" + CHR(243) + "prio em poder de 3" + CHR(176) + "s"
376:             .Value     = 0
377:             .Left      = 223
378:             .Top       = 206
379:             .ForeColor = RGB(90, 90, 90)
380:             .TabIndex  = 4
381:             .Visible   = .T.
382:         ENDWITH
383: 
384:         *-- ChkInv3: Produto de terceiros em nosso poder
385:         THIS.AddObject("chk_4c_Inv3", "CheckBox")
386:         WITH THIS.chk_4c_Inv3
387:             .AutoSize  = .T.
388:             .FontName  = "Tahoma"
389:             .FontSize  = 8
390:             .Alignment = 0
391:             .BackStyle = 0
392:             .Caption   = "Produto de 3" + CHR(176) + "s em nosso poder"
393:             .Value     = 0
394:             .Left      = 223
395:             .Top       = 223
396:             .ForeColor = RGB(90, 90, 90)
397:             .TabIndex  = 5
398:             .Visible   = .T.
399:         ENDWITH
400: 
401:         *-- Label Saldo
402:         THIS.AddObject("lbl_4c_Saldo", "Label")
403:         WITH THIS.lbl_4c_Saldo
404:             .AutoSize  = .T.
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .Caption   = "Saldo :"
408:             .Left      = 179
409:             .Top       = 243
410:             .ForeColor = RGB(90, 90, 90)
411:             .BackStyle = 0
412:             .Visible   = .T.
413:         ENDWITH
414: 
415:         *-- Shape agrupador de Saldo
416:         THIS.AddObject("shp_4c_Saldo", "Shape")
417:         WITH THIS.shp_4c_Saldo
418:             .Top           = 248
419:             .Left          = 219
420:             .Height        = 42
421:             .Width         = 243
422:             .BackStyle     = 0
423:             .BorderWidth   = 1
424:             .SpecialEffect = 1
425:             .Visible       = .T.
426:         ENDWITH
427: 
428:         *-- ChkSaldo1: Positivo (Value=1, Enabled=.F. - habilitado por tipo de valor)
429:         THIS.AddObject("chk_4c_Saldo1", "CheckBox")
430:         WITH THIS.chk_4c_Saldo1
431:             .AutoSize  = .T.
432:             .FontName  = "Tahoma"
433:             .FontSize  = 8
434:             .Alignment = 0
435:             .BackStyle = 0
436:             .Caption   = "Positivo"
437:             .Value     = 1
438:             .Enabled   = .F.
439:             .Left      = 223
440:             .Top       = 252
441:             .ForeColor = RGB(90, 90, 90)
442:             .TabIndex  = 6
443:             .Visible   = .T.
444:         ENDWITH
445: 
446:         *-- ChkSaldo2: Negativo (Enabled=.F.)
447:         THIS.AddObject("chk_4c_Saldo2", "CheckBox")
448:         WITH THIS.chk_4c_Saldo2
449:             .AutoSize  = .T.
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .Alignment = 0
453:             .BackStyle = 0
454:             .Caption   = "Negativo"
455:             .Value     = 0
456:             .Enabled   = .F.
457:             .Left      = 223
458:             .Top       = 269
459:             .ForeColor = RGB(90, 90, 90)
460:             .TabIndex  = 7
461:             .Visible   = .T.
462:         ENDWITH
463:         BINDEVENT(THIS.chk_4c_Saldo1, "Valid", THIS, "ValidSaldo1")
464:         BINDEVENT(THIS.chk_4c_Saldo2, "Valid", THIS, "ValidSaldo2")
465: 
466:         *-- Label Valor
467:         THIS.AddObject("lbl_4c_Valor", "Label")
468:         WITH THIS.lbl_4c_Valor
469:             .AutoSize  = .T.
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .Caption   = "Valor :"
473:             .Left      = 181
474:             .Top       = 285
475:             .ForeColor = RGB(90, 90, 90)
476:             .BackStyle = 0
477:             .Visible   = .T.
478:         ENDWITH
479: 
480:         *-- Shape agrupador de Valor
481:         THIS.AddObject("shp_4c_Valor", "Shape")
482:         WITH THIS.shp_4c_Valor
483:             .Top           = 295
484:             .Left          = 219
485:             .Height        = 94
486:             .Width         = 243
487:             .BackStyle     = 0
488:             .BorderWidth   = 1
489:             .SpecialEffect = 1
490:             .Visible       = .T.
491:         ENDWITH
492: 
493:         *-- ChkValor1: UEPS
494:         THIS.AddObject("chk_4c_Valor1", "CheckBox")
495:         WITH THIS.chk_4c_Valor1
496:             .AutoSize  = .T.
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .Alignment = 0
500:             .BackStyle = 0
501:             .Caption   = "UEPS"
502:             .Value     = 0
503:             .Left      = 223
504:             .Top       = 301
505:             .ForeColor = RGB(90, 90, 90)
506:             .TabIndex  = 8
507:             .Visible   = .T.
508:         ENDWITH
509:         BINDEVENT(THIS.chk_4c_Valor1, "Valid", THIS, "ValidValor1")
510: 
511:         *-- ChkValor2: PEPS (Value=1 = default)
512:         THIS.AddObject("chk_4c_Valor2", "CheckBox")
513:         WITH THIS.chk_4c_Valor2
514:             .AutoSize  = .T.
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .Alignment = 0
518:             .BackStyle = 0
519:             .Caption   = "PEPS"
520:             .Value     = 1
521:             .Left      = 223
522:             .Top       = 318
523:             .ForeColor = RGB(90, 90, 90)
524:             .TabIndex  = 9
525:             .Visible   = .T.
526:         ENDWITH
527:         BINDEVENT(THIS.chk_4c_Valor2, "Valid", THIS, "ValidValor2")
528: 
529:         *-- ChkValor3: Custo
530:         THIS.AddObject("chk_4c_Valor3", "CheckBox")
531:         WITH THIS.chk_4c_Valor3
532:             .AutoSize  = .T.
533:             .FontName  = "Tahoma"
534:             .FontSize  = 8
535:             .Alignment = 0
536:             .BackStyle = 0
537:             .Caption   = "Custo"
538:             .Value     = 0
539:             .Left      = 223
540:             .Top       = 335
541:             .ForeColor = RGB(90, 90, 90)
542:             .TabIndex  = 10
543:             .Visible   = .T.
544:         ENDWITH
545:         BINDEVENT(THIS.chk_4c_Valor3, "Valid", THIS, "ValidValor3")
546: 
547:         *-- ChkValor4: Custo Medio (visibilidade por acesso)
548:         THIS.AddObject("chk_4c_Valor4", "CheckBox")
549:         WITH THIS.chk_4c_Valor4
550:             .AutoSize  = .T.
551:             .FontName  = "Tahoma"
552:             .FontSize  = 8
553:             .Alignment = 0
554:             .BackStyle = 0
555:             .Caption   = "Custo M" + CHR(233) + "dio"
556:             .Value     = 0
557:             .Left      = 223
558:             .Top       = 352
559:             .ForeColor = RGB(90, 90, 90)
560:             .TabIndex  = 11
561:             .Visible   = .T.
562:         ENDWITH
563:         BINDEVENT(THIS.chk_4c_Valor4, "Valid", THIS, "ValidValor4")
564: 
565:         *-- ChkValor5: Venda (visibilidade por acesso)
566:         THIS.AddObject("chk_4c_Valor5", "CheckBox")
567:         WITH THIS.chk_4c_Valor5
568:             .AutoSize  = .T.
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .Alignment = 0
572:             .BackStyle = 0
573:             .Caption   = "Venda"
574:             .Value     = 0
575:             .Left      = 223
576:             .Top       = 369
577:             .ForeColor = RGB(90, 90, 90)
578:             .TabIndex  = 12
579:             .Visible   = .T.
580:         ENDWITH
581:         BINDEVENT(THIS.chk_4c_Valor5, "Valid", THIS, "ValidValor5")
582: 
583:         *-- Label Fator (Get_MoeFator)
584:         THIS.AddObject("lbl_4c_Fator", "Label")
585:         WITH THIS.lbl_4c_Fator
586:             .AutoSize  = .T.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .Caption   = "Fator :"
590:             .Left      = 179
591:             .Top       = 396
592:             .ForeColor = RGB(90, 90, 90)
593:             .BackStyle = 0
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         *-- Moeda Fator (Get_MoeFator) - codigo de moeda para fator manual
598:         THIS.AddObject("txt_4c_MoeFator", "TextBox")
599:         WITH THIS.txt_4c_MoeFator
600:             .FontName      = "Tahoma"
601:             .BorderStyle   = 1
602:             .Format        = "K!"
603:             .Height        = 25
604:             .Left          = 219
605:             .MaxLength     = 3
606:             .SpecialEffect = 1
607:             .TabIndex      = 13
608:             .Top           = 392
609:             .Width         = 37
610:             .ForeColor     = RGB(0, 0, 0)
611:             .Visible       = .T.
612:         ENDWITH
613:         BINDEVENT(THIS.txt_4c_MoeFator, "KeyPress", THIS, "TeclaMoeFator")

*-- Linhas 622 a 651:
622:             .Value                = 0
623:             .Height               = 25
624:             .InputMask            = "999999.999"
625:             .Left                 = 258
626:             .MaxLength            = 10
627:             .SpecialEffect        = 1
628:             .TabIndex             = 14
629:             .Top                  = 392
630:             .Width                = 95
631:             .ForeColor            = RGB(0, 0, 0)
632:             .DisabledBackColor    = RGB(192, 192, 192)
633:             .DisabledForeColor    = RGB(192, 192, 192)
634:             .Enabled              = .F.
635:             .Visible              = .T.
636:         ENDWITH
637: 
638:         *-- Label Moeda de Conversao
639:         THIS.AddObject("lbl_4c_Moeda", "Label")
640:         WITH THIS.lbl_4c_Moeda
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .Caption   = "Moeda de Convers" + CHR(227) + "o :"
644:             .Height    = 15
645:             .Left      = 103
646:             .Top       = 424
647:             .Width     = 111
648:             .ForeColor = RGB(90, 90, 90)
649:             .BackStyle = 0
650:             .Visible   = .T.
651:         ENDWITH

*-- Linhas 660 a 673:
660:             .BorderStyle   = 1
661:             .Format        = "!"
662:             .Height        = 25
663:             .Left          = 219
664:             .MaxLength     = 3
665:             .SpecialEffect = 1
666:             .TabIndex      = 15
667:             .ToolTipText   = "Converte os valores para esta moeda. Este par" + CHR(226) + "metro tem prioridade sobre o fator."
668:             .Top           = 419
669:             .Width         = 37
670:             .ForeColor     = RGB(0, 0, 0)
671:             .BackColor     = RGB(255, 255, 255)
672:             .Visible       = .T.
673:         ENDWITH

*-- Linhas 684 a 774:
684:             .BorderStyle   = 1
685:             .Format        = "!"
686:             .Height        = 25
687:             .Left          = 258
688:             .MaxLength     = 15
689:             .SpecialEffect = 1
690:             .TabIndex      = 16
691:             .Top           = 419
692:             .Width         = 95
693:             .ForeColor     = RGB(0, 0, 0)
694:             .BackColor     = RGB(255, 255, 255)
695:             .Visible       = .T.
696:         ENDWITH
697:         BINDEVENT(THIS.txt_4c_MoedaDesc, "When", THIS, "WhenMoedaDesc")
698:         BINDEVENT(THIS.txt_4c_MoedaDesc, "KeyPress", THIS, "TeclaMoedaDesc")
699:         BINDEVENT(THIS.txt_4c_MoedaDesc, "DblClick", THIS, "MoedaDescDblClick")
700: 
701:         *-- Label Retira ICMS
702:         THIS.AddObject("lbl_4c_ICMS", "Label")
703:         WITH THIS.lbl_4c_ICMS
704:             .AutoSize  = .T.
705:             .FontName  = "Tahoma"
706:             .FontSize  = 8
707:             .BackStyle = 0
708:             .Caption   = "Retira ICMS :"
709:             .Height    = 15
710:             .Left      = 148
711:             .Top       = 452
712:             .ForeColor = RGB(90, 90, 90)
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         *-- OptionGroup ICMS (Opt_ICMS): Value=2=Nao por default
717:         THIS.AddObject("opt_4c_ICMS", "OptionGroup")
718:         WITH THIS.opt_4c_ICMS
719:             .ButtonCount   = 2
720:             .BackStyle     = 0
721:             .BorderStyle   = 0
722:             .Value         = 2
723:             .Height        = 25
724:             .Left          = 216
725:             .SpecialEffect = 0
726:             .Top           = 448
727:             .Width         = 133
728:             .TabIndex      = 17
729:             .Visible       = .T.
730: 
731:             WITH .Buttons(1)
732:                 .BackStyle = 0
733:                 .Caption   = "Sim"
734:                 .Value     = 0
735:                 .Height    = 15
736:                 .Left      = 4
737:                 .Top       = 4
738:                 .Width     = 34
739:                 .AutoSize  = .T.
740:                 .ForeColor = RGB(90, 90, 90)
741:                 .Themes    = .F.
742:             ENDWITH
743: 
744:             WITH .Buttons(2)
745:                 .FontName  = "Tahoma"
746:                 .FontSize  = 8
747:                 .BackStyle = 0
748:                 .Caption   = "N" + CHR(227) + "o"
749:                 .Value     = 1
750:                 .Height    = 15
751:                 .Left      = 56
752:                 .Top       = 4
753:                 .Width     = 37
754:                 .AutoSize  = .T.
755:                 .ForeColor = RGB(90, 90, 90)
756:                 .Themes    = .F.
757:             ENDWITH
758:         ENDWITH
759:         BINDEVENT(THIS.opt_4c_ICMS, "InteractiveChange", THIS, "IcmsInteractiveChange")
760: 
761:         *-- Label Posicao
762:         THIS.AddObject("lbl_4c_Posicao", "Label")
763:         WITH THIS.lbl_4c_Posicao
764:             .AutoSize  = .T.
765:             .FontName  = "Tahoma"
766:             .FontSize  = 8
767:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o :"
768:             .Left      = 169
769:             .Top       = 476
770:             .ForeColor = RGB(90, 90, 90)
771:             .BackStyle = 0
772:             .Visible   = .T.
773:         ENDWITH
774: 

*-- Linhas 780 a 813:
780:             .BackStyle     = 0
781:             .BorderStyle   = 0
782:             .Height        = 25
783:             .Left          = 216
784:             .SpecialEffect = 0
785:             .Top           = 472
786:             .Width         = 138
787:             .TabIndex      = 18
788:             .Value         = 1
789:             .Visible       = .T.
790: 
791:             WITH .Buttons(1)
792:                 .BackStyle = 0
793:                 .Caption   = "Atual"
794:                 .Left      = 5
795:                 .Top       = 5
796:                 .Width     = 43
797:                 .AutoSize  = .T.
798:                 .ForeColor = RGB(90, 90, 90)
799:                 .Themes    = .F.
800:             ENDWITH
801: 
802:             WITH .Buttons(2)
803:                 .FontName  = "Tahoma"
804:                 .FontSize  = 8
805:                 .BackStyle = 0
806:                 .Caption   = "Retroativa :"
807:                 .Left      = 57
808:                 .Top       = 5
809:                 .AutoSize  = .T.
810:                 .ForeColor = RGB(90, 90, 90)
811:                 .Themes    = .F.
812:             ENDWITH
813:         ENDWITH

*-- Linhas 819 a 831:
819:             .FontName      = "Tahoma"
820:             .BorderStyle   = 1
821:             .Height        = 23
822:             .Left          = 360
823:             .MaxLength     = 10
824:             .SpecialEffect = 1
825:             .TabIndex      = 19
826:             .Top           = 474
827:             .Width         = 79
828:             .Enabled       = .F.
829:             .Visible       = .T.
830:         ENDWITH
831:     ENDPROC

