# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Get_grupo' (parent: SIGCDCCR.Pagina.Dados.PageFrame1.Geral): Left original=486 vs migrado 'Get_grupo' Left=179 (diff=307px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (6822 linhas total):

*-- Linhas 60 a 69:
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                     THIS.CarregarLista()
68:                 ENDIF
69: 

*-- Linhas 89 a 106:
89: 
90:         WITH loc_oPgf
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()

*-- Linhas 118 a 156:
118:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oCab.lbl_4c_Sombra
132:             .AutoSize  = .F.
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .AutoSize  = .F.
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 163 a 187:
163:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
164:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
165:         WITH loc_oBotoes
166:             .Top         = 29
167:             .Left        =  542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackColor   = RGB(53, 53, 53)
171:             .BackStyle   = 1
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oBotoes.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 75
185:             .BackColor       = RGB(255, 255, 255)
186:             .ForeColor       = RGB(90, 90, 90)
187:             .FontName        = "Tahoma"

*-- Linhas 196 a 210:
196:             .Visible         = .T.
197:         ENDWITH
198: 
199:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oBotoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .BackColor       = RGB(255, 255, 255)
209:             .ForeColor       = RGB(90, 90, 90)
210:             .FontName        = "Tahoma"

*-- Linhas 219 a 233:
219:             .Visible         = .T.
220:         ENDWITH
221: 
222:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oBotoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .BackColor       = RGB(255, 255, 255)
232:             .ForeColor       = RGB(90, 90, 90)
233:             .FontName        = "Tahoma"

*-- Linhas 242 a 256:
242:             .Visible         = .T.
243:         ENDWITH
244: 
245:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
246:         WITH loc_oBotoes.cmd_4c_Excluir
247:             .Caption         = "Excluir"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:             .PicturePosition = 13
250:             .Top             = 5
251:             .Left            = 230
252:             .Width           = 75
253:             .Height          = 75
254:             .BackColor       = RGB(255, 255, 255)
255:             .ForeColor       = RGB(90, 90, 90)
256:             .FontName        = "Tahoma"

*-- Linhas 265 a 279:
265:             .Visible         = .T.
266:         ENDWITH
267: 
268:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
269:         WITH loc_oBotoes.cmd_4c_Buscar
270:             .Caption         = "Buscar"
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:             .PicturePosition = 13
273:             .Top             = 5
274:             .Left            = 305
275:             .Width           = 75
276:             .Height          = 75
277:             .BackColor       = RGB(255, 255, 255)
278:             .ForeColor       = RGB(90, 90, 90)
279:             .FontName        = "Tahoma"

*-- Linhas 288 a 321:
288:             .Visible         = .T.
289:         ENDWITH
290: 
291:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
294:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
295:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Encerrar (canonico: Left=917, Width=90, Height=85)
298:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
299:         loc_oSaida = loc_oPg1.cnt_4c_Saida
300:         WITH loc_oSaida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
311:         WITH loc_oSaida.cmd_4c_Encerrar
312:             .Caption         = "Encerrar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
314:             .PicturePosition = 13
315:             .Top             = 5
316:             .Left            = 5
317:             .Width           = 75
318:             .Height          = 75
319:             .BackColor       = RGB(255, 255, 255)
320:             .ForeColor       = RGB(90, 90, 90)
321:             .FontName        = "Tahoma"

*-- Linhas 330 a 349:
330:             .Visible         = .T.
331:         ENDWITH
332: 
333:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid de lista
336:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
337:         loc_oGrid = loc_oPg1.grd_4c_Lista
338: 
339:         loc_oGrid.RecordSource = ""
340:         loc_oGrid.ColumnCount  = 2
341: 
342:         WITH loc_oGrid
343:             .Top                = 117
344:             .Left               = 26
345:             .Width              = 945
346:             .Height             = 460
347:             .FontName           = "Verdana"
348:             .FontSize           = 8
349:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 375 a 398:
375:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
376:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
377:         WITH loc_oBotoesAcao
378:             .Top         = 33
379:             .Left        = 838
380:             .Width       = 160
381:             .Height      = 85
382:             .BackStyle   = 0
383:             .BorderWidth = 0
384:             .Visible     = .T.
385:         ENDWITH
386: 
387:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
388:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
389:             .Caption         = "Confirmar"
390:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
391:             .PicturePosition = 13
392:             .Top             = 5
393:             .Left            = 5
394:             .Width           = 75
395:             .Height          = 75
396:             .BackColor       = RGB(255, 255, 255)
397:             .ForeColor       = RGB(90, 90, 90)
398:             .FontName        = "Tahoma"

*-- Linhas 407 a 421:
407:             .Visible         = .T.
408:         ENDWITH
409: 
410:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
411:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
412:             .Caption         = "Encerrar"
413:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
414:             .PicturePosition = 13
415:             .Top             = 5
416:             .Left            = 80
417:             .Width           = 75
418:             .Height          = 75
419:             .BackColor       = RGB(255, 255, 255)
420:             .ForeColor       = RGB(90, 90, 90)
421:             .FontName        = "Tahoma"

*-- Linhas 430 a 446:
430:             .Visible         = .T.
431:         ENDWITH
432: 
433:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
434:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
435: 
436:         *-- Label + TextBox Codigo
437:         loc_oPg2.AddObject("lbl_4c_LblCodigo", "Label")
438:         WITH loc_oPg2.lbl_4c_LblCodigo
439:             .Caption   = "C" + CHR(243) + "digo:"
440:             .Top       = 47
441:             .Left      = 39
442:             .Width     = 42
443:             .Height    = 17
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 452 a 461:
452:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
453:         WITH loc_oPg2.txt_4c_Codigo
454:             .Value         = ""
455:             .Top           = 43
456:             .Left          = 83
457:             .Width         = 80
458:             .Height        = 23
459:             .MaxLength     = 10
460:             .FontName      = "Tahoma"
461:             .FontSize      = 8

*-- Linhas 467 a 479:
467:         ENDWITH
468: 
469:         *-- Label + TextBox Digito
470:         loc_oPg2.AddObject("lbl_4c_LblDigito", "Label")
471:         WITH loc_oPg2.lbl_4c_LblDigito
472:             .Caption   = "D" + CHR(237) + "g:"
473:             .Top       = 47
474:             .Left      = 176
475:             .Width     = 35
476:             .Height    = 17
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 485 a 494:
485:         loc_oPg2.AddObject("txt_4c_Digito", "TextBox")
486:         WITH loc_oPg2.txt_4c_Digito
487:             .Value         = ""
488:             .Top           = 43
489:             .Left          = 214
490:             .Width         = 19
491:             .Height        = 23
492:             .MaxLength     = 1
493:             .FontName      = "Tahoma"
494:             .FontSize      = 8

*-- Linhas 500 a 512:
500:         ENDWITH
501: 
502:         *-- Label + TextBox Descricao
503:         loc_oPg2.AddObject("lbl_4c_LblDescr", "Label")
504:         WITH loc_oPg2.lbl_4c_LblDescr
505:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
506:             .Top       = 47
507:             .Left      = 261
508:             .Width     = 55
509:             .Height    = 17
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 518 a 527:
518:         loc_oPg2.AddObject("txt_4c_Descr", "TextBox")
519:         WITH loc_oPg2.txt_4c_Descr
520:             .Value         = ""
521:             .Top           = 43
522:             .Left          = 318
523:             .Width         = 290
524:             .Height        = 23
525:             .MaxLength     = 40
526:             .FontName      = "Tahoma"
527:             .FontSize      = 8

*-- Linhas 533 a 545:
533:         ENDWITH
534: 
535:         *-- Label + TextBox Interno
536:         loc_oPg2.AddObject("lbl_4c_LblInterno", "Label")
537:         WITH loc_oPg2.lbl_4c_LblInterno
538:             .Caption   = "Interno:"
539:             .Top       = 73
540:             .Left      = 36
541:             .Width     = 45
542:             .Height    = 17
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 551 a 560:
551:         loc_oPg2.AddObject("txt_4c_Interno", "TextBox")
552:         WITH loc_oPg2.txt_4c_Interno
553:             .Value         = ""
554:             .Top           = 69
555:             .Left          = 83
556:             .Width         = 150
557:             .Height        = 23
558:             .MaxLength     = 20
559:             .FontName      = "Tahoma"
560:             .FontSize      = 8

*-- Linhas 566 a 578:
566:         ENDWITH
567: 
568:         *-- Label + TextBox Classe + DClasses
569:         loc_oPg2.AddObject("lbl_4c_LblClasse", "Label")
570:         WITH loc_oPg2.lbl_4c_LblClasse
571:             .Caption   = "Classe:"
572:             .Top       = 71
573:             .Left      = 276
574:             .Width     = 40
575:             .Height    = 17
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 584 a 593:
584:         loc_oPg2.AddObject("txt_4c_Classes", "TextBox")
585:         WITH loc_oPg2.txt_4c_Classes
586:             .Value         = ""
587:             .Top           = 68
588:             .Left          = 318
589:             .Width         = 80
590:             .Height        = 23
591:             .MaxLength     = 10
592:             .FontName      = "Tahoma"
593:             .FontSize      = 8

*-- Linhas 601 a 610:
601:         loc_oPg2.AddObject("txt_4c_DClasses", "TextBox")
602:         WITH loc_oPg2.txt_4c_DClasses
603:             .Value         = ""
604:             .Top           = 68
605:             .Left          = 400
606:             .Width         = 290
607:             .Height        = 23
608:             .FontName      = "Tahoma"
609:             .FontSize      = 8
610:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 620 a 632:
620:         BINDEVENT(loc_oPg2.txt_4c_Classes, "KeyPress", THIS, "ClassesLostFocus")
621: 
622:         *-- Label + OptionGroup Codificacao
623:         loc_oPg2.AddObject("lbl_4c_LblTpCods", "Label")
624:         WITH loc_oPg2.lbl_4c_LblTpCods
625:             .Caption   = "Codifica" + CHR(231) + CHR(227) + "o:"
626:             .Top       = 100
627:             .Left      = 17
628:             .Width     = 64
629:             .Height    = 17
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 638 a 679:
638:         loc_oPg2.AddObject("obj_4c_Opt_TpCods", "OptionGroup")
639:         WITH loc_oPg2.obj_4c_Opt_TpCods
640:             .ButtonCount = 2
641:             .Top         = 94
642:             .Left        = 83
643:             .Width       = 150
644:             .Height      = 23
645:             .BackStyle   = 0
646:             .BorderStyle = 0
647:             .Value       = 1
648:             .Visible     = .T.
649:         ENDWITH
650: 
651:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Caption   = "Simples"
652:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Left      = 5
653:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Top       = 3
654:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Width     = 65
655:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).FontName  = "Tahoma"
656:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).FontSize  = 8
657:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).ForeColor = RGB(90, 90, 90)
658:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Themes    = .F.
659: 
660:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Caption   = "Composto"
661:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Left      = 75
662:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Top       = 3
663:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Width     = 70
664:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).FontName  = "Tahoma"
665:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).FontSize  = 8
666:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).ForeColor = RGB(90, 90, 90)
667:         loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Themes    = .F.
668: 
669:         *-- Label + OptionGroup Incluir Empresa
670:         loc_oPg2.AddObject("lbl_4c_LblTpEmps", "Label")
671:         WITH loc_oPg2.lbl_4c_LblTpEmps
672:             .Caption   = "Incluir Empresa:"
673:             .Top       = 97
674:             .Left      = 318
675:             .Width     = 90
676:             .Height    = 17
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 685 a 735:
685:         loc_oPg2.AddObject("obj_4c_Opt_TpEmps", "OptionGroup")
686:         WITH loc_oPg2.obj_4c_Opt_TpEmps
687:             .ButtonCount = 3
688:             .Top         = 93
689:             .Left        = 459
690:             .Width       = 225
691:             .Height      = 23
692:             .BackStyle   = 0
693:             .BorderStyle = 0
694:             .Value       = 1
695:             .Visible     = .T.
696:         ENDWITH
697: 
698:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Caption   = "N" + CHR(227) + "o"
699:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Left      = 5
700:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Top       = 3
701:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Width     = 40
702:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).FontName  = "Tahoma"
703:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).FontSize  = 8
704:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).ForeColor = RGB(90, 90, 90)
705:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Themes    = .F.
706: 
707:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Caption   = "Sim"
708:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Left      = 50
709:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Top       = 3
710:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Width     = 40
711:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).FontName  = "Tahoma"
712:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).FontSize  = 8
713:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).ForeColor = RGB(90, 90, 90)
714:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Themes    = .F.
715: 
716:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Caption   = "Obrigat" + CHR(243) + "rio"
717:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Left      = 95
718:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Top       = 3
719:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Width     = 85
720:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).FontName  = "Tahoma"
721:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).FontSize  = 8
722:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).ForeColor = RGB(90, 90, 90)
723:         loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Themes    = .F.
724: 
725:         *-- Label + OptionGroup Tipo
726:         loc_oPg2.AddObject("lbl_4c_LblTpCads", "Label")
727:         WITH loc_oPg2.lbl_4c_LblTpCads
728:             .Caption   = "Tipo:"
729:             .Top       = 124
730:             .Left      = 52
731:             .Width     = 30
732:             .Height    = 17
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 741 a 770:
741:         loc_oPg2.AddObject("obj_4c_Opt_TpCads", "OptionGroup")
742:         WITH loc_oPg2.obj_4c_Opt_TpCads
743:             .ButtonCount = 2
744:             .Top         = 120
745:             .Left        = 83
746:             .Width       = 150
747:             .Height      = 23
748:             .BackStyle   = 0
749:             .BorderStyle = 0
750:             .Value       = 1
751:             .Visible     = .T.
752:         ENDWITH
753: 
754:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Caption   = "Pessoa F" + CHR(237) + "sica"
755:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Left      = 5
756:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Top       = 3
757:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Width     = 70
758:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).FontName  = "Tahoma"
759:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).FontSize  = 8
760:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).ForeColor = RGB(90, 90, 90)
761:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Themes    = .F.
762: 
763:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Caption   = "Pessoa Jur" + CHR(237) + "dica"
764:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Left      = 80
765:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Top       = 3
766:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Width     = 70
767:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).FontName  = "Tahoma"
768:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).FontSize  = 8
769:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).ForeColor = RGB(90, 90, 90)
770:         loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Themes    = .F.

*-- Linhas 784 a 802:
784:         loc_oPgf1 = par_oPg2.pgf_4c_1
785: 
786:         WITH loc_oPgf1
787:             .Top       = 146
788:             .Left      = 1
789:             .Width     = 998
790:             .Height    = 454
791:             .Tabs      = .T.
792:             .PageCount = 4
793:             .Visible   = .T.
794:             .Page1.Caption = "Geral"
795:             .Page2.Caption = "Cadastro"
796:             .Page3.Caption = "Estoque"
797:             .Page4.Caption = "Faturamento"
798:         ENDWITH
799: 
800:         THIS.CriarAbaGeral(loc_oPgf1.Page1)
801:         THIS.CriarAbaCadastro(loc_oPgf1.Page2)
802:         THIS.CriarAbaEstoque(loc_oPgf1.Page3)

*-- Linhas 811 a 823:
811: 
812:         *-- Coluna esquerda: opcoes gerais (Left ~92-165)
813:         *-- Complemento
814:         par_oPg.AddObject("lbl_4c_LblComple", "Label")
815:         WITH par_oPg.lbl_4c_LblComple
816:             .Caption = "Complemento:"
817:             .Top = 18
818:             .Left = 92
819:             .Width = 72
820:             .Height = 17
821:             .FontName = "Tahoma"
822:             .FontSize = 8
823:             .ForeColor = RGB(90,90,90)

*-- Linhas 830 a 869:
830:         loc_oOpt = par_oPg.obj_4c_Opt_Comple
831:         WITH loc_oOpt
832:             .ButtonCount = 2
833:             .Top = 15
834:             .Left = 165
835:             .Width = 97
836:             .Height = 23
837:             .BackStyle = 0
838:             .BorderStyle = 0
839:             .Value = 1
840:             .Visible = .T.
841:         ENDWITH
842:         loc_oOpt.Buttons(1).Caption = "Sim"
843:         loc_oOpt.Buttons(1).Left = 5
844:         loc_oOpt.Buttons(1).Top = 3
845:         loc_oOpt.Buttons(1).Width = 40
846:         loc_oOpt.Buttons(1).FontName = "Tahoma"
847:         loc_oOpt.Buttons(1).FontSize = 8
848:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
849:         loc_oOpt.Buttons(1).Themes = .F.
850:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
851:         loc_oOpt.Buttons(2).Left = 48
852:         loc_oOpt.Buttons(2).Top = 3
853:         loc_oOpt.Buttons(2).Width = 44
854:         loc_oOpt.Buttons(2).FontName = "Tahoma"
855:         loc_oOpt.Buttons(2).FontSize = 8
856:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
857:         loc_oOpt.Buttons(2).Themes = .F.
858: 
859:         *-- Dados Pessoais
860:         par_oPg.AddObject("lbl_4c_LblPessoais", "Label")
861:         WITH par_oPg.lbl_4c_LblPessoais
862:             .Caption = "Dados Pessoais:"
863:             .Top = 44
864:             .Left = 83
865:             .Width = 80
866:             .Height = 17
867:             .FontName = "Tahoma"
868:             .FontSize = 8
869:             .ForeColor = RGB(90,90,90)

*-- Linhas 876 a 915:
876:         loc_oOpt = par_oPg.obj_4c_Opt_Pessoais
877:         WITH loc_oOpt
878:             .ButtonCount = 2
879:             .Top = 41
880:             .Left = 165
881:             .Width = 97
882:             .Height = 23
883:             .BackStyle = 0
884:             .BorderStyle = 0
885:             .Value = 1
886:             .Visible = .T.
887:         ENDWITH
888:         loc_oOpt.Buttons(1).Caption = "Sim"
889:         loc_oOpt.Buttons(1).Left = 5
890:         loc_oOpt.Buttons(1).Top = 3
891:         loc_oOpt.Buttons(1).Width = 40
892:         loc_oOpt.Buttons(1).FontName = "Tahoma"
893:         loc_oOpt.Buttons(1).FontSize = 8
894:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
895:         loc_oOpt.Buttons(1).Themes = .F.
896:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
897:         loc_oOpt.Buttons(2).Left = 48
898:         loc_oOpt.Buttons(2).Top = 3
899:         loc_oOpt.Buttons(2).Width = 44
900:         loc_oOpt.Buttons(2).FontName = "Tahoma"
901:         loc_oOpt.Buttons(2).FontSize = 8
902:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
903:         loc_oOpt.Buttons(2).Themes = .F.
904: 
905:         *-- Ref. Bancarias
906:         par_oPg.AddObject("lbl_4c_LblRefbancs", "Label")
907:         WITH par_oPg.lbl_4c_LblRefbancs
908:             .Caption = "Ref. Banc" + CHR(225) + "rias:"
909:             .Top = 70
910:             .Left = 87
911:             .Width = 77
912:             .Height = 17
913:             .FontName = "Tahoma"
914:             .FontSize = 8
915:             .ForeColor = RGB(90,90,90)

*-- Linhas 922 a 961:
922:         loc_oOpt = par_oPg.obj_4c_Opt_RefBancs
923:         WITH loc_oOpt
924:             .ButtonCount = 2
925:             .Top = 67
926:             .Left = 165
927:             .Width = 97
928:             .Height = 23
929:             .BackStyle = 0
930:             .BorderStyle = 0
931:             .Value = 1
932:             .Visible = .T.
933:         ENDWITH
934:         loc_oOpt.Buttons(1).Caption = "Sim"
935:         loc_oOpt.Buttons(1).Left = 5
936:         loc_oOpt.Buttons(1).Top = 3
937:         loc_oOpt.Buttons(1).Width = 40
938:         loc_oOpt.Buttons(1).FontName = "Tahoma"
939:         loc_oOpt.Buttons(1).FontSize = 8
940:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
941:         loc_oOpt.Buttons(1).Themes = .F.
942:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
943:         loc_oOpt.Buttons(2).Left = 48
944:         loc_oOpt.Buttons(2).Top = 3
945:         loc_oOpt.Buttons(2).Width = 44
946:         loc_oOpt.Buttons(2).FontName = "Tahoma"
947:         loc_oOpt.Buttons(2).FontSize = 8
948:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
949:         loc_oOpt.Buttons(2).Themes = .F.
950: 
951:         *-- Follow-Up
952:         par_oPg.AddObject("lbl_4c_LblFollowUp", "Label")
953:         WITH par_oPg.lbl_4c_LblFollowUp
954:             .Caption = "Follow-Up:"
955:             .Top = 97
956:             .Left = 110
957:             .Width = 54
958:             .Height = 17
959:             .FontName = "Tahoma"
960:             .FontSize = 8
961:             .ForeColor = RGB(90,90,90)

*-- Linhas 968 a 1007:
968:         loc_oOpt = par_oPg.obj_4c_Opt_FollowUp
969:         WITH loc_oOpt
970:             .ButtonCount = 2
971:             .Top = 94
972:             .Left = 165
973:             .Width = 97
974:             .Height = 23
975:             .BackStyle = 0
976:             .BorderStyle = 0
977:             .Value = 1
978:             .Visible = .T.
979:         ENDWITH
980:         loc_oOpt.Buttons(1).Caption = "Sim"
981:         loc_oOpt.Buttons(1).Left = 5
982:         loc_oOpt.Buttons(1).Top = 3
983:         loc_oOpt.Buttons(1).Width = 40
984:         loc_oOpt.Buttons(1).FontName = "Tahoma"
985:         loc_oOpt.Buttons(1).FontSize = 8
986:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
987:         loc_oOpt.Buttons(1).Themes = .F.
988:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
989:         loc_oOpt.Buttons(2).Left = 48
990:         loc_oOpt.Buttons(2).Top = 3
991:         loc_oOpt.Buttons(2).Width = 44
992:         loc_oOpt.Buttons(2).FontName = "Tahoma"
993:         loc_oOpt.Buttons(2).FontSize = 8
994:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
995:         loc_oOpt.Buttons(2).Themes = .F.
996: 
997:         *-- Dados Fiscais
998:         par_oPg.AddObject("lbl_4c_LblFiscais", "Label")
999:         WITH par_oPg.lbl_4c_LblFiscais
1000:             .Caption = "Dados Fiscais:"
1001:             .Top = 123
1002:             .Left = 93
1003:             .Width = 71
1004:             .Height = 17
1005:             .FontName = "Tahoma"
1006:             .FontSize = 8
1007:             .ForeColor = RGB(90,90,90)

*-- Linhas 1014 a 1053:
1014:         loc_oOpt = par_oPg.obj_4c_Opt_Fiscais
1015:         WITH loc_oOpt
1016:             .ButtonCount = 2
1017:             .Top = 120
1018:             .Left = 165
1019:             .Width = 97
1020:             .Height = 23
1021:             .BackStyle = 0
1022:             .BorderStyle = 0
1023:             .Value = 1
1024:             .Visible = .T.
1025:         ENDWITH
1026:         loc_oOpt.Buttons(1).Caption = "Sim"
1027:         loc_oOpt.Buttons(1).Left = 5
1028:         loc_oOpt.Buttons(1).Top = 3
1029:         loc_oOpt.Buttons(1).Width = 40
1030:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1031:         loc_oOpt.Buttons(1).FontSize = 8
1032:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1033:         loc_oOpt.Buttons(1).Themes = .F.
1034:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1035:         loc_oOpt.Buttons(2).Left = 48
1036:         loc_oOpt.Buttons(2).Top = 3
1037:         loc_oOpt.Buttons(2).Width = 44
1038:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1039:         loc_oOpt.Buttons(2).FontSize = 8
1040:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1041:         loc_oOpt.Buttons(2).Themes = .F.
1042: 
1043:         *-- Dados Comerciais
1044:         par_oPg.AddObject("lbl_4c_LblDadcoms", "Label")
1045:         WITH par_oPg.lbl_4c_LblDadcoms
1046:             .Caption = "Dados Comerciais:"
1047:             .Top = 148
1048:             .Left = 73
1049:             .Width = 91
1050:             .Height = 17
1051:             .FontName = "Tahoma"
1052:             .FontSize = 8
1053:             .ForeColor = RGB(90,90,90)

*-- Linhas 1060 a 1099:
1060:         loc_oOpt = par_oPg.obj_4c_Opt_DadosCom
1061:         WITH loc_oOpt
1062:             .ButtonCount = 2
1063:             .Top = 146
1064:             .Left = 165
1065:             .Width = 97
1066:             .Height = 23
1067:             .BackStyle = 0
1068:             .BorderStyle = 0
1069:             .Value = 1
1070:             .Visible = .T.
1071:         ENDWITH
1072:         loc_oOpt.Buttons(1).Caption = "Sim"
1073:         loc_oOpt.Buttons(1).Left = 5
1074:         loc_oOpt.Buttons(1).Top = 3
1075:         loc_oOpt.Buttons(1).Width = 40
1076:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1077:         loc_oOpt.Buttons(1).FontSize = 8
1078:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1079:         loc_oOpt.Buttons(1).Themes = .F.
1080:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1081:         loc_oOpt.Buttons(2).Left = 48
1082:         loc_oOpt.Buttons(2).Top = 3
1083:         loc_oOpt.Buttons(2).Width = 44
1084:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1085:         loc_oOpt.Buttons(2).FontSize = 8
1086:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1087:         loc_oOpt.Buttons(2).Themes = .F.
1088: 
1089:         *-- Possui Responsavel
1090:         par_oPg.AddObject("lbl_4c_LblRespos", "Label")
1091:         WITH par_oPg.lbl_4c_LblRespos
1092:             .Caption = "Possui Respons" + CHR(225) + "vel:"
1093:             .Top = 174
1094:             .Left = 63
1095:             .Width = 101
1096:             .Height = 17
1097:             .FontName = "Tahoma"
1098:             .FontSize = 8
1099:             .ForeColor = RGB(90,90,90)

