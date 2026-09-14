# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehtc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1267 linhas total):

*-- Linhas 60 a 68:
60:                 THIS.this_oRelatorio.BuscarContas()
61:                 THIS.ConfigurarPageFrame()
62:                 THIS.ConfigurarCabecalho()
63:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.ConfigurarPaginaLista()
66:                 THIS.LimparCampos()
67: 
68:                 THIS.Visible = .T.

*-- Linhas 80 a 88:
80:     * CONFIGURARPAGEFRAME - Aplica propriedades de janela do form de relatorio
81:     *==========================================================================
82:     PROTECTED PROCEDURE ConfigurarPageFrame()
83:         THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques Emitidos"
84:         THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
85:         THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
86:         THIS.AutoCenter  = .T.
87:         THIS.BorderStyle = 2
88:         THIS.WindowType  = 1

*-- Linhas 102 a 145:
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH THIS.cnt_4c_Cabecalho
105:             .Top       = 0
106:             .Left      = 0
107:             .Width     = THIS.Width
108:             .Height    = 80
109:             .BackStyle = 1
110:             .BackColor = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible   = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Top       = 15
117:                 .Left      = 12
118:                 .Width     = THIS.Width
119:                 .Height    = 40
120:                 .FontName  = "Tahoma"
121:                 .FontSize  = 16
122:                 .FontBold  = .T.
123:                 .BackStyle = 0
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .Caption   = THIS.Caption
126:                 .Visible   = .T.
127:             ENDWITH
128: 
129:             .AddObject("lbl_4c_Titulo", "Label")
130:             WITH .lbl_4c_Titulo
131:                 .Top       = 18
132:                 .Left      = 10
133:                 .Width     = THIS.Width
134:                 .Height    = 40
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 16
137:                 .FontBold  = .T.
138:                 .BackStyle = 0
139:                 .ForeColor = RGB(255, 255, 255)
140:                 .Caption   = THIS.Caption
141:                 .Visible   = .T.
142:             ENDWITH
143:         ENDWITH
144:     ENDPROC
145: 

*-- Linhas 159 a 194:
159: 
160:     *==========================================================================
161:     * CONFIGURARBOTOES - CommandGroup com 4 botoes (frmrelatorio canonical)
162:     * Left=529 (original btnReport.Left=530), Width=273, Height=80, Top=0
163:     * Geometria canonical: ButtonCount=4, BackStyle=0, BorderStyle=0
164:     * BINDEVENTs adicionados na Fase 7
165:     *==========================================================================
166:     PROTECTED PROCEDURE ConfigurarBotoes()
167:         LOCAL loc_cIcones
168:         loc_cIcones = gc_4c_CaminhoIcones
169: 
170:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
171:         WITH THIS.cmg_4c_Botoes
172:             .Top           = 0
173:             .Left          = 529
174:             .Width         = 273
175:             .Height        = 80
176:             .ButtonCount   = 4
177:             .BackStyle     = 0
178:             .BorderStyle   = 0
179:             .BorderColor   = RGB(136, 189, 188)
180:             .SpecialEffect = 1
181:             .Themes        = .F.
182:             .Visible       = .T.
183: 
184:             WITH .Buttons(1)
185:                 .Top             = 5
186:                 .Left            = 5
187:                 .Width           = 65
188:                 .Height          = 70
189:                 .Caption         = "Visualizar"
190:                 .Picture         = loc_cIcones + "ideo.jpg"
191:                 .FontBold        = .T.
192:                 .FontItalic      = .T.
193:                 .BackColor       = RGB(255, 255, 255)
194:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 200 a 255:
200:             ENDWITH
201: 
202:             WITH .Buttons(2)
203:                 .Top             = 5
204:                 .Left            = 71
205:                 .Width           = 65
206:                 .Height          = 70
207:                 .Caption         = "Imprimir"
208:                 .Picture         = loc_cIcones + "impressora.jpg"
209:                 .FontName        = "Comic Sans MS"
210:                 .FontBold        = .T.
211:                 .FontItalic      = .T.
212:                 .FontSize        = 8
213:                 .BackColor       = RGB(255, 255, 255)
214:                 .ForeColor       = RGB(90, 90, 90)
215:                 .PicturePosition = 13
216:                 .SpecialEffect   = 0
217:                 .MousePointer    = 15
218:                 .Themes          = .F.
219:                 .WordWrap        = .T.
220:             ENDWITH
221: 
222:             WITH .Buttons(3)
223:                 .Top             = 5
224:                 .Left            = 137
225:                 .Width           = 65
226:                 .Height          = 70
227:                 .Caption         = "Excel"
228:                 .Picture         = loc_cIcones + "excel.jpg"
229:                 .FontName        = "Comic Sans MS"
230:                 .FontBold        = .T.
231:                 .FontItalic      = .T.
232:                 .FontSize        = 8
233:                 .BackColor       = RGB(255, 255, 255)
234:                 .ForeColor       = RGB(90, 90, 90)
235:                 .PicturePosition = 13
236:                 .SpecialEffect   = 0
237:                 .MousePointer    = 15
238:                 .Themes          = .F.
239:                 .WordWrap        = .T.
240:             ENDWITH
241: 
242:             WITH .Buttons(4)
243:                 .Top             = 5
244:                 .Left            = 203
245:                 .Width           = 65
246:                 .Height          = 70
247:                 .Caption         = "Sair"
248:                 .Picture         = loc_cIcones + "otao_encerrar.jpg"
249:                 .FontName        = "Comic Sans MS"
250:                 .FontBold        = .T.
251:                 .FontItalic      = .T.
252:                 .FontSize        = 8
253:                 .BackColor       = RGB(255, 255, 255)
254:                 .ForeColor       = RGB(90, 90, 90)
255:                 .PicturePosition = 13

*-- Linhas 277 a 367:
277:     PROTECTED PROCEDURE ConfigurarPaginaDados()
278: 
279:         *-- Label: Grupo
280:         THIS.AddObject("lbl_4c_Label3", "Label")
281:         WITH THIS.lbl_4c_Label3
282:             .AutoSize  = .T.
283:             .FontName  = "Tahoma"
284:             .FontSize  = 8
285:             .Caption   = "Grupo :"
286:             .Left      = 211
287:             .Top       = 101
288:             .Width     = 38
289:             .ForeColor = RGB(90, 90, 90)
290:             .BackStyle = 0
291:             .Visible   = .T.
292:         ENDWITH
293: 
294:         *-- Label: Conta
295:         THIS.AddObject("lbl_4c_Label4", "Label")
296:         WITH THIS.lbl_4c_Label4
297:             .AutoSize  = .T.
298:             .FontName  = "Tahoma"
299:             .FontSize  = 8
300:             .Caption   = "Conta :"
301:             .Left      = 211
302:             .Top       = 128
303:             .Width     = 38
304:             .ForeColor = RGB(90, 90, 90)
305:             .BackStyle = 0
306:             .Visible   = .T.
307:         ENDWITH
308: 
309:         *-- Label: Periodo
310:         THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
311:         WITH THIS.lbl_4c_Lbl_periodo
312:             .AutoSize  = .T.
313:             .FontName  = "Tahoma"
314:             .FontSize  = 8
315:             .Caption   = "Per" + CHR(237) + "odo  :"
316:             .Left      = 201
317:             .Top       = 154
318:             .Width     = 48
319:             .ForeColor = RGB(90, 90, 90)
320:             .BackStyle = 0
321:             .Visible   = .T.
322:         ENDWITH
323: 
324:         *-- Label: separador "a" entre datas (azul)
325:         THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
326:         WITH THIS.lbl_4c_Lbl_periodo_a
327:             .AutoSize  = .T.
328:             .FontName  = "Verdana"
329:             .FontSize  = 8
330:             .Caption   = CHR(224)
331:             .Left      = 338
332:             .Top       = 153
333:             .Width     = 9
334:             .ForeColor = RGB(36, 84, 155)
335:             .BackStyle = 0
336:             .Visible   = .T.
337:         ENDWITH
338: 
339:         *-- Label: Ordem
340:         THIS.AddObject("lbl_4c_Label1", "Label")
341:         WITH THIS.lbl_4c_Label1
342:             .AutoSize  = .T.
343:             .FontName  = "Tahoma"
344:             .FontSize  = 8
345:             .Caption   = "Ordem :"
346:             .Left      = 208
347:             .Top       = 177
348:             .Width     = 41
349:             .ForeColor = RGB(90, 90, 90)
350:             .BackStyle = 0
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- Label: Imprime Baixadas
355:         THIS.AddObject("lbl_4c_Label2", "Label")
356:         WITH THIS.lbl_4c_Label2
357:             .AutoSize  = .T.
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .Caption   = "Imprime Baixadas :"
361:             .Left      = 156
362:             .Top       = 245
363:             .Width     = 93
364:             .ForeColor = RGB(90, 90, 90)
365:             .BackStyle = 0
366:             .Visible   = .T.
367:         ENDWITH

*-- Linhas 373 a 384:
373:             .BorderStyle   = 1
374:             .Format        = "K"
375:             .Height        = 25
376:             .Left          = 254
377:             .MaxLength     = 10
378:             .SpecialEffect = 1
379:             .Top           = 96
380:             .Width         = 80
381:             .ForeColor     = RGB(0, 0, 0)
382:             .Value         = ""
383:             .Visible       = .T.
384:         ENDWITH

*-- Linhas 390 a 401:
390:             .BorderStyle   = 1
391:             .Format        = "K"
392:             .Height        = 25
393:             .Left          = 336
394:             .MaxLength     = 20
395:             .SpecialEffect = 1
396:             .Top           = 96
397:             .Width         = 150
398:             .ForeColor     = RGB(0, 0, 0)
399:             .Value         = ""
400:             .Visible       = .T.
401:         ENDWITH

*-- Linhas 407 a 418:
407:             .BorderStyle   = 1
408:             .Format        = "K"
409:             .Height        = 25
410:             .Left          = 254
411:             .MaxLength     = 10
412:             .SpecialEffect = 1
413:             .Top           = 123
414:             .Width         = 80
415:             .ForeColor     = RGB(0, 0, 0)
416:             .Value         = ""
417:             .Visible       = .T.
418:         ENDWITH

