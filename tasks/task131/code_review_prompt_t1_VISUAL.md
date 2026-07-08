# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (16)
- [LAYOUT-POSITION] Controle 'TipoRelatorio' (parent: SIGREIR1): Top original=84 vs migrado 'obj_4c_TipoRelatorio' Top=4 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_codigo' (parent: SIGREIR1): Top original=186 vs migrado 'lbl_4c_Lbl_codigo' Top=106 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoDiferenca' (parent: SIGREIR1): Top original=237 vs migrado 'obj_4c_TipoDiferenca' Top=157 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGREIR1): Top original=261 vs migrado 'obj_4c_TipoLeitura' Top=181 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoAnalitico' (parent: SIGREIR1): Top original=157 vs migrado 'obj_4c_TipoAnalitico' Top=77 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optgTpCusto' (parent: SIGREIR1): Top original=284 vs migrado 'obj_4c_OptgTpCusto' Top=204 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optgTpVenda' (parent: SIGREIR1): Top original=284 vs migrado 'obj_4c_OptgTpVenda' Top=204 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblDescricao' (parent: SIGREIR1): Top original=314 vs migrado 'lbl_4c_LblDescricao' Top=234 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optgDescricao' (parent: SIGREIR1): Top original=308 vs migrado 'obj_4c_OptgDescricao' Top=228 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblBarras' (parent: SIGREIR1): Top original=266 vs migrado 'lbl_4c_LblBarras' Top=186 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblLocalizacao' (parent: SIGREIR1): Top original=314 vs migrado 'lbl_4c_LblLocalizacao' Top=234 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optgBarras' (parent: SIGREIR1): Top original=260 vs migrado 'obj_4c_OptgBarras' Top=180 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optgLocalizacao' (parent: SIGREIR1): Top original=308 vs migrado 'obj_4c_OptgLocalizacao' Top=228 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoOrdem' (parent: SIGREIR1): Top original=236 vs migrado 'obj_4c_TipoOrdem' Top=156 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblOrdem' (parent: SIGREIR1): Top original=242 vs migrado 'lbl_4c_LblOrdem' Top=162 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkImpImg' (parent: SIGREIR1): Top original=160 vs migrado 'chk_4c_ChkImpImg' Top=80 (diff=80px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIr1.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1688 linhas total):

*-- Linhas 63 a 71:
63:             SET DATE TO BRITISH
64:             SET CENTURY ON
65: 
66:             THIS.Caption = "Invent" + CHR(225) + "rio n" + CHR(186) + " " + TRANSFORM(THIS.this_nNumBalanco)
67: 
68:             IF TYPE("gc_4c_CaminhoIcones") = "U"
69:                 gc_4c_CaminhoIcones = ""
70:             ENDIF
71:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 81 a 90:
81:                 THIS.ConfigurarBotoes()
82:                 THIS.ConfigurarPageFrame()
83: 
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
86: 
87:                 THIS.ConfigurarPaginaLista()
88:                 THIS.ConfigurarPaginaDados()
89: 
90:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

*-- Linhas 117 a 155:
117:     PROTECTED PROCEDURE ConfigurarCabecalho()
118:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH THIS.cnt_4c_Cabecalho
120:             .Top         = 0
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackStyle   = 1
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128: 
129:             .AddObject("lbl_4c_Sombra", "Label")
130:             WITH .lbl_4c_Sombra
131:                 .Top       = 22
132:                 .Left      = 22
133:                 .Width     = THIS.Width
134:                 .Height    = 30
135:                 .Caption   = THIS.Caption
136:                 .FontName  = "Tahoma"
137:                 .FontSize  = 14
138:                 .FontBold  = .T.
139:                 .ForeColor = RGB(0, 0, 0)
140:                 .BackStyle = 0
141:                 .Visible   = .T.
142:             ENDWITH
143: 
144:             .AddObject("lbl_4c_Titulo", "Label")
145:             WITH .lbl_4c_Titulo
146:                 .Top       = 20
147:                 .Left      = 20
148:                 .Width     = THIS.Width
149:                 .Height    = 30
150:                 .Caption   = THIS.Caption
151:                 .FontName  = "Tahoma"
152:                 .FontSize  = 14
153:                 .FontBold  = .T.
154:                 .ForeColor = RGB(255, 255, 255)
155:                 .BackStyle = 0

