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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2194 linhas total):

*-- Linhas 44 a 88:
44: * Fase 1/8 - sigopsepBO.prg: propriedades de filtro + Init.
45: * Fase 2/8 - sigopsepBO.prg: BuscarLinhas/MarcarTodasLinhas/BuscarProdutos/
46: *            MarcarTodosProdutos/ObterProdutosParaCopia/LimparCursores.
47: * Fase 3/8 - estrutura base do Form: DEFINE CLASS + propriedades visuais do
48: *            dump, Init completo (contexto do pai + BO + InicializarForm),
49: *            cabecalho cinza (cntSombra -> cnt_4c_Sombra) e Destroy.
50: *
51: * Fase 4/8 (ESTA FASE) - as DUAS grades do dialogo e os botoes de acao:
52: *   - cnt_4c_Filtro (CrtFiltro): campos de filtro + grd_4c_Linhas
53: *     (GradeLinhas) + cmd_4c_Marcar/cmd_4c_Desmarcar
54: *   - grd_4c_Itens (GradeItens, direto na Form, 6 colunas)
55: *   - botoes de acao direto na Form: cmd_4c_Processar, cmd_4c_CopiaLista,
56: *     cmd_4c_Encerrar (Sair), cmd_4c_MarcaProd, cmd_4c_DesmarcaProd
57: *   - funis de carga CarregarLinhas()/CarregarDados(), que ligam cada grade
58: *     ao seu cursor e instalam o CheckBox da coluna de marcacao
59: *     (InstalarCheckBoxColuna) - replicam o fecho do SIGOPSEP.Init
60: *
61: * NAO existe aqui PageFrame nem pagina Lista/Dados: o SCX legado NAO tem
62: * Page nenhuma (layout FLAT, controles direto na Form) - igual ao padrao ja
63: * usado em FormSigOpCrd.prg para a mesma familia de dialogos OPERACIONAL.
64: * Inventar PageFrame Lista/Dados violaria o PILAR 1. Os nomes de metodo
65: * ConfigurarPageFrame/ConfigurarPaginaLista/ConfigurarPaginaDados seguem o
66: * CONTRATO do pipeline, mas o conteudo de cada um e o que de fato existe no
67: * dump:
68: *
69: *   ConfigurarPageFrame   -> fundo do form (Picture new_background.jpg)
70: *   ConfigurarPaginaLista -> cnt_4c_Filtro (CrtFiltro do legado): campos de
71: *       filtro (Grupo Venda/Produto, Moeda, Acrescimo/Desconto,
72: *       Arredondamento, Situacao) + grd_4c_Linhas + cmd_4c_Marcar/
73: *       cmd_4c_Desmarcar
74: *   ConfigurarPaginaDados -> grd_4c_Itens (GradeItens) + os cinco botoes de
75: *       acao, todos filhos diretos da Form no dump
76: *
77: * mapeamento.json (gerado automaticamente) mapeia GradeLinhas E GradeItens
78: * para o MESMO nome "grd_4c_Dados" - colisao de gerador (mesma familia de
79: * bug ja registrada em outras tasks: alvo duplicado no mapeamento auto).
80: * Por isso os dois grids usam nomes DISTINTOS e explicitos (grd_4c_Linhas /
81: * grd_4c_Itens), escolhidos manualmente, e os botoes cmdMarcaProd/
82: * cmdDesmarcaProd (que marcam PRODUTOS) usam cmd_4c_MarcaProd/
83: * cmd_4c_DesmarcaProd para nao colidir com cmd_4c_Marcar/cmd_4c_Desmarcar
84: * (que marcam LINHAS, dentro de cnt_4c_Filtro).
85: *
86: * Fase 5/8 - FormParaBO()/BOParaForm() dos campos de filtro de cnt_4c_Filtro
87: *   (Grupo Venda/Produto codigo+descricao, Moeda Venda codigo+descricao,
88: *   Acrescimo/Desconto, Arredondamento, Situacao), espelhando 1:1 as

*-- Linhas 105 a 130:
105: *   faltavam os 3 campos de descricao).
106: *
107: * Fase 7/8 (ESTA FASE) - os eventos restantes:
108: *   - cmd_4c_Marcar/cmd_4c_Desmarcar.Click -> BO.MarcarTodasLinhas(1/0) +
109: *     Refresh de grd_4c_Linhas (Marcar/Desmarcar do legado)
110: *   - cmd_4c_MarcaProd/cmd_4c_DesmarcaProd.Click -> BO.MarcarTodosProdutos
111: *     (1/0) + Refresh de grd_4c_Itens (cmdMarcaProd/cmdDesmarcaProd)
112: *   - chk_4c_MarcaProduto.When -> so edita a celula quando
113: *     cursor_4c_Produtos.lMarcas = 0 (GradeItens.Column1.Check1.When do
114: *     legado, literal)
115: *   - cmd_4c_Processar.Click -> FormParaBO() + BO.BuscarProdutos(""),
116: *     religa grd_4c_Itens (ReligarGradeItens, novo - fatorado de
117: *     CarregarDados porque o BO recria o alias e a grade precisa ser
118: *     religada nas DUAS situacoes) e replica o aviso "Nao existem
119: *     produtos.../habilita CopiaLista" do fim do Processar.Click legado
120: *   - cmd_4c_CopiaLista.Click -> FormParaBO() + BO.ObterProdutosParaCopia
121: *     ("") preenche cursor_4c_ProdutosCopia (cpros/dpros/pvens/pliqs/moevs)
122: *     com os candidatos (flagctabs=1 AND lMarcas=0, filtrados por
123: *     Situacao) - EXATAMENTE o SCAN do CopiaLista.Click legado, so sem a
124: *     parte que pertence ao form PAI (abaixo)
125: *   - cmd_4c_Encerrar Click -> THIS.Release() (literal)
126: *
127: * O QUE CONTINUA DEFERIDO (documentado desde a Fase 3, linhas 35-39): a
128: * gravacao real em CrSigCdLpi - Delete From CrSigCdLpi Where Empty(cpros),
129: * cidchaves via fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs,
130: * vencis/vencfs, e o arredondamento condicional via fArredondamento

