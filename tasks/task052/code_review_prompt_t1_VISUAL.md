# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGRECMC): Top original=248 vs migrado 'cmd_4c_Apaga' Top=163 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGRECMC): Top original=204 vs migrado 'cmd_4c_SelTudo' Top=119 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Comparativo' (parent: SIGRECMC): Top original=380 vs migrado 'chk_4c_Comparativo' Top=295 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecmc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2064 linhas total):

*-- Linhas 46 a 54:
46:         loc_lSucesso   = .F.
47:         loc_lContinuar = .T.
48:         TRY
49:             THIS.Caption = "Relat" + CHR(243) + "rio de Clientes que Mais/Menos/N" + ;
50:                 CHR(227) + "o Compram em Valores e Quantidades"
51: 
52:             IF TYPE("gc_4c_CaminhoIcones") = "U"
53:                 gc_4c_CaminhoIcones = ""
54:             ENDIF

*-- Linhas 85 a 94:
85:                 THIS.ConfigurarBINDEVENTs()
86:                 THIS.AlternarPagina(1)
87: 
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
89:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
90: 
91:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
92:                     THIS.LimparCampos()
93:                 ENDIF
94: 

*-- Linhas 111 a 183:
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH THIS.cnt_4c_Cabecalho
114:             .Top         = 0
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BackStyle   = 1
120:             .BorderWidth = 0
121:             .Visible     = .T.
122:         ENDWITH
123: 
124:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
125:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
126:             .Top       = 17
127:             .Left      = 12
128:             .AutoSize  = .T.
129:             .Caption   = THIS.Caption
130:             .FontName  = "Tahoma"
131:             .FontSize  = 12
132:             .FontBold  = .T.
133:             .ForeColor = RGB(0, 0, 0)
134:             .BackStyle = 0
135:             .Visible   = .T.
136:         ENDWITH
137: 
138:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
139:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
140:             .Top       = 20
141:             .Left      = 10
142:             .AutoSize  = .T.
143:             .Caption   = THIS.Caption
144:             .FontName  = "Tahoma"
145:             .FontSize  = 12
146:             .FontBold  = .T.
147:             .ForeColor = RGB(255, 255, 255)
148:             .BackStyle = 0
149:             .Visible   = .T.
150:         ENDWITH
151:     ENDPROC
152: 
153:     *--------------------------------------------------------------------------
154:     * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
155:     * Left=528 (equivalente ao btnReport.Left=525 do original)
156:     *--------------------------------------------------------------------------
157:     PROTECTED PROCEDURE ConfigurarBotoes()
158:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
159:         WITH THIS.cmg_4c_Botoes
160:             .Top           = 0
161:             .Left          = 529
162:             .Width         = 273
163:             .Height        = 80
164:             .ButtonCount   = 4
165:             .BackStyle     = 0
166:             .BorderStyle   = 0
167:             .BorderColor   = RGB(136, 189, 188)
168:             .SpecialEffect = 1
169:             .Themes        = .F.
170:             .Visible       = .T.
171:         ENDWITH
172: 
173:         WITH THIS.cmg_4c_Botoes.Buttons(1)
174:             .Top             = 5
175:             .Left            = 5
176:             .Width           = 65
177:             .Height          = 70
178:             .Caption         = "Visualizar"
179:             .FontName        = "Tahoma"
180:             .FontBold        = .T.
181:             .FontItalic      = .T.
182:             .FontSize        = 8
183:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 191 a 203:
191:         ENDWITH
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
203:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 211 a 223:
211:         ENDWITH
212: 
213:         WITH THIS.cmg_4c_Botoes.Buttons(3)
214:             .Top             = 5
215:             .Left            = 137
216:             .Width           = 65
217:             .Height          = 70
218:             .Caption         = "Doc Excel"
219:             .FontName        = "Tahoma"
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .FontSize        = 8
223:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 231 a 243:
231:         ENDWITH
232: 
233:         WITH THIS.cmg_4c_Botoes.Buttons(4)
234:             .Top             = 5
235:             .Left            = 203
236:             .Width           = 65
237:             .Height          = 70
238:             .Caption         = "Encerrar"
239:             .FontName        = "Tahoma"
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .FontSize        = 8
243:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 262 a 276:
262:         loc_oPgf = THIS.pgf_4c_Paginas
263: 
264:         loc_oPgf.PageCount = 1
265:         loc_oPgf.Top    = 85
266:         loc_oPgf.Left   = -1
267:         loc_oPgf.Width  = THIS.Width + 2
268:         loc_oPgf.Height = THIS.Height - 85
269:         loc_oPgf.Tabs   = .F.
270: 
271:         loc_oPgf.Page1.Caption   = "Filtros"
272:         loc_oPgf.Page1.FontName  = "Tahoma"
273:         loc_oPgf.Page1.FontSize  = 8
274:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
275:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
276:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 288 a 302:
288:         loc_oPg = THIS.pgf_4c_Paginas.Page1
289: 
290:         *-- Botao Graficos (cmdGgrafico1: Top=84, Left=12, W=116, H=51)
291:         loc_oPg.AddObject("cmd_4c_Graficos", "CommandButton")
292:         WITH loc_oPg.cmd_4c_Graficos
293:             .Top             = 0
294:             .Left            = 12
295:             .Width           = 116
296:             .Height          = 51
297:             .Caption         = "Gr" + CHR(225) + "ficos"
298:             .FontBold        = .T.
299:             .FontItalic      = .T.
300:             .FontName        = "Tahoma"
301:             .FontSize        = 8
302:             .PicturePosition = 1

