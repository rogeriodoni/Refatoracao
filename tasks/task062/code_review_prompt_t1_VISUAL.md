# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (11)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Analitico' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGRECOR): Top original=152 vs migrado 'lbl_4c_Lbl_estoque' Top=67 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGRECOR): Top original=179 vs migrado 'lbl_4c_Lbl_moeda' Top=94 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTipo' (parent: SIGRECOR): Top original=226 vs migrado 'obj_4c_OptTipo' Top=0 (diff=226px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTipo' (parent: SIGRECOR): Left original=235 vs migrado 'obj_4c_OptTipo' Left=0 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optQuebras' (parent: SIGRECOR): Top original=249 vs migrado 'obj_4c_OptQuebras' Top=0 (diff=249px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optQuebras' (parent: SIGRECOR): Left original=235 vs migrado 'obj_4c_OptQuebras' Left=0 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optSNA' (parent: SIGRECOR): Top original=201 vs migrado 'obj_4c_OptSNA' Top=0 (diff=201px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optSNA' (parent: SIGRECOR): Left original=235 vs migrado 'obj_4c_OptSNA' Left=0 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optPenPag' (parent: SIGRECOR): Top original=179 vs migrado 'chk_4c_OptPenPag' Top=94 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecor.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1573 linhas total):

*-- Linhas 12 a 20:
12: *   - Op" + CHR(231) + CHR(227) + "o SNA (Sim / N" + CHR(227) + "o / Ambos)
13: *   - Tipo (Anal" + CHR(237) + "tico / Sint" + CHR(233) + "tico / Resumo)
14: *   - Quebra (Datas / Data+Movimenta" + CHR(231) + CHR(227) + "o / Cliente)
15: *   - PenPag: pagamento em aberto (CheckBox)
16: *
17: * FASE 3/8 - Estrutura base do form
18: *   * Propriedades visuais do form (Width=800, Height=300, TitleBar=0)
19: *   * Init() / InicializarForm() / Destroy()
20: *   * ConfigurarCabecalho() (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)

*-- Linhas 61 a 69:
61:         loc_lSucesso   = .F.
62:         loc_lContinuar = .T.
63:         TRY
64:             THIS.Caption = "Comiss" + CHR(227) + "o Pendente por Vendedor"
65: 
66:             IF TYPE("gc_4c_CaminhoIcones") = "U"
67:                 gc_4c_CaminhoIcones = ""
68:             ENDIF
69:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 95 a 104:
95:                 *-- Inicializa filtros com valores padrao
96:                 THIS.LimparCampos()
97: 
98:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
99:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
100: 
101:                 THIS.Visible = .T.
102:                 loc_lSucesso = .T.
103:             ENDIF
104:         CATCH TO loc_oErro

*-- Linhas 118 a 196:
118:     PROTECTED PROCEDURE ConfigurarCabecalho()
119:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH THIS.cnt_4c_Cabecalho
121:             .Top         = 0
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackStyle   = 1
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129: 
130:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
131:             .AddObject("lbl_4c_Sombra", "Label")
132:             WITH .lbl_4c_Sombra
133:                 .Top       = 22
134:                 .Left      = 22
135:                 .Width     = THIS.Width
136:                 .Height    = 30
137:                 .Caption   = "Comiss" + CHR(227) + "o Pendente por Vendedor"
138:                 .FontName  = "Tahoma"
139:                 .FontSize  = 14
140:                 .FontBold  = .T.
141:                 .ForeColor = RGB(0, 0, 0)
142:                 .BackStyle = 0
143:                 .Visible   = .T.
144:             ENDWITH
145: 
146:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
147:             .AddObject("lbl_4c_Titulo", "Label")
148:             WITH .lbl_4c_Titulo
149:                 .Top       = 20
150:                 .Left      = 20
151:                 .Width     = THIS.Width
152:                 .Height    = 30
153:                 .Caption   = "Comiss" + CHR(227) + "o Pendente por Vendedor"
154:                 .FontName  = "Tahoma"
155:                 .FontSize  = 14
156:                 .FontBold  = .T.
157:                 .ForeColor = RGB(255, 255, 255)
158:                 .BackStyle = 0
159:                 .Visible   = .T.
160:             ENDWITH
161:         ENDWITH
162:     ENDPROC
163: 
164:     *--------------------------------------------------------------------------
165:     * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
166:     *   Original: btnReport.Left=529, Top=0, ButtonCount=4
167:     *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
168:     *   BINDEVENTs Click s" + CHR(227) + "o vinculados na Fase 7.
169:     *--------------------------------------------------------------------------
170:     PROTECTED PROCEDURE ConfigurarBotoes()
171:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
172:         WITH THIS.cmg_4c_Botoes
173:             .Top           = 0
174:             .Left          = 529
175:             .Width         = 273
176:             .Height        = 80
177:             .ButtonCount   = 4
178:             .BackStyle     = 0
179:             .BorderStyle   = 0
180:             .BorderColor   = RGB(136, 189, 188)
181:             .SpecialEffect = 1
182:             .Themes        = .F.
183:             .Visible       = .T.
184: 
185:             *-- Visualizar (preview em tela)
186:             WITH .Buttons(1)
187:                 .Top             = 5
188:                 .Left            = 5
189:                 .Width           = 65
190:                 .Height          = 70
191:                 .Caption         = "Visualizar"
192:                 .FontBold        = .T.
193:                 .FontItalic      = .T.
194:                 .BackColor       = RGB(255, 255, 255)
195:                 .ForeColor       = RGB(90, 90, 90)
196:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 204 a 216:
204: 
205:             *-- Imprimir (impressora padr" + CHR(227) + "o)
206:             WITH .Buttons(2)
207:                 .Top             = 5
208:                 .Left            = 71
209:                 .Width           = 65
210:                 .Height          = 70
211:                 .Caption         = "Imprimir"
212:                 .FontName        = "Tahoma"
213:                 .FontBold        = .T.
214:                 .FontItalic      = .T.
215:                 .FontSize        = 8
216:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 226 a 238:
226: 
227:             *-- Excel (exportar dados)
228:             WITH .Buttons(3)
229:                 .Top             = 5
230:                 .Left            = 137
231:                 .Width           = 65
232:                 .Height          = 70
233:                 .Caption         = "Excel"
234:                 .FontName        = "Tahoma"
235:                 .FontBold        = .T.
236:                 .FontItalic      = .T.
237:                 .FontSize        = 8
238:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 248 a 260:
248: 
249:             *-- Encerrar (fechar form)
250:             WITH .Buttons(4)
251:                 .Top             = 5
252:                 .Left            = 203
253:                 .Width           = 65
254:                 .Height          = 70
255:                 .Caption         = "Encerrar"
256:                 .Cancel          = .T.
257:                 .FontName        = "Tahoma"
258:                 .FontBold        = .T.
259:                 .FontItalic      = .T.
260:                 .FontSize        = 8

