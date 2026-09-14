# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Distrib' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp1.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1064 linhas total):

*-- Linhas 87 a 95:
87:             IF ALLTRIM(THIS.this_cEscolha) = "INSERIR"
88:                 loc_cCaption = loc_cCaption + " Fase Anterior"
89:             ENDIF
90:             THIS.Caption = loc_cCaption
91: 
92:             *-- Fundo do form (new_background.jpg)
93:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
94: 
95:             *-- Titulo dinamico da coluna Industrializacao (dois niveis acima no legado)

*-- Linhas 124 a 137:
124: 
125:             *-- Caption dinamico do header Industrializacao (ParentForm.ParentForm.Titulo no legado)
126:             IF !EMPTY(loc_cTitulo) AND VARTYPE(THIS.grd_4c_Dados) = "O"
127:                 THIS.grd_4c_Dados.Column1.Header1.Caption = loc_cTitulo
128:             ENDIF
129: 
130:             *-- Botao Alterar visivel somente no modo INSERIR (replica logica fChecaAcesso do legado)
131:             IF VARTYPE(THIS.cmd_4c_Alterar) = "O"
132:                 THIS.cmd_4c_Alterar.Visible = INLIST(ALLTRIM(THIS.this_cEscolha), "INSERIR")
133:             ENDIF
134: 
135:             loc_lSucesso = .T.
136: 
137:         CATCH TO loc_oErro

*-- Linhas 163 a 215:
163: 
164:         *-- Caption ajustado conforme escolha (INSERIR mostra Fase Anterior)
165:         IF ALLTRIM(THIS.this_cEscolha) = "INSERIR"
166:             THIS.Caption = "Componentes Agregados Fase Anterior"
167:         ELSE
168:             THIS.Caption = "Componentes Agregados"
169:         ENDIF
170:     ENDPROC
171: 
172:     *==========================================================================
173:     * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
174:     * Equivale a lblSombra e lblTitulo dentro de cntSombra no legado
175:     *==========================================================================
176:     PROTECTED PROCEDURE ConfigurarCabecalho()
177:         LOCAL loc_cCaption
178:         loc_cCaption = THIS.Caption
179: 
180:         WITH THIS.cnt_4c_Sombra
181:             .AddObject("lbl_4c_LblSombra", "Label")
182:             WITH .lbl_4c_LblSombra
183:                 .FontBold      = .T.
184:                 .FontName      = "Tahoma"
185:                 .FontSize      = 18
186:                 .FontUnderline = .F.
187:                 .WordWrap      = .T.
188:                 .Alignment     = 0
189:                 .BackStyle     = 0
190:                 .Caption       = loc_cCaption
191:                 .Height        = 40
192:                 .Left          = 10
193:                 .Top           = 18
194:                 .Width         = 769
195:                 .ForeColor     = RGB(0, 0, 0)
196:                 .Visible       = .T.
197:             ENDWITH
198: 
199:             .AddObject("lbl_4c_LblTitulo", "Label")
200:             WITH .lbl_4c_LblTitulo
201:                 .FontBold   = .T.
202:                 .FontName   = "Tahoma"
203:                 .FontSize   = 18
204:                 .WordWrap   = .T.
205:                 .Alignment  = 0
206:                 .BackStyle  = 0
207:                 .Caption    = loc_cCaption
208:                 .Height     = 46
209:                 .Left       = 10
210:                 .Top        = 17
211:                 .Width      = 769
212:                 .ForeColor  = RGB(255, 255, 255)
213:                 .Visible    = .T.
214:             ENDWITH
215:         ENDWITH

*-- Linhas 222 a 244:
222:     *==========================================================================
223:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
224:         WITH THIS.cnt_4c_Operacao
225:             .AddObject("lbl_4c_LblOperacao", "Label")
226:             WITH .lbl_4c_LblOperacao
227:                 .FontSize  = 8
228:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
229:                 .Left      = 18
230:                 .Top       = 13
231:                 .ForeColor = RGB(90, 90, 90)
232:                 .BackStyle = 0
233:                 .Visible   = .T.
234:             ENDWITH
235: 
236:             .AddObject("txt_4c_Empresa", "TextBox")
237:             WITH .txt_4c_Empresa
238:                 .Left          = 76
239:                 .Top           = 9
240:                 .Width         = 36
241:                 .Height        = 23
242:                 .ReadOnly      = .T.
243:                 .ControlSource = "tmpnens.emps"
244:                 .FontName      = "Tahoma"

