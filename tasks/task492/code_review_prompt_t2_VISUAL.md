# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'Opt_CampoNf' (parent: SIGCDOTI.Pagina.Dados): Left original=136 vs migrado 'obj_4c_Opt_CampoNf' Left=683 (diff=547px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnPastasC' (parent: SIGCDOTI.Pagina.Dados): Left original=538 vs migrado 'cmd_4c_BtnPastasCl' Left=723 (diff=185px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOTI.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4435 linhas total):

*-- Linhas 44 a 64:
44:         loc_lResultado = .F.
45: 
46:         TRY
47:             THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"
48: 
49:             THIS.this_oBusinessObject = CREATEOBJECT("OTIBO")
50: 
51:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
52:                 MsgErro("Erro ao instanciar OTIBO.", "FormOTI")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57: 
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarLista()
63:                 ENDIF
64: 

*-- Linhas 85 a 107:
85:         loc_oPgf = THIS.pgf_4c_Paginas
86: 
87:         loc_oPgf.PageCount = 2
88:         loc_oPgf.Top       = -29
89:         loc_oPgf.Left      = 0
90:         loc_oPgf.Width     = THIS.Width
91:         loc_oPgf.Height    = THIS.Height
92:         loc_oPgf.Tabs      = .F.
93:         loc_oPgf.TabStyle  = 0
94:         loc_oPgf.Visible   = .T.
95: 
96:         WITH loc_oPgf.Page1
97:             .Caption = "Lista"
98:             .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:         ENDWITH
100: 
101:         WITH loc_oPgf.Page2
102:             .Caption = "Dados"
103:             .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105:     ENDPROC
106: 
107:     *==========================================================================

*-- Linhas 118 a 157:
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPagina.cnt_4c_Cabecalho
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
132:             .Top       = 16
133:             .Left      = 11
134:             .Width     = 869
135:             .Height    = 46
136:             .Caption   = THIS.Caption
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .Alignment = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .Top       = 15
149:             .Left      = 10
150:             .Width     = 869
151:             .Height    = 46
152:             .Caption   = THIS.Caption
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.
156:             .ForeColor = RGB(255, 255, 255)
157:             .BackStyle = 0

*-- Linhas 163 a 185:
163:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
164:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
165:         WITH loc_oCnt
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackStyle   = 1
171:             .BackColor   = RGB(53, 53, 53)
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oCnt.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Top             = 5
180:             .Left            = 5
181:             .Width           = 75
182:             .Height          = 75
183:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
184:             .PicturePosition = 13
185:             .FontName        = "Tahoma"

*-- Linhas 195 a 209:
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
199: 
200:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oCnt.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
208:             .PicturePosition = 13
209:             .FontName        = "Tahoma"

*-- Linhas 219 a 233:
219:             .AutoSize        = .F.
220:             .Visible         = .T.
221:         ENDWITH
222:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
223: 
224:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oCnt.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
232:             .PicturePosition = 13
233:             .FontName        = "Tahoma"

*-- Linhas 243 a 257:
243:             .AutoSize        = .F.
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oCnt.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
256:             .PicturePosition = 13
257:             .FontName        = "Tahoma"

*-- Linhas 267 a 281:
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
271: 
272:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
273:         WITH loc_oCnt.cmd_4c_Buscar
274:             .Caption         = "Buscar"
275:             .Top             = 5
276:             .Left            = 305
277:             .Width           = 75
278:             .Height          = 75
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
280:             .PicturePosition = 13
281:             .FontName        = "Tahoma"

*-- Linhas 291 a 317:
291:             .AutoSize        = .F.
292:             .Visible         = .T.
293:         ENDWITH
294:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container saida (padrao canonico)
297:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
298:         WITH loc_oPagina.cnt_4c_Saida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
310:             .Caption         = "Encerrar"
311:             .Top             = 5
312:             .Left            = 5
313:             .Width           = 75
314:             .Height          = 75
315:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
316:             .PicturePosition = 13
317:             .FontName        = "Tahoma"

*-- Linhas 327 a 341:
327:             .AutoSize        = .F.
328:             .Visible         = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
331: 
332:         *-- Grid de listagem
333:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
334:         loc_oGrid = loc_oPagina.grd_4c_Lista
335:         loc_oGrid.Top         = 117
336:         loc_oGrid.Left        = 12
337:         loc_oGrid.Width       = 895
338:         loc_oGrid.Height      = 483
339:         loc_oGrid.ColumnCount = 3
340:         WITH loc_oGrid
341:             .FontName           = "Verdana"

*-- Linhas 358 a 380:
358:         WITH loc_oGrid.Column1
359:             .Width           = 60
360:             .Alignment       = 0
361:             .Header1.Caption = "N" + CHR(186)
362:             .Resizable       = .T.
363:         ENDWITH
364: 
365:         WITH loc_oGrid.Column2
366:             .Width           = 250
367:             .Alignment       = 0
368:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
369:             .Resizable       = .T.
370:         ENDWITH
371: 
372:         WITH loc_oGrid.Column3
373:             .Width           = 80
374:             .Alignment       = 0
375:             .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
376:             .Resizable       = .T.
377:         ENDWITH
378: 
379:         THIS.TornarControlesVisiveis(loc_oPagina)
380:     ENDPROC

*-- Linhas 394 a 415:
394:         *----------------------------------------------------------------------
395:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
396:         WITH loc_oPagina.cnt_4c_BotoesAcao
397:             .Top         = 33
398:             .Left        = 842
399:             .Width       = 160
400:             .Height      = 85
401:             .BackStyle   = 0
402:             .BorderWidth = 0
403:             .Visible     = .T.
404:         ENDWITH
405: 
406:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
408:             .Caption         = "Confirmar"
409:             .Top             = 5
410:             .Left            = 5
411:             .Width           = 75
412:             .Height          = 75
413:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
414:             .PicturePosition = 13
415:             .FontName        = "Tahoma"

*-- Linhas 425 a 439:
425:             .AutoSize        = .F.
426:             .Visible         = .T.
427:         ENDWITH
428:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
429: 
430:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
431:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
432:             .Caption         = "Encerrar"
433:             .Top             = 5
434:             .Left            = 80
435:             .Width           = 75
436:             .Height          = 75
437:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
438:             .PicturePosition = 13
439:             .FontName        = "Tahoma"

*-- Linhas 449 a 599:
449:             .AutoSize        = .F.
450:             .Visible         = .T.
451:         ENDWITH
452:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
453: 
454:         *----------------------------------------------------------------------
455:         *-- Linha 1: N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o (readonly) + Descri" + CHR(231) + CHR(227) + "o + Cancelamento
456:         *----------------------------------------------------------------------
457: 
458:         loc_oPagina.AddObject("txt_4c_Ndope", "TextBox")
459:         WITH loc_oPagina.txt_4c_Ndope
460:             .Value    = 0
461:             .Top      = 65
462:             .Left     = 688
463:             .Width    = 80
464:             .Height   = 23
465:             .ReadOnly = .T.
466:             .Enabled  = .T.
467:             .FontName = "Tahoma"
468:             .FontSize = 8
469:             .Visible  = .T.
470:         ENDWITH
471: 
472:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
473:         WITH loc_oPagina.lbl_4c_Label3
474:             .Caption   = "N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o :"
475:             .Top       = 69
476:             .Left      = 605
477:             .Width     = 80
478:             .Height    = 15
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .BackStyle = 0
482:             .Visible   = .T.
483:         ENDWITH
484: 
485:         loc_oPagina.AddObject("chk_4c_Chk_Inativar", "CheckBox")
486:         WITH loc_oPagina.chk_4c_Chk_Inativar
487:             .Caption   = "Cancelamento"
488:             .Top       = 70
489:             .Left      = 298
490:             .Width     = 99
491:             .Height    = 15
492:             .Value     = 0
493:             .FontName  = "Tahoma"
494:             .FontSize  = 8
495:             .BackStyle = 0
496:             .Visible   = .T.
497:         ENDWITH
498:         BINDEVENT(loc_oPagina.chk_4c_Chk_Inativar, "InteractiveChange", THIS, "ChkInativarChanged")
499: 
500:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
501:         WITH loc_oPagina.lbl_4c_Label1
502:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
503:             .Top       = 71
504:             .Left      = 73
505:             .Width     = 63
506:             .Height    = 15
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .BackStyle = 0
510:             .Visible   = .T.
511:         ENDWITH
512: 
513:         loc_oPagina.AddObject("txt_4c_Dope", "TextBox")
514:         WITH loc_oPagina.txt_4c_Dope
515:             .Value     = ""
516:             .Top       = 67
517:             .Left      = 140
518:             .Width     = 150
519:             .Height    = 23
520:             .MaxLength = 50
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         *----------------------------------------------------------------------
527:         *-- Linha 2: Opera" + CHR(231) + CHR(227) + "o CR/DB + Opera" + CHR(231) + CHR(227) + "o de Dep" + CHR(243) + "sito
528:         *----------------------------------------------------------------------
529: 
530:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
531:         WITH loc_oPagina.lbl_4c_Label2
532:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
533:             .Top       = 93
534:             .Left      = 77
535:             .Width     = 59
536:             .Height    = 15
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .BackStyle = 0
540:             .Visible   = .T.
541:         ENDWITH
542: 
543:         loc_oPagina.AddObject("obj_4c_Opcao_oper", "OptionGroup")
544:         WITH loc_oPagina.obj_4c_Opcao_oper
545:             .ButtonCount = 2
546:             .Top         = 90
547:             .Left        = 135
548:             .Width       = 142
549:             .Height      = 21
550:             .BackStyle   = 0
551:             .BorderStyle = 0
552:             .Visible     = .T.
553:         ENDWITH
554:         WITH loc_oPagina.obj_4c_Opcao_oper.Buttons(1)
555:             .Caption   = "Cr" + CHR(233) + "dito"
556:             .BackStyle = 0
557:             .Left      = 5
558:             .Top       = 3
559:             .Width     = 62
560:             .AutoSize  = .F.
561:             .ForeColor = RGB(90, 90, 90)
562:             .FontName  = "Tahoma"
563:             .FontSize  = 8
564:         ENDWITH
565:         WITH loc_oPagina.obj_4c_Opcao_oper.Buttons(2)
566:             .Caption   = "D" + CHR(233) + "bito"
567:             .BackStyle = 0
568:             .Left      = 70
569:             .Top       = 3
570:             .Width     = 62
571:             .AutoSize  = .F.
572:             .ForeColor = RGB(90, 90, 90)
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:         ENDWITH
576: 
577:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
578:         WITH loc_oPagina.lbl_4c_Label4
579:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Dep" + CHR(243) + "sito :"
580:             .Top       = 94
581:             .Left      = 567
582:             .Width     = 116
583:             .Height    = 15
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .BackStyle = 0
587:             .Visible   = .T.
588:         ENDWITH
589: 
590:         loc_oPagina.AddObject("txt_4c_Opdepo", "TextBox")
591:         WITH loc_oPagina.txt_4c_Opdepo
592:             .Value     = ""
593:             .Top       = 90
594:             .Left      = 688
595:             .Width     = 80
596:             .Height    = 23
597:             .MaxLength = 10
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8

