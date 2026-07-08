# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-HEADER] Header Caption 'Tipo de Material' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReAtm.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2521 linhas total):

*-- Linhas 19 a 28:
19: *   - Moeda (CdMoeda/DsMoeda)           -> SigCdMoe / crSigCdMoe
20: *   - Envelope / N. OP
21: *   - Agrupamento (opt_4c_Agru: 1=Analitico 2=Modelo 3=Classif 4=Conta)
22: *   - Grid de Tipos de Material (cursor_4c_TiposMat) com checkbox Marca
23: *   - cnt_4c_Ope: grid grd_4c_Dados + cmd_4c_SelTudo + cmd_4c_Apagar
24: *==============================================================================
25: 
26: DEFINE CLASS FormSigReAtm AS FormBase
27: 
28:     *-- Dimensoes EXATAS do original SIGREATM.SCX

*-- Linhas 60 a 68:
60:         loc_lSucesso   = .F.
61:         loc_lContinuar = .T.
62:         TRY
63:             THIS.Caption = "An" + CHR(225) + "lise por Tipo de Material"
64:             IF TYPE("gc_4c_CaminhoIcones") = "U"
65:                 gc_4c_CaminhoIcones = ""
66:             ENDIF
67:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
68: 

*-- Linhas 90 a 99:
90:                 THIS.ConfigurarMensagem()
91:                 THIS.ConfigurarBINDEVENTs()
92:                 THIS.AlternarPagina(1)
93:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
94:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
95:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
96:                     THIS.LimparCampos()
97:                 ENDIF
98:                 THIS.Visible   = .T.
99:                 loc_lSucesso   = .T.

*-- Linhas 114 a 149:
114:     PROTECTED PROCEDURE ConfigurarCabecalho()
115:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH THIS.cnt_4c_Cabecalho
117:             .Top         = 0
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackColor   = RGB(100, 100, 100)
122:             .BackStyle   = 1
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
127:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
128:             .Top       = 17
129:             .Left      = 12
130:             .AutoSize  = .T.
131:             .Caption   = "An" + CHR(225) + "lise por Tipo de Material"
132:             .FontName  = "Tahoma"
133:             .FontSize  = 14
134:             .FontBold  = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .Visible   = .T.
138:         ENDWITH
139:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
140:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
141:             .Top       = 20
142:             .Left      = 10
143:             .AutoSize  = .T.
144:             .Caption   = "An" + CHR(225) + "lise por Tipo de Material"
145:             .FontName  = "Tahoma"
146:             .FontSize  = 14
147:             .FontBold  = .T.
148:             .ForeColor = RGB(255, 255, 255)
149:             .BackStyle = 0

