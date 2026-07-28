# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [ALINHAMENTO] Botao 'cmd_4c_ExcluirAcesso' tem Top=527 mas grupo usa Top=528 (diferenca de 1px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCargo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3302 linhas total):

*-- Linhas 59 a 68:
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
66:                     THIS.CarregarLista()
67:                 ENDIF
68: 

*-- Linhas 88 a 105:
88: 
89:         WITH loc_oPgf
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97:             .Page1.Caption   = "Lista"
98:             .Page1.BackColor = RGB(100, 100, 100)
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.Caption   = "Dados"
101:             .Page2.BackColor = RGB(100, 100, 100)
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()

*-- Linhas 117 a 155:
117:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
118:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
119:         WITH loc_oCab
120:             .Top         = 31
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
130:         WITH loc_oCab.lbl_4c_Sombra
131:             .AutoSize  = .F.
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oCab.lbl_4c_Titulo
147:             .AutoSize  = .F.
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 162 a 186:
162:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
163:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
164:         WITH loc_oBotoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackColor   = RGB(53, 53, 53)
170:             .BackStyle   = 1
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oBotoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .FontName        = "Tahoma"

*-- Linhas 195 a 209:
195:             .Visible         = .T.
196:         ENDWITH
197: 
198:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oBotoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .BackColor       = RGB(255, 255, 255)
208:             .ForeColor       = RGB(90, 90, 90)
209:             .FontName        = "Tahoma"

*-- Linhas 218 a 232:
218:             .Visible         = .T.
219:         ENDWITH
220: 
221:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oBotoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .BackColor       = RGB(255, 255, 255)
231:             .ForeColor       = RGB(90, 90, 90)
232:             .FontName        = "Tahoma"

*-- Linhas 241 a 255:
241:             .Visible         = .T.
242:         ENDWITH
243: 
244:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oBotoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .FontName        = "Tahoma"

*-- Linhas 264 a 278:
264:             .Visible         = .T.
265:         ENDWITH
266: 
267:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
268:         WITH loc_oBotoes.cmd_4c_Buscar
269:             .Caption         = "Buscar"
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
271:             .PicturePosition = 13
272:             .Top             = 5
273:             .Left            = 305
274:             .Width           = 75
275:             .Height          = 75
276:             .BackColor       = RGB(255, 255, 255)
277:             .ForeColor       = RGB(90, 90, 90)
278:             .FontName        = "Tahoma"

*-- Linhas 287 a 320:
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
291:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
294:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Encerrar (canonico: Left=917, Width=90)
297:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
298:         loc_oSaida = loc_oPg1.cnt_4c_Saida
299:         WITH loc_oSaida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308: 
309:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oSaida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .BackColor       = RGB(255, 255, 255)
319:             .ForeColor       = RGB(90, 90, 90)
320:             .FontName        = "Tahoma"

*-- Linhas 329 a 346:
329:             .Visible         = .T.
330:         ENDWITH
331: 
332:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Grid lista: ccargs (Cargo) + dcargs (Descricao)
335:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
336:         loc_oPg1.grd_4c_Lista.RecordSource = ""
337:         loc_oPg1.grd_4c_Lista.ColumnCount  = 2
338: 
339:         WITH loc_oPg1.grd_4c_Lista
340:             .Top                     = 117
341:             .Left                    = 12
342:             .Width                   = 890
343:             .Height                  = 480
344:             .FontName                = "Verdana"
345:             .FontSize                = 8
346:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 360 a 369:
360:             .Column2.Width           = 760
361:             .Column1.ReadOnly        = .T.
362:             .Column2.ReadOnly        = .T.
363:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
364:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPg1)
368:     ENDPROC
369: 

*-- Linhas 378 a 401:
378:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
379:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
380:         WITH loc_oBotoesAcao
381:             .Top         = 33
382:             .Left        = 842
383:             .Width       = 160
384:             .Height      = 85
385:             .BackStyle   = 0
386:             .BorderWidth = 0
387:             .Visible     = .T.
388:         ENDWITH
389: 
390:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
391:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
392:             .Caption         = "Confirmar"
393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
394:             .PicturePosition = 13
395:             .Top             = 5
396:             .Left            = 5
397:             .Width           = 75
398:             .Height          = 75
399:             .BackColor       = RGB(255, 255, 255)
400:             .ForeColor       = RGB(90, 90, 90)
401:             .FontName        = "Tahoma"

*-- Linhas 410 a 424:
410:             .Visible         = .T.
411:         ENDWITH
412: 
413:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
414:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
415:             .Caption         = "Encerrar"
416:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
417:             .PicturePosition = 13
418:             .Top             = 5
419:             .Left            = 80
420:             .Width           = 75
421:             .Height          = 75
422:             .BackColor       = RGB(255, 255, 255)
423:             .ForeColor       = RGB(90, 90, 90)
424:             .FontName        = "Tahoma"

*-- Linhas 433 a 451:
433:             .Visible         = .T.
434:         ENDWITH
435: 
436:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
437:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
438: 
439:         *======================================================================
440:         * LINHA 1: Cargo + Senha
441:         *======================================================================
442:         loc_oPg2.AddObject("lbl_4c_LbCargo", "Label")
443:         WITH loc_oPg2.lbl_4c_LbCargo
444:             .Caption   = "Cargo :"
445:             .Top       = 51
446:             .Left      = 212
447:             .Width     = 38
448:             .Height    = 17
449:             .AutoSize  = .F.
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8

*-- Linhas 458 a 467:
458:         loc_oPg2.AddObject("txt_4c_Ccargs", "TextBox")
459:         WITH loc_oPg2.txt_4c_Ccargs
460:             .Value         = ""
461:             .Top           = 47
462:             .Left          = 252
463:             .Width         = 80
464:             .Height        = 21
465:             .FontName      = "Tahoma"
466:             .FontSize      = 8
467:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 473 a 504:
473:         ENDWITH
474: 
475:         *-- Botao busca template (cmdGarqicone: abre picker p/ copiar cargo base)
476:         loc_oPg2.AddObject("cmd_4c_BuscarBase", "CommandButton")
477:         WITH loc_oPg2.cmd_4c_BuscarBase
478:             .Caption         = ""
479:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
480:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
481:             .PicturePosition = 0
482:             .Top             = 47
483:             .Left            = 335
484:             .Width           = 22
485:             .Height          = 22
486:             .BackColor       = RGB(255, 255, 255)
487:             .Themes          = .T.
488:             .SpecialEffect   = 0
489:             .MousePointer    = 15
490:             .Visible         = .T.
491:         ENDWITH
492: 
493:         BINDEVENT(loc_oPg2.cmd_4c_BuscarBase, "Click", THIS, "BtnBuscarBaseClick")
494: 
495:         loc_oPg2.AddObject("lbl_4c_LbSenha", "Label")
496:         WITH loc_oPg2.lbl_4c_LbSenha
497:             .Caption   = "Senha :"
498:             .Top       = 50
499:             .Left      = 578
500:             .Width     = 40
501:             .Height    = 17
502:             .AutoSize  = .F.
503:             .FontName  = "Tahoma"
504:             .FontSize  = 8

*-- Linhas 511 a 537:
511:         loc_oPg2.AddObject("txt_4c_Nivels", "TextBox")
512:         WITH loc_oPg2.txt_4c_Nivels
513:             .Value         = ""
514:             .Top           = 46
515:             .Left          = 619
516:             .Width         = 20
517:             .Height        = 21
518:             .FontName      = "Tahoma"
519:             .FontSize      = 8
520:             .ForeColor     = RGB(90, 90, 90)
521:             .BackColor     = RGB(255, 255, 255)
522:             .BorderStyle   = 1
523:             .SpecialEffect = 0
524:             .MaxLength     = 1
525:             .Visible       = .T.
526:         ENDWITH
527: 
528:         loc_oPg2.AddObject("lbl_4c_LbSenhaSN", "Label")
529:         WITH loc_oPg2.lbl_4c_LbSenhaSN
530:             .Caption   = "(S/N)"
531:             .Top       = 50
532:             .Left      = 642
533:             .Width     = 35
534:             .Height    = 17
535:             .AutoSize  = .F.
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8

*-- Linhas 543 a 555:
543:         *======================================================================
544:         * LINHA 2: Descricao + Altera Cotacao
545:         *======================================================================
546:         loc_oPg2.AddObject("lbl_4c_LbDescr", "Label")
547:         WITH loc_oPg2.lbl_4c_LbDescr
548:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
549:             .Top       = 76
550:             .Left      = 195
551:             .Width     = 55
552:             .Height    = 17
553:             .AutoSize  = .F.
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8

*-- Linhas 562 a 588:
562:         loc_oPg2.AddObject("txt_4c_Dcargs", "TextBox")
563:         WITH loc_oPg2.txt_4c_Dcargs
564:             .Value         = ""
565:             .Top           = 72
566:             .Left          = 252
567:             .Width         = 155
568:             .Height        = 21
569:             .FontName      = "Tahoma"
570:             .FontSize      = 8
571:             .ForeColor     = RGB(90, 90, 90)
572:             .BackColor     = RGB(255, 255, 255)
573:             .BorderStyle   = 1
574:             .SpecialEffect = 0
575:             .MaxLength     = 20
576:             .Visible       = .T.
577:         ENDWITH
578: 
579:         loc_oPg2.AddObject("lbl_4c_LbAltCot", "Label")
580:         WITH loc_oPg2.lbl_4c_LbAltCot
581:             .Caption   = "Altera Cota" + CHR(231) + CHR(227) + "o :"
582:             .Top       = 75
583:             .Left      = 536
584:             .Width     = 82
585:             .Height    = 17
586:             .AutoSize  = .F.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8

*-- Linhas 595 a 621:
595:         loc_oPg2.AddObject("txt_4c_Altcots", "TextBox")
596:         WITH loc_oPg2.txt_4c_Altcots
597:             .Value         = ""
598:             .Top           = 71
599:             .Left          = 619
600:             .Width         = 20
601:             .Height        = 21
602:             .FontName      = "Tahoma"
603:             .FontSize      = 8
604:             .ForeColor     = RGB(90, 90, 90)
605:             .BackColor     = RGB(255, 255, 255)
606:             .BorderStyle   = 1
607:             .SpecialEffect = 0
608:             .MaxLength     = 1
609:             .Visible       = .T.
610:         ENDWITH
611: 
612:         loc_oPg2.AddObject("lbl_4c_LbAltCotSN", "Label")
613:         WITH loc_oPg2.lbl_4c_LbAltCotSN
614:             .Caption   = "(S/N)"
615:             .Top       = 75
616:             .Left      = 642
617:             .Width     = 35
618:             .Height    = 17
619:             .AutoSize  = .F.
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8

