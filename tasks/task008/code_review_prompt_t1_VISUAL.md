# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [ALINHAMENTO] Botao 'cmd_4c_Minimo' tem Top=166 mas grupo usa Top=181 (diferenca de 15px)
- [ALINHAMENTO] Botao 'cmd_4c_CopiarProduto' tem Top=4 mas grupo usa Top=5 (diferenca de 1px)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (12585 linhas total):

*-- Linhas 82 a 109:
82:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83:             loc_oPgf = THIS.pgf_4c_Paginas
84:             WITH loc_oPgf
85:                 .Top       = -29
86:                 .Left      = 0
87:                 .Width     = 1000
88:                 .Height    = 629
89:                 .PageCount = 2
90:                 .Tabs      = .F.
91:                 .Themes    = .F.
92:                 .Visible   = .T.
93:             ENDWITH
94: 
95:             loc_oPage1 = loc_oPgf.Page1
96:             WITH loc_oPage1
97:                 .Caption   = "Lista"
98:                 .BackColor = RGB(53,53,53)
99:             ENDWITH
100:             THIS.ConfigurarPage1(loc_oPage1)
101: 
102:             loc_oPage2 = loc_oPgf.Page2
103:             WITH loc_oPage2
104:                 .Caption   = "Dados"
105:                 .BackColor = RGB(53,53,53)
106:             ENDWITH
107:             THIS.ConfigurarPage2(loc_oPage2)
108: 
109:         CATCH TO loc_oErro

*-- Linhas 118 a 186:
118:             *-- Cabecalho (cntSombra no legado) - Top = 2+29 = 31
119:             par_oPage.AddObject("cnt_4c_Cabecalho", "Container")
120:             WITH par_oPage.cnt_4c_Cabecalho
121:                 .Top         = 31
122:                 .Left        = 0
123:                 .Width       = 800
124:                 .Height      = 80
125:                 .BackStyle   = 1
126:                 .BackColor   = RGB(53,53,53)
127:                 .BorderWidth = 0
128:                 .Visible     = .T.
129:             ENDWITH
130: 
131:             par_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:             WITH par_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
133:                 .Top       = 15
134:                 .Left      = 10
135:                 .Width     = 769
136:                 .Height    = 40
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 16
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(0,0,0)
141:                 .BackStyle = 0
142:                 .Caption   = "Cadastro de Produtos"
143:                 .Visible   = .T.
144:             ENDWITH
145: 
146:             par_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:             WITH par_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
148:                 .Top       = 18
149:                 .Left      = 10
150:                 .Width     = 769
151:                 .Height    = 46
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 16
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(255,255,255)
156:                 .BackStyle = 0
157:                 .Caption   = "Cadastro de Produtos"
158:                 .Visible   = .T.
159:             ENDWITH
160: 
161:             *-- Botoes CRUD (Grupo_Op no legado) - Top = 0+29 = 29
162:             par_oPage.AddObject("cnt_4c_Botoes", "Container")
163:             WITH par_oPage.cnt_4c_Botoes
164:                 .Top         = 29
165:                 .Left        = 542
166:                 .Width       = 390
167:                 .Height      = 85
168:                 .BackStyle   = 1
169:                 .BackColor   = RGB(53,53,53)
170:                 .BorderWidth = 0
171:                 .Visible     = .T.
172:             ENDWITH
173: 
174:             *-- Botao Incluir
175:             par_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:             WITH par_oPage.cnt_4c_Botoes.cmd_4c_Incluir
177:                 .Top             = 5
178:                 .Left            = 5
179:                 .Width           = 75
180:                 .Height          = 75
181:                 .Caption         = "Incluir"
182:                 .FontName        = "Comic Sans MS"
183:                 .FontBold        = .T.
184:                 .FontItalic      = .T.
185:                 .FontSize        = 8
186:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 196 a 210:
196:             ENDWITH
197: 
198:             *-- Botao Visualizar
199:             par_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:             WITH par_oPage.cnt_4c_Botoes.cmd_4c_Visualizar
201:                 .Top             = 5
202:                 .Left            = 80
203:                 .Width           = 75
204:                 .Height          = 75
205:                 .Caption         = "Visualizar"
206:                 .FontName        = "Comic Sans MS"
207:                 .FontBold        = .T.
208:                 .FontItalic      = .T.
209:                 .FontSize        = 8
210:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 220 a 234:
220:             ENDWITH
221: 
222:             *-- Botao Alterar
223:             par_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:             WITH par_oPage.cnt_4c_Botoes.cmd_4c_Alterar
225:                 .Top             = 5
226:                 .Left            = 155
227:                 .Width           = 75
228:                 .Height          = 75
229:                 .Caption         = "Alterar"
230:                 .FontName        = "Comic Sans MS"
231:                 .FontBold        = .T.
232:                 .FontItalic      = .T.
233:                 .FontSize        = 8
234:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 244 a 258:
244:             ENDWITH
245: 
246:             *-- Botao Excluir
247:             par_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:             WITH par_oPage.cnt_4c_Botoes.cmd_4c_Excluir
249:                 .Top             = 5
250:                 .Left            = 230
251:                 .Width           = 75
252:                 .Height          = 75
253:                 .Caption         = "Excluir"
254:                 .FontName        = "Comic Sans MS"
255:                 .FontBold        = .T.
256:                 .FontItalic      = .T.
257:                 .FontSize        = 8
258:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 268 a 282:
268:             ENDWITH
269: 
270:             *-- Botao Buscar
271:             par_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:             WITH par_oPage.cnt_4c_Botoes.cmd_4c_Buscar
273:                 .Top             = 5
274:                 .Left            = 305
275:                 .Width           = 75
276:                 .Height          = 75
277:                 .Caption         = "Buscar"
278:                 .FontName        = "Comic Sans MS"
279:                 .FontBold        = .T.
280:                 .FontItalic      = .T.
281:                 .FontSize        = 8
282:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 294 a 318:
294:             *-- Container de saida (Grupo_Saida no legado) - Top = 0+29 = 29
295:             par_oPage.AddObject("cnt_4c_Saida", "Container")
296:             WITH par_oPage.cnt_4c_Saida
297:                 .Top         = 29
298:                 .Left        = 935
299:                 .Width       = 60
300:                 .Height      = 85
301:                 .BackStyle   = 1
302:                 .BackColor   = RGB(53,53,53)
303:                 .BorderWidth = 0
304:                 .Visible     = .T.
305:             ENDWITH
306: 
307:             par_oPage.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
308:             WITH par_oPage.cnt_4c_Saida.cmd_4c_Encerrar
309:                 .Top             = 5
310:                 .Left            = 5
311:                 .Width           = 50
312:                 .Height          = 75
313:                 .Caption         = "X"
314:                 .FontName        = "Comic Sans MS"
315:                 .FontBold        = .T.
316:                 .FontItalic      = .T.
317:                 .FontSize        = 8
318:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 348 a 454:
348:             *-- Container de filtros (cntFiltros no legado) - Top = 82+29 = 111
349:             par_oPage.AddObject("cnt_4c_Filtros", "Container")
350:             WITH par_oPage.cnt_4c_Filtros
351:                 .Top         = 111
352:                 .Left        = 2
353:                 .Width       = 395
354:                 .Height      = 68
355:                 .BackStyle   = 0
356:                 .BorderStyle = 1
357:                 .Visible     = .T.
358:             ENDWITH
359: 
360:             par_oPage.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
361:             WITH par_oPage.cnt_4c_Filtros.lbl_4c_LblGrupo
362:                 .Top       = 18
363:                 .Left      = 21
364:                 .Width     = 94
365:                 .Height    = 15
366:                 .FontName  = "Tahoma"
367:                 .FontSize  = 8
368:                 .ForeColor = RGB(0,0,0)
369:                 .BackStyle = 0
370:                 .Caption   = "Grupo de Produto :"
371:                 .Visible   = .T.
372:             ENDWITH
373: 
374:             *-- Campo codigo grupo (getCgru no legado)
375:             par_oPage.cnt_4c_Filtros.AddObject("txt_4c_CodGrupo", "TextBox")
376:             WITH par_oPage.cnt_4c_Filtros.txt_4c_CodGrupo
377:                 .Top       = 14
378:                 .Left      = 116
379:                 .Width     = 31
380:                 .Height    = 23
381:                 .FontName  = "Tahoma"
382:                 .FontSize  = 8
383:                 .MaxLength = 10
384:                 .Themes    = .F.
385:                 .Visible   = .T.
386:             ENDWITH
387: 
388:             *-- Campo descricao grupo (getDgru no legado - somente leitura)
389:             par_oPage.cnt_4c_Filtros.AddObject("txt_4c_DesGrupo", "TextBox")
390:             WITH par_oPage.cnt_4c_Filtros.txt_4c_DesGrupo
391:                 .Top       = 14
392:                 .Left      = 149
393:                 .Width     = 156
394:                 .Height    = 23
395:                 .FontName  = "Tahoma"
396:                 .FontSize  = 8
397:                 .ReadOnly  = .T.
398:                 .Themes    = .F.
399:                 .Visible   = .T.
400:             ENDWITH
401: 
402:             par_oPage.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
403:             WITH par_oPage.cnt_4c_Filtros.lbl_4c_LblData1
404:                 .Top       = 43
405:                 .Left      = 28
406:                 .Width     = 87
407:                 .Height    = 15
408:                 .FontName  = "Tahoma"
409:                 .FontSize  = 8
410:                 .ForeColor = RGB(0,0,0)
411:                 .BackStyle = 0
412:                 .Caption   = CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
413:                 .Visible   = .T.
414:             ENDWITH
415: 
416:             *-- Campo data inicial (getDtIni no legado)
417:             par_oPage.cnt_4c_Filtros.AddObject("txt_4c_DtAlterIni", "TextBox")
418:             WITH par_oPage.cnt_4c_Filtros.txt_4c_DtAlterIni
419:                 .Top       = 39
420:                 .Left      = 116
421:                 .Width     = 85
422:                 .Height    = 23
423:                 .FontName  = "Tahoma"
424:                 .FontSize  = 8
425:                 .Value     = {}
426:                 .Format    = "D"
427:                 .Themes    = .F.
428:                 .Visible   = .T.
429:             ENDWITH
430: 
431:             par_oPage.cnt_4c_Filtros.AddObject("lbl_4c_LblData2", "Label")
432:             WITH par_oPage.cnt_4c_Filtros.lbl_4c_LblData2
433:                 .Top       = 43
434:                 .Left      = 202
435:                 .Width     = 18
436:                 .Height    = 15
437:                 .FontName  = "Tahoma"
438:                 .FontSize  = 8
439:                 .ForeColor = RGB(0,0,0)
440:                 .BackStyle = 0
441:                 .Caption   = "at" + CHR(233)
442:                 .Visible   = .T.
443:             ENDWITH
444: 
445:             *-- Campo data final (getDtFim no legado)
446:             par_oPage.cnt_4c_Filtros.AddObject("txt_4c_DtAlterFim", "TextBox")
447:             WITH par_oPage.cnt_4c_Filtros.txt_4c_DtAlterFim
448:                 .Top       = 39
449:                 .Left      = 225
450:                 .Width     = 85
451:                 .Height    = 23
452:                 .FontName  = "Tahoma"
453:                 .FontSize  = 8
454:                 .Value     = {}

*-- Linhas 460 a 550:
460:             *-- OptionGroup situacao (optFilSituas no legado: 3 botoes Todos/Ativos/Inativos)
461:             par_oPage.cnt_4c_Filtros.AddObject("opt_4c_Situacao", "OptionGroup")
462:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao
463:                 .Top         = 5
464:                 .Left        = 315
465:                 .Width       = 75
466:                 .Height      = 58
467:                 .ButtonCount = 3
468:                 .Value       = 1
469:                 .Themes      = .F.
470:                 .Visible     = .T.
471:             ENDWITH
472: 
473:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(1)
474:                 .Caption   = "Todos"
475:                 .Top       = 0
476:                 .Left      = 0
477:                 .Width     = 65
478:                 .Height    = 17
479:                 .FontName  = "Tahoma"
480:                 .FontSize  = 8
481:                 .Themes    = .F.
482:                 .Value     = 1
483:             ENDWITH
484: 
485:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(2)
486:                 .Caption   = "Ativos"
487:                 .Top       = 19
488:                 .Left      = 0
489:                 .Width     = 65
490:                 .Height    = 17
491:                 .FontName  = "Tahoma"
492:                 .FontSize  = 8
493:                 .Themes    = .F.
494:             ENDWITH
495: 
496:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(3)
497:                 .Caption   = "Inativos"
498:                 .Top       = 38
499:                 .Left      = 0
500:                 .Width     = 65
501:                 .Height    = 17
502:                 .FontName  = "Tahoma"
503:                 .FontSize  = 8
504:                 .Themes    = .F.
505:             ENDWITH
506: 
507:             *-- Container de mensagem "Aguarde" (cntMensagem no legado - Visible=.F.)
508:             par_oPage.AddObject("cnt_4c_Mensagem", "Container")
509:             WITH par_oPage.cnt_4c_Mensagem
510:                 .Top         = 255 + 29
511:                 .Left        = 254
512:                 .Width       = 490
513:                 .Height      = 90
514:                 .BackStyle   = 1
515:                 .BackColor   = RGB(255,255,255)
516:                 .BorderWidth = 1
517:                 .Visible     = .F.
518:             ENDWITH
519: 
520:             par_oPage.cnt_4c_Mensagem.AddObject("lbl_4c_Aguarde", "Label")
521:             WITH par_oPage.cnt_4c_Mensagem.lbl_4c_Aguarde
522:                 .Top       = 32
523:                 .Left      = 72
524:                 .Width     = 345
525:                 .Height    = 25
526:                 .FontName  = "Tahoma"
527:                 .FontSize  = 8
528:                 .BackStyle = 0
529:                 .Caption   = "Aguarde!!! Selecionando Produtos..."
530:                 .Visible   = .T.
531:             ENDWITH
532: 
533:             *-- Botao Copiar Produto (cmdAcabado no legado - Visible=.F.)
534:             par_oPage.AddObject("cmd_4c_CopiarProduto", "CommandButton")
535:             WITH par_oPage.cmd_4c_CopiarProduto
536:                 .Top             = 4 + 29
537:                 .Left            = 472
538:                 .Width           = 75
539:                 .Height          = 75
540:                 .Caption         = "Copiar um Produto"
541:                 .FontName        = "Comic Sans MS"
542:                 .FontBold        = .T.
543:                 .FontItalic      = .T.
544:                 .FontSize        = 8
545:                 .ForeColor       = RGB(90,90,90)
546:                 .BackColor       = RGB(255,255,255)
547:                 .Themes          = .F.
548:                 .SpecialEffect   = 0
549:                 .PicturePosition = 13
550:                 .MousePointer    = 15

*-- Linhas 556 a 908:
556:             *-- Container Copiar Produto (CntAcabado no legado - Visible=.F.)
557:             par_oPage.AddObject("cnt_4c_Acabado", "Container")
558:             WITH par_oPage.cnt_4c_Acabado
559:                 .Top         = 257 + 29
560:                 .Left        = 282
561:                 .Width       = 435
562:                 .Height      = 139
563:                 .BackStyle   = 1
564:                 .BackColor   = RGB(255,255,255)
565:                 .BorderWidth = 1
566:                 .Visible     = .F.
567:             ENDWITH
568: 
569:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_NotOk", "Label")
570:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_NotOk
571:                 .Top       = 110
572:                 .Left      = 17
573:                 .Width     = 306
574:                 .Height    = 17
575:                 .FontName  = "Tahoma"
576:                 .FontSize  = 8
577:                 .BackStyle = 0
578:                 .Caption   = "Novo Produto N" + CHR(227) + "o Foi Criado!"
579:                 .Visible   = .F.
580:             ENDWITH
581: 
582:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_Ok", "Label")
583:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_Ok
584:                 .Top       = 110
585:                 .Left      = 17
586:                 .Width     = 306
587:                 .Height    = 17
588:                 .FontName  = "Tahoma"
589:                 .FontSize  = 8
590:                 .BackStyle = 0
591:                 .Caption   = "Novo Produto Criado!"
592:                 .Visible   = .F.
593:             ENDWITH
594: 
595:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_Say5", "Label")
596:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_Say5
597:                 .Top       = 32
598:                 .Left      = 31
599:                 .Width     = 75
600:                 .Height    = 15
601:                 .FontName  = "Tahoma"
602:                 .FontSize  = 8
603:                 .BackStyle = 0
604:                 .Caption   = "Produto Atual :"
605:                 .Visible   = .T.
606:             ENDWITH
607: 
608:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_Say2", "Label")
609:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_Say2
610:                 .Top       = 61
611:                 .Left      = 31
612:                 .Width     = 75
613:                 .Height    = 15
614:                 .FontName  = "Tahoma"
615:                 .FontSize  = 8
616:                 .BackStyle = 0
617:                 .Caption   = "Novo Produto :"
618:                 .Visible   = .T.
619:             ENDWITH
620: 
621:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_Say1Ref", "Label")
622:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_Say1Ref
623:                 .Top       = 10
624:                 .Left      = 108
625:                 .Width     = 63
626:                 .Height    = 15
627:                 .FontName  = "Tahoma"
628:                 .FontSize  = 8
629:                 .BackStyle = 0
630:                 .Caption   = "Refer" + CHR(234) + "ncia"
631:                 .Visible   = .T.
632:             ENDWITH
633: 
634:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_Say3Grp", "Label")
635:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_Say3Grp
636:                 .Top       = 10
637:                 .Left      = 223
638:                 .Width     = 36
639:                 .Height    = 15
640:                 .FontName  = "Tahoma"
641:                 .FontSize  = 8
642:                 .BackStyle = 0
643:                 .Caption   = "Grupo"
644:                 .Visible   = .T.
645:             ENDWITH
646: 
647:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_Say12Ref", "Label")
648:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_Say12Ref
649:                 .Top       = 10
650:                 .Left      = 272
651:                 .Width     = 91
652:                 .Height    = 15
653:                 .FontName  = "Tahoma"
654:                 .FontSize  = 8
655:                 .BackStyle = 0
656:                 .Caption   = "Ref. Fornecedor"
657:                 .Visible   = .T.
658:             ENDWITH
659: 
660:             par_oPage.cnt_4c_Acabado.AddObject("lbl_4c_SaySit", "Label")
661:             WITH par_oPage.cnt_4c_Acabado.lbl_4c_SaySit
662:                 .Top       = 83
663:                 .Left      = 56
664:                 .Width     = 45
665:                 .Height    = 15
666:                 .FontName  = "Tahoma"
667:                 .FontSize  = 8
668:                 .BackStyle = 0
669:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
670:                 .Visible   = .T.
671:             ENDWITH
672: 
673:             par_oPage.cnt_4c_Acabado.AddObject("txt_4c_OldCPro", "TextBox")
674:             WITH par_oPage.cnt_4c_Acabado.txt_4c_OldCPro
675:                 .Top      = 28
676:                 .Left     = 108
677:                 .Width    = 108
678:                 .Height   = 23
679:                 .FontName = "Tahoma"
680:                 .FontSize = 8
681:                 .ReadOnly = .T.
682:                 .Themes   = .F.
683:                 .Visible  = .T.
684:             ENDWITH
685: 
686:             par_oPage.cnt_4c_Acabado.AddObject("txt_4c_NewCPro", "TextBox")
687:             WITH par_oPage.cnt_4c_Acabado.txt_4c_NewCPro
688:                 .Top      = 57
689:                 .Left     = 108
690:                 .Width    = 108
691:                 .Height   = 23
692:                 .FontName = "Tahoma"
693:                 .FontSize = 8
694:                 .Themes   = .F.
695:                 .Visible  = .T.
696:             ENDWITH
697: 
698:             par_oPage.cnt_4c_Acabado.AddObject("txt_4c_OldCGrus", "TextBox")
699:             WITH par_oPage.cnt_4c_Acabado.txt_4c_OldCGrus
700:                 .Top      = 28
701:                 .Left     = 223
702:                 .Width    = 41
703:                 .Height   = 23
704:                 .FontName = "Tahoma"
705:                 .FontSize = 8
706:                 .ReadOnly = .T.
707:                 .Themes   = .F.
708:                 .Visible  = .T.
709:             ENDWITH
710: 
711:             par_oPage.cnt_4c_Acabado.AddObject("txt_4c_NewCGrus", "TextBox")
712:             WITH par_oPage.cnt_4c_Acabado.txt_4c_NewCGrus
713:                 .Top      = 57
714:                 .Left     = 223
715:                 .Width    = 41
716:                 .Height   = 23
717:                 .FontName = "Tahoma"
718:                 .FontSize = 8
719:                 .Themes   = .F.
720:                 .Visible  = .T.
721:             ENDWITH
722: 
723:             par_oPage.cnt_4c_Acabado.AddObject("txt_4c_OldReffs", "TextBox")
724:             WITH par_oPage.cnt_4c_Acabado.txt_4c_OldReffs
725:                 .Top      = 28
726:                 .Left     = 272
727:                 .Width    = 152
728:                 .Height   = 23
729:                 .FontName = "Tahoma"
730:                 .FontSize = 8
731:                 .ReadOnly = .T.
732:                 .Themes   = .F.
733:                 .Visible  = .T.
734:             ENDWITH
735: 
736:             par_oPage.cnt_4c_Acabado.AddObject("txt_4c_NewReffs", "TextBox")
737:             WITH par_oPage.cnt_4c_Acabado.txt_4c_NewReffs
738:                 .Top      = 57
739:                 .Left     = 272
740:                 .Width    = 152
741:                 .Height   = 23
742:                 .FontName = "Tahoma"
743:                 .FontSize = 8
744:                 .Themes   = .F.
745:                 .Visible  = .T.
746:             ENDWITH
747: 
748:             par_oPage.cnt_4c_Acabado.AddObject("opt_4c_SituacaoCopia", "OptionGroup")
749:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia
750:                 .Top         = 83
751:                 .Left        = 102
752:                 .Width       = 129
753:                 .Height      = 17
754:                 .ButtonCount = 2
755:                 .Value       = 1
756:                 .Themes      = .F.
757:                 .Visible     = .T.
758:             ENDWITH
759: 
760:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia.Buttons(1)
761:                 .Caption  = "Ativo"
762:                 .Top      = 0
763:                 .Left     = 0
764:                 .Width    = 55
765:                 .Height   = 17
766:                 .FontName = "Tahoma"
767:                 .FontSize = 8
768:                 .Themes   = .F.
769:             ENDWITH
770: 
771:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia.Buttons(2)
772:                 .Caption  = "Inativo"
773:                 .Top      = 0
774:                 .Left     = 60
775:                 .Width    = 55
776:                 .Height   = 17
777:                 .FontName = "Tahoma"
778:                 .FontSize = 8
779:                 .Themes   = .F.
780:             ENDWITH
781: 
782:             par_oPage.cnt_4c_Acabado.AddObject("cmd_4c_OkCopia", "CommandButton")
783:             WITH par_oPage.cnt_4c_Acabado.cmd_4c_OkCopia
784:                 .Top      = 90
785:                 .Left     = 344
786:                 .Width    = 40
787:                 .Height   = 40
788:                 .Caption  = ""
789:                 .FontName = "Tahoma"
790:                 .FontSize = 8
791:                 .Themes   = .F.
792:                 .Visible  = .T.
793:             ENDWITH
794: 
795:             par_oPage.cnt_4c_Acabado.AddObject("cmd_4c_CancelCopia", "CommandButton")
796:             WITH par_oPage.cnt_4c_Acabado.cmd_4c_CancelCopia
797:                 .Top      = 90
798:                 .Left     = 384
799:                 .Width    = 40
800:                 .Height   = 40
801:                 .Caption  = ""
802:                 .FontName = "Tahoma"
803:                 .FontSize = 8
804:                 .Themes   = .F.
805:                 .Visible  = .T.
806:             ENDWITH
807: 
808:             *-- Container Botoes de cor (3 textboxes indicadores - legado)
809:             par_oPage.AddObject("cnt_4c_BotoesCor", "Container")
810:             WITH par_oPage.cnt_4c_BotoesCor
811:                 .Top         = 171 + 29
812:                 .Left        = 959
813:                 .Width       = 24
814:                 .Height      = 71
815:                 .BackStyle   = 0
816:                 .BorderWidth = 0
817:                 .Visible     = .T.
818:             ENDWITH
819: 
820:             par_oPage.cnt_4c_BotoesCor.AddObject("txt_4c_Botao1", "TextBox")
821:             WITH par_oPage.cnt_4c_BotoesCor.txt_4c_Botao1
822:                 .Top      = 3
823:                 .Left     = 2
824:                 .Width    = 22
825:                 .Height   = 22
826:                 .FontName = "Tahoma"
827:                 .FontSize = 8
828:                 .ReadOnly = .T.
829:                 .Themes   = .F.
830:                 .Visible  = .T.
831:             ENDWITH
832: 
833:             par_oPage.cnt_4c_BotoesCor.AddObject("txt_4c_Botao2", "TextBox")
834:             WITH par_oPage.cnt_4c_BotoesCor.txt_4c_Botao2
835:                 .Top      = 24
836:                 .Left     = 2
837:                 .Width    = 22
838:                 .Height   = 22
839:                 .FontName = "Tahoma"
840:                 .FontSize = 8
841:                 .ReadOnly = .T.
842:                 .Themes   = .F.
843:                 .Visible  = .T.
844:             ENDWITH
845: 
846:             par_oPage.cnt_4c_BotoesCor.AddObject("txt_4c_Botao3", "TextBox")
847:             WITH par_oPage.cnt_4c_BotoesCor.txt_4c_Botao3
848:                 .Top      = 46
849:                 .Left     = 2
850:                 .Width    = 22
851:                 .Height   = 22
852:                 .FontName = "Tahoma"
853:                 .FontSize = 8
854:                 .ReadOnly = .T.
855:                 .Themes   = .F.
856:                 .Visible  = .T.
857:             ENDWITH
858: 
859:             *-- Imagem produto (ImgFigJpg no legado - Visible=.F.)
860:             par_oPage.AddObject("img_4c_FigJpg", "Image")
861:             WITH par_oPage.img_4c_FigJpg
862:                 .Top     = 84 + 29
863:                 .Left    = 737
864:                 .Width   = 223
865:                 .Height  = 87
866:                 .Visible = .F.
867:             ENDWITH
868: 
869:             *-- Label "MENU FISCAL INACESSIVEL" (lblSemMenu no legado - Visible=.F.)
870:             par_oPage.AddObject("lbl_4c_SemMenu", "Label")
871:             WITH par_oPage.lbl_4c_SemMenu
872:                 .Top       = 53 + 29
873:                 .Left      = 23
874:                 .Width     = 251
875:                 .Height    = 16
876:                 .FontName  = "Tahoma"
877:                 .FontSize  = 8
878:                 .BackStyle = 0
879:                 .Caption   = "MENU FISCAL INACESS" + CHR(205) + "VEL NESTA TELA"
880:                 .Visible   = .F.
881:             ENDWITH
882: 
883:             *-- Label contador de produtos (lblProdutos no legado)
884:             par_oPage.AddObject("lbl_4c_Produtos", "Label")
885:             WITH par_oPage.lbl_4c_Produtos
886:                 .Top       = 575
887:                 .Left      = 38
888:                 .Width     = 220
889:                 .Height    = 15
890:                 .FontName  = "Tahoma"
891:                 .FontSize  = 8
892:                 .ForeColor = RGB(0,0,0)
893:                 .BackStyle = 0
894:                 .Caption   = "Produtos Selecionados : 0"
895:                 .Visible   = .T.
896:             ENDWITH
897: 
898:             *-- Grid principal (Grade no legado)
899:             *-- Top = 182 (82+29 cntFiltros + 68 altura + 3 gap + compensacao)
900:             *-- RecordSource e colunas definidos FORA de WITH (critico VFP9)
901:             par_oPage.AddObject("grd_4c_Lista", "Grid")
902:             par_oPage.grd_4c_Lista.Top               = 182
903:             par_oPage.grd_4c_Lista.Left              = 2
904:             par_oPage.grd_4c_Lista.Width             = 930
905:             par_oPage.grd_4c_Lista.Height            = 390
906:             par_oPage.grd_4c_Lista.ColumnCount       = 7
907:             par_oPage.grd_4c_Lista.FontName          = "Verdana"
908:             par_oPage.grd_4c_Lista.FontSize          = 8

*-- Linhas 920 a 929:
920:             par_oPage.grd_4c_Lista.Themes            = .F.
921:             par_oPage.grd_4c_Lista.Visible           = .T.
922: 
923:             *-- CheckBox na Column7 ANTES de RecordSource
924:             par_oPage.grd_4c_Lista.Column7.AddObject("Check1", "CheckBox")
925:             par_oPage.grd_4c_Lista.Column7.CurrentControl = "Check1"
926:             par_oPage.grd_4c_Lista.Column7.Check1.Themes  = .F.
927:             par_oPage.grd_4c_Lista.Column7.Check1.Value   = 0
928: 
929:             *-- RecordSource FORA de WITH (critico: evita "Unknown member COLUMN1")

*-- Linhas 953 a 977:
953:             *-- Botoes de acao (Grupo_Salva no legado) - Top = 9+29 = 38
954:             par_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
955:             WITH par_oPage.cnt_4c_BotoesAcao
956:                 .Top         = 38
957:                 .Left        = 842
958:                 .Width       = 160
959:                 .Height      = 85
960:                 .BackStyle = 1
961:                 .BackColor = RGB(53, 53, 53)
962:                 .BorderStyle = 0
963:                 .Visible     = .T.
964:             ENDWITH
965: 
966:             par_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
967:             WITH par_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar
968:                 .Top             = 5
969:                 .Left            = 5
970:                 .Width           = 75
971:                 .Height          = 75
972:                 .Caption         = "Confirmar"
973:                 .FontName        = "Comic Sans MS"
974:                 .FontBold        = .T.
975:                 .FontItalic      = .T.
976:                 .FontSize        = 8
977:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 986 a 1000:
986:                 .Visible         = .T.
987:             ENDWITH
988: 
989:             par_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
990:             WITH par_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar
991:                 .Top             = 5
992:                 .Left            = 80
993:                 .Width           = 75
994:                 .Height          = 75
995:                 .Caption         = "Cancelar"
996:                 .FontName        = "Comic Sans MS"
997:                 .FontBold        = .T.
998:                 .FontItalic      = .T.
999:                 .FontSize        = 8
1000:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 1031 a 1107:
1031:                     loc_cNome = UPPER(loc_oCtrl.Name)
1032:                     IF loc_cNome == "CNT_4C_ACABADO" OR ;
1033:                        loc_cNome == "CNT_4C_MENSAGEM" OR ;
1034:                        loc_cNome == "IMG_4C_FIGJPG" OR ;
1035:                        loc_cNome == "LBL_4C_SEMMENU" OR ;
1036:                        loc_cNome == "CMD_4C_COPIARPRODUTO"
1037:                         LOOP
1038:                     ENDIF
1039:                     IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1040:                         loc_oCtrl.Visible = .T.
1041:                     ENDIF
1042:                 ENDIF
1043:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1044:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1045:                 ENDIF
1046:             ENDFOR
1047:         CATCH TO loc_oErro
1048:             *-- Tolerado: controles podem nao estar acessiveis durante ValidarUIFidelity
1049:         ENDTRY
1050:     ENDPROC
1051: 
1052:     *--------------------------------------------------------------------------
1053:     PROCEDURE FormatarGridLista(par_oGrid)
1054:         LOCAL loc_oGrid
1055:         TRY
1056:             loc_oGrid = par_oGrid
1057: 
1058:             *-- Column1: Produto (CPros)
1059:             loc_oGrid.Column1.Header1.Caption  = "Produto"
1060:             loc_oGrid.Column1.ControlSource    = "cursor_4c_Lista.CPros"
1061:             loc_oGrid.Column1.Width            = 80
1062:             loc_oGrid.Column1.ReadOnly         = .T.
1063:             loc_oGrid.Column1.Header1.FontBold = .T.
1064: 
1065:             *-- Column2: Descricao (DPros)
1066:             loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
1067:             loc_oGrid.Column2.ControlSource    = "cursor_4c_Lista.DPros"
1068:             loc_oGrid.Column2.Width            = 250
1069:             loc_oGrid.Column2.ReadOnly         = .T.
1070:             loc_oGrid.Column2.Header1.FontBold = .T.
1071: 
1072:             *-- Column3: Grupo (DGrus - descricao do grupo via JOIN)
1073:             loc_oGrid.Column3.Header1.Caption  = "Grupo"
1074:             loc_oGrid.Column3.ControlSource    = "cursor_4c_Lista.DGrus"
1075:             loc_oGrid.Column3.Width            = 100
1076:             loc_oGrid.Column3.ReadOnly         = .T.
1077:             loc_oGrid.Column3.Header1.FontBold = .T.
1078: 
1079:             *-- Column4: Subgrupo (SGrus)
1080:             loc_oGrid.Column4.Header1.Caption  = "Subgrp."
1081:             loc_oGrid.Column4.ControlSource    = "cursor_4c_Lista.SGrus"
1082:             loc_oGrid.Column4.Width            = 70
1083:             loc_oGrid.Column4.ReadOnly         = .T.
1084:             loc_oGrid.Column4.Header1.FontBold = .T.
1085: 
1086:             *-- Column5: Ref. Fornecedor (Reffs)
1087:             loc_oGrid.Column5.Header1.Caption  = "Ref. Fornecedor"
1088:             loc_oGrid.Column5.ControlSource    = "cursor_4c_Lista.Reffs"
1089:             loc_oGrid.Column5.Width            = 180
1090:             loc_oGrid.Column5.ReadOnly         = .T.
1091:             loc_oGrid.Column5.Header1.FontBold = .T.
1092: 
1093:             *-- Column6: Usuario (UsuaAlts)
1094:             loc_oGrid.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
1095:             loc_oGrid.Column6.ControlSource    = "cursor_4c_Lista.UsuaAlts"
1096:             loc_oGrid.Column6.Width            = 100
1097:             loc_oGrid.Column6.ReadOnly         = .T.
1098:             loc_oGrid.Column6.Header1.FontBold = .T.
1099: 
1100:             *-- Column7: Instalacao - CheckBox (Instalas)
1101:             *-- ControlSource definido na Column (NAO no Check1) - evita Error 1767
1102:             loc_oGrid.Column7.Header1.Caption  = "I"
1103:             loc_oGrid.Column7.ControlSource    = "cursor_4c_Lista.Instalas"
1104:             loc_oGrid.Column7.Width            = 30
1105:             loc_oGrid.Column7.ReadOnly         = .T.
1106:             loc_oGrid.Column7.Header1.FontBold = .T.
1107:             loc_oGrid.Column7.Alignment        = 2

*-- Linhas 1136 a 1152:
1136:             loc_lEditando = this_lEmEdicao
1137: 
1138:             *-- Botoes CRUD na Page1: desabilitar quando editando
1139:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = !loc_lEditando
1140:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = !loc_lEditando
1141:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = !loc_lEditando
1142:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = !loc_lEditando
1143:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = !loc_lEditando
1144:             loc_oPage1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = !loc_lEditando
1145: 
1146:             *-- Botoes de acao na Page2: Confirmar habilitado somente quando editando
1147:             loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1148:         CATCH TO loc_oErro
1149:             *-- Tolerado: botoes podem nao existir durante inicializacao
1150:         ENDTRY
1151:     ENDPROC
1152: 

*-- Linhas 1235 a 1243:
1235:                 GO TOP
1236:                 loc_oPage1.grd_4c_Lista.Refresh()
1237:                 loc_nCount = RECCOUNT("cursor_4c_Lista")
1238:                 loc_oPage1.lbl_4c_Produtos.Caption = ;
1239:                     "Produtos Selecionados : " + LTRIM(STR(loc_nCount))
1240:             ENDIF
1241: 
1242:         CATCH TO loc_oErro
1243:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de produtos")

*-- Linhas 1255 a 1272:
1255:             loc_oPage2 = THIS.pgf_4c_Paginas.Page2
1256: 
1257:             *-- Botoes CRUD (Page1)
1258:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
1259:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
1260:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
1261:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
1262:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
1263:             BINDEVENT(loc_oPage1.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
1264: 
1265:             *-- Botoes de acao (Page2)
1266:             BINDEVENT(loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
1267:             BINDEVENT(loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1268: 
1269:             *-- Grid DblClick -> Alterar
1270:             BINDEVENT(loc_oPage1.grd_4c_Lista, "DblClick", THIS, "GridDblClick")
1271: 
1272:             *-- Filtro de grupo: KeyPress (NUNCA LostFocus - causa recursao infinita)

*-- Linhas 1327 a 1335:
1327: 
1328:             *-- Fornecedor (campo + botao F4)
1329:             BINDEVENT(loc_oPgDados.txt_4c_Ifor, "KeyPress", THIS, "IforKeyPress")
1330:             BINDEVENT(loc_oPgDados.cmd_4c_BtnFornecedor, "Click", THIS, "BtnFornecedorClick")
1331: 
1332:             *-- Cor
1333:             BINDEVENT(loc_oPgDados.txt_4c_CorPro, "KeyPress", THIS, "CorProKeyPress")
1334:             BINDEVENT(loc_oPgDados.txt_4c_CorPro, "DblClick", THIS, "CorProDblClick")
1335: 

*-- Linhas 1378 a 1387:
1378:             BINDEVENT(loc_oPgComp.txt_4c_Ftio,              "KeyPress", THIS, "FtioKeyPress")
1379:             BINDEVENT(loc_oPgComp.txt_4c_Margem,            "KeyPress", THIS, "MargemKeyPress")
1380:             BINDEVENT(loc_oPgComp.txt_4c_Cmkpc,             "KeyPress", THIS, "CmkpcKeyPress")
1381:             BINDEVENT(loc_oPgComp.cmd_4c_CmdCalcVals,       "Click",    THIS, "CalcValsClick")
1382:             BINDEVENT(loc_oPgComp.cmd_4c_CmdPesoM,          "Click",    THIS, "PesoMClick")
1383:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(1), "Click",    THIS, "CompoIncluirClick")
1384:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(2), "Click",    THIS, "CompoExcluirClick")
1385:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(3), "Click",    THIS, "CompoAtualizaClick")
1386:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(4), "Click",    THIS, "CompoCopiarClick")
1387:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(5), "Click",    THIS, "CompoGrupoClick")

*-- Linhas 1425 a 1433:
1425:             BINDEVENT(loc_oPgFisc.txt_4c_Metal,      "DblClick", THIS, "MetalDblClick")
1426:             BINDEVENT(loc_oPgFisc.txt_4c_Teor,       "KeyPress", THIS, "TeorKeyPress")
1427:             BINDEVENT(loc_oPgFisc.txt_4c_Teor,       "DblClick", THIS, "TeorDblClick")
1428:             BINDEVENT(loc_oPgFisc.cmd_4c_BtnDescFis, "Click",    THIS, "BtnDescFisClick")
1429: 
1430:         CATCH TO loc_oErro
1431:             MsgErro(loc_oErro.Message, "Erro ao configurar eventos")
1432:         ENDTRY
1433:     ENDPROC

