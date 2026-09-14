# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarUFIBGES' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarUFIBGES(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMun.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1093 linhas total):

*-- Linhas 27 a 155:
27:     *==========================================================================
28:     * Init - Inicializa o formulario
29:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
30:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
31:     *==========================================================================
32:     PROCEDURE Init()
33:         RETURN DODEFAULT()
34:     ENDPROC
35: 
36:     *==========================================================================
37:     * InicializarForm - Configura estrutura completa do formulario
38:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
39:     *==========================================================================
40:     PROTECTED PROCEDURE InicializarForm()
41:         LOCAL loc_lSucesso
42:         loc_lSucesso = .F.
43: 
44:         TRY
45:             THIS.this_oBusinessObject = CREATEOBJECT("MunBO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar MunBO" + CHR(13) + ;
49:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
50:                     "FormMun.InicializarForm")
51:             ELSE
52:                 *-- Caption com acentuacao correta (nunca acentos literais em .PRG)
53:                 THIS.Caption = "Cadastro de C" + CHR(243) + "digo de Munic" + CHR(237) + "pios"
54: 
55:                 THIS.ConfigurarPageFrame()
56: 
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59: 
60:                 THIS.pgf_4c_Paginas.Visible   = .T.
61:                 THIS.pgf_4c_Paginas.ActivePage = 1
62:                 THIS.this_cModoAtual = "LISTA"
63: 
64:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
65:                     THIS.CarregarLista()
66:                 ENDIF
67: 
68:                 loc_lSucesso = .T.
69:             ENDIF
70: 
71:         CATCH TO loException
72:             MostrarErro("Erro ao inicializar FormMun:" + CHR(13) + ;
73:                 loException.Message + CHR(13) + ;
74:                 "Linha: " + TRANSFORM(loException.LineNo), ;
75:                 "FormMun.InicializarForm")
76:         ENDTRY
77: 
78:         RETURN loc_lSucesso
79:     ENDPROC
80: 
81:     *==========================================================================
82:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
83:     * Top=-29 esconde abas; todos os controles dentro compensam +29 no Top
84:     *==========================================================================
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
87: 
88:         WITH THIS.pgf_4c_Paginas
89:             .PageCount = 2
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = THIS.Width
93:             .Height    = THIS.Height + 29
94:             .Tabs      = .F.
95:             .Visible   = .T.
96: 
97:             .Page1.Caption   = "Lista"
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page1.BackColor = RGB(255, 255, 255)
100: 
101:             .Page2.Caption   = "Dados"
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()
107:         THIS.ConfigurarPaginaDados()
108:     ENDPROC
109: 
110:     *==========================================================================
111:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e Grid
112:     * Original: cntSombra.Top=1, Grupo_op.Top=-1 (Left=538), Grade.Top=88
113:     * Compensacao PageFrame (+29): Top original + 29
114:     *==========================================================================
115:     PROTECTED PROCEDURE ConfigurarPaginaLista()
116:         LOCAL loc_oPagina
117:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
118: 
119:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
120:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121: 
122:         *-- Container Cabecalho (cntSombra no legado)
123:         *-- Original: cntSombra.Top=1, Left=-1, Width=1008, Height=80
124:         *-- Com compensacao +29: Top=30
125:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH loc_oPagina.cnt_4c_Cabecalho
127:             .Top         = 30
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
137:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
138:             .Caption   = ""
139:             .Top       = 15
140:             .Left      = 10
141:             .Width     = THIS.Width - 20
142:             .Height    = 46
143:             .FontName  = "Tahoma"
144:             .FontSize  = 16
145:             .FontBold  = .T.
146:             .ForeColor = RGB(0, 0, 0)
147:             .BackStyle = 0
148:             .AutoSize  = .F.
149:             .Visible   = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = ""
155:             .Top       = 18

*-- Linhas 373 a 431:
373:             .Visible         = .T.
374:         ENDWITH
375: 
376:         *-- BINDEVENTs dos botoes CRUD e Encerrar (PUBLIC - obrigatorio para BINDEVENT)
377:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
380:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
383: 
384:         THIS.TornarControlesVisiveis(loc_oPagina)
385:     ENDPROC
386: 
387:     *==========================================================================
388:     * ConfigurarPaginaDados - Configura Page2: container de acoes e campos
389:     * Original: Grupo_Salva.Top=9, Left=817. Com compensacao +29: Top=38
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarPaginaDados()
392:         LOCAL loc_oPagina
393:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
394: 
395:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
396:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
397: 
398:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
399:         *-- Original: Grupo_Salva.Top=9, Left=817, Width=160, Height=85
400:         *-- Com compensacao +29: Top=38
401:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
402:         WITH loc_oPagina.cnt_4c_Salva
403:             .Top         = 38
404:             .Left        = 817
405:             .Width       = 160
406:             .Height      = 85
407:             .BackStyle = 1
408:             .BackColor = RGB(255, 255, 255)
409:             .BorderWidth = 0
410:             .Visible     = .T.
411:         ENDWITH
412: 
413:         *-- Botao Confirmar (Salvar)
414:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
415:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
416:             .Caption         = "Confirmar"
417:             .Top             = 5
418:             .Left            = 5
419:             .Width           = 75
420:             .Height          = 75
421:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
422:             .PicturePosition = 13
423:             .FontName        = "Comic Sans MS"
424:             .FontSize        = 8
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .ForeColor       = RGB(90, 90, 90)
428:             .BackColor       = RGB(255, 255, 255)
429:             .Themes          = .F.
430:             .SpecialEffect   = 0
431:             .MousePointer    = 15

*-- Linhas 458 a 503:
458:             .Visible         = .T.
459:         ENDWITH
460: 
461:         *-- BINDEVENTs dos botoes de Page2 (PUBLIC - obrigatorio para BINDEVENT)
462:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
463:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
464: 
465:         *-- ====== CAMPOS DA PAGE2 - PARTE 1/2 ======
466:         *-- Coordenadas originais do SCX + compensacao PageFrame (+29 no Top)
467: 
468:         *-- lbl_4c_Label2: "Codigo :" - Original: Top=133, Left=302, Width=42, Height=15
469:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
470:         WITH loc_oPagina.lbl_4c_Label2
471:             .Caption   = "C" + CHR(243) + "digo :"
472:             .Top       = 162
473:             .Left      = 302
474:             .Width     = 42
475:             .Height    = 15
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .FontBold  = .F.
479:             .AutoSize  = .T.
480:             .BackStyle = 0
481:             .ForeColor = RGB(90, 90, 90)
482:             .Visible   = .T.
483:         ENDWITH
484: 
485:         *-- txt_4c_Codigos (get_Codigos): Original: Top=129, Left=347, Width=60, Height=25
486:         *-- InputMask="9999999": codigos e campo numerico-string (somente digitos)
487:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
488:         WITH loc_oPagina.txt_4c_Codigos
489:             .Value         = ""
490:             .Top           = 158
491:             .Left          = 347
492:             .Width         = 60
493:             .Height        = 25
494:             .FontName      = "Tahoma"
495:             .FontSize      = 8
496:             .InputMask     = "9999999"
497:             .MaxLength     = 7
498:             .SpecialEffect = 1
499:             .Visible       = .T.
500:         ENDWITH
501: 
502:         *-- lbl_4c_Label5 (Say5): "Cod. da UF no IBGE :" - Original: Top=133, Left=504
503:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 569 a 1093:
569:             .Visible       = .T.
570:         ENDWITH
571: 
572:         *-- BINDEVENT: ValidarUFIBGES equivale ao Valid/fwBuscaExt original (SigCdUfs.UFIBGEs)
573:         BINDEVENT(loc_oPagina.txt_4c_UFIBGES, "KeyPress", THIS, "ValidarUFIBGES")
574: 
575:         THIS.TornarControlesVisiveis(loc_oPagina)
576:     ENDPROC
577: 
578:     *==========================================================================
579:     * CarregarLista - Carrega dados no Grid da Page1 via MunBO.Buscar()
580:     *==========================================================================
581:     PROCEDURE CarregarLista()
582:         LOCAL loc_lResultado, loc_oGrid
583:         loc_lResultado = .F.
584: 
585:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
586:             loc_lResultado = .T.
587:         ELSE
588:             TRY
589:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
590: 
591:                 IF !THIS.this_oBusinessObject.Buscar("")
592:                     loc_lResultado = .F.
593:                 ELSE
594:                     *-- Problema 36: RecordSource e ColumnCount FORA de WITH
595:                     loc_oGrid.ColumnCount = 2
596:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
597:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
598:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
599: 
600:                     *-- Problema 32: redefinir cabecalhos apos RecordSource (auto-bind reseta)
601:                     loc_oGrid.Column1.Width           = 60
602:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
603:                     loc_oGrid.Column2.Width           = 290
604:                     loc_oGrid.Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
605: 
606:                     THIS.FormatarGridLista(loc_oGrid)
607:                     loc_oGrid.Refresh()
608:                     loc_lResultado = .T.
609:                 ENDIF
610:             CATCH TO loException
611:                 MsgErro(loException.Message + CHR(13) + ;
612:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
613:                     "Procedure: " + loException.Procedure, ;
614:                     "FormMun.CarregarLista")
615:                 loc_lResultado = .F.
616:             ENDTRY
617:         ENDIF
618: 
619:         RETURN loc_lResultado
620:     ENDPROC
621: 
622:     *==========================================================================
623:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
624:     *==========================================================================
625:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
626:         LOCAL loc_nI, loc_oObjeto, loc_nP
627: 
628:         FOR loc_nI = 1 TO par_oContainer.ControlCount
629:             loc_oObjeto = par_oContainer.Controls(loc_nI)
630: 
631:             IF VARTYPE(loc_oObjeto) = "O"
632:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
633:                     loc_oObjeto.Visible = .T.
634:                 ENDIF
635: 
636:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
637:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
638:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
639:                     ENDFOR
640:                 ENDIF
641: 
642:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
643:                     THIS.TornarControlesVisiveis(loc_oObjeto)
644:                 ENDIF
645:             ENDIF
646:         ENDFOR
647:     ENDPROC
648: 
649:     *==========================================================================
650:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
651:     *==========================================================================
652:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
653:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
654:             RETURN .F.
655:         ENDIF
656: 
657:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
658: 
659:         IF par_nPagina = 1
660:             THIS.this_cModoAtual = "LISTA"
661:             THIS.CarregarLista()
662:         ENDIF
663: 
664:         RETURN .T.
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * FormatarGridLista - Formata visual do grid da lista
669:     *==========================================================================
670:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
671:         WITH par_oGrid
672:             .FontName = "Verdana"
673:             .FontSize = 8
674:         ENDWITH
675:     ENDPROC
676: 
677:     *==========================================================================
678:     * BtnEncerrarClick - Fecha o formulario
679:     *==========================================================================
680:     PROCEDURE BtnEncerrarClick()
681:         THIS.Release()
682:     ENDPROC
683: 
684:     *==========================================================================
685:     * BtnIncluirClick - Prepara inclusao de novo municipio
686:     *==========================================================================
687:     PROCEDURE BtnIncluirClick()
688:         THIS.this_oBusinessObject.NovoRegistro()
689:         THIS.this_cModoAtual = "INCLUIR"
690:         THIS.LimparCampos()
691:         THIS.HabilitarCampos(.T.)
692:         THIS.AlternarPagina(2)
693:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
694:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
695:         ENDIF
696:     ENDPROC
697: 
698:     *==========================================================================
699:     * BtnVisualizarClick - Exibe municipio selecionado em modo somente leitura
700:     *==========================================================================
701:     PROCEDURE BtnVisualizarClick()
702:         LOCAL loc_cCodigo
703: 
704:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
705:             MsgAviso("Selecione um munic" + CHR(237) + "pio na lista.", "")
706:             RETURN
707:         ENDIF
708: 
709:         SELECT cursor_4c_Dados
710:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
711: 
712:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
713:             THIS.this_cModoAtual = "VISUALIZAR"
714:             THIS.BOParaForm()
715:             THIS.HabilitarCampos(.F.)
716:             THIS.AlternarPagina(2)
717:         ELSE
718:             MsgAviso("Erro ao carregar o munic" + CHR(237) + "pio selecionado.", "")
719:         ENDIF
720:     ENDPROC
721: 
722:     *==========================================================================
723:     * BtnAlterarClick - Abre municipio selecionado para edicao
724:     *==========================================================================
725:     PROCEDURE BtnAlterarClick()
726:         LOCAL loc_cCodigo
727: 
728:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
729:             MsgAviso("Selecione um munic" + CHR(237) + "pio na lista.", "")
730:             RETURN
731:         ENDIF
732: 
733:         SELECT cursor_4c_Dados
734:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
735: 
736:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
737:             THIS.this_oBusinessObject.EditarRegistro()
738:             THIS.this_cModoAtual = "ALTERAR"
739:             THIS.BOParaForm()
740:             THIS.HabilitarCampos(.T.)
741:             THIS.AlternarPagina(2)
742:         ELSE
743:             MsgAviso("Erro ao carregar o munic" + CHR(237) + "pio selecionado.", "")
744:         ENDIF
745:     ENDPROC
746: 
747:     *==========================================================================
748:     * BtnExcluirClick - Exclui municipio selecionado apos confirmacao
749:     *==========================================================================
750:     PROCEDURE BtnExcluirClick()
751:         LOCAL loc_cCodigo, loc_lConfirmado
752: 
753:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
754:             MsgAviso("Selecione um munic" + CHR(237) + "pio na lista.", "")
755:             RETURN
756:         ENDIF
757: 
758:         SELECT cursor_4c_Dados
759:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
760: 
761:         loc_lConfirmado = MsgConfirma("Deseja excluir o munic" + CHR(237) + ;
762:             "pio '" + loc_cCodigo + "'?", ;
763:             "Confirmar Exclus" + CHR(227) + "o")
764: 
765:         IF loc_lConfirmado
766:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
767:                 IF THIS.this_oBusinessObject.Excluir()
768:                     MsgInfo("Munic" + CHR(237) + "pio exclu" + CHR(237) + ;
769:                         "do com sucesso!", "")
770:                     THIS.CarregarLista()
771:                 ENDIF
772:             ELSE
773:                 MsgAviso("Erro ao carregar o munic" + CHR(237) + ;
774:                     "pio para exclus" + CHR(227) + "o.", "")
775:             ENDIF
776:         ENDIF
777:     ENDPROC
778: 
779:     *==========================================================================
780:     * BtnBuscarClick - Abre lookup para localizar municipio na lista
781:     *==========================================================================
782:     PROCEDURE BtnBuscarClick()
783:         LOCAL loc_oBusca, loc_cCodigo
784: 
785:         TRY
786:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
787:                 "SigCdMun", "cursor_4c_BuscaMun", "codigos", "", ;
788:                 "Buscar Munic" + CHR(237) + "pio")
789: 
790:             IF VARTYPE(loc_oBusca) = "O"
791:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
792:                 loc_oBusca.mAddColuna("descs",   "", "Munic" + CHR(237) + "pio")
793:                 loc_oBusca.Show()
794: 
795:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMun")
796:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaMun.codigos)
797:                     IF USED("cursor_4c_Dados")
798:                         SELECT cursor_4c_Dados
799:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
800:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
801:                     ENDIF
802:                 ENDIF
803: 
804:                 loc_oBusca.Release()
805:             ENDIF
806:         CATCH TO loException
807:             MsgErro(loException.Message + CHR(13) + ;
808:                 "Linha: " + TRANSFORM(loException.LineNo), ;
809:                 "FormMun.BtnBuscarClick")
810:         ENDTRY
811: 
812:         IF USED("cursor_4c_BuscaMun")
813:             USE IN cursor_4c_BuscaMun
814:         ENDIF
815:     ENDPROC
816: 
817:     *==========================================================================
818:     * BtnSalvarClick - Salva o municipio (Confirmar na Page2)
819:     *==========================================================================
820:     PROCEDURE BtnSalvarClick()
821:         LOCAL loc_oPagina
822:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
823: 
824:         *-- Validacoes obrigatorias antes do TRY (RETURN nao permitido dentro de TRY)
825:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
826:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigos.Value))
827:                 MsgAviso("C" + CHR(243) + "digo do Munic" + CHR(237) + ;
828:                     "pio obrigat" + CHR(243) + "rio!", "")
829:                 loc_oPagina.txt_4c_Codigos.SetFocus()
830:                 RETURN
831:             ENDIF
832:         ENDIF
833: 
834:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
835:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Descs.Value))
836:                 MsgAviso("Nome do Munic" + CHR(237) + "pio obrigat" + CHR(243) + "rio!", "")
837:                 loc_oPagina.txt_4c_Descs.SetFocus()
838:                 RETURN
839:             ENDIF
840:         ENDIF
841: 
842:         THIS.FormParaBO()
843: 
844:         IF THIS.this_oBusinessObject.ValidarDuplicidade()
845:             MsgAviso("C" + CHR(243) + "digo " + ;
846:                 ALLTRIM(THIS.this_oBusinessObject.this_cCodigos) + ;
847:                 " j" + CHR(225) + " cadastrado!", "")
848:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
849:                 loc_oPagina.txt_4c_Codigos.SetFocus()
850:             ENDIF
851:             RETURN
852:         ENDIF
853: 
854:         IF THIS.this_oBusinessObject.Salvar()
855:             MsgInfo("Munic" + CHR(237) + "pio salvo com sucesso!", "")
856:             THIS.AlternarPagina(1)
857:         ENDIF
858:     ENDPROC
859: 
860:     *==========================================================================
861:     * BtnCancelarClick - Cancela edicao e volta para lista
862:     *==========================================================================
863:     PROCEDURE BtnCancelarClick()
864:         THIS.this_cModoAtual = "LISTA"
865:         THIS.AlternarPagina(1)
866:     ENDPROC
867: 
868:     *==========================================================================
869:     * LimparCampos - Limpa todos os campos de entrada da Page2
870:     *==========================================================================
871:     PROTECTED PROCEDURE LimparCampos()
872:         LOCAL loc_oPagina
873:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
874: 
875:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
876:             loc_oPagina.txt_4c_Codigos.Value = ""
877:         ENDIF
878:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
879:             loc_oPagina.txt_4c_Descs.Value = ""
880:         ENDIF
881:         IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
882:             loc_oPagina.txt_4c_UFIBGES.Value = 0
883:         ENDIF
884:     ENDPROC
885: 
886:     *==========================================================================
887:     * HabilitarCampos - Habilita ou desabilita campos de entrada da Page2
888:     *==========================================================================
889:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
890:         LOCAL loc_oPagina, loc_lHabilitar
891:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
892:         loc_lHabilitar = (par_lHabilitar = .T.)
893: 
894:         *-- Codigo editavel somente em modo INCLUIR (PK nao pode ser alterada)
895:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
896:             loc_oPagina.txt_4c_Codigos.Enabled = (loc_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
897:         ENDIF
898:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
899:             loc_oPagina.txt_4c_Descs.Enabled = loc_lHabilitar
900:         ENDIF
901:         IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
902:             loc_oPagina.txt_4c_UFIBGES.Enabled = loc_lHabilitar
903:         ENDIF
904: 
905:         *-- Botao Confirmar habilitado somente quando campos editaveis
906:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Salva", 5)
907:             IF PEMSTATUS(loc_oPagina.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
908:                 loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lHabilitar
909:             ENDIF
910:         ENDIF
911:     ENDPROC
912: 
913:     *==========================================================================
914:     * BOParaForm - Transfere dados do BO para os campos da Page2
915:     *==========================================================================
916:     PROTECTED PROCEDURE BOParaForm()
917:         LOCAL loc_oPagina
918:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
919: 
920:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
921:             loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
922:         ENDIF
923:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
924:             loc_oPagina.txt_4c_Descs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
925:         ENDIF
926:         IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
927:             loc_oPagina.txt_4c_UFIBGES.Value = THIS.this_oBusinessObject.this_nUFIBGES
928:         ENDIF
929:     ENDPROC
930: 
931:     *==========================================================================
932:     * FormParaBO - Transfere dados dos campos da Page2 para o BO
933:     *==========================================================================
934:     PROTECTED PROCEDURE FormParaBO()
935:         LOCAL loc_oPagina
936:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
937: 
938:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
939:             THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
940:         ENDIF
941:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
942:             THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPagina.txt_4c_Descs.Value)
943:         ENDIF
944:         IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
945:             THIS.this_oBusinessObject.this_nUFIBGES = loc_oPagina.txt_4c_UFIBGES.Value
946:         ENDIF
947:     ENDPROC
948: 
949:     *==========================================================================
950:     * ValidarUFIBGES - Lookup SigCdUfs ao sair do campo (equivale ao Valid original)
951:     * Original: fwBuscaExt SigCdUfs / UFIBGEs / crListaRemota
952:     *==========================================================================
953:     PROCEDURE ValidarUFIBGES(par_nKeyCode, par_nShiftAltCtrl)
954:         LOCAL loc_oPagina, loc_nUFIBGES, loc_nResult, loc_cSQL, loc_oBusca
955:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
956:         loc_nUFIBGES = 0
957: 
958:         IF !PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
959:             RETURN
960:         ENDIF
961: 
962:         loc_nUFIBGES = loc_oPagina.txt_4c_UFIBGES.Value
963: 
964:         IF loc_nUFIBGES = 0
965:             RETURN
966:         ENDIF
967: 
968:         TRY
969:             *-- Busca exata por UFIBGEs
970:             loc_cSQL = "SELECT UFIBGEs, Estados, Descrs FROM SigCdUfs" + ;
971:                 " WHERE UFIBGEs = " + TRANSFORM(loc_nUFIBGES)
972: 
973:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUF")
974: 
975:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaUF") = 0
976:                 *-- Nao encontrado - mostrar lista completa para selecao
977:                 IF USED("cursor_4c_BuscaUF")
978:                     USE IN cursor_4c_BuscaUF
979:                 ENDIF
980: 
981:                 loc_cSQL = "SELECT UFIBGEs, Estados, Descrs FROM SigCdUfs ORDER BY UFIBGEs"
982:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUF")
983: 
984:                 IF loc_nResult > 0 AND USED("cursor_4c_BuscaUF") AND RECCOUNT("cursor_4c_BuscaUF") > 0
985:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
986: 
987:                     IF VARTYPE(loc_oBusca) = "O"
988:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUF"
989:                         loc_oBusca.this_cTitulo        = "Selecionar UF no IBGE"
990:                         loc_oBusca.mAddColuna("UFIBGEs", "", "C" + CHR(243) + "d. IBGE")
991:                         loc_oBusca.mAddColuna("Estados", "", "UF")
992:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
993:                         loc_oBusca.Show()
994: 
995:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
996:                             SELECT cursor_4c_BuscaUF
997:                             loc_oPagina.txt_4c_UFIBGES.Value = cursor_4c_BuscaUF.UFIBGEs
998:                         ELSE
999:                             loc_oPagina.txt_4c_UFIBGES.Value = 0
1000:                         ENDIF
1001:                         loc_oBusca.Release()
1002:                     ENDIF
1003:                 ELSE
1004:                     MsgAviso("C" + CHR(243) + "d. UF IBGE n" + CHR(227) + "o encontrado.", "")
1005:                     loc_oPagina.txt_4c_UFIBGES.Value = 0
1006:                 ENDIF
1007:             ENDIF
1008:         CATCH TO loException
1009:             MsgErro(loException.Message + CHR(13) + ;
1010:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1011:                 "Procedure: " + loException.Procedure, ;
1012:                 "FormMun.ValidarUFIBGES")
1013:         ENDTRY
1014: 
1015:         IF USED("cursor_4c_BuscaUF")
1016:             USE IN cursor_4c_BuscaUF
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme o modo atual
1022:     * LISTA: botoes CRUD ativos; INCLUIR/ALTERAR: Confirmar+Cancelar ativos;
1023:     * VISUALIZAR: apenas Cancelar ativo (Confirmar desabilitado)
1024:     *==========================================================================
1025:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1026:         LOCAL loc_oPg1, loc_oPg2, loc_lLista, loc_lEdita, loc_lVisualiza
1027:         loc_oPg1       = THIS.pgf_4c_Paginas.Page1
1028:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
1029:         loc_lLista     = (THIS.this_cModoAtual = "LISTA")
1030:         loc_lEdita     = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1031:         loc_lVisualiza = (THIS.this_cModoAtual = "VISUALIZAR")
1032: 
1033:         *-- Page1: botoes CRUD habilitados apenas em modo LISTA
1034:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1035:             WITH loc_oPg1.cnt_4c_Botoes
1036:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir",    5)
1037:                     .cmd_4c_Incluir.Enabled    = loc_lLista
1038:                 ENDIF
1039:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1040:                     .cmd_4c_Visualizar.Enabled = loc_lLista
1041:                 ENDIF
1042:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar",    5)
1043:                     .cmd_4c_Alterar.Enabled    = loc_lLista
1044:                 ENDIF
1045:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir",    5)
1046:                     .cmd_4c_Excluir.Enabled    = loc_lLista
1047:                 ENDIF
1048:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar",     5)
1049:                     .cmd_4c_Buscar.Enabled     = loc_lLista
1050:                 ENDIF
1051:                 .Visible     = .T.
1052:             ENDWITH
1053:         ENDIF
1054: 
1055:         *-- Page2: Confirmar habilitado so em INCLUIR/ALTERAR; Cancelar sempre ativo em Page2
1056:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1057:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1058:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdita
1059:             ENDIF
1060:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1061:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = (loc_lEdita OR loc_lVisualiza)
1062:             ENDIF
1063:         ENDIF
1064:     ENDPROC
1065: 
1066:     *==========================================================================
1067:     * Destroy - Libera recursos ao fechar o formulario
1068:     *==========================================================================
1069:     PROCEDURE Destroy()
1070:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1071:             THIS.this_oBusinessObject = .NULL.
1072:         ENDIF
1073: 
1074:         IF USED("cursor_4c_Dados")
1075:             USE IN cursor_4c_Dados
1076:         ENDIF
1077: 
1078:         IF USED("cursor_4c_Carrega")
1079:             USE IN cursor_4c_Carrega
1080:         ENDIF
1081: 
1082:         IF USED("cursor_4c_DupMun")
1083:             USE IN cursor_4c_DupMun
1084:         ENDIF
1085: 
1086:         IF USED("cursor_4c_BuscaUF")
1087:             USE IN cursor_4c_BuscaUF
1088:         ENDIF
1089: 
1090:         DODEFAULT()
1091:     ENDPROC
1092: 
1093: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MunBO.prg):
*==============================================================================
* MunBO.prg - Business Object para Cadastro de Municípios
* Tabela: SigCdMun
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS MunBO AS BusinessBase

    *-- Propriedades da tabela SigCdMun
    this_cCidChaves = ""     && cidchaves char(20) - chave interna PK do banco
    this_cCodigos   = ""     && codigos char(7) - código do município (negócio)
    this_cDescs     = ""     && descs char(40) - nome do município
    this_nUFIBGES   = 0      && ufibges numeric(2,0) - código da UF no IBGE

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMun"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodigos   = TratarNulo(codigos,   "C")
            THIS.this_cDescs     = TratarNulo(descs,     "C")
            THIS.this_nUFIBGES   = TratarNulo(ufibges,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os municípios (PUBLIC - chamado pelo Form)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar municípios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega município por código de negócio (codigos)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015) + SYS(2015)
                THIS.this_cCidChaves = LEFT(THIS.this_cCidChaves, 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMun (codigos, descs, ufibges, cidchaves) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUFIBGES)   + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMun SET" + ;
                       " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescs))   + "," + ;
                       " ufibges = " + FormatarNumeroSQL(THIS.this_nUFIBGES)   + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMun (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se código já cadastrado
    * Para INSERT: verifica se codigos existe
    * Para UPDATE: verifica se outro registro tem o mesmo codigos
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        *-- codigos nao pode ser alterado no UPDATE, entao duplicidade so eh possivel em INSERT
        IF !THIS.this_lNovoRegistro
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DupMun")
                TABLEREVERT(.T., "cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupMun")

            IF loc_nResult >= 0
                loc_lResultado = (RECCOUNT("cursor_4c_DupMun") > 0)
            ENDIF

            IF USED("cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ValidarDuplicidade")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