*-- Linhas 627 a 639:
627:         *======================================================================
628:         * LINHA 3: Limite Desconto + Libera Limite
629:         *======================================================================
630:         loc_oPg2.AddObject("lbl_4c_LbLimDesc", "Label")
631:         WITH loc_oPg2.lbl_4c_LbLimDesc
632:             .Caption   = "Limite Desconto :"
633:             .Top       = 101
634:             .Left      = 166
635:             .Width     = 84
636:             .Height    = 17
637:             .AutoSize  = .F.
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8

*-- Linhas 646 a 655:
646:         loc_oPg2.AddObject("txt_4c_Limdescs", "TextBox")
647:         WITH loc_oPg2.txt_4c_Limdescs
648:             .Value         = 0
649:             .Top           = 97
650:             .Left          = 252
651:             .Width         = 108
652:             .Height        = 21
653:             .FontName      = "Tahoma"
654:             .FontSize      = 8
655:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 664 a 673:
664:         loc_oPg2.AddObject("txt_4c_Descpors", "TextBox")
665:         WITH loc_oPg2.txt_4c_Descpors
666:             .Value         = 0
667:             .Top           = 97
668:             .Left          = 362
669:             .Width         = 45
670:             .Height        = 21
671:             .FontName      = "Tahoma"
672:             .FontSize      = 8
673:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 679 a 706:
679:             .Visible       = .T.
680:         ENDWITH
681: 
682:         loc_oPg2.AddObject("lbl_4c_LbDescPct", "Label")
683:         WITH loc_oPg2.lbl_4c_LbDescPct
684:             .Caption   = "(%)"
685:             .Top       = 101
686:             .Left      = 410
687:             .Width     = 25
688:             .Height    = 17
689:             .AutoSize  = .F.
690:             .FontName  = "Tahoma"
691:             .FontSize  = 8
692:             .ForeColor = RGB(90, 90, 90)
693:             .BackStyle = 0
694:             .Visible   = .T.
695:         ENDWITH
696: 
697:         loc_oPg2.AddObject("lbl_4c_LbLibLim", "Label")
698:         WITH loc_oPg2.lbl_4c_LbLibLim
699:             .Caption   = "Libera Limite :"
700:             .Top       = 100
701:             .Left      = 549
702:             .Width     = 68
703:             .Height    = 17
704:             .AutoSize  = .F.
705:             .FontName  = "Tahoma"
706:             .FontSize  = 8

*-- Linhas 713 a 739:
713:         loc_oPg2.AddObject("txt_4c_Limites", "TextBox")
714:         WITH loc_oPg2.txt_4c_Limites
715:             .Value         = ""
716:             .Top           = 96
717:             .Left          = 619
718:             .Width         = 20
719:             .Height        = 21
720:             .FontName      = "Tahoma"
721:             .FontSize      = 8
722:             .ForeColor     = RGB(90, 90, 90)
723:             .BackColor     = RGB(255, 255, 255)
724:             .BorderStyle   = 1
725:             .SpecialEffect = 0
726:             .MaxLength     = 1
727:             .Visible       = .T.
728:         ENDWITH
729: 
730:         loc_oPg2.AddObject("lbl_4c_LbLibLimSN", "Label")
731:         WITH loc_oPg2.lbl_4c_LbLibLimSN
732:             .Caption   = "(S/N)"
733:             .Top       = 100
734:             .Left      = 642
735:             .Width     = 35
736:             .Height    = 17
737:             .AutoSize  = .F.
738:             .FontName  = "Tahoma"
739:             .FontSize  = 8

*-- Linhas 745 a 757:
745:         *======================================================================
746:         * LINHA 4: Limite Acrescimo + Cancela Item Cupom
747:         *======================================================================
748:         loc_oPg2.AddObject("lbl_4c_LbLimAcre", "Label")
749:         WITH loc_oPg2.lbl_4c_LbLimAcre
750:             .Caption   = "Limite Acr" + CHR(233) + "scimo :"
751:             .Top       = 126
752:             .Left      = 163
753:             .Width     = 87
754:             .Height    = 17
755:             .AutoSize  = .F.
756:             .FontName  = "Tahoma"
757:             .FontSize  = 8

*-- Linhas 764 a 773:
764:         loc_oPg2.AddObject("txt_4c_Limacres", "TextBox")
765:         WITH loc_oPg2.txt_4c_Limacres
766:             .Value         = 0
767:             .Top           = 122
768:             .Left          = 252
769:             .Width         = 108
770:             .Height        = 21
771:             .FontName      = "Tahoma"
772:             .FontSize      = 8
773:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 782 a 791:
782:         loc_oPg2.AddObject("txt_4c_Acrepors", "TextBox")
783:         WITH loc_oPg2.txt_4c_Acrepors
784:             .Value         = 0
785:             .Top           = 122
786:             .Left          = 362
787:             .Width         = 45
788:             .Height        = 21
789:             .FontName      = "Tahoma"
790:             .FontSize      = 8
791:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 797 a 824:
797:             .Visible       = .T.
798:         ENDWITH
799: 
800:         loc_oPg2.AddObject("lbl_4c_LbAcrePct", "Label")
801:         WITH loc_oPg2.lbl_4c_LbAcrePct
802:             .Caption   = "(%)"
803:             .Top       = 126
804:             .Left      = 410
805:             .Width     = 25
806:             .Height    = 17
807:             .AutoSize  = .F.
808:             .FontName  = "Tahoma"
809:             .FontSize  = 8
810:             .ForeColor = RGB(90, 90, 90)
811:             .BackStyle = 0
812:             .Visible   = .T.
813:         ENDWITH
814: 
815:         loc_oPg2.AddObject("lbl_4c_LbCancItem", "Label")
816:         WITH loc_oPg2.lbl_4c_LbCancItem
817:             .Caption   = "Cancela Item Cupom Fiscal:"
818:             .Top       = 125
819:             .Left      = 483
820:             .Width     = 135
821:             .Height    = 17
822:             .AutoSize  = .F.
823:             .FontName  = "Tahoma"
824:             .FontSize  = 8

*-- Linhas 831 a 857:
831:         loc_oPg2.AddObject("txt_4c_Cancitens", "TextBox")
832:         WITH loc_oPg2.txt_4c_Cancitens
833:             .Value         = ""
834:             .Top           = 121
835:             .Left          = 619
836:             .Width         = 20
837:             .Height        = 21
838:             .FontName      = "Tahoma"
839:             .FontSize      = 8
840:             .ForeColor     = RGB(90, 90, 90)
841:             .BackColor     = RGB(255, 255, 255)
842:             .BorderStyle   = 1
843:             .SpecialEffect = 0
844:             .MaxLength     = 1
845:             .Visible       = .T.
846:         ENDWITH
847: 
848:         loc_oPg2.AddObject("lbl_4c_LbCancSN", "Label")
849:         WITH loc_oPg2.lbl_4c_LbCancSN
850:             .Caption   = "(S/N)"
851:             .Top       = 125
852:             .Left      = 642
853:             .Width     = 35
854:             .Height    = 17
855:             .AutoSize  = .F.
856:             .FontName  = "Tahoma"
857:             .FontSize  = 8

*-- Linhas 863 a 875:
863:         *======================================================================
864:         * LINHA 5: Liberar Pagamentos + Excluir Cond Pagto
865:         *======================================================================
866:         loc_oPg2.AddObject("lbl_4c_LbVlPag", "Label")
867:         WITH loc_oPg2.lbl_4c_LbVlPag
868:             .Caption   = "Liberar Pagamentos at" + CHR(233) + " :"
869:             .Top       = 151
870:             .Left      = 127
871:             .Width     = 123
872:             .Height    = 17
873:             .AutoSize  = .F.
874:             .FontName  = "Tahoma"
875:             .FontSize  = 8

*-- Linhas 882 a 891:
882:         loc_oPg2.AddObject("txt_4c_Vllibpgs", "TextBox")
883:         WITH loc_oPg2.txt_4c_Vllibpgs
884:             .Value         = 0
885:             .Top           = 147
886:             .Left          = 252
887:             .Width         = 108
888:             .Height        = 21
889:             .FontName      = "Tahoma"
890:             .FontSize      = 8
891:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 897 a 924:
897:             .Visible       = .T.
898:         ENDWITH
899: 
900:         loc_oPg2.AddObject("lbl_4c_LbVlPagRS", "Label")
901:         WITH loc_oPg2.lbl_4c_LbVlPagRS
902:             .Caption   = "(R$)"
903:             .Top       = 151
904:             .Left      = 365
905:             .Width     = 30
906:             .Height    = 17
907:             .AutoSize  = .F.
908:             .FontName  = "Tahoma"
909:             .FontSize  = 8
910:             .ForeColor = RGB(90, 90, 90)
911:             .BackStyle = 0
912:             .Visible   = .T.
913:         ENDWITH
914: 
915:         loc_oPg2.AddObject("lbl_4c_LbLibFpag", "Label")
916:         WITH loc_oPg2.lbl_4c_LbLibFpag
917:             .Caption   = "Excluir Condi" + CHR(231) + CHR(227) + "o Pagto (ecf):"
918:             .Top       = 150
919:             .Left      = 476
920:             .Width     = 142
921:             .Height    = 17
922:             .AutoSize  = .F.
923:             .FontName  = "Tahoma"
924:             .FontSize  = 8

*-- Linhas 931 a 957:
931:         loc_oPg2.AddObject("txt_4c_Libfpags", "TextBox")
932:         WITH loc_oPg2.txt_4c_Libfpags
933:             .Value         = ""
934:             .Top           = 146
935:             .Left          = 619
936:             .Width         = 20
937:             .Height        = 21
938:             .FontName      = "Tahoma"
939:             .FontSize      = 8
940:             .ForeColor     = RGB(90, 90, 90)
941:             .BackColor     = RGB(255, 255, 255)
942:             .BorderStyle   = 1
943:             .SpecialEffect = 0
944:             .MaxLength     = 1
945:             .Visible       = .T.
946:         ENDWITH
947: 
948:         loc_oPg2.AddObject("lbl_4c_LbLibFpagSN", "Label")
949:         WITH loc_oPg2.lbl_4c_LbLibFpagSN
950:             .Caption   = "(S/N)"
951:             .Top       = 150
952:             .Left      = 642
953:             .Width     = 35
954:             .Height    = 17
955:             .AutoSize  = .F.
956:             .FontName  = "Tahoma"
957:             .FontSize  = 8

