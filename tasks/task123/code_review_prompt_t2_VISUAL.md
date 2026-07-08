# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'optTipos' (parent: SIGREIMP): Top original=188 vs migrado 'opt_4c_OptTipos' Top=3 (diff=185px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTipos' (parent: SIGREIMP): Left original=92 vs migrado 'opt_4c_OptTipos' Left=5 (diff=87px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreimp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1701 linhas total):

*-- Linhas 19 a 33:
19: *
20: * FASE 4/8 - Form - Filtros e Grades na Page1
21: *   * ConfigurarPaginaLista() - orquestra configuracao de Page1 (filtros + grades)
22: *   * ConfigurarFiltrosData() - periodo, datas e checkbox SubTotDat
23: *   * ConfigurarFiltroEmpresa() - campos codigo e descricao empresa
24: *   * ConfigurarFiltroConta() - campos codigo e descricao conta
25: *   * ConfigurarOpcoes() - OptionGroup Detalhado/Resumido
26: *   * ConfigurarLabelsGrades() - labels acima das grades
27: *   * ConfigurarGradeEntradas() - grd_4c_OperacoesE com CheckBox
28: *   * ConfigurarGradeSaidas() - grd_4c_OperacoesS com CheckBox
29: *   * ConfigurarBotoesGradeEntradas() - cmg_4c_BtnGradeE (Marcar/Desmarcar)
30: *   * ConfigurarBotoesGradeSaidas() - cmg_4c_BtnGradeS (Marcar/Desmarcar)
31: *   * VincularEventos() - BINDEVENTs para botoes e campos
32: *   * FormParaRelatorio() - transfere valores do form para o BO
33: *   * LimparCampos() - inicializa campos com valores padrao

*-- Linhas 47 a 58:
47: *     (Click, KeyPress) para replicar Replace SelImp do original
48: *   * ConfigurarEventosCheckGradeS() - BINDEVENT em grd_4c_OperacoesS.Column1.Check1
49: *     (Click, KeyPress) para replicar Replace SelImp do original
50: *   * Handlers (PUBLIC) do checkbox da grade de Entradas:
51: *       CheckGradeEClick    - toggle SelImp via clique do mouse
52: *       CheckGradeEKeyPress - toggle SelImp via ENTER (13) ou ESPACO (32)
53: *   * Handlers (PUBLIC) do checkbox da grade de Saidas:
54: *       CheckGradeSClick    - toggle SelImp via clique do mouse
55: *       CheckGradeSKeyPress - toggle SelImp via ENTER (13) ou ESPACO (32)
56: *   * TornarControlesVisiveis() - helper recursivo que garante .Visible = .T. em
57: *     todos os controles aninhados (Pages e Controls). Compensa o default .F. de
58: *     AddObject e evita formulario "em branco" apos configuracao programatica.

*-- Linhas 64 a 85:
64: * FASE 6/8 - Form - Campos Restantes e Lookups (Complementacao)
65: *   * HeaderHeight=0, AllowHeaderSizing=.F., AllowRowSizing=.F. nos grids
66: *     (replica propriedades do original que ocultam cabecalhos das grades)
67: *   * Column1.Sparse=.F. - CheckBox visivel em TODAS as linhas do grid,
68: *     nao apenas na linha corrente (PILAR 1 - fidelidade visual ao original)
69: *   * BINDEVENT chk_4c_ChkSubTotDat.When -> QuandoSubTotDat
70: *     Replica: chkSubTotDat.When = Return (optTipos.Value = 1) do original
71: *   * QuandoSubTotDat() - permite foco no checkbox apenas no modo Detalhado
72: *   * BtnVisualizarClick / BtnImprimirClick com refresh de grade antes do
73: *     processamento - replica Go Bottom/Refresh/Go Top do btnReport.Click
74: *     original para garantir que ultimo estado de CheckBox seja commitado
75: *
76: * FASE 7/8 - Form - Eventos Principais (CONCLUIDA em fases anteriores)
77: *   Formulario tipo RELATORIO (frmrelatorio): os "eventos principais" sao os
78: *   handlers dos botoes do cmg_4c_Botoes, todos ja implementados na Fase 4:
79: *   * BtnVisualizarClick() - preview na tela (Buttons(1))
80: *     - Refresh de grade para commitar ultimo CheckBox
81: *     - FormParaRelatorio() + ValidarFiltros() + BO.Visualizar()
82: *   * BtnImprimirClick() - envio para impressora (Buttons(2))
83: *     - Mesma logica de refresh + FormParaRelatorio() + ValidarFiltros() + BO.Imprimir()
84: *   * BtnEncerrarClick() - fecha formulario (Buttons(4))
85: *     - THIS.Release()

*-- Linhas 157 a 165:
157: 
158:         TRY
159:             *-- Caption do formulario
160:             THIS.Caption = "Relat" + CHR(243) + "rio Comparativo de Impostos"
161: 
162:             *-- Garantir variavel global de icones
163:             IF TYPE("gc_4c_CaminhoIcones") = "U"
164:                 gc_4c_CaminhoIcones = ""
165:             ENDIF

*-- Linhas 188 a 197:
188:                 THIS.ConfigurarPageFrame()
189: 
190:                 *-- Propagar Caption para labels do cabecalho
191:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
192:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
193: 
194:                 *-- Fase 4: controles de filtro e grades na Page1
195:                 THIS.ConfigurarPaginaLista()
196: 
197:                 *-- Fase 5: eventos adicionais e ajustes de comportamento

*-- Linhas 234 a 272:
234:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
235: 
236:         WITH THIS.cnt_4c_Cabecalho
237:             .Top         = 0
238:             .Left        = 0
239:             .Width       = THIS.Width
240:             .Height      = 80
241:             .BackStyle   = 1
242:             .BackColor   = RGB(100, 100, 100)
243:             .BorderWidth = 0
244:             .Visible     = .T.
245: 
246:             .AddObject("lbl_4c_Sombra", "Label")
247:             WITH .lbl_4c_Sombra
248:                 .Top       = 22
249:                 .Left      = 22
250:                 .Width     = THIS.Width
251:                 .Height    = 40
252:                 .Caption   = "Relat" + CHR(243) + "rio Comparativo de Impostos"
253:                 .FontName  = "Tahoma"
254:                 .FontSize  = 14
255:                 .FontBold  = .T.
256:                 .ForeColor = RGB(0, 0, 0)
257:                 .BackStyle = 0
258:                 .Visible   = .T.
259:             ENDWITH
260: 
261:             .AddObject("lbl_4c_Titulo", "Label")
262:             WITH .lbl_4c_Titulo
263:                 .Top       = 20
264:                 .Left      = 20
265:                 .Width     = THIS.Width
266:                 .Height    = 40
267:                 .Caption   = "Relat" + CHR(243) + "rio Comparativo de Impostos"
268:                 .FontName  = "Tahoma"
269:                 .FontSize  = 14
270:                 .FontBold  = .T.
271:                 .ForeColor = RGB(255, 255, 255)
272:                 .BackStyle = 0

