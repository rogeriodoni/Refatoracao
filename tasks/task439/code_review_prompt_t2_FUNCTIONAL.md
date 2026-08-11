# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Grupo Operacional' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operações Possíveis, Operação Conferência. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nº' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operações Possíveis, Operação Conferência. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo Operacional' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operações Possíveis, Operação Conferência. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nº' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operações Possíveis, Operação Conferência. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormGpe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4250 linhas total):

*-- Linhas 26 a 146:
26:     *--------------------------------------------------------------------------
27:     * Init - Inicializacao do formulario
28:     *--------------------------------------------------------------------------
29:     PROCEDURE Init()
30:         LOCAL loc_lResultado
31:         loc_lResultado = .F.
32:         TRY
33:             loc_lResultado = DODEFAULT()
34:         CATCH TO loc_oErro
35:             MsgErro(loc_oErro.Message + CHR(13) + ;
36:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
37:                 "Procedure: " + loc_oErro.Procedure, "Erro FormGpe.Init")
38:         ENDTRY
39:         RETURN loc_lResultado
40:     ENDPROC
41: 
42:     *--------------------------------------------------------------------------
43:     * InicializarForm - Criacao da estrutura completa do formulario
44:     *--------------------------------------------------------------------------
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lResultado
47:         loc_lResultado = .F.
48: 
49:         TRY
50:             THIS.this_oBusinessObject = CREATEOBJECT("GpeBO")
51:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
52:                 MsgErro("Erro ao criar GpeBO", "Erro")
53:                 loc_lResultado = .F.
54:             ELSE
55:                 THIS.ConfigurarPageFrame()
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58:                 THIS.ConfigurarPaginaLista()
59:                 THIS.ConfigurarPaginaDados()
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarLista()
63:                 ENDIF
64: 
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68:                 loc_lResultado = .T.
69:             ENDIF
70:         CATCH TO loc_oErro
71:             MsgErro(loc_oErro.Message + CHR(13) + ;
72:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
73:                 "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
74:         ENDTRY
75: 
76:         RETURN loc_lResultado
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
81:     *--------------------------------------------------------------------------
82:     PROTECTED PROCEDURE ConfigurarPageFrame()
83:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .PageCount  = 2
87:             .Top        = -29
88:             .Left       = 0
89:             .Width      = THIS.Width
90:             .Height     = THIS.Height + 29
91:             .Tabs       = .F.
92:             .Visible    = .T.
93: 
94:             .Page1.Caption   = "Lista"
95:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page1.BackColor = RGB(255, 255, 255)
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101:     ENDPROC
102: 
103:     *--------------------------------------------------------------------------
104:     * ConfigurarPaginaLista - Configura Page1 (Lista de registros)
105:     *--------------------------------------------------------------------------
106:     PROTECTED PROCEDURE ConfigurarPaginaLista()
107:         LOCAL loc_oPagina
108:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
109: 
110:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
111:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112: 
113:         *-- Container cabecalho cinza superior
114:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH loc_oPagina.cnt_4c_Cabecalho
116:             .Top         = 2
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackColor   = RGB(100, 100, 100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123: 
124:             .AddObject("lbl_4c_Sombra", "Label")
125:             WITH .lbl_4c_Sombra
126:                 .Caption   = THIS.Caption
127:                 .Top       = 15
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 40
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 16
133:                 .FontBold  = .T.
134:                 .ForeColor = RGB(0, 0, 0)
135:                 .BackStyle = 0
136:                 .AutoSize  = .F.
137:                 .Visible   = .T.
138:             ENDWITH
139: 
140:             .AddObject("lbl_4c_Titulo", "Label")
141:             WITH .lbl_4c_Titulo
142:                 .Caption   = THIS.Caption
143:                 .Top       = 18
144:                 .Left      = 10
145:                 .Width     = THIS.Width
146:                 .Height    = 46

*-- Linhas 393 a 453:
393:             .Column2.Header1.Caption = "N" + CHR(186)
394:         ENDWITH
395: 
396:         THIS.TornarControlesVisiveis(loc_oPagina)
397: 
398:         *-- BINDEVENTs dos botoes da Page1
399:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
400:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
401:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
402:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
403:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
404:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
405:         BINDEVENT(loc_oPagina.cmd_4c_MontaLista,               "Click", THIS, "BtnMontaListaClick")
406:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML,                "Click", THIS, "BtnImpXMLClick")
407:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML,                "Click", THIS, "BtnExpXMLClick")
408:     ENDPROC
409: 
410:     *--------------------------------------------------------------------------
411:     * ConfigurarPaginaDados - Configura Page2 (Dados do registro)
412:     *--------------------------------------------------------------------------
413:     PROTECTED PROCEDURE ConfigurarPaginaDados()
414:         LOCAL loc_oPagina
415:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
416: 
417:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
418:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
419: 
420:         *-- Container botoes Confirmar/Cancelar (topo direito)
421:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
422:         WITH loc_oPagina.cnt_4c_BotoesAcao
423:             .Top         = 33
424:             .Left        = 842
425:             .Width       = 160
426:             .Height      = 85
427:             .BackStyle   = 0
428:             .BorderWidth = 0
429:             .Visible     = .T.
430: 
431:             .AddObject("cmd_4c_Confirmar", "CommandButton")
432:             WITH .cmd_4c_Confirmar
433:                 .Caption         = "Confirmar"
434:                 .Top             = 5
435:                 .Left            = 5
436:                 .Width           = 75
437:                 .Height          = 75
438:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
439:                 .PicturePosition = 13
440:                 .FontName        = "Tahoma"
441:                 .FontSize        = 8
442:                 .FontBold        = .T.
443:                 .FontItalic      = .T.
444:                 .ForeColor       = RGB(90, 90, 90)
445:                 .BackColor       = RGB(255, 255, 255)
446:                 .SpecialEffect   = 0
447:                 .MousePointer    = 15
448:                 .WordWrap        = .T.
449:                 .Visible         = .T.
450:             ENDWITH
451: 
452:             .AddObject("cmd_4c_Cancelar", "CommandButton")
453:             WITH .cmd_4c_Cancelar

*-- Linhas 555 a 645:
555:         THIS.ConfigurarPgConfig(loc_oPagina.pgf_4c_Dados.Page1)
556:         THIS.ConfigurarPgCompls(loc_oPagina.pgf_4c_Dados.Page2)
557: 
558:         THIS.TornarControlesVisiveis(loc_oPagina)
559: 
560:         *-- BINDEVENTs dos botoes da Page2
561:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
562:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
563:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.cmd_4c_Icone,    "Click", THIS, "BtnIconeClick")
564: 
565:         *-- BINDEVENTs para lookup dos campos de texto (Enter/Tab/F4 abre picker)
566:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Subncrs, ;
567:             "KeyPress", THIS, "TxtSubncrsKeyPress")
568:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Locals, ;
569:             "KeyPress", THIS, "TxtLocalsKeyPress")
570:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Codsegs, ;
571:             "KeyPress", THIS, "TxtCodegsKeyPress")
572: 
573:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Subncrs, ;
574:             "DblClick", THIS, "TxtSubncrsDblClick")
575:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Locals, ;
576:             "DblClick", THIS, "TxtLocalsDblClick")
577:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Codsegs, ;
578:             "DblClick", THIS, "TxtCodegsDblClick")
579:     ENDPROC
580: 
581:     *--------------------------------------------------------------------------
582:     * ConfigurarPgConfig - Configura aba Configuracoes (pgf_4c_Dados.Page1)
583:     * Coordenadas relativas a pagina (sem compensacao +29)
584:     *--------------------------------------------------------------------------
585:     PROTECTED PROCEDURE ConfigurarPgConfig(par_oPg)
586: 
587:         *-- COLUNA ESQUERDA: OptionGroups e labels (Left=167, Width=247)
588: 
589:         *-- Numeracao da Operacao (numopers)
590:         par_oPg.AddObject("lbl_4c_NumOper", "Label")
591:         WITH par_oPg.lbl_4c_NumOper
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .Caption   = "Numera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o :"
595:             .Top       = 13
596:             .Left      = 36
597:             .Width     = 128
598:             .Height    = 15
599:             .ForeColor = RGB(90, 90, 90)
600:             .BackStyle = 0
601:             .AutoSize  = .F.
602:             .Visible   = .T.
603:         ENDWITH
604: 
605:         par_oPg.AddObject("opt_4c_NumOper", "OptionGroup")
606:         WITH par_oPg.opt_4c_NumOper
607:             .ButtonCount = 3
608:             .AutoSize    = .F.
609:             .BackStyle   = 0
610:             .BorderStyle = 0
611:             .Height      = 21
612:             .Left        = 167
613:             .Top         = 8
614:             .Width       = 247
615:             .Value       = 1
616:             .Visible     = .T.
617:             .Buttons(1).Caption   = "No. Controle"
618:             .Buttons(1).FontSize  = 8
619:             .Buttons(1).BackStyle = 0
620:             .Buttons(1).Left      = 3
621:             .Buttons(1).Top       = 3
622:             .Buttons(1).Width     = 79
623:             .Buttons(1).AutoSize  = .T.
624:             .Buttons(1).ForeColor = RGB(90, 90, 90)
625:             .Buttons(2).Caption   = "Autom" + CHR(225) + "tica"
626:             .Buttons(2).FontSize  = 8
627:             .Buttons(2).BackStyle = 0
628:             .Buttons(2).Left      = 82
629:             .Buttons(2).Top       = 3
630:             .Buttons(2).Width     = 72
631:             .Buttons(2).AutoSize  = .T.
632:             .Buttons(2).ForeColor = RGB(90, 90, 90)
633:             .Buttons(3).Caption   = "Oper + No.Ctrl"
634:             .Buttons(3).FontSize  = 8
635:             .Buttons(3).BackStyle = 0
636:             .Buttons(3).Left      = 159
637:             .Buttons(3).Top       = 3
638:             .Buttons(3).Width     = 90
639:             .Buttons(3).AutoSize  = .T.
640:             .Buttons(3).ForeColor = RGB(90, 90, 90)
641:         ENDWITH
642: 
643:         *-- Tipo do No de Controle (ncontroles)
644:         par_oPg.AddObject("lbl_4c_Controle", "Label")
645:         WITH par_oPg.lbl_4c_Controle

*-- Linhas 656 a 699:
656:             .Visible   = .T.
657:         ENDWITH
658: 
659:         par_oPg.AddObject("opt_4c_Controle", "OptionGroup")
660:         WITH par_oPg.opt_4c_Controle
661:             .ButtonCount = 3
662:             .AutoSize    = .F.
663:             .BackStyle   = 0
664:             .BorderStyle = 0
665:             .Height      = 22
666:             .Left        = 167
667:             .Top         = 29
668:             .Width       = 247
669:             .Value       = 1
670:             .Visible     = .T.
671:             .Buttons(1).Caption      = "Empresa"
672:             .Buttons(1).ToolTipText  = "Tipo Espelho ( EEENNNNNN )"
673:             .Buttons(1).FontSize     = 8
674:             .Buttons(1).BackStyle    = 0
675:             .Buttons(1).Left         = 3
676:             .Buttons(1).Top          = 3
677:             .Buttons(1).Width        = 59
678:             .Buttons(1).AutoSize     = .T.
679:             .Buttons(1).ForeColor    = RGB(90, 90, 90)
680:             .Buttons(2).Caption      = "Opera" + CHR(231) + CHR(227) + "o"
681:             .Buttons(2).ToolTipText  = "Tipo Boleto ( OONNNNNN )"
682:             .Buttons(2).FontSize     = 8
683:             .Buttons(2).BackStyle    = 0
684:             .Buttons(2).Left         = 82
685:             .Buttons(2).Top          = 3
686:             .Buttons(2).Width        = 65
687:             .Buttons(2).AutoSize     = .T.
688:             .Buttons(2).ForeColor    = RGB(90, 90, 90)
689:             .Buttons(3).Caption      = "Manual"
690:             .Buttons(3).ToolTipText  = "Tipo Manual ( NNNNNN )"
691:             .Buttons(3).FontSize     = 8
692:             .Buttons(3).BackStyle    = 0
693:             .Buttons(3).Left         = 159
694:             .Buttons(3).Top          = 3
695:             .Buttons(3).Width        = 61
696:             .Buttons(3).AutoSize     = .T.
697:             .Buttons(3).ForeColor    = RGB(90, 90, 90)
698:         ENDWITH
699: 

*-- Linhas 713 a 802:
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         par_oPg.AddObject("opt_4c_FonNum", "OptionGroup")
717:         WITH par_oPg.opt_4c_FonNum
718:             .ButtonCount = 2
719:             .AutoSize    = .F.
720:             .BackStyle   = 0
721:             .BorderStyle = 0
722:             .Height      = 21
723:             .Left        = 167
724:             .Top         = 51
725:             .Width       = 247
726:             .Value       = 2
727:             .Visible     = .T.
728:             .Buttons(1).Caption   = "Grupo"
729:             .Buttons(1).FontSize  = 8
730:             .Buttons(1).BackStyle = 0
731:             .Buttons(1).Left      = 3
732:             .Buttons(1).Top       = 3
733:             .Buttons(1).Width     = 47
734:             .Buttons(1).AutoSize  = .T.
735:             .Buttons(1).ForeColor = RGB(90, 90, 90)
736:             .Buttons(2).Caption   = "Opera" + CHR(231) + CHR(227) + "o"
737:             .Buttons(2).FontSize  = 8
738:             .Buttons(2).BackStyle = 0
739:             .Buttons(2).Left      = 82
740:             .Buttons(2).Top       = 3
741:             .Buttons(2).Width     = 65
742:             .Buttons(2).AutoSize  = .T.
743:             .Buttons(2).ForeColor = RGB(90, 90, 90)
744:         ENDWITH
745: 
746:         *-- Situacao das Operacoes (utilizas)
747:         par_oPg.AddObject("lbl_4c_Utilizas", "Label")
748:         WITH par_oPg.lbl_4c_Utilizas
749:             .FontName  = "Tahoma"
750:             .FontSize  = 8
751:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es:"
752:             .Top       = 75
753:             .Left      = 42
754:             .Width     = 122
755:             .Height    = 15
756:             .ForeColor = RGB(90, 90, 90)
757:             .BackStyle = 0
758:             .AutoSize  = .F.
759:             .Visible   = .T.
760:         ENDWITH
761: 
762:         par_oPg.AddObject("opt_4c_Utilizas", "OptionGroup")
763:         WITH par_oPg.opt_4c_Utilizas
764:             .ButtonCount = 3
765:             .AutoSize    = .F.
766:             .BackStyle   = 0
767:             .BorderStyle = 0
768:             .Height      = 22
769:             .Left        = 167
770:             .Top         = 72
771:             .Width       = 247
772:             .Value       = 1
773:             .Visible     = .T.
774:             .Buttons(1).Caption   = "Todas"
775:             .Buttons(1).FontSize  = 8
776:             .Buttons(1).BackStyle = 0
777:             .Buttons(1).Left      = 3
778:             .Buttons(1).Top       = 3
779:             .Buttons(1).Width     = 47
780:             .Buttons(1).AutoSize  = .T.
781:             .Buttons(1).ForeColor = RGB(90, 90, 90)
782:             .Buttons(2).Caption   = "Utilizadas"
783:             .Buttons(2).FontSize  = 8
784:             .Buttons(2).BackStyle = 0
785:             .Buttons(2).Left      = 82
786:             .Buttons(2).Top       = 3
787:             .Buttons(2).Width     = 63
788:             .Buttons(2).AutoSize  = .T.
789:             .Buttons(2).ForeColor = RGB(90, 90, 90)
790:             .Buttons(3).Caption   = "N" + CHR(227) + "o Utilizadas"
791:             .Buttons(3).FontSize  = 8
792:             .Buttons(3).BackStyle = 0
793:             .Buttons(3).Left      = 159
794:             .Buttons(3).Top       = 3
795:             .Buttons(3).Width     = 73
796:             .Buttons(3).AutoSize  = .T.
797:             .Buttons(3).ForeColor = RGB(90, 90, 90)
798:         ENDWITH
799: 
800:         *-- Situacao dos Subniveis (subniveis)
801:         par_oPg.AddObject("lbl_4c_Subniveis", "Label")
802:         WITH par_oPg.lbl_4c_Subniveis

*-- Linhas 813 a 856:
813:             .Visible   = .T.
814:         ENDWITH
815: 
816:         par_oPg.AddObject("opt_4c_Subniveis", "OptionGroup")
817:         WITH par_oPg.opt_4c_Subniveis
818:             .ButtonCount = 3
819:             .AutoSize    = .F.
820:             .BackStyle   = 0
821:             .BorderStyle = 0
822:             .Height      = 22
823:             .Left        = 167
824:             .Top         = 94
825:             .Width       = 247
826:             .Value       = 1
827:             .Visible     = .T.
828:             .Buttons(1).Caption   = "Todos"
829:             .Buttons(1).FontSize  = 8
830:             .Buttons(1).BackStyle = 0
831:             .Buttons(1).Left      = 3
832:             .Buttons(1).Top       = 3
833:             .Buttons(1).Width     = 47
834:             .Buttons(1).AutoSize  = .T.
835:             .Buttons(1).ForeColor = RGB(90, 90, 90)
836:             .Buttons(2).Caption   = "Pendentes"
837:             .Buttons(2).FontSize  = 8
838:             .Buttons(2).BackStyle = 0
839:             .Buttons(2).Left      = 82
840:             .Buttons(2).Top       = 3
841:             .Buttons(2).Width     = 69
842:             .Buttons(2).AutoSize  = .T.
843:             .Buttons(2).ForeColor = RGB(90, 90, 90)
844:             .Buttons(3).Caption   = "Baixados"
845:             .Buttons(3).FontSize  = 8
846:             .Buttons(3).BackStyle = 0
847:             .Buttons(3).Left      = 159
848:             .Buttons(3).Top       = 3
849:             .Buttons(3).Width     = 61
850:             .Buttons(3).AutoSize  = .T.
851:             .Buttons(3).ForeColor = RGB(90, 90, 90)
852:         ENDWITH
853: 
854:         *-- Ordem de Producao (prods)
855:         par_oPg.AddObject("lbl_4c_Prods", "Label")
856:         WITH par_oPg.lbl_4c_Prods

*-- Linhas 867 a 910:
867:             .Visible   = .T.
868:         ENDWITH
869: 
870:         par_oPg.AddObject("opt_4c_Prods", "OptionGroup")
871:         WITH par_oPg.opt_4c_Prods
872:             .ButtonCount = 3
873:             .AutoSize    = .F.
874:             .BackStyle   = 0
875:             .BorderStyle = 0
876:             .Height      = 22
877:             .Left        = 167
878:             .Top         = 116
879:             .Width       = 247
880:             .Value       = 1
881:             .Visible     = .T.
882:             .Buttons(1).Caption   = "Todas"
883:             .Buttons(1).FontSize  = 8
884:             .Buttons(1).BackStyle = 0
885:             .Buttons(1).Left      = 3
886:             .Buttons(1).Top       = 3
887:             .Buttons(1).Width     = 47
888:             .Buttons(1).AutoSize  = .T.
889:             .Buttons(1).ForeColor = RGB(90, 90, 90)
890:             .Buttons(2).Caption   = "Com OP"
891:             .Buttons(2).FontSize  = 8
892:             .Buttons(2).BackStyle = 0
893:             .Buttons(2).Left      = 82
894:             .Buttons(2).Top       = 3
895:             .Buttons(2).Width     = 56
896:             .Buttons(2).AutoSize  = .T.
897:             .Buttons(2).ForeColor = RGB(90, 90, 90)
898:             .Buttons(3).Caption   = "Sem OP"
899:             .Buttons(3).FontSize  = 8
900:             .Buttons(3).BackStyle = 0
901:             .Buttons(3).Left      = 159
902:             .Buttons(3).Top       = 3
903:             .Buttons(3).Width     = 55
904:             .Buttons(3).AutoSize  = .T.
905:             .Buttons(3).ForeColor = RGB(90, 90, 90)
906:         ENDWITH
907: 
908:         *-- Desagendar Utilizados (desutils)
909:         par_oPg.AddObject("lbl_4c_Desutils", "Label")
910:         WITH par_oPg.lbl_4c_Desutils

