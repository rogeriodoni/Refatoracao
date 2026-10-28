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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCgr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1804 linhas total):

*-- Linhas 15 a 23:
15: *              Pedido+Numero - o usuario preenche APENAS um dos tres) +
16: *              botao Processar + o CommandGroup grp_operacao (Encerrar).
17: *   Pagina 2 = pag_resultado -> grade com o resultado da pesquisa
18: *              (Grd_Produto, 7 colunas) + Container1 (3 CheckBoxes que
19: *              escolhem a chave de rastreabilidade: Op/Envelope/Pedido) +
20: *              botao Rastreab. (Bot_Rastro) + o CommandGroup grp_operacao
21: *              (Voltar).
22: * Os metodos de configuracao de pagina mantem os nomes canonicos do
23: * pipeline (ConfigurarPaginaLista/ConfigurarPaginaDados) mesmo as paginas

*-- Linhas 40 a 49:
40: *
41: * FASE 4/8: Grade de resultado (grd_4c_Dados, ligada a
42: * this_oBusinessObject.this_cCursorResultado) e os botoes de acao:
43: * Page1 - CommandGroup cmg_4c_Operacao (Encerrar) + cmd_4c_Processar;
44: * Page2 - CommandGroup cmg_4c_Operacao (Voltar) + cmd_4c_Rastreab +
45: * Container1 (chk_4c_Op/chk_4c_Envelope/chk_4c_Pedido). Navegacao entre
46: * paginas (AlternarPagina) fica funcional; a consulta SQL dos criterios
47: * (Fase 7-8) depende dos campos de filtro das Fases 5-6.
48: *
49: * FASE 5/8 (PARTE 1/2): Campos do bloco "Dados para pesquisa" (Origem/

*-- Linhas 82 a 99:
82: * ProcessarPorEnvelope/ProcessarPorPedido/BuscarTopoPorOp/
83: * AppendPicagemPorOp/AppendResultado) + navegacao condicionada a haver
84: * linha no resultado (senao MsgAviso "Nenhum Registro Encontrado!!!") +
85: * sincronismo dos 3 CheckBoxes de Container1 (Page2), tudo incondicional
86: * apos o Processar() como no legado. AlternarPagina(2) agora tambem foca
87: * a 1a coluna da grade (equivalente ao ramo Else do pag_resultado.Activate
88: * legado, coberto pelo mesmo guard de ConsultaExecutada).
89: *
90: * Este form OPERACIONAL nao tem CRUD (eh dialogo de PESQUISA, sem Incluir/
91: * Alterar/Visualizar/Excluir no legado - ver "Decisao de projeto" no
92: * cabecalho de SigOpCgrBO.prg) - os eventos principais da Fase 7 sao os
93: * do fluxo real do dialogo (Processar/Encerrar/Voltar/Rastreab./
94: * CheckBoxes), ja implementados nas Fases 4-7.
95: *
96: * FASE 8/8: Eventos auxiliares e consolidacao final. Os metodos canonicos
97: * do pipeline ganham aqui o conteudo que o legado de fato tem, cada um
98: * transcrito de um trecho identificado do dump:
99: *

