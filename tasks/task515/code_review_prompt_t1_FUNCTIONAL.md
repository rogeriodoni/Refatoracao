# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarOrigem' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOrigem(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDestino' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDestino(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRss.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1115 linhas total):

*-- Linhas 22 a 149:
22:     *-- Propriedades da classe
23:     this_oBusinessObject          = .NULL.
24:     this_cModoAtual               = "LISTA"
25:     this_cUltimoOrigemValidada    = ""
26:     this_cUltimoDestinoValidado   = ""
27: 
28:     *--------------------------------------------------------------------------
29:     * Init - Inicializa o formulario via FormBase.Init()
30:     * CRITICO: Apenas DODEFAULT() - FormBase.Init() ja chama InicializarForm()
31:     *--------------------------------------------------------------------------
32:     PROCEDURE Init()
33:         LOCAL loc_lSucesso
34:         loc_lSucesso = .F.
35: 
36:         TRY
37:             loc_lSucesso = DODEFAULT()
38:         CATCH TO loc_oErro
39:             MsgErro("Erro ao iniciar FormRss:" + CHR(13) + loc_oErro.Message, "FormRss.Init")
40:         ENDTRY
41: 
42:         RETURN loc_lSucesso
43:     ENDPROC
44: 
45:     *--------------------------------------------------------------------------
46:     * InicializarForm - Chamado pelo FormBase.Init() automaticamente
47:     *--------------------------------------------------------------------------
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso
50:         loc_lSucesso = .F.
51: 
52:         TRY
53:             THIS.Caption = "Restri" + CHR(231) + CHR(227) + "o de Setores"
54: 
55:             THIS.this_oBusinessObject = CREATEOBJECT("RssBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
58:                 MsgErro("Erro ao criar RssBO.", "FormRss.InicializarForm")
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
63:                     IF !THIS.CarregarLista()
64:                         *-- Falha ao carregar nao impede abertura
65:                     ENDIF
66:                 ENDIF
67: 
68:                 THIS.pgf_4c_Paginas.Visible = .T.
69:                 THIS.pgf_4c_Paginas.ActivePage = 1
70:                 THIS.this_cModoAtual           = "LISTA"
71:                 loc_lSucesso                   = .T.
72:             ENDIF
73: 
74:         CATCH TO loc_oErro
75:             MsgErro("Erro ao inicializar FormRss:" + CHR(13) + loc_oErro.Message, "FormRss.InicializarForm")
76:         ENDTRY
77: 
78:         RETURN loc_lSucesso
79:     ENDPROC
80: 
81:     *--------------------------------------------------------------------------
82:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
83:     * PageFrame.Top = -29 para ocultar abas; containers compensam com +29
84:     *--------------------------------------------------------------------------
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 29
93:             .Tabs      = .F.
94:             .Visible   = .T.
95:             .Page1.BackColor = RGB(53, 53, 53)
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page2.BackColor = RGB(53, 53, 53)
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()
102:         THIS.ConfigurarPaginaDados()
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     * ConfigurarPaginaLista - Page1 completa: cabecalho, botoes CRUD e grid
107:     * Grid colunas: grupoos (Grupo Origem), grupods (Grupo Destino)
108:     *--------------------------------------------------------------------------
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina, loc_cIcones
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
114:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115:         loc_cIcones = gc_4c_CaminhoIcones
116: 
117:         *-- Container cabecalho escuro com titulo
118:         *-- cntSombra.Top=2 no legado + compensacao +29 = Top=31
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128: 
129:             .AddObject("lbl_4c_Sombra", "Label")
130:             WITH .lbl_4c_Sombra
131:                 .Caption   = "Restri" + CHR(231) + CHR(227) + "o de Setores"
132:                 .Top       = 15
133:                 .Left      = 10
134:                 .Width     = THIS.Width
135:                 .Height    = 40
136:                 .FontName  = "Tahoma"
137:                 .FontSize  = 16
138:                 .FontBold  = .T.
139:                 .ForeColor = RGB(0, 0, 0)
140:                 .BackStyle = 0
141:                 .Visible   = .T.
142:             ENDWITH
143: 
144:             .AddObject("lbl_4c_Titulo", "Label")
145:             WITH .lbl_4c_Titulo
146:                 .Caption   = "Restri" + CHR(231) + CHR(227) + "o de Setores"
147:                 .Top       = 18
148:                 .Left      = 10
149:                 .Width     = THIS.Width

*-- Linhas 344 a 402:
344:             .Column2.Width      = 786
345:         ENDWITH
346: 
347:         *-- BINDEVENT para todos os botoes (metodos devem ser PUBLIC)
348:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
349:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
352:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
353:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
354: 
355:         THIS.TornarControlesVisiveis(loc_oPagina)
356:     ENDPROC
357: 
358:     *--------------------------------------------------------------------------
359:     * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + campos Origem
360:     * Fase 5: lbl_4c_Say2, txt_4c_Origem, txt_4c_Dorigem com lookup SigCdGcr
361:     *--------------------------------------------------------------------------
362:     PROTECTED PROCEDURE ConfigurarPaginaDados()
363:         LOCAL loc_oPagina
364:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
365: 
366:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
367:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
368: 
369:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva do legado)
370:         *-- Top=4+29=33 (compensacao), Left=842, Width=160
371:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
372:         WITH loc_oPagina.cnt_4c_BotoesAcao
373:             .Top         = 33
374:             .Left        = 842
375:             .Width       = 160
376:             .Height      = 85
377:             .BackStyle   = 0
378:             .BorderWidth = 0
379:             .Visible     = .T.
380: 
381:             .AddObject("cmd_4c_Confirmar", "CommandButton")
382:             WITH .cmd_4c_Confirmar
383:                 .Caption         = "Confirmar"
384:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
385:                 .PicturePosition = 13
386:                 .Top             = 5
387:                 .Left            = 5
388:                 .Width           = 75
389:                 .Height          = 75
390:                 .BackColor       = RGB(255, 255, 255)
391:                 .ForeColor       = RGB(90, 90, 90)
392:                 .FontName        = "Comic Sans MS"
393:                 .FontBold        = .T.
394:                 .FontItalic      = .T.
395:                 .FontSize        = 8
396:                 .SpecialEffect   = 0
397:                 .MousePointer    = 15
398:                 .WordWrap        = .T.
399:                 .Visible         = .T.
400:             ENDWITH
401: 
402:             .AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 422 a 466:
422:             ENDWITH
423:         ENDWITH
424: 
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
426:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
427: 
428:         *-- Label e TextBoxes para Grupo Origem (Say2, Get_Origem, Get_Dorigem)
429:         *-- Say2 original: Top=140, Left=181 -> compensado Top=169
430:         *-- Get_Origem original: Top=138, Left=232, W=80, H=23 -> Top=167
431:         *-- Get_Dorigem original: Top=138, Left=314, W=193, H=23 -> Top=167
432: 
433:         loc_oPagina.AddObject("lbl_4c_Say2", "Label")
434:         WITH loc_oPagina.lbl_4c_Say2
435:             .Caption   = "Origem : "
436:             .Top       = 169
437:             .Left      = 181
438:             .Width     = 50
439:             .Height    = 17
440:             .FontName  = "Tahoma"
441:             .FontSize  = 8
442:             .BackStyle = 0
443:             .ForeColor = RGB(255, 255, 255)
444:             .Visible   = .T.
445:         ENDWITH
446: 
447:         loc_oPagina.AddObject("txt_4c_Origem", "TextBox")
448:         WITH loc_oPagina.txt_4c_Origem
449:             .Value     = ""
450:             .Top       = 167
451:             .Left      = 232
452:             .Width     = 80
453:             .Height    = 23
454:             .MaxLength = 15
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .BackColor = RGB(255, 255, 255)
458:             .ForeColor = RGB(90, 90, 90)
459:             .TabIndex  = 3
460:             .Visible   = .T.
461:         ENDWITH
462: 
463:         loc_oPagina.AddObject("txt_4c_Dorigem", "TextBox")
464:         WITH loc_oPagina.txt_4c_Dorigem
465:             .Value     = ""
466:             .Top       = 167