*-- Linhas 286 a 311:
286:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
287: 
288:         WITH THIS.cmg_4c_Botoes
289:             .Top           = 0
290:             .Left          = 727
291:             .Width         = 273
292:             .Height        = 80
293:             .ButtonCount   = 4
294:             .BackStyle     = 0
295:             .BorderStyle   = 0
296:             .BorderColor   = RGB(136, 189, 188)
297:             .SpecialEffect = 1
298:             .Themes        = .F.
299:             .Visible       = .T.
300: 
301:             WITH .Buttons(1)
302:                 .Top             = 5
303:                 .Left            = 5
304:                 .Width           = 65
305:                 .Height          = 70
306:                 .Caption         = "Visualizar"
307:                 .FontBold        = .T.
308:                 .FontItalic      = .T.
309:                 .BackColor       = RGB(255, 255, 255)
310:                 .ForeColor       = RGB(90, 90, 90)
311:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 318 a 330:
318:             ENDWITH
319: 
320:             WITH .Buttons(2)
321:                 .Top             = 5
322:                 .Left            = 71
323:                 .Width           = 65
324:                 .Height          = 70
325:                 .Caption         = "Imprimir"
326:                 .FontName        = "Tahoma"
327:                 .FontBold        = .T.
328:                 .FontItalic      = .T.
329:                 .FontSize        = 8
330:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 339 a 351:
339:             ENDWITH
340: 
341:             WITH .Buttons(3)
342:                 .Top             = 5
343:                 .Left            = 137
344:                 .Width           = 65
345:                 .Height          = 70
346:                 .Caption         = "Excel"
347:                 .FontName        = "Tahoma"
348:                 .FontBold        = .T.
349:                 .FontItalic      = .T.
350:                 .FontSize        = 8
351:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 361 a 373:
361:             ENDWITH
362: 
363:             WITH .Buttons(4)
364:                 .Top             = 5
365:                 .Left            = 203
366:                 .Width           = 65
367:                 .Height          = 70
368:                 .Caption         = "Encerrar"
369:                 .Cancel          = .T.
370:                 .FontName        = "Tahoma"
371:                 .FontBold        = .T.
372:                 .FontItalic      = .T.
373:                 .FontSize        = 8

*-- Linhas 395 a 409:
395:         loc_oPgf = THIS.pgf_4c_Paginas
396: 
397:         loc_oPgf.PageCount = 1
398:         loc_oPgf.Top       = 80
399:         loc_oPgf.Left      = -1
400:         loc_oPgf.Width     = THIS.Width + 2
401:         loc_oPgf.Height    = THIS.Height - 80
402:         loc_oPgf.Tabs      = .F.
403: 
404:         loc_oPgf.Page1.Caption   = "Filtros"
405:         loc_oPgf.Page1.FontName  = "Tahoma"
406:         loc_oPgf.Page1.FontSize  = 8
407:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
408:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
409:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 433 a 509:
433:     ENDPROC
434: 
435:     *--------------------------------------------------------------------------
436:     * ConfigurarFiltrosData - Adiciona campos de periodo e checkbox SubTotDat
437:     * Linha superior do formulario: DtInicial a DtFinal [Totalizar Por Datas]
438:     *--------------------------------------------------------------------------
439:     PROTECTED PROCEDURE ConfigurarFiltrosData(par_oPagina)
440:         par_oPagina.AddObject("lbl_4c_Periodo", "Label")
441:         WITH par_oPagina.lbl_4c_Periodo
442:             .Top       = 23
443:             .Left      = 30
444:             .Width     = 68
445:             .Height    = 18
446:             .Caption   = "Per" + CHR(237) + "odo :"
447:             .FontName  = "Tahoma"
448:             .FontSize  = 8
449:             .ForeColor = RGB(90, 90, 90)
450:             .BackStyle = 0
451:             .Visible   = .T.
452:         ENDWITH
453: 
454:         par_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
455:         WITH par_oPagina.txt_4c_DtInicial
456:             .Top       = 18
457:             .Left      = 102
458:             .Width     = 90
459:             .Height    = 25
460:             .Format    = "D"
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .BackColor = RGB(255, 255, 255)
464:             .ForeColor = RGB(90, 90, 90)
465:             .Value     = {}
466:             .Visible   = .T.
467:         ENDWITH
468: 
469:         par_oPagina.AddObject("lbl_4c_A", "Label")
470:         WITH par_oPagina.lbl_4c_A
471:             .Top       = 23
472:             .Left      = 196
473:             .Width     = 16
474:             .Height    = 18
475:             .Caption   = "a"
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .ForeColor = RGB(90, 90, 90)
479:             .BackStyle = 0
480:             .Visible   = .T.
481:         ENDWITH
482: 
483:         par_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
484:         WITH par_oPagina.txt_4c_DtFinal
485:             .Top       = 18
486:             .Left      = 216
487:             .Width     = 90
488:             .Height    = 25
489:             .Format    = "D"
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .BackColor = RGB(255, 255, 255)
493:             .ForeColor = RGB(90, 90, 90)
494:             .Value     = {}
495:             .Visible   = .T.
496:         ENDWITH
497: 
498:         par_oPagina.AddObject("chk_4c_ChkSubTotDat", "CheckBox")
499:         WITH par_oPagina.chk_4c_ChkSubTotDat
500:             .Top       = 111
501:             .Left      = 320
502:             .Width     = 185
503:             .Height    = 25
504:             .Caption   = "Totalizar Por Datas"
505:             .Value     = 0
506:             .FontName  = "Tahoma"
507:             .FontSize  = 8
508:             .ForeColor = RGB(90, 90, 90)
509:             .BackStyle = 0

