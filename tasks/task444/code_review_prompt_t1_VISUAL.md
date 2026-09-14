# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [FONTNAME-ERRADO] Linha 640: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 659: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 678: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 734: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 754: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormHOR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1873 linhas total):

*-- Linhas 142 a 240:
142:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
143:             SET DATE TO BRITISH
144:             SET CENTURY ON
145:             THIS.Caption = "Cadastro de Carga Hor" + CHR(225) + "ria"
146: 
147:             *-- BO
148:             THIS.this_oBusinessObject = CREATEOBJECT("HORBO")
149:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
150:                 MsgErro("Falha ao criar HORBO.", "InicializarForm")
151:             ELSE
152:             THIS.this_oBusinessObject.this_cSetors   = THIS.this_cParCod
153:             THIS.this_oBusinessObject.this_cUniPrdts = THIS.this_cParUni
154: 
155:             *-- ===== SOMBRA (CABE?ALHO ESCURO) =====
156:             THIS.AddObject("cnt_4c_Sombra", "Container")
157:             WITH THIS.cnt_4c_Sombra
158:                 .Top         = 0
159:                 .Left        = 0
160:                 .Width       = THIS.Width
161:                 .Height      = 80
162:                 .BorderWidth = 0
163:                 .BackColor   = RGB(100,100,100)
164:                 .Visible     = .T.
165: 
166:                 .AddObject("lbl_4c_LblSombra", "Label")
167:                 WITH .lbl_4c_LblSombra
168:                     .AutoSize    = .F.
169:                     .FontBold    = .T.
170:                     .FontName    = "Tahoma"
171:                     .FontSize    = 18
172:                     .WordWrap    = .T.
173:                     .Alignment   = 0
174:                     .BackStyle   = 0
175:                     .Width       = THIS.Width
176:                     .Height      = 40
177:                     .Left        = 10
178:                     .Top         = 18
179:                     .ForeColor   = RGB(0,0,0)
180:                     .Caption     = "Cadastro de Carga Hor" + CHR(225) + "ria"
181:                     .Visible     = .T.
182:                 ENDWITH
183: 
184:                 .AddObject("lbl_4c_LblTitulo", "Label")
185:                 WITH .lbl_4c_LblTitulo
186:                     .AutoSize    = .F.
187:                     .FontBold    = .T.
188:                     .FontName    = "Tahoma"
189:                     .FontSize    = 18
190:                     .WordWrap    = .T.
191:                     .Alignment   = 0
192:                     .BackStyle   = 0
193:                     .Width       = THIS.Width
194:                     .Height      = 46
195:                     .Left        = 10
196:                     .Top         = 17
197:                     .ForeColor   = RGB(255,255,255)
198:                     .Caption     = "Cadastro de Carga Hor" + CHR(225) + "ria"
199:                     .Visible     = .T.
200:                 ENDWITH
201:             ENDWITH
202: 
203:             *-- ===== LABELS DO FORM (Fase/Setor e Unidade Produtiva) =====
204:             THIS.AddObject("lbl_4c_LblFase", "Label")
205:             WITH THIS.lbl_4c_LblFase
206:                 .FontBold  = .T.
207:                 .FontName  = "Tahoma"
208:                 .Caption   = "Fase/Setor :"
209:                 .Left      = 79
210:                 .Top       = 128
211:                 .ForeColor = RGB(90,90,90)
212:                 .BackStyle = 0
213:                 .AutoSize  = .T.
214:                 .Visible   = .T.
215:             ENDWITH
216: 
217:             THIS.AddObject("lbl_4c_LblUni", "Label")
218:             WITH THIS.lbl_4c_LblUni
219:                 .FontBold  = .T.
220:                 .FontName  = "Tahoma"
221:                 .Caption   = "Unidade Produtiva :"
222:                 .Left      = 407
223:                 .Top       = 128
224:                 .ForeColor = RGB(90,90,90)
225:                 .BackStyle = 0
226:                 .AutoSize  = .T.
227:                 .Visible   = .T.
228:             ENDWITH
229: 
230:             *-- ===== TEXTBOXES DO FORM (somente leitura) =====
231:             THIS.AddObject("txt_4c_Fases", "TextBox")
232:             WITH THIS.txt_4c_Fases
233:                 .Enabled           = .F.
234:                 .Left              = 166
235:                 .Top               = 124
236:                 .Width             = 80
237:                 .Height            = 20
238:                 .ForeColor         = RGB(0,0,0)
239:                 .DisabledBackColor = RGB(255,255,230)
240:                 .DisabledForeColor = RGB(0,0,128)

*-- Linhas 246 a 255:
246:             THIS.AddObject("txt_4c_DFases", "TextBox")
247:             WITH THIS.txt_4c_DFases
248:                 .Enabled           = .F.
249:                 .Left              = 247
250:                 .Top               = 124
251:                 .Width             = 150
252:                 .Height            = 20
253:                 .ForeColor         = RGB(0,0,0)
254:                 .DisabledBackColor = RGB(255,255,230)
255:                 .DisabledForeColor = RGB(0,0,128)

*-- Linhas 261 a 270:
261:             THIS.AddObject("txt_4c_UniPrdts", "TextBox")
262:             WITH THIS.txt_4c_UniPrdts
263:                 .Enabled           = .F.
264:                 .Left              = 540
265:                 .Top               = 124
266:                 .Width             = 80
267:                 .Height            = 20
268:                 .ForeColor         = RGB(0,0,0)
269:                 .DisabledBackColor = RGB(255,255,230)
270:                 .DisabledForeColor = RGB(0,0,128)

*-- Linhas 276 a 285:
276:             *-- ===== GRADE MES/ANO =====
277:             THIS.AddObject("grd_4c_Dados", "Grid")
278:             WITH THIS.grd_4c_Dados
279:                 .Top          = 163
280:                 .Left         = 80
281:                 .Width        = 92
282:                 .Height       = 346
283:                 .ColumnCount  = 2
284:                 .FontName     = "Courier New"
285:                 .DeleteMark   = .F.

*-- Linhas 297 a 305:
297:                     .Resizable     = .F.
298:                     .ReadOnly      = .T.
299:                     WITH .Header1
300:                         .Caption   = "M" + CHR(234) + "s"
301:                         .FontName  = "Verdana"
302:                         .FontSize  = 8
303:                         .Alignment = 2
304:                         .ForeColor = RGB(36,84,155)
305:                     ENDWITH

*-- Linhas 314 a 336:
314:                     .Resizable     = .F.
315:                     .ReadOnly      = .T.
316:                     WITH .Header1
317:                         .Caption   = "Ano"
318:                         .FontName  = "Verdana"
319:                         .FontSize  = 8
320:                         .Alignment = 2
321:                         .ForeColor = RGB(36,84,155)
322:                     ENDWITH
323:                     .Text1.FontName = "Courier New"
324:                 ENDWITH
325:             ENDWITH
326: 
327:             *-- ===== CALENDARIO (container com bot?es de dia) =====
328:             THIS.AddObject("cnt_4c_Calendario", "Container")
329:             WITH THIS.cnt_4c_Calendario
330:                 .Top           = 163
331:                 .Left          = 185
332:                 .Width         = 344
333:                 .Height        = 347
334:                 .SpecialEffect = 0
335:                 .BackColor     = RGB(255,255,255)
336:                 .BorderColor   = RGB(128,128,128)