*-- Linhas 963 a 975:
963:         *======================================================================
964:         * LINHA 6: Liberar Cotacoes + Libera Saldo Insuficiente
965:         *======================================================================
966:         loc_oPg2.AddObject("lbl_4c_LbVlCot", "Label")
967:         WITH loc_oPg2.lbl_4c_LbVlCot
968:             .Caption   = "Liberar Cota" + CHR(231) + CHR(245) + "es at" + CHR(233) + " :"
969:             .Top       = 176
970:             .Left      = 141
971:             .Width     = 109
972:             .Height    = 17
973:             .AutoSize  = .F.
974:             .FontName  = "Tahoma"
975:             .FontSize  = 8

*-- Linhas 982 a 991:
982:         loc_oPg2.AddObject("txt_4c_Vllibcots", "TextBox")
983:         WITH loc_oPg2.txt_4c_Vllibcots
984:             .Value         = 0
985:             .Top           = 172
986:             .Left          = 252
987:             .Width         = 108
988:             .Height        = 21
989:             .FontName      = "Tahoma"
990:             .FontSize      = 8
991:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 997 a 1024:
997:             .Visible       = .T.
998:         ENDWITH
999: 
1000:         loc_oPg2.AddObject("lbl_4c_LbVlCotRS", "Label")
1001:         WITH loc_oPg2.lbl_4c_LbVlCotRS
1002:             .Caption   = "(R$)"
1003:             .Top       = 176
1004:             .Left      = 365
1005:             .Width     = 30
1006:             .Height    = 17
1007:             .AutoSize  = .F.
1008:             .FontName  = "Tahoma"
1009:             .FontSize  = 8
1010:             .ForeColor = RGB(90, 90, 90)
1011:             .BackStyle = 0
1012:             .Visible   = .T.
1013:         ENDWITH
1014: 
1015:         loc_oPg2.AddObject("lbl_4c_LbSdIns", "Label")
1016:         WITH loc_oPg2.lbl_4c_LbSdIns
1017:             .Caption   = "Libera Saldo Insuficiente :"
1018:             .Top       = 175
1019:             .Left      = 491
1020:             .Width     = 127
1021:             .Height    = 17
1022:             .AutoSize  = .F.
1023:             .FontName  = "Tahoma"
1024:             .FontSize  = 8

*-- Linhas 1031 a 1057:
1031:         loc_oPg2.AddObject("txt_4c_Libsdins", "TextBox")
1032:         WITH loc_oPg2.txt_4c_Libsdins
1033:             .Value         = ""
1034:             .Top           = 171
1035:             .Left          = 619
1036:             .Width         = 20
1037:             .Height        = 21
1038:             .FontName      = "Tahoma"
1039:             .FontSize      = 8
1040:             .ForeColor     = RGB(90, 90, 90)
1041:             .BackColor     = RGB(255, 255, 255)
1042:             .BorderStyle   = 1
1043:             .SpecialEffect = 0
1044:             .MaxLength     = 1
1045:             .Visible       = .T.
1046:         ENDWITH
1047: 
1048:         loc_oPg2.AddObject("lbl_4c_LbSdInsSN", "Label")
1049:         WITH loc_oPg2.lbl_4c_LbSdInsSN
1050:             .Caption   = "(S/N)"
1051:             .Top       = 175
1052:             .Left      = 642
1053:             .Width     = 35
1054:             .Height    = 17
1055:             .AutoSize  = .F.
1056:             .FontName  = "Tahoma"
1057:             .FontSize  = 8

*-- Linhas 1063 a 1075:
1063:         *======================================================================
1064:         * LINHA 7: Liberar Movimentacoes + Liberar Cond Pagto
1065:         *======================================================================
1066:         loc_oPg2.AddObject("lbl_4c_LbVlOps", "Label")
1067:         WITH loc_oPg2.lbl_4c_LbVlOps
1068:             .Caption   = "Liberar Movimenta" + CHR(231) + CHR(245) + "es at" + CHR(233) + " :"
1069:             .Top       = 201
1070:             .Left      = 112
1071:             .Width     = 138
1072:             .Height    = 17
1073:             .AutoSize  = .F.
1074:             .FontName  = "Tahoma"
1075:             .FontSize  = 8

*-- Linhas 1082 a 1091:
1082:         loc_oPg2.AddObject("txt_4c_Vllibopes", "TextBox")
1083:         WITH loc_oPg2.txt_4c_Vllibopes
1084:             .Value         = 0
1085:             .Top           = 197
1086:             .Left          = 252
1087:             .Width         = 108
1088:             .Height        = 21
1089:             .FontName      = "Tahoma"
1090:             .FontSize      = 8
1091:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1097 a 1124:
1097:             .Visible       = .T.
1098:         ENDWITH
1099: 
1100:         loc_oPg2.AddObject("lbl_4c_LbVlOpsRS", "Label")
1101:         WITH loc_oPg2.lbl_4c_LbVlOpsRS
1102:             .Caption   = "(R$)"
1103:             .Top       = 201
1104:             .Left      = 365
1105:             .Width     = 30
1106:             .Height    = 17
1107:             .AutoSize  = .F.
1108:             .FontName  = "Tahoma"
1109:             .FontSize  = 8
1110:             .ForeColor = RGB(90, 90, 90)
1111:             .BackStyle = 0
1112:             .Visible   = .T.
1113:         ENDWITH
1114: 
1115:         loc_oPg2.AddObject("lbl_4c_LbLibFpgs", "Label")
1116:         WITH loc_oPg2.lbl_4c_LbLibFpgs
1117:             .Caption   = "Liberar Condi" + CHR(231) + CHR(227) + "o Pagto :"
1118:             .Top       = 200
1119:             .Left      = 497
1120:             .Width     = 121
1121:             .Height    = 17
1122:             .AutoSize  = .F.
1123:             .FontName  = "Tahoma"
1124:             .FontSize  = 8

*-- Linhas 1131 a 1157:
1131:         loc_oPg2.AddObject("txt_4c_Libfpgs", "TextBox")
1132:         WITH loc_oPg2.txt_4c_Libfpgs
1133:             .Value         = ""
1134:             .Top           = 196
1135:             .Left          = 619
1136:             .Width         = 20
1137:             .Height        = 21
1138:             .FontName      = "Tahoma"
1139:             .FontSize      = 8
1140:             .ForeColor     = RGB(90, 90, 90)
1141:             .BackColor     = RGB(255, 255, 255)
1142:             .BorderStyle   = 1
1143:             .SpecialEffect = 0
1144:             .MaxLength     = 1
1145:             .Visible       = .T.
1146:         ENDWITH
1147: 
1148:         loc_oPg2.AddObject("lbl_4c_LbLibFpgsSN", "Label")
1149:         WITH loc_oPg2.lbl_4c_LbLibFpgsSN
1150:             .Caption   = "(S/N)"
1151:             .Top       = 200
1152:             .Left      = 642
1153:             .Width     = 35
1154:             .Height    = 17
1155:             .AutoSize  = .F.
1156:             .FontName  = "Tahoma"
1157:             .FontSize  = 8

*-- Linhas 1163 a 1175:
1163:         *======================================================================
1164:         * LINHA 8: Variacao Cotacao + Liberar Movs Estoque
1165:         *======================================================================
1166:         loc_oPg2.AddObject("lbl_4c_LbVarCot", "Label")
1167:         WITH loc_oPg2.lbl_4c_LbVarCot
1168:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o Cota" + CHR(231) + CHR(227) + "o :"
1169:             .Top       = 226
1170:             .Left      = 157
1171:             .Width     = 93
1172:             .Height    = 17
1173:             .AutoSize  = .F.
1174:             .FontName  = "Tahoma"
1175:             .FontSize  = 8

*-- Linhas 1182 a 1191:
1182:         loc_oPg2.AddObject("txt_4c_Varcots", "TextBox")
1183:         WITH loc_oPg2.txt_4c_Varcots
1184:             .Value         = 0
1185:             .Top           = 222
1186:             .Left          = 252
1187:             .Width         = 52
1188:             .Height        = 21
1189:             .FontName      = "Tahoma"
1190:             .FontSize      = 8
1191:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1197 a 1224:
1197:             .Visible       = .T.
1198:         ENDWITH
1199: 
1200:         loc_oPg2.AddObject("lbl_4c_LbVarCotPct", "Label")
1201:         WITH loc_oPg2.lbl_4c_LbVarCotPct
1202:             .Caption   = "(%)"
1203:             .Top       = 226
1204:             .Left      = 309
1205:             .Width     = 25
1206:             .Height    = 17
1207:             .AutoSize  = .F.
1208:             .FontName  = "Tahoma"
1209:             .FontSize  = 8
1210:             .ForeColor = RGB(90, 90, 90)
1211:             .BackStyle = 0
1212:             .Visible   = .T.
1213:         ENDWITH
1214: 
1215:         loc_oPg2.AddObject("lbl_4c_LbLibOpes", "Label")
1216:         WITH loc_oPg2.lbl_4c_LbLibOpes
1217:             .Caption   = "Liberar Movimenta" + CHR(231) + CHR(245) + "es de Estoque :"
1218:             .Top       = 225
1219:             .Left      = 441
1220:             .Width     = 177
1221:             .Height    = 17
1222:             .AutoSize  = .F.
1223:             .FontName  = "Tahoma"
1224:             .FontSize  = 8

*-- Linhas 1231 a 1257:
1231:         loc_oPg2.AddObject("txt_4c_Libopes", "TextBox")
1232:         WITH loc_oPg2.txt_4c_Libopes
1233:             .Value         = ""
1234:             .Top           = 221
1235:             .Left          = 619
1236:             .Width         = 20
1237:             .Height        = 21
1238:             .FontName      = "Tahoma"
1239:             .FontSize      = 8
1240:             .ForeColor     = RGB(90, 90, 90)
1241:             .BackColor     = RGB(255, 255, 255)
1242:             .BorderStyle   = 1
1243:             .SpecialEffect = 0
1244:             .MaxLength     = 1
1245:             .Visible       = .T.
1246:         ENDWITH
1247: 
1248:         loc_oPg2.AddObject("lbl_4c_LbLibOpesSN", "Label")
1249:         WITH loc_oPg2.lbl_4c_LbLibOpesSN
1250:             .Caption   = "(S/N)"
1251:             .Top       = 225
1252:             .Left      = 642
1253:             .Width     = 35
1254:             .Height    = 17
1255:             .AutoSize  = .F.
1256:             .FontName  = "Tahoma"
1257:             .FontSize  = 8