*-- Linhas 424 a 730:
424:             .BorderStyle   = 1
425:             .Format        = "K"
426:             .Height        = 25
427:             .Left          = 336
428:             .MaxLength     = 50
429:             .SpecialEffect = 1
430:             .Top           = 123
431:             .Width         = 345
432:             .ForeColor     = RGB(0, 0, 0)
433:             .Value         = ""
434:             .Visible       = .T.
435:         ENDWITH
436: 
437:         *-- TextBox: Data Inicial
438:         THIS.AddObject("txt_4c__dt_inicial", "TextBox")
439:         WITH THIS.txt_4c__dt_inicial
440:             .FontName      = "Tahoma"
441:             .BorderStyle   = 1
442:             .Height        = 25
443:             .Left          = 254
444:             .MaxLength     = 10
445:             .SpecialEffect = 1
446:             .Top           = 150
447:             .Width         = 80
448:             .ForeColor     = RGB(0, 0, 0)
449:             .Value         = {}
450:             .Visible       = .T.
451:         ENDWITH
452: 
453:         *-- TextBox: Data Final
454:         THIS.AddObject("txt_4c__dt_final", "TextBox")
455:         WITH THIS.txt_4c__dt_final
456:             .FontName      = "Tahoma"
457:             .BorderStyle   = 1
458:             .Height        = 25
459:             .Left          = 350
460:             .MaxLength     = 10
461:             .SpecialEffect = 1
462:             .Top           = 150
463:             .Width         = 80
464:             .ForeColor     = RGB(0, 0, 0)
465:             .Value         = {}
466:             .Visible       = .T.
467:         ENDWITH
468: 
469:         *-- OptionGroup: Tipo de data (Movimentacao / Vencimento)
470:         THIS.AddObject("obj_4c_OptDatas", "OptionGroup")
471:         WITH THIS.obj_4c_OptDatas
472:             .Top           = 149
473:             .Left          = 430
474:             .Width         = 189
475:             .Height        = 25
476:             .ButtonCount   = 2
477:             .BackStyle     = 0
478:             .BorderStyle   = 0
479:             .Value         = 1
480:             .SpecialEffect = 0
481:             .Visible       = .T.
482: 
483:             WITH .Buttons(1)
484:                 .BackStyle = 0
485:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
486:                 .Height    = 15
487:                 .Left      = 5
488:                 .Style     = 0
489:                 .Top       = 5
490:                 .Width     = 87
491:                 .AutoSize  = .T.
492:                 .ForeColor = RGB(90, 90, 90)
493:                 .Themes    = .F.
494:                 .Visible   = .T.
495:             ENDWITH
496: 
497:             WITH .Buttons(2)
498:                 .FontName  = "Tahoma"
499:                 .FontSize  = 8
500:                 .BackStyle = 0
501:                 .Caption   = "Vencimento"
502:                 .Height    = 15
503:                 .Left      = 111
504:                 .Style     = 0
505:                 .Top       = 5
506:                 .Width     = 73
507:                 .AutoSize  = .T.
508:                 .ForeColor = RGB(90, 90, 90)
509:                 .Themes    = .F.
510:                 .Visible   = .T.
511:             ENDWITH
512:         ENDWITH
513: 
514:         *-- OptionGroup: Op_Emitido (Emitido / Nao Emitido / Todos)
515:         THIS.AddObject("obj_4c_Op_Emitido", "OptionGroup")
516:         WITH THIS.obj_4c_Op_Emitido
517:             .Top           = 197
518:             .Left          = 248
519:             .Width         = 262
520:             .Height        = 24
521:             .ButtonCount   = 3
522:             .BackStyle     = 0
523:             .BorderStyle   = 0
524:             .Value         = 1
525:             .SpecialEffect = 0
526:             .AutoSize      = .F.
527:             .Visible       = .T.
528: 
529:             WITH .Buttons(1)
530:                 .BackStyle = 0
531:                 .Caption   = "Emitido"
532:                 .Height    = 15
533:                 .Left      = 5
534:                 .Top       = 5
535:                 .Width     = 52
536:                 .AutoSize  = .T.
537:                 .ForeColor = RGB(90, 90, 90)
538:                 .Themes    = .F.
539:                 .Visible   = .T.
540:             ENDWITH
541: 
542:             WITH .Buttons(2)
543:                 .FontName  = "Tahoma"
544:                 .FontSize  = 8
545:                 .BackStyle = 0
546:                 .Caption   = "N" + CHR(227) + "o Emitido"
547:                 .Left      = 92
548:                 .Top       = 5
549:                 .AutoSize  = .T.
550:                 .ForeColor = RGB(90, 90, 90)
551:                 .Themes    = .F.
552:                 .Visible   = .T.
553:             ENDWITH
554: 
555:             WITH .Buttons(3)
556:                 .FontName  = "Tahoma"
557:                 .FontSize  = 8
558:                 .BackStyle = 0
559:                 .Caption   = "Todos"
560:                 .Height    = 15
561:                 .Left      = 201
562:                 .Top       = 5
563:                 .Width     = 47
564:                 .AutoSize  = .T.
565:                 .ForeColor = RGB(90, 90, 90)
566:                 .Themes    = .F.
567:                 .Visible   = .T.
568:             ENDWITH
569:         ENDWITH
570: 
571:         *-- OptionGroup: Op_Cancelado (Validos / Cancelados / Todos)
572:         THIS.AddObject("obj_4c_Op_Cancelado", "OptionGroup")
573:         WITH THIS.obj_4c_Op_Cancelado
574:             .Top           = 219
575:             .Left          = 248
576:             .Width         = 262
577:             .Height        = 24
578:             .ButtonCount   = 3
579:             .BackStyle     = 0
580:             .BorderStyle   = 0
581:             .Value         = 1
582:             .SpecialEffect = 0
583:             .AutoSize      = .F.
584:             .Visible       = .T.
585: 
586:             WITH .Buttons(1)
587:                 .BackStyle = 0
588:                 .Caption   = "V" + CHR(225) + "lidos"
589:                 .Height    = 15
590:                 .Left      = 5
591:                 .Top       = 5
592:                 .Width     = 51
593:                 .AutoSize  = .T.
594:                 .ForeColor = RGB(90, 90, 90)
595:                 .Themes    = .F.
596:                 .Visible   = .T.
597:             ENDWITH
598: 
599:             WITH .Buttons(2)
600:                 .FontName  = "Tahoma"
601:                 .FontSize  = 8
602:                 .BackStyle = 0
603:                 .Caption   = "Cancelados"
604:                 .Left      = 92
605:                 .Top       = 5
606:                 .AutoSize  = .T.
607:                 .ForeColor = RGB(90, 90, 90)
608:                 .Themes    = .F.
609:                 .Visible   = .T.
610:             ENDWITH
611: 
612:             WITH .Buttons(3)
613:                 .FontName  = "Tahoma"
614:                 .FontSize  = 8
615:                 .BackStyle = 0
616:                 .Caption   = "Todos"
617:                 .Height    = 15
618:                 .Left      = 201
619:                 .Top       = 5
620:                 .Width     = 47
621:                 .AutoSize  = .T.
622:                 .ForeColor = RGB(90, 90, 90)
623:                 .Themes    = .F.
624:                 .Visible   = .T.
625:             ENDWITH
626:         ENDWITH
627: 
628:         *-- OptionGroup: Op_Ordem (por Copia / por Data / por Conta)
629:         THIS.AddObject("obj_4c_Op_Ordem", "OptionGroup")
630:         WITH THIS.obj_4c_Op_Ordem
631:             .Top           = 172
632:             .Left          = 248
633:             .Width         = 280
634:             .Height        = 27
635:             .ButtonCount   = 3
636:             .BackStyle     = 0
637:             .BorderStyle   = 0
638:             .Value         = 1
639:             .SpecialEffect = 0
640:             .Visible       = .T.
641: 
642:             WITH .Buttons(1)
643:                 .BackStyle = 0
644:                 .Caption   = "por C" + CHR(243) + "pia"
645:                 .Height    = 17
646:                 .Left      = 5
647:                 .Style     = 0
648:                 .Top       = 5
649:                 .Width     = 72
650:                 .AutoSize  = .F.
651:                 .ForeColor = RGB(90, 90, 90)
652:                 .Themes    = .F.
653:                 .Visible   = .T.
654:             ENDWITH
655: 
656:             WITH .Buttons(2)
657:                 .FontName  = "Tahoma"
658:                 .FontSize  = 8
659:                 .BackStyle = 0
660:                 .Caption   = "por Data"
661:                 .Height    = 17
662:                 .Left      = 92
663:                 .Style     = 0
664:                 .Top       = 5
665:                 .Width     = 72
666:                 .AutoSize  = .F.
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .Themes    = .F.
669:                 .Visible   = .T.
670:             ENDWITH
671: 
672:             WITH .Buttons(3)
673:                 .FontName  = "Tahoma"
674:                 .FontSize  = 8
675:                 .BackStyle = 0
676:                 .Caption   = "por Conta"
677:                 .Height    = 17
678:                 .Left      = 201
679:                 .Style     = 0
680:                 .Top       = 5
681:                 .Width     = 77
682:                 .AutoSize  = .F.
683:                 .ForeColor = RGB(90, 90, 90)
684:                 .Themes    = .F.
685:                 .Visible   = .T.
686:             ENDWITH
687:         ENDWITH
688: 
689:         *-- OptionGroup: Op_Baixados (Sim / Nao)
690:         THIS.AddObject("obj_4c_Op_Baixados", "OptionGroup")
691:         WITH THIS.obj_4c_Op_Baixados
692:             .Top           = 240
693:             .Left          = 248
694:             .Width         = 144
695:             .Height        = 27
696:             .ButtonCount   = 2
697:             .BackStyle     = 0
698:             .BorderStyle   = 0
699:             .Value         = 1
700:             .SpecialEffect = 0
701:             .Visible       = .T.
702: 
703:             WITH .Buttons(1)
704:                 .BackStyle = 0
705:                 .Caption   = "Sim"
706:                 .Height    = 17
707:                 .Left      = 5
708:                 .Style     = 0
709:                 .Top       = 5
710:                 .Width     = 40
711:                 .AutoSize  = .F.
712:                 .ForeColor = RGB(90, 90, 90)
713:                 .Themes    = .F.
714:                 .Visible   = .T.
715:             ENDWITH
716: 
717:             WITH .Buttons(2)
718:                 .FontName  = "Tahoma"
719:                 .FontSize  = 8
720:                 .BackStyle = 0
721:                 .Caption   = "N" + CHR(227) + "o"
722:                 .Height    = 17
723:                 .Left      = 92
724:                 .Style     = 0
725:                 .Top       = 5
726:                 .Width     = 40
727:                 .AutoSize  = .F.
728:                 .ForeColor = RGB(90, 90, 90)
729:                 .Themes    = .F.
730:                 .Visible   = .T.