*-- Linhas 252 a 261:
252: 
253:             .AddObject("txt_4c_Operacao", "TextBox")
254:             WITH .txt_4c_Operacao
255:                 .Left          = 114
256:                 .Top           = 9
257:                 .Width         = 156
258:                 .Height        = 23
259:                 .ReadOnly      = .T.
260:                 .ControlSource = "tmpnens.dopps"
261:                 .FontName      = "Tahoma"

*-- Linhas 269 a 278:
269: 
270:             .AddObject("txt_4c_Codigo", "TextBox")
271:             WITH .txt_4c_Codigo
272:                 .Left          = 272
273:                 .Top           = 9
274:                 .Width         = 81
275:                 .Height        = 23
276:                 .ReadOnly      = .T.
277:                 .ControlSource = "tmpnens.numps"
278:                 .InputMask     = "9999999999"

*-- Linhas 320 a 329:
320:     * em ConfigurarPaginaDados().
321:     *
322:     *  - grd_4c_Dados   : grid de componentes (Grade no legado, 11 colunas)
323:     *  - cmd_4c_Alterar : libera edicao das colunas (botao Alterar)
324:     *  - cmd_4c_Ok      : persiste alteracoes e fecha (botao ok)
325:     *
326:     * O form NAO tem botoes CRUD (Incluir/Visualizar/Excluir/Buscar/Encerrar)
327:     * porque o legado nao tem - paridade funcional 100% com SIGPDMP1.SCX.
328:     *==========================================================================
329:     PROTECTED PROCEDURE ConfigurarPaginaLista()

*-- Linhas 338 a 359:
338:     * edicao. Em SIGPDMP1 (OPERACIONAL) nao ha Page2; este metodo agrupa o
339:     * bloco inferior do form com os campos de detalhe e o grid de totais:
340:     *
341:     *  - lbl_4c_Label2  : label "Descricao :" (Say2 no legado)
342:     *  - txt_4c_Descr   : campo de descricao da linha corrente do grid
343:     *                     principal (Get_descr no legado, vinculado a
344:     *                     cursor_4c_Distrib.CDescs)
345:     *  - txt_4c_TotPeso : total de peso da fase anterior calculado pelo BO
346:     *                     (getTotPeso no legado)
347:     *  - grd_4c_Resumo  : grid de resumo com totais agrupados por componente
348:     *                     (grdResumo no legado, 6 colunas, ReadOnly)
349:     *
350:     * Ordem importa: ConfigurarCamposExtras() cria os controles flutuantes
351:     * (labels/textboxes) que ficam visualmente sobre/abaixo do grid principal;
352:     * ConfigurarGradeResumo() cria o grid de totais no rodape do form.
353:     *==========================================================================
354:     PROTECTED PROCEDURE ConfigurarPaginaDados()
355:         THIS.ConfigurarCamposExtras()
356:         THIS.ConfigurarGradeResumo()
357:     ENDPROC
358: 
359:     *==========================================================================