*-- Linhas 1263 a 1275:
1263:         *======================================================================
1264:         * LINHA 9: Grupo Financeiro + Libera Excluir Mov Producao
1265:         *======================================================================
1266:         loc_oPg2.AddObject("lbl_4c_LbGrupo", "Label")
1267:         WITH loc_oPg2.lbl_4c_LbGrupo
1268:             .Caption   = "Grupo Financeiro :"
1269:             .Top       = 251
1270:             .Left      = 160
1271:             .Width     = 90
1272:             .Height    = 17
1273:             .AutoSize  = .F.
1274:             .FontName  = "Tahoma"
1275:             .FontSize  = 8

*-- Linhas 1282 a 1291:
1282:         loc_oPg2.AddObject("txt_4c_Grcomis", "TextBox")
1283:         WITH loc_oPg2.txt_4c_Grcomis
1284:             .Value         = ""
1285:             .Top           = 247
1286:             .Left          = 252
1287:             .Width         = 80
1288:             .Height        = 21
1289:             .FontName      = "Tahoma"
1290:             .FontSize      = 8
1291:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1298 a 1310:
1298: 
1299:         BINDEVENT(loc_oPg2.txt_4c_Grcomis, "KeyPress", THIS, "BuscarGrupoFinan")
1300: 
1301:         loc_oPg2.AddObject("lbl_4c_LbLibExprd", "Label")
1302:         WITH loc_oPg2.lbl_4c_LbLibExprd
1303:             .Caption   = "Libera Excluir Movimenta" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o :"
1304:             .Top       = 250
1305:             .Left      = 410
1306:             .Width     = 208
1307:             .Height    = 17
1308:             .AutoSize  = .F.
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8

*-- Linhas 1317 a 1343:
1317:         loc_oPg2.AddObject("txt_4c_Libexprd", "TextBox")
1318:         WITH loc_oPg2.txt_4c_Libexprd
1319:             .Value         = ""
1320:             .Top           = 246
1321:             .Left          = 619
1322:             .Width         = 20
1323:             .Height        = 21
1324:             .FontName      = "Tahoma"
1325:             .FontSize      = 8
1326:             .ForeColor     = RGB(90, 90, 90)
1327:             .BackColor     = RGB(255, 255, 255)
1328:             .BorderStyle   = 1
1329:             .SpecialEffect = 0
1330:             .MaxLength     = 1
1331:             .Visible       = .T.
1332:         ENDWITH
1333: 
1334:         loc_oPg2.AddObject("lbl_4c_LbLibExprdSN", "Label")
1335:         WITH loc_oPg2.lbl_4c_LbLibExprdSN
1336:             .Caption   = "(S/N)"
1337:             .Top       = 250
1338:             .Left      = 642
1339:             .Width     = 35
1340:             .Height    = 17
1341:             .AutoSize  = .F.
1342:             .FontName  = "Tahoma"
1343:             .FontSize  = 8

*-- Linhas 1349 a 1361:
1349:         *======================================================================
1350:         * LINHA 10: Fator Comissao (tipo S/N + valor %)
1351:         *======================================================================
1352:         loc_oPg2.AddObject("lbl_4c_LbFcomis", "Label")
1353:         WITH loc_oPg2.lbl_4c_LbFcomis
1354:             .Caption   = "Fator de Comiss" + CHR(227) + "o :"
1355:             .Top       = 275
1356:             .Left      = 519
1357:             .Width     = 99
1358:             .Height    = 17
1359:             .AutoSize  = .F.
1360:             .FontName  = "Tahoma"
1361:             .FontSize  = 8

*-- Linhas 1368 a 1394:
1368:         loc_oPg2.AddObject("txt_4c_Fcomis", "TextBox")
1369:         WITH loc_oPg2.txt_4c_Fcomis
1370:             .Value         = ""
1371:             .Top           = 271
1372:             .Left          = 619
1373:             .Width         = 20
1374:             .Height        = 21
1375:             .FontName      = "Tahoma"
1376:             .FontSize      = 8
1377:             .ForeColor     = RGB(90, 90, 90)
1378:             .BackColor     = RGB(255, 255, 255)
1379:             .BorderStyle   = 1
1380:             .SpecialEffect = 0
1381:             .MaxLength     = 1
1382:             .Visible       = .T.
1383:         ENDWITH
1384: 
1385:         loc_oPg2.AddObject("lbl_4c_LbFcomisSN", "Label")
1386:         WITH loc_oPg2.lbl_4c_LbFcomisSN
1387:             .Caption   = "(S/N)"
1388:             .Top       = 275
1389:             .Left      = 642
1390:             .Width     = 35
1391:             .Height    = 17
1392:             .AutoSize  = .F.
1393:             .FontName  = "Tahoma"
1394:             .FontSize  = 8

*-- Linhas 1400 a 1409:
1400:         loc_oPg2.AddObject("txt_4c_Acomis", "TextBox")
1401:         WITH loc_oPg2.txt_4c_Acomis
1402:             .Value         = 0
1403:             .Top           = 271
1404:             .Left          = 680
1405:             .Width         = 52
1406:             .Height        = 21
1407:             .FontName      = "Tahoma"
1408:             .FontSize      = 8
1409:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1417 a 1429:
1417: 
1418:         BINDEVENT(loc_oPg2.txt_4c_Acomis, "KeyPress", THIS, "ValidarAcomis")
1419: 
1420:         loc_oPg2.AddObject("lbl_4c_LbAcomisPct", "Label")
1421:         WITH loc_oPg2.lbl_4c_LbAcomisPct
1422:             .Caption   = "(%)"
1423:             .Top       = 275
1424:             .Left      = 737
1425:             .Width     = 25
1426:             .Height    = 17
1427:             .AutoSize  = .F.
1428:             .FontName  = "Tahoma"
1429:             .FontSize  = 8

*-- Linhas 1437 a 1449:
1437:         *======================================================================
1438: 
1439:         *-- Libera Produtos Bloqueados (libleilaos)
1440:         loc_oPg2.AddObject("lbl_4c_LbLibleilaos", "Label")
1441:         WITH loc_oPg2.lbl_4c_LbLibleilaos
1442:             .Caption   = "Libera Produtos Bloqueados :"
1443:             .Top       = 276
1444:             .Left      = 108
1445:             .Width     = 138
1446:             .Height    = 17
1447:             .AutoSize  = .F.
1448:             .FontName  = "Tahoma"
1449:             .FontSize  = 8

*-- Linhas 1456 a 1500:
1456:         loc_oPg2.AddObject("opt_4c_Libleilaos", "OptionGroup")
1457:         WITH loc_oPg2.opt_4c_Libleilaos
1458:             .ButtonCount = 2
1459:             .Top         = 272
1460:             .Left        = 247
1461:             .Width       = 89
1462:             .Height      = 22
1463:             .AutoSize    = .F.
1464:             .BackStyle   = 0
1465:             .BorderStyle = 0
1466:             .Value       = 2
1467:             .Visible     = .T.
1468:             WITH .Buttons(1)
1469:                 .Caption   = "\<Sim"
1470:                 .Left      = 2
1471:                 .Top       = 3
1472:                 .Width     = 40
1473:                 .Height    = 17
1474:                 .AutoSize  = .F.
1475:                 .BackStyle = 0
1476:                 .ForeColor = RGB(90, 90, 90)
1477:             ENDWITH
1478:             WITH .Buttons(2)
1479:                 .Caption   = "\<N" + CHR(227) + "o"
1480:                 .Left      = 46
1481:                 .Top       = 3
1482:                 .Width     = 40
1483:                 .Height    = 17
1484:                 .AutoSize  = .F.
1485:                 .BackStyle = 0
1486:                 .ForeColor = RGB(90, 90, 90)
1487:             ENDWITH
1488:         ENDWITH
1489: 
1490:         *-- Libera Duplicidade (libdupends)
1491:         loc_oPg2.AddObject("lbl_4c_LbLibdupends", "Label")
1492:         WITH loc_oPg2.lbl_4c_LbLibdupends
1493:             .Caption   = "Libera Duplicidade :"
1494:             .Top       = 296
1495:             .Left      = 155
1496:             .Width     = 91
1497:             .Height    = 17
1498:             .AutoSize  = .F.
1499:             .FontName  = "Tahoma"
1500:             .FontSize  = 8

*-- Linhas 1507 a 1553:
1507:         loc_oPg2.AddObject("opt_4c_Libdupends", "OptionGroup")
1508:         WITH loc_oPg2.opt_4c_Libdupends
1509:             .ButtonCount = 2
1510:             .Top         = 292
1511:             .Left        = 247
1512:             .Width       = 89
1513:             .Height      = 22
1514:             .AutoSize    = .F.
1515:             .BackStyle   = 0
1516:             .BorderStyle = 0
1517:             .Value       = 2
1518:             .Visible     = .T.
1519:             WITH .Buttons(1)
1520:                 .Caption   = "\<Sim"
1521:                 .Left      = 2
1522:                 .Top       = 3
1523:                 .Width     = 40
1524:                 .Height    = 17
1525:                 .AutoSize  = .F.
1526:                 .BackStyle = 0
1527:                 .ForeColor = RGB(90, 90, 90)
1528:             ENDWITH
1529:             WITH .Buttons(2)
1530:                 .Caption   = "\<N" + CHR(227) + "o"
1531:                 .Left      = 46
1532:                 .Top       = 3
1533:                 .Width     = 40
1534:                 .Height    = 17
1535:                 .AutoSize  = .F.
1536:                 .BackStyle = 0
1537:                 .ForeColor = RGB(90, 90, 90)
1538:             ENDWITH
1539:         ENDWITH
1540: 
1541:         *======================================================================
1542:         * LINHA 11: Comissao + Tipo Comissao (direita)
1543:         *======================================================================
1544:         loc_oPg2.AddObject("lbl_4c_LbComis", "Label")
1545:         WITH loc_oPg2.lbl_4c_LbComis
1546:             .Caption   = "Comiss" + CHR(227) + "o :"
1547:             .Top       = 299
1548:             .Left      = 563
1549:             .Width     = 55
1550:             .Height    = 17
1551:             .AutoSize  = .F.
1552:             .FontName  = "Tahoma"
1553:             .FontSize  = 8

