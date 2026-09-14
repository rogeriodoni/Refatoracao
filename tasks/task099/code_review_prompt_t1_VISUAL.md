# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [LAYOUT-POSITION] Controle 'OptQuebra' (parent: SIGREFCX): Top original=198 vs migrado 'opt_4c_OptQuebra' Top=113 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optcol' (parent: SIGREFCX): Top original=283 vs migrado 'opt_4c_OptCol' Top=198 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptMov' (parent: SIGREFCX): Top original=327 vs migrado 'opt_4c_OptMov' Top=242 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GrdTipo' (parent: SIGREFCX): Top original=216 vs migrado 'grd_4c_GrdTipo' Top=131 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGREFCX): Top original=286 vs migrado 'btn_4c_Apaga' Top=201 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGREFCX): Top original=241 vs migrado 'btn_4c_SelTudo' Top=156 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkDetLan' (parent: SIGREFCX): Top original=376 vs migrado 'chk_4c_ChkDetLan' Top=291 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefcx.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2043 linhas total):

*-- Linhas 6 a 14:
6: *
7: * Filtros: Empresa, Per" + CHR(237) + "odo, Moeda, Usu" + CHR(225) + "rio, Operador
8: *          OptQuebra, OptImpNomCli, OpcTipo, OptCol, OptMov, opt_nr_opcao
9: *          9 combos de resumo, 3 checkboxes, GrdTipo (SigCdTom)
10: *
11: * Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
12: *==============================================================================
13: 
14: DEFINE CLASS Formsigrefcx AS FormBase

*-- Linhas 39 a 47:
39:         loc_lSucesso   = .F.
40:         loc_lContinuar = .T.
41:         TRY
42:             THIS.Caption = "Fechamento de Caixa"
43:             IF TYPE("gc_4c_CaminhoIcones") = "U"
44:                 gc_4c_CaminhoIcones = ""
45:             ENDIF
46:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
47: 

*-- Linhas 59 a 68:
59:                 THIS.ConfigurarBotoes()
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 *-- Garante cs_SigCdTom para grid (BO popula com dados reais; placeholder aqui para UI validation)
66:                 IF !USED("cs_SigCdTom")
67:                     CREATE CURSOR cs_SigCdTom (Marca n(1), Descri c(40), Codigos n(2))
68:                     INDEX ON Codigos TAG Codigos

*-- Linhas 91 a 129:
91:     PROTECTED PROCEDURE ConfigurarCabecalho()
92:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
93:         WITH THIS.cnt_4c_Cabecalho
94:             .Top         = 0
95:             .Left        = 0
96:             .Width       = THIS.Width
97:             .Height      = 80
98:             .BackStyle   = 1
99:             .BackColor   = RGB(100, 100, 100)
100:             .BorderWidth = 0
101:             .Visible     = .T.
102: 
103:             .AddObject("lbl_4c_Sombra", "Label")
104:             WITH .lbl_4c_Sombra
105:                 .Top       = 22
106:                 .Left      = 22
107:                 .Width     = THIS.Width
108:                 .Height    = 30
109:                 .Caption   = "Fechamento de Caixa"
110:                 .FontName  = "Tahoma"
111:                 .FontSize  = 14
112:                 .FontBold  = .T.
113:                 .ForeColor = RGB(0, 0, 0)
114:                 .BackStyle = 0
115:                 .Visible   = .T.
116:             ENDWITH
117: 
118:             .AddObject("lbl_4c_Titulo", "Label")
119:             WITH .lbl_4c_Titulo
120:                 .Top       = 20
121:                 .Left      = 20
122:                 .Width     = THIS.Width
123:                 .Height    = 30
124:                 .Caption   = "Fechamento de Caixa"
125:                 .FontName  = "Tahoma"
126:                 .FontSize  = 14
127:                 .FontBold  = .T.
128:                 .ForeColor = RGB(255, 255, 255)
129:                 .BackStyle = 0

*-- Linhas 135 a 159:
135:     PROTECTED PROCEDURE ConfigurarBotoes()
136:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
137:         WITH THIS.cmg_4c_Botoes
138:             .Top           = 0
139:             .Left          = 529
140:             .Width         = 273
141:             .Height        = 80
142:             .ButtonCount   = 4
143:             .BackStyle     = 0
144:             .BorderStyle   = 0
145:             .SpecialEffect = 1
146:             .Themes        = .F.
147:             .Visible       = .T.
148: 
149:             WITH .Buttons(1)
150:                 .Top             = 5
151:                 .Left            = 5
152:                 .Width           = 65
153:                 .Height          = 70
154:                 .Caption         = "Visualizar"
155:                 .FontBold        = .T.
156:                 .FontItalic      = .T.
157:                 .BackColor       = RGB(255, 255, 255)
158:                 .ForeColor       = RGB(90, 90, 90)
159:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 166 a 178:
166:             ENDWITH
167: 
168:             WITH .Buttons(2)
169:                 .Top             = 5
170:                 .Left            = 71
171:                 .Width           = 65
172:                 .Height          = 70
173:                 .Caption         = "Imprimir"
174:                 .FontName        = "Tahoma"
175:                 .FontBold        = .T.
176:                 .FontItalic      = .T.
177:                 .FontSize        = 8
178:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 187 a 199:
187:             ENDWITH
188: 
189:             WITH .Buttons(3)
190:                 .Top             = 5
191:                 .Left            = 137
192:                 .Width           = 65
193:                 .Height          = 70
194:                 .Caption         = "Excel"
195:                 .FontName        = "Tahoma"
196:                 .FontBold        = .T.
197:                 .FontItalic      = .T.
198:                 .FontSize        = 8
199:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 208 a 220:
208:             ENDWITH
209: 
210:             WITH .Buttons(4)
211:                 .Top             = 5
212:                 .Left            = 203
213:                 .Width           = 65
214:                 .Height          = 70
215:                 .Caption         = "Encerrar"
216:                 .Cancel          = .T.
217:                 .FontName        = "Tahoma"
218:                 .FontBold        = .T.
219:                 .FontItalic      = .T.
220:                 .FontSize        = 8

*-- Linhas 236 a 250:
236:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
237:         loc_oPgf = THIS.pgf_4c_Paginas
238:         loc_oPgf.PageCount = 1
239:         loc_oPgf.Top    = 85
240:         loc_oPgf.Left   = -1
241:         loc_oPgf.Width  = THIS.Width + 2
242:         loc_oPgf.Height = THIS.Height - 85
243:         loc_oPgf.Tabs   = .F.
244: 
245:         loc_oPgf.Page1.Caption   = "Filtros"
246:         loc_oPgf.Page1.FontName  = "Tahoma"
247:         loc_oPgf.Page1.FontSize  = 8
248:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
249:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
250:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 260 a 285:
260:         *======================================================================
261:         * EMPRESA (original top=96/99 -> ajustado -85)
262:         *======================================================================
263:         loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
264:         WITH loc_oPg.lbl_4c_LblEmpresa
265:             .Top       = 14
266:             .Left      = 108
267:             .Width     = 52
268:             .Height    = 15
269:             .Caption   = "Empresa :"
270:             .FontName  = "Tahoma"
271:             .FontSize  = 8
272:             .ForeColor = RGB(90, 90, 90)
273:             .BackStyle = 0
274:             .Visible   = .T.
275:         ENDWITH
276: 
277:         loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
278:         WITH loc_oPg.txt_4c_CdEmpresa
279:             .Top           = 11
280:             .Left          = 162
281:             .Width         = 31
282:             .Height        = 23
283:             .Value         = ""
284:             .MaxLength     = 3
285:             .InputMask     = "!"

*-- Linhas 293 a 302:
293: 
294:         loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
295:         WITH loc_oPg.txt_4c_DsEmpresa
296:             .Top           = 11
297:             .Left          = 195
298:             .Width         = 289
299:             .Height        = 23
300:             .Value         = ""
301:             .MaxLength     = 40
302:             .InputMask     = "!"

*-- Linhas 311 a 366:
311:         *======================================================================
312:         * PERIODO (original top=121/124 -> ajustado -85)
313:         *======================================================================
314:         loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
315:         WITH loc_oPg.lbl_4c_LblPeriodo
316:             .Top       = 39
317:             .Left      = 113
318:             .Width     = 48
319:             .Height    = 15
320:             .Caption   = "Per" + CHR(237) + "odo :"
321:             .FontName  = "Tahoma"
322:             .FontSize  = 8
323:             .ForeColor = RGB(90, 90, 90)
324:             .BackStyle = 0
325:             .Visible   = .T.
326:         ENDWITH
327: 
328:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
329:         WITH loc_oPg.txt_4c_DtInicial
330:             .Top           = 36
331:             .Left          = 162
332:             .Width         = 80
333:             .Height        = 23
334:             .Value         = {}
335:             .Format        = "D"
336:             .FontName      = "Tahoma"
337:             .FontSize      = 8
338:             .BackColor     = RGB(255, 255, 255)
339:             .ForeColor     = RGB(0, 0, 0)
340:             .SpecialEffect = 1
341:             .Visible       = .T.
342:         ENDWITH
343: 
344:         loc_oPg.AddObject("lbl_4c_SepDatas", "Label")
345:         WITH loc_oPg.lbl_4c_SepDatas
346:             .Top       = 39
347:             .Left      = 247
348:             .Width     = 22
349:             .Height    = 15
350:             .Caption   = "at" + CHR(233)
351:             .FontName  = "Tahoma"
352:             .FontSize  = 8
353:             .ForeColor = RGB(90, 90, 90)
354:             .BackStyle = 0
355:             .Visible   = .T.
356:         ENDWITH
357: 
358:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
359:         WITH loc_oPg.txt_4c_DtFinal
360:             .Top           = 36
361:             .Left          = 271
362:             .Width         = 80
363:             .Height        = 23
364:             .Value         = {}
365:             .Format        = "D"
366:             .FontName      = "Tahoma"

*-- Linhas 374 a 399:
374:         *======================================================================
375:         * MOEDA (original top=146/149 -> ajustado -85)
376:         *======================================================================
377:         loc_oPg.AddObject("lbl_4c_LblMoeda", "Label")
378:         WITH loc_oPg.lbl_4c_LblMoeda
379:             .Top       = 64
380:             .Left      = 117
381:             .Width     = 44
382:             .Height    = 15
383:             .Caption   = "Moeda :"
384:             .FontName  = "Tahoma"
385:             .FontSize  = 8
386:             .ForeColor = RGB(90, 90, 90)
387:             .BackStyle = 0
388:             .Visible   = .T.
389:         ENDWITH
390: 
391:         loc_oPg.AddObject("txt_4c_CdMoeda", "TextBox")
392:         WITH loc_oPg.txt_4c_CdMoeda
393:             .Top           = 61
394:             .Left          = 162
395:             .Width         = 31
396:             .Height        = 23
397:             .Value         = ""
398:             .MaxLength     = 3
399:             .InputMask     = "!"

*-- Linhas 407 a 416:
407: 
408:         loc_oPg.AddObject("txt_4c_DsMoeda", "TextBox")
409:         WITH loc_oPg.txt_4c_DsMoeda
410:             .Top           = 61
411:             .Left          = 195
412:             .Width         = 156
413:             .Height        = 23
414:             .Value         = ""
415:             .MaxLength     = 15
416:             .InputMask     = "!"

*-- Linhas 425 a 450:
425:         *======================================================================
426:         * USUARIO / OPERADOR (original top=171/174 -> ajustado -85)
427:         *======================================================================
428:         loc_oPg.AddObject("lbl_4c_LblUsuario", "Label")
429:         WITH loc_oPg.lbl_4c_LblUsuario
430:             .Top       = 89
431:             .Left      = 113
432:             .Width     = 47
433:             .Height    = 15
434:             .Caption   = "Usu" + CHR(225) + "rio :"
435:             .FontName  = "Tahoma"
436:             .FontSize  = 8
437:             .ForeColor = RGB(90, 90, 90)
438:             .BackStyle = 0
439:             .Visible   = .T.
440:         ENDWITH
441: 
442:         loc_oPg.AddObject("txt_4c_Usuario", "TextBox")
443:         WITH loc_oPg.txt_4c_Usuario
444:             .Top           = 86
445:             .Left          = 162
446:             .Width         = 82
447:             .Height        = 23
448:             .Value         = ""
449:             .MaxLength     = 10
450:             .InputMask     = "!"

*-- Linhas 456 a 481:
456:             .Visible       = .T.
457:         ENDWITH
458: 
459:         loc_oPg.AddObject("lbl_4c_LblOperador", "Label")
460:         WITH loc_oPg.lbl_4c_LblOperador
461:             .Top       = 89
462:             .Left      = 262
463:             .Width     = 56
464:             .Height    = 15
465:             .Caption   = "Operador :"
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90, 90, 90)
469:             .BackStyle = 0
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         loc_oPg.AddObject("txt_4c_Operador", "TextBox")
474:         WITH loc_oPg.txt_4c_Operador
475:             .Top           = 86
476:             .Left          = 320
477:             .Width         = 31
478:             .Height        = 23
479:             .Value         = ""
480:             .MaxLength     = 10
481:             .InputMask     = "999"

