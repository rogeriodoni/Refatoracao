# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Emps define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Emps.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Orcs define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Orcs.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredtv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1736 linhas total):

*-- Linhas 68 a 79:
68:             IF loc_lSucesso
69:                 THIS.this_oRelatorio = CREATEOBJECT("sigredtvBO")
70:                 THIS.this_oRelatorio.ConfigurarTipo(THIS.this_nTipo)
71:                 THIS.Caption = THIS.this_oRelatorio.ObterCaptionForm()
72: 
73:                 THIS.ConfigurarCabecalho()
74:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
75:                 THIS.ConfigurarBotoes()
76:                 THIS.ConfigurarCampos()
77: 
78:                 THIS.this_oRelatorio.InicializarDados()
79: 

*-- Linhas 124 a 182:
124:     PROTECTED PROCEDURE ConfigurarCabecalho()
125:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH THIS.cnt_4c_Cabecalho
127:             .Top         = 0
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
137:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
138:             .Top       = 25
139:             .Left      = 20
140:             .AutoSize  = .T.
141:             .Caption   = THIS.Caption
142:             .FontName  = "Tahoma"
143:             .FontSize  = 14
144:             .FontBold  = .T.
145:             .ForeColor = RGB(255, 255, 255)
146:             .BackStyle = 0
147:             .Visible   = .T.
148:         ENDWITH
149:         THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
150:         THIS.cnt_4c_Cabecalho.Visible = .T.
151:     ENDPROC
152: 
153:     *--------------------------------------------------------------------------
154:     * ConfigurarBotoes - Visualizar / Imprimir / Documento / Encerrar
155:     *--------------------------------------------------------------------------
156:     PROTECTED PROCEDURE ConfigurarBotoes()
157:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
158:         WITH THIS.cmg_4c_Botoes
159:             .Top           = 0
160:             .Left          = 529
161:             .Width         = 273
162:             .Height        = 80
163:             .ButtonCount   = 4
164:             .BackStyle     = 0
165:             .BorderStyle   = 0
166:             .BorderColor   = RGB(136, 189, 188)
167:             .SpecialEffect = 1
168:             .Themes        = .F.
169:             .Visible       = .T.
170:         ENDWITH
171: 
172:         WITH THIS.cmg_4c_Botoes.Buttons(1)
173:             .Top             = 5
174:             .Left            = 5
175:             .Width           = 65
176:             .Height          = 70
177:             .Caption         = "Visualizar"
178:             .FontName        = "Tahoma"
179:             .FontBold        = .T.
180:             .FontItalic      = .T.
181:             .FontSize        = 8
182:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"

*-- Linhas 191 a 203:
191:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
192: 
193:         WITH THIS.cmg_4c_Botoes.Buttons(2)
194:             .Top             = 5
195:             .Left            = 71
196:             .Width           = 65
197:             .Height          = 70
198:             .Caption         = "Imprimir"
199:             .FontName        = "Tahoma"
200:             .FontBold        = .T.
201:             .FontItalic      = .T.
202:             .FontSize        = 8
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"

*-- Linhas 212 a 224:
212:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
213: 
214:         WITH THIS.cmg_4c_Botoes.Buttons(3)
215:             .Top             = 5
216:             .Left            = 137
217:             .Width           = 65
218:             .Height          = 70
219:             .Caption         = "Documento"
220:             .FontName        = "Tahoma"
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .FontSize        = 8
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"

*-- Linhas 233 a 245:
233:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
234: 
235:         WITH THIS.cmg_4c_Botoes.Buttons(4)
236:             .Top             = 5
237:             .Left            = 203
238:             .Width           = 65
239:             .Height          = 70
240:             .Caption         = "Encerrar"
241:             .FontName        = "Tahoma"
242:             .FontBold        = .T.
243:             .FontItalic      = .T.
244:             .FontSize        = 8
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 261 a 285:
261:     PROTECTED PROCEDURE ConfigurarCampos()
262: 
263:         *-- === DEMONSTRATIVO Top=120/123 ===
264:         THIS.AddObject("lbl_4c_LblDemonstrativo", "Label")
265:         WITH THIS.lbl_4c_LblDemonstrativo
266:             .Top       = 123
267:             .Left      = 121
268:             .AutoSize  = .T.
269:             .Caption   = "Demonstrativo :"
270:             .FontName  = "Tahoma"
271:             .FontSize  = 8
272:             .BackStyle = 0
273:             .ForeColor = RGB(90, 90, 90)
274:             .Visible   = .T.
275:         ENDWITH
276: 
277:         THIS.AddObject("txt_4c_Demons", "TextBox")
278:         WITH THIS.txt_4c_Demons
279:             .Top           = 120
280:             .Left          = 204
281:             .Width         = 150
282:             .Height        = 23
283:             .FontName      = "Tahoma"
284:             .FontSize      = 9
285:             .Format        = "K!"