*-- Linhas 1560 a 1569:
1560:         loc_oPg2.AddObject("txt_4c_Comis", "TextBox")
1561:         WITH loc_oPg2.txt_4c_Comis
1562:             .Value         = 0
1563:             .Top           = 295
1564:             .Left          = 619
1565:             .Width         = 52
1566:             .Height        = 21
1567:             .FontName      = "Tahoma"
1568:             .FontSize      = 8
1569:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1575 a 1602:
1575:             .Visible       = .T.
1576:         ENDWITH
1577: 
1578:         loc_oPg2.AddObject("lbl_4c_LbComisPct", "Label")
1579:         WITH loc_oPg2.lbl_4c_LbComisPct
1580:             .Caption   = "(%)"
1581:             .Top       = 299
1582:             .Left      = 675
1583:             .Width     = 25
1584:             .Height    = 17
1585:             .AutoSize  = .F.
1586:             .FontName  = "Tahoma"
1587:             .FontSize  = 8
1588:             .ForeColor = RGB(90, 90, 90)
1589:             .BackStyle = 0
1590:             .Visible   = .T.
1591:         ENDWITH
1592: 
1593:         loc_oPg2.AddObject("lbl_4c_LbTpComis", "Label")
1594:         WITH loc_oPg2.lbl_4c_LbTpComis
1595:             .Caption   = "Tipo : "
1596:             .Top       = 296
1597:             .Left      = 719
1598:             .Width     = 32
1599:             .Height    = 17
1600:             .AutoSize  = .F.
1601:             .FontName  = "Tahoma"
1602:             .FontSize  = 8

*-- Linhas 1609 a 1663:
1609:         loc_oPg2.AddObject("opt_4c_Tpcomis", "OptionGroup")
1610:         WITH loc_oPg2.opt_4c_Tpcomis
1611:             .ButtonCount = 3
1612:             .Top         = 292
1613:             .Left        = 749
1614:             .Width       = 141
1615:             .Height      = 21
1616:             .AutoSize    = .F.
1617:             .BackStyle   = 0
1618:             .BorderStyle = 0
1619:             .Value       = 1
1620:             .Visible     = .T.
1621:             WITH .Buttons(1)
1622:                 .Caption   = "Venda"
1623:                 .Left      = 2
1624:                 .Top       = 2
1625:                 .Width     = 44
1626:                 .Height    = 17
1627:                 .AutoSize  = .F.
1628:                 .BackStyle = 0
1629:                 .ForeColor = RGB(90, 90, 90)
1630:             ENDWITH
1631:             WITH .Buttons(2)
1632:                 .Caption   = "Caixa"
1633:                 .Left      = 48
1634:                 .Top       = 2
1635:                 .Width     = 44
1636:                 .Height    = 17
1637:                 .AutoSize  = .F.
1638:                 .BackStyle = 0
1639:                 .ForeColor = RGB(90, 90, 90)
1640:             ENDWITH
1641:             WITH .Buttons(3)
1642:                 .Caption   = "O.S."
1643:                 .Left      = 94
1644:                 .Top       = 2
1645:                 .Width     = 44
1646:                 .Height    = 17
1647:                 .AutoSize  = .F.
1648:                 .BackStyle = 0
1649:                 .ForeColor = RGB(90, 90, 90)
1650:             ENDWITH
1651:         ENDWITH
1652: 
1653:         *-- Libera Variacao de Custo (custoprod)
1654:         loc_oPg2.AddObject("lbl_4c_LbCustoprod", "Label")
1655:         WITH loc_oPg2.lbl_4c_LbCustoprod
1656:             .Caption   = "Libera Varia" + CHR(231) + CHR(227) + "o de Custo :"
1657:             .Top       = 317
1658:             .Left      = 122
1659:             .Width     = 124
1660:             .Height    = 17
1661:             .AutoSize  = .F.
1662:             .FontName  = "Tahoma"
1663:             .FontSize  = 8

*-- Linhas 1670 a 1714:
1670:         loc_oPg2.AddObject("opt_4c_Custoprod", "OptionGroup")
1671:         WITH loc_oPg2.opt_4c_Custoprod
1672:             .ButtonCount = 2
1673:             .Top         = 313
1674:             .Left        = 247
1675:             .Width       = 89
1676:             .Height      = 22
1677:             .AutoSize    = .F.
1678:             .BackStyle   = 0
1679:             .BorderStyle = 0
1680:             .Value       = 2
1681:             .Visible     = .T.
1682:             WITH .Buttons(1)
1683:                 .Caption   = "\<Sim"
1684:                 .Left      = 2
1685:                 .Top       = 3
1686:                 .Width     = 40
1687:                 .Height    = 17
1688:                 .AutoSize  = .F.
1689:                 .BackStyle = 0
1690:                 .ForeColor = RGB(90, 90, 90)
1691:             ENDWITH
1692:             WITH .Buttons(2)
1693:                 .Caption   = "\<N" + CHR(227) + "o"
1694:                 .Left      = 46
1695:                 .Top       = 3
1696:                 .Width     = 40
1697:                 .Height    = 17
1698:                 .AutoSize  = .F.
1699:                 .BackStyle = 0
1700:                 .ForeColor = RGB(90, 90, 90)
1701:             ENDWITH
1702:         ENDWITH
1703: 
1704:         *-- Variacao Mov Dupla (varmovdup)
1705:         loc_oPg2.AddObject("lbl_4c_LbVarMovDup", "Label")
1706:         WITH loc_oPg2.lbl_4c_LbVarMovDup
1707:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o Mov. Dupla :"
1708:             .Top       = 326
1709:             .Left      = 510
1710:             .Width     = 108
1711:             .Height    = 17
1712:             .AutoSize  = .F.
1713:             .FontName  = "Tahoma"
1714:             .FontSize  = 8

*-- Linhas 1721 a 1730:
1721:         loc_oPg2.AddObject("txt_4c_Varmovdup", "TextBox")
1722:         WITH loc_oPg2.txt_4c_Varmovdup
1723:             .Value         = 0
1724:             .Top           = 320
1725:             .Left          = 619
1726:             .Width         = 52
1727:             .Height        = 21
1728:             .FontName      = "Tahoma"
1729:             .FontSize      = 8
1730:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1736 a 1764:
1736:             .Visible       = .T.
1737:         ENDWITH
1738: 
1739:         loc_oPg2.AddObject("lbl_4c_LbVarMovDupPct", "Label")
1740:         WITH loc_oPg2.lbl_4c_LbVarMovDupPct
1741:             .Caption   = "(%)"
1742:             .Top       = 324
1743:             .Left      = 676
1744:             .Width     = 25
1745:             .Height    = 17
1746:             .AutoSize  = .F.
1747:             .FontName  = "Tahoma"
1748:             .FontSize  = 8
1749:             .ForeColor = RGB(90, 90, 90)
1750:             .BackStyle = 0
1751:             .Visible   = .T.
1752:         ENDWITH
1753: 
1754:         *-- Libera Valor Max Malote (libValMMax)
1755:         loc_oPg2.AddObject("lbl_4c_LbLibValmmax", "Label")
1756:         WITH loc_oPg2.lbl_4c_LbLibValmmax
1757:             .Caption   = "Libera Valor Max. Malote :"
1758:             .Top       = 338
1759:             .Left      = 123
1760:             .Width     = 123
1761:             .Height    = 17
1762:             .AutoSize  = .F.
1763:             .FontName  = "Tahoma"
1764:             .FontSize  = 8

*-- Linhas 1771 a 1815:
1771:         loc_oPg2.AddObject("opt_4c_LibValmmax", "OptionGroup")
1772:         WITH loc_oPg2.opt_4c_LibValmmax
1773:             .ButtonCount = 2
1774:             .Top         = 334
1775:             .Left        = 247
1776:             .Width       = 89
1777:             .Height      = 22
1778:             .AutoSize    = .F.
1779:             .BackStyle   = 0
1780:             .BorderStyle = 0
1781:             .Value       = 2
1782:             .Visible     = .T.
1783:             WITH .Buttons(1)
1784:                 .Caption   = "\<Sim"
1785:                 .Left      = 2
1786:                 .Top       = 3
1787:                 .Width     = 40
1788:                 .Height    = 17
1789:                 .AutoSize  = .F.
1790:                 .BackStyle = 0
1791:                 .ForeColor = RGB(90, 90, 90)
1792:             ENDWITH
1793:             WITH .Buttons(2)
1794:                 .Caption   = "\<N" + CHR(227) + "o"
1795:                 .Left      = 46
1796:                 .Top       = 3
1797:                 .Width     = 40
1798:                 .Height    = 17
1799:                 .AutoSize  = .F.
1800:                 .BackStyle = 0
1801:                 .ForeColor = RGB(90, 90, 90)
1802:             ENDWITH
1803:         ENDWITH
1804: 
1805:         *-- Liberar Variacao Mov Dupla (libvmovdup)
1806:         loc_oPg2.AddObject("lbl_4c_LbLibVMovDup", "Label")
1807:         WITH loc_oPg2.lbl_4c_LbLibVMovDup
1808:             .Caption   = "Liberar Varia" + CHR(231) + CHR(227) + "o Mov. Dupla :"
1809:             .Top       = 350
1810:             .Left      = 474
1811:             .Width     = 144
1812:             .Height    = 17
1813:             .AutoSize  = .F.
1814:             .FontName  = "Tahoma"
1815:             .FontSize  = 8

*-- Linhas 1822 a 1864:
1822:         loc_oPg2.AddObject("txt_4c_Libvmovdup", "TextBox")
1823:         WITH loc_oPg2.txt_4c_Libvmovdup
1824:             .Value         = ""
1825:             .Top           = 346
1826:             .Left          = 619
1827:             .Width         = 20
1828:             .Height        = 21
1829:             .FontName      = "Tahoma"
1830:             .FontSize      = 8
1831:             .ForeColor     = RGB(90, 90, 90)
1832:             .BackColor     = RGB(255, 255, 255)
1833:             .BorderStyle   = 1
1834:             .SpecialEffect = 0
1835:             .MaxLength     = 1
1836:             .Visible       = .T.
1837:         ENDWITH
1838: 
1839:         loc_oPg2.AddObject("lbl_4c_LbLibVMovDupSN", "Label")
1840:         WITH loc_oPg2.lbl_4c_LbLibVMovDupSN
1841:             .Caption   = "(S/N)"
1842:             .Top       = 350
1843:             .Left      = 642
1844:             .Width     = 35
1845:             .Height    = 17
1846:             .AutoSize  = .F.
1847:             .FontName  = "Tahoma"
1848:             .FontSize  = 8
1849:             .ForeColor = RGB(90, 90, 90)
1850:             .BackStyle = 0
1851:             .Visible   = .T.
1852:         ENDWITH
1853: 
1854:         *-- Liberar Titulos Iguais (libduptits)
1855:         loc_oPg2.AddObject("lbl_4c_LbLibduptits", "Label")
1856:         WITH loc_oPg2.lbl_4c_LbLibduptits
1857:             .Caption   = "Liberar T" + CHR(237) + "tulos Iguais :"
1858:             .Top       = 356
1859:             .Left      = 142
1860:             .Width     = 104
1861:             .Height    = 17
1862:             .AutoSize  = .F.
1863:             .FontName  = "Tahoma"
1864:             .FontSize  = 8