*-- Linhas 1106 a 1145:
1106:         loc_oOpt = par_oPg.obj_4c_Opt_Respos
1107:         WITH loc_oOpt
1108:             .ButtonCount = 2
1109:             .Top = 171
1110:             .Left = 165
1111:             .Width = 97
1112:             .Height = 23
1113:             .BackStyle = 0
1114:             .BorderStyle = 0
1115:             .Value = 1
1116:             .Visible = .T.
1117:         ENDWITH
1118:         loc_oOpt.Buttons(1).Caption = "Sim"
1119:         loc_oOpt.Buttons(1).Left = 5
1120:         loc_oOpt.Buttons(1).Top = 3
1121:         loc_oOpt.Buttons(1).Width = 40
1122:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1123:         loc_oOpt.Buttons(1).FontSize = 8
1124:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1125:         loc_oOpt.Buttons(1).Themes = .F.
1126:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1127:         loc_oOpt.Buttons(2).Left = 48
1128:         loc_oOpt.Buttons(2).Top = 3
1129:         loc_oOpt.Buttons(2).Width = 44
1130:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1131:         loc_oOpt.Buttons(2).FontSize = 8
1132:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1133:         loc_oOpt.Buttons(2).Themes = .F.
1134: 
1135:         *-- Limite de Credito
1136:         par_oPg.AddObject("lbl_4c_LblLimcres", "Label")
1137:         WITH par_oPg.lbl_4c_LblLimcres
1138:             .Caption = "Limite de Cr" + CHR(233) + "dito:"
1139:             .Top = 199
1140:             .Left = 77
1141:             .Width = 87
1142:             .Height = 17
1143:             .FontName = "Tahoma"
1144:             .FontSize = 8
1145:             .ForeColor = RGB(90,90,90)

*-- Linhas 1152 a 1191:
1152:         loc_oOpt = par_oPg.obj_4c_Opt_LimCre
1153:         WITH loc_oOpt
1154:             .ButtonCount = 2
1155:             .Top = 196
1156:             .Left = 165
1157:             .Width = 97
1158:             .Height = 23
1159:             .BackStyle = 0
1160:             .BorderStyle = 0
1161:             .Value = 1
1162:             .Visible = .T.
1163:         ENDWITH
1164:         loc_oOpt.Buttons(1).Caption = "Sim"
1165:         loc_oOpt.Buttons(1).Left = 5
1166:         loc_oOpt.Buttons(1).Top = 3
1167:         loc_oOpt.Buttons(1).Width = 40
1168:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1169:         loc_oOpt.Buttons(1).FontSize = 8
1170:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1171:         loc_oOpt.Buttons(1).Themes = .F.
1172:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1173:         loc_oOpt.Buttons(2).Left = 48
1174:         loc_oOpt.Buttons(2).Top = 3
1175:         loc_oOpt.Buttons(2).Width = 44
1176:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1177:         loc_oOpt.Buttons(2).FontSize = 8
1178:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1179:         loc_oOpt.Buttons(2).Themes = .F.
1180: 
1181:         *-- Comissao
1182:         par_oPg.AddObject("lbl_4c_LblComis", "Label")
1183:         WITH par_oPg.lbl_4c_LblComis
1184:             .Caption = "Comiss" + CHR(227) + "o:"
1185:             .Top = 225
1186:             .Left = 112
1187:             .Width = 52
1188:             .Height = 17
1189:             .FontName = "Tahoma"
1190:             .FontSize = 8
1191:             .ForeColor = RGB(90,90,90)

*-- Linhas 1198 a 1238:
1198:         loc_oOpt = par_oPg.obj_4c_Opt_Comi
1199:         WITH loc_oOpt
1200:             .ButtonCount = 2
1201:             .Top = 222
1202:             .Left = 165
1203:             .Width = 97
1204:             .Height = 23
1205:             .BackStyle = 0
1206:             .BorderStyle = 0
1207:             .Value = 1
1208:             .Visible = .T.
1209:         ENDWITH
1210:         loc_oOpt.Buttons(1).Caption = "Sim"
1211:         loc_oOpt.Buttons(1).Left = 5
1212:         loc_oOpt.Buttons(1).Top = 3
1213:         loc_oOpt.Buttons(1).Width = 40
1214:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1215:         loc_oOpt.Buttons(1).FontSize = 8
1216:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1217:         loc_oOpt.Buttons(1).Themes = .F.
1218:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1219:         loc_oOpt.Buttons(2).Left = 48
1220:         loc_oOpt.Buttons(2).Top = 3
1221:         loc_oOpt.Buttons(2).Width = 44
1222:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1223:         loc_oOpt.Buttons(2).FontSize = 8
1224:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1225:         loc_oOpt.Buttons(2).Themes = .F.
1226: 
1227:         *-- Coluna central: opcoes gerais (Left ~394-483)
1228:         *-- Dados da Empresa
1229:         par_oPg.AddObject("lbl_4c_LblEmpresas", "Label")
1230:         WITH par_oPg.lbl_4c_LblEmpresas
1231:             .Caption = "Dados da Empresa:"
1232:             .Top = 19
1233:             .Left = 386
1234:             .Width = 96
1235:             .Height = 17
1236:             .FontName = "Tahoma"
1237:             .FontSize = 8
1238:             .ForeColor = RGB(90,90,90)

*-- Linhas 1245 a 1284:
1245:         loc_oOpt = par_oPg.obj_4c_Opt_Empresa
1246:         WITH loc_oOpt
1247:             .ButtonCount = 2
1248:             .Top = 15
1249:             .Left = 483
1250:             .Width = 97
1251:             .Height = 23
1252:             .BackStyle = 0
1253:             .BorderStyle = 0
1254:             .Value = 1
1255:             .Visible = .T.
1256:         ENDWITH
1257:         loc_oOpt.Buttons(1).Caption = "Sim"
1258:         loc_oOpt.Buttons(1).Left = 5
1259:         loc_oOpt.Buttons(1).Top = 3
1260:         loc_oOpt.Buttons(1).Width = 40
1261:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1262:         loc_oOpt.Buttons(1).FontSize = 8
1263:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1264:         loc_oOpt.Buttons(1).Themes = .F.
1265:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1266:         loc_oOpt.Buttons(2).Left = 48
1267:         loc_oOpt.Buttons(2).Top = 3
1268:         loc_oOpt.Buttons(2).Width = 44
1269:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1270:         loc_oOpt.Buttons(2).FontSize = 8
1271:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1272:         loc_oOpt.Buttons(2).Themes = .F.
1273: 
1274:         *-- Dados Contabeis
1275:         par_oPg.AddObject("lbl_4c_LblContabs", "Label")
1276:         WITH par_oPg.lbl_4c_LblContabs
1277:             .Caption = "Dados Cont" + CHR(225) + "beis:"
1278:             .Top = 45
1279:             .Left = 394
1280:             .Width = 88
1281:             .Height = 17
1282:             .FontName = "Tahoma"
1283:             .FontSize = 8
1284:             .ForeColor = RGB(90,90,90)

*-- Linhas 1291 a 1330:
1291:         loc_oOpt = par_oPg.obj_4c_Opt_Contabs
1292:         WITH loc_oOpt
1293:             .ButtonCount = 2
1294:             .Top = 41
1295:             .Left = 483
1296:             .Width = 97
1297:             .Height = 23
1298:             .BackStyle = 0
1299:             .BorderStyle = 0
1300:             .Value = 1
1301:             .Visible = .T.
1302:         ENDWITH
1303:         loc_oOpt.Buttons(1).Caption = "Sim"
1304:         loc_oOpt.Buttons(1).Left = 5
1305:         loc_oOpt.Buttons(1).Top = 3
1306:         loc_oOpt.Buttons(1).Width = 40
1307:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1308:         loc_oOpt.Buttons(1).FontSize = 8
1309:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1310:         loc_oOpt.Buttons(1).Themes = .F.
1311:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1312:         loc_oOpt.Buttons(2).Left = 48
1313:         loc_oOpt.Buttons(2).Top = 3
1314:         loc_oOpt.Buttons(2).Width = 44
1315:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1316:         loc_oOpt.Buttons(2).FontSize = 8
1317:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1318:         loc_oOpt.Buttons(2).Themes = .F.
1319: 
1320:         *-- Caracteristicas
1321:         par_oPg.AddObject("lbl_4c_LblCaracteris", "Label")
1322:         WITH par_oPg.lbl_4c_LblCaracteris
1323:             .Caption = "Caracter" + CHR(237) + "sticas:"
1324:             .Top = 71
1325:             .Left = 404
1326:             .Width = 78
1327:             .Height = 17
1328:             .FontName = "Tahoma"
1329:             .FontSize = 8
1330:             .ForeColor = RGB(90,90,90)

*-- Linhas 1337 a 1376:
1337:         loc_oOpt = par_oPg.obj_4c_Opt_Caracteris
1338:         WITH loc_oOpt
1339:             .ButtonCount = 2
1340:             .Top = 67
1341:             .Left = 483
1342:             .Width = 97
1343:             .Height = 23
1344:             .BackStyle = 0
1345:             .BorderStyle = 0
1346:             .Value = 1
1347:             .Visible = .T.
1348:         ENDWITH
1349:         loc_oOpt.Buttons(1).Caption = "Sim"
1350:         loc_oOpt.Buttons(1).Left = 5
1351:         loc_oOpt.Buttons(1).Top = 3
1352:         loc_oOpt.Buttons(1).Width = 40
1353:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1354:         loc_oOpt.Buttons(1).FontSize = 8
1355:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1356:         loc_oOpt.Buttons(1).Themes = .F.
1357:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1358:         loc_oOpt.Buttons(2).Left = 48
1359:         loc_oOpt.Buttons(2).Top = 3
1360:         loc_oOpt.Buttons(2).Width = 44
1361:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1362:         loc_oOpt.Buttons(2).FontSize = 8
1363:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1364:         loc_oOpt.Buttons(2).Themes = .F.
1365: 
1366:         *-- Informacoes Cadastrais
1367:         par_oPg.AddObject("lbl_4c_LblInfcads", "Label")
1368:         WITH par_oPg.lbl_4c_LblInfcads
1369:             .Caption = "Informa" + CHR(231) + CHR(245) + "es Cadastrais:"
1370:             .Top = 98
1371:             .Left = 361
1372:             .Width = 121
1373:             .Height = 17
1374:             .FontName = "Tahoma"
1375:             .FontSize = 8
1376:             .ForeColor = RGB(90,90,90)

*-- Linhas 1383 a 1422:
1383:         loc_oOpt = par_oPg.obj_4c_Fwoption1
1384:         WITH loc_oOpt
1385:             .ButtonCount = 2
1386:             .Top = 94
1387:             .Left = 483
1388:             .Width = 97
1389:             .Height = 23
1390:             .BackStyle = 0
1391:             .BorderStyle = 0
1392:             .Value = 1
1393:             .Visible = .T.
1394:         ENDWITH
1395:         loc_oOpt.Buttons(1).Caption = "Sim"
1396:         loc_oOpt.Buttons(1).Left = 5
1397:         loc_oOpt.Buttons(1).Top = 3
1398:         loc_oOpt.Buttons(1).Width = 40
1399:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1400:         loc_oOpt.Buttons(1).FontSize = 8
1401:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1402:         loc_oOpt.Buttons(1).Themes = .F.
1403:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1404:         loc_oOpt.Buttons(2).Left = 48
1405:         loc_oOpt.Buttons(2).Top = 3
1406:         loc_oOpt.Buttons(2).Width = 44
1407:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1408:         loc_oOpt.Buttons(2).FontSize = 8
1409:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1410:         loc_oOpt.Buttons(2).Themes = .F.
1411: 
1412:         *-- Perfil
1413:         par_oPg.AddObject("lbl_4c_LblPerfil", "Label")
1414:         WITH par_oPg.lbl_4c_LblPerfil
1415:             .Caption = "Perfil:"
1416:             .Top = 124
1417:             .Left = 451
1418:             .Width = 31
1419:             .Height = 17
1420:             .FontName = "Tahoma"
1421:             .FontSize = 8
1422:             .ForeColor = RGB(90,90,90)

*-- Linhas 1429 a 1468:
1429:         loc_oOpt = par_oPg.obj_4c_Fwoption2
1430:         WITH loc_oOpt
1431:             .ButtonCount = 2
1432:             .Top = 120
1433:             .Left = 483
1434:             .Width = 97
1435:             .Height = 23
1436:             .BackStyle = 0
1437:             .BorderStyle = 0
1438:             .Value = 1
1439:             .Visible = .T.
1440:         ENDWITH
1441:         loc_oOpt.Buttons(1).Caption = "Sim"
1442:         loc_oOpt.Buttons(1).Left = 5
1443:         loc_oOpt.Buttons(1).Top = 3
1444:         loc_oOpt.Buttons(1).Width = 40
1445:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1446:         loc_oOpt.Buttons(1).FontSize = 8
1447:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1448:         loc_oOpt.Buttons(1).Themes = .F.
1449:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1450:         loc_oOpt.Buttons(2).Left = 48
1451:         loc_oOpt.Buttons(2).Top = 3
1452:         loc_oOpt.Buttons(2).Width = 44
1453:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1454:         loc_oOpt.Buttons(2).FontSize = 8
1455:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1456:         loc_oOpt.Buttons(2).Themes = .F.
1457: 
1458:         *-- Cargos
1459:         par_oPg.AddObject("lbl_4c_LblCargos", "Label")
1460:         WITH par_oPg.lbl_4c_LblCargos
1461:             .Caption = "Cargos:"
1462:             .Top = 149
1463:             .Left = 441
1464:             .Width = 41
1465:             .Height = 17
1466:             .FontName = "Tahoma"
1467:             .FontSize = 8
1468:             .ForeColor = RGB(90,90,90)

*-- Linhas 1475 a 1514:
1475:         loc_oOpt = par_oPg.obj_4c_Opt_Cargo
1476:         WITH loc_oOpt
1477:             .ButtonCount = 2
1478:             .Top = 145
1479:             .Left = 483
1480:             .Width = 97
1481:             .Height = 23
1482:             .BackStyle = 0
1483:             .BorderStyle = 0
1484:             .Value = 1
1485:             .Visible = .T.
1486:         ENDWITH
1487:         loc_oOpt.Buttons(1).Caption = "Sim"
1488:         loc_oOpt.Buttons(1).Left = 5
1489:         loc_oOpt.Buttons(1).Top = 3
1490:         loc_oOpt.Buttons(1).Width = 40
1491:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1492:         loc_oOpt.Buttons(1).FontSize = 8
1493:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1494:         loc_oOpt.Buttons(1).Themes = .F.
1495:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1496:         loc_oOpt.Buttons(2).Left = 48
1497:         loc_oOpt.Buttons(2).Top = 3
1498:         loc_oOpt.Buttons(2).Width = 44
1499:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1500:         loc_oOpt.Buttons(2).FontSize = 8
1501:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1502:         loc_oOpt.Buttons(2).Themes = .F.
1503: 
1504:         *-- Checa Limite de Credito
1505:         par_oPg.AddObject("lbl_4c_LblChkLimCr", "Label")
1506:         WITH par_oPg.lbl_4c_LblChkLimCr
1507:             .Caption = "Checa Limite Cr" + CHR(233) + "dito:"
1508:             .Top = 175
1509:             .Left = 377
1510:             .Width = 105
1511:             .Height = 17
1512:             .FontName = "Tahoma"
1513:             .FontSize = 8
1514:             .ForeColor = RGB(90,90,90)

*-- Linhas 1521 a 1560:
1521:         loc_oOpt = par_oPg.obj_4c_Opt_ChkLimCr
1522:         WITH loc_oOpt
1523:             .ButtonCount = 2
1524:             .Top = 171
1525:             .Left = 483
1526:             .Width = 97
1527:             .Height = 23
1528:             .BackStyle = 0
1529:             .BorderStyle = 0
1530:             .Value = 1
1531:             .Visible = .T.
1532:         ENDWITH
1533:         loc_oOpt.Buttons(1).Caption = "Sim"
1534:         loc_oOpt.Buttons(1).Left = 5
1535:         loc_oOpt.Buttons(1).Top = 3
1536:         loc_oOpt.Buttons(1).Width = 40
1537:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1538:         loc_oOpt.Buttons(1).FontSize = 8
1539:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1540:         loc_oOpt.Buttons(1).Themes = .F.
1541:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1542:         loc_oOpt.Buttons(2).Left = 48
1543:         loc_oOpt.Buttons(2).Top = 3
1544:         loc_oOpt.Buttons(2).Width = 44
1545:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1546:         loc_oOpt.Buttons(2).FontSize = 8
1547:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1548:         loc_oOpt.Buttons(2).Themes = .F.
1549: 
1550:         *-- Lim.Credito Grupo Valor Moeda
1551:         par_oPg.AddObject("lbl_4c_LblLimVrMoe", "Label")
1552:         WITH par_oPg.lbl_4c_LblLimVrMoe
1553:             .Caption = "Lim.Cr" + CHR(233) + "dito Grupo/Vr/Moeda:"
1554:             .Top = 200
1555:             .Left = 339
1556:             .Width = 143
1557:             .Height = 17
1558:             .FontName = "Tahoma"
1559:             .FontSize = 8
1560:             .ForeColor = RGB(90,90,90)

*-- Linhas 1566 a 1575:
1566:         par_oPg.AddObject("txt_4c_Vrlimc", "TextBox")
1567:         WITH par_oPg.txt_4c_Vrlimc
1568:             .Value = 0
1569:             .Top = 196
1570:             .Left = 586
1571:             .Width = 110
1572:             .Height = 23
1573:             .FontName = "Tahoma"
1574:             .FontSize = 8
1575:             .ForeColor = RGB(90,90,90)

*-- Linhas 1582 a 1591:
1582:         par_oPg.AddObject("txt_4c__molimc", "TextBox")
1583:         WITH par_oPg.txt_4c__molimc
1584:             .Value = ""
1585:             .Top = 196
1586:             .Left = 698
1587:             .Width = 32
1588:             .Height = 23
1589:             .MaxLength = 3
1590:             .FontName = "Tahoma"
1591:             .FontSize = 8

*-- Linhas 1597 a 1609:
1597:         ENDWITH
1598: 
1599:         *-- Moeda da Comissao
1600:         par_oPg.AddObject("lbl_4c_LblComMoeda", "Label")
1601:         WITH par_oPg.lbl_4c_LblComMoeda
1602:             .Caption = "Moeda da Comiss" + CHR(227) + "o:"
1603:             .Top = 226
1604:             .Left = 380
1605:             .Width = 103
1606:             .Height = 17
1607:             .FontName = "Tahoma"
1608:             .FontSize = 8
1609:             .ForeColor = RGB(90,90,90)

*-- Linhas 1615 a 1624:
1615:         par_oPg.AddObject("txt_4c__cd_moeda", "TextBox")
1616:         WITH par_oPg.txt_4c__cd_moeda
1617:             .Value = ""
1618:             .Top = 222
1619:             .Left = 486
1620:             .Width = 32
1621:             .Height = 23
1622:             .MaxLength = 3
1623:             .FontName = "Tahoma"
1624:             .FontSize = 8

*-- Linhas 1632 a 1641:
1632:         par_oPg.AddObject("txt_4c__ds_moeda", "TextBox")
1633:         WITH par_oPg.txt_4c__ds_moeda
1634:             .Value = ""
1635:             .Top = 222
1636:             .Left = 520
1637:             .Width = 150
1638:             .Height = 23
1639:             .FontName = "Tahoma"
1640:             .FontSize = 8
1641:             .ForeColor = RGB(90,90,90)

*-- Linhas 1654 a 1666:
1654:         BINDEVENT(par_oPg.txt_4c__molimc,   "KeyPress", THIS, "MoedaLimiteLostFocus")
1655: 
1656:         *-- Grupo Padrao Contabil
1657:         par_oPg.AddObject("lbl_4c_LblGrupolms", "Label")
1658:         WITH par_oPg.lbl_4c_LblGrupolms
1659:             .Caption = "Grupo Padr" + CHR(227) + "o:"
1660:             .Top = 19
1661:             .Left = 678
1662:             .Width = 80
1663:             .Height = 17
1664:             .FontName = "Tahoma"
1665:             .FontSize = 8
1666:             .ForeColor = RGB(90,90,90)

*-- Linhas 1672 a 1681:
1672:         par_oPg.AddObject("txt_4c_Grupo", "TextBox")
1673:         WITH par_oPg.txt_4c_Grupo
1674:             .Value = ""
1675:             .Top = 17
1676:             .Left = 760
1677:             .Width = 120
1678:             .Height = 23
1679:             .MaxLength = 10
1680:             .FontName = "Tahoma"
1681:             .FontSize = 8

*-- Linhas 1690 a 1702:
1690:         BINDEVENT(par_oPg.txt_4c_Grupo, "DblClick", THIS, "GrupoContabDblClick")
1691: 
1692:         *-- Coletor (11 opcoes) - OptionGroup vertical
1693:         par_oPg.AddObject("lbl_4c_LblColetor", "Label")
1694:         WITH par_oPg.lbl_4c_LblColetor
1695:             .Caption = "Coletor:"
1696:             .Top = 8
1697:             .Left = 700
1698:             .Width = 50
1699:             .Height = 17
1700:             .FontName = "Tahoma"
1701:             .FontSize = 8
1702:             .ForeColor = RGB(90,90,90)

*-- Linhas 1709 a 1832:
1709:         loc_oOpt = par_oPg.obj_4c_Opt_Coletor
1710:         WITH loc_oOpt
1711:             .ButtonCount = 11
1712:             .Top = 12
1713:             .Left = 750
1714:             .Width = 141
1715:             .Height = 210
1716:             .BackStyle = 0
1717:             .BorderStyle = 0
1718:             .Value = 1
1719:             .Visible = .T.
1720:         ENDWITH
1721: 
1722:         loc_oOpt.Buttons(1).Caption   = "N" + CHR(227) + "o"
1723:         loc_oOpt.Buttons(1).Left      = 5
1724:         loc_oOpt.Buttons(1).Top       = 5
1725:         loc_oOpt.Buttons(1).Width     = 130
1726:         loc_oOpt.Buttons(1).AutoSize  = .F.
1727:         loc_oOpt.Buttons(1).FontName  = "Tahoma"
1728:         loc_oOpt.Buttons(1).FontSize  = 8
1729:         loc_oOpt.Buttons(1).ForeColor = RGB(90, 90, 90)
1730:         loc_oOpt.Buttons(1).Themes    = .F.
1731:         loc_oOpt.Buttons(2).Caption   = "Coletor 1"
1732:         loc_oOpt.Buttons(2).Left      = 5
1733:         loc_oOpt.Buttons(2).Top       = 23
1734:         loc_oOpt.Buttons(2).Width     = 130
1735:         loc_oOpt.Buttons(2).AutoSize  = .F.
1736:         loc_oOpt.Buttons(2).FontName  = "Tahoma"
1737:         loc_oOpt.Buttons(2).FontSize  = 8
1738:         loc_oOpt.Buttons(2).ForeColor = RGB(90, 90, 90)
1739:         loc_oOpt.Buttons(2).Themes    = .F.
1740:         loc_oOpt.Buttons(3).Caption   = "Coletor 2"
1741:         loc_oOpt.Buttons(3).Left      = 5
1742:         loc_oOpt.Buttons(3).Top       = 41
1743:         loc_oOpt.Buttons(3).Width     = 130
1744:         loc_oOpt.Buttons(3).AutoSize  = .F.
1745:         loc_oOpt.Buttons(3).FontName  = "Tahoma"
1746:         loc_oOpt.Buttons(3).FontSize  = 8
1747:         loc_oOpt.Buttons(3).ForeColor = RGB(90, 90, 90)
1748:         loc_oOpt.Buttons(3).Themes    = .F.
1749:         loc_oOpt.Buttons(4).Caption   = "Coletor 3"
1750:         loc_oOpt.Buttons(4).Left      = 5
1751:         loc_oOpt.Buttons(4).Top       = 59
1752:         loc_oOpt.Buttons(4).Width     = 130
1753:         loc_oOpt.Buttons(4).AutoSize  = .F.
1754:         loc_oOpt.Buttons(4).FontName  = "Tahoma"
1755:         loc_oOpt.Buttons(4).FontSize  = 8
1756:         loc_oOpt.Buttons(4).ForeColor = RGB(90, 90, 90)
1757:         loc_oOpt.Buttons(4).Themes    = .F.
1758:         loc_oOpt.Buttons(5).Caption   = "Coletor 4"
1759:         loc_oOpt.Buttons(5).Left      = 5
1760:         loc_oOpt.Buttons(5).Top       = 77
1761:         loc_oOpt.Buttons(5).Width     = 130
1762:         loc_oOpt.Buttons(5).AutoSize  = .F.
1763:         loc_oOpt.Buttons(5).FontName  = "Tahoma"
1764:         loc_oOpt.Buttons(5).FontSize  = 8
1765:         loc_oOpt.Buttons(5).ForeColor = RGB(90, 90, 90)
1766:         loc_oOpt.Buttons(5).Themes    = .F.
1767:         loc_oOpt.Buttons(6).Caption   = "Coletor 5"
1768:         loc_oOpt.Buttons(6).Left      = 5
1769:         loc_oOpt.Buttons(6).Top       = 95
1770:         loc_oOpt.Buttons(6).Width     = 130
1771:         loc_oOpt.Buttons(6).AutoSize  = .F.
1772:         loc_oOpt.Buttons(6).FontName  = "Tahoma"
1773:         loc_oOpt.Buttons(6).FontSize  = 8
1774:         loc_oOpt.Buttons(6).ForeColor = RGB(90, 90, 90)
1775:         loc_oOpt.Buttons(6).Themes    = .F.
1776:         loc_oOpt.Buttons(7).Caption   = "Coletor 6"
1777:         loc_oOpt.Buttons(7).Left      = 5
1778:         loc_oOpt.Buttons(7).Top       = 113
1779:         loc_oOpt.Buttons(7).Width     = 130
1780:         loc_oOpt.Buttons(7).AutoSize  = .F.
1781:         loc_oOpt.Buttons(7).FontName  = "Tahoma"
1782:         loc_oOpt.Buttons(7).FontSize  = 8
1783:         loc_oOpt.Buttons(7).ForeColor = RGB(90, 90, 90)
1784:         loc_oOpt.Buttons(7).Themes    = .F.
1785:         loc_oOpt.Buttons(8).Caption   = "Coletor 7"
1786:         loc_oOpt.Buttons(8).Left      = 5
1787:         loc_oOpt.Buttons(8).Top       = 131
1788:         loc_oOpt.Buttons(8).Width     = 130
1789:         loc_oOpt.Buttons(8).AutoSize  = .F.
1790:         loc_oOpt.Buttons(8).FontName  = "Tahoma"
1791:         loc_oOpt.Buttons(8).FontSize  = 8
1792:         loc_oOpt.Buttons(8).ForeColor = RGB(90, 90, 90)
1793:         loc_oOpt.Buttons(8).Themes    = .F.
1794:         loc_oOpt.Buttons(9).Caption   = "Coletor 8"
1795:         loc_oOpt.Buttons(9).Left      = 5
1796:         loc_oOpt.Buttons(9).Top       = 149
1797:         loc_oOpt.Buttons(9).Width     = 130
1798:         loc_oOpt.Buttons(9).AutoSize  = .F.
1799:         loc_oOpt.Buttons(9).FontName  = "Tahoma"
1800:         loc_oOpt.Buttons(9).FontSize  = 8
1801:         loc_oOpt.Buttons(9).ForeColor = RGB(90, 90, 90)
1802:         loc_oOpt.Buttons(9).Themes    = .F.
1803:         loc_oOpt.Buttons(10).Caption   = "Coletor 9"
1804:         loc_oOpt.Buttons(10).Left      = 5
1805:         loc_oOpt.Buttons(10).Top       = 167
1806:         loc_oOpt.Buttons(10).Width     = 130
1807:         loc_oOpt.Buttons(10).AutoSize  = .F.
1808:         loc_oOpt.Buttons(10).FontName  = "Tahoma"
1809:         loc_oOpt.Buttons(10).FontSize  = 8
1810:         loc_oOpt.Buttons(10).ForeColor = RGB(90, 90, 90)
1811:         loc_oOpt.Buttons(10).Themes    = .F.
1812:         loc_oOpt.Buttons(11).Caption   = "Coletor 10"
1813:         loc_oOpt.Buttons(11).Left      = 5
1814:         loc_oOpt.Buttons(11).Top       = 185
1815:         loc_oOpt.Buttons(11).Width     = 130
1816:         loc_oOpt.Buttons(11).AutoSize  = .F.
1817:         loc_oOpt.Buttons(11).FontName  = "Tahoma"
1818:         loc_oOpt.Buttons(11).FontSize  = 8
1819:         loc_oOpt.Buttons(11).ForeColor = RGB(90, 90, 90)
1820:         loc_oOpt.Buttons(11).Themes    = .F.
1821: 
1822:         *-- LEAD / Pre-Cadastro
1823:         par_oPg.AddObject("lbl_4c_LblPreCad", "Label")
1824:         WITH par_oPg.lbl_4c_LblPreCad
1825:             .Caption = "LEAD:"
1826:             .Top = 221
1827:             .Left = 719
1828:             .Width = 30
1829:             .Height = 17
1830:             .FontName = "Tahoma"
1831:             .FontSize = 8
1832:             .ForeColor = RGB(90,90,90)