*-- Linhas 289 a 297:
289:                 *-- (cursor_4c_Linhas), cria CsSigCdPro (cursor_4c_Produtos)
290:                 *-- vazio e liga as DUAS grades. Entra so aqui, depois de
291:                 *-- TornarControlesVisiveis, porque RecordSource/ControlSource
292:                 *-- exigem o cursor ja criado (regra #41) e o CheckBox das
293:                 *-- colunas de marcacao exige o bind feito (ver CarregarLinhas).
294:                 *-- As duas cargas sao independentes: a falha da primeira nao
295:                 *-- deve mascarar o resultado da segunda, por isso o AND vem
296:                 *-- depois das duas chamadas, nao em curto-circuito.
297:                 loc_lSucesso = THIS.CarregarLinhas()

*-- Linhas 345 a 404:
345:     * ha o artefato do Form Designer visto em outros dumps (container maior
346:     * que o form) - mesmo assim o container e os labels acompanham
347:     * THIS.Width, nunca o literal, para nao quebrar se o Width mudar.
348:     *==========================================================================
349:     PROTECTED PROCEDURE ConfigurarCabecalho()
350:         THIS.AddObject("cnt_4c_Sombra", "Container")
351:         WITH THIS.cnt_4c_Sombra
352:             .Top           = 0
353:             .Left          = 0
354:             .Width         = THIS.Width
355:             .Height        = 80
356:             .BorderWidth   = 0
357:             .BackStyle     = 1
358:             .BackColor     = RGB(100, 100, 100)
359:             .SpecialEffect = 0
360:             .Visible       = .T.
361:         ENDWITH
362: 
363:         *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
364:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
365:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
366:             *-- AutoSize = .F. explicito: AutoSize e NO-OP em Label criado
367:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
368:             *-- corta o texto (regra #23).
369:             .AutoSize      = .F.
370:             .FontName      = "Tahoma"
371:             .FontSize      = 18
372:             .FontBold      = .T.
373:             .FontUnderline = .F.
374:             .WordWrap      = .T.
375:             .Alignment     = 0
376:             .BackStyle     = 0
377:             .Caption       = THIS.Caption
378:             .Top           = 18
379:             .Left          = 10
380:             .Width         = THIS.Width - 20
381:             .Height        = 40
382:             .ForeColor     = RGB(0, 0, 0)
383:             .Visible       = .T.
384:         ENDWITH
385: 
386:         *-- Label do titulo: branco sobre o cinza do container OPACO - este
387:         *-- e o caso em que o branco esta CORRETO (regra #12)
388:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
389:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
390:             .AutoSize    = .F.
391:             .FontName    = "Tahoma"
392:             .FontSize    = 18
393:             .FontBold    = .T.
394:             .WordWrap    = .T.
395:             .Alignment   = 0
396:             .BackStyle   = 0
397:             .Caption     = THIS.Caption
398:             .Top         = 17
399:             .Left        = 10
400:             .Width       = THIS.Width - 20
401:             .Height      = 46
402:             .ForeColor   = RGB(255, 255, 255)
403:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
404:             .Visible     = .T.

*-- Linhas 442 a 561:
442:     PROTECTED PROCEDURE ConfigurarPaginaLista()
443:         THIS.AddObject("cnt_4c_Filtro", "Container")
444:         WITH THIS.cnt_4c_Filtro
445:             .Top           = 130
446:             .Left          = 62
447:             .Width         = 656
448:             .Height        = 182
449:             .BackStyle     = 0
450:             .BorderWidth   = 0
451:             .SpecialEffect = 2
452:             .Visible       = .T.
453:         ENDWITH
454: 
455:         *-- Labels (Say1..Say7 do legado)
456:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label1", "Label")
457:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label1
458:             .Caption   = "Grupo Venda :"
459:             .Top       = 9
460:             .Left      = 36
461:             .Width     = 69
462:             .Height    = 17
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .Alignment = 0
466:             .BackStyle = 0
467:             .AutoSize  = .F.
468:             .ForeColor = RGB(90, 90, 90)
469:             .Visible   = .T.
470:         ENDWITH
471: 
472:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label2", "Label")
473:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label2
474:             .Caption   = "Moeda Venda :"
475:             .Top       = 57
476:             .Left      = 33
477:             .Width     = 72
478:             .Height    = 17
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .Alignment = 0
482:             .BackStyle = 0
483:             .AutoSize  = .F.
484:             .ForeColor = RGB(90, 90, 90)
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label3", "Label")
489:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label3
490:             .Caption   = "Acr" + CHR(233) + "scimos/Descontos :"
491:             .Top       = 57
492:             .Left      = 385
493:             .Width     = 114
494:             .Height    = 17
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .Alignment = 0
498:             .BackStyle = 0
499:             .AutoSize  = .F.
500:             .ForeColor = RGB(90, 90, 90)
501:             .Visible   = .T.
502:         ENDWITH
503: 
504:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label4", "Label")
505:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label4
506:             .Caption   = "Arredondamento :"
507:             .Top       = 33
508:             .Left      = 432
509:             .Width     = 88
510:             .Height    = 17
511:             .FontName  = "Tahoma"
512:             .FontSize  = 8
513:             .Alignment = 0
514:             .BackStyle = 0
515:             .AutoSize  = .F.
516:             .ForeColor = RGB(90, 90, 90)
517:             .Visible   = .T.
518:         ENDWITH
519: 
520:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label5", "Label")
521:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label5
522:             .Caption   = "%"
523:             .Top       = 57
524:             .Left      = 545
525:             .Width     = 20
526:             .Height    = 17
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .Alignment = 0
530:             .BackStyle = 0
531:             .AutoSize  = .F.
532:             .ForeColor = RGB(90, 90, 90)
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label6", "Label")
537:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label6
538:             .Caption   = "Linhas :"
539:             .Top       = 80
540:             .Left      = 68
541:             .Width     = 37
542:             .Height    = 17
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .Alignment = 0
546:             .BackStyle = 0
547:             .AutoSize  = .F.
548:             .ForeColor = RGB(90, 90, 90)
549:             .Visible   = .T.
550:         ENDWITH
551: 
552:         THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label7", "Label")
553:         WITH THIS.cnt_4c_Filtro.lbl_4c_Label7
554:             .Caption   = "Grupo Produtos :"
555:             .Top       = 33
556:             .Left      = 23
557:             .Width     = 82
558:             .Height    = 17
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .Alignment = 0

*-- Linhas 570 a 579:
570:         *-- Get_DgrVenda.Valid+When)
571:         THIS.cnt_4c_Filtro.AddObject("txt_4c_GrVenda", "TextBox")
572:         WITH THIS.cnt_4c_Filtro.txt_4c_GrVenda
573:             .Top       = 6
574:             .Left      = 109
575:             .Width     = 80
576:             .MaxLength = 10
577:             .ForeColor = RGB(0, 0, 0)
578:             .TabIndex  = 1
579:             .Value     = ""

*-- Linhas 587 a 596:
587:         *-- lookup reverso por descricao (colecoes.descs)
588:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrVenda", "TextBox")
589:         WITH THIS.cnt_4c_Filtro.txt_4c_DgrVenda
590:             .Top       = 6
591:             .Left      = 189
592:             .Width     = 366
593:             .Height    = 23
594:             .MaxLength = 40
595:             .ForeColor = RGB(0, 0, 0)
596:             .TabIndex  = 2

*-- Linhas 604 a 627:
604:         *-- Grupo de Produto: codigo + descricao, lookup SigCdGrp (cgrus/dgrus)
605:         THIS.cnt_4c_Filtro.AddObject("txt_4c_GrProduto", "TextBox")
606:         WITH THIS.cnt_4c_Filtro.txt_4c_GrProduto
607:             .Top       = 30
608:             .Left      = 109
609:             .Width     = 31
610:             .MaxLength = 3
611:             .ForeColor = RGB(0, 0, 0)
612:             .TabIndex  = 3
613:             .Value     = ""
614:             .Visible   = .T.
615:         ENDWITH
616:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "LostFocus", THIS, "ValidarGrProduto")
617:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "InteractiveChange", THIS, "FiltroAlterado")
618: 
619:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrProduto", "TextBox")
620:         WITH THIS.cnt_4c_Filtro.txt_4c_DgrProduto
621:             .Top       = 30
622:             .Left      = 140
623:             .Width     = 150
624:             .MaxLength = 20
625:             .ForeColor = RGB(0, 0, 0)
626:             .TabIndex  = 4
627:             .Value     = ""

