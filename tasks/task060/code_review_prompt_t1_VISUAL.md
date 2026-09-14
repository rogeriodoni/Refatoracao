# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 188: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecom.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1396 linhas total):

*-- Linhas 17 a 25:
17: * Dimensoes originais: Width=800, Height=300
18: * Cabecalho Top=0, Height=80
19: * PageFrame Top=85, Height=215 (300-85)
20: * Page1.Top = Top_original - 85
21: *==============================================================================
22: 
23: DEFINE CLASS Formsigrecom AS FormBase
24: 
25:     Height      = 300

*-- Linhas 56 a 64:
56:         loc_lContinuar = .T.
57: 
58:         TRY
59:             THIS.Caption = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
60: 
61:             IF TYPE("gc_4c_CaminhoIcones") = "U"
62:                 gc_4c_CaminhoIcones = ""
63:             ENDIF
64:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 76 a 85:
76:             IF loc_lContinuar
77:                 THIS.ConfigurarCabecalho()
78:                 THIS.ConfigurarPageFrame()
79:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81:                 THIS.ConfigurarPaginaLista()
82:                 THIS.ConfigurarPaginaDados()
83:                 THIS.LimparCampos()
84:                 THIS.InicializarOpcoes()
85:                 loc_lSucesso = .T.

*-- Linhas 106 a 171:
106:         loc_oCab = THIS.cnt_4c_Cabecalho
107: 
108:         WITH loc_oCab
109:             .Top         = 0
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackStyle   = 1
114:             .BackColor   = RGB(100, 100, 100)
115:             .BorderWidth = 0
116:             .Visible     = .T.
117: 
118:             .AddObject("lbl_4c_Sombra", "Label")
119:             WITH .lbl_4c_Sombra
120:                 .Top       = 22
121:                 .Left      = 22
122:                 .Width     = THIS.Width
123:                 .Height    = 30
124:                 .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
125:                 .FontName  = "Tahoma"
126:                 .FontSize  = 14
127:                 .FontBold  = .T.
128:                 .ForeColor = RGB(0, 0, 0)
129:                 .BackStyle = 0
130:                 .Visible   = .T.
131:             ENDWITH
132: 
133:             .AddObject("lbl_4c_Titulo", "Label")
134:             WITH .lbl_4c_Titulo
135:                 .Top       = 20
136:                 .Left      = 20
137:                 .Width     = THIS.Width
138:                 .Height    = 30
139:                 .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
140:                 .FontName  = "Tahoma"
141:                 .FontSize  = 14
142:                 .FontBold  = .T.
143:                 .ForeColor = RGB(255, 255, 255)
144:                 .BackStyle = 0
145:                 .Visible   = .T.
146:             ENDWITH
147: 
148:             *-- Botoes de relatorio (framework frmrelatorio: cmg_4c_Botoes)
149:             *-- Left=529 Width=273 canonico frmrelatorio; FontName=Comic Sans MS; Width=65 por botao
150:             .AddObject("cmg_4c_Botoes", "CommandGroup")
151:             WITH .cmg_4c_Botoes
152:                 .Top           = 0
153:                 .Left          = 529
154:                 .Width         = THIS.Width
155:                 .Height        = 80
156:                 .ButtonCount   = 4
157:                 .BackStyle     = 0
158:                 .BorderColor   = RGB(136, 189, 188)
159:                 .SpecialEffect = 1
160:                 .Themes        = .F.
161:                 .Visible       = .T.
162: 
163:                 WITH .Buttons(1)
164:                     .Caption         = "Visualizar"
165:                     .Top             = 5
166:                     .Left            = 5
167:                     .Width           = THIS.Width
168:                     .Height          = 70
169:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
170:                     .PicturePosition = 13
171:                     .FontBold        = .T.