*-- Linhas 921 a 1140:
921:             .Visible   = .T.
922:         ENDWITH
923: 
924:         par_oPg.AddObject("opt_4c_Desutils", "OptionGroup")
925:         WITH par_oPg.opt_4c_Desutils
926:             .ButtonCount = 2
927:             .AutoSize    = .F.
928:             .BackStyle   = 0
929:             .BorderStyle = 0
930:             .Height      = 22
931:             .Left        = 167
932:             .Top         = 138
933:             .Width       = 247
934:             .Value       = 2
935:             .Visible     = .T.
936:             .Buttons(1).Caption   = "Sim"
937:             .Buttons(1).FontSize  = 8
938:             .Buttons(1).BackStyle = 0
939:             .Buttons(1).Left      = 3
940:             .Buttons(1).Top       = 3
941:             .Buttons(1).Width     = 34
942:             .Buttons(1).AutoSize  = .T.
943:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
944:             .Buttons(2).FontSize  = 8
945:             .Buttons(2).BackStyle = 0
946:             .Buttons(2).Left      = 82
947:             .Buttons(2).Top       = 3
948:             .Buttons(2).Width     = 37
949:             .Buttons(2).AutoSize  = .T.
950:         ENDWITH
951: 
952:         *-- Exibir botao F8 - AGENDA (iniagenda)
953:         par_oPg.AddObject("lbl_4c_Iniagenda", "Label")
954:         WITH par_oPg.lbl_4c_Iniagenda
955:             .FontName  = "Tahoma"
956:             .FontSize  = 8
957:             .Caption   = "Exibir bot" + CHR(227) + "o F8 - AGENDA:"
958:             .Top       = 163
959:             .Left      = 35
960:             .Width     = 129
961:             .Height    = 15
962:             .ForeColor = RGB(90, 90, 90)
963:             .BackStyle = 0
964:             .AutoSize  = .F.
965:             .Visible   = .T.
966:         ENDWITH
967: 
968:         par_oPg.AddObject("opt_4c_Iniagenda", "OptionGroup")
969:         WITH par_oPg.opt_4c_Iniagenda
970:             .ButtonCount = 2
971:             .AutoSize    = .F.
972:             .BackStyle   = 0
973:             .BorderStyle = 0
974:             .Height      = 22
975:             .Left        = 167
976:             .Top         = 160
977:             .Width       = 247
978:             .Value       = 2
979:             .Visible     = .T.
980:             .Buttons(1).Caption   = "Sim"
981:             .Buttons(1).FontSize  = 8
982:             .Buttons(1).BackStyle = 0
983:             .Buttons(1).Left      = 3
984:             .Buttons(1).Top       = 3
985:             .Buttons(1).Width     = 34
986:             .Buttons(1).AutoSize  = .T.
987:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
988:             .Buttons(2).FontSize  = 8
989:             .Buttons(2).BackStyle = 0
990:             .Buttons(2).Left      = 82
991:             .Buttons(2).Top       = 3
992:             .Buttons(2).Width     = 37
993:             .Buttons(2).AutoSize  = .T.
994:         ENDWITH
995: 
996:         *-- Ignorar Grupo Operacional (qualquer)
997:         par_oPg.AddObject("lbl_4c_Qualquer", "Label")
998:         WITH par_oPg.lbl_4c_Qualquer
999:             .FontName  = "Tahoma"
1000:             .FontSize  = 8
1001:             .Caption   = "Ignorar Grupo Operacional :"
1002:             .Top       = 185
1003:             .Left      = 27
1004:             .Width     = 137
1005:             .Height    = 15
1006:             .ForeColor = RGB(90, 90, 90)
1007:             .BackStyle = 0
1008:             .AutoSize  = .F.
1009:             .Visible   = .T.
1010:         ENDWITH
1011: 
1012:         par_oPg.AddObject("opt_4c_Qualquer", "OptionGroup")
1013:         WITH par_oPg.opt_4c_Qualquer
1014:             .ButtonCount = 2
1015:             .AutoSize    = .F.
1016:             .BackStyle   = 0
1017:             .BorderStyle = 0
1018:             .Height      = 22
1019:             .Left        = 167
1020:             .Top         = 182
1021:             .Width       = 247
1022:             .Value       = 2
1023:             .Visible     = .T.
1024:             .Buttons(1).Caption   = "Sim"
1025:             .Buttons(1).FontSize  = 8
1026:             .Buttons(1).BackStyle = 0
1027:             .Buttons(1).Left      = 3
1028:             .Buttons(1).Top       = 3
1029:             .Buttons(1).Width     = 34
1030:             .Buttons(1).AutoSize  = .T.
1031:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1032:             .Buttons(2).FontSize  = 8
1033:             .Buttons(2).BackStyle = 0
1034:             .Buttons(2).Left      = 82
1035:             .Buttons(2).Top       = 3
1036:             .Buttons(2).Width     = 37
1037:             .Buttons(2).AutoSize  = .T.
1038:         ENDWITH
1039: 
1040:         *-- Apenas Consulta (consulta)
1041:         par_oPg.AddObject("lbl_4c_Consulta", "Label")
1042:         WITH par_oPg.lbl_4c_Consulta
1043:             .FontName  = "Tahoma"
1044:             .FontSize  = 8
1045:             .Caption   = "Apenas Consulta :"
1046:             .Top       = 207
1047:             .Left      = 74
1048:             .Width     = 90
1049:             .Height    = 15
1050:             .ForeColor = RGB(90, 90, 90)
1051:             .BackStyle = 0
1052:             .AutoSize  = .F.
1053:             .Visible   = .T.
1054:         ENDWITH
1055: 
1056:         par_oPg.AddObject("opt_4c_Consulta", "OptionGroup")
1057:         WITH par_oPg.opt_4c_Consulta
1058:             .ButtonCount = 2
1059:             .AutoSize    = .F.
1060:             .BackStyle   = 0
1061:             .BorderStyle = 0
1062:             .Height      = 22
1063:             .Left        = 167
1064:             .Top         = 204
1065:             .Width       = 247
1066:             .Value       = 2
1067:             .Visible     = .T.
1068:             .Buttons(1).Caption   = "Sim"
1069:             .Buttons(1).FontSize  = 8
1070:             .Buttons(1).BackStyle = 0
1071:             .Buttons(1).Left      = 3
1072:             .Buttons(1).Top       = 3
1073:             .Buttons(1).Width     = 34
1074:             .Buttons(1).AutoSize  = .T.
1075:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1076:             .Buttons(2).FontSize  = 8
1077:             .Buttons(2).BackStyle = 0
1078:             .Buttons(2).Left      = 82
1079:             .Buttons(2).Top       = 3
1080:             .Buttons(2).Width     = 37
1081:             .Buttons(2).AutoSize  = .T.
1082:         ENDWITH
1083: 
1084:         *-- Produtos Com Montagem (montagem)
1085:         par_oPg.AddObject("lbl_4c_Montagem", "Label")
1086:         WITH par_oPg.lbl_4c_Montagem
1087:             .FontName  = "Tahoma"
1088:             .FontSize  = 8
1089:             .Caption   = "Produtos Com Montagem :"
1090:             .Top       = 229
1091:             .Left      = 35
1092:             .Width     = 129
1093:             .Height    = 15
1094:             .ForeColor = RGB(90, 90, 90)
1095:             .BackStyle = 0
1096:             .AutoSize  = .F.
1097:             .Visible   = .T.
1098:         ENDWITH
1099: 
1100:         par_oPg.AddObject("opt_4c_Montagem", "OptionGroup")
1101:         WITH par_oPg.opt_4c_Montagem
1102:             .ButtonCount = 3
1103:             .AutoSize    = .F.
1104:             .BackStyle   = 0
1105:             .BorderStyle = 0
1106:             .Height      = 22
1107:             .Left        = 167
1108:             .Top         = 226
1109:             .Width       = 247
1110:             .Value       = 2
1111:             .Visible     = .T.
1112:             .Buttons(1).Caption   = "Sim"
1113:             .Buttons(1).FontSize  = 8
1114:             .Buttons(1).BackStyle = 0
1115:             .Buttons(1).Left      = 3
1116:             .Buttons(1).Top       = 3
1117:             .Buttons(1).Width     = 34
1118:             .Buttons(1).AutoSize  = .T.
1119:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1120:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1121:             .Buttons(2).FontSize  = 8
1122:             .Buttons(2).BackStyle = 0
1123:             .Buttons(2).Left      = 82
1124:             .Buttons(2).Top       = 3
1125:             .Buttons(2).Width     = 37
1126:             .Buttons(2).AutoSize  = .T.
1127:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1128:             .Buttons(3).Caption   = "Ambos"
1129:             .Buttons(3).FontSize  = 8
1130:             .Buttons(3).BackStyle = 0
1131:             .Buttons(3).Left      = 159
1132:             .Buttons(3).Top       = 3
1133:             .Buttons(3).Width     = 61
1134:             .Buttons(3).AutoSize  = .T.
1135:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1136:         ENDWITH
1137: 
1138:         *-- Checar Mercadorias (chkmercs)
1139:         par_oPg.AddObject("lbl_4c_Chkmercs", "Label")
1140:         WITH par_oPg.lbl_4c_Chkmercs

*-- Linhas 1151 a 1238:
1151:             .Visible   = .T.
1152:         ENDWITH
1153: 
1154:         par_oPg.AddObject("opt_4c_Chkmercs", "OptionGroup")
1155:         WITH par_oPg.opt_4c_Chkmercs
1156:             .ButtonCount = 2
1157:             .AutoSize    = .F.
1158:             .BackStyle   = 0
1159:             .BorderStyle = 0
1160:             .Height      = 22
1161:             .Left        = 167
1162:             .Top         = 248
1163:             .Width       = 247
1164:             .Value       = 2
1165:             .Visible     = .T.
1166:             .Buttons(1).Caption   = "Sim"
1167:             .Buttons(1).FontSize  = 8
1168:             .Buttons(1).BackStyle = 0
1169:             .Buttons(1).Left      = 3
1170:             .Buttons(1).Top       = 3
1171:             .Buttons(1).Width     = 34
1172:             .Buttons(1).AutoSize  = .T.
1173:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1174:             .Buttons(2).FontSize  = 8
1175:             .Buttons(2).BackStyle = 0
1176:             .Buttons(2).Left      = 82
1177:             .Buttons(2).Top       = 3
1178:             .Buttons(2).Width     = 37
1179:             .Buttons(2).AutoSize  = .T.
1180:         ENDWITH
1181: 
1182:         *-- Operacoes Utilizadas (oputiliza)
1183:         par_oPg.AddObject("lbl_4c_Oputiliza", "Label")
1184:         WITH par_oPg.lbl_4c_Oputiliza
1185:             .FontName  = "Tahoma"
1186:             .FontSize  = 8
1187:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es Utilizadas :"
1188:             .Top       = 273
1189:             .Left      = 55
1190:             .Width     = 109
1191:             .Height    = 15
1192:             .ForeColor = RGB(90, 90, 90)
1193:             .BackStyle = 0
1194:             .AutoSize  = .F.
1195:             .Visible   = .T.
1196:         ENDWITH
1197: 
1198:         par_oPg.AddObject("opt_4c_Oputiliza", "OptionGroup")
1199:         WITH par_oPg.opt_4c_Oputiliza
1200:             .ButtonCount = 3
1201:             .AutoSize    = .F.
1202:             .BackStyle   = 0
1203:             .BorderStyle = 0
1204:             .Height      = 22
1205:             .Left        = 167
1206:             .Top         = 270
1207:             .Width       = 247
1208:             .Value       = 1
1209:             .Visible     = .T.
1210:             .Buttons(1).Caption   = "Sim"
1211:             .Buttons(1).FontSize  = 8
1212:             .Buttons(1).BackStyle = 0
1213:             .Buttons(1).Left      = 3
1214:             .Buttons(1).Top       = 3
1215:             .Buttons(1).Width     = 34
1216:             .Buttons(1).AutoSize  = .T.
1217:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1218:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1219:             .Buttons(2).FontSize  = 8
1220:             .Buttons(2).BackStyle = 0
1221:             .Buttons(2).Left      = 82
1222:             .Buttons(2).Top       = 3
1223:             .Buttons(2).Width     = 37
1224:             .Buttons(2).AutoSize  = .T.
1225:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1226:             .Buttons(3).Caption   = "Ambas"
1227:             .Buttons(3).FontSize  = 8
1228:             .Buttons(3).BackStyle = 0
1229:             .Buttons(3).Left      = 159
1230:             .Buttons(3).Top       = 3
1231:             .Buttons(3).Width     = 61
1232:             .Buttons(3).AutoSize  = .T.
1233:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1234:         ENDWITH
1235: 
1236:         *-- Operacoes Pagas (filpagas)
1237:         par_oPg.AddObject("lbl_4c_Filpagas", "Label")
1238:         WITH par_oPg.lbl_4c_Filpagas

*-- Linhas 1249 a 1292:
1249:             .Visible   = .T.
1250:         ENDWITH
1251: 
1252:         par_oPg.AddObject("opt_4c_Filpagas", "OptionGroup")
1253:         WITH par_oPg.opt_4c_Filpagas
1254:             .ButtonCount = 3
1255:             .AutoSize    = .F.
1256:             .BackStyle   = 0
1257:             .BorderStyle = 0
1258:             .Height      = 22
1259:             .Left        = 167
1260:             .Top         = 292
1261:             .Width       = 247
1262:             .Value       = 1
1263:             .Visible     = .T.
1264:             .Buttons(1).Caption   = "Sim"
1265:             .Buttons(1).FontSize  = 8
1266:             .Buttons(1).BackStyle = 0
1267:             .Buttons(1).Left      = 3
1268:             .Buttons(1).Top       = 3
1269:             .Buttons(1).Width     = 34
1270:             .Buttons(1).AutoSize  = .T.
1271:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1272:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1273:             .Buttons(2).FontSize  = 8
1274:             .Buttons(2).BackStyle = 0
1275:             .Buttons(2).Left      = 82
1276:             .Buttons(2).Top       = 3
1277:             .Buttons(2).Width     = 37
1278:             .Buttons(2).AutoSize  = .T.
1279:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1280:             .Buttons(3).Caption   = "Ambas"
1281:             .Buttons(3).FontSize  = 8
1282:             .Buttons(3).BackStyle = 0
1283:             .Buttons(3).Left      = 159
1284:             .Buttons(3).Top       = 3
1285:             .Buttons(3).Width     = 61
1286:             .Buttons(3).AutoSize  = .T.
1287:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1288:         ENDWITH
1289: 
1290:         *-- Operacoes Baixadas (filbaixas)
1291:         par_oPg.AddObject("lbl_4c_Filbaixas", "Label")
1292:         WITH par_oPg.lbl_4c_Filbaixas

*-- Linhas 1303 a 1346:
1303:             .Visible   = .T.
1304:         ENDWITH
1305: 
1306:         par_oPg.AddObject("opt_4c_Filbaixas", "OptionGroup")
1307:         WITH par_oPg.opt_4c_Filbaixas
1308:             .ButtonCount = 3
1309:             .AutoSize    = .F.
1310:             .BackStyle   = 0
1311:             .BorderStyle = 0
1312:             .Height      = 22
1313:             .Left        = 167
1314:             .Top         = 314
1315:             .Width       = 247
1316:             .Value       = 1
1317:             .Visible     = .T.
1318:             .Buttons(1).Caption   = "Sim"
1319:             .Buttons(1).FontSize  = 8
1320:             .Buttons(1).BackStyle = 0
1321:             .Buttons(1).Left      = 3
1322:             .Buttons(1).Top       = 3
1323:             .Buttons(1).Width     = 34
1324:             .Buttons(1).AutoSize  = .T.
1325:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1326:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1327:             .Buttons(2).FontSize  = 8
1328:             .Buttons(2).BackStyle = 0
1329:             .Buttons(2).Left      = 82
1330:             .Buttons(2).Top       = 3
1331:             .Buttons(2).Width     = 37
1332:             .Buttons(2).AutoSize  = .T.
1333:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1334:             .Buttons(3).Caption   = "Ambas"
1335:             .Buttons(3).FontSize  = 8
1336:             .Buttons(3).BackStyle = 0
1337:             .Buttons(3).Left      = 159
1338:             .Buttons(3).Top       = 3
1339:             .Buttons(3).Width     = 61
1340:             .Buttons(3).AutoSize  = .T.
1341:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1342:         ENDWITH
1343: 
1344:         *-- Limite Diario (limdia)
1345:         par_oPg.AddObject("lbl_4c_Limdia", "Label")
1346:         WITH par_oPg.lbl_4c_Limdia

*-- Linhas 1370 a 1413:
1370:         ENDWITH
1371: 
1372:         *-- COLUNA DIREITA: Auditoria (9 opcoes) - Left=424
1373:         par_oPg.AddObject("opt_4c_Audits", "OptionGroup")
1374:         WITH par_oPg.opt_4c_Audits
1375:             .ButtonCount = 9
1376:             .AutoSize    = .F.
1377:             .BackStyle   = 0
1378:             .BorderStyle = 0
1379:             .Height      = 112
1380:             .Left        = 424
1381:             .Top         = 8
1382:             .Width       = 301
1383:             .Value       = 2
1384:             .Visible     = .T.
1385:             .Buttons(1).Caption   = "Sim"
1386:             .Buttons(1).FontSize  = 8
1387:             .Buttons(1).BackStyle = 0
1388:             .Buttons(1).Left      = 4
1389:             .Buttons(1).Top       = 6
1390:             .Buttons(1).Width     = 34
1391:             .Buttons(1).AutoSize  = .T.
1392:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1393:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1394:             .Buttons(2).FontSize  = 8
1395:             .Buttons(2).BackStyle = 0
1396:             .Buttons(2).Left      = 151
1397:             .Buttons(2).Top       = 6
1398:             .Buttons(2).Width     = 37
1399:             .Buttons(2).AutoSize  = .T.
1400:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1401:             .Buttons(3).Caption   = "Agendamento Pago"
1402:             .Buttons(3).FontSize  = 8
1403:             .Buttons(3).BackStyle = 0
1404:             .Buttons(3).Left      = 4
1405:             .Buttons(3).Top       = 27
1406:             .Buttons(3).Width     = 112
1407:             .Buttons(3).AutoSize  = .T.
1408:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1409:             .Buttons(4).Caption   = "Agendamento N" + CHR(227) + "o Pago"
1410:             .Buttons(4).FontSize  = 8
1411:             .Buttons(4).BackStyle = 0
1412:             .Buttons(4).Left      = 151
1413:             .Buttons(4).Top       = 27

*-- Linhas 1506 a 1549:
1506:     * ConfigurarPgCompls - Configura aba Complementos (pgf_4c_Dados.Page2)
1507:     * Coordenadas relativas a pagina (sem compensacao +29)
1508:     *--------------------------------------------------------------------------
1509:     PROTECTED PROCEDURE ConfigurarPgCompls(par_oPg)
1510: 
1511:         *-- Bordas decorativas (Shape) - agrupamento visual de secoes
1512: 
1513:         par_oPg.AddObject("shp_4c_Shape2", "Shape")
1514:         WITH par_oPg.shp_4c_Shape2
1515:             .Top           = 10
1516:             .Left          = 515
1517:             .Height        = 61
1518:             .Width         = 215
1519:             .BackStyle     = 0
1520:             .SpecialEffect = 0
1521:             .Visible       = .T.
1522:         ENDWITH
1523: 
1524:         par_oPg.AddObject("shp_4c_Shape6", "Shape")
1525:         WITH par_oPg.shp_4c_Shape6
1526:             .Top           = 73
1527:             .Left          = 515
1528:             .Height        = 56
1529:             .Width         = 215
1530:             .BackStyle     = 0
1531:             .SpecialEffect = 0
1532:             .Visible       = .T.
1533:         ENDWITH
1534: 
1535:         par_oPg.AddObject("shp_4c_Shape1", "Shape")
1536:         WITH par_oPg.shp_4c_Shape1
1537:             .Top           = 246
1538:             .Left          = 275
1539:             .Height        = 79
1540:             .Width         = 264
1541:             .BackStyle     = 0
1542:             .SpecialEffect = 0
1543:             .Visible       = .T.
1544:         ENDWITH
1545: 
1546:         par_oPg.AddObject("shp_4c_Shape3", "Shape")
1547:         WITH par_oPg.shp_4c_Shape3
1548:             .Top           = 246
1549:             .Left          = 5