*-- Linhas 605 a 1189:
605:         *-- Linha 3: Hist" + CHR(243) + "rico Padr" + CHR(227) + "o + Pend" + CHR(234) + "ncias
606:         *----------------------------------------------------------------------
607: 
608:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
609:         WITH loc_oPagina.lbl_4c_Label5
610:             .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o :"
611:             .Top       = 113
612:             .Left      = 49
613:             .Width     = 87
614:             .Height    = 15
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8
617:             .BackStyle = 0
618:             .Visible   = .T.
619:         ENDWITH
620: 
621:         loc_oPagina.AddObject("txt_4c_Hists", "TextBox")
622:         WITH loc_oPagina.txt_4c_Hists
623:             .Value     = ""
624:             .Top       = 109
625:             .Left      = 140
626:             .Width     = 223
627:             .Height    = 23
628:             .MaxLength = 100
629:             .FontName  = "Tahoma"
630:             .FontSize  = 8
631:             .Visible   = .T.
632:         ENDWITH
633: 
634:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
635:         WITH loc_oPagina.lbl_4c_Label24
636:             .Caption   = "Pend" + CHR(234) + "ncias :"
637:             .Top       = 116
638:             .Left      = 622
639:             .Width     = 61
640:             .Height    = 15
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .BackStyle = 0
644:             .Visible   = .T.
645:         ENDWITH
646: 
647:         loc_oPagina.AddObject("obj_4c_Opc_Pend", "OptionGroup")
648:         WITH loc_oPagina.obj_4c_Opc_Pend
649:             .ButtonCount = 2
650:             .Top         = 113
651:             .Left        = 683
652:             .Width       = 128
653:             .Height      = 21
654:             .BackStyle   = 0
655:             .BorderStyle = 0
656:             .Visible     = .T.
657:         ENDWITH
658:         WITH loc_oPagina.obj_4c_Opc_Pend.Buttons(1)
659:             .Caption   = "Sim"
660:             .BackStyle = 0
661:             .Left      = 5
662:             .Top       = 3
663:             .Width     = 55
664:             .AutoSize  = .F.
665:             .ForeColor = RGB(90, 90, 90)
666:             .FontName  = "Tahoma"
667:             .FontSize  = 8
668:         ENDWITH
669:         WITH loc_oPagina.obj_4c_Opc_Pend.Buttons(2)
670:             .Caption   = "N" + CHR(227) + "o"
671:             .BackStyle = 0
672:             .Left      = 63
673:             .Top       = 3
674:             .Width     = 55
675:             .AutoSize  = .F.
676:             .ForeColor = RGB(90, 90, 90)
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:         ENDWITH
680: 
681:         *----------------------------------------------------------------------
682:         *-- Linha 4: Valor Previsto + Complemento Hist" + CHR(243) + "rico (5 op" + CHR(231) + CHR(245) + "es)
683:         *----------------------------------------------------------------------
684: 
685:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
686:         WITH loc_oPagina.lbl_4c_Label19
687:             .Caption   = "Valor Previsto :"
688:             .Top       = 132
689:             .Left      = 610
690:             .Width     = 73
691:             .Height    = 15
692:             .FontName  = "Tahoma"
693:             .FontSize  = 8
694:             .BackStyle = 0
695:             .Visible   = .T.
696:         ENDWITH
697: 
698:         loc_oPagina.AddObject("obj_4c_Opc_valprev", "OptionGroup")
699:         WITH loc_oPagina.obj_4c_Opc_valprev
700:             .ButtonCount = 2
701:             .Top         = 129
702:             .Left        = 683
703:             .Width       = 128
704:             .Height      = 21
705:             .BackStyle   = 0
706:             .BorderStyle = 0
707:             .Visible     = .T.
708:         ENDWITH
709:         WITH loc_oPagina.obj_4c_Opc_valprev.Buttons(1)
710:             .Caption   = "Sim"
711:             .BackStyle = 0
712:             .Left      = 5
713:             .Top       = 3
714:             .Width     = 55
715:             .AutoSize  = .F.
716:             .ForeColor = RGB(90, 90, 90)
717:             .FontName  = "Tahoma"
718:             .FontSize  = 8
719:         ENDWITH
720:         WITH loc_oPagina.obj_4c_Opc_valprev.Buttons(2)
721:             .Caption   = "N" + CHR(227) + "o"
722:             .BackStyle = 0
723:             .Left      = 63
724:             .Top       = 3
725:             .Width     = 55
726:             .AutoSize  = .F.
727:             .ForeColor = RGB(90, 90, 90)
728:             .FontName  = "Tahoma"
729:             .FontSize  = 8
730:         ENDWITH
731: 
732:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
733:         WITH loc_oPagina.lbl_4c_Label6
734:             .Caption   = "Compl. Hist" + CHR(243) + "rico :"
735:             .Top       = 137
736:             .Left      = 50
737:             .Width     = 86
738:             .Height    = 15
739:             .FontName  = "Tahoma"
740:             .FontSize  = 8
741:             .BackStyle = 0
742:             .Visible   = .T.
743:         ENDWITH
744: 
745:         loc_oPagina.AddObject("obj_4c_Opc_Compl", "OptionGroup")
746:         WITH loc_oPagina.obj_4c_Opc_Compl
747:             .ButtonCount = 5
748:             .Top         = 134
749:             .Left        = 135
750:             .Width       = 206
751:             .Height      = 53
752:             .BackStyle   = 0
753:             .BorderStyle = 0
754:             .Visible     = .T.
755:         ENDWITH
756:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(1)
757:             .Caption   = "Nenhum"
758:             .BackStyle = 0
759:             .Left      = 5
760:             .Top       = 3
761:             .Width     = 75
762:             .AutoSize  = .F.
763:             .ForeColor = RGB(90, 90, 90)
764:             .FontName  = "Tahoma"
765:             .FontSize  = 8
766:         ENDWITH
767:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(2)
768:             .Caption   = "Emitente"
769:             .BackStyle = 0
770:             .Left      = 5
771:             .Top       = 28
772:             .Width     = 75
773:             .AutoSize  = .F.
774:             .ForeColor = RGB(90, 90, 90)
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:         ENDWITH
778:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(3)
779:             .Caption   = "Portador"
780:             .BackStyle = 0
781:             .Left      = 83
782:             .Top       = 3
783:             .Width     = 75
784:             .AutoSize  = .F.
785:             .ForeColor = RGB(90, 90, 90)
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:         ENDWITH
789:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(4)
790:             .Caption   = "Ambos"
791:             .BackStyle = 0
792:             .Left      = 83
793:             .Top       = 28
794:             .Width     = 75
795:             .AutoSize  = .F.
796:             .ForeColor = RGB(90, 90, 90)
797:             .FontName  = "Tahoma"
798:             .FontSize  = 8
799:         ENDWITH
800:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(5)
801:             .Caption   = "Conta"
802:             .BackStyle = 0
803:             .Left      = 161
804:             .Top       = 3
805:             .Width     = 35
806:             .AutoSize  = .F.
807:             .ForeColor = RGB(90, 90, 90)
808:             .FontName  = "Tahoma"
809:             .FontSize  = 8
810:         ENDWITH
811: 
812:         *----------------------------------------------------------------------
813:         *-- Linha 5: Bloquear C/C
814:         *----------------------------------------------------------------------
815: 
816:         loc_oPagina.AddObject("lbl_4c_Label26", "Label")
817:         WITH loc_oPagina.lbl_4c_Label26
818:             .Caption   = "Bloquear C/C :"
819:             .Top       = 149
820:             .Left      = 613
821:             .Width     = 70
822:             .Height    = 15
823:             .FontName  = "Tahoma"
824:             .FontSize  = 8
825:             .BackStyle = 0
826:             .Visible   = .T.
827:         ENDWITH
828: 
829:         loc_oPagina.AddObject("obj_4c_Opc_blqcc", "OptionGroup")
830:         WITH loc_oPagina.obj_4c_Opc_blqcc
831:             .ButtonCount = 2
832:             .Top         = 146
833:             .Left        = 683
834:             .Width       = 128
835:             .Height      = 21
836:             .BackStyle   = 0
837:             .BorderStyle = 0
838:             .Visible     = .T.
839:         ENDWITH
840:         WITH loc_oPagina.obj_4c_Opc_blqcc.Buttons(1)
841:             .Caption   = "Sim"
842:             .BackStyle = 0
843:             .Left      = 5
844:             .Top       = 3
845:             .Width     = 55
846:             .AutoSize  = .F.
847:             .ForeColor = RGB(90, 90, 90)
848:             .FontName  = "Tahoma"
849:             .FontSize  = 8
850:         ENDWITH
851:         WITH loc_oPagina.obj_4c_Opc_blqcc.Buttons(2)
852:             .Caption   = "N" + CHR(227) + "o"
853:             .BackStyle = 0
854:             .Left      = 63
855:             .Top       = 3
856:             .Width     = 55
857:             .AutoSize  = .F.
858:             .ForeColor = RGB(90, 90, 90)
859:             .FontName  = "Tahoma"
860:             .FontSize  = 8
861:         ENDWITH
862: 
863:         *----------------------------------------------------------------------
864:         *-- Linha 6: Realizar Apenas Autorizados
865:         *----------------------------------------------------------------------
866: 
867:         loc_oPagina.AddObject("lbl_4c_Label27", "Label")
868:         WITH loc_oPagina.lbl_4c_Label27
869:             .Caption   = "Realizar Apenas Autorizados :"
870:             .Top       = 167
871:             .Left      = 537
872:             .Width     = 146
873:             .Height    = 15
874:             .FontName  = "Tahoma"
875:             .FontSize  = 8
876:             .BackStyle = 0
877:             .Visible   = .T.
878:         ENDWITH
879: 
880:         loc_oPagina.AddObject("obj_4c_Opc_Transporte", "OptionGroup")
881:         WITH loc_oPagina.obj_4c_Opc_Transporte
882:             .ButtonCount = 2
883:             .Top         = 162
884:             .Left        = 683
885:             .Width       = 128
886:             .Height      = 21
887:             .BackStyle   = 0
888:             .BorderStyle = 0
889:             .Visible     = .T.
890:         ENDWITH
891:         WITH loc_oPagina.obj_4c_Opc_Transporte.Buttons(1)
892:             .Caption   = "Sim"
893:             .BackStyle = 0
894:             .Left      = 5
895:             .Top       = 3
896:             .Width     = 55
897:             .AutoSize  = .F.
898:             .ForeColor = RGB(90, 90, 90)
899:             .FontName  = "Tahoma"
900:             .FontSize  = 8
901:         ENDWITH
902:         WITH loc_oPagina.obj_4c_Opc_Transporte.Buttons(2)
903:             .Caption   = "N" + CHR(227) + "o"
904:             .BackStyle = 0
905:             .Left      = 63
906:             .Top       = 3
907:             .Width     = 55
908:             .AutoSize  = .F.
909:             .ForeColor = RGB(90, 90, 90)
910:             .FontName  = "Tahoma"
911:             .FontSize  = 8
912:         ENDWITH
913: 
914:         *----------------------------------------------------------------------
915:         *-- Linha 7: Outros T" + CHR(237) + "tulos Auto + Identificador + N" + CHR(186) + " T" + CHR(237) + "tulo Autom" + CHR(225) + "tico
916:         *----------------------------------------------------------------------
917: 
918:         loc_oPagina.AddObject("lbl_4c_Label31", "Label")
919:         WITH loc_oPagina.lbl_4c_Label31
920:             .Caption   = "Outros Titulos (Auto) :"
921:             .Top       = 182
922:             .Left      = 573
923:             .Width     = 110
924:             .Height    = 15
925:             .FontName  = "Tahoma"
926:             .FontSize  = 8
927:             .BackStyle = 0
928:             .Visible   = .T.
929:         ENDWITH
930: 
931:         loc_oPagina.AddObject("obj_4c_Get_OutroTit", "OptionGroup")
932:         WITH loc_oPagina.obj_4c_Get_OutroTit
933:             .ButtonCount = 2
934:             .Top         = 179
935:             .Left        = 683
936:             .Width       = 128
937:             .Height      = 21
938:             .BackStyle   = 0
939:             .BorderStyle = 0
940:             .Visible     = .T.
941:         ENDWITH
942:         WITH loc_oPagina.obj_4c_Get_OutroTit.Buttons(1)
943:             .Caption   = "Sim"
944:             .BackStyle = 0
945:             .Left      = 5
946:             .Top       = 3
947:             .Width     = 55
948:             .AutoSize  = .F.
949:             .ForeColor = RGB(90, 90, 90)
950:             .FontName  = "Tahoma"
951:             .FontSize  = 8
952:         ENDWITH
953:         WITH loc_oPagina.obj_4c_Get_OutroTit.Buttons(2)
954:             .Caption   = "N" + CHR(227) + "o"
955:             .BackStyle = 0
956:             .Left      = 63
957:             .Top       = 3
958:             .Width     = 55
959:             .AutoSize  = .F.
960:             .ForeColor = RGB(90, 90, 90)
961:             .FontName  = "Tahoma"
962:             .FontSize  = 8
963:         ENDWITH
964: 
965:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
966:         WITH loc_oPagina.lbl_4c_Label7
967:             .Caption   = "N" + CHR(186) + " titulo autom" + CHR(225) + "tico :"
968:             .Top       = 188
969:             .Left      = 32
970:             .Width     = 104
971:             .Height    = 15
972:             .FontName  = "Tahoma"
973:             .FontSize  = 8
974:             .BackStyle = 0
975:             .Visible   = .T.
976:         ENDWITH
977: 
978:         loc_oPagina.AddObject("obj_4c_Opc_Numtit", "OptionGroup")
979:         WITH loc_oPagina.obj_4c_Opc_Numtit
980:             .ButtonCount = 2
981:             .Top         = 185
982:             .Left        = 135
983:             .Width       = 110
984:             .Height      = 21
985:             .BackStyle   = 0
986:             .BorderStyle = 0
987:             .Visible     = .T.
988:         ENDWITH
989:         WITH loc_oPagina.obj_4c_Opc_Numtit.Buttons(1)
990:             .Caption   = "Sim"
991:             .BackStyle = 0
992:             .Left      = 5
993:             .Top       = 3
994:             .Width     = 46
995:             .AutoSize  = .F.
996:             .ForeColor = RGB(90, 90, 90)
997:             .FontName  = "Tahoma"
998:             .FontSize  = 8
999:         ENDWITH
1000:         WITH loc_oPagina.obj_4c_Opc_Numtit.Buttons(2)
1001:             .Caption   = "N" + CHR(227) + "o"
1002:             .BackStyle = 0
1003:             .Left      = 54
1004:             .Top       = 3
1005:             .Width     = 46
1006:             .AutoSize  = .F.
1007:             .ForeColor = RGB(90, 90, 90)
1008:             .FontName  = "Tahoma"
1009:             .FontSize  = 8
1010:         ENDWITH
1011: 
1012:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1013:         WITH loc_oPagina.lbl_4c_Label8
1014:             .Caption   = "Identificador :"
1015:             .Top       = 188
1016:             .Left      = 303
1017:             .Width     = 70
1018:             .Height    = 15
1019:             .FontName  = "Tahoma"
1020:             .FontSize  = 8
1021:             .BackStyle = 0
1022:             .Visible   = .T.
1023:         ENDWITH
1024: 
1025:         loc_oPagina.AddObject("txt_4c_Ident", "TextBox")
1026:         WITH loc_oPagina.txt_4c_Ident
1027:             .Value     = ""
1028:             .Top       = 184
1029:             .Left      = 378
1030:             .Width     = 17
1031:             .Height    = 21
1032:             .MaxLength = 1
1033:             .FontName  = "Tahoma"
1034:             .FontSize  = 8
1035:             .Visible   = .T.
1036:         ENDWITH
1037: 
1038:         *----------------------------------------------------------------------
1039:         *-- Linha 8: Tipo (Opc_realprev) + Qtd. Vias Boleto
1040:         *----------------------------------------------------------------------
1041: 
1042:         loc_oPagina.AddObject("lbl_4c_Label17", "Label")
1043:         WITH loc_oPagina.lbl_4c_Label17
1044:             .Caption   = "Tipo :"
1045:             .Top       = 200
1046:             .Left      = 654
1047:             .Width     = 29
1048:             .Height    = 15
1049:             .FontName  = "Tahoma"
1050:             .FontSize  = 8
1051:             .BackStyle = 0
1052:             .Visible   = .T.
1053:         ENDWITH
1054: 
1055:         loc_oPagina.AddObject("obj_4c_Opc_realprev", "OptionGroup")
1056:         WITH loc_oPagina.obj_4c_Opc_realprev
1057:             .ButtonCount = 2
1058:             .Top         = 197
1059:             .Left        = 683
1060:             .Width       = 128
1061:             .Height      = 21
1062:             .BackStyle   = 0
1063:             .BorderStyle = 0
1064:             .Visible     = .T.
1065:         ENDWITH
1066:         WITH loc_oPagina.obj_4c_Opc_realprev.Buttons(1)
1067:             .Caption   = "C/C"
1068:             .BackStyle = 0
1069:             .Left      = 5
1070:             .Top       = 3
1071:             .Width     = 55
1072:             .AutoSize  = .F.
1073:             .ForeColor = RGB(90, 90, 90)
1074:             .FontName  = "Tahoma"
1075:             .FontSize  = 8
1076:         ENDWITH
1077:         WITH loc_oPagina.obj_4c_Opc_realprev.Buttons(2)
1078:             .Caption   = "Previsto"
1079:             .BackStyle = 0
1080:             .Left      = 63
1081:             .Top       = 3
1082:             .Width     = 55
1083:             .AutoSize  = .F.
1084:             .ForeColor = RGB(90, 90, 90)
1085:             .FontName  = "Tahoma"
1086:             .FontSize  = 8
1087:         ENDWITH
1088:         BINDEVENT(loc_oPagina.obj_4c_Opc_realprev, "InteractiveChange", THIS, "OpcRealprevChanged")
1089: 
1090:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
1091:         WITH loc_oPagina.lbl_4c_Label16
1092:             .Caption   = "Qtd. Vias Boleto :"
1093:             .Top       = 213
1094:             .Left      = 287
1095:             .Width     = 86
1096:             .Height    = 15
1097:             .FontName  = "Tahoma"
1098:             .FontSize  = 8
1099:             .BackStyle = 0
1100:             .Visible   = .T.
1101:         ENDWITH
1102: 
1103:         loc_oPagina.AddObject("txt_4c_Vias", "TextBox")
1104:         WITH loc_oPagina.txt_4c_Vias
1105:             .Value    = 0
1106:             .Top      = 208
1107:             .Left     = 378
1108:             .Width    = 24
1109:             .Height   = 24
1110:             .FontName = "Tahoma"
1111:             .FontSize = 8
1112:             .Visible  = .T.
1113:         ENDWITH
1114:         BINDEVENT(loc_oPagina.txt_4c_Vias, "KeyPress", THIS, "ValidarVias")
1115: 
1116:         *----------------------------------------------------------------------
1117:         *-- Linha 9: Imprime Boleto + Opera" + CHR(231) + CHR(227) + "o Realizado
1118:         *----------------------------------------------------------------------
1119: 
1120:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
1121:         WITH loc_oPagina.lbl_4c_Label15
1122:             .Caption   = "Imprime Boleto :"
1123:             .Top       = 213
1124:             .Left      = 56
1125:             .Width     = 80
1126:             .Height    = 15
1127:             .FontName  = "Tahoma"
1128:             .FontSize  = 8
1129:             .BackStyle = 0
1130:             .Visible   = .T.
1131:         ENDWITH
1132: 
1133:         loc_oPagina.AddObject("obj_4c_Opc_Impbol", "OptionGroup")
1134:         WITH loc_oPagina.obj_4c_Opc_Impbol
1135:             .ButtonCount = 2
1136:             .Top         = 210
1137:             .Left        = 135
1138:             .Width       = 110
1139:             .Height      = 21
1140:             .BackStyle   = 0
1141:             .BorderStyle = 0
1142:             .Visible     = .T.
1143:         ENDWITH
1144:         WITH loc_oPagina.obj_4c_Opc_Impbol.Buttons(1)
1145:             .Caption   = "Sim"
1146:             .BackStyle = 0
1147:             .Left      = 5
1148:             .Top       = 3
1149:             .Width     = 46
1150:             .AutoSize  = .F.
1151:             .ForeColor = RGB(90, 90, 90)
1152:             .FontName  = "Tahoma"
1153:             .FontSize  = 8
1154:         ENDWITH
1155:         WITH loc_oPagina.obj_4c_Opc_Impbol.Buttons(2)
1156:             .Caption   = "N" + CHR(227) + "o"
1157:             .BackStyle = 0
1158:             .Left      = 54
1159:             .Top       = 3
1160:             .Width     = 46
1161:             .AutoSize  = .F.
1162:             .ForeColor = RGB(90, 90, 90)
1163:             .FontName  = "Tahoma"
1164:             .FontSize  = 8
1165:         ENDWITH
1166: 
1167:         loc_oPagina.AddObject("lbl_4c_Label18", "Label")
1168:         WITH loc_oPagina.lbl_4c_Label18
1169:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o Realizado :"
1170:             .Top       = 220
1171:             .Left      = 578
1172:             .Width     = 105
1173:             .Height    = 15
1174:             .FontName  = "Tahoma"
1175:             .FontSize  = 8
1176:             .BackStyle = 0
1177:             .Visible   = .T.
1178:         ENDWITH
1179: 
1180:         loc_oPagina.AddObject("txt_4c_DopReal", "TextBox")
1181:         WITH loc_oPagina.txt_4c_DopReal
1182:             .Value     = ""
1183:             .Top       = 216
1184:             .Left      = 688
1185:             .Width     = 150
1186:             .Height    = 23
1187:             .MaxLength = 10
1188:             .FontName  = "Tahoma"
1189:             .FontSize  = 8

