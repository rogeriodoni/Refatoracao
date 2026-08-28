# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarNopes' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarNopes(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDopes' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDopes(par_nKeyCode, par_nShiftAltCtrl)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOpd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1292 linhas total):

*-- Linhas 26 a 151:
26:     *===========================================================================
27:     * Init - Inicializa o formulario
28:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
29:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
30:     *===========================================================================
31:     PROCEDURE Init()
32:         RETURN DODEFAULT()
33:     ENDPROC
34: 
35:     *===========================================================================
36:     * InicializarForm - Configura estrutura completa do formulario
37:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
38:     *===========================================================================
39:     PROTECTED PROCEDURE InicializarForm()
40:         LOCAL loc_lSucesso
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.Caption = "Cadastro de Opera" + CHR(231) + CHR(245) + "es de Pedido"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("OpdBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar OpdBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormOpd.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Visible  = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual = "LISTA"
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 loc_lSucesso = .T.
65:             ENDIF
66: 
67:         CATCH TO loException
68:             MostrarErro("Erro ao inicializar FormOpd:" + CHR(13) + ;
69:                 loException.Message + CHR(13) + ;
70:                 "Linha: " + TRANSFORM(loException.LineNo), ;
71:                 "FormOpd.InicializarForm")
72:         ENDTRY
73: 
74:         RETURN loc_lSucesso
75:     ENDPROC
76: 
77:     *===========================================================================
78:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
79:     * Top=-29 para esconder abas; todos os controles compensam +29 no Top
80:     *===========================================================================
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 com Grid + botoes CRUD
108:     * Grid: legado Top=121/Left=12/Width=940; compensacao +29 -> Top=150
109:     * Botoes canonicos: cnt_4c_Botoes Left=542; cnt_4c_Saida Left=917
110:     *===========================================================================
111:     PROTECTED PROCEDURE ConfigurarPaginaLista()
112:         LOCAL loc_oPagina, loc_oGrid
113:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
114: 
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         *-- Container Cabecalho (cntSombra no legado: Top=1; +29 -> Top=30)
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top         = 30
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
130:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
131:             .Caption   = THIS.Caption
132:             .Top       = 15
133:             .Left      = 10
134:             .Width     = 769
135:             .Height    = 40
136:             .FontName  = "Tahoma"
137:             .FontSize  = 16
138:             .FontBold  = .T.
139:             .ForeColor = RGB(0, 0, 0)
140:             .BackStyle = 0
141:             .AutoSize  = .F.
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
147:             .Caption   = THIS.Caption
148:             .Top       = 18
149:             .Left      = 10
150:             .Width     = 769
151:             .Height    = 46

*-- Linhas 374 a 435:
374:             .Alignment = 0
375:         ENDWITH
376: 
377:         *-- BINDEVENTs para botoes (handlers devem ser PUBLIC)
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
380:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
384: 
385:         THIS.TornarControlesVisiveis(loc_oPagina)
386:     ENDPROC
387: 
388:     *===========================================================================
389:     * ConfigurarPaginaDados - Configura Page2 com todos os campos e botoes
390:     * Campos: lbl_4c_OperacaoLabel, txt_4c_Nopes, txt_4c_Dopes,
391:     *         opt_4c_Pagos (3 buttons), opt_4c_Utils (3 buttons)
392:     * Botoes: cnt_4c_BotoesAcao -> cmd_4c_Confirmar, cmd_4c_Cancelar
393:     * Compensacao PageFrame +29 aplicada a todos os Tops
394:     *===========================================================================
395:     PROTECTED PROCEDURE ConfigurarPaginaDados()
396:         LOCAL loc_oPagina
397:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
398: 
399:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
400: 
401:         *-- Container BotoesAcao (grupo_salva: Left=618, Top=11+29=40, Width=160, Height=85)
402:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
403:         WITH loc_oPagina.cnt_4c_BotoesAcao
404:             .Top         = 40
405:             .Left        = 618
406:             .Width       = 160
407:             .Height      = 85
408:             .BackStyle   = 0
409:             .BorderWidth = 0
410:             .Visible     = .T.
411:         ENDWITH
412: 
413:         *-- Botao Confirmar (salva: Left=5, Top=5, Width=75, Height=75)
414:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
415:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
416:             .Caption         = "Confirmar"
417:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
418:             .PicturePosition = 13
419:             .Top             = 5
420:             .Left            = 5
421:             .Width           = 75
422:             .Height          = 75
423:             .FontName        = "Comic Sans MS"
424:             .FontSize        = 8
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .ForeColor       = RGB(90, 90, 90)
428:             .BackColor       = RGB(255, 255, 255)
429:             .Themes          = .F.
430:             .SpecialEffect   = 0
431:             .MousePointer    = 15
432:             .WordWrap        = .T.
433:             .AutoSize        = .F.
434:             .Visible         = .T.
435:         ENDWITH

*-- Linhas 458 a 662:
458:             .Visible         = .T.
459:         ENDWITH
460: 
461:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
462:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
463: 
464:         *-- Label Opera??o: (Label3: Top=121+29=150, Left=135, Width=53, Height=15)
465:         loc_oPagina.AddObject("lbl_4c_OperacaoLabel", "Label")
466:         WITH loc_oPagina.lbl_4c_OperacaoLabel
467:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
468:             .Top       = 150
469:             .Left      = 135
470:             .Width     = 53
471:             .Height    = 15
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.
475:             .ForeColor = RGB(90, 90, 90)
476:             .BackStyle = 0
477:             .AutoSize  = .T.
478:             .Visible   = .T.
479:         ENDWITH
480: 
481:         *-- TextBox Codigo Operacao (getnopes: Top=117+29=146, Left=203, Width=37)
482:         *-- Value=0 (numeric: this_nNdopes); lookup abre em SigCdOpe
483:         loc_oPagina.AddObject("txt_4c_Nopes", "TextBox")
484:         WITH loc_oPagina.txt_4c_Nopes
485:             .Value     = 0
486:             .Top       = 146
487:             .Left      = 203
488:             .Width     = 37
489:             .Height    = 23
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .ForeColor = RGB(90, 90, 90)
493:             .TabIndex  = 1
494:             .ReadOnly  = .F.
495:             .Visible   = .T.
496:         ENDWITH
497:         BINDEVENT(loc_oPagina.txt_4c_Nopes, "KeyPress", THIS, "ValidarNopes")
498:         BINDEVENT(loc_oPagina.txt_4c_Nopes, "KeyPress", THIS, "NopesKeyPress")
499:         BINDEVENT(loc_oPagina.txt_4c_Nopes, "DblClick", THIS, "NopesDblClick")
500: 
501:         *-- TextBox Descricao Operacao (GetDopes: Top=117+29=146, Left=243, Width=150)
502:         *-- Value="" (char: this_cDopes = PK de SigOpPed); somente em INCLUIR
503:         loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
504:         WITH loc_oPagina.txt_4c_Dopes
505:             .Value     = ""
506:             .Top       = 146
507:             .Left      = 243
508:             .Width     = 150
509:             .Height    = 23
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .ForeColor = RGB(90, 90, 90)
513:             .TabIndex  = 2
514:             .ReadOnly  = .F.
515:             .Visible   = .T.
516:         ENDWITH
517:         BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "ValidarDopes")
518:         BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "DopesKeyPress")
519:         BINDEVENT(loc_oPagina.txt_4c_Dopes, "DblClick", THIS, "DopesDblClick")
520: 
521:         *-- OptionGroup Pagamentos (OptPagos: Top=143+29=172, Left=198, Width=268, Height=27)
522:         *-- 1=Pagos, 2=Nao Pagos, 3=Todos
523:         loc_oPagina.AddObject("opt_4c_Pagos", "OptionGroup")
524:         WITH loc_oPagina.opt_4c_Pagos
525:             .ButtonCount = 3
526:             .BackStyle   = 0
527:             .BorderStyle = 0
528:             .Top         = 172
529:             .Left        = 198
530:             .Width       = 268
531:             .Height      = 27
532:             .Value       = 0
533:             .Visible     = .T.
534:         ENDWITH
535:         WITH loc_oPagina.opt_4c_Pagos.Buttons(1)
536:             .Caption   = "Pagos"
537:             .Left      = 5
538:             .Top       = 5
539:             .AutoSize  = .T.
540:             .FontName  = "Tahoma"
541:             .FontSize  = 8
542:             .ForeColor = RGB(90, 90, 90)
543:             .BackStyle = 0
544:         ENDWITH
545:         WITH loc_oPagina.opt_4c_Pagos.Buttons(2)
546:             .Caption   = "N" + CHR(227) + "o Pagos"
547:             .Left      = 87
548:             .Top       = 5
549:             .AutoSize  = .T.
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .ForeColor = RGB(90, 90, 90)
553:             .BackStyle = 0
554:         ENDWITH
555:         WITH loc_oPagina.opt_4c_Pagos.Buttons(3)
556:             .Caption   = "Todos"
557:             .Left      = 200
558:             .Top       = 5
559:             .Height    = 15
560:             .Width     = 47
561:             .AutoSize  = .T.
562:             .FontName  = "Tahoma"
563:             .FontSize  = 8
564:             .ForeColor = RGB(90, 90, 90)
565:             .BackStyle = 0
566:         ENDWITH
567: 
568:         *-- OptionGroup Utilizacao (OptUtils: Top=164+29=193, Left=198, Width=268, Height=27)
569:         *-- 1=Utilizados, 2=Nao Utilizados, 3=Todos; default=1 (Utilizados) conforme legado
570:         loc_oPagina.AddObject("opt_4c_Utils", "OptionGroup")
571:         WITH loc_oPagina.opt_4c_Utils
572:             .ButtonCount = 3
573:             .BackStyle   = 0
574:             .BorderStyle = 0
575:             .Top         = 193
576:             .Left        = 198
577:             .Width       = 268
578:             .Height      = 27
579:             .Value       = 0
580:             .Visible     = .T.
581:         ENDWITH
582:         WITH loc_oPagina.opt_4c_Utils.Buttons(1)
583:             .Caption   = "Utilizados"
584:             .Left      = 5
585:             .Top       = 5
586:             .AutoSize  = .T.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .ForeColor = RGB(90, 90, 90)
590:             .BackStyle = 0
591:         ENDWITH
592:         WITH loc_oPagina.opt_4c_Utils.Buttons(2)
593:             .Caption   = "N" + CHR(227) + "o Utilizados"
594:             .Left      = 87
595:             .Top       = 5
596:             .AutoSize  = .T.
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .ForeColor = RGB(90, 90, 90)
600:             .BackStyle = 0
601:         ENDWITH
602:         WITH loc_oPagina.opt_4c_Utils.Buttons(3)
603:             .Caption   = "Todos"
604:             .Left      = 200
605:             .Top       = 5
606:             .Height    = 15
607:             .Width     = 47
608:             .AutoSize  = .T.
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .ForeColor = RGB(90, 90, 90)
612:             .BackStyle = 0
613:         ENDWITH
614: 
615:         THIS.TornarControlesVisiveis(loc_oPagina)
616:     ENDPROC
617: 
618:     *===========================================================================
619:     * CarregarLista - Busca registros de SigOpPed e vincula ao grid
620:     * CRITICO: RecordSource, ControlSource e Headers sempre re-definidos apos Buscar
621:     *===========================================================================
622:     PROCEDURE CarregarLista()
623:         LOCAL loc_lResultado, loc_oGrid
624:         loc_lResultado = .F.
625: 
626:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
627:             RETURN .T.
628:         ENDIF
629: 
630:         TRY
631:             loc_lResultado = THIS.this_oBusinessObject.Buscar("")
632: 
633:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
634:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
635: 
636:                 IF VARTYPE(loc_oGrid) = "O"
637:                     *-- RecordSource fora de WITH para garantir auto-bind imediato
638:                     loc_oGrid.ColumnCount = 4
639:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
640: 
641:                     *-- ControlSource re-definido APOS RecordSource (auto-bind sobrescreve)
642:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ndopes"
643:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dopes"
644:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.desc_pagos"
645:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.desc_utils"
646: 
647:                     *-- Larguras re-confirmadas
648:                     loc_oGrid.Column1.Width = 31
649:                     loc_oGrid.Column2.Width = 150
650:                     loc_oGrid.Column3.Width = 80
651:                     loc_oGrid.Column4.Width = 108
652: 
653:                     *-- Headers re-definidos APOS RecordSource (reset para nome do campo)
654:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
655:                     loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
656:                     loc_oGrid.Column3.Header1.Caption = "Pagamentos"
657:                     loc_oGrid.Column4.Header1.Caption = "Utilizados"
658: 
659:                     THIS.FormatarGridLista(loc_oGrid)
660:                     loc_oGrid.Refresh()
661:                 ENDIF
662:             ENDIF