*-- Linhas 1203 a 1221:
1203:     *==========================================================================
1204:     PROCEDURE BOParaForm()
1205:         WITH THIS.this_oRelatorio
1206:             THIS.txt_4c__dt_inicial.Value     = .this_dDtInicial
1207:             THIS.txt_4c__dt_final.Value       = .this_dDtFinal
1208:             THIS.obj_4c_OptDatas.Value        = .this_nTpDat
1209:             THIS.txt_4c_CdGrEstoque.Value     = .this_cGrupo
1210:             THIS.txt_4c_DsGrEstoque.Value     = .this_cDsGrupo
1211:             THIS.txt_4c_CdContas.Value        = .this_cIclis
1212:             THIS.txt_4c_DsContas.Value        = .this_cDsContas
1213:             THIS.obj_4c_Op_Emitido.Value      = .this_nOpEmitido
1214:             THIS.obj_4c_Op_Cancelado.Value    = .this_nOpCancela
1215:             THIS.obj_4c_Op_Ordem.Value        = .this_nOpOrdem
1216:             THIS.obj_4c_Op_Baixados.Value     = .this_nOpBaixas
1217:         ENDWITH
1218:     ENDPROC
1219: 
1220:     *==========================================================================
1221:     * HABILITARCAMPOS - Habilita/desabilita todos os campos de filtro