*-- Linhas 1577 a 2242:
1577:             .Visible     = .T.
1578:         ENDWITH
1579: 
1580:         *-- COLUNA ESQUERDA: OptionGroups Sim/Nao (Left=173, Width=86, H=20)
1581: 
1582:         *-- Utilizar Data Atual (dtatuals)
1583:         par_oPg.AddObject("lbl_4c_DtAtuals", "Label")
1584:         WITH par_oPg.lbl_4c_DtAtuals
1585:             .FontName  = "Tahoma"
1586:             .FontSize  = 8
1587:             .Caption   = "Utilizar Data Atual :"
1588:             .Top       = 6
1589:             .Left      = 79
1590:             .Width     = 95
1591:             .Height    = 15
1592:             .ForeColor = RGB(90, 90, 90)
1593:             .BackStyle = 0
1594:             .AutoSize  = .F.
1595:             .Visible   = .T.
1596:         ENDWITH
1597: 
1598:         par_oPg.AddObject("opt_4c_Dtatuals", "OptionGroup")
1599:         WITH par_oPg.opt_4c_Dtatuals
1600:             .ButtonCount = 2
1601:             .AutoSize    = .F.
1602:             .BackStyle   = 0
1603:             .BorderStyle = 0
1604:             .Height      = 20
1605:             .Left        = 173
1606:             .Top         = 2
1607:             .Width       = 86
1608:             .Value       = 1
1609:             .Visible     = .T.
1610:             .Buttons(1).Caption   = "Sim"
1611:             .Buttons(1).FontSize  = 8
1612:             .Buttons(1).BackStyle = 0
1613:             .Buttons(1).Left      = 5
1614:             .Buttons(1).Top       = 3
1615:             .Buttons(1).Width     = 34
1616:             .Buttons(1).AutoSize  = .T.
1617:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1618:             .Buttons(2).FontSize  = 8
1619:             .Buttons(2).BackStyle = 0
1620:             .Buttons(2).Left      = 45
1621:             .Buttons(2).Top       = 3
1622:             .Buttons(2).Width     = 37
1623:             .Buttons(2).AutoSize  = .T.
1624:         ENDWITH
1625: 
1626:         *-- Bloqueia Alt. Data (blqadts)
1627:         par_oPg.AddObject("lbl_4c_BlqAdts", "Label")
1628:         WITH par_oPg.lbl_4c_BlqAdts
1629:             .FontName  = "Tahoma"
1630:             .FontSize  = 8
1631:             .Caption   = "Bloqueia Alt. Data :"
1632:             .Top       = 25
1633:             .Left      = 79
1634:             .Width     = 95
1635:             .Height    = 15
1636:             .ForeColor = RGB(90, 90, 90)
1637:             .BackStyle = 0
1638:             .AutoSize  = .F.
1639:             .Visible   = .T.
1640:         ENDWITH
1641: 
1642:         par_oPg.AddObject("opt_4c_Blqadts", "OptionGroup")
1643:         WITH par_oPg.opt_4c_Blqadts
1644:             .ButtonCount = 2
1645:             .AutoSize    = .F.
1646:             .BackStyle   = 0
1647:             .BorderStyle = 0
1648:             .Height      = 20
1649:             .Left        = 173
1650:             .Top         = 21
1651:             .Width       = 86
1652:             .Value       = 2
1653:             .Visible     = .T.
1654:             .Buttons(1).Caption   = "Sim"
1655:             .Buttons(1).FontSize  = 8
1656:             .Buttons(1).BackStyle = 0
1657:             .Buttons(1).Left      = 5
1658:             .Buttons(1).Top       = 3
1659:             .Buttons(1).Width     = 34
1660:             .Buttons(1).AutoSize  = .T.
1661:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1662:             .Buttons(2).FontSize  = 8
1663:             .Buttons(2).BackStyle = 0
1664:             .Buttons(2).Left      = 45
1665:             .Buttons(2).Top       = 3
1666:             .Buttons(2).Width     = 37
1667:             .Buttons(2).AutoSize  = .T.
1668:         ENDWITH
1669: 
1670:         *-- Inibir Botao Ocorrencia (inibocors)
1671:         par_oPg.AddObject("lbl_4c_InibOcors", "Label")
1672:         WITH par_oPg.lbl_4c_InibOcors
1673:             .FontName  = "Tahoma"
1674:             .FontSize  = 8
1675:             .Caption   = "Inibir Bot" + CHR(227) + "o Ocorr" + CHR(234) + "ncia :"
1676:             .Top       = 44
1677:             .Left      = 55
1678:             .Width     = 119
1679:             .Height    = 15
1680:             .ForeColor = RGB(90, 90, 90)
1681:             .BackStyle = 0
1682:             .AutoSize  = .F.
1683:             .Visible   = .T.
1684:         ENDWITH
1685: 
1686:         par_oPg.AddObject("opt_4c_Inibocors", "OptionGroup")
1687:         WITH par_oPg.opt_4c_Inibocors
1688:             .ButtonCount = 2
1689:             .AutoSize    = .F.
1690:             .BackStyle   = 0
1691:             .BorderStyle = 0
1692:             .Height      = 20
1693:             .Left        = 173
1694:             .Top         = 40
1695:             .Width       = 86
1696:             .Value       = 2
1697:             .Visible     = .T.
1698:             .Buttons(1).Caption   = "Sim"
1699:             .Buttons(1).FontSize  = 8
1700:             .Buttons(1).BackStyle = 0
1701:             .Buttons(1).Left      = 5
1702:             .Buttons(1).Top       = 3
1703:             .Buttons(1).Width     = 34
1704:             .Buttons(1).AutoSize  = .T.
1705:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1706:             .Buttons(2).FontSize  = 8
1707:             .Buttons(2).BackStyle = 0
1708:             .Buttons(2).Left      = 45
1709:             .Buttons(2).Top       = 3
1710:             .Buttons(2).Width     = 37
1711:             .Buttons(2).AutoSize  = .T.
1712:         ENDWITH
1713: 
1714:         *-- Inibir Botao Fechamento (inibfecs)
1715:         par_oPg.AddObject("lbl_4c_InibFecs", "Label")
1716:         WITH par_oPg.lbl_4c_InibFecs
1717:             .FontName  = "Tahoma"
1718:             .FontSize  = 8
1719:             .Caption   = "Inibir Bot" + CHR(227) + "o Fechamento :"
1720:             .Top       = 63
1721:             .Left      = 48
1722:             .Width     = 126
1723:             .Height    = 15
1724:             .ForeColor = RGB(90, 90, 90)
1725:             .BackStyle = 0
1726:             .AutoSize  = .F.
1727:             .Visible   = .T.
1728:         ENDWITH
1729: 
1730:         par_oPg.AddObject("opt_4c_Inibfecs", "OptionGroup")
1731:         WITH par_oPg.opt_4c_Inibfecs
1732:             .ButtonCount = 2
1733:             .AutoSize    = .F.
1734:             .BackStyle   = 0
1735:             .BorderStyle = 0
1736:             .Height      = 20
1737:             .Left        = 173
1738:             .Top         = 59
1739:             .Width       = 86
1740:             .Value       = 2
1741:             .Visible     = .T.
1742:             .Buttons(1).Caption   = "Sim"
1743:             .Buttons(1).FontSize  = 8
1744:             .Buttons(1).BackStyle = 0
1745:             .Buttons(1).Left      = 5
1746:             .Buttons(1).Top       = 3
1747:             .Buttons(1).Width     = 34
1748:             .Buttons(1).AutoSize  = .T.
1749:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1750:             .Buttons(2).FontSize  = 8
1751:             .Buttons(2).BackStyle = 0
1752:             .Buttons(2).Left      = 45
1753:             .Buttons(2).Top       = 3
1754:             .Buttons(2).Width     = 37
1755:             .Buttons(2).AutoSize  = .T.
1756:         ENDWITH
1757: 
1758:         *-- Permitir Alteracao (alterar)
1759:         par_oPg.AddObject("lbl_4c_Alterar", "Label")
1760:         WITH par_oPg.lbl_4c_Alterar
1761:             .FontName  = "Tahoma"
1762:             .FontSize  = 8
1763:             .Caption   = "Permitir Altera" + CHR(231) + CHR(227) + "o :"
1764:             .Top       = 82
1765:             .Left      = 80
1766:             .Width     = 94
1767:             .Height    = 15
1768:             .ForeColor = RGB(90, 90, 90)
1769:             .BackStyle = 0
1770:             .AutoSize  = .F.
1771:             .Visible   = .T.
1772:         ENDWITH
1773: 
1774:         par_oPg.AddObject("opt_4c_Alterar", "OptionGroup")
1775:         WITH par_oPg.opt_4c_Alterar
1776:             .ButtonCount = 2
1777:             .AutoSize    = .F.
1778:             .BackStyle   = 0
1779:             .BorderStyle = 0
1780:             .Height      = 20
1781:             .Left        = 173
1782:             .Top         = 78
1783:             .Width       = 86
1784:             .Value       = 2
1785:             .Visible     = .T.
1786:             .Buttons(1).Caption   = "Sim"
1787:             .Buttons(1).FontSize  = 8
1788:             .Buttons(1).BackStyle = 0
1789:             .Buttons(1).Left      = 5
1790:             .Buttons(1).Top       = 3
1791:             .Buttons(1).Width     = 34
1792:             .Buttons(1).AutoSize  = .T.
1793:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1794:             .Buttons(2).FontSize  = 8
1795:             .Buttons(2).BackStyle = 0
1796:             .Buttons(2).Left      = 45
1797:             .Buttons(2).Top       = 3
1798:             .Buttons(2).Width     = 37
1799:             .Buttons(2).AutoSize  = .T.
1800:         ENDWITH
1801: 
1802:         *-- Utiliza Periodo Configuracao (periodos)
1803:         par_oPg.AddObject("lbl_4c_Periodos", "Label")
1804:         WITH par_oPg.lbl_4c_Periodos
1805:             .FontName  = "Tahoma"
1806:             .FontSize  = 8
1807:             .Caption   = "Utiliza Per" + CHR(237) + "odo Configura" + CHR(231) + CHR(227) + "o :"
1808:             .Top       = 101
1809:             .Left      = 31
1810:             .Width     = 143
1811:             .Height    = 15
1812:             .ForeColor = RGB(90, 90, 90)
1813:             .BackStyle = 0
1814:             .AutoSize  = .F.
1815:             .Visible   = .T.
1816:         ENDWITH
1817: 
1818:         par_oPg.AddObject("opt_4c_Periodos", "OptionGroup")
1819:         WITH par_oPg.opt_4c_Periodos
1820:             .ButtonCount = 2
1821:             .AutoSize    = .F.
1822:             .BackStyle   = 0
1823:             .BorderStyle = 0
1824:             .Height      = 20
1825:             .Left        = 173
1826:             .Top         = 97
1827:             .Width       = 86
1828:             .Value       = 2
1829:             .Visible     = .T.
1830:             .Buttons(1).Caption   = "Sim"
1831:             .Buttons(1).FontSize  = 8
1832:             .Buttons(1).BackStyle = 0
1833:             .Buttons(1).Left      = 5
1834:             .Buttons(1).Top       = 3
1835:             .Buttons(1).Width     = 34
1836:             .Buttons(1).AutoSize  = .T.
1837:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1838:             .Buttons(2).FontSize  = 8
1839:             .Buttons(2).BackStyle = 0
1840:             .Buttons(2).Left      = 45
1841:             .Buttons(2).Top       = 3
1842:             .Buttons(2).Width     = 37
1843:             .Buttons(2).AutoSize  = .T.
1844:         ENDWITH
1845: 
1846:         *-- Utiliza Periodo Entrega (entregas)
1847:         par_oPg.AddObject("lbl_4c_Entregas", "Label")
1848:         WITH par_oPg.lbl_4c_Entregas
1849:             .FontName  = "Tahoma"
1850:             .FontSize  = 8
1851:             .Caption   = "Utiliza Per" + CHR(237) + "odo Entrega :"
1852:             .Top       = 121
1853:             .Left      = 57
1854:             .Width     = 117
1855:             .Height    = 15
1856:             .ForeColor = RGB(90, 90, 90)
1857:             .BackStyle = 0
1858:             .AutoSize  = .F.
1859:             .Visible   = .T.
1860:         ENDWITH
1861: 
1862:         par_oPg.AddObject("opt_4c_Entregas", "OptionGroup")
1863:         WITH par_oPg.opt_4c_Entregas
1864:             .ButtonCount = 2
1865:             .AutoSize    = .F.
1866:             .BackStyle   = 0
1867:             .BorderStyle = 0
1868:             .Height      = 20
1869:             .Left        = 173
1870:             .Top         = 117
1871:             .Width       = 86
1872:             .Value       = 2
1873:             .Visible     = .T.
1874:             .Buttons(1).Caption   = "Sim"
1875:             .Buttons(1).FontSize  = 8
1876:             .Buttons(1).BackStyle = 0
1877:             .Buttons(1).Left      = 5
1878:             .Buttons(1).Top       = 3
1879:             .Buttons(1).Width     = 34
1880:             .Buttons(1).AutoSize  = .T.
1881:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1882:             .Buttons(2).FontSize  = 8
1883:             .Buttons(2).BackStyle = 0
1884:             .Buttons(2).Left      = 45
1885:             .Buttons(2).Top       = 3
1886:             .Buttons(2).Width     = 37
1887:             .Buttons(2).AutoSize  = .T.
1888:         ENDWITH
1889: 
1890:         *-- Utiliza Periodo Operacao (operacoes)
1891:         par_oPg.AddObject("lbl_4c_Operacoes", "Label")
1892:         WITH par_oPg.lbl_4c_Operacoes
1893:             .FontName  = "Tahoma"
1894:             .FontSize  = 8
1895:             .Caption   = "Utiliza Per" + CHR(237) + "odo Opera" + CHR(231) + CHR(227) + "o :"
1896:             .Top       = 140
1897:             .Left      = 48
1898:             .Width     = 126
1899:             .Height    = 15
1900:             .ForeColor = RGB(90, 90, 90)
1901:             .BackStyle = 0
1902:             .AutoSize  = .F.
1903:             .Visible   = .T.
1904:         ENDWITH
1905: 
1906:         par_oPg.AddObject("opt_4c_Operacoes", "OptionGroup")
1907:         WITH par_oPg.opt_4c_Operacoes
1908:             .ButtonCount = 2
1909:             .AutoSize    = .F.
1910:             .BackStyle   = 0
1911:             .BorderStyle = 0
1912:             .Height      = 20
1913:             .Left        = 173
1914:             .Top         = 136
1915:             .Width       = 86
1916:             .Value       = 2
1917:             .Visible     = .T.
1918:             .Buttons(1).Caption   = "Sim"
1919:             .Buttons(1).FontSize  = 8
1920:             .Buttons(1).BackStyle = 0
1921:             .Buttons(1).Left      = 5
1922:             .Buttons(1).Top       = 3
1923:             .Buttons(1).Width     = 34
1924:             .Buttons(1).AutoSize  = .T.
1925:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1926:             .Buttons(2).FontSize  = 8
1927:             .Buttons(2).BackStyle = 0
1928:             .Buttons(2).Left      = 45
1929:             .Buttons(2).Top       = 3
1930:             .Buttons(2).Width     = 37
1931:             .Buttons(2).AutoSize  = .T.
1932:         ENDWITH
1933: 
1934:         *-- Senha por Responsavel (vends)
1935:         par_oPg.AddObject("lbl_4c_Vends", "Label")
1936:         WITH par_oPg.lbl_4c_Vends
1937:             .FontName  = "Tahoma"
1938:             .FontSize  = 8
1939:             .Caption   = "Senha por Respons" + CHR(225) + "vel :"
1940:             .Top       = 159
1941:             .Left      = 52
1942:             .Width     = 122
1943:             .Height    = 15
1944:             .ForeColor = RGB(90, 90, 90)
1945:             .BackStyle = 0
1946:             .AutoSize  = .F.
1947:             .Visible   = .T.
1948:         ENDWITH
1949: 
1950:         par_oPg.AddObject("opt_4c_Vends", "OptionGroup")
1951:         WITH par_oPg.opt_4c_Vends
1952:             .ButtonCount = 2
1953:             .AutoSize    = .F.
1954:             .BackStyle   = 0
1955:             .BorderStyle = 0
1956:             .Height      = 20
1957:             .Left        = 173
1958:             .Top         = 155
1959:             .Width       = 86
1960:             .Value       = 2
1961:             .Visible     = .T.
1962:             .Buttons(1).Caption   = "Sim"
1963:             .Buttons(1).FontSize  = 8
1964:             .Buttons(1).BackStyle = 0
1965:             .Buttons(1).Left      = 5
1966:             .Buttons(1).Top       = 3
1967:             .Buttons(1).Width     = 34
1968:             .Buttons(1).AutoSize  = .T.
1969:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1970:             .Buttons(2).FontSize  = 8
1971:             .Buttons(2).BackStyle = 0
1972:             .Buttons(2).Left      = 45
1973:             .Buttons(2).Top       = 3
1974:             .Buttons(2).Width     = 37
1975:             .Buttons(2).AutoSize  = .T.
1976:         ENDWITH
1977: 
1978:         *-- Checar SAC (sacs)
1979:         par_oPg.AddObject("lbl_4c_Sacs", "Label")
1980:         WITH par_oPg.lbl_4c_Sacs
1981:             .FontName  = "Tahoma"
1982:             .FontSize  = 8
1983:             .Caption   = "Checar SAC :"
1984:             .Top       = 178
1985:             .Left      = 108
1986:             .Width     = 66
1987:             .Height    = 15
1988:             .ForeColor = RGB(90, 90, 90)
1989:             .BackStyle = 0
1990:             .AutoSize  = .F.
1991:             .Visible   = .T.
1992:         ENDWITH
1993: 
1994:         par_oPg.AddObject("opt_4c_Sacs", "OptionGroup")
1995:         WITH par_oPg.opt_4c_Sacs
1996:             .ButtonCount = 2
1997:             .AutoSize    = .F.
1998:             .BackStyle   = 0
1999:             .BorderStyle = 0
2000:             .Height      = 20
2001:             .Left        = 173
2002:             .Top         = 174
2003:             .Width       = 86
2004:             .Value       = 2
2005:             .Visible     = .T.
2006:             .Buttons(1).Caption   = "Sim"
2007:             .Buttons(1).FontSize  = 8
2008:             .Buttons(1).BackStyle = 0
2009:             .Buttons(1).Left      = 5
2010:             .Buttons(1).Top       = 3
2011:             .Buttons(1).Width     = 34
2012:             .Buttons(1).AutoSize  = .T.
2013:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2014:             .Buttons(2).FontSize  = 8
2015:             .Buttons(2).BackStyle = 0
2016:             .Buttons(2).Left      = 45
2017:             .Buttons(2).Top       = 3
2018:             .Buttons(2).Width     = 37
2019:             .Buttons(2).AutoSize  = .T.
2020:         ENDWITH
2021: 
2022:         *-- Utiliza Empresa (empresas)
2023:         par_oPg.AddObject("lbl_4c_Empresas", "Label")
2024:         WITH par_oPg.lbl_4c_Empresas
2025:             .FontName  = "Tahoma"
2026:             .FontSize  = 8
2027:             .Caption   = "Utiliza Empresa :"
2028:             .Top       = 198
2029:             .Left      = 93
2030:             .Width     = 81
2031:             .Height    = 15
2032:             .ForeColor = RGB(90, 90, 90)
2033:             .BackStyle = 0
2034:             .AutoSize  = .F.
2035:             .Visible   = .T.
2036:         ENDWITH
2037: 
2038:         par_oPg.AddObject("opt_4c_Empresas", "OptionGroup")
2039:         WITH par_oPg.opt_4c_Empresas
2040:             .ButtonCount = 2
2041:             .AutoSize    = .F.
2042:             .BackStyle   = 0
2043:             .BorderStyle = 0
2044:             .Height      = 20
2045:             .Left        = 173
2046:             .Top         = 193
2047:             .Width       = 86
2048:             .Value       = 2
2049:             .Visible     = .T.
2050:             .Buttons(1).Caption   = "Sim"
2051:             .Buttons(1).FontSize  = 8
2052:             .Buttons(1).BackStyle = 0
2053:             .Buttons(1).Left      = 5
2054:             .Buttons(1).Top       = 3
2055:             .Buttons(1).Width     = 34
2056:             .Buttons(1).AutoSize  = .T.
2057:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2058:             .Buttons(2).FontSize  = 8
2059:             .Buttons(2).BackStyle = 0
2060:             .Buttons(2).Left      = 45
2061:             .Buttons(2).Top       = 3
2062:             .Buttons(2).Width     = 37
2063:             .Buttons(2).AutoSize  = .T.
2064:         ENDWITH
2065: 
2066:         *-- Controlar Acesso por Usuario (ctacusus)
2067:         par_oPg.AddObject("lbl_4c_Ctacusus", "Label")
2068:         WITH par_oPg.lbl_4c_Ctacusus
2069:             .FontName  = "Tahoma"
2070:             .FontSize  = 8
2071:             .Caption   = "Controlar Acesso por Usu" + CHR(225) + "rio :"
2072:             .Top       = 217
2073:             .Left      = 25
2074:             .Width     = 149
2075:             .Height    = 15
2076:             .ForeColor = RGB(90, 90, 90)
2077:             .BackStyle = 0
2078:             .AutoSize  = .F.
2079:             .Visible   = .T.
2080:         ENDWITH
2081: 
2082:         par_oPg.AddObject("opt_4c_Ctacusus", "OptionGroup")
2083:         WITH par_oPg.opt_4c_Ctacusus
2084:             .ButtonCount = 2
2085:             .AutoSize    = .F.
2086:             .BackStyle   = 0
2087:             .BorderStyle = 0
2088:             .Height      = 20
2089:             .Left        = 173
2090:             .Top         = 214
2091:             .Width       = 86
2092:             .Value       = 2
2093:             .Visible     = .T.
2094:             .Buttons(1).Caption   = "Sim"
2095:             .Buttons(1).FontSize  = 8
2096:             .Buttons(1).BackStyle = 0
2097:             .Buttons(1).Left      = 4
2098:             .Buttons(1).Top       = 2
2099:             .Buttons(1).AutoSize  = .T.
2100:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2101:             .Buttons(2).FontSize  = 8
2102:             .Buttons(2).BackStyle = 0
2103:             .Buttons(2).Left      = 43
2104:             .Buttons(2).Top       = 2
2105:             .Buttons(2).AutoSize  = .T.
2106:         ENDWITH
2107: 
2108:         *-- SECAO "Padrao de Configuracao" - header Bold
2109:         par_oPg.AddObject("lbl_4c_PadrConf", "Label")
2110:         WITH par_oPg.lbl_4c_PadrConf
2111:             .FontName  = "Tahoma"
2112:             .FontSize  = 8
2113:             .FontBold  = .T.
2114:             .Caption   = " Padr" + CHR(227) + "o de Configura" + CHR(231) + CHR(227) + "o "
2115:             .Top       = 247
2116:             .Left      = 7
2117:             .Width     = 142
2118:             .Height    = 15
2119:             .ForeColor = RGB(90, 90, 90)
2120:             .BackStyle = 0
2121:             .AutoSize  = .F.
2122:             .Visible   = .T.
2123:         ENDWITH
2124: 
2125:         *-- OptionGroups para filtro de operacoes (Left=3, Width=216)
2126:         par_oPg.AddObject("opt_4c_Oppends", "OptionGroup")
2127:         WITH par_oPg.opt_4c_Oppends
2128:             .ButtonCount = 3
2129:             .AutoSize    = .F.
2130:             .BackStyle   = 0
2131:             .BorderStyle = 0
2132:             .Height      = 22
2133:             .Left        = 3
2134:             .Top         = 261
2135:             .Width       = 216
2136:             .Value       = 1
2137:             .Visible     = .T.
2138:             .Buttons(1).Caption   = "Todas"
2139:             .Buttons(1).FontSize  = 8
2140:             .Buttons(1).BackStyle = 0
2141:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2142:             .Buttons(1).Left      = 5
2143:             .Buttons(1).Top       = 3
2144:             .Buttons(1).Width     = 47
2145:             .Buttons(1).AutoSize  = .T.
2146:             .Buttons(2).Caption   = "Pendentes"
2147:             .Buttons(2).FontSize  = 8
2148:             .Buttons(2).BackStyle = 0
2149:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2150:             .Buttons(2).Left      = 57
2151:             .Buttons(2).Top       = 3
2152:             .Buttons(2).Width     = 69
2153:             .Buttons(2).AutoSize  = .T.
2154:             .Buttons(3).Caption   = "Baixadas"
2155:             .Buttons(3).FontSize  = 8
2156:             .Buttons(3).BackStyle = 0
2157:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2158:             .Buttons(3).Left      = 140
2159:             .Buttons(3).Top       = 3
2160:             .Buttons(3).Width     = 61
2161:             .Buttons(3).AutoSize  = .T.
2162:         ENDWITH
2163: 
2164:         par_oPg.AddObject("opt_4c_Opagends", "OptionGroup")
2165:         WITH par_oPg.opt_4c_Opagends
2166:             .ButtonCount = 3
2167:             .AutoSize    = .F.
2168:             .BackStyle   = 0
2169:             .BorderStyle = 0
2170:             .Height      = 22
2171:             .Left        = 3
2172:             .Top         = 278
2173:             .Width       = 216
2174:             .Value       = 1
2175:             .Visible     = .T.
2176:             .Buttons(1).Caption   = "Todas"
2177:             .Buttons(1).FontSize  = 8
2178:             .Buttons(1).BackStyle = 0
2179:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2180:             .Buttons(1).Left      = 5
2181:             .Buttons(1).Top       = 3
2182:             .Buttons(1).Width     = 47
2183:             .Buttons(1).AutoSize  = .T.
2184:             .Buttons(2).Caption   = "N" + CHR(227) + "o Agendadas"
2185:             .Buttons(2).FontSize  = 8
2186:             .Buttons(2).BackStyle = 0
2187:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2188:             .Buttons(2).Left      = 57
2189:             .Buttons(2).Top       = 3
2190:             .Buttons(2).Width     = 82
2191:             .Buttons(2).AutoSize  = .T.
2192:             .Buttons(3).Caption   = "Agendadas"
2193:             .Buttons(3).FontSize  = 8
2194:             .Buttons(3).BackStyle = 0
2195:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2196:             .Buttons(3).Left      = 140
2197:             .Buttons(3).Top       = 3
2198:             .Buttons(3).Width     = 72
2199:             .Buttons(3).AutoSize  = .T.
2200:         ENDWITH
2201: 
2202:         par_oPg.AddObject("opt_4c_Oppagas", "OptionGroup")
2203:         WITH par_oPg.opt_4c_Oppagas
2204:             .ButtonCount = 3
2205:             .AutoSize    = .F.
2206:             .BackStyle   = 0
2207:             .BorderStyle = 0
2208:             .Height      = 22
2209:             .Left        = 3
2210:             .Top         = 296
2211:             .Width       = 216
2212:             .Value       = 1
2213:             .Visible     = .T.
2214:             .Buttons(1).Caption   = "Todas"
2215:             .Buttons(1).FontSize  = 8
2216:             .Buttons(1).BackStyle = 0
2217:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2218:             .Buttons(1).Left      = 5
2219:             .Buttons(1).Top       = 3
2220:             .Buttons(1).Width     = 47
2221:             .Buttons(1).AutoSize  = .T.
2222:             .Buttons(2).Caption   = "N" + CHR(227) + "o Pagas"
2223:             .Buttons(2).FontSize  = 8
2224:             .Buttons(2).BackStyle = 0
2225:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2226:             .Buttons(2).Left      = 57
2227:             .Buttons(2).Top       = 3
2228:             .Buttons(2).Width     = 57
2229:             .Buttons(2).AutoSize  = .T.
2230:             .Buttons(3).Caption   = "Pagas"
2231:             .Buttons(3).FontSize  = 8
2232:             .Buttons(3).BackStyle = 0
2233:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2234:             .Buttons(3).Left      = 140
2235:             .Buttons(3).Top       = 3
2236:             .Buttons(3).Width     = 47
2237:             .Buttons(3).AutoSize  = .T.
2238:         ENDWITH
2239: 
2240:         *-- CheckBoxes para travar ordenacao (Fixa*)
2241:         par_oPg.AddObject("chk_4c_Fixaps", "CheckBox")
2242:         WITH par_oPg.chk_4c_Fixaps

