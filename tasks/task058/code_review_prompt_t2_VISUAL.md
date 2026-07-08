# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (13)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGRECNT): Top original=134 vs migrado 'lbl_4c_Label2' Top=49 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGRECNT): Top original=270 vs migrado 'lbl_4c_Label4' Top=185 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGRECNT): Top original=294 vs migrado 'lbl_4c_Label9' Top=209 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGRECNT): Top original=162 vs migrado 'lbl_4c_Label7' Top=77 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGRECNT): Top original=190 vs migrado 'lbl_4c_Label6' Top=105 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGRECNT): Top original=218 vs migrado 'lbl_4c_Label5' Top=133 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGRECNT): Top original=246 vs migrado 'lbl_4c_Label8' Top=161 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGRECNT): Top original=105 vs migrado 'lbl_4c_Label3' Top=20 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECNT): Top original=106 vs migrado 'lbl_4c_Label1' Top=21 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptLocal' (parent: SIGRECNT): Top original=265 vs migrado 'obj_4c_OptLocal' Top=4 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptLocal' (parent: SIGRECNT): Left original=231 vs migrado 'obj_4c_OptLocal' Left=2 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGRECNT): Top original=289 vs migrado 'obj_4c_OptOrdem' Top=4 (diff=285px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGRECNT): Left original=231 vs migrado 'obj_4c_OptOrdem' Left=2 (diff=229px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecnt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1470 linhas total):

*-- Linhas 89 a 97:
89:         loc_lSucesso   = .F.
90:         loc_lContinuar = .T.
91:         TRY
92:             THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
93:                            "Localiza" + CHR(231) + CHR(227) + "o"
94: 
95:             IF TYPE("gc_4c_CaminhoIcones") = "U"
96:                 gc_4c_CaminhoIcones = ""
97:             ENDIF

*-- Linhas 136 a 145:
136:                 *-- Redefine filtros para valores padr" + CHR(227) + "o
137:                 THIS.LimparCampos()
138: 
139:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
140:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
141: 
142:                 THIS.Visible = .T.
143:                 loc_lSucesso = .T.
144:             ENDIF
145:         CATCH TO loc_oErro

