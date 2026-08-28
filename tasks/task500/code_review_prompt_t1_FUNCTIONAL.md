# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarProduto' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarProduto(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPMC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1327 linhas total):

*-- Linhas 28 a 159:
28:     *==========================================================================
29:     * Init
30:     *==========================================================================
31:     PROCEDURE Init()
32:         LOCAL loc_lResultado
33:         loc_lResultado = .F.
34:         TRY
35:             loc_lResultado = DODEFAULT()
36:         CATCH TO loc_oErro
37:             MsgErro("Erro em FormPMC.Init:" + CHR(13) + loc_oErro.Message, "Erro")
38:         ENDTRY
39:         RETURN loc_lResultado
40:     ENDPROC
41: 
42:     *==========================================================================
43:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
44:     *==========================================================================
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lResultado, loc_oCab
47:         loc_lResultado = .F.
48: 
49:         TRY
50:             THIS.Caption = "Tabela de promo" + CHR(231) + CHR(245) + "es por per" + CHR(237) + "odo"
51: 
52:             THIS.this_oBusinessObject = CREATEOBJECT("PMCBO")
53: 
54:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
55:                 MsgErro("Erro ao criar PMCBO!" + CHR(13) + ;
56:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.ConfigurarPaginaLista()
60:                 THIS.ConfigurarPaginaDados()
61: 
62:                 *-- Propagar caption para labels de titulo da Page1
63:                 loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
64:                 IF VARTYPE(loc_oCab) = "O"
65:                     IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
66:                         loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
67:                     ENDIF
68:                     IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
69:                         loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
70:                     ENDIF
71:                 ENDIF
72: 
73:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
74:                     THIS.CarregarLista()
75:                 ENDIF
76: 
77:                 THIS.pgf_4c_Paginas.Visible   = .T.
78:                 THIS.pgf_4c_Paginas.ActivePage = 1
79:                 THIS.this_cModoAtual = "LISTA"
80:                 loc_lResultado = .T.
81:             ENDIF
82: 
83:         CATCH TO loc_oErro
84:             MsgErro("Erro em FormPMC.InicializarForm:" + CHR(13) + ;
85:                     loc_oErro.Message + CHR(13) + ;
86:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
87:                     "Procedure: " + loc_oErro.Procedure, "Erro")
88:         ENDTRY
89: 
90:         RETURN loc_lResultado
91:     ENDPROC
92: 
93:     *==========================================================================
94:     * ConfigurarPageFrame - Cria pgf_4c_Paginas com Page1 (Lista) e Page2 (Dados)
95:     * PageFrame.Top = -29 esconde abas; controles dentro das Pages compensam +29px
96:     *==========================================================================
97:     PROTECTED PROCEDURE ConfigurarPageFrame()
98:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
99:         WITH THIS.pgf_4c_Paginas
100:             .Top       = -29
101:             .Left      = 0
102:             .Width     = THIS.Width
103:             .Height    = THIS.Height + 29
104:             .PageCount = 2
105:             .Tabs      = .F.
106:             .Page1.Caption = "Lista"
107:             .Page2.Caption = "Dados"
108:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:             .Visible   = .T.
111:         ENDWITH
112:     ENDPROC
113: 
114:     *==========================================================================
115:     * ConfigurarPaginaLista - Page1: Cabecalho + containers botoes + Saida
116:     * Legado: cntSombra.Top=1, Grupo_op.Left=538 Top=-1, Grupo_Saida.Left=918 Top=-1
117:     * Compensacao +29px em todos os controles (PageFrame.Top=-29)
118:     *==========================================================================
119:     PROTECTED PROCEDURE ConfigurarPaginaLista()
120:         LOCAL loc_oPagina
121:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
122: 
123:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
124:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125: 
126:         *-- Cabecalho escuro com titulo (cntSombra: Top=1+29=30, Left=0)
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 30
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136: 
137:             .AddObject("lbl_4c_Sombra", "Label")
138:             WITH .lbl_4c_Sombra
139:                 .Caption   = THIS.Caption
140:                 .Top       = 15
141:                 .Left      = 10
142:                 .Width     = THIS.Width
143:                 .Height    = 40
144:                 .FontName  = "Tahoma"
145:                 .FontSize  = 16
146:                 .FontBold  = .T.
147:                 .ForeColor = RGB(0, 0, 0)
148:                 .BackStyle = 0
149:                 .Visible   = .T.
150:             ENDWITH
151: 
152:             .AddObject("lbl_4c_Titulo", "Label")
153:             WITH .lbl_4c_Titulo
154:                 .Caption   = THIS.Caption
155:                 .Top       = 18
156:                 .Left      = 10
157:                 .Width     = THIS.Width
158:                 .Height    = 46
159:                 .FontName  = "Tahoma"

*-- Linhas 377 a 436:
377:             .Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
378:         ENDWITH
379: 
380:         *-- BINDEVENTs botoes Page1 (handlers PUBLIC para funcionar com BINDEVENT)
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
386:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
387: 
388:         THIS.TornarControlesVisiveis(loc_oPagina)
389:     ENDPROC
390: 
391:     *==========================================================================
392:     * ConfigurarPaginaDados - Page2: Container BotoesAcao
393:     * Legado: Grupo_Salva.Left=819, Top=9 -> +29 compensacao = Top=38
394:     * TextBoxes/Labels adicionados nas Fases 5-6
395:     *==========================================================================
396:     PROTECTED PROCEDURE ConfigurarPaginaDados()
397:         LOCAL loc_oPagina
398:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
399: 
400:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
401:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
402: 
403:         *-- Container botoes Salvar/Cancelar (Grupo_Salva: Left=819, Top=9+29=38)
404:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
405:         WITH loc_oPagina.cnt_4c_BotoesAcao
406:             .Top         = 38
407:             .Left        = 819
408:             .Width       = 160
409:             .Height      = 85
410:             .BackStyle   = 0
411:             .BorderWidth = 0
412:             .Visible     = .T.
413: 
414:             .AddObject("cmd_4c_Confirmar", "CommandButton")
415:             WITH .cmd_4c_Confirmar
416:                 .Caption         = "Confirmar"
417:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
418:                 .PicturePosition = 13
419:                 .Top             = 5
420:                 .Left            = 5
421:                 .Width           = 75
422:                 .Height          = 75
423:                 .BackColor       = RGB(255, 255, 255)
424:                 .ForeColor       = RGB(90, 90, 90)
425:                 .FontName        = "Comic Sans MS"
426:                 .FontSize        = 8
427:                 .FontBold        = .T.
428:                 .FontItalic      = .T.
429:                 .SpecialEffect   = 0
430:                 .MousePointer    = 15
431:                 .WordWrap        = .T.
432:                 .AutoSize        = .F.
433:                 .Visible         = .T.
434:             ENDWITH
435: 
436:             .AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 638 a 1327:
638:             .Visible       = .T.
639:         ENDWITH
640: 
641:         *-- BINDEVENTs txt_4c_Cpros: F4/DblClick abre busca, LostFocus valida
642:         BINDEVENT(loc_oPagina.txt_4c_Cpros, "KeyPress",  THIS, "TeclaTxtCpros")
643:         BINDEVENT(loc_oPagina.txt_4c_Cpros, "DblClick",  THIS, "AbrirBuscaProduto")
644:         BINDEVENT(loc_oPagina.txt_4c_Cpros, "KeyPress", THIS, "ValidarProduto")
645: 
646:         *-- BINDEVENTs botoes Page2
647:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
648:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
649: 
650:         THIS.TornarControlesVisiveis(loc_oPagina)
651:     ENDPROC
652: 
653:     *==========================================================================
654:     * CarregarLista - Busca registros e atualiza grid Page1
655:     * Grid (grd_4c_Lista) configurado na Fase 4
656:     *==========================================================================
657:     PROCEDURE CarregarLista()
658:         LOCAL loc_lResultado, loc_oGrid
659:         loc_lResultado = .F.
660: 
661:         TRY
662:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
663:                 loc_lResultado = .T.
664:             ELSE
665:                 IF !THIS.this_oBusinessObject.Buscar("")
666:                     loc_lResultado = .F.
667:                 ELSE
668:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
669:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
670:                         loc_oGrid.ColumnCount = 8
671:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
672:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
673:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
674:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
675:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
676:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
677:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
678:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
679:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
680:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
681:                         loc_oGrid.Column2.Header1.Caption = "Produto"
682:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
683:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
684:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
685:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
686:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
687:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
688:                         THIS.FormatarGridLista(loc_oGrid)
689:                     ENDIF
690:                     loc_lResultado = .T.
691:                 ENDIF
692:             ENDIF
693:         CATCH TO loc_oErro
694:             MsgErro("Erro em FormPMC.CarregarLista:" + CHR(13) + loc_oErro.Message + ;
695:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
696:             loc_lResultado = .F.
697:         ENDTRY
698: 
699:         RETURN loc_lResultado
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
704:     *==========================================================================
705:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
706:         LOCAL loc_lResultado
707:         loc_lResultado = .F.
708: 
709:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
710:             RETURN .F.
711:         ENDIF
712: 
713:         TRY
714:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
715: 
716:             IF par_nPagina = 1
717:                 THIS.this_cModoAtual = "LISTA"
718:                 THIS.CarregarLista()
719:             ENDIF
720: 
721:             loc_lResultado = .T.
722:         CATCH TO loc_oErro
723:             MsgErro("Erro em FormPMC.AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
724:             loc_lResultado = .F.
725:         ENDTRY
726: 
727:         RETURN loc_lResultado
728:     ENDPROC
729: 
730:     *==========================================================================
731:     * Destroy
732:     *==========================================================================
733:     PROCEDURE Destroy()
734:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
735:             THIS.this_oBusinessObject = .NULL.
736:         ENDIF
737:         IF USED("cursor_4c_Dados")
738:             USE IN cursor_4c_Dados
739:         ENDIF
740:         DODEFAULT()
741:     ENDPROC
742: 
743:     *==========================================================================
744:     * TornarControlesVisiveis - Torna controles do container visiveis recursivamente
745:     *==========================================================================
746:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
747:         LOCAL loc_nI, loc_oObjeto, loc_nP
748: 
749:         IF VARTYPE(par_oContainer) != "O"
750:             RETURN
751:         ENDIF
752: 
753:         FOR loc_nI = 1 TO par_oContainer.ControlCount
754:             loc_oObjeto = par_oContainer.Controls(loc_nI)
755: 
756:             IF VARTYPE(loc_oObjeto) = "O"
757:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
758:                     loc_oObjeto.Visible = .T.
759:                 ENDIF
760: 
761:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
762:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
763:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
764:                     ENDFOR
765:                 ENDIF
766: 
767:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
768:                     THIS.TornarControlesVisiveis(loc_oObjeto)
769:                 ENDIF
770:             ENDIF
771:         ENDFOR
772:     ENDPROC
773: 
774:     *==========================================================================
775:     * FormatarGridLista - Formata fonte do grid de listagem
776:     *==========================================================================
777:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
778:         IF VARTYPE(par_oGrid) != "O"
779:             RETURN
780:         ENDIF
781:         WITH par_oGrid
782:             .FontName = "Tahoma"
783:             .FontSize = 8
784:         ENDWITH
785:     ENDPROC
786: 
787:     *==========================================================================
788:     * BtnIncluirClick - Inicia inclusao de novo registro
789:     *==========================================================================
790:     PROCEDURE BtnIncluirClick()
791:         THIS.this_oBusinessObject.NovoRegistro()
792:         THIS.LimparCampos()
793:         THIS.this_cModoAtual    = "INCLUIR"
794:         THIS.this_cPkChaveAtual = ""
795:         THIS.HabilitarCampos(.T.)
796:         THIS.AjustarBotoesPorModo()
797:         THIS.AlternarPagina(2)
798:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Cpros", 5)
799:             THIS.pgf_4c_Paginas.Page2.txt_4c_Cpros.SetFocus
800:         ENDIF
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
805:     *==========================================================================
806:     PROCEDURE BtnVisualizarClick()
807:         LOCAL loc_cCodigo
808:         loc_cCodigo = ""
809: 
810:         TRY
811:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
812:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
813:             ELSE
814:                 SELECT cursor_4c_Dados
815:                 IF EOF("cursor_4c_Dados")
816:                     MsgAviso("Selecione um registro na lista.", "Visualizar")
817:                 ELSE
818:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
819:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
820:                         THIS.this_cModoAtual    = "VISUALIZAR"
821:                         THIS.this_cPkChaveAtual = loc_cCodigo
822:                         THIS.BOParaForm()
823:                         THIS.HabilitarCampos(.F.)
824:                         THIS.AjustarBotoesPorModo()
825:                         THIS.AlternarPagina(2)
826:                     ELSE
827:                         MsgErro("Erro ao carregar registro!", "Visualizar")
828:                     ENDIF
829:                 ENDIF
830:             ENDIF
831:         CATCH TO loc_oErro
832:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message, "Erro")
833:         ENDTRY
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * BtnAlterarClick - Abre registro selecionado para edicao
838:     *==========================================================================
839:     PROCEDURE BtnAlterarClick()
840:         LOCAL loc_cCodigo
841:         loc_cCodigo = ""
842: 
843:         TRY
844:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
845:                 MsgAviso("Selecione um registro na lista.", "Alterar")
846:             ELSE
847:                 SELECT cursor_4c_Dados
848:                 IF EOF("cursor_4c_Dados")
849:                     MsgAviso("Selecione um registro na lista.", "Alterar")
850:                 ELSE
851:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
852:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
853:                         THIS.this_oBusinessObject.EditarRegistro()
854:                         THIS.this_cModoAtual    = "ALTERAR"
855:                         THIS.this_cPkChaveAtual = loc_cCodigo
856:                         THIS.BOParaForm()
857:                         THIS.HabilitarCampos(.T.)
858:                         THIS.AjustarBotoesPorModo()
859:                         THIS.AlternarPagina(2)
860:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmin", 5)
861:                             THIS.pgf_4c_Paginas.Page2.txt_4c_Valmin.SetFocus
862:                         ENDIF
863:                     ELSE
864:                         MsgErro("Erro ao carregar registro!", "Alterar")
865:                     ENDIF
866:                 ENDIF
867:             ENDIF
868:         CATCH TO loc_oErro
869:             MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message, "Erro")
870:         ENDTRY
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
875:     *==========================================================================
876:     PROCEDURE BtnExcluirClick()
877:         LOCAL loc_cCodigo
878:         loc_cCodigo = ""
879: 
880:         TRY
881:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
882:                 MsgAviso("Selecione um registro na lista.", "Excluir")
883:             ELSE
884:                 SELECT cursor_4c_Dados
885:                 IF EOF("cursor_4c_Dados")
886:                     MsgAviso("Selecione um registro na lista.", "Excluir")
887:                 ELSE
888:                     loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
889:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
890:                                    "Confirmar Exclus" + CHR(227) + "o")
891:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
892:                             IF THIS.this_oBusinessObject.Excluir()
893:                                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
894:                                         "Exclu" + CHR(237) + "do")
895:                                 THIS.CarregarLista()
896:                             ELSE
897:                                 MsgErro("Erro ao excluir registro!", "Excluir")
898:                             ENDIF
899:                         ELSE
900:                             MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Excluir")
901:                         ENDIF
902:                     ENDIF
903:                 ENDIF
904:             ENDIF
905:         CATCH TO loc_oErro
906:             MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
907:         ENDTRY
908:     ENDPROC
909: 
910:     *==========================================================================
911:     * BtnBuscarClick - Filtra registros no grid por codigo de produto
912:     * Legado: Procedure fazia LocateCursor('crSigCdPmc','cpros',valor)
913:     *==========================================================================
914:     PROCEDURE BtnBuscarClick()
915:         LOCAL loc_cFiltro, loc_cTermoBusca, loc_oGrid
916:         loc_cTermoBusca = INPUTBOX("C" + CHR(243) + "digo ou parte do produto:", ;
917:                                    "Buscar promo" + CHR(231) + CHR(245) + "es", "")
918: 
919:         TRY
920:             IF !EMPTY(ALLTRIM(loc_cTermoBusca))
921:                 loc_cFiltro = "cpros LIKE " + EscaparSQL(ALLTRIM(loc_cTermoBusca) + "%")
922:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
923:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
924:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
925:                         loc_oGrid.ColumnCount = 8
926:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
927:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
928:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
929:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
930:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
931:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
932:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
933:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
934:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
935:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
936:                         loc_oGrid.Column2.Header1.Caption = "Produto"
937:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
938:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
939:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
940:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
941:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
942:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
943:                         THIS.FormatarGridLista(loc_oGrid)
944:                     ENDIF
945:                 ENDIF
946:             ELSE
947:                 THIS.CarregarLista()
948:             ENDIF
949:         CATCH TO loc_oErro
950:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
951:         ENDTRY
952:     ENDPROC
953: 
954:     *==========================================================================
955:     * BtnEncerrarClick - Fecha o formulario
956:     *==========================================================================
957:     PROCEDURE BtnEncerrarClick()
958:         THIS.Release()
959:     ENDPROC
960: 
961:     *==========================================================================
962:     * BtnSalvarClick - Valida e salva o registro (Page2 -> BO -> banco)
963:     * Legado: valida cpros/dtini/dtfin obrigatorios (so em INSERIR)
964:     *         PMCBO.ValidarPeriodo() tambem verifica sobreposicao de periodo
965:     *==========================================================================
966:     PROCEDURE BtnSalvarClick()
967:         LOCAL loc_lResultado, loc_oPg2, loc_cMsgVal
968:         loc_lResultado = .F.
969:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
970: 
971:         *-- Validacoes FORA do TRY para permitir RETURN
972:         IF THIS.this_cModoAtual = "INCLUIR"
973:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Cpros.Value))
974:                 MsgAviso("Produto n" + CHR(227) + "o pode ficar em branco!", ;
975:                           "Aten" + CHR(231) + CHR(227) + "o")
976:                 loc_oPg2.txt_4c_Cpros.SetFocus
977:                 RETURN
978:             ENDIF
979:             IF EMPTY(loc_oPg2.txt_4c_Dtini.Value)
980:                 MsgAviso("Data Inicial n" + CHR(227) + "o pode ficar em branco!", ;
981:                           "Aten" + CHR(231) + CHR(227) + "o")
982:                 loc_oPg2.txt_4c_Dtini.SetFocus
983:                 RETURN
984:             ENDIF
985:             IF EMPTY(loc_oPg2.txt_4c_Dtfin.Value)
986:                 MsgAviso("Data final n" + CHR(227) + "o pode ficar em branco!", ;
987:                           "Aten" + CHR(231) + CHR(227) + "o")
988:                 loc_oPg2.txt_4c_Dtfin.SetFocus
989:                 RETURN
990:             ENDIF
991:             IF loc_oPg2.txt_4c_Dtini.Value > loc_oPg2.txt_4c_Dtfin.Value
992:                 MsgAviso("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", ;
993:                           "Aten" + CHR(231) + CHR(227) + "o")
994:                 loc_oPg2.txt_4c_Dtini.SetFocus
995:                 RETURN
996:             ENDIF
997:         ENDIF
998: 
999:         TRY
1000:             THIS.FormParaBO()
1001: 
1002:             IF THIS.this_cModoAtual = "INCLUIR"
1003:                 loc_cMsgVal = THIS.this_oBusinessObject.ValidarPeriodo()
1004:                 IF !EMPTY(loc_cMsgVal)
1005:                     MsgAviso(loc_cMsgVal, "Aten" + CHR(231) + CHR(227) + "o")
1006:                     loc_lResultado = .F.
1007:                 ELSE
1008:                     IF !THIS.this_oBusinessObject.GerarCodigo()
1009:                         MsgErro("Erro ao gerar c" + CHR(243) + "digo!", "Erro")
1010:                     ELSE
1011:                         THIS.this_oBusinessObject.this_cUsualts = ALLTRIM(gc_4c_UsuarioLogado)
1012:                         THIS.this_oBusinessObject.this_tDtalts  = DATETIME()
1013:                         IF THIS.this_oBusinessObject.Salvar()
1014:                             MsgInfo("Registro salvo com sucesso!", "Salvo")
1015:                             THIS.this_cModoAtual = "LISTA"
1016:                             THIS.AlternarPagina(1)
1017:                             loc_lResultado = .T.
1018:                         ELSE
1019:                             MsgErro("Erro ao salvar registro!", "Salvar")
1020:                         ENDIF
1021:                     ENDIF
1022:                 ENDIF
1023:             ELSE
1024:                 THIS.this_oBusinessObject.this_cUsualts = ALLTRIM(gc_4c_UsuarioLogado)
1025:                 THIS.this_oBusinessObject.this_tDtalts  = DATETIME()
1026:                 IF THIS.this_oBusinessObject.Salvar()
1027:                     MsgInfo("Registro salvo com sucesso!", "Salvo")
1028:                     THIS.this_cModoAtual = "LISTA"
1029:                     THIS.AlternarPagina(1)
1030:                     loc_lResultado = .T.
1031:                 ELSE
1032:                     MsgErro("Erro ao salvar registro!", "Salvar")
1033:                 ENDIF
1034:             ENDIF
1035:         CATCH TO loc_oErro
1036:             MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + ;
1037:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1038:         ENDTRY
1039:     ENDPROC
1040: 
1041:     *==========================================================================
1042:     * BtnCancelarClick - Cancela edicao e volta para lista
1043:     *==========================================================================
1044:     PROCEDURE BtnCancelarClick()
1045:         THIS.this_cModoAtual = "LISTA"
1046:         THIS.AlternarPagina(1)
1047:         THIS.CarregarLista()
1048:     ENDPROC
1049: 
1050:     *==========================================================================
1051:     * FormParaBO - Transfere campos do form para as propriedades do BO
1052:     *==========================================================================
1053:     PROTECTED PROCEDURE FormParaBO()
1054:         LOCAL loc_oPg2
1055:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1056: 
1057:         IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1058:             THIS.this_oBusinessObject.this_cCpros   = ALLTRIM(loc_oPg2.txt_4c_Cpros.Value)
1059:         ENDIF
1060:         IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
1061:             THIS.this_oBusinessObject.this_nTppro   = loc_oPg2.cbo_4c_CmbTpDesc.ListIndex
1062:         ENDIF
1063:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
1064:             THIS.this_oBusinessObject.this_nValmin  = loc_oPg2.txt_4c_Valmin.Value
1065:         ENDIF
1066:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1067:             THIS.this_oBusinessObject.this_tDtini   = loc_oPg2.txt_4c_Dtini.Value
1068:         ENDIF
1069:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1070:             THIS.this_oBusinessObject.this_tDtfin   = loc_oPg2.txt_4c_Dtfin.Value
1071:         ENDIF
1072:     ENDPROC
1073: 
1074:     *==========================================================================
1075:     * BOParaForm - Transfere propriedades do BO para os campos do form
1076:     *==========================================================================
1077:     PROTECTED PROCEDURE BOParaForm()
1078:         LOCAL loc_oPg2
1079:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1080: 
1081:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1082:             loc_oPg2.txt_4c_Codigo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1083:         ENDIF
1084:         IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1085:             loc_oPg2.txt_4c_Cpros.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
1086:         ENDIF
1087:         IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
1088:             loc_oPg2.cbo_4c_CmbTpDesc.ListIndex = THIS.this_oBusinessObject.this_nTppro
1089:         ENDIF
1090:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
1091:             loc_oPg2.txt_4c_Valmin.Value     = THIS.this_oBusinessObject.this_nValmin
1092:         ENDIF
1093:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1094:             loc_oPg2.txt_4c_Dtini.Value      = THIS.this_oBusinessObject.this_tDtini
1095:         ENDIF
1096:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1097:             loc_oPg2.txt_4c_Dtfin.Value      = THIS.this_oBusinessObject.this_tDtfin
1098:         ENDIF
1099:     ENDPROC
1100: 
1101:     *==========================================================================
1102:     * LimparCampos - Limpa valores dos campos editaveis da Page2
1103:     *==========================================================================
1104:     PROTECTED PROCEDURE LimparCampos()
1105:         LOCAL loc_oPg2
1106:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1107: 
1108:         IF VARTYPE(loc_oPg2) != "O"
1109:             RETURN
1110:         ENDIF
1111:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1112:             loc_oPg2.txt_4c_Codigo.Value    = ""
1113:         ENDIF
1114:         IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1115:             loc_oPg2.txt_4c_Cpros.Value     = ""
1116:         ENDIF
1117:         IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
1118:             loc_oPg2.cbo_4c_CmbTpDesc.ListIndex = 1
1119:         ENDIF
1120:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
1121:             loc_oPg2.txt_4c_Valmin.Value    = 0
1122:         ENDIF
1123:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1124:             loc_oPg2.txt_4c_Dtini.Value     = {}
1125:         ENDIF
1126:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1127:             loc_oPg2.txt_4c_Dtfin.Value     = {}
1128:         ENDIF
1129:     ENDPROC
1130: 
1131:     *==========================================================================
1132:     * HabilitarCampos - Habilita/desabilita campos conforme modo
1133:     * Legado When clauses: getcodigo=RETURN .F. (sempre RO)
1134:     *        getCpros/getDtini/GetDtfin/cmbTpDesc = INLIST INSERIR
1135:     *        GetValmin = sem restricao (editavel em INSERIR e ALTERAR)
1136:     *==========================================================================
1137:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1138:         LOCAL loc_oPg2, loc_lInserir
1139:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1140:         loc_lInserir = (THIS.this_cModoAtual = "INCLUIR")
1141: 
1142:         IF VARTYPE(loc_oPg2) != "O"
1143:             RETURN
1144:         ENDIF
1145: 
1146:         *-- Codigo sempre ReadOnly (legado: getcodigo.When = RETURN .F.)
1147:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1148:             loc_oPg2.txt_4c_Codigo.ReadOnly = .T.
1149:             loc_oPg2.txt_4c_Codigo.Enabled  = .F.
1150:         ENDIF
1151: 
1152:         *-- Produto: editavel apenas no INSERIR
1153:         IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1154:             loc_oPg2.txt_4c_Cpros.ReadOnly = !(par_lHabilitar AND loc_lInserir)
1155:             loc_oPg2.txt_4c_Cpros.Enabled  = par_lHabilitar AND loc_lInserir
1156:         ENDIF
1157: 
1158:         *-- Tipo desconto: editavel apenas no INSERIR
1159:         IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
1160:             loc_oPg2.cbo_4c_CmbTpDesc.Enabled = par_lHabilitar AND loc_lInserir
1161:         ENDIF
1162: 
1163:         *-- Valor minimo: editavel em INSERIR e ALTERAR
1164:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
1165:             loc_oPg2.txt_4c_Valmin.ReadOnly = !par_lHabilitar
1166:             loc_oPg2.txt_4c_Valmin.Enabled  = par_lHabilitar
1167:         ENDIF
1168: 
1169:         *-- Datas: editaveis apenas no INSERIR
1170:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
1171:             loc_oPg2.txt_4c_Dtini.ReadOnly = !(par_lHabilitar AND loc_lInserir)
1172:             loc_oPg2.txt_4c_Dtini.Enabled  = par_lHabilitar AND loc_lInserir
1173:         ENDIF
1174:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
1175:             loc_oPg2.txt_4c_Dtfin.ReadOnly = !(par_lHabilitar AND loc_lInserir)
1176:             loc_oPg2.txt_4c_Dtfin.Enabled  = par_lHabilitar AND loc_lInserir
1177:         ENDIF
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * AjustarBotoesPorModo - Habilita/desabilita Confirmar por modo
1182:     * VISUALIZAR: Confirmar disabled, Cancelar enabled
1183:     * INCLUIR/ALTERAR: ambos enabled
1184:     *==========================================================================
1185:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1186:         LOCAL loc_oPg2, loc_oBtns
1187:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1188: 
1189:         IF VARTYPE(loc_oPg2) != "O"
1190:             RETURN
1191:         ENDIF
1192:         IF !PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1193:             RETURN
1194:         ENDIF
1195: 
1196:         loc_oBtns = loc_oPg2.cnt_4c_BotoesAcao
1197: 
1198:         DO CASE
1199:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1200:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Confirmar", 5)
1201:                     loc_oBtns.cmd_4c_Confirmar.Enabled = .T.
1202:                 ENDIF
1203:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Cancelar", 5)
1204:                     loc_oBtns.cmd_4c_Cancelar.Enabled = .T.
1205:                 ENDIF
1206:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1207:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Confirmar", 5)
1208:                     loc_oBtns.cmd_4c_Confirmar.Enabled = .F.
1209:                 ENDIF
1210:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Cancelar", 5)
1211:                     loc_oBtns.cmd_4c_Cancelar.Enabled = .T.
1212:                 ENDIF
1213:         ENDCASE
1214:     ENDPROC
1215: 
1216:     *==========================================================================
1217:     * TeclaTxtCpros - KeyPress de txt_4c_Cpros: F4(115) ou F5(116) abre busca
1218:     *==========================================================================
1219:     PROCEDURE TeclaTxtCpros(par_nKeyCode, par_nShiftAltCtrl)
1220:         IF INLIST(par_nKeyCode, 115, 116)
1221:             THIS.AbrirBuscaProduto()
1222:         ENDIF
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * AbrirBuscaProduto - Busca produto em SigCdPro via FormBuscaAuxiliar
1227:     * Original: fwbuscaext em SigCdPro, campo CPros, descricao DPros
1228:     *==========================================================================
1229:     PROCEDURE AbrirBuscaProduto()
1230:         LOCAL loc_oPg2, loc_cValor, loc_oBusca
1231:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1232: 
1233:         IF THIS.this_cModoAtual != "INCLUIR"
1234:             RETURN
1235:         ENDIF
1236: 
1237:         loc_cValor = ""
1238:         IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1239:             loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Cpros.Value)
1240:         ENDIF
1241: 
1242:         TRY
1243:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1244:                 "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
1245:                 "Selecionar Produto")
1246: 
1247:             IF VARTYPE(loc_oBusca) = "O"
1248:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1249:                     IF USED("cursor_4c_BuscaPro") AND PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1250:                         loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
1251:                     ENDIF
1252:                 ELSE
1253:                     IF !loc_oBusca.this_lAchouRegistro
1254:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1255:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1256:                     loc_oBusca.Show()
1257:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
1258:                         IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1259:                             loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
1260:                         ENDIF
1261:                     ENDIF
1262:                     ENDIF
1263:                 ENDIF
1264:                 loc_oBusca.Release()
1265:             ENDIF
1266:         CATCH TO loc_oErro
1267:             MsgErro("Erro em AbrirBuscaProduto:" + CHR(13) + loc_oErro.Message, "Erro")
1268:         ENDTRY
1269: 
1270:         IF USED("cursor_4c_BuscaPro")
1271:             USE IN cursor_4c_BuscaPro
1272:         ENDIF
1273:     ENDPROC
1274: 
1275:     *==========================================================================
1276:     * ValidarProduto - LostFocus de txt_4c_Cpros: verifica codigo em SigCdPro
1277:     * Original: fwbuscaext abre lista se nao achou; campo vazio -> limpa
1278:     *==========================================================================
1279:     PROCEDURE ValidarProduto(par_nKeyCode, par_nShiftAltCtrl)
1280:         LOCAL loc_oPg2, loc_cCpros, loc_cSQL, loc_nResult
1281:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1282: 
1283:         IF THIS.this_cModoAtual != "INCLUIR"
1284:             RETURN
1285:         ENDIF
1286:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1287:             RETURN
1288:         ENDIF
1289:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
1290:             RETURN
1291:         ENDIF
1292: 
1293:         loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Cpros.Value)
1294: 
1295:         IF EMPTY(loc_cCpros)
1296:             loc_oPg2.txt_4c_Cpros.Value = ""
1297:             RETURN
1298:         ENDIF
1299: 
1300:         TRY
1301:             loc_cSQL = "SELECT CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
1302: 
1303:             IF USED("cursor_4c_ValPro")
1304:                 USE IN cursor_4c_ValPro
1305:             ENDIF
1306: 
1307:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")
1308: 
1309:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValPro") > 0
1310:                 SELECT cursor_4c_ValPro
1311:                 loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_ValPro.CPros)
1312:             ELSE
1313:                 THIS.AbrirBuscaProduto()
1314:             ENDIF
1315: 
1316:             IF USED("cursor_4c_ValPro")
1317:                 USE IN cursor_4c_ValPro
1318:             ENDIF
1319:         CATCH TO loc_oErro
1320:             MsgErro("Erro em ValidarProduto:" + CHR(13) + loc_oErro.Message, "Erro")
1321:             IF USED("cursor_4c_ValPro")
1322:                 USE IN cursor_4c_ValPro
1323:             ENDIF
1324:         ENDTRY
1325:     ENDPROC
1326: 
1327: ENDDEFINE