*-- Linhas 2454 a 2911:
2454:             .Visible       = .T.
2455:         ENDWITH
2456: 
2457:         *-- COLUNA DIREITA: OptionGroups Sim/Nao (Left=431, Width=86)
2458: 
2459:         *-- Analisar C.Pagto Fx.Cx (anacps)
2460:         par_oPg.AddObject("lbl_4c_Anacps", "Label")
2461:         WITH par_oPg.lbl_4c_Anacps
2462:             .FontName  = "Tahoma"
2463:             .FontSize  = 8
2464:             .Caption   = "Analisar C.Pagto Fx. Cx :"
2465:             .Top       = 7
2466:             .Left      = 310
2467:             .Width     = 124
2468:             .Height    = 15
2469:             .ForeColor = RGB(90, 90, 90)
2470:             .BackStyle = 0
2471:             .AutoSize  = .F.
2472:             .Visible   = .T.
2473:         ENDWITH
2474: 
2475:         par_oPg.AddObject("opt_4c_Anacps", "OptionGroup")
2476:         WITH par_oPg.opt_4c_Anacps
2477:             .ButtonCount = 2
2478:             .AutoSize    = .F.
2479:             .BackStyle   = 0
2480:             .BorderStyle = 0
2481:             .Height      = 20
2482:             .Left        = 431
2483:             .Top         = 3
2484:             .Width       = 86
2485:             .Value       = 2
2486:             .Visible     = .T.
2487:             .Buttons(1).Caption   = "Sim"
2488:             .Buttons(1).FontSize  = 8
2489:             .Buttons(1).BackStyle = 0
2490:             .Buttons(1).Left      = 5
2491:             .Buttons(1).Top       = 3
2492:             .Buttons(1).Width     = 34
2493:             .Buttons(1).AutoSize  = .T.
2494:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2495:             .Buttons(2).FontSize  = 8
2496:             .Buttons(2).BackStyle = 0
2497:             .Buttons(2).Left      = 45
2498:             .Buttons(2).Top       = 3
2499:             .Buttons(2).Width     = 37
2500:             .Buttons(2).AutoSize  = .T.
2501:         ENDWITH
2502: 
2503:         *-- Gera Controle de Volumes / ChkReserva (chkreserva)
2504:         par_oPg.AddObject("lbl_4c_Chkreserva", "Label")
2505:         WITH par_oPg.lbl_4c_Chkreserva
2506:             .FontName  = "Tahoma"
2507:             .FontSize  = 8
2508:             .Caption   = "Gera Controle de Volumes :"
2509:             .Top       = 26
2510:             .Left      = 301
2511:             .Width     = 133
2512:             .Height    = 15
2513:             .ForeColor = RGB(90, 90, 90)
2514:             .BackStyle = 0
2515:             .AutoSize  = .F.
2516:             .Visible   = .T.
2517:         ENDWITH
2518: 
2519:         par_oPg.AddObject("opt_4c_Chkreserva", "OptionGroup")
2520:         WITH par_oPg.opt_4c_Chkreserva
2521:             .ButtonCount = 2
2522:             .AutoSize    = .F.
2523:             .BackStyle   = 0
2524:             .BorderStyle = 0
2525:             .Height      = 20
2526:             .Left        = 431
2527:             .Top         = 22
2528:             .Width       = 86
2529:             .Value       = 2
2530:             .Visible     = .T.
2531:             .Buttons(1).Caption   = "Sim"
2532:             .Buttons(1).FontSize  = 8
2533:             .Buttons(1).BackStyle = 0
2534:             .Buttons(1).Left      = 5
2535:             .Buttons(1).Top       = 3
2536:             .Buttons(1).Width     = 34
2537:             .Buttons(1).AutoSize  = .T.
2538:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2539:             .Buttons(2).FontSize  = 8
2540:             .Buttons(2).BackStyle = 0
2541:             .Buttons(2).Left      = 45
2542:             .Buttons(2).Top       = 3
2543:             .Buttons(2).Width     = 37
2544:             .Buttons(2).AutoSize  = .T.
2545:         ENDWITH
2546: 
2547:         *-- Utiliza Responsavel (resps)
2548:         par_oPg.AddObject("lbl_4c_Resps", "Label")
2549:         WITH par_oPg.lbl_4c_Resps
2550:             .FontName  = "Tahoma"
2551:             .FontSize  = 8
2552:             .Caption   = "Utiliza Respons" + CHR(225) + "vel :"
2553:             .Top       = 45
2554:             .Left      = 333
2555:             .Width     = 101
2556:             .Height    = 15
2557:             .ForeColor = RGB(90, 90, 90)
2558:             .BackStyle = 0
2559:             .AutoSize  = .F.
2560:             .Visible   = .T.
2561:         ENDWITH
2562: 
2563:         par_oPg.AddObject("opt_4c_Resps", "OptionGroup")
2564:         WITH par_oPg.opt_4c_Resps
2565:             .ButtonCount = 2
2566:             .AutoSize    = .F.
2567:             .BackStyle   = 0
2568:             .BorderStyle = 0
2569:             .Height      = 20
2570:             .Left        = 431
2571:             .Top         = 41
2572:             .Width       = 86
2573:             .Value       = 2
2574:             .Visible     = .T.
2575:             .Buttons(1).Caption   = "Sim"
2576:             .Buttons(1).FontSize  = 8
2577:             .Buttons(1).BackStyle = 0
2578:             .Buttons(1).Left      = 5
2579:             .Buttons(1).Top       = 3
2580:             .Buttons(1).Width     = 34
2581:             .Buttons(1).AutoSize  = .T.
2582:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2583:             .Buttons(2).FontSize  = 8
2584:             .Buttons(2).BackStyle = 0
2585:             .Buttons(2).Left      = 45
2586:             .Buttons(2).Top       = 3
2587:             .Buttons(2).Width     = 37
2588:             .Buttons(2).AutoSize  = .T.
2589:         ENDWITH
2590: 
2591:         *-- Estoque Disponivel (estdisps)
2592:         par_oPg.AddObject("lbl_4c_Estdisps", "Label")
2593:         WITH par_oPg.lbl_4c_Estdisps
2594:             .FontName  = "Tahoma"
2595:             .FontSize  = 8
2596:             .Caption   = "Estoque Dispon" + CHR(237) + "vel :"
2597:             .Top       = 64
2598:             .Left      = 335
2599:             .Width     = 99
2600:             .Height    = 15
2601:             .ForeColor = RGB(90, 90, 90)
2602:             .BackStyle = 0
2603:             .AutoSize  = .F.
2604:             .Visible   = .T.
2605:         ENDWITH
2606: 
2607:         par_oPg.AddObject("opt_4c_Estdisps", "OptionGroup")
2608:         WITH par_oPg.opt_4c_Estdisps
2609:             .ButtonCount = 2
2610:             .AutoSize    = .F.
2611:             .BackStyle   = 0
2612:             .BorderStyle = 0
2613:             .Height      = 20
2614:             .Left        = 431
2615:             .Top         = 60
2616:             .Width       = 86
2617:             .Value       = 2
2618:             .Visible     = .T.
2619:             .Buttons(1).Caption   = "Sim"
2620:             .Buttons(1).FontSize  = 8
2621:             .Buttons(1).BackStyle = 0
2622:             .Buttons(1).Left      = 5
2623:             .Buttons(1).Top       = 3
2624:             .Buttons(1).Width     = 34
2625:             .Buttons(1).AutoSize  = .T.
2626:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2627:             .Buttons(2).FontSize  = 8
2628:             .Buttons(2).BackStyle = 0
2629:             .Buttons(2).Left      = 45
2630:             .Buttons(2).Top       = 3
2631:             .Buttons(2).Width     = 37
2632:             .Buttons(2).AutoSize  = .T.
2633:         ENDWITH
2634: 
2635:         *-- Quantidade de Volumes (volumes)
2636:         par_oPg.AddObject("lbl_4c_Volumes", "Label")
2637:         WITH par_oPg.lbl_4c_Volumes
2638:             .FontName  = "Tahoma"
2639:             .FontSize  = 8
2640:             .Caption   = "Quantidade de Volumes :"
2641:             .Top       = 83
2642:             .Left      = 312
2643:             .Width     = 122
2644:             .Height    = 15
2645:             .ForeColor = RGB(90, 90, 90)
2646:             .BackStyle = 0
2647:             .AutoSize  = .F.
2648:             .Visible   = .T.
2649:         ENDWITH
2650: 
2651:         par_oPg.AddObject("opt_4c_Volumes", "OptionGroup")
2652:         WITH par_oPg.opt_4c_Volumes
2653:             .ButtonCount = 2
2654:             .AutoSize    = .F.
2655:             .BackStyle   = 0
2656:             .BorderStyle = 0
2657:             .Height      = 20
2658:             .Left        = 431
2659:             .Top         = 79
2660:             .Width       = 86
2661:             .Value       = 2
2662:             .Visible     = .T.
2663:             .Buttons(1).Caption   = "Sim"
2664:             .Buttons(1).FontSize  = 8
2665:             .Buttons(1).BackStyle = 0
2666:             .Buttons(1).Left      = 5
2667:             .Buttons(1).Top       = 3
2668:             .Buttons(1).Width     = 34
2669:             .Buttons(1).AutoSize  = .T.
2670:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2671:             .Buttons(2).FontSize  = 8
2672:             .Buttons(2).BackStyle = 0
2673:             .Buttons(2).Left      = 45
2674:             .Buttons(2).Top       = 3
2675:             .Buttons(2).Width     = 37
2676:             .Buttons(2).AutoSize  = .T.
2677:         ENDWITH
2678: 
2679:         *-- Checa Acesso Muda Empresa (acmemps)
2680:         par_oPg.AddObject("lbl_4c_Acmemps", "Label")
2681:         WITH par_oPg.lbl_4c_Acmemps
2682:             .FontName  = "Tahoma"
2683:             .FontSize  = 8
2684:             .Caption   = "Checa Acesso Muda Empresa :"
2685:             .Top       = 103
2686:             .Left      = 285
2687:             .Width     = 149
2688:             .Height    = 15
2689:             .ForeColor = RGB(90, 90, 90)
2690:             .BackStyle = 0
2691:             .AutoSize  = .F.
2692:             .Visible   = .T.
2693:         ENDWITH
2694: 
2695:         par_oPg.AddObject("opt_4c_Acmemps", "OptionGroup")
2696:         WITH par_oPg.opt_4c_Acmemps
2697:             .ButtonCount = 2
2698:             .AutoSize    = .F.
2699:             .BackStyle   = 0
2700:             .BorderStyle = 0
2701:             .Height      = 20
2702:             .Left        = 431
2703:             .Top         = 99
2704:             .Width       = 86
2705:             .Value       = 2
2706:             .Visible     = .T.
2707:             .Buttons(1).Caption   = "Sim"
2708:             .Buttons(1).FontSize  = 8
2709:             .Buttons(1).BackStyle = 0
2710:             .Buttons(1).Left      = 5
2711:             .Buttons(1).Top       = 3
2712:             .Buttons(1).Width     = 34
2713:             .Buttons(1).AutoSize  = .T.
2714:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2715:             .Buttons(2).FontSize  = 8
2716:             .Buttons(2).BackStyle = 0
2717:             .Buttons(2).Left      = 45
2718:             .Buttons(2).Top       = 3
2719:             .Buttons(2).Width     = 37
2720:             .Buttons(2).AutoSize  = .T.
2721:         ENDWITH
2722: 
2723:         *-- Solicita Senha Responsavel (senresps)
2724:         par_oPg.AddObject("lbl_4c_Senresps", "Label")
2725:         WITH par_oPg.lbl_4c_Senresps
2726:             .FontName  = "Tahoma"
2727:             .FontSize  = 8
2728:             .Caption   = "Solicita Senha Respons" + CHR(225) + "vel :"
2729:             .Top       = 122
2730:             .Left      = 295
2731:             .Width     = 139
2732:             .Height    = 15
2733:             .ForeColor = RGB(90, 90, 90)
2734:             .BackStyle = 0
2735:             .AutoSize  = .F.
2736:             .Visible   = .T.
2737:         ENDWITH
2738: 
2739:         par_oPg.AddObject("opt_4c_Senresps", "OptionGroup")
2740:         WITH par_oPg.opt_4c_Senresps
2741:             .ButtonCount = 2
2742:             .AutoSize    = .F.
2743:             .BackStyle   = 0
2744:             .BorderStyle = 0
2745:             .Height      = 20
2746:             .Left        = 431
2747:             .Top         = 118
2748:             .Width       = 86
2749:             .Value       = 1
2750:             .Visible     = .T.
2751:             .Buttons(1).Caption   = "Sim"
2752:             .Buttons(1).FontSize  = 8
2753:             .Buttons(1).BackStyle = 0
2754:             .Buttons(1).Left      = 5
2755:             .Buttons(1).Top       = 3
2756:             .Buttons(1).Width     = 34
2757:             .Buttons(1).AutoSize  = .T.
2758:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2759:             .Buttons(2).FontSize  = 8
2760:             .Buttons(2).BackStyle = 0
2761:             .Buttons(2).Left      = 45
2762:             .Buttons(2).Top       = 3
2763:             .Buttons(2).Width     = 37
2764:             .Buttons(2).AutoSize  = .T.
2765:         ENDWITH
2766: 
2767:         *-- Checar Data de Entrega (chdtentrs)
2768:         par_oPg.AddObject("lbl_4c_Chdtentrs", "Label")
2769:         WITH par_oPg.lbl_4c_Chdtentrs
2770:             .FontName  = "Tahoma"
2771:             .FontSize  = 8
2772:             .Caption   = "Checar Data de Entrega :"
2773:             .Top       = 141
2774:             .Left      = 309
2775:             .Width     = 125
2776:             .Height    = 15
2777:             .ForeColor = RGB(90, 90, 90)
2778:             .BackStyle = 0
2779:             .AutoSize  = .F.
2780:             .Visible   = .T.
2781:         ENDWITH
2782: 
2783:         par_oPg.AddObject("opt_4c_Chdtentrs", "OptionGroup")
2784:         WITH par_oPg.opt_4c_Chdtentrs
2785:             .ButtonCount = 2
2786:             .AutoSize    = .F.
2787:             .BackStyle   = 0
2788:             .BorderStyle = 0
2789:             .Height      = 20
2790:             .Left        = 431
2791:             .Top         = 137
2792:             .Width       = 86
2793:             .Value       = 1
2794:             .Visible     = .T.
2795:             .Buttons(1).Caption   = "Sim"
2796:             .Buttons(1).FontSize  = 8
2797:             .Buttons(1).BackStyle = 0
2798:             .Buttons(1).Left      = 5
2799:             .Buttons(1).Top       = 3
2800:             .Buttons(1).Width     = 34
2801:             .Buttons(1).AutoSize  = .T.
2802:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2803:             .Buttons(2).FontSize  = 8
2804:             .Buttons(2).BackStyle = 0
2805:             .Buttons(2).Left      = 45
2806:             .Buttons(2).Top       = 3
2807:             .Buttons(2).Width     = 37
2808:             .Buttons(2).AutoSize  = .T.
2809:         ENDWITH
2810: 
2811:         *-- Imprime Documentos (multiimps)
2812:         par_oPg.AddObject("lbl_4c_Multiimps", "Label")
2813:         WITH par_oPg.lbl_4c_Multiimps
2814:             .FontName  = "Tahoma"
2815:             .FontSize  = 8
2816:             .Caption   = "Imprime Documentos :"
2817:             .Top       = 160
2818:             .Left      = 325
2819:             .Width     = 109
2820:             .Height    = 15
2821:             .ForeColor = RGB(90, 90, 90)
2822:             .BackStyle = 0
2823:             .AutoSize  = .F.
2824:             .Visible   = .T.
2825:         ENDWITH
2826: 
2827:         par_oPg.AddObject("opt_4c_Multiimps", "OptionGroup")
2828:         WITH par_oPg.opt_4c_Multiimps
2829:             .ButtonCount = 2
2830:             .AutoSize    = .F.
2831:             .BackStyle   = 0
2832:             .BorderStyle = 0
2833:             .Height      = 20
2834:             .Left        = 431
2835:             .Top         = 156
2836:             .Width       = 86
2837:             .Value       = 1
2838:             .Visible     = .T.
2839:             .Buttons(1).Caption   = "Sim"
2840:             .Buttons(1).FontSize  = 8
2841:             .Buttons(1).BackStyle = 0
2842:             .Buttons(1).Left      = 5
2843:             .Buttons(1).Top       = 3
2844:             .Buttons(1).Width     = 34
2845:             .Buttons(1).AutoSize  = .T.
2846:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2847:             .Buttons(2).FontSize  = 8
2848:             .Buttons(2).BackStyle = 0
2849:             .Buttons(2).Left      = 45
2850:             .Buttons(2).Top       = 3
2851:             .Buttons(2).Width     = 37
2852:             .Buttons(2).AutoSize  = .T.
2853:         ENDWITH
2854: 
2855:         *-- Utiliza Conta (contas)
2856:         par_oPg.AddObject("lbl_4c_Contas", "Label")
2857:         WITH par_oPg.lbl_4c_Contas
2858:             .FontName  = "Tahoma"
2859:             .FontSize  = 8
2860:             .Caption   = "Utiliza Conta :"
2861:             .Top       = 179
2862:             .Left      = 365
2863:             .Width     = 69
2864:             .Height    = 15
2865:             .ForeColor = RGB(90, 90, 90)
2866:             .BackStyle = 0
2867:             .AutoSize  = .F.
2868:             .Visible   = .T.
2869:         ENDWITH
2870: 
2871:         par_oPg.AddObject("opt_4c_Contas", "OptionGroup")
2872:         WITH par_oPg.opt_4c_Contas
2873:             .ButtonCount = 2
2874:             .AutoSize    = .F.
2875:             .BackStyle   = 0
2876:             .BorderStyle = 0
2877:             .Height      = 20
2878:             .Left        = 431
2879:             .Top         = 175
2880:             .Width       = 86
2881:             .Value       = 2
2882:             .Visible     = .T.
2883:             .Buttons(1).Caption   = "Sim"
2884:             .Buttons(1).FontSize  = 8
2885:             .Buttons(1).BackStyle = 0
2886:             .Buttons(1).Left      = 5
2887:             .Buttons(1).Top       = 3
2888:             .Buttons(1).Width     = 34
2889:             .Buttons(1).AutoSize  = .T.
2890:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2891:             .Buttons(2).FontSize  = 8
2892:             .Buttons(2).BackStyle = 0
2893:             .Buttons(2).Left      = 45
2894:             .Buttons(2).Top       = 3
2895:             .Buttons(2).Width     = 37
2896:             .Buttons(2).AutoSize  = .T.
2897:         ENDWITH
2898: 
2899:         *-- SECAO "Credito / Bonus" (header Bold, Left=524)
2900:         par_oPg.AddObject("lbl_4c_CrBonus", "Label")
2901:         WITH par_oPg.lbl_4c_CrBonus
2902:             .FontName  = "Tahoma"
2903:             .FontSize  = 8
2904:             .FontBold  = .T.
2905:             .Caption   = "Cr" + CHR(233) + "dito / B" + CHR(244) + "nus"
2906:             .Top       = 10
2907:             .Left      = 524
2908:             .Width     = 89
2909:             .Height    = 15
2910:             .ForeColor = RGB(90, 90, 90)
2911:             .BackStyle = 0