*-- Linhas 2071 a 2079:
2071:             loc_oPgDados.txt_4c_CodIdent.Value = ALLTRIM(loc_oBO.this_cCodIdents)
2072:             loc_oPgDados.txt_4c_TEnts.Value    = ALLTRIM(loc_oBO.this_cTEnts)
2073: 
2074:             *-- === Flags (CheckBox: value 0/1) ===
2075:             loc_oPgDados.chk_4c_GarVit.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nGarVits) = "L", loc_oBO.this_nGarVits, (NVL(loc_oBO.this_nGarVits, 0) = 1)), 1, 0)
2076:             loc_oPgDados.chk_4c_Consig.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nConsigs) = "L", loc_oBO.this_nConsigs, (NVL(loc_oBO.this_nConsigs, 0) = 1)), 1, 0)
2077:             loc_oPgDados.chk_4c_FabrProprs.Value = IIF(IIF(VARTYPE(loc_oBO.this_nFabrProprs) = "L", loc_oBO.this_nFabrProprs, (NVL(loc_oBO.this_nFabrProprs, 0) = 1)), 1, 0)
2078:             loc_oPgDados.chk_4c_Encoms.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nEncoms) = "L", loc_oBO.this_nEncoms, (NVL(loc_oBO.this_nEncoms, 0) = 1)), 1, 0)
2079: 

*-- Linhas 2216 a 2224:
2216:             loc_oBO.this_cCodIdents = ALLTRIM(loc_oPgDados.txt_4c_CodIdent.Value)
2217:             loc_oBO.this_cTEnts     = ALLTRIM(loc_oPgDados.txt_4c_TEnts.Value)
2218: 
2219:             *-- === Flags (CheckBox 0/1) ===
2220:             loc_oBO.this_nGarVits    = IIF(loc_oPgDados.chk_4c_GarVit.Value    = 1, 1, 0)
2221:             loc_oBO.this_nConsigs    = IIF(loc_oPgDados.chk_4c_Consig.Value    = 1, 1, 0)
2222:             loc_oBO.this_nFabrProprs = IIF(loc_oPgDados.chk_4c_FabrProprs.Value = 1, 1, 0)
2223:             loc_oBO.this_nEncoms     = IIF(loc_oPgDados.chk_4c_Encoms.Value    = 1, 1, 0)
2224: 

*-- Linhas 2272 a 2378:
2272:             *-- top=5+29=34, left=5, width=535, height=85
2273:             par_oPage.AddObject("obj_4c_Optiongroup1", "OptionGroup")
2274:             WITH par_oPage.obj_4c_Optiongroup1
2275:                 .Top         = 34
2276:                 .Left        = 5
2277:                 .Width       = 535
2278:                 .Height      = 85
2279:                 .ButtonCount = 7
2280:                 .Value       = 1
2281:                 .Themes      = .F.
2282:                 .Visible     = .T.
2283:             ENDWITH
2284: 
2285:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(1)
2286:                 .Caption   = "Dados"
2287:                 .Top       = 0
2288:                 .Left      = 0
2289:                 .Width     = 75
2290:                 .Height    = 80
2291:                 .FontName  = "Comic Sans MS"
2292:                 .FontBold  = .T.
2293:                 .FontSize  = 8
2294:                 .ForeColor = RGB(90,90,90)
2295:                 .BackColor = RGB(255,255,255)
2296:                 .Themes    = .F.
2297:                 .Value     = 1
2298:             ENDWITH
2299: 
2300:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(2)
2301:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
2302:                 .Top       = 0
2303:                 .Left      = 76
2304:                 .Width     = 75
2305:                 .Height    = 80
2306:                 .FontName  = "Comic Sans MS"
2307:                 .FontBold  = .T.
2308:                 .FontSize  = 8
2309:                 .ForeColor = RGB(90,90,90)
2310:                 .BackColor = RGB(255,255,255)
2311:                 .Themes    = .F.
2312:             ENDWITH
2313: 
2314:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(3)
2315:                 .Caption   = "Fiscal"
2316:                 .Top       = 0
2317:                 .Left      = 152
2318:                 .Width     = 75
2319:                 .Height    = 80
2320:                 .FontName  = "Comic Sans MS"
2321:                 .FontBold  = .T.
2322:                 .FontSize  = 8
2323:                 .ForeColor = RGB(90,90,90)
2324:                 .BackColor = RGB(255,255,255)
2325:                 .Themes    = .F.
2326:             ENDWITH
2327: 
2328:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(4)
2329:                 .Caption   = "Fase P"
2330:                 .Top       = 0
2331:                 .Left      = 228
2332:                 .Width     = 75
2333:                 .Height    = 80
2334:                 .FontName  = "Comic Sans MS"
2335:                 .FontBold  = .T.
2336:                 .FontSize  = 8
2337:                 .ForeColor = RGB(90,90,90)
2338:                 .BackColor = RGB(255,255,255)
2339:                 .Themes    = .F.
2340:             ENDWITH
2341: 
2342:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(5)
2343:                 .Caption   = "Cons P"
2344:                 .Top       = 0
2345:                 .Left      = 304
2346:                 .Width     = 75
2347:                 .Height    = 80
2348:                 .FontName  = "Comic Sans MS"
2349:                 .FontBold  = .T.
2350:                 .FontSize  = 8
2351:                 .ForeColor = RGB(90,90,90)
2352:                 .BackColor = RGB(255,255,255)
2353:                 .Themes    = .F.
2354:             ENDWITH
2355: 
2356:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(6)
2357:                 .Caption   = "Custo"
2358:                 .Top       = 0
2359:                 .Left      = 380
2360:                 .Width     = 75
2361:                 .Height    = 80
2362:                 .FontName  = "Comic Sans MS"
2363:                 .FontBold  = .T.
2364:                 .FontSize  = 8
2365:                 .ForeColor = RGB(90,90,90)
2366:                 .BackColor = RGB(255,255,255)
2367:                 .Themes    = .F.
2368:             ENDWITH
2369: 
2370:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(7)
2371:                 .Caption   = "Designer"
2372:                 .Top       = 0
2373:                 .Left      = 456
2374:                 .Width     = 75
2375:                 .Height    = 80
2376:                 .FontName  = "Comic Sans MS"
2377:                 .FontBold  = .T.
2378:                 .FontSize  = 8

*-- Linhas 2386 a 2410:
2386:             par_oPage.AddObject("pgf_4c_DadosInterno", "PageFrame")
2387:             loc_oPgfInner = par_oPage.pgf_4c_DadosInterno
2388:             WITH loc_oPgfInner
2389:                 .Top       = -25
2390:                 .Left      = -1
2391:                 .Width     = 1003
2392:                 .Height    = 656
2393:                 .PageCount = 7
2394:                 .Tabs      = .F.
2395:                 .Themes    = .F.
2396:                 .Visible   = .T.
2397:             ENDWITH
2398: 
2399:             loc_oPgfInner.Page1.Caption = "Dados"
2400:             loc_oPgfInner.Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2401:             loc_oPgfInner.Page3.Caption = "Fiscal"
2402:             loc_oPgfInner.Page4.Caption = "Fase P"
2403:             loc_oPgfInner.Page5.Caption = "Cons P"
2404:             loc_oPgfInner.Page6.Caption = "Custo"
2405:             loc_oPgfInner.Page7.Caption = "Designer"
2406: 
2407:             *-- Configurar primeira pagina interna (pgDados - ambas as partes)
2408:             THIS.ConfigurarPgDados1(loc_oPgfInner.Page1)
2409:             THIS.ConfigurarPgDados2(loc_oPgfInner.Page1)
2410: 

*-- Linhas 2441 a 2931:
2441:             *-- top=130+29=159, left=735, width=142, height=25
2442:             par_oPage.AddObject("opt_4c_SituacaoPro", "OptionGroup")
2443:             WITH par_oPage.opt_4c_SituacaoPro
2444:                 .Top         = 159
2445:                 .Left        = 735
2446:                 .Width       = 142
2447:                 .Height      = 25
2448:                 .ButtonCount = 2
2449:                 .Value       = 1
2450:                 .Themes      = .F.
2451:                 .Visible     = .T.
2452:             ENDWITH
2453:             WITH par_oPage.opt_4c_SituacaoPro.Buttons(1)
2454:                 .Caption  = "Ativo"
2455:                 .Top      = 0
2456:                 .Left     = 0
2457:                 .Width    = 68
2458:                 .Height   = 22
2459:                 .FontName = "Tahoma"
2460:                 .FontSize = 8
2461:                 .Themes   = .F.
2462:                 .Value    = 1
2463:             ENDWITH
2464:             WITH par_oPage.opt_4c_SituacaoPro.Buttons(2)
2465:                 .Caption  = "Inativo"
2466:                 .Top      = 0
2467:                 .Left     = 70
2468:                 .Width    = 68
2469:                 .Height   = 22
2470:                 .FontName = "Tahoma"
2471:                 .FontSize = 8
2472:                 .Themes   = .F.
2473:             ENDWITH
2474: 
2475:             *-- Label "Produto :" (Label2, top=134+29=163)
2476:             par_oPage.AddObject("lbl_4c_LbCpro", "Label")
2477:             WITH par_oPage.lbl_4c_LbCpro
2478:                 .Top       = 163
2479:                 .Left      = 58
2480:                 .Width     = 53
2481:                 .Height    = 15
2482:                 .FontName  = "Tahoma"
2483:                 .FontSize  = 8
2484:                 .BackStyle = 0
2485:                 .Caption   = "Produto :"
2486:                 .Visible   = .T.
2487:             ENDWITH
2488: 
2489:             *-- getCpro -> txt_4c_Cpro (codigo produto, top=130+29=159)
2490:             par_oPage.AddObject("txt_4c_Cpro", "TextBox")
2491:             WITH par_oPage.txt_4c_Cpro
2492:                 .Top       = 159
2493:                 .Left      = 113
2494:                 .Width     = 108
2495:                 .Height    = 23
2496:                 .FontName  = "Tahoma"
2497:                 .FontSize  = 8
2498:                 .MaxLength = 14
2499:                 .Themes    = .F.
2500:                 .Visible   = .T.
2501:             ENDWITH
2502: 
2503:             *-- getDpro -> txt_4c_Dpro (descricao produto, top=130+29=159)
2504:             par_oPage.AddObject("txt_4c_Dpro", "TextBox")
2505:             WITH par_oPage.txt_4c_Dpro
2506:                 .Top       = 159
2507:                 .Left      = 222
2508:                 .Width     = 290
2509:                 .Height    = 23
2510:                 .FontName  = "Tahoma"
2511:                 .FontSize  = 8
2512:                 .MaxLength = 40
2513:                 .Themes    = .F.
2514:                 .Visible   = .T.
2515:             ENDWITH
2516: 
2517:             *-- Label "Equivalente :" (Say2, top=137+29=166)
2518:             par_oPage.AddObject("lbl_4c_LbEquiv", "Label")
2519:             WITH par_oPage.lbl_4c_LbEquiv
2520:                 .Top       = 166
2521:                 .Left      = 560
2522:                 .Width     = 65
2523:                 .Height    = 15
2524:                 .FontName  = "Tahoma"
2525:                 .FontSize  = 8
2526:                 .BackStyle = 0
2527:                 .Caption   = "Equivalente :"
2528:                 .Visible   = .T.
2529:             ENDWITH
2530: 
2531:             *-- Get_CProEq -> txt_4c_CProEq (produto equivalente, top=133+29=162)
2532:             par_oPage.AddObject("txt_4c_CProEq", "TextBox")
2533:             WITH par_oPage.txt_4c_CProEq
2534:                 .Top       = 162
2535:                 .Left      = 626
2536:                 .Width     = 108
2537:                 .Height    = 21
2538:                 .FontName  = "Tahoma"
2539:                 .FontSize  = 8
2540:                 .MaxLength = 14
2541:                 .Themes    = .F.
2542:                 .Visible   = .T.
2543:             ENDWITH
2544: 
2545:             *-- Label "Descritivo :" (Say10, top=158+29=187)
2546:             par_oPage.AddObject("lbl_4c_LbDPro2s", "Label")
2547:             WITH par_oPage.lbl_4c_LbDPro2s
2548:                 .Top       = 187
2549:                 .Left      = 55
2550:                 .Width     = 56
2551:                 .Height    = 15
2552:                 .FontName  = "Tahoma"
2553:                 .FontSize  = 8
2554:                 .BackStyle = 0
2555:                 .Caption   = "Descritivo :"
2556:                 .Visible   = .T.
2557:             ENDWITH
2558: 
2559:             *-- getDPro2s -> txt_4c_DPro2s (descricao 2, top=154+29=183)
2560:             par_oPage.AddObject("txt_4c_DPro2s", "TextBox")
2561:             WITH par_oPage.txt_4c_DPro2s
2562:                 .Top       = 183
2563:                 .Left      = 113
2564:                 .Width     = 399
2565:                 .Height    = 23
2566:                 .FontName  = "Tahoma"
2567:                 .FontSize  = 8
2568:                 .MaxLength = 30
2569:                 .Themes    = .F.
2570:                 .Visible   = .T.
2571:             ENDWITH
2572: 
2573:             *-- Label "Barra :" (Say15, top=157+29=186)
2574:             par_oPage.AddObject("lbl_4c_LbCbar", "Label")
2575:             WITH par_oPage.lbl_4c_LbCbar
2576:                 .Top       = 186
2577:                 .Left      = 590
2578:                 .Width     = 35
2579:                 .Height    = 15
2580:                 .FontName  = "Tahoma"
2581:                 .FontSize  = 8
2582:                 .BackStyle = 0
2583:                 .Caption   = "Barra :"
2584:                 .Visible   = .T.
2585:             ENDWITH
2586: 
2587:             *-- getCbar -> txt_4c_Cbar (codigo barras, top=155+29=184)
2588:             par_oPage.AddObject("txt_4c_Cbar", "TextBox")
2589:             WITH par_oPage.txt_4c_Cbar
2590:                 .Top       = 184
2591:                 .Left      = 626
2592:                 .Width     = 108
2593:                 .Height    = 21
2594:                 .FontName  = "Tahoma"
2595:                 .FontSize  = 8
2596:                 .MaxLength = 14
2597:                 .Themes    = .F.
2598:                 .Visible   = .T.
2599:             ENDWITH
2600: 
2601:             *-- Label "EAN/GTIN :" (Say1, top=181+29=210)
2602:             par_oPage.AddObject("lbl_4c_LbEAN13", "Label")
2603:             WITH par_oPage.lbl_4c_LbEAN13
2604:                 .Top       = 210
2605:                 .Left      = 568
2606:                 .Width     = 57
2607:                 .Height    = 15
2608:                 .FontName  = "Tahoma"
2609:                 .FontSize  = 8
2610:                 .BackStyle = 0
2611:                 .Caption   = "EAN/GTIN :"
2612:                 .Visible   = .T.
2613:             ENDWITH
2614: 
2615:             *-- getEAN13 -> txt_4c_EAN13 (EAN13, top=177+29=206)
2616:             par_oPage.AddObject("txt_4c_EAN13", "TextBox")
2617:             WITH par_oPage.txt_4c_EAN13
2618:                 .Top       = 206
2619:                 .Left      = 626
2620:                 .Width     = 108
2621:                 .Height    = 21
2622:                 .FontName  = "Tahoma"
2623:                 .FontSize  = 8
2624:                 .MaxLength = 13
2625:                 .Themes    = .F.
2626:                 .Visible   = .T.
2627:             ENDWITH
2628: 
2629:             *-- Label "Grupo :" (Say8, top=182+29=211)
2630:             par_oPage.AddObject("lbl_4c_LbCgru", "Label")
2631:             WITH par_oPage.lbl_4c_LbCgru
2632:                 .Top       = 211
2633:                 .Left      = 73
2634:                 .Width     = 38
2635:                 .Height    = 15
2636:                 .FontName  = "Tahoma"
2637:                 .FontSize  = 8
2638:                 .BackStyle = 0
2639:                 .Caption   = "Grupo :"
2640:                 .Visible   = .T.
2641:             ENDWITH
2642: 
2643:             *-- getCgru -> txt_4c_Cgru (codigo grupo, top=178+29=207)
2644:             par_oPage.AddObject("txt_4c_Cgru", "TextBox")
2645:             WITH par_oPage.txt_4c_Cgru
2646:                 .Top       = 207
2647:                 .Left      = 113
2648:                 .Width     = 31
2649:                 .Height    = 23
2650:                 .FontName  = "Tahoma"
2651:                 .FontSize  = 8
2652:                 .MaxLength = 10
2653:                 .Themes    = .F.
2654:                 .Visible   = .T.
2655:             ENDWITH
2656: 
2657:             *-- getDgru -> txt_4c_Dgru (desc grupo, readonly, top=178+29=207)
2658:             par_oPage.AddObject("txt_4c_Dgru", "TextBox")
2659:             WITH par_oPage.txt_4c_Dgru
2660:                 .Top       = 207
2661:                 .Left      = 145
2662:                 .Width     = 171
2663:                 .Height    = 23
2664:                 .FontName  = "Tahoma"
2665:                 .FontSize  = 8
2666:                 .ReadOnly  = .T.
2667:                 .Themes    = .F.
2668:                 .Visible   = .T.
2669:             ENDWITH
2670: 
2671:             *-- getMerc -> txt_4c_Merc (mercado, top=178+29=207)
2672:             par_oPage.AddObject("txt_4c_Merc", "TextBox")
2673:             WITH par_oPage.txt_4c_Merc
2674:                 .Top       = 207
2675:                 .Left      = 318
2676:                 .Width     = 31
2677:                 .Height    = 23
2678:                 .FontName  = "Tahoma"
2679:                 .FontSize  = 8
2680:                 .MaxLength = 5
2681:                 .Themes    = .F.
2682:                 .Visible   = .T.
2683:             ENDWITH
2684: 
2685:             *-- getIdeCPros -> txt_4c_IdeCPros (identificador, top=178+29=207)
2686:             par_oPage.AddObject("txt_4c_IdeCPros", "TextBox")
2687:             WITH par_oPage.txt_4c_IdeCPros
2688:                 .Top       = 207
2689:                 .Left      = 481
2690:                 .Width     = 31
2691:                 .Height    = 23
2692:                 .FontName  = "Tahoma"
2693:                 .FontSize  = 8
2694:                 .MaxLength = 5
2695:                 .Themes    = .F.
2696:                 .Visible   = .T.
2697:             ENDWITH
2698: 
2699:             *-- Label "Subgrupo :" (Say9, top=206+29=235)
2700:             par_oPage.AddObject("lbl_4c_LbCSGru", "Label")
2701:             WITH par_oPage.lbl_4c_LbCSGru
2702:                 .Top       = 235
2703:                 .Left      = 56
2704:                 .Width     = 55
2705:                 .Height    = 15
2706:                 .FontName  = "Tahoma"
2707:                 .FontSize  = 8
2708:                 .BackStyle = 0
2709:                 .Caption   = "Subgrupo :"
2710:                 .Visible   = .T.
2711:             ENDWITH
2712: 
2713:             *-- GetCSGru -> txt_4c_CSGru (subgrupo, top=202+29=231)
2714:             par_oPage.AddObject("txt_4c_CSGru", "TextBox")
2715:             WITH par_oPage.txt_4c_CSGru
2716:                 .Top       = 231
2717:                 .Left      = 113
2718:                 .Width     = 52
2719:                 .Height    = 23
2720:                 .FontName  = "Tahoma"
2721:                 .FontSize  = 8
2722:                 .MaxLength = 10
2723:                 .Themes    = .F.
2724:                 .Visible   = .T.
2725:             ENDWITH
2726: 
2727:             *-- GetDsGru -> txt_4c_DsGru (desc subgrupo, readonly, top=202+29=231)
2728:             par_oPage.AddObject("txt_4c_DsGru", "TextBox")
2729:             WITH par_oPage.txt_4c_DsGru
2730:                 .Top       = 231
2731:                 .Left      = 166
2732:                 .Width     = 150
2733:                 .Height    = 23
2734:                 .FontName  = "Tahoma"
2735:                 .FontSize  = 8
2736:                 .ReadOnly  = .T.
2737:                 .Themes    = .F.
2738:                 .Visible   = .T.
2739:             ENDWITH
2740: 
2741:             *-- Label "Qtde. Minima :" (Say13, top=203+29=232)
2742:             par_oPage.AddObject("lbl_4c_LbQmin", "Label")
2743:             WITH par_oPage.lbl_4c_LbQmin
2744:                 .Top       = 232
2745:                 .Left      = 553
2746:                 .Width     = 72
2747:                 .Height    = 15
2748:                 .FontName  = "Tahoma"
2749:                 .FontSize  = 8
2750:                 .BackStyle = 0
2751:                 .Caption   = "Qtde. M" + CHR(237) + "nima :"
2752:                 .Visible   = .T.
2753:             ENDWITH
2754: 
2755:             *-- getQmin -> txt_4c_Qmin (qtd minima, top=199+29=228)
2756:             par_oPage.AddObject("txt_4c_Qmin", "TextBox")
2757:             WITH par_oPage.txt_4c_Qmin
2758:                 .Top       = 228
2759:                 .Left      = 626
2760:                 .Width     = 80
2761:                 .Height    = 21
2762:                 .FontName  = "Tahoma"
2763:                 .FontSize  = 8
2764:                 .Themes    = .F.
2765:                 .Visible   = .T.
2766:             ENDWITH
2767: 
2768:             *-- Label "Linha :" (Say16, top=230+29=259)
2769:             par_oPage.AddObject("lbl_4c_LbLin", "Label")
2770:             WITH par_oPage.lbl_4c_LbLin
2771:                 .Top       = 259
2772:                 .Left      = 77
2773:                 .Width     = 34
2774:                 .Height    = 15
2775:                 .FontName  = "Tahoma"
2776:                 .FontSize  = 8
2777:                 .BackStyle = 0
2778:                 .Caption   = "Linha :"
2779:                 .Visible   = .T.
2780:             ENDWITH
2781: 
2782:             *-- GetLin -> txt_4c_Lin (linha, top=226+29=255)
2783:             par_oPage.AddObject("txt_4c_Lin", "TextBox")
2784:             WITH par_oPage.txt_4c_Lin
2785:                 .Top       = 255
2786:                 .Left      = 113
2787:                 .Width     = 80
2788:                 .Height    = 23
2789:                 .FontName  = "Tahoma"
2790:                 .FontSize  = 8
2791:                 .MaxLength = 10
2792:                 .Themes    = .F.
2793:                 .Visible   = .T.
2794:             ENDWITH
2795: 
2796:             *-- GetDLin -> txt_4c_DLin (desc linha, readonly, top=226+29=255)
2797:             par_oPage.AddObject("txt_4c_DLin", "TextBox")
2798:             WITH par_oPage.txt_4c_DLin
2799:                 .Top       = 255
2800:                 .Left      = 194
2801:                 .Width     = 318
2802:                 .Height    = 23
2803:                 .FontName  = "Tahoma"
2804:                 .FontSize  = 8
2805:                 .ReadOnly  = .T.
2806:                 .Themes    = .F.
2807:                 .Visible   = .T.
2808:             ENDWITH
2809: 
2810:             *-- GetObs3 -> txt_4c_Obs3 (obs3, top=243+29=272)
2811:             par_oPage.AddObject("txt_4c_Obs3", "TextBox")
2812:             WITH par_oPage.txt_4c_Obs3
2813:                 .Top       = 272
2814:                 .Left      = 626
2815:                 .Width     = 80
2816:                 .Height    = 21
2817:                 .FontName  = "Tahoma"
2818:                 .FontSize  = 8
2819:                 .MaxLength = 20
2820:                 .Themes    = .F.
2821:                 .Visible   = .T.
2822:             ENDWITH
2823: 
2824:             *-- Label "Grupo de Venda :" (Say17, top=253+29=282)
2825:             par_oPage.AddObject("lbl_4c_LbCol", "Label")
2826:             WITH par_oPage.lbl_4c_LbCol
2827:                 .Top       = 282
2828:                 .Left      = 25
2829:                 .Width     = 86
2830:                 .Height    = 15
2831:                 .FontName  = "Tahoma"
2832:                 .FontSize  = 8
2833:                 .BackStyle = 0
2834:                 .Caption   = "Grupo de Venda :"
2835:                 .Visible   = .T.
2836:             ENDWITH
2837: 
2838:             *-- GetCol -> txt_4c_Col (colecao, top=250+29=279)
2839:             par_oPage.AddObject("txt_4c_Col", "TextBox")
2840:             WITH par_oPage.txt_4c_Col
2841:                 .Top       = 279
2842:                 .Left      = 113
2843:                 .Width     = 80
2844:                 .Height    = 23
2845:                 .FontName  = "Tahoma"
2846:                 .FontSize  = 8
2847:                 .MaxLength = 10
2848:                 .Themes    = .F.
2849:                 .Visible   = .T.
2850:             ENDWITH
2851: 
2852:             *-- GetDCol -> txt_4c_DCol (desc colecao, readonly, top=250+29=279)
2853:             par_oPage.AddObject("txt_4c_DCol", "TextBox")
2854:             WITH par_oPage.txt_4c_DCol
2855:                 .Top       = 279
2856:                 .Left      = 194
2857:                 .Width     = 318
2858:                 .Height    = 23
2859:                 .FontName  = "Tahoma"
2860:                 .FontSize  = 8
2861:                 .ReadOnly  = .T.
2862:                 .Themes    = .F.
2863:                 .Visible   = .T.
2864:             ENDWITH
2865: 
2866:             *-- Label "Fornecedor :" (Say11, top=278+29=307)
2867:             par_oPage.AddObject("lbl_4c_LbIfor", "Label")
2868:             WITH par_oPage.lbl_4c_LbIfor
2869:                 .Top       = 307
2870:                 .Left      = 47
2871:                 .Width     = 64
2872:                 .Height    = 15
2873:                 .FontName  = "Tahoma"
2874:                 .FontSize  = 8
2875:                 .BackStyle = 0
2876:                 .Caption   = "Fornecedor :"
2877:                 .Visible   = .T.
2878:             ENDWITH
2879: 
2880:             *-- getIfor -> txt_4c_Ifor (codigo fornecedor, top=274+29=303)
2881:             par_oPage.AddObject("txt_4c_Ifor", "TextBox")
2882:             WITH par_oPage.txt_4c_Ifor
2883:                 .Top       = 303
2884:                 .Left      = 113
2885:                 .Width     = 80
2886:                 .Height    = 23
2887:                 .FontName  = "Tahoma"
2888:                 .FontSize  = 8
2889:                 .MaxLength = 10
2890:                 .Themes    = .F.
2891:                 .Visible   = .T.
2892:             ENDWITH
2893: 
2894:             *-- getDfor -> txt_4c_Dfor (nome fornecedor, readonly, top=274+29=303)
2895:             par_oPage.AddObject("txt_4c_Dfor", "TextBox")
2896:             WITH par_oPage.txt_4c_Dfor
2897:                 .Top       = 303
2898:                 .Left      = 194
2899:                 .Width     = 318
2900:                 .Height    = 23
2901:                 .FontName  = "Tahoma"
2902:                 .FontSize  = 8
2903:                 .ReadOnly  = .T.
2904:                 .Themes    = .F.
2905:                 .Visible   = .T.
2906:             ENDWITH
2907: 
2908:             *-- Label "Ref. Fornecedor :" (Say12, top=301+29=330)
2909:             par_oPage.AddObject("lbl_4c_LbRefs", "Label")
2910:             WITH par_oPage.lbl_4c_LbRefs
2911:                 .Top       = 330
2912:                 .Left      = 23
2913:                 .Width     = 88
2914:                 .Height    = 15
2915:                 .FontName  = "Tahoma"
2916:                 .FontSize  = 8
2917:                 .BackStyle = 0
2918:                 .Caption   = "Ref. Fornecedor :"
2919:                 .Visible   = .T.
2920:             ENDWITH
2921: 
2922:             *-- getRefs -> txt_4c_Refs (ref fornecedor, top=298+29=327)
2923:             par_oPage.AddObject("txt_4c_Refs", "TextBox")
2924:             WITH par_oPage.txt_4c_Refs
2925:                 .Top       = 327
2926:                 .Left      = 113
2927:                 .Width     = 152
2928:                 .Height    = 23
2929:                 .FontName  = "Tahoma"
2930:                 .FontSize  = 8
2931:                 .MaxLength = 30

