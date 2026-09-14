# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (12)
- [LAYOUT-POSITION] Controle 'lbl_empresa' (parent: SIGRECPM): Top original=124 vs migrado 'lbl_4c_Lbl_empresa' Top=39 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_dopes' (parent: SIGRECPM): Top original=151 vs migrado 'lbl_4c_Lbl_dopes' Top=66 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGRECPM): Top original=152 vs migrado 'lbl_4c_Label9' Top=67 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECPM): Top original=152 vs migrado 'lbl_4c_Label1b' Top=67 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGRECPM): Top original=286 vs migrado 'lbl_4c_Label3' Top=201 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGRECPM): Top original=308 vs migrado 'obj_4c_Opt_Tipo' Top=0 (diff=308px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGRECPM): Left original=262 vs migrado 'obj_4c_Opt_Tipo' Left=0 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGRECPM): Top original=311 vs migrado 'lbl_4c_Label2b' Top=226 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECPM.cntAguarde): Top original=7 vs migrado 'lbl_4c_Label1b' Top=67 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECPM.cntAguarde): Left original=69 vs migrado 'lbl_4c_Label1b' Left=475 (diff=406px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGRECPM.cntAguarde): Top original=24 vs migrado 'lbl_4c_Label2b' Top=226 (diff=202px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGRECPM.cntAguarde): Left original=24 vs migrado 'lbl_4c_Label2b' Left=235 (diff=211px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECPM.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1474 linhas total):

*-- Linhas 53 a 61:
53:         loc_lSucesso   = .F.
54:         loc_lContinuar = .T.
55:         TRY
56:             THIS.Caption = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"
57: 
58:             IF TYPE("gc_4c_CaminhoIcones") = "U"
59:                 gc_4c_CaminhoIcones = ""
60:             ENDIF
61:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 74 a 83:
74:                 THIS.ConfigurarPageFrame()
75:                 THIS.ConfigurarPaginaDados()
76: 
77:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
78:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
79: 
80:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
81:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
82:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
83:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

*-- Linhas 103 a 141:
103:     PROTECTED PROCEDURE ConfigurarCabecalho()
104:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH THIS.cnt_4c_Cabecalho
106:             .Top         = 0
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackStyle   = 1
111:             .BackColor   = RGB(100, 100, 100)
112:             .BorderWidth = 0
113:             .Visible     = .T.
114: 
115:             .AddObject("lbl_4c_Sombra", "Label")
116:             WITH .lbl_4c_Sombra
117:                 .Top       = 22
118:                 .Left      = 22
119:                 .Width     = THIS.Width
120:                 .Height    = 30
121:                 .Caption   = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"
122:                 .FontName  = "Tahoma"
123:                 .FontSize  = 14
124:                 .FontBold  = .T.
125:                 .ForeColor = RGB(0, 0, 0)
126:                 .BackStyle = 0
127:                 .Visible   = .T.
128:             ENDWITH
129: 
130:             .AddObject("lbl_4c_Titulo", "Label")
131:             WITH .lbl_4c_Titulo
132:                 .Top       = 20
133:                 .Left      = 20
134:                 .Width     = THIS.Width
135:                 .Height    = 30
136:                 .Caption   = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 14
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(255, 255, 255)
141:                 .BackStyle = 0

*-- Linhas 154 a 179:
154:     PROTECTED PROCEDURE ConfigurarBotoes()
155:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
156:         WITH THIS.cmg_4c_Botoes
157:             .Top           = 0
158:             .Left          = 529
159:             .Width         = 273
160:             .Height        = 80
161:             .ButtonCount   = 4
162:             .BackStyle     = 0
163:             .BorderStyle   = 0
164:             .BorderColor   = RGB(136, 189, 188)
165:             .SpecialEffect = 1
166:             .Themes        = .F.
167:             .Visible       = .T.
168: 
169:             WITH .Buttons(1)
170:                 .Top             = 5
171:                 .Left            = 5
172:                 .Width           = 65
173:                 .Height          = 70
174:                 .Caption         = "Visualizar"
175:                 .FontBold        = .T.
176:                 .FontItalic      = .T.
177:                 .BackColor       = RGB(255, 255, 255)
178:                 .ForeColor       = RGB(90, 90, 90)
179:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 186 a 198:
186:             ENDWITH
187: 
188:             WITH .Buttons(2)
189:                 .Top             = 5
190:                 .Left            = 71
191:                 .Width           = 65
192:                 .Height          = 70
193:                 .Caption         = "Imprimir"
194:                 .FontName        = "Tahoma"
195:                 .FontBold        = .T.
196:                 .FontItalic      = .T.
197:                 .FontSize        = 8
198:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 207 a 219:
207:             ENDWITH
208: 
209:             WITH .Buttons(3)
210:                 .Top             = 5
211:                 .Left            = 137
212:                 .Width           = 65
213:                 .Height          = 70
214:                 .Caption         = "Excel"
215:                 .FontName        = "Tahoma"
216:                 .FontBold        = .T.
217:                 .FontItalic      = .T.
218:                 .FontSize        = 8
219:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 228 a 240:
228:             ENDWITH
229: 
230:             WITH .Buttons(4)
231:                 .Top             = 5
232:                 .Left            = 203
233:                 .Width           = 65
234:                 .Height          = 70
235:                 .Caption         = "Encerrar"
236:                 .Cancel          = .T.
237:                 .FontName        = "Tahoma"
238:                 .FontBold        = .T.
239:                 .FontItalic      = .T.
240:                 .FontSize        = 8

