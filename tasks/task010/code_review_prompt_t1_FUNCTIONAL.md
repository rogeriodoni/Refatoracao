# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (16)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCfoST60' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCfoST60Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCfoST' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCfoSTValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCfdest' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCfdestValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarSittricm' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarSittricmValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4406 linhas total):

*-- Linhas 28 a 158:
28:     *--------------------------------------------------------------------------
29:     * Init - Inicializa o formulario via FormBase
30:     *--------------------------------------------------------------------------
31:     PROCEDURE Init()
32:         LOCAL loc_lSucesso
33:         loc_lSucesso = .F.
34:         TRY
35:             loc_lSucesso = DODEFAULT()
36:         CATCH TO loc_oErro
37:             MostrarErro(loc_oErro, "Formcfo.Init")
38:         ENDTRY
39:         RETURN loc_lSucesso
40:     ENDPROC
41: 
42:     *--------------------------------------------------------------------------
43:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
44:     *--------------------------------------------------------------------------
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lSucesso
47:         loc_lSucesso = .F.
48: 
49:         TRY
50:             *-- Criar Business Object
51:             THIS.this_oBusinessObject = CREATEOBJECT("cfoBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MostrarErro("Erro ao criar cfoBO", "InicializarForm")
55:             ELSE
56:                 *-- Configurar PageFrame externo (Lista/Dados)
57:                 THIS.ConfigurarPageFrame()
58: 
59:                 *-- Carregar lista inicial (pula se validando UI)
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66:                 loc_lSucesso = .T.
67:             ENDIF
68: 
69:         CATCH TO loc_oErro
70:             MostrarErro(loc_oErro, "Formcfo.InicializarForm")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *--------------------------------------------------------------------------
77:     * ConfigurarPageFrame - PageFrame externo com Page1 (Lista) e Page2 (Dados)
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80: 
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount  = 2
84:             .Top        = -29
85:             .Left       = 0
86:             .Width      = 1000
87:             .Height     = 629
88:             .Tabs       = .F.
89:             .Visible    = .T.
90:         ENDWITH
91: 
92:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
93:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
94:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
95:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
96: 
97:         *-- Configurar Page1 e Page2
98:         THIS.ConfigurarPaginaLista()
99:         THIS.ConfigurarPaginaDados()
100: 
101:         THIS.pgf_4c_Paginas.Visible = .T.
102:     ENDPROC
103: 
104:     *--------------------------------------------------------------------------
105:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid, botoes XML
106:     *--------------------------------------------------------------------------
107:     PROTECTED PROCEDURE ConfigurarPaginaLista()
108:         LOCAL loc_oPagina
109:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
110: 
111:         *-- Container cabecalho (titulo do formulario - lado esquerdo)
112:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH loc_oPagina.cnt_4c_Cabecalho
114:             .Top         = 31
115:             .Left        = 0
116:             .Width       = 800
117:             .Height      = 85
118:             .BackStyle   = 1
119:             .BackColor   = RGB(53, 53, 53)
120:             .BorderWidth = 0
121:             .Visible     = .T.
122:         ENDWITH
123: 
124:         *-- Label sombra (efeito de sombra no titulo)
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
127:             .Caption   = "Cadastro de CFOP"
128:             .Top       = 15
129:             .Left      = 10
130:             .Width     = 769
131:             .Height    = 40
132:             .FontName  = "Tahoma"
133:             .FontSize  = 16
134:             .FontBold  = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .AutoSize  = .F.
138:             .Visible   = .T.
139:         ENDWITH
140: 
141:         *-- Label titulo (branco - sobre a sombra)
142:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
143:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
144:             .Caption   = "Cadastro de CFOP"
145:             .Top       = 18
146:             .Left      = 10
147:             .Width     = 769
148:             .Height    = 46
149:             .FontName  = "Tahoma"
150:             .FontSize  = 16
151:             .FontBold  = .T.
152:             .ForeColor = RGB(255, 255, 255)
153:             .BackStyle = 0
154:             .AutoSize  = .F.
155:             .Visible   = .T.
156:         ENDWITH
157: 
158:         *-- Container botoes CRUD (lado direito - a partir de Left=542)

*-- Linhas 383 a 443:
383:             .Visible            = .T.
384:         ENDWITH
385: 
386:         *-- BINDEVENT para botoes (PUBLIC para funcionar com BINDEVENT)
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
393:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
394:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
395:         BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")
396: 
397:         THIS.TornarControlesVisiveis(loc_oPagina)
398:     ENDPROC
399: 
400:     *--------------------------------------------------------------------------
401:     * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar e inner PageFrame
402:     *--------------------------------------------------------------------------
403:     PROTECTED PROCEDURE ConfigurarPaginaDados()
404:         LOCAL loc_oPagina
405:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
406: 
407:         *-- Container botoes Confirmar/Cancelar (canto superior direito, +29 compensado)
408:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
409:         WITH loc_oPagina.cnt_4c_BotoesAcao
410:             .Top         = 33
411:             .Left        = 842
412:             .Width       = 160
413:             .Height      = 85
414:             .BackStyle   = 1
415:             .BackColor   = RGB(53, 53, 53)
416:             .BorderWidth = 0
417:             .Visible     = .T.
418:         ENDWITH
419: 
420:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
421:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
422:             .Caption         = "Confirmar"
423:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
424:             .PicturePosition = 13
425:             .Top             = 5
426:             .Left            = 5
427:             .Width           = 75
428:             .Height          = 75
429:             .FontName        = "Comic Sans MS"
430:             .FontSize        = 8
431:             .FontBold        = .T.
432:             .FontItalic      = .T.
433:             .ForeColor       = RGB(90, 90, 90)
434:             .BackColor       = RGB(255, 255, 255)
435:             .Themes          = .F.
436:             .SpecialEffect   = 0
437:             .MousePointer    = 15
438:             .WordWrap        = .T.
439:             .AutoSize        = .F.
440:             .Visible         = .T.
441:         ENDWITH
442: 
443:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 495 a 916:
495:         *-- Campos Page2 - Integracao Contabil/Fiscal
496:         THIS.ConfigurarPaginaDadosPage2()
497: 
498:         *-- BINDEVENT para botoes de acao
499:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
500:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
501: 
502:         THIS.TornarControlesVisiveis(loc_oPagina)
503:     ENDPROC
504: 
505:     *--------------------------------------------------------------------------
506:     * CarregarLista - Carrega registros no grid da Page1
507:     *--------------------------------------------------------------------------
508:     PROCEDURE CarregarLista()
509:         LOCAL loc_lResultado, loc_oGrid
510:         loc_lResultado = .F.
511: 
512:         *-- Verificar modo de validacao de UI (sem conexao SQL)
513:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
514:             RETURN .T.
515:         ENDIF
516: 
517:         TRY
518:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
519: 
520:             IF THIS.this_oBusinessObject.Buscar("")
521:                 *-- RecordSource e ColumnCount FORA de WITH para garantir criacao das colunas
522:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
523:                 loc_oGrid.ColumnCount  = 2
524: 
525:                 *-- Configurar colunas APOS RecordSource (redefine headers resetados pelo auto-bind)
526:                 loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
527:                 loc_oGrid.Column1.Width            = 80
528:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
529:                 loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
530: 
531:                 loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
532:                 loc_oGrid.Column2.Width            = 400
533:                 loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
534:                 loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
535: 
536:                 THIS.FormatarGridLista(loc_oGrid)
537:                 loc_lResultado = .T.
538:             ENDIF
539:         CATCH TO loc_oErro
540:             MostrarErro(loc_oErro, "Formcfo.CarregarLista")
541:         ENDTRY
542: 
543:         RETURN loc_lResultado
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------
547:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
548:     * Obs: Percorre Pages de PageFrames e Controls de Containers
549:     *--------------------------------------------------------------------------
550:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
551:         LOCAL loc_nI, loc_oObjeto, loc_nP
552: 
553:         FOR loc_nI = 1 TO par_oContainer.ControlCount
554:             loc_oObjeto = par_oContainer.Controls(loc_nI)
555: 
556:             IF VARTYPE(loc_oObjeto) = "O"
557:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
558:                     loc_oObjeto.Visible = .T.
559:                 ENDIF
560: 
561:                 *-- Trata PageFrame: itera Pages
562:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
563:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
564:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
565:                     ENDFOR
566:                 ENDIF
567: 
568:                 *-- Trata containers com ControlCount
569:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
570:                     THIS.TornarControlesVisiveis(loc_oObjeto)
571:                 ENDIF
572:             ENDIF
573:         ENDFOR
574:     ENDPROC
575: 
576:     *--------------------------------------------------------------------------
577:     * FormatarGridLista - Formata visual do grid da lista
578:     *--------------------------------------------------------------------------
579:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
580:         WITH par_oGrid
581:             .FontName = "Verdana"
582:             .FontSize = 8
583:         ENDWITH
584:     ENDPROC
585: 
586:     *--------------------------------------------------------------------------
587:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
588:     *--------------------------------------------------------------------------
589:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
590:         LOCAL loc_lResultado
591:         loc_lResultado = .F.
592: 
593:         TRY
594:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
595:                 loc_lResultado = .F.
596:             ELSE
597:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
598:                 IF par_nPagina = 1
599:                     THIS.this_cModoAtual = "LISTA"
600:                     THIS.CarregarLista()
601:                     THIS.AjustarBotoesPorModo()
602:                 ENDIF
603:                 loc_lResultado = .T.
604:             ENDIF
605:         CATCH TO loc_oErro
606:             MostrarErro(loc_oErro, "Formcfo.AlternarPagina")
607:         ENDTRY
608: 
609:         RETURN loc_lResultado
610:     ENDPROC
611: 
612:     *--------------------------------------------------------------------------
613:     * BtnIncluirClick - Abre Page2 para inclusao de novo registro
614:     *--------------------------------------------------------------------------
615:     PROCEDURE BtnIncluirClick()
616:         TRY
617:             THIS.this_oBusinessObject.NovoRegistro()
618:             THIS.this_cModoAtual = "INCLUIR"
619:             THIS.LimparCampos()
620:             THIS.HabilitarCampos(.T.)
621:             THIS.AjustarBotoesPorModo()
622:             THIS.pgf_4c_Paginas.ActivePage = 2
623:             THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
624:         CATCH TO loc_oErro
625:             MostrarErro(loc_oErro, "Formcfo.BtnIncluirClick")
626:         ENDTRY
627:     ENDPROC
628: 
629:     *--------------------------------------------------------------------------
630:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
631:     *--------------------------------------------------------------------------
632:     PROCEDURE BtnVisualizarClick()
633:         LOCAL loc_cCodigo
634:         loc_cCodigo = ""
635: 
636:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
637:             SELECT cursor_4c_Dados
638:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
639:         ENDIF
640: 
641:         IF EMPTY(loc_cCodigo)
642:             MsgAviso("Selecione um registro na lista.", "Visualizar")
643:             RETURN
644:         ENDIF
645: 
646:         TRY
647:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
648:                 THIS.this_cModoAtual = "VISUALIZAR"
649:                 THIS.BOParaForm()
650:                 THIS.HabilitarCampos(.F.)
651:                 THIS.AjustarBotoesPorModo()
652:                 THIS.pgf_4c_Paginas.ActivePage = 2
653:             ELSE
654:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
655:             ENDIF
656:         CATCH TO loc_oErro
657:             MostrarErro(loc_oErro, "Formcfo.BtnVisualizarClick")
658:         ENDTRY
659:     ENDPROC
660: 
661:     *--------------------------------------------------------------------------
662:     * BtnAlterarClick - Carrega registro selecionado para edicao
663:     *--------------------------------------------------------------------------
664:     PROCEDURE BtnAlterarClick()
665:         LOCAL loc_cCodigo
666:         loc_cCodigo = ""
667: 
668:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
669:             SELECT cursor_4c_Dados
670:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
671:         ENDIF
672: 
673:         IF EMPTY(loc_cCodigo)
674:             MsgAviso("Selecione um registro na lista.", "Alterar")
675:             RETURN
676:         ENDIF
677: 
678:         TRY
679:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
680:                 THIS.this_oBusinessObject.EditarRegistro()
681:                 THIS.this_cModoAtual = "ALTERAR"
682:                 THIS.BOParaForm()
683:                 THIS.HabilitarCampos(.T.)
684:                 THIS.AjustarBotoesPorModo()
685:                 THIS.pgf_4c_Paginas.ActivePage = 2
686:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Descricao.SetFocus()
687:             ELSE
688:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
689:             ENDIF
690:         CATCH TO loc_oErro
691:             MostrarErro(loc_oErro, "Formcfo.BtnAlterarClick")
692:         ENDTRY
693:     ENDPROC
694: 
695:     *--------------------------------------------------------------------------
696:     * BtnExcluirClick - Confirma e exclui o registro selecionado
697:     *--------------------------------------------------------------------------
698:     PROCEDURE BtnExcluirClick()
699:         LOCAL loc_cCodigo, loc_lConfirma
700:         loc_cCodigo  = ""
701:         loc_lConfirma = .F.
702: 
703:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
704:             SELECT cursor_4c_Dados
705:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
706:         ENDIF
707: 
708:         IF EMPTY(loc_cCodigo)
709:             MsgAviso("Selecione um registro na lista.", "Excluir")
710:             RETURN
711:         ENDIF
712: 
713:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do CFOP '" + ;
714:             loc_cCodigo + "'?", "Excluir")
715: 
716:         IF loc_lConfirma
717:             TRY
718:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
719:                     IF THIS.this_oBusinessObject.Excluir()
720:                         MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
721:                         THIS.CarregarLista()
722:                     ENDIF
723:                 ENDIF
724:             CATCH TO loc_oErro
725:                 MostrarErro(loc_oErro, "Formcfo.BtnExcluirClick")
726:             ENDTRY
727:         ENDIF
728:     ENDPROC
729: 
730:     *--------------------------------------------------------------------------
731:     * BtnBuscarClick - Abre busca auxiliar para localizar CFOP
732:     *--------------------------------------------------------------------------
733:     PROCEDURE BtnBuscarClick()
734:         LOCAL loc_oBusca
735:         loc_oBusca = .NULL.
736: 
737:         TRY
738:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
739:                 "SigCdCfo", "cursor_4c_BuscaCFO", "codigos", "", ;
740:                 "Buscar CFOP")
741: 
742:             IF VARTYPE(loc_oBusca) = "O"
743:                 IF !loc_oBusca.this_lAchouRegistro
744:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
745:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
746:                     loc_oBusca.Show()
747:                 ENDIF
748:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFO")
749:                     SELECT cursor_4c_BuscaCFO
750:                     GO TOP
751:                 ENDIF
752:                 loc_oBusca.Release()
753:                 loc_oBusca = .NULL.
754:             ENDIF
755:         CATCH TO loc_oErro
756:             MostrarErro(loc_oErro, "Formcfo.BtnBuscarClick")
757:         ENDTRY
758: 
759:         IF USED("cursor_4c_BuscaCFO")
760:             USE IN cursor_4c_BuscaCFO
761:         ENDIF
762: 
763:         THIS.CarregarLista()
764:     ENDPROC
765: 
766:     *--------------------------------------------------------------------------
767:     * BtnEncerrarClick - Fecha o formulario
768:     *--------------------------------------------------------------------------
769:     PROCEDURE BtnEncerrarClick()
770:         THIS.Release()
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * BtnExpXMLClick - Exporta CFOP selecionado para XML (via SigOpXml)
775:     *--------------------------------------------------------------------------
776:     PROCEDURE BtnExpXMLClick()
777:         LOCAL loc_cCodigo
778:         loc_cCodigo = ""
779: 
780:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
781:             SELECT cursor_4c_Dados
782:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
783:         ENDIF
784: 
785:         IF EMPTY(loc_cCodigo)
786:             MsgAviso("Selecione um registro para exportar.", "Exporta XML")
787:             RETURN
788:         ENDIF
789: 
790:         TRY
791:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
792:             THIS.CarregarLista()
793:             IF USED("cursor_4c_Dados")
794:                 SELECT cursor_4c_Dados
795:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
796:             ENDIF
797:         CATCH TO loc_oErro
798:             MostrarErro(loc_oErro, "Formcfo.BtnExpXMLClick")
799:         ENDTRY
800:     ENDPROC
801: 
802:     *--------------------------------------------------------------------------
803:     * BtnImpXMLClick - Importa CFOP de arquivo XML (via SigOpXml)
804:     *--------------------------------------------------------------------------
805:     PROCEDURE BtnImpXMLClick()
806:         LOCAL loc_cCodigo
807:         loc_cCodigo = ""
808: 
809:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
810:             SELECT cursor_4c_Dados
811:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
812:         ENDIF
813: 
814:         TRY
815:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "I", "CFOP", 10
816:             THIS.CarregarLista()
817:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
818:                 SELECT cursor_4c_Dados
819:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
820:             ENDIF
821:         CATCH TO loc_oErro
822:             MostrarErro(loc_oErro, "Formcfo.BtnImpXMLClick")
823:         ENDTRY
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * GrdListaDblClick - DblClick na lista abre visualizacao do registro
828:     *--------------------------------------------------------------------------
829:     PROCEDURE GrdListaDblClick()
830:         THIS.BtnVisualizarClick()
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * ConfigurarPaginaDadosParte1 - Page1 do PagDados: primeira metade (top < 236)
835:     *--------------------------------------------------------------------------
836:     PROTECTED PROCEDURE ConfigurarPaginaDadosParte1()
837:         LOCAL loc_oPag1
838:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
839: 
840:         *----------------------------------------------------------------------
841:         *-- Grupo 1: Cabecalho (top 0-90)
842:         *----------------------------------------------------------------------
843: 
844:         *-- Label Codigo
845:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
846:         WITH loc_oPag1.lbl_4c_Label1
847:             .Caption   = "C" + CHR(243) + "digo :"
848:             .Top       = 11
849:             .Left      = 91
850:             .Width     = 42
851:             .Height    = 15
852:             .FontName  = "Tahoma"
853:             .FontSize  = 8
854:             .BackStyle = 0
855:             .ForeColor = RGB(90, 90, 90)
856:             .Visible   = .T.
857:         ENDWITH
858: 
859:         *-- Codigo CFOP
860:         loc_oPag1.AddObject("txt_4c_Codigo", "TextBox")
861:         WITH loc_oPag1.txt_4c_Codigo
862:             .Top           = 7
863:             .Left          = 136
864:             .Width         = 91
865:             .Height        = 24
866:             .FontName      = "Tahoma"
867:             .FontSize      = 8
868:             .MaxLength     = 10
869:             .SpecialEffect = 1
870:             .ForeColor     = RGB(90, 90, 90)
871:             .BorderColor   = RGB(100, 100, 100)
872:             .Visible       = .T.
873:         ENDWITH
874: 
875:         *-- Situacao (Ativo/Inativo)
876:         loc_oPag1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
877:         WITH loc_oPag1.obj_4c_Opc_situacao
878:             .ButtonCount = 2
879:             .Top         = 11
880:             .Left        = 243
881:             .Width       = 137
882:             .Height      = 17
883:             .BorderStyle = 0
884:             .Visible     = .T.
885:         ENDWITH
886:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(1)
887:             .Caption   = "Ativo"
888:             .Left      = 0
889:             .Top       = 0
890:             .AutoSize  = .T.
891:             .FontName  = "Tahoma"
892:             .FontSize  = 8
893:             .ForeColor = RGB(90, 90, 90)
894:             .Themes    = .F.
895:         ENDWITH
896:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(2)
897:             .Caption   = "Inativo"
898:             .Left      = 60
899:             .Top       = 0
900:             .AutoSize  = .T.
901:             .FontName  = "Tahoma"
902:             .FontSize  = 8
903:             .ForeColor = RGB(90, 90, 90)
904:             .Themes    = .F.
905:         ENDWITH
906: 
907:         *-- Label Operacao
908:         loc_oPag1.AddObject("lbl_4c_Label3", "Label")
909:         WITH loc_oPag1.lbl_4c_Label3
910:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
911:             .Top       = 11
912:             .Left      = 393
913:             .Width     = 56
914:             .Height    = 15
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8

*-- Linhas 1722 a 1775:
1722:             .Visible       = .T.
1723:         ENDWITH
1724: 
1725:         *-- BINDEVENT para lookup fields (LostFocus abre FormBuscaAuxiliar)
1726:         BINDEVENT(loc_oPag1.txt_4c_CfoST60,  "LostFocus", THIS, "ValidarCfoST60")
1727:         BINDEVENT(loc_oPag1.txt_4c_CfoST,    "LostFocus", THIS, "ValidarCfoST")
1728:         BINDEVENT(loc_oPag1.txt_4c_Cfdest,   "LostFocus", THIS, "ValidarCfdest")
1729:         BINDEVENT(loc_oPag1.txt_4c_Sittricm, "LostFocus", THIS, "ValidarSittricm")
1730:     ENDPROC
1731: 
1732:     *--------------------------------------------------------------------------
1733:     * ConfigurarPaginaDadosParte2 - Page1 do PagDados: segunda metade (top >= 236)
1734:     *--------------------------------------------------------------------------
1735:     PROTECTED PROCEDURE ConfigurarPaginaDadosParte2()
1736:         LOCAL loc_oPag1
1737:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1738: 
1739:         *-- Linha separadora shp03 (top=236)
1740:         loc_oPag1.AddObject("shp_4c_Shp03", "Shape")
1741:         WITH loc_oPag1.shp_4c_Shp03
1742:             .Top         = 236
1743:             .Left        = 3
1744:             .Width       = 984
1745:             .Height      = 1
1746:             .BackStyle   = 1
1747:             .BackColor   = RGB(180, 180, 180)
1748:             .BorderStyle = 0
1749:             .Visible     = .T.
1750:         ENDWITH
1751: 
1752:         *-- Label "Especificacoes Para NF-e" (bold Verdana, top=246)
1753:         loc_oPag1.AddObject("lbl_4c_Label38", "Label")
1754:         WITH loc_oPag1.lbl_4c_Label38
1755:             .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
1756:             .Top       = 246
1757:             .Left      = 498
1758:             .Width     = 167
1759:             .Height    = 15
1760:             .FontName  = "Verdana"
1761:             .FontSize  = 8
1762:             .FontBold  = .T.
1763:             .BackStyle = 0
1764:             .ForeColor = RGB(90, 90, 90)
1765:             .Visible   = .T.
1766:         ENDWITH
1767: 
1768:         *----------------------------------------------------------------------
1769:         *-- Grupo IPI (lado esquerdo, top >= 263)
1770:         *----------------------------------------------------------------------
1771: 
1772:         *-- Label IPI
1773:         loc_oPag1.AddObject("lbl_4c_Label8", "Label")
1774:         WITH loc_oPag1.lbl_4c_Label8
1775:             .Caption   = "I P I :"

*-- Linhas 2465 a 2509:
2465:             .Visible   = .T.
2466:         ENDWITH
2467: 
2468:         *-- OptionGroup Codigo Tributacao ISSQN (ctissqn, 5 botoes: Normal/Retida/Substituta/Isenta/Nao Calcula)
2469:         loc_oPag1.AddObject("obj_4c_Fwoption1", "OptionGroup")
2470:         WITH loc_oPag1.obj_4c_Fwoption1
2471:             .Top         = 389
2472:             .Left        = 686
2473:             .Width       = 297
2474:             .Height      = 34
2475:             .ButtonCount = 5
2476:             .BorderStyle = 0
2477:             .Visible     = .T.
2478:         ENDWITH
2479:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(1)
2480:             .Caption   = "Normal"
2481:             .Left      = 4
2482:             .Top       = 0
2483:             .Height    = 15
2484:             .AutoSize  = .T.
2485:             .FontName  = "Verdana"
2486:             .FontSize  = 8
2487:             .ForeColor = RGB(90, 90, 90)
2488:         ENDWITH
2489:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(2)
2490:             .Caption   = "Retida"
2491:             .Left      = 72
2492:             .Top       = 0
2493:             .Height    = 15
2494:             .AutoSize  = .T.
2495:             .FontName  = "Verdana"
2496:             .FontSize  = 8
2497:             .ForeColor = RGB(90, 90, 90)
2498:         ENDWITH
2499:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(3)
2500:             .Caption   = "Substituta"
2501:             .Left      = 135
2502:             .Top       = 1
2503:             .Width     = 76
2504:             .Height    = 15
2505:             .AutoSize  = .T.
2506:             .FontName  = "Verdana"
2507:             .FontSize  = 8
2508:             .ForeColor = RGB(90, 90, 90)
2509:         ENDWITH

*-- Linhas 2543 a 2587:
2543:             .Visible   = .T.
2544:         ENDWITH
2545: 
2546:         *-- OptionGroup Informa Retencao de Tributacao (rettribs, 2 botoes: Sim/Nao)
2547:         loc_oPag1.AddObject("obj_4c_Fwoption2", "OptionGroup")
2548:         WITH loc_oPag1.obj_4c_Fwoption2
2549:             .Top         = 420
2550:             .Left        = 686
2551:             .Width       = 95
2552:             .Height      = 25
2553:             .ButtonCount = 2
2554:             .BorderStyle = 0
2555:             .Visible     = .T.
2556:         ENDWITH
2557:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(1)
2558:             .Caption   = "Sim"
2559:             .Left      = 5
2560:             .Top       = 5
2561:             .Height    = 15
2562:             .AutoSize  = .T.
2563:             .FontName  = "Tahoma"
2564:             .FontSize  = 8
2565:             .ForeColor = RGB(90, 90, 90)
2566:         ENDWITH
2567:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(2)
2568:             .Caption   = "N" + CHR(227) + "o"
2569:             .Left      = 53
2570:             .Top       = 5
2571:             .Height    = 15
2572:             .AutoSize  = .T.
2573:             .FontName  = "Tahoma"
2574:             .FontSize  = 8
2575:             .ForeColor = RGB(90, 90, 90)
2576:         ENDWITH
2577: 
2578:         *-- Label Aliquota do II
2579:         loc_oPag1.AddObject("lbl_4c_Label47", "Label")
2580:         WITH loc_oPag1.lbl_4c_Label47
2581:             .Caption   = "Al" + CHR(237) + "quota do II :"
2582:             .Top       = 425
2583:             .Left      = 820
2584:             .Width     = 89
2585:             .Height    = 15
2586:             .FontName  = "Verdana"
2587:             .FontSize  = 8

*-- Linhas 2621 a 2671:
2621:             .Visible   = .T.
2622:         ENDWITH
2623: 
2624:         *-- BINDEVENT: cmbIpiI.InteractiveChange -> habilita/desabilita Combo8
2625:         BINDEVENT(loc_oPag1.cbo_4c_CmbIpiI, "InteractiveChange", THIS, "AtualizarCombo8")
2626:     ENDPROC
2627: 
2628:     *--------------------------------------------------------------------------
2629:     * ConfigurarPaginaDadosPage2 - Page2 do PagDados: Integracao Contabil/Fiscal
2630:     *--------------------------------------------------------------------------
2631:     PROTECTED PROCEDURE ConfigurarPaginaDadosPage2()
2632:         LOCAL loc_oPag2
2633:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
2634: 
2635:         *----------------------------------------------------------------------
2636:         *-- Secao: Integracao Contabil (esquerda)
2637:         *----------------------------------------------------------------------
2638: 
2639:         *-- Label cabecalho secao Integracao Contabil
2640:         loc_oPag2.AddObject("lbl_4c_LblIntCont", "Label")
2641:         WITH loc_oPag2.lbl_4c_LblIntCont
2642:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
2643:             .Top       = 6
2644:             .Left      = 15
2645:             .Width     = 114
2646:             .Height    = 15
2647:             .FontName  = "Tahoma"
2648:             .FontSize  = 8
2649:             .FontBold  = .T.
2650:             .BackStyle = 0
2651:             .ForeColor = RGB(90, 90, 90)
2652:             .Visible   = .T.
2653:         ENDWITH
2654: 
2655:         *-- Label Valor Contabil
2656:         loc_oPag2.AddObject("lbl_4c_LblValorCont", "Label")
2657:         WITH loc_oPag2.lbl_4c_LblValorCont
2658:             .Caption   = "Valor Cont" + CHR(225) + "bil :"
2659:             .Top       = 34
2660:             .Left      = 84
2661:             .Width     = 75
2662:             .Height    = 15
2663:             .FontName  = "Tahoma"
2664:             .FontSize  = 8
2665:             .BackStyle = 0
2666:             .ForeColor = RGB(90, 90, 90)
2667:             .Visible   = .T.
2668:         ENDWITH
2669: 
2670:         *-- Label DB (Valor Contabil)
2671:         loc_oPag2.AddObject("lbl_4c_LblVcDB", "Label")

*-- Linhas 3061 a 3105:
3061:             .Visible   = .T.
3062:         ENDWITH
3063: 
3064:         *-- OptionGroup Agrupa CFO (agrupas: 1=Sim, 2=Nao)
3065:         loc_oPag2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
3066:         WITH loc_oPag2.obj_4c_OptAgrupas
3067:             .ButtonCount = 2
3068:             .Top         = 79
3069:             .Left        = 638
3070:             .Width       = 94
3071:             .Height      = 27
3072:             .BorderStyle = 0
3073:             .Visible     = .T.
3074:         ENDWITH
3075:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(1)
3076:             .Caption   = "Sim"
3077:             .Left      = 5
3078:             .Top       = 5
3079:             .Width     = 40
3080:             .Height    = 17
3081:             .AutoSize  = .F.
3082:             .FontName  = "Tahoma"
3083:             .FontSize  = 8
3084:             .ForeColor = RGB(90, 90, 90)
3085:             .Themes    = .F.
3086:         ENDWITH
3087:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(2)
3088:             .Caption   = "N" + CHR(227) + "o"
3089:             .Left      = 51
3090:             .Top       = 5
3091:             .Width     = 40
3092:             .Height    = 17
3093:             .AutoSize  = .F.
3094:             .FontName  = "Tahoma"
3095:             .FontSize  = 8
3096:             .ForeColor = RGB(90, 90, 90)
3097:             .Themes    = .F.
3098:         ENDWITH
3099: 
3100:         *-- Label Integracao Zerada
3101:         loc_oPag2.AddObject("lbl_4c_LblZeradas", "Label")
3102:         WITH loc_oPag2.lbl_4c_LblZeradas
3103:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
3104:             .Top       = 108
3105:             .Left      = 523

*-- Linhas 3112 a 3156:
3112:             .Visible   = .T.
3113:         ENDWITH
3114: 
3115:         *-- OptionGroup Integracao Zerada (zeradas: 1=Sim, 2=Nao)
3116:         loc_oPag2.AddObject("obj_4c_OptZeradas", "OptionGroup")
3117:         WITH loc_oPag2.obj_4c_OptZeradas
3118:             .ButtonCount = 2
3119:             .Top         = 103
3120:             .Left        = 638
3121:             .Width       = 94
3122:             .Height      = 27
3123:             .BorderStyle = 0
3124:             .Visible     = .T.
3125:         ENDWITH
3126:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(1)
3127:             .Caption   = "Sim"
3128:             .Left      = 5
3129:             .Top       = 5
3130:             .Width     = 40
3131:             .Height    = 17
3132:             .AutoSize  = .F.
3133:             .FontName  = "Tahoma"
3134:             .FontSize  = 8
3135:             .ForeColor = RGB(90, 90, 90)
3136:             .Themes    = .F.
3137:         ENDWITH
3138:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(2)
3139:             .Caption   = "N" + CHR(227) + "o"
3140:             .Left      = 51
3141:             .Top       = 5
3142:             .Width     = 40
3143:             .Height    = 17
3144:             .AutoSize  = .F.
3145:             .FontName  = "Tahoma"
3146:             .FontSize  = 8
3147:             .ForeColor = RGB(90, 90, 90)
3148:             .Themes    = .F.
3149:         ENDWITH
3150: 
3151:         *-- Label Data Lancamento Contabil
3152:         loc_oPag2.AddObject("lbl_4c_LblDtLanc", "Label")
3153:         WITH loc_oPag2.lbl_4c_LblDtLanc
3154:             .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
3155:             .Top       = 132
3156:             .Left      = 479

*-- Linhas 3163 a 3207:
3163:             .Visible   = .T.
3164:         ENDWITH
3165: 
3166:         *-- OptionGroup Data Lancamento Contabil (dtintfis: 1=Data Integracao, 2=Data N.F.)
3167:         loc_oPag2.AddObject("obj_4c_Fwoption1", "OptionGroup")
3168:         WITH loc_oPag2.obj_4c_Fwoption1
3169:             .ButtonCount = 2
3170:             .Top         = 127
3171:             .Left        = 638
3172:             .Width       = 192
3173:             .Height      = 27
3174:             .BorderStyle = 0
3175:             .Visible     = .T.
3176:         ENDWITH
3177:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(1)
3178:             .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
3179:             .Left      = 5
3180:             .Top       = 5
3181:             .Width     = 97
3182:             .Height    = 15
3183:             .AutoSize  = .F.
3184:             .FontName  = "Tahoma"
3185:             .FontSize  = 8
3186:             .ForeColor = RGB(90, 90, 90)
3187:             .Themes    = .F.
3188:         ENDWITH
3189:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(2)
3190:             .Caption   = "Data N.F."
3191:             .Left      = 122
3192:             .Top       = 7
3193:             .Width     = 65
3194:             .Height    = 15
3195:             .AutoSize  = .F.
3196:             .FontName  = "Tahoma"
3197:             .FontSize  = 8
3198:             .ForeColor = RGB(90, 90, 90)
3199:             .Themes    = .F.
3200:         ENDWITH
3201: 
3202:         *-- Label Utilizar variacao de CFOP na Integracao
3203:         loc_oPag2.AddObject("lbl_4c_LblUtilvars", "Label")
3204:         WITH loc_oPag2.lbl_4c_LblUtilvars
3205:             .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
3206:             .Top       = 156
3207:             .Left      = 390

*-- Linhas 3214 a 3258:
3214:             .Visible   = .T.
3215:         ENDWITH
3216: 
3217:         *-- OptionGroup Utilizar variacao CFOP (utilvars: 1=Sim, 2=Nao)
3218:         loc_oPag2.AddObject("obj_4c_Optutilvars", "OptionGroup")
3219:         WITH loc_oPag2.obj_4c_Optutilvars
3220:             .ButtonCount = 2
3221:             .Top         = 150
3222:             .Left        = 638
3223:             .Width       = 94
3224:             .Height      = 27
3225:             .BorderStyle = 0
3226:             .Visible     = .T.
3227:         ENDWITH
3228:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(1)
3229:             .Caption   = "Sim"
3230:             .Left      = 5
3231:             .Top       = 5
3232:             .Width     = 40
3233:             .Height    = 17
3234:             .AutoSize  = .F.
3235:             .FontName  = "Tahoma"
3236:             .FontSize  = 8
3237:             .ForeColor = RGB(90, 90, 90)
3238:             .Themes    = .F.
3239:         ENDWITH
3240:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(2)
3241:             .Caption   = "N" + CHR(227) + "o"
3242:             .Left      = 51
3243:             .Top       = 5
3244:             .Width     = 40
3245:             .Height    = 17
3246:             .AutoSize  = .F.
3247:             .FontName  = "Tahoma"
3248:             .FontSize  = 8
3249:             .ForeColor = RGB(90, 90, 90)
3250:             .Themes    = .F.
3251:         ENDWITH
3252: 
3253:         *----------------------------------------------------------------------
3254:         *-- Separador e secao Integracao Fiscal
3255:         *----------------------------------------------------------------------
3256: 
3257:         *-- Linha separadora horizontal
3258:         loc_oPag2.AddObject("shp_4c_Sep", "Shape")

