# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [LAYOUT-POSITION] Controle 'lblemp' (parent: SIGREDOC): Top original=104 vs migrado 'lbl_4c_LblEmpresas' Top=19 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredoc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1232 linhas total):

*-- Linhas 55 a 63:
55:         loc_lContinuar = .T.
56: 
57:         TRY
58:             THIS.Caption = "Impress" + CHR(227) + "o de Documento"
59: 
60:             IF TYPE("gc_4c_CaminhoIcones") = "U"
61:                 gc_4c_CaminhoIcones = ""
62:             ENDIF
63:             IF TYPE("gc_4c_CaminhoBase") = "U"

*-- Linhas 76 a 85:
76:             IF loc_lContinuar
77:                 THIS.ConfigurarCabecalho()
78:                 THIS.ConfigurarPageFrame()
79:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81:                 THIS.ConfigurarPaginaLista()
82:                 THIS.ConfigurarPaginaDados()
83:                 THIS.CarregarEmpresas()
84:                 THIS.LimparCampos()
85:                 loc_lSucesso = .T.

*-- Linhas 105 a 168:
105:         loc_oCab = THIS.cnt_4c_Cabecalho
106: 
107:         WITH loc_oCab
108:             .Top         = 0
109:             .Left        = 0
110:             .Width       = THIS.Width
111:             .Height      = 80
112:             .BackStyle   = 1
113:             .BackColor   = RGB(100, 100, 100)
114:             .BorderWidth = 0
115:             .Visible     = .T.
116: 
117:             .AddObject("lbl_4c_Sombra", "Label")
118:             WITH .lbl_4c_Sombra
119:                 .Top       = 22
120:                 .Left      = 22
121:                 .Width     = THIS.Width
122:                 .Height    = 30
123:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
124:                 .FontName  = "Tahoma"
125:                 .FontSize  = 14
126:                 .FontBold  = .T.
127:                 .ForeColor = RGB(0, 0, 0)
128:                 .BackStyle = 0
129:                 .Visible   = .T.
130:             ENDWITH
131: 
132:             .AddObject("lbl_4c_Titulo", "Label")
133:             WITH .lbl_4c_Titulo
134:                 .Top       = 20
135:                 .Left      = 20
136:                 .Width     = THIS.Width
137:                 .Height    = 30
138:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 14
141:                 .FontBold  = .T.
142:                 .ForeColor = RGB(255, 255, 255)
143:                 .BackStyle = 0
144:                 .Visible   = .T.
145:             ENDWITH
146: 
147:             .AddObject("cmg_4c_Botoes", "CommandGroup")
148:             WITH .cmg_4c_Botoes
149:                 .Top           = 0
150:                 .Left          = 529
151:                 .Width         = THIS.Width
152:                 .Height        = 80
153:                 .ButtonCount   = 4
154:                 .BackStyle     = 0
155:                 .BorderColor   = RGB(136, 189, 188)
156:                 .SpecialEffect = 1
157:                 .Themes        = .F.
158:                 .Visible       = .T.
159: 
160:                 WITH .Buttons(1)
161:                     .Caption         = "Visualizar"
162:                     .Top             = 5
163:                     .Left            = 5
164:                     .Width           = THIS.Width
165:                     .Height          = 70
166:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
167:                     .PicturePosition = 13
168:                     .FontBold        = .T.

*-- Linhas 175 a 185:
175:                 ENDWITH
176: 
177:                 WITH .Buttons(2)
178:                     .Caption         = "Imprimir"
179:                     .Top             = 5
180:                     .Left            = 71
181:                     .Width           = THIS.Width
182:                     .Height          = 70
183:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
184:                     .PicturePosition = 13
185:                     .FontName        = "Tahoma"

*-- Linhas 194 a 204:
194:                 ENDWITH
195: 
196:                 WITH .Buttons(3)
197:                     .Caption         = "Doc. Excel"
198:                     .Top             = 5
199:                     .Left            = 137
200:                     .Width           = THIS.Width
201:                     .Height          = 70
202:                     .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
203:                     .PicturePosition = 13
204:                     .FontName        = "Tahoma"

*-- Linhas 213 a 223:
213:                 ENDWITH
214: 
215:                 WITH .Buttons(4)
216:                     .Caption         = "Sair"
217:                     .Top             = 5
218:                     .Left            = 203
219:                     .Width           = THIS.Width
220:                     .Height          = 70
221:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
222:                     .PicturePosition = 13
223:                     .Cancel          = .T.

*-- Linhas 252 a 266:
252:         loc_oPgf = THIS.pgf_4c_Paginas
253: 
254:         loc_oPgf.PageCount = 1
255:         loc_oPgf.Top       = 85
256:         loc_oPgf.Left      = -1
257:         loc_oPgf.Width     = THIS.Width + 2
258:         loc_oPgf.Height    = THIS.Height - 85
259:         loc_oPgf.Tabs      = .F.
260: 
261:         loc_oPgf.Page1.Caption   = "Filtros"
262:         loc_oPgf.Page1.FontName  = "Tahoma"
263:         loc_oPgf.Page1.FontSize  = 8
264:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
265:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
266:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 275 a 313:
275:     *   de empresas; o nome ConfigurarPaginaLista mantem compatibilidade com o
276:     *   pipeline multi-fase (validacao Fase 4) e com forms similares (FormSIGREDIR).
277:     *   Posicoes: Top_page1 = Top_original - 85
278:     *   (Form original Top max ~420; PageFrame.Top=85)
279:     *--------------------------------------------------------------------------
280:     PROTECTED PROCEDURE ConfigurarPaginaLista()
281:         LOCAL loc_oPagina, loc_oGrd
282:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
283: 
284:         *-- Label "Empresas :" (top_orig=104, left=217 -> page1 top=19)
285:         loc_oPagina.AddObject("lbl_4c_LblEmpresas", "Label")
286:         WITH loc_oPagina.lbl_4c_LblEmpresas
287:             .Top       = 19
288:             .Left      = 217
289:             .Width     = 63
290:             .Height    = 15
291:             .Caption   = "Empresas :"
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .FontBold  = .T.
295:             .ForeColor = RGB(90, 90, 90)
296:             .BackStyle = 0
297:             .Visible   = .T.
298:         ENDWITH
299: 
300:         *-- Grid de empresas (top_orig=120, left=216 -> page1 top=35)
301:         *   Column1: CheckBox Marca (w=15)
302:         *   Column2: cEmps Cod. (w=33, ReadOnly)
303:         *   Column3: Razas Nome (w=245, ReadOnly)
304:         loc_oPagina.AddObject("grd_4c_Emps", "Grid")
305:         loc_oGrd = loc_oPagina.grd_4c_Emps
306:         WITH loc_oGrd
307:             .Top              = 35
308:             .Left             = 216
309:             .Width            = 327
310:             .Height           = 164
311:             .ColumnCount      = 3
312:             .FontName         = "Tahoma"
313:             .FontSize         = 8

*-- Linhas 322 a 343:
322:             .Themes           = .F.
323:             .Visible          = .T.
324: 
325:             *-- Column1: CheckBox para Marca
326:             WITH .Column1
327:                 .Width     = 15
328:                 .Movable   = .F.
329:                 .Resizable = .F.
330:                 .Sparse    = .F.
331:                 .Header1.Caption   = ""
332:                 .Header1.FontName  = "Tahoma"
333:                 .Header1.FontSize  = 8
334:                 .Header1.ForeColor = RGB(90, 90, 90)
335:                 .AddObject("chk_4c_Marca", "CheckBox")
336:                 .CurrentControl = "chk_4c_Marca"
337:                 WITH .chk_4c_Marca
338:                     .Caption   = ""
339:                     .Alignment = 2
340:                     .Width     = 14
341:                     .Height    = 14
342:                     .FontName  = "Tahoma"
343:                     .FontSize  = 8

*-- Linhas 351 a 359:
351:                 .Resizable      = .F.
352:                 .ReadOnly       = .T.
353:                 .CurrentControl = "Text1"
354:                 .Header1.Caption   = "C" + CHR(243) + "d."
355:                 .Header1.FontName  = "Tahoma"
356:                 .Header1.FontSize  = 8
357:                 .Header1.ForeColor = RGB(90, 90, 90)
358:                 .Header1.Alignment = 2
359:                 WITH .Text1

*-- Linhas 373 a 381:
373:                 .Resizable      = .F.
374:                 .ReadOnly       = .T.
375:                 .CurrentControl = "Text1"
376:                 .Header1.Caption   = "Nome da Empresa"
377:                 .Header1.FontName  = "Tahoma"
378:                 .Header1.FontSize  = 8
379:                 .Header1.ForeColor = RGB(90, 90, 90)
380:                 .Header1.Alignment = 2
381:                 WITH .Text1

