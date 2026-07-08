# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 182: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 221: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2220 linhas total):

*-- Linhas 49 a 57:
49:         loc_lContinuar = .T.
50: 
51:         TRY
52:             THIS.Caption = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber"
53: 
54:             IF TYPE("gc_4c_CaminhoIcones") = "U"
55:                 gc_4c_CaminhoIcones = ""
56:             ENDIF
57:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 69 a 78:
69:             IF loc_lContinuar
70:                 THIS.ConfigurarCabecalho()
71:                 THIS.ConfigurarPageFrame()
72:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74:                 THIS.ConfigurarFiltros()
75:                 IF !THIS.CarregarCursores()
76:                     loc_lContinuar = .F.
77:                 ENDIF
78:             ENDIF

*-- Linhas 102 a 165:
102:         loc_oCab = THIS.cnt_4c_Cabecalho
103: 
104:         WITH loc_oCab
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Top       = 22
117:                 .Left      = 22
118:                 .Width     = THIS.Width
119:                 .Height    = 30
120:                 .Caption   = ""
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 14
123:                 .FontBold  = .T.
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .BackStyle = 0
126:                 .Visible   = .T.
127:             ENDWITH
128: 
129:             .AddObject("lbl_4c_Titulo", "Label")
130:             WITH .lbl_4c_Titulo
131:                 .Top       = 20
132:                 .Left      = 20
133:                 .Width     = THIS.Width
134:                 .Height    = 30
135:                 .Caption   = ""
136:                 .FontName  = "Tahoma"
137:                 .FontSize  = 14
138:                 .FontBold  = .T.
139:                 .ForeColor = RGB(255, 255, 255)
140:                 .BackStyle = 0
141:                 .Visible   = .T.
142:             ENDWITH
143: 
144:             .AddObject("cmg_4c_Botoes", "CommandGroup")
145:             WITH .cmg_4c_Botoes
146:                 .Top           = 0
147:                 .Left          = 1026
148:                 .Width         = THIS.Width
149:                 .Height        = 80
150:                 .ButtonCount   = 4
151:                 .BackStyle     = 0
152:                 .BorderColor   = RGB(136, 189, 188)
153:                 .SpecialEffect = 1
154:                 .Themes        = .F.
155:                 .Visible       = .T.
156: 
157:                 WITH .Buttons(1)
158:                     .Caption         = "Visualizar"
159:                     .Top             = 5
160:                     .Left            = 5
161:                     .Width           = THIS.Width
162:                     .Height          = 70
163:                     .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
164:                     .PicturePosition = 13
165:                     .FontBold        = .T.

*-- Linhas 172 a 227:
172:                 ENDWITH
173: 
174:                 WITH .Buttons(2)
175:                     .Caption         = "Imprimir"
176:                     .Top             = 5
177:                     .Left            = 71
178:                     .Width           = THIS.Width
179:                     .Height          = 70
180:                     .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
181:                     .PicturePosition = 13
182:                     .FontName        = "Comic Sans MS"
183:                     .FontBold        = .T.
184:                     .FontItalic      = .T.
185:                     .FontSize        = 8
186:                     .BackColor       = RGB(255, 255, 255)
187:                     .ForeColor       = RGB(90, 90, 90)
188:                     .SpecialEffect   = 0
189:                     .MousePointer    = 15
190:                     .Themes          = .F.
191:                 ENDWITH
192: 
193:                 WITH .Buttons(3)
194:                     .Caption         = "Doc. Excel"
195:                     .Top             = 5
196:                     .Left            = 137
197:                     .Width           = THIS.Width
198:                     .Height          = 70
199:                     .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
200:                     .PicturePosition = 13
201:                     .FontName        = "Comic Sans MS"
202:                     .FontBold        = .T.
203:                     .FontItalic      = .T.
204:                     .FontSize        = 8
205:                     .BackColor       = RGB(255, 255, 255)
206:                     .ForeColor       = RGB(90, 90, 90)
207:                     .SpecialEffect   = 0
208:                     .MousePointer    = 15
209:                     .Themes          = .F.
210:                 ENDWITH
211: 
212:                 WITH .Buttons(4)
213:                     .Caption         = "Sair"
214:                     .Top             = 5
215:                     .Left            = 203
216:                     .Width           = THIS.Width
217:                     .Height          = 70
218:                     .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
219:                     .PicturePosition = 13
220:                     .Cancel          = .T.
221:                     .FontName        = "Comic Sans MS"
222:                     .FontBold        = .T.
223:                     .FontItalic      = .T.
224:                     .FontSize        = 8
225:                     .BackColor       = RGB(255, 255, 255)
226:                     .ForeColor       = RGB(90, 90, 90)
227:                     .SpecialEffect   = 0

