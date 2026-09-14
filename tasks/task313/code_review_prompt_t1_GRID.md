# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 497: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS GRID (921 linhas total):

*-- Linhas 229 a 276:
229: 
230:     *==========================================================================
231:     PROTECTED PROCEDURE ConfigurarGrade
232:     *-- Grid grd_4c_Selecoes: 6 colunas (Check, Codigo, Descricao, Usuario,
233:     *-- Dt.Entrada, N.Registros) ? espelho do grdSelecoes do legado
234:     *==========================================================================
235:         THIS.AddObject("grd_4c_Selecoes", "Grid")
236:         WITH THIS.grd_4c_Selecoes
237:             .Top                = 140
238:             .Left               = 15
239:             .Width              = 870
240:             .Height             = 420
241:             .RecordMark         = .F.
242:             .DeleteMark         = .F.
243:             .RowHeight          = 16
244:             .HeaderHeight       = 16
245:             .AllowHeaderSizing  = .F.
246:             .AllowRowSizing     = .F.
247:             .ReadOnly           = .F.
248:             .ScrollBars         = 2
249:             .FontName           = "Tahoma"
250:             .FontSize           = 8
251:             .GridLineColor      = RGB(238, 238, 238)
252:             .ColumnCount        = 6
253: 
254:             *-- Column1: CheckBox de selecao (SelImp)
255:             WITH .Column1
256:                 .ColumnOrder   = 1
257:                 .Width         = 20
258:                 .Movable       = .F.
259:                 .Resizable     = .F.
260:                 .ReadOnly      = .F.
261:                 WITH .Header1
262:                     .Caption   = ""
263:                     .Alignment = 2
264:                     .FontName  = "Tahoma"
265:                     .FontSize  = 8
266:                     .ForeColor = RGB(36, 84, 155)
267:                 ENDWITH
268:                 .AddObject("ctlCheck1", "CheckBox")
269:                 WITH .ctlCheck1
270:                     .Caption   = ""
271:                     .Alignment = 0
272:                     .AutoSize  = .T.
273:                     .FontName  = "Tahoma"
274:                     .FontSize  = 8
275:                     .Value     = 0
276:                 ENDWITH

*-- Linhas 285 a 303:
285:                 .Movable       = .F.
286:                 .Resizable     = .F.
287:                 .ReadOnly      = .T.
288:                 WITH .Header1
289:                     .Caption   = "C" + CHR(243) + "digo"
290:                     .Alignment = 2
291:                     .FontName  = "Tahoma"
292:                     .FontSize  = 8
293:                     .ForeColor = RGB(36, 84, 155)
294:                 ENDWITH
295:                 .AddObject("ctlText", "TextBox")
296:                 WITH .ctlText
297:                     .BorderStyle = 0
298:                     .Margin      = 0
299:                     .ReadOnly    = .T.
300:                     .FontName    = "Courier New"
301:                     .FontSize    = 8
302:                 ENDWITH
303:                 .CurrentControl = "ctlText"

*-- Linhas 310 a 328:
310:                 .Movable       = .F.
311:                 .Resizable     = .F.
312:                 .ReadOnly      = .T.
313:                 WITH .Header1
314:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
315:                     .Alignment = 2
316:                     .FontName  = "Tahoma"
317:                     .FontSize  = 8
318:                     .ForeColor = RGB(36, 84, 155)
319:                 ENDWITH
320:                 .AddObject("ctlText", "TextBox")
321:                 WITH .ctlText
322:                     .BorderStyle = 0
323:                     .Margin      = 0
324:                     .ReadOnly    = .T.
325:                     .FontName    = "Tahoma"
326:                     .FontSize    = 8
327:                 ENDWITH
328:                 .CurrentControl = "ctlText"

*-- Linhas 335 a 353:
335:                 .Movable       = .F.
336:                 .Resizable     = .F.
337:                 .ReadOnly      = .T.
338:                 WITH .Header1
339:                     .Caption   = "Usu" + CHR(225) + "rio"
340:                     .Alignment = 2
341:                     .FontName  = "Tahoma"
342:                     .FontSize  = 8
343:                     .ForeColor = RGB(36, 84, 155)
344:                 ENDWITH
345:                 .AddObject("ctlText", "TextBox")
346:                 WITH .ctlText
347:                     .BorderStyle = 0
348:                     .Margin      = 0
349:                     .ReadOnly    = .T.
350:                     .FontName    = "Courier New"
351:                     .FontSize    = 8
352:                 ENDWITH
353:                 .CurrentControl = "ctlText"

