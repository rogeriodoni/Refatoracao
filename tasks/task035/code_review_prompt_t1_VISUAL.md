# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_OperacoesE' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_OperacoesS' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_SigCdCeg' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_OperacoesE' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_OperacoesS' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_SigCdCeg' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreato.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2033 linhas total):

*-- Linhas 13 a 23:
13: *   - optImagem (1=Com Imagem, 2=Sem Imagem)
14: *   - optTipos  (1=Analitico, 2=Sintetico)
15: *   - optDiferencas (1=Ignorar, 2=Sem Diferenca, 3=Positiva, 4=Negativa)
16: *   - grd_4c_OperacoesE + cmd_4c_BtnGradeE (tipos de entrada)
17: *   - grd_4c_OperacoesS + cmd_4c_BtnGradeS (tipos de saida)
18: *   - grd_4c_SigCdCeg   + cmd_4c_BtnCeg   (contas de estoque)
19: *==============================================================================
20: 
21: DEFINE CLASS FormSigreato AS FormBase
22: 
23:     *-- Dimensoes EXATAS baseadas no original SIGREATO.SCX

*-- Linhas 55 a 63:
55:         loc_lSucesso   = .F.
56:         loc_lContinuar = .T.
57:         TRY
58:             THIS.Caption = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque Por Tipo de Opera" + CHR(231) + CHR(227) + "o"
59: 
60:             IF TYPE("gc_4c_CaminhoIcones") = "U"
61:                 gc_4c_CaminhoIcones = ""
62:             ENDIF
63:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 83 a 92:
83:                 THIS.ConfigurarBotoes()
84:                 THIS.ConfigurarPageFrame()
85:                 THIS.ConfigurarPaginaLista()
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
88:                 THIS.LimparCampos()
89:                 THIS.Visible   = .T.
90:                 loc_lSucesso   = .T.
91:             ENDIF
92: 

*-- Linhas 105 a 140:
105:     PROTECTED PROCEDURE ConfigurarCabecalho()
106:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
107:         WITH THIS.cnt_4c_Cabecalho
108:             .Top         = 0
109:             .Left        = 0
110:             .Width       = THIS.Width
111:             .Height      = 80
112:             .BackColor   = RGB(100, 100, 100)
113:             .BackStyle   = 1
114:             .BorderWidth = 0
115:             .Visible     = .T.
116:         ENDWITH
117:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
118:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
119:             .Top       = 17
120:             .Left      = 12
121:             .AutoSize  = .T.
122:             .Caption   = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque Por Tipo de Opera" + CHR(231) + CHR(227) + "o"
123:             .FontName  = "Tahoma"
124:             .FontSize  = 12
125:             .FontBold  = .T.
126:             .ForeColor = RGB(0, 0, 0)
127:             .BackStyle = 0
128:             .Visible   = .T.
129:         ENDWITH
130:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
131:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
132:             .Top       = 20
133:             .Left      = 10
134:             .AutoSize  = .T.
135:             .Caption   = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque Por Tipo de Opera" + CHR(231) + CHR(227) + "o"
136:             .FontName  = "Tahoma"
137:             .FontSize  = 12
138:             .FontBold  = .T.
139:             .ForeColor = RGB(255, 255, 255)
140:             .BackStyle = 0

*-- Linhas 149 a 174:
149:     PROTECTED PROCEDURE ConfigurarBotoes()
150:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
151:         WITH THIS.cmg_4c_Botoes
152:             .Top           = 0
153:             .Left          = 529
154:             .Width         = 273
155:             .Height        = 80
156:             .ButtonCount   = 4
157:             .BackStyle     = 0
158:             .BorderStyle   = 0
159:             .BorderColor   = RGB(136, 189, 188)
160:             .SpecialEffect = 1
161:             .Themes        = .F.
162:             .Visible       = .T.
163:         ENDWITH
164:         WITH THIS.cmg_4c_Botoes.Buttons(1)
165:             .Top             = 5
166:             .Left            = 5
167:             .Width           = 65
168:             .Height          = 70
169:             .Caption         = "Visualizar"
170:             .FontName        = "Tahoma"
171:             .FontBold        = .T.
172:             .FontItalic      = .T.
173:             .FontSize        = 8
174:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 181 a 193:
181:             .Visible         = .T.
182:         ENDWITH
183:         WITH THIS.cmg_4c_Botoes.Buttons(2)
184:             .Top             = 5
185:             .Left            = 71
186:             .Width           = 65
187:             .Height          = 70
188:             .Caption         = "Imprimir"
189:             .FontName        = "Tahoma"
190:             .FontBold        = .T.
191:             .FontItalic      = .T.
192:             .FontSize        = 8
193:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 200 a 212:
200:             .Visible         = .T.
201:         ENDWITH
202:         WITH THIS.cmg_4c_Botoes.Buttons(3)
203:             .Top             = 5
204:             .Left            = 137
205:             .Width           = 65
206:             .Height          = 70
207:             .Caption         = "Doc Excel"
208:             .FontName        = "Tahoma"
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .FontSize        = 8
212:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 219 a 231:
219:             .Visible         = .T.
220:         ENDWITH
221:         WITH THIS.cmg_4c_Botoes.Buttons(4)
222:             .Top             = 5
223:             .Left            = 203
224:             .Width           = 65
225:             .Height          = 70
226:             .Caption         = "Encerrar"
227:             .FontName        = "Tahoma"
228:             .FontBold        = .T.
229:             .FontItalic      = .T.
230:             .FontSize        = 8
231:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 248 a 261:
248:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
249:         loc_oPgf = THIS.pgf_4c_Paginas
250:         loc_oPgf.PageCount = 1
251:         loc_oPgf.Top    = 85
252:         loc_oPgf.Left   = -1
253:         loc_oPgf.Width  = THIS.Width + 2
254:         loc_oPgf.Height = THIS.Height - 85
255:         loc_oPgf.Tabs   = .F.
256:         loc_oPgf.Page1.Caption   = "Filtros"
257:         loc_oPgf.Page1.FontName  = "Tahoma"
258:         loc_oPgf.Page1.FontSize  = 8
259:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
260:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
261:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 288 a 382:
288: 
289:         loc_oPg.AddObject("cnt_4c_Local", "Container")
290:         WITH loc_oPg.cnt_4c_Local
291:             .Top         = 0
292:             .Left        = 0
293:             .Width       = 800
294:             .Height      = 425
295:             .BackStyle   = 0
296:             .BorderWidth = 0
297:             .Visible     = .T.
298:         ENDWITH
299:         loc_oCnt = loc_oPg.cnt_4c_Local
300: 
301:         *-- Periodo -------------------------------------------------------
302:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
303:         WITH loc_oCnt.lbl_4c_Periodo
304:             .AutoSize  = .T.
305:             .FontName  = "Tahoma"
306:             .FontSize  = 8
307:             .Caption   = "Per" + CHR(237) + "odo :"
308:             .Left      = 68
309:             .Top       = 13
310:             .ForeColor = RGB(90, 90, 90)
311:             .BackStyle = 0
312:             .Visible   = .T.
313:         ENDWITH
314: 
315:         loc_oCnt.AddObject("txt_4c_DataIni", "TextBox")
316:         WITH loc_oCnt.txt_4c_DataIni
317:             .Height        = 23
318:             .Left          = 116
319:             .Top           = 10
320:             .Width         = 80
321:             .Alignment     = 3
322:             .FontName      = "Tahoma"
323:             .FontSize      = 8
324:             .ForeColor     = RGB(0, 0, 0)
325:             .SpecialEffect = 1
326:             .Themes        = .F.
327:             .Value         = DATE()
328:             .Visible       = .T.
329:         ENDWITH
330: 
331:         loc_oCnt.AddObject("lbl_4c_Ate", "Label")
332:         WITH loc_oCnt.lbl_4c_Ate
333:             .AutoSize  = .T.
334:             .FontName  = "Tahoma"
335:             .FontSize  = 8
336:             .Caption   = " " + CHR(233) + " "
337:             .Left      = 200
338:             .Top       = 13
339:             .BackStyle = 0
340:             .Visible   = .T.
341:         ENDWITH
342: 
343:         loc_oCnt.AddObject("txt_4c_DataFin", "TextBox")
344:         WITH loc_oCnt.txt_4c_DataFin
345:             .Height        = 23
346:             .Left          = 215
347:             .Top           = 10
348:             .Width         = 80
349:             .Alignment     = 3
350:             .FontName      = "Tahoma"
351:             .FontSize      = 8
352:             .ForeColor     = RGB(0, 0, 0)
353:             .SpecialEffect = 1
354:             .Themes        = .F.
355:             .Value         = DATE()
356:             .Visible       = .T.
357:         ENDWITH
358: 
359:         *-- Grupo de Produto -----------------------------------------------
360:         loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
361:         WITH loc_oCnt.lbl_4c_Grupo
362:             .AutoSize  = .T.
363:             .FontName  = "Tahoma"
364:             .FontSize  = 8
365:             .Caption   = "Grupo :"
366:             .Left      = 75
367:             .Top       = 38
368:             .ForeColor = RGB(90, 90, 90)
369:             .BackStyle = 0
370:             .Visible   = .T.
371:         ENDWITH
372: 
373:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
374:         WITH loc_oCnt.txt_4c_Grupo
375:             .Height        = 23
376:             .Left          = 116
377:             .Top           = 35
378:             .Width         = 31
379:             .MaxLength     = 3
380:             .Format        = "!K"
381:             .FontName      = "Tahoma"
382:             .FontSize      = 8