*-- Linhas 2945 a 4758:
2945:     PROTECTED PROCEDURE ConfigurarPgDados2(par_oPage)
2946:         LOCAL loc_oErro
2947:         TRY
2948:             *-- cmd_4c_Produto (cmdProduto, top=33+29=62, left=623, w=85, h=85)
2949:             par_oPage.AddObject("cmd_4c_Produto", "CommandButton")
2950:             WITH par_oPage.cmd_4c_Produto
2951:                 .Top = 62
2952:                 .Left = 623
2953:                 .Width = 85
2954:                 .Height = 85
2955:                 .Caption = "Produto"
2956:                 .FontName = "Tahoma"
2957:                 .FontSize = 8
2958:                 .Themes = .F.
2959:                 .Visible = .T.
2960:             ENDWITH
2961: 
2962:             *-- cmd_4c_Arquivos (cmdArquivos, top=33+29=62, left=698, w=85, h=85)
2963:             par_oPage.AddObject("cmd_4c_Arquivos", "CommandButton")
2964:             WITH par_oPage.cmd_4c_Arquivos
2965:                 .Top = 62
2966:                 .Left = 698
2967:                 .Width = 85
2968:                 .Height = 85
2969:                 .Caption = "Arquivos"
2970:                 .FontName = "Tahoma"
2971:                 .FontSize = 8
2972:                 .Themes = .F.
2973:                 .Visible = .T.
2974:             ENDWITH
2975: 
2976:             *-- txt_4c_DtSituas (getDtSituas, data situacao, top=132+29=161) readonly
2977:             par_oPage.AddObject("txt_4c_DtSituas", "TextBox")
2978:             WITH par_oPage.txt_4c_DtSituas
2979:                 .Top = 161
2980:                 .Left = 878
2981:                 .Width = 80
2982:                 .Height = 21
2983:                 .FontName = "Tahoma"
2984:                 .FontSize = 8
2985:                 .ReadOnly = .T.
2986:                 .Themes = .F.
2987:                 .Visible = .T.
2988:             ENDWITH
2989: 
2990:             *-- cmd_4c_Minimo (cmdMinimo, top=137+29=166, left=960, w=41, h=40)
2991:             par_oPage.AddObject("cmd_4c_Minimo", "CommandButton")
2992:             WITH par_oPage.cmd_4c_Minimo
2993:                 .Top = 166
2994:                 .Left = 960
2995:                 .Width = 41
2996:                 .Height = 40
2997:                 .Caption = "Min"
2998:                 .FontName = "Tahoma"
2999:                 .FontSize = 8
3000:                 .Themes = .F.
3001:                 .Visible = .T.
3002:             ENDWITH
3003: 
3004:             *-- txt_4c_LtMinsV (getLtMinsV, lote minimo, top=154+29=183)
3005:             par_oPage.AddObject("txt_4c_LtMinsV", "TextBox")
3006:             WITH par_oPage.txt_4c_LtMinsV
3007:                 .Top = 183
3008:                 .Left = 878
3009:                 .Width = 80
3010:                 .Height = 21
3011:                 .FontName = "Tahoma"
3012:                 .FontSize = 8
3013:                 .Themes = .F.
3014:                 .Visible = .T.
3015:             ENDWITH
3016: 
3017:             *-- Label "Lote Minimo :" (Say21, top=157+29=186)
3018:             par_oPage.AddObject("lbl_4c_LbLtMin", "Label")
3019:             WITH par_oPage.lbl_4c_LbLtMin
3020:                 .Top = 186
3021:                 .Left = 812
3022:                 .Width = 65
3023:                 .Height = 15
3024:                 .FontName = "Tahoma"
3025:                 .FontSize = 8
3026:                 .BackStyle = 0
3027:                 .Caption = "Lote M" + CHR(237) + "nimo :"
3028:                 .Visible = .T.
3029:             ENDWITH
3030: 
3031:             *-- opt_4c_ProdWeb (Fwoption1, produto web, top=172+29=201, left=879, w=117, h=42)
3032:             par_oPage.AddObject("opt_4c_ProdWeb", "OptionGroup")
3033:             WITH par_oPage.opt_4c_ProdWeb
3034:                 .Top = 201
3035:                 .Left = 879
3036:                 .Width = 117
3037:                 .Height = 42
3038:                 .ButtonCount = 2
3039:                 .Value = 1
3040:                 .Themes = .F.
3041:                 .Visible = .T.
3042:             ENDWITH
3043:             WITH par_oPage.opt_4c_ProdWeb.Buttons(1)
3044:                 .Caption = "Sim"
3045:                 .Top = 0
3046:                 .Left = 0
3047:                 .Width = 55
3048:                 .Height = 20
3049:                 .FontName = "Tahoma"
3050:                 .FontSize = 8
3051:                 .Themes = .F.
3052:                 .Value = 1
3053:             ENDWITH
3054:             WITH par_oPage.opt_4c_ProdWeb.Buttons(2)
3055:                 .Caption = "N" + CHR(227) + "o"
3056:                 .Top = 0
3057:                 .Left = 57
3058:                 .Width = 55
3059:                 .Height = 20
3060:                 .FontName = "Tahoma"
3061:                 .FontSize = 8
3062:                 .Themes = .F.
3063:             ENDWITH
3064: 
3065:             *-- Label "Produto Web :" (Say29, top=176+29=205)
3066:             par_oPage.AddObject("lbl_4c_LbProdWeb", "Label")
3067:             WITH par_oPage.lbl_4c_LbProdWeb
3068:                 .Top = 205
3069:                 .Left = 805
3070:                 .Width = 72
3071:                 .Height = 15
3072:                 .FontName = "Tahoma"
3073:                 .FontSize = 8
3074:                 .BackStyle = 0
3075:                 .Caption = "Produto Web :"
3076:                 .Visible = .T.
3077:             ENDWITH
3078: 
3079:             *-- cmd_4c_Caracts (cmdCaracts, top=181+29=210, left=352, w=42, h=42)
3080:             par_oPage.AddObject("cmd_4c_Caracts", "CommandButton")
3081:             WITH par_oPage.cmd_4c_Caracts
3082:                 .Top = 210
3083:                 .Left = 352
3084:                 .Width = 42
3085:                 .Height = 42
3086:                 .Caption = "Car."
3087:                 .FontName = "Tahoma"
3088:                 .FontSize = 8
3089:                 .Themes = .F.
3090:                 .Visible = .T.
3091:             ENDWITH
3092: 
3093:             *-- Label "Identificador :" (Say23, top=182+29=211, left=408)
3094:             par_oPage.AddObject("lbl_4c_LbIdent", "Label")
3095:             WITH par_oPage.lbl_4c_LbIdent
3096:                 .Top = 211
3097:                 .Left = 408
3098:                 .Width = 70
3099:                 .Height = 15
3100:                 .FontName = "Tahoma"
3101:                 .FontSize = 8
3102:                 .BackStyle = 0
3103:                 .Caption = "Identificador :"
3104:                 .Visible = .T.
3105:             ENDWITH
3106: 
3107:             *-- cmd_4c_Conjunto (cmdConjunto, top=198+29=227, left=513, w=36, h=30)
3108:             par_oPage.AddObject("cmd_4c_Conjunto", "CommandButton")
3109:             WITH par_oPage.cmd_4c_Conjunto
3110:                 .Top = 227
3111:                 .Left = 513
3112:                 .Width = 36
3113:                 .Height = 30
3114:                 .Caption = "Conj"
3115:                 .FontName = "Tahoma"
3116:                 .FontSize = 8
3117:                 .Themes = .F.
3118:                 .Visible = .T.
3119:             ENDWITH
3120: 
3121:             *-- cmd_4c_QtMin (CmdQtMin "...", top=199+29=228, left=709)
3122:             par_oPage.AddObject("cmd_4c_QtMin", "CommandButton")
3123:             WITH par_oPage.cmd_4c_QtMin
3124:                 .Top = 228
3125:                 .Left = 709
3126:                 .Width = 25
3127:                 .Height = 23
3128:                 .Caption = ". . ."
3129:                 .FontName = "Tahoma"
3130:                 .FontSize = 8
3131:                 .Themes = .F.
3132:                 .Visible = .T.
3133:             ENDWITH
3134: 
3135:             *-- txt_4c_Conjunto (getConjunto, top=202+29=231, left=460, w=52)
3136:             par_oPage.AddObject("txt_4c_Conjunto", "TextBox")
3137:             WITH par_oPage.txt_4c_Conjunto
3138:                 .Top = 231
3139:                 .Left = 460
3140:                 .Width = 52
3141:                 .Height = 23
3142:                 .FontName = "Tahoma"
3143:                 .FontSize = 8
3144:                 .MaxLength = 14
3145:                 .Themes = .F.
3146:                 .Visible = .T.
3147:             ENDWITH
3148: 
3149:             *-- opt_4c_OpcVar (Fwoption2, top=203+29=232, left=874, w=107, h=22)
3150:             par_oPage.AddObject("opt_4c_OpcVar", "OptionGroup")
3151:             WITH par_oPage.opt_4c_OpcVar
3152:                 .Top = 232
3153:                 .Left = 874
3154:                 .Width = 107
3155:                 .Height = 22
3156:                 .ButtonCount = 2
3157:                 .Value = 1
3158:                 .Themes = .F.
3159:                 .Visible = .T.
3160:             ENDWITH
3161:             WITH par_oPage.opt_4c_OpcVar.Buttons(1)
3162:                 .Caption = "Sim"
3163:                 .Top = 0
3164:                 .Left = 0
3165:                 .Width = 50
3166:                 .Height = 20
3167:                 .FontName = "Tahoma"
3168:                 .FontSize = 8
3169:                 .Themes = .F.
3170:                 .Value = 1
3171:             ENDWITH
3172:             WITH par_oPage.opt_4c_OpcVar.Buttons(2)
3173:                 .Caption = "N" + CHR(227) + "o"
3174:                 .Top = 0
3175:                 .Left = 52
3176:                 .Width = 50
3177:                 .Height = 20
3178:                 .FontName = "Tahoma"
3179:                 .FontSize = 8
3180:                 .Themes = .F.
3181:             ENDWITH
3182: 
3183:             *-- Label "Conjunto :" (Say37, top=206+29=235, left=408)
3184:             par_oPage.AddObject("lbl_4c_LbConjunto", "Label")
3185:             WITH par_oPage.lbl_4c_LbConjunto
3186:                 .Top = 235
3187:                 .Left = 408
3188:                 .Width = 53
3189:                 .Height = 15
3190:                 .FontName = "Tahoma"
3191:                 .FontSize = 8
3192:                 .BackStyle = 0
3193:                 .Caption = "Conjunto :"
3194:                 .Visible = .T.
3195:             ENDWITH
3196: 
3197:             *-- Label "Variacao :" (Say36, top=207+29=236, left=827)
3198:             par_oPage.AddObject("lbl_4c_LbVariacao", "Label")
3199:             WITH par_oPage.lbl_4c_LbVariacao
3200:                 .Top = 236
3201:                 .Left = 827
3202:                 .Width = 50
3203:                 .Height = 15
3204:                 .FontName = "Tahoma"
3205:                 .FontSize = 8
3206:                 .BackStyle = 0
3207:                 .Caption = "Varia" + CHR(231) + CHR(227) + "o :"
3208:                 .Visible = .T.
3209:             ENDWITH
3210: 
3211:             *-- txt_4c_QtPed (getQtPed, top=221+29=250, left=626, w=80)
3212:             par_oPage.AddObject("txt_4c_QtPed", "TextBox")
3213:             WITH par_oPage.txt_4c_QtPed
3214:                 .Top = 250
3215:                 .Left = 626
3216:                 .Width = 80
3217:                 .Height = 21
3218:                 .FontName = "Tahoma"
3219:                 .FontSize = 8
3220:                 .Themes = .F.
3221:                 .Visible = .T.
3222:             ENDWITH
3223: 
3224:             *-- Label "Qtde. Pedido :" (Say57, top=225+29=254, left=553)
3225:             par_oPage.AddObject("lbl_4c_LbQtPed", "Label")
3226:             WITH par_oPage.lbl_4c_LbQtPed
3227:                 .Top = 254
3228:                 .Left = 553
3229:                 .Width = 72
3230:                 .Height = 15
3231:                 .FontName = "Tahoma"
3232:                 .FontSize = 8
3233:                 .BackStyle = 0
3234:                 .Caption = "Qtde. Pedido :"
3235:                 .Visible = .T.
3236:             ENDWITH
3237: 
3238:             *-- txt_4c_DiasGar (getDiasGar, top=224+29=253, left=880, w=34)
3239:             par_oPage.AddObject("txt_4c_DiasGar", "TextBox")
3240:             WITH par_oPage.txt_4c_DiasGar
3241:                 .Top = 253
3242:                 .Left = 880
3243:                 .Width = 34
3244:                 .Height = 21
3245:                 .FontName = "Tahoma"
3246:                 .FontSize = 8
3247:                 .Themes = .F.
3248:                 .Visible = .T.
3249:             ENDWITH
3250: 
3251:             *-- Label "Garantia :" (Say46, top=228+29=257, left=827)
3252:             par_oPage.AddObject("lbl_4c_LbGarantia", "Label")
3253:             WITH par_oPage.lbl_4c_LbGarantia
3254:                 .Top = 257
3255:                 .Left = 827
3256:                 .Width = 50
3257:                 .Height = 15
3258:                 .FontName = "Tahoma"
3259:                 .FontSize = 8
3260:                 .BackStyle = 0
3261:                 .Caption = "Garantia :"
3262:                 .Visible = .T.
3263:             ENDWITH
3264: 
3265:             *-- Label "Dias" (Say47, top=228+29=257, left=918)
3266:             par_oPage.AddObject("lbl_4c_LbDias", "Label")
3267:             WITH par_oPage.lbl_4c_LbDias
3268:                 .Top = 257
3269:                 .Left = 918
3270:                 .Width = 22
3271:                 .Height = 15
3272:                 .FontName = "Tahoma"
3273:                 .FontSize = 8
3274:                 .BackStyle = 0
3275:                 .Caption = "Dias"
3276:                 .Visible = .T.
3277:             ENDWITH
3278: 
3279:             *-- chk_4c_GarVit (ChkGarVit "Vitalicia", top=228+29=257, left=943)
3280:             par_oPage.AddObject("chk_4c_GarVit", "CheckBox")
3281:             WITH par_oPage.chk_4c_GarVit
3282:                 .Top = 257
3283:                 .Left = 943
3284:                 .Width = 60
3285:                 .Height = 17
3286:                 .Caption = "Vital" + CHR(237) + "cia"
3287:                 .Value = 0
3288:                 .BackStyle = 0
3289:                 .FontName = "Tahoma"
3290:                 .FontSize = 8
3291:                 .Themes = .F.
3292:                 .Visible = .T.
3293:             ENDWITH
3294: 
3295:             *-- Label "Obs. Componente :" (Say22, top=247+29=276, left=529)
3296:             par_oPage.AddObject("lbl_4c_LbObsComp2", "Label")
3297:             WITH par_oPage.lbl_4c_LbObsComp2
3298:                 .Top = 276
3299:                 .Left = 529
3300:                 .Width = 96
3301:                 .Height = 15
3302:                 .FontName = "Tahoma"
3303:                 .FontSize = 8
3304:                 .BackStyle = 0
3305:                 .Caption = "Obs. Componente :"
3306:                 .Visible = .T.
3307:             ENDWITH
3308: 
3309:             *-- txt_4c_Altura (getaltura, top=247+29=276, left=923, w=48)
3310:             par_oPage.AddObject("txt_4c_Altura", "TextBox")
3311:             WITH par_oPage.txt_4c_Altura
3312:                 .Top = 276
3313:                 .Left = 923
3314:                 .Width = 48
3315:                 .Height = 21
3316:                 .FontName = "Tahoma"
3317:                 .FontSize = 8
3318:                 .Themes = .F.
3319:                 .Visible = .T.
3320:             ENDWITH
3321: 
3322:             *-- Label "Altura :" (Say44, top=250+29=279, left=881)
3323:             par_oPage.AddObject("lbl_4c_LbAltura", "Label")
3324:             WITH par_oPage.lbl_4c_LbAltura
3325:                 .Top = 279
3326:                 .Left = 881
3327:                 .Width = 38
3328:                 .Height = 15
3329:                 .FontName = "Tahoma"
3330:                 .FontSize = 8
3331:                 .BackStyle = 0
3332:                 .Caption = "Altura :"
3333:                 .Visible = .T.
3334:             ENDWITH
3335: 
3336:             *-- Label "MM" (Say52, top=251+29=280, left=976)
3337:             par_oPage.AddObject("lbl_4c_LbMM1", "Label")
3338:             WITH par_oPage.lbl_4c_LbMM1
3339:                 .Top = 280
3340:                 .Left = 976
3341:                 .Width = 18
3342:                 .Height = 15
3343:                 .FontName = "Tahoma"
3344:                 .FontSize = 8
3345:                 .BackStyle = 0
3346:                 .Caption = "MM"
3347:                 .Visible = .T.
3348:             ENDWITH
3349: 
3350:             *-- txt_4c_Obs1 (getObs1, observacao 1, top=265+29=294, left=626, w=220)
3351:             par_oPage.AddObject("txt_4c_Obs1", "TextBox")
3352:             WITH par_oPage.txt_4c_Obs1
3353:                 .Top = 294
3354:                 .Left = 626
3355:                 .Width = 220
3356:                 .Height = 21
3357:                 .FontName = "Tahoma"
3358:                 .FontSize = 8
3359:                 .MaxLength = 40
3360:                 .Themes = .F.
3361:                 .Visible = .T.
3362:             ENDWITH
3363: 
3364:             *-- Label "Observacao :" (Say7, top=269+29=298, left=558)
3365:             par_oPage.AddObject("lbl_4c_LbObs", "Label")
3366:             WITH par_oPage.lbl_4c_LbObs
3367:                 .Top = 298
3368:                 .Left = 558
3369:                 .Width = 67
3370:                 .Height = 15
3371:                 .FontName = "Tahoma"
3372:                 .FontSize = 8
3373:                 .BackStyle = 0
3374:                 .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
3375:                 .Visible = .T.
3376:             ENDWITH
3377: 
3378:             *-- txt_4c_Largura (getlargura, top=269+29=298, left=923, w=48)
3379:             par_oPage.AddObject("txt_4c_Largura", "TextBox")
3380:             WITH par_oPage.txt_4c_Largura
3381:                 .Top = 298
3382:                 .Left = 923
3383:                 .Width = 48
3384:                 .Height = 21
3385:                 .FontName = "Tahoma"
3386:                 .FontSize = 8
3387:                 .Themes = .F.
3388:                 .Visible = .T.
3389:             ENDWITH
3390: 
3391:             *-- Label "Largura :" (Say48, top=270+29=299, left=873)
3392:             par_oPage.AddObject("lbl_4c_LbLargura", "Label")
3393:             WITH par_oPage.lbl_4c_LbLargura
3394:                 .Top = 299
3395:                 .Left = 873
3396:                 .Width = 46
3397:                 .Height = 15
3398:                 .FontName = "Tahoma"
3399:                 .FontSize = 8
3400:                 .BackStyle = 0
3401:                 .Caption = "Largura :"
3402:                 .Visible = .T.
3403:             ENDWITH
3404: 
3405:             *-- Label "MM" (Say53, top=271+29=300, left=976)
3406:             par_oPage.AddObject("lbl_4c_LbMM2", "Label")
3407:             WITH par_oPage.lbl_4c_LbMM2
3408:                 .Top = 300
3409:                 .Left = 976
3410:                 .Width = 18
3411:                 .Height = 15
3412:                 .FontName = "Tahoma"
3413:                 .FontSize = 8
3414:                 .BackStyle = 0
3415:                 .Caption = "MM"
3416:                 .Visible = .T.
3417:             ENDWITH
3418: 
3419:             *-- txt_4c_Obs2 (getObs2, complemento, top=287+29=316, left=626, w=220)
3420:             par_oPage.AddObject("txt_4c_Obs2", "TextBox")
3421:             WITH par_oPage.txt_4c_Obs2
3422:                 .Top = 316
3423:                 .Left = 626
3424:                 .Width = 220
3425:                 .Height = 21
3426:                 .FontName = "Tahoma"
3427:                 .FontSize = 8
3428:                 .MaxLength = 40
3429:                 .Themes = .F.
3430:                 .Visible = .T.
3431:             ENDWITH
3432: 
3433:             *-- Label "Complemento :" (Say30, top=290+29=319, left=551)
3434:             par_oPage.AddObject("lbl_4c_LbCompl", "Label")
3435:             WITH par_oPage.lbl_4c_LbCompl
3436:                 .Top = 319
3437:                 .Left = 551
3438:                 .Width = 74
3439:                 .Height = 15
3440:                 .FontName = "Tahoma"
3441:                 .FontSize = 8
3442:                 .BackStyle = 0
3443:                 .Caption = "Complemento :"
3444:                 .Visible = .T.
3445:             ENDWITH
3446: 
3447:             *-- txt_4c_Diametro (getdiametro, top=291+29=320, left=923, w=48)
3448:             par_oPage.AddObject("txt_4c_Diametro", "TextBox")
3449:             WITH par_oPage.txt_4c_Diametro
3450:                 .Top = 320
3451:                 .Left = 923
3452:                 .Width = 48
3453:                 .Height = 21
3454:                 .FontName = "Tahoma"
3455:                 .FontSize = 8
3456:                 .Themes = .F.
3457:                 .Visible = .T.
3458:             ENDWITH
3459: 
3460:             *-- Label "Diametro :" (Say49, top=293+29=322, left=867)
3461:             par_oPage.AddObject("lbl_4c_LbDiam", "Label")
3462:             WITH par_oPage.lbl_4c_LbDiam
3463:                 .Top = 322
3464:                 .Left = 867
3465:                 .Width = 52
3466:                 .Height = 15
3467:                 .FontName = "Tahoma"
3468:                 .FontSize = 8
3469:                 .BackStyle = 0
3470:                 .Caption = "Di" + CHR(226) + "metro :"
3471:                 .Visible = .T.
3472:             ENDWITH
3473: 
3474:             *-- cmd_4c_Tamanho (cmdTamanho, top=294+29=323, left=513, w=32, h=29)
3475:             par_oPage.AddObject("cmd_4c_Tamanho", "CommandButton")
3476:             WITH par_oPage.cmd_4c_Tamanho
3477:                 .Top = 323
3478:                 .Left = 513
3479:                 .Width = 32
3480:                 .Height = 29
3481:                 .Caption = "Tam"
3482:                 .FontName = "Tahoma"
3483:                 .FontSize = 8
3484:                 .Themes = .F.
3485:                 .Visible = .T.
3486:             ENDWITH
3487: 
3488:             *-- Label "MM" (Say54, top=294+29=323, left=976)
3489:             par_oPage.AddObject("lbl_4c_LbMM3", "Label")
3490:             WITH par_oPage.lbl_4c_LbMM3
3491:                 .Top = 323
3492:                 .Left = 976
3493:                 .Width = 18
3494:                 .Height = 15
3495:                 .FontName = "Tahoma"
3496:                 .FontSize = 8
3497:                 .BackStyle = 0
3498:                 .Caption = "MM"
3499:                 .Visible = .T.
3500:             ENDWITH
3501: 
3502:             *-- txt_4c_Tam (getTam, top=298+29=327, left=474, w=38)
3503:             par_oPage.AddObject("txt_4c_Tam", "TextBox")
3504:             WITH par_oPage.txt_4c_Tam
3505:                 .Top = 327
3506:                 .Left = 474
3507:                 .Width = 38
3508:                 .Height = 21
3509:                 .FontName = "Tahoma"
3510:                 .FontSize = 8
3511:                 .Themes = .F.
3512:                 .Visible = .T.
3513:             ENDWITH
3514: 
3515:             *-- txt_4c_CorPro (getCor, top=298+29=327, left=401, w=38)
3516:             par_oPage.AddObject("txt_4c_CorPro", "TextBox")
3517:             WITH par_oPage.txt_4c_CorPro
3518:                 .Top = 327
3519:                 .Left = 401
3520:                 .Width = 38
3521:                 .Height = 21
3522:                 .FontName = "Tahoma"
3523:                 .FontSize = 8
3524:                 .Themes = .F.
3525:                 .Visible = .T.
3526:             ENDWITH
3527: 
3528:             *-- cmd_4c_BtnFornecedor (Bot_Fornecedor, top=299+29=328, left=266, w=32, h=22)
3529:             par_oPage.AddObject("cmd_4c_BtnFornecedor", "CommandButton")
3530:             WITH par_oPage.cmd_4c_BtnFornecedor
3531:                 .Top = 328
3532:                 .Left = 266
3533:                 .Width = 32
3534:                 .Height = 22
3535:                 .Caption = "F4"
3536:                 .FontName = "Tahoma"
3537:                 .FontSize = 8
3538:                 .Themes = .F.
3539:                 .Visible = .T.
3540:             ENDWITH
3541: 
3542:             *-- Label "Padrao > Cor :" (Say42, top=302+29=331, left=323)
3543:             par_oPage.AddObject("lbl_4c_LbCorPad", "Label")
3544:             WITH par_oPage.lbl_4c_LbCorPad
3545:                 .Top = 331
3546:                 .Left = 323
3547:                 .Width = 70
3548:                 .Height = 15
3549:                 .FontName = "Tahoma"
3550:                 .FontSize = 8
3551:                 .BackStyle = 0
3552:                 .Caption = "Padr" + CHR(227) + "o > Cor :"
3553:                 .Visible = .T.
3554:             ENDWITH
3555: 
3556:             *-- Label "Tam:" (Say43, top=302+29=331, left=442)
3557:             par_oPage.AddObject("lbl_4c_LbTam", "Label")
3558:             WITH par_oPage.lbl_4c_LbTam
3559:                 .Top = 331
3560:                 .Left = 442
3561:                 .Width = 30
3562:                 .Height = 15
3563:                 .FontName = "Tahoma"
3564:                 .FontSize = 8
3565:                 .BackStyle = 0
3566:                 .Caption = "Tam:"
3567:                 .Visible = .T.
3568:             ENDWITH
3569: 
3570:             *-- txt_4c_Dtucp (get_Dtucp, data ult.compra, top=309+29=338, left=626, w=79) readonly
3571:             par_oPage.AddObject("txt_4c_Dtucp", "TextBox")
3572:             WITH par_oPage.txt_4c_Dtucp
3573:                 .Top = 338
3574:                 .Left = 626
3575:                 .Width = 79
3576:                 .Height = 21
3577:                 .FontName = "Tahoma"
3578:                 .FontSize = 8
3579:                 .ReadOnly = .T.
3580:                 .Themes = .F.
3581:                 .Visible = .T.
3582:             ENDWITH
3583: 
3584:             *-- txt_4c_Vucp (Get_vucp, valor ult.compra, top=309+29=338, left=706, w=106) readonly
3585:             par_oPage.AddObject("txt_4c_Vucp", "TextBox")
3586:             WITH par_oPage.txt_4c_Vucp
3587:                 .Top = 338
3588:                 .Left = 706
3589:                 .Width = 106
3590:                 .Height = 21
3591:                 .FontName = "Tahoma"
3592:                 .FontSize = 8
3593:                 .ReadOnly = .T.
3594:                 .Themes = .F.
3595:                 .Visible = .T.
3596:             ENDWITH
3597: 
3598:             *-- txt_4c_Mucp (Get_mucp, moeda ult.compra, top=309+29=338, left=813, w=33) readonly
3599:             par_oPage.AddObject("txt_4c_Mucp", "TextBox")
3600:             WITH par_oPage.txt_4c_Mucp
3601:                 .Top = 338
3602:                 .Left = 813
3603:                 .Width = 33
3604:                 .Height = 21
3605:                 .FontName = "Tahoma"
3606:                 .FontSize = 8
3607:                 .ReadOnly = .T.
3608:                 .Themes = .F.
3609:                 .Visible = .T.
3610:             ENDWITH
3611: 
3612:             *-- Label "Ult.Compra :" (Say19, top=313+29=342, left=562)
3613:             par_oPage.AddObject("lbl_4c_LbUltComp", "Label")
3614:             WITH par_oPage.lbl_4c_LbUltComp
3615:                 .Top = 342
3616:                 .Left = 562
3617:                 .Width = 63
3618:                 .Height = 15
3619:                 .FontName = "Tahoma"
3620:                 .FontSize = 8
3621:                 .BackStyle = 0
3622:                 .Caption = CHR(218) + "lt.Compra :"
3623:                 .Visible = .T.
3624:             ENDWITH
3625: 
3626:             *-- txt_4c_Espessura (getespessura, top=313+29=342, left=923, w=48)
3627:             par_oPage.AddObject("txt_4c_Espessura", "TextBox")
3628:             WITH par_oPage.txt_4c_Espessura
3629:                 .Top = 342
3630:                 .Left = 923
3631:                 .Width = 48
3632:                 .Height = 21
3633:                 .FontName = "Tahoma"
3634:                 .FontSize = 8
3635:                 .Themes = .F.
3636:                 .Visible = .T.
3637:             ENDWITH
3638: 
3639:             *-- Label "Espessura :" (Say50, top=316+29=345, left=861)
3640:             par_oPage.AddObject("lbl_4c_LbEspess", "Label")
3641:             WITH par_oPage.lbl_4c_LbEspess
3642:                 .Top = 345
3643:                 .Left = 861
3644:                 .Width = 58
3645:                 .Height = 15
3646:                 .FontName = "Tahoma"
3647:                 .FontSize = 8
3648:                 .BackStyle = 0
3649:                 .Caption = "Espessura :"
3650:                 .Visible = .T.
3651:             ENDWITH
3652: 
3653:             *-- Label "MM" (Say55, top=317+29=346, left=976)
3654:             par_oPage.AddObject("lbl_4c_LbMM4", "Label")
3655:             WITH par_oPage.lbl_4c_LbMM4
3656:                 .Top = 346
3657:                 .Left = 976
3658:                 .Width = 18
3659:                 .Height = 15
3660:                 .FontName = "Tahoma"
3661:                 .FontSize = 8
3662:                 .BackStyle = 0
3663:                 .Caption = "MM"
3664:                 .Visible = .T.
3665:             ENDWITH
3666: 
3667:             *-- txt_4c_CodFinP (getCodFinP, top=322+29=351, left=113, w=31)
3668:             par_oPage.AddObject("txt_4c_CodFinP", "TextBox")
3669:             WITH par_oPage.txt_4c_CodFinP
3670:                 .Top = 351
3671:                 .Left = 113
3672:                 .Width = 31
3673:                 .Height = 23
3674:                 .FontName = "Tahoma"
3675:                 .FontSize = 8
3676:                 .MaxLength = 5
3677:                 .Themes = .F.
3678:                 .Visible = .T.
3679:             ENDWITH
3680: 
3681:             *-- txt_4c_DesFinP (getDesFinP, desc finalidade, top=322+29=351, left=145, w=150) readonly
3682:             par_oPage.AddObject("txt_4c_DesFinP", "TextBox")
3683:             WITH par_oPage.txt_4c_DesFinP
3684:                 .Top = 351
3685:                 .Left = 145
3686:                 .Width = 150
3687:                 .Height = 23
3688:                 .FontName = "Tahoma"
3689:                 .FontSize = 8
3690:                 .ReadOnly = .T.
3691:                 .Themes = .F.
3692:                 .Visible = .T.
3693:             ENDWITH
3694: 
3695:             *-- txt_4c_PesoBs (getPesoBs, peso bruto, top=322+29=351, left=401, w=111)
3696:             par_oPage.AddObject("txt_4c_PesoBs", "TextBox")
3697:             WITH par_oPage.txt_4c_PesoBs
3698:                 .Top = 351
3699:                 .Left = 401
3700:                 .Width = 111
3701:                 .Height = 23
3702:                 .FontName = "Tahoma"
3703:                 .FontSize = 8
3704:                 .Themes = .F.
3705:                 .Visible = .T.
3706:             ENDWITH
3707: 
3708:             *-- Label "Modelo :" (lblModelo, top=326+29=355, left=7)
3709:             par_oPage.AddObject("lbl_4c_LbModelo", "Label")
3710:             WITH par_oPage.lbl_4c_LbModelo
3711:                 .Top = 355
3712:                 .Left = 7
3713:                 .Width = 104
3714:                 .Height = 15
3715:                 .FontName = "Tahoma"
3716:                 .FontSize = 8
3717:                 .BackStyle = 0
3718:                 .Caption = "Modelo :"
3719:                 .Visible = .T.
3720:             ENDWITH
3721: 
3722:             *-- Label "Peso Bruto :" (Say35, top=326+29=355, left=336)
3723:             par_oPage.AddObject("lbl_4c_LbPesoBruto", "Label")
3724:             WITH par_oPage.lbl_4c_LbPesoBruto
3725:                 .Top = 355
3726:                 .Left = 336
3727:                 .Width = 61
3728:                 .Height = 15
3729:                 .FontName = "Tahoma"
3730:                 .FontSize = 8
3731:                 .BackStyle = 0
3732:                 .Caption = "Peso Bruto :"
3733:                 .Visible = .T.
3734:             ENDWITH
3735: 
3736:             *-- txt_4c_QtdUltComp (Get_qtdultcomp, top=331+29=360, left=626, w=79) readonly
3737:             par_oPage.AddObject("txt_4c_QtdUltComp", "TextBox")
3738:             WITH par_oPage.txt_4c_QtdUltComp
3739:                 .Top = 360
3740:                 .Left = 626
3741:                 .Width = 79
3742:                 .Height = 21
3743:                 .FontName = "Tahoma"
3744:                 .FontSize = 8
3745:                 .ReadOnly = .T.
3746:                 .Themes = .F.
3747:                 .Visible = .T.
3748:             ENDWITH
3749: 
3750:             *-- Label "Qtde Ult.Compra :" (Say45, top=335+29=364, left=535)
3751:             par_oPage.AddObject("lbl_4c_LbQtdUltComp", "Label")
3752:             WITH par_oPage.lbl_4c_LbQtdUltComp
3753:                 .Top = 364
3754:                 .Left = 535
3755:                 .Width = 90
3756:                 .Height = 15
3757:                 .FontName = "Tahoma"
3758:                 .FontSize = 8
3759:                 .BackStyle = 0
3760:                 .Caption = "Qtde " + CHR(218) + "lt.Compra :"
3761:                 .Visible = .T.
3762:             ENDWITH
3763: 
3764:             *-- txt_4c_Compriment (getcompriment, top=335+29=364, left=923, w=48)
3765:             par_oPage.AddObject("txt_4c_Compriment", "TextBox")
3766:             WITH par_oPage.txt_4c_Compriment
3767:                 .Top = 364
3768:                 .Left = 923
3769:                 .Width = 48
3770:                 .Height = 21
3771:                 .FontName = "Tahoma"
3772:                 .FontSize = 8
3773:                 .Themes = .F.
3774:                 .Visible = .T.
3775:             ENDWITH
3776: 
3777:             *-- Label "Comprimento :" (Say51, top=339+29=368, left=847)
3778:             par_oPage.AddObject("lbl_4c_LbCompriment", "Label")
3779:             WITH par_oPage.lbl_4c_LbCompriment
3780:                 .Top = 368
3781:                 .Left = 847
3782:                 .Width = 72
3783:                 .Height = 15
3784:                 .FontName = "Tahoma"
3785:                 .FontSize = 8
3786:                 .BackStyle = 0
3787:                 .Caption = "Comprimento :"
3788:                 .Visible = .T.
3789:             ENDWITH
3790: 
3791:             *-- Label "CM" (Say56, top=340+29=369, left=976)
3792:             par_oPage.AddObject("lbl_4c_LbCM", "Label")
3793:             WITH par_oPage.lbl_4c_LbCM
3794:                 .Top = 369
3795:                 .Left = 976
3796:                 .Width = 17
3797:                 .Height = 15
3798:                 .FontName = "Tahoma"
3799:                 .FontSize = 8
3800:                 .BackStyle = 0
3801:                 .Caption = "CM"
3802:                 .Visible = .T.
3803:             ENDWITH
3804: 
3805:             *-- txt_4c_PesoPmedio (getPmedio, peso liquido, top=346+29=375, left=401, w=111)
3806:             par_oPage.AddObject("txt_4c_PesoPmedio", "TextBox")
3807:             WITH par_oPage.txt_4c_PesoPmedio
3808:                 .Top = 375
3809:                 .Left = 401
3810:                 .Width = 111
3811:                 .Height = 23
3812:                 .FontName = "Tahoma"
3813:                 .FontSize = 8
3814:                 .Themes = .F.
3815:                 .Visible = .T.
3816:             ENDWITH
3817: 
3818:             *-- txt_4c_CodAcb (get_codacb, acabamento, top=346+29=375, left=113, w=31)
3819:             par_oPage.AddObject("txt_4c_CodAcb", "TextBox")
3820:             WITH par_oPage.txt_4c_CodAcb
3821:                 .Top = 375
3822:                 .Left = 113
3823:                 .Width = 31
3824:                 .Height = 23
3825:                 .FontName = "Tahoma"
3826:                 .FontSize = 8
3827:                 .MaxLength = 5
3828:                 .Themes = .F.
3829:                 .Visible = .T.
3830:             ENDWITH
3831: 
3832:             *-- txt_4c_DesAcb (get_Dacb, desc acabamento, top=346+29=375, left=145, w=150) readonly
3833:             par_oPage.AddObject("txt_4c_DesAcb", "TextBox")
3834:             WITH par_oPage.txt_4c_DesAcb
3835:                 .Top = 375
3836:                 .Left = 145
3837:                 .Width = 150
3838:                 .Height = 23
3839:                 .FontName = "Tahoma"
3840:                 .FontSize = 8
3841:                 .ReadOnly = .T.
3842:                 .Themes = .F.
3843:                 .Visible = .T.
3844:             ENDWITH
3845: 
3846:             *-- Label "Peso Liquido :" (Say34, top=350+29=379, left=329)
3847:             par_oPage.AddObject("lbl_4c_LbPesoLiq", "Label")
3848:             WITH par_oPage.lbl_4c_LbPesoLiq
3849:                 .Top = 379
3850:                 .Left = 329
3851:                 .Width = 68
3852:                 .Height = 15
3853:                 .FontName = "Tahoma"
3854:                 .FontSize = 8
3855:                 .BackStyle = 0
3856:                 .Caption = "Peso L" + CHR(237) + "quido :"
3857:                 .Visible = .T.
3858:             ENDWITH
3859: 
3860:             *-- Label "Acabamento :" (lblAcabamento, top=350+29=379, left=7)
3861:             par_oPage.AddObject("lbl_4c_LbAcab", "Label")
3862:             WITH par_oPage.lbl_4c_LbAcab
3863:                 .Top = 379
3864:                 .Left = 7
3865:                 .Width = 104
3866:                 .Height = 15
3867:                 .FontName = "Tahoma"
3868:                 .FontSize = 8
3869:                 .BackStyle = 0
3870:                 .Caption = "Acabamento :"
3871:                 .Visible = .T.
3872:             ENDWITH
3873: 
3874:             *-- txt_4c_Estoques (getEstoques, top=353+29=382, left=626, w=79) readonly
3875:             par_oPage.AddObject("txt_4c_Estoques", "TextBox")
3876:             WITH par_oPage.txt_4c_Estoques
3877:                 .Top = 382
3878:                 .Left = 626
3879:                 .Width = 79
3880:                 .Height = 21
3881:                 .FontName = "Tahoma"
3882:                 .FontSize = 8
3883:                 .ReadOnly = .T.
3884:                 .Themes = .F.
3885:                 .Visible = .T.
3886:             ENDWITH
3887: 
3888:             *-- txt_4c_QtdEsts (getQtdEsts, top=353+29=382, left=706, w=79) readonly
3889:             par_oPage.AddObject("txt_4c_QtdEsts", "TextBox")
3890:             WITH par_oPage.txt_4c_QtdEsts
3891:                 .Top = 382
3892:                 .Left = 706
3893:                 .Width = 79
3894:                 .Height = 21
3895:                 .FontName = "Tahoma"
3896:                 .FontSize = 8
3897:                 .ReadOnly = .T.
3898:                 .Themes = .F.
3899:                 .Visible = .T.
3900:             ENDWITH
3901: 
3902:             *-- cmd_4c_Estoque (cmdEstoque, top=353+29=382, left=788, w=42, h=42)
3903:             par_oPage.AddObject("cmd_4c_Estoque", "CommandButton")
3904:             WITH par_oPage.cmd_4c_Estoque
3905:                 .Top = 382
3906:                 .Left = 788
3907:                 .Width = 42
3908:                 .Height = 42
3909:                 .Caption = "Estoq."
3910:                 .FontName = "Tahoma"
3911:                 .FontSize = 8
3912:                 .Themes = .F.
3913:                 .Visible = .T.
3914:             ENDWITH
3915: 
3916:             *-- Label "Estoque :" (Say28, top=357+29=386, left=577)
3917:             par_oPage.AddObject("lbl_4c_LbEstq", "Label")
3918:             WITH par_oPage.lbl_4c_LbEstq
3919:                 .Top = 386
3920:                 .Left = 577
3921:                 .Width = 48
3922:                 .Height = 15
3923:                 .FontName = "Tahoma"
3924:                 .FontSize = 8
3925:                 .BackStyle = 0
3926:                 .Caption = "Estoque :"
3927:                 .Visible = .T.
3928:             ENDWITH
3929: 
3930:             *-- Label "Data / Usuario" (Say20, top=365+29=394, left=833)
3931:             par_oPage.AddObject("lbl_4c_LbDataUsr", "Label")
3932:             WITH par_oPage.lbl_4c_LbDataUsr
3933:                 .Top = 394
3934:                 .Left = 833
3935:                 .Width = 84
3936:                 .Height = 15
3937:                 .FontName = "Tahoma"
3938:                 .FontSize = 8
3939:                 .BackStyle = 0
3940:                 .Caption = "Data / Usu" + CHR(225) + "rio"
3941:                 .Visible = .T.
3942:             ENDWITH
3943: 
3944:             *-- txt_4c_Local (Get_Local, top=370+29=399, left=401, w=111)
3945:             par_oPage.AddObject("txt_4c_Local", "TextBox")
3946:             WITH par_oPage.txt_4c_Local
3947:                 .Top = 399
3948:                 .Left = 401
3949:                 .Width = 111
3950:                 .Height = 23
3951:                 .FontName = "Tahoma"
3952:                 .FontSize = 8
3953:                 .Themes = .F.
3954:                 .Visible = .T.
3955:             ENDWITH
3956: 
3957:             *-- txt_4c_Class (Get_Class, classificacao, top=370+29=399, left=113, w=31)
3958:             par_oPage.AddObject("txt_4c_Class", "TextBox")
3959:             WITH par_oPage.txt_4c_Class
3960:                 .Top = 399
3961:                 .Left = 113
3962:                 .Width = 31
3963:                 .Height = 23
3964:                 .FontName = "Tahoma"
3965:                 .FontSize = 8
3966:                 .MaxLength = 5
3967:                 .Themes = .F.
3968:                 .Visible = .T.
3969:             ENDWITH
3970: 
3971:             *-- txt_4c_DClass (Get_DClass, desc classificacao, top=370+29=399, left=145, w=150) readonly
3972:             par_oPage.AddObject("txt_4c_DClass", "TextBox")
3973:             WITH par_oPage.txt_4c_DClass
3974:                 .Top = 399
3975:                 .Left = 145
3976:                 .Width = 150
3977:                 .Height = 23
3978:                 .FontName = "Tahoma"
3979:                 .FontSize = 8
3980:                 .ReadOnly = .T.
3981:                 .Themes = .F.
3982:                 .Visible = .T.
3983:             ENDWITH
3984: 
3985:             *-- Label "Local :" (Say5, top=374+29=403, left=364)
3986:             par_oPage.AddObject("lbl_4c_LbLocal", "Label")
3987:             WITH par_oPage.lbl_4c_LbLocal
3988:                 .Top = 403
3989:                 .Left = 364
3990:                 .Width = 33
3991:                 .Height = 15
3992:                 .FontName = "Tahoma"
3993:                 .FontSize = 8
3994:                 .BackStyle = 0
3995:                 .Caption = "Local :"
3996:                 .Visible = .T.
3997:             ENDWITH
3998: 
3999:             *-- Label "Classificacao :" (lblClassificacao, top=374+29=403, left=7)
4000:             par_oPage.AddObject("lbl_4c_LbClassif", "Label")
4001:             WITH par_oPage.lbl_4c_LbClassif
4002:                 .Top = 403
4003:                 .Left = 7
4004:                 .Width = 104
4005:                 .Height = 15
4006:                 .FontName = "Tahoma"
4007:                 .FontSize = 8
4008:                 .BackStyle = 0
4009:                 .Caption = "Classifica" + CHR(231) + CHR(227) + "o :"
4010:                 .Visible = .T.
4011:             ENDWITH
4012: 
4013:             *-- txt_4c_Ctotal (getCtotal, custo total, top=375+29=404, left=626, w=127) readonly
4014:             par_oPage.AddObject("txt_4c_Ctotal", "TextBox")
4015:             WITH par_oPage.txt_4c_Ctotal
4016:                 .Top = 404
4017:                 .Left = 626
4018:                 .Width = 127
4019:                 .Height = 21
4020:                 .FontName = "Tahoma"
4021:                 .FontSize = 8
4022:                 .ReadOnly = .T.
4023:                 .Themes = .F.
4024:                 .Visible = .T.
4025:             ENDWITH
4026: 
4027:             *-- txt_4c_Mctotal (getMctotal, moeda custo, top=375+29=404, left=754, w=31) readonly
4028:             par_oPage.AddObject("txt_4c_Mctotal", "TextBox")
4029:             WITH par_oPage.txt_4c_Mctotal
4030:                 .Top = 404
4031:                 .Left = 754
4032:                 .Width = 31
4033:                 .Height = 21
4034:                 .FontName = "Tahoma"
4035:                 .FontSize = 8
4036:                 .ReadOnly = .T.
4037:                 .Themes = .F.
4038:                 .Visible = .T.
4039:             ENDWITH
4040: 
4041:             *-- Label "Valor de Custo :" (Say3, top=379+29=408, left=546)
4042:             par_oPage.AddObject("lbl_4c_LbCusto", "Label")
4043:             WITH par_oPage.lbl_4c_LbCusto
4044:                 .Top = 408
4045:                 .Left = 546
4046:                 .Width = 79
4047:                 .Height = 15
4048:                 .FontName = "Tahoma"
4049:                 .FontSize = 8
4050:                 .BackStyle = 0
4051:                 .Caption = "Valor de Custo :"
4052:                 .Visible = .T.
4053:             ENDWITH
4054: 
4055:             *-- Label "Inclusao" (Say24, top=384+29=413, left=833)
4056:             par_oPage.AddObject("lbl_4c_LbIncl", "Label")
4057:             WITH par_oPage.lbl_4c_LbIncl
4058:                 .Top = 413
4059:                 .Left = 833
4060:                 .Width = 48
4061:                 .Height = 15
4062:                 .FontName = "Tahoma"
4063:                 .FontSize = 8
4064:                 .BackStyle = 0
4065:                 .Caption = "Inclus" + CHR(227) + "o"
4066:                 .Visible = .T.
4067:             ENDWITH
4068: 
4069:             *-- Label "Alteracao" (Say25, top=384+29=413, left=914)
4070:             par_oPage.AddObject("lbl_4c_LbAlter", "Label")
4071:             WITH par_oPage.lbl_4c_LbAlter
4072:                 .Top = 413
4073:                 .Left = 914
4074:                 .Width = 48
4075:                 .Height = 15
4076:                 .FontName = "Tahoma"
4077:                 .FontSize = 8
4078:                 .BackStyle = 0
4079:                 .Caption = "Altera" + CHR(231) + CHR(227) + "o"
4080:                 .Visible = .T.
4081:             ENDWITH
4082: 
4083:             *-- txt_4c_Cuni (Get_Cuni, unidade 1, top=394+29=423, left=113, w=31)
4084:             par_oPage.AddObject("txt_4c_Cuni", "TextBox")
4085:             WITH par_oPage.txt_4c_Cuni
4086:                 .Top = 423
4087:                 .Left = 113
4088:                 .Width = 31
4089:                 .Height = 23
4090:                 .FontName = "Tahoma"
4091:                 .FontSize = 8
4092:                 .MaxLength = 5
4093:                 .Themes = .F.
4094:                 .Visible = .T.
4095:             ENDWITH
4096: 
4097:             *-- txt_4c_Duni (Get_Duni, desc unidade 1, top=394+29=423, left=145, w=150) readonly
4098:             par_oPage.AddObject("txt_4c_Duni", "TextBox")
4099:             WITH par_oPage.txt_4c_Duni
4100:                 .Top = 423
4101:                 .Left = 145
4102:                 .Width = 150
4103:                 .Height = 23
4104:                 .FontName = "Tahoma"
4105:                 .FontSize = 8
4106:                 .ReadOnly = .T.
4107:                 .Themes = .F.
4108:                 .Visible = .T.
4109:             ENDWITH
4110: 
4111:             *-- txt_4c_Cunip (Get_cunip, unidade 2, top=394+29=423, left=330, w=31)
4112:             par_oPage.AddObject("txt_4c_Cunip", "TextBox")
4113:             WITH par_oPage.txt_4c_Cunip
4114:                 .Top = 423
4115:                 .Left = 330
4116:                 .Width = 31
4117:                 .Height = 23
4118:                 .FontName = "Tahoma"
4119:                 .FontSize = 8
4120:                 .MaxLength = 5
4121:                 .Themes = .F.
4122:                 .Visible = .T.
4123:             ENDWITH
4124: 
4125:             *-- txt_4c_Dunip (get_dunip, desc unidade 2, top=394+29=423, left=362, w=150) readonly
4126:             par_oPage.AddObject("txt_4c_Dunip", "TextBox")
4127:             WITH par_oPage.txt_4c_Dunip
4128:                 .Top = 423
4129:                 .Left = 362
4130:                 .Width = 150
4131:                 .Height = 23
4132:                 .FontName = "Tahoma"
4133:                 .FontSize = 8
4134:                 .ReadOnly = .T.
4135:                 .Themes = .F.
4136:                 .Visible = .T.
4137:             ENDWITH
4138: 
4139:             *-- txt_4c_Pvenda (getPvenda, preco venda, top=397+29=426, left=626, w=127)
4140:             par_oPage.AddObject("txt_4c_Pvenda", "TextBox")
4141:             WITH par_oPage.txt_4c_Pvenda
4142:                 .Top = 426
4143:                 .Left = 626
4144:                 .Width = 127
4145:                 .Height = 21
4146:                 .FontName = "Tahoma"
4147:                 .FontSize = 8
4148:                 .Themes = .F.
4149:                 .Visible = .T.
4150:             ENDWITH
4151: 
4152:             *-- txt_4c_Mpvenda (getMpvenda, moeda preco, top=397+29=426, left=754, w=31)
4153:             par_oPage.AddObject("txt_4c_Mpvenda", "TextBox")
4154:             WITH par_oPage.txt_4c_Mpvenda
4155:                 .Top = 426
4156:                 .Left = 754
4157:                 .Width = 31
4158:                 .Height = 21
4159:                 .FontName = "Tahoma"
4160:                 .FontSize = 8
4161:                 .Themes = .F.
4162:                 .Visible = .T.
4163:             ENDWITH
4164: 
4165:             *-- txt_4c_DtIncs (Get_DtIncs, data inclusao, top=397+29=426, left=833, w=79) readonly
4166:             par_oPage.AddObject("txt_4c_DtIncs", "TextBox")
4167:             WITH par_oPage.txt_4c_DtIncs
4168:                 .Top = 426
4169:                 .Left = 833
4170:                 .Width = 79
4171:                 .Height = 21
4172:                 .FontName = "Tahoma"
4173:                 .FontSize = 8
4174:                 .ReadOnly = .T.
4175:                 .Themes = .F.
4176:                 .Visible = .T.
4177:             ENDWITH
4178: 
4179:             *-- txt_4c_DataAlts (getDataAlts, data alteracao, top=397+29=426, left=914, w=79) readonly
4180:             par_oPage.AddObject("txt_4c_DataAlts", "TextBox")
4181:             WITH par_oPage.txt_4c_DataAlts
4182:                 .Top = 426
4183:                 .Left = 914
4184:                 .Width = 79
4185:                 .Height = 21
4186:                 .FontName = "Tahoma"
4187:                 .FontSize = 8
4188:                 .ReadOnly = .T.
4189:                 .Themes = .F.
4190:                 .Visible = .T.
4191:             ENDWITH
4192: 
4193:             *-- Label "Unidades (1) :" (Say14, top=398+29=427, left=41)
4194:             par_oPage.AddObject("lbl_4c_LbUnid", "Label")
4195:             WITH par_oPage.lbl_4c_LbUnid
4196:                 .Top = 427
4197:                 .Left = 41
4198:                 .Width = 70
4199:                 .Height = 15
4200:                 .FontName = "Tahoma"
4201:                 .FontSize = 8
4202:                 .BackStyle = 0
4203:                 .Caption = "Unidades (1) :"
4204:                 .Visible = .T.
4205:             ENDWITH
4206: 
4207:             *-- Label "(2) :" (Say18, top=398+29=427, left=301)
4208:             par_oPage.AddObject("lbl_4c_LbUnid2", "Label")
4209:             WITH par_oPage.lbl_4c_LbUnid2
4210:                 .Top = 427
4211:                 .Left = 301
4212:                 .Width = 23
4213:                 .Height = 15
4214:                 .FontName = "Tahoma"
4215:                 .FontSize = 8
4216:                 .BackStyle = 0
4217:                 .Caption = "(2) :"
4218:                 .Visible = .T.
4219:             ENDWITH
4220: 
4221:             *-- Label "Valor de Venda :" (Say4, top=400+29=429, left=505)
4222:             par_oPage.AddObject("lbl_4c_LbVenda", "Label")
4223:             WITH par_oPage.lbl_4c_LbVenda
4224:                 .Top = 429
4225:                 .Left = 505
4226:                 .Width = 120
4227:                 .Height = 15
4228:                 .FontName = "Tahoma"
4229:                 .FontSize = 8
4230:                 .BackStyle = 0
4231:                 .Caption = "Valor de Venda :"
4232:                 .Visible = .T.
4233:             ENDWITH
4234: 
4235:             *-- txt_4c_CodIdent (GetCodIdent, cod identidade, top=418+29=447, left=113, w=182)
4236:             par_oPage.AddObject("txt_4c_CodIdent", "TextBox")
4237:             WITH par_oPage.txt_4c_CodIdent
4238:                 .Top = 447
4239:                 .Left = 113
4240:                 .Width = 182
4241:                 .Height = 23
4242:                 .FontName = "Tahoma"
4243:                 .FontSize = 8
4244:                 .MaxLength = 30
4245:                 .Themes = .F.
4246:                 .Visible = .T.
4247:             ENDWITH
4248: 
4249:             *-- txt_4c_Fvenda (getFvenda, fator venda, top=419+29=448, left=626, w=127)
4250:             par_oPage.AddObject("txt_4c_Fvenda", "TextBox")
4251:             WITH par_oPage.txt_4c_Fvenda
4252:                 .Top = 448
4253:                 .Left = 626
4254:                 .Width = 127
4255:                 .Height = 21
4256:                 .FontName = "Tahoma"
4257:                 .FontSize = 8
4258:                 .Themes = .F.
4259:                 .Visible = .T.
4260:             ENDWITH
4261: 
4262:             *-- txt_4c_Mfvenda (getMfvenda, moeda fator, top=419+29=448, left=754, w=31)
4263:             par_oPage.AddObject("txt_4c_Mfvenda", "TextBox")
4264:             WITH par_oPage.txt_4c_Mfvenda
4265:                 .Top = 448
4266:                 .Left = 754
4267:                 .Width = 31
4268:                 .Height = 21
4269:                 .FontName = "Tahoma"
4270:                 .FontSize = 8
4271:                 .Themes = .F.
4272:                 .Visible = .T.
4273:             ENDWITH
4274: 
4275:             *-- txt_4c_Usuario (Get_Usuario, usuario inclusao, top=419+29=448, left=833, w=79) readonly
4276:             par_oPage.AddObject("txt_4c_Usuario", "TextBox")
4277:             WITH par_oPage.txt_4c_Usuario
4278:                 .Top = 448
4279:                 .Left = 833
4280:                 .Width = 79
4281:                 .Height = 21
4282:                 .FontName = "Tahoma"
4283:                 .FontSize = 8
4284:                 .ReadOnly = .T.
4285:                 .Themes = .F.
4286:                 .Visible = .T.
4287:             ENDWITH
4288: 
4289:             *-- txt_4c_UsuaAlts (getUsuaAlts, usuario alteracao, top=419+29=448, left=914, w=79) readonly
4290:             par_oPage.AddObject("txt_4c_UsuaAlts", "TextBox")
4291:             WITH par_oPage.txt_4c_UsuaAlts
4292:                 .Top = 448
4293:                 .Left = 914
4294:                 .Width = 79
4295:                 .Height = 21
4296:                 .FontName = "Tahoma"
4297:                 .FontSize = 8
4298:                 .ReadOnly = .T.
4299:                 .Themes = .F.
4300:                 .Visible = .T.
4301:             ENDWITH
4302: 
4303:             *-- Label "Fator de Venda :" (Say6, top=422+29=451, left=539)
4304:             par_oPage.AddObject("lbl_4c_LbFVenda", "Label")
4305:             WITH par_oPage.lbl_4c_LbFVenda
4306:                 .Top = 451
4307:                 .Left = 539
4308:                 .Width = 86
4309:                 .Height = 15
4310:                 .FontName = "Tahoma"
4311:                 .FontSize = 8
4312:                 .BackStyle = 0
4313:                 .Caption = "Fator de Venda :"
4314:                 .Visible = .T.
4315:             ENDWITH
4316: 
4317:             *-- Label "Cod. Identidade :" (Say38, top=422+29=451, left=24)
4318:             par_oPage.AddObject("lbl_4c_LbCodIdent", "Label")
4319:             WITH par_oPage.lbl_4c_LbCodIdent
4320:                 .Top = 451
4321:                 .Left = 24
4322:                 .Width = 87
4323:                 .Height = 15
4324:                 .FontName = "Tahoma"
4325:                 .FontSize = 8
4326:                 .BackStyle = 0
4327:                 .Caption = "Cod. Identidade :"
4328:                 .Visible = .T.
4329:             ENDWITH
4330: 
4331:             *-- txt_4c_TEnts (getTEnts, tempo entrega, top=447+29=476, left=934, w=31)
4332:             par_oPage.AddObject("txt_4c_TEnts", "TextBox")
4333:             WITH par_oPage.txt_4c_TEnts
4334:                 .Top = 476
4335:                 .Left = 934
4336:                 .Width = 31
4337:                 .Height = 22
4338:                 .FontName = "Tahoma"
4339:                 .FontSize = 8
4340:                 .Themes = .F.
4341:                 .Visible = .T.
4342:             ENDWITH
4343: 
4344:             *-- Label "Descricao de : Compra ." (Say31, top=448+29=477, left=23, w=88, h=28)
4345:             par_oPage.AddObject("lbl_4c_LbDscComp", "Label")
4346:             WITH par_oPage.lbl_4c_LbDscComp
4347:                 .Top = 477
4348:                 .Left = 23
4349:                 .Width = 88
4350:                 .Height = 28
4351:                 .FontName = "Tahoma"
4352:                 .FontSize = 8
4353:                 .BackStyle = 0
4354:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o de : Compra ."
4355:                 .Visible = .T.
4356:             ENDWITH
4357: 
4358:             *-- edt_4c_DscCompras (getdsccompras, EditBox, top=448+29=477, left=113, w=400, h=58)
4359:             par_oPage.AddObject("edt_4c_DscCompras", "EditBox")
4360:             WITH par_oPage.edt_4c_DscCompras
4361:                 .Top = 477
4362:                 .Left = 113
4363:                 .Width = 400
4364:                 .Height = 58
4365:                 .FontName = "Tahoma"
4366:                 .FontSize = 8
4367:                 .ScrollBars = 2
4368:                 .Themes = .F.
4369:                 .Visible = .T.
4370:             ENDWITH
4371: 
4372:             *-- Label "Entrega :" (Label9, top=451+29=480, left=884)
4373:             par_oPage.AddObject("lbl_4c_LbEntrega", "Label")
4374:             WITH par_oPage.lbl_4c_LbEntrega
4375:                 .Top = 480
4376:                 .Left = 884
4377:                 .Width = 47
4378:                 .Height = 15
4379:                 .FontName = "Tahoma"
4380:                 .FontSize = 8
4381:                 .BackStyle = 0
4382:                 .Caption = "Entrega :"
4383:                 .Visible = .T.
4384:             ENDWITH
4385: 
4386:             *-- Label "Dias" (Label10, top=451+29=480, left=967)
4387:             par_oPage.AddObject("lbl_4c_LbDias2", "Label")
4388:             WITH par_oPage.lbl_4c_LbDias2
4389:                 .Top = 480
4390:                 .Left = 967
4391:                 .Width = 22
4392:                 .Height = 15
4393:                 .FontName = "Tahoma"
4394:                 .FontSize = 8
4395:                 .BackStyle = 0
4396:                 .Caption = "Dias"
4397:                 .Visible = .T.
4398:             ENDWITH
4399: 
4400:             *-- Label "Situacao :" (Say39, top=451+29=480, left=548)
4401:             par_oPage.AddObject("lbl_4c_LbSitComp", "Label")
4402:             WITH par_oPage.lbl_4c_LbSitComp
4403:                 .Top = 480
4404:                 .Left = 548
4405:                 .Width = 50
4406:                 .Height = 15
4407:                 .FontName = "Tahoma"
4408:                 .FontSize = 8
4409:                 .BackStyle = 0
4410:                 .Caption = "Situa" + CHR(231) + CHR(227) + "o :"
4411:                 .Visible = .T.
4412:             ENDWITH
4413: 
4414:             *-- chk_4c_Consig (get_Consig "Consigna", top=451+29=480, left=601)
4415:             par_oPage.AddObject("chk_4c_Consig", "CheckBox")
4416:             WITH par_oPage.chk_4c_Consig
4417:                 .Top = 480
4418:                 .Left = 601
4419:                 .Width = 75
4420:                 .Height = 17
4421:                 .Caption = "Consigna"
4422:                 .Value = 0
4423:                 .BackStyle = 0
4424:                 .FontName = "Tahoma"
4425:                 .FontSize = 8
4426:                 .Themes = .F.
4427:                 .Visible = .T.
4428:             ENDWITH
4429: 
4430:             *-- chk_4c_FabrProprs (chkFabrProprs "Fabr. Propria", top=451+29=480, left=681)
4431:             par_oPage.AddObject("chk_4c_FabrProprs", "CheckBox")
4432:             WITH par_oPage.chk_4c_FabrProprs
4433:                 .Top = 480
4434:                 .Left = 681
4435:                 .Width = 90
4436:                 .Height = 17
4437:                 .Caption = "Fabr. Pr" + CHR(243) + "pria"
4438:                 .Value = 0
4439:                 .BackStyle = 0
4440:                 .FontName = "Tahoma"
4441:                 .FontSize = 8
4442:                 .Themes = .F.
4443:                 .Visible = .T.
4444:             ENDWITH
4445: 
4446:             *-- chk_4c_Encoms (chkEncoms "Encomenda", top=451+29=480, left=781)
4447:             par_oPage.AddObject("chk_4c_Encoms", "CheckBox")
4448:             WITH par_oPage.chk_4c_Encoms
4449:                 .Top = 480
4450:                 .Left = 781
4451:                 .Width = 80
4452:                 .Height = 17
4453:                 .Caption = "Encomenda"
4454:                 .Value = 0
4455:                 .BackStyle = 0
4456:                 .FontName = "Tahoma"
4457:                 .FontSize = 8
4458:                 .Themes = .F.
4459:                 .Visible = .T.
4460:             ENDWITH
4461: 
4462:             *-- txt_4c_Fwget6 (fwget6, top=470+29=499, left=601, w=58)
4463:             par_oPage.AddObject("txt_4c_Fwget6", "TextBox")
4464:             WITH par_oPage.txt_4c_Fwget6
4465:                 .Top = 499
4466:                 .Left = 601
4467:                 .Width = 58
4468:                 .Height = 23
4469:                 .FontName = "Tahoma"
4470:                 .FontSize = 8
4471:                 .Themes = .F.
4472:                 .Visible = .T.
4473:             ENDWITH
4474: 
4475:             *-- txt_4c_Fwget5 (fwget5, top=470+29=499, left=688, w=58)
4476:             par_oPage.AddObject("txt_4c_Fwget5", "TextBox")
4477:             WITH par_oPage.txt_4c_Fwget5
4478:                 .Top = 499
4479:                 .Left = 688
4480:                 .Width = 58
4481:                 .Height = 23
4482:                 .FontName = "Tahoma"
4483:                 .FontSize = 8
4484:                 .Themes = .F.
4485:                 .Visible = .T.
4486:             ENDWITH
4487: 
4488:             *-- txt_4c_Fwget4 (fwget4, top=470+29=499, left=776, w=58)
4489:             par_oPage.AddObject("txt_4c_Fwget4", "TextBox")
4490:             WITH par_oPage.txt_4c_Fwget4
4491:                 .Top = 499
4492:                 .Left = 776
4493:                 .Width = 58
4494:                 .Height = 23
4495:                 .FontName = "Tahoma"
4496:                 .FontSize = 8
4497:                 .Themes = .F.
4498:                 .Visible = .T.
4499:             ENDWITH
4500: 
4501:             *-- txt_4c_Fwget3 (fwget3, top=470+29=499, left=934, w=31)
4502:             par_oPage.AddObject("txt_4c_Fwget3", "TextBox")
4503:             WITH par_oPage.txt_4c_Fwget3
4504:                 .Top = 499
4505:                 .Left = 934
4506:                 .Width = 31
4507:                 .Height = 23
4508:                 .FontName = "Tahoma"
4509:                 .FontSize = 8
4510:                 .Themes = .F.
4511:                 .Visible = .T.
4512:             ENDWITH
4513: 
4514:             *-- Label "Dimensao :" (Say27, top=474+29=503, left=543)
4515:             par_oPage.AddObject("lbl_4c_LbDim", "Label")
4516:             WITH par_oPage.lbl_4c_LbDim
4517:                 .Top = 503
4518:                 .Left = 543
4519:                 .Width = 55
4520:                 .Height = 15
4521:                 .FontName = "Tahoma"
4522:                 .FontSize = 8
4523:                 .BackStyle = 0
4524:                 .Caption = "Dimens" + CHR(227) + "o :"
4525:                 .Visible = .T.
4526:             ENDWITH
4527: 
4528:             *-- Label "Volumes :" (Say26, top=474+29=503, left=883)
4529:             par_oPage.AddObject("lbl_4c_LbVols", "Label")
4530:             WITH par_oPage.lbl_4c_LbVols
4531:                 .Top = 503
4532:                 .Left = 883
4533:                 .Width = 48
4534:                 .Height = 15
4535:                 .FontName = "Tahoma"
4536:                 .FontSize = 8
4537:                 .BackStyle = 0
4538:                 .Caption = "Volumes :"
4539:                 .Visible = .T.
4540:             ENDWITH
4541: 
4542:             *-- Label profundidade (lblProfundidade, top=474+29=503, left=661)
4543:             par_oPage.AddObject("lbl_4c_Profund", "Label")
4544:             WITH par_oPage.lbl_4c_Profund
4545:                 .Top = 503
4546:                 .Left = 661
4547:                 .Width = 20
4548:                 .Height = 15
4549:                 .FontName = "Tahoma"
4550:                 .FontSize = 8
4551:                 .BackStyle = 0
4552:                 .Caption = "Prf"
4553:                 .Visible = .T.
4554:             ENDWITH
4555: 
4556:             *-- Label altura header (lblAltura, top=474+29=503, left=749)
4557:             par_oPage.AddObject("lbl_4c_AlturaHdr", "Label")
4558:             WITH par_oPage.lbl_4c_AlturaHdr
4559:                 .Top = 503
4560:                 .Left = 749
4561:                 .Width = 20
4562:                 .Height = 15
4563:                 .FontName = "Tahoma"
4564:                 .FontSize = 8
4565:                 .BackStyle = 0
4566:                 .Caption = "Alt"
4567:                 .Visible = .T.
4568:             ENDWITH
4569: 
4570:             *-- Label comprimento header (lblComprimento, top=474+29=503, left=836)
4571:             par_oPage.AddObject("lbl_4c_ComprimHdr", "Label")
4572:             WITH par_oPage.lbl_4c_ComprimHdr
4573:                 .Top = 503
4574:                 .Left = 836
4575:                 .Width = 17
4576:                 .Height = 15
4577:                 .FontName = "Tahoma"
4578:                 .FontSize = 8
4579:                 .BackStyle = 0
4580:                 .Caption = "Cmp"
4581:                 .Visible = .T.
4582:             ENDWITH
4583: 
4584:             *-- cmd_4c_FigCam (cmdgFigCam, top=496+29=525, left=717, w=50, h=50)
4585:             par_oPage.AddObject("cmd_4c_FigCam", "CommandButton")
4586:             WITH par_oPage.cmd_4c_FigCam
4587:                 .Top = 525
4588:                 .Left = 717
4589:                 .Width = 50
4590:                 .Height = 50
4591:                 .Caption = "Cam"
4592:                 .FontName = "Tahoma"
4593:                 .FontSize = 8
4594:                 .Themes = .F.
4595:                 .Visible = .T.
4596:             ENDWITH
4597: 
4598:             *-- Label "Imagem Principal" (Say40, top=502+29=531, left=543)
4599:             par_oPage.AddObject("lbl_4c_LbImgPrinc", "Label")
4600:             WITH par_oPage.lbl_4c_LbImgPrinc
4601:                 .Top = 531
4602:                 .Left = 543
4603:                 .Width = 101
4604:                 .Height = 15
4605:                 .FontName = "Tahoma"
4606:                 .FontSize = 8
4607:                 .BackStyle = 0
4608:                 .Caption = "Imagem Principal"
4609:                 .Visible = .T.
4610:             ENDWITH
4611: 
4612:             *-- Label "Imagem Tecnica" (Say41, top=502+29=531, left=775)
4613:             par_oPage.AddObject("lbl_4c_LbImgTec", "Label")
4614:             WITH par_oPage.lbl_4c_LbImgTec
4615:                 .Top = 531
4616:                 .Left = 775
4617:                 .Width = 96
4618:                 .Height = 15
4619:                 .FontName = "Tahoma"
4620:                 .FontSize = 8
4621:                 .BackStyle = 0
4622:                 .Caption = "Imagem T" + CHR(233) + "cnica"
4623:                 .Visible = .T.
4624:             ENDWITH
4625: 
4626:             *-- Label "Descricao : Completa ." (Say33, top=507+29=536, left=23, w=88, h=28)
4627:             par_oPage.AddObject("lbl_4c_LbDscCompl", "Label")
4628:             WITH par_oPage.lbl_4c_LbDscCompl
4629:                 .Top = 536
4630:                 .Left = 23
4631:                 .Width = 88
4632:                 .Height = 28
4633:                 .FontName = "Tahoma"
4634:                 .FontSize = 8
4635:                 .BackStyle = 0
4636:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o : Completa ."
4637:                 .Visible = .T.
4638:             ENDWITH
4639: 
4640:             *-- edt_4c_DPro3s (getDPro3s, descricao completa EditBox, top=507+29=536, left=113, w=400, h=58)
4641:             par_oPage.AddObject("edt_4c_DPro3s", "EditBox")
4642:             WITH par_oPage.edt_4c_DPro3s
4643:                 .Top = 536
4644:                 .Left = 113
4645:                 .Width = 400
4646:                 .Height = 58
4647:                 .FontName = "Tahoma"
4648:                 .FontSize = 8
4649:                 .ScrollBars = 2
4650:                 .Themes = .F.
4651:                 .Visible = .T.
4652:             ENDWITH
4653: 
4654:             *-- img_4c_FigJpg (ImgFigJpg, imagem produto, top=521+29=550, left=544, w=172, h=101)
4655:             par_oPage.AddObject("img_4c_FigJpg", "Image")
4656:             WITH par_oPage.img_4c_FigJpg
4657:                 .Top = 550
4658:                 .Left = 544
4659:                 .Width = 172
4660:                 .Height = 101
4661:                 .Stretch = 2
4662:                 .Visible = .T.
4663:             ENDWITH
4664: 
4665:             *-- img_4c_FigTec (ImgFigTec, imagem tecnica, top=520+29=549, left=776, w=172, h=101)
4666:             par_oPage.AddObject("img_4c_FigTec", "Image")
4667:             WITH par_oPage.img_4c_FigTec
4668:                 .Top = 549
4669:                 .Left = 776
4670:                 .Width = 172
4671:                 .Height = 101
4672:                 .Stretch = 2
4673:                 .Visible = .T.
4674:             ENDWITH
4675: 
4676:             *-- cmd_4c_Zoom (cmdZoom, top=537+29=566, left=717, w=50, h=50)
4677:             par_oPage.AddObject("cmd_4c_Zoom", "CommandButton")
4678:             WITH par_oPage.cmd_4c_Zoom
4679:                 .Top = 566
4680:                 .Left = 717
4681:                 .Width = 50
4682:                 .Height = 50
4683:                 .Caption = "Zoom"
4684:                 .FontName = "Tahoma"
4685:                 .FontSize = 8
4686:                 .Themes = .F.
4687:                 .Visible = .T.
4688:             ENDWITH
4689: 
4690:             *-- cmd_4c_Cmdgroup2 (Commandgroup2, top=537+29=566, left=948, w=50, h=50)
4691:             par_oPage.AddObject("cmd_4c_Cmdgroup2", "CommandButton")
4692:             WITH par_oPage.cmd_4c_Cmdgroup2
4693:                 .Top = 566
4694:                 .Left = 948
4695:                 .Width = 50
4696:                 .Height = 50
4697:                 .Caption = ""
4698:                 .FontName = "Tahoma"
4699:                 .FontSize = 8
4700:                 .Themes = .F.
4701:                 .Visible = .T.
4702:             ENDWITH
4703: 
4704:             *-- Label "Observacao : da Compra ." (Say32, top=566+29=595, left=23, w=88, h=28)
4705:             par_oPage.AddObject("lbl_4c_LbObsComp", "Label")
4706:             WITH par_oPage.lbl_4c_LbObsComp
4707:                 .Top = 595
4708:                 .Left = 23
4709:                 .Width = 88
4710:                 .Height = 28
4711:                 .FontName = "Tahoma"
4712:                 .FontSize = 8
4713:                 .BackStyle = 0
4714:                 .Caption = "Observa" + CHR(231) + CHR(227) + "o : da Compra ."
4715:                 .Visible = .T.
4716:             ENDWITH
4717: 
4718:             *-- edt_4c_ObsCompras (getObsCompras, obs compra EditBox, top=566+29=595, left=113, w=400, h=58)
4719:             par_oPage.AddObject("edt_4c_ObsCompras", "EditBox")
4720:             WITH par_oPage.edt_4c_ObsCompras
4721:                 .Top = 595
4722:                 .Left = 113
4723:                 .Width = 400
4724:                 .Height = 58
4725:                 .FontName = "Tahoma"
4726:                 .FontSize = 8
4727:                 .ScrollBars = 2
4728:                 .Themes = .F.
4729:                 .Visible = .T.
4730:             ENDWITH
4731: 
4732:             *-- cmd_4c_Figura (cmdgFigura, top=578+29=607, left=717, w=50, h=50)
4733:             par_oPage.AddObject("cmd_4c_Figura", "CommandButton")
4734:             WITH par_oPage.cmd_4c_Figura
4735:                 .Top = 607
4736:                 .Left = 717
4737:                 .Width = 50
4738:                 .Height = 50
4739:                 .Caption = "Fig"
4740:                 .FontName = "Tahoma"
4741:                 .FontSize = 8
4742:                 .Themes = .F.
4743:                 .Visible = .T.
4744:             ENDWITH
4745: 
4746:             *-- cmd_4c_Cmdgroup1 (Commandgroup1, top=578+29=607, left=948, w=50, h=50)
4747:             par_oPage.AddObject("cmd_4c_Cmdgroup1", "CommandButton")
4748:             WITH par_oPage.cmd_4c_Cmdgroup1
4749:                 .Top = 607
4750:                 .Left = 948
4751:                 .Width = 50
4752:                 .Height = 50
4753:                 .Caption = ""
4754:                 .FontName = "Tahoma"
4755:                 .FontSize = 8
4756:                 .Themes = .F.
4757:                 .Visible = .T.
4758:             ENDWITH