*-- Linhas 674 a 1292:
674:     * FormatarGridLista - Formata visual do grid da lista
675:     * Grid sera adicionado na Fase 4
676:     *===========================================================================
677:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
678:         IF VARTYPE(par_oGrid) != "O"
679:             RETURN
680:         ENDIF
681:         WITH par_oGrid
682:             .FontName = "Tahoma"
683:             .FontSize = 8
684:         ENDWITH
685:     ENDPROC
686: 
687:     *===========================================================================
688:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
689:     * REGRA: Iterar Pages E Controls para PageFrames; passar container como param
690:     *===========================================================================
691:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
692:         LOCAL loc_nI, loc_oObjeto, loc_nP
693: 
694:         IF VARTYPE(par_oContainer) != "O"
695:             RETURN
696:         ENDIF
697: 
698:         FOR loc_nI = 1 TO par_oContainer.ControlCount
699:             loc_oObjeto = par_oContainer.Controls(loc_nI)
700: 
701:             IF VARTYPE(loc_oObjeto) = "O"
702:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
703:                     loc_oObjeto.Visible = .T.
704:                 ENDIF
705: 
706:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
707:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
708:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
709:                     ENDFOR
710:                 ENDIF
711: 
712:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
713:                    UPPER(loc_oObjeto.BaseClass) != "PAGEFRAME"
714:                     THIS.TornarControlesVisiveis(loc_oObjeto)
715:                 ENDIF
716:             ENDIF
717:         ENDFOR
718:     ENDPROC
719: 
720:     *===========================================================================
721:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
722:     * Quando volta para Page1 recarrega a lista para refletir mudancas
723:     *===========================================================================
724:     PROCEDURE AlternarPagina(par_nPagina)
725:         LOCAL loc_lResultado
726:         loc_lResultado = .F.
727: 
728:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
729:             RETURN .F.
730:         ENDIF
731: 
732:         TRY
733:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
734: 
735:             IF par_nPagina = 1
736:                 THIS.CarregarLista()
737:             ENDIF
738: 
739:             loc_lResultado = .T.
740:         CATCH TO loException
741:             MostrarErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, ;
742:                 "FormOpd.AlternarPagina")
743:         ENDTRY
744: 
745:         RETURN loc_lResultado
746:     ENDPROC
747: 
748:     *===========================================================================
749:     * BtnIncluirClick - Novo registro: limpa BO, vai para Page2 em modo INCLUIR
750:     *===========================================================================
751:     PROCEDURE BtnIncluirClick()
752:         TRY
753:             THIS.this_oBusinessObject.NovoRegistro()
754:             THIS.this_cModoAtual = "INCLUIR"
755:             THIS.LimparCampos()
756:             THIS.HabilitarCampos(.T.)
757:             THIS.AlternarPagina(2)
758:         CATCH TO loException
759:             MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, ;
760:                 "FormOpd.BtnIncluirClick")
761:         ENDTRY
762:     ENDPROC
763: 
764:     *===========================================================================
765:     * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
766:     *===========================================================================
767:     PROCEDURE BtnVisualizarClick()
768:         LOCAL loc_cDopes, loc_lPode
769:         loc_cDopes = ""
770:         loc_lPode  = .F.
771: 
772:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
773:             MsgAviso("Selecione um registro na lista.")
774:             RETURN
775:         ENDIF
776: 
777:         SELECT cursor_4c_Dados
778:         IF EOF("cursor_4c_Dados")
779:             MsgAviso("Selecione um registro na lista.")
780:             RETURN
781:         ENDIF
782: 
783:         loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
784: 
785:         TRY
786:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
787:                 THIS.this_cModoAtual = "VISUALIZAR"
788:                 THIS.BOParaForm()
789:                 THIS.HabilitarCampos(.F.)
790:                 loc_lPode = .T.
791:             ENDIF
792:         CATCH TO loException
793:             MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
794:                 "FormOpd.BtnVisualizarClick")
795:         ENDTRY
796: 
797:         IF loc_lPode
798:             THIS.AlternarPagina(2)
799:         ENDIF
800:     ENDPROC
801: 
802:     *===========================================================================
803:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
804:     * CarregarPorCodigo ja seta this_lNovoRegistro = .F.
805:     *===========================================================================
806:     PROCEDURE BtnAlterarClick()
807:         LOCAL loc_cDopes, loc_lPode
808:         loc_cDopes = ""
809:         loc_lPode  = .F.
810: 
811:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
812:             MsgAviso("Selecione um registro na lista.")
813:             RETURN
814:         ENDIF
815: 
816:         SELECT cursor_4c_Dados
817:         IF EOF("cursor_4c_Dados")
818:             MsgAviso("Selecione um registro na lista.")
819:             RETURN
820:         ENDIF
821: 
822:         loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
823: 
824:         TRY
825:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
826:                 THIS.this_oBusinessObject.EditarRegistro()
827:                 THIS.this_cModoAtual = "ALTERAR"
828:                 THIS.BOParaForm()
829:                 THIS.HabilitarCampos(.T.)
830:                 loc_lPode = .T.
831:             ENDIF
832:         CATCH TO loException
833:             MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
834:                 "FormOpd.BtnAlterarClick")
835:         ENDTRY
836: 
837:         IF loc_lPode
838:             THIS.AlternarPagina(2)
839:         ENDIF
840:     ENDPROC
841: 
842:     *===========================================================================
843:     * BtnExcluirClick - Confirma e exclui o registro selecionado
844:     *===========================================================================
845:     PROCEDURE BtnExcluirClick()
846:         LOCAL loc_cDopes, loc_lConfirmado, loc_lExcluido
847:         loc_cDopes      = ""
848:         loc_lConfirmado = .F.
849:         loc_lExcluido   = .F.
850: 
851:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
852:             MsgAviso("Selecione um registro na lista.")
853:             RETURN
854:         ENDIF
855: 
856:         SELECT cursor_4c_Dados
857:         IF EOF("cursor_4c_Dados")
858:             MsgAviso("Selecione um registro na lista.")
859:             RETURN
860:         ENDIF
861: 
862:         loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
863: 
864:         loc_lConfirmado = MsgConfirma("Confirma exclus" + CHR(227) + "o da opera" + ;
865:             CHR(231) + CHR(227) + "o '" + loc_cDopes + "'?", "Excluir")
866: 
867:         IF !loc_lConfirmado
868:             RETURN
869:         ENDIF
870: 
871:         TRY
872:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
873:                 loc_lExcluido = THIS.this_oBusinessObject.Excluir()
874:             ENDIF
875:         CATCH TO loException
876:             MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
877:                 "FormOpd.BtnExcluirClick")
878:         ENDTRY
879: 
880:         IF loc_lExcluido
881:             MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!")
882:             THIS.CarregarLista()
883:         ENDIF
884:     ENDPROC
885: 
886:     *===========================================================================
887:     * BtnBuscarClick - Recarrega lista (filtro de texto sera adicionado em fase posterior)
888:     *===========================================================================
889:     PROCEDURE BtnBuscarClick()
890:         TRY
891:             THIS.CarregarLista()
892:         CATCH TO loException
893:             MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
894:                 "FormOpd.BtnBuscarClick")
895:         ENDTRY
896:     ENDPROC
897: 
898:     *===========================================================================
899:     * BtnEncerrarClick - Fecha o formulario
900:     *===========================================================================
901:     PROCEDURE BtnEncerrarClick()
902:         THIS.Release()
903:     ENDPROC
904: 
905:     *===========================================================================
906:     * BtnSalvarClick - Delega validacao ao BO e salva o registro
907:     * Validacoes completas estao em OpdBO.ValidarDados():
908:     *   - Dopes nao vazio, tpagos >= 1, tutils >= 1, duplicata em INCLUIR
909:     *===========================================================================
910:     PROCEDURE BtnSalvarClick()
911:         LOCAL loc_lResultado
912:         loc_lResultado = .F.
913: 
914:         THIS.FormParaBO()
915: 
916:         TRY
917:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
918:         CATCH TO loException
919:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
920:                 "FormOpd.BtnSalvarClick")
921:         ENDTRY
922: 
923:         IF loc_lResultado
924:             MsgInfo("Registro salvo com sucesso!")
925:             THIS.this_cModoAtual = "LISTA"
926:             THIS.AlternarPagina(1)
927:         ENDIF
928:     ENDPROC
929: 
930:     *===========================================================================
931:     * BtnCancelarClick - Descarta alteracoes e volta para Page1 (lista)
932:     *===========================================================================
933:     PROCEDURE BtnCancelarClick()
934:         THIS.this_cModoAtual = "LISTA"
935:         THIS.AlternarPagina(1)
936:         THIS.CarregarLista()
937:     ENDPROC
938: 
939:     *===========================================================================
940:     * FormParaBO - Transfere valores do formulario para o BO
941:     *===========================================================================
942:     PROTECTED PROCEDURE FormParaBO()
943:         LOCAL loc_oPagina2
944:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
945: 
946:         IF VARTYPE(loc_oPagina2) != "O"
947:             RETURN
948:         ENDIF
949: 
950:         WITH THIS.this_oBusinessObject
951:             .this_nNdopes = loc_oPagina2.txt_4c_Nopes.Value
952:             .this_cDopes  = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)
953:             .this_nTpagos = loc_oPagina2.opt_4c_Pagos.Value
954:             .this_nTutils = loc_oPagina2.opt_4c_Utils.Value
955:         ENDWITH
956:     ENDPROC
957: 
958:     *===========================================================================
959:     * BOParaForm - Preenche campos do formulario a partir do BO
960:     *===========================================================================
961:     PROTECTED PROCEDURE BOParaForm()
962:         LOCAL loc_oPagina2
963:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
964: 
965:         IF VARTYPE(loc_oPagina2) != "O"
966:             RETURN
967:         ENDIF
968: 
969:         WITH THIS.this_oBusinessObject
970:             loc_oPagina2.txt_4c_Nopes.Value = .this_nNdopes
971:             loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(.this_cDopes)
972:             loc_oPagina2.opt_4c_Pagos.Value = .this_nTpagos
973:             loc_oPagina2.opt_4c_Utils.Value = .this_nTutils
974:         ENDWITH
975:     ENDPROC
976: 
977:     *===========================================================================
978:     * LimparCampos - Zera todos os campos da Page2
979:     *===========================================================================
980:     PROTECTED PROCEDURE LimparCampos()
981:         LOCAL loc_oPagina2
982:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
983: 
984:         IF VARTYPE(loc_oPagina2) != "O"
985:             RETURN
986:         ENDIF
987: 
988:         loc_oPagina2.txt_4c_Nopes.Value = 0
989:         loc_oPagina2.txt_4c_Dopes.Value = ""
990:         loc_oPagina2.opt_4c_Pagos.Value = 0
991:         loc_oPagina2.opt_4c_Utils.Value = 0
992:     ENDPROC
993: 
994:     *===========================================================================
995:     * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
996:     * Dopes (PK) somente editavel em INCLUIR; OptionGroups somente em INCLUIR/ALTERAR
997:     *===========================================================================
998:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
999:         LOCAL loc_oPagina2, loc_lModoEdicao
1000:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1001: 
1002:         IF VARTYPE(loc_oPagina2) != "O"
1003:             RETURN
1004:         ENDIF
1005: 
1006:         loc_lModoEdicao = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1007: 
1008:         *-- Nopes: habilitado sempre em INCLUIR/ALTERAR (codigo pode mudar)
1009:         loc_oPagina2.txt_4c_Nopes.ReadOnly = !loc_lModoEdicao
1010: 
1011:         *-- Dopes (PK): somente editavel em INCLUIR (nao altera PK)
1012:         loc_oPagina2.txt_4c_Dopes.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1013: 
1014:         *-- OptionGroups: somente em INCLUIR/ALTERAR
1015:         loc_oPagina2.opt_4c_Pagos.Enabled = loc_lModoEdicao
1016:         loc_oPagina2.opt_4c_Utils.Enabled = loc_lModoEdicao
1017: 
1018:         THIS.AjustarBotoesPorModo()
1019:     ENDPROC
1020: 
1021:     *===========================================================================
1022:     * AjustarBotoesPorModo - Habilita Confirmar somente em INCLUIR/ALTERAR
1023:     *===========================================================================
1024:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1025:         LOCAL loc_oPagina2
1026:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1027: 
1028:         IF VARTYPE(loc_oPagina2) != "O"
1029:             RETURN
1030:         ENDIF
1031:         IF VARTYPE(loc_oPagina2.cnt_4c_BotoesAcao) != "O"
1032:             RETURN
1033:         ENDIF
1034: 
1035:         LOCAL loc_lSalvar
1036:         loc_lSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1037: 
1038:         loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lSalvar
1039:         loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1040:     ENDPROC
1041: 
1042:     *===========================================================================
1043:     * ValidarNopes - Handler de LostFocus do txt_4c_Nopes
1044:     * Busca SigCdOpe por Dopes; se nao achar abre picker
1045:     *===========================================================================
1046:     PROCEDURE ValidarNopes(par_nKeyCode, par_nShiftAltCtrl)
1047:         LOCAL loc_oPagina2, loc_cDopes, loc_cSQL, loc_nRes
1048:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1049: 
1050:         IF VARTYPE(loc_oPagina2) != "O"
1051:             RETURN
1052:         ENDIF
1053: 
1054:         loc_cDopes = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)
1055: 
1056:         IF EMPTY(loc_cDopes)
1057:             RETURN
1058:         ENDIF
1059: 
1060:         TRY
1061:             loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Dopes = " + ;
1062:                 EscaparSQL(loc_cDopes)
1063:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaOpe")
1064: 
1065:             IF loc_nRes > 0 AND USED("cursor_4c_ValidaOpe") AND RECCOUNT("cursor_4c_ValidaOpe") > 0
1066:                 SELECT cursor_4c_ValidaOpe
1067:                 loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_ValidaOpe.Ndopes
1068:                 loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ValidaOpe.Dopes)
1069:                 IF USED("cursor_4c_ValidaOpe")
1070:                     USE IN cursor_4c_ValidaOpe
1071:                 ENDIF
1072:             ELSE
1073:                 IF USED("cursor_4c_ValidaOpe")
1074:                     USE IN cursor_4c_ValidaOpe
1075:                 ENDIF
1076:                 THIS.AbrirBuscaNopes()
1077:             ENDIF
1078: 
1079:         CATCH TO loException
1080:             IF USED("cursor_4c_ValidaOpe")
1081:                 USE IN cursor_4c_ValidaOpe
1082:             ENDIF
1083:             MostrarErro("Erro ao validar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1084:                 loException.Message, "FormOpd.ValidarNopes")
1085:         ENDTRY
1086:     ENDPROC
1087: 
1088:     *===========================================================================
1089:     * AbrirBuscaNopes - Abre picker de operacoes por codigo (SigCdOpe)
1090:     *===========================================================================
1091:     PROTECTED PROCEDURE AbrirBuscaNopes()
1092:         LOCAL loc_oPagina2, loc_cSQL, loc_nRes, loc_oBusca
1093:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1094: 
1095:         TRY
1096:             loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Ndopes"
1097:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
1098: 
1099:             IF loc_nRes >= 0
1100:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1101:                 IF VARTYPE(loc_oBusca) = "O"
1102:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
1103:                     loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1104:                     loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
1105:                     loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
1106:                     loc_oBusca.Show()
1107: 
1108:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1109:                         SELECT cursor_4c_BuscaOpe
1110:                         loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
1111:                         loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1112:                     ENDIF
1113:                     loc_oBusca.Release()
1114:                 ENDIF
1115:             ELSE
1116:                 MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1117:                     CapturarErroSQL(), "FormOpd.AbrirBuscaNopes")
1118:             ENDIF
1119: 
1120:         CATCH TO loException
1121:             MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
1122:                 "FormOpd.AbrirBuscaNopes")
1123:         ENDTRY
1124: 
1125:         IF USED("cursor_4c_BuscaOpe")
1126:             USE IN cursor_4c_BuscaOpe
1127:         ENDIF
1128:     ENDPROC
1129: 
1130:     *===========================================================================
1131:     * ValidarDopes - Handler de LostFocus do txt_4c_Dopes
1132:     * Busca SigCdOpe por Dopes (LIKE); match unico preenche auto; multiplos abre picker
1133:     *===========================================================================
1134:     PROCEDURE ValidarDopes(par_nKeyCode, par_nShiftAltCtrl)
1135:         LOCAL loc_oPagina2, loc_cDopes, loc_cSQL, loc_nRes
1136:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1137: 
1138:         IF VARTYPE(loc_oPagina2) != "O"
1139:             RETURN
1140:         ENDIF
1141: 
1142:         loc_cDopes = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)
1143: 
1144:         IF EMPTY(loc_cDopes)
1145:             loc_oPagina2.txt_4c_Nopes.Value = 0
1146:             RETURN
1147:         ENDIF
1148: 
1149:         TRY
1150:             loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Dopes LIKE " + ;
1151:                 EscaparSQL(loc_cDopes + "%") + " ORDER BY Dopes"
1152:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
1153: 
1154:             IF loc_nRes > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
1155:                 SELECT cursor_4c_BuscaOpe
1156:                 GO TOP
1157:                 IF RECCOUNT("cursor_4c_BuscaOpe") = 1
1158:                     loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
1159:                     loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1160:                     IF USED("cursor_4c_BuscaOpe")
1161:                         USE IN cursor_4c_BuscaOpe
1162:                     ENDIF
1163:                 ELSE
1164:                     THIS.AbrirBuscaDopes()
1165:                 ENDIF
1166:             ELSE
1167:                 IF USED("cursor_4c_BuscaOpe")
1168:                     USE IN cursor_4c_BuscaOpe
1169:                 ENDIF
1170:                 THIS.AbrirBuscaDopes()
1171:             ENDIF
1172: 
1173:         CATCH TO loException
1174:             IF USED("cursor_4c_BuscaOpe")
1175:                 USE IN cursor_4c_BuscaOpe
1176:             ENDIF
1177:             MostrarErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1178:                 loException.Message, "FormOpd.ValidarDopes")
1179:         ENDTRY
1180:     ENDPROC
1181: 
1182:     *===========================================================================
1183:     * AbrirBuscaDopes - Abre picker de operacoes por descricao (SigCdOpe)
1184:     * Reutiliza cursor_4c_BuscaOpe se ja existir (criado em ValidarDopes)
1185:     *===========================================================================
1186:     PROTECTED PROCEDURE AbrirBuscaDopes()
1187:         LOCAL loc_oPagina2, loc_cSQL, loc_nRes, loc_oBusca
1188:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1189: 
1190:         TRY
1191:             IF !USED("cursor_4c_BuscaOpe")
1192:                 loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Dopes"
1193:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
1194:                 IF loc_nRes < 0
1195:                     MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1196:                         CapturarErroSQL(), "FormOpd.AbrirBuscaDopes")
1197:                     RETURN
1198:                 ENDIF
1199:             ENDIF
1200: 
1201:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1202:             IF VARTYPE(loc_oBusca) = "O"
1203:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
1204:                 loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1205:                 loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
1206:                 loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
1207:                 loc_oBusca.Show()
1208: 
1209:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1210:                     SELECT cursor_4c_BuscaOpe
1211:                     loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
1212:                     loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1213:                 ENDIF
1214:                 loc_oBusca.Release()
1215:             ENDIF
1216: 
1217:         CATCH TO loException
1218:             MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
1219:                 "FormOpd.AbrirBuscaDopes")
1220:         ENDTRY
1221: 
1222:         IF USED("cursor_4c_BuscaOpe")
1223:             USE IN cursor_4c_BuscaOpe
1224:         ENDIF
1225:     ENDPROC
1226: 
1227:     *===========================================================================
1228:     * NopesKeyPress - Handler de KeyPress do txt_4c_Nopes (F4 abre picker)
1229:     * CRITICO: handler de BINDEVENT DEVE declarar parametros do evento
1230:     *===========================================================================
1231:     PROCEDURE NopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1232:         IF par_nKeyCode = 28  && F4
1233:             IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Nopes.ReadOnly
1234:                 THIS.AbrirBuscaNopes()
1235:             ENDIF
1236:         ENDIF
1237:     ENDPROC
1238: 
1239:     *===========================================================================
1240:     * NopesDblClick - Handler de DblClick do txt_4c_Nopes (abre picker)
1241:     *===========================================================================
1242:     PROCEDURE NopesDblClick()
1243:         IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Nopes.ReadOnly
1244:             THIS.AbrirBuscaNopes()
1245:         ENDIF
1246:     ENDPROC
1247: 
1248:     *===========================================================================
1249:     * DopesKeyPress - Handler de KeyPress do txt_4c_Dopes (F4 abre picker)
1250:     * CRITICO: handler de BINDEVENT DEVE declarar parametros do evento
1251:     *===========================================================================
1252:     PROCEDURE DopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1253:         IF par_nKeyCode = 28  && F4
1254:             IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.ReadOnly
1255:                 THIS.AbrirBuscaDopes()
1256:             ENDIF
1257:         ENDIF
1258:     ENDPROC
1259: 
1260:     *===========================================================================
1261:     * DopesDblClick - Handler de DblClick do txt_4c_Dopes (abre picker)
1262:     *===========================================================================
1263:     PROCEDURE DopesDblClick()
1264:         IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.ReadOnly
1265:             THIS.AbrirBuscaDopes()
1266:         ENDIF
1267:     ENDPROC
1268: 
1269:     *===========================================================================
1270:     * Destroy - Libera recursos ao fechar o formulario
1271:     *===========================================================================
1272:     PROCEDURE Destroy()
1273:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1274:             THIS.this_oBusinessObject = .NULL.
1275:         ENDIF
1276: 
1277:         IF USED("cursor_4c_Dados")
1278:             USE IN cursor_4c_Dados
1279:         ENDIF
1280: 
1281:         IF USED("cursor_4c_DadosTmp")
1282:             USE IN cursor_4c_DadosTmp
1283:         ENDIF
1284: 
1285:         IF USED("cursor_4c_BuscaOpe")
1286:             USE IN cursor_4c_BuscaOpe
1287:         ENDIF
1288: 
1289:         DODEFAULT()
1290:     ENDPROC
1291: 
1292: ENDDEFINE