*-- Linhas 308 a 333:
308:         ENDWITH
309: 
310:         *-- Empresa (Say8: Left=41, Top=144->59; Get_Empresa: L=96, T=141->56, W=33, H=21)
311:         loc_oPg.AddObject("lbl_4c_Empresa", "Label")
312:         WITH loc_oPg.lbl_4c_Empresa
313:             .AutoSize  = .T.
314:             .FontName  = "Tahoma"
315:             .FontSize  = 8
316:             .Caption   = "Empresa :"
317:             .Left      = 41
318:             .Top       = 59
319:             .ForeColor = RGB(90, 90, 90)
320:             .BackStyle = 0
321:             .Visible   = .T.
322:         ENDWITH
323: 
324:         loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
325:         WITH loc_oPg.txt_4c_Empresa
326:             .Height        = 21
327:             .Left          = 96
328:             .Top           = 56
329:             .Width         = 33
330:             .MaxLength     = 10
331:             .Format        = "K"
332:             .SpecialEffect = 1
333:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 339 a 461:
339:         loc_oPg.AddObject("txt_4c_DEmpresa", "TextBox")
340:         WITH loc_oPg.txt_4c_DEmpresa
341:             .Height        = 21
342:             .Left          = 131
343:             .Top           = 56
344:             .Width         = 365
345:             .MaxLength     = 40
346:             .Format        = "K"
347:             .SpecialEffect = 1
348:             .ForeColor     = RGB(0, 0, 0)
349:             .Themes        = .F.
350:             .Value         = ""
351:             .Visible       = .T.
352:         ENDWITH
353: 
354:         *-- Movimentacao (lbl_dopes: L=13, T=169->84; get_nm_operacao: L=96, T=164->79)
355:         loc_oPg.AddObject("lbl_4c_DopEs", "Label")
356:         WITH loc_oPg.lbl_4c_DopEs
357:             .AutoSize  = .T.
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
361:             .Left      = 13
362:             .Top       = 84
363:             .ForeColor = RGB(90, 90, 90)
364:             .BackStyle = 0
365:             .Visible   = .T.
366:         ENDWITH
367: 
368:         loc_oPg.AddObject("txt_4c_NmOperacao", "TextBox")
369:         WITH loc_oPg.txt_4c_NmOperacao
370:             .Height        = 25
371:             .Left          = 96
372:             .Top           = 79
373:             .Width         = 156
374:             .MaxLength     = 20
375:             .Format        = "K!"
376:             .SpecialEffect = 1
377:             .ForeColor     = RGB(0, 0, 0)
378:             .Themes        = .F.
379:             .Value         = ""
380:             .Visible       = .T.
381:         ENDWITH
382: 
383:         *-- Periodo (lbl_periodo: L=46, T=196->111; get_dt_inicial: L=96, T=191->106)
384:         loc_oPg.AddObject("lbl_4c_Periodo", "Label")
385:         WITH loc_oPg.lbl_4c_Periodo
386:             .AutoSize  = .T.
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .Caption   = "Per" + CHR(237) + "odo :"
390:             .Left      = 46
391:             .Top       = 111
392:             .ForeColor = RGB(90, 90, 90)
393:             .BackStyle = 0
394:             .Visible   = .T.
395:         ENDWITH
396: 
397:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
398:         WITH loc_oPg.txt_4c_DtInicial
399:             .Height        = 25
400:             .Left          = 96
401:             .Top           = 106
402:             .Width         = 84
403:             .Format        = "K"
404:             .SpecialEffect = 1
405:             .ForeColor     = RGB(0, 0, 0)
406:             .Themes        = .F.
407:             .Value         = DATE()
408:             .Visible       = .T.
409:         ENDWITH
410: 
411:         loc_oPg.AddObject("lbl_4c_PeriodoA", "Label")
412:         WITH loc_oPg.lbl_4c_PeriodoA
413:             .AutoSize  = .T.
414:             .FontName  = "Tahoma"
415:             .FontSize  = 8
416:             .Caption   = CHR(224)
417:             .Left      = 189
418:             .Top       = 110
419:             .ForeColor = RGB(90, 90, 90)
420:             .BackStyle = 0
421:             .Visible   = .T.
422:         ENDWITH
423: 
424:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
425:         WITH loc_oPg.txt_4c_DtFinal
426:             .Height        = 25
427:             .Left          = 206
428:             .Top           = 106
429:             .Width         = 84
430:             .Format        = "K"
431:             .SpecialEffect = 1
432:             .ForeColor     = RGB(0, 0, 0)
433:             .Themes        = .F.
434:             .Value         = DATE()
435:             .Visible       = .T.
436:         ENDWITH
437: 
438:         *-- Moeda (lbl_moeda: L=50, T=222->137; get_moeda: L=96, T=218->133)
439:         loc_oPg.AddObject("lbl_4c_Moeda", "Label")
440:         WITH loc_oPg.lbl_4c_Moeda
441:             .AutoSize  = .T.
442:             .FontName  = "Tahoma"
443:             .FontSize  = 8
444:             .Caption   = "Moeda :"
445:             .Left      = 50
446:             .Top       = 137
447:             .ForeColor = RGB(90, 90, 90)
448:             .BackStyle = 0
449:             .Visible   = .T.
450:         ENDWITH
451: 
452:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
453:         WITH loc_oPg.txt_4c_Moeda
454:             .Height        = 25
455:             .Left          = 96
456:             .Top           = 133
457:             .Width         = 31
458:             .MaxLength     = 3
459:             .Format        = "K!"
460:             .SpecialEffect = 1
461:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 467 a 562:
467:         loc_oPg.AddObject("txt_4c_MoedaDesc", "TextBox")
468:         WITH loc_oPg.txt_4c_MoedaDesc
469:             .Height        = 25
470:             .Left          = 129
471:             .Top           = 133
472:             .Width         = 154
473:             .MaxLength     = 15
474:             .Format        = "K!"
475:             .SpecialEffect = 1
476:             .ForeColor     = RGB(0, 0, 0)
477:             .Themes        = .F.
478:             .Value         = ""
479:             .Visible       = .T.
480:         ENDWITH
481: 
482:         *-- Quantidade/Minimo (Say2: L=26, T=250->165; Get_Qtde: L=96, T=245->160)
483:         loc_oPg.AddObject("lbl_4c_Quantidade", "Label")
484:         WITH loc_oPg.lbl_4c_Quantidade
485:             .AutoSize  = .T.
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8
488:             .Caption   = "Quantidade :"
489:             .Left      = 26
490:             .Top       = 165
491:             .ForeColor = RGB(90, 90, 90)
492:             .BackStyle = 0
493:             .Visible   = .T.
494:         ENDWITH
495: 
496:         loc_oPg.AddObject("txt_4c_Qtde", "TextBox")
497:         WITH loc_oPg.txt_4c_Qtde
498:             .Height        = 25
499:             .Left          = 96
500:             .Top           = 160
501:             .Width         = 53
502:             .Format        = "K"
503:             .Alignment     = 3
504:             .SpecialEffect = 1
505:             .ForeColor     = RGB(0, 0, 0)
506:             .Themes        = .F.
507:             .Value         = 50
508:             .Visible       = .T.
509:         ENDWITH
510: 
511:         loc_oPg.AddObject("lbl_4c_Minimo", "Label")
512:         WITH loc_oPg.lbl_4c_Minimo
513:             .AutoSize  = .T.
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .Caption   = "M" + CHR(237) + "nimo :"
517:             .Left      = 162
518:             .Top       = 165
519:             .ForeColor = RGB(90, 90, 90)
520:             .BackStyle = 0
521:             .Visible   = .T.
522:         ENDWITH
523: 
524:         loc_oPg.AddObject("txt_4c_QtMin", "TextBox")
525:         WITH loc_oPg.txt_4c_QtMin
526:             .Height        = 25
527:             .Left          = 206
528:             .Top           = 160
529:             .Width         = 53
530:             .Format        = "K"
531:             .Alignment     = 3
532:             .SpecialEffect = 1
533:             .ForeColor     = RGB(0, 0, 0)
534:             .Themes        = .F.
535:             .Value         = 0
536:             .Visible       = .T.
537:         ENDWITH
538: 
539:         *-- Conta (lbl_estoque: L=53, T=276->191; getCdEstoque: L=96, T=272->187)
540:         loc_oPg.AddObject("lbl_4c_Conta", "Label")
541:         WITH loc_oPg.lbl_4c_Conta
542:             .AutoSize  = .T.
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .Caption   = "Conta :"
546:             .Left      = 53
547:             .Top       = 191
548:             .ForeColor = RGB(90, 90, 90)
549:             .BackStyle = 0
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         loc_oPg.AddObject("txt_4c_CdConta", "TextBox")
554:         WITH loc_oPg.txt_4c_CdConta
555:             .Height        = 25
556:             .Left          = 96
557:             .Top           = 187
558:             .Width         = 108
559:             .MaxLength     = 10
560:             .Format        = "K"
561:             .SpecialEffect = 1
562:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 568 a 606:
568:         loc_oPg.AddObject("txt_4c_DsConta", "TextBox")
569:         WITH loc_oPg.txt_4c_DsConta
570:             .Height        = 25
571:             .Left          = 206
572:             .Top           = 187
573:             .Width         = 290
574:             .MaxLength     = 40
575:             .Format        = "K"
576:             .SpecialEffect = 1
577:             .ForeColor     = RGB(0, 0, 0)
578:             .Themes        = .F.
579:             .Value         = ""
580:             .Visible       = .T.
581:         ENDWITH
582: 
583:         *-- Vendedor (Say4: L=36, T=303->218; getCdVendedor: L=96, T=299->214)
584:         loc_oPg.AddObject("lbl_4c_Vendedor1", "Label")
585:         WITH loc_oPg.lbl_4c_Vendedor1
586:             .AutoSize  = .T.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .Caption   = "Vendedor :"
590:             .Left      = 36
591:             .Top       = 218
592:             .ForeColor = RGB(90, 90, 90)
593:             .BackStyle = 0
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         loc_oPg.AddObject("txt_4c_CdVendedor", "TextBox")
598:         WITH loc_oPg.txt_4c_CdVendedor
599:             .Height        = 25
600:             .Left          = 96
601:             .Top           = 214
602:             .Width         = 108
603:             .MaxLength     = 10
604:             .Format        = "K"
605:             .SpecialEffect = 1
606:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 612 a 650:
612:         loc_oPg.AddObject("txt_4c_DsVendedor", "TextBox")
613:         WITH loc_oPg.txt_4c_DsVendedor
614:             .Height        = 25
615:             .Left          = 206
616:             .Top           = 214
617:             .Width         = 290
618:             .MaxLength     = 40
619:             .Format        = "K"
620:             .SpecialEffect = 1
621:             .ForeColor     = RGB(0, 0, 0)
622:             .Themes        = .F.
623:             .Value         = ""
624:             .Visible       = .T.
625:         ENDWITH
626: 
627:         *-- Produto (lbl_codigo: L=44, T=330->245; get_cd_codigo: L=96, T=326->241)
628:         loc_oPg.AddObject("lbl_4c_Produto", "Label")
629:         WITH loc_oPg.lbl_4c_Produto
630:             .AutoSize  = .T.
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .Caption   = "Produto :"
634:             .Left      = 44
635:             .Top       = 245
636:             .ForeColor = RGB(90, 90, 90)
637:             .BackStyle = 0
638:             .Visible   = .T.
639:         ENDWITH
640: 
641:         loc_oPg.AddObject("txt_4c_CdProduto", "TextBox")
642:         WITH loc_oPg.txt_4c_CdProduto
643:             .Height        = 25
644:             .Left          = 96
645:             .Top           = 241
646:             .Width         = 108
647:             .MaxLength     = 14
648:             .Format        = "K!"
649:             .SpecialEffect = 1
650:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 656 a 760:
656:         loc_oPg.AddObject("txt_4c_DsProduto", "TextBox")
657:         WITH loc_oPg.txt_4c_DsProduto
658:             .Height        = 25
659:             .Left          = 206
660:             .Top           = 241
661:             .Width         = 290
662:             .MaxLength     = 40
663:             .Format        = "K!"
664:             .SpecialEffect = 1
665:             .ForeColor     = RGB(0, 0, 0)
666:             .Themes        = .F.
667:             .Value         = ""
668:             .Visible       = .T.
669:         ENDWITH
670: 
671:         *-- Ordem (Say1: L=50, T=363->278; opt_ordem: L=93, T=356->271)
672:         loc_oPg.AddObject("lbl_4c_Ordem", "Label")
673:         WITH loc_oPg.lbl_4c_Ordem
674:             .AutoSize  = .T.
675:             .FontName  = "Tahoma"
676:             .FontSize  = 8
677:             .Caption   = "Ordem :"
678:             .Left      = 50
679:             .Top       = 278
680:             .ForeColor = RGB(90, 90, 90)
681:             .BackStyle = 0
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         loc_oPg.AddObject("ogp_4c_Ordem", "OptionGroup")
686:         WITH loc_oPg.ogp_4c_Ordem
687:             .AutoSize      = .T.
688:             .ButtonCount   = 3
689:             .BackStyle     = 0
690:             .BorderStyle   = 0
691:             .Height        = 62
692:             .Left          = 93
693:             .SpecialEffect = 0
694:             .Top           = 271
695:             .Width         = 107
696:             .Value         = 1
697:             .Visible       = .T.
698:         ENDWITH
699:         WITH loc_oPg.ogp_4c_Ordem.Buttons(1)
700:             .Caption   = "Mais Compram"
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .BackStyle = 0
704:             .Left      = 5
705:             .Top       = 5
706:             .AutoSize  = .T.
707:             .ForeColor = RGB(90, 90, 90)
708:         ENDWITH
709:         WITH loc_oPg.ogp_4c_Ordem.Buttons(2)
710:             .Caption   = "Menos Compram"
711:             .FontName  = "Tahoma"
712:             .FontSize  = 8
713:             .BackStyle = 0
714:             .Left      = 5
715:             .Top       = 23
716:             .AutoSize  = .T.
717:             .ForeColor = RGB(90, 90, 90)
718:         ENDWITH
719:         WITH loc_oPg.ogp_4c_Ordem.Buttons(3)
720:             .Caption   = "N" + CHR(227) + "o Compram"
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .BackStyle = 0
724:             .Left      = 5
725:             .Top       = 42
726:             .AutoSize  = .T.
727:             .ForeColor = RGB(90, 90, 90)
728:         ENDWITH
729: 
730:         *-- chkCidade (L=227, T=362->277)
731:         loc_oPg.AddObject("chk_4c_Cidade", "CheckBox")
732:         WITH loc_oPg.chk_4c_Cidade
733:             .Left      = 227
734:             .Top       = 277
735:             .Height    = 15
736:             .Width     = 70
737:             .Caption   = "Cidades"
738:             .AutoSize  = .T.
739:             .FontName  = "Tahoma"
740:             .FontSize  = 8
741:             .BackStyle = 0
742:             .ForeColor = RGB(90, 90, 90)
743:             .Value     = 0
744:             .Themes    = .F.
745:             .Visible   = .T.
746:         ENDWITH
747: 
748:         *-- chkComparativo (L=227, T=380->295)
749:         loc_oPg.AddObject("chk_4c_Comparativo", "CheckBox")
750:         WITH loc_oPg.chk_4c_Comparativo
751:             .Left      = 227
752:             .Top       = 295
753:             .Height    = 15
754:             .Width     = 90
755:             .Caption   = "Comparativo"
756:             .AutoSize  = .T.
757:             .FontName  = "Tahoma"
758:             .FontSize  = 8
759:             .BackStyle = 0
760:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 766 a 825:
766:         *-- Container1 com ChkDadosCli e chkValor (L=224, T=396->311, W=313, H=20)
767:         loc_oPg.AddObject("cnt_4c_OpcoesDados", "Container")
768:         WITH loc_oPg.cnt_4c_OpcoesDados
769:             .Top         = 311
770:             .Left        = 224
771:             .Width       = 313
772:             .Height      = 20
773:             .BackStyle   = 0
774:             .BorderWidth = 0
775:             .Visible     = .T.
776:         ENDWITH
777: 
778:         loc_oPg.cnt_4c_OpcoesDados.AddObject("chk_4c_DadosCli", "CheckBox")
779:         WITH loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli
780:             .Top       = 2
781:             .Left      = 3
782:             .Height    = 15
783:             .Width     = 110
784:             .Caption   = "Dados do Cliente"
785:             .AutoSize  = .T.
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:             .BackStyle = 0
789:             .ForeColor = RGB(90, 90, 90)
790:             .Value     = 0
791:             .Themes    = .F.
792:             .Visible   = .T.
793:         ENDWITH
794: 
795:         loc_oPg.cnt_4c_OpcoesDados.AddObject("chk_4c_Valor", "CheckBox")
796:         WITH loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor
797:             .Top       = 2
798:             .Left      = 148
799:             .Height    = 15
800:             .Width     = 70
801:             .Caption   = "Com Valor"
802:             .AutoSize  = .T.
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .BackStyle = 0
806:             .ForeColor = RGB(90, 90, 90)
807:             .Value     = 0
808:             .Themes    = .F.
809:             .Visible   = .T.
810:         ENDWITH
811: 
812:         *-- Selecao (Say6: L=45, T=423->338)
813:         loc_oPg.AddObject("lbl_4c_Selecao", "Label")
814:         WITH loc_oPg.lbl_4c_Selecao
815:             .AutoSize  = .T.
816:             .FontName  = "Tahoma"
817:             .FontSize  = 8
818:             .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
819:             .Left      = 45
820:             .Top       = 338
821:             .ForeColor = RGB(90, 90, 90)
822:             .BackStyle = 0
823:             .Visible   = .T.
824:         ENDWITH
825: 

*-- Linhas 831 a 875:
831:             .BackStyle     = 0
832:             .BorderStyle   = 0
833:             .Height        = 27
834:             .Left          = 93
835:             .SpecialEffect = 0
836:             .Top           = 332
837:             .Width         = 225
838:             .Value         = 1
839:             .Visible       = .T.
840:         ENDWITH
841:         WITH loc_oPg.ogp_4c_SelRel.Buttons(1)
842:             .Caption   = "Valor"
843:             .FontName  = "Tahoma"
844:             .FontSize  = 8
845:             .BackStyle = 0
846:             .Left      = 5
847:             .Top       = 6
848:             .Width     = 82
849:             .ForeColor = RGB(90, 90, 90)
850:         ENDWITH
851:         WITH loc_oPg.ogp_4c_SelRel.Buttons(2)
852:             .Caption   = "Quantidade"
853:             .FontName  = "Tahoma"
854:             .FontSize  = 8
855:             .BackStyle = 0
856:             .Left      = 133
857:             .Top       = 5
858:             .Width     = 82
859:             .ForeColor = RGB(90, 90, 90)
860:         ENDWITH
861: 
862:         *-- Comparativo label (Say5: L=21, T=447->362)
863:         loc_oPg.AddObject("lbl_4c_LblCompara", "Label")
864:         WITH loc_oPg.lbl_4c_LblCompara
865:             .AutoSize  = .T.
866:             .FontName  = "Tahoma"
867:             .FontSize  = 8
868:             .Caption   = "Comparativo :"
869:             .Left      = 21
870:             .Top       = 362
871:             .ForeColor = RGB(90, 90, 90)
872:             .BackStyle = 0
873:             .Visible   = .T.
874:         ENDWITH
875: 

