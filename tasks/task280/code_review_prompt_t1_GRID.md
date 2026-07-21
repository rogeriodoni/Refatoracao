# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 506: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEop.prg) - TRECHOS RELEVANTES PARA PASS GRID (861 linhas total):

*-- Linhas 109 a 129:
109:             THIS.ConfigurarPaginaLista()
110: 
111:             *-- BINDEVENTs
112:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdAfterRowColChange")
113:             BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click",     THIS, "ChkSelecaoClick")
114:             BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress",  THIS, "ChkSelecaoKeyPress")
115:             BINDEVENT(THIS.chk_4c_Ck_Marca,                    "Click",     THIS, "ChkMarcaClick")
116:             BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Confirmar,      "Click",     THIS, "CmdConfirmarClick")
117: 
118:             *-- Tornar controles visiveis apos AddObject (que cria com Visible=.F.)
119:             THIS.TornarControlesVisiveis(THIS)
120: 
121:             loc_lSucesso = .T.
122:         CATCH TO loc_oErro
123:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
124:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
125:         ENDTRY
126:         RETURN loc_lSucesso
127:     ENDPROC
128: 
129:     *--------------------------------------------------------------------------

*-- Linhas 245 a 266:
245:             GO TOP IN cursor_4c_Operacoes
246:         ENDIF
247: 
248:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
249:             THIS.grd_4c_Dados.Refresh()
250:             IF loc_lTemDados
251:                 THIS.grd_4c_Dados.SetFocus()
252:             ENDIF
253:         ENDIF
254: 
255:         IF VARTYPE(THIS.txt_4c_Operacao) = "O"
256:             THIS.txt_4c_Operacao.Refresh()
257:         ENDIF
258: 
259:         IF VARTYPE(THIS.txt_4c_Numes) = "O"
260:             THIS.txt_4c_Numes.Refresh()
261:         ENDIF
262:     ENDPROC
263: 
264:     *--------------------------------------------------------------------------
265:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra do legado)
266:     * Top=0/Left=0/Width=Form.Width/Height=80 | BackColor=RGB(100,100,100)

*-- Linhas 380 a 404:
380:     *   CurrentControl ANTES de ControlSource, Sparse=.F. obrigatorio.
381:     *--------------------------------------------------------------------------
382:     PROTECTED PROCEDURE ConfigurarGrade()
383:         THIS.AddObject("grd_4c_Dados", "Grid")
384:         WITH THIS.grd_4c_Dados
385:             .Top               = 121
386:             .Left              = 3
387:             .Width             = 732
388:             .Height            = 275
389:             .ColumnCount       = 7
390:             .FontName          = "Tahoma"
391:             .DeleteMark        = .F.
392:             .RecordMark        = .F.
393:             .ScrollBars        = 2
394:             .HeaderHeight      = 19
395:             .ReadOnly          = .F.
396:             .AllowHeaderSizing = .F.
397:             .AllowRowSizing    = .F.
398:             .GridLineColor     = RGB(238,238,238)
399: 
400:             WITH .Column1
401:                 .Width     = 15
402:                 .Movable   = .F.
403:                 .Resizable = .F.
404:                 .ReadOnly  = .F.