*-- Linhas 390 a 459:
390:         ENDWITH
391: 
392:         *-- Botao Selecionar Todas (cmdSelemp, top_orig=164, left=547 -> top=79)
393:         loc_oPagina.AddObject("cmd_4c_SelecionarTodas", "CommandButton")
394:         WITH loc_oPagina.cmd_4c_SelecionarTodas
395:             .Top          = 79
396:             .Left         = 547
397:             .Width        = 40
398:             .Height       = 40
399:             .Caption      = ""
400:             .Picture      = gc_4c_CaminhoBase + "vbmp\a_save1.bmp"
401:             .FontName     = "Verdana"
402:             .FontSize     = 8
403:             .WordWrap     = .T.
404:             .ToolTipText  = "Selecionar"
405:             .TabStop      = .F.
406:             .ForeColor    = RGB(36, 84, 155)
407:             .BackColor    = RGB(255, 255, 255)
408:             .Themes       = .F.
409:             .Visible      = .T.
410:         ENDWITH
411:         BINDEVENT(loc_oPagina.cmd_4c_SelecionarTodas, "Click", THIS, "CmdSelecionarTodasClick")
412: 
413:         *-- Botao Desmarcar Todas (CmdApgEmp, top_orig=204, left=547 -> top=119)
414:         loc_oPagina.AddObject("cmd_4c_DesmarcarTodas", "CommandButton")
415:         WITH loc_oPagina.cmd_4c_DesmarcarTodas
416:             .Top          = 119
417:             .Left         = 547
418:             .Width        = 40
419:             .Height       = 40
420:             .Caption      = ""
421:             .Picture      = gc_4c_CaminhoBase + "vbmp\cancelab.bmp"
422:             .FontName     = "Verdana"
423:             .FontSize     = 8
424:             .WordWrap     = .T.
425:             .ToolTipText  = "Desmarcar"
426:             .TabStop      = .F.
427:             .ForeColor    = RGB(36, 84, 155)
428:             .BackColor    = RGB(255, 255, 255)
429:             .Themes       = .F.
430:             .Visible      = .T.
431:         ENDWITH
432:         BINDEVENT(loc_oPagina.cmd_4c_DesmarcarTodas, "Click", THIS, "CmdDesmarcarTodasClick")
433: 
434:         *-- Label "Opera" + CHR(231) + CHR(227) + "o :" (top_orig=293, left=225 -> top=208)
435:         loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
436:         WITH loc_oPagina.lbl_4c_Operacao
437:             .Top       = 208
438:             .Left      = 225
439:             .Width     = 59
440:             .Height    = 18
441:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
442:             .FontName  = "Tahoma"
443:             .FontSize  = 8
444:             .ForeColor = RGB(90, 90, 90)
445:             .BackStyle = 0
446:             .AutoSize  = .T.
447:             .Visible   = .T.
448:         ENDWITH
449: 
450:         *-- Campo Operacao get_dopes (top_orig=289, left=288 -> top=204)
451:         loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
452:         WITH loc_oPagina.txt_4c_Dopes
453:             .Top           = 204
454:             .Left          = 288
455:             .Width         = 150
456:             .Height        = 23
457:             .Value         = ""
458:             .FontName      = "Tahoma"
459:             .FontSize      = 9

*-- Linhas 469 a 496:
469:         BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "TeclaDopes")
470: 
471:         *-- Label "Periodo :" (top_orig=318, left=236 -> top=233)
472:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
473:         WITH loc_oPagina.lbl_4c_Periodo
474:             .Top       = 233
475:             .Left      = 236
476:             .Width     = 48
477:             .Height    = 18
478:             .Caption   = "Periodo : "
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .ForeColor = RGB(90, 90, 90)
482:             .BackStyle = 0
483:             .AutoSize  = .T.
484:             .Visible   = .T.
485:         ENDWITH
486: 
487:         *-- Data Inicial (top_orig=314, left=288 -> top=229)
488:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
489:         WITH loc_oPagina.txt_4c_DtInicial
490:             .Top           = 229
491:             .Left          = 288
492:             .Width         = 80
493:             .Height        = 23
494:             .Value         = {}
495:             .FontName      = "Tahoma"
496:             .FontSize      = 8

*-- Linhas 505 a 531:
505:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "LostFocus", THIS, "AtualizarEstadoFiltros")
506: 
507:         *-- Separador "a" entre datas (top_orig=319, left=371 -> top=234)
508:         loc_oPagina.AddObject("lbl_4c_SepData", "Label")
509:         WITH loc_oPagina.lbl_4c_SepData
510:             .Top       = 234
511:             .Left      = 371
512:             .Width     = 8
513:             .Height    = 18
514:             .Caption   = CHR(224)
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .ForeColor = RGB(90, 90, 90)
518:             .BackStyle = 0
519:             .Visible   = .T.
520:         ENDWITH
521: 
522:         *-- Data Final (top_orig=314, left=382 -> top=229)
523:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
524:         WITH loc_oPagina.txt_4c_DtFinal
525:             .Top           = 229
526:             .Left          = 382
527:             .Width         = 80
528:             .Height        = 23
529:             .Value         = {}
530:             .FontName      = "Tahoma"
531:             .FontSize      = 8

