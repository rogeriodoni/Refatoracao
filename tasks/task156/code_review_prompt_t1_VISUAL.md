# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 232: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 976: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2728 linhas total):

*-- Linhas 108 a 121:
108:                     ENDIF
109: 
110:                     THIS.ConfigurarPageFrame()
111:                     THIS.Caption = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
112:                     THIS.ConfigurarPaginaLista()
113:                     THIS.ConfigurarPaginaDados()
114: 
115:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
116:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
117: 
118:                     THIS.TornarControlesVisiveis(THIS)
119: 
120:                     *-- Visibilidade inicial por tipo (Tipo 1 = Variacao)
121:                     THIS.AtualizarVisibilidade(1)

*-- Linhas 139 a 184:
139: 
140:         THIS.AddObject("cnt_4c_Sombra", "Container")
141:         WITH THIS.cnt_4c_Sombra
142:             .Top         = 0
143:             .Left        = 0
144:             .Width       = THIS.Width
145:             .Height      = 80
146:             .BackColor   = RGB(100, 100, 100)
147:             .BackStyle   = 1
148:             .BorderWidth = 0
149: 
150:             .AddObject("lbl_4c_Sombra", "Label")
151:             WITH .lbl_4c_Sombra
152:                 .Top       = 18
153:                 .Left      = 10
154:                 .Width     = THIS.Width
155:                 .Height    = 40
156:                 .AutoSize  = .F.
157:                 .FontBold  = .T.
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 18
160:                 .BackStyle = 0
161:                 .ForeColor = RGB(0, 0, 0)
162:                 .WordWrap  = .T.
163:                 .Caption   = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
164:             ENDWITH
165: 
166:             .AddObject("lbl_4c_Titulo", "Label")
167:             WITH .lbl_4c_Titulo
168:                 .Top       = 17
169:                 .Left      = 10
170:                 .Width     = THIS.Width
171:                 .Height    = 46
172:                 .AutoSize  = .F.
173:                 .FontBold  = .T.
174:                 .FontName  = "Tahoma"
175:                 .FontSize  = 18
176:                 .BackStyle = 0
177:                 .ForeColor = RGB(255, 255, 255)
178:                 .WordWrap  = .T.
179:                 .Caption   = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
180:             ENDWITH
181:         ENDWITH
182:     ENDPROC
183: 
184:     *==========================================================================

*-- Linhas 191 a 215:
191:         *----------------------------------------------------------------------
192:         THIS.AddObject("cmg_4c_Acao", "CommandGroup")
193:         WITH THIS.cmg_4c_Acao
194:             .Top           = 0
195:             .Left          = 770
196:             .Width         = 225
197:             .Height        = 85
198:             .BackStyle     = 0
199:             .BorderStyle   = 0
200:             .SpecialEffect = 1
201:             .ButtonCount   = 3
202:             .Themes        = .F.
203:             .AutoSize      = .F.
204: 
205:             WITH .Buttons(1)
206:                 .Top             = 5
207:                 .Left            = 5
208:                 .Width           = 75
209:                 .Height          = 75
210:                 .Caption         = "Processar"
211:                 .FontBold        = .T.
212:                 .FontItalic      = .T.
213:                 .ForeColor       = RGB(90, 90, 90)
214:                 .BackColor       = RGB(255, 255, 255)
215:                 .Themes          = .F.

*-- Linhas 222 a 238:
222:             ENDWITH
223: 
224:             WITH .Buttons(2)
225:                 .Top             = 5
226:                 .Left            = 80
227:                 .Width           = 75
228:                 .Height          = 75
229:                 .Caption         = "Atualizar"
230:                 .FontBold        = .T.
231:                 .FontItalic      = .T.
232:                 .FontName        = "Comic Sans MS"
233:                 .FontSize        = 8
234:                 .ForeColor       = RGB(90, 90, 90)
235:                 .BackColor       = RGB(255, 255, 255)
236:                 .Themes          = .F.
237:                 .SpecialEffect   = 0
238:                 .PicturePosition = 13

*-- Linhas 244 a 260:
244:             ENDWITH
245: 
246:             WITH .Buttons(3)
247:                 .Top             = 5
248:                 .Left            = 155
249:                 .Width           = 75
250:                 .Height          = 75
251:                 .Caption         = "Encerrar"
252:                 .FontBold        = .T.
253:                 .FontItalic      = .T.
254:                 .FontName        = "Comic Sans MS"
255:                 .FontSize        = 8
256:                 .ForeColor       = RGB(90, 90, 90)
257:                 .BackColor       = RGB(255, 255, 255)
258:                 .Themes          = .F.
259:                 .SpecialEffect   = 0
260:                 .PicturePosition = 13