*-- Linhas 476 a 520:
476:             .Visible   = .T.
477:         ENDWITH
478: 
479:         BINDEVENT(loc_oPagina.txt_4c_Origem, "KeyPress", THIS, "ValidarOrigem")
480:         BINDEVENT(loc_oPagina.txt_4c_Origem, "KeyPress",  THIS, "OrigemKeyPress")
481: 
482:         *-- Label e TextBoxes para Grupo Destino (Say1, Get_Destino, Get_ddestino)
483:         *-- Say1 original: Top=176, Left=179 -> compensado Top=205
484:         *-- Get_Destino original: Top=174, Left=232, W=80, H=23 -> Top=203
485:         *-- Get_ddestino original: Top=174, Left=314, W=193, H=23 -> Top=203
486: 
487:         loc_oPagina.AddObject("lbl_4c_Say1", "Label")
488:         WITH loc_oPagina.lbl_4c_Say1
489:             .Caption   = "Destino : "
490:             .Top       = 205
491:             .Left      = 179
492:             .Width     = 52
493:             .Height    = 17
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .BackStyle = 0
497:             .ForeColor = RGB(255, 255, 255)
498:             .Visible   = .T.
499:         ENDWITH
500: 
501:         loc_oPagina.AddObject("txt_4c_Destino", "TextBox")
502:         WITH loc_oPagina.txt_4c_Destino
503:             .Value     = ""
504:             .Top       = 203
505:             .Left      = 232
506:             .Width     = 80
507:             .Height    = 23
508:             .MaxLength = 15
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .BackColor = RGB(255, 255, 255)
512:             .ForeColor = RGB(90, 90, 90)
513:             .TabIndex  = 5
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         loc_oPagina.AddObject("txt_4c_Ddestino", "TextBox")
518:         WITH loc_oPagina.txt_4c_Ddestino
519:             .Value     = ""
520:             .Top       = 203