*-- Linhas 634 a 670:
634:         *-- Arredondamento (InputMask "9.9" do dump - regra #49)
635:         THIS.cnt_4c_Filtro.AddObject("txt_4c_Arrend", "TextBox")
636:         WITH THIS.cnt_4c_Filtro.txt_4c_Arrend
637:             .Top       = 30
638:             .Left      = 524
639:             .Width     = 31
640:             .MaxLength = 3
641:             .InputMask = "9.9"
642:             .TabIndex  = 5
643:             .Value     = 0
644:             .Visible   = .T.
645:         ENDWITH
646: 
647:         *-- Moeda de Venda: codigo + descricao, lookup SigCdMoe (cmoes/dmoes)
648:         THIS.cnt_4c_Filtro.AddObject("txt_4c_MoeVenda", "TextBox")
649:         WITH THIS.cnt_4c_Filtro.txt_4c_MoeVenda
650:             .Top       = 54
651:             .Left      = 109
652:             .Width     = 31
653:             .MaxLength = 3
654:             .ForeColor = RGB(0, 0, 0)
655:             .TabIndex  = 6
656:             .Value     = ""
657:             .Visible   = .T.
658:         ENDWITH
659:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "LostFocus", THIS, "ValidarMoeVenda")
660:         BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "InteractiveChange", THIS, "FiltroAlterado")
661: 
662:         THIS.cnt_4c_Filtro.AddObject("txt_4c_DmoeVenda", "TextBox")
663:         WITH THIS.cnt_4c_Filtro.txt_4c_DmoeVenda
664:             .Top       = 54
665:             .Left      = 140
666:             .Width     = 115
667:             .MaxLength = 15
668:             .ForeColor = RGB(0, 0, 0)
669:             .TabIndex  = 7
670:             .Value     = ""

*-- Linhas 677 a 747:
677:         *-- Acrescimo/Desconto percentual (InputMask "9999" do dump)
678:         THIS.cnt_4c_Filtro.AddObject("txt_4c_AcreDesc", "TextBox")
679:         WITH THIS.cnt_4c_Filtro.txt_4c_AcreDesc
680:             .Top       = 54
681:             .Left      = 503
682:             .Width     = 38
683:             .MaxLength = 4
684:             .InputMask = "9999"
685:             .TabIndex  = 8
686:             .Value     = 0
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         *-- Situacao (Opc_situacao do legado) - Value = indice do botao
691:         *-- (1=Ativos, 2=Inativos, 3=Todos), transcrito do dump
692:         THIS.cnt_4c_Filtro.AddObject("obj_4c_Situacao", "OptionGroup")
693:         WITH THIS.cnt_4c_Filtro.obj_4c_Situacao
694:             .Top         = 6
695:             .Left        = 569
696:             .Width       = 79
697:             .Height      = 69
698:             .ButtonCount = 3
699:             .BackStyle   = 0
700:             .TabIndex    = 9
701:             .Value       = 1
702:             .Visible     = .T.
703: 
704:             WITH .Buttons(1)
705:                 .FontName  = "Tahoma"
706:                 .Caption   = "\<Ativos"
707:                 .Left      = 10
708:                 .Top       = 5
709:                 .BackStyle = 0
710:                 .ForeColor = RGB(90, 90, 90)
711:             ENDWITH
712: 
713:             WITH .Buttons(2)
714:                 .FontName  = "Tahoma"
715:                 .Caption   = "\<Inativos"
716:                 .Left      = 10
717:                 .Top       = 26
718:                 .BackStyle = 0
719:                 .ForeColor = RGB(90, 90, 90)
720:             ENDWITH
721: 
722:             WITH .Buttons(3)
723:                 .FontName  = "Tahoma"
724:                 .FontSize  = 8
725:                 .BackStyle = 0
726:                 .Caption   = "\<Todos"
727:                 .Height    = 15
728:                 .Left      = 10
729:                 .Top       = 47
730:                 .Width     = 47
731:                 .ForeColor = RGB(90, 90, 90)
732:             ENDWITH
733:         ENDWITH
734: 
735:         *-- Grade de Linhas (GradeLinhas do legado) - estrutura (ColumnCount,
736:         *-- fontes, larguras, headers); RecordSource/ControlSource entram em
737:         *-- CarregarLinhas() (regra #41). HeaderHeight=0 e fiel ao dump (o
738:         *-- legado esconde a linha de header desta grade).
739:         THIS.cnt_4c_Filtro.AddObject("grd_4c_Linhas", "Grid")
740:         WITH THIS.cnt_4c_Filtro.grd_4c_Linhas
741:             .Top          = 79
742:             .Left         = 109
743:             .Width        = 454
744:             .Height       = 94
745:             .ColumnCount  = 3
746:             .FontName     = "Courier New"
747:             .HeaderHeight = 0