*-- Linhas 517 a 556:
517:     * getDEmpresa.When = Return Empty(getEmpresa.Value) - gerenciado via BINDEVENT
518:     *--------------------------------------------------------------------------
519:     PROTECTED PROCEDURE ConfigurarFiltroEmpresa(par_oPagina)
520:         par_oPagina.AddObject("lbl_4c_LblEmpresa", "Label")
521:         WITH par_oPagina.lbl_4c_LblEmpresa
522:             .Top       = 55
523:             .Left      = 30
524:             .Width     = 68
525:             .Height    = 18
526:             .Caption   = "Empresa :"
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .ForeColor = RGB(90, 90, 90)
530:             .BackStyle = 0
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         par_oPagina.AddObject("txt_4c_Empresa", "TextBox")
535:         WITH par_oPagina.txt_4c_Empresa
536:             .Top       = 50
537:             .Left      = 102
538:             .Width     = 42
539:             .Height    = 25
540:             .FontName  = "Tahoma"
541:             .FontSize  = 8
542:             .BackColor = RGB(255, 255, 255)
543:             .ForeColor = RGB(90, 90, 90)
544:             .Value     = ""
545:             .Visible   = .T.
546:         ENDWITH
547: 
548:         par_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
549:         WITH par_oPagina.txt_4c_DEmpresa
550:             .Top       = 50
551:             .Left      = 148
552:             .Width     = 363
553:             .Height    = 25
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8
556:             .BackColor = RGB(255, 255, 255)

*-- Linhas 566 a 605:
566:     * getDConta.When = Return Empty(getConta.Value) - gerenciado via BINDEVENT
567:     *--------------------------------------------------------------------------
568:     PROTECTED PROCEDURE ConfigurarFiltroConta(par_oPagina)
569:         par_oPagina.AddObject("lbl_4c_LblConta", "Label")
570:         WITH par_oPagina.lbl_4c_LblConta
571:             .Top       = 87
572:             .Left      = 30
573:             .Width     = 68
574:             .Height    = 18
575:             .Caption   = "Conta :"
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .ForeColor = RGB(90, 90, 90)
579:             .BackStyle = 0
580:             .Visible   = .T.
581:         ENDWITH
582: 
583:         par_oPagina.AddObject("txt_4c_Conta", "TextBox")
584:         WITH par_oPagina.txt_4c_Conta
585:             .Top       = 82
586:             .Left      = 102
587:             .Width     = 100
588:             .Height    = 25
589:             .FontName  = "Tahoma"
590:             .FontSize  = 8
591:             .BackColor = RGB(255, 255, 255)
592:             .ForeColor = RGB(90, 90, 90)
593:             .Value     = ""
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         par_oPagina.AddObject("txt_4c_DConta", "TextBox")
598:         WITH par_oPagina.txt_4c_DConta
599:             .Top       = 82
600:             .Left      = 206
601:             .Width     = 363
602:             .Height    = 25
603:             .FontName  = "Tahoma"
604:             .FontSize  = 8
605:             .BackColor = RGB(255, 255, 255)

*-- Linhas 615 a 664:
615:     * chkSubTotDat.When = Return (optTipos.Value = 1) - gerenciado via handler
616:     *--------------------------------------------------------------------------
617:     PROTECTED PROCEDURE ConfigurarOpcoes(par_oPagina)
618:         par_oPagina.AddObject("lbl_4c_LblTipo", "Label")
619:         WITH par_oPagina.lbl_4c_LblTipo
620:             .Top       = 120
621:             .Left      = 30
622:             .Width     = 68
623:             .Height    = 18
624:             .Caption   = "Tipo :"
625:             .FontName  = "Tahoma"
626:             .FontSize  = 8
627:             .ForeColor = RGB(90, 90, 90)
628:             .BackStyle = 0
629:             .Visible   = .T.
630:         ENDWITH
631: 
632:         par_oPagina.AddObject("opt_4c_OptTipos", "OptionGroup")
633:         WITH par_oPagina.opt_4c_OptTipos
634:             .Top         = 188
635:             .Left        = 92
636:             .Width       = 200
637:             .Height      = 28
638:             .ButtonCount = 2
639:             .BackStyle   = 0
640:             .BorderStyle = 0
641:             .Value       = 1
642:             .Themes      = .F.
643:             .Visible     = .T.
644: 
645:             WITH .Buttons(1)
646:                 .Caption   = "Detalhado"
647:                 .Top       = 3
648:                 .Left      = 5
649:                 .Width     = 90
650:                 .Height    = 20
651:                 .ForeColor = RGB(90, 90, 90)
652:                 .BackStyle = 0
653:                 .Visible   = .T.
654:             ENDWITH
655: 
656:             WITH .Buttons(2)
657:                 .Caption   = "Resumido"
658:                 .Top       = 3
659:                 .Left      = 100
660:                 .Width     = 90
661:                 .Height    = 20
662:                 .FontName  = "Tahoma"
663:                 .FontSize  = 8
664:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 672 a 713:
672:     * ConfigurarLabelsGrades - Labels de titulo para as duas grades
673:     *--------------------------------------------------------------------------
674:     PROTECTED PROCEDURE ConfigurarLabelsGrades(par_oPagina)
675:         par_oPagina.AddObject("lbl_4c_LblEntradas", "Label")
676:         WITH par_oPagina.lbl_4c_LblEntradas
677:             .Top       = 152
678:             .Left      = 30
679:             .Width     = 460
680:             .Height    = 18
681:             .Caption   = "Tipos de Opera" + CHR(231) + CHR(245) + "es de Entradas"
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .FontBold  = .T.
685:             .ForeColor = RGB(90, 90, 90)
686:             .BackStyle = 0
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         par_oPagina.AddObject("lbl_4c_LblSaidas", "Label")
691:         WITH par_oPagina.lbl_4c_LblSaidas
692:             .Top       = 152
693:             .Left      = 510
694:             .Width     = 460
695:             .Height    = 18
696:             .Caption   = "Tipos de Opera" + CHR(231) + CHR(245) + "es de Sa" + CHR(237) + "das"
697:             .FontName  = "Tahoma"
698:             .FontSize  = 8
699:             .FontBold  = .T.
700:             .ForeColor = RGB(90, 90, 90)
701:             .BackStyle = 0
702:             .Visible   = .T.
703:         ENDWITH
704:     ENDPROC
705: 
706:     *--------------------------------------------------------------------------
707:     * ConfigurarGradeEntradas - Grade de tipos de operacoes de Entradas
708:     * Column1: CheckBox para selecao (SelImp)
709:     * Column2: Codigo (Codigos, numerico, somente leitura)
710:     * Column3: Descricao (Descrs, char, somente leitura)
711:     * Regra: Column1.AddObject("Check1") ANTES de CurrentControl
712:     *        ControlSource APENAS no Column, NUNCA no Check1
713:     *        ControlSource definido DEPOIS de CurrentControl e RecordSource

*-- Linhas 719 a 728:
719:         par_oPagina.AddObject("grd_4c_OperacoesE", "Grid")
720: 
721:         WITH par_oPagina.grd_4c_OperacoesE
722:             .Top                = 173
723:             .Left               = 30
724:             .Width              = 460
725:             .Height             = 220
726:             .ColumnCount        = 3
727:             .FontName           = "Verdana"
728:             .FontSize           = 8

