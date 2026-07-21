# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRES1): Top original=84 vs migrado 'cnt_4c_Container1' Top=13 (diff=71px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2111 linhas total):

*-- Linhas 61 a 70:
61:             THIS.TornarControlesVisiveis(THIS)
62: 
63:             *-- Define titulo no cabecalho
64:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"
65:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"
66: 
67:             *-- Inicializa valores dos campos
68:             THIS.InicializarCampos()
69: 
70:             *-- Liga eventos de lookup (KeyPress) aos campos

*-- Linhas 129 a 217:
129:     PROTECTED PROCEDURE ConfigurarCabecalho()
130:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
131:         WITH THIS.cnt_4c_Cabecalho
132:             .Top        = 0
133:             .Left       = 0
134:             .Width      = THIS.Width
135:             .Height     = 80
136:             .BackStyle  = 1
137:             .BackColor  = RGB(100, 100, 100)
138:             .BorderWidth = 0
139:             .Visible    = .T.
140: 
141:             .AddObject("lbl_4c_Sombra", "Label")
142:             WITH .lbl_4c_Sombra
143:                 .Top       = 25
144:                 .Left      = 10
145:                 .Width     = THIS.Width
146:                 .Height    = 40
147:                 .AutoSize  = .F.
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 18
150:                 .FontBold  = .T.
151:                 .BackStyle = 0
152:                 .ForeColor = RGB(0, 0, 0)
153:                 .Caption   = ""
154:                 .Visible   = .T.
155:             ENDWITH
156: 
157:             .AddObject("lbl_4c_Titulo", "Label")
158:             WITH .lbl_4c_Titulo
159:                 .Top       = 24
160:                 .Left      = 10
161:                 .Width     = THIS.Width
162:                 .Height    = 46
163:                 .AutoSize  = .F.
164:                 .FontName  = "Tahoma"
165:                 .FontSize  = 18
166:                 .FontBold  = .T.
167:                 .BackStyle = 0
168:                 .ForeColor = RGB(255, 255, 255)
169:                 .Caption   = ""
170:                 .Visible   = .T.
171:             ENDWITH
172:         ENDWITH
173:     ENDPROC
174: 
175:     *===========================================================================
176:     * ConfigurarContainerFiltros - Cria cnt_4c_Container1 com todos os filtros
177:     * Proporcional ao original: left=84->102, width=618->752, height=249->303
178:     * Escalado de 823->1000 (fator ~1.215)
179:     *===========================================================================
180:     PROTECTED PROCEDURE ConfigurarContainerFiltros()
181:         LOCAL loc_oCnt
182:         THIS.AddObject("cnt_4c_Container1", "Container")
183:         WITH THIS.cnt_4c_Container1
184:             .Top        = 84
185:             .Left       = 102
186:             .Width      = 752
187:             .Height     = 303
188:             .BackStyle  = 0
189:             .BorderWidth = 0
190:             .Visible    = .T.
191: 
192:             *-- Label Empresa
193:             .AddObject("lbl_4c_Empresa", "Label")
194:             WITH .lbl_4c_Empresa
195:                 .Top       = 13
196:                 .Left      = 55
197:                 .Width     = 60
198:                 .Height    = 15
199:                 .AutoSize  = .F.
200:                 .FontName  = "Tahoma"
201:                 .FontSize  = 8
202:                 .BackStyle = 0
203:                 .ForeColor = RGB(90, 90, 90)
204:                 .Caption   = "Empresa :"
205:                 .Visible   = .T.
206:             ENDWITH
207: 
208:             *-- Codigo Empresa (3 chars)
209:             .AddObject("txt_4c_CdEmpresa", "TextBox")
210:             WITH .txt_4c_CdEmpresa
211:                 .Top           = 10
212:                 .Left          = 122
213:                 .Width         = 38
214:                 .Height        = 23
215:                 .FontName      = "Tahoma"
216:                 .FontSize      = 8
217:                 .Format        = "K!"

*-- Linhas 226 a 235:
226:             *-- Descricao Empresa
227:             .AddObject("txt_4c_DsEmpresa", "TextBox")
228:             WITH .txt_4c_DsEmpresa
229:                 .Top           = 10
230:                 .Left          = 163
231:                 .Width         = 354
232:                 .Height        = 23
233:                 .FontName      = "Tahoma"
234:                 .FontSize      = 8
235:                 .Format        = "K!"

*-- Linhas 241 a 287:
241:                 .Visible       = .T.
242:             ENDWITH
243: 
244:             *-- CheckBox Empresa Destino
245:             .AddObject("chk_4c_EmpD", "CheckBox")
246:             WITH .chk_4c_EmpD
247:                 .Top       = 14
248:                 .Left      = 530
249:                 .Width     = 120
250:                 .Height    = 15
251:                 .FontName  = "Tahoma"
252:                 .FontSize  = 8
253:                 .BackStyle = 0
254:                 .AutoSize  = .F.
255:                 .Alignment = 0
256:                 .Caption   = "Empresa Destino"
257:                 .ForeColor = RGB(90, 90, 90)
258:                 .Value     = 0
259:                 .Visible   = .T.
260:             ENDWITH
261: 
262:             *-- Label Periodo
263:             .AddObject("lbl_4c_Periodo", "Label")
264:             WITH .lbl_4c_Periodo
265:                 .Top       = 41
266:                 .Left      = 61
267:                 .Width     = 55
268:                 .Height    = 15
269:                 .AutoSize  = .F.
270:                 .FontName  = "Tahoma"
271:                 .FontSize  = 8
272:                 .BackStyle = 0
273:                 .ForeColor = RGB(90, 90, 90)
274:                 .Caption   = "Per" + CHR(237) + "odo :"
275:                 .Visible   = .T.
276:             ENDWITH
277: 
278:             *-- Data Inicial
279:             .AddObject("txt_4c_DtInicial", "TextBox")
280:             WITH .txt_4c_DtInicial
281:                 .Top           = 37
282:                 .Left          = 122
283:                 .Width         = 97
284:                 .Height        = 23
285:                 .FontName      = "Tahoma"
286:                 .FontSize      = 8
287:                 .Format        = "K"

*-- Linhas 293 a 320:
293:             ENDWITH
294: 
295:             *-- Label separador "a"
296:             .AddObject("lbl_4c_PeriodoA", "Label")
297:             WITH .lbl_4c_PeriodoA
298:                 .Top       = 41
299:                 .Left      = 222
300:                 .Width     = 10
301:                 .Height    = 15
302:                 .AutoSize  = .F.
303:                 .FontName  = "Tahoma"
304:                 .FontSize  = 8
305:                 .BackStyle = 0
306:                 .ForeColor = RGB(90, 90, 90)
307:                 .Caption   = CHR(224)
308:                 .Visible   = .T.
309:             ENDWITH
310: 
311:             *-- Data Final
312:             .AddObject("txt_4c_DtFinal", "TextBox")
313:             WITH .txt_4c_DtFinal
314:                 .Top           = 37
315:                 .Left          = 235
316:                 .Width         = 97
317:                 .Height        = 23
318:                 .FontName      = "Tahoma"
319:                 .FontSize      = 8
320:                 .Format        = "K"

*-- Linhas 328 a 390:
328:             *-- OptionGroup Periodo (Lancamento / Prazo Entrega)
329:             .AddObject("obj_4c_OptPeriodo", "OptionGroup")
330:             WITH .obj_4c_OptPeriodo
331:                 .Top         = 36
332:                 .Left        = 332
333:                 .Width       = 225
334:                 .Height      = 25
335:                 .ButtonCount = 2
336:                 .BackStyle   = 0
337:                 .Value       = 1
338:                 .Themes      = .F.
339:                 .AutoSize    = .F.
340:                 WITH .Buttons(1)
341:                     .Top       = 5
342:                     .Left      = 5
343:                     .Width     = 92
344:                     .Height    = 15
345:                     .AutoSize  = .F.
346:                     .BackStyle = 0
347:                     .ForeColor = RGB(90, 90, 90)
348:                     .Caption   = "Lan" + CHR(231) + "amento"
349:                 ENDWITH
350:                 WITH .Buttons(2)
351:                     .Top       = 5
352:                     .Left      = 114
353:                     .Width     = 105
354:                     .Height    = 15
355:                     .AutoSize  = .F.
356:                     .BackStyle = 0
357:                     .FontName  = "Tahoma"
358:                     .FontSize  = 8
359:                     .ForeColor = RGB(90, 90, 90)
360:                     .Caption   = "Prazo Entrega"
361:                 ENDWITH
362:                 .Visible = .T.
363:             ENDWITH
364: 
365:             *-- Label Movimentacao
366:             .AddObject("lbl_4c_Movimentacao", "Label")
367:             WITH .lbl_4c_Movimentacao
368:                 .Top       = 67
369:                 .Left      = 21
370:                 .Width     = 95
371:                 .Height    = 15
372:                 .AutoSize  = .F.
373:                 .FontName  = "Tahoma"
374:                 .FontSize  = 8
375:                 .BackStyle = 0
376:                 .ForeColor = RGB(90, 90, 90)
377:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
378:                 .Visible   = .T.
379:             ENDWITH
380: 
381:             *-- Campo Movimentacao / Operacao
382:             .AddObject("txt_4c_NmOperacao", "TextBox")
383:             WITH .txt_4c_NmOperacao
384:                 .Top           = 63
385:                 .Left          = 122
386:                 .Width         = 182
387:                 .Height        = 23
388:                 .FontName      = "Tahoma"
389:                 .FontSize      = 9
390:                 .Format        = "K!"