*-- Linhas 159 a 200:
159:     PROTECTED PROCEDURE ConfigurarCabecalho()
160:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
161:         WITH THIS.cnt_4c_Cabecalho
162:             .Top         = 0
163:             .Left        = 0
164:             .Width       = THIS.Width
165:             .Height      = 80
166:             .BackStyle   = 1
167:             .BackColor   = RGB(100, 100, 100)
168:             .BorderWidth = 0
169:             .Visible     = .T.
170: 
171:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
172:             .AddObject("lbl_4c_Sombra", "Label")
173:             WITH .lbl_4c_Sombra
174:                 .Top       = 22
175:                 .Left      = 22
176:                 .Width     = THIS.Width
177:                 .Height    = 30
178:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
179:                              "Localiza" + CHR(231) + CHR(227) + "o"
180:                 .FontName  = "Tahoma"
181:                 .FontSize  = 14
182:                 .FontBold  = .T.
183:                 .ForeColor = RGB(0, 0, 0)
184:                 .BackStyle = 0
185:                 .Visible   = .T.
186:             ENDWITH
187: 
188:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
189:             .AddObject("lbl_4c_Titulo", "Label")
190:             WITH .lbl_4c_Titulo
191:                 .Top       = 20
192:                 .Left      = 20
193:                 .Width     = THIS.Width
194:                 .Height    = 30
195:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
196:                              "Localiza" + CHR(231) + CHR(227) + "o"
197:                 .FontName  = "Tahoma"
198:                 .FontSize  = 14
199:                 .FontBold  = .T.
200:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 206 a 239:
206: 
207:     *--------------------------------------------------------------------------
208:     * ConfigurarBotoes - CommandGroup com bot" + CHR(245) + "es de relat" + CHR(243) + "rio (btnReport " + CHR(225) + "rea)
209:     *   Original: btnReport.Top=0, Left=529, Width=273, Height=80, ButtonCount=4
210:     *   Bot" + CHR(245) + "es: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
211:     *   Eventos Click vinculados em InicializarForm (Fase 7).
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarBotoes()
214:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
215:         WITH THIS.cmg_4c_Botoes
216:             .Top           = 0
217:             .Left          = 529
218:             .Width         = 273
219:             .Height        = 80
220:             .ButtonCount   = 4
221:             .BackStyle     = 0
222:             .BorderStyle   = 0
223:             .BorderColor   = RGB(136, 189, 188)
224:             .SpecialEffect = 1
225:             .Themes        = .F.
226:             .Visible       = .T.
227: 
228:             *-- Visualizar (preview em tela)
229:             WITH .Buttons(1)
230:                 .Top             = 5
231:                 .Left            = 5
232:                 .Width           = 65
233:                 .Height          = 70
234:                 .Caption         = "Visualizar"
235:                 .FontBold        = .T.
236:                 .FontItalic      = .T.
237:                 .BackColor       = RGB(255, 255, 255)
238:                 .ForeColor       = RGB(90, 90, 90)
239:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 247 a 259:
247: 
248:             *-- Imprimir (impressora padr" + CHR(227) + "o)
249:             WITH .Buttons(2)
250:                 .Top             = 5
251:                 .Left            = 71
252:                 .Width           = 65
253:                 .Height          = 70
254:                 .Caption         = "Imprimir"
255:                 .FontName        = "Tahoma"
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .FontSize        = 8
259:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 269 a 281:
269: 
270:             *-- Excel (exportar dados)
271:             WITH .Buttons(3)
272:                 .Top             = 5
273:                 .Left            = 137
274:                 .Width           = 65
275:                 .Height          = 70
276:                 .Caption         = "Excel"
277:                 .FontName        = "Tahoma"
278:                 .FontBold        = .T.
279:                 .FontItalic      = .T.
280:                 .FontSize        = 8
281:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 291 a 303:
291: 
292:             *-- Encerrar (fechar form)
293:             WITH .Buttons(4)
294:                 .Top             = 5
295:                 .Left            = 203
296:                 .Width           = 65
297:                 .Height          = 70
298:                 .Caption         = "Encerrar"
299:                 .Cancel          = .T.
300:                 .FontName        = "Tahoma"
301:                 .FontBold        = .T.
302:                 .FontItalic      = .T.
303:                 .FontSize        = 8

*-- Linhas 334 a 349:
334:         loc_oPgf.PageCount = 1
335: 
336:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho
337:         loc_oPgf.Top    = 85
338:         loc_oPgf.Left   = -1
339:         loc_oPgf.Width  = THIS.Width + 2
340:         loc_oPgf.Height = THIS.Height - 85
341:         loc_oPgf.Tabs   = .F.
342: 
343:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
344:         loc_oPgf.Page1.Caption   = "Filtros"
345:         loc_oPgf.Page1.FontName  = "Tahoma"
346:         loc_oPgf.Page1.FontSize  = 8
347:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
348:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
349:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 368 a 769:
368:         loc_oPag = THIS.pgf_4c_Paginas.Page1
369: 
370:         *-- Data
371:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
372:         WITH loc_oPag.lbl_4c_Label1
373:             .Top       = 21
374:             .Left      = 199
375:             .Width     = 32
376:             .Height    = 15
377:             .Caption   = "Data :"
378:             .FontName  = "Tahoma"
379:             .FontSize  = 8
380:             .BackStyle = 0
381:             .ForeColor = RGB(90, 90, 90)
382:             .Visible   = .T.
383:         ENDWITH
384: 
385:         loc_oPag.AddObject("txt_4c_Datas", "TextBox")
386:         WITH loc_oPag.txt_4c_Datas
387:             .Top      = 17
388:             .Left     = 235
389:             .Width    = 80
390:             .Height   = 24
391:             .Value    = {}
392:             .Format   = "D"
393:             .FontName = "Tahoma"
394:             .FontSize = 8
395:             .Visible  = .T.
396:         ENDWITH
397: 
398:         *-- C" + CHR(243) + "digo
399:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
400:         WITH loc_oPag.lbl_4c_Label3
401:             .Top       = 20
402:             .Left      = 366
403:             .Width     = 42
404:             .Height    = 15
405:             .Caption   = "C" + CHR(243) + "digo :"
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .BackStyle = 0
409:             .ForeColor = RGB(90, 90, 90)
410:             .Visible   = .T.
411:         ENDWITH
412: 
413:         loc_oPag.AddObject("txt_4c_Codigo", "TextBox")
414:         WITH loc_oPag.txt_4c_Codigo
415:             .Top      = 16
416:             .Left     = 411
417:             .Width    = 54
418:             .Height   = 24
419:             .Value    = ""
420:             .FontName = "Tahoma"
421:             .FontSize = 8
422:             .Visible  = .T.
423:         ENDWITH
424: 
425:         *-- Vendedor
426:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
427:         WITH loc_oPag.lbl_4c_Label2
428:             .Top       = 49
429:             .Left      = 176
430:             .Width     = 55
431:             .Height    = 15
432:             .Caption   = "Vendedor :"
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .BackStyle = 0
436:             .ForeColor = RGB(90, 90, 90)
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         loc_oPag.AddObject("txt_4c_Conta", "TextBox")
441:         WITH loc_oPag.txt_4c_Conta
442:             .Top      = 44
443:             .Left     = 235
444:             .Width    = 80
445:             .Height   = 24
446:             .Value    = ""
447:             .FontName = "Tahoma"
448:             .FontSize = 8
449:             .Visible  = .T.
450:         ENDWITH
451: 
452:         loc_oPag.AddObject("txt_4c_DConta", "TextBox")
453:         WITH loc_oPag.txt_4c_DConta
454:             .Top       = 44
455:             .Left      = 317
456:             .Width     = 290
457:             .Height    = 24
458:             .Value     = ""
459:             .ReadOnly  = .T.
460:             .FontName  = "Tahoma"
461:             .FontSize  = 8
462:             .BackColor = RGB(235, 235, 235)
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         *-- Base (N" + CHR(237) + "vel 1)
467:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
468:         WITH loc_oPag.lbl_4c_Label7
469:             .Top       = 77
470:             .Left      = 199
471:             .Width     = 32
472:             .Height    = 15
473:             .Caption   = "Base :"
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .BackStyle = 0
477:             .ForeColor = RGB(90, 90, 90)
478:             .Visible   = .T.
479:         ENDWITH
480: 
481:         loc_oPag.AddObject("txt_4c_Base", "TextBox")
482:         WITH loc_oPag.txt_4c_Base
483:             .Top      = 72
484:             .Left     = 235
485:             .Width    = 54
486:             .Height   = 24
487:             .Value    = ""
488:             .FontName = "Tahoma"
489:             .FontSize = 8
490:             .Visible  = .T.
491:         ENDWITH
492: 
493:         loc_oPag.AddObject("txt_4c_DBase", "TextBox")
494:         WITH loc_oPag.txt_4c_DBase
495:             .Top       = 72
496:             .Left      = 291
497:             .Width     = 174
498:             .Height    = 24
499:             .Value     = ""
500:             .ReadOnly  = .T.
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8
503:             .BackColor = RGB(235, 235, 235)
504:             .Visible   = .T.
505:         ENDWITH
506: 
507:         *-- Segundo N" + CHR(237) + "vel
508:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
509:         WITH loc_oPag.lbl_4c_Label6
510:             .Top       = 105
511:             .Left      = 154
512:             .Width     = 77
513:             .Height    = 15
514:             .Caption   = "Segundo N" + CHR(237) + "vel :"
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .BackStyle = 0
518:             .ForeColor = RGB(90, 90, 90)
519:             .Visible   = .T.
520:         ENDWITH
521: 
522:         loc_oPag.AddObject("txt_4c_Nvl2", "TextBox")
523:         WITH loc_oPag.txt_4c_Nvl2
524:             .Top      = 100
525:             .Left     = 235
526:             .Width    = 54
527:             .Height   = 24
528:             .Value    = ""
529:             .FontName = "Tahoma"
530:             .FontSize = 8
531:             .Visible  = .T.
532:         ENDWITH
533: 
534:         loc_oPag.AddObject("txt_4c_DNvl2", "TextBox")
535:         WITH loc_oPag.txt_4c_DNvl2
536:             .Top       = 100
537:             .Left      = 291
538:             .Width     = 174
539:             .Height    = 24
540:             .Value     = ""
541:             .ReadOnly  = .T.
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .BackColor = RGB(235, 235, 235)
545:             .Visible   = .T.
546:         ENDWITH
547: 
548:         *-- Terceiro N" + CHR(237) + "vel
549:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
550:         WITH loc_oPag.lbl_4c_Label5
551:             .Top       = 133
552:             .Left      = 157
553:             .Width     = 74
554:             .Height    = 15
555:             .Caption   = "Terceiro N" + CHR(237) + "vel :"
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .BackStyle = 0
559:             .ForeColor = RGB(90, 90, 90)
560:             .Visible   = .T.
561:         ENDWITH
562: 
563:         loc_oPag.AddObject("txt_4c_Nvl3", "TextBox")
564:         WITH loc_oPag.txt_4c_Nvl3
565:             .Top      = 128
566:             .Left     = 235
567:             .Width    = 54
568:             .Height   = 24
569:             .Value    = ""
570:             .FontName = "Tahoma"
571:             .FontSize = 8
572:             .Visible  = .T.
573:         ENDWITH
574: 
575:         loc_oPag.AddObject("txt_4c_DNvl3", "TextBox")
576:         WITH loc_oPag.txt_4c_DNvl3
577:             .Top       = 128
578:             .Left      = 291
579:             .Width     = 174
580:             .Height    = 24
581:             .Value     = ""
582:             .ReadOnly  = .T.
583:             .FontName  = "Tahoma"
584:             .FontSize  = 8
585:             .BackColor = RGB(235, 235, 235)
586:             .Visible   = .T.
587:         ENDWITH
588: 
589:         *-- Quarto N" + CHR(237) + "vel
590:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
591:         WITH loc_oPag.lbl_4c_Label8
592:             .Top       = 161
593:             .Left      = 162
594:             .Width     = 69
595:             .Height    = 15
596:             .Caption   = "Quarto N" + CHR(237) + "vel :"
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .BackStyle = 0
600:             .ForeColor = RGB(90, 90, 90)
601:             .Visible   = .T.
602:         ENDWITH
603: 
604:         loc_oPag.AddObject("txt_4c_Nvl4", "TextBox")
605:         WITH loc_oPag.txt_4c_Nvl4
606:             .Top      = 156
607:             .Left     = 235
608:             .Width    = 54
609:             .Height   = 24
610:             .Value    = ""
611:             .FontName = "Tahoma"
612:             .FontSize = 8
613:             .Visible  = .T.
614:         ENDWITH
615: 
616:         loc_oPag.AddObject("txt_4c_DNvl4", "TextBox")
617:         WITH loc_oPag.txt_4c_DNvl4
618:             .Top       = 156
619:             .Left      = 291
620:             .Width     = 174
621:             .Height    = 24
622:             .Value     = ""
623:             .ReadOnly  = .T.
624:             .FontName  = "Tahoma"
625:             .FontSize  = 8
626:             .BackColor = RGB(235, 235, 235)
627:             .Visible   = .T.
628:         ENDWITH
629: 
630:         *-- Label Localiza" + CHR(231) + CHR(245) + "es (ao lado do OptionGroup Local)
631:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
632:         WITH loc_oPag.lbl_4c_Label4
633:             .Top       = 185
634:             .Left      = 163
635:             .Width     = 68
636:             .Height    = 15
637:             .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .BackStyle = 0
641:             .ForeColor = RGB(90, 90, 90)
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         *-- OptionGroup - Tipo de localiza" + CHR(231) + CHR(227) + "o
646:         loc_oPag.AddObject("obj_4c_OptLocal", "OptionGroup")
647:         WITH loc_oPag.obj_4c_OptLocal
648:             .Top         = 180
649:             .Left        = 231
650:             .Width       = 347
651:             .Height      = 26
652:             .ButtonCount = 4
653:             .BackStyle   = 0
654:             .BorderStyle = 0
655:             .Visible     = .T.
656:             .Value       = 1
657:             WITH .Buttons(1)
658:                 .Caption   = "Todos"
659:                 .Width     = 82
660:                 .Height    = 18
661:                 .Top       = 4
662:                 .Left      = 2
663:                 .AutoSize  = .F.
664:                 .ForeColor = RGB(90, 90, 90)
665:             ENDWITH
666:             WITH .Buttons(2)
667:                 .Caption   = "Contados"
668:                 .Width     = 82
669:                 .Height    = 18
670:                 .Top       = 4
671:                 .Left      = 87
672:                 .AutoSize  = .F.
673:                 .FontName  = "Tahoma"
674:                 .FontSize  = 8
675:                 .ForeColor = RGB(90, 90, 90)
676:             ENDWITH
677:             WITH .Buttons(3)
678:                 .Caption   = "N" + CHR(227) + "o Contados"
679:                 .Width     = 90
680:                 .Height    = 18
681:                 .Top       = 4
682:                 .Left      = 172
683:                 .AutoSize  = .F.
684:                 .FontName  = "Tahoma"
685:                 .FontSize  = 8
686:                 .ForeColor = RGB(90, 90, 90)
687:             ENDWITH
688:             WITH .Buttons(4)
689:                 .Caption   = "Divergentes"
690:                 .Width     = 82
691:                 .Height    = 18
692:                 .Top       = 4
693:                 .Left      = 265
694:                 .AutoSize  = .F.
695:                 .FontName  = "Tahoma"
696:                 .FontSize  = 8
697:                 .ForeColor = RGB(90, 90, 90)
698:             ENDWITH
699:         ENDWITH
700: 
701:         *-- Label Ordena" + CHR(231) + CHR(227) + "o (ao lado do OptionGroup Ordem)
702:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
703:         WITH loc_oPag.lbl_4c_Label9
704:             .Top       = 209
705:             .Left      = 169
706:             .Width     = 62
707:             .Height    = 15
708:             .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .BackStyle = 0
712:             .ForeColor = RGB(90, 90, 90)
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         *-- OptionGroup - Crit" + CHR(233) + "rio de ordena" + CHR(231) + CHR(227) + "o
717:         loc_oPag.AddObject("obj_4c_OptOrdem", "OptionGroup")
718:         WITH loc_oPag.obj_4c_OptOrdem
719:             .Top         = 204
720:             .Left        = 231
721:             .Width       = 432
722:             .Height      = 26
723:             .ButtonCount = 4
724:             .BackStyle   = 0
725:             .BorderStyle = 0
726:             .Visible     = .T.
727:             .Value       = 1
728:             WITH .Buttons(1)
729:                 .Caption   = "Local"
730:                 .Width     = 104
731:                 .Height    = 18
732:                 .Top       = 4
733:                 .Left      = 2
734:                 .AutoSize  = .F.
735:                 .ForeColor = RGB(90, 90, 90)
736:             ENDWITH
737:             WITH .Buttons(2)
738:                 .Caption   = "N" + CHR(237) + "vel 2"
739:                 .Width     = 104
740:                 .Height    = 18
741:                 .Top       = 4
742:                 .Left      = 109
743:                 .AutoSize  = .F.
744:                 .FontName  = "Tahoma"
745:                 .FontSize  = 8
746:                 .ForeColor = RGB(90, 90, 90)
747:             ENDWITH
748:             WITH .Buttons(3)
749:                 .Caption   = "N" + CHR(237) + "vel 3"
750:                 .Width     = 104
751:                 .Height    = 18
752:                 .Top       = 4
753:                 .Left      = 216
754:                 .AutoSize  = .F.
755:                 .FontName  = "Tahoma"
756:                 .FontSize  = 8
757:                 .ForeColor = RGB(90, 90, 90)
758:             ENDWITH
759:             WITH .Buttons(4)
760:                 .Caption   = "N" + CHR(237) + "vel 4"
761:                 .Width     = 104
762:                 .Height    = 18
763:                 .Top       = 4
764:                 .Left      = 323
765:                 .AutoSize  = .F.
766:                 .FontName  = "Tahoma"
767:                 .FontSize  = 8
768:                 .ForeColor = RGB(90, 90, 90)
769:             ENDWITH


