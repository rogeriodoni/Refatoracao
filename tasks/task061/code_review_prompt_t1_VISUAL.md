# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpVende' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_CotMov' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1602 linhas total):

*-- Linhas 14 a 22:
14: *   - Tipo        : opt_4c_Tipo (4: Anal./ Sint./ Resumido / Anal. por parcelas)
15: *   - Selecao     : opt_4c_Quebras (3: Todos / Pagos / Nao Pagos)
16: *   - Movimento   : opt_4c_Movs (3: Ambas / Entradas / Saidas)
17: *   - % Comissao  : chk_4c_PComis (checkbox)
18: *   - Saldo       : opt_4c_Saldo (2: Sim / Nao; default=2)
19: *
20: * Form: Width=800, Height=400
21: * Cabecalho: Top=0, Height=80
22: * PageFrame: Top=85, Height=315, Width=802

*-- Linhas 59 a 67:
59:         loc_lContinuar = .T.
60: 
61:         TRY
62:             THIS.Caption = "Comiss" + CHR(245) + "es por Recebimento"
63: 
64:             IF TYPE("gc_4c_CaminhoIcones") = "U"
65:                 gc_4c_CaminhoIcones = ""
66:             ENDIF
67:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 79 a 88:
79:             IF loc_lContinuar
80:                 THIS.ConfigurarCabecalho()
81:                 THIS.ConfigurarPageFrame()
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
84:                 THIS.ConfigurarPaginaLista()
85:                 THIS.ConfigurarPaginaDados()
86:                 THIS.LimparCampos()
87:                 loc_lSucesso = .T.
88:             ENDIF

*-- Linhas 107 a 170:
107:         loc_oCab = THIS.cnt_4c_Cabecalho
108: 
109:         WITH loc_oCab
110:             .Top         = 0
111:             .Left        = 0
112:             .Width       = THIS.Width
113:             .Height      = 80
114:             .BackStyle   = 1
115:             .BackColor   = RGB(100, 100, 100)
116:             .BorderWidth = 0
117:             .Visible     = .T.
118: 
119:             .AddObject("lbl_4c_Sombra", "Label")
120:             WITH .lbl_4c_Sombra
121:                 .Top       = 22
122:                 .Left      = 22
123:                 .Width     = THIS.Width
124:                 .Height    = 30
125:                 .Caption   = "Comiss" + CHR(245) + "es por Recebimento"
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 14
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(0, 0, 0)
130:                 .BackStyle = 0
131:                 .Visible   = .T.
132:             ENDWITH
133: 
134:             .AddObject("lbl_4c_Titulo", "Label")
135:             WITH .lbl_4c_Titulo
136:                 .Top       = 20
137:                 .Left      = 20
138:                 .Width     = THIS.Width
139:                 .Height    = 30
140:                 .Caption   = "Comiss" + CHR(245) + "es por Recebimento"
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 14
143:                 .FontBold  = .T.
144:                 .ForeColor = RGB(255, 255, 255)
145:                 .BackStyle = 0
146:                 .Visible   = .T.
147:             ENDWITH
148: 
149:             .AddObject("cmg_4c_Botoes", "CommandGroup")
150:             WITH .cmg_4c_Botoes
151:                 .Top           = 0
152:                 .Left          = 529
153:                 .Width         = THIS.Width
154:                 .Height        = 80
155:                 .ButtonCount   = 4
156:                 .BackStyle     = 0
157:                 .BorderColor   = RGB(136, 189, 188)
158:                 .SpecialEffect = 1
159:                 .Themes        = .F.
160:                 .Visible       = .T.
161: 
162:                 WITH .Buttons(1)
163:                     .Caption         = "Visualizar"
164:                     .Top             = 5
165:                     .Left            = 5
166:                     .Width           = THIS.Width
167:                     .Height          = 70
168:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
169:                     .PicturePosition = 13
170:                     .FontBold        = .T.

*-- Linhas 177 a 187:
177:                 ENDWITH
178: 
179:                 WITH .Buttons(2)
180:                     .Caption         = "Imprimir"
181:                     .Top             = 5
182:                     .Left            = 71
183:                     .Width           = THIS.Width
184:                     .Height          = 70
185:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
186:                     .PicturePosition = 13
187:                     .FontName        = "Tahoma"

*-- Linhas 196 a 206:
196:                 ENDWITH
197: 
198:                 WITH .Buttons(3)
199:                     .Caption         = "Doc. Excel"
200:                     .Top             = 5
201:                     .Left            = 137
202:                     .Width           = THIS.Width
203:                     .Height          = 70
204:                     .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
205:                     .PicturePosition = 13
206:                     .FontName        = "Tahoma"

*-- Linhas 215 a 225:
215:                 ENDWITH
216: 
217:                 WITH .Buttons(4)
218:                     .Caption         = "Sair"
219:                     .Top             = 5
220:                     .Left            = 203
221:                     .Width           = THIS.Width
222:                     .Height          = 70
223:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
224:                     .PicturePosition = 13
225:                     .Cancel          = .T.

*-- Linhas 254 a 268:
254:         loc_oPgf = THIS.pgf_4c_Paginas
255: 
256:         loc_oPgf.PageCount = 1
257:         loc_oPgf.Top       = 85
258:         loc_oPgf.Left      = -1
259:         loc_oPgf.Width     = THIS.Width + 2
260:         loc_oPgf.Height    = THIS.Height - 85
261:         loc_oPgf.Tabs      = .F.
262: 
263:         loc_oPgf.Page1.Caption   = "Filtros"
264:         loc_oPgf.Page1.FontName  = "Tahoma"
265:         loc_oPgf.Page1.FontSize  = 8
266:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
267:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
268:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 274 a 306:
274:     *--------------------------------------------------------------------------
275:     * ConfigurarPaginaLista - Controles de filtro na Page1
276:     *   Posicoes: Top_page1 = Top_original - 85
277:     *   (Form original: Top=108..333; PageFrame.Top=85)
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarPaginaLista()
280:         LOCAL loc_oPagina
281:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
282: 
283:         *-- Periodo (top_orig=111, left=203 -> page1 top=26)
284:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
285:         WITH loc_oPagina.lbl_4c_Periodo
286:             .Top       = 26
287:             .Left      = 203
288:             .Width     = 46
289:             .Height    = 18
290:             .Caption   = "Per" + CHR(237) + "odo :"
291:             .FontName  = "Tahoma"
292:             .FontSize  = 8
293:             .ForeColor = RGB(90, 90, 90)
294:             .BackStyle = 0
295:             .Visible   = .T.
296:         ENDWITH
297: 
298:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
299:         WITH loc_oPagina.txt_4c_DtInicial
300:             .Top           = 23
301:             .Left          = 252
302:             .Width         = 80
303:             .Height        = 23
304:             .Value         = {}
305:             .FontName      = "Tahoma"
306:             .FontSize      = 8

*-- Linhas 313 a 338:
313:         ENDWITH
314:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
315: 
316:         loc_oPagina.AddObject("lbl_4c_PeriodoSep", "Label")
317:         WITH loc_oPagina.lbl_4c_PeriodoSep
318:             .Top       = 27
319:             .Left      = 336
320:             .Width     = 8
321:             .Height    = 18
322:             .Caption   = CHR(224)
323:             .FontName  = "Tahoma"
324:             .FontSize  = 8
325:             .ForeColor = RGB(90, 90, 90)
326:             .BackStyle = 0
327:             .Visible   = .T.
328:         ENDWITH
329: 
330:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
331:         WITH loc_oPagina.txt_4c_DtFinal
332:             .Top           = 23
333:             .Left          = 348
334:             .Width         = 80
335:             .Height        = 23
336:             .Value         = {}
337:             .FontName      = "Tahoma"
338:             .FontSize      = 8

*-- Linhas 346 a 371:
346:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")
347: 
348:         *-- Empresa (top_orig=137, left=198 -> page1 top=52)
349:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
350:         WITH loc_oPagina.lbl_4c_Empresa
351:             .Top       = 52
352:             .Left      = 198
353:             .Width     = 50
354:             .Height    = 18
355:             .Caption   = "Empresa :"
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .ForeColor = RGB(90, 90, 90)
359:             .BackStyle = 0
360:             .Visible   = .T.
361:         ENDWITH
362: 
363:         loc_oPagina.AddObject("txt_4c_CdEmpresa", "TextBox")
364:         WITH loc_oPagina.txt_4c_CdEmpresa
365:             .Top           = 48
366:             .Left          = 252
367:             .Width         = 31
368:             .Height        = 23
369:             .Value         = ""
370:             .FontName      = "Tahoma"
371:             .FontSize      = 8