*-- Linhas 397 a 424:
397:             ENDWITH
398: 
399:             *-- Label Numero
400:             .AddObject("lbl_4c_Numero", "Label")
401:             WITH .lbl_4c_Numero
402:                 .Top       = 67
403:                 .Left      = 305
404:                 .Width     = 40
405:                 .Height    = 15
406:                 .AutoSize  = .F.
407:                 .FontName  = "Tahoma"
408:                 .FontSize  = 8
409:                 .BackStyle = 0
410:                 .ForeColor = RGB(90, 90, 90)
411:                 .Caption   = "N" + CHR(250) + "m :"
412:                 .Visible   = .T.
413:             ENDWITH
414: 
415:             *-- Campo Numero
416:             .AddObject("txt_4c_Numero", "TextBox")
417:             WITH .txt_4c_Numero
418:                 .Top           = 63
419:                 .Left          = 306
420:                 .Width         = 67
421:                 .Height        = 23
422:                 .FontName      = "Tahoma"
423:                 .FontSize      = 8
424:                 .Alignment     = 3

*-- Linhas 432 a 459:
432:             ENDWITH
433: 
434:             *-- Label OP
435:             .AddObject("lbl_4c_Op", "Label")
436:             WITH .lbl_4c_Op
437:                 .Top       = 67
438:                 .Left      = 387
439:                 .Width     = 28
440:                 .Height    = 15
441:                 .AutoSize  = .F.
442:                 .FontName  = "Tahoma"
443:                 .FontSize  = 8
444:                 .BackStyle = 0
445:                 .ForeColor = RGB(90, 90, 90)
446:                 .Caption   = "OP :"
447:                 .Visible   = .T.
448:             ENDWITH
449: 
450:             *-- Campo OP
451:             .AddObject("txt_4c_Op", "TextBox")
452:             WITH .txt_4c_Op
453:                 .Top           = 63
454:                 .Left          = 423
455:                 .Width         = 67
456:                 .Height        = 23
457:                 .FontName      = "Tahoma"
458:                 .FontSize      = 8
459:                 .Alignment     = 3

*-- Linhas 467 a 494:
467:             ENDWITH
468: 
469:             *-- Label Status
470:             .AddObject("lbl_4c_Status", "Label")
471:             WITH .lbl_4c_Status
472:                 .Top       = 67
473:                 .Left      = 498
474:                 .Width     = 48
475:                 .Height    = 15
476:                 .AutoSize  = .F.
477:                 .FontName  = "Tahoma"
478:                 .FontSize  = 8
479:                 .BackStyle = 0
480:                 .ForeColor = RGB(90, 90, 90)
481:                 .Caption   = "Status :"
482:                 .Visible   = .T.
483:             ENDWITH
484: 
485:             *-- Campo pStatus (1 char, A=Ativo, etc)
486:             .AddObject("txt_4c_PStatus", "TextBox")
487:             WITH .txt_4c_PStatus
488:                 .Top           = 63
489:                 .Left          = 554
490:                 .Width         = 21
491:                 .Height        = 23
492:                 .FontName      = "Tahoma"
493:                 .FontSize      = 8
494:                 .InputMask     = "A"

*-- Linhas 500 a 527:
500:             ENDWITH
501: 
502:             *-- Label Grupo
503:             .AddObject("lbl_4c_Grupo", "Label")
504:             WITH .lbl_4c_Grupo
505:                 .Top       = 93
506:                 .Left      = 69
507:                 .Width     = 47
508:                 .Height    = 15
509:                 .AutoSize  = .F.
510:                 .FontName  = "Tahoma"
511:                 .FontSize  = 8
512:                 .BackStyle = 0
513:                 .ForeColor = RGB(90, 90, 90)
514:                 .Caption   = "Grupo :"
515:                 .Visible   = .T.
516:             ENDWITH
517: 
518:             *-- Codigo Grupo Contabil
519:             .AddObject("txt_4c_Grupo", "TextBox")
520:             WITH .txt_4c_Grupo
521:                 .Top           = 89
522:                 .Left          = 122
523:                 .Width         = 97
524:                 .Height        = 23
525:                 .FontName      = "Tahoma"
526:                 .FontSize      = 8
527:                 .Format        = "K"

*-- Linhas 536 a 545:
536:             *-- Descricao Grupo
537:             .AddObject("txt_4c_DsGrupo", "TextBox")
538:             WITH .txt_4c_DsGrupo
539:                 .Top           = 89
540:                 .Left          = 222
541:                 .Width         = 353
542:                 .Height        = 23
543:                 .FontName      = "Tahoma"
544:                 .FontSize      = 8
545:                 .Format        = "K"

*-- Linhas 552 a 579:
552:             ENDWITH
553: 
554:             *-- Label Conta
555:             .AddObject("lbl_4c_Conta", "Label")
556:             WITH .lbl_4c_Conta
557:                 .Top       = 119
558:                 .Left      = 69
559:                 .Width     = 47
560:                 .Height    = 15
561:                 .AutoSize  = .F.
562:                 .FontName  = "Tahoma"
563:                 .FontSize  = 8
564:                 .BackStyle = 0
565:                 .ForeColor = RGB(90, 90, 90)
566:                 .Caption   = "Conta :"
567:                 .Visible   = .T.
568:             ENDWITH
569: 
570:             *-- Codigo Conta (iClis)
571:             .AddObject("txt_4c_Conta", "TextBox")
572:             WITH .txt_4c_Conta
573:                 .Top           = 115
574:                 .Left          = 122
575:                 .Width         = 97
576:                 .Height        = 23
577:                 .FontName      = "Tahoma"
578:                 .FontSize      = 9
579:                 .Format        = "K"

*-- Linhas 588 a 597:
588:             *-- CPF/CNPJ (busca alternativa por documento)
589:             .AddObject("txt_4c_Cpf", "TextBox")
590:             WITH .txt_4c_Cpf
591:                 .Top           = 115
592:                 .Left          = 222
593:                 .Width         = 178
594:                 .Height        = 23
595:                 .FontName      = "Tahoma"
596:                 .FontSize      = 8
597:                 .InputMask     = "XXXXXXXXXXXXXXXXXXXX"

*-- Linhas 606 a 615:
606:             *-- Descricao Conta (rClis)
607:             .AddObject("txt_4c_DsConta", "TextBox")
608:             WITH .txt_4c_DsConta
609:                 .Top           = 115
610:                 .Left          = 404
611:                 .Width         = 341
612:                 .Height        = 23
613:                 .FontName      = "Courier New"
614:                 .FontSize      = 8
615:                 .Format        = "K"

*-- Linhas 622 a 649:
622:             ENDWITH
623: 
624:             *-- Label Responsavel
625:             .AddObject("lbl_4c_Responsavel", "Label")
626:             WITH .lbl_4c_Responsavel
627:                 .Top       = 145
628:                 .Left      = 30
629:                 .Width     = 87
630:                 .Height    = 15
631:                 .AutoSize  = .F.
632:                 .FontName  = "Tahoma"
633:                 .FontSize  = 8
634:                 .BackStyle = 0
635:                 .ForeColor = RGB(90, 90, 90)
636:                 .Caption   = "Respons" + CHR(225) + "vel :"
637:                 .Visible   = .T.
638:             ENDWITH
639: 
640:             *-- Codigo Responsavel (Vends/iClis do vendedor)
641:             .AddObject("txt_4c_Resps", "TextBox")
642:             WITH .txt_4c_Resps
643:                 .Top           = 141
644:                 .Left          = 122
645:                 .Width         = 97
646:                 .Height        = 23
647:                 .FontName      = "Tahoma"
648:                 .FontSize      = 9
649:                 .Format        = "K"

*-- Linhas 658 a 667:
658:             *-- Descricao Responsavel
659:             .AddObject("txt_4c_DsResps", "TextBox")
660:             WITH .txt_4c_DsResps
661:                 .Top           = 141
662:                 .Left          = 222
663:                 .Width         = 353
664:                 .Height        = 23
665:                 .FontName      = "Tahoma"
666:                 .FontSize      = 8
667:                 .Format        = "K"

*-- Linhas 674 a 701:
674:             ENDWITH
675: 
676:             *-- Label Moeda
677:             .AddObject("lbl_4c_Moeda", "Label")
678:             WITH .lbl_4c_Moeda
679:                 .Top       = 171
680:                 .Left      = 66
681:                 .Width     = 50
682:                 .Height    = 15
683:                 .AutoSize  = .F.
684:                 .FontName  = "Tahoma"
685:                 .FontSize  = 8
686:                 .BackStyle = 0
687:                 .ForeColor = RGB(90, 90, 90)
688:                 .Caption   = "Moeda :"
689:                 .Visible   = .T.
690:             ENDWITH
691: 
692:             *-- Codigo Moeda (CMoes, 3 chars)
693:             .AddObject("txt_4c_CdMoeda", "TextBox")
694:             WITH .txt_4c_CdMoeda
695:                 .Top           = 167
696:                 .Left          = 122
697:                 .Width         = 38
698:                 .Height        = 23
699:                 .FontName      = "Tahoma"
700:                 .FontSize      = 8
701:                 .Format        = "K!"

*-- Linhas 710 a 719:
710:             *-- Descricao Moeda (DMoes)
711:             .AddObject("txt_4c_DsMoeda", "TextBox")
712:             WITH .txt_4c_DsMoeda
713:                 .Top           = 167
714:                 .Left          = 163
715:                 .Width         = 140
716:                 .Height        = 23
717:                 .FontName      = "Tahoma"
718:                 .FontSize      = 8
719:                 .Format        = "K!"