*-- Linhas 390 a 399:
390:         loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
391:         WITH loc_oCnt.txt_4c_DGrupo
392:             .Height        = 23
393:             .Left          = 149
394:             .Top           = 35
395:             .Width         = 181
396:             .MaxLength     = 20
397:             .Format        = "!K"
398:             .FontName      = "Tahoma"
399:             .FontSize      = 8

*-- Linhas 405 a 430:
405:         ENDWITH
406: 
407:         *-- Produto --------------------------------------------------------
408:         loc_oCnt.AddObject("lbl_4c_CPros", "Label")
409:         WITH loc_oCnt.lbl_4c_CPros
410:             .AutoSize  = .T.
411:             .FontName  = "Tahoma"
412:             .FontSize  = 8
413:             .Caption   = "Produto :"
414:             .Left      = 66
415:             .Top       = 63
416:             .ForeColor = RGB(90, 90, 90)
417:             .BackStyle = 0
418:             .Visible   = .T.
419:         ENDWITH
420: 
421:         loc_oCnt.AddObject("txt_4c_CPros", "TextBox")
422:         WITH loc_oCnt.txt_4c_CPros
423:             .Height        = 23
424:             .Left          = 116
425:             .Top           = 60
426:             .Width         = 108
427:             .MaxLength     = 14
428:             .Format        = "K"
429:             .FontName      = "Tahoma"
430:             .FontSize      = 8

*-- Linhas 438 a 447:
438:         loc_oCnt.AddObject("txt_4c_DPros", "TextBox")
439:         WITH loc_oCnt.txt_4c_DPros
440:             .Height        = 23
441:             .Left          = 225
442:             .Top           = 60
443:             .Width         = 290
444:             .MaxLength     = 40
445:             .Format        = "K"
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8

*-- Linhas 453 a 478:
453:         ENDWITH
454: 
455:         *-- Linha ----------------------------------------------------------
456:         loc_oCnt.AddObject("lbl_4c_Linha", "Label")
457:         WITH loc_oCnt.lbl_4c_Linha
458:             .AutoSize  = .T.
459:             .FontName  = "Tahoma"
460:             .FontSize  = 8
461:             .Caption   = "Linha :"
462:             .Left      = 79
463:             .Top       = 88
464:             .ForeColor = RGB(90, 90, 90)
465:             .BackStyle = 0
466:             .Visible   = .T.
467:         ENDWITH
468: 
469:         loc_oCnt.AddObject("txt_4c_Linha", "TextBox")
470:         WITH loc_oCnt.txt_4c_Linha
471:             .Height        = 23
472:             .Left          = 116
473:             .Top           = 85
474:             .Width         = 80
475:             .MaxLength     = 10
476:             .Format        = "K"
477:             .FontName      = "Tahoma"
478:             .FontSize      = 8

*-- Linhas 486 a 495:
486:         loc_oCnt.AddObject("txt_4c_DLin", "TextBox")
487:         WITH loc_oCnt.txt_4c_DLin
488:             .Height        = 23
489:             .Left          = 198
490:             .Top           = 85
491:             .Width         = 290
492:             .MaxLength     = 40
493:             .Format        = "K"
494:             .FontName      = "Tahoma"
495:             .FontSize      = 8

*-- Linhas 501 a 526:
501:         ENDWITH
502: 
503:         *-- Fornecedor -----------------------------------------------------
504:         loc_oCnt.AddObject("lbl_4c_Fornecedor", "Label")
505:         WITH loc_oCnt.lbl_4c_Fornecedor
506:             .AutoSize  = .T.
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .Caption   = "Fornecedor :"
510:             .Left      = 49
511:             .Top       = 113
512:             .ForeColor = RGB(90, 90, 90)
513:             .BackStyle = 0
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         loc_oCnt.AddObject("txt_4c_Fornecedor", "TextBox")
518:         WITH loc_oCnt.txt_4c_Fornecedor
519:             .Height        = 23
520:             .Left          = 116
521:             .Top           = 110
522:             .Width         = 80
523:             .MaxLength     = 10
524:             .Format        = "K!"
525:             .FontName      = "Tahoma"
526:             .FontSize      = 8

*-- Linhas 534 a 543:
534:         loc_oCnt.AddObject("txt_4c_DFornecedor", "TextBox")
535:         WITH loc_oCnt.txt_4c_DFornecedor
536:             .Height        = 23
537:             .Left          = 198
538:             .Top           = 110
539:             .Width         = 290
540:             .MaxLength     = 40
541:             .Format        = "K!"
542:             .FontName      = "Tahoma"
543:             .FontSize      = 8

*-- Linhas 551 a 690:
551:         *-- optImagem (Com Imagem / Sem Imagem) - padrao: Sem Imagem (2) ---
552:         loc_oCnt.AddObject("opt_4c_Imagem", "OptionGroup")
553:         WITH loc_oCnt.opt_4c_Imagem
554:             .Top         = 10
555:             .Left        = 521
556:             .Width       = 211
557:             .Height      = 22
558:             .ButtonCount = 2
559:             .BackStyle   = 0
560:             .BorderStyle = 0
561:             .SpecialEffect = 1
562:             .Themes      = .F.
563:             .Value       = 2
564:             .Visible     = .T.
565:         ENDWITH
566:         WITH loc_oCnt.opt_4c_Imagem.Buttons(1)
567:             .Caption   = "Com Imagem"
568:             .Left      = 5
569:             .Top       = 2
570:             .Width     = 80
571:             .Height    = 15
572:             .AutoSize  = .T.
573:             .BackStyle = 0
574:             .FontName  = "Tahoma"
575:             .FontSize  = 8
576:             .ForeColor = RGB(90, 90, 90)
577:         ENDWITH
578:         WITH loc_oCnt.opt_4c_Imagem.Buttons(2)
579:             .Caption   = "Sem Imagem"
580:             .Left      = 104
581:             .Top       = 2
582:             .Width     = 79
583:             .Height    = 15
584:             .AutoSize  = .T.
585:             .BackStyle = 0
586:             .FontName  = "Tahoma"
587:             .FontSize  = 8
588:             .ForeColor = RGB(90, 90, 90)
589:         ENDWITH
590: 
591:         *-- optTipos (Analitico / Sintetico) - padrao: Analitico (1) ------
592:         loc_oCnt.AddObject("opt_4c_Tipos", "OptionGroup")
593:         WITH loc_oCnt.opt_4c_Tipos
594:             .Top         = 35
595:             .Left        = 521
596:             .Width       = 211
597:             .Height      = 22
598:             .ButtonCount = 2
599:             .BackStyle   = 0
600:             .BorderStyle = 0
601:             .SpecialEffect = 1
602:             .Themes      = .F.
603:             .Value       = 1
604:             .Visible     = .T.
605:         ENDWITH
606:         WITH loc_oCnt.opt_4c_Tipos.Buttons(1)
607:             .Caption   = "Anal" + CHR(237) + "tico"
608:             .Left      = 5
609:             .Top       = 2
610:             .Width     = 58
611:             .Height    = 15
612:             .AutoSize  = .T.
613:             .BackStyle = 0
614:             .FontName  = "Tahoma"
615:             .FontSize  = 8
616:             .ForeColor = RGB(90, 90, 90)
617:         ENDWITH
618:         WITH loc_oCnt.opt_4c_Tipos.Buttons(2)
619:             .Caption   = "Sint" + CHR(233) + "tico"
620:             .Left      = 104
621:             .Top       = 2
622:             .Width     = 78
623:             .Height    = 15
624:             .AutoSize  = .T.
625:             .BackStyle = 0
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .ForeColor = RGB(90, 90, 90)
629:         ENDWITH
630: 
631:         *-- optDiferencas (4 opcoes) - padrao: Ignorar (1) ----------------
632:         loc_oCnt.AddObject("opt_4c_Diferencas", "OptionGroup")
633:         WITH loc_oCnt.opt_4c_Diferencas
634:             .Top         = 60
635:             .Left        = 521
636:             .Width       = 211
637:             .Height      = 72
638:             .ButtonCount = 4
639:             .BackStyle   = 0
640:             .BorderStyle = 0
641:             .SpecialEffect = 1
642:             .Themes      = .F.
643:             .Value       = 1
644:             .Visible     = .T.
645:         ENDWITH
646:         WITH loc_oCnt.opt_4c_Diferencas.Buttons(1)
647:             .Caption   = "Ignorar Diferen" + CHR(231) + "as"
648:             .Left      = 5
649:             .Top       = 3
650:             .Width     = 108
651:             .Height    = 15
652:             .AutoSize  = .T.
653:             .BackStyle = 0
654:             .FontName  = "Tahoma"
655:             .FontSize  = 8
656:             .ForeColor = RGB(90, 90, 90)
657:         ENDWITH
658:         WITH loc_oCnt.opt_4c_Diferencas.Buttons(2)
659:             .Caption   = "Sem Diferen" + CHR(231) + "a"
660:             .Left      = 5
661:             .Top       = 19
662:             .Width     = 87
663:             .Height    = 15
664:             .AutoSize  = .T.
665:             .BackStyle = 0
666:             .FontName  = "Tahoma"
667:             .FontSize  = 8
668:             .ForeColor = RGB(90, 90, 90)
669:         ENDWITH
670:         WITH loc_oCnt.opt_4c_Diferencas.Buttons(3)
671:             .Caption   = "Diferen" + CHR(231) + "a Positiva"
672:             .Left      = 5
673:             .Top       = 35
674:             .Width     = 104
675:             .Height    = 15
676:             .AutoSize  = .T.
677:             .BackStyle = 0
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .ForeColor = RGB(90, 90, 90)
681:         ENDWITH
682:         WITH loc_oCnt.opt_4c_Diferencas.Buttons(4)
683:             .Caption   = "Diferen" + CHR(231) + "a Negativa"
684:             .Left      = 5
685:             .Top       = 51
686:             .Width     = 110
687:             .Height    = 15
688:             .AutoSize  = .T.
689:             .BackStyle = 0
690:             .FontName  = "Tahoma"

*-- Linhas 703 a 896:
703:         *-- Linha divisoria esquerda (Tipos de Operacoes) ------------------
704:         loc_oCnt.AddObject("shp_4c_Div1", "Shape")
705:         WITH loc_oCnt.shp_4c_Div1
706:             .Top         = 144
707:             .Left        = 42
708:             .Width       = 333
709:             .Height      = 2
710:             .BorderStyle = 6
711:             .BorderWidth = 2
712:             .FillStyle   = 1
713:             .SpecialEffect = 0
714:             .Visible     = .T.
715:         ENDWITH
716: 
717:         *-- Linha divisoria direita (Estoques) ----------------------------
718:         loc_oCnt.AddObject("shp_4c_Div2", "Shape")
719:         WITH loc_oCnt.shp_4c_Div2
720:             .Top         = 144
721:             .Left        = 414
722:             .Width       = 267
723:             .Height      = 2
724:             .BorderStyle = 6
725:             .BorderWidth = 2
726:             .FillStyle   = 1
727:             .SpecialEffect = 0
728:             .Visible     = .T.
729:         ENDWITH
730: 
731:         *-- Label "Tipos de Operacoes" ------------------------------------
732:         loc_oCnt.AddObject("lbl_4c_TiposOpe", "Label")
733:         WITH loc_oCnt.lbl_4c_TiposOpe
734:             .AutoSize  = .T.
735:             .FontBold  = .T.
736:             .FontName  = "Tahoma"
737:             .FontSize  = 8
738:             .Caption   = " Tipos de Opera" + CHR(231) + CHR(245) + "es "
739:             .Left      = 47
740:             .Top       = 148
741:             .ForeColor = RGB(90, 90, 90)
742:             .BackStyle = 0
743:             .Visible   = .T.
744:         ENDWITH
745: 
746:         *-- Label "Estoques" -----------------------------------------------
747:         loc_oCnt.AddObject("lbl_4c_Estoques", "Label")
748:         WITH loc_oCnt.lbl_4c_Estoques
749:             .AutoSize  = .T.
750:             .FontBold  = .T.
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .Caption   = " Estoques  "
754:             .Left      = 421
755:             .Top       = 148
756:             .ForeColor = RGB(90, 90, 90)
757:             .BackStyle = 0
758:             .Visible   = .T.
759:         ENDWITH
760:     ENDPROC
761: 
762:     *--------------------------------------------------------------------------
763:     * ConfigurarGrades - Cria as 3 grades com botoes de marca/desmarca:
764:     *   grd_4c_OperacoesE + cmd_4c_BtnGradeE (tipos de entrada)
765:     *   grd_4c_OperacoesS + cmd_4c_BtnGradeS (tipos de saida)
766:     *   grd_4c_SigCdCeg   + cmd_4c_BtnCeg   (contas de estoque)
767:     *--------------------------------------------------------------------------
768:     PROTECTED PROCEDURE ConfigurarGrades()
769:         LOCAL loc_oCnt, loc_oGrd
770:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
771: 
772:         *-- Garantir cursores placeholder se InicializarDados foi pulado ----
773:         IF !USED("cursor_4c_OperacoesE")
774:             CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
775:         ENDIF
776:         IF !USED("cursor_4c_OperacoesS")
777:             CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
778:         ENDIF
779:         IF !USED("cursor_4c_SigCdCeg")
780:             CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
781:         ENDIF
782: 
783:         *====================================================================
784:         * Grade de Operacoes de Entrada
785:         *====================================================================
786:         loc_oCnt.AddObject("grd_4c_OperacoesE", "Grid")
787:         WITH loc_oCnt.grd_4c_OperacoesE
788:             .ColumnCount       = 3
789:             .AllowHeaderSizing = .F.
790:             .AllowRowSizing    = .F.
791:             .DeleteMark        = .F.
792:             .GridLines         = 3
793:             .HeaderHeight      = 16
794:             .Height            = 99
795:             .Left              = 46
796:             .Panel             = 1
797:             .RecordMark        = .F.
798:             .RowHeight         = 16
799:             .ScrollBars        = 2
800:             .TabStop           = .F.
801:             .Top               = 163
802:             .Width             = 275
803:             .GridLineColor     = RGB(238, 238, 238)
804:             .FontName          = "Tahoma"
805:             .FontSize          = 8
806:             .Visible           = .T.
807:         ENDWITH
808:         loc_oGrd = loc_oCnt.grd_4c_OperacoesE
809:         loc_oGrd.ColumnCount = 3
810:         loc_oGrd.RecordSource = "cursor_4c_OperacoesE"
811: 
812:         WITH loc_oGrd.Column1
813:             .Width         = 15
814:             .Sparse        = .F.
815:             .Alignment     = 0
816:             .Enabled       = .T.
817:             .ReadOnly      = .F.
818:             .Movable       = .F.
819:             .Resizable     = .F.
820:             .FontName      = "Tahoma"
821:             .FontSize      = 8
822:         ENDWITH
823:         loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
824:         WITH loc_oGrd.Column1.chk_4c_Marca
825:             .Caption   = ""
826:             .Alignment = 0
827:             .BackStyle = 0
828:             .Enabled   = .T.
829:         ENDWITH
830:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
831:         loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesE.SelImp"
832: 
833:         WITH loc_oGrd.Column2
834:             .Width         = 20
835:             .ControlSource = "cursor_4c_OperacoesE.Codigos"
836:             .ReadOnly      = .T.
837:             .Enabled       = .T.
838:             .Movable       = .F.
839:             .Resizable     = .F.
840:             .FontName      = "Courier New"
841:             .FontSize      = 8
842:         ENDWITH
843:         loc_oGrd.Column2.Header1.Caption  = ""
844:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
845: 
846:         WITH loc_oGrd.Column3
847:             .Width         = 208
848:             .ControlSource = "cursor_4c_OperacoesE.Descrs"
849:             .ReadOnly      = .T.
850:             .Enabled       = .T.
851:             .Movable       = .F.
852:             .Resizable     = .F.
853:             .FontName      = "Courier New"
854:             .FontSize      = 8
855:         ENDWITH
856:         loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Entrada"
857:         loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
858:         loc_oGrd.Column3.Header1.Alignment  = 2
859: 
860:         *-- Botoes Marca/Desmarca para Entradas ----------------------------
861:         loc_oCnt.AddObject("cmd_4c_BtnGradeE", "CommandGroup")
862:         WITH loc_oCnt.cmd_4c_BtnGradeE
863:             .AutoSize    = .T.
864:             .ButtonCount = 2
865:             .BackStyle   = 0
866:             .BorderStyle = 0
867:             .Value       = 1
868:             .Height      = 90
869:             .Left        = 321
870:             .Top         = 168
871:             .Width       = 50
872:             .Visible     = .T.
873:         ENDWITH
874:         WITH loc_oCnt.cmd_4c_BtnGradeE.Buttons(1)
875:             .Top         = 5
876:             .Left        = 5
877:             .Height      = 40
878:             .Width       = 40
879:             .Caption     = ""
880:             .ToolTipText = "Selecionar todos"
881:             .ForeColor   = RGB(36, 84, 155)
882:             .BackColor   = RGB(255, 255, 255)
883:             .Themes      = .F.
884:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
885:         ENDWITH
886:         WITH loc_oCnt.cmd_4c_BtnGradeE.Buttons(2)
887:             .Top         = 45
888:             .Left        = 5
889:             .Height      = 40
890:             .Width       = 40
891:             .Caption     = ""
892:             .ToolTipText = "Desmarcar todos"
893:             .ForeColor   = RGB(36, 84, 155)
894:             .BackColor   = RGB(255, 255, 255)
895:             .Themes      = .F.
896:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_16.jpg"