*-- Linhas 380 a 389:
380: 
381:         loc_oPagina.AddObject("txt_4c_DsEmpresa", "TextBox")
382:         WITH loc_oPagina.txt_4c_DsEmpresa
383:             .Top           = 48
384:             .Left          = 285
385:             .Width         = 360
386:             .Height        = 23
387:             .Value         = ""
388:             .FontName      = "Tahoma"
389:             .FontSize      = 8

*-- Linhas 397 a 422:
397:         BINDEVENT(loc_oPagina.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")
398: 
399:         *-- Grupo Estoque (top_orig=164, left=210 -> page1 top=79)
400:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
401:         WITH loc_oPagina.lbl_4c_Grupo
402:             .Top       = 79
403:             .Left      = 210
404:             .Width     = 38
405:             .Height    = 15
406:             .Caption   = "Grupo :"
407:             .FontName  = "Tahoma"
408:             .FontSize  = 8
409:             .ForeColor = RGB(90, 90, 90)
410:             .BackStyle = 0
411:             .Visible   = .T.
412:         ENDWITH
413: 
414:         loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
415:         WITH loc_oPagina.txt_4c_CdGrEstoque
416:             .Top           = 75
417:             .Left          = 252
418:             .Width         = 79
419:             .Height        = 23
420:             .Value         = ""
421:             .FontName      = "Tahoma"
422:             .FontSize      = 8

*-- Linhas 431 a 440:
431: 
432:         loc_oPagina.AddObject("txt_4c_DsGrEstoque", "TextBox")
433:         WITH loc_oPagina.txt_4c_DsGrEstoque
434:             .Top           = 75
435:             .Left          = 333
436:             .Width         = 290
437:             .Height        = 23
438:             .Value         = ""
439:             .FontName      = "Tahoma"
440:             .FontSize      = 8

*-- Linhas 449 a 474:
449:         BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
450: 
451:         *-- Conta Estoque (top_orig=191, left=210 -> page1 top=106)
452:         loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
453:         WITH loc_oPagina.lbl_4c_Estoque
454:             .Top       = 106
455:             .Left      = 210
456:             .Width     = 38
457:             .Height    = 15
458:             .Caption   = "Conta :"
459:             .FontName  = "Tahoma"
460:             .FontSize  = 8
461:             .ForeColor = RGB(90, 90, 90)
462:             .BackStyle = 0
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
467:         WITH loc_oPagina.txt_4c_CdEstoque
468:             .Top           = 102
469:             .Left          = 252
470:             .Width         = 79
471:             .Height        = 23
472:             .Value         = ""
473:             .FontName      = "Tahoma"
474:             .FontSize      = 8

*-- Linhas 484 a 493:
484: 
485:         loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
486:         WITH loc_oPagina.txt_4c_DsEstoque
487:             .Top           = 102
488:             .Left          = 333
489:             .Width         = 290
490:             .Height        = 23
491:             .Value         = ""
492:             .FontName      = "Tahoma"
493:             .FontSize      = 8

*-- Linhas 502 a 527:
502:         BINDEVENT(loc_oPagina.txt_4c_DsEstoque, "KeyPress", THIS, "TeclaDsEstoque")
503: 
504:         *-- Moeda (top_orig=216, left=207 -> page1 top=131)
505:         loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
506:         WITH loc_oPagina.lbl_4c_Moeda
507:             .Top       = 131
508:             .Left      = 207
509:             .Width     = 42
510:             .Height    = 18
511:             .Caption   = "Moeda :"
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(90, 90, 90)
515:             .BackStyle = 0
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
520:         WITH loc_oPagina.txt_4c_CdMoeda
521:             .Top           = 128
522:             .Left          = 252
523:             .Width         = 31
524:             .Height        = 23
525:             .Value         = ""
526:             .FontName      = "Tahoma"
527:             .FontSize      = 8

*-- Linhas 536 a 545:
536: 
537:         loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
538:         WITH loc_oPagina.txt_4c_DsMoeda
539:             .Top           = 128
540:             .Left          = 285
541:             .Width         = 115
542:             .Height        = 23
543:             .Value         = ""
544:             .FontName      = "Tahoma"
545:             .FontSize      = 8

*-- Linhas 555 a 870:
555:         *-- Unifica (top_orig=214, left=401 -> page1 top=129)
556:         loc_oPagina.AddObject("opt_4c_Unifica", "OptionGroup")
557:         WITH loc_oPagina.opt_4c_Unifica
558:             .Top         = 129
559:             .Left        = 401
560:             .Width       = 134
561:             .Height      = 25
562:             .ButtonCount = 2
563:             .AutoSize    = .F.
564:             .BackStyle   = 0
565:             .BorderStyle = 0
566:             .Value       = 1
567:             .Visible     = .T.
568: 
569:             WITH .Buttons(1)
570:                 .Caption   = "Unificar"
571:                 .Top       = 5
572:                 .Left      = 5
573:                 .Width     = 54
574:                 .Height    = 15
575:                 .AutoSize  = .T.
576:                 .BackStyle = 0
577:                 .ForeColor = RGB(90, 90, 90)
578:             ENDWITH
579: 
580:             WITH .Buttons(2)
581:                 .Caption   = "Filtrar"
582:                 .Top       = 5
583:                 .Left      = 78
584:                 .Width     = 46
585:                 .Height    = 15
586:                 .AutoSize  = .T.
587:                 .BackStyle = 0
588:                 .FontName  = "Tahoma"
589:                 .FontSize  = 8
590:                 .ForeColor = RGB(90, 90, 90)
591:             ENDWITH
592:         ENDWITH
593: 
594:         *-- Tipo (top_orig=243, left=219 -> page1 top=158)
595:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
596:         WITH loc_oPagina.lbl_4c_Tipo
597:             .Top       = 158
598:             .Left      = 219
599:             .Width     = 25
600:             .Height    = 18
601:             .Caption   = "Tipo :"
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .ForeColor = RGB(90, 90, 90)
605:             .BackStyle = 0
606:             .Visible   = .T.
607:         ENDWITH
608: 
609:         loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
610:         WITH loc_oPagina.opt_4c_Tipo
611:             .Top         = 154
612:             .Left        = 247
613:             .Width       = 368
614:             .Height      = 27
615:             .ButtonCount = 4
616:             .AutoSize    = .T.
617:             .BackStyle   = 0
618:             .BorderStyle = 0
619:             .Value       = 1
620:             .Visible     = .T.
621: 
622:             WITH .Buttons(1)
623:                 .Caption   = "Anal" + CHR(237) + "tico"
624:                 .Top       = 5
625:                 .Left      = 5
626:                 .Width     = 58
627:                 .Height    = 15
628:                 .AutoSize  = .T.
629:                 .BackStyle = 0
630:                 .ForeColor = RGB(90, 90, 90)
631:             ENDWITH
632: 
633:             WITH .Buttons(2)
634:                 .Caption   = "Sint" + CHR(233) + "tico"
635:                 .Top       = 5
636:                 .Left      = 82
637:                 .Width     = 59
638:                 .Height    = 15
639:                 .AutoSize  = .T.
640:                 .BackStyle = 0
641:                 .FontName  = "Tahoma"
642:                 .FontSize  = 8
643:                 .ForeColor = RGB(90, 90, 90)
644:             ENDWITH
645: 
646:             WITH .Buttons(3)
647:                 .Caption   = "Resumido"
648:                 .Top       = 5
649:                 .Left      = 157
650:                 .Width     = 76
651:                 .Height    = 15
652:                 .AutoSize  = .T.
653:                 .BackStyle = 0
654:                 .FontName  = "Tahoma"
655:                 .FontSize  = 8
656:                 .ForeColor = RGB(90, 90, 90)
657:             ENDWITH
658: 
659:             WITH .Buttons(4)
660:                 .Caption   = "Anal" + CHR(237) + "tico por parcelas"
661:                 .Top       = 7
662:                 .Left      = 243
663:                 .Width     = 120
664:                 .Height    = 15
665:                 .AutoSize  = .T.
666:                 .BackStyle = 0
667:                 .FontName  = "Tahoma"
668:                 .FontSize  = 8
669:                 .ForeColor = RGB(90, 90, 90)
670:             ENDWITH
671:         ENDWITH
672: 
673:         *-- Selecao / Quebras (top_orig=265, left=202 -> page1 top=180)
674:         loc_oPagina.AddObject("lbl_4c_Selecao", "Label")
675:         WITH loc_oPagina.lbl_4c_Selecao
676:             .Top       = 180
677:             .Left      = 202
678:             .Width     = 43
679:             .Height    = 18
680:             .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
681:             .FontName  = "Tahoma"
682:             .FontSize  = 8
683:             .ForeColor = RGB(90, 90, 90)
684:             .BackStyle = 0
685:             .Visible   = .T.
686:         ENDWITH
687: 
688:         loc_oPagina.AddObject("opt_4c_Quebras", "OptionGroup")
689:         WITH loc_oPagina.opt_4c_Quebras
690:             .Top         = 176
691:             .Left        = 247
692:             .Width       = 231
693:             .Height      = 25
694:             .ButtonCount = 3
695:             .AutoSize    = .T.
696:             .BackStyle   = 0
697:             .BorderStyle = 0
698:             .Value       = 1
699:             .Visible     = .T.
700: 
701:             WITH .Buttons(1)
702:                 .Caption   = "Todos"
703:                 .Top       = 5
704:                 .Left      = 5
705:                 .Width     = 47
706:                 .Height    = 15
707:                 .AutoSize  = .T.
708:                 .BackStyle = 0
709:                 .ForeColor = RGB(90, 90, 90)
710:             ENDWITH
711: 
712:             WITH .Buttons(2)
713:                 .Caption   = "Pagos"
714:                 .Top       = 5
715:                 .Left      = 82
716:                 .Width     = 47
717:                 .Height    = 15
718:                 .AutoSize  = .T.
719:                 .BackStyle = 0
720:                 .FontName  = "Tahoma"
721:                 .FontSize  = 8
722:                 .ForeColor = RGB(90, 90, 90)
723:             ENDWITH
724: 
725:             WITH .Buttons(3)
726:                 .Caption   = "N" + CHR(227) + "o Pagos"
727:                 .Top       = 5
728:                 .Left      = 157
729:                 .Width     = 69
730:                 .Height    = 15
731:                 .AutoSize  = .T.
732:                 .BackStyle = 0
733:                 .FontName  = "Tahoma"
734:                 .FontSize  = 8
735:                 .ForeColor = RGB(90, 90, 90)
736:             ENDWITH
737:         ENDWITH
738: 
739:         *-- Movimento (top_orig=287, left=187 -> page1 top=202)
740:         loc_oPagina.AddObject("lbl_4c_Movimento", "Label")
741:         WITH loc_oPagina.lbl_4c_Movimento
742:             .Top       = 202
743:             .Left      = 187
744:             .Width     = 57
745:             .Height    = 18
746:             .Caption   = "Movimento :"
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .ForeColor = RGB(90, 90, 90)
750:             .BackStyle = 0
751:             .Visible   = .T.
752:         ENDWITH
753: 
754:         loc_oPagina.AddObject("opt_4c_Movs", "OptionGroup")
755:         WITH loc_oPagina.opt_4c_Movs
756:             .Top         = 198
757:             .Left        = 247
758:             .Width       = 211
759:             .Height      = 25
760:             .ButtonCount = 3
761:             .AutoSize    = .T.
762:             .BackStyle   = 0
763:             .BorderStyle = 0
764:             .Value       = 1
765:             .Visible     = .T.
766: 
767:             WITH .Buttons(1)
768:                 .Caption   = "Ambas"
769:                 .Top       = 5
770:                 .Left      = 5
771:                 .Width     = 50
772:                 .Height    = 15
773:                 .AutoSize  = .T.
774:                 .BackStyle = 0
775:                 .ForeColor = RGB(90, 90, 90)
776:             ENDWITH
777: 
778:             WITH .Buttons(2)
779:                 .Caption   = "Entradas"
780:                 .Top       = 5
781:                 .Left      = 82
782:                 .Width     = 61
783:                 .Height    = 15
784:                 .AutoSize  = .T.
785:                 .BackStyle = 0
786:                 .FontName  = "Tahoma"
787:                 .FontSize  = 8
788:                 .ForeColor = RGB(90, 90, 90)
789:             ENDWITH
790: 
791:             WITH .Buttons(3)
792:                 .Caption   = "Sa" + CHR(237) + "das"
793:                 .Top       = 5
794:                 .Left      = 157
795:                 .Width     = 49
796:                 .Height    = 15
797:                 .AutoSize  = .T.
798:                 .BackStyle = 0
799:                 .FontName  = "Tahoma"
800:                 .FontSize  = 8
801:                 .ForeColor = RGB(90, 90, 90)
802:             ENDWITH
803:         ENDWITH
804: 
805:         *-- % Comissao (top_orig=312, left=397 -> page1 top=227)
806:         loc_oPagina.AddObject("chk_4c_PComis", "CheckBox")
807:         WITH loc_oPagina.chk_4c_PComis
808:             .Top       = 227
809:             .Left      = 397
810:             .Width     = 77
811:             .Height    = 15
812:             .Caption   = "% Comiss" + CHR(227) + "o"
813:             .Value     = 1
814:             .FontName  = "Tahoma"
815:             .FontSize  = 8
816:             .AutoSize  = .T.
817:             .Alignment = 0
818:             .BackStyle = 0
819:             .ForeColor = RGB(90, 90, 90)
820:             .Visible   = .T.
821:         ENDWITH
822: 
823:         *-- Saldo (top_orig=333, left=213 -> page1 top=248)
824:         loc_oPagina.AddObject("lbl_4c_Saldo", "Label")
825:         WITH loc_oPagina.lbl_4c_Saldo
826:             .Top       = 248
827:             .Left      = 213
828:             .Width     = 35
829:             .Height    = 15
830:             .Caption   = "Saldo :"
831:             .FontName  = "Tahoma"
832:             .FontSize  = 8
833:             .ForeColor = RGB(90, 90, 90)
834:             .BackStyle = 0
835:             .Visible   = .T.
836:         ENDWITH
837: 
838:         loc_oPagina.AddObject("opt_4c_Saldo", "OptionGroup")
839:         WITH loc_oPagina.opt_4c_Saldo
840:             .Top         = 244
841:             .Left        = 247
842:             .Width       = 117
843:             .Height      = 25
844:             .ButtonCount = 2
845:             .AutoSize    = .T.
846:             .BackStyle   = 0
847:             .BorderStyle = 0
848:             .Value       = 2
849:             .Visible     = .T.
850: 
851:             WITH .Buttons(1)
852:                 .Caption   = "Sim"
853:                 .Top       = 5
854:                 .Left      = 5
855:                 .Width     = 34
856:                 .Height    = 15
857:                 .AutoSize  = .T.
858:                 .BackStyle = 0
859:                 .ForeColor = RGB(90, 90, 90)
860:             ENDWITH
861: 
862:             WITH .Buttons(2)
863:                 .Caption   = "N" + CHR(227) + "o"
864:                 .Top       = 5
865:                 .Left      = 75
866:                 .Width     = 37
867:                 .Height    = 15
868:                 .AutoSize  = .T.
869:                 .BackStyle = 0
870:                 .FontName  = "Tahoma"

*-- Linhas 1508 a 1538:
1508:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
1509:                 WITH THIS.this_oRelatorio
1510:                     IF !EMPTY(.this_dDtInicial)
1511:                         loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
1512:                     ENDIF
1513:                     IF !EMPTY(.this_dDtFinal)
1514:                         loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
1515:                     ENDIF
1516:                     loc_oPg.txt_4c_CdEmpresa.Value   = .this_cCdEmpresa
1517:                     loc_oPg.txt_4c_DsEmpresa.Value   = .this_cDsEmpresa
1518:                     loc_oPg.txt_4c_CdGrEstoque.Value = .this_cCdGrEstoque
1519:                     loc_oPg.txt_4c_DsGrEstoque.Value = .this_cDsGrEstoque
1520:                     loc_oPg.txt_4c_CdEstoque.Value   = .this_cCdEstoque
1521:                     loc_oPg.txt_4c_DsEstoque.Value   = .this_cDsEstoque
1522:                     IF !EMPTY(.this_cCdMoeda)
1523:                         loc_oPg.txt_4c_CdMoeda.Value = .this_cCdMoeda
1524:                     ENDIF
1525:                     IF !EMPTY(.this_cDsMoeda)
1526:                         loc_oPg.txt_4c_DsMoeda.Value = .this_cDsMoeda
1527:                     ENDIF
1528:                     loc_oPg.opt_4c_Unifica.Value  = .this_nUnifica
1529:                     loc_oPg.opt_4c_Tipo.Value      = .this_nTipo
1530:                     loc_oPg.opt_4c_Quebras.Value   = .this_nQuebras
1531:                     loc_oPg.opt_4c_Movs.Value      = .this_nMovs
1532:                     loc_oPg.opt_4c_Saldo.Value     = .this_nSaldo
1533:                     loc_oPg.chk_4c_PComis.Value    = .this_nPComis
1534:                 ENDWITH
1535:             ENDIF
1536:         CATCH TO loc_oErro
1537:             MsgErro(loc_oErro.Message, "BOParaForm")
1538:         ENDTRY