*-- Linhas 411 a 571:
411:                 ENDWITH
412:                 .CurrentControl    = "chk_4c_Check1"
413:                 .ControlSource     = "cursor_4c_Operacoes.Selecionada"
414:                 .Header1.Caption   = ""
415:                 .Header1.Alignment = 2
416:                 .Header1.ForeColor = RGB(90,90,90)
417:                 .Header1.FontName  = "Tahoma"
418:                 .Header1.FontSize  = 8
419:             ENDWITH
420: 
421:             WITH .Column2
422:                 .Width             = 80
423:                 .Movable           = .F.
424:                 .Resizable         = .F.
425:                 .ReadOnly          = .T.
426:                 .FontName          = "Tahoma"
427:                 .ControlSource     = "cursor_4c_Operacoes.Datas"
428:                 .Header1.Caption   = "Data"
429:                 .Header1.Alignment = 2
430:                 .Header1.ForeColor = RGB(90,90,90)
431:                 .Header1.FontName  = "Tahoma"
432:                 .Header1.FontSize  = 8
433:             ENDWITH
434: 
435:             WITH .Column3
436:                 .Width             = 35
437:                 .Movable           = .F.
438:                 .Resizable         = .F.
439:                 .ReadOnly          = .T.
440:                 .FontName          = "Tahoma"
441:                 .ControlSource     = "cursor_4c_Operacoes.Emps"
442:                 .Header1.Caption   = "Emp"
443:                 .Header1.Alignment = 2
444:                 .Header1.ForeColor = RGB(90,90,90)
445:                 .Header1.FontName  = "Tahoma"
446:                 .Header1.FontSize  = 8
447:             ENDWITH
448: 
449:             WITH .Column4
450:                 .Width             = 80
451:                 .Movable           = .F.
452:                 .Resizable         = .F.
453:                 .ReadOnly          = .T.
454:                 .FontName          = "Tahoma"
455:                 .ControlSource     = "cursor_4c_Operacoes.PrazoEnts"
456:                 .Header1.Caption   = THIS.this_cCabData
457:                 .Header1.Alignment = 2
458:                 .Header1.ForeColor = RGB(90,90,90)
459:                 .Header1.FontName  = "Tahoma"
460:                 .Header1.FontSize  = 8
461:             ENDWITH
462: 
463:             WITH .Column5
464:                 .Width             = 80
465:                 .Movable           = .F.
466:                 .Resizable         = .F.
467:                 .ReadOnly          = .T.
468:                 .FontName          = "Tahoma"
469:                 .ControlSource     = "cursor_4c_Operacoes.Contas"
470:                 .Header1.Caption   = "Cliente"
471:                 .Header1.Alignment = 2
472:                 .Header1.ForeColor = RGB(90,90,90)
473:                 .Header1.FontName  = "Tahoma"
474:                 .Header1.FontSize  = 8
475:             ENDWITH
476: 
477:             WITH .Column6
478:                 .Width             = 200
479:                 .Movable           = .F.
480:                 .Resizable         = .F.
481:                 .ReadOnly          = .T.
482:                 .FontName          = "Tahoma"
483:                 .ControlSource     = "cursor_4c_Operacoes.RClis"
484:                 .Header1.Caption   = "Nome do Cliente"
485:                 .Header1.Alignment = 2
486:                 .Header1.ForeColor = RGB(90,90,90)
487:                 .Header1.FontName  = "Tahoma"
488:                 .Header1.FontSize  = 8
489:             ENDWITH
490: 
491:             WITH .Column7
492:                 .Width             = 205
493:                 .Movable           = .F.
494:                 .Resizable         = .F.
495:                 .ReadOnly          = .T.
496:                 .FontName          = "Tahoma"
497:                 .FontSize          = 9
498:                 .ControlSource     = "cursor_4c_Operacoes.Conjuges"
499:                 .Header1.Caption   = "Conjug" + CHR(233)
500:                 .Header1.Alignment = 2
501:                 .Header1.ForeColor = RGB(90,90,90)
502:                 .Header1.FontName  = "Tahoma"
503:                 .Header1.FontSize  = 8
504:             ENDWITH
505: 
506:             .RecordSource = "cursor_4c_Operacoes"
507:         ENDWITH
508:     ENDPROC
509: 
510:     *--------------------------------------------------------------------------
511:     * GrdAfterRowColChange - Atualiza textboxes de status ao navegar no grid
512:     * (equivalente ao grdOperacoes.AfterRowColChange do legado)
513:     *--------------------------------------------------------------------------
514:     PROCEDURE GrdAfterRowColChange
515:         LPARAMETERS par_nColIndex
516:         IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
517:             THIS.txt_4c_Operacao.Refresh()
518:             THIS.txt_4c_Numes.Refresh()
519:         ENDIF
520:     ENDPROC
521: 
522:     *--------------------------------------------------------------------------
523:     * ChkSelecaoClick - Refresca grid apos toggle automatico via ControlSource
524:     * Cursor ja foi atualizado pelo binding antes de Click disparar
525:     *--------------------------------------------------------------------------
526:     PROCEDURE ChkSelecaoClick
527:         IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
528:             THIS.grd_4c_Dados.Refresh()
529:         ENDIF
530:     ENDPROC
531: 
532:     *--------------------------------------------------------------------------
533:     * ChkSelecaoKeyPress - Inverte selecao ao pressionar ENTER ou SPACE
534:     * Original: InList(nKeyCode, 13, 32) -> GATHER MEMVAR Fields Selecionada
535:     * ENTER e SPACE ambos alternam; ControlSource nao suprime default, por isso
536:     * usamos AlternarSelecao (toggle via GATHER MEMVAR como o legado) para ambos.
537:     *--------------------------------------------------------------------------
538:     PROCEDURE ChkSelecaoKeyPress
539:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
540:         IF INLIST(par_nKeyCode, 13, 32)
541:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
542:                 THIS.this_oBusinessObject.AlternarSelecao("cursor_4c_Operacoes")
543:                 THIS.grd_4c_Dados.Refresh()
544:             ENDIF
545:         ENDIF
546:     ENDPROC
547: 
548:     *--------------------------------------------------------------------------
549:     * ChkMarcaClick - Marca ou desmarca todas as operacoes (ck_Marca do legado)
550:     * Value ja esta no novo estado (VFP9 togglou antes de Click disparar)
551:     *--------------------------------------------------------------------------
552:     PROCEDURE ChkMarcaClick
553:         IF USED("cursor_4c_Operacoes")
554:             THIS.this_oBusinessObject.MarcarDesmarcarTodos( ;
555:                 THIS.chk_4c_Ck_Marca.Value, "cursor_4c_Operacoes")
556:             THIS.grd_4c_Dados.Refresh()
557:         ENDIF
558:     ENDPROC
559: 
560:     *--------------------------------------------------------------------------
561:     * CmdConfirmarClick - Popula cursor destino com operacoes selecionadas e fecha
562:     * Equivalente ao cmdSair.Click do legado: ZAP + SCAN(Selecionada=1) + Release
563:     *--------------------------------------------------------------------------
564:     PROCEDURE CmdConfirmarClick
565:         LOCAL loc_lSucesso, loc_oErro
566:         loc_lSucesso = .F.
567:         TRY
568:             loc_lSucesso = THIS.this_oBusinessObject.PopularFilOper( ;
569:                 THIS.this_cCursorDestino, "cursor_4c_Operacoes")
570:             IF !loc_lSucesso
571:                 MsgErro("Falha ao processar sele" + CHR(231) + CHR(227) + ;

*-- Linhas 600 a 618:
600:             IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
601:                 THIS.chk_4c_Ck_Marca.Value = 1
602:             ENDIF
603:             THIS.grd_4c_Dados.Refresh()
604:             THIS.txt_4c_Operacao.Refresh()
605:             THIS.txt_4c_Numes.Refresh()
606:         CATCH TO loc_oErro
607:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
608:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
609:         ENDTRY
610:     ENDPROC
611: 
612:     *--------------------------------------------------------------------------
613:     * BtnAlterarClick - Popup OPERACIONAL: mapeia p/ alternar selecao corrente
614:     * Legado SIGPREOP nao tem botao Alterar - contrato do pipeline exige metodo.
615:     * Semantica: alterna Selecionada do registro corrente (equivalente ao
616:     * chk_4c_Check1.KeyPress ENTER/SPACE do legado). Reusa BO.AlternarSelecao.
617:     *--------------------------------------------------------------------------
618:     PROCEDURE BtnAlterarClick()

*-- Linhas 624 a 642:
624:                 RETURN
625:             ENDIF
626:             THIS.this_oBusinessObject.AlternarSelecao("cursor_4c_Operacoes")
627:             THIS.grd_4c_Dados.Refresh()
628:             THIS.txt_4c_Operacao.Refresh()
629:             THIS.txt_4c_Numes.Refresh()
630:         CATCH TO loc_oErro
631:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
632:                     " PROC=" + loc_oErro.Procedure, "Erro BtnAlterarClick")
633:         ENDTRY
634:     ENDPROC
635: 
636:     *--------------------------------------------------------------------------
637:     * BtnVisualizarClick - Popup OPERACIONAL: mapeia p/ sincronizar visualizacao
638:     * Legado SIGPREOP nao tem botao Visualizar - contrato do pipeline exige metodo.
639:     * Semantica: reposiciona no topo, refresca grid e textboxes de status
640:     * (equivalente a AlternarPagina em forms CRUD - refresh completo da lista).
641:     *--------------------------------------------------------------------------
642:     PROCEDURE BtnVisualizarClick()