*-- Linhas 164 a 189:
164:     PROTECTED PROCEDURE ConfigurarBotoes()
165:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
166:         WITH THIS.cmg_4c_Botoes
167:             .Top           = 0
168:             .Left          = 727
169:             .Width         = 273
170:             .Height        = 80
171:             .ButtonCount   = 4
172:             .BackStyle     = 0
173:             .BorderStyle   = 0
174:             .BorderColor   = RGB(136, 189, 188)
175:             .SpecialEffect = 1
176:             .Themes        = .F.
177:             .Visible       = .T.
178: 
179:             WITH .Buttons(1)
180:                 .Top             = 5
181:                 .Left            = 5
182:                 .Width           = 65
183:                 .Height          = 70
184:                 .Caption         = "Visualizar"
185:                 .FontBold        = .T.
186:                 .FontItalic      = .T.
187:                 .BackColor       = RGB(255, 255, 255)
188:                 .ForeColor       = RGB(90, 90, 90)
189:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 196 a 208:
196:             ENDWITH
197: 
198:             WITH .Buttons(2)
199:                 .Top             = 5
200:                 .Left            = 71
201:                 .Width           = 65
202:                 .Height          = 70
203:                 .Caption         = "Imprimir"
204:                 .FontName        = "Tahoma"
205:                 .FontSize        = 8
206:                 .FontBold        = .T.
207:                 .FontItalic      = .T.
208:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 217 a 229:
217:             ENDWITH
218: 
219:             WITH .Buttons(3)
220:                 .Top             = 5
221:                 .Left            = 137
222:                 .Width           = 65
223:                 .Height          = 70
224:                 .Caption         = "Excel"
225:                 .FontName        = "Tahoma"
226:                 .FontSize        = 8
227:                 .FontBold        = .T.
228:                 .FontItalic      = .T.
229:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 238 a 250:
238:             ENDWITH
239: 
240:             WITH .Buttons(4)
241:                 .Top             = 5
242:                 .Left            = 203
243:                 .Width           = 65
244:                 .Height          = 70
245:                 .Caption         = "Encerrar"
246:                 .Cancel          = .T.
247:                 .FontName        = "Tahoma"
248:                 .FontSize        = 8
249:                 .FontBold        = .T.
250:                 .FontItalic      = .T.