*-- Linhas 346 a 593:
346:                 STORE "Sab" TO loc_aDias(7)
347: 
348:                 FOR loc_nObj = 1 TO 7
349:                     loc_cNome = "cmd_4c_Command" + TRANSFORM(loc_nObj)
350:                     .AddObject(loc_cNome, "CommandButton")
351:                     WITH EVALUATE("." + loc_cNome)
352:                         .Top       = 3
353:                         .Left      = 4 + (loc_nObj - 1) * 48
354:                         .Width     = 47
355:                         .Height    = 42
356:                         .FontBold  = .T.
357:                         .FontName  = "Tahoma"
358:                         .FontSize  = 10
359:                         .WordWrap  = .T.
360:                         .Caption   = loc_aDias(loc_nObj)
361:                         .ForeColor = RGB(90,90,90)
362:                         .BackColor = RGB(255,255,255)
363:                         .Enabled   = .F.
364:                         .Visible   = .T.
365:                     ENDWITH
366:                 NEXT
367: 
368:                 *-- 42 bot?es de dia (6 semanas x 7 dias)
369:                 FOR loc_nObj = 1 TO 42
370:                     loc_cNome  = "cmd_4c_Chk" + PADL(loc_nObj, 2, "0")
371:                     loc_nRow   = INT((loc_nObj - 1) / 7)
372:                     loc_nCol   = MOD(loc_nObj - 1, 7)
373:                     loc_nTop   = 56  + loc_nRow * 48
374:                     loc_nLeft  = 4   + loc_nCol * 48
375: 
376:                     .AddObject(loc_cNome, "CommandButton")
377:                     WITH EVALUATE("." + loc_cNome)
378:                         .Top       = loc_nTop
379:                         .Left      = loc_nLeft
380:                         .Width     = 47
381:                         .Height    = 47
382:                         .FontBold  = .T.
383:                         .FontName  = "Arial"
384:                         .FontSize  = 10
385:                         .WordWrap  = .T.
386:                         .Caption   = "  00   000:00"
387:                         .BackColor = RGB(255,255,255)
388:                         .Enabled   = .F.
389:                         .Visible   = .T.
390:                     ENDWITH
391:                 NEXT
392:             ENDWITH
393: 
394:             *-- BINDEVENT para os 42 bot?es do calend?rio
395:             FOR loc_nObj = 1 TO 42
396:                 loc_cNome = "cmd_4c_Chk" + PADL(loc_nObj, 2, "0")
397:                 BINDEVENT(THIS.cnt_4c_Calendario.&loc_cNome., "Click", THIS, "ChkClick")
398:             NEXT
399: 
400:             *-- ===== CONTAINER DADOS (painel lateral direito) =====
401:             THIS.AddObject("cnt_4c_Dados", "Container")
402:             WITH THIS.cnt_4c_Dados
403:                 .Top           = 163
404:                 .Left          = 542
405:                 .Width         = 195
406:                 .Height        = 199
407:                 .SpecialEffect = 0
408:                 .BackColor     = RGB(255,255,255)
409:                 .BorderColor   = RGB(128,128,128)
410:                 .Visible       = .T.
411: 
412:                 *-- Bot?o indicador do per?odo selecionado
413:                 .AddObject("cmd_4c_BtnData", "CommandButton")
414:                 WITH .cmd_4c_BtnData
415:                     .Top       = 3
416:                     .Left      = 4
417:                     .Width     = 186
418:                     .Height    = 42
419:                     .FontBold  = .T.
420:                     .FontName  = "Verdana"
421:                     .FontSize  = 10
422:                     .WordWrap  = .T.
423:                     .Caption   = "00/00/0000"
424:                     .ForeColor = RGB(90,90,90)
425:                     .BackColor = RGB(255,255,255)
426:                     .Enabled   = .F.
427:                     .Visible   = .T.
428:                 ENDWITH
429: 
430:                 *-- Separador superior
431:                 .AddObject("cnt_4c__periodo", "Container")
432:                 WITH .cnt_4c__periodo
433:                     .Top           = 47
434:                     .Left          = 4
435:                     .Width         = 186
436:                     .Height        = 6
437:                     .SpecialEffect = 0
438:                     .BackColor     = RGB(255,255,255)
439:                     .Visible       = .T.
440:                 ENDWITH
441: 
442:                 *-- Label M?s/Ano
443:                 .AddObject("lbl_4c_LblMesAno", "Label")
444:                 WITH .lbl_4c_LblMesAno
445:                     .FontBold  = .T.
446:                     .FontName  = "Verdana"
447:                     .Caption   = "M" + CHR(234) + "s / Ano :"
448:                     .Left      = 36
449:                     .Top       = 70
450:                     .ForeColor = RGB(90,90,90)
451:                     .BackStyle = 0
452:                     .AutoSize  = .T.
453:                     .Visible   = .T.
454:                 ENDWITH
455: 
456:                 *-- TextBox M?s (char, aceita 2 d?gitos)
457:                 .AddObject("txt_4c_Mes", "TextBox")
458:                 WITH .txt_4c_Mes
459:                     .InputMask         = "99"
460:                     .Value             = ""
461:                     .Left              = 113
462:                     .Top               = 67
463:                     .Width             = 24
464:                     .Height            = 20
465:                     .DisabledBackColor = RGB(255,255,230)
466:                     .DisabledForeColor = RGB(0,0,128)
467:                     .Visible           = .T.
468:                 ENDWITH
469: 
470:                 *-- Label separador /
471:                 .AddObject("lbl_4c_LblSep", "Label")
472:                 WITH .lbl_4c_LblSep
473:                     .FontBold  = .T.
474:                     .FontName  = "Verdana"
475:                     .FontSize  = 12
476:                     .Caption   = "/"
477:                     .Left      = 138
478:                     .Top       = 69
479:                     .ForeColor = RGB(90,90,90)
480:                     .BackStyle = 0
481:                     .AutoSize  = .T.
482:                     .Visible   = .T.
483:                 ENDWITH
484: 
485:                 *-- TextBox Ano (char, aceita 4 d?gitos)
486:                 .AddObject("txt_4c_Ano", "TextBox")
487:                 WITH .txt_4c_Ano
488:                     .InputMask         = "9999"
489:                     .Value             = ""
490:                     .Left              = 149
491:                     .Top               = 67
492:                     .Width             = 38
493:                     .Height            = 20
494:                     .DisabledBackColor = RGB(255,255,230)
495:                     .DisabledForeColor = RGB(0,0,128)
496:                     .Visible           = .T.
497:                 ENDWITH
498: 
499:                 *-- Label Quantidade
500:                 .AddObject("lbl_4c_LblQtds", "Label")
501:                 WITH .lbl_4c_LblQtds
502:                     .FontBold  = .T.
503:                     .FontName  = "Verdana"
504:                     .Caption   = "Quantidade :"
505:                     .Left      = 28
506:                     .Top       = 97
507:                     .ForeColor = RGB(90,90,90)
508:                     .BackStyle = 0
509:                     .AutoSize  = .T.
510:                     .Visible   = .T.
511:                 ENDWITH
512: 
513:                 *-- TextBox Quantidade (num?rico)
514:                 .AddObject("txt_4c_Qtds", "TextBox")
515:                 WITH .txt_4c_Qtds
516:                     .InputMask         = "99"
517:                     .Value             = 0
518:                     .Left              = 113
519:                     .Top               = 93
520:                     .Width             = 24
521:                     .Height            = 20
522:                     .DisabledBackColor = RGB(255,255,230)
523:                     .DisabledForeColor = RGB(0,0,128)
524:                     .Visible           = .T.
525:                 ENDWITH
526: 
527:                 *-- Label Horas por Dia
528:                 .AddObject("lbl_4c_LblQtHoras", "Label")
529:                 WITH .lbl_4c_LblQtHoras
530:                     .FontBold  = .T.
531:                     .FontName  = "Verdana"
532:                     .Caption   = "Horas por Dia:"
533:                     .Left      = 17
534:                     .Top       = 122
535:                     .ForeColor = RGB(90,90,90)
536:                     .BackStyle = 0
537:                     .AutoSize  = .T.
538:                     .Visible   = .T.
539:                 ENDWITH
540: 
541:                 *-- TextBox QtHoras (num?rico, formato HHH.MM)
542:                 .AddObject("txt_4c_QtHoras", "TextBox")
543:                 WITH .txt_4c_QtHoras
544:                     .InputMask         = "999.99"
545:                     .Value             = 0
546:                     .Left              = 113
547:                     .Top               = 118
548:                     .Width             = 52
549:                     .Height            = 20
550:                     .DisabledBackColor = RGB(255,255,230)
551:                     .DisabledForeColor = RGB(0,0,128)
552:                     .Visible           = .T.
553:                 ENDWITH
554: 
555:                 *-- Separador inferior
556:                 .AddObject("cnt_4c_Container1", "Container")
557:                 WITH .cnt_4c_Container1
558:                     .Top           = 151
559:                     .Left          = 4
560:                     .Width         = 186
561:                     .Height        = 6
562:                     .SpecialEffect = 0
563:                     .BackColor     = RGB(255,255,255)
564:                     .Visible       = .T.
565:                 ENDWITH
566: 
567:                 *-- Label Total de Horas
568:                 .AddObject("lbl_4c_LblTotHoras", "Label")
569:                 WITH .lbl_4c_LblTotHoras
570:                     .FontBold  = .T.
571:                     .FontName  = "Tahoma"
572:                     .Caption   = "Total de Horas :"
573:                     .Left      = 13
574:                     .Top       = 168
575:                     .ForeColor = RGB(90,90,90)
576:                     .BackStyle = 0
577:                     .AutoSize  = .T.
578:                     .Visible   = .T.
579:                 ENDWITH
580: 
581:                 *-- TextBox Total de Horas (somente leitura)
582:                 .AddObject("txt_4c_TotHoras", "TextBox")
583:                 WITH .txt_4c_TotHoras
584:                     .InputMask         = "999.99"
585:                     .Value             = 0
586:                     .Enabled           = .F.
587:                     .Left              = 120
588:                     .Top               = 164
589:                     .Width             = 52
590:                     .Height            = 20
591:                     .DisabledBackColor = RGB(255,255,230)
592:                     .DisabledForeColor = RGB(0,0,128)
593:                     .Visible           = .T.