### BO (C:\4c\projeto\app\classes\sigrecntBO.prg):
*==============================================================================
* SIGRECNTBO.PRG
* Business Object para Relatorio de Contagem por Localizacao
*
* Herda de: RelatorioBase
* Form: Formsigrecnt.prg
* Relatorio original: sigrecnt.SCX / SigReCnt.FRX
*==============================================================================

DEFINE CLASS sigrecntBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCnt"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cBase              = ""
    this_cNvl2              = ""
    this_cNvl3              = ""
    this_cNvl4              = ""
    this_cCods              = ""
    this_nOptLocal          = 0
    this_nOptOrdem          = 0

    *-- Estado / controle
    this_lVisualizaCtg      = .F.
    this_cGrPadVens         = ""

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                     "Contagem por Localiza" + CHR(231) + CHR(227) + "o"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega GrPadVens e cursores de nivel para o form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cSQL = "SELECT TOP 1 GrPadVens FROM SigCdPam " + ;
                           "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_LocalPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrPadVens = ALLTRIM(NVL(cursor_4c_LocalPam.GrPadVens, ""))
                    ENDIF
                ENDIF

                IF EMPTY(THIS.this_cGrPadVens)
                    THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores " + ;
                        "N" + CHR(227) + "o Est" + CHR(225) + " Configurado nos " + ;
                        "Par" + CHR(226) + "metros do Sistema."
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv1", "cursor_4c_SigLcNv1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 1"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv2", "cursor_4c_SigLcNv2")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 2"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv3", "cursor_4c_SigLcNv3")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 3"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv4", "cursor_4c_SigLcNv4")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 4"
                    EXIT
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida parametros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio de contagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lcLocalizacao, loc_lcBase, loc_lcNvl2, loc_lcNvl3, loc_lcNvl4
        LOCAL loc_lcVends, loc_lnLocal, loc_lnOrdem, loc_lcCods
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2
        LOCAL loc_lcNvl3Tmp
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                loc_lcBase        = ALLTRIM(THIS.this_cBase)
                loc_lcNvl2        = ALLTRIM(THIS.this_cNvl2)
                loc_lcNvl3        = ALLTRIM(THIS.this_cNvl3)
                loc_lcNvl4        = ALLTRIM(THIS.this_cNvl4)
                loc_lcLocalizacao = loc_lcBase + loc_lcNvl2 + loc_lcNvl3 + loc_lcNvl4
                loc_lcVends       = ALLTRIM(THIS.this_cConta)
                loc_lnLocal       = THIS.this_nOptLocal
                loc_lnOrdem       = THIS.this_nOptOrdem
                loc_lcCods        = ALLTRIM(THIS.this_cCods)

                loc_cDtI = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 00:00:00', 120)"
                loc_cDtF = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 23:59:59', 120)"

                IF USED("csRel")
                    USE IN csRel
                ENDIF
                IF USED("crRel")
                    USE IN crRel
                ENDIF
                IF USED("crTmpLocal")
                    USE IN crTmpLocal
                ENDIF
                IF USED("crSigCdCnl")
                    USE IN crSigCdCnl
                ENDIF
                IF USED("csTotLocal")
                    USE IN csTotLocal
                ENDIF
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF

                CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

                loc_lcEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

                loc_lcTitulo  = "Rela" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
                loc_lcTitulo2 = IIF(!EMPTY(THIS.this_cConta), ;
                    "Vendedor - " + THIS.this_cConta + " " + THIS.this_cDConta, "")
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                    VALUES (loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2)

                *-- Contagens realizadas (sigcdcnl + sigcdcni)
                loc_cSQL = "SELECT a.cods, a.datas, a.vends, a.emps, b.locals, b.qtds, b.estoque " + ;
                           "FROM sigcdcnl a " + ;
                           "JOIN sigcdcni b ON a.cods = b.cods " + ;
                           "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

                IF !EMPTY(loc_lcCods)
                    loc_cSQL = loc_cSQL + " AND A.Cods = " + EscaparSQL(loc_lcCods)
                ENDIF
                IF !EMPTY(loc_lcVends)
                    loc_cSQL = loc_cSQL + " AND A.Vends = " + EscaparSQL(loc_lcVends)
                ENDIF
                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND b.locals LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar contagens."
                    EXIT
                ENDIF

                SELECT crSigCdCnl
                INDEX ON Locals TAG Locals
                GO TOP

                IF RECCOUNT("crSigCdCnl") = 0
                    THIS.this_cMensagemErro = "Nenhuma contagem encontrada para os filtros informados."
                    EXIT
                ENDIF

                *-- Estoque por localizacao (SigOpEtq UNION ALL SigMvesl)
                loc_cSQL = "SELECT localizas, grupos, contas, empos, Sum(Qtde) AS qtde, " + ;
                           "CONVERT(NUMERIC(5,0), 0) AS QtdCtg " + ;
                           "FROM (" + ;
                           " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
                           " FROM SigOpEtq A " + ;
                           " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
                           "  ON b.cpros = a.cpros " + ;
                           " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.contas NOT IN ('15000100','15000141') " + ;
                           " GROUP BY A.localizas, a.grupos, a.contas, a.empos " + ;
                           " UNION ALL " + ;
                           " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
                           " FROM SigMvesl a, SigCdpro b " + ;
                           " WHERE a.CPros = b.Cpros " + ;
                           " AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.estos NOT IN ('15000100','15000141') " + ;
                           " AND a.cpros + a.locals NOT IN " + ;
                           "  (SELECT cpros + localizas FROM sigopetq) " + ;
                           " GROUP BY a.locals, a.grupos, a.estos, a.emps" + ;
                           ") a WHERE Grupos <> SPACE(10)"

                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND a.localizas LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_cSQL = loc_cSQL + ;
                           " GROUP BY localizas, grupos, contas, empos" + ;
                           " HAVING SUM(qtde) <> 0"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLocal")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoque por localiza" + ;
                                              CHR(231) + CHR(227) + "o."
                    EXIT
                ENDIF

                *-- Filtra crTmpLocal: manter apenas localizacoes com contagem
                SELECT crTmpLocal
                GO TOP
                SCAN
                    IF !SEEK(crTmpLocal.localizas, "crSigCdCnl", "Locals")
                        DELETE
                        LOOP
                    ENDIF
                    SELECT crTmpLocal
                ENDSCAN

                SELECT Localizas, SUM(Qtde) AS Qtds ;
                    FROM crTmpLocal WHERE 0=0 ;
                    GROUP BY Localizas ;
                    INTO CURSOR csTotLocal READWRITE

                IF RECCOUNT("csTotLocal") = 0
                    THIS.this_cMensagemErro = "Nenhum estoque encontrado para as " + ;
                        "localiza" + CHR(231) + CHR(245) + "es contadas."
                    EXIT
                ENDIF

                SELECT csTotLocal
                INDEX ON Localizas TAG Locals
                GO TOP

                *-- Gera cursor de resultado conforme OptLocal
                DO CASE
                CASE loc_lnLocal = 1
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 2
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crSigCdCnl a ;
                        LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 3
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) = 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 4
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> ;
                            IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;
                        INTO CURSOR csRel READWRITE
                ENDCASE

                *-- Agrega resultado final com campos de nivel decompostos
                SELECT Datas, Locals, Vends, Empos, Localizas, ;
                    SUM(Qtds) AS Qtds, SUM(Qtde) AS Qtde, ;
                    SPACE(100) AS Descr, ;
                    LEFT(Locals, 2) AS Nivel1s, ;
                    SUBSTR(Locals, 3, 2) AS Nivel2s, ;
                    SUBSTR(Locals, 5, 2) AS Nivel3s, ;
                    SUBSTR(Locals, 7, 3) AS Nivel4s ;
                    FROM csRel ;
                    GROUP BY Datas, Locals, Vends, Empos, Localizas ;
                    INTO CURSOR crRel READWRITE

                *-- Enriquece descricao com nivel 3
                IF !USED("cursor_4c_SigLcNv3")
                    SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigLcNv3", "cursor_4c_SigLcNv3")
                ENDIF

                SELECT crRel
                INDEX ON Vends + Locals TAG Locals
                GO TOP
                SCAN
                    loc_lcNvl3Tmp = SUBSTR(crRel.Locals, 5, 2)
                    IF !EMPTY(loc_lcNvl3Tmp)
                        SELECT cursor_4c_SigLcNv3
                        LOCATE FOR ALLTRIM(Cods) = ALLTRIM(loc_lcNvl3Tmp)
                        IF FOUND()
                            REPLACE Descr WITH ALLTRIM(cursor_4c_SigLcNv3.Descs) IN crRel
                        ENDIF
                    ENDIF
                    SELECT crRel
                ENDSCAN

                *-- Aplica ordenacao final
                SELECT crRel
                DO CASE
                CASE loc_lnOrdem = 1
                    INDEX ON Locals TAG Locals
                CASE loc_lnOrdem = 2
                    INDEX ON Nivel2s TAG Nivel2s
                CASE loc_lnOrdem = 3
                    INDEX ON Nivel3s TAG Nivel3s
                CASE loc_lnOrdem = 4
                    INDEX ON Nivel4s TAG Nivel4s
                ENDCASE
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e exporta para planilha Excel
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                    "contagem_localizacao", "xls")
                IF !EMPTY(loc_cArquivo)
                    SELECT crRel
                    COPY TO (loc_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem, o unico
    * parametro persistido eh GrPadVens, usado nos lookups de vendedor.
    * Retorna .T. se carregou, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Localizacao eh apenas leitura: consulta SigCdCnl/SigCdCnI/
    * SigOpEtq/SigMvesl e gera preview via REPORT FORM. Retorna .F. para
    * satisfazer contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto pela
    * data, empresa e filtro de localizacao) para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCNT|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cBase) + ;
                     ALLTRIM(THIS.this_cNvl2) + ;
                     ALLTRIM(THIS.this_cNvl3) + ;
                     ALLTRIM(THIS.this_cNvl4)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de execucao do relatorio na
    * tabela LogAuditoria (Empresa, Usuario, DataHora, Operacao, Detalhes).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.
        IF EMPTY(par_cOperacao)
            par_cOperacao = "VISUALIZAR"
        ENDIF
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Empresa, Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("Relatorio_Contagem") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cTituloRelatorio) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