*-- Linhas 1839 a 1903:
1839:         loc_oOpt = par_oPg.obj_4c_OptPreCad
1840:         WITH loc_oOpt
1841:             .ButtonCount = 2
1842:             .Top = 217
1843:             .Left = 751
1844:             .Width = 97
1845:             .Height = 23
1846:             .BackStyle = 0
1847:             .BorderStyle = 0
1848:             .Value = 1
1849:             .Visible = .T.
1850:         ENDWITH
1851:         loc_oOpt.Buttons(1).Caption = "Sim"
1852:         loc_oOpt.Buttons(1).Left = 5
1853:         loc_oOpt.Buttons(1).Top = 3
1854:         loc_oOpt.Buttons(1).Width = 40
1855:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1856:         loc_oOpt.Buttons(1).FontSize = 8
1857:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1858:         loc_oOpt.Buttons(1).Themes = .F.
1859:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
1860:         loc_oOpt.Buttons(2).Left = 48
1861:         loc_oOpt.Buttons(2).Top = 3
1862:         loc_oOpt.Buttons(2).Width = 44
1863:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1864:         loc_oOpt.Buttons(2).FontSize = 8
1865:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1866:         loc_oOpt.Buttons(2).Themes = .F.
1867: 
1868:         *-- Linha separadora
1869:         par_oPg.AddObject("lin_4c_Line1", "Line")
1870:         WITH par_oPg.lin_4c_Line1
1871:             .Top = 253
1872:             .Left = 17
1873:             .Width = 959
1874:             .Height = 1
1875:             .BorderColor = RGB(150,150,150)
1876:             .Visible = .T.
1877:         ENDWITH
1878: 
1879:         *-- Rodape do Relatorio
1880:         par_oPg.AddObject("lbl_4c_LblRodrel", "Label")
1881:         WITH par_oPg.lbl_4c_LblRodrel
1882:             .Caption = "Rodap" + CHR(233) + " do Relat" + CHR(243) + "rio:"
1883:             .Top = 260
1884:             .Left = 103
1885:             .Width = 120
1886:             .Height = 17
1887:             .FontName = "Tahoma"
1888:             .FontSize = 8
1889:             .ForeColor = RGB(90,90,90)
1890:             .BackStyle = 0
1891:             .Visible = .T.
1892:         ENDWITH
1893: 
1894:         par_oPg.AddObject("obj_4c_GetRodRelCC", "EditBox")
1895:         WITH par_oPg.obj_4c_GetRodRelCC
1896:             .Value = ""
1897:             .Top = 277
1898:             .Left = 103
1899:             .Width = 788
1900:             .Height = 117
1901:             .FontName = "Tahoma"
1902:             .FontSize = 8
1903:             .ForeColor = RGB(90,90,90)

*-- Linhas 1918 a 1959:
1918:         *-- Linhas separadoras
1919:         par_oPg.AddObject("lin_4c_Cad1", "Line")
1920:         WITH par_oPg.lin_4c_Cad1
1921:             .Top = 341
1922:             .Left = 17
1923:             .Width = 959
1924:             .Height = 1
1925:             .BorderColor = RGB(150,150,150)
1926:             .Visible = .T.
1927:         ENDWITH
1928: 
1929:         par_oPg.AddObject("lin_4c_Cad2", "Line")
1930:         WITH par_oPg.lin_4c_Cad2
1931:             .Top = 29
1932:             .Left = 344
1933:             .Width = 1
1934:             .Height = 312
1935:             .BorderColor = RGB(150,150,150)
1936:             .Visible = .T.
1937:         ENDWITH
1938: 
1939:         par_oPg.AddObject("lin_4c_Cad3", "Line")
1940:         WITH par_oPg.lin_4c_Cad3
1941:             .Top = 29
1942:             .Left = 583
1943:             .Width = 1
1944:             .Height = 312
1945:             .BorderColor = RGB(150,150,150)
1946:             .Visible = .T.
1947:         ENDWITH
1948: 
1949:         *-- Col 1: CPF/CNPJ Obrigatorio (3 btn)
1950:         par_oPg.AddObject("lbl_4c_LblCpfObrig", "Label")
1951:         WITH par_oPg.lbl_4c_LblCpfObrig
1952:             .Caption = "CPF/CNPJ Obrig.:"
1953:             .Top = 34
1954:             .Left = 17
1955:             .Width = 141
1956:             .Height = 17
1957:             .FontName = "Tahoma"
1958:             .FontSize = 8
1959:             .ForeColor = RGB(90,90,90)

*-- Linhas 1966 a 2013:
1966:         loc_oOpt = par_oPg.Opt_CPFObrig
1967:         WITH loc_oOpt
1968:             .ButtonCount = 3
1969:             .Top = 34
1970:             .Left = 160
1971:             .Width = 201
1972:             .Height = 23
1973:             .BackStyle = 0
1974:             .BorderStyle = 0
1975:             .Value = 1
1976:             .Visible = .T.
1977:         ENDWITH
1978:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
1979:         loc_oOpt.Buttons(1).Left = 5
1980:         loc_oOpt.Buttons(1).Top = 3
1981:         loc_oOpt.Buttons(1).Width = 44
1982:         loc_oOpt.Buttons(1).FontName = "Tahoma"
1983:         loc_oOpt.Buttons(1).FontSize = 8
1984:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
1985:         loc_oOpt.Buttons(1).Themes = .F.
1986:         loc_oOpt.Buttons(2).Caption = "Opcional"
1987:         loc_oOpt.Buttons(2).Left = 55
1988:         loc_oOpt.Buttons(2).Top = 3
1989:         loc_oOpt.Buttons(2).Width = 65
1990:         loc_oOpt.Buttons(2).FontName = "Tahoma"
1991:         loc_oOpt.Buttons(2).FontSize = 8
1992:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
1993:         loc_oOpt.Buttons(2).Themes = .F.
1994:         loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
1995:         loc_oOpt.Buttons(3).Left = 125
1996:         loc_oOpt.Buttons(3).Top = 3
1997:         loc_oOpt.Buttons(3).Width = 70
1998:         loc_oOpt.Buttons(3).FontName = "Tahoma"
1999:         loc_oOpt.Buttons(3).FontSize = 8
2000:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2001:         loc_oOpt.Buttons(3).Themes = .F.
2002: 
2003:         *-- Calc Imediato
2004:         par_oPg.AddObject("lbl_4c_LblCalcImeds", "Label")
2005:         WITH par_oPg.lbl_4c_LblCalcImeds
2006:             .Caption = "Calc. Imediato:"
2007:             .Top = 54
2008:             .Left = 17
2009:             .Width = 141
2010:             .Height = 17
2011:             .FontName = "Tahoma"
2012:             .FontSize = 8
2013:             .ForeColor = RGB(90,90,90)

*-- Linhas 2020 a 2059:
2020:         loc_oOpt = par_oPg.fwoption2
2021:         WITH loc_oOpt
2022:             .ButtonCount = 2
2023:             .Top = 54
2024:             .Left = 160
2025:             .Width = 115
2026:             .Height = 23
2027:             .BackStyle = 0
2028:             .BorderStyle = 0
2029:             .Value = 1
2030:             .Visible = .T.
2031:         ENDWITH
2032:         loc_oOpt.Buttons(1).Caption = "Sim"
2033:         loc_oOpt.Buttons(1).Left = 5
2034:         loc_oOpt.Buttons(1).Top = 3
2035:         loc_oOpt.Buttons(1).Width = 40
2036:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2037:         loc_oOpt.Buttons(1).FontSize = 8
2038:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2039:         loc_oOpt.Buttons(1).Themes = .F.
2040:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2041:         loc_oOpt.Buttons(2).Left = 48
2042:         loc_oOpt.Buttons(2).Top = 3
2043:         loc_oOpt.Buttons(2).Width = 44
2044:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2045:         loc_oOpt.Buttons(2).FontSize = 8
2046:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2047:         loc_oOpt.Buttons(2).Themes = .F.
2048: 
2049:         *-- Calcimeds (optCalcIMeds)
2050:         par_oPg.AddObject("lbl_4c_LblCalcIMed2", "Label")
2051:         WITH par_oPg.lbl_4c_LblCalcIMed2
2052:             .Caption = "Calc.Imeds2:"
2053:             .Top = 73
2054:             .Left = 17
2055:             .Width = 141
2056:             .Height = 17
2057:             .FontName = "Tahoma"
2058:             .FontSize = 8
2059:             .ForeColor = RGB(90,90,90)

*-- Linhas 2066 a 2105:
2066:         loc_oOpt = par_oPg.optCalcIMeds
2067:         WITH loc_oOpt
2068:             .ButtonCount = 2
2069:             .Top = 73
2070:             .Left = 160
2071:             .Width = 97
2072:             .Height = 25
2073:             .BackStyle = 0
2074:             .BorderStyle = 0
2075:             .Value = 1
2076:             .Visible = .T.
2077:         ENDWITH
2078:         loc_oOpt.Buttons(1).Caption = "Sim"
2079:         loc_oOpt.Buttons(1).Left = 5
2080:         loc_oOpt.Buttons(1).Top = 3
2081:         loc_oOpt.Buttons(1).Width = 40
2082:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2083:         loc_oOpt.Buttons(1).FontSize = 8
2084:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2085:         loc_oOpt.Buttons(1).Themes = .F.
2086:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2087:         loc_oOpt.Buttons(2).Left = 48
2088:         loc_oOpt.Buttons(2).Top = 3
2089:         loc_oOpt.Buttons(2).Width = 44
2090:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2091:         loc_oOpt.Buttons(2).FontSize = 8
2092:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2093:         loc_oOpt.Buttons(2).Themes = .F.
2094: 
2095:         *-- ObrMails
2096:         par_oPg.AddObject("lbl_4c_LblObrMails", "Label")
2097:         WITH par_oPg.lbl_4c_LblObrMails
2098:             .Caption = "E-mail Obrig.:"
2099:             .Top = 96
2100:             .Left = 17
2101:             .Width = 141
2102:             .Height = 17
2103:             .FontName = "Tahoma"
2104:             .FontSize = 8
2105:             .ForeColor = RGB(90,90,90)

*-- Linhas 2112 a 2151:
2112:         loc_oOpt = par_oPg.getObrMails
2113:         WITH loc_oOpt
2114:             .ButtonCount = 2
2115:             .Top = 96
2116:             .Left = 160
2117:             .Width = 97
2118:             .Height = 25
2119:             .BackStyle = 0
2120:             .BorderStyle = 0
2121:             .Value = 1
2122:             .Visible = .T.
2123:         ENDWITH
2124:         loc_oOpt.Buttons(1).Caption = "Sim"
2125:         loc_oOpt.Buttons(1).Left = 5
2126:         loc_oOpt.Buttons(1).Top = 3
2127:         loc_oOpt.Buttons(1).Width = 40
2128:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2129:         loc_oOpt.Buttons(1).FontSize = 8
2130:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2131:         loc_oOpt.Buttons(1).Themes = .F.
2132:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2133:         loc_oOpt.Buttons(2).Left = 48
2134:         loc_oOpt.Buttons(2).Top = 3
2135:         loc_oOpt.Buttons(2).Width = 44
2136:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2137:         loc_oOpt.Buttons(2).FontSize = 8
2138:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2139:         loc_oOpt.Buttons(2).Themes = .F.
2140: 
2141:         *-- ObrNome
2142:         par_oPg.AddObject("lbl_4c_LblObrNome", "Label")
2143:         WITH par_oPg.lbl_4c_LblObrNome
2144:             .Caption = "Nome Obrig.:"
2145:             .Top = 117
2146:             .Left = 17
2147:             .Width = 141
2148:             .Height = 17
2149:             .FontName = "Tahoma"
2150:             .FontSize = 8
2151:             .ForeColor = RGB(90,90,90)

*-- Linhas 2158 a 2197:
2158:         loc_oOpt = par_oPg.getObrNome
2159:         WITH loc_oOpt
2160:             .ButtonCount = 2
2161:             .Top = 117
2162:             .Left = 160
2163:             .Width = 97
2164:             .Height = 25
2165:             .BackStyle = 0
2166:             .BorderStyle = 0
2167:             .Value = 1
2168:             .Visible = .T.
2169:         ENDWITH
2170:         loc_oOpt.Buttons(1).Caption = "Sim"
2171:         loc_oOpt.Buttons(1).Left = 5
2172:         loc_oOpt.Buttons(1).Top = 3
2173:         loc_oOpt.Buttons(1).Width = 40
2174:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2175:         loc_oOpt.Buttons(1).FontSize = 8
2176:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2177:         loc_oOpt.Buttons(1).Themes = .F.
2178:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2179:         loc_oOpt.Buttons(2).Left = 48
2180:         loc_oOpt.Buttons(2).Top = 3
2181:         loc_oOpt.Buttons(2).Width = 44
2182:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2183:         loc_oOpt.Buttons(2).FontSize = 8
2184:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2185:         loc_oOpt.Buttons(2).Themes = .F.
2186: 
2187:         *-- RazSoc Obrig (Fwoption15)
2188:         par_oPg.AddObject("lbl_4c_LblRazSocObr", "Label")
2189:         WITH par_oPg.lbl_4c_LblRazSocObr
2190:             .Caption = "Raz" + CHR(227) + "o Social Obrig.:"
2191:             .Top = 136
2192:             .Left = 17
2193:             .Width = 141
2194:             .Height = 17
2195:             .FontName = "Tahoma"
2196:             .FontSize = 8
2197:             .ForeColor = RGB(90,90,90)

*-- Linhas 2204 a 2243:
2204:         loc_oOpt = par_oPg.Fwoption15
2205:         WITH loc_oOpt
2206:             .ButtonCount = 2
2207:             .Top = 136
2208:             .Left = 160
2209:             .Width = 97
2210:             .Height = 25
2211:             .BackStyle = 0
2212:             .BorderStyle = 0
2213:             .Value = 1
2214:             .Visible = .T.
2215:         ENDWITH
2216:         loc_oOpt.Buttons(1).Caption = "Sim"
2217:         loc_oOpt.Buttons(1).Left = 5
2218:         loc_oOpt.Buttons(1).Top = 3
2219:         loc_oOpt.Buttons(1).Width = 40
2220:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2221:         loc_oOpt.Buttons(1).FontSize = 8
2222:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2223:         loc_oOpt.Buttons(1).Themes = .F.
2224:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2225:         loc_oOpt.Buttons(2).Left = 48
2226:         loc_oOpt.Buttons(2).Top = 3
2227:         loc_oOpt.Buttons(2).Width = 44
2228:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2229:         loc_oOpt.Buttons(2).FontSize = 8
2230:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2231:         loc_oOpt.Buttons(2).Themes = .F.
2232: 
2233:         *-- ObrSit
2234:         par_oPg.AddObject("lbl_4c_LblObrSit", "Label")
2235:         WITH par_oPg.lbl_4c_LblObrSit
2236:             .Caption = "Situa" + CHR(231) + CHR(227) + "o Obrig.:"
2237:             .Top = 157
2238:             .Left = 17
2239:             .Width = 141
2240:             .Height = 17
2241:             .FontName = "Tahoma"
2242:             .FontSize = 8
2243:             .ForeColor = RGB(90,90,90)

*-- Linhas 2250 a 2289:
2250:         loc_oOpt = par_oPg.getObrSit
2251:         WITH loc_oOpt
2252:             .ButtonCount = 2
2253:             .Top = 157
2254:             .Left = 160
2255:             .Width = 97
2256:             .Height = 25
2257:             .BackStyle = 0
2258:             .BorderStyle = 0
2259:             .Value = 1
2260:             .Visible = .T.
2261:         ENDWITH
2262:         loc_oOpt.Buttons(1).Caption = "Sim"
2263:         loc_oOpt.Buttons(1).Left = 5
2264:         loc_oOpt.Buttons(1).Top = 3
2265:         loc_oOpt.Buttons(1).Width = 40
2266:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2267:         loc_oOpt.Buttons(1).FontSize = 8
2268:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2269:         loc_oOpt.Buttons(1).Themes = .F.
2270:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2271:         loc_oOpt.Buttons(2).Left = 48
2272:         loc_oOpt.Buttons(2).Top = 3
2273:         loc_oOpt.Buttons(2).Width = 44
2274:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2275:         loc_oOpt.Buttons(2).FontSize = 8
2276:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2277:         loc_oOpt.Buttons(2).Themes = .F.
2278: 
2279:         *-- ObrTlm (Telemarketing)
2280:         par_oPg.AddObject("lbl_4c_LblObrTlm", "Label")
2281:         WITH par_oPg.lbl_4c_LblObrTlm
2282:             .Caption = "Telemarketing Obrig.:"
2283:             .Top = 179
2284:             .Left = 17
2285:             .Width = 141
2286:             .Height = 17
2287:             .FontName = "Tahoma"
2288:             .FontSize = 8
2289:             .ForeColor = RGB(90,90,90)

*-- Linhas 2296 a 2335:
2296:         loc_oOpt = par_oPg.getObrTlm
2297:         WITH loc_oOpt
2298:             .ButtonCount = 2
2299:             .Top = 179
2300:             .Left = 160
2301:             .Width = 97
2302:             .Height = 25
2303:             .BackStyle = 0
2304:             .BorderStyle = 0
2305:             .Value = 1
2306:             .Visible = .T.
2307:         ENDWITH
2308:         loc_oOpt.Buttons(1).Caption = "Sim"
2309:         loc_oOpt.Buttons(1).Left = 5
2310:         loc_oOpt.Buttons(1).Top = 3
2311:         loc_oOpt.Buttons(1).Width = 40
2312:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2313:         loc_oOpt.Buttons(1).FontSize = 8
2314:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2315:         loc_oOpt.Buttons(1).Themes = .F.
2316:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2317:         loc_oOpt.Buttons(2).Left = 48
2318:         loc_oOpt.Buttons(2).Top = 3
2319:         loc_oOpt.Buttons(2).Width = 44
2320:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2321:         loc_oOpt.Buttons(2).FontSize = 8
2322:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2323:         loc_oOpt.Buttons(2).Themes = .F.
2324: 
2325:         *-- ObrCla (Classificacao)
2326:         par_oPg.AddObject("lbl_4c_LblObrCla", "Label")
2327:         WITH par_oPg.lbl_4c_LblObrCla
2328:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o Obrig.:"
2329:             .Top = 201
2330:             .Left = 17
2331:             .Width = 141
2332:             .Height = 17
2333:             .FontName = "Tahoma"
2334:             .FontSize = 8
2335:             .ForeColor = RGB(90,90,90)

*-- Linhas 2342 a 2381:
2342:         loc_oOpt = par_oPg.getObrCla
2343:         WITH loc_oOpt
2344:             .ButtonCount = 2
2345:             .Top = 201
2346:             .Left = 160
2347:             .Width = 97
2348:             .Height = 25
2349:             .BackStyle = 0
2350:             .BorderStyle = 0
2351:             .Value = 1
2352:             .Visible = .T.
2353:         ENDWITH
2354:         loc_oOpt.Buttons(1).Caption = "Sim"
2355:         loc_oOpt.Buttons(1).Left = 5
2356:         loc_oOpt.Buttons(1).Top = 3
2357:         loc_oOpt.Buttons(1).Width = 40
2358:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2359:         loc_oOpt.Buttons(1).FontSize = 8
2360:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2361:         loc_oOpt.Buttons(1).Themes = .F.
2362:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2363:         loc_oOpt.Buttons(2).Left = 48
2364:         loc_oOpt.Buttons(2).Top = 3
2365:         loc_oOpt.Buttons(2).Width = 44
2366:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2367:         loc_oOpt.Buttons(2).FontSize = 8
2368:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2369:         loc_oOpt.Buttons(2).Themes = .F.
2370: 
2371:         *-- ObrSeg (Segmento)
2372:         par_oPg.AddObject("lbl_4c_LblObrSeg", "Label")
2373:         WITH par_oPg.lbl_4c_LblObrSeg
2374:             .Caption = "Segmento Obrig.:"
2375:             .Top = 222
2376:             .Left = 17
2377:             .Width = 141
2378:             .Height = 17
2379:             .FontName = "Tahoma"
2380:             .FontSize = 8
2381:             .ForeColor = RGB(90,90,90)

*-- Linhas 2388 a 2427:
2388:         loc_oOpt = par_oPg.getObrSeg
2389:         WITH loc_oOpt
2390:             .ButtonCount = 2
2391:             .Top = 222
2392:             .Left = 160
2393:             .Width = 97
2394:             .Height = 25
2395:             .BackStyle = 0
2396:             .BorderStyle = 0
2397:             .Value = 1
2398:             .Visible = .T.
2399:         ENDWITH
2400:         loc_oOpt.Buttons(1).Caption = "Sim"
2401:         loc_oOpt.Buttons(1).Left = 5
2402:         loc_oOpt.Buttons(1).Top = 3
2403:         loc_oOpt.Buttons(1).Width = 40
2404:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2405:         loc_oOpt.Buttons(1).FontSize = 8
2406:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2407:         loc_oOpt.Buttons(1).Themes = .F.
2408:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2409:         loc_oOpt.Buttons(2).Left = 48
2410:         loc_oOpt.Buttons(2).Top = 3
2411:         loc_oOpt.Buttons(2).Width = 44
2412:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2413:         loc_oOpt.Buttons(2).FontSize = 8
2414:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2415:         loc_oOpt.Buttons(2).Themes = .F.
2416: 
2417:         *-- Nascimento Obrig (Fwoption6)
2418:         par_oPg.AddObject("lbl_4c_LblNascObr", "Label")
2419:         WITH par_oPg.lbl_4c_LblNascObr
2420:             .Caption = "Nascimento Obrig.:"
2421:             .Top = 241
2422:             .Left = 17
2423:             .Width = 141
2424:             .Height = 17
2425:             .FontName = "Tahoma"
2426:             .FontSize = 8
2427:             .ForeColor = RGB(90,90,90)

