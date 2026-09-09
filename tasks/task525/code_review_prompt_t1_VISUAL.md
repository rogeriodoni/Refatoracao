# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 412: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 435: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSRV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4068 linhas total):

*-- Linhas 56 a 66:
56: 
57:                 *-- Caption dinamico conforme o tipo de servico (legado: ThisForm.Caption)
58:                 IF THIS.this_cTipoServico = "E"
59:                     THIS.Caption = "Servi" + CHR(231) + "os de Entradas"
60:                 ELSE
61:                     THIS.Caption = "Servi" + CHR(231) + "os de Sa" + CHR(237) + "das"
62:                 ENDIF
63: 
64:                 THIS.ConfigurarPageFrame()
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 88 a 107:
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page1.BackColor = RGB(255, 255, 255)
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()

*-- Linhas 122 a 160:
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         loc_oCab = loc_oPagina.cnt_4c_Cabecalho
124:         WITH loc_oCab
125:             .Top         = 31
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackColor   = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oCab.lbl_4c_Sombra
136:             .AutoSize  = .F.
137:             .Caption   = THIS.Caption
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = THIS.Width
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oCab.lbl_4c_Titulo
152:             .AutoSize  = .F.
153:             .Caption   = THIS.Caption
154:             .Top       = 18
155:             .Left      = 10
156:             .Width     = THIS.Width
157:             .Height    = 46
158:             .FontName  = "Tahoma"
159:             .FontSize  = 16
160:             .FontBold  = .T.

*-- Linhas 168 a 192:
168:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
169:         loc_oBotoes = loc_oPagina.cnt_4c_Botoes
170:         WITH loc_oBotoes
171:             .Top         = 29
172:             .Left        = 542
173:             .Width       = 390
174:             .Height      = 85
175:             .BackColor   = RGB(53, 53, 53)
176:             .BackStyle   = 1
177:             .BorderWidth = 0
178:             .Visible     = .T.
179:         ENDWITH
180: 
181:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH loc_oBotoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .Top             = 5
187:             .Left            = 5
188:             .Width           = 75
189:             .Height          = 75
190:             .BackColor       = RGB(255, 255, 255)
191:             .ForeColor       = RGB(90, 90, 90)
192:             .FontName        = "Tahoma"

*-- Linhas 201 a 215:
201:             .Visible         = .T.
202:         ENDWITH
203: 
204:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
205:         WITH loc_oBotoes.cmd_4c_Visualizar
206:             .Caption         = "Visualizar"
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
208:             .PicturePosition = 13
209:             .Top             = 5
210:             .Left            = 80
211:             .Width           = 75
212:             .Height          = 75
213:             .BackColor       = RGB(255, 255, 255)
214:             .ForeColor       = RGB(90, 90, 90)
215:             .FontName        = "Tahoma"

*-- Linhas 224 a 238:
224:             .Visible         = .T.
225:         ENDWITH
226: 
227:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH loc_oBotoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
231:             .PicturePosition = 13
232:             .Top             = 5
233:             .Left            = 155
234:             .Width           = 75
235:             .Height          = 75
236:             .BackColor       = RGB(255, 255, 255)
237:             .ForeColor       = RGB(90, 90, 90)
238:             .FontName        = "Tahoma"

*-- Linhas 247 a 261:
247:             .Visible         = .T.
248:         ENDWITH
249: 
250:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
251:         WITH loc_oBotoes.cmd_4c_Excluir
252:             .Caption         = "Excluir"
253:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
254:             .PicturePosition = 13
255:             .Top             = 5
256:             .Left            = 230
257:             .Width           = 75
258:             .Height          = 75
259:             .BackColor       = RGB(255, 255, 255)
260:             .ForeColor       = RGB(90, 90, 90)
261:             .FontName        = "Tahoma"

*-- Linhas 270 a 284:
270:             .Visible         = .T.
271:         ENDWITH
272: 
273:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oBotoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .Top             = 5
279:             .Left            = 305
280:             .Width           = 75
281:             .Height          = 75
282:             .BackColor       = RGB(255, 255, 255)
283:             .ForeColor       = RGB(90, 90, 90)
284:             .FontName        = "Tahoma"