*-- Linhas 726 a 899:
726:             ENDWITH
727: 
728:             *-- Label Cotacao
729:             .AddObject("lbl_4c_Cotacao", "Label")
730:             WITH .lbl_4c_Cotacao
731:                 .Top       = 171
732:                 .Left      = 308
733:                 .Width     = 60
734:                 .Height    = 15
735:                 .AutoSize  = .F.
736:                 .FontName  = "Tahoma"
737:                 .FontSize  = 8
738:                 .BackStyle = 0
739:                 .ForeColor = RGB(90, 90, 90)
740:                 .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
741:                 .Visible   = .T.
742:             ENDWITH
743: 
744:             *-- OptionGroup Cotacao (Fechamento / Movimentacao)
745:             .AddObject("obj_4c_OptCotacao", "OptionGroup")
746:             WITH .obj_4c_OptCotacao
747:                 .Top         = 165
748:                 .Left        = 375
749:                 .Width       = 247
750:                 .Height      = 27
751:                 .ButtonCount = 2
752:                 .BackStyle   = 0
753:                 .Value       = 1
754:                 .Themes      = .F.
755:                 .AutoSize    = .F.
756:                 WITH .Buttons(1)
757:                     .Top       = 5
758:                     .Left      = 5
759:                     .Width     = 108
760:                     .Height    = 17
761:                     .AutoSize  = .F.
762:                     .BackStyle = 0
763:                     .ForeColor = RGB(90, 90, 90)
764:                     .Caption   = "Fechamento"
765:                 ENDWITH
766:                 WITH .Buttons(2)
767:                     .Top       = 5
768:                     .Left      = 122
769:                     .Width     = 121
770:                     .Height    = 17
771:                     .AutoSize  = .F.
772:                     .BackStyle = 0
773:                     .FontName  = "Tahoma"
774:                     .FontSize  = 8
775:                     .ForeColor = RGB(90, 90, 90)
776:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
777:                 ENDWITH
778:                 .Visible = .T.
779:             ENDWITH
780: 
781:             *-- Label Situacao
782:             .AddObject("lbl_4c_Situacao", "Label")
783:             WITH .lbl_4c_Situacao
784:                 .Top       = 196
785:                 .Left      = 55
786:                 .Width     = 61
787:                 .Height    = 15
788:                 .AutoSize  = .F.
789:                 .FontName  = "Tahoma"
790:                 .FontSize  = 8
791:                 .BackStyle = 0
792:                 .ForeColor = RGB(90, 90, 90)
793:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
794:                 .Visible   = .T.
795:             ENDWITH
796: 
797:             *-- OptionGroup Situacao (opcoes: Todas / Baixadas / Em aberto)
798:             .AddObject("obj_4c_OptPendente", "OptionGroup")
799:             WITH .obj_4c_OptPendente
800:                 .Top         = 191
801:                 .Left        = 114
802:                 .Width       = 282
803:                 .Height      = 25
804:                 .ButtonCount = 3
805:                 .BackStyle   = 0
806:                 .Value       = 3
807:                 .Themes      = .F.
808:                 .AutoSize    = .F.
809:                 WITH .Buttons(1)
810:                     .Top       = 5
811:                     .Left      = 5
812:                     .Width     = 84
813:                     .Height    = 15
814:                     .AutoSize  = .F.
815:                     .BackStyle = 0
816:                     .ForeColor = RGB(90, 90, 90)
817:                     .Caption   = "Pendentes"
818:                 ENDWITH
819:                 WITH .Buttons(2)
820:                     .Top       = 5
821:                     .Left      = 108
822:                     .Width     = 74
823:                     .Height    = 15
824:                     .AutoSize  = .F.
825:                     .BackStyle = 0
826:                     .FontName  = "Tahoma"
827:                     .FontSize  = 8
828:                     .ForeColor = RGB(90, 90, 90)
829:                     .Caption   = "Baixadas"
830:                 ENDWITH
831:                 WITH .Buttons(3)
832:                     .Top       = 5
833:                     .Left      = 202
834:                     .Width     = 74
835:                     .Height    = 15
836:                     .AutoSize  = .F.
837:                     .BackStyle = 0
838:                     .FontName  = "Tahoma"
839:                     .FontSize  = 8
840:                     .ForeColor = RGB(90, 90, 90)
841:                     .Caption   = "Todas"
842:                 ENDWITH
843:                 .Visible = .T.
844:             ENDWITH
845: 
846:             *-- Label Impressao
847:             .AddObject("lbl_4c_Impressao", "Label")
848:             WITH .lbl_4c_Impressao
849:                 .Top       = 218
850:                 .Left      = 44
851:                 .Width     = 72
852:                 .Height    = 15
853:                 .AutoSize  = .F.
854:                 .FontName  = "Tahoma"
855:                 .FontSize  = 8
856:                 .BackStyle = 0
857:                 .ForeColor = RGB(90, 90, 90)
858:                 .Caption   = "Impress" + CHR(227) + "o :"
859:                 .Visible   = .T.
860:             ENDWITH
861: 
862:             *-- OptionGroup Impressao (Por Vendedor / Por Movimentacao)
863:             .AddObject("obj_4c_OptImpressao", "OptionGroup")
864:             WITH .obj_4c_OptImpressao
865:                 .Top         = 213
866:                 .Left        = 114
867:                 .Width       = 279
868:                 .Height      = 25
869:                 .ButtonCount = 2
870:                 .BackStyle   = 0
871:                 .Value       = 1
872:                 .Themes      = .F.
873:                 .AutoSize    = .F.
874:                 WITH .Buttons(1)
875:                     .Top       = 5
876:                     .Left      = 5
877:                     .Width     = 101
878:                     .Height    = 15
879:                     .AutoSize  = .F.
880:                     .BackStyle = 0
881:                     .ForeColor = RGB(90, 90, 90)
882:                     .Caption   = "Por Vendedor"
883:                 ENDWITH
884:                 WITH .Buttons(2)
885:                     .Top       = 5
886:                     .Left      = 143
887:                     .Width     = 130
888:                     .Height    = 15
889:                     .AutoSize  = .F.
890:                     .BackStyle = 0
891:                     .FontName  = "Tahoma"
892:                     .FontSize  = 8
893:                     .ForeColor = RGB(90, 90, 90)
894:                     .Caption   = "Por Movimenta" + CHR(231) + CHR(227) + "o"
895:                 ENDWITH
896:                 .Visible = .T.
897:             ENDWITH
898: 
899:         ENDWITH

*-- Linhas 906 a 953:
906:     PROTECTED PROCEDURE ConfigurarBotoes()
907:         THIS.AddObject("obj_4c_Sair", "CommandGroup")
908:         WITH THIS.obj_4c_Sair
909:             .Top         = -2
910:             .Left        = 808
911:             .Width       = 186
912:             .Height      = 85
913:             .ButtonCount = 2
914:             .BackStyle   = 0
915:             .BorderStyle = 0
916:             .Value       = 1
917:             .Themes      = .F.
918:             .Visible     = .T.
919: 
920:             WITH .Buttons(1)
921:                 .Top           = 5
922:                 .Left          = 5
923:                 .Width         = 75
924:                 .Height        = 75
925:                 .FontBold      = .T.
926:                 .FontItalic    = .T.
927:                 .WordWrap      = .T.
928:                 .Caption       = "Consultar"
929:                 .Picture       = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
930:                 .ForeColor     = RGB(90, 90, 90)
931:                 .BackColor     = RGB(255, 255, 255)
932:                 .Themes        = .F.
933:                 .SpecialEffect = 0
934:                 .MousePointer  = 15
935:                 .PicturePosition = 13
936:             ENDWITH
937: 
938:             WITH .Buttons(2)
939:                 .Top           = 5
940:                 .Left          = 98
941:                 .Width         = 75
942:                 .Height        = 75
943:                 .FontBold      = .T.
944:                 .FontItalic    = .T.
945:                 .FontName      = "Tahoma"
946:                 .FontSize      = 8
947:                 .WordWrap      = .T.
948:                 .Caption       = "Encerrar"
949:                 .Cancel        = .T.
950:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
951:                 .ForeColor     = RGB(90, 90, 90)
952:                 .BackColor     = RGB(255, 255, 255)
953:                 .Themes        = .F.

*-- Linhas 964 a 984:
964:     *===========================================================================
965:     * InicializarCampos - Seta valores default dos campos de filtro
966:     * Replica logica do Init() original
967:     *===========================================================================
968:     PROTECTED PROCEDURE InicializarCampos()
969:         WITH THIS.cnt_4c_Container1
970:             .txt_4c_NmOperacao.Value  = ""
971:             .txt_4c_DtInicial.Value   = DATE()
972:             .txt_4c_DtFinal.Value     = DATE()
973:             .txt_4c_Grupo.Value       = SPACE(10)
974:             .txt_4c_DsGrupo.Value     = SPACE(20)
975:             .txt_4c_Conta.Value       = SPACE(10)
976:             .txt_4c_DsConta.Value     = SPACE(40)
977:             .txt_4c_CdMoeda.Value     = " "
978:             .txt_4c_DsMoeda.Value     = ""
979:             .txt_4c_Resps.Value       = ""
980:             .txt_4c_DsResps.Value     = ""
981:             .txt_4c_Cpf.Value         = ""
982:             .txt_4c_Numero.Value      = 0
983:             .txt_4c_Op.Value          = 0
984:             .txt_4c_PStatus.Value     = ""