*-- Linhas 490 a 769:
490:         *======================================================================
491:         * QUEBRA DE IMPRESSAO (original top=198/199 -> ajustado -85)
492:         *======================================================================
493:         loc_oPg.AddObject("lbl_4c_LblQuebra", "Label")
494:         WITH loc_oPg.lbl_4c_LblQuebra
495:             .Top       = 114
496:             .Left      = 45
497:             .Width     = 110
498:             .Height    = 15
499:             .Caption   = "Quebra de Impress" + CHR(227) + "o :"
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .ForeColor = RGB(90, 90, 90)
503:             .BackStyle = 0
504:             .Visible   = .T.
505:         ENDWITH
506: 
507:         loc_oPg.AddObject("opt_4c_OptQuebra", "OptionGroup")
508:         loc_oPg.opt_4c_OptQuebra.ButtonCount = 2
509:         WITH loc_oPg.opt_4c_OptQuebra
510:             .Top         = 113
511:             .Left        = 155
512:             .Width       = 232
513:             .Height      = 20
514:             .BackStyle   = 0
515:             .BorderStyle = 0
516:             .Visible     = .T.
517:         ENDWITH
518:         WITH loc_oPg.opt_4c_OptQuebra.Buttons(1)
519:             .Caption   = "Usu" + CHR(225) + "rio"
520:             .Left      = 5
521:             .Top       = 2
522:             .Width     = 54
523:             .Height    = 15
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .BackStyle = 0
527:             .ForeColor = RGB(90, 90, 90)
528:         ENDWITH
529:         WITH loc_oPg.opt_4c_OptQuebra.Buttons(2)
530:             .Caption   = "Sem Quebra"
531:             .Left      = 111
532:             .Top       = 2
533:             .Width     = 77
534:             .Height    = 15
535:             .FontName  = "Tahoma"
536:             .FontSize  = 8
537:             .BackStyle = 0
538:             .ForeColor = RGB(90, 90, 90)
539:         ENDWITH
540:         loc_oPg.opt_4c_OptQuebra.Value = 1
541: 
542:         *======================================================================
543:         * NOME DO CLIENTE (original top=221/222 -> ajustado -85)
544:         *======================================================================
545:         loc_oPg.AddObject("lbl_4c_LblNomeCli", "Label")
546:         WITH loc_oPg.lbl_4c_LblNomeCli
547:             .Top       = 137
548:             .Left      = 71
549:             .Width     = 82
550:             .Height    = 15
551:             .Caption   = "Nome do Cliente :"
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .ForeColor = RGB(90, 90, 90)
555:             .BackStyle = 0
556:             .Visible   = .T.
557:         ENDWITH
558: 
559:         loc_oPg.AddObject("opt_4c_ImpNomCli", "OptionGroup")
560:         loc_oPg.opt_4c_ImpNomCli.ButtonCount = 3
561:         WITH loc_oPg.opt_4c_ImpNomCli
562:             .Top         = 136
563:             .Left        = 155
564:             .Width       = 232
565:             .Height      = 36
566:             .BackStyle   = 0
567:             .BorderStyle = 0
568:             .Value       = 2
569:             .Visible     = .T.
570:         ENDWITH
571:         WITH loc_oPg.opt_4c_ImpNomCli.Buttons(1)
572:             .Caption   = "Imprimir"
573:             .Left      = 5
574:             .Top       = 2
575:             .Width     = 56
576:             .Height    = 15
577:             .FontName  = "Tahoma"
578:             .FontSize  = 8
579:             .BackStyle = 0
580:             .ForeColor = RGB(90, 90, 90)
581:         ENDWITH
582:         WITH loc_oPg.opt_4c_ImpNomCli.Buttons(2)
583:             .Caption   = "N" + CHR(227) + "o Imprimir"
584:             .Left      = 111
585:             .Top       = 2
586:             .Width     = 78
587:             .Height    = 15
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .BackStyle = 0
591:             .ForeColor = RGB(90, 90, 90)
592:         ENDWITH
593:         WITH loc_oPg.opt_4c_ImpNomCli.Buttons(3)
594:             .Caption   = "Imprimir Nome OU Observa" + CHR(231) + CHR(227) + "o"
595:             .Left      = 5
596:             .Top       = 19
597:             .Width     = 165
598:             .Height    = 15
599:             .FontName  = "Tahoma"
600:             .FontSize  = 8
601:             .BackStyle = 0
602:             .ForeColor = RGB(90, 90, 90)
603:         ENDWITH
604: 
605:         *======================================================================
606:         * TIPO (Opc_Tipo): Agrupado/Individual (original top=259/264 -> -85)
607:         *======================================================================
608:         loc_oPg.AddObject("lbl_4c_LblTipo", "Label")
609:         WITH loc_oPg.lbl_4c_LblTipo
610:             .Top       = 179
611:             .Left      = 129
612:             .Width     = 29
613:             .Height    = 15
614:             .Caption   = "Tipo :"
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8
617:             .ForeColor = RGB(90, 90, 90)
618:             .BackStyle = 0
619:             .Visible   = .T.
620:         ENDWITH
621: 
622:         loc_oPg.AddObject("opt_4c_OpcTipo", "OptionGroup")
623:         loc_oPg.opt_4c_OpcTipo.ButtonCount = 2
624:         WITH loc_oPg.opt_4c_OpcTipo
625:             .Top         = 174
626:             .Left        = 155
627:             .Width       = 232
628:             .Height      = 27
629:             .BackStyle   = 0
630:             .BorderStyle = 0
631:             .Visible     = .T.
632:         ENDWITH
633:         WITH loc_oPg.opt_4c_OpcTipo.Buttons(1)
634:             .Caption   = "Agrupado"
635:             .Left      = 5
636:             .Top       = 5
637:             .Width     = 83
638:             .Height    = 17
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .BackStyle = 0
642:             .ForeColor = RGB(90, 90, 90)
643:         ENDWITH
644:         WITH loc_oPg.opt_4c_OpcTipo.Buttons(2)
645:             .Caption   = "Individual"
646:             .Left      = 111
647:             .Top       = 5
648:             .Width     = 83
649:             .Height    = 17
650:             .FontName  = "Tahoma"
651:             .FontSize  = 8
652:             .BackStyle = 0
653:             .ForeColor = RGB(90, 90, 90)
654:         ENDWITH
655:         loc_oPg.opt_4c_OpcTipo.Value = 1
656: 
657:         *======================================================================
658:         * IMPRESSAO EM (OptCol): 40/80 colunas (original top=283/288 -> -85)
659:         *======================================================================
660:         loc_oPg.AddObject("lbl_4c_LblOptCol", "Label")
661:         WITH loc_oPg.lbl_4c_LblOptCol
662:             .Top       = 203
663:             .Left      = 82
664:             .Width     = 71
665:             .Height    = 15
666:             .Caption   = "Impress" + CHR(227) + "o em :"
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .ForeColor = RGB(90, 90, 90)
670:             .BackStyle = 0
671:             .Visible   = .T.
672:         ENDWITH
673: 
674:         loc_oPg.AddObject("opt_4c_OptCol", "OptionGroup")
675:         loc_oPg.opt_4c_OptCol.ButtonCount = 2
676:         WITH loc_oPg.opt_4c_OptCol
677:             .Top         = 198
678:             .Left        = 155
679:             .Width       = 232
680:             .Height      = 27
681:             .BackStyle   = 0
682:             .BorderStyle = 0
683:             .Visible     = .T.
684:         ENDWITH
685:         WITH loc_oPg.opt_4c_OptCol.Buttons(1)
686:             .Caption   = "40 Colunas"
687:             .Left      = 5
688:             .Top       = 5
689:             .Width     = 83
690:             .Height    = 17
691:             .FontName  = "Tahoma"
692:             .FontSize  = 8
693:             .BackStyle = 0
694:             .ForeColor = RGB(90, 90, 90)
695:         ENDWITH
696:         WITH loc_oPg.opt_4c_OptCol.Buttons(2)
697:             .Caption   = "80 Colunas"
698:             .Left      = 111
699:             .Top       = 5
700:             .Width     = 83
701:             .Height    = 17
702:             .FontName  = "Tahoma"
703:             .FontSize  = 8
704:             .BackStyle = 0
705:             .ForeColor = RGB(90, 90, 90)
706:         ENDWITH
707:         loc_oPg.opt_4c_OptCol.Value = 2
708: 
709:         *======================================================================
710:         * OPCAO (opt_nr_opcao): Sim/Nao/Ambos (original top=308/311 -> -85)
711:         *======================================================================
712:         loc_oPg.AddObject("lbl_4c_LblNrOpcao", "Label")
713:         WITH loc_oPg.lbl_4c_LblNrOpcao
714:             .Top       = 226
715:             .Left      = 118
716:             .Width     = 35
717:             .Height    = 15
718:             .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
719:             .FontName  = "Tahoma"
720:             .FontSize  = 8
721:             .ForeColor = RGB(90, 90, 90)
722:             .BackStyle = 0
723:             .Visible   = .T.
724:         ENDWITH
725: 
726:         loc_oPg.AddObject("opt_4c_NrOpcao", "OptionGroup")
727:         loc_oPg.opt_4c_NrOpcao.ButtonCount = 3
728:         WITH loc_oPg.opt_4c_NrOpcao
729:             .Top         = 223
730:             .Left        = 155
731:             .Width       = 232
732:             .Height      = 23
733:             .BackStyle   = 0
734:             .BorderStyle = 0
735:             .Visible     = .T.
736:         ENDWITH
737:         WITH loc_oPg.opt_4c_NrOpcao.Buttons(1)
738:             .Caption   = "Sim"
739:             .Left      = 5
740:             .Top       = 4
741:             .Width     = 34
742:             .Height    = 15
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .BackStyle = 0
746:             .AutoSize  = .T.
747:             .ForeColor = RGB(90, 90, 90)
748:         ENDWITH
749:         WITH loc_oPg.opt_4c_NrOpcao.Buttons(2)
750:             .Caption   = "N" + CHR(227) + "o"
751:             .Left      = 59
752:             .Top       = 4
753:             .Width     = 37
754:             .Height    = 15
755:             .FontName  = "Tahoma"
756:             .FontSize  = 8
757:             .BackStyle = 0
758:             .AutoSize  = .T.
759:             .ForeColor = RGB(90, 90, 90)
760:         ENDWITH
761:         WITH loc_oPg.opt_4c_NrOpcao.Buttons(3)
762:             .Caption   = "Ambos"
763:             .Left      = 111
764:             .Top       = 4
765:             .Width     = 50
766:             .Height    = 15
767:             .FontName  = "Tahoma"
768:             .FontSize  = 8
769:             .BackStyle = 0