*-- Linhas 540 a 567:
540:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "LostFocus", THIS, "AtualizarEstadoFiltros")
541: 
542:         *-- Label "N" + CHR(250) + "mero :" (top_orig=341, left=235 -> top=256)
543:         loc_oPagina.AddObject("lbl_4c_Numero", "Label")
544:         WITH loc_oPagina.lbl_4c_Numero
545:             .Top       = 256
546:             .Left      = 235
547:             .Width     = 49
548:             .Height    = 18
549:             .Caption   = "N" + CHR(250) + "mero : "
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .ForeColor = RGB(90, 90, 90)
553:             .BackStyle = 0
554:             .AutoSize  = .T.
555:             .Visible   = .T.
556:         ENDWITH
557: 
558:         *-- Numero Inicial Get_Opera??oi (top_orig=339, left=288 -> top=254)
559:         loc_oPagina.AddObject("txt_4c_NumeroI", "TextBox")
560:         WITH loc_oPagina.txt_4c_NumeroI
561:             .Top           = 254
562:             .Left          = 288
563:             .Width         = 55
564:             .Height        = 23
565:             .Value         = 0
566:             .FontName      = "Tahoma"
567:             .FontSize      = 8

*-- Linhas 578 a 604:
578:         BINDEVENT(loc_oPagina.txt_4c_NumeroI, "LostFocus", THIS, "AtualizarEstadoFiltros")
579: 
580:         *-- Separador "a" entre numeros (top_orig=344, left=349 -> top=259)
581:         loc_oPagina.AddObject("lbl_4c_SepNumero", "Label")
582:         WITH loc_oPagina.lbl_4c_SepNumero
583:             .Top       = 259
584:             .Left      = 349
585:             .Width     = 8
586:             .Height    = 15
587:             .Caption   = CHR(224)
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .ForeColor = RGB(90, 90, 90)
591:             .BackStyle = 0
592:             .Visible   = .T.
593:         ENDWITH
594: 
595:         *-- Numero Final Get_Opera??of (top_orig=339, left=363 -> top=254)
596:         loc_oPagina.AddObject("txt_4c_NumeroF", "TextBox")
597:         WITH loc_oPagina.txt_4c_NumeroF
598:             .Top           = 254
599:             .Left          = 363
600:             .Width         = 55
601:             .Height        = 23
602:             .Value         = 0
603:             .FontName      = "Tahoma"
604:             .FontSize      = 8

*-- Linhas 614 a 667:
614:         BINDEVENT(loc_oPagina.txt_4c_NumeroF, "KeyPress", THIS, "TeclaNumeroF")
615:         BINDEVENT(loc_oPagina.txt_4c_NumeroF, "LostFocus", THIS, "AtualizarEstadoFiltros")
616: 
617:         *-- Checkbox Imprimir Imagem (top_orig=368, left=288 -> top=283)
618:         loc_oPagina.AddObject("chk_4c_Imagem", "CheckBox")
619:         WITH loc_oPagina.chk_4c_Imagem
620:             .Top       = 283
621:             .Left      = 288
622:             .Width     = 100
623:             .Height    = 15
624:             .Caption   = "Imprimir Imagem"
625:             .Value     = 0
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .FontBold  = .F.
629:             .AutoSize  = .T.
630:             .Alignment = 0
631:             .BackStyle = 0
632:             .ForeColor = RGB(90, 90, 90)
633:             .Visible   = .T.
634:         ENDWITH
635: 
636:         *-- Checkbox Imprimir Apenas Itens em Aberto (top_orig=384, left=288 -> top=299)
637:         loc_oPagina.AddObject("chk_4c_ItensPendentes", "CheckBox")
638:         WITH loc_oPagina.chk_4c_ItensPendentes
639:             .Top       = 299
640:             .Left      = 288
641:             .Width     = 170
642:             .Height    = 15
643:             .Caption   = "Imprimir Apenas Itens Pendentes"
644:             .Value     = 0
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .FontBold  = .F.
648:             .AutoSize  = .T.
649:             .Alignment = 0
650:             .BackStyle = 0
651:             .ForeColor = RGB(90, 90, 90)
652:             .Visible   = .T.
653:         ENDWITH
654: 
655:         *-- Checkbox Reimpressao (top_orig=400, left=288 -> top=315)
656:         loc_oPagina.AddObject("chk_4c_Reimp", "CheckBox")
657:         WITH loc_oPagina.chk_4c_Reimp
658:             .Top           = 315
659:             .Left          = 288
660:             .Width         = 79
661:             .Height        = 15
662:             .Caption       = "Reimpress" + CHR(227) + "o"
663:             .Value         = 0
664:             .FontName      = "Tahoma"
665:             .FontSize      = 8
666:             .FontBold      = .F.
667:             .AutoSize      = .T.