*-- Linhas 116 a 124:
116: *   FormParaBO() / BOParaForm() - transferencia dos 4 campos de filtro
117: *     (Op / Envelope / Pedido+Numero) entre a tela e o BO, nos dois
118: *     sentidos. Antes estava embutida em BtnProcessarClick; extraida
119: *     aqui, BOParaForm passa a ser tambem quem sincroniza os 3 CheckBoxes
120: *     de cnt_4c_ModoRastro (o "With This.Parent.Parent.pag_resultado.
121: *     Container1" do fim do cmdprocessar.Click legado) e as flags
122: *     this_lRastroPor* que BtnRastreabClick consulta.
123: *
124: *   LimparCampos() - o "With .fld_principal.pag_consulta.Origem.Pedido /

*-- Linhas 343 a 361:
343:         loc_oPgf = THIS.pgf_4c_Paginas
344: 
345:         loc_oPgf.PageCount = 2
346:         loc_oPgf.Top       = -29
347:         loc_oPgf.Left      = 0
348:         loc_oPgf.Width     = THIS.Width
349:         loc_oPgf.Height    = THIS.Height + 29
350:         loc_oPgf.TabIndex  = 1
351:         loc_oPgf.Tabs      = .F.
352: 
353:         loc_oPgf.Page1.Caption = "Consulta"
354:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
355: 
356:         loc_oPgf.Page2.Caption = "Resultado"
357:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
358: 
359:         loc_oPgf.Visible    = .T.
360:         loc_oPgf.ActivePage = 1
361:     ENDPROC

*-- Linhas 378 a 557:
378:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
379:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
380:         WITH loc_oCab
381:             .Top           = 29
382:             .Left          = 0
383:             .Width         = THIS.Width
384:             .Height        = 80
385:             .BorderWidth   = 0
386:             .SpecialEffect = 0
387:             .BackColor     = RGB(100, 100, 100)
388: 
389:             .AddObject("lbl_4c_Sombra", "Label")
390:             WITH .lbl_4c_Sombra
391:                 .Top       = 15
392:                 .Left      = 10
393:                 .Width     = THIS.Width
394:                 .Height    = 40
395:                 .FontName  = "Tahoma"
396:                 .FontSize  = 16
397:                 .FontBold  = .T.
398:                 .WordWrap  = .T.
399:                 .Alignment = 0
400:                 .BackStyle = 0
401:                 .ForeColor = RGB(0, 0, 0)
402:                 .Caption   = THIS.Caption
403:             ENDWITH
404: 
405:             .AddObject("lbl_4c_Titulo", "Label")
406:             WITH .lbl_4c_Titulo
407:                 .Top       = 18
408:                 .Left      = 10
409:                 .Width     = THIS.Width
410:                 .Height    = 46
411:                 .FontName  = "Tahoma"
412:                 .FontSize  = 16
413:                 .FontBold  = .T.
414:                 .WordWrap  = .T.
415:                 .Alignment = 0
416:                 .BackStyle = 0
417:                 .ForeColor = RGB(255, 255, 255)
418:                 .Caption   = THIS.Caption
419:             ENDWITH
420:         ENDWITH
421: 
422:         *-- Container "Dados para pesquisa" (Origem no legado, Top=201+29=230
423:         *-- apos compensacao do PageFrame.Top=-29 - regra CLAUDE.md #1/#11 -
424:         *-- bem acima do limite Top>=109 imposto pela faixa do cabecalho).
425:         *-- Centralizado horizontalmente no form 1000px (legado: Left=203 no
426:         *-- canvas 800px fica Left=203+(1000-800)/2=303 no canonico 1000px).
427:         loc_oPag.AddObject("cnt_4c_Origem", "Container")
428:         WITH loc_oPag.cnt_4c_Origem
429:             .Top         = 230
430:             .Left        = 303
431:             .Width       = 393
432:             .Height      = 129
433:             .BackStyle   = 0
434:             .BorderColor = RGB(90, 90, 90)
435: 
436:             .AddObject("lbl_4c__Origem1", "Label")
437:             WITH .lbl_4c__Origem1
438:                 .Top       = 5
439:                 .Left      = 6
440:                 .Width     = 119
441:                 .Height    = 15
442:                 .FontName  = "Tahoma"
443:                 .FontSize  = 8
444:                 .FontBold  = .T.
445:                 .Alignment = 0
446:                 .AutoSize  = .F.
447:                 .BackStyle = 0
448:                 .ForeColor = RGB(90, 90, 90)
449:                 .Caption   = "Dados para pesquisa"
450:             ENDWITH
451: 
452:             *-- Pedido (container interno do legado) - campos de filtro.
453:             *-- O usuario preenche APENAS um dos tres (Op OU Envelope OU
454:             *-- Pedido+Numero - guards When do legado, replicados nos
455:             *-- handlers de Valid/LostFocus da Fase 6). Fase 5 Parte 1 so
456:             *-- cria Op e Envelope; Pedido/Numero entram na Parte 2.
457:             .AddObject("cnt_4c_Pedido", "Container")
458:             WITH .cnt_4c_Pedido
459:                 .Top         = 33
460:                 .Left        = 22
461:                 .Width       = 348
462:                 .Height      = 72
463:                 .BackStyle   = 0
464:                 .BorderWidth = 0
465:                 .BorderColor = RGB(136, 189, 188)
466:                 .Visible     = .T.
467: 
468:                 *-- Get_Op do legado - "N. Op :" (numerico, this_nOps no BO)
469:                 .AddObject("lbl_4c_Label1", "Label")
470:                 WITH .lbl_4c_Label1
471:                     .Top       = 13
472:                     .Left      = 29
473:                     .Width     = 37
474:                     .Height    = 15
475:                     .FontName  = "Tahoma"
476:                     .FontSize  = 8
477:                     .Alignment = 0
478:                     .AutoSize  = .F.
479:                     .BackStyle = 0
480:                     .ForeColor = RGB(90, 90, 90)
481:                     .Caption   = "N. Op :"
482:                 ENDWITH
483: 
484:                 .AddObject("txt_4c_Op", "TextBox")
485:                 WITH .txt_4c_Op
486:                     .Top       = 9
487:                     .Left      = 68
488:                     .Width     = 85
489:                     .FontName  = "Tahoma"
490:                     .FontSize  = 8
491:                     .Alignment = 3
492:                     .Format    = "K"
493:                     .ForeColor = RGB(0, 0, 0)
494:                     .Value     = 0
495:                     .TabIndex  = 1
496:                 ENDWITH
497: 
498:                 *-- Get_Env do legado - "Envelope : " (numerico, this_nEnvs no BO)
499:                 .AddObject("lbl_4c_Label2", "Label")
500:                 WITH .lbl_4c_Label2
501:                     .Top       = 13
502:                     .Left      = 177
503:                     .Width     = 56
504:                     .Height    = 15
505:                     .FontName  = "Tahoma"
506:                     .FontSize  = 8
507:                     .Alignment = 0
508:                     .AutoSize  = .F.
509:                     .BackStyle = 0
510:                     .ForeColor = RGB(90, 90, 90)
511:                     .Caption   = "Envelope : "
512:                 ENDWITH
513: 
514:                 .AddObject("txt_4c_Env", "TextBox")
515:                 WITH .txt_4c_Env
516:                     .Top       = 9
517:                     .Left      = 235
518:                     .Width     = 85
519:                     .FontName  = "Tahoma"
520:                     .FontSize  = 8
521:                     .Alignment = 3
522:                     .Format    = "K"
523:                     .ForeColor = RGB(0, 0, 0)
524:                     .Value     = 0
525:                     .TabIndex  = 2
526:                 ENDWITH
527: 
528:                 *-- say_pedido do legado - "Pedido :" (linha 2 do container)
529:                 .AddObject("lbl_4c_Label3", "Label")
530:                 WITH .lbl_4c_Label3
531:                     .Top       = 43
532:                     .Left      = 25
533:                     .Width     = 41
534:                     .Height    = 15
535:                     .FontName  = "Tahoma"
536:                     .FontSize  = 8
537:                     .Alignment = 0
538:                     .AutoSize  = .F.
539:                     .BackStyle = 0
540:                     .ForeColor = RGB(90, 90, 90)
541:                     .Caption   = "Pedido :"
542:                 ENDWITH
543: 
544:                 *-- Get_Pedido do legado - codigo da operacao (this_cPedido
545:                 *-- no BO), com lookup contra cursor_4c_Operacoes (Fase 6).
546:                 *-- Junto com txt_4c_Numero compoe a chave EmpDopNums usada
547:                 *-- por Processar() na Fase 7/8 (regra CLAUDE.md #42 - chave
548:                 *-- posicional Emps(3)+Dopes(20)+Numero(6)).
549:                 .AddObject("txt_4c_Pedido", "TextBox")
550:                 WITH .txt_4c_Pedido
551:                     .Top       = 39
552:                     .Left      = 68
553:                     .Width     = 154
554:                     .Height    = 23
555:                     .FontName  = "Tahoma"
556:                     .FontSize  = 8
557:                     .Alignment = 3

*-- Linhas 566 a 575:
566:                 *-- operacao (this_nNumero no BO)
567:                 .AddObject("txt_4c_Numero", "TextBox")
568:                 WITH .txt_4c_Numero
569:                     .Top       = 39
570:                     .Left      = 225
571:                     .Width     = 55
572:                     .Height    = 23
573:                     .FontName  = "Tahoma"
574:                     .FontSize  = 8
575:                     .Alignment = 3

*-- Linhas 589 a 660:
589:         *-- 800px eles terminam em 803, 3px alem da borda).
590:         loc_oPag.AddObject("cnt_4c_Botoes", "Container")
591:         WITH loc_oPag.cnt_4c_Botoes
592:             .Top         = 29
593:             .Left        =  542
594:             .Width       = 160
595:             .Height      = 85
596:             .BackStyle   = 0
597:             .BorderWidth = 0
598:             .Visible     = .T.
599: 
600:             *-- cmdprocessar - standalone, fora de CommandGroup. Themes=.T.
601:             *-- + DisabledPicture: o botao nunca eh desabilitado nesta
602:             *-- tela, mas padrao canonico (regra CLAUDE.md #99) evita
603:             *-- icone sumir se algum dia precisar.
604:             .AddObject("cmd_4c_Processar", "CommandButton")
605:             WITH .cmd_4c_Processar
606:                 .Top             = 5
607:                 .Left            = 0
608:                 .Width           = 75
609:                 .Height          = 75
610:                 .FontName        = "Comic Sans MS"
611:                 .FontSize        = 8
612:                 .FontBold        = .T.
613:                 .FontItalic      = .T.
614:                 .WordWrap        = .T.
615:                 .ForeColor       = RGB(90, 90, 90)
616:                 .BackColor       = RGB(255, 255, 255)
617:                 .Themes          = .T.
618:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
619:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
620:                 .Caption         = "\<Processar"
621:             ENDWITH
622: 
623:             *-- grp_operacao (Page1) - 1 botao Encerrar
624:             .AddObject("cmg_4c_Operacao", "CommandGroup")
625:             WITH .cmg_4c_Operacao
626:                 .Top         = 0
627:                 .Left        = 75
628:                 .Width       = 85
629:                 .Height      = 85
630:                 .ButtonCount = 1
631:                 .BackStyle   = 0
632:                 .BorderStyle = 0
633:                 .Themes      = .F.
634:             ENDWITH
635: 
636:             WITH .cmg_4c_Operacao.Buttons(1)
637:                 .Top        = 5
638:                 .Left       = 5
639:                 .Width      = 75
640:                 .Height     = 75
641:                 .FontName   = "Comic Sans MS"
642:                 .FontSize   = 8
643:                 .FontBold   = .T.
644:                 .FontItalic = .T.
645:                 .WordWrap   = .T.
646:                 .Cancel     = .T.
647:                 .ForeColor  = RGB(90, 90, 90)
648:                 .BackColor  = RGB(255, 255, 255)
649:                 .Themes     = .F.
650:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
651:                 .Caption    = "Encerrar"
652:             ENDWITH
653:         ENDWITH
654: 
655:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Processar,          "Click", THIS, "BtnProcessarClick")
656:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnEncerrarClick")
657: 
658:         *-- Valid/When dos 3 filtros mutuamente exclusivos (Op OU Envelope OU
659:         *-- Pedido+Numero - regra CLAUDE.md #47: lookup/validacao em
660:         *-- LostFocus, nunca em KeyPress sem testar a tecla).