*-- Linhas 2434 a 2473:
2434:         loc_oOpt = par_oPg.Fwoption6
2435:         WITH loc_oOpt
2436:             .ButtonCount = 2
2437:             .Top = 241
2438:             .Left = 160
2439:             .Width = 97
2440:             .Height = 25
2441:             .BackStyle = 0
2442:             .BorderStyle = 0
2443:             .Value = 1
2444:             .Visible = .T.
2445:         ENDWITH
2446:         loc_oOpt.Buttons(1).Caption = "Sim"
2447:         loc_oOpt.Buttons(1).Left = 5
2448:         loc_oOpt.Buttons(1).Top = 3
2449:         loc_oOpt.Buttons(1).Width = 40
2450:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2451:         loc_oOpt.Buttons(1).FontSize = 8
2452:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2453:         loc_oOpt.Buttons(1).Themes = .F.
2454:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2455:         loc_oOpt.Buttons(2).Left = 48
2456:         loc_oOpt.Buttons(2).Top = 3
2457:         loc_oOpt.Buttons(2).Width = 44
2458:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2459:         loc_oOpt.Buttons(2).FontSize = 8
2460:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2461:         loc_oOpt.Buttons(2).Themes = .F.
2462: 
2463:         *-- Sexo Obrig (Fwoption7)
2464:         par_oPg.AddObject("lbl_4c_LblSexoObr", "Label")
2465:         WITH par_oPg.lbl_4c_LblSexoObr
2466:             .Caption = "Sexo Obrig.:"
2467:             .Top = 262
2468:             .Left = 17
2469:             .Width = 141
2470:             .Height = 17
2471:             .FontName = "Tahoma"
2472:             .FontSize = 8
2473:             .ForeColor = RGB(90,90,90)

*-- Linhas 2480 a 2519:
2480:         loc_oOpt = par_oPg.Fwoption7
2481:         WITH loc_oOpt
2482:             .ButtonCount = 2
2483:             .Top = 262
2484:             .Left = 160
2485:             .Width = 97
2486:             .Height = 25
2487:             .BackStyle = 0
2488:             .BorderStyle = 0
2489:             .Value = 1
2490:             .Visible = .T.
2491:         ENDWITH
2492:         loc_oOpt.Buttons(1).Caption = "Sim"
2493:         loc_oOpt.Buttons(1).Left = 5
2494:         loc_oOpt.Buttons(1).Top = 3
2495:         loc_oOpt.Buttons(1).Width = 40
2496:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2497:         loc_oOpt.Buttons(1).FontSize = 8
2498:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2499:         loc_oOpt.Buttons(1).Themes = .F.
2500:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2501:         loc_oOpt.Buttons(2).Left = 48
2502:         loc_oOpt.Buttons(2).Top = 3
2503:         loc_oOpt.Buttons(2).Width = 44
2504:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2505:         loc_oOpt.Buttons(2).FontSize = 8
2506:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2507:         loc_oOpt.Buttons(2).Themes = .F.
2508: 
2509:         *-- Telefone 1 Obrig (Fwoption12)
2510:         par_oPg.AddObject("lbl_4c_LblTel1Obr", "Label")
2511:         WITH par_oPg.lbl_4c_LblTel1Obr
2512:             .Caption = "Telefone 1 Obrig.:"
2513:             .Top = 283
2514:             .Left = 17
2515:             .Width = 141
2516:             .Height = 17
2517:             .FontName = "Tahoma"
2518:             .FontSize = 8
2519:             .ForeColor = RGB(90,90,90)

*-- Linhas 2526 a 2565:
2526:         loc_oOpt = par_oPg.Fwoption12
2527:         WITH loc_oOpt
2528:             .ButtonCount = 2
2529:             .Top = 283
2530:             .Left = 160
2531:             .Width = 97
2532:             .Height = 25
2533:             .BackStyle = 0
2534:             .BorderStyle = 0
2535:             .Value = 1
2536:             .Visible = .T.
2537:         ENDWITH
2538:         loc_oOpt.Buttons(1).Caption = "Sim"
2539:         loc_oOpt.Buttons(1).Left = 5
2540:         loc_oOpt.Buttons(1).Top = 3
2541:         loc_oOpt.Buttons(1).Width = 40
2542:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2543:         loc_oOpt.Buttons(1).FontSize = 8
2544:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2545:         loc_oOpt.Buttons(1).Themes = .F.
2546:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2547:         loc_oOpt.Buttons(2).Left = 48
2548:         loc_oOpt.Buttons(2).Top = 3
2549:         loc_oOpt.Buttons(2).Width = 44
2550:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2551:         loc_oOpt.Buttons(2).FontSize = 8
2552:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2553:         loc_oOpt.Buttons(2).Themes = .F.
2554: 
2555:         *-- Telefone 2 Obrig (Fwoption13)
2556:         par_oPg.AddObject("lbl_4c_LblTel2Obr", "Label")
2557:         WITH par_oPg.lbl_4c_LblTel2Obr
2558:             .Caption = "Telefone 2 Obrig.:"
2559:             .Top = 302
2560:             .Left = 17
2561:             .Width = 141
2562:             .Height = 17
2563:             .FontName = "Tahoma"
2564:             .FontSize = 8
2565:             .ForeColor = RGB(90,90,90)

*-- Linhas 2572 a 2612:
2572:         loc_oOpt = par_oPg.Fwoption13
2573:         WITH loc_oOpt
2574:             .ButtonCount = 2
2575:             .Top = 302
2576:             .Left = 160
2577:             .Width = 97
2578:             .Height = 25
2579:             .BackStyle = 0
2580:             .BorderStyle = 0
2581:             .Value = 1
2582:             .Visible = .T.
2583:         ENDWITH
2584:         loc_oOpt.Buttons(1).Caption = "Sim"
2585:         loc_oOpt.Buttons(1).Left = 5
2586:         loc_oOpt.Buttons(1).Top = 3
2587:         loc_oOpt.Buttons(1).Width = 40
2588:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2589:         loc_oOpt.Buttons(1).FontSize = 8
2590:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2591:         loc_oOpt.Buttons(1).Themes = .F.
2592:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2593:         loc_oOpt.Buttons(2).Left = 48
2594:         loc_oOpt.Buttons(2).Top = 3
2595:         loc_oOpt.Buttons(2).Width = 44
2596:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2597:         loc_oOpt.Buttons(2).FontSize = 8
2598:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2599:         loc_oOpt.Buttons(2).Themes = .F.
2600: 
2601:         *-- Col 2: Endereco obrigatorio (Left 464)
2602:         *-- Endereco Obrig (Fwoption14)
2603:         par_oPg.AddObject("lbl_4c_LblEndObr", "Label")
2604:         WITH par_oPg.lbl_4c_LblEndObr
2605:             .Caption = "Endere" + CHR(231) + "o Obrig.:"
2606:             .Top = 33
2607:             .Left = 360
2608:             .Width = 103
2609:             .Height = 17
2610:             .FontName = "Tahoma"
2611:             .FontSize = 8
2612:             .ForeColor = RGB(90,90,90)

*-- Linhas 2619 a 2658:
2619:         loc_oOpt = par_oPg.Fwoption14
2620:         WITH loc_oOpt
2621:             .ButtonCount = 2
2622:             .Top = 33
2623:             .Left = 464
2624:             .Width = 97
2625:             .Height = 25
2626:             .BackStyle = 0
2627:             .BorderStyle = 0
2628:             .Value = 1
2629:             .Visible = .T.
2630:         ENDWITH
2631:         loc_oOpt.Buttons(1).Caption = "Sim"
2632:         loc_oOpt.Buttons(1).Left = 5
2633:         loc_oOpt.Buttons(1).Top = 3
2634:         loc_oOpt.Buttons(1).Width = 40
2635:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2636:         loc_oOpt.Buttons(1).FontSize = 8
2637:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2638:         loc_oOpt.Buttons(1).Themes = .F.
2639:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2640:         loc_oOpt.Buttons(2).Left = 48
2641:         loc_oOpt.Buttons(2).Top = 3
2642:         loc_oOpt.Buttons(2).Width = 44
2643:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2644:         loc_oOpt.Buttons(2).FontSize = 8
2645:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2646:         loc_oOpt.Buttons(2).Themes = .F.
2647: 
2648:         *-- Numero Obrig (Fwoption8)
2649:         par_oPg.AddObject("lbl_4c_LblNumObr", "Label")
2650:         WITH par_oPg.lbl_4c_LblNumObr
2651:             .Caption = "N" + CHR(250) + "mero Obrig.:"
2652:             .Top = 52
2653:             .Left = 360
2654:             .Width = 103
2655:             .Height = 17
2656:             .FontName = "Tahoma"
2657:             .FontSize = 8
2658:             .ForeColor = RGB(90,90,90)

*-- Linhas 2665 a 2704:
2665:         loc_oOpt = par_oPg.Fwoption8
2666:         WITH loc_oOpt
2667:             .ButtonCount = 2
2668:             .Top = 52
2669:             .Left = 464
2670:             .Width = 97
2671:             .Height = 25
2672:             .BackStyle = 0
2673:             .BorderStyle = 0
2674:             .Value = 1
2675:             .Visible = .T.
2676:         ENDWITH
2677:         loc_oOpt.Buttons(1).Caption = "Sim"
2678:         loc_oOpt.Buttons(1).Left = 5
2679:         loc_oOpt.Buttons(1).Top = 3
2680:         loc_oOpt.Buttons(1).Width = 40
2681:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2682:         loc_oOpt.Buttons(1).FontSize = 8
2683:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2684:         loc_oOpt.Buttons(1).Themes = .F.
2685:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2686:         loc_oOpt.Buttons(2).Left = 48
2687:         loc_oOpt.Buttons(2).Top = 3
2688:         loc_oOpt.Buttons(2).Width = 44
2689:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2690:         loc_oOpt.Buttons(2).FontSize = 8
2691:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2692:         loc_oOpt.Buttons(2).Themes = .F.
2693: 
2694:         *-- Bairro Obrig (Fwoption9)
2695:         par_oPg.AddObject("lbl_4c_LblBairroObr", "Label")
2696:         WITH par_oPg.lbl_4c_LblBairroObr
2697:             .Caption = "Bairro Obrig.:"
2698:             .Top = 73
2699:             .Left = 360
2700:             .Width = 103
2701:             .Height = 17
2702:             .FontName = "Tahoma"
2703:             .FontSize = 8
2704:             .ForeColor = RGB(90,90,90)

*-- Linhas 2711 a 2750:
2711:         loc_oOpt = par_oPg.Fwoption9
2712:         WITH loc_oOpt
2713:             .ButtonCount = 2
2714:             .Top = 73
2715:             .Left = 464
2716:             .Width = 97
2717:             .Height = 25
2718:             .BackStyle = 0
2719:             .BorderStyle = 0
2720:             .Value = 1
2721:             .Visible = .T.
2722:         ENDWITH
2723:         loc_oOpt.Buttons(1).Caption = "Sim"
2724:         loc_oOpt.Buttons(1).Left = 5
2725:         loc_oOpt.Buttons(1).Top = 3
2726:         loc_oOpt.Buttons(1).Width = 40
2727:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2728:         loc_oOpt.Buttons(1).FontSize = 8
2729:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2730:         loc_oOpt.Buttons(1).Themes = .F.
2731:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2732:         loc_oOpt.Buttons(2).Left = 48
2733:         loc_oOpt.Buttons(2).Top = 3
2734:         loc_oOpt.Buttons(2).Width = 44
2735:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2736:         loc_oOpt.Buttons(2).FontSize = 8
2737:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2738:         loc_oOpt.Buttons(2).Themes = .F.
2739: 
2740:         *-- Cidade Obrig (Fwoption11)
2741:         par_oPg.AddObject("lbl_4c_LblCidObr", "Label")
2742:         WITH par_oPg.lbl_4c_LblCidObr
2743:             .Caption = "Cidade Obrig.:"
2744:             .Top = 92
2745:             .Left = 360
2746:             .Width = 103
2747:             .Height = 17
2748:             .FontName = "Tahoma"
2749:             .FontSize = 8
2750:             .ForeColor = RGB(90,90,90)

*-- Linhas 2757 a 2796:
2757:         loc_oOpt = par_oPg.Fwoption11
2758:         WITH loc_oOpt
2759:             .ButtonCount = 2
2760:             .Top = 92
2761:             .Left = 464
2762:             .Width = 97
2763:             .Height = 25
2764:             .BackStyle = 0
2765:             .BorderStyle = 0
2766:             .Value = 1
2767:             .Visible = .T.
2768:         ENDWITH
2769:         loc_oOpt.Buttons(1).Caption = "Sim"
2770:         loc_oOpt.Buttons(1).Left = 5
2771:         loc_oOpt.Buttons(1).Top = 3
2772:         loc_oOpt.Buttons(1).Width = 40
2773:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2774:         loc_oOpt.Buttons(1).FontSize = 8
2775:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2776:         loc_oOpt.Buttons(1).Themes = .F.
2777:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2778:         loc_oOpt.Buttons(2).Left = 48
2779:         loc_oOpt.Buttons(2).Top = 3
2780:         loc_oOpt.Buttons(2).Width = 44
2781:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2782:         loc_oOpt.Buttons(2).FontSize = 8
2783:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2784:         loc_oOpt.Buttons(2).Themes = .F.
2785: 
2786:         *-- Pais Obrig (Fwoption10)
2787:         par_oPg.AddObject("lbl_4c_LblPaisObr", "Label")
2788:         WITH par_oPg.lbl_4c_LblPaisObr
2789:             .Caption = "Pa" + CHR(237) + "s Obrig.:"
2790:             .Top = 112
2791:             .Left = 360
2792:             .Width = 103
2793:             .Height = 17
2794:             .FontName = "Tahoma"
2795:             .FontSize = 8
2796:             .ForeColor = RGB(90,90,90)

*-- Linhas 2803 a 2842:
2803:         loc_oOpt = par_oPg.Fwoption10
2804:         WITH loc_oOpt
2805:             .ButtonCount = 2
2806:             .Top = 112
2807:             .Left = 464
2808:             .Width = 97
2809:             .Height = 25
2810:             .BackStyle = 0
2811:             .BorderStyle = 0
2812:             .Value = 1
2813:             .Visible = .T.
2814:         ENDWITH
2815:         loc_oOpt.Buttons(1).Caption = "Sim"
2816:         loc_oOpt.Buttons(1).Left = 5
2817:         loc_oOpt.Buttons(1).Top = 3
2818:         loc_oOpt.Buttons(1).Width = 40
2819:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2820:         loc_oOpt.Buttons(1).FontSize = 8
2821:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2822:         loc_oOpt.Buttons(1).Themes = .F.
2823:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2824:         loc_oOpt.Buttons(2).Left = 48
2825:         loc_oOpt.Buttons(2).Top = 3
2826:         loc_oOpt.Buttons(2).Width = 44
2827:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2828:         loc_oOpt.Buttons(2).FontSize = 8
2829:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2830:         loc_oOpt.Buttons(2).Themes = .F.
2831: 
2832:         *-- CEP Obrig (Opt_CEPObrig, 3 btn)
2833:         par_oPg.AddObject("lbl_4c_LblCepObr", "Label")
2834:         WITH par_oPg.lbl_4c_LblCepObr
2835:             .Caption = "CEP Obrig.:"
2836:             .Top = 132
2837:             .Left = 360
2838:             .Width = 103
2839:             .Height = 17
2840:             .FontName = "Tahoma"
2841:             .FontSize = 8
2842:             .ForeColor = RGB(90,90,90)

*-- Linhas 2849 a 2896:
2849:         loc_oOpt = par_oPg.Opt_CEPObrig
2850:         WITH loc_oOpt
2851:             .ButtonCount = 3
2852:             .Top = 132
2853:             .Left = 464
2854:             .Width = 180
2855:             .Height = 25
2856:             .BackStyle = 0
2857:             .BorderStyle = 0
2858:             .Value = 1
2859:             .Visible = .T.
2860:         ENDWITH
2861:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2862:         loc_oOpt.Buttons(1).Left = 5
2863:         loc_oOpt.Buttons(1).Top = 3
2864:         loc_oOpt.Buttons(1).Width = 44
2865:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2866:         loc_oOpt.Buttons(1).FontSize = 8
2867:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2868:         loc_oOpt.Buttons(1).Themes = .F.
2869:         loc_oOpt.Buttons(2).Caption = "Opcional"
2870:         loc_oOpt.Buttons(2).Left = 55
2871:         loc_oOpt.Buttons(2).Top = 3
2872:         loc_oOpt.Buttons(2).Width = 65
2873:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2874:         loc_oOpt.Buttons(2).FontSize = 8
2875:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2876:         loc_oOpt.Buttons(2).Themes = .F.
2877:         loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
2878:         loc_oOpt.Buttons(3).Left = 125
2879:         loc_oOpt.Buttons(3).Top = 3
2880:         loc_oOpt.Buttons(3).Width = 50
2881:         loc_oOpt.Buttons(3).FontName = "Tahoma"
2882:         loc_oOpt.Buttons(3).FontSize = 8
2883:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
2884:         loc_oOpt.Buttons(3).Themes = .F.
2885: 
2886:         *-- IBGE Obrig (getObrIbge)
2887:         par_oPg.AddObject("lbl_4c_LblIbgeObr", "Label")
2888:         WITH par_oPg.lbl_4c_LblIbgeObr
2889:             .Caption = "IBGE Obrig.:"
2890:             .Top = 190
2891:             .Left = 360
2892:             .Width = 103
2893:             .Height = 17
2894:             .FontName = "Tahoma"
2895:             .FontSize = 8
2896:             .ForeColor = RGB(90,90,90)

*-- Linhas 2903 a 2942:
2903:         loc_oOpt = par_oPg.getObrIbge
2904:         WITH loc_oOpt
2905:             .ButtonCount = 2
2906:             .Top = 190
2907:             .Left = 464
2908:             .Width = 97
2909:             .Height = 25
2910:             .BackStyle = 0
2911:             .BorderStyle = 0
2912:             .Value = 1
2913:             .Visible = .T.
2914:         ENDWITH
2915:         loc_oOpt.Buttons(1).Caption = "Sim"
2916:         loc_oOpt.Buttons(1).Left = 5
2917:         loc_oOpt.Buttons(1).Top = 3
2918:         loc_oOpt.Buttons(1).Width = 40
2919:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2920:         loc_oOpt.Buttons(1).FontSize = 8
2921:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
2922:         loc_oOpt.Buttons(1).Themes = .F.
2923:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
2924:         loc_oOpt.Buttons(2).Left = 48
2925:         loc_oOpt.Buttons(2).Top = 3
2926:         loc_oOpt.Buttons(2).Width = 44
2927:         loc_oOpt.Buttons(2).FontName = "Tahoma"
2928:         loc_oOpt.Buttons(2).FontSize = 8
2929:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
2930:         loc_oOpt.Buttons(2).Themes = .F.
2931: 
2932:         *-- Conta Interna
2933:         par_oPg.AddObject("lbl_4c_LblContint", "Label")
2934:         WITH par_oPg.lbl_4c_LblContint
2935:             .Caption = "Conta Interna:"
2936:             .Top = 349
2937:             .Left = 17
2938:             .Width = 90
2939:             .Height = 17
2940:             .FontName = "Tahoma"
2941:             .FontSize = 8
2942:             .ForeColor = RGB(90,90,90)

*-- Linhas 2948 a 2957:
2948:         par_oPg.AddObject("Getcontint", "TextBox")
2949:         WITH par_oPg.Getcontint
2950:             .Value = ""
2951:             .Top = 349
2952:             .Left = 192
2953:             .Width = 73
2954:             .Height = 23
2955:             .MaxLength = 9
2956:             .FontName = "Tahoma"
2957:             .FontSize = 8

*-- Linhas 2963 a 2975:
2963:         ENDWITH
2964: 
2965:         *-- Integracao Contabil (Opt_Integ, 3 btn)
2966:         par_oPg.AddObject("lbl_4c_LblIntcont", "Label")
2967:         WITH par_oPg.lbl_4c_LblIntcont
2968:             .Caption = "Integra" + CHR(231) + CHR(227) + "o Contabil:"
2969:             .Top = 373
2970:             .Left = 17
2971:             .Width = 173
2972:             .Height = 17
2973:             .FontName = "Tahoma"
2974:             .FontSize = 8
2975:             .ForeColor = RGB(90,90,90)

*-- Linhas 2982 a 3029:
2982:         loc_oOpt = par_oPg.Opt_Integ
2983:         WITH loc_oOpt
2984:             .ButtonCount = 3
2985:             .Top = 373
2986:             .Left = 192
2987:             .Width = 316
2988:             .Height = 23
2989:             .BackStyle = 0
2990:             .BorderStyle = 0
2991:             .Value = 1
2992:             .Visible = .T.
2993:         ENDWITH
2994:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
2995:         loc_oOpt.Buttons(1).Left = 5
2996:         loc_oOpt.Buttons(1).Top = 3
2997:         loc_oOpt.Buttons(1).Width = 40
2998:         loc_oOpt.Buttons(1).FontName = "Tahoma"
2999:         loc_oOpt.Buttons(1).FontSize = 8
3000:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3001:         loc_oOpt.Buttons(1).Themes = .F.
3002:         loc_oOpt.Buttons(2).Caption = "Integra" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o"
3003:         loc_oOpt.Buttons(2).Left = 50
3004:         loc_oOpt.Buttons(2).Top = 3
3005:         loc_oOpt.Buttons(2).Width = 130
3006:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3007:         loc_oOpt.Buttons(2).FontSize = 8
3008:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3009:         loc_oOpt.Buttons(2).Themes = .F.
3010:         loc_oOpt.Buttons(3).Caption = "Por Grupo"
3011:         loc_oOpt.Buttons(3).Left = 185
3012:         loc_oOpt.Buttons(3).Top = 3
3013:         loc_oOpt.Buttons(3).Width = 90
3014:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3015:         loc_oOpt.Buttons(3).FontSize = 8
3016:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3017:         loc_oOpt.Buttons(3).Themes = .F.
3018: 
3019:         *-- Padrao Preenchimento (Fwoption3, 4 btn)
3020:         par_oPg.AddObject("lbl_4c_LblPadPgrec", "Label")
3021:         WITH par_oPg.lbl_4c_LblPadPgrec
3022:             .Caption = "Padr" + CHR(227) + "o Preenchimento:"
3023:             .Top = 394
3024:             .Left = 17
3025:             .Width = 173
3026:             .Height = 17
3027:             .FontName = "Tahoma"
3028:             .FontSize = 8
3029:             .ForeColor = RGB(90,90,90)

*-- Linhas 3036 a 3091:
3036:         loc_oOpt = par_oPg.Fwoption3
3037:         WITH loc_oOpt
3038:             .ButtonCount = 4
3039:             .Top = 394
3040:             .Left = 192
3041:             .Width = 353
3042:             .Height = 23
3043:             .BackStyle = 0
3044:             .BorderStyle = 0
3045:             .Value = 1
3046:             .Visible = .T.
3047:         ENDWITH
3048:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3049:         loc_oOpt.Buttons(1).Left = 5
3050:         loc_oOpt.Buttons(1).Top = 3
3051:         loc_oOpt.Buttons(1).Width = 40
3052:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3053:         loc_oOpt.Buttons(1).FontSize = 8
3054:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3055:         loc_oOpt.Buttons(1).Themes = .F.
3056:         loc_oOpt.Buttons(2).Caption = "Gravar Zero"
3057:         loc_oOpt.Buttons(2).Left = 50
3058:         loc_oOpt.Buttons(2).Top = 3
3059:         loc_oOpt.Buttons(2).Width = 80
3060:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3061:         loc_oOpt.Buttons(2).FontSize = 8
3062:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3063:         loc_oOpt.Buttons(2).Themes = .F.
3064:         loc_oOpt.Buttons(3).Caption = "Gravar Nulo"
3065:         loc_oOpt.Buttons(3).Left = 135
3066:         loc_oOpt.Buttons(3).Top = 3
3067:         loc_oOpt.Buttons(3).Width = 80
3068:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3069:         loc_oOpt.Buttons(3).FontSize = 8
3070:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3071:         loc_oOpt.Buttons(3).Themes = .F.
3072:         loc_oOpt.Buttons(4).Caption = "Gravar Vazio"
3073:         loc_oOpt.Buttons(4).Left = 220
3074:         loc_oOpt.Buttons(4).Top = 3
3075:         loc_oOpt.Buttons(4).Width = 80
3076:         loc_oOpt.Buttons(4).FontName = "Tahoma"
3077:         loc_oOpt.Buttons(4).FontSize = 8
3078:         loc_oOpt.Buttons(4).ForeColor = RGB(90,90,90)
3079:         loc_oOpt.Buttons(4).Themes = .F.
3080: 
3081:         *-- Vincula Conta PG/RC (optVincPgRcs)
3082:         par_oPg.AddObject("lbl_4c_LblVincPgRcs", "Label")
3083:         WITH par_oPg.lbl_4c_LblVincPgRcs
3084:             .Caption = "Vincula Conta PG/RC:"
3085:             .Top = 415
3086:             .Left = 17
3087:             .Width = 173
3088:             .Height = 17
3089:             .FontName = "Tahoma"
3090:             .FontSize = 8
3091:             .ForeColor = RGB(90,90,90)

*-- Linhas 3098 a 3137:
3098:         loc_oOpt = par_oPg.optVincPgRcs
3099:         WITH loc_oOpt
3100:             .ButtonCount = 2
3101:             .Top = 415
3102:             .Left = 192
3103:             .Width = 181
3104:             .Height = 23
3105:             .BackStyle = 0
3106:             .BorderStyle = 0
3107:             .Value = 1
3108:             .Visible = .T.
3109:         ENDWITH
3110:         loc_oOpt.Buttons(1).Caption = "Sim"
3111:         loc_oOpt.Buttons(1).Left = 5
3112:         loc_oOpt.Buttons(1).Top = 3
3113:         loc_oOpt.Buttons(1).Width = 40
3114:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3115:         loc_oOpt.Buttons(1).FontSize = 8
3116:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3117:         loc_oOpt.Buttons(1).Themes = .F.
3118:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3119:         loc_oOpt.Buttons(2).Left = 48
3120:         loc_oOpt.Buttons(2).Top = 3
3121:         loc_oOpt.Buttons(2).Width = 44
3122:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3123:         loc_oOpt.Buttons(2).FontSize = 8
3124:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3125:         loc_oOpt.Buttons(2).Themes = .F.
3126: 
3127:         *-- Tit Nao Baixado (OptTitBaixado)
3128:         par_oPg.AddObject("lbl_4c_LblTitBaix", "Label")
3129:         WITH par_oPg.lbl_4c_LblTitBaix
3130:             .Caption = "Visualiza Tit.n" + CHR(227) + "o Baixados:"
3131:             .Top = 435
3132:             .Left = 17
3133:             .Width = 173
3134:             .Height = 17
3135:             .FontName = "Tahoma"
3136:             .FontSize = 8
3137:             .ForeColor = RGB(90,90,90)