*-- Linhas 5934 a 6023:
5934:             SET NULL OFF
5935: 
5936:             *-- === Obs. da OF (getObsOFs) - top=297+29=326 ===
5937:             par_oPage.AddObject("lbl_4c_LblObsOF", "Label")
5938:             WITH par_oPage.lbl_4c_LblObsOF
5939:                 .Top       = 329
5940:                 .Left      = 36
5941:                 .Width     = 64
5942:                 .Height    = 15
5943:                 .FontName  = "Tahoma"
5944:                 .FontSize  = 8
5945:                 .BackStyle = 0
5946:                 .Caption   = "<Obs. da OF :"
5947:                 .Visible   = .T.
5948:             ENDWITH
5949: 
5950:             par_oPage.AddObject("txt_4c_ObsOFs", "TextBox")
5951:             WITH par_oPage.txt_4c_ObsOFs
5952:                 .Top      = 326
5953:                 .Left     = 99
5954:                 .Width    = 850
5955:                 .Height   = 21
5956:                 .FontName = "Tahoma"
5957:                 .FontSize = 8
5958:                 .Themes   = .F.
5959:                 .Visible  = .T.
5960:             ENDWITH
5961: 
5962:             *-- === Descricao / Material Principal - top=321+29=350 ===
5963:             par_oPage.AddObject("lbl_4c_LblDesc", "Label")
5964:             WITH par_oPage.lbl_4c_LblDesc
5965:                 .Top       = 353
5966:                 .Left      = 45
5967:                 .Width     = 55
5968:                 .Height    = 15
5969:                 .FontName  = "Tahoma"
5970:                 .FontSize  = 8
5971:                 .BackStyle = 0
5972:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
5973:                 .Visible   = .T.
5974:             ENDWITH
5975: 
5976:             par_oPage.AddObject("txt_4c_Desc", "TextBox")
5977:             WITH par_oPage.txt_4c_Desc
5978:                 .Top      = 350
5979:                 .Left     = 99
5980:                 .Width    = 298
5981:                 .Height   = 21
5982:                 .FontName = "Tahoma"
5983:                 .FontSize = 8
5984:                 .ReadOnly = .T.
5985:                 .Themes   = .F.
5986:                 .Visible  = .T.
5987:             ENDWITH
5988: 
5989:             par_oPage.AddObject("lbl_4c_LblMatP", "Label")
5990:             WITH par_oPage.lbl_4c_LblMatP
5991:                 .Top       = 353
5992:                 .Left      = 421
5993:                 .Width     = 89
5994:                 .Height    = 15
5995:                 .FontName  = "Tahoma"
5996:                 .FontSize  = 8
5997:                 .BackStyle = 0
5998:                 .Caption   = "Material Principal :"
5999:                 .Visible   = .T.
6000:             ENDWITH
6001: 
6002:             par_oPage.AddObject("txt_4c_MatP", "TextBox")
6003:             WITH par_oPage.txt_4c_MatP
6004:                 .Top      = 350
6005:                 .Left     = 517
6006:                 .Width    = 108
6007:                 .Height   = 21
6008:                 .FontName = "Tahoma"
6009:                 .FontSize = 8
6010:                 .ReadOnly = .T.
6011:                 .Themes   = .F.
6012:                 .Visible  = .T.
6013:             ENDWITH
6014: 
6015:             *-- === GradeGRUPO (grupos composicao) - top=34+29=63 ===
6016:             par_oPage.AddObject("grd_4c_Grupo", "Grid")
6017:             par_oPage.grd_4c_Grupo.Top         = 63
6018:             par_oPage.grd_4c_Grupo.Left        = 582
6019:             par_oPage.grd_4c_Grupo.Width       = 229
6020:             par_oPage.grd_4c_Grupo.Height      = 107
6021:             par_oPage.grd_4c_Grupo.ColumnCount = 3
6022:             par_oPage.grd_4c_Grupo.FontName    = "Tahoma"
6023:             par_oPage.grd_4c_Grupo.FontSize    = 8

*-- Linhas 6031 a 6057:
6031: 
6032:             par_oPage.grd_4c_Grupo.RecordSource = "cursor_4c_GrupoCompo"
6033: 
6034:             par_oPage.grd_4c_Grupo.Column1.Header1.Caption  = "Grupo"
6035:             par_oPage.grd_4c_Grupo.Column1.ControlSource    = "cursor_4c_GrupoCompo.CGrus"
6036:             par_oPage.grd_4c_Grupo.Column1.Width            = 60
6037:             par_oPage.grd_4c_Grupo.Column1.Header1.FontBold = .T.
6038: 
6039:             par_oPage.grd_4c_Grupo.Column2.Header1.Caption  = "Total"
6040:             par_oPage.grd_4c_Grupo.Column2.ControlSource    = "cursor_4c_GrupoCompo.Totals"
6041:             par_oPage.grd_4c_Grupo.Column2.Width            = 90
6042:             par_oPage.grd_4c_Grupo.Column2.Header1.FontBold = .T.
6043: 
6044:             par_oPage.grd_4c_Grupo.Column3.Header1.Caption  = "Moeda"
6045:             par_oPage.grd_4c_Grupo.Column3.ControlSource    = "cursor_4c_GrupoCompo.Moedas"
6046:             par_oPage.grd_4c_Grupo.Column3.Width            = 65
6047:             par_oPage.grd_4c_Grupo.Column3.Header1.FontBold = .T.
6048: 
6049:             *-- === grdCompo (composicao principal) - top=148+29=177 ===
6050:             par_oPage.AddObject("grd_4c_Compo", "Grid")
6051:             par_oPage.grd_4c_Compo.Top         = 177
6052:             par_oPage.grd_4c_Compo.Left        = 6
6053:             par_oPage.grd_4c_Compo.Width       = 943
6054:             par_oPage.grd_4c_Compo.Height      = 147
6055:             par_oPage.grd_4c_Compo.ColumnCount = 14
6056:             par_oPage.grd_4c_Compo.FontName    = "Tahoma"
6057:             par_oPage.grd_4c_Compo.FontSize    = 8

*-- Linhas 6065 a 6268:
6065: 
6066:             par_oPage.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
6067: 
6068:             par_oPage.grd_4c_Compo.Column1.Header1.Caption  = "Material"
6069:             par_oPage.grd_4c_Compo.Column1.ControlSource    = "cursor_4c_Compo.Mats"
6070:             par_oPage.grd_4c_Compo.Column1.Width            = 80
6071:             par_oPage.grd_4c_Compo.Column1.Header1.FontBold = .T.
6072: 
6073:             par_oPage.grd_4c_Compo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6074:             par_oPage.grd_4c_Compo.Column2.ControlSource    = "cursor_4c_Compo.DPros"
6075:             par_oPage.grd_4c_Compo.Column2.Width            = 155
6076:             par_oPage.grd_4c_Compo.Column2.Header1.FontBold = .T.
6077: 
6078:             par_oPage.grd_4c_Compo.Column3.Header1.Caption  = "Un"
6079:             par_oPage.grd_4c_Compo.Column3.ControlSource    = "cursor_4c_Compo.Unisp"
6080:             par_oPage.grd_4c_Compo.Column3.Width            = 35
6081:             par_oPage.grd_4c_Compo.Column3.Header1.FontBold = .T.
6082: 
6083:             par_oPage.grd_4c_Compo.Column4.Header1.Caption  = "Valor"
6084:             par_oPage.grd_4c_Compo.Column4.ControlSource    = "cursor_4c_Compo.Vals"
6085:             par_oPage.grd_4c_Compo.Column4.Width            = 75
6086:             par_oPage.grd_4c_Compo.Column4.Header1.FontBold = .T.
6087: 
6088:             par_oPage.grd_4c_Compo.Column5.Header1.Caption  = "Qtde."
6089:             par_oPage.grd_4c_Compo.Column5.ControlSource    = "cursor_4c_Compo.Qtds"
6090:             par_oPage.grd_4c_Compo.Column5.Width            = 65
6091:             par_oPage.grd_4c_Compo.Column5.Header1.FontBold = .T.
6092: 
6093:             par_oPage.grd_4c_Compo.Column6.Header1.Caption  = "Total"
6094:             par_oPage.grd_4c_Compo.Column6.ControlSource    = "cursor_4c_Compo.Totals"
6095:             par_oPage.grd_4c_Compo.Column6.Width            = 75
6096:             par_oPage.grd_4c_Compo.Column6.Header1.FontBold = .T.
6097: 
6098:             par_oPage.grd_4c_Compo.Column7.Header1.Caption  = "Moe"
6099:             par_oPage.grd_4c_Compo.Column7.ControlSource    = "cursor_4c_Compo.Moedas"
6100:             par_oPage.grd_4c_Compo.Column7.Width            = 35
6101:             par_oPage.grd_4c_Compo.Column7.Header1.FontBold = .T.
6102: 
6103:             par_oPage.grd_4c_Compo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6104:             par_oPage.grd_4c_Compo.Column8.ControlSource    = "cursor_4c_Compo.Obss"
6105:             par_oPage.grd_4c_Compo.Column8.Width            = 100
6106:             par_oPage.grd_4c_Compo.Column8.Header1.FontBold = .T.
6107: 
6108:             par_oPage.grd_4c_Compo.Column9.Header1.Caption  = "E"
6109:             par_oPage.grd_4c_Compo.Column9.ControlSource    = "cursor_4c_Compo.Es"
6110:             par_oPage.grd_4c_Compo.Column9.Width            = 25
6111:             par_oPage.grd_4c_Compo.Column9.Header1.FontBold = .T.
6112: 
6113:             par_oPage.grd_4c_Compo.Column10.Header1.Caption  = "Consumo"
6114:             par_oPage.grd_4c_Compo.Column10.ControlSource    = "cursor_4c_Compo.Conss"
6115:             par_oPage.grd_4c_Compo.Column10.Width            = 65
6116:             par_oPage.grd_4c_Compo.Column10.Header1.FontBold = .T.
6117: 
6118:             par_oPage.grd_4c_Compo.Column11.Header1.Caption  = "Qtde."
6119:             par_oPage.grd_4c_Compo.Column11.ControlSource    = "cursor_4c_Compo.Qtdss"
6120:             par_oPage.grd_4c_Compo.Column11.Width            = 65
6121:             par_oPage.grd_4c_Compo.Column11.Header1.FontBold = .T.
6122: 
6123:             par_oPage.grd_4c_Compo.Column12.Header1.Caption  = "Un"
6124:             par_oPage.grd_4c_Compo.Column12.ControlSource    = "cursor_4c_Compo.Unis"
6125:             par_oPage.grd_4c_Compo.Column12.Width            = 35
6126:             par_oPage.grd_4c_Compo.Column12.Header1.FontBold = .T.
6127: 
6128:             par_oPage.grd_4c_Compo.Column13.Header1.Caption  = "Ord"
6129:             par_oPage.grd_4c_Compo.Column13.ControlSource    = "cursor_4c_Compo.Ords"
6130:             par_oPage.grd_4c_Compo.Column13.Width            = 35
6131:             par_oPage.grd_4c_Compo.Column13.Header1.FontBold = .T.
6132: 
6133:             par_oPage.grd_4c_Compo.Column14.Header1.Caption  = "Matriz"
6134:             par_oPage.grd_4c_Compo.Column14.ControlSource    = "cursor_4c_Compo.Bloqueio"
6135:             par_oPage.grd_4c_Compo.Column14.Width            = 90
6136:             par_oPage.grd_4c_Compo.Column14.Header1.FontBold = .T.
6137: 
6138:             *-- === cmdgCompo (CommandGroup 5 botoes) - top=145+29=174 ===
6139:             par_oPage.AddObject("cmdg_4c_Compo", "CommandGroup")
6140:             WITH par_oPage.cmdg_4c_Compo
6141:                 .Top         = 174
6142:                 .Left        = 947
6143:                 .Width       = 50
6144:                 .Height      = 210
6145:                 .ButtonCount = 5
6146:                 .Themes      = .F.
6147:                 .Visible     = .T.
6148:             ENDWITH
6149: 
6150:             WITH par_oPage.cmdg_4c_Compo.Buttons(1)
6151:                 .Caption  = "+"
6152:                 .Top      = 0
6153:                 .Left     = 0
6154:                 .Width    = 50
6155:                 .Height   = 40
6156:                 .FontName = "Tahoma"
6157:                 .FontSize = 10
6158:                 .FontBold = .T.
6159:                 .Themes   = .F.
6160:             ENDWITH
6161: 
6162:             WITH par_oPage.cmdg_4c_Compo.Buttons(2)
6163:                 .Caption  = "-"
6164:                 .Top      = 42
6165:                 .Left     = 0
6166:                 .Width    = 50
6167:                 .Height   = 40
6168:                 .FontName = "Tahoma"
6169:                 .FontSize = 10
6170:                 .FontBold = .T.
6171:                 .Themes   = .F.
6172:             ENDWITH
6173: 
6174:             WITH par_oPage.cmdg_4c_Compo.Buttons(3)
6175:                 .Caption  = "Atualiza"
6176:                 .Top      = 84
6177:                 .Left     = 0
6178:                 .Width    = 50
6179:                 .Height   = 40
6180:                 .FontName = "Tahoma"
6181:                 .FontSize = 7
6182:                 .Themes   = .F.
6183:             ENDWITH
6184: 
6185:             WITH par_oPage.cmdg_4c_Compo.Buttons(4)
6186:                 .Caption  = "Copiar"
6187:                 .Top      = 126
6188:                 .Left     = 0
6189:                 .Width    = 50
6190:                 .Height   = 40
6191:                 .FontName = "Tahoma"
6192:                 .FontSize = 7
6193:                 .Themes   = .F.
6194:             ENDWITH
6195: 
6196:             WITH par_oPage.cmdg_4c_Compo.Buttons(5)
6197:                 .Caption  = "Grupo"
6198:                 .Top      = 168
6199:                 .Left     = 0
6200:                 .Width    = 50
6201:                 .Height   = 40
6202:                 .FontName = "Tahoma"
6203:                 .FontSize = 7
6204:                 .Themes   = .F.
6205:             ENDWITH
6206: 
6207:             *-- === Substitucao: labels + campos - top=435+29=464 ===
6208:             par_oPage.AddObject("lbl_4c_LblDescCp", "Label")
6209:             WITH par_oPage.lbl_4c_LblDescCp
6210:                 .Top       = 464
6211:                 .Left      = 39
6212:                 .Width     = 55
6213:                 .Height    = 15
6214:                 .FontName  = "Tahoma"
6215:                 .FontSize  = 8
6216:                 .BackStyle = 0
6217:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
6218:                 .Visible   = .T.
6219:             ENDWITH
6220: 
6221:             par_oPage.AddObject("txt_4c_Desccp", "TextBox")
6222:             WITH par_oPage.txt_4c_Desccp
6223:                 .Top      = 461
6224:                 .Left     = 99
6225:                 .Width    = 298
6226:                 .Height   = 21
6227:                 .FontName = "Tahoma"
6228:                 .FontSize = 8
6229:                 .ReadOnly = .T.
6230:                 .Themes   = .F.
6231:                 .Visible  = .T.
6232:             ENDWITH
6233: 
6234:             par_oPage.AddObject("lbl_4c_LblSubstitui", "Label")
6235:             WITH par_oPage.lbl_4c_LblSubstitui
6236:                 .Top       = 464
6237:                 .Left      = 465
6238:                 .Width     = 50
6239:                 .Height    = 15
6240:                 .FontName  = "Tahoma"
6241:                 .FontSize  = 8
6242:                 .BackStyle = 0
6243:                 .Caption   = "Substitui :"
6244:                 .Visible   = .T.
6245:             ENDWITH
6246: 
6247:             par_oPage.AddObject("txt_4c_Matsub", "TextBox")
6248:             WITH par_oPage.txt_4c_Matsub
6249:                 .Top      = 461
6250:                 .Left     = 517
6251:                 .Width    = 108
6252:                 .Height   = 21
6253:                 .FontName = "Tahoma"
6254:                 .FontSize = 8
6255:                 .ReadOnly = .T.
6256:                 .Themes   = .F.
6257:                 .Visible  = .T.
6258:             ENDWITH
6259: 
6260:             *-- === grdsubcp (grid substitutos) - top=348+29=377 ===
6261:             par_oPage.AddObject("grd_4c_SubCp", "Grid")
6262:             par_oPage.grd_4c_SubCp.Top         = 377
6263:             par_oPage.grd_4c_SubCp.Left        = 6
6264:             par_oPage.grd_4c_SubCp.Width       = 943
6265:             par_oPage.grd_4c_SubCp.Height      = 83
6266:             par_oPage.grd_4c_SubCp.ColumnCount = 15
6267:             par_oPage.grd_4c_SubCp.FontName    = "Tahoma"
6268:             par_oPage.grd_4c_SubCp.FontSize    = 8