*-- Linhas 1195 a 1267:
1195:         *-- Linha 10: Imprime Documento + Opera" + CHR(231) + CHR(227) + "o Cancelamento
1196:         *----------------------------------------------------------------------
1197: 
1198:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
1199:         WITH loc_oPagina.lbl_4c_Label28
1200:             .Caption   = "Imprime Documento :"
1201:             .Top       = 234
1202:             .Left      = 32
1203:             .Width     = 104
1204:             .Height    = 15
1205:             .FontName  = "Tahoma"
1206:             .FontSize  = 8
1207:             .BackStyle = 0
1208:             .Visible   = .T.
1209:         ENDWITH
1210: 
1211:         loc_oPagina.AddObject("obj_4c_Opc_imprimedoc", "OptionGroup")
1212:         WITH loc_oPagina.obj_4c_Opc_imprimedoc
1213:             .ButtonCount = 2
1214:             .Top         = 231
1215:             .Left        = 135
1216:             .Width       = 110
1217:             .Height      = 21
1218:             .BackStyle   = 0
1219:             .BorderStyle = 0
1220:             .Visible     = .T.
1221:         ENDWITH
1222:         WITH loc_oPagina.obj_4c_Opc_imprimedoc.Buttons(1)
1223:             .Caption   = "Sim"
1224:             .BackStyle = 0
1225:             .Left      = 5
1226:             .Top       = 3
1227:             .Width     = 46
1228:             .AutoSize  = .F.
1229:             .ForeColor = RGB(90, 90, 90)
1230:             .FontName  = "Tahoma"
1231:             .FontSize  = 8
1232:         ENDWITH
1233:         WITH loc_oPagina.obj_4c_Opc_imprimedoc.Buttons(2)
1234:             .Caption   = "N" + CHR(227) + "o"
1235:             .BackStyle = 0
1236:             .Left      = 54
1237:             .Top       = 3
1238:             .Width     = 46
1239:             .AutoSize  = .F.
1240:             .ForeColor = RGB(90, 90, 90)
1241:             .FontName  = "Tahoma"
1242:             .FontSize  = 8
1243:         ENDWITH
1244: 
1245:         loc_oPagina.AddObject("lbl_4c_Label30", "Label")
1246:         WITH loc_oPagina.lbl_4c_Label30
1247:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o Cancelamento :"
1248:             .Top       = 245
1249:             .Left      = 556
1250:             .Width     = 127
1251:             .Height    = 15
1252:             .FontName  = "Tahoma"
1253:             .FontSize  = 8
1254:             .BackStyle = 0
1255:             .Visible   = .T.
1256:         ENDWITH
1257: 
1258:         loc_oPagina.AddObject("txt_4c_DopCanc", "TextBox")
1259:         WITH loc_oPagina.txt_4c_DopCanc
1260:             .Value     = ""
1261:             .Top       = 241
1262:             .Left      = 688
1263:             .Width     = 150
1264:             .Height    = 23
1265:             .MaxLength = 10
1266:             .FontName  = "Tahoma"
1267:             .FontSize  = 8

