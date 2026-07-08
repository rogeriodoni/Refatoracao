# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (13)
- [LAYOUT-POSITION] Controle 'lbl_empresa' (parent: SIGREEGP): Top original=185 vs migrado 'lbl_4c_Lbl_empresa' Top=100 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupo' (parent: SIGREEGP): Top original=264 vs migrado 'lbl_4c_Lbl_grupo' Top=179 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_data' (parent: SIGREEGP): Top original=341 vs migrado 'lbl_4c_Lbl_data' Top=256 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_dt_cotacao' (parent: SIGREEGP): Top original=341 vs migrado 'lbl_4c_Lbl_dt_cotacao' Top=256 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGREEGP): Top original=368 vs migrado 'lbl_4c_Lbl_moeda' Top=283 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_dados_cotacao' (parent: SIGREEGP): Top original=467 vs migrado 'lbl_4c_Lbl_dados_cotacao' Top=382 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_dados_cotacao' (parent: SIGREEGP): Top original=463 vs migrado 'obj_4c_Opt_dados_cotacao' Top=378 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_fator' (parent: SIGREEGP): Top original=416 vs migrado 'obj_4c_Opc_fator' Top=331 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CmbOrdem' (parent: SIGREEGP): Top original=390 vs migrado 'cbo_4c_CmbOrdem' Top=305 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_Venda' (parent: SIGREEGP): Top original=415 vs migrado 'obj_4c_Opc_Venda' Top=330 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_Custo' (parent: SIGREEGP): Top original=439 vs migrado 'obj_4c_Opc_Custo' Top=354 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_Peso' (parent: SIGREEGP): Top original=440 vs migrado 'obj_4c_Opc_Peso' Top=355 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptUnis' (parent: SIGREEGP): Top original=462 vs migrado 'obj_4c_OptUnis' Top=377 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreegp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1948 linhas total):

*-- Linhas 59 a 67:
59:         loc_lSucesso   = .F.
60:         loc_lContinuar = .T.
61:         TRY
62:             THIS.Caption = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
63:                 CHR(227) + "o de Estoque por Grupo de Produto"
64: 
65:             IF TYPE("gc_4c_CaminhoIcones") = "U"
66:                 gc_4c_CaminhoIcones = ""
67:             ENDIF

*-- Linhas 79 a 88:
79:                 THIS.ConfigurarBotoes()
80:                 THIS.ConfigurarPageFrame()
81: 
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
84: 
85:                 THIS.ConfigurarPaginaLista()
86:                 THIS.ConfigurarPaginaDados()
87:                 THIS.LimparCampos()
88: 

*-- Linhas 105 a 143:
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
117: 
118:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
119:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
120:             .Top       = 17
121:             .Left      = 12
122:             .AutoSize  = .T.
123:             .Caption   = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
124:                 CHR(227) + "o de Estoque por Grupo de Produto"
125:             .FontName  = "Tahoma"
126:             .FontSize  = 14
127:             .FontBold  = .T.
128:             .ForeColor = RGB(0, 0, 0)
129:             .BackStyle = 0
130:             .Visible   = .T.
131:         ENDWITH
132: 
133:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
134:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
135:             .Top       = 20
136:             .Left      = 10
137:             .AutoSize  = .T.
138:             .Caption   = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
139:                 CHR(227) + "o de Estoque por Grupo de Produto"
140:             .FontName  = "Tahoma"
141:             .FontSize  = 14
142:             .FontBold  = .T.
143:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 153 a 179:
153:     PROTECTED PROCEDURE ConfigurarBotoes()
154:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
155:         WITH THIS.cmg_4c_Botoes
156:             .Top           = 0
157:             .Left          = 529
158:             .Width         = 273
159:             .Height        = 80
160:             .ButtonCount   = 4
161:             .BackStyle     = 0
162:             .BorderStyle   = 0
163:             .BorderColor   = RGB(136, 189, 188)
164:             .SpecialEffect = 1
165:             .Themes        = .F.
166:             .Visible       = .T.
167:         ENDWITH
168: 
169:         WITH THIS.cmg_4c_Botoes.Buttons(1)
170:             .Top             = 5
171:             .Left            = 5
172:             .Width           = 65
173:             .Height          = 70
174:             .Caption         = "Visualizar"
175:             .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
176:             .PicturePosition = 13
177:             .FontName        = "Tahoma"
178:             .FontBold        = .T.
179:             .FontItalic      = .T.

*-- Linhas 186 a 198:
186:         ENDWITH
187: 
188:         WITH THIS.cmg_4c_Botoes.Buttons(2)
189:             .Top             = 5
190:             .Left            = 71
191:             .Width           = 65
192:             .Height          = 70
193:             .Caption         = "Imprimir"
194:             .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
195:             .PicturePosition = 13
196:             .FontName        = "Tahoma"
197:             .FontBold        = .T.
198:             .FontItalic      = .T.

*-- Linhas 205 a 217:
205:         ENDWITH
206: 
207:         WITH THIS.cmg_4c_Botoes.Buttons(3)
208:             .Top             = 5
209:             .Left            = 137
210:             .Width           = 65
211:             .Height          = 70
212:             .Caption         = "Excel"
213:             .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
214:             .PicturePosition = 13
215:             .FontName        = "Tahoma"
216:             .FontBold        = .T.
217:             .FontItalic      = .T.

*-- Linhas 224 a 236:
224:         ENDWITH
225: 
226:         WITH THIS.cmg_4c_Botoes.Buttons(4)
227:             .Top             = 5
228:             .Left            = 203
229:             .Width           = 65
230:             .Height          = 70
231:             .Caption         = "Encerrar"
232:             .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
233:             .PicturePosition = 13
234:             .FontName        = "Tahoma"
235:             .FontBold        = .T.
236:             .FontItalic      = .T.

*-- Linhas 260 a 281:
260: 
261:         loc_oPgf.PageCount = 2
262: 
263:         loc_oPgf.Top    = 85
264:         loc_oPgf.Left   = -1
265:         loc_oPgf.Width  = THIS.Width + 2
266:         loc_oPgf.Height = THIS.Height - 85
267:         loc_oPgf.Tabs   = .F.
268: 
269:         loc_oPgf.Page1.Caption   = "Filtros"
270:         loc_oPgf.Page1.FontName  = "Tahoma"
271:         loc_oPgf.Page1.FontSize  = 8
272:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
273:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
274:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
275: 
276:         loc_oPgf.Page2.Caption   = "Dados"
277:         loc_oPgf.Page2.FontName  = "Tahoma"
278:         loc_oPgf.Page2.FontSize  = 8
279:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
280:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
281:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

*-- Linhas 343 a 368:
343:         LOCAL loc_oPagina
344:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
345: 
346:         *-- EMPRESA (lbl_empresa.top=185->100, get_cd_empresa.top=180->95)
347:         loc_oPagina.AddObject("lbl_4c_Lbl_empresa", "Label")
348:         WITH loc_oPagina.lbl_4c_Lbl_empresa
349:             .Top       = 100
350:             .Left      = 237
351:             .AutoSize  = .T.
352:             .Caption   = "Empresa :"
353:             .FontName  = "Tahoma"
354:             .FontSize  = 8
355:             .ForeColor = RGB(90, 90, 90)
356:             .BackStyle = 0
357:             .Visible   = .T.
358:         ENDWITH
359: 
360:         loc_oPagina.AddObject("txt_4c__cd_empresa", "TextBox")
361:         WITH loc_oPagina.txt_4c__cd_empresa
362:             .Top       = 95
363:             .Left      = 290
364:             .Width     = 31
365:             .Height    = 23
366:             .MaxLength = 3
367:             .Value     = ""
368:             .FontName  = "Courier New"

*-- Linhas 374 a 412:
374: 
375:         loc_oPagina.AddObject("txt_4c__ds_empresa", "TextBox")
376:         WITH loc_oPagina.txt_4c__ds_empresa
377:             .Top       = 95
378:             .Left      = 372
379:             .Width     = 290
380:             .Height    = 23
381:             .MaxLength = 40
382:             .Value     = ""
383:             .FontName  = "Courier New"
384:             .FontSize  = 9
385:             .BackColor = RGB(255, 255, 255)
386:             .ForeColor = RGB(90, 90, 90)
387:             .Visible   = .T.
388:         ENDWITH
389: 
390:         *-- GRUPO DE ESTOQUE (Say2.top=210->125, get_Cd_GrEstoque.top=205->120)
391:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
392:         WITH loc_oPagina.lbl_4c_Label2
393:             .Top       = 125
394:             .Left      = 192
395:             .AutoSize  = .T.
396:             .Caption   = "Grupo de Estoque :"
397:             .FontName  = "Tahoma"
398:             .FontSize  = 8
399:             .ForeColor = RGB(90, 90, 90)
400:             .BackStyle = 0
401:             .Visible   = .T.
402:         ENDWITH
403: 
404:         loc_oPagina.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
405:         WITH loc_oPagina.txt_4c__Cd_GrEstoque
406:             .Top       = 120
407:             .Left      = 290
408:             .Width     = 80
409:             .Height    = 25
410:             .MaxLength = 10
411:             .Value     = ""
412:             .FontName  = "Courier New"

*-- Linhas 418 a 456:
418: 
419:         loc_oPagina.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
420:         WITH loc_oPagina.txt_4c__Ds_GrEstoque
421:             .Top       = 120
422:             .Left      = 372
423:             .Width     = 150
424:             .Height    = 25
425:             .MaxLength = 20
426:             .Value     = ""
427:             .FontName  = "Courier New"
428:             .FontSize  = 9
429:             .BackColor = RGB(255, 255, 255)
430:             .ForeColor = RGB(90, 90, 90)
431:             .Visible   = .T.
432:         ENDWITH
433: 
434:         *-- CONTA DE ESTOQUE (Say3.top=237->152, get_cd_estoque.top=232->147)
435:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
436:         WITH loc_oPagina.lbl_4c_Label3
437:             .Top       = 152
438:             .Left      = 239
439:             .AutoSize  = .T.
440:             .Caption   = "Estoque :"
441:             .FontName  = "Tahoma"
442:             .FontSize  = 8
443:             .ForeColor = RGB(90, 90, 90)
444:             .BackStyle = 0
445:             .Visible   = .T.
446:         ENDWITH
447: 
448:         loc_oPagina.AddObject("txt_4c__cd_estoque", "TextBox")
449:         WITH loc_oPagina.txt_4c__cd_estoque
450:             .Top       = 147
451:             .Left      = 290
452:             .Width     = 80
453:             .Height    = 25
454:             .MaxLength = 10
455:             .Value     = ""
456:             .FontName  = "Courier New"

*-- Linhas 462 a 500:
462: 
463:         loc_oPagina.AddObject("txt_4c__ds_estoque", "TextBox")
464:         WITH loc_oPagina.txt_4c__ds_estoque
465:             .Top       = 147
466:             .Left      = 372
467:             .Width     = 290
468:             .Height    = 25
469:             .MaxLength = 40
470:             .Value     = ""
471:             .FontName  = "Courier New"
472:             .FontSize  = 9
473:             .BackColor = RGB(255, 255, 255)
474:             .ForeColor = RGB(90, 90, 90)
475:             .Visible   = .T.
476:         ENDWITH
477: 
478:         *-- GRUPO DE PRODUTO (lbl_grupo.top=264->179, get_cd_grupo.top=259->174)
479:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
480:         WITH loc_oPagina.lbl_4c_Lbl_grupo
481:             .Top       = 179
482:             .Left      = 193
483:             .AutoSize  = .T.
484:             .Caption   = "Grupo de Produto :"
485:             .FontName  = "Tahoma"
486:             .FontSize  = 8
487:             .ForeColor = RGB(90, 90, 90)
488:             .BackStyle = 0
489:             .Visible   = .T.
490:         ENDWITH
491: 
492:         loc_oPagina.AddObject("txt_4c__cd_grupo", "TextBox")
493:         WITH loc_oPagina.txt_4c__cd_grupo
494:             .Top       = 174
495:             .Left      = 290
496:             .Width     = 31
497:             .Height    = 25
498:             .MaxLength = 3
499:             .Value     = ""
500:             .FontName  = "Courier New"

*-- Linhas 506 a 545:
506: 
507:         loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
508:         WITH loc_oPagina.txt_4c__ds_grupo
509:             .Top       = 174
510:             .Left      = 372
511:             .Width     = 290
512:             .Height    = 25
513:             .MaxLength = 20
514:             .Value     = ""
515:             .FontName  = "Courier New"
516:             .FontSize  = 9
517:             .BackColor = RGB(255, 255, 255)
518:             .ForeColor = RGB(90, 90, 90)
519:             .Visible   = .T.
520:         ENDWITH
521: 
522:         *-- LINHA (Say16.top=289->204, GetLin.top=286->201)
523:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
524:         WITH loc_oPagina.lbl_4c_Label16
525:             .Top       = 204
526:             .Left      = 253
527:             .Width     = 34
528:             .Height    = 15
529:             .Caption   = "Linha :"
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .ForeColor = RGB(90, 90, 90)
533:             .BackStyle = 0
534:             .Visible   = .T.
535:         ENDWITH
536: 
537:         loc_oPagina.AddObject("txt_4c_Lin", "TextBox")
538:         WITH loc_oPagina.txt_4c_Lin
539:             .Top       = 201
540:             .Left      = 290
541:             .Width     = 80
542:             .Height    = 23
543:             .MaxLength = 10
544:             .Value     = ""
545:             .FontName  = "Courier New"

*-- Linhas 551 a 590:
551: 
552:         loc_oPagina.AddObject("txt_4c_DLin", "TextBox")
553:         WITH loc_oPagina.txt_4c_DLin
554:             .Top       = 201
555:             .Left      = 372
556:             .Width     = 255
557:             .Height    = 23
558:             .MaxLength = 40
559:             .Value     = ""
560:             .FontName  = "Courier New"
561:             .FontSize  = 9
562:             .BackColor = RGB(255, 255, 255)
563:             .ForeColor = RGB(90, 90, 90)
564:             .Visible   = .T.
565:         ENDWITH
566: 
567:         *-- GRUPO VENDA (Say17.top=314->229, GetCol.top=311->226)
568:         loc_oPagina.AddObject("lbl_4c_Label17", "Label")
569:         WITH loc_oPagina.lbl_4c_Label17
570:             .Top       = 229
571:             .Left      = 213
572:             .Width     = 74
573:             .Height    = 15
574:             .Caption   = "Grupo  Venda :"
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .ForeColor = RGB(90, 90, 90)
578:             .BackStyle = 0
579:             .Visible   = .T.
580:         ENDWITH
581: 
582:         loc_oPagina.AddObject("txt_4c_Col", "TextBox")
583:         WITH loc_oPagina.txt_4c_Col
584:             .Top       = 226
585:             .Left      = 290
586:             .Width     = 80
587:             .Height    = 23
588:             .MaxLength = 10
589:             .Value     = ""
590:             .FontName  = "Courier New"

*-- Linhas 596 a 690:
596: 
597:         loc_oPagina.AddObject("txt_4c_DCol", "TextBox")
598:         WITH loc_oPagina.txt_4c_DCol
599:             .Top       = 226
600:             .Left      = 372
601:             .Width     = 255
602:             .Height    = 23
603:             .MaxLength = 40
604:             .Value     = ""
605:             .FontName  = "Courier New"
606:             .FontSize  = 9
607:             .BackColor = RGB(255, 255, 255)
608:             .ForeColor = RGB(90, 90, 90)
609:             .Visible   = .T.
610:         ENDWITH
611: 
612:         *-- DATA e DT. COTACAO (lbl_data.top=341->256, get_data.top=336->251)
613:         loc_oPagina.AddObject("lbl_4c_Lbl_data", "Label")
614:         WITH loc_oPagina.lbl_4c_Lbl_data
615:             .Top       = 256
616:             .Left      = 255
617:             .AutoSize  = .T.
618:             .Caption   = "Data :"
619:             .FontName  = "Tahoma"
620:             .FontSize  = 8
621:             .ForeColor = RGB(90, 90, 90)
622:             .BackStyle = 0
623:             .Visible   = .T.
624:         ENDWITH
625: 
626:         loc_oPagina.AddObject("txt_4c__data", "TextBox")
627:         WITH loc_oPagina.txt_4c__data
628:             .Top       = 251
629:             .Left      = 290
630:             .Width     = 80
631:             .Height    = 25
632:             .Value     = {}
633:             .FontName  = "Courier New"
634:             .FontSize  = 9
635:             .BackColor = RGB(255, 255, 255)
636:             .ForeColor = RGB(0, 0, 0)
637:             .Visible   = .T.
638:         ENDWITH
639: 
640:         loc_oPagina.AddObject("lbl_4c_Lbl_dt_cotacao", "Label")
641:         WITH loc_oPagina.lbl_4c_Lbl_dt_cotacao
642:             .Top       = 256
643:             .Left      = 384
644:             .AutoSize  = .T.
645:             .Caption   = "Dt. Cota" + CHR(231) + CHR(227) + "o :"
646:             .FontName  = "Tahoma"
647:             .FontSize  = 8
648:             .ForeColor = RGB(90, 90, 90)
649:             .BackStyle = 0
650:             .Visible   = .T.
651:         ENDWITH
652: 
653:         loc_oPagina.AddObject("txt_4c__dt_cotacao", "TextBox")
654:         WITH loc_oPagina.txt_4c__dt_cotacao
655:             .Top       = 251
656:             .Left      = 455
657:             .Width     = 80
658:             .Height    = 25
659:             .Value     = {}
660:             .ReadOnly  = .T.
661:             .FontName  = "Courier New"
662:             .FontSize  = 9
663:             .BackColor = RGB(220, 220, 220)
664:             .ForeColor = RGB(0, 0, 0)
665:             .Visible   = .T.
666:         ENDWITH
667: 
668:         *-- MOEDA (lbl_moeda.top=368->283, get_moeda.top=363->278)
669:         loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
670:         WITH loc_oPagina.lbl_4c_Lbl_moeda
671:             .Top       = 283
672:             .Left      = 246
673:             .AutoSize  = .T.
674:             .Caption   = "Moeda :"
675:             .FontName  = "Tahoma"
676:             .FontSize  = 8
677:             .ForeColor = RGB(90, 90, 90)
678:             .BackStyle = 0
679:             .Visible   = .T.
680:         ENDWITH
681: 
682:         loc_oPagina.AddObject("txt_4c__moeda", "TextBox")
683:         WITH loc_oPagina.txt_4c__moeda
684:             .Top       = 278
685:             .Left      = 290
686:             .Width     = 31
687:             .Height    = 25
688:             .MaxLength = 3
689:             .Value     = ""
690:             .FontName  = "Courier New"

*-- Linhas 696 a 734:
696: 
697:         loc_oPagina.AddObject("txt_4c__moeda_desc", "TextBox")
698:         WITH loc_oPagina.txt_4c__moeda_desc
699:             .Top       = 278
700:             .Left      = 372
701:             .Width     = 105
702:             .Height    = 25
703:             .MaxLength = 15
704:             .Value     = ""
705:             .FontName  = "Courier New"
706:             .FontSize  = 9
707:             .BackColor = RGB(255, 255, 255)
708:             .ForeColor = RGB(90, 90, 90)
709:             .Visible   = .T.
710:         ENDWITH
711: 
712:         *-- ORDENACAO (Say4.top=395->310, CmbOrdem.top=390->305)
713:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
714:         WITH loc_oPagina.lbl_4c_Label4
715:             .Top       = 310
716:             .Left      = 225
717:             .AutoSize  = .T.
718:             .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
719:             .FontName  = "Tahoma"
720:             .FontSize  = 8
721:             .ForeColor = RGB(90, 90, 90)
722:             .BackStyle = 0
723:             .Visible   = .T.
724:         ENDWITH
725: 
726:         loc_oPagina.AddObject("cbo_4c_CmbOrdem", "ComboBox")
727:         WITH loc_oPagina.cbo_4c_CmbOrdem
728:             .Top       = 305
729:             .Left      = 290
730:             .Width     = 152
731:             .Height    = 24
732:             .Style     = 2
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8