*-- Linhas 6276 a 7259:
6276: 
6277:             par_oPage.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
6278: 
6279:             par_oPage.grd_4c_SubCp.Column1.Header1.Caption  = "Material"
6280:             par_oPage.grd_4c_SubCp.Column1.ControlSource    = "cursor_4c_SubCp.Mats"
6281:             par_oPage.grd_4c_SubCp.Column1.Width            = 80
6282:             par_oPage.grd_4c_SubCp.Column1.Header1.FontBold = .T.
6283: 
6284:             par_oPage.grd_4c_SubCp.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6285:             par_oPage.grd_4c_SubCp.Column2.ControlSource    = "cursor_4c_SubCp.DPros"
6286:             par_oPage.grd_4c_SubCp.Column2.Width            = 140
6287:             par_oPage.grd_4c_SubCp.Column2.Header1.FontBold = .T.
6288: 
6289:             par_oPage.grd_4c_SubCp.Column3.Header1.Caption  = "Un"
6290:             par_oPage.grd_4c_SubCp.Column3.ControlSource    = "cursor_4c_SubCp.Unisp"
6291:             par_oPage.grd_4c_SubCp.Column3.Width            = 30
6292:             par_oPage.grd_4c_SubCp.Column3.Header1.FontBold = .T.
6293: 
6294:             par_oPage.grd_4c_SubCp.Column4.Header1.Caption  = "Valor"
6295:             par_oPage.grd_4c_SubCp.Column4.ControlSource    = "cursor_4c_SubCp.Vals"
6296:             par_oPage.grd_4c_SubCp.Column4.Width            = 65
6297:             par_oPage.grd_4c_SubCp.Column4.Header1.FontBold = .T.
6298: 
6299:             par_oPage.grd_4c_SubCp.Column5.Header1.Caption  = "Qtde."
6300:             par_oPage.grd_4c_SubCp.Column5.ControlSource    = "cursor_4c_SubCp.Qtds"
6301:             par_oPage.grd_4c_SubCp.Column5.Width            = 60
6302:             par_oPage.grd_4c_SubCp.Column5.Header1.FontBold = .T.
6303: 
6304:             par_oPage.grd_4c_SubCp.Column6.Header1.Caption  = "Total"
6305:             par_oPage.grd_4c_SubCp.Column6.ControlSource    = "cursor_4c_SubCp.Totals"
6306:             par_oPage.grd_4c_SubCp.Column6.Width            = 65
6307:             par_oPage.grd_4c_SubCp.Column6.Header1.FontBold = .T.
6308: 
6309:             par_oPage.grd_4c_SubCp.Column7.Header1.Caption  = "Moe"
6310:             par_oPage.grd_4c_SubCp.Column7.ControlSource    = "cursor_4c_SubCp.Moedas"
6311:             par_oPage.grd_4c_SubCp.Column7.Width            = 30
6312:             par_oPage.grd_4c_SubCp.Column7.Header1.FontBold = .T.
6313: 
6314:             par_oPage.grd_4c_SubCp.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6315:             par_oPage.grd_4c_SubCp.Column8.ControlSource    = "cursor_4c_SubCp.Obss"
6316:             par_oPage.grd_4c_SubCp.Column8.Width            = 90
6317:             par_oPage.grd_4c_SubCp.Column8.Header1.FontBold = .T.
6318: 
6319:             par_oPage.grd_4c_SubCp.Column9.Header1.Caption  = "E"
6320:             par_oPage.grd_4c_SubCp.Column9.ControlSource    = "cursor_4c_SubCp.Es"
6321:             par_oPage.grd_4c_SubCp.Column9.Width            = 20
6322:             par_oPage.grd_4c_SubCp.Column9.Header1.FontBold = .T.
6323: 
6324:             par_oPage.grd_4c_SubCp.Column10.Header1.Caption  = "Consumo"
6325:             par_oPage.grd_4c_SubCp.Column10.ControlSource    = "cursor_4c_SubCp.Conss"
6326:             par_oPage.grd_4c_SubCp.Column10.Width            = 60
6327:             par_oPage.grd_4c_SubCp.Column10.Header1.FontBold = .T.
6328: 
6329:             par_oPage.grd_4c_SubCp.Column11.Header1.Caption  = "Qtde."
6330:             par_oPage.grd_4c_SubCp.Column11.ControlSource    = "cursor_4c_SubCp.Qtdss"
6331:             par_oPage.grd_4c_SubCp.Column11.Width            = 60
6332:             par_oPage.grd_4c_SubCp.Column11.Header1.FontBold = .T.
6333: 
6334:             par_oPage.grd_4c_SubCp.Column12.Header1.Caption  = "Un"
6335:             par_oPage.grd_4c_SubCp.Column12.ControlSource    = "cursor_4c_SubCp.Unis"
6336:             par_oPage.grd_4c_SubCp.Column12.Width            = 30
6337:             par_oPage.grd_4c_SubCp.Column12.Header1.FontBold = .T.
6338: 
6339:             par_oPage.grd_4c_SubCp.Column13.Header1.Caption  = "Ord"
6340:             par_oPage.grd_4c_SubCp.Column13.ControlSource    = "cursor_4c_SubCp.Ords"
6341:             par_oPage.grd_4c_SubCp.Column13.Width            = 30
6342:             par_oPage.grd_4c_SubCp.Column13.Header1.FontBold = .T.
6343: 
6344:             par_oPage.grd_4c_SubCp.Column14.Header1.Caption  = "Matriz"
6345:             par_oPage.grd_4c_SubCp.Column14.ControlSource    = "cursor_4c_SubCp.Bloqueio"
6346:             par_oPage.grd_4c_SubCp.Column14.Width            = 75
6347:             par_oPage.grd_4c_SubCp.Column14.Header1.FontBold = .T.
6348: 
6349:             par_oPage.grd_4c_SubCp.Column15.Header1.Caption  = "Tam"
6350:             par_oPage.grd_4c_SubCp.Column15.ControlSource    = "cursor_4c_SubCp.Tams"
6351:             par_oPage.grd_4c_SubCp.Column15.Width            = 55
6352:             par_oPage.grd_4c_SubCp.Column15.Header1.FontBold = .T.
6353: 
6354:             *-- === cmdgSubCp (CommandGroup 2 botoes) - top=345+29=374 ===
6355:             par_oPage.AddObject("cmdg_4c_SubCp", "CommandGroup")
6356:             WITH par_oPage.cmdg_4c_SubCp
6357:                 .Top         = 374
6358:                 .Left        = 947
6359:                 .Width       = 50
6360:                 .Height      = 90
6361:                 .ButtonCount = 2
6362:                 .Themes      = .F.
6363:                 .Visible     = .T.
6364:             ENDWITH
6365: 
6366:             WITH par_oPage.cmdg_4c_SubCp.Buttons(1)
6367:                 .Caption  = "+"
6368:                 .Top      = 0
6369:                 .Left     = 0
6370:                 .Width    = 50
6371:                 .Height   = 40
6372:                 .FontName = "Tahoma"
6373:                 .FontSize = 10
6374:                 .FontBold = .T.
6375:                 .Themes   = .F.
6376:             ENDWITH
6377: 
6378:             WITH par_oPage.cmdg_4c_SubCp.Buttons(2)
6379:                 .Caption  = "-"
6380:                 .Top      = 42
6381:                 .Left     = 0
6382:                 .Width    = 50
6383:                 .Height   = 40
6384:                 .FontName = "Tahoma"
6385:                 .FontSize = 10
6386:                 .FontBold = .T.
6387:                 .Themes   = .F.
6388:             ENDWITH
6389: 
6390:             *-- === cntMtPrima container - top=511+29=540 ===
6391:             par_oPage.AddObject("cnt_4c_MtPrima", "Container")
6392:             WITH par_oPage.cnt_4c_MtPrima
6393:                 .Top         = 540
6394:                 .Left        = 752
6395:                 .Width       = 242
6396:                 .Height      = 108
6397:                 .BackStyle   = 1
6398:                 .BackColor   = RGB(240,240,240)
6399:                 .BorderStyle = 1
6400:                 .Visible     = .T.
6401:             ENDWITH
6402: 
6403:             par_oPage.cnt_4c_MtPrima.AddObject("lbl_4c_LblCompos", "Label")
6404:             WITH par_oPage.cnt_4c_MtPrima.lbl_4c_LblCompos
6405:                 .Top       = 1
6406:                 .Left      = 6
6407:                 .Width     = 66
6408:                 .Height    = 15
6409:                 .FontName  = "Tahoma"
6410:                 .FontSize  = 8
6411:                 .BackStyle = 0
6412:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
6413:                 .Visible   = .T.
6414:             ENDWITH
6415: 
6416:             par_oPage.cnt_4c_MtPrima.AddObject("txt_4c_Compos", "TextBox")
6417:             WITH par_oPage.cnt_4c_MtPrima.txt_4c_Compos
6418:                 .Top      = 18
6419:                 .Left     = 6
6420:                 .Width    = 233
6421:                 .Height   = 23
6422:                 .FontName = "Tahoma"
6423:                 .FontSize = 8
6424:                 .Themes   = .F.
6425:                 .Visible  = .T.
6426:             ENDWITH
6427: 
6428:             par_oPage.cnt_4c_MtPrima.AddObject("lbl_4c_LblMontaDescs", "Label")
6429:             WITH par_oPage.cnt_4c_MtPrima.lbl_4c_LblMontaDescs
6430:                 .Top       = 42
6431:                 .Left      = 6
6432:                 .Width     = 59
6433:                 .Height    = 15
6434:                 .FontName  = "Tahoma"
6435:                 .FontSize  = 8
6436:                 .BackStyle = 0
6437:                 .Caption   = "Montagem :"
6438:                 .Visible   = .T.
6439:             ENDWITH
6440: 
6441:             par_oPage.cnt_4c_MtPrima.AddObject("cmb_4c_MontaDescs", "ComboBox")
6442:             WITH par_oPage.cnt_4c_MtPrima.cmb_4c_MontaDescs
6443:                 .Top      = 59
6444:                 .Left     = 6
6445:                 .Width    = 233
6446:                 .Height   = 23
6447:                 .FontName = "Tahoma"
6448:                 .FontSize = 8
6449:                 .Themes   = .F.
6450:                 .Visible  = .T.
6451:             ENDWITH
6452: 
6453:             par_oPage.cnt_4c_MtPrima.AddObject("lbl_4c_LblDigiMaxs", "Label")
6454:             WITH par_oPage.cnt_4c_MtPrima.lbl_4c_LblDigiMaxs
6455:                 .Top       = 88
6456:                 .Left      = 4
6457:                 .Width     = 41
6458:                 .Height    = 15
6459:                 .FontName  = "Tahoma"
6460:                 .FontSize  = 8
6461:                 .BackStyle = 0
6462:                 .Caption   = "Digitos :"
6463:                 .Visible   = .T.
6464:             ENDWITH
6465: 
6466:             par_oPage.cnt_4c_MtPrima.AddObject("txt_4c_DigiMaxs", "TextBox")
6467:             WITH par_oPage.cnt_4c_MtPrima.txt_4c_DigiMaxs
6468:                 .Top      = 84
6469:                 .Left     = 54
6470:                 .Width    = 25
6471:                 .Height   = 20
6472:                 .FontName = "Tahoma"
6473:                 .FontSize = 8
6474:                 .Themes   = .F.
6475:                 .Visible  = .T.
6476:             ENDWITH
6477: 
6478:             par_oPage.cnt_4c_MtPrima.AddObject("lbl_4c_LblOrdCompos", "Label")
6479:             WITH par_oPage.cnt_4c_MtPrima.lbl_4c_LblOrdCompos
6480:                 .Top       = 88
6481:                 .Left      = 85
6482:                 .Width     = 41
6483:                 .Height    = 15
6484:                 .FontName  = "Tahoma"
6485:                 .FontSize  = 8
6486:                 .BackStyle = 0
6487:                 .Caption   = "Ordem :"
6488:                 .Visible   = .T.
6489:             ENDWITH
6490: 
6491:             par_oPage.cnt_4c_MtPrima.AddObject("txt_4c_OrdCompos", "TextBox")
6492:             WITH par_oPage.cnt_4c_MtPrima.txt_4c_OrdCompos
6493:                 .Top      = 84
6494:                 .Left     = 136
6495:                 .Width    = 25
6496:                 .Height   = 20
6497:                 .FontName = "Tahoma"
6498:                 .FontSize = 8
6499:                 .Themes   = .F.
6500:                 .Visible  = .T.
6501:             ENDWITH
6502: 
6503:             par_oPage.cnt_4c_MtPrima.AddObject("lbl_4c_LblCasas", "Label")
6504:             WITH par_oPage.cnt_4c_MtPrima.lbl_4c_LblCasas
6505:                 .Top       = 88
6506:                 .Left      = 165
6507:                 .Width     = 38
6508:                 .Height    = 15
6509:                 .FontName  = "Tahoma"
6510:                 .FontSize  = 8
6511:                 .BackStyle = 0
6512:                 .Caption   = "Casas :"
6513:                 .Visible   = .T.
6514:             ENDWITH
6515: 
6516:             par_oPage.cnt_4c_MtPrima.AddObject("txt_4c_Casas", "TextBox")
6517:             WITH par_oPage.cnt_4c_MtPrima.txt_4c_Casas
6518:                 .Top      = 84
6519:                 .Left     = 213
6520:                 .Width    = 25
6521:                 .Height   = 20
6522:                 .FontName = "Tahoma"
6523:                 .FontSize = 8
6524:                 .Themes   = .F.
6525:                 .Visible  = .T.
6526:             ENDWITH
6527: 
6528:             *-- === SECAO CUSTO ===
6529:             *-- Separador "Custo" Say1 - top=473+29=502
6530:             par_oPage.AddObject("lbl_4c_LblCusto", "Label")
6531:             WITH par_oPage.lbl_4c_LblCusto
6532:                 .Top       = 502
6533:                 .Left      = 47
6534:                 .Width     = 46
6535:                 .Height    = 16
6536:                 .FontName  = "Tahoma"
6537:                 .FontSize  = 8
6538:                 .BackStyle = 0
6539:                 .Caption   = " Custo "
6540:                 .Visible   = .T.
6541:             ENDWITH
6542: 
6543:             *-- Shape6 top=497+29=526
6544:             par_oPage.AddObject("shp_4c_Shape6", "Shape")
6545:             WITH par_oPage.shp_4c_Shape6
6546:                 .Top         = 526
6547:                 .Left        = 9
6548:                 .Width       = 158
6549:                 .Height      = 2
6550:                 .BackColor   = RGB(128,128,128)
6551:                 .BorderColor = RGB(128,128,128)
6552:                 .Visible     = .T.
6553:             ENDWITH
6554: 
6555:             *-- chkLiberaCusto - top=458+29=487
6556:             par_oPage.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
6557:             WITH par_oPage.chk_4c_ChkLiberaCusto
6558:                 .Top      = 487
6559:                 .Left     = 9
6560:                 .Width    = 39
6561:                 .Height   = 38
6562:                 .FontName = "Tahoma"
6563:                 .FontSize = 8
6564:                 .Value    = 0
6565:                 .Themes   = .F.
6566:                 .Visible  = .T.
6567:             ENDWITH
6568: 
6569:             *-- lblCompra - top=502+29=531
6570:             par_oPage.AddObject("lbl_4c_LblCompra", "Label")
6571:             WITH par_oPage.lbl_4c_LblCompra
6572:                 .Top       = 531
6573:                 .Left      = 9
6574:                 .Width     = 127
6575:                 .Height    = 15
6576:                 .FontName  = "Tahoma"
6577:                 .FontSize  = 8
6578:                 .BackStyle = 0
6579:                 .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
6580:                 .Visible   = .T.
6581:             ENDWITH
6582: 
6583:             *-- getMoec - top=517+29=546
6584:             par_oPage.AddObject("txt_4c_Moec", "TextBox")
6585:             WITH par_oPage.txt_4c_Moec
6586:                 .Top      = 546
6587:                 .Left     = 127
6588:                 .Width    = 31
6589:                 .Height   = 23
6590:                 .FontName = "Tahoma"
6591:                 .FontSize = 8
6592:                 .Themes   = .F.
6593:                 .Visible  = .T.
6594:             ENDWITH
6595: 
6596:             *-- getPcus - top=517+29=546
6597:             par_oPage.AddObject("txt_4c_Pcus", "TextBox")
6598:             WITH par_oPage.txt_4c_Pcus
6599:                 .Top      = 546
6600:                 .Left     = 9
6601:                 .Width    = 115
6602:                 .Height   = 23
6603:                 .FontName = "Tahoma"
6604:                 .FontSize = 8
6605:                 .Themes   = .F.
6606:                 .Visible  = .T.
6607:             ENDWITH
6608: 
6609:             *-- lblCuVda - top=502+29=531
6610:             par_oPage.AddObject("lbl_4c_LblCuVda", "Label")
6611:             WITH par_oPage.lbl_4c_LblCuVda
6612:                 .Top       = 531
6613:                 .Left      = 161
6614:                 .Width     = 126
6615:                 .Height    = 15
6616:                 .FontName  = "Tahoma"
6617:                 .FontSize  = 8
6618:                 .BackStyle = 0
6619:                 .Caption   = "Fator de Custo (Moeda 2)"
6620:                 .Visible   = .T.
6621:             ENDWITH
6622: 
6623:             *-- getMoepc - top=517+29=546
6624:             par_oPage.AddObject("txt_4c_Moepc", "TextBox")
6625:             WITH par_oPage.txt_4c_Moepc
6626:                 .Top      = 546
6627:                 .Left     = 279
6628:                 .Width    = 31
6629:                 .Height   = 23
6630:                 .FontName = "Tahoma"
6631:                 .FontSize = 8
6632:                 .Themes   = .F.
6633:                 .Visible  = .T.
6634:             ENDWITH
6635: 
6636:             *-- getFcusto - top=517+29=546
6637:             par_oPage.AddObject("txt_4c_FcustoC", "TextBox")
6638:             WITH par_oPage.txt_4c_FcustoC
6639:                 .Top      = 546
6640:                 .Left     = 161
6641:                 .Width    = 115
6642:                 .Height   = 23
6643:                 .FontName = "Tahoma"
6644:                 .FontSize = 8
6645:                 .Themes   = .F.
6646:                 .Visible  = .T.
6647:             ENDWITH
6648: 
6649:             *-- Say8 "Total " - top=542+29=571
6650:             par_oPage.AddObject("lbl_4c_LblTotalCusto", "Label")
6651:             WITH par_oPage.lbl_4c_LblTotalCusto
6652:                 .Top       = 571
6653:                 .Left      = 161
6654:                 .Width     = 29
6655:                 .Height    = 15
6656:                 .FontName  = "Tahoma"
6657:                 .FontSize  = 8
6658:                 .BackStyle = 0
6659:                 .Caption   = "Total "
6660:                 .Visible   = .T.
6661:             ENDWITH
6662: 
6663:             *-- getMoecusf - top=557+29=586
6664:             par_oPage.AddObject("txt_4c_Moecusf", "TextBox")
6665:             WITH par_oPage.txt_4c_Moecusf
6666:                 .Top      = 586
6667:                 .Left     = 279
6668:                 .Width    = 31
6669:                 .Height   = 23
6670:                 .FontName = "Tahoma"
6671:                 .FontSize = 8
6672:                 .Themes   = .F.
6673:                 .Visible  = .T.
6674:             ENDWITH
6675: 
6676:             *-- getCustof (total custo moeda) - top=557+29=586
6677:             par_oPage.AddObject("txt_4c_CustofC", "TextBox")
6678:             WITH par_oPage.txt_4c_CustofC
6679:                 .Top      = 586
6680:                 .Left     = 161
6681:                 .Width    = 115
6682:                 .Height   = 23
6683:                 .FontName = "Tahoma"
6684:                 .FontSize = 8
6685:                 .ReadOnly = .T.
6686:                 .Themes   = .F.
6687:                 .Visible  = .T.
6688:             ENDWITH
6689: 
6690:             *-- Say22 "MKP" - top=542+29=571
6691:             par_oPage.AddObject("lbl_4c_LblMkpCusto", "Label")
6692:             WITH par_oPage.lbl_4c_LblMkpCusto
6693:                 .Top       = 571
6694:                 .Left      = 9
6695:                 .Width     = 22
6696:                 .Height    = 15
6697:                 .FontName  = "Tahoma"
6698:                 .FontSize  = 8
6699:                 .BackStyle = 0
6700:                 .Caption   = "MKP"
6701:                 .Visible   = .T.
6702:             ENDWITH
6703: 
6704:             *-- Get_cmkpc - top=557+29=586
6705:             par_oPage.AddObject("txt_4c_Cmkpc", "TextBox")
6706:             WITH par_oPage.txt_4c_Cmkpc
6707:                 .Top      = 586
6708:                 .Left     = 9
6709:                 .Width    = 24
6710:                 .Height   = 23
6711:                 .FontName = "Tahoma"
6712:                 .FontSize = 8
6713:                 .Themes   = .F.
6714:                 .Visible  = .T.
6715:             ENDWITH
6716: 
6717:             *-- lblValAdics "Valor Adicional" - top=542+29=571
6718:             par_oPage.AddObject("lbl_4c_LblValAdics", "Label")
6719:             WITH par_oPage.lbl_4c_LblValAdics
6720:                 .Top       = 571
6721:                 .Left      = 64
6722:                 .Width     = 71
6723:                 .Height    = 15
6724:                 .FontName  = "Tahoma"
6725:                 .FontSize  = 8
6726:                 .BackStyle = 0
6727:                 .Caption   = "Valor Adicional"
6728:                 .Visible   = .T.
6729:             ENDWITH
6730: 
6731:             *-- get_pftioc - top=557+29=586
6732:             par_oPage.AddObject("txt_4c_Pftioc", "TextBox")
6733:             WITH par_oPage.txt_4c_Pftioc
6734:                 .Top      = 586
6735:                 .Left     = 64
6736:                 .Width    = 94
6737:                 .Height   = 23
6738:                 .FontName = "Tahoma"
6739:                 .FontSize = 8
6740:                 .Themes   = .F.
6741:                 .Visible  = .T.
6742:             ENDWITH
6743: 
6744:             *-- chkPlanCus - top=556+29=585
6745:             par_oPage.AddObject("chk_4c_PlanCus", "CheckBox")
6746:             WITH par_oPage.chk_4c_PlanCus
6747:                 .Top      = 585
6748:                 .Left     = 36
6749:                 .Width    = 25
6750:                 .Height   = 25
6751:                 .FontName = "Tahoma"
6752:                 .FontSize = 8
6753:                 .Value    = 0
6754:                 .Themes   = .F.
6755:                 .Visible  = .T.
6756:             ENDWITH
6757: 
6758:             *-- Say6 "Peso Medio" - top=581+29=610
6759:             par_oPage.AddObject("lbl_4c_LblPesoM", "Label")
6760:             WITH par_oPage.lbl_4c_LblPesoM
6761:                 .Top       = 610
6762:                 .Left      = 10
6763:                 .Width     = 56
6764:                 .Height    = 15
6765:                 .FontName  = "Tahoma"
6766:                 .FontSize  = 8
6767:                 .BackStyle = 0
6768:                 .Caption   = "Peso M" + CHR(233) + "dio"
6769:                 .Visible   = .T.
6770:             ENDWITH
6771: 
6772:             *-- getPesom - top=596+29=625
6773:             par_oPage.AddObject("txt_4c_Peso", "TextBox")
6774:             WITH par_oPage.txt_4c_Peso
6775:                 .Top      = 625
6776:                 .Left     = 10
6777:                 .Width    = 79
6778:                 .Height   = 23
6779:                 .FontName = "Tahoma"
6780:                 .FontSize = 8
6781:                 .Themes   = .F.
6782:                 .Visible  = .T.
6783:             ENDWITH
6784: 
6785:             *-- cmdPesoM - top=597+29=626
6786:             par_oPage.AddObject("cmd_4c_CmdPesoM", "CommandButton")
6787:             WITH par_oPage.cmd_4c_CmdPesoM
6788:                 .Top      = 626
6789:                 .Left     = 92
6790:                 .Width    = 26
6791:                 .Height   = 23
6792:                 .Caption  = "..."
6793:                 .FontName = "Tahoma"
6794:                 .FontSize = 8
6795:                 .Themes   = .F.
6796:                 .Visible  = .T.
6797:             ENDWITH
6798: 
6799:             *-- Say7 "Cotacao" - top=581+29=610
6800:             par_oPage.AddObject("lbl_4c_LblCotacao", "Label")
6801:             WITH par_oPage.lbl_4c_LblCotacao
6802:                 .Top       = 610
6803:                 .Left      = 161
6804:                 .Width     = 42
6805:                 .Height    = 15
6806:                 .FontName  = "Tahoma"
6807:                 .FontSize  = 8
6808:                 .BackStyle = 0
6809:                 .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
6810:                 .Visible   = .T.
6811:             ENDWITH
6812: 
6813:             *-- GetCotaCalcP - top=596+29=625
6814:             par_oPage.AddObject("txt_4c_CotaCalcP", "TextBox")
6815:             WITH par_oPage.txt_4c_CotaCalcP
6816:                 .Top      = 625
6817:                 .Left     = 161
6818:                 .Width    = 115
6819:                 .Height   = 23
6820:                 .FontName = "Tahoma"
6821:                 .FontSize = 8
6822:                 .ReadOnly = .T.
6823:                 .Themes   = .F.
6824:                 .Visible  = .T.
6825:             ENDWITH
6826: 
6827:             *-- === SECAO VENDA ===
6828:             *-- Say2 " Venda " - top=474+29=503
6829:             par_oPage.AddObject("lbl_4c_LblVendaSep", "Label")
6830:             WITH par_oPage.lbl_4c_LblVendaSep
6831:                 .Top       = 503
6832:                 .Left      = 361
6833:                 .Width     = 48
6834:                 .Height    = 16
6835:                 .FontName  = "Tahoma"
6836:                 .FontSize  = 8
6837:                 .BackStyle = 0
6838:                 .Caption   = " Venda "
6839:                 .Visible   = .T.
6840:             ENDWITH
6841: 
6842:             *-- Shape4 - top=498+29=527
6843:             par_oPage.AddObject("shp_4c_Shape4", "Shape")
6844:             WITH par_oPage.shp_4c_Shape4
6845:                 .Top         = 527
6846:                 .Left        = 323
6847:                 .Width       = 158
6848:                 .Height      = 2
6849:                 .BackColor   = RGB(128,128,128)
6850:                 .BorderColor = RGB(128,128,128)
6851:                 .Visible     = .T.
6852:             ENDWITH
6853: 
6854:             *-- chkLiberaVenda - top=459+29=488
6855:             par_oPage.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
6856:             WITH par_oPage.chk_4c_ChkLiberaVenda
6857:                 .Top      = 488
6858:                 .Left     = 323
6859:                 .Width    = 39
6860:                 .Height   = 38
6861:                 .FontName = "Tahoma"
6862:                 .FontSize = 8
6863:                 .Value    = 0
6864:                 .Themes   = .F.
6865:                 .Visible  = .T.
6866:             ENDWITH
6867: 
6868:             *-- lblMkpVenda "MKP Ideal" - top=504+29=533
6869:             par_oPage.AddObject("lbl_4c_LblMkpVenda", "Label")
6870:             WITH par_oPage.lbl_4c_LblMkpVenda
6871:                 .Top       = 533
6872:                 .Left      = 324
6873:                 .Width     = 49
6874:                 .Height    = 15
6875:                 .FontName  = "Tahoma"
6876:                 .FontSize  = 8
6877:                 .BackStyle = 0
6878:                 .Caption   = "MKP Ideal"
6879:                 .Visible   = .T.
6880:             ENDWITH
6881: 
6882:             *-- getMargem - top=517+29=546
6883:             par_oPage.AddObject("txt_4c_Margem", "TextBox")
6884:             WITH par_oPage.txt_4c_Margem
6885:                 .Top      = 546
6886:                 .Left     = 323
6887:                 .Width    = 89
6888:                 .Height   = 23
6889:                 .FontName = "Tahoma"
6890:                 .FontSize = 8
6891:                 .Themes   = .F.
6892:                 .Visible  = .T.
6893:             ENDWITH
6894: 
6895:             *-- Say14 "MKP" - top=542+29=571
6896:             par_oPage.AddObject("lbl_4c_LblMkpFtio", "Label")
6897:             WITH par_oPage.lbl_4c_LblMkpFtio
6898:                 .Top       = 571
6899:                 .Left      = 360
6900:                 .Width     = 22
6901:                 .Height    = 15
6902:                 .FontName  = "Tahoma"
6903:                 .FontSize  = 8
6904:                 .BackStyle = 0
6905:                 .Caption   = "MKP"
6906:                 .Visible   = .T.
6907:             ENDWITH
6908: 
6909:             *-- getStatus - top=557+29=586
6910:             par_oPage.AddObject("txt_4c_Status", "TextBox")
6911:             WITH par_oPage.txt_4c_Status
6912:                 .Top      = 586
6913:                 .Left     = 324
6914:                 .Width    = 31
6915:                 .Height   = 23
6916:                 .FontName = "Tahoma"
6917:                 .FontSize = 8
6918:                 .ReadOnly = .T.
6919:                 .Themes   = .F.
6920:                 .Visible  = .T.
6921:             ENDWITH
6922: 
6923:             *-- Say24 "Sts" - top=542+29=571
6924:             par_oPage.AddObject("lbl_4c_LblSts", "Label")
6925:             WITH par_oPage.lbl_4c_LblSts
6926:                 .Top       = 571
6927:                 .Left      = 324
6928:                 .Width     = 17
6929:                 .Height    = 15
6930:                 .FontName  = "Tahoma"
6931:                 .FontSize  = 8
6932:                 .BackStyle = 0
6933:                 .Caption   = "Sts"
6934:                 .Visible   = .T.
6935:             ENDWITH
6936: 
6937:             *-- Getftio (feitio/markup) - top=557+29=586
6938:             par_oPage.AddObject("txt_4c_Ftio", "TextBox")
6939:             WITH par_oPage.txt_4c_Ftio
6940:                 .Top      = 586
6941:                 .Left     = 360
6942:                 .Width    = 24
6943:                 .Height   = 23
6944:                 .FontName = "Tahoma"
6945:                 .FontSize = 8
6946:                 .Themes   = .F.
6947:                 .Visible  = .T.
6948:             ENDWITH
6949: 
6950:             *-- lblIdeal "Preco Ideal (Moeda 1)" - top=503+29=532
6951:             par_oPage.AddObject("lbl_4c_LblIdeal", "Label")
6952:             WITH par_oPage.lbl_4c_LblIdeal
6953:                 .Top       = 532
6954:                 .Left      = 416
6955:                 .Width     = 111
6956:                 .Height    = 15
6957:                 .FontName  = "Tahoma"
6958:                 .FontSize  = 8
6959:                 .BackStyle = 0
6960:                 .Caption   = "Pre" + CHR(231) + "o Ideal (Moeda 1)"
6961:                 .Visible   = .T.
6962:             ENDWITH
6963: 
6964:             *-- getMoeda - top=517+29=546
6965:             par_oPage.AddObject("txt_4c_Moeda", "TextBox")
6966:             WITH par_oPage.txt_4c_Moeda
6967:                 .Top      = 546
6968:                 .Left     = 529
6969:                 .Width    = 31
6970:                 .Height   = 23
6971:                 .FontName = "Tahoma"
6972:                 .FontSize = 8
6973:                 .Themes   = .F.
6974:                 .Visible  = .T.
6975:             ENDWITH
6976: 
6977:             *-- getPvideal - top=517+29=546
6978:             par_oPage.AddObject("txt_4c_Pvideal", "TextBox")
6979:             WITH par_oPage.txt_4c_Pvideal
6980:                 .Top      = 546
6981:                 .Left     = 416
6982:                 .Width    = 110
6983:                 .Height   = 23
6984:                 .FontName = "Tahoma"
6985:                 .FontSize = 8
6986:                 .Themes   = .F.
6987:                 .Visible  = .T.
6988:             ENDWITH
6989: 
6990:             *-- lblFIdeals "Fator Ideal" - top=503+29=532
6991:             par_oPage.AddObject("lbl_4c_LblFIdeals", "Label")
6992:             WITH par_oPage.lbl_4c_LblFIdeals
6993:                 .Top       = 532
6994:                 .Left      = 563
6995:                 .Width     = 55
6996:                 .Height    = 15
6997:                 .FontName  = "Tahoma"
6998:                 .FontSize  = 8
6999:                 .BackStyle = 0
7000:                 .Caption   = "Fator Ideal"
7001:                 .Visible   = .T.
7002:             ENDWITH
7003: 
7004:             *-- getFIdeals - top=517+29=546
7005:             par_oPage.AddObject("txt_4c_FIdeals", "TextBox")
7006:             WITH par_oPage.txt_4c_FIdeals
7007:                 .Top      = 546
7008:                 .Left     = 563
7009:                 .Width    = 110
7010:                 .Height   = 23
7011:                 .FontName = "Tahoma"
7012:                 .FontSize = 8
7013:                 .Themes   = .F.
7014:                 .Visible  = .T.
7015:             ENDWITH
7016: 
7017:             *-- Say13 "Valor Adicional" - top=542+29=571
7018:             par_oPage.AddObject("lbl_4c_LblValAdd", "Label")
7019:             WITH par_oPage.lbl_4c_LblValAdd
7020:                 .Top       = 571
7021:                 .Left      = 416
7022:                 .Width     = 71
7023:                 .Height    = 15
7024:                 .FontName  = "Tahoma"
7025:                 .FontSize  = 8
7026:                 .BackStyle = 0
7027:                 .Caption   = "Valor Adicional"
7028:                 .Visible   = .T.
7029:             ENDWITH
7030: 
7031:             *-- Get_Pftio - top=557+29=586
7032:             par_oPage.AddObject("txt_4c_Pftio", "TextBox")
7033:             WITH par_oPage.txt_4c_Pftio
7034:                 .Top      = 586
7035:                 .Left     = 416
7036:                 .Width    = 110
7037:                 .Height   = 23
7038:                 .FontName = "Tahoma"
7039:                 .FontSize = 8
7040:                 .Themes   = .F.
7041:                 .Visible  = .T.
7042:             ENDWITH
7043: 
7044:             *-- Say12 "Fator" - top=542+29=571
7045:             par_oPage.AddObject("lbl_4c_LblFatorAtual", "Label")
7046:             WITH par_oPage.lbl_4c_LblFatorAtual
7047:                 .Top       = 571
7048:                 .Left      = 563
7049:                 .Width     = 28
7050:                 .Height    = 15
7051:                 .FontName  = "Tahoma"
7052:                 .FontSize  = 8
7053:                 .BackStyle = 0
7054:                 .Caption   = "Fator"
7055:                 .Visible   = .T.
7056:             ENDWITH
7057: 
7058:             *-- Get_mftio - top=557+29=586
7059:             par_oPage.AddObject("txt_4c_Mftio", "TextBox")
7060:             WITH par_oPage.txt_4c_Mftio
7061:                 .Top      = 586
7062:                 .Left     = 529
7063:                 .Width    = 31
7064:                 .Height   = 23
7065:                 .FontName = "Tahoma"
7066:                 .FontSize = 8
7067:                 .Themes   = .F.
7068:                 .Visible  = .T.
7069:             ENDWITH
7070: 
7071:             *-- getFvenda (fator venda) - top=557+29=586
7072:             par_oPage.AddObject("txt_4c_FvendaC", "TextBox")
7073:             WITH par_oPage.txt_4c_FvendaC
7074:                 .Top      = 586
7075:                 .Left     = 563
7076:                 .Width    = 110
7077:                 .Height   = 23
7078:                 .FontName = "Tahoma"
7079:                 .FontSize = 8
7080:                 .Themes   = .F.
7081:                 .Visible  = .T.
7082:             ENDWITH
7083: 
7084:             *-- getMoepv - top=557+29=586
7085:             par_oPage.AddObject("txt_4c_Moepv", "TextBox")
7086:             WITH par_oPage.txt_4c_Moepv
7087:                 .Top      = 586
7088:                 .Left     = 677
7089:                 .Width    = 31
7090:                 .Height   = 23
7091:                 .FontName = "Tahoma"
7092:                 .FontSize = 8
7093:                 .Themes   = .F.
7094:                 .Visible  = .T.
7095:             ENDWITH
7096: 
7097:             *-- lblVenda "Preco Atual (Moeda 2)" - top=581+29=610
7098:             par_oPage.AddObject("lbl_4c_LblVendaAtual", "Label")
7099:             WITH par_oPage.lbl_4c_LblVendaAtual
7100:                 .Top       = 610
7101:                 .Left      = 416
7102:                 .Width     = 115
7103:                 .Height    = 15
7104:                 .FontName  = "Tahoma"
7105:                 .FontSize  = 8
7106:                 .BackStyle = 0
7107:                 .Caption   = "Pre" + CHR(231) + "o Atual (Moeda 2)"
7108:                 .Visible   = .T.
7109:             ENDWITH
7110: 
7111:             *-- getMoev - top=596+29=625
7112:             par_oPage.AddObject("txt_4c_Moev", "TextBox")
7113:             WITH par_oPage.txt_4c_Moev
7114:                 .Top      = 625
7115:                 .Left     = 529
7116:                 .Width    = 31
7117:                 .Height   = 23
7118:                 .FontName = "Tahoma"
7119:                 .FontSize = 8
7120:                 .Themes   = .F.
7121:                 .Visible  = .T.
7122:             ENDWITH
7123: 
7124:             *-- getPven - top=596+29=625
7125:             par_oPage.AddObject("txt_4c_Pven", "TextBox")
7126:             WITH par_oPage.txt_4c_Pven
7127:                 .Top      = 625
7128:                 .Left     = 416
7129:                 .Width    = 110
7130:                 .Height   = 23
7131:                 .FontName = "Tahoma"
7132:                 .FontSize = 8
7133:                 .ReadOnly = .T.
7134:                 .Themes   = .F.
7135:                 .Visible  = .T.
7136:             ENDWITH
7137: 
7138:             *-- lblFAtuals "Fator Atual" - top=581+29=610
7139:             par_oPage.AddObject("lbl_4c_LblFAtuals", "Label")
7140:             WITH par_oPage.lbl_4c_LblFAtuals
7141:                 .Top       = 610
7142:                 .Left      = 563
7143:                 .Width     = 56
7144:                 .Height    = 15
7145:                 .FontName  = "Tahoma"
7146:                 .FontSize  = 8
7147:                 .BackStyle = 0
7148:                 .Caption   = "Fator Atual"
7149:                 .Visible   = .T.
7150:             ENDWITH
7151: 
7152:             *-- getFAtuals - top=596+29=625
7153:             par_oPage.AddObject("txt_4c_FAtuals", "TextBox")
7154:             WITH par_oPage.txt_4c_FAtuals
7155:                 .Top      = 625
7156:                 .Left     = 563
7157:                 .Width    = 110
7158:                 .Height   = 23
7159:                 .FontName = "Tahoma"
7160:                 .FontSize = 8
7161:                 .Themes   = .F.
7162:                 .Visible  = .T.
7163:             ENDWITH
7164: 
7165:             *-- lblMkpApl "MKP Aplic." - top=581+29=610
7166:             par_oPage.AddObject("lbl_4c_LblMkpApl", "Label")
7167:             WITH par_oPage.lbl_4c_LblMkpApl
7168:                 .Top       = 610
7169:                 .Left      = 324
7170:                 .Width     = 51
7171:                 .Height    = 15
7172:                 .FontName  = "Tahoma"
7173:                 .FontSize  = 8
7174:                 .BackStyle = 0
7175:                 .Caption   = "MKP Aplic."
7176:                 .Visible   = .T.
7177:             ENDWITH
7178: 
7179:             *-- getMarkupA - top=596+29=625
7180:             par_oPage.AddObject("txt_4c_MarkupA", "TextBox")
7181:             WITH par_oPage.txt_4c_MarkupA
7182:                 .Top      = 625
7183:                 .Left     = 323
7184:                 .Width    = 62
7185:                 .Height   = 23
7186:                 .FontName = "Tahoma"
7187:                 .FontSize = 8
7188:                 .ReadOnly = .T.
7189:                 .Themes   = .F.
7190:                 .Visible  = .T.
7191:             ENDWITH
7192: 
7193:             *-- chkPlanVen - top=556+29=585
7194:             par_oPage.AddObject("chk_4c_PlanVen", "CheckBox")
7195:             WITH par_oPage.chk_4c_PlanVen
7196:                 .Top      = 585
7197:                 .Left     = 387
7198:                 .Width    = 25
7199:                 .Height   = 25
7200:                 .FontName = "Tahoma"
7201:                 .FontSize = 8
7202:                 .Value    = 0
7203:                 .Themes   = .F.
7204:                 .Visible  = .T.
7205:             ENDWITH
7206: 
7207:             *-- Chk_Pvenda - top=595+29=624
7208:             par_oPage.AddObject("chk_4c_Pvenda", "CheckBox")
7209:             WITH par_oPage.chk_4c_Pvenda
7210:                 .Top      = 624
7211:                 .Left     = 387
7212:                 .Width    = 25
7213:                 .Height   = 25
7214:                 .FontName = "Tahoma"
7215:                 .FontSize = 8
7216:                 .Value    = 0
7217:                 .Themes   = .F.
7218:                 .Visible  = .T.
7219:             ENDWITH
7220: 
7221:             *-- lbl "Financeiro" + Get_Encarg - top=595+29=624
7222:             par_oPage.AddObject("lbl_4c_LblFinanceiro", "Label")
7223:             WITH par_oPage.lbl_4c_LblFinanceiro
7224:                 .Top       = 610
7225:                 .Left      = 678
7226:                 .Width     = 51
7227:                 .Height    = 15
7228:                 .FontName  = "Tahoma"
7229:                 .FontSize  = 8
7230:                 .BackStyle = 0
7231:                 .Caption   = "Financeiro"
7232:                 .Visible   = .T.
7233:             ENDWITH
7234: 
7235:             par_oPage.AddObject("txt_4c_Encarg", "TextBox")
7236:             WITH par_oPage.txt_4c_Encarg
7237:                 .Top      = 624
7238:                 .Left     = 678
7239:                 .Width    = 62
7240:                 .Height   = 23
7241:                 .FontName = "Tahoma"
7242:                 .FontSize = 8
7243:                 .Themes   = .F.
7244:                 .Visible  = .T.
7245:             ENDWITH
7246: 
7247:             *-- cmdCalcVals - top=507+29=536
7248:             par_oPage.AddObject("cmd_4c_CmdCalcVals", "CommandButton")
7249:             WITH par_oPage.cmd_4c_CmdCalcVals
7250:                 .Top      = 536
7251:                 .Left     = 678
7252:                 .Width    = 40
7253:                 .Height   = 40
7254:                 .Caption  = "Calc."
7255:                 .FontName = "Tahoma"
7256:                 .FontSize = 7
7257:                 .Themes   = .F.
7258:                 .Visible  = .T.
7259:             ENDWITH