*-- Linhas 264 a 278:
264: 
265:         loc_oPgf.PageCount = 1
266: 
267:         loc_oPgf.Top    = 85
268:         loc_oPgf.Left   = -1
269:         loc_oPgf.Width  = THIS.Width + 2
270:         loc_oPgf.Height = THIS.Height - 85
271:         loc_oPgf.Tabs   = .F.
272: 
273:         loc_oPgf.Page1.Caption   = "Filtros"
274:         loc_oPgf.Page1.FontName  = "Tahoma"
275:         loc_oPgf.Page1.FontSize  = 8
276:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
277:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
278:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 293 a 380:
293:             loc_oPag = THIS.pgf_4c_Paginas.Page1
294: 
295:             *-- Linha 1: Periodo
296:             loc_oPag.AddObject("lbl_4c_Label1", "Label")
297:             WITH loc_oPag.lbl_4c_Label1
298:                 .Top       = 12
299:                 .Left      = 219
300:                 .Width     = 50
301:                 .Height    = 18
302:                 .Caption   = "Per" + CHR(237) + "odo :"
303:                 .FontName  = "Tahoma"
304:                 .FontSize  = 8
305:                 .FontBold  = .F.
306:                 .ForeColor = RGB(90, 90, 90)
307:                 .BackStyle = 0
308:                 .Visible   = .T.
309:             ENDWITH
310: 
311:             loc_oPag.AddObject("txt_4c_DtInicial", "TextBox")
312:             WITH loc_oPag.txt_4c_DtInicial
313:                 .Top           = 8
314:                 .Left          = 267
315:                 .Width         = 80
316:                 .Height        = 25
317:                 .Value         = {}
318:                 .FontName      = "Tahoma"
319:                 .FontSize      = 8
320:                 .SpecialEffect = 0
321:                 .BackColor     = RGB(255, 255, 255)
322:                 .ForeColor     = RGB(0, 0, 128)
323:                 .Visible       = .T.
324:             ENDWITH
325: 
326:             loc_oPag.AddObject("lbl_4c_Label6", "Label")
327:             WITH loc_oPag.lbl_4c_Label6
328:                 .Top       = 13
329:                 .Left      = 355
330:                 .Width     = 20
331:                 .Height    = 18
332:                 .Caption   = "at" + CHR(233)
333:                 .FontName  = "Tahoma"
334:                 .FontSize  = 8
335:                 .FontBold  = .F.
336:                 .ForeColor = RGB(90, 90, 90)
337:                 .BackStyle = 0
338:                 .Visible   = .T.
339:             ENDWITH
340: 
341:             loc_oPag.AddObject("txt_4c_DtFinal", "TextBox")
342:             WITH loc_oPag.txt_4c_DtFinal
343:                 .Top           = 8
344:                 .Left          = 381
345:                 .Width         = 80
346:                 .Height        = 25
347:                 .Value         = {}
348:                 .FontName      = "Tahoma"
349:                 .FontSize      = 8
350:                 .SpecialEffect = 0
351:                 .BackColor     = RGB(255, 255, 255)
352:                 .ForeColor     = RGB(0, 0, 128)
353:                 .Visible       = .T.
354:             ENDWITH
355: 
356:             *-- Linha 2: Empresa
357:             loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
358:             WITH loc_oPag.lbl_4c_Lbl_empresa
359:                 .Top       = 39
360:                 .Left      = 214
361:                 .Width     = 50
362:                 .Height    = 18
363:                 .Caption   = "Empresa :"
364:                 .FontName  = "Tahoma"
365:                 .FontSize  = 8
366:                 .FontBold  = .F.
367:                 .ForeColor = RGB(90, 90, 90)
368:                 .BackStyle = 0
369:                 .Visible   = .T.
370:             ENDWITH
371: 
372:             loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
373:             WITH loc_oPag.txt_4c_Empresa
374:                 .Top           = 35
375:                 .Left          = 267
376:                 .Width         = 31
377:                 .Height        = 25
378:                 .Value         = ""
379:                 .FontName      = "Tahoma"
380:                 .FontSize      = 8