*-- Linhas 740 a 1046:
740:         loc_oPagina.cbo_4c_CmbOrdem.AddItem("por Estoque")
741:         loc_oPagina.cbo_4c_CmbOrdem.ListIndex = 4
742: 
743:         *-- VALOR DE VENDA (Say5.top=420->335, Opc_Venda.top=415->330)
744:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
745:         WITH loc_oPagina.lbl_4c_Label5
746:             .Top       = 335
747:             .Left      = 206
748:             .AutoSize  = .T.
749:             .Caption   = "Valor de Venda :"
750:             .FontName  = "Tahoma"
751:             .FontSize  = 8
752:             .ForeColor = RGB(90, 90, 90)
753:             .BackStyle = 0
754:             .Visible   = .T.
755:         ENDWITH
756: 
757:         loc_oPagina.AddObject("obj_4c_Opc_Venda", "OptionGroup")
758:         WITH loc_oPagina.obj_4c_Opc_Venda
759:             .Top           = 330
760:             .Left          = 285
761:             .Width         = 97
762:             .Height        = 23
763:             .ButtonCount   = 2
764:             .BackStyle     = 0
765:             .BorderStyle   = 0
766:             .Value         = 1
767:             .SpecialEffect = 0
768:             .Themes        = .F.
769:             .Visible       = .T.
770:         ENDWITH
771:         WITH loc_oPagina.obj_4c_Opc_Venda.Buttons(1)
772:             .Caption   = "Sim"
773:             .Left      = 5
774:             .Top       = 5
775:             .Width     = 34
776:             .Height    = 15
777:             .AutoSize  = .T.
778:             .BackStyle = 0
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .ForeColor = RGB(90, 90, 90)
782:         ENDWITH
783:         WITH loc_oPagina.obj_4c_Opc_Venda.Buttons(2)
784:             .Caption   = "N" + CHR(227) + "o"
785:             .Left      = 51
786:             .Top       = 5
787:             .AutoSize  = .T.
788:             .BackStyle = 0
789:             .FontName  = "Tahoma"
790:             .FontSize  = 8
791:             .ForeColor = RGB(90, 90, 90)
792:         ENDWITH
793: 
794:         *-- FATOR DE VENDA (Say1.top=421->336, Opc_fator.top=416->331)
795:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
796:         WITH loc_oPagina.lbl_4c_Label1
797:             .Top       = 336
798:             .Left      = 454
799:             .AutoSize  = .T.
800:             .Caption   = "Fator de Venda :"
801:             .FontName  = "Tahoma"
802:             .FontSize  = 8
803:             .ForeColor = RGB(90, 90, 90)
804:             .BackStyle = 0
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         loc_oPagina.AddObject("obj_4c_Opc_fator", "OptionGroup")
809:         WITH loc_oPagina.obj_4c_Opc_fator
810:             .Top           = 331
811:             .Left          = 541
812:             .Width         = 97
813:             .Height        = 23
814:             .ButtonCount   = 2
815:             .BackStyle     = 0
816:             .BorderStyle   = 0
817:             .Value         = 2
818:             .SpecialEffect = 0
819:             .Themes        = .F.
820:             .Visible       = .T.
821:         ENDWITH
822:         WITH loc_oPagina.obj_4c_Opc_fator.Buttons(1)
823:             .Caption   = "Sim"
824:             .Left      = 5
825:             .Top       = 5
826:             .Width     = 34
827:             .Height    = 15
828:             .AutoSize  = .T.
829:             .BackStyle = 0
830:             .FontName  = "Tahoma"
831:             .FontSize  = 8
832:             .ForeColor = RGB(90, 90, 90)
833:         ENDWITH
834:         WITH loc_oPagina.obj_4c_Opc_fator.Buttons(2)
835:             .Caption   = "N" + CHR(227) + "o"
836:             .Left      = 51
837:             .Top       = 5
838:             .AutoSize  = .T.
839:             .BackStyle = 0
840:             .FontName  = "Tahoma"
841:             .FontSize  = 8
842:             .ForeColor = RGB(90, 90, 90)
843:         ENDWITH
844: 
845:         *-- VALOR DE CUSTO (Say6.top=444->359, Opc_Custo.top=439->354)
846:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
847:         WITH loc_oPagina.lbl_4c_Label6
848:             .Top       = 359
849:             .Left      = 208
850:             .AutoSize  = .T.
851:             .Caption   = "Valor de Custo :"
852:             .FontName  = "Tahoma"
853:             .FontSize  = 8
854:             .ForeColor = RGB(90, 90, 90)
855:             .BackStyle = 0
856:             .Visible   = .T.
857:         ENDWITH
858: 
859:         loc_oPagina.AddObject("obj_4c_Opc_Custo", "OptionGroup")
860:         WITH loc_oPagina.obj_4c_Opc_Custo
861:             .Top           = 354
862:             .Left          = 285
863:             .Width         = 97
864:             .Height        = 23
865:             .ButtonCount   = 2
866:             .BackStyle     = 0
867:             .BorderStyle   = 0
868:             .Value         = 1
869:             .SpecialEffect = 0
870:             .Themes        = .F.
871:             .Visible       = .T.
872:         ENDWITH
873:         WITH loc_oPagina.obj_4c_Opc_Custo.Buttons(1)
874:             .Caption   = "Sim"
875:             .Left      = 5
876:             .Top       = 5
877:             .Width     = 34
878:             .Height    = 15
879:             .AutoSize  = .T.
880:             .BackStyle = 0
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8
883:             .ForeColor = RGB(90, 90, 90)
884:         ENDWITH
885:         WITH loc_oPagina.obj_4c_Opc_Custo.Buttons(2)
886:             .Caption   = "N" + CHR(227) + "o"
887:             .Left      = 51
888:             .Top       = 5
889:             .AutoSize  = .T.
890:             .BackStyle = 0
891:             .FontName  = "Tahoma"
892:             .FontSize  = 8
893:             .ForeColor = RGB(90, 90, 90)
894:         ENDWITH
895: 
896:         *-- PESO MEDIO (Say7.top=446->361, Opc_Peso.top=440->355)
897:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
898:         WITH loc_oPagina.lbl_4c_Label7
899:             .Top       = 361
900:             .Left      = 474
901:             .AutoSize  = .T.
902:             .Caption   = "Peso M" + CHR(233) + "dio :"
903:             .FontName  = "Tahoma"
904:             .FontSize  = 8
905:             .ForeColor = RGB(90, 90, 90)
906:             .BackStyle = 0
907:             .Visible   = .T.
908:         ENDWITH
909: 
910:         loc_oPagina.AddObject("obj_4c_Opc_Peso", "OptionGroup")
911:         WITH loc_oPagina.obj_4c_Opc_Peso
912:             .Top           = 355
913:             .Left          = 541
914:             .Width         = 97
915:             .Height        = 23
916:             .ButtonCount   = 2
917:             .BackStyle     = 0
918:             .BorderStyle   = 0
919:             .Value         = 2
920:             .SpecialEffect = 0
921:             .Themes        = .F.
922:             .Visible       = .T.
923:         ENDWITH
924:         WITH loc_oPagina.obj_4c_Opc_Peso.Buttons(1)
925:             .Caption   = "Sim"
926:             .Left      = 5
927:             .Top       = 5
928:             .Width     = 34
929:             .Height    = 15
930:             .AutoSize  = .T.
931:             .BackStyle = 0
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8
934:             .ForeColor = RGB(90, 90, 90)
935:         ENDWITH
936:         WITH loc_oPagina.obj_4c_Opc_Peso.Buttons(2)
937:             .Caption   = "N" + CHR(227) + "o"
938:             .Left      = 51
939:             .Top       = 5
940:             .AutoSize  = .T.
941:             .BackStyle = 0
942:             .FontName  = "Tahoma"
943:             .FontSize  = 8
944:             .ForeColor = RGB(90, 90, 90)
945:         ENDWITH
946: 
947:         *-- QUEBRA UNIDADE (Say8.top=468->383, OptUnis.top=462->377)
948:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
949:         WITH loc_oPagina.lbl_4c_Label8
950:             .Top       = 383
951:             .Left      = 450
952:             .AutoSize  = .T.
953:             .Caption   = "Quebra Unidade :"
954:             .FontName  = "Tahoma"
955:             .FontSize  = 8
956:             .ForeColor = RGB(90, 90, 90)
957:             .BackStyle = 0
958:             .Visible   = .T.
959:         ENDWITH
960: 
961:         loc_oPagina.AddObject("obj_4c_OptUnis", "OptionGroup")
962:         WITH loc_oPagina.obj_4c_OptUnis
963:             .Top           = 377
964:             .Left          = 541
965:             .Width         = 97
966:             .Height        = 23
967:             .ButtonCount   = 2
968:             .BackStyle     = 0
969:             .BorderStyle   = 0
970:             .Value         = 2
971:             .SpecialEffect = 0
972:             .Themes        = .F.
973:             .Visible       = .T.
974:         ENDWITH
975:         WITH loc_oPagina.obj_4c_OptUnis.Buttons(1)
976:             .Caption   = "Sim"
977:             .Left      = 5
978:             .Top       = 5
979:             .Width     = 34
980:             .Height    = 15
981:             .AutoSize  = .T.
982:             .BackStyle = 0
983:             .FontName  = "Tahoma"
984:             .FontSize  = 8
985:             .ForeColor = RGB(90, 90, 90)
986:         ENDWITH
987:         WITH loc_oPagina.obj_4c_OptUnis.Buttons(2)
988:             .Caption   = "N" + CHR(227) + "o"
989:             .Left      = 51
990:             .Top       = 5
991:             .AutoSize  = .T.
992:             .BackStyle = 0
993:             .FontName  = "Tahoma"
994:             .FontSize  = 8
995:             .ForeColor = RGB(90, 90, 90)
996:         ENDWITH
997: 
998:         *-- DADOS DA COTACAO (lbl_dados_cotacao.top=467->382, opt_dados_cotacao.top=463->378)
999:         loc_oPagina.AddObject("lbl_4c_Lbl_dados_cotacao", "Label")
1000:         WITH loc_oPagina.lbl_4c_Lbl_dados_cotacao
1001:             .Top       = 382
1002:             .Left      = 190
1003:             .AutoSize  = .T.
1004:             .Caption   = "Dados da Cota" + CHR(231) + CHR(227) + "o :"
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:             .ForeColor = RGB(90, 90, 90)
1008:             .BackStyle = 0
1009:             .Visible   = .T.
1010:         ENDWITH
1011: 
1012:         loc_oPagina.AddObject("obj_4c_Opt_dados_cotacao", "OptionGroup")
1013:         WITH loc_oPagina.obj_4c_Opt_dados_cotacao
1014:             .Top           = 378
1015:             .Left          = 285
1016:             .Width         = 97
1017:             .Height        = 23
1018:             .ButtonCount   = 2
1019:             .BackStyle     = 0
1020:             .BorderStyle   = 0
1021:             .Value         = 1
1022:             .SpecialEffect = 0
1023:             .Themes        = .F.
1024:             .Visible       = .T.
1025:         ENDWITH
1026:         WITH loc_oPagina.obj_4c_Opt_dados_cotacao.Buttons(1)
1027:             .Caption   = "Sim"
1028:             .Left      = 5
1029:             .Top       = 5
1030:             .Width     = 34
1031:             .Height    = 15
1032:             .AutoSize  = .T.
1033:             .BackStyle = 0
1034:             .FontName  = "Tahoma"
1035:             .FontSize  = 8
1036:             .ForeColor = RGB(90, 90, 90)
1037:         ENDWITH
1038:         WITH loc_oPagina.obj_4c_Opt_dados_cotacao.Buttons(2)
1039:             .Caption   = "N" + CHR(227) + "o"
1040:             .Left      = 52
1041:             .Top       = 5
1042:             .AutoSize  = .T.
1043:             .BackStyle = 0
1044:             .FontName  = "Tahoma"
1045:             .FontSize  = 8
1046:             .ForeColor = RGB(90, 90, 90)