*-- Linhas 740 a 760:
740:             .ScrollBars         = 2
741:             .RowHeight          = 16
742: 
743:             *-- Column 1: CheckBox para selecao
744:             *-- Sparse=.F. garante checkbox visivel em TODAS as linhas (nao apenas na corrente)
745:             .Column1.Width = 30
746:             .Column1.AddObject("Check1", "CheckBox")
747:             WITH .Column1.Check1
748:                 .Caption = ""
749:                 .Top     = 0
750:                 .Left    = 2
751:                 .Width   = 22
752:                 .Height  = 17
753:                 .Visible = .T.
754:             ENDWITH
755:             .Column1.Check1.Caption = ""
756:             .Column1.CurrentControl = "Check1"
757:             .Column1.Sparse         = .F.
758: 
759:             *-- Column 2: Codigo (somente leitura)
760:             .Column2.Width    = 55

*-- Linhas 777 a 787:
777:             ENDIF
778: 
779:             *-- Headers (ocultos por HeaderHeight=0, mantidos para referencia)
780:             .Column1.Header1.Caption = ""
781:             .Column2.Header1.Caption = ""
782:             .Column3.Header1.Caption = "C" + CHR(243) + "digos"
783: 
784:             .FontName = "Verdana"
785:             .FontSize = 8
786: 
787:             .Visible = .T.

*-- Linhas 799 a 808:
799:         par_oPagina.AddObject("grd_4c_OperacoesS", "Grid")
800: 
801:         WITH par_oPagina.grd_4c_OperacoesS
802:             .Top                = 173
803:             .Left               = 510
804:             .Width              = 460
805:             .Height             = 220
806:             .ColumnCount        = 3
807:             .FontName           = "Verdana"
808:             .FontSize           = 8

*-- Linhas 820 a 839:
820:             .ScrollBars         = 2
821:             .RowHeight          = 16
822: 
823:             *-- Sparse=.F. garante checkbox visivel em TODAS as linhas
824:             .Column1.Width = 30
825:             .Column1.AddObject("Check1", "CheckBox")
826:             WITH .Column1.Check1
827:                 .Caption = ""
828:                 .Top     = 0
829:                 .Left    = 2
830:                 .Width   = 22
831:                 .Height  = 17
832:                 .Visible = .T.
833:             ENDWITH
834:             .Column1.Check1.Caption = ""
835:             .Column1.CurrentControl = "Check1"
836:             .Column1.Sparse         = .F.
837: 
838:             .Column2.Width    = 55
839:             .Column2.ReadOnly = .T.

*-- Linhas 852 a 862:
852:             ENDIF
853: 
854:             *-- Headers (ocultos por HeaderHeight=0, mantidos para referencia)
855:             .Column1.Header1.Caption = ""
856:             .Column2.Header1.Caption = ""
857:             .Column3.Header1.Caption = "C" + CHR(243) + "digos"
858: 
859:             .FontName = "Verdana"
860:             .FontSize = 8
861: 
862:             .Visible = .T.

*-- Linhas 872 a 907:
872:         par_oPagina.AddObject("cmg_4c_BtnGradeE", "CommandGroup")
873: 
874:         WITH par_oPagina.cmg_4c_BtnGradeE
875:             .Top         = 400
876:             .Left        = 167
877:             .Width       = 185
878:             .Height      = 42
879:             .ButtonCount = 2
880:             .BackStyle   = 0
881:             .BorderStyle = 0
882:             .Themes      = .F.
883:             .Visible     = .T.
884: 
885:             WITH .Buttons(1)
886:                 .Top        = 2
887:                 .Left       = 2
888:                 .Width      = 88
889:                 .Height     = 34
890:                 .Caption    = "Marcar Todos"
891:                 .BackColor  = RGB(255, 255, 255)
892:                 .ForeColor  = RGB(90, 90, 90)
893:                 .Themes     = .F.
894:                 .Visible    = .T.
895:             ENDWITH
896: 
897:             WITH .Buttons(2)
898:                 .Top        = 2
899:                 .Left       = 94
900:                 .Width      = 88
901:                 .Height     = 34
902:                 .Caption    = "Desmarcar Todos"
903:                 .FontName   = "Tahoma"
904:                 .FontSize   = 8
905:                 .BackColor  = RGB(255, 255, 255)
906:                 .ForeColor  = RGB(90, 90, 90)
907:                 .Themes     = .F.

*-- Linhas 919 a 954:
919:         par_oPagina.AddObject("cmg_4c_BtnGradeS", "CommandGroup")
920: 
921:         WITH par_oPagina.cmg_4c_BtnGradeS
922:             .Top         = 400
923:             .Left        = 647
924:             .Width       = 185
925:             .Height      = 42
926:             .ButtonCount = 2
927:             .BackStyle   = 0
928:             .BorderStyle = 0
929:             .Themes      = .F.
930:             .Visible     = .T.
931: 
932:             WITH .Buttons(1)
933:                 .Top        = 2
934:                 .Left       = 2
935:                 .Width      = 88
936:                 .Height     = 34
937:                 .Caption    = "Marcar Todos"
938:                 .BackColor  = RGB(255, 255, 255)
939:                 .ForeColor  = RGB(90, 90, 90)
940:                 .Themes     = .F.
941:                 .Visible    = .T.
942:             ENDWITH
943: 
944:             WITH .Buttons(2)
945:                 .Top        = 2
946:                 .Left       = 94
947:                 .Width      = 88
948:                 .Height     = 34
949:                 .Caption    = "Desmarcar Todos"
950:                 .FontName   = "Tahoma"
951:                 .FontSize   = 8
952:                 .BackColor  = RGB(255, 255, 255)
953:                 .ForeColor  = RGB(90, 90, 90)
954:                 .Themes     = .F.

