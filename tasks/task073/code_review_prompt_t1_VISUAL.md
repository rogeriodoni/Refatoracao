# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 202: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 223: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECTP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1609 linhas total):

*-- Linhas 54 a 62:
54:         loc_lSucesso   = .F.
55:         loc_lContinuar = .T.
56:         TRY
57:             THIS.Caption = "Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras"
58: 
59:             IF TYPE("gc_4c_CaminhoIcones") = "U"
60:                 gc_4c_CaminhoIcones = ""
61:             ENDIF
62:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 79 a 88:
79:                 *-- PageFrame com 1 p" + CHR(225) + "gina de filtros
80:                 THIS.ConfigurarPageFrame()
81: 
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
84: 
85:                 *-- Controles de filtro na Page1
86:                 THIS.ConfigurarPaginaLista()
87: 
88:                 *-- Vincular Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio

*-- Linhas 113 a 187:
113:     PROTECTED PROCEDURE ConfigurarCabecalho()
114:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH THIS.cnt_4c_Cabecalho
116:             .Top         = 0
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackStyle   = 1
121:             .BackColor   = RGB(100, 100, 100)
122:             .BorderWidth = 0
123:             .Visible     = .T.
124: 
125:             .AddObject("lbl_4c_Sombra", "Label")
126:             WITH .lbl_4c_Sombra
127:                 .Top       = 22
128:                 .Left      = 22
129:                 .Width     = THIS.Width
130:                 .Height    = 30
131:                 .Caption   = "Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras"
132:                 .FontName  = "Tahoma"
133:                 .FontSize  = 14
134:                 .FontBold  = .T.
135:                 .ForeColor = RGB(0, 0, 0)
136:                 .BackStyle = 0
137:                 .Visible   = .T.
138:             ENDWITH
139: 
140:             .AddObject("lbl_4c_Titulo", "Label")
141:             WITH .lbl_4c_Titulo
142:                 .Top       = 20
143:                 .Left      = 20
144:                 .Width     = THIS.Width
145:                 .Height    = 30
146:                 .Caption   = "Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras"
147:                 .FontName  = "Tahoma"
148:                 .FontSize  = 14
149:                 .FontBold  = .T.
150:                 .ForeColor = RGB(255, 255, 255)
151:                 .BackStyle = 0
152:                 .Visible   = .T.
153:             ENDWITH
154:         ENDWITH
155:     ENDPROC
156: 
157:     *--------------------------------------------------------------------------
158:     * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es de relat" + CHR(243) + "rio
159:     *   Original: btnReport.Top=-2, Left=495, Height=85, Width=310
160:     *   Framework: cmg_4c_Botoes.Top=0, Left=529, Width=273, Height=80
161:     *--------------------------------------------------------------------------
162:     PROTECTED PROCEDURE ConfigurarBotoes()
163:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
164:         WITH THIS.cmg_4c_Botoes
165:             .Top           = 0
166:             .Left          = 529
167:             .Width         = 273
168:             .Height        = 80
169:             .ButtonCount   = 4
170:             .BackStyle     = 0
171:             .BorderStyle   = 0
172:             .BorderColor   = RGB(136, 189, 188)
173:             .SpecialEffect = 1
174:             .Themes        = .F.
175:             .Visible       = .T.
176: 
177:             WITH .Buttons(1)
178:                 .Top             = 5
179:                 .Left            = 5
180:                 .Width           = 65
181:                 .Height          = 70
182:                 .Caption         = "Visualizar"
183:                 .FontBold        = .T.
184:                 .FontItalic      = .T.
185:                 .BackColor       = RGB(255, 255, 255)
186:                 .ForeColor       = RGB(90, 90, 90)
187:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 194 a 208:
194:             ENDWITH
195: 
196:             WITH .Buttons(2)
197:                 .Top             = 5
198:                 .Left            = 71
199:                 .Width           = 65
200:                 .Height          = 70
201:                 .Caption         = "Imprimir"
202:                 .FontName        = "Comic Sans MS"
203:                 .FontBold        = .T.
204:                 .FontItalic      = .T.
205:                 .FontSize        = 8
206:                 .BackColor       = RGB(255, 255, 255)
207:                 .ForeColor       = RGB(90, 90, 90)
208:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 215 a 229:
215:             ENDWITH
216: 
217:             WITH .Buttons(3)
218:                 .Top             = 5
219:                 .Left            = 137
220:                 .Width           = 65
221:                 .Height          = 70
222:                 .Caption         = "Excel"
223:                 .FontName        = "Comic Sans MS"
224:                 .FontBold        = .T.
225:                 .FontItalic      = .T.
226:                 .FontSize        = 8
227:                 .BackColor       = RGB(255, 255, 255)
228:                 .ForeColor       = RGB(90, 90, 90)
229:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 236 a 251:
236:             ENDWITH
237: 
238:             WITH .Buttons(4)
239:                 .Top             = 5
240:                 .Left            = 203
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .Caption         = "Encerrar"
244:                 .Cancel          = .T.
245:                 .FontName        = "Comic Sans MS"
246:                 .FontBold        = .T.
247:                 .FontItalic      = .T.
248:                 .FontSize        = 8
249:                 .BackColor       = RGB(255, 255, 255)
250:                 .ForeColor       = RGB(90, 90, 90)
251:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 271 a 285:
271: 
272:         loc_oPgf.PageCount = 1
273: 
274:         loc_oPgf.Top    = 85
275:         loc_oPgf.Left   = -1
276:         loc_oPgf.Width  = THIS.Width + 2
277:         loc_oPgf.Height = THIS.Height - 85
278:         loc_oPgf.Tabs   = .F.
279: 
280:         loc_oPgf.Page1.Caption   = "Filtros"
281:         loc_oPgf.Page1.FontName  = "Tahoma"
282:         loc_oPgf.Page1.FontSize  = 8
283:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
284:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
285:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 291 a 386:
291:     *--------------------------------------------------------------------------
292:     * ConfigurarPaginaLista - Adiciona controles de filtro na Page1
293:     *   Posi" + CHR(231) + CHR(245) + "es originais SIGRECTP (800x230px) menos offset PageFrame (85px):
294:     *     Linha 1 (Cota" + CHR(231) + CHR(227) + "o + Comprador): top_original=94 -> page.top=9
295:     *     Linha 2 (Validade + Aprovador): top_original=119 -> page.top=34
296:     *     Linha 3 (Produto):   top_original=144 -> page.top=59
297:     *     Linha 4 (Fornecedor): top_original=169 -> page.top=84
298:     *--------------------------------------------------------------------------
299:     PROTECTED PROCEDURE ConfigurarPaginaLista()
300:         LOCAL loc_oPg
301:         loc_oPg = THIS.pgf_4c_Paginas.Page1
302: 
303:         *-- Linha 1: Cota" + CHR(231) + CHR(227) + "o (per" + CHR(237) + "odo obrigat" + CHR(243) + "rio) + Comprador
304:         loc_oPg.AddObject("lbl_4c_Cotacao", "Label")
305:         WITH loc_oPg.lbl_4c_Cotacao
306:             .Top       = 12
307:             .Left      = 195
308:             .Width     = 47
309:             .Height    = 15
310:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
311:             .FontName  = "Tahoma"
312:             .FontSize  = 8
313:             .ForeColor = RGB(90, 90, 90)
314:             .BackStyle = 0
315:             .Visible   = .T.
316:         ENDWITH
317: 
318:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
319:         WITH loc_oPg.txt_4c_DtInicial
320:             .Top         = 9
321:             .Left        = 246
322:             .Width       = 80
323:             .Height      = 23
324:             .Value       = {}
325:             .Format      = "D"
326:             .FontName    = "Tahoma"
327:             .FontSize    = 8
328:             .BackColor   = RGB(255, 255, 255)
329:             .ForeColor   = RGB(0, 0, 0)
330:             .BorderStyle = 1
331:             .Visible     = .T.
332:         ENDWITH
333: 
334:         loc_oPg.AddObject("lbl_4c_Sep1", "Label")
335:         WITH loc_oPg.lbl_4c_Sep1
336:             .Top       = 12
337:             .Left      = 332
338:             .Width     = 9
339:             .Height    = 15
340:             .Caption   = "a"
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .ForeColor = RGB(90, 90, 90)
344:             .BackStyle = 0
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
349:         WITH loc_oPg.txt_4c_DtFinal
350:             .Top         = 9
351:             .Left        = 343
352:             .Width       = 80
353:             .Height      = 23
354:             .Value       = {}
355:             .Format      = "D"
356:             .FontName    = "Tahoma"
357:             .FontSize    = 8
358:             .BackColor   = RGB(255, 255, 255)
359:             .ForeColor   = RGB(0, 0, 0)
360:             .BorderStyle = 1
361:             .Visible     = .T.
362:         ENDWITH
363: 
364:         loc_oPg.AddObject("lbl_4c_Comprador", "Label")
365:         WITH loc_oPg.lbl_4c_Comprador
366:             .Top       = 12
367:             .Left      = 474
368:             .Width     = 62
369:             .Height    = 15
370:             .Caption   = "Comprador :"
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8
373:             .ForeColor = RGB(90, 90, 90)
374:             .BackStyle = 0
375:             .Visible   = .T.
376:         ENDWITH
377: 
378:         loc_oPg.AddObject("txt_4c_Comprador", "TextBox")
379:         WITH loc_oPg.txt_4c_Comprador
380:             .Top         = 9
381:             .Left        = 538
382:             .Width       = 80
383:             .Height      = 23
384:             .Value       = ""
385:             .MaxLength   = 10
386:             .Format      = "K"