*-- Linhas 7302 a 7327:
7302:             SET NULL OFF
7303: 
7304:             *-- === Say1: label "Tipo:" - top=159+29=188, left=112 ===
7305:             par_oPage.AddObject("lbl_4c_LblTipo", "Label")
7306:             WITH par_oPage.lbl_4c_LblTipo
7307:                 .Top       = 188
7308:                 .Left      = 112
7309:                 .Width     = 29
7310:                 .Height    = 15
7311:                 .FontName  = "Tahoma"
7312:                 .FontSize  = 8
7313:                 .BackStyle = 0
7314:                 .Caption   = "Tipo:"
7315:                 .Visible   = .T.
7316:             ENDWITH
7317: 
7318:             *-- === cmbTipos - top=154+29=183, left=143, w=187, h=23 ===
7319:             par_oPage.AddObject("cbo_4c_CmbTipos", "ComboBox")
7320:             WITH par_oPage.cbo_4c_CmbTipos
7321:                 .Top            = 183
7322:                 .Left           = 143
7323:                 .Width          = 187
7324:                 .Height         = 23
7325:                 .FontName       = "Tahoma"
7326:                 .FontSize       = 8
7327:                 .RowSourceType  = 1

*-- Linhas 7333 a 7342:
7333: 
7334:             *-- === grdCompo (custo principal) - top=178+29=207, left=34, w=813, h=230, 12 cols ===
7335:             par_oPage.AddObject("grd_4c_GrdCustoCompo", "Grid")
7336:             par_oPage.grd_4c_GrdCustoCompo.Top         = 207
7337:             par_oPage.grd_4c_GrdCustoCompo.Left        = 34
7338:             par_oPage.grd_4c_GrdCustoCompo.Width       = 813
7339:             par_oPage.grd_4c_GrdCustoCompo.Height      = 230
7340:             par_oPage.grd_4c_GrdCustoCompo.ColumnCount = 12
7341:             par_oPage.grd_4c_GrdCustoCompo.FontName    = "Tahoma"
7342:             par_oPage.grd_4c_GrdCustoCompo.FontSize    = 8

*-- Linhas 7350 a 7542:
7350: 
7351:             par_oPage.grd_4c_GrdCustoCompo.RecordSource = "cursor_4c_CustoCompo"
7352: 
7353:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.Caption  = "Item"
7354:             par_oPage.grd_4c_GrdCustoCompo.Column1.ControlSource    = "cursor_4c_CustoCompo.Mats"
7355:             par_oPage.grd_4c_GrdCustoCompo.Column1.Width            = 80
7356:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.FontBold = .T.
7357: 
7358:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
7359:             par_oPage.grd_4c_GrdCustoCompo.Column2.ControlSource    = "cursor_4c_CustoCompo.DPros"
7360:             par_oPage.grd_4c_GrdCustoCompo.Column2.Width            = 160
7361:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.FontBold = .T.
7362: 
7363:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.Caption  = "Un"
7364:             par_oPage.grd_4c_GrdCustoCompo.Column3.ControlSource    = "cursor_4c_CustoCompo.Unisp"
7365:             par_oPage.grd_4c_GrdCustoCompo.Column3.Width            = 35
7366:             par_oPage.grd_4c_GrdCustoCompo.Column3.ReadOnly         = .T.
7367:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.FontBold = .T.
7368: 
7369:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.Caption  = "Valor"
7370:             par_oPage.grd_4c_GrdCustoCompo.Column4.ControlSource    = "cursor_4c_CustoCompo.Vals"
7371:             par_oPage.grd_4c_GrdCustoCompo.Column4.Width            = 80
7372:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.FontBold = .T.
7373: 
7374:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.Caption  = "Qtde."
7375:             par_oPage.grd_4c_GrdCustoCompo.Column5.ControlSource    = "cursor_4c_CustoCompo.Qtds"
7376:             par_oPage.grd_4c_GrdCustoCompo.Column5.Width            = 65
7377:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.FontBold = .T.
7378: 
7379:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.Caption  = "Total"
7380:             par_oPage.grd_4c_GrdCustoCompo.Column6.ControlSource    = "cursor_4c_CustoCompo.Totals"
7381:             par_oPage.grd_4c_GrdCustoCompo.Column6.Width            = 80
7382:             par_oPage.grd_4c_GrdCustoCompo.Column6.ReadOnly         = .T.
7383:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.FontBold = .T.
7384: 
7385:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.Caption  = "Moe"
7386:             par_oPage.grd_4c_GrdCustoCompo.Column7.ControlSource    = "cursor_4c_CustoCompo.Moedas"
7387:             par_oPage.grd_4c_GrdCustoCompo.Column7.Width            = 40
7388:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.FontBold = .T.
7389: 
7390:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
7391:             par_oPage.grd_4c_GrdCustoCompo.Column8.ControlSource    = "cursor_4c_CustoCompo.Obss"
7392:             par_oPage.grd_4c_GrdCustoCompo.Column8.Width            = 100
7393:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.FontBold = .T.
7394: 
7395:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.Caption  = "E"
7396:             par_oPage.grd_4c_GrdCustoCompo.Column9.ControlSource    = "cursor_4c_CustoCompo.Es"
7397:             par_oPage.grd_4c_GrdCustoCompo.Column9.Width            = 30
7398:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.FontBold = .T.
7399: 
7400:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.Caption  = "Consumo"
7401:             par_oPage.grd_4c_GrdCustoCompo.Column10.ControlSource    = "cursor_4c_CustoCompo.Conss"
7402:             par_oPage.grd_4c_GrdCustoCompo.Column10.Width            = 65
7403:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.FontBold = .T.
7404: 
7405:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.Caption  = "Qtde."
7406:             par_oPage.grd_4c_GrdCustoCompo.Column11.ControlSource    = "cursor_4c_CustoCompo.Qtdss"
7407:             par_oPage.grd_4c_GrdCustoCompo.Column11.Width            = 65
7408:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.FontBold = .T.
7409: 
7410:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.Caption  = "Un"
7411:             par_oPage.grd_4c_GrdCustoCompo.Column12.ControlSource    = "cursor_4c_CustoCompo.Unis"
7412:             par_oPage.grd_4c_GrdCustoCompo.Column12.Width            = 35
7413:             par_oPage.grd_4c_GrdCustoCompo.Column12.ReadOnly         = .T.
7414:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.FontBold = .T.
7415: 
7416:             *-- === cmdgCompo (2 botoes +/-) - top=240+29=269, left=851, w=50, h=90 ===
7417:             par_oPage.AddObject("cmdg_4c_CustoCompo", "CommandGroup")
7418:             WITH par_oPage.cmdg_4c_CustoCompo
7419:                 .Top         = 269
7420:                 .Left        = 851
7421:                 .Width       = 50
7422:                 .Height      = 90
7423:                 .ButtonCount = 2
7424:                 .Themes      = .F.
7425:                 .Visible     = .T.
7426:             ENDWITH
7427: 
7428:             WITH par_oPage.cmdg_4c_CustoCompo.Buttons(1)
7429:                 .Caption  = "+"
7430:                 .Top      = 0
7431:                 .Left     = 0
7432:                 .Width    = 50
7433:                 .Height   = 40
7434:                 .FontName = "Tahoma"
7435:                 .FontSize = 10
7436:                 .FontBold = .T.
7437:                 .Themes   = .F.
7438:             ENDWITH
7439: 
7440:             WITH par_oPage.cmdg_4c_CustoCompo.Buttons(2)
7441:                 .Caption  = "-"
7442:                 .Top      = 42
7443:                 .Left     = 0
7444:                 .Width    = 50
7445:                 .Height   = 40
7446:                 .FontName = "Tahoma"
7447:                 .FontSize = 10
7448:                 .FontBold = .T.
7449:                 .Themes   = .F.
7450:             ENDWITH
7451: 
7452:             *-- === Say16: label "Descricao:" - top=415+29=444, left=52 ===
7453:             par_oPage.AddObject("lbl_4c_LblDescCus", "Label")
7454:             WITH par_oPage.lbl_4c_LblDescCus
7455:                 .Top       = 444
7456:                 .Left      = 52
7457:                 .Width     = 55
7458:                 .Height    = 15
7459:                 .FontName  = "Tahoma"
7460:                 .FontSize  = 8
7461:                 .BackStyle = 0
7462:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
7463:                 .Visible   = .T.
7464:             ENDWITH
7465: 
7466:             *-- === Get_Desc: textbox descricao - top=412+29=441, left=116, w=304 ===
7467:             par_oPage.AddObject("txt_4c_DescCus", "TextBox")
7468:             WITH par_oPage.txt_4c_DescCus
7469:                 .Top      = 441
7470:                 .Left     = 116
7471:                 .Width    = 304
7472:                 .Height   = 21
7473:                 .FontName = "Tahoma"
7474:                 .FontSize = 8
7475:                 .ReadOnly = .T.
7476:                 .Themes   = .F.
7477:                 .Visible  = .T.
7478:             ENDWITH
7479: 
7480:             *-- === Say2: label "Grupo:" - top=415+29=444, left=479 ===
7481:             par_oPage.AddObject("lbl_4c_LblGrupoCus", "Label")
7482:             WITH par_oPage.lbl_4c_LblGrupoCus
7483:                 .Top       = 444
7484:                 .Left      = 479
7485:                 .Width     = 38
7486:                 .Height    = 15
7487:                 .FontName  = "Tahoma"
7488:                 .FontSize  = 8
7489:                 .BackStyle = 0
7490:                 .Caption   = "Grupo:"
7491:                 .Visible   = .T.
7492:             ENDWITH
7493: 
7494:             *-- === getDGruCompos: textbox grupo - top=412+29=441, left=522, w=304 ===
7495:             par_oPage.AddObject("txt_4c_DGruCompos", "TextBox")
7496:             WITH par_oPage.txt_4c_DGruCompos
7497:                 .Top      = 441
7498:                 .Left     = 522
7499:                 .Width    = 304
7500:                 .Height   = 21
7501:                 .FontName = "Tahoma"
7502:                 .FontSize = 8
7503:                 .ReadOnly = .T.
7504:                 .Themes   = .F.
7505:                 .Visible  = .T.
7506:             ENDWITH
7507: 
7508:             *-- === Say3: label "Resumo por Grupo" - top=445+29=474, left=35 ===
7509:             par_oPage.AddObject("lbl_4c_LblResumoGrp", "Label")
7510:             WITH par_oPage.lbl_4c_LblResumoGrp
7511:                 .Top       = 474
7512:                 .Left      = 35
7513:                 .Width     = 107
7514:                 .Height    = 15
7515:                 .FontName  = "Tahoma"
7516:                 .FontSize  = 8
7517:                 .BackStyle = 0
7518:                 .Caption   = "Resumo por Grupo"
7519:                 .Visible   = .T.
7520:             ENDWITH
7521: 
7522:             *-- === Shape2 - top=460+29=489, left=35, w=158, h=2 ===
7523:             par_oPage.AddObject("shp_4c_ShapeCusto", "Shape")
7524:             WITH par_oPage.shp_4c_ShapeCusto
7525:                 .Top         = 489
7526:                 .Left        = 35
7527:                 .Width       = 158
7528:                 .Height      = 2
7529:                 .BackColor   = RGB(128,128,128)
7530:                 .BorderColor = RGB(128,128,128)
7531:                 .Visible     = .T.
7532:             ENDWITH
7533: 
7534:             *-- === GradeGRUPO2 - top=468+29=497, left=35, w=195, h=141, 3 cols ===
7535:             par_oPage.AddObject("grd_4c_GrupoCompo2", "Grid")
7536:             par_oPage.grd_4c_GrupoCompo2.Top         = 497
7537:             par_oPage.grd_4c_GrupoCompo2.Left        = 35
7538:             par_oPage.grd_4c_GrupoCompo2.Width       = 195
7539:             par_oPage.grd_4c_GrupoCompo2.Height      = 141
7540:             par_oPage.grd_4c_GrupoCompo2.ColumnCount = 3
7541:             par_oPage.grd_4c_GrupoCompo2.FontName    = "Tahoma"
7542:             par_oPage.grd_4c_GrupoCompo2.FontSize    = 8

*-- Linhas 7550 a 7568:
7550: 
7551:             par_oPage.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
7552: 
7553:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.Caption  = "Grp"
7554:             par_oPage.grd_4c_GrupoCompo2.Column1.ControlSource    = "cursor_4c_GrupoCompo2.CGrus"
7555:             par_oPage.grd_4c_GrupoCompo2.Column1.Width            = 60
7556:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.FontBold = .T.
7557: 
7558:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.Caption  = "Total"
7559:             par_oPage.grd_4c_GrupoCompo2.Column2.ControlSource    = "cursor_4c_GrupoCompo2.Totals"
7560:             par_oPage.grd_4c_GrupoCompo2.Column2.Width            = 90
7561:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.FontBold = .T.
7562: 
7563:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.Caption  = "Moe"
7564:             par_oPage.grd_4c_GrupoCompo2.Column3.ControlSource    = "cursor_4c_GrupoCompo2.Moedas"
7565:             par_oPage.grd_4c_GrupoCompo2.Column3.Width            = 40
7566:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.FontBold = .T.
7567: 
7568:         CATCH TO loc_oErro

*-- Linhas 8300 a 8368:
8300:             SET NULL OFF
8301: 
8302:             *-- === Say7: label "Qtde Componentes :" - top=523+29=552, left=25 ===
8303:             par_oPage.AddObject("lbl_4c_Label7", "Label")
8304:             WITH par_oPage.lbl_4c_Label7
8305:                 .Top       = 552
8306:                 .Left      = 25
8307:                 .Width     = 105
8308:                 .Height    = 15
8309:                 .FontName  = "Tahoma"
8310:                 .FontSize  = 8
8311:                 .BackStyle = 0
8312:                 .Caption   = "Qtde Componentes :"
8313:                 .Visible   = .T.
8314:             ENDWITH
8315: 
8316:             *-- === Getqtcpnt: TextBox contagem - top=519+29=548, left=131 ===
8317:             par_oPage.AddObject("txt_4c_Qtcpnt", "TextBox")
8318:             WITH par_oPage.txt_4c_Qtcpnt
8319:                 .Top      = 548
8320:                 .Left     = 131
8321:                 .Width    = 31
8322:                 .Height   = 23
8323:                 .FontName = "Tahoma"
8324:                 .FontSize = 8
8325:                 .ReadOnly = .T.
8326:                 .Themes   = .F.
8327:                 .Visible  = .T.
8328:             ENDWITH
8329: 
8330:             *-- === chkFund: CheckBox - top=544+29=573, left=10 ===
8331:             par_oPage.AddObject("chk_4c_ChkFund", "CheckBox")
8332:             WITH par_oPage.chk_4c_ChkFund
8333:                 .Top      = 573
8334:                 .Left     = 10
8335:                 .Width    = 182
8336:                 .Height   = 15
8337:                 .FontName = "Tahoma"
8338:                 .FontSize = 8
8339:                 .Caption  = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
8340:                 .Value    = 0
8341:                 .Themes   = .F.
8342:                 .Visible  = .T.
8343:             ENDWITH
8344: 
8345:             *-- === Say1: label "Tempo Producao por Agrupamento:" - top=521+29=550, left=642 ===
8346:             par_oPage.AddObject("lbl_4c_Label1", "Label")
8347:             WITH par_oPage.lbl_4c_Label1
8348:                 .Top       = 550
8349:                 .Left      = 642
8350:                 .Width     = 176
8351:                 .Height    = 15
8352:                 .FontName  = "Tahoma"
8353:                 .FontSize  = 8
8354:                 .BackStyle = 0
8355:                 .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
8356:                 .Visible   = .T.
8357:             ENDWITH
8358: 
8359:             *-- === GrdCons - top=155+29=184, left=6, w=987, h=362, 9 colunas ===
8360:             par_oPage.AddObject("grd_4c_GrdCons", "Grid")
8361:             loc_oGrd = par_oPage.grd_4c_GrdCons
8362:             loc_oGrd.Top         = 184
8363:             loc_oGrd.Left        = 6
8364:             loc_oGrd.Width       = 987
8365:             loc_oGrd.Height      = 362
8366:             loc_oGrd.ColumnCount = 9
8367:             loc_oGrd.FontName    = "Tahoma"
8368:             loc_oGrd.FontSize    = 8

*-- Linhas 8376 a 8428:
8376: 
8377:             loc_oGrd.RecordSource = "cursor_4c_ConsP"
8378: 
8379:             loc_oGrd.Column1.Header1.Caption  = "Componente"
8380:             loc_oGrd.Column1.ControlSource    = "cursor_4c_ConsP.Mats"
8381:             loc_oGrd.Column1.Width            = 100
8382:             loc_oGrd.Column1.ReadOnly         = .T.
8383:             loc_oGrd.Column1.Header1.FontBold = .T.
8384: 
8385:             loc_oGrd.Column2.Header1.Caption  = "Qtde."
8386:             loc_oGrd.Column2.ControlSource    = "cursor_4c_ConsP.Qtds"
8387:             loc_oGrd.Column2.Width            = 65
8388:             loc_oGrd.Column2.ReadOnly         = .T.
8389:             loc_oGrd.Column2.Header1.FontBold = .T.
8390: 
8391:             loc_oGrd.Column3.Header1.Caption  = "Uni"
8392:             loc_oGrd.Column3.ControlSource    = "cursor_4c_ConsP.Unisp"
8393:             loc_oGrd.Column3.Width            = 45
8394:             loc_oGrd.Column3.ReadOnly         = .T.
8395:             loc_oGrd.Column3.Header1.FontBold = .T.
8396: 
8397:             loc_oGrd.Column4.Header1.Caption  = "Fase"
8398:             loc_oGrd.Column4.ControlSource    = "cursor_4c_ConsP.Grupos"
8399:             loc_oGrd.Column4.Width            = 65
8400:             loc_oGrd.Column4.Header1.FontBold = .T.
8401: 
8402:             loc_oGrd.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8403:             loc_oGrd.Column5.ControlSource    = "cursor_4c_ConsP.Descrs"
8404:             loc_oGrd.Column5.Width            = 200
8405:             loc_oGrd.Column5.Header1.FontBold = .T.
8406: 
8407:             loc_oGrd.Column6.Header1.Caption  = "Ord."
8408:             loc_oGrd.Column6.ControlSource    = "cursor_4c_ConsP.Ordems"
8409:             loc_oGrd.Column6.Width            = 40
8410:             loc_oGrd.Column6.ReadOnly         = .T.
8411:             loc_oGrd.Column6.Header1.FontBold = .T.
8412: 
8413:             loc_oGrd.Column7.Header1.Caption  = "Consumo"
8414:             loc_oGrd.Column7.ControlSource    = "cursor_4c_ConsP.Conss"
8415:             loc_oGrd.Column7.Width            = 80
8416:             loc_oGrd.Column7.Header1.FontBold = .T.
8417: 
8418:             loc_oGrd.Column8.Header1.Caption  = "Cat."
8419:             loc_oGrd.Column8.ControlSource    = "cursor_4c_ConsP.Ccats"
8420:             loc_oGrd.Column8.Width            = 60
8421:             loc_oGrd.Column8.Header1.FontBold = .T.
8422: 
8423:             loc_oGrd.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8424:             loc_oGrd.Column9.ControlSource    = "cursor_4c_ConsP.DCats"
8425:             loc_oGrd.Column9.Width            = 150
8426:             loc_oGrd.Column9.ReadOnly         = .T.
8427:             loc_oGrd.Column9.Header1.FontBold = .T.
8428: 

*-- Linhas 8434 a 8443:
8434:             *-- === grDTEMP - top=519+29=548, left=821, w=172, h=107, 2 colunas ===
8435:             par_oPage.AddObject("grd_4c_GrDTEMP", "Grid")
8436:             WITH par_oPage.grd_4c_GrDTEMP
8437:                 .Top         = 548
8438:                 .Left        = 821
8439:                 .Width       = 172
8440:                 .Height      = 107
8441:                 .ColumnCount = 2
8442:                 .FontName    = "Tahoma"
8443:                 .FontSize    = 8

*-- Linhas 8452 a 8466:
8452: 
8453:             par_oPage.grd_4c_GrDTEMP.RecordSource = "cursor_4c_DTemp"
8454: 
8455:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.Caption  = "Agrupamento"
8456:             par_oPage.grd_4c_GrDTEMP.Column1.ControlSource    = "cursor_4c_DTemp.Grupos"
8457:             par_oPage.grd_4c_GrDTEMP.Column1.Width            = 90
8458:             par_oPage.grd_4c_GrDTEMP.Column1.ReadOnly         = .T.
8459:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.FontBold = .T.
8460: 
8461:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.Caption  = "Tempo %"
8462:             par_oPage.grd_4c_GrDTEMP.Column2.ControlSource    = "cursor_4c_DTemp.TempoP"
8463:             par_oPage.grd_4c_GrDTEMP.Column2.Width            = 70
8464:             par_oPage.grd_4c_GrDTEMP.Column2.ReadOnly         = .T.
8465:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.FontBold = .T.
8466: 

*-- Linhas 8738 a 9101:
8738:             *-- === Shape fundo imagem fase (shpFig, top=152+29=181, left=231, w=244, h=148) ===
8739:             par_oPage.AddObject("shp_4c_ShpFig", "Shape")
8740:             WITH par_oPage.shp_4c_ShpFig
8741:                 .Top    = 181
8742:                 .Left   = 231
8743:                 .Width  = 244
8744:                 .Height = 148
8745:                 .BackColor   = RGB(255,255,255)
8746:                 .BorderStyle = 1
8747:                 .Visible     = .T.
8748:             ENDWITH
8749: 
8750:             *-- === Imagem fase (ImgFigJpg, top=153+29=182, left=232, w=241, h=146) ===
8751:             par_oPage.AddObject("img_4c_ImgFigJpg", "Image")
8752:             WITH par_oPage.img_4c_ImgFigJpg
8753:                 .Top     = 182
8754:                 .Left    = 232
8755:                 .Width   = 241
8756:                 .Height  = 146
8757:                 .Stretch = 2
8758:                 .Visible = .F.
8759:             ENDWITH
8760: 
8761:             *-- === Botao Ficha (CmdFicha, top=152+29=181, left=482, w=40, h=40) ===
8762:             par_oPage.AddObject("cmd_4c_CmdFicha", "CommandButton")
8763:             WITH par_oPage.cmd_4c_CmdFicha
8764:                 .Top      = 181
8765:                 .Left   = 482
8766:                 .Width    = 40
8767:                 .Height = 40
8768:                 .Caption  = "Fch"
8769:                 .FontName = "Tahoma"
8770:                 .FontSize = 7
8771:                 .Themes   = .F.
8772:                 .Visible = .T.
8773:             ENDWITH
8774: 
8775:             *-- === Botao Figura/Foto (cmdgFigura, top=192+29=221, left=482, w=40, h=40) ===
8776:             par_oPage.AddObject("cmd_4c_CmdgFigura", "CommandButton")
8777:             WITH par_oPage.cmd_4c_CmdgFigura
8778:                 .Top      = 221
8779:                 .Left   = 482
8780:                 .Width    = 40
8781:                 .Height = 40
8782:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
8783:                 .Caption  = ""
8784:                 .FontName = "Tahoma"
8785:                 .FontSize = 8
8786:                 .Themes   = .F.
8787:                 .Visible = .T.
8788:             ENDWITH
8789: 
8790:             *-- === Botao Camera/Cam (cmdgFigCam, top=232+29=261, left=482, w=40, h=40) ===
8791:             par_oPage.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
8792:             WITH par_oPage.cmd_4c_CmdgFigCam
8793:                 .Top      = 261
8794:                 .Left   = 482
8795:                 .Width    = 40
8796:                 .Height = 40
8797:                 .Caption  = "Cam"
8798:                 .FontName = "Tahoma"
8799:                 .FontSize = 7
8800:                 .Themes   = .F.
8801:                 .Visible = .T.
8802:             ENDWITH
8803: 
8804:             *-- === Label "Qtd. Min. Producao :" (Say13, top=156+29=185, left=33, w=102, h=15) ===
8805:             par_oPage.AddObject("lbl_4c_Label13", "Label")
8806:             WITH par_oPage.lbl_4c_Label13
8807:                 .Top = 185
8808:                 .Left = 33
8809:                 .Width = 102
8810:                 .Height = 15
8811:                 .FontName = "Tahoma"
8812:                 .FontSize = 8
8813:                 .BackStyle = 0
8814:                 .Caption = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
8815:                 .Visible = .T.
8816:             ENDWITH
8817: 
8818:             *-- === TextBox Qmin (getQmin, top=152+29=181, left=137, w=80, h=23) ===
8819:             par_oPage.AddObject("txt_4c_Qmin", "TextBox")
8820:             WITH par_oPage.txt_4c_Qmin
8821:                 .Top = 181
8822:                 .Left = 137
8823:                 .Width = 80
8824:                 .Height = 23
8825:                 .FontName = "Tahoma"
8826:                 .FontSize = 8
8827:                 .Themes = .F.
8828:                 .Visible = .T.
8829:             ENDWITH
8830: 
8831:             *-- === Label "Garra :" (Say5, top=181+29=210, left=99, w=36, h=15) ===
8832:             par_oPage.AddObject("lbl_4c_Label5", "Label")
8833:             WITH par_oPage.lbl_4c_Label5
8834:                 .Top = 210
8835:                 .Left = 99
8836:                 .Width = 36
8837:                 .Height = 15
8838:                 .FontName = "Tahoma"
8839:                 .FontSize = 8
8840:                 .BackStyle = 0
8841:                 .Caption = "Garra :"
8842:                 .Visible = .T.
8843:             ENDWITH
8844: 
8845:             *-- === TextBox CodGarras (getCodGarras, top=177+29=206, left=137, w=80, h=23, readonly) ===
8846:             par_oPage.AddObject("txt_4c_CodGarras", "TextBox")
8847:             WITH par_oPage.txt_4c_CodGarras
8848:                 .Top = 206
8849:                 .Left = 137
8850:                 .Width = 80
8851:                 .Height = 23
8852:                 .FontName = "Tahoma"
8853:                 .FontSize = 8
8854:                 .ReadOnly = .T.
8855:                 .Themes = .F.
8856:                 .Visible = .T.
8857:             ENDWITH
8858: 
8859:             *-- === Label "Conquilha :" (Say4, top=206+29=235, left=79, h=15) ===
8860:             par_oPage.AddObject("lbl_4c_Label4", "Label")
8861:             WITH par_oPage.lbl_4c_Label4
8862:                 .Top = 235
8863:                 .Left = 79
8864:                 .Width = 57
8865:                 .Height = 15
8866:                 .FontName = "Tahoma"
8867:                 .FontSize = 8
8868:                 .BackStyle = 0
8869:                 .Caption = "Conquilha :"
8870:                 .Visible = .T.
8871:             ENDWITH
8872: 
8873:             *-- === TextBox Conquilha (getConquilha, top=202+29=231, left=137, w=80, h=23) ===
8874:             par_oPage.AddObject("txt_4c_Conquilha", "TextBox")
8875:             WITH par_oPage.txt_4c_Conquilha
8876:                 .Top = 231
8877:                 .Left = 137
8878:                 .Width = 80
8879:                 .Height = 23
8880:                 .FontName = "Tahoma"
8881:                 .FontSize = 8
8882:                 .Themes = .F.
8883:                 .Visible = .T.
8884:             ENDWITH
8885: 
8886:             *-- === Label "Peso Brilhante :" (Say9, top=231+29=260, left=58, w=77, h=15) ===
8887:             par_oPage.AddObject("lbl_4c_Label9", "Label")
8888:             WITH par_oPage.lbl_4c_Label9
8889:                 .Top = 260
8890:                 .Left = 58
8891:                 .Width = 77
8892:                 .Height = 15
8893:                 .FontName = "Tahoma"
8894:                 .FontSize = 8
8895:                 .BackStyle = 0
8896:                 .Caption = "Peso Brilhante :"
8897:                 .Visible = .T.
8898:             ENDWITH
8899: 
8900:             *-- === TextBox PesoBris (getPesoBris, top=227+29=256, left=137, w=80, h=23) ===
8901:             par_oPage.AddObject("txt_4c_PesoBris", "TextBox")
8902:             WITH par_oPage.txt_4c_PesoBris
8903:                 .Top = 256
8904:                 .Left = 137
8905:                 .Width = 80
8906:                 .Height = 23
8907:                 .FontName = "Tahoma"
8908:                 .FontSize = 8
8909:                 .Themes = .F.
8910:                 .Visible = .T.
8911:             ENDWITH
8912: 
8913:             *-- === Label "Peso Metal :" (Say10, top=256+29=285, left=74, w=61, h=15) ===
8914:             par_oPage.AddObject("lbl_4c_Label10", "Label")
8915:             WITH par_oPage.lbl_4c_Label10
8916:                 .Top = 285
8917:                 .Left = 74
8918:                 .Width = 61
8919:                 .Height = 15
8920:                 .FontName = "Tahoma"
8921:                 .FontSize = 8
8922:                 .BackStyle = 0
8923:                 .Caption = "Peso Metal :"
8924:                 .Visible = .T.
8925:             ENDWITH
8926: 
8927:             *-- === TextBox PesoMetal (getPesoMetal, top=252+29=281, left=137, w=80, h=23) ===
8928:             par_oPage.AddObject("txt_4c_PesoMetal", "TextBox")
8929:             WITH par_oPage.txt_4c_PesoMetal
8930:                 .Top = 281
8931:                 .Left = 137
8932:                 .Width = 80
8933:                 .Height = 23
8934:                 .FontName = "Tahoma"
8935:                 .FontSize = 8
8936:                 .Themes = .F.
8937:                 .Visible = .T.
8938:             ENDWITH
8939: 
8940:             *-- === Label "Peso Pedra :" (Say8, top=281+29=310, left=72, w=63, h=15) ===
8941:             par_oPage.AddObject("lbl_4c_Label8", "Label")
8942:             WITH par_oPage.lbl_4c_Label8
8943:                 .Top = 310
8944:                 .Left = 72
8945:                 .Width = 63
8946:                 .Height = 15
8947:                 .FontName = "Tahoma"
8948:                 .FontSize = 8
8949:                 .BackStyle = 0
8950:                 .Caption = "Peso Pedra :"
8951:                 .Visible = .T.
8952:             ENDWITH
8953: 
8954:             *-- === TextBox PesoPdrs (getPesoPdrs, top=277+29=306, left=137, w=80, h=23) ===
8955:             par_oPage.AddObject("txt_4c_PesoPdrs", "TextBox")
8956:             WITH par_oPage.txt_4c_PesoPdrs
8957:                 .Top = 306
8958:                 .Left = 137
8959:                 .Width = 80
8960:                 .Height = 23
8961:                 .FontName = "Tahoma"
8962:                 .FontSize = 8
8963:                 .Themes = .F.
8964:                 .Visible = .T.
8965:             ENDWITH
8966: 
8967:             *-- === Label "Cor Padrao :" (Say7, top=306+29=335, left=72, h=15) ===
8968:             par_oPage.AddObject("lbl_4c_Label7", "Label")
8969:             WITH par_oPage.lbl_4c_Label7
8970:                 .Top = 335
8971:                 .Left = 72
8972:                 .Width = 63
8973:                 .Height = 15
8974:                 .FontName = "Tahoma"
8975:                 .FontSize = 8
8976:                 .BackStyle = 0
8977:                 .Caption = "Cor Padr" + CHR(227) + "o :"
8978:                 .Visible = .T.
8979:             ENDWITH
8980: 
8981:             *-- === TextBox Cor (getCor, top=302+29=331, left=137, w=38, h=23) ===
8982:             par_oPage.AddObject("txt_4c_Cor", "TextBox")
8983:             WITH par_oPage.txt_4c_Cor
8984:                 .Top = 331
8985:                 .Left = 137
8986:                 .Width = 38
8987:                 .Height = 23
8988:                 .FontName = "Tahoma"
8989:                 .FontSize = 8
8990:                 .Themes = .F.
8991:                 .Visible = .T.
8992:             ENDWITH
8993: 
8994:             *-- === CheckBox Cravacao em Cera (opc_CravCera, top=306+29=335, left=180) ===
8995:             par_oPage.AddObject("chk_4c_Opc_CravCera", "CheckBox")
8996:             WITH par_oPage.chk_4c_Opc_CravCera
8997:                 .Top = 335
8998:                 .Left = 180
8999:                 .Width = 120
9000:                 .Height = 15
9001:                 .FontName = "Tahoma"
9002:                 .FontSize = 8
9003:                 .Caption = "Crava" + CHR(231) + CHR(227) + "o em Cera"
9004:                 .Value = 0
9005:                 .Themes = .F.
9006:                 .Visible = .T.
9007:             ENDWITH
9008: 
9009:             *-- === Label "Tamanho Padrao :" (Say2, top=331+29=360, left=45, h=15) ===
9010:             par_oPage.AddObject("lbl_4c_Label2", "Label")
9011:             WITH par_oPage.lbl_4c_Label2
9012:                 .Top = 360
9013:                 .Left = 45
9014:                 .Width = 90
9015:                 .Height = 15
9016:                 .FontName = "Tahoma"
9017:                 .FontSize = 8
9018:                 .BackStyle = 0
9019:                 .Caption = "Tamanho Padr" + CHR(227) + "o :"
9020:                 .Visible = .T.
9021:             ENDWITH
9022: 
9023:             *-- === TextBox Tam (getTam, top=327+29=356, left=137, w=38, h=23) ===
9024:             par_oPage.AddObject("txt_4c_Tam", "TextBox")
9025:             WITH par_oPage.txt_4c_Tam
9026:                 .Top = 356
9027:                 .Left = 137
9028:                 .Width = 38
9029:                 .Height = 23
9030:                 .FontName = "Tahoma"
9031:                 .FontSize = 8
9032:                 .Themes = .F.
9033:                 .Visible = .T.
9034:             ENDWITH
9035: 
9036:             *-- === CheckBox Peso Variavel (fwoption1, top=331+29=360, left=180) ===
9037:             par_oPage.AddObject("chk_4c_Fwoption1", "CheckBox")
9038:             WITH par_oPage.chk_4c_Fwoption1
9039:                 .Top = 360
9040:                 .Left = 180
9041:                 .Width = 100
9042:                 .Height = 15
9043:                 .FontName = "Tahoma"
9044:                 .FontSize = 8
9045:                 .Caption = "Peso Vari" + CHR(225) + "vel"
9046:                 .Value = 0
9047:                 .Themes = .F.
9048:                 .Visible = .T.
9049:             ENDWITH
9050: 
9051:             *-- === Label "Acabamento :" (lblAcabamento, top=356+29=385, left=16, w=119, h=15) ===
9052:             par_oPage.AddObject("lbl_4c_LblAcabamento", "Label")
9053:             WITH par_oPage.lbl_4c_LblAcabamento
9054:                 .Top = 385
9055:                 .Left = 16
9056:                 .Width = 119
9057:                 .Height = 15
9058:                 .FontName = "Tahoma"
9059:                 .FontSize = 8
9060:                 .BackStyle = 0
9061:                 .Caption = "Acabamento :"
9062:                 .Visible = .T.
9063:             ENDWITH
9064: 
9065:             *-- === TextBox codacb (get_codacb, top=352+29=381, left=137, w=38, h=23) ===
9066:             par_oPage.AddObject("txt_4c_codacb", "TextBox")
9067:             WITH par_oPage.txt_4c_codacb
9068:                 .Top = 381
9069:                 .Left = 137
9070:                 .Width = 38
9071:                 .Height = 23
9072:                 .FontName = "Tahoma"
9073:                 .FontSize = 8
9074:                 .Themes = .F.
9075:                 .Visible = .T.
9076:             ENDWITH
9077: 
9078:             *-- === TextBox Dacb (get_Dacb, top=352+29=381, left=177, w=207, h=23, readonly) ===
9079:             par_oPage.AddObject("txt_4c_Dacb", "TextBox")
9080:             WITH par_oPage.txt_4c_Dacb
9081:                 .Top = 381
9082:                 .Left = 177
9083:                 .Width = 207
9084:                 .Height = 23
9085:                 .FontName = "Tahoma"
9086:                 .FontSize = 8
9087:                 .ReadOnly = .T.
9088:                 .Themes = .F.
9089:                 .Visible = .T.
9090:             ENDWITH
9091: 
9092:             *-- === grd_4c_GradFase (GradFase, top=152+29=181, left=527, w=420, h=312, 5 colunas) ===
9093:             par_oPage.AddObject("grd_4c_GradFase", "Grid")
9094:             loc_oGrd = par_oPage.grd_4c_GradFase
9095:             loc_oGrd.Top         = 181
9096:             loc_oGrd.Left        = 527
9097:             loc_oGrd.Width       = 420
9098:             loc_oGrd.Height      = 312
9099:             loc_oGrd.ColumnCount = 5
9100:             loc_oGrd.FontName    = "Tahoma"
9101:             loc_oGrd.FontSize    = 8