*-- Linhas 290 a 305:
290:         loc_oPgf.PageCount = 1
291: 
292:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
293:         loc_oPgf.Top    = 85
294:         loc_oPgf.Left   = -1
295:         loc_oPgf.Width  = THIS.Width + 2
296:         loc_oPgf.Height = THIS.Height - 85
297:         loc_oPgf.Tabs   = .F.
298: 
299:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
300:         loc_oPgf.Page1.Caption   = "Filtros"
301:         loc_oPgf.Page1.FontName  = "Tahoma"
302:         loc_oPgf.Page1.FontSize  = 8
303:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
304:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
305:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 329 a 384:
329:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
330: 
331:             *-- --- Periodo ---
332:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
333:             WITH loc_oPagina.lbl_4c_Label1
334:                 .Top       = 15
335:                 .Left      = 191
336:                 .Width     = 50
337:                 .Height    = 15
338:                 .Caption   = "Per" + CHR(237) + "odo :"
339:                 .FontName  = "Tahoma"
340:                 .FontSize  = 8
341:                 .ForeColor = RGB(90, 90, 90)
342:                 .BackStyle = 0
343:                 .Visible   = .T.
344:             ENDWITH
345: 
346:             loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
347:             WITH loc_oPagina.txt_4c__dt_inicial
348:                 .Top         = 11
349:                 .Left        = 240
350:                 .Width       = 80
351:                 .Height      = 25
352:                 .Value       = {}
353:                 .Format      = "D"
354:                 .FontName    = "Tahoma"
355:                 .FontSize    = 8
356:                 .ForeColor   = RGB(90, 90, 90)
357:                 .BackColor   = RGB(255, 255, 255)
358:                 .BorderStyle = 1
359:                 .Visible     = .T.
360:             ENDWITH
361: 
362:             loc_oPagina.AddObject("lbl_4c_Label4", "Label")
363:             WITH loc_oPagina.lbl_4c_Label4
364:                 .Top       = 16
365:                 .Left      = 324
366:                 .Width     = 20
367:                 .Height    = 15
368:                 .Caption   = "at" + CHR(233)
369:                 .FontName  = "Tahoma"
370:                 .FontSize  = 8
371:                 .ForeColor = RGB(90, 90, 90)
372:                 .BackStyle = 0
373:                 .Visible   = .T.
374:             ENDWITH
375: 
376:             loc_oPagina.AddObject("txt_4c__dt_final", "TextBox")
377:             WITH loc_oPagina.txt_4c__dt_final
378:                 .Top         = 11
379:                 .Left        = 348
380:                 .Width       = 80
381:                 .Height      = 25
382:                 .Value       = {}
383:                 .Format      = "D"
384:                 .FontName    = "Tahoma"

*-- Linhas 390 a 415:
390:             ENDWITH
391: 
392:             *-- --- Grupo de Estoque ---
393:             loc_oPagina.AddObject("lbl_4c_Label3", "Label")
394:             WITH loc_oPagina.lbl_4c_Label3
395:                 .Top       = 40
396:                 .Left      = 198
397:                 .Width     = 38
398:                 .Height    = 15
399:                 .Caption   = "Grupo :"
400:                 .FontName  = "Tahoma"
401:                 .FontSize  = 8
402:                 .ForeColor = RGB(90, 90, 90)
403:                 .BackStyle = 0
404:                 .Visible   = .T.
405:             ENDWITH
406: 
407:             loc_oPagina.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
408:             WITH loc_oPagina.txt_4c__Cd_GrEstoque
409:                 .Top         = 36
410:                 .Left        = 240
411:                 .Width       = 79
412:                 .Height      = 25
413:                 .Value       = ""
414:                 .FontName    = "Tahoma"
415:                 .FontSize    = 8