*-- Linhas 1024 a 1095:
1024:     *===========================================================================
1025:     * FormParaBO - Transfere filtros do Form para o Business Object
1026:     *===========================================================================
1027:     PROCEDURE FormParaBO()
1028:         WITH THIS.this_oBusinessObject
1029:             .this_cEmpresa    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value)
1030:             .this_cDsEmpresa  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value)
1031:             .this_nEmpD       = THIS.cnt_4c_Container1.chk_4c_EmpD.Value
1032:             .this_cNmOperacao = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value)
1033:             .this_nNumero     = THIS.cnt_4c_Container1.txt_4c_Numero.Value
1034:             .this_nOp         = THIS.cnt_4c_Container1.txt_4c_Op.Value
1035:             .this_dDtInicial  = THIS.cnt_4c_Container1.txt_4c_DtInicial.Value
1036:             .this_dDtFinal    = THIS.cnt_4c_Container1.txt_4c_DtFinal.Value
1037:             .this_nPeriodo    = THIS.cnt_4c_Container1.obj_4c_OptPeriodo.Value
1038:             .this_cGrupo      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
1039:             .this_cDsGrupo    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value)
1040:             .this_cConta      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Conta.Value)
1041:             .this_cDsConta    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsConta.Value)
1042:             .this_cCpf        = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Cpf.Value)
1043:             .this_cResps      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Resps.Value)
1044:             .this_cDsResps    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsResps.Value)
1045:             .this_cMoeda      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value)
1046:             .this_cDsMoeda    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value)
1047:             .this_nSituacao   = THIS.cnt_4c_Container1.obj_4c_OptPendente.Value
1048:             .this_nImpressao  = THIS.cnt_4c_Container1.obj_4c_OptImpressao.Value
1049:             .this_nCotacao    = THIS.cnt_4c_Container1.obj_4c_OptCotacao.Value
1050:             .this_cStatus     = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_PStatus.Value)
1051:         ENDWITH
1052:     ENDPROC
1053: 
1054:     *===========================================================================
1055:     * BOParaForm - Transfere valores do BO de volta ao Form
1056:     *===========================================================================
1057:     PROCEDURE BOParaForm()
1058:         WITH THIS.this_oBusinessObject
1059:             THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = .this_cEmpresa
1060:             THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = .this_cDsEmpresa
1061:             THIS.cnt_4c_Container1.chk_4c_EmpD.Value       = .this_nEmpD
1062:             THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = .this_cNmOperacao
1063:             THIS.cnt_4c_Container1.txt_4c_Numero.Value     = .this_nNumero
1064:             THIS.cnt_4c_Container1.txt_4c_Op.Value         = .this_nOp
1065:             THIS.cnt_4c_Container1.txt_4c_DtInicial.Value  = .this_dDtInicial
1066:             THIS.cnt_4c_Container1.txt_4c_DtFinal.Value    = .this_dDtFinal
1067:             THIS.cnt_4c_Container1.obj_4c_OptPeriodo.Value = .this_nPeriodo
1068:             THIS.cnt_4c_Container1.txt_4c_Grupo.Value      = .this_cGrupo
1069:             THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value    = .this_cDsGrupo
1070:             THIS.cnt_4c_Container1.txt_4c_Conta.Value      = .this_cConta
1071:             THIS.cnt_4c_Container1.txt_4c_DsConta.Value    = .this_cDsConta
1072:             THIS.cnt_4c_Container1.txt_4c_Cpf.Value        = .this_cCpf
1073:             THIS.cnt_4c_Container1.txt_4c_Resps.Value      = .this_cResps
1074:             THIS.cnt_4c_Container1.txt_4c_DsResps.Value    = .this_cDsResps
1075:             THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value    = .this_cMoeda
1076:             THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value    = .this_cDsMoeda
1077:             THIS.cnt_4c_Container1.obj_4c_OptPendente.Value  = .this_nSituacao
1078:             THIS.cnt_4c_Container1.obj_4c_OptImpressao.Value = .this_nImpressao
1079:             THIS.cnt_4c_Container1.obj_4c_OptCotacao.Value   = .this_nCotacao
1080:             THIS.cnt_4c_Container1.txt_4c_PStatus.Value    = .this_cStatus
1081:         ENDWITH
1082:     ENDPROC
1083: 
1084:     *===========================================================================
1085:     * BtnIncluirClick - N/A (form OPERACIONAL de consulta/relat" + CHR(243) + "rio, sem CRUD)
1086:     * SIGPRES1 eh um dialogo de filtros que dispara consulta "Posicao Por
1087:     * Movimentacao" (abre SigPrEs2 com os resultados). Nao inclui/altera/
1088:     * visualiza/exclui registros de negocio - apenas coleta parametros e
1089:     * chama ExecutarConsulta() no BO. Ver BtnConsultarClick() para o fluxo
1090:     * principal do form.
1091:     * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
1092:     *===========================================================================
1093:     PROCEDURE BtnIncluirClick()
1094:         *-- Sem-operacao: dialogo de filtros nao suporta inclusao de registros.
1095:         *-- Ver BtnConsultarClick() para executar a consulta configurada.

*-- Linhas 1138 a 1172:
1138:     PROCEDURE BtnConsultarClick()
1139:         LOCAL loc_lResultado, loc_cNmOp, loc_nSessaoId
1140:         loc_lResultado = .F.
1141: 
1142:         *-- Valida campos obrigatorios
1143:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value))
1144:             MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aviso")
1145:             THIS.cnt_4c_Container1.txt_4c_CdEmpresa.SetFocus()
1146:             RETURN
1147:         ENDIF
1148: 
1149:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value))
1150:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Aviso")
1151:             THIS.cnt_4c_Container1.txt_4c_NmOperacao.SetFocus()
1152:             RETURN
1153:         ENDIF
1154: 
1155:         IF THIS.cnt_4c_Container1.txt_4c_DtFinal.Value < THIS.cnt_4c_Container1.txt_4c_DtInicial.Value
1156:             MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!", "Aviso")
1157:             THIS.cnt_4c_Container1.txt_4c_DtInicial.SetFocus()
1158:             RETURN
1159:         ENDIF
1160: 
1161:         *-- Transfere filtros para o BO
1162:         THIS.FormParaBO()
1163: 
1164:         *-- Executa consulta
1165:         THIS.Enabled = .F.
1166:         TRY
1167:             IF THIS.this_oBusinessObject.ExecutarConsulta()
1168:                 *-- Registra auditoria
1169:                 THIS.this_oBusinessObject.RegistrarAuditoria("CONSULTA")
1170: 
1171:                 *-- Abre form de resultados passando operacao e DataSessionId
1172:                 loc_cNmOp     = ALLTRIM(THIS.this_oBusinessObject.this_cNmOperacao)

*-- Linhas 1225 a 1246:
1225:             loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
1226:             loc_oBusca.mAddColuna("Razas", "", "Empresa")
1227:             loc_oBusca.Show()
1228: 
1229:             IF loc_oBusca.this_lSelecionou
1230:                 THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = ALLTRIM(NVL(cursor_4c_BuscaEmp.Cemps, ""))
1231:                 THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = ALLTRIM(NVL(cursor_4c_BuscaEmp.Razas, ""))
1232:             ENDIF
1233: 
1234:             IF USED("cursor_4c_BuscaEmp")
1235:                 USE IN cursor_4c_BuscaEmp
1236:             ENDIF
1237:         CATCH TO loc_oErro
1238:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmpresa")
1239:         ENDTRY
1240:     ENDPROC
1241: 
1242:     *===========================================================================
1243:     * AbrirBuscaOperacao - Abre picker de operacao (SigCdOpe.Dopes)
1244:     *===========================================================================
1245:     PROCEDURE AbrirBuscaOperacao(par_cValor)
1246:         LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere

*-- Linhas 1266 a 1286:
1266:                 "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
1267:             loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1268:             loc_oBusca.Show()
1269: 
1270:             IF loc_oBusca.this_lSelecionou
1271:                 THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))
1272:             ENDIF
1273: 
1274:             IF USED("cursor_4c_BuscaOpe")
1275:                 USE IN cursor_4c_BuscaOpe
1276:             ENDIF
1277:         CATCH TO loc_oErro
1278:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaOperacao")
1279:         ENDTRY
1280:     ENDPROC
1281: 
1282:     *===========================================================================
1283:     * AbrirBuscaMoeda - Abre picker de moeda (SigCdMoe)
1284:     *===========================================================================
1285:     PROCEDURE AbrirBuscaMoeda(par_cModo, par_cValor)
1286:         LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere

*-- Linhas 1312 a 1333:
1312:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
1313:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1314:             loc_oBusca.Show()
1315: 
1316:             IF loc_oBusca.this_lSelecionou
1317:                 THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_BuscaMoe.CMoes, ""))
1318:                 THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_BuscaMoe.DMoes, ""))
1319:             ENDIF
1320: 
1321:             IF USED("cursor_4c_BuscaMoe")
1322:                 USE IN cursor_4c_BuscaMoe
1323:             ENDIF
1324:         CATCH TO loc_oErro
1325:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaMoeda")
1326:         ENDTRY
1327:     ENDPROC
1328: 
1329:     *===========================================================================
1330:     * AbrirBuscaConta - Abre picker de conta SigCdCli (por codigo ou descricao)
1331:     * Substituto canonico de fAcessoContas()
1332:     *===========================================================================
1333:     PROCEDURE AbrirBuscaConta(par_cModo, par_cGrupo, par_cValor)

*-- Linhas 1365 a 1387:
1365:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1366:             loc_oBusca.mAddColuna("RClis", "", "Nome")
1367:             loc_oBusca.Show()
1368: 
1369:             IF loc_oBusca.this_lSelecionou
1370:                 THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_BuscaCli.IClis, ""))
1371:                 THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_BuscaCli.RClis, ""))
1372:                 THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_BuscaCli.Cpfs, ""))
1373:             ENDIF
1374: 
1375:             IF USED("cursor_4c_BuscaCli")
1376:                 USE IN cursor_4c_BuscaCli
1377:             ENDIF
1378:         CATCH TO loc_oErro
1379:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaConta")
1380:         ENDTRY
1381:     ENDPROC
1382: 
1383:     *===========================================================================
1384:     * AbrirBuscaResponsavel - Abre picker de responsavel/vendedor (SigCdCli)
1385:     * Usa grupo padrao de vendedores (this_oBusinessObject.this_cGrPadVens)
1386:     *===========================================================================
1387:     PROCEDURE AbrirBuscaResponsavel(par_cModo, par_cValor)