*-- Linhas 602 a 687:
602:             THIS.AddObject("obj_4c_CmdEscolha", "CommandGroup")
603:             WITH THIS.obj_4c_CmdEscolha
604:                 .ButtonCount   = 4
605:                 .Top           = -1
606:                 .Left          = 247
607:                 .Width         = 312
608:                 .Height        = 85
609:                 .BorderStyle   = 0
610:                 .SpecialEffect = 1
611:                 .BorderColor   = RGB(136,189,188)
612:                 .Value         = 0
613:                 .Visible       = .T.
614: 
615:                 WITH .Buttons(1)
616:                     .Name        = "btnInserir"
617:                     .Top         = 5
618:                     .Left        = 5
619:                     .Width       = 75
620:                     .Height      = 75
621:                     .FontBold    = .T.
622:                     .FontItalic  = .T.
623:                     .WordWrap    = .T.
624:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
625:                     .Caption     = "\<Inserir"
626:                     .ToolTipText = "Inserir Um Novo Per" + CHR(237) + "odo"
627:                     .ForeColor   = RGB(90,90,90)
628:                     .BackColor   = RGB(255,255,255)
629:                     .Themes      = .F.
630:                 ENDWITH
631: 
632:                 WITH .Buttons(2)
633:                     .Name        = "btnAlterar"
634:                     .Top         = 5
635:                     .Left        = 82
636:                     .Width       = 75
637:                     .Height      = 75
638:                     .FontBold    = .T.
639:                     .FontItalic  = .T.
640:                     .FontName    = "Comic Sans MS"
641:                     .FontSize    = 8
642:                     .WordWrap    = .T.
643:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
644:                     .Caption     = "\<Alterar"
645:                     .ToolTipText = "Alterar o Per" + CHR(237) + "odo"
646:                     .ForeColor   = RGB(90,90,90)
647:                     .BackColor   = RGB(255,255,255)
648:                     .Themes      = .F.
649:                 ENDWITH
650: 
651:                 WITH .Buttons(3)
652:                     .Name        = "btnExcluir"
653:                     .Top         = 5
654:                     .Left        = 157
655:                     .Width       = 75
656:                     .Height      = 75
657:                     .FontBold    = .T.
658:                     .FontItalic  = .T.
659:                     .FontName    = "Comic Sans MS"
660:                     .FontSize    = 8
661:                     .WordWrap    = .T.
662:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
663:                     .Caption     = "\<Excluir"
664:                     .ToolTipText = "Excluir o Per" + CHR(237) + "odo"
665:                     .ForeColor   = RGB(90,90,90)
666:                     .BackColor   = RGB(255,255,255)
667:                     .Themes      = .F.
668:                 ENDWITH
669: 
670:                 WITH .Buttons(4)
671:                     .Name        = "btnCopiarP"
672:                     .Top         = 5
673:                     .Left        = 232
674:                     .Width       = 75
675:                     .Height      = 75
676:                     .FontBold    = .T.
677:                     .FontItalic  = .T.
678:                     .FontName    = "Comic Sans MS"
679:                     .FontSize    = 8
680:                     .WordWrap    = .T.
681:                     .Picture     = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
682:                     .Caption     = "\<Copiar"
683:                     .ToolTipText = "Copiar o Per" + CHR(237) + "odo Para Um Novo"
684:                     .ForeColor   = RGB(90,90,90)
685:                     .BackColor   = RGB(255,255,255)
686:                     .Themes      = .F.
687:                 ENDWITH

