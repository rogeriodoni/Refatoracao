# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarCodTam' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCodTam(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNQ.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1048 linhas total):

*-- Linhas 30 a 149:
30:     *--------------------------------------------------------------------------
31:     * Init
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *--------------------------------------------------------------------------
38:     * InicializarForm - Configuracao inicial (chamado pelo FormBase.Init)
39:     *--------------------------------------------------------------------------
40:     PROTECTED PROCEDURE InicializarForm()
41:         LOCAL loc_lSucesso
42:         loc_lSucesso = .F.
43: 
44:         TRY
45:             THIS.this_oBusinessObject = CREATEOBJECT("CNQBO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar Business Object CNQBO", "Erro Cr" + CHR(237) + "tico")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.ConfigurarPaginaLista()
52:                 THIS.ConfigurarPaginaDados()
53: 
54:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
55:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 ENDIF
58: 
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 THIS.pgf_4c_Paginas.Visible    = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual           = "LISTA"
66:                 loc_lSucesso = .T.
67:             ENDIF
68: 
69:         CATCH TO loException
70:             MostrarErro("Erro ao inicializar FormCNQ:" + CHR(13) + ;
71:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
72:                 loException.Message, "Erro")
73:             loc_lSucesso = .F.
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - PageFrame principal com 2 paginas
81:     * Legado: Pagina Width=1003, Top=-29 (oculta abas do framework)
82:     *--------------------------------------------------------------------------
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = 1003
90:             .Height    = 629
91:             .PageCount = 2
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e Grid
107:     * Compensacao PageFrame +29 aplicada em todos os controles
108:     *--------------------------------------------------------------------------
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina, loc_oGrid
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
114:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115: 
116:         *-- Container cabecalho (cntSombra original: Top=2 -> 31 com compensacao)
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = 1020
122:             .Height      = 80
123:             .BackStyle   = 0
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .AutoSize  = .F.
139:             .BackStyle = 0
140:             .ForeColor = RGB(0, 0, 0)
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769

*-- Linhas 343 a 402:
343:         loc_oGrid.BackColor          = RGB(255, 255, 255)
344:         loc_oGrid.Visible            = .T.
345: 
346:         *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
347:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
348:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,  "Click", THIS, "BtnVisualizarClick")
349:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
352:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
353: 
354:         THIS.TornarControlesVisiveis(loc_oPagina)
355:     ENDPROC
356: 
357:     *--------------------------------------------------------------------------
358:     * ConfigurarPaginaDados - Page2: campos Conquilha/CodTam/Valor + botoes
359:     * Legado: Get_conquilha(top=147,left=402,w=115), Get_codtam(top=174,left=402,w=59)
360:     *         Get_valor(top=202,left=402,w=59) | Compensacao PageFrame +29 aplicada
361:     *--------------------------------------------------------------------------
362:     PROTECTED PROCEDURE ConfigurarPaginaDados()
363:         LOCAL loc_oPagina
364:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
365: 
366:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
367:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
368: 
369:         *-- Label Conquilha (Say1: top=150+29=179, left=343)
370:         loc_oPagina.AddObject("lbl_4c_Conquilha", "Label")
371:         WITH loc_oPagina.lbl_4c_Conquilha
372:             .Caption   = "Conquilha :"
373:             .Top       = 179
374:             .Left      = 343
375:             .Width     = 57
376:             .Height    = 17
377:             .FontName  = "Tahoma"
378:             .FontSize  = 8
379:             .FontBold  = .F.
380:             .AutoSize  = .F.
381:             .BackStyle = 0
382:             .ForeColor = RGB(90, 90, 90)
383:             .Alignment = 1
384:             .Visible   = .T.
385:         ENDWITH
386: 
387:         *-- TextBox Conquilha (Get_conquilha: top=147+29=176, left=402, width=115)
388:         loc_oPagina.AddObject("txt_4c_Conquilha", "TextBox")
389:         WITH loc_oPagina.txt_4c_Conquilha
390:             .Value        = ""
391:             .Top          = 176
392:             .Left         = 402
393:             .Width        = 115
394:             .Height       = 23
395:             .FontName     = "Tahoma"
396:             .FontSize     = 8
397:             .MaxLength    = 30
398:             .BackColor    = RGB(255, 255, 255)
399:             .ForeColor    = RGB(90, 90, 90)
400:             .Enabled      = .T.
401:             .Visible      = .T.
402:         ENDWITH