*-- Linhas 360 a 378:
360:                 .Movable       = .F.
361:                 .Resizable     = .F.
362:                 .ReadOnly      = .T.
363:                 WITH .Header1
364:                     .Caption   = "Dt.Entrada"
365:                     .Alignment = 2
366:                     .FontName  = "Tahoma"
367:                     .FontSize  = 8
368:                     .ForeColor = RGB(36, 84, 155)
369:                 ENDWITH
370:                 .AddObject("ctlText", "TextBox")
371:                 WITH .ctlText
372:                     .BorderStyle = 0
373:                     .Margin      = 0
374:                     .ReadOnly    = .T.
375:                     .FontName    = "Tahoma"
376:                     .FontSize    = 8
377:                 ENDWITH
378:                 .CurrentControl = "ctlText"

*-- Linhas 385 a 403:
385:                 .Movable       = .F.
386:                 .Resizable     = .F.
387:                 .ReadOnly      = .T.
388:                 WITH .Header1
389:                     .Caption   = "N.Registros"
390:                     .Alignment = 2
391:                     .FontName  = "Tahoma"
392:                     .FontSize  = 8
393:                     .ForeColor = RGB(36, 84, 155)
394:                 ENDWITH
395:                 .AddObject("ctlText", "TextBox")
396:                 WITH .ctlText
397:                     .BorderStyle = 0
398:                     .Margin      = 0
399:                     .ReadOnly    = .T.
400:                     .FontName    = "Tahoma"
401:                     .FontSize    = 8
402:                 ENDWITH
403:                 .CurrentControl = "ctlText"

*-- Linhas 461 a 513:
461:         BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnDesmarcarTudoClick")
462: 
463:         *-- Cliques nos cabecalhos para ordenacao
464:         BINDEVENT(THIS.grd_4c_Selecoes.Column2.Header1, "Click", THIS, "Col2HeaderClick")
465:         BINDEVENT(THIS.grd_4c_Selecoes.Column3.Header1, "Click", THIS, "Col3HeaderClick")
466:         BINDEVENT(THIS.grd_4c_Selecoes.Column4.Header1, "Click", THIS, "Col4HeaderClick")
467:         BINDEVENT(THIS.grd_4c_Selecoes.Column5.Header1, "Click", THIS, "Col5HeaderClick")
468: 
469:         *-- CheckBox de selecao individual: MouseDown + KeyPress
470:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "MouseDown", THIS, "GrdChkMouseDown")
471:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "KeyPress",  THIS, "GrdChkKeyPress")
472:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "Click",     THIS, "GrdChkClick")
473:     ENDPROC
474: 
475:     *==========================================================================
476:     PROTECTED PROCEDURE MontarGrade
477:     *-- Vincula o cursor_4c_Itn ao grid apos BuscarMalas()
478:     *==========================================================================
479:         LOCAL loc_oGrd, loc_oErro
480:         loc_oGrd = .NULL.
481:         TRY
482:             IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
483:                 loc_oGrd = THIS.grd_4c_Selecoes
484:                 loc_oGrd.RecordSource = ""
485:             ENDIF
486: 
487:             IF USED("cursor_4c_Itn")
488:                 THIS.OrdenarGrade(THIS.this_nOrdemGrade)
489: 
490:                 WITH loc_oGrd
491:                     .Column1.ControlSource = "cursor_4c_Itn.SelImp"
492:                     .Column2.ControlSource = "cursor_4c_Itn.Codigos"
493:                     .Column3.ControlSource = "cursor_4c_Itn.Descs"
494:                     .Column4.ControlSource = "cursor_4c_Itn.Usuins"
495:                     .Column5.ControlSource = "cursor_4c_Itn.Datins"
496:                     .Column6.ControlSource = "cursor_4c_Itn.Nregis"
497:                     .RecordSource          = "cursor_4c_Itn"
498:                 ENDWITH
499: 
500:                 GO TOP IN cursor_4c_Itn
501:             ENDIF
502: 
503:             IF VARTYPE(loc_oGrd) = "O"
504:                 loc_oGrd.Refresh()
505:             ENDIF
506: 
507:         CATCH TO loc_oErro
508:             MsgErro(loc_oErro.Message, "Erro MontarGrade")
509:         ENDTRY
510:     ENDPROC
511: 
512:     *==========================================================================
513:     PROCEDURE OrdenarGrade

*-- Linhas 541 a 561:
541:             ENDIF
542:         ENDIF
543: 
544:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
545:             FOR loc_i = 1 TO THIS.grd_4c_Selecoes.ColumnCount
546:                 THIS.grd_4c_Selecoes.Columns(loc_i).Header1.BackColor = ;
547:                     IIF(THIS.this_nOrdemGrade = loc_i, RGB(220, 255, 220), RGB(192, 192, 192))
548:             ENDFOR
549:         ENDIF
550:     ENDPROC
551: 
552:     *==========================================================================
553:     PROTECTED PROCEDURE TornarControlesVisiveis
554:     *==========================================================================
555:         LOCAL loc_i, loc_oControl
556:         FOR loc_i = 1 TO THIS.ControlCount
557:             loc_oControl = THIS.Controls(loc_i)
558:             IF VARTYPE(loc_oControl) = "O"
559:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
560:                     loc_oControl.Visible = .T.
561:                 ENDIF

*-- Linhas 587 a 631:
587:     *
588:     * Este form nao segue o padrao Page1=Lista/Page2=Dados.
589:     * Grid e botoes sao criados diretamente via:
590:     *   ConfigurarGrade()    ? grd_4c_Selecoes (6 colunas, checkbox SelImp)
591:     *   ConfigurarBotoes()   ? cmd_4c_Processar + cnt_4c_Saida/cmd_4c_Encerrar
592:     *   ConfigurarBtnGrade() ? cmd_4c_SelTudo + cmd_4c_Apaga
593:     * Todos chamados em InicializarForm().
594:     *==========================================================================
595:     PROTECTED PROCEDURE ConfigurarPageFrame()
596:         *-- OPERACIONAL: sem PageFrame; controles criados diretamente em InicializarForm
597:         RETURN .T.
598:     ENDPROC
599: 
600:     PROTECTED PROCEDURE ConfigurarPaginaLista()
601:         *-- OPERACIONAL: grid ja configurado por ConfigurarGrade() em InicializarForm()
602:         *-- Refrescar grade caso chamado pelo pipeline apos carga inicial
603:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5) AND USED("cursor_4c_Itn")
604:             THIS.grd_4c_Selecoes.Refresh()
605:         ENDIF
606:     ENDPROC
607: 
608:     PROTECTED PROCEDURE ConfigurarPaginaDados()
609:         *-- OPERACIONAL: sem pagina de dados separada; grade gerenciada por ConfigurarGrade()
610:         RETURN .T.
611:     ENDPROC
612: 
613:     PROCEDURE AlternarPagina(par_nPagina)
614:         *-- OPERACIONAL: nao ha troca de pagina; apenas refresca a grade
615:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
616:             THIS.grd_4c_Selecoes.Refresh()
617:         ENDIF
618:     ENDPROC
619: 
620:     *==========================================================================
621:     PROCEDURE Destroy
622:     *==========================================================================
623:         IF USED("cursor_4c_Itn")
624:             USE IN cursor_4c_Itn
625:         ENDIF
626:         DODEFAULT()
627:     ENDPROC
628: 
629:     *==========================================================================
630:     * Handlers de eventos - PUBLIC (obrigatorio para BINDEVENT)
631:     *==========================================================================

*-- Linhas 645 a 711:
645:             ELSE
646:                 *-- GO TOP + refresh antes de verificar selecao (comportamento original)
647:                 GO TOP IN cursor_4c_Itn
648:                 IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
649:                     THIS.grd_4c_Selecoes.Refresh()
650:                 ENDIF
651: 
652:                 *-- Verificar se ha malas com registros selecionadas
653:                 SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
654:                     WHERE SelImp = 1 INTO CURSOR cursor_4c_TmpSel
655:                 loc_nSelecionadas = 0
656:                 IF USED("cursor_4c_TmpSel")
657:                     loc_nSelecionadas = NVL(cursor_4c_TmpSel.nSel, 0)
658:                     USE IN cursor_4c_TmpSel
659:                 ENDIF
660: 
661:                 IF loc_nSelecionadas < 1
662:                     MsgAviso("Nenhuma Mala Direta com registros foi selecionada para unifica" + ;
663:                              CHR(231) + CHR(227) + "o.", "Processar")
664:                     IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
665:                         THIS.grd_4c_Selecoes.SetFocus()
666:                     ENDIF
667:                 ELSE
668:                     IF loc_nSelecionadas = 1
669:                     MsgAviso("Apenas uma Mala Direta com registros foi selecionada." + CHR(13) + ;
670:                              "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel unificar apenas uma." + CHR(13) + ;
671:                              "Selecione ao menos duas Malas Diretas.", "Processar")
672:                     IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
673:                         THIS.grd_4c_Selecoes.SetFocus()
674:                     ENDIF
675:                 ELSE
676:                     IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
677:                         loc_cNome = ALLTRIM(THIS.cnt_4c_Nova.txt_4c_GetNova.Value)
678:                     ENDIF
679: 
680:                     IF EMPTY(loc_cNome)
681:                         MsgAviso("Nome da Unifica" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido." + CHR(13) + ;
682:                                  "Este " + CHR(233) + " o nome que ser" + CHR(225) + " utilizado na unifica" + ;
683:                                  CHR(231) + CHR(227) + "o gerada.", "Processar")
684:                         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
685:                             THIS.cnt_4c_Nova.txt_4c_GetNova.SetFocus()
686:                         ENDIF
687:                     ELSE
688:                         IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?")
689:                             loc_lOk = THIS.this_oBusinessObject.ProcessarUnificacao(loc_cNome)
690:                             IF loc_lOk
691:                                 THIS.MontarGrade()
692:                                 IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
693:                                     THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ""
694:                                 ENDIF
695:                                 IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
696:                                     THIS.grd_4c_Selecoes.SetFocus()
697:                                 ENDIF
698:                             ENDIF
699:                         ENDIF
700:                     ENDIF
701:                     ENDIF
702:                 ENDIF
703:             ENDIF
704: 
705:         CATCH TO loc_oErro
706:             MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
707:         ENDTRY
708: 
709:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
710:             THIS.cmd_4c_Processar.Enabled = .T.
711:         ENDIF