*-- Linhas 178 a 233:
178:                 ENDWITH
179: 
180:                 WITH .Buttons(2)
181:                     .Caption         = "Imprimir"
182:                     .Top             = 5
183:                     .Left            = 71
184:                     .Width           = THIS.Width
185:                     .Height          = 70
186:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
187:                     .PicturePosition = 13
188:                     .FontName        = "Comic Sans MS"
189:                     .FontSize        = 8
190:                     .FontBold        = .T.
191:                     .FontItalic      = .T.
192:                     .BackColor       = RGB(255, 255, 255)
193:                     .ForeColor       = RGB(90, 90, 90)
194:                     .SpecialEffect   = 0
195:                     .MousePointer    = 15
196:                     .Themes          = .F.
197:                 ENDWITH
198: 
199:                 WITH .Buttons(3)
200:                     .Caption         = "Doc. Excel"
201:                     .Top             = 5
202:                     .Left            = 137
203:                     .Width           = THIS.Width
204:                     .Height          = 70
205:                     .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
206:                     .PicturePosition = 13
207:                     .FontName        = "Comic Sans MS"
208:                     .FontSize        = 8
209:                     .FontBold        = .T.
210:                     .FontItalic      = .T.
211:                     .BackColor       = RGB(255, 255, 255)
212:                     .ForeColor       = RGB(90, 90, 90)
213:                     .SpecialEffect   = 0
214:                     .MousePointer    = 15
215:                     .Themes          = .F.
216:                 ENDWITH
217: 
218:                 WITH .Buttons(4)
219:                     .Caption         = "Sair"
220:                     .Top             = 5
221:                     .Left            = 203
222:                     .Width           = THIS.Width
223:                     .Height          = 70
224:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
225:                     .PicturePosition = 13
226:                     .Cancel          = .T.
227:                     .FontName        = "Comic Sans MS"
228:                     .FontSize        = 8
229:                     .FontBold        = .T.
230:                     .FontItalic      = .T.
231:                     .BackColor       = RGB(255, 255, 255)
232:                     .ForeColor       = RGB(90, 90, 90)
233:                     .SpecialEffect   = 0

*-- Linhas 256 a 270:
256:         loc_oPgf = THIS.pgf_4c_Paginas
257: 
258:         loc_oPgf.PageCount = 1
259:         loc_oPgf.Top       = 85
260:         loc_oPgf.Left      = -1
261:         loc_oPgf.Width     = THIS.Width + 2
262:         loc_oPgf.Height    = THIS.Height - 85
263:         loc_oPgf.Tabs      = .F.
264: 
265:         loc_oPgf.Page1.Caption   = "Filtros"
266:         loc_oPgf.Page1.FontName  = "Tahoma"
267:         loc_oPgf.Page1.FontSize  = 8
268:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
269:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
270:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 283 a 308:
283:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
284: 
285:         *-- Periodo
286:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
287:         WITH loc_oPagina.lbl_4c_Periodo
288:             .Top       = 7
289:             .Left      = 215
290:             .Width     = 46
291:             .Height    = 18
292:             .Caption   = "Per" + CHR(237) + "odo :"
293:             .FontName  = "Tahoma"
294:             .FontSize  = 8
295:             .ForeColor = RGB(90, 90, 90)
296:             .BackStyle = 0
297:             .Visible   = .T.
298:         ENDWITH
299: 
300:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
301:         WITH loc_oPagina.txt_4c_DtInicial
302:             .Top         = 3
303:             .Left        = 264
304:             .Width       = 80
305:             .Height      = 23
306:             .Value       = {}
307:             .FontName    = "Tahoma"
308:             .FontSize    = 8

*-- Linhas 315 a 340:
315:         ENDWITH
316:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
317: 
318:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
319:         WITH loc_oPagina.lbl_4c_PeriodoA
320:             .Top       = 8
321:             .Left      = 348
322:             .Width     = 8
323:             .Height    = 18
324:             .Caption   = CHR(224)
325:             .FontName  = "Tahoma"
326:             .FontSize  = 8
327:             .ForeColor = RGB(90, 90, 90)
328:             .BackStyle = 0
329:             .Visible   = .T.
330:         ENDWITH
331: 
332:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
333:         WITH loc_oPagina.txt_4c_DtFinal
334:             .Top         = 3
335:             .Left        = 360
336:             .Width       = 80
337:             .Height      = 23
338:             .Value       = {}
339:             .FontName    = "Tahoma"
340:             .FontSize    = 8

*-- Linhas 348 a 373:
348:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")
349: 
350:         *-- Moeda
351:         loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
352:         WITH loc_oPagina.lbl_4c_Moeda
353:             .Top       = 32
354:             .Left      = 219
355:             .Width     = 42
356:             .Height    = 18
357:             .Caption   = "Moeda :"
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .ForeColor = RGB(90, 90, 90)
361:             .BackStyle = 0
362:             .Visible   = .T.
363:         ENDWITH
364: 
365:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
366:         WITH loc_oPagina.txt_4c_CdMoeda
367:             .Top           = 28
368:             .Left          = 264
369:             .Width         = 31
370:             .Height        = 23
371:             .Value         = ""
372:             .FontName      = "Tahoma"
373:             .FontSize      = 8