### BO (C:\4c\projeto\app\classes\sigrehtcBO.prg):
*==============================================================================
* SIGREHTCBO.PRG
* Business Object para Relatorio de Cheques Emitidos (SIGREHTC)
* Herda de: RelatorioBase
*
* Filtros disponiveis (mapeados do codigo legado):
*   - Periodo (data inicial / data final) + tipo (Movimentacao ou Vencimento)
*   - Grupo de estoque/contabil (codigo + descricao)
*   - Conta (codigo Iclis + descricao)
*   - Opcoes de selecao: Emitido, Cancelado, Ordem, Baixados
*
* Tabela principal: SigCqChi
* Tabelas auxiliares: SigCdCli, SigOpFp, SigCdPit, SigMvPar, SigMvCcr
*==============================================================================

DEFINE CLASS sigrehtcBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Tipo de data: 1=Movimentacao, 2=Vencimento (optDatas)
    this_nTpDat         = 1

    *-- Grupo de estoque / contabil (getCdGrEstoque / getDsGrEstoque)
    this_cGrupo         = ""
    this_cDsGrupo       = ""

    *-- Conta corrente (getCdContas / getDsContas) - Iclis no banco
    this_cIclis         = ""
    this_cDsContas      = ""

    *-- Op_Emitido: 1=Emitido, 2=Nao Emitido, 3=Todos
    this_nOpEmitido     = 1

    *-- Op_Cancelado: 1=Validos, 2=Cancelados, 3=Todos
    this_nOpCancela     = 1

    *-- Op_Ordem: 1=por Copia, 2=por Data, 3=por Conta
    this_nOpOrdem       = 1

    *-- Op_Baixados: 1=Sim, 2=Nao
    this_nOpBaixas      = 1

    *-- Nome do cursor de resultado gerado por PrepararDados()
    this_cCursorDados   = "cursor_4c_Resultado"

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCqChi"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor para o relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_cOrdem
        LOCAL loc_cDtInicial, loc_cDtFinal
        LOCAL loc_cGrupos, loc_cContas
        LOCAL loc_cTitulo1, loc_cPeriodo, loc_cOrdemDesc, loc_cEmp
        LOCAL loc_nResult
        LOCAL loc_cFavor, loc_cHists, loc_cMoedas
        LOCAL loc_nCopia

        loc_lSucesso = .F.

        TRY
            loc_cEmp = go_4c_Sistema.cEmpresa

            *-- Titulo principal do relatorio
            loc_cTitulo1 = "Relat" + CHR(243) + "rio de Cheques Emitidos de " + ;
                DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                DTOC(THIS.this_dDtFinal) + " - " + ;
                IIF(THIS.this_nTpDat = 1, ;
                    "Movimenta" + CHR(231) + CHR(227) + "o", ;
                    "Vencimento")

            *-- Linha descritiva de grupo/conta para o relatorio
            IF !EMPTY(THIS.this_cGrupo)
                loc_cPeriodo = "Grupo : " + ALLTRIM(THIS.this_cGrupo) + ;
                    " - " + ALLTRIM(THIS.this_cDsGrupo) + " - "
            ELSE
                loc_cPeriodo = "Grupo : Todos - "
            ENDIF

            IF !EMPTY(THIS.this_cIclis)
                loc_cPeriodo = loc_cPeriodo + "Conta : " + ;
                    ALLTRIM(THIS.this_cIclis) + " - " + ALLTRIM(THIS.this_cDsContas)
            ELSE
                loc_cPeriodo = loc_cPeriodo + "Conta : Todas"
            ENDIF

            *-- Descricao da ordem de impressao
            loc_cOrdemDesc = "Emiss" + CHR(227) + "o em Ordem de " + ;
                IIF(THIS.this_nOpOrdem = 1, ;
                    "N" + CHR(250) + "mero de C" + CHR(243) + "pia", ;
                    IIF(THIS.this_nOpOrdem = 2, "Data", "Conta"))

            *-- Datas formatadas para SQL
            loc_cDtInicial = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinal   = "'" + ;
                PADL(ALLTRIM(STR(YEAR(THIS.this_dDtFinal),  4, 0)), 4, "0") + "-" + ;
                PADL(ALLTRIM(STR(MONTH(THIS.this_dDtFinal), 2, 0)), 2, "0") + "-" + ;
                PADL(ALLTRIM(STR(DAY(THIS.this_dDtFinal),   2, 0)), 2, "0") + ;
                " 23:59:59'"

            *-- Campo de data e clausulas opcionais
            loc_cOrdem  = IIF(THIS.this_nTpDat = 1, "Datas", "Vencs")
            loc_cContas = IIF(EMPTY(THIS.this_cIclis), "", ;
                " AND Contas = " + EscaparSQL(THIS.this_cIclis))
            loc_cGrupos = IIF(EMPTY(THIS.this_cGrupo), "", ;
                " AND Grupos = " + EscaparSQL(THIS.this_cGrupo))

            *-- Query principal em SigCqChi
            loc_cSQL = "SELECT * FROM SigCqChi" + ;
                " WHERE " + loc_cOrdem + ;
                " BETWEEN " + loc_cDtInicial + " AND " + loc_cDtFinal + ;
                loc_cGrupos + loc_cContas + ;
                " ORDER BY " + loc_cOrdem

            IF USED("cursor_4c_SigCqChi")
                USE IN cursor_4c_SigCqChi
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCqChi")

            IF loc_nResult >= 0
                *-- Recria cursor de resultado com estrutura identica ao original
                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Resultado ( ;
                    NCopias   N(6,0),  ;
                    Favos     C(40),   ;
                    Valors    N(12,2), ;
                    Vencs     D,       ;
                    Datas     D,       ;
                    Hists     C(60),   ;
                    Valos     N(12,2), ;
                    Emps      C(3),    ;
                    Dopes     C(20),   ;
                    MascNum   C(6),    ;
                    Cheques   C(26),   ;
                    Cancelas  L,       ;
                    Moedas    C(3),    ;
                    Periodos  C(254),  ;
                    cEmpresas C(50),   ;
                    Grupos    C(10),   ;
                    Contas    C(10),   ;
                    Titulo1s  C(254),  ;
                    Ordem     C(254),  ;
                    Saltar    C(20),   ;
                    Total     L,       ;
                    Baixas    N(1,0),  ;
                    TotCon    N(12,4)  ;
                )
                SET NULL OFF

                *-- Indice conforme ordem selecionada
                DO CASE
                    CASE THIS.this_nOpOrdem = 1
                        INDEX ON STR(NCopias, 6) TAG Ncopias
                    CASE THIS.this_nOpOrdem = 2
                        IF THIS.this_nTpDat = 1
                            INDEX ON DTOS(Datas) + STR(NCopias, 6) TAG DataNCop
                        ELSE
                            INDEX ON DTOS(Vencs) + STR(NCopias, 6) TAG DataNCop
                        ENDIF
                    CASE THIS.this_nOpOrdem = 3
                        IF THIS.this_nTpDat = 1
                            INDEX ON Grupos + Contas + Cheques + ;
                                DTOS(Datas) + STR(NCopias, 6) TAG GruConDat
                        ELSE
                            INDEX ON Grupos + Contas + Cheques + ;
                                DTOS(Vencs) + STR(NCopias, 6) TAG GruConDat
                        ENDIF
                ENDCASE

                *-- Percorre SigCqChi e popula cursor de resultado
                SELECT cursor_4c_SigCqChi
                SCAN
                    *-- Filtro cancelamento/emissao
                    IF (THIS.this_nOpCancela = 1 .AND. ;
                            (cursor_4c_SigCqChi.Cancelas .OR. !cursor_4c_SigCqChi.Emitidos)) .OR. ;
                       (THIS.this_nOpCancela = 2 .AND. ;
                            (cursor_4c_SigCqChi.Emitidos .OR. !cursor_4c_SigCqChi.Cancelas))
                        LOOP
                    ENDIF

                    IF cursor_4c_SigCqChi.Cancelas
                        *-- Cancelado: insere sem busca de historico
                        INSERT INTO cursor_4c_Resultado ;
                            (NCopias, Favos, Valors, Vencs, Datas, ;
                             Emps, Dopes, MascNum, Cheques, Cancelas, ;
                             Periodos, cEmpresas, Grupos, Contas, ;
                             Titulo1s, Ordem, Saltar, Total, Baixas) ;
                        VALUES ;
                            (cursor_4c_SigCqChi.NCopias, ;
                             cursor_4c_SigCqChi.Favos, ;
                             cursor_4c_SigCqChi.Valors, ;
                             IIF(ISNULL(cursor_4c_SigCqChi.Vencs), {}, TTOD(cursor_4c_SigCqChi.Vencs)), ;
                             IIF(ISNULL(cursor_4c_SigCqChi.Datas), {}, TTOD(cursor_4c_SigCqChi.Datas)), ;
                             cursor_4c_SigCqChi.Emps, ;
                             cursor_4c_SigCqChi.Dopes, ;
                             PADL(ALLTRIM(STR(cursor_4c_SigCqChi.Numes, 6, 0)), 6, "0"), ;
                             cursor_4c_SigCqChi.Bancos + "-" + cursor_4c_SigCqChi.Agencias + ;
                                 "-" + cursor_4c_SigCqChi.Ncontas + ;
                                 "-" + cursor_4c_SigCqChi.NCheques, ;
                             cursor_4c_SigCqChi.Cancelas, ;
                             loc_cPeriodo, ;
                             loc_cEmp, ;
                             cursor_4c_SigCqChi.Grupos, ;
                             cursor_4c_SigCqChi.Contas, ;
                             loc_cTitulo1, ;
                             loc_cOrdemDesc, ;
                             IIF(THIS.this_nOpOrdem = 3, ;
                                 cursor_4c_SigCqChi.Grupos + cursor_4c_SigCqChi.Contas, ;
                                 ""), ;
                             (THIS.this_nOpOrdem = 3), ;
                             THIS.this_nOpBaixas)
                    ELSE
                        *-- Nao cancelado: busca historico em SigCdPit
                        loc_cFavor = cursor_4c_SigCqChi.Favos

                        loc_cSQL = "SELECT * FROM SigCdPit" + ;
                            " WHERE Emps = " + EscaparSQL(cursor_4c_SigCqChi.Emps) + ;
                            " AND Dopes = " + EscaparSQL(cursor_4c_SigCqChi.Dopes) + ;
                            " AND Numes = " + FormatarNumeroSQL(cursor_4c_SigCqChi.Numes)

                        IF USED("cursor_4c_SigCdPit")
                            USE IN cursor_4c_SigCdPit
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPit")

                        IF loc_nResult > 0
                            SELECT cursor_4c_SigCdPit
                            SCAN
                                IF cursor_4c_SigCdPit.Tipos = "P"
                                    loc_cSQL = "SELECT * FROM SigMvPar" + ;
                                        " WHERE Emps = " + EscaparSQL(cursor_4c_SigCdPit.Empos) + ;
                                        " AND Nopers = " + FormatarNumeroSQL(cursor_4c_SigCdPit.Nopers)

                                    IF USED("cursor_4c_SigMvPar")
                                        USE IN cursor_4c_SigMvPar
                                    ENDIF

                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvPar")

                                    IF loc_nResult > 0
                                        SELECT cursor_4c_SigMvPar
                                        loc_cHists  = LEFT( ;
                                            cursor_4c_SigMvPar.Emps + ;
                                            ALLTRIM(cursor_4c_SigMvPar.Dopes) + " " + ;
                                            ALLTRIM(PADL(ALLTRIM(STR(cursor_4c_SigMvPar.Numes, 6, 0)), 6, "0")) + ;
                                            " ( " + ALLTRIM(cursor_4c_SigMvPar.Fpags) + " ) ", 60)
                                        loc_cMoedas = cursor_4c_SigMvPar.Moefpgs
                                    ELSE
                                        loc_cHists  = ""
                                        loc_cMoedas = ""
                                    ENDIF
                                ELSE
                                    loc_cSQL = "SELECT * FROM SigMvCcr" + ;
                                        " WHERE Emps = " + EscaparSQL(cursor_4c_SigCdPit.Empos) + ;
                                        " AND Nopers = " + FormatarNumeroSQL(cursor_4c_SigCdPit.Nopers)

                                    IF USED("cursor_4c_SigMvCcr")
                                        USE IN cursor_4c_SigMvCcr
                                    ENDIF

                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCcr")

                                    IF loc_nResult > 0
                                        SELECT cursor_4c_SigMvCcr
                                        loc_cHists  = NVL(cursor_4c_SigMvCcr.Hists, "")
                                        loc_cMoedas = cursor_4c_SigMvCcr.Moedas
                                    ELSE
                                        loc_cHists  = ""
                                        loc_cMoedas = ""
                                    ENDIF
                                ENDIF

                                INSERT INTO cursor_4c_Resultado ;
                                    (NCopias, Favos, Valors, Vencs, Datas, ;
                                     Hists, Moedas, Emps, Dopes, MascNum, ;
                                     Cheques, Valos, Cancelas, Periodos, ;
                                     cEmpresas, Grupos, Contas, Titulo1s, ;
                                     Ordem, Saltar, Total, Baixas) ;
                                VALUES ;
                                    (cursor_4c_SigCqChi.NCopias, ;
                                     loc_cFavor, ;
                                     cursor_4c_SigCqChi.Valors, ;
                                     IIF(ISNULL(cursor_4c_SigCqChi.Vencs), {}, ;
                                         TTOD(cursor_4c_SigCqChi.Vencs)), ;
                                     IIF(ISNULL(cursor_4c_SigCqChi.Datas), {}, ;
                                         TTOD(cursor_4c_SigCqChi.Datas)), ;
                                     loc_cHists, ;
                                     loc_cMoedas, ;
                                     cursor_4c_SigCqChi.Emps, ;
                                     cursor_4c_SigCqChi.Dopes, ;
                                     PADL(ALLTRIM(STR(cursor_4c_SigCqChi.Numes, 6, 0)), 6, "0"), ;
                                     cursor_4c_SigCqChi.Bancos + "-" + ;
                                         cursor_4c_SigCqChi.Agencias + "-" + ;
                                         cursor_4c_SigCqChi.Ncontas + "-" + ;
                                         cursor_4c_SigCqChi.NCheques, ;
                                     cursor_4c_SigCdPit.Acertos, ;
                                     cursor_4c_SigCqChi.Cancelas, ;
                                     loc_cPeriodo, ;
                                     loc_cEmp, ;
                                     cursor_4c_SigCqChi.Grupos, ;
                                     cursor_4c_SigCqChi.Contas, ;
                                     loc_cTitulo1, ;
                                     loc_cOrdemDesc, ;
                                     IIF(THIS.this_nOpOrdem = 3, ;
                                         cursor_4c_SigCqChi.Grupos + cursor_4c_SigCqChi.Contas, ;
                                         ""), ;
                                     (THIS.this_nOpOrdem = 3), ;
                                     THIS.this_nOpBaixas)

                                loc_cFavor = ""
                                SELECT cursor_4c_SigCdPit
                            ENDSCAN
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigCqChi
                ENDSCAN

                *-- Calculo TotCon para ordem por Conta
                SELECT cursor_4c_Resultado
                GO TOP

                IF THIS.this_nOpOrdem = 3
                    loc_nCopia = 0
                    DO WHILE !EOF()
                        IF loc_nCopia != NCopias
                            loc_nCopia = NCopias
                            REPLACE TotCon WITH Valors
                        ENDIF
                        SKIP
                    ENDDO
                    GO TOP
                ENDIF

                *-- Limpa cursores auxiliares
                IF USED("cursor_4c_SigCqChi")
                    USE IN cursor_4c_SigCqChi
                ENDIF
                IF USED("cursor_4c_SigCdPit")
                    USE IN cursor_4c_SigCdPit
                ENDIF
                IF USED("cursor_4c_SigMvPar")
                    USE IN cursor_4c_SigMvPar
                ENDIF
                IF USED("cursor_4c_SigMvCcr")
                    USE IN cursor_4c_SigMvCcr
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar cheques de SigCqChi"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)

                IF !EOF()
                    loc_cFrx = gc_4c_CaminhoBase + "reports\SigReHtc.frx"

                    IF !FILE(loc_cFrx)
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                            "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                        MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    ELSE
                        REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)

                IF !EOF()
                    loc_cFrx = gc_4c_CaminhoBase + "reports\SigReHtc.frx"

                    IF !FILE(loc_cFrx)
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                            "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                        MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    ELSE
                        REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContas - Popula cursor de contas para lookup no form
    * Substitui o crContas do Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContas()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT b.iclis, b.rclis" + ;
                " FROM SigOpFp a, SigCdCli b" + ;
                " WHERE a.emichqs = 1 AND b.iclis = a.contads" + ;
                " ORDER BY b.iclis"

            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contas")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar lista de contas"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "BuscarContas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel(par_cArquivo)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                IF !EOF()
                    COPY TO (par_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhum dado encontrado para exportar.", ;
                        "Exportar Excel")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao preparar dados para exporta" + ;
                    CHR(231) + CHR(227) + "o"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Resultado")
            USE IN cursor_4c_Resultado
        ENDIF
        IF USED("cursor_4c_SigCqChi")
            USE IN cursor_4c_SigCqChi
        ENDIF
        IF USED("cursor_4c_SigCdPit")
            USE IN cursor_4c_SigCdPit
        ENDIF
        IF USED("cursor_4c_SigMvPar")
            USE IN cursor_4c_SigMvPar
        ENDIF
        IF USED("cursor_4c_SigMvCcr")
            USE IN cursor_4c_SigMvCcr
        ENDIF
        IF USED("cursor_4c_Contas")
            USE IN cursor_4c_Contas
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

