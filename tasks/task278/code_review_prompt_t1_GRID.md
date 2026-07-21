# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 463: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg) - TRECHOS RELEVANTES PARA PASS GRID (782 linhas total):

*-- Linhas 94 a 112:
94:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
95:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
96: 
97:                     THIS.grd_4c_Dados.Refresh()
98:                     loc_lSucesso = .T.
99:                 ENDIF
100:             ENDIF
101:         CATCH TO loc_oErro
102:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
103:                     "Erro FormSigPrEml.InicializarForm")
104:         ENDTRY
105: 
106:         RETURN loc_lSucesso
107:     ENDPROC
108: 
109:     *==========================================================================
110:     PROTECTED PROCEDURE ConfigurarPageFrame
111:     *==========================================================================
112:         THIS.Picture      = gc_4c_CaminhoIcones + "new_background.jpg"

*-- Linhas 132 a 150:
132:     * ConfigurarPaginaDados - Area de trabalho (grid + botoes de selecao)
133:     *--------------------------------------------------------------------------
134:     * Equivale a "Page2 (Dados)" dos forms CRUD. Neste form plano monta a
135:     * grade principal (grd_4c_Dados exibindo cursor_4c_Total) e os botoes
136:     * auxiliares cmd_4c_SelTudo/cmd_4c_Apaga que operam sobre o cursor de
137:     * destinatarios.
138:     *==========================================================================
139:     PROTECTED PROCEDURE ConfigurarPaginaDados()
140:         THIS.ConfigurarGrade()
141:         THIS.ConfigurarSelecaoBotoes()
142:     ENDPROC
143: 
144:     *==========================================================================
145:     * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
146:     *--------------------------------------------------------------------------
147:     * Metodo mantido para atender contrato arquitetural do pipeline (Fase 4).
148:     * Forms OPERACIONAIS como SIGPREML nao possuem PageFrame Lista/Dados:
149:     * o layout completo eh persistente (cabecalho + grid + botoes de acao) e a
150:     * interacao acontece via botoes flutuantes sobre o grid. O parametro eh

*-- Linhas 312 a 357:
312:     *==========================================================================
313:     PROTECTED PROCEDURE ConfigurarGrade
314:     *==========================================================================
315:         THIS.AddObject("grd_4c_Dados", "Grid")
316:         WITH THIS.grd_4c_Dados
317:             .Top                  = 132
318:             .Left                 = 3
319:             .Width                = 993
320:             .Height               = 435
321:             .RecordMark           = .F.
322:             .DeleteMark           = .F.
323:             .RowHeight            = 18
324:             .FontName             = "Verdana"
325:             .FontSize             = 8
326:             .ForeColor            = RGB(90, 90, 90)
327:             .BackColor            = RGB(255, 255, 255)
328:             .GridLineColor        = RGB(238, 238, 238)
329:             .HighlightStyle       = 2
330:             .HighlightBackColor   = RGB(255, 255, 255)
331:             .HighlightForeColor   = RGB(15, 41, 104)
332:             .AllowAutoColumnFit   = 2
333:             .GridLines            = 2
334:             .ColumnCount          = 5
335: 
336:             *-- Column1: Checkbox Checks (ColumnOrder=1 exibido a esquerda)
337:             *-- Ordem obrigatoria: AddObject -> CurrentControl -> Sparse -> ControlSource (Erro 1767)
338:             WITH .Column1
339:                 .ColumnOrder   = 1
340:                 .Width         = 17
341:                 .ReadOnly      = .F.
342:                 WITH .Header1
343:                     .Caption  = ""
344:                     .FontName = "Verdana"
345:                     .FontSize = 8
346:                 ENDWITH
347:                 .AddObject("ctlCheckbox", "CheckBox")
348:                 WITH .ctlCheckbox
349:                     .Caption   = ""
350:                     .Alignment = 0
351:                     .FontName  = "Verdana"
352:                     .FontSize  = 8
353:                     .Value     = 0
354:                 ENDWITH
355:                 .CurrentControl = "ctlCheckbox"
356:                 .Sparse        = .F.
357:                 .ControlSource = "cursor_4c_Total.Checks"