*-- Linhas 775 a 901:
775:         *======================================================================
776:         * MOVIMENTACOES (OptMov): Sim/Nao (original top=327/332 -> -85)
777:         *======================================================================
778:         loc_oPg.AddObject("lbl_4c_LblOptMov", "Label")
779:         WITH loc_oPg.lbl_4c_LblOptMov
780:             .Top       = 247
781:             .Left      = 75
782:             .Width     = 80
783:             .Height    = 15
784:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
785:             .FontName  = "Tahoma"
786:             .FontSize  = 8
787:             .ForeColor = RGB(90, 90, 90)
788:             .BackStyle = 0
789:             .Visible   = .T.
790:         ENDWITH
791: 
792:         loc_oPg.AddObject("opt_4c_OptMov", "OptionGroup")
793:         loc_oPg.opt_4c_OptMov.ButtonCount = 2
794:         WITH loc_oPg.opt_4c_OptMov
795:             .Top         = 242
796:             .Left        = 155
797:             .Width       = 232
798:             .Height      = 27
799:             .BackStyle   = 0
800:             .BorderStyle = 0
801:             .Visible     = .T.
802:         ENDWITH
803:         WITH loc_oPg.opt_4c_OptMov.Buttons(1)
804:             .Caption   = "Sim"
805:             .Left      = 5
806:             .Top       = 5
807:             .Width     = 83
808:             .Height    = 17
809:             .FontName  = "Tahoma"
810:             .FontSize  = 8
811:             .BackStyle = 0
812:             .ForeColor = RGB(90, 90, 90)
813:         ENDWITH
814:         WITH loc_oPg.opt_4c_OptMov.Buttons(2)
815:             .Caption   = "N" + CHR(227) + "o"
816:             .Left      = 111
817:             .Top       = 5
818:             .Width     = 83
819:             .Height    = 17
820:             .FontName  = "Tahoma"
821:             .FontSize  = 8
822:             .BackStyle = 0
823:             .ForeColor = RGB(90, 90, 90)
824:         ENDWITH
825:         loc_oPg.opt_4c_OptMov.Value = 1
826: 
827:         *======================================================================
828:         * TIPO DE MOVIMENTACAO (painel direito) - original top=201/216 -> -85
829:         *======================================================================
830:         loc_oPg.AddObject("lbl_4c_LblTipoMov", "Label")
831:         WITH loc_oPg.lbl_4c_LblTipoMov
832:             .Top       = 116
833:             .Left      = 403
834:             .Width     = 172
835:             .Height    = 17
836:             .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
837:             .FontName  = "Tahoma"
838:             .FontSize  = 8
839:             .FontBold  = .T.
840:             .ForeColor = RGB(90, 90, 90)
841:             .BackStyle = 0
842:             .Visible   = .T.
843:         ENDWITH
844: 
845:         loc_oPg.AddObject("grd_4c_GrdTipo", "Grid")
846:         WITH loc_oPg.grd_4c_GrdTipo
847:             .Top           = 131
848:             .Left          = 403
849:             .Width         = 251
850:             .Height        = 138
851:             .RecordSource  = "cs_SigCdTom"
852:             .ColumnCount   = 2
853:             .DeleteMark    = .F.
854:             .HeaderHeight  = 0
855:             .RecordMark    = .F.
856:             .RowHeight     = 18
857:             .ScrollBars    = 2
858:             .FontName      = "Tahoma"
859:             .FontSize      = 8
860:             .GridLineColor = RGB(238, 238, 238)
861:             .Visible       = .T.
862:         ENDWITH
863:         WITH loc_oPg.grd_4c_GrdTipo.Column1
864:             .Width     = 20
865:             .Alignment = 0
866:             .Sparse    = .F.
867:             .FontName  = "Tahoma"
868:             .FontSize  = 8
869:             .Enabled   = .T.
870:             .AddObject("chk_4c_GrdMarca", "CheckBox")
871:             WITH .chk_4c_GrdMarca
872:                 .Caption   = ""
873:                 .Alignment = 0
874:                 .Width     = 20
875:                 .Height    = 17
876:                 .FontName  = "Tahoma"
877:             ENDWITH
878:             .CurrentControl = "chk_4c_GrdMarca"
879:             .ControlSource  = "cs_SigCdTom.Marca"
880:         ENDWITH
881:         WITH loc_oPg.grd_4c_GrdTipo.Column2
882:             .Width         = 215
883:             .ControlSource = "cs_SigCdTom.Descri"
884:             .ReadOnly      = .T.
885:             .FontName      = "Tahoma"
886:             .FontSize      = 8
887:             .Enabled       = .T.
888:         ENDWITH
889: 
890:         loc_oPg.AddObject("btn_4c_SelTudo", "CommandButton")
891:         WITH loc_oPg.btn_4c_SelTudo
892:             .Top         = 156
893:             .Left        = 657
894:             .Width       = 45
895:             .Height      = 45
896:             .Caption     = ""
897:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
898:             .ToolTipText = "Marcar"
899:             .TabStop     = .F.
900:             .ForeColor   = RGB(36, 84, 155)
901:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 907 a 919:
907: 
908:         loc_oPg.AddObject("btn_4c_Apaga", "CommandButton")
909:         WITH loc_oPg.btn_4c_Apaga
910:             .Top         = 201
911:             .Left        = 657
912:             .Width       = 45
913:             .Height      = 45
914:             .Caption     = ""
915:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
916:             .ToolTipText = "Desmarcar"
917:             .TabStop     = .F.
918:             .ForeColor   = RGB(36, 84, 155)
919:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 928 a 937:
928:         *======================================================================
929:         loc_oPg.AddObject("shp_4c_Separador", "Shape")
930:         WITH loc_oPg.shp_4c_Separador
931:             .Top         = 275
932:             .Left        = 6
933:             .Width       = 782
934:             .Height      = 2
935:             .BackStyle   = 1
936:             .BorderStyle = 6
937:             .BorderWidth = 2