*-- Linhas 649 a 668:
649:             ENDIF
650:             SELECT cursor_4c_Operacoes
651:             GO TOP IN cursor_4c_Operacoes
652:             THIS.grd_4c_Dados.Refresh()
653:             THIS.grd_4c_Dados.SetFocus()
654:             THIS.txt_4c_Operacao.Refresh()
655:             THIS.txt_4c_Numes.Refresh()
656:         CATCH TO loc_oErro
657:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
658:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
659:         ENDTRY
660:     ENDPROC
661: 
662:     *--------------------------------------------------------------------------
663:     * BtnExcluirClick - Popup OPERACIONAL: mapeia p/ excluir todas da selecao
664:     * Legado SIGPREOP nao tem botao Excluir - contrato do pipeline exige metodo.
665:     * Semantica: remove todas as operacoes da selecao (desmarca Selecionada=0).
666:     * Reusa BO.MarcarDesmarcarTodos(0) + sincroniza UI.
667:     *--------------------------------------------------------------------------
668:     PROCEDURE BtnExcluirClick()

*-- Linhas 684 a 748:
684:             IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
685:                 THIS.chk_4c_Ck_Marca.Value = 0
686:             ENDIF
687:             THIS.grd_4c_Dados.Refresh()
688:             THIS.txt_4c_Operacao.Refresh()
689:             THIS.txt_4c_Numes.Refresh()
690:         CATCH TO loc_oErro
691:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
692:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
693:         ENDTRY
694:     ENDPROC
695: 
696:     *--------------------------------------------------------------------------
697:     * CarregarLista - Refresca o grid reposicionando no topo do cursor
698:     * OPERACIONAL: cursor ja foi inicializado por InicializarOperacoes()
699:     *--------------------------------------------------------------------------
700:     PROCEDURE CarregarLista()
701:         LOCAL loc_lSucesso, loc_oErro
702:         loc_lSucesso = .F.
703:         TRY
704:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
705:                 SELECT cursor_4c_Operacoes
706:                 GO TOP
707:             ENDIF
708:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
709:                 THIS.grd_4c_Dados.Refresh()
710:             ENDIF
711:             IF VARTYPE(THIS.txt_4c_Operacao) = "O"
712:                 THIS.txt_4c_Operacao.Refresh()
713:             ENDIF
714:             IF VARTYPE(THIS.txt_4c_Numes) = "O"
715:                 THIS.txt_4c_Numes.Refresh()
716:             ENDIF
717:             loc_lSucesso = .T.
718:         CATCH TO loc_oErro
719:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
720:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista")
721:         ENDTRY
722:         RETURN loc_lSucesso
723:     ENDPROC
724: 
725:     *--------------------------------------------------------------------------
726:     * BtnBuscarClick - Reposiciona no topo e refresca o grid de operacoes
727:     * OPERACIONAL: popup recebe cursor pre-populado (sem busca por texto)
728:     *--------------------------------------------------------------------------
729:     PROCEDURE BtnBuscarClick()
730:         THIS.CarregarLista()
731:         IF VARTYPE(THIS.grd_4c_Dados) = "O" AND USED("cursor_4c_Operacoes") ;
732:                 AND RECCOUNT("cursor_4c_Operacoes") > 0
733:             THIS.grd_4c_Dados.SetFocus()
734:         ENDIF
735:     ENDPROC
736: 
737:     *--------------------------------------------------------------------------
738:     * BtnSalvarClick - Confirma selecao e fecha popup (equivalente ao OK)
739:     * Popula cursor destino com operacoes marcadas (Selecionada = 1)
740:     *--------------------------------------------------------------------------
741:     PROCEDURE BtnSalvarClick()
742:         THIS.CmdConfirmarClick()
743:     ENDPROC
744: 
745:     *--------------------------------------------------------------------------
746:     * BtnCancelarClick - Cancela sem processar: reabilita pai e fecha popup
747:     * Nao popula crFilOper - pai interpretara cursor destino intacto como cancelamento
748:     *--------------------------------------------------------------------------