*-- Linhas 386 a 517:
386: 
387:             loc_oPag.AddObject("txt_4c_DEmpresa", "TextBox")
388:             WITH loc_oPag.txt_4c_DEmpresa
389:                 .Top           = 35
390:                 .Left          = 300
391:                 .Width         = 339
392:                 .Height        = 25
393:                 .Value         = ""
394:                 .FontName      = "Tahoma"
395:                 .FontSize      = 8
396:                 .SpecialEffect = 0
397:                 .BackColor     = RGB(255, 255, 255)
398:                 .ForeColor     = RGB(0, 0, 128)
399:                 .Visible       = .T.
400:             ENDWITH
401: 
402:             *-- Linha 3: Movimentacao / Faixa de numeros
403:             loc_oPag.AddObject("lbl_4c_Lbl_dopes", "Label")
404:             WITH loc_oPag.lbl_4c_Lbl_dopes
405:                 .Top       = 66
406:                 .Left      = 186
407:                 .Width     = 78
408:                 .Height    = 18
409:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
410:                 .FontName  = "Tahoma"
411:                 .FontSize  = 8
412:                 .FontBold  = .F.
413:                 .ForeColor = RGB(90, 90, 90)
414:                 .BackStyle = 0
415:                 .Visible   = .T.
416:             ENDWITH
417: 
418:             loc_oPag.AddObject("txt_4c_Operacao", "TextBox")
419:             WITH loc_oPag.txt_4c_Operacao
420:                 .Top           = 62
421:                 .Left          = 267
422:                 .Width         = 184
423:                 .Height        = 25
424:                 .Value         = ""
425:                 .FontName      = "Tahoma"
426:                 .FontSize      = 8
427:                 .SpecialEffect = 0
428:                 .BackColor     = RGB(255, 255, 255)
429:                 .ForeColor     = RGB(0, 0, 128)
430:                 .Visible       = .T.
431:             ENDWITH
432: 
433:             loc_oPag.AddObject("lbl_4c_Label1b", "Label")
434:             WITH loc_oPag.lbl_4c_Label1b
435:                 .Top       = 67
436:                 .Left      = 475
437:                 .Width     = 21
438:                 .Height    = 15
439:                 .Caption   = "de :"
440:                 .FontName  = "Tahoma"
441:                 .FontSize  = 8
442:                 .FontBold  = .F.
443:                 .ForeColor = RGB(90, 90, 90)
444:                 .BackStyle = 0
445:                 .Visible   = .T.
446:             ENDWITH
447: 
448:             loc_oPag.AddObject("txt_4c_OperacaoI", "TextBox")
449:             WITH loc_oPag.txt_4c_OperacaoI
450:                 .Top           = 62
451:                 .Left          = 500
452:                 .Width         = 55
453:                 .Height        = 25
454:                 .Value         = 0
455:                 .FontName      = "Tahoma"
456:                 .FontSize      = 8
457:                 .SpecialEffect = 0
458:                 .BackColor     = RGB(255, 255, 255)
459:                 .ForeColor     = RGB(0, 0, 128)
460:                 .Visible       = .T.
461:             ENDWITH
462: 
463:             loc_oPag.AddObject("lbl_4c_Label9", "Label")
464:             WITH loc_oPag.lbl_4c_Label9
465:                 .Top       = 67
466:                 .Left      = 561
467:                 .Width     = 18
468:                 .Height    = 15
469:                 .Caption   = "at" + CHR(233)
470:                 .FontName  = "Tahoma"
471:                 .FontSize  = 8
472:                 .FontBold  = .F.
473:                 .ForeColor = RGB(90, 90, 90)
474:                 .BackStyle = 0
475:                 .Visible   = .T.
476:             ENDWITH
477: 
478:             loc_oPag.AddObject("txt_4c_OperacaoF", "TextBox")
479:             WITH loc_oPag.txt_4c_OperacaoF
480:                 .Top           = 62
481:                 .Left          = 584
482:                 .Width         = 55
483:                 .Height        = 25
484:                 .Value         = 0
485:                 .FontName      = "Tahoma"
486:                 .FontSize      = 8
487:                 .SpecialEffect = 0
488:                 .BackColor     = RGB(255, 255, 255)
489:                 .ForeColor     = RGB(0, 0, 128)
490:                 .Visible       = .T.
491:             ENDWITH
492: 
493:             *-- Linha 4: Grupo Origem
494:             loc_oPag.AddObject("lbl_4c_Label5", "Label")
495:             WITH loc_oPag.lbl_4c_Label5
496:                 .Top       = 93
497:                 .Left      = 189
498:                 .Width     = 75
499:                 .Height    = 18
500:                 .Caption   = "Grupo Origem :"
501:                 .FontName  = "Tahoma"
502:                 .FontSize  = 8
503:                 .FontBold  = .F.
504:                 .ForeColor = RGB(90, 90, 90)
505:                 .BackStyle = 0
506:                 .Visible   = .T.
507:             ENDWITH
508: 
509:             loc_oPag.AddObject("txt_4c_GrOrigem", "TextBox")
510:             WITH loc_oPag.txt_4c_GrOrigem
511:                 .Top           = 89
512:                 .Left          = 267
513:                 .Width         = 80
514:                 .Height        = 25
515:                 .Value         = ""
516:                 .FontName      = "Tahoma"
517:                 .FontSize      = 8

*-- Linhas 523 a 563:
523: 
524:             loc_oPag.AddObject("txt_4c_DsGrOrigem", "TextBox")
525:             WITH loc_oPag.txt_4c_DsGrOrigem
526:                 .Top           = 89
527:                 .Left          = 350
528:                 .Width         = 312
529:                 .Height        = 25
530:                 .Value         = ""
531:                 .FontName      = "Tahoma"
532:                 .FontSize      = 8
533:                 .SpecialEffect = 0
534:                 .BackColor     = RGB(255, 255, 255)
535:                 .ForeColor     = RGB(0, 0, 128)
536:                 .Visible       = .T.
537:             ENDWITH
538: 
539:             *-- Linha 5: Conta Origem
540:             loc_oPag.AddObject("lbl_4c_Label2", "Label")
541:             WITH loc_oPag.lbl_4c_Label2
542:                 .Top       = 120
543:                 .Left      = 189
544:                 .Width     = 75
545:                 .Height    = 18
546:                 .Caption   = "Conta Origem :"
547:                 .FontName  = "Tahoma"
548:                 .FontSize  = 8
549:                 .FontBold  = .F.
550:                 .ForeColor = RGB(90, 90, 90)
551:                 .BackStyle = 0
552:                 .Visible   = .T.
553:             ENDWITH
554: 
555:             loc_oPag.AddObject("txt_4c_ContaO", "TextBox")
556:             WITH loc_oPag.txt_4c_ContaO
557:                 .Top           = 116
558:                 .Left          = 267
559:                 .Width         = 80
560:                 .Height        = 25
561:                 .Value         = ""
562:                 .FontName      = "Tahoma"
563:                 .FontSize      = 8

*-- Linhas 569 a 609:
569: 
570:             loc_oPag.AddObject("txt_4c_DContaO", "TextBox")
571:             WITH loc_oPag.txt_4c_DContaO
572:                 .Top           = 116
573:                 .Left          = 350
574:                 .Width         = 312
575:                 .Height        = 25
576:                 .Value         = ""
577:                 .FontName      = "Tahoma"
578:                 .FontSize      = 8
579:                 .SpecialEffect = 0
580:                 .BackColor     = RGB(255, 255, 255)
581:                 .ForeColor     = RGB(0, 0, 128)
582:                 .Visible       = .T.
583:             ENDWITH
584: 
585:             *-- Linha 6: Grupo Destino
586:             loc_oPag.AddObject("lbl_4c_Label7", "Label")
587:             WITH loc_oPag.lbl_4c_Label7
588:                 .Top       = 147
589:                 .Left      = 187
590:                 .Width     = 77
591:                 .Height    = 18
592:                 .Caption   = "Grupo Destino :"
593:                 .FontName  = "Tahoma"
594:                 .FontSize  = 8
595:                 .FontBold  = .F.
596:                 .ForeColor = RGB(90, 90, 90)
597:                 .BackStyle = 0
598:                 .Visible   = .T.
599:             ENDWITH
600: 
601:             loc_oPag.AddObject("txt_4c_GrDestino", "TextBox")
602:             WITH loc_oPag.txt_4c_GrDestino
603:                 .Top           = 143
604:                 .Left          = 267
605:                 .Width         = 80
606:                 .Height        = 25
607:                 .Value         = ""
608:                 .FontName      = "Tahoma"
609:                 .FontSize      = 8

*-- Linhas 615 a 655:
615: 
616:             loc_oPag.AddObject("txt_4c_DsGrDestino", "TextBox")
617:             WITH loc_oPag.txt_4c_DsGrDestino
618:                 .Top           = 143
619:                 .Left          = 350
620:                 .Width         = 312
621:                 .Height        = 25
622:                 .Value         = ""
623:                 .FontName      = "Tahoma"
624:                 .FontSize      = 8
625:                 .SpecialEffect = 0
626:                 .BackColor     = RGB(255, 255, 255)
627:                 .ForeColor     = RGB(0, 0, 128)
628:                 .Visible       = .T.
629:             ENDWITH
630: 
631:             *-- Linha 7: Conta Destino
632:             loc_oPag.AddObject("lbl_4c_Label4", "Label")
633:             WITH loc_oPag.lbl_4c_Label4
634:                 .Top       = 174
635:                 .Left      = 187
636:                 .Width     = 77
637:                 .Height    = 18
638:                 .Caption   = "Conta Destino :"
639:                 .FontName  = "Tahoma"
640:                 .FontSize  = 8
641:                 .FontBold  = .F.
642:                 .ForeColor = RGB(90, 90, 90)
643:                 .BackStyle = 0
644:                 .Visible   = .T.
645:             ENDWITH
646: 
647:             loc_oPag.AddObject("txt_4c_ContaD", "TextBox")
648:             WITH loc_oPag.txt_4c_ContaD
649:                 .Top           = 170
650:                 .Left          = 267
651:                 .Width         = 80
652:                 .Height        = 25
653:                 .Value         = ""
654:                 .FontName      = "Tahoma"
655:                 .FontSize      = 8