*-- Linhas 393 a 478:
393:         ENDWITH
394: 
395:         *-- Linha 2: Validade (per" + CHR(237) + "odo opcional) + Aprovador
396:         loc_oPg.AddObject("lbl_4c_Validade", "Label")
397:         WITH loc_oPg.lbl_4c_Validade
398:             .Top       = 37
399:             .Left      = 195
400:             .Width     = 56
401:             .Height    = 15
402:             .Caption   = "Validade :"
403:             .FontName  = "Tahoma"
404:             .FontSize  = 8
405:             .ForeColor = RGB(90, 90, 90)
406:             .BackStyle = 0
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         loc_oPg.AddObject("txt_4c_DtValidIs", "TextBox")
411:         WITH loc_oPg.txt_4c_DtValidIs
412:             .Top         = 34
413:             .Left        = 246
414:             .Width       = 80
415:             .Height      = 23
416:             .Value       = {}
417:             .Format      = "D"
418:             .FontName    = "Tahoma"
419:             .FontSize    = 8
420:             .BackColor   = RGB(255, 255, 255)
421:             .ForeColor   = RGB(0, 0, 0)
422:             .BorderStyle = 1
423:             .Visible     = .T.
424:         ENDWITH
425: 
426:         loc_oPg.AddObject("lbl_4c_Sep2", "Label")
427:         WITH loc_oPg.lbl_4c_Sep2
428:             .Top       = 37
429:             .Left      = 332
430:             .Width     = 9
431:             .Height    = 15
432:             .Caption   = "a"
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .ForeColor = RGB(90, 90, 90)
436:             .BackStyle = 0
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         loc_oPg.AddObject("txt_4c_DtValidFs", "TextBox")
441:         WITH loc_oPg.txt_4c_DtValidFs
442:             .Top         = 34
443:             .Left        = 343
444:             .Width       = 80
445:             .Height      = 23
446:             .Value       = {}
447:             .Format      = "D"
448:             .FontName    = "Tahoma"
449:             .FontSize    = 8
450:             .BackColor   = RGB(255, 255, 255)
451:             .ForeColor   = RGB(0, 0, 0)
452:             .BorderStyle = 1
453:             .Visible     = .T.
454:         ENDWITH
455: 
456:         loc_oPg.AddObject("lbl_4c_Aprovador", "Label")
457:         WITH loc_oPg.lbl_4c_Aprovador
458:             .Top       = 37
459:             .Left      = 476
460:             .Width     = 60
461:             .Height    = 15
462:             .Caption   = "Aprovador :"
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .ForeColor = RGB(90, 90, 90)
466:             .BackStyle = 0
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         loc_oPg.AddObject("txt_4c_Aprovador", "TextBox")
471:         WITH loc_oPg.txt_4c_Aprovador
472:             .Top         = 34
473:             .Left        = 538
474:             .Width       = 80
475:             .Height      = 23
476:             .Value       = ""
477:             .MaxLength   = 10
478:             .Format      = "K"