*-- Linhas 270 a 283:
270:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
271:         loc_oPgf = THIS.pgf_4c_Paginas
272:         loc_oPgf.PageCount = 1
273:         loc_oPgf.Top    = 85
274:         loc_oPgf.Left   = -1
275:         loc_oPgf.Width  = THIS.Width + 2
276:         loc_oPgf.Height = THIS.Height - 85
277:         loc_oPgf.Tabs   = .F.
278:         loc_oPgf.Page1.Caption   = "Filtros"
279:         loc_oPgf.Page1.FontName  = "Tahoma"
280:         loc_oPgf.Page1.FontSize  = 8
281:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
282:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
283:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 296 a 492:
296:         loc_oPg = THIS.pgf_4c_Paginas.Page1
297: 
298:         *-- Label "Relat" + CHR(243) + "rio :"
299:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
300:         WITH loc_oPg.lbl_4c_Label1
301:             .Top       = 8
302:             .Left      = 89
303:             .Width     = 58
304:             .Height    = 15
305:             .Caption   = "Relat" + CHR(243) + "rio :"
306:             .FontName  = "Tahoma"
307:             .FontSize  = 8
308:             .ForeColor = RGB(90, 90, 90)
309:             .BackStyle = 0
310:             .Visible   = .T.
311:         ENDWITH
312: 
313:         *-- OptionGroup TipoRelatorio (5 op" + CHR(231) + CHR(245) + "es)
314:         *   Original: top=84, left=140, width=245, height=62
315:         loc_oPg.AddObject("obj_4c_TipoRelatorio", "OptionGroup")
316:         loc_oPg.obj_4c_TipoRelatorio.ButtonCount = 5
317:         WITH loc_oPg.obj_4c_TipoRelatorio
318:             .Top           = 4
319:             .Left          = 140
320:             .Width         = 280
321:             .Height        = 62
322:             .BackStyle     = 0
323:             .BorderStyle   = 0
324:             .SpecialEffect = 1
325:             .Value         = 1
326:             .Visible       = .T.
327:         ENDWITH
328:         WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(1)
329:             .Caption   = "Resumo p/ Produto"
330:             .Left      = 5
331:             .Top       = 5
332:             .Width     = 115
333:             .Height    = 15
334:             .FontName  = "Tahoma"
335:             .FontSize  = 8
336:             .BackStyle = 0
337:             .ForeColor = RGB(90, 90, 90)
338:         ENDWITH
339:         WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(2)
340:             .Caption   = "Resumo Geral"
341:             .Left      = 156
342:             .Top       = 5
343:             .Width     = 100
344:             .Height    = 15
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .BackStyle = 0
348:             .ForeColor = RGB(90, 90, 90)
349:         ENDWITH
350:         WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(3)
351:             .Caption   = "Anal" + CHR(237) + "tico"
352:             .Left      = 5
353:             .Top       = 24
354:             .Width     = 65
355:             .Height    = 15
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .BackStyle = 0
359:             .ForeColor = RGB(90, 90, 90)
360:         ENDWITH
361:         WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(4)
362:             .Caption   = "Etiqueta"
363:             .Left      = 156
364:             .Top       = 24
365:             .Width     = 65
366:             .Height    = 15
367:             .FontName  = "Tahoma"
368:             .FontSize  = 8
369:             .BackStyle = 0
370:             .ForeColor = RGB(90, 90, 90)
371:         ENDWITH
372:         WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(5)
373:             .Caption   = "Estoque x Leitura"
374:             .Left      = 5
375:             .Top       = 43
376:             .Width     = 110
377:             .Height    = 15
378:             .FontName  = "Tahoma"
379:             .FontSize  = 8
380:             .BackStyle = 0
381:             .ForeColor = RGB(90, 90, 90)
382:         ENDWITH
383: 
384:         *-- Linha separadora (Shape3: top=150->70)
385:         loc_oPg.AddObject("shp_4c_Shape3", "Shape")
386:         WITH loc_oPg.shp_4c_Shape3
387:             .Top       = 70
388:             .Left      = 13
389:             .Height    = 2
390:             .Width     = 620
391:             .BackStyle = 0
392:             .Visible   = .T.
393:         ENDWITH
394: 
395:         *-- Label "Tipo :" (para TipoAnalitico) (top=162->82)
396:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
397:         WITH loc_oPg.lbl_4c_Label4
398:             .Top       = 82
399:             .Left      = 112
400:             .Width     = 35
401:             .Height    = 15
402:             .Caption   = "Tipo :"
403:             .FontName  = "Tahoma"
404:             .FontSize  = 8
405:             .ForeColor = RGB(90, 90, 90)
406:             .BackStyle = 0
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         *-- OptionGroup TipoAnalitico (2 op" + CHR(231) + CHR(245) + "es: Produto, Local)
411:         *   Original: top=157, left=141, width=133, height=25
412:         loc_oPg.AddObject("obj_4c_TipoAnalitico", "OptionGroup")
413:         loc_oPg.obj_4c_TipoAnalitico.ButtonCount = 2
414:         WITH loc_oPg.obj_4c_TipoAnalitico
415:             .Top           = 77
416:             .Left          = 141
417:             .Width         = 146
418:             .Height        = 25
419:             .BackStyle     = 0
420:             .BorderStyle   = 0
421:             .SpecialEffect = 1
422:             .Value         = 1
423:             .Visible       = .T.
424:         ENDWITH
425:         WITH loc_oPg.obj_4c_TipoAnalitico.Buttons(1)
426:             .Caption   = "Produto"
427:             .Left      = 5
428:             .Top       = 5
429:             .Width     = 62
430:             .Height    = 15
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .BackStyle = 0
434:             .ForeColor = RGB(90, 90, 90)
435:         ENDWITH
436:         WITH loc_oPg.obj_4c_TipoAnalitico.Buttons(2)
437:             .Caption   = "Local"
438:             .Left      = 86
439:             .Top       = 5
440:             .Width     = 50
441:             .Height    = 15
442:             .FontName  = "Tahoma"
443:             .FontSize  = 8
444:             .BackStyle = 0
445:             .ForeColor = RGB(90, 90, 90)
446:         ENDWITH
447: 
448:         *-- CheckBox "Imprimir Imagem" (top=160->80, left=295)
449:         loc_oPg.AddObject("chk_4c_ChkImpImg", "CheckBox")
450:         WITH loc_oPg.chk_4c_ChkImpImg
451:             .Top           = 80
452:             .Left          = 295
453:             .Width         = 110
454:             .Height        = 15
455:             .Caption       = "Imprimir Imagem"
456:             .Value         = 0
457:             .FontName      = "Tahoma"
458:             .FontSize      = 8
459:             .BackStyle     = 0
460:             .Alignment     = 0
461:             .SpecialEffect = 1
462:             .ForeColor     = RGB(90, 90, 90)
463:             .Enabled       = .F.
464:             .Visible       = .T.
465:         ENDWITH
466: 
467:         *-- Label "Produto :" (top=186->106, left=94)
468:         loc_oPg.AddObject("lbl_4c_Lbl_codigo", "Label")
469:         WITH loc_oPg.lbl_4c_Lbl_codigo
470:             .Top       = 106
471:             .Left      = 94
472:             .Width     = 50
473:             .Height    = 15
474:             .Caption   = "Produto :"
475:             .FontName  = "Tahoma"
476:             .FontSize  = 8
477:             .ForeColor = RGB(90, 90, 90)
478:             .BackStyle = 0
479:             .Visible   = .T.
480:         ENDWITH
481: 
482:         *-- TextBox c" + CHR(243) + "digo produto (get_cd_codigo -> txt_4c__cd_codigo)
483:         *   Original: top=181->101, left=147, width=108, MaxLength=14
484:         loc_oPg.AddObject("txt_4c__cd_codigo", "TextBox")
485:         WITH loc_oPg.txt_4c__cd_codigo
486:             .Top               = 101
487:             .Left              = 147
488:             .Width             = 108
489:             .Height            = 24
490:             .Value             = ""
491:             .MaxLength         = 14
492:             .Format            = "!"