*-- Linhas 881 a 928:
881:             .BackStyle     = 0
882:             .BorderStyle   = 0
883:             .Height        = 26
884:             .Left          = 93
885:             .SpecialEffect = 0
886:             .Top           = 356
887:             .Width         = 222
888:             .Value         = 1
889:             .Enabled       = .F.
890:             .Visible       = .T.
891:         ENDWITH
892:         WITH loc_oPg.ogp_4c_Compara.Buttons(1)
893:             .Caption   = "Cliente"
894:             .FontName  = "Tahoma"
895:             .FontSize  = 8
896:             .BackStyle = 0
897:             .Left      = 5
898:             .Top       = 6
899:             .Width     = 51
900:             .AutoSize  = .T.
901:             .ForeColor = RGB(90, 90, 90)
902:         ENDWITH
903:         WITH loc_oPg.ogp_4c_Compara.Buttons(2)
904:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o"
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .BackStyle = 0
908:             .Left      = 133
909:             .Top       = 5
910:             .Width     = 79
911:             .AutoSize  = .T.
912:             .ForeColor = RGB(90, 90, 90)
913:         ENDWITH
914: 
915:         *-- Vendedor label 2 (Say7: L=36, T=470->385)
916:         loc_oPg.AddObject("lbl_4c_Vendedor2", "Label")
917:         WITH loc_oPg.lbl_4c_Vendedor2
918:             .AutoSize  = .T.
919:             .FontName  = "Tahoma"
920:             .FontSize  = 8
921:             .Caption   = "Vendedor :"
922:             .Left      = 36
923:             .Top       = 385
924:             .ForeColor = RGB(90, 90, 90)
925:             .BackStyle = 0
926:             .Visible   = .T.
927:         ENDWITH
928: 