*-- Linhas 376 a 562:
376:         THIS.AddObject("grd_4c_Dados", "Grid")
377: 
378:         WITH THIS.grd_4c_Dados
379:             .Top         = 125
380:             .Left        = 38
381:             .Width       = 724
382:             .Height      = 329
383:             .ColumnCount = 11
384:             .RecordSource = "cursor_4c_Distrib"
385:             .RecordMark  = .F.
386:             .DeleteMark  = .F.
387:             .ReadOnly    = .F.
388:             .ScrollBars  = 2
389:             .GridLines   = 1
390:             .RowHeight   = 16
391:             .FontName    = "Verdana"
392:             .FontSize    = 8
393:             .Themes      = .F.
394: 
395:             *-- ColumnOrder replica a ordem visual do original (SCX usava ColumnOrder para rearranjar)
396:             *-- Visual: Industrializacao | Componente | Descricao | Cor | Tam. | Unid. | Qtde(1) | Unid.(2) | Qtde(2) | Peso Fabr. | Lote
397: 
398:             WITH .Column1
399:                 .ColumnOrder   = 1
400:                 .Width         = 83
401:                 .ReadOnly      = .T.
402:                 .ControlSource = "cursor_4c_Distrib.Nops"
403:                 .FontName      = "Courier New"
404:                 .FontSize      = 9
405:                 .InputMask     = "9999999999"
406:                 .Alignment     = 3
407:                 .Header1.Caption = "Industrializa" + CHR(231) + CHR(227) + "o"
408:                 .Header1.FontName = "Tahoma"
409:                 .Header1.FontSize = 9
410:                 .Header1.Alignment = 2
411:             ENDWITH
412: 
413:             WITH .Column2
414:                 .ColumnOrder   = 2
415:                 .Width         = 100
416:                 .ReadOnly      = .T.
417:                 .ControlSource = "cursor_4c_Distrib.CMats"
418:                 .Header1.Caption = "Componente"
419:                 .Header1.FontName = "Tahoma"
420:                 .Header1.FontSize = 9
421:                 .Header1.Alignment = 2
422:             ENDWITH
423: 
424:             WITH .Column3
425:                 .ColumnOrder   = 10
426:                 .Width         = 80
427:                 .ReadOnly      = .T.
428:                 .ControlSource = "cursor_4c_Distrib.Pesos"
429:                 .Header1.Caption = "Peso Fabr."
430:                 .Header1.FontName = "Tahoma"
431:                 .Header1.FontSize = 9
432:                 .Header1.Alignment = 2
433:             ENDWITH
434: 
435:             WITH .Column4
436:                 .ColumnOrder   = 6
437:                 .Width         = 31
438:                 .ReadOnly      = .T.
439:                 .ControlSource = "cursor_4c_Distrib.CUnis"
440:                 .Header1.Caption = "Unid."
441:                 .Header1.FontName = "Tahoma"
442:                 .Header1.FontSize = 9
443:                 .Header1.Alignment = 2
444:             ENDWITH
445: 
446:             WITH .Column5
447:                 .ColumnOrder   = 7
448:                 .Width         = 80
449:                 .ReadOnly      = .T.
450:                 .ControlSource = "cursor_4c_Distrib.Qtds"
451:                 .Header1.Caption = "Qtde (1)"
452:                 .Header1.FontName = "Tahoma"
453:                 .Header1.FontSize = 9
454:                 .Header1.Alignment = 2
455:             ENDWITH
456: 
457:             WITH .Column6
458:                 .ColumnOrder   = 3
459:                 .Width         = 50
460:                 .ReadOnly      = .T.
461:                 .ControlSource = "cursor_4c_Distrib.CDescs"
462:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
463:                 .Header1.FontName = "Tahoma"
464:                 .Header1.FontSize = 9
465:                 .Header1.Alignment = 2
466:             ENDWITH
467: 
468:             WITH .Column7
469:                 .ColumnOrder   = 11
470:                 .Width         = 80
471:                 .ReadOnly      = .T.
472:                 .ControlSource = "cursor_4c_Distrib.nLotes"
473:                 .Header1.Caption = "Lote"
474:                 .Header1.FontName = "Tahoma"
475:                 .Header1.FontSize = 9
476:                 .Header1.Alignment = 2
477:             ENDWITH
478: 
479:             WITH .Column8
480:                 .ColumnOrder   = 9
481:                 .Width         = 70
482:                 .ReadOnly      = .T.
483:                 .ControlSource = "cursor_4c_Distrib.Peso2s"
484:                 .Header1.Caption = "Qtde (2)"
485:                 .Header1.FontName = "Tahoma"
486:                 .Header1.FontSize = 9
487:                 .Header1.Alignment = 2
488:             ENDWITH
489: 
490:             WITH .Column9
491:                 .ColumnOrder   = 8
492:                 .Width         = 31
493:                 .ReadOnly      = .T.
494:                 .ControlSource = "cursor_4c_Distrib.cUniPs"
495:                 .Header1.Caption = "Unid."
496:                 .Header1.FontName = "Tahoma"
497:                 .Header1.FontSize = 9
498:                 .Header1.Alignment = 2
499:             ENDWITH
500: 
501:             WITH .Column10
502:                 .ColumnOrder   = 4
503:                 .Width         = 38
504:                 .ReadOnly      = .T.
505:                 .ControlSource = "cursor_4c_Distrib.CodCors"
506:                 .Header1.Caption = "Cor"
507:                 .Header1.FontName = "Tahoma"
508:                 .Header1.FontSize = 9
509:                 .Header1.Alignment = 2
510:             ENDWITH
511: 
512:             WITH .Column11
513:                 .ColumnOrder   = 5
514:                 .Width         = 38
515:                 .ReadOnly      = .T.
516:                 .ControlSource = "cursor_4c_Distrib.CodTams"
517:                 .Header1.Caption = "Tam."
518:                 .Header1.FontName = "Tahoma"
519:                 .Header1.FontSize = 9
520:                 .Header1.Alignment = 2
521:             ENDWITH
522: 
523:             .Visible = .T.
524:         ENDWITH
525: 
526:         *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
527:         THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Distrib.Nops"
528:         THIS.grd_4c_Dados.Column2.ControlSource  = "cursor_4c_Distrib.CMats"
529:         THIS.grd_4c_Dados.Column3.ControlSource  = "cursor_4c_Distrib.Pesos"
530:         THIS.grd_4c_Dados.Column4.ControlSource  = "cursor_4c_Distrib.CUnis"
531:         THIS.grd_4c_Dados.Column5.ControlSource  = "cursor_4c_Distrib.Qtds"
532:         THIS.grd_4c_Dados.Column6.ControlSource  = "cursor_4c_Distrib.CDescs"
533:         THIS.grd_4c_Dados.Column7.ControlSource  = "cursor_4c_Distrib.nLotes"
534:         THIS.grd_4c_Dados.Column8.ControlSource  = "cursor_4c_Distrib.Peso2s"
535:         THIS.grd_4c_Dados.Column9.ControlSource  = "cursor_4c_Distrib.cUniPs"
536:         THIS.grd_4c_Dados.Column10.ControlSource = "cursor_4c_Distrib.CodCors"
537:         THIS.grd_4c_Dados.Column11.ControlSource = "cursor_4c_Distrib.CodTams"
538: 
539:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDistribAfterRowColChange")
540:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus",  THIS, "GrdCol3GotFocus")
541:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GrdCol3LostFocus")
542:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus",  THIS, "GrdCol5GotFocus")
543:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdCol5LostFocus")
544:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus",  THIS, "GrdCol8GotFocus")
545:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GrdCol8LostFocus")
546:     ENDPROC
547: 
548:     *==========================================================================
549:     * ConfigurarGradeResumo - Grid de resumo com 6 colunas (grdResumo)
550:     * Exibe cursor_4c_Resumo: totais agrupados por componente
551:     *==========================================================================
552:     PROTECTED PROCEDURE ConfigurarGradeResumo()
553:         THIS.AddObject("grd_4c_Resumo", "Grid")
554: 
555:         WITH THIS.grd_4c_Resumo
556:             .Top               = 481
557:             .Left              = 38
558:             .Width             = 446
559:             .Height            = 114
560:             .ColumnCount       = 6
561:             .RecordSource      = "cursor_4c_Resumo"
562:             .RecordMark        = .F.