*-- Linhas 1273 a 1714:
1273:         *-- Linha 10: Dados Pagamento + Campo NF
1274:         *----------------------------------------------------------------------
1275: 
1276:         loc_oPagina.AddObject("lbl_4c_Label32", "Label")
1277:         WITH loc_oPagina.lbl_4c_Label32
1278:             .Caption   = "Dados Pagamento :"
1279:             .Top       = 273
1280:             .Left      = 37
1281:             .Width     = 99
1282:             .Height    = 15
1283:             .FontName  = "Tahoma"
1284:             .FontSize  = 8
1285:             .BackStyle = 0
1286:             .Visible   = .T.
1287:         ENDWITH
1288: 
1289:         loc_oPagina.AddObject("obj_4c_Opc_DadosPg", "OptionGroup")
1290:         WITH loc_oPagina.obj_4c_Opc_DadosPg
1291:             .ButtonCount = 2
1292:             .Top         = 270
1293:             .Left        = 135
1294:             .Width       = 110
1295:             .Height      = 21
1296:             .BackStyle   = 0
1297:             .BorderStyle = 0
1298:             .Visible     = .T.
1299:         ENDWITH
1300:         WITH loc_oPagina.obj_4c_Opc_DadosPg.Buttons(1)
1301:             .Caption   = "Sim"
1302:             .BackStyle = 0
1303:             .Left      = 5
1304:             .Top       = 3
1305:             .Width     = 46
1306:             .AutoSize  = .F.
1307:             .ForeColor = RGB(90, 90, 90)
1308:             .FontName  = "Tahoma"
1309:             .FontSize  = 8
1310:         ENDWITH
1311:         WITH loc_oPagina.obj_4c_Opc_DadosPg.Buttons(2)
1312:             .Caption   = "N" + CHR(227) + "o"
1313:             .BackStyle = 0
1314:             .Left      = 54
1315:             .Top       = 3
1316:             .Width     = 46
1317:             .AutoSize  = .F.
1318:             .ForeColor = RGB(90, 90, 90)
1319:             .FontName  = "Tahoma"
1320:             .FontSize  = 8
1321:         ENDWITH
1322: 
1323:         loc_oPagina.AddObject("lbl_4c_Label33", "Label")
1324:         WITH loc_oPagina.lbl_4c_Label33
1325:             .Caption   = "Campo NF :"
1326:             .Top       = 273
1327:             .Left      = 583
1328:             .Width     = 65
1329:             .Height    = 15
1330:             .FontName  = "Tahoma"
1331:             .FontSize  = 8
1332:             .BackStyle = 0
1333:             .Visible   = .T.
1334:         ENDWITH
1335: 
1336:         loc_oPagina.AddObject("obj_4c_Opt_CampoNf", "OptionGroup")
1337:         WITH loc_oPagina.obj_4c_Opt_CampoNf
1338:             .ButtonCount = 2
1339:             .Top         = 270
1340:             .Left        = 683
1341:             .Width       = 128
1342:             .Height      = 21
1343:             .BackStyle   = 0
1344:             .BorderStyle = 0
1345:             .Visible     = .T.
1346:         ENDWITH
1347:         WITH loc_oPagina.obj_4c_Opt_CampoNf.Buttons(1)
1348:             .Caption   = "Sim"
1349:             .BackStyle = 0
1350:             .Left      = 5
1351:             .Top       = 3
1352:             .Width     = 55
1353:             .AutoSize  = .F.
1354:             .ForeColor = RGB(90, 90, 90)
1355:             .FontName  = "Tahoma"
1356:             .FontSize  = 8
1357:         ENDWITH
1358:         WITH loc_oPagina.obj_4c_Opt_CampoNf.Buttons(2)
1359:             .Caption   = "N" + CHR(227) + "o"
1360:             .BackStyle = 0
1361:             .Left      = 63
1362:             .Top       = 3
1363:             .Width     = 55
1364:             .AutoSize  = .F.
1365:             .ForeColor = RGB(90, 90, 90)
1366:             .FontName  = "Tahoma"
1367:             .FontSize  = 8
1368:         ENDWITH
1369: 
1370:         *----------------------------------------------------------------------
1371:         *-- Linha 11: Emitente=Portador + Compet" + CHR(234) + "ncia
1372:         *----------------------------------------------------------------------
1373: 
1374:         loc_oPagina.AddObject("lbl_4c_Label34", "Label")
1375:         WITH loc_oPagina.lbl_4c_Label34
1376:             .Caption   = "Emit.=Portador :"
1377:             .Top       = 295
1378:             .Left      = 54
1379:             .Width     = 82
1380:             .Height    = 15
1381:             .FontName  = "Tahoma"
1382:             .FontSize  = 8
1383:             .BackStyle = 0
1384:             .Visible   = .T.
1385:         ENDWITH
1386: 
1387:         loc_oPagina.AddObject("obj_4c_Opc_EmiPor", "OptionGroup")
1388:         WITH loc_oPagina.obj_4c_Opc_EmiPor
1389:             .ButtonCount = 2
1390:             .Top         = 292
1391:             .Left        = 135
1392:             .Width       = 110
1393:             .Height      = 21
1394:             .BackStyle   = 0
1395:             .BorderStyle = 0
1396:             .Visible     = .T.
1397:         ENDWITH
1398:         WITH loc_oPagina.obj_4c_Opc_EmiPor.Buttons(1)
1399:             .Caption   = "Sim"
1400:             .BackStyle = 0
1401:             .Left      = 5
1402:             .Top       = 3
1403:             .Width     = 46
1404:             .AutoSize  = .F.
1405:             .ForeColor = RGB(90, 90, 90)
1406:             .FontName  = "Tahoma"
1407:             .FontSize  = 8
1408:         ENDWITH
1409:         WITH loc_oPagina.obj_4c_Opc_EmiPor.Buttons(2)
1410:             .Caption   = "N" + CHR(227) + "o"
1411:             .BackStyle = 0
1412:             .Left      = 54
1413:             .Top       = 3
1414:             .Width     = 46
1415:             .AutoSize  = .F.
1416:             .ForeColor = RGB(90, 90, 90)
1417:             .FontName  = "Tahoma"
1418:             .FontSize  = 8
1419:         ENDWITH
1420: 
1421:         loc_oPagina.AddObject("lbl_4c_Label35", "Label")
1422:         WITH loc_oPagina.lbl_4c_Label35
1423:             .Caption   = "Compet" + CHR(234) + "ncia :"
1424:             .Top       = 295
1425:             .Left      = 574
1426:             .Width     = 75
1427:             .Height    = 15
1428:             .FontName  = "Tahoma"
1429:             .FontSize  = 8
1430:             .BackStyle = 0
1431:             .Visible   = .T.
1432:         ENDWITH
1433: 
1434:         loc_oPagina.AddObject("obj_4c_Opc_Compet", "OptionGroup")
1435:         WITH loc_oPagina.obj_4c_Opc_Compet
1436:             .ButtonCount = 2
1437:             .Top         = 292
1438:             .Left        = 683
1439:             .Width       = 128
1440:             .Height      = 21
1441:             .BackStyle   = 0
1442:             .BorderStyle = 0
1443:             .Visible     = .T.
1444:         ENDWITH
1445:         WITH loc_oPagina.obj_4c_Opc_Compet.Buttons(1)
1446:             .Caption   = "Sim"
1447:             .BackStyle = 0
1448:             .Left      = 5
1449:             .Top       = 3
1450:             .Width     = 55
1451:             .AutoSize  = .F.
1452:             .ForeColor = RGB(90, 90, 90)
1453:             .FontName  = "Tahoma"
1454:             .FontSize  = 8
1455:         ENDWITH
1456:         WITH loc_oPagina.obj_4c_Opc_Compet.Buttons(2)
1457:             .Caption   = "N" + CHR(227) + "o"
1458:             .BackStyle = 0
1459:             .Left      = 63
1460:             .Top       = 3
1461:             .Width     = 55
1462:             .AutoSize  = .F.
1463:             .ForeColor = RGB(90, 90, 90)
1464:             .FontName  = "Tahoma"
1465:             .FontSize  = 8
1466:         ENDWITH
1467: 
1468:         *----------------------------------------------------------------------
1469:         *-- Linha 12: Filtra Conta p/ Grupo + Jobs
1470:         *----------------------------------------------------------------------
1471: 
1472:         loc_oPagina.AddObject("lbl_4c_Label36", "Label")
1473:         WITH loc_oPagina.lbl_4c_Label36
1474:             .Caption   = "Filtra Conta p/ Grupo :"
1475:             .Top       = 317
1476:             .Left      = 17
1477:             .Width     = 119
1478:             .Height    = 15
1479:             .FontName  = "Tahoma"
1480:             .FontSize  = 8
1481:             .BackStyle = 0
1482:             .Visible   = .T.
1483:         ENDWITH
1484: 
1485:         loc_oPagina.AddObject("obj_4c_Opc_FiltContas", "OptionGroup")
1486:         WITH loc_oPagina.obj_4c_Opc_FiltContas
1487:             .ButtonCount = 2
1488:             .Top         = 314
1489:             .Left        = 135
1490:             .Width       = 110
1491:             .Height      = 21
1492:             .BackStyle   = 0
1493:             .BorderStyle = 0
1494:             .Visible     = .T.
1495:         ENDWITH
1496:         WITH loc_oPagina.obj_4c_Opc_FiltContas.Buttons(1)
1497:             .Caption   = "Sim"
1498:             .BackStyle = 0
1499:             .Left      = 5
1500:             .Top       = 3
1501:             .Width     = 46
1502:             .AutoSize  = .F.
1503:             .ForeColor = RGB(90, 90, 90)
1504:             .FontName  = "Tahoma"
1505:             .FontSize  = 8
1506:         ENDWITH
1507:         WITH loc_oPagina.obj_4c_Opc_FiltContas.Buttons(2)
1508:             .Caption   = "N" + CHR(227) + "o"
1509:             .BackStyle = 0
1510:             .Left      = 54
1511:             .Top       = 3
1512:             .Width     = 46
1513:             .AutoSize  = .F.
1514:             .ForeColor = RGB(90, 90, 90)
1515:             .FontName  = "Tahoma"
1516:             .FontSize  = 8
1517:         ENDWITH
1518: 
1519:         loc_oPagina.AddObject("lbl_4c_Label37", "Label")
1520:         WITH loc_oPagina.lbl_4c_Label37
1521:             .Caption   = "Jobs :"
1522:             .Top       = 317
1523:             .Left      = 633
1524:             .Width     = 36
1525:             .Height    = 15
1526:             .FontName  = "Tahoma"
1527:             .FontSize  = 8
1528:             .BackStyle = 0
1529:             .Visible   = .T.
1530:         ENDWITH
1531: 
1532:         loc_oPagina.AddObject("obj_4c_Opt_Jobs", "OptionGroup")
1533:         WITH loc_oPagina.obj_4c_Opt_Jobs
1534:             .ButtonCount = 2
1535:             .Top         = 314
1536:             .Left        = 683
1537:             .Width       = 128
1538:             .Height      = 21
1539:             .BackStyle   = 0
1540:             .BorderStyle = 0
1541:             .Visible     = .T.
1542:         ENDWITH
1543:         WITH loc_oPagina.obj_4c_Opt_Jobs.Buttons(1)
1544:             .Caption   = "Sim"
1545:             .BackStyle = 0
1546:             .Left      = 5
1547:             .Top       = 3
1548:             .Width     = 55
1549:             .AutoSize  = .F.
1550:             .ForeColor = RGB(90, 90, 90)
1551:             .FontName  = "Tahoma"
1552:             .FontSize  = 8
1553:         ENDWITH
1554:         WITH loc_oPagina.obj_4c_Opt_Jobs.Buttons(2)
1555:             .Caption   = "N" + CHR(227) + "o"
1556:             .BackStyle = 0
1557:             .Left      = 63
1558:             .Top       = 3
1559:             .Width     = 55
1560:             .AutoSize  = .F.
1561:             .ForeColor = RGB(90, 90, 90)
1562:             .FontName  = "Tahoma"
1563:             .FontSize  = 8
1564:         ENDWITH
1565: 
1566:         *----------------------------------------------------------------------
1567:         *-- Linha 13: Limite Cr" + CHR(233) + "dito
1568:         *----------------------------------------------------------------------
1569: 
1570:         loc_oPagina.AddObject("lbl_4c_Label38", "Label")
1571:         WITH loc_oPagina.lbl_4c_Label38
1572:             .Caption   = "Limite Cr" + CHR(233) + "dito :"
1573:             .Top       = 339
1574:             .Left      = 42
1575:             .Width     = 94
1576:             .Height    = 15
1577:             .FontName  = "Tahoma"
1578:             .FontSize  = 8
1579:             .BackStyle = 0
1580:             .Visible   = .T.
1581:         ENDWITH
1582: 
1583:         loc_oPagina.AddObject("obj_4c_Opc_Limcres", "OptionGroup")
1584:         WITH loc_oPagina.obj_4c_Opc_Limcres
1585:             .ButtonCount = 2
1586:             .Top         = 336
1587:             .Left        = 135
1588:             .Width       = 110
1589:             .Height      = 21
1590:             .BackStyle   = 0
1591:             .BorderStyle = 0
1592:             .Visible     = .T.
1593:         ENDWITH
1594:         WITH loc_oPagina.obj_4c_Opc_Limcres.Buttons(1)
1595:             .Caption   = "Sim"
1596:             .BackStyle = 0
1597:             .Left      = 5
1598:             .Top       = 3
1599:             .Width     = 46
1600:             .AutoSize  = .F.
1601:             .ForeColor = RGB(90, 90, 90)
1602:             .FontName  = "Tahoma"
1603:             .FontSize  = 8
1604:         ENDWITH
1605:         WITH loc_oPagina.obj_4c_Opc_Limcres.Buttons(2)
1606:             .Caption   = "N" + CHR(227) + "o"
1607:             .BackStyle = 0
1608:             .Left      = 54
1609:             .Top       = 3
1610:             .Width     = 46
1611:             .AutoSize  = .F.
1612:             .ForeColor = RGB(90, 90, 90)
1613:             .FontName  = "Tahoma"
1614:             .FontSize  = 8
1615:         ENDWITH
1616: 
1617:         *----------------------------------------------------------------------
1618:         *-- Linha 14: CheckBoxes
1619:         *----------------------------------------------------------------------
1620: 
1621:         loc_oPagina.AddObject("chk_4c_Congvs", "CheckBox")
1622:         WITH loc_oPagina.chk_4c_Congvs
1623:             .Caption   = "Cong" + CHR(234) + "neres"
1624:             .Top       = 362
1625:             .Left      = 20
1626:             .Width     = 100
1627:             .Height    = 17
1628:             .Value     = 0
1629:             .FontName  = "Tahoma"
1630:             .FontSize  = 8
1631:             .BackStyle = 0
1632:             .Visible   = .T.
1633:         ENDWITH
1634: 
1635:         loc_oPagina.AddObject("chk_4c_BlqTits", "CheckBox")
1636:         WITH loc_oPagina.chk_4c_BlqTits
1637:             .Caption   = "Bloqueia T" + CHR(237) + "tulos"
1638:             .Top       = 362
1639:             .Left      = 128
1640:             .Width     = 118
1641:             .Height    = 17
1642:             .Value     = 0
1643:             .FontName  = "Tahoma"
1644:             .FontSize  = 8
1645:             .BackStyle = 0
1646:             .Visible   = .T.
1647:         ENDWITH
1648: 
1649:         loc_oPagina.AddObject("chk_4c_Espobrigs", "CheckBox")
1650:         WITH loc_oPagina.chk_4c_Espobrigs
1651:             .Caption   = "Esp. Obrig."
1652:             .Top       = 362
1653:             .Left      = 255
1654:             .Width     = 95
1655:             .Height    = 17
1656:             .Value     = 0
1657:             .FontName  = "Tahoma"
1658:             .FontSize  = 8
1659:             .BackStyle = 0
1660:             .Visible   = .T.
1661:         ENDWITH
1662: 
1663:         loc_oPagina.AddObject("chk_4c_LancCCEs", "CheckBox")
1664:         WITH loc_oPagina.chk_4c_LancCCEs
1665:             .Caption   = "Lan" + CHR(231) + ".C/C Emiss."
1666:             .Top       = 362
1667:             .Left      = 360
1668:             .Width     = 112
1669:             .Height    = 17
1670:             .Value     = 0
1671:             .FontName  = "Tahoma"
1672:             .FontSize  = 8
1673:             .BackStyle = 0
1674:             .Visible   = .T.
1675:         ENDWITH
1676: 
1677:         loc_oPagina.AddObject("chk_4c_LancCCAs", "CheckBox")
1678:         WITH loc_oPagina.chk_4c_LancCCAs
1679:             .Caption   = "Lan" + CHR(231) + ".C/C Ato."
1680:             .Top       = 362
1681:             .Left      = 480
1682:             .Width     = 105
1683:             .Height    = 17
1684:             .Value     = 0
1685:             .FontName  = "Tahoma"
1686:             .FontSize  = 8
1687:             .BackStyle = 0
1688:             .Visible   = .T.
1689:         ENDWITH
1690: 
1691:         loc_oPagina.AddObject("chk_4c_Obsobrigs", "CheckBox")
1692:         WITH loc_oPagina.chk_4c_Obsobrigs
1693:             .Caption   = "Obs. Obrig."
1694:             .Top       = 362
1695:             .Left      = 595
1696:             .Width     = 95
1697:             .Height    = 17
1698:             .Value     = 0
1699:             .FontName  = "Tahoma"
1700:             .FontSize  = 8
1701:             .BackStyle = 0
1702:             .Visible   = .T.
1703:         ENDWITH
1704: 
1705:         loc_oPagina.AddObject("chk_4c_ObrCompet", "CheckBox")
1706:         WITH loc_oPagina.chk_4c_ObrCompet
1707:             .Caption   = "Obrig. Compet."
1708:             .Top       = 362
1709:             .Left      = 700
1710:             .Width     = 115
1711:             .Height    = 17
1712:             .Value     = 0
1713:             .FontName  = "Tahoma"
1714:             .FontSize  = 8

