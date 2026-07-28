# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSetor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSetor(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCES.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1191 linhas total):

*-- Linhas 25 a 142:
25:     *==========================================================================
26:     * Init
27:     *==========================================================================
28:     PROCEDURE Init()
29:         LOCAL loc_lResultado
30:         loc_lResultado = .F.
31: 
32:         TRY
33:             loc_lResultado = DODEFAULT()
34:         CATCH TO loException
35:             MsgErro("Erro em FormCES.Init:" + CHR(13) + loException.Message, "Erro")
36:         ENDTRY
37: 
38:         RETURN loc_lResultado
39:     ENDPROC
40: 
41:     *==========================================================================
42:     * InicializarForm - Chamado pelo FormBase.Init()
43:     *==========================================================================
44:     PROTECTED PROCEDURE InicializarForm()
45:         LOCAL loc_lResultado
46:         loc_lResultado = .F.
47: 
48:         TRY
49:             THIS.this_oBusinessObject = CREATEOBJECT("CESBO")
50: 
51:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
52:                 MsgErro("Erro ao criar CESBO", "Erro")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65:                 loc_lResultado = .T.
66:             ENDIF
67:         CATCH TO loException
68:             MsgErro("Erro em FormCES.InicializarForm:" + CHR(13) + loException.Message, "Erro")
69:         ENDTRY
70: 
71:         RETURN loc_lResultado
72:     ENDPROC
73: 
74:     *==========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com 2 p&#225;ginas
76:     *==========================================================================
77:     PROTECTED PROCEDURE ConfigurarPageFrame()
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79: 
80:         WITH THIS.pgf_4c_Paginas
81:             .Top       = -29
82:             .Left      = 0
83:             .Width     = THIS.Width
84:             .Height    = THIS.Height + 29
85:             .PageCount = 2
86:             .Tabs      = .F.
87:             .Visible   = .T.
88: 
89:             .Page1.Caption   = "Lista"
90:             .Page1.BackColor = RGB(255, 255, 255)
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92: 
93:             .Page2.Caption   = "Dados"
94:             .Page2.BackColor = RGB(255, 255, 255)
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:         ENDWITH
97:     ENDPROC
98: 
99:     *==========================================================================
100:     * ConfigurarPaginaLista - Page1: cabe&#231;alho + containers de bot&#245;es
101:     *==========================================================================
102:     PROTECTED PROCEDURE ConfigurarPaginaLista()
103:         LOCAL loc_oPagina
104:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
105: 
106:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
107:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108: 
109:         *-- Cabe&#231;alho cinza escuro (cntSombra do legado)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 31
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
124:             .Top       = 15
125:             .Left      = 12
126:             .Width     = THIS.Width
127:             .Height    = 40
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .AutoSize  = .F.
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = THIS.Width

*-- Linhas 312 a 393:
312:             .Visible         = .T.
313:         ENDWITH
314: 
315:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
316: 
317:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
318:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
319:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
320:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
321:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
322: 
323:         *-- Grid de listagem: clacods, clagrupos, clacontas, setors
324:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
325:         WITH loc_oPagina.grd_4c_Lista
326:             .Top                = 127
327:             .Left               = 30
328:             .Width              = 939
329:             .Height             = 487
330:             .ColumnCount        = 4
331:             .FontName           = "Verdana"
332:             .FontSize           = 8
333:             .ForeColor          = RGB(90, 90, 90)
334:             .BackColor          = RGB(255, 255, 255)
335:             .GridLineColor      = RGB(238, 238, 238)
336:             .HighlightBackColor = RGB(255, 255, 255)
337:             .HighlightForeColor = RGB(15, 41, 104)
338:             .HighlightStyle     = 2
339:             .DeleteMark         = .F.
340:             .RecordMark         = .F.
341:             .RowHeight          = 16
342:             .ScrollBars         = 2
343:             .GridLines          = 3
344:             .Visible            = .T.
345:         ENDWITH
346: 
347:         THIS.TornarControlesVisiveis(loc_oPagina)
348:     ENDPROC
349: 
350:     *==========================================================================
351:     * ConfigurarPaginaDados - Page2: container Salvar/Cancelar
352:     *==========================================================================
353:     PROTECTED PROCEDURE ConfigurarPaginaDados()
354:         LOCAL loc_oPagina
355:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
356: 
357:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
358:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
359: 
360:         *-- Container Salvar/Cancelar (Grupo_Salva do legado)
361:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
362:         WITH loc_oPagina.cnt_4c_Salva
363:             .Top         = 33
364:             .Left        = 842
365:             .Width       = 160
366:             .Height      = 85
367:             .BackStyle   = 0
368:             .Visible     = .T.
369:         ENDWITH
370: 
371:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
372:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
373:             .Caption         = "Confirmar"
374:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
375:             .PicturePosition = 13
376:             .Top             = 5
377:             .Left            = 5
378:             .Width           = 75
379:             .Height          = 75
380:             .BackColor       = RGB(255, 255, 255)
381:             .ForeColor       = RGB(90, 90, 90)
382:             .FontName        = "Comic Sans MS"
383:             .FontBold        = .T.
384:             .FontItalic      = .T.
385:             .FontSize        = 8
386:             .Themes          = .F.
387:             .SpecialEffect   = 0
388:             .MousePointer    = 15
389:             .WordWrap        = .T.
390:             .AutoSize        = .F.
391:             .Visible         = .T.
392:         ENDWITH
393: 

*-- Linhas 414 a 458:
414:             .Visible         = .T.
415:         ENDWITH
416: 
417:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
419: 
420:         *-- Label: C&#243;digo (Say2 do legado - Top=190+29=219, Left=411)
421:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
422:         WITH loc_oPagina.lbl_4c_Codigo
423:             .Caption   = "C" + CHR(243) + "digo :"
424:             .Top       = 219
425:             .Left      = 411
426:             .Width     = 60
427:             .Height    = 17
428:             .FontName  = "Tahoma"
429:             .FontSize  = 8
430:             .ForeColor = RGB(90, 90, 90)
431:             .BackStyle = 0
432:             .Alignment = 1
433:             .Visible   = .T.
434:         ENDWITH
435: 
436:         *-- TextBox: C&#243;digo (Get_codigo do legado - Top=186+29=215, Left=455, Width=132, Height=23)
437:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
438:         WITH loc_oPagina.txt_4c_Codigo
439:             .Value         = ""
440:             .Top           = 215
441:             .Left          = 455
442:             .Width         = 132
443:             .Height        = 23
444:             .FontName      = "Tahoma"
445:             .FontSize      = 8
446:             .ForeColor     = RGB(0, 0, 0)
447:             .BorderColor   = RGB(100, 100, 100)
448:             .SpecialEffect = 1
449:             .MaxLength     = 20
450:             .Visible       = .T.
451:         ENDWITH
452: 
453:         *-- Label: Grupo (Say1 do legado - Top=215+29=244, Left=415)
454:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
455:         WITH loc_oPagina.lbl_4c_Grupo
456:             .Caption   = "Grupo :"
457:             .Top       = 244
458:             .Left      = 415

*-- Linhas 484 a 1191:
484:             .Visible       = .T.
485:         ENDWITH
486: 
487:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
488:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")
489:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick",  THIS, "GrupoDblClick")
490: 
491:         *-- Label: Conta (Say3 do legado - Top=241+29=270, Left=415)
492:         loc_oPagina.AddObject("lbl_4c_Conta", "Label")
493:         WITH loc_oPagina.lbl_4c_Conta
494:             .Caption   = "Conta :"
495:             .Top       = 270
496:             .Left      = 415
497:             .Width     = 60
498:             .Height    = 17
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .ForeColor = RGB(90, 90, 90)
502:             .BackStyle = 0
503:             .Alignment = 1
504:             .Visible   = .T.
505:         ENDWITH
506: 
507:         *-- TextBox: Conta (get_Conta do legado - Top=236+29=265, Left=455, Width=80)
508:         *-- Lookup em SigCdCli (iclis) via LostFocus/F4/DblClick
509:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
510:         WITH loc_oPagina.txt_4c_Conta
511:             .Value         = ""
512:             .Top           = 265
513:             .Left          = 455
514:             .Width         = 80
515:             .Height        = 21
516:             .FontName      = "Tahoma"
517:             .FontSize      = 8
518:             .ForeColor     = RGB(0, 0, 0)
519:             .BorderColor   = RGB(100, 100, 100)
520:             .SpecialEffect = 1
521:             .MaxLength     = 15
522:             .Visible       = .T.
523:         ENDWITH
524: 
525:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
526:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress",  THIS, "ContaKeyPress")
527:         BINDEVENT(loc_oPagina.txt_4c_Conta, "DblClick",  THIS, "ContaDblClick")
528: 
529:         *-- Label: Setor (Say4 do legado - Top=265+29=294, Left=418)
530:         loc_oPagina.AddObject("lbl_4c_Setor", "Label")
531:         WITH loc_oPagina.lbl_4c_Setor
532:             .Caption   = "Setor :"
533:             .Top       = 294
534:             .Left      = 418
535:             .Width     = 60
536:             .Height    = 17
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .ForeColor = RGB(90, 90, 90)
540:             .BackStyle = 0
541:             .Alignment = 1
542:             .Visible   = .T.
543:         ENDWITH
544: 
545:         *-- TextBox: Setor (Get_Setor do legado - Top=261+29=290, Left=455, Width=80)
546:         *-- Lookup em SigCdGcr (Codigos) via LostFocus/F4/DblClick
547:         loc_oPagina.AddObject("txt_4c_Setor", "TextBox")
548:         WITH loc_oPagina.txt_4c_Setor
549:             .Value         = ""
550:             .Top           = 290
551:             .Left          = 455
552:             .Width         = 80
553:             .Height        = 21
554:             .FontName      = "Tahoma"
555:             .FontSize      = 8
556:             .ForeColor     = RGB(0, 0, 0)
557:             .BorderColor   = RGB(100, 100, 100)
558:             .SpecialEffect = 1
559:             .MaxLength     = 15
560:             .Visible       = .T.
561:         ENDWITH
562: 
563:         BINDEVENT(loc_oPagina.txt_4c_Setor, "KeyPress", THIS, "ValidarSetor")
564:         BINDEVENT(loc_oPagina.txt_4c_Setor, "KeyPress",  THIS, "SetorKeyPress")
565:         BINDEVENT(loc_oPagina.txt_4c_Setor, "DblClick",  THIS, "SetorDblClick")
566: 
567:         THIS.TornarControlesVisiveis(loc_oPagina)
568:     ENDPROC
569: 
570:     *==========================================================================
571:     * CarregarLista - Carrega dados no Grid (grid conectado na Fase 4)
572:     *==========================================================================
573:     PROCEDURE CarregarLista(par_cFiltro)
574:         LOCAL loc_lResultado, loc_oGrid
575:         loc_lResultado = .F.
576: 
577:         IF VARTYPE(par_cFiltro) <> "C"
578:             par_cFiltro = ""
579:         ENDIF
580: 
581:         TRY
582:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
583:                 loc_lResultado = .T.
584:             ELSE
585:                 IF THIS.this_oBusinessObject.Buscar(par_cFiltro)
586:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
587: 
588:                     loc_oGrid.ColumnCount = 4
589:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
590:                     loc_oGrid.ColumnCount  = 4
591: 
592:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.clacods"
593:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.clagrupos"
594:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.clacontas"
595:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.setors"
596: 
597:                     loc_oGrid.Column1.Width = 80
598:                     loc_oGrid.Column2.Width = 80
599:                     loc_oGrid.Column3.Width = 80
600:                     loc_oGrid.Column4.Width = 80
601: 
602:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
603:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
604:                     loc_oGrid.Column3.Header1.Caption = "Conta"
605:                     loc_oGrid.Column4.Header1.Caption = "Setor"
606: 
607:                     THIS.FormatarGridLista(loc_oGrid)
608:                     loc_lResultado = .T.
609:                 ENDIF
610:             ENDIF
611:         CATCH TO loException
612:             MsgErro("Erro em FormCES.CarregarLista:" + CHR(13) + loException.Message, "Erro")
613:         ENDTRY
614: 
615:         RETURN loc_lResultado
616:     ENDPROC
617: 
618:     *==========================================================================
619:     * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
620:     *==========================================================================
621:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
622:         LOCAL loc_lResultado
623:         loc_lResultado = .F.
624: 
625:         IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
626:             RETURN .F.
627:         ENDIF
628: 
629:         TRY
630:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
631: 
632:             IF par_nPagina = 1
633:                 THIS.CarregarLista()
634:             ENDIF
635: 
636:             loc_lResultado = .T.
637:         CATCH TO loException
638:             MsgErro("Erro em FormCES.AlternarPagina:" + CHR(13) + loException.Message, "Erro")
639:         ENDTRY
640: 
641:         RETURN loc_lResultado
642:     ENDPROC
643: 
644:     *==========================================================================
645:     * BtnEncerrarClick
646:     *==========================================================================
647:     PROCEDURE BtnEncerrarClick()
648:         THIS.Release()
649:     ENDPROC
650: 
651:     *==========================================================================
652:     * BtnCancelarClick - Descarta edi&#231;&#227;o e volta para a lista
653:     *==========================================================================
654:     PROCEDURE BtnCancelarClick()
655:         THIS.this_cModoAtual = "LISTA"
656:         THIS.AlternarPagina(1)
657:     ENDPROC
658: 
659:     *==========================================================================
660:     * TornarControlesVisiveis - Percorre controles recursivamente
661:     *==========================================================================
662:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
663:         LOCAL loc_nI, loc_oObjeto, loc_nP
664: 
665:         FOR loc_nI = 1 TO par_oContainer.ControlCount
666:             loc_oObjeto = par_oContainer.Controls(loc_nI)
667: 
668:             IF VARTYPE(loc_oObjeto) = "O"
669:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
670:                     loc_oObjeto.Visible = .T.
671:                 ENDIF
672: 
673:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
674:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
675:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
676:                     ENDFOR
677:                 ENDIF
678: 
679:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
680:                     THIS.TornarControlesVisiveis(loc_oObjeto)
681:                 ENDIF
682:             ENDIF
683:         ENDFOR
684:     ENDPROC
685: 
686:     *==========================================================================
687:     * FormatarGridLista - Fonte padr&#227;o Tahoma/8 para o grid
688:     *==========================================================================
689:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
690:         WITH par_oGrid
691:             .FontName = "Tahoma"
692:             .FontSize = 8
693:         ENDWITH
694:     ENDPROC
695: 
696:     *==========================================================================
697:     * BtnIncluirClick - Prepara modo INCLUIR e navega para Page2
698:     *==========================================================================
699:     PROCEDURE BtnIncluirClick()
700:         THIS.this_oBusinessObject.NovoRegistro()
701:         THIS.this_cModoAtual = "INCLUIR"
702:         THIS.LimparCampos()
703:         THIS.HabilitarCampos(.T.)
704:         THIS.AlternarPagina(2)
705:     ENDPROC
706: 
707:     *==========================================================================
708:     * BtnVisualizarClick - Carrega registro selecionado em modo somente-leitura
709:     *==========================================================================
710:     PROCEDURE BtnVisualizarClick()
711:         LOCAL loc_cChave
712:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
713:             MsgAviso("Selecione um registro na lista!", "Aten" + CHR(231) + CHR(227) + "o")
714:             RETURN
715:         ENDIF
716:         SELECT cursor_4c_Dados
717:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
718:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
719:             THIS.this_cModoAtual = "VISUALIZAR"
720:             THIS.BOParaForm()
721:             THIS.HabilitarCampos(.F.)
722:             THIS.AlternarPagina(2)
723:         ENDIF
724:     ENDPROC
725: 
726:     *==========================================================================
727:     * BtnAlterarClick - Carrega registro selecionado e habilita edicao
728:     *==========================================================================
729:     PROCEDURE BtnAlterarClick()
730:         LOCAL loc_cChave
731:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
732:             MsgAviso("Selecione um registro na lista!", "Aten" + CHR(231) + CHR(227) + "o")
733:             RETURN
734:         ENDIF
735:         SELECT cursor_4c_Dados
736:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
737:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
738:             THIS.this_oBusinessObject.EditarRegistro()
739:             THIS.this_cModoAtual = "ALTERAR"
740:             THIS.BOParaForm()
741:             THIS.HabilitarCampos(.T.)
742:             THIS.AlternarPagina(2)
743:         ENDIF
744:     ENDPROC
745: 
746:     *==========================================================================
747:     * BtnExcluirClick - Confirma e exclui o registro selecionado
748:     *==========================================================================
749:     PROCEDURE BtnExcluirClick()
750:         LOCAL loc_cChave
751:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
752:             MsgAviso("Selecione um registro na lista!", "Aten" + CHR(231) + CHR(227) + "o")
753:             RETURN
754:         ENDIF
755:         SELECT cursor_4c_Dados
756:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
757:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
758:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
759:                 IF THIS.this_oBusinessObject.Excluir()
760:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
761:                     THIS.CarregarLista()
762:                 ENDIF
763:             ENDIF
764:         ENDIF
765:     ENDPROC
766: 
767:     *==========================================================================
768:     * BtnBuscarClick - Abre FormBuscaAuxiliar e filtra a lista pelo codigo
769:     *==========================================================================
770:     PROCEDURE BtnBuscarClick()
771:         LOCAL loc_oBusca, loc_cFiltro, loc_cCodigo
772:         loc_cFiltro = ""
773: 
774:         TRY
775:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
776:                 "SigCdCle", "cursor_4c_BuscaCes", "clacods", "", ;
777:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o de Estoque")
778: 
779:             IF VARTYPE(loc_oBusca) = "O"
780:                 IF !loc_oBusca.this_lAchouRegistro
781:                     loc_oBusca.mAddColuna("clacods",   "", "C" + CHR(243) + "digo")
782:                     loc_oBusca.mAddColuna("clagrupos", "", "Grupo")
783:                     loc_oBusca.mAddColuna("clacontas", "", "Conta")
784:                     loc_oBusca.mAddColuna("setors",    "", "Setor")
785:                     loc_oBusca.Show()
786:                 ENDIF
787: 
788:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCes")
789:                     SELECT cursor_4c_BuscaCes
790:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCes.clacods)
791:                     IF !EMPTY(loc_cCodigo)
792:                         loc_cFiltro = "clacods = " + EscaparSQL(loc_cCodigo)
793:                     ENDIF
794:                 ENDIF
795: 
796:                 loc_oBusca.Release()
797:             ENDIF
798: 
799:             IF USED("cursor_4c_BuscaCes")
800:                 USE IN cursor_4c_BuscaCes
801:             ENDIF
802:         CATCH TO loException
803:             MsgErro("Erro em FormCES.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
804:         ENDTRY
805: 
806:         THIS.CarregarLista(loc_cFiltro)
807:     ENDPROC
808: 
809:     *==========================================================================
810:     * BtnSalvarClick - Salva o registro (botao Confirmar da Page2)
811:     * Valida&#231;&#227;o: Grupo n&#227;o pode ficar em branco (regra do legado)
812:     *==========================================================================
813:     PROCEDURE BtnSalvarClick()
814:         LOCAL loc_oPagina
815:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
816: 
817:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
818:             MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Aten" + CHR(231) + CHR(227) + "o")
819:             loc_oPagina.txt_4c_Grupo.SetFocus()
820:             RETURN
821:         ENDIF
822: 
823:         THIS.FormParaBO()
824:         IF THIS.this_oBusinessObject.Salvar()
825:             MsgInfo("Registro salvo com sucesso!", "Sucesso")
826:             THIS.this_cModoAtual = "LISTA"
827:             THIS.AlternarPagina(1)
828:         ENDIF
829:     ENDPROC
830: 
831:     *==========================================================================
832:     * FormParaBO - Transfere valores dos campos da Page2 para o BO
833:     *==========================================================================
834:     PROTECTED PROCEDURE FormParaBO()
835:         LOCAL loc_oPagina
836:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
837:         THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
838:         THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
839:         THIS.this_oBusinessObject.this_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
840:         THIS.this_oBusinessObject.this_cSetor  = ALLTRIM(loc_oPagina.txt_4c_Setor.Value)
841:     ENDPROC
842: 
843:     *==========================================================================
844:     * BOParaForm - Transfere valores do BO para os campos da Page2
845:     *==========================================================================
846:     PROTECTED PROCEDURE BOParaForm()
847:         LOCAL loc_oPagina
848:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
849:         loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
850:         loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cGrupo)
851:         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
852:         loc_oPagina.txt_4c_Setor.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cSetor)
853:     ENDPROC
854: 
855:     *==========================================================================
856:     * LimparCampos - Limpa todos os campos da Page2
857:     *==========================================================================
858:     PROTECTED PROCEDURE LimparCampos()
859:         LOCAL loc_oPagina
860:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
861:         loc_oPagina.txt_4c_Codigo.Value = ""
862:         loc_oPagina.txt_4c_Grupo.Value  = ""
863:         loc_oPagina.txt_4c_Conta.Value  = ""
864:         loc_oPagina.txt_4c_Setor.Value  = ""
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
869:     * INCLUIR  -> Codigo, Grupo, Conta, Setor: editaveis
870:     * ALTERAR  -> Conta, Setor: editaveis; Codigo, Grupo: somente-leitura
871:     * VISUALIZAR/EXCLUIR -> todos somente-leitura
872:     *==========================================================================
873:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
874:         LOCAL loc_oPagina, loc_lEditarCodGrp, loc_lEditarContaSeto
875:         loc_oPagina          = THIS.pgf_4c_Paginas.Page2
876:         loc_lEditarCodGrp    = (THIS.this_cModoAtual = "INCLUIR")
877:         loc_lEditarContaSeto = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND par_lHabilitar
878: 
879:         loc_oPagina.txt_4c_Codigo.ReadOnly = !loc_lEditarCodGrp
880:         loc_oPagina.txt_4c_Grupo.ReadOnly  = !loc_lEditarCodGrp
881:         loc_oPagina.txt_4c_Conta.ReadOnly  = !loc_lEditarContaSeto
882:         loc_oPagina.txt_4c_Setor.ReadOnly  = !loc_lEditarContaSeto
883: 
884:         loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditarContaSeto OR loc_lEditarCodGrp
885:         loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
886:     ENDPROC
887: 
888:     *==========================================================================
889:     * ValidarGrupo - Lookup em SigCdGcr (LostFocus de txt_4c_Grupo)
890:     * Original: Get_Grupo.Valid com fwBuscaExt em SigCdGcr/Codigos
891:     *==========================================================================
892:     PROCEDURE ValidarGrupo()
893:         LOCAL loc_oPagina, loc_cGrupo, loc_oBusca
894:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
895:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
896: 
897:         IF EMPTY(loc_cGrupo)
898:             RETURN
899:         ENDIF
900: 
901:         TRY
902:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
903:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
904:                 "Grupos")
905: 
906:             IF VARTYPE(loc_oBusca) = "O"
907:                 IF !loc_oBusca.this_lAchouRegistro
908:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
909:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
910:                     loc_oBusca.Show()
911:                 ENDIF
912: 
913:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
914:                     SELECT cursor_4c_BuscaGrupo
915:                     loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
916:                 ENDIF
917: 
918:                 loc_oBusca.Release()
919:             ENDIF
920: 
921:             IF USED("cursor_4c_BuscaGrupo")
922:                 USE IN cursor_4c_BuscaGrupo
923:             ENDIF
924:         CATCH TO loException
925:             MsgErro("Erro em FormCES.ValidarGrupo:" + CHR(13) + loException.Message, "Erro")
926:         ENDTRY
927:     ENDPROC
928: 
929:     *==========================================================================
930:     * GrupoKeyPress / GrupoDblClick / AbrirLookupGrupo
931:     * Lookup em SigCdGcr via F4 e DblClick
932:     *==========================================================================
933:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
934:         IF par_nKeyCode = 28  && F4
935:             THIS.AbrirLookupGrupo()
936:         ENDIF
937:     ENDPROC
938: 
939:     PROCEDURE GrupoDblClick()
940:         THIS.AbrirLookupGrupo()
941:     ENDPROC
942: 
943:     PROCEDURE AbrirLookupGrupo()
944:         LOCAL loc_oPagina, loc_cGrupo, loc_oBusca
945:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
946:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
947: 
948:         IF loc_oPagina.txt_4c_Grupo.ReadOnly
949:             RETURN
950:         ENDIF
951: 
952:         TRY
953:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
954:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
955:                 "Grupos")
956: 
957:             IF VARTYPE(loc_oBusca) = "O"
958:                 IF !loc_oBusca.this_lAchouRegistro
959:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
960:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
961:                     loc_oBusca.Show()
962:                 ENDIF
963: 
964:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
965:                     SELECT cursor_4c_BuscaGrupo
966:                     loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
967:                 ENDIF
968: 
969:                 loc_oBusca.Release()
970:             ENDIF
971: 
972:             IF USED("cursor_4c_BuscaGrupo")
973:                 USE IN cursor_4c_BuscaGrupo
974:             ENDIF
975:         CATCH TO loException
976:             MsgErro("Erro em FormCES.AbrirLookupGrupo:" + CHR(13) + loException.Message, "Erro")
977:         ENDTRY
978:     ENDPROC
979: 
980:     *==========================================================================
981:     * ValidarConta - LostFocus: lookup em SigCdCli (iclis/rclis/grupos)
982:     * Original: get_Conta.Valid com fwBuscaExt em SigCdCli/iclis
983:     *==========================================================================
984:     PROCEDURE ValidarConta()
985:         LOCAL loc_oPagina, loc_cConta, loc_oBusca
986:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
987:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
988: 
989:         IF EMPTY(loc_cConta)
990:             RETURN
991:         ENDIF
992: 
993:         TRY
994:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
995:                 "SigCdCli", "cursor_4c_BuscaConta", "iclis", loc_cConta, ;
996:                 "Contas")
997: 
998:             IF VARTYPE(loc_oBusca) = "O"
999:                 IF !loc_oBusca.this_lAchouRegistro
1000:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
1001:                     loc_oBusca.mAddColuna("rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
1002:                     loc_oBusca.mAddColuna("grupos", "", "Grupo")
1003:                     loc_oBusca.Show()
1004:                 ENDIF
1005: 
1006:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1007:                     SELECT cursor_4c_BuscaConta
1008:                     loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
1009:                 ENDIF
1010: 
1011:                 loc_oBusca.Release()
1012:             ENDIF
1013: 
1014:             IF USED("cursor_4c_BuscaConta")
1015:                 USE IN cursor_4c_BuscaConta
1016:             ENDIF
1017:         CATCH TO loException
1018:             MsgErro("Erro em FormCES.ValidarConta:" + CHR(13) + loException.Message, "Erro")
1019:         ENDTRY
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * ContaKeyPress / ContaDblClick / AbrirLookupConta
1024:     * Lookup em SigCdCli via F4 e DblClick
1025:     *==========================================================================
1026:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1027:         IF par_nKeyCode = 28  && F4
1028:             THIS.AbrirLookupConta()
1029:         ENDIF
1030:     ENDPROC
1031: 
1032:     PROCEDURE ContaDblClick()
1033:         THIS.AbrirLookupConta()
1034:     ENDPROC
1035: 
1036:     PROCEDURE AbrirLookupConta()
1037:         LOCAL loc_oPagina, loc_cConta, loc_oBusca
1038:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1039:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1040: 
1041:         IF loc_oPagina.txt_4c_Conta.ReadOnly
1042:             RETURN
1043:         ENDIF
1044: 
1045:         TRY
1046:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1047:                 "SigCdCli", "cursor_4c_BuscaConta", "iclis", loc_cConta, ;
1048:                 "Contas")
1049: 
1050:             IF VARTYPE(loc_oBusca) = "O"
1051:                 IF !loc_oBusca.this_lAchouRegistro
1052:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
1053:                     loc_oBusca.mAddColuna("rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
1054:                     loc_oBusca.mAddColuna("grupos", "", "Grupo")
1055:                     loc_oBusca.Show()
1056:                 ENDIF
1057: 
1058:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1059:                     SELECT cursor_4c_BuscaConta
1060:                     loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
1061:                 ENDIF
1062: 
1063:                 loc_oBusca.Release()
1064:             ENDIF
1065: 
1066:             IF USED("cursor_4c_BuscaConta")
1067:                 USE IN cursor_4c_BuscaConta
1068:             ENDIF
1069:         CATCH TO loException
1070:             MsgErro("Erro em FormCES.AbrirLookupConta:" + CHR(13) + loException.Message, "Erro")
1071:         ENDTRY
1072:     ENDPROC
1073: 
1074:     *==========================================================================
1075:     * ValidarSetor - LostFocus: lookup em SigCdGcr (Codigos/Descrs)
1076:     * Original: Get_Setor.Valid com fwBuscaExt em SigCdGcr/Codigos
1077:     *==========================================================================
1078:     PROCEDURE ValidarSetor()
1079:         LOCAL loc_oPagina, loc_cSetor, loc_oBusca
1080:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1081:         loc_cSetor  = ALLTRIM(loc_oPagina.txt_4c_Setor.Value)
1082: 
1083:         IF EMPTY(loc_cSetor)
1084:             RETURN
1085:         ENDIF
1086: 
1087:         TRY
1088:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1089:                 "SigCdGcr", "cursor_4c_BuscaSetor", "Codigos", loc_cSetor, ;
1090:                 "Grupos")
1091: 
1092:             IF VARTYPE(loc_oBusca) = "O"
1093:                 IF !loc_oBusca.this_lAchouRegistro
1094:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1095:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1096:                     loc_oBusca.Show()
1097:                 ENDIF
1098: 
1099:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSetor")
1100:                     SELECT cursor_4c_BuscaSetor
1101:                     loc_oPagina.txt_4c_Setor.Value = ALLTRIM(cursor_4c_BuscaSetor.Codigos)
1102:                 ENDIF
1103: 
1104:                 loc_oBusca.Release()
1105:             ENDIF
1106: 
1107:             IF USED("cursor_4c_BuscaSetor")
1108:                 USE IN cursor_4c_BuscaSetor
1109:             ENDIF
1110:         CATCH TO loException
1111:             MsgErro("Erro em FormCES.ValidarSetor:" + CHR(13) + loException.Message, "Erro")
1112:         ENDTRY
1113:     ENDPROC
1114: 
1115:     *==========================================================================
1116:     * SetorKeyPress / SetorDblClick / AbrirLookupSetor
1117:     * Lookup em SigCdGcr via F4 e DblClick
1118:     *==========================================================================
1119:     PROCEDURE SetorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1120:         IF par_nKeyCode = 28  && F4
1121:             THIS.AbrirLookupSetor()
1122:         ENDIF
1123:     ENDPROC
1124: 
1125:     PROCEDURE SetorDblClick()
1126:         THIS.AbrirLookupSetor()
1127:     ENDPROC
1128: 
1129:     PROCEDURE AbrirLookupSetor()
1130:         LOCAL loc_oPagina, loc_cSetor, loc_oBusca
1131:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1132:         loc_cSetor  = ALLTRIM(loc_oPagina.txt_4c_Setor.Value)
1133: 
1134:         IF loc_oPagina.txt_4c_Setor.ReadOnly
1135:             RETURN
1136:         ENDIF
1137: 
1138:         TRY
1139:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1140:                 "SigCdGcr", "cursor_4c_BuscaSetor", "Codigos", loc_cSetor, ;
1141:                 "Grupos")
1142: 
1143:             IF VARTYPE(loc_oBusca) = "O"
1144:                 IF !loc_oBusca.this_lAchouRegistro
1145:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1146:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1147:                     loc_oBusca.Show()
1148:                 ENDIF
1149: 
1150:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSetor")
1151:                     SELECT cursor_4c_BuscaSetor
1152:                     loc_oPagina.txt_4c_Setor.Value = ALLTRIM(cursor_4c_BuscaSetor.Codigos)
1153:                 ENDIF
1154: 
1155:                 loc_oBusca.Release()
1156:             ENDIF
1157: 
1158:             IF USED("cursor_4c_BuscaSetor")
1159:                 USE IN cursor_4c_BuscaSetor
1160:             ENDIF
1161:         CATCH TO loException
1162:             MsgErro("Erro em FormCES.AbrirLookupSetor:" + CHR(13) + loException.Message, "Erro")
1163:         ENDTRY
1164:     ENDPROC
1165: 
1166:     *==========================================================================
1167:     * AjustarBotoesPorModo - Habilita/desabilita botoes de Page2 conforme modo
1168:     *==========================================================================
1169:     PROCEDURE AjustarBotoesPorModo()
1170:         LOCAL loc_oSalva
1171:         loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
1172: 
1173:         TRY
1174:             loc_oSalva.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1175:             loc_oSalva.cmd_4c_Cancelar.Enabled  = .T.
1176:         CATCH TO loException
1177:             MsgErro("Erro em FormCES.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
1178:         ENDTRY
1179:     ENDPROC
1180: 
1181:     *==========================================================================
1182:     * Destroy - Libera recursos
1183:     *==========================================================================
1184:     PROCEDURE Destroy()
1185:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1186:             THIS.this_oBusinessObject = .NULL.
1187:         ENDIF
1188:         DODEFAULT()
1189:     ENDPROC
1190: 
1191: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CESBO.prg):
*==============================================================================
* CESBO.prg - Business Object para Classifica" + CHR(231) + CHR(227) + "o de Estoque
* Tabela: SigCdCle
* PK: cidchaves (char 20, gerada por fUniqueIds)
* Indice de busca: clacods (char 15)
*==============================================================================

DEFINE CLASS CESBO AS BusinessBase

    *-- Propriedades da tabela SigCdCle
    this_cChaveUnica = ""    && cidchaves char(20) - PK gerada por fUniqueIds
    this_cCodigo     = ""    && clacods   char(15) - C" + CHR(243) + "digo (indice de busca)
    this_cGrupo      = ""    && clagrupos char(10) - Grupo (FK SigCdGcr.Codigos)
    this_cConta      = ""    && clacontas char(10) - Conta (FK SigCdCli.iclis)
    this_cSetor      = ""    && setors    char(10) - Setor (FK SigCdGcr.Codigos)

    *==========================================================================
    * Init - Configura tabela e campo chave do BusinessBase
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCle"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna PK para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cChaveUnica
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia cursor -> propriedades (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaveUnica   = TratarNulo(cidchaves, "C")
            THIS.this_cCodigo       = TratarNulo(clacods,   "C")
            THIS.this_cGrupo        = TratarNulo(clagrupos, "C")
            THIS.this_cConta        = TratarNulo(clacontas, "C")
            THIS.this_cSetor        = TratarNulo(setors,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros (PUBLIC)
    * Inclui cidchaves no SELECT para que o Form possa carregar por PK
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, clacods, clagrupos, clacontas, setors" + ;
                       " FROM SigCdCle"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY clacods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PUBLIC)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, clacods, clagrupos, clacontas, setors" + ;
                       " FROM SigCdCle" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarDuplicata - Verifica duplicidade de clacods+clagrupos+clacontas
    * Reproduz ChkRegister('SigCdCle') do legado
    *==========================================================================
    FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata
        loc_lDuplicata = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdCle" + ;
                       " WHERE clacods   = " + EscaparSQL(THIS.this_cCodigo) + ;
                       "   AND clagrupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                       "   AND clacontas = " + EscaparSQL(THIS.this_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicata = (cursor_4c_Dup.total > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.VerificarDuplicata:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicata
    ENDFUNC

    *==========================================================================
    * Inserir - Inclui novo registro (PROTECTED)
    * cidchaves gerado por fUniqueIds(); valida grupo + duplicata antes
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cGrupo))
                MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.VerificarDuplicata()
                    MsgAviso("C" + CHR(243) + "digo, Grupo e Conta j" + CHR(225) + " Cadastrado!", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_cChaveUnica = fUniqueIds()

                    loc_cSQL = "INSERT INTO SigCdCle" + ;
                               " (cidchaves, clacods, clagrupos, clacontas, setors)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cChaveUnica) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)     + ", " + ;
                               EscaparSQL(THIS.this_cGrupo)      + ", " + ;
                               EscaparSQL(THIS.this_cConta)      + ", " + ;
                               EscaparSQL(THIS.this_cSetor)      + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao incluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF

                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * clacods e fixo ao alterar (desabilitado no legado em modo ALTERAR)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCle SET" + ;
                       " clagrupos = " + EscaparSQL(THIS.this_cGrupo) + "," + ;
                       " clacontas = " + EscaparSQL(THIS.this_cConta) + "," + ;
                       " setors    = " + EscaparSQL(THIS.this_cSetor) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Remove registro do banco (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCle" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