*-- Linhas 943 a 1062:
943:         *======================================================================
944:         * IMPRESSAO DE RESUMOS - cabecalho (original top=351 -> -85)
945:         *======================================================================
946:         loc_oPg.AddObject("lbl_4c_LblResumos", "Label")
947:         WITH loc_oPg.lbl_4c_LblResumos
948:             .Top       = 266
949:             .Left      = 6
950:             .Width     = 135
951:             .Height    = 15
952:             .Caption   = "Impress" + CHR(227) + "o de Resumos"
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .FontBold  = .T.
956:             .ForeColor = RGB(90, 90, 90)
957:             .BackStyle = 0
958:             .Visible   = .T.
959:         ENDWITH
960: 
961:         *-- Linha 1: Lancamento | Lancto.xF.Pagto | Conta Corrente
962:         loc_oPg.AddObject("lbl_4c_LblLanca", "Label")
963:         WITH loc_oPg.lbl_4c_LblLanca
964:             .Top       = 292
965:             .Left      = 32
966:             .Width     = 70
967:             .Height    = 15
968:             .Caption   = "Lan" + CHR(231) + "amento :"
969:             .FontName  = "Tahoma"
970:             .FontSize  = 8
971:             .ForeColor = RGB(90, 90, 90)
972:             .BackStyle = 0
973:             .Visible   = .T.
974:         ENDWITH
975: 
976:         loc_oPg.AddObject("cmb_4c_ResLanca", "ComboBox")
977:         WITH loc_oPg.cmb_4c_ResLanca
978:             .Top           = 287
979:             .Left          = 103
980:             .Width         = 48
981:             .Height        = 24
982:             .RowSourceType = 1
983:             .RowSource     = "Sim,N" + CHR(227) + "o"
984:             .Style         = 2
985:             .SpecialEffect = 1
986:             .FontName      = "Tahoma"
987:             .FontSize      = 8
988:             .ForeColor     = RGB(0, 0, 0)
989:             .Visible       = .T.
990:         ENDWITH
991: 
992:         loc_oPg.AddObject("chk_4c_ChkDetLan", "CheckBox")
993:         WITH loc_oPg.chk_4c_ChkDetLan
994:             .Top           = 291
995:             .Left          = 155
996:             .Width         = 67
997:             .Height        = 15
998:             .Caption       = "Detalhado"
999:             .Value         = 0
1000:             .AutoSize      = .T.
1001:             .Alignment     = 0
1002:             .BackStyle     = 0
1003:             .SpecialEffect = 1
1004:             .FontName      = "Tahoma"
1005:             .FontSize      = 8
1006:             .ForeColor     = RGB(90, 90, 90)
1007:             .Visible       = .T.
1008:         ENDWITH
1009: 
1010:         loc_oPg.AddObject("lbl_4c_LblLanFor", "Label")
1011:         WITH loc_oPg.lbl_4c_LblLanFor
1012:             .Top       = 292
1013:             .Left      = 322
1014:             .Width     = 100
1015:             .Height    = 15
1016:             .Caption   = "Lan" + CHR(231) + "to. x F. Pagto.:"
1017:             .FontName  = "Tahoma"
1018:             .FontSize  = 8
1019:             .ForeColor = RGB(90, 90, 90)
1020:             .BackStyle = 0
1021:             .Visible   = .T.
1022:         ENDWITH
1023: 
1024:         loc_oPg.AddObject("cmb_4c_ResLanFor", "ComboBox")
1025:         WITH loc_oPg.cmb_4c_ResLanFor
1026:             .Top           = 287
1027:             .Left          = 424
1028:             .Width         = 48
1029:             .Height        = 24
1030:             .RowSourceType = 1
1031:             .RowSource     = "Sim,N" + CHR(227) + "o"
1032:             .Style         = 2
1033:             .SpecialEffect = 1
1034:             .FontName      = "Tahoma"
1035:             .FontSize      = 8
1036:             .ForeColor     = RGB(0, 0, 0)
1037:             .Visible       = .T.
1038:         ENDWITH
1039: 
1040:         loc_oPg.AddObject("lbl_4c_LblContaC", "Label")
1041:         WITH loc_oPg.lbl_4c_LblContaC
1042:             .Top       = 292
1043:             .Left      = 590
1044:             .Width     = 85
1045:             .Height    = 15
1046:             .Caption   = "Conta Corrente :"
1047:             .FontName  = "Tahoma"
1048:             .FontSize  = 8
1049:             .ForeColor = RGB(90, 90, 90)
1050:             .BackStyle = 0
1051:             .Visible   = .T.
1052:         ENDWITH
1053: 
1054:         loc_oPg.AddObject("cmb_4c_ResContac", "ComboBox")
1055:         WITH loc_oPg.cmb_4c_ResContac
1056:             .Top           = 287
1057:             .Left          = 678
1058:             .Width         = 48
1059:             .Height        = 24
1060:             .RowSourceType = 1
1061:             .RowSource     = "Sim,N" + CHR(227) + "o"
1062:             .Style         = 2