*-- Linhas 661 a 792:
661: 
662:             loc_oPag.AddObject("txt_4c_DContaD", "TextBox")
663:             WITH loc_oPag.txt_4c_DContaD
664:                 .Top           = 170
665:                 .Left          = 350
666:                 .Width         = 312
667:                 .Height        = 25
668:                 .Value         = ""
669:                 .FontName      = "Tahoma"
670:                 .FontSize      = 8
671:                 .SpecialEffect = 0
672:                 .BackColor     = RGB(255, 255, 255)
673:                 .ForeColor     = RGB(0, 0, 128)
674:                 .Visible       = .T.
675:             ENDWITH
676: 
677:             *-- Linha 8: O.P.
678:             loc_oPag.AddObject("lbl_4c_Label3", "Label")
679:             WITH loc_oPag.lbl_4c_Label3
680:                 .Top       = 201
681:                 .Left      = 233
682:                 .Width     = 31
683:                 .Height    = 15
684:                 .Caption   = "O.P. :"
685:                 .FontName  = "Tahoma"
686:                 .FontSize  = 8
687:                 .FontBold  = .F.
688:                 .ForeColor = RGB(90, 90, 90)
689:                 .BackStyle = 0
690:                 .Visible   = .T.
691:             ENDWITH
692: 
693:             loc_oPag.AddObject("txt_4c_OP", "TextBox")
694:             WITH loc_oPag.txt_4c_OP
695:                 .Top           = 197
696:                 .Left          = 267
697:                 .Width         = 86
698:                 .Height        = 25
699:                 .Value         = 0
700:                 .FontName      = "Tahoma"
701:                 .FontSize      = 8
702:                 .SpecialEffect = 0
703:                 .BackColor     = RGB(255, 255, 255)
704:                 .ForeColor     = RGB(0, 0, 128)
705:                 .Visible       = .T.
706:             ENDWITH
707: 
708:             *-- Linha 9: Tipo de relatorio
709:             loc_oPag.AddObject("lbl_4c_Label2b", "Label")
710:             WITH loc_oPag.lbl_4c_Label2b
711:                 .Top       = 226
712:                 .Left      = 235
713:                 .Width     = 29
714:                 .Height    = 15
715:                 .Caption   = "Tipo :"
716:                 .FontName  = "Tahoma"
717:                 .FontSize  = 8
718:                 .FontBold  = .F.
719:                 .ForeColor = RGB(90, 90, 90)
720:                 .BackStyle = 0
721:                 .Visible   = .T.
722:             ENDWITH
723: 
724:             loc_oPag.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
725:             WITH loc_oPag.obj_4c_Opt_Tipo
726:                 .Top         = 223
727:                 .Left        = 262
728:                 .Width       = 175
729:                 .Height      = 25
730:                 .ButtonCount = 2
731:                 .Value       = 1
732:                 .BackStyle   = 0
733:                 .BorderStyle = 0
734:                 .Visible     = .T.
735:                 WITH .Buttons(1)
736:                     .Caption = "Anal" + CHR(237) + "tico"
737:                     .Left    = 0
738:                     .Top     = 0
739:                     .Width   = 80
740:                     .Height  = 25
741:                 ENDWITH
742:                 WITH .Buttons(2)
743:                     .Caption  = "Sint" + CHR(233) + "tico"
744:                     .Left     = 90
745:                     .Top      = 0
746:                     .Width    = 80
747:                     .Height   = 25
748:                     .FontName = "Tahoma"
749:                     .FontSize = 8
750:                     .Visible  = .T.
751:                 ENDWITH
752:             ENDWITH
753: 
754:             *-- Container Aguarde (oculto ate o processamento)
755:             loc_oPag.AddObject("cnt_4c_Aguarde", "Container")
756:             WITH loc_oPag.cnt_4c_Aguarde
757:                 .Top         = 83
758:                 .Left        = 312
759:                 .Width       = 207
760:                 .Height      = 49
761:                 .BackStyle   = 1
762:                 .BackColor   = RGB(255, 255, 200)
763:                 .BorderWidth = 1
764:                 .Visible     = .F.
765: 
766:                 .AddObject("lbl_4c_Aguarde1", "Label")
767:                 WITH .lbl_4c_Aguarde1
768:                     .Top       = 7
769:                     .Left      = 69
770:                     .Width     = 68
771:                     .Height    = 18
772:                     .Caption   = "Aguarde..."
773:                     .FontName  = "Tahoma"
774:                     .FontSize  = 8
775:                     .FontBold  = .T.
776:                     .ForeColor = RGB(0, 0, 128)
777:                     .BackStyle = 0
778:                     .Visible   = .T.
779:                 ENDWITH
780: 
781:                 .AddObject("lbl_4c_Aguarde2", "Label")
782:                 WITH .lbl_4c_Aguarde2
783:                     .Top       = 24
784:                     .Left      = 24
785:                     .Width     = 141
786:                     .Height    = 18
787:                     .Caption   = "Processando Dados..."
788:                     .FontName  = "Tahoma"
789:                     .FontSize  = 8
790:                     .FontBold  = .F.
791:                     .ForeColor = RGB(0, 0, 128)
792:                     .BackStyle = 0


