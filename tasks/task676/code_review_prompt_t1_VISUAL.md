# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSer.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1030 linhas total):

*-- Linhas 23 a 46:
23: * cursores do pai).
24: *
25: * Herda de: FormBase
26: * Fase 3/8: estrutura base (DEFINE CLASS, Init, InicializarForm,
27: * ConfigurarPageFrame - so o cabecalho - e Destroy).
28: * Fase 4/8: grade de servicos lancados (grd_4c_Dados, equivalente a Grade/
29: * TmpDistrib) com as 9 colunas do dump, carga via SigPrSerBO.
30: * CarregarDistribuicao()/Acumular() e AlternarPagina(). Este form NAO tem
31: * PageFrame nem toolbar CRUD (layout FLAT do SIGPRSER legado - dialogo de
32: * conferencia, sem Incluir/Alterar/Excluir/Buscar: a unica acao do legado
33: * eh o botao OK, que fecha o dialogo - ver SigPrSerBO.prg).
34: * Fase 5/8: 1a metade dos campos restantes - ConfigurarPaginaDados() com
35: * Shape1 (decorativo), container cnt_4c_Operacao (cabecalho somente-leitura
36: * da movimentacao: txt_4c_Codigo/Empresa/Operacao ligados por ControlSource
37: * direto a tmpnens.numps/emps/dopps, cursor que o formulario PAI ja deixa na
38: * DataSession compartilhada - mesmo padrao de FormSigPrTar.prg) e o botao
39: * cmd_4c_Ok (BtnOkClick = THIS.Release(), fecha o dialogo via Destroy()).
40: * Fase 6/8: 2a metade dos campos - labels lbl_4c_Origem/lbl_4c_Destino/
41: * lbl_4c_Descricao (Say1/Say4/Say2 do dump, fora do container Operacao) e
42: * os TextBox somente-leitura txt_4c_Descr/DescOrig/DescDest (Get_descr/
43: * getDescOrig/getDescDest - ControlSource = TmpDistrib.Dpros/DescOrig/
44: * DescDest no legado) e txt_4c_QtdTot/txt_4c_Valtot (totalizadores). Nenhum
45: * desses campos tem lookup (comportamento.json: lookups=[]; todos os When
46: * do dump so fazem "Return .f.", ou seja, somente-leitura/auto-preenchidos -

*-- Linhas 167 a 175:
167:                 SET DATASESSION TO (THIS.this_oParentForm.DataSessionId)
168:             ENDIF
169: 
170:             THIS.Caption = "Servi" + CHR(231) + "os Lan" + CHR(231) + "ados"
171: 
172:             IF TYPE("gc_4c_CaminhoIcones") = "C" AND FILE(gc_4c_CaminhoIcones + "new_background.jpg")
173:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
174:             ENDIF
175: 

*-- Linhas 185 a 194:
185:                 THIS.ConfigurarPaginaLista()
186:                 THIS.ConfigurarPaginaDados()
187: 
188:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
189:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
190: 
191:                 *-- Carga da grade de servicos lancados (bloco final do Init
192:                 *-- legado, dump 945-964). Em modo de teste/validacao de UI
193:                 *-- o cursor_4c_Operacoes (equivalente a xMfas) ainda nao foi
194:                 *-- preparado por nenhum form pai - pular evita SQLEXEC sem

*-- Linhas 229 a 310:
229:     PROTECTED PROCEDURE ConfigurarPageFrame()
230:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
231:         WITH THIS.cnt_4c_Cabecalho
232:             .Top         = 0
233:             .Left        = 0
234:             .Width       = THIS.Width
235:             .Height      = 80
236:             .BackStyle   = 1
237:             .BackColor   = RGB(100, 100, 100)
238:             .BorderWidth = 0
239:             .Visible     = .T.
240: 
241:             .AddObject("lbl_4c_Sombra", "Label")
242:             WITH .lbl_4c_Sombra
243:                 .FontBold  = .T.
244:                 .FontName  = "Tahoma"
245:                 .FontSize  = 18
246:                 .WordWrap  = .T.
247:                 .Alignment = 0
248:                 .BackStyle = 0
249:                 .AutoSize  = .F.
250:                 .Caption   = ""
251:                 .Height    = 40
252:                 .Left      = 10
253:                 .Top       = 18
254:                 .Width     = THIS.Width
255:                 .ForeColor = RGB(0, 0, 0)
256:                 .Visible   = .T.
257:             ENDWITH
258: 
259:             .AddObject("lbl_4c_Titulo", "Label")
260:             WITH .lbl_4c_Titulo
261:                 .FontBold  = .T.
262:                 .FontName  = "Tahoma"
263:                 .FontSize  = 18
264:                 .WordWrap  = .T.
265:                 .Alignment = 0
266:                 .BackStyle = 0
267:                 .AutoSize  = .F.
268:                 .Caption   = ""
269:                 .Height    = 46
270:                 .Left      = 10
271:                 .Top       = 17
272:                 .Width     = THIS.Width
273:                 .ForeColor = RGB(255, 255, 255)
274:                 .Visible   = .T.
275:             ENDWITH
276:         ENDWITH
277:     ENDPROC
278: 
279:     *--------------------------------------------------------------------------
280:     * ConfigurarPaginaLista - Cria a grade de servicos lancados (grd_4c_Dados,
281:     * equivalente a Grade/TmpDistrib do legado - dump 463-553). Form OPERACIONAL
282:     * FLAT (sem PageFrame, regra #46 do CLAUDE.md para forms sem Page1/Page2):
283:     * a grade eh a vista principal do dialogo, criada direto sobre THIS, igual
284:     * ao cabecalho (Fase 3). So a estrutura/formatacao ESTATICA das colunas
285:     * entra aqui - RecordSource e Column.ControlSource (que dependem do cursor
286:     * populado) entram em CarregarLista().
287:     *
288:     * ColumnOrder reproduz a ordem VISUAL do dump (1,2,7,8,9,3,4,5,6), que
289:     * difere da ordem de criacao das Columns - Column7/8/9 (Conta/Grupo/Conta
290:     * do destino) aparecem visualmente ANTES de Column3/4/5 (Servico/Qtde/
291:     * Valor), exatamente como no SCX legado.
292:     *--------------------------------------------------------------------------
293:     PROTECTED PROCEDURE ConfigurarPaginaLista()
294:         THIS.AddObject("grd_4c_Dados", "Grid")
295:         WITH THIS.grd_4c_Dados
296:             .Top              = 197
297:             .Left             = 12
298:             .Width            = 976
299:             .Height           = 325
300:             .FontName         = "Courier New"
301:             .FontSize         = 8
302:             .RowHeight        = 17
303:             .ScrollBars       = 2
304:             .RecordSourceType = 1
305:             .DeleteMark       = .F.
306:             .RecordMark       = .F.
307:             .ReadOnly         = .F.
308:             .ColumnCount      = 9
309:             .Visible          = .T.
310: 

*-- Linhas 320 a 328:
320:                 .FontName  = "Tahoma"
321:                 .FontSize  = 8
322:                 .Alignment = 2
323:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
324:             ENDWITH
325:             WITH .Column1.Text1
326:                 .FontName    = "Courier New"
327:                 .FontSize    = 8
328:                 .BorderStyle = 0

*-- Linhas 344 a 352:
344:                 .FontName  = "Tahoma"
345:                 .FontSize  = 8
346:                 .Alignment = 2
347:                 .Caption   = "Grupo"
348:             ENDWITH
349:             WITH .Column2.Text1
350:                 .FontName    = "Courier New"
351:                 .FontSize    = 8
352:                 .BorderStyle = 0

*-- Linhas 368 a 376:
368:                 .FontName  = "Tahoma"
369:                 .FontSize  = 8
370:                 .Alignment = 2
371:                 .Caption   = "Conta"
372:             ENDWITH
373:             WITH .Column7.Text1
374:                 .FontName    = "Courier New"
375:                 .FontSize    = 8
376:                 .BorderStyle = 0

*-- Linhas 392 a 400:
392:                 .FontName  = "Tahoma"
393:                 .FontSize  = 8
394:                 .Alignment = 2
395:                 .Caption   = "Grupo"
396:             ENDWITH
397:             WITH .Column8.Text1
398:                 .FontName    = "Courier New"
399:                 .FontSize    = 8
400:                 .BorderStyle = 0

*-- Linhas 416 a 424:
416:                 .FontName  = "Tahoma"
417:                 .FontSize  = 8
418:                 .Alignment = 2
419:                 .Caption   = "Conta"
420:             ENDWITH
421:             WITH .Column9.Text1
422:                 .FontName    = "Courier New"
423:                 .FontSize    = 8
424:                 .BorderStyle = 0

*-- Linhas 440 a 448:
440:                 .FontName  = "Tahoma"
441:                 .FontSize  = 8
442:                 .Alignment = 2
443:                 .Caption   = "Servi" + CHR(231) + "o"
444:             ENDWITH
445:             WITH .Column3.Text1
446:                 .FontName    = "Courier New"
447:                 .FontSize    = 8
448:                 .BorderStyle = 0

*-- Linhas 464 a 472:
464:                 .FontName  = "Tahoma"
465:                 .FontSize  = 8
466:                 .Alignment = 2
467:                 .Caption   = "Qtde"
468:             ENDWITH
469:             WITH .Column4.Text1
470:                 .FontName    = "Courier New"
471:                 .FontSize    = 8
472:                 .BorderStyle = 0

*-- Linhas 488 a 496:
488:                 .FontName  = "Tahoma"
489:                 .FontSize  = 8
490:                 .Alignment = 2
491:                 .Caption   = "Valor"
492:             ENDWITH
493:             WITH .Column5.Text1
494:                 .FontName    = "Courier New"
495:                 .FontSize    = 8
496:                 .BorderStyle = 0

*-- Linhas 512 a 658:
512:                 .FontName  = "Tahoma"
513:                 .FontSize  = 8
514:                 .Alignment = 2
515:                 .Caption   = "Total"
516:             ENDWITH
517:             WITH .Column6.Text1
518:                 .FontName    = "Courier New"
519:                 .FontSize    = 8
520:                 .BorderStyle = 0
521:                 .Margin      = 0
522:                 .ReadOnly    = .T.
523:                 .ForeColor   = RGB(0, 0, 0)
524:                 .BackColor   = RGB(255, 255, 255)
525:             ENDWITH
526:         ENDWITH
527: 
528:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
529:     ENDPROC
530: 
531:     *--------------------------------------------------------------------------
532:     * ConfigurarPaginaDados - Controles diretos do form FLAT (SIGPRSER nao
533:     * tem Page1/Page2 - ver cabecalho do arquivo):
534:     *   Bloco de TOPO (Fase 5, acima da grade, Top < 197):
535:     *     - Shape1 (dump 313-322, decorativo, canto superior direito)
536:     *     - Container "Operacao" (dump 326-337) com os campos somente-leitura
537:     *       do cabecalho da movimentacao em conferencia (tmpnens.numps/emps/
538:     *       dopps - cursor que o formulario PAI ja deixa na DataSession
539:     *       compartilhada, igual ao padrao de FormSigPrTar.prg)
540:     *     - Botao OK (dump 413-421), unica acao viva do dialogo
541:     *   Bloco de BAIXO (Fase 6, abaixo da grade, Top > 522):
542:     *     - lbl_4c_Origem/lbl_4c_Destino (Say1/Say4, dump 764-795) - cabecalho
543:     *       das colunas de descricao de origem/destino
544:     *     - lbl_4c_Descricao (Say2, dump 424-434)
545:     *     - txt_4c_DescOrig/txt_4c_DescDest/txt_4c_Descr (getDescOrig/
546:     *       getDescDest/Get_descr) - somente-leitura, ControlSource atribuido
547:     *       dinamicamente em CarregarLista() porque dependem do alias real de
548:     *       cursor_4c_Distrib (so existe apos CarregarDistribuicao() rodar)
549:     *     - txt_4c_QtdTot/txt_4c_Valtot (getQtdTot/getValtot, dump 798-833) -
550:     *       totalizadores, preenchidos por AtualizarTotais()
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarPaginaDados()
553:         THIS.AddObject("shp_4c_Shape1", "Shape")
554:         WITH THIS.shp_4c_Shape1
555:             .Top         = 7
556:             .Left        = 898
557:             .Height      = 110
558:             .Width       = 90
559:             .BackStyle   = 0
560:             .BorderStyle = 0
561:             .BorderColor = RGB(136, 189, 188)
562:             .Visible     = .T.
563:         ENDWITH
564: 
565:         THIS.AddObject("cnt_4c_Operacao", "Container")
566:         WITH THIS.cnt_4c_Operacao
567:             .Top           = 104
568:             .Left          = 12
569:             .Width         = 490
570:             .Height        = 56
571:             .BackStyle     = 1
572:             .BackColor     = RGB(255, 255, 255)
573:             .BorderWidth   = 1
574:             .SpecialEffect = 0
575:             .TabIndex      = 6
576:             .Visible       = .T.
577: 
578:             .AddObject("lbl_4c_Movimentacao", "Label")
579:             WITH .lbl_4c_Movimentacao
580:                 .FontName  = "Tahoma"
581:                 .FontSize  = 8
582:                 .FontBold  = .T.
583:                 .Alignment = 0
584:                 .BackStyle = 0
585:                 .AutoSize  = .F.
586:                 .Left      = 4
587:                 .Top       = 3
588:                 .Width     = 100
589:                 .Height    = 14
590:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
591:                 .Visible   = .T.
592:             ENDWITH
593: 
594:             .AddObject("txt_4c_Codigo", "TextBox")
595:             WITH .txt_4c_Codigo
596:                 .ControlSource = "tmpnens.numps"
597:                 .Format        = "L"
598:                 .InputMask     = "9999999999"
599:                 .Left          = 201
600:                 .Top           = 26
601:                 .Width         = 81
602:                 .Height        = 23
603:                 .ReadOnly      = .T.
604:                 .ForeColor     = RGB(0, 0, 0)
605:                 .DisabledBackColor = RGB(255, 255, 255)
606:                 .Visible       = .T.
607:             ENDWITH
608: 
609:             .AddObject("txt_4c_Empresa", "TextBox")
610:             WITH .txt_4c_Empresa
611:                 .ControlSource = "tmpnens.emps"
612:                 .Left          = 5
613:                 .Top           = 26
614:                 .Width         = 36
615:                 .Height        = 23
616:                 .ReadOnly      = .T.
617:                 .ForeColor     = RGB(0, 0, 0)
618:                 .DisabledBackColor = RGB(255, 255, 255)
619:                 .Visible       = .T.
620:             ENDWITH
621: 
622:             .AddObject("txt_4c_Operacao", "TextBox")
623:             WITH .txt_4c_Operacao
624:                 .ControlSource = "tmpnens.dopps"
625:                 .Left          = 43
626:                 .Top           = 26
627:                 .Width         = 156
628:                 .Height        = 23
629:                 .ReadOnly      = .T.
630:                 .ForeColor     = RGB(0, 0, 0)
631:                 .DisabledBackColor = RGB(255, 255, 255)
632:                 .Visible       = .T.
633:             ENDWITH
634: 
635:             .AddObject("lin_4c_Line1", "Line")
636:             WITH .lin_4c_Line1
637:                 .BorderWidth = 2
638:                 .Height      = 0
639:                 .Left        = 4
640:                 .Top         = 19
641:                 .Width       = 316
642:                 .BorderColor = RGB(90, 90, 90)
643:                 .Visible     = .T.
644:             ENDWITH
645:         ENDWITH
646: 
647:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
648:         WITH THIS.cmd_4c_Ok
649:             .Top             = 3
650:             .Left            = 925
651:             .Width           = 75
652:             .Height          = 75
653:             .Caption         = "OK"
654:             .Cancel          = .T.
655:             .FontName        = "Comic Sans MS"
656:             .FontBold        = .T.
657:             .FontItalic      = .T.
658:             .FontSize        = 8

*-- Linhas 671 a 774:
671:             ENDIF
672:         ENDWITH
673: 
674:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
675: 
676:         *-- lbl_4c_Origem (Say1, dump 764-778) - cabecalho da coluna de
677:         *-- descricao de origem (centrado, em caixa com borda, igual ao
678:         *-- legado - este Say DECLARA Width/Alignment, nao eh a classe "say"
679:         *-- pura da regra #23)
680:         THIS.AddObject("lbl_4c_Origem", "Label")
681:         WITH THIS.lbl_4c_Origem
682:             .Top         = 182
683:             .Left        = 264
684:             .Width       = 163
685:             .Height      = 15
686:             .FontName    = "Tahoma"
687:             .FontSize    = 8
688:             .FontBold    = .T.
689:             .Alignment   = 2
690:             .AutoSize    = .F.
691:             .BackStyle   = 1
692:             .BackColor   = RGB(255, 255, 255)
693:             .BorderStyle = 1
694:             .Caption     = "Origem"
695:             .Visible     = .T.
696:         ENDWITH
697: 
698:         *-- lbl_4c_Destino (Say4, dump 781-795)
699:         THIS.AddObject("lbl_4c_Destino", "Label")
700:         WITH THIS.lbl_4c_Destino
701:             .Top         = 182
702:             .Left        = 426
703:             .Width       = 163
704:             .Height      = 15
705:             .FontName    = "Tahoma"
706:             .FontSize    = 8
707:             .FontBold    = .T.
708:             .Alignment   = 2
709:             .AutoSize    = .F.
710:             .BackStyle   = 1
711:             .BackColor   = RGB(255, 255, 255)
712:             .BorderStyle = 1
713:             .Caption     = "Destino"
714:             .Visible     = .T.
715:         ENDWITH
716: 
717:         *-- txt_4c_DescOrig (getDescOrig, dump 450-459) - ControlSource
718:         *-- atribuido em CarregarLista() (cursor_4c_Distrib ainda nao existe
719:         *-- aqui - regra "ControlSource antes do cursor existir")
720:         THIS.AddObject("txt_4c_DescOrig", "TextBox")
721:         WITH THIS.txt_4c_DescOrig
722:             .Top               = 541
723:             .Left              = 217
724:             .Width             = 150
725:             .Height            = 22
726:             .ReadOnly          = .T.
727:             .ForeColor         = RGB(0, 0, 0)
728:             .DisabledBackColor = RGB(255, 255, 255)
729:             .Visible           = .T.
730:         ENDWITH
731: 
732:         *-- txt_4c_DescDest (getDescDest, dump 836-845)
733:         THIS.AddObject("txt_4c_DescDest", "TextBox")
734:         WITH THIS.txt_4c_DescDest
735:             .Top               = 541
736:             .Left              = 379
737:             .Width             = 150
738:             .Height            = 22
739:             .ReadOnly          = .T.
740:             .ForeColor         = RGB(0, 0, 0)
741:             .DisabledBackColor = RGB(255, 255, 255)
742:             .Visible           = .T.
743:         ENDWITH
744: 
745:         *-- lbl_4c_Descricao (Say2, dump 424-434) - classe "say" pura (sem
746:         *-- Width/Alignment no dump) - regra #23: Alignment = 0 + Width
747:         *-- explicita que caiba o texto, ForeColor copiado do dump (90,90,90)
748:         THIS.AddObject("lbl_4c_Descricao", "Label")
749:         WITH THIS.lbl_4c_Descricao
750:             .Top       = 525
751:             .Left      = 591
752:             .Width     = 70
753:             .Height    = 15
754:             .FontName  = "Tahoma"
755:             .FontSize  = 8
756:             .Alignment = 0
757:             .AutoSize  = .F.
758:             .BackStyle = 0
759:             .ForeColor = RGB(90, 90, 90)
760:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
761:             .Visible   = .T.
762:         ENDWITH
763: 
764:         *-- txt_4c_Descr (Get_descr, dump 437-446) - ControlSource atribuido
765:         *-- em CarregarLista(), mesmo motivo de txt_4c_DescOrig/DescDest
766:         THIS.AddObject("txt_4c_Descr", "TextBox")
767:         WITH THIS.txt_4c_Descr
768:             .Top               = 540
769:             .Left              = 541
770:             .Width             = 241
771:             .Height            = 23
772:             .ReadOnly          = .T.
773:             .ForeColor         = RGB(0, 0, 0)
774:             .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 780 a 789:
780:         *-- no legado -> somente-leitura (igual GetCodigo/Get_descr)
781:         THIS.AddObject("txt_4c_QtdTot", "TextBox")
782:         WITH THIS.txt_4c_QtdTot
783:             .Top         = 521
784:             .Left        = 696
785:             .Width       = 83
786:             .Height      = 18
787:             .Value       = 0
788:             .FontName    = "Tahoma"
789:             .FontSize    = 8

*-- Linhas 799 a 808:
799:         *-- txt_4c_Valtot (getValtot, dump 816-832) - totalizador de valor
800:         THIS.AddObject("txt_4c_Valtot", "TextBox")
801:         WITH THIS.txt_4c_Valtot
802:             .Top         = 521
803:             .Left        = 860
804:             .Width       = 108
805:             .Height      = 18
806:             .Value       = 0
807:             .FontName    = "Tahoma"
808:             .FontSize    = 8

*-- Linhas 847 a 889:
847:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
848: 
849:                 IF THIS.this_oBusinessObject.CarregarDistribuicao()
850:                     loc_cCursor = THIS.this_oBusinessObject.this_cCursorDistrib
851: 
852:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
853:                         WITH THIS.grd_4c_Dados
854:                             .RecordSource = loc_cCursor
855:                             .Column1.ControlSource = loc_cCursor + ".Empdnps"
856:                             .Column2.ControlSource = loc_cCursor + ".Grupoos"
857:                             .Column7.ControlSource = loc_cCursor + ".Contaos"
858:                             .Column8.ControlSource = loc_cCursor + ".Grupods"
859:                             .Column9.ControlSource = loc_cCursor + ".Contads"
860:                             .Column3.ControlSource = loc_cCursor + ".Cmats"
861:                             .Column4.ControlSource = loc_cCursor + ".Qtds"
862:                             .Column5.ControlSource = loc_cCursor + ".Fators"
863:                             .Column6.ControlSource = loc_cCursor + ".Qtds * " + loc_cCursor + ".Fators"
864: 
865:                             *-- Reaplica Width/Caption apos o bind (reset do VFP9)
866:                             .Column1.Width = 241
867:                             .Column2.Width = 80
868:                             .Column7.Width = 80
869:                             .Column8.Width = 80
870:                             .Column9.Width = 80
871:                             .Column3.Width = 108
872:                             .Column4.Width = 80
873:                             .Column5.Width = 80
874:                             .Column6.Width = 108
875: 
876:                             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
877:                             .Column2.Header1.Caption = "Grupo"
878:                             .Column7.Header1.Caption = "Conta"
879:                             .Column8.Header1.Caption = "Grupo"
880:                             .Column9.Header1.Caption = "Conta"
881:                             .Column3.Header1.Caption = "Servi" + CHR(231) + "o"
882:                             .Column4.Header1.Caption = "Qtde"
883:                             .Column5.Header1.Caption = "Valor"
884:                             .Column6.Header1.Caption = "Total"
885: 
886:                             *-- Equivalente a .SetAll('DynamicForeColor', "Iif(TmpDistrib.Retrabs,
887:                             *-- RGB(255,0,0),RGB(0,0,0))", 'Column') do Init legado (dump 959).
888:                             *-- Retrabs vem como BIT do SQL Server -> LOGICAL no VFP9, por isso
889:                             *-- entra direto no IIF (sem comparar com 1/0 - CLAUDE.md regra #13).


### BO (C:\4c\projeto\app\classes\SigPrSerBO.prg):
*==============================================================================
* SigPrSerBO.prg - Business Object: Servicos Lancados (SIGPRSER)
*
* Form OPERACIONAL (SIGPRSER / FormSigPrSer): dialogo filho, aberto por um
* formulario pai durante a emissao de uma nota/movimentacao, que exibe os
* servicos ja lancados para o conjunto de operacoes de producao (Nops) em
* processamento - origem/destino de conta, quantidade, fator e valor - e
* totaliza quantidade/valor para conferencia antes de confirmar a nota.
*
* Origem legado (SIGPRSER.SCX): o Init monta o cursor TmpDistrib juntando
* SigPdMvf/SigCdNei/SigCdNec/SigCdPro/SigCdCli (origem e destino), uma
* consulta por Nops presente no cursor xMfas (que o formulario pai ja
* populava na DataSession antes de abrir este dialogo); a grade exibe
* TmpDistrib e o metodo acumula() soma Qtds e (Qtds*Fators) para os
* totalizadores. O bloco de gravacao do botao OK (transferencia para o
* cursor xnensi) esta COMENTADO no legado (*!*) - a acao realmente ativa
* e apenas reabilitar o formulario pai, atualiza-lo e fechar este dialogo.
*
* NAO existe uma unica "tabela principal" para este BO (this_cTabela
* permanece vazio) - ele opera sobre cursores temporarios (cursor_4c_
* Distrib, equivalente a TmpDistrib) montados a partir de varias tabelas,
* igual ao padrao ja adotado em SigPrGlxBO/SigPrGl2BO.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga/calculo (CarregarDistribuicao/
*                Acumular/CarregarDoCursor)
*==============================================================================

DEFINE CLASS SigPrSerBO AS BusinessBase

    *==========================================================================
    * Cursores de trabalho (nomes) - equivalentes aos cursores do legado que
    * viviam na DataSession compartilhada entre o formulario pai e este
    * dialogo filho.
    *==========================================================================
    this_cCursorOperacoes = "cursor_4c_Operacoes" && Lista de Nops (operacoes de producao) a processar - equivalente ao cursor xMfas, populado pelo formulario pai antes de abrir este dialogo
    this_cCursorDistrib   = "cursor_4c_Distrib"   && Servicos lancados consolidados com origem/destino de conta - equivalente a TmpDistrib

    *==========================================================================
    * Dados do cabecalho da movimentacao atual, exibidos somente leitura na
    * tela (equivalentes ao cursor tmpnens.numps/emps/dopps do legado, que o
    * formulario pai tambem ja deixava preparado).
    *==========================================================================
    this_nNumMov  = 0  && tmpnens.numps - numero da movimentacao/nota em processamento
    this_cEmpMov  = "" && tmpnens.emps  - empresa da movimentacao
    this_cOperMov = "" && tmpnens.dopps - tipo/descricao da operacao da movimentacao

    *==========================================================================
    * Totalizadores calculados a partir de cursor_4c_Distrib (equivalente ao
    * PROCEDURE acumula() do legado, que soma Qtds e Qtds*Fators de
    * TmpDistrib e exibe em getQtdTot/getValtot).
    *==========================================================================
    this_nQtdTotal   = 0 && Soma de Qtds dos servicos lancados
    this_nValorTotal = 0 && Soma de (Qtds * Fators) dos servicos lancados

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *
    * Este BO nao opera sobre uma unica tabela SQL Server: o resultado
    * exibido (cursor_4c_Distrib) vem de um JOIN entre SigPdMvf, SigCdNei,
    * SigCdNec, SigCdPro e SigCdCli (origem e destino), montado por Nops -
    * por isso this_cTabela/this_cCampoChave ficam vazios, igual ao padrao
    * ja adotado em SigPrGlxBO/SigPrGl2BO para dialogos operacionais sem
    * entidade unica.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega os dados de cabecalho da movimentacao em
    * processamento (equivalente a tmpnens.numps/emps/dopps do legado, lidos
    * direto via ControlSource em GetCodigo/GetEmpresa/GetOperacao - Init,
    * dump 886-965). par_cCursor eh o alias do cursor de cabecalho que o
    * formulario PAI ja deixa preparado na DataSession compartilhada (Set
    * DataSession To pForm.DataSessionId) antes de abrir este dialogo - este
    * BO so LE esse cursor, nunca o popula.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF TYPE(par_cAliasCursor + ".numps") != "U"
            THIS.this_nNumMov = TratarNulo(EVALUATE(par_cAliasCursor + ".numps"), 0)
        ENDIF
        IF TYPE(par_cAliasCursor + ".emps") != "U"
            THIS.this_cEmpMov = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".emps"), ""))
        ENDIF
        IF TYPE(par_cAliasCursor + ".dopps") != "U"
            THIS.this_cOperMov = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".dopps"), ""))
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarDistribuicao - Monta this_cCursorDistrib (equivalente a
    * TmpDistrib) a partir da lista de operacoes de producao presente em
    * this_cCursorOperacoes (equivalente ao cursor xMfas, que o formulario
    * pai ja deixa populado na DataSession compartilhada antes de abrir este
    * dialogo - "Select xMfas / Scan / _nOperacao = xMfas.Nops" no Init
    * legado, dump 913-943).
    *
    * Para cada Nops, repete a mesma consulta (join SigPdMvf/SigCdNei/
    * SigCdNec/SigCdPro/SigCdCli origem e destino) que o legado fazia em
    * LocalMFas4, filtrando so os servicos (b.servicos = 1 and b.cats <> '')
    * e acumulando as linhas no cursor de distribuicao (equivalente ao
    * "Insert into TmpDistrib from memvar" do legado - o bloco alternativo,
    * que so inseria quando TmpDistrib ainda nao tinha aquele Empdnps, esta
    * COMENTADO no legado, *!* linhas 936-941 - por isso NAO reproduzir esse
    * filtro aqui, e acumular toda linha que a consulta devolver).
    *
    * O legado tambem roda essa mesma consulta uma unica vez, sem filtro de
    * Nops e com "where 0=1" (dump 900-911), so para definir a ESTRUTURA de
    * TmpDistrib antes do SCAN. Aqui a estrutura nasce da primeira consulta
    * que devolver linha, ou (se nenhuma operacao casar, ou a lista de
    * operacoes estiver vazia) de uma consulta equivalente com "WHERE 0 = 1"
    * - para que a grade sempre tenha RecordSource valido mesmo com zero
    * linhas, que eh resultado normal (nao erro).
    *==========================================================================
    FUNCTION CarregarDistribuicao()
        LOCAL loc_lSucesso, loc_cAliasAnt, loc_nNops, loc_cSQL, loc_cSQLBase, ;
            loc_nResultado, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso  = .F.
        loc_cAliasAnt = ""

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cSQLBase = "SELECT b.Empdnps, c.Grupoos, c.Contaos, c.Grupods, c.Contads, " + ;
            "b.Cmats, b.Fators, b.Qtds, b.Cretrabs, c.Retrabs, b.CDescs, d.Dpros, " + ;
            "e.Rclis AS DescOrig, f.Rclis AS DescDest " + ;
            "FROM SigPdMvf a " + ;
            "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
            "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
            "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
            "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
            "INNER JOIN SigCdCli f ON c.Contads = f.Iclis "

        TRY
            loc_cAliasAnt = ALIAS()

            IF USED(THIS.this_cCursorDistrib)
                USE IN (THIS.this_cCursorDistrib)
            ENDIF
            IF USED("cursor_4c_DistribTmp")
                USE IN cursor_4c_DistribTmp
            ENDIF

            IF USED(THIS.this_cCursorOperacoes) AND RECCOUNT(THIS.this_cCursorOperacoes) > 0

                SELECT (THIS.this_cCursorOperacoes)
                SCAN
                    loc_nNops = TratarNulo(EVALUATE(THIS.this_cCursorOperacoes + ".Nops"), 0)

                    loc_cSQL = loc_cSQLBase + ;
                        "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                        " AND b.Servicos = 1 AND b.Cats <> ''"

                    IF USED("cursor_4c_DistribTmp")
                        USE IN cursor_4c_DistribTmp
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DistribTmp")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "(Text - LocalMFas4) " + CapturarErroSQL()
                        EXIT
                    ENDIF

                    IF USED("cursor_4c_DistribTmp") AND RECCOUNT("cursor_4c_DistribTmp") > 0
                        IF !USED(THIS.this_cCursorDistrib)
                            SELECT * FROM cursor_4c_DistribTmp WHERE .F. ;
                                INTO CURSOR (THIS.this_cCursorDistrib) READWRITE
                        ENDIF
                        SELECT (THIS.this_cCursorDistrib)
                        APPEND FROM DBF("cursor_4c_DistribTmp")
                    ENDIF

                    SELECT (THIS.this_cCursorOperacoes)
                ENDSCAN

                IF USED("cursor_4c_DistribTmp")
                    USE IN cursor_4c_DistribTmp
                ENDIF
            ENDIF

            IF EMPTY(THIS.this_cMensagemErro) AND !USED(THIS.this_cCursorDistrib)
                *-- Lista de operacoes vazia, ou nenhuma linha casou com o
                *-- filtro de servicos - cursor nasce vazio, com estrutura
                *-- valida (equivalente ao "where 0=1" do Init legado)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLBase + "WHERE 0 = 1", "cursor_4c_DistribTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "(Text - TmpDistrib) " + CapturarErroSQL()
                ELSE
                    SELECT * FROM cursor_4c_DistribTmp WHERE .F. ;
                        INTO CURSOR (THIS.this_cCursorDistrib) READWRITE
                    USE IN cursor_4c_DistribTmp
                ENDIF
            ENDIF

            loc_lSucesso = EMPTY(THIS.this_cMensagemErro) AND USED(THIS.this_cCursorDistrib)

            IF USED(THIS.this_cCursorDistrib)
                GO TOP IN (THIS.this_cCursorDistrib)
            ENDIF

            IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Acumular - Recalcula os totalizadores exibidos no rodape da tela
    * (getQtdTot/getValtot) a partir de this_cCursorDistrib - transcricao do
    * PROCEDURE acumula() do legado (dump 871-881):
    *   Select Sum(qtds) as qtds, Sum(qtds * fators) as vrpags From
    *   tmpDistrib Into Cursor curt
    * Com o cursor de distribuicao vazio, SUM() devolve NULL (equivalente ao
    * .NULL. que o legado tambem gravaria no textbox) - TratarNulo normaliza
    * para 0, mantendo os totalizadores coerentes com uma lista vazia.
    *==========================================================================
    FUNCTION Acumular()
        LOCAL loc_lSucesso, loc_cAliasAnt

        THIS.this_nQtdTotal   = 0
        THIS.this_nValorTotal = 0
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorDistrib)
            RETURN .F.
        ENDIF

        loc_cAliasAnt = ALIAS()

        IF USED("cursor_4c_Totais")
            USE IN cursor_4c_Totais
        ENDIF

        SELECT SUM(Qtds) AS Qtds, SUM(Qtds * Fators) AS VrPags ;
            FROM (THIS.this_cCursorDistrib) ;
            INTO CURSOR cursor_4c_Totais

        IF USED("cursor_4c_Totais")
            THIS.this_nQtdTotal   = TratarNulo(cursor_4c_Totais.Qtds, 0)
            THIS.this_nValorTotal = TratarNulo(cursor_4c_Totais.VrPags, 0)
            USE IN cursor_4c_Totais
            loc_lSucesso = .T.
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor() ja esta implementado acima (dados de cabecalho,
    * somente leitura). ObterChavePrimaria() / Inserir() / Atualizar() /
    * ExecutarExclusao(): este BO deliberadamente NAO sobrescreve esses
    * quatro metodos do BusinessBase.
    *
    * SIGPRSER eh um dialogo filho de PREVIA (conferencia de servicos ja
    * lancados antes de confirmar a nota do form pai) - nao um cadastro. No
    * legado, o bloco que de fato gravaria algo (OK.Click: transferencia de
    * TmpDistrib para o cursor xnensi, dump 1030-1072) esta INTEIRO dentro
    * de comentarios "*!*", ou seja, codigo morto, desativado pela propria
    * equipe Fortyus. A UNICA acao viva do botao OK eh:
    *   ThisForm.ParentForm.Enabled = .t.
    *   Select xnensi / Go Bott
    *   ThisForm.ParentForm.Refresh
    *   ThisForm.Release
    * ou seja: reabilitar e atualizar o formulario pai, e fechar este
    * dialogo - nenhuma gravacao em tabela acontece. Essa acao pertence ao
    * FORM (FormSigPrSer.BtnOkClick), nao ao BO: nao ha "registro desta
    * entidade" para Salvar()/Excluir() persistirem.
    *
    * Os stubs herdados de BusinessBase (que devolvem .F. com mensagem de
    * erro, e ObterChavePrimaria() devolvendo "") permanecem corretos, pois
    * Salvar()/Excluir() nunca sao acionados por este form - ver mesma
    * decisao, pelo mesmo motivo, em SigPrGlxBO.prg/SigPrGl2BO.prg.
    *==========================================================================

ENDDEFINE