*-- Linhas 421 a 460:
421: 
422:             loc_oPagina.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
423:             WITH loc_oPagina.txt_4c__Ds_GrEstoque
424:                 .Top         = 36
425:                 .Left        = 321
426:                 .Width       = 290
427:                 .Height      = 25
428:                 .Value       = ""
429:                 .FontName    = "Tahoma"
430:                 .FontSize    = 8
431:                 .ForeColor   = RGB(90, 90, 90)
432:                 .BackColor   = RGB(255, 255, 255)
433:                 .BorderStyle = 1
434:                 .Visible     = .T.
435:             ENDWITH
436: 
437:             *-- --- Conta de Estoque ---
438:             loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
439:             WITH loc_oPagina.lbl_4c_Lbl_estoque
440:                 .Top       = 67
441:                 .Left      = 198
442:                 .Width     = 38
443:                 .Height    = 15
444:                 .Caption   = "Conta :"
445:                 .FontName  = "Tahoma"
446:                 .FontSize  = 8
447:                 .ForeColor = RGB(90, 90, 90)
448:                 .BackStyle = 0
449:                 .Visible   = .T.
450:             ENDWITH
451: 
452:             loc_oPagina.AddObject("txt_4c__cd_estoque", "TextBox")
453:             WITH loc_oPagina.txt_4c__cd_estoque
454:                 .Top         = 63
455:                 .Left        = 240
456:                 .Width       = 79
457:                 .Height      = 25
458:                 .Value       = ""
459:                 .FontName    = "Tahoma"
460:                 .FontSize    = 8

*-- Linhas 466 a 505:
466: 
467:             loc_oPagina.AddObject("txt_4c__ds_estoque", "TextBox")
468:             WITH loc_oPagina.txt_4c__ds_estoque
469:                 .Top         = 63
470:                 .Left        = 321
471:                 .Width       = 290
472:                 .Height      = 25
473:                 .Value       = ""
474:                 .FontName    = "Tahoma"
475:                 .FontSize    = 8
476:                 .ForeColor   = RGB(90, 90, 90)
477:                 .BackColor   = RGB(255, 255, 255)
478:                 .BorderStyle = 1
479:                 .Visible     = .T.
480:             ENDWITH
481: 
482:             *-- --- Moeda ---
483:             loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
484:             WITH loc_oPagina.lbl_4c_Lbl_moeda
485:                 .Top       = 94
486:                 .Left      = 195
487:                 .Width     = 42
488:                 .Height    = 15
489:                 .Caption   = "Moeda :"
490:                 .FontName  = "Tahoma"
491:                 .FontSize  = 8
492:                 .ForeColor = RGB(90, 90, 90)
493:                 .BackStyle = 0
494:                 .Visible   = .T.
495:             ENDWITH
496: 
497:             loc_oPagina.AddObject("txt_4c__cd_moeda", "TextBox")
498:             WITH loc_oPagina.txt_4c__cd_moeda
499:                 .Top         = 90
500:                 .Left        = 240
501:                 .Width       = 31
502:                 .Height      = 25
503:                 .Value       = ""
504:                 .FontName    = "Tahoma"
505:                 .FontSize    = 8