*-- Linhas 575 a 628:
575:             WITH .Column1
576:                 .Width         = 108
577:                 .ControlSource = "cursor_4c_Resumo.CMats"
578:                 .Header1.Caption = "Componente"
579:                 .Header1.FontName = "Tahoma"
580:                 .Header1.FontSize = 8
581:                 .Header1.Alignment = 2
582:             ENDWITH
583: 
584:             WITH .Column2
585:                 .Width         = 80
586:                 .ControlSource = "cursor_4c_Resumo.Qtds"
587:                 .Header1.Caption = "Qtde (1)"
588:                 .Header1.FontName = "Tahoma"
589:                 .Header1.FontSize = 8
590:                 .Header1.Alignment = 2
591:             ENDWITH
592: 
593:             WITH .Column3
594:                 .Width         = 31
595:                 .ControlSource = "cursor_4c_Resumo.CUnis"
596:                 .Header1.Caption = "Unid."
597:                 .Header1.FontName = "Tahoma"
598:                 .Header1.FontSize = 8
599:                 .Header1.Alignment = 2
600:             ENDWITH
601: 
602:             WITH .Column4
603:                 .Width         = 80
604:                 .ControlSource = "cursor_4c_Resumo.Peso2s"
605:                 .Header1.Caption = "Qtde (2)"
606:                 .Header1.FontName = "Tahoma"
607:                 .Header1.FontSize = 8
608:                 .Header1.Alignment = 2
609:             ENDWITH
610: 
611:             WITH .Column5
612:                 .Width         = 31
613:                 .ControlSource = "cursor_4c_Resumo.CUniPs"
614:                 .Header1.Caption = "Unid."
615:                 .Header1.FontName = "Tahoma"
616:                 .Header1.FontSize = 8
617:                 .Header1.Alignment = 2
618:             ENDWITH
619: 
620:             WITH .Column6
621:                 .Width         = 80
622:                 .ControlSource = "cursor_4c_Resumo.Pesos"
623:                 .Header1.Caption = "Peso Fabr."
624:                 .Header1.FontName = "Tahoma"
625:                 .Header1.FontSize = 8
626:                 .Header1.Alignment = 2
627:             ENDWITH
628: 

*-- Linhas 644 a 683:
644:     * getTotPeso (soma PsFaseAnt calculada em InicializarDistrib)
645:     *==========================================================================
646:     PROTECTED PROCEDURE ConfigurarCamposExtras()
647:         THIS.AddObject("lbl_4c_Label2", "Label")
648:         WITH THIS.lbl_4c_Label2
649:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
650:             .Top       = 458
651:             .Left      = 71
652:             .FontName  = "Tahoma"
653:             .FontSize  = 8
654:             .BackStyle = 0
655:             .ForeColor = RGB(90, 90, 90)
656:             .Visible   = .T.
657:         ENDWITH
658: 
659:         THIS.AddObject("txt_4c_Descr", "TextBox")
660:         WITH THIS.txt_4c_Descr
661:             .Top           = 454
662:             .Left          = 131
663:             .Width         = 335
664:             .Height        = 23
665:             .ReadOnly      = .T.
666:             .ControlSource = "cursor_4c_Distrib.CDescs"
667:             .FontName      = "Tahoma"
668:             .FontSize      = 8
669:             .BackColor     = RGB(240, 240, 240)
670:             .BorderStyle   = 1
671:             .Themes        = .F.
672:             .Visible       = .T.
673:         ENDWITH
674: 
675:         THIS.AddObject("txt_4c_TotPeso", "TextBox")
676:         WITH THIS.txt_4c_TotPeso
677:             .Top         = 454
678:             .Left        = 577
679:             .Width       = 81
680:             .Height      = 23
681:             .ReadOnly    = .T.
682:             .Alignment   = 3
683:             .Value       = THIS.this_nTotPeso