*-- Linhas 758 a 806:
758:             .Column1.ReadOnly          = .F.
759:             .Column1.Sparse            = .F.
760:             .Column1.Visible           = .T.
761:             .Column1.Header1.Caption   = ""
762:             .Column1.Header1.FontName  = "Tahoma"
763:             .Column1.Header1.FontSize  = 8
764: 
765:             .Column2.FontName          = "Courier New"
766:             .Column2.FontSize          = 9
767:             .Column2.Width             = 120
768:             .Column2.Movable           = .F.
769:             .Column2.Resizable         = .F.
770:             .Column2.ReadOnly          = .T.
771:             .Column2.Visible           = .T.
772:             .Column2.Header1.Caption   = "C" + CHR(243) + "digo"
773:             .Column2.Header1.FontName  = "Tahoma"
774:             .Column2.Header1.FontSize  = 8
775:             .Column2.Header1.Alignment = 2
776: 
777:             .Column3.FontName          = "Courier New"
778:             .Column3.FontSize          = 9
779:             .Column3.Width             = 290
780:             .Column3.Movable           = .F.
781:             .Column3.Resizable         = .F.
782:             .Column3.ReadOnly          = .T.
783:             .Column3.Visible           = .T.
784:             .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
785:             .Column3.Header1.FontName  = "Tahoma"
786:             .Column3.Header1.FontSize  = 8
787:             .Column3.Header1.Alignment = 2
788:         ENDWITH
789: 
790:         *-- Botoes Marcar/Desmarcar das LINHAS (fwbtnp do legado). O dump
791:         *-- declara so Top/Left/Picture/Caption/ToolTipText: Width/Height vem
792:         *-- da classe fwbtnp (40x40), nao se inventa numero novo (regra #30).
793:         *-- O Click (Replace All lMarcas... + Refresh, ja replicado em
794:         *-- sigopsepBO.MarcarTodasLinhas) e ligado na fase de eventos.
795:         THIS.cnt_4c_Filtro.AddObject("cmd_4c_Marcar", "CommandButton")
796:         WITH THIS.cnt_4c_Filtro.cmd_4c_Marcar
797:             .Top             = 88
798:             .Left            = 573
799:             .Width           = 40
800:             .Height          = 40
801:             .Caption         = ""
802:             .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
803:             .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
804:             .FontName        = "Comic Sans MS"
805:             .FontSize        = 8
806:             .FontBold        = .T.

*-- Linhas 813 a 829:
813:             .Themes          = .T.
814:             .Visible         = .T.
815:         ENDWITH
816:         BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Marcar, "Click", THIS, "BtnMarcarClick")
817: 
818:         THIS.cnt_4c_Filtro.AddObject("cmd_4c_Desmarcar", "CommandButton")
819:         WITH THIS.cnt_4c_Filtro.cmd_4c_Desmarcar
820:             .Top             = 128
821:             .Left            = 573
822:             .Width           = 40
823:             .Height          = 40
824:             .Caption         = ""
825:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
826:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
827:             .FontName        = "Comic Sans MS"
828:             .FontSize        = 8
829:             .FontBold        = .T.

*-- Linhas 836 a 862:
836:             .Themes          = .T.
837:             .Visible         = .T.
838:         ENDWITH
839:         BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Desmarcar, "Click", THIS, "BtnDesmarcarClick")
840: 
841:         RETURN .T.
842:     ENDPROC
843: 
844: 
845:     *==========================================================================
846:     * CarregarLinhas - FUNIL de carga da grade de Linhas (GradeLinhas)
847:     *
848:     * Replica o trecho do SIGOPSEP.Init que popula CsSigCdLin e liga a grade.
849:     * A ORDEM aqui e regra medida, nao estilo:
850:     *   RecordSource -> ControlSource de TODAS as colunas -> Column.AddObject
851:     *   do CheckBox + .Value = 0 -> Sparse = .F. + CurrentControl -> Width /
852:     *   Header1.Caption.
853:     * Motivos: (a) atribuir ControlSource antes do cursor existir estoura
854:     * "Alias not found" dentro do TRY do InicializarForm e a tela nao abre
855:     * (regra #41); (b) Grid sem RecordSource AUTO-BINDA na area de trabalho
856:     * CORRENTE quando o ColumnCount e definido, e um AddObject de CheckBox
857:     * sobre coluna de texto estoura "Data type mismatch" - por isso o CheckBox
858:     * e instalado AQUI, depois do bind, e nao em ConfigurarPaginaLista;
859:     * (c) BuscarLinhas faz USE IN no alias, o que DESTROI o controle posto por
860:     * Column.AddObject (CurrentControl volta a "Text1") preservando
861:     * ColumnCount/Width/Header - perda PARCIAL e silenciosa, por isso a
862:     * instalacao e reentrante; (d) RecordSource reseta Width/Header1.Caption

*-- Linhas 886 a 894:
886:         loc_oGrid.Column3.ControlSource = "cursor_4c_Linhas.descs"
887: 
888:         *-- Column1.Check1 do dump: a coluna de marcacao das Linhas
889:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaLinha")
890: 
891:         *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
892:         *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
893:         *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
894:         *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).

*-- Linhas 921 a 929:
921:     * produtos ja feita.
922:     *==========================================================================
923:     PROCEDURE FiltroAlterado()
924:         THIS.cmd_4c_CopiaLista.Enabled = .F.
925:     ENDPROC
926: 
927: 
928:     *==========================================================================
929:     * Lookups de cnt_4c_Filtro (fase 6/8) - 3 pares codigo/descricao, cada um