### BO (C:\4c\projeto\app\classes\OpdBO.prg):
*==============================================================================
* OpdBO.prg - Business Object para Opera??es de Pedido (SigOpPed)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS OpdBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (mapeamento das colunas de SigOpPed)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && cidchaves char(20) - identificador interno
    this_cDopes     = ""   && dopes     char(20) - PK: descri��o da opera��o
    this_nNdopes    = 0    && ndopes    numeric(10,0) - c�digo num�rico
    this_nTpagos    = 0    && tpagos    numeric(10,0) - tipo pagamento (1=Pagos,2=N�o Pagos,3=Todos)
    this_nTutils    = 0    && tutils    numeric(10,0) - tipo utiliza��o (1=Utilizados,2=N�o Utilizados,3=Todos)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigOpPed"
                THIS.this_cCampoChave = "Dopes"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_nNdopes    = TratarNulo(ndopes,    "N")
                THIS.this_nTpagos    = TratarNulo(tpagos,   "N")
                THIS.this_nTutils    = TratarNulo(tutils,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "OpdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTpagos < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Pagamento!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTutils < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Utiliza" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDopesExistente(THIS.this_cDopes)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Cadastrada!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDopesExistente - Verifica se dopes ja existe em SigOpPed
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDopesExistente(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpPed" + ;
                " WHERE dopes = " + EscaparSQL(par_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpd")
                SELECT cursor_4c_ChkOpd
                loc_lExiste = (cursor_4c_ChkOpd.qtd > 0)
                USE IN cursor_4c_ChkOpd
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "OpdBO.VerificarDopesExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se nao definido (equivalente ao fUniqueIds() do legado)
            loc_cCidChaves = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cCidChaves)
                loc_cCidChaves = PADR(ALLTRIM(THIS.this_cDopes), 20)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpPed (cidchaves, dopes, ndopes, tpagos, tutils)
                VALUES (
                    <<EscaparSQL(PADR(loc_cCidChaves, 20))>>,
                    <<EscaparSQL(THIS.this_cDopes)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = loc_cCidChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigOpPed
    * Nota: dopes e a PK, nao pode ser alterado - apenas ndopes, tpagos, tutils
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpPed
                SET ndopes = <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    tpagos = <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    tutils = <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpPed WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ndopes, dopes, tpagos, tutils
    * Grid colunas 3 e 4 usam IIF no ControlSource para exibir texto
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ndopes N(10,0), dopes C(20), tpagos N(10,0), tutils N(10,0), desc_pagos C(20), desc_utils C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ndopes, dopes, tpagos, tutils," + ;
                    " CASE WHEN tpagos = 1 THEN 'Pagos'" + ;
                    " WHEN tpagos = 2 THEN 'Nao Pagos' ELSE 'Todos' END AS desc_pagos," + ;
                    " CASE WHEN tutils = 1 THEN 'Utilizados'" + ;
                    " WHEN tutils = 2 THEN 'Nao Utilizados' ELSE 'Todos' END AS desc_utils" + ;
                    " FROM SigOpPed"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ndopes"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpdBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, dopes, ndopes, tpagos, tutils" + ;
                " FROM SigOpPed WHERE dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