*-- Linhas 788 a 841:
788:         IF VARTYPE(THIS.txt_4c_Numes) = "O"
789:             THIS.txt_4c_Numes.Refresh()
790:         ENDIF
791:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
792:             THIS.grd_4c_Dados.Refresh()
793:         ENDIF
794:     ENDPROC
795: 
796:     *--------------------------------------------------------------------------
797:     * HabilitarCampos - Controla habilitacao de controles interativos
798:     * OPERACIONAL: grid e checkbox sao sempre interativos neste popup modal
799:     * par_lHabilitar: .T. = habilitar, .F. = desabilitar (default .T.)
800:     *--------------------------------------------------------------------------
801:     PROCEDURE HabilitarCampos(par_lHabilitar)
802:         LOCAL loc_lHabilitar
803:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
804:         IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
805:             THIS.chk_4c_Ck_Marca.Enabled = loc_lHabilitar
806:         ENDIF
807:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
808:             THIS.grd_4c_Dados.Enabled = loc_lHabilitar
809:         ENDIF
810:         IF VARTYPE(THIS.cnt_4c_Saida) = "O"
811:             THIS.cnt_4c_Saida.cmd_4c_Confirmar.Enabled = loc_lHabilitar
812:         ENDIF
813:     ENDPROC
814: 
815:     *--------------------------------------------------------------------------
816:     * LimparCampos - Desmarca todas as operacoes (zera Selecionada no cursor)
817:     * OPERACIONAL: LimparCampos = desmarcar toda a selecao corrente
818:     *--------------------------------------------------------------------------
819:     PROCEDURE LimparCampos()
820:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Operacoes")
821:             THIS.this_oBusinessObject.MarcarDesmarcarTodos(0, "cursor_4c_Operacoes")
822:             IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
823:                 THIS.chk_4c_Ck_Marca.Value = 0
824:             ENDIF
825:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
826:                 THIS.grd_4c_Dados.Refresh()
827:             ENDIF
828:         ENDIF
829:     ENDPROC
830: 
831:     *--------------------------------------------------------------------------
832:     * AjustarBotoesPorModo - OPERACIONAL: popup nao tem modos CRUD
833:     * Mantido para compatibilidade com contrato do pipeline de migracao.
834:     * Garante botao OK habilitado apenas se ha operacoes carregadas.
835:     *--------------------------------------------------------------------------
836:     PROCEDURE AjustarBotoesPorModo()
837:         IF VARTYPE(THIS.cnt_4c_Saida) = "O"
838:             THIS.cnt_4c_Saida.cmd_4c_Confirmar.Enabled = ;
839:                 USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
840:         ENDIF
841:     ENDPROC