*-- Linhas 719 a 805:
719:         IF USED("cursor_4c_Itn")
720:             REPLACE ALL SelImp WITH 1 IN cursor_4c_Itn
721:         ENDIF
722:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
723:             THIS.grd_4c_Selecoes.Refresh()
724:         ENDIF
725:     ENDPROC
726: 
727:     PROCEDURE BtnDesmarcarTudoClick()
728:         IF USED("cursor_4c_Itn")
729:             REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
730:         ENDIF
731:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
732:             THIS.grd_4c_Selecoes.Refresh()
733:         ENDIF
734:     ENDPROC
735: 
736:     PROCEDURE Col2HeaderClick()
737:         THIS.OrdenarGrade(2)
738:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
739:             THIS.grd_4c_Selecoes.Refresh()
740:         ENDIF
741:     ENDPROC
742: 
743:     PROCEDURE Col3HeaderClick()
744:         THIS.OrdenarGrade(3)
745:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
746:             THIS.grd_4c_Selecoes.Refresh()
747:         ENDIF
748:     ENDPROC
749: 
750:     PROCEDURE Col4HeaderClick()
751:         THIS.OrdenarGrade(4)
752:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
753:             THIS.grd_4c_Selecoes.Refresh()
754:         ENDIF
755:     ENDPROC
756: 
757:     PROCEDURE Col5HeaderClick()
758:         THIS.OrdenarGrade(5)
759:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
760:             THIS.grd_4c_Selecoes.Refresh()
761:         ENDIF
762:     ENDPROC
763: 
764:     *-- MouseDown: toggle SelImp do registro corrente (equivale ao CheckBox original)
765:     PROCEDURE GrdChkMouseDown
766:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
767:         LOCAL loc_nSel
768:         IF USED("cursor_4c_Itn")
769:             loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
770:             SELECT cursor_4c_Itn
771:             REPLACE SelImp WITH loc_nSel
772:         ENDIF
773:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
774:             THIS.grd_4c_Selecoes.Refresh()
775:         ENDIF
776:         NODEFAULT
777:     ENDPROC
778: 
779:     *-- KeyPress: toggle SelImp com Enter (13) ou Space (32)
780:     PROCEDURE GrdChkKeyPress
781:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
782:         LOCAL loc_nSel
783:         IF INLIST(par_nKeyCode, 13, 32)
784:             IF USED("cursor_4c_Itn")
785:                 loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
786:                 SELECT cursor_4c_Itn
787:                 REPLACE SelImp WITH loc_nSel
788:             ENDIF
789:             IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
790:                 THIS.grd_4c_Selecoes.Refresh()
791:             ENDIF
792:             NODEFAULT
793:         ENDIF
794:     ENDPROC
795: 
796:     *-- Click: absorver para nao disparar duplo-toggle com MouseDown
797:     PROCEDURE GrdChkClick()
798:         NODEFAULT
799:     ENDPROC
800: 
801:     *==========================================================================
802:     * Contratos de pipeline ? nao aplicaveis a este form OPERACIONAL
803:     * (nao ha Page1=Lista/Page2=Dados nem botoes CRUD; acao principal = BtnProcessarClick)
804:     *==========================================================================
805:     PROCEDURE BtnIncluirClick()

*-- Linhas 882 a 901:
882:         IF USED("cursor_4c_Itn")
883:             REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
884:         ENDIF
885:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
886:             THIS.grd_4c_Selecoes.Refresh()
887:         ENDIF
888:     ENDPROC
889: 
890:     *==========================================================================
891:     * AjustarBotoesPorModo - sem modo CRUD neste form OPERACIONAL
892:     *==========================================================================
893:     PROTECTED PROCEDURE AjustarBotoesPorModo()
894:         *-- OPERACIONAL: habilita Processar somente se BO inicializado
895:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
896:             THIS.cmd_4c_Processar.Enabled = (VARTYPE(THIS.this_oBusinessObject) = "O")
897:         ENDIF
898:     ENDPROC
899: 
900:     *==========================================================================
901:     * BtnBuscarClick - recarrega a lista de malas diretas do servidor