*-- Linhas 274 a 351:
274:         *----------------------------------------------------------------------
275:         THIS.AddObject("opt_4c_Tipo", "OptionGroup")
276:         WITH THIS.opt_4c_Tipo
277:             .Top           = 134
278:             .Left          = 159
279:             .Width         = 208
280:             .Height        = 24
281:             .BackStyle     = 0
282:             .BorderStyle   = 0
283:             .AutoSize      = .F.
284:             .ButtonCount   = 3
285:             .Value         = 1
286: 
287:             WITH .Buttons(1)
288:                 .Left      = 5
289:                 .Top       = 5
290:                 .Width     = 59
291:                 .Height    = 15
292:                 .Caption   = "Varia" + CHR(231) + CHR(227) + "o"
293:                 .BackStyle = 0
294:                 .AutoSize  = .T.
295:                 .ForeColor = RGB(90, 90, 90)
296:             ENDWITH
297: 
298:             WITH .Buttons(2)
299:                 .Left      = 74
300:                 .Top       = 5
301:                 .Height    = 15
302:                 .Caption   = "MarkUp"
303:                 .BackStyle = 0
304:                 .AutoSize  = .T.
305:                 .ForeColor = RGB(90, 90, 90)
306:                 .FontName  = "Tahoma"
307:                 .FontSize  = 8
308:             ENDWITH
309: 
310:             WITH .Buttons(3)
311:                 .Left      = 139
312:                 .Top       = 5
313:                 .Width     = 53
314:                 .Height    = 15
315:                 .Caption   = "C" + CHR(226) + "mbio"
316:                 .BackStyle = 0
317:                 .AutoSize  = .T.
318:                 .ForeColor = RGB(90, 90, 90)
319:                 .FontName  = "Tahoma"
320:                 .FontSize  = 8
321:             ENDWITH
322:         ENDWITH
323:         BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
324: 
325:         *----------------------------------------------------------------------
326:         * Label: "Grupo de Produto :"
327:         *----------------------------------------------------------------------
328:         THIS.AddObject("lbl_4c_Grupo", "Label")
329:         WITH THIS.lbl_4c_Grupo
330:             .Top       = 113
331:             .Left      = 69
332:             .Width     = 94
333:             .Height    = 15
334:             .AutoSize  = .T.
335:             .Caption   = "Grupo de Produto :"
336:             .FontName  = "Tahoma"
337:             .FontSize  = 8
338:             .BackStyle = 0
339:             .ForeColor = RGB(90, 90, 90)
340:         ENDWITH
341: 
342:         *-- TextBox: Grupo de (codigo)
343:         THIS.AddObject("txt_4c_CdGrupo", "TextBox")
344:         WITH THIS.txt_4c_CdGrupo
345:             .Top           = 109
346:             .Left          = 165
347:             .Width         = 31
348:             .Height        = 23
349:             .MaxLength     = 3
350:             .Format        = "K!"
351:             .SpecialEffect = 1

*-- Linhas 359 a 385:
359:         BINDEVENT(THIS.txt_4c_CdGrupo, "KeyPress", THIS, "TeclaLookupCdGrupo")
360: 
361:         *-- Label: "at" + CHR(233)
362:         THIS.AddObject("lbl_4c_Ate", "Label")
363:         WITH THIS.lbl_4c_Ate
364:             .Top       = 113
365:             .Left      = 203
366:             .Width     = 18
367:             .Height    = 15
368:             .AutoSize  = .T.
369:             .Caption   = "at" + CHR(233)
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:             .BackStyle = 0
373:             .ForeColor = RGB(90, 90, 90)
374:         ENDWITH
375: 
376:         *-- TextBox: Grupo ate (codigo)
377:         THIS.AddObject("txt_4c_AteGrupo", "TextBox")
378:         WITH THIS.txt_4c_AteGrupo
379:             .Top           = 109
380:             .Left          = 228
381:             .Width         = 31
382:             .Height        = 23
383:             .MaxLength     = 3
384:             .Format        = "K!"
385:             .SpecialEffect = 1

*-- Linhas 392 a 437:
392:         BINDEVENT(THIS.txt_4c_AteGrupo, "DblClick", THIS, "AbrirBuscaAteGrupo")
393:         BINDEVENT(THIS.txt_4c_AteGrupo, "KeyPress", THIS, "TeclaLookupAteGrupo")
394: 
395:         *-- Label: "Ignorar Componentes" (CheckBox)
396:         THIS.AddObject("chk_4c_Ignorar", "CheckBox")
397:         WITH THIS.chk_4c_Ignorar
398:             .Top       = 112
399:             .Left      = 609
400:             .Width     = 123
401:             .Height    = 15
402:             .AutoSize  = .T.
403:             .Caption   = "Ignorar Componentes"
404:             .BackStyle = 0
405:             .Value     = 0
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .ForeColor = RGB(90, 90, 90)
409:             .ToolTipText = "N" + CHR(227) + "o Checa Se o Produto Est" + CHR(225) + ;
410:                            " em Uso Como Componente de Outros Produtos"
411:         ENDWITH
412: 
413:         *-- Label: "Grupo de Venda :" (Colecao)
414:         THIS.AddObject("lbl_4c_GrupoVd", "Label")
415:         WITH THIS.lbl_4c_GrupoVd
416:             .Top       = 113
417:             .Left      = 399
418:             .Width     = 86
419:             .Height    = 15
420:             .AutoSize  = .T.
421:             .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
422:             .FontName  = "Tahoma"
423:             .FontSize  = 8
424:             .BackStyle = 0
425:             .ForeColor = RGB(90, 90, 90)
426:         ENDWITH
427: 
428:         *-- TextBox: Colecao
429:         THIS.AddObject("txt_4c_Col", "TextBox")
430:         WITH THIS.txt_4c_Col
431:             .Top           = 109
432:             .Left          = 487
433:             .Width         = 94
434:             .Height        = 23
435:             .MaxLength     = 10
436:             .Format        = "K"
437:             .SpecialEffect = 1

*-- Linhas 446 a 487:
446:         *----------------------------------------------------------------------
447:         * Label: "Reajuste por :"
448:         *----------------------------------------------------------------------
449:         THIS.AddObject("lbl_4c_TipoLabel", "Label")
450:         WITH THIS.lbl_4c_TipoLabel
451:             .Top       = 139
452:             .Left      = 92
453:             .Width     = 71
454:             .Height    = 15
455:             .AutoSize  = .T.
456:             .Caption   = "Reajuste por :"
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .BackStyle = 0
460:             .ForeColor = RGB(90, 90, 90)
461:         ENDWITH
462: 
463:         *-- Label: "Variacao de Preco :" (Tipo 1)
464:         THIS.AddObject("lbl_4c_Variacao", "Label")
465:         WITH THIS.lbl_4c_Variacao
466:             .Top       = 139
467:             .Left      = 390
468:             .Width     = 95
469:             .Height    = 15
470:             .AutoSize  = .T.
471:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .BackStyle = 0
475:             .ForeColor = RGB(90, 90, 90)
476:         ENDWITH
477: 
478:         *-- TextBox: Variacao (Tipo 1)
479:         THIS.AddObject("txt_4c_Variacao", "TextBox")
480:         WITH THIS.txt_4c_Variacao
481:             .Top           = 135
482:             .Left          = 487
483:             .Width         = 94
484:             .Height        = 23
485:             .Alignment     = 3
486:             .Format        = "K99,999.99"
487:             .InputMask     = "99,999.99"

*-- Linhas 497 a 554:
497:         BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "TxtVariacaoLostFocus")
498: 
499:         *-- Label: "%" (Tipo 1)
500:         THIS.AddObject("lbl_4c_Pct", "Label")
501:         WITH THIS.lbl_4c_Pct
502:             .Top       = 139
503:             .Left      = 585
504:             .Width     = 13
505:             .Height    = 15
506:             .AutoSize  = .T.
507:             .Caption   = "%"
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .BackStyle = 0
511:             .ForeColor = RGB(90, 90, 90)
512:         ENDWITH
513: 
514:         *-- CheckBox: "Incluir Custos" (Tipo 1)
515:         THIS.AddObject("chk_4c_IncCusts", "CheckBox")
516:         WITH THIS.chk_4c_IncCusts
517:             .Top       = 139
518:             .Left      = 609
519:             .Width     = 83
520:             .Height    = 15
521:             .AutoSize  = .T.
522:             .Caption   = "Incluir Custos"
523:             .BackStyle = 0
524:             .Value     = 0
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .ForeColor = RGB(90, 90, 90)
528:         ENDWITH
529: 
530:         *-- Label: "Moeda :" (Tipo 2)
531:         THIS.AddObject("lbl_4c_Moeda", "Label")
532:         WITH THIS.lbl_4c_Moeda
533:             .Top       = 139
534:             .Left      = 444
535:             .Width     = 41
536:             .Height    = 15
537:             .AutoSize  = .T.
538:             .Caption   = "Moeda :"
539:             .FontName  = "Tahoma"
540:             .FontSize  = 8
541:             .BackStyle = 0
542:             .ForeColor = RGB(90, 90, 90)
543:         ENDWITH
544: 
545:         *-- TextBox: Moeda (Tipo 2)
546:         THIS.AddObject("txt_4c_Moeda", "TextBox")
547:         WITH THIS.txt_4c_Moeda
548:             .Top           = 135
549:             .Left          = 487
550:             .Width         = 31
551:             .Height        = 23
552:             .MaxLength     = 3
553:             .Format        = "K!"
554:             .SpecialEffect = 1

*-- Linhas 565 a 591:
565:         *----------------------------------------------------------------------
566: 
567:         *-- Label: "Fator de Custo:" (Tipo 2)
568:         THIS.AddObject("lbl_4c_Fator", "Label")
569:         WITH THIS.lbl_4c_Fator
570:             .Top       = 165
571:             .Left      = 85
572:             .Width     = 78
573:             .Height    = 15
574:             .AutoSize  = .T.
575:             .Caption   = "Fator de Custo:"
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .BackStyle = 0
579:             .ForeColor = RGB(90, 90, 90)
580:         ENDWITH
581: 
582:         *-- TextBox: Fator (Tipo 2)
583:         THIS.AddObject("txt_4c_Fator", "TextBox")
584:         WITH THIS.txt_4c_Fator
585:             .Top           = 161
586:             .Left          = 165
587:             .Width         = 73
588:             .Height        = 23
589:             .Alignment     = 3
590:             .InputMask     = "9999.999"
591:             .MaxLength     = 8

*-- Linhas 600 a 609:
600:         *-- TextBox: Moeda Custo (Tipo 2)
601:         THIS.AddObject("txt_4c_MoeCusto", "TextBox")
602:         WITH THIS.txt_4c_MoeCusto
603:             .Top           = 161
604:             .Left          = 241
605:             .Width         = 31
606:             .Height        = 23
607:             .MaxLength     = 3
608:             .Format        = "K!"
609:             .SpecialEffect = 1

*-- Linhas 615 a 641:
615:         BINDEVENT(THIS.txt_4c_MoeCusto, "KeyPress", THIS, "TeclaLookupMoeCusto")
616: 
617:         *-- Label: "MarkUp :" (Tipo 2)
618:         THIS.AddObject("lbl_4c_MarkUp", "Label")
619:         WITH THIS.lbl_4c_MarkUp
620:             .Top       = 165
621:             .Left      = 440
622:             .Width     = 45
623:             .Height    = 15
624:             .AutoSize  = .T.
625:             .Caption   = "MarkUp :"
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .BackStyle = 0
629:             .ForeColor = RGB(90, 90, 90)
630:         ENDWITH
631: 
632:         *-- TextBox: MarkUp1 (Tipo 2)
633:         THIS.AddObject("txt_4c_MarkUp1", "TextBox")
634:         WITH THIS.txt_4c_MarkUp1
635:             .Top           = 161
636:             .Left          = 487
637:             .Width         = 52
638:             .Height        = 23
639:             .Alignment     = 3
640:             .InputMask     = "999.99"
641:             .MaxLength     = 6

*-- Linhas 648 a 674:
648:         ENDWITH
649: 
650:         *-- Label: "para" (Tipo 2)
651:         THIS.AddObject("lbl_4c_Para", "Label")
652:         WITH THIS.lbl_4c_Para
653:             .Top       = 165
654:             .Left      = 547
655:             .Width     = 24
656:             .Height    = 15
657:             .AutoSize  = .T.
658:             .Caption   = "para"
659:             .FontName  = "Tahoma"
660:             .FontSize  = 8
661:             .BackStyle = 0
662:             .ForeColor = RGB(90, 90, 90)
663:         ENDWITH
664: 
665:         *-- TextBox: MarkUp2 (Tipo 2)
666:         THIS.AddObject("txt_4c_MarkUp2", "TextBox")
667:         WITH THIS.txt_4c_MarkUp2
668:             .Top           = 161
669:             .Left          = 580
670:             .Width         = 52
671:             .Height        = 23
672:             .Alignment     = 3
673:             .InputMask     = "999.99"
674:             .MaxLength     = 6

*-- Linhas 685 a 711:
685:         *----------------------------------------------------------------------
686: 
687:         *-- Label: "Promo" + CHR(231) + CHR(227) + "o :"
688:         THIS.AddObject("lbl_4c_Promo", "Label")
689:         WITH THIS.lbl_4c_Promo
690:             .Top       = 191
691:             .Left      = 107
692:             .Width     = 56
693:             .Height    = 15
694:             .AutoSize  = .T.
695:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
696:             .FontName  = "Tahoma"
697:             .FontSize  = 8
698:             .BackStyle = 0
699:             .ForeColor = RGB(90, 90, 90)
700:         ENDWITH
701: 
702:         *-- TextBox: Promo
703:         THIS.AddObject("txt_4c_Promo", "TextBox")
704:         WITH THIS.txt_4c_Promo
705:             .Top           = 187
706:             .Left          = 165
707:             .Width         = 185
708:             .Height        = 23
709:             .MaxLength     = 25
710:             .Format        = "K!"
711:             .SpecialEffect = 1

*-- Linhas 718 a 765:
718:         BINDEVENT(THIS.txt_4c_Promo, "DblClick", THIS, "AbrirBuscaPromo")
719:         BINDEVENT(THIS.txt_4c_Promo, "KeyPress", THIS, "TeclaLookupPromo")
720: 
721:         *-- CheckBox: "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
722:         THIS.AddObject("chk_4c_Limpar", "CheckBox")
723:         WITH THIS.chk_4c_Limpar
724:             .Top       = 191
725:             .Left      = 362
726:             .Width     = 157
727:             .Height    = 15
728:             .AutoSize  = .T.
729:             .Caption   = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
730:             .BackStyle = 0
731:             .Value     = 0
732:             .FontName  = "Tahoma"
733:             .FontSize  = 8
734:             .ForeColor = RGB(90, 90, 90)
735:         ENDWITH
736: 
737:         *----------------------------------------------------------------------
738:         * Row 4: Fornecedor
739:         *----------------------------------------------------------------------
740: 
741:         *-- Label: "Fornecedor :"
742:         THIS.AddObject("lbl_4c_Forne", "Label")
743:         WITH THIS.lbl_4c_Forne
744:             .Top       = 216
745:             .Left      = 99
746:             .Width     = 64
747:             .Height    = 15
748:             .AutoSize  = .T.
749:             .Caption   = "Fornecedor :"
750:             .FontName  = "Tahoma"
751:             .FontSize  = 8
752:             .BackStyle = 0
753:             .ForeColor = RGB(90, 90, 90)
754:         ENDWITH
755: 
756:         *-- TextBox: Conta (codigo fornecedor)
757:         THIS.AddObject("txt_4c_Conta", "TextBox")
758:         WITH THIS.txt_4c_Conta
759:             .Top           = 213
760:             .Left          = 165
761:             .Width         = 80
762:             .Height        = 23
763:             .SpecialEffect = 1
764:             .FontName      = "Tahoma"
765:             .FontSize      = 8

*-- Linhas 772 a 781:
772:         *-- TextBox: DConta (descricao fornecedor)
773:         THIS.AddObject("txt_4c_DConta", "TextBox")
774:         WITH THIS.txt_4c_DConta
775:             .Top           = 213
776:             .Left          = 248
777:             .Width         = 290
778:             .Height        = 23
779:             .MaxLength     = 50
780:             .SpecialEffect = 1
781:             .FontName      = "Tahoma"

*-- Linhas 791 a 817:
791:         *----------------------------------------------------------------------
792: 
793:         *-- Label: "Moeda Custo Compo. :" (Tipo 2)
794:         THIS.AddObject("lbl_4c_Moecs", "Label")
795:         WITH THIS.lbl_4c_Moecs
796:             .Top       = 244
797:             .Left      = 51
798:             .Width     = 112
799:             .Height    = 15
800:             .AutoSize  = .T.
801:             .Caption   = "Moeda Custo Compo. :"
802:             .FontName  = "Tahoma"
803:             .FontSize  = 8
804:             .BackStyle = 0
805:             .ForeColor = RGB(90, 90, 90)
806:         ENDWITH
807: 
808:         *-- TextBox: Moecs (Tipo 2)
809:         THIS.AddObject("txt_4c_Moecs", "TextBox")
810:         WITH THIS.txt_4c_Moecs
811:             .Top           = 240
812:             .Left          = 165
813:             .Width         = 31
814:             .Height        = 23
815:             .MaxLength     = 3
816:             .Format        = "K!"
817:             .SpecialEffect = 1