*-- Linhas 3144 a 3184:
3144:         loc_oOpt = par_oPg.OptTitBaixado
3145:         WITH loc_oOpt
3146:             .ButtonCount = 2
3147:             .Top = 435
3148:             .Left = 192
3149:             .Width = 181
3150:             .Height = 23
3151:             .BackStyle = 0
3152:             .BorderStyle = 0
3153:             .Value = 1
3154:             .Visible = .T.
3155:         ENDWITH
3156:         loc_oOpt.Buttons(1).Caption = "Sim"
3157:         loc_oOpt.Buttons(1).Left = 5
3158:         loc_oOpt.Buttons(1).Top = 3
3159:         loc_oOpt.Buttons(1).Width = 40
3160:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3161:         loc_oOpt.Buttons(1).FontSize = 8
3162:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3163:         loc_oOpt.Buttons(1).Themes = .F.
3164:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3165:         loc_oOpt.Buttons(2).Left = 48
3166:         loc_oOpt.Buttons(2).Top = 3
3167:         loc_oOpt.Buttons(2).Width = 44
3168:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3169:         loc_oOpt.Buttons(2).FontSize = 8
3170:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3171:         loc_oOpt.Buttons(2).Themes = .F.
3172: 
3173:         *-- Col 3: dados adicionais (Left 583+)
3174:         *-- Duplicar Endereco (Fwoption4)
3175:         par_oPg.AddObject("lbl_4c_LblDupEnd", "Label")
3176:         WITH par_oPg.lbl_4c_LblDupEnd
3177:             .Caption = "Duplicar Endere" + CHR(231) + "o:"
3178:             .Top = 34
3179:             .Left = 600
3180:             .Width = 120
3181:             .Height = 17
3182:             .FontName = "Tahoma"
3183:             .FontSize = 8
3184:             .ForeColor = RGB(90,90,90)

*-- Linhas 3191 a 3230:
3191:         loc_oOpt = par_oPg.Fwoption4
3192:         WITH loc_oOpt
3193:             .ButtonCount = 2
3194:             .Top = 34
3195:             .Left = 796
3196:             .Width = 131
3197:             .Height = 23
3198:             .BackStyle = 0
3199:             .BorderStyle = 0
3200:             .Value = 1
3201:             .Visible = .T.
3202:         ENDWITH
3203:         loc_oOpt.Buttons(1).Caption = "Sim"
3204:         loc_oOpt.Buttons(1).Left = 5
3205:         loc_oOpt.Buttons(1).Top = 3
3206:         loc_oOpt.Buttons(1).Width = 40
3207:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3208:         loc_oOpt.Buttons(1).FontSize = 8
3209:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3210:         loc_oOpt.Buttons(1).Themes = .F.
3211:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3212:         loc_oOpt.Buttons(2).Left = 48
3213:         loc_oOpt.Buttons(2).Top = 3
3214:         loc_oOpt.Buttons(2).Width = 44
3215:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3216:         loc_oOpt.Buttons(2).FontSize = 8
3217:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3218:         loc_oOpt.Buttons(2).Themes = .F.
3219: 
3220:         *-- Restringe Endereco (Fwoption5)
3221:         par_oPg.AddObject("lbl_4c_LblRestrEnd", "Label")
3222:         WITH par_oPg.lbl_4c_LblRestrEnd
3223:             .Caption = "Restringe Endere" + CHR(231) + "o:"
3224:             .Top = 55
3225:             .Left = 600
3226:             .Width = 120
3227:             .Height = 17
3228:             .FontName = "Tahoma"
3229:             .FontSize = 8
3230:             .ForeColor = RGB(90,90,90)

*-- Linhas 3237 a 3276:
3237:         loc_oOpt = par_oPg.Fwoption5
3238:         WITH loc_oOpt
3239:             .ButtonCount = 2
3240:             .Top = 55
3241:             .Left = 796
3242:             .Width = 131
3243:             .Height = 23
3244:             .BackStyle = 0
3245:             .BorderStyle = 0
3246:             .Value = 1
3247:             .Visible = .T.
3248:         ENDWITH
3249:         loc_oOpt.Buttons(1).Caption = "Sim"
3250:         loc_oOpt.Buttons(1).Left = 5
3251:         loc_oOpt.Buttons(1).Top = 3
3252:         loc_oOpt.Buttons(1).Width = 40
3253:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3254:         loc_oOpt.Buttons(1).FontSize = 8
3255:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3256:         loc_oOpt.Buttons(1).Themes = .F.
3257:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3258:         loc_oOpt.Buttons(2).Left = 48
3259:         loc_oOpt.Buttons(2).Top = 3
3260:         loc_oOpt.Buttons(2).Width = 44
3261:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3262:         loc_oOpt.Buttons(2).FontSize = 8
3263:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3264:         loc_oOpt.Buttons(2).Themes = .F.
3265: 
3266:         *-- Bloqueia CPF (Fwoption16)
3267:         par_oPg.AddObject("lbl_4c_LblBlqCpf", "Label")
3268:         WITH par_oPg.lbl_4c_LblBlqCpf
3269:             .Caption = "Bloqueia CPF dup.:"
3270:             .Top = 73
3271:             .Left = 600
3272:             .Width = 120
3273:             .Height = 17
3274:             .FontName = "Tahoma"
3275:             .FontSize = 8
3276:             .ForeColor = RGB(90,90,90)

*-- Linhas 3283 a 3322:
3283:         loc_oOpt = par_oPg.Fwoption16
3284:         WITH loc_oOpt
3285:             .ButtonCount = 2
3286:             .Top = 73
3287:             .Left = 796
3288:             .Width = 131
3289:             .Height = 23
3290:             .BackStyle = 0
3291:             .BorderStyle = 0
3292:             .Value = 1
3293:             .Visible = .T.
3294:         ENDWITH
3295:         loc_oOpt.Buttons(1).Caption = "Sim"
3296:         loc_oOpt.Buttons(1).Left = 5
3297:         loc_oOpt.Buttons(1).Top = 3
3298:         loc_oOpt.Buttons(1).Width = 40
3299:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3300:         loc_oOpt.Buttons(1).FontSize = 8
3301:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3302:         loc_oOpt.Buttons(1).Themes = .F.
3303:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3304:         loc_oOpt.Buttons(2).Left = 48
3305:         loc_oOpt.Buttons(2).Top = 3
3306:         loc_oOpt.Buttons(2).Width = 44
3307:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3308:         loc_oOpt.Buttons(2).FontSize = 8
3309:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3310:         loc_oOpt.Buttons(2).Themes = .F.
3311: 
3312:         *-- Mostrar Foto (Opt_MFotos)
3313:         par_oPg.AddObject("lbl_4c_LblMFotos", "Label")
3314:         WITH par_oPg.lbl_4c_LblMFotos
3315:             .Caption = "Mostrar Foto:"
3316:             .Top = 93
3317:             .Left = 600
3318:             .Width = 120
3319:             .Height = 17
3320:             .FontName = "Tahoma"
3321:             .FontSize = 8
3322:             .ForeColor = RGB(90,90,90)

*-- Linhas 3329 a 3368:
3329:         loc_oOpt = par_oPg.Opt_MFotos
3330:         WITH loc_oOpt
3331:             .ButtonCount = 2
3332:             .Top = 93
3333:             .Left = 796
3334:             .Width = 131
3335:             .Height = 22
3336:             .BackStyle = 0
3337:             .BorderStyle = 0
3338:             .Value = 1
3339:             .Visible = .T.
3340:         ENDWITH
3341:         loc_oOpt.Buttons(1).Caption = "Sim"
3342:         loc_oOpt.Buttons(1).Left = 5
3343:         loc_oOpt.Buttons(1).Top = 3
3344:         loc_oOpt.Buttons(1).Width = 40
3345:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3346:         loc_oOpt.Buttons(1).FontSize = 8
3347:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3348:         loc_oOpt.Buttons(1).Themes = .F.
3349:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3350:         loc_oOpt.Buttons(2).Left = 48
3351:         loc_oOpt.Buttons(2).Top = 3
3352:         loc_oOpt.Buttons(2).Width = 44
3353:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3354:         loc_oOpt.Buttons(2).FontSize = 8
3355:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3356:         loc_oOpt.Buttons(2).Themes = .F.
3357: 
3358:         *-- Observacoes (fwoption1, 3 btn)
3359:         par_oPg.AddObject("lbl_4c_LblObservs", "Label")
3360:         WITH par_oPg.lbl_4c_LblObservs
3361:             .Caption = "Observa" + CHR(231) + CHR(245) + "es:"
3362:             .Top = 111
3363:             .Left = 600
3364:             .Width = 120
3365:             .Height = 17
3366:             .FontName = "Tahoma"
3367:             .FontSize = 8
3368:             .ForeColor = RGB(90,90,90)

*-- Linhas 3375 a 3422:
3375:         loc_oOpt = par_oPg.fwoption1
3376:         WITH loc_oOpt
3377:             .ButtonCount = 3
3378:             .Top = 111
3379:             .Left = 797
3380:             .Width = 131
3381:             .Height = 52
3382:             .BackStyle = 0
3383:             .BorderStyle = 0
3384:             .Value = 1
3385:             .Visible = .T.
3386:         ENDWITH
3387:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3388:         loc_oOpt.Buttons(1).Left = 5
3389:         loc_oOpt.Buttons(1).Top = 3
3390:         loc_oOpt.Buttons(1).Width = 44
3391:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3392:         loc_oOpt.Buttons(1).FontSize = 8
3393:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3394:         loc_oOpt.Buttons(1).Themes = .F.
3395:         loc_oOpt.Buttons(2).Caption = "Livre"
3396:         loc_oOpt.Buttons(2).Left = 5
3397:         loc_oOpt.Buttons(2).Top = 22
3398:         loc_oOpt.Buttons(2).Width = 44
3399:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3400:         loc_oOpt.Buttons(2).FontSize = 8
3401:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3402:         loc_oOpt.Buttons(2).Themes = .F.
3403:         loc_oOpt.Buttons(3).Caption = "RTF"
3404:         loc_oOpt.Buttons(3).Left = 5
3405:         loc_oOpt.Buttons(3).Top = 41
3406:         loc_oOpt.Buttons(3).Width = 44
3407:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3408:         loc_oOpt.Buttons(3).FontSize = 8
3409:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3410:         loc_oOpt.Buttons(3).Themes = .F.
3411: 
3412:         *-- CPF Fixo (optCpffixo, 3 btn)
3413:         par_oPg.AddObject("lbl_4c_LblCpfFixo", "Label")
3414:         WITH par_oPg.lbl_4c_LblCpfFixo
3415:             .Caption = "CPF/CNPJ Fixo:"
3416:             .Top = 163
3417:             .Left = 600
3418:             .Width = 120
3419:             .Height = 17
3420:             .FontName = "Tahoma"
3421:             .FontSize = 8
3422:             .ForeColor = RGB(90,90,90)

*-- Linhas 3429 a 3476:
3429:         loc_oOpt = par_oPg.optCpffixo
3430:         WITH loc_oOpt
3431:             .ButtonCount = 3
3432:             .Top = 163
3433:             .Left = 798
3434:             .Width = 183
3435:             .Height = 23
3436:             .BackStyle = 0
3437:             .BorderStyle = 0
3438:             .Value = 1
3439:             .Visible = .T.
3440:         ENDWITH
3441:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
3442:         loc_oOpt.Buttons(1).Left = 5
3443:         loc_oOpt.Buttons(1).Top = 3
3444:         loc_oOpt.Buttons(1).Width = 40
3445:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3446:         loc_oOpt.Buttons(1).FontSize = 8
3447:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3448:         loc_oOpt.Buttons(1).Themes = .F.
3449:         loc_oOpt.Buttons(2).Caption = "Fixar Formato"
3450:         loc_oOpt.Buttons(2).Left = 50
3451:         loc_oOpt.Buttons(2).Top = 3
3452:         loc_oOpt.Buttons(2).Width = 80
3453:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3454:         loc_oOpt.Buttons(2).FontSize = 8
3455:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3456:         loc_oOpt.Buttons(2).Themes = .F.
3457:         loc_oOpt.Buttons(3).Caption = "Fixar CPF"
3458:         loc_oOpt.Buttons(3).Left = 135
3459:         loc_oOpt.Buttons(3).Top = 3
3460:         loc_oOpt.Buttons(3).Width = 45
3461:         loc_oOpt.Buttons(3).FontName = "Tahoma"
3462:         loc_oOpt.Buttons(3).FontSize = 8
3463:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
3464:         loc_oOpt.Buttons(3).Themes = .F.
3465: 
3466:         *-- Situacao Padrao
3467:         par_oPg.AddObject("lbl_4c_LblSitPad", "Label")
3468:         WITH par_oPg.lbl_4c_LblSitPad
3469:             .Caption = "Situa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o:"
3470:             .Top = 188
3471:             .Left = 600
3472:             .Width = 120
3473:             .Height = 17
3474:             .FontName = "Tahoma"
3475:             .FontSize = 8
3476:             .ForeColor = RGB(90,90,90)

*-- Linhas 3482 a 3491:
3482:         par_oPg.AddObject("getSituas", "TextBox")
3483:         WITH par_oPg.getSituas
3484:             .Value = ""
3485:             .Top = 188
3486:             .Left = 801
3487:             .Width = 48
3488:             .Height = 23
3489:             .MaxLength = 3
3490:             .FontName = "Tahoma"
3491:             .FontSize = 8

*-- Linhas 3500 a 3512:
3500:         BINDEVENT(par_oPg.getSituas, "KeyPress", THIS, "SituacaoLostFocus")
3501: 
3502:         *-- Caracteristicas (optCarac)
3503:         par_oPg.AddObject("lbl_4c_LblCarac", "Label")
3504:         WITH par_oPg.lbl_4c_LblCarac
3505:             .Caption = "Caracter" + CHR(237) + "sticas:"
3506:             .Top = 211
3507:             .Left = 600
3508:             .Width = 120
3509:             .Height = 17
3510:             .FontName = "Tahoma"
3511:             .FontSize = 8
3512:             .ForeColor = RGB(90,90,90)

*-- Linhas 3519 a 3558:
3519:         loc_oOpt = par_oPg.optCarac
3520:         WITH loc_oOpt
3521:             .ButtonCount = 2
3522:             .Top = 211
3523:             .Left = 796
3524:             .Width = 131
3525:             .Height = 23
3526:             .BackStyle = 0
3527:             .BorderStyle = 0
3528:             .Value = 1
3529:             .Visible = .T.
3530:         ENDWITH
3531:         loc_oOpt.Buttons(1).Caption = "Sim"
3532:         loc_oOpt.Buttons(1).Left = 5
3533:         loc_oOpt.Buttons(1).Top = 3
3534:         loc_oOpt.Buttons(1).Width = 40
3535:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3536:         loc_oOpt.Buttons(1).FontSize = 8
3537:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3538:         loc_oOpt.Buttons(1).Themes = .F.
3539:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3540:         loc_oOpt.Buttons(2).Left = 48
3541:         loc_oOpt.Buttons(2).Top = 3
3542:         loc_oOpt.Buttons(2).Width = 44
3543:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3544:         loc_oOpt.Buttons(2).FontSize = 8
3545:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3546:         loc_oOpt.Buttons(2).Themes = .F.
3547: 
3548:         *-- AceJob (optAceJob)
3549:         par_oPg.AddObject("lbl_4c_LblAceJob", "Label")
3550:         WITH par_oPg.lbl_4c_LblAceJob
3551:             .Caption = "Aceita Job:"
3552:             .Top = 232
3553:             .Left = 600
3554:             .Width = 120
3555:             .Height = 17
3556:             .FontName = "Tahoma"
3557:             .FontSize = 8
3558:             .ForeColor = RGB(90,90,90)

*-- Linhas 3565 a 3604:
3565:         loc_oOpt = par_oPg.optAceJob
3566:         WITH loc_oOpt
3567:             .ButtonCount = 2
3568:             .Top = 232
3569:             .Left = 796
3570:             .Width = 131
3571:             .Height = 23
3572:             .BackStyle = 0
3573:             .BorderStyle = 0
3574:             .Value = 1
3575:             .Visible = .T.
3576:         ENDWITH
3577:         loc_oOpt.Buttons(1).Caption = "Sim"
3578:         loc_oOpt.Buttons(1).Left = 5
3579:         loc_oOpt.Buttons(1).Top = 3
3580:         loc_oOpt.Buttons(1).Width = 40
3581:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3582:         loc_oOpt.Buttons(1).FontSize = 8
3583:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3584:         loc_oOpt.Buttons(1).Themes = .F.
3585:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3586:         loc_oOpt.Buttons(2).Left = 48
3587:         loc_oOpt.Buttons(2).Top = 3
3588:         loc_oOpt.Buttons(2).Width = 44
3589:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3590:         loc_oOpt.Buttons(2).FontSize = 8
3591:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3592:         loc_oOpt.Buttons(2).Themes = .F.
3593: 
3594:         *-- Alerta Cadastro (OptAlertaCad)
3595:         par_oPg.AddObject("lbl_4c_LblAlertaCad", "Label")
3596:         WITH par_oPg.lbl_4c_LblAlertaCad
3597:             .Caption = "Alerta Cadastro:"
3598:             .Top = 250
3599:             .Left = 600
3600:             .Width = 120
3601:             .Height = 17
3602:             .FontName = "Tahoma"
3603:             .FontSize = 8
3604:             .ForeColor = RGB(90,90,90)

*-- Linhas 3611 a 3664:
3611:         loc_oOpt = par_oPg.OptAlertaCad
3612:         WITH loc_oOpt
3613:             .ButtonCount = 2
3614:             .Top = 250
3615:             .Left = 795
3616:             .Width = 98
3617:             .Height = 25
3618:             .BackStyle = 0
3619:             .BorderStyle = 0
3620:             .Value = 1
3621:             .Visible = .T.
3622:         ENDWITH
3623:         loc_oOpt.Buttons(1).Caption = "Sim"
3624:         loc_oOpt.Buttons(1).Left = 5
3625:         loc_oOpt.Buttons(1).Top = 3
3626:         loc_oOpt.Buttons(1).Width = 40
3627:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3628:         loc_oOpt.Buttons(1).FontSize = 8
3629:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3630:         loc_oOpt.Buttons(1).Themes = .F.
3631:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3632:         loc_oOpt.Buttons(2).Left = 48
3633:         loc_oOpt.Buttons(2).Top = 3
3634:         loc_oOpt.Buttons(2).Width = 44
3635:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3636:         loc_oOpt.Buttons(2).FontSize = 8
3637:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3638:         loc_oOpt.Buttons(2).Themes = .F.
3639: 
3640:         *-- Mensagem de Alerta
3641:         par_oPg.AddObject("lbl_4c_LblMsgAlerta", "Label")
3642:         WITH par_oPg.lbl_4c_LblMsgAlerta
3643:             .Caption = "Mensagem Alerta:"
3644:             .Top = 271
3645:             .Left = 600
3646:             .Width = 120
3647:             .Height = 17
3648:             .FontName = "Tahoma"
3649:             .FontSize = 8
3650:             .ForeColor = RGB(90,90,90)
3651:             .BackStyle = 0
3652:             .Visible = .T.
3653:         ENDWITH
3654: 
3655:         par_oPg.AddObject("getMsgAlertaC", "EditBox")
3656:         WITH par_oPg.getMsgAlertaC
3657:             .Value = ""
3658:             .Top = 272
3659:             .Left = 799
3660:             .Width = 189
3661:             .Height = 65
3662:             .FontName = "Tahoma"
3663:             .FontSize = 8
3664:             .ForeColor = RGB(90,90,90)

*-- Linhas 3679 a 3700:
3679:         *-- Linha separadora
3680:         par_oPg.AddObject("lin_4c_Est1", "Line")
3681:         WITH par_oPg.lin_4c_Est1
3682:             .Top = 158
3683:             .Left = 17
3684:             .Width = 959
3685:             .Height = 1
3686:             .BorderColor = RGB(150,150,150)
3687:             .Visible = .T.
3688:         ENDWITH
3689: 
3690:         *-- Limite de Estoque (Opt_LimEsto)
3691:         par_oPg.AddObject("lbl_4c_LblLimEsto", "Label")
3692:         WITH par_oPg.lbl_4c_LblLimEsto
3693:             .Caption = "Limite de Estoque:"
3694:             .Top = 29
3695:             .Left = 17
3696:             .Width = 156
3697:             .Height = 17
3698:             .FontName = "Tahoma"
3699:             .FontSize = 8
3700:             .ForeColor = RGB(90,90,90)

*-- Linhas 3707 a 3746:
3707:         loc_oOpt = par_oPg.Opt_LimEsto
3708:         WITH loc_oOpt
3709:             .ButtonCount = 2
3710:             .Top = 29
3711:             .Left = 174
3712:             .Width = 92
3713:             .Height = 25
3714:             .BackStyle = 0
3715:             .BorderStyle = 0
3716:             .Value = 1
3717:             .Visible = .T.
3718:         ENDWITH
3719:         loc_oOpt.Buttons(1).Caption = "Sim"
3720:         loc_oOpt.Buttons(1).Left = 5
3721:         loc_oOpt.Buttons(1).Top = 3
3722:         loc_oOpt.Buttons(1).Width = 40
3723:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3724:         loc_oOpt.Buttons(1).FontSize = 8
3725:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3726:         loc_oOpt.Buttons(1).Themes = .F.
3727:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3728:         loc_oOpt.Buttons(2).Left = 48
3729:         loc_oOpt.Buttons(2).Top = 3
3730:         loc_oOpt.Buttons(2).Width = 44
3731:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3732:         loc_oOpt.Buttons(2).FontSize = 8
3733:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3734:         loc_oOpt.Buttons(2).Themes = .F.
3735: 
3736:         *-- Verificar Estoque (Opt_VerEst)
3737:         par_oPg.AddObject("lbl_4c_LblVerEst", "Label")
3738:         WITH par_oPg.lbl_4c_LblVerEst
3739:             .Caption = "Verificar Estoque:"
3740:             .Top = 53
3741:             .Left = 17
3742:             .Width = 156
3743:             .Height = 17
3744:             .FontName = "Tahoma"
3745:             .FontSize = 8
3746:             .ForeColor = RGB(90,90,90)

*-- Linhas 3753 a 3792:
3753:         loc_oOpt = par_oPg.Opt_VerEst
3754:         WITH loc_oOpt
3755:             .ButtonCount = 2
3756:             .Top = 53
3757:             .Left = 174
3758:             .Width = 92
3759:             .Height = 25
3760:             .BackStyle = 0
3761:             .BorderStyle = 0
3762:             .Value = 1
3763:             .Visible = .T.
3764:         ENDWITH
3765:         loc_oOpt.Buttons(1).Caption = "Sim"
3766:         loc_oOpt.Buttons(1).Left = 5
3767:         loc_oOpt.Buttons(1).Top = 3
3768:         loc_oOpt.Buttons(1).Width = 40
3769:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3770:         loc_oOpt.Buttons(1).FontSize = 8
3771:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3772:         loc_oOpt.Buttons(1).Themes = .F.
3773:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3774:         loc_oOpt.Buttons(2).Left = 48
3775:         loc_oOpt.Buttons(2).Top = 3
3776:         loc_oOpt.Buttons(2).Width = 44
3777:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3778:         loc_oOpt.Buttons(2).FontSize = 8
3779:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3780:         loc_oOpt.Buttons(2).Themes = .F.
3781: 
3782:         *-- Est P.Acabar (Opt_EstPAcab)
3783:         par_oPg.AddObject("lbl_4c_LblEstPAcab", "Label")
3784:         WITH par_oPg.lbl_4c_LblEstPAcab
3785:             .Caption = "Est. P.Acabar:"
3786:             .Top = 77
3787:             .Left = 17
3788:             .Width = 156
3789:             .Height = 17
3790:             .FontName = "Tahoma"
3791:             .FontSize = 8
3792:             .ForeColor = RGB(90,90,90)

*-- Linhas 3799 a 3838:
3799:         loc_oOpt = par_oPg.Opt_EstPAcab
3800:         WITH loc_oOpt
3801:             .ButtonCount = 2
3802:             .Top = 77
3803:             .Left = 174
3804:             .Width = 92
3805:             .Height = 25
3806:             .BackStyle = 0
3807:             .BorderStyle = 0
3808:             .Value = 1
3809:             .Visible = .T.
3810:         ENDWITH
3811:         loc_oOpt.Buttons(1).Caption = "Sim"
3812:         loc_oOpt.Buttons(1).Left = 5
3813:         loc_oOpt.Buttons(1).Top = 3
3814:         loc_oOpt.Buttons(1).Width = 40
3815:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3816:         loc_oOpt.Buttons(1).FontSize = 8
3817:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3818:         loc_oOpt.Buttons(1).Themes = .F.
3819:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3820:         loc_oOpt.Buttons(2).Left = 48
3821:         loc_oOpt.Buttons(2).Top = 3
3822:         loc_oOpt.Buttons(2).Width = 44
3823:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3824:         loc_oOpt.Buttons(2).FontSize = 8
3825:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3826:         loc_oOpt.Buttons(2).Themes = .F.
3827: 
3828:         *-- Checa Lim Estoque (opt_ChkLimest)
3829:         par_oPg.AddObject("lbl_4c_LblChkLimEst", "Label")
3830:         WITH par_oPg.lbl_4c_LblChkLimEst
3831:             .Caption = "Checa Lim.Estoque:"
3832:             .Top = 101
3833:             .Left = 17
3834:             .Width = 156
3835:             .Height = 17
3836:             .FontName = "Tahoma"
3837:             .FontSize = 8
3838:             .ForeColor = RGB(90,90,90)