*-- Linhas 293 a 326:
293:             .Visible         = .T.
294:         ENDWITH
295: 
296:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
297:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
298:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
299:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
300:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
301: 
302:         *-- Container Encerrar (canonico CLAUDE.md #10: Left=917, Width=90)
303:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
304:         loc_oSaida = loc_oPagina.cnt_4c_Saida
305:         WITH loc_oSaida
306:             .Top         = 29
307:             .Left        = 917
308:             .Width       = 90
309:             .Height      = 85
310:             .BackStyle   = 0
311:             .BorderWidth = 0
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oSaida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .BackColor       = RGB(255, 255, 255)
325:             .ForeColor       = RGB(90, 90, 90)
326:             .FontName        = "Tahoma"

*-- Linhas 335 a 352:
335:             .Visible         = .T.
336:         ENDWITH
337: 
338:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
339: 
340:         *-- Grid lista: codservs (Codigo) + descservs (Descricao)
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oPagina.grd_4c_Lista.RecordSource = ""
343:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
344: 
345:         WITH loc_oPagina.grd_4c_Lista
346:             .Top                     = 117
347:             .Left                    = 12
348:             .Width                   = 890
349:             .Height                  = 480
350:             .FontName                = "Verdana"
351:             .FontSize                = 8
352:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 366 a 375:
366:             .Column2.Width           = 760
367:             .Column1.ReadOnly        = .T.
368:             .Column2.ReadOnly        = .T.
369:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
370:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
371:         ENDWITH
372: 
373:         THIS.TornarControlesVisiveis(loc_oPagina)
374:     ENDPROC
375: 

*-- Linhas 388 a 471:
388:         *-- Compensacao PageFrame +29: Top=33 (4+29), Left=842
389:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
390:         WITH loc_oPagina.cnt_4c_BotoesAcao
391:             .Top         = 33
392:             .Left        = 842
393:             .Width       = 160
394:             .Height      = 85
395:             .BackStyle = 1
396:             .BackColor   = RGB(255, 255, 255)
397:             .BorderWidth = 0
398:             .Visible     = .T.
399:         ENDWITH
400: 
401:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
402:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
403:             .Caption         = "Confirmar"
404:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
405:             .PicturePosition = 13
406:             .Top             = 5
407:             .Left            = 5
408:             .Width           = 75
409:             .Height          = 75
410:             .BackColor       = RGB(255, 255, 255)
411:             .ForeColor       = RGB(90, 90, 90)
412:             .FontName        = "Comic Sans MS"
413:             .FontSize        = 8
414:             .FontBold        = .T.
415:             .FontItalic      = .T.
416:             .Themes          = .F.
417:             .SpecialEffect   = 0
418:             .MousePointer    = 15
419:             .WordWrap        = .T.
420:             .AutoSize        = .F.
421:             .Visible         = .T.
422:         ENDWITH
423: 
424:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
425:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
426:             .Caption         = "Encerrar"
427:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
428:             .PicturePosition = 13
429:             .Top             = 5
430:             .Left            = 80
431:             .Width           = 75
432:             .Height          = 75
433:             .BackColor       = RGB(255, 255, 255)
434:             .ForeColor       = RGB(90, 90, 90)
435:             .FontName        = "Comic Sans MS"
436:             .FontSize        = 8
437:             .FontBold        = .T.
438:             .FontItalic      = .T.
439:             .Themes          = .F.
440:             .SpecialEffect   = 0
441:             .MousePointer    = 15
442:             .WordWrap        = .T.
443:             .AutoSize        = .F.
444:             .Visible         = .T.
445:         ENDWITH
446: 
447:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
448:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
449: 
450:         *-- PageFrame interno (legado: pgDados - Top=132,Left=29,Width=740,Height=417)
451:         *-- Compensacao PageFrame externo +29: Top=161
452:         *-- Abas visiveis (Tabs=.T.) para o usuario navegar Impostos/Vencimentos/Retencao
453:         loc_oPagina.AddObject("pgf_4c_1", "PageFrame")
454:         WITH loc_oPagina.pgf_4c_1
455:             .PageCount = 3
456:             .Top       = 161
457:             .Left      = 29
458:             .Width     = 740
459:             .Height    = 417
460:             .Visible   = .T.
461: 
462:             .Page1.Caption   = "Impostos"
463:             .Page1.BackColor = RGB(255, 255, 255)
464:             .Page2.Caption   = "Vencimentos"
465:             .Page2.BackColor = RGB(255, 255, 255)
466:             .Page3.Caption   = "Reten" + CHR(231) + CHR(227) + "o"
467:             .Page3.BackColor = RGB(255, 255, 255)
468:         ENDWITH
469: 
470:         THIS.ConfigurarAbaImpostos()
471:         THIS.ConfigurarAbaVencimentos()

*-- Linhas 490 a 526:
490:         *-- Moldura geral da aba
491:         loc_oAba.AddObject("shp_4c_Shape2", "Shape")
492:         WITH loc_oAba.shp_4c_Shape2
493:             .Top         = 1
494:             .Left        = 8
495:             .Width       = 721
496:             .Height      = 331
497:             .BorderColor = RGB(0, 0, 0)
498:             .BorderStyle = 1
499:             .Visible     = .T.
500:         ENDWITH
501: 
502:         *-- Codigo / Descricao
503:         loc_oAba.AddObject("lbl_4c_Label3", "Label")
504:         WITH loc_oAba.lbl_4c_Label3
505:             .Caption   = "C" + CHR(243) + "digo :"
506:             .Top       = 16
507:             .Left      = 44
508:             .Width     = 54
509:             .Height    = 15
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .BackStyle = 0
513:             .ForeColor = RGB(0, 0, 0)
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         loc_oAba.AddObject("txt_4c_Codigos", "TextBox")
518:         WITH loc_oAba.txt_4c_Codigos
519:             .Value         = ""
520:             .Top           = 11
521:             .Left          = 92
522:             .Width         = 80
523:             .Height        = 23
524:             .MaxLength     = 10
525:             .FontName      = "Tahoma"
526:             .FontSize      = 8

*-- Linhas 532 a 1512:
532:         loc_oAba.AddObject("txt_4c_Descricao", "TextBox")
533:         WITH loc_oAba.txt_4c_Descricao
534:             .Value         = ""
535:             .Top           = 11
536:             .Left          = 173
537:             .Width         = 324
538:             .Height        = 23
539:             .MaxLength     = 40
540:             .FontName      = "Tahoma"
541:             .FontSize      = 8
542:             .SpecialEffect = 1
543:             .BorderColor   = RGB(100, 100, 100)
544:             .Visible       = .T.
545:         ENDWITH
546: 
547:         *-- Aliquotas (%)
548:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
549:         WITH loc_oAba.lbl_4c_Label6
550:             .Caption   = "Al" + CHR(237) + "quotas"
551:             .Top       = 36
552:             .Left      = 20
553:             .Width     = 63
554:             .Height    = 15
555:             .FontName  = "Tahoma"
556:             .FontSize  = 8
557:             .FontBold  = .T.
558:             .BackStyle = 0
559:             .ForeColor = RGB(0, 0, 0)
560:             .Visible   = .T.
561:         ENDWITH
562: 
563:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
564:         WITH loc_oAba.shp_4c_Shape1
565:             .Top         = 44
566:             .Left        = 13
567:             .Width       = 712
568:             .Height      = 37
569:             .BorderColor = RGB(0, 0, 0)
570:             .BorderStyle = 1
571:             .Visible     = .T.
572:         ENDWITH
573: 
574:         loc_oAba.AddObject("lbl_4c_Label1", "Label")
575:         WITH loc_oAba.lbl_4c_Label1
576:             .Caption   = "% ISS :"
577:             .Top       = 56
578:             .Left      = 19
579:             .Width     = 50
580:             .Height    = 15
581:             .FontName  = "Tahoma"
582:             .FontSize  = 8
583:             .BackStyle = 0
584:             .ForeColor = RGB(0, 0, 0)
585:             .Visible   = .T.
586:         ENDWITH
587: 
588:         loc_oAba.AddObject("txt_4c__ISS", "TextBox")
589:         WITH loc_oAba.txt_4c__ISS
590:             .Value         = 0
591:             .Top           = 52
592:             .Left          = 61
593:             .Width         = 50
594:             .Height        = 23
595:             .Format        = "999.99"
596:             .InputMask     = "999.99"
597:             .FontName      = "Tahoma"
598:             .FontSize      = 8
599:             .SpecialEffect = 1
600:             .BorderColor   = RGB(100, 100, 100)
601:             .Visible       = .T.
602:         ENDWITH
603: 
604:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
605:         WITH loc_oAba.lbl_4c_Label2
606:             .Caption   = "% PIS :"
607:             .Top       = 56
608:             .Left      = 126
609:             .Width     = 50
610:             .Height    = 15
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .BackStyle = 0
614:             .ForeColor = RGB(0, 0, 0)
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         loc_oAba.AddObject("txt_4c__PIS", "TextBox")
619:         WITH loc_oAba.txt_4c__PIS
620:             .Value         = 0
621:             .Top           = 53
622:             .Left          = 168
623:             .Width         = 50
624:             .Height        = 22
625:             .Format        = "99.99"
626:             .InputMask     = "99.99"
627:             .FontName      = "Tahoma"
628:             .FontSize      = 8
629:             .SpecialEffect = 1
630:             .BorderColor   = RGB(100, 100, 100)
631:             .Visible       = .T.
632:         ENDWITH
633: 
634:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
635:         WITH loc_oAba.lbl_4c_Label4
636:             .Caption   = "% COFINS :"
637:             .Top       = 57
638:             .Left      = 234
639:             .Width     = 76
640:             .Height    = 15
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .BackStyle = 0
644:             .ForeColor = RGB(0, 0, 0)
645:             .Visible   = .T.
646:         ENDWITH
647: 
648:         loc_oAba.AddObject("txt_4c__COFINS", "TextBox")
649:         WITH loc_oAba.txt_4c__COFINS
650:             .Value         = 0
651:             .Top           = 53
652:             .Left          = 303
653:             .Width         = 50
654:             .Height        = 22
655:             .Format        = "99.99"
656:             .InputMask     = "99.99"
657:             .FontName      = "Tahoma"
658:             .FontSize      = 8
659:             .SpecialEffect = 1
660:             .BorderColor   = RGB(100, 100, 100)
661:             .Visible       = .T.
662:         ENDWITH
663: 
664:         loc_oAba.AddObject("lbl_4c_Label5", "Label")
665:         WITH loc_oAba.lbl_4c_Label5
666:             .Caption   = "% IRRF :"
667:             .Top       = 57
668:             .Left      = 373
669:             .Width     = 58
670:             .Height    = 15
671:             .FontName  = "Tahoma"
672:             .FontSize  = 8
673:             .BackStyle = 0
674:             .ForeColor = RGB(0, 0, 0)
675:             .Visible   = .T.
676:         ENDWITH
677: 
678:         loc_oAba.AddObject("txt_4c__IRRF", "TextBox")
679:         WITH loc_oAba.txt_4c__IRRF
680:             .Value         = 0
681:             .Top           = 53
682:             .Left          = 423
683:             .Width         = 50
684:             .Height        = 22
685:             .Format        = "99.99"
686:             .InputMask     = "99.99"
687:             .FontName      = "Tahoma"
688:             .FontSize      = 8
689:             .SpecialEffect = 1
690:             .BorderColor   = RGB(100, 100, 100)
691:             .Visible       = .T.
692:         ENDWITH
693: 
694:         loc_oAba.AddObject("lbl_4c_Label7", "Label")
695:         WITH loc_oAba.lbl_4c_Label7
696:             .Caption   = "% INSS :"
697:             .Top       = 57
698:             .Left      = 491
699:             .Width     = 59
700:             .Height    = 15
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .BackStyle = 0
704:             .ForeColor = RGB(0, 0, 0)
705:             .Visible   = .T.
706:         ENDWITH
707: 
708:         loc_oAba.AddObject("txt_4c__INSS", "TextBox")
709:         WITH loc_oAba.txt_4c__INSS
710:             .Value         = 0
711:             .Top           = 53
712:             .Left          = 544
713:             .Width         = 50
714:             .Height        = 22
715:             .Format        = "99.99"
716:             .InputMask     = "99.99"
717:             .FontName      = "Tahoma"
718:             .FontSize      = 8
719:             .SpecialEffect = 1
720:             .BorderColor   = RGB(100, 100, 100)
721:             .Visible       = .T.
722:         ENDWITH
723: 
724:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
725:         WITH loc_oAba.lbl_4c_Label8
726:             .Caption   = "% CSLL :"
727:             .Top       = 57
728:             .Left      = 609
729:             .Width     = 58
730:             .Height    = 15
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .BackStyle = 0
734:             .ForeColor = RGB(0, 0, 0)
735:             .Visible   = .T.
736:         ENDWITH
737: 
738:         loc_oAba.AddObject("txt_4c__CSLL", "TextBox")
739:         WITH loc_oAba.txt_4c__CSLL
740:             .Value         = 0
741:             .Top           = 53
742:             .Left          = 661
743:             .Width         = 50
744:             .Height        = 22
745:             .Format        = "99.99"
746:             .InputMask     = "99.99"
747:             .FontName      = "Tahoma"
748:             .FontSize      = 8
749:             .SpecialEffect = 1
750:             .BorderColor   = RGB(100, 100, 100)
751:             .Visible       = .T.
752:         ENDWITH
753: 
754:         *-- Valores Minimos a recolher
755:         loc_oAba.AddObject("lbl_4c_Label25", "Label")
756:         WITH loc_oAba.lbl_4c_Label25
757:             .Caption   = "Valores M" + CHR(237) + "nimos " + CHR(224) + " recolher"
758:             .Top       = 85
759:             .Left      = 20
760:             .Width     = 179
761:             .Height    = 15
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .FontBold  = .T.
765:             .BackStyle = 0
766:             .ForeColor = RGB(0, 0, 0)
767:             .Visible   = .T.
768:         ENDWITH
769: 
770:         loc_oAba.AddObject("shp_4c_Shape7", "Shape")
771:         WITH loc_oAba.shp_4c_Shape7
772:             .Top         = 93
773:             .Left        = 13
774:             .Width       = 712
775:             .Height      = 37
776:             .BorderColor = RGB(0, 0, 0)
777:             .BorderStyle = 1
778:             .Visible     = .T.
779:         ENDWITH
780: 
781:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
782:         WITH loc_oAba.lbl_4c_Label10
783:             .Caption   = "PIS :"
784:             .Top       = 106
785:             .Left      = 21
786:             .Width     = 32
787:             .Height    = 15
788:             .FontName  = "Tahoma"
789:             .FontSize  = 8
790:             .BackStyle = 0
791:             .ForeColor = RGB(0, 0, 0)
792:             .Visible   = .T.
793:         ENDWITH
794: 
795:         loc_oAba.AddObject("txt_4c__VMinPis", "TextBox")
796:         WITH loc_oAba.txt_4c__VMinPis
797:             .Value         = 0
798:             .Top           = 102
799:             .Left          = 48
800:             .Width         = 90
801:             .Height        = 22
802:             .Format        = "999999999.99"
803:             .FontName      = "Tahoma"
804:             .FontSize      = 8
805:             .SpecialEffect = 1
806:             .BorderColor   = RGB(100, 100, 100)
807:             .Visible       = .T.
808:         ENDWITH
809: 
810:         loc_oAba.AddObject("lbl_4c_Label11", "Label")
811:         WITH loc_oAba.lbl_4c_Label11
812:             .Caption   = "COFINS :"
813:             .Top       = 106
814:             .Left      = 161
815:             .Width     = 58
816:             .Height    = 15
817:             .FontName  = "Tahoma"
818:             .FontSize  = 8
819:             .BackStyle = 0
820:             .ForeColor = RGB(0, 0, 0)
821:             .Visible   = .T.
822:         ENDWITH
823: 
824:         loc_oAba.AddObject("txt_4c__VMinCofins", "TextBox")
825:         WITH loc_oAba.txt_4c__VMinCofins
826:             .Value         = 0
827:             .Top           = 102
828:             .Left          = 212
829:             .Width         = 90
830:             .Height        = 22
831:             .Format        = "999999999.99"
832:             .FontName      = "Tahoma"
833:             .FontSize      = 8
834:             .SpecialEffect = 1
835:             .BorderColor   = RGB(100, 100, 100)
836:             .Visible       = .T.
837:         ENDWITH
838: 
839:         loc_oAba.AddObject("lbl_4c_Label12", "Label")
840:         WITH loc_oAba.lbl_4c_Label12
841:             .Caption   = "IRRF :"
842:             .Top       = 106
843:             .Left      = 314
844:             .Width     = 40
845:             .Height    = 15
846:             .FontName  = "Tahoma"
847:             .FontSize  = 8
848:             .BackStyle = 0
849:             .ForeColor = RGB(0, 0, 0)
850:             .Visible   = .T.
851:         ENDWITH
852: 
853:         loc_oAba.AddObject("txt_4c__VMinIrrf", "TextBox")
854:         WITH loc_oAba.txt_4c__VMinIrrf
855:             .Value         = 0
856:             .Top           = 102
857:             .Left          = 348
858:             .Width         = 90
859:             .Height        = 22
860:             .Format        = "999999999.99"
861:             .FontName      = "Tahoma"
862:             .FontSize      = 8
863:             .SpecialEffect = 1
864:             .BorderColor   = RGB(100, 100, 100)
865:             .Visible       = .T.
866:         ENDWITH
867: 
868:         loc_oAba.AddObject("lbl_4c_Label13", "Label")
869:         WITH loc_oAba.lbl_4c_Label13
870:             .Caption   = "INSS :"
871:             .Top       = 106
872:             .Left      = 451
873:             .Width     = 41
874:             .Height    = 15
875:             .FontName  = "Tahoma"
876:             .FontSize  = 8
877:             .BackStyle = 0
878:             .ForeColor = RGB(0, 0, 0)
879:             .Visible   = .T.
880:         ENDWITH
881: 
882:         loc_oAba.AddObject("txt_4c__VMinInss", "TextBox")
883:         WITH loc_oAba.txt_4c__VMinInss
884:             .Value         = 0
885:             .Top           = 102
886:             .Left          = 487
887:             .Width         = 90
888:             .Height        = 22
889:             .Format        = "999999999.99"
890:             .FontName      = "Tahoma"
891:             .FontSize      = 8
892:             .SpecialEffect = 1
893:             .BorderColor   = RGB(100, 100, 100)
894:             .Visible       = .T.
895:         ENDWITH
896: 
897:         loc_oAba.AddObject("lbl_4c_Label14", "Label")
898:         WITH loc_oAba.lbl_4c_Label14
899:             .Caption   = "CSLL :"
900:             .Top       = 107
901:             .Left      = 586
902:             .Width     = 40
903:             .Height    = 15
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .BackStyle = 0
907:             .ForeColor = RGB(0, 0, 0)
908:             .Visible   = .T.
909:         ENDWITH
910: 
911:         loc_oAba.AddObject("txt_4c__VMinCsll", "TextBox")
912:         WITH loc_oAba.txt_4c__VMinCsll
913:             .Value         = 0
914:             .Top           = 102
915:             .Left          = 621
916:             .Width         = 90
917:             .Height        = 22
918:             .Format        = "999999999.99"
919:             .FontName      = "Tahoma"
920:             .FontSize      = 8
921:             .SpecialEffect = 1
922:             .BorderColor   = RGB(100, 100, 100)
923:             .Visible       = .T.
924:         ENDWITH
925: 
926:         *-- Base de calculo minima
927:         loc_oAba.AddObject("lbl_4c_Label28", "Label")
928:         WITH loc_oAba.lbl_4c_Label28
929:             .Caption   = "Base de c" + CHR(225) + "lculo m" + CHR(237) + "nima"
930:             .Top       = 138
931:             .Left      = 20
932:             .Width     = 155
933:             .Height    = 15
934:             .FontName  = "Tahoma"
935:             .FontSize  = 8
936:             .FontBold  = .T.
937:             .BackStyle = 0
938:             .ForeColor = RGB(0, 0, 0)
939:             .Visible   = .T.
940:         ENDWITH
941: 
942:         loc_oAba.AddObject("shp_4c_Shape4", "Shape")
943:         WITH loc_oAba.shp_4c_Shape4
944:             .Top         = 146
945:             .Left        = 13
946:             .Width       = 712
947:             .Height      = 54
948:             .BorderColor = RGB(0, 0, 0)
949:             .BorderStyle = 1
950:             .Visible     = .T.
951:         ENDWITH
952: 
953:         loc_oAba.AddObject("lbl_4c_Label24", "Label")
954:         WITH loc_oAba.lbl_4c_Label24
955:             .Caption   = "PIS :"
956:             .Top       = 158
957:             .Left      = 21
958:             .Width     = 32
959:             .Height    = 15
960:             .FontName  = "Tahoma"
961:             .FontSize  = 8
962:             .BackStyle = 0
963:             .ForeColor = RGB(0, 0, 0)
964:             .Visible   = .T.
965:         ENDWITH
966: 
967:         loc_oAba.AddObject("txt_4c__VMinBPis", "TextBox")
968:         WITH loc_oAba.txt_4c__VMinBPis
969:             .Value         = 0
970:             .Top           = 155
971:             .Left          = 48
972:             .Width         = 90
973:             .Height        = 22
974:             .Format        = "999999999.99"
975:             .FontName      = "Tahoma"
976:             .FontSize      = 8
977:             .SpecialEffect = 1
978:             .BorderColor   = RGB(100, 100, 100)
979:             .Visible       = .T.
980:         ENDWITH
981: 
982:         loc_oAba.AddObject("chk_4c_Chk_bpisms", "CheckBox")
983:         WITH loc_oAba.chk_4c_Chk_bpisms
984:             .Caption   = "Mensal"
985:             .Top       = 180
986:             .Left      = 48
987:             .Width     = 64
988:             .Height    = 15
989:             .Value     = 0
990:             .FontName  = "Tahoma"
991:             .FontSize  = 8
992:             .BackStyle = 0
993:             .ForeColor = RGB(0, 0, 0)
994:             .Themes    = .F.
995:             .Visible   = .T.
996:         ENDWITH
997: 
998:         loc_oAba.AddObject("lbl_4c_Label22", "Label")
999:         WITH loc_oAba.lbl_4c_Label22
1000:             .Caption   = "COFINS :"
1001:             .Top       = 159
1002:             .Left      = 161
1003:             .Width     = 58
1004:             .Height    = 15
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:             .BackStyle = 0
1008:             .ForeColor = RGB(0, 0, 0)
1009:             .Visible   = .T.
1010:         ENDWITH
1011: 
1012:         loc_oAba.AddObject("txt_4c__VMinBCofins", "TextBox")
1013:         WITH loc_oAba.txt_4c__VMinBCofins
1014:             .Value         = 0
1015:             .Top           = 155
1016:             .Left          = 212
1017:             .Width         = 90
1018:             .Height        = 22
1019:             .Format        = "999999999.99"
1020:             .FontName      = "Tahoma"
1021:             .FontSize      = 8
1022:             .SpecialEffect = 1
1023:             .BorderColor   = RGB(100, 100, 100)
1024:             .Visible       = .T.
1025:         ENDWITH
1026: 
1027:         loc_oAba.AddObject("chk_4c_Chk_bcofinms", "CheckBox")
1028:         WITH loc_oAba.chk_4c_Chk_bcofinms
1029:             .Caption   = "Mensal"
1030:             .Top       = 180
1031:             .Left      = 212
1032:             .Width     = 64
1033:             .Height    = 15
1034:             .Value     = 0
1035:             .FontName  = "Tahoma"
1036:             .FontSize  = 8
1037:             .BackStyle = 0
1038:             .ForeColor = RGB(0, 0, 0)
1039:             .Themes    = .F.
1040:             .Visible   = .T.
1041:         ENDWITH
1042: 
1043:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
1044:         WITH loc_oAba.lbl_4c_Label20
1045:             .Caption   = "IRRF :"
1046:             .Top       = 159
1047:             .Left      = 314
1048:             .Width     = 40
1049:             .Height    = 15
1050:             .FontName  = "Tahoma"
1051:             .FontSize  = 8
1052:             .BackStyle = 0
1053:             .ForeColor = RGB(0, 0, 0)
1054:             .Visible   = .T.
1055:         ENDWITH
1056: 
1057:         loc_oAba.AddObject("txt_4c__VMinBIrrf", "TextBox")
1058:         WITH loc_oAba.txt_4c__VMinBIrrf
1059:             .Value         = 0
1060:             .Top           = 155
1061:             .Left          = 348
1062:             .Width         = 90
1063:             .Height        = 22
1064:             .Format        = "999999999.99"
1065:             .FontName      = "Tahoma"
1066:             .FontSize      = 8
1067:             .SpecialEffect = 1
1068:             .BorderColor   = RGB(100, 100, 100)
1069:             .Visible       = .T.
1070:         ENDWITH
1071: 
1072:         loc_oAba.AddObject("chk_4c_Chk_birrfms", "CheckBox")
1073:         WITH loc_oAba.chk_4c_Chk_birrfms
1074:             .Caption   = "Mensal"
1075:             .Top       = 180
1076:             .Left      = 348
1077:             .Width     = 64
1078:             .Height    = 15
1079:             .Value     = 0
1080:             .FontName  = "Tahoma"
1081:             .FontSize  = 8
1082:             .BackStyle = 0
1083:             .ForeColor = RGB(0, 0, 0)
1084:             .Themes    = .F.
1085:             .Visible   = .T.
1086:         ENDWITH
1087: 
1088:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
1089:         WITH loc_oAba.lbl_4c_Label18
1090:             .Caption   = "INSS :"
1091:             .Top       = 159
1092:             .Left      = 451
1093:             .Width     = 41
1094:             .Height    = 15
1095:             .FontName  = "Tahoma"
1096:             .FontSize  = 8
1097:             .BackStyle = 0
1098:             .ForeColor = RGB(0, 0, 0)
1099:             .Visible   = .T.
1100:         ENDWITH
1101: 
1102:         loc_oAba.AddObject("txt_4c__VMinBInss", "TextBox")
1103:         WITH loc_oAba.txt_4c__VMinBInss
1104:             .Value         = 0
1105:             .Top           = 155
1106:             .Left          = 487
1107:             .Width         = 90
1108:             .Height        = 22
1109:             .Format        = "999999999.99"
1110:             .FontName      = "Tahoma"
1111:             .FontSize      = 8
1112:             .SpecialEffect = 1
1113:             .BorderColor   = RGB(100, 100, 100)
1114:             .Visible       = .T.
1115:         ENDWITH
1116: 
1117:         loc_oAba.AddObject("chk_4c_Chk_binssms", "CheckBox")
1118:         WITH loc_oAba.chk_4c_Chk_binssms
1119:             .Caption   = "Mensal"
1120:             .Top       = 180
1121:             .Left      = 487
1122:             .Width     = 64
1123:             .Height    = 15
1124:             .Value     = 0
1125:             .FontName  = "Tahoma"
1126:             .FontSize  = 8
1127:             .BackStyle = 0
1128:             .ForeColor = RGB(0, 0, 0)
1129:             .Themes    = .F.
1130:             .Visible   = .T.
1131:         ENDWITH
1132: 
1133:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
1134:         WITH loc_oAba.lbl_4c_Label16
1135:             .Caption   = "CSLL :"
1136:             .Top       = 159
1137:             .Left      = 586
1138:             .Width     = 40
1139:             .Height    = 15
1140:             .FontName  = "Tahoma"
1141:             .FontSize  = 8
1142:             .BackStyle = 0
1143:             .ForeColor = RGB(0, 0, 0)
1144:             .Visible   = .T.
1145:         ENDWITH
1146: 
1147:         loc_oAba.AddObject("txt_4c__vMinBCsll", "TextBox")
1148:         WITH loc_oAba.txt_4c__vMinBCsll
1149:             .Value         = 0
1150:             .Top           = 155
1151:             .Left          = 621
1152:             .Width         = 90
1153:             .Height        = 22
1154:             .Format        = "999999999.99"
1155:             .FontName      = "Tahoma"
1156:             .FontSize      = 8
1157:             .SpecialEffect = 1
1158:             .BorderColor   = RGB(100, 100, 100)
1159:             .Visible       = .T.
1160:         ENDWITH
1161: 
1162:         loc_oAba.AddObject("chk_4c_Chk_bcsllms", "CheckBox")
1163:         WITH loc_oAba.chk_4c_Chk_bcsllms
1164:             .Caption   = "Mensal"
1165:             .Top       = 180
1166:             .Left      = 621
1167:             .Width     = 64
1168:             .Height    = 15
1169:             .Value     = 0
1170:             .FontName  = "Tahoma"
1171:             .FontSize  = 8
1172:             .BackStyle = 0
1173:             .ForeColor = RGB(0, 0, 0)
1174:             .Themes    = .F.
1175:             .Visible   = .T.
1176:         ENDWITH
1177: 
1178:         *-- Lancamento Financeiro
1179:         loc_oAba.AddObject("lbl_4c_Label26", "Label")
1180:         WITH loc_oAba.lbl_4c_Label26
1181:             .Caption   = "Lan" + CHR(231) + "amento Financeiro"
1182:             .Top       = 201
1183:             .Left      = 20
1184:             .Width     = 154
1185:             .Height    = 15
1186:             .FontName  = "Tahoma"
1187:             .FontSize  = 8
1188:             .FontBold  = .T.
1189:             .BackStyle = 0
1190:             .ForeColor = RGB(0, 0, 0)
1191:             .Visible   = .T.
1192:         ENDWITH
1193: 
1194:         loc_oAba.AddObject("shp_4c_Shape3", "Shape")
1195:         WITH loc_oAba.shp_4c_Shape3
1196:             .Top         = 209
1197:             .Left        = 13
1198:             .Width       = 712
1199:             .Height      = 31
1200:             .BorderColor = RGB(0, 0, 0)
1201:             .BorderStyle = 1
1202:             .Visible     = .T.
1203:         ENDWITH
1204: 
1205:         loc_oAba.AddObject("chk_4c_Chk_LancFinPis", "CheckBox")
1206:         WITH loc_oAba.chk_4c_Chk_LancFinPis
1207:             .Caption   = "PIS"
1208:             .Top       = 217
1209:             .Left      = 27
1210:             .Width     = 41
1211:             .Height    = 15
1212:             .Value     = 0
1213:             .FontName  = "Tahoma"
1214:             .FontSize  = 8
1215:             .BackStyle = 0
1216:             .ForeColor = RGB(0, 0, 0)
1217:             .Themes    = .F.
1218:             .Visible   = .T.
1219:         ENDWITH
1220: 
1221:         loc_oAba.AddObject("chk_4c_Ck_LancFinCofins", "CheckBox")
1222:         WITH loc_oAba.chk_4c_Ck_LancFinCofins
1223:             .Caption   = "COFINS"
1224:             .Top       = 217
1225:             .Left      = 138
1226:             .Width     = 67
1227:             .Height    = 15
1228:             .Value     = 0
1229:             .FontName  = "Tahoma"
1230:             .FontSize  = 8
1231:             .BackStyle = 0
1232:             .ForeColor = RGB(0, 0, 0)
1233:             .Themes    = .F.
1234:             .Visible   = .T.
1235:         ENDWITH
1236: 
1237:         loc_oAba.AddObject("chk_4c_Ck_LancFinIrrf", "CheckBox")
1238:         WITH loc_oAba.chk_4c_Ck_LancFinIrrf
1239:             .Caption   = "IRRF"
1240:             .Top       = 217
1241:             .Left      = 279
1242:             .Width     = 49
1243:             .Height    = 15
1244:             .Value     = 0
1245:             .FontName  = "Tahoma"
1246:             .FontSize  = 8
1247:             .BackStyle = 0
1248:             .ForeColor = RGB(0, 0, 0)
1249:             .Themes    = .F.
1250:             .Visible   = .T.
1251:         ENDWITH
1252: 
1253:         loc_oAba.AddObject("chk_4c_Ck_LancFinCsll", "CheckBox")
1254:         WITH loc_oAba.chk_4c_Ck_LancFinCsll
1255:             .Caption   = "CSLL"
1256:             .Top       = 217
1257:             .Left      = 526
1258:             .Width     = 49
1259:             .Height    = 15
1260:             .Value     = 0
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .BackStyle = 0
1264:             .ForeColor = RGB(0, 0, 0)
1265:             .Themes    = .F.
1266:             .Visible   = .T.
1267:         ENDWITH
1268: 
1269:         loc_oAba.AddObject("chk_4c_Ck_LancFinInss", "CheckBox")
1270:         WITH loc_oAba.chk_4c_Ck_LancFinInss
1271:             .Caption   = "INSS"
1272:             .Top       = 217
1273:             .Left      = 409
1274:             .Width     = 50
1275:             .Height    = 15
1276:             .Value     = 0
1277:             .FontName  = "Tahoma"
1278:             .FontSize  = 8
1279:             .BackStyle = 0
1280:             .ForeColor = RGB(0, 0, 0)
1281:             .Themes    = .F.
1282:             .Visible   = .T.
1283:         ENDWITH
1284: 
1285:         loc_oAba.AddObject("chk_4c_Ck_LancFinIss", "CheckBox")
1286:         WITH loc_oAba.chk_4c_Ck_LancFinIss
1287:             .Caption   = "ISS"
1288:             .Top       = 217
1289:             .Left      = 645
1290:             .Width     = 41
1291:             .Height    = 15
1292:             .Value     = 0
1293:             .FontName  = "Tahoma"
1294:             .FontSize  = 8
1295:             .BackStyle = 0
1296:             .ForeColor = RGB(0, 0, 0)
1297:             .Themes    = .F.
1298:             .Visible   = .T.
1299:         ENDWITH
1300: 
1301:         *-- Ocorrencias
1302:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
1303:         WITH loc_oAba.lbl_4c_Label27
1304:             .Caption   = "Ocorr" + CHR(234) + "ncias"
1305:             .Top       = 250
1306:             .Left      = 20
1307:             .Width     = 80
1308:             .Height    = 15
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8
1311:             .FontBold  = .T.
1312:             .BackStyle = 0
1313:             .ForeColor = RGB(0, 0, 0)
1314:             .Visible   = .T.
1315:         ENDWITH
1316: 
1317:         loc_oAba.AddObject("shp_4c_Shape8", "Shape")
1318:         WITH loc_oAba.shp_4c_Shape8
1319:             .Top         = 258
1320:             .Left        = 13
1321:             .Width       = 712
1322:             .Height      = 35
1323:             .BorderColor = RGB(0, 0, 0)
1324:             .BorderStyle = 1
1325:             .Visible     = .T.
1326:         ENDWITH
1327: 
1328:         loc_oAba.AddObject("txt_4c__CodOcorPis", "TextBox")
1329:         WITH loc_oAba.txt_4c__CodOcorPis
1330:             .Value         = ""
1331:             .Top           = 265
1332:             .Left          = 43
1333:             .Width         = 78
1334:             .Height        = 22
1335:             .MaxLength     = 10
1336:             .FontName      = "Tahoma"
1337:             .FontSize      = 8
1338:             .SpecialEffect = 1
1339:             .BorderColor   = RGB(100, 100, 100)
1340:             .Visible       = .T.
1341:         ENDWITH
1342: 
1343:         loc_oAba.AddObject("lbl_4c_Label15", "Label")
1344:         WITH loc_oAba.lbl_4c_Label15
1345:             .Caption   = "PIS"
1346:             .Top       = 271
1347:             .Left      = 20
1348:             .Width     = 24
1349:             .Height    = 15
1350:             .FontName  = "Tahoma"
1351:             .FontSize  = 8
1352:             .BackStyle = 0
1353:             .ForeColor = RGB(0, 0, 0)
1354:             .Visible   = .T.
1355:         ENDWITH
1356: 
1357:         loc_oAba.AddObject("txt_4c__CodOcorCofins", "TextBox")
1358:         WITH loc_oAba.txt_4c__CodOcorCofins
1359:             .Value         = ""
1360:             .Top           = 265
1361:             .Left          = 178
1362:             .Width         = 78
1363:             .Height        = 22
1364:             .MaxLength     = 10
1365:             .FontName      = "Tahoma"
1366:             .FontSize      = 8
1367:             .SpecialEffect = 1
1368:             .BorderColor   = RGB(100, 100, 100)
1369:             .Visible       = .T.
1370:         ENDWITH
1371: 
1372:         loc_oAba.AddObject("lbl_4c_Label17", "Label")
1373:         WITH loc_oAba.lbl_4c_Label17
1374:             .Caption   = "COFINS"
1375:             .Top       = 270
1376:             .Left      = 129
1377:             .Width     = 50
1378:             .Height    = 15
1379:             .FontName  = "Tahoma"
1380:             .FontSize  = 8
1381:             .BackStyle = 0
1382:             .ForeColor = RGB(0, 0, 0)
1383:             .Visible   = .T.
1384:         ENDWITH
1385: 
1386:         loc_oAba.AddObject("txt_4c__CodOcorIrrf", "TextBox")
1387:         WITH loc_oAba.txt_4c__CodOcorIrrf
1388:             .Value         = ""
1389:             .Top           = 265
1390:             .Left          = 291
1391:             .Width         = 78
1392:             .Height        = 22
1393:             .MaxLength     = 10
1394:             .FontName      = "Tahoma"
1395:             .FontSize      = 8
1396:             .SpecialEffect = 1
1397:             .BorderColor   = RGB(100, 100, 100)
1398:             .Visible       = .T.
1399:         ENDWITH
1400: 
1401:         loc_oAba.AddObject("lbl_4c_Label19", "Label")
1402:         WITH loc_oAba.lbl_4c_Label19
1403:             .Caption   = "IRRF"
1404:             .Top       = 270
1405:             .Left      = 261
1406:             .Width     = 32
1407:             .Height    = 15
1408:             .FontName  = "Tahoma"
1409:             .FontSize  = 8
1410:             .BackStyle = 0
1411:             .ForeColor = RGB(0, 0, 0)
1412:             .Visible   = .T.
1413:         ENDWITH
1414: 
1415:         loc_oAba.AddObject("txt_4c__CodOcorInss", "TextBox")
1416:         WITH loc_oAba.txt_4c__CodOcorInss
1417:             .Value         = ""
1418:             .Top           = 265
1419:             .Left          = 411
1420:             .Width         = 78
1421:             .Height        = 22
1422:             .MaxLength     = 10
1423:             .FontName      = "Tahoma"
1424:             .FontSize      = 8
1425:             .SpecialEffect = 1
1426:             .BorderColor   = RGB(100, 100, 100)
1427:             .Visible       = .T.
1428:         ENDWITH
1429: 
1430:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
1431:         WITH loc_oAba.lbl_4c_Label21
1432:             .Caption   = "INSS"
1433:             .Top       = 270
1434:             .Left      = 377
1435:             .Width     = 33
1436:             .Height    = 15
1437:             .FontName  = "Tahoma"
1438:             .FontSize  = 8
1439:             .BackStyle = 0
1440:             .ForeColor = RGB(0, 0, 0)
1441:             .Visible   = .T.
1442:         ENDWITH
1443: 
1444:         loc_oAba.AddObject("txt_4c__CodOcorCsll", "TextBox")
1445:         WITH loc_oAba.txt_4c__CodOcorCsll
1446:             .Value         = ""
1447:             .Top           = 265
1448:             .Left          = 529
1449:             .Width         = 78
1450:             .Height        = 22
1451:             .MaxLength     = 10
1452:             .FontName      = "Tahoma"
1453:             .FontSize      = 8
1454:             .SpecialEffect = 1
1455:             .BorderColor   = RGB(100, 100, 100)
1456:             .Visible       = .T.
1457:         ENDWITH
1458: 
1459:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
1460:         WITH loc_oAba.lbl_4c_Label23
1461:             .Caption   = "CSLL"
1462:             .Top       = 270
1463:             .Left      = 496
1464:             .Width     = 32
1465:             .Height    = 15
1466:             .FontName  = "Tahoma"
1467:             .FontSize  = 8
1468:             .BackStyle = 0
1469:             .ForeColor = RGB(0, 0, 0)
1470:             .Visible   = .T.
1471:         ENDWITH
1472: 
1473:         loc_oAba.AddObject("txt_4c__CodOcoriSS", "TextBox")
1474:         WITH loc_oAba.txt_4c__CodOcoriSS
1475:             .Value         = ""
1476:             .Top           = 265
1477:             .Left          = 635
1478:             .Width         = 78
1479:             .Height        = 22
1480:             .MaxLength     = 10
1481:             .FontName      = "Tahoma"
1482:             .FontSize      = 8
1483:             .SpecialEffect = 1
1484:             .BorderColor   = RGB(100, 100, 100)
1485:             .Visible       = .T.
1486:         ENDWITH
1487: 
1488:         loc_oAba.AddObject("lbl_4c_Label31", "Label")
1489:         WITH loc_oAba.lbl_4c_Label31
1490:             .Caption   = "ISS"
1491:             .Top       = 269
1492:             .Left      = 612
1493:             .Width     = 24
1494:             .Height    = 15
1495:             .FontName  = "Tahoma"
1496:             .FontSize  = 8
1497:             .BackStyle = 0
1498:             .ForeColor = RGB(0, 0, 0)
1499:             .Visible   = .T.
1500:         ENDWITH
1501: 
1502:         *-- Conta Contabil principal
1503:         loc_oAba.AddObject("lbl_4c_Label9", "Label")
1504:         WITH loc_oAba.lbl_4c_Label9
1505:             .Caption   = "Cta Cont" + CHR(225) + "bil :"
1506:             .Top       = 306
1507:             .Left      = 44
1508:             .Width     = 88
1509:             .Height    = 15
1510:             .FontName  = "Tahoma"
1511:             .FontSize  = 8
1512:             .FontBold  = .T.

*-- Linhas 1518 a 1527:
1518:         loc_oAba.AddObject("txt_4c_Grupo", "TextBox")
1519:         WITH loc_oAba.txt_4c_Grupo
1520:             .Value         = ""
1521:             .Top           = 301
1522:             .Left          = 127
1523:             .Width         = 78
1524:             .Height        = 23
1525:             .MaxLength     = 10
1526:             .FontName      = "Tahoma"
1527:             .FontSize      = 8

*-- Linhas 1533 a 1542:
1533:         loc_oAba.AddObject("txt_4c_Contao", "TextBox")
1534:         WITH loc_oAba.txt_4c_Contao
1535:             .Value         = ""
1536:             .Top           = 301
1537:             .Left          = 206
1538:             .Width         = 78
1539:             .Height        = 23
1540:             .MaxLength     = 10
1541:             .FontName      = "Tahoma"
1542:             .FontSize      = 8

*-- Linhas 1549 a 1558:
1549:         loc_oAba.AddObject("txt_4c_Dcontao", "TextBox")
1550:         WITH loc_oAba.txt_4c_Dcontao
1551:             .Value         = ""
1552:             .Top           = 301
1553:             .Left          = 285
1554:             .Width         = 290
1555:             .Height        = 23
1556:             .MaxLength     = 60
1557:             .ReadOnly      = .T.
1558:             .FontName      = "Tahoma"

*-- Linhas 1577 a 1651:
1577:         *-- Molduras gerais da aba
1578:         loc_oAba.AddObject("shp_4c_Shape6", "Shape")
1579:         WITH loc_oAba.shp_4c_Shape6
1580:             .Top         = 13
1581:             .Left        = 8
1582:             .Width       = 719
1583:             .Height      = 154
1584:             .BorderColor = RGB(0, 0, 0)
1585:             .BorderStyle = 1
1586:             .Visible     = .T.
1587:         ENDWITH
1588: 
1589:         loc_oAba.AddObject("shp_4c_Shape4", "Shape")
1590:         WITH loc_oAba.shp_4c_Shape4
1591:             .Top         = 13
1592:             .Left        = 61
1593:             .Width       = 270
1594:             .Height      = 154
1595:             .BorderColor = RGB(0, 0, 0)
1596:             .BorderStyle = 1
1597:             .Visible     = .T.
1598:         ENDWITH
1599: 
1600:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
1601:         WITH loc_oAba.shp_4c_Shape1
1602:             .Top         = 176
1603:             .Left        = 7
1604:             .Width       = 719
1605:             .Height      = 154
1606:             .BorderColor = RGB(0, 0, 0)
1607:             .BorderStyle = 1
1608:             .Visible     = .T.
1609:         ENDWITH
1610: 
1611:         loc_oAba.AddObject("lbl_4c_Label29", "Label")
1612:         WITH loc_oAba.lbl_4c_Label29
1613:             .Caption   = "Vencimentos"
1614:             .Top       = 5
1615:             .Left      = 69
1616:             .Width     = 85
1617:             .Height    = 15
1618:             .FontName  = "Tahoma"
1619:             .FontSize  = 8
1620:             .FontBold  = .T.
1621:             .BackStyle = 0
1622:             .ForeColor = RGB(0, 0, 0)
1623:             .Visible   = .T.
1624:         ENDWITH
1625: 
1626:         loc_oAba.AddObject("lbl_4c_Label28", "Label")
1627:         WITH loc_oAba.lbl_4c_Label28
1628:             .Caption   = "" + CHR(211) + "rg" + CHR(227) + "o Contribuinte"
1629:             .Top       = 5
1630:             .Left      = 335
1631:             .Width     = 125
1632:             .Height    = 15
1633:             .FontName  = "Tahoma"
1634:             .FontSize  = 8
1635:             .FontBold  = .T.
1636:             .BackStyle = 0
1637:             .ForeColor = RGB(0, 0, 0)
1638:             .Visible   = .T.
1639:         ENDWITH
1640: 
1641:         *-- Linha PIS
1642:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
1643:         WITH loc_oAba.lbl_4c_Label16
1644:             .Caption   = "PIS"
1645:             .Top       = 28
1646:             .Left      = 12
1647:             .Width     = 24
1648:             .Height    = 15
1649:             .FontName  = "Tahoma"
1650:             .FontSize  = 8
1651:             .BackStyle = 0

*-- Linhas 1658 a 1667:
1658:         loc_oAba.AddObject("txt_4c__grupopis", "TextBox")
1659:         WITH loc_oAba.txt_4c__grupopis
1660:             .Value         = ""
1661:             .Top           = 22
1662:             .Left          = 342
1663:             .Width         = 78
1664:             .Height        = 22
1665:             .MaxLength     = 10
1666:             .FontName      = "Tahoma"
1667:             .FontSize      = 8

*-- Linhas 1673 a 1682:
1673:         loc_oAba.AddObject("txt_4c__contapis", "TextBox")
1674:         WITH loc_oAba.txt_4c__contapis
1675:             .Value         = ""
1676:             .Top           = 22
1677:             .Left          = 421
1678:             .Width         = 78
1679:             .Height        = 22
1680:             .MaxLength     = 10
1681:             .FontName      = "Tahoma"
1682:             .FontSize      = 8

*-- Linhas 1688 a 1714:
1688:         loc_oAba.AddObject("txt_4c__dcontapis", "TextBox")
1689:         WITH loc_oAba.txt_4c__dcontapis
1690:             .Value         = ""
1691:             .Top           = 22
1692:             .Left          = 500
1693:             .Width         = 220
1694:             .Height        = 22
1695:             .MaxLength     = 50
1696:             .ReadOnly      = .T.
1697:             .FontName      = "Tahoma"
1698:             .FontSize      = 8
1699:             .SpecialEffect = 1
1700:             .BorderColor   = RGB(100, 100, 100)
1701:             .Visible       = .T.
1702:         ENDWITH
1703: 
1704:         *-- Linha COFINS
1705:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
1706:         WITH loc_oAba.lbl_4c_Label18
1707:             .Caption   = "COFINS"
1708:             .Top       = 50
1709:             .Left      = 11
1710:             .Width     = 50
1711:             .Height    = 15
1712:             .FontName  = "Tahoma"
1713:             .FontSize  = 8
1714:             .BackStyle = 0

*-- Linhas 1721 a 1730:
1721:         loc_oAba.AddObject("txt_4c__grupocofins", "TextBox")
1722:         WITH loc_oAba.txt_4c__grupocofins
1723:             .Value         = ""
1724:             .Top           = 45
1725:             .Left          = 342
1726:             .Width         = 78
1727:             .Height        = 22
1728:             .MaxLength     = 10
1729:             .FontName      = "Tahoma"
1730:             .FontSize      = 8

*-- Linhas 1736 a 1745:
1736:         loc_oAba.AddObject("txt_4c__contacofins", "TextBox")
1737:         WITH loc_oAba.txt_4c__contacofins
1738:             .Value         = ""
1739:             .Top           = 45
1740:             .Left          = 421
1741:             .Width         = 78
1742:             .Height        = 22
1743:             .MaxLength     = 10
1744:             .FontName      = "Tahoma"
1745:             .FontSize      = 8

*-- Linhas 1751 a 1777:
1751:         loc_oAba.AddObject("txt_4c__dcontacofins", "TextBox")
1752:         WITH loc_oAba.txt_4c__dcontacofins
1753:             .Value         = ""
1754:             .Top           = 45
1755:             .Left          = 500
1756:             .Width         = 220
1757:             .Height        = 22
1758:             .MaxLength     = 50
1759:             .ReadOnly      = .T.
1760:             .FontName      = "Tahoma"
1761:             .FontSize      = 8
1762:             .SpecialEffect = 1
1763:             .BorderColor   = RGB(100, 100, 100)
1764:             .Visible       = .T.
1765:         ENDWITH
1766: 
1767:         *-- Linha IRRF
1768:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
1769:         WITH loc_oAba.lbl_4c_Label20
1770:             .Caption   = "IRRF"
1771:             .Top       = 72
1772:             .Left      = 12
1773:             .Width     = 32
1774:             .Height    = 15
1775:             .FontName  = "Tahoma"
1776:             .FontSize  = 8
1777:             .BackStyle = 0

*-- Linhas 1784 a 1793:
1784:         loc_oAba.AddObject("txt_4c__grupoirrf", "TextBox")
1785:         WITH loc_oAba.txt_4c__grupoirrf
1786:             .Value         = ""
1787:             .Top           = 68
1788:             .Left          = 342
1789:             .Width         = 78
1790:             .Height        = 22
1791:             .MaxLength     = 10
1792:             .FontName      = "Tahoma"
1793:             .FontSize      = 8

*-- Linhas 1799 a 1808:
1799:         loc_oAba.AddObject("txt_4c__contairrf", "TextBox")
1800:         WITH loc_oAba.txt_4c__contairrf
1801:             .Value         = ""
1802:             .Top           = 68
1803:             .Left          = 421
1804:             .Width         = 78
1805:             .Height        = 22
1806:             .MaxLength     = 10
1807:             .FontName      = "Tahoma"
1808:             .FontSize      = 8

*-- Linhas 1814 a 1840:
1814:         loc_oAba.AddObject("txt_4c__dcontairrf", "TextBox")
1815:         WITH loc_oAba.txt_4c__dcontairrf
1816:             .Value         = ""
1817:             .Top           = 68
1818:             .Left          = 500
1819:             .Width         = 220
1820:             .Height        = 22
1821:             .MaxLength     = 50
1822:             .ReadOnly      = .T.
1823:             .FontName      = "Tahoma"
1824:             .FontSize      = 8
1825:             .SpecialEffect = 1
1826:             .BorderColor   = RGB(100, 100, 100)
1827:             .Visible       = .T.
1828:         ENDWITH
1829: 
1830:         *-- Linha INSS
1831:         loc_oAba.AddObject("lbl_4c_Label22", "Label")
1832:         WITH loc_oAba.lbl_4c_Label22
1833:             .Caption   = "INSS"
1834:             .Top       = 94
1835:             .Left      = 12
1836:             .Width     = 33
1837:             .Height    = 15
1838:             .FontName  = "Tahoma"
1839:             .FontSize  = 8
1840:             .BackStyle = 0

*-- Linhas 1847 a 1856:
1847:         loc_oAba.AddObject("txt_4c__grupoinss", "TextBox")
1848:         WITH loc_oAba.txt_4c__grupoinss
1849:             .Value         = ""
1850:             .Top           = 91
1851:             .Left          = 342
1852:             .Width         = 78
1853:             .Height        = 22
1854:             .MaxLength     = 10
1855:             .FontName      = "Tahoma"
1856:             .FontSize      = 8

*-- Linhas 1862 a 1871:
1862:         loc_oAba.AddObject("txt_4c__containss", "TextBox")
1863:         WITH loc_oAba.txt_4c__containss
1864:             .Value         = ""
1865:             .Top           = 91
1866:             .Left          = 421
1867:             .Width         = 78
1868:             .Height        = 22
1869:             .MaxLength     = 10
1870:             .FontName      = "Tahoma"
1871:             .FontSize      = 8

*-- Linhas 1877 a 1903:
1877:         loc_oAba.AddObject("txt_4c__dcontainss", "TextBox")
1878:         WITH loc_oAba.txt_4c__dcontainss
1879:             .Value         = ""
1880:             .Top           = 91
1881:             .Left          = 500
1882:             .Width         = 220
1883:             .Height        = 22
1884:             .MaxLength     = 50
1885:             .ReadOnly      = .T.
1886:             .FontName      = "Tahoma"
1887:             .FontSize      = 8
1888:             .SpecialEffect = 1
1889:             .BorderColor   = RGB(100, 100, 100)
1890:             .Visible       = .T.
1891:         ENDWITH
1892: 
1893:         *-- Linha CSLL
1894:         loc_oAba.AddObject("lbl_4c_Label24", "Label")
1895:         WITH loc_oAba.lbl_4c_Label24
1896:             .Caption   = "CSLL"
1897:             .Top       = 116
1898:             .Left      = 12
1899:             .Width     = 32
1900:             .Height    = 15
1901:             .FontName  = "Tahoma"
1902:             .FontSize  = 8
1903:             .BackStyle = 0

*-- Linhas 1910 a 1919:
1910:         loc_oAba.AddObject("txt_4c__grupocsll", "TextBox")
1911:         WITH loc_oAba.txt_4c__grupocsll
1912:             .Value         = ""
1913:             .Top           = 114
1914:             .Left          = 342
1915:             .Width         = 78
1916:             .Height        = 22
1917:             .MaxLength     = 10
1918:             .FontName      = "Tahoma"
1919:             .FontSize      = 8

*-- Linhas 1925 a 1934:
1925:         loc_oAba.AddObject("txt_4c__contacsll", "TextBox")
1926:         WITH loc_oAba.txt_4c__contacsll
1927:             .Value         = ""
1928:             .Top           = 114
1929:             .Left          = 421
1930:             .Width         = 78
1931:             .Height        = 22
1932:             .MaxLength     = 10
1933:             .FontName      = "Tahoma"
1934:             .FontSize      = 8

*-- Linhas 1940 a 1966:
1940:         loc_oAba.AddObject("txt_4c__dcontacsll", "TextBox")
1941:         WITH loc_oAba.txt_4c__dcontacsll
1942:             .Value         = ""
1943:             .Top           = 114
1944:             .Left          = 500
1945:             .Width         = 220
1946:             .Height        = 22
1947:             .MaxLength     = 50
1948:             .ReadOnly      = .T.
1949:             .FontName      = "Tahoma"
1950:             .FontSize      = 8
1951:             .SpecialEffect = 1
1952:             .BorderColor   = RGB(100, 100, 100)
1953:             .Visible       = .T.
1954:         ENDWITH
1955: 
1956:         *-- Linha ISS
1957:         loc_oAba.AddObject("lbl_4c_Label30", "Label")
1958:         WITH loc_oAba.lbl_4c_Label30
1959:             .Caption   = "ISS"
1960:             .Top       = 138
1961:             .Left      = 12
1962:             .Width     = 24
1963:             .Height    = 15
1964:             .FontName  = "Tahoma"
1965:             .FontSize  = 8
1966:             .BackStyle = 0

*-- Linhas 1973 a 1982:
1973:         loc_oAba.AddObject("txt_4c__grupoiss", "TextBox")
1974:         WITH loc_oAba.txt_4c__grupoiss
1975:             .Value         = ""
1976:             .Top           = 137
1977:             .Left          = 342
1978:             .Width         = 78
1979:             .Height        = 22
1980:             .MaxLength     = 10
1981:             .FontName      = "Tahoma"
1982:             .FontSize      = 8

*-- Linhas 1988 a 1997:
1988:         loc_oAba.AddObject("txt_4c__contaiss", "TextBox")
1989:         WITH loc_oAba.txt_4c__contaiss
1990:             .Value         = ""
1991:             .Top           = 137
1992:             .Left          = 421
1993:             .Width         = 78
1994:             .Height        = 22
1995:             .MaxLength     = 10
1996:             .FontName      = "Tahoma"
1997:             .FontSize      = 8

*-- Linhas 2003 a 2029:
2003:         loc_oAba.AddObject("txt_4c__dcontaiss", "TextBox")
2004:         WITH loc_oAba.txt_4c__dcontaiss
2005:             .Value         = ""
2006:             .Top           = 137
2007:             .Left          = 500
2008:             .Width         = 220
2009:             .Height        = 22
2010:             .MaxLength     = 50
2011:             .ReadOnly      = .T.
2012:             .FontName      = "Tahoma"
2013:             .FontSize      = 8
2014:             .SpecialEffect = 1
2015:             .BorderColor   = RGB(100, 100, 100)
2016:             .Visible       = .T.
2017:         ENDWITH
2018: 
2019:         *-- Produtos utilizados para cupons fiscais/NFe
2020:         loc_oAba.AddObject("lbl_4c_Label1", "Label")
2021:         WITH loc_oAba.lbl_4c_Label1
2022:             .Caption   = "Produtos (utilizado para cupons fiscais - NFe)"
2023:             .Top       = 169
2024:             .Left      = 16
2025:             .Width     = 301
2026:             .Height    = 15
2027:             .FontName  = "Tahoma"
2028:             .FontSize  = 8
2029:             .FontBold  = .T.

*-- Linhas 2037 a 2046:
2037:         loc_oAba.grd_4c_Dados.ColumnCount  = 2
2038: 
2039:         WITH loc_oAba.grd_4c_Dados
2040:             .Top                     = 187
2041:             .Left                    = 14
2042:             .Width                   = 430
2043:             .Height                  = 138
2044:             .FontName                = "Tahoma"
2045:             .FontSize                = 8
2046:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 2057 a 2100:
2057:             .Visible                 = .T.
2058:             .Column1.Width           = 100
2059:             .Column2.Width           = 320
2060:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
2061:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2062:         ENDWITH
2063: 
2064:         loc_oAba.AddObject("cmd_4c_CmdInserir", "CommandButton")
2065:         WITH loc_oAba.cmd_4c_CmdInserir
2066:             .Caption   = "Inserir"
2067:             .Top       = 234
2068:             .Left      = 448
2069:             .Width     = 64
2070:             .Height    = 46
2071:             .FontName  = "Tahoma"
2072:             .FontSize  = 8
2073:             .ForeColor = RGB(90, 90, 90)
2074:             .BackColor = RGB(255, 255, 255)
2075:             .Themes    = .F.
2076:             .Visible   = .T.
2077:         ENDWITH
2078: 
2079:         loc_oAba.AddObject("cmd_4c_CmdExcluir", "CommandButton")
2080:         WITH loc_oAba.cmd_4c_CmdExcluir
2081:             .Caption   = "Excluir"
2082:             .Top       = 280
2083:             .Left      = 448
2084:             .Width     = 64
2085:             .Height    = 46
2086:             .FontName  = "Tahoma"
2087:             .FontSize  = 8
2088:             .ForeColor = RGB(90, 90, 90)
2089:             .BackColor = RGB(255, 255, 255)
2090:             .Themes    = .F.
2091:             .Visible   = .T.
2092:         ENDWITH
2093: 
2094:         BINDEVENT(loc_oAba.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirProdutoClick")
2095:         BINDEVENT(loc_oAba.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirProdutoClick")
2096: 
2097:         THIS.TornarControlesVisiveis(loc_oAba)
2098:     ENDPROC
2099: 
2100:     *===========================================================================

*-- Linhas 2108 a 2155:
2108:             .ButtonCount = 3
2109:             .BackStyle   = 0
2110:             .BorderStyle = 1
2111:             .Top         = par_nTop
2112:             .Left        = 66
2113:             .Width       = 261
2114:             .Height      = 24
2115:             .Value       = 1
2116:             .Visible     = .T.
2117:         ENDWITH
2118: 
2119:         WITH par_oAba.&par_cNome..Buttons(1)
2120:             .Caption   = "T" + CHR(237) + "tulo"
2121:             .Left      = 5
2122:             .Top       = 5
2123:             .Width     = 47
2124:             .Height    = 14
2125:             .AutoSize  = .T.
2126:             .FontName  = "Verdana"
2127:             .FontSize  = 7
2128:             .BackStyle = 0
2129:             .ForeColor = RGB(36, 84, 155)
2130:             .Themes    = .F.
2131:         ENDWITH
2132: 
2133:         WITH par_oAba.&par_cNome..Buttons(2)
2134:             .Caption   = "10 D F M" + CHR(234) + "s"
2135:             .Left      = 52
2136:             .Top       = 5
2137:             .Width     = 76
2138:             .Height    = 14
2139:             .AutoSize  = .T.
2140:             .FontName  = "Verdana"
2141:             .FontSize  = 7
2142:             .BackStyle = 0
2143:             .ForeColor = RGB(36, 84, 155)
2144:             .Themes    = .F.
2145:         ENDWITH
2146: 
2147:         WITH par_oAba.&par_cNome..Buttons(3)
2148:             .Caption   = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
2149:             .Left      = 129
2150:             .Top       = 5
2151:             .Width     = 128
2152:             .Height    = 14
2153:             .AutoSize  = .T.
2154:             .FontName  = "Verdana"
2155:             .FontSize  = 7

*-- Linhas 2169 a 2279:
2169:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3
2170: 
2171:         *-- Bloco "Codigos de retencao" (nivel da propria aba)
2172:         loc_oAba.AddObject("lbl_4c_Label1", "Label")
2173:         WITH loc_oAba.lbl_4c_Label1
2174:             .Caption   = "C" + CHR(243) + "digos de reten" + CHR(231) + CHR(227) + "o"
2175:             .Top       = 6
2176:             .Left      = 18
2177:             .Width     = 135
2178:             .Height    = 15
2179:             .FontName  = "Tahoma"
2180:             .FontSize  = 8
2181:             .FontBold  = .T.
2182:             .BackStyle = 0
2183:             .ForeColor = RGB(0, 0, 0)
2184:             .Visible   = .T.
2185:         ENDWITH
2186: 
2187:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
2188:         WITH loc_oAba.shp_4c_Shape1
2189:             .Top         = 13
2190:             .Left        = 5
2191:             .Width       = 721
2192:             .Height      = 37
2193:             .BorderColor = RGB(0, 0, 0)
2194:             .BorderStyle = 1
2195:             .Visible     = .T.
2196:         ENDWITH
2197: 
2198:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
2199:         WITH loc_oAba.lbl_4c_Label2
2200:             .Caption   = "PIS :"
2201:             .Top       = 24
2202:             .Left      = 196
2203:             .Width     = 32
2204:             .Height    = 15
2205:             .FontName  = "Tahoma"
2206:             .FontSize  = 8
2207:             .BackStyle = 0
2208:             .ForeColor = RGB(0, 0, 0)
2209:             .Visible   = .T.
2210:         ENDWITH
2211: 
2212:         loc_oAba.AddObject("txt_4c__PIS", "TextBox")
2213:         WITH loc_oAba.txt_4c__PIS
2214:             .Value         = ""
2215:             .Top           = 21
2216:             .Left          = 228
2217:             .Width         = 50
2218:             .Height        = 22
2219:             .MaxLength     = 5
2220:             .FontName      = "Tahoma"
2221:             .FontSize      = 8
2222:             .SpecialEffect = 1
2223:             .BorderColor   = RGB(100, 100, 100)
2224:             .Visible       = .T.
2225:         ENDWITH
2226: 
2227:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
2228:         WITH loc_oAba.lbl_4c_Label4
2229:             .Caption   = "COFINS :"
2230:             .Top       = 24
2231:             .Left      = 286
2232:             .Width     = 58
2233:             .Height    = 15
2234:             .FontName  = "Tahoma"
2235:             .FontSize  = 8
2236:             .BackStyle = 0
2237:             .ForeColor = RGB(0, 0, 0)
2238:             .Visible   = .T.
2239:         ENDWITH
2240: 
2241:         loc_oAba.AddObject("txt_4c__COFINS", "TextBox")
2242:         WITH loc_oAba.txt_4c__COFINS
2243:             .Value         = ""
2244:             .Top           = 21
2245:             .Left          = 344
2246:             .Width         = 50
2247:             .Height        = 22
2248:             .MaxLength     = 5
2249:             .FontName      = "Tahoma"
2250:             .FontSize      = 8
2251:             .SpecialEffect = 1
2252:             .BorderColor   = RGB(100, 100, 100)
2253:             .Visible       = .T.
2254:         ENDWITH
2255: 
2256:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
2257:         WITH loc_oAba.lbl_4c_Label8
2258:             .Caption   = "CSLL :"
2259:             .Top       = 24
2260:             .Left      = 399
2261:             .Width     = 40
2262:             .Height    = 15
2263:             .FontName  = "Tahoma"
2264:             .FontSize  = 8
2265:             .BackStyle = 0
2266:             .ForeColor = RGB(0, 0, 0)
2267:             .Visible   = .T.
2268:         ENDWITH
2269: 
2270:         loc_oAba.AddObject("txt_4c__CSLL", "TextBox")
2271:         WITH loc_oAba.txt_4c__CSLL
2272:             .Value         = ""
2273:             .Top           = 21
2274:             .Left          = 439
2275:             .Width         = 50
2276:             .Height        = 22
2277:             .MaxLength     = 5
2278:             .FontName      = "Tahoma"
2279:             .FontSize      = 8

*-- Linhas 2286 a 2333:
2286:         loc_oAba.AddObject("cnt_4c_RPA", "Container")
2287:         loc_oRPA = loc_oAba.cnt_4c_RPA
2288:         WITH loc_oRPA
2289:             .Top         = 64
2290:             .Left        = 9
2291:             .Width       = 721
2292:             .Height      = 125
2293:             .BackStyle   = 0
2294:             .BorderWidth = 0
2295:             .Visible     = .T.
2296:         ENDWITH
2297: 
2298:         loc_oRPA.AddObject("lbl_4c_Label3", "Label")
2299:         WITH loc_oRPA.lbl_4c_Label3
2300:             .Caption   = " RPA "
2301:             .Top       = 1
2302:             .Left      = 5
2303:             .Width     = 35
2304:             .Height    = 15
2305:             .FontName  = "Tahoma"
2306:             .FontSize  = 8
2307:             .FontBold  = .T.
2308:             .BackStyle = 0
2309:             .ForeColor = RGB(0, 0, 0)
2310:             .Visible   = .T.
2311:         ENDWITH
2312: 
2313:         loc_oRPA.AddObject("shp_4c_Shape2", "Shape")
2314:         WITH loc_oRPA.shp_4c_Shape2
2315:             .Top         = 76
2316:             .Left        = 1
2317:             .Width       = 681
2318:             .Height      = 2
2319:             .BorderColor = RGB(0, 0, 0)
2320:             .BorderStyle = 1
2321:             .Visible     = .T.
2322:         ENDWITH
2323: 
2324:         loc_oRPA.AddObject("lbl_4c_Label16", "Label")
2325:         WITH loc_oRPA.lbl_4c_Label16
2326:             .Caption   = "Servi" + CHR(231) + "o " + CHR(233) + " um RPA :"
2327:             .Top       = 16
2328:             .Left      = 123
2329:             .Width     = 124
2330:             .Height    = 15
2331:             .FontName  = "Tahoma"
2332:             .FontSize  = 8
2333:             .BackStyle = 0

*-- Linhas 2340 a 2531:
2340:             .ButtonCount = 2
2341:             .BackStyle   = 0
2342:             .BorderStyle = 0
2343:             .Top         = 12
2344:             .Left        = 249
2345:             .Width       = 122
2346:             .Height      = 24
2347:             .Value       = 2
2348:             .Themes      = .F.
2349:             .Visible     = .T.
2350:         ENDWITH
2351: 
2352:         WITH loc_oRPA.obj_4c_Opt_RPA.Buttons(1)
2353:             .Caption   = "Sim"
2354:             .Left      = 5
2355:             .Top       = 4
2356:             .Width     = 44
2357:             .Height    = 17
2358:             .FontName  = "Verdana"
2359:             .FontSize  = 8
2360:             .BackStyle = 0
2361:             .ForeColor = RGB(36, 84, 155)
2362:             .Themes    = .F.
2363:         ENDWITH
2364: 
2365:         WITH loc_oRPA.obj_4c_Opt_RPA.Buttons(2)
2366:             .Caption   = "N" + CHR(227) + "o"
2367:             .Left      = 50
2368:             .Top       = 4
2369:             .Width     = 62
2370:             .Height    = 17
2371:             .FontName  = "Verdana"
2372:             .FontSize  = 8
2373:             .BackStyle = 0
2374:             .ForeColor = RGB(36, 84, 155)
2375:             .Themes    = .F.
2376:         ENDWITH
2377: 
2378:         loc_oRPA.AddObject("lbl_4c_Label5", "Label")
2379:         WITH loc_oRPA.lbl_4c_Label5
2380:             .Caption   = "Valor M" + CHR(225) + "ximo p/ Reten" + CHR(231) + CHR(227) + "o do INSS :"
2381:             .Top       = 43
2382:             .Left      = 10
2383:             .Width     = 237
2384:             .Height    = 15
2385:             .FontName  = "Tahoma"
2386:             .FontSize  = 8
2387:             .BackStyle = 0
2388:             .ForeColor = RGB(0, 0, 0)
2389:             .Visible   = .T.
2390:         ENDWITH
2391: 
2392:         loc_oRPA.AddObject("txt_4c__MaxRetInss", "TextBox")
2393:         WITH loc_oRPA.txt_4c__MaxRetInss
2394:             .Value         = 0
2395:             .Top           = 40
2396:             .Left          = 248
2397:             .Width         = 90
2398:             .Height        = 22
2399:             .Format        = "999999999.99"
2400:             .FontName      = "Tahoma"
2401:             .FontSize      = 8
2402:             .SpecialEffect = 1
2403:             .BorderColor   = RGB(100, 100, 100)
2404:             .Visible       = .T.
2405:         ENDWITH
2406: 
2407:         loc_oRPA.AddObject("lbl_4c_Label6", "Label")
2408:         WITH loc_oRPA.lbl_4c_Label6
2409:             .Caption   = "C" + CHR(243) + "digos de Receita no DARF "
2410:             .Top       = 69
2411:             .Left      = 9
2412:             .Width     = 187
2413:             .Height    = 15
2414:             .FontName  = "Tahoma"
2415:             .FontSize  = 8
2416:             .BackStyle = 0
2417:             .ForeColor = RGB(0, 0, 0)
2418:             .Visible   = .T.
2419:         ENDWITH
2420: 
2421:         loc_oRPA.AddObject("lbl_4c_Label7", "Label")
2422:         WITH loc_oRPA.lbl_4c_Label7
2423:             .Caption   = "PIS :"
2424:             .Top       = 94
2425:             .Left      = 137
2426:             .Width     = 32
2427:             .Height    = 15
2428:             .FontName  = "Tahoma"
2429:             .FontSize  = 8
2430:             .BackStyle = 0
2431:             .ForeColor = RGB(0, 0, 0)
2432:             .Visible   = .T.
2433:         ENDWITH
2434: 
2435:         loc_oRPA.AddObject("txt_4c_CodRecPis", "TextBox")
2436:         WITH loc_oRPA.txt_4c_CodRecPis
2437:             .Value         = ""
2438:             .Top           = 91
2439:             .Left          = 169
2440:             .Width         = 50
2441:             .Height        = 22
2442:             .MaxLength     = 5
2443:             .FontName      = "Tahoma"
2444:             .FontSize      = 8
2445:             .SpecialEffect = 1
2446:             .BorderColor   = RGB(100, 100, 100)
2447:             .Visible       = .T.
2448:         ENDWITH
2449: 
2450:         loc_oRPA.AddObject("lbl_4c_Label9", "Label")
2451:         WITH loc_oRPA.lbl_4c_Label9
2452:             .Caption   = "COFINS :"
2453:             .Top       = 94
2454:             .Left      = 227
2455:             .Width     = 58
2456:             .Height    = 15
2457:             .FontName  = "Tahoma"
2458:             .FontSize  = 8
2459:             .BackStyle = 0
2460:             .ForeColor = RGB(0, 0, 0)
2461:             .Visible   = .T.
2462:         ENDWITH
2463: 
2464:         loc_oRPA.AddObject("txt_4c_CodRecCof", "TextBox")
2465:         WITH loc_oRPA.txt_4c_CodRecCof
2466:             .Value         = ""
2467:             .Top           = 91
2468:             .Left          = 285
2469:             .Width         = 50
2470:             .Height        = 22
2471:             .MaxLength     = 5
2472:             .FontName      = "Tahoma"
2473:             .FontSize      = 8
2474:             .SpecialEffect = 1
2475:             .BorderColor   = RGB(100, 100, 100)
2476:             .Visible       = .T.
2477:         ENDWITH
2478: 
2479:         loc_oRPA.AddObject("lbl_4c_Label10", "Label")
2480:         WITH loc_oRPA.lbl_4c_Label10
2481:             .Caption   = "CSLL :"
2482:             .Top       = 94
2483:             .Left      = 340
2484:             .Width     = 40
2485:             .Height    = 15
2486:             .FontName  = "Tahoma"
2487:             .FontSize  = 8
2488:             .BackStyle = 0
2489:             .ForeColor = RGB(0, 0, 0)
2490:             .Visible   = .T.
2491:         ENDWITH
2492: 
2493:         loc_oRPA.AddObject("txt_4c_CodRecCsll", "TextBox")
2494:         WITH loc_oRPA.txt_4c_CodRecCsll
2495:             .Value         = ""
2496:             .Top           = 92
2497:             .Left          = 382
2498:             .Width         = 50
2499:             .Height        = 22
2500:             .MaxLength     = 5
2501:             .FontName      = "Tahoma"
2502:             .FontSize      = 8
2503:             .SpecialEffect = 1
2504:             .BorderColor   = RGB(100, 100, 100)
2505:             .Visible       = .T.
2506:         ENDWITH
2507: 
2508:         loc_oRPA.AddObject("lbl_4c_Label11", "Label")
2509:         WITH loc_oRPA.lbl_4c_Label11
2510:             .Caption   = "IRRF :"
2511:             .Top       = 94
2512:             .Left      = 441
2513:             .Width     = 40
2514:             .Height    = 15
2515:             .FontName  = "Tahoma"
2516:             .FontSize  = 8
2517:             .BackStyle = 0
2518:             .ForeColor = RGB(0, 0, 0)
2519:             .Visible   = .T.
2520:         ENDWITH
2521: 
2522:         loc_oRPA.AddObject("txt_4c_CodRecIrrf", "TextBox")
2523:         WITH loc_oRPA.txt_4c_CodRecIrrf
2524:             .Value         = ""
2525:             .Top           = 91
2526:             .Left          = 483
2527:             .Width         = 50
2528:             .Height        = 22
2529:             .MaxLength     = 5
2530:             .FontName      = "Tahoma"
2531:             .FontSize      = 8

*-- Linhas 2606 a 2615:
2606:                         loc_oGrid.Column1.ReadOnly = .T.
2607:                         loc_oGrid.Column2.ReadOnly = .T.
2608: 
2609:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2610:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2611: 
2612:                         THIS.FormatarGridLista(loc_oGrid)
2613:                     ENDIF
2614:                     loc_lResultado = .T.
2615:                 ENDIF

*-- Linhas 3383 a 3392:
3383:                 loc_oGrid.RecordSource = "cursor_4c_Produtos"
3384:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Produtos.CPros"
3385:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Produtos.DPros"
3386:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3387:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3388:                 loc_oGrid.Refresh()
3389:             ENDIF
3390:         CATCH TO loException
3391:             MsgErro(loException.Message, "FormSRV.AtualizarGridProdutos")
3392:         ENDTRY

*-- Linhas 3788 a 3797:
3788:             loc_oVen.obj_4c_Opt_VencCsll.Enabled   = loc_lEdit
3789:             loc_oVen.obj_4c_Opt_vencIss.Enabled    = loc_lEdit
3790:             loc_oVen.grd_4c_Dados.ReadOnly         = !loc_lEdit
3791:             loc_oVen.cmd_4c_CmdInserir.Enabled     = loc_lEdit
3792:             loc_oVen.cmd_4c_CmdExcluir.Enabled     = loc_lEdit
3793: 
3794:             *-- Aba Retencao ------------------------------------------------------
3795:             loc_oRet.txt_4c__PIS.ReadOnly    = !loc_lEdit
3796:             loc_oRet.txt_4c__COFINS.ReadOnly = !loc_lEdit
3797:             loc_oRet.txt_4c__CSLL.ReadOnly   = !loc_lEdit

*-- Linhas 3805 a 3814:
3805:             *-- Botoes de acao (Confirmar habilitado em INCLUIR/ALTERAR/BUSCAR
3806:             *-- e tambem em EXCLUIR - campos readonly mas usuario precisa
3807:             *-- poder confirmar a exclusao - CLAUDE.md Erro140/Pattern #178)
3808:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdit OR (THIS.this_cModoAtual = "EXCLUIR")
3809:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
3810:         CATCH TO loException
3811:             MsgErro(loException.Message, "FormSRV.HabilitarCampos")
3812:         ENDTRY
3813:     ENDPROC
3814: 

*-- Linhas 3821 a 3834:
3821:         loc_lLista = (THIS.this_cModoAtual = "LISTA")
3822: 
3823:         TRY
3824:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
3825:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
3826:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
3827:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
3828:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
3829:             loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lLista
3830:         CATCH TO loException
3831:             MsgErro(loException.Message, "FormSRV.AjustarBotoesPorModo")
3832:         ENDTRY
3833:     ENDPROC
3834: 


### BO (C:\4c\projeto\app\classes\SRVBO.prg):
*====================================================================
* SRVBO.prg
*
* Business Object para Cadastro de Servicos (Entradas/Saidas)
* Tabela: SigCdSrv (mestre) / SigSeRvp (detalhe - produtos do servico)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SRVBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdSrv)
    this_cCidChaves     = ""    && cidchaves char(20) - PK
    this_cCodigo        = ""    && codservs char(10)
    this_cDescricao     = ""    && descservs char(40)
    this_cTipo          = "S"   && ctipos char(1) - S=Saidas / E=Entradas

    *-- Aliquotas (%)
    this_nAliquotaPis     = 0   && apiss numeric(4,2)
    this_nAliquotaCofins  = 0   && acofinss numeric(4,2)
    this_nAliquotaIrrf    = 0   && airrfs numeric(4,2)
    this_nAliquotaInss    = 0   && ainss numeric(4,2)
    this_nAliquotaCsll    = 0   && acslls numeric(4,2)
    this_nAliquotaIss     = 0   && aiss numeric(4,2)

    *-- Valores minimos a recolher
    this_nValorMinimoPis     = 0   && vminpiss numeric(11,2)
    this_nValorMinimoCofins  = 0   && vmincofins numeric(11,2)
    this_nValorMinimoIrrf    = 0   && vminirrfs numeric(11,2)
    this_nValorMinimoInss    = 0   && vmininss numeric(11,2)
    this_nValorMinimoCsll    = 0   && vmincslls numeric(11,2)

    *-- Base de calculo minima
    this_nBaseMinimaPis     = 0   && vminbpiss numeric(11,2)
    this_nBaseMinimaCofins  = 0   && vminbcofin numeric(11,2)
    this_nBaseMinimaIrrf    = 0   && vminbirrfs numeric(11,2)
    this_nBaseMinimaInss    = 0   && vminbinss numeric(11,2)
    this_nBaseMinimaCsll    = 0   && vminbcslls numeric(11,2)

    *-- Recolhimento Mensal (checkboxes)
    this_lMensalPis     = .F.   && bpisms numeric(1,0)
    this_lMensalCofins  = .F.   && bcofinms numeric(1,0)
    this_lMensalIrrf    = .F.   && birrfms numeric(1,0)
    this_lMensalInss    = .F.   && binssms numeric(1,0)
    this_lMensalCsll    = .F.   && bcsllms numeric(1,0)

    *-- Lancamento Financeiro (checkboxes)
    this_lLancFinPis     = .F.   && nlanfpiss numeric(1,0)
    this_lLancFinCofins  = .F.   && nlanfcofin numeric(1,0)
    this_lLancFinIrrf    = .F.   && nlanfirrfs numeric(1,0)
    this_lLancFinInss    = .F.   && nlanfinss numeric(1,0)
    this_lLancFinCsll    = .F.   && nlanfcslls numeric(1,0)
    this_lLancFinIss     = .F.   && nlanfiss numeric(1,0)

    *-- Codigos de Ocorrencia (F4 - crSigOpOco)
    this_cCodOcorPis     = ""   && cocorpiss char(10)
    this_cCodOcorCofins  = ""   && cocorcofin char(10)
    this_cCodOcorIrrf    = ""   && cocorirrfs char(10)
    this_cCodOcorInss    = ""   && cocorinss char(10)
    this_cCodOcorCsll    = ""   && cocorcslls char(10)
    this_cCodOcorIss     = ""   && cocoriss char(10)

    *-- Codigos reduzidos de imposto (nao exibidos no form legado, mas fazem parte da tabela)
    this_cCodCofins  = ""   && codcofinss char(5)
    this_cCodCsll    = ""   && codcslls char(5)
    this_cCodPis     = ""   && codpiss char(5)

    *-- Conta contabil principal (Get_grupoo / Get_contao / Get_dcontao)
    this_cGrupoContab  = ""   && cgrupo char(10)
    this_cContaContab  = ""   && ccontab char(10)

    *-- Grupo/Conta contabil por imposto (aba Vencimentos)
    this_cGrupoPis      = ""   && cgrppiss char(10)
    this_cContaPis      = ""   && cctapiss char(10)
    this_cGrupoCofins   = ""   && cgrpcofins char(10)
    this_cContaCofins   = ""   && cctacofins char(10)
    this_cGrupoIrrf     = ""   && cgrpirrfs char(10)
    this_cContaIrrf     = ""   && cctairrfs char(10)
    this_cGrupoInss     = ""   && cgrpinss char(10)
    this_cContaInss     = ""   && cctainss char(10)
    this_cGrupoCsll     = ""   && cgrpcslls char(10)
    this_cContaCsll     = ""   && cctacslls char(10)
    this_cGrupoIss      = ""   && cgrpiss char(10)
    this_cContaIss      = ""   && cctaiss char(10)

    *-- Opcao de vencimento por imposto (OptionGroup 1/2/3)
    this_nVencimentoPis      = 0   && vcpis numeric(1,0)
    this_nVencimentoCofins   = 0   && vccofins numeric(1,0)
    this_nVencimentoIrrf     = 0   && vcirrf numeric(1,0)
    this_nVencimentoInss     = 0   && vcinss numeric(1,0)
    this_nVencimentoCsll     = 0   && vccsll numeric(1,0)
    this_nVencimentoIss      = 0   && vciss numeric(1,0)

    *-- RPA (Recibo de Pagamento Autonomo)
    this_nRPA                     = 0   && nrpas numeric(1,0) - OptionGroup S/N
    this_nValorMaximoRetencaoInss = 0   && maxretinss numeric(11,2)
    this_cCodRecCofins            = ""   && codreccof char(5)
    this_cCodRecPis               = ""   && codrecpis char(5)
    this_cCodRecCsll              = ""   && codreccsll char(5)
    this_cCodRecIrrf              = ""   && codrecirrf char(5)

    *-- Detalhe: produtos do servico (SigSeRvp) - gerenciado via cursor proprio
    this_cCursorProdutos = "cursor_4c_Produtos"   && cursor local do grid de produtos (codservs, cpros)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSrv"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SRVBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna PK para auditoria (RegistrarAuditoria)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * LimparDados - Reseta todas as propriedades para novo registro
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        *-- this_cTipo NAO eh resetado: contexto Saidas/Entradas definido pelo Form

        THIS.this_nAliquotaPis    = 0
        THIS.this_nAliquotaCofins = 0
        THIS.this_nAliquotaIrrf   = 0
        THIS.this_nAliquotaInss   = 0
        THIS.this_nAliquotaCsll   = 0
        THIS.this_nAliquotaIss    = 0

        THIS.this_nValorMinimoPis    = 0
        THIS.this_nValorMinimoCofins = 0
        THIS.this_nValorMinimoIrrf   = 0
        THIS.this_nValorMinimoInss   = 0
        THIS.this_nValorMinimoCsll   = 0

        THIS.this_nBaseMinimaPis    = 0
        THIS.this_nBaseMinimaCofins = 0
        THIS.this_nBaseMinimaIrrf   = 0
        THIS.this_nBaseMinimaInss   = 0
        THIS.this_nBaseMinimaCsll   = 0

        THIS.this_lMensalPis    = .F.
        THIS.this_lMensalCofins = .F.
        THIS.this_lMensalIrrf   = .F.
        THIS.this_lMensalInss   = .F.
        THIS.this_lMensalCsll   = .F.

        THIS.this_lLancFinPis    = .F.
        THIS.this_lLancFinCofins = .F.
        THIS.this_lLancFinIrrf   = .F.
        THIS.this_lLancFinInss   = .F.
        THIS.this_lLancFinCsll   = .F.
        THIS.this_lLancFinIss    = .F.

        THIS.this_cCodOcorPis    = ""
        THIS.this_cCodOcorCofins = ""
        THIS.this_cCodOcorIrrf   = ""
        THIS.this_cCodOcorInss   = ""
        THIS.this_cCodOcorCsll   = ""
        THIS.this_cCodOcorIss    = ""

        THIS.this_cCodCofins = ""
        THIS.this_cCodCsll   = ""
        THIS.this_cCodPis    = ""

        THIS.this_cGrupoContab = ""
        THIS.this_cContaContab = ""

        THIS.this_cGrupoPis    = ""
        THIS.this_cContaPis    = ""
        THIS.this_cGrupoCofins = ""
        THIS.this_cContaCofins = ""
        THIS.this_cGrupoIrrf   = ""
        THIS.this_cContaIrrf   = ""
        THIS.this_cGrupoInss   = ""
        THIS.this_cContaInss   = ""
        THIS.this_cGrupoCsll   = ""
        THIS.this_cContaCsll   = ""
        THIS.this_cGrupoIss    = ""
        THIS.this_cContaIss    = ""

        THIS.this_nVencimentoPis    = 0
        THIS.this_nVencimentoCofins = 0
        THIS.this_nVencimentoIrrf   = 0
        THIS.this_nVencimentoInss   = 0
        THIS.this_nVencimentoCsll   = 0
        THIS.this_nVencimentoIss    = 0

        THIS.this_nRPA                     = 0
        THIS.this_nValorMaximoRetencaoInss = 0
        THIS.this_cCodRecCofins            = ""
        THIS.this_cCodRecPis               = ""
        THIS.this_cCodRecCsll              = ""
        THIS.this_cCodRecIrrf              = ""

        IF USED(THIS.this_cCursorProdutos)
            USE IN (THIS.this_cCursorProdutos)
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (CidChaves C(20), CodServs C(10), CPros C(14), DPros C(40))
        SET NULL OFF
    ENDPROC

    *====================================================================
    * Buscar - SELECT servicos do tipo atual (this_cTipo), filtro opcional
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codservs, descservs, ctipos" + ;
                       " FROM SigCdSrv" + ;
                       " WHERE ctipos = " + EscaparSQL(THIS.this_cTipo)

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " AND (UPPER(codservs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")" + ;
                    " OR UPPER(descservs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + "))"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codservs"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar servicos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - SELECT registro por codigo (+ tipo atual) e produtos
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codservs, descservs, ctipos," + ;
                " apiss, acofinss, airrfs, ainss, aiss, acslls," + ;
                " vminpiss, vmincofins, vminirrfs, vmininss, vmincslls," + ;
                " vminbpiss, vminbcofin, vminbirrfs, vminbinss, vminbcslls," + ;
                " bpisms, bcofinms, birrfms, binssms, bcsllms," + ;
                " nlanfpiss, nlanfcofin, nlanfirrfs, nlanfinss, nlanfcslls, nlanfiss," + ;
                " cocorpiss, cocorcofin, cocorirrfs, cocorinss, cocorcslls, cocoriss," + ;
                " codpiss, codcslls, codcofinss, cgrupo, ccontab," + ;
                " cgrppiss, cctapiss, cgrpcofins, cctacofins, cgrpirrfs, cctairrfs," + ;
                " cgrpinss, cctainss, cgrpcslls, cctacslls, cgrpiss, cctaiss," + ;
                " vcpis, vccofins, vcirrf, vcinss, vccsll, vciss," + ;
                " nrpas, maxretinss, codreccof, codrecpis, codreccsll, codrecirrf" + ;
                " FROM SigCdSrv" + ;
                " WHERE codservs = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                " AND ctipos = " + EscaparSQL(THIS.this_cTipo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                    THIS.CarregarProdutos(THIS.this_cCodigo)
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor para as
    * propriedades this_* (chamado por CarregarPorCodigo)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, "C"))
                THIS.this_cCodigo    = ALLTRIM(TratarNulo(codservs, "C"))
                THIS.this_cDescricao = ALLTRIM(TratarNulo(descservs, "C"))
                THIS.this_cTipo      = ALLTRIM(TratarNulo(ctipos, "C"))

                THIS.this_nAliquotaPis    = TratarNulo(apiss, "N")
                THIS.this_nAliquotaCofins = TratarNulo(acofinss, "N")
                THIS.this_nAliquotaIrrf   = TratarNulo(airrfs, "N")
                THIS.this_nAliquotaInss   = TratarNulo(ainss, "N")
                THIS.this_nAliquotaCsll   = TratarNulo(acslls, "N")
                THIS.this_nAliquotaIss    = TratarNulo(aiss, "N")

                THIS.this_nValorMinimoPis    = TratarNulo(vminpiss, "N")
                THIS.this_nValorMinimoCofins = TratarNulo(vmincofins, "N")
                THIS.this_nValorMinimoIrrf   = TratarNulo(vminirrfs, "N")
                THIS.this_nValorMinimoInss   = TratarNulo(vmininss, "N")
                THIS.this_nValorMinimoCsll   = TratarNulo(vmincslls, "N")

                THIS.this_nBaseMinimaPis    = TratarNulo(vminbpiss, "N")
                THIS.this_nBaseMinimaCofins = TratarNulo(vminbcofin, "N")
                THIS.this_nBaseMinimaIrrf   = TratarNulo(vminbirrfs, "N")
                THIS.this_nBaseMinimaInss   = TratarNulo(vminbinss, "N")
                THIS.this_nBaseMinimaCsll   = TratarNulo(vminbcslls, "N")

                THIS.this_lMensalPis    = (TratarNulo(bpisms, "N") = 1)
                THIS.this_lMensalCofins = (TratarNulo(bcofinms, "N") = 1)
                THIS.this_lMensalIrrf   = (TratarNulo(birrfms, "N") = 1)
                THIS.this_lMensalInss   = (TratarNulo(binssms, "N") = 1)
                THIS.this_lMensalCsll   = (TratarNulo(bcsllms, "N") = 1)

                THIS.this_lLancFinPis    = (TratarNulo(nlanfpiss, "N") = 1)
                THIS.this_lLancFinCofins = (TratarNulo(nlanfcofin, "N") = 1)
                THIS.this_lLancFinIrrf   = (TratarNulo(nlanfirrfs, "N") = 1)
                THIS.this_lLancFinInss   = (TratarNulo(nlanfinss, "N") = 1)
                THIS.this_lLancFinCsll   = (TratarNulo(nlanfcslls, "N") = 1)
                THIS.this_lLancFinIss    = (TratarNulo(nlanfiss, "N") = 1)

                THIS.this_cCodOcorPis    = ALLTRIM(TratarNulo(cocorpiss, "C"))
                THIS.this_cCodOcorCofins = ALLTRIM(TratarNulo(cocorcofin, "C"))
                THIS.this_cCodOcorIrrf   = ALLTRIM(TratarNulo(cocorirrfs, "C"))
                THIS.this_cCodOcorInss   = ALLTRIM(TratarNulo(cocorinss, "C"))
                THIS.this_cCodOcorCsll   = ALLTRIM(TratarNulo(cocorcslls, "C"))
                THIS.this_cCodOcorIss    = ALLTRIM(TratarNulo(cocoriss, "C"))

                THIS.this_cCodCofins = ALLTRIM(TratarNulo(codcofinss, "C"))
                THIS.this_cCodCsll   = ALLTRIM(TratarNulo(codcslls, "C"))
                THIS.this_cCodPis    = ALLTRIM(TratarNulo(codpiss, "C"))

                THIS.this_cGrupoContab = ALLTRIM(TratarNulo(cgrupo, "C"))
                THIS.this_cContaContab = ALLTRIM(TratarNulo(ccontab, "C"))

                THIS.this_cGrupoPis    = ALLTRIM(TratarNulo(cgrppiss, "C"))
                THIS.this_cContaPis    = ALLTRIM(TratarNulo(cctapiss, "C"))
                THIS.this_cGrupoCofins = ALLTRIM(TratarNulo(cgrpcofins, "C"))
                THIS.this_cContaCofins = ALLTRIM(TratarNulo(cctacofins, "C"))
                THIS.this_cGrupoIrrf   = ALLTRIM(TratarNulo(cgrpirrfs, "C"))
                THIS.this_cContaIrrf   = ALLTRIM(TratarNulo(cctairrfs, "C"))
                THIS.this_cGrupoInss   = ALLTRIM(TratarNulo(cgrpinss, "C"))
                THIS.this_cContaInss   = ALLTRIM(TratarNulo(cctainss, "C"))
                THIS.this_cGrupoCsll   = ALLTRIM(TratarNulo(cgrpcslls, "C"))
                THIS.this_cContaCsll   = ALLTRIM(TratarNulo(cctacslls, "C"))
                THIS.this_cGrupoIss    = ALLTRIM(TratarNulo(cgrpiss, "C"))
                THIS.this_cContaIss    = ALLTRIM(TratarNulo(cctaiss, "C"))

                THIS.this_nVencimentoPis    = TratarNulo(vcpis, "N")
                THIS.this_nVencimentoCofins = TratarNulo(vccofins, "N")
                THIS.this_nVencimentoIrrf   = TratarNulo(vcirrf, "N")
                THIS.this_nVencimentoInss   = TratarNulo(vcinss, "N")
                THIS.this_nVencimentoCsll   = TratarNulo(vccsll, "N")
                THIS.this_nVencimentoIss    = TratarNulo(vciss, "N")

                THIS.this_nRPA                     = TratarNulo(nrpas, "N")
                THIS.this_nValorMaximoRetencaoInss = TratarNulo(maxretinss, "N")
                THIS.this_cCodRecCofins            = ALLTRIM(TratarNulo(codreccof, "C"))
                THIS.this_cCodRecPis               = ALLTRIM(TratarNulo(codrecpis, "C"))
                THIS.this_cCodRecCsll              = ALLTRIM(TratarNulo(codreccsll, "C"))
                THIS.this_cCodRecIrrf              = ALLTRIM(TratarNulo(codrecirrf, "C"))

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT INTO SigCdSrv (todas as colunas) + produtos
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdSrv" + ;
                " (cidchaves, codservs, descservs, ctipos," + ;
                " apiss, acofinss, airrfs, ainss, aiss, acslls," + ;
                " vminpiss, vmincofins, vminirrfs, vmininss, vmincslls," + ;
                " vminbpiss, vminbcofin, vminbirrfs, vminbinss, vminbcslls," + ;
                " bpisms, bcofinms, birrfms, binssms, bcsllms," + ;
                " nlanfpiss, nlanfcofin, nlanfirrfs, nlanfinss, nlanfcslls, nlanfiss," + ;
                " cocorpiss, cocorcofin, cocorirrfs, cocorinss, cocorcslls, cocoriss," + ;
                " codpiss, codcslls, codcofinss, cgrupo, ccontab," + ;
                " cgrppiss, cctapiss, cgrpcofins, cctacofins, cgrpirrfs, cctairrfs," + ;
                " cgrpinss, cctainss, cgrpcslls, cctacslls, cgrpiss, cctaiss," + ;
                " vcpis, vccofins, vcirrf, vcinss, vccsll, vciss," + ;
                " nrpas, maxretinss, codreccof, codrecpis, codreccsll, codrecirrf)"

            loc_cSQL = loc_cSQL + " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cCodigo) + ", " + ;
                EscaparSQL(THIS.this_cDescricao) + ", " + ;
                EscaparSQL(THIS.this_cTipo) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nAliquotaPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaIss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalPis, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalCofins, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalIrrf, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalInss, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalCsll, 1, 0)) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinPis, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinCofins, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinIrrf, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinInss, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinCsll, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinIss, 1, 0)) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodOcorPis) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorCofins) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorIrrf) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorInss) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorIss) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodPis) + ", " + ;
                EscaparSQL(THIS.this_cCodCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodCofins) + ", " + ;
                EscaparSQL(THIS.this_cGrupoContab) + ", " + ;
                EscaparSQL(THIS.this_cContaContab) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupoPis) + ", " + ;
                EscaparSQL(THIS.this_cContaPis) + ", " + ;
                EscaparSQL(THIS.this_cGrupoCofins) + ", " + ;
                EscaparSQL(THIS.this_cContaCofins) + ", " + ;
                EscaparSQL(THIS.this_cGrupoIrrf) + ", " + ;
                EscaparSQL(THIS.this_cContaIrrf) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupoInss) + ", " + ;
                EscaparSQL(THIS.this_cContaInss) + ", " + ;
                EscaparSQL(THIS.this_cGrupoCsll) + ", " + ;
                EscaparSQL(THIS.this_cContaCsll) + ", " + ;
                EscaparSQL(THIS.this_cGrupoIss) + ", " + ;
                EscaparSQL(THIS.this_cContaIss) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nVencimentoPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoCsll) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoIss) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nRPA) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMaximoRetencaoInss) + ", " + ;
                EscaparSQL(THIS.this_cCodRecCofins) + ", " + ;
                EscaparSQL(THIS.this_cCodRecPis) + ", " + ;
                EscaparSQL(THIS.this_cCodRecCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodRecIrrf) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = THIS.SalvarProdutos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Servico inserido mas erro ao salvar produtos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE SigCdSrv (todas as colunas editaveis) + produtos
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdSrv SET" + ;
                " descservs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                " apiss = " + FormatarNumeroSQL(THIS.this_nAliquotaPis) + "," + ;
                " acofinss = " + FormatarNumeroSQL(THIS.this_nAliquotaCofins) + "," + ;
                " airrfs = " + FormatarNumeroSQL(THIS.this_nAliquotaIrrf) + "," + ;
                " ainss = " + FormatarNumeroSQL(THIS.this_nAliquotaInss) + "," + ;
                " aiss = " + FormatarNumeroSQL(THIS.this_nAliquotaIss) + "," + ;
                " acslls = " + FormatarNumeroSQL(THIS.this_nAliquotaCsll) + "," + ;
                " vminpiss = " + FormatarNumeroSQL(THIS.this_nValorMinimoPis) + "," + ;
                " vmincofins = " + FormatarNumeroSQL(THIS.this_nValorMinimoCofins) + "," + ;
                " vminirrfs = " + FormatarNumeroSQL(THIS.this_nValorMinimoIrrf) + "," + ;
                " vmininss = " + FormatarNumeroSQL(THIS.this_nValorMinimoInss) + "," + ;
                " vmincslls = " + FormatarNumeroSQL(THIS.this_nValorMinimoCsll)

            loc_cSQL = loc_cSQL + "," + ;
                " vminbpiss = " + FormatarNumeroSQL(THIS.this_nBaseMinimaPis) + "," + ;
                " vminbcofin = " + FormatarNumeroSQL(THIS.this_nBaseMinimaCofins) + "," + ;
                " vminbirrfs = " + FormatarNumeroSQL(THIS.this_nBaseMinimaIrrf) + "," + ;
                " vminbinss = " + FormatarNumeroSQL(THIS.this_nBaseMinimaInss) + "," + ;
                " vminbcslls = " + FormatarNumeroSQL(THIS.this_nBaseMinimaCsll) + "," + ;
                " bpisms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalPis, 1, 0)) + "," + ;
                " bcofinms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalCofins, 1, 0)) + "," + ;
                " birrfms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalIrrf, 1, 0)) + "," + ;
                " binssms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalInss, 1, 0)) + "," + ;
                " bcsllms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalCsll, 1, 0))

            loc_cSQL = loc_cSQL + "," + ;
                " nlanfpiss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinPis, 1, 0)) + "," + ;
                " nlanfcofin = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinCofins, 1, 0)) + "," + ;
                " nlanfirrfs = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinIrrf, 1, 0)) + "," + ;
                " nlanfinss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinInss, 1, 0)) + "," + ;
                " nlanfcslls = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinCsll, 1, 0)) + "," + ;
                " nlanfiss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinIss, 1, 0)) + "," + ;
                " cocorpiss = " + EscaparSQL(THIS.this_cCodOcorPis) + "," + ;
                " cocorcofin = " + EscaparSQL(THIS.this_cCodOcorCofins) + "," + ;
                " cocorirrfs = " + EscaparSQL(THIS.this_cCodOcorIrrf) + "," + ;
                " cocorinss = " + EscaparSQL(THIS.this_cCodOcorInss)

            loc_cSQL = loc_cSQL + "," + ;
                " cocorcslls = " + EscaparSQL(THIS.this_cCodOcorCsll) + "," + ;
                " cocoriss = " + EscaparSQL(THIS.this_cCodOcorIss) + "," + ;
                " codpiss = " + EscaparSQL(THIS.this_cCodPis) + "," + ;
                " codcslls = " + EscaparSQL(THIS.this_cCodCsll) + "," + ;
                " codcofinss = " + EscaparSQL(THIS.this_cCodCofins) + "," + ;
                " cgrupo = " + EscaparSQL(THIS.this_cGrupoContab) + "," + ;
                " ccontab = " + EscaparSQL(THIS.this_cContaContab) + "," + ;
                " cgrppiss = " + EscaparSQL(THIS.this_cGrupoPis) + "," + ;
                " cctapiss = " + EscaparSQL(THIS.this_cContaPis) + "," + ;
                " cgrpcofins = " + EscaparSQL(THIS.this_cGrupoCofins)

            loc_cSQL = loc_cSQL + "," + ;
                " cctacofins = " + EscaparSQL(THIS.this_cContaCofins) + "," + ;
                " cgrpirrfs = " + EscaparSQL(THIS.this_cGrupoIrrf) + "," + ;
                " cctairrfs = " + EscaparSQL(THIS.this_cContaIrrf) + "," + ;
                " cgrpinss = " + EscaparSQL(THIS.this_cGrupoInss) + "," + ;
                " cctainss = " + EscaparSQL(THIS.this_cContaInss) + "," + ;
                " cgrpcslls = " + EscaparSQL(THIS.this_cGrupoCsll) + "," + ;
                " cctacslls = " + EscaparSQL(THIS.this_cContaCsll) + "," + ;
                " cgrpiss = " + EscaparSQL(THIS.this_cGrupoIss) + "," + ;
                " cctaiss = " + EscaparSQL(THIS.this_cContaIss) + "," + ;
                " vcpis = " + FormatarNumeroSQL(THIS.this_nVencimentoPis)

            loc_cSQL = loc_cSQL + "," + ;
                " vccofins = " + FormatarNumeroSQL(THIS.this_nVencimentoCofins) + "," + ;
                " vcirrf = " + FormatarNumeroSQL(THIS.this_nVencimentoIrrf) + "," + ;
                " vcinss = " + FormatarNumeroSQL(THIS.this_nVencimentoInss) + "," + ;
                " vccsll = " + FormatarNumeroSQL(THIS.this_nVencimentoCsll) + "," + ;
                " vciss = " + FormatarNumeroSQL(THIS.this_nVencimentoIss) + "," + ;
                " nrpas = " + FormatarNumeroSQL(THIS.this_nRPA) + "," + ;
                " maxretinss = " + FormatarNumeroSQL(THIS.this_nValorMaximoRetencaoInss) + "," + ;
                " codreccof = " + EscaparSQL(THIS.this_cCodRecCofins) + "," + ;
                " codrecpis = " + EscaparSQL(THIS.this_cCodRecPis) + "," + ;
                " codreccsll = " + EscaparSQL(THIS.this_cCodRecCsll) + "," + ;
                " codrecirrf = " + EscaparSQL(THIS.this_cCodRecIrrf)

            loc_cSQL = loc_cSQL + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = THIS.SalvarProdutos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Servico atualizado mas erro ao salvar produtos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE SigSeRvp (produtos) + DELETE SigCdSrv
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Remove produtos relacionados primeiro
            loc_cSQL = "DELETE FROM SigSeRvp WHERE codservs = " + ;
                       EscaparSQL(THIS.this_cCodigo)

            IF USED("cursor_4c_DelProd")
                TABLEREVERT(.T., "cursor_4c_DelProd")
                USE IN cursor_4c_DelProd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelProd")
            IF USED("cursor_4c_DelProd")
                USE IN cursor_4c_DelProd
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir produtos do servico:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remove o registro principal
                loc_cSQL = "DELETE FROM SigCdSrv WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidChaves)

                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir servico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.ExecutarExclusao:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarProdutos - Carrega produtos do servico (SigSeRvp) no cursor
    * do grid (this_cCursorProdutos), com descricao via JOIN SigCdPro
    *====================================================================
    FUNCTION CarregarProdutos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorProdutos)
                USE IN (THIS.this_cCursorProdutos)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos (CidChaves C(20), CodServs C(10), CPros C(14), DPros C(40))
            SET NULL OFF

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.cidchaves AS CidChaves, a.codservs AS CodServs," + ;
                           " a.cpros AS CPros, b.dpros AS DPros" + ;
                           " FROM SigSeRvp a" + ;
                           " LEFT JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                           " WHERE a.codservs = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_ProdTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdTmp")
                    USE IN cursor_4c_ProdTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Produtos
                    APPEND FROM DBF("cursor_4c_ProdTmp")
                    IF USED("cursor_4c_ProdTmp")
                        USE IN cursor_4c_ProdTmp
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar produtos do servico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            GO TOP IN cursor_4c_Produtos
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarProdutos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * SalvarProdutos - Persiste cursor_4c_Produtos em SigSeRvp
    * (remove todos os produtos do servico e reinsere os atuais)
    *====================================================================
    PROTECTED FUNCTION SalvarProdutos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aProdutos[1]
        loc_lResultado = .F.

        TRY
            *-- Remove todos os produtos existentes para este servico
            loc_cSQL = "DELETE FROM SigSeRvp WHERE codservs = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_DelProdSalvar")
                TABLEREVERT(.T., "cursor_4c_DelProdSalvar")
                USE IN cursor_4c_DelProdSalvar
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelProdSalvar")
            IF USED("cursor_4c_DelProdSalvar")
                USE IN cursor_4c_DelProdSalvar
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar produtos do servico:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.

                *-- Coleta codigos de produto nao-vazios do cursor numa array
                IF USED(THIS.this_cCursorProdutos)
                    loc_nTotal = RECCOUNT(THIS.this_cCursorProdutos)
                    IF loc_nTotal > 0
                        DIMENSION loc_aProdutos[loc_nTotal]
                        SELECT (THIS.this_cCursorProdutos)
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aProdutos[loc_nI] = ALLTRIM(cursor_4c_Produtos.CPros)
                            IF !EOF(THIS.this_cCursorProdutos)
                                SKIP IN (THIS.this_cCursorProdutos)
                            ENDIF
                        ENDFOR

                        *-- Insere os produtos via SQL
                        FOR loc_nI = 1 TO loc_nTotal
                            IF !EMPTY(loc_aProdutos[loc_nI])
                                loc_cSQL = "INSERT INTO SigSeRvp (cidchaves, codservs, cpros)" + ;
                                           " VALUES (" + ;
                                           EscaparSQL(fUniqueIds()) + ", " + ;
                                           EscaparSQL(ALLTRIM(par_cCodigo)) + ", " + ;
                                           EscaparSQL(loc_aProdutos[loc_nI]) + ")"

                                IF USED("cursor_4c_InsProd")
                                    TABLEREVERT(.T., "cursor_4c_InsProd")
                                    USE IN cursor_4c_InsProd
                                ENDIF

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsProd")
                                IF USED("cursor_4c_InsProd")
                                    USE IN cursor_4c_InsProd
                                ENDIF

                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir produto " + loc_aProdutos[loc_nI] + ;
                                             ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                ENDIF
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.SalvarProdutos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