*-- Linhas 2929 a 2972:
2929:         ENDWITH
2930: 
2931:         *-- Gera Controle de Subniveis (geracrs)
2932:         par_oPg.AddObject("opt_4c_Geracrs", "OptionGroup")
2933:         WITH par_oPg.opt_4c_Geracrs
2934:             .ButtonCount = 2
2935:             .AutoSize    = .F.
2936:             .BackStyle   = 0
2937:             .BorderStyle = 0
2938:             .Height      = 20
2939:             .Left        = 572
2940:             .Top         = 22
2941:             .Width       = 86
2942:             .Value       = 2
2943:             .Visible     = .T.
2944:             .Buttons(1).Caption   = "Sim"
2945:             .Buttons(1).FontSize  = 8
2946:             .Buttons(1).BackStyle = 0
2947:             .Buttons(1).Left      = 5
2948:             .Buttons(1).Top       = 3
2949:             .Buttons(1).Width     = 34
2950:             .Buttons(1).AutoSize  = .T.
2951:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2952:             .Buttons(2).FontSize  = 8
2953:             .Buttons(2).BackStyle = 0
2954:             .Buttons(2).Left      = 45
2955:             .Buttons(2).Top       = 3
2956:             .Buttons(2).Width     = 37
2957:             .Buttons(2).AutoSize  = .T.
2958:         ENDWITH
2959: 
2960:         par_oPg.AddObject("lbl_4c_Subnivel", "Label")
2961:         WITH par_oPg.lbl_4c_Subnivel
2962:             .FontName  = "Tahoma"
2963:             .FontSize  = 8
2964:             .Caption   = "Subn" + CHR(237) + "vel :"
2965:             .Top       = 47
2966:             .Left      = 530
2967:             .Width     = 49
2968:             .Height    = 15
2969:             .ForeColor = RGB(90, 90, 90)
2970:             .BackStyle = 0
2971:             .AutoSize  = .F.
2972:             .Visible   = .T.

*-- Linhas 3018 a 3061:
3018:         ENDWITH
3019: 
3020:         *-- Tipo de Bloqueio (tpbloqueio) - 3 opcoes verticais
3021:         par_oPg.AddObject("opt_4c_Tpbloqueio", "OptionGroup")
3022:         WITH par_oPg.opt_4c_Tpbloqueio
3023:             .ButtonCount = 3
3024:             .AutoSize    = .F.
3025:             .BackStyle   = 0
3026:             .BorderStyle = 0
3027:             .Height      = 48
3028:             .Left        = 585
3029:             .Top         = 77
3030:             .Width       = 244
3031:             .Value       = 1
3032:             .Visible     = .T.
3033:             .Buttons(1).Caption   = "Per" + CHR(237) + "odo"
3034:             .Buttons(1).FontSize  = 8
3035:             .Buttons(1).BackStyle = 0
3036:             .Buttons(1).Left      = 3
3037:             .Buttons(1).Top       = 1
3038:             .Buttons(1).Width     = 54
3039:             .Buttons(1).AutoSize  = .T.
3040:             .Buttons(2).Caption   = "Limite M" + CHR(237) + "nimo"
3041:             .Buttons(2).FontSize  = 8
3042:             .Buttons(2).BackStyle = 0
3043:             .Buttons(2).Left      = 3
3044:             .Buttons(2).Top       = 15
3045:             .Buttons(2).Width     = 80
3046:             .Buttons(2).AutoSize  = .T.
3047:             .Buttons(3).Caption   = "N" + CHR(227) + "o Bloqueia"
3048:             .Buttons(3).FontSize  = 8
3049:             .Buttons(3).BackStyle = 0
3050:             .Buttons(3).Left      = 3
3051:             .Buttons(3).Top       = 29
3052:             .Buttons(3).Width     = 81
3053:             .Buttons(3).AutoSize  = .T.
3054:         ENDWITH
3055: 
3056:         *-- SECAO "Icone Para Barra de Acesso" (header Bold)
3057:         par_oPg.AddObject("lbl_4c_IcoBarra", "Label")
3058:         WITH par_oPg.lbl_4c_IcoBarra
3059:             .FontName  = "Tahoma"
3060:             .FontSize  = 8
3061:             .FontBold  = .T.

*-- Linhas 3109 a 3247:
3109:     *--------------------------------------------------------------------------
3110:     * CarregarLista - Carrega dados do grid da Page1
3111:     *--------------------------------------------------------------------------
3112:     PROCEDURE CarregarLista()
3113:         LOCAL loc_lResultado, loc_oGrid
3114:         loc_lResultado = .F.
3115: 
3116:         TRY
3117:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3118:                 loc_lResultado = .T.
3119:             ELSE
3120:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
3121: 
3122:                 IF VARTYPE(loc_oGrid) = "O" AND THIS.this_oBusinessObject.Buscar("")
3123:                     loc_oGrid.ColumnCount = 2
3124:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
3125:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dgopes"
3126:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ngopes"
3127: 
3128:                     *-- Reconfigurar headers APOS RecordSource (VFP9 reseta headers)
3129:                     loc_oGrid.Column1.Header1.Caption = "Grupo Operacional"
3130:                     loc_oGrid.Column2.Header1.Caption = "N" + CHR(186)
3131:                     loc_oGrid.Column2.Alignment       = 1
3132: 
3133:                     THIS.FormatarGridLista(loc_oGrid)
3134:                     loc_lResultado = .T.
3135:                 ENDIF
3136:             ENDIF
3137:         CATCH TO loc_oErro
3138:             MsgErro(loc_oErro.Message + CHR(13) + ;
3139:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
3140:             loc_lResultado = .F.
3141:         ENDTRY
3142: 
3143:         RETURN loc_lResultado
3144:     ENDPROC
3145: 
3146:     *--------------------------------------------------------------------------
3147:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
3148:     *--------------------------------------------------------------------------
3149:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
3150:         LOCAL loc_lResultado
3151:         loc_lResultado = .F.
3152: 
3153:         TRY
3154:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
3155:                 loc_lResultado = .F.
3156:             ELSE
3157:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3158:                 IF par_nPagina = 1
3159:                     THIS.CarregarLista()
3160:                 ENDIF
3161:                 loc_lResultado = .T.
3162:             ENDIF
3163:         CATCH TO loc_oErro
3164:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")
3165:             loc_lResultado = .F.
3166:         ENDTRY
3167: 
3168:         RETURN loc_lResultado
3169:     ENDPROC
3170: 
3171:     *--------------------------------------------------------------------------
3172:     * FormParaBO - Transfere valores do Form para o BO
3173:     * Fase 6: campos detalhados
3174:     *--------------------------------------------------------------------------
3175:     PROTECTED PROCEDURE FormParaBO()
3176:         LOCAL loc_lResultado, loc_oPg2, loc_oPg1, loc_oPgC
3177:         loc_lResultado = .F.
3178: 
3179:         TRY
3180:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3181:             loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
3182:             loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2
3183: 
3184:             WITH THIS.this_oBusinessObject
3185:                 *-- Identificacao (Page2 direto)
3186:                 .this_cDgopes = ALLTRIM(loc_oPg2.txt_4c_Dgope.Value)
3187: 
3188:                 *-- pgConfig: OptionGroups e TextBox
3189:                 .this_nNumopers   = loc_oPg1.opt_4c_NumOper.Value
3190:                 .this_nNcontroles = loc_oPg1.opt_4c_Controle.Value
3191:                 .this_nFontnums   = loc_oPg1.opt_4c_FonNum.Value
3192:                 .this_nUtilizas   = loc_oPg1.opt_4c_Utilizas.Value
3193:                 .this_nSubniveis  = loc_oPg1.opt_4c_Subniveis.Value
3194:                 .this_nProds      = loc_oPg1.opt_4c_Prods.Value
3195:                 .this_nDesutils   = loc_oPg1.opt_4c_Desutils.Value
3196:                 .this_nIniagenda  = loc_oPg1.opt_4c_Iniagenda.Value
3197:                 .this_nQualquer   = loc_oPg1.opt_4c_Qualquer.Value
3198:                 .this_nConsulta   = loc_oPg1.opt_4c_Consulta.Value
3199:                 .this_nMontagem   = loc_oPg1.opt_4c_Montagem.Value
3200:                 .this_nChkmercs   = loc_oPg1.opt_4c_Chkmercs.Value
3201:                 .this_nOputiliza  = loc_oPg1.opt_4c_Oputiliza.Value
3202:                 .this_nFilpagas   = loc_oPg1.opt_4c_Filpagas.Value
3203:                 .this_nFilbaixas  = loc_oPg1.opt_4c_Filbaixas.Value
3204:                 .this_nAudits     = loc_oPg1.opt_4c_Audits.Value
3205:                 .this_nLimdia     = INT(VAL(TRANSFORM(loc_oPg1.txt_4c_Limdia.Value)))
3206: 
3207:                 *-- pgCompls: OptionGroups
3208:                 .this_nDtatuals   = loc_oPgC.opt_4c_Dtatuals.Value
3209:                 .this_nBlqadts    = loc_oPgC.opt_4c_Blqadts.Value
3210:                 .this_nInibocors  = loc_oPgC.opt_4c_Inibocors.Value
3211:                 .this_nInibfecs   = loc_oPgC.opt_4c_Inibfecs.Value
3212:                 .this_nAlterar    = loc_oPgC.opt_4c_Alterar.Value
3213:                 .this_nPeriodos   = loc_oPgC.opt_4c_Periodos.Value
3214:                 .this_nEntregas   = loc_oPgC.opt_4c_Entregas.Value
3215:                 .this_nOperacoes  = loc_oPgC.opt_4c_Operacoes.Value
3216:                 .this_nVends      = loc_oPgC.opt_4c_Vends.Value
3217:                 .this_nSacs       = loc_oPgC.opt_4c_Sacs.Value
3218:                 .this_nEmpresas   = loc_oPgC.opt_4c_Empresas.Value
3219:                 .this_nCtacusus   = loc_oPgC.opt_4c_Ctacusus.Value
3220:                 .this_nOppends    = loc_oPgC.opt_4c_Oppends.Value
3221:                 .this_nOpagends   = loc_oPgC.opt_4c_Opagends.Value
3222:                 .this_nOppagas    = loc_oPgC.opt_4c_Oppagas.Value
3223:                 .this_nAnacps     = loc_oPgC.opt_4c_Anacps.Value
3224:                 .this_nChkreserva = loc_oPgC.opt_4c_Chkreserva.Value
3225:                 .this_nResps      = loc_oPgC.opt_4c_Resps.Value
3226:                 .this_nEstdisps   = loc_oPgC.opt_4c_Estdisps.Value
3227:                 .this_nVolumes    = loc_oPgC.opt_4c_Volumes.Value
3228:                 .this_nAcmemps    = loc_oPgC.opt_4c_Acmemps.Value
3229:                 .this_nSenresps   = loc_oPgC.opt_4c_Senresps.Value
3230:                 .this_nChdtentrs  = loc_oPgC.opt_4c_Chdtentrs.Value
3231:                 .this_nMultiimps  = loc_oPgC.opt_4c_Multiimps.Value
3232:                 .this_nContas     = loc_oPgC.opt_4c_Contas.Value
3233:                 .this_nGeracrs    = loc_oPgC.opt_4c_Geracrs.Value
3234:                 .this_nTpbloqueio = loc_oPgC.opt_4c_Tpbloqueio.Value
3235: 
3236:                 *-- pgCompls: CheckBoxes (0/1 numeric)
3237:                 .this_nFixaps  = loc_oPgC.chk_4c_Fixaps.Value
3238:                 .this_nFixaas  = loc_oPgC.chk_4c_Fixaas.Value
3239:                 .this_nFixags  = loc_oPgC.chk_4c_Fixags.Value
3240:                 .this_nFixals  = loc_oPgC.chk_4c_Fixals.Value
3241:                 .this_nFixass  = loc_oPgC.chk_4c_Fixass.Value
3242: 
3243:                 *-- pgCompls: ComboBoxes (ListIndex 1-based = DB value)
3244:                 .this_nOrdems  = IIF(loc_oPgC.cmb_4c_Ordems.ListIndex  >= 1, ;
3245:                                      loc_oPgC.cmb_4c_Ordems.ListIndex,  1)
3246:                 .this_nOrdemns = IIF(loc_oPgC.cmb_4c_Ordemns.ListIndex >= 1, ;
3247:                                      loc_oPgC.cmb_4c_Ordemns.ListIndex, 1)

*-- Linhas 3260 a 3345:
3260:         CATCH TO loc_oErro
3261:             MsgErro(loc_oErro.Message + CHR(13) + ;
3262:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3263:                 "Procedure: " + loc_oErro.Procedure, "Erro FormParaBO")
3264:         ENDTRY
3265: 
3266:         RETURN loc_lResultado
3267:     ENDPROC
3268: 
3269:     *--------------------------------------------------------------------------
3270:     * BOParaForm - Transfere valores do BO para o Form
3271:     *--------------------------------------------------------------------------
3272:     PROTECTED PROCEDURE BOParaForm()
3273:         LOCAL loc_lResultado, loc_oPg2, loc_oPg1, loc_oPgC, loc_oBO
3274:         loc_lResultado = .F.
3275: 
3276:         TRY
3277:             loc_oBO  = THIS.this_oBusinessObject
3278:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3279:             loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
3280:             loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2
3281: 
3282:             *-- Identificacao (Page2 direto)
3283:             loc_oPg2.txt_4c_Dgope.Value = ALLTRIM(loc_oBO.this_cDgopes)
3284:             loc_oPg2.txt_4c_Ngope.Value = loc_oBO.this_nNgopes
3285: 
3286:             *-- pgConfig: OptionGroups (IIF guard: val=0 usa botao 1)
3287:             loc_oPg1.opt_4c_NumOper.Value   = IIF(loc_oBO.this_nNumopers   >= 1, loc_oBO.this_nNumopers,   1)
3288:             loc_oPg1.opt_4c_Controle.Value  = IIF(loc_oBO.this_nNcontroles >= 1, loc_oBO.this_nNcontroles, 1)
3289:             loc_oPg1.opt_4c_FonNum.Value    = IIF(loc_oBO.this_nFontnums   >= 1, loc_oBO.this_nFontnums,   1)
3290:             loc_oPg1.opt_4c_Utilizas.Value  = IIF(loc_oBO.this_nUtilizas   >= 1, loc_oBO.this_nUtilizas,   1)
3291:             loc_oPg1.opt_4c_Subniveis.Value = IIF(loc_oBO.this_nSubniveis  >= 1, loc_oBO.this_nSubniveis,  1)
3292:             loc_oPg1.opt_4c_Prods.Value     = IIF(loc_oBO.this_nProds      >= 1, loc_oBO.this_nProds,      1)
3293:             loc_oPg1.opt_4c_Desutils.Value  = IIF(loc_oBO.this_nDesutils   >= 1, loc_oBO.this_nDesutils,   1)
3294:             loc_oPg1.opt_4c_Iniagenda.Value = IIF(loc_oBO.this_nIniagenda  >= 1, loc_oBO.this_nIniagenda,  1)
3295:             loc_oPg1.opt_4c_Qualquer.Value  = IIF(loc_oBO.this_nQualquer   >= 1, loc_oBO.this_nQualquer,   1)
3296:             loc_oPg1.opt_4c_Consulta.Value  = IIF(loc_oBO.this_nConsulta   >= 1, loc_oBO.this_nConsulta,   1)
3297:             loc_oPg1.opt_4c_Montagem.Value  = IIF(loc_oBO.this_nMontagem   >= 1, loc_oBO.this_nMontagem,   1)
3298:             loc_oPg1.opt_4c_Chkmercs.Value  = IIF(loc_oBO.this_nChkmercs   >= 1, loc_oBO.this_nChkmercs,   1)
3299:             loc_oPg1.opt_4c_Oputiliza.Value = IIF(loc_oBO.this_nOputiliza  >= 1, loc_oBO.this_nOputiliza,  1)
3300:             loc_oPg1.opt_4c_Filpagas.Value  = IIF(loc_oBO.this_nFilpagas   >= 1, loc_oBO.this_nFilpagas,   1)
3301:             loc_oPg1.opt_4c_Filbaixas.Value = IIF(loc_oBO.this_nFilbaixas  >= 1, loc_oBO.this_nFilbaixas,  1)
3302:             loc_oPg1.opt_4c_Audits.Value    = IIF(loc_oBO.this_nAudits     >= 1, loc_oBO.this_nAudits,     1)
3303:             loc_oPg1.txt_4c_Limdia.Value    = loc_oBO.this_nLimdia
3304: 
3305:             *-- pgCompls: OptionGroups
3306:             loc_oPgC.opt_4c_Dtatuals.Value   = IIF(loc_oBO.this_nDtatuals   >= 1, loc_oBO.this_nDtatuals,   1)
3307:             loc_oPgC.opt_4c_Blqadts.Value    = IIF(loc_oBO.this_nBlqadts    >= 1, loc_oBO.this_nBlqadts,    1)
3308:             loc_oPgC.opt_4c_Inibocors.Value  = IIF(loc_oBO.this_nInibocors  >= 1, loc_oBO.this_nInibocors,  1)
3309:             loc_oPgC.opt_4c_Inibfecs.Value   = IIF(loc_oBO.this_nInibfecs   >= 1, loc_oBO.this_nInibfecs,   1)
3310:             loc_oPgC.opt_4c_Alterar.Value    = IIF(loc_oBO.this_nAlterar    >= 1, loc_oBO.this_nAlterar,    1)
3311:             loc_oPgC.opt_4c_Periodos.Value   = IIF(loc_oBO.this_nPeriodos   >= 1, loc_oBO.this_nPeriodos,   1)
3312:             loc_oPgC.opt_4c_Entregas.Value   = IIF(loc_oBO.this_nEntregas   >= 1, loc_oBO.this_nEntregas,   1)
3313:             loc_oPgC.opt_4c_Operacoes.Value  = IIF(loc_oBO.this_nOperacoes  >= 1, loc_oBO.this_nOperacoes,  1)
3314:             loc_oPgC.opt_4c_Vends.Value      = IIF(loc_oBO.this_nVends      >= 1, loc_oBO.this_nVends,      1)
3315:             loc_oPgC.opt_4c_Sacs.Value       = IIF(loc_oBO.this_nSacs       >= 1, loc_oBO.this_nSacs,       1)
3316:             loc_oPgC.opt_4c_Empresas.Value   = IIF(loc_oBO.this_nEmpresas   >= 1, loc_oBO.this_nEmpresas,   1)
3317:             loc_oPgC.opt_4c_Ctacusus.Value   = IIF(loc_oBO.this_nCtacusus   >= 1, loc_oBO.this_nCtacusus,   1)
3318:             loc_oPgC.opt_4c_Oppends.Value    = IIF(loc_oBO.this_nOppends    >= 1, loc_oBO.this_nOppends,    1)
3319:             loc_oPgC.opt_4c_Opagends.Value   = IIF(loc_oBO.this_nOpagends   >= 1, loc_oBO.this_nOpagends,   1)
3320:             loc_oPgC.opt_4c_Oppagas.Value    = IIF(loc_oBO.this_nOppagas    >= 1, loc_oBO.this_nOppagas,    1)
3321:             loc_oPgC.opt_4c_Anacps.Value     = IIF(loc_oBO.this_nAnacps     >= 1, loc_oBO.this_nAnacps,     1)
3322:             loc_oPgC.opt_4c_Chkreserva.Value = IIF(loc_oBO.this_nChkreserva >= 1, loc_oBO.this_nChkreserva, 1)
3323:             loc_oPgC.opt_4c_Resps.Value      = IIF(loc_oBO.this_nResps      >= 1, loc_oBO.this_nResps,      1)
3324:             loc_oPgC.opt_4c_Estdisps.Value   = IIF(loc_oBO.this_nEstdisps   >= 1, loc_oBO.this_nEstdisps,   1)
3325:             loc_oPgC.opt_4c_Volumes.Value    = IIF(loc_oBO.this_nVolumes    >= 1, loc_oBO.this_nVolumes,    1)
3326:             loc_oPgC.opt_4c_Acmemps.Value    = IIF(loc_oBO.this_nAcmemps    >= 1, loc_oBO.this_nAcmemps,    1)
3327:             loc_oPgC.opt_4c_Senresps.Value   = IIF(loc_oBO.this_nSenresps   >= 1, loc_oBO.this_nSenresps,   1)
3328:             loc_oPgC.opt_4c_Chdtentrs.Value  = IIF(loc_oBO.this_nChdtentrs  >= 1, loc_oBO.this_nChdtentrs,  1)
3329:             loc_oPgC.opt_4c_Multiimps.Value  = IIF(loc_oBO.this_nMultiimps  >= 1, loc_oBO.this_nMultiimps,  1)
3330:             loc_oPgC.opt_4c_Contas.Value     = IIF(loc_oBO.this_nContas     >= 1, loc_oBO.this_nContas,     1)
3331:             loc_oPgC.opt_4c_Geracrs.Value    = IIF(loc_oBO.this_nGeracrs    >= 1, loc_oBO.this_nGeracrs,    1)
3332:             loc_oPgC.opt_4c_Tpbloqueio.Value = IIF(loc_oBO.this_nTpbloqueio >= 1, loc_oBO.this_nTpbloqueio, 1)
3333: 
3334:             *-- pgCompls: CheckBoxes (0/1)
3335:             loc_oPgC.chk_4c_Fixaps.Value = loc_oBO.this_nFixaps
3336:             loc_oPgC.chk_4c_Fixaas.Value = loc_oBO.this_nFixaas
3337:             loc_oPgC.chk_4c_Fixags.Value = loc_oBO.this_nFixags
3338:             loc_oPgC.chk_4c_Fixals.Value = loc_oBO.this_nFixals
3339:             loc_oPgC.chk_4c_Fixass.Value = loc_oBO.this_nFixass
3340: 
3341:             *-- pgCompls: ComboBoxes (ListIndex 1-based = DB value)
3342:             loc_oPgC.cmb_4c_Ordems.ListIndex  = IIF(loc_oBO.this_nOrdems  >= 1, loc_oBO.this_nOrdems,  1)
3343:             loc_oPgC.cmb_4c_Ordemns.ListIndex = IIF(loc_oBO.this_nOrdemns >= 1, loc_oBO.this_nOrdemns, 1)
3344:             loc_oPgC.cmb_4c_Ordemas.ListIndex = IIF(loc_oBO.this_nOrdemas >= 1, loc_oBO.this_nOrdemas, 1)
3345: 

*-- Linhas 3376 a 3460:
3376:         CATCH TO loc_oErro
3377:             MsgErro(loc_oErro.Message + CHR(13) + ;
3378:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3379:                 "Procedure: " + loc_oErro.Procedure, "Erro BOParaForm")
3380:         ENDTRY
3381: 
3382:         RETURN loc_lResultado
3383:     ENDPROC
3384: 
3385:     *--------------------------------------------------------------------------
3386:     * HabilitarCampos - Habilita ou desabilita campos editaveis
3387:     *--------------------------------------------------------------------------
3388:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3389:         LOCAL loc_oPg2, loc_oPg1, loc_oPgC, loc_lSoLeitura
3390: 
3391:         TRY
3392:             loc_oPg2       = THIS.pgf_4c_Paginas.Page2
3393:             loc_oPg1       = loc_oPg2.pgf_4c_Dados.Page1
3394:             loc_oPgC       = loc_oPg2.pgf_4c_Dados.Page2
3395:             loc_lSoLeitura = !par_lHabilitar
3396: 
3397:             *-- Codigo do grupo: editavel apenas em INCLUIR (e PK)
3398:             loc_oPg2.txt_4c_Dgope.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
3399: 
3400:             *-- pgConfig: OptionGroups e campos
3401:             loc_oPg1.opt_4c_NumOper.Enabled   = par_lHabilitar
3402:             loc_oPg1.opt_4c_Controle.Enabled  = par_lHabilitar
3403:             loc_oPg1.opt_4c_FonNum.Enabled    = par_lHabilitar
3404:             loc_oPg1.opt_4c_Utilizas.Enabled  = par_lHabilitar
3405:             loc_oPg1.opt_4c_Subniveis.Enabled = par_lHabilitar
3406:             loc_oPg1.opt_4c_Prods.Enabled     = par_lHabilitar
3407:             loc_oPg1.opt_4c_Desutils.Enabled  = par_lHabilitar
3408:             loc_oPg1.opt_4c_Iniagenda.Enabled = par_lHabilitar
3409:             loc_oPg1.opt_4c_Qualquer.Enabled  = par_lHabilitar
3410:             loc_oPg1.opt_4c_Consulta.Enabled  = par_lHabilitar
3411:             loc_oPg1.opt_4c_Montagem.Enabled  = par_lHabilitar
3412:             loc_oPg1.opt_4c_Chkmercs.Enabled  = par_lHabilitar
3413:             loc_oPg1.opt_4c_Oputiliza.Enabled = par_lHabilitar
3414:             loc_oPg1.opt_4c_Filpagas.Enabled  = par_lHabilitar
3415:             loc_oPg1.opt_4c_Filbaixas.Enabled = par_lHabilitar
3416:             loc_oPg1.opt_4c_Audits.Enabled    = par_lHabilitar
3417:             loc_oPg1.txt_4c_Limdia.ReadOnly   = loc_lSoLeitura
3418:             loc_oPg1.grd_4c_GradeOpe.ReadOnly = loc_lSoLeitura
3419: 
3420:             *-- pgCompls: OptionGroups
3421:             loc_oPgC.opt_4c_Dtatuals.Enabled   = par_lHabilitar
3422:             loc_oPgC.opt_4c_Blqadts.Enabled    = par_lHabilitar
3423:             loc_oPgC.opt_4c_Inibocors.Enabled  = par_lHabilitar
3424:             loc_oPgC.opt_4c_Inibfecs.Enabled   = par_lHabilitar
3425:             loc_oPgC.opt_4c_Alterar.Enabled    = par_lHabilitar
3426:             loc_oPgC.opt_4c_Periodos.Enabled   = par_lHabilitar
3427:             loc_oPgC.opt_4c_Entregas.Enabled   = par_lHabilitar
3428:             loc_oPgC.opt_4c_Operacoes.Enabled  = par_lHabilitar
3429:             loc_oPgC.opt_4c_Vends.Enabled      = par_lHabilitar
3430:             loc_oPgC.opt_4c_Sacs.Enabled       = par_lHabilitar
3431:             loc_oPgC.opt_4c_Empresas.Enabled   = par_lHabilitar
3432:             loc_oPgC.opt_4c_Ctacusus.Enabled   = par_lHabilitar
3433:             loc_oPgC.opt_4c_Oppends.Enabled    = par_lHabilitar
3434:             loc_oPgC.opt_4c_Opagends.Enabled   = par_lHabilitar
3435:             loc_oPgC.opt_4c_Oppagas.Enabled    = par_lHabilitar
3436:             loc_oPgC.opt_4c_Anacps.Enabled     = par_lHabilitar
3437:             loc_oPgC.opt_4c_Chkreserva.Enabled = par_lHabilitar
3438:             loc_oPgC.opt_4c_Resps.Enabled      = par_lHabilitar
3439:             loc_oPgC.opt_4c_Estdisps.Enabled   = par_lHabilitar
3440:             loc_oPgC.opt_4c_Volumes.Enabled    = par_lHabilitar
3441:             loc_oPgC.opt_4c_Acmemps.Enabled    = par_lHabilitar
3442:             loc_oPgC.opt_4c_Senresps.Enabled   = par_lHabilitar
3443:             loc_oPgC.opt_4c_Chdtentrs.Enabled  = par_lHabilitar
3444:             loc_oPgC.opt_4c_Multiimps.Enabled  = par_lHabilitar
3445:             loc_oPgC.opt_4c_Contas.Enabled     = par_lHabilitar
3446:             loc_oPgC.opt_4c_Geracrs.Enabled    = par_lHabilitar
3447:             loc_oPgC.opt_4c_Tpbloqueio.Enabled = par_lHabilitar
3448: 
3449:             *-- pgCompls: CheckBoxes
3450:             loc_oPgC.chk_4c_Fixaps.Enabled = par_lHabilitar
3451:             loc_oPgC.chk_4c_Fixaas.Enabled = par_lHabilitar
3452:             loc_oPgC.chk_4c_Fixags.Enabled = par_lHabilitar
3453:             loc_oPgC.chk_4c_Fixals.Enabled = par_lHabilitar
3454:             loc_oPgC.chk_4c_Fixass.Enabled = par_lHabilitar
3455: 
3456:             *-- pgCompls: ComboBoxes
3457:             loc_oPgC.cmb_4c_Ordems.Enabled  = par_lHabilitar
3458:             loc_oPgC.cmb_4c_Ordemns.Enabled = par_lHabilitar
3459:             loc_oPgC.cmb_4c_Ordemas.Enabled = par_lHabilitar
3460: 

*-- Linhas 3468 a 3566:
3468:         CATCH TO loc_oErro
3469:             MsgErro(loc_oErro.Message + CHR(13) + ;
3470:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3471:                 "Procedure: " + loc_oErro.Procedure, "Erro HabilitarCampos")
3472:         ENDTRY
3473:     ENDPROC
3474: 
3475:     *--------------------------------------------------------------------------
3476:     * LimparCampos - Limpa valores dos campos da Page2 (para novo registro)
3477:     *--------------------------------------------------------------------------
3478:     PROTECTED PROCEDURE LimparCampos()
3479:         LOCAL loc_oPg2, loc_oPg1, loc_oPgC
3480: 
3481:         TRY
3482:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3483:             loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
3484:             loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2
3485: 
3486:             *-- Identificacao
3487:             loc_oPg2.txt_4c_Dgope.Value = ""
3488:             loc_oPg2.txt_4c_Ngope.Value = 0
3489: 
3490:             *-- pgConfig: OptionGroups → todos Value=1 (primeiro botao)
3491:             loc_oPg1.opt_4c_NumOper.Value   = 1
3492:             loc_oPg1.opt_4c_Controle.Value  = 1
3493:             loc_oPg1.opt_4c_FonNum.Value    = 1
3494:             loc_oPg1.opt_4c_Utilizas.Value  = 1
3495:             loc_oPg1.opt_4c_Subniveis.Value = 1
3496:             loc_oPg1.opt_4c_Prods.Value     = 1
3497:             loc_oPg1.opt_4c_Desutils.Value  = 1
3498:             loc_oPg1.opt_4c_Iniagenda.Value = 1
3499:             loc_oPg1.opt_4c_Qualquer.Value  = 1
3500:             loc_oPg1.opt_4c_Consulta.Value  = 1
3501:             loc_oPg1.opt_4c_Montagem.Value  = 1
3502:             loc_oPg1.opt_4c_Chkmercs.Value  = 1
3503:             loc_oPg1.opt_4c_Oputiliza.Value = 1
3504:             loc_oPg1.opt_4c_Filpagas.Value  = 1
3505:             loc_oPg1.opt_4c_Filbaixas.Value = 1
3506:             loc_oPg1.opt_4c_Audits.Value    = 1
3507:             loc_oPg1.txt_4c_Limdia.Value    = 0
3508: 
3509:             *-- pgConfig: Grid → cursor vazio editavel
3510:             IF USED("cursor_4c_Operacoes")
3511:                 USE IN cursor_4c_Operacoes
3512:             ENDIF
3513:             SET NULL ON
3514:             CREATE CURSOR cursor_4c_Operacoes (dopers C(20), confops C(20), cidchaves C(20))
3515:             SET NULL OFF
3516:             loc_oPg1.grd_4c_GradeOpe.ColumnCount = 2
3517:             loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
3518:             loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
3519:             loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
3520:             loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
3521:                 "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
3522:             loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
3523:                 "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
3524:             loc_oPg1.grd_4c_GradeOpe.Refresh()
3525: 
3526:             *-- pgCompls: OptionGroups → todos Value=1
3527:             loc_oPgC.opt_4c_Dtatuals.Value   = 1
3528:             loc_oPgC.opt_4c_Blqadts.Value    = 1
3529:             loc_oPgC.opt_4c_Inibocors.Value  = 1
3530:             loc_oPgC.opt_4c_Inibfecs.Value   = 1
3531:             loc_oPgC.opt_4c_Alterar.Value    = 1
3532:             loc_oPgC.opt_4c_Periodos.Value   = 1
3533:             loc_oPgC.opt_4c_Entregas.Value   = 1
3534:             loc_oPgC.opt_4c_Operacoes.Value  = 1
3535:             loc_oPgC.opt_4c_Vends.Value      = 1
3536:             loc_oPgC.opt_4c_Sacs.Value       = 1
3537:             loc_oPgC.opt_4c_Empresas.Value   = 1
3538:             loc_oPgC.opt_4c_Ctacusus.Value   = 1
3539:             loc_oPgC.opt_4c_Oppends.Value    = 1
3540:             loc_oPgC.opt_4c_Opagends.Value   = 1
3541:             loc_oPgC.opt_4c_Oppagas.Value    = 1
3542:             loc_oPgC.opt_4c_Anacps.Value     = 1
3543:             loc_oPgC.opt_4c_Chkreserva.Value = 1
3544:             loc_oPgC.opt_4c_Resps.Value      = 1
3545:             loc_oPgC.opt_4c_Estdisps.Value   = 1
3546:             loc_oPgC.opt_4c_Volumes.Value    = 1
3547:             loc_oPgC.opt_4c_Acmemps.Value    = 1
3548:             loc_oPgC.opt_4c_Senresps.Value   = 1
3549:             loc_oPgC.opt_4c_Chdtentrs.Value  = 1
3550:             loc_oPgC.opt_4c_Multiimps.Value  = 1
3551:             loc_oPgC.opt_4c_Contas.Value     = 1
3552:             loc_oPgC.opt_4c_Geracrs.Value    = 1
3553:             loc_oPgC.opt_4c_Tpbloqueio.Value = 1
3554: 
3555:             *-- pgCompls: CheckBoxes
3556:             loc_oPgC.chk_4c_Fixaps.Value = 0
3557:             loc_oPgC.chk_4c_Fixaas.Value = 0
3558:             loc_oPgC.chk_4c_Fixags.Value = 0
3559:             loc_oPgC.chk_4c_Fixals.Value = 0
3560:             loc_oPgC.chk_4c_Fixass.Value = 0
3561: 
3562:             *-- pgCompls: ComboBoxes → primeira opcao
3563:             loc_oPgC.cmb_4c_Ordems.ListIndex  = 1
3564:             loc_oPgC.cmb_4c_Ordemns.ListIndex = 1
3565:             loc_oPgC.cmb_4c_Ordemas.ListIndex = 1
3566: 

*-- Linhas 3574 a 3804:
3574:         CATCH TO loc_oErro
3575:             MsgErro(loc_oErro.Message + CHR(13) + ;
3576:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3577:                 "Procedure: " + loc_oErro.Procedure, "Erro LimparCampos")
3578:         ENDTRY
3579:     ENDPROC
3580: 
3581:     *--------------------------------------------------------------------------
3582:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
3583:     *--------------------------------------------------------------------------
3584:     PROTECTED PROCEDURE AjustarBotoesPorModo()
3585:         LOCAL loc_oBotoes, loc_lTemRegistro
3586: 
3587:         TRY
3588:             loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
3589:             loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
3590:                                !EOF("cursor_4c_Dados") AND ;
3591:                                RECCOUNT("cursor_4c_Dados") > 0
3592: 
3593:             IF VARTYPE(loc_oBotoes) = "O"
3594:                 loc_oBotoes.cmd_4c_Incluir.Enabled    = .T.
3595:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3596:                 loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3597:                 loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3598:                 loc_oBotoes.cmd_4c_Buscar.Enabled     = .T.
3599:             ENDIF
3600:         CATCH TO loc_oErro
3601:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
3602:         ENDTRY
3603:     ENDPROC
3604: 
3605:     *--------------------------------------------------------------------------
3606:     * BtnEncerrarClick - Fecha o formulario
3607:     *--------------------------------------------------------------------------
3608:     PROCEDURE BtnEncerrarClick()
3609:         THIS.Release()
3610:     ENDPROC
3611: 
3612:     *--------------------------------------------------------------------------
3613:     * BtnIncluirClick - Prepara formulario para inclusao de novo registro
3614:     *--------------------------------------------------------------------------
3615:     PROCEDURE BtnIncluirClick()
3616:         THIS.this_oBusinessObject.NovoRegistro()
3617:         THIS.LimparCampos()
3618:         THIS.this_cModoAtual = "INCLUIR"
3619:         THIS.HabilitarCampos(.T.)
3620:         THIS.pgf_4c_Paginas.ActivePage = 2
3621:     ENDPROC
3622: 
3623:     *--------------------------------------------------------------------------
3624:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
3625:     *--------------------------------------------------------------------------
3626:     PROCEDURE BtnVisualizarClick()
3627:         LOCAL loc_cDgopes
3628:         loc_cDgopes = ""
3629: 
3630:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3631:             MsgAviso("Selecione um registro na lista.", "")
3632:             RETURN
3633:         ENDIF
3634: 
3635:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3636: 
3637:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
3638:             THIS.BOParaForm()
3639:             THIS.this_cModoAtual = "VISUALIZAR"
3640:             THIS.HabilitarCampos(.F.)
3641:             THIS.pgf_4c_Paginas.ActivePage = 2
3642:         ENDIF
3643:     ENDPROC
3644: 
3645:     *--------------------------------------------------------------------------
3646:     * BtnAlterarClick - Carrega registro selecionado para edicao
3647:     *--------------------------------------------------------------------------
3648:     PROCEDURE BtnAlterarClick()
3649:         LOCAL loc_cDgopes
3650:         loc_cDgopes = ""
3651: 
3652:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3653:             MsgAviso("Selecione um registro na lista.", "")
3654:             RETURN
3655:         ENDIF
3656: 
3657:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3658: 
3659:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
3660:             THIS.this_oBusinessObject.EditarRegistro()
3661:             THIS.BOParaForm()
3662:             THIS.this_cModoAtual = "ALTERAR"
3663:             THIS.HabilitarCampos(.T.)
3664:             THIS.pgf_4c_Paginas.ActivePage = 2
3665:         ENDIF
3666:     ENDPROC
3667: 
3668:     *--------------------------------------------------------------------------
3669:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
3670:     *--------------------------------------------------------------------------
3671:     PROCEDURE BtnExcluirClick()
3672:         LOCAL loc_cDgopes
3673: 
3674:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3675:             MsgAviso("Selecione um registro na lista.", "")
3676:             RETURN
3677:         ENDIF
3678: 
3679:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3680: 
3681:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo operacional:" + ;
3682:                 CHR(13) + loc_cDgopes + "?", "Excluir")
3683:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
3684:                 IF THIS.this_oBusinessObject.Excluir()
3685:                     MsgInfo("Grupo operacional exclu" + CHR(237) + "do com sucesso!", "")
3686:                     THIS.CarregarLista()
3687:                 ENDIF
3688:             ENDIF
3689:         ENDIF
3690:     ENDPROC
3691: 
3692:     *--------------------------------------------------------------------------
3693:     * BtnBuscarClick - Abre lookup para localizar grupo na lista
3694:     *--------------------------------------------------------------------------
3695:     PROCEDURE BtnBuscarClick()
3696:         LOCAL loc_oBusca, loc_cDgopes
3697: 
3698:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3699:             "SigCdGpe", "cursor_4c_Busca", "dgopes", "", ;
3700:             "Buscar Grupo Operacional")
3701: 
3702:         IF VARTYPE(loc_oBusca) = "O"
3703:             loc_oBusca.mAddColuna("dgopes", "", "Grupo Operacional")
3704:             loc_oBusca.mAddColuna("ngopes", "", "N" + CHR(186))
3705:             loc_oBusca.Show()
3706: 
3707:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3708:                 loc_cDgopes = ALLTRIM(cursor_4c_Busca.dgopes)
3709:                 IF USED("cursor_4c_Dados")
3710:                     SELECT cursor_4c_Dados
3711:                     LOCATE FOR ALLTRIM(dgopes) = loc_cDgopes
3712:                 ENDIF
3713:             ENDIF
3714: 
3715:             loc_oBusca.Release()
3716:         ENDIF
3717: 
3718:         IF USED("cursor_4c_Busca")
3719:             USE IN cursor_4c_Busca
3720:         ENDIF
3721:     ENDPROC
3722: 
3723:     *--------------------------------------------------------------------------
3724:     * BtnConfirmarClick - Salva o registro atual (Inserir ou Atualizar)
3725:     *--------------------------------------------------------------------------
3726:     PROCEDURE BtnConfirmarClick()
3727:         LOCAL loc_lResultado, loc_cDgopes
3728:         loc_lResultado = .F.
3729:         loc_cDgopes    = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dgope.Value)
3730: 
3731:         IF EMPTY(loc_cDgopes)
3732:             MsgAviso("Informe o Grupo Operacional.", "")
3733:             RETURN
3734:         ENDIF
3735: 
3736:         THIS.FormParaBO()
3737: 
3738:         IF THIS.this_oBusinessObject.Salvar()
3739:             THIS.this_oBusinessObject.SalvarOperacoes(;
3740:                 THIS.this_oBusinessObject.this_cDgopes, "cursor_4c_Operacoes")
3741:             MsgInfo("Registro salvo com sucesso!", "")
3742:             THIS.this_cModoAtual = "LISTA"
3743:             THIS.CarregarLista()
3744:             THIS.AlternarPagina(1)
3745:         ENDIF
3746:     ENDPROC
3747: 
3748:     *--------------------------------------------------------------------------
3749:     * BtnCancelarClick - Cancela edicao e volta para lista
3750:     *--------------------------------------------------------------------------
3751:     PROCEDURE BtnCancelarClick()
3752:         THIS.this_cModoAtual = "LISTA"
3753:         THIS.AlternarPagina(1)
3754:     ENDPROC
3755: 
3756:     *--------------------------------------------------------------------------
3757:     * BtnMontaListaClick - Lista operacoes do grupo selecionado (equivalente SigLlOpe)
3758:     *--------------------------------------------------------------------------
3759:     PROCEDURE BtnMontaListaClick()
3760:         LOCAL loc_cDgopes, loc_cTexto, loc_cArqTmp, loc_nCount
3761: 
3762:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
3763:                 RECCOUNT("cursor_4c_Dados") = 0
3764:             MsgAviso("Selecione um grupo operacional na lista.", "")
3765:             RETURN
3766:         ENDIF
3767: 
3768:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3769: 
3770:         TRY
3771:             IF THIS.this_oBusinessObject.BuscarOperacoes(loc_cDgopes)
3772:                 loc_nCount = RECCOUNT("cursor_4c_Operacoes")
3773:                 IF loc_nCount = 0
3774:                     MsgInfo("O grupo [" + loc_cDgopes + ;
3775:                         "] n" + CHR(227) + "o possui opera" + CHR(231) + CHR(245) + ;
3776:                         "es cadastradas.", ;
3777:                         "Listagem de Opera" + CHR(231) + CHR(245) + "es")
3778:                 ELSE
3779:                     loc_cTexto = "LISTAGEM DE OPERA" + CHR(199) + CHR(213) + "ES" + CHR(13) + CHR(10) + ;
3780:                         "Grupo Operacional: " + loc_cDgopes + CHR(13) + CHR(10) + ;
3781:                         "Total: " + TRANSFORM(loc_nCount) + " registro(s)" + CHR(13) + CHR(10) + ;
3782:                         REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
3783:                         PADR("Opera" + CHR(231) + CHR(227) + "o Poss" + CHR(237) + "vel", 22) + ;
3784:                         PADR("Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia", 22) + ;
3785:                         CHR(13) + CHR(10) + REPLICATE("-", 60) + CHR(13) + CHR(10)
3786: 
3787:                     SELECT cursor_4c_Operacoes
3788:                     GO TOP
3789:                     SCAN
3790:                         loc_cTexto = loc_cTexto + ;
3791:                             PADR(ALLTRIM(cursor_4c_Operacoes.dopers),  22) + ;
3792:                             PADR(ALLTRIM(cursor_4c_Operacoes.confops), 22) + ;
3793:                             CHR(13) + CHR(10)
3794:                     ENDSCAN
3795: 
3796:                     loc_cArqTmp = ADDBS(SYS(2023)) + "ListaOps_" + loc_cDgopes + "_" + ;
3797:                         SYS(2015) + ".txt"
3798:                     STRTOFILE(loc_cTexto, loc_cArqTmp)
3799: 
3800:                     IF FILE(loc_cArqTmp)
3801:                         RUN /N NOTEPAD.EXE "&loc_cArqTmp"
3802:                     ELSE
3803:                         MsgErro("Falha ao gerar arquivo de listagem.", "Erro")
3804:                     ENDIF

*-- Linhas 3813 a 3856:
3813:     *--------------------------------------------------------------------------
3814:     * BtnImpXMLClick - Importa XML de grupo operacional (equivalente SigOpXml modo I)
3815:     *--------------------------------------------------------------------------
3816:     PROCEDURE BtnImpXMLClick()
3817:         LOCAL loc_cArquivo, loc_cXML, loc_cDgopes, loc_nResultado, loc_cSQL
3818:         LOCAL loc_lProsseguir, loc_lJaExiste
3819: 
3820:         loc_cArquivo = GETFILE("XML", "Selecionar XML para importar", "Abrir")
3821:         IF EMPTY(loc_cArquivo) OR !FILE(loc_cArquivo)
3822:             RETURN
3823:         ENDIF
3824: 
3825:         TRY
3826:             loc_lProsseguir = .T.
3827:             loc_cXML        = FILETOSTR(loc_cArquivo)
3828: 
3829:             IF EMPTY(loc_cXML)
3830:                 MsgErro("Arquivo XML vazio ou ileg" + CHR(237) + "vel.", "Erro")
3831:                 loc_lProsseguir = .F.
3832:             ENDIF
3833: 
3834:             IF loc_lProsseguir
3835:                 IF USED("cursor_4c_XMLImp")
3836:                     USE IN cursor_4c_XMLImp
3837:                 ENDIF
3838:                 XMLTOCURSOR(loc_cXML, "cursor_4c_XMLImp")
3839: 
3840:                 IF !USED("cursor_4c_XMLImp") OR RECCOUNT("cursor_4c_XMLImp") = 0
3841:                     MsgErro("XML inv" + CHR(225) + "lido ou vazio.", "Erro")
3842:                     loc_lProsseguir = .F.
3843:                 ENDIF
3844:             ENDIF
3845: 
3846:             IF loc_lProsseguir
3847:                 SELECT cursor_4c_XMLImp
3848:                 GO TOP
3849: 
3850:                 IF TYPE("cursor_4c_XMLImp.dgopes") = "U"
3851:                     MsgErro("XML n" + CHR(227) + "o possui a coluna 'dgopes'.", "Erro")
3852:                     loc_lProsseguir = .F.
3853:                 ENDIF
3854:             ENDIF
3855: 
3856:             IF loc_lProsseguir

*-- Linhas 3912 a 3966:
3912:     *--------------------------------------------------------------------------
3913:     * BtnExpXMLClick - Exporta grupo selecionado em XML (equivalente SigOpXml modo E)
3914:     *--------------------------------------------------------------------------
3915:     PROCEDURE BtnExpXMLClick()
3916:         LOCAL loc_cDgopes, loc_cArquivo, loc_cXML, loc_cSQL, loc_nResultado
3917:         LOCAL loc_lProsseguir
3918: 
3919:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3920:             MsgAviso("Selecione um registro na lista.", "")
3921:             RETURN
3922:         ENDIF
3923: 
3924:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3925:         IF EMPTY(loc_cDgopes)
3926:             MsgAviso("Grupo operacional inv" + CHR(225) + "lido.", "")
3927:             RETURN
3928:         ENDIF
3929: 
3930:         loc_cArquivo = PUTFILE("Salvar como", ;
3931:             "GrupoOper_" + loc_cDgopes + ".xml", "XML")
3932:         IF EMPTY(loc_cArquivo)
3933:             RETURN
3934:         ENDIF
3935: 
3936:         TRY
3937:             loc_lProsseguir = .T.
3938:             loc_cSQL        = "SELECT * FROM SigCdGpe WHERE dgopes = " + ;
3939:                 EscaparSQL(loc_cDgopes)
3940:             loc_nResultado  = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XMLExp")
3941: 
3942:             IF loc_nResultado < 0 OR !USED("cursor_4c_XMLExp") OR ;
3943:                     RECCOUNT("cursor_4c_XMLExp") = 0
3944:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o grupo:" + ;
3945:                     CHR(13) + CapturarErroSQL(), "Erro")
3946:                 loc_lProsseguir = .F.
3947:             ENDIF
3948: 
3949:             IF loc_lProsseguir
3950:                 loc_cXML = ""
3951:                 CURSORTOXML("cursor_4c_XMLExp", "loc_cXML", 1, 512, 0, "1")
3952: 
3953:                 IF EMPTY(loc_cXML)
3954:                     MsgErro("Falha ao gerar XML.", "Erro")
3955:                     loc_lProsseguir = .F.
3956:                 ENDIF
3957:             ENDIF
3958: 
3959:             IF loc_lProsseguir
3960:                 STRTOFILE(loc_cXML, loc_cArquivo)
3961: 
3962:                 IF FILE(loc_cArquivo)
3963:                     MsgInfo("Grupo [" + loc_cDgopes + ;
3964:                         "] exportado para:" + CHR(13) + loc_cArquivo, ;
3965:                         "Exporta" + CHR(231) + CHR(227) + "o")
3966:                 ELSE

*-- Linhas 3980 a 4250:
3980:     *--------------------------------------------------------------------------
3981:     * BtnIconeClick - Abre seletor de arquivo .ico para o grupo
3982:     *--------------------------------------------------------------------------
3983:     PROCEDURE BtnIconeClick()
3984:         LOCAL loc_cArquivo, loc_txt, loc_img
3985: 
3986:         TRY
3987:             loc_cArquivo = GetFile("ico;bmp;jpg;png", "Selecionar " + CHR(205) + "cone", "Selecionar")
3988:             IF !EMPTY(loc_cArquivo)
3989:                 loc_txt = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Carqicones
3990:                 loc_img = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.img_4c_Icone
3991:                 IF VARTYPE(loc_txt) = "O"
3992:                     loc_txt.Value = loc_cArquivo
3993:                 ENDIF
3994:                 IF VARTYPE(loc_img) = "O"
3995:                     loc_img.Picture = loc_cArquivo
3996:                     loc_img.Visible = .T.
3997:                 ENDIF
3998:             ENDIF
3999:         CATCH TO loc_oErro
4000:             MsgErro(loc_oErro.Message, "Erro BtnIconeClick")
4001:         ENDTRY
4002:     ENDPROC
4003: 
4004:     *--------------------------------------------------------------------------
4005:     * FormatarGridLista - Formata visual do grid da lista
4006:     *--------------------------------------------------------------------------
4007:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
4008:         WITH par_oGrid
4009:             .FontName = "Verdana"
4010:             .FontSize = 8
4011:         ENDWITH
4012:     ENDPROC
4013: 
4014:     *--------------------------------------------------------------------------
4015:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
4016:     *--------------------------------------------------------------------------
4017:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4018:         LOCAL loc_nI, loc_oObjeto, loc_nP
4019: 
4020:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4021:             loc_oObjeto = par_oContainer.Controls(loc_nI)
4022: 
4023:             IF VARTYPE(loc_oObjeto) = "O"
4024:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
4025:                     LOOP
4026:                 ENDIF
4027: 
4028:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
4029:                     loc_oObjeto.Visible = .T.
4030:                 ENDIF
4031: 
4032:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
4033:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
4034:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
4035:                     ENDFOR
4036:                 ENDIF
4037: 
4038:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
4039:                     THIS.TornarControlesVisiveis(loc_oObjeto)
4040:                 ENDIF
4041:             ENDIF
4042:         ENDFOR
4043:     ENDPROC
4044: 
4045:     *--------------------------------------------------------------------------
4046:     * Destroy - Limpeza ao fechar o formulario
4047:     *--------------------------------------------------------------------------
4048:     PROCEDURE Destroy()
4049:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
4050:             THIS.this_oBusinessObject = .NULL.
4051:         ENDIF
4052: 
4053:         IF USED("cursor_4c_Dados")
4054:             USE IN cursor_4c_Dados
4055:         ENDIF
4056: 
4057:         IF USED("cursor_4c_Operacoes")
4058:             USE IN cursor_4c_Operacoes
4059:         ENDIF
4060: 
4061:         IF USED("cursor_4c_Busca")
4062:             USE IN cursor_4c_Busca
4063:         ENDIF
4064: 
4065:         IF USED("cursor_4c_BuscaSub")
4066:             USE IN cursor_4c_BuscaSub
4067:         ENDIF
4068: 
4069:         IF USED("cursor_4c_BuscaLcl")
4070:             USE IN cursor_4c_BuscaLcl
4071:         ENDIF
4072: 
4073:         IF USED("cursor_4c_BuscaSct")
4074:             USE IN cursor_4c_BuscaSct
4075:         ENDIF
4076: 
4077:         DODEFAULT()
4078:     ENDPROC
4079: 
4080:     *--------------------------------------------------------------------------
4081:     * TxtSubncrsKeyPress - Enter/Tab/F4 abre lookup SigCdOpe
4082:     *--------------------------------------------------------------------------
4083:     PROCEDURE TxtSubncrsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4084:         IF INLIST(par_nKeyCode, 13, 9, 115)
4085:             THIS.AbrirLookupSubncrs()
4086:         ENDIF
4087:     ENDPROC
4088: 
4089:     *--------------------------------------------------------------------------
4090:     * TxtLocalsKeyPress - Enter/Tab/F4 abre lookup SigPrLcl
4091:     *--------------------------------------------------------------------------
4092:     PROCEDURE TxtLocalsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4093:         IF INLIST(par_nKeyCode, 13, 9, 115)
4094:             THIS.AbrirLookupLocals()
4095:         ENDIF
4096:     ENDPROC
4097: 
4098:     *--------------------------------------------------------------------------
4099:     * TxtCodegsKeyPress - Enter/Tab/F4 abre lookup SigCdSct
4100:     *--------------------------------------------------------------------------
4101:     PROCEDURE TxtCodegsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4102:         IF INLIST(par_nKeyCode, 13, 9, 115)
4103:             THIS.AbrirLookupCodsegs()
4104:         ENDIF
4105:     ENDPROC
4106: 
4107:     *--------------------------------------------------------------------------
4108:     * AbrirLookupSubncrs - FormBuscaAuxiliar em SigCdOpe (campo subncrs)
4109:     *--------------------------------------------------------------------------
4110:     PROCEDURE AbrirLookupSubncrs()
4111:         LOCAL loc_oBusca, loc_cValor, loc_oTxt
4112:         loc_cValor = ""
4113:         loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Subncrs
4114: 
4115:         IF VARTYPE(loc_oTxt) = "O"
4116:             loc_cValor = ALLTRIM(loc_oTxt.Value)
4117:         ENDIF
4118: 
4119:         TRY
4120:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4121:                 "SigCdOpe", "cursor_4c_BuscaSub", "Dopes", loc_cValor, ;
4122:                 "Buscar Subn" + CHR(237) + "vel")
4123: 
4124:             IF VARTYPE(loc_oBusca) = "O"
4125:                 IF !loc_oBusca.this_lAchouRegistro
4126:                     loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
4127:                     loc_oBusca.Show()
4128:                 ENDIF
4129: 
4130:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSub")
4131:                     IF VARTYPE(loc_oTxt) = "O"
4132:                         loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaSub.Dopes)
4133:                     ENDIF
4134:                 ENDIF
4135: 
4136:                 loc_oBusca.Release()
4137:             ENDIF
4138:         CATCH TO loc_oErro
4139:             MsgErro(loc_oErro.Message, "Erro AbrirLookupSubncrs")
4140:         ENDTRY
4141: 
4142:         IF USED("cursor_4c_BuscaSub")
4143:             USE IN cursor_4c_BuscaSub
4144:         ENDIF
4145:     ENDPROC
4146: 
4147:     *--------------------------------------------------------------------------
4148:     * AbrirLookupLocals - FormBuscaAuxiliar em SigPrLcl (campo locals)
4149:     *--------------------------------------------------------------------------
4150:     PROCEDURE AbrirLookupLocals()
4151:         LOCAL loc_oBusca, loc_cValor, loc_oTxt
4152:         loc_cValor = ""
4153:         loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Locals
4154: 
4155:         IF VARTYPE(loc_oTxt) = "O"
4156:             loc_cValor = ALLTRIM(loc_oTxt.Value)
4157:         ENDIF
4158: 
4159:         TRY
4160:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4161:                 "SigPrLcl", "cursor_4c_BuscaLcl", "Codigos", loc_cValor, ;
4162:                 "Buscar Localiza" + CHR(231) + CHR(227) + "o", .F., .T., "Tipos = 2")
4163: 
4164:             IF VARTYPE(loc_oBusca) = "O"
4165:                 IF !loc_oBusca.this_lAchouRegistro
4166:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
4167:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4168:                     loc_oBusca.Show()
4169:                 ENDIF
4170: 
4171:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLcl")
4172:                     IF VARTYPE(loc_oTxt) = "O"
4173:                         loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLcl.Codigos)
4174:                     ENDIF
4175:                 ENDIF
4176: 
4177:                 loc_oBusca.Release()
4178:             ENDIF
4179:         CATCH TO loc_oErro
4180:             MsgErro(loc_oErro.Message, "Erro AbrirLookupLocals")
4181:         ENDTRY
4182: 
4183:         IF USED("cursor_4c_BuscaLcl")
4184:             USE IN cursor_4c_BuscaLcl
4185:         ENDIF
4186:     ENDPROC
4187: 
4188:     *--------------------------------------------------------------------------
4189:     * AbrirLookupCodsegs - FormBuscaAuxiliar em SigCdSct (campo codsegs)
4190:     *--------------------------------------------------------------------------
4191:     PROCEDURE AbrirLookupCodsegs()
4192:         LOCAL loc_oBusca, loc_cValor, loc_oTxt
4193:         loc_cValor = ""
4194:         loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Codsegs
4195: 
4196:         IF VARTYPE(loc_oTxt) = "O"
4197:             loc_cValor = ALLTRIM(loc_oTxt.Value)
4198:         ENDIF
4199: 
4200:         TRY
4201:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4202:                 "SigCdSct", "cursor_4c_BuscaSct", "Codigos", loc_cValor, ;
4203:                 "Buscar Segmento")
4204: 
4205:             IF VARTYPE(loc_oBusca) = "O"
4206:                 IF !loc_oBusca.this_lAchouRegistro
4207:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4208:                     loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
4209:                     loc_oBusca.Show()
4210:                 ENDIF
4211: 
4212:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSct")
4213:                     IF VARTYPE(loc_oTxt) = "O"
4214:                         loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaSct.Codigos)
4215:                     ENDIF
4216:                 ENDIF
4217: 
4218:                 loc_oBusca.Release()
4219:             ENDIF
4220:         CATCH TO loc_oErro
4221:             MsgErro(loc_oErro.Message, "Erro AbrirLookupCodsegs")
4222:         ENDTRY
4223: 
4224:         IF USED("cursor_4c_BuscaSct")
4225:             USE IN cursor_4c_BuscaSct
4226:         ENDIF
4227:     ENDPROC
4228: 
4229:     *--------------------------------------------------------------------------
4230:     * TxtSubncrsDblClick - DblClick abre lookup SigCdOpe
4231:     *--------------------------------------------------------------------------
4232:     PROCEDURE TxtSubncrsDblClick()
4233:         THIS.AbrirLookupSubncrs()
4234:     ENDPROC
4235: 
4236:     *--------------------------------------------------------------------------
4237:     * TxtLocalsDblClick - DblClick abre lookup SigPrLcl
4238:     *--------------------------------------------------------------------------
4239:     PROCEDURE TxtLocalsDblClick()
4240:         THIS.AbrirLookupLocals()
4241:     ENDPROC
4242: 
4243:     *--------------------------------------------------------------------------
4244:     * TxtCodegsDblClick - DblClick abre lookup SigCdSct
4245:     *--------------------------------------------------------------------------
4246:     PROCEDURE TxtCodegsDblClick()
4247:         THIS.AbrirLookupCodsegs()
4248:     ENDPROC
4249: 
4250: ENDDEFINE


### BO (C:\4c\projeto\app\classes\GpeBO.prg):
* GpeBO.prg - Business Object para Cadastro de Grupos Operacionais
* Tabela principal: SigCdGpe | PK: dgopes
* Tabela filha: SigCdGpo (grid operacoes: dopers + confops)

DEFINE CLASS GpeBO AS BusinessBase

    *-- SigCdGpe: Identificacao
    this_cDgopes            = ""   && dgopes char(20) - PK Grupo Operacional
    this_nNgopes            = 0    && ngopes numeric(6,0) - Nro interno (fGerUniqueKey)

    *-- SigCdGpe: Numeracao e Controle
    this_nNumopers          = 0    && numopers numeric(1,0) - Numeracao da Operacao
    this_nNcontroles        = 0    && ncontroles numeric(1,0) - Tipo do Nro de Controle
    this_nFontnums          = 0    && fontnums numeric(1,0) - Fonte da Numeracao
    this_nLimdia            = 0    && limdia numeric(6,0) - Limite diario

    *-- SigCdGpe: Auditoria e Acesso
    this_nAudits            = 0    && audits numeric(1,0) - Auditoria (9 opcoes)
    this_nBlqadts           = 0    && blqadts numeric(1,0) - Bloqueia Alt. Data
    this_nInibfecs          = 0    && inibfecs numeric(1,0) - Inibir Botao Fechamento
    this_nInibocors         = 0    && inibocors numeric(1,0) - Inibir Botao Ocorrencia
    this_nAlterar           = 0    && alterar numeric(1,0) - Permitir Alteracao
    this_nConsulta          = 0    && consulta numeric(1,0) - Apenas Consulta
    this_nCtacusus          = 0    && ctacusus numeric(1,0) - Controlar Acesso por Usuario
    this_nSenresps          = 0    && senresps numeric(1,0) - Senha por Responsavel
    this_nAcmemps           = 0    && acmemps numeric(1,0) - Checar Acesso Muda Empresa
    this_nAnacps            = 0    && anacps numeric(1,0) - Analisar C.Pagto Fx.Cx

    *-- SigCdGpe: Situacoes (tristate)
    this_nSubniveis         = 0    && subniveis numeric(1,0) - Situacao dos Subniveis
    this_nUtilizas          = 0    && utilizas numeric(1,0) - Situacao das Operacoes
    this_nFilpagas          = 0    && filpagas numeric(1,0) - Filtro Operacoes Pagas
    this_nFilbaixas         = 0    && filbaixas numeric(1,0) - Filtro Operacoes Baixadas
    this_nOputiliza         = 0    && oputiliza numeric(1,0) - Operacoes Utilizadas
    this_nMontagem          = 0    && montagem numeric(1,0) - Produtos Com Montagem
    this_nQualquer          = 0    && qualquer numeric(1,0) - Ignorar Grupo Operacional
    this_nChkmercs          = 0    && chkmercs numeric(1,0) - Checar Mercadorias
    this_nProds             = 0    && prods numeric(1,0) - Ordem de Producao
    this_nDesutils          = 0    && desutils numeric(1,0) - Desagendar Utilizados
    this_nIniagenda         = 0    && iniagenda numeric(1,0) - Exibir botao F8 - AGENDA

    *-- SigCdGpe: Operacoes em filtro (ordem grade)
    this_nOpagends          = 0    && opagends numeric(1,0) - Operacoes Agendadas (filtro lista)
    this_nOppagas           = 0    && oppagas numeric(1,0) - Operacoes Pagas (filtro lista)
    this_nOppends           = 0    && oppends numeric(1,0) - Operacoes Todas/Agend./Nao-Agend.
    this_nOrdemas           = 0    && ordemas numeric(1,0) - Ordem das Agendadas (combobox)
    this_nOrdemns           = 0    && ordemns numeric(1,0) - Ordem das Nao-Agendadas (combobox)
    this_nOrdems            = 0    && ordems numeric(1,0) - Ordem de Todas (combobox)

    *-- SigCdGpe: Fixar ordenacao
    this_nFixaps            = 0    && fixaps numeric(1,0) - Fixa Pagas (checkbox)
    this_nFixaas            = 0    && fixaas numeric(1,0) - Fixa Agendadas (checkbox)
    this_nFixals            = 0    && fixals numeric(1,0) - Fixa Livres (checkbox Check1)
    this_nFixags            = 0    && fixags numeric(1,0) - Fixa Geral (checkbox)
    this_nFixass            = 0    && fixass numeric(1,0) - Fixa Sessao (checkbox Check2)

    *-- SigCdGpe: Utilizar recursos
    this_nResps             = 0    && resps numeric(1,0) - Utiliza Responsavel
    this_nContas            = 0    && contas numeric(1,0) - Utiliza Conta
    this_nEmpresas          = 0    && empresas numeric(1,0) - Utiliza Empresa
    this_nVends             = 0    && vends numeric(1,0) - Senha por Responsavel (Vendas)
    this_nSacs              = 0    && sacs numeric(1,0) - Checar SAC
    this_nVolumes           = 0    && volumes numeric(1,0) - Quantidade de Volumes
    this_nPeriodos          = 0    && periodos numeric(1,0) - Utiliza Periodo Configuracao
    this_nEntregas          = 0    && entregas numeric(1,0) - Utiliza Periodo Entrega
    this_nOperacoes         = 0    && operacoes numeric(1,0) - Utiliza Periodo Operacao
    this_nEstdisps          = 0    && estdisps numeric(1,0) - Estoque Disponivel
    this_nDtatuals          = 0    && dtatuals numeric(1,0) - Utilizar Data Atual
    this_nGeracrs           = 0    && geracrs numeric(1,0) - Gera Controle de Subniveis
    this_nChkreserva        = 0    && chkreserva numeric(1,0) - Credito/Bonus (optReserva)
    this_nMultiimps         = 0    && multiimps numeric(1,0) - Imprime Documentos
    this_nRoadshows         = 0    && roadshows numeric(1,0)
    this_nTpbloqueio        = 0    && tpbloqueio numeric(1,0) - Tipo de Bloqueio
    this_nChdtentrs         = 0    && chdtentrs numeric(1,0) - Checar Data de Entrega

    *-- SigCdGpe: Campos texto
    this_cSubncrs           = ""   && subncrs char(20) - Subnivel (lookup SigCdOpe)
    this_cLocals            = ""   && locals char(10) - Localizacao Padrao
    this_cCodsegs           = ""   && codsegs char(10) - Segmento Padrao (lookup SigCdSct)
    this_cCarqicones        = ""   && carqicones char(64) - Arquivo de icone
    this_cDopes             = ""   && dopes char(20) - Operacao Padrao (lookup SigCdOpe)
    this_cTproads           = ""   && tproads char(15)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGpe"
        THIS.this_cCampoChave = "dgopes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDgopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista SigCdGpe em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes FROM SigCdGpe"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY dgopes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos operacionais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega SigCdGpe pelo codigo do grupo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                " FROM SigCdGpe WHERE dgopes = " + EscaparSQL(par_cDgopes)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDgopes       = TratarNulo(dgopes, "C")
            THIS.this_nNgopes       = TratarNulo(ngopes, "N")
            THIS.this_nNumopers     = TratarNulo(numopers, "N")
            THIS.this_nNcontroles   = TratarNulo(ncontroles, "N")
            THIS.this_nFontnums     = TratarNulo(fontnums, "N")
            THIS.this_nLimdia       = TratarNulo(limdia, "N")
            THIS.this_nAudits       = TratarNulo(audits, "N")
            THIS.this_nBlqadts      = TratarNulo(blqadts, "N")
            THIS.this_nInibfecs     = TratarNulo(inibfecs, "N")
            THIS.this_nInibocors    = TratarNulo(inibocors, "N")
            THIS.this_nAlterar      = TratarNulo(alterar, "N")
            THIS.this_nConsulta     = TratarNulo(consulta, "N")
            THIS.this_nCtacusus     = TratarNulo(ctacusus, "N")
            THIS.this_nSenresps     = TratarNulo(senresps, "N")
            THIS.this_nAcmemps      = TratarNulo(acmemps, "N")
            THIS.this_nAnacps       = TratarNulo(anacps, "N")
            THIS.this_nSubniveis    = TratarNulo(subniveis, "N")
            THIS.this_nUtilizas     = TratarNulo(utilizas, "N")
            THIS.this_nFilpagas     = TratarNulo(filpagas, "N")
            THIS.this_nFilbaixas    = TratarNulo(filbaixas, "N")
            THIS.this_nOputiliza    = TratarNulo(oputiliza, "N")
            THIS.this_nMontagem     = TratarNulo(montagem, "N")
            THIS.this_nQualquer     = TratarNulo(qualquer, "N")
            THIS.this_nChkmercs     = TratarNulo(chkmercs, "N")
            THIS.this_nProds        = TratarNulo(prods, "N")
            THIS.this_nDesutils     = TratarNulo(desutils, "N")
            THIS.this_nIniagenda    = TratarNulo(iniagenda, "N")
            THIS.this_nOpagends     = TratarNulo(opagends, "N")
            THIS.this_nOppagas      = TratarNulo(oppagas, "N")
            THIS.this_nOppends      = TratarNulo(oppends, "N")
            THIS.this_nOrdemas      = TratarNulo(ordemas, "N")
            THIS.this_nOrdemns      = TratarNulo(ordemns, "N")
            THIS.this_nOrdems       = TratarNulo(ordems, "N")
            THIS.this_nFixaps       = TratarNulo(fixaps, "N")
            THIS.this_nFixaas       = TratarNulo(fixaas, "N")
            THIS.this_nFixals       = TratarNulo(fixals, "N")
            THIS.this_nFixags       = TratarNulo(fixags, "N")
            THIS.this_nFixass       = TratarNulo(fixass, "N")
            THIS.this_nResps        = TratarNulo(resps, "N")
            THIS.this_nContas       = TratarNulo(contas, "N")
            THIS.this_nEmpresas     = TratarNulo(empresas, "N")
            THIS.this_nVends        = TratarNulo(vends, "N")
            THIS.this_nSacs         = TratarNulo(sacs, "N")
            THIS.this_nVolumes      = TratarNulo(volumes, "N")
            THIS.this_nPeriodos     = TratarNulo(periodos, "N")
            THIS.this_nEntregas     = TratarNulo(entregas, "N")
            THIS.this_nOperacoes    = TratarNulo(operacoes, "N")
            THIS.this_nEstdisps     = TratarNulo(estdisps, "N")
            THIS.this_nDtatuals     = TratarNulo(dtatuals, "N")
            THIS.this_nGeracrs      = TratarNulo(geracrs, "N")
            THIS.this_nChkreserva   = TratarNulo(chkreserva, "N")
            THIS.this_nMultiimps    = TratarNulo(multiimps, "N")
            THIS.this_nRoadshows    = TratarNulo(roadshows, "N")
            THIS.this_nTpbloqueio   = TratarNulo(tpbloqueio, "N")
            THIS.this_nChdtentrs    = TratarNulo(chdtentrs, "N")
            THIS.this_cSubncrs      = TratarNulo(subncrs, "C")
            THIS.this_cLocals       = TratarNulo(locals, "C")
            THIS.this_cCodsegs      = TratarNulo(codsegs, "C")
            THIS.this_cCarqicones   = TratarNulo(carqicones, "C")
            THIS.this_cDopes        = TratarNulo(dopes, "C")
            THIS.this_cTproads      = TratarNulo(tproads, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdGpe
    * ngopes gerado via fGerUniqueKey("SigCdGpe")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_nNgopes = fGerUniqueKey("SigCdGpe")

            loc_cSQL = "INSERT INTO SigCdGpe (" + ;
                "dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cDgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumopers) + "," + ;
                FormatarNumeroSQL(THIS.this_nNcontroles) + "," + ;
                FormatarNumeroSQL(THIS.this_nFontnums) + "," + ;
                FormatarNumeroSQL(THIS.this_nLimdia) + "," + ;
                FormatarNumeroSQL(THIS.this_nAudits) + "," + ;
                FormatarNumeroSQL(THIS.this_nBlqadts) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibfecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibocors) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlterar) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsulta) + "," + ;
                FormatarNumeroSQL(THIS.this_nCtacusus) + "," + ;
                FormatarNumeroSQL(THIS.this_nSenresps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAcmemps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAnacps) + "," + ;
                FormatarNumeroSQL(THIS.this_nSubniveis) + "," + ;
                FormatarNumeroSQL(THIS.this_nUtilizas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilpagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilbaixas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOputiliza) + "," + ;
                FormatarNumeroSQL(THIS.this_nMontagem) + "," + ;
                FormatarNumeroSQL(THIS.this_nQualquer) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkmercs) + "," + ;
                FormatarNumeroSQL(THIS.this_nProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDesutils) + "," + ;
                FormatarNumeroSQL(THIS.this_nIniagenda) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpagends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemns) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdems) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaps) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixals) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixags) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixass) + "," + ;
                FormatarNumeroSQL(THIS.this_nResps) + "," + ;
                FormatarNumeroSQL(THIS.this_nContas) + "," + ;
                FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                FormatarNumeroSQL(THIS.this_nSacs) + "," + ;
                FormatarNumeroSQL(THIS.this_nVolumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeriodos) + "," + ;
                FormatarNumeroSQL(THIS.this_nEntregas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOperacoes) + "," + ;
                FormatarNumeroSQL(THIS.this_nEstdisps) + "," + ;
                FormatarNumeroSQL(THIS.this_nDtatuals) + "," + ;
                FormatarNumeroSQL(THIS.this_nGeracrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkreserva) + "," + ;
                FormatarNumeroSQL(THIS.this_nMultiimps) + "," + ;
                FormatarNumeroSQL(THIS.this_nRoadshows) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpbloqueio) + "," + ;
                FormatarNumeroSQL(THIS.this_nChdtentrs) + "," + ;
                EscaparSQL(THIS.this_cSubncrs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cCodsegs) + "," + ;
                EscaparSQL(THIS.this_cCarqicones) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cTproads) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdGpe (nao atualiza dgopes/ngopes - sao PK/chave)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGpe SET" + ;
                " numopers = " + FormatarNumeroSQL(THIS.this_nNumopers) + ;
                ", ncontroles = " + FormatarNumeroSQL(THIS.this_nNcontroles) + ;
                ", fontnums = " + FormatarNumeroSQL(THIS.this_nFontnums) + ;
                ", limdia = " + FormatarNumeroSQL(THIS.this_nLimdia) + ;
                ", audits = " + FormatarNumeroSQL(THIS.this_nAudits) + ;
                ", blqadts = " + FormatarNumeroSQL(THIS.this_nBlqadts) + ;
                ", inibfecs = " + FormatarNumeroSQL(THIS.this_nInibfecs) + ;
                ", inibocors = " + FormatarNumeroSQL(THIS.this_nInibocors) + ;
                ", alterar = " + FormatarNumeroSQL(THIS.this_nAlterar) + ;
                ", consulta = " + FormatarNumeroSQL(THIS.this_nConsulta) + ;
                ", ctacusus = " + FormatarNumeroSQL(THIS.this_nCtacusus) + ;
                ", senresps = " + FormatarNumeroSQL(THIS.this_nSenresps) + ;
                ", acmemps = " + FormatarNumeroSQL(THIS.this_nAcmemps) + ;
                ", anacps = " + FormatarNumeroSQL(THIS.this_nAnacps) + ;
                ", subniveis = " + FormatarNumeroSQL(THIS.this_nSubniveis) + ;
                ", utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas) + ;
                ", filpagas = " + FormatarNumeroSQL(THIS.this_nFilpagas) + ;
                ", filbaixas = " + FormatarNumeroSQL(THIS.this_nFilbaixas) + ;
                ", oputiliza = " + FormatarNumeroSQL(THIS.this_nOputiliza) + ;
                ", montagem = " + FormatarNumeroSQL(THIS.this_nMontagem) + ;
                ", qualquer = " + FormatarNumeroSQL(THIS.this_nQualquer) + ;
                ", chkmercs = " + FormatarNumeroSQL(THIS.this_nChkmercs) + ;
                ", prods = " + FormatarNumeroSQL(THIS.this_nProds) + ;
                ", desutils = " + FormatarNumeroSQL(THIS.this_nDesutils) + ;
                ", iniagenda = " + FormatarNumeroSQL(THIS.this_nIniagenda) + ;
                ", opagends = " + FormatarNumeroSQL(THIS.this_nOpagends) + ;
                ", oppagas = " + FormatarNumeroSQL(THIS.this_nOppagas) + ;
                ", oppends = " + FormatarNumeroSQL(THIS.this_nOppends) + ;
                ", ordemas = " + FormatarNumeroSQL(THIS.this_nOrdemas) + ;
                ", ordemns = " + FormatarNumeroSQL(THIS.this_nOrdemns) + ;
                ", ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ;
                ", fixaps = " + FormatarNumeroSQL(THIS.this_nFixaps) + ;
                ", fixaas = " + FormatarNumeroSQL(THIS.this_nFixaas) + ;
                ", fixals = " + FormatarNumeroSQL(THIS.this_nFixals) + ;
                ", fixags = " + FormatarNumeroSQL(THIS.this_nFixags) + ;
                ", fixass = " + FormatarNumeroSQL(THIS.this_nFixass) + ;
                ", resps = " + FormatarNumeroSQL(THIS.this_nResps) + ;
                ", contas = " + FormatarNumeroSQL(THIS.this_nContas) + ;
                ", empresas = " + FormatarNumeroSQL(THIS.this_nEmpresas) + ;
                ", vends = " + FormatarNumeroSQL(THIS.this_nVends) + ;
                ", sacs = " + FormatarNumeroSQL(THIS.this_nSacs) + ;
                ", volumes = " + FormatarNumeroSQL(THIS.this_nVolumes) + ;
                ", periodos = " + FormatarNumeroSQL(THIS.this_nPeriodos) + ;
                ", entregas = " + FormatarNumeroSQL(THIS.this_nEntregas) + ;
                ", operacoes = " + FormatarNumeroSQL(THIS.this_nOperacoes) + ;
                ", estdisps = " + FormatarNumeroSQL(THIS.this_nEstdisps) + ;
                ", dtatuals = " + FormatarNumeroSQL(THIS.this_nDtatuals) + ;
                ", geracrs = " + FormatarNumeroSQL(THIS.this_nGeracrs) + ;
                ", chkreserva = " + FormatarNumeroSQL(THIS.this_nChkreserva) + ;
                ", multiimps = " + FormatarNumeroSQL(THIS.this_nMultiimps) + ;
                ", roadshows = " + FormatarNumeroSQL(THIS.this_nRoadshows) + ;
                ", tpbloqueio = " + FormatarNumeroSQL(THIS.this_nTpbloqueio) + ;
                ", chdtentrs = " + FormatarNumeroSQL(THIS.this_nChdtentrs) + ;
                ", subncrs = " + EscaparSQL(THIS.this_cSubncrs) + ;
                ", locals = " + EscaparSQL(THIS.this_cLocals) + ;
                ", codsegs = " + EscaparSQL(THIS.this_cCodsegs) + ;
                ", carqicones = " + EscaparSQL(THIS.this_cCarqicones) + ;
                ", dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                ", tproads = " + EscaparSQL(THIS.this_cTproads) + ;
                " WHERE dgopes = " + EscaparSQL(THIS.this_cDgopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdGpe e registros filhos SigCdGpo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Excluir operacoes filhas em SigCdGpo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + ;
                EscaparSQL(THIS.this_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es do grupo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal
                loc_cSQL = "DELETE FROM SigCdGpe WHERE dgopes = " + ;
                    EscaparSQL(THIS.this_cDgopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega SigCdGpo (grid de operacoes) em cursor_4c_Operacoes
    * SigCdGpo: dgopes(FK), dopers(op. possivel), confops(op. conferencia), cidchaves(PK)
    *--------------------------------------------------------------------------
    FUNCTION BuscarOperacoes(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dopers, confops, cidchaves FROM SigCdGpo" + ;
                " WHERE dgopes = " + EscaparSQL(par_cDgopes) + ;
                " ORDER BY cidchaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Operacoes")
                TABLEREVERT(.T., "cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarOperacoes - Persiste grid de operacoes (SigCdGpo) do grupo
    * par_cDgopes: codigo do grupo
    * par_cCursorOps: nome do cursor com linhas editadas (campos: dopers, confops)
    * Estrategia: DELETE todas + INSERT das linhas nao vazias
    *--------------------------------------------------------------------------
    FUNCTION SalvarOperacoes(par_cDgopes, par_cCursorOps)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nLinha, loc_cChave
        LOCAL loc_cDopers, loc_cConfops
        loc_lResultado = .F.

        TRY
            *-- Excluir todas as operacoes do grupo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + EscaparSQL(par_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
                IF USED(par_cCursorOps) AND RECCOUNT(par_cCursorOps) > 0
                    SELECT (par_cCursorOps)
                    GO TOP
                    loc_nLinha = 0
                    DO WHILE !EOF() AND loc_lResultado
                        loc_cDopers  = ALLTRIM(dopers)
                        loc_cConfops = ALLTRIM(confops)
                        IF !EMPTY(loc_cDopers)
                            loc_nLinha = loc_nLinha + 1
                            loc_cChave = LEFT(ALLTRIM(par_cDgopes) + ;
                                STR(loc_nLinha, 6), 20)
                            loc_cSQL = "INSERT INTO SigCdGpo" + ;
                                " (dgopes, dopers, confops, cidchaves) VALUES (" + ;
                                EscaparSQL(par_cDgopes) + "," + ;
                                EscaparSQL(loc_cDopers) + "," + ;
                                EscaparSQL(loc_cConfops) + "," + ;
                                EscaparSQL(loc_cChave) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + ;
                                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                        SKIP
                    ENDDO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