*-- Linhas 3845 a 3884:
3845:         loc_oOpt = par_oPg.opt_ChkLimest
3846:         WITH loc_oOpt
3847:             .ButtonCount = 2
3848:             .Top = 101
3849:             .Left = 174
3850:             .Width = 92
3851:             .Height = 25
3852:             .BackStyle = 0
3853:             .BorderStyle = 0
3854:             .Value = 1
3855:             .Visible = .T.
3856:         ENDWITH
3857:         loc_oOpt.Buttons(1).Caption = "Sim"
3858:         loc_oOpt.Buttons(1).Left = 5
3859:         loc_oOpt.Buttons(1).Top = 3
3860:         loc_oOpt.Buttons(1).Width = 40
3861:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3862:         loc_oOpt.Buttons(1).FontSize = 8
3863:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3864:         loc_oOpt.Buttons(1).Themes = .F.
3865:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3866:         loc_oOpt.Buttons(2).Left = 48
3867:         loc_oOpt.Buttons(2).Top = 3
3868:         loc_oOpt.Buttons(2).Width = 44
3869:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3870:         loc_oOpt.Buttons(2).FontSize = 8
3871:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3872:         loc_oOpt.Buttons(2).Themes = .F.
3873: 
3874:         *-- Centro de Custos (Opt_CCusto)
3875:         par_oPg.AddObject("lbl_4c_LblCCusto", "Label")
3876:         WITH par_oPg.lbl_4c_LblCCusto
3877:             .Caption = "Centro de Custos:"
3878:             .Top = 125
3879:             .Left = 17
3880:             .Width = 156
3881:             .Height = 17
3882:             .FontName = "Tahoma"
3883:             .FontSize = 8
3884:             .ForeColor = RGB(90,90,90)

*-- Linhas 3891 a 3930:
3891:         loc_oOpt = par_oPg.Opt_CCusto
3892:         WITH loc_oOpt
3893:             .ButtonCount = 2
3894:             .Top = 125
3895:             .Left = 174
3896:             .Width = 92
3897:             .Height = 25
3898:             .BackStyle = 0
3899:             .BorderStyle = 0
3900:             .Value = 1
3901:             .Visible = .T.
3902:         ENDWITH
3903:         loc_oOpt.Buttons(1).Caption = "Sim"
3904:         loc_oOpt.Buttons(1).Left = 5
3905:         loc_oOpt.Buttons(1).Top = 3
3906:         loc_oOpt.Buttons(1).Width = 40
3907:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3908:         loc_oOpt.Buttons(1).FontSize = 8
3909:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3910:         loc_oOpt.Buttons(1).Themes = .F.
3911:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3912:         loc_oOpt.Buttons(2).Left = 48
3913:         loc_oOpt.Buttons(2).Top = 3
3914:         loc_oOpt.Buttons(2).Width = 44
3915:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3916:         loc_oOpt.Buttons(2).FontSize = 8
3917:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3918:         loc_oOpt.Buttons(2).Themes = .F.
3919: 
3920:         *-- Gerar Balancete (Opt_GBals)
3921:         par_oPg.AddObject("lbl_4c_LblGBals", "Label")
3922:         WITH par_oPg.lbl_4c_LblGBals
3923:             .Caption = "Gerar Balan" + CHR(231) + "o:"
3924:             .Top = 191
3925:             .Left = 17
3926:             .Width = 156
3927:             .Height = 17
3928:             .FontName = "Tahoma"
3929:             .FontSize = 8
3930:             .ForeColor = RGB(90,90,90)

*-- Linhas 3937 a 3976:
3937:         loc_oOpt = par_oPg.Opt_GBals
3938:         WITH loc_oOpt
3939:             .ButtonCount = 2
3940:             .Top = 191
3941:             .Left = 174
3942:             .Width = 92
3943:             .Height = 25
3944:             .BackStyle = 0
3945:             .BorderStyle = 0
3946:             .Value = 1
3947:             .Visible = .T.
3948:         ENDWITH
3949:         loc_oOpt.Buttons(1).Caption = "Sim"
3950:         loc_oOpt.Buttons(1).Left = 5
3951:         loc_oOpt.Buttons(1).Top = 3
3952:         loc_oOpt.Buttons(1).Width = 40
3953:         loc_oOpt.Buttons(1).FontName = "Tahoma"
3954:         loc_oOpt.Buttons(1).FontSize = 8
3955:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
3956:         loc_oOpt.Buttons(1).Themes = .F.
3957:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
3958:         loc_oOpt.Buttons(2).Left = 48
3959:         loc_oOpt.Buttons(2).Top = 3
3960:         loc_oOpt.Buttons(2).Width = 44
3961:         loc_oOpt.Buttons(2).FontName = "Tahoma"
3962:         loc_oOpt.Buttons(2).FontSize = 8
3963:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
3964:         loc_oOpt.Buttons(2).Themes = .F.
3965: 
3966:         *-- Grupo Dif Balanco
3967:         par_oPg.AddObject("lbl_4c_LblGrufals", "Label")
3968:         WITH par_oPg.lbl_4c_LblGrufals
3969:             .Caption = "Grupo Dif.Balan" + CHR(231) + "o:"
3970:             .Top = 216
3971:             .Left = 17
3972:             .Width = 156
3973:             .Height = 17
3974:             .FontName = "Tahoma"
3975:             .FontSize = 8
3976:             .ForeColor = RGB(90,90,90)

*-- Linhas 3982 a 3991:
3982:         par_oPg.AddObject("Get_grupo", "TextBox")
3983:         WITH par_oPg.Get_grupo
3984:             .Value = ""
3985:             .Top = 216
3986:             .Left = 179
3987:             .Width = 90
3988:             .Height = 23
3989:             .MaxLength = 10
3990:             .FontName = "Tahoma"
3991:             .FontSize = 8

*-- Linhas 3999 a 4011:
3999:         BINDEVENT(par_oPg.Get_grupo, "DblClick", THIS, "GrupoEstoqueDblClick")
4000: 
4001:         *-- Balanco Unificado (Opt_UnifBal, 4 btn)
4002:         par_oPg.AddObject("lbl_4c_LblUnifBal", "Label")
4003:         WITH par_oPg.lbl_4c_LblUnifBal
4004:             .Caption = "Balan" + CHR(231) + "o Unificado:"
4005:             .Top = 242
4006:             .Left = 17
4007:             .Width = 156
4008:             .Height = 17
4009:             .FontName = "Tahoma"
4010:             .FontSize = 8
4011:             .ForeColor = RGB(90,90,90)

*-- Linhas 4018 a 4073:
4018:         loc_oOpt = par_oPg.Opt_UnifBal
4019:         WITH loc_oOpt
4020:             .ButtonCount = 4
4021:             .Top = 242
4022:             .Left = 174
4023:             .Width = 171
4024:             .Height = 43
4025:             .BackStyle = 0
4026:             .BorderStyle = 0
4027:             .Value = 1
4028:             .Visible = .T.
4029:         ENDWITH
4030:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4031:         loc_oOpt.Buttons(1).Left = 5
4032:         loc_oOpt.Buttons(1).Top = 3
4033:         loc_oOpt.Buttons(1).Width = 40
4034:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4035:         loc_oOpt.Buttons(1).FontSize = 8
4036:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4037:         loc_oOpt.Buttons(1).Themes = .F.
4038:         loc_oOpt.Buttons(2).Caption = "Empresa"
4039:         loc_oOpt.Buttons(2).Left = 50
4040:         loc_oOpt.Buttons(2).Top = 3
4041:         loc_oOpt.Buttons(2).Width = 60
4042:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4043:         loc_oOpt.Buttons(2).FontSize = 8
4044:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4045:         loc_oOpt.Buttons(2).Themes = .F.
4046:         loc_oOpt.Buttons(3).Caption = "Grupo"
4047:         loc_oOpt.Buttons(3).Left = 115
4048:         loc_oOpt.Buttons(3).Top = 3
4049:         loc_oOpt.Buttons(3).Width = 50
4050:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4051:         loc_oOpt.Buttons(3).FontSize = 8
4052:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4053:         loc_oOpt.Buttons(3).Themes = .F.
4054:         loc_oOpt.Buttons(4).Caption = "Ambos"
4055:         loc_oOpt.Buttons(4).Left = 5
4056:         loc_oOpt.Buttons(4).Top = 23
4057:         loc_oOpt.Buttons(4).Width = 50
4058:         loc_oOpt.Buttons(4).FontName = "Tahoma"
4059:         loc_oOpt.Buttons(4).FontSize = 8
4060:         loc_oOpt.Buttons(4).ForeColor = RGB(90,90,90)
4061:         loc_oOpt.Buttons(4).Themes = .F.
4062: 
4063:         *-- Balanco Falhas/Perdas (Opt_FalPers)
4064:         par_oPg.AddObject("lbl_4c_LblFalPers", "Label")
4065:         WITH par_oPg.lbl_4c_LblFalPers
4066:             .Caption = "Balan" + CHR(231) + "o Falhas/Perdas:"
4067:             .Top = 285
4068:             .Left = 17
4069:             .Width = 156
4070:             .Height = 17
4071:             .FontName = "Tahoma"
4072:             .FontSize = 8
4073:             .ForeColor = RGB(90,90,90)

*-- Linhas 4080 a 4119:
4080:         loc_oOpt = par_oPg.Opt_FalPers
4081:         WITH loc_oOpt
4082:             .ButtonCount = 2
4083:             .Top = 285
4084:             .Left = 174
4085:             .Width = 92
4086:             .Height = 25
4087:             .BackStyle = 0
4088:             .BorderStyle = 0
4089:             .Value = 1
4090:             .Visible = .T.
4091:         ENDWITH
4092:         loc_oOpt.Buttons(1).Caption = "Sim"
4093:         loc_oOpt.Buttons(1).Left = 5
4094:         loc_oOpt.Buttons(1).Top = 3
4095:         loc_oOpt.Buttons(1).Width = 40
4096:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4097:         loc_oOpt.Buttons(1).FontSize = 8
4098:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4099:         loc_oOpt.Buttons(1).Themes = .F.
4100:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4101:         loc_oOpt.Buttons(2).Left = 48
4102:         loc_oOpt.Buttons(2).Top = 3
4103:         loc_oOpt.Buttons(2).Width = 44
4104:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4105:         loc_oOpt.Buttons(2).FontSize = 8
4106:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4107:         loc_oOpt.Buttons(2).Themes = .F.
4108: 
4109:         *-- Bloqueia Divisao OF (Opt_BlqDivOp)
4110:         par_oPg.AddObject("lbl_4c_LblBlqDivOp", "Label")
4111:         WITH par_oPg.lbl_4c_LblBlqDivOp
4112:             .Caption = "Bloqueia Divis" + CHR(227) + "o OF:"
4113:             .Top = 311
4114:             .Left = 17
4115:             .Width = 156
4116:             .Height = 17
4117:             .FontName = "Tahoma"
4118:             .FontSize = 8
4119:             .ForeColor = RGB(90,90,90)

*-- Linhas 4126 a 4165:
4126:         loc_oOpt = par_oPg.Opt_BlqDivOp
4127:         WITH loc_oOpt
4128:             .ButtonCount = 2
4129:             .Top = 311
4130:             .Left = 174
4131:             .Width = 92
4132:             .Height = 25
4133:             .BackStyle = 0
4134:             .BorderStyle = 0
4135:             .Value = 1
4136:             .Visible = .T.
4137:         ENDWITH
4138:         loc_oOpt.Buttons(1).Caption = "Sim"
4139:         loc_oOpt.Buttons(1).Left = 5
4140:         loc_oOpt.Buttons(1).Top = 3
4141:         loc_oOpt.Buttons(1).Width = 40
4142:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4143:         loc_oOpt.Buttons(1).FontSize = 8
4144:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4145:         loc_oOpt.Buttons(1).Themes = .F.
4146:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4147:         loc_oOpt.Buttons(2).Left = 48
4148:         loc_oOpt.Buttons(2).Top = 3
4149:         loc_oOpt.Buttons(2).Width = 44
4150:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4151:         loc_oOpt.Buttons(2).FontSize = 8
4152:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4153:         loc_oOpt.Buttons(2).Themes = .F.
4154: 
4155:         *-- OS - Data de Entrega (Get_OsPend)
4156:         par_oPg.AddObject("lbl_4c_LblOsPend", "Label")
4157:         WITH par_oPg.lbl_4c_LblOsPend
4158:             .Caption = "OS Pendente Dt.Entrega:"
4159:             .Top = 335
4160:             .Left = 17
4161:             .Width = 156
4162:             .Height = 17
4163:             .FontName = "Tahoma"
4164:             .FontSize = 8
4165:             .ForeColor = RGB(90,90,90)

*-- Linhas 4172 a 4211:
4172:         loc_oOpt = par_oPg.Get_OsPend
4173:         WITH loc_oOpt
4174:             .ButtonCount = 2
4175:             .Top = 335
4176:             .Left = 174
4177:             .Width = 92
4178:             .Height = 25
4179:             .BackStyle = 0
4180:             .BorderStyle = 0
4181:             .Value = 1
4182:             .Visible = .T.
4183:         ENDWITH
4184:         loc_oOpt.Buttons(1).Caption = "Sim"
4185:         loc_oOpt.Buttons(1).Left = 5
4186:         loc_oOpt.Buttons(1).Top = 3
4187:         loc_oOpt.Buttons(1).Width = 40
4188:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4189:         loc_oOpt.Buttons(1).FontSize = 8
4190:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4191:         loc_oOpt.Buttons(1).Themes = .F.
4192:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4193:         loc_oOpt.Buttons(2).Left = 48
4194:         loc_oOpt.Buttons(2).Top = 3
4195:         loc_oOpt.Buttons(2).Width = 44
4196:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4197:         loc_oOpt.Buttons(2).FontSize = 8
4198:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4199:         loc_oOpt.Buttons(2).Themes = .F.
4200: 
4201:         *-- Checa Dup Titulo (ObjDupTit)
4202:         par_oPg.AddObject("lbl_4c_LblDupTit", "Label")
4203:         WITH par_oPg.lbl_4c_LblDupTit
4204:             .Caption = "Checa Dup.T" + CHR(237) + "tulo:"
4205:             .Top = 361
4206:             .Left = 17
4207:             .Width = 156
4208:             .Height = 17
4209:             .FontName = "Tahoma"
4210:             .FontSize = 8
4211:             .ForeColor = RGB(90,90,90)

*-- Linhas 4218 a 4258:
4218:         loc_oOpt = par_oPg.ObjDupTit
4219:         WITH loc_oOpt
4220:             .ButtonCount = 2
4221:             .Top = 361
4222:             .Left = 174
4223:             .Width = 92
4224:             .Height = 25
4225:             .BackStyle = 0
4226:             .BorderStyle = 0
4227:             .Value = 1
4228:             .Visible = .T.
4229:         ENDWITH
4230:         loc_oOpt.Buttons(1).Caption = "Sim"
4231:         loc_oOpt.Buttons(1).Left = 5
4232:         loc_oOpt.Buttons(1).Top = 3
4233:         loc_oOpt.Buttons(1).Width = 40
4234:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4235:         loc_oOpt.Buttons(1).FontSize = 8
4236:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4237:         loc_oOpt.Buttons(1).Themes = .F.
4238:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4239:         loc_oOpt.Buttons(2).Left = 48
4240:         loc_oOpt.Buttons(2).Top = 3
4241:         loc_oOpt.Buttons(2).Width = 44
4242:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4243:         loc_oOpt.Buttons(2).FontSize = 8
4244:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4245:         loc_oOpt.Buttons(2).Themes = .F.
4246: 
4247:         *-- Col direita: saldo/relevante/etc (Left 469)
4248:         *-- Calcular Saldo (Opt_Saldo)
4249:         par_oPg.AddObject("lbl_4c_LblSaldo", "Label")
4250:         WITH par_oPg.lbl_4c_LblSaldo
4251:             .Caption = "Calcular Saldo:"
4252:             .Top = 29
4253:             .Left = 290
4254:             .Width = 178
4255:             .Height = 17
4256:             .FontName = "Tahoma"
4257:             .FontSize = 8
4258:             .ForeColor = RGB(90,90,90)

*-- Linhas 4265 a 4304:
4265:         loc_oOpt = par_oPg.Opt_Saldo
4266:         WITH loc_oOpt
4267:             .ButtonCount = 2
4268:             .Top = 29
4269:             .Left = 469
4270:             .Width = 149
4271:             .Height = 25
4272:             .BackStyle = 0
4273:             .BorderStyle = 0
4274:             .Value = 1
4275:             .Visible = .T.
4276:         ENDWITH
4277:         loc_oOpt.Buttons(1).Caption = "Sim"
4278:         loc_oOpt.Buttons(1).Left = 5
4279:         loc_oOpt.Buttons(1).Top = 3
4280:         loc_oOpt.Buttons(1).Width = 40
4281:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4282:         loc_oOpt.Buttons(1).FontSize = 8
4283:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4284:         loc_oOpt.Buttons(1).Themes = .F.
4285:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4286:         loc_oOpt.Buttons(2).Left = 48
4287:         loc_oOpt.Buttons(2).Top = 3
4288:         loc_oOpt.Buttons(2).Width = 44
4289:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4290:         loc_oOpt.Buttons(2).FontSize = 8
4291:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4292:         loc_oOpt.Buttons(2).Themes = .F.
4293: 
4294:         *-- Empresa Relevante (Opt_Relevante)
4295:         par_oPg.AddObject("lbl_4c_LblRelev", "Label")
4296:         WITH par_oPg.lbl_4c_LblRelev
4297:             .Caption = "Empresa Relevante:"
4298:             .Top = 53
4299:             .Left = 290
4300:             .Width = 178
4301:             .Height = 17
4302:             .FontName = "Tahoma"
4303:             .FontSize = 8
4304:             .ForeColor = RGB(90,90,90)

*-- Linhas 4311 a 4350:
4311:         loc_oOpt = par_oPg.Opt_Relevante
4312:         WITH loc_oOpt
4313:             .ButtonCount = 2
4314:             .Top = 53
4315:             .Left = 469
4316:             .Width = 149
4317:             .Height = 25
4318:             .BackStyle = 0
4319:             .BorderStyle = 0
4320:             .Value = 1
4321:             .Visible = .T.
4322:         ENDWITH
4323:         loc_oOpt.Buttons(1).Caption = "Sim"
4324:         loc_oOpt.Buttons(1).Left = 5
4325:         loc_oOpt.Buttons(1).Top = 3
4326:         loc_oOpt.Buttons(1).Width = 40
4327:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4328:         loc_oOpt.Buttons(1).FontSize = 8
4329:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4330:         loc_oOpt.Buttons(1).Themes = .F.
4331:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4332:         loc_oOpt.Buttons(2).Left = 48
4333:         loc_oOpt.Buttons(2).Top = 3
4334:         loc_oOpt.Buttons(2).Width = 44
4335:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4336:         loc_oOpt.Buttons(2).FontSize = 8
4337:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4338:         loc_oOpt.Buttons(2).Themes = .F.
4339: 
4340:         *-- Bloqueia Consulta GV (Opt_BlqConGV)
4341:         par_oPg.AddObject("lbl_4c_LblBlqConGV", "Label")
4342:         WITH par_oPg.lbl_4c_LblBlqConGV
4343:             .Caption = "Bloqueia Consulta GV:"
4344:             .Top = 77
4345:             .Left = 290
4346:             .Width = 178
4347:             .Height = 17
4348:             .FontName = "Tahoma"
4349:             .FontSize = 8
4350:             .ForeColor = RGB(90,90,90)

*-- Linhas 4357 a 4396:
4357:         loc_oOpt = par_oPg.Opt_BlqConGV
4358:         WITH loc_oOpt
4359:             .ButtonCount = 2
4360:             .Top = 77
4361:             .Left = 469
4362:             .Width = 149
4363:             .Height = 25
4364:             .BackStyle = 0
4365:             .BorderStyle = 0
4366:             .Value = 1
4367:             .Visible = .T.
4368:         ENDWITH
4369:         loc_oOpt.Buttons(1).Caption = "Sim"
4370:         loc_oOpt.Buttons(1).Left = 5
4371:         loc_oOpt.Buttons(1).Top = 3
4372:         loc_oOpt.Buttons(1).Width = 40
4373:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4374:         loc_oOpt.Buttons(1).FontSize = 8
4375:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4376:         loc_oOpt.Buttons(1).Themes = .F.
4377:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4378:         loc_oOpt.Buttons(2).Left = 48
4379:         loc_oOpt.Buttons(2).Top = 3
4380:         loc_oOpt.Buttons(2).Width = 44
4381:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4382:         loc_oOpt.Buttons(2).FontSize = 8
4383:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4384:         loc_oOpt.Buttons(2).Themes = .F.
4385: 
4386:         *-- Patrimonialpor Etiq (Opt_Patrim)
4387:         par_oPg.AddObject("lbl_4c_LblPatrim", "Label")
4388:         WITH par_oPg.lbl_4c_LblPatrim
4389:             .Caption = "Patrimonial/Etiqueta:"
4390:             .Top = 101
4391:             .Left = 290
4392:             .Width = 178
4393:             .Height = 17
4394:             .FontName = "Tahoma"
4395:             .FontSize = 8
4396:             .ForeColor = RGB(90,90,90)

*-- Linhas 4403 a 4442:
4403:         loc_oOpt = par_oPg.Opt_Patrim
4404:         WITH loc_oOpt
4405:             .ButtonCount = 2
4406:             .Top = 101
4407:             .Left = 469
4408:             .Width = 149
4409:             .Height = 25
4410:             .BackStyle = 0
4411:             .BorderStyle = 0
4412:             .Value = 1
4413:             .Visible = .T.
4414:         ENDWITH
4415:         loc_oOpt.Buttons(1).Caption = "Sim"
4416:         loc_oOpt.Buttons(1).Left = 5
4417:         loc_oOpt.Buttons(1).Top = 3
4418:         loc_oOpt.Buttons(1).Width = 40
4419:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4420:         loc_oOpt.Buttons(1).FontSize = 8
4421:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4422:         loc_oOpt.Buttons(1).Themes = .F.
4423:         loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
4424:         loc_oOpt.Buttons(2).Left = 48
4425:         loc_oOpt.Buttons(2).Top = 3
4426:         loc_oOpt.Buttons(2).Width = 44
4427:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4428:         loc_oOpt.Buttons(2).FontSize = 8
4429:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4430:         loc_oOpt.Buttons(2).Themes = .F.
4431: 
4432:         *-- Tipo Inventario (OpTipoInvs, 3 btn)
4433:         par_oPg.AddObject("lbl_4c_LblTipoInv", "Label")
4434:         WITH par_oPg.lbl_4c_LblTipoInv
4435:             .Caption = "Tipo Invent" + CHR(225) + "rio:"
4436:             .Top = 125
4437:             .Left = 290
4438:             .Width = 178
4439:             .Height = 17
4440:             .FontName = "Tahoma"
4441:             .FontSize = 8
4442:             .ForeColor = RGB(90,90,90)

*-- Linhas 4449 a 4496:
4449:         loc_oOpt = par_oPg.OpTipoInvs
4450:         WITH loc_oOpt
4451:             .ButtonCount = 3
4452:             .Top = 125
4453:             .Left = 470
4454:             .Width = 371
4455:             .Height = 25
4456:             .BackStyle = 0
4457:             .BorderStyle = 0
4458:             .Value = 1
4459:             .Visible = .T.
4460:         ENDWITH
4461:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4462:         loc_oOpt.Buttons(1).Left = 5
4463:         loc_oOpt.Buttons(1).Top = 3
4464:         loc_oOpt.Buttons(1).Width = 44
4465:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4466:         loc_oOpt.Buttons(1).FontSize = 8
4467:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4468:         loc_oOpt.Buttons(1).Themes = .F.
4469:         loc_oOpt.Buttons(2).Caption = "Inventario"
4470:         loc_oOpt.Buttons(2).Left = 54
4471:         loc_oOpt.Buttons(2).Top = 3
4472:         loc_oOpt.Buttons(2).Width = 80
4473:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4474:         loc_oOpt.Buttons(2).FontSize = 8
4475:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4476:         loc_oOpt.Buttons(2).Themes = .F.
4477:         loc_oOpt.Buttons(3).Caption = "Coletor"
4478:         loc_oOpt.Buttons(3).Left = 139
4479:         loc_oOpt.Buttons(3).Top = 3
4480:         loc_oOpt.Buttons(3).Width = 60
4481:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4482:         loc_oOpt.Buttons(3).FontSize = 8
4483:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4484:         loc_oOpt.Buttons(3).Themes = .F.
4485: 
4486:         *-- Diferenca de Peso
4487:         par_oPg.AddObject("lbl_4c_LblDifPeso", "Label")
4488:         WITH par_oPg.lbl_4c_LblDifPeso
4489:             .Caption = "Diferen" + CHR(231) + "a Peso:"
4490:             .Top = 191
4491:             .Left = 350
4492:             .Width = 123
4493:             .Height = 17
4494:             .FontName = "Tahoma"
4495:             .FontSize = 8
4496:             .ForeColor = RGB(90,90,90)

*-- Linhas 4502 a 4528:
4502:         par_oPg.AddObject("Get_DifPeso", "TextBox")
4503:         WITH par_oPg.Get_DifPeso
4504:             .Value = 0
4505:             .Top = 191
4506:             .Left = 480
4507:             .Width = 68
4508:             .Height = 24
4509:             .FontName = "Tahoma"
4510:             .FontSize = 8
4511:             .ForeColor = RGB(90,90,90)
4512:             .BackColor = RGB(255,255,255)
4513:             .Themes = .F.
4514:             .SpecialEffect = 0
4515:             .Visible = .T.
4516:         ENDWITH
4517: 
4518:         *-- Sinal +/-
4519:         par_oPg.AddObject("lbl_4c_LblSinal", "Label")
4520:         WITH par_oPg.lbl_4c_LblSinal
4521:             .Caption = "Sinal:"
4522:             .Top = 191
4523:             .Left = 550
4524:             .Width = 35
4525:             .Height = 17
4526:             .FontName = "Tahoma"
4527:             .FontSize = 8
4528:             .ForeColor = RGB(90,90,90)