*-- Linhas 3298 a 3342:
3298:             .Visible   = .T.
3299:         ENDWITH
3300: 
3301:         *-- OptionGroup Integrar Valor Contabil (intvlrcont: 1=Sim, 2=Nao)
3302:         loc_oPag2.AddObject("obj_4c_Fwoption2", "OptionGroup")
3303:         WITH loc_oPag2.obj_4c_Fwoption2
3304:             .ButtonCount = 2
3305:             .Top         = 233
3306:             .Left        = 231
3307:             .Width       = 94
3308:             .Height      = 27
3309:             .BorderStyle = 0
3310:             .Visible     = .T.
3311:         ENDWITH
3312:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(1)
3313:             .Caption   = "Sim"
3314:             .Left      = 5
3315:             .Top       = 5
3316:             .Width     = 40
3317:             .Height    = 17
3318:             .AutoSize  = .F.
3319:             .FontName  = "Tahoma"
3320:             .FontSize  = 8
3321:             .ForeColor = RGB(90, 90, 90)
3322:             .Themes    = .F.
3323:         ENDWITH
3324:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(2)
3325:             .Caption   = "N" + CHR(227) + "o"
3326:             .Left      = 51
3327:             .Top       = 5
3328:             .Width     = 40
3329:             .Height    = 17
3330:             .AutoSize  = .F.
3331:             .FontName  = "Tahoma"
3332:             .FontSize  = 8
3333:             .ForeColor = RGB(90, 90, 90)
3334:             .Themes    = .F.
3335:         ENDWITH
3336: 
3337:         *-- Label Integrar Valores Icms
3338:         loc_oPag2.AddObject("lbl_4c_LblIntvlricms", "Label")
3339:         WITH loc_oPag2.lbl_4c_LblIntvlricms
3340:             .Caption   = "Integrar Valores Icms :"
3341:             .Top       = 259
3342:             .Left      = 121

*-- Linhas 3349 a 3393:
3349:             .Visible   = .T.
3350:         ENDWITH
3351: 
3352:         *-- OptionGroup Integrar Valores Icms (intvlricms: 1=Sim, 2=Nao)
3353:         loc_oPag2.AddObject("obj_4c_Fwoption3", "OptionGroup")
3354:         WITH loc_oPag2.obj_4c_Fwoption3
3355:             .ButtonCount = 2
3356:             .Top         = 253
3357:             .Left        = 231
3358:             .Width       = 94
3359:             .Height      = 27
3360:             .BorderStyle = 0
3361:             .Visible     = .T.
3362:         ENDWITH
3363:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(1)
3364:             .Caption   = "Sim"
3365:             .Left      = 5
3366:             .Top       = 5
3367:             .Width     = 40
3368:             .Height    = 17
3369:             .AutoSize  = .F.
3370:             .FontName  = "Tahoma"
3371:             .FontSize  = 8
3372:             .ForeColor = RGB(90, 90, 90)
3373:             .Themes    = .F.
3374:         ENDWITH
3375:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(2)
3376:             .Caption   = "N" + CHR(227) + "o"
3377:             .Left      = 51
3378:             .Top       = 5
3379:             .Width     = 40
3380:             .Height    = 17
3381:             .AutoSize  = .F.
3382:             .FontName  = "Tahoma"
3383:             .FontSize  = 8
3384:             .ForeColor = RGB(90, 90, 90)
3385:             .Themes    = .F.
3386:         ENDWITH
3387: 
3388:         *-- Label Integrar Valores Ipi
3389:         loc_oPag2.AddObject("lbl_4c_LblIntvlripi", "Label")
3390:         WITH loc_oPag2.lbl_4c_LblIntvlripi
3391:             .Caption   = "Integrar Valores Ipi :"
3392:             .Top       = 278
3393:             .Left      = 131

*-- Linhas 3400 a 3444:
3400:             .Visible   = .T.
3401:         ENDWITH
3402: 
3403:         *-- OptionGroup Integrar Valores Ipi (intvlripi: 1=Sim, 2=Nao)
3404:         loc_oPag2.AddObject("obj_4c_Fwoption4", "OptionGroup")
3405:         WITH loc_oPag2.obj_4c_Fwoption4
3406:             .ButtonCount = 2
3407:             .Top         = 272
3408:             .Left        = 231
3409:             .Width       = 94
3410:             .Height      = 27
3411:             .BorderStyle = 0
3412:             .Visible     = .T.
3413:         ENDWITH
3414:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(1)
3415:             .Caption   = "Sim"
3416:             .Left      = 5
3417:             .Top       = 5
3418:             .Width     = 40
3419:             .Height    = 17
3420:             .AutoSize  = .F.
3421:             .FontName  = "Tahoma"
3422:             .FontSize  = 8
3423:             .ForeColor = RGB(90, 90, 90)
3424:             .Themes    = .F.
3425:         ENDWITH
3426:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(2)
3427:             .Caption   = "N" + CHR(227) + "o"
3428:             .Left      = 51
3429:             .Top       = 5
3430:             .Width     = 40
3431:             .Height    = 17
3432:             .AutoSize  = .F.
3433:             .FontName  = "Tahoma"
3434:             .FontSize  = 8
3435:             .ForeColor = RGB(90, 90, 90)
3436:             .Themes    = .F.
3437:         ENDWITH
3438: 
3439:         *-- Label Movimentacao Fisica de Estoque
3440:         loc_oPag2.AddObject("lbl_4c_LblIndmov", "Label")
3441:         WITH loc_oPag2.lbl_4c_LblIndmov
3442:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
3443:             .Top       = 298
3444:             .Left      = 69

*-- Linhas 3451 a 3495:
3451:             .Visible   = .T.
3452:         ENDWITH
3453: 
3454:         *-- OptionGroup Movimentacao Fisica de Estoque (indmov: 1=Sim, 2=Nao)
3455:         loc_oPag2.AddObject("obj_4c_Fwoption5", "OptionGroup")
3456:         WITH loc_oPag2.obj_4c_Fwoption5
3457:             .ButtonCount = 2
3458:             .Top         = 292
3459:             .Left        = 231
3460:             .Width       = 94
3461:             .Height      = 27
3462:             .BorderStyle = 0
3463:             .Visible     = .T.
3464:         ENDWITH
3465:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(1)
3466:             .Caption   = "Sim"
3467:             .Left      = 5
3468:             .Top       = 5
3469:             .Width     = 40
3470:             .Height    = 17
3471:             .AutoSize  = .F.
3472:             .FontName  = "Tahoma"
3473:             .FontSize  = 8
3474:             .ForeColor = RGB(90, 90, 90)
3475:             .Themes    = .F.
3476:         ENDWITH
3477:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(2)
3478:             .Caption   = "N" + CHR(227) + "o"
3479:             .Left      = 51
3480:             .Top       = 5
3481:             .Width     = 40
3482:             .Height    = 17
3483:             .AutoSize  = .F.
3484:             .FontName  = "Tahoma"
3485:             .FontSize  = 8
3486:             .ForeColor = RGB(90, 90, 90)
3487:             .Themes    = .F.
3488:         ENDWITH
3489: 
3490:         *-- Label Indicacao de Pagamento
3491:         loc_oPag2.AddObject("lbl_4c_LblIndpagto", "Label")
3492:         WITH loc_oPag2.lbl_4c_LblIndpagto
3493:             .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
3494:             .Top       = 318
3495:             .Left      = 106

*-- Linhas 3502 a 3897:
3502:             .Visible   = .T.
3503:         ENDWITH
3504: 
3505:         *-- OptionGroup Indicacao de Pagamento (indpagto: 1=Sim, 2=Nao)
3506:         loc_oPag2.AddObject("obj_4c_Fwoption6", "OptionGroup")
3507:         WITH loc_oPag2.obj_4c_Fwoption6
3508:             .ButtonCount = 2
3509:             .Top         = 312
3510:             .Left        = 231
3511:             .Width       = 94
3512:             .Height      = 27
3513:             .BorderStyle = 0
3514:             .Visible     = .T.
3515:         ENDWITH
3516:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(1)
3517:             .Caption   = "Sim"
3518:             .Left      = 5
3519:             .Top       = 5
3520:             .Width     = 40
3521:             .Height    = 17
3522:             .AutoSize  = .F.
3523:             .FontName  = "Tahoma"
3524:             .FontSize  = 8
3525:             .ForeColor = RGB(90, 90, 90)
3526:             .Themes    = .F.
3527:         ENDWITH
3528:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(2)
3529:             .Caption   = "N" + CHR(227) + "o"
3530:             .Left      = 51
3531:             .Top       = 5
3532:             .Width     = 40
3533:             .Height    = 17
3534:             .AutoSize  = .F.
3535:             .FontName  = "Tahoma"
3536:             .FontSize  = 8
3537:             .ForeColor = RGB(90, 90, 90)
3538:             .Themes    = .F.
3539:         ENDWITH
3540: 
3541:         *-- BINDEVENT para validacao de contas contabeis (LostFocus)
3542:         BINDEVENT(loc_oPag2.txt_4c_ContFrt, "LostFocus", THIS, "ValidarContFrt")
3543:         BINDEVENT(loc_oPag2.txt_4c_ContSeg, "LostFocus", THIS, "ValidarContSeg")
3544:         BINDEVENT(loc_oPag2.txt_4c_ContDa,  "LostFocus", THIS, "ValidarContDa")
3545:     ENDPROC
3546: 
3547:     *--------------------------------------------------------------------------
3548:     * AtualizarCombo8 - Habilita/desabilita Combo8 conforme cmbIpiI (IPI Importacao)
3549:     *--------------------------------------------------------------------------
3550:     PROCEDURE AtualizarCombo8()
3551:         LOCAL loc_oPag1
3552:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3553:         TRY
3554:             loc_oPag1.cbo_4c_Combo8.Enabled = ;
3555:                 (UPPER(LEFT(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbIpiI.Value, "")), 1)) = "S")
3556:         CATCH TO loc_oErro
3557:             MostrarErro(loc_oErro, "Formcfo.AtualizarCombo8")
3558:         ENDTRY
3559:     ENDPROC
3560: 
3561:     *--------------------------------------------------------------------------
3562:     * ValidarContFrt - Valida Conta de Frete contra SigCdCli (LostFocus)
3563:     *--------------------------------------------------------------------------
3564:     PROCEDURE ValidarContFrt()
3565:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3566:         IF gb_4c_ValidandoUI
3567:             RETURN
3568:         ENDIF
3569:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3570:         loc_cConta = ""
3571:         loc_nRows  = 0
3572:         TRY
3573:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContFrt.Value, ""))
3574:             IF NOT EMPTY(loc_cConta)
3575:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3576:                     "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
3577:                     "cursor_4c_ContFrt")
3578:                 IF loc_nRows > 0 AND cursor_4c_ContFrt.nExiste = 0
3579:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3580:                     loc_oPag2.txt_4c_ContFrt.SetFocus()
3581:                 ENDIF
3582:                 USE IN SELECT("cursor_4c_ContFrt")
3583:             ENDIF
3584:         CATCH TO loc_oErro
3585:             MostrarErro(loc_oErro, "Formcfo.ValidarContFrt")
3586:         ENDTRY
3587:     ENDPROC
3588: 
3589:     *--------------------------------------------------------------------------
3590:     * ValidarContSeg - Valida Conta de Seguro contra SigCdCli (LostFocus)
3591:     *--------------------------------------------------------------------------
3592:     PROCEDURE ValidarContSeg()
3593:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3594:         IF gb_4c_ValidandoUI
3595:             RETURN
3596:         ENDIF
3597:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3598:         loc_cConta = ""
3599:         loc_nRows  = 0
3600:         TRY
3601:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContSeg.Value, ""))
3602:             IF NOT EMPTY(loc_cConta)
3603:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3604:                     "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
3605:                     "cursor_4c_ContSeg")
3606:                 IF loc_nRows > 0 AND cursor_4c_ContSeg.nExiste = 0
3607:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3608:                     loc_oPag2.txt_4c_ContSeg.SetFocus()
3609:                 ENDIF
3610:                 USE IN SELECT("cursor_4c_ContSeg")
3611:             ENDIF
3612:         CATCH TO loc_oErro
3613:             MostrarErro(loc_oErro, "Formcfo.ValidarContSeg")
3614:         ENDTRY
3615:     ENDPROC
3616: 
3617:     *--------------------------------------------------------------------------
3618:     * ValidarContDa - Valida Conta de Despesas contra SigCdCli (LostFocus)
3619:     *--------------------------------------------------------------------------
3620:     PROCEDURE ValidarContDa()
3621:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3622:         IF gb_4c_ValidandoUI
3623:             RETURN
3624:         ENDIF
3625:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3626:         loc_cConta = ""
3627:         loc_nRows  = 0
3628:         TRY
3629:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContDa.Value, ""))
3630:             IF NOT EMPTY(loc_cConta)
3631:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3632:                     "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
3633:                     "cursor_4c_ContDa")
3634:                 IF loc_nRows > 0 AND cursor_4c_ContDa.nExiste = 0
3635:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3636:                     loc_oPag2.txt_4c_ContDa.SetFocus()
3637:                 ENDIF
3638:                 USE IN SELECT("cursor_4c_ContDa")
3639:             ENDIF
3640:         CATCH TO loc_oErro
3641:             MostrarErro(loc_oErro, "Formcfo.ValidarContDa")
3642:         ENDTRY
3643:     ENDPROC
3644: 
3645:     *--------------------------------------------------------------------------
3646:     * BtnSalvarClick - Confirma o registro (Incluir ou Alterar)
3647:     *--------------------------------------------------------------------------
3648:     PROCEDURE BtnSalvarClick()
3649:         LOCAL loc_lResultado, loc_oPag1
3650:         loc_lResultado = .F.
3651:         loc_oPag1      = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3652: 
3653:         *-- Validacoes basicas ANTES do TRY
3654:         IF EMPTY(ALLTRIM(loc_oPag1.txt_4c_Codigo.Value))
3655:             MsgAviso("C" + CHR(243) + "digo em branco.", "Confirmar")
3656:             loc_oPag1.txt_4c_Codigo.SetFocus()
3657:             RETURN
3658:         ENDIF
3659: 
3660:         IF EMPTY(ALLTRIM(loc_oPag1.txt_4c_Descricao.Value))
3661:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida.", "Confirmar")
3662:             loc_oPag1.txt_4c_Descricao.SetFocus()
3663:             RETURN
3664:         ENDIF
3665: 
3666:         TRY
3667:             THIS.FormParaBO()
3668:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
3669:             IF loc_lResultado
3670:                 MsgSucesso("Registro salvo com sucesso!")
3671:                 THIS.AlternarPagina(1)
3672:             ENDIF
3673:         CATCH TO loc_oErro
3674:             MostrarErro(loc_oErro, "Formcfo.BtnSalvarClick")
3675:         ENDTRY
3676:     ENDPROC
3677: 
3678:     *--------------------------------------------------------------------------
3679:     * BtnCancelarClick - Cancela e volta para a lista
3680:     *--------------------------------------------------------------------------
3681:     PROCEDURE BtnCancelarClick()
3682:         TRY
3683:             THIS.this_oBusinessObject.CancelarEdicao()
3684:         CATCH TO loc_oErro
3685:             *-- Ignora erro se CancelarEdicao nao existir no BO base
3686:         ENDTRY
3687:         THIS.AlternarPagina(1)
3688:     ENDPROC
3689: 
3690:     *--------------------------------------------------------------------------
3691:     * ValidarCfoST60 - Lookup CFOP ST60 via FormBuscaAuxiliar
3692:     *--------------------------------------------------------------------------
3693:     PROCEDURE ValidarCfoST60()
3694:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3695:         loc_oBusca  = .NULL.
3696:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3697:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))
3698: 
3699:         IF EMPTY(loc_cCodAtual)
3700:             RETURN
3701:         ENDIF
3702: 
3703:         TRY
3704:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3705:                 "SigCdCfo", "cursor_4c_BuscaCfoST60", "codigos", ;
3706:                 loc_cCodAtual, ;
3707:                 "CFOP ST60")
3708: 
3709:             IF VARTYPE(loc_oBusca) = "O"
3710:                 IF !loc_oBusca.this_lAchouRegistro
3711:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3712:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3713:                     loc_oBusca.Show()
3714:                 ENDIF
3715:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
3716:                     SELECT cursor_4c_BuscaCfoST60
3717:                     loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
3718:                 ENDIF
3719:                 loc_oBusca.Release()
3720:                 loc_oBusca = .NULL.
3721:             ENDIF
3722:         CATCH TO loc_oErro
3723:             MostrarErro(loc_oErro, "Formcfo.ValidarCfoST60")
3724:         ENDTRY
3725: 
3726:         IF USED("cursor_4c_BuscaCfoST60")
3727:             USE IN cursor_4c_BuscaCfoST60
3728:         ENDIF
3729:     ENDPROC
3730: 
3731:     *--------------------------------------------------------------------------
3732:     * ValidarCfoST - Lookup CFOP Subst.Trib. via FormBuscaAuxiliar
3733:     *--------------------------------------------------------------------------
3734:     PROCEDURE ValidarCfoST()
3735:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3736:         loc_oBusca  = .NULL.
3737:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3738:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))
3739: 
3740:         IF EMPTY(loc_cCodAtual)
3741:             RETURN
3742:         ENDIF
3743: 
3744:         TRY
3745:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3746:                 "SigCdCfo", "cursor_4c_BuscaCfoST", "codigos", ;
3747:                 loc_cCodAtual, ;
3748:                 "CFOP Subst.Trib.")
3749: 
3750:             IF VARTYPE(loc_oBusca) = "O"
3751:                 IF !loc_oBusca.this_lAchouRegistro
3752:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3753:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3754:                     loc_oBusca.Show()
3755:                 ENDIF
3756:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
3757:                     SELECT cursor_4c_BuscaCfoST
3758:                     loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
3759:                 ENDIF
3760:                 loc_oBusca.Release()
3761:                 loc_oBusca = .NULL.
3762:             ENDIF
3763:         CATCH TO loc_oErro
3764:             MostrarErro(loc_oErro, "Formcfo.ValidarCfoST")
3765:         ENDTRY
3766: 
3767:         IF USED("cursor_4c_BuscaCfoST")
3768:             USE IN cursor_4c_BuscaCfoST
3769:         ENDIF
3770:     ENDPROC
3771: 
3772:     *--------------------------------------------------------------------------
3773:     * ValidarCfdest - Lookup CFOP Destino via FormBuscaAuxiliar
3774:     *--------------------------------------------------------------------------
3775:     PROCEDURE ValidarCfdest()
3776:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3777:         loc_oBusca  = .NULL.
3778:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3779:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))
3780: 
3781:         IF EMPTY(loc_cCodAtual)
3782:             RETURN
3783:         ENDIF
3784: 
3785:         TRY
3786:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3787:                 "SigCdCfo", "cursor_4c_BuscaCfdest", "codigos", ;
3788:                 loc_cCodAtual, ;
3789:                 "CFOP Destino")
3790: 
3791:             IF VARTYPE(loc_oBusca) = "O"
3792:                 IF !loc_oBusca.this_lAchouRegistro
3793:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3794:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3795:                     loc_oBusca.Show()
3796:                 ENDIF
3797:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
3798:                     SELECT cursor_4c_BuscaCfdest
3799:                     loc_oPag1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
3800:                 ENDIF
3801:                 loc_oBusca.Release()
3802:                 loc_oBusca = .NULL.
3803:             ENDIF
3804:         CATCH TO loc_oErro
3805:             MostrarErro(loc_oErro, "Formcfo.ValidarCfdest")
3806:         ENDTRY
3807: 
3808:         IF USED("cursor_4c_BuscaCfdest")
3809:             USE IN cursor_4c_BuscaCfdest
3810:         ENDIF
3811:     ENDPROC
3812: 
3813:     *--------------------------------------------------------------------------
3814:     * ValidarSittricm - Lookup Situacao Tributaria ICMS via FormBuscaAuxiliar
3815:     *--------------------------------------------------------------------------
3816:     PROCEDURE ValidarSittricm()
3817:         LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
3818:         loc_oBusca  = .NULL.
3819:         loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3820:         loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))
3821: 
3822:         IF EMPTY(loc_cCodAtual)
3823:             RETURN
3824:         ENDIF
3825: 
3826:         TRY
3827:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3828:                 "SigCdIcm", "cursor_4c_BuscaIcm", "codigos", ;
3829:                 loc_cCodAtual, ;
3830:                 "Tributa" + CHR(231) + CHR(227) + "o ICMS")
3831: 
3832:             IF VARTYPE(loc_oBusca) = "O"
3833:                 IF !loc_oBusca.this_lAchouRegistro
3834:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3835:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3836:                     loc_oBusca.Show()
3837:                 ENDIF
3838:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
3839:                     SELECT cursor_4c_BuscaIcm
3840:                     loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.codigos)
3841:                 ENDIF
3842:                 loc_oBusca.Release()
3843:                 loc_oBusca = .NULL.
3844:             ENDIF
3845:         CATCH TO loc_oErro
3846:             MostrarErro(loc_oErro, "Formcfo.ValidarSittricm")
3847:         ENDTRY
3848: 
3849:         IF USED("cursor_4c_BuscaIcm")
3850:             USE IN cursor_4c_BuscaIcm
3851:         ENDIF
3852:     ENDPROC
3853: 
3854:     *--------------------------------------------------------------------------
3855:     * FormParaBO - Transfere valores da tela para o Business Object (parte 1)
3856:     *--------------------------------------------------------------------------
3857:     PROTECTED PROCEDURE FormParaBO()
3858:         LOCAL loc_oPag1, loc_oBO
3859:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3860:         loc_oBO   = THIS.this_oBusinessObject
3861: 
3862:         TRY
3863:             *-- Dados principais
3864:             loc_oBO.this_cCodigos    = ALLTRIM(NVL(loc_oPag1.txt_4c_Codigo.Value, ""))
3865:             loc_oBO.this_cDescricaos = ALLTRIM(NVL(loc_oPag1.txt_4c_Descricao.Value, ""))
3866:             loc_oBO.this_cDesc2s     = ALLTRIM(NVL(loc_oPag1.txt_4c_Desc2s.Value, ""))
3867:             loc_oBO.this_nSituas     = IIF(loc_oPag1.obj_4c_Opc_situacao.Value = 1, 1, 0)
3868:             loc_oBO.this_cOperacaos  = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbOperacao.Value, ""))), 1)
3869:             loc_oBO.this_nTipos      = VAL(NVL(loc_oPag1.cbo_4c_Cmbtipo.Value, "0"))
3870:             loc_oBO.this_nNdigitos   = loc_oPag1.obj_4c_Ndigito.Value
3871: 
3872:             *-- ICMS
3873:             loc_oBO.this_cIcms       = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbIcms.Value, ""))), 1)
3874:             loc_oBO.this_nInclicms   = loc_oPag1.cbo_4c_Combo3.ListIndex
3875:             loc_oBO.this_nIcmsdscs   = loc_oPag1.cbo_4c_Combo6.ListIndex
3876:             loc_oBO.this_cCfost60s   = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))
3877:             loc_oBO.this_cCfosts     = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))
3878:             loc_oBO.this_cCoddests   = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))
3879:             loc_oBO.this_nFrticms    = IIF(loc_oPag1.chk_4c_ObjFreteICM.Value, 1, 0)
3880:             loc_oBO.this_nSegicms    = IIF(loc_oPag1.chk_4c_ObjSegIcm.Value, 1, 0)
3881:             loc_oBO.this_nDesicms    = IIF(loc_oPag1.chk_4c_ObjDespIcm.Value, 1, 0)
3882:             loc_oBO.this_nIncicmnfs  = IIF(loc_oPag1.chk_4c_Fwcheckbox1.Value, 1, 0)
3883:             loc_oBO.this_nSomaicmfrete = IIF(loc_oPag1.chk_4c_Fwcheckbox2.Value, 1, 0)
3884:             loc_oBO.this_cSubtribs   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbSTRIB.Value, ""))), 1)
3885:             loc_oBO.this_nPbcsts     = VAL(NVL(loc_oPag1.txt_4c_Bcst.Value, "0"))
3886:             loc_oBO.this_nTransps    = loc_oPag1.cbo_4c_Combo5.ListIndex
3887:             loc_oBO.this_nIcmsincs   = loc_oPag1.cbo_4c_Combo10.ListIndex
3888:             loc_oBO.this_cSittribs   = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))
3889:             loc_oBO.this_cContribs   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbContribuinte.Value, ""))), 1)
3890:             loc_oBO.this_nAliqivcs   = VAL(NVL(loc_oPag1.txt_4c_AliqIVCs.Value, "0"))
3891:             loc_oBO.this_cMotdeson   = ALLTRIM(NVL(loc_oPag1.txt_4c_MotDeson.Value, ""))
3892:             loc_oBO.this_cUnitimps   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_Combo9.Value, ""))), 1)
3893:             loc_oBO.this_cIpiIcms    = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_Combo4.Value, ""))), 1)
3894: 
3895:             *-- IPI (Parte 2)
3896:             loc_oBO.this_cIpis       = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbIpi.Value, ""))), 1)
3897:             loc_oBO.this_nAliqipis   = VAL(NVL(loc_oPag1.txt_4c_Aliqs.Value, "0"))