*-- Linhas 675 a 683:
675:     * ConfigurarPaginaDados - Estrutura da Page2 (Resultado)
676:     * Fase 3/8: so a faixa do cabecalho + container vazio para o botao
677:     * Rastreab. e o CommandGroup Voltar (Fase 4). A grade de resultado
678:     * (Grd_Produto) e o Container1 (CheckBoxes de modo de rastreabilidade)
679:     * vem na Fase 4.
680:     *==========================================================================
681:     PROTECTED PROCEDURE ConfigurarPaginaDados()
682:         LOCAL loc_oPag, loc_oCab
683: 

*-- Linhas 689 a 910:
689:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
690:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
691:         WITH loc_oCab
692:             .Top           = 29
693:             .Left          = 0
694:             .Width         = THIS.Width
695:             .Height        = 80
696:             .BorderWidth   = 0
697:             .SpecialEffect = 0
698:             .BackColor     = RGB(100, 100, 100)
699: 
700:             .AddObject("lbl_4c_Sombra", "Label")
701:             WITH .lbl_4c_Sombra
702:                 .Top       = 15
703:                 .Left      = 10
704:                 .Width     = THIS.Width
705:                 .Height    = 40
706:                 .FontName  = "Tahoma"
707:                 .FontSize  = 16
708:                 .FontBold  = .T.
709:                 .WordWrap  = .T.
710:                 .Alignment = 0
711:                 .BackStyle = 0
712:                 .ForeColor = RGB(0, 0, 0)
713:                 .Caption   = THIS.Caption
714:             ENDWITH
715: 
716:             .AddObject("lbl_4c_Titulo", "Label")
717:             WITH .lbl_4c_Titulo
718:                 .Top       = 18
719:                 .Left      = 10
720:                 .Width     = THIS.Width
721:                 .Height    = 46
722:                 .FontName  = "Tahoma"
723:                 .FontSize  = 16
724:                 .FontBold  = .T.
725:                 .WordWrap  = .T.
726:                 .Alignment = 0
727:                 .BackStyle = 0
728:                 .ForeColor = RGB(255, 255, 255)
729:                 .Caption   = THIS.Caption
730:             ENDWITH
731:         ENDWITH
732: 
733:         *-- Container com o botao Rastreab. (Bot_Rastro do legado,
734:         *-- Left=647/Top=4/Width=75/Height=75) + o CommandGroup grp_operacao
735:         *-- (1 botao Voltar, Left=717/Top=-1/Width=85/Height=85).
736:         loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
737:         WITH loc_oPag.cnt_4c_BotoesAcao
738:             .Top         = 29
739:             .Left        = 843
740:             .Width       = 160
741:             .Height      = 85
742:             .BackStyle   = 0
743:             .BorderWidth = 0
744:             .Visible     = .T.
745: 
746:             *-- Bot_Rastro - standalone, fora de CommandGroup. Enabled eh
747:             *-- alternado em runtime por AtualizarBotaoRastreab() (equivalente
748:             *-- ao When "Return Not Eof('dbProduto')" do legado) - por isso
749:             *-- Themes=.T. + DisabledPicture sao obrigatorios (regra #99),
750:             *-- senao o icone some quando o botao fica desabilitado.
751:             .AddObject("cmd_4c_Rastreab", "CommandButton")
752:             WITH .cmd_4c_Rastreab
753:                 .Top             = 5
754:                 .Left            = 0
755:                 .Width           = 75
756:                 .Height          = 75
757:                 .FontName        = "Comic Sans MS"
758:                 .FontSize        = 8
759:                 .FontBold        = .T.
760:                 .FontItalic      = .T.
761:                 .WordWrap        = .T.
762:                 .ForeColor       = RGB(90, 90, 90)
763:                 .BackColor       = RGB(255, 255, 255)
764:                 .Themes          = .T.
765:                 .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
766:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
767:                 .Caption         = "Rastreab."
768:                 .ToolTipText     = "Rastreabilidade"
769:                 .Enabled         = .F.
770:             ENDWITH
771: 
772:             *-- grp_operacao (Page2) - 1 botao Voltar
773:             .AddObject("cmg_4c_Operacao", "CommandGroup")
774:             WITH .cmg_4c_Operacao
775:                 .Top         = 0
776:                 .Left        = 75
777:                 .Width       = 85
778:                 .Height      = 85
779:                 .ButtonCount = 1
780:                 .BackStyle   = 0
781:                 .BorderStyle = 0
782:                 .Themes      = .F.
783:             ENDWITH
784: 
785:             WITH .cmg_4c_Operacao.Buttons(1)
786:                 .Top        = 5
787:                 .Left       = 5
788:                 .Width      = 75
789:                 .Height     = 75
790:                 .FontName   = "Comic Sans MS"
791:                 .FontSize   = 8
792:                 .FontBold   = .T.
793:                 .FontItalic = .T.
794:                 .WordWrap   = .T.
795:                 .Cancel     = .T.
796:                 .ForeColor  = RGB(90, 90, 90)
797:                 .BackColor  = RGB(255, 255, 255)
798:                 .Themes     = .F.
799:                 .Picture    = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
800:                 .Caption    = "Voltar"
801:             ENDWITH
802:         ENDWITH
803: 
804:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Rastreab,          "Click", THIS, "BtnRastreabClick")
805:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnVoltarClick")
806: 
807:         *-- Container1 do legado - "Pesquisar OP por" (3 CheckBoxes
808:         *-- mutuamente exclusivos que escolhem a chave usada por
809:         *-- Bot_Rastro.Click: Op/Envelope/Pedido). Top original=46 fica
810:         *-- MUITO perto do topo da pagina (regra do re-layout da faixa de
811:         *-- cabecalho, CLAUDE.md #11: controle de dados tem de ficar com
812:         *-- Top >= 115, nao so +29 - no legado esta pagina nao tinha
813:         *-- cabecalho nenhum, e agora tem). Deslocamento aplicado: +40
814:         *-- (Container1 46+29+40=115; Grd_Produto 150+29+40=219, cabe
815:         *-- dentro do form - ver grade abaixo).
816:         loc_oPag.AddObject("cnt_4c_ModoRastro", "Container")
817:         WITH loc_oPag.cnt_4c_ModoRastro
818:             .Top         = 115
819:             .Left        = 35
820:             .Width       = 168
821:             .Height      = 101
822:             .BackStyle   = 0
823:             .BorderColor = RGB(90, 90, 90)
824:             .BorderWidth = 1
825:             .SpecialEffect = 1
826: 
827:             .AddObject("lbl_4c_PesquisarPor", "Label")
828:             WITH .lbl_4c_PesquisarPor
829:                 .Top       = 4
830:                 .Left      = 3
831:                 .Width     = 97
832:                 .Height    = 15
833:                 .FontName  = "Tahoma"
834:                 .FontSize  = 8
835:                 .FontBold  = .T.
836:                 .BackStyle = 0
837:                 .ForeColor = RGB(90, 90, 90)
838:                 .Caption   = "Pesquisar OP por"
839:             ENDWITH
840: 
841:             .AddObject("chk_4c_Op", "CheckBox")
842:             WITH .chk_4c_Op
843:                 .Top       = 24
844:                 .Left      = 36
845:                 .Width     = 93
846:                 .Height    = 20
847:                 .FontName  = "Tahoma"
848:                 .FontSize  = 8
849:                 .Alignment = 0
850:                 .Style     = 1
851:                 .ForeColor = RGB(0, 0, 255)
852:                 .BackColor = RGB(255, 255, 255)
853:                 .Themes    = .F.
854:                 .Value     = 0
855:                 .Caption   = "Individual"
856:             ENDWITH
857: 
858:             .AddObject("chk_4c_Envelope", "CheckBox")
859:             WITH .chk_4c_Envelope
860:                 .Top       = 48
861:                 .Left      = 36
862:                 .Width     = 93
863:                 .Height    = 20
864:                 .FontName  = "Tahoma"
865:                 .FontSize  = 8
866:                 .Alignment = 0
867:                 .Style     = 1
868:                 .ForeColor = RGB(255, 0, 0)
869:                 .BackColor = RGB(255, 255, 255)
870:                 .Themes    = .F.
871:                 .Value     = 0
872:                 .Caption   = "Envelope"
873:             ENDWITH
874: 
875:             .AddObject("chk_4c_Pedido", "CheckBox")
876:             WITH .chk_4c_Pedido
877:                 .Top       = 72
878:                 .Left      = 36
879:                 .Width     = 93
880:                 .Height    = 20
881:                 .FontName  = "Tahoma"
882:                 .FontSize  = 8
883:                 .Alignment = 0
884:                 .Style     = 1
885:                 .ForeColor = RGB(0, 0, 128)
886:                 .BackColor = RGB(255, 255, 255)
887:                 .Themes    = .F.
888:                 .Value     = 0
889:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
890:             ENDWITH
891:         ENDWITH
892: 
893:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Op,       "Click", THIS, "ChkOpClick")
894:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Envelope, "Click", THIS, "ChkEnvelopeClick")
895:         BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Pedido,   "Click", THIS, "ChkPedidoClick")
896: 
897:         *-- Grd_Produto do legado - grade de resultado. ControlSource/
898:         *-- Header1.Caption/Width TRANSCRITOS do PROCEDURE Init legado (que
899:         *-- SOBRESCREVE os headers do dump estatico do SCX - regra "a pagina
900:         *-- segue o Init legado, nao o SCX desenhado"), nao do dump da
901:         *-- SECAO 2 (que tem Column6/7 com Header1.Caption = "Header1").
902:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
903:         WITH loc_oPag.grd_4c_Dados
904:             .Top           = 219
905:             .Left          = 35
906:             .Width         = 729
907:             .Height        = 400
908:             .FontName      = "Tahoma"
909:             .FontSize      = 8
910:             .ReadOnly      = .T.

*-- Linhas 977 a 1052:
977:                 .Movable           = .F.
978:                 .Resizable         = .F.
979:                 .Width             = 68
980:                 .Header1.Caption   = "Envelope"
981:                 .Header1.Alignment = 2
982:                 .Header1.FontSize  = 8
983:                 .Text1.FontSize    = 8
984:             ENDWITH
985: 
986:             WITH loc_oGrid.Column2
987:                 .FontSize          = 8
988:                 .Movable           = .F.
989:                 .Resizable         = .F.
990:                 .Width             = 68
991:                 .Header1.Caption   = "Op"
992:                 .Header1.Alignment = 2
993:                 .Header1.FontSize  = 8
994:                 .Text1.FontSize    = 8
995:             ENDWITH
996: 
997:             WITH loc_oGrid.Column3
998:                 .Alignment         = 2
999:                 .FontSize          = 8
1000:                 .Movable           = .F.
1001:                 .Resizable         = .F.
1002:                 .Width             = 182
1003:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1004:                 .Header1.Alignment = 2
1005:                 .Header1.FontSize  = 8
1006:                 .Text1.FontSize    = 8
1007:             ENDWITH
1008: 
1009:             WITH loc_oGrid.Column4
1010:                 .FontSize          = 8
1011:                 .Movable           = .F.
1012:                 .Resizable         = .F.
1013:                 .Width             = 108
1014:                 .Header1.Caption   = "Produto"
1015:                 .Header1.Alignment = 2
1016:                 .Header1.FontSize  = 8
1017:                 .Text1.FontSize    = 8
1018:             ENDWITH
1019: 
1020:             WITH loc_oGrid.Column5
1021:                 .FontSize          = 8
1022:                 .Movable           = .F.
1023:                 .Resizable         = .F.
1024:                 .Width             = 68
1025:                 .Header1.Caption   = "Qtde"
1026:                 .Header1.Alignment = 2
1027:                 .Header1.FontSize  = 8
1028:                 .Text1.FontSize    = 8
1029:             ENDWITH
1030: 
1031:             WITH loc_oGrid.Column6
1032:                 .FontSize          = 8
1033:                 .Movable           = .F.
1034:                 .Resizable         = .F.
1035:                 .Width             = 80
1036:                 .Header1.Caption   = "Fase"
1037:                 .Header1.Alignment = 2
1038:                 .Header1.FontSize  = 8
1039:                 .Text1.FontSize    = 8
1040:             ENDWITH
1041: 
1042:             WITH loc_oGrid.Column7
1043:                 .FontSize          = 8
1044:                 .Movable           = .F.
1045:                 .Resizable         = .F.
1046:                 .Width             = 80
1047:                 .Header1.Caption   = "Conta"
1048:                 .Header1.Alignment = 2
1049:                 .Header1.FontSize  = 8
1050:                 .Text1.FontSize    = 8
1051:             ENDWITH
1052: 

*-- Linhas 1110 a 1118:
1110:         loc_cCursor      = THIS.this_oBusinessObject.this_cCursorResultado
1111:         loc_lTemRegistro = USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1112: 
1113:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Rastreab.Enabled = loc_lTemRegistro
1114:     ENDPROC
1115: 
1116:     *==========================================================================
1117:     * BtnProcessarClick - botao "Processar" (Page1). Equivalente a
1118:     * cmdprocessar.Click do legado:

*-- Linhas 1125 a 1133:
1125:     *   3) ThisForm.Processa() -> THIS.this_oBusinessObject.Processar();
1126:     *   4) Not Eof('DbProduto') -> avanca para a Pagina Resultado, senao
1127:     *      MsgAviso("Nenhum Registro Encontrado!!!");
1128:     *   5) sincroniza os 3 CheckBoxes de Container1 (Page2) com o criterio
1129:     *      efetivamente usado - SEMPRE, dentro ou fora do bloco If/Else,
1130:     *      igual ao legado (o With final do Click roda incondicionalmente).
1131:     *==========================================================================
1132:     PROCEDURE BtnProcessarClick()
1133:         LOCAL loc_oPg, loc_lSucesso, loc_cCursor

*-- Linhas 1169 a 1177:
1169:         *-- "With This.Parent.Parent.pag_resultado.Container1" do fim do
1170:         *-- cmdprocessar.Click legado - roda SEMPRE depois do Processa,
1171:         *-- dentro ou fora do ramo "Not Eof('DbProduto')". Fase 8: os 3
1172:         *-- CheckBoxes e as flags this_lRastroPor* saem de BOParaForm, que
1173:         *-- le os MESMOS criterios que FormParaBO acabou de gravar no BO.
1174:         THIS.BOParaForm()
1175:     ENDPROC
1176: 
1177:     *==========================================================================

*-- Linhas 1393 a 1401:
1393: 
1394:     *==========================================================================
1395:     * ChkOp/Envelope/PedidoClick - Container1 do legado: os tres
1396:     * CheckBoxes sao mutuamente exclusivos (marcar um desmarca os outros
1397:     * dois) e definem a chave que Bot_Rastro.Click usa.
1398:     *==========================================================================
1399:     PROCEDURE ChkOpClick()
1400:         LOCAL loc_oCnt
1401:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro

*-- Linhas 1567 a 1582:
1567:     *==========================================================================
1568:     * BOParaForm - Sentido inverso de FormParaBO: escreve os criterios
1569:     * guardados no BO de volta nos 4 campos de filtro (Page1) e sincroniza
1570:     * os 3 CheckBoxes de cnt_4c_ModoRastro (Page2) com o criterio
1571:     * efetivamente usado - este segundo trecho eh o "With
1572:     * This.Parent.Parent.pag_resultado.Container1 / .Chk_op.Value =
1573:     * Iif(Empty(...Get_Op.Value), 0, 1) / ..." que fecha o
1574:     * cmdprocessar.Click legado.
1575:     *
1576:     * As flags this_lRastroPor* do BO sao derivadas no MESMO ponto, para
1577:     * nao divergirem dos CheckBoxes: BtnRastreabClick as consulta para
1578:     * escolher a chave (equivalente ao "If Chk_op.Value = 1" do
1579:     * Bot_Rastro.Click legado).
1580:     *
1581:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
1582:     * HERANCA (FormBase declara PROTECTED PROCEDURE BOParaForm) e nao da

*-- Linhas 1592 a 1603:
1592:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro
1593: 
1594:             WITH THIS.this_oBusinessObject
1595:                 loc_oPg.txt_4c_Op.Value     = .this_nOps
1596:                 loc_oPg.txt_4c_Env.Value    = .this_nEnvs
1597:                 loc_oPg.txt_4c_Pedido.Value = PADR(.this_cPedido, 20)
1598:                 loc_oPg.txt_4c_Numero.Value = .this_nNumero
1599: 
1600:                 *-- Iif(Empty(<campo>), 0, 1) do legado, campo a campo
1601:                 .this_lRastroPorOp      = !EMPTY(.this_nOps)
1602:                 .this_lRastroPorEnvelop = !EMPTY(.this_nEnvs)
1603:                 .this_lRastroPorPedido  = !EMPTY(.this_cPedido)

*-- Linhas 1676 a 1684:
1676:                     "Erro ao Limpar os Campos")
1677:         ENDTRY
1678: 
1679:         *-- BOParaForm zera tambem os 3 CheckBoxes de modo e as flags
1680:         *-- this_lRastroPor* (todos os criterios estao vazios agora).
1681:         THIS.BOParaForm()
1682:         THIS.HabilitarCampos(.T.)
1683:         THIS.CarregarLista()
1684:         THIS.AjustarBotoesPorModo()