*-- Linhas 1720 a 2275:
1720:         *-- Linha 15: M" + CHR(225) + "scara NF + Dias Vcto + Juros + Moeda + Vlr.Lim.Aprov.
1721:         *----------------------------------------------------------------------
1722: 
1723:         loc_oPagina.AddObject("lbl_4c_Label39", "Label")
1724:         WITH loc_oPagina.lbl_4c_Label39
1725:             .Caption   = "M" + CHR(225) + "scara NF :"
1726:             .Top       = 387
1727:             .Left      = 12
1728:             .Width     = 82
1729:             .Height    = 15
1730:             .FontName  = "Tahoma"
1731:             .FontSize  = 8
1732:             .BackStyle = 0
1733:             .Visible   = .T.
1734:         ENDWITH
1735: 
1736:         loc_oPagina.AddObject("txt_4c_Mascara", "TextBox")
1737:         WITH loc_oPagina.txt_4c_Mascara
1738:             .Value     = ""
1739:             .Top       = 383
1740:             .Left      = 97
1741:             .Width     = 75
1742:             .Height    = 23
1743:             .MaxLength = 10
1744:             .FontName  = "Tahoma"
1745:             .FontSize  = 8
1746:             .Visible   = .T.
1747:         ENDWITH
1748: 
1749:         loc_oPagina.AddObject("lbl_4c_Label40", "Label")
1750:         WITH loc_oPagina.lbl_4c_Label40
1751:             .Caption   = "Dias Vcto :"
1752:             .Top       = 387
1753:             .Left      = 178
1754:             .Width     = 65
1755:             .Height    = 15
1756:             .FontName  = "Tahoma"
1757:             .FontSize  = 8
1758:             .BackStyle = 0
1759:             .Visible   = .T.
1760:         ENDWITH
1761: 
1762:         loc_oPagina.AddObject("txt_4c_DiasVcto", "TextBox")
1763:         WITH loc_oPagina.txt_4c_DiasVcto
1764:             .Value     = 0
1765:             .Top       = 383
1766:             .Left      = 248
1767:             .Width     = 40
1768:             .Height    = 23
1769:             .FontName  = "Tahoma"
1770:             .FontSize  = 8
1771:             .Visible   = .T.
1772:         ENDWITH
1773:         BINDEVENT(loc_oPagina.txt_4c_DiasVcto, "KeyPress", THIS, "ValidarDiasVcto")
1774: 
1775:         loc_oPagina.AddObject("lbl_4c_Label41", "Label")
1776:         WITH loc_oPagina.lbl_4c_Label41
1777:             .Caption   = "Juros Di" + CHR(225) + "rio(%) :"
1778:             .Top       = 387
1779:             .Left      = 296
1780:             .Width     = 90
1781:             .Height    = 15
1782:             .FontName  = "Tahoma"
1783:             .FontSize  = 8
1784:             .BackStyle = 0
1785:             .Visible   = .T.
1786:         ENDWITH
1787: 
1788:         loc_oPagina.AddObject("txt_4c_Juros", "TextBox")
1789:         WITH loc_oPagina.txt_4c_Juros
1790:             .Value     = 0.0
1791:             .Top       = 383
1792:             .Left      = 390
1793:             .Width     = 55
1794:             .Height    = 23
1795:             .FontName  = "Tahoma"
1796:             .FontSize  = 8
1797:             .Visible   = .T.
1798:         ENDWITH
1799: 
1800:         loc_oPagina.AddObject("lbl_4c_Label42", "Label")
1801:         WITH loc_oPagina.lbl_4c_Label42
1802:             .Caption   = "Moeda :"
1803:             .Top       = 387
1804:             .Left      = 452
1805:             .Width     = 47
1806:             .Height    = 15
1807:             .FontName  = "Tahoma"
1808:             .FontSize  = 8
1809:             .BackStyle = 0
1810:             .Visible   = .T.
1811:         ENDWITH
1812: 
1813:         loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
1814:         WITH loc_oPagina.txt_4c_Moeda
1815:             .Value     = ""
1816:             .Top       = 383
1817:             .Left      = 503
1818:             .Width     = 35
1819:             .Height    = 23
1820:             .MaxLength = 3
1821:             .FontName  = "Tahoma"
1822:             .FontSize  = 8
1823:             .Visible   = .T.
1824:         ENDWITH
1825:         BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
1826: 
1827:         loc_oPagina.AddObject("lbl_4c_Label43", "Label")
1828:         WITH loc_oPagina.lbl_4c_Label43
1829:             .Caption   = "Vlr.Lim.Aprov. :"
1830:             .Top       = 387
1831:             .Left      = 544
1832:             .Width     = 100
1833:             .Height    = 15
1834:             .FontName  = "Tahoma"
1835:             .FontSize  = 8
1836:             .BackStyle = 0
1837:             .Visible   = .T.
1838:         ENDWITH
1839: 
1840:         loc_oPagina.AddObject("txt_4c_VlrLimApv", "TextBox")
1841:         WITH loc_oPagina.txt_4c_VlrLimApv
1842:             .Value     = 0.0
1843:             .Top       = 383
1844:             .Left      = 648
1845:             .Width     = 95
1846:             .Height    = 23
1847:             .FontName  = "Tahoma"
1848:             .FontSize  = 8
1849:             .Visible   = .T.
1850:         ENDWITH
1851: 
1852:         *----------------------------------------------------------------------
1853:         *-- Linha 16: Pasta(s)
1854:         *----------------------------------------------------------------------
1855: 
1856:         loc_oPagina.AddObject("lbl_4c_Label44", "Label")
1857:         WITH loc_oPagina.lbl_4c_Label44
1858:             .Caption   = "Pasta(s) :"
1859:             .Top       = 412
1860:             .Left      = 37
1861:             .Width     = 58
1862:             .Height    = 15
1863:             .FontName  = "Tahoma"
1864:             .FontSize  = 8
1865:             .BackStyle = 0
1866:             .Visible   = .T.
1867:         ENDWITH
1868: 
1869:         loc_oPagina.AddObject("txt_4c_Pasta", "TextBox")
1870:         WITH loc_oPagina.txt_4c_Pasta
1871:             .Value     = ""
1872:             .Top       = 408
1873:             .Left      = 99
1874:             .Width     = 620
1875:             .Height    = 23
1876:             .MaxLength = 250
1877:             .FontName  = "Tahoma"
1878:             .FontSize  = 8
1879:             .Visible   = .T.
1880:         ENDWITH
1881: 
1882:         loc_oPagina.AddObject("cmd_4c_BtnPastasCl", "CommandButton")
1883:         WITH loc_oPagina.cmd_4c_BtnPastasCl
1884:             .Caption       = "..."
1885:             .Top           = 408
1886:             .Left          = 723
1887:             .Width         = 25
1888:             .Height        = 23
1889:             .FontName      = "Tahoma"
1890:             .FontSize      = 8
1891:             .SpecialEffect = 0
1892:             .Visible       = .T.
1893:         ENDWITH
1894:         BINDEVENT(loc_oPagina.cmd_4c_BtnPastasCl, "Click", THIS, "BtnPastasCClick")
1895: 
1896:         *----------------------------------------------------------------------
1897:         *-- Linha 17: Grupos Padr" + CHR(227) + "o (Emitente/Portador/C.Custo/Ag.Cobrador)
1898:         *----------------------------------------------------------------------
1899: 
1900:         loc_oPagina.AddObject("lbl_4c_Label45", "Label")
1901:         WITH loc_oPagina.lbl_4c_Label45
1902:             .Caption   = "Gr.Emitente :"
1903:             .Top       = 437
1904:             .Left      = 10
1905:             .Width     = 82
1906:             .Height    = 15
1907:             .FontName  = "Tahoma"
1908:             .FontSize  = 8
1909:             .BackStyle = 0
1910:             .Visible   = .T.
1911:         ENDWITH
1912: 
1913:         loc_oPagina.AddObject("txt_4c_Grupo1", "TextBox")
1914:         WITH loc_oPagina.txt_4c_Grupo1
1915:             .Value     = ""
1916:             .Top       = 433
1917:             .Left      = 97
1918:             .Width     = 85
1919:             .Height    = 23
1920:             .MaxLength = 10
1921:             .FontName  = "Tahoma"
1922:             .FontSize  = 8
1923:             .Visible   = .T.
1924:         ENDWITH
1925: 
1926:         loc_oPagina.AddObject("lbl_4c_Label46", "Label")
1927:         WITH loc_oPagina.lbl_4c_Label46
1928:             .Caption   = "Gr.Portador :"
1929:             .Top       = 437
1930:             .Left      = 193
1931:             .Width     = 80
1932:             .Height    = 15
1933:             .FontName  = "Tahoma"
1934:             .FontSize  = 8
1935:             .BackStyle = 0
1936:             .Visible   = .T.
1937:         ENDWITH
1938: 
1939:         loc_oPagina.AddObject("txt_4c_Grupo2", "TextBox")
1940:         WITH loc_oPagina.txt_4c_Grupo2
1941:             .Value     = ""
1942:             .Top       = 433
1943:             .Left      = 278
1944:             .Width     = 85
1945:             .Height    = 23
1946:             .MaxLength = 10
1947:             .FontName  = "Tahoma"
1948:             .FontSize  = 8
1949:             .Visible   = .T.
1950:         ENDWITH
1951: 
1952:         loc_oPagina.AddObject("lbl_4c_Label47", "Label")
1953:         WITH loc_oPagina.lbl_4c_Label47
1954:             .Caption   = "Gr.C.Custo :"
1955:             .Top       = 437
1956:             .Left      = 374
1957:             .Width     = 77
1958:             .Height    = 15
1959:             .FontName  = "Tahoma"
1960:             .FontSize  = 8
1961:             .BackStyle = 0
1962:             .Visible   = .T.
1963:         ENDWITH
1964: 
1965:         loc_oPagina.AddObject("txt_4c_Grupo3", "TextBox")
1966:         WITH loc_oPagina.txt_4c_Grupo3
1967:             .Value     = ""
1968:             .Top       = 433
1969:             .Left      = 456
1970:             .Width     = 85
1971:             .Height    = 23
1972:             .MaxLength = 10
1973:             .FontName  = "Tahoma"
1974:             .FontSize  = 8
1975:             .Visible   = .T.
1976:         ENDWITH
1977: 
1978:         loc_oPagina.AddObject("lbl_4c_Label48", "Label")
1979:         WITH loc_oPagina.lbl_4c_Label48
1980:             .Caption   = "Gr.Ag.Cobr. :"
1981:             .Top       = 437
1982:             .Left      = 548
1983:             .Width     = 83
1984:             .Height    = 15
1985:             .FontName  = "Tahoma"
1986:             .FontSize  = 8
1987:             .BackStyle = 0
1988:             .Visible   = .T.
1989:         ENDWITH
1990: 
1991:         loc_oPagina.AddObject("txt_4c_Grupo4", "TextBox")
1992:         WITH loc_oPagina.txt_4c_Grupo4
1993:             .Value     = ""
1994:             .Top       = 433
1995:             .Left      = 636
1996:             .Width     = 85
1997:             .Height    = 23
1998:             .MaxLength = 10
1999:             .FontName  = "Tahoma"
2000:             .FontSize  = 8
2001:             .Visible   = .T.
2002:         ENDWITH
2003: 
2004:         *----------------------------------------------------------------------
2005:         *-- Linha 18: T" + CHR(237) + "tulos dos Campos
2006:         *----------------------------------------------------------------------
2007: 
2008:         loc_oPagina.AddObject("lbl_4c_Label49", "Label")
2009:         WITH loc_oPagina.lbl_4c_Label49
2010:             .Caption   = "Tit.Emitente :"
2011:             .Top       = 461
2012:             .Left      = 10
2013:             .Width     = 82
2014:             .Height    = 15
2015:             .FontName  = "Tahoma"
2016:             .FontSize  = 8
2017:             .BackStyle = 0
2018:             .Visible   = .T.
2019:         ENDWITH
2020: 
2021:         loc_oPagina.AddObject("txt_4c_Txt01", "TextBox")
2022:         WITH loc_oPagina.txt_4c_Txt01
2023:             .Value     = ""
2024:             .Top       = 457
2025:             .Left      = 97
2026:             .Width     = 90
2027:             .Height    = 23
2028:             .MaxLength = 15
2029:             .FontName  = "Tahoma"
2030:             .FontSize  = 8
2031:             .Visible   = .T.
2032:         ENDWITH
2033: 
2034:         loc_oPagina.AddObject("lbl_4c_Label50", "Label")
2035:         WITH loc_oPagina.lbl_4c_Label50
2036:             .Caption   = "Tit.Portador :"
2037:             .Top       = 461
2038:             .Left      = 196
2039:             .Width     = 80
2040:             .Height    = 15
2041:             .FontName  = "Tahoma"
2042:             .FontSize  = 8
2043:             .BackStyle = 0
2044:             .Visible   = .T.
2045:         ENDWITH
2046: 
2047:         loc_oPagina.AddObject("txt_4c_Txt02", "TextBox")
2048:         WITH loc_oPagina.txt_4c_Txt02
2049:             .Value     = ""
2050:             .Top       = 457
2051:             .Left      = 281
2052:             .Width     = 90
2053:             .Height    = 23
2054:             .MaxLength = 15
2055:             .FontName  = "Tahoma"
2056:             .FontSize  = 8
2057:             .Visible   = .T.
2058:         ENDWITH
2059: 
2060:         loc_oPagina.AddObject("lbl_4c_Label51", "Label")
2061:         WITH loc_oPagina.lbl_4c_Label51
2062:             .Caption   = "Tit.C.Custo :"
2063:             .Top       = 461
2064:             .Left      = 380
2065:             .Width     = 75
2066:             .Height    = 15
2067:             .FontName  = "Tahoma"
2068:             .FontSize  = 8
2069:             .BackStyle = 0
2070:             .Visible   = .T.
2071:         ENDWITH
2072: 
2073:         loc_oPagina.AddObject("txt_4c_Txt03", "TextBox")
2074:         WITH loc_oPagina.txt_4c_Txt03
2075:             .Value     = ""
2076:             .Top       = 457
2077:             .Left      = 460
2078:             .Width     = 90
2079:             .Height    = 23
2080:             .MaxLength = 15
2081:             .FontName  = "Tahoma"
2082:             .FontSize  = 8
2083:             .Visible   = .T.
2084:         ENDWITH
2085: 
2086:         loc_oPagina.AddObject("lbl_4c_Label52", "Label")
2087:         WITH loc_oPagina.lbl_4c_Label52
2088:             .Caption   = "Tit.Agente :"
2089:             .Top       = 461
2090:             .Left      = 560
2091:             .Width     = 72
2092:             .Height    = 15
2093:             .FontName  = "Tahoma"
2094:             .FontSize  = 8
2095:             .BackStyle = 0
2096:             .Visible   = .T.
2097:         ENDWITH
2098: 
2099:         loc_oPagina.AddObject("txt_4c_Txt04", "TextBox")
2100:         WITH loc_oPagina.txt_4c_Txt04
2101:             .Value     = ""
2102:             .Top       = 457
2103:             .Left      = 638
2104:             .Width     = 90
2105:             .Height    = 23
2106:             .MaxLength = 15
2107:             .FontName  = "Tahoma"
2108:             .FontSize  = 8
2109:             .Visible   = .T.
2110:         ENDWITH
2111: 
2112:         *----------------------------------------------------------------------
2113:         *-- Linhas 19-20: Grupos Cadastrais 1-2 e 3-4
2114:         *----------------------------------------------------------------------
2115: 
2116:         loc_oPagina.AddObject("lbl_4c_Label53", "Label")
2117:         WITH loc_oPagina.lbl_4c_Label53
2118:             .Caption   = "Gr.Cad.1 :"
2119:             .Top       = 487
2120:             .Left      = 10
2121:             .Width     = 66
2122:             .Height    = 15
2123:             .FontName  = "Tahoma"
2124:             .FontSize  = 8
2125:             .BackStyle = 0
2126:             .Visible   = .T.
2127:         ENDWITH
2128: 
2129:         loc_oPagina.AddObject("txt_4c_GrpCad1", "TextBox")
2130:         WITH loc_oPagina.txt_4c_GrpCad1
2131:             .Value     = ""
2132:             .Top       = 483
2133:             .Left      = 80
2134:             .Width     = 65
2135:             .Height    = 23
2136:             .MaxLength = 10
2137:             .FontName  = "Tahoma"
2138:             .FontSize  = 8
2139:             .Visible   = .T.
2140:         ENDWITH
2141:         BINDEVENT(loc_oPagina.txt_4c_GrpCad1, "KeyPress", THIS, "ValidarGrpCad1s")
2142: 
2143:         loc_oPagina.AddObject("txt_4c_DGrpCad1", "TextBox")
2144:         WITH loc_oPagina.txt_4c_DGrpCad1
2145:             .Value     = ""
2146:             .Top       = 483
2147:             .Left      = 150
2148:             .Width     = 200
2149:             .Height    = 23
2150:             .ReadOnly  = .T.
2151:             .Enabled   = .T.
2152:             .FontName  = "Tahoma"
2153:             .FontSize  = 8
2154:             .Visible   = .T.
2155:         ENDWITH
2156: 
2157:         loc_oPagina.AddObject("lbl_4c_Label54", "Label")
2158:         WITH loc_oPagina.lbl_4c_Label54
2159:             .Caption   = "Gr.Cad.2 :"
2160:             .Top       = 487
2161:             .Left      = 365
2162:             .Width     = 66
2163:             .Height    = 15
2164:             .FontName  = "Tahoma"
2165:             .FontSize  = 8
2166:             .BackStyle = 0
2167:             .Visible   = .T.
2168:         ENDWITH
2169: 
2170:         loc_oPagina.AddObject("txt_4c_GrpCad2", "TextBox")
2171:         WITH loc_oPagina.txt_4c_GrpCad2
2172:             .Value     = ""
2173:             .Top       = 483
2174:             .Left      = 436
2175:             .Width     = 65
2176:             .Height    = 23
2177:             .MaxLength = 10
2178:             .FontName  = "Tahoma"
2179:             .FontSize  = 8
2180:             .Visible   = .T.
2181:         ENDWITH
2182:         BINDEVENT(loc_oPagina.txt_4c_GrpCad2, "KeyPress", THIS, "ValidarGrpCad2s")
2183: 
2184:         loc_oPagina.AddObject("txt_4c_DGrpCad2", "TextBox")
2185:         WITH loc_oPagina.txt_4c_DGrpCad2
2186:             .Value     = ""
2187:             .Top       = 483
2188:             .Left      = 506
2189:             .Width     = 200
2190:             .Height    = 23
2191:             .ReadOnly  = .T.
2192:             .Enabled   = .T.
2193:             .FontName  = "Tahoma"
2194:             .FontSize  = 8
2195:             .Visible   = .T.
2196:         ENDWITH
2197: 
2198:         loc_oPagina.AddObject("lbl_4c_Label55", "Label")
2199:         WITH loc_oPagina.lbl_4c_Label55
2200:             .Caption   = "Gr.Cad.3 :"
2201:             .Top       = 511
2202:             .Left      = 10
2203:             .Width     = 66
2204:             .Height    = 15
2205:             .FontName  = "Tahoma"
2206:             .FontSize  = 8
2207:             .BackStyle = 0
2208:             .Visible   = .T.
2209:         ENDWITH
2210: 
2211:         loc_oPagina.AddObject("txt_4c_GrpCad3", "TextBox")
2212:         WITH loc_oPagina.txt_4c_GrpCad3
2213:             .Value     = ""
2214:             .Top       = 507
2215:             .Left      = 80
2216:             .Width     = 65
2217:             .Height    = 23
2218:             .MaxLength = 10
2219:             .FontName  = "Tahoma"
2220:             .FontSize  = 8
2221:             .Visible   = .T.
2222:         ENDWITH
2223:         BINDEVENT(loc_oPagina.txt_4c_GrpCad3, "KeyPress", THIS, "ValidarGrpCad3s")
2224: 
2225:         loc_oPagina.AddObject("txt_4c_DGrpCad3", "TextBox")
2226:         WITH loc_oPagina.txt_4c_DGrpCad3
2227:             .Value     = ""
2228:             .Top       = 507
2229:             .Left      = 150
2230:             .Width     = 200
2231:             .Height    = 23
2232:             .ReadOnly  = .T.
2233:             .Enabled   = .T.
2234:             .FontName  = "Tahoma"
2235:             .FontSize  = 8
2236:             .Visible   = .T.
2237:         ENDWITH
2238: 
2239:         loc_oPagina.AddObject("lbl_4c_Label56", "Label")
2240:         WITH loc_oPagina.lbl_4c_Label56
2241:             .Caption   = "Gr.Cad.4 :"
2242:             .Top       = 511
2243:             .Left      = 365
2244:             .Width     = 66
2245:             .Height    = 15
2246:             .FontName  = "Tahoma"
2247:             .FontSize  = 8
2248:             .BackStyle = 0
2249:             .Visible   = .T.
2250:         ENDWITH
2251: 
2252:         loc_oPagina.AddObject("txt_4c_GrpCad4", "TextBox")
2253:         WITH loc_oPagina.txt_4c_GrpCad4
2254:             .Value     = ""
2255:             .Top       = 507
2256:             .Left      = 436
2257:             .Width     = 65
2258:             .Height    = 23
2259:             .MaxLength = 10
2260:             .FontName  = "Tahoma"
2261:             .FontSize  = 8
2262:             .Visible   = .T.
2263:         ENDWITH
2264:         BINDEVENT(loc_oPagina.txt_4c_GrpCad4, "KeyPress", THIS, "ValidarGrpCad4s")
2265: 
2266:         loc_oPagina.AddObject("txt_4c_DGrpCad4", "TextBox")
2267:         WITH loc_oPagina.txt_4c_DGrpCad4
2268:             .Value     = ""
2269:             .Top       = 507
2270:             .Left      = 506
2271:             .Width     = 200
2272:             .Height    = 23
2273:             .ReadOnly  = .T.
2274:             .Enabled   = .T.
2275:             .FontName  = "Tahoma"