*-- Linhas 1871 a 1915:
1871:         loc_oPg2.AddObject("opt_4c_Libduptits", "OptionGroup")
1872:         WITH loc_oPg2.opt_4c_Libduptits
1873:             .ButtonCount = 2
1874:             .Top         = 352
1875:             .Left        = 247
1876:             .Width       = 89
1877:             .Height      = 22
1878:             .AutoSize    = .F.
1879:             .BackStyle   = 0
1880:             .BorderStyle = 0
1881:             .Value       = 2
1882:             .Visible     = .T.
1883:             WITH .Buttons(1)
1884:                 .Caption   = "\<Sim"
1885:                 .Left      = 2
1886:                 .Top       = 3
1887:                 .Width     = 40
1888:                 .Height    = 17
1889:                 .AutoSize  = .F.
1890:                 .BackStyle = 0
1891:                 .ForeColor = RGB(90, 90, 90)
1892:             ENDWITH
1893:             WITH .Buttons(2)
1894:                 .Caption   = "\<N" + CHR(227) + "o"
1895:                 .Left      = 46
1896:                 .Top       = 3
1897:                 .Width     = 40
1898:                 .Height    = 17
1899:                 .AutoSize  = .F.
1900:                 .BackStyle = 0
1901:                 .ForeColor = RGB(90, 90, 90)
1902:             ENDWITH
1903:         ENDWITH
1904: 
1905:         *-- Libera Prazo de Entrega (libprzes)
1906:         loc_oPg2.AddObject("lbl_4c_LbLibprzes", "Label")
1907:         WITH loc_oPg2.lbl_4c_LbLibprzes
1908:             .Caption   = "Libera Prazo de Entrega :"
1909:             .Top       = 377
1910:             .Left      = 126
1911:             .Width     = 120
1912:             .Height    = 17
1913:             .AutoSize  = .F.
1914:             .FontName  = "Tahoma"
1915:             .FontSize  = 8

*-- Linhas 1922 a 1966:
1922:         loc_oPg2.AddObject("opt_4c_Libprzes", "OptionGroup")
1923:         WITH loc_oPg2.opt_4c_Libprzes
1924:             .ButtonCount = 2
1925:             .Top         = 373
1926:             .Left        = 247
1927:             .Width       = 89
1928:             .Height      = 22
1929:             .AutoSize    = .F.
1930:             .BackStyle   = 0
1931:             .BorderStyle = 0
1932:             .Value       = 2
1933:             .Visible     = .T.
1934:             WITH .Buttons(1)
1935:                 .Caption   = "\<Sim"
1936:                 .Left      = 2
1937:                 .Top       = 3
1938:                 .Width     = 40
1939:                 .Height    = 17
1940:                 .AutoSize  = .F.
1941:                 .BackStyle = 0
1942:                 .ForeColor = RGB(90, 90, 90)
1943:             ENDWITH
1944:             WITH .Buttons(2)
1945:                 .Caption   = "\<N" + CHR(227) + "o"
1946:                 .Left      = 46
1947:                 .Top       = 3
1948:                 .Width     = 40
1949:                 .Height    = 17
1950:                 .AutoSize  = .F.
1951:                 .BackStyle = 0
1952:                 .ForeColor = RGB(90, 90, 90)
1953:             ENDWITH
1954:         ENDWITH
1955: 
1956:         *-- Libera Consulta de Todos Subniveis (ConsSubn)
1957:         loc_oPg2.AddObject("lbl_4c_LbConsSubn", "Label")
1958:         WITH loc_oPg2.lbl_4c_LbConsSubn
1959:             .Caption   = "Libera Consulta de Todos Subniveis :"
1960:             .Top       = 375
1961:             .Left      = 439
1962:             .Width     = 179
1963:             .Height    = 17
1964:             .AutoSize  = .F.
1965:             .FontName  = "Tahoma"
1966:             .FontSize  = 8

*-- Linhas 1973 a 1999:
1973:         loc_oPg2.AddObject("txt_4c_ConsSubn", "TextBox")
1974:         WITH loc_oPg2.txt_4c_ConsSubn
1975:             .Value         = ""
1976:             .Top           = 371
1977:             .Left          = 619
1978:             .Width         = 20
1979:             .Height        = 21
1980:             .FontName      = "Tahoma"
1981:             .FontSize      = 8
1982:             .ForeColor     = RGB(90, 90, 90)
1983:             .BackColor     = RGB(255, 255, 255)
1984:             .BorderStyle   = 1
1985:             .SpecialEffect = 0
1986:             .MaxLength     = 1
1987:             .Visible       = .T.
1988:         ENDWITH
1989: 
1990:         loc_oPg2.AddObject("lbl_4c_LbConsSubnSN", "Label")
1991:         WITH loc_oPg2.lbl_4c_LbConsSubnSN
1992:             .Caption   = "(S/N)"
1993:             .Top       = 375
1994:             .Left      = 642
1995:             .Width     = 35
1996:             .Height    = 17
1997:             .AutoSize  = .F.
1998:             .FontName  = "Tahoma"
1999:             .FontSize  = 8

*-- Linhas 2005 a 2017:
2005:         *======================================================================
2006:         * SUB-GRADE: Acesso Financeiro (SIGCRRCC)
2007:         *======================================================================
2008:         loc_oPg2.AddObject("lbl_4c_LbGradeAcesso", "Label")
2009:         WITH loc_oPg2.lbl_4c_LbGradeAcesso
2010:             .Caption   = "Liberar Pagamentos por Centro de Custo"
2011:             .Top       = 403
2012:             .Left      = 66
2013:             .Width     = 231
2014:             .Height    = 15
2015:             .AutoSize  = .F.
2016:             .FontName  = "Tahoma"
2017:             .FontSize  = 8

*-- Linhas 2027 a 2036:
2027: 
2028:         loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
2029:         WITH loc_oGridAcesso
2030:             .Top                     = 419
2031:             .Left                    = 66
2032:             .Width                   = 310
2033:             .Height                  = 205
2034:             .FontName                = "Verdana"
2035:             .FontSize                = 8
2036:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 2050 a 2075:
2050:             .Column2.Width           = 85
2051:             .Column3.Width           = 90
2052:             .Column4.Width           = 55
2053:             .Column1.Header1.Caption = "Grupo"
2054:             .Column2.Header1.Caption = "Conta"
2055:             .Column3.Header1.Caption = "Valor"
2056:             .Column4.Header1.Caption = "Moeda"
2057:         ENDWITH
2058: 
2059:         BINDEVENT(loc_oGridAcesso.Column1.Text1, "KeyPress", THIS, "ValidarGrupoGrade")
2060:         BINDEVENT(loc_oGridAcesso.Column2.Text1, "KeyPress", THIS, "ValidarContaGrade")
2061:         BINDEVENT(loc_oGridAcesso.Column4.Text1, "KeyPress", THIS, "ValidarMoedaGrade")
2062: 
2063:         *-- Botoes Inserir/Excluir linhas da grade de acesso
2064:         loc_oPg2.AddObject("cmd_4c_InserirAcesso", "CommandButton")
2065:         WITH loc_oPg2.cmd_4c_InserirAcesso
2066:             .Caption         = "Inserir"
2067:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2068:             .PicturePosition = 13
2069:             .Top             = 482
2070:             .Left            = 380
2071:             .Width           = 45
2072:             .Height          = 45
2073:             .BackColor       = RGB(255, 255, 255)
2074:             .ForeColor       = RGB(90, 90, 90)
2075:             .FontName        = "Tahoma"

*-- Linhas 2081 a 2124:
2081:             .WordWrap        = .T.
2082:             .AutoSize        = .F.
2083:             .Visible         = .T.
2084:         ENDWITH
2085: 
2086:         loc_oPg2.AddObject("cmd_4c_ExcluirAcesso", "CommandButton")
2087:         WITH loc_oPg2.cmd_4c_ExcluirAcesso
2088:             .Caption         = "Excluir"
2089:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2090:             .PicturePosition = 13
2091:             .Top             = 527
2092:             .Left            = 380
2093:             .Width           = 45
2094:             .Height          = 45
2095:             .BackColor       = RGB(255, 255, 255)
2096:             .ForeColor       = RGB(90, 90, 90)
2097:             .FontName        = "Tahoma"
2098:             .FontSize        = 7
2099:             .FontBold        = .T.
2100:             .Themes          = .F.
2101:             .SpecialEffect   = 0
2102:             .MousePointer    = 15
2103:             .WordWrap        = .T.
2104:             .AutoSize        = .F.
2105:             .Visible         = .T.
2106:         ENDWITH
2107: 
2108:         BINDEVENT(loc_oPg2.cmd_4c_InserirAcesso, "Click", THIS, "BtnInserirAcessoClick")
2109:         BINDEVENT(loc_oPg2.cmd_4c_ExcluirAcesso, "Click", THIS, "BtnExcluirAcessoClick")
2110: 
2111:         *======================================================================
2112:         * SUB-GRADE: Categorias (sigcarct + sigcdctg)
2113:         *======================================================================
2114:         loc_oPg2.AddObject("lbl_4c_LbGradeCat", "Label")
2115:         WITH loc_oPg2.lbl_4c_LbGradeCat
2116:             .Caption   = "Categorias"
2117:             .Top       = 403
2118:             .Left      = 509
2119:             .Width     = 63
2120:             .Height    = 15
2121:             .AutoSize  = .F.
2122:             .FontName  = "Tahoma"
2123:             .FontSize  = 8
2124:             .FontBold  = .T.