*-- Linhas 1068 a 1171:
1068:         ENDWITH
1069: 
1070:         *-- Linha 2: Cartao | Forma de Pagamento | Resumo Quantidade
1071:         loc_oPg.AddObject("lbl_4c_LblCartao", "Label")
1072:         WITH loc_oPg.lbl_4c_LblCartao
1073:             .Top       = 318
1074:             .Left      = 57
1075:             .Width     = 44
1076:             .Height    = 15
1077:             .Caption   = "Cart" + CHR(227) + "o :"
1078:             .FontName  = "Tahoma"
1079:             .FontSize  = 8
1080:             .ForeColor = RGB(90, 90, 90)
1081:             .BackStyle = 0
1082:             .Visible   = .T.
1083:         ENDWITH
1084: 
1085:         loc_oPg.AddObject("cmb_4c_ResCartao", "ComboBox")
1086:         WITH loc_oPg.cmb_4c_ResCartao
1087:             .Top           = 313
1088:             .Left          = 103
1089:             .Width         = 48
1090:             .Height        = 24
1091:             .RowSourceType = 1
1092:             .RowSource     = "Sim,N" + CHR(227) + "o"
1093:             .Style         = 2
1094:             .SpecialEffect = 1
1095:             .FontName      = "Tahoma"
1096:             .FontSize      = 8
1097:             .ForeColor     = RGB(0, 0, 0)
1098:             .Visible       = .T.
1099:         ENDWITH
1100: 
1101:         loc_oPg.AddObject("chk_4c_CrtDetalhado", "CheckBox")
1102:         WITH loc_oPg.chk_4c_CrtDetalhado
1103:             .Top           = 318
1104:             .Left          = 155
1105:             .Width         = 67
1106:             .Height        = 15
1107:             .Caption       = "Detalhado"
1108:             .Value         = 0
1109:             .AutoSize      = .T.
1110:             .Alignment     = 0
1111:             .BackStyle     = 0
1112:             .SpecialEffect = 1
1113:             .FontName      = "Tahoma"
1114:             .FontSize      = 8
1115:             .ForeColor     = RGB(90, 90, 90)
1116:             .Visible       = .T.
1117:         ENDWITH
1118: 
1119:         loc_oPg.AddObject("lbl_4c_LblForma", "Label")
1120:         WITH loc_oPg.lbl_4c_LblForma
1121:             .Top       = 318
1122:             .Left      = 310
1123:             .Width     = 112
1124:             .Height    = 15
1125:             .Caption   = "Forma de Pagamento :"
1126:             .FontName  = "Tahoma"
1127:             .FontSize  = 8
1128:             .ForeColor = RGB(90, 90, 90)
1129:             .BackStyle = 0
1130:             .Visible   = .T.
1131:         ENDWITH
1132: 
1133:         loc_oPg.AddObject("cmb_4c_ResForma", "ComboBox")
1134:         WITH loc_oPg.cmb_4c_ResForma
1135:             .Top           = 313
1136:             .Left          = 424
1137:             .Width         = 48
1138:             .Height        = 24
1139:             .RowSourceType = 1
1140:             .RowSource     = "Sim,N" + CHR(227) + "o"
1141:             .Style         = 2
1142:             .SpecialEffect = 1
1143:             .FontName      = "Tahoma"
1144:             .FontSize      = 8
1145:             .ForeColor     = RGB(0, 0, 0)
1146:             .Visible       = .T.
1147:         ENDWITH
1148: 
1149:         loc_oPg.AddObject("lbl_4c_LblQtdes", "Label")
1150:         WITH loc_oPg.lbl_4c_LblQtdes
1151:             .Top       = 318
1152:             .Left      = 568
1153:             .Width     = 108
1154:             .Height    = 15
1155:             .Caption   = "Resumo Quantidade :"
1156:             .FontName  = "Tahoma"
1157:             .FontSize  = 8
1158:             .ForeColor = RGB(90, 90, 90)
1159:             .BackStyle = 0
1160:             .Visible   = .T.
1161:         ENDWITH
1162: 
1163:         loc_oPg.AddObject("cmb_4c_ResQtdes", "ComboBox")
1164:         WITH loc_oPg.cmb_4c_ResQtdes
1165:             .Top           = 313
1166:             .Left          = 678
1167:             .Width         = 48
1168:             .Height        = 24
1169:             .RowSourceType = 1
1170:             .RowSource     = "Sim,N" + CHR(227) + "o"
1171:             .Style         = 2