*-- Linhas 291 a 343:
291:         ENDWITH
292: 
293:         *-- === PERIODO Top=145/148 ===
294:         THIS.AddObject("lbl_4c_LblPeriodo", "Label")
295:         WITH THIS.lbl_4c_LblPeriodo
296:             .Top       = 148
297:             .Left      = 155
298:             .AutoSize  = .T.
299:             .Caption   = "Per" + CHR(237) + "odo :"
300:             .FontName  = "Tahoma"
301:             .FontSize  = 8
302:             .BackStyle = 0
303:             .ForeColor = RGB(90, 90, 90)
304:             .Visible   = .T.
305:         ENDWITH
306: 
307:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
308:         WITH THIS.txt_4c_DtInicial
309:             .Top           = 145
310:             .Left          = 204
311:             .Width         = 80
312:             .Height        = 23
313:             .FontName      = "Tahoma"
314:             .FontSize      = 9
315:             .Format        = "K"
316:             .SpecialEffect = 1
317:             .BorderColor   = RGB(100, 100, 100)
318:             .Value         = DATE()
319:             .Visible       = .T.
320:         ENDWITH
321: 
322:         THIS.AddObject("lbl_4c_LblPeriodoA", "Label")
323:         WITH THIS.lbl_4c_LblPeriodoA
324:             .Top       = 148
325:             .Left      = 288
326:             .AutoSize  = .T.
327:             .Caption   = CHR(224)
328:             .FontName  = "Tahoma"
329:             .FontSize  = 8
330:             .BackStyle = 0
331:             .ForeColor = RGB(90, 90, 90)
332:             .Visible   = .T.
333:         ENDWITH
334: 
335:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
336:         WITH THIS.txt_4c_DtFinal
337:             .Top           = 145
338:             .Left          = 300
339:             .Width         = 80
340:             .Height        = 23
341:             .FontName      = "Tahoma"
342:             .FontSize      = 9
343:             .Format        = "K"

*-- Linhas 351 a 431:
351:         THIS.AddObject("obj_4c_OptTpDatas", "OptionGroup")
352:         WITH THIS.obj_4c_OptTpDatas
353:             .ButtonCount = 5
354:             .Top         = 138
355:             .Left        = 381
356:             .Width       = 176
357:             .Height      = 59
358:             .BackStyle   = 0
359:             .BorderStyle = 0
360:             .Value       = 2
361:             .Option1.Caption   = "Emiss" + CHR(227) + "o"
362:             .Option1.FontName  = "Tahoma"
363:             .Option1.FontSize  = 8
364:             .Option1.BackStyle = 0
365:             .Option1.ForeColor = RGB(90, 90, 90)
366:             .Option1.Top       = 5
367:             .Option1.Left      = 5
368:             .Option1.Width     = 56
369:             .Option1.Height    = 15
370:             .Option2.Caption   = "Lan" + CHR(231) + "amento"
371:             .Option2.FontName  = "Tahoma"
372:             .Option2.FontSize  = 8
373:             .Option2.BackStyle = 0
374:             .Option2.ForeColor = RGB(90, 90, 90)
375:             .Option2.Top       = 5
376:             .Option2.Left      = 95
377:             .Option2.Width     = 76
378:             .Option2.Height    = 15
379:             .Option3.Caption   = "Vencimento"
380:             .Option3.FontName  = "Tahoma"
381:             .Option3.FontSize  = 8
382:             .Option3.BackStyle = 0
383:             .Option3.ForeColor = RGB(90, 90, 90)
384:             .Option3.Top       = 22
385:             .Option3.Left      = 5
386:             .Option3.Width     = 73
387:             .Option3.Height    = 15
388:             .Option4.Caption   = "Baixa"
389:             .Option4.FontName  = "Tahoma"
390:             .Option4.FontSize  = 8
391:             .Option4.BackStyle = 0
392:             .Option4.ForeColor = RGB(90, 90, 90)
393:             .Option4.Top       = 22
394:             .Option4.Left      = 95
395:             .Option4.Width     = 44
396:             .Option4.Height    = 15
397:             .Option5.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
398:             .Option5.FontName  = "Tahoma"
399:             .Option5.FontSize  = 8
400:             .Option5.BackStyle = 0
401:             .Option5.ForeColor = RGB(90, 90, 90)
402:             .Option5.Top       = 39
403:             .Option5.Left      = 5
404:             .Option5.Width     = 82
405:             .Option5.Height    = 15
406:             .Visible           = .T.
407:         ENDWITH
408: 
409:         *-- === MOEDA Top=170/173 ===
410:         THIS.AddObject("lbl_4c_LblMoeda", "Label")
411:         WITH THIS.lbl_4c_LblMoeda
412:             .Top       = 173
413:             .Left      = 159
414:             .AutoSize  = .T.
415:             .Caption   = "Moeda :"
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .BackStyle = 0
419:             .ForeColor = RGB(90, 90, 90)
420:             .Visible   = .T.
421:         ENDWITH
422: 
423:         THIS.AddObject("txt_4c_CodMoeda", "TextBox")
424:         WITH THIS.txt_4c_CodMoeda
425:             .Top           = 170
426:             .Left          = 204
427:             .Width         = 31
428:             .Height        = 23
429:             .FontName      = "Tahoma"
430:             .FontSize      = 9
431:             .Format        = "K!"

*-- Linhas 439 a 448:
439: 
440:         THIS.AddObject("txt_4c_DesMoeda", "TextBox")
441:         WITH THIS.txt_4c_DesMoeda
442:             .Top           = 170
443:             .Left          = 237
444:             .Width         = 142
445:             .Height        = 23
446:             .FontName      = "Tahoma"
447:             .FontSize      = 9
448:             .Format        = "K"