*-- Linhas 1757 a 1765:
1757: 
1758:         loc_lNaConsulta = (THIS.pgf_4c_Paginas.ActivePage = 1)
1759: 
1760:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Processar.Enabled = loc_lNaConsulta
1761: 
1762:         THIS.HabilitarCampos(loc_lNaConsulta)
1763:         THIS.AtualizarBotaoRastreab()
1764:     ENDPROC
1765: 


### BO (C:\4c\projeto\app\classes\SigOpCgrBO.prg):
*------------------------------------------------------------------------------
* SigOpCgrBO - Business Object para FormSigOpCgr
* Dialogo operacional de "Pesquisa Global de Rastreabilidade": o usuario
* informa UM dos tres criterios (N. Op, Envelope ou Pedido/Numero), o BO
* monta a lista de produtos envolvidos naquele lote (tabela SigPdMvf,
* cruzada com a picagem de SigOpPic e a lista de operacoes de SigCdOpe) e
* o form exibe o resultado numa grade. A partir de uma linha do resultado,
* o usuario abre o relatorio SigReCgr (rastreabilidade) filtrado por
* Op/Envelope/Pedido, conforme o modo marcado.
* Migrado de: SIGOPCGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida (nao ha Inserir/
* Atualizar/Excluir no legado - e so consulta). A tabela "principal" para
* efeito de this_cTabela/this_cCampoChave e SigPdMvf, que e a fonte real
* do resultado (equivalente a dbProduto no legado); SigCdOpe e SigOpPic
* sao consultadas apenas como apoio (lista de operacoes e picagem).
*------------------------------------------------------------------------------
DEFINE CLASS SigOpCgrBO AS BusinessBase

    *-- Criterios de pesquisa (equivalentes aos Get_Op/Get_Env/Get_Pedido/
    *-- Get_Numero do dump legado - o usuario preenche APENAS um dos tres
    *-- grupos: Op, OU Envelope, OU Pedido+Numero)
    this_nOps    = 0
    this_nEnvs   = 0
    this_cPedido = ""
    this_nNumero = 0

    *-- Estado de controle (equivalente a ThisForm.ConsultaExecutada) -
    *-- evita reprocessar a mesma consulta enquanto nenhum criterio mudou
    this_lConsultaExecutada = .F.

    *-- Modo de rastreabilidade escolhido na pagina de resultado
    *-- (equivalente aos Chk_op/chk_Env/Chk_Dop do Container1 do legado -
    *-- define qual chave o Bot_Rastro.Click usa para abrir SigReCgr)
    this_lRastroPorOp      = .F.
    this_lRastroPorEnvelop = .F.
    this_lRastroPorPedido  = .F.

    *-- Linha corrente do resultado (equivalente ao registro atual de
    *-- dbProduto - usado pelo Bot_Rastro.Click e pelas colunas da grade)
    this_nSelNenvs   = 0
    this_nSelNops    = 0
    this_cSelDopNums = ""
    this_cSelCpros   = ""
    this_nSelQtds    = 0
    this_cSelGrupods = ""
    this_cSelContads = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao sigopagrBO/SigMvSbnBO)
    this_cCursorOperacoes = "cursor_4c_Operacoes" && equivalente a TmpOper (SigCdOpe) - lista de operacoes para o lookup do Pedido
    this_cCursorPicagem   = "cursor_4c_Picagem"   && equivalente a crSigOpPic (SigOpPic) - picagem por Op/Envelope/EmpDopNums
    this_cCursorMovimento = "cursor_4c_Movimento" && equivalente a crSigPdMvf (SigPdMvf) - lote/producao por Op ou por EmpDNps
    this_cCursorTopo      = "cursor_4c_Topo"      && equivalente a crTopMfas (SigPdMvf) - top 1 EmpDNps por envelope
    this_cCursorResultado = "cursor_4c_Resultado" && equivalente a dbProduto - grade de resultado exibida na pagina 2

    *-- Mensagem de erro do ultimo ValidarOperacao() (equivalente aos dois
    *-- MessageBox do Get_Op.Valid legado: "Op Nao Cadastrada!!!" / "Op de
    *-- Outra Empresa!!!") - o Form le esta property para exibir o MsgAviso.
    this_cMensagemErroOp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "Nops"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da linha CORRENTE do cursor de
    * resultado (equivalente ao registro atual de dbProduto no legado) para
    * as properties this_nSel*/this_cSel*. E chamado pelo form ao posicionar
    * o grid de resultado (AfterRowColChange da grade) e antes de
    * Bot_Rastro.Click, que precisa da linha selecionada para montar a
    * chave (Nops/Nenvs/DopNums) usada ao abrir SigReCgr.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelNenvs   = TratarNulo(Nenvs, 0)
            THIS.this_nSelNops    = TratarNulo(Nops, 0)
            THIS.this_cSelDopNums = TratarNulo(DopNums, "")
            THIS.this_cSelCpros   = TratarNulo(Cpros, "")
            THIS.this_nSelQtds    = TratarNulo(Qtds, 0)
            THIS.this_cSelGrupods = TratarNulo(Grupods, "")
            THIS.this_cSelContads = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula this_cCursorOperacoes (equivalente a TmpOper
    * do PROCEDURE Init legado: Select Dopes, NDopes, Globalizas, Reservas
    * From SigCdOpe Where Globalizas In (1, 2), Index On Dopes Tag Dopes).
    * Usado pelo lookup do campo Pedido (Fase 6): SEEK contra o cursor local
    * + picker FormBuscaAuxiliar.DefinirCursor/Mostrar (Pattern A - regra
    * "FormBuscaAuxiliar Pattern B broken") sobre este MESMO cursor, sem
    * nova consulta SQL - igual ao fwBuscaSel legado, que tambem trabalha
    * em cima do cursor ja carregado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorOperacoes

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        *-- Modo teste/validacao de UI: sem conexao real de SQL Server -
        *-- SQLEXEC com handle invalido DISPARA excecao (nao devolve -1),
        *-- entao criar o cursor vazio com a MESMA estrutura do TmpOper
        *-- legado, para o SEEK do lookup de Pedido nao estourar "Alias
        *-- CURSOR_4C_OPERACOES is not found".
        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            CREATE CURSOR (loc_cCursor) ;
                (Dopes C(20), NDopes N(4, 0), Globalizas N(1, 0), Reservas N(1, 0))
            INDEX ON Dopes TAG Dopes
            RETURN .T.
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas " + ;
                   "FROM SigCdOpe WHERE Globalizas IN (1, 2)"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado >= 0 AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            INDEX ON Dopes TAG Dopes
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Confere se a Op existe em SigOpPic e pertence a
    * empresa corrente (equivalente ao Get_Op.Valid legado: CursorQuery +
    * Eof('crSigOpPic') + crSigOpPic.Emps <> _Empr). Preenche
    * this_cMensagemErroOp quando invalido, para o Form exibir o MsgAviso.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao(par_nOps)
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErroOp = ""
        loc_cCursor = "cursor_4c_ValOp"

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Emps FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado > 0 AND USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            IF ALLTRIM(Emps) == ALLTRIM(go_4c_Sistema.cCodEmpresa)
                loc_lValido = .T.
            ELSE
                THIS.this_cMensagemErroOp = "Op de Outra Empresa!!!"
            ENDIF
        ELSE
            THIS.this_cMensagemErroOp = "Op N" + CHR(227) + "o Cadastrada!!!"
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - equivalente ao PROCEDURE processa do legado: monta o
    * resultado da pesquisa (this_cCursorResultado) a partir de QUAL dos
    * tres criterios foi preenchido (Op, Envelope ou Pedido+Numero). O
    * guard "If Not Thisform.ConsultaExecutada" do legado fica aqui dentro
    * (nao reprocessa enquanto nenhum criterio mudou - os handlers de
    * LostFocus dos filtros resetam this_lConsultaExecutada no Form).
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_cCursorResultado, loc_lSucesso

        loc_lSucesso          = .T.
        loc_cCursorResultado  = THIS.this_cCursorResultado

        IF !THIS.this_lConsultaExecutada
            *-[ Limpa os Arquivos ]-* (equivalente a "Select DbProduto / Zap")
            IF USED(loc_cCursorResultado)
                SELECT (loc_cCursorResultado)
                ZAP
            ENDIF

            DO CASE
                CASE THIS.this_nOps != 0
                    loc_lSucesso = THIS.ProcessarPorOp()
                CASE THIS.this_nEnvs > 0
                    loc_lSucesso = THIS.ProcessarPorEnvelope()
                OTHERWISE
                    loc_lSucesso = THIS.ProcessarPorPedido()
            ENDCASE

            IF loc_lSucesso
                THIS.this_lConsultaExecutada = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPorOp - ramo "If (lnOp <> 0)" do legado: pesquisa a picagem
    * (SigOpPic) da Op informada e, para cada linha, busca o topo de
    * producao (SigPdMvf) correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorOp()
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso   = .T.
        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(THIS.this_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        *-- Snapshot em array ANTES de fechar o cursor: BuscarTopoPorOp faz
        *-- SQLEXEC/SELECT proprios, e um SCAN direto neste cursor perderia
        *-- a posicao corrente quando a funcao chamada troca de workarea.
        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(THIS.this_nOps, loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "1")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorEnvelope - ramo "If (lnEnv > 0)" do legado: acha o topo
    * de EmpDNps do envelope informado, pesquisa TODAS as linhas de
    * SigPdMvf daquele EmpDNps e, para cada uma, busca a picagem (SigOpPic)
    * da Op correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorEnvelope()
        LOCAL loc_cCursorTopo, loc_cSQL, loc_nResultado, loc_cChave, loc_lSucesso
        LOCAL loc_cCursorMvf, loc_nTotal, loc_nI
        LOCAL loc_aNops[1], loc_aNenvs[1], loc_aCodPds[1], loc_aGrupods[1], loc_aContads[1]

        loc_lSucesso    = .T.
        loc_cCursorTopo = THIS.this_cCursorTopo

        IF USED(loc_cCursorTopo)
            USE IN (loc_cCursorTopo)
        ENDIF

        loc_cSQL = "SELECT TOP 1 EmpDNps FROM SigPdMvf " + ;
                   "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nEnvs, 0) + " " + ;
                   "ORDER BY Nenvs DESC, EmpDNps DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTopo)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crTopMfas)")
            RETURN .F.
        ENDIF

        *-- legado: "If Not Eof()" - sem registro, nao eh erro, simplesmente
        *-- nao ha nada para acrescentar ao resultado.
        IF !USED(loc_cCursorTopo) OR EOF(loc_cCursorTopo)
            IF USED(loc_cCursorTopo)
                USE IN (loc_cCursorTopo)
            ENDIF
            RETURN .T.
        ENDIF

        SELECT (loc_cCursorTopo)
        GO TOP
        loc_cChave = EmpDNps
        USE IN (loc_cCursorTopo)

        loc_cCursorMvf = THIS.this_cCursorMovimento
        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps " + ;
                   "FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cChave) + " " + ;
                   "ORDER BY Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf 2)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorMvf)
            loc_nTotal = RECCOUNT(loc_cCursorMvf)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aNenvs[loc_nTotal]
            DIMENSION loc_aCodPds[loc_nTotal]
            DIMENSION loc_aGrupods[loc_nTotal]
            DIMENSION loc_aContads[loc_nTotal]

            SELECT (loc_cCursorMvf)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]    = Nops
                loc_aNenvs[loc_nI]   = Nenvs
                loc_aCodPds[loc_nI]  = CodPds
                loc_aGrupods[loc_nI] = Grupods
                loc_aContads[loc_nI] = Contads
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.AppendPicagemPorOp(loc_aNops[loc_nI], loc_aNenvs[loc_nI], ;
                    loc_aCodPds[loc_nI], loc_aGrupods[loc_nI], loc_aContads[loc_nI])
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorPedido - ramo "Else" (nem Op nem Envelope) do legado:
    * monta a chave posicional EmpDopNums (Emps(3)+Dopes(20)+Numero(6) =
    * 29 = SigOpPic.EmpDopNums char(29) - regra CLAUDE.md #42) e pesquisa
    * a picagem direto por ela.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorPedido()
        LOCAL loc_cEDN, loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aNops[1], loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso = .T.

        *-- Chave POSICIONAL - PADR explicito nas DUAS partes de largura
        *-- fixa (nunca ALLTRIM, regra CLAUDE.md #42), independente do
        *-- padding que txt_4c_Pedido.Value tenha trazido.
        loc_cEDN = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                   PADR(THIS.this_cPedido, 20) + ;
                   STR(THIS.this_nNumero, 6)

        loc_cCursorPic = THIS.this_cCursorPicagem
        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Nops, Dopes, Numes, Qtds FROM SigOpPic " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEDN)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]  = Nops
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(loc_aNops[loc_nI], loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "3")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTopoPorOp - equivalente ao "Select Top 1 Nops, Nenvs, CodPds,
    * Grupods, Contads From SigPdMvf Where Nops = ... Order By ... Desc"
    * repetido nos ramos Op e Pedido do legado. par_cContexto reproduz o
    * numero do MessageBox de falha original (crSigPdMvf 1 / 3).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarTopoPorOp(par_nOps, par_cDopes, par_nNumes, par_nQtds, par_cContexto)
        LOCAL loc_cCursorMvf, loc_cSQL, loc_nResultado
        LOCAL loc_nNenvs, loc_cCodPds, loc_cGrupods, loc_cContads

        loc_cCursorMvf = THIS.this_cCursorMovimento

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Nops, Nenvs, CodPds, Grupods, Contads " + ;
                   "FROM SigPdMvf " + ;
                   "WHERE Nops = " + FormatarNumeroSQL(par_nOps, 0) + " " + ;
                   "ORDER BY Nops DESC, Nenvs DESC, CodPds DESC, Grupods DESC, Contads DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0 OR !USED(loc_cCursorMvf) OR EOF(loc_cCursorMvf)
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf " + par_cContexto + ")")
            IF USED(loc_cCursorMvf)
                USE IN (loc_cCursorMvf)
            ENDIF
            RETURN .F.
        ENDIF

        SELECT (loc_cCursorMvf)
        GO TOP
        loc_nNenvs   = Nenvs
        loc_cCodPds  = CodPds
        loc_cGrupods = Grupods
        loc_cContads = Contads

        USE IN (loc_cCursorMvf)

        THIS.AppendResultado(loc_nNenvs, par_nOps, ;
            par_cDopes + STR(par_nNumes, 6), loc_cCodPds, par_nQtds, loc_cGrupods, loc_cContads)

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendPicagemPorOp - equivalente ao bloco interno do ramo Envelope do
    * legado: "ThisForm.poDataMgr.CursorQuery('SigOpPic', ..., 'Nops', ...)
    * / Scan / Append Blank" - pesquisa a picagem da Op da linha de
    * SigPdMvf corrente e acrescenta UMA linha de resultado por cada linha
    * de picagem encontrada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AppendPicagemPorOp(par_nNops, par_nNenvs, par_cCodPds, par_cGrupods, par_cContads)
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nNops, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            IF USED(loc_cCursorPic)
                USE IN (loc_cCursorPic)
            ENDIF
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            THIS.AppendResultado(par_nNenvs, par_nNops, ;
                loc_aDopes[loc_nI] + STR(loc_aNumes[loc_nI], 6), ;
                par_cCodPds, loc_aQtds[loc_nI], par_cGrupods, par_cContads)
        ENDFOR

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendResultado - equivalente a "Select DbProduto / Append Blank /
    * Replace ..." do legado. Unico ponto de escrita em
    * this_cCursorResultado, usado pelos tres ramos de Processar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AppendResultado(par_nNenvs, par_nNops, par_cDopNums, par_cCpros, par_nQtds, par_cGrupods, par_cContads)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorResultado

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        APPEND BLANK
        REPLACE Nenvs   WITH TratarNulo(par_nNenvs, 0), ;
                Nops    WITH TratarNulo(par_nNops, 0), ;
                DopNums WITH TratarNulo(par_cDopNums, ""), ;
                Cpros   WITH TratarNulo(par_cCpros, ""), ;
                Qtds    WITH TratarNulo(par_nQtds, 0), ;
                Grupods WITH TratarNulo(par_cGrupods, ""), ;
                Contads WITH TratarNulo(par_cContads, "")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave que identifica a linha corrente do
    * resultado (nao existe PK de tabela gravavel neste dialogo - ver
    * decisao de projeto abaixo). Usa Nops, o mesmo campo definido como
    * this_cCampoChave no Init, igual ao padrao dos demais BOs.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nSelNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPCGR legado e um dialogo de PESQUISA (Pesquisa Global de
    * Rastreabilidade): o unico Create Cursor do Init e dbProduto, que e
    * um cursor LOCAL (nunca gravado no SQL Server), e todo Insert
    * Into/Replace do codigo fonte original tem como alvo esse mesmo
    * cursor local. Nao ha TableUpdate nem AddCursor contra tabela remota
    * em lugar nenhum do dump - as unicas chamadas SqlExecute/CursorQuery
    * do Processa()/Init() sao SELECTs de leitura (SigPdMvf, SigOpPic,
    * SigCdOpe). Por isso este BO nao sobrescreve Inserir(), Atualizar()
    * nem ExecutarExclusao(): o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto para uma tela que
    * so consulta. CarregarDoCursor() acima e o unico ponto de leitura de
    * linha que este BO precisa, pois alimenta a selecao usada por
    * Bot_Rastro.Click; RegistrarAuditoria() herdado de BusinessBase
    * tambem nao e chamado, porque nao ha Inserir/Atualizar/Excluir que o
    * dispare.
    *--------------------------------------------------------------------------

ENDDEFINE