*-- Linhas 511 a 737:
511: 
512:             loc_oPagina.AddObject("txt_4c__ds_moeda", "TextBox")
513:             WITH loc_oPagina.txt_4c__ds_moeda
514:                 .Top         = 90
515:                 .Left        = 273
516:                 .Width       = 115
517:                 .Height      = 25
518:                 .Value       = ""
519:                 .FontName    = "Tahoma"
520:                 .FontSize    = 8
521:                 .ForeColor   = RGB(90, 90, 90)
522:                 .BackColor   = RGB(255, 255, 255)
523:                 .BorderStyle = 1
524:                 .Visible     = .T.
525:             ENDWITH
526: 
527:             *-- CheckBox PenPag (pagamento em aberto)
528:             loc_oPagina.AddObject("chk_4c_OptPenPag", "CheckBox")
529:             WITH loc_oPagina.chk_4c_OptPenPag
530:                 .Top       = 94
531:                 .Left      = 442
532:                 .Width     = 136
533:                 .Height    = 15
534:                 .Caption   = "Pendente de Pagamento"
535:                 .Value     = 0
536:                 .FontName  = "Tahoma"
537:                 .FontSize  = 8
538:                 .ForeColor = RGB(90, 90, 90)
539:                 .BackStyle = 0
540:                 .BackColor = RGB(255, 255, 255)
541:                 .Visible   = .T.
542:             ENDWITH
543: 
544:             *-- --- Opcao SNA (Sim / Nao / Ambos) ---
545:             loc_oPagina.AddObject("lbl_4c_Label6", "Label")
546:             WITH loc_oPagina.lbl_4c_Label6
547:                 .Top       = 120
548:                 .Left      = 196
549:                 .Width     = 42
550:                 .Height    = 15
551:                 .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
552:                 .FontName  = "Tahoma"
553:                 .FontSize  = 8
554:                 .ForeColor = RGB(90, 90, 90)
555:                 .BackStyle = 0
556:                 .Visible   = .T.
557:             ENDWITH
558: 
559:             loc_oPagina.AddObject("obj_4c_OptSNA", "OptionGroup")
560:             WITH loc_oPagina.obj_4c_OptSNA
561:                 .Top         = 116
562:                 .Left        = 235
563:                 .Width       = 220
564:                 .Height      = 23
565:                 .ButtonCount = 3
566:                 .BackStyle   = 0
567:                 .BorderStyle = 0
568:                 .Themes      = .F.
569:                 .Value       = 3
570:                 .Visible     = .T.
571:                 WITH .Buttons(1)
572:                     .Top       = 0
573:                     .Left      = 0
574:                     .Width     = 73
575:                     .Height    = 23
576:                     .Caption   = "Sim"
577:                     .BackStyle = 0
578:                     .BackColor = RGB(255, 255, 255)
579:                     .ForeColor = RGB(90, 90, 90)
580:                     .Visible   = .T.
581:                 ENDWITH
582:                 WITH .Buttons(2)
583:                     .Top       = 0
584:                     .Left      = 73
585:                     .Width     = 73
586:                     .Height    = 23
587:                     .Caption   = "N" + CHR(227) + "o"
588:                     .FontName  = "Tahoma"
589:                     .FontSize  = 8
590:                     .BackStyle = 0
591:                     .BackColor = RGB(255, 255, 255)
592:                     .ForeColor = RGB(90, 90, 90)
593:                     .Visible   = .T.
594:                 ENDWITH
595:                 WITH .Buttons(3)
596:                     .Top       = 0
597:                     .Left      = 146
598:                     .Width     = 74
599:                     .Height    = 23
600:                     .Caption   = "Ambos"
601:                     .FontName  = "Tahoma"
602:                     .FontSize  = 8
603:                     .BackStyle = 0
604:                     .BackColor = RGB(255, 255, 255)
605:                     .ForeColor = RGB(90, 90, 90)
606:                     .Visible   = .T.
607:                 ENDWITH
608:             ENDWITH
609: 
610:             *-- --- Tipo (Analitico / Sintetico / Resumo) ---
611:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
612:             WITH loc_oPagina.lbl_4c_Label2
613:                 .Top       = 145
614:                 .Left      = 207
615:                 .Width     = 30
616:                 .Height    = 15
617:                 .Caption   = "Tipo :"
618:                 .FontName  = "Tahoma"
619:                 .FontSize  = 8
620:                 .ForeColor = RGB(90, 90, 90)
621:                 .BackStyle = 0
622:                 .Visible   = .T.
623:             ENDWITH
624: 
625:             loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
626:             WITH loc_oPagina.obj_4c_OptTipo
627:                 .Top         = 141
628:                 .Left        = 235
629:                 .Width       = 220
630:                 .Height      = 23
631:                 .ButtonCount = 3
632:                 .BackStyle   = 0
633:                 .BorderStyle = 0
634:                 .Themes      = .F.
635:                 .Value       = 1
636:                 .Visible     = .T.
637:                 WITH .Buttons(1)
638:                     .Top       = 0
639:                     .Left      = 0
640:                     .Width     = 73
641:                     .Height    = 23
642:                     .Caption   = "Anal" + CHR(237) + "tico"
643:                     .BackStyle = 0
644:                     .BackColor = RGB(255, 255, 255)
645:                     .ForeColor = RGB(90, 90, 90)
646:                     .Visible   = .T.
647:                 ENDWITH
648:                 WITH .Buttons(2)
649:                     .Top       = 0
650:                     .Left      = 73
651:                     .Width     = 73
652:                     .Height    = 23
653:                     .Caption   = "Sint" + CHR(233) + "tico"
654:                     .FontName  = "Tahoma"
655:                     .FontSize  = 8
656:                     .BackStyle = 0
657:                     .BackColor = RGB(255, 255, 255)
658:                     .ForeColor = RGB(90, 90, 90)
659:                     .Visible   = .T.
660:                 ENDWITH
661:                 WITH .Buttons(3)
662:                     .Top       = 0
663:                     .Left      = 146
664:                     .Width     = 74
665:                     .Height    = 23
666:                     .Caption   = "Resumo"
667:                     .FontName  = "Tahoma"
668:                     .FontSize  = 8
669:                     .BackStyle = 0
670:                     .BackColor = RGB(255, 255, 255)
671:                     .ForeColor = RGB(90, 90, 90)
672:                     .Visible   = .T.
673:                 ENDWITH
674:             ENDWITH
675: 
676:             *-- --- Quebra (Datas / Data+Mov. / Cliente) ---
677:             loc_oPagina.AddObject("lbl_4c_Label5", "Label")
678:             WITH loc_oPagina.lbl_4c_Label5
679:                 .Top       = 168
680:                 .Left      = 191
681:                 .Width     = 45
682:                 .Height    = 15
683:                 .Caption   = "Quebra :"
684:                 .FontName  = "Tahoma"
685:                 .FontSize  = 8
686:                 .ForeColor = RGB(90, 90, 90)
687:                 .BackStyle = 0
688:                 .Visible   = .T.
689:             ENDWITH
690: 
691:             loc_oPagina.AddObject("obj_4c_OptQuebras", "OptionGroup")
692:             WITH loc_oPagina.obj_4c_OptQuebras
693:                 .Top         = 164
694:                 .Left        = 235
695:                 .Width       = 303
696:                 .Height      = 25
697:                 .ButtonCount = 3
698:                 .BackStyle   = 0
699:                 .BorderStyle = 0
700:                 .Themes      = .F.
701:                 .Value       = 1
702:                 .Visible     = .T.
703:                 WITH .Buttons(1)
704:                     .Top       = 0
705:                     .Left      = 0
706:                     .Width     = 101
707:                     .Height    = 25
708:                     .Caption   = "Datas"
709:                     .BackStyle = 0
710:                     .BackColor = RGB(255, 255, 255)
711:                     .ForeColor = RGB(90, 90, 90)
712:                     .Visible   = .T.
713:                 ENDWITH
714:                 WITH .Buttons(2)
715:                     .Top       = 0
716:                     .Left      = 101
717:                     .Width     = 101
718:                     .Height    = 25
719:                     .Caption   = "Data+Mov."
720:                     .FontName  = "Tahoma"
721:                     .FontSize  = 8
722:                     .BackStyle = 0
723:                     .BackColor = RGB(255, 255, 255)
724:                     .ForeColor = RGB(90, 90, 90)
725:                     .Visible   = .T.
726:                 ENDWITH
727:                 WITH .Buttons(3)
728:                     .Top       = 0
729:                     .Left      = 202
730:                     .Width     = 101
731:                     .Height    = 25
732:                     .Caption   = "Cliente"
733:                     .FontName  = "Tahoma"
734:                     .FontSize  = 8
735:                     .BackStyle = 0
736:                     .BackColor = RGB(255, 255, 255)
737:                     .ForeColor = RGB(90, 90, 90)