### BO (C:\4c\projeto\app\classes\sigreegpBO.prg):
*==============================================================================
* SIGREEGPBO.PRG
* Business Object - Relatorio de Posicao de Estoque por Grupo de Produto
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigreegpBO AS RelatorioBase

    *-- Empresa
    this_cCdEmpresa       = ""
    this_cDsEmpresa       = ""

    *-- Grupo de Estoque
    this_cCdGrEstoque     = ""
    this_cDsGrEstoque     = ""

    *-- Estoque (Conta/Cliente)
    this_cCdEstoque       = ""
    this_cDsEstoque       = ""

    *-- Grupo de Produto
    this_cCdGrupo         = ""
    this_cDsGrupo         = ""

    *-- Data de posicao
    this_dData            = {}

    *-- Moeda
    this_cCdMoeda         = ""
    this_cDsMoeda         = ""
    this_dDtCotacao       = {}
    this_nOptDadosCotacao = 1

    *-- Linha de produto
    this_cCdLinha         = ""
    this_cDsLinha         = ""

    *-- Colecao / Grupo de Venda
    this_cCdColecao       = ""
    this_cDsColecao       = ""

    *-- Opcoes de exibicao (1=Sim, 2=Nao)
    this_nCmbOrdem        = 4
    this_nOpcVenda        = 1
    this_nOpcCusto        = 1
    this_nOpcPeso         = 2
    this_nOpcFator        = 2
    this_nOptUnis         = 2

    *-- Propriedades internas do relatorio
    this_cNomeRelatorio   = "SigReEg2"
    this_cCursorDados     = "cursor_4c_EgpRelatorio"
    this_cCursorCabecalho = "cursor_4c_EgpCabecalho"
    this_cTipo            = "ESTOQUE"

    *--------------------------------------------------------------------------
    * Init - Inicializa propriedades com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_dData            = DATE()
            THIS.this_dDtCotacao       = DATE()
            THIS.this_cCdEmpresa       = go_4c_Sistema.cCodEmpresa
            THIS.this_nCmbOrdem        = 4
            THIS.this_nOptDadosCotacao = 1
            THIS.this_nOpcVenda        = 1
            THIS.this_nOpcCusto        = 1
            THIS.this_nOpcPeso         = 2
            THIS.this_nOpcFator        = 2
            THIS.this_nOptUnis         = 2
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.LimparCursores()
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + THIS.this_cNomeRelatorio + ".frx"
                IF FILE(loc_cFrx)
                    REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                        "o encontrado: " + loc_cFrx, "Erro")
                ENDIF
                THIS.LimparCursores()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.LimparCursores()
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.LimparCursores()
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + THIS.this_cNomeRelatorio + ".frx"
                IF FILE(loc_cFrx)
                    REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                        "o encontrado: " + loc_cFrx, "Erro")
                ENDIF
                THIS.LimparCursores()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.LimparCursores()
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Hook que chama processamento real
    *--------------------------------------------------------------------------
    FUNCTION PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.ExecutarProcessamento()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarProcessamento - Logica principal do relatorio
    * Replica fielmente o procedure "processamento" do sistema legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarProcessamento()
        LOCAL lcEmpresa, lcNomeEmpresa, lcTitulo, lcSubTitulo, lcOrdenaCab
        LOCAL lcGrest, lcEstoque, lcGrupo, lcMoeda, lcDescMoeda
        LOCAL ldData, ldDtCotacao, lnDadosCotacao
        LOCAL lcCabecalho, lcOrdem, lcChave
        LOCAL lnValCust, lnValVend, lnPeso, lnFator, lnOrdem
        LOCAL lnValCot, lnValorProd, lnCustoProd, lnValFat
        LOCAL nTotQtds, nTotPeso, nTotCusto, nTotVenda
        LOCAL cDetalhe, cTotal, cAnt, cAnte, lnEspaco
        LOCAL lcLinha, lcGrupoVenda
        LOCAL lcEmpIni, lcEmpFim, lcGrEstIni, lcGrEstFim, lcEstIni, lcEstFim
        LOCAL loc_cSQL, loc_nResult, llPosAtu, llUnis
        LOCAL lcFatVens, lcCodCors, lcEstos, lcRclis, lcCodPro
        LOCAL lcWhere1, lcWhere1H

        *-- Ler propriedades do BO definidas pelo Form via FormParaRelatorio
        lcGrest        = ALLTRIM(THIS.this_cCdGrEstoque)
        lcEstoque      = ALLTRIM(THIS.this_cCdEstoque)
        lcGrupo        = ALLTRIM(THIS.this_cCdGrupo)
        ldData         = THIS.this_dData
        lcMoeda        = ALLTRIM(THIS.this_cCdMoeda)
        lcLinha        = ALLTRIM(THIS.this_cCdLinha)
        lcGrupoVenda   = ALLTRIM(THIS.this_cCdColecao)
        lcDescMoeda    = ALLTRIM(THIS.this_cDsMoeda)
        ldDtCotacao    = THIS.this_dDtCotacao
        lnDadosCotacao = THIS.this_nOptDadosCotacao
        lnValCust      = THIS.this_nOpcCusto
        lnValVend      = THIS.this_nOpcVenda
        lnPeso         = THIS.this_nOpcPeso
        lnFator        = THIS.this_nOpcFator
        lnOrdem        = THIS.this_nCmbOrdem
        lcEmpresa      = ALLTRIM(THIS.this_cCdEmpresa)
        llUnis         = (THIS.this_nOptUnis = 1)

        IF EMPTY(ldData)
            ldData = DATE()
        ENDIF

        *-- Posicao atual (hoje) ou historico?
        llPosAtu = (ldData = DATE())

        *-- Carregar nome da empresa via SQLEXEC
        lcNomeEmpresa = ""
        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(lcEmpresa)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EgpEmpresa")
        IF loc_nResult > 0
            SELECT cursor_4c_EgpEmpresa
            GO TOP
            IF !EOF()
                lcNomeEmpresa = ALLTRIM(cursor_4c_EgpEmpresa.razas)
            ENDIF
            USE IN cursor_4c_EgpEmpresa
        ENDIF
        THIS.this_cDsEmpresa = lcNomeEmpresa

        *-- Montar titulo e subtitulo do relatorio
        lcTitulo    = "Posi" + CHR(231) + CHR(227) + "o de Estoque p/ Grupo de Produto em " + DTOC(ldData)
        lcSubTitulo = IIF(EMPTY(lcMoeda), "", "Valores em " + lcDescMoeda)
        IF !EMPTY(lcGrest)
            lcSubTitulo = lcSubTitulo + " - Grupo de Estoque: " + ALLTRIM(lcGrest)
        ENDIF
        IF !EMPTY(lcEstoque)
            lcSubTitulo = lcSubTitulo + " - Estoque : " + ALLTRIM(lcEstoque)
        ENDIF
        IF !EMPTY(lcGrupo)
            lcSubTitulo = lcSubTitulo + " - Grupo de Produto: " + ALLTRIM(lcGrupo)
        ENDIF
        IF !EMPTY(lcLinha)
            lcSubTitulo = lcSubTitulo + " - Linha : " + ALLTRIM(lcLinha)
        ENDIF
        IF !EMPTY(lcGrupoVenda)
            lcSubTitulo = lcSubTitulo + " - Grupo de Venda : " + ALLTRIM(lcGrupoVenda)
        ENDIF

        *-- Descricao da ordenacao
        DO CASE
        CASE lnOrdem = 1
            lcOrdenaCab = "Ordenado por Grupo de Produto"
        CASE lnOrdem = 2
            lcOrdenaCab = "Ordenado por Linha"
        CASE lnOrdem = 3
            lcOrdenaCab = "Ordenado por Grupo de Venda"
        CASE lnOrdem = 4
            lcOrdenaCab = "Ordenado por Estoque"
        OTHERWISE
            lcOrdenaCab = ""
            lnOrdem     = 1
        ENDCASE

        *-- Montar cabecalho de colunas conforme opcoes selecionadas
        lcCabecalho = PADC("Grupo", 10, "_") + " "
        IF lnOrdem <> 4
            lcCabecalho = lcCabecalho + PADC("Conta", 10, "_") + " "
        ENDIF
        lcCabecalho = lcCabecalho + PADC("C" + CHR(243) + "digo", 10, "_") + " "
        lcCabecalho = lcCabecalho + PADC("Descri" + CHR(231) + CHR(227) + "o", ;
            IIF((lnPeso = 1 OR lnFator = 1) AND lnOrdem <> 4, 18, 30), "_") + " "
        IF lnFator = 1
            lcCabecalho = lcCabecalho + PADC("FV.", 3, "_") + " "
        ENDIF
        lcCabecalho = lcCabecalho + PADC("Qtde.", 10, "_") + " "
        IF lnPeso = 1
            lcCabecalho = lcCabecalho + PADC("Peso M" + CHR(233) + "dio", 10, "_") + " "
        ENDIF
        IF lnValCust = 1
            lcCabecalho = lcCabecalho + PADC("Vl.Custo", 17, "_") + " "
        ENDIF
        IF lnValVend = 1
            lcCabecalho = lcCabecalho + PADC("Vl.Venda", 17, "_")
        ENDIF

        *-- Criar cursores temporarios do relatorio
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), SubTitulo C(200), ;
            Cabecalho C(200), SubTitulo2 C(100))
        INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Cabecalho, SubTitulo2) ;
            VALUES (lcNomeEmpresa, lcTitulo, lcSubTitulo, lcCabecalho, lcOrdenaCab)

        IF USED("dbRelatorio")
            USE IN dbRelatorio
        ENDIF
        CREATE CURSOR dbRelatorio (Detalhe C(200))

        IF USED("dbUnis")
            USE IN dbUnis
        ENDIF
        CREATE CURSOR dbUnis (cUnis C(3), nValors N(15, 3))
        INDEX ON cUnis TAG cUnis
        SET ORDER TO cUnis

        IF USED("TempMoe")
            USE IN TempMoe
        ENDIF
        CREATE CURSOR TempMoe (cmoes C(3), cotacao N(14, 4))
        INDEX ON cmoes TAG cmoes

        IF USED("dbRelat")
            USE IN dbRelat
        ENDIF
        CREATE CURSOR dbRelat (codigo C(10), Descr C(30), qtds N(12, 3), ;
            vends N(15, 2), custs N(15, 2), fatvens C(3), pesom N(12, 3), ;
            grupos C(10), estos C(10), codCors C(4), sPesos N(12, 3), ;
            cUnis C(3), cUniPs C(3))
        IF !llUnis
            INDEX ON grupos + estos + codigo + codCors + fatvens TAG cgrus
        ELSE
            INDEX ON grupos + estos + cUnis + codigo + codCors + fatvens TAG cgrus
        ENDIF
        INDEX ON Descr + fatvens TAG descrs

        *-- Ranges para filtros BETWEEN
        lcEmpIni   = IIF(!EMPTY(lcEmpresa), lcEmpresa, SPACE(3))
        lcEmpFim   = IIF(!EMPTY(lcEmpresa), lcEmpresa, REPLICATE(CHR(254), 3))
        lcGrEstIni = IIF(!EMPTY(lcGrest),   lcGrest,   SPACE(10))
        lcGrEstFim = IIF(!EMPTY(lcGrest),   lcGrest,   REPLICATE(CHR(254), 10))
        lcEstIni   = IIF(!EMPTY(lcEstoque),  lcEstoque, SPACE(10))
        lcEstFim   = IIF(!EMPTY(lcEstoque),  lcEstoque, REPLICATE(CHR(254), 10))

        *-- Definir ordenacao e chave de agrupamento conforme lnOrdem
        DO CASE
        CASE lnOrdem = 1
            lcOrdem = "1,2,4,3,14"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + PADR(NVL(Tempo.cgrus,''),10) + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + PADR(NVL(Tempo.cgrus,''),10) + lcCodCors + lcFatVens"
            ENDIF
        CASE lnOrdem = 2
            lcOrdem = "1,2,12,3"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + NVL(Tempo.linhas,'') + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + NVL(Tempo.linhas,'') + lcCodCors + lcFatVens"
            ENDIF
        CASE lnOrdem = 3
            lcOrdem = "1,2,13,3"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + NVL(Tempo.colecoes,'') + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + NVL(Tempo.colecoes,'') + lcCodCors + lcFatVens"
            ENDIF
        CASE lnOrdem = 4
            lcOrdem = "1,2,3"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.estos + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + Tempo.estos + lcCodCors + lcFatVens"
            ENDIF
        OTHERWISE
            lnOrdem = 1
            lcOrdem = "1,2,4,3"
            lcChave = "PADR(NVL(Tempo.cgrus,''),10) + lcCodCors + lcFatVens"
        ENDCASE

        *-- Carregar descricao do estoque filtrado (se especificado)
        IF USED("TmpEsto")
            USE IN TmpEsto
        ENDIF
        IF !EMPTY(lcEstoque)
            loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(lcEstoque)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEsto")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados do estoque"
                RETURN .F.
            ENDIF
            SELECT TmpEsto
            GO TOP
        ENDIF

        *-- Buscar dados de movimentacao de estoque
        IF USED("Tempo")
            USE IN Tempo
        ENDIF

        WAIT WINDOW "Aguarde! Selecionando produtos..." NOWAIT

        IF llPosAtu
            *-- Posicao atual: consultar SigMvEst no SQL Server
            lcWhere1 = "a.emps+a.grupos+a.estos Between '" + ;
                lcEmpIni + lcGrEstIni + lcEstIni + ;
                "' And '" + ;
                lcEmpFim + lcGrEstFim + lcEstFim + "'"
            IF !EMPTY(lcLinha)
                lcWhere1 = lcWhere1 + " And b.linhas=" + EscaparSQL(lcLinha)
            ENDIF
            IF !EMPTY(lcGrupoVenda)
                lcWhere1 = lcWhere1 + " And b.colecoes=" + EscaparSQL(lcGrupoVenda)
            ENDIF
            IF !EMPTY(lcGrupo)
                lcWhere1 = lcWhere1 + " And b.cgrus=" + EscaparSQL(lcGrupo) + " And a.Sqtds <> 0"
            ENDIF

            loc_cSQL = "Select a.grupos,a.estos,a.cpros,b.cgrus,a.sqtds As valos," + ;
                "b.pvens,b.moevs,b.fvendas,b.moepvs,b.custofs,b.moecusfs," + ;
                "b.linhas,b.colecoes,a.CodCors,b.pesoms,b.Cunis,b.cUniPs,a.sPesos," + ;
                "l.descs As desclin,l.tpcustos,l.tpvendas,g.dgrus,c.descs As desccol " + ;
                "From SigMvEst a " + ;
                "Left Join SigCdPro b On b.cpros=a.cpros " + ;
                "Left Join SigCdLin l On l.linhas=b.linhas " + ;
                "Left Join SigCdCol c On c.colecoes=b.colecoes " + ;
                "Left Join SigCdGrp g On g.cgrus=b.cgrus " + ;
                "Where " + lcWhere1 + " " + ;
                "Order By " + lcOrdem
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tempo")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar dados de estoque"
                RETURN .F.
            ENDIF
            SELECT Tempo
            GO TOP
        ELSE
            *-- Historico: consultar SigMvHst
            IF USED("TmpHisPro")
                USE IN TmpHisPro
            ENDIF

            IF !EMPTY(lcEmpresa) AND !EMPTY(lcGrest) AND !EMPTY(lcEstoque)
                lcWhere1H = "a.empgruests = '" + lcEmpresa + lcGrest + lcEstoque + "'"
            ELSE
                lcWhere1H = "a.empgruests Between '" + ;
                    lcEmpIni + lcGrEstIni + lcEstIni + ;
                    "' And '" + ;
                    lcEmpFim + lcGrEstFim + lcEstFim + "'"
            ENDIF
            lcWhere1H = lcWhere1H + " And a.datas <= " + FormatarDataSQL(ldData) + ;
                " And a.cpros = b.cpros"
            IF !EMPTY(lcLinha)
                lcWhere1H = lcWhere1H + " And b.linhas = " + EscaparSQL(lcLinha)
            ENDIF
            IF !EMPTY(lcGrupoVenda)
                lcWhere1H = lcWhere1H + " And b.colecoes = " + EscaparSQL(lcGrupoVenda)
            ENDIF
            IF !EMPTY(lcGrupo)
                lcWhere1H = lcWhere1H + " And b.cgrus = " + EscaparSQL(lcGrupo)
            ENDIF

            loc_cSQL = "Select a.grupos,a.estos,a.cpros,b.cgrus,a.qtds," + ;
                "b.pvens,b.moevs,b.fvendas,b.moepvs,b.custofs,b.moecusfs," + ;
                "b.linhas,b.colecoes,a.CodCors,b.pesoms,a.opers,b.CUnis,b.cUniPs,a.Pesos " + ;
                "From SigMvHst a, SigCdPro b " + ;
                "Where " + lcWhere1H
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHisPro")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico de estoque"
                RETURN .F.
            ENDIF

            WAIT WINDOW "Aguarde! Verificando movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT
            SELECT grupos, estos, cpros, cgrus, pvens, moevs, fvendas, moepvs, ;
                custofs, moecusfs, linhas, colecoes, codCors, pesoms, cUnis, cUniPs, ;
                SUM(qtds * IIF(opers = "E", 1, -1)) AS valos, ;
                SUM(Pesos * IIF(opers = "E", 1, -1)) AS sPesos ;
                FROM TmpHisPro ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY &lcOrdem. ;
                INTO CURSOR Tempo
            SELECT Tempo
            GO TOP
        ENDIF

        *-- Processar registros de Tempo
        SELECT Tempo
        GO TOP
        IF !EOF()
            lnValCot = THIS.CarregarCambio(lcMoeda, ldData)

            SELECT Tempo
            GO TOP
            SCAN
                lcCodPro = Tempo.cpros

                IF Tempo.valos = 0
                    LOOP
                ENDIF

                IF !llPosAtu
                    *-- Buscar detalhes do produto na consulta historica
                    loc_cSQL = "Select a.cpros,g.dgrus,l.descs As desclin," + ;
                        "l.tpcustos,l.tpvendas,c.descs As desccol " + ;
                        "From SigCdPro a " + ;
                        "Left Join SigCdLin l On l.linhas = a.linhas " + ;
                        "Left Join SigCdCol c On c.colecoes = a.colecoes " + ;
                        "Left Join SigCdGrp g On g.cgrus = a.cgrus " + ;
                        "Where a.cpros = " + EscaparSQL(lcCodPro)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPro")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar dados do produto"
                        RETURN .F.
                    ENDIF
                ENDIF

                SELECT Tempo
                lnValorProd = NVL(Tempo.pvens, 0) * Tempo.valos
                lnValorProd = lnValorProd * THIS.CarregarCambio(NVL(Tempo.moevs, ""), ldData) / lnValCot
                lnCustoProd = NVL(Tempo.custofs, 0)

                IF llPosAtu
                    IF NVL(Tempo.tpcustos, "") = "2"
                        lnCustoProd = NVL(Tempo.pesoms, 0) * NVL(Tempo.custofs, 0)
                    ENDIF
                    IF NVL(Tempo.tpvendas, "") = "2"
                        lnValorProd = NVL(Tempo.pesoms, 0) * lnValorProd
                    ENDIF
                ELSE
                    IF NVL(TmpPro.tpcustos, "") = "2"
                        lnCustoProd = NVL(Tempo.pesoms, 0) * NVL(Tempo.custofs, 0)
                    ENDIF
                    IF NVL(TmpPro.tpvendas, "") = "2"
                        lnValorProd = NVL(Tempo.pesoms, 0) * lnValorProd
                    ENDIF
                ENDIF

                lnCustoProd = lnCustoProd * Tempo.valos * ;
                    THIS.CarregarCambio(NVL(Tempo.moecusfs, ""), ldData) / lnValCot
                lnValFat = IIF(NVL(Tempo.fvendas, 0) = 0, 1, ;
                    NVL(Tempo.fvendas, 0) * THIS.CarregarCambio(NVL(Tempo.moepvs, ""), ldData))
                lnValorProd = lnValorProd * lnValFat

                *-- Registrar cotacoes utilizadas em TempMoe
                SELECT TempMoe
                SET ORDER TO cmoes
                =SEEK(NVL(Tempo.moevs, ""), "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH NVL(Tempo.moevs, "")
                    REPLACE TempMoe.cotacao WITH THIS.CarregarCambio(NVL(Tempo.moevs, ""), ldData)
                ENDIF
                =SEEK(lcMoeda, "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH lcMoeda
                    REPLACE TempMoe.cotacao WITH lnValCot
                ENDIF
                =SEEK(NVL(Tempo.moecusfs, ""), "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH NVL(Tempo.moecusfs, "")
                    REPLACE TempMoe.cotacao WITH THIS.CarregarCambio(NVL(Tempo.moecusfs, ""), ldData)
                ENDIF
                =SEEK(NVL(Tempo.moepvs, ""), "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH NVL(Tempo.moepvs, "")
                    REPLACE TempMoe.cotacao WITH THIS.CarregarCambio(NVL(Tempo.moepvs, ""), ldData)
                ENDIF

                *-- Adicionar ou acumular registro em dbRelat
                SELECT dbRelat
                SET ORDER TO cgrus

                lcFatVens = ""
                IF lnFator = 1
                    lcFatVens = NVL(Tempo.moepvs, "")
                ENDIF
                lcCodCors = SPACE(4)
                IF lnOrdem = 1
                    lcCodCors = Tempo.codCors
                ENDIF

                =SEEK(&lcChave., "dbRelat", "cgrus")
                SELECT dbRelat
                IF EOF()
                    APPEND BLANK
                    REPLACE dbRelat.fatvens WITH lcFatVens, ;
                        dbRelat.grupos  WITH Tempo.grupos, ;
                        dbRelat.estos   WITH Tempo.estos, ;
                        dbRelat.cUnis   WITH Tempo.cUnis, ;
                        dbRelat.cUniPs  WITH Tempo.cUniPs, ;
                        dbRelat.codCors WITH lcCodCors IN dbRelat
                    DO CASE
                    CASE lnOrdem = 1
                        REPLACE dbRelat.codigo WITH NVL(Tempo.cgrus, "")
                        IF llPosAtu
                            REPLACE dbRelat.Descr WITH NVL(Tempo.dgrus, "")
                        ELSE
                            REPLACE dbRelat.Descr WITH NVL(TmpPro.dgrus, "")
                        ENDIF
                    CASE lnOrdem = 2
                        REPLACE dbRelat.codigo WITH NVL(Tempo.linhas, "")
                        IF llPosAtu
                            REPLACE dbRelat.Descr WITH NVL(Tempo.desclin, "")
                        ELSE
                            REPLACE dbRelat.Descr WITH NVL(TmpPro.desclin, "")
                        ENDIF
                    CASE lnOrdem = 3
                        REPLACE dbRelat.codigo WITH NVL(Tempo.colecoes, "")
                        IF llPosAtu
                            REPLACE dbRelat.Descr WITH NVL(Tempo.desccol, "")
                        ELSE
                            REPLACE dbRelat.Descr WITH NVL(TmpPro.desccol, "")
                        ENDIF
                    CASE lnOrdem = 4
                        lcEstos = Tempo.estos
                        lcRclis = ""
                        IF EMPTY(lcEstoque)
                            IF USED("TmpEsto")
                                USE IN TmpEsto
                            ENDIF
                            loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(lcEstos)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEsto")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar descri" + CHR(231) + CHR(227) + "o do estoque"
                                RETURN .F.
                            ENDIF
                        ENDIF
                        SELECT TmpEsto
                        GO TOP
                        IF !EOF()
                            lcRclis = TmpEsto.rclis
                        ENDIF
                        REPLACE dbRelat.codigo WITH lcEstos
                        REPLACE dbRelat.Descr  WITH lcRclis
                    ENDCASE
                ENDIF

                *-- Acumular totais no registro de dbRelat
                REPLACE dbRelat.qtds   WITH dbRelat.qtds   + Tempo.valos
                REPLACE dbRelat.vends  WITH dbRelat.vends  + lnValorProd
                REPLACE dbRelat.custs  WITH dbRelat.custs  + lnCustoProd
                REPLACE dbRelat.sPesos WITH dbRelat.sPesos + Tempo.sPesos
                REPLACE dbRelat.pesom  WITH dbRelat.pesom  + NVL(Tempo.pesoms, 0) * Tempo.valos

                *-- Acumular por unidade
                SELECT dbUnis
                SEEK Tempo.cUnis
                IF !FOUND()
                    APPEND BLANK
                    REPLACE cUnis WITH Tempo.cUnis
                ENDIF
                REPLACE nValors WITH nValors + Tempo.valos

                SELECT Tempo
            ENDSCAN

            *-- Montar linhas de detalhe do relatorio
            nTotQtds  = 0
            nTotPeso  = 0
            nTotCusto = 0
            nTotVenda = 0
            cAnt      = " "
            cAnte     = " "

            SELECT dbRelat
            GO TOP
            SCAN
                cDetalhe = PADR(dbRelat.codigo, 10) + " "
                cDetalhe = cDetalhe + PADR(dbRelat.Descr, ;
                    IIF((lnPeso = 1 OR lnFator = 1) AND lnOrdem <> 4, ;
                    IIF(lnOrdem = 1, 13, 18), 27)) + " "
                cDetalhe = cDetalhe + IIF(lnOrdem = 1, dbRelat.codCors + " ", "")
                IF lnFator = 1
                    cDetalhe = cDetalhe + PADC(dbRelat.fatvens, 3) + " "
                ENDIF
                cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.qtds, "999999.999"), 10) + " " + ;
                    IIF(llUnis, dbRelat.cUnis + " ", "")
                IF lnPeso = 1
                    cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.pesom, "999,999.99"), 10) + " "
                ENDIF
                IF lnValCust = 1
                    cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.custs, "99999,999,999.99"), 16) + " "
                ENDIF
                IF lnValVend = 1
                    cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.vends, "99999,999,999.99"), 16)
                ENDIF
                IF lnOrdem <> 4
                    cDetalhe = IIF(cAnt = dbRelat.grupos, SPACE(10), dbRelat.grupos) + ;
                        " " + dbRelat.estos + " " + cDetalhe
                ELSE
                    cDetalhe = IIF(cAnt = dbRelat.grupos, SPACE(10), dbRelat.grupos) + ;
                        " " + cDetalhe
                ENDIF
                cAnt  = dbRelat.grupos
                cAnte = dbRelat.estos

                INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)

                nTotQtds  = nTotQtds  + dbRelat.qtds
                nTotPeso  = nTotPeso  + dbRelat.pesom
                nTotCusto = nTotCusto + dbRelat.custs
                nTotVenda = nTotVenda + dbRelat.vends
            ENDSCAN

            *-- Calcular espaco para alinhamento dos totais
            lnEspaco = IIF((lnFator = 1 OR lnPeso = 1) AND lnOrdem <> 4, ;
                IIF(lnPeso = 1 AND lnFator <> 1, 39, 43), ;
                IIF(lnPeso = 1 AND lnFator <> 1, 51, ;
                IIF(lnPeso <> 1 AND lnFator <> 1, IIF(lnOrdem <> 4, 56, 51), 55))) + ;
                IIF(lnOrdem = 1, 13, IIF(lnOrdem <> 4, IIF(lnPeso = 1 OR lnFator = 1, 13, 8), 2))

            *-- Linha separadora
            cTotal = SPACE(lnEspaco)
            cTotal = cTotal + REPLICATE("_", 10) + " "
            IF lnPeso = 1
                cTotal = cTotal + REPLICATE("_", 10) + " "
            ENDIF
            IF lnValCust = 1
                cTotal = cTotal + REPLICATE("_", 16) + " "
            ENDIF
            IF lnValVend = 1
                cTotal = cTotal + REPLICATE("_", 16) + " "
            ENDIF
            INSERT INTO dbRelatorio (Detalhe) VALUES (cTotal)

            *-- Linha de totais gerais
            cTotal = PADL("Total : ", lnEspaco)
            cTotal = cTotal + PADL(TRANSFORM(nTotQtds, "999,999.99"), 10) + " "
            IF lnPeso = 1
                cTotal = cTotal + PADL(TRANSFORM(nTotPeso, "999,999.99"), 10) + " "
            ENDIF
            IF lnValCust = 1
                cTotal = cTotal + PADL(TRANSFORM(nTotCusto, "99999,999,999.99"), 16) + " "
            ENDIF
            IF lnValVend = 1
                cTotal = cTotal + PADL(TRANSFORM(nTotVenda, "99999,999,999.99"), 16) + " "
            ENDIF
            INSERT INTO dbRelatorio (Detalhe) VALUES (cTotal)

            *-- Totais por unidade (se habilitado)
            IF llUnis
                SELECT dbUnis
                GO TOP
                IF !EOF()
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = "Totais Por Unidade"
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = PADC("Unidade", 7) + " "
                    cDetalhe = cDetalhe + PADC("Total", 14)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    cDetalhe = REPLICATE("_", 7) + " "
                    cDetalhe = cDetalhe + REPLICATE("_", 20)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    SCAN
                        cDetalhe = "  " + dbUnis.cUnis + "   "
                        cDetalhe = cDetalhe + PADL(TRANSFORM(dbUnis.nValors, "9999,999,999,999.999"), 20)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Dados de cotacoes de moeda (se habilitado e moeda informada)
            IF lnDadosCotacao = 1 AND !EMPTY(lcMoeda)
                SELECT TempMoe
                GO TOP
                IF !EOF()
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = "Cota" + CHR(231) + CHR(245) + "es de " + DTOC(ldDtCotacao)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = PADC("Moeda", 5) + " "
                    cDetalhe = cDetalhe + PADC("Cota" + CHR(231) + CHR(227) + "o", 14)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    cDetalhe = REPLICATE("_", 5) + " "
                    cDetalhe = cDetalhe + REPLICATE("_", 14)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    SCAN
                        cDetalhe = PADR(TempMoe.cmoes, 5) + " "
                        cDetalhe = cDetalhe + PADL(TRANSFORM(TempMoe.cotacao, "999,999,999.99"), 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    ENDSCAN
                ENDIF
            ENDIF
        ENDIF

        WAIT CLEAR

        SELECT dbRelatorio
        GO TOP

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data especificada
    * Replica logica de fCarregarCambio do sistema legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 cotacao FROM SigCdCot " + ;
                "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                " AND datas <= " + FormatarDataSQL(par_dData) + ;
                " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EgpCambio")
            IF loc_nResult > 0
                SELECT cursor_4c_EgpCambio
                GO TOP
                IF !EOF()
                    loc_nCotacao = NVL(cursor_4c_EgpCambio.cotacao, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_EgpCambio
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor de parametros
    * BO de RELATORIO nao tem cursor de dados persistido: a procedure existe
    * para compatibilidade com a interface esperada pelo pipeline e para permitir
    * que um cursor temporario de parametros seja relido (por exemplo, ao
    * reabrir o form com filtros salvos). Mapeia colunas conhecidas para as
    * propriedades correspondentes do BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        IF VARTYPE(par_cAliasCursor) <> "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF
        loc_cAlias = ALLTRIM(par_cAliasCursor)
        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF
        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".cemps")     = "C"
                    THIS.this_cCdEmpresa = TratarNulo(EVALUATE(loc_cAlias + ".cemps"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".grupos")    = "C"
                    THIS.this_cCdGrEstoque = TratarNulo(EVALUATE(loc_cAlias + ".grupos"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".estos")     = "C"
                    THIS.this_cCdEstoque = TratarNulo(EVALUATE(loc_cAlias + ".estos"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".cgrus")     = "C"
                    THIS.this_cCdGrupo = TratarNulo(EVALUATE(loc_cAlias + ".cgrus"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".datas")     = "D"
                    THIS.this_dData = TratarNulo(EVALUATE(loc_cAlias + ".datas"), "D")
                ENDIF
                IF TYPE(loc_cAlias + ".cmoes")     = "C"
                    THIS.this_cCdMoeda = TratarNulo(EVALUATE(loc_cAlias + ".cmoes"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".linhas")    = "C"
                    THIS.this_cCdLinha = TratarNulo(EVALUATE(loc_cAlias + ".linhas"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".colecoes")  = "C"
                    THIS.this_cCdColecao = TratarNulo(EVALUATE(loc_cAlias + ".colecoes"), "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persistencia desabilitada
    * BO de RELATORIO nao grava registros em tabela. Mantemos o metodo na
    * interface publica para compatibilidade com chamadas genericas do pipeline,
    * mas qualquer chamada eh tratada como erro de uso: emite mensagem clara,
    * NAO falha silenciosamente e retorna .F. para sinalizar a opcao invalida.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o aplic" + CHR(225) + "vel: este relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o realiza inser" + CHR(231) + CHR(227) + "o de registros em tabela. " + ;
            "Use Imprimir() ou Visualizar() para gerar o relat" + CHR(243) + "rio."
        THIS.RegistrarAuditoria("INSERIR_INVALIDA")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Persistencia desabilitada
    * BO de RELATORIO nao atualiza registros. Mesma logica de Inserir():
    * mantemos a assinatura para compatibilidade, mas qualquer chamada eh
    * tratada como uso indevido com mensagem explicita e retorno .F.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o aplic" + CHR(225) + "vel: este relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o realiza atualiza" + CHR(231) + CHR(227) + "o de registros em tabela. " + ;
            "Use Imprimir() ou Visualizar() para gerar o relat" + CHR(243) + "rio."
        THIS.RegistrarAuditoria("ATUALIZAR_INVALIDA")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da emissao do relatorio
    * Como o relatorio nao tem registro persistido com PK, montamos um
    * identificador unico baseado nos filtros principais (empresa + data de
    * posicao + grupo de estoque). Usado por RegistrarAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmp, loc_cData, loc_cGrEst
        loc_cEmp   = ALLTRIM(NVL(THIS.this_cCdEmpresa, ""))
        loc_cGrEst = ALLTRIM(NVL(THIS.this_cCdGrEstoque, ""))
        IF VARTYPE(THIS.this_dData) = "D" AND !EMPTY(THIS.this_dData)
            loc_cData = DTOS(THIS.this_dData)
        ELSE
            loc_cData = DTOS(DATE())
        ENDIF
        loc_cChave = "SIGREEGP|" + loc_cEmp + "|" + loc_cData + "|" + loc_cGrEst
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava log de emissao/uso do relatorio
    * Para BO de RELATORIO registra a operacao executada (EMISSAO_IMPRIMIR,
    * EMISSAO_VISUALIZAR, INSERIR_INVALIDA, ATUALIZAR_INVALIDA) na tabela
    * LogAuditoria com a chave gerada por ObterChavePrimaria. Falhas no INSERT
    * de auditoria nao devem propagar (auditoria nao pode bloquear a emissao
    * do relatorio), portanto sao capturadas e silenciadas via TRY/CATCH.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cOperacao, loc_cChave, loc_cUsuario, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cOperacao) <> "C" OR EMPTY(par_cOperacao)
                loc_cOperacao = "EMISSAO_RELATORIO"
            ELSE
                loc_cOperacao = ALLTRIM(par_cOperacao)
            ENDIF
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                    "VALUES (" + EscaparSQL("SIGREEGP") + ", " + EscaparSQL(loc_cOperacao) + ", " + ;
                    EscaparSQL(loc_cChave) + ", " + EscaparSQL(loc_cUsuario) + ", GETDATE())"
                =SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha todos os cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("dbRelatorio")
            USE IN dbRelatorio
        ENDIF
        IF USED("TempMoe")
            USE IN TempMoe
        ENDIF
        IF USED("dbRelat")
            USE IN dbRelat
        ENDIF
        IF USED("Tempo")
            USE IN Tempo
        ENDIF
        IF USED("TmpHisPro")
            USE IN TmpHisPro
        ENDIF
        IF USED("TmpEsto")
            USE IN TmpEsto
        ENDIF
        IF USED("TmpPro")
            USE IN TmpPro
        ENDIF
        IF USED("dbUnis")
            USE IN dbUnis
        ENDIF
    ENDPROC

ENDDEFINE