*-- Linhas 485 a 510:
485:         ENDWITH
486: 
487:         *-- Linha 3: Produto (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
488:         loc_oPg.AddObject("lbl_4c_Produto", "Label")
489:         WITH loc_oPg.lbl_4c_Produto
490:             .Top       = 62
491:             .Left      = 197
492:             .Width     = 47
493:             .Height    = 15
494:             .Caption   = "Produto :"
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .ForeColor = RGB(90, 90, 90)
498:             .BackStyle = 0
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         loc_oPg.AddObject("txt_4c_CPros", "TextBox")
503:         WITH loc_oPg.txt_4c_CPros
504:             .Top         = 59
505:             .Left        = 246
506:             .Width       = 108
507:             .Height      = 23
508:             .Value       = ""
509:             .MaxLength   = 14
510:             .Format      = "K"

*-- Linhas 518 a 527:
518: 
519:         loc_oPg.AddObject("txt_4c_DPros", "TextBox")
520:         WITH loc_oPg.txt_4c_DPros
521:             .Top         = 59
522:             .Left        = 356
523:             .Width       = 262
524:             .Height      = 23
525:             .Value       = ""
526:             .MaxLength   = 40
527:             .Format      = "K"

*-- Linhas 534 a 559:
534:         ENDWITH
535: 
536:         *-- Linha 4: Fornecedor (c" + CHR(243) + "digo + nome)
537:         loc_oPg.AddObject("lbl_4c_Fornecedor", "Label")
538:         WITH loc_oPg.lbl_4c_Fornecedor
539:             .Top       = 87
540:             .Left      = 180
541:             .Width     = 64
542:             .Height    = 15
543:             .Caption   = "Fornecedor :"
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .ForeColor = RGB(90, 90, 90)
547:             .BackStyle = 0
548:             .Visible   = .T.
549:         ENDWITH
550: 
551:         loc_oPg.AddObject("txt_4c_IClis", "TextBox")
552:         WITH loc_oPg.txt_4c_IClis
553:             .Top         = 84
554:             .Left        = 246
555:             .Width       = 80
556:             .Height      = 23
557:             .Value       = ""
558:             .MaxLength   = 10
559:             .Format      = "K"

*-- Linhas 567 a 576:
567: 
568:         loc_oPg.AddObject("txt_4c_RClis", "TextBox")
569:         WITH loc_oPg.txt_4c_RClis
570:             .Top         = 84
571:             .Left        = 328
572:             .Width       = 290
573:             .Height      = 23
574:             .Value       = ""
575:             .MaxLength   = 40
576:             .Format      = "K"

*-- Linhas 588 a 722:
588: 
589:     *--------------------------------------------------------------------------
590:     * ConfigurarPaginaDados - Adiciona OptionGroups e vincula todos os BINDEVENTs
591:     *   Linha 5: Pedidos + Aprovados (top_original=195 -> page.top=110)
592:     *   Todos os handlers de teclado e DblClick tamb" + CHR(233) + "m s" + CHR(227) + "o vinculados aqui.
593:     *--------------------------------------------------------------------------
594:     PROTECTED PROCEDURE ConfigurarPaginaDados()
595:         LOCAL loc_oPg
596:         loc_oPg = THIS.pgf_4c_Paginas.Page1
597: 
598:         *-- Label "Pedidos :"
599:         loc_oPg.AddObject("lbl_4c_Pedidos", "Label")
600:         WITH loc_oPg.lbl_4c_Pedidos
601:             .Top       = 114
602:             .Left      = 198
603:             .Width     = 46
604:             .Height    = 15
605:             .Caption   = "Pedidos :"
606:             .FontName  = "Tahoma"
607:             .FontSize  = 8
608:             .ForeColor = RGB(90, 90, 90)
609:             .BackStyle = 0
610:             .Visible   = .T.
611:         ENDWITH
612: 
613:         *-- OptionGroup Pedidos (Sim/N" + CHR(227) + "o/Ambos) - ButtonCount ANTES de Buttons(N)
614:         loc_oPg.AddObject("opt_4c_Pedidos", "OptionGroup")
615:         loc_oPg.opt_4c_Pedidos.ButtonCount = 3
616:         WITH loc_oPg.opt_4c_Pedidos
617:             .Top         = 110
618:             .Left        = 239
619:             .Width       = 156
620:             .Height      = 24
621:             .BackStyle   = 0
622:             .BorderStyle = 0
623:             .Visible     = .T.
624:         ENDWITH
625:         WITH loc_oPg.opt_4c_Pedidos.Buttons(1)
626:             .Caption   = "Sim"
627:             .Left      = 5
628:             .Top       = 4
629:             .Width     = 34
630:             .Height    = 15
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .BackStyle = 0
634:             .AutoSize  = .T.
635:             .ForeColor = RGB(90, 90, 90)
636:         ENDWITH
637:         WITH loc_oPg.opt_4c_Pedidos.Buttons(2)
638:             .Caption   = "N" + CHR(227) + "o"
639:             .Left      = 50
640:             .Top       = 4
641:             .Width     = 37
642:             .Height    = 15
643:             .FontName  = "Tahoma"
644:             .FontSize  = 8
645:             .BackStyle = 0
646:             .AutoSize  = .T.
647:             .ForeColor = RGB(90, 90, 90)
648:         ENDWITH
649:         WITH loc_oPg.opt_4c_Pedidos.Buttons(3)
650:             .Caption   = "Ambos"
651:             .Left      = 96
652:             .Top       = 4
653:             .Width     = 50
654:             .Height    = 15
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .BackStyle = 0
658:             .AutoSize  = .T.
659:             .ForeColor = RGB(90, 90, 90)
660:         ENDWITH
661:         loc_oPg.opt_4c_Pedidos.Value = 3
662: 
663:         *-- Label "Aprova" + CHR(231) + CHR(227) + "o :"
664:         loc_oPg.AddObject("lbl_4c_Aprovacao", "Label")
665:         WITH loc_oPg.lbl_4c_Aprovacao
666:             .Top       = 115
667:             .Left      = 416
668:             .Width     = 61
669:             .Height    = 15
670:             .Caption   = "Aprova" + CHR(231) + CHR(227) + "o :"
671:             .FontName  = "Tahoma"
672:             .FontSize  = 8
673:             .ForeColor = RGB(90, 90, 90)
674:             .BackStyle = 0
675:             .Visible   = .T.
676:         ENDWITH
677: 
678:         *-- OptionGroup Aprovados (Sim/N" + CHR(227) + "o/Ambos)
679:         loc_oPg.AddObject("opt_4c_Aprovados", "OptionGroup")
680:         loc_oPg.opt_4c_Aprovados.ButtonCount = 3
681:         WITH loc_oPg.opt_4c_Aprovados
682:             .Top         = 110
683:             .Left        = 474
684:             .Width       = 149
685:             .Height      = 24
686:             .BackStyle   = 0
687:             .BorderStyle = 0
688:             .Visible     = .T.
689:         ENDWITH
690:         WITH loc_oPg.opt_4c_Aprovados.Buttons(1)
691:             .Caption   = "Sim"
692:             .Left      = 5
693:             .Top       = 4
694:             .Width     = 34
695:             .Height    = 15
696:             .FontName  = "Tahoma"
697:             .FontSize  = 8
698:             .BackStyle = 0
699:             .AutoSize  = .T.
700:             .ForeColor = RGB(90, 90, 90)
701:         ENDWITH
702:         WITH loc_oPg.opt_4c_Aprovados.Buttons(2)
703:             .Caption   = "N" + CHR(227) + "o"
704:             .Left      = 46
705:             .Top       = 4
706:             .Width     = 37
707:             .Height    = 15
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .BackStyle = 0
711:             .AutoSize  = .T.
712:             .ForeColor = RGB(90, 90, 90)
713:         ENDWITH
714:         WITH loc_oPg.opt_4c_Aprovados.Buttons(3)
715:             .Caption   = "Ambos"
716:             .Left      = 89
717:             .Top       = 4
718:             .Width     = 50
719:             .Height    = 15
720:             .FontName  = "Tahoma"
721:             .FontSize  = 8
722:             .BackStyle = 0

*-- Linhas 1493 a 1512:
1493:             ENDIF
1494:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1495:             WITH THIS.this_oRelatorio
1496:                 loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
1497:                 loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
1498:                 loc_oPg.txt_4c_DtValidIs.Value  = .this_dDtValidIs
1499:                 loc_oPg.txt_4c_DtValidFs.Value  = .this_dDtValidFs
1500:                 loc_oPg.txt_4c_Comprador.Value  = .this_cComprador
1501:                 loc_oPg.txt_4c_Aprovador.Value  = .this_cAprovador
1502:                 loc_oPg.txt_4c_CPros.Value      = .this_cCPros
1503:                 loc_oPg.txt_4c_DPros.Value      = .this_cDPros
1504:                 loc_oPg.txt_4c_IClis.Value      = .this_cIClis
1505:                 loc_oPg.txt_4c_RClis.Value      = .this_cRClis
1506:                 loc_oPg.opt_4c_Pedidos.Value    = .this_nPedidos
1507:                 loc_oPg.opt_4c_Aprovados.Value  = .this_nAprovados
1508:             ENDWITH
1509:             THIS.AtualizarEstadoCamposDescricao()
1510:         CATCH TO loc_oErro
1511:             MsgErro(loc_oErro.Message, "Erro")
1512:         ENDTRY


### BO (C:\4c\projeto\app\classes\SIGRECTPBO.prg):
*==============================================================================
* SIGRECTPBO.PRG
* Business Object para Relatorio de Cotacao de Compras
* Herda de RelatorioBase
* Formulario original: SIGRECTP (sigrectp.SCX)
*
* Tabelas: SigCtTdc (cabecalho), SigCtTct (itens), SigCtTfn (fornecedores),
*           SigCtTps (pedidos gerados), sigcdusu (usuarios)
*==============================================================================

DEFINE CLASS SIGRECTPBO AS RelatorioBase

    *-- Arquivo e titulo do relatorio
    this_cArquivoRelatorio  = ""
    this_cTituloRelatorio   = ""

    *-- Cursor de saida do relatorio
    this_cCursorDados       = "cursor_4c_ReCtp"

    *-- Filtros de periodo de cotacao (obrigatorios)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de periodo de validade (opcionais)
    this_dDtValidIs         = {}
    this_dDtValidFs         = {}

    *-- Filtro de comprador (sigcdusu.Usuarios, MaxLen 10)
    this_cComprador         = ""

    *-- Filtro de aprovador (sigcdusu.Usuarios, MaxLen 10)
    this_cAprovador         = ""

    *-- Filtro de produto: codigo (SigCtTct.cpros, MaxLen 14) e descricao (SigCtTct.dpros)
    this_cCPros             = ""
    this_cDPros             = ""

    *-- Filtro de fornecedor: codigo (SigCtTfn.iclis, MaxLen 10) e nome (SigCdCli.rclis)
    this_cIClis             = ""
    this_cRClis             = ""

    *-- Filtro pedidos: 1=Sim (tem pedido gerado), 2=Nao, 3=Ambos (default 3)
    this_nPedidos           = 3

    *-- Filtro aprovados: 1=Sim (chkaprovs=1), 2=Nao (chkaprovs=0), 3=Ambos (default 3)
    this_nAprovados         = 3

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de cotacao de compras
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "relsigrectp.frx"
            THIS.this_cTituloRelatorio  = "Relat" + CHR(243) + "rio de Cota" + ;
                                          CHR(231) + CHR(227) + "o de Compras"
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de preparar dados.
    * Equivalente a loNegocios.ValidaBotoes(loObj) do legado.
    * Retorna "": filtros validos
    * Retorna "DataInicial": data inicial vazia ou invalida
    * Retorna "DataFinal":   data final vazia ou invalida
    * Retorna "Periodo":     data final < data inicial (cotacao)
    * Retorna "PeriodoV":    data validade final < data validade inicial
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial)
            RETURN "DataInicial"
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            RETURN "DataFinal"
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            RETURN "Periodo"
        ENDIF
        IF !EMPTY(THIS.this_dDtValidIs) AND !EMPTY(THIS.this_dDtValidFs)
            IF THIS.this_dDtValidFs < THIS.this_dDtValidIs
                RETURN "PeriodoV"
            ENDIF
        ENDIF
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor cursor_4c_ReCtp com dados de cotacoes de
    * compras conforme filtros definidos nas propriedades this_*.
    * Equivalente ao PROCEDURE processamento do legado SIGRECTP.
    * Tambem cria cursor CsCabecalho para cabecalho do relatorio FRX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_cWhere, loc_cJoin, loc_nResult
        LOCAL loc_cDtIniSQL, loc_cDtFimSQL
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            *-- Fechar cursor anterior se aberto
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Formatar datas para SQL Server (datetime)
            loc_cDtIniSQL = "'" + ;
                PADL(YEAR(THIS.this_dDtInicial),  4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDtInicial), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDtInicial),   2, "0") + " 00:00:00'"
            loc_cDtFimSQL = "'" + ;
                PADL(YEAR(THIS.this_dDtFinal),  4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDtFinal), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDtFinal),   2, "0") + " 23:59:59'"

            *-- Clausula WHERE base: periodo de cotacao (obrigatorio)
            loc_cWhere = "dc.dtcotas >= " + loc_cDtIniSQL + ;
                         " AND dc.dtcotas <= " + loc_cDtFimSQL

            *-- Filtro periodo de validade (opcional - apenas se ambas preenchidas)
            IF !EMPTY(THIS.this_dDtValidIs)
                loc_cWhere = loc_cWhere + ;
                    " AND dc.dtvalids >= '" + ;
                    PADL(YEAR(THIS.this_dDtValidIs),  4, "0") + "-" + ;
                    PADL(MONTH(THIS.this_dDtValidIs), 2, "0") + "-" + ;
                    PADL(DAY(THIS.this_dDtValidIs),   2, "0") + " 00:00:00'"
            ENDIF
            IF !EMPTY(THIS.this_dDtValidFs)
                loc_cWhere = loc_cWhere + ;
                    " AND dc.dtvalids <= '" + ;
                    PADL(YEAR(THIS.this_dDtValidFs),  4, "0") + "-" + ;
                    PADL(MONTH(THIS.this_dDtValidFs), 2, "0") + "-" + ;
                    PADL(DAY(THIS.this_dDtValidFs),   2, "0") + " 23:59:59'"
            ENDIF

            *-- Filtro comprador
            IF !EMPTY(ALLTRIM(THIS.this_cComprador))
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(dc.comprador) = " + EscaparSQL(ALLTRIM(THIS.this_cComprador))
            ENDIF

            *-- Filtro aprovador
            IF !EMPTY(ALLTRIM(THIS.this_cAprovador))
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(dc.aprovador) = " + EscaparSQL(ALLTRIM(THIS.this_cAprovador))
            ENDIF

            *-- Filtro aprovados (chkaprovs: 0=nao aprovado, 1=aprovado)
            IF THIS.this_nAprovados = 1
                loc_cWhere = loc_cWhere + " AND dc.chkaprovs = 1"
            ENDIF
            IF THIS.this_nAprovados = 2
                loc_cWhere = loc_cWhere + " AND dc.chkaprovs = 0"
            ENDIF

            *-- Filtro pedidos via EXISTS em SigCtTps
            IF THIS.this_nPedidos = 1
                loc_cWhere = loc_cWhere + ;
                    " AND EXISTS (SELECT 1 FROM SigCtTps ps" + ;
                    " WHERE ps.codigos = dc.codigos)"
            ENDIF
            IF THIS.this_nPedidos = 2
                loc_cWhere = loc_cWhere + ;
                    " AND NOT EXISTS (SELECT 1 FROM SigCtTps ps" + ;
                    " WHERE ps.codigos = dc.codigos)"
            ENDIF

            *-- JOINs adicionais para filtros de produto e fornecedor
            loc_cJoin = ""

            IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                loc_cJoin  = loc_cJoin + ;
                    " INNER JOIN SigCtTct ct ON ct.codigos = dc.codigos"
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(ct.cpros) = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cIClis))
                loc_cJoin  = loc_cJoin + ;
                    " INNER JOIN SigCtTfn fn ON fn.codigos = dc.codigos"
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(fn.iclis) = " + EscaparSQL(ALLTRIM(THIS.this_cIClis))
            ENDIF

            *-- SELECT principal: cabecalho da cotacao com nomes dos usuarios
            loc_cSQL = "SELECT DISTINCT" + ;
                " dc.codigos, dc.dtcotas, dc.dtvalids, dc.dtsolics," + ;
                " dc.dtpagtos, dc.dtaprovs," + ;
                " RTRIM(dc.comprador) AS comprador," + ;
                " RTRIM(dc.aprovador) AS aprovador," + ;
                " RTRIM(dc.solicitas) AS solicitas," + ;
                " RTRIM(dc.aprsols)   AS aprsols," + ;
                " dc.situas, dc.prioris," + ;
                " dc.chkaprovs, dc.localents, dc.copias," + ;
                " RTRIM(dc.deptos)   AS deptos," + ;
                " RTRIM(dc.contaes)  AS contaes," + ;
                " ISNULL(RTRIM(u1.ncomps), '') AS ncomp_comprador," + ;
                " ISNULL(RTRIM(u2.ncomps), '') AS ncomp_aprovador" + ;
                " FROM SigCtTdc dc" + ;
                " LEFT JOIN sigcdusu u1 ON RTRIM(u1.usuarios) = RTRIM(dc.comprador)" + ;
                " LEFT JOIN sigcdusu u2 ON RTRIM(u2.usuarios) = RTRIM(dc.aprovador)" + ;
                loc_cJoin + ;
                " WHERE " + loc_cWhere + ;
                " ORDER BY dc.codigos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de cota" + ;
                    CHR(231) + CHR(227) + "o de compras"
                loc_lSucesso = .F.
            ELSE
                *-- Cursor de cabecalho para o FRX
                loc_cEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)
                loc_cTitulo  = THIS.this_cTituloRelatorio
                loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                    DTOC(THIS.this_dDtInicial) + " " + CHR(150) + " " + DTOC(THIS.this_dDtFinal)

                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                CREATE CURSOR CsCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
                INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                    VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

                SELECT (THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave descritiva para auditoria (periodo+filtros)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTituloRelatorio)
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_dDtFinal)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cComprador))
            loc_cChave = loc_cChave + "|comp:" + ALLTRIM(THIS.this_cComprador)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cIClis))
            loc_cChave = loc_cChave + "|forn:" + ALLTRIM(THIS.this_cIClis)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cOperacao
        loc_lSucesso = .F.
        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
                            par_cOperacao, "VISUALIZAR")
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Operacao, Tabela, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cOperacao) + "," + ;
                EscaparSQL("RELATORIO_COTACAO_COMPRAS") + "," + ;
                EscaparSQL(THIS.ObterChavePrimaria()) + "," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(ALLTRIM(THIS.this_cTituloRelatorio)) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar auditoria"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de parametros salvos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) ;
               OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(par_cAliasCursor)
                loc_lSucesso = .F.
            ELSE
                loc_cAlias = ALLTRIM(par_cAliasCursor)
                SELECT (loc_cAlias)
                IF !EOF()
                    IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                        THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_final") = "D"
                        THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".dt_final")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_valid_i") = "D"
                        THIS.this_dDtValidIs = EVALUATE(loc_cAlias + ".dt_valid_i")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_valid_f") = "D"
                        THIS.this_dDtValidFs = EVALUATE(loc_cAlias + ".dt_valid_f")
                    ENDIF
                    IF TYPE(loc_cAlias + ".comprador") = "C"
                        THIS.this_cComprador = ALLTRIM(EVALUATE(loc_cAlias + ".comprador"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".aprovador") = "C"
                        THIS.this_cAprovador = ALLTRIM(EVALUATE(loc_cAlias + ".aprovador"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cpros") = "C"
                        THIS.this_cCPros = ALLTRIM(EVALUATE(loc_cAlias + ".cpros"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".dpros") = "C"
                        THIS.this_cDPros = ALLTRIM(EVALUATE(loc_cAlias + ".dpros"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".iclis") = "C"
                        THIS.this_cIClis = ALLTRIM(EVALUATE(loc_cAlias + ".iclis"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".rclis") = "C"
                        THIS.this_cRClis = ALLTRIM(EVALUATE(loc_cAlias + ".rclis"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".n_pedidos") = "N"
                        THIS.this_nPedidos = IIF(BETWEEN(EVALUATE(loc_cAlias + ".n_pedidos"), 1, 3), ;
                            EVALUATE(loc_cAlias + ".n_pedidos"), 3)
                    ENDIF
                    IF TYPE(loc_cAlias + ".n_aprovados") = "N"
                        THIS.this_nAprovados = IIF(BETWEEN(EVALUATE(loc_cAlias + ".n_aprovados"), 1, 3), ;
                            EVALUATE(loc_cAlias + ".n_aprovados"), 3)
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o grava registros. Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o altera registros. Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores abertos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