*-- Linhas 9109 a 9138:
9109: 
9110:             loc_oGrd.RecordSource = "cursor_4c_PrfFase"
9111: 
9112:             loc_oGrd.Column1.Header1.Caption  = "Ordem"
9113:             loc_oGrd.Column1.ControlSource    = "cursor_4c_PrfFase.Ordems"
9114:             loc_oGrd.Column1.Width            = 40
9115:             loc_oGrd.Column1.Header1.FontBold = .T.
9116: 
9117:             loc_oGrd.Column2.Header1.Caption  = "Fase"
9118:             loc_oGrd.Column2.ControlSource    = "cursor_4c_PrfFase.Grupos"
9119:             loc_oGrd.Column2.Width            = 70
9120:             loc_oGrd.Column2.Header1.FontBold = .T.
9121: 
9122:             loc_oGrd.Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
9123:             loc_oGrd.Column3.ControlSource    = "cursor_4c_PrfFase.Descrs"
9124:             loc_oGrd.Column3.Width            = 160
9125:             loc_oGrd.Column3.ReadOnly         = .T.
9126:             loc_oGrd.Column3.Header1.FontBold = .T.
9127: 
9128:             loc_oGrd.Column4.Header1.Caption  = "Uni. Produtiva"
9129:             loc_oGrd.Column4.ControlSource    = "cursor_4c_PrfFase.UniPrdts"
9130:             loc_oGrd.Column4.Width            = 75
9131:             loc_oGrd.Column4.Header1.FontBold = .T.
9132: 
9133:             loc_oGrd.Column5.Header1.Caption  = "Material"
9134:             loc_oGrd.Column5.ControlSource    = "cursor_4c_PrfFase.MatPrdts"
9135:             loc_oGrd.Column5.Width            = 75
9136:             loc_oGrd.Column5.Header1.FontBold = .T.
9137: 
9138:             *-- BINDEVENTs para GradFase

*-- Linhas 9144 a 9250:
9144:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress",         THIS, "GradFaseCol5KeyPress")
9145: 
9146:             *-- === Botao Incluir fase (inserir, top=152+29=181, left=950, w=40, h=40) ===
9147:             par_oPage.AddObject("cmd_4c_Incluir", "CommandButton")
9148:             WITH par_oPage.cmd_4c_Incluir
9149:                 .Top     = 181
9150:                 .Left   = 950
9151:                 .Width   = 40
9152:                 .Height = 40
9153:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9154:                 .Caption = ""
9155:                 .FontName = "Tahoma"
9156:                 .FontSize = 8
9157:                 .Themes  = .F.
9158:                 .Visible = .T.
9159:             ENDWITH
9160: 
9161:             *-- === Botao Excluir fase (excluir, top=192+29=221, left=950, w=40, h=40) ===
9162:             par_oPage.AddObject("cmd_4c_Excluir", "CommandButton")
9163:             WITH par_oPage.cmd_4c_Excluir
9164:                 .Top     = 221
9165:                 .Left   = 950
9166:                 .Width   = 40
9167:                 .Height = 40
9168:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
9169:                 .Caption = ""
9170:                 .FontName = "Tahoma"
9171:                 .FontSize = 8
9172:                 .Themes  = .F.
9173:                 .Visible = .T.
9174:             ENDWITH
9175: 
9176:             *-- === Botao Alternativa (Alternativa, top=232+29=261, left=950, w=40, h=40) ===
9177:             par_oPage.AddObject("cmd_4c_Alternativa", "CommandButton")
9178:             WITH par_oPage.cmd_4c_Alternativa
9179:                 .Top     = 261
9180:                 .Left   = 950
9181:                 .Width   = 40
9182:                 .Height = 40
9183:                 .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_26.jpg"
9184:                 .Caption = ""
9185:                 .FontName = "Tahoma"
9186:                 .FontSize = 8
9187:                 .Themes  = .F.
9188:                 .Visible = .T.
9189:             ENDWITH
9190: 
9191:             *-- BINDEVENTs para botoes do GradFase
9192:             BINDEVENT(par_oPage.cmd_4c_Incluir,    "Click", THIS, "FasePIncluirClick")
9193:             BINDEVENT(par_oPage.cmd_4c_Excluir,    "Click", THIS, "FasePExcluirClick")
9194:             BINDEVENT(par_oPage.cmd_4c_Alternativa,"Click", THIS, "FasePAlternativaClick")
9195:             BINDEVENT(par_oPage.cmd_4c_CmdFicha,   "Click", THIS, "FasePCmdFichaClick")
9196:             BINDEVENT(par_oPage.cmd_4c_CmdgFigura, "Click", THIS, "FasePCmdgFiguraClick")
9197:             BINDEVENT(par_oPage.cmd_4c_CmdgFigCam, "Click", THIS, "FasePCmdgFigCamClick")
9198:             BINDEVENT(par_oPage.img_4c_ImgFigJpg,  "Click", THIS, "FasePImgFigJpgClick")
9199: 
9200:             *-- === Label "Descricao :" (Say1, top=474+29=503, left=527, w=67, h=17) ===
9201:             par_oPage.AddObject("lbl_4c_Label1", "Label")
9202:             WITH par_oPage.lbl_4c_Label1
9203:                 .Top = 503
9204:                 .Left = 527
9205:                 .Width = 67
9206:                 .Height = 17
9207:                 .FontName = "Tahoma"
9208:                 .FontSize = 8
9209:                 .BackStyle = 0
9210:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
9211:                 .Visible = .T.
9212:             ENDWITH
9213: 
9214:             *-- === TextBox Desc (Get_Desc, top=471+29=500, left=595, w=395, h=23) ===
9215:             par_oPage.AddObject("txt_4c_Desc", "TextBox")
9216:             WITH par_oPage.txt_4c_Desc
9217:                 .Top = 500
9218:                 .Left = 595
9219:                 .Width = 395
9220:                 .Height = 23
9221:                 .FontName = "Tahoma"
9222:                 .FontSize = 8
9223:                 .Themes = .F.
9224:                 .Visible = .T.
9225:             ENDWITH
9226: 
9227:             *-- === EditBox Obs (Get_Obs, top=497+29=526, left=527, w=463, h=122) ===
9228:             par_oPage.AddObject("edt_4c_Get_Obs", "EditBox")
9229:             WITH par_oPage.edt_4c_Get_Obs
9230:                 .Top = 526
9231:                 .Left = 527
9232:                 .Width = 463
9233:                 .Height = 122
9234:                 .FontName = "Tahoma"
9235:                 .FontSize = 8
9236:                 .ScrollBars = 2
9237:                 .Themes = .F.
9238:                 .Visible = .T.
9239:             ENDWITH
9240: 
9241:             *-- === grd_4c_Matrizes (grdMatrizes, top=380+29=409, left=7, w=246, h=240, 4 colunas) ===
9242:             par_oPage.AddObject("grd_4c_Matrizes", "Grid")
9243:             loc_oGrd2 = par_oPage.grd_4c_Matrizes
9244:             loc_oGrd2.Top         = 409
9245:             loc_oGrd2.Left        = 7
9246:             loc_oGrd2.Width       = 246
9247:             loc_oGrd2.Height      = 240
9248:             loc_oGrd2.ColumnCount = 4
9249:             loc_oGrd2.FontName    = "Tahoma"
9250:             loc_oGrd2.FontSize    = 8

*-- Linhas 9258 a 9343:
9258: 
9259:             loc_oGrd2.RecordSource = "cursor_4c_Mtz"
9260: 
9261:             loc_oGrd2.Column1.Header1.Caption  = "Matriz"
9262:             loc_oGrd2.Column1.ControlSource    = "cursor_4c_Mtz.CMats"
9263:             loc_oGrd2.Column1.Width            = 60
9264:             loc_oGrd2.Column1.Header1.FontBold = .T.
9265: 
9266:             loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
9267:             loc_oGrd2.Column2.ControlSource    = "cursor_4c_Mtz.DPros"
9268:             loc_oGrd2.Column2.Width            = 100
9269:             loc_oGrd2.Column2.ReadOnly         = .T.
9270:             loc_oGrd2.Column2.Header1.FontBold = .T.
9271: 
9272:             loc_oGrd2.Column3.Header1.Caption  = "Local"
9273:             loc_oGrd2.Column3.ControlSource    = "cursor_4c_Mtz.Locals"
9274:             loc_oGrd2.Column3.Width            = 50
9275:             loc_oGrd2.Column3.ReadOnly         = .T.
9276:             loc_oGrd2.Column3.Header1.FontBold = .T.
9277: 
9278:             loc_oGrd2.Column4.Header1.Caption  = "Qtde"
9279:             loc_oGrd2.Column4.ControlSource    = "cursor_4c_Mtz.Qtds"
9280:             loc_oGrd2.Column4.Width            = 36
9281:             loc_oGrd2.Column4.Header1.FontBold = .T.
9282: 
9283:             *-- BINDEVENTs para Matrizes
9284:             BINDEVENT(loc_oGrd2,              "AfterRowColChange", THIS, "MatrizesAfterRowColChange")
9285:             BINDEVENT(loc_oGrd2.Column1.Text1, "GotFocus",         THIS, "MatrizesCol1GotFocus")
9286:             BINDEVENT(loc_oGrd2.Column1.Text1, "KeyPress",         THIS, "MatrizesCol1KeyPress")
9287: 
9288:             *-- === Botao Inserir Matriz (btnInsereMtx, top=380+29=409, left=258, w=40, h=40) ===
9289:             par_oPage.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
9290:             WITH par_oPage.cmd_4c_BtnInsereMtx
9291:                 .Top     = 409
9292:                 .Left   = 258
9293:                 .Width   = 40
9294:                 .Height = 40
9295:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9296:                 .Caption = ""
9297:                 .FontName = "Tahoma"
9298:                 .FontSize = 8
9299:                 .Themes  = .F.
9300:                 .Visible = .T.
9301:             ENDWITH
9302: 
9303:             *-- === Botao Excluir Matriz (btnExcluiMtz, top=420+29=449, left=258, w=40, h=40) ===
9304:             par_oPage.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
9305:             WITH par_oPage.cmd_4c_BtnExcluiMtz
9306:                 .Top     = 449
9307:                 .Left   = 258
9308:                 .Width   = 40
9309:                 .Height = 40
9310:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
9311:                 .Caption = ""
9312:                 .FontName = "Tahoma"
9313:                 .FontSize = 8
9314:                 .Themes  = .F.
9315:                 .Visible = .T.
9316:             ENDWITH
9317: 
9318:             *-- BINDEVENTs botoes Matrizes
9319:             BINDEVENT(par_oPage.cmd_4c_BtnInsereMtx, "Click", THIS, "FasePBtnInsereMtxClick")
9320:             BINDEVENT(par_oPage.cmd_4c_BtnExcluiMtz, "Click", THIS, "FasePBtnExcluiMtzClick")
9321: 
9322:             *-- === Shape fundo borracha (shpBorracha, top=464+29=493, left=258, w=236, h=156) ===
9323:             par_oPage.AddObject("shp_4c_ShpBorracha", "Shape")
9324:             WITH par_oPage.shp_4c_ShpBorracha
9325:                 .Top    = 493
9326:                 .Left   = 258
9327:                 .Width  = 236
9328:                 .Height = 156
9329:                 .BackColor   = RGB(255,255,255)
9330:                 .BorderStyle = 1
9331:                 .Visible     = .T.
9332:             ENDWITH
9333: 
9334:             *-- === Imagem borracha/matriz (ImgBorracha, top=465+29=494, left=260, w=232, h=154) ===
9335:             par_oPage.AddObject("img_4c_ImgBorracha", "Image")
9336:             WITH par_oPage.img_4c_ImgBorracha
9337:                 .Top     = 494
9338:                 .Left    = 260
9339:                 .Width   = 232
9340:                 .Height  = 154
9341:                 .Stretch = 2
9342:                 .Visible = .F.
9343:             ENDWITH

*-- Linhas 10436 a 10477:
10436:             SET NULL OFF
10437: 
10438:             *-- === Say16: "Grupo C.C. :" - top=165+29=194, left=138, w=63, h=15 ===
10439:             par_oPage.AddObject("lbl_4c_Label16", "Label")
10440:             WITH par_oPage.lbl_4c_Label16
10441:                 .Top       = 194
10442:                 .Left      = 138
10443:                 .Width     = 63
10444:                 .Height    = 15
10445:                 .FontName  = "Tahoma"
10446:                 .FontSize  = 8
10447:                 .BackStyle = 0
10448:                 .Caption   = "Grupo C.C. :"
10449:                 .ForeColor = RGB(90,90,90)
10450:                 .Visible   = .T.
10451:             ENDWITH
10452: 
10453:             *-- === Say17: "Conta C.C. :" - top=189+29=218, left=138, w=63, h=15 ===
10454:             par_oPage.AddObject("lbl_4c_Label17", "Label")
10455:             WITH par_oPage.lbl_4c_Label17
10456:                 .Top       = 218
10457:                 .Left      = 138
10458:                 .Width     = 63
10459:                 .Height    = 15
10460:                 .FontName  = "Tahoma"
10461:                 .FontSize  = 8
10462:                 .BackStyle = 0
10463:                 .Caption   = "Conta C.C. :"
10464:                 .ForeColor = RGB(90,90,90)
10465:                 .Visible   = .T.
10466:             ENDWITH
10467: 
10468:             *-- === get_gruccus: top=161+29=190, left=206, w=80, h=23 ===
10469:             par_oPage.AddObject("txt_4c__gruccus", "TextBox")
10470:             WITH par_oPage.txt_4c__gruccus
10471:                 .Top            = 190
10472:                 .Left           = 206
10473:                 .Width          = 80
10474:                 .Height         = 23
10475:                 .FontName       = "Tahoma"
10476:                 .FontSize       = 8
10477:                 .SpecialEffect  = 1

*-- Linhas 10483 a 10506:
10483:             *-- === get_dgruccus: top=161+29=190, left=288, w=318, h=23 ===
10484:             par_oPage.AddObject("txt_4c__dgruccus", "TextBox")
10485:             WITH par_oPage.txt_4c__dgruccus
10486:                 .Top            = 190
10487:                 .Left           = 288
10488:                 .Width          = 318
10489:                 .Height         = 23
10490:                 .FontName       = "Tahoma"
10491:                 .FontSize       = 8
10492:                 .SpecialEffect  = 1
10493:                 .Themes         = .F.
10494:                 .Visible        = .T.
10495:             ENDWITH
10496: 
10497:             *-- === get_contaccus: top=186+29=215, left=206, w=80, h=23 ===
10498:             par_oPage.AddObject("txt_4c__contaccus", "TextBox")
10499:             WITH par_oPage.txt_4c__contaccus
10500:                 .Top            = 215
10501:                 .Left           = 206
10502:                 .Width          = 80
10503:                 .Height         = 23
10504:                 .FontName       = "Tahoma"
10505:                 .FontSize       = 8
10506:                 .SpecialEffect  = 1

*-- Linhas 10512 a 10549:
10512:             *-- === get_dcontaccus: top=186+29=215, left=288, w=318, h=23 ===
10513:             par_oPage.AddObject("txt_4c__dcontaccus", "TextBox")
10514:             WITH par_oPage.txt_4c__dcontaccus
10515:                 .Top            = 215
10516:                 .Left           = 288
10517:                 .Width          = 318
10518:                 .Height         = 23
10519:                 .FontName       = "Tahoma"
10520:                 .FontSize       = 8
10521:                 .SpecialEffect  = 1
10522:                 .Themes         = .F.
10523:                 .Visible        = .T.
10524:             ENDWITH
10525: 
10526:             *-- === Say1: "Classificacao Fiscal :" - top=216+29=245, left=102, w=99 ===
10527:             par_oPage.AddObject("lbl_4c_Label1", "Label")
10528:             WITH par_oPage.lbl_4c_Label1
10529:                 .Top       = 245
10530:                 .Left      = 102
10531:                 .Width     = 99
10532:                 .FontName  = "Tahoma"
10533:                 .FontSize  = 8
10534:                 .BackStyle = 0
10535:                 .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
10536:                 .ForeColor = RGB(90,90,90)
10537:                 .Visible   = .T.
10538:             ENDWITH
10539: 
10540:             *-- === getClfiscal: top=211+29=240, left=206, w=94, h=23, mask=9999.99.9999 ===
10541:             par_oPage.AddObject("txt_4c_Clfiscal", "TextBox")
10542:             WITH par_oPage.txt_4c_Clfiscal
10543:                 .Top            = 240
10544:                 .Left           = 206
10545:                 .Width          = 94
10546:                 .Height         = 23
10547:                 .FontName       = "Tahoma"
10548:                 .FontSize       = 8
10549:                 .SpecialEffect  = 1

*-- Linhas 10558 a 10567:
10558:             *-- === getDclfiscal: top=211+29=240, left=303, w=303, h=23 ===
10559:             par_oPage.AddObject("txt_4c_Dclfiscal", "TextBox")
10560:             WITH par_oPage.txt_4c_Dclfiscal
10561:                 .Top            = 240
10562:                 .Left           = 303
10563:                 .Width          = 303
10564:                 .Height         = 23
10565:                 .FontName       = "Tahoma"
10566:                 .FontSize       = 8
10567:                 .SpecialEffect  = 1

*-- Linhas 10573 a 10598:
10573:             ENDWITH
10574: 
10575:             *-- === Say2: "Origem da Mercadoria :" - top=241+29=270, left=87, w=114 ===
10576:             par_oPage.AddObject("lbl_4c_Label2", "Label")
10577:             WITH par_oPage.lbl_4c_Label2
10578:                 .Top       = 270
10579:                 .Left      = 87
10580:                 .Width     = 114
10581:                 .FontName  = "Tahoma"
10582:                 .FontSize  = 8
10583:                 .BackStyle = 0
10584:                 .Caption   = "Origem da Mercadoria :"
10585:                 .ForeColor = RGB(90,90,90)
10586:                 .Visible   = .T.
10587:             ENDWITH
10588: 
10589:             *-- === getOrigmerc: top=236+29=265, left=206, w=17, h=23 ===
10590:             par_oPage.AddObject("txt_4c_Origmerc", "TextBox")
10591:             WITH par_oPage.txt_4c_Origmerc
10592:                 .Top            = 265
10593:                 .Left           = 206
10594:                 .Width          = 17
10595:                 .Height         = 23
10596:                 .FontName       = "Tahoma"
10597:                 .FontSize       = 8
10598:                 .SpecialEffect  = 1

*-- Linhas 10605 a 10614:
10605:             *-- === getDorigmerc: top=236+29=265, left=226, w=380, h=23 ===
10606:             par_oPage.AddObject("txt_4c_Dorigmerc", "TextBox")
10607:             WITH par_oPage.txt_4c_Dorigmerc
10608:                 .Top            = 265
10609:                 .Left           = 226
10610:                 .Width          = 380
10611:                 .Height         = 23
10612:                 .FontName       = "Tahoma"
10613:                 .FontSize       = 8
10614:                 .SpecialEffect  = 1

*-- Linhas 10620 a 10645:
10620:             ENDWITH
10621: 
10622:             *-- === Say3: "Situacao Tributaria ICMS :" - top=266+29=295, left=74, w=127 ===
10623:             par_oPage.AddObject("lbl_4c_Label3", "Label")
10624:             WITH par_oPage.lbl_4c_Label3
10625:                 .Top       = 295
10626:                 .Left      = 74
10627:                 .Width     = 127
10628:                 .FontName  = "Tahoma"
10629:                 .FontSize  = 8
10630:                 .BackStyle = 0
10631:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
10632:                 .ForeColor = RGB(90,90,90)
10633:                 .Visible   = .T.
10634:             ENDWITH
10635: 
10636:             *-- === getSittricm: top=261+29=290, left=206, w=31, h=23 ===
10637:             par_oPage.AddObject("txt_4c_Sittricm", "TextBox")
10638:             WITH par_oPage.txt_4c_Sittricm
10639:                 .Top            = 290
10640:                 .Left           = 206
10641:                 .Width          = 31
10642:                 .Height         = 23
10643:                 .FontName       = "Tahoma"
10644:                 .FontSize       = 8
10645:                 .SpecialEffect  = 1

*-- Linhas 10652 a 10661:
10652:             *-- === getDsittricm: top=261+29=290, left=240, w=366, h=23 ===
10653:             par_oPage.AddObject("txt_4c_Dsittricm", "TextBox")
10654:             WITH par_oPage.txt_4c_Dsittricm
10655:                 .Top            = 290
10656:                 .Left           = 240
10657:                 .Width          = 366
10658:                 .Height         = 23
10659:                 .FontName       = "Tahoma"
10660:                 .FontSize       = 8
10661:                 .SpecialEffect  = 1

*-- Linhas 10667 a 10692:
10667:             ENDWITH
10668: 
10669:             *-- === Say6: "Codigo de Servicos para ICMS :" - top=291+29=320, left=48, w=153 ===
10670:             par_oPage.AddObject("lbl_4c_Label6", "Label")
10671:             WITH par_oPage.lbl_4c_Label6
10672:                 .Top       = 320
10673:                 .Left      = 48
10674:                 .Width     = 153
10675:                 .FontName  = "Tahoma"
10676:                 .FontSize  = 8
10677:                 .BackStyle = 0
10678:                 .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
10679:                 .ForeColor = RGB(90,90,90)
10680:                 .Visible   = .T.
10681:             ENDWITH
10682: 
10683:             *-- === Get_CodServs: top=286+29=315, left=206, w=38, h=23 ===
10684:             par_oPage.AddObject("txt_4c_Codigo", "TextBox")
10685:             WITH par_oPage.txt_4c_Codigo
10686:                 .Top            = 315
10687:                 .Left           = 206
10688:                 .Width          = 38
10689:                 .Height         = 23
10690:                 .FontName       = "Tahoma"
10691:                 .FontSize       = 8
10692:                 .SpecialEffect  = 1

*-- Linhas 10698 a 10724:
10698:             ENDWITH
10699: 
10700:             *-- === Say8: "Aliquota ICMS :" - top=291+29=320, left=250, w=76, h=15 ===
10701:             par_oPage.AddObject("lbl_4c_Label8", "Label")
10702:             WITH par_oPage.lbl_4c_Label8
10703:                 .Top       = 320
10704:                 .Left      = 250
10705:                 .Width     = 76
10706:                 .Height    = 15
10707:                 .FontName  = "Tahoma"
10708:                 .FontSize  = 8
10709:                 .BackStyle = 0
10710:                 .Caption   = "Al" + CHR(237) + "quota ICMS :"
10711:                 .ForeColor = RGB(90,90,90)
10712:                 .Visible   = .T.
10713:             ENDWITH
10714: 
10715:             *-- === getIcms: top=286+29=315, left=342, w=45, h=23 ===
10716:             par_oPage.AddObject("txt_4c_Icms", "TextBox")
10717:             WITH par_oPage.txt_4c_Icms
10718:                 .Top            = 315
10719:                 .Left           = 342
10720:                 .Width          = 45
10721:                 .Height         = 23
10722:                 .FontName       = "Tahoma"
10723:                 .FontSize       = 8
10724:                 .SpecialEffect  = 1

*-- Linhas 10730 a 10862:
10730:             ENDWITH
10731: 
10732:             *-- === Say4: "Tipo de Tributacao :" - top=291+29=320, left=395, w=98 ===
10733:             par_oPage.AddObject("lbl_4c_Label4", "Label")
10734:             WITH par_oPage.lbl_4c_Label4
10735:                 .Top       = 320
10736:                 .Left      = 395
10737:                 .Width     = 98
10738:                 .FontName  = "Tahoma"
10739:                 .FontSize  = 8
10740:                 .BackStyle = 0
10741:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
10742:                 .ForeColor = RGB(90,90,90)
10743:                 .Visible   = .T.
10744:             ENDWITH
10745: 
10746:             *-- === Get_TpTrib: top=286+29=315, left=513, w=38, h=23 ===
10747:             par_oPage.AddObject("txt_4c_TpTrib", "TextBox")
10748:             WITH par_oPage.txt_4c_TpTrib
10749:                 .Top            = 315
10750:                 .Left           = 513
10751:                 .Width          = 38
10752:                 .Height         = 23
10753:                 .FontName       = "Tahoma"
10754:                 .FontSize       = 8
10755:                 .SpecialEffect  = 1
10756:                 .MaxLength      = 4
10757:                 .Themes         = .F.
10758:                 .ControlSource  = "crSigCdPro.tptribs"
10759:                 .Visible        = .T.
10760:             ENDWITH
10761: 
10762:             *-- === Say41: "IAT :" - top=290+29=319, left=558, w=26, h=15 ===
10763:             par_oPage.AddObject("lbl_4c_Label41", "Label")
10764:             WITH par_oPage.lbl_4c_Label41
10765:                 .Top       = 319
10766:                 .Left      = 558
10767:                 .Width     = 26
10768:                 .Height    = 15
10769:                 .FontName  = "Tahoma"
10770:                 .FontSize  = 8
10771:                 .BackStyle = 0
10772:                 .Caption   = "IAT :"
10773:                 .ForeColor = RGB(90,90,90)
10774:                 .Visible   = .T.
10775:             ENDWITH
10776: 
10777:             *-- === getiat: top=286+29=315, left=589, w=17, h=23 ===
10778:             par_oPage.AddObject("txt_4c_Iat", "TextBox")
10779:             WITH par_oPage.txt_4c_Iat
10780:                 .Top            = 315
10781:                 .Left           = 589
10782:                 .Width          = 17
10783:                 .Height         = 23
10784:                 .FontName       = "Tahoma"
10785:                 .FontSize       = 8
10786:                 .SpecialEffect  = 1
10787:                 .MaxLength      = 1
10788:                 .Themes         = .F.
10789:                 .ControlSource  = "crSigCdPro.iats"
10790:                 .Visible        = .T.
10791:             ENDWITH
10792: 
10793:             *-- === Say42: "[A]rredondamento [T]runcamento" - top=290+29=319, left=609, w=165, h=15 ===
10794:             par_oPage.AddObject("lbl_4c_Label42", "Label")
10795:             WITH par_oPage.lbl_4c_Label42
10796:                 .Top       = 319
10797:                 .Left      = 609
10798:                 .Width     = 165
10799:                 .Height    = 15
10800:                 .FontName  = "Tahoma"
10801:                 .FontSize  = 8
10802:                 .BackStyle = 0
10803:                 .Caption   = "[A]rredondamento [T]runcamento"
10804:                 .ForeColor = RGB(90,90,90)
10805:                 .Visible   = .T.
10806:             ENDWITH
10807: 
10808:             *-- === Say5: "Situacao Tributaria IPI :" - top=316+29=345, left=85, w=116, h=15 ===
10809:             par_oPage.AddObject("lbl_4c_Label5", "Label")
10810:             WITH par_oPage.lbl_4c_Label5
10811:                 .Top       = 345
10812:                 .Left      = 85
10813:                 .Width     = 116
10814:                 .Height    = 15
10815:                 .FontName  = "Tahoma"
10816:                 .FontSize  = 8
10817:                 .BackStyle = 0
10818:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
10819:                 .ForeColor = RGB(90,90,90)
10820:                 .Visible   = .T.
10821:             ENDWITH
10822: 
10823:             *-- === cmbIpi: top=311+29=340, left=206, w=108, h=25 ===
10824:             par_oPage.AddObject("cbo_4c_CmbIpi", "ComboBox")
10825:             WITH par_oPage.cbo_4c_CmbIpi
10826:                 .Top            = 340
10827:                 .Left           = 206
10828:                 .Width          = 108
10829:                 .Height         = 25
10830:                 .FontName       = "Tahoma"
10831:                 .FontSize       = 8
10832:                 .SpecialEffect  = 1
10833:                 .Style          = 2
10834:                 .Themes         = .F.
10835:                 .Visible        = .T.
10836:             ENDWITH
10837: 
10838:             *-- === Say_AliqIPI: "Aliquota de IPI :" - top=316+29=345, left=327, w=80, h=15 ===
10839:             par_oPage.AddObject("lbl_4c__AliqIPI", "Label")
10840:             WITH par_oPage.lbl_4c__AliqIPI
10841:                 .Top       = 345
10842:                 .Left      = 327
10843:                 .Width     = 80
10844:                 .Height    = 15
10845:                 .FontName  = "Tahoma"
10846:                 .FontSize  = 8
10847:                 .BackStyle = 0
10848:                 .Caption   = "Al" + CHR(237) + "quota de IPI :"
10849:                 .ForeColor = RGB(90,90,90)
10850:                 .Visible   = .T.
10851:             ENDWITH
10852: 
10853:             *-- === Get_AliqIPI: top=311+29=340, left=425, w=45, h=25 ===
10854:             par_oPage.AddObject("txt_4c_AliqIPI", "TextBox")
10855:             WITH par_oPage.txt_4c_AliqIPI
10856:                 .Top            = 340
10857:                 .Left           = 425
10858:                 .Width          = 45
10859:                 .Height         = 25
10860:                 .FontName       = "Tahoma"
10861:                 .FontSize       = 8
10862:                 .SpecialEffect  = 1

*-- Linhas 10868 a 10894:
10868:             ENDWITH
10869: 
10870:             *-- === Say13: "Excecao da TIPI :" - top=316+29=345, left=495, w=87, h=15 ===
10871:             par_oPage.AddObject("lbl_4c_Label13", "Label")
10872:             WITH par_oPage.lbl_4c_Label13
10873:                 .Top       = 345
10874:                 .Left      = 495
10875:                 .Width     = 87
10876:                 .Height    = 15
10877:                 .FontName  = "Tahoma"
10878:                 .FontSize  = 8
10879:                 .BackStyle = 0
10880:                 .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
10881:                 .ForeColor = RGB(90,90,90)
10882:                 .Visible   = .T.
10883:             ENDWITH
10884: 
10885:             *-- === getextipi: top=311+29=340, left=601, w=35, h=25 ===
10886:             par_oPage.AddObject("txt_4c_Extipi", "TextBox")
10887:             WITH par_oPage.txt_4c_Extipi
10888:                 .Top            = 340
10889:                 .Left           = 601
10890:                 .Width          = 35
10891:                 .Height         = 25
10892:                 .FontName       = "Tahoma"
10893:                 .FontSize       = 8
10894:                 .SpecialEffect  = 1

*-- Linhas 10900 a 10967:
10900:             ENDWITH
10901: 
10902:             *-- === Say18: "Descricao Fiscal :" - top=341+29=370, left=117, w=84, h=15 ===
10903:             par_oPage.AddObject("lbl_4c_Label18", "Label")
10904:             WITH par_oPage.lbl_4c_Label18
10905:                 .Top       = 370
10906:                 .Left      = 117
10907:                 .Width     = 84
10908:                 .Height    = 15
10909:                 .FontName  = "Tahoma"
10910:                 .FontSize  = 8
10911:                 .BackStyle = 0
10912:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
10913:                 .ForeColor = RGB(90,90,90)
10914:                 .Visible   = .T.
10915:             ENDWITH
10916: 
10917:             *-- === btnDescFis: top=359+29=388, left=162, w=32, h=32 ===
10918:             par_oPage.AddObject("cmd_4c_BtnDescFis", "CommandButton")
10919:             WITH par_oPage.cmd_4c_BtnDescFis
10920:                 .Top      = 388
10921:                 .Left     = 162
10922:                 .Width    = 32
10923:                 .Height   = 32
10924:                 .Caption  = ""
10925:                 .Themes   = .F.
10926:                 .Visible  = .T.
10927:             ENDWITH
10928: 
10929:             *-- === mgetdescfi: top=338+29=367, left=206, w=509, h=89 ===
10930:             par_oPage.AddObject("obj_4c_Mgetdescfi", "EditBox")
10931:             WITH par_oPage.obj_4c_Mgetdescfi
10932:                 .Top            = 367
10933:                 .Left           = 206
10934:                 .Width          = 509
10935:                 .Height         = 89
10936:                 .FontName       = "Tahoma"
10937:                 .FontSize       = 8
10938:                 .SpecialEffect  = 1
10939:                 .Themes         = .F.
10940:                 .ControlSource  = "crSigCdPro.descfis"
10941:                 .Visible        = .T.
10942:             ENDWITH
10943: 
10944:             *-- === Say9: "Valor do Grama Produzido" - top=320+29=349, left=756, w=125, h=15 ===
10945:             par_oPage.AddObject("lbl_4c_Label9", "Label")
10946:             WITH par_oPage.lbl_4c_Label9
10947:                 .Top       = 349
10948:                 .Left      = 756
10949:                 .Width     = 125
10950:                 .Height    = 15
10951:                 .FontName  = "Tahoma"
10952:                 .FontSize  = 8
10953:                 .BackStyle = 0
10954:                 .Caption   = "Valor do Grama Produzido"
10955:                 .ForeColor = RGB(90,90,90)
10956:                 .Visible   = .T.
10957:             ENDWITH
10958: 
10959:             *-- === grdCmv: top=338+29=367, left=754, w=223, h=141, 3 colunas, ReadOnly ===
10960:             par_oPage.AddObject("grd_4c_Dados", "Grid")
10961:             par_oPage.grd_4c_Dados.Top         = 367
10962:             par_oPage.grd_4c_Dados.Left        = 754
10963:             par_oPage.grd_4c_Dados.Width       = 223
10964:             par_oPage.grd_4c_Dados.Height      = 141
10965:             par_oPage.grd_4c_Dados.ColumnCount = 3
10966:             par_oPage.grd_4c_Dados.FontName    = "Tahoma"
10967:             par_oPage.grd_4c_Dados.FontSize    = 8