*-- Linhas 983 a 1046:
983:         BINDEVENT(loc_oPagina.txt_4c_Conta,  "KeyPress", THIS, "TeclaConta")
984:         BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "TeclaDConta")
985:         BINDEVENT(loc_oPagina.txt_4c_DConta, "When",     THIS, "QuandoDConta")
986: 
987:         *-- OptionGroup: mudanca de tipo Detalhado/Resumido
988:         BINDEVENT(loc_oPagina.opt_4c_OptTipos, "InteractiveChange", THIS, "OptTiposChange")
989: 
990:         *-- Checkbox SubTotDat: When -> permite foco apenas em modo Detalhado
991:         *-- Replica: chkSubTotDat.When = Return (optTipos.Value = 1) do original
992:         BINDEVENT(loc_oPagina.chk_4c_ChkSubTotDat, "When", THIS, "QuandoSubTotDat")
993:     ENDPROC
994: 
995:     *--------------------------------------------------------------------------
996:     * FormParaRelatorio - Transfere valores dos campos do form para o BO
997:     *--------------------------------------------------------------------------
998:     PROTECTED PROCEDURE FormParaRelatorio()
999:         LOCAL loc_oPagina
1000:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1001: 
1002:         WITH THIS.this_oRelatorio
1003:             .this_dDtInicial  = loc_oPagina.txt_4c_DtInicial.Value
1004:             .this_dDtFinal    = loc_oPagina.txt_4c_DtFinal.Value
1005:             .this_cEmpresa    = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
1006:             .this_cDEmpresa   = ALLTRIM(loc_oPagina.txt_4c_DEmpresa.Value)
1007:             .this_cConta      = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1008:             .this_cDConta     = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
1009:             .this_lSubTotDat  = (loc_oPagina.chk_4c_ChkSubTotDat.Value = 1)
1010:             .this_nTipos      = loc_oPagina.opt_4c_OptTipos.Value
1011:         ENDWITH
1012:     ENDPROC
1013: 
1014:     *--------------------------------------------------------------------------
1015:     * LimparCampos - Inicializa campos com valores padrao
1016:     * Data = hoje, demais campos em branco, opcao Detalhado
1017:     *--------------------------------------------------------------------------
1018:     PROTECTED PROCEDURE LimparCampos()
1019:         LOCAL loc_oPagina
1020:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1021: 
1022:         WITH loc_oPagina
1023:             .txt_4c_DtInicial.Value      = DATE()
1024:             .txt_4c_DtFinal.Value        = DATE()
1025:             .txt_4c_Empresa.Value        = ""
1026:             .txt_4c_DEmpresa.Value       = ""
1027:             .txt_4c_Conta.Value          = ""
1028:             .txt_4c_DConta.Value         = ""
1029:             .chk_4c_ChkSubTotDat.Value   = 0
1030:             .chk_4c_ChkSubTotDat.Enabled = .T.
1031:             .opt_4c_OptTipos.Value       = 1
1032:         ENDWITH
1033:     ENDPROC
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * InicializarEmpresa - Preenche empresa atual do sistema nos campos
1037:     * Usa go_4c_Sistema.cCodEmpresa (substitui _Empr do legado)
1038:     *--------------------------------------------------------------------------
1039:     PROTECTED PROCEDURE InicializarEmpresa()
1040:         LOCAL loc_cCodEmpresa, loc_cSQL, loc_nResult, loc_oErro
1041:         loc_cCodEmpresa = ""
1042: 
1043:         TRY
1044:             IF TYPE("go_4c_Sistema") = "O" AND VARTYPE(go_4c_Sistema) = "O"
1045:                 loc_cCodEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1046:             ENDIF

*-- Linhas 1082 a 1098:
1082:     * Handler do Buttons(1) do cmg_4c_Botoes (BINDEVENT - deve ser PUBLIC)
1083:     * Fase 6: Refresh de grade antes do processamento replica o
1084:     * Go Bottom/Refresh/Go Top do btnReport.Click do original, garantindo
1085:     * que o ultimo estado do CheckBox seja commitado no cursor antes de filtrar.
1086:     *--------------------------------------------------------------------------
1087:     PROCEDURE BtnVisualizarClick()
1088:         LOCAL loc_oPagina, loc_cCursorE, loc_cCursorS
1089:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
1090:         loc_cCursorE = THIS.this_oRelatorio.this_cCursorOperacoesE
1091:         loc_cCursorS = THIS.this_oRelatorio.this_cCursorOperacoesS
1092: 
1093:         *-- Refresh grids para garantir ultimo estado do CheckBox no cursor
1094:         IF USED(loc_cCursorE) AND VARTYPE(loc_oPagina.grd_4c_OperacoesE) = "O"
1095:             SELECT (loc_cCursorE)
1096:             GO BOTTOM
1097:             loc_oPagina.grd_4c_OperacoesE.Refresh()
1098:             GO TOP

*-- Linhas 1127 a 1135:
1127:         loc_cCursorE = THIS.this_oRelatorio.this_cCursorOperacoesE
1128:         loc_cCursorS = THIS.this_oRelatorio.this_cCursorOperacoesS
1129: 
1130:         *-- Refresh grids para garantir ultimo estado do CheckBox no cursor
1131:         IF USED(loc_cCursorE) AND VARTYPE(loc_oPagina.grd_4c_OperacoesE) = "O"
1132:             SELECT (loc_cCursorE)
1133:             GO BOTTOM
1134:             loc_oPagina.grd_4c_OperacoesE.Refresh()
1135:             GO TOP

*-- Linhas 1261 a 1281:
1261:     *--------------------------------------------------------------------------
1262:     PROCEDURE OptTiposChange()
1263:         LOCAL loc_oPagina
1264:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1265: 
1266:         IF loc_oPagina.opt_4c_OptTipos.Value = 2
1267:             loc_oPagina.chk_4c_ChkSubTotDat.Value   = 0
1268:             loc_oPagina.chk_4c_ChkSubTotDat.Enabled = .F.
1269:         ELSE
1270:             loc_oPagina.chk_4c_ChkSubTotDat.Enabled = .T.
1271:         ENDIF
1272:     ENDPROC
1273: 
1274:     *--------------------------------------------------------------------------
1275:     * QuandoDEmpresa - When handler para txt_4c_DEmpresa
1276:     * Retorna .T. (permite foco) somente quando codigo empresa esta vazio
1277:     * Replica comportamento getDEmpresa.When do original
1278:     * Handler BINDEVENT - deve ser PUBLIC
1279:     *--------------------------------------------------------------------------
1280:     PROCEDURE QuandoDEmpresa()
1281:         RETURN EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value))

*-- Linhas 1296 a 1316:
1296:     * Retorna .T. (permite foco) somente quando Detalhado esta selecionado
1297:     * Replica comportamento chkSubTotDat.When = Return (optTipos.Value = 1)
1298:     * Handler BINDEVENT - deve ser PUBLIC
1299:     *--------------------------------------------------------------------------
1300:     PROCEDURE QuandoSubTotDat()
1301:         RETURN (THIS.pgf_4c_Paginas.Page1.opt_4c_OptTipos.Value = 1)
1302:     ENDPROC
1303: 
1304:     *--------------------------------------------------------------------------
1305:     * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecionar empresa
1306:     * Preenche txt_4c_Empresa e txt_4c_DEmpresa com o resultado
1307:     *--------------------------------------------------------------------------
1308:     PROTECTED PROCEDURE AbrirBuscaEmpresa()
1309:         LOCAL loc_oLookup, loc_oPagina, loc_cValorInicial, loc_oErro
1310:         loc_oPagina     = THIS.pgf_4c_Paginas.Page1
1311:         loc_cValorInicial = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
1312: 
1313:         TRY
1314:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1315:                 "SigCdEmp", ;
1316:                 "Cemps", ;

