# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Combo1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=315 vs migrado 'cbo_4c_Combo10' Top=178 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=136 vs migrado 'cbo_4c_Combo10' Left=380 (diff=244px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=315 vs migrado 'cbo_4c_Combo2' Top=27 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=380 vs migrado 'cbo_4c_Combo2' Left=642 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmbIpi' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=136 vs migrado 'cbo_4c_CmbIpiI' Left=380 (diff=244px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=389 vs migrado 'obj_4c_Fwoption1' Top=127 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=686 vs migrado 'obj_4c_Fwoption1' Left=638 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=420 vs migrado 'obj_4c_Fwoption2' Top=233 (diff=187px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=686 vs migrado 'obj_4c_Fwoption2' Left=231 (diff=455px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CmbFixa' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=642 vs migrado 'lbl_4c_LblCmbFixa' Left=477 (diff=165px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4455 linhas total):

*-- Linhas 26 a 168:
26:     this_cModoAtual      = "LISTA"
27: 
28:     *-- Guardias LostFocus: evita revalidar quando valor nao mudou
29:     this_cUltimoValidarCfoST60Validado  = ""
30:     this_cUltimoValidarCfoSTValidado    = ""
31:     this_cUltimoValidarCfdestValidado   = ""
32:     this_cUltimoValidarSittricmValidado = ""
33: 
34:     *--------------------------------------------------------------------------
35:     * Init - Inicializa o formulario via FormBase
36:     *--------------------------------------------------------------------------
37:     PROCEDURE Init()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40:         TRY
41:             loc_lSucesso = DODEFAULT()
42:         CATCH TO loc_oErro
43:             MostrarErro(loc_oErro, "Formcfo.Init")
44:         ENDTRY
45:         RETURN loc_lSucesso
46:     ENDPROC
47: 
48:     *--------------------------------------------------------------------------
49:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
50:     *--------------------------------------------------------------------------
51:     PROTECTED PROCEDURE InicializarForm()
52:         LOCAL loc_lSucesso
53:         loc_lSucesso = .F.
54: 
55:         TRY
56:             *-- Criar Business Object
57:             THIS.this_oBusinessObject = CREATEOBJECT("cfoBO")
58: 
59:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
60:                 MostrarErro("Erro ao criar cfoBO", "InicializarForm")
61:             ELSE
62:                 *-- Configurar PageFrame externo (Lista/Dados)
63:                 THIS.ConfigurarPageFrame()
64: 
65:                 *-- Propagar titulo para labels do cabecalho
66:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68: 
69:                 *-- Carregar lista inicial (pula se validando UI)
70:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
71:                     THIS.CarregarLista()
72:                 ENDIF
73: 
74:                 THIS.pgf_4c_Paginas.ActivePage = 1
75:                 THIS.this_cModoAtual = "LISTA"
76:                 loc_lSucesso = .T.
77:             ENDIF
78: 
79:         CATCH TO loc_oErro
80:             MostrarErro(loc_oErro, "Formcfo.InicializarForm")
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *--------------------------------------------------------------------------
87:     * ConfigurarPageFrame - PageFrame externo com Page1 (Lista) e Page2 (Dados)
88:     *--------------------------------------------------------------------------
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90: 
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount  = 2
94:             .Top        = -29
95:             .Left       = 0
96:             .Width      = 1000
97:             .Height     = 629
98:             .Tabs       = .F.
99:             .Visible    = .T.
100:         ENDWITH
101: 
102:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
103:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
104:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
105:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
106: 
107:         *-- Configurar Page1 e Page2
108:         THIS.ConfigurarPaginaLista()
109:         THIS.ConfigurarPaginaDados()
110: 
111:         THIS.pgf_4c_Paginas.Visible = .T.
112:     ENDPROC
113: 
114:     *--------------------------------------------------------------------------
115:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid, botoes XML
116:     *--------------------------------------------------------------------------
117:     PROTECTED PROCEDURE ConfigurarPaginaLista()
118:         LOCAL loc_oPagina
119:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
120: 
121:         *-- Container cabecalho (titulo do formulario - lado esquerdo)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = 800
127:             .Height      = 85
128:             .BackStyle   = 1
129:             .BackColor   = RGB(53, 53, 53)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         *-- Label sombra (efeito de sombra no titulo)
135:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
136:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
137:             .Caption   = "Cadastro de CFOP"
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = 769
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .AutoSize  = .F.
148:             .Visible   = .T.
149:         ENDWITH
150: 
151:         *-- Label titulo (branco - sobre a sombra)
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = "Cadastro de CFOP"
155:             .Top       = 18
156:             .Left      = 10
157:             .Width     = 769
158:             .Height    = 46
159:             .FontName  = "Tahoma"
160:             .FontSize  = 16
161:             .FontBold  = .T.
162:             .ForeColor = RGB(255, 255, 255)
163:             .BackStyle = 0
164:             .AutoSize  = .F.
165:             .Visible   = .T.
166:         ENDWITH
167: 
168:         *-- Container botoes CRUD (lado direito - a partir de Left=542)

*-- Linhas 393 a 453:
393:             .Visible            = .T.
394:         ENDWITH
395: 
396:         *-- BINDEVENT para botoes (PUBLIC para funcionar com BINDEVENT)
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
399:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
400:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
401:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
402:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
403:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
404:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
405:         BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")
406: 
407:         THIS.TornarControlesVisiveis(loc_oPagina)
408:     ENDPROC
409: 
410:     *--------------------------------------------------------------------------
411:     * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar e inner PageFrame
412:     *--------------------------------------------------------------------------
413:     PROTECTED PROCEDURE ConfigurarPaginaDados()
414:         LOCAL loc_oPagina
415:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
416: 
417:         *-- Container botoes Confirmar/Cancelar (canto superior direito, +29 compensado)
418:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
419:         WITH loc_oPagina.cnt_4c_BotoesAcao
420:             .Top         = 33
421:             .Left        = 842
422:             .Width       = 160
423:             .Height      = 85
424:             .BackStyle   = 1
425:             .BackColor   = RGB(53, 53, 53)
426:             .BorderWidth = 0
427:             .Visible     = .T.
428:         ENDWITH
429: 
430:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
431:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
432:             .Caption         = "Confirmar"
433:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
434:             .PicturePosition = 13
435:             .Top             = 5
436:             .Left            = 5
437:             .Width           = 75
438:             .Height          = 75
439:             .FontName        = "Tahoma"
440:             .FontSize        = 8
441:             .FontBold        = .T.
442:             .FontItalic      = .T.
443:             .ForeColor       = RGB(90, 90, 90)
444:             .BackColor       = RGB(255, 255, 255)
445:             .Themes          = .F.
446:             .SpecialEffect   = 0
447:             .MousePointer    = 15
448:             .WordWrap        = .T.
449:             .AutoSize        = .F.
450:             .Visible         = .T.
451:         ENDWITH
452: 
453:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 505 a 933:
505:         *-- Campos Page2 - Integracao Contabil/Fiscal
506:         THIS.ConfigurarPaginaDadosPage2()
507: 
508:         *-- BINDEVENT para botoes de acao
509:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
510:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
511: 
512:         THIS.TornarControlesVisiveis(loc_oPagina)
513:     ENDPROC
514: 
515:     *--------------------------------------------------------------------------
516:     * CarregarLista - Carrega registros no grid da Page1
517:     *--------------------------------------------------------------------------
518:     PROCEDURE CarregarLista()
519:         LOCAL loc_lResultado, loc_oGrid
520:         loc_lResultado = .F.
521: 
522:         *-- Verificar modo de validacao de UI (sem conexao SQL)
523:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
524:             RETURN .T.
525:         ENDIF
526: 
527:         TRY
528:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
529: 
530:             IF THIS.this_oBusinessObject.Buscar("")
531:                 *-- RecordSource e ColumnCount FORA de WITH para garantir criacao das colunas
532:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
533:                 loc_oGrid.ColumnCount  = 2
534: 
535:                 *-- Configurar colunas APOS RecordSource (redefine headers resetados pelo auto-bind)
536:                 loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
537:                 loc_oGrid.Column1.Width            = 80
538:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
539:                 loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
540: 
541:                 loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
542:                 loc_oGrid.Column2.Width            = 400
543:                 loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
544:                 loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
545: 
546:                 THIS.FormatarGridLista(loc_oGrid)
547:                 loc_lResultado = .T.
548:             ENDIF
549:         CATCH TO loc_oErro
550:             MostrarErro(loc_oErro, "Formcfo.CarregarLista")
551:         ENDTRY
552: 
553:         RETURN loc_lResultado
554:     ENDPROC
555: 
556:     *--------------------------------------------------------------------------
557:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
558:     * Obs: Percorre Pages de PageFrames e Controls de Containers
559:     *--------------------------------------------------------------------------
560:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
561:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cBaseClass
562: 
563:         FOR loc_nI = 1 TO par_oContainer.ControlCount
564:             loc_oObjeto = par_oContainer.Controls(loc_nI)
565: 
566:             IF VARTYPE(loc_oObjeto) = "O"
567:                 loc_cBaseClass = UPPER(loc_oObjeto.BaseClass)
568: 
569:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
570:                     *-- Preservar containers com Visible=.F. (ocultos intencionalmente)
571:                     IF loc_cBaseClass = "CONTAINER" AND !loc_oObjeto.Visible
572:                         *-- Nao alterar: container oculto intencional
573:                     ELSE
574:                         loc_oObjeto.Visible = .T.
575:                     ENDIF
576:                 ENDIF
577: 
578:                 *-- Trata PageFrame: itera Pages
579:                 IF loc_cBaseClass = "PAGEFRAME"
580:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
581:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
582:                     ENDFOR
583:                 ENDIF
584: 
585:                 *-- Trata containers com ControlCount
586:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
587:                     THIS.TornarControlesVisiveis(loc_oObjeto)
588:                 ENDIF
589:             ENDIF
590:         ENDFOR
591:     ENDPROC
592: 
593:     *--------------------------------------------------------------------------
594:     * FormatarGridLista - Formata visual do grid da lista
595:     *--------------------------------------------------------------------------
596:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
597:         WITH par_oGrid
598:             .FontName = "Verdana"
599:             .FontSize = 8
600:         ENDWITH
601:     ENDPROC
602: 
603:     *--------------------------------------------------------------------------
604:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
605:     *--------------------------------------------------------------------------
606:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
607:         LOCAL loc_lResultado
608:         loc_lResultado = .F.
609: 
610:         TRY
611:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
612:                 loc_lResultado = .F.
613:             ELSE
614:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
615:                 IF par_nPagina = 1
616:                     THIS.this_cModoAtual = "LISTA"
617:                     THIS.CarregarLista()
618:                     THIS.AjustarBotoesPorModo()
619:                 ENDIF
620:                 loc_lResultado = .T.
621:             ENDIF
622:         CATCH TO loc_oErro
623:             MostrarErro(loc_oErro, "Formcfo.AlternarPagina")
624:         ENDTRY
625: 
626:         RETURN loc_lResultado
627:     ENDPROC
628: 
629:     *--------------------------------------------------------------------------
630:     * BtnIncluirClick - Abre Page2 para inclusao de novo registro
631:     *--------------------------------------------------------------------------
632:     PROCEDURE BtnIncluirClick()
633:         TRY
634:             THIS.this_oBusinessObject.NovoRegistro()
635:             THIS.this_cModoAtual = "INCLUIR"
636:             THIS.LimparCampos()
637:             THIS.HabilitarCampos(.T.)
638:             THIS.AjustarBotoesPorModo()
639:             THIS.pgf_4c_Paginas.ActivePage = 2
640:             THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
641:         CATCH TO loc_oErro
642:             MostrarErro(loc_oErro, "Formcfo.BtnIncluirClick")
643:         ENDTRY
644:     ENDPROC
645: 
646:     *--------------------------------------------------------------------------
647:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
648:     *--------------------------------------------------------------------------
649:     PROCEDURE BtnVisualizarClick()
650:         LOCAL loc_cCodigo
651:         loc_cCodigo = ""
652: 
653:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
654:             SELECT cursor_4c_Dados
655:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
656:         ENDIF
657: 
658:         IF EMPTY(loc_cCodigo)
659:             MsgAviso("Selecione um registro na lista.", "Visualizar")
660:             RETURN
661:         ENDIF
662: 
663:         TRY
664:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
665:                 THIS.this_cModoAtual = "VISUALIZAR"
666:                 THIS.BOParaForm()
667:                 THIS.HabilitarCampos(.F.)
668:                 THIS.AjustarBotoesPorModo()
669:                 THIS.pgf_4c_Paginas.ActivePage = 2
670:             ELSE
671:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
672:             ENDIF
673:         CATCH TO loc_oErro
674:             MostrarErro(loc_oErro, "Formcfo.BtnVisualizarClick")
675:         ENDTRY
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     * BtnAlterarClick - Carrega registro selecionado para edicao
680:     *--------------------------------------------------------------------------
681:     PROCEDURE BtnAlterarClick()
682:         LOCAL loc_cCodigo
683:         loc_cCodigo = ""
684: 
685:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
686:             SELECT cursor_4c_Dados
687:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
688:         ENDIF
689: 
690:         IF EMPTY(loc_cCodigo)
691:             MsgAviso("Selecione um registro na lista.", "Alterar")
692:             RETURN
693:         ENDIF
694: 
695:         TRY
696:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
697:                 THIS.this_oBusinessObject.EditarRegistro()
698:                 THIS.this_cModoAtual = "ALTERAR"
699:                 THIS.BOParaForm()
700:                 THIS.HabilitarCampos(.T.)
701:                 THIS.AjustarBotoesPorModo()
702:                 THIS.pgf_4c_Paginas.ActivePage = 2
703:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Descricao.SetFocus()
704:             ELSE
705:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
706:             ENDIF
707:         CATCH TO loc_oErro
708:             MostrarErro(loc_oErro, "Formcfo.BtnAlterarClick")
709:         ENDTRY
710:     ENDPROC
711: 
712:     *--------------------------------------------------------------------------
713:     * BtnExcluirClick - Confirma e exclui o registro selecionado
714:     *--------------------------------------------------------------------------
715:     PROCEDURE BtnExcluirClick()
716:         LOCAL loc_cCodigo, loc_lConfirma
717:         loc_cCodigo  = ""
718:         loc_lConfirma = .F.
719: 
720:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
721:             SELECT cursor_4c_Dados
722:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
723:         ENDIF
724: 
725:         IF EMPTY(loc_cCodigo)
726:             MsgAviso("Selecione um registro na lista.", "Excluir")
727:             RETURN
728:         ENDIF
729: 
730:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do CFOP '" + ;
731:             loc_cCodigo + "'?", "Excluir")
732: 
733:         IF loc_lConfirma
734:             TRY
735:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
736:                     IF THIS.this_oBusinessObject.Excluir()
737:                         MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
738:                         THIS.CarregarLista()
739:                     ENDIF
740:                 ENDIF
741:             CATCH TO loc_oErro
742:                 MostrarErro(loc_oErro, "Formcfo.BtnExcluirClick")
743:             ENDTRY
744:         ENDIF
745:     ENDPROC
746: 
747:     *--------------------------------------------------------------------------
748:     * BtnBuscarClick - Abre busca auxiliar para localizar CFOP
749:     *--------------------------------------------------------------------------
750:     PROCEDURE BtnBuscarClick()
751:         LOCAL loc_oBusca
752:         loc_oBusca = .NULL.
753: 
754:         TRY
755:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
756:                 "SigCdCfo", "cursor_4c_BuscaCFO", "codigos", "", ;
757:                 "Buscar CFOP")
758: 
759:             IF VARTYPE(loc_oBusca) = "O"
760:                 IF !loc_oBusca.this_lAchouRegistro
761:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
762:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
763:                     loc_oBusca.Show()
764:                 ENDIF
765:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFO")
766:                     SELECT cursor_4c_BuscaCFO
767:                     GO TOP
768:                 ENDIF
769:                 loc_oBusca.Release()
770:                 loc_oBusca = .NULL.
771:             ENDIF
772:         CATCH TO loc_oErro
773:             MostrarErro(loc_oErro, "Formcfo.BtnBuscarClick")
774:         ENDTRY
775: 
776:         IF USED("cursor_4c_BuscaCFO")
777:             USE IN cursor_4c_BuscaCFO
778:         ENDIF
779: 
780:         THIS.CarregarLista()
781:     ENDPROC
782: 
783:     *--------------------------------------------------------------------------
784:     * BtnEncerrarClick - Fecha o formulario
785:     *--------------------------------------------------------------------------
786:     PROCEDURE BtnEncerrarClick()
787:         THIS.Release()
788:     ENDPROC
789: 
790:     *--------------------------------------------------------------------------
791:     * BtnExpXMLClick - Exporta CFOP selecionado para XML (via SigOpXml)
792:     *--------------------------------------------------------------------------
793:     PROCEDURE BtnExpXMLClick()
794:         LOCAL loc_cCodigo
795:         loc_cCodigo = ""
796: 
797:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
798:             SELECT cursor_4c_Dados
799:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
800:         ENDIF
801: 
802:         IF EMPTY(loc_cCodigo)
803:             MsgAviso("Selecione um registro para exportar.", "Exporta XML")
804:             RETURN
805:         ENDIF
806: 
807:         TRY
808:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
809:             THIS.CarregarLista()
810:             IF USED("cursor_4c_Dados")
811:                 SELECT cursor_4c_Dados
812:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
813:             ENDIF
814:         CATCH TO loc_oErro
815:             MostrarErro(loc_oErro, "Formcfo.BtnExpXMLClick")
816:         ENDTRY
817:     ENDPROC
818: 
819:     *--------------------------------------------------------------------------
820:     * BtnImpXMLClick - Importa CFOP de arquivo XML (via SigOpXml)
821:     *--------------------------------------------------------------------------
822:     PROCEDURE BtnImpXMLClick()
823:         LOCAL loc_cCodigo
824:         loc_cCodigo = ""
825: 
826:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
827:             SELECT cursor_4c_Dados
828:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
829:         ENDIF
830: 
831:         TRY
832:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "I", "CFOP", 10
833:             THIS.CarregarLista()
834:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
835:                 SELECT cursor_4c_Dados
836:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
837:             ENDIF
838:         CATCH TO loc_oErro
839:             MostrarErro(loc_oErro, "Formcfo.BtnImpXMLClick")
840:         ENDTRY
841:     ENDPROC
842: 
843:     *--------------------------------------------------------------------------
844:     * GrdListaDblClick - DblClick na lista abre visualizacao do registro
845:     *--------------------------------------------------------------------------
846:     PROCEDURE GrdListaDblClick()
847:         THIS.BtnVisualizarClick()
848:     ENDPROC
849: 
850:     *--------------------------------------------------------------------------
851:     * ConfigurarPaginaDadosParte1 - Page1 do PagDados: primeira metade (top < 236)
852:     *--------------------------------------------------------------------------
853:     PROTECTED PROCEDURE ConfigurarPaginaDadosParte1()
854:         LOCAL loc_oPag1
855:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
856: 
857:         *----------------------------------------------------------------------
858:         *-- Grupo 1: Cabecalho (top 0-90)
859:         *----------------------------------------------------------------------
860: 
861:         *-- Label Codigo
862:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
863:         WITH loc_oPag1.lbl_4c_Label1
864:             .Caption   = "C" + CHR(243) + "digo :"
865:             .Top       = 11
866:             .Left      = 91
867:             .Width     = 42
868:             .Height    = 15
869:             .FontName  = "Tahoma"
870:             .FontSize  = 8
871:             .BackStyle = 0
872:             .ForeColor = RGB(90, 90, 90)
873:             .Visible   = .T.
874:         ENDWITH
875: 
876:         *-- Codigo CFOP
877:         loc_oPag1.AddObject("txt_4c_Codigo", "TextBox")
878:         WITH loc_oPag1.txt_4c_Codigo
879:             .Top           = 7
880:             .Left          = 136
881:             .Width         = 91
882:             .Height        = 24
883:             .FontName      = "Tahoma"
884:             .FontSize      = 8
885:             .MaxLength     = 10
886:             .SpecialEffect = 1
887:             .ForeColor     = RGB(90, 90, 90)
888:             .BorderColor   = RGB(100, 100, 100)
889:             .Visible       = .T.
890:         ENDWITH
891: 
892:         *-- Situacao (Ativo/Inativo)
893:         loc_oPag1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
894:         WITH loc_oPag1.obj_4c_Opc_situacao
895:             .ButtonCount = 2
896:             .Top         = 11
897:             .Left        = 243
898:             .Width       = 137
899:             .Height      = 17
900:             .BorderStyle = 0
901:             .Visible     = .T.
902:         ENDWITH
903:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(1)
904:             .Caption   = "Ativo"
905:             .Left      = 0
906:             .Top       = 0
907:             .AutoSize  = .T.
908:             .FontName  = "Tahoma"
909:             .FontSize  = 8
910:             .ForeColor = RGB(90, 90, 90)
911:             .Themes    = .F.
912:         ENDWITH
913:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(2)
914:             .Caption   = "Inativo"
915:             .Left      = 60
916:             .Top       = 0
917:             .AutoSize  = .T.
918:             .FontName  = "Tahoma"
919:             .FontSize  = 8
920:             .ForeColor = RGB(90, 90, 90)
921:             .Themes    = .F.
922:         ENDWITH
923: 
924:         *-- Label Operacao
925:         loc_oPag1.AddObject("lbl_4c_Label3", "Label")
926:         WITH loc_oPag1.lbl_4c_Label3
927:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
928:             .Top       = 11
929:             .Left      = 393
930:             .Width     = 56
931:             .Height    = 15
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8

*-- Linhas 1739 a 1792:
1739:             .Visible       = .T.
1740:         ENDWITH
1741: 
1742:         *-- BINDEVENT para lookup fields (LostFocus abre FormBuscaAuxiliar)
1743:         BINDEVENT(loc_oPag1.txt_4c_CfoST60,  "LostFocus", THIS, "ValidarCfoST60")
1744:         BINDEVENT(loc_oPag1.txt_4c_CfoST,    "LostFocus", THIS, "ValidarCfoST")
1745:         BINDEVENT(loc_oPag1.txt_4c_Cfdest,   "LostFocus", THIS, "ValidarCfdest")
1746:         BINDEVENT(loc_oPag1.txt_4c_Sittricm, "LostFocus", THIS, "ValidarSittricm")
1747:     ENDPROC
1748: 
1749:     *--------------------------------------------------------------------------
1750:     * ConfigurarPaginaDadosParte2 - Page1 do PagDados: segunda metade (top >= 236)
1751:     *--------------------------------------------------------------------------
1752:     PROTECTED PROCEDURE ConfigurarPaginaDadosParte2()
1753:         LOCAL loc_oPag1
1754:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1755: 
1756:         *-- Linha separadora shp03 (top=236)
1757:         loc_oPag1.AddObject("shp_4c_Shp03", "Shape")
1758:         WITH loc_oPag1.shp_4c_Shp03
1759:             .Top         = 236
1760:             .Left        = 3
1761:             .Width       = 984
1762:             .Height      = 1
1763:             .BackStyle   = 1
1764:             .BackColor   = RGB(180, 180, 180)
1765:             .BorderStyle = 0
1766:             .Visible     = .T.
1767:         ENDWITH
1768: 
1769:         *-- Label "Especificacoes Para NF-e" (bold Verdana, top=246)
1770:         loc_oPag1.AddObject("lbl_4c_Label38", "Label")
1771:         WITH loc_oPag1.lbl_4c_Label38
1772:             .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
1773:             .Top       = 246
1774:             .Left      = 498
1775:             .Width     = 167
1776:             .Height    = 15
1777:             .FontName  = "Verdana"
1778:             .FontSize  = 8
1779:             .FontBold  = .T.
1780:             .BackStyle = 0
1781:             .ForeColor = RGB(90, 90, 90)
1782:             .Visible   = .T.
1783:         ENDWITH
1784: 
1785:         *----------------------------------------------------------------------
1786:         *-- Grupo IPI (lado esquerdo, top >= 263)
1787:         *----------------------------------------------------------------------
1788: 
1789:         *-- Label IPI
1790:         loc_oPag1.AddObject("lbl_4c_Label8", "Label")
1791:         WITH loc_oPag1.lbl_4c_Label8
1792:             .Caption   = "I P I :"

*-- Linhas 2482 a 2526:
2482:             .Visible   = .T.
2483:         ENDWITH
2484: 
2485:         *-- OptionGroup Codigo Tributacao ISSQN (ctissqn, 5 botoes: Normal/Retida/Substituta/Isenta/Nao Calcula)
2486:         loc_oPag1.AddObject("obj_4c_Fwoption1", "OptionGroup")
2487:         WITH loc_oPag1.obj_4c_Fwoption1
2488:             .Top         = 389
2489:             .Left        = 686
2490:             .Width       = 297
2491:             .Height      = 34
2492:             .ButtonCount = 5
2493:             .BorderStyle = 0
2494:             .Visible     = .T.
2495:         ENDWITH
2496:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(1)
2497:             .Caption   = "Normal"
2498:             .Left      = 4
2499:             .Top       = 0
2500:             .Height    = 15
2501:             .AutoSize  = .T.
2502:             .FontName  = "Verdana"
2503:             .FontSize  = 8
2504:             .ForeColor = RGB(90, 90, 90)
2505:         ENDWITH
2506:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(2)
2507:             .Caption   = "Retida"
2508:             .Left      = 72
2509:             .Top       = 0
2510:             .Height    = 15
2511:             .AutoSize  = .T.
2512:             .FontName  = "Verdana"
2513:             .FontSize  = 8
2514:             .ForeColor = RGB(90, 90, 90)
2515:         ENDWITH
2516:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(3)
2517:             .Caption   = "Substituta"
2518:             .Left      = 135
2519:             .Top       = 1
2520:             .Width     = 76
2521:             .Height    = 15
2522:             .AutoSize  = .T.
2523:             .FontName  = "Verdana"
2524:             .FontSize  = 8
2525:             .ForeColor = RGB(90, 90, 90)
2526:         ENDWITH

*-- Linhas 2560 a 2604:
2560:             .Visible   = .T.
2561:         ENDWITH
2562: 
2563:         *-- OptionGroup Informa Retencao de Tributacao (rettribs, 2 botoes: Sim/Nao)
2564:         loc_oPag1.AddObject("obj_4c_Fwoption2", "OptionGroup")
2565:         WITH loc_oPag1.obj_4c_Fwoption2
2566:             .Top         = 420
2567:             .Left        = 686
2568:             .Width       = 95
2569:             .Height      = 25
2570:             .ButtonCount = 2
2571:             .BorderStyle = 0
2572:             .Visible     = .T.
2573:         ENDWITH
2574:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(1)
2575:             .Caption   = "Sim"
2576:             .Left      = 5
2577:             .Top       = 5
2578:             .Height    = 15
2579:             .AutoSize  = .T.
2580:             .FontName  = "Tahoma"
2581:             .FontSize  = 8
2582:             .ForeColor = RGB(90, 90, 90)
2583:         ENDWITH
2584:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(2)
2585:             .Caption   = "N" + CHR(227) + "o"
2586:             .Left      = 53
2587:             .Top       = 5
2588:             .Height    = 15
2589:             .AutoSize  = .T.
2590:             .FontName  = "Tahoma"
2591:             .FontSize  = 8
2592:             .ForeColor = RGB(90, 90, 90)
2593:         ENDWITH
2594: 
2595:         *-- Label Aliquota do II
2596:         loc_oPag1.AddObject("lbl_4c_Label47", "Label")
2597:         WITH loc_oPag1.lbl_4c_Label47
2598:             .Caption   = "Al" + CHR(237) + "quota do II :"
2599:             .Top       = 425
2600:             .Left      = 820
2601:             .Width     = 89
2602:             .Height    = 15
2603:             .FontName  = "Verdana"
2604:             .FontSize  = 8

*-- Linhas 2638 a 2688:
2638:             .Visible   = .T.
2639:         ENDWITH
2640: 
2641:         *-- BINDEVENT: cmbIpiI.InteractiveChange -> habilita/desabilita Combo8
2642:         BINDEVENT(loc_oPag1.cbo_4c_CmbIpiI, "InteractiveChange", THIS, "AtualizarCombo8")
2643:     ENDPROC
2644: 
2645:     *--------------------------------------------------------------------------
2646:     * ConfigurarPaginaDadosPage2 - Page2 do PagDados: Integracao Contabil/Fiscal
2647:     *--------------------------------------------------------------------------
2648:     PROTECTED PROCEDURE ConfigurarPaginaDadosPage2()
2649:         LOCAL loc_oPag2
2650:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
2651: 
2652:         *----------------------------------------------------------------------
2653:         *-- Secao: Integracao Contabil (esquerda)
2654:         *----------------------------------------------------------------------
2655: 
2656:         *-- Label cabecalho secao Integracao Contabil
2657:         loc_oPag2.AddObject("lbl_4c_LblIntCont", "Label")
2658:         WITH loc_oPag2.lbl_4c_LblIntCont
2659:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
2660:             .Top       = 6
2661:             .Left      = 15
2662:             .Width     = 114
2663:             .Height    = 15
2664:             .FontName  = "Tahoma"
2665:             .FontSize  = 8
2666:             .FontBold  = .T.
2667:             .BackStyle = 0
2668:             .ForeColor = RGB(90, 90, 90)
2669:             .Visible   = .T.
2670:         ENDWITH
2671: 
2672:         *-- Label Valor Contabil
2673:         loc_oPag2.AddObject("lbl_4c_LblValorCont", "Label")
2674:         WITH loc_oPag2.lbl_4c_LblValorCont
2675:             .Caption   = "Valor Cont" + CHR(225) + "bil :"
2676:             .Top       = 34
2677:             .Left      = 84
2678:             .Width     = 75
2679:             .Height    = 15
2680:             .FontName  = "Tahoma"
2681:             .FontSize  = 8
2682:             .BackStyle = 0
2683:             .ForeColor = RGB(90, 90, 90)
2684:             .Visible   = .T.
2685:         ENDWITH
2686: 
2687:         *-- Label DB (Valor Contabil)
2688:         loc_oPag2.AddObject("lbl_4c_LblVcDB", "Label")

*-- Linhas 3078 a 3122:
3078:             .Visible   = .T.
3079:         ENDWITH
3080: 
3081:         *-- OptionGroup Agrupa CFO (agrupas: 1=Sim, 2=Nao)
3082:         loc_oPag2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
3083:         WITH loc_oPag2.obj_4c_OptAgrupas
3084:             .ButtonCount = 2
3085:             .Top         = 79
3086:             .Left        = 638
3087:             .Width       = 94
3088:             .Height      = 27
3089:             .BorderStyle = 0
3090:             .Visible     = .T.
3091:         ENDWITH
3092:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(1)
3093:             .Caption   = "Sim"
3094:             .Left      = 5
3095:             .Top       = 5
3096:             .Width     = 40
3097:             .Height    = 17
3098:             .AutoSize  = .F.
3099:             .FontName  = "Tahoma"
3100:             .FontSize  = 8
3101:             .ForeColor = RGB(90, 90, 90)
3102:             .Themes    = .F.
3103:         ENDWITH
3104:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(2)
3105:             .Caption   = "N" + CHR(227) + "o"
3106:             .Left      = 51
3107:             .Top       = 5
3108:             .Width     = 40
3109:             .Height    = 17
3110:             .AutoSize  = .F.
3111:             .FontName  = "Tahoma"
3112:             .FontSize  = 8
3113:             .ForeColor = RGB(90, 90, 90)
3114:             .Themes    = .F.
3115:         ENDWITH
3116: 
3117:         *-- Label Integracao Zerada
3118:         loc_oPag2.AddObject("lbl_4c_LblZeradas", "Label")
3119:         WITH loc_oPag2.lbl_4c_LblZeradas
3120:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
3121:             .Top       = 108
3122:             .Left      = 523

*-- Linhas 3129 a 3173:
3129:             .Visible   = .T.
3130:         ENDWITH
3131: 
3132:         *-- OptionGroup Integracao Zerada (zeradas: 1=Sim, 2=Nao)
3133:         loc_oPag2.AddObject("obj_4c_OptZeradas", "OptionGroup")
3134:         WITH loc_oPag2.obj_4c_OptZeradas
3135:             .ButtonCount = 2
3136:             .Top         = 103
3137:             .Left        = 638
3138:             .Width       = 94
3139:             .Height      = 27
3140:             .BorderStyle = 0
3141:             .Visible     = .T.
3142:         ENDWITH
3143:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(1)
3144:             .Caption   = "Sim"
3145:             .Left      = 5
3146:             .Top       = 5
3147:             .Width     = 40
3148:             .Height    = 17
3149:             .AutoSize  = .F.
3150:             .FontName  = "Tahoma"
3151:             .FontSize  = 8
3152:             .ForeColor = RGB(90, 90, 90)
3153:             .Themes    = .F.
3154:         ENDWITH
3155:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(2)
3156:             .Caption   = "N" + CHR(227) + "o"
3157:             .Left      = 51
3158:             .Top       = 5
3159:             .Width     = 40
3160:             .Height    = 17
3161:             .AutoSize  = .F.
3162:             .FontName  = "Tahoma"
3163:             .FontSize  = 8
3164:             .ForeColor = RGB(90, 90, 90)
3165:             .Themes    = .F.
3166:         ENDWITH
3167: 
3168:         *-- Label Data Lancamento Contabil
3169:         loc_oPag2.AddObject("lbl_4c_LblDtLanc", "Label")
3170:         WITH loc_oPag2.lbl_4c_LblDtLanc
3171:             .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
3172:             .Top       = 132
3173:             .Left      = 479

*-- Linhas 3180 a 3224:
3180:             .Visible   = .T.
3181:         ENDWITH
3182: 
3183:         *-- OptionGroup Data Lancamento Contabil (dtintfis: 1=Data Integracao, 2=Data N.F.)
3184:         loc_oPag2.AddObject("obj_4c_Fwoption1", "OptionGroup")
3185:         WITH loc_oPag2.obj_4c_Fwoption1
3186:             .ButtonCount = 2
3187:             .Top         = 127
3188:             .Left        = 638
3189:             .Width       = 192
3190:             .Height      = 27
3191:             .BorderStyle = 0
3192:             .Visible     = .T.
3193:         ENDWITH
3194:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(1)
3195:             .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
3196:             .Left      = 5
3197:             .Top       = 5
3198:             .Width     = 97
3199:             .Height    = 15
3200:             .AutoSize  = .F.
3201:             .FontName  = "Tahoma"
3202:             .FontSize  = 8
3203:             .ForeColor = RGB(90, 90, 90)
3204:             .Themes    = .F.
3205:         ENDWITH
3206:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(2)
3207:             .Caption   = "Data N.F."
3208:             .Left      = 122
3209:             .Top       = 7
3210:             .Width     = 65
3211:             .Height    = 15
3212:             .AutoSize  = .F.
3213:             .FontName  = "Tahoma"
3214:             .FontSize  = 8
3215:             .ForeColor = RGB(90, 90, 90)
3216:             .Themes    = .F.
3217:         ENDWITH
3218: 
3219:         *-- Label Utilizar variacao de CFOP na Integracao
3220:         loc_oPag2.AddObject("lbl_4c_LblUtilvars", "Label")
3221:         WITH loc_oPag2.lbl_4c_LblUtilvars
3222:             .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
3223:             .Top       = 156
3224:             .Left      = 390

*-- Linhas 3231 a 3275:
3231:             .Visible   = .T.
3232:         ENDWITH
3233: 
3234:         *-- OptionGroup Utilizar variacao CFOP (utilvars: 1=Sim, 2=Nao)
3235:         loc_oPag2.AddObject("obj_4c_Optutilvars", "OptionGroup")
3236:         WITH loc_oPag2.obj_4c_Optutilvars
3237:             .ButtonCount = 2
3238:             .Top         = 150
3239:             .Left        = 638
3240:             .Width       = 94
3241:             .Height      = 27
3242:             .BorderStyle = 0
3243:             .Visible     = .T.
3244:         ENDWITH
3245:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(1)
3246:             .Caption   = "Sim"
3247:             .Left      = 5
3248:             .Top       = 5
3249:             .Width     = 40
3250:             .Height    = 17
3251:             .AutoSize  = .F.
3252:             .FontName  = "Tahoma"
3253:             .FontSize  = 8
3254:             .ForeColor = RGB(90, 90, 90)
3255:             .Themes    = .F.
3256:         ENDWITH
3257:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(2)
3258:             .Caption   = "N" + CHR(227) + "o"
3259:             .Left      = 51
3260:             .Top       = 5
3261:             .Width     = 40
3262:             .Height    = 17
3263:             .AutoSize  = .F.
3264:             .FontName  = "Tahoma"
3265:             .FontSize  = 8
3266:             .ForeColor = RGB(90, 90, 90)
3267:             .Themes    = .F.
3268:         ENDWITH
3269: 
3270:         *----------------------------------------------------------------------
3271:         *-- Separador e secao Integracao Fiscal
3272:         *----------------------------------------------------------------------
3273: 
3274:         *-- Linha separadora horizontal
3275:         loc_oPag2.AddObject("shp_4c_Sep", "Shape")

*-- Linhas 3315 a 3359:
3315:             .Visible   = .T.
3316:         ENDWITH
3317: 
3318:         *-- OptionGroup Integrar Valor Contabil (intvlrcont: 1=Sim, 2=Nao)
3319:         loc_oPag2.AddObject("obj_4c_Fwoption2", "OptionGroup")
3320:         WITH loc_oPag2.obj_4c_Fwoption2
3321:             .ButtonCount = 2
3322:             .Top         = 233
3323:             .Left        = 231
3324:             .Width       = 94
3325:             .Height      = 27
3326:             .BorderStyle = 0
3327:             .Visible     = .T.
3328:         ENDWITH
3329:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(1)
3330:             .Caption   = "Sim"
3331:             .Left      = 5
3332:             .Top       = 5
3333:             .Width     = 40
3334:             .Height    = 17
3335:             .AutoSize  = .F.
3336:             .FontName  = "Tahoma"
3337:             .FontSize  = 8
3338:             .ForeColor = RGB(90, 90, 90)
3339:             .Themes    = .F.
3340:         ENDWITH
3341:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(2)
3342:             .Caption   = "N" + CHR(227) + "o"
3343:             .Left      = 51
3344:             .Top       = 5
3345:             .Width     = 40
3346:             .Height    = 17
3347:             .AutoSize  = .F.
3348:             .FontName  = "Tahoma"
3349:             .FontSize  = 8
3350:             .ForeColor = RGB(90, 90, 90)
3351:             .Themes    = .F.
3352:         ENDWITH
3353: 
3354:         *-- Label Integrar Valores Icms
3355:         loc_oPag2.AddObject("lbl_4c_LblIntvlricms", "Label")
3356:         WITH loc_oPag2.lbl_4c_LblIntvlricms
3357:             .Caption   = "Integrar Valores Icms :"
3358:             .Top       = 259
3359:             .Left      = 121

*-- Linhas 3366 a 3410:
3366:             .Visible   = .T.
3367:         ENDWITH
3368: 
3369:         *-- OptionGroup Integrar Valores Icms (intvlricms: 1=Sim, 2=Nao)
3370:         loc_oPag2.AddObject("obj_4c_Fwoption3", "OptionGroup")
3371:         WITH loc_oPag2.obj_4c_Fwoption3
3372:             .ButtonCount = 2
3373:             .Top         = 253
3374:             .Left        = 231
3375:             .Width       = 94
3376:             .Height      = 27
3377:             .BorderStyle = 0
3378:             .Visible     = .T.
3379:         ENDWITH
3380:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(1)
3381:             .Caption   = "Sim"
3382:             .Left      = 5
3383:             .Top       = 5
3384:             .Width     = 40
3385:             .Height    = 17
3386:             .AutoSize  = .F.
3387:             .FontName  = "Tahoma"
3388:             .FontSize  = 8
3389:             .ForeColor = RGB(90, 90, 90)
3390:             .Themes    = .F.
3391:         ENDWITH
3392:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(2)
3393:             .Caption   = "N" + CHR(227) + "o"
3394:             .Left      = 51
3395:             .Top       = 5
3396:             .Width     = 40
3397:             .Height    = 17
3398:             .AutoSize  = .F.
3399:             .FontName  = "Tahoma"
3400:             .FontSize  = 8
3401:             .ForeColor = RGB(90, 90, 90)
3402:             .Themes    = .F.
3403:         ENDWITH
3404: 
3405:         *-- Label Integrar Valores Ipi
3406:         loc_oPag2.AddObject("lbl_4c_LblIntvlripi", "Label")
3407:         WITH loc_oPag2.lbl_4c_LblIntvlripi
3408:             .Caption   = "Integrar Valores Ipi :"
3409:             .Top       = 278
3410:             .Left      = 131

*-- Linhas 3417 a 3461:
3417:             .Visible   = .T.
3418:         ENDWITH
3419: 
3420:         *-- OptionGroup Integrar Valores Ipi (intvlripi: 1=Sim, 2=Nao)
3421:         loc_oPag2.AddObject("obj_4c_Fwoption4", "OptionGroup")
3422:         WITH loc_oPag2.obj_4c_Fwoption4
3423:             .ButtonCount = 2
3424:             .Top         = 272
3425:             .Left        = 231
3426:             .Width       = 94
3427:             .Height      = 27
3428:             .BorderStyle = 0
3429:             .Visible     = .T.
3430:         ENDWITH
3431:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(1)
3432:             .Caption   = "Sim"
3433:             .Left      = 5
3434:             .Top       = 5
3435:             .Width     = 40
3436:             .Height    = 17
3437:             .AutoSize  = .F.
3438:             .FontName  = "Tahoma"
3439:             .FontSize  = 8
3440:             .ForeColor = RGB(90, 90, 90)
3441:             .Themes    = .F.
3442:         ENDWITH
3443:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(2)
3444:             .Caption   = "N" + CHR(227) + "o"
3445:             .Left      = 51
3446:             .Top       = 5
3447:             .Width     = 40
3448:             .Height    = 17
3449:             .AutoSize  = .F.
3450:             .FontName  = "Tahoma"
3451:             .FontSize  = 8
3452:             .ForeColor = RGB(90, 90, 90)
3453:             .Themes    = .F.
3454:         ENDWITH
3455: 
3456:         *-- Label Movimentacao Fisica de Estoque
3457:         loc_oPag2.AddObject("lbl_4c_LblIndmov", "Label")
3458:         WITH loc_oPag2.lbl_4c_LblIndmov
3459:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
3460:             .Top       = 298
3461:             .Left      = 69

*-- Linhas 3468 a 3512:
3468:             .Visible   = .T.
3469:         ENDWITH
3470: 
3471:         *-- OptionGroup Movimentacao Fisica de Estoque (indmov: 1=Sim, 2=Nao)
3472:         loc_oPag2.AddObject("obj_4c_Fwoption5", "OptionGroup")
3473:         WITH loc_oPag2.obj_4c_Fwoption5
3474:             .ButtonCount = 2
3475:             .Top         = 292
3476:             .Left        = 231
3477:             .Width       = 94
3478:             .Height      = 27
3479:             .BorderStyle = 0
3480:             .Visible     = .T.
3481:         ENDWITH
3482:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(1)
3483:             .Caption   = "Sim"
3484:             .Left      = 5
3485:             .Top       = 5
3486:             .Width     = 40
3487:             .Height    = 17
3488:             .AutoSize  = .F.
3489:             .FontName  = "Tahoma"
3490:             .FontSize  = 8
3491:             .ForeColor = RGB(90, 90, 90)
3492:             .Themes    = .F.
3493:         ENDWITH
3494:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(2)
3495:             .Caption   = "N" + CHR(227) + "o"
3496:             .Left      = 51
3497:             .Top       = 5
3498:             .Width     = 40
3499:             .Height    = 17
3500:             .AutoSize  = .F.
3501:             .FontName  = "Tahoma"
3502:             .FontSize  = 8
3503:             .ForeColor = RGB(90, 90, 90)
3504:             .Themes    = .F.
3505:         ENDWITH
3506: 
3507:         *-- Label Indicacao de Pagamento
3508:         loc_oPag2.AddObject("lbl_4c_LblIndpagto", "Label")
3509:         WITH loc_oPag2.lbl_4c_LblIndpagto
3510:             .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
3511:             .Top       = 318
3512:             .Left      = 106

*-- Linhas 3519 a 3946:
3519:             .Visible   = .T.
3520:         ENDWITH
3521: 
3522:         *-- OptionGroup Indicacao de Pagamento (indpagto: 1=Sim, 2=Nao)
3523:         loc_oPag2.AddObject("obj_4c_Fwoption6", "OptionGroup")
3524:         WITH loc_oPag2.obj_4c_Fwoption6
3525:             .ButtonCount = 2
3526:             .Top         = 312
3527:             .Left        = 231
3528:             .Width       = 94
3529:             .Height      = 27
3530:             .BorderStyle = 0
3531:             .Visible     = .T.
3532:         ENDWITH
3533:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(1)
3534:             .Caption   = "Sim"
3535:             .Left      = 5
3536:             .Top       = 5
3537:             .Width     = 40
3538:             .Height    = 17
3539:             .AutoSize  = .F.
3540:             .FontName  = "Tahoma"
3541:             .FontSize  = 8
3542:             .ForeColor = RGB(90, 90, 90)
3543:             .Themes    = .F.
3544:         ENDWITH
3545:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(2)
3546:             .Caption   = "N" + CHR(227) + "o"
3547:             .Left      = 51
3548:             .Top       = 5
3549:             .Width     = 40
3550:             .Height    = 17
3551:             .AutoSize  = .F.
3552:             .FontName  = "Tahoma"
3553:             .FontSize  = 8
3554:             .ForeColor = RGB(90, 90, 90)
3555:             .Themes    = .F.
3556:         ENDWITH
3557: 
3558:         *-- BINDEVENT para validacao de contas contabeis (LostFocus)
3559:         BINDEVENT(loc_oPag2.txt_4c_ContFrt, "LostFocus", THIS, "ValidarContFrt")
3560:         BINDEVENT(loc_oPag2.txt_4c_ContSeg, "LostFocus", THIS, "ValidarContSeg")
3561:         BINDEVENT(loc_oPag2.txt_4c_ContDa,  "LostFocus", THIS, "ValidarContDa")
3562:     ENDPROC
3563: 
3564:     *--------------------------------------------------------------------------
3565:     * AtualizarCombo8 - Habilita/desabilita Combo8 conforme cmbIpiI (IPI Importacao)
3566:     *--------------------------------------------------------------------------
3567:     PROCEDURE AtualizarCombo8()
3568:         LOCAL loc_oPag1
3569:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3570:         TRY
3571:             loc_oPag1.cbo_4c_Combo8.Enabled = ;
3572:                 (UPPER(LEFT(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbIpiI.Value, "")), 1)) = "S")
3573:         CATCH TO loc_oErro
3574:             MostrarErro(loc_oErro, "Formcfo.AtualizarCombo8")
3575:         ENDTRY
3576:     ENDPROC
3577: 
3578:     *--------------------------------------------------------------------------
3579:     * ValidarContFrt - Valida Conta de Frete contra SigCdCli (LostFocus)
3580:     *--------------------------------------------------------------------------
3581:     PROCEDURE ValidarContFrt()
3582:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3583:         IF gb_4c_ValidandoUI
3584:             RETURN
3585:         ENDIF
3586:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3587:         loc_cConta = ""
3588:         loc_nRows  = 0
3589:         TRY
3590:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContFrt.Value, ""))
3591:             IF NOT EMPTY(loc_cConta)
3592:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3593:                     "SELECT COUNT(*) AS nTotalRecs FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
3594:                     "cursor_4c_ContFrt")
3595:                 IF loc_nRows > 0 AND cursor_4c_ContFrt.nTotalRecs = 0
3596:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3597:                     loc_oPag2.txt_4c_ContFrt.SetFocus()
3598:                 ENDIF
3599:                 USE IN SELECT("cursor_4c_ContFrt")
3600:             ENDIF
3601:         CATCH TO loc_oErro
3602:             MostrarErro(loc_oErro, "Formcfo.ValidarContFrt")
3603:         ENDTRY
3604:     ENDPROC
3605: 
3606:     *--------------------------------------------------------------------------
3607:     * ValidarContSeg - Valida Conta de Seguro contra SigCdCli (LostFocus)
3608:     *--------------------------------------------------------------------------
3609:     PROCEDURE ValidarContSeg()
3610:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3611:         IF gb_4c_ValidandoUI
3612:             RETURN
3613:         ENDIF
3614:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3615:         loc_cConta = ""
3616:         loc_nRows  = 0
3617:         TRY
3618:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContSeg.Value, ""))
3619:             IF NOT EMPTY(loc_cConta)
3620:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3621:                     "SELECT COUNT(*) AS nTotalRecs FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
3622:                     "cursor_4c_ContSeg")
3623:                 IF loc_nRows > 0 AND cursor_4c_ContSeg.nTotalRecs = 0
3624:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3625:                     loc_oPag2.txt_4c_ContSeg.SetFocus()
3626:                 ENDIF
3627:                 USE IN SELECT("cursor_4c_ContSeg")
3628:             ENDIF
3629:         CATCH TO loc_oErro
3630:             MostrarErro(loc_oErro, "Formcfo.ValidarContSeg")
3631:         ENDTRY
3632:     ENDPROC
3633: 
3634:     *--------------------------------------------------------------------------
3635:     * ValidarContDa - Valida Conta de Despesas contra SigCdCli (LostFocus)
3636:     *--------------------------------------------------------------------------
3637:     PROCEDURE ValidarContDa()
3638:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3639:         IF gb_4c_ValidandoUI
3640:             RETURN
3641:         ENDIF
3642:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3643:         loc_cConta = ""
3644:         loc_nRows  = 0
3645:         TRY
3646:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContDa.Value, ""))
3647:             IF NOT EMPTY(loc_cConta)
3648:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3649:                     "SELECT COUNT(*) AS nTotalRecs FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
3650:                     "cursor_4c_ContDa")
3651:                 IF loc_nRows > 0 AND cursor_4c_ContDa.nTotalRecs = 0
3652:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3653:                     loc_oPag2.txt_4c_ContDa.SetFocus()
3654:                 ENDIF
3655:                 USE IN SELECT("cursor_4c_ContDa")
3656:             ENDIF
3657:         CATCH TO loc_oErro
3658:             MostrarErro(loc_oErro, "Formcfo.ValidarContDa")
3659:         ENDTRY
3660:     ENDPROC
3661: 
3662:     *--------------------------------------------------------------------------
3663:     * BtnSalvarClick - Confirma o registro (Incluir ou Alterar)
3664:     *--------------------------------------------------------------------------
3665:     PROCEDURE BtnSalvarClick()
3666:         LOCAL loc_lResultado, loc_oPag1
3667:         loc_lResultado = .F.
3668:         loc_oPag1      = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3669: 
3670:         *-- Validacoes basicas ANTES do TRY
3671:         IF EMPTY(ALLTRIM(loc_oPag1.txt_4c_Codigo.Value))
3672:             MsgAviso("C" + CHR(243) + "digo em branco.", "Confirmar")
3673:             loc_oPag1.txt_4c_Codigo.SetFocus()
3674:             RETURN
3675:         ENDIF
3676: 
3677:         IF EMPTY(ALLTRIM(loc_oPag1.txt_4c_Descricao.Value))
3678:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida.", "Confirmar")
3679:             loc_oPag1.txt_4c_Descricao.SetFocus()
3680:             RETURN
3681:         ENDIF
3682: 
3683:         TRY
3684:             THIS.FormParaBO()
3685:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
3686:             IF loc_lResultado
3687:                 MsgSucesso("Registro salvo com sucesso!")
3688:                 THIS.AlternarPagina(1)
3689:             ENDIF
3690:         CATCH TO loc_oErro
3691:             MostrarErro(loc_oErro, "Formcfo.BtnSalvarClick")
3692:         ENDTRY
3693:     ENDPROC
3694: 
3695:     *--------------------------------------------------------------------------
3696:     * BtnCancelarClick - Cancela e volta para a lista
3697:     *--------------------------------------------------------------------------
3698:     PROCEDURE BtnCancelarClick()
3699:         TRY
3700:             THIS.this_oBusinessObject.CancelarEdicao()
3701:         CATCH TO loc_oErro
3702:             *-- Ignora erro se CancelarEdicao nao existir no BO base
3703:         ENDTRY
3704:         THIS.AlternarPagina(1)
3705:     ENDPROC
3706: 
3707:     *--------------------------------------------------------------------------
3708:     * ValidarCfoST60 - Lookup CFOP ST60 via FormBuscaAuxiliar
3709:     *--------------------------------------------------------------------------
3710:     PROCEDURE ValidarCfoST60()
3711:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3712:         loc_oBusca  = .NULL.
3713:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3714:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))
3715: 
3716:         *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
3717:         IF loc_cCodAtual == THIS.this_cUltimoValidarCfoST60Validado
3718:             RETURN
3719:         ENDIF
3720: 
3721:         IF EMPTY(loc_cCodAtual)
3722:             THIS.this_cUltimoValidarCfoST60Validado = loc_cCodAtual
3723:             RETURN
3724:         ENDIF
3725: 
3726:         TRY
3727:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3728:                 "SigCdCfo", "cursor_4c_BuscaCfoST60", "codigos", ;
3729:                 loc_cCodAtual, ;
3730:                 "CFOP ST60")
3731: 
3732:             IF VARTYPE(loc_oBusca) = "O"
3733:                 IF !loc_oBusca.this_lAchouRegistro
3734:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3735:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3736:                     loc_oBusca.Show()
3737:                 ENDIF
3738:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
3739:                     SELECT cursor_4c_BuscaCfoST60
3740:                     loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
3741:                 ENDIF
3742:                 loc_oBusca.Release()
3743:                 loc_oBusca = .NULL.
3744:             ENDIF
3745:         CATCH TO loc_oErro
3746:             MostrarErro(loc_oErro, "Formcfo.ValidarCfoST60")
3747:         ENDTRY
3748: 
3749:         THIS.this_cUltimoValidarCfoST60Validado = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))
3750: 
3751:         IF USED("cursor_4c_BuscaCfoST60")
3752:             USE IN cursor_4c_BuscaCfoST60
3753:         ENDIF
3754:     ENDPROC
3755: 
3756:     *--------------------------------------------------------------------------
3757:     * ValidarCfoST - Lookup CFOP Subst.Trib. via FormBuscaAuxiliar
3758:     *--------------------------------------------------------------------------
3759:     PROCEDURE ValidarCfoST()
3760:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3761:         loc_oBusca  = .NULL.
3762:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3763:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))
3764: 
3765:         *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
3766:         IF loc_cCodAtual == THIS.this_cUltimoValidarCfoSTValidado
3767:             RETURN
3768:         ENDIF
3769: 
3770:         IF EMPTY(loc_cCodAtual)
3771:             THIS.this_cUltimoValidarCfoSTValidado = loc_cCodAtual
3772:             RETURN
3773:         ENDIF
3774: 
3775:         TRY
3776:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3777:                 "SigCdCfo", "cursor_4c_BuscaCfoST", "codigos", ;
3778:                 loc_cCodAtual, ;
3779:                 "CFOP Subst.Trib.")
3780: 
3781:             IF VARTYPE(loc_oBusca) = "O"
3782:                 IF !loc_oBusca.this_lAchouRegistro
3783:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3784:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3785:                     loc_oBusca.Show()
3786:                 ENDIF
3787:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
3788:                     SELECT cursor_4c_BuscaCfoST
3789:                     loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
3790:                 ENDIF
3791:                 loc_oBusca.Release()
3792:                 loc_oBusca = .NULL.
3793:             ENDIF
3794:         CATCH TO loc_oErro
3795:             MostrarErro(loc_oErro, "Formcfo.ValidarCfoST")
3796:         ENDTRY
3797: 
3798:         THIS.this_cUltimoValidarCfoSTValidado = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))
3799: 
3800:         IF USED("cursor_4c_BuscaCfoST")
3801:             USE IN cursor_4c_BuscaCfoST
3802:         ENDIF
3803:     ENDPROC
3804: 
3805:     *--------------------------------------------------------------------------
3806:     * ValidarCfdest - Lookup CFOP Destino via FormBuscaAuxiliar
3807:     *--------------------------------------------------------------------------
3808:     PROCEDURE ValidarCfdest()
3809:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3810:         loc_oBusca  = .NULL.
3811:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3812:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))
3813: 
3814:         *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
3815:         IF loc_cCodAtual == THIS.this_cUltimoValidarCfdestValidado
3816:             RETURN
3817:         ENDIF
3818: 
3819:         IF EMPTY(loc_cCodAtual)
3820:             THIS.this_cUltimoValidarCfdestValidado = loc_cCodAtual
3821:             RETURN
3822:         ENDIF
3823: 
3824:         TRY
3825:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3826:                 "SigCdCfo", "cursor_4c_BuscaCfdest", "codigos", ;
3827:                 loc_cCodAtual, ;
3828:                 "CFOP Destino")
3829: 
3830:             IF VARTYPE(loc_oBusca) = "O"
3831:                 IF !loc_oBusca.this_lAchouRegistro
3832:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3833:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3834:                     loc_oBusca.Show()
3835:                 ENDIF
3836:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
3837:                     SELECT cursor_4c_BuscaCfdest
3838:                     loc_oPag1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
3839:                 ENDIF
3840:                 loc_oBusca.Release()
3841:                 loc_oBusca = .NULL.
3842:             ENDIF
3843:         CATCH TO loc_oErro
3844:             MostrarErro(loc_oErro, "Formcfo.ValidarCfdest")
3845:         ENDTRY
3846: 
3847:         THIS.this_cUltimoValidarCfdestValidado = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))
3848: 
3849:         IF USED("cursor_4c_BuscaCfdest")
3850:             USE IN cursor_4c_BuscaCfdest
3851:         ENDIF
3852:     ENDPROC
3853: 
3854:     *--------------------------------------------------------------------------
3855:     * ValidarSittricm - Lookup Situacao Tributaria ICMS via FormBuscaAuxiliar
3856:     *--------------------------------------------------------------------------
3857:     PROCEDURE ValidarSittricm()
3858:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3859:         loc_oBusca  = .NULL.
3860:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3861:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))
3862: 
3863:         *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
3864:         IF loc_cCodAtual == THIS.this_cUltimoValidarSittricmValidado
3865:             RETURN
3866:         ENDIF
3867: 
3868:         IF EMPTY(loc_cCodAtual)
3869:             THIS.this_cUltimoValidarSittricmValidado = loc_cCodAtual
3870:             RETURN
3871:         ENDIF
3872: 
3873:         TRY
3874:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3875:                 "SigCdIcm", "cursor_4c_BuscaIcm", "codigos", ;
3876:                 loc_cCodAtual, ;
3877:                 "Tributa" + CHR(231) + CHR(227) + "o ICMS")
3878: 
3879:             IF VARTYPE(loc_oBusca) = "O"
3880:                 IF !loc_oBusca.this_lAchouRegistro
3881:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3882:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3883:                     loc_oBusca.Show()
3884:                 ENDIF
3885:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
3886:                     SELECT cursor_4c_BuscaIcm
3887:                     loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.codigos)
3888:                 ENDIF
3889:                 loc_oBusca.Release()
3890:                 loc_oBusca = .NULL.
3891:             ENDIF
3892:         CATCH TO loc_oErro
3893:             MostrarErro(loc_oErro, "Formcfo.ValidarSittricm")
3894:         ENDTRY
3895: 
3896:         THIS.this_cUltimoValidarSittricmValidado = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))
3897: 
3898:         IF USED("cursor_4c_BuscaIcm")
3899:             USE IN cursor_4c_BuscaIcm
3900:         ENDIF
3901:     ENDPROC
3902: 
3903:     *--------------------------------------------------------------------------
3904:     * FormParaBO - Transfere valores da tela para o Business Object (parte 1)
3905:     *--------------------------------------------------------------------------
3906:     PROTECTED PROCEDURE FormParaBO()
3907:         LOCAL loc_oPag1, loc_oBO
3908:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3909:         loc_oBO   = THIS.this_oBusinessObject
3910: 
3911:         TRY
3912:             *-- Dados principais
3913:             loc_oBO.this_cCodigos    = ALLTRIM(NVL(loc_oPag1.txt_4c_Codigo.Value, ""))
3914:             loc_oBO.this_cDescricaos = ALLTRIM(NVL(loc_oPag1.txt_4c_Descricao.Value, ""))
3915:             loc_oBO.this_cDesc2s     = ALLTRIM(NVL(loc_oPag1.txt_4c_Desc2s.Value, ""))
3916:             loc_oBO.this_nSituas     = IIF(loc_oPag1.obj_4c_Opc_situacao.Value = 1, 1, 0)
3917:             loc_oBO.this_cOperacaos  = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbOperacao.Value, ""))), 1)
3918:             loc_oBO.this_nTipos      = VAL(NVL(loc_oPag1.cbo_4c_Cmbtipo.Value, "0"))
3919:             loc_oBO.this_nNdigitos   = loc_oPag1.obj_4c_Ndigito.Value
3920: 
3921:             *-- ICMS
3922:             loc_oBO.this_cIcms       = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbIcms.Value, ""))), 1)
3923:             loc_oBO.this_nInclicms   = loc_oPag1.cbo_4c_Combo3.ListIndex
3924:             loc_oBO.this_nIcmsdscs   = loc_oPag1.cbo_4c_Combo6.ListIndex
3925:             loc_oBO.this_cCfost60s   = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))
3926:             loc_oBO.this_cCfosts     = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))
3927:             loc_oBO.this_cCoddests   = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))
3928:             loc_oBO.this_nFrticms    = IIF(loc_oPag1.chk_4c_ObjFreteICM.Value, 1, 0)
3929:             loc_oBO.this_nSegicms    = IIF(loc_oPag1.chk_4c_ObjSegIcm.Value, 1, 0)
3930:             loc_oBO.this_nDesicms    = IIF(loc_oPag1.chk_4c_ObjDespIcm.Value, 1, 0)
3931:             loc_oBO.this_nIncicmnfs  = IIF(loc_oPag1.chk_4c_Fwcheckbox1.Value, 1, 0)
3932:             loc_oBO.this_nSomaicmfrete = IIF(loc_oPag1.chk_4c_Fwcheckbox2.Value, 1, 0)
3933:             loc_oBO.this_cSubtribs   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbSTRIB.Value, ""))), 1)
3934:             loc_oBO.this_nPbcsts     = VAL(NVL(loc_oPag1.txt_4c_Bcst.Value, "0"))
3935:             loc_oBO.this_nTransps    = loc_oPag1.cbo_4c_Combo5.ListIndex
3936:             loc_oBO.this_nIcmsincs   = loc_oPag1.cbo_4c_Combo10.ListIndex
3937:             loc_oBO.this_cSittribs   = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))
3938:             loc_oBO.this_cContribs   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbContribuinte.Value, ""))), 1)
3939:             loc_oBO.this_nAliqivcs   = VAL(NVL(loc_oPag1.txt_4c_AliqIVCs.Value, "0"))
3940:             loc_oBO.this_cMotdeson   = ALLTRIM(NVL(loc_oPag1.txt_4c_MotDeson.Value, ""))
3941:             loc_oBO.this_cUnitimps   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_Combo9.Value, ""))), 1)
3942:             loc_oBO.this_cIpiIcms    = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_Combo4.Value, ""))), 1)
3943: 
3944:             *-- IPI (Parte 2)
3945:             loc_oBO.this_cIpis       = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbIpi.Value, ""))), 1)
3946:             loc_oBO.this_nAliqipis   = VAL(NVL(loc_oPag1.txt_4c_Aliqs.Value, "0"))

*-- Linhas 4009 a 4052:
4009:     *--------------------------------------------------------------------------
4010:     * BOParaForm - Transfere valores do Business Object para a tela (parte 1)
4011:     *--------------------------------------------------------------------------
4012:     PROTECTED PROCEDURE BOParaForm()
4013:         LOCAL loc_oPag1, loc_oBO
4014:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4015:         loc_oBO   = THIS.this_oBusinessObject
4016: 
4017:         TRY
4018:             *-- Dados principais
4019:             loc_oPag1.txt_4c_Codigo.Value    = ALLTRIM(NVL(loc_oBO.this_cCodigos, ""))
4020:             loc_oPag1.txt_4c_Descricao.Value = ALLTRIM(NVL(loc_oBO.this_cDescricaos, ""))
4021:             loc_oPag1.txt_4c_Desc2s.Value    = ALLTRIM(NVL(loc_oBO.this_cDesc2s, ""))
4022:             loc_oPag1.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)
4023:             loc_oPag1.obj_4c_Ndigito.Value      = loc_oBO.this_nNdigitos
4024: 
4025:             *-- Operacao
4026:             loc_oPag1.cbo_4c_CmbOperacao.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cOperacaos)) = "E", ;
4027:                 "Entrada", "Sa" + CHR(237) + "da")
4028: 
4029:             *-- Tipo
4030:             loc_oPag1.cbo_4c_Cmbtipo.Value = LTRIM(STR(loc_oBO.this_nTipos))
4031: 
4032:             *-- ICMS regime
4033:             LOCAL loc_cIcmsDisplay
4034:             DO CASE
4035:                 CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "O"
4036:                     loc_cIcmsDisplay = "Outros"
4037:                 CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "I"
4038:                     loc_cIcmsDisplay = "Isento"
4039:                 CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "N"
4040:                     loc_cIcmsDisplay = "N Tributa"
4041:                 OTHERWISE
4042:                     loc_cIcmsDisplay = "Tributado"
4043:             ENDCASE
4044:             loc_oPag1.cbo_4c_CmbIcms.Value = loc_cIcmsDisplay
4045: 
4046:             *-- Incluir ICMS (ListIndex = valor numerico)
4047:             loc_oPag1.cbo_4c_Combo3.ListIndex  = loc_oBO.this_nInclicms
4048:             loc_oPag1.cbo_4c_Combo6.ListIndex  = loc_oBO.this_nIcmsdscs
4049:             loc_oPag1.cbo_4c_Combo10.ListIndex = loc_oBO.this_nIcmsincs
4050:             loc_oPag1.cbo_4c_Combo5.ListIndex  = loc_oBO.this_nTransps
4051: 
4052:             *-- CFOP lookups

*-- Linhas 4202 a 4245:
4202:     *--------------------------------------------------------------------------
4203:     * LimparCampos - Limpa todos os campos do Page1 (parte 1) para novo registro
4204:     *--------------------------------------------------------------------------
4205:     PROTECTED PROCEDURE LimparCampos()
4206:         LOCAL loc_oPag1
4207:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4208: 
4209:         TRY
4210:             *-- Dados principais
4211:             loc_oPag1.txt_4c_Codigo.Value    = ""
4212:             loc_oPag1.txt_4c_Descricao.Value = ""
4213:             loc_oPag1.txt_4c_Desc2s.Value    = ""
4214:             loc_oPag1.obj_4c_Opc_situacao.Value  = 1
4215:             loc_oPag1.obj_4c_Ndigito.Value        = 0
4216:             loc_oPag1.cbo_4c_CmbOperacao.ListIndex = 1
4217:             loc_oPag1.cbo_4c_Cmbtipo.ListIndex     = 1
4218: 
4219:             *-- ICMS
4220:             loc_oPag1.cbo_4c_CmbIcms.ListIndex    = 1
4221:             loc_oPag1.cbo_4c_Combo3.ListIndex      = 1
4222:             loc_oPag1.cbo_4c_Combo6.ListIndex      = 2
4223:             loc_oPag1.cbo_4c_Combo10.ListIndex     = 2
4224:             loc_oPag1.cbo_4c_Combo5.ListIndex      = 2
4225:             loc_oPag1.txt_4c_CfoST60.Value         = ""
4226:             loc_oPag1.txt_4c_CfoST.Value           = ""
4227:             loc_oPag1.txt_4c_Cfdest.Value          = ""
4228:             loc_oPag1.chk_4c_ObjFreteICM.Value     = 0
4229:             loc_oPag1.chk_4c_ObjSegIcm.Value       = 0
4230:             loc_oPag1.chk_4c_ObjDespIcm.Value      = 0
4231:             loc_oPag1.chk_4c_Fwcheckbox1.Value     = 0
4232:             loc_oPag1.chk_4c_Fwcheckbox2.Value     = 0
4233:             loc_oPag1.cbo_4c_CmbSTRIB.ListIndex    = 2
4234:             loc_oPag1.txt_4c_Bcst.Value            = "  0.00"
4235:             loc_oPag1.txt_4c_Sittricm.Value        = ""
4236:             loc_oPag1.cbo_4c_CmbContribuinte.ListIndex = 2
4237:             loc_oPag1.txt_4c_AliqIVCs.Value        = " 0.00"
4238:             loc_oPag1.txt_4c_MotDeson.Value        = ""
4239:             loc_oPag1.cbo_4c_Combo9.ListIndex      = 2
4240:             loc_oPag1.cbo_4c_Combo4.ListIndex      = 2
4241: 
4242:             *-- IPI / NF-e (Parte 2)
4243:             loc_oPag1.cbo_4c_CmbIpi.ListIndex      = 1   && Tributado
4244:             loc_oPag1.txt_4c_Aliqs.Value           = " 0.00"
4245:             loc_oPag1.cbo_4c_CmbIpiI.ListIndex     = 2   && Nao (ipiimpors)

*-- Linhas 4285 a 4348:
4285:             loc_oPag2C.cbo_4c_Combo2.ListIndex = 2   && Nao-Nenhuma
4286:             loc_oPag2C.cbo_4c_CmbFixa.Value    = "N" + CHR(227) + "o (CFOP)"
4287: 
4288:             *-- OptionGroups (defaults: Nao)
4289:             loc_oPag2C.obj_4c_OptAgrupas.Value  = 2   && Nao
4290:             loc_oPag2C.obj_4c_OptZeradas.Value  = 2   && Nao
4291:             loc_oPag2C.obj_4c_Fwoption1.Value   = 1   && Data Integracao (default)
4292:             loc_oPag2C.obj_4c_Optutilvars.Value = 2   && Nao
4293:             loc_oPag2C.obj_4c_Fwoption2.Value   = 2   && Nao
4294:             loc_oPag2C.obj_4c_Fwoption3.Value   = 2   && Nao
4295:             loc_oPag2C.obj_4c_Fwoption4.Value   = 2   && Nao
4296:             loc_oPag2C.obj_4c_Fwoption5.Value   = 2   && Nao
4297:             loc_oPag2C.obj_4c_Fwoption6.Value   = 2   && Nao
4298: 
4299:         CATCH TO loc_oErro
4300:             MostrarErro(loc_oErro, "Formcfo.LimparCampos")
4301:         ENDTRY
4302:     ENDPROC
4303: 
4304:     *--------------------------------------------------------------------------
4305:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
4306:     * par_lHabilitar = .T. para editar, .F. para somente leitura (VISUALIZAR)
4307:     *--------------------------------------------------------------------------
4308:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
4309:         LOCAL loc_oPag1, loc_oPag2, loc_lHabCodigo
4310: 
4311:         *-- Codigo editavel apenas em INCLUIR (nunca em ALTERAR)
4312:         loc_lHabCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
4313: 
4314:         TRY
4315:             loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4316: 
4317:             *-- Codigo (apenas INCLUIR)
4318:             loc_oPag1.txt_4c_Codigo.Enabled   = loc_lHabCodigo
4319:             *-- Spinner digitos
4320:             loc_oPag1.obj_4c_Ndigito.Enabled  = par_lHabilitar
4321: 
4322:             *-- Descricoes
4323:             loc_oPag1.txt_4c_Descricao.Enabled   = par_lHabilitar
4324:             loc_oPag1.txt_4c_Desc2s.Enabled      = par_lHabilitar
4325: 
4326:             *-- Combos / situacao
4327:             loc_oPag1.obj_4c_Opc_situacao.Enabled  = par_lHabilitar
4328:             loc_oPag1.cbo_4c_CmbOperacao.Enabled   = par_lHabilitar
4329:             loc_oPag1.cbo_4c_Cmbtipo.Enabled       = par_lHabilitar
4330: 
4331:             *-- ICMS
4332:             loc_oPag1.cbo_4c_CmbIcms.Enabled       = par_lHabilitar
4333:             loc_oPag1.cbo_4c_Combo3.Enabled         = par_lHabilitar
4334:             loc_oPag1.cbo_4c_Combo6.Enabled         = par_lHabilitar
4335:             loc_oPag1.cbo_4c_Combo10.Enabled        = par_lHabilitar
4336:             loc_oPag1.cbo_4c_CmbSTRIB.Enabled       = par_lHabilitar
4337:             loc_oPag1.cbo_4c_Combo5.Enabled         = par_lHabilitar
4338:             loc_oPag1.cbo_4c_Combo9.Enabled         = par_lHabilitar
4339:             loc_oPag1.cbo_4c_CmbContribuinte.Enabled = par_lHabilitar
4340:             loc_oPag1.txt_4c_Bcst.Enabled           = par_lHabilitar
4341:             loc_oPag1.txt_4c_CfoST60.Enabled        = par_lHabilitar
4342:             loc_oPag1.txt_4c_CfoST.Enabled          = par_lHabilitar
4343:             loc_oPag1.txt_4c_Cfdest.Enabled         = par_lHabilitar
4344:             loc_oPag1.txt_4c_Sittricm.Enabled       = par_lHabilitar
4345:             loc_oPag1.txt_4c_AliqIVCs.Enabled       = par_lHabilitar
4346:             loc_oPag1.txt_4c_MotDeson.Enabled       = par_lHabilitar
4347:             loc_oPag1.txt_4c_Gergia1.Enabled        = par_lHabilitar
4348:             loc_oPag1.chk_4c_ObjFreteICM.Enabled    = par_lHabilitar

*-- Linhas 4411 a 4455:
4411:     *--------------------------------------------------------------------------
4412:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
4413:     *--------------------------------------------------------------------------
4414:     PROTECTED PROCEDURE AjustarBotoesPorModo()
4415:         LOCAL loc_oPg2, loc_lEmEdicao
4416: 
4417:         *-- Determina se esta em modo de edicao (INCLUIR ou ALTERAR)
4418:         loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
4419: 
4420:         TRY
4421:             *-- Botoes da Page2 (Confirmar/Cancelar)
4422:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4423: 
4424:             *-- Confirmar: habilitado apenas em INCLUIR/ALTERAR
4425:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEmEdicao
4426: 
4427:             *-- Cancelar: sempre habilitado em Page2
4428:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
4429: 
4430:             *-- Botoes da Page1 (CRUD): desabilita Alterar/Excluir quando nao ha registro
4431:             LOCAL loc_oPg1
4432:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
4433:             LOCAL loc_lTemRegistro
4434:             loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
4435: 
4436:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
4437:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
4438:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
4439: 
4440:         CATCH TO loc_oErro
4441:             MostrarErro(loc_oErro, "Formcfo.AjustarBotoesPorModo")
4442:         ENDTRY
4443:     ENDPROC
4444: 
4445:     *--------------------------------------------------------------------------
4446:     * Destroy - Libera recursos ao fechar
4447:     *--------------------------------------------------------------------------
4448:     PROCEDURE Destroy()
4449:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
4450:             THIS.this_oBusinessObject = .NULL.
4451:         ENDIF
4452:         DODEFAULT()
4453:     ENDPROC
4454: 
4455: ENDDEFINE


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*==============================================================================
* cfoBO.prg - Business Object para CFOP (C" + CHR(243) + "digo Fiscal de Opera" + CHR(231) + CHR(245) + "es)
* Data: 2026-04-11
* Tabela: SIGCDCFO | PK: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *-- === DADOS PRINCIPAIS ===
    this_cCodigos       = ""   && codigos    CHAR(10)      - C" + CHR(243) + "digo CFOP (PK)
    this_cDescricaos    = ""   && descricaos CHAR(60)      - Descri" + CHR(231) + CHR(227) + "o Nota Fiscal
    this_cDesc2s        = ""   && desc2s     CHAR(60)      - Descri" + CHR(231) + CHR(227) + "o Consulta
    this_nSituas        = 1    && situas     NUMERIC(1,0)  - Situa" + CHR(231) + CHR(227) + "o (1=Ativo, 0=Inativo)
    this_nTipos         = 0    && tipos      NUMERIC(1,0)  - Tipo (0=Compras,1=Dev.Comp.,2=Vendas,3=Dev.Vend.,4=Serv.)
    this_cOperacaos     = ""   && operacaos  CHAR(1)       - Opera" + CHR(231) + CHR(227) + "o (E=Entrada, S=Sa" + CHR(237) + "da)
    this_nNdigitos      = 0    && ndigitos   NUMERIC(2,0)  - D" + CHR(237) + "gitos Para NF

    *-- === ICMS ===
    this_cIcms          = ""   && icms       CHAR(1)       - ICMS (regime)
    this_nInclicms      = 0    && inclicms   NUMERIC(1,0)  - Incluir ICMS (0=N" + CHR(227) + "o,1=Sim,2=Base,3=Pre" + CHR(231) + "o)
    this_nIcmsincs      = 0    && icmsincs   NUMERIC(1,0)  - ICMS Incluso no Pre" + CHR(231) + "o (Sim/N" + CHR(227) + "o)
    this_nIcmsdscs      = 0    && icmsdscs   NUMERIC(1,0)  - ICMS Sobre Desconto
    this_cSittribs      = ""   && sittribs   CHAR(3)       - Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS (lookup SigCdIcm)
    this_nPbcsts        = 0    && pbcsts     NUMERIC(5,2)  - % Base de C" + CHR(225) + "lculo ST
    this_cSubtribs      = ""   && subtribs   CHAR(1)       - Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria (Sim/N" + CHR(227) + "o)
    this_cCfosts        = ""   && cfosts     CHAR(10)      - CFOP Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria
    this_cCoddests      = ""   && coddests   CHAR(10)      - CFOP Destino
    this_cCfost60s      = ""   && cfost60s   CHAR(10)      - CFOP ST60
    this_nAliqivcs      = 0    && aliqivcs   NUMERIC(4,2)  - Al" + CHR(237) + "quota Venda Consumidor
    this_nDesicms       = 0    && desicms    NUMERIC(1,0)  - Desp. Acess. ICMS (Sim/N" + CHR(227) + "o)
    this_nFrticms       = 0    && frticms    NUMERIC(1,0)  - Frete ICMS (Sim/N" + CHR(227) + "o)
    this_nSegicms       = 0    && segicms    NUMERIC(1,0)  - Seguro ICMS (Sim/N" + CHR(227) + "o)
    this_nIncicmnfs     = 0    && incicmnfs  NUMERIC(1,0)  - Incluir ICMS no Total NF (Sim/N" + CHR(227) + "o)
    this_nSomaicmfrete  = 0    && somaicmfrete NUMERIC(1,0) - Soma ICMS Frete no Total NF
    this_cCgergia1s     = ""   && cgergia1s  CHAR(1)       - Destaca ICMS na Nota Fiscal (S/N)
    this_cUnitimps      = ""   && unitimps   CHAR(1)       - Inibe Valor Unit" + CHR(225) + "rio NF Importa" + CHR(231) + CHR(227) + "o
    this_cMotdeson      = ""   && motdeson   CHAR(2)       - Motivo Desonera" + CHR(231) + CHR(227) + "o ICMS

    *-- === IPI ===
    this_cIpis          = ""   && ipis       CHAR(1)       - IPI
    this_nAliqipis      = 0    && aliqipis   NUMERIC(4,2)  - Al" + CHR(237) + "quota IPI
    this_nInclipis      = 0    && inclipis   NUMERIC(1,0)  - Incluir IPI na Base
    this_cIpiIcms       = ""   && ipi_icms   CHAR(1)       - IPI Importa" + CHR(231) + CHR(227) + "o
    this_cBcipis        = ""   && bcipis     CHAR(1)       - Base de C" + CHR(225) + "lculo IPI
    this_nPbcipis       = 0    && pbcipis    NUMERIC(5,2)  - % Base de C" + CHR(225) + "lculo IPI
    this_nIpincreds     = 0    && ipincreds  NUMERIC(1,0)  - N" + CHR(227) + "o Creditado
    this_cAcresipis     = ""   && acresipis  CHAR(1)       - Acres/Desc na Base IPI
    this_cIpiimpors     = ""   && ipiimpors  CHAR(1)       - Retira IPI do $
    this_cIpiom2s       = ""   && ipiom2s    CHAR(1)       - Calcula IPI Import. Origem Merc.=2
    this_nDesipis       = 0    && desipis    NUMERIC(1,0)  - Desp. Acess. IPI (Sim/N" + CHR(227) + "o)
    this_nFrtipis       = 0    && frtipis    NUMERIC(1,0)  - Frete IPI (Sim/N" + CHR(227) + "o)
    this_nSegipis       = 0    && segipis    NUMERIC(1,0)  - Seguro IPI (Sim/N" + CHR(227) + "o)

    *-- === ESPECIFICACOES NF-e ===
    this_cIpicst        = ""   && ipicst     CHAR(2)       - C" + CHR(243) + "digo IPI Sit. Tribut" + CHR(225) + "ria
    this_cPiscst        = ""   && piscst     CHAR(2)       - C" + CHR(243) + "digo PIS Sit. Tribut" + CHR(225) + "ria
    this_cCofcst        = ""   && cofcst     CHAR(2)       - C" + CHR(243) + "digo COFINS Sit. Tribut" + CHR(225) + "ria
    this_cIssqnl        = ""   && issqnl     CHAR(5)       - C" + CHR(243) + "digo ISSQN Lista Serv.
    this_nAliqpis       = 0    && aliqpis    NUMERIC(5,2)  - Al" + CHR(237) + "quota do PIS
    this_nAliqcofins    = 0    && aliqcofins NUMERIC(5,2)  - Al" + CHR(237) + "quota do COFINS
    this_nAliqissqn     = 0    && aliqissqn  NUMERIC(5,2)  - Al" + CHR(237) + "quota do ISSQN
    this_nCtissqn       = 0    && ctissqn    NUMERIC(1,0)  - C" + CHR(243) + "d. Trib. ISSQN (0=Normal,1=Retida,2=Substituta,3=Isenta)
    this_nRettribs      = 0    && rettribs   NUMERIC(1,0)  - Informa Reten" + CHR(231) + CHR(227) + "o de Trib. (Sim/N" + CHR(227) + "o)
    this_nAliqii        = 0    && aliqii     NUMERIC(5,2)  - Al" + CHR(237) + "quota do II
    this_cIpienq        = ""   && ipienq     CHAR(3)       - C" + CHR(243) + "digo Enquadramento IPI
    this_cContribs      = ""   && contribs   CHAR(1)       - Contribuinte

    *-- === INTEGRACAO CONTABIL ===
    this_cContvcds      = ""   && contvcds   CHAR(9)       - Conta Valor Cont" + CHR(225) + "bil DB
    this_cContvccs      = ""   && contvccs   CHAR(9)       - Conta Valor Cont" + CHR(225) + "bil CR
    this_cConticds      = ""   && conticds   CHAR(9)       - Conta ICMS DB
    this_cConticcs      = ""   && conticcs   CHAR(9)       - Conta ICMS CR
    this_cContipds      = ""   && contipds   CHAR(9)       - Conta IPI DB
    this_cContipcs      = ""   && contipcs   CHAR(9)       - Conta IPI CR
    this_cContfrt       = ""   && contfrt    CHAR(9)       - Conta de Frete
    this_cContseg       = ""   && contseg    CHAR(9)       - Conta de Seguro
    this_cContda        = ""   && contda     CHAR(9)       - Conta de Despesas
    this_cContconts     = ""   && contconts  CHAR(1)       - Tipo contabiliza" + CHR(231) + CHR(227) + "o (fixa/din" + CHR(226) + "mica)

    *-- === INTEGRACAO FISCAL ===
    this_nPontedescs    = 0    && pontedescs NUMERIC(1,0)  - Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o (0=N" + CHR(227) + "o,1=CFOP,2=Obs)
    this_nAgrupas       = 0    && agrupas    NUMERIC(1,0)  - Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o (Sim/N" + CHR(227) + "o)
    this_nZeradas       = 0    && zeradas    NUMERIC(1,0)  - Integra" + CHR(231) + CHR(227) + "o Zerada (Sim/N" + CHR(227) + "o)
    this_nDtintfis      = 0    && dtintfis   NUMERIC(1,0)  - Data Lan" + CHR(231) + "amento Cont" + CHR(225) + "bil (0=Integra" + CHR(231) + CHR(227) + "o, 1=NF)
    this_nUtilvars      = 0    && utilvars   NUMERIC(1,0)  - Utilizar Varia" + CHR(231) + CHR(227) + "o CFOP na Integra" + CHR(231) + CHR(227) + "o
    this_nIntvlrcont    = 0    && intvlrcont NUMERIC(1,0)  - Integrar Valor Cont" + CHR(225) + "bil (Sim/N" + CHR(227) + "o)
    this_nIntvlricms    = 0    && intvlricms NUMERIC(1,0)  - Integrar Valores ICMS (Sim/N" + CHR(227) + "o)
    this_nIntvlripi     = 0    && intvlripi  NUMERIC(1,0)  - Integrar Valores IPI (Sim/N" + CHR(227) + "o)
    this_nIndmov        = 0    && indmov     NUMERIC(1,0)  - Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque (Sim/N" + CHR(227) + "o)
    this_nIndpagto      = 0    && indpagto   NUMERIC(1,0)  - Indica" + CHR(231) + CHR(227) + "o de Pagamento (Sim/N" + CHR(227) + "o)

    *-- === OUTROS ===
    this_nTransps       = 0    && transps    NUMERIC(1,0)  - CFOP Transporte (Sim/N" + CHR(227) + "o)
    this_nTiporecs      = 0    && tiporecs   NUMERIC(1,0)  - Tipo Recibo
    this_nObspads       = 0    && obspads    NUMERIC(3,0)  - Obs. Padr" + CHR(227) + "o

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCFO"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Dados Principais
                THIS.this_cCodigos       = TratarNulo(codigos,      "C")
                THIS.this_cDescricaos    = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s        = TratarNulo(desc2s,       "C")
                THIS.this_nSituas        = TratarNulo(situas,       "N")
                THIS.this_nTipos         = TratarNulo(tipos,        "N")
                THIS.this_cOperacaos     = TratarNulo(operacaos,    "C")
                THIS.this_nNdigitos      = TratarNulo(ndigitos,     "N")

                *-- ICMS
                THIS.this_cIcms          = TratarNulo(icms,         "C")
                THIS.this_nInclicms      = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsincs      = TratarNulo(icmsincs,     "N")
                THIS.this_nIcmsdscs      = TratarNulo(icmsdscs,     "N")
                THIS.this_cSittribs      = TratarNulo(sittribs,     "C")
                THIS.this_nPbcsts        = TratarNulo(pbcsts,       "N")
                THIS.this_cSubtribs      = TratarNulo(subtribs,     "C")
                THIS.this_cCfosts        = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests      = TratarNulo(coddests,     "C")
                THIS.this_cCfost60s      = TratarNulo(cfost60s,     "C")
                THIS.this_nAliqivcs      = TratarNulo(aliqivcs,     "N")
                THIS.this_nDesicms       = TratarNulo(desicms,      "N")
                THIS.this_nFrticms       = TratarNulo(frticms,      "N")
                THIS.this_nSegicms       = TratarNulo(segicms,      "N")
                THIS.this_nIncicmnfs     = TratarNulo(incicmnfs,    "N")
                THIS.this_nSomaicmfrete  = TratarNulo(somaicmfrete, "N")
                THIS.this_cCgergia1s     = TratarNulo(cgergia1s,    "C")
                THIS.this_cUnitimps      = TratarNulo(unitimps,     "C")
                THIS.this_cMotdeson      = TratarNulo(motdeson,     "C")

                *-- IPI
                THIS.this_cIpis          = TratarNulo(ipis,         "C")
                THIS.this_nAliqipis      = TratarNulo(aliqipis,     "N")
                THIS.this_nInclipis      = TratarNulo(inclipis,     "N")
                THIS.this_cIpiIcms       = TratarNulo(ipi_icms,     "C")
                THIS.this_cBcipis        = TratarNulo(bcipis,       "C")
                THIS.this_nPbcipis       = TratarNulo(pbcipis,      "N")
                THIS.this_nIpincreds     = TratarNulo(ipincreds,    "N")
                THIS.this_cAcresipis     = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors     = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s       = TratarNulo(ipiom2s,      "C")
                THIS.this_nDesipis       = TratarNulo(desipis,      "N")
                THIS.this_nFrtipis       = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis       = TratarNulo(segipis,      "N")

                *-- Especifica" + CHR(231) + CHR(245) + "es NF-e
                THIS.this_cIpicst        = TratarNulo(ipicst,       "C")
                THIS.this_cPiscst        = TratarNulo(piscst,       "C")
                THIS.this_cCofcst        = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl        = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis       = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins    = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn     = TratarNulo(aliqissqn,    "N")
                THIS.this_nCtissqn       = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs      = TratarNulo(rettribs,     "N")
                THIS.this_nAliqii        = TratarNulo(aliqii,       "N")
                THIS.this_cIpienq        = TratarNulo(ipienq,       "C")
                THIS.this_cContribs      = TratarNulo(contribs,     "C")

                *-- Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil
                THIS.this_cContvcds      = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs      = TratarNulo(contvccs,     "C")
                THIS.this_cConticds      = TratarNulo(conticds,     "C")
                THIS.this_cConticcs      = TratarNulo(conticcs,     "C")
                THIS.this_cContipds      = TratarNulo(contipds,     "C")
                THIS.this_cContipcs      = TratarNulo(contipcs,     "C")
                THIS.this_cContfrt       = TratarNulo(contfrt,      "C")
                THIS.this_cContseg       = TratarNulo(contseg,      "C")
                THIS.this_cContda        = TratarNulo(contda,       "C")
                THIS.this_cContconts     = TratarNulo(contconts,    "C")

                *-- Integra" + CHR(231) + CHR(227) + "o Fiscal
                THIS.this_nPontedescs    = TratarNulo(pontedescs,   "N")
                THIS.this_nAgrupas       = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas       = TratarNulo(zeradas,      "N")
                THIS.this_nDtintfis      = TratarNulo(dtintfis,     "N")
                THIS.this_nUtilvars      = TratarNulo(utilvars,     "N")
                THIS.this_nIntvlrcont    = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms    = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi     = TratarNulo(intvlripi,    "N")
                THIS.this_nIndmov        = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto      = TratarNulo(indpagto,     "N")

                *-- Outros
                THIS.this_nTransps       = TratarNulo(transps,      "N")
                THIS.this_nTiporecs      = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads       = TratarNulo(obspads,      "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDCFO (" + ;
                "codigos, descricaos, desc2s, situas, tipos, operacaos, ndigitos," + ;
                " icms, inclicms, icmsincs, icmsdscs, sittribs, pbcsts, subtribs," + ;
                " cfosts, coddests, cfost60s, aliqivcs, desicms, frticms, segicms," + ;
                " incicmnfs, somaicmfrete, cgergia1s, unitimps, motdeson," + ;
                " ipis, aliqipis, inclipis, ipi_icms, bcipis, pbcipis, ipincreds," + ;
                " acresipis, ipiimpors, ipiom2s, desipis, frtipis, segipis," + ;
                " ipicst, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn," + ;
                " ctissqn, rettribs, aliqii, ipienq, contribs," + ;
                " contvcds, contvccs, conticds, conticcs, contipds, contipcs," + ;
                " contfrt, contseg, contda, contconts," + ;
                " pontedescs, agrupas, zeradas, dtintfis, utilvars," + ;
                " intvlrcont, intvlricms, intvlripi, indmov, indpagto," + ;
                " transps, tiporecs, obspads" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpiIcms) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDCFO SET " + ;
                "descricaos    = " + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s        = " + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "situas        = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "tipos         = " + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "operacaos     = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "ndigitos      = " + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms          = " + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "inclicms      = " + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsincs      = " + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "icmsdscs      = " + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "sittribs      = " + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "pbcsts        = " + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "subtribs      = " + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "cfosts        = " + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests      = " + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "cfost60s      = " + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "aliqivcs      = " + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "desicms       = " + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "frticms       = " + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms       = " + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "incicmnfs     = " + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "somaicmfrete  = " + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "cgergia1s     = " + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "unitimps      = " + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "motdeson      = " + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "ipis          = " + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "aliqipis      = " + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "inclipis      = " + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "ipi_icms      = " + EscaparSQL(THIS.this_cIpiIcms) + ", " + ;
                "bcipis        = " + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "pbcipis       = " + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "ipincreds     = " + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "acresipis     = " + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors     = " + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s       = " + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "desipis       = " + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "frtipis       = " + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis       = " + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "ipicst        = " + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "piscst        = " + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst        = " + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl        = " + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis       = " + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins    = " + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn     = " + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "ctissqn       = " + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs      = " + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "aliqii        = " + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ipienq        = " + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "contribs      = " + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "contvcds      = " + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs      = " + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "conticds      = " + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs      = " + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contipds      = " + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs      = " + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "contfrt       = " + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg       = " + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda        = " + EscaparSQL(THIS.this_cContda) + ", " + ;
                "contconts     = " + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "pontedescs    = " + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "agrupas       = " + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas       = " + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "dtintfis      = " + FormatarNumeroSQL(THIS.this_nDtintfis, 0) + ", " + ;
                "utilvars      = " + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "intvlrcont    = " + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms    = " + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi     = " + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "indmov        = " + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto      = " + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "transps       = " + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "tiporecs      = " + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads       = " + FormatarNumeroSQL(THIS.this_nObspads, 0) + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCFO WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: criar cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, situas FROM SIGCDCFO"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Protecao de grid: se cursor ja esta aberto (grid vinculado), usar ZAP+APPEND
            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
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
            loc_cSQL = "SELECT codigos, descricaos, desc2s, situas, tipos, operacaos, ndigitos," + ;
                " icms, inclicms, icmsincs, icmsdscs, sittribs, pbcsts, subtribs," + ;
                " cfosts, coddests, cfost60s, aliqivcs, desicms, frticms, segicms," + ;
                " incicmnfs, somaicmfrete, cgergia1s, unitimps, motdeson," + ;
                " ipis, aliqipis, inclipis, ipi_icms, bcipis, pbcipis, ipincreds," + ;
                " acresipis, ipiimpors, ipiom2s, desipis, frtipis, segipis," + ;
                " ipicst, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn," + ;
                " ctissqn, rettribs, aliqii, ipienq, contribs," + ;
                " contvcds, contvccs, conticds, conticcs, contipds, contipcs," + ;
                " contfrt, contseg, contda, contconts," + ;
                " pontedescs, agrupas, zeradas, dtintfis, utilvars," + ;
                " intvlrcont, intvlricms, intvlripi, indmov, indpagto," + ;
                " transps, tiporecs, obspads" + ;
                " FROM SIGCDCFO WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave prim" + CHR(225) + "ria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCfopPorCodigo - Busca CFOP para lookup (usado em validacoes de campos)
    * Retorna .T. se encontrou, cursor cursor_4c_BuscaCfo com os dados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCfopPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos FROM SIGCDCFO" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_BuscaCfo")
                USE IN cursor_4c_BuscaCfo
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCfo")

            IF loc_nResultado >= 0
                loc_lSucesso = (RECCOUNT("cursor_4c_BuscaCfo") > 0)
            ELSE
                MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar CFOP:" + CHR(13) + loException.Message, "cfoBO.BuscarCfopPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarIcmPorCodigo - Busca Situacao Tributaria ICMS para lookup
    * Retorna .T. se encontrou, cursor cursor_4c_BuscaIcm com os dados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarIcmPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos FROM SigCdIcm" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_BuscaIcm")
                USE IN cursor_4c_BuscaIcm
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaIcm")

            IF loc_nResultado >= 0
                loc_lSucesso = (RECCOUNT("cursor_4c_BuscaIcm") > 0)
            ELSE
                MostrarErro("Erro ao buscar ICM:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar ICM:" + CHR(13) + loException.Message, "cfoBO.BuscarIcmPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