*-- Linhas 363 a 381:
363:                 .Width         = 80
364:                 .ReadOnly      = .T.
365:                 .ControlSource = "cursor_4c_Total.Contas"
366:                 WITH .Header1
367:                     .Caption   = " Conta"
368:                     .Alignment = 2
369:                     .FontName  = "Verdana"
370:                     .FontSize  = 8
371:                     .BackColor = RGB(192, 192, 192)
372:                 ENDWITH
373:                 .AddObject("ctlText", "TextBox")
374:                 WITH .ctlText
375:                     .BorderStyle = 0
376:                     .Margin      = 0
377:                     .ReadOnly    = .T.
378:                     .ForeColor   = RGB(0, 0, 0)
379:                     .BackColor   = RGB(255, 255, 255)
380:                     .FontName    = "Verdana"
381:                     .FontSize    = 8

*-- Linhas 389 a 407:
389:                 .Width         = 290
390:                 .ReadOnly      = .T.
391:                 .ControlSource = "cursor_4c_Total.Rclis"
392:                 WITH .Header1
393:                     .Caption   = " Nome"
394:                     .Alignment = 2
395:                     .FontName  = "Verdana"
396:                     .FontSize  = 8
397:                     .BackColor = RGB(64, 128, 128)
398:                 ENDWITH
399:                 .AddObject("ctlText", "TextBox")
400:                 WITH .ctlText
401:                     .BorderStyle = 0
402:                     .Margin      = 0
403:                     .ReadOnly    = .T.
404:                     .ForeColor   = RGB(0, 0, 0)
405:                     .BackColor   = RGB(255, 255, 255)
406:                     .FontName    = "Verdana"
407:                     .FontSize    = 8

*-- Linhas 415 a 433:
415:                 .Width         = 290
416:                 .ReadOnly      = .F.
417:                 .ControlSource = "cursor_4c_Total.emails"
418:                 WITH .Header1
419:                     .Caption   = "Email"
420:                     .Alignment = 2
421:                     .FontName  = "Verdana"
422:                     .FontSize  = 8
423:                     .BackColor = RGB(192, 192, 192)
424:                 ENDWITH
425:                 .AddObject("ctlText", "TextBox")
426:                 WITH .ctlText
427:                     .BorderStyle = 0
428:                     .Margin      = 0
429:                     .ReadOnly    = .F.
430:                     .ForeColor   = RGB(0, 0, 0)
431:                     .BackColor   = RGB(255, 255, 255)
432:                     .FontName    = "Verdana"
433:                     .FontSize    = 8

*-- Linhas 442 a 497:
442:                 .ReadOnly      = .T.
443:                 .Sparse        = .F.
444:                 .ControlSource = "cursor_4c_Total.mensagems"
445:                 WITH .Header1
446:                     .Caption   = "Mensagem"
447:                     .Alignment = 2
448:                     .FontName  = "Verdana"
449:                     .FontSize  = 8
450:                 ENDWITH
451:                 .AddObject("ctlEditBox", "EditBox")
452:                 WITH .ctlEditBox
453:                     .BorderStyle   = 0
454:                     .ReadOnly      = .T.
455:                     .SpecialEffect = 1
456:                     .FontName      = "Verdana"
457:                     .FontSize      = 8
458:                 ENDWITH
459:                 .CurrentControl = "ctlEditBox"
460:             ENDWITH
461: 
462:             *-- Ativar RecordSource por ultimo para evitar auto-binding prematuro
463:             .RecordSource = "cursor_4c_Total"
464:         ENDWITH
465:     ENDPROC
466: 
467:     *==========================================================================
468:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
469:     *==========================================================================
470:         *-- Botoes de acao
471:         BINDEVENT(THIS.cmd_4c_BtnEmail,               "Click", THIS, "BtnEmailClick")
472:         BINDEVENT(THIS.cmd_4c_SelTudo,                "Click", THIS, "SelTudoClick")
473:         BINDEVENT(THIS.cmd_4c_Apaga,                  "Click", THIS, "ApagaClick")
474:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")
475: 
476:         *-- Cliques nos cabecalhos para ordenacao (Conta, Nome, Email)
477:         BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "Col2HeaderClick")
478:         BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "Col3HeaderClick")
479:         BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "Col4HeaderClick")
480: 
481:         *-- Checkbox individual para marcar/desmarcar linha
482:         BINDEVENT(THIS.grd_4c_Dados.Column1.ctlCheckbox, "InteractiveChange", ;
483:                   THIS, "GrdChkInteractiveChange")
484:     ENDPROC
485: 
486:     *==========================================================================
487:     * TornarControlesVisiveis - Form plano (sem PageFrame); nao ha containers
488:     * que devam permanecer ocultos, entao todos os controles ficam visiveis.
489:     *==========================================================================
490:     PROTECTED PROCEDURE TornarControlesVisiveis()
491:         LOCAL loc_i, loc_oControl
492:         FOR loc_i = 1 TO THIS.ControlCount
493:             loc_oControl = THIS.Controls(loc_i)
494:             IF VARTYPE(loc_oControl) = "O"
495:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
496:                     loc_oControl.Visible = .T.
497:                 ENDIF

*-- Linhas 538 a 606:
538:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
539:             THIS.this_oBusinessObject.MarcarTodos()
540:         ENDIF
541:         THIS.grd_4c_Dados.Refresh()
542:     ENDPROC
543: 
544:     PROCEDURE ApagaClick()
545:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
546:             THIS.this_oBusinessObject.DesmarcarTodos()
547:         ENDIF
548:         THIS.grd_4c_Dados.Refresh()
549:     ENDPROC
550: 
551:     PROCEDURE EncerrarClick()
552:         THIS.Release()
553:     ENDPROC
554: 
555:     PROCEDURE Col2HeaderClick()
556:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
557:             THIS.this_oBusinessObject.OrdenarPorColuna("Contas")
558:         ENDIF
559:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
560:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
561:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
562:         THIS.grd_4c_Dados.Refresh()
563:     ENDPROC
564: 
565:     PROCEDURE Col3HeaderClick()
566:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
567:             THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
568:         ENDIF
569:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
570:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
571:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
572:         THIS.grd_4c_Dados.Refresh()
573:     ENDPROC
574: 
575:     PROCEDURE Col4HeaderClick()
576:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
577:             THIS.this_oBusinessObject.OrdenarPorColuna("Emails")
578:         ENDIF
579:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
580:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
581:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
582:         THIS.grd_4c_Dados.Refresh()
583:     ENDPROC
584: 
585:     PROCEDURE GrdChkInteractiveChange()
586:         LOCAL loc_nValue
587:         IF USED("cursor_4c_Total")
588:             loc_nValue = THIS.grd_4c_Dados.Column1.ctlCheckbox.Value
589:             REPLACE Checks WITH loc_nValue IN cursor_4c_Total
590:         ENDIF
591:         THIS.grd_4c_Dados.Refresh()
592:     ENDPROC
593: 
594:     *==========================================================================
595:     * Eventos CRUD - Contrato arquitetural do pipeline (Fase 7)
596:     *--------------------------------------------------------------------------
597:     * SIGPREML eh form OPERACIONAL de envio de alertas por email; nao ha
598:     * botoes CRUD (Incluir/Alterar/Excluir/Visualizar) na tela original. Os
599:     * handlers abaixo existem para atender o contrato de validacao do
600:     * pipeline e delegam para as acoes operacionais reais deste form. O
601:     * parametro cEscolha ("INSERIR"/"ALTERAR"/"EXCLUIR") recebido no Init
602:     * descreve o contexto que originou o alerta, nao gera botoes locais.
603:     *==========================================================================
604: 
605:     *--------------------------------------------------------------------------
606:     * BtnIncluirClick - Contexto INSERIR do alerta -> disparar envio de email

*-- Linhas 627 a 672:
627:             SELECT cursor_4c_Total
628:             GO TOP
629:         ENDIF
630:         THIS.grd_4c_Dados.SetFocus()
631:         THIS.grd_4c_Dados.Refresh()
632:     ENDPROC
633: 
634:     *--------------------------------------------------------------------------
635:     * BtnExcluirClick - Contexto EXCLUIR do alerta: no fluxo operacional
636:     * equivale a limpar selecao (desmarcar destinatarios) via BO.
637:     *--------------------------------------------------------------------------
638:     PROCEDURE BtnExcluirClick()
639:         THIS.this_cEscolha = "EXCLUIR"
640:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
641:             THIS.this_oBusinessObject.DesmarcarTodos()
642:         ENDIF
643:         THIS.grd_4c_Dados.Refresh()
644:     ENDPROC
645: 
646:     *==========================================================================
647:     * BtnBuscarClick - Form OPERACIONAL: sem busca interativa
648:     *--------------------------------------------------------------------------
649:     * SIGPREML carrega destinatarios no Init via parametros recebidos.
650:     * "Buscar" equivale a reposicionar o grid no primeiro registro.
651:     *==========================================================================
652:     PROCEDURE BtnBuscarClick()
653:         IF USED("cursor_4c_Total")
654:             SELECT cursor_4c_Total
655:             GO TOP
656:         ENDIF
657:         THIS.grd_4c_Dados.Refresh()
658:     ENDPROC
659: 
660:     *==========================================================================
661:     * BtnEncerrarClick - Alias de EncerrarClick (contrato arquitetural pipeline)
662:     *==========================================================================
663:     PROCEDURE BtnEncerrarClick()
664:         THIS.EncerrarClick()
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * BtnSalvarClick - Form OPERACIONAL: "salvar" = enviar email
669:     *--------------------------------------------------------------------------
670:     * Nao ha operacao de salvar no sentido CRUD. O equivalente operacional
671:     * e o envio dos emails (BtnEmailClick), que registra o alerta em SigAlert
672:     * e fecha o form.

*-- Linhas 728 a 765:
728:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
729:             THIS.this_oBusinessObject.DesmarcarTodos()
730:         ENDIF
731:         THIS.grd_4c_Dados.Refresh()
732:     ENDPROC
733: 
734:     *==========================================================================
735:     * CarregarLista - Reposiciona e atualiza exibicao do grid de destinatarios
736:     *--------------------------------------------------------------------------
737:     * Form OPERACIONAL: o cursor_4c_Total ja esta populado pelo CarregarDados
738:     * do BO chamado no InicializarForm. CarregarLista reposiciona o ponteiro
739:     * e atualiza o grid sem re-executar SQL.
740:     *==========================================================================
741:     PROCEDURE CarregarLista()
742:         LOCAL loc_lSucesso, loc_oErro
743: 
744:         loc_lSucesso = .F.
745: 
746:         TRY
747:             IF USED("cursor_4c_Total")
748:                 SELECT cursor_4c_Total
749:                 GO TOP
750:                 THIS.grd_4c_Dados.Refresh()
751:                 loc_lSucesso = .T.
752:             ENDIF
753:         CATCH TO loc_oErro
754:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
755:                     "Erro FormSigPrEml.CarregarLista")
756:         ENDTRY
757: 
758:         RETURN loc_lSucesso
759:     ENDPROC
760: 
761:     *==========================================================================
762:     * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD a ajustar
763:     *--------------------------------------------------------------------------
764:     * SIGPREML tem um unico modo de operacao: exibir destinatarios e enviar
765:     * email. Nao ha alternancia de modos (LISTA/DADOS/INCLUIR/ALTERAR/