*-- Linhas 1445 a 1464:
1445:     * ConfigurarPaginaDados - Orquestrador da Fase 5
1446:     * Em forms REPORT (frmrelatorio), a "Page Dados" eh interpretada como o
1447:     * conjunto de configuracoes adicionais sobre os filtros e grades de selecao:
1448:     *   - Eventos de interacao dos checkboxes dentro das grades de operacoes
1449:     *   - Enabled dos campos de descricao conforme presenca do codigo
1450:     * Replica os comportamentos das procedures de grdOperacoesE.Column1.Check1 e
1451:     * grdOperacoesS.Column1.Check1 do form original (Click, MouseDown, KeyPress).
1452:     *--------------------------------------------------------------------------
1453:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1454:         THIS.ConfigurarEventosCheckGradeE()
1455:         THIS.ConfigurarEventosCheckGradeS()
1456:     ENDPROC
1457: 
1458:     *--------------------------------------------------------------------------
1459:     * ConfigurarEventosCheckGradeE - Vincula eventos no CheckBox da Column1
1460:     * da grade de Entradas para replicar o comportamento do original
1461:     * (SIGREIMP.grdOperacoesE.Column1.Check1).
1462:     *
1463:     * No SCX original:
1464:     *   Click   -> NoDefault

*-- Linhas 1483 a 1491:
1483:     ENDPROC
1484: 
1485:     *--------------------------------------------------------------------------
1486:     * ConfigurarEventosCheckGradeS - Vincula eventos no CheckBox da Column1
1487:     * da grade de Saidas. Espelha ConfigurarEventosCheckGradeE.
1488:     *--------------------------------------------------------------------------
1489:     PROTECTED PROCEDURE ConfigurarEventosCheckGradeS()
1490:         LOCAL loc_oGrid, loc_oCheck
1491:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesS

*-- Linhas 1583 a 1591:
1583:     *   getConta.Value     = []
1584:     *   getDConta.Value    = []
1585:     *   optTipos.Value     = 1   (Detalhado)
1586:     *   chkSubTotDat.Value = .F.
1587:     * Tambem reseta o flag SelImp dos cursores de operacoes para .F.
1588:     *--------------------------------------------------------------------------
1589:     PROTECTED PROCEDURE ConfigurarValoresIniciaisFiltros()
1590:         LOCAL loc_oPagina, loc_cCursorE, loc_cCursorS
1591:         loc_oPagina = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1597 a 1621:
1597:         IF EMPTY(loc_oPagina.txt_4c_DtFinal.Value)
1598:             loc_oPagina.txt_4c_DtFinal.Value = DATE()
1599:         ENDIF
1600: 
1601:         *-- Opcoes (Detalhado por default + chkSubTotDat desmarcado)
1602:         IF loc_oPagina.opt_4c_OptTipos.Value <> 1 AND loc_oPagina.opt_4c_OptTipos.Value <> 2
1603:             loc_oPagina.opt_4c_OptTipos.Value = 1
1604:         ENDIF
1605:         loc_oPagina.chk_4c_ChkSubTotDat.Value   = 0
1606:         loc_oPagina.chk_4c_ChkSubTotDat.Enabled = (loc_oPagina.opt_4c_OptTipos.Value = 1)
1607: 
1608:         *-- Reset SelImp dos cursores de operacoes
1609:         loc_cCursorE = THIS.this_oRelatorio.this_cCursorOperacoesE
1610:         loc_cCursorS = THIS.this_oRelatorio.this_cCursorOperacoesS
1611: 
1612:         IF !EMPTY(loc_cCursorE) AND USED(loc_cCursorE)
1613:             SELECT (loc_cCursorE)
1614:             REPLACE ALL SelImp WITH .F.
1615:             GO TOP
1616:         ENDIF
1617: 
1618:         IF !EMPTY(loc_cCursorS) AND USED(loc_cCursorS)
1619:             SELECT (loc_cCursorS)
1620:             REPLACE ALL SelImp WITH .F.
1621:             GO TOP


### BO (C:\4c\projeto\app\classes\sigreimpBO.prg):
*==============================================================================
* SIGREIMPBO.PRG
* Business Object - Relatorio Comparativo de Impostos
*
* Herda de RelatorioBase (NAO de BusinessBase)
* Form original: SIGREIMP.SCX (frmrelatorio)
* Relatorios: SigReIp1 (Detalhado), SigReIp2 (Resumido)
*==============================================================================