### BO (C:\4c\projeto\app\classes\PMCBO.prg):
*==============================================================================
* PMCBO.prg - Business Object: Tabela de Promo??es por Per?odo
* Tabela: SigCdPmc (PK: codigo)
* Schema:
*   codigo   char(10)     PK  auto-gerado PMC+AAMM+SEQ
*   cpros    char(14)     FK SigCdPro.CPros
*   tppro    numeric(2,0) tipo (1=Brinde)
*   dtini    datetime     data inicial
*   dtfin    datetime     data final
*   valmin   numeric(9,2) valor minimo
*   usualts  char(10)     usuario ultima alteracao
*   dtalts   datetime     data/hora ultima alteracao
*==============================================================================
DEFINE CLASS PMCBO AS BusinessBase

    *-- Chave prim?ria
    this_cCodigo   = ""

    *-- Produto (FK SigCdPro.CPros)
    this_cCpros    = ""

    *-- Tipo de promo??o: 1=Brinde
    this_nTppro    = 0

    *-- Per?odo de vig?ncia
    this_tDtini    = {}
    this_tDtfin    = {}

    *-- Valor m?nimo da venda para conceder o brinde
    this_nValmin   = 0

    *-- Auditoria
    this_cUsualts  = ""
    this_tDtalts   = {}

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPmc"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "")
            THIS.this_cCpros    = TratarNulo(cpros,    "")
            THIS.this_nTppro    = TratarNulo(tppro,    0)
            THIS.this_tDtini    = TratarNulo(dtini,    {})
            THIS.this_tDtfin    = TratarNulo(dtfin,    {})
            THIS.this_nValmin   = TratarNulo(valmin,   0)
            THIS.this_cUsualts  = TratarNulo(usualts,  "")
            THIS.this_tDtalts   = TratarNulo(dtalts,   {})
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condi??o SQL adicional (sem WHERE), ou "" para todos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + loc_cWhere + ;
                       " ORDER BY codigo"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo??es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Buscar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo c?digo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.CarregarPorCodigo:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera c?digo auto no formato PMC+AAMM+SEQ (ex: PMC2608001)
    * Replica l?gica original: 'PMC'+SUBSTR(STR(YEAR),3)+PADL(MONTH,2,'0')+SEQ
    *==========================================================================
    PROCEDURE GerarCodigo()
    *==========================================================================
        LOCAL loc_cPrefixo, loc_cSQL, loc_nResult, loc_cCodigo, loc_nSeq, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCodigo  = ""

        TRY
            loc_cPrefixo = "PMC" + SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                           PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                       " WHERE codigo LIKE " + EscaparSQL(loc_cPrefixo + "%")

            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")

            IF loc_nResult >= 0
                SELECT cursor_4c_Seq
                loc_nSeq    = cursor_4c_Seq.qtd + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
                USE IN cursor_4c_Seq
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao gerar c?digo PMC:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_Seq")
                    USE IN cursor_4c_Seq
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.GerarCodigo:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.this_cCodigo = loc_cCodigo
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDtIniFim - Valida que dtini <= dtfin e que o per?odo n?o existe
    * Retorna "" se OK, ou mensagem de erro
    *==========================================================================
    PROCEDURE ValidarPeriodo()
    *==========================================================================
        LOCAL loc_cMsg, loc_cSQL, loc_nResult, loc_cDtIni, loc_cDtFin, loc_lSucesso
        loc_cMsg     = ""
        loc_lSucesso = .T.

        TRY
            *-- Validar campos obrigat?rios
            IF EMPTY(THIS.this_cCpros)
                loc_lSucesso = "Produto n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtini)
                loc_lSucesso = "Data Inicial n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtfin)
                loc_lSucesso = "Data final n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF THIS.this_tDtini > THIS.this_tDtfin
                loc_lSucesso = "As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!"
            ENDIF

            *-- Verificar sobreposi??o de per?odo para o mesmo produto (s? no INSERT)
            IF THIS.this_lNovoRegistro
                loc_cDtIni = FormatarDataSQL(THIS.this_tDtini)
                loc_cDtFin = FormatarDataSQL(THIS.this_tDtfin)

                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                           " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                           " AND (" + ;
                           "  " + loc_cDtIni + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           " OR " + ;
                           "  " + loc_cDtFin + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           ")"

                IF USED("cursor_4c_Val")
                    USE IN cursor_4c_Val
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Val")

                IF loc_nResult >= 0
                    SELECT cursor_4c_Val
                    IF cursor_4c_Val.qtd > 0
                        loc_cMsg = "Esse intervalo j" + CHR(225) + " est" + CHR(225) + ;
                                   " cadastrado para esse produto!"
                    ENDIF
                    USE IN cursor_4c_Val
                ELSE
                    MsgErro("Erro ao validar per?odo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    IF USED("cursor_4c_Val")
                        USE IN cursor_4c_Val
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ValidarPeriodo:" + CHR(13) + loException.Message, "Erro")
            loc_cMsg = "Erro interno ao validar per?odo."
        ENDTRY

        RETURN loc_cMsg
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPmc" + ;
                       " (codigo, cpros, tppro, dtini, dtfin, valmin, usualts, dtalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)            + ", " + ;
                       EscaparSQL(THIS.this_cCpros)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTppro)       + ", " + ;
                       FormatarDataSQL(THIS.this_tDtini)         + ", " + ;
                       FormatarDataSQL(THIS.this_tDtfin)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmin)      + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)           + ", " + ;
                       FormatarDataSQL(THIS.this_tDtalts)        + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Inserir:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPmc SET" + ;
                       " cpros   = " + EscaparSQL(THIS.this_cCpros)          + ", " + ;
                       " tppro   = " + FormatarNumeroSQL(THIS.this_nTppro)   + ", " + ;
                       " dtini   = " + FormatarDataSQL(THIS.this_tDtini)     + ", " + ;
                       " dtfin   = " + FormatarDataSQL(THIS.this_tDtfin)     + ", " + ;
                       " valmin  = " + FormatarNumeroSQL(THIS.this_nValmin)  + ", " + ;
                       " usualts = " + EscaparSQL(THIS.this_cUsualts)        + ", " + ;
                       " dtalts  = " + FormatarDataSQL(THIS.this_tDtalts)    + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Atualizar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPmc WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ExecutarExclusao:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