*-- Linhas 908 a 1012:
908:             .GridLines         = 3
909:             .HeaderHeight      = 16
910:             .Height            = 99
911:             .Left              = 46
912:             .Panel             = 1
913:             .RecordMark        = .F.
914:             .RowHeight         = 16
915:             .ScrollBars        = 2
916:             .TabStop           = .F.
917:             .Top               = 276
918:             .Width             = 275
919:             .GridLineColor     = RGB(238, 238, 238)
920:             .FontName          = "Tahoma"
921:             .FontSize          = 8
922:             .Visible           = .T.
923:         ENDWITH
924:         loc_oGrd = loc_oCnt.grd_4c_OperacoesS
925:         loc_oGrd.ColumnCount = 3
926:         loc_oGrd.RecordSource = "cursor_4c_OperacoesS"
927: 
928:         WITH loc_oGrd.Column1
929:             .Width         = 15
930:             .Sparse        = .F.
931:             .Alignment     = 0
932:             .Enabled       = .T.
933:             .ReadOnly      = .F.
934:             .Movable       = .F.
935:             .Resizable     = .F.
936:             .FontName      = "Tahoma"
937:             .FontSize      = 8
938:         ENDWITH
939:         loc_oGrd.Column1.AddObject("chk_4c_marca2", "CheckBox")
940:         WITH loc_oGrd.Column1.chk_4c_marca2
941:             .Caption   = ""
942:             .Alignment = 0
943:             .BackStyle = 0
944:             .Enabled   = .T.
945:         ENDWITH
946:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
947:         loc_oGrd.Column1.ControlSource  = "cursor_4c_OperacoesS.SelImp"
948: 
949:         WITH loc_oGrd.Column2
950:             .Width         = 20
951:             .ControlSource = "cursor_4c_OperacoesS.Codigos"
952:             .ReadOnly      = .T.
953:             .Enabled       = .T.
954:             .Movable       = .F.
955:             .Resizable     = .F.
956:             .FontName      = "Courier New"
957:             .FontSize      = 8
958:         ENDWITH
959:         loc_oGrd.Column2.Header1.Caption  = ""
960:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
961: 
962:         WITH loc_oGrd.Column3
963:             .Width         = 208
964:             .ControlSource = "cursor_4c_OperacoesS.Descrs"
965:             .ReadOnly      = .T.
966:             .Enabled       = .T.
967:             .Movable       = .F.
968:             .Resizable     = .F.
969:             .FontName      = "Courier New"
970:             .FontSize      = 8
971:         ENDWITH
972:         loc_oGrd.Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Sa" + CHR(237) + "da"
973:         loc_oGrd.Column3.Header1.ForeColor  = RGB(90, 90, 90)
974:         loc_oGrd.Column3.Header1.Alignment  = 2
975: 
976:         *-- Botoes Marca/Desmarca para Saidas ------------------------------
977:         loc_oCnt.AddObject("cmd_4c_BtnGradeS", "CommandGroup")
978:         WITH loc_oCnt.cmd_4c_BtnGradeS
979:             .AutoSize    = .T.
980:             .ButtonCount = 2
981:             .BackStyle   = 0
982:             .BorderStyle = 0
983:             .Value       = 1
984:             .Height      = 90
985:             .Left        = 321
986:             .Top         = 282
987:             .Width       = 50
988:             .Visible     = .T.
989:         ENDWITH
990:         WITH loc_oCnt.cmd_4c_BtnGradeS.Buttons(1)
991:             .Top         = 5
992:             .Left        = 5
993:             .Height      = 40
994:             .Width       = 40
995:             .Caption     = ""
996:             .ToolTipText = "Selecionar todos"
997:             .ForeColor   = RGB(36, 84, 155)
998:             .BackColor   = RGB(255, 255, 255)
999:             .Themes      = .F.
1000:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1001:         ENDWITH
1002:         WITH loc_oCnt.cmd_4c_BtnGradeS.Buttons(2)
1003:             .Top         = 45
1004:             .Left        = 5
1005:             .Height      = 40
1006:             .Width       = 40
1007:             .Caption     = ""
1008:             .ToolTipText = "Desmarcar todos"
1009:             .ForeColor   = RGB(36, 84, 155)
1010:             .BackColor   = RGB(255, 255, 255)
1011:             .Themes      = .F.
1012:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_16.jpg"

*-- Linhas 1024 a 1127:
1024:             .GridLines         = 3
1025:             .HeaderHeight      = 16
1026:             .Height            = 211
1027:             .Left              = 421
1028:             .Panel             = 1
1029:             .RecordMark        = .F.
1030:             .RowHeight         = 16
1031:             .ScrollBars        = 2
1032:             .TabStop           = .F.
1033:             .Top               = 163
1034:             .Width             = 207
1035:             .GridLineColor     = RGB(238, 238, 238)
1036:             .FontName          = "Tahoma"
1037:             .FontSize          = 8
1038:             .Visible           = .T.
1039:         ENDWITH
1040:         loc_oGrd = loc_oCnt.grd_4c_SigCdCeg
1041:         loc_oGrd.ColumnCount = 3
1042:         loc_oGrd.RecordSource = "cursor_4c_SigCdCeg"
1043: 
1044:         WITH loc_oGrd.Column1
1045:             .Width         = 15
1046:             .Sparse        = .F.
1047:             .Alignment     = 0
1048:             .Enabled       = .T.
1049:             .ReadOnly      = .F.
1050:             .Movable       = .F.
1051:             .Resizable     = .F.
1052:             .FontName      = "Tahoma"
1053:             .FontSize      = 8
1054:         ENDWITH
1055:         loc_oGrd.Column1.AddObject("chk_4c_marca3", "CheckBox")
1056:         WITH loc_oGrd.Column1.chk_4c_marca3
1057:             .Caption   = ""
1058:             .Alignment = 0
1059:             .BackStyle = 0
1060:             .Enabled   = .T.
1061:         ENDWITH
1062:         loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
1063:         loc_oGrd.Column1.ControlSource  = "cursor_4c_SigCdCeg.lMarca"
1064: 
1065:         WITH loc_oGrd.Column2
1066:             .Width         = 80
1067:             .ControlSource = "cursor_4c_SigCdCeg.Grupos"
1068:             .ReadOnly      = .T.
1069:             .Enabled       = .T.
1070:             .Movable       = .F.
1071:             .Resizable     = .F.
1072:             .FontName      = "Courier New"
1073:             .FontSize      = 8
1074:         ENDWITH
1075:         loc_oGrd.Column2.Header1.Caption  = "Grupo"
1076:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1077: 
1078:         WITH loc_oGrd.Column3
1079:             .Width         = 80
1080:             .ControlSource = "cursor_4c_SigCdCeg.Contas"
1081:             .ReadOnly      = .T.
1082:             .Enabled       = .T.
1083:             .Movable       = .F.
1084:             .Resizable     = .F.
1085:             .FontName      = "Courier New"
1086:             .FontSize      = 8
1087:         ENDWITH
1088:         loc_oGrd.Column3.Header1.Caption  = "Conta"
1089:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1090: 
1091:         *-- Botoes Marca/Desmarca para SigCdCeg ----------------------------
1092:         loc_oCnt.AddObject("cmd_4c_BtnCeg", "CommandGroup")
1093:         WITH loc_oCnt.cmd_4c_BtnCeg
1094:             .AutoSize    = .T.
1095:             .ButtonCount = 2
1096:             .BackStyle   = 0
1097:             .BorderStyle = 0
1098:             .Value       = 1
1099:             .Height      = 90
1100:             .Left        = 632
1101:             .Top         = 225
1102:             .Width       = 50
1103:             .Visible     = .T.
1104:         ENDWITH
1105:         WITH loc_oCnt.cmd_4c_BtnCeg.Buttons(1)
1106:             .Top         = 5
1107:             .Left        = 5
1108:             .Height      = 40
1109:             .Width       = 40
1110:             .Caption     = ""
1111:             .ToolTipText = "Selecionar todos"
1112:             .ForeColor   = RGB(36, 84, 155)
1113:             .BackColor   = RGB(255, 255, 255)
1114:             .Themes      = .F.
1115:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1116:         ENDWITH
1117:         WITH loc_oCnt.cmd_4c_BtnCeg.Buttons(2)
1118:             .Top         = 45
1119:             .Left        = 5
1120:             .Height      = 40
1121:             .Width       = 40
1122:             .Caption     = ""
1123:             .ToolTipText = "Desmarcar todos"
1124:             .ForeColor   = RGB(36, 84, 155)
1125:             .BackColor   = RGB(255, 255, 255)
1126:             .Themes      = .F.
1127:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_16.jpg"

*-- Linhas 1136 a 1158:
1136:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1137:         loc_oCnt.AddObject("cnt_4c_Mensagem", "Container")
1138:         WITH loc_oCnt.cnt_4c_Mensagem
1139:             .Top         = 390
1140:             .Left        = 130
1141:             .Width       = 400
1142:             .Height      = 30
1143:             .BackStyle   = 0
1144:             .BorderWidth = 0
1145:             .Visible     = .F.
1146:         ENDWITH
1147:         loc_oCnt.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
1148:         WITH loc_oCnt.cnt_4c_Mensagem.lbl_4c_LblMensagem
1149:             .Top       = 5
1150:             .Left      = 10
1151:             .Width     = 380
1152:             .Height    = 22
1153:             .Caption   = "Aguarde!!!"
1154:             .FontName  = "Tahoma"
1155:             .FontSize  = 14
1156:             .FontBold  = .T.
1157:             .ForeColor = RGB(0, 0, 0)
1158:             .BackStyle = 0

*-- Linhas 1193 a 1203:
1193:         BINDEVENT(loc_oCnt.txt_4c_DFornecedor,    "KeyPress", THIS, "TxtDFornecedorKeyPress")
1194:         BINDEVENT(loc_oCnt.txt_4c_DFornecedor,    "DblClick", THIS, "TxtDFornecedorDblClick")
1195: 
1196:         BINDEVENT(loc_oCnt.cmd_4c_BtnGradeE,      "Click",    THIS, "CmdGradeEClick")
1197:         BINDEVENT(loc_oCnt.cmd_4c_BtnGradeS,      "Click",    THIS, "CmdGradeSClick")
1198:         BINDEVENT(loc_oCnt.cmd_4c_BtnCeg,         "Click",    THIS, "CmdCegClick")
1199:     ENDPROC
1200: 
1201:     *--------------------------------------------------------------------------
1202:     * LimparCampos - Inicializa/zera todos os campos de filtro
1203:     *--------------------------------------------------------------------------

*-- Linhas 1320 a 1356:
1320:     PROTECTED PROCEDURE ValidarSelecaoGrades()
1321:         LOCAL loc_lOK, loc_oCnt
1322:         loc_lOK  = .T.
1323:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1324: 
1325:         IF USED("cursor_4c_OperacoesE")
1326:             SELECT Codigos FROM cursor_4c_OperacoesE WHERE SelImp INTO CURSOR cursor_4c_TmpE READWRITE
1327:             IF RECCOUNT("cursor_4c_TmpE") < 1
1328:                 MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Entrada Foi Selecionado!!!", ;
1329:                     "Aten" + CHR(231) + CHR(227) + "o")
1330:                 IF VARTYPE(loc_oCnt.grd_4c_OperacoesE) = "O"
1331:                     loc_oCnt.grd_4c_OperacoesE.Column1.SetFocus()
1332:                 ENDIF
1333:                 IF USED("cursor_4c_TmpE")
1334:                     USE IN cursor_4c_TmpE
1335:                 ENDIF
1336:                 RETURN .F.
1337:             ENDIF
1338:         ENDIF
1339: 
1340:         IF USED("cursor_4c_OperacoesS")
1341:             SELECT Codigos FROM cursor_4c_OperacoesS WHERE SelImp INTO CURSOR cursor_4c_TmpS READWRITE
1342:             IF RECCOUNT("cursor_4c_TmpS") < 1
1343:                 MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da Foi Selecionado!!!", ;
1344:                     "Aten" + CHR(231) + CHR(227) + "o")
1345:                 IF VARTYPE(loc_oCnt.grd_4c_OperacoesS) = "O"
1346:                     loc_oCnt.grd_4c_OperacoesS.Column1.SetFocus()
1347:                 ENDIF
1348:                 IF USED("cursor_4c_TmpE")
1349:                     USE IN cursor_4c_TmpE
1350:                 ENDIF
1351:                 IF USED("cursor_4c_TmpS")
1352:                     USE IN cursor_4c_TmpS
1353:                 ENDIF
1354:                 RETURN .F.
1355:             ENDIF
1356:         ENDIF