*-- Linhas 3960 a 4003:
3960:     *--------------------------------------------------------------------------
3961:     * BOParaForm - Transfere valores do Business Object para a tela (parte 1)
3962:     *--------------------------------------------------------------------------
3963:     PROTECTED PROCEDURE BOParaForm()
3964:         LOCAL loc_oPag1, loc_oBO
3965:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3966:         loc_oBO   = THIS.this_oBusinessObject
3967: 
3968:         TRY
3969:             *-- Dados principais
3970:             loc_oPag1.txt_4c_Codigo.Value    = ALLTRIM(NVL(loc_oBO.this_cCodigos, ""))
3971:             loc_oPag1.txt_4c_Descricao.Value = ALLTRIM(NVL(loc_oBO.this_cDescricaos, ""))
3972:             loc_oPag1.txt_4c_Desc2s.Value    = ALLTRIM(NVL(loc_oBO.this_cDesc2s, ""))
3973:             loc_oPag1.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)
3974:             loc_oPag1.obj_4c_Ndigito.Value      = loc_oBO.this_nNdigitos
3975: 
3976:             *-- Operacao
3977:             loc_oPag1.cbo_4c_CmbOperacao.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cOperacaos)) = "E", ;
3978:                 "Entrada", "Sa" + CHR(237) + "da")
3979: 
3980:             *-- Tipo
3981:             loc_oPag1.cbo_4c_Cmbtipo.Value = LTRIM(STR(loc_oBO.this_nTipos))
3982: 
3983:             *-- ICMS regime
3984:             LOCAL loc_cIcmsDisplay
3985:             DO CASE
3986:                 CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "O"
3987:                     loc_cIcmsDisplay = "Outros"
3988:                 CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "I"
3989:                     loc_cIcmsDisplay = "Isento"
3990:                 CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "N"
3991:                     loc_cIcmsDisplay = "N Tributa"
3992:                 OTHERWISE
3993:                     loc_cIcmsDisplay = "Tributado"
3994:             ENDCASE
3995:             loc_oPag1.cbo_4c_CmbIcms.Value = loc_cIcmsDisplay
3996: 
3997:             *-- Incluir ICMS (ListIndex = valor numerico)
3998:             loc_oPag1.cbo_4c_Combo3.ListIndex  = loc_oBO.this_nInclicms
3999:             loc_oPag1.cbo_4c_Combo6.ListIndex  = loc_oBO.this_nIcmsdscs
4000:             loc_oPag1.cbo_4c_Combo10.ListIndex = loc_oBO.this_nIcmsincs
4001:             loc_oPag1.cbo_4c_Combo5.ListIndex  = loc_oBO.this_nTransps
4002: 
4003:             *-- CFOP lookups

*-- Linhas 4153 a 4196:
4153:     *--------------------------------------------------------------------------
4154:     * LimparCampos - Limpa todos os campos do Page1 (parte 1) para novo registro
4155:     *--------------------------------------------------------------------------
4156:     PROTECTED PROCEDURE LimparCampos()
4157:         LOCAL loc_oPag1
4158:         loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4159: 
4160:         TRY
4161:             *-- Dados principais
4162:             loc_oPag1.txt_4c_Codigo.Value    = ""
4163:             loc_oPag1.txt_4c_Descricao.Value = ""
4164:             loc_oPag1.txt_4c_Desc2s.Value    = ""
4165:             loc_oPag1.obj_4c_Opc_situacao.Value  = 1
4166:             loc_oPag1.obj_4c_Ndigito.Value        = 0
4167:             loc_oPag1.cbo_4c_CmbOperacao.ListIndex = 1
4168:             loc_oPag1.cbo_4c_Cmbtipo.ListIndex     = 1
4169: 
4170:             *-- ICMS
4171:             loc_oPag1.cbo_4c_CmbIcms.ListIndex    = 1
4172:             loc_oPag1.cbo_4c_Combo3.ListIndex      = 1
4173:             loc_oPag1.cbo_4c_Combo6.ListIndex      = 2
4174:             loc_oPag1.cbo_4c_Combo10.ListIndex     = 2
4175:             loc_oPag1.cbo_4c_Combo5.ListIndex      = 2
4176:             loc_oPag1.txt_4c_CfoST60.Value         = ""
4177:             loc_oPag1.txt_4c_CfoST.Value           = ""
4178:             loc_oPag1.txt_4c_Cfdest.Value          = ""
4179:             loc_oPag1.chk_4c_ObjFreteICM.Value     = 0
4180:             loc_oPag1.chk_4c_ObjSegIcm.Value       = 0
4181:             loc_oPag1.chk_4c_ObjDespIcm.Value      = 0
4182:             loc_oPag1.chk_4c_Fwcheckbox1.Value     = 0
4183:             loc_oPag1.chk_4c_Fwcheckbox2.Value     = 0
4184:             loc_oPag1.cbo_4c_CmbSTRIB.ListIndex    = 2
4185:             loc_oPag1.txt_4c_Bcst.Value            = "  0.00"
4186:             loc_oPag1.txt_4c_Sittricm.Value        = ""
4187:             loc_oPag1.cbo_4c_CmbContribuinte.ListIndex = 2
4188:             loc_oPag1.txt_4c_AliqIVCs.Value        = " 0.00"
4189:             loc_oPag1.txt_4c_MotDeson.Value        = ""
4190:             loc_oPag1.cbo_4c_Combo9.ListIndex      = 2
4191:             loc_oPag1.cbo_4c_Combo4.ListIndex      = 2
4192: 
4193:             *-- IPI / NF-e (Parte 2)
4194:             loc_oPag1.cbo_4c_CmbIpi.ListIndex      = 1   && Tributado
4195:             loc_oPag1.txt_4c_Aliqs.Value           = " 0.00"
4196:             loc_oPag1.cbo_4c_CmbIpiI.ListIndex     = 2   && Nao (ipiimpors)

*-- Linhas 4236 a 4299:
4236:             loc_oPag2C.cbo_4c_Combo2.ListIndex = 2   && Nao-Nenhuma
4237:             loc_oPag2C.cbo_4c_CmbFixa.Value    = "N" + CHR(227) + "o (CFOP)"
4238: 
4239:             *-- OptionGroups (defaults: Nao)
4240:             loc_oPag2C.obj_4c_OptAgrupas.Value  = 2   && Nao
4241:             loc_oPag2C.obj_4c_OptZeradas.Value  = 2   && Nao
4242:             loc_oPag2C.obj_4c_Fwoption1.Value   = 1   && Data Integracao (default)
4243:             loc_oPag2C.obj_4c_Optutilvars.Value = 2   && Nao
4244:             loc_oPag2C.obj_4c_Fwoption2.Value   = 2   && Nao
4245:             loc_oPag2C.obj_4c_Fwoption3.Value   = 2   && Nao
4246:             loc_oPag2C.obj_4c_Fwoption4.Value   = 2   && Nao
4247:             loc_oPag2C.obj_4c_Fwoption5.Value   = 2   && Nao
4248:             loc_oPag2C.obj_4c_Fwoption6.Value   = 2   && Nao
4249: 
4250:         CATCH TO loc_oErro
4251:             MostrarErro(loc_oErro, "Formcfo.LimparCampos")
4252:         ENDTRY
4253:     ENDPROC
4254: 
4255:     *--------------------------------------------------------------------------
4256:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
4257:     * par_lHabilitar = .T. para editar, .F. para somente leitura (VISUALIZAR)
4258:     *--------------------------------------------------------------------------
4259:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
4260:         LOCAL loc_oPag1, loc_oPag2, loc_lHabCodigo
4261: 
4262:         *-- Codigo editavel apenas em INCLUIR (nunca em ALTERAR)
4263:         loc_lHabCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
4264: 
4265:         TRY
4266:             loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4267: 
4268:             *-- Codigo (apenas INCLUIR)
4269:             loc_oPag1.txt_4c_Codigo.Enabled   = loc_lHabCodigo
4270:             *-- Spinner digitos
4271:             loc_oPag1.obj_4c_Ndigito.Enabled  = par_lHabilitar
4272: 
4273:             *-- Descricoes
4274:             loc_oPag1.txt_4c_Descricao.Enabled   = par_lHabilitar
4275:             loc_oPag1.txt_4c_Desc2s.Enabled      = par_lHabilitar
4276: 
4277:             *-- Combos / situacao
4278:             loc_oPag1.obj_4c_Opc_situacao.Enabled  = par_lHabilitar
4279:             loc_oPag1.cbo_4c_CmbOperacao.Enabled   = par_lHabilitar
4280:             loc_oPag1.cbo_4c_Cmbtipo.Enabled       = par_lHabilitar
4281: 
4282:             *-- ICMS
4283:             loc_oPag1.cbo_4c_CmbIcms.Enabled       = par_lHabilitar
4284:             loc_oPag1.cbo_4c_Combo3.Enabled         = par_lHabilitar
4285:             loc_oPag1.cbo_4c_Combo6.Enabled         = par_lHabilitar
4286:             loc_oPag1.cbo_4c_Combo10.Enabled        = par_lHabilitar
4287:             loc_oPag1.cbo_4c_CmbSTRIB.Enabled       = par_lHabilitar
4288:             loc_oPag1.cbo_4c_Combo5.Enabled         = par_lHabilitar
4289:             loc_oPag1.cbo_4c_Combo9.Enabled         = par_lHabilitar
4290:             loc_oPag1.cbo_4c_CmbContribuinte.Enabled = par_lHabilitar
4291:             loc_oPag1.txt_4c_Bcst.Enabled           = par_lHabilitar
4292:             loc_oPag1.txt_4c_CfoST60.Enabled        = par_lHabilitar
4293:             loc_oPag1.txt_4c_CfoST.Enabled          = par_lHabilitar
4294:             loc_oPag1.txt_4c_Cfdest.Enabled         = par_lHabilitar
4295:             loc_oPag1.txt_4c_Sittricm.Enabled       = par_lHabilitar
4296:             loc_oPag1.txt_4c_AliqIVCs.Enabled       = par_lHabilitar
4297:             loc_oPag1.txt_4c_MotDeson.Enabled       = par_lHabilitar
4298:             loc_oPag1.txt_4c_Gergia1.Enabled        = par_lHabilitar
4299:             loc_oPag1.chk_4c_ObjFreteICM.Enabled    = par_lHabilitar

*-- Linhas 4362 a 4406:
4362:     *--------------------------------------------------------------------------
4363:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
4364:     *--------------------------------------------------------------------------
4365:     PROTECTED PROCEDURE AjustarBotoesPorModo()
4366:         LOCAL loc_oPg2, loc_lEmEdicao
4367: 
4368:         *-- Determina se esta em modo de edicao (INCLUIR ou ALTERAR)
4369:         loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
4370: 
4371:         TRY
4372:             *-- Botoes da Page2 (Confirmar/Cancelar)
4373:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4374: 
4375:             *-- Confirmar: habilitado apenas em INCLUIR/ALTERAR
4376:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEmEdicao
4377: 
4378:             *-- Cancelar: sempre habilitado em Page2
4379:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
4380: 
4381:             *-- Botoes da Page1 (CRUD): desabilita Alterar/Excluir quando nao ha registro
4382:             LOCAL loc_oPg1
4383:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
4384:             LOCAL loc_lTemRegistro
4385:             loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
4386: 
4387:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
4388:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
4389:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
4390: 
4391:         CATCH TO loc_oErro
4392:             MostrarErro(loc_oErro, "Formcfo.AjustarBotoesPorModo")
4393:         ENDTRY
4394:     ENDPROC
4395: 
4396:     *--------------------------------------------------------------------------
4397:     * Destroy - Libera recursos ao fechar
4398:     *--------------------------------------------------------------------------
4399:     PROCEDURE Destroy()
4400:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
4401:             THIS.this_oBusinessObject = .NULL.
4402:         ENDIF
4403:         DODEFAULT()
4404:     ENDPROC
4405: 
4406: ENDDEFINE


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
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
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