*-- Linhas 10976 a 11063:
10976: 
10977:             par_oPage.grd_4c_Dados.RecordSource = "cursor_4c_Cmv"
10978: 
10979:             par_oPage.grd_4c_Dados.Column1.Header1.Caption  = "Per" + CHR(237) + "odo"
10980:             par_oPage.grd_4c_Dados.Column1.ControlSource    = "cursor_4c_Cmv.Periodo"
10981:             par_oPage.grd_4c_Dados.Column1.Width            = 59
10982:             par_oPage.grd_4c_Dados.Column1.ReadOnly         = .T.
10983:             par_oPage.grd_4c_Dados.Column1.Movable          = .F.
10984:             par_oPage.grd_4c_Dados.Column1.Resizable        = .F.
10985:             par_oPage.grd_4c_Dados.Column1.FontName         = "Tahoma"
10986:             par_oPage.grd_4c_Dados.Column1.FontSize         = 8
10987:             par_oPage.grd_4c_Dados.Column1.Header1.FontBold = .T.
10988:             par_oPage.grd_4c_Dados.Column1.Header1.Alignment = 2
10989: 
10990:             par_oPage.grd_4c_Dados.Column2.Header1.Caption  = "Valor Custo GR"
10991:             par_oPage.grd_4c_Dados.Column2.ControlSource    = "cursor_4c_Cmv.ValGR"
10992:             par_oPage.grd_4c_Dados.Column2.Width            = 100
10993:             par_oPage.grd_4c_Dados.Column2.ReadOnly         = .T.
10994:             par_oPage.grd_4c_Dados.Column2.Movable          = .F.
10995:             par_oPage.grd_4c_Dados.Column2.Resizable        = .F.
10996:             par_oPage.grd_4c_Dados.Column2.FontName         = "Tahoma"
10997:             par_oPage.grd_4c_Dados.Column2.FontSize         = 8
10998:             par_oPage.grd_4c_Dados.Column2.Header1.FontBold = .T.
10999:             par_oPage.grd_4c_Dados.Column2.Header1.Alignment = 2
11000: 
11001:             par_oPage.grd_4c_Dados.Column3.Header1.Caption  = "Moe"
11002:             par_oPage.grd_4c_Dados.Column3.ControlSource    = "cursor_4c_Cmv.Moe"
11003:             par_oPage.grd_4c_Dados.Column3.Width            = 31
11004:             par_oPage.grd_4c_Dados.Column3.ReadOnly         = .T.
11005:             par_oPage.grd_4c_Dados.Column3.FontName         = "Tahoma"
11006:             par_oPage.grd_4c_Dados.Column3.Header1.FontBold = .T.
11007:             par_oPage.grd_4c_Dados.Column3.Header1.Alignment = 2
11008: 
11009:             *-- === Say12: "Descricao ECF :" - top=433+29=462, left=124, w=77, h=15 ===
11010:             par_oPage.AddObject("lbl_4c_Label12", "Label")
11011:             WITH par_oPage.lbl_4c_Label12
11012:                 .Top       = 462
11013:                 .Left      = 124
11014:                 .Width     = 77
11015:                 .Height    = 15
11016:                 .FontName  = "Tahoma"
11017:                 .FontSize  = 8
11018:                 .BackStyle = 0
11019:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
11020:                 .ForeColor = RGB(90,90,90)
11021:                 .Visible   = .T.
11022:             ENDWITH
11023: 
11024:             *-- === getDescEcfs: top=429+29=458, left=206, w=213, h=23 ===
11025:             par_oPage.AddObject("txt_4c_DescEcfs", "TextBox")
11026:             WITH par_oPage.txt_4c_DescEcfs
11027:                 .Top            = 458
11028:                 .Left           = 206
11029:                 .Width          = 213
11030:                 .Height         = 23
11031:                 .FontName       = "Tahoma"
11032:                 .FontSize       = 8
11033:                 .SpecialEffect  = 1
11034:                 .MaxLength      = 29
11035:                 .Themes         = .F.
11036:                 .ControlSource  = "crSigCdPro.descecfs"
11037:                 .Visible        = .T.
11038:             ENDWITH
11039: 
11040:             *-- === Say11: "Metal :" - top=433+29=462, left=494, w=35 ===
11041:             par_oPage.AddObject("lbl_4c_Label11", "Label")
11042:             WITH par_oPage.lbl_4c_Label11
11043:                 .Top       = 462
11044:                 .Left      = 494
11045:                 .Width     = 35
11046:                 .FontName  = "Tahoma"
11047:                 .FontSize  = 8
11048:                 .BackStyle = 0
11049:                 .Caption   = "Metal :"
11050:                 .ForeColor = RGB(90,90,90)
11051:                 .Visible   = .T.
11052:             ENDWITH
11053: 
11054:             *-- === Get_metal: top=429+29=458, left=537, w=24, h=23 ===
11055:             par_oPage.AddObject("txt_4c_Metal", "TextBox")
11056:             WITH par_oPage.txt_4c_Metal
11057:                 .Top            = 458
11058:                 .Left           = 537
11059:                 .Width          = 24
11060:                 .Height         = 23
11061:                 .FontName       = "Tahoma"
11062:                 .FontSize       = 8
11063:                 .SpecialEffect  = 1

*-- Linhas 11069 a 11078:
11069:             *-- === Get_DesMetal: top=429+29=458, left=564, w=150, h=23 ===
11070:             par_oPage.AddObject("txt_4c_DesMetal", "TextBox")
11071:             WITH par_oPage.txt_4c_DesMetal
11072:                 .Top            = 458
11073:                 .Left           = 564
11074:                 .Width          = 150
11075:                 .Height         = 23
11076:                 .FontName       = "Tahoma"
11077:                 .FontSize       = 8
11078:                 .SpecialEffect  = 1

*-- Linhas 11085 a 11111:
11085:             ENDWITH
11086: 
11087:             *-- === Say7: "Valor Estimado :" - top=458+29=487, left=122, w=79, h=15 ===
11088:             par_oPage.AddObject("lbl_4c_Label7", "Label")
11089:             WITH par_oPage.lbl_4c_Label7
11090:                 .Top       = 487
11091:                 .Left      = 122
11092:                 .Width     = 79
11093:                 .Height    = 15
11094:                 .FontName  = "Tahoma"
11095:                 .FontSize  = 8
11096:                 .BackStyle = 0
11097:                 .Caption   = "Valor Estimado :"
11098:                 .ForeColor = RGB(90,90,90)
11099:                 .Visible   = .T.
11100:             ENDWITH
11101: 
11102:             *-- === getValor: top=454+29=483, left=206, w=108, h=23 ===
11103:             par_oPage.AddObject("txt_4c_Valor", "TextBox")
11104:             WITH par_oPage.txt_4c_Valor
11105:                 .Top            = 483
11106:                 .Left           = 206
11107:                 .Width          = 108
11108:                 .Height         = 23
11109:                 .FontName       = "Tahoma"
11110:                 .FontSize       = 8
11111:                 .SpecialEffect  = 1

*-- Linhas 11119 a 11158:
11119:             *-- === GetMvalor: top=454+29=483, left=317, w=31, h=23 ===
11120:             par_oPage.AddObject("txt_4c_Mvalor", "TextBox")
11121:             WITH par_oPage.txt_4c_Mvalor
11122:                 .Top            = 483
11123:                 .Left           = 317
11124:                 .Width          = 31
11125:                 .Height         = 23
11126:                 .FontName       = "Tahoma"
11127:                 .FontSize       = 8
11128:                 .SpecialEffect  = 1
11129:                 .MaxLength      = 3
11130:                 .Themes         = .F.
11131:                 .ControlSource  = "crSigCdPro.moedas"
11132:                 .Visible        = .T.
11133:             ENDWITH
11134: 
11135:             *-- === Say15: "Teor :" - top=458+29=487, left=498, w=31 ===
11136:             par_oPage.AddObject("lbl_4c_Label15", "Label")
11137:             WITH par_oPage.lbl_4c_Label15
11138:                 .Top       = 487
11139:                 .Left      = 498
11140:                 .Width     = 31
11141:                 .FontName  = "Tahoma"
11142:                 .FontSize  = 8
11143:                 .BackStyle = 0
11144:                 .Caption   = "Teor :"
11145:                 .ForeColor = RGB(90,90,90)
11146:                 .Visible   = .T.
11147:             ENDWITH
11148: 
11149:             *-- === Get_teor: top=454+29=483, left=537, w=24, h=23 ===
11150:             par_oPage.AddObject("txt_4c_Teor", "TextBox")
11151:             WITH par_oPage.txt_4c_Teor
11152:                 .Top            = 483
11153:                 .Left           = 537
11154:                 .Width          = 24
11155:                 .Height         = 23
11156:                 .FontName       = "Tahoma"
11157:                 .FontSize       = 8
11158:                 .SpecialEffect  = 1

*-- Linhas 11164 a 11173:
11164:             *-- === Get_DesTeor: top=454+29=483, left=564, w=150, h=23 ===
11165:             par_oPage.AddObject("txt_4c_DesTeor", "TextBox")
11166:             WITH par_oPage.txt_4c_DesTeor
11167:                 .Top            = 483
11168:                 .Left           = 564
11169:                 .Width          = 150
11170:                 .Height         = 23
11171:                 .FontName       = "Tahoma"
11172:                 .FontSize       = 8
11173:                 .SpecialEffect  = 1

*-- Linhas 11180 a 11206:
11180:             ENDWITH
11181: 
11182:             *-- === Say10: "IPPT/CST :" - top=483+29=512, left=147, w=54, h=15 ===
11183:             par_oPage.AddObject("lbl_4c_Label10", "Label")
11184:             WITH par_oPage.lbl_4c_Label10
11185:                 .Top       = 512
11186:                 .Left      = 147
11187:                 .Width     = 54
11188:                 .Height    = 15
11189:                 .FontName  = "Tahoma"
11190:                 .FontSize  = 8
11191:                 .BackStyle = 0
11192:                 .Caption   = "IPPT/CST :"
11193:                 .ForeColor = RGB(90,90,90)
11194:                 .Visible   = .T.
11195:             ENDWITH
11196: 
11197:             *-- === getIPPTCST: top=479+29=508, left=206, w=108, h=23, ReadOnly ===
11198:             par_oPage.AddObject("txt_4c_IPPTCST", "TextBox")
11199:             WITH par_oPage.txt_4c_IPPTCST
11200:                 .Top            = 508
11201:                 .Left           = 206
11202:                 .Width          = 108
11203:                 .Height         = 23
11204:                 .FontName       = "Tahoma"
11205:                 .FontSize       = 8
11206:                 .SpecialEffect  = 1

*-- Linhas 11351 a 11364:
11351:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11352:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11353:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11354:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11355:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11356:             ELSE
11357:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11358:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11359:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11360:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11361:             ENDIF
11362:             IF USED("cursor_4c_BuscaClf")
11363:                 USE IN cursor_4c_BuscaClf
11364:             ENDIF

*-- Linhas 11397 a 11410:
11397:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11398:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11399:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11400:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11401:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11402:             ELSE
11403:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11404:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11405:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11406:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11407:             ENDIF
11408:             IF USED("cursor_4c_BuscaClf")
11409:                 USE IN cursor_4c_BuscaClf
11410:             ENDIF

*-- Linhas 11916 a 11944:
11916:             )
11917:             SET NULL OFF
11918: 
11919:             *-- === lbl_4c_ObsTar (Say31): top=144+29=173, left=583, w=126, h=15 ===
11920:             par_oPage.AddObject("lbl_4c_ObsTar", "Label")
11921:             WITH par_oPage.lbl_4c_ObsTar
11922:                 .Top       = 173
11923:                 .Left      = 583
11924:                 .Width     = 126
11925:                 .Height    = 15
11926:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
11927:                 .FontName  = "Tahoma"
11928:                 .FontSize  = 8
11929:                 .AutoSize  = .F.
11930:                 .BackStyle = 0
11931:                 .ForeColor = RGB(0, 0, 0)
11932:                 .Visible   = .T.
11933:             ENDWITH
11934: 
11935:             *-- === grd_4c_Designer (grdDesigner): top=160+29=189, left=10, w=495, h=238 ===
11936:             par_oPage.AddObject("grd_4c_Designer", "Grid")
11937:             loc_oGrd = par_oPage.grd_4c_Designer
11938:             loc_oGrd.Top         = 189
11939:             loc_oGrd.Left        = 10
11940:             loc_oGrd.Width       = 495
11941:             loc_oGrd.Height      = 238
11942:             loc_oGrd.ColumnCount = 4
11943:             loc_oGrd.FontName    = "Tahoma"
11944:             loc_oGrd.FontSize    = 8

*-- Linhas 11952 a 12020:
11952: 
11953:             loc_oGrd.RecordSource = "crSigPrTar"
11954: 
11955:             loc_oGrd.Column1.Header1.Caption  = "Data de In" + CHR(237) + "cio"
11956:             loc_oGrd.Column1.ControlSource    = "crSigPrTar.DtInis"
11957:             loc_oGrd.Column1.Width            = 110
11958:             loc_oGrd.Column1.ReadOnly         = .T.
11959:             loc_oGrd.Column1.Header1.FontBold = .T.
11960: 
11961:             loc_oGrd.Column2.Header1.Caption  = "Data de Conclus" + CHR(227) + "o"
11962:             loc_oGrd.Column2.ControlSource    = "crSigPrTar.DtFims"
11963:             loc_oGrd.Column2.Width            = 120
11964:             loc_oGrd.Column2.ReadOnly         = .T.
11965:             loc_oGrd.Column2.Header1.FontBold = .T.
11966: 
11967:             loc_oGrd.Column3.Header1.Caption  = "Usu" + CHR(225) + "rio"
11968:             loc_oGrd.Column3.ControlSource    = "crSigPrTar.Usuars"
11969:             loc_oGrd.Column3.Width            = 100
11970:             loc_oGrd.Column3.ReadOnly         = .T.
11971:             loc_oGrd.Column3.Header1.FontBold = .T.
11972: 
11973:             loc_oGrd.Column4.Header1.Caption  = "Tarefa"
11974:             loc_oGrd.Column4.ControlSource    = "crSigPrTar.Tarefas"
11975:             loc_oGrd.Column4.Width            = 165
11976:             loc_oGrd.Column4.ReadOnly         = .T.
11977:             loc_oGrd.Column4.Header1.FontBold = .T.
11978: 
11979:             *-- BINDEVENTs para grd_4c_Designer
11980:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "DesignerAfterRowColChange")
11981:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "DesignerCol4KeyPress")
11982: 
11983:             *-- === cmd_4c_BtnIniTarefa (btnIniTarefa): top=161+29=190, left=509, w=42, h=42 ===
11984:             par_oPage.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
11985:             WITH par_oPage.cmd_4c_BtnIniTarefa
11986:                 .Top     = 190
11987:                 .Left    = 509
11988:                 .Width   = 42
11989:                 .Height  = 42
11990:                 .Caption = ""
11991:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
11992:                 .Themes  = .F.
11993:                 .Visible = .T.
11994:             ENDWITH
11995:             BINDEVENT(par_oPage.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
11996: 
11997:             *-- === cmd_4c_BtnFimTarefa (btnFimTarefa): top=203+29=232, left=509, w=42, h=42 ===
11998:             par_oPage.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
11999:             WITH par_oPage.cmd_4c_BtnFimTarefa
12000:                 .Top     = 232
12001:                 .Left    = 509
12002:                 .Width   = 42
12003:                 .Height  = 42
12004:                 .Caption = ""
12005:                 .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
12006:                 .Themes  = .F.
12007:                 .Visible = .T.
12008:             ENDWITH
12009:             BINDEVENT(par_oPage.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
12010: 
12011:             *-- === obj_4c_GetObsTarefas (getObsTarefas): top=160+29=189, left=584, w=407, h=238 ===
12012:             par_oPage.AddObject("obj_4c_GetObsTarefas", "EditBox")
12013:             WITH par_oPage.obj_4c_GetObsTarefas
12014:                 .Top         = 189
12015:                 .Left        = 584
12016:                 .Width       = 407
12017:                 .Height      = 238
12018:                 .ControlSource = "crSigPrTar.ObsTars"
12019:                 .FontName    = "Tahoma"
12020:                 .FontSize    = 8

*-- Linhas 12027 a 12049:
12027:             *-- === shp_4c_Shape1 (Shape1): top=415+29=444, left=584, w=407, h=202 ===
12028:             par_oPage.AddObject("shp_4c_Shape1", "Shape")
12029:             WITH par_oPage.shp_4c_Shape1
12030:                 .Top         = 444
12031:                 .Left        = 584
12032:                 .Width       = 407
12033:                 .Height      = 202
12034:                 .BackColor   = RGB(255, 255, 255)
12035:                 .BackStyle   = 1
12036:                 .BorderStyle = 1
12037:                 .Visible     = .T.
12038:             ENDWITH
12039: 
12040:             *-- === grd_4c_Arquivos (grdArquivos): top=415+29=444, left=10, w=495, h=202 ===
12041:             par_oPage.AddObject("grd_4c_Arquivos", "Grid")
12042:             loc_oGrdArq = par_oPage.grd_4c_Arquivos
12043:             loc_oGrdArq.Top         = 444
12044:             loc_oGrdArq.Left        = 10
12045:             loc_oGrdArq.Width       = 495
12046:             loc_oGrdArq.Height      = 202
12047:             loc_oGrdArq.ColumnCount = 1
12048:             loc_oGrdArq.FontName    = "Tahoma"
12049:             loc_oGrdArq.FontSize    = 8

*-- Linhas 12057 a 12120:
12057: 
12058:             loc_oGrdArq.RecordSource = "crSigPrArq"
12059: 
12060:             loc_oGrdArq.Column1.Header1.Caption  = "Arquivos Para Designer"
12061:             loc_oGrdArq.Column1.ControlSource    = "crSigPrArq.Arquivos"
12062:             loc_oGrdArq.Column1.Width            = 495
12063:             loc_oGrdArq.Column1.ReadOnly         = .T.
12064:             loc_oGrdArq.Column1.Header1.FontBold = .T.
12065: 
12066:             *-- BINDEVENTs para grd_4c_Arquivos
12067:             BINDEVENT(loc_oGrdArq, "AfterRowColChange", THIS, "ArquivosAfterRowColChange")
12068: 
12069:             *-- === cmd_4c_BtnInsArqs (btnInsArqs): top=416+29=445, left=509, w=42, h=42 ===
12070:             par_oPage.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
12071:             WITH par_oPage.cmd_4c_BtnInsArqs
12072:                 .Top     = 445
12073:                 .Left    = 509
12074:                 .Width   = 42
12075:                 .Height  = 42
12076:                 .Caption = ""
12077:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
12078:                 .Themes  = .F.
12079:                 .Visible = .T.
12080:             ENDWITH
12081:             BINDEVENT(par_oPage.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
12082: 
12083:             *-- === cmd_4c_BtnExcArqs (btnExcArqs): top=458+29=487, left=509, w=42, h=42 ===
12084:             par_oPage.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
12085:             WITH par_oPage.cmd_4c_BtnExcArqs
12086:                 .Top     = 487
12087:                 .Left    = 509
12088:                 .Width   = 42
12089:                 .Height  = 42
12090:                 .Caption = ""
12091:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
12092:                 .Themes  = .F.
12093:                 .Visible = .T.
12094:             ENDWITH
12095:             BINDEVENT(par_oPage.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
12096: 
12097:             *-- === cmd_4c_BtnOpnArqs (btnOpnArqs): top=500+29=529, left=509, w=42, h=42 ===
12098:             par_oPage.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
12099:             WITH par_oPage.cmd_4c_BtnOpnArqs
12100:                 .Top     = 529
12101:                 .Left    = 509
12102:                 .Width   = 42
12103:                 .Height  = 42
12104:                 .Caption = ""
12105:                 .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
12106:                 .Themes  = .F.
12107:                 .Visible = .T.
12108:             ENDWITH
12109:             BINDEVENT(par_oPage.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
12110: 
12111:             *-- === img_4c_ImgArqJpg (imgArqJpg): top=417+29=446, left=586, w=403, h=198 ===
12112:             par_oPage.AddObject("img_4c_ImgArqJpg", "Image")
12113:             WITH par_oPage.img_4c_ImgArqJpg
12114:                 .Top     = 446
12115:                 .Left    = 586
12116:                 .Width   = 403
12117:                 .Height  = 198
12118:                 .Stretch = 2
12119:                 .Visible = .F.
12120:             ENDWITH


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos (SigCdPro)
* Gerado: Fase 8/8 - Completo, tabela SigCdPro
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros       = ""    && CPros  char(14) - PK: codigo do produto
    *-- Descricoes
    this_cDpros       = ""    && DPros  - descricao principal
    this_cDPro2s      = ""    && DPro2s - descricao secundaria
    this_cDPro3s      = ""    && DPro3s - descricao memo (editbox)
    *-- Grupo / Subgrupo
    this_cCgrus       = ""    && CGrus  - codigo do grupo
    this_cSGrus       = ""    && SGrus  - codigo do subgrupo
    *-- Fornecedor / Referencia / Colecao
    this_cIFors       = ""    && IFors  - codigo do fornecedor
    this_cReffs       = ""    && Reffs  - referencia do fornecedor
    this_cColecoes    = ""    && Colecoes - colecao
    *-- Codigos auxiliares
    this_cCbars       = ""    && Cbars    - codigo de barras
    this_cEAN13       = ""    && EAN13    - EAN-13 (se campo separado)
    this_cCProEqs     = ""    && CProEqs  - produto equivalente
    this_cIdeCPros    = ""    && IdeCPros - identificador
    this_cMercs       = ""    && Mercs    - mercadoria
    *-- Linha / Colecao
    this_cLins        = ""    && Lins     - codigo da linha
    this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
    *-- Unidades
    this_cCUnis       = ""    && CUnis    - unidade 1
    this_cCUnips      = ""    && CUnips   - unidade 2
    *-- Dimensoes
    this_nAlturas     = 0     && Alturas
    this_nLarguras    = 0     && Larguras
    this_nDiametros   = 0     && Diametros
    this_nEspessuras  = 0     && Espessuras
    this_nCompriments = 0     && Compriments
    this_nPesoMs      = 0     && PesoMs      - peso base
    this_nPesoBs      = 0     && PesoBs      - peso bruto
    this_nPesoPmedios = 0     && PesoPmedios - peso medio
    *-- Classificacoes
    this_cTams        = ""    && Tams     - tamanho
    this_cCorPros     = ""    && CorPros  - cor
    this_cCodFinPs    = ""    && CodFinPs - finalidade
    this_cCodAcbs     = ""    && CodAcbs  - acabamento
    this_cLocals      = ""    && Locals   - local
    this_cClasss      = ""    && Classs   - classificacao
    *-- Precos e moedas
    this_nPvens       = 0     && Pvens    - preco de venda
    this_cMoevs       = ""    && Moevs    - moeda venda
    this_nFvendas     = 0     && Fvendas  - fator venda
    this_cMfvendas    = ""    && Mfvendas - moeda fator venda
    this_nCustofs     = 0     && Custofs  - custo
    this_cMoecs       = ""    && Moecs    - moeda custo
    this_nMargems     = 0     && Margems  - margem
    this_nPcuss       = 0     && Pcuss    - preco custo unitario
    this_cMoePcs      = ""    && MoePcs   - moeda preco custo
    this_nFcustos     = 0     && Fcustos  - fator custo
    this_nPFTioCs     = 0     && PFTioCs  - feitio custo
    this_nPFTios      = 0     && PFTios   - feitio venda
    *-- Quantidades e lotes
    this_nQmins       = 0     && Qmins    - quantidade minima
    this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
    this_nConjuntos   = 0     && Conjuntos - conjunto
    this_nQtPeds      = 0     && QtPeds   - quantidade pedido
    *-- Flags booleanos (armazenados como INT 0/1)
    this_nGarVits     = 0     && GarVits     - garantia vitrine
    this_nConsigs     = 0     && Consigs     - consignado
    this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
    this_nEncoms      = 0     && Encoms      - encomenda
    this_nProdWebs    = 0     && ProdWebs    - produto web
    this_nOpcVars     = 0     && OpcVars     - opcao variacao
    this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
    *-- Status e situacao
    this_nSituas      = 0     && Situas  - situacao
    this_dDtSituas    = {}    && DtSituas - data situacao
    *-- Observacoes
    this_cObs1s       = ""    && Obs1s
    this_cObs2s       = ""    && Obs2s
    this_cObs3s       = ""    && Obs3s
    this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
    this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
    *-- Campos customizados
    this_cFwget3s     = ""    && Fwget3s
    this_cFwget4s     = ""    && Fwget4s
    this_cFwget5s     = ""    && Fwget5s
    this_cFwget6s     = ""    && Fwget6s
    this_cCodIdents   = ""    && CodIdents
    this_cTEnts       = ""    && TEnts  - tipo entrada
    this_nDiasGars    = 0     && DiasGars - dias de garantia
    *-- Campos FaseP (Fase P - dados de processo)
    this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao
    this_cCodGarras   = ""    && CodGarras  - codigo de garras
    this_cConquilhas  = ""    && Conquilhas - conquilha padrao
    this_nPesoBris    = 0     && PesoBris   - peso brilhante
    this_nPesoMetal   = 0     && PesoMetal  - peso metal
    this_nPesoPdrs    = 0     && PesoPdrs   - peso pedra
    this_nCravCers    = 0     && CravCers   - cravacao em cera (0/1)
    this_nVarias      = 0     && Varias     - peso variavel (0/1)
    *-- Estoque e auditoria (somente leitura)
    this_nEstoques    = 0     && Estoques
    this_nQtdEsts     = 0     && QtdEsts
    this_dDtIncs      = {}    && DtIncs  - data de inclusao
    this_dDataAlts    = {}    && DataAlts - data alteracao
    this_cHoraAlts    = ""    && HoraAlts - hora alteracao
    this_cUsuaIncs    = ""    && UsuaIncs - usuario inclusao
    this_cUsuaAlts    = ""    && UsuaAlts - usuario alteracao
    this_dDtucps      = {}    && Dtucps  - data ult. compra
    this_nVucps       = 0     && Vucps   - valor ult. compra
    this_cMucps       = ""    && Mucps   - moeda ult. compra
    this_nQtdUltComps = 0     && QtdUltComps - qtd ult. compra

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCpros       = TratarNulo(CPros,       "C")
                THIS.this_cDpros       = TratarNulo(DPros,       "C")
                THIS.this_cDPro2s      = TratarNulo(DPro2s,      "C")
                THIS.this_cDPro3s      = TratarNulo(DPro3s,      "C")
                THIS.this_cCgrus       = TratarNulo(CGrus,       "C")
                THIS.this_cSGrus       = TratarNulo(SGrus,       "C")
                THIS.this_cIFors       = TratarNulo(IFors,       "C")
                THIS.this_cReffs       = TratarNulo(Reffs,       "C")
                THIS.this_cColecoes    = TratarNulo(Colecoes,    "C")
                THIS.this_cCbars       = TratarNulo(Cbars,       "C")
                THIS.this_cCProEqs     = TratarNulo(CProEqs,     "C")
                THIS.this_cIdeCPros    = TratarNulo(IdeCPros,    "C")
                THIS.this_cMercs       = TratarNulo(Mercs,       "C")
                THIS.this_cLins        = TratarNulo(Lins,        "C")
                THIS.this_cCols        = TratarNulo(Cols,        "C")
                THIS.this_cCUnis       = TratarNulo(CUnis,       "C")
                THIS.this_cCUnips      = TratarNulo(CUnips,      "C")
                THIS.this_nAlturas     = TratarNulo(Alturas,     "N")
                THIS.this_nLarguras    = TratarNulo(Larguras,    "N")
                THIS.this_nDiametros   = TratarNulo(Diametros,   "N")
                THIS.this_nEspessuras  = TratarNulo(Espessuras,  "N")
                THIS.this_nCompriments = TratarNulo(Compriments, "N")
                THIS.this_nPesoMs      = TratarNulo(PesoMs,      "N")
                THIS.this_nPesoBs      = TratarNulo(PesoBs,      "N")
                THIS.this_nPesoPmedios = TratarNulo(PesoPmedios, "N")
                THIS.this_cTams        = TratarNulo(Tams,        "C")
                THIS.this_cCorPros     = TratarNulo(CorPros,     "C")
                THIS.this_cCodFinPs    = TratarNulo(CodFinPs,    "C")
                THIS.this_cCodAcbs     = TratarNulo(CodAcbs,     "C")
                THIS.this_cLocals      = TratarNulo(Locals,      "C")
                THIS.this_cClasss      = TratarNulo(Classs,      "C")
                THIS.this_nPvens       = TratarNulo(Pvens,       "N")
                THIS.this_cMoevs       = TratarNulo(Moevs,       "C")
                THIS.this_nFvendas     = TratarNulo(Fvendas,     "N")
                THIS.this_cMfvendas    = TratarNulo(Mfvendas,    "C")
                THIS.this_nCustofs     = TratarNulo(Custofs,     "N")
                THIS.this_cMoecs       = TratarNulo(Moecs,       "C")
                THIS.this_nMargems     = TratarNulo(Margems,     "N")
                THIS.this_nQmins       = TratarNulo(Qmins,       "N")
                THIS.this_nLtMinsVs    = TratarNulo(LtMinsVs,    "N")
                THIS.this_nConjuntos   = TratarNulo(Conjuntos,   "N")
                THIS.this_nQtPeds      = TratarNulo(QtPeds,      "N")
                THIS.this_nGarVits     = TratarNulo(GarVits,     "N")
                THIS.this_nConsigs     = TratarNulo(Consigs,     "N")
                THIS.this_nFabrProprs  = TratarNulo(FabrProprs,  "N")
                THIS.this_nEncoms      = TratarNulo(Encoms,      "N")
                THIS.this_nProdWebs    = TratarNulo(ProdWebs,    "N")
                THIS.this_nOpcVars     = TratarNulo(OpcVars,     "N")
                THIS.this_nInstalas    = TratarNulo(Instalas,    "N")
                THIS.this_nSituas      = TratarNulo(Situas,      "N")
                THIS.this_dDtSituas    = TratarNulo(DtSituas,    "D")
                THIS.this_cObs1s       = TratarNulo(Obs1s,       "C")
                THIS.this_cObs2s       = TratarNulo(Obs2s,       "C")
                THIS.this_cObs3s       = TratarNulo(Obs3s,       "C")
                THIS.this_cDscCompras  = TratarNulo(DscCompras,  "C")
                THIS.this_cObsCompras  = TratarNulo(ObsCompras,  "C")
                THIS.this_cFwget3s     = TratarNulo(Fwget3s,     "C")
                THIS.this_cFwget4s     = TratarNulo(Fwget4s,     "C")
                THIS.this_cFwget5s     = TratarNulo(Fwget5s,     "C")
                THIS.this_cFwget6s     = TratarNulo(Fwget6s,     "C")
                THIS.this_cCodIdents   = TratarNulo(CodIdents,   "C")
                THIS.this_cTEnts       = TratarNulo(TEnts,       "C")
                THIS.this_nDiasGars    = TratarNulo(DiasGars,    "N")
                THIS.this_nQtMinFabs   = TratarNulo(QtMinFabs,   "N")
                THIS.this_cCodGarras   = TratarNulo(CodGarras,   "C")
                THIS.this_cConquilhas  = TratarNulo(Conquilhas,  "C")
                THIS.this_nPesoBris    = TratarNulo(PesoBris,    "N")
                THIS.this_nPesoMetal   = TratarNulo(PesoMetal,   "N")
                THIS.this_nPesoPdrs    = TratarNulo(PesoPdrs,    "N")
                THIS.this_nCravCers    = TratarNulo(CravCers,    "N")
                THIS.this_nVarias      = TratarNulo(Varias,      "N")
                THIS.this_nEstoques    = TratarNulo(Estoques,    "N")
                THIS.this_nQtdEsts     = TratarNulo(QtdEsts,     "N")
                THIS.this_dDtIncs      = TratarNulo(DtIncs,      "D")
                THIS.this_dDataAlts    = TratarNulo(DataAlts,    "D")
                THIS.this_cHoraAlts    = TratarNulo(HoraAlts,    "C")
                THIS.this_cUsuaIncs    = TratarNulo(UsuaIncs,    "C")
                THIS.this_cUsuaAlts    = TratarNulo(UsuaAlts,    "C")
                THIS.this_dDtucps      = TratarNulo(Dtucps,      "D")
                THIS.this_nVucps       = TratarNulo(Vucps,       "N")
                THIS.this_cMucps       = TratarNulo(Mucps,       "C")
                THIS.this_nQtdUltComps = TratarNulo(QtdUltComps, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto do cursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Busca o produto no banco pelo CPros
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_nRet, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCodigo) OR gnConnHandle <= 0
                loc_lSucesso = loc_lSucesso
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodigo), 14)), ;
                "cursor_4c_ProdutoBO")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ProdutoBO") > 0
                THIS.CarregarDoCursor("cursor_4c_ProdutoBO")
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna cursor com lista de produtos (filtro SQL WHERE opcional)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        TRY
            IF USED("cursor_4c_BuscarBO")
                USE IN cursor_4c_BuscarBO
            ENDIF
            loc_cSQL = "SELECT CPros, DPros, CGrus, SGrus, Reffs, " + ;
                       "UsuaAlts, CAST(ISNULL(Instalas,0) AS INT) AS Instalas " + ;
                       "FROM SigCdPro"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY CPros"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscarBO")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY
        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdPro (" + ;
                "CPros, DPros, DPro2s, CGrus, SGrus, IFors, Reffs, Colecoes, " + ;
                "Cbars, CProEqs, IdeCPros, Mercs, Lins, Cols, CUnis, CUnips, " + ;
                "Alturas, Larguras, Diametros, Espessuras, Compriments, " + ;
                "PesoMs, PesoBs, PesoPmedios, Tams, CorPros, CodFinPs, " + ;
                "CodAcbs, Locals, Classs, " + ;
                "Pvens, Moevs, Fvendas, Mfvendas, Custofs, Moecs, Margems, " + ;
                "Qmins, LtMinsVs, Conjuntos, QtPeds, DiasGars, " + ;
                "GarVits, Consigs, FabrProprs, Encoms, ProdWebs, OpcVars, Instalas, " + ;
                "Situas, DtSituas, Obs1s, Obs2s, Obs3s, DscCompras, ObsCompras, " + ;
                "Fwget3s, Fwget4s, Fwget5s, Fwget6s, CodIdents, TEnts, " + ;
                "QtMinFabs, CodGarras, Conquilhas, PesoBris, PesoMetal, PesoPdrs, CravCers, Varias, " + ;
                "DtIncs, UsuaIncs, DataAlts, UsuaAlts" + ;
                ") VALUES (" + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14)) + "," + ;
                EscaparSQL(THIS.this_cDpros) + "," + ;
                EscaparSQL(THIS.this_cDPro2s) + "," + ;
                EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                EscaparSQL(THIS.this_cIFors) + "," + ;
                EscaparSQL(THIS.this_cReffs) + "," + ;
                EscaparSQL(THIS.this_cColecoes) + "," + ;
                EscaparSQL(THIS.this_cCbars) + "," + ;
                EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                EscaparSQL(THIS.this_cMercs) + "," + ;
                EscaparSQL(THIS.this_cLins) + "," + ;
                EscaparSQL(THIS.this_cCols) + "," + ;
                EscaparSQL(THIS.this_cCUnis) + "," + ;
                EscaparSQL(THIS.this_cCUnips) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                EscaparSQL(THIS.this_cTams) + "," + ;
                EscaparSQL(THIS.this_cCorPros) + "," + ;
                EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cClasss) + "," + ;
                FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                EscaparSQL(THIS.this_cMoevs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                EscaparSQL(THIS.this_cMfvendas) + "," + ;
                FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                EscaparSQL(THIS.this_cMoecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                EscaparSQL(THIS.this_cObs1s) + "," + ;
                EscaparSQL(THIS.this_cObs2s) + "," + ;
                EscaparSQL(THIS.this_cObs3s) + "," + ;
                EscaparSQL(THIS.this_cDscCompras) + "," + ;
                EscaparSQL(THIS.this_cObsCompras) + "," + ;
                EscaparSQL(THIS.this_cFwget3s) + "," + ;
                EscaparSQL(THIS.this_cFwget4s) + "," + ;
                EscaparSQL(THIS.this_cFwget5s) + "," + ;
                EscaparSQL(THIS.this_cFwget6s) + "," + ;
                EscaparSQL(THIS.this_cCodIdents) + "," + ;
                EscaparSQL(THIS.this_cTEnts) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                EscaparSQL(THIS.this_cCodGarras) + "," + ;
                EscaparSQL(THIS.this_cConquilhas) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ;
                ")"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "DPros       = " + EscaparSQL(THIS.this_cDpros) + "," + ;
                "DPro2s      = " + EscaparSQL(THIS.this_cDPro2s) + "," + ;
                "CGrus       = " + EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                "SGrus       = " + EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                "IFors       = " + EscaparSQL(THIS.this_cIFors) + "," + ;
                "Reffs       = " + EscaparSQL(THIS.this_cReffs) + "," + ;
                "Colecoes    = " + EscaparSQL(THIS.this_cColecoes) + "," + ;
                "Cbars       = " + EscaparSQL(THIS.this_cCbars) + "," + ;
                "CProEqs     = " + EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                "IdeCPros    = " + EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
                "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
                "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
                "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
                "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
                "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
                "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
                "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
                "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;
                "Fvendas     = " + FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
                "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
                "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
                "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
                "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
                "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
                "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
                "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
                "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
                "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
                "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
                "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
                "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
                "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;
                "Conquilhas  = " + EscaparSQL(THIS.this_cConquilhas) + "," + ;
                "PesoBris    = " + FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                "PesoMetal   = " + FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                "PesoPdrs    = " + FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                "CravCers    = " + FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                "Varias      = " + FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "DataAlts    = GETDATE()," + ;
                "UsuaAlts    = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE CPros = " + EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdPro (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