*-- Linhas 1429 a 1450:
1429:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1430:             loc_oBusca.mAddColuna("RClis", "", "Nome")
1431:             loc_oBusca.Show()
1432: 
1433:             IF loc_oBusca.this_lSelecionou
1434:                 THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_BuscaResp.IClis, ""))
1435:                 THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_BuscaResp.RClis, ""))
1436:             ENDIF
1437: 
1438:             IF USED("cursor_4c_BuscaResp")
1439:                 USE IN cursor_4c_BuscaResp
1440:             ENDIF
1441:         CATCH TO loc_oErro
1442:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaResponsavel")
1443:         ENDTRY
1444:     ENDPROC
1445: 
1446:     *===========================================================================
1447:     * ValidarCdEmpresa - Handler KeyPress de txt_4c_CdEmpresa
1448:     * ENTER/TAB: SELECT exato; miss -> AbrirBuscaEmpresa
1449:     * F4: abre picker direto
1450:     *===========================================================================

*-- Linhas 1456 a 1646:
1456:         ENDIF
1457:         IF par_nKeyCode = 115
1458:             THIS.AbrirBuscaEmpresa("C")
1459:             RETURN
1460:         ENDIF
1461:         loc_cCod = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value)
1462:         IF EMPTY(loc_cCod)
1463:             THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value = ""
1464:             RETURN
1465:         ENDIF
1466:         TRY
1467:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1468:             IF USED("cursor_4c_EmpTmp")
1469:                 USE IN cursor_4c_EmpTmp
1470:             ENDIF
1471:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
1472:             IF loc_nResultado >= 1
1473:                 SELECT cursor_4c_EmpTmp
1474:                 IF !EOF("cursor_4c_EmpTmp")
1475:                     THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
1476:                     THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
1477:                     USE IN cursor_4c_EmpTmp
1478:                     RETURN
1479:                 ENDIF
1480:                 USE IN cursor_4c_EmpTmp
1481:             ENDIF
1482:             THIS.AbrirBuscaEmpresa("C")
1483:         CATCH TO loc_oErro
1484:             MsgErro(loc_oErro.Message, "Erro ValidarCdEmpresa")
1485:         ENDTRY
1486:     ENDPROC
1487: 
1488:     *===========================================================================
1489:     * ValidarDsEmpresa - Handler KeyPress de txt_4c_DsEmpresa
1490:     *===========================================================================
1491:     PROCEDURE ValidarDsEmpresa
1492:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1493:         LOCAL loc_nResultado, loc_cSQL, loc_cDs
1494:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1495:             RETURN
1496:         ENDIF
1497:         IF par_nKeyCode = 115
1498:             THIS.AbrirBuscaEmpresa("D")
1499:             RETURN
1500:         ENDIF
1501:         loc_cDs = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value)
1502:         IF EMPTY(loc_cDs)
1503:             THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value = ""
1504:             RETURN
1505:         ENDIF
1506:         TRY
1507:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) LIKE " + ;
1508:                 EscaparSQL(loc_cDs + "%")
1509:             IF USED("cursor_4c_EmpTmp")
1510:                 USE IN cursor_4c_EmpTmp
1511:             ENDIF
1512:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
1513:             IF loc_nResultado >= 1
1514:                 SELECT cursor_4c_EmpTmp
1515:                 IF !EOF("cursor_4c_EmpTmp")
1516:                     THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
1517:                     THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
1518:                     USE IN cursor_4c_EmpTmp
1519:                     RETURN
1520:                 ENDIF
1521:                 USE IN cursor_4c_EmpTmp
1522:             ENDIF
1523:             THIS.AbrirBuscaEmpresa("D")
1524:         CATCH TO loc_oErro
1525:             MsgErro(loc_oErro.Message, "Erro ValidarDsEmpresa")
1526:         ENDTRY
1527:     ENDPROC
1528: 
1529:     *===========================================================================
1530:     * ValidarNmOperacao - Handler KeyPress de txt_4c_NmOperacao (fAcessoMovmto)
1531:     * ENTER/TAB/F4 -> abre picker SigCdOpe
1532:     *===========================================================================
1533:     PROCEDURE ValidarNmOperacao
1534:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1535:         LOCAL loc_nResultado, loc_cSQL, loc_cOpe
1536:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1537:             RETURN
1538:         ENDIF
1539:         loc_cOpe = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value)
1540:         IF par_nKeyCode = 115
1541:             THIS.AbrirBuscaOperacao(loc_cOpe)
1542:             RETURN
1543:         ENDIF
1544:         IF EMPTY(loc_cOpe)
1545:             RETURN
1546:         ENDIF
1547:         TRY
1548:             loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(PADR(loc_cOpe, 20))
1549:             IF USED("cursor_4c_OpeTmp")
1550:                 USE IN cursor_4c_OpeTmp
1551:             ENDIF
1552:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTmp")
1553:             IF loc_nResultado >= 1
1554:                 SELECT cursor_4c_OpeTmp
1555:                 IF !EOF("cursor_4c_OpeTmp")
1556:                     THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = ALLTRIM(NVL(cursor_4c_OpeTmp.Dopes, ""))
1557:                     USE IN cursor_4c_OpeTmp
1558:                     RETURN
1559:                 ENDIF
1560:                 USE IN cursor_4c_OpeTmp
1561:             ENDIF
1562:             THIS.AbrirBuscaOperacao(loc_cOpe)
1563:         CATCH TO loc_oErro
1564:             MsgErro(loc_oErro.Message, "Erro ValidarNmOperacao")
1565:         ENDTRY
1566:     ENDPROC
1567: 
1568:     *===========================================================================
1569:     * ValidarCdGrupo - Handler KeyPress de txt_4c_Grupo
1570:     * Usa fAcessoContab substituido por SQL direto + FormBuscaAuxiliar
1571:     *===========================================================================
1572:     PROCEDURE ValidarCdGrupo
1573:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1574:         LOCAL loc_nResultado, loc_cSQL, loc_cGrp, loc_oBusca
1575:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1576:             RETURN
1577:         ENDIF
1578:         loc_cGrp = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
1579:         IF par_nKeyCode = 115 OR EMPTY(loc_cGrp)
1580:             THIS.AbrirBuscaGrupoContabil("C", loc_cGrp)
1581:             RETURN
1582:         ENDIF
1583:         TRY
1584:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
1585:                 EscaparSQL(PADR(loc_cGrp, 10))
1586:             IF USED("cursor_4c_GrpTmp")
1587:                 USE IN cursor_4c_GrpTmp
1588:             ENDIF
1589:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
1590:             IF loc_nResultado >= 1
1591:                 SELECT cursor_4c_GrpTmp
1592:                 IF !EOF("cursor_4c_GrpTmp")
1593:                     THIS.cnt_4c_Container1.txt_4c_Grupo.Value    = ALLTRIM(NVL(cursor_4c_GrpTmp.codigos, ""))
1594:                     THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value  = ALLTRIM(NVL(cursor_4c_GrpTmp.descrs, ""))
1595:                     USE IN cursor_4c_GrpTmp
1596:                     RETURN
1597:                 ENDIF
1598:                 USE IN cursor_4c_GrpTmp
1599:             ENDIF
1600:             THIS.AbrirBuscaGrupoContabil("C", loc_cGrp)
1601:         CATCH TO loc_oErro
1602:             MsgErro(loc_oErro.Message, "Erro ValidarCdGrupo")
1603:         ENDTRY
1604:     ENDPROC
1605: 
1606:     *===========================================================================
1607:     * ValidarDsGrupo - Handler KeyPress de txt_4c_DsGrupo
1608:     *===========================================================================
1609:     PROCEDURE ValidarDsGrupo
1610:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1611:         LOCAL loc_nResultado, loc_cSQL, loc_cDs, loc_oBusca
1612:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1613:             RETURN
1614:         ENDIF
1615:         loc_cDs = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value)
1616:         IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
1617:             THIS.AbrirBuscaGrupoContabil("D", loc_cDs)
1618:             RETURN
1619:         ENDIF
1620:         TRY
1621:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(descrs) LIKE " + ;
1622:                 EscaparSQL(loc_cDs + "%")
1623:             IF USED("cursor_4c_GrpTmp")
1624:                 USE IN cursor_4c_GrpTmp
1625:             ENDIF
1626:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
1627:             IF loc_nResultado >= 1
1628:                 SELECT cursor_4c_GrpTmp
1629:                 IF !EOF("cursor_4c_GrpTmp")
1630:                     THIS.cnt_4c_Container1.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_GrpTmp.codigos, ""))
1631:                     THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value = ALLTRIM(NVL(cursor_4c_GrpTmp.descrs, ""))
1632:                     USE IN cursor_4c_GrpTmp
1633:                     RETURN
1634:                 ENDIF
1635:                 USE IN cursor_4c_GrpTmp
1636:             ENDIF
1637:             THIS.AbrirBuscaGrupoContabil("D", loc_cDs)
1638:         CATCH TO loc_oErro
1639:             MsgErro(loc_oErro.Message, "Erro ValidarDsGrupo")
1640:         ENDTRY
1641:     ENDPROC
1642: 
1643:     *===========================================================================
1644:     * AbrirBuscaGrupoContabil - Picker SigCdGcr (codigos/descrs com r)
1645:     *===========================================================================
1646:     PROCEDURE AbrirBuscaGrupoContabil(par_cModo, par_cValor)