*-- Linhas 2133 a 2142:
2133: 
2134:         loc_oGridCat = loc_oPg2.grd_4c_Categorias
2135:         WITH loc_oGridCat
2136:             .Top                     = 419
2137:             .Left                    = 509
2138:             .Width                   = 310
2139:             .Height                  = 205
2140:             .FontName                = "Verdana"
2141:             .FontSize                = 8
2142:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 2155 a 2179:
2155:             .Column1.Width           = 60
2156:             .Column2.Width           = 170
2157:             .Column3.Width           = 75
2158:             .Column1.Header1.Caption = "Categoria"
2159:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2160:             .Column3.Header1.Caption = "Validar"
2161:             .Column2.ReadOnly        = .T.
2162:         ENDWITH
2163: 
2164:         BINDEVENT(loc_oGridCat.Column1.Text1, "KeyPress", THIS, "ValidarCategoriaGrade")
2165:         BINDEVENT(loc_oGridCat.Column3.Text1, "KeyPress", THIS, "ValidarTipoCategoria")
2166: 
2167:         *-- Botoes Inserir/Excluir linhas da grade de categorias
2168:         loc_oPg2.AddObject("cmd_4c_InserirCat", "CommandButton")
2169:         WITH loc_oPg2.cmd_4c_InserirCat
2170:             .Caption         = "Inserir"
2171:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2172:             .PicturePosition = 13
2173:             .Top             = 482
2174:             .Left            = 380
2175:             .Width           = 45
2176:             .Height          = 45
2177:             .BackColor       = RGB(255, 255, 255)
2178:             .ForeColor       = RGB(90, 90, 90)
2179:             .FontName        = "Tahoma"

*-- Linhas 2187 a 2201:
2187:             .Visible         = .T.
2188:         ENDWITH
2189: 
2190:         loc_oPg2.AddObject("cmd_4c_ExcluirCat", "CommandButton")
2191:         WITH loc_oPg2.cmd_4c_ExcluirCat
2192:             .Caption         = "Excluir"
2193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2194:             .PicturePosition = 13
2195:             .Top             = 528
2196:             .Left            = 823
2197:             .Width           = 45
2198:             .Height          = 45
2199:             .BackColor       = RGB(255, 255, 255)
2200:             .ForeColor       = RGB(90, 90, 90)
2201:             .FontName        = "Tahoma"

*-- Linhas 2209 a 2218:
2209:             .Visible         = .T.
2210:         ENDWITH
2211: 
2212:         BINDEVENT(loc_oPg2.cmd_4c_InserirCat, "Click", THIS, "BtnInserirCatClick")
2213:         BINDEVENT(loc_oPg2.cmd_4c_ExcluirCat, "Click", THIS, "BtnExcluirCatClick")
2214: 
2215:         THIS.TornarControlesVisiveis(loc_oPg2)
2216:     ENDPROC
2217: 
2218:     *--------------------------------------------------------------------------

*-- Linhas 2244 a 2253:
2244:                         loc_oGrid.Column1.ReadOnly = .T.
2245:                         loc_oGrid.Column2.ReadOnly = .T.
2246: 
2247:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2248:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2249: 
2250:                         THIS.FormatarGridLista(loc_oGrid)
2251:                     ENDIF
2252:                     loc_lResultado = .T.
2253:                 ENDIF

*-- Linhas 2277 a 2288:
2277:                     loc_oGridAcesso.Column2.ControlSource = "cursor_4c_AcessoFinan.contas"
2278:                     loc_oGridAcesso.Column3.ControlSource = "cursor_4c_AcessoFinan.valors"
2279:                     loc_oGridAcesso.Column4.ControlSource = "cursor_4c_AcessoFinan.moedas"
2280:                     loc_oGridAcesso.Column1.Header1.Caption = "Grupo"
2281:                     loc_oGridAcesso.Column2.Header1.Caption = "Conta"
2282:                     loc_oGridAcesso.Column3.Header1.Caption = "Valor"
2283:                     loc_oGridAcesso.Column4.Header1.Caption = "Moeda"
2284:                     loc_oGridAcesso.Refresh
2285:                 ENDIF
2286:             ENDIF
2287: 
2288:             *-- Grid categorias

*-- Linhas 2294 a 2304:
2294:                     loc_oGridCat.Column1.ControlSource = "cursor_4c_Categorias.categoria"
2295:                     loc_oGridCat.Column2.ControlSource = "cursor_4c_Categorias.descs"
2296:                     loc_oGridCat.Column3.ControlSource = "cursor_4c_Categorias.tipo"
2297:                     loc_oGridCat.Column1.Header1.Caption = "Categoria"
2298:                     loc_oGridCat.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2299:                     loc_oGridCat.Column3.Header1.Caption = "Validar"
2300:                     loc_oGridCat.Refresh
2301:                 ENDIF
2302:             ENDIF
2303:         CATCH TO loc_oErro
2304:             MsgErro(loc_oErro.Message, "FormCargo.CarregarGrades")

*-- Linhas 2904 a 2912:
2904:             *-- Codigo do cargo: apenas em INCLUIR e BUSCAR
2905:             loc_lCodHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
2906:             loc_oPg2.txt_4c_Ccargs.Enabled     = loc_lCodHabilitar
2907:             loc_oPg2.cmd_4c_BuscarBase.Enabled = (THIS.this_cModoAtual = "INCLUIR")
2908: 
2909:             *-- Demais campos
2910:             loc_oPg2.txt_4c_Dcargs.Enabled     = par_lHabilitar
2911:             loc_oPg2.txt_4c_Limdescs.Enabled   = par_lHabilitar
2912:             loc_oPg2.txt_4c_Descpors.Enabled   = par_lHabilitar

*-- Linhas 2949 a 2983:
2949:             ENDIF
2950: 
2951:             *-- Botoes das sub-grades
2952:             IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirAcesso", 5)
2953:                 loc_oPg2.cmd_4c_InserirAcesso.Enabled = par_lHabilitar
2954:             ENDIF
2955:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirAcesso", 5)
2956:                 loc_oPg2.cmd_4c_ExcluirAcesso.Enabled = par_lHabilitar
2957:             ENDIF
2958:             IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirCat", 5)
2959:                 loc_oPg2.cmd_4c_InserirCat.Enabled = par_lHabilitar
2960:             ENDIF
2961:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirCat", 5)
2962:                 loc_oPg2.cmd_4c_ExcluirCat.Enabled = par_lHabilitar
2963:             ENDIF
2964:         CATCH TO loc_oErro
2965:             MsgErro(loc_oErro.Message, "FormCargo.HabilitarCampos")
2966:         ENDTRY
2967:     ENDPROC
2968: 
2969:     *--------------------------------------------------------------------------
2970:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo
2971:     *--------------------------------------------------------------------------
2972:     PROCEDURE AjustarBotoesPorModo()
2973:         LOCAL loc_oBotoesAcao
2974:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2975: 
2976:         TRY
2977:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
2978:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2979:         CATCH TO loc_oErro
2980:             MsgErro(loc_oErro.Message, "FormCargo.AjustarBotoesPorModo")
2981:         ENDTRY
2982:     ENDPROC
2983: 