*-- Linhas 844 a 852:
844:             BINDEVENT(loc_oPagina.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
845:             BINDEVENT(loc_oPagina.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")
846: 
847:             *-- OptionGroups e CheckBox: Click handlers para controle mutuo (padrao legado)
848:             BINDEVENT(loc_oPagina.obj_4c_OptTipo,    "Click", THIS, "OptTipoClick")
849:             BINDEVENT(loc_oPagina.obj_4c_OptQuebras, "Click", THIS, "OptQuebrasClick")
850:             BINDEVENT(loc_oPagina.chk_4c_OptPenPag,  "Click", THIS, "OptPenPagClick")
851: 
852:         CATCH TO loc_oErro

*-- Linhas 892 a 914:
892:     PROCEDURE BtnExcelClick()
893:         LOCAL loc_cArq, loc_oErro
894:         TRY
895:             THIS.FormParaRelatorio()
896:             IF THIS.this_oRelatorio.PrepararDados()
897:                 IF USED("cursor_4c_Analitico")
898:                     loc_cArq = ADDBS(SYS(2023)) + "sigrecor_" + DTOS(DATE()) + ".xls"
899:                     SELECT cursor_4c_Analitico
900:                     SET SAFETY OFF
901:                     COPY TO (loc_cArq) TYPE XL5
902:                     SET SAFETY ON
903:                     MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArq, "Excel")
904:                 ELSE
905:                     MsgAviso("Nenhum dado para exportar.", "Excel")
906:                 ENDIF
907:             ELSE
908:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
909:             ENDIF
910:         CATCH TO loc_oErro
911:             MsgErro(loc_oErro.Message, "BtnExcelClick")
912:         ENDTRY
913:     ENDPROC
914: 

*-- Linhas 1463 a 1471:
1463:     ENDPROC
1464: 
1465:     *--------------------------------------------------------------------------
1466:     * OptPenPagClick - Click no CheckBox PenPag
1467:     * Replica: ao marcar PenPag, forca tipo=Analitico e quebra=Datas.
1468:     *--------------------------------------------------------------------------
1469:     PROCEDURE OptPenPagClick()
1470:         LOCAL loc_oPagina
1471:         loc_oPagina = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1512 a 1534:
1512:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1513:             WITH THIS.this_oRelatorio
1514:                 IF VARTYPE(.this_dDtInicial) = "D" AND !EMPTY(.this_dDtInicial)
1515:                     loc_oPagina.txt_4c__dt_inicial.Value = .this_dDtInicial
1516:                 ENDIF
1517:                 IF VARTYPE(.this_dDtFinal) = "D" AND !EMPTY(.this_dDtFinal)
1518:                     loc_oPagina.txt_4c__dt_final.Value = .this_dDtFinal
1519:                 ENDIF
1520:                 loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(.this_cCdGrEstoque)
1521:                 loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(.this_cDsGrEstoque)
1522:                 loc_oPagina.txt_4c__cd_estoque.Value   = ALLTRIM(.this_cCdEstoque)
1523:                 loc_oPagina.txt_4c__ds_estoque.Value   = ALLTRIM(.this_cDsEstoque)
1524:                 loc_oPagina.txt_4c__cd_moeda.Value     = ALLTRIM(.this_cCdMoeda)
1525:                 loc_oPagina.txt_4c__ds_moeda.Value     = ALLTRIM(.this_cDsMoeda)
1526:                 loc_oPagina.obj_4c_OptSNA.Value        = .this_nOptSNA
1527:                 loc_oPagina.obj_4c_OptTipo.Value       = .this_nOptTipo
1528:                 loc_oPagina.obj_4c_OptQuebras.Value    = .this_nOptQuebras
1529:                 loc_oPagina.chk_4c_OptPenPag.Value     = .this_nOptPenPag
1530:             ENDWITH
1531:         CATCH TO loc_oErro
1532:             MsgErro(loc_oErro.Message, "BOParaForm")
1533:         ENDTRY
1534:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigrecorBO.prg):
*==============================================================================
* SIGRECORBO.PRG
* Business Object para Relatorio de Comissao por Vendedor (filtro PenPag)
*
* Herda de RelatorioBase
* Tabela principal: SigCdCmm
*==============================================================================