### BO (C:\4c\projeto\app\classes\SIGRECPMBO.prg):
*==============================================================================
* SIGRECPMBO.PRG
* Business Object para Relatorio de Composicao por OP (SIGRECPM)
* Herda de RelatorioBase
*
* Relatorio: Listagem de Composicao por OP (Analitico/Sintetico)
* FRX Analitico: SigReCPM.frx
* FRX Sintetico: SigReC2P.frx
* Tabelas: SigCdNei, SigCdNec, SigCdPro, SigOpPic, SigPdMvf, SigCdEmp
*==============================================================================

DEFINE CLASS SIGRECPMBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtro: Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: Movimentacao/Operacao
    this_cOperacao      = ""

    *-- Filtro: Conta Origem
    this_cContaO        = ""
    this_cDContaO       = ""

    *-- Filtro: Conta Destino
    this_cContaD        = ""
    this_cDContaD       = ""

    *-- Filtro: Grupo Origem
    this_cGrOrigem      = ""
    this_cDsGrOrigem    = ""

    *-- Filtro: Grupo Destino
    this_cGrDestino     = ""
    this_cDsGrDestino   = ""

    *-- Filtro: Faixa de Numeros de Operacao
    this_nOperacaoI     = 0
    this_nOperacaoF     = 0

    *-- Filtro: Numero da OP
    this_nOP            = 0

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico
    this_nTipo          = 1

    *-- Flags e acumuladores (equivalentes a llope, npeso2s, npesos, nqtd do form legado)
    this_lLlope         = .F.
    this_nPeso2s        = 0
    this_nPesos         = 0
    this_nQtd           = 0

    *-- Cursor principal de dados
    this_cCursorDados   = "cursor_4c_SigRecPM"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal e processa cursors intermediarios
    * Replica logica do PROCEDURE processamento do legado SIGRECPM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQLEmp, loc_nResEmp, loc_cNomeEmpresa
        LOCAL loc_cTitulo, loc_cPeriodo, loc_cSubTit, loc_cNopRange
        LOCAL loc_cDtIni, loc_cDtFim
        LOCAL loc_nAno, loc_nMes, loc_nDia
        LOCAL loc_cWhere, loc_cWhereNop1, loc_cWhereNop2
        LOCAL loc_cSQL1, loc_cSQL2, loc_cSQLUnion
        LOCAL loc_nResult
        LOCAL loc_nPesos, loc_nPeso2s, loc_nQtd

        loc_lSucesso = .F.
        TRY
            *-- Busca nome da empresa quando filtrado
            loc_cNomeEmpresa = ""
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cSQLEmp = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa)
                loc_nResEmp = SQLEXEC(gnConnHandle, loc_cSQLEmp, "cursor_4c_SigRecPM_Emp")
                IF loc_nResEmp > 0
                    SELECT cursor_4c_SigRecPM_Emp
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    USE IN cursor_4c_SigRecPM_Emp
                ENDIF
            ENDIF

            *-- Monta cabecalho do relatorio (dbCabecalho usado pelo FRX)
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(150), SubTitulo C(80), ;
                                       lCompo L, Total M(4))

            loc_cTitulo = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP - " + ;
                          IIF(THIS.this_nTipo = 2, "Sint" + CHR(233) + "tico", ;
                              "Anal" + CHR(237) + "tico")

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(THIS.this_cEmpresa), "Geral", ;
                           THIS.this_cEmpresa + " - " + ALLTRIM(THIS.this_cDEmpresa))

            loc_cSubTit = IIF(THIS.this_nOP <> 0, ;
                              "OP: " + ALLTRIM(STR(THIS.this_nOP, 10)), "")

            IF !EMPTY(THIS.this_cOperacao)
                loc_cNopRange = ""
                IF THIS.this_nOperacaoI <> 0
                    loc_cNopRange = ":" + ALLTRIM(STR(THIS.this_nOperacaoI, 6))
                    IF THIS.this_nOperacaoF <> 0
                        loc_cNopRange = loc_cNopRange + " " + CHR(224) + " " + ;
                                        ALLTRIM(STR(THIS.this_nOperacaoF, 6))
                    ENDIF
                ENDIF
                loc_cSubTit = loc_cSubTit + IIF(!EMPTY(loc_cSubTit), " ", "") + ;
                              "Movimenta" + CHR(231) + CHR(227) + "o (" + ;
                              ALLTRIM(THIS.this_cOperacao) + loc_cNopRange + ")"
            ENDIF

            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
                   VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cSubTit)

            *-- Datas para o WHERE: inicio normal, fim com 23:59:59 para cobrir dia inteiro
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_nAno   = YEAR(THIS.this_dDtFinal)
            loc_nMes   = MONTH(THIS.this_dDtFinal)
            loc_nDia   = DAY(THIS.this_dDtFinal)
            loc_cDtFim = "'" + PADL(LTRIM(STR(loc_nAno)), 4, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nMes)), 2, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nDia)), 2, "0") + " 23:59:59'"

            *-- WHERE base (compartilhado pelas duas partes do UNION)
            loc_cWhere = " WHERE b.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)
            ENDIF
            IF !EMPTY(THIS.this_cOperacao)
                loc_cWhere = loc_cWhere + " AND a.Dopps = " + EscaparSQL(THIS.this_cOperacao)
            ENDIF
            IF THIS.this_nOperacaoI <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps >= " + ALLTRIM(STR(THIS.this_nOperacaoI))
            ENDIF
            IF THIS.this_nOperacaoF <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps <= " + ALLTRIM(STR(THIS.this_nOperacaoF))
            ENDIF
            IF !EMPTY(THIS.this_cGrOrigem)
                loc_cWhere = loc_cWhere + " AND b.GrupoOs = " + EscaparSQL(THIS.this_cGrOrigem)
            ENDIF
            IF !EMPTY(THIS.this_cContaO)
                loc_cWhere = loc_cWhere + " AND b.ContaOs = " + EscaparSQL(THIS.this_cContaO)
            ENDIF
            IF !EMPTY(THIS.this_cGrDestino)
                loc_cWhere = loc_cWhere + " AND b.GrupoDs = " + EscaparSQL(THIS.this_cGrDestino)
            ENDIF
            IF !EMPTY(THIS.this_cContaD)
                loc_cWhere = loc_cWhere + " AND b.ContaDs = " + EscaparSQL(THIS.this_cContaD)
            ENDIF

            *-- WHERE para parte 1: filtra por Nops (OP direta)
            loc_cWhereNop1 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop1 = loc_cWhereNop1 + ;
                                 " AND a.Nops = " + ALLTRIM(STR(THIS.this_nOP))
            ENDIF

            *-- WHERE para parte 2: filtra por Nenvs (sub-ordens da OP)
            loc_cWhereNop2 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop2 = loc_cWhereNop2 + ;
                                 " AND (a.Nenvs = " + ALLTRIM(STR(THIS.this_nOP)) + ;
                                 " AND a.Nops <> " + ALLTRIM(STR(THIS.this_nOP)) + ")"
            ENDIF

            *-- Parte 1 do UNION: Nops como OP direta (a.Nops AS Nenvs)
            loc_cSQL1 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL1 = loc_cSQL1 + ;
                        " FROM SigCdNei a"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL1 = loc_cSQL1 + loc_cWhereNop1

            *-- Parte 2 do UNION: Nenvs real (sub-ordens)
            loc_cSQL2 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL2 = loc_cSQL2 + ;
                        " FROM SigCdNei a"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL2 = loc_cSQL2 + loc_cWhereNop2

            loc_cSQLUnion = loc_cSQL1 + " UNION " + loc_cSQL2

            *-- Executa query principal no SQL Server
            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLUnion, "TmpNensi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE

            *-- Agrupa por material/OP para eliminar duplicatas e calcular totais
            IF USED("crNensi")
                USE IN crNensi
            ENDIF
            SELECT Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips, ;
                   MAX(cidchaves) AS cidchaves, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds, MAX(qtd) AS qtd ;
                   FROM TmpNensi ;
                   GROUP BY Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips ;
                   INTO CURSOR crNensi READWRITE

            SELECT crNensi
            INDEX ON STR(nenvs, 10) + STR(Tipo) + cidchaves + dopps + cmats TAG Mov
            GO TOP

            *-- Agrega por material para calcular totais de peso
            IF USED("crNensi2")
                USE IN crNensi2
            ENDIF
            SELECT 2 AS Tipo, nenvs, cmats, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds ;
                   FROM crNensi ;
                   GROUP BY Nenvs, cmats ;
                   INTO CURSOR crNensi2 READWRITE

            SELECT crNensi2
            loc_nPesos  = 0
            loc_nPeso2s = 0
            SUM pesos, peso2s TO loc_nPesos, loc_nPeso2s
            THIS.this_nPesos  = loc_nPesos
            THIS.this_nPeso2s = loc_nPeso2s

            *-- Agrega por OP para calcular total de quantidade
            IF USED("crNensi3")
                USE IN crNensi3
            ENDIF
            SELECT 3 AS Tipo, nenvs, MAX(qtd) AS Qtd ;
                   FROM crNensi ;
                   GROUP BY Nenvs ;
                   INTO CURSOR crNensi3 READWRITE

            SELECT crNensi3
            loc_nQtd = 0
            SUM Qtd TO loc_nQtd
            THIS.this_nQtd = loc_nQtd

            *-- Modo Sintetico: reagrupa por material eliminando detalhe de OP
            IF THIS.this_nTipo = 2
                IF USED("crTmpNensi")
                    USE IN crTmpNensi
                ENDIF
                SELECT 9 AS Tipo, '' AS Dopps, cmats, dpros, cunips, cunis, ;
                       0 AS Qtd, SUM(qtds) AS Qtds, SUM(pesos) AS pesos, ;
                       SUM(peso2s) AS peso2s ;
                       FROM crNensi ;
                       GROUP BY cmats, dpros, cunis, cunips ;
                       ORDER BY cmats ;
                       INTO CURSOR crTmpNensi READWRITE

                SELECT crTmpNensi
                GO TOP
            ELSE
                SELECT crNensi
                GO TOP
            ENDIF

            THIS.this_lLlope = EMPTY(THIS.this_cOperacao)

            loc_lSucesso = .T.
            ENDIF  && loc_nResult >= 1
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCPM.frx") PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigReC2P.frx") PREVIEW NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCPM.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigReC2P.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * Util para restaurar conjuntos de filtros salvos (presets)
    * O cursor deve conter colunas com os mesmos nomes dos filtros do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Empresa
            IF TYPE(par_cAliasCursor + ".Emps") != "U"
                THIS.this_cEmpresa = TratarNulo(Emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DEmps") != "U"
                THIS.this_cDEmpresa = TratarNulo(DEmps, "C")
            ENDIF

            *-- Periodo
            IF TYPE(par_cAliasCursor + ".DtIni") != "U"
                THIS.this_dDtInicial = TratarNulo(DtIni, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DtFim") != "U"
                THIS.this_dDtFinal = TratarNulo(DtFim, "D")
            ENDIF

            *-- Operacao
            IF TYPE(par_cAliasCursor + ".Dopps") != "U"
                THIS.this_cOperacao = TratarNulo(Dopps, "C")
            ENDIF

            *-- Contas
            IF TYPE(par_cAliasCursor + ".Contaos") != "U"
                THIS.this_cContaO = TratarNulo(Contaos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaO") != "U"
                THIS.this_cDContaO = TratarNulo(DContaO, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Contads") != "U"
                THIS.this_cContaD = TratarNulo(Contads, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaD") != "U"
                THIS.this_cDContaD = TratarNulo(DContaD, "C")
            ENDIF

            *-- Grupos
            IF TYPE(par_cAliasCursor + ".Grupoos") != "U"
                THIS.this_cGrOrigem = TratarNulo(Grupoos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoOs") != "U"
                THIS.this_cDsGrOrigem = TratarNulo(DGrupoOs, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Grupods") != "U"
                THIS.this_cGrDestino = TratarNulo(Grupods, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoDs") != "U"
                THIS.this_cDsGrDestino = TratarNulo(DGrupoDs, "C")
            ENDIF

            *-- Faixa de Operacao
            IF TYPE(par_cAliasCursor + ".NumPsI") != "U"
                THIS.this_nOperacaoI = TratarNulo(NumPsI, "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".NumPsF") != "U"
                THIS.this_nOperacaoF = TratarNulo(NumPsF, "N")
            ENDIF

            *-- OP
            IF TYPE(par_cAliasCursor + ".Nops") != "U"
                THIS.this_nOP = TratarNulo(Nops, "N")
            ENDIF

            *-- Tipo
            IF TYPE(par_cAliasCursor + ".TipoRel") != "U"
                THIS.this_nTipo = TratarNulo(TipoRel, "N")
                IF THIS.this_nTipo < 1 OR THIS.this_nTipo > 2
                    THIS.this_nTipo = 1
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao NAO aplicavel para BOs de relatorio
    * Relatorios nao persistem registros; existem apenas para gerar saida.
    * Sobrescreve para garantir que chamadas indevidas vindas de codigo
    * generico (sweepers, framework) falhem com mensagem clara e auditavel.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao NAO aplicavel para BOs de relatorio
    * (mesma justificativa de Inserir())
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + ;
                                  CHR(227) + "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do conjunto de filtros atual
    * Relatorios nao tem chave de registro - usa-se o hash dos filtros
    * para identificar a execucao (util em auditoria/log).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECPM|" + ;
                     ALLTRIM(THIS.this_cEmpresa) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cOperacao) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoI, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoF, 10)) + "|" + ;
                     ALLTRIM(THIS.this_cContaO) + "|" + ;
                     ALLTRIM(THIS.this_cContaD) + "|" + ;
                     ALLTRIM(THIS.this_cGrOrigem) + "|" + ;
                     ALLTRIM(THIS.this_cGrDestino) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOP, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nTipo, 2))
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na auditoria
    * par_cOperacao: "VISUALIZAR" ou "IMPRIMIR"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cChave, loc_cUsuario
        LOCAL loc_cOperacao, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "EXECUTAR", UPPER(ALLTRIM(par_cOperacao)))

            loc_cChave    = THIS.ObterChavePrimaria()
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                                gc_4c_UsuarioLogado, "SYSTEM")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, Chave, Usuario, DataHora)" + ;
                       " VALUES (" + EscaparSQL("SIGRECPM") + ", " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar auditoria do relat" + ;
                                          CHR(243) + "rio"
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nunca deve interromper o relatorio; apenas registra erro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