*-- Linhas 1614 a 1678:
1614:     * Handlers Marca/Desmarca das grades
1615:     *==========================================================================
1616:     PROCEDURE CmdGradeEClick()
1617:         LOCAL loc_oCnt
1618:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1619:         IF !USED("cursor_4c_OperacoesE")
1620:             RETURN
1621:         ENDIF
1622:         IF loc_oCnt.cmd_4c_BtnGradeE.Value = 1
1623:             SELECT cursor_4c_OperacoesE
1624:             REPLACE ALL SelImp WITH .T.
1625:             GO TOP
1626:         ELSE
1627:             SELECT cursor_4c_OperacoesE
1628:             REPLACE ALL SelImp WITH .F.
1629:             GO TOP
1630:         ENDIF
1631:         loc_oCnt.grd_4c_OperacoesE.Refresh()
1632:     ENDPROC
1633: 
1634:     PROCEDURE CmdGradeSClick()
1635:         LOCAL loc_oCnt
1636:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1637:         IF !USED("cursor_4c_OperacoesS")
1638:             RETURN
1639:         ENDIF
1640:         IF loc_oCnt.cmd_4c_BtnGradeS.Value = 1
1641:             SELECT cursor_4c_OperacoesS
1642:             REPLACE ALL SelImp WITH .T.
1643:             GO TOP
1644:         ELSE
1645:             SELECT cursor_4c_OperacoesS
1646:             REPLACE ALL SelImp WITH .F.
1647:             GO TOP
1648:         ENDIF
1649:         loc_oCnt.grd_4c_OperacoesS.Refresh()
1650:     ENDPROC
1651: 
1652:     PROCEDURE CmdCegClick()
1653:         LOCAL loc_oCnt
1654:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1655:         IF !USED("cursor_4c_SigCdCeg")
1656:             RETURN
1657:         ENDIF
1658:         IF loc_oCnt.cmd_4c_BtnCeg.Value = 1
1659:             SELECT cursor_4c_SigCdCeg
1660:             REPLACE ALL lMarca WITH .T.
1661:             GO TOP
1662:         ELSE
1663:             SELECT cursor_4c_SigCdCeg
1664:             REPLACE ALL lMarca WITH .F.
1665:             GO TOP
1666:         ENDIF
1667:         loc_oCnt.grd_4c_SigCdCeg.Refresh()
1668:     ENDPROC
1669: 
1670:     *==========================================================================
1671:     * Lookups com FormBuscaAuxiliar
1672:     *==========================================================================
1673: 
1674:     *--------------------------------------------------------------------------
1675:     * AbrirBuscaGrupo - SigCdGrp (CGrus/DGrus)
1676:     *--------------------------------------------------------------------------
1677:     PROCEDURE AbrirBuscaGrupo()
1678:         LOCAL loc_oCnt, loc_cValor, loc_oForm


### BO (C:\4c\projeto\app\classes\sigreatoBO.prg):
*==============================================================================
* SIGREATOBO.PRG
* Business Object - Relatorio de Analise de Estoque Por Tipo de Operacao
*
* Herda de RelatorioBase
* Tabelas: SigMvHst (movimentos), SigCdOpe (operacoes), SigCdTom (tipos),
*          SigCdPro (produtos), SigCdGrp (grupos), SigCdCeg (contas estoque)
* Relatorios: SigReAto.frx (sem imagem) / SigReAtu.frx (com imagem)
*==============================================================================