*-- Linhas 1669 a 2006:
1669:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1670:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1671:             loc_oBusca.Show()
1672: 
1673:             IF loc_oBusca.this_lSelecionou
1674:                 THIS.cnt_4c_Container1.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_BuscaGcr.codigos, ""))
1675:                 THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value = ALLTRIM(NVL(cursor_4c_BuscaGcr.descrs, ""))
1676:             ENDIF
1677: 
1678:             IF USED("cursor_4c_BuscaGcr")
1679:                 USE IN cursor_4c_BuscaGcr
1680:             ENDIF
1681:         CATCH TO loc_oErro
1682:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrupoContabil")
1683:         ENDTRY
1684:     ENDPROC
1685: 
1686:     *===========================================================================
1687:     * ValidarCdConta - Handler KeyPress de txt_4c_Conta
1688:     *===========================================================================
1689:     PROCEDURE ValidarCdConta
1690:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1691:         LOCAL loc_nResultado, loc_cSQL, loc_cCta, loc_cGrp
1692:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1693:             RETURN
1694:         ENDIF
1695:         loc_cCta = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Conta.Value)
1696:         loc_cGrp = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
1697:         IF par_nKeyCode = 115 OR EMPTY(loc_cCta)
1698:             THIS.AbrirBuscaConta("C", loc_cGrp, loc_cCta)
1699:             RETURN
1700:         ENDIF
1701:         TRY
1702:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE IClis = " + ;
1703:                 EscaparSQL(PADR(loc_cCta, 10))
1704:             IF !EMPTY(loc_cGrp)
1705:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
1706:             ENDIF
1707:             IF USED("cursor_4c_CtaTmp")
1708:                 USE IN cursor_4c_CtaTmp
1709:             ENDIF
1710:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
1711:             IF loc_nResultado >= 1
1712:                 SELECT cursor_4c_CtaTmp
1713:                 IF !EOF("cursor_4c_CtaTmp")
1714:                     THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_CtaTmp.IClis, ""))
1715:                     THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_CtaTmp.RClis, ""))
1716:                     THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_CtaTmp.Cpfs, ""))
1717:                     USE IN cursor_4c_CtaTmp
1718:                     RETURN
1719:                 ENDIF
1720:                 USE IN cursor_4c_CtaTmp
1721:             ENDIF
1722:             THIS.AbrirBuscaConta("C", loc_cGrp, loc_cCta)
1723:         CATCH TO loc_oErro
1724:             MsgErro(loc_oErro.Message, "Erro ValidarCdConta")
1725:         ENDTRY
1726:     ENDPROC
1727: 
1728:     *===========================================================================
1729:     * ValidarDsConta - Handler KeyPress de txt_4c_DsConta
1730:     *===========================================================================
1731:     PROCEDURE ValidarDsConta
1732:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1733:         LOCAL loc_nResultado, loc_cSQL, loc_cDs, loc_cGrp
1734:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1735:             RETURN
1736:         ENDIF
1737:         loc_cDs  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsConta.Value)
1738:         loc_cGrp = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
1739:         IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
1740:             THIS.AbrirBuscaConta("D", loc_cGrp, loc_cDs)
1741:             RETURN
1742:         ENDIF
1743:         TRY
1744:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1745:                 EscaparSQL(loc_cDs + "%")
1746:             IF !EMPTY(loc_cGrp)
1747:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
1748:             ENDIF
1749:             IF USED("cursor_4c_CtaTmp")
1750:                 USE IN cursor_4c_CtaTmp
1751:             ENDIF
1752:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
1753:             IF loc_nResultado >= 1
1754:                 SELECT cursor_4c_CtaTmp
1755:                 IF !EOF("cursor_4c_CtaTmp")
1756:                     THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_CtaTmp.IClis, ""))
1757:                     THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_CtaTmp.RClis, ""))
1758:                     THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_CtaTmp.Cpfs, ""))
1759:                     USE IN cursor_4c_CtaTmp
1760:                     RETURN
1761:                 ENDIF
1762:                 USE IN cursor_4c_CtaTmp
1763:             ENDIF
1764:             THIS.AbrirBuscaConta("D", loc_cGrp, loc_cDs)
1765:         CATCH TO loc_oErro
1766:             MsgErro(loc_oErro.Message, "Erro ValidarDsConta")
1767:         ENDTRY
1768:     ENDPROC
1769: 
1770:     *===========================================================================
1771:     * ValidarCpf - Handler KeyPress de txt_4c_Cpf
1772:     * Valida CPF/CNPJ e popula txt_4c_Conta/txt_4c_DsConta
1773:     *===========================================================================
1774:     PROCEDURE ValidarCpf
1775:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1776:         LOCAL loc_oCpfRet, loc_cCpf
1777:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1778:             RETURN
1779:         ENDIF
1780:         loc_cCpf = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Cpf.Value)
1781:         IF EMPTY(loc_cCpf)
1782:             THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ""
1783:             THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ""
1784:             RETURN
1785:         ENDIF
1786:         TRY
1787:             loc_oCpfRet = THIS.this_oBusinessObject.ValidarCpfCnpj(loc_cCpf)
1788:             IF !loc_oCpfRet.lValido
1789:                 IF !EMPTY(loc_oCpfRet.cErro)
1790:                     MsgAviso(loc_oCpfRet.cErro, "Aviso")
1791:                     THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ""
1792:                     THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ""
1793:                     THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ""
1794:                 ENDIF
1795:                 RETURN
1796:             ENDIF
1797:             IF !EMPTY(loc_oCpfRet.cConta)
1798:                 THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(loc_oCpfRet.cConta)
1799:                 THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(loc_oCpfRet.cDsConta)
1800:                 THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(loc_oCpfRet.cCpf)
1801:             ENDIF
1802:         CATCH TO loc_oErro
1803:             MsgErro(loc_oErro.Message, "Erro ValidarCpf")
1804:         ENDTRY
1805:     ENDPROC
1806: 
1807:     *===========================================================================
1808:     * ValidarCdResps - Handler KeyPress de txt_4c_Resps
1809:     *===========================================================================
1810:     PROCEDURE ValidarCdResps
1811:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1812:         LOCAL loc_nResultado, loc_cSQL, loc_cCod, loc_cGrpPad
1813:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1814:             RETURN
1815:         ENDIF
1816:         loc_cCod    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Resps.Value)
1817:         loc_cGrpPad = IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
1818:                           ALLTRIM(THIS.this_oBusinessObject.this_cGrPadVens), "")
1819:         IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
1820:             THIS.AbrirBuscaResponsavel("C", loc_cCod)
1821:             RETURN
1822:         ENDIF
1823:         TRY
1824:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1825:                 EscaparSQL(PADR(loc_cCod, 10))
1826:             IF !EMPTY(loc_cGrpPad)
1827:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrpPad, 10))
1828:             ENDIF
1829:             IF USED("cursor_4c_RespTmp")
1830:                 USE IN cursor_4c_RespTmp
1831:             ENDIF
1832:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespTmp")
1833:             IF loc_nResultado >= 1
1834:                 SELECT cursor_4c_RespTmp
1835:                 IF !EOF("cursor_4c_RespTmp")
1836:                     THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_RespTmp.IClis, ""))
1837:                     THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_RespTmp.RClis, ""))
1838:                     USE IN cursor_4c_RespTmp
1839:                     RETURN
1840:                 ENDIF
1841:                 USE IN cursor_4c_RespTmp
1842:             ENDIF
1843:             THIS.AbrirBuscaResponsavel("C", loc_cCod)
1844:         CATCH TO loc_oErro
1845:             MsgErro(loc_oErro.Message, "Erro ValidarCdResps")
1846:         ENDTRY
1847:     ENDPROC
1848: 
1849:     *===========================================================================
1850:     * ValidarDsResps - Handler KeyPress de txt_4c_DsResps
1851:     *===========================================================================
1852:     PROCEDURE ValidarDsResps
1853:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1854:         LOCAL loc_nResultado, loc_cSQL, loc_cDs, loc_cGrpPad
1855:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1856:             RETURN
1857:         ENDIF
1858:         loc_cDs     = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsResps.Value)
1859:         loc_cGrpPad = IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
1860:                           ALLTRIM(THIS.this_oBusinessObject.this_cGrPadVens), "")
1861:         IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
1862:             THIS.AbrirBuscaResponsavel("D", loc_cDs)
1863:             RETURN
1864:         ENDIF
1865:         TRY
1866:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1867:                 EscaparSQL(loc_cDs + "%")
1868:             IF !EMPTY(loc_cGrpPad)
1869:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrpPad, 10))
1870:             ENDIF
1871:             IF USED("cursor_4c_RespTmp")
1872:                 USE IN cursor_4c_RespTmp
1873:             ENDIF
1874:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespTmp")
1875:             IF loc_nResultado >= 1
1876:                 SELECT cursor_4c_RespTmp
1877:                 IF !EOF("cursor_4c_RespTmp")
1878:                     THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_RespTmp.IClis, ""))
1879:                     THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_RespTmp.RClis, ""))
1880:                     USE IN cursor_4c_RespTmp
1881:                     RETURN
1882:                 ENDIF
1883:                 USE IN cursor_4c_RespTmp
1884:             ENDIF
1885:             THIS.AbrirBuscaResponsavel("D", loc_cDs)
1886:         CATCH TO loc_oErro
1887:             MsgErro(loc_oErro.Message, "Erro ValidarDsResps")
1888:         ENDTRY
1889:     ENDPROC
1890: 
1891:     *===========================================================================
1892:     * ValidarCdMoeda - Handler KeyPress de txt_4c_CdMoeda
1893:     *===========================================================================
1894:     PROCEDURE ValidarCdMoeda
1895:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1896:         LOCAL loc_nResultado, loc_cSQL, loc_cCod
1897:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1898:             RETURN
1899:         ENDIF
1900:         loc_cCod = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value)
1901:         IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
1902:             THIS.AbrirBuscaMoeda("C", loc_cCod)
1903:             RETURN
1904:         ENDIF
1905:         TRY
1906:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cCod)
1907:             IF USED("cursor_4c_MoeTmp")
1908:                 USE IN cursor_4c_MoeTmp
1909:             ENDIF
1910:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeTmp")
1911:             IF loc_nResultado >= 1
1912:                 SELECT cursor_4c_MoeTmp
1913:                 IF !EOF("cursor_4c_MoeTmp")
1914:                     THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.CMoes, ""))
1915:                     THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.DMoes, ""))
1916:                     USE IN cursor_4c_MoeTmp
1917:                     RETURN
1918:                 ENDIF
1919:                 USE IN cursor_4c_MoeTmp
1920:             ENDIF
1921:             THIS.AbrirBuscaMoeda("C", loc_cCod)
1922:         CATCH TO loc_oErro
1923:             MsgErro(loc_oErro.Message, "Erro ValidarCdMoeda")
1924:         ENDTRY
1925:     ENDPROC
1926: 
1927:     *===========================================================================
1928:     * ValidarDsMoeda - Handler KeyPress de txt_4c_DsMoeda
1929:     *===========================================================================
1930:     PROCEDURE ValidarDsMoeda
1931:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1932:         LOCAL loc_nResultado, loc_cSQL, loc_cDs
1933:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1934:             RETURN
1935:         ENDIF
1936:         loc_cDs = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value)
1937:         IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
1938:             THIS.AbrirBuscaMoeda("D", loc_cDs)
1939:             RETURN
1940:         ENDIF
1941:         TRY
1942:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE RTRIM(DMoes) LIKE " + ;
1943:                 EscaparSQL(loc_cDs + "%")
1944:             IF USED("cursor_4c_MoeTmp")
1945:                 USE IN cursor_4c_MoeTmp
1946:             ENDIF
1947:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeTmp")
1948:             IF loc_nResultado >= 1
1949:                 SELECT cursor_4c_MoeTmp
1950:                 IF !EOF("cursor_4c_MoeTmp")
1951:                     THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.CMoes, ""))
1952:                     THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.DMoes, ""))
1953:                     USE IN cursor_4c_MoeTmp
1954:                     RETURN
1955:                 ENDIF
1956:                 USE IN cursor_4c_MoeTmp
1957:             ENDIF
1958:             THIS.AbrirBuscaMoeda("D", loc_cDs)
1959:         CATCH TO loc_oErro
1960:             MsgErro(loc_oErro.Message, "Erro ValidarDsMoeda")
1961:         ENDTRY
1962:     ENDPROC
1963: 
1964:     *===========================================================================
1965:     * ConfigurarBindEvents - Liga eventos de lookup aos campos
1966:     * Chamado ao final de InicializarForm apos TornarControlesVisiveis
1967:     *===========================================================================
1968:     PROCEDURE ConfigurarBindEvents()
1969:         LOCAL loc_oCnt
1970:         loc_oCnt = THIS.cnt_4c_Container1
1971: 
1972:         BINDEVENT(loc_oCnt.txt_4c_CdEmpresa,  "KeyPress", THIS, "ValidarCdEmpresa")
1973:         BINDEVENT(loc_oCnt.txt_4c_DsEmpresa,  "KeyPress", THIS, "ValidarDsEmpresa")
1974:         BINDEVENT(loc_oCnt.txt_4c_NmOperacao, "KeyPress", THIS, "ValidarNmOperacao")
1975:         BINDEVENT(loc_oCnt.txt_4c_Grupo,      "KeyPress", THIS, "ValidarCdGrupo")
1976:         BINDEVENT(loc_oCnt.txt_4c_DsGrupo,    "KeyPress", THIS, "ValidarDsGrupo")
1977:         BINDEVENT(loc_oCnt.txt_4c_Conta,      "KeyPress", THIS, "ValidarCdConta")
1978:         BINDEVENT(loc_oCnt.txt_4c_DsConta,    "KeyPress", THIS, "ValidarDsConta")
1979:         BINDEVENT(loc_oCnt.txt_4c_Cpf,        "KeyPress", THIS, "ValidarCpf")
1980:         BINDEVENT(loc_oCnt.txt_4c_Resps,      "KeyPress", THIS, "ValidarCdResps")
1981:         BINDEVENT(loc_oCnt.txt_4c_DsResps,    "KeyPress", THIS, "ValidarDsResps")
1982:         BINDEVENT(loc_oCnt.txt_4c_CdMoeda,    "KeyPress", THIS, "ValidarCdMoeda")
1983:         BINDEVENT(loc_oCnt.txt_4c_DsMoeda,    "KeyPress", THIS, "ValidarDsMoeda")
1984:     ENDPROC
1985: 
1986:     *===========================================================================
1987:     * LimparCampos - Restaura todos os filtros para o estado inicial
1988:     * Chamado quando o usuario quer limpar o formulario de filtros
1989:     *===========================================================================
1990:     PROCEDURE LimparCampos()
1991:         WITH THIS.cnt_4c_Container1
1992:             .txt_4c_NmOperacao.Value  = ""
1993:             .txt_4c_DtInicial.Value   = DATE()
1994:             .txt_4c_DtFinal.Value     = DATE()
1995:             .txt_4c_Grupo.Value       = SPACE(10)
1996:             .txt_4c_DsGrupo.Value     = SPACE(20)
1997:             .txt_4c_Conta.Value       = SPACE(10)
1998:             .txt_4c_DsConta.Value     = SPACE(40)
1999:             .txt_4c_CdMoeda.Value     = " "
2000:             .txt_4c_DsMoeda.Value     = ""
2001:             .txt_4c_Resps.Value       = ""
2002:             .txt_4c_DsResps.Value     = ""
2003:             .txt_4c_Cpf.Value         = ""
2004:             .txt_4c_Numero.Value      = 0
2005:             .txt_4c_Op.Value          = 0
2006:             .txt_4c_PStatus.Value     = ""

*-- Linhas 2025 a 2045:
2025:     * Form OPERACIONAL: todos os campos de filtro sempre habilitados
2026:     *===========================================================================
2027:     PROCEDURE HabilitarCampos(par_lHabilitar)
2028:         LOCAL loc_lHab
2029:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2030:         WITH THIS.cnt_4c_Container1
2031:             .txt_4c_CdEmpresa.Enabled  = loc_lHab
2032:             .txt_4c_DsEmpresa.Enabled  = loc_lHab
2033:             .chk_4c_EmpD.Enabled       = loc_lHab
2034:             .txt_4c_NmOperacao.Enabled = loc_lHab
2035:             .txt_4c_Numero.Enabled     = loc_lHab
2036:             .txt_4c_Op.Enabled         = loc_lHab
2037:             .txt_4c_PStatus.Enabled    = loc_lHab
2038:             .txt_4c_DtInicial.Enabled  = loc_lHab
2039:             .txt_4c_DtFinal.Enabled    = loc_lHab
2040:             .obj_4c_OptPeriodo.Enabled = loc_lHab
2041:             .txt_4c_Grupo.Enabled      = loc_lHab
2042:             .txt_4c_DsGrupo.Enabled    = loc_lHab
2043:             .txt_4c_Conta.Enabled      = loc_lHab
2044:             .txt_4c_DsConta.Enabled    = loc_lHab
2045:             .txt_4c_Cpf.Enabled        = loc_lHab


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de BusinessBase
* Form OPERACIONAL - consulta/filtro de movimentacoes em SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Empresa
    this_cEmpresa      = ""
    this_cDsEmpresa    = ""
    this_nEmpD         = 0

    *-- Operacao / Movimentacao
    this_cNmOperacao   = ""
    this_nNumero       = 0
    this_nOp           = 0

    *-- Periodo
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nPeriodo      = 1

    *-- Grupo contabil
    this_cGrupo        = ""
    this_cDsGrupo      = ""

    *-- Conta
    this_cConta        = ""
    this_cDsConta      = ""

    *-- CPF/CNPJ
    this_cCpf          = ""

    *-- Responsavel / Vendedor
    this_cResps        = ""
    this_cDsResps      = ""

    *-- Moeda
    this_cMoeda        = ""
    this_cDsMoeda      = ""

    *-- Opcoes de filtro
    this_nSituacao     = 3
    this_nImpressao    = 1
    this_nCotacao      = 1
    this_cStatus       = ""

    *-- Grupo padrao de vendedores (SigCdPam.grpadvens) - carregado em Init
    this_cGrPadVens    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.CarregarGrPadVens()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrPadVens - Carrega o grupo padrao de vendedores de SigCdPam
    * Necessario para validacao de Responsavel via fAcessoContab
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrPadVens()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens AS GrPadVens FROM SigCdPam"

            IF USED("cursor_4c_ParamPam")
                USE IN cursor_4c_ParamPam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamPam")

            IF loc_nResultado >= 1
                SELECT cursor_4c_ParamPam
                GO TOP
                IF !EOF("cursor_4c_ParamPam")
                    THIS.this_cGrPadVens = NVL(cursor_4c_ParamPam.GrPadVens, "")
                    loc_lResultado = .T.
                ENDIF
                USE IN cursor_4c_ParamPam
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de executar consulta
    * Retorna .T. se valido; popula this_cMensagemErro se invalido
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cNmOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                    "Data Final Menor do Que a Inicial!!!"
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - Executa a consulta principal contra SigMvCab
    * Cria cursor csTemporario com resultados indexados
    * Retorna .T. se encontrou registros, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ExecutarConsulta()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResultado
        LOCAL loc_cEmp, loc_cNmO, loc_cGrupo, loc_cConta, loc_cResps, loc_cSta
        LOCAL loc_nEmpD, loc_nNrP, loc_nPen, loc_nOp, loc_nNum
        LOCAL loc_dDtI, loc_dDtF, loc_cDtISQL, loc_cDtFSQL, loc_cEmpFilter

        loc_lResultado = .F.

        TRY
            loc_cEmp    = ALLTRIM(THIS.this_cEmpresa)
            loc_cNmO    = ALLTRIM(THIS.this_cNmOperacao)
            loc_cGrupo  = ALLTRIM(THIS.this_cGrupo)
            loc_cConta  = ALLTRIM(THIS.this_cConta)
            loc_cResps  = ALLTRIM(THIS.this_cResps)
            loc_cSta    = ALLTRIM(THIS.this_cStatus)
            loc_nEmpD   = THIS.this_nEmpD
            loc_nNrP    = THIS.this_nPeriodo
            loc_nPen    = THIS.this_nSituacao
            loc_nOp     = THIS.this_nOp
            loc_nNum    = THIS.this_nNumero
            loc_dDtI    = THIS.this_dDtInicial
            loc_dDtF    = THIS.this_dDtFinal

            *-- Formata datas para SQL Server (com componente de hora)
            loc_cDtISQL = "'" + PADL(YEAR(loc_dDtI), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtI), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtI), 2, "0") + " 00:00:00'"
            loc_cDtFSQL = "'" + PADL(YEAR(loc_dDtF), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF), 2, "0") + " 23:59:59'"

            *-- Monta WHERE replicando logica de consulta.Click do legado
            loc_cWhere = ""

            IF !EMPTY(loc_cNmO)
                loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(loc_cNmO) + " And "
            ENDIF

            IF loc_nNrP = 1
                loc_cWhere = loc_cWhere + "a.Datas "
            ELSE
                loc_cWhere = loc_cWhere + "a.PrazoEnts "
            ENDIF
            loc_cWhere = loc_cWhere + "BetWeen " + loc_cDtISQL + " And " + loc_cDtFSQL + " And "

            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
                    " Or a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ") And "
            ENDIF

            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(loc_cConta) + ;
                    " Or a.ContaDs = " + EscaparSQL(loc_cConta) + ") And "
            ENDIF

            IF loc_nOp > 0
                loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(loc_nOp, 0) + " And "
            ENDIF

            IF loc_nNum > 0
                loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(loc_nNum, 0) + " And "
            ENDIF

            IF !EMPTY(loc_cResps)
                loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(loc_cResps) + " And "
            ENDIF

            DO CASE
                CASE loc_nPen = 1
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
                CASE loc_nPen = 2
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
            ENDCASE

            IF !EMPTY(loc_cSta)
                loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(loc_cSta) + " And "
            ENDIF

            *-- Filtro de empresa (com empresa destino opcional)
            loc_cEmpFilter = "(a.Emps = " + EscaparSQL(loc_cEmp)
            IF loc_nEmpD != 0
                loc_cEmpFilter = loc_cEmpFilter + " Or a.Empds = " + EscaparSQL(loc_cEmp)
            ENDIF
            loc_cEmpFilter = loc_cEmpFilter + ")"

            loc_cSQL = "Select a.* " + ;
                "From SigMvCab a, SigCdOpe b " + ;
                "Where " + loc_cEmpFilter + " And " + ;
                loc_cWhere + ;
                "a.Dopes = b.Dopes"

            IF USED("csTemporario")
                USE IN csTemporario
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "csTemporario")

            IF loc_nResultado >= 1
                SELECT csTemporario
                IF RECCOUNT("csTemporario") > 0
                    INDEX ON EmpDopNums TAG EmpDopNums
                    *-- Corrige PrazoEnts NULL (replica Update Set PrazoEnts = Iif(IsNull,Ctod(''),PrazoEnts))
                    REPLACE ALL prazoents WITH IIF(ISNULL(prazoents), CTOD(""), prazoents) IN csTemporario
                    GO TOP IN csTemporario
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum Registro Selecionado!!!"
                    USE IN csTemporario
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao executar consulta (csTemporario)"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCpfPorConta - Carrega CPF do cliente pelo codigo da conta (iclis)
    * Retorna o CPF (string) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarCpfPorConta(par_cConta)
        LOCAL loc_cCpf, loc_cSQL, loc_nResultado
        loc_cCpf = ""

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN ""
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Cpfs FROM SigCdCli " + ;
                "WHERE iClis = " + EscaparSQL(PADR(ALLTRIM(par_cConta), 10))

            IF USED("cursor_4c_CpfCli")
                USE IN cursor_4c_CpfCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfCli")

            IF loc_nResultado >= 1
                SELECT cursor_4c_CpfCli
                IF !EOF("cursor_4c_CpfCli")
                    loc_cCpf = NVL(cursor_4c_CpfCli.Cpfs, "")
                ENDIF
                USE IN cursor_4c_CpfCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cCpf
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCpfCnpj - Valida CPF/CNPJ e localiza conta vinculada em SigCdCli
    * Retorna objeto Empty com: lValido, cConta, cDsConta, cCpf, cErro
    * Replica logica de Get_cpf.Valid do legado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCpfCnpj(par_cCpfCnpj)
        LOCAL loc_oRet, loc_cCgc, loc_cCgc1, loc_nLen, loc_nVerCpfCgc, loc_nResultado

        loc_oRet = CREATEOBJECT("Empty")
        ADDPROPERTY(loc_oRet, "lValido",  .F.)
        ADDPROPERTY(loc_oRet, "cConta",   "")
        ADDPROPERTY(loc_oRet, "cDsConta", "")
        ADDPROPERTY(loc_oRet, "cCpf",     "")
        ADDPROPERTY(loc_oRet, "cErro",    "")

        IF EMPTY(ALLTRIM(par_cCpfCnpj))
            loc_oRet.lValido = .T.
            RETURN loc_oRet
        ENDIF

        loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(par_cCpfCnpj), ".", ""), "-", ""), "/", "")
        loc_nLen = LEN(ALLTRIM(loc_cCgc))
        loc_nVerCpfCgc = 0

        IF loc_nLen <> 14
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 999.999.999-99")
            IF loc_nLen = 11
                loc_nVerCpfCgc = IIF(ValidarCPF(loc_cCgc1), 1, 2)
            ENDIF
        ELSE
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99")
            loc_nVerCpfCgc = IIF(ValidarCNPJ(loc_cCgc1), 1, 2)
        ENDIF

        IF loc_nVerCpfCgc = 2
            loc_oRet.cErro = "CPF / CGC Incorreto !!!"
            RETURN loc_oRet
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 iclis, rclis, cpfs FROM SigCdCli " + ;
                "WHERE cpfs = " + EscaparSQL(PADR(ALLTRIM(loc_cCgc1), 20))

            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")

            IF loc_nResultado >= 1
                SELECT cursor_4c_BuscaCpf
                IF !EOF("cursor_4c_BuscaCpf")
                    loc_oRet.cConta   = NVL(cursor_4c_BuscaCpf.iclis, "")
                    loc_oRet.cDsConta = NVL(cursor_4c_BuscaCpf.rclis, "")
                    loc_oRet.cCpf     = NVL(cursor_4c_BuscaCpf.cpfs, "")
                    loc_oRet.lValido  = .T.
                ELSE
                    IF loc_nVerCpfCgc = 1
                        loc_oRet.cErro = "CPF / CGC n" + CHR(227) + "o encontrado !!!"
                    ELSE
                        loc_oRet.lValido = .T.
                    ENDIF
                ENDIF
                USE IN cursor_4c_BuscaCpf
            ELSE
                loc_oRet.cErro = "Falha ao buscar CPF/CGC em SigCdCli"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oRet.cErro = loc_oErro.Message
        ENDTRY

        RETURN loc_oRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de SigMvCab (Emps + Dopes + Nums)
    * Usada em RegistrarAuditoria para log de consulta/operacoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpresa) + "|" + ;
               ALLTRIM(THIS.this_cNmOperacao) + "|" + ;
               ALLTRIM(TRANSFORM(THIS.this_nNumero))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega chave e campos principais de SigMvCab
    * a partir da linha corrente do cursor (usado quando usuario seleciona
    * uma movimentacao no grid de resultados de ExecutarConsulta)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cEmpresa    = TratarNulo(emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".empds") != "U"
                THIS.this_nEmpD       = IIF(NVL(empds, "") != THIS.this_cEmpresa AND !EMPTY(NVL(empds, "")), 1, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = TratarNulo(dopes, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp         = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero     = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupos") != "U"
                THIS.this_cGrupo      = TratarNulo(grupos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".iclis") != "U"
                THIS.this_cConta      = TratarNulo(iclis, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps      = TratarNulo(vends, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial  = TratarNulo(datas, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".prazoents") != "U"
                THIS.this_dDtFinal    = TratarNulo(prazoents, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cStatus     = TratarNulo(pstatus, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                THIS.this_nSituacao   = IIF(NVL(chksubn, .F.), 2, 1)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEs1BO.CarregarDoCursor")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a form OPERACIONAL de consulta
    * SigPrEs1 (Posicao Por Movimentacao) apenas LE registros de SigMvCab
    * atraves de ExecutarConsulta. Inclusao de movimentacoes ocorre nos
    * forms de entrada de operacao (SigMvCab tem forms proprios de CRUD).
    * Metodo mantido para conformidade com contrato BusinessBase; sempre
    * retorna .F. com mensagem clara para prevenir uso indevido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para incluir movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a form OPERACIONAL de consulta
    * Mesma razao de Inserir(): SigPrEs1 apenas consulta SigMvCab.
    * Atualizacoes ocorrem nos forms de operacao correspondentes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para atualizar movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra em LogAuditoria a consulta executada
    * Sobrescreve BusinessBase para logar operacao "CONSULTA" com filtros
    * aplicados (empresa, operacao, periodo). DataHora usa GETDATE() (regra
    * canonica - GETDATE() rejeita tipo T).
    *--------------------------------------------------------------------------
    FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cUsuario, loc_cDetalhes
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                              ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")
            loc_cChave = THIS.ObterChavePrimaria()

            loc_cDetalhes = "Empresa=" + ALLTRIM(THIS.this_cEmpresa) + ;
                "; Operacao=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                "; Periodo=" + DTOC(THIS.this_dDtInicial) + ".." + DTOC(THIS.this_dDtFinal)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
                "VALUES (" + ;
                EscaparSQL("SigPrEs1") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(loc_cDetalhes) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe operacao principal
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