*-- Linhas 506 a 515:
506:         *   Original: top=181->101, left=257, width=237, MaxLength=40
507:         loc_oPg.AddObject("txt_4c__ds_codigo", "TextBox")
508:         WITH loc_oPg.txt_4c__ds_codigo
509:             .Top               = 101
510:             .Left              = 257
511:             .Width             = 237
512:             .Height            = 24
513:             .Value             = ""
514:             .MaxLength         = 40
515:             .Format            = "!"

*-- Linhas 526 a 553:
526:         ENDWITH
527: 
528:         *-- Label "Local :" (top=212->132, left=108)
529:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
530:         WITH loc_oPg.lbl_4c_Label5
531:             .Top       = 132
532:             .Left      = 108
533:             .Width     = 38
534:             .Height    = 15
535:             .Caption   = "Local :"
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .ForeColor = RGB(90, 90, 90)
539:             .BackStyle = 0
540:             .Visible   = .T.
541:         ENDWITH
542: 
543:         *-- TextBox c" + CHR(243) + "digo local (Get_Local -> txt_4c_Local)
544:         *   Original: top=207->127, left=147, width=80, MaxLength=10
545:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
546:         WITH loc_oPg.txt_4c_Local
547:             .Top               = 127
548:             .Left              = 147
549:             .Width             = 80
550:             .Height            = 24
551:             .Value             = ""
552:             .MaxLength         = 10
553:             .FontName          = "Tahoma"

*-- Linhas 566 a 575:
566:         *   Original: top=207->127, left=229, width=237, MaxLength=20
567:         loc_oPg.AddObject("txt_4c__Dlocal", "TextBox")
568:         WITH loc_oPg.txt_4c__Dlocal
569:             .Top               = 127
570:             .Left              = 229
571:             .Width             = 237
572:             .Height            = 24
573:             .Value             = ""
574:             .MaxLength         = 20
575:             .FontName          = "Tahoma"