*-- Linhas 696 a 764:
696:             THIS.AddObject("obj_4c_CmdSalva", "CommandGroup")
697:             WITH THIS.obj_4c_CmdSalva
698:                 .ButtonCount   = 3
699:                 .Top           = -1
700:                 .Left          = 572
701:                 .Width         = 235
702:                 .Height        = 85
703:                 .BorderStyle   = 0
704:                 .SpecialEffect = 1
705:                 .BorderColor   = RGB(136,189,188)
706:                 .Value         = 1
707:                 .Visible       = .T.
708: 
709:                 WITH .Buttons(1)
710:                     .Name        = "btnConfirmar"
711:                     .Top         = 5
712:                     .Left        = 5
713:                     .Width       = 75
714:                     .Height      = 75
715:                     .FontBold    = .T.
716:                     .FontItalic  = .T.
717:                     .WordWrap    = .T.
718:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
719:                     .Caption     = "\<Salvar"
720:                     .ToolTipText = "Gravar os Dados"
721:                     .ForeColor   = RGB(90,90,90)
722:                     .BackColor   = RGB(255,255,255)
723:                     .Themes      = .F.
724:                 ENDWITH
725: 
726:                 WITH .Buttons(2)
727:                     .Name        = "btnSair"
728:                     .Top         = 5
729:                     .Left        = 155
730:                     .Width       = 75
731:                     .Height      = 75
732:                     .FontBold    = .T.
733:                     .FontItalic  = .T.
734:                     .FontName    = "Comic Sans MS"
735:                     .FontSize    = 8
736:                     .WordWrap    = .T.
737:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
738:                     .Cancel      = .T.
739:                     .Caption     = "Encerrar"
740:                     .ToolTipText = "Sair do Cadastro"
741:                     .ForeColor   = RGB(90,90,90)
742:                     .BackColor   = RGB(255,255,255)
743:                     .Themes      = .F.
744:                 ENDWITH
745: 
746:                 WITH .Buttons(3)
747:                     .Name        = "btnCancelar"
748:                     .Top         = 5
749:                     .Left        = 80
750:                     .Width       = 75
751:                     .Height      = 75
752:                     .FontBold    = .T.
753:                     .FontItalic  = .T.
754:                     .FontName    = "Comic Sans MS"
755:                     .FontSize    = 8
756:                     .WordWrap    = .T.
757:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
758:                     .Cancel      = .T.
759:                     .Caption     = "Ca\<ncelar"
760:                     .ToolTipText = "Cancelar os Dados"
761:                     .ForeColor   = RGB(90,90,90)
762:                     .BackColor   = RGB(255,255,255)
763:                     .Themes      = .F.
764:                 ENDWITH

*-- Linhas 860 a 870:
860: 
861:                 LOCAL loc_nB
862:                 FOR loc_nB = 1 TO 42
863:                     WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + PADL(loc_nB, 2, "0"))
864:                         .ForeColor = RGB(0,0,0)
865:                         .Caption   = "  00   000:00"
866:                         .Enabled   = .F.
867:                     ENDWITH
868:                 NEXT
869:             ENDIF
870: 

*-- Linhas 937 a 953:
937:                             loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
938:                             loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")
939: 
940:                             WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
941:                                 .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
942:                                 .Caption   = "  " + SUBSTR(DTOC(loc_ldDia), 1, 2) + "   " + loc_cHrr
943:                                 .Enabled   = .T.
944:                             ENDWITH
945:                         ELSE
946:                             WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
947:                                 .ForeColor = RGB(0,0,0)
948:                                 .Caption   = "  00   000:00"
949:                                 .Enabled   = .F.
950:                             ENDWITH
951:                         ENDIF
952:                     NEXT
953: 

*-- Linhas 966 a 976:
966:                     *-- M?s sem dados: reset visual
967:                     FOR loc_nObj = 1 TO 42
968:                         loc_cObj = PADL(loc_nObj, 2, "0")
969:                         WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
970:                             .ForeColor = RGB(216,39,70)
971:                             .Caption   = "  00   000:00"
972:                             .Enabled   = .F.
973:                         ENDWITH
974:                     NEXT
975: 
976:                     THIS.AjustarTela()

*-- Linhas 1012 a 1020:
1012: 
1013:                     WITH THIS.cnt_4c_Dados
1014:                         .Visible = .T.
1015:                         .cmd_4c_BtnData.Caption = SUBSTR(DTOC(loc_ldDat), 1, 2) + "/" + ;
1016:                                                   crMesAno.Mes + "/" + crMesAno.Ano
1017:                         .txt_4c_Mes.Value       = crMesAno.Mes
1018:                         .txt_4c_Ano.Value       = crMesAno.Ano
1019: 
1020:                         .txt_4c_Mes.Enabled     = INLIST(loc_cEscolha, "INSERIR", "COPIARP")

*-- Linhas 1073 a 1083:
1073:                     loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
1074:                     loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")
1075: 
1076:                     WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cSlot)
1077:                         .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
1078:                         .Caption   = "  " + SUBSTR(DTOC(loc_ldDat), 1, 2) + "   " + loc_cHrr
1079:                     ENDWITH
1080: 
1081:                     THIS.cnt_4c_Dados.txt_4c_TotHoras.Value = loc_nHor
1082:                 ENDIF
1083:             ENDIF

*-- Linhas 1102 a 1110:
1102:                 loc_cNome = ALLTRIM(THIS.ActiveControl.Name)
1103:             ENDIF
1104: 
1105:             IF LEFT(loc_cNome, 10) = "cmd_4c_Chk"
1106:                 loc_cSlot = SUBSTR(loc_cNome, 11, 2)
1107:                 THIS.ValidarDias(loc_cSlot)
1108:             ENDIF
1109:         CATCH TO loc_oErro
1110:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1146 a 1154:
1146:                 .grd_4c_Dados.Enabled              = .F.
1147:                 .cnt_4c_Calendario.Enabled          = .F.
1148:                 .cnt_4c_Dados.Visible               = .T.
1149:                 .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Inserir"
1150:                 .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
1151:                 .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
1152:                 .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
1153:                 .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
1154:                 .cnt_4c_Dados.txt_4c_Mes.Value      = ""

*-- Linhas 1231 a 1239:
1231:                 .grd_4c_Dados.Enabled              = .F.
1232:                 .cnt_4c_Calendario.Enabled          = .F.
1233:                 .cnt_4c_Dados.Visible               = .T.
1234:                 .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Excluir"
1235:                 .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
1236:                 .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
1237:                 .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
1238:                 .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
1239:             ENDWITH

*-- Linhas 1274 a 1282:
1274:                     .grd_4c_Dados.Enabled              = .F.
1275:                     .cnt_4c_Calendario.Enabled          = .F.
1276:                     .cnt_4c_Dados.Visible               = .T.
1277:                     .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Copiar " + crMesAno.Mes + "/" + crMesAno.Ano
1278:                     .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
1279:                     .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
1280:                     .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
1281:                     .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
1282:                     .cnt_4c_Dados.txt_4c_Mes.Value      = ""