*-- Linhas 1353 a 1361:
1353:     * (Sair/CopiaLista/Processar/cmdMarcaProd/cmdDesmarcaProd).
1354:     *
1355:     * APENAS a estrutura da grade (ColumnCount, fontes, larguras, headers):
1356:     * RecordSource/ControlSource e o CheckBox da Column1 ficam no funil
1357:     * CarregarDados(), pela sequencia medida que esta documentada la.
1358:     *
1359:     * Sair/CopiaLista/Processar sao fwbtng no legado e o SCX sobrepoe apenas
1360:     * Top/Left/Picture/Caption/Cancel/ToolTipText/PicturePosition; o resto vem
1361:     * da classe ("Comic Sans MS" 8 bold+italic, ForeColor 90,90,90, BackColor

*-- Linhas 1382 a 1414:
1382:         *----------------------------------------------------------------------
1383:         THIS.AddObject("grd_4c_Itens", "Grid")
1384:         WITH THIS.grd_4c_Itens
1385:             .Top         = 316
1386:             .Left        = 64
1387:             .Width       = 673
1388:             .Height      = 130
1389:             .ColumnCount = 6
1390:             .FontName    = "Courier New"
1391:             .FontSize    = 9
1392:             .ReadOnly    = .F.
1393:             .RecordMark  = .F.
1394:             .DeleteMark  = .F.
1395:             .TabIndex    = 2
1396:             .Visible     = .T.
1397:         ENDWITH
1398: 
1399:         *-- Column1: marcacao (CheckBox). O ReadOnly da COLUNA vem DEPOIS do
1400:         *-- ReadOnly do GRID, que propaga e sobrescreveria (regra #18).
1401:         WITH THIS.grd_4c_Itens.Column1
1402:             .FontName          = "Courier New"
1403:             .Width             = 20
1404:             .Movable           = .F.
1405:             .Resizable         = .F.
1406:             .Sparse            = .F.
1407:             .ReadOnly          = .F.
1408:             .Visible           = .T.
1409:             .Header1.Caption   = ""
1410:             .Header1.FontName  = "Tahoma"
1411:             .Header1.FontSize  = 8
1412:             .Header1.ForeColor = RGB(0, 0, 0)
1413:         ENDWITH
1414: 

*-- Linhas 1420 a 1428:
1420:             .Sparse            = .F.
1421:             .ReadOnly          = .T.
1422:             .Visible           = .T.
1423:             .Header1.Caption   = "C" + CHR(243) + "digo Produto"
1424:             .Header1.FontName  = "Tahoma"
1425:             .Header1.FontSize  = 8
1426:             .Header1.Alignment = 2
1427:             .Header1.ForeColor = RGB(0, 0, 0)
1428:             .Text1.FontName    = "Courier New"

*-- Linhas 1440 a 1448:
1440:             .Resizable         = .F.
1441:             .ReadOnly          = .T.
1442:             .Visible           = .T.
1443:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
1444:             .Header1.FontName  = "Tahoma"
1445:             .Header1.FontSize  = 8
1446:             .Header1.Alignment = 2
1447:             .Header1.ForeColor = RGB(0, 0, 0)
1448:             .Text1.FontName    = "Courier New"

*-- Linhas 1464 a 1472:
1464:             .ReadOnly          = .T.
1465:             .InputMask         = "999,999,999.99"
1466:             .Visible           = .T.
1467:             .Header1.Caption   = "Pre" + CHR(231) + "o de Venda (C)"
1468:             .Header1.FontName  = "Tahoma"
1469:             .Header1.FontSize  = 8
1470:             .Header1.Alignment = 2
1471:             .Header1.ForeColor = RGB(36, 84, 155)
1472:             .Text1.FontName    = "Courier New"

*-- Linhas 1484 a 1492:
1484:             .Resizable         = .F.
1485:             .ReadOnly          = .T.
1486:             .Visible           = .T.
1487:             .Header1.Caption   = "Moeda"
1488:             .Header1.FontName  = "Tahoma"
1489:             .Header1.FontSize  = 8
1490:             .Header1.Alignment = 2
1491:             .Header1.ForeColor = RGB(0, 0, 0)
1492:             .Text1.FontName    = "Courier New"

*-- Linhas 1508 a 1516:
1508:             .ReadOnly          = .F.
1509:             .InputMask         = "999,999,999.99"
1510:             .Visible           = .T.
1511:             .Header1.Caption   = "Pre" + CHR(231) + "o de Venda (L)"
1512:             .Header1.FontName  = "Tahoma"
1513:             .Header1.FontSize  = 8
1514:             .Header1.Alignment = 2
1515:             .Header1.ForeColor = RGB(0, 0, 0)
1516:             .Text1.FontName    = "Courier New"

*-- Linhas 1526 a 1540:
1526:         *----------------------------------------------------------------------
1527: 
1528:         *-- Processar (dump: Top=3 Left=651, geral_processar_60.jpg)
1529:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
1530:         WITH THIS.cmd_4c_Processar
1531:             .Top             = 3
1532:             .Left            = 651
1533:             .Width           = 75
1534:             .Height          = 75
1535:             .Caption         = "\<Processar"
1536:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1537:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1538:             .FontName        = "Comic Sans MS"
1539:             .FontSize        = 8
1540:             .FontBold        = .T.

*-- Linhas 1548 a 1566:
1548:             .ToolTipText     = "Seleciona os Produtos Conforme os Filtros"
1549:             .Visible         = .T.
1550:         ENDWITH
1551:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1552: 
1553:         *-- Copia p/ Lista (dump: Top=3 Left=576, geral_pendencia_60.jpg,
1554:         *-- PicturePosition = 7)
1555:         THIS.AddObject("cmd_4c_CopiaLista", "CommandButton")
1556:         WITH THIS.cmd_4c_CopiaLista
1557:             .Top             = 3
1558:             .Left            = 576
1559:             .Width           = 75
1560:             .Height          = 75
1561:             .Caption         = "Copia p/ \<Lista"
1562:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
1563:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
1564:             .PicturePosition = 7
1565:             .FontName        = "Comic Sans MS"
1566:             .FontSize        = 8

*-- Linhas 1575 a 1593:
1575:             .ToolTipText     = "Copia os Produtos Marcados Para a Lista"
1576:             .Visible         = .T.
1577:         ENDWITH
1578:         BINDEVENT(THIS.cmd_4c_CopiaLista, "Click", THIS, "BtnCopiaListaClick")
1579: 
1580:         *-- Encerrar (Sair do dump: Top=3 Left=725, Cancel = .T. - e o botao
1581:         *-- que responde ao ESC; cadastro_sair_60.jpg)
1582:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1583:         WITH THIS.cmd_4c_Encerrar
1584:             .Top             = 3
1585:             .Left            = 725
1586:             .Width           = 75
1587:             .Height          = 75
1588:             .Caption         = "Encerrar"
1589:             .Cancel          = .T.
1590:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1591:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1592:             .FontName        = "Comic Sans MS"
1593:             .FontSize        = 8

*-- Linhas 1602 a 1622:
1602:             .ToolTipText     = "Encerra a Sele" + CHR(231) + CHR(227) + "o de Produtos"
1603:             .Visible         = .T.
1604:         ENDWITH
1605:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1606: 
1607:         *-- Marca / Desmarca TODOS os PRODUTOS (cmdMarcaProd/cmdDesmarcaProd
1608:         *-- do dump: Top=455, Left=626/666, fwbtnp 40x40, icone-only).
1609:         *-- Nomes distintos dos irmaos de cnt_4c_Filtro (cmd_4c_Marcar/
1610:         *-- cmd_4c_Desmarcar), que marcam LINHAS e nao PRODUTOS.
1611:         THIS.AddObject("cmd_4c_MarcaProd", "CommandButton")
1612:         WITH THIS.cmd_4c_MarcaProd
1613:             .Top             = 455
1614:             .Left            = 626
1615:             .Width           = 40
1616:             .Height          = 40
1617:             .Caption         = ""
1618:             .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
1619:             .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
1620:             .FontName        = "Comic Sans MS"
1621:             .FontSize        = 8
1622:             .FontBold        = .T.

*-- Linhas 1629 a 1645:
1629:             .ToolTipText     = "Marca Todas as Linhas de Produto"
1630:             .Visible         = .T.
1631:         ENDWITH
1632:         BINDEVENT(THIS.cmd_4c_MarcaProd, "Click", THIS, "BtnMarcaProdClick")
1633: 
1634:         THIS.AddObject("cmd_4c_DesmarcaProd", "CommandButton")
1635:         WITH THIS.cmd_4c_DesmarcaProd
1636:             .Top             = 455
1637:             .Left            = 666
1638:             .Width           = 40
1639:             .Height          = 40
1640:             .Caption         = ""
1641:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
1642:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
1643:             .FontName        = "Comic Sans MS"
1644:             .FontSize        = 8
1645:             .FontBold        = .T.

*-- Linhas 1652 a 1660:
1652:             .ToolTipText     = "Desmarca Todas as Linhas de Produto"
1653:             .Visible         = .T.
1654:         ENDWITH
1655:         BINDEVENT(THIS.cmd_4c_DesmarcaProd, "Click", THIS, "BtnDesmarcaProdClick")
1656: 
1657:         RETURN .T.
1658:     ENDPROC
1659: 
1660: 

*-- Linhas 1685 a 1706:
1685:         ENDIF
1686: 
1687:         *-- SIGOPSEP.Init termina com CopiaLista.Enabled = .F.
1688:         THIS.cmd_4c_CopiaLista.Enabled = .F.
1689: 
1690:         RETURN .T.
1691:     ENDPROC
1692: 
1693: 
1694:     *==========================================================================
1695:     * ReligarGradeItens - (re)liga grd_4c_Itens a cursor_4c_Produtos
1696:     *
1697:     * Fatorado de CarregarDados (Fase 4) porque BO.BuscarProdutos (Fase 7,
1698:     * usado em BtnProcessarClick) RECRIA cursor_4c_Produtos (USE IN +
1699:     * CREATE CURSOR, via CriarCursorProdutos) para popula-lo com dados
1700:     * reais - a MESMA razao, ja documentada em InstalarCheckBoxColuna, pela
1701:     * qual fechar/recriar o alias do RecordSource destroi o CheckBox posto
1702:     * por Column.AddObject. Por isso o bind tem de ser refeito do ZERO
1703:     * depois de QUALQUER recriacao do cursor, nao so na carga inicial.
1704:     *==========================================================================
1705:     PROTECTED PROCEDURE ReligarGradeItens()
1706:         LOCAL loc_oGrid

*-- Linhas 1725 a 1733:
1725:         *-- objeto acabou de nascer de novo (RecordSource acima destruiu o
1726:         *-- anterior) - religar o When (GradeItens.Column1.Check1.When do
1727:         *-- legado: "Return(CsSigCdPro.lMarcas = 0)") no objeto NOVO.
1728:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaProduto")
1729:         BINDEVENT(loc_oGrid.Column1.chk_4c_MarcaProduto, "When", THIS, "WhenMarcaProduto")
1730: 
1731:         *-- DynamicForeColor do legado: azul no produto que JA esta na lista de
1732:         *-- precos do form pai (lMarcas = 1), preto nos demais. Transcrito do
1733:         *-- SIGOPSEP.Init, com o nome do cursor migrado.

*-- Linhas 1765 a 1773:
1765: 
1766: 
1767:     *==========================================================================
1768:     * WhenMarcaProduto - When do CheckBox de marcacao de grd_4c_Itens
1769:     * (GradeItens.Column1.Check1.When do legado: "Return(CsSigCdPro.lMarcas
1770:     * = 0)", literal). So permite editar a celula quando o produto AINDA
1771:     * NAO esta na lista de precos do pai - produto ja presente (lMarcas=1)
1772:     * fica travado, visualmente distinguido pelo DynamicForeColor azul de
1773:     * ReligarGradeItens.

*-- Linhas 1853 a 1861:
1853:                      CHR(226) + "metros !!!", "Aten" + CHR(231) + CHR(227) + "o")
1854:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.SetFocus()
1855:         ELSE
1856:             THIS.cmd_4c_CopiaLista.Enabled = .T.
1857:             THIS.grd_4c_Itens.SetFocus()
1858:         ENDIF
1859:     ENDPROC
1860: 
1861:     *--------------------------------------------------------------------------

*-- Linhas 1914 a 1922:
1914: 
1915: 
1916:     *==========================================================================
1917:     * InstalarCheckBoxColuna - instala (ou REINSTALA) o CheckBox de marcacao
1918:     * numa Column de Grid, no estado em que o dump declara Column1.Check1
1919:     * (Top=27 Left=7 Width=60 Height=17 Alignment=0 Caption="" ReadOnly=.F.) -
1920:     * o mesmo nos dois grids do form.
1921:     *
1922:     * Column.AddObject cria o objeto mas NAO o exibe: sem CurrentControl a

*-- Linhas 1930 a 1967:
1930:     * o resto e sempre reaplicado.
1931:     *
1932:     * par_oColuna - objeto Column, JA ligado via ControlSource
1933:     * par_cNome   - nome do CheckBox a instalar nessa coluna
1934:     *==========================================================================
1935:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNome)
1936:         LOCAL loc_oChk
1937: 
1938:         IF VARTYPE(par_oColuna) != "O" OR VARTYPE(par_cNome) != "C" OR EMPTY(par_cNome)
1939:             RETURN .F.
1940:         ENDIF
1941: 
1942:         IF !PEMSTATUS(par_oColuna, par_cNome, 5)
1943:             par_oColuna.AddObject(par_cNome, "CheckBox")
1944:         ENDIF
1945: 
1946:         *-- Membro alcancado por NOME: EVALUATE na leitura. Controls(<nome>) e
1947:         *-- indexado por NUMERO e estouraria em runtime (regras #15/#34).
1948:         loc_oChk = EVALUATE("par_oColuna." + par_cNome)
1949: 
1950:         IF VARTYPE(loc_oChk) != "O"
1951:             RETURN .F.
1952:         ENDIF
1953: 
1954:         WITH loc_oChk
1955:             .Caption   = ""
1956:             .Alignment = 0
1957:             .Top       = 27
1958:             .Left      = 7
1959:             .Width     = 60
1960:             .Height    = 17
1961:             .ReadOnly  = .F.
1962:             *-- CheckBox.Value e NUMERICO (0/1), nunca .F./.T.: as colunas
1963:             *-- ligadas (lMarcas/flagctabs) sao N(1)
1964:             .Value     = 0
1965:             .Visible   = .T.
1966:         ENDWITH
1967: 

*-- Linhas 1999 a 2007:
1999: 
2000:         WITH par_oColuna
2001:             .Width             = par_nWidth
2002:             .Header1.Caption   = par_cCaption
2003:             .Header1.FontName  = "Tahoma"
2004:             .Header1.FontSize  = 8
2005:             .Header1.Alignment = par_nAlignment
2006: 
2007:             IF par_nForeColor >= 0

*-- Linhas 2052 a 2068:
2052:     *==========================================================================
2053:     PROTECTED PROCEDURE BOParaForm()
2054:         WITH THIS.this_oBusinessObject
2055:             THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value    = .this_cGrupoVenda
2056:             THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value   = .this_cDescGrupoVenda
2057:             THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = .this_cGrupoProduto
2058:             THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = .this_cDescGrupoProduto
2059:             THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value   = .this_cMoedaVenda
2060:             THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value  = .this_cDescMoedaVenda
2061:             THIS.cnt_4c_Filtro.txt_4c_AcreDesc.Value   = .this_nAcrescimoDesconto
2062:             THIS.cnt_4c_Filtro.txt_4c_Arrend.Value     = .this_nArredondamento
2063:             THIS.cnt_4c_Filtro.obj_4c_Situacao.Value   = .this_nSituacao
2064:         ENDWITH
2065:     ENDPROC
2066: 
2067: 
2068:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigopsepBO.prg):
*==============================================================================
* SIGOPSEPBO.PRG
* Business Object - Selecao de Produtos para Lista de Preco
* Origem: SIGOPSEP.SCX (form filho, chamado por ThisForm.ParentForm)
*==============================================================================