*-- Linhas 531 a 590:
531:             .Visible         = .T.
532:         ENDWITH
533: 
534:         *-- BINDEVENTs campos (LostFocus, F4 e DblClick para lookup de Tamanho/Aro)
535:         BINDEVENT(loc_oPagina.txt_4c_CodTam, "KeyPress", THIS, "ValidarCodTam")
536:         BINDEVENT(loc_oPagina.txt_4c_CodTam, "KeyPress",  THIS, "CodTamKeyPress")
537:         BINDEVENT(loc_oPagina.txt_4c_CodTam, "DblClick",  THIS, "CodTamDblClick")
538: 
539:         *-- BINDEVENTs botoes
540:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
541:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
542: 
543:         THIS.TornarControlesVisiveis(loc_oPagina)
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------
547:     * CarregarLista - Carrega registros no grid da Page1
548:     * Aplica this_cFiltroBusca como WHERE clause (vazio = todos)
549:     *--------------------------------------------------------------------------
550:     PROCEDURE CarregarLista()
551:         LOCAL loc_lResultado, loc_oGrid
552:         loc_lResultado = .F.
553: 
554:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
555:             RETURN .T.
556:         ENDIF
557: 
558:         TRY
559:             IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroBusca)
560:                 IF USED("cursor_4c_Dados")
561:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
562: 
563:                     *-- Problema 36/48: RecordSource e ColumnCount FORA de WITH
564:                     loc_oGrid.ColumnCount = 3
565:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
566:                     loc_oGrid.ColumnCount  = 3
567: 
568:                     *-- Problema 32: redefinir Headers APOS RecordSource + ControlSource
569:                     WITH loc_oGrid
570:                         .Column1.ControlSource   = "cursor_4c_Dados.conquilhas"
571:                         .Column1.Width           = 150
572:                         .Column1.Header1.Caption = "Conquilha"
573:                         .Column1.Alignment       = 0
574: 
575:                         .Column2.ControlSource   = "cursor_4c_Dados.codtams"
576:                         .Column2.Width           = 100
577:                         .Column2.Header1.Caption = "Aro"
578:                         .Column2.Alignment       = 1
579: 
580:                         .Column3.ControlSource   = "cursor_4c_Dados.valors"
581:                         .Column3.Width           = 100
582:                         .Column3.Header1.Caption = "Valor"
583:                         .Column3.Alignment       = 1
584:                     ENDWITH
585: 
586:                     THIS.FormatarGridLista(loc_oGrid)
587:                     loc_oGrid.Refresh()
588:                 ENDIF
589:                 loc_lResultado = .T.
590:             ENDIF