*-- Linhas 530 a 1115:
530:             .Visible   = .T.
531:         ENDWITH
532: 
533:         BINDEVENT(loc_oPagina.txt_4c_Destino, "KeyPress", THIS, "ValidarDestino")
534:         BINDEVENT(loc_oPagina.txt_4c_Destino, "KeyPress",  THIS, "DestinoKeyPress")
535: 
536:         THIS.TornarControlesVisiveis(loc_oPagina)
537:     ENDPROC
538: 
539:     *--------------------------------------------------------------------------
540:     * CarregarLista - Busca dados e associa ao grid
541:     * Colunas cursor_4c_Dados: grupoos, grupods, cidchaves
542:     *--------------------------------------------------------------------------
543:     PROCEDURE CarregarLista()
544:         LOCAL loc_lResultado, loc_oGrid
545:         loc_lResultado = .F.
546: 
547:         TRY
548:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
549:                 loc_lResultado = .T.
550:             ELSE
551:                 IF THIS.this_oBusinessObject.Buscar("")
552:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
553: 
554:                     loc_oGrid.ColumnCount = 2
555:                     loc_oGrid.RecordSource             = "cursor_4c_Dados"
556:                     loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.grupoos"
557:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.grupods"
558: 
559:                     *-- OBRIGATORIO: Redefinir cabecalhos apos RecordSource (VFP9 reseta)
560:                     loc_oGrid.Column1.Header1.Caption  = "Grupo Origem"
561:                     loc_oGrid.Column2.Header1.Caption  = "Grupo Destino"
562: 
563:                     THIS.FormatarGridLista(loc_oGrid)
564:                     loc_lResultado = .T.
565:                 ENDIF
566:             ENDIF
567:         CATCH TO loc_oErro
568:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormRss.CarregarLista")
569:         ENDTRY
570: 
571:         RETURN loc_lResultado
572:     ENDPROC
573: 
574:     *--------------------------------------------------------------------------
575:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
576:     *--------------------------------------------------------------------------
577:     PROCEDURE AlternarPagina(par_nPagina)
578:         LOCAL loc_lResultado
579:         loc_lResultado = .F.
580: 
581:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
582:             RETURN .F.
583:         ENDIF
584: 
585:         TRY
586:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
587: 
588:             IF par_nPagina = 1
589:                 THIS.CarregarLista()
590:             ENDIF
591: 
592:             loc_lResultado = .T.
593:         CATCH TO loc_oErro
594:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormRss.AlternarPagina")
595:         ENDTRY
596: 
597:         RETURN loc_lResultado
598:     ENDPROC
599: 
600:     *--------------------------------------------------------------------------
601:     * FormParaBO - Transfere valores dos campos do form para o BO
602:     * Grupo Origem so editavel em INCLUIR; Grupo Destino em INCLUIR e ALTERAR
603:     *--------------------------------------------------------------------------
604:     PROTECTED PROCEDURE FormParaBO()
605:         LOCAL loc_oPagina2
606:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
607: 
608:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
609:             THIS.this_oBusinessObject.this_cGrupoos = ALLTRIM(loc_oPagina2.txt_4c_Origem.Value)
610:         ENDIF
611: 
612:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
613:             THIS.this_oBusinessObject.this_cGrupods = ALLTRIM(loc_oPagina2.txt_4c_Destino.Value)
614:         ENDIF
615:     ENDPROC
616: 
617:     *--------------------------------------------------------------------------
618:     * BOParaForm - Transfere valores do BO para os campos do form
619:     * Popula codigo e descricao de Origem e Destino
620:     *--------------------------------------------------------------------------
621:     PROTECTED PROCEDURE BOParaForm()
622:         LOCAL loc_oPagina2
623:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
624: 
625:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
626:             loc_oPagina2.txt_4c_Origem.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoos)
627:         ENDIF
628: 
629:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
630:             loc_oPagina2.txt_4c_Destino.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupods)
631:         ENDIF
632: 
633:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
634:             loc_oPagina2.txt_4c_Dorigem.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescOrigem)
635:         ENDIF
636: 
637:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
638:             loc_oPagina2.txt_4c_Ddestino.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescDestino)
639:         ENDIF
640:     ENDPROC
641: 
642:     *--------------------------------------------------------------------------
643:     * LimparCampos - Limpa os campos da Page2
644:     *--------------------------------------------------------------------------
645:     PROTECTED PROCEDURE LimparCampos()
646:         LOCAL loc_oPagina2
647:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
648: 
649:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
650:             loc_oPagina2.txt_4c_Origem.Value = ""
651:         ENDIF
652:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
653:             loc_oPagina2.txt_4c_Destino.Value = ""
654:         ENDIF
655:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
656:             loc_oPagina2.txt_4c_Dorigem.Value = ""
657:         ENDIF
658:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
659:             loc_oPagina2.txt_4c_Ddestino.Value = ""
660:         ENDIF
661:     ENDPROC
662: 
663:     *--------------------------------------------------------------------------
664:     * HabilitarCampos - Habilita/desabilita campos conforme modo
665:     * INCLUIR  : Origem=editavel, Destino=editavel
666:     * ALTERAR  : Origem=readonly, Destino=editavel (PK nao muda)
667:     * VISUALIZAR: ambos readonly
668:     *--------------------------------------------------------------------------
669:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
670:         LOCAL loc_oPagina2, loc_lOrigemEdit, loc_lDestinoEdit
671:         loc_oPagina2    = THIS.pgf_4c_Paginas.Page2
672:         loc_lOrigemEdit  = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
673:         loc_lDestinoEdit = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
674: 
675:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
676:             loc_oPagina2.txt_4c_Origem.ReadOnly = !loc_lOrigemEdit
677:         ENDIF
678:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
679:             loc_oPagina2.txt_4c_Destino.ReadOnly = !loc_lDestinoEdit
680:         ENDIF
681:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
682:             loc_oPagina2.txt_4c_Dorigem.ReadOnly = .T.
683:         ENDIF
684:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
685:             loc_oPagina2.txt_4c_Ddestino.ReadOnly = .T.
686:         ENDIF
687:     ENDPROC
688: 
689:     *--------------------------------------------------------------------------
690:     * AjustarBotoesPorModo - Ajusta Confirmar e Cancelar conforme modo
691:     * INCLUIR/ALTERAR: Confirmar enabled
692:     * VISUALIZAR     : Confirmar disabled
693:     *--------------------------------------------------------------------------
694:     PROTECTED PROCEDURE AjustarBotoesPorModo()
695:         LOCAL loc_oCnt
696:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
697:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
698:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
699:                 loc_oCnt.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
700:             ENDIF
701:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
702:                 loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
703:             ENDIF
704:         ENDIF
705:     ENDPROC
706: 
707:     *==========================================================================
708:     * HANDLERS DOS BOTOES - PUBLIC para funcionar com BINDEVENT
709:     *==========================================================================
710: 
711:     *--------------------------------------------------------------------------
712:     * BtnIncluirClick - Prepara formulario para incluir novo registro
713:     *--------------------------------------------------------------------------
714:     PROCEDURE BtnIncluirClick()
715:         THIS.this_oBusinessObject.NovoRegistro()
716:         THIS.LimparCampos()
717:         THIS.this_cModoAtual = "INCLUIR"
718:         THIS.HabilitarCampos(.T.)
719:         THIS.AjustarBotoesPorModo()
720:         THIS.AlternarPagina(2)
721:     ENDPROC
722: 
723:     *--------------------------------------------------------------------------
724:     * BtnVisualizarClick - Carrega registro selecionado em modo somente-leitura
725:     *--------------------------------------------------------------------------
726:     PROCEDURE BtnVisualizarClick()
727:         LOCAL loc_cChave
728:         loc_cChave = ""
729: 
730:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
731:             MsgAviso("Selecione um registro na lista.")
732:             RETURN
733:         ENDIF
734: 
735:         SELECT cursor_4c_Dados
736:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
737: 
738:         IF EMPTY(loc_cChave)
739:             MsgAviso("Selecione um registro na lista.")
740:             RETURN
741:         ENDIF
742: 
743:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
744:             THIS.this_cModoAtual = "VISUALIZAR"
745:             THIS.BOParaForm()
746:             THIS.HabilitarCampos(.F.)
747:             THIS.AjustarBotoesPorModo()
748:             THIS.AlternarPagina(2)
749:         ENDIF
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * BtnAlterarClick - Carrega registro selecionado para edicao
754:     * Grupo Origem nao pode ser alterado (faz parte da chave de negocio)
755:     *--------------------------------------------------------------------------
756:     PROCEDURE BtnAlterarClick()
757:         LOCAL loc_cChave
758:         loc_cChave = ""
759: 
760:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
761:             MsgAviso("Selecione um registro na lista.")
762:             RETURN
763:         ENDIF
764: 
765:         SELECT cursor_4c_Dados
766:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
767: 
768:         IF EMPTY(loc_cChave)
769:             MsgAviso("Selecione um registro na lista.")
770:             RETURN
771:         ENDIF
772: 
773:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
774:             THIS.this_oBusinessObject.EditarRegistro()
775:             THIS.this_cModoAtual = "ALTERAR"
776:             THIS.BOParaForm()
777:             THIS.HabilitarCampos(.T.)
778:             THIS.AjustarBotoesPorModo()
779:             THIS.AlternarPagina(2)
780:         ENDIF
781:     ENDPROC
782: 
783:     *--------------------------------------------------------------------------
784:     * BtnExcluirClick - Confirma e exclui registro selecionado
785:     *--------------------------------------------------------------------------
786:     PROCEDURE BtnExcluirClick()
787:         LOCAL loc_cChave, loc_lConfirma
788:         loc_cChave   = ""
789:         loc_lConfirma = .F.
790: 
791:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
792:             MsgAviso("Selecione um registro na lista.")
793:             RETURN
794:         ENDIF
795: 
796:         SELECT cursor_4c_Dados
797:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
798: 
799:         IF EMPTY(loc_cChave)
800:             MsgAviso("Selecione um registro na lista.")
801:             RETURN
802:         ENDIF
803: 
804:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
805:             "Confirmar Exclus" + CHR(227) + "o")
806: 
807:         IF loc_lConfirma
808:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
809:                 IF THIS.this_oBusinessObject.Excluir()
810:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
811:                     THIS.this_cModoAtual = "LISTA"
812:                     THIS.CarregarLista()
813:                 ENDIF
814:             ENDIF
815:         ENDIF
816:     ENDPROC
817: 
818:     *--------------------------------------------------------------------------
819:     * BtnBuscarClick - Recarrega lista com todos os registros
820:     *--------------------------------------------------------------------------
821:     PROCEDURE BtnBuscarClick()
822:         THIS.this_cModoAtual = "LISTA"
823:         THIS.CarregarLista()
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * BtnEncerrarClick - Fecha o formulario
828:     *--------------------------------------------------------------------------
829:     PROCEDURE BtnEncerrarClick()
830:         THIS.Release()
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * BtnSalvarClick - Salva o registro (Inserir ou Atualizar) via botao Confirmar
835:     *--------------------------------------------------------------------------
836:     PROCEDURE BtnSalvarClick()
837:         LOCAL loc_lSucesso
838:         loc_lSucesso = .F.
839: 
840:         THIS.FormParaBO()
841: 
842:         IF THIS.this_oBusinessObject.Salvar()
843:             MsgInfo("Registro salvo com sucesso.")
844:             THIS.this_cModoAtual = "LISTA"
845:             THIS.AlternarPagina(1)
846:             loc_lSucesso = .T.
847:         ENDIF
848: 
849:         RETURN loc_lSucesso
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * BtnCancelarClick - Cancela edicao e volta para a lista
854:     *--------------------------------------------------------------------------
855:     PROCEDURE BtnCancelarClick()
856:         THIS.this_cModoAtual = "LISTA"
857:         THIS.AlternarPagina(1)
858:     ENDPROC
859: 
860:     *--------------------------------------------------------------------------
861:     * FormatarGridLista - Formata visual do grid da lista
862:     *--------------------------------------------------------------------------
863:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
864:         WITH par_oGrid
865:             .FontName = "Tahoma"
866:             .FontSize = 8
867:         ENDWITH
868:     ENDPROC
869: 
870:     *--------------------------------------------------------------------------
871:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
872:     * REGRA: Iterar Pages de PageFrames e Controls de Containers
873:     *--------------------------------------------------------------------------
874:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
875:         LOCAL loc_nI, loc_oObjeto, loc_nP
876: 
877:         FOR loc_nI = 1 TO par_oContainer.ControlCount
878:             loc_oObjeto = par_oContainer.Controls(loc_nI)
879: 
880:             IF VARTYPE(loc_oObjeto) = "O"
881:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
882:                     loc_oObjeto.Visible = .T.
883:                 ENDIF
884: 
885:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
886:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
887:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
888:                     ENDFOR
889:                 ENDIF
890: 
891:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
892:                     THIS.TornarControlesVisiveis(loc_oObjeto)
893:                 ENDIF
894:             ENDIF
895:         ENDFOR
896:     ENDPROC
897: 
898:     *--------------------------------------------------------------------------
899:     * ValidarOrigem - LostFocus de txt_4c_Origem: valida codigo e busca descricao
900:     * Guard de repeticao via this_cUltimoOrigemValidada evita re-abertura do picker
901:     *--------------------------------------------------------------------------
902:     PROCEDURE ValidarOrigem(par_nKeyCode, par_nShiftAltCtrl)
903:         LOCAL loc_cGrupo, loc_oPagina2
904:         loc_cGrupo   = ""
905:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
906: 
907:         IF !PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
908:             RETURN
909:         ENDIF
910: 
911:         loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Origem.Value)
912: 
913:         IF loc_cGrupo == THIS.this_cUltimoOrigemValidada
914:             RETURN
915:         ENDIF
916:         THIS.this_cUltimoOrigemValidada = loc_cGrupo
917: 
918:         IF EMPTY(loc_cGrupo)
919:             IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
920:                 loc_oPagina2.txt_4c_Dorigem.Value = ""
921:             ENDIF
922:             RETURN
923:         ENDIF
924: 
925:         THIS.AbrirBuscaOrigem(loc_cGrupo)
926:     ENDPROC
927: 
928:     *--------------------------------------------------------------------------
929:     * OrigemKeyPress - Abre lookup de Origem ao pressionar F4 (nKeyCode=115)
930:     * BINDEVENT requer parametros declarados
931:     *--------------------------------------------------------------------------
932:     PROCEDURE OrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
933:         LOCAL loc_cGrupo, loc_oPagina2
934: 
935:         IF par_nKeyCode != 115
936:             RETURN
937:         ENDIF
938: 
939:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
940: 
941:         IF !PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
942:             RETURN
943:         ENDIF
944: 
945:         loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Origem.Value)
946:         THIS.AbrirBuscaOrigem(loc_cGrupo)
947:     ENDPROC
948: 
949:     *--------------------------------------------------------------------------
950:     * AbrirBuscaOrigem - Lookup de SigCdGcr por Codigos para o campo Origem
951:     * Preenche txt_4c_Origem (codigo) e txt_4c_Dorigem (descricao)
952:     * Usa BuscarDescricaoGrupo() do BO para obter descricao apos selecao
953:     *--------------------------------------------------------------------------
954:     PROCEDURE AbrirBuscaOrigem(par_cValor)
955:         LOCAL loc_oBusca, loc_oPagina2, loc_cCodigo, loc_cDesc
956:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
957:         loc_cCodigo  = ""
958:         loc_cDesc    = ""
959: 
960:         TRY
961:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
962:                 "SigCdGcr", "cursor_4c_BuscaOrigem", "Codigos", par_cValor, ;
963:                 "Grupo Origem")
964: 
965:             IF VARTYPE(loc_oBusca) = "O"
966:                 IF !loc_oBusca.this_lAchouRegistro
967:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
968:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
969:                     loc_oBusca.Show()
970:                 ENDIF
971: 
972:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
973:                     SELECT cursor_4c_BuscaOrigem
974:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaOrigem.Codigos)
975:                 ENDIF
976: 
977:                 loc_oBusca.Release()
978:             ENDIF
979:         CATCH TO loc_oErro
980:             MsgErro("Erro ao buscar Grupo Origem:" + CHR(13) + loc_oErro.Message, ;
981:                 "FormRss.AbrirBuscaOrigem")
982:         ENDTRY
983: 
984:         IF USED("cursor_4c_BuscaOrigem")
985:             USE IN cursor_4c_BuscaOrigem
986:         ENDIF
987: 
988:         IF !EMPTY(loc_cCodigo)
989:             loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cCodigo)
990:         ENDIF
991: 
992:         THIS.this_cUltimoOrigemValidada = loc_cCodigo
993: 
994:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
995:             loc_oPagina2.txt_4c_Origem.Value = loc_cCodigo
996:         ENDIF
997:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
998:             loc_oPagina2.txt_4c_Dorigem.Value = loc_cDesc
999:         ENDIF
1000:     ENDPROC
1001: 
1002:     *--------------------------------------------------------------------------
1003:     * ValidarDestino - LostFocus de txt_4c_Destino: valida codigo e busca descricao
1004:     * Guard de repeticao via this_cUltimoDestinoValidado evita re-abertura do picker
1005:     *--------------------------------------------------------------------------
1006:     PROCEDURE ValidarDestino(par_nKeyCode, par_nShiftAltCtrl)
1007:         LOCAL loc_cGrupo, loc_oPagina2
1008:         loc_cGrupo   = ""
1009:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1010: 
1011:         IF !PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
1012:             RETURN
1013:         ENDIF
1014: 
1015:         loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Destino.Value)
1016: 
1017:         IF loc_cGrupo == THIS.this_cUltimoDestinoValidado
1018:             RETURN
1019:         ENDIF
1020:         THIS.this_cUltimoDestinoValidado = loc_cGrupo
1021: 
1022:         IF EMPTY(loc_cGrupo)
1023:             IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
1024:                 loc_oPagina2.txt_4c_Ddestino.Value = ""
1025:             ENDIF
1026:             RETURN
1027:         ENDIF
1028: 
1029:         THIS.AbrirBuscaDestino(loc_cGrupo)
1030:     ENDPROC
1031: 
1032:     *--------------------------------------------------------------------------
1033:     * DestinoKeyPress - Abre lookup de Destino ao pressionar F4 (nKeyCode=115)
1034:     * BINDEVENT requer parametros declarados
1035:     *--------------------------------------------------------------------------
1036:     PROCEDURE DestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1037:         LOCAL loc_cGrupo, loc_oPagina2
1038: 
1039:         IF par_nKeyCode != 115
1040:             RETURN
1041:         ENDIF
1042: 
1043:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1044: 
1045:         IF !PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
1046:             RETURN
1047:         ENDIF
1048: 
1049:         loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Destino.Value)
1050:         THIS.AbrirBuscaDestino(loc_cGrupo)
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     * AbrirBuscaDestino - Lookup de SigCdGcr por Codigos para o campo Destino
1055:     * Preenche txt_4c_Destino (codigo) e txt_4c_Ddestino (descricao)
1056:     *--------------------------------------------------------------------------
1057:     PROCEDURE AbrirBuscaDestino(par_cValor)
1058:         LOCAL loc_oBusca, loc_oPagina2, loc_cCodigo, loc_cDesc
1059:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1060:         loc_cCodigo  = ""
1061:         loc_cDesc    = ""
1062: 
1063:         TRY
1064:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1065:                 "SigCdGcr", "cursor_4c_BuscaDestino", "Codigos", par_cValor, ;
1066:                 "Grupo Destino")
1067: 
1068:             IF VARTYPE(loc_oBusca) = "O"
1069:                 IF !loc_oBusca.this_lAchouRegistro
1070:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1071:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1072:                     loc_oBusca.Show()
1073:                 ENDIF
1074: 
1075:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDestino")
1076:                     SELECT cursor_4c_BuscaDestino
1077:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaDestino.Codigos)
1078:                 ENDIF
1079: 
1080:                 loc_oBusca.Release()
1081:             ENDIF
1082:         CATCH TO loc_oErro
1083:             MsgErro("Erro ao buscar Grupo Destino:" + CHR(13) + loc_oErro.Message, ;
1084:                 "FormRss.AbrirBuscaDestino")
1085:         ENDTRY
1086: 
1087:         IF USED("cursor_4c_BuscaDestino")
1088:             USE IN cursor_4c_BuscaDestino
1089:         ENDIF
1090: 
1091:         IF !EMPTY(loc_cCodigo)
1092:             loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cCodigo)
1093:         ENDIF
1094: 
1095:         THIS.this_cUltimoDestinoValidado = loc_cCodigo
1096: 
1097:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
1098:             loc_oPagina2.txt_4c_Destino.Value = loc_cCodigo
1099:         ENDIF
1100:         IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
1101:             loc_oPagina2.txt_4c_Ddestino.Value = loc_cDesc
1102:         ENDIF
1103:     ENDPROC
1104: 
1105:     *--------------------------------------------------------------------------
1106:     * Destroy - Libera recursos ao fechar o formulario
1107:     *--------------------------------------------------------------------------
1108:     PROCEDURE Destroy()
1109:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1110:             THIS.this_oBusinessObject = .NULL.
1111:         ENDIF
1112:         DODEFAULT()
1113:     ENDPROC
1114: 
1115: ENDDEFINE