*-- Linhas 454 a 564:
454:         ENDWITH
455: 
456:         *-- === COTACAO Top=196/200 ===
457:         THIS.AddObject("lbl_4c_LblCotacao", "Label")
458:         WITH THIS.lbl_4c_LblCotacao
459:             .Top       = 200
460:             .Left      = 151
461:             .AutoSize  = .T.
462:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .BackStyle = 0
466:             .ForeColor = RGB(90, 90, 90)
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         THIS.AddObject("obj_4c_OptCotacao", "OptionGroup")
471:         WITH THIS.obj_4c_OptCotacao
472:             .ButtonCount = 2
473:             .Top         = 196
474:             .Left        = 198
475:             .Width       = 210
476:             .Height      = 25
477:             .BackStyle   = 0
478:             .BorderStyle = 0
479:             .Value       = 2
480:             .Option1.Caption   = "\<Fechamento"
481:             .Option1.FontName  = "Tahoma"
482:             .Option1.FontSize  = 8
483:             .Option1.BackStyle = 0
484:             .Option1.ForeColor = RGB(90, 90, 90)
485:             .Option1.Top       = 5
486:             .Option1.Left      = 5
487:             .Option1.Width     = 89
488:             .Option1.Height    = 17
489:             .Option2.Caption   = "\<Movimenta" + CHR(231) + CHR(227) + "o"
490:             .Option2.FontName  = "Tahoma"
491:             .Option2.FontSize  = 8
492:             .Option2.BackStyle = 0
493:             .Option2.ForeColor = RGB(90, 90, 90)
494:             .Option2.Top       = 5
495:             .Option2.Left      = 100
496:             .Option2.Width     = 98
497:             .Option2.Height    = 17
498:             .Visible           = .T.
499:         ENDWITH
500: 
501:         *-- === COMPARATIVO Top=218/223 ===
502:         THIS.AddObject("lbl_4c_LblComparativo", "Label")
503:         WITH THIS.lbl_4c_LblComparativo
504:             .Top       = 223
505:             .Left      = 130
506:             .AutoSize  = .T.
507:             .Caption   = "Comparativo :"
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .BackStyle = 0
511:             .ForeColor = RGB(90, 90, 90)
512:             .Visible   = .T.
513:         ENDWITH
514: 
515:         THIS.AddObject("obj_4c_OptCompara", "OptionGroup")
516:         WITH THIS.obj_4c_OptCompara
517:             .ButtonCount = 3
518:             .Top         = 218
519:             .Left        = 198
520:             .Width       = 317
521:             .Height      = 25
522:             .BackStyle   = 0
523:             .BorderStyle = 0
524:             .Value       = 1
525:             .Option1.Caption   = "N" + CHR(227) + "o"
526:             .Option1.FontName  = "Tahoma"
527:             .Option1.FontSize  = 8
528:             .Option1.BackStyle = 0
529:             .Option1.ForeColor = RGB(90, 90, 90)
530:             .Option1.Top       = 5
531:             .Option1.Left      = 5
532:             .Option1.Width     = 53
533:             .Option1.Height    = 17
534:             .Option2.Caption   = "M" + CHR(234) + "s Anterior"
535:             .Option2.FontName  = "Tahoma"
536:             .Option2.FontSize  = 8
537:             .Option2.BackStyle = 0
538:             .Option2.ForeColor = RGB(90, 90, 90)
539:             .Option2.Top       = 5
540:             .Option2.Left      = 100
541:             .Option2.Width     = 90
542:             .Option2.Height    = 17
543:             .Option3.Caption   = "Ano Anterior"
544:             .Option3.FontName  = "Tahoma"
545:             .Option3.FontSize  = 8
546:             .Option3.BackStyle = 0
547:             .Option3.ForeColor = RGB(90, 90, 90)
548:             .Option3.Top       = 5
549:             .Option3.Left      = 217
550:             .Option3.Width     = 79
551:             .Option3.Height    = 15
552:             .Visible           = .T.
553:         ENDWITH
554: 
555:         *-- Campos de periodo comparativo (inicialmente ocultos, somente leitura)
556:         THIS.AddObject("txt_4c_Comp1", "TextBox")
557:         WITH THIS.txt_4c_Comp1
558:             .Top           = 219
559:             .Left          = 517
560:             .Width         = 80
561:             .Height        = 23
562:             .FontName      = "Tahoma"
563:             .FontSize      = 9
564:             .Format        = "K"

*-- Linhas 570 a 594:
570:             .Visible       = .F.
571:         ENDWITH
572: 
573:         THIS.AddObject("lbl_4c_LblCompA", "Label")
574:         WITH THIS.lbl_4c_LblCompA
575:             .Top       = 223
576:             .Left      = 601
577:             .AutoSize  = .T.
578:             .Caption   = CHR(224)
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .BackStyle = 0
582:             .ForeColor = RGB(90, 90, 90)
583:             .Visible   = .F.
584:         ENDWITH
585: 
586:         THIS.AddObject("txt_4c_Comp2", "TextBox")
587:         WITH THIS.txt_4c_Comp2
588:             .Top           = 219
589:             .Left          = 613
590:             .Width         = 80
591:             .Height        = 23
592:             .FontName      = "Tahoma"
593:             .FontSize      = 9
594:             .Format        = "K"