*-- Linhas 599 a 1048:
599:     *--------------------------------------------------------------------------
600:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
601:     *--------------------------------------------------------------------------
602:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
603:         LOCAL loc_lResultado
604:         loc_lResultado = .F.
605: 
606:         TRY
607:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
608:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
609: 
610:                 IF par_nPagina = 1
611:                     THIS.this_cModoAtual = "LISTA"
612:                     THIS.CarregarLista()
613:                 ENDIF
614: 
615:                 loc_lResultado = .T.
616:             ENDIF
617:         CATCH TO loException
618:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "FormCNQ.AlternarPagina")
619:             loc_lResultado = .F.
620:         ENDTRY
621: 
622:         RETURN loc_lResultado
623:     ENDPROC
624: 
625:     *--------------------------------------------------------------------------
626:     * BtnIncluirClick - Incluir novo registro
627:     *--------------------------------------------------------------------------
628:     PROCEDURE BtnIncluirClick()
629:         THIS.this_oBusinessObject.NovoRegistro()
630:         THIS.LimparCampos()
631:         THIS.this_cModoAtual = "INCLUIR"
632:         THIS.HabilitarCampos(.T.)
633:         THIS.AjustarBotoesPorModo()
634:         THIS.pgf_4c_Paginas.ActivePage = 2
635: 
636:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Conquilha", 5)
637:             THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.SetFocus()
638:         ENDIF
639:     ENDPROC
640: 
641:     *--------------------------------------------------------------------------
642:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
643:     *--------------------------------------------------------------------------
644:     PROCEDURE BtnVisualizarClick()
645:         LOCAL loc_cPK
646:         loc_cPK = ""
647: 
648:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
649:             SELECT cursor_4c_Dados
650:             loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
651:         ENDIF
652: 
653:         IF EMPTY(STRTRAN(loc_cPK, "|", ""))
654:             MsgAviso("Selecione um registro na lista.")
655:             RETURN
656:         ENDIF
657: 
658:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
659:             THIS.BOParaForm()
660:             THIS.this_cPkSelecionado = loc_cPK
661:             THIS.this_cModoAtual     = "VISUALIZAR"
662:             THIS.HabilitarCampos(.F.)
663:             THIS.AjustarBotoesPorModo()
664:             THIS.pgf_4c_Paginas.ActivePage = 2
665:         ENDIF
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * BtnAlterarClick - Alterar registro selecionado
670:     *--------------------------------------------------------------------------
671:     PROCEDURE BtnAlterarClick()
672:         LOCAL loc_cPK
673:         loc_cPK = ""
674: 
675:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
676:             SELECT cursor_4c_Dados
677:             loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
678:         ENDIF
679: 
680:         IF EMPTY(STRTRAN(loc_cPK, "|", ""))
681:             MsgAviso("Selecione um registro na lista.")
682:             RETURN
683:         ENDIF
684: 
685:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
686:             THIS.this_oBusinessObject.EditarRegistro()
687:             THIS.BOParaForm()
688:             THIS.this_cPkSelecionado = loc_cPK
689:             THIS.this_cModoAtual     = "ALTERAR"
690:             THIS.HabilitarCampos(.T.)
691:             THIS.AjustarBotoesPorModo()
692:             THIS.pgf_4c_Paginas.ActivePage = 2
693:         ENDIF
694:     ENDPROC
695: 
696:     *--------------------------------------------------------------------------
697:     * BtnExcluirClick - Excluir registro selecionado
698:     *--------------------------------------------------------------------------
699:     PROCEDURE BtnExcluirClick()
700:         LOCAL loc_cPK, loc_lConfirma
701:         loc_cPK = ""
702: 
703:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
704:             SELECT cursor_4c_Dados
705:             loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
706:         ENDIF
707: 
708:         IF EMPTY(STRTRAN(loc_cPK, "|", ""))
709:             MsgAviso("Selecione um registro na lista.")
710:             RETURN
711:         ENDIF
712: 
713:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
714:                                      "Confirmar Exclus" + CHR(227) + "o")
715:         IF !loc_lConfirma
716:             RETURN
717:         ENDIF
718: 
719:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
720:             IF THIS.this_oBusinessObject.Excluir()
721:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
722:                 THIS.this_cFiltroBusca = ""
723:                 THIS.CarregarLista()
724:             ENDIF
725:         ENDIF
726:     ENDPROC
727: 
728:     *--------------------------------------------------------------------------
729:     * BtnBuscarClick - Buscar/filtrar registros por conquilha
730:     *--------------------------------------------------------------------------
731:     PROCEDURE BtnBuscarClick()
732:         LOCAL loc_cConquilha, loc_cFiltro
733:         loc_cConquilha = INPUTBOX("Informe a conquilha para buscar (vazio = todos):", ;
734:                                    "Buscar Conquilha", "")
735: 
736:         IF EMPTY(ALLTRIM(loc_cConquilha))
737:             loc_cFiltro = ""
738:         ELSE
739:             loc_cFiltro = "conquilhas LIKE " + EscaparSQL("%" + ALLTRIM(loc_cConquilha) + "%")
740:         ENDIF
741: 
742:         THIS.this_cFiltroBusca = loc_cFiltro
743:         THIS.CarregarLista()
744:     ENDPROC
745: 
746:     *--------------------------------------------------------------------------
747:     * BtnEncerrarClick - Fechar formulario
748:     *--------------------------------------------------------------------------
749:     PROCEDURE BtnEncerrarClick()
750:         THIS.Release()
751:     ENDPROC
752: 
753:     *--------------------------------------------------------------------------
754:     * BtnSalvarClick - Salvar alteracoes (chamado por cmd_4c_Confirmar)
755:     *--------------------------------------------------------------------------
756:     PROCEDURE BtnSalvarClick()
757:         LOCAL loc_lSucesso
758:         loc_lSucesso = .F.
759: 
760:         *-- Validar campos obrigatorios ANTES do TRY (RETURN fora do TRY - regra #1)
761:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Conquilha", 5)
762:             IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.Value))
763:                 MsgAviso("Obrigat" + CHR(243) + "rio informar a Conquilha.")
764:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.SetFocus()
765:                 RETURN .F.
766:             ENDIF
767:         ENDIF
768: 
769:         TRY
770:             THIS.FormParaBO()
771: 
772:             IF THIS.this_oBusinessObject.Salvar()
773:                 MsgInfo("Registro salvo com sucesso!")
774:                 THIS.this_cModoAtual   = "LISTA"
775:                 THIS.this_cFiltroBusca = ""
776:                 THIS.AlternarPagina(1)
777:                 loc_lSucesso = .T.
778:             ENDIF
779: 
780:         CATCH TO loException
781:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormCNQ.BtnSalvarClick")
782:             loc_lSucesso = .F.
783:         ENDTRY
784: 
785:         RETURN loc_lSucesso
786:     ENDPROC
787: 
788:     *--------------------------------------------------------------------------
789:     * BtnCancelarClick - Cancelar e voltar para lista
790:     *--------------------------------------------------------------------------
791:     PROCEDURE BtnCancelarClick()
792:         THIS.this_cModoAtual = "LISTA"
793:         THIS.AlternarPagina(1)
794:     ENDPROC
795: 
796:     *--------------------------------------------------------------------------
797:     * FormParaBO - Transfere dados do Form para o BO
798:     *--------------------------------------------------------------------------
799:     PROTECTED PROCEDURE FormParaBO()
800:         LOCAL loc_oPg2
801:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
802: 
803:         IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
804:             THIS.this_oBusinessObject.this_cConquilha = ALLTRIM(loc_oPg2.txt_4c_Conquilha.Value)
805:         ENDIF
806: 
807:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
808:             THIS.this_oBusinessObject.this_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
809:         ENDIF
810: 
811:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
812:             THIS.this_oBusinessObject.this_nValor = loc_oPg2.txt_4c_Valor.Value
813:         ENDIF
814:     ENDPROC
815: 
816:     *--------------------------------------------------------------------------
817:     * BOParaForm - Transfere dados do BO para o Form
818:     *--------------------------------------------------------------------------
819:     PROTECTED PROCEDURE BOParaForm()
820:         LOCAL loc_oPg2
821:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
822: 
823:         IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
824:             loc_oPg2.txt_4c_Conquilha.Value = THIS.this_oBusinessObject.this_cConquilha
825:         ENDIF
826: 
827:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
828:             loc_oPg2.txt_4c_CodTam.Value = THIS.this_oBusinessObject.this_cCodTam
829:         ENDIF
830: 
831:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
832:             loc_oPg2.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValor
833:         ENDIF
834:     ENDPROC
835: 
836:     *--------------------------------------------------------------------------
837:     * LimparCampos - Limpa valores dos campos do formulario (Page2)
838:     *--------------------------------------------------------------------------
839:     PROTECTED PROCEDURE LimparCampos()
840:         LOCAL loc_oPg2
841:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
842: 
843:         IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
844:             loc_oPg2.txt_4c_Conquilha.Value = ""
845:         ENDIF
846: 
847:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
848:             loc_oPg2.txt_4c_CodTam.Value = ""
849:         ENDIF
850: 
851:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
852:             loc_oPg2.txt_4c_Valor.Value = 0
853:         ENDIF
854:     ENDPROC
855: 
856:     *--------------------------------------------------------------------------
857:     * HabilitarCampos - Habilita ou desabilita campos de edicao (Page2)
858:     *--------------------------------------------------------------------------
859:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
860:         LOCAL loc_oPg2
861:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
862: 
863:         *-- Conquilha e CodTam: editaveis apenas no INCLUIR (chave de negocio nao muda)
864:         IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
865:             loc_oPg2.txt_4c_Conquilha.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
866:         ENDIF
867: 
868:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
869:             loc_oPg2.txt_4c_CodTam.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
870:         ENDIF
871: 
872:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
873:             loc_oPg2.txt_4c_Valor.Enabled = par_lHabilitar
874:         ENDIF
875: 
876:         *-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
877:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
878:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
879:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
880:             ENDIF
881:         ENDIF
882:     ENDPROC
883: 
884:     *--------------------------------------------------------------------------
885:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme o modo atual
886:     *--------------------------------------------------------------------------
887:     PROTECTED PROCEDURE AjustarBotoesPorModo()
888:         LOCAL loc_oPg1, loc_lNaLista
889:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
890:         loc_lNaLista = (THIS.this_cModoAtual = "LISTA")
891: 
892:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
893:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
894:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lNaLista
895:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lNaLista
896:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lNaLista
897:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lNaLista
898:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lNaLista
899:             ENDIF
900:         ENDIF
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------
904:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
905:     * Obrigatorio: percorre Pages de PageFrames E Controls de Containers
906:     *--------------------------------------------------------------------------
907:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
908:         LOCAL loc_nI, loc_oObjeto, loc_nP
909: 
910:         FOR loc_nI = 1 TO par_oContainer.ControlCount
911:             loc_oObjeto = par_oContainer.Controls(loc_nI)
912: 
913:             IF VARTYPE(loc_oObjeto) = "O"
914:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
915:                     loc_oObjeto.Visible = .T.
916:                 ENDIF
917: 
918:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
919:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
920:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
921:                     ENDFOR
922:                 ENDIF
923: 
924:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
925:                     THIS.TornarControlesVisiveis(loc_oObjeto)
926:                 ENDIF
927:             ENDIF
928:         ENDFOR
929:     ENDPROC
930: 
931:     *--------------------------------------------------------------------------
932:     * FormatarGridLista - Aplica formatacao visual padrao no grid da lista
933:     *--------------------------------------------------------------------------
934:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
935:         TRY
936:             WITH par_oGrid
937:                 .FontName = "Tahoma"
938:                 .FontSize = 8
939:             ENDWITH
940:         CATCH TO loException
941:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "FormCNQ.FormatarGridLista")
942:         ENDTRY
943:     ENDPROC
944: 
945:     *--------------------------------------------------------------------------
946:     * ValidarCodTam - LostFocus: aciona lookup apenas se valor nao vazio
947:     * Legado: Get_codtam.Valid usava fwBuscaExt em SigCdTam (cods/descs)
948:     *--------------------------------------------------------------------------
949:     PROCEDURE ValidarCodTam(par_nKeyCode, par_nShiftAltCtrl)
950:         LOCAL loc_oPg2, loc_cCodTam
951:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
952:         loc_cCodTam = ""
953: 
954:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
955:             loc_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
956:         ENDIF
957: 
958:         IF !EMPTY(loc_cCodTam)
959:             THIS.AbrirLookupCodTam()
960:         ENDIF
961:     ENDPROC
962: 
963:     *--------------------------------------------------------------------------
964:     * CodTamKeyPress - Handler de KeyPress: abre lookup ao pressionar F4 (28)
965:     *--------------------------------------------------------------------------
966:     PROCEDURE CodTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
967:         IF par_nKeyCode = 28
968:             THIS.AbrirLookupCodTam()
969:         ENDIF
970:     ENDPROC
971: 
972:     *--------------------------------------------------------------------------
973:     * CodTamDblClick - Handler de DblClick: abre lookup de Tamanho/Aro
974:     *--------------------------------------------------------------------------
975:     PROCEDURE CodTamDblClick()
976:         THIS.AbrirLookupCodTam()
977:     ENDPROC
978: 
979:     *--------------------------------------------------------------------------
980:     * AbrirLookupCodTam - Lookup em SigCdTam (cods/descs) via FormBuscaAuxiliar
981:     * Campo vazio: exibe lista completa. Nao-vazio: tenta exato primeiro.
982:     *--------------------------------------------------------------------------
983:     PROCEDURE AbrirLookupCodTam()
984:         LOCAL loc_oPg2, loc_cCodTam, loc_oBusca
985:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
986:         loc_cCodTam = ""
987: 
988:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
989:             IF !loc_oPg2.txt_4c_CodTam.Enabled
990:                 RETURN
991:             ENDIF
992:             loc_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
993:         ENDIF
994: 
995:         TRY
996:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
997:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cCodTam, ;
998:                 "Selecionar Tamanho (Aro)")
999: 
1000:             IF VARTYPE(loc_oBusca) = "O"
1001:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1002:                     *-- Registro exato encontrado e selecionado automaticamente
1003:                     IF USED("cursor_4c_BuscaTam") AND PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
1004:                         loc_oPg2.txt_4c_CodTam.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
1005:                     ENDIF
1006:                 ELSE
1007:                     *-- Nao encontrou exato (ou campo vazio): mostrar grid para selecao
1008:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d Tam")
1009:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1010:                     loc_oBusca.Show()
1011:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
1012:                         IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
1013:                             loc_oPg2.txt_4c_CodTam.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
1014:                         ENDIF
1015:                     ENDIF
1016:                 ENDIF
1017:                 loc_oBusca.Release()
1018:             ENDIF
1019: 
1020:         CATCH TO loException
1021:             MostrarErro("Erro ao abrir lookup Tamanho:" + CHR(13) + loException.Message, "FormCNQ.AbrirLookupCodTam")
1022:         ENDTRY
1023: 
1024:         IF USED("cursor_4c_BuscaTam")
1025:             USE IN cursor_4c_BuscaTam
1026:         ENDIF
1027:     ENDPROC
1028: 
1029:     *--------------------------------------------------------------------------
1030:     * Destroy - Libera recursos do formulario
1031:     *--------------------------------------------------------------------------
1032:     PROCEDURE Destroy()
1033:         TRY
1034:             IF USED("cursor_4c_Dados")
1035:                 USE IN cursor_4c_Dados
1036:             ENDIF
1037: 
1038:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1039:                 THIS.this_oBusinessObject = .NULL.
1040:             ENDIF
1041:         CATCH TO loException
1042:             MostrarErro("Erro ao destruir FormCNQ:" + CHR(13) + loException.Message, "FormCNQ.Destroy")
1043:         ENDTRY
1044: 
1045:         DODEFAULT()
1046:     ENDPROC
1047: 
1048: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CNQBO.prg):
*==============================================================================
* CNQBO.prg - Business Object para Conquilhas (CNQ)
* Tabela: SigCdCnq | PK: conquilhas+codtams (chave composta de negocio)
* Schema: codtams char(4), conquilhas char(10), valors numeric(6,3)
*==============================================================================

DEFINE CLASS CNQBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCnq)
    this_cConquilha = ""    && Conquilhas CHAR(10)     - Conquilha
    this_cCodTam    = ""    && Codtams    CHAR(4)      - Codigo Tamanho (Aro) FK->SigCdTam.cods
    this_nValor     = 0     && Valors     NUMERIC(6,3) - Valor

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnq"
        THIS.this_cCampoChave = "conquilhas"
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
                THIS.this_cConquilha = TratarNulo(Conquilhas, "C")
                THIS.this_cCodTam    = TratarNulo(Codtams,    "C")
                THIS.this_nValor     = TratarNulo(Valors,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CNQBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica conquilha + codtam duplicados no INSERT
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nRes, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdCnq" + ;
                       " WHERE conquilhas = " + EscaparSQL(THIS.this_cConquilha) + ;
                       " AND codtams = " + EscaparSQL(THIS.this_cCodTam)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "CNQBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cConquilha))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conquilha.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Conquilha j" + CHR(225) + " cadastrada para este tamanho (Aro).")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnq (conquilhas, codtams, valors)
                VALUES (
                    <<EscaparSQL(THIS.this_cConquilha)>>,
                    <<EscaparSQL(THIS.this_cCodTam)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CNQBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnq
                SET valors = <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                WHERE conquilhas = <<EscaparSQL(THIS.this_cConquilha)>>
                AND codtams = <<EscaparSQL(THIS.this_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CNQBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCnq
                WHERE conquilhas = <<EscaparSQL(THIS.this_cConquilha)>>
                AND codtams = <<EscaparSQL(THIS.this_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CNQBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com conquilhas, codtams, valors
    * Ordenado por conquilhas (ordem original do legado)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (conquilhas C(10), codtams C(4), valors N(6,3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT conquilhas, codtams, valors FROM SigCdCnq"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY conquilhas"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CNQBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave composta "conquilhas|codtams"
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChaveComposta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConquilha, loc_cCodTam, loc_nSep
        loc_lSucesso = .F.

        TRY
            loc_nSep      = AT("|", par_cChaveComposta)
            loc_cConquilha = ALLTRIM(LEFT(par_cChaveComposta, loc_nSep - 1))
            loc_cCodTam    = ALLTRIM(SUBSTR(par_cChaveComposta, loc_nSep + 1))

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT conquilhas, codtams, valors
                FROM SigCdCnq
                WHERE conquilhas = <<EscaparSQL(loc_cConquilha)>>
                AND codtams = <<EscaparSQL(loc_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Conquilha n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CNQBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cConquilha) + "|" + ALLTRIM(THIS.this_cCodTam)
    ENDFUNC

ENDDEFINE