DEFINE CLASS sigopsepBO AS BusinessBase

    *-- Filtro: Grupo de Venda (colecoes - SigCdCol)
    this_cGrupoVenda = ""
    this_cDescGrupoVenda = ""

    *-- Filtro: Grupo de Produto (cgrus - SigCdGrp)
    this_cGrupoProduto = ""
    this_cDescGrupoProduto = ""

    *-- Filtro: Moeda de Venda (cmoes - SigCdMoe)
    this_cMoedaVenda = ""
    this_cDescMoedaVenda = ""

    *-- Filtro: Acrescimo/Desconto percentual
    this_nAcrescimoDesconto = 0

    *-- Filtro: Arredondamento
    this_nArredondamento = 0

    *-- Filtro: Situacao (1=Ativos, 2=Inativos, 3=Todos)
    this_nSituacao = 1

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdPro")

        THIS.this_cCampoChave = "cpros"

        THIS.this_cGrupoVenda = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cGrupoProduto = ""
        THIS.this_cDescGrupoProduto = ""
        THIS.this_cMoedaVenda = ""
        THIS.this_cDescMoedaVenda = ""
        THIS.this_nAcrescimoDesconto = 0
        THIS.this_nArredondamento = 0
        THIS.this_nSituacao = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Carrega cursor_4c_Linhas (SigCdLin) para a grade de
    * marcacao de linhas do filtro (SIGOPSEP.Init: CsSigCdLin).
    * SQLEXEC() devolve cursor SOMENTE-LEITURA; como a grade marca/desmarca
    * via REPLACE, convertemos para READWRITE antes de expor o cursor.
    *
    * O bypass de teste vem no TOPO porque o TesteAutomatico.prg e o
    * ValidarUIFidelity.prg NAO conectam ao SQL Server (definem gnConnHandle
    * como SENTINELA). Sem ele a falha de conexao devolveria .F., o
    * InicializarForm do Form devolveria .F., CREATEOBJECT devolveria o
    * LOGICO .F. e a tela simplesmente nao abriria no harness - com uma
    * mensagem de conexao que nao corresponde a falha de rede nenhuma. O
    * cursor VAZIO e criado com a MESMA estrutura e ordem de campos do SELECT
    * abaixo (lMarcas, linhas C(10), descs C(40) - larguras de SigCdLin no
    * schema), para a grade ter o que ligar em ControlSource.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Linhas (lMarcas N(1), linhas C(10), descs C(40))
            SET NULL OFF
            SELECT cursor_4c_Linhas
            GO TOP
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_LinhasTmp")
                USE IN cursor_4c_LinhasTmp
            ENDIF
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, linhas, descs FROM SigCdLin"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasTmp")

            IF loc_nResultado >= 0
                SET NULL ON
                SELECT * FROM cursor_4c_LinhasTmp INTO CURSOR cursor_4c_Linhas READWRITE
                SET NULL OFF

                IF USED("cursor_4c_LinhasTmp")
                    USE IN cursor_4c_LinhasTmp
                ENDIF

                SELECT cursor_4c_Linhas
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLinhas - Replica Marcar.Click/Desmarcar.Click (Replace All
    * lMarcas With <valor> In CsSigCdLin).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLinhas(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                REPLACE ALL lMarcas WITH par_nValor
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorProdutos - Estrutura identica ao "Create Cursor CsSigCdPro"
    * do SIGOPSEP.Init. Cursor local (nao vem de SQLEXEC), por isso ja nasce
    * READWRITE - suporta o CheckBox da coluna flagctabs (Column1) e os
    * REPLACE de MarcarTodosProdutos/ObterProdutosParaCopia.
    *
    * PUBLIC de proposito: o Form chama este metodo para criar o cursor VAZIO
    * antes de ligar a grade de produtos (o SIGOPSEP.Init legado faz o
    * "Create Cursor" inline, antes do RecordSource/ControlSource). Deixar a
    * estrutura do cursor SO aqui evita duas versoes do mesmo CREATE CURSOR -
    * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
    * ControlSource da grade. Metodo que o Form chama de fora NAO pode ser
    * PROTECTED em nenhum nivel da heranca (regra #51): a chamada compila
    * limpo e estoura em runtime com "Property ... is not found".
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorProdutos()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (flagctabs N(1), cpros C(14), dpros C(40), pvens N(12,2), ;
            pliqs N(12,2), moevs C(3), situas N(1), cgrus C(3), colecoes C(10), linhas C(10), lMarcas N(1))
        SET NULL OFF

        INDEX ON cpros + cgrus TAG CProGrus
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Replica SIGOPSEP.Processar.Click: monta o WHERE a
    * partir dos filtros (this_cGrupoProduto/this_cGrupoVenda/
    * this_cMoedaVenda) e das linhas marcadas em cursor_4c_Linhas, consulta
    * SigCdPro e recria cursor_4c_Produtos com pliqs calculado
    * (this_nAcrescimoDesconto/this_nArredondamento).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (equivalente a
    * CrSigCdLpi) - usado so para marcar flagctabs/lMarcas = 1 quando o
    * produto ja esta na lista de precos (Seek por CPros, igual ao legado).
    * Passar "" quando o form pai ainda nao disponibilizar esse cursor.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_cWhere, loc_cLinhas, loc_cSQL, loc_nResultado, ;
            loc_nVariacao, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cWhere = "0 = 0 "

            IF !EMPTY(THIS.this_cGrupoProduto)
                loc_cWhere = loc_cWhere + "AND cgrus = " + EscaparSQL(THIS.this_cGrupoProduto) + " "
            ENDIF
            IF !EMPTY(THIS.this_cGrupoVenda)
                loc_cWhere = loc_cWhere + "AND colecoes = " + EscaparSQL(THIS.this_cGrupoVenda) + " "
            ENDIF
            IF !EMPTY(THIS.this_cMoedaVenda)
                loc_cWhere = loc_cWhere + "AND moevs = " + EscaparSQL(THIS.this_cMoedaVenda) + " "
            ENDIF

            loc_cLinhas = ""
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                GO TOP
                SCAN
                    IF cursor_4c_Linhas.lMarcas = 1
                        loc_cLinhas = loc_cLinhas + "linhas = " + EscaparSQL(cursor_4c_Linhas.linhas) + " OR "
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cLinhas)
                loc_cWhere = loc_cWhere + "AND (" + LEFT(loc_cLinhas, LEN(loc_cLinhas) - 3) + ") "
            ENDIF

            loc_cSQL = "SELECT flagctabs, cpros, dpros, pvens, moevs, situas, cgrus, colecoes, linhas " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY cpros, cgrus, flagctabs, dpros, pvens, moevs, situas, colecoes, linhas"

            IF USED("cursor_4c_ProdutosTmp")
                USE IN cursor_4c_ProdutosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTmp")

            IF loc_nResultado >= 0
                THIS.CriarCursorProdutos()

                loc_nVariacao = 1 + (THIS.this_nAcrescimoDesconto / 100)

                SELECT cursor_4c_ProdutosTmp
                GO TOP
                SCAN
                    SCATTER MEMVAR

                    IF !EMPTY(par_cCursorListaPrecos) AND USED(par_cCursorListaPrecos) ;
                            AND SEEK(cursor_4c_ProdutosTmp.cpros, par_cCursorListaPrecos, "CPros")
                        m.flagctabs = 1
                    ELSE
                        m.flagctabs = 0
                    ENDIF
                    m.lMarcas = m.flagctabs

                    m.pliqs = ROUND(cursor_4c_ProdutosTmp.pvens * loc_nVariacao, 2)
                    IF THIS.this_nArredondamento <> 0
                        m.pliqs = ROUND(m.pliqs / THIS.this_nArredondamento, 0) * THIS.this_nArredondamento
                    ENDIF

                    INSERT INTO cursor_4c_Produtos FROM MEMVAR

                    SELECT cursor_4c_ProdutosTmp
                ENDSCAN

                IF USED("cursor_4c_ProdutosTmp")
                    USE IN cursor_4c_ProdutosTmp
                ENDIF

                SELECT cursor_4c_Produtos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosProdutos - Replica cmdMarcaProd.Click/cmdDesmarcaProd.Click
    * (Replace All flagctabs With <valor> For lMarcas = 0).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosProdutos(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                REPLACE ALL flagctabs WITH par_nValor FOR lMarcas = 0
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutosParaCopia - Replica o SCAN de SIGOPSEP.CopiaLista.Click:
    * seleciona os produtos marcados pelo usuario (flagctabs=1) que ainda
    * nao estavam na lista (lMarcas=0), respeitando o filtro de situacao
    * (this_nSituacao: 3=Todos), e reconfere que nao foram copiados nesse
    * meio-tempo (Seek por CPros no cursor do form pai).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (CrSigCdLpi).
    *
    * A INSERCAO final nesse cursor (cidchaves=fUniqueIds(), lprecos do
    * cabecalho CrSigCdLpc, vencis/vencfs={}, flagutabs=.T., pvens=pliqs)
    * fica por conta do Form: a estrutura de CrSigCdLpi/CrSigCdLpc pertence
    * ao form pai (fora do escopo deste BO, que so enxerga SigCdPro/
    * SigCdLin). fArredondamento(pvens, poDataMgr) do legado NAO foi
    * portada (funcao global Fortyus ausente do acervo, SIGFUNCS.PRG) -
    * fica de fora de proposito; o Form aplica essa funcao, quando portada,
    * somente quando o form pai indicar CompVenda <> "C" (mesmo guard do
    * legado). NUNCA substituir por ROUND/INT/CEILING.
    *
    * Popula cursor_4c_ProdutosCopia com cpros/dpros/pvens/pliqs/moevs.
    *--------------------------------------------------------------------------
    PROCEDURE ObterProdutosParaCopia(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF !USED("cursor_4c_Produtos")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_ProdutosCopia")
                    USE IN cursor_4c_ProdutosCopia
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_ProdutosCopia (cpros C(14), dpros C(40), pvens N(12,2), ;
                    pliqs N(12,2), moevs C(3))
                SET NULL OFF

                SELECT cursor_4c_Produtos
                GO TOP
                SCAN FOR cursor_4c_Produtos.flagctabs = 1 AND cursor_4c_Produtos.lMarcas = 0
                    IF THIS.this_nSituacao = 3 OR THIS.this_nSituacao = cursor_4c_Produtos.situas
                        IF EMPTY(par_cCursorListaPrecos) OR !USED(par_cCursorListaPrecos) ;
                                OR !SEEK(cursor_4c_Produtos.cpros, par_cCursorListaPrecos, "CPros")
                            INSERT INTO cursor_4c_ProdutosCopia (cpros, dpros, pvens, pliqs, moevs) VALUES ;
                                (cursor_4c_Produtos.cpros, cursor_4c_Produtos.dpros, cursor_4c_Produtos.pvens, ;
                                 cursor_4c_Produtos.pliqs, cursor_4c_Produtos.moevs)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Produtos
                ENDSCAN

                SELECT cursor_4c_ProdutosCopia
                GO TOP

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores locais abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("cursor_4c_Linhas")
            USE IN cursor_4c_Linhas
        ENDIF
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdutosCopia")
            USE IN cursor_4c_ProdutosCopia
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais ao destruir o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Este BO NAO persiste nenhuma tabela propria: o SIGOPSEP legado apenas
    * CONSULTA SigCdPro/SigCdLin (filtros + grade de selecao) e copia os
    * produtos marcados para o cursor de ITENS do form pai (CrSigCdLpi,
    * fora do escopo deste BO) - nunca grava em SigCdPro. Por isso
    * Inserir()/Atualizar()/ExecutarExclusao()/RegistrarAuditoria()/
    * CarregarDoCursor()/ObterChavePrimaria() NAO sao sobrescritos aqui - o
    * comportamento padrao herdado de BusinessBase ja eh o correto para
    * este caso (mesmo padrao de SigOpCtsBO.prg/SigOpAutBO.prg, outras
    * telas operacionais sem tabela mestre propria).
    *==========================================================================

ENDDEFINE