*-- Linhas 585 a 1007:
585:         ENDWITH
586: 
587:         *-- Label "Itens :" (top=242->162, left=107)
588:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
589:         WITH loc_oPg.lbl_4c_Label2
590:             .Top       = 162
591:             .Left      = 107
592:             .Width     = 38
593:             .Height    = 15
594:             .Caption   = "Itens :"
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .ForeColor = RGB(90, 90, 90)
598:             .BackStyle = 0
599:             .Visible   = .T.
600:         ENDWITH
601: 
602:         *-- OptionGroup TipoDiferenca (Todos / Com Diferen" + CHR(231) + "a) - default=2
603:         *   Original: top=237->157, left=141, width=178, height=25; Init set value=2
604:         loc_oPg.AddObject("obj_4c_TipoDiferenca", "OptionGroup")
605:         loc_oPg.obj_4c_TipoDiferenca.ButtonCount = 2
606:         WITH loc_oPg.obj_4c_TipoDiferenca
607:             .Top           = 157
608:             .Left          = 141
609:             .Width         = 190
610:             .Height        = 25
611:             .BackStyle     = 0
612:             .BorderStyle   = 0
613:             .SpecialEffect = 1
614:             .Value         = 2
615:             .Visible       = .T.
616:         ENDWITH
617:         WITH loc_oPg.obj_4c_TipoDiferenca.Buttons(1)
618:             .Caption   = "Todos"
619:             .Left      = 5
620:             .Top       = 5
621:             .Width     = 55
622:             .Height    = 15
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .BackStyle = 0
626:             .ForeColor = RGB(90, 90, 90)
627:         ENDWITH
628:         WITH loc_oPg.obj_4c_TipoDiferenca.Buttons(2)
629:             .Caption   = "Com Diferen" + CHR(231) + "a"
630:             .Left      = 85
631:             .Top       = 5
632:             .Width     = 95
633:             .Height    = 15
634:             .FontName  = "Tahoma"
635:             .FontSize  = 8
636:             .BackStyle = 0
637:             .ForeColor = RGB(90, 90, 90)
638:         ENDWITH
639: 
640:         *-- Label "Ordem :" (top=242->162, left=422)
641:         loc_oPg.AddObject("lbl_4c_LblOrdem", "Label")
642:         WITH loc_oPg.lbl_4c_LblOrdem
643:             .Top       = 162
644:             .Left      = 422
645:             .Width     = 48
646:             .Height    = 15
647:             .Caption   = "Ordem :"
648:             .FontName  = "Tahoma"
649:             .FontSize  = 8
650:             .ForeColor = RGB(90, 90, 90)
651:             .BackStyle = 0
652:             .Visible   = .T.
653:         ENDWITH
654: 
655:         *-- OptionGroup TipoOrdem (Produto / Grupo)
656:         *   Original: top=236->156, left=471, width=137, height=27
657:         loc_oPg.AddObject("obj_4c_TipoOrdem", "OptionGroup")
658:         loc_oPg.obj_4c_TipoOrdem.ButtonCount = 2
659:         WITH loc_oPg.obj_4c_TipoOrdem
660:             .Top           = 156
661:             .Left          = 471
662:             .Width         = 147
663:             .Height        = 27
664:             .BackStyle     = 0
665:             .BorderStyle   = 0
666:             .SpecialEffect = 1
667:             .Value         = 1
668:             .Visible       = .T.
669:         ENDWITH
670:         WITH loc_oPg.obj_4c_TipoOrdem.Buttons(1)
671:             .Caption   = "Produto"
672:             .Left      = 5
673:             .Top       = 5
674:             .Width     = 62
675:             .Height    = 15
676:             .FontName  = "Tahoma"
677:             .FontSize  = 8
678:             .BackStyle = 0
679:             .ForeColor = RGB(90, 90, 90)
680:         ENDWITH
681:         WITH loc_oPg.obj_4c_TipoOrdem.Buttons(2)
682:             .Caption   = "Grupo"
683:             .Left      = 85
684:             .Top       = 5
685:             .Width     = 52
686:             .Height    = 15
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .BackStyle = 0
690:             .ForeColor = RGB(90, 90, 90)
691:         ENDWITH
692: 
693:         *-- Label "Leitura :" (top=266->186, left=99)
694:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
695:         WITH loc_oPg.lbl_4c_Label3
696:             .Top       = 186
697:             .Left      = 99
698:             .Width     = 46
699:             .Height    = 15
700:             .Caption   = "Leitura :"
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .ForeColor = RGB(90, 90, 90)
704:             .BackStyle = 0
705:             .Visible   = .T.
706:         ENDWITH
707: 
708:         *-- OptionGroup TipoLeitura (Leitura / Releitura)
709:         *   Original: top=261->181, left=141, width=151, height=25
710:         loc_oPg.AddObject("obj_4c_TipoLeitura", "OptionGroup")
711:         loc_oPg.obj_4c_TipoLeitura.ButtonCount = 2
712:         WITH loc_oPg.obj_4c_TipoLeitura
713:             .Top           = 181
714:             .Left          = 141
715:             .Width         = 165
716:             .Height        = 25
717:             .BackStyle     = 0
718:             .BorderStyle   = 0
719:             .SpecialEffect = 1
720:             .Value         = 1
721:             .Visible       = .T.
722:         ENDWITH
723:         WITH loc_oPg.obj_4c_TipoLeitura.Buttons(1)
724:             .Caption   = "Leitura"
725:             .Left      = 5
726:             .Top       = 5
727:             .Width     = 55
728:             .Height    = 15
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .BackStyle = 0
732:             .ForeColor = RGB(90, 90, 90)
733:         ENDWITH
734:         WITH loc_oPg.obj_4c_TipoLeitura.Buttons(2)
735:             .Caption   = "Releitura"
736:             .Left      = 85
737:             .Top       = 5
738:             .Width     = 70
739:             .Height    = 15
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .BackStyle = 0
743:             .ForeColor = RGB(90, 90, 90)
744:         ENDWITH
745: 
746:         *-- Label "C" + CHR(243) + "digo de Barras :" (top=266->186, left=372)
747:         loc_oPg.AddObject("lbl_4c_LblBarras", "Label")
748:         WITH loc_oPg.lbl_4c_LblBarras
749:             .Top       = 186
750:             .Left      = 372
751:             .Width     = 97
752:             .Height    = 15
753:             .Caption   = "C" + CHR(243) + "digo de Barras :"
754:             .FontName  = "Tahoma"
755:             .FontSize  = 8
756:             .ForeColor = RGB(90, 90, 90)
757:             .BackStyle = 0
758:             .Visible   = .T.
759:         ENDWITH
760: 
761:         *-- OptionGroup optgBarras (Sim / N" + CHR(227) + "o) - default=1 (Sim)
762:         *   Original: top=260->180, left=471, width=131, height=27
763:         loc_oPg.AddObject("obj_4c_OptgBarras", "OptionGroup")
764:         loc_oPg.obj_4c_OptgBarras.ButtonCount = 2
765:         WITH loc_oPg.obj_4c_OptgBarras
766:             .Top           = 180
767:             .Left          = 471
768:             .Width         = 145
769:             .Height        = 27
770:             .BackStyle     = 0
771:             .BorderStyle   = 0
772:             .SpecialEffect = 1
773:             .Value         = 1
774:             .Visible       = .T.
775:         ENDWITH
776:         WITH loc_oPg.obj_4c_OptgBarras.Buttons(1)
777:             .Caption   = "Sim"
778:             .Left      = 5
779:             .Top       = 5
780:             .Width     = 45
781:             .Height    = 17
782:             .FontName  = "Tahoma"
783:             .FontSize  = 8
784:             .BackStyle = 0
785:             .ForeColor = RGB(90, 90, 90)
786:         ENDWITH
787:         WITH loc_oPg.obj_4c_OptgBarras.Buttons(2)
788:             .Caption   = "N" + CHR(227) + "o"
789:             .Left      = 85
790:             .Top       = 5
791:             .Width     = 45
792:             .Height    = 17
793:             .FontName  = "Tahoma"
794:             .FontSize  = 8
795:             .BackStyle = 0
796:             .ForeColor = RGB(90, 90, 90)
797:         ENDWITH
798: 
799:         *-- Label "Pre" + CHR(231) + "o Custo :" (top=290->210, left=74)
800:         loc_oPg.AddObject("lbl_4c_Label6", "Label")
801:         WITH loc_oPg.lbl_4c_Label6
802:             .Top       = 210
803:             .Left      = 74
804:             .Width     = 72
805:             .Height    = 15
806:             .Caption   = "Pre" + CHR(231) + "o Custo :"
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .ForeColor = RGB(90, 90, 90)
810:             .BackStyle = 0
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         *-- OptionGroup optgTpCusto (Sim / N" + CHR(227) + "o) - default=1 (Sim)
815:         *   Original: top=284->204, left=141, width=131, height=27
816:         loc_oPg.AddObject("obj_4c_OptgTpCusto", "OptionGroup")
817:         loc_oPg.obj_4c_OptgTpCusto.ButtonCount = 2
818:         WITH loc_oPg.obj_4c_OptgTpCusto
819:             .Top           = 204
820:             .Left          = 141
821:             .Width         = 145
822:             .Height        = 27
823:             .BackStyle     = 0
824:             .BorderStyle   = 0
825:             .SpecialEffect = 1
826:             .Value         = 1
827:             .Visible       = .T.
828:         ENDWITH
829:         WITH loc_oPg.obj_4c_OptgTpCusto.Buttons(1)
830:             .Caption   = "Sim"
831:             .Left      = 5
832:             .Top       = 5
833:             .Width     = 45
834:             .Height    = 17
835:             .FontName  = "Tahoma"
836:             .FontSize  = 8
837:             .BackStyle = 0
838:             .ForeColor = RGB(90, 90, 90)
839:         ENDWITH
840:         WITH loc_oPg.obj_4c_OptgTpCusto.Buttons(2)
841:             .Caption   = "N" + CHR(227) + "o"
842:             .Left      = 85
843:             .Top       = 5
844:             .Width     = 45
845:             .Height    = 17
846:             .FontName  = "Tahoma"
847:             .FontSize  = 8
848:             .BackStyle = 0
849:             .ForeColor = RGB(90, 90, 90)
850:         ENDWITH
851: 
852:         *-- Label "Pre" + CHR(231) + "o Venda :" (top=290->210, left=394)
853:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
854:         WITH loc_oPg.lbl_4c_Label7
855:             .Top       = 210
856:             .Left      = 394
857:             .Width     = 74
858:             .Height    = 15
859:             .Caption   = "Pre" + CHR(231) + "o Venda :"
860:             .FontName  = "Tahoma"
861:             .FontSize  = 8
862:             .ForeColor = RGB(90, 90, 90)
863:             .BackStyle = 0
864:             .Visible   = .T.
865:         ENDWITH
866: 
867:         *-- OptionGroup optgTpVenda (Sim / N" + CHR(227) + "o) - default=1 (Sim)
868:         *   Original: top=284->204, left=471, width=131, height=27
869:         loc_oPg.AddObject("obj_4c_OptgTpVenda", "OptionGroup")
870:         loc_oPg.obj_4c_OptgTpVenda.ButtonCount = 2
871:         WITH loc_oPg.obj_4c_OptgTpVenda
872:             .Top           = 204
873:             .Left          = 471
874:             .Width         = 145
875:             .Height        = 27
876:             .BackStyle     = 0
877:             .BorderStyle   = 0
878:             .SpecialEffect = 1
879:             .Value         = 1
880:             .Visible       = .T.
881:         ENDWITH
882:         WITH loc_oPg.obj_4c_OptgTpVenda.Buttons(1)
883:             .Caption   = "Sim"
884:             .Left      = 5
885:             .Top       = 5
886:             .Width     = 45
887:             .Height    = 17
888:             .FontName  = "Tahoma"
889:             .FontSize  = 8
890:             .BackStyle = 0
891:             .ForeColor = RGB(90, 90, 90)
892:         ENDWITH
893:         WITH loc_oPg.obj_4c_OptgTpVenda.Buttons(2)
894:             .Caption   = "N" + CHR(227) + "o"
895:             .Left      = 85
896:             .Top       = 5
897:             .Width     = 45
898:             .Height    = 17
899:             .FontName  = "Tahoma"
900:             .FontSize  = 8
901:             .BackStyle = 0
902:             .ForeColor = RGB(90, 90, 90)
903:         ENDWITH
904: 
905:         *-- Label "Descri" + CHR(231) + CHR(227) + "o do Produto :" (top=314->234, left=30)
906:         loc_oPg.AddObject("lbl_4c_LblDescricao", "Label")
907:         WITH loc_oPg.lbl_4c_LblDescricao
908:             .Top       = 234
909:             .Left      = 30
910:             .Width     = 115
911:             .Height    = 15
912:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto :"
913:             .FontName  = "Tahoma"
914:             .FontSize  = 8
915:             .ForeColor = RGB(90, 90, 90)
916:             .BackStyle = 0
917:             .Visible   = .T.
918:         ENDWITH
919: 
920:         *-- OptionGroup optgDescricao (Sim / N" + CHR(227) + "o) - default=2 (N" + CHR(227) + "o)
921:         *   Original: top=308->228, left=141, width=131, height=27, Value=2
922:         loc_oPg.AddObject("obj_4c_OptgDescricao", "OptionGroup")
923:         loc_oPg.obj_4c_OptgDescricao.ButtonCount = 2
924:         WITH loc_oPg.obj_4c_OptgDescricao
925:             .Top           = 228
926:             .Left          = 141
927:             .Width         = 145
928:             .Height        = 27
929:             .BackStyle     = 0
930:             .BorderStyle   = 0
931:             .SpecialEffect = 1
932:             .Value         = 2
933:             .Visible       = .T.
934:         ENDWITH
935:         WITH loc_oPg.obj_4c_OptgDescricao.Buttons(1)
936:             .Caption   = "Sim"
937:             .Left      = 5
938:             .Top       = 5
939:             .Width     = 45
940:             .Height    = 17
941:             .FontName  = "Tahoma"
942:             .FontSize  = 8
943:             .BackStyle = 0
944:             .ForeColor = RGB(90, 90, 90)
945:         ENDWITH
946:         WITH loc_oPg.obj_4c_OptgDescricao.Buttons(2)
947:             .Caption   = "N" + CHR(227) + "o"
948:             .Left      = 85
949:             .Top       = 5
950:             .Width     = 45
951:             .Height    = 17
952:             .FontName  = "Tahoma"
953:             .FontSize  = 8
954:             .BackStyle = 0
955:             .ForeColor = RGB(90, 90, 90)
956:         ENDWITH
957: 
958:         *-- Label "Localiza" + CHR(231) + CHR(227) + "o :" (top=314->234, left=400)
959:         loc_oPg.AddObject("lbl_4c_LblLocalizacao", "Label")
960:         WITH loc_oPg.lbl_4c_LblLocalizacao
961:             .Top       = 234
962:             .Left      = 400
963:             .Width     = 72
964:             .Height    = 15
965:             .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
966:             .FontName  = "Tahoma"
967:             .FontSize  = 8
968:             .ForeColor = RGB(90, 90, 90)
969:             .BackStyle = 0
970:             .Visible   = .T.
971:         ENDWITH
972: 
973:         *-- OptionGroup optgLocalizacao (Sim / N" + CHR(227) + "o) - default=2 (N" + CHR(227) + "o)
974:         *   Original: top=308->228, left=471, width=131, height=27, Value=2
975:         loc_oPg.AddObject("obj_4c_OptgLocalizacao", "OptionGroup")
976:         loc_oPg.obj_4c_OptgLocalizacao.ButtonCount = 2
977:         WITH loc_oPg.obj_4c_OptgLocalizacao
978:             .Top           = 228
979:             .Left          = 471
980:             .Width         = 145
981:             .Height        = 27
982:             .BackStyle     = 0
983:             .BorderStyle   = 0
984:             .SpecialEffect = 1
985:             .Value         = 2
986:             .Visible       = .T.
987:         ENDWITH
988:         WITH loc_oPg.obj_4c_OptgLocalizacao.Buttons(1)
989:             .Caption   = "Sim"
990:             .Left      = 5
991:             .Top       = 5
992:             .Width     = 45
993:             .Height    = 17
994:             .FontName  = "Tahoma"
995:             .FontSize  = 8
996:             .BackStyle = 0
997:             .ForeColor = RGB(90, 90, 90)
998:         ENDWITH
999:         WITH loc_oPg.obj_4c_OptgLocalizacao.Buttons(2)
1000:             .Caption   = "N" + CHR(227) + "o"
1001:             .Left      = 85
1002:             .Top       = 5
1003:             .Width     = 45
1004:             .Height    = 17
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:             .BackStyle = 0