*-- Linhas 2281 a 2443:
2281:         *-- Linhas 21-22: Classes Cont" + CHR(225) + "beis 1-4 com Obrigatoriedade
2282:         *----------------------------------------------------------------------
2283: 
2284:         loc_oPagina.AddObject("lbl_4c_Label57", "Label")
2285:         WITH loc_oPagina.lbl_4c_Label57
2286:             .Caption   = "Classe 1 :"
2287:             .Top       = 538
2288:             .Left      = 10
2289:             .Width     = 60
2290:             .Height    = 15
2291:             .FontName  = "Tahoma"
2292:             .FontSize  = 8
2293:             .BackStyle = 0
2294:             .Visible   = .T.
2295:         ENDWITH
2296: 
2297:         loc_oPagina.AddObject("txt_4c_Class1", "TextBox")
2298:         WITH loc_oPagina.txt_4c_Class1
2299:             .Value     = ""
2300:             .Top       = 534
2301:             .Left      = 74
2302:             .Width     = 30
2303:             .Height    = 23
2304:             .MaxLength = 1
2305:             .FontName  = "Tahoma"
2306:             .FontSize  = 8
2307:             .Visible   = .T.
2308:         ENDWITH
2309:         BINDEVENT(loc_oPagina.txt_4c_Class1, "KeyPress", THIS, "ValidarClass1s")
2310: 
2311:         loc_oPagina.AddObject("chk_4c_ObrigC1", "CheckBox")
2312:         WITH loc_oPagina.chk_4c_ObrigC1
2313:             .Caption   = "Obrigat" + CHR(243) + "ria"
2314:             .Top       = 536
2315:             .Left      = 109
2316:             .Width     = 80
2317:             .Height    = 17
2318:             .Value     = 0
2319:             .FontName  = "Tahoma"
2320:             .FontSize  = 8
2321:             .BackStyle = 0
2322:             .Visible   = .T.
2323:         ENDWITH
2324: 
2325:         loc_oPagina.AddObject("lbl_4c_Label58", "Label")
2326:         WITH loc_oPagina.lbl_4c_Label58
2327:             .Caption   = "Classe 2 :"
2328:             .Top       = 538
2329:             .Left      = 200
2330:             .Width     = 60
2331:             .Height    = 15
2332:             .FontName  = "Tahoma"
2333:             .FontSize  = 8
2334:             .BackStyle = 0
2335:             .Visible   = .T.
2336:         ENDWITH
2337: 
2338:         loc_oPagina.AddObject("txt_4c_Class2", "TextBox")
2339:         WITH loc_oPagina.txt_4c_Class2
2340:             .Value     = ""
2341:             .Top       = 534
2342:             .Left      = 264
2343:             .Width     = 30
2344:             .Height    = 23
2345:             .MaxLength = 1
2346:             .FontName  = "Tahoma"
2347:             .FontSize  = 8
2348:             .Visible   = .T.
2349:         ENDWITH
2350:         BINDEVENT(loc_oPagina.txt_4c_Class2, "KeyPress", THIS, "ValidarClass2s")
2351: 
2352:         loc_oPagina.AddObject("chk_4c_ObrigC2", "CheckBox")
2353:         WITH loc_oPagina.chk_4c_ObrigC2
2354:             .Caption   = "Obrigat" + CHR(243) + "ria"
2355:             .Top       = 536
2356:             .Left      = 299
2357:             .Width     = 80
2358:             .Height    = 17
2359:             .Value     = 0
2360:             .FontName  = "Tahoma"
2361:             .FontSize  = 8
2362:             .BackStyle = 0
2363:             .Visible   = .T.
2364:         ENDWITH
2365: 
2366:         loc_oPagina.AddObject("lbl_4c_Label59", "Label")
2367:         WITH loc_oPagina.lbl_4c_Label59
2368:             .Caption   = "Classe 3 :"
2369:             .Top       = 538
2370:             .Left      = 395
2371:             .Width     = 60
2372:             .Height    = 15
2373:             .FontName  = "Tahoma"
2374:             .FontSize  = 8
2375:             .BackStyle = 0
2376:             .Visible   = .T.
2377:         ENDWITH
2378: 
2379:         loc_oPagina.AddObject("txt_4c_Class3", "TextBox")
2380:         WITH loc_oPagina.txt_4c_Class3
2381:             .Value     = ""
2382:             .Top       = 534
2383:             .Left      = 459
2384:             .Width     = 30
2385:             .Height    = 23
2386:             .MaxLength = 1
2387:             .FontName  = "Tahoma"
2388:             .FontSize  = 8
2389:             .Visible   = .T.
2390:         ENDWITH
2391:         BINDEVENT(loc_oPagina.txt_4c_Class3, "KeyPress", THIS, "ValidarClass3s")
2392: 
2393:         loc_oPagina.AddObject("chk_4c_ObrigC3", "CheckBox")
2394:         WITH loc_oPagina.chk_4c_ObrigC3
2395:             .Caption   = "Obrigat" + CHR(243) + "ria"
2396:             .Top       = 536
2397:             .Left      = 494
2398:             .Width     = 80
2399:             .Height    = 17
2400:             .Value     = 0
2401:             .FontName  = "Tahoma"
2402:             .FontSize  = 8
2403:             .BackStyle = 0
2404:             .Visible   = .T.
2405:         ENDWITH
2406: 
2407:         loc_oPagina.AddObject("lbl_4c_Label60", "Label")
2408:         WITH loc_oPagina.lbl_4c_Label60
2409:             .Caption   = "Classe 4 :"
2410:             .Top       = 538
2411:             .Left      = 590
2412:             .Width     = 60
2413:             .Height    = 15
2414:             .FontName  = "Tahoma"
2415:             .FontSize  = 8
2416:             .BackStyle = 0
2417:             .Visible   = .T.
2418:         ENDWITH
2419: 
2420:         loc_oPagina.AddObject("txt_4c_Class4", "TextBox")
2421:         WITH loc_oPagina.txt_4c_Class4
2422:             .Value     = ""
2423:             .Top       = 534
2424:             .Left      = 654
2425:             .Width     = 30
2426:             .Height    = 23
2427:             .MaxLength = 1
2428:             .FontName  = "Tahoma"
2429:             .FontSize  = 8
2430:             .Visible   = .T.
2431:         ENDWITH
2432:         BINDEVENT(loc_oPagina.txt_4c_Class4, "KeyPress", THIS, "ValidarClass4s")
2433: 
2434:         loc_oPagina.AddObject("chk_4c_ObrigC4", "CheckBox")
2435:         WITH loc_oPagina.chk_4c_ObrigC4
2436:             .Caption   = "Obrigat" + CHR(243) + "ria"
2437:             .Top       = 536
2438:             .Left      = 689
2439:             .Width     = 80
2440:             .Height    = 17
2441:             .Value     = 0
2442:             .FontName  = "Tahoma"
2443:             .FontSize  = 8

*-- Linhas 2468 a 2478:
2468:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ndopes"
2469:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
2470:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Opers"
2471:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(186)
2472:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2473:                         loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2474:                         THIS.FormatarGridLista(loc_oGrid)
2475:                     ENDIF
2476:                 ENDIF
2477:             CATCH TO loc_oErro
2478:                 MsgErro(loc_oErro.Message, "FormOTI.CarregarLista")

*-- Linhas 3489 a 3510:
3489:                 loc_oPg2.txt_4c_VlrLimApv.Enabled = par_lHabilitar
3490:             ENDIF
3491:             IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
3492:                 loc_oPg2.txt_4c_Pasta.Enabled = par_lHabilitar
3493:             ENDIF
3494:             IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnPastasCl", 5)
3495:                 loc_oPg2.cmd_4c_BtnPastasCl.Enabled = par_lHabilitar
3496:             ENDIF
3497:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo1", 5)
3498:                 loc_oPg2.txt_4c_Grupo1.Enabled = par_lHabilitar
3499:             ENDIF
3500:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo2", 5)
3501:                 loc_oPg2.txt_4c_Grupo2.Enabled = par_lHabilitar
3502:             ENDIF
3503:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo3", 5)
3504:                 loc_oPg2.txt_4c_Grupo3.Enabled = par_lHabilitar
3505:             ENDIF
3506:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo4", 5)
3507:                 loc_oPg2.txt_4c_Grupo4.Enabled = par_lHabilitar
3508:             ENDIF
3509:             IF PEMSTATUS(loc_oPg2, "txt_4c_Txt01", 5)
3510:                 loc_oPg2.txt_4c_Txt01.Enabled = par_lHabilitar

*-- Linhas 3556 a 3565:
3556:             ENDIF
3557:             *-- Bot" + CHR(227) + "o Confirmar: s" + CHR(243) + " habilita em INCLUIR/ALTERAR
3558:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
3559:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
3560:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
3561:                 ENDIF
3562:             ENDIF
3563: 
3564:         CATCH TO loc_oErro
3565:             MsgErro(loc_oErro.Message, "FormOTI.HabilitarCampos")

*-- Linhas 4359 a 4372:
4359:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
4360:                 loc_oCnt = loc_oPg2.cnt_4c_BotoesAcao
4361: 
4362:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
4363:                     loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEdicao
4364:                 ENDIF
4365: 
4366:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
4367:                     loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
4368:                 ENDIF
4369:             ENDIF
4370:         CATCH TO loc_oErro
4371:             MsgErro(loc_oErro.Message, "FormOTI.AjustarBotoesPorModo")
4372:         ENDTRY


### BO (C:\4c\projeto\app\classes\OTIBO.prg):
*==============================================================================
* OTIBO.prg - Business Object para Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos
* Tabela principal: SigOpOpe (PK: dopes char(20))
* Tabela secund" + CHR(225) + "ria: SigCdPrg (acessos por opera" + CHR(231) + CHR(227) + "o)
* Migrado de: sigCDOTI.SCX
*==============================================================================