### BO (C:\4c\projeto\app\classes\CargoBO.prg):
*====================================================================
* CargoBO.prg
*
* Business Object para Cargos
* Tabela principal: SIGCDCRG (ccargs PK)
* Sub-tabelas: SIGCRRCC (acesso financeiro), sigcarct (categorias)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CargoBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDCRG)
	this_cCcargs      = ""   && ccargs char(10)      - PK (codigo do cargo)
	this_cDcargs      = ""   && dcargs char(20)       - descricao
	this_nAcrepors    = 0    && acrepors numeric(9,2) - acrescimo %
	this_cAltcots     = ""   && altcots char(1)       - altera cotacao (S/N)
	this_nComis       = 0    && comis numeric(5,2)    - comissao %
	this_dDatatrans   = {}   && datatrans datetime    - data transacao (NULL)
	this_nDescpors    = 0    && descpors numeric(9,2) - desconto %
	this_nLimacres    = 0    && limacres numeric(11,2) - limite acrescimo (R$)
	this_nLimdescs    = 0    && limdescs numeric(11,2) - limite desconto (R$)
	this_cNivels      = ""   && nivels char(1)        - senha (S/N)
	this_nVarcots     = 0    && varcots numeric(5,2)  - variacao cotacao %
	this_cLimites     = ""   && limites char(1)       - libera limite (S/N)
	this_nAcomis      = 0    && acomis numeric(5,2)   - fator de comissao %
	this_cFcomis      = ""   && fcomis char(1)        - tipo comissao S/N
	this_cCancitens   = ""   && cancitens char(1)     - cancela item cupom fiscal (S/N)
	this_nVllibpgs    = 0    && vllibpgs numeric(11,2) - valor liberar pagamentos (R$)
	this_cLibfpags    = ""   && libfpags char(1)      - excluir cond. pagto ecf (S/N)
	this_cLibsdins    = ""   && libsdins char(1)      - libera saldo insuficiente (S/N)
	this_nVllibcots   = 0    && vllibcots numeric(11,2) - valor liberar cotacoes (R$)
	this_nVllibopes   = 0    && vllibopes numeric(11,2) - valor liberar movimentacoes (R$)
	this_cLibfpgs     = ""   && libfpgs char(1)       - libera condicao pagto (S/N)
	this_cLibopes     = ""   && libopes char(1)       - liberar movim. estoque (S/N)
	this_cGrcomis     = ""   && grcomis char(10)      - grupo financeiro
	this_nTpcomis     = 0    && tpcomis numeric(1,0)  - tipo comissao (OptionGroup)
	this_nLibleilaos  = 0    && libleilaos numeric(1,0) - libera leilao (OptionGroup)
	this_nLibdupends  = 0    && libdupends numeric(1,0) - libera duplicidade (OptionGroup)
	this_nLibduptits  = 0    && libduptits numeric(1,0) - liberar titulos iguais (OptionGroup)
	this_nLibprzes    = 0    && libprzes numeric(1,0) - liberar prazo entrega (OptionGroup)
	this_nLibsldtqe   = 0    && libsldtqe numeric(1,0) - libera saldo cotacao (OptionGroup)
	this_cLibaltcli   = ""   && libaltcli char(1)     - libera alterar cliente (S/N)
	this_cLibexprd    = ""   && libexprd char(1)      - libera excluir mov. producao (S/N)
	this_nCustoprod   = 0    && custoprod numeric(1,0) - custo producao (OptionGroup)
	this_cLibvmovdup  = ""   && libvmovdup char(1)    - liberar variacao mov dupla (S/N)
	this_nVarmovdup   = 0    && varmovdup numeric(5,2) - variacao mov dupla %
	this_cLibopers    = ""   && libopers char(1)      - liberar operacoes (S/N)
	this_cLibvarpeso  = ""   && libvarpeso char(1)    - liberar variacao peso (S/N)
	this_nLibmultvends = 0   && libmultvends numeric(1,0) - libera multi-vendas (OptionGroup)
	this_nAltvlpro    = 0    && altvlpro numeric(1,0) - altera valor producao (OptionGroup)

	*-- Colunas adicionais presentes no banco (nao no schema dump inicial)
	this_cConsSubn    = ""   && ConsSubn char(1)      - libera consulta todos subniveis (S/N)
	this_nLibValmmax  = 0    && libValMMax numeric(1,0) - libera valor max malote (OptionGroup)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCRG"
		THIS.this_cCampoChave = "ccargs"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCcargs)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de cargos no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG ORDER BY ccargs"
			ELSE
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG" + ;
				           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY ccargs"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar cargos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar cargos:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT acrepors, altcots, ccargs, comis, datatrans," + ;
			           " dcargs, descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs, libfpags," + ;
			           " libsdins, vllibcots, vllibopes, libfpgs, libopes, grcomis," + ;
			           " tpcomis, libleilaos, libdupends, libduptits, libprzes," + ;
			           " libsldtqe, libaltcli, libexprd, custoprod, libvmovdup," + ;
			           " varmovdup, libopers, libvarpeso, libmultvends, altvlpro" + ;
			           " FROM SIGCDCRG" + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
				IF loc_lSucesso
					THIS.CarregarSubTabelaAcessoFinan(par_cCcargs)
					THIS.CarregarSubTabelaCategorias(par_cCcargs)
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCcargs       = TratarNulo(ccargs, "C")
			THIS.this_cDcargs       = TratarNulo(dcargs, "C")
			THIS.this_nAcrepors     = TratarNulo(acrepors, "N")
			THIS.this_cAltcots      = TratarNulo(altcots, "C")
			THIS.this_nComis        = TratarNulo(comis, "N")
			THIS.this_nDescpors     = TratarNulo(descpors, "N")
			THIS.this_nLimacres     = TratarNulo(limacres, "N")
			THIS.this_nLimdescs     = TratarNulo(limdescs, "N")
			THIS.this_cNivels       = TratarNulo(nivels, "C")
			THIS.this_nVarcots      = TratarNulo(varcots, "N")
			THIS.this_cLimites      = TratarNulo(limites, "C")
			THIS.this_nAcomis       = TratarNulo(acomis, "N")
			THIS.this_cFcomis       = TratarNulo(fcomis, "C")
			THIS.this_cCancitens    = TratarNulo(cancitens, "C")
			THIS.this_nVllibpgs     = TratarNulo(vllibpgs, "N")
			THIS.this_cLibfpags     = TratarNulo(libfpags, "C")
			THIS.this_cLibsdins     = TratarNulo(libsdins, "C")
			THIS.this_nVllibcots    = TratarNulo(vllibcots, "N")
			THIS.this_nVllibopes    = TratarNulo(vllibopes, "N")
			THIS.this_cLibfpgs      = TratarNulo(libfpgs, "C")
			THIS.this_cLibopes      = TratarNulo(libopes, "C")
			THIS.this_cGrcomis      = TratarNulo(grcomis, "C")
			THIS.this_nTpcomis      = TratarNulo(tpcomis, "N")
			THIS.this_nLibleilaos   = TratarNulo(libleilaos, "N")
			THIS.this_nLibdupends   = TratarNulo(libdupends, "N")
			THIS.this_nLibduptits   = TratarNulo(libduptits, "N")
			THIS.this_nLibprzes     = TratarNulo(libprzes, "N")
			THIS.this_nLibsldtqe    = TratarNulo(libsldtqe, "N")
			THIS.this_cLibaltcli    = TratarNulo(libaltcli, "C")
			THIS.this_cLibexprd     = TratarNulo(libexprd, "C")
			THIS.this_nCustoprod    = TratarNulo(custoprod, "N")
			THIS.this_cLibvmovdup   = TratarNulo(libvmovdup, "C")
			THIS.this_nVarmovdup    = TratarNulo(varmovdup, "N")
			THIS.this_cLibopers     = TratarNulo(libopers, "C")
			THIS.this_cLibvarpeso   = TratarNulo(libvarpeso, "C")
			THIS.this_nLibmultvends = TratarNulo(libmultvends, "N")
			THIS.this_nAltvlpro     = TratarNulo(altvlpro, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaAcessoFinan - Carrega acesso financeiro (SIGCRRCC)
	*====================================================================
	PROCEDURE CarregarSubTabelaAcessoFinan(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_AcessoFinan")
				USE IN cursor_4c_AcessoFinan
			ENDIF

			loc_cSQL = "SELECT grupos, contas, valors, moedas FROM SIGCRRCC" + ;
			           " WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY grupos, contas"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessoFinan")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaCategorias - Carrega categorias (sigcarct + sigcdctg)
	*====================================================================
	PROCEDURE CarregarSubTabelaCategorias(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Categorias")
				USE IN cursor_4c_Categorias
			ENDIF

			loc_cSQL = "SELECT a.categoria, ISNULL(b.descs, '') AS descs, a.tipo, a.cargo" + ;
			           " FROM sigcarct a" + ;
			           " LEFT JOIN sigcdctg b ON RTRIM(b.cods) = RTRIM(a.categoria)" + ;
			           " WHERE RTRIM(a.cargo) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY a.categoria"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Categorias")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarCursoresGrid - Cria cursores vazios para grids em INCLUIR
	*====================================================================
	PROCEDURE InicializarCursoresGrid()
		IF USED("cursor_4c_AcessoFinan")
			USE IN cursor_4c_AcessoFinan
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_AcessoFinan (grupos C(10), contas C(10), valors N(13,2), moedas C(3))
		SET NULL OFF

		IF USED("cursor_4c_Categorias")
			USE IN cursor_4c_Categorias
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_Categorias (categoria C(6), descs C(30), tipo C(10), cargo C(10))
		SET NULL OFF
	ENDPROC

	*====================================================================
	* SalvarSubTabelaAcessoFinan - Salva acesso financeiro (SIGCRRCC)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaAcessoFinan()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_AcessoFinan") AND RECCOUNT("cursor_4c_AcessoFinan") > 0
					GO TOP IN cursor_4c_AcessoFinan
					SELECT cursor_4c_AcessoFinan
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.grupos)) .OR. ;
						   !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.contas))
							loc_cCidchaves = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO SIGCRRCC (cargos, cidchaves, grupos, contas, valors, moedas)" + ;
							           " VALUES (" + ;
							           EscaparSQL(THIS.this_cCcargs) + "," + ;
							           EscaparSQL(loc_cCidchaves) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.grupos) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.contas) + "," + ;
							           FormatarNumeroSQL(cursor_4c_AcessoFinan.valors) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.moedas) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarSubTabelaCategorias - Salva categorias (sigcarct)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaCategorias()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChave
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_Categorias") AND RECCOUNT("cursor_4c_Categorias") > 0
					GO TOP IN cursor_4c_Categorias
					SELECT cursor_4c_Categorias
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_Categorias.categoria))
							loc_cPkChave = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO sigcarct (categoria, pkchave, tipo, cargo)" + ;
							           " VALUES (" + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.categoria), 6)) + "," + ;
							           EscaparSQL(loc_cPkChave) + "," + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.tipo), 10)) + "," + ;
							           EscaparSQL(THIS.this_cCcargs) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SIGCDCRG" + ;
			           " (ccargs, dcargs, acrepors, altcots, comis," + ;
			           " descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs," + ;
			           " libfpags, libsdins, vllibcots, vllibopes, libfpgs," + ;
			           " libopes, grcomis, tpcomis, libleilaos, libdupends," + ;
			           " libduptits, libprzes, libsldtqe, libaltcli, libexprd," + ;
			           " custoprod, libvmovdup, varmovdup, libopers, libvarpeso," + ;
			           " libmultvends, altvlpro, ConsSubn, libValMMax)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCcargs) + "," + ;
			           EscaparSQL(THIS.this_cDcargs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           EscaparSQL(THIS.this_cAltcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           EscaparSQL(THIS.this_cNivels) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           EscaparSQL(THIS.this_cLimites) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           EscaparSQL(THIS.this_cFcomis) + "," + ;
			           EscaparSQL(THIS.this_cCancitens) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibopes) + "," + ;
			           EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           EscaparSQL(THIS.this_cLibopers) + "," + ;
			           EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
			           EscaparSQL(THIS.this_cConsSubn) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCRG SET" + ;
			           " dcargs = " + EscaparSQL(THIS.this_cDcargs) + "," + ;
			           " acrepors = " + FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           " altcots = " + EscaparSQL(THIS.this_cAltcots) + "," + ;
			           " comis = " + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           " descpors = " + FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           " limacres = " + FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           " limdescs = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
			           " varcots = " + FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           " limites = " + EscaparSQL(THIS.this_cLimites) + "," + ;
			           " acomis = " + FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           " fcomis = " + EscaparSQL(THIS.this_cFcomis) + "," + ;
			           " cancitens = " + EscaparSQL(THIS.this_cCancitens) + "," + ;
			           " vllibpgs = " + FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           " libfpags = " + EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           " libsdins = " + EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           " vllibcots = " + FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           " vllibopes = " + FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           " libfpgs = " + EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           " libopes = " + EscaparSQL(THIS.this_cLibopes) + "," + ;
			           " grcomis = " + EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           " tpcomis = " + FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           " libleilaos = " + FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           " libdupends = " + FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           " libduptits = " + FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           " libprzes = " + FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           " libsldtqe = " + FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           " libaltcli = " + EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           " libexprd = " + EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           " custoprod = " + FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           " libvmovdup = " + EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           " varmovdup = " + FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           " libopers = " + EscaparSQL(THIS.this_cLibopers) + "," + ;
			           " libvarpeso = " + EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           " libmultvends = " + FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           " altvlpro = " + FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
			           " ConsSubn = " + EscaparSQL(THIS.this_cConsSubn) + "," + ;
			           " libValMMax = " + FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE SIGCRRCC + sigcarct + SIGCDCRG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- 1. Excluir acesso financeiro (SIGCRRCC)
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- 2. Excluir categorias (sigcarct)
				loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					MsgErro("Erro ao excluir categorias do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Excluir registro principal (SIGCDCRG)
					loc_cSQL = "DELETE FROM SIGCDCRG WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao excluir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