*-- Linhas 249 a 263:
249:         loc_oPgf = THIS.pgf_4c_Paginas
250: 
251:         loc_oPgf.PageCount   = 1
252:         loc_oPgf.Top         = 85
253:         loc_oPgf.Left        = -1
254:         loc_oPgf.Width       = THIS.Width + 2
255:         loc_oPgf.Height      = THIS.Height - 85
256:         loc_oPgf.Tabs        = .F.
257: 
258:         loc_oPgf.Page1.Caption   = "Filtros"
259:         loc_oPgf.Page1.FontName  = "Tahoma"
260:         loc_oPgf.Page1.FontSize  = 8
261:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
262:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
263:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 275 a 396:
275:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
276: 
277:         *-- Tipo de relatorio (Analitico/Sintetico/Fluxo de Caixa)
278:         loc_oPg1.AddObject("lbl_4c_Label2", "Label")
279:         WITH loc_oPg1.lbl_4c_Label2
280:             .Top       = 20
281:             .Left      = 64
282:             .Width     = 35
283:             .Height    = 15
284:             .Caption   = "Tipo :"
285:             .FontName  = "Tahoma"
286:             .FontSize  = 8
287:             .ForeColor = RGB(90, 90, 90)
288:             .BackStyle = 0
289:             .AutoSize  = .T.
290:             .Visible   = .T.
291:         ENDWITH
292: 
293:         loc_oPg1.AddObject("obj_4c_Opt_AnaSi", "OptionGroup")
294:         WITH loc_oPg1.obj_4c_Opt_AnaSi
295:             .Top         = 13
296:             .Left        = 92
297:             .Width       = 265
298:             .Height      = 29
299:             .ButtonCount = 3
300:             .BackStyle   = 0
301:             .BorderStyle = 0
302:             .Value       = 1
303:             .Visible     = .T.
304:             WITH .Buttons(1)
305:                 .Caption   = "Anal" + CHR(237) + "tico"
306:                 .Value     = 1
307:                 .Top       = 6
308:                 .Left      = 5
309:                 .Width     = 58
310:                 .Height    = 15
311:                 .AutoSize  = .T.
312:                 .BackStyle = 0
313:                 .ForeColor = RGB(90, 90, 90)
314:             ENDWITH
315:             WITH .Buttons(2)
316:                 .Caption   = "Sint" + CHR(233) + "tico"
317:                 .Value     = 0
318:                 .Top       = 6
319:                 .Left      = 76
320:                 .Width     = 59
321:                 .Height    = 15
322:                 .AutoSize  = .T.
323:                 .BackStyle = 0
324:                 .FontName  = "Tahoma"
325:                 .FontSize  = 8
326:                 .ForeColor = RGB(90, 90, 90)
327:             ENDWITH
328:             WITH .Buttons(3)
329:                 .Caption   = "Fluxo de Caixa"
330:                 .Top       = 6
331:                 .Left      = 151
332:                 .Width     = 89
333:                 .Height    = 15
334:                 .AutoSize  = .T.
335:                 .BackStyle = 0
336:                 .FontName  = "Tahoma"
337:                 .FontSize  = 8
338:                 .ForeColor = RGB(90, 90, 90)
339:             ENDWITH
340:         ENDWITH
341: 
342:         *-- Periodo (DtInicial / DtFinal)
343:         loc_oPg1.AddObject("lbl_4c_LblPeriodo", "Label")
344:         WITH loc_oPg1.lbl_4c_LblPeriodo
345:             .Top       = 44
346:             .Left      = 29
347:             .Width     = 80
348:             .Height    = 15
349:             .Caption   = "Vencimento :"
350:             .FontName  = "Tahoma"
351:             .FontSize  = 8
352:             .ForeColor = RGB(90, 90, 90)
353:             .BackStyle = 0
354:             .AutoSize  = .T.
355:             .Visible   = .T.
356:         ENDWITH
357: 
358:         loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
359:         WITH loc_oPg1.txt_4c_DtInicial
360:             .Top           = 40
361:             .Left          = 98
362:             .Width         = 80
363:             .Height        = 24
364:             .Value         = {}
365:             .FontName      = "Tahoma"
366:             .FontSize      = 8
367:             .ForeColor     = RGB(0, 0, 0)
368:             .BackColor     = RGB(255, 255, 255)
369:             .BorderStyle   = 1
370:             .SpecialEffect = 1
371:             .Visible       = .T.
372:         ENDWITH
373: 
374:         loc_oPg1.AddObject("lbl_4c_Label3", "Label")
375:         WITH loc_oPg1.lbl_4c_Label3
376:             .Top       = 45
377:             .Left      = 183
378:             .Width     = 18
379:             .Height    = 15
380:             .Caption   = "at" + CHR(233)
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .ForeColor = RGB(90, 90, 90)
384:             .BackStyle = 0
385:             .Visible   = .T.
386:         ENDWITH
387: 
388:         loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
389:         WITH loc_oPg1.txt_4c_DtFinal
390:             .Top           = 40
391:             .Left          = 208
392:             .Width         = 80
393:             .Height        = 24
394:             .Value         = {}
395:             .FontName      = "Tahoma"
396:             .FontSize      = 8