*-- Linhas 934 a 986:
934:             .BackStyle     = 0
935:             .BorderStyle   = 0
936:             .Height        = 25
937:             .Left          = 93
938:             .SpecialEffect = 0
939:             .Top           = 380
940:             .Width         = 200
941:             .Value         = 1
942:             .Visible       = .T.
943:         ENDWITH
944:         WITH loc_oPg.ogp_4c_MovCad.Buttons(1)
945:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
946:             .FontName  = "Tahoma"
947:             .FontSize  = 8
948:             .BackStyle = 0
949:             .Left      = 5
950:             .Top       = 5
951:             .AutoSize  = .T.
952:             .Value     = 1
953:             .ForeColor = RGB(90, 90, 90)
954:         ENDWITH
955:         WITH loc_oPg.ogp_4c_MovCad.Buttons(2)
956:             .Caption   = "Cadastro"
957:             .FontName  = "Tahoma"
958:             .FontSize  = 8
959:             .BackStyle = 0
960:             .Left      = 133
961:             .Top       = 5
962:             .AutoSize  = .T.
963:             .Value     = 0
964:             .ForeColor = RGB(90, 90, 90)
965:         ENDWITH
966:     ENDPROC
967: 
968:     *--------------------------------------------------------------------------
969:     * ConfigurarGrade - Grid para tipos de operacao (GrdTipo original)
970:     * GrdTipo: Left=503, Top=141->56, W=228, H=218
971:     * cmd_4c_SelTudo: L=735, T=204->119; cmd_4c_Apaga: L=735, T=248->163
972:     *--------------------------------------------------------------------------
973:     PROTECTED PROCEDURE ConfigurarGrade()
974:         LOCAL loc_oPg, loc_oGrd
975:         loc_oPg = THIS.pgf_4c_Paginas.Page1
976: 
977:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
978:         loc_oGrd = loc_oPg.grd_4c_Dados
979:         WITH loc_oGrd
980:             .Top          = 56
981:             .Left         = 503
982:             .Width        = 228
983:             .Height       = 218
984:             .ColumnCount  = 2
985:             .AllowRowSizing = .F.
986:             .DeleteMark   = .F.