*-- Linhas 383 a 392:
383: 
384:         loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
385:         WITH loc_oPagina.txt_4c_DsMoeda
386:             .Top           = 28
387:             .Left          = 297
388:             .Width         = 115
389:             .Height        = 23
390:             .Value         = ""
391:             .FontName      = "Tahoma"
392:             .FontSize      = 8

*-- Linhas 401 a 426:
401:         BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "ValidarDsMoeda")
402: 
403:         *-- Vendedor
404:         loc_oPagina.AddObject("lbl_4c_Vendedor", "Label")
405:         WITH loc_oPagina.lbl_4c_Vendedor
406:             .Top       = 56
407:             .Left      = 205
408:             .Width     = 56
409:             .Height    = 18
410:             .Caption   = "Vendedor :"
411:             .FontName  = "Tahoma"
412:             .FontSize  = 8
413:             .ForeColor = RGB(90, 90, 90)
414:             .BackStyle = 0
415:             .Visible   = .T.
416:         ENDWITH
417: 
418:         loc_oPagina.AddObject("txt_4c_Vendedor", "TextBox")
419:         WITH loc_oPagina.txt_4c_Vendedor
420:             .Top           = 53
421:             .Left          = 264
422:             .Width         = 80
423:             .Height        = 23
424:             .Value         = ""
425:             .FontName      = "Tahoma"
426:             .FontSize      = 8

*-- Linhas 434 a 796:
434:         BINDEVENT(loc_oPagina.txt_4c_Vendedor, "KeyPress", THIS, "ValidarVendedor")
435: 
436:         *-- Opcao (titulos dinamicos de SigCdPac)
437:         loc_oPagina.AddObject("lbl_4c_Opcao", "Label")
438:         WITH loc_oPagina.lbl_4c_Opcao
439:             .Top       = 84
440:             .Left      = 220
441:             .Width     = 40
442:             .Height    = 18
443:             .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .ForeColor = RGB(90, 90, 90)
447:             .BackStyle = 0
448:             .Visible   = .T.
449:         ENDWITH
450: 
451:         loc_oPagina.AddObject("opt_4c_NrOpcao", "OptionGroup")
452:         WITH loc_oPagina.opt_4c_NrOpcao
453:             .Top         = 80
454:             .Left        = 259
455:             .Width       = 220
456:             .Height      = 23
457:             .ButtonCount = 3
458:             .AutoSize    = .F.
459:             .BackStyle   = 0
460:             .BorderStyle = 0
461:             .Value       = 3
462:             .Visible     = .T.
463: 
464:             WITH .Buttons(1)
465:                 .Caption   = "Sim"
466:                 .Top       = 4
467:                 .Left      = 5
468:                 .Width     = 34
469:                 .Height    = 15
470:                 .AutoSize  = .T.
471:                 .BackStyle = 0
472:                 .ForeColor = RGB(90, 90, 90)
473:             ENDWITH
474: 
475:             WITH .Buttons(2)
476:                 .Caption   = "N" + CHR(227) + "o"
477:                 .Top       = 4
478:                 .Left      = 82
479:                 .Width     = 37
480:                 .Height    = 15
481:                 .AutoSize  = .T.
482:                 .BackStyle = 0
483:                 .FontName  = "Tahoma"
484:                 .FontSize  = 8
485:                 .ForeColor = RGB(90, 90, 90)
486:             ENDWITH
487: 
488:             WITH .Buttons(3)
489:                 .Caption   = "Ambos"
490:                 .Top       = 4
491:                 .Left      = 157
492:                 .Width     = 50
493:                 .Height    = 15
494:                 .AutoSize  = .T.
495:                 .BackStyle = 0
496:                 .FontName  = "Tahoma"
497:                 .FontSize  = 8
498:                 .ForeColor = RGB(90, 90, 90)
499:             ENDWITH
500:         ENDWITH
501: 
502:         *-- Tipo (Analitico/Sintetico/Resumo/Analise Medias)
503:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
504:         WITH loc_oPagina.lbl_4c_Tipo
505:             .Top       = 107
506:             .Left      = 231
507:             .Width     = 25
508:             .Height    = 18
509:             .Caption   = "Tipo :"
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .ForeColor = RGB(90, 90, 90)
513:             .BackStyle = 0
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
518:         WITH loc_oPagina.opt_4c_Tipo
519:             .Top         = 103
520:             .Left        = 259
521:             .Width       = 356
522:             .Height      = 23
523:             .ButtonCount = 4
524:             .AutoSize    = .F.
525:             .BackStyle   = 0
526:             .BorderStyle = 0
527:             .Value       = 1
528:             .Visible     = .T.
529: 
530:             WITH .Buttons(1)
531:                 .Caption   = "Anal" + CHR(237) + "tico"
532:                 .Top       = 4
533:                 .Left      = 5
534:                 .Width     = 67
535:                 .Height    = 15
536:                 .AutoSize  = .T.
537:                 .BackStyle = 0
538:                 .ForeColor = RGB(90, 90, 90)
539:             ENDWITH
540: 
541:             WITH .Buttons(2)
542:                 .Caption   = "Sint" + CHR(233) + "tico"
543:                 .Top       = 4
544:                 .Left      = 82
545:                 .Width     = 68
546:                 .Height    = 15
547:                 .AutoSize  = .T.
548:                 .BackStyle = 0
549:                 .FontName  = "Verdana"
550:                 .FontSize  = 8
551:                 .ForeColor = RGB(90, 90, 90)
552:             ENDWITH
553: 
554:             WITH .Buttons(3)
555:                 .Caption   = "Resumo"
556:                 .Top       = 4
557:                 .Left      = 157
558:                 .Width     = 65
559:                 .Height    = 15
560:                 .AutoSize  = .T.
561:                 .BackStyle = 0
562:                 .FontName  = "Verdana"
563:                 .FontSize  = 8
564:                 .ForeColor = RGB(90, 90, 90)
565:             ENDWITH
566: 
567:             WITH .Buttons(4)
568:                 .Caption   = "An" + CHR(225) + "lise M" + CHR(233) + "dias"
569:                 .Top       = 3
570:                 .Left      = 234
571:                 .Width     = 103
572:                 .Height    = 15
573:                 .AutoSize  = .T.
574:                 .BackStyle = 0
575:                 .FontName  = "Verdana"
576:                 .FontSize  = 8
577:                 .ForeColor = RGB(90, 90, 90)
578:             ENDWITH
579:         ENDWITH
580:         BINDEVENT(loc_oPagina.opt_4c_Tipo, "Click", THIS, "ClickOptTipo")
581: 
582:         *-- Quebra (Datas / Datas+Operacoes)
583:         loc_oPagina.AddObject("lbl_4c_Quebra", "Label")
584:         WITH loc_oPagina.lbl_4c_Quebra
585:             .Top       = 130
586:             .Left      = 215
587:             .Width     = 42
588:             .Height    = 18
589:             .Caption   = "Quebra :"
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .ForeColor = RGB(90, 90, 90)
593:             .BackStyle = 0
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         loc_oPagina.AddObject("opt_4c_Quebras", "OptionGroup")
598:         WITH loc_oPagina.opt_4c_Quebras
599:             .Top         = 126
600:             .Left        = 259
601:             .Width       = 220
602:             .Height      = 23
603:             .ButtonCount = 2
604:             .AutoSize    = .F.
605:             .BackStyle   = 0
606:             .BorderStyle = 0
607:             .Value       = 1
608:             .Visible     = .T.
609: 
610:             WITH .Buttons(1)
611:                 .Caption   = "Datas"
612:                 .Top       = 4
613:                 .Left      = 5
614:                 .Width     = 46
615:                 .Height    = 15
616:                 .AutoSize  = .T.
617:                 .BackStyle = 0
618:                 .ForeColor = RGB(90, 90, 90)
619:             ENDWITH
620: 
621:             WITH .Buttons(2)
622:                 .Caption   = "Datas + Opera" + CHR(231) + CHR(245) + "es"
623:                 .Top       = 4
624:                 .Left      = 82
625:                 .Width     = 112
626:                 .Height    = 15
627:                 .AutoSize  = .T.
628:                 .BackStyle = 0
629:                 .FontName  = "Tahoma"
630:                 .FontSize  = 8
631:                 .ForeColor = RGB(90, 90, 90)
632:             ENDWITH
633:         ENDWITH
634: 
635:         *-- Valor Base (Itens / Movimentacao / Movimentacao S/ST)
636:         loc_oPagina.AddObject("lbl_4c_Base", "Label")
637:         WITH loc_oPagina.lbl_4c_Base
638:             .Top       = 152
639:             .Left      = 201
640:             .Width     = 56
641:             .Height    = 18
642:             .Caption   = "Valor Base :"
643:             .FontName  = "Tahoma"
644:             .FontSize  = 8
645:             .ForeColor = RGB(90, 90, 90)
646:             .BackStyle = 0
647:             .Visible   = .T.
648:         ENDWITH
649: 
650:         loc_oPagina.AddObject("opt_4c_Base", "OptionGroup")
651:         WITH loc_oPagina.opt_4c_Base
652:             .Top         = 148
653:             .Left        = 259
654:             .Width       = 364
655:             .Height      = 23
656:             .ButtonCount = 3
657:             .AutoSize    = .F.
658:             .BackStyle   = 0
659:             .BorderStyle = 0
660:             .Value       = 1
661:             .Visible     = .T.
662: 
663:             WITH .Buttons(1)
664:                 .Caption   = "Itens"
665:                 .Top       = 4
666:                 .Left      = 5
667:                 .Width     = 43
668:                 .Height    = 15
669:                 .AutoSize  = .T.
670:                 .BackStyle = 0
671:                 .ForeColor = RGB(90, 90, 90)
672:             ENDWITH
673: 
674:             WITH .Buttons(2)
675:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
676:                 .Top       = 4
677:                 .Left      = 82
678:                 .Width     = 87
679:                 .Height    = 15
680:                 .AutoSize  = .T.
681:                 .BackStyle = 0
682:                 .FontName  = "Tahoma"
683:                 .FontSize  = 8
684:                 .ForeColor = RGB(90, 90, 90)
685:             ENDWITH
686: 
687:             WITH .Buttons(3)
688:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o S/ST"
689:                 .Top       = 3
690:                 .Left      = 198
691:                 .Width     = 139
692:                 .Height    = 17
693:                 .BackStyle = 0
694:                 .FontName  = "Tahoma"
695:                 .FontSize  = 8
696:                 .ForeColor = RGB(90, 90, 90)
697:             ENDWITH
698:         ENDWITH
699: 
700:         *-- Ordens (so visivel quando Tipo=4; hidden por padrao)
701:         loc_oPagina.AddObject("lbl_4c_Ordem", "Label")
702:         WITH loc_oPagina.lbl_4c_Ordem
703:             .Top       = 172
704:             .Left      = 216
705:             .Width     = 40
706:             .Height    = 18
707:             .Caption   = "Ordens :"
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .ForeColor = RGB(90, 90, 90)
711:             .BackStyle = 0
712:             .Visible   = .F.
713:         ENDWITH
714: 
715:         loc_oPagina.AddObject("opt_4c_Ordem", "OptionGroup")
716:         WITH loc_oPagina.opt_4c_Ordem
717:             .Top         = 173
718:             .Left        = 260
719:             .Width       = 292
720:             .Height      = 37
721:             .ButtonCount = 6
722:             .AutoSize    = .F.
723:             .BackStyle   = 0
724:             .BorderStyle = 0
725:             .Value       = 1
726:             .Enabled     = .F.
727:             .Visible     = .F.
728: 
729:             WITH .Buttons(1)
730:                 .Caption   = "Vendedor"
731:                 .Top       = 1
732:                 .Left      = 4
733:                 .Width     = 64
734:                 .Height    = 15
735:                 .AutoSize  = .T.
736:                 .BackStyle = 0
737:                 .ForeColor = RGB(90, 90, 90)
738:             ENDWITH
739: 
740:             WITH .Buttons(2)
741:                 .Caption   = "Qtde Pe" + CHR(231) + "as"
742:                 .Top       = 1
743:                 .Left      = 100
744:                 .Width     = 73
745:                 .Height    = 15
746:                 .BackStyle = 0
747:                 .FontName  = "Tahoma"
748:                 .FontSize  = 8
749:                 .ForeColor = RGB(90, 90, 90)
750:             ENDWITH
751: 
752:             WITH .Buttons(3)
753:                 .Caption   = "M" + CHR(233) + "dia Pe" + CHR(231) + "as"
754:                 .Top       = 1
755:                 .Left      = 196
756:                 .Width     = 77
757:                 .Height    = 15
758:                 .BackStyle = 0
759:                 .FontName  = "Tahoma"
760:                 .FontSize  = 8
761:                 .ForeColor = RGB(90, 90, 90)
762:             ENDWITH
763: 
764:             WITH .Buttons(4)
765:                 .Caption   = "Qtde Opers"
766:                 .Top       = 17
767:                 .Left      = 4
768:                 .Width     = 83
769:                 .Height    = 17
770:                 .BackStyle = 0
771:                 .FontName  = "Tahoma"
772:                 .FontSize  = 8
773:                 .ForeColor = RGB(90, 90, 90)
774:             ENDWITH
775: 
776:             WITH .Buttons(5)
777:                 .Caption   = "M" + CHR(233) + "dia Opers"
778:                 .Top       = 17
779:                 .Left      = 100
780:                 .Width     = 83
781:                 .Height    = 17
782:                 .BackStyle = 0
783:                 .FontName  = "Tahoma"
784:                 .FontSize  = 8
785:                 .ForeColor = RGB(90, 90, 90)
786:             ENDWITH
787: 
788:             WITH .Buttons(6)
789:                 .Caption   = "Comiss" + CHR(227) + "o"
790:                 .Top       = 17
791:                 .Left      = 196
792:                 .Width     = 83
793:                 .Height    = 17
794:                 .BackStyle = 0
795:                 .FontName  = "Tahoma"
796:                 .FontSize  = 8

*-- Linhas 823 a 837:
823:             IF VARTYPE(THIS.this_oRelatorio) = "O"
824:                 WITH loc_oPagina.opt_4c_NrOpcao
825:                     IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcS)
826:                         .Buttons(1).Caption = THIS.this_oRelatorio.this_cTitOpcS
827:                     ENDIF
828:                     IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcN)
829:                         .Buttons(2).Caption = THIS.this_oRelatorio.this_cTitOpcN
830:                     ENDIF
831:                     IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcA)
832:                         .Buttons(3).Caption = THIS.this_oRelatorio.this_cTitOpcA
833:                     ENDIF
834:                 ENDWITH
835:             ENDIF
836: 
837:         CATCH TO loc_oErro

*-- Linhas 866 a 874:
866:                 .opt_4c_Quebras.Value    = 1
867:                 .opt_4c_Base.Value       = 1
868:                 .opt_4c_Ordem.Value      = 1
869:                 .lbl_4c_Ordem.Visible    = .F.
870:                 .opt_4c_Ordem.Visible    = .F.
871:                 .opt_4c_Ordem.Enabled    = .F.
872:             ENDWITH
873: 
874:         CATCH TO loc_oErro

*-- Linhas 993 a 1008:
993:         TRY
994:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
995:             IF loc_oPagina.opt_4c_Tipo.Value = 4
996:                 loc_oPagina.lbl_4c_Ordem.Visible = .T.
997:                 loc_oPagina.opt_4c_Ordem.Visible = .T.
998:                 loc_oPagina.opt_4c_Ordem.Enabled = .T.
999:                 IF loc_oPagina.opt_4c_Base.Value = 1
1000:                     loc_oPagina.opt_4c_Base.Value = 2
1001:                 ENDIF
1002:             ELSE
1003:                 loc_oPagina.lbl_4c_Ordem.Visible = .F.
1004:                 loc_oPagina.opt_4c_Ordem.Visible = .F.
1005:                 loc_oPagina.opt_4c_Ordem.Enabled = .F.
1006:             ENDIF
1007:         CATCH TO loc_oErro
1008:             MsgErro(loc_oErro.Message, "ClickOptTipo")

*-- Linhas 1312 a 1336:
1312:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
1313:                 WITH THIS.this_oRelatorio
1314:                     IF !EMPTY(.this_dDtInicial)
1315:                         loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
1316:                     ENDIF
1317:                     IF !EMPTY(.this_dDtFinal)
1318:                         loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
1319:                     ENDIF
1320:                     IF !EMPTY(.this_cCdMoeda)
1321:                         loc_oPg.txt_4c_CdMoeda.Value = .this_cCdMoeda
1322:                     ENDIF
1323:                     IF !EMPTY(.this_cDsMoeda)
1324:                         loc_oPg.txt_4c_DsMoeda.Value = .this_cDsMoeda
1325:                     ENDIF
1326:                     loc_oPg.txt_4c_Vendedor.Value  = .this_cVendedor
1327:                     loc_oPg.opt_4c_NrOpcao.Value   = .this_nNrOpcao
1328:                     loc_oPg.opt_4c_Tipo.Value       = .this_nTipo
1329:                     loc_oPg.opt_4c_Quebras.Value    = .this_nQuebra
1330:                     loc_oPg.opt_4c_Base.Value       = .this_nBase
1331:                     loc_oPg.opt_4c_Ordem.Value      = .this_nOrdem
1332:                 ENDWITH
1333:                 THIS.ClickOptTipo()
1334:             ENDIF
1335:         CATCH TO loc_oErro
1336:             MsgErro(loc_oErro.Message, "BOParaForm")