*-- Linhas 674 a 688:
674:         ENDWITH
675: 
676:         *-- Label "Agrupar por: " (top_orig=420, left=217 -> top=335)
677:         loc_oPagina.AddObject("lbl_4c_AgruparPor", "Label")
678:         WITH loc_oPagina.lbl_4c_AgruparPor
679:             .Top       = 335
680:             .Left      = 217
681:             .Width     = 67
682:             .Height    = 18
683:             .Caption   = "Agrupar por: "
684:             .FontName  = "Tahoma"
685:             .FontSize  = 8
686:             .ForeColor = RGB(90, 90, 90)
687:             .BackStyle = 0
688:             .AutoSize  = .T.

*-- Linhas 695 a 728:
695:         *   Button2: "Nenhum" (Value=1 dentro do botao, mas grupo Value=2)
696:         loc_oPagina.AddObject("opt_4c_Agrupa", "OptionGroup")
697:         WITH loc_oPagina.opt_4c_Agrupa
698:             .Top         = 331
699:             .Left        = 283
700:             .Width       = 267
701:             .Height      = 27
702:             .ButtonCount = 2
703:             .AutoSize    = .T.
704:             .BackStyle   = 0
705:             .BorderStyle = 0
706:             .Value       = 2
707:             .Visible     = .T.
708: 
709:             WITH .Buttons(1)
710:                 .Caption   = "Produto, Cor, Valor Unit" + CHR(225) + "rio"
711:                 .Top       = 5
712:                 .Left      = 5
713:                 .Width     = 151
714:                 .Height    = 15
715:                 .AutoSize  = .T.
716:                 .BackStyle = 0
717:                 .ForeColor = RGB(90, 90, 90)
718:             ENDWITH
719: 
720:             WITH .Buttons(2)
721:                 .Caption   = "Nenhum"
722:                 .Top       = 5
723:                 .Left      = 193
724:                 .Width     = 69
725:                 .Height    = 17
726:                 .AutoSize  = .T.
727:                 .BackStyle = 0
728:                 .FontName  = "Tahoma"

*-- Linhas 740 a 749:
740:     *   de edicao; todos os 20 controles migrados estao na Page1/Filtros:
741:     *     grd_4c_Emps (3 colunas), txt_4c_Dopes, txt_4c_DtInicial,
742:     *     txt_4c_DtFinal, txt_4c_NumeroI, txt_4c_NumeroF, chk_4c_Imagem,
743:     *     chk_4c_Reimp, opt_4c_Agrupa (2 botoes), checkboxes de filtro,
744:     *     cmd_4c_SelecionarTodas, cmd_4c_DesmarcarTodas + 6 labels.
745:     *--------------------------------------------------------------------------
746:     PROTECTED PROCEDURE ConfigurarPaginaDados()
747:         LOCAL loc_oPagina, loc_oErro, loc_lOk
748:         loc_lOk = .F.
749:         TRY

*-- Linhas 1178 a 1196:
1178:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1179:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
1180:                 WITH THIS.this_oRelatorio
1181:                     loc_oPg.txt_4c_Dopes.Value          = .this_cDopes
1182:                     IF !EMPTY(.this_dDtInicial)
1183:                         loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
1184:                     ENDIF
1185:                     IF !EMPTY(.this_dDtFinal)
1186:                         loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
1187:                     ENDIF
1188:                     loc_oPg.txt_4c_NumeroI.Value        = .this_nOperacaoI
1189:                     loc_oPg.txt_4c_NumeroF.Value        = .this_nOperacaoF
1190:                     loc_oPg.chk_4c_Reimp.Value          = .this_nReimp
1191:                     loc_oPg.opt_4c_Agrupa.Value         = .this_nAgrupa
1192:                     loc_oPg.chk_4c_Imagem.Value         = IIF(.this_lImagem, 1, 0)
1193:                     loc_oPg.chk_4c_ItensPendentes.Value = IIF(.this_lItensPendentes, 1, 0)
1194:                 ENDWITH
1195:                 THIS.AtualizarEstadoFiltros()
1196:             ENDIF