DEFINE CLASS sigreimpBO AS RelatorioBase

    *-- Identificacao (nao aplicavel em relatorio, requerido pela base)
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros de data (getDtInicial / getDtFinal)
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro de empresa (getEmpresa / getDEmpresa)
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtro de conta (getConta / getDConta)
    this_cConta         = ""
    this_cDConta        = ""

    *-- Opcoes de relatorio (chkSubTotDat / optTipos)
    this_lSubTotDat     = .F.
    this_nTipos         = 1

    *-- Nomes dos cursores de trabalho
    this_cCursorOperacoesE  = "cursor_4c_OperacoesE"
    this_cCursorOperacoesS  = "cursor_4c_OperacoesS"
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Mensagem de erro
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oDataAccess = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacoes - Popula cursores de operacoes a partir de SigCdTom
    * Chamado no InicializarForm do Form antes de exibir os grids
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacoes()
        LOCAL loc_lSucesso, loc_cCursorE, loc_cCursorS
        LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs

        loc_lSucesso = .F.
        loc_cCursorE = THIS.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_cCursorOperacoesS

        TRY
            *-- Criar ou zerar cursor de entradas
            IF !USED(loc_cCursorE)
                CREATE CURSOR (loc_cCursorE) (SelImp l(1), Codigos n(2), Descrs c(30))
            ELSE
                ZAP IN (loc_cCursorE)
            ENDIF

            *-- Criar ou zerar cursor de saidas
            IF !USED(loc_cCursorS)
                CREATE CURSOR (loc_cCursorS) (SelImp l(1), Codigos n(2), Descrs c(30))
            ELSE
                ZAP IN (loc_cCursorS)
            ENDIF

            *-- Buscar tipos de operacoes de SigCdTom
            loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOp")

            IF loc_nResult > 0
                SELECT cursor_4c_TiposOp
                SCAN
                    loc_nCodigos = cursor_4c_TiposOp.Codigos
                    loc_cDescrs  = ALLTRIM(cursor_4c_TiposOp.Descrs)

                    SELECT (loc_cCursorE)
                    APPEND BLANK
                    REPLACE SelImp  WITH .F.
                    REPLACE Codigos WITH loc_nCodigos
                    REPLACE Descrs  WITH loc_cDescrs

                    SELECT (loc_cCursorS)
                    APPEND BLANK
                    REPLACE SelImp  WITH .F.
                    REPLACE Codigos WITH loc_nCodigos
                    REPLACE Descrs  WITH loc_cDescrs
                ENDSCAN

                IF USED("cursor_4c_TiposOp")
                    USE IN cursor_4c_TiposOp
                ENDIF

                SELECT (loc_cCursorE)
                GO TOP
                SELECT (loc_cCursorS)
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar tipos de opera" + ;
                    CHR(231) + CHR(245) + "es (SigCdTom)"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de gerar relatorio
    * Retorna .T. se valido, .F. caso contrario (this_cMensagemErro preenchido)
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        LOCAL loc_lValido, loc_cCursorE, loc_cCursorS
        LOCAL loc_nContE, loc_nContS, loc_lConflito
        LOCAL loc_nCodSaida, loc_cDescSaida

        loc_lValido    = .F.
        loc_lConflito  = .F.
        loc_cCursorE   = THIS.this_cCursorOperacoesE
        loc_cCursorS   = THIS.this_cCursorOperacoesS
        loc_nCodSaida  = 0
        loc_cDescSaida = ""

        TRY
            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"

            ELSE
                IF EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"

            ELSE
                IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Data Final Menor Que a Inicial!!!"

            ELSE
                *-- Contar entradas selecionadas
                loc_nContE = 0
                IF USED(loc_cCursorE)
                    SELECT (loc_cCursorE)
                    GO TOP
                    SCAN
                        IF SelImp
                            loc_nContE = loc_nContE + 1
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_nContE = 0
                    THIS.this_cMensagemErro = "Nenhum Tipo Operacional de Entrada Foi Selecionado!!!"

                ELSE
                    *-- Contar saidas selecionadas
                    loc_nContS = 0
                    IF USED(loc_cCursorS)
                        SELECT (loc_cCursorS)
                        GO TOP
                        SCAN
                            IF SelImp
                                loc_nContS = loc_nContS + 1
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF loc_nContS = 0
                        THIS.this_cMensagemErro = "Nenhum Tipo Operacional de Sa" + ;
                            CHR(237) + "da Foi Selecionado!!!"

                    ELSE
                        *-- Verificar conflito: mesmo codigo em entrada e saida
                        IF USED(loc_cCursorS)
                            SELECT (loc_cCursorS)
                            GO TOP
                            SCAN
                                IF SelImp AND !loc_lConflito
                                    loc_nCodSaida  = Codigos
                                    loc_cDescSaida = Descrs
                                    IF USED(loc_cCursorE)
                                        SELECT (loc_cCursorE)
                                        GO TOP
                                        LOCATE FOR Codigos = loc_nCodSaida AND SelImp
                                        IF !EOF()
                                            loc_lConflito = .T.
                                            THIS.this_cMensagemErro = "O Tipo Operacional " + ;
                                                ALLTRIM(loc_cDescSaida) + " Foi" + ;
                                                " Selecionado Como Entrada e Sa" + CHR(237) + ;
                                                "da. Verifique!!!"
                                        ENDIF
                                        SELECT (loc_cCursorS)
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF !loc_lConflito
                            loc_lValido = .T.
                        ENDIF
                    ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e prepara cursores para o relatorio
    * Replica logica do PROCEDURE processamento do SIGREIMP.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cCursorE, loc_cCursorS
        LOCAL loc_cDtInicialSQL, loc_cDtFinalSQL
        LOCAL loc_cEtiquetaEmp, loc_cEtiquetaCta
        LOCAL loc_cWrE, loc_cWrS, loc_nContE, loc_nContS, loc_nCodigo
        LOCAL loc_cQuery, loc_nResult
        LOCAL loc_cEmpresaFiltro, loc_cContaFiltro
        LOCAL loc_cEmpDopNums, loc_cQueryBaixas, loc_nResultBaixas

        loc_lSucesso = .F.
        loc_cCursorE = THIS.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_cCursorOperacoesS

        TRY
            *-- Formatar datas para SQL Server
            loc_cDtInicialSQL = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinalSQL   = "'" + ;
                PADL(TRANSFORM(YEAR(THIS.this_dDtFinal)),  4, "0") + "-" + ;
                PADL(TRANSFORM(MONTH(THIS.this_dDtFinal)), 2, "0") + "-" + ;
                PADL(TRANSFORM(DAY(THIS.this_dDtFinal)),   2, "0") + " 23:59:59'"

            *-- Montar etiquetas descritivas para o cabecalho
            IF EMPTY(THIS.this_cEmpresa)
                loc_cEtiquetaEmp = "Global"
            ELSE
                loc_cEtiquetaEmp = ALLTRIM(THIS.this_cEmpresa) + "-" + ALLTRIM(THIS.this_cDEmpresa)
            ENDIF

            IF EMPTY(THIS.this_cConta)
                loc_cEtiquetaCta = "Global"
            ELSE
                loc_cEtiquetaCta = ALLTRIM(THIS.this_cConta) + "-" + ALLTRIM(THIS.this_cDConta)
            ENDIF

            *-- Criar / zerar cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                ZAP IN (THIS.this_cCursorCabecalho)
            ELSE
                CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                    (Titulo c(200), Subtitulo c(200), Periodo c(200), SubTotDia l(1))
            ENDIF
            SELECT (THIS.this_cCursorCabecalho)
            APPEND BLANK
            REPLACE Titulo    WITH "Relat" + CHR(243) + "rio Comparativo de Impostos"
            REPLACE Subtitulo WITH "Empresa: " + loc_cEtiquetaEmp + ;
                " - Conta: " + loc_cEtiquetaCta
            REPLACE Periodo   WITH "Per" + CHR(237) + "odo: " + ;
                DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal)
            REPLACE SubTotDia WITH THIS.this_lSubTotDat
            GO TOP IN (THIS.this_cCursorCabecalho)

            *-- Construir lista de codigos de Entrada selecionados
            loc_cWrE   = ""
            loc_nContE = 0
            IF USED(loc_cCursorE)
                SELECT (loc_cCursorE)
                GO TOP
                SCAN
                    IF SelImp
                        loc_nCodigo = Codigos
                        IF EMPTY(loc_cWrE)
                            loc_cWrE = ALLTRIM(STR(loc_nCodigo, 2))
                        ELSE
                            loc_cWrE = loc_cWrE + ", " + ALLTRIM(STR(loc_nCodigo, 2))
                        ENDIF
                        loc_nContE = loc_nContE + 1
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_nContE > 1
                loc_cWrE = "IN (" + loc_cWrE + ")"
            ELSE
                loc_cWrE = "= " + loc_cWrE
            ENDIF

            *-- Construir lista de codigos de Saida selecionados
            loc_cWrS   = ""
            loc_nContS = 0
            IF USED(loc_cCursorS)
                SELECT (loc_cCursorS)
                GO TOP
                SCAN
                    IF SelImp
                        loc_nCodigo = Codigos
                        IF EMPTY(loc_cWrS)
                            loc_cWrS = ALLTRIM(STR(loc_nCodigo, 2))
                        ELSE
                            loc_cWrS = loc_cWrS + ", " + ALLTRIM(STR(loc_nCodigo, 2))
                        ENDIF
                        loc_nContS = loc_nContS + 1
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_nContS > 1
                loc_cWrS = "IN (" + loc_cWrS + ")"
            ELSE
                loc_cWrS = "= " + loc_cWrS
            ENDIF

            *-- Filtros opcionais de empresa e conta para SQL
            IF EMPTY(THIS.this_cEmpresa)
                loc_cEmpresaFiltro = ""
            ELSE
                loc_cEmpresaFiltro = "n.Emps = " + EscaparSQL(THIS.this_cEmpresa) + " AND "
            ENDIF

            IF EMPTY(THIS.this_cConta)
                loc_cContaFiltro = ""
            ELSE
                loc_cContaFiltro = "c.IClis = " + EscaparSQL(THIS.this_cConta) + " AND "
            ENDIF

            *-- Query principal: UNION ALL de Entradas e Saidas (replica lcQuery do original)
            loc_cQuery = ;
                "SELECT ' ' AS Baixas, 'E' AS Movimento, " + ;
                "n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, " + ;
                "n.TotNotas, n.ValICms, n.ICmsS, n.ValIpis, " + ;
                "n.CliFors, c.Razaos, c.Estas, n.EmpDopNums " + ;
                "FROM SigCdOpe o, SigMvNfi n, SigCdCli c " + ;
                "WHERE o.TipoOps " + loc_cWrE + " AND " + ;
                "o.NFiscals IN (1, 2) AND " + ;
                "o.Dopes = n.Dopes AND " + ;
                "n.Emis BETWEEN " + loc_cDtInicialSQL + " AND " + loc_cDtFinalSQL + ;
                " AND " + loc_cEmpresaFiltro + ;
                "LEFT(n.CliFors, 10) = c.IClis AND " + ;
                loc_cContaFiltro + "n.Cancelas = 0 " + ;
                "UNION ALL " + ;
                "SELECT ' ' AS Baixas, 'S' AS Movimento, " + ;
                "n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, " + ;
                "n.TotNotas, n.ValICms, n.ICmsS, n.ValIpis, " + ;
                "n.CliFors, c.Razaos, c.Estas, n.EmpDopNums " + ;
                "FROM SigCdOpe o, SigMvNfi n, SigCdCli c " + ;
                "WHERE o.TipoOps " + loc_cWrS + " AND " + ;
                "o.NFiscals IN (1, 2) AND " + ;
                "o.Dopes = n.Dopes AND " + ;
                "n.Emis BETWEEN " + loc_cDtInicialSQL + " AND " + loc_cDtFinalSQL + ;
                " AND " + loc_cEmpresaFiltro + ;
                "LEFT(n.CliFors, 10) = c.IClis AND " + ;
                loc_cContaFiltro + "n.Cancelas = 0"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Dados1")

            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o ao buscar dados"

            ELSE
                *-- Processar baixas: para cada nota, verificar em SigMvCab/SigMvPec
                SELECT cursor_4c_Dados1
                GO TOP
                SCAN
                    loc_cEmpDopNums  = ALLTRIM(cursor_4c_Dados1.EmpDopNums)

                    loc_cQueryBaixas = ;
                        "SELECT e.EmpDopNums, p.EmpDopNums " + ;
                        "FROM SigMvCab e, SigCdOpe o, SigMvPec p, SigCdOpe o2 " + ;
                        "WHERE e.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
                        " AND o.Dopes = e.Dopes" + ;
                        " AND (1000000 * o.NDopes) + e.Numes = p.Codigos" + ;
                        " AND p.Dopes = o2.Dopes" + ;
                        " AND o2.CBxSubns = 1"

                    loc_nResultBaixas = SQLEXEC(gnConnHandle, loc_cQueryBaixas, "cursor_4c_Baixas")

                    IF loc_nResultBaixas > 0
                        SELECT cursor_4c_Baixas
                        GO TOP IN cursor_4c_Baixas
                        IF !EOF("cursor_4c_Baixas")
                            SELECT cursor_4c_Dados1
                            REPLACE Baixas WITH "X"
                        ENDIF
                        IF USED("cursor_4c_Baixas")
                            USE IN cursor_4c_Baixas
                        ENDIF
                        SELECT cursor_4c_Dados1
                    ENDIF
                ENDSCAN

                *-- Criar cursor final conforme tipo de relatorio
                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                IF THIS.this_nTipos = 1
                    *-- Detalhado: todos os registros ordenados
                    SELECT * FROM cursor_4c_Dados1 ;
                        INTO CURSOR (THIS.this_cCursorDados) READWRITE ;
                        ORDER BY Movimento, Emis, NFis, Series
                ELSE
                    *-- Resumido: agrupado por movimento, excluindo baixas
                    SELECT Movimento, ;
                           SUM(TotNotas) AS TotNotas, ;
                           SUM(ValICms)  AS ValICms, ;
                           SUM(ICmsS)    AS ICmsS, ;
                           SUM(ValIpis)  AS ValIpis ;
                        FROM cursor_4c_Dados1 ;
                        WHERE EMPTY(Baixas) ;
                        INTO CURSOR (THIS.this_cCursorDados) READWRITE ;
                        GROUP BY Movimento ;
                        ORDER BY Movimento
                ENDIF

                IF USED("cursor_4c_Dados1")
                    USE IN cursor_4c_Dados1
                ENDIF

                SELECT (THIS.this_cCursorDados)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Gera relatorio em preview na tela
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso, loc_cRelatorio
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipos = 1
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp1.frx"
                ELSE
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp2.frx"
                ENDIF
                REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso, loc_cRelatorio
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipos = 1
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp1.frx"
                ELSE
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp2.frx"
                ENDIF
                REPORT FORM (loc_cRelatorio) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