*-- Linhas 1177 a 1280:
1177:         ENDWITH
1178: 
1179:         *-- Linha 3: Cheques | Vendedor | Vendedor Detalhado
1180:         loc_oPg.AddObject("lbl_4c_LblCheque", "Label")
1181:         WITH loc_oPg.lbl_4c_LblCheque
1182:             .Top       = 344
1183:             .Left      = 48
1184:             .Width     = 53
1185:             .Height    = 15
1186:             .Caption   = "Cheques :"
1187:             .FontName  = "Tahoma"
1188:             .FontSize  = 8
1189:             .ForeColor = RGB(90, 90, 90)
1190:             .BackStyle = 0
1191:             .Visible   = .T.
1192:         ENDWITH
1193: 
1194:         loc_oPg.AddObject("cmb_4c_ResCheque", "ComboBox")
1195:         WITH loc_oPg.cmb_4c_ResCheque
1196:             .Top           = 339
1197:             .Left          = 103
1198:             .Width         = 48
1199:             .Height        = 24
1200:             .RowSourceType = 1
1201:             .RowSource     = "Sim,N" + CHR(227) + "o"
1202:             .Style         = 2
1203:             .SpecialEffect = 1
1204:             .FontName      = "Tahoma"
1205:             .FontSize      = 8
1206:             .ForeColor     = RGB(0, 0, 0)
1207:             .Visible       = .T.
1208:         ENDWITH
1209: 
1210:         loc_oPg.AddObject("chk_4c_ChqDetalhado", "CheckBox")
1211:         WITH loc_oPg.chk_4c_ChqDetalhado
1212:             .Top           = 344
1213:             .Left          = 155
1214:             .Width         = 67
1215:             .Height        = 15
1216:             .Caption       = "Detalhado"
1217:             .Value         = 0
1218:             .AutoSize      = .T.
1219:             .Alignment     = 0
1220:             .BackStyle     = 0
1221:             .SpecialEffect = 1
1222:             .FontName      = "Tahoma"
1223:             .FontSize      = 8
1224:             .ForeColor     = RGB(90, 90, 90)
1225:             .Visible       = .T.
1226:         ENDWITH
1227: 
1228:         loc_oPg.AddObject("lbl_4c_LblVendedor", "Label")
1229:         WITH loc_oPg.lbl_4c_LblVendedor
1230:             .Top       = 344
1231:             .Left      = 366
1232:             .Width     = 56
1233:             .Height    = 15
1234:             .Caption   = "Vendedor :"
1235:             .FontName  = "Tahoma"
1236:             .FontSize  = 8
1237:             .ForeColor = RGB(90, 90, 90)
1238:             .BackStyle = 0
1239:             .Visible   = .T.
1240:         ENDWITH
1241: 
1242:         loc_oPg.AddObject("cmb_4c_ResVende", "ComboBox")
1243:         WITH loc_oPg.cmb_4c_ResVende
1244:             .Top           = 339
1245:             .Left          = 424
1246:             .Width         = 48
1247:             .Height        = 24
1248:             .RowSourceType = 1
1249:             .RowSource     = "Sim,N" + CHR(227) + "o"
1250:             .Style         = 2
1251:             .SpecialEffect = 1
1252:             .FontName      = "Tahoma"
1253:             .FontSize      = 8
1254:             .ForeColor     = RGB(0, 0, 0)
1255:             .Visible       = .T.
1256:         ENDWITH
1257: 
1258:         loc_oPg.AddObject("lbl_4c_LblDetVen", "Label")
1259:         WITH loc_oPg.lbl_4c_LblDetVen
1260:             .Top       = 344
1261:             .Left      = 567
1262:             .Width     = 110
1263:             .Height    = 15
1264:             .Caption   = "Vendedor Detalhado :"
1265:             .FontName  = "Tahoma"
1266:             .FontSize  = 8
1267:             .ForeColor = RGB(90, 90, 90)
1268:             .BackStyle = 0
1269:             .Visible   = .T.
1270:         ENDWITH
1271: 
1272:         loc_oPg.AddObject("cmb_4c_ResDetVen", "ComboBox")
1273:         WITH loc_oPg.cmb_4c_ResDetVen
1274:             .Top           = 339
1275:             .Left          = 678
1276:             .Width         = 48
1277:             .Height        = 24
1278:             .RowSourceType = 1
1279:             .RowSource     = "Sim,N" + CHR(227) + "o"
1280:             .Style         = 2

*-- Linhas 1306 a 1326:
1306:         BINDEVENT(loc_oPg.txt_4c_CdMoeda,   "DblClick", THIS, "AbrirBuscaCdMoeda")
1307:         BINDEVENT(loc_oPg.txt_4c_DsMoeda,   "DblClick", THIS, "AbrirBuscaDsMoeda")
1308:         BINDEVENT(loc_oPg.txt_4c_Usuario,   "DblClick", THIS, "AbrirBuscaUsuario")
1309:         BINDEVENT(loc_oPg.txt_4c_Operador,  "DblClick", THIS, "AbrirBuscaOperador")
1310: 
1311:         BINDEVENT(loc_oPg.opt_4c_OptCol,   "InteractiveChange", THIS, "OptColMudou")
1312:         BINDEVENT(loc_oPg.btn_4c_SelTudo,  "Click",             THIS, "BtnSelTudoClick")
1313:         BINDEVENT(loc_oPg.btn_4c_Apaga,    "Click",             THIS, "BtnApagaClick")
1314:     ENDPROC
1315: 
1316:     PROCEDURE LimparCampos()
1317:         LOCAL loc_oPg, loc_nOptCol
1318:         TRY
1319:             IF VARTYPE(THIS.this_oRelatorio) != "O"
1320:                 RETURN
1321:             ENDIF
1322:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1323: 
1324:             loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(THIS.this_oRelatorio.this_cCdEmpresa)
1325:             loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(THIS.this_oRelatorio.this_cDsEmpresa)
1326:             loc_oPg.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial

*-- Linhas 1339 a 1374:
1339:                     IF INLIST(NVL(resimps, 0), 1, 2)
1340:                         loc_nOptCol = NVL(resimps, 2)
1341:                     ENDIF
1342:                 ENDIF
1343:             ENDIF
1344:             loc_oPg.opt_4c_OptCol.Value = loc_nOptCol
1345: 
1346:             loc_oPg.opt_4c_OptQuebra.Value = THIS.this_oRelatorio.this_nOptQuebra
1347:             loc_oPg.opt_4c_ImpNomCli.Value = THIS.this_oRelatorio.this_nOptImpNomCli
1348:             loc_oPg.opt_4c_OpcTipo.Value   = THIS.this_oRelatorio.this_nOpcTipo
1349:             loc_oPg.opt_4c_OptMov.Value    = THIS.this_oRelatorio.this_nOptMov
1350:             loc_oPg.opt_4c_NrOpcao.Value   = THIS.this_oRelatorio.this_nOptNrOpcao
1351: 
1352:             *-- 40 colunas: desabilita e forca ImpNomCli = Nao Imprimir
1353:             loc_oPg.opt_4c_ImpNomCli.Enabled = (loc_nOptCol = 2)
1354:             IF loc_nOptCol = 1
1355:                 loc_oPg.opt_4c_ImpNomCli.Value = 2
1356:             ENDIF
1357: 
1358:             *-- ComboBoxes de resumo (ListIndex: 1=Sim, 2=Nao)
1359:             loc_oPg.cmb_4c_ResLanca.ListIndex  = THIS.this_oRelatorio.this_nResLanca
1360:             loc_oPg.cmb_4c_ResForma.ListIndex  = THIS.this_oRelatorio.this_nResForma
1361:             loc_oPg.cmb_4c_ResCheque.ListIndex = THIS.this_oRelatorio.this_nResCheque
1362:             loc_oPg.cmb_4c_ResCartao.ListIndex = THIS.this_oRelatorio.this_nResCartao
1363:             loc_oPg.cmb_4c_ResVende.ListIndex  = THIS.this_oRelatorio.this_nResVende
1364:             loc_oPg.cmb_4c_ResContac.ListIndex = THIS.this_oRelatorio.this_nResConta
1365:             loc_oPg.cmb_4c_ResLanFor.ListIndex = THIS.this_oRelatorio.this_nResLanFor
1366:             loc_oPg.cmb_4c_ResQtdes.ListIndex  = THIS.this_oRelatorio.this_nResQtdes
1367:             loc_oPg.cmb_4c_ResDetVen.ListIndex = THIS.this_oRelatorio.this_nResVDets
1368: 
1369:             *-- CheckBoxes
1370:             loc_oPg.chk_4c_CrtDetalhado.Value = THIS.this_oRelatorio.this_nCrtDetalhado
1371:             loc_oPg.chk_4c_ChqDetalhado.Value = THIS.this_oRelatorio.this_nChqDetalhado
1372:             loc_oPg.chk_4c_ChkDetLan.Value    = THIS.this_oRelatorio.this_nChkDetLan
1373: 
1374:         CATCH TO loc_oErro