*-- Linhas 601 a 950:
601:         ENDWITH
602: 
603:         *-- === NOTA FISCAL / SINTETICO Top=238/243 ===
604:         THIS.AddObject("lbl_4c_LblTipo", "Label")
605:         WITH THIS.lbl_4c_LblTipo
606:             .Top       = 243
607:             .Left      = 165
608:             .AutoSize  = .T.
609:             .Caption   = "Tipo :"
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .BackStyle = 0
613:             .ForeColor = RGB(90, 90, 90)
614:             .Visible   = .T.
615:         ENDWITH
616: 
617:         THIS.AddObject("obj_4c_OptSnt", "OptionGroup")
618:         WITH THIS.obj_4c_OptSnt
619:             .ButtonCount = 3
620:             .Top         = 238
621:             .Left        = 198
622:             .Width       = 274
623:             .Height      = 25
624:             .BackStyle   = 0
625:             .BorderStyle = 0
626:             .Value       = 3
627:             .Option1.Caption   = "Sim"
628:             .Option1.FontName  = "Tahoma"
629:             .Option1.FontSize  = 8
630:             .Option1.BackStyle = 0
631:             .Option1.ForeColor = RGB(90, 90, 90)
632:             .Option1.Top       = 5
633:             .Option1.Left      = 5
634:             .Option1.Width     = 53
635:             .Option1.Height    = 17
636:             .Option2.Caption   = "N" + CHR(227) + "o"
637:             .Option2.FontName  = "Tahoma"
638:             .Option2.FontSize  = 8
639:             .Option2.BackStyle = 0
640:             .Option2.ForeColor = RGB(90, 90, 90)
641:             .Option2.Top       = 5
642:             .Option2.Left      = 100
643:             .Option2.Width     = 53
644:             .Option2.Height    = 17
645:             .Option3.Caption   = "Todos"
646:             .Option3.FontName  = "Tahoma"
647:             .Option3.FontSize  = 8
648:             .Option3.BackStyle = 0
649:             .Option3.ForeColor = RGB(90, 90, 90)
650:             .Option3.Top       = 5
651:             .Option3.Left      = 216
652:             .Option3.Width     = 53
653:             .Option3.Height    = 17
654:             .Visible           = .T.
655:         ENDWITH
656: 
657:         *-- === CONTRAPARTIDA Top=259/263 ===
658:         THIS.AddObject("lbl_4c_LblContrapartida", "Label")
659:         WITH THIS.lbl_4c_LblContrapartida
660:             .Top       = 263
661:             .Left      = 124
662:             .AutoSize  = .T.
663:             .Caption   = "Contrapartida :"
664:             .FontName  = "Tahoma"
665:             .FontSize  = 8
666:             .BackStyle = 0
667:             .ForeColor = RGB(90, 90, 90)
668:             .Visible   = .T.
669:         ENDWITH
670: 
671:         THIS.AddObject("obj_4c_OptContras", "OptionGroup")
672:         WITH THIS.obj_4c_OptContras
673:             .ButtonCount = 2
674:             .Top         = 259
675:             .Left        = 198
676:             .Width       = 210
677:             .Height      = 25
678:             .BackStyle   = 0
679:             .BorderStyle = 0
680:             .Value       = 1
681:             .Option1.Caption   = "Ocultar"
682:             .Option1.FontName  = "Tahoma"
683:             .Option1.FontSize  = 8
684:             .Option1.BackStyle = 0
685:             .Option1.ForeColor = RGB(90, 90, 90)
686:             .Option1.Top       = 5
687:             .Option1.Left      = 5
688:             .Option1.Width     = 89
689:             .Option1.Height    = 17
690:             .Option2.Caption   = "Desmembrar"
691:             .Option2.FontName  = "Tahoma"
692:             .Option2.FontSize  = 8
693:             .Option2.BackStyle = 0
694:             .Option2.ForeColor = RGB(90, 90, 90)
695:             .Option2.Top       = 5
696:             .Option2.Left      = 100
697:             .Option2.Width     = 98
698:             .Option2.Height    = 17
699:             .Visible           = .T.
700:         ENDWITH
701: 
702:         *-- === EMPRESAS Top=287 ===
703:         THIS.AddObject("lbl_4c_LblEmpresas", "Label")
704:         WITH THIS.lbl_4c_LblEmpresas
705:             .Top       = 287
706:             .Left      = 145
707:             .AutoSize  = .T.
708:             .Caption   = "Empresas :"
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .BackStyle = 0
712:             .ForeColor = RGB(90, 90, 90)
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         *-- Checkbox "marcar tudo" flutuante sobre header Column1 do grid
717:         THIS.AddObject("chk_4c_MarcaEmp", "CheckBox")
718:         WITH THIS.chk_4c_MarcaEmp
719:             .Top       = 288
720:             .Left      = 206
721:             .Width     = 13
722:             .Height    = 16
723:             .Caption   = ""
724:             .Value     = 1
725:             .Alignment = 0
726:             .Visible   = .T.
727:         ENDWITH
728: 
729:         *-- Grid de empresas (sem RecordSource ainda - configurado apos InicializarDados)
730:         THIS.AddObject("grd_4c_Emps", "Grid")
731:         WITH THIS.grd_4c_Emps
732:             .Top               = 287
733:             .Left              = 205
734:             .Width             = 279
735:             .Height            = 123
736:             .ColumnCount       = 3
737:             .FontName          = "Tahoma"
738:             .FontSize          = 8
739:             .AllowHeaderSizing = .F.
740:             .AllowRowSizing    = .F.
741:             .DeleteMark        = .F.
742:             .RecordMark        = .F.
743:             .ReadOnly          = .F.
744:             .RowHeight         = 17
745:             .ScrollBars        = 2
746:             .GridLineColor     = RGB(238, 238, 238)
747:             .Visible           = .T.
748:         ENDWITH
749:         WITH THIS.grd_4c_Emps.Column1
750:             .Width     = 15
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .Movable   = .F.
754:             .Resizable = .F.
755:             .ReadOnly  = .F.
756:             .Sparse    = .F.
757:         ENDWITH
758:         THIS.grd_4c_Emps.Column1.AddObject("Check1", "CheckBox")
759:         WITH THIS.grd_4c_Emps.Column1.Check1
760:             .Caption  = ""
761:             .AutoSize = .T.
762:             .Visible  = .T.
763:         ENDWITH
764:         THIS.grd_4c_Emps.Column1.CurrentControl = "Check1"
765:         THIS.grd_4c_Emps.Column1.Header1.Caption   = ""
766:         THIS.grd_4c_Emps.Column1.Header1.ForeColor = RGB(90, 90, 90)
767:         WITH THIS.grd_4c_Emps.Column2
768:             .Width     = 27
769:             .FontName  = "Tahoma"
770:             .FontSize  = 8
771:             .Movable   = .F.
772:             .Resizable = .F.
773:             .ReadOnly  = .T.
774:         ENDWITH
775:         THIS.grd_4c_Emps.Column2.Header1.Caption    = "Emp."
776:         THIS.grd_4c_Emps.Column2.Header1.Alignment  = 2
777:         THIS.grd_4c_Emps.Column2.Header1.ForeColor  = RGB(90, 90, 90)
778:         WITH THIS.grd_4c_Emps.Column3
779:             .Width     = 215
780:             .FontName  = "Tahoma"
781:             .FontSize  = 8
782:             .Movable   = .F.
783:             .Resizable = .F.
784:             .ReadOnly  = .T.
785:         ENDWITH
786:         THIS.grd_4c_Emps.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
787:         THIS.grd_4c_Emps.Column3.Header1.Alignment = 2
788:         THIS.grd_4c_Emps.Column3.Header1.ForeColor = RGB(90, 90, 90)
789: 
790:         *-- === ORCAMENTOS Top=415/416 ===
791:         THIS.AddObject("lbl_4c_LblOrcamentos", "Label")
792:         WITH THIS.lbl_4c_LblOrcamentos
793:             .Top       = 415
794:             .Left      = 133
795:             .AutoSize  = .T.
796:             .Caption   = "Or" + CHR(231) + "amentos :"
797:             .FontName  = "Tahoma"
798:             .FontSize  = 8
799:             .BackStyle = 0
800:             .ForeColor = RGB(90, 90, 90)
801:             .Visible   = .T.
802:         ENDWITH
803: 
804:         *-- Checkbox "marcar tudo" flutuante sobre header Column1 do grid de orcamentos
805:         THIS.AddObject("chk_4c_MarcaOrcs", "CheckBox")
806:         WITH THIS.chk_4c_MarcaOrcs
807:             .Top       = 417
808:             .Left      = 206
809:             .Width     = 13
810:             .Height    = 16
811:             .Caption   = ""
812:             .Value     = 0
813:             .Alignment = 0
814:             .Visible   = .T.
815:         ENDWITH
816: 
817:         *-- Grid de orcamentos (sem RecordSource ainda - configurado apos DisponibilizarOrcamentos)
818:         THIS.AddObject("grd_4c_Orcs", "Grid")
819:         WITH THIS.grd_4c_Orcs
820:             .Top               = 416
821:             .Left              = 205
822:             .Width             = 438
823:             .Height            = 122
824:             .ColumnCount       = 5
825:             .FontName          = "Tahoma"
826:             .FontSize          = 8
827:             .AllowHeaderSizing = .F.
828:             .AllowRowSizing    = .F.
829:             .DeleteMark        = .F.
830:             .RecordMark        = .F.
831:             .ReadOnly          = .F.
832:             .RowHeight         = 17
833:             .ScrollBars        = 2
834:             .GridLineColor     = RGB(238, 238, 238)
835:             .Visible           = .T.
836:         ENDWITH
837:         WITH THIS.grd_4c_Orcs.Column1
838:             .Width     = 15
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .Movable   = .F.
842:             .Resizable = .F.
843:             .ReadOnly  = .F.
844:             .Sparse    = .F.
845:         ENDWITH
846:         THIS.grd_4c_Orcs.Column1.AddObject("check12", "CheckBox")
847:         WITH THIS.grd_4c_Orcs.Column1.check12
848:             .Caption  = ""
849:             .AutoSize = .T.
850:             .Visible  = .T.
851:         ENDWITH
852:         THIS.grd_4c_Orcs.Column1.AddObject("check13", "CheckBox")
853:         THIS.grd_4c_Orcs.Column1.check13.Caption = ""
854:         THIS.grd_4c_Orcs.Column1.CurrentControl = "check13"
855:         THIS.grd_4c_Orcs.Column1.Header1.Caption   = ""
856:         THIS.grd_4c_Orcs.Column1.Header1.ForeColor = RGB(90, 90, 90)
857:         WITH THIS.grd_4c_Orcs.Column2
858:             .Width     = 300
859:             .FontName  = "Tahoma"
860:             .FontSize  = 8
861:             .Movable   = .F.
862:             .Resizable = .F.
863:             .ReadOnly  = .T.
864:         ENDWITH
865:         THIS.grd_4c_Orcs.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
866:         THIS.grd_4c_Orcs.Column2.Header1.Alignment = 2
867:         THIS.grd_4c_Orcs.Column2.Header1.ForeColor = RGB(90, 90, 90)
868:         WITH THIS.grd_4c_Orcs.Column3
869:             .Width     = 25
870:             .FontName  = "Tahoma"
871:             .FontSize  = 8
872:             .Movable   = .F.
873:             .Resizable = .F.
874:             .ReadOnly  = .T.
875:         ENDWITH
876:         THIS.grd_4c_Orcs.Column3.Header1.Caption   = "M" + CHR(234) + "s"
877:         THIS.grd_4c_Orcs.Column3.Header1.Alignment = 2
878:         THIS.grd_4c_Orcs.Column3.Header1.ForeColor = RGB(90, 90, 90)
879:         WITH THIS.grd_4c_Orcs.Column4
880:             .Width     = 40
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8
883:             .Movable   = .F.
884:             .Resizable = .F.
885:             .ReadOnly  = .T.
886:         ENDWITH
887:         THIS.grd_4c_Orcs.Column4.Header1.Caption   = "Ano"
888:         THIS.grd_4c_Orcs.Column4.Header1.Alignment = 2
889:         THIS.grd_4c_Orcs.Column4.Header1.ForeColor = RGB(90, 90, 90)
890:         WITH THIS.grd_4c_Orcs.Column5
891:             .Width     = 32
892:             .FontName  = "Tahoma"
893:             .FontSize  = 8
894:             .Movable   = .F.
895:             .Resizable = .F.
896:             .ReadOnly  = .T.
897:         ENDWITH
898:         THIS.grd_4c_Orcs.Column5.Header1.Caption   = "Moeda"
899:         THIS.grd_4c_Orcs.Column5.Header1.Alignment = 2
900:         THIS.grd_4c_Orcs.Column5.Header1.ForeColor = RGB(90, 90, 90)
901: 
902:     ENDPROC
903: 
904:     *--------------------------------------------------------------------------
905:     * ConfigurarGridEmpresas - Vincula RecordSource apos csSigCdEmp disponivel
906:     *--------------------------------------------------------------------------
907:     PROTECTED PROCEDURE ConfigurarGridEmpresas()
908:         IF NOT USED("csSigCdEmp")
909:             RETURN
910:         ENDIF
911:         WITH THIS.grd_4c_Emps
912:             .RecordSource          = "csSigCdEmp"
913:             .Column1.ControlSource = "csSigCdEmp.Imps"
914:             .Column2.ControlSource = "csSigCdEmp.CEmps"
915:             .Column3.ControlSource = "csSigCdEmp.Razas"
916:         ENDWITH
917:         THIS.grd_4c_Emps.Refresh()
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     * ConfigurarGridOrcamentos - Vincula RecordSource apos crSigCdMrp disponivel
922:     *--------------------------------------------------------------------------
923:     PROTECTED PROCEDURE ConfigurarGridOrcamentos()
924:         IF NOT USED("crSigCdMrp")
925:             RETURN
926:         ENDIF
927:         WITH THIS.grd_4c_Orcs
928:             .RecordSource          = "crSigCdMrp"
929:             .Column1.ControlSource = "crSigCdMrp.Imps"
930:             .Column2.ControlSource = "crSigCdMrp.cTitulo"
931:             .Column3.ControlSource = "crSigCdMrp.cMes"
932:             .Column4.ControlSource = "crSigCdMrp.cAno"
933:             .Column5.ControlSource = "crSigCdMrp.Moeda"
934:         ENDWITH
935:         THIS.grd_4c_Orcs.Refresh()
936:     ENDPROC
937: 
938:     *--------------------------------------------------------------------------
939:     * ConfigurarBINDEVENTs - Vincula eventos a metodos do form
940:     *--------------------------------------------------------------------------
941:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
942:         *-- Campos de data
943:         BINDEVENT(THIS.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
944:         BINDEVENT(THIS.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
945: 
946:         *-- Moeda
947:         BINDEVENT(THIS.txt_4c_CodMoeda, "KeyPress", THIS, "TeclaLookupMoedaCod")
948:         BINDEVENT(THIS.txt_4c_DesMoeda, "KeyPress", THIS, "TeclaLookupMoedaDesc")
949:         BINDEVENT(THIS.txt_4c_CodMoeda, "DblClick", THIS, "AbrirBuscaMoedaCod")
950:         BINDEVENT(THIS.txt_4c_DesMoeda, "DblClick", THIS, "AbrirBuscaMoedaDesc")

*-- Linhas 956 a 988:
956:         *-- Comparativo OptionGroup
957:         BINDEVENT(THIS.obj_4c_OptCompara, "InteractiveChange", THIS, "OptComparaChange")
958: 
959:         *-- Checkboxes de selecionar tudo
960:         BINDEVENT(THIS.chk_4c_MarcaEmp,  "Click", THIS, "MarcaEmpClick")
961:         BINDEVENT(THIS.chk_4c_MarcaOrcs, "Click", THIS, "MarcaOrcsClick")
962: 
963:         *-- Grid Empresas - checkbox Column1
964:         BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")
965:         BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
966:         BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
967:         BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "Click",     THIS, "EmpCheckClick")
968: 
969:         *-- Grid Orcamentos - checkbox Column1
970:         BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "KeyPress",  THIS, "OrcCheckKeyPress")
971:         BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "MouseUp",   THIS, "OrcCheckMouseUp")
972:         BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "MouseDown", THIS, "OrcCheckMouseDown")
973:         BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "Click",     THIS, "OrcCheckClick")
974:     ENDPROC
975: 
976:     *--------------------------------------------------------------------------
977:     * FormParaRelatorio - Transfere valores dos controles para propriedades do BO
978:     *--------------------------------------------------------------------------
979:     PROTECTED PROCEDURE FormParaRelatorio()
980:         THIS.this_oRelatorio.this_dDtInicial     = THIS.txt_4c_DtInicial.Value
981:         THIS.this_oRelatorio.this_dDtFinal       = THIS.txt_4c_DtFinal.Value
982:         THIS.this_oRelatorio.this_cCodMoeda      = ALLTRIM(THIS.txt_4c_CodMoeda.Value)
983:         THIS.this_oRelatorio.this_cDesMoeda      = ALLTRIM(THIS.txt_4c_DesMoeda.Value)
984:         THIS.this_oRelatorio.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demons.Value)
985:         THIS.this_oRelatorio.this_nTipoDatas     = THIS.obj_4c_OptTpDatas.Value
986:         THIS.this_oRelatorio.this_nCotacao       = THIS.obj_4c_OptCotacao.Value
987:         THIS.this_oRelatorio.this_nComparativo   = THIS.obj_4c_OptCompara.Value
988:         THIS.this_oRelatorio.this_dCompInicial   = THIS.txt_4c_Comp1.Value

