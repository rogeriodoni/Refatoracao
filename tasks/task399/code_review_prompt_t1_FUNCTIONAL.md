# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoForm' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoForm(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaForm' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaForm(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDsp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1186 linhas total):

*-- Linhas 23 a 141:
23:     this_cModoAtual      = "LISTA"
24: 
25:     *==========================================================================
26:     * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
27:     *==========================================================================
28:     PROCEDURE Init()
29:         RETURN DODEFAULT()
30:     ENDPROC
31: 
32:     *==========================================================================
33:     * InicializarForm - Inicializa BO e estrutura do formulario
34:     *==========================================================================
35:     PROTECTED PROCEDURE InicializarForm()
36:         LOCAL loc_lSucesso
37:         loc_lSucesso = .F.
38: 
39:         TRY
40:             THIS.this_oBusinessObject = CREATEOBJECT("DspBO")
41: 
42:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
43:                 MostrarErro("Erro ao criar DspBO" + CHR(13) + ;
44:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
45:                     "FormDsp.InicializarForm")
46:             ELSE
47:                 THIS.ConfigurarPageFrame()
48: 
49:                 THIS.pgf_4c_Paginas.Visible    = .T.
50:                 THIS.pgf_4c_Paginas.ActivePage = 1
51:                 THIS.this_cModoAtual           = "LISTA"
52: 
53:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
54:                     THIS.CarregarLista()
55:                 ENDIF
56: 
57:                 loc_lSucesso = .T.
58:             ENDIF
59: 
60:         CATCH TO loc_oErro
61:             MostrarErro("Erro ao inicializar FormDsp:" + CHR(13) + ;
62:                 loc_oErro.Message + CHR(13) + ;
63:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
64:                 "FormDsp.InicializarForm")
65:         ENDTRY
66: 
67:         RETURN loc_lSucesso
68:     ENDPROC
69: 
70:     *==========================================================================
71:     * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
72:     *==========================================================================
73:     PROTECTED PROCEDURE ConfigurarPageFrame()
74:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
75: 
76:         WITH THIS.pgf_4c_Paginas
77:             .PageCount = 2
78:             .Top       = -29
79:             .Left      = 0
80:             .Width     = THIS.Width
81:             .Height    = THIS.Height + 29
82:             .Tabs      = .F.
83:             .Visible   = .T.
84: 
85:             .Page1.Caption   = "Lista"
86:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page1.BackColor = RGB(255, 255, 255)
88: 
89:             .Page2.Caption   = "Dados"
90:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
91:             .Page2.BackColor = RGB(255, 255, 255)
92:         ENDWITH
93: 
94:         THIS.ConfigurarPaginaLista()
95:         THIS.ConfigurarPaginaDados()
96:     ENDPROC
97: 
98:     *==========================================================================
99:     * ConfigurarPaginaLista - Configura Page1 (Lista - Grid + Botoes CRUD)
100:     *==========================================================================
101:     PROTECTED PROCEDURE ConfigurarPaginaLista()
102:         LOCAL loc_oPagina, loc_oGrd
103:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
104: 
105:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
106:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107: 
108:         *-- Container cabecalho (fundo escuro com titulo)
109:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
110:         WITH loc_oPagina.cnt_4c_Cabecalho
111:             .Top         = 31
112:             .Left        = 0
113:             .Width       = THIS.Width
114:             .Height      = 80
115:             .BackColor   = RGB(100, 100, 100)
116:             .BackStyle   = 1
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Top       = 15
124:             .Left      = 10
125:             .Width     = THIS.Width - 20
126:             .Height    = 40
127:             .Caption   = THIS.Caption
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
139:             .Top       = 18
140:             .Left      = 10
141:             .Width     = THIS.Width - 20

*-- Linhas 355 a 414:
355:             .Column5.Alignment = 2
356:         ENDWITH
357: 
358:         *-- BINDEVENTs dos botoes (PUBLIC handlers obrigatorio)
359:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
360:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
361:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
362:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
363:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
364:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
365: 
366:         THIS.TornarControlesVisiveis(loc_oPagina)
367:     ENDPROC
368: 
369:     *==========================================================================
370:     * ConfigurarPaginaDados - Configura Page2 (Dados - campos de edicao)
371:     * Fase 5: Botoes Salvar/Cancelar + secao Grupo (lbl + cd + ds)
372:     * Fase 6: Secao Conta + OptionGroup Tipo
373:     *==========================================================================
374:     PROTECTED PROCEDURE ConfigurarPaginaDados()
375:         LOCAL loc_oPagina
376:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
377: 
378:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
379:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
380: 
381:         *-- Container botoes acao (Grupo_Salva no legado: Left=842, Top=4+29=33)
382:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
383:         WITH loc_oPagina.cnt_4c_BotoesAcao
384:             .Top         = 33
385:             .Left        = 842
386:             .Width       = 160
387:             .Height      = 85
388:             .BackStyle   = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         *-- Botao Salvar (Salva no legado: Left=5, Top=5)
393:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
394:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
395:             .Caption         = "Salvar"
396:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
397:             .PicturePosition = 13
398:             .Top             = 5
399:             .Left            = 5
400:             .Width           = 75
401:             .Height          = 75
402:             .BackColor       = RGB(255, 255, 255)
403:             .ForeColor       = RGB(90, 90, 90)
404:             .FontName        = "Comic Sans MS"
405:             .FontSize        = 8
406:             .FontBold        = .T.
407:             .FontItalic      = .T.
408:             .Themes          = .F.
409:             .SpecialEffect   = 0
410:             .MousePointer    = 15
411:             .WordWrap        = .T.
412:             .AutoSize        = .F.
413:             .Visible         = .T.
414:         ENDWITH

*-- Linhas 437 a 481:
437:             .Visible         = .T.
438:         ENDWITH
439: 
440:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
441:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
442: 
443:         *======================================================================
444:         * SECAO GRUPO
445:         * Original: lbl_grupo.Top=172, get_cd_grupo.Top=168 -> comp +29
446:         *======================================================================
447: 
448:         *-- Label "Grupo :" (lbl_grupo no legado: Top=172, Left=148)
449:         loc_oPagina.AddObject("lbl_4c_lbl_grupo", "Label")
450:         WITH loc_oPagina.lbl_4c_lbl_grupo
451:             .Caption   = "Grupo :"
452:             .Top       = 201
453:             .Left      = 148
454:             .Width     = 38
455:             .Height    = 17
456:             .AutoSize  = .T.
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .ForeColor = RGB(90, 90, 90)
460:             .BackStyle = 0
461:             .Visible   = .T.
462:         ENDWITH
463: 
464:         *-- TextBox codigo do grupo (get_cd_grupo: Left=197, Width=79, MaxLength=10)
465:         loc_oPagina.AddObject("txt_4c_cd_grupo", "TextBox")
466:         WITH loc_oPagina.txt_4c_cd_grupo
467:             .Top       = 197
468:             .Left      = 197
469:             .Width     = 79
470:             .Height    = 23
471:             .MaxLength = 10
472:             .Format    = "!"
473:             .Value     = ""
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .Visible   = .T.
477:         ENDWITH
478: 
479:         *-- TextBox descricao do grupo (get_ds_grupo: Left=278, Width=150, MaxLength=20)
480:         *-- ReadOnly: descricao preenchida automaticamente pelo lookup/validacao
481:         loc_oPagina.AddObject("txt_4c_ds_grupo", "TextBox")

*-- Linhas 492 a 536:
492:             .Visible   = .T.
493:         ENDWITH
494: 
495:         BINDEVENT(loc_oPagina.txt_4c_cd_grupo, "KeyPress", THIS, "ValidarGrupoForm")
496:         BINDEVENT(loc_oPagina.txt_4c_cd_grupo, "KeyPress",  THIS, "TeclaGrupoKeyPress")
497: 
498:         *======================================================================
499:         * SECAO CONTA
500:         * Original: lbl_conta.Top=197, get_cd_conta.Top=193 -> comp +29
501:         *======================================================================
502: 
503:         *-- Label "Conta :" (lbl_conta no legado: Top=197, Left=148)
504:         loc_oPagina.AddObject("lbl_4c_lbl_conta", "Label")
505:         WITH loc_oPagina.lbl_4c_lbl_conta
506:             .Caption   = "Conta :"
507:             .Top       = 226
508:             .Left      = 148
509:             .Width     = 38
510:             .Height    = 17
511:             .AutoSize  = .T.
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(90, 90, 90)
515:             .BackStyle = 0
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         *-- TextBox codigo da conta (get_cd_conta: Left=197, Width=79, MaxLength=10)
520:         loc_oPagina.AddObject("txt_4c_cd_conta", "TextBox")
521:         WITH loc_oPagina.txt_4c_cd_conta
522:             .Top       = 222
523:             .Left      = 197
524:             .Width     = 79
525:             .Height    = 23
526:             .MaxLength = 10
527:             .Format    = "!"
528:             .Value     = ""
529:             .FontName  = "Tahoma"
530:             .FontSize  = 8
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         *-- TextBox descricao da conta (get_ds_conta: Left=278, Width=290, MaxLength=40)
535:         *-- ReadOnly: preenchida automaticamente pelo lookup/validacao
536:         loc_oPagina.AddObject("txt_4c_ds_conta", "TextBox")

*-- Linhas 547 a 615:
547:             .Visible   = .T.
548:         ENDWITH
549: 
550:         BINDEVENT(loc_oPagina.txt_4c_cd_conta, "KeyPress", THIS, "ValidarContaForm")
551:         BINDEVENT(loc_oPagina.txt_4c_cd_conta, "KeyPress",  THIS, "TeclaContaKeyPress")
552: 
553:         *======================================================================
554:         * SECAO TIPO (OptionGroup)
555:         * Original: Say8.Top=230, ObjUniDop.Top=228 -> comp +29
556:         *======================================================================
557: 
558:         *-- Label "Tipo :" (Say8 no legado: Top=230, Left=157, Width=29, Height=15)
559:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
560:         WITH loc_oPagina.lbl_4c_Label8
561:             .Caption   = "Tipo :"
562:             .Top       = 259
563:             .Left      = 157
564:             .Width     = 29
565:             .Height    = 15
566:             .AutoSize  = .T.
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:             .ForeColor = RGB(90, 90, 90)
570:             .BackStyle = 0
571:             .Visible   = .T.
572:         ENDWITH
573: 
574:         *-- OptionGroup tipo (ObjUniDop: Top=228, Left=191, Width=308, Height=19, ButtonCount=3)
575:         loc_oPagina.AddObject("opt_4c_Tipos", "OptionGroup")
576:         WITH loc_oPagina.opt_4c_Tipos
577:             .Top         = 257
578:             .Left        = 191
579:             .Width       = 308
580:             .Height      = 19
581:             .ButtonCount = 3
582:             .BackStyle   = 0
583:             .BorderStyle = 0
584:             .Value       = 1
585:             .Visible     = .T.
586:         ENDWITH
587: 
588:         WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
589:             .Caption   = "Disponibilidade"
590:             .Left      = 5
591:             .Top       = 2
592:             .AutoSize  = .T.
593:             .FontName  = "Tahoma"
594:             .FontSize  = 8
595:             .ForeColor = RGB(90, 90, 90)
596:             .BackStyle = 0
597:             .Themes    = .F.
598:         ENDWITH
599: 
600:         WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
601:             .Caption   = "Investimento"
602:             .Left      = 116
603:             .Top       = 2
604:             .AutoSize  = .T.
605:             .FontName  = "Tahoma"
606:             .FontSize  = 8
607:             .ForeColor = RGB(90, 90, 90)
608:             .BackStyle = 0
609:             .Themes    = .F.
610:         ENDWITH
611: 
612:         WITH loc_oPagina.opt_4c_Tipos.Buttons(3)
613:             .Caption   = "Empr" + CHR(233) + "stimo"
614:             .Left      = 216
615:             .Top       = 2

*-- Linhas 622 a 1186:
622:             .Themes    = .F.
623:         ENDWITH
624: 
625:         THIS.TornarControlesVisiveis(loc_oPagina)
626:     ENDPROC
627: 
628:     *==========================================================================
629:     * CarregarLista - Carrega dados no Grid da Page1
630:     *==========================================================================
631:     PROCEDURE CarregarLista()
632:         LOCAL loc_lResultado, loc_oGrd
633:         loc_lResultado = .F.
634: 
635:         TRY
636:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
637:                 loc_lResultado = .T.
638:             ELSE
639:                 IF THIS.this_oBusinessObject.Buscar("")
640:                     loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
641: 
642:                     loc_oGrd.ColumnCount = 5
643:                     loc_oGrd.RecordSource          = "cursor_4c_Dados"
644:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.Grupos"
645:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.DsGrupos"
646:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.Iclis"
647:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.DsConta"
648:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.Tipos"
649: 
650:                     loc_oGrd.Column1.Header1.Caption = "Grupo"
651:                     loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
652:                     loc_oGrd.Column3.Header1.Caption = "Conta"
653:                     loc_oGrd.Column4.Header1.Caption = "Nome da Conta"
654:                     loc_oGrd.Column5.Header1.Caption = "Tipo"
655: 
656:                     THIS.FormatarGridLista(loc_oGrd)
657:                     loc_lResultado = .T.
658:                 ENDIF
659:             ENDIF
660:         CATCH TO loc_oErro
661:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
662:         ENDTRY
663: 
664:         RETURN loc_lResultado
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
669:     *==========================================================================
670:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
671:         LOCAL loc_lResultado
672:         loc_lResultado = .F.
673: 
674:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
675:             RETURN .F.
676:         ENDIF
677: 
678:         TRY
679:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
680: 
681:             IF par_nPagina = 1
682:                 THIS.this_cModoAtual = "LISTA"
683:                 THIS.CarregarLista()
684:             ENDIF
685: 
686:             loc_lResultado = .T.
687: 
688:         CATCH TO loc_oErro
689:             MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loc_oErro.Message, "Erro")
690:         ENDTRY
691: 
692:         RETURN loc_lResultado
693:     ENDPROC
694: 
695:     *==========================================================================
696:     * FormParaBO - Transfere dados do Form para Business Object
697:     * Implementado na Fase 5 (apos criacao dos campos em Page2)
698:     *==========================================================================
699:     PROCEDURE FormParaBO()
700:         WITH THIS.pgf_4c_Paginas.Page2
701:             THIS.this_oBusinessObject.this_cGrupos  = ALLTRIM(.txt_4c_cd_grupo.Value)
702:             THIS.this_oBusinessObject.this_cIclis  = ALLTRIM(.txt_4c_cd_conta.Value)
703:             THIS.this_oBusinessObject.this_cDsGrupo = ALLTRIM(.txt_4c_ds_grupo.Value)
704:             THIS.this_oBusinessObject.this_cDsConta = ALLTRIM(.txt_4c_ds_conta.Value)
705:             THIS.this_oBusinessObject.this_nTipos   = .opt_4c_Tipos.Value
706:         ENDWITH
707:     ENDPROC
708: 
709:     *==========================================================================
710:     * BOParaForm - Transfere dados do Business Object para Form
711:     * Implementado na Fase 5 (apos criacao dos campos em Page2)
712:     *==========================================================================
713:     PROCEDURE BOParaForm()
714:         WITH THIS.pgf_4c_Paginas.Page2
715:             .txt_4c_cd_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
716:             .txt_4c_ds_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDsGrupo)
717:             .txt_4c_cd_conta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
718:             .txt_4c_ds_conta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDsConta)
719:             .opt_4c_Tipos.Value    = THIS.this_oBusinessObject.this_nTipos
720:         ENDWITH
721:     ENDPROC
722: 
723:     *==========================================================================
724:     * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)
725:     *==========================================================================
726:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
727:         LOCAL loc_i, loc_oObjeto, loc_nP
728: 
729:         IF VARTYPE(par_oContainer) != "O"
730:             RETURN
731:         ENDIF
732: 
733:         FOR loc_i = 1 TO par_oContainer.ControlCount
734:             loc_oObjeto = par_oContainer.Controls(loc_i)
735: 
736:             IF VARTYPE(loc_oObjeto) = "O"
737:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
738:                     loc_oObjeto.Visible = .T.
739:                 ENDIF
740: 
741:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
742:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
743:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
744:                     ENDFOR
745:                 ENDIF
746: 
747:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
748:                     IF loc_oObjeto.ControlCount > 0
749:                         THIS.TornarControlesVisiveis(loc_oObjeto)
750:                     ENDIF
751:                 ENDIF
752:             ENDIF
753:         ENDFOR
754:     ENDPROC
755: 
756:     *==========================================================================
757:     * FormatarGridLista - Formata visual do Grid apos carregar dados
758:     *==========================================================================
759:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
760:         IF VARTYPE(par_oGrid) != "O"
761:             RETURN
762:         ENDIF
763: 
764:         WITH par_oGrid
765:             .FontName = "Tahoma"
766:             .FontSize = 8
767:         ENDWITH
768:     ENDPROC
769: 
770:     *==========================================================================
771:     * BtnIncluirClick - Abre Page2 para inclusao de novo registro
772:     *==========================================================================
773:     PROCEDURE BtnIncluirClick()
774:         THIS.this_oBusinessObject.NovoRegistro()
775:         THIS.this_cModoAtual = "INCLUIR"
776:         THIS.LimparCampos()
777:         THIS.HabilitarCampos(.T.)
778:         THIS.AjustarBotoesPorModo()
779:         THIS.AlternarPagina(2)
780:     ENDPROC
781: 
782:     *==========================================================================
783:     * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
784:     *==========================================================================
785:     PROCEDURE BtnVisualizarClick()
786:         LOCAL loc_cChave
787:         loc_cChave = ""
788: 
789:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
790:             MsgAviso("Selecione um registro na lista!", "Visualizar")
791:             RETURN
792:         ENDIF
793: 
794:         SELECT cursor_4c_Dados
795:         loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)
796: 
797:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
798:             THIS.this_cModoAtual = "VISUALIZAR"
799:             THIS.BOParaForm()
800:             THIS.HabilitarCampos(.F.)
801:             THIS.AjustarBotoesPorModo()
802:             THIS.AlternarPagina(2)
803:         ENDIF
804:     ENDPROC
805: 
806:     *==========================================================================
807:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
808:     *==========================================================================
809:     PROCEDURE BtnAlterarClick()
810:         LOCAL loc_cChave
811:         loc_cChave = ""
812: 
813:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
814:             MsgAviso("Selecione um registro na lista!", "Alterar")
815:             RETURN
816:         ENDIF
817: 
818:         SELECT cursor_4c_Dados
819:         loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)
820: 
821:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
822:             THIS.this_oBusinessObject.EditarRegistro()
823:             THIS.this_cModoAtual = "ALTERAR"
824:             THIS.BOParaForm()
825:             THIS.HabilitarCampos(.T.)
826:             THIS.AjustarBotoesPorModo()
827:             THIS.AlternarPagina(2)
828:         ENDIF
829:     ENDPROC
830: 
831:     *==========================================================================
832:     * BtnExcluirClick - Exclui o registro selecionado na lista
833:     *==========================================================================
834:     PROCEDURE BtnExcluirClick()
835:         LOCAL loc_cChave, loc_lConfirma
836:         loc_cChave    = ""
837:         loc_lConfirma = .F.
838: 
839:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
840:             MsgAviso("Selecione um registro na lista!", "Excluir")
841:             RETURN
842:         ENDIF
843: 
844:         SELECT cursor_4c_Dados
845:         loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)
846: 
847:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do registro selecionado?", ;
848:             "Excluir Disponibilidade")
849: 
850:         IF loc_lConfirma
851:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
852:                 IF THIS.this_oBusinessObject.Excluir()
853:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
854:                         "Exclus" + CHR(227) + "o")
855:                     THIS.CarregarLista()
856:                 ENDIF
857:             ENDIF
858:         ENDIF
859:     ENDPROC
860: 
861:     *==========================================================================
862:     * BtnBuscarClick - Recarrega a lista completa
863:     *==========================================================================
864:     PROCEDURE BtnBuscarClick()
865:         THIS.CarregarLista()
866:     ENDPROC
867: 
868:     *==========================================================================
869:     * BtnEncerrarClick - Fecha o formulario
870:     *==========================================================================
871:     PROCEDURE BtnEncerrarClick()
872:         THIS.Release()
873:     ENDPROC
874: 
875:     *==========================================================================
876:     * BtnSalvarClick - Valida e persiste o registro (Salva.Click no legado)
877:     * Valida Grupo e Conta antes de FormParaBO + Salvar()
878:     *==========================================================================
879:     PROCEDURE BtnSalvarClick()
880:         LOCAL loc_oPagina, loc_cGrupo, loc_cConta
881:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
882:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
883:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_cd_conta.Value)
884: 
885:         *-- Validacoes obrigatorias fora do TRY (regra critica VFP9)
886:         IF THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
887:             IF EMPTY(loc_cGrupo)
888:                 MsgAviso("Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!", "Validar")
889:                 loc_oPagina.txt_4c_cd_grupo.SetFocus()
890:                 RETURN
891:             ENDIF
892: 
893:             IF !THIS.this_oBusinessObject.ValidarGrupo(loc_cGrupo)
894:                 MsgAviso("Grupo inv" + CHR(225) + "lido!", "Validar")
895:                 loc_oPagina.txt_4c_cd_grupo.SetFocus()
896:                 RETURN
897:             ENDIF
898: 
899:             IF EMPTY(loc_cConta)
900:                 MsgAviso("Conta " + CHR(233) + " obrigat" + CHR(243) + "ria!", "Validar")
901:                 loc_oPagina.txt_4c_cd_conta.SetFocus()
902:                 RETURN
903:             ENDIF
904: 
905:             IF !THIS.this_oBusinessObject.ValidarConta(loc_cGrupo, loc_cConta)
906:                 MsgAviso("Conta inv" + CHR(225) + "lida!", "Validar")
907:                 loc_oPagina.txt_4c_cd_conta.SetFocus()
908:                 RETURN
909:             ENDIF
910:         ENDIF
911: 
912:         THIS.FormParaBO()
913: 
914:         IF THIS.this_oBusinessObject.Salvar()
915:             MsgInfo("Registro salvo com sucesso!", "Salvar")
916:             THIS.AlternarPagina(1)
917:         ENDIF
918:     ENDPROC
919: 
920:     *==========================================================================
921:     * BtnCancelarClick - Cancela edicao e volta para lista
922:     *==========================================================================
923:     PROCEDURE BtnCancelarClick()
924:         THIS.this_cModoAtual = "LISTA"
925:         THIS.AlternarPagina(1)
926:         THIS.CarregarLista()
927:     ENDPROC
928: 
929:     *==========================================================================
930:     * LimparCampos - Limpa todos os campos da Page2
931:     *==========================================================================
932:     PROCEDURE LimparCampos()
933:         LOCAL loc_oPagina
934:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
935: 
936:         IF PEMSTATUS(loc_oPagina, "txt_4c_cd_grupo", 5)
937:             loc_oPagina.txt_4c_cd_grupo.Value = ""
938:             loc_oPagina.txt_4c_ds_grupo.Value = ""
939:         ENDIF
940: 
941:         *-- Campos adicionados na Fase 6
942:         IF PEMSTATUS(loc_oPagina, "txt_4c_cd_conta", 5)
943:             loc_oPagina.txt_4c_cd_conta.Value = ""
944:             loc_oPagina.txt_4c_ds_conta.Value = ""
945:         ENDIF
946: 
947:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipos", 5)
948:             loc_oPagina.opt_4c_Tipos.Value = 1
949:         ENDIF
950:     ENDPROC
951: 
952:     *==========================================================================
953:     * HabilitarCampos - Habilita ou desabilita campos de edicao
954:     * par_lHabilitar: .T.=edicao, .F.=somente leitura (VISUALIZAR)
955:     * Regra legado: get_cd_grupo editavel apenas em INSERIR (nao em ALTERAR)
956:     *               get_cd_conta editavel em INSERIR e ALTERAR
957:     *==========================================================================
958:     PROCEDURE HabilitarCampos(par_lHabilitar)
959:         LOCAL loc_oPagina
960:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
961: 
962:         *-- cd_grupo: editavel apenas em INCLUIR (nao em ALTERAR)
963:         IF PEMSTATUS(loc_oPagina, "txt_4c_cd_grupo", 5)
964:             loc_oPagina.txt_4c_cd_grupo.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
965:         ENDIF
966: 
967:         *-- Campos adicionados na Fase 6
968:         IF PEMSTATUS(loc_oPagina, "txt_4c_cd_conta", 5)
969:             loc_oPagina.txt_4c_cd_conta.ReadOnly = !par_lHabilitar
970:         ENDIF
971: 
972:         IF PEMSTATUS(loc_oPagina, "opt_4c_Tipos", 5)
973:             loc_oPagina.opt_4c_Tipos.Enabled = par_lHabilitar
974:         ENDIF
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * AjustarBotoesPorModo - Habilita/desabilita Salvar conforme modo atual
979:     *==========================================================================
980:     PROCEDURE AjustarBotoesPorModo()
981:         LOCAL loc_oPagina, loc_lEdicao
982:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
983:         loc_lEdicao = THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
984: 
985:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
986:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Salvar", 5)
987:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled  = loc_lEdicao
988:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
989:             ENDIF
990:         ENDIF
991:     ENDPROC
992: 
993:     *==========================================================================
994:     * ValidarGrupoForm - Handler LostFocus de txt_4c_cd_grupo
995:     * Valida codigo no banco (SigCdGcr) e preenche descricao em ds_grupo
996:     *==========================================================================
997:     PROCEDURE ValidarGrupoForm(par_nKeyCode, par_nShiftAltCtrl)
998:         LOCAL loc_oPagina, loc_cGrupo
999:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1000:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
1001: 
1002:         IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
1003:             RETURN
1004:         ENDIF
1005: 
1006:         IF EMPTY(loc_cGrupo)
1007:             loc_oPagina.txt_4c_ds_grupo.Value = ""
1008:             RETURN
1009:         ENDIF
1010: 
1011:         IF THIS.this_oBusinessObject.ValidarGrupo(loc_cGrupo)
1012:             loc_oPagina.txt_4c_ds_grupo.Value = THIS.this_oBusinessObject.this_cDsGrupo
1013:         ELSE
1014:             MsgAviso("Grupo inv" + CHR(225) + "lido!", "Grupo")
1015:             loc_oPagina.txt_4c_cd_grupo.Value = ""
1016:             loc_oPagina.txt_4c_ds_grupo.Value = ""
1017:             loc_oPagina.txt_4c_cd_grupo.SetFocus()
1018:         ENDIF
1019:     ENDPROC
1020: 
1021:     *==========================================================================
1022:     * TeclaGrupoKeyPress - Handler KeyPress de txt_4c_cd_grupo (F4=lookup)
1023:     *==========================================================================
1024:     PROCEDURE TeclaGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1025:         IF par_nKeyCode = 115
1026:             THIS.AbrirBuscaGrupo()
1027:         ENDIF
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * AbrirBuscaGrupo - FormBuscaAuxiliar para SigCdGcr (Grupos Conta Corrente)
1032:     * Replica fAcessoContab('C'): lookup por codigo, preenche descricao
1033:     *==========================================================================
1034:     PROCEDURE AbrirBuscaGrupo()
1035:         LOCAL loc_oPagina, loc_oBusca, loc_cGrupo
1036:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1037:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
1038: 
1039:         IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
1040:             RETURN
1041:         ENDIF
1042: 
1043:         TRY
1044:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1045:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", ;
1046:                 loc_cGrupo, "Grupo de Conta Corrente")
1047: 
1048:             IF VARTYPE(loc_oBusca) = "O"
1049:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1050:                     IF USED("cursor_4c_BuscaGrupo")
1051:                         SELECT cursor_4c_BuscaGrupo
1052:                         loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1053:                         loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1054:                     ENDIF
1055:                 ELSE
1056:                     IF !loc_oBusca.this_lAchouRegistro
1057:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1058:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1059:                     loc_oBusca.Show()
1060: 
1061:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1062:                         SELECT cursor_4c_BuscaGrupo
1063:                         loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1064:                         loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1065:                     ENDIF
1066:                     ENDIF
1067:                 ENDIF
1068:                 loc_oBusca.Release()
1069:             ENDIF
1070:         CATCH TO loc_oErro
1071:             MsgErro("Erro ao abrir busca de grupo: " + loc_oErro.Message, "Erro")
1072:         ENDTRY
1073: 
1074:         IF USED("cursor_4c_BuscaGrupo")
1075:             USE IN cursor_4c_BuscaGrupo
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *==========================================================================
1080:     * ValidarContaForm - Handler LostFocus de txt_4c_cd_conta
1081:     * Valida codigo no banco (SigCdCli filtrado por grupo) e preenche descricao
1082:     *==========================================================================
1083:     PROCEDURE ValidarContaForm(par_nKeyCode, par_nShiftAltCtrl)
1084:         LOCAL loc_oPagina, loc_cGrupo, loc_cConta
1085:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1086:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
1087:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_cd_conta.Value)
1088: 
1089:         IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
1090:             RETURN
1091:         ENDIF
1092: 
1093:         IF EMPTY(loc_cConta)
1094:             loc_oPagina.txt_4c_ds_conta.Value = ""
1095:             RETURN
1096:         ENDIF
1097: 
1098:         IF THIS.this_oBusinessObject.ValidarConta(loc_cGrupo, loc_cConta)
1099:             loc_oPagina.txt_4c_ds_conta.Value = THIS.this_oBusinessObject.this_cDsConta
1100:         ELSE
1101:             MsgAviso("Conta inv" + CHR(225) + "lida!", "Conta")
1102:             loc_oPagina.txt_4c_cd_conta.Value = ""
1103:             loc_oPagina.txt_4c_ds_conta.Value = ""
1104:             loc_oPagina.txt_4c_cd_conta.SetFocus()
1105:         ENDIF
1106:     ENDPROC
1107: 
1108:     *==========================================================================
1109:     * TeclaContaKeyPress - Handler KeyPress de txt_4c_cd_conta (F4=lookup)
1110:     *==========================================================================
1111:     PROCEDURE TeclaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1112:         IF par_nKeyCode = 115
1113:             THIS.AbrirBuscaConta()
1114:         ENDIF
1115:     ENDPROC
1116: 
1117:     *==========================================================================
1118:     * AbrirBuscaConta - FormBuscaAuxiliar para SigCdCli filtrado por grupo
1119:     * Replica fAcessoContas('C'): busca conta dentro do grupo selecionado
1120:     *==========================================================================
1121:     PROCEDURE AbrirBuscaConta()
1122:         LOCAL loc_oPagina, loc_oBusca, loc_cGrupo, loc_cConta
1123:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1124:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_cd_grupo.Value)
1125:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_cd_conta.Value)
1126: 
1127:         IF !THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
1128:             RETURN
1129:         ENDIF
1130: 
1131:         IF EMPTY(loc_cGrupo)
1132:             MsgAviso("Informe o Grupo antes de buscar a Conta!", "Conta")
1133:             loc_oPagina.txt_4c_cd_grupo.SetFocus()
1134:             RETURN
1135:         ENDIF
1136: 
1137:         TRY
1138:             IF THIS.this_oBusinessObject.BuscarContas(loc_cGrupo, loc_cConta)
1139:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1140:                 IF VARTYPE(loc_oBusca) = "O"
1141:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1142:                     loc_oBusca.this_cTitulo        = "Conta"
1143:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1144:                     loc_oBusca.mAddColuna("Rclis", "", "Nome da Conta")
1145:                     loc_oBusca.Show()
1146: 
1147:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1148:                         SELECT cursor_4c_BuscaConta
1149:                         loc_oPagina.txt_4c_cd_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1150:                         loc_oPagina.txt_4c_ds_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1151:                     ENDIF
1152:                     loc_oBusca.Release()
1153:                 ENDIF
1154:             ENDIF
1155:         CATCH TO loc_oErro
1156:             MsgErro("Erro ao abrir busca de conta: " + loc_oErro.Message, "Erro")
1157:         ENDTRY
1158: 
1159:         IF USED("cursor_4c_BuscaConta")
1160:             USE IN cursor_4c_BuscaConta
1161:         ENDIF
1162:     ENDPROC
1163: 
1164:     *==========================================================================
1165:     * Destroy - Libera recursos do formulario
1166:     *==========================================================================
1167:     PROCEDURE Destroy()
1168:         LOCAL loc_oErro
1169: 
1170:         TRY
1171:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1172:                 THIS.this_oBusinessObject = .NULL.
1173:             ENDIF
1174: 
1175:             IF USED("cursor_4c_Dados")
1176:                 USE IN cursor_4c_Dados
1177:             ENDIF
1178: 
1179:         CATCH TO loc_oErro
1180:             MsgErro("Erro ao destruir FormDsp: " + loc_oErro.Message, "Erro")
1181:         ENDTRY
1182: 
1183:         DODEFAULT()
1184:     ENDPROC
1185: 
1186: ENDDEFINE


### BO (C:\4c\projeto\app\classes\DspBO.prg):
*==============================================================================
* DspBO.prg - Business Object para Cadastro de Disponibilidades
* Tabela: SigCdDis
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DspBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdDis
    *--------------------------------------------------------------------------
    this_cCodigos   = ""   && char(20) PK - gerado por SYS(2015)
    this_cGrupos    = ""   && char(10) FK -> SigCdGcr.Codigos
    this_cIclis     = ""   && char(10) FK -> SigCdCli.IClis
    this_nTipos     = 1    && numeric(1,0) 1=Disponibilidade 2=Investimento 3=Emprestimo

    *--------------------------------------------------------------------------
    * Campos auxiliares (nao persistidos - apenas para exibicao no form)
    *--------------------------------------------------------------------------
    this_cDsGrupo   = ""   && descricao do grupo (SigCdGcr.Descrs)
    this_cDsConta   = ""   && descricao da conta (SigCdCli.RClis)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDis"
            THIS.this_cCampoChave = "Codigos"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de disponibilidades no cursor cursor_4c_Dados
    * par_cFiltro: filtro SQL adicional (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Iclis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar disponibilidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega disponibilidade pelo Codigos (PK)
    * par_cCodigo: valor do Codigos
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: nome do cursor (SELECT antes de acessar campos)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos   = TratarNulo(Codigos,  "C")
                THIS.this_cGrupos    = TratarNulo(Grupos,   "C")
                THIS.this_cIclis     = TratarNulo(Iclis,    "C")
                THIS.this_nTipos     = TratarNulo(Tipos,    "N")
                THIS.this_cDsGrupo   = TratarNulo(DsGrupos, "C")
                THIS.this_cDsConta   = TratarNulo(DsConta,  "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova disponibilidade (PROTECTED)
    * Gera Codigos via SYS(2015), verifica duplicidade antes de INSERT
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, "")
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_cCodigos = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSQL = "INSERT INTO SigCdDis (Codigos, Grupos, Iclis, Tipos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCodigos)               + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cGrupos, 10))      + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cIclis, 10))       + ", " + ;
                           FormatarNumeroSQL(THIS.this_nTipos)          + ;
                           ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza disponibilidade existente (PROTECTED)
    * Verifica duplicidade (excluindo o registro atual) antes de UPDATE
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, THIS.this_cCodigos)
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigCdDis SET" + ;
                           " Grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                           " Iclis  = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))  + "," + ;
                           " Tipos  = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui disponibilidade (PROTECTED)
    * Chamado internamente por Excluir() do BusinessBase
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDis WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com Grupos+Iclis
    * par_cGrupos: codigo do grupo
    * par_cContas: codigo da conta (Iclis)
    * par_cExcluirChave: PK a excluir da verificacao (vazio=INSERT, atual=UPDATE)
    * Retorna: .T. se duplicado, .F. se nao existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade(par_cGrupos, par_cContas, par_cExcluirChave)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Duplic")
                USE IN cursor_4c_Duplic
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDis" + ;
                       " WHERE Grupos = " + EscaparSQL(LEFT(par_cGrupos, 10)) + ;
                       " AND Iclis = " + EscaparSQL(par_cContas)

            IF VARTYPE(par_cExcluirChave) = "C" AND !EMPTY(ALLTRIM(par_cExcluirChave))
                loc_cSQL = loc_cSQL + " AND Codigos <> " + EscaparSQL(par_cExcluirChave)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Duplic") > 0
                SELECT cursor_4c_Duplic
                loc_lDuplicado = (Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Duplic")
            USE IN cursor_4c_Duplic
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida codigo de grupo e carrega descricao
    * par_cGrupo: codigo do grupo (SigCdGcr.Codigos)
    * Retorna: .T. se valido | Efeito: popula this_cDsGrupo
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cGrupo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValGrupo")
                USE IN cursor_4c_ValGrupo
            ENDIF

            IF EMPTY(ALLTRIM(par_cGrupo))
                THIS.this_cDsGrupo = ""
            ELSE
                loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGrupo") > 0
                    SELECT cursor_4c_ValGrupo
                    THIS.this_cDsGrupo = ALLTRIM(cursor_4c_ValGrupo.Descrs)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsGrupo = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValGrupo")
            USE IN cursor_4c_ValGrupo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarConta - Valida codigo de conta (SigCdCli.IClis)
    * par_cGrupo: nao utilizado no filtro SQL
    * par_cConta: codigo da conta (SigCdCli.IClis)
    * Retorna: .T. se valida | Efeito: popula this_cDsConta
    *==========================================================================
    PROCEDURE ValidarConta(par_cGrupo, par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValConta")
                USE IN cursor_4c_ValConta
            ENDIF

            IF EMPTY(ALLTRIM(par_cConta))
                THIS.this_cDsConta = ""
            ELSE
                loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValConta") > 0
                    SELECT cursor_4c_ValConta
                    THIS.this_cDsConta = ALLTRIM(cursor_4c_ValConta.Rclis)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsConta = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conta: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValConta")
            USE IN cursor_4c_ValConta
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarGrupos - Popula cursor_4c_BuscaGrupo para lookup de grupos
    * par_cFiltro: prefixo para filtrar por Codigos (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarGrupos(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE Codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaGrupo
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarContas - Popula cursor_4c_BuscaConta para lookup de contas
    * par_cGrupo: nao utilizado no filtro SQL
    * par_cFiltro: prefixo para filtrar por Iclis (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarContas(par_cGrupo, par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
        loc_lResultado = .F.
        loc_cWhere     = ""

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + loc_cWhere + " ORDER BY Iclis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaConta
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar contas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