*-- Linhas 1148 a 1159:
1148:                 loc_oPg.obj_4c_OptgDescricao.Visible   = .F.
1149:                 loc_oPg.obj_4c_OptgBarras.Visible      = .F.
1150:                 loc_oPg.obj_4c_OptgLocalizacao.Visible = .F.
1151:                 loc_oPg.lbl_4c_LblOrdem.Visible        = .F.
1152:                 loc_oPg.lbl_4c_LblDescricao.Visible    = .F.
1153:                 loc_oPg.lbl_4c_LblBarras.Visible       = .F.
1154:                 loc_oPg.lbl_4c_LblLocalizacao.Visible  = .F.
1155:             ENDIF
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message, "Erro AplicarRegraGesInd")
1158:         ENDTRY
1159:     ENDPROC

*-- Linhas 1609 a 1631:
1609:             ENDIF
1610:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1611:             WITH THIS.this_oRelatorio
1612:                 loc_oPg.obj_4c_TipoRelatorio.Value   = .this_nTipoRelatorio
1613:                 loc_oPg.obj_4c_TipoAnalitico.Value   = .this_nTipoAnalitico
1614:                 loc_oPg.obj_4c_TipoDiferenca.Value   = .this_nTipoDiferenca
1615:                 loc_oPg.obj_4c_TipoLeitura.Value     = .this_nTipoLeitura
1616:                 loc_oPg.obj_4c_TipoOrdem.Value       = .this_nTipoOrdem
1617:                 loc_oPg.txt_4c__cd_codigo.Value      = .this_cCodProduto
1618:                 loc_oPg.txt_4c__ds_codigo.Value      = .this_cDesProduto
1619:                 loc_oPg.txt_4c_Local.Value           = .this_cLocal
1620:                 loc_oPg.txt_4c__Dlocal.Value         = .this_cDesLocal
1621:                 loc_oPg.obj_4c_OptgTpCusto.Value     = .this_nTpCusto
1622:                 loc_oPg.obj_4c_OptgTpVenda.Value     = .this_nTpVenda
1623:                 loc_oPg.obj_4c_OptgDescricao.Value   = .this_nDescricao
1624:                 loc_oPg.obj_4c_OptgBarras.Value      = .this_nBarras
1625:                 loc_oPg.obj_4c_OptgLocalizacao.Value = .this_nLocalizacao
1626:                 loc_oPg.chk_4c_ChkImpImg.Value       = .this_lImprimirImagem
1627:             ENDWITH
1628:             THIS.TipoRelatorioChange()
1629:         CATCH TO loc_oErro
1630:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
1631:         ENDTRY