DEFINE CLASS sigreatoBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial            = {}
    this_dDtFinal              = {}

    *-- Filtro de grupo (SigCdGrp - CGrus/DGrus, MaxLength=3)
    this_cGrupo                = ""
    this_cDGrupo               = ""

    *-- Filtro de produto (SigCdPro - CPros/DPros, MaxLength=14)
    this_cCPros                = ""
    this_cDPros                = ""

    *-- Filtro de linha (SigCdLin - Linhas/Descs, MaxLength=10)
    this_cLin                  = ""
    this_cDLin                 = ""

    *-- Filtro de fornecedor (MaxLength=10 codigo, MaxLength=40 descricao)
    this_cFornecedor           = ""
    this_cDFornecedor          = ""

    *-- Opcao de imagem: .T.=Com Imagem (optImagem.Value=1), .F.=Sem Imagem
    this_lImagem               = .F.

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico (optTipos)
    this_nTipos                = 1

    *-- Filtro de diferencas: 1=Ignorar, 2=Sem Diferenca, 3=Positiva, 4=Negativa
    this_nDiferenca            = 1

    *-- Mensagem de validacao de parametros (TrataErro do legado)
    this_cTrataErro            = ""

    *-- Cursor principal de saida do relatorio
    this_cCursorDados          = "crImpressao"

    *-- Nomes dos cursores de referencia carregados em InicializarDados
    this_cCursorOperacoesE     = "cursor_4c_OperacoesE"
    this_cCursorOperacoesS     = "cursor_4c_OperacoesS"
    this_cCursorSigCdCeg       = "cursor_4c_SigCdCeg"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao identicos ao legado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        THIS.this_nTipos     = 1
        THIS.this_nDiferenca = 1
        THIS.this_lImagem    = .F.
        THIS.this_cTrataErro = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(7), loc_nI
        loc_aCursors(1) = "cursor_4c_OperacoesE"
        loc_aCursors(2) = "cursor_4c_OperacoesS"
        loc_aCursors(3) = "cursor_4c_SigCdCeg"
        loc_aCursors(4) = "crImpressao"
        loc_aCursors(5) = "cursor_4c_Prods"
        loc_aCursors(6) = "cursor_4c_Entradas"
        loc_aCursors(7) = "cursor_4c_Saidas"
        FOR loc_nI = 1 TO 7
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursores de referencia usados pelo Form
    * Chamado no InicializarForm() do Formsigreato.
    * Cria:
    *   cursor_4c_OperacoesE : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=3 (entrada padrao)
    *   cursor_4c_OperacoesS : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=6 (saida padrao)
    *   cursor_4c_SigCdCeg   : lMarca L, Grupos C(10), Contas C(10)
    *     todos com lMarca=.F. (usuario marca quais incluir)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- 1. Tipos de operacao (SigCdTom) -> cursor_4c_OperacoesE e cursor_4c_OperacoesS
            IF USED("cursor_4c_TomTmp")
                USE IN cursor_4c_TomTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_TomTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Tipos de Opera" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OperacoesE")
                USE IN cursor_4c_OperacoesE
            ENDIF
            CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
            INDEX ON Codigos TAG Codigos

            IF USED("cursor_4c_OperacoesS")
                USE IN cursor_4c_OperacoesS
            ENDIF
            CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
            INDEX ON Codigos TAG Codigos

            SELECT cursor_4c_TomTmp
            GO TOP
            SCAN
                *-- Tipos=3 pre-selecionados em Entrada, Tipos=6 em Saida (padrao legado)
                INSERT INTO cursor_4c_OperacoesE (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 3, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
                INSERT INTO cursor_4c_OperacoesS (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 6, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
            ENDSCAN
            USE IN cursor_4c_TomTmp

            GO TOP IN cursor_4c_OperacoesE
            GO TOP IN cursor_4c_OperacoesS

            *-- 2. Contas de estoque (SigCdCeg) -> cursor_4c_SigCdCeg
            IF USED("cursor_4c_CegTmp")
                USE IN cursor_4c_CegTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos, Contas FROM SigCdCeg ORDER BY Grupos, Contas", ;
                "cursor_4c_CegTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Contas de Estoque (SigCdCeg)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigCdCeg")
                USE IN cursor_4c_SigCdCeg
            ENDIF
            CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
            INDEX ON Grupos + Contas TAG GruContas

            SELECT cursor_4c_CegTmp
            GO TOP
            SCAN
                INSERT INTO cursor_4c_SigCdCeg (lMarca, Grupos, Contas) ;
                    VALUES (.F., ALLTRIM(cursor_4c_CegTmp.Grupos), ALLTRIM(cursor_4c_CegTmp.Contas))
            ENDSCAN
            USE IN cursor_4c_CegTmp

            SELECT cursor_4c_SigCdCeg
            SET ORDER TO TAG GruContas
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida entradas antes de PrepararDados
    * Preenche this_cTrataErro com identificador do erro (equivale ao
    * ValidaBotoes/loObj.TrataErro do legado).
    * Retorna .T. se OK, .F. se ha erro (mensagem em this_cTrataErro).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        THIS.this_cTrataErro = ""

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cTrataErro = "DataInicial"
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cTrataErro = "DataFinal"
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cTrataErro = "Final < Inicial"
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaTipos - Constroi string "(cod1,cod2,...)" de Codigos marcados
    * par_cCursor: nome do cursor (cursor_4c_OperacoesE ou cursor_4c_OperacoesS)
    * Retorna string IN ex: "(3,6)" ou "" se nenhum selecionado
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaTipos(par_cCursor)
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED(par_cCursor)
            RETURN ""
        ENDIF

        SELECT (par_cCursor)
        GO TOP
        SCAN
            IF SelImp
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             ALLTRIM(STR(Codigos, 2))
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaContas - Constroi string de contas marcadas em cursor_4c_SigCdCeg
    * Retorna string IN ex: "('GRP1ACC1','GRP2ACC2')" ou "" se nenhuma marcada
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaContas()
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED("cursor_4c_SigCdCeg")
            RETURN ""
        ENDIF

        SELECT cursor_4c_SigCdCeg
        GO TOP
        SCAN
            IF lMarca
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             "'" + ALLTRIM(Grupos) + ALLTRIM(Contas) + "'"
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo gerando cursor crImpressao
    *
    * Estrutura de crImpressao (por produto):
    *   Linha header (Ordem='0000000001'): dados do produto, Entradas, Saidas
    *   Linhas conta (Ordem='0000000002',...): Estos=Grupo+Conta, Estoques=saldo liq
    *   Linha total  (Estos='Total :   '): soma de Estoques, Diferencas
    *
    * Entradas = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in E-selecionados
    * Saidas   = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in S-selecionados
    * Estoques = saldo liquido por conta (SigMvHst: E+qtd, S-qtd) no periodo
    * Diferencas = Entradas - Saidas - SUM(Estoques por conta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cEmp, loc_cDtI, loc_cDtF
        LOCAL loc_cInCodE, loc_cInCodS, loc_cInContas
        LOCAL loc_nResult, loc_cSQL, loc_cWhere
        LOCAL loc_nEntradas, loc_nSaidas, loc_nTotalEst, loc_nDif
        LOCAL loc_nOrdem, loc_cCPros
        LOCAL loc_nEstCount, loc_nEstLine

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF !THIS.ValidarParametros()
                loc_lSucesso = .F.
            ENDIF

            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)

            *-- Montar listas de tipos selecionados
            loc_cInCodE = THIS.MontarListaTipos("cursor_4c_OperacoesE")
            IF EMPTY(loc_cInCodE)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Entrada Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInCodS = THIS.MontarListaTipos("cursor_4c_OperacoesS")
            IF EMPTY(loc_cInCodS)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Sa" + CHR(237) + "da Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInContas = THIS.MontarListaContas()

            *-- Recriar crImpressao
            IF USED("crImpressao")
                USE IN crImpressao
            ENDIF
            CREATE CURSOR crImpressao (CPros C(14), DPros C(40), Reffs C(15), ;
                CGrus C(3), Linhas C(10), IFors C(10), Ordem C(10), ;
                Estos C(30), Imagem M, Pvens N(14,2), Moevs C(3), ;
                Entradas N(14,3), Saidas N(14,3), Grupos C(30), ;
                Margems N(9,6), Estoques N(14,3), Diferencas N(14,3))

            *-- Limpar cursores temporarios de execucao anterior
            LOCAL loc_aTmp(4), loc_nT
            loc_aTmp(1) = "cursor_4c_Prods"
            loc_aTmp(2) = "cursor_4c_Entradas"
            loc_aTmp(3) = "cursor_4c_Saidas"
            loc_aTmp(4) = "cursor_4c_EstContas"
            FOR loc_nT = 1 TO 4
                IF USED(loc_aTmp(loc_nT))
                    USE IN (loc_aTmp(loc_nT))
                ENDIF
            ENDFOR

            *-- Query 1: Produtos com movimentos no periodo (E ou S selecionados)
            loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros, p.Reffs, p.CGrus, p.Linhas," + ;
                       " p.IFors, p.Pvens, p.Moevs, p.Margems," + ;
                       " ISNULL(g.DGrus,'') AS DGrus" + ;
                       " FROM SigCdPro p" + ;
                       " LEFT JOIN SigCdGrp g ON g.CGrus = p.CGrus" + ;
                       " WHERE p.CPros IN" + ;
                       " (SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " UNION" + ;
                       " SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ")"

            *-- Filtros adicionais de produto
            IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cLin))
                loc_cSQL = loc_cSQL + ;
                           " AND p.Linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
                loc_cSQL = loc_cSQL + ;
                           " AND p.IFors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY p.DPros, p.CPros"

            WAIT WINDOW "Selecionando produtos..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prods")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar produtos"
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: Total Entradas por produto (tipos E selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Entradas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular entradas"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Entradas")
                SELECT cursor_4c_Entradas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 3: Total Saidas por produto (tipos S selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Saidas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular sa" + CHR(237) + "das"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Saidas")
                SELECT cursor_4c_Saidas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 4: Saldo liquido por produto/conta no periodo
            loc_cSQL = "SELECT h.Cpros, h.Grupos, h.Estos," + ;
                       " SUM(IIF(h.Opers='E', h.Qtds, -h.Qtds)) AS Estoques" + ;
                       " FROM SigMvHst h" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

            IF !EMPTY(loc_cInContas)
                loc_cSQL = loc_cSQL + ;
                           " AND (RTRIM(h.Grupos) + RTRIM(h.Estos)) IN " + loc_cInContas
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY h.Cpros, h.Grupos, h.Estos" + ;
                                  " ORDER BY h.Cpros, h.Grupos, h.Estos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstContas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular saldo de estoques"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_EstContas")
                SELECT cursor_4c_EstContas
                INDEX ON Cpros TAG Cpros
                GO TOP
            ENDIF

            *-- Iterar produtos e montar crImpressao
            WAIT WINDOW "Processando relat" + CHR(243) + "rio..." NOWAIT

            SELECT cursor_4c_Prods
            GO TOP

            SCAN
                loc_cCPros = PADR(ALLTRIM(cursor_4c_Prods.CPros), 14)

                *-- Entradas deste produto
                loc_nEntradas = 0
                IF USED("cursor_4c_Entradas")
                    SELECT cursor_4c_Entradas
                    IF SEEK(loc_cCPros, "cursor_4c_Entradas", "Cpros")
                        loc_nEntradas = NVL(cursor_4c_Entradas.Total, 0)
                    ENDIF
                ENDIF

                *-- Saidas deste produto
                loc_nSaidas = 0
                IF USED("cursor_4c_Saidas")
                    SELECT cursor_4c_Saidas
                    IF SEEK(loc_cCPros, "cursor_4c_Saidas", "Cpros")
                        loc_nSaidas = NVL(cursor_4c_Saidas.Total, 0)
                    ENDIF
                ENDIF

                *-- Linhas de conta para este produto
                LOCAL loc_aEst(1,3)
                loc_nEstCount = 0
                loc_nTotalEst = 0

                IF USED("cursor_4c_EstContas")
                    SELECT cursor_4c_EstContas
                    LOCATE FOR Cpros = loc_cCPros
                    SCAN WHILE Cpros = loc_cCPros
                        loc_nEstCount = loc_nEstCount + 1
                        DIMENSION loc_aEst(loc_nEstCount, 3)
                        loc_aEst[loc_nEstCount, 1] = ALLTRIM(cursor_4c_EstContas.Grupos)
                        loc_aEst[loc_nEstCount, 2] = ALLTRIM(cursor_4c_EstContas.Estos)
                        loc_aEst[loc_nEstCount, 3] = NVL(cursor_4c_EstContas.Estoques, 0)
                        loc_nTotalEst = loc_nTotalEst + NVL(cursor_4c_EstContas.Estoques, 0)
                    ENDSCAN
                ENDIF

                *-- Diferenca = Entradas - Saidas - SomEstoques
                loc_nDif = loc_nEntradas - loc_nSaidas - loc_nTotalEst

                *-- Aplicar filtro optDiferencas
                DO CASE
                    CASE THIS.this_nDiferenca = 2
                        IF ABS(loc_nDif) > 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 3
                        IF loc_nDif <= 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 4
                        IF loc_nDif >= -0.001
                            LOOP
                        ENDIF
                ENDCASE

                *-- Linha header do produto (Ordem='0000000001')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, DPros, Reffs, CGrus, Linhas, IFors, ;
                    Ordem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems) ;
                    VALUES (loc_cCPros, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DPros), 40), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Reffs), 15), ;
                        PADR(ALLTRIM(cursor_4c_Prods.CGrus), 3), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Linhas), 10), ;
                        PADR(ALLTRIM(cursor_4c_Prods.IFors), 10), ;
                        "0000000001", ;
                        NVL(cursor_4c_Prods.Pvens, 0), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Moevs), 3), ;
                        loc_nEntradas, loc_nSaidas, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DGrus), 30), ;
                        NVL(cursor_4c_Prods.Margems, 0))

                *-- Linhas de conta (Ordem='0000000002', '0000000003', ...)
                loc_nOrdem = 2
                FOR loc_nEstLine = 1 TO loc_nEstCount
                    SELECT crImpressao
                    INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques) ;
                        VALUES (loc_cCPros, ;
                            PADL(ALLTRIM(STR(loc_nOrdem)), 10, "0"), ;
                            PADR(loc_aEst[loc_nEstLine,1] + " " + ;
                                 loc_aEst[loc_nEstLine,2], 30), ;
                            loc_aEst[loc_nEstLine,3])
                    loc_nOrdem = loc_nOrdem + 1
                ENDFOR

                *-- Linha total (Estos='Total :   ')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques, Diferencas) ;
                    VALUES (loc_cCPros, ;
                        "9999999999", ;
                        PADR("Total :   ", 30), ;
                        loc_nTotalEst, loc_nDif)

            ENDSCAN

            WAIT CLEAR

            SELECT crImpressao
            GO TOP

            loc_lSucesso = (RECCOUNT("crImpressao") > 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Nenhum dado encontrado para os filtros informados"
            ENDIF

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorExcel - Prepara cursor csExcell para exportacao
    * Analogo ao evento "documentoexcel" do legado.
    * Chama PrepararDados antes de montar o cursor de exportacao.
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorExcel()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED("csExcell")
                USE IN csExcell
            ENDIF

            IF THIS.this_nTipos = 1
                *-- Analitico: linha por produto/conta com IIF para suprimir valores nas linhas de conta
                SELECT IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CPros), ;
                           SPACE(14)) AS Codigo, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.DPros), ;
                           SPACE(40)) AS Descricao, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Reffs), ;
                           SPACE(15)) AS Referencia, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CGrus), ;
                           SPACE(3)) AS Grp, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Linhas), ;
                           SPACE(10)) AS Linha, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.IFors), ;
                           SPACE(10)) AS Fornecedor, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Margems, 0) AS Markup, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Entradas, 0) AS Entradas, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Saidas, 0) AS Saidas, ;
                       IIF(crImpressao.Ordem = "0000000001", ;
                           crImpressao.Entradas - crImpressao.Saidas, 0) AS Saldo, ;
                       ALLTRIM(crImpressao.Grupos) AS Grupos, ;
                       ALLTRIM(crImpressao.Estos) AS Contas, ;
                       crImpressao.Estoques AS Qtde, ;
                       IIF(ALLTRIM(crImpressao.Estos) = "Total :   ", crImpressao.Diferencas, ;
                           0) AS Diferencas ;
                  FROM crImpressao ;
                  INTO CURSOR csExcell READWRITE
            ELSE
                *-- Sintetico: apenas linha header por produto
                SELECT ALLTRIM(crImpressao.CPros) AS Codigo, ;
                       ALLTRIM(crImpressao.DPros) AS Descricao, ;
                       ALLTRIM(crImpressao.Reffs) AS Referencia, ;
                       ALLTRIM(crImpressao.CGrus) AS Grp, ;
                       ALLTRIM(crImpressao.Linhas) AS Linha, ;
                       ALLTRIM(crImpressao.IFors) AS Fornecedor, ;
                       crImpressao.Margems AS Markup, ;
                       crImpressao.Entradas AS Entradas, ;
                       crImpressao.Saidas AS Saidas, ;
                       crImpressao.Entradas - crImpressao.Saidas AS Saldo, ;
                       crImpressao.Estoques AS Qtde, ;
                       crImpressao.Diferencas AS Diferencas ;
                  FROM crImpressao ;
                 WHERE crImpressao.Estos = PADR("Total :   ", 30) ;
                  INTO CURSOR csExcell READWRITE
            ENDIF

            SELECT csExcell
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao montar cursor Excel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        LOCAL loc_cCursorSel1, loc_cCursorSel2

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                *-- Com imagem: monta Selecao intermediaria
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                loc_cFRX = gc_4c_CaminhoReports + "SigReAto"
                SELECT crImpressao
                GO TOP
            ENDIF

            REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                loc_cFRX = gc_4c_CaminhoReports + "SigReAto"
                SELECT crImpressao
                GO TOP
            ENDIF

            REPORT FORM (loc_cFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSelecaoComImagem - Prepara cursor Selecao para SigReAtu.frx
    * Equivale ao bloco "If (optImagem.Value=1)" dos eventos impressao/visualizacao
    * do legado. Usa crImpressao (deve estar populado por PrepararDados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSelecaoComImagem()
        LOCAL loc_oErro
        TRY
            IF USED("Selecao1")
                USE IN Selecao1
            ENDIF
            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            IF USED("Selecao")
                USE IN Selecao
            ENDIF

            SELECT CPros, DPros, Reffs, CGrus, Linhas, IFors, Ordem, Estos, ;
                   Imagem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems ;
              FROM crImpressao ;
             WHERE Ordem = "0000000001" ;
              INTO CURSOR Selecao1

            SELECT CPros, SUM(Estoques) AS Estoques ;
              FROM crImpressao ;
             WHERE ALLTRIM(Estos) = "Total :   " ;
             GROUP BY CPros ;
              INTO CURSOR Selecao2

            SELECT a.*, b.Estoques ;
              FROM Selecao1 a, Selecao2 b ;
             WHERE a.CPros = b.CPros ;
             ORDER BY a.CPros ;
              INTO CURSOR Selecao READWRITE

            SELECT Selecao
            GO TOP
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em MontarSelecaoComImagem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + "|" + ;
               ALLTRIM(THIS.this_cGrupo) + "|" + ALLTRIM(THIS.this_cCPros) + "|" + ;
               ALLTRIM(THIS.this_cLin) + "|" + ALLTRIM(THIS.this_cFornecedor) + "|" + ;
               STR(THIS.this_nTipos, 1) + "|" + STR(THIS.this_nDiferenca, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta cursor para planilha Excel (XL5)
    *   Usa PUTFILE para escolha interativa do arquivo destino.
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_cArquivo, loc_lSafetyEra
        loc_lResultado = .F.
        TRY
            IF THIS.MontarCursorExcel()
                loc_cArquivo = PUTFILE("Exportar para Excel", "AnEstTpOpe.xls", "xls")
                IF !EMPTY(loc_cArquivo)
                    IF LOWER(RIGHT(loc_cArquivo, 4)) != ".xls"
                        loc_cArquivo = loc_cArquivo + ".xls"
                    ENDIF
                    SELECT csExcell
                    loc_lSafetyEra = (SET("SAFETY") = "ON")
                    SET SAFETY OFF
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF loc_lSafetyEra
                        SET SAFETY ON
                    ENDIF
                    THIS.RegistrarAuditoria("EXCEL")
                    MsgInfo("Arquivo exportado com sucesso!", ;
                            "Informa" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao exportar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("csExcell")
            USE IN csExcell
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE

