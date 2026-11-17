# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPEN.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1428 linhas total):

*-- Linhas 2 a 10:
2: * FormSIGOPPEN.prg - Pendencias Em Subniveis (SIGOPPEN)
3: * Form OPERACIONAL (layout customizado: grade principal + painel de Status
4: * de aprovacao). Fase 7/8: eventos principais - marcar/desmarcar linha
5: * (checkbox + select-all da grade) e o fluxo de Aprovar/Reprovar/Cancelar/
6: * Encerrar do painel de Status (CmdStatusClick/BtnAprovarClick/
7: * BtnReprovarClick/BtnCancelarClick/BtnEncerrarStatusClick), o grupo
8: * Produtos/Encerrar da Lista (CmdBotoesClick/BtnSelItensClick/BtnSairClick)
9: * e os botoes Subniveis (BtnSubNiveisClick) e de liberacao de consulta de
10: * todos os subniveis (BtnLiberarClick).

*-- Linhas 130 a 139:
130:     PROTECTED PROCEDURE ConfigurarPageFrame()
131:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
132:         WITH THIS.pgf_4c_Paginas
133:             .Top       = 0
134:             .Left      = 0
135:             .Width     = THIS.Width
136:             .Height    = THIS.Height
137:             .Tabs      = .F.
138:             .PageCount = 2
139:             .Visible   = .F.

*-- Linhas 160 a 207:
160:         *-- Faixa cinza do cabecalho (equivalente cntSombra do legado)
161:         loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
162:         WITH loc_oPg.cnt_4c_Cabecalho
163:             .Top         = 0
164:             .Left        = 0
165:             .Width       = THIS.Width
166:             .Height      = 80
167:             .BackStyle   = 1
168:             .BackColor   = RGB(100, 100, 100)
169:             .BorderWidth = 0
170:             .Visible     = .T.
171: 
172:             .AddObject("lbl_4c_Sombra", "Label")
173:             WITH .lbl_4c_Sombra
174:                 .Top       = 15
175:                 .Left      = 10
176:                 .Width     = THIS.Width
177:                 .Height    = 40
178:                 .AutoSize  = .F.
179:                 .WordWrap  = .T.
180:                 .FontBold  = .T.
181:                 .FontName  = "Tahoma"
182:                 .FontSize  = 16
183:                 .BackStyle = 0
184:                 .ForeColor = RGB(0, 0, 0)
185:                 .Caption   = THIS.Caption
186:                 .Visible   = .T.
187:             ENDWITH
188: 
189:             .AddObject("lbl_4c_Titulo", "Label")
190:             WITH .lbl_4c_Titulo
191:                 .Top       = 18
192:                 .Left      = 10
193:                 .Width     = THIS.Width
194:                 .Height    = 46
195:                 .AutoSize  = .F.
196:                 .WordWrap  = .T.
197:                 .FontBold  = .T.
198:                 .FontName  = "Tahoma"
199:                 .FontSize  = 16
200:                 .BackStyle = 0
201:                 .ForeColor = RGB(255, 255, 255)
202:                 .Caption   = THIS.Caption
203:                 .Visible   = .T.
204:             ENDWITH
205:         ENDWITH
206: 
207:         *-- Cursor placeholder - estrutura IDENTICA ao "Create Cursor TmpPends"

*-- Linhas 263 a 272:
263:         loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
264: 
265:         WITH loc_oPg.grd_4c_Dados
266:             .Top                = 213
267:             .Left               = 26
268:             .Width              = 999
269:             .Height             = 236
270:             .FontName           = "Verdana"
271:             .FontSize           = 8
272:             .HeaderHeight       = 22

*-- Linhas 279 a 288:
279:             .HighlightStyle     = 2
280:             .Visible            = .T.
281: 
282:             *-- Column1 "seleciona" (ColumnOrder=1) - checkbox de marcacao
283:             *-- (legado: fwcheckbox1, ligado em runtime a TmpPends.Flag). O
284:             *-- "When" do legado (Op_Escolha='INSERIR' Or LibPend) le
285:             *-- Op_Escolha, que o legado recebe do form PAI no Init
286:             *-- (This.op_escolha = thisform.parentform.pcescolha). O SIGOPPEN
287:             *-- eh um dialogo filho e a cadeia do pai entra com a carga da
288:             *-- grade; sem Op_Escolha o guard negaria TODA marcacao, entao a

*-- Linhas 299 a 329:
299:             .Column1.Alignment         = 2
300:             .Column1.FontName          = "Verdana"
301:             .Column1.FontSize          = 8
302:             .Column1.Header1.Caption   = ""
303:             .Column1.Header1.Alignment = 2
304:             .Column1.Header1.FontName  = "Verdana"
305:             .Column1.Header1.FontSize  = 8
306: 
307:             .Column1.AddObject("chk_4c_Flag", "CheckBox")
308:             WITH .Column1.chk_4c_Flag
309:                 .Top       = 31
310:                 .Left      = 12
311:                 .Height    = 17
312:                 .Width     = 22
313:                 .Alignment = 0
314:                 .BackStyle = 0
315:                 .Caption   = ""
316:                 .ReadOnly  = .F.
317:                 .Visible   = .T.
318:                 .FontName  = "Verdana"
319:                 .FontSize  = 8
320:             ENDWITH
321:             .Column1.CurrentControl = "chk_4c_Flag"
322: 
323:             *-- Toggle da marcacao (legado: Grade.seleciona.fwcheckbox1.Click)
324:             *-- - CheckBox de Column exige os 4 handlers com NODEFAULT (regra
325:             *-- #46/pattern #185 CLAUDE.md), senao o clique nao alterna nada.
326:             BINDEVENT(.Column1.chk_4c_Flag, "Click",     THIS, "ChkFlagClick")
327:             BINDEVENT(.Column1.chk_4c_Flag, "MouseDown", THIS, "ChkFlagMouseDown")
328:             BINDEVENT(.Column1.chk_4c_Flag, "MouseUp",   THIS, "ChkFlagMouseUp")
329:             BINDEVENT(.Column1.chk_4c_Flag, "KeyPress",  THIS, "ChkFlagKeyPress")

*-- Linhas 339 a 347:
339:             .Column8.ReadOnly          = .T.
340:             .Column8.FontName          = "Verdana"
341:             .Column8.FontSize          = 8
342:             .Column8.Header1.Caption   = "Emp"
343:             .Column8.Header1.Alignment = 2
344:             .Column8.Header1.FontName  = "Verdana"
345:             .Column8.Header1.FontSize  = 8
346: 
347:             *-- Column3 "codigo" (ColumnOrder=3) - ControlSource EXPRESSAO

*-- Linhas 356 a 364:
356:             .Column3.ReadOnly          = .T.
357:             .Column3.FontName          = "Verdana"
358:             .Column3.FontSize          = 8
359:             .Column3.Header1.Caption   = "Codigo"
360:             .Column3.Header1.Alignment = 2
361:             .Column3.Header1.FontName  = "Verdana"
362:             .Column3.Header1.FontSize  = 8
363: 
364:             *-- Column9 "operacao" (ColumnOrder=4) - caption "Movimentacao".

*-- Linhas 372 a 380:
372:             .Column9.ReadOnly          = .T.
373:             .Column9.FontName          = "Verdana"
374:             .Column9.FontSize          = 8
375:             .Column9.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
376:             .Column9.Header1.Alignment = 2
377:             .Column9.Header1.FontName  = "Verdana"
378:             .Column9.Header1.FontSize  = 8
379: 
380:             *-- Column4 "data" (ColumnOrder=5)

*-- Linhas 386 a 394:
386:             .Column4.ReadOnly          = .T.
387:             .Column4.FontName          = "Verdana"
388:             .Column4.FontSize          = 8
389:             .Column4.Header1.Caption   = "Data"
390:             .Column4.Header1.Alignment = 2
391:             .Column4.Header1.FontName  = "Verdana"
392:             .Column4.Header1.FontSize  = 8
393: 
394:             *-- Column5 "Grupo" (ColumnOrder=6) - caption "Origem". ReadOnly

*-- Linhas 404 a 412:
404:             .Column5.ReadOnly          = .T.
405:             .Column5.FontName          = "Verdana"
406:             .Column5.FontSize          = 8
407:             .Column5.Header1.Caption   = "Origem"
408:             .Column5.Header1.Alignment = 2
409:             .Column5.Header1.FontName  = "Verdana"
410:             .Column5.Header1.FontSize  = 8
411: 
412:             *-- Column6 "Conta" (ColumnOrder=7) - caption "Destino" (mesma

*-- Linhas 419 a 427:
419:             .Column6.ReadOnly          = .T.
420:             .Column6.FontName          = "Verdana"
421:             .Column6.FontSize          = 8
422:             .Column6.Header1.Caption   = "Destino"
423:             .Column6.Header1.Alignment = 2
424:             .Column6.Header1.FontName  = "Verdana"
425:             .Column6.Header1.FontSize  = 8
426: 
427:             *-- Column2 "documento" (ColumnOrder=8) - caption "Docto." (mesma

*-- Linhas 434 a 442:
434:             .Column2.ReadOnly          = .T.
435:             .Column2.FontName          = "Verdana"
436:             .Column2.FontSize          = 8
437:             .Column2.Header1.Caption   = "Docto."
438:             .Column2.Header1.Alignment = 2
439:             .Column2.Header1.FontName  = "Verdana"
440:             .Column2.Header1.FontSize  = 8
441: 
442:             *-- Column7 "Valor" (ColumnOrder=9)

*-- Linhas 448 a 456:
448:             .Column7.ReadOnly          = .T.
449:             .Column7.FontName          = "Verdana"
450:             .Column7.FontSize          = 8
451:             .Column7.Header1.Caption   = "Valor"
452:             .Column7.Header1.Alignment = 2
453:             .Column7.Header1.FontName  = "Verdana"
454:             .Column7.Header1.FontSize  = 8
455: 
456:             *-- Column10 "EmpDestino" (sem ColumnOrder explicito no dump -

*-- Linhas 462 a 470:
462:             .Column10.ReadOnly          = .T.
463:             .Column10.FontName          = "Verdana"
464:             .Column10.FontSize          = 8
465:             .Column10.Header1.Caption   = "EmpD"
466:             .Column10.Header1.Alignment = 2
467:             .Column10.Header1.FontName  = "Verdana"
468:             .Column10.Header1.FontSize  = 8
469:         ENDWITH
470: 

*-- Linhas 480 a 532:
480:             .SpecialEffect = 1
481:             .Value         = 0
482:             .Themes        = .F.
483:             .Top           = 95
484:             .Left          = 834
485:             .Width         = 160
486:             .Height        = 85
487:             .Visible       = .T.
488: 
489:             *-- Buttons(1) "btnSelItens" - abre o painel de selecao de
490:             *-- produtos. Cnt_SelItem (a grade de itens do subnivel) ainda
491:             *-- nao foi migrado - ver BtnSelItensClick para o guard real que
492:             *-- ja funciona com a estrutura atual.
493:             WITH .Buttons(1)
494:                 .Top             = 5
495:                 .Left            = 5
496:                 .Width           = 75
497:                 .Height          = 75
498:                 .FontBold        = .T.
499:                 .FontItalic      = .T.
500:                 .FontName        = "Comic Sans MS"
501:                 .FontSize        = 8
502:                 .WordWrap        = .T.
503:                 .Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
504:                 .Caption         = "P\<rodutos"
505:                 .ToolTipText     = "Selecionar os Produtos Que Deseja Carregar"
506:                 .MousePointer    = 15
507:                 .PicturePosition = 13
508:                 .SpecialEffect   = 0
509:                 .ForeColor       = RGB(90, 90, 90)
510:                 .BackColor       = RGB(255, 255, 255)
511:                 .Themes          = .F.
512:             ENDWITH
513: 
514:             *-- Buttons(2) "btnSair" - Encerrar (legado: Cancel=.T., [Esc])
515:             WITH .Buttons(2)
516:                 .Top           = 5
517:                 .Left          = 80
518:                 .Width         = 75
519:                 .Height        = 75
520:                 .FontBold      = .T.
521:                 .FontItalic    = .T.
522:                 .FontName      = "Comic Sans MS"
523:                 .FontSize      = 8
524:                 .WordWrap      = .T.
525:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
526:                 .Cancel        = .T.
527:                 .Caption       = "Encerrar"
528:                 .ToolTipText   = "[Esc] Encerrar"
529:                 .MousePointer  = 15
530:                 .SpecialEffect = 0
531:                 .ForeColor     = RGB(90, 90, 90)
532:                 .BackColor     = RGB(255, 255, 255)

*-- Linhas 543 a 599:
543:         *-- subniveis da linha corrente da grade. ZOrderSet=14 do dump NAO eh
544:         *-- transcrito: eh bookkeeping do Form Designer e nao existe em
545:         *-- runtime (regra #33 CLAUDE.md).
546:         loc_oPg.AddObject("cmd_4c_SubNiveis", "CommandButton")
547:         WITH loc_oPg.cmd_4c_SubNiveis
548:             .Top             = 130
549:             .Left            = 284
550:             .Width           = 75
551:             .Height          = 75
552:             .FontBold        = .T.
553:             .FontItalic      = .T.
554:             .FontName        = "Comic Sans MS"
555:             .FontSize        = 8
556:             .WordWrap        = .T.
557:             .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
558:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
559:             .Caption         = "\<Subn" + CHR(237) + "veis"
560:             .ToolTipText     = "Subn" + CHR(237) + "veis"
561:             .MousePointer    = 15
562:             .PicturePosition = 13
563:             .ForeColor       = RGB(90, 90, 90)
564:             .BackColor       = RGB(255, 255, 255)
565:             .Themes          = .T.
566:             .Visible         = .T.
567:         ENDWITH
568: 
569:         BINDEVENT(loc_oPg.cmd_4c_SubNiveis, "Click", THIS, "BtnSubNiveisClick")
570: 
571:         *-- Botao "..." de liberacao de consulta de TODOS os subniveis
572:         *-- (legado: SIGOPPEN.BtnLiberar, Top=564/Left=210/18x19, Caption
573:         *-- "..."). O Init legado o deixa oculto e so o revela quando
574:         *-- Type([CrSigOpCdI.ValTmpSubn])=[N] And CrSigOpCdI.ValTmpSubn = 1 -
575:         *-- CrSigOpCdI eh montado pelo metodo "Carregar" do legado, que vem
576:         *-- com a carga da grade; ate la vale o estado inicial do legado
577:         *-- (oculto), transcrito literalmente.
578:         loc_oPg.AddObject("cmd_4c_Liberar", "CommandButton")
579:         WITH loc_oPg.cmd_4c_Liberar
580:             .Top               = 564
581:             .Left              = 210
582:             .Width             = 18
583:             .Height            = 19
584:             .FontName          = "Tahoma"
585:             .FontSize          = 7
586:             .Caption           = "..."
587:             .ToolTipText       = "Libera Consulta de Todos Subn" + CHR(237) + "veis"
588:             .ForeColor         = RGB(90, 90, 90)
589:             .BackColor         = RGB(255, 255, 255)
590:             .DisabledBackColor = RGB(255, 255, 255)
591:             .Visible           = .F.
592:         ENDWITH
593: 
594:         BINDEVENT(loc_oPg.cmd_4c_Liberar, "Click", THIS, "BtnLiberarClick")
595:     ENDPROC
596: 
597:     *==========================================================================
598:     * ConfigurarPaginaDados - Page2: painel de Status da Movimentacao
599:     * (equivalente Cnt_Status do legado - Aprovar/Reprovar/Cancelar).

*-- Linhas 613 a 672:
613:         *-- terem sido criados DEPOIS dela.
614:         loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
615:         WITH loc_oPg.cnt_4c_Cabecalho
616:             .Top         = 0
617:             .Left        = 0
618:             .Width       = THIS.Width
619:             .Height      = 80
620:             .BackStyle   = 1
621:             .BackColor   = RGB(100, 100, 100)
622:             .BorderWidth = 0
623:             .Visible     = .T.
624: 
625:             .AddObject("lbl_4c_Sombra", "Label")
626:             WITH .lbl_4c_Sombra
627:                 .Top       = 15
628:                 .Left      = 10
629:                 .Width     = THIS.Width
630:                 .Height    = 40
631:                 .AutoSize  = .F.
632:                 .WordWrap  = .T.
633:                 .FontBold  = .T.
634:                 .FontName  = "Tahoma"
635:                 .FontSize  = 16
636:                 .BackStyle = 0
637:                 .ForeColor = RGB(0, 0, 0)
638:                 .Caption   = THIS.Caption
639:                 .Visible   = .T.
640:             ENDWITH
641: 
642:             .AddObject("lbl_4c_Titulo", "Label")
643:             WITH .lbl_4c_Titulo
644:                 .Top       = 18
645:                 .Left      = 10
646:                 .Width     = THIS.Width
647:                 .Height    = 46
648:                 .AutoSize  = .F.
649:                 .WordWrap  = .T.
650:                 .FontBold  = .T.
651:                 .FontName  = "Tahoma"
652:                 .FontSize  = 16
653:                 .BackStyle = 0
654:                 .ForeColor = RGB(255, 255, 255)
655:                 .Caption   = THIS.Caption
656:                 .Visible   = .T.
657:             ENDWITH
658:         ENDWITH
659: 
660:         *-- Container de botoes de acao (legado: Cnt_Status.Commandgroup1,
661:         *-- Top=32/Left=112/Width=235/Height=85) - "barra de acao do topo"
662:         *-- (regra #11, excecao: Top 20..55 e Height 60..100), mantido NA
663:         *-- POSICAO ORIGINAL do legado, sem deslocamento, por cima da faixa.
664:         loc_oPg.AddObject("cnt_4c_BotoesAcao", "Container")
665:         WITH loc_oPg.cnt_4c_BotoesAcao
666:             .Top         = 32
667:             .Left        = 112
668:             .Width       = 235
669:             .Height      = 85
670:             .BackStyle   = 0
671:             .BorderWidth = 0
672:             .Visible     = .T.

*-- Linhas 679 a 744:
679:             .AddObject("obj_4c_CmgStatus", "CommandGroup")
680:             WITH .obj_4c_CmgStatus
681:                 .ButtonCount   = 3
682:                 .Top           = 0
683:                 .Left          = 0
684:                 .Width         = 235
685:                 .Height        = 85
686:                 .BackStyle     = 0
687:                 .BorderStyle   = 0
688:                 .SpecialEffect = 1
689:                 .Value         = 1
690:                 .Visible       = .T.
691: 
692:                 WITH .Buttons(1)
693:                     .Top             = 5
694:                     .Left            = 5
695:                     .Width           = 75
696:                     .Height          = 75
697:                     .FontBold        = .T.
698:                     .FontItalic      = .T.
699:                     .FontName        = "Comic Sans MS"
700:                     .FontSize        = 8
701:                     .WordWrap        = .T.
702:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
703:                     .Caption         = "\<Aprovada"
704:                     .PicturePosition = 13
705:                     .ForeColor       = RGB(90, 90, 90)
706:                     .BackColor       = RGB(255, 255, 255)
707:                     .Themes          = .F.
708:                 ENDWITH
709: 
710:                 WITH .Buttons(2)
711:                     .Top             = 5
712:                     .Left            = 80
713:                     .Width           = 75
714:                     .Height          = 75
715:                     .FontBold        = .T.
716:                     .FontItalic      = .T.
717:                     .FontName        = "Comic Sans MS"
718:                     .FontSize        = 8
719:                     .WordWrap        = .T.
720:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
721:                     .Caption         = "\<Reprovada"
722:                     .PicturePosition = 13
723:                     .ForeColor       = RGB(90, 90, 90)
724:                     .BackColor       = RGB(255, 255, 255)
725:                     .Themes          = .F.
726:                 ENDWITH
727: 
728:                 WITH .Buttons(3)
729:                     .Top        = 5
730:                     .Left       = 155
731:                     .Width      = 75
732:                     .Height     = 75
733:                     .FontBold   = .T.
734:                     .FontItalic = .T.
735:                     .FontName   = "Comic Sans MS"
736:                     .FontSize   = 8
737:                     .WordWrap   = .T.
738:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
739:                     .Caption    = "Cancelada"
740:                     .ForeColor  = RGB(90, 90, 90)
741:                     .BackColor  = RGB(255, 255, 255)
742:                     .Themes     = .F.
743:                 ENDWITH
744:             ENDWITH

*-- Linhas 754 a 814:
754:         *-- acao do topo, mesma excecao da regra #11.
755:         loc_oPg.AddObject("shp_4c_Shape5", "Shape")
756:         WITH loc_oPg.shp_4c_Shape5
757:             .Top           = 34
758:             .Left          = 340
759:             .Width         = 85
760:             .Height        = 82
761:             .BorderWidth   = 1
762:             .SpecialEffect = 1
763:             .Visible       = .T.
764:         ENDWITH
765: 
766:         *-- Say1 "Status da Movimentacao" (legado: Cnt_Status.Say1, Top=4) -
767:         *-- deslocado para Top=84 (imediatamente abaixo da faixa, que ocupa
768:         *-- 0-80). Label NAO esta na lista de excecoes da regra #11 (que
769:         *-- cobre so Container/CommandButton/OptionGroup da barra de acao).
770:         loc_oPg.AddObject("lbl_4c_Status", "Label")
771:         WITH loc_oPg.lbl_4c_Status
772:             .Top       = 84
773:             .Left      = 151
774:             .Width     = 230
775:             .Height    = 15
776:             .AutoSize  = .F.
777:             .Alignment = 0
778:             .BackStyle = 0
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .ForeColor = RGB(90, 90, 90)
782:             .Caption   = "Status da Movimenta" + CHR(231) + CHR(227) + "o"
783:             .Visible   = .T.
784:         ENDWITH
785: 
786:         *-- Label9 "Tam" (legado: Cnt_Status.Label9, Top=115/Left=5)
787:         loc_oPg.AddObject("lbl_4c_Tam", "Label")
788:         WITH loc_oPg.lbl_4c_Tam
789:             .Top       = 115
790:             .Left      = 5
791:             .Width     = 22
792:             .Height    = 15
793:             .AutoSize  = .F.
794:             .Alignment = 0
795:             .BackStyle = 0
796:             .FontName  = "Tahoma"
797:             .FontSize  = 8
798:             .ForeColor = RGB(90, 90, 90)
799:             .Caption   = "Tam"
800:             .Visible   = .T.
801:         ENDWITH
802: 
803:         *-- getCodTams (legado: Cnt_Status.getCodTams, Top=131/Left=5) -
804:         *-- codigo do Tamanho associado ao subnivel selecionado na grade
805:         *-- (lookup fwbuscaext contra SigCdTam.Cods - comportamento.json).
806:         loc_oPg.AddObject("txt_4c_CodTams", "TextBox")
807:         WITH loc_oPg.txt_4c_CodTams
808:             .Top         = 131
809:             .Left        = 5
810:             .Width       = 38
811:             .Height      = 23
812:             .Value       = ""
813:             .MaxLength   = 3
814:             .Alignment   = 3

*-- Linhas 825 a 857:
825:         BINDEVENT(loc_oPg.txt_4c_CodTams, "LostFocus", THIS, "ValidarCodTamsLostFocus")
826: 
827:         *-- Label10 "Observacao" (legado: Cnt_Status.Label10, Top=115/Left=47)
828:         loc_oPg.AddObject("lbl_4c_Observacao", "Label")
829:         WITH loc_oPg.lbl_4c_Observacao
830:             .Top       = 115
831:             .Left      = 47
832:             .Width     = 60
833:             .Height    = 15
834:             .AutoSize  = .F.
835:             .Alignment = 0
836:             .BackStyle = 0
837:             .FontName  = "Tahoma"
838:             .FontSize  = 8
839:             .ForeColor = RGB(90, 90, 90)
840:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
841:             .Visible   = .T.
842:         ENDWITH
843: 
844:         *-- txtObses (legado: Cnt_Status.txtObses, EditBox, Top=131/Left=47)
845:         *-- - texto de aprovacao/reprovacao/cancelamento, concatenado pelo
846:         *-- BO com o usuario logado (ver BtnAprovarClick/BtnReprovarClick/
847:         *-- BtnCancelarClick). Sem ControlSource - o legado tambem nao liga a
848:         *-- cursor (ControlSource = "").
849:         loc_oPg.AddObject("edt_4c_Observacoes", "EditBox")
850:         WITH loc_oPg.edt_4c_Observacoes
851:             .Top           = 131
852:             .Left          = 47
853:             .Width         = 487
854:             .Height        = 101
855:             .Value         = ""
856:             .BorderStyle   = 1
857:             .SpecialEffect = 1

*-- Linhas 863 a 894:
863:         *-- btnCancela "Encerrar" (legado: Cnt_Status.btnCancela, classe
864:         *-- fwbtng, Top=37/Left=342/Width=80 - sem Height explicito no
865:         *-- dump, herda 75 da classe fwbtng/padrao canonico de botao).
866:         loc_oPg.AddObject("cmd_4c_Encerrar", "CommandButton")
867:         WITH loc_oPg.cmd_4c_Encerrar
868:             .Top             = 37
869:             .Left            = 342
870:             .Width           = 75
871:             .Height          = 75
872:             .FontBold        = .T.
873:             .FontItalic      = .T.
874:             .FontName        = "Comic Sans MS"
875:             .FontSize        = 8
876:             .WordWrap        = .T.
877:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
878:             .Cancel          = .T.
879:             .Caption         = "Encerrar"
880:             .PicturePosition = 13
881:             .ForeColor       = RGB(90, 90, 90)
882:             .BackColor       = RGB(255, 255, 255)
883:             .Themes          = .F.
884:             .Visible         = .T.
885:         ENDWITH
886: 
887:         *-- Dismiss do painel de Status sem gravar (legado:
888:         *-- Cnt_Status.btnCancela.Click)
889:         BINDEVENT(loc_oPg.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarStatusClick")
890:     ENDPROC
891: 
892:     *==========================================================================
893:     * ValidarCodTamsLostFocus - Lookup do campo Tamanho do painel de Status
894:     * (legado: Cnt_Status.getCodTams.Valid - fwbuscaext contra SigCdTam,

*-- Linhas 1008 a 1016:
1008:     ENDPROC
1009: 
1010:     *==========================================================================
1011:     * ChkFlagClick/MouseDown/MouseUp - Suprimem o toggle nativo do CheckBox
1012:     * de Column (regra #46 CLAUDE.md / pattern #185) - a alternancia real
1013:     * acontece em ChkFlagKeyPress, chamado por MouseUp/Enter/Espaco.
1014:     *==========================================================================
1015:     PROCEDURE ChkFlagClick()
1016:         NODEFAULT

*-- Linhas 1027 a 1035:
1027: 
1028:     *==========================================================================
1029:     * ChkFlagKeyPress - Alterna a marcacao da linha corrente (legado:
1030:     * Grade.seleciona.fwcheckbox1.Click - "If !This.Value / ThisForm.
1031:     * Desmarca / Else / This.Value = ThisForm.Marca() / Endif"). Marca()/
1032:     * Desmarca() do legado preparam ~10 cursores de trabalho (crTpmMvItn,
1033:     * crTpmMvIts, crSigSubMv, xBaixaSS, ...) para a baixa em subniveis - esse
1034:     * subsistema de carga de itens ainda nao foi migrado (fica para fase
1035:     * dedicada); aqui fica o efeito visivel e auditavel da marcacao: alterna


### BO (C:\4c\projeto\app\classes\SIGOPPENBO.prg):
*==============================================================================
* SIGOPPENBO.prg - Business Object para Pendencias Em Subniveis (SIGOPPEN)
* Tabela principal: SigMvCab (cabecalho da movimentacao em aberto)
* Tabelas relacionadas: SigMvItn, SigCdOpe, SigCdEmp, SigCdPro, SigPrTrp,
*                        SigOpCdd, SigClJob, SigBxEst, SigSubMv
*==============================================================================

DEFINE CLASS SIGOPPENBO AS BusinessBase

    *-- Identificacao da movimentacao em aberto (SigMvCab) -------------------
    this_cEmps          = ""    && char(3)  - Empresa da movimentacao
    this_cDopes         = ""    && char(20) - Codigo da operacao (Dopes)
    this_nNumes         = 0     && numeric(6,0) - Numero sequencial da movimentacao
    this_cEmpDopNums    = ""    && char(29) - Chave combinada Emps+Dopes+Str(Numes,6)
    this_cCidChaves     = ""    && char(20) - Chave unica (PK de SigMvCab)
    this_cMascNum       = ""    && char(10) - Numero mascarado para exibicao em tela
    this_dDatas         = {}    && datetime - Data da movimentacao
    this_cNotas         = ""    && char(6)  - Numero da nota fiscal (legado)
    this_cNumeroNota    = ""    && char(10) - Numero da nota fiscal (NF-e)
    this_cPedidoWeb     = ""    && char(50) - Identificacao do pedido Web
    this_cIdTransp      = ""    && char(15) - Identificacao da transportadora
    this_cObsCabMovs    = ""    && char(40) - Observacao do cabecalho da movimentacao
    this_cObses         = ""    && text     - Observacoes gerais (memo)
    this_cPStatus       = ""    && char(1)  - Status de aprovacao da movimentacao
    this_cStatusAprRep  = ""    && char(1)  - Status aplicado na ultima Aprovacao/Reprovacao
    this_lChkSubn       = .F.   && bit      - Indica se ja foi baixada em subniveis
    this_lChkBxParcs    = .F.   && bit      - Indica baixa parcial permitida
    this_lChkQtdss      = .F.   && bit      - Indica conferencia de quantidades habilitada
    this_cGrupoOs       = ""    && char(10) - Grupo de origem
    this_cContaOs       = ""    && char(10) - Conta de origem
    this_cGrupoDs       = ""    && char(10) - Grupo de destino
    this_cContaDs       = ""    && char(10) - Conta de destino
    this_cGrResps       = ""    && char(10) - Grupo responsavel
    this_cVends         = ""    && char(10) - Responsavel/Vendedor
    this_dPrazoEnts     = {}    && datetime - Prazo de entrega
    this_nValOs         = 0     && numeric(11,2) - Valor da operacao de origem

    *-- Configuracao da operacao vigente (SigCdOpe / SigOpCdd) --------------
    this_cDopesAtual    = ""    && char(20) - Operacao vigente sendo tratada
    this_nDopesNivel    = 0     && numeric  - Nivel da operacao (Nivels)
    this_cOpera         = ""    && char(1)  - Tipo de operacao (Opers)
    this_nPuxaOrigem    = 0     && numeric  - ConOSubs: forma de puxar origem
    this_nPuxaDestino   = 0     && numeric  - ConDSubs: forma de puxar destino
    this_cOpePad        = ""    && char(20) - Operacao padrao associada (OpePads)
    this_cOpePadC       = ""    && char(20) - Operacao padrao de componentes (OpePadcs)
    this_lBaixaSubN     = .F.   && bit      - BaixaSns: baixa automatica em subniveis
    this_lBxParc        = .F.   && bit      - BxParcials: permite baixa parcial
    this_lBxAutos       = .F.   && bit      - BxAutos: baixa automatica
    this_cCarOpCr       = ""    && char(1)  - Opcrs: tipo de carga de operacao credito
    this_nMarcaSubns    = 0     && numeric  - MarcaSubns: marca subniveis ao localizar
    this_nCupFis        = 0     && numeric(1,0) - CupFis: tipo de cupom fiscal
    this_nDigItens      = 0     && numeric  - DigItens: permite digitar itens manualmente
    this_nVars          = 0     && numeric(9,4) - Vars: variacao percentual da operacao
    this_cCfos          = ""    && char     - Cfos: codigo fiscal da operacao
    this_nNDopes        = 0     && numeric  - nDopes: nivel numerico da operacao
    this_nParcs         = 0     && numeric  - parcs: quantidade de parcelas
    this_cCMoes         = ""    && char(3)  - cMoes: moeda da operacao
    this_nNDdVals       = 0     && numeric  - nDdVals: dias de vencimento padrao
    this_lValpres       = .F.   && bit      - Valpres: valores pre-definidos
    this_cCadprods      = ""    && char     - cadprods: cadastra produto na operacao

    *-- Filtros e parametros de tela (Init/Carregar do legado) --------------
    this_nMeses         = 0     && numeric  - Qtd. de meses do filtro de periodo
    this_dAntValue      = {}    && date     - Valor anterior do filtro de meses
    this_lLibPend       = .F.   && logical  - Libera visualizacao de subniveis bloqueados
    this_lChkPends      = .F.   && logical  - Filtra apenas pendencias marcadas
    this_lDdBloqueado   = .F.   && logical  - Indica filtro de datas bloqueado
    this_nNfServicos    = 0     && numeric  - Tipo de nota fiscal de servicos
    this_lBuscProd      = .F.   && logical  - Indica busca restrita por produto (pbusprod)
    this_lSelecStatus   = .F.   && logical  - Indica que o status foi selecionado no painel
    this_nItemMov       = 0     && numeric  - Item de movimentacao em edicao (ItemMov)
    this_cCfgTitOrigem      = "" && char   - Titulo configurado para "Origem"
    this_cCfgTitDestino     = "" && char   - Titulo configurado para "Destino"
    this_cCfgTitVendedor    = "" && char   - Titulo configurado para "Vendedor"
    this_cCfgTitResponsavel = "" && char   - Titulo configurado para "Responsavel"
    this_cCfgTitJob         = "" && char   - Titulo configurado para "Job"
    this_cCfgTitListaVends  = "" && char   - Titulo configurado para lista de vendedores
    this_cCodigo        = ""    && char    - Codigo digitado no filtro "Procura"
    this_cDoc           = ""    && char(6) - Documento digitado no filtro "Documento"
    this_cLocPed        = ""    && char    - Pedido/Localizacao digitada no filtro
    this_cCpros         = ""    && char(10)- Produto filtrado na pesquisa
    this_cIdTranspFiltro= ""    && char    - Transportadora filtrada na pesquisa
    this_lLiberaConsulta= .F.   && logical - Autorizacao para liberar consulta de subniveis

    *-- Itens da movimentacao (crTpmMvItn / SigMvItn) ------------------------
    this_nCItem         = 0     && numeric - Contador de itens no processo de carga
    this_nQtds          = 0     && numeric - Quantidade do item corrente
    this_nQtdsP         = 0     && numeric - Quantidade original do item (antes de ajuste)
    this_nValCars       = 0     && numeric - Valor carregado do item corrente
    this_nTotCar        = 0     && numeric - Total carregado (rateio de frete/despesas)
    this_nTotite        = 0     && numeric - Total de itens apos agrupamento

    *-- Configuracao de status de gravacao (SigOpCdd.StsGrvs/GrvAutos) ------
    this_cStsGrvs       = ""    && char(3) - pos1=Aprovado pos2=Reprovado pos3=Cancelado
    this_lGrvAutos      = .F.   && bit - fecha a tela automaticamente apos gravar o status

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_nMeses  = 0
            THIS.this_dAntValue = DATE()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SIGOPPENBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave usada nos UPDATE/auditoria (EmpDopNums,
    * o this_cCampoChave configurado no Init). char(29) posicional (Emps+Dopes+
    * Str(Numes,6)) lido direto da coluna - ALLTRIM na chave INTEIRA eh inofensivo
    * (char no SQL Server compara com blank-padding ANSI); regra #42 so proibe
    * ALLTRIM nas PARTES internas de uma montagem manual.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos de SigMvCab (cabecalho da movimentacao
    * em aberto) do cursor informado para as propriedades do BO.
    * this_cStatusAprRep (status aplicado na ultima Aprovacao/Reprovacao) e
    * this_lChkQtdss (ChkQtdss) NAO sao colunas de SigMvCab - o primeiro eh
    * variavel de trabalho do form, o segundo vem da config da operacao em
    * SigCdOpe - por isso ficam fora deste mapeamento.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps,       "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes,      "C"))
            THIS.this_nNumes       = TratarNulo(Numes,              "N")
            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cCidChaves   = ALLTRIM(TratarNulo(CidChaves,  "C"))
            THIS.this_cMascNum     = ALLTRIM(TratarNulo(MascNum,    "C"))
            THIS.this_dDatas       = ConverterParaData(TratarNulo(Datas, "D"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas,       "C"))
            THIS.this_cNumeroNota  = ALLTRIM(TratarNulo(NumeroNota,  "C"))
            THIS.this_cPedidoWeb   = ALLTRIM(TratarNulo(PedidoWeb,   "C"))
            THIS.this_cIdTransp    = ALLTRIM(TratarNulo(IdTransp,    "C"))
            THIS.this_cObsCabMovs  = ALLTRIM(TratarNulo(ObsCabMovs,  "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus,     "C"))
            THIS.this_lChkSubn     = ConverterParaLogico(ChkSubn)
            THIS.this_lChkBxParcs  = ConverterParaLogico(ChkBxParcs)
            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs,     "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs,     "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs,     "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs,     "C"))
            THIS.this_cGrResps     = ALLTRIM(TratarNulo(GrResps,     "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends,       "C"))
            THIS.this_dPrazoEnts   = ConverterParaData(TratarNulo(PrazoEnts, "D"))
            THIS.this_nValOs       = TratarNulo(ValOs, "N")

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Mantem o comportamento padrao herdado de BusinessBase (recusa a
    * operacao). Conferido no codigo fonte legado (SIGOPPEN_form_codigo_fonte.txt)
    * e no comportamento.json: a tela so aprova/reprova/cancela/baixa movimentos
    * EM ABERTO que ja existem em SigMvCab (varios "Update SigMvCab Set ...") -
    * em nenhum ponto o legado faz "Insert Into SigMvCab". Sobrescrever Inserir()
    * aqui exigiria inventar valores para as ~140 colunas NOT NULL de SigMvCab
    * que esta tela nunca grava, violando o PILAR 2 (schema identico) e o
    * PILAR 1 (a tela nao cria movimentacao nova).
    *==========================================================================

    *==========================================================================
    * Atualizar - UPDATE SigMvCab com os campos que as acoes de Aprovar/
    * Reprovar/Cancelar/Baixar Subnivel do legado alteram (Cnt_Status.
    * Commandgroup1.Click Command1/2/3 e o fluxo de SubNiveis), consolidados
    * num unico UPDATE pela chave EmpDopNums.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lContinuar, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            IF EMPTY(loc_cChave)
                MsgErro("Chave do movimento (EmpDopNums) n" + CHR(227) + "o definida " + ;
                        "para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Usuals = "     + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "DtAlts = GETDATE(), " + ;
                           "Obses = "      + EscaparSQL(THIS.this_cObses) + ", " + ;
                           "pStatus = "    + EscaparSQL(PADR(THIS.this_cPStatus, 1)) + ", " + ;
                           "ChkSubn = "    + IIF(THIS.this_lChkSubn, "1", "0") + ", " + ;
                           "ChkBxParcs = " + IIF(THIS.this_lChkBxParcs, "1", "0") + ", " + ;
                           "DtBaixas = "   + IIF(THIS.this_lChkSubn, "GETDATE()", "NULL") + " " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd") >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao atualizar a pend" + CHR(234) + "ncia em subn" + ;
                            CHR(237) + "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a worklist de pendencias em subniveis (Page1/
    * grd_4c_Dados) a partir de SigMvCab. Equivalente REDUZIDO do metodo
    * "Carregar" do legado (SIGOPPEN_form_codigo_fonte.txt, PROCEDURE
    * carregar, ~650 linhas).
    *
    * ESCOPO DELIBERADAMENTE REDUZIDO (documentado, NAO omitido em
    * silencio - REGRA FUNDAMENTAL do CLAUDE.md): o "Carregar" legado so
    * roda dentro de um dialogo FILHO aberto por uma tela de movimentacao
    * especifica ("Do Form SigOpPen With ThisForm, ..."), que fixa a
    * variavel de modulo TprMvCab (cabecalho da movimentacao do
    * CHAMADOR) e carrega quatro cursores de configuracao POR OPERACAO
    * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd/CrSigOpCdI) antes de montar a
    * consulta - sao eles que decidem, operacao por operacao, qual conta
    * vale como "origem"/"destino" (_PuxaOrigem/_PuxaDestino), quais
    * status ficam visiveis (StsSubs), o filtro de acesso por empresa
    * (fAcessoEmpresa) e o agrupamento por nivel de subnivel (SigOpCsn).
    * Esta task expoe FormSIGOPPEN como tela INDEPENDENTE no menu
    * (popMovimentos - "Pendencias em Subniveis"), sem nenhum form
    * chamador: TprMvCab e crSigCdOpe NUNCA existem neste caminho, e
    * fabricar os dois so para preencher o metodo seria inventar regra
    * de negocio (tambem PROIBIDO pelo CLAUDE.md).
    *
    * O que fica, fiel ao legado e sem depender do contexto ausente: a
    * condicao-base de pendencia - "ChkSubn = 0" - eh, em TODA variante
    * do WHERE do legado, o filtro que sempre aparece (Iif(crSigCdOpe.
    * Subns = 1,[a.ChkSubn = ?llsubnt And ],...) com llsubnt = .F." -
    * aqui aplicada a TODAS as operacoes de uma vez, no lugar de uma
    * unica operacao escolhida pelo form chamador. Origem/Destino usam
    * Grupo+Conta diretos de SigMvCab (sem o desvio _PuxaOrigem/
    * _PuxaDestino, que depende de configuracao por operacao) e a
    * descricao da conta vem de SigCdCli.Rclis - mesma tabela/coluna que
    * o legado consulta por CrEest.ContaOs/contads (dump, linha ~3480).
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltro, loc_oErro
        loc_lSucesso = .F.
        loc_cFiltro  = TratarNulo(par_cFiltro, "C")

        TRY
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.MascNum, a.Datas, a.TpFats, " + ;
                       "RTRIM(a.GrupoOs) + '/' + RTRIM(a.ContaOs) AS Origem, " + ;
                       "RTRIM(a.GrupoDs) + '/' + RTRIM(a.ContaDs) AS Destino, " + ;
                       "a.Valos, a.Notas, a.ChkSubn AS ChkSubN, " + ;
                       "CONVERT(VARCHAR(8000), a.Obses) AS Obss, " + ;
                       "ISNULL(co.Rclis, '') AS DescsO, ISNULL(cd.Rclis, '') AS DescsD, " + ;
                       "LEFT(a.CidChaves, 10) AS cIdChaves, a.Usuars, a.EmpDs, a.pStatus, " + ;
                       "a.PrazoEnts AS DtEnts, a.ObsCabMovs, a.Jobs, a.PedidoWeb, " + ;
                       "a.IDEntrega, a.ChaveNota, a.IDTransp, a.NumeroNota, a.EmpRet " + ;
                       "FROM SigMvCab a " + ;
                       "LEFT JOIN SigCdCli co ON co.Iclis = a.ContaOs " + ;
                       "LEFT JOIN SigCdCli cd ON cd.Iclis = a.ContaDs " + ;
                       "WHERE a.ChkSubn = 0"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND (" + loc_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Datas, a.Emps, a.Dopes, a.Numes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp") >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    IF USED("cursor_4c_DadosTmp") AND RECCOUNT("cursor_4c_DadosTmp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                    ENDIF
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar pend" + CHR(234) + "ncias em subn" + CHR(237) + ;
                        "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarConfigOperacao - Le StsGrvs/GrvAutos de SigOpCdd para a operacao
    * informada. StsGrvs eh char(3) posicional: pos1 = status gravado ao
    * Aprovar, pos2 = status gravado ao Reprovar, pos3 = status gravado ao
    * Cancelar (legado: Cnt_Status.Commandgroup1.Command1/2/3.Click -
    * Substr(crSigOpCdd.StsGrvs, 1|2|3, 1)). Usado pelo form antes de montar
    * o UPDATE de aprovacao/reprovacao/cancelamento.
    *==========================================================================
    PROCEDURE CarregarConfigOperacao(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cStsGrvs  = ""
            THIS.this_lGrvAutos = .F.

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

            loc_cSQL = "SELECT StsGrvs, GrvAutos FROM SigOpCdd " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") >= 0
                IF USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
                    SELECT cursor_4c_CfgOpe
                    GO TOP
                    THIS.this_cStsGrvs  = PADR(TratarNulo(StsGrvs, "C"), 3)
                    THIS.this_lGrvAutos = (TratarNulo(GrvAutos, "N") = 1)
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + ;
                            CHR(227) + "o " + ALLTRIM(par_cDopes) + " n" + CHR(227) + ;
                            "o encontrada em SigOpCdd.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar a configura" + CHR(231) + CHR(227) + "o da " + ;
                        "opera" + CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.CarregarConfigOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