*-- Linhas 824 a 850:
824:         BINDEVENT(THIS.txt_4c_Moecs, "KeyPress", THIS, "TeclaLookupMoecs")
825: 
826:         *-- Label: "Moeda Pre" + CHR(231) + "o Ideal :" (Tipo 2)
827:         THIS.AddObject("lbl_4c_Moedas", "Label")
828:         WITH THIS.lbl_4c_Moedas
829:             .Top       = 244
830:             .Left      = 320
831:             .Width     = 98
832:             .Height    = 15
833:             .AutoSize  = .T.
834:             .Caption   = "Moeda Pre" + CHR(231) + "o Ideal :"
835:             .FontName  = "Tahoma"
836:             .FontSize  = 8
837:             .BackStyle = 0
838:             .ForeColor = RGB(90, 90, 90)
839:         ENDWITH
840: 
841:         *-- TextBox: Moedas (Tipo 2)
842:         THIS.AddObject("txt_4c_Moedas", "TextBox")
843:         WITH THIS.txt_4c_Moedas
844:             .Top           = 240
845:             .Left          = 420
846:             .Width         = 31
847:             .Height        = 23
848:             .MaxLength     = 3
849:             .Format        = "K!"
850:             .SpecialEffect = 1

*-- Linhas 857 a 883:
857:         BINDEVENT(THIS.txt_4c_Moedas, "KeyPress", THIS, "TeclaLookupMoedas")
858: 
859:         *-- Label: "Feitio :" (Tipo 2)
860:         THIS.AddObject("lbl_4c_CFtios", "Label")
861:         WITH THIS.lbl_4c_CFtios
862:             .Top       = 244
863:             .Left      = 531
864:             .Width     = 35
865:             .Height    = 15
866:             .AutoSize  = .T.
867:             .Caption   = "Feitio :"
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8
870:             .BackStyle = 0
871:             .ForeColor = RGB(90, 90, 90)
872:         ENDWITH
873: 
874:         *-- TextBox: CFtios (Tipo 2)
875:         THIS.AddObject("txt_4c_CFtios", "TextBox")
876:         WITH THIS.txt_4c_CFtios
877:             .Top           = 240
878:             .Left          = 568
879:             .Width         = 31
880:             .Height        = 23
881:             .MaxLength     = 3
882:             .Format        = "K!"
883:             .SpecialEffect = 1

*-- Linhas 894 a 920:
894:         *----------------------------------------------------------------------
895: 
896:         *-- Label: "Moeda Custo Total :" (Tipo 2)
897:         THIS.AddObject("lbl_4c_MoeCusFs", "Label")
898:         WITH THIS.lbl_4c_MoeCusFs
899:             .Top       = 270
900:             .Left      = 64
901:             .Width     = 99
902:             .Height    = 15
903:             .AutoSize  = .T.
904:             .Caption   = "Moeda Custo Total :"
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .BackStyle = 0
908:             .ForeColor = RGB(90, 90, 90)
909:         ENDWITH
910: 
911:         *-- TextBox: MoeCusFs (Tipo 2)
912:         THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
913:         WITH THIS.txt_4c_MoeCusFs
914:             .Top           = 266
915:             .Left          = 165
916:             .Width         = 31
917:             .Height        = 23
918:             .MaxLength     = 3
919:             .Format        = "K!"
920:             .SpecialEffect = 1

*-- Linhas 927 a 953:
927:         BINDEVENT(THIS.txt_4c_MoeCusFs, "KeyPress", THIS, "TeclaLookupMoeCusFs")
928: 
929:         *-- Label: "Moeda Pre" + CHR(231) + "o Atual :" (Tipo 2)
930:         THIS.AddObject("lbl_4c_MoeVs", "Label")
931:         WITH THIS.lbl_4c_MoeVs
932:             .Top       = 270
933:             .Left      = 319
934:             .Width     = 99
935:             .Height    = 15
936:             .AutoSize  = .T.
937:             .Caption   = "Moeda Pre" + CHR(231) + "o Atual :"
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .BackStyle = 0
941:             .ForeColor = RGB(90, 90, 90)
942:         ENDWITH
943: 
944:         *-- TextBox: MoeVs (Tipo 2)
945:         THIS.AddObject("txt_4c_MoeVs", "TextBox")
946:         WITH THIS.txt_4c_MoeVs
947:             .Top           = 266
948:             .Left          = 420
949:             .Width         = 31
950:             .Height        = 23
951:             .MaxLength     = 3
952:             .Format        = "K!"
953:             .SpecialEffect = 1