*-- Linhas 695 a 709:
695:     * ConfigurarBotoes - Botoes Alterar (left=650) e OK (left=725)
696:     *==========================================================================
697:     PROTECTED PROCEDURE ConfigurarBotoes()
698:         THIS.AddObject("cmd_4c_Alterar", "CommandButton")
699:         WITH THIS.cmd_4c_Alterar
700:             .Top             = 3
701:             .Left            = 650
702:             .Width           = 75
703:             .Height          = 75
704:             .Caption         = "Alterar"
705:             .FontName        = "Tahoma"
706:             .FontSize        = 8
707:             .FontBold        = .T.
708:             .FontItalic      = .T.
709:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 716 a 732:
716:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
717:             .Visible         = .T.
718:         ENDWITH
719:         BINDEVENT(THIS.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
720: 
721:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
722:         WITH THIS.cmd_4c_Ok
723:             .Top             = 3
724:             .Left            = 725
725:             .Width           = 75
726:             .Height          = 75
727:             .Caption         = "OK"
728:             .FontName        = "Tahoma"
729:             .FontSize        = 8
730:             .FontBold        = .T.
731:             .FontItalic      = .T.
732:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 739 a 747:
739:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
740:             .Visible         = .T.
741:         ENDWITH
742:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
743:     ENDPROC
744: 
745:     *==========================================================================
746:     * BtnAlterarClick - Habilita edicao nas colunas Pesos, Qtds e Peso2s
747:     * BackColor 12713983 = RGB(255,255,193) pale-yellow do legado

*-- Linhas 764 a 784:
764:     * BtnIncluirClick - Reinicializa distribuicao a partir de xNensi
765:     *
766:     * SIGPDMP1 legado nao possui botao Incluir explicito; a "inclusao" ocorre
767:     * automaticamente no Init quando pcEscolha = "INSERIR" via reconstrucao
768:     * do cursor TmpDistrib percorrendo xNensi.Visivel = .F.. Este metodo
769:     * replica essa logica: recarrega cursor_4c_Distrib e cursor_4c_Resumo do
770:     * xNensi compartilhado pelo form pai e refresca grids e totalizador.
771:     *==========================================================================
772:     PROCEDURE BtnIncluirClick()
773:         LOCAL loc_cTitulo
774:         loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
775:         THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
776:         THIS.this_oBusinessObject.InicializarResumo()
777:         THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
778:         THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
779:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
780:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
781:         ENDIF
782:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
783:             THIS.grd_4c_Dados.Refresh()
784:         ENDIF

*-- Linhas 813 a 835:
813:             THIS.this_oBusinessObject.this_lLiberaAlteracao = .F.
814:         ENDIF
815:     ENDPROC
816: 
817:     *==========================================================================
818:     * BtnExcluirClick - Descarta alteracoes feitas em cursor_4c_Distrib
819:     *
820:     * Confirma com o usuario e recarrega cursor_4c_Distrib do xNensi
821:     * (chamando InicializarDistrib novamente). Qualquer linha marcada como
822:     * modificada (Locals = 'M') eh perdida. Util quando o usuario decide
823:     * cancelar as alteracoes antes de pressionar OK.
824:     *==========================================================================
825:     PROCEDURE BtnExcluirClick()
826:         LOCAL loc_cTitulo, loc_cMsg
827:         loc_cMsg = "Descartar todas as altera" + CHR(231) + CHR(245) + "es?"
828:         IF !MsgConfirma(loc_cMsg, "Confirma" + CHR(231) + CHR(227) + "o")
829:             RETURN
830:         ENDIF
831:         loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
832:         THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
833:         THIS.this_oBusinessObject.InicializarResumo()
834:         THIS.this_nTotPeso = THIS.this_oBusinessObject.this_nTotPeso
835:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"

*-- Linhas 933 a 953:
933:         ENDIF
934:     ENDPROC
935: 
936:     *==========================================================================
937:     * FormParaBO - Sincroniza propriedades de controle do form para o BO
938:     * O BO gerencia cursor_4c_Distrib diretamente; apenas sincroniza estado.
939:     *==========================================================================
940:     PROTECTED PROCEDURE FormParaBO()
941:         THIS.this_oBusinessObject.this_nTotPeso         = THIS.this_nTotPeso
942:         THIS.this_oBusinessObject.this_lLiberaAlteracao = THIS.this_lLiberaAlteracao
943:     ENDPROC
944: 
945:     *==========================================================================
946:     * BOParaForm - Atualiza controles do form com dados do BO
947:     * Refresca totalizador de peso e campo de descricao da linha corrente.
948:     *==========================================================================
949:     PROTECTED PROCEDURE BOParaForm()
950:         THIS.this_nTotPeso = THIS.this_oBusinessObject.this_nTotPeso
951:         IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
952:             THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
953:         ENDIF

*-- Linhas 1002 a 1011:
1002:     * Botao Alterar visivel somente no modo INSERIR (replica fChecaAcesso do legado)
1003:     *==========================================================================
1004:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1005:         IF VARTYPE(THIS.cmd_4c_Alterar) = "O"
1006:             THIS.cmd_4c_Alterar.Visible = INLIST(ALLTRIM(THIS.this_cEscolha), "INSERIR")
1007:         ENDIF
1008:     ENDPROC
1009: 
1010:     *==========================================================================
1011:     * BtnSalvarClick - Persiste alteracoes e fecha (equivalente ao BtnOkClick)

*-- Linhas 1042 a 1063:
1042:     * Metodo existe para compatibilidade com FormBase. Navega para o topo do
1043:     * grid principal como comportamento neutro.
1044:     *==========================================================================
1045:     PROCEDURE BtnBuscarClick()
1046:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1047:             IF USED("cursor_4c_Distrib") AND !EOF("cursor_4c_Distrib")
1048:                 SELECT cursor_4c_Distrib
1049:                 GO TOP
1050:             ENDIF
1051:             THIS.grd_4c_Dados.Refresh()
1052:         ENDIF
1053:     ENDPROC
1054: 
1055:     *==========================================================================
1056:     * Destroy - Libera BO e referencia ao form pai
1057:     *==========================================================================
1058:     PROCEDURE Destroy()
1059:         THIS.this_oBusinessObject = .NULL.
1060:         THIS.this_oFormPai        = .NULL.
1061:         DODEFAULT()
1062:     ENDPROC
1063: 


### BO (C:\4c\projeto\app\classes\SigPdMp1BO.prg):
*==============================================================================
* SIGPDMP1BO.PRG
* Business Object para Componentes Agregados (SIGPDMP1)
* Form operacional: exibe e permite edicao de componentes de uma operacao
* de industrializacao. Recebe cursor xNensi do form pai e trabalha
* com cursores locais cursor_4c_Distrib e cursor_4c_Resumo.
*==============================================================================

DEFINE CLASS SigPdMp1BO AS BusinessBase

    *-- Tabela e chave (form operacional sem CRUD direto na tabela principal)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Dados da operacao (vindos de tmpnens / xNensi do form pai)
    this_nNumPs  = 0    && Numero da operacao (tmpnens.numps)
    this_cEmps   = ""   && Empresa (tmpnens.emps)
    this_cDOpPs  = ""   && Descricao da operacao (tmpnens.dopps)
    this_cTitulo = ""   && Titulo da col. Industrializacao (ParentForm.ParentForm.Titulo)

    *-- Controle de edicao
    this_lLiberaAlteracao = .F.  && .T. quando usuario clica Alterar
    this_cEscolha         = ""   && "INSERIR" ou outro modo vindo do form pai

    *-- Posicao de navegacao em xNensi antes de abrir o form
    this_nRecnoAnt = 0

    *-- Totalizador de peso (soma de PsFaseAnt dos registros nao-visiveis)
    this_nTotPeso = 0

    *-- Valor anterior de celula em edicao no grid (controle de alteracao)
    this_nAntValue = 0

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO operacional de Componentes Agregados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumPs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor_4c_Distrib
    * Mapeia colunas da linha corrente do grid principal
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumPs = TratarNulo(Nops,   "N")
            THIS.this_cEmps  = ALLTRIM(TratarNulo(CMats,  "C"))
            THIS.this_cDOpPs = ALLTRIM(TratarNulo(CDescs, "C"))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDistrib - Cria cursor_4c_Distrib a partir de xNensi
    * Equivale ao bloco de criacao do TmpDistrib no Init original.
    * Percorre xNensi na ordem NopCMat, incluindo apenas registros onde
    * Visivel = .F. (os que ainda nao foram distribuidos).
    * par_cTitulo: caption dinamico da coluna Industrializacao
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarDistrib(par_cTitulo)
        LOCAL loc_lSucesso, loc_nTotPeso, loc_nX, loc_nQtds, loc_nPesos
        loc_lSucesso = .F.
        loc_nTotPeso = 0
        loc_nX       = 1

        TRY
            THIS.this_cTitulo = par_cTitulo

            *-- Salva posicao corrente de xNensi para restaurar no OK
            SELECT xNensi
            THIS.this_nRecnoAnt = RECNO()

            *-- Recria cursor de distribuicao
            IF USED("cursor_4c_Distrib")
                USE IN cursor_4c_Distrib
            ENDIF

            CREATE CURSOR cursor_4c_Distrib ( ;
                Nops    N(10,0), ;
                Nenvs   N(10,0), ;
                CodPds  C(10),   ;
                CMats   C(14),   ;
                CUnis   C(3),    ;
                Qtds    N(10,3), ;
                Pesos   N(10,3), ;
                Qtds2   N(10,3), ;
                Pesos2  N(10,3), ;
                CDescs  C(40),   ;
                CGrus   C(3),    ;
                TpOps   C(15),   ;
                nLotes  N(10,0), ;
                Qtd2s   N(10,3), ;
                Peso2s  N(10,3), ;
                cUniPs  C(3),    ;
                CodCors C(4),    ;
                CodTams C(4),    ;
                nTrans  N(6,0),  ;
                Locals  C(1)     ;
            )

            *-- Percorre xNensi em ordem NopCMat, pula visiveis (ja distribuidos)
            SELECT xNensi
            SET ORDER TO NopCMat
            SCAN
                IF xNensi.Visivel
                    LOOP
                ENDIF

                loc_nQtds  = xNensi.QtFaseAnt
                loc_nPesos = xNensi.PsFaseAnt

                REPLACE nTrans WITH loc_nX IN xNensi

                INSERT INTO cursor_4c_Distrib ( ;
                    Nops, Nenvs, Qtds2, Pesos2, CUnis, CMats, CDescs, ;
                    CGrus, Qtds, Pesos, nLotes, Peso2s, cUniPs, ;
                    CodCors, CodTams, nTrans ;
                ) VALUES ( ;
                    xNensi.Nops, xNensi.Nenvs, loc_nQtds, loc_nPesos, ;
                    xNensi.CUnis, xNensi.CMats, xNensi.CDescs, ;
                    xNensi.CGrus, xNensi.Qtds, xNensi.Pesos, xNensi.nLotes, ;
                    xNensi.Peso2s, xNensi.cUniPs, xNensi.CodCors, ;
                    xNensi.CodTams, xNensi.nTrans ;
                )

                loc_nX       = loc_nX + 1
                loc_nTotPeso = loc_nTotPeso + loc_nPesos
            ENDSCAN

            THIS.this_nTotPeso = loc_nTotPeso

            SELECT cursor_4c_Distrib
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarResumo - Cria cursor_4c_Resumo com totais por componente
    * Replica SELECT...GROUP BY...INTO CURSOR TmpResumo do Init original.
    * Agrupa xNensi onde Visivel = .T. (registros ja distribuidos).
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarResumo()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Resumo")
                USE IN cursor_4c_Resumo
            ENDIF

            SELECT CMats, CUnis, CUniPs,      ;
                   SUM(Qtds)   AS Qtds,       ;
                   SUM(Pesos)  AS Pesos,      ;
                   SUM(Peso2s) AS Peso2s      ;
            FROM xNensi                       ;
            WHERE xNensi.Visivel              ;
            GROUP BY CMats, CUnis, CUniPs     ;
            INTO CURSOR cursor_4c_Resumo READWRITE

            SELECT cursor_4c_Resumo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Grava linhas modificadas de cursor_4c_Distrib em xNensi
    * Replica logica do botao OK original.
    * So persiste quando this_lLiberaAlteracao = .T. (usuario clicou Alterar).
    * Identifica linhas modificadas pelo campo Locals = 'M'.
    * Atualiza Qtds, Pesos e Peso2s em xNensi via nTrans.
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION SalvarAlteracoes()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF THIS.this_lLiberaAlteracao
                SELECT cursor_4c_Distrib
                SCAN
                    IF cursor_4c_Distrib.Locals = "M"
                        SELECT xNensi
                        LOCATE FOR nTrans = cursor_4c_Distrib.nTrans
                        IF !EOF()
                            REPLACE Qtds   WITH cursor_4c_Distrib.Qtds, ;
                                    Pesos  WITH cursor_4c_Distrib.Pesos, ;
                                    Peso2s WITH cursor_4c_Distrib.Peso2s
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * HabilitarAlteracao - Permite edicao nas colunas Pesos, Qtds e Peso2s
    * Define this_lLiberaAlteracao = .T. para que SalvarAlteracoes persista
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarAlteracao()
        THIS.this_lLiberaAlteracao = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarModificado - Marca registro corrente de cursor_4c_Distrib como 'M'
    * Chamado pelos handlers de Valid/KeyPress do grid ao detectar mudanca
    *--------------------------------------------------------------------------
    PROCEDURE MarcarModificado()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Distrib")
                REPLACE Locals WITH "M" IN cursor_4c_Distrib
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel: form operacional nao insere registros no banco
    * A criacao inicial dos componentes ocorre via InicializarDistrib (cursor
    * em memoria) e a persistencia eh feita em xNensi pelo form pai (SigPdMov)
    * no momento do salvamento global da operacao.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Persiste alteracoes do cursor_4c_Distrib em xNensi
    * Equivale ao "OK Click" do form original: percorre linhas marcadas como
    * 'M' (modificadas) e replica Qtds/Pesos/Peso2s para o cursor pai xNensi
    * via campo nTrans. Form operacional nao executa UPDATE direto no banco;
    * a gravacao em SigPdNen ocorre pelo form SigPdMov que mantem xNensi.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.SalvarAlteracoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: form operacional usa cursores locais
    * Alteracoes ficam em xNensi (cursor do datasession do form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF EMPTY(par_cOperacao)
            RETURN
        ENDIF
        RETURN
    ENDPROC

ENDDEFINE