*-- Linhas 158 a 182:
158:     PROTECTED PROCEDURE ConfigurarBotoes()
159:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
160:         WITH THIS.cmg_4c_Botoes
161:             .Top           = 0
162:             .Left          = 527
163:             .Width         = 273
164:             .Height        = 80
165:             .ButtonCount   = 4
166:             .BackStyle     = 0
167:             .BorderStyle   = 0
168:             .SpecialEffect = 1
169:             .Themes        = .F.
170:             .Visible       = .T.
171:         ENDWITH
172:         WITH THIS.cmg_4c_Botoes.Buttons(1)
173:             .Top             = 5
174:             .Left            = 5
175:             .Width           = 65
176:             .Height          = 70
177:             .Caption         = "Visualizar"
178:             .FontName        = "Tahoma"
179:             .FontBold        = .T.
180:             .FontItalic      = .T.
181:             .FontSize        = 8
182:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 189 a 201:
189:             .Visible         = .T.
190:         ENDWITH
191:         WITH THIS.cmg_4c_Botoes.Buttons(2)
192:             .Top             = 5
193:             .Left            = 71
194:             .Width           = 65
195:             .Height          = 70
196:             .Caption         = "Imprimir"
197:             .FontName        = "Tahoma"
198:             .FontBold        = .T.
199:             .FontItalic      = .T.
200:             .FontSize        = 8
201:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 208 a 220:
208:             .Visible         = .T.
209:         ENDWITH
210:         WITH THIS.cmg_4c_Botoes.Buttons(3)
211:             .Top             = 5
212:             .Left            = 137
213:             .Width           = 65
214:             .Height          = 70
215:             .Caption         = "Doc Excel"
216:             .FontName        = "Tahoma"
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .FontSize        = 8
220:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 227 a 239:
227:             .Visible         = .T.
228:         ENDWITH
229:         WITH THIS.cmg_4c_Botoes.Buttons(4)
230:             .Top             = 5
231:             .Left            = 203
232:             .Width           = 65
233:             .Height          = 70
234:             .Caption         = "Encerrar"
235:             .FontName        = "Tahoma"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 256 a 269:
256:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
257:         loc_oPgf = THIS.pgf_4c_Paginas
258:         loc_oPgf.PageCount = 1
259:         loc_oPgf.Top    = 85
260:         loc_oPgf.Left   = -1
261:         loc_oPgf.Width  = THIS.Width + 2
262:         loc_oPgf.Height = THIS.Height - 85
263:         loc_oPgf.Tabs   = .F.
264:         loc_oPgf.Page1.Caption   = "Filtros"
265:         loc_oPgf.Page1.FontName  = "Tahoma"
266:         loc_oPgf.Page1.FontSize  = 8
267:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
268:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
269:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 279 a 287:
279:     *   fundo (regra #88/#90) e delega para ConfigurarFiltros, que monta:
280:     *     - cnt_4c_Local : container com TODOS os filtros (datas/codigos/opcoes)
281:     *     - cnt_4c_Ope   : container com grd_4c_Dados (tipos de material) e
282:     *                      cmd_4c_SelTudo / cmd_4c_Apagar
283:     *   Botoes "CRUD" deste form sao os 4 do CommandGroup cmg_4c_Botoes
284:     *   (Visualizar/Imprimir/DocExcel/Encerrar), criados em ConfigurarBotoes()
285:     *   fora do PageFrame conforme padrao frmrelatorio do framework.vcx.
286:     *--------------------------------------------------------------------------
287:     PROTECTED PROCEDURE ConfigurarPaginaLista()

*-- Linhas 310 a 432:
310: 
311:         loc_oPg.AddObject("cnt_4c_Local", "Container")
312:         WITH loc_oPg.cnt_4c_Local
313:             .Top         = 0
314:             .Left        = 0
315:             .Width       = 800
316:             .Height      = 465
317:             .BackStyle   = 0
318:             .BorderWidth = 0
319:             .Visible     = .T.
320:         ENDWITH
321:         loc_oCnt = loc_oPg.cnt_4c_Local
322: 
323:         *-- Periodo -----------------------------------------------------------
324:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
325:         WITH loc_oCnt.lbl_4c_Periodo
326:             .AutoSize  = .T.
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .Caption   = "Per" + CHR(237) + "odo :"
330:             .Left      = 83
331:             .Top       = 39
332:             .ForeColor = RGB(90, 90, 90)
333:             .BackStyle = 0
334:             .Visible   = .T.
335:         ENDWITH
336: 
337:         loc_oCnt.AddObject("txt_4c_DataIni", "TextBox")
338:         WITH loc_oCnt.txt_4c_DataIni
339:             .Height        = 23
340:             .Left          = 132
341:             .Top           = 35
342:             .Width         = 80
343:             .Alignment     = 3
344:             .FontName      = "Tahoma"
345:             .FontSize      = 8
346:             .ForeColor     = RGB(0, 0, 0)
347:             .SpecialEffect = 1
348:             .Themes        = .F.
349:             .Value         = DATE()
350:             .Visible       = .T.
351:         ENDWITH
352: 
353:         loc_oCnt.AddObject("lbl_4c_Ate", "Label")
354:         WITH loc_oCnt.lbl_4c_Ate
355:             .AutoSize  = .T.
356:             .FontSize  = 8
357:             .Caption   = " at" + CHR(233) + " "
358:             .Left      = 216
359:             .Top       = 39
360:             .BackStyle = 0
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         loc_oCnt.AddObject("txt_4c_DataFin", "TextBox")
365:         WITH loc_oCnt.txt_4c_DataFin
366:             .Height        = 23
367:             .Left          = 240
368:             .Top           = 35
369:             .Width         = 80
370:             .Alignment     = 3
371:             .FontName      = "Tahoma"
372:             .FontSize      = 8
373:             .ForeColor     = RGB(0, 0, 0)
374:             .SpecialEffect = 1
375:             .Themes        = .F.
376:             .Value         = DATE()
377:             .Visible       = .T.
378:         ENDWITH
379: 
380:         *-- Tipo de O.P. ------------------------------------------------------
381:         loc_oCnt.AddObject("lbl_4c_TpGOp", "Label")
382:         WITH loc_oCnt.lbl_4c_TpGOp
383:             .AutoSize  = .T.
384:             .FontName  = "Tahoma"
385:             .FontSize  = 8
386:             .Caption   = "Tipo de O.P.:"
387:             .Left      = 62
388:             .Top       = 63
389:             .ForeColor = RGB(90, 90, 90)
390:             .BackStyle = 0
391:             .Visible   = .T.
392:         ENDWITH
393: 
394:         loc_oCnt.AddObject("txt_4c_TpGOp", "TextBox")
395:         WITH loc_oCnt.txt_4c_TpGOp
396:             .Height        = 23
397:             .Left          = 132
398:             .Top           = 59
399:             .Width         = 80
400:             .MaxLength     = 10
401:             .FontName      = "Tahoma"
402:             .FontSize      = 8
403:             .ForeColor     = RGB(0, 0, 0)
404:             .SpecialEffect = 1
405:             .Value         = ""
406:             .Visible       = .T.
407:         ENDWITH
408: 
409:         *-- Grupo de Balanco --------------------------------------------------
410:         loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
411:         WITH loc_oCnt.lbl_4c_Grupo
412:             .AutoSize  = .T.
413:             .FontName  = "Tahoma"
414:             .FontSize  = 8
415:             .Caption   = "Grupo :"
416:             .Left      = 90
417:             .Top       = 87
418:             .ForeColor = RGB(90, 90, 90)
419:             .BackStyle = 0
420:             .Visible   = .T.
421:         ENDWITH
422: 
423:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
424:         WITH loc_oCnt.txt_4c_Grupo
425:             .Height        = 23
426:             .Left          = 132
427:             .Top           = 83
428:             .Width         = 80
429:             .FontName      = "Tahoma"
430:             .FontSize      = 8
431:             .ForeColor     = RGB(0, 0, 0)
432:             .SpecialEffect = 1

*-- Linhas 438 a 476:
438:         loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
439:         WITH loc_oCnt.txt_4c_DGrupo
440:             .Height        = 23
441:             .Left          = 213
442:             .Top           = 83
443:             .Width         = 280
444:             .FontName      = "Tahoma"
445:             .FontSize      = 8
446:             .ForeColor     = RGB(0, 0, 0)
447:             .SpecialEffect = 1
448:             .Themes        = .F.
449:             .Value         = ""
450:             .Visible       = .T.
451:         ENDWITH
452: 
453:         *-- Conta/Cliente -----------------------------------------------------
454:         loc_oCnt.AddObject("lbl_4c_Conta", "Label")
455:         WITH loc_oCnt.lbl_4c_Conta
456:             .AutoSize  = .T.
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .Caption   = "Conta :"
460:             .Left      = 90
461:             .Top       = 111
462:             .ForeColor = RGB(90, 90, 90)
463:             .BackStyle = 0
464:             .Visible   = .T.
465:         ENDWITH
466: 
467:         loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
468:         WITH loc_oCnt.txt_4c_Conta
469:             .Height        = 23
470:             .Left          = 132
471:             .Top           = 107
472:             .Width         = 80
473:             .FontName      = "Tahoma"
474:             .FontSize      = 8
475:             .ForeColor     = RGB(0, 0, 0)
476:             .SpecialEffect = 1

*-- Linhas 482 a 521:
482:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
483:         WITH loc_oCnt.txt_4c_DConta
484:             .Height        = 23
485:             .Left          = 213
486:             .Top           = 107
487:             .Width         = 280
488:             .FontName      = "Tahoma"
489:             .FontSize      = 8
490:             .ForeColor     = RGB(0, 0, 0)
491:             .SpecialEffect = 1
492:             .Themes        = .F.
493:             .Value         = ""
494:             .Visible       = .T.
495:         ENDWITH
496: 
497:         *-- Grande Grupo de Produto -------------------------------------------
498:         loc_oCnt.AddObject("lbl_4c_Ggrp", "Label")
499:         WITH loc_oCnt.lbl_4c_Ggrp
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .Caption   = "Grande Grupo :"
503:             .Height    = 15
504:             .Left      = 52
505:             .Top       = 135
506:             .Width     = 76
507:             .ForeColor = RGB(90, 90, 90)
508:             .BackStyle = 0
509:             .Visible   = .T.
510:         ENDWITH
511: 
512:         loc_oCnt.AddObject("txt_4c_Ggrp", "TextBox")
513:         WITH loc_oCnt.txt_4c_Ggrp
514:             .Height        = 23
515:             .Left          = 132
516:             .Top           = 131
517:             .Width         = 31
518:             .MaxLength     = 3
519:             .FontName      = "Tahoma"
520:             .FontSize      = 8
521:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 528 a 537:
528:         loc_oCnt.AddObject("txt_4c_DGGrp", "TextBox")
529:         WITH loc_oCnt.txt_4c_DGGrp
530:             .Height        = 23
531:             .Left          = 164
532:             .Top           = 131
533:             .Width         = 158
534:             .MaxLength     = 20
535:             .FontName      = "Tahoma"
536:             .FontSize      = 8
537:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 543 a 569:
543:         ENDWITH
544: 
545:         *-- Grupo de Materia Prima --------------------------------------------
546:         loc_oCnt.AddObject("lbl_4c_CGru", "Label")
547:         WITH loc_oCnt.lbl_4c_CGru
548:             .FontName  = "Tahoma"
549:             .FontSize  = 8
550:             .Caption   = "Grupo Mat. Prima :"
551:             .Height    = 15
552:             .Left      = 36
553:             .Top       = 159
554:             .Width     = 92
555:             .ForeColor = RGB(90, 90, 90)
556:             .BackStyle = 0
557:             .Visible   = .T.
558:         ENDWITH
559: 
560:         loc_oCnt.AddObject("txt_4c_CGru", "TextBox")
561:         WITH loc_oCnt.txt_4c_CGru
562:             .Height        = 23
563:             .Left          = 132
564:             .Top           = 155
565:             .Width         = 31
566:             .MaxLength     = 3
567:             .FontName      = "Tahoma"
568:             .FontSize      = 8
569:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 576 a 616:
576:         loc_oCnt.AddObject("txt_4c_DGru", "TextBox")
577:         WITH loc_oCnt.txt_4c_DGru
578:             .Height        = 23
579:             .Left          = 164
580:             .Top           = 155
581:             .Width         = 158
582:             .MaxLength     = 20
583:             .FontName      = "Tahoma"
584:             .FontSize      = 8
585:             .ForeColor     = RGB(0, 0, 0)
586:             .SpecialEffect = 1
587:             .Themes        = .F.
588:             .Value         = ""
589:             .Visible       = .T.
590:         ENDWITH
591: 
592:         *-- Subgrupo de Materia Prima -----------------------------------------
593:         loc_oCnt.AddObject("lbl_4c_CSGru", "Label")
594:         WITH loc_oCnt.lbl_4c_CSGru
595:             .AutoSize  = .T.
596:             .FontName  = "Tahoma"
597:             .FontSize  = 8
598:             .Caption   = "Subgrupo Mat. Prima:"
599:             .Height    = 15
600:             .Left      = 22
601:             .Top       = 183
602:             .ForeColor = RGB(90, 90, 90)
603:             .BackStyle = 0
604:             .Visible   = .T.
605:         ENDWITH
606: 
607:         loc_oCnt.AddObject("txt_4c_CSGru", "TextBox")
608:         WITH loc_oCnt.txt_4c_CSGru
609:             .Height        = 23
610:             .Left          = 132
611:             .Top           = 179
612:             .Width         = 52
613:             .MaxLength     = 6
614:             .Format        = "!K"
615:             .FontName      = "Tahoma"
616:             .FontSize      = 8

*-- Linhas 624 a 633:
624:         loc_oCnt.AddObject("txt_4c_DsGru", "TextBox")
625:         WITH loc_oCnt.txt_4c_DsGru
626:             .Height        = 23
627:             .Left          = 185
628:             .Top           = 179
629:             .Width         = 150
630:             .MaxLength     = 20
631:             .Format        = "!K"
632:             .FontName      = "Tahoma"
633:             .FontSize      = 8

*-- Linhas 649 a 677:
649:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
650: 
651:         *-- Modelo/Finalidade de Produto --------------------------------------
652:         loc_oCnt.AddObject("lbl_4c_Modelo", "Label")
653:         WITH loc_oCnt.lbl_4c_Modelo
654:             .AutoSize  = .F.
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .Alignment = 1
658:             .Caption   = "Modelo :"
659:             .Height    = 15
660:             .Left      = 24
661:             .Top       = 207
662:             .Width     = 104
663:             .ForeColor = RGB(90, 90, 90)
664:             .BackStyle = 0
665:             .Visible   = .T.
666:         ENDWITH
667: 
668:         loc_oCnt.AddObject("txt_4c_CodFinP", "TextBox")
669:         WITH loc_oCnt.txt_4c_CodFinP
670:             .Height        = 23
671:             .Left          = 132
672:             .Top           = 203
673:             .Width         = 31
674:             .Format        = "K"
675:             .FontName      = "Tahoma"
676:             .FontSize      = 8
677:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 683 a 769:
683:         loc_oCnt.AddObject("txt_4c_DesFinP", "TextBox")
684:         WITH loc_oCnt.txt_4c_DesFinP
685:             .Height        = 23
686:             .Left          = 164
687:             .Top           = 203
688:             .Width         = 150
689:             .Format        = "K"
690:             .FontName      = "Tahoma"
691:             .FontSize      = 8
692:             .ForeColor     = RGB(0, 0, 0)
693:             .SpecialEffect = 1
694:             .Value         = ""
695:             .Visible       = .T.
696:         ENDWITH
697: 
698:         *-- Acabamento --------------------------------------------------------
699:         loc_oCnt.AddObject("lbl_4c_Acab", "Label")
700:         WITH loc_oCnt.lbl_4c_Acab
701:             .AutoSize  = .F.
702:             .FontName  = "Tahoma"
703:             .FontSize  = 8
704:             .Alignment = 1
705:             .Caption   = "Acabamento :"
706:             .Height    = 15
707:             .Left      = 24
708:             .Top       = 231
709:             .Width     = 104
710:             .ForeColor = RGB(90, 90, 90)
711:             .BackStyle = 0
712:             .Visible   = .T.
713:         ENDWITH
714: 
715:         loc_oCnt.AddObject("txt_4c_CodAcb", "TextBox")
716:         WITH loc_oCnt.txt_4c_CodAcb
717:             .Height        = 23
718:             .Left          = 132
719:             .Top           = 227
720:             .Width         = 31
721:             .FontName      = "Tahoma"
722:             .FontSize      = 8
723:             .ForeColor     = RGB(0, 0, 0)
724:             .SpecialEffect = 1
725:             .Value         = ""
726:             .Visible       = .T.
727:         ENDWITH
728: 
729:         loc_oCnt.AddObject("txt_4c_DAcb", "TextBox")
730:         WITH loc_oCnt.txt_4c_DAcb
731:             .Height        = 23
732:             .Left          = 164
733:             .Top           = 227
734:             .Width         = 150
735:             .FontName      = "Tahoma"
736:             .FontSize      = 8
737:             .ForeColor     = RGB(0, 0, 0)
738:             .SpecialEffect = 1
739:             .Value         = ""
740:             .Visible       = .T.
741:         ENDWITH
742: 
743:         *-- Classificacao -----------------------------------------------------
744:         loc_oCnt.AddObject("lbl_4c_Class", "Label")
745:         WITH loc_oCnt.lbl_4c_Class
746:             .AutoSize  = .F.
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .Alignment = 1
750:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
751:             .Height    = 15
752:             .Left      = 24
753:             .Top       = 255
754:             .Width     = 104
755:             .ForeColor = RGB(90, 90, 90)
756:             .BackStyle = 0
757:             .Visible   = .T.
758:         ENDWITH
759: 
760:         loc_oCnt.AddObject("txt_4c_Class", "TextBox")
761:         WITH loc_oCnt.txt_4c_Class
762:             .Height        = 23
763:             .Left          = 132
764:             .Top           = 251
765:             .Width         = 31
766:             .MaxLength     = 3
767:             .FontName      = "Tahoma"
768:             .FontSize      = 8
769:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 775 a 920:
775:         loc_oCnt.AddObject("txt_4c_DClass", "TextBox")
776:         WITH loc_oCnt.txt_4c_DClass
777:             .Height        = 23
778:             .Left          = 164
779:             .Top           = 251
780:             .Width         = 150
781:             .FontName      = "Tahoma"
782:             .FontSize      = 8
783:             .ForeColor     = RGB(0, 0, 0)
784:             .SpecialEffect = 1
785:             .Value         = ""
786:             .Visible       = .T.
787:         ENDWITH
788: 
789:         *-- Dimensoes ---------------------------------------------------------
790:         loc_oCnt.AddObject("lbl_4c_Dimen", "Label")
791:         WITH loc_oCnt.lbl_4c_Dimen
792:             .FontName  = "Tahoma"
793:             .FontSize  = 8
794:             .Caption   = "Dimens" + CHR(227) + "o :"
795:             .Height    = 15
796:             .Left      = 73
797:             .Top       = 279
798:             .Width     = 55
799:             .ForeColor = RGB(90, 90, 90)
800:             .BackStyle = 0
801:             .Visible   = .T.
802:         ENDWITH
803: 
804:         loc_oCnt.AddObject("txt_4c_TamPs", "TextBox")
805:         WITH loc_oCnt.txt_4c_TamPs
806:             .Height        = 23
807:             .Left          = 132
808:             .Top           = 275
809:             .Width         = 58
810:             .InputMask     = "999.99"
811:             .MaxLength     = 6
812:             .FontName      = "Tahoma"
813:             .FontSize      = 8
814:             .ForeColor     = RGB(0, 0, 0)
815:             .SpecialEffect = 1
816:             .Themes        = .F.
817:             .Value         = 0
818:             .Visible       = .T.
819:         ENDWITH
820: 
821:         loc_oCnt.AddObject("lbl_4c_P", "Label")
822:         WITH loc_oCnt.lbl_4c_P
823:             .FontName  = "Tahoma"
824:             .FontSize  = 8
825:             .Caption   = "p"
826:             .Height    = 15
827:             .Left      = 192
828:             .Top       = 279
829:             .Width     = 8
830:             .ForeColor = RGB(90, 90, 90)
831:             .BackStyle = 0
832:             .Visible   = .T.
833:         ENDWITH
834: 
835:         loc_oCnt.AddObject("txt_4c_TamHs", "TextBox")
836:         WITH loc_oCnt.txt_4c_TamHs
837:             .Height        = 23
838:             .Left          = 219
839:             .Top           = 275
840:             .Width         = 58
841:             .InputMask     = "999.99"
842:             .MaxLength     = 6
843:             .FontName      = "Tahoma"
844:             .FontSize      = 8
845:             .ForeColor     = RGB(0, 0, 0)
846:             .SpecialEffect = 1
847:             .Themes        = .F.
848:             .Value         = 0
849:             .Visible       = .T.
850:         ENDWITH
851: 
852:         loc_oCnt.AddObject("lbl_4c_A", "Label")
853:         WITH loc_oCnt.lbl_4c_A
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .Caption   = "a"
857:             .Height    = 15
858:             .Left      = 280
859:             .Top       = 279
860:             .Width     = 8
861:             .ForeColor = RGB(90, 90, 90)
862:             .BackStyle = 0
863:             .Visible   = .T.
864:         ENDWITH
865: 
866:         loc_oCnt.AddObject("txt_4c_TamLs", "TextBox")
867:         WITH loc_oCnt.txt_4c_TamLs
868:             .Height        = 23
869:             .Left          = 307
870:             .Top           = 275
871:             .Width         = 58
872:             .InputMask     = "999.99"
873:             .MaxLength     = 6
874:             .FontName      = "Tahoma"
875:             .FontSize      = 8
876:             .ForeColor     = RGB(0, 0, 0)
877:             .SpecialEffect = 1
878:             .Themes        = .F.
879:             .Value         = 0
880:             .Visible       = .T.
881:         ENDWITH
882: 
883:         loc_oCnt.AddObject("lbl_4c_C", "Label")
884:         WITH loc_oCnt.lbl_4c_C
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .Caption   = "c"
888:             .Height    = 15
889:             .Left      = 367
890:             .Top       = 279
891:             .Width     = 7
892:             .ForeColor = RGB(90, 90, 90)
893:             .BackStyle = 0
894:             .Visible   = .T.
895:         ENDWITH
896: 
897:         *-- Moeda de Conversao ------------------------------------------------
898:         loc_oCnt.AddObject("lbl_4c_Moeda", "Label")
899:         WITH loc_oCnt.lbl_4c_Moeda
900:             .AutoSize  = .T.
901:             .FontName  = "Tahoma"
902:             .FontSize  = 8
903:             .Caption   = "Moeda :"
904:             .Left      = 87
905:             .Top       = 303
906:             .ForeColor = RGB(90, 90, 90)
907:             .BackStyle = 0
908:             .Visible   = .T.
909:         ENDWITH
910: 
911:         loc_oCnt.AddObject("txt_4c_CdMoeda", "TextBox")
912:         WITH loc_oCnt.txt_4c_CdMoeda
913:             .Height        = 23
914:             .Left          = 132
915:             .Top           = 299
916:             .Width         = 31
917:             .MaxLength     = 3
918:             .Format        = "K!"
919:             .FontName      = "Tahoma"
920:             .FontSize      = 8

*-- Linhas 927 a 966:
927:         loc_oCnt.AddObject("txt_4c_DsMoeda", "TextBox")
928:         WITH loc_oCnt.txt_4c_DsMoeda
929:             .Height        = 23
930:             .Left          = 164
931:             .Top           = 299
932:             .Width         = 202
933:             .MaxLength     = 15
934:             .Format        = "K!"
935:             .FontName      = "Tahoma"
936:             .FontSize      = 8
937:             .ForeColor     = RGB(0, 0, 0)
938:             .SpecialEffect = 1
939:             .Value         = ""
940:             .Visible       = .T.
941:         ENDWITH
942: 
943:         *-- Envelope e N. OP --------------------------------------------------
944:         loc_oCnt.AddObject("lbl_4c_Envelope", "Label")
945:         WITH loc_oCnt.lbl_4c_Envelope
946:             .AutoSize  = .T.
947:             .FontName  = "Tahoma"
948:             .FontSize  = 8
949:             .Caption   = "Envelope :"
950:             .Left      = 75
951:             .Top       = 327
952:             .ForeColor = RGB(90, 90, 90)
953:             .BackStyle = 0
954:             .Visible   = .T.
955:         ENDWITH
956: 
957:         loc_oCnt.AddObject("txt_4c_Envelope", "TextBox")
958:         WITH loc_oCnt.txt_4c_Envelope
959:             .Height        = 23
960:             .Left          = 132
961:             .Top           = 323
962:             .Width         = 80
963:             .MaxLength     = 10
964:             .InputMask     = "9999999999"
965:             .Alignment     = 3
966:             .FontName      = "Tahoma"

*-- Linhas 972 a 995:
972:             .Visible       = .T.
973:         ENDWITH
974: 
975:         loc_oCnt.AddObject("lbl_4c_Nop", "Label")
976:         WITH loc_oCnt.lbl_4c_Nop
977:             .AutoSize  = .T.
978:             .FontSize  = 8
979:             .Caption   = "O.P. :"
980:             .Left      = 220
981:             .Top       = 327
982:             .BackStyle = 0
983:             .Visible   = .T.
984:         ENDWITH
985: 
986:         loc_oCnt.AddObject("txt_4c_Nop", "TextBox")
987:         WITH loc_oCnt.txt_4c_Nop
988:             .Height        = 23
989:             .Left          = 255
990:             .Top           = 323
991:             .Width         = 58
992:             .MaxLength     = 6
993:             .InputMask     = "999999"
994:             .Alignment     = 3
995:             .FontName      = "Tahoma"

*-- Linhas 1002 a 1176:
1002:         ENDWITH
1003: 
1004:         *-- Agrupamento (OptionGroup) -----------------------------------------
1005:         loc_oCnt.AddObject("lbl_4c_Tipo", "Label")
1006:         WITH loc_oCnt.lbl_4c_Tipo
1007:             .AutoSize  = .T.
1008:             .FontName  = "Tahoma"
1009:             .FontSize  = 8
1010:             .Caption   = "Tipo :"
1011:             .Left      = 99
1012:             .Top       = 354
1013:             .ForeColor = RGB(90, 90, 90)
1014:             .BackStyle = 0
1015:             .Visible   = .T.
1016:         ENDWITH
1017: 
1018:         loc_oCnt.AddObject("opt_4c_Agru", "OptionGroup")
1019:         WITH loc_oCnt.opt_4c_Agru
1020:             .Top         = 348
1021:             .Left        = 126
1022:             .Width       = 300
1023:             .Height      = 28
1024:             .ButtonCount = 4
1025:             .BackStyle   = 0
1026:             .BorderStyle = 0
1027:             .Value       = 4
1028:             .Visible     = .T.
1029:         ENDWITH
1030:         WITH loc_oCnt.opt_4c_Agru.Buttons(1)
1031:             .Caption   = "Anal" + CHR(237) + "tico"
1032:             .Left      = 5
1033:             .Top       = 6
1034:             .Width     = 58
1035:             .Height    = 15
1036:             .AutoSize  = .T.
1037:             .BackStyle = 0
1038:             .FontName  = "Tahoma"
1039:             .ForeColor = RGB(90, 90, 90)
1040:         ENDWITH
1041:         WITH loc_oCnt.opt_4c_Agru.Buttons(2)
1042:             .Caption   = "Modelo"
1043:             .Left      = 78
1044:             .Top       = 6
1045:             .Width     = 55
1046:             .AutoSize  = .T.
1047:             .BackStyle = 0
1048:             .FontName  = "Tahoma"
1049:             .ForeColor = RGB(90, 90, 90)
1050:         ENDWITH
1051:         WITH loc_oCnt.opt_4c_Agru.Buttons(3)
1052:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o"
1053:             .Left      = 143
1054:             .Top       = 6
1055:             .Width     = 79
1056:             .Height    = 15
1057:             .AutoSize  = .T.
1058:             .BackStyle = 0
1059:             .FontName  = "Tahoma"
1060:             .FontSize  = 8
1061:             .ForeColor = RGB(90, 90, 90)
1062:         ENDWITH
1063:         WITH loc_oCnt.opt_4c_Agru.Buttons(4)
1064:             .Caption   = "Conta"
1065:             .Left      = 242
1066:             .Top       = 6
1067:             .Width     = 47
1068:             .Height    = 15
1069:             .AutoSize  = .T.
1070:             .BackStyle = 0
1071:             .FontName  = "Tahoma"
1072:             .FontSize  = 8
1073:             .ForeColor = RGB(90, 90, 90)
1074:         ENDWITH
1075: 
1076:         *-- Checkboxes (ocultos - original Visible=.F.) -----------------------
1077:         loc_oCnt.AddObject("chk_4c_Destino", "CheckBox")
1078:         WITH loc_oCnt.chk_4c_Destino
1079:             .Top       = 377
1080:             .Left      = 136
1081:             .Height    = 15
1082:             .Width     = 118
1083:             .FontName  = "Tahoma"
1084:             .FontSize  = 8
1085:             .AutoSize  = .T.
1086:             .Alignment = 0
1087:             .BackStyle = 0
1088:             .Caption   = "Analisar pelo Destino"
1089:             .Value     = 0
1090:             .ForeColor = RGB(90, 90, 90)
1091:             .Visible   = .F.
1092:         ENDWITH
1093: 
1094:         loc_oCnt.AddObject("chk_4c_Produtos", "CheckBox")
1095:         WITH loc_oCnt.chk_4c_Produtos
1096:             .Top       = 396
1097:             .Left      = 153
1098:             .Height    = 15
1099:             .Width     = 123
1100:             .FontName  = "Tahoma"
1101:             .FontSize  = 8
1102:             .AutoSize  = .T.
1103:             .Alignment = 0
1104:             .BackStyle = 0
1105:             .Caption   = "Imprimir Produtos"
1106:             .Value     = 0
1107:             .Enabled   = .F.
1108:             .ForeColor = RGB(36, 84, 155)
1109:             .Visible   = .F.
1110:         ENDWITH
1111: 
1112:         *-- Container do Grid de Tipos de Material ----------------------------
1113:         *-- Original: cntOpe Top=235, Left=440 -> Page: 235-85=150
1114:         loc_oCnt.AddObject("cnt_4c_Ope", "Container")
1115:         WITH loc_oCnt.cnt_4c_Ope
1116:             .Top         = 150
1117:             .Left        = 440
1118:             .Width       = 350
1119:             .Height      = 265
1120:             .BackStyle   = 0
1121:             .BorderWidth = 0
1122:             .Visible     = .T.
1123:         ENDWITH
1124:         loc_oOpe = loc_oCnt.cnt_4c_Ope
1125: 
1126:         loc_oOpe.AddObject("lbl_4c_TipoMat", "Label")
1127:         WITH loc_oOpe.lbl_4c_TipoMat
1128:             .AutoSize  = .T.
1129:             .FontBold  = .T.
1130:             .FontName  = "Tahoma"
1131:             .BackStyle = 0
1132:             .Caption   = "Tipo de material"
1133:             .Height    = 16
1134:             .Left      = 7
1135:             .Top       = 1
1136:             .Width     = 100
1137:             .ForeColor = RGB(90, 90, 90)
1138:             .Visible   = .T.
1139:         ENDWITH
1140: 
1141:         loc_oOpe.AddObject("cmd_4c_SelTudo", "CommandButton")
1142:         WITH loc_oOpe.cmd_4c_SelTudo
1143:             .Top         = 87
1144:             .Left        = 306
1145:             .Height      = 40
1146:             .Width       = 40
1147:             .FontName    = "Verdana"
1148:             .FontSize    = 8
1149:             .WordWrap    = .T.
1150:             .Caption     = ""
1151:             .TabStop     = .F.
1152:             .ToolTipText = "Marca todos"
1153:             .ForeColor   = RGB(36, 84, 155)
1154:             .BackColor   = RGB(255, 255, 255)
1155:             .Themes      = .F.
1156:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1157:             .Visible     = .T.
1158:         ENDWITH
1159: 
1160:         loc_oOpe.AddObject("cmd_4c_Apagar", "CommandButton")
1161:         WITH loc_oOpe.cmd_4c_Apagar
1162:             .Top         = 127
1163:             .Left        = 306
1164:             .Height      = 40
1165:             .Width       = 40
1166:             .FontBold    = .F.
1167:             .FontItalic  = .F.
1168:             .FontName    = "Verdana"
1169:             .FontSize    = 8
1170:             .WordWrap    = .T.
1171:             .Caption     = ""
1172:             .TabStop     = .F.
1173:             .ToolTipText = "Desmarca todos"
1174:             .ForeColor   = RGB(36, 84, 155)
1175:             .BackColor   = RGB(255, 255, 255)
1176:             .Themes      = .F.

*-- Linhas 1186 a 1201:
1186:             .GridLines      = 3
1187:             .HeaderHeight   = 0
1188:             .Height         = 240
1189:             .Left           = 5
1190:             .Panel          = 1
1191:             .RecordMark     = .F.
1192:             .RecordSource   = "cursor_4c_TiposMat"
1193:             .RowHeight      = 18
1194:             .ScrollBars     = 2
1195:             .TabStop        = .F.
1196:             .Top            = 17
1197:             .Width          = 300
1198:             .GridLineColor  = RGB(238, 238, 238)
1199:             .FontName       = "Tahoma"
1200:             .Visible        = .T.
1201:         ENDWITH

*-- Linhas 1209 a 1219:
1209:             .ReadOnly      = .F.
1210:             .FontName      = "Tahoma"
1211:         ENDWITH
1212:         loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
1213:         WITH loc_oGrd.Column1.chk_4c_Marca
1214:             .Caption       = ""
1215:             .Alignment     = 0
1216:             .BackStyle     = 0
1217:             .Enabled       = .T.
1218:         ENDWITH
1219:         loc_oGrd.Column1.CurrentControl  = "chk_4c_Marca"

*-- Linhas 1226 a 1259:
1226:             .Enabled       = .T.
1227:             .FontName      = "Tahoma"
1228:         ENDWITH
1229:         loc_oGrd.Column2.Header1.Caption = "Tipo de Material"
1230:     ENDPROC
1231: 
1232:     *--------------------------------------------------------------------------
1233:     * ConfigurarMensagem - Cria container "Aguarde!!!" (oculto inicialmente)
1234:     *--------------------------------------------------------------------------
1235:     PROTECTED PROCEDURE ConfigurarMensagem()
1236:         LOCAL loc_oCnt
1237:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1238:         loc_oCnt.AddObject("cnt_4c_Mensagem", "Container")
1239:         WITH loc_oCnt.cnt_4c_Mensagem
1240:             .Top         = 420
1241:             .Left        = 130
1242:             .Width       = 400
1243:             .Height      = 40
1244:             .BackStyle   = 0
1245:             .BorderWidth = 0
1246:             .Visible     = .F.
1247:         ENDWITH
1248:         loc_oCnt.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
1249:         WITH loc_oCnt.cnt_4c_Mensagem.lbl_4c_LblMensagem
1250:             .Top       = 10
1251:             .Left      = 10
1252:             .Width     = 380
1253:             .Height    = 22
1254:             .Caption   = "Aguarde!!!"
1255:             .FontName  = "Tahoma"
1256:             .FontSize  = 14
1257:             .FontBold  = .T.
1258:             .ForeColor = RGB(0, 0, 0)
1259:             .BackStyle = 0

*-- Linhas 1291 a 1300:
1291:         BINDEVENT(loc_oCnt.txt_4c_DClass,   "KeyPress", THIS, "TxtDClassKeyPress")
1292:         BINDEVENT(loc_oCnt.txt_4c_CdMoeda,  "KeyPress", THIS, "TxtCdMoedaKeyPress")
1293:         BINDEVENT(loc_oCnt.txt_4c_DsMoeda,  "KeyPress", THIS, "TxtDsMoedaKeyPress")
1294:         BINDEVENT(loc_oOpe.cmd_4c_Apagar,   "Click",    THIS, "CntOpeApagaClick")
1295:         BINDEVENT(loc_oOpe.cmd_4c_SelTudo,  "Click",    THIS, "CntOpeSelTudoClick")
1296: 
1297:         *-- DblClick: atalho alternativo ao F4 para todos os campos com lookup
1298:         BINDEVENT(loc_oCnt.txt_4c_TpGOp,    "DblClick", THIS, "TxtTpGOpDblClick")
1299:         BINDEVENT(loc_oCnt.txt_4c_Grupo,    "DblClick", THIS, "TxtGrupoDblClick")
1300:         BINDEVENT(loc_oCnt.txt_4c_DGrupo,   "DblClick", THIS, "TxtDGrupoDblClick")


### BO (C:\4c\projeto\app\classes\SigReAtmBO.prg):
*==============================================================================
* SIGREATMBO.PRG
* Business Object para Relatorio Analise por Tipo de Material (SigReAtm)
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SigReAtmBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDatai           = {}
    this_dDataf           = {}

    *-- Filtro tipo de OP
    this_cTpGOp           = ""

    *-- Filtro grupo de balanco (SigCdGcr)
    this_cGrupo           = ""
    this_cDGrupo          = ""

    *-- Filtro conta/cliente
    this_cConta           = ""
    this_cDConta          = ""

    *-- Filtro grande grupo de produto
    this_cGgrp            = ""
    this_cDGGrp           = ""

    *-- Filtro grupo de materia prima
    this_cCGru            = ""
    this_cDGru            = ""

    *-- Filtro subgrupo de materia prima
    this_cCSGru           = ""
    this_cDsGru           = ""

    *-- Filtro modelo (finalidade de produto)
    this_cCodFinP         = ""
    this_cDesFinP         = ""

    *-- Filtro acabamento
    this_cCodAcb          = ""
    this_cDAcb            = ""

    *-- Filtro classificacao
    this_cClass           = ""
    this_cDClass          = ""

    *-- Filtro dimensoes
    this_nTamPs           = 0
    this_nTamHs           = 0
    this_nTamLs           = 0

    *-- Filtro envelope e OP
    this_nEnvelope        = 0
    this_nNop             = 0

    *-- Filtro moeda de conversao
    this_cCdMoeda         = ""
    this_cDsMoeda         = ""

    *-- Agrupamento: 1=Analitico 2=Modelo 3=Classificacao 4=Conta
    this_nAgru            = 4

    *-- Opcoes logicas
    this_lDestino         = .F.
    this_lProdutos        = .F.

    *-- Nomes dos cursors para uso pelo Form
    this_cCursorTiposMat  = "cursor_4c_TiposMat"
    this_cCursorGrupos    = "cursor_4c_GruposBal"
    this_cCursorClientes  = "cursor_4c_Clientes"
    this_cCursorTpGOp     = "cursor_4c_TpGOp"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(8), loc_nI
        loc_aCursors(1) = "cursor_4c_GruposBal"
        loc_aCursors(2) = "cursor_4c_TiposMat"
        loc_aCursors(3) = "cursor_4c_Clientes"
        loc_aCursors(4) = "cursor_4c_Pam"
        loc_aCursors(5) = "cursor_4c_TpGOp"
        loc_aCursors(6) = "crSigCdCot"
        loc_aCursors(7) = "crSigCdMoe"
        loc_aCursors(8) = "cursor_4c_Operacoes"
        FOR loc_nI = 1 TO 8
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursors de referencia usados pelo Form e pelo
    * PrepararDados. Deve ser chamado no InicializarForm() do Form.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cEmp, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- 1. Grupos de balanco (SigCdGcr GerBals=1)
            IF USED("cursor_4c_GruposBal")
                USE IN cursor_4c_GruposBal
            ENDIF
            loc_cSQL = "SELECT Codigos, Descrs, Agrupas FROM SigCdGcr WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar grupos de balan" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_GruposBal
            INDEX ON Codigos TAG BalCodigo
            INDEX ON Descrs  TAG BalDescrs

            *-- 2. Tipos de material selecionaveis (SigOpOpt Situas<2)
            IF USED("cursor_4c_TiposMat")
                USE IN cursor_4c_TiposMat
            ENDIF
            loc_cSQL = "SELECT 0 AS Marca, Cods, Descs FROM SigOpOpt " + ;
                       "WHERE Situas < 2 AND " + ;
                       "(RTRIM(Emps) = '' OR Emps = " + EscaparSQL(loc_cEmp) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposMat")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar tipos de material"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TiposMat
            INDEX ON Cods  TAG Cods
            INDEX ON Descs TAG Descs
            GO TOP

            *-- 3. Clientes (SigCdCli GerBals=1)
            IF USED("cursor_4c_Clientes")
                USE IN cursor_4c_Clientes
            ENDIF
            loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Clientes")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar clientes"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Clientes
            INDEX ON IClis TAG BalCodigo
            INDEX ON RClis TAG BalNome

            *-- 4. Parametros empresa (GrTrans para exclusao de transitorio)
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT GrTrans FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            GO TOP

            *-- 5. Tipos de geracao de OP filtrados por acesso do usuario
            IF USED("TmpTpGop")
                USE IN TmpTpGop
            ENDIF
            IF USED("cursor_4c_TpGOp")
                USE IN cursor_4c_TpGOp
            ENDIF
            loc_cSQL = "SELECT 0 AS Acesso, Codigos, Descs FROM SigInTgo"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpTpGop")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar tipos de OP"
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN TmpTpGop
                ENDIF
            ENDSCAN
            SELECT * FROM TmpTpGop WHERE Acesso = 1 INTO CURSOR cursor_4c_TpGOp READWRITE
            SELECT cursor_4c_TpGOp
            INDEX ON Codigos TAG Codigos
            GO TOP
            USE IN TmpTpGop

            *-- 6. Cotacoes de moeda (crSigCdCot - nome exato usado por fCarregarCambio)
            IF USED("crSigCdCot")
                USE IN crSigCdCot
            ENDIF
            loc_cSQL = "SELECT CMoes, Datas, Valos FROM SigCdCot"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar cota" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            SET ORDER TO CMoeData DESCENDING

            *-- 7. Moedas (crSigCdMoe - nome exato usado por fCarregarCambio)
            IF USED("crSigCdMoe")
                USE IN crSigCdMoe
            ENDIF
            loc_cSQL = "SELECT CMoes, Cotas FROM SigCdMoe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMoe
            INDEX ON CMoes TAG CMoes

            *-- 8. Operacoes de producao (SigCdOpd)
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            loc_cSQL = "SELECT 0 AS Marca, DopPs, ndopps, CodTgOps FROM SigCdOpd"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL loc_cGrupo, loc_cConta, loc_cGruMat, loc_cGgrp, loc_cSgru
        LOCAL loc_dDatai, loc_dDataf, loc_lDestino, loc_nEnvelope, loc_nOp
        LOCAL loc_nOpI, loc_nOpF, loc_cTGOp, loc_cCodFin, loc_cClas
        LOCAL loc_nTamA, loc_nTamP, loc_nTamC, loc_nAgru, loc_cMoeda
        LOCAL loc_cTpOp, loc_nTotOp, loc_cCabTipo, loc_cCab, loc_cSub, loc_cEmp
        LOCAL loc_cTpOps, loc_cGrp, loc_cCta, loc_cPed, loc_nEnv, loc_ldData
        LOCAL loc_lcDimen, loc_lcPro, loc_lcDpr, loc_cGrTrans, loc_nValorCalc
        LOCAL loc_cDtI, loc_cDtF, loc_cChave, loc_cChaveTotal, loc_cRClis
        LOCAL loc_cDFinP, loc_cDClass, loc_cQueryPro, loc_cLabel1, loc_cLabel2, loc_cLabel3

        loc_lSucesso = .F.

        TRY
            *-- Copiar filtros das propriedades
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_cGruMat   = ALLTRIM(THIS.this_cCGru)
            loc_cGgrp     = ALLTRIM(THIS.this_cGgrp)
            loc_cSgru     = ALLTRIM(THIS.this_cCSGru)
            loc_dDatai    = THIS.this_dDatai
            loc_dDataf    = THIS.this_dDataf
            loc_lDestino  = THIS.this_lDestino
            loc_nEnvelope = THIS.this_nEnvelope
            loc_nOp       = THIS.this_nNop
            loc_nOpI      = (loc_nOp * 10000) + 1
            loc_nOpF      = (loc_nOp * 10000) + 9999
            loc_cTGOp     = ALLTRIM(THIS.this_cTpGOp)
            loc_cCodFin   = ALLTRIM(THIS.this_cCodFinP)
            loc_cClas     = ALLTRIM(THIS.this_cClass)
            loc_nTamA     = THIS.this_nTamHs
            loc_nTamP     = THIS.this_nTamPs
            loc_nTamC     = THIS.this_nTamLs
            loc_nAgru     = THIS.this_nAgru
            loc_cMoeda    = ALLTRIM(THIS.this_cCdMoeda)

            *-- Criar cursor TmpRelat com indexes
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            CREATE CURSOR TmpRelat (Fase c(10), IClis c(10), RClis c(50), ;
                CMats c(14), DPros c(40), CPros c(14), DDPros c(40), ;
                Qtde n(12,3), TpOps c(15), CUnis c(3), Operacaos c(31), ;
                Nenvs n(10), Datas D, Pesos n(12,3), Valor n(12,2), ;
                Fators n(12,3), Moecs c(3), Cgrus c(3), Sgrus c(3), ;
                Cclass c(3), CodFinP c(3), Dimens c(30), DFinP c(20), ;
                DClass c(40), QtdTrabs n(12,3))
            INDEX ON DTOS(Datas) + Operacaos + STR(Nenvs,10) + CMats TAG Operacao
            INDEX ON TpOps + CodFinP + STR(Qtde,12,3) TAG TpCodFin
            INDEX ON DTOS(Datas) + Fase + IClis + TpOps + CUnis + ;
                CMats + Operacaos + STR(Nenvs,10) + STR(Qtde,12,3) TAG FFuncMat

            *-- Datas formatadas
            loc_cDtI = FormatarDataSQL(loc_dDatai)
            loc_cDtF = FormatarDataSQL(loc_dDataf)

            *-- Montar filtro de tipos de material marcados no grid
            loc_cTpOp  = ""
            loc_nTotOp = 0
            IF USED("cursor_4c_TiposMat")
                SELECT cursor_4c_TiposMat
                GO TOP
                COUNT FOR Marca = 1 TO loc_nTotOp
                SCAN
                    IF cursor_4c_TiposMat.Marca = 1 OR loc_nTotOp = 0
                        IF EMPTY(loc_cTpOp)
                            loc_cTpOp = "'" + ALLTRIM(cursor_4c_TiposMat.Cods) + "'"
                        ELSE
                            loc_cTpOp = loc_cTpOp + ",'" + ALLTRIM(cursor_4c_TiposMat.Cods) + "'"
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cTpOp = "(" + IIF(EMPTY(loc_cTpOp), "''", loc_cTpOp) + ")"

            *-- QUERY 1: movimentos basicos (TmpNens)
            IF USED("TmpNens")
                USE IN TmpNens
            ENDIF
            loc_cSQL = "Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.GrupoOs,a.ContaOs," + ;
                       "b.CMats,b.Qtds,b.TpOps,b.Nenvs," + ;
                       "a.GrupoDs,a.ContaDs,b.Nops,b.Pesos,b.Fators,b.Servicos,b.Cats,b.Empdnps " + ;
                       "From SigCdNec a, SigCdNei b " + ;
                       "Where a.Datas Between " + loc_cDtI + " And " + loc_cDtF + ;
                       " And a.EmpDNPs = b.EmpDNPs"
            IF !EMPTY(loc_cTpOp) AND loc_cTpOp <> "()"
                loc_cSQL = loc_cSQL + " And b.TpOps in " + loc_cTpOp
            ENDIF
            IF !EMPTY(loc_cGrupo)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                ENDIF
            ENDIF
            IF !EMPTY(loc_cConta)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.ContaDs = " + EscaparSQL(loc_cConta)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.ContaOs = " + EscaparSQL(loc_cConta)
                ENDIF
            ENDIF
            IF loc_nEnvelope > 0
                loc_cSQL = loc_cSQL + " And b.Nenvs = " + FormatarNumeroSQL(loc_nEnvelope)
            ENDIF
            loc_cSQL = loc_cSQL + " Order By a.cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpNens")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar movimenta" + CHR(231) + CHR(245) + "es (TmpNens)"
                loc_lSucesso = .F.
            ENDIF

            *-- QUERY 2: componentes com dados de produto (TmpProd)
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            loc_cSQL = "Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.ContaOs," + ;
                       "b.CMats,b.Qtds,b.TpOps,b.Nenvs,a.GrupoDs,a.ContaDs," + ;
                       "b.Nops,b.Pesos,b.Fators,b.Servicos,b.Cats,b.Empdnps," + ;
                       "d.CodFinP,d.Cclass,d.Cunis,d.Pcuss," + ;
                       "case when e.agrupas = '' then a.GrupoOs else e.agrupas end as GrupoOs " + ;
                       "From SigCdNec a, SigCdNei b, SigOpOpt c, SigCdPro d, SigCdGcr e " + ;
                       "Where a.Datas Between " + loc_cDtI + " And " + loc_cDtF + ;
                       " And a.EmpDNPs = b.EmpDNPs And c.Cods = b.TpOps" + ;
                       " And b.Cmats = d.Cpros And b.servicos = 0 And a.Retrabs = 0 And a.GrupoOs = e.Codigos"
            IF !EMPTY(loc_cGrupo)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                ENDIF
            ENDIF
            IF !EMPTY(loc_cConta)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.ContaDs = " + EscaparSQL(loc_cConta)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.ContaOs = " + EscaparSQL(loc_cConta)
                ENDIF
            ENDIF
            IF loc_nEnvelope > 0
                loc_cSQL = loc_cSQL + " And b.Nenvs = " + FormatarNumeroSQL(loc_nEnvelope)
            ENDIF
            IF !EMPTY(loc_cGruMat)
                loc_cSQL = loc_cSQL + " And d.CGrus = " + EscaparSQL(loc_cGruMat)
            ENDIF
            IF !EMPTY(loc_cGgrp)
                loc_cSQL = loc_cSQL + " And d.Mercs = " + EscaparSQL(loc_cGgrp)
            ENDIF
            IF !EMPTY(loc_cCodFin)
                loc_cSQL = loc_cSQL + " And d.CodFinP = " + EscaparSQL(loc_cCodFin)
            ENDIF
            IF !EMPTY(loc_cClas)
                loc_cSQL = loc_cSQL + " And d.Cclass = " + EscaparSQL(loc_cClas)
            ENDIF
            loc_cSQL = loc_cSQL + " Order By a.cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpProd")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar componentes (TmpProd)"
                loc_lSucesso = .F.
            ENDIF

            *-- Filtrar movimentos por tipo de geracao de OP
            IF USED("CrSigCdNec")
                USE IN CrSigCdNec
            ENDIF
            SELECT TmpNens.* FROM TmpNens, cursor_4c_Operacoes ;
                WHERE TmpNens.DopPs = cursor_4c_Operacoes.DopPs ;
                AND IIF(!EMPTY(loc_cTGOp), ALLTRIM(cursor_4c_Operacoes.CodTgOps) = loc_cTGOp, .T.) ;
                INTO CURSOR CrSigCdNec READWRITE

            *-- Cursor de filtro por envelope
            IF USED("crEnvelope")
                USE IN crEnvelope
            ENDIF
            IF loc_nEnvelope > 0
                SELECT DISTINCT Empdnps FROM CrSigCdNec ;
                    WHERE Nenvs = loc_nEnvelope INTO CURSOR crEnvelope
            ENDIF

            *-- Indexar CrSigCdNec
            SELECT CrSigCdNec
            INDEX ON DTOS(Datas) + CIdChaves TAG Datas
            SET ORDER TO Datas
            GO TOP

            *-- Ler GrTrans uma vez (evitar acesso ao cursor dentro do SCAN)
            loc_cGrTrans = ""
            IF USED("cursor_4c_Pam")
                SELECT cursor_4c_Pam
                GO TOP
                IF !EOF()
                    loc_cGrTrans = ALLTRIM(cursor_4c_Pam.GrTrans)
                ENDIF
            ENDIF

            *-- Processar movimentos
            LOCAL loc_nTotal
            loc_nTotal = RECCOUNT("CrSigCdNec")

            IF loc_nTotal > 0
                WAIT WINDOW "Processando movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT

                SELECT CrSigCdNec
                SCAN
                    *-- Filtro envelope
                    IF loc_nEnvelope > 0
                        IF USED("crEnvelope")
                            SELECT crEnvelope
                            GO TOP
                            LOCATE FOR Empdnps = CrSigCdNec.Empdnps
                            IF EOF("crEnvelope")
                                LOOP
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Filtro numero de OP
                    IF loc_nOp > 0
                        IF !BETWEEN(CrSigCdNec.Nops, loc_nOpI, loc_nOpF)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- Buscar dados do produto/material para este componente
                    IF USED("CrSigCdPro")
                        USE IN CrSigCdPro
                    ENDIF
                    loc_cQueryPro = "Select a.CPros,a.DPros,a.CGrus,a.Sgrus,a.CUnis," + ;
                                    "b.Mercs,a.Pcuss,a.Moecs,a.Cclass,a.CodFinp," + ;
                                    "a.TamPs,a.TamHs,a.TamLs " + ;
                                    "From SigCdPro a, SigCdGrp b " + ;
                                    "Where a.CPros = " + EscaparSQL(ALLTRIM(CrSigCdNec.CMats)) + ;
                                    " And a.Cgrus = b.Cgrus"
                    IF SQLEXEC(gnConnHandle, loc_cQueryPro, "CrSigCdPro") < 1
                        THIS.this_cMensagemErro = "Erro ao buscar produto " + ALLTRIM(CrSigCdNec.CMats)
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT CrSigCdPro
                    IF EOF()
                        LOOP
                    ENDIF

                    *-- Aplicar filtros de produto
                    IF !EMPTY(loc_cGruMat) AND ALLTRIM(CrSigCdPro.CGrus) <> loc_cGruMat
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cGgrp) AND ALLTRIM(CrSigCdPro.Mercs) <> loc_cGgrp
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cSgru) AND ALLTRIM(CrSigCdPro.Sgrus) <> loc_cSgru
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cCodFin) AND ALLTRIM(CrSigCdPro.CodFinp) <> loc_cCodFin
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cClas) AND ALLTRIM(CrSigCdPro.Cclass) <> loc_cClas
                        LOOP
                    ENDIF
                    IF loc_nTamP <> 0 AND CrSigCdPro.TamPs <> loc_nTamP
                        LOOP
                    ENDIF
                    IF loc_nTamA <> 0 AND CrSigCdPro.TamHs <> loc_nTamA
                        LOOP
                    ENDIF
                    IF loc_nTamC <> 0 AND CrSigCdPro.TamLs <> loc_nTamC
                        LOOP
                    ENDIF

                    loc_cTpOps = CrSigCdNec.TpOps

                    *-- Determinar grupo (origem ou destino)
                    IF loc_lDestino
                        loc_cGrp = CrSigCdNec.GrupoDs
                    ELSE
                        loc_cGrp = CrSigCdNec.GrupoOs
                    ENDIF

                    *-- Buscar agrupamento customizado do grupo
                    IF USED("cursor_4c_GruposBal") AND !EMPTY(ALLTRIM(loc_cGrp))
                        SELECT cursor_4c_GruposBal
                        SET ORDER TO TAG BalCodigo
                        IF SEEK(ALLTRIM(loc_cGrp)) AND !EMPTY(ALLTRIM(cursor_4c_GruposBal.Agrupas))
                            loc_cGrp = PADR(ALLTRIM(cursor_4c_GruposBal.Agrupas), 10)
                        ENDIF
                        SELECT CrSigCdNec
                    ENDIF

                    *-- Excluir grupo transitorio
                    IF ALLTRIM(loc_cGrp) = loc_cGrTrans
                        LOOP
                    ENDIF

                    *-- Determinar conta
                    IF loc_lDestino
                        loc_cCta = CrSigCdNec.ContaDs
                    ELSE
                        loc_cCta = CrSigCdNec.ContaOs
                    ENDIF

                    *-- Montar chave de agrupamento (loc_cPed/lnEnv/ldData por modo)
                    IF loc_nAgru = 1
                        loc_cPed   = PADR(ALLTRIM(CrSigCdNec.DopPs) + "-" + STR(CrSigCdNec.NumPs,10), 31)
                        loc_nEnv   = CrSigCdNec.Nenvs
                        loc_ldData = CrSigCdNec.Datas
                    ELSE
                        loc_cPed   = PADR(" ", 31)
                        loc_nEnv   = 0
                        loc_ldData = CTOD("31/12/9999")
                    ENDIF

                    *-- Buscar produto final da OP (opcional)
                    loc_lcPro = ""
                    loc_lcDpr = ""
                    IF !EMPTY(CrSigCdNec.Nops) AND THIS.this_lProdutos
                        IF USED("LocalPro")
                            USE IN LocalPro
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 a.Cpros,b.DPros " + ;
                            "From SigOpPic a Inner join SigCdPro b on a.Cpros = b.Cpros " + ;
                            "Where Nops = " + FormatarNumeroSQL(CrSigCdNec.Nops), "LocalPro")
                        IF loc_nResult > 0
                            SELECT LocalPro
                            GO TOP
                            IF !EOF()
                                loc_lcDpr = ALLTRIM(LocalPro.DPros)
                                loc_lcPro = ALLTRIM(LocalPro.Cpros)
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Montar string de dimensoes do produto
                    loc_lcDimen = ""
                    IF USED("crSigCdGrp")
                        USE IN crSigCdGrp
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TitulosPro FROM SigCdGrp WHERE CGrus = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.CGrus)), "crSigCdGrp")
                    IF loc_nResult > 0
                        SELECT crSigCdGrp
                        GO TOP
                        IF !EOF() AND !EMPTY(SUBSTR(crSigCdGrp.TitulosPro, 61, 60))
                            loc_cLabel1 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 61, 20))), ;
                                             "p", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 61, 20)))
                            loc_cLabel2 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 81, 20))), ;
                                             "a", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 81, 20)))
                            loc_cLabel3 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 101, 20))), ;
                                             "c", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 101, 20)))
                            loc_lcDimen = STR(CrSigCdPro.TamPs, 2) + loc_cLabel1 + ;
                                          " x " + STR(CrSigCdPro.TamHs, 2) + loc_cLabel2 + ;
                                          " x " + STR(CrSigCdPro.TamLs, 2) + loc_cLabel3
                        ENDIF
                    ENDIF

                    *-- Buscar descricao de finalidade/modelo (SigCdFip)
                    IF USED("crSigCdFip")
                        USE IN crSigCdFip
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdFip WHERE Cods = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.CodFinp)), "crSigCdFip")
                    loc_cDFinP = ""
                    IF USED("crSigCdFip")
                        SELECT crSigCdFip
                        GO TOP
                        IF !EOF()
                            loc_cDFinP = ALLTRIM(crSigCdFip.Descs)
                        ENDIF
                    ENDIF

                    *-- Buscar descricao de classificacao (SigCdCls)
                    IF USED("crSigCdCls")
                        USE IN crSigCdCls
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdCls WHERE Cods = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.Cclass)), "crSigCdCls")
                    loc_cDClass = ""
                    IF USED("crSigCdCls")
                        SELECT crSigCdCls
                        GO TOP
                        IF !EOF()
                            loc_cDClass = ALLTRIM(crSigCdCls.Descs)
                        ENDIF
                    ENDIF

                    *-- Montar chave de busca no TmpRelat
                    loc_cChave = DTOS(loc_ldData) + ;
                                 PADR(ALLTRIM(loc_cGrp), 10) + ;
                                 PADR(ALLTRIM(loc_cCta), 10) + ;
                                 PADR(ALLTRIM(loc_cTpOps), 15) + ;
                                 PADR(ALLTRIM(CrSigCdPro.Cunis), 3) + ;
                                 PADR(ALLTRIM(CrSigCdNec.CMats), 14) + ;
                                 loc_cPed + ;
                                 STR(loc_nEnv, 10)

                    SELECT TmpRelat
                    SET ORDER TO TAG FFuncMat

                    IF !SEEK(loc_cChave)
                        *-- Buscar nome do cliente para o INSERT
                        IF USED("CrTmpCli")
                            USE IN CrTmpCli
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(ALLTRIM(loc_cCta)), "CrTmpCli")
                        loc_cRClis = ""
                        IF USED("CrTmpCli")
                            SELECT CrTmpCli
                            GO TOP
                            IF !EOF()
                                loc_cRClis = ALLTRIM(CrTmpCli.RClis)
                            ENDIF
                        ENDIF

                        SELECT TmpRelat
                        INSERT INTO TmpRelat (Fase, IClis, RClis, CMats, DPros, CPros, ;
                            DDPros, TpOps, CUnis, Operacaos, Nenvs, Datas, Fators, ;
                            Moecs, Cclass, CodFinP, Dimens, Cgrus, Sgrus, DFinP, DClass) ;
                            VALUES (PADR(ALLTRIM(loc_cGrp),10), ;
                                PADR(ALLTRIM(loc_cCta),10), ;
                                loc_cRClis, ;
                                PADR(ALLTRIM(CrSigCdNec.CMats),14), ;
                                ALLTRIM(CrSigCdPro.DPros), ;
                                loc_lcPro, loc_lcDpr, ;
                                PADR(ALLTRIM(loc_cTpOps),15), ;
                                PADR(ALLTRIM(CrSigCdPro.Cunis),3), ;
                                loc_cPed, loc_nEnv, loc_ldData, ;
                                CrSigCdNec.Fators, ;
                                PADR(ALLTRIM(CrSigCdPro.Moecs),3), ;
                                PADR(ALLTRIM(CrSigCdPro.Cclass),3), ;
                                PADR(ALLTRIM(CrSigCdPro.CodFinp),3), ;
                                loc_lcDimen, ;
                                PADR(ALLTRIM(CrSigCdPro.Cgrus),3), ;
                                PADR(ALLTRIM(CrSigCdPro.Sgrus),3), ;
                                loc_cDFinP, loc_cDClass)
                    ENDIF

                    SELECT TmpRelat
                    REPLACE Qtde WITH Qtde + CrSigCdNec.Qtds
                    IF ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda
                        loc_nValorCalc = fCarregarCambio(ALLTRIM(CrSigCdPro.Moecs), DATE()) / ;
                                         fCarregarCambio(loc_cMoeda, DATE())
                    ELSE
                        loc_nValorCalc = CrSigCdPro.Pcuss * CrSigCdNec.Qtds
                    ENDIF
                    REPLACE Valor WITH Valor + loc_nValorCalc
                    REPLACE Moecs WITH IIF(ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda, ;
                        loc_cMoeda, ALLTRIM(CrSigCdPro.Moecs))

                    *-- Linha de total geral (somente modo Analitico)
                    IF loc_nAgru = 1
                        loc_cChaveTotal = DTOS(CTOD("31/12/9999")) + ;
                                          REPLICATE(CHR(255), 20) + ;
                                          PADR(ALLTRIM(loc_cTpOps), 15) + ;
                                          PADR(ALLTRIM(CrSigCdPro.Cunis), 3) + ;
                                          PADR(ALLTRIM(CrSigCdNec.CMats), 14) + ;
                                          PADR(" ", 31) + STR(0, 10)
                        SELECT TmpRelat
                        SET ORDER TO TAG FFuncMat
                        IF !SEEK(loc_cChaveTotal)
                            INSERT INTO TmpRelat (Fase, IClis, RClis, CMats, TpOps, ;
                                CUnis, Moecs, Datas, CodFinP, Cclass) ;
                                VALUES (REPLICATE(CHR(255),10), ;
                                    REPLICATE(CHR(255),10), ;
                                    "Total Geral : ", ;
                                    PADR(ALLTRIM(CrSigCdNec.CMats),14), ;
                                    PADR(ALLTRIM(loc_cTpOps),15), ;
                                    PADR(ALLTRIM(CrSigCdPro.Cunis),3), ;
                                    PADR(ALLTRIM(CrSigCdPro.Moecs),3), ;
                                    CTOD("31/12/9999"), "", "")
                        ENDIF
                        SELECT TmpRelat
                        REPLACE Qtde WITH Qtde + CrSigCdNec.Qtds
                        IF ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda
                            loc_nValorCalc = fCarregarCambio(ALLTRIM(CrSigCdPro.Moecs), DATE()) / ;
                                             fCarregarCambio(loc_cMoeda, DATE())
                        ELSE
                            loc_nValorCalc = CrSigCdPro.Pcuss * CrSigCdNec.Qtds
                        ENDIF
                        REPLACE Valor WITH Valor + loc_nValorCalc
                        REPLACE Moecs WITH IIF(ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda, ;
                            loc_cMoeda, ALLTRIM(CrSigCdPro.Moecs))
                    ENDIF

                ENDSCAN

                WAIT CLEAR
            ENDIF

            *-- Agregar TmpRelat conforme tipo de agrupamento
            SELECT TmpRelat
            GO TOP

            DO CASE
                CASE loc_nAgru = 1
                    loc_cCabTipo = " - Tipo : Anal" + CHR(237) + "tico"
                    SELECT * FROM TmpRelat ;
                        ORDER BY Datas, Fase, IClis, TpOps, CUnis, Moecs, CMats, Qtde DESC ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 2
                    loc_cCabTipo = " - Tipo : Modelo"
                    SELECT CodFinp, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY CodFinp, Cunis ;
                        ORDER BY CodFinp, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.CodFinp AS Agrupa, a.DFinP AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON a.CodFinP = b.CodFinP AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.CodFinp, a.DFinP, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.CodFinp, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 3
                    loc_cCabTipo = " - Tipo : Classifica" + CHR(231) + CHR(227) + "o"
                    SELECT Cclass, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY Cclass, Cunis ;
                        ORDER BY Cclass, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.Cclass AS Agrupa, a.DClass AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON a.Cclass = b.Cclass AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.Cclass, a.DClass, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.Cclass, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 4
                    loc_cCabTipo = " - Tipo : Conta"
                    SELECT GrupoOs, ContaOs, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY GrupoOs, ContaOs, Cunis ;
                        ORDER BY GrupoOs, ContaOs, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.Fase AS Agrupa, ;
                        ALLTRIM(a.IClis) + " - " + ALLTRIM(a.RClis) AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON ALLTRIM(a.Fase) = ALLTRIM(b.GrupoOs) ;
                                AND ALLTRIM(a.IClis) = ALLTRIM(b.ContaOs) ;
                                AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.Fase, Dagrupa, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.Fase, Dagrupa, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

            ENDCASE

            *-- Cabecalho do relatorio
            loc_cCab = "An" + CHR(225) + "lise por Tipo de Material" + ;
                       CHR(13) + "Moeda : " + loc_cMoeda + loc_cCabTipo
            IF loc_lDestino
                loc_cSub = "Por Destino"
            ELSE
                loc_cSub = "Por Origem"
            ENDIF
            loc_cSub = loc_cSub + " - Per" + CHR(237) + "odo : " + ;
                       ALLTRIM(DTOC(loc_dDatai)) + " at" + CHR(233) + " " + ;
                       ALLTRIM(DTOC(loc_dDataf))

            *-- Nome da empresa
            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- Cursor de cabecalho
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100))
            INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)

            SELECT TmpRelat
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                DO CASE
                    CASE THIS.this_nAgru = 1
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt2") PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt3") PREVIEW NOCONSOLE
                ENDCASE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                DO CASE
                    CASE THIS.this_nAgru = 1
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt2") TO PRINT PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt3") TO PRINT PROMPT NOCONSOLE
                ENDCASE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria persistida
    * Para fins de auditoria/log, retorna chave composta dos filtros principais
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = DTOC(THIS.this_dDatai) + "|" + DTOC(THIS.this_dDataf) + "|" + ;
                     ALLTRIM(THIS.this_cTpGOp) + "|" + ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + STR(THIS.this_nAgru, 1)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao persiste)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * Em relatorios, a carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE

