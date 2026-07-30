# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarUsuars' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCol.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1227 linhas total):

*-- Linhas 24 a 140:
24:     this_cModoAtual      = "LISTA"
25: 
26:     *--------------------------------------------------------------------------
27:     * Init - Inicializa o formulario (FormBase.Init chama InicializarForm)
28:     *--------------------------------------------------------------------------
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *--------------------------------------------------------------------------
34:     * InicializarForm - Configura estrutura completa do formulario
35:     * Chamado automaticamente por FormBase.Init()
36:     *--------------------------------------------------------------------------
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("ColBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar ColBO", "FormCol.InicializarForm")
46:             ELSE
47:                 THIS.ConfigurarPageFrame()
48:                 THIS.pgf_4c_Paginas.ActivePage = 1
49:                 THIS.this_cModoAtual = "LISTA"
50: 
51:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
52:                     THIS.CarregarLista()
53:                 ENDIF
54: 
55:                 loc_lSucesso = .T.
56:             ENDIF
57: 
58:         CATCH TO loc_oErro
59:             MostrarErro("Erro ao inicializar FormCol:" + CHR(13) + loc_oErro.Message, "FormCol.InicializarForm")
60:         ENDTRY
61: 
62:         RETURN loc_lSucesso
63:     ENDPROC
64: 
65:     *--------------------------------------------------------------------------
66:     * ConfigurarPageFrame - Cria o PageFrame principal com 2 paginas
67:     *--------------------------------------------------------------------------
68:     PROTECTED PROCEDURE ConfigurarPageFrame()
69:         TRY
70:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
71: 
72:             THIS.pgf_4c_Paginas.Top       = -29
73:             THIS.pgf_4c_Paginas.Left      = 0
74:             THIS.pgf_4c_Paginas.Width     = 1000
75:             THIS.pgf_4c_Paginas.Height    = 629
76:             THIS.pgf_4c_Paginas.PageCount = 2
77:             THIS.pgf_4c_Paginas.Tabs      = .F.
78:             THIS.pgf_4c_Paginas.TabStyle  = 0
79:             THIS.pgf_4c_Paginas.Visible   = .T.
80: 
81:             WITH THIS.pgf_4c_Paginas
82:                 .Page1.Caption  = "Lista"
83:                 .Page1.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
84:                 .Page2.Caption  = "Dados"
85:                 .Page2.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
86:             ENDWITH
87: 
88:             THIS.ConfigurarPaginaLista()
89:             THIS.ConfigurarPaginaDados()
90: 
91:         CATCH TO loc_oErro
92:             MostrarErro("Erro ao configurar PageFrame:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPageFrame")
93:         ENDTRY
94:     ENDPROC
95: 
96:     *--------------------------------------------------------------------------
97:     * ConfigurarPaginaLista - Configura Page1 (lista de registros)
98:     * Cabecalho, botoes CRUD, grid e saida
99:     *--------------------------------------------------------------------------
100:     PROTECTED PROCEDURE ConfigurarPaginaLista()
101:         LOCAL loc_oPagina
102:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
103: 
104:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
105:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106: 
107:         TRY
108:             *-- Cabecalho cinza (cntSombra legado: Top=1, Left=-1, Width=1008, Height=80)
109:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
110:             WITH loc_oPagina.cnt_4c_Cabecalho
111:                 .Top         = 30
112:                 .Left        = 0
113:                 .Width       = 1000
114:                 .Height      = 80
115:                 .BackColor   = RGB(100, 100, 100)
116:                 .BorderWidth = 0
117:                 .Visible     = .T.
118: 
119:                 .AddObject("lbl_4c_Sombra", "Label")
120:                 WITH .lbl_4c_Sombra
121:                     .Caption   = "Cadastro de Grupo de Venda"
122:                     .Top       = 15
123:                     .Left      = 10
124:                     .Width     = THIS.Width
125:                     .Height    = 40
126:                     .AutoSize  = .F.
127:                     .FontName  = "Tahoma"
128:                     .FontSize  = 16
129:                     .FontBold  = .T.
130:                     .ForeColor = RGB(0, 0, 0)
131:                     .BackStyle = 0
132:                     .Visible   = .T.
133:                 ENDWITH
134: 
135:                 .AddObject("lbl_4c_Titulo", "Label")
136:                 WITH .lbl_4c_Titulo
137:                     .Caption   = "Cadastro de Grupo de Venda"
138:                     .Top       = 18
139:                     .Left      = 10
140:                     .Width     = THIS.Width

*-- Linhas 329 a 392:
329:                 .Visible              = .T.
330:             ENDWITH
331: 
332:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
333:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
334:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
335:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
336:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
337:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
338: 
339:             THIS.TornarControlesVisiveis(loc_oPagina)
340: 
341:         CATCH TO loc_oErro
342:             MostrarErro("Erro ao configurar Page Lista:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPaginaLista")
343:         ENDTRY
344:     ENDPROC
345: 
346:     *--------------------------------------------------------------------------
347:     * ConfigurarPaginaDados - Configura Page2 (campos de edicao)
348:     * Fase 3: container salvar/cancelar
349:     * Fase 5: campos principais (getColecoes, getDescs, getUsuars, getDtInicial)
350:     * Fase 6: OptionGroups (optConProds, optAltProds), getAgrupa - COMPLETO
351:     *--------------------------------------------------------------------------
352:     PROTECTED PROCEDURE ConfigurarPaginaDados()
353:         LOCAL loc_oPagina
354:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
355: 
356:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
357:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
358: 
359:         TRY
360:             *-- Container salvar/cancelar (Grupo_Salva legado: Left=820, Top=8, Width=160)
361:             loc_oPagina.AddObject("cnt_4c_Salva", "Container")
362:             WITH loc_oPagina.cnt_4c_Salva
363:                 .Top         = 37
364:                 .Left        = 820
365:                 .Width       = 160
366:                 .Height      = 85
367:                 .BackStyle   = 0
368:                 .BorderWidth = 0
369:                 .Visible     = .T.
370: 
371:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
372:                 WITH .cmd_4c_Confirmar
373:                     .Caption         = "Confirmar"
374:                     .Top             = 5
375:                     .Left            = 5
376:                     .Width           = 75
377:                     .Height          = 75
378:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
379:                     .PicturePosition = 13
380:                     .FontName        = "Comic Sans MS"
381:                     .FontSize        = 8
382:                     .FontBold        = .T.
383:                     .FontItalic      = .T.
384:                     .ForeColor       = RGB(90, 90, 90)
385:                     .BackColor       = RGB(255, 255, 255)
386:                     .SpecialEffect   = 0
387:                     .MousePointer    = 15
388:                     .WordWrap        = .T.
389:                     .Visible         = .T.
390:                 ENDWITH
391: 
392:                 .AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 412 a 456:
412:                 ENDWITH
413:             ENDWITH
414: 
415:             BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
416:             BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
417: 
418:             *-- Label "Grupo :" (Say1: Top=127, Left=324, compensacao +29 = 156)
419:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
420:             WITH loc_oPagina.lbl_4c_Label1
421:                 .Caption   = "Grupo :"
422:                 .Top       = 156
423:                 .Left      = 324
424:                 .Width     = 38
425:                 .Height    = 15
426:                 .AutoSize  = .T.
427:                 .FontName  = "Tahoma"
428:                 .FontSize  = 8
429:                 .ForeColor = RGB(90, 90, 90)
430:                 .BackStyle = 0
431:                 .Visible   = .T.
432:             ENDWITH
433: 
434:             *-- TextBox Colecoes (getColecoes: Top=123, Left=366, Width=79, compensacao +29 = 152)
435:             *-- Editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
436:             loc_oPagina.AddObject("txt_4c_Colecoes", "TextBox")
437:             WITH loc_oPagina.txt_4c_Colecoes
438:                 .Top           = 152
439:                 .Left          = 366
440:                 .Width         = 79
441:                 .Height        = 25
442:                 .InputMask     = "XXXXXXXXXX"
443:                 .MaxLength     = 10
444:                 .SpecialEffect = 1
445:                 .FontName      = "Tahoma"
446:                 .FontSize      = 8
447:                 .Value         = ""
448:                 .Visible       = .T.
449:             ENDWITH
450: 
451:             *-- Label "Descricao :" (Say2: Top=155, Left=307, compensacao +29 = 184)
452:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
453:             WITH loc_oPagina.lbl_4c_Label2
454:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
455:                 .Top       = 184
456:                 .Left      = 307

*-- Linhas 559 a 604:
559:                 .Visible   = .T.
560:             ENDWITH
561: 
562:             *-- OptionGroup optConProds (Top=235, Left=362, Width=95, Height=25, comp +29 = 264)
563:             *-- S (Sim=1) / N (Nao=0) -> mapeado em this_nConprods; Value=1->S, Value=2->N
564:             loc_oPagina.AddObject("opt_4c_ConProds", "OptionGroup")
565:             WITH loc_oPagina.opt_4c_ConProds
566:                 .ButtonCount = 2
567:                 .Top         = 264
568:                 .Left        = 362
569:                 .Width       = 95
570:                 .Height      = 25
571:                 .BackStyle   = 0
572:                 .BorderStyle = 0
573:                 .Value       = 2
574:                 .Visible     = .T.
575:                 WITH .Buttons(1)
576:                     .Caption   = "S"
577:                     .Left      = 5
578:                     .Top       = 5
579:                     .Width     = 40
580:                     .AutoSize  = .T.
581:                     .ForeColor = RGB(90, 90, 90)
582:                     .Themes    = .F.
583:                 ENDWITH
584:                 WITH .Buttons(2)
585:                     .Caption   = "N"
586:                     .Left      = 48
587:                     .Top       = 5
588:                     .Width     = 40
589:                     .AutoSize  = .T.
590:                     .FontName  = "Tahoma"
591:                     .FontSize  = 8
592:                     .ForeColor = RGB(90, 90, 90)
593:                     .Themes    = .F.
594:                 ENDWITH
595:             ENDWITH
596: 
597:             *-- Label "Alertar ao Alterar Produtos :" (Say6: Top=260, Left=223, comp +29 = 289)
598:             loc_oPagina.AddObject("lbl_4c_Label6", "Label")
599:             WITH loc_oPagina.lbl_4c_Label6
600:                 .Caption   = "Alertar ao Alterar Produtos :"
601:                 .Top       = 289
602:                 .Left      = 223
603:                 .Width     = 139
604:                 .Height    = 15

*-- Linhas 610 a 655:
610:                 .Visible   = .T.
611:             ENDWITH
612: 
613:             *-- OptionGroup optAltProds (Top=255, Left=362, Width=95, Height=25, comp +29 = 284)
614:             *-- S (Sim=1) / N (Nao=0) -> mapeado em this_nAltProds; Value=1->S, Value=2->N
615:             loc_oPagina.AddObject("opt_4c_AltProds", "OptionGroup")
616:             WITH loc_oPagina.opt_4c_AltProds
617:                 .ButtonCount = 2
618:                 .Top         = 284
619:                 .Left        = 362
620:                 .Width       = 95
621:                 .Height      = 25
622:                 .BackStyle   = 0
623:                 .BorderStyle = 0
624:                 .Value       = 2
625:                 .Visible     = .T.
626:                 WITH .Buttons(1)
627:                     .Caption   = "S"
628:                     .Left      = 5
629:                     .Top       = 5
630:                     .Width     = 40
631:                     .AutoSize  = .T.
632:                     .ForeColor = RGB(90, 90, 90)
633:                     .Themes    = .F.
634:                 ENDWITH
635:                 WITH .Buttons(2)
636:                     .Caption   = "N"
637:                     .Left      = 48
638:                     .Top       = 5
639:                     .Width     = 40
640:                     .AutoSize  = .T.
641:                     .FontName  = "Tahoma"
642:                     .FontSize  = 8
643:                     .ForeColor = RGB(90, 90, 90)
644:                     .Themes    = .F.
645:                 ENDWITH
646:             ENDWITH
647: 
648:             *-- Label "Agrupamento :" (Say9: Top=285, Left=288, comp +29 = 314)
649:             loc_oPagina.AddObject("lbl_4c_Label9", "Label")
650:             WITH loc_oPagina.lbl_4c_Label9
651:                 .Caption   = "Agrupamento :"
652:                 .Top       = 314
653:                 .Left      = 288
654:                 .Width     = 74
655:                 .Height    = 15

*-- Linhas 677 a 1227:
677:                 .Visible       = .T.
678:             ENDWITH
679: 
680:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")
681: 
682:             THIS.TornarControlesVisiveis(loc_oPagina)
683: 
684:         CATCH TO loc_oErro
685:             MostrarErro("Erro ao configurar Page Dados:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPaginaDados")
686:         ENDTRY
687:     ENDPROC
688: 
689:     *--------------------------------------------------------------------------
690:     * CarregarLista - Carrega dados no Grid da Page1
691:     *--------------------------------------------------------------------------
692:     PROCEDURE CarregarLista()
693:         LOCAL loc_lResultado, loc_oGrid
694:         loc_lResultado = .F.
695: 
696:         TRY
697:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
698:                 loc_lResultado = .T.
699:             ELSE
700:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
701:                     IF THIS.this_oBusinessObject.Buscar("")
702:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
703: 
704:                         loc_oGrid.ColumnCount = 3
705:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
706:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.colecoes"
707:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
708:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codcols"
709: 
710:                         loc_oGrid.Column1.Width = 79
711:                         loc_oGrid.Column2.Width = 290
712:                         loc_oGrid.Column3.Width = 75
713: 
714:                         *-- Reconfigurar cabecalhos APOS RecordSource (VFP reseta captions)
715:                         loc_oGrid.Column1.Header1.Caption = "Grupo"
716:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
717:                         loc_oGrid.Column3.Header1.Caption = "Cod. Coletor"
718: 
719:                         THIS.FormatarGridLista(loc_oGrid)
720:                         loc_lResultado = .T.
721:                     ENDIF
722:                 ENDIF
723:             ENDIF
724:         CATCH TO loc_oErro
725:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormCol.CarregarLista")
726:         ENDTRY
727: 
728:         RETURN loc_lResultado
729:     ENDPROC
730: 
731:     *--------------------------------------------------------------------------
732:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
733:     *--------------------------------------------------------------------------
734:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
735:         LOCAL loc_lResultado
736:         loc_lResultado = .F.
737: 
738:         TRY
739:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
740:                 loc_lResultado = .F.
741:             ELSE
742:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
743: 
744:                 IF par_nPagina = 1
745:                     THIS.CarregarLista()
746:                 ENDIF
747: 
748:                 loc_lResultado = .T.
749:             ENDIF
750:         CATCH TO loc_oErro
751:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormCol.AlternarPagina")
752:         ENDTRY
753: 
754:         RETURN loc_lResultado
755:     ENDPROC
756: 
757:     *--------------------------------------------------------------------------
758:     * FormParaBO - Transfere valores dos campos do Form para o BO
759:     *--------------------------------------------------------------------------
760:     PROTECTED PROCEDURE FormParaBO()
761:         LOCAL loc_lResultado, loc_oPg2
762:         loc_lResultado = .F.
763: 
764:         TRY
765:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
766:                 loc_lResultado = .F.
767:             ELSE
768:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
769: 
770:                 THIS.this_oBusinessObject.this_cColecoes = ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value)
771:                 THIS.this_oBusinessObject.this_cDescs    = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
772:                 THIS.this_oBusinessObject.this_cUsuars   = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
773: 
774:                 IF VARTYPE(loc_oPg2.txt_4c_DtInicial.Value) = "T" OR ;
775:                    VARTYPE(loc_oPg2.txt_4c_DtInicial.Value) = "D"
776:                     THIS.this_oBusinessObject.this_tDtIncs = loc_oPg2.txt_4c_DtInicial.Value
777:                 ENDIF
778: 
779:                 THIS.this_oBusinessObject.this_nConprods = IIF(loc_oPg2.opt_4c_ConProds.Value = 1, 1, 0)
780:                 THIS.this_oBusinessObject.this_nAltProds = IIF(loc_oPg2.opt_4c_AltProds.Value = 1, 1, 0)
781:                 THIS.this_oBusinessObject.this_cAgrupas  = ALLTRIM(loc_oPg2.txt_4c_Agrupa.Value)
782: 
783:                 loc_lResultado = .T.
784:             ENDIF
785:         CATCH TO loc_oErro
786:             MostrarErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormCol.FormParaBO")
787:         ENDTRY
788: 
789:         RETURN loc_lResultado
790:     ENDPROC
791: 
792:     *--------------------------------------------------------------------------
793:     * BOParaForm - Transfere valores do BO para os campos do Form
794:     *--------------------------------------------------------------------------
795:     PROTECTED PROCEDURE BOParaForm()
796:         LOCAL loc_lResultado, loc_oPg2
797:         loc_lResultado = .F.
798: 
799:         TRY
800:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
801:                 loc_lResultado = .F.
802:             ELSE
803:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
804: 
805:                 loc_oPg2.txt_4c_Colecoes.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cColecoes)
806:                 loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
807:                 loc_oPg2.txt_4c_Usuars.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)
808: 
809:                 IF !EMPTY(THIS.this_oBusinessObject.this_tDtIncs)
810:                     loc_oPg2.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_tDtIncs
811:                 ELSE
812:                     loc_oPg2.txt_4c_DtInicial.Value = {}
813:                 ENDIF
814: 
815:                 loc_oPg2.opt_4c_ConProds.Value = IIF(THIS.this_oBusinessObject.this_nConprods = 1, 1, 2)
816:                 loc_oPg2.opt_4c_AltProds.Value = IIF(THIS.this_oBusinessObject.this_nAltProds = 1, 1, 2)
817:                 loc_oPg2.txt_4c_Agrupa.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cAgrupas)
818: 
819:                 loc_lResultado = .T.
820:             ENDIF
821:         CATCH TO loc_oErro
822:             MostrarErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "FormCol.BOParaForm")
823:         ENDTRY
824: 
825:         RETURN loc_lResultado
826:     ENDPROC
827: 
828:     *--------------------------------------------------------------------------
829:     * HabilitarCampos - Habilita ou desabilita campos de edicao
830:     *--------------------------------------------------------------------------
831:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
832:         LOCAL loc_oPg2
833:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
834: 
835:         TRY
836:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
837:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
838:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
839:             ENDIF
840: 
841:             *-- Colecoes: editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
842:             IF PEMSTATUS(loc_oPg2, "txt_4c_Colecoes", 5)
843:                 loc_oPg2.txt_4c_Colecoes.ReadOnly = ;
844:                     !par_lHabilitar OR THIS.this_cModoAtual = "ALTERAR"
845:             ENDIF
846: 
847:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
848:                 loc_oPg2.txt_4c_Descricao.ReadOnly = !par_lHabilitar
849:             ENDIF
850: 
851:             IF PEMSTATUS(loc_oPg2, "txt_4c_Usuars", 5)
852:                 loc_oPg2.txt_4c_Usuars.ReadOnly = !par_lHabilitar
853:             ENDIF
854: 
855:             IF PEMSTATUS(loc_oPg2, "txt_4c_DtInicial", 5)
856:                 loc_oPg2.txt_4c_DtInicial.ReadOnly = !par_lHabilitar
857:             ENDIF
858: 
859:             IF PEMSTATUS(loc_oPg2, "opt_4c_ConProds", 5)
860:                 loc_oPg2.opt_4c_ConProds.Enabled = par_lHabilitar
861:             ENDIF
862: 
863:             IF PEMSTATUS(loc_oPg2, "opt_4c_AltProds", 5)
864:                 loc_oPg2.opt_4c_AltProds.Enabled = par_lHabilitar
865:             ENDIF
866: 
867:             IF PEMSTATUS(loc_oPg2, "txt_4c_Agrupa", 5)
868:                 loc_oPg2.txt_4c_Agrupa.ReadOnly = !par_lHabilitar
869:             ENDIF
870: 
871:         CATCH TO loc_oErro
872:             MostrarErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "FormCol.HabilitarCampos")
873:         ENDTRY
874:     ENDPROC
875: 
876:     *--------------------------------------------------------------------------
877:     * LimparCampos - Limpa valores dos campos da Page2
878:     *--------------------------------------------------------------------------
879:     PROTECTED PROCEDURE LimparCampos()
880:         LOCAL loc_oPg2
881:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
882: 
883:         TRY
884:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
885:                 THIS.this_oBusinessObject.NovoRegistro()
886:             ENDIF
887: 
888:             IF PEMSTATUS(loc_oPg2, "txt_4c_Colecoes", 5)
889:                 loc_oPg2.txt_4c_Colecoes.Value  = ""
890:                 loc_oPg2.txt_4c_Descricao.Value = ""
891:                 loc_oPg2.txt_4c_Usuars.Value    = ""
892:                 loc_oPg2.txt_4c_DtInicial.Value = {}
893:             ENDIF
894: 
895:             IF PEMSTATUS(loc_oPg2, "opt_4c_ConProds", 5)
896:                 loc_oPg2.opt_4c_ConProds.Value = 2
897:                 loc_oPg2.opt_4c_AltProds.Value = 2
898:                 loc_oPg2.txt_4c_Agrupa.Value   = ""
899:             ENDIF
900: 
901:         CATCH TO loc_oErro
902:             MostrarErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "FormCol.LimparCampos")
903:         ENDTRY
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * AjustarBotoesPorModo - Ajusta botoes conforme modo atual
908:     *--------------------------------------------------------------------------
909:     PROTECTED PROCEDURE AjustarBotoesPorModo()
910:         LOCAL loc_oPg2
911:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
912: 
913:         TRY
914:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
915:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
916:                     INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
917:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
918:             ENDIF
919:         CATCH TO loc_oErro
920:             MostrarErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "FormCol.AjustarBotoesPorModo")
921:         ENDTRY
922:     ENDPROC
923: 
924:     *--------------------------------------------------------------------------
925:     * Eventos dos botoes CRUD da Page1
926:     *--------------------------------------------------------------------------
927: 
928:     PROCEDURE BtnIncluirClick()
929:         THIS.this_oBusinessObject.NovoRegistro()
930:         THIS.LimparCampos()
931:         THIS.this_cModoAtual = "INCLUIR"
932:         THIS.HabilitarCampos(.T.)
933:         THIS.AlternarPagina(2)
934:     ENDPROC
935: 
936:     PROCEDURE BtnAlterarClick()
937:         LOCAL loc_cCodigo
938:         loc_cCodigo = ""
939: 
940:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
941:             SELECT cursor_4c_Dados
942:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
943:         ENDIF
944: 
945:         IF EMPTY(loc_cCodigo)
946:             MsgAviso("Selecione um registro para alterar.")
947:             RETURN
948:         ENDIF
949: 
950:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
951:             THIS.this_oBusinessObject.EditarRegistro()
952:             THIS.this_cModoAtual = "ALTERAR"
953:             THIS.BOParaForm()
954:             THIS.HabilitarCampos(.T.)
955:             THIS.AlternarPagina(2)
956:         ENDIF
957:     ENDPROC
958: 
959:     PROCEDURE BtnVisualizarClick()
960:         LOCAL loc_cCodigo
961:         loc_cCodigo = ""
962: 
963:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
964:             SELECT cursor_4c_Dados
965:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
966:         ENDIF
967: 
968:         IF EMPTY(loc_cCodigo)
969:             MsgAviso("Selecione um registro para visualizar.")
970:             RETURN
971:         ENDIF
972: 
973:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
974:             THIS.this_cModoAtual = "VISUALIZAR"
975:             THIS.BOParaForm()
976:             THIS.HabilitarCampos(.F.)
977:             THIS.AlternarPagina(2)
978:         ENDIF
979:     ENDPROC
980: 
981:     PROCEDURE BtnExcluirClick()
982:         LOCAL loc_cCodigo, loc_nResultado, loc_lPodeExcluir
983:         loc_cCodigo      = ""
984:         loc_lPodeExcluir = .T.
985: 
986:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
987:             SELECT cursor_4c_Dados
988:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
989:         ENDIF
990: 
991:         IF EMPTY(loc_cCodigo)
992:             MsgAviso("Selecione um registro para excluir.")
993:             RETURN
994:         ENDIF
995: 
996:         *-- Verificar se existem Produtos usando este Grupo (legado: ChkRegister SigCdPro/Colecoes)
997:         loc_nResultado = SQLEXEC(gnConnHandle, ;
998:             "SELECT COUNT(*) AS Contador FROM SigCdPro WHERE Colecoes = " + ;
999:             EscaparSQL(loc_cCodigo), "cursor_4c_ChkPro")
1000:         IF loc_nResultado > 0 AND USED("cursor_4c_ChkPro")
1001:             SELECT cursor_4c_ChkPro
1002:             IF cursor_4c_ChkPro.Contador > 0
1003:                 MsgAviso("Existem Produtos Utilizando Esse Grupo de Venda.", ;
1004:                     "Imposs" + CHR(237) + "vel Exclus" + CHR(227) + "o")
1005:                 loc_lPodeExcluir = .F.
1006:             ENDIF
1007:             USE IN cursor_4c_ChkPro
1008:         ENDIF
1009: 
1010:         IF !loc_lPodeExcluir
1011:             RETURN
1012:         ENDIF
1013: 
1014:         IF MsgConfirma("Deseja excluir este Grupo de Venda?", "Confirmar Exclus" + CHR(227) + "o")
1015:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1016:                 IF THIS.this_oBusinessObject.Excluir()
1017:                     MsgInfo("Grupo de Venda exclu" + CHR(237) + "do com sucesso!")
1018:                     THIS.CarregarLista()
1019:                 ENDIF
1020:             ENDIF
1021:         ENDIF
1022:     ENDPROC
1023: 
1024:     PROCEDURE BtnBuscarClick()
1025:         LOCAL loc_oBusca, loc_cCodigo
1026:         loc_cCodigo = ""
1027: 
1028:         TRY
1029:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1030:                 "SigCdCol", "cursor_4c_BuscaCol", "colecoes", "", ;
1031:                 "Buscar Grupo de Venda")
1032: 
1033:             IF VARTYPE(loc_oBusca) = "O"
1034:                 loc_oBusca.mAddColuna("colecoes", "", "Grupo")
1035:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1036:                 loc_oBusca.mAddColuna("codcols", "", "Cod. Coletor")
1037:                 loc_oBusca.Show()
1038: 
1039:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1040:                     SELECT cursor_4c_BuscaCol
1041:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCol.colecoes)
1042:                 ENDIF
1043: 
1044:                 loc_oBusca.Release()
1045:             ENDIF
1046: 
1047:             IF USED("cursor_4c_BuscaCol")
1048:                 USE IN cursor_4c_BuscaCol
1049:             ENDIF
1050: 
1051:             IF !EMPTY(loc_cCodigo)
1052:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1053:                     THIS.this_cModoAtual = "VISUALIZAR"
1054:                     THIS.BOParaForm()
1055:                     THIS.HabilitarCampos(.F.)
1056:                     THIS.AlternarPagina(2)
1057:                 ENDIF
1058:             ENDIF
1059: 
1060:         CATCH TO loc_oErro
1061:             MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormCol.BtnBuscarClick")
1062:             IF USED("cursor_4c_BuscaCol")
1063:                 USE IN cursor_4c_BuscaCol
1064:             ENDIF
1065:         ENDTRY
1066:     ENDPROC
1067: 
1068:     PROCEDURE BtnEncerrarClick()
1069:         THIS.Release()
1070:     ENDPROC
1071: 
1072:     *--------------------------------------------------------------------------
1073:     * Evento do botao Confirmar (Salvar)
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE BtnSalvarClick()
1076:         LOCAL loc_lResultado
1077:         loc_lResultado = .F.
1078: 
1079:         IF !THIS.FormParaBO()
1080:             RETURN
1081:         ENDIF
1082: 
1083:         TRY
1084:             IF THIS.this_oBusinessObject.Salvar()
1085:                 MsgInfo("Grupo de Venda salvo com sucesso!")
1086:                 THIS.this_cModoAtual = "LISTA"
1087:                 THIS.AlternarPagina(1)
1088:                 loc_lResultado = .T.
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "FormCol.BtnSalvarClick")
1092:         ENDTRY
1093: 
1094:         RETURN loc_lResultado
1095:     ENDPROC
1096: 
1097:     PROCEDURE BtnCancelarClick()
1098:         THIS.this_cModoAtual = "LISTA"
1099:         THIS.AlternarPagina(1)
1100:         THIS.CarregarLista()
1101:     ENDPROC
1102: 
1103:     *--------------------------------------------------------------------------
1104:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1105:     * Itera Pages de PageFrames e Controls de Containers
1106:     *--------------------------------------------------------------------------
1107:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1108:         LOCAL loc_nI, loc_oObjeto, loc_nP
1109: 
1110:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1111:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1112: 
1113:             IF VARTYPE(loc_oObjeto) = "O"
1114:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1115:                     loc_oObjeto.Visible = .T.
1116:                 ENDIF
1117: 
1118:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1119:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1120:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1121:                     ENDFOR
1122:                 ENDIF
1123: 
1124:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1125:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1126:                 ENDIF
1127:             ENDIF
1128:         ENDFOR
1129:     ENDPROC
1130: 
1131:     *--------------------------------------------------------------------------
1132:     * ValidarUsuars - Valida e busca usuario em SigCdUsu
1133:     * Equivalente ao Valid do getUsuars no legado (fwBuscaExt -> FormBuscaAuxiliar)
1134:     * Disparado via BINDEVENT LostFocus em txt_4c_Usuars
1135:     *--------------------------------------------------------------------------
1136:     PROCEDURE ValidarUsuars()
1137:         LOCAL loc_cUsuars, loc_oPg2, loc_oBusca, loc_lResultado
1138:         loc_lResultado = .F.
1139:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1140:         loc_cUsuars = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
1141: 
1142:         IF EMPTY(loc_cUsuars)
1143:             RETURN loc_lResultado
1144:         ENDIF
1145: 
1146:         TRY
1147:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1148:                 "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuars, ;
1149:                 "Sele" + CHR(231) + CHR(227) + "o", .T., .F., "Not cAtivos='N'")
1150: 
1151:             IF VARTYPE(loc_oBusca) = "O"
1152:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1153:                     *-- Usuario encontrado exatamente
1154:                     IF USED("cursor_4c_BuscaUsu")
1155:                         SELECT cursor_4c_BuscaUsu
1156:                         loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1157:                     ENDIF
1158:                 ELSE
1159:                     IF !loc_oBusca.this_lAchouRegistro
1160:                     *-- Nao encontrado exatamente, mostrar grid de selecao
1161:                     loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1162:                     loc_oBusca.Show()
1163: 
1164:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1165:                         SELECT cursor_4c_BuscaUsu
1166:                         loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1167:                     ELSE
1168:                         loc_oPg2.txt_4c_Usuars.Value = ""
1169:                     ENDIF
1170:                     ENDIF
1171:                 ENDIF
1172: 
1173:                 loc_oBusca.Release()
1174:             ENDIF
1175: 
1176:             IF USED("cursor_4c_BuscaUsu")
1177:                 USE IN cursor_4c_BuscaUsu
1178:             ENDIF
1179: 
1180:             *-- Auto-setar DtInicial se Usuars foi definido e DtInicial esta vazio (legado: Valid getUsuars)
1181:             loc_cUsuars = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
1182:             IF !EMPTY(loc_cUsuars) AND EMPTY(loc_oPg2.txt_4c_DtInicial.Value)
1183:                 loc_oPg2.txt_4c_DtInicial.Value = DATE()
1184:             ENDIF
1185: 
1186:             loc_lResultado = .T.
1187: 
1188:         CATCH TO loc_oErro
1189:             IF USED("cursor_4c_BuscaUsu")
1190:                 USE IN cursor_4c_BuscaUsu
1191:             ENDIF
1192:             MostrarErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "FormCol.ValidarUsuars")
1193:         ENDTRY
1194: 
1195:         RETURN loc_lResultado
1196:     ENDPROC
1197: 
1198:     *--------------------------------------------------------------------------
1199:     * FormatarGridLista - Formata visual do grid da lista
1200:     *--------------------------------------------------------------------------
1201:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1202:         WITH par_oGrid
1203:             .FontName = "Tahoma"
1204:             .FontSize = 8
1205:         ENDWITH
1206:     ENDPROC
1207: 
1208:     *--------------------------------------------------------------------------
1209:     * Destroy - Libera recursos ao fechar o formulario
1210:     *--------------------------------------------------------------------------
1211:     PROCEDURE Destroy()
1212:         TRY
1213:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1214:                 THIS.this_oBusinessObject = .NULL.
1215:             ENDIF
1216: 
1217:             IF USED("cursor_4c_Dados")
1218:                 USE IN cursor_4c_Dados
1219:             ENDIF
1220:         CATCH TO loc_oErro
1221:             *-- Erros no Destroy sao ignorados para nao bloquear fechamento
1222:         ENDTRY
1223: 
1224:         DODEFAULT()
1225:     ENDPROC
1226: 
1227: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ColBO.prg):
*------------------------------------------------------------------------------
* ColBO.prg - Business Object para Cadastro de Grupo de Venda
* Tabela: SigCdCol | PK: colecoes
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS ColBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SigCdCol (schema.sql)
    *-- colecoes char(10) NOT NULL (PK)
    this_cColecoes  = ""
    *-- descs char(40) NOT NULL
    this_cDescs     = ""
    *-- codcols char(1) NOT NULL
    this_cCodcols   = ""
    *-- repoauts numeric(1,0) NOT NULL
    this_nRepoauts  = 0
    *-- conprods numeric(1,0) NOT NULL
    this_nConprods  = 0
    *-- altprods numeric(1,0) NOT NULL
    this_nAltProds  = 0
    *-- dtincs datetime NULL
    this_tDtIncs    = {}
    *-- usuars char(10) NOT NULL
    this_cUsuars    = ""
    *-- agrupas char(10) NOT NULL
    this_cAgrupas   = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCol"
            THIS.this_cCampoChave = "colecoes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ColBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cColecoes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cColecoes  = TratarNulo(colecoes, "C")
                THIS.this_cDescs     = TratarNulo(descs,    "C")
                THIS.this_cCodcols   = TratarNulo(codcols,  "C")
                THIS.this_nRepoauts  = TratarNulo(repoauts, "N")
                THIS.this_nConprods  = TratarNulo(conprods, "N")
                THIS.this_nAltProds  = TratarNulo(altprods, "N")
                THIS.this_tDtIncs    = TratarNulo(dtincs,   "T")
                THIS.this_cUsuars    = TratarNulo(usuars,   "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ColBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cColecoes)
            MsgAviso("Grupo de Venda Inv" + CHR(225) + "lido.")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Definir usuario e data/hora de inclusao automaticamente
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_tDtIncs = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCol (colecoes, descs, codcols, repoauts, conprods, altprods, dtincs, usuars, agrupas)
                VALUES (
                    <<EscaparSQL(THIS.this_cColecoes)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodcols)>>,
                    <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cAgrupas)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ColBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCol
                SET descs    = <<EscaparSQL(THIS.this_cDescs)>>,
                    codcols  = <<EscaparSQL(THIS.this_cCodcols)>>,
                    repoauts = <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    conprods = <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    altprods = <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    agrupas  = <<EscaparSQL(THIS.this_cAgrupas)>>
                WHERE colecoes = <<EscaparSQL(THIS.this_cColecoes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ColBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCol
    * Verifica dependencia em SigCdPro antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se produtos utilizam este grupo de venda
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPro WHERE Colecoes = " + ;
                EscaparSQL(THIS.this_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkPro")
                SELECT cursor_4c_ChkPro
                loc_nUso = cursor_4c_ChkPro.qtd
                USE IN cursor_4c_ChkPro
                IF loc_nUso > 0
                    MsgAviso("Existem Produtos Utilizando Esse Grupo de Venda.")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCol WHERE colecoes = " + ;
                        EscaparSQL(THIS.this_cColecoes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ColBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colecoes, descs, codcols
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (colecoes C(10), descs C(40), codcols C(1))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT colecoes, descs, codcols FROM SigCdCol"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY colecoes"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ColBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT colecoes, descs, codcols, repoauts, conprods, altprods," + ;
                " dtincs, usuars, agrupas" + ;
                " FROM SigCdCol WHERE colecoes = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de Venda n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ColBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoColetor - Verifica se codcols ja existe em outro registro
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoColetor(par_cCodcols)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF !EMPTY(par_cCodcols)
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                    " WHERE codcols = " + EscaparSQL(par_cCodcols) + ;
                    " AND colecoes <> " + EscaparSQL(THIS.this_cColecoes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                    USE IN cursor_4c_ChkCod
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo coletor:" + CHR(13) + loException.Message, "ColBO.VerificarCodigoColetor")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarColecaoExistente - Verifica se colecoes ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarColecaoExistente(par_cColecoes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                " WHERE colecoes = " + EscaparSQL(par_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCol")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCol")
                SELECT cursor_4c_ChkCol
                loc_lExiste = (cursor_4c_ChkCol.qtd > 0)
                USE IN cursor_4c_ChkCol
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "ColBO.VerificarColecaoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