DEFINE CLASS sigrecorBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Filtros: moeda
    this_cCdMoeda     = ""
    this_cDsMoeda     = ""

    *-- Filtros: grupo de estoque/contabilidade
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""

    *-- Filtros: conta de estoque/contabilidade
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Opcoes do relatorio
    *-- this_nOptTipo: 1=Analitico  2=Sintetico  3=Resumo
    this_nOptTipo     = 1

    *-- this_nOptSNA: 1=Sim  2=Nao  3=Ambos  (default=3)
    this_nOptSNA      = 3

    *-- this_nOptQuebras: 1=Datas  2=Data+Movimentacao  3=Cliente
    this_nOptQuebras  = 1

    *-- this_nOptPenPag: 0=Nao  1=Sim (PenPag: pagamento em aberto)
    this_nOptPenPag   = 0

    *-- Cursores de saida do relatorio
    this_cCursorAnalitico = "cursor_4c_Analitico"
    this_cCursorCabecalho = "cursor_4c_Cabecalho"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCmm"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTabela) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     STR(THIS.this_nOptTipo, 1) + "|" + ;
                     STR(THIS.this_nOptSNA, 1) + "|" + ;
                     STR(THIS.this_nOptQuebras, 1) + "|" + ;
                     STR(THIS.this_nOptPenPag, 1)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros salva previamente.
    * par_cAliasCursor: alias do cursor com colunas DtInicial, DtFinal,
    *   CdMoeda, DsMoeda, CdGrEstoque, DsGrEstoque, CdEstoque, DsEstoque,
    *   OptTipo, OptSNA, OptQuebras, OptPenPag
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".CdGrEstoque") = "C"
                    THIS.this_cCdGrEstoque = EVALUATE(loc_cAlias + ".CdGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrEstoque") = "C"
                    THIS.this_cDsGrEstoque = EVALUATE(loc_cAlias + ".DsGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEstoque") = "C"
                    THIS.this_cCdEstoque = EVALUATE(loc_cAlias + ".CdEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEstoque") = "C"
                    THIS.this_cDsEstoque = EVALUATE(loc_cAlias + ".DsEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".OptTipo") = "N"
                    THIS.this_nOptTipo = EVALUATE(loc_cAlias + ".OptTipo")
                ENDIF
                IF TYPE(loc_cAlias + ".OptSNA") = "N"
                    THIS.this_nOptSNA = EVALUATE(loc_cAlias + ".OptSNA")
                ENDIF
                IF TYPE(loc_cAlias + ".OptQuebras") = "N"
                    THIS.this_nOptQuebras = EVALUATE(loc_cAlias + ".OptQuebras")
                ENDIF
                IF TYPE(loc_cAlias + ".OptPenPag") = "N"
                    THIS.this_nOptPenPag = EVALUATE(loc_cAlias + ".OptPenPag")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Comissao por Vendedor
    * Replica logica do procedimento 'processamento' do legado SIGRECOR
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_lErroNoScan, loc_oErro
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_cMoeda, loc_nCot1, loc_nCot
        LOCAL loc_cGrupo, loc_cConta, loc_cCdMoeda, loc_cDsMoeda
        LOCAL loc_nTip, loc_nOpt, loc_nPenPag
        LOCAL loc_cNmEmpresa, loc_cNmTitulo
        LOCAL loc_cCta, loc_cNvends
        LOCAL loc_nReg, loc_nValA, loc_nValR
        LOCAL loc_nComiAtual, loc_cHistPat, loc_cEdn

        loc_lResultado  = .F.
        loc_lErroNoScan = .F.

        TRY
            loc_cMoeda   = "AU"
            loc_nCot1    = THIS.BuscarCotacao(loc_cMoeda, DATE())
            loc_cGrupo   = PADR(THIS.this_cCdGrEstoque, 10)
            loc_cConta   = PADR(THIS.this_cCdEstoque, 10)
            loc_cCdMoeda = ALLTRIM(THIS.this_cCdMoeda)
            loc_cDsMoeda = ALLTRIM(THIS.this_cDsMoeda)
            loc_nTip     = THIS.this_nOptTipo
            loc_nOpt     = THIS.this_nOptSNA
            loc_nPenPag  = THIS.this_nOptPenPag

            *-- Busca nome da empresa
            loc_cNmEmpresa = ""
            loc_cSQL = "SELECT razas FROM SigCdEmp" + ;
                       " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    loc_cNmEmpresa = ALLTRIM(razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta titulo do relatorio
            loc_cNmTitulo = "Comiss" + CHR(227) + "o em " + PROPER(loc_cDsMoeda) + ;
                            " de " + DTOC(THIS.this_dDtInicial) + ;
                            " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                            IIF(loc_nTip = 1, "Anal" + CHR(237) + "tico", ;
                                IIF(loc_nTip = 2, "Sint" + CHR(233) + "tico", "Resumido")) + ;
                            " - Op" + CHR(231) + CHR(227) + "o: " + ;
                            IIF(loc_nOpt = 1, "Sim", ;
                                IIF(loc_nOpt = 2, "N" + CHR(227) + "o", "Ambos"))

            *-- Cursor cabecalho
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80))
            INSERT INTO cursor_4c_Cabecalho (NomeEmpresa, Titulo) ;
                VALUES (loc_cNmEmpresa, loc_cNmTitulo)

            *-- Cursor analitico de saida
            IF USED("cursor_4c_Analitico")
                USE IN cursor_4c_Analitico
            ENDIF
            CREATE CURSOR cursor_4c_Analitico ;
                (Vends C(10), NVends C(50), Comis N(9,4), Valos N(12,4), ;
                 Datas D(8), EmpDopNums C(29), ContaDs C(10), RClis C(40), ;
                 Notas C(6), Dopes C(20), VlBaixas N(12,4), moedas C(3), ;
                 VlPago N(12,4), VlComi N(12,4), VlPagoR N(12,4), VlComiR N(12,4))

            *-- Indice conforme tipo e quebra de relatorio
            DO CASE
                CASE (loc_nTip = 1)
                    IF THIS.this_nOptQuebras <> 3
                        INDEX ON Vends + DTOS(Datas) + EmpDopNums + moedas TAG VendDatas
                    ELSE
                        INDEX ON Vends + RClis + moedas TAG VendDatas
                    ENDIF
                CASE (loc_nTip = 2)
                    INDEX ON Vends + moedas TAG VendDatas
                OTHERWISE
                    INDEX ON Vends + DTOS(Datas) + Dopes + moedas TAG VendDatas
            ENDCASE

            *-- Query principal em SigCdCmm com filtros de periodo/grupo/conta/moeda
            loc_cSQL = "SELECT * FROM SigCdCmm" + ;
                       " WHERE datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            IF !EMPTY(ALLTRIM(loc_cGrupo))
                loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(ALLTRIM(loc_cConta))
                loc_cSQL = loc_cSQL + " AND contas = " + EscaparSQL(loc_cConta)
            ENDIF
            IF !EMPTY(loc_cCdMoeda)
                loc_cSQL = loc_cSQL + " AND moedas = " + EscaparSQL(loc_cCdMoeda)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cmm")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                loc_lErroNoScan = .T.
            ENDIF

            *-- SCAN principal: processa cada registro de comissao
            IF !loc_lErroNoScan
                SELECT cursor_4c_Cmm
                SCAN WHILE !loc_lErroNoScan

                    *-- Busca cabecalho do movimento correspondente
                    loc_cSQL = "SELECT Emps, Dopes, Datas, Numes, Notas, Valos," + ;
                               " GrVends, Vends, EmpDopNums, ContaDs FROM SigMvCab" + ;
                               " WHERE EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Cmm.EmpDopNums)) + ;
                               " ORDER BY Emps, Dopes, Datas, Numes, Notas," + ;
                               " Valos, GrVends, Vends, EmpDopNums, ContaDs"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvCab"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    IF !EOF("cursor_4c_MvCab")
                        SELECT cursor_4c_Analitico
                        APPEND BLANK

                        *-- Busca descricao para ContaDs do movimento
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_MvCab.ContaDs))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli1")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (ContaDs)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cCta = ""
                        SELECT cursor_4c_Cli1
                        IF !EOF()
                            loc_cCta = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli1

                        *-- Busca nome do vendedor via Contas da comissao
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli2")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (Contas)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cNvends = ""
                        SELECT cursor_4c_Cli2
                        GO TOP
                        IF !EOF()
                            loc_cNvends = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli2

                        SELECT cursor_4c_Analitico
                        REPLACE Vends  WITH cursor_4c_Cmm.Contas, ;
                                NVends WITH loc_cNvends IN cursor_4c_Analitico

                        *-- Verifica se operacao e estorno de comissao
                        loc_cSQL = "SELECT calcfecs FROM SigCdOpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.dopes))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdOpe"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        SELECT cursor_4c_Ope
                        IF !EOF() AND cursor_4c_Ope.calcfecs = 1
                            SELECT cursor_4c_Cmm
                            REPLACE bases     WITH -cursor_4c_Cmm.bases     IN cursor_4c_Cmm
                            REPLACE comissaos WITH -cursor_4c_Cmm.comissaos IN cursor_4c_Cmm
                        ENDIF
                        USE IN cursor_4c_Ope

                        *-- Processamento de PenPag (pagamento em aberto)
                        IF loc_nPenPag = 1
                            loc_nReg = RECNO("cursor_4c_Analitico")
                            SELECT cursor_4c_Analitico
                            LOCATE FOR EmpDopNums = cursor_4c_Cmm.EmpDopNums
                            IF !FOUND()
                                GO loc_nReg
                            ELSE
                                REPLACE VlComi WITH VlComi + VlPago IN cursor_4c_Analitico
                            ENDIF

                            *-- Busca valor ja pago ao vendedor via lancamentos
                            loc_cHistPat = ALLTRIM(cursor_4c_Cmm.emps) + ;
                                           ALLTRIM(cursor_4c_Cmm.dopes) + " " + ;
                                           ALLTRIM(STR(cursor_4c_Cmm.numes))
                            loc_cSQL = "SELECT b.acertos AS vlPago, a.cotacaos," + ;
                                       " a.moedas, b.moedas AS moepit" + ;
                                       " FROM sigmvCcr a, sigcdpit b" + ;
                                       " WHERE a.nopers = b.nopers" + ;
                                       " AND a.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND a.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND b.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.hists LIKE '" + loc_cHistPat + "%'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pag")
                            IF loc_nResult < 0
                                THIS.this_cMensagemErro = "Erro ao buscar pagamentos"
                                loc_lErroNoScan = .T.
                                EXIT
                            ENDIF

                            loc_nCot = THIS.BuscarCotacao(loc_cMoeda, DATE())

                            IF ALLTRIM(cursor_4c_Cmm.moedas) = loc_cMoeda
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + cursor_4c_Cmm.comissaos ;
                                            IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos + loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos - loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ELSE
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + ;
                                        ROUND(cursor_4c_Cmm.comissaos / loc_nCot, 2) ;
                                        IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    loc_nValR = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                        loc_nValR = loc_nValR + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                ROUND(cursor_4c_Pag.vlPago * ;
                                                      cursor_4c_Pag.cotacaos, 2), ;
                                                cursor_4c_Pag.vlPago)
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos + ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos - ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_Pag")
                                USE IN cursor_4c_Pag
                            ENDIF
                        ENDIF

                        *-- Preenche campos conforme tipo de relatorio
                        IF (loc_nTip = 1)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas      WITH cursor_4c_MvCab.Datas, ;
                                    EmpDopNums WITH cursor_4c_MvCab.EmpDopNums, ;
                                    Notas      WITH cursor_4c_MvCab.Notas, ;
                                    ContaDs    WITH cursor_4c_MvCab.ContaDs, ;
                                    RClis      WITH loc_cCta IN cursor_4c_Analitico
                        ENDIF
                        IF (loc_nTip = 3)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas WITH cursor_4c_MvCab.Datas, ;
                                    Dopes WITH cursor_4c_MvCab.Dopes IN cursor_4c_Analitico
                        ENDIF

                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ENDIF

                    *-- Acumula valores base no cursor analitico (sempre executa)
                    loc_nComiAtual = cursor_4c_Cmm.comissaos
                    SELECT cursor_4c_Analitico
                    REPLACE valos    WITH valos + cursor_4c_Cmm.bases     IN cursor_4c_Analitico
                    REPLACE comis    WITH comis + loc_nComiAtual           IN cursor_4c_Analitico
                    REPLACE vlbaixas WITH vlbaixas + cursor_4c_Cmm.Baixas IN cursor_4c_Analitico
                    REPLACE moedas   WITH cursor_4c_Cmm.moedas            IN cursor_4c_Analitico
                    SELECT cursor_4c_Cmm

                ENDSCAN

                IF USED("cursor_4c_Cmm")
                    USE IN cursor_4c_Cmm
                ENDIF
            ENDIF

            *-- Pos-processamento tipo Analitico: busca numeros de NF nos subnivels
            IF !loc_lErroNoScan AND (loc_nTip = 1)
                SELECT cursor_4c_Analitico
                SET ORDER TO
                GO TOP
                SCAN WHILE !loc_lErroNoScan
                    loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps," + ;
                               " o.Dopes, RIGHT(a.Codigos, 6) AS Numes" + ;
                               " FROM SigMvPec a, SigMvCab b, SigCdOpe o" + ;
                               " WHERE a.EmpDopNums = b.EmpDopNums" + ;
                               " AND LEFT(a.Codigos, 3) = o.NDopes" + ;
                               " AND a.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ;
                               " AND a.EmpDopNums NOT IN" + ;
                               " (SELECT n.EmpDopNums FROM SigMvNfi n" + ;
                               " WHERE n.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sub")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvPec"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_Sub
                    GO TOP
                    IF !EOF()
                        loc_cEdn = ALLTRIM(cursor_4c_Sub.Emps) + ;
                                   ALLTRIM(cursor_4c_Sub.Dopes) + ;
                                   STR(INT(VAL(ALLTRIM(cursor_4c_Sub.Numes))), 6)
                        loc_cSQL = "SELECT b.NFis, b.EmpDopNums FROM SigMvNfi b" + ;
                                   " WHERE b.EmpDopNums = " + EscaparSQL(loc_cEdn)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NF")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigMvNfi"
                            loc_lErroNoScan = .T.
                            USE IN cursor_4c_Sub
                            EXIT
                        ENDIF
                        SELECT cursor_4c_NF
                        GO TOP
                        IF !EOF()
                            SELECT cursor_4c_Analitico
                            REPLACE EmpDopNums WITH cursor_4c_NF.EmpDopNums, ;
                                    Notas      WITH cursor_4c_NF.NFis IN cursor_4c_Analitico
                        ENDIF
                        IF USED("cursor_4c_NF")
                            USE IN cursor_4c_NF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Sub")
                        USE IN cursor_4c_Sub
                    ENDIF
                    SELECT cursor_4c_Analitico
                ENDSCAN
            ENDIF

            *-- Aplica filtros SNA (Sim/Nao/Ambos) e filtro PenPag
            IF !loc_lErroNoScan
                SELECT cursor_4c_Analitico
                DO CASE
                    CASE (loc_nOpt = 1)
                        DELETE FROM cursor_4c_Analitico WHERE EMPTY(Notas)
                    CASE (loc_nOpt = 2)
                        DELETE FROM cursor_4c_Analitico WHERE !EMPTY(Notas)
                ENDCASE

                IF loc_nPenPag = 1
                    DELETE FROM cursor_4c_Analitico WHERE VlComi = 0
                ENDIF

                SELECT cursor_4c_Analitico
                SET ORDER TO VendDatas
                GO TOP

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaImprimir()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaVisualizar()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaImprimir - Seleciona FRX conforme opcoes de impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaImprimir()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                IF THIS.this_nOptQuebras = 1
                    RETURN "SigReCr1"
                ELSE
                    RETURN "SigReCr2"
                ENDIF
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaVisualizar - Seleciona FRX conforme opcoes de preview
    * (opcao de quebra 3 = SigReCr6, exclusivo para preview)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaVisualizar()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                DO CASE
                    CASE THIS.this_nOptQuebras = 1
                        RETURN "SigReCr1"
                    CASE THIS.this_nOptQuebras = 2
                        RETURN "SigReCr2"
                    OTHERWISE
                        RETURN "SigReCr6"
                ENDCASE
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao mais recente da moeda ate a data informada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nResult, loc_nCotacao, loc_cSQL, loc_oErro
        loc_nCotacao = 1.00
        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
                       " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC, horas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotBusca")
            IF loc_nResult > 0
                SELECT cursor_4c_CotBusca
                GO TOP
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1.00)
                ENDIF
                USE IN cursor_4c_CotBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCotacao
    ENDPROC

ENDDEFINE