*-- Linhas 960 a 1018:
960:         BINDEVENT(THIS.txt_4c_MoeVs, "KeyPress", THIS, "TeclaLookupMoeVs")
961: 
962:         *----------------------------------------------------------------------
963:         * CheckBox: Modo manual "Produtos" (chkAuditado)
964:         *----------------------------------------------------------------------
965:         THIS.AddObject("chk_4c_Auditado", "CheckBox")
966:         WITH THIS.chk_4c_Auditado
967:             .Top           = 307
968:             .Left          = 763
969:             .Width         = 75
970:             .Height        = 75
971:             .Style         = 1
972:             .Caption       = "Produtos"
973:             .Value         = 0
974:             .FontBold      = .T.
975:             .FontItalic    = .T.
976:             .FontName      = "Comic Sans MS"
977:             .FontSize      = 8
978:             .ForeColor     = RGB(90, 90, 90)
979:             .BackColor     = RGB(255, 255, 255)
980:             .Themes        = .F.
981:             .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
982:         ENDWITH
983:         BINDEVENT(THIS.chk_4c_Auditado, "Click", THIS, "ChkAuditadoClick")
984: 
985:         *----------------------------------------------------------------------
986:         * Grid de produtos
987:         *----------------------------------------------------------------------
988:         THIS.AddObject("grd_4c_Produtos", "Grid")
989:         WITH THIS.grd_4c_Produtos
990:             .Top          = 307
991:             .Left         = 31
992:             .Width        = 725
993:             .Height       = 247
994:             .FontName     = "Verdana"
995:             .FontSize     = 8
996:             .HeaderHeight = 20
997:             .RowHeight    = 16
998:             .ScrollBars   = 2
999:             .DeleteMark   = .F.
1000:             .RecordMark   = .F.
1001:             .GridLines    = 3
1002:             .ColumnCount  = 5
1003: 
1004:             *-- Column1: CheckBox de selecao (lMarca)
1005:             WITH .Column1
1006:                 .Width         = 20
1007:                 .Alignment     = 3
1008:                 .Movable       = .F.
1009:                 .Resizable     = .F.
1010:                 .Sparse        = .F.
1011:                 .FontName      = "Verdana"
1012:                 .FontSize      = 8
1013:                 .Header1.Caption   = ""
1014:                 .Header1.Picture   = gc_4c_CaminhoIcones + "checkbx.bmp"
1015:                 .Header1.Alignment = 2
1016:                 .Header1.FontName  = "Verdana"
1017:                 .Header1.FontSize  = 8
1018:             ENDWITH

*-- Linhas 1024 a 1045:
1024:                 .Resizable         = .F.
1025:                 .FontName          = "Verdana"
1026:                 .FontSize          = 8
1027:                 .Header1.Caption   = "Produto"
1028:                 .Header1.Alignment = 2
1029:                 .Header1.FontName  = "Verdana"
1030:                 .Header1.FontSize  = 8
1031:             ENDWITH
1032: 
1033:             *-- Column3: Descricao (DPros)
1034:             WITH .Column3
1035:                 .Width             = 350
1036:                 .Movable           = .F.
1037:                 .Resizable         = .F.
1038:                 .FontName          = "Verdana"
1039:                 .FontSize          = 8
1040:                 .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1041:                 .Header1.Alignment = 2
1042:                 .Header1.FontName  = "Verdana"
1043:                 .Header1.FontSize  = 8
1044:             ENDWITH
1045: 

*-- Linhas 1052 a 1060:
1052:                 .InputMask         = "999,999,999.99"
1053:                 .FontName          = "Verdana"
1054:                 .FontSize          = 8
1055:                 .Header1.Caption   = "Pre" + CHR(231) + "o Anterior"
1056:                 .Header1.Alignment = 2
1057:                 .Header1.FontName  = "Verdana"
1058:                 .Header1.FontSize  = 8
1059:             ENDWITH
1060: 

*-- Linhas 1073 a 1083:
1073:             ENDWITH
1074:         ENDWITH
1075: 
1076:         *-- CheckBox em Column1 DEVE ser adicionado ANTES do ControlSource (regra Error 1767)
1077:         THIS.grd_4c_Produtos.Column1.AddObject("Check1", "CheckBox")
1078:         THIS.grd_4c_Produtos.Column1.Check1.Caption = ""
1079:         THIS.grd_4c_Produtos.Column1.Check1.Value   = 0
1080:         THIS.grd_4c_Produtos.Column1.CurrentControl = "Check1"
1081: 
1082:         *-- Define RecordSource FORA do WITH para evitar auto-bind sobrescrever ControlSources
1083:         THIS.grd_4c_Produtos.ColumnCount = 5

*-- Linhas 1092 a 1103:
1092:         LOCAL loc_lLibValAtu
1093:         loc_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu
1094:         IF loc_lLibValAtu
1095:             THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
1096:             THIS.grd_4c_Produtos.Column5.ReadOnly = .F.
1097:         ELSE
1098:             THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
1099:             THIS.grd_4c_Produtos.Column5.Header1.Picture = gc_4c_CaminhoIcones + "lock.bmp"
1100:             THIS.grd_4c_Produtos.Column5.ReadOnly = .T.
1101:         ENDIF
1102: 
1103:         *-- Column2 come?a ReadOnly (modo normal; auditor inverte)

*-- Linhas 1111 a 1133:
1111:         *----------------------------------------------------------------------
1112:         THIS.AddObject("shp_4c_Foto", "Shape")
1113:         WITH THIS.shp_4c_Foto
1114:             .Top          = 414
1115:             .Left         = 763
1116:             .Width        = 205
1117:             .Height       = 140
1118:             .BackStyle    = 0
1119:             .BorderStyle  = 1
1120:             .FillStyle    = 1
1121:             .SpecialEffect = 1
1122:             .BorderColor  = RGB(90, 90, 90)
1123:         ENDWITH
1124: 
1125:         THIS.AddObject("img_4c_Foto", "Image")
1126:         WITH THIS.img_4c_Foto
1127:             .Top     = 415
1128:             .Left    = 764
1129:             .Width   = 203
1130:             .Height  = 138
1131:             .Stretch = 1
1132:             .Visible = .F.
1133:         ENDWITH

*-- Linhas 1167 a 1175:
1167:             THIS.cmg_4c_Acao.Buttons(2).Refresh
1168:         ENDIF
1169: 
1170:         *-- Reseta selecao global do header (checkbox da coluna 1)
1171:         THIS.this_lAllSelected = .T.
1172:         THIS.this_lInCol5      = .F.
1173:         THIS.this_nAntValAtu   = 0
1174: 
1175:         IF loc_nModo = 1

*-- Linhas 1299 a 1330:
1299:         loc_lTipo2 = (par_nTipo = 2)
1300: 
1301:         *-- Tipo 1: Variacao
1302:         THIS.lbl_4c_Variacao.Visible = loc_lTipo1
1303:         THIS.txt_4c_Variacao.Visible = loc_lTipo1
1304:         THIS.lbl_4c_Pct.Visible      = loc_lTipo1
1305:         THIS.chk_4c_IncCusts.Visible = loc_lTipo1
1306: 
1307:         *-- Tipo 2: MarkUp
1308:         THIS.lbl_4c_Moeda.Visible    = loc_lTipo2
1309:         THIS.txt_4c_Moeda.Visible    = loc_lTipo2
1310:         THIS.lbl_4c_MarkUp.Visible   = loc_lTipo2
1311:         THIS.txt_4c_MarkUp1.Visible  = loc_lTipo2
1312:         THIS.lbl_4c_Para.Visible     = loc_lTipo2
1313:         THIS.txt_4c_MarkUp2.Visible  = loc_lTipo2
1314:         THIS.lbl_4c_Fator.Visible    = loc_lTipo2
1315:         THIS.txt_4c_Fator.Visible    = loc_lTipo2
1316:         THIS.txt_4c_MoeCusto.Visible = loc_lTipo2
1317:         THIS.lbl_4c_Moecs.Visible    = loc_lTipo2
1318:         THIS.txt_4c_Moecs.Visible    = loc_lTipo2
1319:         THIS.lbl_4c_MoeCusFs.Visible = loc_lTipo2
1320:         THIS.txt_4c_MoeCusFs.Visible = loc_lTipo2
1321:         THIS.lbl_4c_Moedas.Visible   = loc_lTipo2
1322:         THIS.txt_4c_Moedas.Visible   = loc_lTipo2
1323:         THIS.lbl_4c_CFtios.Visible   = loc_lTipo2
1324:         THIS.txt_4c_CFtios.Visible   = loc_lTipo2
1325:         THIS.lbl_4c_MoeVs.Visible    = loc_lTipo2
1326:         THIS.txt_4c_MoeVs.Visible    = loc_lTipo2
1327: 
1328:         THIS.Refresh
1329:     ENDPROC
1330: 