*-- Linhas 994 a 1010:
994:             .Visible      = .T.
995:         ENDWITH
996: 
997:         *-- Column1: CheckBox para nMarca (Width=20, Sparse=.F.)
998:         WITH loc_oGrd.Column1
999:             .Width         = 20
1000:             .Sparse        = .F.
1001:             .Enabled       = .T.
1002:         ENDWITH
1003:         loc_oGrd.Column1.AddObject("chk_4c_Mark", "CheckBox")
1004:         WITH loc_oGrd.Column1.chk_4c_Mark
1005:             .Caption   = ""
1006:             .Alignment = 2
1007:             .BackStyle = 0
1008:             .Themes    = .F.
1009:         ENDWITH
1010:         loc_oGrd.Column1.CurrentControl = "chk_4c_Mark"

*-- Linhas 1028 a 1067:
1028:             loc_oGrd.Column1.ControlSource     = "CrSigCdTom.nMarca"
1029:             loc_oGrd.Column2.ControlSource     = "CrSigCdTom.Descri"
1030:         ENDIF
1031: 
1032:         *-- Botao Selecionar todos (SelTudo: L=735, T=204->119, W=45, H=45)
1033:         loc_oPg.AddObject("cmd_4c_SelTudo", "CommandButton")
1034:         WITH loc_oPg.cmd_4c_SelTudo
1035:             .Top           = 119
1036:             .Left          = 735
1037:             .Width         = 45
1038:             .Height        = 45
1039:             .Caption       = ""
1040:             .FontName      = "Verdana"
1041:             .FontSize      = 8
1042:             .ForeColor     = RGB(36, 84, 155)
1043:             .BackColor     = RGB(255, 255, 255)
1044:             .Themes        = .F.
1045:             .TabStop       = .F.
1046:             .ToolTipText   = "Selecionar"
1047:             .Visible       = .T.
1048:         ENDWITH
1049: 
1050:         *-- Botao Desmarcar (apaga: L=735, T=248->163, W=45, H=45)
1051:         loc_oPg.AddObject("cmd_4c_Apaga", "CommandButton")
1052:         WITH loc_oPg.cmd_4c_Apaga
1053:             .Top           = 163
1054:             .Left          = 735
1055:             .Width         = 45
1056:             .Height        = 45
1057:             .Caption       = ""
1058:             .FontName      = "Verdana"
1059:             .FontSize      = 8
1060:             .ForeColor     = RGB(36, 84, 155)
1061:             .BackColor     = RGB(255, 255, 255)
1062:             .Themes        = .F.
1063:             .TabStop       = .F.
1064:             .ToolTipText   = "Desmarcar"
1065:             .Visible       = .T.
1066:         ENDWITH
1067:     ENDPROC

*-- Linhas 1075 a 1098:
1075: 
1076:         loc_oPg.AddObject("cnt_4c_Mensagem", "Container")
1077:         WITH loc_oPg.cnt_4c_Mensagem
1078:             .Top         = 150
1079:             .Left        = 175
1080:             .Width       = 473
1081:             .Height      = 56
1082:             .BackStyle   = 0
1083:             .BorderWidth = 0
1084:             .Visible     = .F.
1085:         ENDWITH
1086: 
1087:         loc_oPg.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
1088:         WITH loc_oPg.cnt_4c_Mensagem.lbl_4c_LblMensagem
1089:             .Top       = 18
1090:             .Left      = 20
1091:             .Width     = 445
1092:             .Height    = 22
1093:             .Caption   = "Aguarde!!!"
1094:             .FontName  = "Tahoma"
1095:             .FontSize  = 14
1096:             .FontBold  = .T.
1097:             .ForeColor = RGB(0, 0, 0)
1098:             .BackStyle = 0

*-- Linhas 1140 a 1161:
1140:         loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
1141:         loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
1142:         loc_oPg.ogp_4c_Compara.Enabled              = .F.
1143:         loc_oPg.cmd_4c_Graficos.Enabled             = .F.
1144:         loc_oPg.grd_4c_Dados.Enabled                = .T.
1145:         loc_oPg.cmd_4c_SelTudo.Enabled              = .T.
1146:         loc_oPg.cmd_4c_Apaga.Enabled                = .T.
1147:         THIS.AjustarCamposMoeda()
1148:         THIS.AjustarCamposProduto()
1149:     ENDPROC
1150: 
1151:     *--------------------------------------------------------------------------
1152:     * AlternarPagina
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE AlternarPagina(par_nPagina)
1155:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
1156:            VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
1157:            par_nPagina <= THIS.pgf_4c_Paginas.PageCount
1158:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1159:         ENDIF
1160:     ENDPROC
1161: 