*-- Linhas 4534 a 4543:
4534:         par_oPg.AddObject("Get_Sinal", "ComboBox")
4535:         WITH par_oPg.Get_Sinal
4536:             .Value = 1
4537:             .Top = 191
4538:             .Left = 552
4539:             .Width = 48
4540:             .Height = 24
4541:             .RowSourceType = 1
4542:             .RowSource = "+,-"
4543:             .Style = 2

*-- Linhas 4549 a 4561:
4549:         ENDWITH
4550: 
4551:         *-- Tipo Falhas (Get_tfalhas - P ou Q)
4552:         par_oPg.AddObject("lbl_4c_LblPq", "Label")
4553:         WITH par_oPg.lbl_4c_LblPq
4554:             .Caption = "Tipo:"
4555:             .Top = 191
4556:             .Left = 602
4557:             .Width = 30
4558:             .Height = 17
4559:             .FontName = "Tahoma"
4560:             .FontSize = 8
4561:             .ForeColor = RGB(90,90,90)

*-- Linhas 4567 a 4576:
4567:         par_oPg.AddObject("Get_tfalhas", "TextBox")
4568:         WITH par_oPg.Get_tfalhas
4569:             .Value = ""
4570:             .Top = 191
4571:             .Left = 601
4572:             .Width = 17
4573:             .Height = 24
4574:             .MaxLength = 1
4575:             .FontName = "Tahoma"
4576:             .FontSize = 8

*-- Linhas 4582 a 4610:
4582:         ENDWITH
4583: 
4584:         *-- Grupo Nao Selecionavel (op_invisivel)
4585:         par_oPg.AddObject("op_invisivel", "CheckBox")
4586:         WITH par_oPg.op_invisivel
4587:             .Caption = "Grupo N" + CHR(227) + "o Selecion" + CHR(225) + "vel"
4588:             .Top = 81
4589:             .Left = 724
4590:             .Width = 137
4591:             .Height = 15
4592:             .Value = 0
4593:             .FontName = "Tahoma"
4594:             .FontSize = 8
4595:             .ForeColor = RGB(90,90,90)
4596:             .BackStyle = 0
4597:             .Visible = .T.
4598:         ENDWITH
4599: 
4600:         *-- Dias bloqueio retroativo
4601:         par_oPg.AddObject("lbl_4c_LblDdr", "Label")
4602:         WITH par_oPg.lbl_4c_LblDdr
4603:             .Caption = "Dias Bloq.Ret.:"
4604:             .Top = 30
4605:             .Left = 670
4606:             .Width = 105
4607:             .Height = 17
4608:             .FontName = "Tahoma"
4609:             .FontSize = 8
4610:             .ForeColor = RGB(90,90,90)

*-- Linhas 4616 a 4642:
4616:         par_oPg.AddObject("get_ddr", "TextBox")
4617:         WITH par_oPg.get_ddr
4618:             .Value = 0
4619:             .Top = 30
4620:             .Left = 852
4621:             .Width = 45
4622:             .Height = 23
4623:             .FontName = "Tahoma"
4624:             .FontSize = 8
4625:             .ForeColor = RGB(90,90,90)
4626:             .BackColor = RGB(255,255,255)
4627:             .Themes = .F.
4628:             .SpecialEffect = 0
4629:             .Visible = .T.
4630:         ENDWITH
4631: 
4632:         *-- Dias bloqueio futuro
4633:         par_oPg.AddObject("lbl_4c_LblDdf", "Label")
4634:         WITH par_oPg.lbl_4c_LblDdf
4635:             .Caption = "Dias Bloq.Fut.:"
4636:             .Top = 54
4637:             .Left = 670
4638:             .Width = 105
4639:             .Height = 17
4640:             .FontName = "Tahoma"
4641:             .FontSize = 8
4642:             .ForeColor = RGB(90,90,90)

*-- Linhas 4648 a 4674:
4648:         par_oPg.AddObject("get_ddf", "TextBox")
4649:         WITH par_oPg.get_ddf
4650:             .Value = 0
4651:             .Top = 54
4652:             .Left = 852
4653:             .Width = 45
4654:             .Height = 23
4655:             .FontName = "Tahoma"
4656:             .FontSize = 8
4657:             .ForeColor = RGB(90,90,90)
4658:             .BackColor = RGB(255,255,255)
4659:             .Themes = .F.
4660:             .SpecialEffect = 0
4661:             .Visible = .T.
4662:         ENDWITH
4663: 
4664:         *-- Transfere Peso (Chk_TrfPeso, 5 btn)
4665:         par_oPg.AddObject("lbl_4c_LblTrfPeso", "Label")
4666:         WITH par_oPg.lbl_4c_LblTrfPeso
4667:             .Caption = "Transfere Peso:"
4668:             .Top = 216
4669:             .Left = 350
4670:             .Width = 123
4671:             .Height = 17
4672:             .FontName = "Tahoma"
4673:             .FontSize = 8
4674:             .ForeColor = RGB(90,90,90)

*-- Linhas 4681 a 4744:
4681:         loc_oOpt = par_oPg.Chk_TrfPeso
4682:         WITH loc_oOpt
4683:             .ButtonCount = 5
4684:             .Top = 216
4685:             .Left = 474
4686:             .Width = 186
4687:             .Height = 95
4688:             .BackStyle = 0
4689:             .BorderStyle = 0
4690:             .Value = 1
4691:             .Visible = .T.
4692:         ENDWITH
4693:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4694:         loc_oOpt.Buttons(1).Left = 5
4695:         loc_oOpt.Buttons(1).Top = 3
4696:         loc_oOpt.Buttons(1).Width = 80
4697:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4698:         loc_oOpt.Buttons(1).FontSize = 8
4699:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4700:         loc_oOpt.Buttons(1).Themes = .F.
4701:         loc_oOpt.Buttons(2).Caption = "Por Kg"
4702:         loc_oOpt.Buttons(2).Left = 5
4703:         loc_oOpt.Buttons(2).Top = 20
4704:         loc_oOpt.Buttons(2).Width = 80
4705:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4706:         loc_oOpt.Buttons(2).FontSize = 8
4707:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4708:         loc_oOpt.Buttons(2).Themes = .F.
4709:         loc_oOpt.Buttons(3).Caption = "Por Un"
4710:         loc_oOpt.Buttons(3).Left = 5
4711:         loc_oOpt.Buttons(3).Top = 38
4712:         loc_oOpt.Buttons(3).Width = 80
4713:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4714:         loc_oOpt.Buttons(3).FontSize = 8
4715:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4716:         loc_oOpt.Buttons(3).Themes = .F.
4717:         loc_oOpt.Buttons(4).Caption = "Por Kg (%)"
4718:         loc_oOpt.Buttons(4).Left = 5
4719:         loc_oOpt.Buttons(4).Top = 56
4720:         loc_oOpt.Buttons(4).Width = 80
4721:         loc_oOpt.Buttons(4).FontName = "Tahoma"
4722:         loc_oOpt.Buttons(4).FontSize = 8
4723:         loc_oOpt.Buttons(4).ForeColor = RGB(90,90,90)
4724:         loc_oOpt.Buttons(4).Themes = .F.
4725:         loc_oOpt.Buttons(5).Caption = "Por Un (%)"
4726:         loc_oOpt.Buttons(5).Left = 5
4727:         loc_oOpt.Buttons(5).Top = 74
4728:         loc_oOpt.Buttons(5).Width = 80
4729:         loc_oOpt.Buttons(5).FontName = "Tahoma"
4730:         loc_oOpt.Buttons(5).FontSize = 8
4731:         loc_oOpt.Buttons(5).ForeColor = RGB(90,90,90)
4732:         loc_oOpt.Buttons(5).Themes = .F.
4733: 
4734:         *-- Agrupa Componentes (op_compagru, 3 btn)
4735:         par_oPg.AddObject("lbl_4c_LblCompagru", "Label")
4736:         WITH par_oPg.lbl_4c_LblCompagru
4737:             .Caption = "Agrupa Comp.:"
4738:             .Top = 337
4739:             .Left = 350
4740:             .Width = 123
4741:             .Height = 17
4742:             .FontName = "Tahoma"
4743:             .FontSize = 8
4744:             .ForeColor = RGB(90,90,90)

*-- Linhas 4751 a 4798:
4751:         loc_oOpt = par_oPg.op_compagru
4752:         WITH loc_oOpt
4753:             .ButtonCount = 3
4754:             .Top = 337
4755:             .Left = 474
4756:             .Width = 186
4757:             .Height = 21
4758:             .BackStyle = 0
4759:             .BorderStyle = 0
4760:             .Value = 1
4761:             .Visible = .T.
4762:         ENDWITH
4763:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4764:         loc_oOpt.Buttons(1).Left = 5
4765:         loc_oOpt.Buttons(1).Top = 3
4766:         loc_oOpt.Buttons(1).Width = 44
4767:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4768:         loc_oOpt.Buttons(1).FontSize = 8
4769:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4770:         loc_oOpt.Buttons(1).Themes = .F.
4771:         loc_oOpt.Buttons(2).Caption = "Tipo"
4772:         loc_oOpt.Buttons(2).Left = 54
4773:         loc_oOpt.Buttons(2).Top = 3
4774:         loc_oOpt.Buttons(2).Width = 50
4775:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4776:         loc_oOpt.Buttons(2).FontSize = 8
4777:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4778:         loc_oOpt.Buttons(2).Themes = .F.
4779:         loc_oOpt.Buttons(3).Caption = "Produto"
4780:         loc_oOpt.Buttons(3).Left = 109
4781:         loc_oOpt.Buttons(3).Top = 3
4782:         loc_oOpt.Buttons(3).Width = 60
4783:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4784:         loc_oOpt.Buttons(3).FontSize = 8
4785:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4786:         loc_oOpt.Buttons(3).Themes = .F.
4787: 
4788:         *-- Agrupamento
4789:         par_oPg.AddObject("lbl_4c_LblAgrupa", "Label")
4790:         WITH par_oPg.lbl_4c_LblAgrupa
4791:             .Caption = "Agrupamento:"
4792:             .Top = 362
4793:             .Left = 350
4794:             .Width = 123
4795:             .Height = 17
4796:             .FontName = "Tahoma"
4797:             .FontSize = 8
4798:             .ForeColor = RGB(90,90,90)

*-- Linhas 4804 a 4813:
4804:         par_oPg.AddObject("Get_Agrupa", "TextBox")
4805:         WITH par_oPg.Get_Agrupa
4806:             .Value = ""
4807:             .Top = 362
4808:             .Left = 480
4809:             .Width = 150
4810:             .Height = 23
4811:             .MaxLength = 10
4812:             .FontName = "Tahoma"
4813:             .FontSize = 8

*-- Linhas 4819 a 4831:
4819:         ENDWITH
4820: 
4821:         *-- Controle de Lote (Fwoption1, 3 btn)
4822:         par_oPg.AddObject("lbl_4c_LblCtrlote", "Label")
4823:         WITH par_oPg.lbl_4c_LblCtrlote
4824:             .Caption = "Controle de Lote:"
4825:             .Top = 390
4826:             .Left = 350
4827:             .Width = 123
4828:             .Height = 17
4829:             .FontName = "Tahoma"
4830:             .FontSize = 8
4831:             .ForeColor = RGB(90,90,90)

*-- Linhas 4838 a 4927:
4838:         loc_oOpt = par_oPg.Fwoption1
4839:         WITH loc_oOpt
4840:             .ButtonCount = 3
4841:             .Top = 390
4842:             .Left = 474
4843:             .Width = 164
4844:             .Height = 21
4845:             .BackStyle = 0
4846:             .BorderStyle = 0
4847:             .Value = 1
4848:             .Visible = .T.
4849:         ENDWITH
4850:         loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
4851:         loc_oOpt.Buttons(1).Left = 5
4852:         loc_oOpt.Buttons(1).Top = 3
4853:         loc_oOpt.Buttons(1).Width = 44
4854:         loc_oOpt.Buttons(1).FontName = "Tahoma"
4855:         loc_oOpt.Buttons(1).FontSize = 8
4856:         loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
4857:         loc_oOpt.Buttons(1).Themes = .F.
4858:         loc_oOpt.Buttons(2).Caption = "Simples"
4859:         loc_oOpt.Buttons(2).Left = 54
4860:         loc_oOpt.Buttons(2).Top = 3
4861:         loc_oOpt.Buttons(2).Width = 60
4862:         loc_oOpt.Buttons(2).FontName = "Tahoma"
4863:         loc_oOpt.Buttons(2).FontSize = 8
4864:         loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
4865:         loc_oOpt.Buttons(2).Themes = .F.
4866:         loc_oOpt.Buttons(3).Caption = "Completo"
4867:         loc_oOpt.Buttons(3).Left = 119
4868:         loc_oOpt.Buttons(3).Top = 3
4869:         loc_oOpt.Buttons(3).Width = 65
4870:         loc_oOpt.Buttons(3).FontName = "Tahoma"
4871:         loc_oOpt.Buttons(3).FontSize = 8
4872:         loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
4873:         loc_oOpt.Buttons(3).Themes = .F.
4874: 
4875:         *-- Os/Alianca/Fundicao checkboxes (Container1)
4876:         par_oPg.AddObject("cnt_4c_OsAlfun", "Container")
4877:         WITH par_oPg.cnt_4c_OsAlfun
4878:             .Top = 308
4879:             .Left = 354
4880:             .Width = 347
4881:             .Height = 27
4882:             .BackStyle = 1
4883:             .BackColor = RGB(245,245,245)
4884:             .BorderWidth = 0
4885:             .Visible = .T.
4886:         ENDWITH
4887: 
4888:         par_oPg.cnt_4c_OsAlfun.AddObject("chk_Os", "CheckBox")
4889:         WITH par_oPg.cnt_4c_OsAlfun.chk_Os
4890:             .Caption = "OS"
4891:             .Top = 5
4892:             .Left = 10
4893:             .Width = 45
4894:             .Height = 15
4895:             .Value = 0
4896:             .FontName = "Tahoma"
4897:             .FontSize = 8
4898:             .ForeColor = RGB(90,90,90)
4899:             .BackStyle = 0
4900:             .Visible = .T.
4901:         ENDWITH
4902: 
4903:         par_oPg.cnt_4c_OsAlfun.AddObject("chk_Alianca", "CheckBox")
4904:         WITH par_oPg.cnt_4c_OsAlfun.chk_Alianca
4905:             .Caption = "Alian" + CHR(231) + "a"
4906:             .Top = 5
4907:             .Left = 65
4908:             .Width = 65
4909:             .Height = 15
4910:             .Value = 0
4911:             .FontName = "Tahoma"
4912:             .FontSize = 8
4913:             .ForeColor = RGB(90,90,90)
4914:             .BackStyle = 0
4915:             .Visible = .T.
4916:         ENDWITH
4917: 
4918:         par_oPg.cnt_4c_OsAlfun.AddObject("chk_Fundicao", "CheckBox")
4919:         WITH par_oPg.cnt_4c_OsAlfun.chk_Fundicao
4920:             .Caption = "Fundi" + CHR(231) + CHR(227) + "o"
4921:             .Top = 5
4922:             .Left = 140
4923:             .Width = 70
4924:             .Height = 15
4925:             .Value = 0
4926:             .FontName = "Tahoma"
4927:             .FontSize = 8

*-- Linhas 4942 a 5061:
4942:         *-- Shapes de fundo (borda e separadores de coluna)
4943:         par_oPg.AddObject("shp_4c_Border", "Shape")
4944:         WITH par_oPg.shp_4c_Border
4945:             .Top           = 50
4946:             .Left          = 45
4947:             .Width         = 673
4948:             .Height        = 261
4949:             .BackStyle     = 0
4950:             .SpecialEffect = 1
4951:             .BorderColor   = RGB(90, 90, 90)
4952:             .Visible       = .T.
4953:         ENDWITH
4954: 
4955:         par_oPg.AddObject("shp_4c_ColGrupo", "Shape")
4956:         WITH par_oPg.shp_4c_ColGrupo
4957:             .Top           = 50
4958:             .Left          = 106
4959:             .Width         = 90
4960:             .Height        = 261
4961:             .BackStyle     = 0
4962:             .SpecialEffect = 1
4963:             .BorderColor   = RGB(90, 90, 90)
4964:             .Visible       = .T.
4965:         ENDWITH
4966: 
4967:         par_oPg.AddObject("shp_4c_HdrLine", "Shape")
4968:         WITH par_oPg.shp_4c_HdrLine
4969:             .Top           = 71
4970:             .Left          = 45
4971:             .Width         = 671
4972:             .Height        = 1
4973:             .BackStyle     = 0
4974:             .SpecialEffect = 1
4975:             .BorderColor   = RGB(90, 90, 90)
4976:             .Visible       = .T.
4977:         ENDWITH
4978: 
4979:         par_oPg.AddObject("shp_4c_ColAliq", "Shape")
4980:         WITH par_oPg.shp_4c_ColAliq
4981:             .Top           = 50
4982:             .Left          = 576
4983:             .Width         = 52
4984:             .Height        = 261
4985:             .BackStyle     = 0
4986:             .SpecialEffect = 1
4987:             .BorderColor   = RGB(90, 90, 90)
4988:             .Visible       = .T.
4989:         ENDWITH
4990: 
4991:         *-- Headers
4992:         par_oPg.AddObject("lbl_4c_HdrImpostos", "Label")
4993:         WITH par_oPg.lbl_4c_HdrImpostos
4994:             .Caption = "Impostos"
4995:             .Top = 53
4996:             .Left = 53
4997:             .Width = 60
4998:             .Height = 17
4999:             .FontName = "Tahoma"
5000:             .FontSize = 8
5001:             .FontBold = .T.
5002:             .ForeColor = RGB(90,90,90)
5003:             .BackStyle = 0
5004:             .Visible = .T.
5005:         ENDWITH
5006: 
5007:         par_oPg.AddObject("lbl_4c_HdrGrupo", "Label")
5008:         WITH par_oPg.lbl_4c_HdrGrupo
5009:             .Caption = "Grupo"
5010:             .Top = 53
5011:             .Left = 131
5012:             .Width = 60
5013:             .Height = 17
5014:             .FontName = "Tahoma"
5015:             .FontSize = 8
5016:             .FontBold = .T.
5017:             .ForeColor = RGB(90,90,90)
5018:             .BackStyle = 0
5019:             .Visible = .T.
5020:         ENDWITH
5021: 
5022:         par_oPg.AddObject("lbl_4c_HdrConta", "Label")
5023:         WITH par_oPg.lbl_4c_HdrConta
5024:             .Caption = "Conta e Descri" + CHR(231) + CHR(227) + "o"
5025:             .Top = 53
5026:             .Left = 328
5027:             .Width = 150
5028:             .Height = 17
5029:             .FontName = "Tahoma"
5030:             .FontSize = 8
5031:             .FontBold = .T.
5032:             .ForeColor = RGB(90,90,90)
5033:             .BackStyle = 0
5034:             .Visible = .T.
5035:         ENDWITH
5036: 
5037:         par_oPg.AddObject("lbl_4c_HdrAliq", "Label")
5038:         WITH par_oPg.lbl_4c_HdrAliq
5039:             .Caption = "Al" + CHR(237) + "quota"
5040:             .Top = 53
5041:             .Left = 579
5042:             .Width = 60
5043:             .Height = 17
5044:             .FontName = "Tahoma"
5045:             .FontSize = 8
5046:             .FontBold = .T.
5047:             .ForeColor = RGB(90,90,90)
5048:             .BackStyle = 0
5049:             .Visible = .T.
5050:         ENDWITH
5051: 
5052:         par_oPg.AddObject("lbl_4c_HdrReceita", "Label")
5053:         WITH par_oPg.lbl_4c_HdrReceita
5054:             .Caption = "Receita"
5055:             .Top = 53
5056:             .Left = 650
5057:             .Width = 60
5058:             .Height = 17
5059:             .FontName = "Tahoma"
5060:             .FontSize = 8
5061:             .FontBold = .T.

*-- Linhas 5122 a 5144:
5122:             par_oPg.AddObject(loc_cProp, "Container")
5123:             loc_oCnt = par_oPg.Controls(par_oPg.ControlCount)
5124:             WITH loc_oCnt
5125:                 .Top = loc_nTop
5126:                 .Left = 45
5127:                 .Width = 673
5128:                 .Height = 25
5129:                 .BackStyle = 1
5130:                 .BackColor = RGB(240,240,240)
5131:                 .BorderWidth = 0
5132:                 .Visible = .T.
5133:             ENDWITH
5134: 
5135:             loc_oCnt.AddObject("lbl_4c_Tax", "Label")
5136:             WITH loc_oCnt.lbl_4c_Tax
5137:                 .Caption = loc_cNome
5138:                 .Top = 5
5139:                 .Left = loc_nLblLeft
5140:                 .Width = 55
5141:                 .Height = 17
5142:                 .FontName = "Tahoma"
5143:                 .FontSize = 8
5144:                 .FontBold = .T.

*-- Linhas 5150 a 5159:
5150:             loc_oCnt.AddObject("getCdGrupos", "TextBox")
5151:             WITH loc_oCnt.getCdGrupos
5152:                 .Value = ""
5153:                 .Top = 2
5154:                 .Left = 66
5155:                 .Width = 80
5156:                 .Height = 21
5157:                 .MaxLength = 10
5158:                 .FontName = "Tahoma"
5159:                 .FontSize = 8

*-- Linhas 5167 a 5176:
5167:             loc_oCnt.AddObject("getCdContas", "TextBox")
5168:             WITH loc_oCnt.getCdContas
5169:                 .Value = ""
5170:                 .Top = 2
5171:                 .Left = 155
5172:                 .Width = 80
5173:                 .Height = 21
5174:                 .MaxLength = 10
5175:                 .FontName = "Tahoma"
5176:                 .FontSize = 8

*-- Linhas 5184 a 5193:
5184:             loc_oCnt.AddObject("getDsContas", "TextBox")
5185:             WITH loc_oCnt.getDsContas
5186:                 .Value = ""
5187:                 .Top = 2
5188:                 .Left = 237
5189:                 .Width = 290
5190:                 .Height = 21
5191:                 .FontName = "Tahoma"
5192:                 .FontSize = 8
5193:                 .ForeColor = RGB(90,90,90)

*-- Linhas 5201 a 5210:
5201:             loc_oCnt.AddObject("getPctAliqs", "TextBox")
5202:             WITH loc_oCnt.getPctAliqs
5203:                 .Value = 0
5204:                 .Top = 2
5205:                 .Left = 536
5206:                 .Width = 42
5207:                 .Height = 21
5208:                 .InputMask = "99.99"
5209:                 .Alignment = 3
5210:                 .FontName = "Tahoma"

*-- Linhas 5219 a 5228:
5219:             loc_oCnt.AddObject("getReceitas", "TextBox")
5220:             WITH loc_oCnt.getReceitas
5221:                 .Value = ""
5222:                 .Top = 2
5223:                 .Left = 588
5224:                 .Width = 80
5225:                 .Height = 21
5226:                 .MaxLength = 10
5227:                 .FontName = "Tahoma"
5228:                 .FontSize = 8

*-- Linhas 5290 a 5299:
5290:         loc_oGrid.Column1.Width = 120
5291:         loc_oGrid.Column2.Width = 400
5292: 
5293:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
5294:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5295:     ENDPROC
5296: 
5297:     *--------------------------------------------------------------------------
5298:     * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
5299:     *--------------------------------------------------------------------------

*-- Linhas 5330 a 5339:
5330:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
5331: 
5332:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
5333:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
5334:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
5335:             ENDIF
5336:         ENDIF
5337:     ENDPROC
5338: 
5339:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\ccrBO.prg):
*==============================================================================
* ccrBO.prg - Business Object para Grupos de Contas Correntes (SigCdGcr)
* Herda de BusinessBase
* Tabela: SigCdGcr  |  PK: codigos
*==============================================================================