### BO (C:\4c\projeto\app\classes\RssBO.prg):
*==============================================================================
* RssBO.prg - Business Object para Restricao de Setores (SigCdRps)
* Tabela principal: SigCdRps
* Chave primaria : cidchaves (char 20, gerada por fUniqueIds())
*==============================================================================

DEFINE CLASS RssBO AS BusinessBase

    *-- Propriedades mapeadas para colunas de SigCdRps
    this_cCidChaves = ""        && cidchaves char(20) - PK
    this_cGrupoos   = ""        && grupoos   char(10) - Grupo Origem (FK SigCdGcr.codigos)
    this_cGrupods   = ""        && grupods   char(10) - Grupo Destino (FK SigCdGcr.codigos)
    this_cUsuars    = ""        && usuars    char(10) - usuario
    this_dDatars    = {}        && datars    datetime - data/hora do registro

    *-- Propriedades auxiliares para exibicao (lookup SigCdGcr.descrs)
    this_cDescOrigem  = ""      && descricao do Grupo Origem
    this_cDescDestino = ""      && descricao do Grupo Destino

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRps"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades da entidade
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves    = ""
        THIS.this_cGrupoos      = ""
        THIS.this_cGrupods      = ""
        THIS.this_cUsuars       = ""
        THIS.this_dDatars       = {}
        THIS.this_cDescOrigem   = ""
        THIS.this_cDescDestino  = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves   = TratarNulo(cidchaves, "C")
                THIS.this_cGrupoos     = TratarNulo(grupoos,   "C")
                THIS.this_cGrupods     = TratarNulo(grupods,   "C")
                THIS.this_cUsuars      = TratarNulo(usuars,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupoos))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Origem.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cGrupods))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Destino.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Grupo Origem , Grupo Destino j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se par (grupoos + grupods) ja existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRps" + ;
                " WHERE grupoos = " + EscaparSQL(THIS.this_cGrupoos) + ;
                " AND   grupods = " + EscaparSQL(THIS.this_cGrupods)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RssBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave", ;
                "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RssBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RssBO.Inserir")
            ELSE
                loc_cSQL = "INSERT INTO SigCdRps" + ;
                    " (cidchaves, grupoos, grupods, datars, usuars)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                    EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                    EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(gc_4c_UsuarioLogado)  + ;
                    ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RssBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRps SET" + ;
                " grupoos = " + EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                " grupods = " + EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                " datars  = GETDATE(), " + ;
                " usuars  = " + EscaparSQL(gc_4c_UsuarioLogado)  + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RssBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRps WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RssBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca todos os registros para o grid da lista
    * Colunas do grid: grupoos (Grupo Origem), grupods (Grupo Destino)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        grupoos   C(10), ;
                        grupods   C(10), ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupoos, grupods, cidchaves" + ;
                    " FROM SigCdRps"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupoos, grupods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RssBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupoos, grupods, usuars, datars" + ;
                " FROM SigCdRps WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarDescricaoGrupo - Busca descricao de um grupo em SigCdGcr
    * Retorna a descricao ou string vazia se nao encontrado
    *==========================================================================
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescrs
        loc_cDescrs = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(par_cCodigo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    IF !EOF("cursor_4c_BuscaGcr")
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGcr
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do grupo:" + ;
                CHR(13) + loc_oErro.Message, "RssBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescrs
    ENDPROC

ENDDEFINE