*-- Linhas 404 a 478:
404:         *-- Tipo de data (Vencimento/Emissao/Lancamento)
405:         loc_oPg1.AddObject("obj_4c_OptDatas", "OptionGroup")
406:         WITH loc_oPg1.obj_4c_OptDatas
407:             .Top         = 39
408:             .Left        = 287
409:             .Width       = 265
410:             .Height      = 29
411:             .ButtonCount = 3
412:             .BackStyle   = 0
413:             .BorderStyle = 0
414:             .Value       = 1
415:             .Visible     = .T.
416:             WITH .Buttons(1)
417:                 .Caption   = "Vencimento"
418:                 .Value     = 1
419:                 .Top       = 6
420:                 .Left      = 5
421:                 .Width     = 73
422:                 .Height    = 15
423:                 .AutoSize  = .T.
424:                 .BackStyle = 0
425:                 .ForeColor = RGB(90, 90, 90)
426:             ENDWITH
427:             WITH .Buttons(2)
428:                 .Caption   = "Emiss" + CHR(227) + "o"
429:                 .Value     = 0
430:                 .Top       = 6
431:                 .Left      = 91
432:                 .Width     = 56
433:                 .Height    = 15
434:                 .AutoSize  = .T.
435:                 .BackStyle = 0
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 8
438:                 .ForeColor = RGB(90, 90, 90)
439:             ENDWITH
440:             WITH .Buttons(3)
441:                 .Caption   = "Lan" + CHR(231) + "amento"
442:                 .Top       = 6
443:                 .Left      = 159
444:                 .Width     = 76
445:                 .Height    = 15
446:                 .AutoSize  = .T.
447:                 .BackStyle = 0
448:                 .FontName  = "Tahoma"
449:                 .FontSize  = 8
450:                 .ForeColor = RGB(90, 90, 90)
451:             ENDWITH
452:         ENDWITH
453: 
454:         *-- Saldo Inicial
455:         loc_oPg1.AddObject("lbl_4c_Label10", "Label")
456:         WITH loc_oPg1.lbl_4c_Label10
457:             .Top       = 44
458:             .Left      = 584
459:             .Width     = 80
460:             .Height    = 15
461:             .Caption   = "Saldo Inicial :"
462:             .FontName  = "Tahoma"
463:             .FontSize  = 8
464:             .ForeColor = RGB(90, 90, 90)
465:             .BackStyle = 0
466:             .AutoSize  = .T.
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         loc_oPg1.AddObject("txt_4c_Saldo", "TextBox")
471:         WITH loc_oPg1.txt_4c_Saldo
472:             .Top           = 40
473:             .Left          = 652
474:             .Width         = 148
475:             .Height        = 24
476:             .Value         = 0
477:             .Alignment     = 1
478:             .Format        = "K"

*-- Linhas 487 a 561:
487:         *-- Saldos (Informado/Data Inicial/Data Atual)
488:         loc_oPg1.AddObject("obj_4c_OptSaldos", "OptionGroup")
489:         WITH loc_oPg1.obj_4c_OptSaldos
490:             .Top         = 40
491:             .Left        = 798
492:             .Width       = 265
493:             .Height      = 29
494:             .ButtonCount = 3
495:             .BackStyle   = 0
496:             .BorderStyle = 0
497:             .Value       = 1
498:             .Visible     = .T.
499:             WITH .Buttons(1)
500:                 .Caption   = "Informado"
501:                 .Value     = 1
502:                 .Top       = 6
503:                 .Left      = 5
504:                 .Width     = 68
505:                 .Height    = 15
506:                 .AutoSize  = .T.
507:                 .BackStyle = 0
508:                 .ForeColor = RGB(90, 90, 90)
509:             ENDWITH
510:             WITH .Buttons(2)
511:                 .Caption   = "Data Inicial"
512:                 .Value     = 0
513:                 .Top       = 6
514:                 .Left      = 87
515:                 .Width     = 71
516:                 .Height    = 15
517:                 .AutoSize  = .T.
518:                 .BackStyle = 0
519:                 .FontName  = "Tahoma"
520:                 .FontSize  = 8
521:                 .ForeColor = RGB(90, 90, 90)
522:             ENDWITH
523:             WITH .Buttons(3)
524:                 .Caption   = "Data Atual"
525:                 .Top       = 6
526:                 .Left      = 176
527:                 .Width     = 69
528:                 .Height    = 15
529:                 .AutoSize  = .T.
530:                 .BackStyle = 0
531:                 .FontName  = "Tahoma"
532:                 .FontSize  = 8
533:                 .ForeColor = RGB(90, 90, 90)
534:             ENDWITH
535:         ENDWITH
536: 
537:         *-- Grupo contabil
538:         loc_oPg1.AddObject("lbl_4c_Label5", "Label")
539:         WITH loc_oPg1.lbl_4c_Label5
540:             .Top       = 72
541:             .Left      = 55
542:             .Width     = 40
543:             .Height    = 15
544:             .Caption   = "Grupo :"
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .ForeColor = RGB(90, 90, 90)
548:             .BackStyle = 0
549:             .AutoSize  = .T.
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         loc_oPg1.AddObject("txt_4c_Grupo", "TextBox")
554:         WITH loc_oPg1.txt_4c_Grupo
555:             .Top           = 67
556:             .Left          = 98
557:             .Width         = 80
558:             .Height        = 24
559:             .Value         = ""
560:             .Format        = "K"
561:             .MaxLength     = 10