*-- Linhas 1434 a 1442:
1434:         TRY
1435:             WITH THIS.cnt_4c_Dados
1436:                 .Visible                 = .T.
1437:                 .cmd_4c_BtnData.Caption  = "00/00/0000"
1438: 
1439:                 .txt_4c_Mes.Value        = ""
1440:                 .txt_4c_Mes.Enabled      = .F.
1441: 
1442:                 .txt_4c_Ano.Value        = ""

*-- Linhas 1677 a 1688:
1677: 
1678:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMes) AND ;
1679:                    !EMPTY(THIS.this_oBusinessObject.this_cAno)
1680:                     .cmd_4c_BtnData.Caption = THIS.this_oBusinessObject.this_cMes + ;
1681:                                              "/" + THIS.this_oBusinessObject.this_cAno
1682:                 ELSE
1683:                     .cmd_4c_BtnData.Caption = "00/00/0000"
1684:                 ENDIF
1685: 
1686:                 .txt_4c_TotHoras.Value = THIS.this_oBusinessObject.ConverterHorasParaDecimal( ;
1687:                     THIS.this_oBusinessObject.this_nQtHoras, ;
1688:                     THIS.this_oBusinessObject.this_nQtds)

*-- Linhas 1753 a 1761:
1753:         LOCAL loc_oErro
1754:         TRY
1755:             WITH THIS.cnt_4c_Dados
1756:                 .cmd_4c_BtnData.Caption = "00/00/0000"
1757:                 .txt_4c_Mes.Value       = ""
1758:                 .txt_4c_Ano.Value       = ""
1759:                 .txt_4c_Qtds.Value      = 0
1760:                 .txt_4c_QtHoras.Value   = 0
1761:                 .txt_4c_TotHoras.Value  = 0


### BO (C:\4c\projeto\app\classes\HORBO.prg):
*==============================================================================
* HORBO.prg - Business Object: Cadastro de Carga Hor?ria
* Tabela principal : SigCdThs
* Chave prim?ria  : cidchaves
* Form OPERACIONAL: recebe pCod (Fase/Setor) e pUni (Unidade Produtiva)
*==============================================================================
* Colunas SigCdThs : cidchaves c(20) PK, codigos n(6,0), datas datetime,
*                    qtds n(4,1), qthoras n(4,2), setors c(10), uniprdts c(10)
* Colunas SigCdUpd : cidchaves c(20) PK, codigos c(10), ddsems n(1,0),
*                    hordds n(4,2), uniprdts c(10), ordems n(2,0), qtdes n(2,0)
* Colunas SigCdGcr : codigos c(10) PK, descrs c(40)
*==============================================================================

DEFINE CLASS HORBO AS BusinessBase

    *-- Identifica??o da tabela
    this_cTabela      = "SigCdThs"
    this_cCampoChave  = "cidchaves"

    *-- Par?metros do form (recebidos do caller)
    this_cSetors      = ""      && Fase/Setor - char(10) - coluna setors
    this_cUniPrdts    = ""      && Unidade Produtiva - char(10) - coluna uniprdts
    this_cDFases      = ""      && Descri??o da Fase (SigCdGcr.descrs)

    *-- Modo de opera??o (equivalente a pcEscolha do legado)
    this_cPcEscolha   = ""      && CONSULTAR / INSERIR / ALTERAR / EXCLUIR / COPIARP

    *-- Dados do registro corrente (SigCdThs)
    this_cCidChaves   = ""      && PK - char(20) - coluna cidchaves
    this_dDatas       = {}      && Data do registro - coluna datas (datetime)
    this_nQtds        = 0       && Quantidade - numeric(4,1) - coluna qtds
    this_nQtHoras     = 0       && Horas por dia - numeric(4,2) - coluna qthoras

    *-- Sele??o de per?odo (para modos INSERIR / COPIARP)
    this_cMes         = ""      && M?s selecionado - char(2)
    this_cAno         = ""      && Ano selecionado - char(4)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    FUNCTION Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave prim?ria do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDescricaoFase - Busca descri??o da Fase/Setor em SigCdGcr
    * Retorna: .T. se encontrado, .F. se n?o encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarDescricaoFase()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_cDFases = ""

            IF !EMPTY(THIS.this_cSetors)
                loc_cSQL = "SELECT descrs FROM SigCdGcr " + ;
                           "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10))

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFase")
                IF loc_nRet > 0 AND USED("cursor_4c_DescFase") AND !EOF("cursor_4c_DescFase")
                    THIS.this_cDFases = ALLTRIM(cursor_4c_DescFase.descrs)
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDescricaoFase")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGradeMesAno - Carrega cursor crMesAno com meses/anos existentes
    * em SigCdThs para o Setor e Unidade Produtiva atuais
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarGradeMesAno()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("crMesAno")
                ZAP IN crMesAno

                loc_cSQL = "SELECT DISTINCT datas " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " ORDER BY datas"

                IF USED("cursor_4c_DatasTemp")
                    USE IN cursor_4c_DatasTemp
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DatasTemp")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarGradeMesAno).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    *-- Extrai mes/ano distintos do cursor de datas
                    SELECT DISTINCT ;
                        SUBSTR(DTOS(NVL(datas, CTOD(""))), 5, 2) AS Mes, ;
                        SUBSTR(DTOS(NVL(datas, CTOD(""))), 1, 4) AS Ano ;
                    FROM cursor_4c_DatasTemp ;
                    INTO CURSOR cursor_4c_MesAnoTemp READWRITE

                    SELECT cursor_4c_MesAnoTemp
                    SCAN
                        INSERT INTO crMesAno (Mes, Ano) ;
                            VALUES (m.cursor_4c_MesAnoTemp.Mes, m.cursor_4c_MesAnoTemp.Ano)
                    ENDSCAN

                    IF USED("cursor_4c_DatasTemp")
                        USE IN cursor_4c_DatasTemp
                    ENDIF
                    IF USED("cursor_4c_MesAnoTemp")
                        USE IN cursor_4c_MesAnoTemp
                    ENDIF

                    *-- Posiciona no m?s corrente se existir
                    SET NEAR ON
                    =SEEK(SUBSTR(DTOS(DATE()), 1, 6), "crMesAno", "Ordem")
                    SET NEAR OFF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarGradeMesAno")

            IF USED("cursor_4c_DatasTemp")
                USE IN cursor_4c_DatasTemp
            ENDIF
            IF USED("cursor_4c_MesAnoTemp")
                USE IN cursor_4c_MesAnoTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCalendario - Carrega crCalendario para o mes/ano informado
    * par_cMes   : Mes desejado (char 2, ex: "08")
    * par_cAno   : Ano desejado (char 4, ex: "2026")
    * par_lTrunc  : .T. = truncar e recalcular dias; .F. = apenas carregar
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarCalendario(par_cMes, par_cAno, par_lTrunc)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDia, loc_ldDtF, loc_ldDtI
        LOCAL loc_nDow, loc_ldDay
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_nHor, loc_nQts
        LOCAL loc_llZer
        LOCAL loc_nDia, loc_nObj, loc_cObj
        LOCAL loc_nHorTotal, loc_nQth, loc_nQtd
        LOCAL loc_cHrr
        loc_lSucesso = .F.

        TRY
            IF USED("crCalendario")
                loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                *-- Busca dados de SigCdThs para o per?odo
                loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDia, 1) - 1, .T.)

                loc_cSQL = "SELECT * " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                IF USED("cursor_4c_TmpCtHr")
                    USE IN cursor_4c_TmpCtHr
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCtHr")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    SELECT cursor_4c_TmpCtHr
                    INDEX ON DTOS(NVL(datas, CTOD(""))) TAG Datas

                    *-- Modo truncar: recalcula horas conforme SigCdUpd
                    LOCAL loc_lTruncOk
                    loc_lTruncOk = .T.
                    IF par_lTrunc
                        loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                                   "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                   " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                        IF loc_nRet < 1
                            MsgErro("Falha ao consultar SigCdUpd (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                            IF USED("cursor_4c_TmpCtHr")
                                USE IN cursor_4c_TmpCtHr
                            ENDIF
                            loc_lTruncOk = .F.
                        ELSE
                            GO TOP IN cursor_4c_LocalUPrdt

                            loc_nHds = cursor_4c_LocalUPrdt.hordds
                            loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                            loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                            FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDia, 1) - 1)
                                loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + par_cMes + "/" + par_cAno)

                                loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                                loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                                loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                                IF SEEK(DTOS(loc_ldDay), "cursor_4c_TmpCtHr", "Datas")
                                    SELECT cursor_4c_TmpCtHr
                                    REPLACE qtds    WITH loc_nQts, ;
                                            qthoras WITH loc_nHor
                                ELSE
                                    INSERT INTO cursor_4c_TmpCtHr ;
                                        (setors, uniprdts, datas, qtds, qthoras) ;
                                    VALUES ;
                                        (THIS.this_cSetors, THIS.this_cUniPrdts, ;
                                         loc_ldDay, loc_nQts, loc_nHor)
                                ENDIF
                            NEXT

                            IF USED("cursor_4c_LocalUPrdt")
                                USE IN cursor_4c_LocalUPrdt
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lTruncOk
                        *-- Alimenta crCalendario com dados do m?s
                        ZAP IN crCalendario

                        IF RECCOUNT("cursor_4c_TmpCtHr") > 0
                            APPEND BLANK IN crCalendario
                            GO TOP IN crCalendario

                            loc_nDow = 1
                            loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                            FOR loc_nObj = 1 TO 42
                                loc_cObj = PADL(loc_nObj, 2, "0")

                                *-- Limpa slot do calend?rio
                                SELECT crCalendario
                                REPLACE ("Data"    + loc_cObj) WITH CTOD(""), ;
                                        ("QtHoras" + loc_cObj) WITH 0, ;
                                        ("Qtds"    + loc_cObj) WITH 0

                                IF loc_nDow = DOW(loc_ldDia) AND MONTH(loc_ldDia) = INT(VAL(par_cMes))
                                    loc_nHorTotal = 0
                                    loc_nQth = 0
                                    loc_nQtd = 0

                                    IF SEEK(DTOS(loc_ldDia), "cursor_4c_TmpCtHr", "Datas")
                                        loc_nQth      = cursor_4c_TmpCtHr.qthoras
                                        loc_nQtd      = cursor_4c_TmpCtHr.qtds
                                        loc_nHorTotal = THIS.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                                    ENDIF

                                    SELECT crCalendario
                                    REPLACE ("Data"    + loc_cObj) WITH loc_ldDia, ;
                                            ("QtHoras" + loc_cObj) WITH loc_nQth, ;
                                            ("Qtds"    + loc_cObj) WITH loc_nQtd

                                    loc_ldDia = loc_ldDia + 1
                                ENDIF

                                loc_nDow = loc_nDow + 1
                                IF loc_nDow > 7
                                    loc_nDow = 1
                                ENDIF
                            NEXT
                        ENDIF

                        IF USED("cursor_4c_TmpCtHr")
                            USE IN cursor_4c_TmpCtHr
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarCalendario")

            IF USED("cursor_4c_TmpCtHr")
                USE IN cursor_4c_TmpCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPeriodo - Insere novo per?odo de carga hor?ria
    * par_cMes : M?s do per?odo (char 2)
    * par_cAno : Ano do per?odo (char 4)
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION InserirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_ldDay, loc_llZer, loc_nHor, loc_nQts
        LOCAL loc_nDia
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            *-- Verifica se j? existem lan?amentos no per?odo
            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtHr")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkCtHr") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF

                    *-- Busca configura??o da unidade produtiva em SigCdUpd
                    loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                               "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                    IF USED("cursor_4c_LocalUPrdt")
                        USE IN cursor_4c_LocalUPrdt
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar SigCdUpd (InserirPeriodo).", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        GO TOP IN cursor_4c_LocalUPrdt

                        loc_nHds = cursor_4c_LocalUPrdt.hordds
                        loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                        loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        *-- Cria cursor de work para inser??o em lote
                        IF USED("crSigCdThs")
                            TABLEREVERT(.T., "crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        SET NULL ON
                        CREATE CURSOR crSigCdThs ;
                            (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                             qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                             setors C(10) NULL, uniprdts C(10) NULL)
                        SET NULL OFF

                        *-- Insere um registro por dia do m?s
                        FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDat, 1) - 1)
                            loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))

                            loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                            loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                            loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                            SELECT crSigCdThs
                            APPEND BLANK
                            REPLACE setors    WITH THIS.this_cSetors, ;
                                    uniprdts  WITH THIS.this_cUniPrdts, ;
                                    qtds      WITH loc_nQts, ;
                                    qthoras   WITH loc_nHor, ;
                                    datas     WITH loc_ldDay, ;
                                    cidchaves WITH THIS.GerarChaveUnica()
                        NEXT

                        *-- Envia para SQL Server via SQLEXEC INSERT em lote
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                        IF USED("crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        *-- Atualiza crMesAno se o m?s n?o existia
                        IF loc_lSucesso AND USED("crMesAno")
                            IF !SEEK(SUBSTR(DTOS(loc_ldDat), 1, 6), "crMesAno", "Ordem")
                                INSERT INTO crMesAno (Mes, Ano) ;
                                    VALUES (SUBSTR(DTOS(loc_ldDat), 5, 2), SUBSTR(DTOS(loc_ldDat), 1, 4))
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.InserirPeriodo")

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlterarPeriodo - Altera dados do per?odo atual a partir de crCalendario
    * Retorna: .T. se alterado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION AlterarPeriodo()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_nObj, loc_cObj, loc_ldDia
        LOCAL loc_ldDtI, loc_ldDtF
        LOCAL loc_nQth, loc_nQtd
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            IF USED("crCalendario")
                IF USED("crSigCdThs")
                    TABLEREVERT(.T., "crSigCdThs")
                    USE IN crSigCdThs
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigCdThs ;
                    (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                     qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                     setors C(10) NULL, uniprdts C(10) NULL)
                SET NULL OFF

                LOCAL loc_lLoopOk
                loc_lLoopOk = .T.

                FOR loc_nObj = 1 TO 42
                    IF loc_lLoopOk
                        loc_cObj = PADL(loc_nObj, 2, "0")
                        SELECT crCalendario
                        loc_ldDia = EVALUATE("Data" + loc_cObj)

                        IF !EMPTY(loc_ldDia)
                            loc_nQth = EVALUATE("QtHoras" + loc_cObj)
                            loc_nQtd = EVALUATE("Qtds"    + loc_cObj)

                            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                            loc_ldDtF = THIS.FormatarDataSQL(loc_ldDia, .T.)

                            *-- Busca registro existente para o dia
                            loc_cSQL = "SELECT * FROM SigCdThs " + ;
                                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                            IF loc_nRet < 1
                                MsgErro("Falha ao consultar SigCdThs (AlterarPeriodo).", "Erro de Conex" + CHR(227) + "o")
                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF
                                loc_lLoopOk = .F.
                            ELSE
                                SELECT crSigCdThs
                                IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                                    *-- Existe: copia e atualiza horas/qtd
                                    GO TOP IN cursor_4c_LocalCtHr
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE cidchaves WITH cursor_4c_LocalCtHr.cidchaves, ;
                                            codigos   WITH cursor_4c_LocalCtHr.codigos, ;
                                            datas     WITH cursor_4c_LocalCtHr.datas, ;
                                            setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth
                                ELSE
                                    *-- N?o existe: insere novo registro
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE setors    WITH THIS.this_cSetors, ;
                                            uniprdts  WITH THIS.this_cUniPrdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth, ;
                                            datas     WITH loc_ldDia, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                ENDIF

                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF

                                loc_lUpd = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                NEXT

                IF loc_lLoopOk
                    IF loc_lUpd
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                IF USED("crSigCdThs")
                    USE IN crSigCdThs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.AlterarPeriodo")

            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirPeriodo - Exclui todos os registros do per?odo (mes/ano)
    * par_cMes : M?s a excluir (char 2)
    * par_cAno : Ano a excluir (char 4)
    * Retorna: .T. se exclu?do com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION ExcluirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            loc_cSQL = "DELETE FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult")
            IF loc_nRet < 1
                MsgErro("Falha ao excluir per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_DelResult")
                    USE IN cursor_4c_DelResult
                ENDIF

                *-- Remove da crMesAno
                IF USED("crMesAno")
                    DELETE FROM crMesAno ;
                    WHERE Mes = SUBSTR(DTOS(loc_ldDat), 5, 2) AND ;
                          Ano = SUBSTR(DTOS(loc_ldDat), 1, 4)
                    PACK IN crMesAno
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.ExcluirPeriodo")

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CopiarPeriodo - Copia per?odo do mes/ano selecionado para outro mes/ano
    * par_cMesOrig : M?s de origem (mes do crMesAno selecionado no grid)
    * par_cAnoOrig : Ano de origem
    * par_cMesDest : M?s de destino (digitado pelo usu?rio)
    * par_cAnoDest : Ano de destino (digitado pelo usu?rio)
    * Retorna: .T. se copiado com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION CopiarPeriodo(par_cMesOrig, par_cAnoOrig, par_cMesDest, par_cAnoDest)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_ldDatDest, loc_ldDtI, loc_ldDtF
        LOCAL loc_ldDatOrig, loc_ldDtIOrig, loc_ldDtFOrig
        LOCAL loc_ldDtn
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            *-- Verifica se destino j? tem lan?amentos
            loc_ldDatDest = CTOD("01/" + PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDatDest)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDatDest, 1) - 1, .T.)

            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDest")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar destino em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkDest") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF

                    *-- Busca registros de origem
                    loc_ldDatOrig = CTOD("01/" + PADL(par_cMesOrig, 2, "0") + "/" + PADL(par_cAnoOrig, 4, "0"))
                    loc_ldDtIOrig = THIS.FormatarDataSQL(loc_ldDatOrig)
                    loc_ldDtFOrig = THIS.FormatarDataSQL(GOMONTH(loc_ldDatOrig, 1) - 1, .T.)

                    loc_cSQL = "SELECT * FROM SigCdThs " + ;
                               "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + loc_ldDtIOrig + " AND " + loc_ldDtFOrig

                    IF USED("cursor_4c_LocalCtHr")
                        USE IN cursor_4c_LocalCtHr
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar origem em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                            IF USED("crSigCdThs")
                                TABLEREVERT(.T., "crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF

                            SET NULL ON
                            CREATE CURSOR crSigCdThs ;
                                (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                                 qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                                 setors C(10) NULL, uniprdts C(10) NULL)
                            SET NULL OFF

                            SELECT cursor_4c_LocalCtHr
                            SCAN
                                *-- Ajusta dia para o m?s destino
                                loc_ldDtn = CTOD(SUBSTR(DTOC(cursor_4c_LocalCtHr.datas), 1, 3) + ;
                                                 PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))

                                IF !EMPTY(loc_ldDtn)
                                    SELECT crSigCdThs
                                    APPEND BLANK
                                    REPLACE setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH cursor_4c_LocalCtHr.qtds, ;
                                            qthoras   WITH cursor_4c_LocalCtHr.qthoras, ;
                                            datas     WITH loc_ldDtn, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                    loc_lUpd = .T.
                                ENDIF
                            ENDSCAN

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            IF loc_lUpd
                                loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                                *-- Atualiza crMesAno com o novo per?odo
                                IF loc_lSucesso AND USED("crMesAno") AND !EMPTY(loc_ldDtn)
                                    INSERT INTO crMesAno (Mes, Ano) ;
                                        VALUES (SUBSTR(DTOS(loc_ldDtn), 5, 2), SUBSTR(DTOS(loc_ldDtn), 1, 4))
                                ENDIF
                            ELSE
                                loc_lSucesso = .T.
                            ENDIF

                            IF USED("crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF
                        ELSE
                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CopiarPeriodo")

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF
            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnviarCursorParaServidor - Insere/atualiza registros de crSigCdThs
    * no SQL Server usando SQLEXEC por registro
    * Retorna: .T. se todos enviados com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EnviarCursorParaServidor(par_cCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_nCodigos, loc_ldDatas
        LOCAL loc_nQtds, loc_nQtHoras, loc_cSetors, loc_cUniPrdts
        loc_lSucesso = .T.

        TRY
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                SELECT (par_cCursor)
                GO TOP

                SCAN
                    loc_cCidChaves = ALLTRIM(EVALUATE(par_cCursor + ".cidchaves"))
                    loc_nCodigos   = EVALUATE(par_cCursor + ".codigos")
                    loc_ldDatas    = EVALUATE(par_cCursor + ".datas")
                    loc_nQtds      = EVALUATE(par_cCursor + ".qtds")
                    loc_nQtHoras   = EVALUATE(par_cCursor + ".qthoras")
                    loc_cSetors    = ALLTRIM(EVALUATE(par_cCursor + ".setors"))
                    loc_cUniPrdts  = ALLTRIM(EVALUATE(par_cCursor + ".uniprdts"))

                    *-- Tenta UPDATE primeiro
                    loc_cSQL = "UPDATE SigCdThs " + ;
                               "SET qtds = " + FormatarNumeroSQL(loc_nQtds, 1) + ;
                               ", qthoras = " + FormatarNumeroSQL(loc_nQtHoras, 2) + ;
                               " WHERE setors = " + EscaparSQL(PADR(loc_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + THIS.FormatarDataSQL(loc_ldDatas) + ;
                               " AND " + THIS.FormatarDataSQL(loc_ldDatas, .T.)

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdResult")

                    IF USED("cursor_4c_UpdResult")
                        USE IN cursor_4c_UpdResult
                    ENDIF

                    *-- Verifica linhas afetadas: 0 = novo registro, faz INSERT
                    LOCAL loc_nAffected
                    loc_nAffected = 0
                    IF loc_nRet >= 1
                        IF SQLEXEC(gnConnHandle, "SELECT @@ROWCOUNT AS rn", "cursor_4c_RowCnt") >= 1
                            loc_nAffected = cursor_4c_RowCnt.rn
                        ENDIF
                        IF USED("cursor_4c_RowCnt")
                            USE IN cursor_4c_RowCnt
                        ENDIF
                    ENDIF

                    *-- Se UPDATE nao afetou nenhuma linha, faz INSERT
                    IF loc_nRet < 1 OR loc_nAffected = 0
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF
                        loc_cSQL = "INSERT INTO SigCdThs " + ;
                                   "(cidchaves, codigos, setors, uniprdts, datas, qtds, qthoras) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", 0, " + ;
                                   EscaparSQL(PADR(loc_cSetors, 10)) + ", " + ;
                                   EscaparSQL(PADR(loc_cUniPrdts, 10)) + ", " + ;
                                   THIS.FormatarDataSQL(loc_ldDatas) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtds, 1) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtHoras, 2) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult")
                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF

                        IF loc_nRet < 1
                            MsgErro("Falha ao inserir registro em SigCdThs.", "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.EnviarCursorParaServidor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave prim?ria ?nica (char 20)
    * Usa NEWID() do SQL Server para gerar GUID truncado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRet
        loc_cChave = ""

        TRY
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, "SELECT LEFT(REPLACE(NEWID(),'-',''),20) AS nova_chave", "cursor_4c_NewId")
            IF loc_nRet > 0 AND USED("cursor_4c_NewId") AND !EOF("cursor_4c_NewId")
                loc_cChave = ALLTRIM(cursor_4c_NewId.nova_chave)
            ENDIF

            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            *-- Fallback com SYS(2015) se SQL falhar
            loc_cChave = LEFT(SYS(2015) + SYS(2015), 20)
        ENDTRY

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarFeriado - Verifica se uma data ? feriado em SigCdThs (stub)
    * Substitui fChkFeriado() do legado
    * par_ldData : Data a verificar
    * Retorna: .T. se for feriado, .F. caso contr?rio
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarFeriado(par_ldData)
        LOCAL loc_lFeriado, loc_cSQL, loc_nRet
        loc_lFeriado = .F.

        TRY
            *-- Verifica em SigCdThs se o dia tem qthoras=0 explicitamente (feriado configurado)
            *-- Na aus?ncia de tabela de feriados dedicada no sistema, retorna .F. por padr?o
            *-- O legado usava fChkFeriado() do framework que consultava tabela de feriados
            loc_lFeriado = .F.
        CATCH TO loc_oErro
            loc_lFeriado = .F.
        ENDTRY

        RETURN loc_lFeriado
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarDataSQL - Formata data para SQL Server incluindo hora opcional
    * par_ldData   : Data a formatar
    * par_lComHora : .T. = adiciona "23:59:59" (fim do dia)
    * Retorna: string no formato 'YYYY-MM-DD HH:MM:SS' entre aspas simples
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDataSQL(par_ldData, par_lComHora)
        LOCAL loc_cData
        loc_cData = "NULL"

        TRY
            IF !EMPTY(par_ldData) AND par_ldData <> {}
                IF VARTYPE(par_lComHora) = "L" AND par_lComHora
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 23:59:59'"
                ELSE
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 00:00:00'"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cData = "NULL"
        ENDTRY

        RETURN loc_cData
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConverterHorasParaDecimal - Converte horas*qtd para valor decimal total
    * Substitui: Val(Strtran(fMtoH(fHtoM(Str(qtHoras,5,2)) * qtds), ':', '.'))
    * par_nQtHoras : Horas por dia (numeric)
    * par_nQtds    : Quantidade (numeric)
    * Retorna: valor decimal total de horas
    *--------------------------------------------------------------------------
    FUNCTION ConverterHorasParaDecimal(par_nQtHoras, par_nQtds)
        LOCAL loc_nTotalMinutos, loc_nHoras, loc_nMinutos, loc_nDecimal
        loc_nDecimal = 0

        TRY
            *-- fHtoM: horas decimais -> minutos (ex: 8.30 -> 510 min)
            *-- QtHoras est? no formato decimal (8.5 = 8h30)
            loc_nTotalMinutos = INT(par_nQtHoras) * 60 + ;
                                (par_nQtHoras - INT(par_nQtHoras)) * 100
            loc_nTotalMinutos = loc_nTotalMinutos * par_nQtds

            *-- fMtoH: minutos -> horas decimal
            loc_nHoras   = INT(loc_nTotalMinutos / 60)
            loc_nMinutos = MOD(loc_nTotalMinutos, 60)
            loc_nDecimal = VAL(TRANSFORM(loc_nHoras, "@L 9999") + "." + PADL(TRANSFORM(loc_nMinutos, "@L 99"), 2, "0"))
        CATCH TO loc_oErro
            loc_nDecimal = 0
        ENDTRY

        RETURN loc_nDecimal
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * par_cAliasCursor : Alias do cursor (ex: crMesAno)
    * Retorna: .T. se carregado com sucesso, .F. se cursor n?o aberto
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cMes = TratarNulo(Mes, "C")
                THIS.this_cAno = TratarNulo(Ano, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados obrigat?rios antes de Inserir/Atualizar
    * Retorna: .T. se v?lido, .F. se inv?lido (exibe mensagem ao usu?rio)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cMes)
            MsgAviso("M" + CHR(234) + "s obrigat" + CHR(243) + "rio.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cAno) OR LEN(ALLTRIM(THIS.this_cAno)) < 4
            MsgAviso("Ano obrigat" + CHR(243) + "rio (4 d" + CHR(237) + "gitos).")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cSetors)
            MsgAviso("Fase/Setor obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cUniPrdts)
            MsgAviso("Unidade Produtiva obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Cria novo per?odo de carga hor?ria no SQL Server
    * Delega para InserirPeriodo usando this_cMes e this_cAno
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.InserirPeriodo(THIS.this_cMes, THIS.this_cAno)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("I")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Grava altera??es do calend?rio atual para o SQL Server
    * Delega para AlterarPeriodo que usa crCalendario como fonte
    * Retorna: .T. se atualizado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.AlterarPeriodo()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("U")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