*-- Linhas 1386 a 1411:
1386:             .this_dDtFinal      = loc_oPg.txt_4c_DtFinal.Value
1387:             .this_cCdMoeda      = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
1388:             .this_cDsMoeda      = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
1389:             .this_cUsuario      = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)
1390:             .this_cOperador     = ALLTRIM(loc_oPg.txt_4c_Operador.Value)
1391:             .this_nOptQuebra    = loc_oPg.opt_4c_OptQuebra.Value
1392:             .this_nOptImpNomCli = loc_oPg.opt_4c_ImpNomCli.Value
1393:             .this_nOpcTipo      = loc_oPg.opt_4c_OpcTipo.Value
1394:             .this_nOptcol       = loc_oPg.opt_4c_OptCol.Value
1395:             .this_nOptNrOpcao   = loc_oPg.opt_4c_NrOpcao.Value
1396:             .this_nOptMov       = loc_oPg.opt_4c_OptMov.Value
1397:             .this_nResLanca  = IIF(loc_oPg.cmb_4c_ResLanca.ListIndex  > 0, loc_oPg.cmb_4c_ResLanca.ListIndex,  1)
1398:             .this_nResForma  = IIF(loc_oPg.cmb_4c_ResForma.ListIndex  > 0, loc_oPg.cmb_4c_ResForma.ListIndex,  1)
1399:             .this_nResCheque = IIF(loc_oPg.cmb_4c_ResCheque.ListIndex > 0, loc_oPg.cmb_4c_ResCheque.ListIndex, 1)
1400:             .this_nResCartao = IIF(loc_oPg.cmb_4c_ResCartao.ListIndex > 0, loc_oPg.cmb_4c_ResCartao.ListIndex, 1)
1401:             .this_nResVende  = IIF(loc_oPg.cmb_4c_ResVende.ListIndex  > 0, loc_oPg.cmb_4c_ResVende.ListIndex,  1)
1402:             .this_nResConta  = IIF(loc_oPg.cmb_4c_ResContac.ListIndex > 0, loc_oPg.cmb_4c_ResContac.ListIndex, 1)
1403:             .this_nResLanFor = IIF(loc_oPg.cmb_4c_ResLanFor.ListIndex > 0, loc_oPg.cmb_4c_ResLanFor.ListIndex, 1)
1404:             .this_nResQtdes  = IIF(loc_oPg.cmb_4c_ResQtdes.ListIndex  > 0, loc_oPg.cmb_4c_ResQtdes.ListIndex,  1)
1405:             .this_nResVDets  = IIF(loc_oPg.cmb_4c_ResDetVen.ListIndex > 0, loc_oPg.cmb_4c_ResDetVen.ListIndex, 1)
1406:             .this_nCrtDetalhado = loc_oPg.chk_4c_CrtDetalhado.Value
1407:             .this_nChqDetalhado = loc_oPg.chk_4c_ChqDetalhado.Value
1408:             .this_nChkDetLan    = loc_oPg.chk_4c_ChkDetLan.Value
1409:         ENDWITH
1410:     ENDPROC
1411: 

*-- Linhas 1494 a 1544:
1494:     *-- OptCol.InteractiveChange: 40 colunas obriga ImpNomCli = Nao Imprimir
1495:     PROCEDURE OptColMudou()
1496:         LOCAL loc_oPg
1497:         TRY
1498:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1499:             IF loc_oPg.opt_4c_OptCol.Value = 1
1500:                 loc_oPg.opt_4c_ImpNomCli.Value   = 2
1501:                 loc_oPg.opt_4c_ImpNomCli.Enabled = .F.
1502:             ELSE
1503:                 loc_oPg.opt_4c_ImpNomCli.Enabled = .T.
1504:             ENDIF
1505:         CATCH TO loc_oErro
1506:             MsgErro(loc_oErro.Message, "OptColMudou")
1507:         ENDTRY
1508:     ENDPROC
1509: 
1510:     PROCEDURE BtnSelTudoClick()
1511:         TRY
1512:             IF USED("cs_SigCdTom")
1513:                 SELECT cs_SigCdTom
1514:                 REPLACE ALL Marca WITH 1
1515:                 GO TOP
1516:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
1517:             ENDIF
1518:         CATCH TO loc_oErro
1519:             MsgErro(loc_oErro.Message, "BtnSelTudoClick")
1520:         ENDTRY
1521:     ENDPROC
1522: 
1523:     PROCEDURE BtnApagaClick()
1524:         TRY
1525:             IF USED("cs_SigCdTom")
1526:                 SELECT cs_SigCdTom
1527:                 REPLACE ALL Marca WITH 0
1528:                 GO TOP
1529:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
1530:             ENDIF
1531:         CATCH TO loc_oErro
1532:             MsgErro(loc_oErro.Message, "BtnApagaClick")
1533:         ENDTRY
1534:     ENDPROC
1535: 
1536:     *==========================================================================
1537:     * HANDLERS DE TECLADO (F4=115, ENTER=13, TAB=9)
1538:     *==========================================================================
1539: 
1540:     PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1541:         IF par_nKeyCode = 115
1542:             THIS.AbrirBuscaCdEmpresa()
1543:         ENDIF
1544:         IF par_nKeyCode = 13 OR par_nKeyCode = 9