DEFINE CLASS ccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * IDENTIFICACAO - PK e Descricao
    *--------------------------------------------------------------------------
    this_cCodigos         = ""   && codigos char(10) PK
    this_cDescrs          = ""   && descrs char(40)
    this_cDgcods          = ""   && dgcods char(1) - digito
    this_cInternos        = ""   && internos char(20) - codigo interno
    this_cClasses         = ""   && classes char(10) - FK SigCdCss
    this_cDClasses        = ""   && DClasses virtual (JOIN SigCdCss.Descrs)

    *--------------------------------------------------------------------------
    * TIPO/MODO
    *--------------------------------------------------------------------------
    this_nTpcods          = 0    && tpcods numeric(1,0) - tipo codificacao
    this_nTpemps          = 0    && tpemps numeric(1,0) - tipo empresa
    this_nTpcads          = 0    && tpcads numeric(1,0) - tipo cadastro

    *--------------------------------------------------------------------------
    * ABA GERAL - Opcoes de obrigatoriedade cadastral
    *--------------------------------------------------------------------------
    this_nComplems        = 0    && complems numeric(1,0) - Complemento
    this_nPessoais        = 0    && pessoais numeric(1,0) - Dados Pessoais
    this_nRefbancs        = 0    && refbancs numeric(1,0) - Ref. Bancarias
    this_nFollowups       = 0    && followups numeric(1,0) - Follow-Up
    this_nFiscais         = 0    && fiscais numeric(1,0) - Dados Fiscais
    this_nContabs         = 0    && contabs numeric(1,0) - Dados Contabeis
    this_nEmpresas        = 0    && empresas numeric(1,0) - Dados da Empresa
    this_nCaracteris      = 0    && caracteris numeric(1,0) - Caracteristicas
    this_nRespos          = 0    && respos numeric(1,0) - Possui Responsavel
    this_nLimcres         = 0    && limcres numeric(1,0) - Limite de Credito
    this_nComis           = 0    && comis numeric(1,0) - Comissao
    this_nDadcoms         = 0    && dadcoms numeric(1,0) - Dados Comerciais
    this_nCargos          = 0    && cargos numeric(1,0) - Cargos
    this_nChklimcrds      = 0    && chklimcrds numeric(1,0) - Checa Limite Credito
    this_nColetors        = 0    && coletors numeric(2,0) - Coletor (11 opcoes)
    this_nPrecad          = 0    && precad numeric(1,0) - Pre-Cadastro (LEAD)

    *--------------------------------------------------------------------------
    * ABA GERAL - Grupo padrao contabil / Limite de credito / Moeda
    *--------------------------------------------------------------------------
    this_cGrupolms        = ""   && grupolms char(10) - Grupo Padrao Contabil
    this_nVrlimcre        = 0    && vrlimcre numeric(11,2) - Valor Limite Credito
    this_cMolimcre        = ""   && molimcre char(3) - Moeda Limite Credito
    this_cCommoedas       = ""   && commoedas char(3) - Moeda Comissao
    this_cRodrelcc        = ""   && rodrelcc text - Rodape Relatorio Conta Corrente

    *--------------------------------------------------------------------------
    * ABA CADASTRO - Obrigatoriedades de preenchimento
    *--------------------------------------------------------------------------
    this_cCfgcdgcr        = ""   && cfgcdgcr char(40) - Config flags empacotados

    *-- Posicoes do CfgCdGcr (armazenados em cfgcdgcr):
    *-- Pos 1: ObrMails, Pos 2: ObrNome, Pos 3: VincPgRcs, Pos 4: ObrSit
    *-- Pos 5: Cpffixo, Pos 6: Carac, Pos 7: AceJob

    this_cDescsit         = ""   && descsit char(16) - Situacao Padrao
    this_nCpfobrigs       = 0    && cpfobrigs numeric(1,0) - CPF/CNPJ Obrigatorio
    this_nRgobrigs        = 0    && rgobrigs numeric(1,0) - RG/IE Obrigatorio
    this_nMfotos          = 0    && mfotos numeric(1,0) - Mostrar Foto
    this_nObservas        = 0    && observas numeric(1,0) - Observacao
    this_nInfcads         = 0    && infcads numeric(1,0) - Info Cadastrais
    this_nCalcimeds       = 0    && calcimeds numeric(1,0) - Calc. Imediato
    this_cDesccalcimeds   = ""   && desccalcimeds char(16) - Desc Calc Imediato
    this_nFpublsobr       = 0    && fpublsobr numeric(1,0) - Func.Publico Obrig.
    this_cDescfpubls      = ""   && descfpubls char(16) - Desc Func.Publico
    this_nInfsenha        = 0    && infsenha numeric(1,0) - Info Senha
    this_nLogalt          = 0    && logalt numeric(1,0) - Log Alteracao

    *-- Endereco
    this_nEndobr          = 0    && endobr numeric(1,0) - Endereco Obrigatorio
    this_nNumobr          = 0    && numobr numeric(1,0) - Numero Obrigatorio
    this_nBairroobr       = 0    && bairroobr numeric(1,0) - Bairro Obrigatorio
    this_nCidasobr        = 0    && cidasobr numeric(1,0) - Cidade Obrigatoria
    this_nCepobris        = 0    && cepobris numeric(1,0) - CEP Obrigatorio
    this_nPaisesobr       = 0    && paisesobr numeric(1,0) - Pais Obrigatorio
    this_nChkendds        = 0    && chkendds numeric(1,0) - Checa Duplic. Endereco
    this_nChkendrs        = 0    && chkendrs numeric(1,0) - Checa Restric. Endereco

    *-- Telefone e outros dados pessoais
    this_nTel1obr         = 0    && tel1obr numeric(1,0) - Telefone 1 Obrigatorio
    this_nTel2obr         = 0    && tel2obr numeric(1,0) - Telefone 2 Obrigatorio
    this_nNascobr         = 0    && nascobr numeric(1,0) - Nascimento Obrigatorio
    this_nSexobr          = 0    && sexobr numeric(1,0) - Sexo Obrigatorio
    this_nDtnascobr       = 0    && dtnascobr numeric(1,0) - Data Nasc. Obrigatoria
    this_nDtespobr        = 0    && dtespobr numeric(1,0) - Data Espera Obrigatoria
    this_nObrtelefone     = 0    && Obrtelefone numeric(1,0) - Telefone Obrigatorio
    this_cDesctlm         = ""   && desctlm char(16) - Desc Telemarketing
    this_cDesccla         = ""   && desccla char(16) - Desc Classificacao
    this_cDescseg         = ""   && descseg char(16) - Desc Segmento

    *-- Financeiro no Cadastro
    this_cContconts       = ""   && contconts char(9) - Conta Interna
    this_nIntconts        = 0    && intconts numeric(1,0) - Integracao Contabil
    this_nPadpgrecs       = 0    && padpgrecs numeric(1,0) - Padrao Preenchimento
    this_nCtvinculas      = 0    && ctvinculas numeric(1,0) - Vincula Contas PG/RC
    this_nTitbaixado      = 0    && titbaixado numeric(1,0) - Visualiza Tit.nao Baixados
    this_cContapdr        = ""   && contapdr char(10) - Conta Padrao
    this_nCcustotit       = 0    && ccustotit numeric(1,0) - C.Custo por Titulo

    *-- Alerta Cadastro
    this_nDefhideshow     = 0    && defhideshow numeric(1,0) - Emitir Mensagem Alerta
    this_nCtainatv        = 0    && ctainatv numeric(1,0) - Conta Inativa

    *--------------------------------------------------------------------------
    * ABA ESTOQUE
    *--------------------------------------------------------------------------
    this_nEstoques        = 0    && estoques numeric(1,0) - Avalia Estoque
    this_nLimestoqs       = 0    && limestoqs numeric(1,0) - Limite de Estoque
    this_nVerests         = 0    && verests numeric(1,0) - Verifica Estoque
    this_nEmprelevs       = 0    && emprelevs numeric(1,0) - Empresa Relevante
    this_nBlqcongvs       = 0    && blqcongvs numeric(1,0) - Bloqueia Consulta GV
    this_nCalcsalds       = 0    && calcsalds numeric(1,0) - Calculo de Saldo
    this_nChklimests      = 0    && chklimests numeric(1,0) - Checa Limite Estoque
    this_nPatrietqs       = 0    && patrietqs numeric(1,0) - Patrimonial por Etiqueta
    this_nCcustos         = 0    && ccustos numeric(1,0) - Centro de Custos
    this_nGerbals         = 0    && gerbals numeric(1,0) - Gerar Balanco
    this_nUnifbals        = 0    && unifbals numeric(1,0) - Balanco Unificado
    this_nBalfalpers      = 0    && balfalpers numeric(1,0) - Balanco Falhas/Perdas
    this_nBlqdivops       = 0    && blqdivops numeric(1,0) - Bloqueia Divisao OF
    this_nInvisivel       = 0    && invisivel numeric(1,0) - Grupo nao Selecionavel
    this_nDdfutus         = 0    && ddfutus numeric(5,0) - Dias Bloqueio Futuro
    this_nDdretros        = 0    && ddretros numeric(5,0) - Dias Bloqueio Retroativo
    this_nDdsems          = 0    && ddsems numeric(1,0) - Dias em Semanas
    this_nHordd           = 0    && hordd numeric(4,2) - Hora DD
    this_nTipoinvs        = 0    && tipoinvs numeric(1,0) - Tipo Inventario

    *-- Industria / Fabrica
    this_nTrfpesas        = 0    && trfpesas numeric(1,0) - Transfere Peso
    this_nDifpesags       = 0    && difpesags numeric(9,3) - Diferenca de Peso
    this_nSinals          = 0    && sinals numeric(1,0) - Sinal (+/-)
    this_cPqs             = ""   && pqs char(1) - P ou Q (tipo falha)
    this_nCompagrus       = 0    && compagrus numeric(1,0) - Agrupa Componentes
    this_cAgrupas         = ""   && agrupas char(10) - Agrupamento
    this_nFichatecs       = 0    && fichatecs numeric(1,0) - Ficha Tecnica
    this_cOsalfuns        = ""   && osalfuns char(3) - Os/Alianca/Fundicao flags
    this_cGrufals         = ""   && grufals char(10) - Grupo Falha/Diferenca Balanco
    this_nOspends         = 0    && ospends numeric(1,0) - OS Pendente Dt.Entrega
    this_nChktits         = 0    && chktits numeric(1,0) - Checa Duplicidade Titulo
    this_nTpprecos        = 0    && tpprecos numeric(1,0) - Tipo de Preco
    this_cContafalha      = ""   && contafalha char(10) - Conta Falha
    this_cGrupofalha      = ""   && grupofalha char(10) - Grupo Falha
    this_nCtrlotes        = 0    && ctrlotes numeric(1,0) - Controle de Lote

    *--------------------------------------------------------------------------
    * ABA FATURAMENTO - Configuracoes fiscais por imposto
    * Formato empacotado: grupo(10)+conta(10)+descricao(40)+aliq(9.4)+receita(8)
    *--------------------------------------------------------------------------
    this_cCfgfisics       = ""   && cfgfisics char(50) - ICMS
    this_cCfgfisips       = ""   && cfgfisips char(50) - IPI
    this_cCfgfisiis       = ""   && cfgfisiis char(50) - II
    this_cCfgfisiss       = ""   && cfgfisiss char(50) - ISS
    this_cCfgfisirs       = ""   && cfgfisirs char(50) - IRRF
    this_cCfgfisins       = ""   && cfgfisins char(50) - INSS
    this_cCfgfispis       = ""   && cfgfispis char(50) - PIS
    this_cCfgfiscss       = ""   && cfgfiscss char(50) - CSSL
    this_cCfgfiscos       = ""   && cfgfiscos char(50) - COFINS

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdGcr"
        THIS.this_cCampoChave  = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de grupos de contas correntes no cursor_4c_Dados
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " ORDER BY a.codigos"
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " WHERE RTRIM(a.codigos) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " OR RTRIM(a.descrs) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY a.codigos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.*, ISNULL(b.Descrs,'') AS DClasses" + ;
                       " FROM SigCdGcr a" + ;
                       " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                       " WHERE RTRIM(a.codigos) = " + EscaparSQL(ALLTRIM(par_cCodigos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos         = TratarNulo(codigos, "C")
            THIS.this_cDescrs          = TratarNulo(descrs, "C")
            THIS.this_cDgcods          = TratarNulo(dgcods, "C")
            THIS.this_cInternos        = TratarNulo(internos, "C")
            THIS.this_cClasses         = TratarNulo(classes, "C")
            THIS.this_cDClasses        = TratarNulo(DClasses, "C")
            THIS.this_nTpcods          = TratarNulo(tpcods, "N")
            THIS.this_nTpemps          = TratarNulo(tpemps, "N")
            THIS.this_nTpcads          = TratarNulo(tpcads, "N")
            THIS.this_nComplems        = TratarNulo(complems, "N")
            THIS.this_nPessoais        = TratarNulo(pessoais, "N")
            THIS.this_nRefbancs        = TratarNulo(refbancs, "N")
            THIS.this_nFollowups       = TratarNulo(followups, "N")
            THIS.this_nFiscais         = TratarNulo(fiscais, "N")
            THIS.this_nContabs         = TratarNulo(contabs, "N")
            THIS.this_nEmpresas        = TratarNulo(empresas, "N")
            THIS.this_nCaracteris      = TratarNulo(caracteris, "N")
            THIS.this_nRespos          = TratarNulo(respos, "N")
            THIS.this_nLimcres         = TratarNulo(limcres, "N")
            THIS.this_nComis           = TratarNulo(comis, "N")
            THIS.this_nDadcoms         = TratarNulo(dadcoms, "N")
            THIS.this_nCargos          = TratarNulo(cargos, "N")
            THIS.this_nChklimcrds      = TratarNulo(chklimcrds, "N")
            THIS.this_nColetors        = TratarNulo(coletors, "N")
            THIS.this_nPrecad          = TratarNulo(precad, "N")
            THIS.this_cGrupolms        = TratarNulo(grupolms, "C")
            THIS.this_nVrlimcre        = TratarNulo(vrlimcre, "N")
            THIS.this_cMolimcre        = TratarNulo(molimcre, "C")
            THIS.this_cCommoedas       = TratarNulo(commoedas, "C")
            THIS.this_cRodrelcc        = TratarNulo(rodrelcc, "C")
            THIS.this_cCfgcdgcr        = TratarNulo(cfgcdgcr, "C")
            THIS.this_cDescsit         = TratarNulo(descsit, "C")
            THIS.this_nCpfobrigs       = TratarNulo(cpfobrigs, "N")
            THIS.this_nRgobrigs        = TratarNulo(rgobrigs, "N")
            THIS.this_nMfotos          = TratarNulo(mfotos, "N")
            THIS.this_nObservas        = TratarNulo(observas, "N")
            THIS.this_nInfcads         = TratarNulo(infcads, "N")
            THIS.this_nCalcimeds       = TratarNulo(calcimeds, "N")
            THIS.this_cDesccalcimeds   = TratarNulo(desccalcimeds, "C")
            THIS.this_nFpublsobr       = TratarNulo(fpublsobr, "N")
            THIS.this_cDescfpubls      = TratarNulo(descfpubls, "C")
            THIS.this_nInfsenha        = TratarNulo(infsenha, "N")
            THIS.this_nLogalt          = TratarNulo(logalt, "N")
            THIS.this_nEndobr          = TratarNulo(endobr, "N")
            THIS.this_nNumobr          = TratarNulo(numobr, "N")
            THIS.this_nBairroobr       = TratarNulo(bairroobr, "N")
            THIS.this_nCidasobr        = TratarNulo(cidasobr, "N")
            THIS.this_nCepobris        = TratarNulo(cepobris, "N")
            THIS.this_nPaisesobr       = TratarNulo(paisesobr, "N")
            THIS.this_nChkendds        = TratarNulo(chkendds, "N")
            THIS.this_nChkendrs        = TratarNulo(chkendrs, "N")
            THIS.this_nTel1obr         = TratarNulo(tel1obr, "N")
            THIS.this_nTel2obr         = TratarNulo(tel2obr, "N")
            THIS.this_nNascobr         = TratarNulo(nascobr, "N")
            THIS.this_nSexobr          = TratarNulo(sexobr, "N")
            THIS.this_nDtnascobr       = TratarNulo(dtnascobr, "N")
            THIS.this_nDtespobr        = TratarNulo(dtespobr, "N")
            THIS.this_nObrtelefone     = TratarNulo(Obrtelefone, "N")
            THIS.this_cDesctlm         = TratarNulo(desctlm, "C")
            THIS.this_cDesccla         = TratarNulo(desccla, "C")
            THIS.this_cDescseg         = TratarNulo(descseg, "C")
            THIS.this_cContconts       = TratarNulo(contconts, "C")
            THIS.this_nIntconts        = TratarNulo(intconts, "N")
            THIS.this_nPadpgrecs       = TratarNulo(padpgrecs, "N")
            THIS.this_nCtvinculas      = TratarNulo(ctvinculas, "N")
            THIS.this_nTitbaixado      = TratarNulo(titbaixado, "N")
            THIS.this_cContapdr        = TratarNulo(contapdr, "C")
            THIS.this_nCcustotit       = TratarNulo(ccustotit, "N")
            THIS.this_nDefhideshow     = TratarNulo(defhideshow, "N")
            THIS.this_nCtainatv        = TratarNulo(ctainatv, "N")
            THIS.this_nEstoques        = TratarNulo(estoques, "N")
            THIS.this_nLimestoqs       = TratarNulo(limestoqs, "N")
            THIS.this_nVerests         = TratarNulo(verests, "N")
            THIS.this_nEmprelevs       = TratarNulo(emprelevs, "N")
            THIS.this_nBlqcongvs       = TratarNulo(blqcongvs, "N")
            THIS.this_nCalcsalds       = TratarNulo(calcsalds, "N")
            THIS.this_nChklimests      = TratarNulo(chklimests, "N")
            THIS.this_nPatrietqs       = TratarNulo(patrietqs, "N")
            THIS.this_nCcustos         = TratarNulo(ccustos, "N")
            THIS.this_nGerbals         = TratarNulo(gerbals, "N")
            THIS.this_nUnifbals        = TratarNulo(unifbals, "N")
            THIS.this_nBalfalpers      = TratarNulo(balfalpers, "N")
            THIS.this_nBlqdivops       = TratarNulo(blqdivops, "N")
            THIS.this_nInvisivel       = TratarNulo(invisivel, "N")
            THIS.this_nDdfutus         = TratarNulo(ddfutus, "N")
            THIS.this_nDdretros        = TratarNulo(ddretros, "N")
            THIS.this_nDdsems          = TratarNulo(ddsems, "N")
            THIS.this_nHordd           = TratarNulo(hordd, "N")
            THIS.this_nTipoinvs        = TratarNulo(tipoinvs, "N")
            THIS.this_nTrfpesas        = TratarNulo(trfpesas, "N")
            THIS.this_nDifpesags       = TratarNulo(difpesags, "N")
            THIS.this_nSinals          = TratarNulo(sinals, "N")
            THIS.this_cPqs             = TratarNulo(pqs, "C")
            THIS.this_nCompagrus       = TratarNulo(compagrus, "N")
            THIS.this_cAgrupas         = TratarNulo(agrupas, "C")
            THIS.this_nFichatecs       = TratarNulo(fichatecs, "N")
            THIS.this_cOsalfuns        = TratarNulo(osalfuns, "C")
            THIS.this_cGrufals         = TratarNulo(grufals, "C")
            THIS.this_nOspends         = TratarNulo(ospends, "N")
            THIS.this_nChktits         = TratarNulo(chktits, "N")
            THIS.this_nTpprecos        = TratarNulo(tpprecos, "N")
            THIS.this_cContafalha      = TratarNulo(contafalha, "C")
            THIS.this_cGrupofalha      = TratarNulo(grupofalha, "C")
            THIS.this_nCtrlotes        = TratarNulo(ctrlotes, "N")
            THIS.this_cCfgfisics       = TratarNulo(cfgfisics, "C")
            THIS.this_cCfgfisips       = TratarNulo(cfgfisips, "C")
            THIS.this_cCfgfisiis       = TratarNulo(cfgfisiis, "C")
            THIS.this_cCfgfisiss       = TratarNulo(cfgfisiss, "C")
            THIS.this_cCfgfisirs       = TratarNulo(cfgfisirs, "C")
            THIS.this_cCfgfisins       = TratarNulo(cfgfisins, "C")
            THIS.this_cCfgfispis       = TratarNulo(cfgfispis, "C")
            THIS.this_cCfgfiscss       = TratarNulo(cfgfiscss, "C")
            THIS.this_cCfgfiscos       = TratarNulo(cfgfiscos, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdGcr (" + ;
                       "codigos,descrs,dgcods,internos,classes," + ;
                       "tpcods,tpemps,tpcads,complems,pessoais," + ;
                       "refbancs,followups,fiscais,contabs,empresas," + ;
                       "caracteris,respos,limcres,comis,dadcoms," + ;
                       "cargos,chklimcrds,coletors,precad,grupolms," + ;
                       "vrlimcre,molimcre,commoedas,rodrelcc,cfgcdgcr," + ;
                       "descsit,cpfobrigs,rgobrigs,mfotos,observas," + ;
                       "infcads,calcimeds,desccalcimeds,fpublsobr,descfpubls," + ;
                       "infsenha,logalt,endobr,numobr,bairroobr," + ;
                       "cidasobr,cepobris,paisesobr,chkendds,chkendrs," + ;
                       "tel1obr,tel2obr,nascobr,sexobr,dtnascobr," + ;
                       "dtespobr,obrtelefone,desctlm,desccla,descseg," + ;
                       "contconts,intconts,padpgrecs,ctvinculas,titbaixado," + ;
                       "contapdr,ccustotit,defhideshow,ctainatv,estoques," + ;
                       "limestoqs,verests,emprelevs,blqcongvs,calcsalds," + ;
                       "chklimests,patrietqs,ccustos,gerbals,unifbals," + ;
                       "balfalpers,blqdivops,invisivel,ddfutus,ddretros," + ;
                       "ddsems,hordd,tipoinvs,trfpesas,difpesags," + ;
                       "sinals,pqs,compagrus,agrupas,fichatecs," + ;
                       "osalfuns,grufals,ospends,chktits,tpprecos," + ;
                       "contafalha,grupofalha,ctrlotes," + ;
                       "cfgfisics,cfgfisips,cfgfisiis,cfgfisiss,cfgfisirs," + ;
                       "cfgfisins,cfgfispis,cfgfiscss,cfgfiscos" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + "," + ;
                       EscaparSQL(THIS.this_cDescrs) + "," + ;
                       EscaparSQL(THIS.this_cDgcods) + "," + ;
                       EscaparSQL(THIS.this_cInternos) + "," + ;
                       EscaparSQL(THIS.this_cClasses) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       EscaparSQL(THIS.this_cDescsit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       EscaparSQL(THIS.this_cDesccla) + "," + ;
                       EscaparSQL(THIS.this_cDescseg) + "," + ;
                       EscaparSQL(THIS.this_cContconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       EscaparSQL(THIS.this_cContapdr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       EscaparSQL(THIS.this_cPqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       EscaparSQL(THIS.this_cGrufals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       EscaparSQL(THIS.this_cContafalha) + "," + ;
                       EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscos) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcr SET" + ;
                       " descrs=" + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " dgcods=" + EscaparSQL(THIS.this_cDgcods) + "," + ;
                       " internos=" + EscaparSQL(THIS.this_cInternos) + "," + ;
                       " classes=" + EscaparSQL(THIS.this_cClasses) + "," + ;
                       " tpcods=" + FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       " tpemps=" + FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       " tpcads=" + FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       " complems=" + FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       " pessoais=" + FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       " refbancs=" + FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       " followups=" + FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       " fiscais=" + FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       " contabs=" + FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       " empresas=" + FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       " caracteris=" + FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       " respos=" + FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       " limcres=" + FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       " comis=" + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       " dadcoms=" + FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       " cargos=" + FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       " chklimcrds=" + FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       " coletors=" + FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       " precad=" + FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       " grupolms=" + EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       " vrlimcre=" + FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       " molimcre=" + EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       " commoedas=" + EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       " rodrelcc=" + EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       " cfgcdgcr=" + EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       " descsit=" + EscaparSQL(THIS.this_cDescsit) + "," + ;
                       " cpfobrigs=" + FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       " rgobrigs=" + FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       " mfotos=" + FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       " observas=" + FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       " infcads=" + FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       " calcimeds=" + FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       " desccalcimeds=" + EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       " fpublsobr=" + FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       " descfpubls=" + EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       " infsenha=" + FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       " logalt=" + FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       " endobr=" + FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       " numobr=" + FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       " bairroobr=" + FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       " cidasobr=" + FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       " cepobris=" + FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       " paisesobr=" + FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       " chkendds=" + FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       " chkendrs=" + FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       " tel1obr=" + FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       " tel2obr=" + FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       " nascobr=" + FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       " sexobr=" + FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       " dtnascobr=" + FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       " dtespobr=" + FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       " obrtelefone=" + FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       " desctlm=" + EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       " desccla=" + EscaparSQL(THIS.this_cDesccla) + "," + ;
                       " descseg=" + EscaparSQL(THIS.this_cDescseg) + "," + ;
                       " contconts=" + EscaparSQL(THIS.this_cContconts) + "," + ;
                       " intconts=" + FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       " padpgrecs=" + FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       " ctvinculas=" + FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       " titbaixado=" + FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       " contapdr=" + EscaparSQL(THIS.this_cContapdr) + "," + ;
                       " ccustotit=" + FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       " defhideshow=" + FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       " ctainatv=" + FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       " estoques=" + FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       " limestoqs=" + FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       " verests=" + FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       " emprelevs=" + FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       " blqcongvs=" + FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       " calcsalds=" + FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       " chklimests=" + FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       " patrietqs=" + FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       " ccustos=" + FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       " gerbals=" + FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       " unifbals=" + FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       " balfalpers=" + FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       " blqdivops=" + FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       " invisivel=" + FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       " ddfutus=" + FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       " ddretros=" + FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       " ddsems=" + FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       " hordd=" + FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       " tipoinvs=" + FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       " trfpesas=" + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       " difpesags=" + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       " sinals=" + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       " pqs=" + EscaparSQL(THIS.this_cPqs) + "," + ;
                       " compagrus=" + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       " agrupas=" + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " fichatecs=" + FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       " osalfuns=" + EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       " grufals=" + EscaparSQL(THIS.this_cGrufals) + "," + ;
                       " ospends=" + FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       " chktits=" + FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       " tpprecos=" + FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       " contafalha=" + EscaparSQL(THIS.this_cContafalha) + "," + ;
                       " grupofalha=" + EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       " ctrlotes=" + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       " cfgfisics=" + EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       " cfgfisips=" + EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       " cfgfisiis=" + EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       " cfgfisiss=" + EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       " cfgfisirs=" + EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       " cfgfisins=" + EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       " cfgfispis=" + EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       " cfgfiscss=" + EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       " cfgfiscos=" + EscaparSQL(THIS.this_cCfgfiscos) + ;
                       " WHERE codigos=" + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigCdGcr com verificacao de dependencias
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_cCodigo, loc_nCount, loc_nResultado, loc_lSucesso, loc_lBloqueado
        loc_lSucesso  = .F.
        loc_lBloqueado = .F.
        loc_cCodigo   = EscaparSQL(ALLTRIM(THIS.this_cCodigos))

        TRY
            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCcr WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigCdCli WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCab WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lBloqueado
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Existem Lan" + CHR(231) + "amentos Efetuados Neste Grupo!!!" + CHR(13) + ;
                        "Exclua Todos os Lan" + CHR(231) + "amentos Antes de Excluir o Grupo!!!", "ERRO!!!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdGcr WHERE codigos = " + loc_cCodigo
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
            MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