*-- Linhas 570 a 579:
570: 
571:         loc_oPg1.AddObject("txt_4c_DGrupo", "TextBox")
572:         WITH loc_oPg1.txt_4c_DGrupo
573:             .Top           = 67
574:             .Left          = 181
575:             .Width         = 301
576:             .Height        = 24
577:             .Value         = ""
578:             .Format        = "K"
579:             .MaxLength     = 20

*-- Linhas 588 a 637:
588:         BINDEVENT(loc_oPg1.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoKeyPress")
589: 
590:         *-- Juros
591:         loc_oPg1.AddObject("lbl_4c_Label6", "Label")
592:         WITH loc_oPg1.lbl_4c_Label6
593:             .Top       = 71
594:             .Left      = 614
595:             .Width     = 40
596:             .Height    = 15
597:             .Caption   = "Juros :"
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .ForeColor = RGB(90, 90, 90)
601:             .BackStyle = 0
602:             .AutoSize  = .T.
603:             .Visible   = .T.
604:         ENDWITH
605: 
606:         loc_oPg1.AddObject("obj_4c_Opt_Juros", "OptionGroup")
607:         WITH loc_oPg1.obj_4c_Opt_Juros
608:             .Top         = 68
609:             .Left        = 646
610:             .Width       = 91
611:             .Height      = 23
612:             .ButtonCount = 2
613:             .BackStyle   = 0
614:             .BorderStyle = 0
615:             .Value       = 2
616:             .Visible     = .T.
617:             WITH .Buttons(1)
618:                 .Caption   = "Sim"
619:                 .Value     = 0
620:                 .Top       = 5
621:                 .Left      = 5
622:                 .Width     = 38
623:                 .Height    = 17
624:                 .AutoSize  = .F.
625:                 .BackStyle = 0
626:                 .ForeColor = RGB(90, 90, 90)
627:             ENDWITH
628:             WITH .Buttons(2)
629:                 .Caption   = "N" + CHR(227) + "o"
630:                 .Value     = 1
631:                 .Top       = 5
632:                 .Left      = 48
633:                 .Width     = 38
634:                 .Height    = 17
635:                 .AutoSize  = .F.
636:                 .BackStyle = 0
637:                 .FontName  = "Tahoma"

*-- Linhas 643 a 652:
643: 
644:         loc_oPg1.AddObject("txt_4c__Juros", "TextBox")
645:         WITH loc_oPg1.txt_4c__Juros
646:             .Top           = 67
647:             .Left          = 749
648:             .Width         = 51
649:             .Height        = 24
650:             .Value         = 0
651:             .Alignment     = 1
652:             .Format        = "K"

*-- Linhas 659 a 738:
659:         ENDWITH
660:         BINDEVENT(loc_oPg1.txt_4c__Juros, "When", THIS, "JurosWhen")
661: 
662:         loc_oPg1.AddObject("lbl_4c_Label7", "Label")
663:         WITH loc_oPg1.lbl_4c_Label7
664:             .Top       = 72
665:             .Left      = 802
666:             .Width     = 40
667:             .Height    = 15
668:             .Caption   = "% m" + CHR(234) + "s"
669:             .FontName  = "Tahoma"
670:             .FontSize  = 8
671:             .ForeColor = RGB(90, 90, 90)
672:             .BackStyle = 0
673:             .AutoSize  = .T.
674:             .Visible   = .T.
675:         ENDWITH
676: 
677:         *-- Pagamentos / Recebimentos
678:         loc_oPg1.AddObject("chk_4c_Ck_Pagamentos", "CheckBox")
679:         WITH loc_oPg1.chk_4c_Ck_Pagamentos
680:             .Top       = 74
681:             .Left      = 889
682:             .Width     = 90
683:             .Height    = 15
684:             .Caption   = "Pagamentos"
685:             .Value     = 0
686:             .BackStyle = 0
687:             .Alignment = 0
688:             .AutoSize  = .T.
689:             .FontName  = "Tahoma"
690:             .FontSize  = 8
691:             .ForeColor = RGB(90, 90, 90)
692:             .Visible   = .T.
693:         ENDWITH
694:         BINDEVENT(loc_oPg1.chk_4c_Ck_Pagamentos, "InteractiveChange", THIS, "PagamentosChange")
695: 
696:         loc_oPg1.AddObject("chk_4c_Ck_Recebimentos", "CheckBox")
697:         WITH loc_oPg1.chk_4c_Ck_Recebimentos
698:             .Top       = 97
699:             .Left      = 889
700:             .Width     = 100
701:             .Height    = 15
702:             .Caption   = "Recebimentos"
703:             .Value     = 0
704:             .BackStyle = 0
705:             .Alignment = 0
706:             .AutoSize  = .T.
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .ForeColor = RGB(90, 90, 90)
710:             .Visible   = .T.
711:         ENDWITH
712:         BINDEVENT(loc_oPg1.chk_4c_Ck_Recebimentos, "InteractiveChange", THIS, "RecebimentosChange")
713: 
714:         *-- Conta contabil
715:         loc_oPg1.AddObject("lbl_4c_Lbl_estoque", "Label")
716:         WITH loc_oPg1.lbl_4c_Lbl_estoque
717:             .Top       = 99
718:             .Left      = 55
719:             .Width     = 40
720:             .Height    = 15
721:             .Caption   = "Conta :"
722:             .FontName  = "Tahoma"
723:             .FontSize  = 8
724:             .ForeColor = RGB(90, 90, 90)
725:             .BackStyle = 0
726:             .AutoSize  = .T.
727:             .Visible   = .T.
728:         ENDWITH
729: 
730:         loc_oPg1.AddObject("txt_4c_Conta", "TextBox")
731:         WITH loc_oPg1.txt_4c_Conta
732:             .Top           = 94
733:             .Left          = 98
734:             .Width         = 80
735:             .Height        = 24
736:             .Value         = ""
737:             .Format        = "K"
738:             .MaxLength     = 10

*-- Linhas 747 a 756:
747: 
748:         loc_oPg1.AddObject("txt_4c_DConta", "TextBox")
749:         WITH loc_oPg1.txt_4c_DConta
750:             .Top           = 94
751:             .Left          = 181
752:             .Width         = 301
753:             .Height        = 24
754:             .Value         = ""
755:             .Format        = "K"
756:             .MaxLength     = 40

*-- Linhas 765 a 791:
765:         BINDEVENT(loc_oPg1.txt_4c_DConta, "KeyPress", THIS, "TxtDContaKeyPress")
766: 
767:         *-- Moeda
768:         loc_oPg1.AddObject("lbl_4c_Lbl_fator", "Label")
769:         WITH loc_oPg1.lbl_4c_Lbl_fator
770:             .Top       = 98
771:             .Left      = 608
772:             .Width     = 50
773:             .Height    = 15
774:             .Caption   = "Moeda :"
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .ForeColor = RGB(90, 90, 90)
778:             .BackStyle = 0
779:             .AutoSize  = .T.
780:             .Visible   = .T.
781:         ENDWITH
782: 
783:         loc_oPg1.AddObject("txt_4c__cd_moeda", "TextBox")
784:         WITH loc_oPg1.txt_4c__cd_moeda
785:             .Top           = 94
786:             .Left          = 652
787:             .Width         = 31
788:             .Height        = 24
789:             .Value         = ""
790:             .Format        = "K"
791:             .MaxLength     = 3

*-- Linhas 802 a 811:
802: 
803:         loc_oPg1.AddObject("txt_4c__ds_moeda", "TextBox")
804:         WITH loc_oPg1.txt_4c__ds_moeda
805:             .Top           = 94
806:             .Left          = 685
807:             .Width         = 115
808:             .Height        = 24
809:             .Value         = ""
810:             .Format        = "K"
811:             .MaxLength     = 15

*-- Linhas 819 a 845:
819:         BINDEVENT(loc_oPg1.txt_4c__ds_moeda, "KeyPress",   THIS, "TxtMoedaDsKeyPress")
820: 
821:         *-- Job (centro de custo)
822:         loc_oPg1.AddObject("lbl_4c_Label11", "Label")
823:         WITH loc_oPg1.lbl_4c_Label11
824:             .Top       = 125
825:             .Left      = 67
826:             .Width     = 30
827:             .Height    = 15
828:             .Caption   = "Job :"
829:             .FontName  = "Tahoma"
830:             .FontSize  = 8
831:             .ForeColor = RGB(90, 90, 90)
832:             .BackStyle = 0
833:             .AutoSize  = .T.
834:             .Visible   = .T.
835:         ENDWITH
836: 
837:         loc_oPg1.AddObject("txt_4c__Jobs", "TextBox")
838:         WITH loc_oPg1.txt_4c__Jobs
839:             .Top           = 120
840:             .Left          = 98
841:             .Width         = 80
842:             .Height        = 24
843:             .Value         = ""
844:             .FontName      = "Tahoma"
845:             .FontSize      = 8

*-- Linhas 853 a 862:
853: 
854:         loc_oPg1.AddObject("txt_4c_DJobs", "TextBox")
855:         WITH loc_oPg1.txt_4c_DJobs
856:             .Top           = 120
857:             .Left          = 181
858:             .Width         = 301
859:             .Height        = 24
860:             .Value         = ""
861:             .MaxLength     = 40
862:             .FontName      = "Tahoma"

*-- Linhas 871 a 897:
871:         BINDEVENT(loc_oPg1.txt_4c_DJobs, "KeyPress", THIS, "TxtDJobsKeyPress")
872: 
873:         *-- Numero da operacao
874:         loc_oPg1.AddObject("lbl_4c_Label9", "Label")
875:         WITH loc_oPg1.lbl_4c_Label9
876:             .Top       = 125
877:             .Left      = 607
878:             .Width     = 50
879:             .Height    = 15
880:             .Caption   = "C" + CHR(243) + "digo :"
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8
883:             .ForeColor = RGB(90, 90, 90)
884:             .BackStyle = 0
885:             .AutoSize  = .T.
886:             .Visible   = .T.
887:         ENDWITH
888: 
889:         loc_oPg1.AddObject("txt_4c__Numes", "TextBox")
890:         WITH loc_oPg1.txt_4c__Numes
891:             .Top           = 121
892:             .Left          = 653
893:             .Width         = 80
894:             .Height        = 24
895:             .Value         = 0
896:             .Format        = "K"
897:             .MaxLength     = 10

*-- Linhas 904 a 963:
904:         ENDWITH
905: 
906:         *-- Autorizados
907:         loc_oPg1.AddObject("lbl_4c_Label12", "Label")
908:         WITH loc_oPg1.lbl_4c_Label12
909:             .Top       = 150
910:             .Left      = 27
911:             .Width     = 70
912:             .Height    = 15
913:             .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o :"
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .ForeColor = RGB(90, 90, 90)
917:             .BackStyle = 0
918:             .AutoSize  = .T.
919:             .Visible   = .T.
920:         ENDWITH
921: 
922:         loc_oPg1.AddObject("obj_4c_OptAutorizados", "OptionGroup")
923:         WITH loc_oPg1.obj_4c_OptAutorizados
924:             .Top         = 145
925:             .Left        = 92
926:             .Width       = 310
927:             .Height      = 27
928:             .ButtonCount = 3
929:             .BackStyle   = 0
930:             .BorderStyle = 0
931:             .Value       = 1
932:             .Visible     = .T.
933:             WITH .Buttons(1)
934:                 .Caption   = "Todos"
935:                 .Top       = 5
936:                 .Left      = 5
937:                 .Width     = 56
938:                 .Height    = 17
939:                 .AutoSize  = .F.
940:                 .BackStyle = 0
941:                 .ForeColor = RGB(90, 90, 90)
942:             ENDWITH
943:             WITH .Buttons(2)
944:                 .Caption   = "Autorizados"
945:                 .Top       = 6
946:                 .Left      = 63
947:                 .Width     = 75
948:                 .Height    = 15
949:                 .AutoSize  = .T.
950:                 .BackStyle = 0
951:                 .FontName  = "Tahoma"
952:                 .FontSize  = 8
953:                 .ForeColor = RGB(90, 90, 90)
954:             ENDWITH
955:             WITH .Buttons(3)
956:                 .Caption   = "N" + CHR(227) + "o Autorizados"
957:                 .Top       = 6
958:                 .Left      = 154
959:                 .Width     = 97
960:                 .Height    = 15
961:                 .AutoSize  = .T.
962:                 .BackStyle = 0
963:                 .FontName  = "Tahoma"

*-- Linhas 1089 a 1131:
1089:         *======================================================================
1090:         *-- GRID EMPRESAS
1091:         *======================================================================
1092:         loc_oPg1.AddObject("lbl_4c_Label1", "Label")
1093:         WITH loc_oPg1.lbl_4c_Label1
1094:             .Top       = 181
1095:             .Left      = 24
1096:             .Width     = 60
1097:             .Height    = 15
1098:             .Caption   = "Empresas"
1099:             .FontName  = "Tahoma"
1100:             .FontSize  = 8
1101:             .FontBold  = .T.
1102:             .ForeColor = RGB(90, 90, 90)
1103:             .BackStyle = 0
1104:             .AutoSize  = .T.
1105:             .Visible   = .T.
1106:         ENDWITH
1107: 
1108:         loc_oPg1.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
1109:         WITH loc_oPg1.chk_4c_Ck_MarcaEmp
1110:             .Top       = 198
1111:             .Left      = 25
1112:             .Width     = 13
1113:             .Height    = 16
1114:             .Caption   = ""
1115:             .Value     = 1
1116:             .Alignment = 0
1117:             .Centered  = .F.
1118:             .Visible   = .T.
1119:         ENDWITH
1120:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaEmp, "Click", THIS, "MarcaEmpClick")
1121: 
1122:         loc_oPg1.AddObject("grd_4c_Emps", "Grid")
1123:         loc_oGrd = loc_oPg1.grd_4c_Emps
1124:         WITH loc_oGrd
1125:             .Top               = 197
1126:             .Left              = 24
1127:             .Width             = 331
1128:             .Height            = 394
1129:             .ColumnCount       = 3
1130:             .FontName          = "Tahoma"
1131:             .FontSize          = 8