*-- Linhas 1202 a 1223:
1202:         BINDEVENT(loc_oPg.chk_4c_Cidade,       "Click", THIS, "ChkCidadeClick")
1203:         BINDEVENT(loc_oPg.chk_4c_Comparativo,  "Click", THIS, "ChkComparativoClick")
1204:         BINDEVENT(loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli, "Click", THIS, "ChkDadosCliClick")
1205:         BINDEVENT(loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor,    "Click", THIS, "ChkValorClick")
1206: 
1207:         BINDEVENT(loc_oPg.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
1208:         BINDEVENT(loc_oPg.cmd_4c_Apaga,   "Click", THIS, "CmdApagaClick")
1209:         BINDEVENT(loc_oPg.cmd_4c_Graficos,"Click", THIS, "CmdGraficosClick")
1210:     ENDPROC
1211: 
1212:     *--------------------------------------------------------------------------
1213:     * AjustarCamposMoeda - Habilita/desabilita desc moeda conforme opt_selrel
1214:     *--------------------------------------------------------------------------
1215:     PROTECTED PROCEDURE AjustarCamposMoeda()
1216:         LOCAL loc_oPg
1217:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1218:         IF VARTYPE(loc_oPg) = "O"
1219:             LOCAL loc_lValor
1220:             loc_lValor = (loc_oPg.ogp_4c_SelRel.Value = 1)
1221:             loc_oPg.txt_4c_Moeda.Enabled     = loc_lValor
1222:             loc_oPg.txt_4c_MoedaDesc.Enabled = loc_lValor
1223:         ENDIF

*-- Linhas 1411 a 1419:
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     * HANDLERS DE OPTIONGROUPS E CHECKBOXES
1415:     *==========================================================================
1416: 
1417:     *-- opt_ordem.InteractiveChange: Value=3 (Nao Compram) -> MovCad=2, Cidade=0
1418:     PROCEDURE OgpOrdemInteractiveChange()
1419:         LOCAL loc_oPg

*-- Linhas 1447 a 1458:
1447:         loc_lComparativo = (loc_oPg.chk_4c_Comparativo.Value = 1)
1448:         IF loc_lComparativo AND loc_oPg.ogp_4c_SelRel.Value = 1
1449:             loc_oPg.ogp_4c_Compara.Enabled  = .T.
1450:             loc_oPg.cmd_4c_Graficos.Enabled = .T.
1451:         ELSE
1452:             loc_oPg.ogp_4c_Compara.Enabled  = .F.
1453:             loc_oPg.cmd_4c_Graficos.Enabled = .F.
1454:         ENDIF
1455:         IF loc_lComparativo
1456:             loc_oPg.chk_4c_Cidade.Value = 0
1457:         ENDIF
1458:         loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0

*-- Linhas 1472 a 1500:
1472:         loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
1473:         loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
1474:         loc_oPg.ogp_4c_Compara.Enabled  = .F.
1475:         loc_oPg.cmd_4c_Graficos.Enabled = .F.
1476:     ENDPROC
1477: 
1478:     *-- ChkDadosCli.Click
1479:     PROCEDURE ChkDadosCliClick()
1480:         LOCAL loc_oPg
1481:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1482:         IF loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 1
1483:             loc_oPg.cmd_4c_Graficos.Enabled  = .F.
1484:             loc_oPg.chk_4c_Cidade.Value      = 0
1485:             loc_oPg.chk_4c_Comparativo.Value = 0
1486:             loc_oPg.ogp_4c_Compara.Enabled   = .F.
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     *-- ChkValor.Click
1491:     PROCEDURE ChkValorClick()
1492:         LOCAL loc_oPg
1493:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1494:         IF loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value = 1
1495:             loc_oPg.cmd_4c_Graficos.Enabled             = .F.
1496:             loc_oPg.chk_4c_Cidade.Value                 = 0
1497:             loc_oPg.chk_4c_Comparativo.Value            = 0
1498:             loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 1
1499:             loc_oPg.ogp_4c_Compara.Enabled              = .F.
1500:         ENDIF

*-- Linhas 1562 a 1587:
1562:             loc_oPg  = THIS.pgf_4c_Paginas.Page1
1563:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)
1564:             IF !EMPTY(loc_cValor)
1565:                 THIS.AbrirBuscaOperacao()
1566:                 loc_oPg.grd_4c_Dados.Enabled   = .F.
1567:                 loc_oPg.cmd_4c_Apaga.Enabled   = .F.
1568:                 loc_oPg.cmd_4c_SelTudo.Enabled = .F.
1569:             ELSE
1570:                 loc_oPg.grd_4c_Dados.Enabled   = .T.
1571:                 loc_oPg.cmd_4c_Apaga.Enabled   = .T.
1572:                 loc_oPg.cmd_4c_SelTudo.Enabled = .T.
1573:             ENDIF
1574:         ENDIF
1575:     ENDPROC
1576: 
1577:     *-- DtInicial: valida intervalo maximo de 6 anos
1578:     PROCEDURE TxtDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1579:         LOCAL loc_oPg, loc_dDti, loc_dDtf
1580:         loc_oPg  = THIS.pgf_4c_Paginas.Page1
1581:         loc_dDti = loc_oPg.txt_4c_DtInicial.Value
1582:         loc_dDtf = loc_oPg.txt_4c_DtFinal.Value
1583:         IF VARTYPE(loc_dDti) = "D" AND VARTYPE(loc_dDtf) = "D"
1584:             IF (YEAR(loc_dDtf) - YEAR(loc_dDti)) >= 6
1585:                 MsgAviso("O per" + CHR(237) + "odo n" + CHR(227) + "o pode passar de 6 anos!!", ;
1586:                     "Aten" + CHR(231) + CHR(227) + "o!!")
1587:                 THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.

*-- Linhas 2016 a 2037:
2016:         loc_oPg.ogp_4c_SelRel.Enabled     = par_lHabilitar
2017:         loc_oPg.ogp_4c_MovCad.Enabled     = par_lHabilitar
2018:         loc_oPg.chk_4c_Cidade.Enabled     = par_lHabilitar
2019:         loc_oPg.chk_4c_Comparativo.Enabled = par_lHabilitar
2020:         loc_oPg.grd_4c_Dados.Enabled      = par_lHabilitar
2021:         loc_oPg.cmd_4c_SelTudo.Enabled    = par_lHabilitar
2022:         loc_oPg.cmd_4c_Apaga.Enabled      = par_lHabilitar
2023: 
2024:         IF par_lHabilitar
2025:             THIS.AjustarCamposMoeda()
2026:             THIS.AjustarCamposProduto()
2027:         ENDIF
2028:     ENDPROC
2029: 
2030:     *--------------------------------------------------------------------------
2031:     * AjustarBotoesPorModo - Ajusta estado dos botoes do CommandGroup
2032:     * Para form REPORT: botoes de imprimir/visualizar sempre habilitados
2033:     *--------------------------------------------------------------------------
2034:     PROCEDURE AjustarBotoesPorModo()
2035:         IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
2036:             RETURN
2037:         ENDIF

