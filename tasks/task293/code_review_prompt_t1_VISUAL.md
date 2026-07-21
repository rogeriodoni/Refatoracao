# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [ALINHAMENTO] Botao 'cmd_4c_Voltar' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_Voltar' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_Voltar' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_Voltar' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)
- [ALINHAMENTO] Botao 'cmd_4c_Voltar' tem Top=12 mas grupo usa Top=2 (diferenca de 10px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3954 linhas total):

*-- Linhas 93 a 105:
93:             IF THIS.this_oBusinessObject.this_lReserva
94:                 loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
95:             ENDIF
96:             THIS.Caption = loc_cCaption
97: 
98:             *-- Atualiza labels do cabecalho
99:             THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
100:             THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
101: 
102:             *-- Obtem SigKey do cursor CrSigCdPac (passado pelo form pai)
103:             IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
104:                 THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
105:             ENDIF

*-- Linhas 148 a 206:
148:             THIS.AddObject("pgf_4c_1", "PageFrame")
149: 
150:             WITH THIS.pgf_4c_1
151:                 .Top       = -27
152:                 .Left      = -1
153:                 .Width     = 1004
154:                 .Height    = 629
155:                 .PageCount = 6
156:                 .Tabs      = .F.
157:                 .Visible   = .F.
158: 
159:                 WITH .Page1
160:                     .FontBold  = .T.
161:                     .ForeColor = RGB(0, 128, 192)
162:                     .Caption   = "Dados"
163:                     .Picture   = loc_cBg
164:                 ENDWITH
165: 
166:                 WITH .Page2
167:                     .FontBold  = .T.
168:                     .ForeColor = RGB(0, 128, 192)
169:                     .Caption   = "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
170:                     .Picture   = loc_cBg
171:                 ENDWITH
172: 
173:                 WITH .Page3
174:                     .FontBold  = .T.
175:                     .ForeColor = RGB(0, 128, 192)
176:                     .Caption   = "Totais por Linha"
177:                     .Picture   = loc_cBg
178:                     .Enabled   = .F.
179:                 ENDWITH
180: 
181:                 WITH .Page4
182:                     .FontBold   = .T.
183:                     .FontItalic = .T.
184:                     .ForeColor  = RGB(0, 128, 192)
185:                     .Caption    = "Selecionar Estoque"
186:                     .Picture    = loc_cBg
187:                     .Enabled    = .F.
188:                 ENDWITH
189: 
190:                 WITH .Page5
191:                     .FontBold  = .T.
192:                     .ForeColor = RGB(0, 128, 192)
193:                     .Caption   = "Disponivel/Tamanho"
194:                     .Picture   = loc_cBg
195:                     .Enabled   = .F.
196:                 ENDWITH
197: 
198:                 WITH .Page6
199:                     .FontBold  = .T.
200:                     .ForeColor = RGB(0, 128, 192)
201:                     .Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
202:                     .Picture   = loc_cBg
203:                     .Enabled   = .F.
204:                 ENDWITH
205:             ENDWITH
206: 

*-- Linhas 243 a 324:
243:             *-- Cabecalho cinza com labels sobrepostas (efeito sombra)
244:             loc_oPage.AddObject("cnt_4c_Sombra", "Container")
245:             WITH loc_oPage.cnt_4c_Sombra
246:                 .Top        = -1
247:                 .Left       = 0
248:                 .Width      = THIS.Width
249:                 .Height     = 80
250:                 .BorderWidth = 0
251:                 .BackColor  = RGB(100, 100, 100)
252:                 .BackStyle  = 1
253:                 .Visible    = .F.
254: 
255:                 .AddObject("lbl_4c_LblSombra", "Label")
256:                 WITH .lbl_4c_LblSombra
257:                     .FontBold      = .T.
258:                     .FontName      = "Tahoma"
259:                     .FontSize      = 18
260:                     .FontUnderline = .F.
261:                     .WordWrap      = .T.
262:                     .Alignment     = 0
263:                     .BackStyle     = 0
264:                     .Top           = 18
265:                     .Left          = 13
266:                     .Width         = THIS.Width
267:                     .Height        = 40
268:                     .ForeColor     = RGB(0, 0, 0)
269:                     .AutoSize      = .F.
270:                     .Caption       = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
271:                 ENDWITH
272: 
273:                 .AddObject("lbl_4c_LblTitulo", "Label")
274:                 WITH .lbl_4c_LblTitulo
275:                     .FontBold  = .T.
276:                     .FontName  = "Tahoma"
277:                     .FontSize  = 18
278:                     .WordWrap  = .T.
279:                     .Alignment = 0
280:                     .BackStyle = 0
281:                     .Top       = 17
282:                     .Left      = 13
283:                     .Width     = THIS.Width
284:                     .Height    = 46
285:                     .ForeColor = RGB(255, 255, 255)
286:                     .AutoSize  = .F.
287:                     .Caption   = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
288:                 ENDWITH
289:             ENDWITH
290: 
291:             *-- Container barra info (Container5) - campos adicionados na Fase 5
292:             loc_oPage.AddObject("cnt_4c_Container5", "Container")
293:             WITH loc_oPage.cnt_4c_Container5
294:                 .Top       = 129
295:                 .Left      = 45
296:                 .Width     = 909
297:                 .Height    = 40
298:                 .BackStyle = 0
299:                 .Visible   = .F.
300:             ENDWITH
301: 
302:             *-- Container estoque disponivel (Container3) - grid adicionado na Fase 4
303:             loc_oPage.AddObject("cnt_4c_Container3", "Container")
304:             WITH loc_oPage.cnt_4c_Container3
305:                 .Top           = 371
306:                 .Left          = 63
307:                 .Width         = 454
308:                 .Height        = 186
309:                 .SpecialEffect = 0
310:                 .BackColor     = RGB(255, 255, 255)
311:                 .BackStyle     = 1
312:                 .Visible       = .F.
313:             ENDWITH
314: 
315:             *-- Container estoque em producao (Container1) - grid adicionado na Fase 4
316:             loc_oPage.AddObject("cnt_4c_Container1", "Container")
317:             WITH loc_oPage.cnt_4c_Container1
318:                 .Top           = 371
319:                 .Left          = 523
320:                 .Width         = 385
321:                 .Height        = 136
322:                 .SpecialEffect = 0
323:                 .BackColor     = RGB(255, 255, 255)
324:                 .BackStyle     = 1

*-- Linhas 346 a 560:
346:             loc_oPage.grd_4c_GradeItens2.ColumnCount  = 10
347:             loc_oPage.grd_4c_GradeItens2.RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
348:             WITH loc_oPage.grd_4c_GradeItens2
349:                 .Top          = 181
350:                 .Left         = 53
351:                 .Width        = 703
352:                 .Height       = 189
353:                 .RecordMark   = .F.
354:                 .DeleteMark   = .F.
355:                 .Visible      = .F.
356: 
357:                 WITH .Column1
358:                     .Header1.Caption = "Produto"
359:                     .ControlSource   = "TmpFinal.Cpros"
360:                     .Width           = 90
361:                     .ReadOnly        = .T.
362:                 ENDWITH
363:                 WITH .Column2
364:                     .Header1.Caption = "Cor"
365:                     .ControlSource   = "TmpFinal.CodCors"
366:                     .Width           = 35
367:                     .ReadOnly        = .T.
368:                 ENDWITH
369:                 WITH .Column3
370:                     .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
371:                     .ControlSource   = "TmpFinal.Dopes"
372:                     .Width           = 60
373:                     .ReadOnly        = .T.
374:                 ENDWITH
375:                 WITH .Column4
376:                     .Header1.Caption = "N" + CHR(250) + "mero"
377:                     .ControlSource   = "TmpFinal.Nops"
378:                     .Width           = 50
379:                     .ReadOnly        = .T.
380:                 ENDWITH
381:                 WITH .Column5
382:                     .Header1.Caption = "Quantidade"
383:                     .ControlSource   = "TmpFinal.Saldo"
384:                     .Width           = 62
385:                     .ReadOnly        = .T.
386:                     .Text1.Alignment = 1
387:                 ENDWITH
388:                 WITH .Column6
389:                     .Header1.Caption = "Produzir"
390:                     .ControlSource   = "TmpFinal.Produzir"
391:                     .Width           = 57
392:                     .ReadOnly        = .T.
393:                     .Text1.Alignment = 1
394:                 ENDWITH
395:                 WITH .Column7
396:                     .Header1.Caption = "Estoque"
397:                     .ControlSource   = "TmpFinal.Estoque"
398:                     .Width           = 62
399:                     .ReadOnly        = .F.
400:                     .Text1.Alignment = 1
401:                 ENDWITH
402:                 WITH .Column8
403:                     .Header1.Caption = "Obs"
404:                     .ControlSource   = "TmpFinal.CodObs"
405:                     .Width           = 60
406:                     .ReadOnly        = .T.
407:                 ENDWITH
408:                 WITH .Column9
409:                     .Header1.Caption = "Tam"
410:                     .ControlSource   = "TmpFinal.CodTams"
411:                     .Width           = 33
412:                     .ReadOnly        = .T.
413:                 ENDWITH
414:                 WITH .Column10
415:                     .Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
416:                     .ControlSource   = "TmpFinal.Fabrs"
417:                     .Width           = 62
418:                     .ReadOnly        = .F.
419:                     .Text1.Alignment = 1
420:                 ENDWITH
421:             ENDWITH
422:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeItens2)
423: 
424:             loc_oPage.AddObject("lbl_4c_LblTotais", "Label")
425:             WITH loc_oPage.lbl_4c_LblTotais
426:                 .Top       = 372
427:                 .Left      = 403
428:                 .Width     = 42
429:                 .Height    = 17
430:                 .Caption   = "Totais :"
431:                 .BackStyle = 0
432:                 .Visible   = .F.
433:             ENDWITH
434: 
435:             loc_oPage.AddObject("txt_4c_Tot_Qtd", "TextBox")
436:             WITH loc_oPage.txt_4c_Tot_Qtd
437:                 .Top       = 370
438:                 .Left      = 449
439:                 .Width     = 68
440:                 .Height    = 19
441:                 .ReadOnly  = .T.
442:                 .Alignment = 1
443:                 .Visible   = .F.
444:             ENDWITH
445: 
446:             loc_oPage.AddObject("txt_4c_Tot_Est", "TextBox")
447:             WITH loc_oPage.txt_4c_Tot_Est
448:                 .Top       = 370
449:                 .Left      = 516
450:                 .Width     = 67
451:                 .Height    = 19
452:                 .ReadOnly  = .T.
453:                 .Alignment = 1
454:                 .Visible   = .F.
455:             ENDWITH
456: 
457:             loc_oPage.AddObject("txt_4c_Tot_prc", "TextBox")
458:             WITH loc_oPage.txt_4c_Tot_prc
459:                 .Top       = 370
460:                 .Left      = 581
461:                 .Width     = 67
462:                 .Height    = 19
463:                 .ReadOnly  = .T.
464:                 .Alignment = 1
465:                 .Visible   = .F.
466:             ENDWITH
467: 
468:             loc_oPage.AddObject("txt_4c_Tot_Prz", "TextBox")
469:             WITH loc_oPage.txt_4c_Tot_Prz
470:                 .Top       = 370
471:                 .Left      = 648
472:                 .Width     = 67
473:                 .Height    = 19
474:                 .ReadOnly  = .T.
475:                 .Alignment = 1
476:                 .Visible   = .F.
477:             ENDWITH
478: 
479:             loc_oPage.AddObject("img_4c_ImgFigJpg", "Image")
480:             WITH loc_oPage.img_4c_ImgFigJpg
481:                 .Top     = 394
482:                 .Left    = 73
483:                 .Width   = 135
484:                 .Height  = 92
485:                 .Stretch = 2
486:                 .Visible = .F.
487:             ENDWITH
488: 
489:             loc_oPage.AddObject("edt_4c_ObsItens", "EditBox")
490:             WITH loc_oPage.edt_4c_ObsItens
491:                 .Top           = 415
492:                 .Left          = 221
493:                 .Width         = 396
494:                 .Height        = 69
495:                 .ControlSource = IIF(USED("TmpFinal"), "TmpFinal.CodObs", "")
496:                 .ReadOnly      = .T.
497:                 .Visible       = .F.
498:             ENDWITH
499: 
500:             loc_oPage.AddObject("lbl_4c_Txt_ObsItens", "Label")
501:             WITH loc_oPage.lbl_4c_Txt_ObsItens
502:                 .Top       = 400
503:                 .Left      = 221
504:                 .Width     = 119
505:                 .Height    = 17
506:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
507:                 .BackStyle = 0
508:                 .Visible   = .F.
509:             ENDWITH
510: 
511:             loc_oPage.AddObject("lbl_4c_LblQtdSel", "Label")
512:             WITH loc_oPage.lbl_4c_LblQtdSel
513:                 .Top       = 164
514:                 .Left      = 383
515:                 .Width     = 119
516:                 .Height    = 15
517:                 .Caption   = "Qtd Selecionada : "
518:                 .BackStyle = 0
519:                 .Visible   = .F.
520:             ENDWITH
521: 
522:             loc_oPage.AddObject("txt_4c_Tot_sEst", "TextBox")
523:             WITH loc_oPage.txt_4c_Tot_sEst
524:                 .Top       = 162
525:                 .Left      = 501
526:                 .Width     = 67
527:                 .Height    = 19
528:                 .ReadOnly  = .T.
529:                 .Alignment = 1
530:                 .Visible   = .F.
531:             ENDWITH
532: 
533:             loc_oPage.AddObject("txt_4c_Tot_sPrc", "TextBox")
534:             WITH loc_oPage.txt_4c_Tot_sPrc
535:                 .Top       = 162
536:                 .Left      = 567
537:                 .Width     = 67
538:                 .Height    = 19
539:                 .ReadOnly  = .T.
540:                 .Alignment = 1
541:                 .Visible   = .F.
542:             ENDWITH
543: 
544:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
545:             WITH loc_oPage.cmd_4c_Voltar
546:                 .Top         = 12
547:                 .Left        = 704
548:                 .Width       = 75
549:                 .Height      = 75
550:                 .Caption     = "Voltar"
551:                 .FontName    = "Tahoma"
552:                 .FontSize    = 8
553:                 .Themes      = .T.
554:                 .Visible     = .F.
555:                 .ToolTipText = "Voltar"
556:             ENDWITH
557: 
558:             loc_oGrid = loc_oPage.grd_4c_GradeItens2
559:             BINDEVENT(loc_oGrid,                "AfterRowColChange", THIS, "P2GradeAfterRowColChange")
560:             BINDEVENT(loc_oGrid.Column1.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")

*-- Linhas 569 a 1184:
569:             BINDEVENT(loc_oGrid.Column7.Text1,  "Valid",             THIS, "P2ColC7Valid")
570:             BINDEVENT(loc_oGrid.Column7.Text1,  "KeyPress",         THIS, "P2ColC7LostFocus")
571:             BINDEVENT(loc_oGrid.Column10.Text1, "When",              THIS, "P2ColC10When")
572:             BINDEVENT(loc_oGrid.Column10.Text1, "Valid",             THIS, "P2ColC10Valid")
573:             BINDEVENT(loc_oGrid.Column10.Text1, "KeyPress",         THIS, "P2ColC10LostFocus")
574:             BINDEVENT(loc_oPage.cmd_4c_Voltar,  "Click",             THIS, "BtnVoltarPage2Click")
575:             BINDEVENT(loc_oPage,                "Activate",          THIS, "Pagina2Activate")
576: 
577:         CATCH TO loc_oErro
578:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 2: " + loc_oErro.Message, "Erro")
579:         ENDTRY
580:     ENDPROC
581: 
582:     *--------------------------------------------------------------------------
583:     * ConfigurarPagina3 - Totais por Linha (TmpLinha)
584:     *--------------------------------------------------------------------------
585:     PROTECTED PROCEDURE ConfigurarPagina3()
586: 
587:         LOCAL loc_oPage
588: 
589:         TRY
590:             loc_oPage = THIS.pgf_4c_1.Page3
591: 
592:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
593:             WITH loc_oPage.shp_4c_Shape4
594:                 .Top     = 169
595:                 .Left    = 168
596:                 .Width   = 437
597:                 .Height  = 2
598:                 .Visible = .F.
599:             ENDWITH
600: 
601:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
602:             WITH loc_oPage.lbl_4c_Label2
603:                 .Top       = 147
604:                 .Left      = 173
605:                 .Width     = 157
606:                 .Height    = 25
607:                 .Caption   = "Totais por Linha"
608:                 .BackStyle = 0
609:                 .FontBold  = .T.
610:                 .Visible   = .F.
611:             ENDWITH
612: 
613:             loc_oPage.AddObject("grd_4c_GradeLinhas", "Grid")
614:             loc_oPage.grd_4c_GradeLinhas.ColumnCount  = 5
615:             loc_oPage.grd_4c_GradeLinhas.RecordSource = IIF(USED("TmpLinha"), "TmpLinha", "")
616:             WITH loc_oPage.grd_4c_GradeLinhas
617:                 .Top          = 181
618:                 .Left         = 167
619:                 .Width        = 438
620:                 .Height       = 292
621:                 .RecordMark   = .F.
622:                 .DeleteMark   = .F.
623:                 .ReadOnly     = .T.
624:                 .Visible      = .F.
625: 
626:                 WITH .Column1
627:                     .Header1.Caption = "Linha"
628:                     .ControlSource   = "TmpLinha.Linhas"
629:                     .Width           = 80
630:                 ENDWITH
631:                 WITH .Column2
632:                     .Header1.Caption = "Quantidade"
633:                     .ControlSource   = "TmpLinha.Saldo"
634:                     .Width           = 74
635:                     .Text1.Alignment = 1
636:                 ENDWITH
637:                 WITH .Column3
638:                     .Header1.Caption = "Estoque"
639:                     .ControlSource   = "TmpLinha.Estoque"
640:                     .Width           = 74
641:                     .Text1.Alignment = 1
642:                 ENDWITH
643:                 WITH .Column4
644:                     .Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
645:                     .ControlSource   = "TmpLinha.Fabrs"
646:                     .Width           = 74
647:                     .Text1.Alignment = 1
648:                 ENDWITH
649:                 WITH .Column5
650:                     .Header1.Caption = "Produzir"
651:                     .ControlSource   = "TmpLinha.Produzir"
652:                     .Width           = 74
653:                     .Text1.Alignment = 1
654:                 ENDWITH
655:             ENDWITH
656:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeLinhas)
657: 
658:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
659:             WITH loc_oPage.cmd_4c_Voltar
660:                 .Top         = 12
661:                 .Left        = 704
662:                 .Width       = 75
663:                 .Height      = 75
664:                 .Caption     = "Voltar"
665:                 .FontName    = "Tahoma"
666:                 .FontSize    = 8
667:                 .Themes      = .T.
668:                 .Visible     = .F.
669:                 .ToolTipText = "Voltar"
670:             ENDWITH
671: 
672:             BINDEVENT(loc_oPage.cmd_4c_Voltar, "Click", THIS, "BtnVoltarPage3Click")
673: 
674:         CATCH TO loc_oErro
675:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 3: " + loc_oErro.Message, "Erro")
676:         ENDTRY
677:     ENDPROC
678: 
679:     *--------------------------------------------------------------------------
680:     * ConfigurarPagina4 - Selecionar Estoque por Grupo/Conta (TmpDisp)
681:     *--------------------------------------------------------------------------
682:     PROTECTED PROCEDURE ConfigurarPagina4()
683: 
684:         LOCAL loc_oPage, loc_oGrid
685: 
686:         TRY
687:             loc_oPage = THIS.pgf_4c_1.Page4
688: 
689:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
690:             WITH loc_oPage.shp_4c_Shape4
691:                 .Top     = 159
692:                 .Left    = 191
693:                 .Width   = 370
694:                 .Height  = 2
695:                 .Visible = .F.
696:             ENDWITH
697: 
698:             loc_oPage.AddObject("lbl_4c_Label1", "Label")
699:             WITH loc_oPage.lbl_4c_Label1
700:                 .Top       = 138
701:                 .Left      = 197
702:                 .Width     = 184
703:                 .Height    = 25
704:                 .Caption   = "Selecionar Estoque"
705:                 .BackStyle = 0
706:                 .FontBold  = .T.
707:                 .Visible   = .F.
708:             ENDWITH
709: 
710:             loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
711:             WITH loc_oPage.txt_4c_Cpros
712:                 .Top      = 138
713:                 .Left     = 479
714:                 .Width    = 80
715:                 .Height   = 19
716:                 .ReadOnly = .T.
717:                 .Visible  = .F.
718:             ENDWITH
719: 
720:             loc_oPage.AddObject("grd_4c_GradeDisp", "Grid")
721:             loc_oPage.grd_4c_GradeDisp.ColumnCount  = 5
722:             loc_oPage.grd_4c_GradeDisp.RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
723:             WITH loc_oPage.grd_4c_GradeDisp
724:                 .Top          = 169
725:                 .Left         = 191
726:                 .Width        = 370
727:                 .Height       = 244
728:                 .RecordMark   = .F.
729:                 .DeleteMark   = .F.
730:                 .Visible      = .F.
731: 
732:                 WITH .Column1
733:                     .Header1.Caption = "Grupo"
734:                     .ControlSource   = "TmpDisp.Grupos"
735:                     .Width           = 60
736:                     .ReadOnly        = .T.
737:                 ENDWITH
738:                 WITH .Column2
739:                     .Header1.Caption = "Conta"
740:                     .ControlSource   = "TmpDisp.Estos"
741:                     .Width           = 60
742:                     .ReadOnly        = .T.
743:                 ENDWITH
744:                 WITH .Column3
745:                     .Header1.Caption = "Prior"
746:                     .ControlSource   = "TmpDisp.Priors"
747:                     .Width           = 55
748:                     .ReadOnly        = .T.
749:                     .Text1.Alignment = 1
750:                 ENDWITH
751:                 WITH .Column4
752:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
753:                     .ControlSource   = "TmpDisp.Disps"
754:                     .Width           = 65
755:                     .ReadOnly        = .T.
756:                     .Text1.Alignment = 1
757:                 ENDWITH
758:                 WITH .Column5
759:                     .Header1.Caption = "Utilizar"
760:                     .ControlSource   = "TmpDisp.Utilizar"
761:                     .Width           = 65
762:                     .ReadOnly        = .F.
763:                     .Text1.Alignment = 1
764:                 ENDWITH
765:             ENDWITH
766:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)
767: 
768:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
769:             WITH loc_oPage.lbl_4c_Label2
770:                 .Top       = 418
771:                 .Left      = 220
772:                 .Width     = 82
773:                 .Height    = 16
774:                 .Caption   = "Qtde Pedida : "
775:                 .BackStyle = 0
776:                 .Visible   = .F.
777:             ENDWITH
778: 
779:             loc_oPage.AddObject("lbl_4c_Label3", "Label")
780:             WITH loc_oPage.lbl_4c_Label3
781:                 .Top       = 437
782:                 .Left      = 192
783:                 .Width     = 110
784:                 .Height    = 16
785:                 .Caption   = "Qtde Selecionada : "
786:                 .BackStyle = 0
787:                 .Visible   = .F.
788:             ENDWITH
789: 
790:             loc_oPage.AddObject("txt_4c_Qt_pedida", "TextBox")
791:             WITH loc_oPage.txt_4c_Qt_pedida
792:                 .Top       = 413
793:                 .Left      = 312
794:                 .Width     = 67
795:                 .Height    = 23
796:                 .ReadOnly  = .T.
797:                 .Alignment = 1
798:                 .Visible   = .F.
799:             ENDWITH
800: 
801:             loc_oPage.AddObject("txt_4c_Qt_Selec", "TextBox")
802:             WITH loc_oPage.txt_4c_Qt_Selec
803:                 .Top       = 436
804:                 .Left      = 312
805:                 .Width     = 67
806:                 .Height    = 23
807:                 .ReadOnly  = .T.
808:                 .Alignment = 1
809:                 .Visible   = .F.
810:             ENDWITH
811: 
812:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
813:             WITH loc_oPage.cmd_4c_Voltar
814:                 .Top         = 12
815:                 .Left        = 704
816:                 .Width       = 75
817:                 .Height      = 75
818:                 .Caption     = "Voltar"
819:                 .FontName    = "Tahoma"
820:                 .FontSize    = 8
821:                 .Themes      = .T.
822:                 .Visible     = .F.
823:                 .ToolTipText = "Voltar"
824:             ENDWITH
825: 
826:             loc_oGrid = loc_oPage.grd_4c_GradeDisp
827:             BINDEVENT(loc_oGrid.Column1.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
828:             BINDEVENT(loc_oGrid.Column2.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
829:             BINDEVENT(loc_oGrid.Column3.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
830:             BINDEVENT(loc_oGrid.Column4.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
831:             BINDEVENT(loc_oGrid.Column5.Text1,    "Valid",     THIS, "P4ColC5Valid")
832:             BINDEVENT(loc_oGrid.Column5.Text1,    "KeyPress", THIS, "P4ColC5LostFocus")
833:             BINDEVENT(loc_oPage.txt_4c_Qt_pedida, "When",      THIS, "P4ColReadOnlyWhen")
834:             BINDEVENT(loc_oPage.txt_4c_Qt_Selec,  "When",      THIS, "P4ColReadOnlyWhen")
835:             BINDEVENT(loc_oPage.cmd_4c_Voltar,    "Click",     THIS, "BtnVoltarPage4Click")
836: 
837:         CATCH TO loc_oErro
838:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 4: " + loc_oErro.Message, "Erro")
839:         ENDTRY
840:     ENDPROC
841: 
842:     *--------------------------------------------------------------------------
843:     * ConfigurarPagina5 - Disponivel por Tamanho (TmpDisp por CodTams)
844:     *--------------------------------------------------------------------------
845:     PROTECTED PROCEDURE ConfigurarPagina5()
846: 
847:         LOCAL loc_oPage, loc_oGrid
848: 
849:         TRY
850:             loc_oPage = THIS.pgf_4c_1.Page5
851: 
852:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
853:             WITH loc_oPage.shp_4c_Shape4
854:                 .Top     = 171
855:                 .Left    = 240
856:                 .Width   = 328
857:                 .Height  = 2
858:                 .Visible = .F.
859:             ENDWITH
860: 
861:             loc_oPage.AddObject("lbl_4c_Label1", "Label")
862:             WITH loc_oPage.lbl_4c_Label1
863:                 .Top       = 150
864:                 .Left      = 246
865:                 .Width     = 205
866:                 .Height    = 25
867:                 .Caption   = "Selecionar Tamanhos"
868:                 .BackStyle = 0
869:                 .FontBold  = .T.
870:                 .Visible   = .F.
871:             ENDWITH
872: 
873:             loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
874:             WITH loc_oPage.txt_4c_Cpros
875:                 .Top      = 151
876:                 .Left     = 486
877:                 .Width    = 80
878:                 .Height   = 19
879:                 .ReadOnly = .T.
880:                 .Visible  = .F.
881:             ENDWITH
882: 
883:             loc_oPage.AddObject("grd_4c_GradeDisp", "Grid")
884:             loc_oPage.grd_4c_GradeDisp.ColumnCount  = 5
885:             loc_oPage.grd_4c_GradeDisp.RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
886:             WITH loc_oPage.grd_4c_GradeDisp
887:                 .Top          = 181
888:                 .Left         = 239
889:                 .Width        = 327
890:                 .Height       = 228
891:                 .RecordMark   = .F.
892:                 .DeleteMark   = .F.
893:                 .Visible      = .F.
894: 
895:                 WITH .Column1
896:                     .Header1.Caption = "Produto"
897:                     .ControlSource   = "TmpDisp.Cpros"
898:                     .Width           = 55
899:                     .ReadOnly        = .T.
900:                 ENDWITH
901:                 WITH .Column2
902:                     .Header1.Caption = "Cor"
903:                     .ControlSource   = "TmpDisp.CodCors"
904:                     .Width           = 40
905:                     .ReadOnly        = .T.
906:                 ENDWITH
907:                 WITH .Column3
908:                     .Header1.Caption = "Tam"
909:                     .ControlSource   = "TmpDisp.CodTams"
910:                     .Width           = 40
911:                     .ReadOnly        = .T.
912:                 ENDWITH
913:                 WITH .Column4
914:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
915:                     .ControlSource   = "TmpDisp.Disps"
916:                     .Width           = 65
917:                     .ReadOnly        = .T.
918:                     .Text1.Alignment = 1
919:                 ENDWITH
920:                 WITH .Column5
921:                     .Header1.Caption = "Utilizar"
922:                     .ControlSource   = "TmpDisp.Utilizar"
923:                     .Width           = 65
924:                     .ReadOnly        = .F.
925:                     .Text1.Alignment = 1
926:                 ENDWITH
927:             ENDWITH
928:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)
929: 
930:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
931:             WITH loc_oPage.lbl_4c_Label2
932:                 .Top       = 415
933:                 .Left      = 289
934:                 .Width     = 82
935:                 .Height    = 16
936:                 .Caption   = "Qtde Pedida : "
937:                 .BackStyle = 0
938:                 .Visible   = .F.
939:             ENDWITH
940: 
941:             loc_oPage.AddObject("lbl_4c_Label3", "Label")
942:             WITH loc_oPage.lbl_4c_Label3
943:                 .Top       = 434
944:                 .Left      = 261
945:                 .Width     = 110
946:                 .Height    = 16
947:                 .Caption   = "Qtde Selecionada : "
948:                 .BackStyle = 0
949:                 .Visible   = .F.
950:             ENDWITH
951: 
952:             loc_oPage.AddObject("txt_4c_Qt_pedida", "TextBox")
953:             WITH loc_oPage.txt_4c_Qt_pedida
954:                 .Top       = 410
955:                 .Left      = 379
956:                 .Width     = 67
957:                 .Height    = 23
958:                 .ReadOnly  = .T.
959:                 .Alignment = 1
960:                 .Visible   = .F.
961:             ENDWITH
962: 
963:             loc_oPage.AddObject("txt_4c_Qt_Selec", "TextBox")
964:             WITH loc_oPage.txt_4c_Qt_Selec
965:                 .Top       = 433
966:                 .Left      = 379
967:                 .Width     = 67
968:                 .Height    = 23
969:                 .ReadOnly  = .T.
970:                 .Alignment = 1
971:                 .Visible   = .F.
972:             ENDWITH
973: 
974:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
975:             WITH loc_oPage.cmd_4c_Voltar
976:                 .Top         = 12
977:                 .Left        = 704
978:                 .Width       = 75
979:                 .Height      = 75
980:                 .Caption     = "Voltar"
981:                 .FontName    = "Tahoma"
982:                 .FontSize    = 8
983:                 .Themes      = .T.
984:                 .Visible     = .F.
985:                 .ToolTipText = "Voltar"
986:             ENDWITH
987: 
988:             loc_oGrid = loc_oPage.grd_4c_GradeDisp
989:             BINDEVENT(loc_oGrid.Column1.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
990:             BINDEVENT(loc_oGrid.Column2.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
991:             BINDEVENT(loc_oGrid.Column3.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
992:             BINDEVENT(loc_oGrid.Column4.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
993:             BINDEVENT(loc_oGrid.Column5.Text1,    "Valid",    THIS, "P5ColC5Valid")
994:             BINDEVENT(loc_oPage.txt_4c_Qt_pedida, "When",    THIS, "P4ColReadOnlyWhen")
995:             BINDEVENT(loc_oPage.txt_4c_Qt_Selec,  "When",    THIS, "P4ColReadOnlyWhen")
996:             BINDEVENT(loc_oPage.cmd_4c_Voltar,    "Click",   THIS, "BtnVoltarPage5Click")
997: 
998:         CATCH TO loc_oErro
999:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 5: " + loc_oErro.Message, "Erro")
1000:         ENDTRY
1001:     ENDPROC
1002: 
1003:     *--------------------------------------------------------------------------
1004:     * ConfigurarPagina6 - Requisicao Manual de Material (SelPedra)
1005:     *--------------------------------------------------------------------------
1006:     PROTECTED PROCEDURE ConfigurarPagina6()
1007: 
1008:         LOCAL loc_oPage, loc_oGrid
1009: 
1010:         TRY
1011:             loc_oPage = THIS.pgf_4c_1.Page6
1012: 
1013:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
1014:             WITH loc_oPage.shp_4c_Shape4
1015:                 .Top     = 189
1016:                 .Left    = 119
1017:                 .Width   = 500
1018:                 .Height  = 2
1019:                 .Visible = .F.
1020:             ENDWITH
1021: 
1022:             loc_oPage.AddObject("lbl_4c_Label1", "Label")
1023:             WITH loc_oPage.lbl_4c_Label1
1024:                 .Top       = 168
1025:                 .Left      = 132
1026:                 .Width     = 294
1027:                 .Height    = 25
1028:                 .Caption   = "Requisi" + CHR(231) + CHR(227) + "o Manual de Material"
1029:                 .BackStyle = 0
1030:                 .FontBold  = .T.
1031:                 .Visible   = .F.
1032:             ENDWITH
1033: 
1034:             loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
1035:             WITH loc_oPage.txt_4c_Cpros
1036:                 .Top      = 169
1037:                 .Left     = 487
1038:                 .Width    = 80
1039:                 .Height   = 19
1040:                 .ReadOnly = .T.
1041:                 .Visible  = .F.
1042:             ENDWITH
1043: 
1044:             loc_oPage.AddObject("grd_4c_GradePedra", "Grid")
1045:             loc_oPage.grd_4c_GradePedra.ColumnCount  = 5
1046:             loc_oPage.grd_4c_GradePedra.RecordSource = IIF(USED("SelPedra"), "SelPedra", "")
1047:             WITH loc_oPage.grd_4c_GradePedra
1048:                 .Top          = 197
1049:                 .Left         = 119
1050:                 .Width        = 500
1051:                 .Height       = 261
1052:                 .RecordMark   = .F.
1053:                 .DeleteMark   = .F.
1054:                 .Visible      = .F.
1055: 
1056:                 WITH .Column1
1057:                     .Header1.Caption = "Produto"
1058:                     .ControlSource   = "SelPedra.Cpros"
1059:                     .Width           = 90
1060:                     .ReadOnly        = .F.
1061:                 ENDWITH
1062:                 WITH .Column2
1063:                     .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1064:                     .ControlSource   = "SelPedra.Dpros"
1065:                     .Width           = 150
1066:                     .ReadOnly        = .T.
1067:                 ENDWITH
1068:                 WITH .Column3
1069:                     .Header1.Caption = "Uni"
1070:                     .ControlSource   = "SelPedra.Cunis"
1071:                     .Width           = 40
1072:                     .ReadOnly        = .T.
1073:                 ENDWITH
1074:                 WITH .Column4
1075:                     .Header1.Caption = "Qtde"
1076:                     .ControlSource   = "SelPedra.Qtdes"
1077:                     .Width           = 75
1078:                     .ReadOnly        = .F.
1079:                     .Text1.Alignment = 1
1080:                 ENDWITH
1081:                 WITH .Column5
1082:                     .Header1.Caption = "Produto"
1083:                     .ControlSource   = "SelPedra.Cpro2s"
1084:                     .Width           = 90
1085:                     .ReadOnly        = .F.
1086:                 ENDWITH
1087:             ENDWITH
1088:             THIS.FormatarGrid(loc_oPage.grd_4c_GradePedra)
1089: 
1090:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
1091:             WITH loc_oPage.cmd_4c_Voltar
1092:                 .Top         = 12
1093:                 .Left        = 704
1094:                 .Width       = 75
1095:                 .Height      = 75
1096:                 .Caption     = "Voltar"
1097:                 .FontName    = "Tahoma"
1098:                 .FontSize    = 8
1099:                 .Themes      = .T.
1100:                 .Visible     = .F.
1101:                 .ToolTipText = "Voltar"
1102:             ENDWITH
1103: 
1104:             loc_oGrid = loc_oPage.grd_4c_GradePedra
1105:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",     THIS, "P6ColC1Valid")
1106:             BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "P6ColC1KeyPress")
1107:             BINDEVENT(loc_oGrid.Column2.Text1, "When",      THIS, "P6ColC2When")
1108:             BINDEVENT(loc_oGrid.Column3.Text1, "When",      THIS, "P6ColC3When")
1109:             BINDEVENT(loc_oGrid.Column4.Text1, "When",      THIS, "P6ColC4When")
1110:             BINDEVENT(loc_oGrid.Column5.Text1, "When",      THIS, "P6ColC5When")
1111:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid",     THIS, "P6ColC5Valid")
1112:             BINDEVENT(loc_oGrid.Column5.Text1, "KeyPress", THIS, "P6ColC5LostFocus")
1113:             BINDEVENT(loc_oGrid.Column5.Text1, "KeyPress",  THIS, "P6ColC5KeyPress")
1114:             BINDEVENT(loc_oPage.cmd_4c_Voltar, "Click",     THIS, "BtnVoltarPage6Click")
1115: 
1116:         CATCH TO loc_oErro
1117:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 6: " + loc_oErro.Message, "Erro")
1118:         ENDTRY
1119:     ENDPROC
1120: 
1121:     *--------------------------------------------------------------------------
1122:     * ConfigurarContainerAguarde - Overlay de espera (nivel do form)
1123:     *--------------------------------------------------------------------------
1124:     PROTECTED PROCEDURE ConfigurarContainerAguarde()
1125: 
1126:         TRY
1127:             THIS.AddObject("cnt_4c_Aguarde", "Container")
1128:             WITH THIS.cnt_4c_Aguarde
1129:                 .Top           = 251
1130:                 .Left          = 178
1131:                 .Width         = 645
1132:                 .Height        = 98
1133:                 .SpecialEffect = 0
1134:                 .BackColor     = RGB(255, 255, 255)
1135:                 .BackStyle     = 1
1136:                 .Visible       = .F.
1137:                 .ZOrderSet     = 1
1138: 
1139:                 .AddObject("lbl_4c_AguardeMsg", "Label")
1140:                 WITH .lbl_4c_AguardeMsg
1141:                     .FontBold  = .T.
1142:                     .FontName  = "Tahoma"
1143:                     .FontSize  = 14
1144:                     .BackStyle = 0
1145:                     .Caption   = "Aguarde..."
1146:                     .Height    = 29
1147:                     .Left      = 260
1148:                     .Top       = 18
1149:                     .Width     = 131
1150:                     .ForeColor = RGB(255, 0, 0)
1151:                     .AutoSize  = .F.
1152:                 ENDWITH
1153: 
1154:                 .AddObject("lbl_4c_AguardeProc", "Label")
1155:                 WITH .lbl_4c_AguardeProc
1156:                     .FontBold  = .T.
1157:                     .FontName  = "Tahoma"
1158:                     .FontSize  = 14
1159:                     .BackStyle = 0
1160:                     .Caption   = "Processando Dados ......"
1161:                     .Height    = 27
1162:                     .Left      = 171
1163:                     .Top       = 52
1164:                     .Width     = 303
1165:                     .ForeColor = RGB(90, 90, 90)
1166:                     .AutoSize  = .F.
1167:                 ENDWITH
1168: 
1169:                 .AddObject("lbl_4c_AguardeDet", "Label")
1170:                 WITH .lbl_4c_AguardeDet
1171:                     .FontBold  = .T.
1172:                     .FontName  = "Verdana"
1173:                     .FontSize  = 14
1174:                     .Alignment = 2
1175:                     .BackStyle = 0
1176:                     .Caption   = ""
1177:                     .Height    = 25
1178:                     .Left      = 164
1179:                     .Top       = 93
1180:                     .Width     = 291
1181:                     .ForeColor = RGB(0, 0, 160)
1182:                     .AutoSize  = .F.
1183:                 ENDWITH
1184:             ENDWITH

*-- Linhas 1262 a 1447:
1262:             *-- Shapes decorativos
1263:             loc_oPage.AddObject("shp_4c_Shape2", "Shape")
1264:             WITH loc_oPage.shp_4c_Shape2
1265:                 .Top     = 12
1266:                 .Left    = 10
1267:                 .Width   = 342
1268:                 .Height  = 110
1269:                 .Visible = .F.
1270:             ENDWITH
1271: 
1272:             loc_oPage.AddObject("shp_4c_Shape3", "Shape")
1273:             WITH loc_oPage.shp_4c_Shape3
1274:                 .Top     = 9
1275:                 .Left    = 605
1276:                 .Width   = 173
1277:                 .Height  = 38
1278:                 .Visible = .F.
1279:             ENDWITH
1280: 
1281:             *-- Imagem do produto
1282:             loc_oPage.AddObject("img_4c_ImgFigJpg", "Image")
1283:             WITH loc_oPage.img_4c_ImgFigJpg
1284:                 .Top     = 255
1285:                 .Left    = 646
1286:                 .Width   = 122
1287:                 .Height  = 89
1288:                 .Stretch = 2
1289:                 .Visible = .F.
1290:             ENDWITH
1291: 
1292:             *-- Grade principal de itens
1293:             loc_oPage.AddObject("grd_4c_GradeItens", "Grid")
1294:             loc_oPage.grd_4c_GradeItens.ColumnCount  = 10
1295:             loc_oPage.grd_4c_GradeItens.RecordSource = IIF(USED("TmpFinalg"), "TmpFinalg", "")
1296:             WITH loc_oPage.grd_4c_GradeItens
1297:                 .Top          = 173
1298:                 .Left         = 52
1299:                 .Width        = 586
1300:                 .Height       = 173
1301:                 .RecordMark   = .F.
1302:                 .DeleteMark   = .F.
1303:                 .Visible      = .F.
1304: 
1305:                 WITH .Column1
1306:                     .Header1.Caption = "Produto"
1307:                     .ControlSource   = "TmpFinalg.Cpros"
1308:                     .Width           = 90
1309:                     .ReadOnly        = .T.
1310:                 ENDWITH
1311: 
1312:                 WITH .Column2
1313:                     .Header1.Caption = "Cor"
1314:                     .ControlSource   = "TmpFinalg.CodCors"
1315:                     .Width           = 35
1316:                     .ReadOnly        = .T.
1317:                 ENDWITH
1318: 
1319:                 WITH .Column3
1320:                     .Header1.Caption = ""
1321:                     .ControlSource   = "TmpFinalg.Linhas"
1322:                     .Width           = 20
1323:                     .ReadOnly        = .T.
1324:                 ENDWITH
1325: 
1326:                 WITH .Column4
1327:                     .Header1.Caption = "N" + CHR(250) + "mero"
1328:                     .ControlSource   = "TmpFinalg.Nops"
1329:                     .Width           = 48
1330:                     .ReadOnly        = .T.
1331:                 ENDWITH
1332: 
1333:                 WITH .Column5
1334:                     .Header1.Caption = "Qtde Pedido"
1335:                     .ControlSource   = "TmpFinalg.Saldo"
1336:                     .Width           = 62
1337:                     .ReadOnly        = .T.
1338:                     .Text1.Alignment = 1
1339:                 ENDWITH
1340: 
1341:                 WITH .Column6
1342:                     .Header1.Caption = "Produzir"
1343:                     .ControlSource   = "TmpFinalg.Produzir"
1344:                     .Width           = 57
1345:                     .ReadOnly        = .T.
1346:                     .Text1.Alignment = 1
1347:                 ENDWITH
1348: 
1349:                 WITH .Column7
1350:                     .Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
1351:                     .ControlSource   = "TmpFinalg.Fabrs"
1352:                     .Width           = 62
1353:                     .ReadOnly        = .F.
1354:                     .Text1.Alignment = 1
1355:                 ENDWITH
1356: 
1357:                 WITH .Column8
1358:                     .Header1.Caption = "Produzir Estq"
1359:                     .ControlSource   = "TmpFinalg.Produzir2"
1360:                     .Width           = 62
1361:                     .ReadOnly        = .F.
1362:                     .Text1.Alignment = 1
1363:                 ENDWITH
1364: 
1365:                 WITH .Column9
1366:                     .Header1.Caption = "Tam"
1367:                     .ControlSource   = "TmpFinalg.CodTams"
1368:                     .Width           = 33
1369:                     .ReadOnly        = .T.
1370:                 ENDWITH
1371: 
1372:                 WITH .Column10
1373:                     .Header1.Caption = "Qtd Estoque"
1374:                     .ControlSource   = "TmpFinalg.Estoque"
1375:                     .Width           = 62
1376:                     .ReadOnly        = .F.
1377:                     .Text1.Alignment = 1
1378:                 ENDWITH
1379:             ENDWITH
1380: 
1381:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeItens)
1382: 
1383:             *-- Label e textboxes de totais da grade
1384:             loc_oPage.AddObject("lbl_4c_LblTotais", "Label")
1385:             WITH loc_oPage.lbl_4c_LblTotais
1386:                 .Top       = 348
1387:                 .Left      = 224
1388:                 .Width     = 42
1389:                 .Height    = 17
1390:                 .Caption   = "Totais :"
1391:                 .BackStyle = 0
1392:                 .Visible   = .F.
1393:             ENDWITH
1394: 
1395:             loc_oPage.AddObject("txt_4c_Tot_Qtd", "TextBox")
1396:             WITH loc_oPage.txt_4c_Tot_Qtd
1397:                 .Top       = 346
1398:                 .Left      = 271
1399:                 .Width     = 67
1400:                 .Height    = 19
1401:                 .ReadOnly  = .T.
1402:                 .Alignment = 1
1403:                 .Visible   = .F.
1404:             ENDWITH
1405: 
1406:             loc_oPage.AddObject("txt_4c_Tot_prdc", "TextBox")
1407:             WITH loc_oPage.txt_4c_Tot_prdc
1408:                 .Top       = 346
1409:                 .Left      = 339
1410:                 .Width     = 67
1411:                 .Height    = 19
1412:                 .ReadOnly  = .T.
1413:                 .Alignment = 1
1414:                 .Visible   = .F.
1415:             ENDWITH
1416: 
1417:             loc_oPage.AddObject("txt_4c_Tot_Est", "TextBox")
1418:             WITH loc_oPage.txt_4c_Tot_Est
1419:                 .Top       = 346
1420:                 .Left      = 407
1421:                 .Width     = 68
1422:                 .Height    = 19
1423:                 .ReadOnly  = .T.
1424:                 .Alignment = 1
1425:                 .Visible   = .F.
1426:             ENDWITH
1427: 
1428:             loc_oPage.AddObject("txt_4c_Tot_Prz", "TextBox")
1429:             WITH loc_oPage.txt_4c_Tot_Prz
1430:                 .Top       = 346
1431:                 .Left      = 476
1432:                 .Width     = 67
1433:                 .Height    = 19
1434:                 .ReadOnly  = .T.
1435:                 .Alignment = 1
1436:                 .Visible   = .F.
1437:             ENDWITH
1438: 
1439:             loc_oPage.AddObject("txt_4c_Tot_prze", "TextBox")
1440:             WITH loc_oPage.txt_4c_Tot_prze
1441:                 .Top       = 346
1442:                 .Left      = 543
1443:                 .Width     = 75
1444:                 .Height    = 19
1445:                 .ReadOnly  = .T.
1446:                 .Alignment = 1
1447:                 .Visible   = .F.

*-- Linhas 1482 a 1558:
1482:         TRY
1483:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container5
1484: 
1485:             loc_oCnt.AddObject("lbl_4c_Lab_periodo", "Label")
1486:             WITH loc_oCnt.lbl_4c_Lab_periodo
1487:                 .Top       = 2
1488:                 .Left      = 8
1489:                 .Width     = 105
1490:                 .Height    = 15
1491:                 .Caption   = "Per" + CHR(237) + "odo: xx meses"
1492:                 .BackStyle = 0
1493:                 .Visible   = .F.
1494:             ENDWITH
1495: 
1496:             loc_oCnt.AddObject("lbl_4c_Lab_produto", "Label")
1497:             WITH loc_oCnt.lbl_4c_Lab_produto
1498:                 .Top       = 18
1499:                 .Left      = 8
1500:                 .Width     = 127
1501:                 .Height    = 15
1502:                 .Caption   = "Referencia Analisada :"
1503:                 .BackStyle = 0
1504:                 .Visible   = .F.
1505:             ENDWITH
1506: 
1507:             loc_oCnt.AddObject("txt_4c_Cpros", "TextBox")
1508:             WITH loc_oCnt.txt_4c_Cpros
1509:                 .Top      = 16
1510:                 .Left     = 141
1511:                 .Width    = 108
1512:                 .Height   = 19
1513:                 .ReadOnly = .T.
1514:                 .Visible  = .F.
1515:             ENDWITH
1516: 
1517:             loc_oCnt.AddObject("lbl_4c_LblQtdVenda", "Label")
1518:             WITH loc_oCnt.lbl_4c_LblQtdVenda
1519:                 .Top       = 18
1520:                 .Left      = 269
1521:                 .Width     = 83
1522:                 .Height    = 15
1523:                 .Caption   = "Qtde Vendida :"
1524:                 .BackStyle = 0
1525:                 .Visible   = .F.
1526:             ENDWITH
1527: 
1528:             loc_oCnt.AddObject("txt_4c_Tot_Venda", "TextBox")
1529:             WITH loc_oCnt.txt_4c_Tot_Venda
1530:                 .Top       = 17
1531:                 .Left      = 349
1532:                 .Width     = 80
1533:                 .Height    = 19
1534:                 .ReadOnly  = .T.
1535:                 .Alignment = 1
1536:                 .Visible   = .F.
1537:             ENDWITH
1538: 
1539:             loc_oCnt.AddObject("lbl_4c_LblQtdMin", "Label")
1540:             WITH loc_oCnt.lbl_4c_LblQtdMin
1541:                 .Top       = 18
1542:                 .Left      = 448
1543:                 .Width     = 164
1544:                 .Height    = 15
1545:                 .Caption   = "Qtde M" + CHR(237) + "nima Para Produ" + CHR(231) + CHR(227) + "o :"
1546:                 .BackStyle = 0
1547:                 .Visible   = .F.
1548:             ENDWITH
1549: 
1550:             loc_oCnt.AddObject("txt_4c_Minima", "TextBox")
1551:             WITH loc_oCnt.txt_4c_Minima
1552:                 .Top       = 17
1553:                 .Left      = 623
1554:                 .Width     = 80
1555:                 .Height    = 19
1556:                 .ReadOnly  = .T.
1557:                 .Alignment = 1
1558:                 .Visible   = .F.

*-- Linhas 1573 a 1691:
1573:         TRY
1574:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container3
1575: 
1576:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1577:             WITH loc_oCnt.lbl_4c_Label1
1578:                 .Top       = 1
1579:                 .Left      = 0
1580:                 .Width     = 363
1581:                 .Height    = 16
1582:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1583:                 .BackStyle = 0
1584:                 .FontBold  = .T.
1585:                 .Visible   = .F.
1586:             ENDWITH
1587: 
1588:             loc_oCnt.AddObject("grd_4c_EstDisp", "Grid")
1589:             loc_oCnt.grd_4c_EstDisp.ColumnCount  = 6
1590:             loc_oCnt.grd_4c_EstDisp.RecordSource = IIF(USED("TmpSaldG"), "TmpSaldG", "")
1591:             WITH loc_oCnt.grd_4c_EstDisp
1592:                 .Top          = 15
1593:                 .Left         = 3
1594:                 .Width        = 358
1595:                 .Height       = 147
1596:                 .RecordMark   = .F.
1597:                 .DeleteMark   = .F.
1598:                 .ReadOnly     = .F.
1599:                 .Visible      = .F.
1600: 
1601:                 WITH .Column1
1602:                     .Header1.Caption = "Grupo"
1603:                     .ControlSource   = "TmpSaldG.Grupos"
1604:                     .Width           = 50
1605:                     .ReadOnly        = .T.
1606:                 ENDWITH
1607: 
1608:                 WITH .Column2
1609:                     .Header1.Caption = "Conta"
1610:                     .ControlSource   = "TmpSaldG.Estos"
1611:                     .Width           = 50
1612:                     .ReadOnly        = .T.
1613:                 ENDWITH
1614: 
1615:                 WITH .Column3
1616:                     .Header1.Caption = "Atual"
1617:                     .ControlSource   = "TmpSaldG.Saldo"
1618:                     .Width           = 60
1619:                     .ReadOnly        = .T.
1620:                     .Text1.Alignment = 1
1621:                 ENDWITH
1622: 
1623:                 WITH .Column4
1624:                     .Header1.Caption = "Utilizado"
1625:                     .ControlSource   = "TmpSaldG.Disps"
1626:                     .Width           = 60
1627:                     .ReadOnly        = .T.
1628:                     .Text1.Alignment = 1
1629:                 ENDWITH
1630: 
1631:                 WITH .Column5
1632:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
1633:                     .ControlSource   = "TmpSaldG.Disps"
1634:                     .Width           = 60
1635:                     .ReadOnly        = .T.
1636:                     .Text1.Alignment = 1
1637:                 ENDWITH
1638: 
1639:                 WITH .Column6
1640:                     .Header1.Caption = "Prior"
1641:                     .ControlSource   = "TmpSaldG.Priors"
1642:                     .Width           = 50
1643:                     .ReadOnly        = .T.
1644:                     .Text1.Alignment = 1
1645:                 ENDWITH
1646:             ENDWITH
1647: 
1648:             THIS.FormatarGrid(loc_oCnt.grd_4c_EstDisp)
1649: 
1650:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
1651:             WITH loc_oCnt.lbl_4c_Label2
1652:                 .Top       = 163
1653:                 .Left      = 128
1654:                 .Width     = 42
1655:                 .Height    = 17
1656:                 .Caption   = "Totais :"
1657:                 .BackStyle = 0
1658:                 .Visible   = .F.
1659:             ENDWITH
1660: 
1661:             loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
1662:             WITH loc_oCnt.txt_4c_Tot_Qtd
1663:                 .Top       = 161
1664:                 .Left      = 174
1665:                 .Width     = 58
1666:                 .Height    = 19
1667:                 .ReadOnly  = .T.
1668:                 .Alignment = 1
1669:                 .Visible   = .F.
1670:             ENDWITH
1671: 
1672:             loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
1673:             WITH loc_oCnt.txt_4c_Tot_Est
1674:                 .Top       = 161
1675:                 .Left      = 234
1676:                 .Width     = 58
1677:                 .Height    = 19
1678:                 .ReadOnly  = .T.
1679:                 .Alignment = 1
1680:                 .Visible   = .F.
1681:             ENDWITH
1682: 
1683:             loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
1684:             WITH loc_oCnt.txt_4c_Tot_Prz
1685:                 .Top       = 161
1686:                 .Left      = 292
1687:                 .Width     = 58
1688:                 .Height    = 19
1689:                 .ReadOnly  = .T.
1690:                 .Alignment = 1
1691:                 .Visible   = .F.

*-- Linhas 1711 a 1806:
1711:         TRY
1712:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container1
1713: 
1714:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1715:             WITH loc_oCnt.lbl_4c_Label1
1716:                 .Top       = 1
1717:                 .Left      = 1
1718:                 .Width     = 305
1719:                 .Height    = 16
1720:                 .Caption   = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
1721:                 .BackStyle = 0
1722:                 .FontBold  = .T.
1723:                 .Visible   = .F.
1724:             ENDWITH
1725: 
1726:             loc_oCnt.AddObject("grd_4c_EstProd", "Grid")
1727:             loc_oCnt.grd_4c_EstProd.ColumnCount  = 5
1728:             loc_oCnt.grd_4c_EstProd.RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
1729:             WITH loc_oCnt.grd_4c_EstProd
1730:                 .Top          = 15
1731:                 .Left         = 2
1732:                 .Width        = 303
1733:                 .Height       = 99
1734:                 .RecordMark   = .F.
1735:                 .DeleteMark   = .F.
1736:                 .ReadOnly     = .T.
1737:                 .Visible      = .F.
1738: 
1739:                 WITH .Column1
1740:                     .Header1.Caption = "Fase"
1741:                     .ControlSource   = "TmpFinal.Dopes"
1742:                     .Width           = 55
1743:                 ENDWITH
1744: 
1745:                 WITH .Column2
1746:                     .Header1.Caption = "Disponivel"
1747:                     .ControlSource   = "TmpFinal.Saldo"
1748:                     .Width           = 62
1749:                     .Text1.Alignment = 1
1750:                 ENDWITH
1751: 
1752:                 WITH .Column3
1753:                     .Header1.Caption = "Utilizado"
1754:                     .ControlSource   = "TmpFinal.Estoque"
1755:                     .Width           = 62
1756:                     .Text1.Alignment = 1
1757:                 ENDWITH
1758: 
1759:                 WITH .Column4
1760:                     .Header1.Caption = "Nop"
1761:                     .ControlSource   = "TmpFinal.Produzir"
1762:                     .Width           = 62
1763:                     .Text1.Alignment = 1
1764:                 ENDWITH
1765: 
1766:                 WITH .Column5
1767:                     .Header1.Caption = "Prior"
1768:                     .ControlSource   = "TmpFinal.Fabrs"
1769:                     .Width           = 55
1770:                     .Text1.Alignment = 1
1771:                 ENDWITH
1772:             ENDWITH
1773: 
1774:             THIS.FormatarGrid(loc_oCnt.grd_4c_EstProd)
1775: 
1776:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
1777:             WITH loc_oCnt.lbl_4c_Label2
1778:                 .Top       = 115
1779:                 .Left      = 102
1780:                 .Width     = 42
1781:                 .Height    = 17
1782:                 .Caption   = "Totais :"
1783:                 .BackStyle = 0
1784:                 .Visible   = .F.
1785:             ENDWITH
1786: 
1787:             loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
1788:             WITH loc_oCnt.txt_4c_Tot_Qtd
1789:                 .Top       = 113
1790:                 .Left      = 145
1791:                 .Width     = 61
1792:                 .Height    = 19
1793:                 .ReadOnly  = .T.
1794:                 .Alignment = 1
1795:                 .Visible   = .F.
1796:             ENDWITH
1797: 
1798:             loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
1799:             WITH loc_oCnt.txt_4c_Tot_Est
1800:                 .Top       = 113
1801:                 .Left      = 207
1802:                 .Width     = 61
1803:                 .Height    = 19
1804:                 .ReadOnly  = .T.
1805:                 .Alignment = 1
1806:                 .Visible   = .F.

*-- Linhas 1821 a 1934:
1821:         TRY
1822:             loc_oPage = THIS.pgf_4c_1.Page1
1823: 
1824:             loc_oPage.AddObject("cmd_4c_Pedras", "CommandButton")
1825:             WITH loc_oPage.cmd_4c_Pedras
1826:                 .Top         = 2
1827:                 .Left        = 348
1828:                 .Width       = 75
1829:                 .Height      = 75
1830:                 .Caption     = "Requisi" + CHR(231) + CHR(245) + "es"
1831:                 .FontName    = "Tahoma"
1832:                 .FontSize    = 8
1833:                 .Themes      = .T.
1834:                 .Visible     = .F.
1835:                 .ToolTipText = "Requisi" + CHR(231) + CHR(245) + "es de Material"
1836:             ENDWITH
1837: 
1838:             loc_oPage.AddObject("cmd_4c_SelEstoque", "CommandButton")
1839:             WITH loc_oPage.cmd_4c_SelEstoque
1840:                 .Top         = 2
1841:                 .Left        = 423
1842:                 .Width       = 75
1843:                 .Height      = 75
1844:                 .Caption     = "Estoques"
1845:                 .FontName    = "Tahoma"
1846:                 .FontSize    = 8
1847:                 .Themes      = .T.
1848:                 .Visible     = .F.
1849:                 .ToolTipText = "Selecionar Estoque"
1850:             ENDWITH
1851: 
1852:             loc_oPage.AddObject("cmd_4c_Disponivel", "CommandButton")
1853:             WITH loc_oPage.cmd_4c_Disponivel
1854:                 .Top         = 2
1855:                 .Left        = 498
1856:                 .Width       = 75
1857:                 .Height      = 75
1858:                 .Caption     = "Dispon" + CHR(237) + "veis"
1859:                 .FontName    = "Tahoma"
1860:                 .FontSize    = 8
1861:                 .Themes      = .T.
1862:                 .Visible     = .F.
1863:                 .ToolTipText = "Dispon" + CHR(237) + "vel por Tamanho"
1864:             ENDWITH
1865: 
1866:             loc_oPage.AddObject("cmd_4c_TotLinha", "CommandButton")
1867:             WITH loc_oPage.cmd_4c_TotLinha
1868:                 .Top         = 2
1869:                 .Left        = 573
1870:                 .Width       = 75
1871:                 .Height      = 75
1872:                 .Caption     = "Total/Linhas"
1873:                 .FontName    = "Tahoma"
1874:                 .FontSize    = 8
1875:                 .Themes      = .T.
1876:                 .Visible     = .F.
1877:                 .ToolTipText = "Totais por Linha"
1878:             ENDWITH
1879: 
1880:             loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
1881:             WITH loc_oPage.cmd_4c_Processar
1882:                 .Top         = 2
1883:                 .Left        = 648
1884:                 .Width       = 75
1885:                 .Height      = 75
1886:                 .Caption     = "Processar"
1887:                 .FontName    = "Tahoma"
1888:                 .FontSize    = 8
1889:                 .Themes      = .T.
1890:                 .Visible     = .F.
1891:                 .ToolTipText = "Processar Globaliza" + CHR(231) + CHR(227) + "o"
1892:             ENDWITH
1893: 
1894:             loc_oPage.AddObject("cmd_4c_Encerrar", "CommandButton")
1895:             WITH loc_oPage.cmd_4c_Encerrar
1896:                 .Top         = 2
1897:                 .Left        = 723
1898:                 .Width       = 75
1899:                 .Height      = 75
1900:                 .Caption     = "Encerrar"
1901:                 .FontName    = "Tahoma"
1902:                 .FontSize    = 8
1903:                 .Themes      = .T.
1904:                 .Visible     = .F.
1905:                 .ToolTipText = "Encerrar"
1906:             ENDWITH
1907: 
1908:             loc_oPage.AddObject("cmd_4c_Alteraqtd", "CommandButton")
1909:             WITH loc_oPage.cmd_4c_Alteraqtd
1910:                 .Top         = 189
1911:                 .Left        = 687
1912:                 .Width       = 40
1913:                 .Height      = 40
1914:                 .Caption     = "Alt"
1915:                 .FontName    = "Tahoma"
1916:                 .FontSize    = 8
1917:                 .Themes      = .T.
1918:                 .Visible     = .F.
1919:                 .ToolTipText = "Autorizar edi" + CHR(231) + CHR(227) + "o de quantidade"
1920:             ENDWITH
1921: 
1922:             *-- BINDEVENTs
1923:             BINDEVENT(loc_oPage.cmd_4c_Pedras,     "Click", THIS, "BtnPedrasClick")
1924:             BINDEVENT(loc_oPage.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
1925:             BINDEVENT(loc_oPage.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
1926:             BINDEVENT(loc_oPage.cmd_4c_TotLinha,   "Click", THIS, "BtnTotLinhaClick")
1927:             BINDEVENT(loc_oPage.cmd_4c_Processar,  "Click", THIS, "BtnProcessarClick")
1928:             BINDEVENT(loc_oPage.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
1929:             BINDEVENT(loc_oPage.cmd_4c_Alteraqtd,  "Click", THIS, "BtnAlteraqtdClick")
1930: 
1931:         CATCH TO loc_oErro
1932:             MsgErro("Erro ao configurar bot" + CHR(245) + "es: " + loc_oErro.Message, "Erro")
1933:         ENDTRY
1934:     ENDPROC

*-- Linhas 1942 a 1959:
1942: 
1943:         TRY
1944:             loc_oPage = THIS.pgf_4c_1.Page1
1945:             IF PEMSTATUS(loc_oPage, "cmd_4c_Disponivel", 5)
1946:                 loc_oPage.cmd_4c_Disponivel.Visible = .F.
1947:             ENDIF
1948:             IF PEMSTATUS(loc_oPage, "cmd_4c_SelEstoque", 5) AND ;
1949:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
1950:                 loc_oPage.cmd_4c_SelEstoque.Visible = THIS.this_oBusinessObject.this_lSelEstoqueVisivel
1951:             ENDIF
1952:             IF PEMSTATUS(loc_oPage, "cmd_4c_Pedras", 5) AND ;
1953:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
1954:                 loc_oPage.cmd_4c_Pedras.Visible = THIS.this_oBusinessObject.this_lPedrasVisiveis
1955:             ENDIF
1956:         CATCH TO loc_oErro
1957:             MsgErro("Erro ao ajustar visibilidade: " + loc_oErro.Message, "Erro")
1958:         ENDTRY
1959:     ENDPROC

*-- Linhas 2056 a 2065:
2056:                     " Cor:" + ALLTRIM(TmpFinalg.CodCors), "")
2057:                 loc_cCapTam = IIF(!EMPTY(ALLTRIM(TmpFinalg.CodTams)), ;
2058:                     " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2059:                 IF PEMSTATUS(loc_oCnt3, "lbl_4c_Label1", 5)
2060:                     loc_oCnt3.lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + ;
2061:                         "vel " + ALLTRIM(TmpFinalg.Cpros) + loc_cCapCor + loc_cCapTam
2062:                 ENDIF
2063: 
2064:                 IF PEMSTATUS(loc_oCnt3, "grd_4c_EstDisp", 5)
2065:                     loc_oCnt3.grd_4c_EstDisp.Refresh

*-- Linhas 2297 a 2306:
2297:                 THIS.this_nOldValue = TmpFinalg.Estoque
2298:             ENDIF
2299: 
2300:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
2301:                 THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.
2302:             ENDIF
2303: 
2304:             *-- Em modo reserva com estoque zero, verifica tipo do grupo
2305:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND ;
2306:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)

*-- Linhas 2314 a 2323:
2314:                         loc_lMostraDisp = INLIST(cursor_4c_GrpTipo.TipoEstos, 3, 4)
2315:                         USE IN cursor_4c_GrpTipo
2316:                         IF loc_lMostraDisp AND ;
2317:                            PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
2318:                             THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
2319:                         ENDIF
2320:                     ENDIF
2321:                 ENDIF
2322:             ENDIF
2323:         CATCH TO loc_oErro

*-- Linhas 2829 a 2838:
2829:                     THIS.pgf_4c_1.Page2.edt_4c_ObsItens.Value = ALLTRIM(TmpFinal.CodObs)
2830:                 ENDIF
2831: 
2832:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "lbl_4c_Txt_ObsItens", 5)
2833:                     THIS.pgf_4c_1.Page2.lbl_4c_Txt_ObsItens.Caption = ALLTRIM(TmpFinal.Cpros)
2834:                 ENDIF
2835: 
2836:                 IF !EMPTY(loc_cCpros) AND gnConnHandle > 0
2837:                     loc_cSQL = "SELECT TOP 1 Fotos FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
2838:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoP2")

*-- Linhas 3608 a 3616:
3608: 
3609:         IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
3610:             IF TYPE("par_cMensagem") = "C" AND !EMPTY(par_cMensagem)
3611:                 THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = par_cMensagem
3612:             ENDIF
3613:             THIS.cnt_4c_Aguarde.Visible = .T.
3614:             THIS.cnt_4c_Aguarde.ZOrder(0)
3615:         ENDIF
3616:         THIS.this_lProcessando = .T.

*-- Linhas 3623 a 3631:
3623:     PROCEDURE OcultarAguarde()
3624: 
3625:         IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
3626:             THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = ""
3627:             THIS.cnt_4c_Aguarde.Visible = .F.
3628:         ENDIF
3629:         THIS.this_lProcessando = .F.
3630:         DOEVENTS
3631:     ENDPROC

*-- Linhas 3861 a 3870:
3861:                 ENDWITH
3862:             ENDIF
3863: 
3864:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Processar", 5)
3865:                 THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled = !loc_lBloquear
3866:             ENDIF
3867:         CATCH TO loc_oErro
3868:             MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
3869:         ENDTRY
3870:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrGlxBO.prg):
*=============================================================================*
* SigPrGlxBO.prg - Business Object para Previa da Globalizacao
*=============================================================================*
* Herda de: BusinessBase
* Form associado: FormSigPrGlx.prg (forms\operacionais\)
* Descricao: Gerencia a previa da globalizacao de producao.
*            Opera sobre cursores temporarios passados pelo form pai
*            (TmpFinalg, TmpFinal, TmpSaldG, TmpFabr, TmpSaldU)
*            alem de cursores SQL criados em tempo de execucao.
*            Nao possui tabela SQL Server propria (opera em varias tabelas).
*=============================================================================*

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros recebidos do form pai via Init/ConfigurarParametros
    *--------------------------------------------------------------------------

    *-- Indica modo reserva automatica (nao produz OP, apenas reserva estoque)
    this_lReserva           = .F.

    *-- Indica modo de processamento automatico (sem confirmacao manual)
    this_lAutomatico        = .F.

    *-- Indica se o destino das OPs segue o destino do movimento origem
    this_lPorDestino        = .F.

    *-- Numero de emphasis (empresa) padrao para geracao de OP
    this_nEmphPdr           = 0

    *-- Numero da OP pre-definida (quando GlobAutos = 2 no parametro)
    this_nNumerodaop        = 0

    *-- Data de referencia para processamento (data da globalizacao)
    this_dData              = {}

    *-- Chave de assinatura unica para rastreio de registros gerados
    this_cSigKey            = ""

    *--------------------------------------------------------------------------
    * Controle de edicao inline nos grids de itens (Page1 e Page2)
    *--------------------------------------------------------------------------

    *-- Valor anterior antes de edicao em Column7/Column10 do GradeItens
    this_nOldValue          = 0

    *-- Valor anterior antes de edicao em Column5 do GradePedra (Page6)
    this_nAntValue          = 0

    *-- Flag de liberacao para edicao de coluna normalmente bloqueada (Column8)
    this_lLiberado          = .F.

    *--------------------------------------------------------------------------
    * Controle de exibicao e estado de botoes da UI
    *--------------------------------------------------------------------------

    *-- Controla visibilidade do botao Pedras (requisicao manual de material)
    this_lPedrasVisiveis    = .F.

    *-- Controla visibilidade do botao Disponivel
    this_lDisponivelVisivel = .F.

    *-- Controla visibilidade do botao SelEstoque (selecionar estoque por grupo)
    this_lSelEstoqueVisivel = .F.

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina principal (Page1 - GradeItens)
    *--------------------------------------------------------------------------

    *-- Total de quantidade / saldo (coluna Saldo do TmpFinalg)
    this_nTotQtd            = 0

    *-- Total de estoque (coluna Estoque do TmpFinalg)
    this_nTotEst            = 0

    *-- Total a produzir / prazo (coluna Produzir do TmpFinalg)
    this_nTotPrz            = 0

    *-- Total de producao / fabrico (coluna Fabrs do TmpFinalg)
    this_nTotPrdc           = 0

    *-- Total de producao para estoque (coluna Produzir2 do TmpFinalg)
    this_nTotPrze           = 0

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina de operacoes detalhadas (Page2)
    *--------------------------------------------------------------------------

    *-- Total de quantidade (Page2 - TmpFinal)
    this_nTotQtdP2          = 0

    *-- Total de estoque (Page2 - TmpFinal)
    this_nTotEstP2          = 0

    *-- Total a produzir (Page2 - TmpFinal)
    this_nTotPrzP2          = 0

    *-- Total de producao (Page2 - TmpFinal.Fabrs)
    this_nTotPrcP2          = 0

    *-- Quantidade selecionada de estoque para a referencia corrente (Tot_sEst)
    this_nTotSEst           = 0

    *-- Quantidade selecionada de producao para a referencia corrente (Tot_sPrc)
    this_nTotSPrc           = 0

    *--------------------------------------------------------------------------
    * Permissoes de acesso
    *--------------------------------------------------------------------------

    *-- Indica se usuario tem permissao para alterar prioridade (SIGPRGLO/PRIORIDADE)
    this_lPermitePrioridade = .F.

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le totais acumulados do cursor de itens
    *--------------------------------------------------------------------------
    * Para forms OPERACIONAIS este BO nao mapeia registro-a-registro:
    * recebe o alias do cursor de itens (TmpFinalg para Page1, TmpFinal para
    * Page2) e calcula os totais para exibir nos textboxes Tot_Qtd/Est/Prz/etc.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_nRecno, loc_nSaldo, loc_nEstoque
        LOCAL loc_nProduzir, loc_nFabrs, loc_nProduzir2
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "TmpFinalg", par_cAliasCursor)

            IF !USED(loc_cAlias)
                loc_lSucesso = .F.
            ELSE
                SELECT (loc_cAlias)
                loc_nRecno = IIF(RECCOUNT() > 0, RECNO(), 0)

                loc_nSaldo     = 0
                loc_nEstoque   = 0
                loc_nProduzir  = 0
                loc_nFabrs     = 0
                loc_nProduzir2 = 0

                IF RECCOUNT() > 0
                    SUM Saldo, Estoque, Produzir, Fabrs ;
                        TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs

                    IF TYPE(loc_cAlias + ".Produzir2") != "U"
                        SUM Produzir2 TO loc_nProduzir2
                    ENDIF

                    IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF

                IF UPPER(loc_cAlias) = "TMPFINAL"
                    THIS.this_nTotQtdP2  = loc_nSaldo
                    THIS.this_nTotEstP2  = loc_nEstoque
                    THIS.this_nTotPrzP2  = loc_nProduzir
                    THIS.this_nTotPrcP2  = loc_nFabrs
                ELSE
                    THIS.this_nTotQtd  = loc_nSaldo
                    THIS.this_nTotEst  = loc_nEstoque
                    THIS.this_nTotPrz  = loc_nProduzir
                    THIS.this_nTotPrdc = loc_nFabrs
                    THIS.this_nTotPrze = loc_nProduzir2
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar totais do cursor: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de rastreio da execucao (SigKey unica)
    *--------------------------------------------------------------------------
    * Cada execucao da previa gera uma SigKey por fGerUniqueKey no legado.
    * Enquanto o form nao a define, retorna string vazia. Usada para vincular
    * registros gerados (SigOpPic/SigCdNei/SigMvCab) na fase Processar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSigKey)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao da globalizacao em LogAuditoria
    *--------------------------------------------------------------------------
    * OPERACIONAL: nao existe INSERT em tabela unica. O metodo delega para
    * RegistrarAuditoria com operacao "GLOBALIZACAO" (ou "RESERVA_AUTO"),
    * marcando que a previa foi confirmada. As gravacoes reais dos registros
    * (SigMvCab/SigOpPic/SigCdNei) ocorrem na fase Processar do form.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cOperacao

        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(THIS.this_lReserva, ;
                "RESERVA_AUTO_GLOBALIZACAO", ;
                "PREVIA_GLOBALIZACAO")

            THIS.RegistrarAuditoria(loc_cOperacao)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar globalizacao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reprocessamento em LogAuditoria
    *--------------------------------------------------------------------------
    * Chamado quando o usuario reexecuta o Processar apos ajustar quantidades
    * (edicoes em GradeItens Column7/Column10). Registra evento no log.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("REPROCESSAMENTO_GLOBALIZACAO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar reprocessamento: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Insere entrada na tabela LogAuditoria
    *--------------------------------------------------------------------------
    * Grava operacao no log para rastreabilidade. Usa GETDATE() literal
    * (nao GETDATE()) para DataHora conforme feedback #35.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cModulo
        LOCAL loc_nResultado, loc_oErro

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, "SISTEMA")
            loc_cModulo  = "SigPrGlx"

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Modulo, Operacao, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cModulo) + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL("SigKey=" + loc_cChave + ;
                    "; Reserva=" + IIF(THIS.this_lReserva, "S", "N") + ;
                    "; Automatico=" + IIF(THIS.this_lAutomatico, "S", "N") + ;
                    "; PorDestino=" + IIF(THIS.this_lPorDestino, "S", "N") + ;
                    "; NumeroOP=" + TRANSFORM(THIS.this_nNumerodaop)) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Falha ao gravar LogAuditoria para operacao " + ;
                    par_cOperacao, "Auditoria")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RegistrarAuditoria: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