*-- Linhas 1469 a 1489:
1469:     PROCEDURE OptComparaChange()
1470:         LOCAL loc_nVal, loc_lAtivo, loc_lnMeses, loc_ldIni, loc_ldFim, loc_leExpr
1471:         loc_nVal   = THIS.obj_4c_OptCompara.Value
1472:         loc_lAtivo = (loc_nVal > 1)
1473: 
1474:         THIS.grd_4c_Orcs.Enabled       = !loc_lAtivo
1475:         THIS.chk_4c_MarcaOrcs.Enabled  = !loc_lAtivo
1476:         THIS.txt_4c_Comp1.Visible      = loc_lAtivo
1477:         THIS.txt_4c_Comp2.Visible      = loc_lAtivo
1478:         THIS.lbl_4c_LblCompA.Visible   = loc_lAtivo
1479: 
1480:         IF loc_lAtivo
1481:             DO CASE
1482:                 CASE loc_nVal = 2
1483:                     loc_lnMeses = -1
1484:                 CASE loc_nVal = 3
1485:                     loc_lnMeses = -12
1486:                 OTHERWISE
1487:                     loc_lnMeses = 0
1488:             ENDCASE
1489: 

*-- Linhas 1518 a 1595:
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * CHECKBOXES "MARCAR TUDO"
1522:     *==========================================================================
1523: 
1524:     PROCEDURE MarcaEmpClick()
1525:         IF THIS.chk_4c_MarcaEmp.Value = 1
1526:             REPLACE ALL Imps WITH 1 IN csSigCdEmp
1527:         ELSE
1528:             REPLACE ALL Imps WITH 0 IN csSigCdEmp
1529:         ENDIF
1530:         THIS.grd_4c_Emps.Refresh()
1531:         THIS.this_oRelatorio.DisponibilizarOrcamentos()
1532:         THIS.ConfigurarGridOrcamentos()
1533:         THIS.grd_4c_Orcs.Refresh()
1534:     ENDPROC
1535: 
1536:     PROCEDURE MarcaOrcsClick()
1537:         IF THIS.chk_4c_MarcaOrcs.Value = 1
1538:             REPLACE ALL Imps WITH 1 IN crSigCdMrp
1539:         ELSE
1540:             REPLACE ALL Imps WITH 0 IN crSigCdMrp
1541:         ENDIF
1542:         THIS.grd_4c_Orcs.Refresh()
1543:     ENDPROC
1544: 
1545:     *==========================================================================
1546:     * GRID EMPRESAS - checkbox Column1
1547:     *==========================================================================
1548: 
1549:     PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1550:         IF INLIST(par_nKeyCode, 13, 32)
1551:             REPLACE csSigCdEmp.Imps WITH IIF(csSigCdEmp.Imps = 0, 1, 0)
1552:             THIS.grd_4c_Emps.Refresh()
1553:             THIS.this_oRelatorio.DisponibilizarOrcamentos()
1554:             THIS.ConfigurarGridOrcamentos()
1555:             THIS.grd_4c_Orcs.Refresh()
1556:             NODEFAULT
1557:         ENDIF
1558:     ENDPROC
1559: 
1560:     PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1561:         THIS.EmpCheckKeyPress(13, 0)
1562:         NODEFAULT
1563:     ENDPROC
1564: 
1565:     PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1566:         NODEFAULT
1567:     ENDPROC
1568: 
1569:     PROCEDURE EmpCheckClick()
1570:         NODEFAULT
1571:     ENDPROC
1572: 
1573:     *==========================================================================
1574:     * GRID ORCAMENTOS - checkbox Column1
1575:     *==========================================================================
1576: 
1577:     PROCEDURE OrcCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1578:         IF INLIST(par_nKeyCode, 13, 32)
1579:             REPLACE crSigCdMrp.Imps WITH IIF(crSigCdMrp.Imps = 0, 1, 0)
1580:             THIS.grd_4c_Orcs.Refresh()
1581:             NODEFAULT
1582:         ENDIF
1583:     ENDPROC
1584: 
1585:     PROCEDURE OrcCheckMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1586:         THIS.OrcCheckKeyPress(13, 0)
1587:         NODEFAULT
1588:     ENDPROC
1589: 
1590:     PROCEDURE OrcCheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1591:         NODEFAULT
1592:     ENDPROC
1593: 
1594:     PROCEDURE OrcCheckClick()
1595:         NODEFAULT

*-- Linhas 1616 a 1645:
1616:     PROTECTED PROCEDURE AtualizarEstadoOrcamentos()
1617:         LOCAL loc_lMostrar
1618:         loc_lMostrar = (THIS.this_nTipo = 1)
1619:         THIS.lbl_4c_LblOrcamentos.Visible = loc_lMostrar
1620:         THIS.chk_4c_MarcaOrcs.Visible     = loc_lMostrar
1621:         THIS.grd_4c_Orcs.Visible          = loc_lMostrar
1622:     ENDPROC
1623: 
1624:     *--------------------------------------------------------------------------
1625:     * LimparCampos - Reseta todos os campos de filtro para valores padrao
1626:     *--------------------------------------------------------------------------
1627:     PROCEDURE LimparCampos()
1628:         THIS.txt_4c_Demons.Value      = ""
1629:         THIS.txt_4c_DtInicial.Value   = DATE()
1630:         THIS.txt_4c_DtFinal.Value     = DATE()
1631:         THIS.txt_4c_CodMoeda.Value    = ""
1632:         THIS.txt_4c_DesMoeda.Value    = ""
1633:         THIS.obj_4c_OptTpDatas.Value  = 2
1634:         THIS.obj_4c_OptCotacao.Value  = 2
1635:         THIS.obj_4c_OptCompara.Value  = 1
1636:         THIS.obj_4c_OptSnt.Value      = 3
1637:         THIS.obj_4c_OptContras.Value  = 1
1638:         THIS.txt_4c_Comp1.Visible     = .F.
1639:         THIS.txt_4c_Comp2.Visible     = .F.
1640:         THIS.lbl_4c_LblCompA.Visible  = .F.
1641:         THIS.AtualizarEstadoMoedaDesc()
1642:         THIS.Refresh()
1643:     ENDPROC
1644: 
1645:     *==========================================================================

*-- Linhas 1669 a 1686:
1669:         ENDIF
1670: 
1671:         WITH THIS.this_oRelatorio
1672:             THIS.txt_4c_DtInicial.Value     = .this_dDtInicial
1673:             THIS.txt_4c_DtFinal.Value       = .this_dDtFinal
1674:             THIS.txt_4c_CodMoeda.Value      = .this_cCodMoeda
1675:             THIS.txt_4c_DesMoeda.Value      = .this_cDesMoeda
1676:             THIS.txt_4c_Demons.Value        = .this_cDemonstrativo
1677:             THIS.obj_4c_OptTpDatas.Value    = IIF(BETWEEN(.this_nTipoDatas, 1, 5), .this_nTipoDatas, 2)
1678:             THIS.obj_4c_OptCotacao.Value    = IIF(BETWEEN(.this_nCotacao, 1, 2), .this_nCotacao, 2)
1679:             THIS.obj_4c_OptCompara.Value    = IIF(BETWEEN(.this_nComparativo, 1, 3), .this_nComparativo, 1)
1680:             THIS.txt_4c_Comp1.Value         = .this_dCompInicial
1681:             THIS.txt_4c_Comp2.Value         = .this_dCompFinal
1682:             THIS.obj_4c_OptSnt.Value        = IIF(BETWEEN(.this_nSnt, 1, 3), .this_nSnt, 3)
1683:             THIS.obj_4c_OptContras.Value    = IIF(BETWEEN(.this_nContrapartida, 1, 2), .this_nContrapartida, 1)
1684:         ENDWITH
1685: 
1686:         THIS.AtualizarEstadoMoedaDesc()

*-- Linhas 1700 a 1721:
1700: 
1701:         THIS.this_oRelatorio.InicializarDados()
1702:         THIS.ConfigurarGridEmpresas()
1703:         THIS.this_oRelatorio.DisponibilizarOrcamentos()
1704:         THIS.ConfigurarGridOrcamentos()
1705:         THIS.grd_4c_Emps.Refresh()
1706:         THIS.grd_4c_Orcs.Refresh()
1707:     ENDPROC
1708: 
1709:     *--------------------------------------------------------------------------
1710:     * BtnSalvarClick - Equivalente CRUD; delega para BtnImprimirClick
1711:     * No contexto REPORT, a acao "principal" do form e gerar o relatorio.
1712:     * Imprimir e a operacao definitiva (analoga a Salvar de um cadastro).
1713:     *--------------------------------------------------------------------------
1714:     PROCEDURE BtnSalvarClick()
1715:         THIS.BtnImprimirClick()
1716:     ENDPROC
1717: 
1718:     *--------------------------------------------------------------------------
1719:     * BtnCancelarClick - Equivalente CRUD; delega para BtnSairClick
1720:     * No contexto REPORT, cancelar = fechar o form de filtros.
1721:     *--------------------------------------------------------------------------