*-- Linhas 1153 a 1166:
1153:             .ReadOnly      = .F.
1154:             .Sparse        = .F.
1155:         ENDWITH
1156:         loc_oGrd.Column1.Header1.Caption  = ""
1157:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1158:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
1159:         WITH loc_oGrd.Column1.Check1
1160:             .Alignment = 0
1161:             .Caption   = ""
1162:             .AutoSize  = .T.
1163:             .BackStyle = 0
1164:             .Visible   = .T.
1165:         ENDWITH
1166:         loc_oGrd.Column1.CurrentControl = "Check1"

*-- Linhas 1177 a 1240:
1177:             .Resizable     = .F.
1178:             .ReadOnly      = .T.
1179:         ENDWITH
1180:         loc_oGrd.Column2.Header1.Caption   = "Emp."
1181:         loc_oGrd.Column2.Header1.Alignment = 2
1182:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1183:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1184: 
1185:         WITH loc_oGrd.Column3
1186:             .Width         = 263
1187:             .ControlSource = "cursor_4c_SigCdEmp.Razas"
1188:             .FontName      = "Courier New"
1189:             .Movable       = .F.
1190:             .Resizable     = .F.
1191:             .ReadOnly      = .T.
1192:         ENDWITH
1193:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1194:         loc_oGrd.Column3.Header1.Alignment = 2
1195:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1196:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1197: 
1198:         *======================================================================
1199:         *-- GRID OPERACOES DE TITULO
1200:         *======================================================================
1201:         loc_oPg1.AddObject("lbl_4c_Label4", "Label")
1202:         WITH loc_oPg1.lbl_4c_Label4
1203:             .Top       = 181
1204:             .Left      = 369
1205:             .Width     = 120
1206:             .Height    = 15
1207:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulo"
1208:             .FontName  = "Tahoma"
1209:             .FontSize  = 8
1210:             .FontBold  = .T.
1211:             .ForeColor = RGB(90, 90, 90)
1212:             .BackStyle = 0
1213:             .AutoSize  = .T.
1214:             .Visible   = .T.
1215:         ENDWITH
1216: 
1217:         loc_oPg1.AddObject("chk_4c_Ck_MarcaOpe", "CheckBox")
1218:         WITH loc_oPg1.chk_4c_Ck_MarcaOpe
1219:             .Top       = 198
1220:             .Left      = 371
1221:             .Width     = 13
1222:             .Height    = 16
1223:             .Caption   = ""
1224:             .Value     = 1
1225:             .Alignment = 0
1226:             .Centered  = .F.
1227:             .Visible   = .T.
1228:         ENDWITH
1229:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaOpe, "Click", THIS, "MarcaOpeClick")
1230: 
1231:         loc_oPg1.AddObject("grd_4c_Tipo", "Grid")
1232:         loc_oGrd = loc_oPg1.grd_4c_Tipo
1233:         WITH loc_oGrd
1234:             .Top               = 197
1235:             .Left              = 369
1236:             .Width             = 323
1237:             .Height            = 394
1238:             .ColumnCount       = 2
1239:             .FontName          = "Tahoma"
1240:             .FontSize          = 8

*-- Linhas 1264 a 1277:
1264:             .Sparse        = .F.
1265:             .Enabled       = .T.
1266:         ENDWITH
1267:         loc_oGrd.Column1.Header1.Caption  = ""
1268:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1269:         loc_oGrd.Column1.AddObject("check12", "CheckBox")
1270:         WITH loc_oGrd.Column1.check12
1271:             .Alignment = 0
1272:             .Caption   = ""
1273:             .AutoSize  = .T.
1274:             .BackStyle = 0
1275:             .Enabled   = .T.
1276:             .Visible   = .T.
1277:         ENDWITH

*-- Linhas 1290 a 1342:
1290:             .ReadOnly      = .T.
1291:             .Enabled       = .T.
1292:         ENDWITH
1293:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1294:         loc_oGrd.Column2.Header1.Alignment = 2
1295:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1296:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1297:         loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
1298:         loc_oGrd.Column2.Text1.ReadOnly    = .T.
1299: 
1300:         *======================================================================
1301:         *-- GRID CLASSIFICACOES
1302:         *======================================================================
1303:         loc_oPg1.AddObject("lbl_4c_Label8", "Label")
1304:         WITH loc_oPg1.lbl_4c_Label8
1305:             .Top       = 180
1306:             .Left      = 706
1307:             .Width     = 95
1308:             .Height    = 15
1309:             .Caption   = "Classifica" + CHR(231) + CHR(245) + "es"
1310:             .FontName  = "Tahoma"
1311:             .FontSize  = 8
1312:             .FontBold  = .T.
1313:             .ForeColor = RGB(90, 90, 90)
1314:             .BackStyle = 0
1315:             .AutoSize  = .T.
1316:             .Visible   = .T.
1317:         ENDWITH
1318: 
1319:         loc_oPg1.AddObject("chk_4c_Ck_MarcaCla", "CheckBox")
1320:         WITH loc_oPg1.chk_4c_Ck_MarcaCla
1321:             .Top       = 198
1322:             .Left      = 708
1323:             .Width     = 13
1324:             .Height    = 16
1325:             .Caption   = ""
1326:             .Value     = 1
1327:             .Alignment = 0
1328:             .Centered  = .F.
1329:             .Visible   = .T.
1330:         ENDWITH
1331:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaCla, "Click", THIS, "MarcaClaClick")
1332: 
1333:         loc_oPg1.AddObject("grd_4c_Cla", "Grid")
1334:         loc_oGrd = loc_oPg1.grd_4c_Cla
1335:         WITH loc_oGrd
1336:             .Top               = 197
1337:             .Left              = 706
1338:             .Width             = 574
1339:             .Height            = 394
1340:             .ColumnCount       = 3
1341:             .FontName          = "Tahoma"
1342:             .FontSize          = 8

*-- Linhas 1364 a 1377:
1364:             .ReadOnly      = .F.
1365:             .Sparse        = .F.
1366:         ENDWITH
1367:         loc_oGrd.Column1.Header1.Caption  = ""
1368:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1369:         loc_oGrd.Column1.AddObject("check13", "CheckBox")
1370:         WITH loc_oGrd.Column1.check13
1371:             .Alignment = 0
1372:             .Caption   = ""
1373:             .AutoSize  = .T.
1374:             .BackStyle = 0
1375:             .Visible   = .T.
1376:         ENDWITH
1377:         loc_oGrd.Column1.CurrentControl = "check13"

*-- Linhas 1388 a 1396:
1388:             .Resizable     = .F.
1389:             .ReadOnly      = .T.
1390:         ENDWITH
1391:         loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
1392:         loc_oGrd.Column2.Header1.Alignment = 2
1393:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1394:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1395:         loc_oGrd.Column2.Text1.ReadOnly    = .F.
1396: 

*-- Linhas 1402 a 1410:
1402:             .Resizable     = .F.
1403:             .ReadOnly      = .T.
1404:         ENDWITH
1405:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1406:         loc_oGrd.Column3.Header1.Alignment = 2
1407:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1408:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1409:         loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
1410:         loc_oGrd.Column3.Text1.ReadOnly    = .T.

*-- Linhas 1456 a 1464:
1456:             "Pagamento:", "Recebimento:")
1457:         loc_oPg1.txt_4c__Numes.Enabled     = par_lPagRec
1458:         loc_oPg1.obj_4c_Opt_AnaSi.Enabled  = !par_lPagRec
1459:         loc_oPg1.lbl_4c_LblPeriodo.Caption = IIF(par_lPagRec, loc_cLabel, "Vencimento :")
1460:         loc_oPg1.obj_4c_Opt_Juros.Enabled  = !par_lPagRec
1461:         loc_oPg1.txt_4c__Juros.Enabled     = !par_lPagRec
1462:     ENDPROC
1463: 
1464:     *--------------------------------------------------------------------------

*-- Linhas 1569 a 1577:
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * HANDLERS MARCAR/DESMARCAR TODOS (checkboxes acima de cada grid)
1573:     *==========================================================================
1574: 
1575:     PROCEDURE MarcaEmpClick()
1576:         LOCAL loc_nImps
1577:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaEmp.Value = 1, 1, 0)

*-- Linhas 1594 a 1602:
1594:     ENDPROC
1595: 
1596:     *==========================================================================
1597:     * HANDLERS CHECKBOX DO GRID EMPRESAS
1598:     *==========================================================================
1599: 
1600:     PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1601:         LOCAL loc_nImps
1602:         loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 0, 1, 0)

*-- Linhas 1624 a 1632:
1624:     ENDPROC
1625: 
1626:     *==========================================================================
1627:     * HANDLERS CHECKBOX DO GRID TIPO (OPERACOES)
1628:     *==========================================================================
1629: 
1630:     PROCEDURE TipoCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1631:         LOCAL loc_nImps
1632:         loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 0, 1, 0)

*-- Linhas 1654 a 1662:
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * HANDLERS CHECKBOX DO GRID CLASSIFICACOES
1658:     *==========================================================================
1659: 
1660:     PROCEDURE ClaCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1661:         LOCAL loc_nImps
1662:         loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 0, 1, 0)