DEFINE CLASS OTIBO AS BusinessBase

    *-- Identifica" + CHR(231) + CHR(227) + "o do registro
    this_cDopes      = ""   && dopes      PK char(20) - descri" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o
    this_nNdopes     = 0    && ndopes     auto-gerado numeric(10,0)
    this_cOpers      = "CR" && opers      CR=cr" + CHR(233) + "dito / DB=d" + CHR(233) + "bito char(2)
    this_nOpeCancs   = 0    && opecancs   0=Ativo / 1=Cancelado numeric(1,0)

    *-- Opera" + CHR(231) + CHR(245) + "es relacionadas
    this_cDopereals  = ""   && dopereals  opera" + CHR(231) + CHR(227) + "o Realizado char(20)
    this_cDopCancs   = ""   && dopcancs   opera" + CHR(231) + CHR(227) + "o Cancelamento char(20)
    this_cOpdepos    = ""   && opdepos    opera" + CHR(231) + CHR(227) + "o Dep" + CHR(243) + "sito char(15)

    *-- Hist" + CHR(243) + "rico e texto
    this_cHists      = ""   && hists      hist" + CHR(243) + "rico padr" + CHR(227) + "o char(30)
    this_nTpHists    = 2    && tphists    tipo hist" + CHR(243) + "rico numeric(1,0)
    this_cIdentifics = ""   && identifics identificador char(1)
    this_cPastas     = ""   && pastas     caminho pasta (text NULL)

    *-- Configura" + CHR(231) + CHR(227) + "o do t" + CHR(237) + "tulo
    this_nDiasVcto   = 0    && diasvcto   dias vencimento numeric(2,0)
    this_nQtdBols    = 0    && qtdbols    qtd vias boleto numeric(2,0)
    this_cCnMascaras = ""   && cnmascaras m" + CHR(225) + "scara NF char(10)
    this_nJuros      = 0    && juros      juros di" + CHR(225) + "rio (%) numeric(4,2)
    this_cMoedas     = ""   && moedas     moeda totalizador char(3)
    this_nVlrLimApv  = 0    && vlrlimapv  valor limite aprova" + CHR(231) + CHR(227) + "o numeric(11,2)

    *-- Op" + CHR(231) + CHR(245) + "es (OptionGroups, valor 1-indexed)
    this_nDadosPgs   = 1    && dadospgs   dados pagamento numeric(1,0)
    this_nCampoNfs   = 1    && camponfs   campo NF numeric(1,0)
    this_nBlqccs     = 2    && blqccs     bloquear C/C numeric(1,0)
    this_nPendencias = 1    && pendencias pend" + CHR(234) + "ncias numeric(1,0)
    this_nRealprevs  = 1    && realprevs  real/previsto numeric(1,0)
    this_nEmiPorDesp = 2    && emipordesp emitente=portador numeric(1,0)
    this_nValprev    = 2    && valprev    valor previsto numeric(1,0)
    this_nTitauts    = 1    && titauts    n" + CHR(186) + " t" + CHR(237) + "tulo autom" + CHR(225) + "tico numeric(1,0)
    this_nImpbols    = 2    && impbols    imprime boleto numeric(1,0)
    this_nCompets    = 1    && compets    compet" + CHR(234) + "ncia numeric(1,0)
    this_nAltTrans   = 1    && alttrans   realizar apenas autorizados numeric(1,0)
    this_nOutTits    = 2    && outtits    outros t" + CHR(237) + "tulos auto numeric(1,0)
    this_nFiltContas = 2    && filtcontas filtra conta p/ grupo numeric(1,0)
    this_nJobs       = 2    && jobs       jobs numeric(1,0)
    this_nImpdocs    = 2    && impdocs    imprime documento numeric(1,0)
    this_nLimcres    = 2    && limcres    checar limite cr" + CHR(233) + "dito numeric(1,0)

    *-- Grupos padr" + CHR(227) + "o
    this_cGrupo1s    = ""   && grupo1s    emitente char(10)
    this_cGrupo2s    = ""   && grupo2s    portador char(10)
    this_cGrupo3s    = ""   && grupo3s    centro de custo char(10)
    this_cGrupo4s    = ""   && grupo4s    agente cobrador char(10)

    *-- Grupos cadastrais
    this_cGrpCad1s   = ""   && grpcad1s   grupo cadastral 1 char(10)
    this_cGrpCad2s   = ""   && grpcad2s   grupo cadastral 2 char(10)
    this_cGrpCad3s   = ""   && grpcad3s   grupo cadastral 3 char(10)
    this_cGrpCad4s   = ""   && grpcad4s   grupo cadastral 4 char(10)
    this_cDGrpCad1s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 1
    this_cDGrpCad2s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 2
    this_cDGrpCad3s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 3
    this_cDGrpCad4s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 4

    *-- Classes cont" + CHR(225) + "beis char(1) - armazenadas como char no banco
    this_cClass1s    = ""   && class1s    classe cont" + CHR(225) + "bil 1 char(1)
    this_cClass2s    = ""   && class2s    classe cont" + CHR(225) + "bil 2 char(1)
    this_cClass3s    = ""   && class3s    classe cont" + CHR(225) + "bil 3 char(1)
    this_cClass4s    = ""   && class4s    classe cont" + CHR(225) + "bil 4 char(1)

    *-- T" + CHR(237) + "tulos dos campos
    this_cTxt01      = ""   && txt01      t" + CHR(237) + "tulo campo emitente char(15)
    this_cTxt02      = ""   && txt02      t" + CHR(237) + "tulo campo portador char(15)
    this_cTxt03      = ""   && txt03      t" + CHR(237) + "tulo campo centro custo char(15)
    this_cTxt04      = ""   && txt04      t" + CHR(237) + "tulo campo agente cobrador char(15)

    *-- Checkboxes (l" + CHR(243) + "gico; congvs=bit no banco, demais=numeric 0/1)
    this_lCongvs     = .F.  && congvs     bit NOT NULL
    this_lBlqTits    = .F.  && blqtits    numeric(1,0) NOT NULL
    this_lEspobrigs  = .F.  && espobrigs  numeric(1,0) NOT NULL
    this_lLancCCEs   = .F.  && lancCCEs   numeric(1,0) NOT NULL
    this_lLancCCAs   = .F.  && lancCCAs   numeric(1,0) NOT NULL
    this_lObsobrigs  = .F.  && obsobrigs  numeric(1,0) NOT NULL
    this_lObrigC1    = .F.  && obrigc1    numeric(1,0) NOT NULL
    this_lObrigC2    = .F.  && obrigc2    numeric(1,0) NOT NULL
    this_lObrigC3    = .F.  && obrigc3    numeric(1,0) NOT NULL
    this_lObrigC4    = .F.  && obrigc4    numeric(1,0) NOT NULL
    this_lObrCompet  = .F.  && obrcompet  numeric(1,0) NOT NULL

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpOpe"
            THIS.this_cCampoChave = "NDopes"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(TRANSFORM(THIS.this_nNdopes))
    ENDPROC

    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE UPPER(dopes) LIKE '%" + UPPER(par_cFiltro) + "%'"
            ENDIF

            loc_cSQL = "SELECT dopes, opers, ndopes FROM SigOpOpe" + loc_cWhere + " ORDER BY dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (dopes C(20), opers C(2), ndopes N(10,0))
                    SET NULL OFF
                ENDIF
                IF !EOF("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(par_nCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Reg")

            IF loc_nResult >= 0 AND !EOF("cursor_4c_Reg")
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Reg")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.CarregarPorCodigo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cDopes      = ALLTRIM(dopes)
            THIS.this_nNdopes     = ndopes
            THIS.this_cOpers      = ALLTRIM(opers)
            THIS.this_nOpeCancs   = opecancs
            THIS.this_cDopereals  = ALLTRIM(dopereals)
            THIS.this_cDopCancs   = ALLTRIM(dopcancs)
            THIS.this_cOpdepos    = ALLTRIM(opdepos)
            THIS.this_cHists      = ALLTRIM(hists)
            THIS.this_nTpHists    = tphists
            THIS.this_cIdentifics = ALLTRIM(identifics)
            THIS.this_cPastas     = IIF(ISNULL(pastas), "", ALLTRIM(pastas))
            THIS.this_nDiasVcto   = diasvcto
            THIS.this_nQtdBols    = qtdbols
            THIS.this_cCnMascaras = ALLTRIM(cnmascaras)
            THIS.this_nJuros      = juros
            THIS.this_cMoedas     = ALLTRIM(moedas)
            THIS.this_nVlrLimApv  = vlrlimapv
            THIS.this_nDadosPgs   = dadospgs
            THIS.this_nCampoNfs   = camponfs
            THIS.this_nBlqccs     = blqccs
            THIS.this_nPendencias = pendencias
            THIS.this_nRealprevs  = realprevs
            THIS.this_nEmiPorDesp = emipordesp
            THIS.this_nValprev    = valprev
            THIS.this_nTitauts    = titauts
            THIS.this_nImpbols    = impbols
            THIS.this_nCompets    = compets
            THIS.this_nAltTrans   = alttrans
            THIS.this_nOutTits    = outtits
            THIS.this_nFiltContas = filtcontas
            THIS.this_nJobs       = jobs
            THIS.this_nImpdocs    = impdocs
            THIS.this_nLimcres    = limcres
            THIS.this_cGrupo1s    = ALLTRIM(grupo1s)
            THIS.this_cGrupo2s    = ALLTRIM(grupo2s)
            THIS.this_cGrupo3s    = ALLTRIM(grupo3s)
            THIS.this_cGrupo4s    = ALLTRIM(grupo4s)
            THIS.this_cGrpCad1s   = ALLTRIM(grpcad1s)
            THIS.this_cGrpCad2s   = ALLTRIM(grpcad2s)
            THIS.this_cGrpCad3s   = ALLTRIM(grpcad3s)
            THIS.this_cGrpCad4s   = ALLTRIM(grpcad4s)
            THIS.this_cClass1s    = ALLTRIM(class1s)
            THIS.this_cClass2s    = ALLTRIM(class2s)
            THIS.this_cClass3s    = ALLTRIM(class3s)
            THIS.this_cClass4s    = ALLTRIM(class4s)
            THIS.this_cTxt01      = ALLTRIM(txt01)
            THIS.this_cTxt02      = ALLTRIM(txt02)
            THIS.this_cTxt03      = ALLTRIM(txt03)
            THIS.this_cTxt04      = ALLTRIM(txt04)
            THIS.this_lCongvs     = (congvs <> 0)
            THIS.this_lBlqTits    = (blqtits <> 0)
            THIS.this_lEspobrigs  = (espobrigs <> 0)
            THIS.this_lLancCCEs   = (lancCCEs <> 0)
            THIS.this_lLancCCAs   = (lancCCAs <> 0)
            THIS.this_lObsobrigs  = (obsobrigs <> 0)
            THIS.this_lObrigC1    = (obrigc1 <> 0)
            THIS.this_lObrigC2    = (obrigc2 <> 0)
            THIS.this_lObrigC3    = (obrigc3 <> 0)
            THIS.this_lObrigC4    = (obrigc4 <> 0)
            THIS.this_lObrCompet  = (obrcompet <> 0)

            THIS.this_cDGrpCad1s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad1s)
            THIS.this_cDGrpCad2s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad2s)
            THIS.this_cDGrpCad3s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad3s)
            THIS.this_cDGrpCad4s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad4s)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ValidarDados()
    *==========================================================================
        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF THIS.this_nRealprevs = 2 AND EMPTY(THIS.this_cDopereals)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Realizado obrigat" + CHR(243) + "ria quando tipo Previsto.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION VerificarCodigoDuplicado()
    *==========================================================================
        LOCAL loc_nCount, loc_nResult
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigOpOpe WHERE dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes)), ;
                "cursor_4c_Dup")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Dup")
                loc_nCount = cursor_4c_Dup.total
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN (loc_nCount > 0)
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterProximoNdopes()
    *==========================================================================
        LOCAL loc_nProximo, loc_nResult
        loc_nProximo = 1

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ndopes),0)+1 AS proximo FROM SigOpOpe", ;
                "cursor_4c_NxtN")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_NxtN")
                loc_nProximo = cursor_4c_NxtN.proximo
            ENDIF
            IF USED("cursor_4c_NxtN")
                USE IN cursor_4c_NxtN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nProximo
    ENDPROC

    *==========================================================================
    FUNCTION BuscarDescricaoGrpCad(par_cCodigo)
    *==========================================================================
        LOCAL loc_cDescr, loc_nResult
        loc_cDescr = ""

        IF EMPTY(par_cCodigo)
            RETURN ""
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_Gcr")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Gcr")
                loc_cDescr = ALLTRIM(cursor_4c_Gcr.descrs)
            ENDIF
            IF USED("cursor_4c_Gcr")
                USE IN cursor_4c_Gcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescr
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InserirSigCdPrgSeNaoExiste(par_cProg, par_cParam, par_cDesc, par_cBarraForms)
    *==========================================================================
        LOCAL loc_nCount, loc_nResult, loc_cSQL
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigCdPrg " + ;
                "WHERE Programas = " + EscaparSQL(par_cProg) + ;
                " AND RTRIM(Parametros) = " + EscaparSQL(RTRIM(par_cParam)), ;
                "cursor_4c_ChkPrg")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_ChkPrg")
                loc_nCount = cursor_4c_ChkPrg.total
            ENDIF
            IF USED("cursor_4c_ChkPrg")
                USE IN cursor_4c_ChkPrg
            ENDIF

            IF loc_nCount = 0
                loc_cSQL = "INSERT INTO SigCdPrg " + ;
                    "(Descricaos, Parametros, Programas, pkChaves, barraforms, barrapict) VALUES (" + ;
                    EscaparSQL(par_cDesc)       + ", " + ;
                    EscaparSQL(par_cParam)      + ", " + ;
                    EscaparSQL(par_cProg)       + ", " + ;
                    EscaparSQL(fUniqueIds())    + ", " + ;
                    EscaparSQL(par_cBarraForms) + ", " + ;
                    "''" + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarEntradasSigCdPrg(par_cDopes, par_nNdopes)
    *==========================================================================
        LOCAL loc_cProg, loc_cDesc, loc_cBarra
        loc_cProg  = "C" + PADL(TRANSFORM(par_nNdopes), 8, "0")
        loc_cDesc  = "Menu - Financeiro - T" + CHR(237) + "tulos - " + PROPER(ALLTRIM(par_cDopes))
        loc_cBarra = "SIGPGTIT WITH '" + ALLTRIM(par_cDopes) + "'"

        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "",          loc_cDesc,                                                                               loc_cBarra)
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "INSERIR",   loc_cDesc + " - [Inserir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAR",   loc_cDesc + " - [Alterar]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "EXCLUIR",   loc_cDesc + " - [Excluir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAR",    loc_cDesc + " - [Listar]",                                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TITULO",    loc_cDesc + " - [T" + CHR(237) + "tulo]",                                               "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OCORR",     loc_cDesc + " - [Ocorr" + CHR(234) + "ncias]",                                          "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTDATAS",  loc_cDesc + " - [Alterar Datas]",                                                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBVENCS",  loc_cDesc + " - [N" + CHR(227) + "o Checa Vcto. X Emiss" + CHR(227) + "o]",             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFREAL",   loc_cDesc + " - [Transfere para C/C]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAGERAL",loc_cDesc + " - [Lista Geral]",                                                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFPREV",   loc_cDesc + " - [Transfere p/ Previs" + CHR(227) + "o]",                                "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTCC",     loc_cDesc + " - [Altera Centro de Custo]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CANCELA",   loc_cDesc + " - [Cancelamento do T" + CHR(237) + "tulo ]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "PRORROGAR", loc_cDesc + " - [Prorrogar T" + CHR(237) + "tulo ]",                                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CONFERIR",  loc_cDesc + " - [Conferir T" + CHR(237) + "tulo ]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAAGC", loc_cDesc + " - [Altera Agente Cobrador]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "AUTOBLQ",   loc_cDesc + " - [Inibir Alerta de Fora do Per" + CHR(237) + "odo]",                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIMPADTT",  loc_cDesc + " - [Desmarca Transporte]",                                                 "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "SUBSTITUI", loc_cDesc + " - [Substitui" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulo]",      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUP",  loc_cDesc + " - [Follow up de Conta]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUPI", loc_cDesc + " - [Follow up de Lan" + CHR(231) + "amento]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLOQVENCS", loc_cDesc + " - [Bloqueio de T" + CHR(237) + "tulos Vencidos]",                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTARQCON", loc_cDesc + " - [Altera Arq. Relac. na Consulta]",                                      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLQDTLANC", loc_cDesc + " - [N" + CHR(227) + "o Altera Data de Lan" + CHR(231) + "amento]",         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "MULTIAPROV",loc_cDesc + " - [Permite Aprovar Mais de um T" + CHR(237) + "tulo]",                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "APVVLRSUP", loc_cDesc + " - [Permite Aprovar Um T" + CHR(237) + "tulo Com Valor Acima do Permitido.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAVENC",loc_cDesc + " - [Permite Prorrogar o Vencimento.]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OUTRESPONS",loc_cDesc + " - [Permite Aprovar T" + CHR(237) + "tulos de Outros Respons" + CHR(225) + "veis.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OBSRESUMO", loc_cDesc + " - [Observa" + CHR(231) + CHR(227) + "o resumida.]",                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBAPROV",  loc_cDesc + " - [Permite Alterar T" + CHR(237) + "tulos Aprovados.]",                   "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBCARTAO", loc_cDesc + " - [Libera Visualizar Cart" + CHR(245) + "es.]",                           "")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_nNdopes = THIS.ObterProximoNdopes()

            loc_cSQL = "INSERT INTO SigOpOpe (" + ;
                "dopes, ndopes, ordes, datas, opers, " + ;
                "opdepos, hists, tphists, fixgrupes, grupoeps, identifics, " + ;
                "titauts, txt01, txt02, txt03, txt04, impbols, " + ;
                "grupo1s, grupo2s, grupo3s, grupo4s, " + ;
                "grpcad1s, grpcad2s, grpcad3s, grpcad4s, " + ;
                "valprev, qtdbols, compets, congvs, " + ;
                "dopereals, pendencias, realprevs, blqccs, alttrans, bloqueios, " + ;
                "impdocs, cnmascaras, dopcancs, opecancs, " + ;
                "blqtits, outtits, soldocs, camponfs, dadospgs, espobrigs, " + ;
                "juros, filtcontas, lancCCAs, lancCCEs, obsobrigs, jobs, " + ;
                "class1s, class2s, class3s, class4s, buscanome, " + ;
                "diasvcto, emipordesp, limcres, moedas, obrcompet, " + ;
                "obrigc1, obrigc2, obrigc3, obrigc4, " + ;
                "pastas, vlrlimapv, InibEmpHst, edthists, rateiocf" + ;
                ") VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdopes)        + ", " + ;
                "0, GETDATE(), "                           + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpers))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpdepos))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cHists))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpHists)       + ", " + ;
                "0, '', "                                  + ;
                EscaparSQL(ALLTRIM(THIS.this_cIdentifics))  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTitauts)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt01))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt02))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt03))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt04))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpbols)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nValprev)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdBols)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nCompets)       + ", " + ;
                IIF(THIS.this_lCongvs,   "1", "0")         + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopereals))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPendencias)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nRealprevs)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqccs)        + ", " + ;
                FormatarNumeroSQL(THIS.this_nAltTrans)      + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nImpdocs)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCnMascaras))  + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopCancs))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOpeCancs)      + ", " + ;
                IIF(THIS.this_lBlqTits,   "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nOutTits)       + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nCampoNfs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nDadosPgs)      + ", " + ;
                IIF(THIS.this_lEspobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJuros)         + ", " + ;
                FormatarNumeroSQL(THIS.this_nFiltContas)    + ", " + ;
                IIF(THIS.this_lLancCCAs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lLancCCEs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lObsobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJobs)          + ", " + ;
                EscaparSQL(THIS.this_cClass1s)              + ", " + ;
                EscaparSQL(THIS.this_cClass2s)              + ", " + ;
                EscaparSQL(THIS.this_cClass3s)              + ", " + ;
                EscaparSQL(THIS.this_cClass4s)              + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nDiasVcto)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmiPorDesp)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLimcres)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoedas))      + ", " + ;
                IIF(THIS.this_lObrCompet, "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC1,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC2,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC3,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC4,   "1", "0")        + ", " + ;
                IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrLimApv)    + ", " + ;
                "0, 0, 0)"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOpe SET " + ;
                "opers       = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))      + ", " + ;
                "opdepos     = " + EscaparSQL(ALLTRIM(THIS.this_cOpdepos))    + ", " + ;
                "hists       = " + EscaparSQL(ALLTRIM(THIS.this_cHists))      + ", " + ;
                "tphists     = " + FormatarNumeroSQL(THIS.this_nTpHists)      + ", " + ;
                "identifics  = " + EscaparSQL(ALLTRIM(THIS.this_cIdentifics)) + ", " + ;
                "titauts     = " + FormatarNumeroSQL(THIS.this_nTitauts)      + ", " + ;
                "txt01       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt01))      + ", " + ;
                "txt02       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt02))      + ", " + ;
                "txt03       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt03))      + ", " + ;
                "txt04       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt04))      + ", " + ;
                "impbols     = " + FormatarNumeroSQL(THIS.this_nImpbols)      + ", " + ;
                "grupo1s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))    + ", " + ;
                "grupo2s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))    + ", " + ;
                "grupo3s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))    + ", " + ;
                "grupo4s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))    + ", " + ;
                "grpcad1s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))   + ", " + ;
                "grpcad2s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))   + ", " + ;
                "grpcad3s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))   + ", " + ;
                "grpcad4s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))   + ", " + ;
                "valprev     = " + FormatarNumeroSQL(THIS.this_nValprev)      + ", " + ;
                "qtdbols     = " + FormatarNumeroSQL(THIS.this_nQtdBols)      + ", " + ;
                "compets     = " + FormatarNumeroSQL(THIS.this_nCompets)      + ", " + ;
                "congvs      = " + IIF(THIS.this_lCongvs,   "1", "0")        + ", " + ;
                "dopereals   = " + EscaparSQL(ALLTRIM(THIS.this_cDopereals))  + ", " + ;
                "pendencias  = " + FormatarNumeroSQL(THIS.this_nPendencias)   + ", " + ;
                "realprevs   = " + FormatarNumeroSQL(THIS.this_nRealprevs)    + ", " + ;
                "blqccs      = " + FormatarNumeroSQL(THIS.this_nBlqccs)       + ", " + ;
                "alttrans    = " + FormatarNumeroSQL(THIS.this_nAltTrans)     + ", " + ;
                "impdocs     = " + FormatarNumeroSQL(THIS.this_nImpdocs)      + ", " + ;
                "cnmascaras  = " + EscaparSQL(ALLTRIM(THIS.this_cCnMascaras)) + ", " + ;
                "dopcancs    = " + EscaparSQL(ALLTRIM(THIS.this_cDopCancs))   + ", " + ;
                "blqtits     = " + IIF(THIS.this_lBlqTits,   "1", "0")       + ", " + ;
                "outtits     = " + FormatarNumeroSQL(THIS.this_nOutTits)      + ", " + ;
                "camponfs    = " + FormatarNumeroSQL(THIS.this_nCampoNfs)     + ", " + ;
                "dadospgs    = " + FormatarNumeroSQL(THIS.this_nDadosPgs)     + ", " + ;
                "espobrigs   = " + IIF(THIS.this_lEspobrigs, "1", "0")       + ", " + ;
                "juros       = " + FormatarNumeroSQL(THIS.this_nJuros)        + ", " + ;
                "filtcontas  = " + FormatarNumeroSQL(THIS.this_nFiltContas)   + ", " + ;
                "lancCCAs    = " + IIF(THIS.this_lLancCCAs,  "1", "0")       + ", " + ;
                "lancCCEs    = " + IIF(THIS.this_lLancCCEs,  "1", "0")       + ", " + ;
                "obsobrigs   = " + IIF(THIS.this_lObsobrigs, "1", "0")       + ", " + ;
                "jobs        = " + FormatarNumeroSQL(THIS.this_nJobs)         + ", " + ;
                "class1s     = " + EscaparSQL(THIS.this_cClass1s)             + ", " + ;
                "class2s     = " + EscaparSQL(THIS.this_cClass2s)             + ", " + ;
                "class3s     = " + EscaparSQL(THIS.this_cClass3s)             + ", " + ;
                "class4s     = " + EscaparSQL(THIS.this_cClass4s)             + ", " + ;
                "diasvcto    = " + FormatarNumeroSQL(THIS.this_nDiasVcto)     + ", " + ;
                "emipordesp  = " + FormatarNumeroSQL(THIS.this_nEmiPorDesp)   + ", " + ;
                "limcres     = " + FormatarNumeroSQL(THIS.this_nLimcres)      + ", " + ;
                "moedas      = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas))     + ", " + ;
                "obrcompet   = " + IIF(THIS.this_lObrCompet, "1", "0")       + ", " + ;
                "obrigc1     = " + IIF(THIS.this_lObrigC1,   "1", "0")       + ", " + ;
                "obrigc2     = " + IIF(THIS.this_lObrigC2,   "1", "0")       + ", " + ;
                "obrigc3     = " + IIF(THIS.this_lObrigC3,   "1", "0")       + ", " + ;
                "obrigc4     = " + IIF(THIS.this_lObrigC4,   "1", "0")       + ", " + ;
                "pastas      = " + IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                "vlrlimapv   = " + FormatarNumeroSQL(THIS.this_nVlrLimApv)   + ;
                " WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes)))
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.ExecutarExclusao")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursors[8], loc_i
        loc_aCursors[1] = "cursor_4c_Dados"
        loc_aCursors[2] = "cursor_4c_Reg"
        loc_aCursors[3] = "cursor_4c_Dup"
        loc_aCursors[4] = "cursor_4c_NxtN"
        loc_aCursors[5] = "cursor_4c_Gcr"
        loc_aCursors[6] = "cursor_4c_ChkPrg"
        loc_aCursors[7] = "cursor_4c_Lista"
        loc_aCursors[8] = "cursor_4c_Busca"
        FOR loc_i = 1 TO 8
            IF USED(loc_aCursors[loc_i])
                USE IN (loc_aCursors[loc_i])
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE

