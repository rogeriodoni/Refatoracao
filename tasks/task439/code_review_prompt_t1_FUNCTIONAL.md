# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Operacoes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormGpe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4242 linhas total):

*-- Linhas 26 a 144:
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
56:                 THIS.ConfigurarPaginaLista()
57:                 THIS.ConfigurarPaginaDados()
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 THIS.pgf_4c_Paginas.Visible = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66:                 loc_lResultado = .T.
67:             ENDIF
68:         CATCH TO loc_oErro
69:             MsgErro(loc_oErro.Message + CHR(13) + ;
70:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
71:                 "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
72:         ENDTRY
73: 
74:         RETURN loc_lResultado
75:     ENDPROC
76: 
77:     *--------------------------------------------------------------------------
78:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
79:     *--------------------------------------------------------------------------
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount  = 2
85:             .Top        = -29
86:             .Left       = 0
87:             .Width      = THIS.Width
88:             .Height     = THIS.Height + 29
89:             .Tabs       = .F.
90:             .Visible    = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95:             .Page2.Caption   = "Dados"
96:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page2.BackColor = RGB(255, 255, 255)
98:         ENDWITH
99:     ENDPROC
100: 
101:     *--------------------------------------------------------------------------
102:     * ConfigurarPaginaLista - Configura Page1 (Lista de registros)
103:     *--------------------------------------------------------------------------
104:     PROTECTED PROCEDURE ConfigurarPaginaLista()
105:         LOCAL loc_oPagina
106:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
107: 
108:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
109:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110: 
111:         *-- Container cabecalho cinza superior
112:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH loc_oPagina.cnt_4c_Cabecalho
114:             .Top         = 2
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121: 
122:             .AddObject("lbl_4c_Sombra", "Label")
123:             WITH .lbl_4c_Sombra
124:                 .Caption   = THIS.Caption
125:                 .Top       = 15
126:                 .Left      = 10
127:                 .Width     = THIS.Width
128:                 .Height    = 40
129:                 .FontName  = "Tahoma"
130:                 .FontSize  = 16
131:                 .FontBold  = .T.
132:                 .ForeColor = RGB(0, 0, 0)
133:                 .BackStyle = 0
134:                 .AutoSize  = .F.
135:                 .Visible   = .T.
136:             ENDWITH
137: 
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Caption   = THIS.Caption
141:                 .Top       = 18
142:                 .Left      = 10
143:                 .Width     = THIS.Width
144:                 .Height    = 46

*-- Linhas 391 a 451:
391:             .Column2.Header1.Caption = "N" + CHR(186)
392:         ENDWITH
393: 
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395: 
396:         *-- BINDEVENTs dos botoes da Page1
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
399:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
400:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
401:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
402:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
403:         BINDEVENT(loc_oPagina.cmd_4c_MontaLista,               "Click", THIS, "BtnMontaListaClick")
404:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML,                "Click", THIS, "BtnImpXMLClick")
405:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML,                "Click", THIS, "BtnExpXMLClick")
406:     ENDPROC
407: 
408:     *--------------------------------------------------------------------------
409:     * ConfigurarPaginaDados - Configura Page2 (Dados do registro)
410:     *--------------------------------------------------------------------------
411:     PROTECTED PROCEDURE ConfigurarPaginaDados()
412:         LOCAL loc_oPagina
413:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
414: 
415:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
416:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
417: 
418:         *-- Container botoes Confirmar/Cancelar (topo direito)
419:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
420:         WITH loc_oPagina.cnt_4c_BotoesAcao
421:             .Top         = 33
422:             .Left        = 842
423:             .Width       = 160
424:             .Height      = 85
425:             .BackStyle   = 0
426:             .BorderWidth = 0
427:             .Visible     = .T.
428: 
429:             .AddObject("cmd_4c_Confirmar", "CommandButton")
430:             WITH .cmd_4c_Confirmar
431:                 .Caption         = "Confirmar"
432:                 .Top             = 5
433:                 .Left            = 5
434:                 .Width           = 75
435:                 .Height          = 75
436:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
437:                 .PicturePosition = 13
438:                 .FontName        = "Comic Sans MS"
439:                 .FontSize        = 8
440:                 .FontBold        = .T.
441:                 .FontItalic      = .T.
442:                 .ForeColor       = RGB(90, 90, 90)
443:                 .BackColor       = RGB(255, 255, 255)
444:                 .SpecialEffect   = 0
445:                 .MousePointer    = 15
446:                 .WordWrap        = .T.
447:                 .Visible         = .T.
448:             ENDWITH
449: 
450:             .AddObject("cmd_4c_Cancelar", "CommandButton")
451:             WITH .cmd_4c_Cancelar

*-- Linhas 553 a 643:
553:         THIS.ConfigurarPgConfig(loc_oPagina.pgf_4c_Dados.Page1)
554:         THIS.ConfigurarPgCompls(loc_oPagina.pgf_4c_Dados.Page2)
555: 
556:         THIS.TornarControlesVisiveis(loc_oPagina)
557: 
558:         *-- BINDEVENTs dos botoes da Page2
559:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
560:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
561:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.cmd_4c_Icone,    "Click", THIS, "BtnIconeClick")
562: 
563:         *-- BINDEVENTs para lookup dos campos de texto (Enter/Tab/F4 abre picker)
564:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Subncrs, ;
565:             "KeyPress", THIS, "TxtSubncrsKeyPress")
566:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Locals, ;
567:             "KeyPress", THIS, "TxtLocalsKeyPress")
568:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Codsegs, ;
569:             "KeyPress", THIS, "TxtCodegsKeyPress")
570: 
571:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Subncrs, ;
572:             "DblClick", THIS, "TxtSubncrsDblClick")
573:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Locals, ;
574:             "DblClick", THIS, "TxtLocalsDblClick")
575:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Codsegs, ;
576:             "DblClick", THIS, "TxtCodegsDblClick")
577:     ENDPROC
578: 
579:     *--------------------------------------------------------------------------
580:     * ConfigurarPgConfig - Configura aba Configuracoes (pgf_4c_Dados.Page1)
581:     * Coordenadas relativas a pagina (sem compensacao +29)
582:     *--------------------------------------------------------------------------
583:     PROTECTED PROCEDURE ConfigurarPgConfig(par_oPg)
584: 
585:         *-- COLUNA ESQUERDA: OptionGroups e labels (Left=167, Width=247)
586: 
587:         *-- Numeracao da Operacao (numopers)
588:         par_oPg.AddObject("lbl_4c_NumOper", "Label")
589:         WITH par_oPg.lbl_4c_NumOper
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .Caption   = "Numera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o :"
593:             .Top       = 13
594:             .Left      = 36
595:             .Width     = 128
596:             .Height    = 15
597:             .ForeColor = RGB(90, 90, 90)
598:             .BackStyle = 0
599:             .AutoSize  = .F.
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         par_oPg.AddObject("opt_4c_NumOper", "OptionGroup")
604:         WITH par_oPg.opt_4c_NumOper
605:             .ButtonCount = 3
606:             .AutoSize    = .F.
607:             .BackStyle   = 0
608:             .BorderStyle = 0
609:             .Height      = 21
610:             .Left        = 167
611:             .Top         = 8
612:             .Width       = 247
613:             .Value       = 1
614:             .Visible     = .T.
615:             .Buttons(1).Caption   = "No. Controle"
616:             .Buttons(1).FontSize  = 8
617:             .Buttons(1).BackStyle = 0
618:             .Buttons(1).Left      = 3
619:             .Buttons(1).Top       = 3
620:             .Buttons(1).Width     = 79
621:             .Buttons(1).AutoSize  = .T.
622:             .Buttons(1).ForeColor = RGB(90, 90, 90)
623:             .Buttons(2).Caption   = "Autom" + CHR(225) + "tica"
624:             .Buttons(2).FontSize  = 8
625:             .Buttons(2).BackStyle = 0
626:             .Buttons(2).Left      = 82
627:             .Buttons(2).Top       = 3
628:             .Buttons(2).Width     = 72
629:             .Buttons(2).AutoSize  = .T.
630:             .Buttons(2).ForeColor = RGB(90, 90, 90)
631:             .Buttons(3).Caption   = "Oper + No.Ctrl"
632:             .Buttons(3).FontSize  = 8
633:             .Buttons(3).BackStyle = 0
634:             .Buttons(3).Left      = 159
635:             .Buttons(3).Top       = 3
636:             .Buttons(3).Width     = 90
637:             .Buttons(3).AutoSize  = .T.
638:             .Buttons(3).ForeColor = RGB(90, 90, 90)
639:         ENDWITH
640: 
641:         *-- Tipo do No de Controle (ncontroles)
642:         par_oPg.AddObject("lbl_4c_Controle", "Label")
643:         WITH par_oPg.lbl_4c_Controle

*-- Linhas 654 a 697:
654:             .Visible   = .T.
655:         ENDWITH
656: 
657:         par_oPg.AddObject("opt_4c_Controle", "OptionGroup")
658:         WITH par_oPg.opt_4c_Controle
659:             .ButtonCount = 3
660:             .AutoSize    = .F.
661:             .BackStyle   = 0
662:             .BorderStyle = 0
663:             .Height      = 22
664:             .Left        = 167
665:             .Top         = 29
666:             .Width       = 247
667:             .Value       = 1
668:             .Visible     = .T.
669:             .Buttons(1).Caption      = "Empresa"
670:             .Buttons(1).ToolTipText  = "Tipo Espelho ( EEENNNNNN )"
671:             .Buttons(1).FontSize     = 8
672:             .Buttons(1).BackStyle    = 0
673:             .Buttons(1).Left         = 3
674:             .Buttons(1).Top          = 3
675:             .Buttons(1).Width        = 59
676:             .Buttons(1).AutoSize     = .T.
677:             .Buttons(1).ForeColor    = RGB(90, 90, 90)
678:             .Buttons(2).Caption      = "Opera" + CHR(231) + CHR(227) + "o"
679:             .Buttons(2).ToolTipText  = "Tipo Boleto ( OONNNNNN )"
680:             .Buttons(2).FontSize     = 8
681:             .Buttons(2).BackStyle    = 0
682:             .Buttons(2).Left         = 82
683:             .Buttons(2).Top          = 3
684:             .Buttons(2).Width        = 65
685:             .Buttons(2).AutoSize     = .T.
686:             .Buttons(2).ForeColor    = RGB(90, 90, 90)
687:             .Buttons(3).Caption      = "Manual"
688:             .Buttons(3).ToolTipText  = "Tipo Manual ( NNNNNN )"
689:             .Buttons(3).FontSize     = 8
690:             .Buttons(3).BackStyle    = 0
691:             .Buttons(3).Left         = 159
692:             .Buttons(3).Top          = 3
693:             .Buttons(3).Width        = 61
694:             .Buttons(3).AutoSize     = .T.
695:             .Buttons(3).ForeColor    = RGB(90, 90, 90)
696:         ENDWITH
697: 

*-- Linhas 711 a 800:
711:             .Visible   = .T.
712:         ENDWITH
713: 
714:         par_oPg.AddObject("opt_4c_FonNum", "OptionGroup")
715:         WITH par_oPg.opt_4c_FonNum
716:             .ButtonCount = 2
717:             .AutoSize    = .F.
718:             .BackStyle   = 0
719:             .BorderStyle = 0
720:             .Height      = 21
721:             .Left        = 167
722:             .Top         = 51
723:             .Width       = 247
724:             .Value       = 2
725:             .Visible     = .T.
726:             .Buttons(1).Caption   = "Grupo"
727:             .Buttons(1).FontSize  = 8
728:             .Buttons(1).BackStyle = 0
729:             .Buttons(1).Left      = 3
730:             .Buttons(1).Top       = 3
731:             .Buttons(1).Width     = 47
732:             .Buttons(1).AutoSize  = .T.
733:             .Buttons(1).ForeColor = RGB(90, 90, 90)
734:             .Buttons(2).Caption   = "Opera" + CHR(231) + CHR(227) + "o"
735:             .Buttons(2).FontSize  = 8
736:             .Buttons(2).BackStyle = 0
737:             .Buttons(2).Left      = 82
738:             .Buttons(2).Top       = 3
739:             .Buttons(2).Width     = 65
740:             .Buttons(2).AutoSize  = .T.
741:             .Buttons(2).ForeColor = RGB(90, 90, 90)
742:         ENDWITH
743: 
744:         *-- Situacao das Operacoes (utilizas)
745:         par_oPg.AddObject("lbl_4c_Utilizas", "Label")
746:         WITH par_oPg.lbl_4c_Utilizas
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es:"
750:             .Top       = 75
751:             .Left      = 42
752:             .Width     = 122
753:             .Height    = 15
754:             .ForeColor = RGB(90, 90, 90)
755:             .BackStyle = 0
756:             .AutoSize  = .F.
757:             .Visible   = .T.
758:         ENDWITH
759: 
760:         par_oPg.AddObject("opt_4c_Utilizas", "OptionGroup")
761:         WITH par_oPg.opt_4c_Utilizas
762:             .ButtonCount = 3
763:             .AutoSize    = .F.
764:             .BackStyle   = 0
765:             .BorderStyle = 0
766:             .Height      = 22
767:             .Left        = 167
768:             .Top         = 72
769:             .Width       = 247
770:             .Value       = 1
771:             .Visible     = .T.
772:             .Buttons(1).Caption   = "Todas"
773:             .Buttons(1).FontSize  = 8
774:             .Buttons(1).BackStyle = 0
775:             .Buttons(1).Left      = 3
776:             .Buttons(1).Top       = 3
777:             .Buttons(1).Width     = 47
778:             .Buttons(1).AutoSize  = .T.
779:             .Buttons(1).ForeColor = RGB(90, 90, 90)
780:             .Buttons(2).Caption   = "Utilizadas"
781:             .Buttons(2).FontSize  = 8
782:             .Buttons(2).BackStyle = 0
783:             .Buttons(2).Left      = 82
784:             .Buttons(2).Top       = 3
785:             .Buttons(2).Width     = 63
786:             .Buttons(2).AutoSize  = .T.
787:             .Buttons(2).ForeColor = RGB(90, 90, 90)
788:             .Buttons(3).Caption   = "N" + CHR(227) + "o Utilizadas"
789:             .Buttons(3).FontSize  = 8
790:             .Buttons(3).BackStyle = 0
791:             .Buttons(3).Left      = 159
792:             .Buttons(3).Top       = 3
793:             .Buttons(3).Width     = 73
794:             .Buttons(3).AutoSize  = .T.
795:             .Buttons(3).ForeColor = RGB(90, 90, 90)
796:         ENDWITH
797: 
798:         *-- Situacao dos Subniveis (subniveis)
799:         par_oPg.AddObject("lbl_4c_Subniveis", "Label")
800:         WITH par_oPg.lbl_4c_Subniveis

*-- Linhas 811 a 854:
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         par_oPg.AddObject("opt_4c_Subniveis", "OptionGroup")
815:         WITH par_oPg.opt_4c_Subniveis
816:             .ButtonCount = 3
817:             .AutoSize    = .F.
818:             .BackStyle   = 0
819:             .BorderStyle = 0
820:             .Height      = 22
821:             .Left        = 167
822:             .Top         = 94
823:             .Width       = 247
824:             .Value       = 1
825:             .Visible     = .T.
826:             .Buttons(1).Caption   = "Todos"
827:             .Buttons(1).FontSize  = 8
828:             .Buttons(1).BackStyle = 0
829:             .Buttons(1).Left      = 3
830:             .Buttons(1).Top       = 3
831:             .Buttons(1).Width     = 47
832:             .Buttons(1).AutoSize  = .T.
833:             .Buttons(1).ForeColor = RGB(90, 90, 90)
834:             .Buttons(2).Caption   = "Pendentes"
835:             .Buttons(2).FontSize  = 8
836:             .Buttons(2).BackStyle = 0
837:             .Buttons(2).Left      = 82
838:             .Buttons(2).Top       = 3
839:             .Buttons(2).Width     = 69
840:             .Buttons(2).AutoSize  = .T.
841:             .Buttons(2).ForeColor = RGB(90, 90, 90)
842:             .Buttons(3).Caption   = "Baixados"
843:             .Buttons(3).FontSize  = 8
844:             .Buttons(3).BackStyle = 0
845:             .Buttons(3).Left      = 159
846:             .Buttons(3).Top       = 3
847:             .Buttons(3).Width     = 61
848:             .Buttons(3).AutoSize  = .T.
849:             .Buttons(3).ForeColor = RGB(90, 90, 90)
850:         ENDWITH
851: 
852:         *-- Ordem de Producao (prods)
853:         par_oPg.AddObject("lbl_4c_Prods", "Label")
854:         WITH par_oPg.lbl_4c_Prods

*-- Linhas 865 a 908:
865:             .Visible   = .T.
866:         ENDWITH
867: 
868:         par_oPg.AddObject("opt_4c_Prods", "OptionGroup")
869:         WITH par_oPg.opt_4c_Prods
870:             .ButtonCount = 3
871:             .AutoSize    = .F.
872:             .BackStyle   = 0
873:             .BorderStyle = 0
874:             .Height      = 22
875:             .Left        = 167
876:             .Top         = 116
877:             .Width       = 247
878:             .Value       = 1
879:             .Visible     = .T.
880:             .Buttons(1).Caption   = "Todas"
881:             .Buttons(1).FontSize  = 8
882:             .Buttons(1).BackStyle = 0
883:             .Buttons(1).Left      = 3
884:             .Buttons(1).Top       = 3
885:             .Buttons(1).Width     = 47
886:             .Buttons(1).AutoSize  = .T.
887:             .Buttons(1).ForeColor = RGB(90, 90, 90)
888:             .Buttons(2).Caption   = "Com OP"
889:             .Buttons(2).FontSize  = 8
890:             .Buttons(2).BackStyle = 0
891:             .Buttons(2).Left      = 82
892:             .Buttons(2).Top       = 3
893:             .Buttons(2).Width     = 56
894:             .Buttons(2).AutoSize  = .T.
895:             .Buttons(2).ForeColor = RGB(90, 90, 90)
896:             .Buttons(3).Caption   = "Sem OP"
897:             .Buttons(3).FontSize  = 8
898:             .Buttons(3).BackStyle = 0
899:             .Buttons(3).Left      = 159
900:             .Buttons(3).Top       = 3
901:             .Buttons(3).Width     = 55
902:             .Buttons(3).AutoSize  = .T.
903:             .Buttons(3).ForeColor = RGB(90, 90, 90)
904:         ENDWITH
905: 
906:         *-- Desagendar Utilizados (desutils)
907:         par_oPg.AddObject("lbl_4c_Desutils", "Label")
908:         WITH par_oPg.lbl_4c_Desutils

*-- Linhas 919 a 1138:
919:             .Visible   = .T.
920:         ENDWITH
921: 
922:         par_oPg.AddObject("opt_4c_Desutils", "OptionGroup")
923:         WITH par_oPg.opt_4c_Desutils
924:             .ButtonCount = 2
925:             .AutoSize    = .F.
926:             .BackStyle   = 0
927:             .BorderStyle = 0
928:             .Height      = 22
929:             .Left        = 167
930:             .Top         = 138
931:             .Width       = 247
932:             .Value       = 2
933:             .Visible     = .T.
934:             .Buttons(1).Caption   = "Sim"
935:             .Buttons(1).FontSize  = 8
936:             .Buttons(1).BackStyle = 0
937:             .Buttons(1).Left      = 3
938:             .Buttons(1).Top       = 3
939:             .Buttons(1).Width     = 34
940:             .Buttons(1).AutoSize  = .T.
941:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
942:             .Buttons(2).FontSize  = 8
943:             .Buttons(2).BackStyle = 0
944:             .Buttons(2).Left      = 82
945:             .Buttons(2).Top       = 3
946:             .Buttons(2).Width     = 37
947:             .Buttons(2).AutoSize  = .T.
948:         ENDWITH
949: 
950:         *-- Exibir botao F8 - AGENDA (iniagenda)
951:         par_oPg.AddObject("lbl_4c_Iniagenda", "Label")
952:         WITH par_oPg.lbl_4c_Iniagenda
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .Caption   = "Exibir bot" + CHR(227) + "o F8 - AGENDA:"
956:             .Top       = 163
957:             .Left      = 35
958:             .Width     = 129
959:             .Height    = 15
960:             .ForeColor = RGB(90, 90, 90)
961:             .BackStyle = 0
962:             .AutoSize  = .F.
963:             .Visible   = .T.
964:         ENDWITH
965: 
966:         par_oPg.AddObject("opt_4c_Iniagenda", "OptionGroup")
967:         WITH par_oPg.opt_4c_Iniagenda
968:             .ButtonCount = 2
969:             .AutoSize    = .F.
970:             .BackStyle   = 0
971:             .BorderStyle = 0
972:             .Height      = 22
973:             .Left        = 167
974:             .Top         = 160
975:             .Width       = 247
976:             .Value       = 2
977:             .Visible     = .T.
978:             .Buttons(1).Caption   = "Sim"
979:             .Buttons(1).FontSize  = 8
980:             .Buttons(1).BackStyle = 0
981:             .Buttons(1).Left      = 3
982:             .Buttons(1).Top       = 3
983:             .Buttons(1).Width     = 34
984:             .Buttons(1).AutoSize  = .T.
985:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
986:             .Buttons(2).FontSize  = 8
987:             .Buttons(2).BackStyle = 0
988:             .Buttons(2).Left      = 82
989:             .Buttons(2).Top       = 3
990:             .Buttons(2).Width     = 37
991:             .Buttons(2).AutoSize  = .T.
992:         ENDWITH
993: 
994:         *-- Ignorar Grupo Operacional (qualquer)
995:         par_oPg.AddObject("lbl_4c_Qualquer", "Label")
996:         WITH par_oPg.lbl_4c_Qualquer
997:             .FontName  = "Tahoma"
998:             .FontSize  = 8
999:             .Caption   = "Ignorar Grupo Operacional :"
1000:             .Top       = 185
1001:             .Left      = 27
1002:             .Width     = 137
1003:             .Height    = 15
1004:             .ForeColor = RGB(90, 90, 90)
1005:             .BackStyle = 0
1006:             .AutoSize  = .F.
1007:             .Visible   = .T.
1008:         ENDWITH
1009: 
1010:         par_oPg.AddObject("opt_4c_Qualquer", "OptionGroup")
1011:         WITH par_oPg.opt_4c_Qualquer
1012:             .ButtonCount = 2
1013:             .AutoSize    = .F.
1014:             .BackStyle   = 0
1015:             .BorderStyle = 0
1016:             .Height      = 22
1017:             .Left        = 167
1018:             .Top         = 182
1019:             .Width       = 247
1020:             .Value       = 2
1021:             .Visible     = .T.
1022:             .Buttons(1).Caption   = "Sim"
1023:             .Buttons(1).FontSize  = 8
1024:             .Buttons(1).BackStyle = 0
1025:             .Buttons(1).Left      = 3
1026:             .Buttons(1).Top       = 3
1027:             .Buttons(1).Width     = 34
1028:             .Buttons(1).AutoSize  = .T.
1029:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1030:             .Buttons(2).FontSize  = 8
1031:             .Buttons(2).BackStyle = 0
1032:             .Buttons(2).Left      = 82
1033:             .Buttons(2).Top       = 3
1034:             .Buttons(2).Width     = 37
1035:             .Buttons(2).AutoSize  = .T.
1036:         ENDWITH
1037: 
1038:         *-- Apenas Consulta (consulta)
1039:         par_oPg.AddObject("lbl_4c_Consulta", "Label")
1040:         WITH par_oPg.lbl_4c_Consulta
1041:             .FontName  = "Tahoma"
1042:             .FontSize  = 8
1043:             .Caption   = "Apenas Consulta :"
1044:             .Top       = 207
1045:             .Left      = 74
1046:             .Width     = 90
1047:             .Height    = 15
1048:             .ForeColor = RGB(90, 90, 90)
1049:             .BackStyle = 0
1050:             .AutoSize  = .F.
1051:             .Visible   = .T.
1052:         ENDWITH
1053: 
1054:         par_oPg.AddObject("opt_4c_Consulta", "OptionGroup")
1055:         WITH par_oPg.opt_4c_Consulta
1056:             .ButtonCount = 2
1057:             .AutoSize    = .F.
1058:             .BackStyle   = 0
1059:             .BorderStyle = 0
1060:             .Height      = 22
1061:             .Left        = 167
1062:             .Top         = 204
1063:             .Width       = 247
1064:             .Value       = 2
1065:             .Visible     = .T.
1066:             .Buttons(1).Caption   = "Sim"
1067:             .Buttons(1).FontSize  = 8
1068:             .Buttons(1).BackStyle = 0
1069:             .Buttons(1).Left      = 3
1070:             .Buttons(1).Top       = 3
1071:             .Buttons(1).Width     = 34
1072:             .Buttons(1).AutoSize  = .T.
1073:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1074:             .Buttons(2).FontSize  = 8
1075:             .Buttons(2).BackStyle = 0
1076:             .Buttons(2).Left      = 82
1077:             .Buttons(2).Top       = 3
1078:             .Buttons(2).Width     = 37
1079:             .Buttons(2).AutoSize  = .T.
1080:         ENDWITH
1081: 
1082:         *-- Produtos Com Montagem (montagem)
1083:         par_oPg.AddObject("lbl_4c_Montagem", "Label")
1084:         WITH par_oPg.lbl_4c_Montagem
1085:             .FontName  = "Tahoma"
1086:             .FontSize  = 8
1087:             .Caption   = "Produtos Com Montagem :"
1088:             .Top       = 229
1089:             .Left      = 35
1090:             .Width     = 129
1091:             .Height    = 15
1092:             .ForeColor = RGB(90, 90, 90)
1093:             .BackStyle = 0
1094:             .AutoSize  = .F.
1095:             .Visible   = .T.
1096:         ENDWITH
1097: 
1098:         par_oPg.AddObject("opt_4c_Montagem", "OptionGroup")
1099:         WITH par_oPg.opt_4c_Montagem
1100:             .ButtonCount = 3
1101:             .AutoSize    = .F.
1102:             .BackStyle   = 0
1103:             .BorderStyle = 0
1104:             .Height      = 22
1105:             .Left        = 167
1106:             .Top         = 226
1107:             .Width       = 247
1108:             .Value       = 2
1109:             .Visible     = .T.
1110:             .Buttons(1).Caption   = "Sim"
1111:             .Buttons(1).FontSize  = 8
1112:             .Buttons(1).BackStyle = 0
1113:             .Buttons(1).Left      = 3
1114:             .Buttons(1).Top       = 3
1115:             .Buttons(1).Width     = 34
1116:             .Buttons(1).AutoSize  = .T.
1117:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1118:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1119:             .Buttons(2).FontSize  = 8
1120:             .Buttons(2).BackStyle = 0
1121:             .Buttons(2).Left      = 82
1122:             .Buttons(2).Top       = 3
1123:             .Buttons(2).Width     = 37
1124:             .Buttons(2).AutoSize  = .T.
1125:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1126:             .Buttons(3).Caption   = "Ambos"
1127:             .Buttons(3).FontSize  = 8
1128:             .Buttons(3).BackStyle = 0
1129:             .Buttons(3).Left      = 159
1130:             .Buttons(3).Top       = 3
1131:             .Buttons(3).Width     = 61
1132:             .Buttons(3).AutoSize  = .T.
1133:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1134:         ENDWITH
1135: 
1136:         *-- Checar Mercadorias (chkmercs)
1137:         par_oPg.AddObject("lbl_4c_Chkmercs", "Label")
1138:         WITH par_oPg.lbl_4c_Chkmercs

*-- Linhas 1149 a 1236:
1149:             .Visible   = .T.
1150:         ENDWITH
1151: 
1152:         par_oPg.AddObject("opt_4c_Chkmercs", "OptionGroup")
1153:         WITH par_oPg.opt_4c_Chkmercs
1154:             .ButtonCount = 2
1155:             .AutoSize    = .F.
1156:             .BackStyle   = 0
1157:             .BorderStyle = 0
1158:             .Height      = 22
1159:             .Left        = 167
1160:             .Top         = 248
1161:             .Width       = 247
1162:             .Value       = 2
1163:             .Visible     = .T.
1164:             .Buttons(1).Caption   = "Sim"
1165:             .Buttons(1).FontSize  = 8
1166:             .Buttons(1).BackStyle = 0
1167:             .Buttons(1).Left      = 3
1168:             .Buttons(1).Top       = 3
1169:             .Buttons(1).Width     = 34
1170:             .Buttons(1).AutoSize  = .T.
1171:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1172:             .Buttons(2).FontSize  = 8
1173:             .Buttons(2).BackStyle = 0
1174:             .Buttons(2).Left      = 82
1175:             .Buttons(2).Top       = 3
1176:             .Buttons(2).Width     = 37
1177:             .Buttons(2).AutoSize  = .T.
1178:         ENDWITH
1179: 
1180:         *-- Operacoes Utilizadas (oputiliza)
1181:         par_oPg.AddObject("lbl_4c_Oputiliza", "Label")
1182:         WITH par_oPg.lbl_4c_Oputiliza
1183:             .FontName  = "Tahoma"
1184:             .FontSize  = 8
1185:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es Utilizadas :"
1186:             .Top       = 273
1187:             .Left      = 55
1188:             .Width     = 109
1189:             .Height    = 15
1190:             .ForeColor = RGB(90, 90, 90)
1191:             .BackStyle = 0
1192:             .AutoSize  = .F.
1193:             .Visible   = .T.
1194:         ENDWITH
1195: 
1196:         par_oPg.AddObject("opt_4c_Oputiliza", "OptionGroup")
1197:         WITH par_oPg.opt_4c_Oputiliza
1198:             .ButtonCount = 3
1199:             .AutoSize    = .F.
1200:             .BackStyle   = 0
1201:             .BorderStyle = 0
1202:             .Height      = 22
1203:             .Left        = 167
1204:             .Top         = 270
1205:             .Width       = 247
1206:             .Value       = 1
1207:             .Visible     = .T.
1208:             .Buttons(1).Caption   = "Sim"
1209:             .Buttons(1).FontSize  = 8
1210:             .Buttons(1).BackStyle = 0
1211:             .Buttons(1).Left      = 3
1212:             .Buttons(1).Top       = 3
1213:             .Buttons(1).Width     = 34
1214:             .Buttons(1).AutoSize  = .T.
1215:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1216:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1217:             .Buttons(2).FontSize  = 8
1218:             .Buttons(2).BackStyle = 0
1219:             .Buttons(2).Left      = 82
1220:             .Buttons(2).Top       = 3
1221:             .Buttons(2).Width     = 37
1222:             .Buttons(2).AutoSize  = .T.
1223:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1224:             .Buttons(3).Caption   = "Ambas"
1225:             .Buttons(3).FontSize  = 8
1226:             .Buttons(3).BackStyle = 0
1227:             .Buttons(3).Left      = 159
1228:             .Buttons(3).Top       = 3
1229:             .Buttons(3).Width     = 61
1230:             .Buttons(3).AutoSize  = .T.
1231:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1232:         ENDWITH
1233: 
1234:         *-- Operacoes Pagas (filpagas)
1235:         par_oPg.AddObject("lbl_4c_Filpagas", "Label")
1236:         WITH par_oPg.lbl_4c_Filpagas

*-- Linhas 1247 a 1290:
1247:             .Visible   = .T.
1248:         ENDWITH
1249: 
1250:         par_oPg.AddObject("opt_4c_Filpagas", "OptionGroup")
1251:         WITH par_oPg.opt_4c_Filpagas
1252:             .ButtonCount = 3
1253:             .AutoSize    = .F.
1254:             .BackStyle   = 0
1255:             .BorderStyle = 0
1256:             .Height      = 22
1257:             .Left        = 167
1258:             .Top         = 292
1259:             .Width       = 247
1260:             .Value       = 1
1261:             .Visible     = .T.
1262:             .Buttons(1).Caption   = "Sim"
1263:             .Buttons(1).FontSize  = 8
1264:             .Buttons(1).BackStyle = 0
1265:             .Buttons(1).Left      = 3
1266:             .Buttons(1).Top       = 3
1267:             .Buttons(1).Width     = 34
1268:             .Buttons(1).AutoSize  = .T.
1269:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1270:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1271:             .Buttons(2).FontSize  = 8
1272:             .Buttons(2).BackStyle = 0
1273:             .Buttons(2).Left      = 82
1274:             .Buttons(2).Top       = 3
1275:             .Buttons(2).Width     = 37
1276:             .Buttons(2).AutoSize  = .T.
1277:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1278:             .Buttons(3).Caption   = "Ambas"
1279:             .Buttons(3).FontSize  = 8
1280:             .Buttons(3).BackStyle = 0
1281:             .Buttons(3).Left      = 159
1282:             .Buttons(3).Top       = 3
1283:             .Buttons(3).Width     = 61
1284:             .Buttons(3).AutoSize  = .T.
1285:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1286:         ENDWITH
1287: 
1288:         *-- Operacoes Baixadas (filbaixas)
1289:         par_oPg.AddObject("lbl_4c_Filbaixas", "Label")
1290:         WITH par_oPg.lbl_4c_Filbaixas

*-- Linhas 1301 a 1344:
1301:             .Visible   = .T.
1302:         ENDWITH
1303: 
1304:         par_oPg.AddObject("opt_4c_Filbaixas", "OptionGroup")
1305:         WITH par_oPg.opt_4c_Filbaixas
1306:             .ButtonCount = 3
1307:             .AutoSize    = .F.
1308:             .BackStyle   = 0
1309:             .BorderStyle = 0
1310:             .Height      = 22
1311:             .Left        = 167
1312:             .Top         = 314
1313:             .Width       = 247
1314:             .Value       = 1
1315:             .Visible     = .T.
1316:             .Buttons(1).Caption   = "Sim"
1317:             .Buttons(1).FontSize  = 8
1318:             .Buttons(1).BackStyle = 0
1319:             .Buttons(1).Left      = 3
1320:             .Buttons(1).Top       = 3
1321:             .Buttons(1).Width     = 34
1322:             .Buttons(1).AutoSize  = .T.
1323:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1324:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1325:             .Buttons(2).FontSize  = 8
1326:             .Buttons(2).BackStyle = 0
1327:             .Buttons(2).Left      = 82
1328:             .Buttons(2).Top       = 3
1329:             .Buttons(2).Width     = 37
1330:             .Buttons(2).AutoSize  = .T.
1331:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1332:             .Buttons(3).Caption   = "Ambas"
1333:             .Buttons(3).FontSize  = 8
1334:             .Buttons(3).BackStyle = 0
1335:             .Buttons(3).Left      = 159
1336:             .Buttons(3).Top       = 3
1337:             .Buttons(3).Width     = 61
1338:             .Buttons(3).AutoSize  = .T.
1339:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1340:         ENDWITH
1341: 
1342:         *-- Limite Diario (limdia)
1343:         par_oPg.AddObject("lbl_4c_Limdia", "Label")
1344:         WITH par_oPg.lbl_4c_Limdia

*-- Linhas 1368 a 1411:
1368:         ENDWITH
1369: 
1370:         *-- COLUNA DIREITA: Auditoria (9 opcoes) - Left=424
1371:         par_oPg.AddObject("opt_4c_Audits", "OptionGroup")
1372:         WITH par_oPg.opt_4c_Audits
1373:             .ButtonCount = 9
1374:             .AutoSize    = .F.
1375:             .BackStyle   = 0
1376:             .BorderStyle = 0
1377:             .Height      = 112
1378:             .Left        = 424
1379:             .Top         = 8
1380:             .Width       = 301
1381:             .Value       = 2
1382:             .Visible     = .T.
1383:             .Buttons(1).Caption   = "Sim"
1384:             .Buttons(1).FontSize  = 8
1385:             .Buttons(1).BackStyle = 0
1386:             .Buttons(1).Left      = 4
1387:             .Buttons(1).Top       = 6
1388:             .Buttons(1).Width     = 34
1389:             .Buttons(1).AutoSize  = .T.
1390:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1391:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1392:             .Buttons(2).FontSize  = 8
1393:             .Buttons(2).BackStyle = 0
1394:             .Buttons(2).Left      = 151
1395:             .Buttons(2).Top       = 6
1396:             .Buttons(2).Width     = 37
1397:             .Buttons(2).AutoSize  = .T.
1398:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1399:             .Buttons(3).Caption   = "Agendamento Pago"
1400:             .Buttons(3).FontSize  = 8
1401:             .Buttons(3).BackStyle = 0
1402:             .Buttons(3).Left      = 4
1403:             .Buttons(3).Top       = 27
1404:             .Buttons(3).Width     = 112
1405:             .Buttons(3).AutoSize  = .T.
1406:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1407:             .Buttons(4).Caption   = "Agendamento N" + CHR(227) + "o Pago"
1408:             .Buttons(4).FontSize  = 8
1409:             .Buttons(4).BackStyle = 0
1410:             .Buttons(4).Left      = 151
1411:             .Buttons(4).Top       = 27

*-- Linhas 1504 a 1547:
1504:     * ConfigurarPgCompls - Configura aba Complementos (pgf_4c_Dados.Page2)
1505:     * Coordenadas relativas a pagina (sem compensacao +29)
1506:     *--------------------------------------------------------------------------
1507:     PROTECTED PROCEDURE ConfigurarPgCompls(par_oPg)
1508: 
1509:         *-- Bordas decorativas (Shape) - agrupamento visual de secoes
1510: 
1511:         par_oPg.AddObject("shp_4c_Shape2", "Shape")
1512:         WITH par_oPg.shp_4c_Shape2
1513:             .Top           = 10
1514:             .Left          = 515
1515:             .Height        = 61
1516:             .Width         = 215
1517:             .BackStyle     = 0
1518:             .SpecialEffect = 0
1519:             .Visible       = .T.
1520:         ENDWITH
1521: 
1522:         par_oPg.AddObject("shp_4c_Shape6", "Shape")
1523:         WITH par_oPg.shp_4c_Shape6
1524:             .Top           = 73
1525:             .Left          = 515
1526:             .Height        = 56
1527:             .Width         = 215
1528:             .BackStyle     = 0
1529:             .SpecialEffect = 0
1530:             .Visible       = .T.
1531:         ENDWITH
1532: 
1533:         par_oPg.AddObject("shp_4c_Shape1", "Shape")
1534:         WITH par_oPg.shp_4c_Shape1
1535:             .Top           = 246
1536:             .Left          = 275
1537:             .Height        = 79
1538:             .Width         = 264
1539:             .BackStyle     = 0
1540:             .SpecialEffect = 0
1541:             .Visible       = .T.
1542:         ENDWITH
1543: 
1544:         par_oPg.AddObject("shp_4c_Shape3", "Shape")
1545:         WITH par_oPg.shp_4c_Shape3
1546:             .Top           = 246
1547:             .Left          = 5

*-- Linhas 1575 a 2240:
1575:             .Visible     = .T.
1576:         ENDWITH
1577: 
1578:         *-- COLUNA ESQUERDA: OptionGroups Sim/Nao (Left=173, Width=86, H=20)
1579: 
1580:         *-- Utilizar Data Atual (dtatuals)
1581:         par_oPg.AddObject("lbl_4c_DtAtuals", "Label")
1582:         WITH par_oPg.lbl_4c_DtAtuals
1583:             .FontName  = "Tahoma"
1584:             .FontSize  = 8
1585:             .Caption   = "Utilizar Data Atual :"
1586:             .Top       = 6
1587:             .Left      = 79
1588:             .Width     = 95
1589:             .Height    = 15
1590:             .ForeColor = RGB(90, 90, 90)
1591:             .BackStyle = 0
1592:             .AutoSize  = .F.
1593:             .Visible   = .T.
1594:         ENDWITH
1595: 
1596:         par_oPg.AddObject("opt_4c_Dtatuals", "OptionGroup")
1597:         WITH par_oPg.opt_4c_Dtatuals
1598:             .ButtonCount = 2
1599:             .AutoSize    = .F.
1600:             .BackStyle   = 0
1601:             .BorderStyle = 0
1602:             .Height      = 20
1603:             .Left        = 173
1604:             .Top         = 2
1605:             .Width       = 86
1606:             .Value       = 1
1607:             .Visible     = .T.
1608:             .Buttons(1).Caption   = "Sim"
1609:             .Buttons(1).FontSize  = 8
1610:             .Buttons(1).BackStyle = 0
1611:             .Buttons(1).Left      = 5
1612:             .Buttons(1).Top       = 3
1613:             .Buttons(1).Width     = 34
1614:             .Buttons(1).AutoSize  = .T.
1615:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1616:             .Buttons(2).FontSize  = 8
1617:             .Buttons(2).BackStyle = 0
1618:             .Buttons(2).Left      = 45
1619:             .Buttons(2).Top       = 3
1620:             .Buttons(2).Width     = 37
1621:             .Buttons(2).AutoSize  = .T.
1622:         ENDWITH
1623: 
1624:         *-- Bloqueia Alt. Data (blqadts)
1625:         par_oPg.AddObject("lbl_4c_BlqAdts", "Label")
1626:         WITH par_oPg.lbl_4c_BlqAdts
1627:             .FontName  = "Tahoma"
1628:             .FontSize  = 8
1629:             .Caption   = "Bloqueia Alt. Data :"
1630:             .Top       = 25
1631:             .Left      = 79
1632:             .Width     = 95
1633:             .Height    = 15
1634:             .ForeColor = RGB(90, 90, 90)
1635:             .BackStyle = 0
1636:             .AutoSize  = .F.
1637:             .Visible   = .T.
1638:         ENDWITH
1639: 
1640:         par_oPg.AddObject("opt_4c_Blqadts", "OptionGroup")
1641:         WITH par_oPg.opt_4c_Blqadts
1642:             .ButtonCount = 2
1643:             .AutoSize    = .F.
1644:             .BackStyle   = 0
1645:             .BorderStyle = 0
1646:             .Height      = 20
1647:             .Left        = 173
1648:             .Top         = 21
1649:             .Width       = 86
1650:             .Value       = 2
1651:             .Visible     = .T.
1652:             .Buttons(1).Caption   = "Sim"
1653:             .Buttons(1).FontSize  = 8
1654:             .Buttons(1).BackStyle = 0
1655:             .Buttons(1).Left      = 5
1656:             .Buttons(1).Top       = 3
1657:             .Buttons(1).Width     = 34
1658:             .Buttons(1).AutoSize  = .T.
1659:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1660:             .Buttons(2).FontSize  = 8
1661:             .Buttons(2).BackStyle = 0
1662:             .Buttons(2).Left      = 45
1663:             .Buttons(2).Top       = 3
1664:             .Buttons(2).Width     = 37
1665:             .Buttons(2).AutoSize  = .T.
1666:         ENDWITH
1667: 
1668:         *-- Inibir Botao Ocorrencia (inibocors)
1669:         par_oPg.AddObject("lbl_4c_InibOcors", "Label")
1670:         WITH par_oPg.lbl_4c_InibOcors
1671:             .FontName  = "Tahoma"
1672:             .FontSize  = 8
1673:             .Caption   = "Inibir Bot" + CHR(227) + "o Ocorr" + CHR(234) + "ncia :"
1674:             .Top       = 44
1675:             .Left      = 55
1676:             .Width     = 119
1677:             .Height    = 15
1678:             .ForeColor = RGB(90, 90, 90)
1679:             .BackStyle = 0
1680:             .AutoSize  = .F.
1681:             .Visible   = .T.
1682:         ENDWITH
1683: 
1684:         par_oPg.AddObject("opt_4c_Inibocors", "OptionGroup")
1685:         WITH par_oPg.opt_4c_Inibocors
1686:             .ButtonCount = 2
1687:             .AutoSize    = .F.
1688:             .BackStyle   = 0
1689:             .BorderStyle = 0
1690:             .Height      = 20
1691:             .Left        = 173
1692:             .Top         = 40
1693:             .Width       = 86
1694:             .Value       = 2
1695:             .Visible     = .T.
1696:             .Buttons(1).Caption   = "Sim"
1697:             .Buttons(1).FontSize  = 8
1698:             .Buttons(1).BackStyle = 0
1699:             .Buttons(1).Left      = 5
1700:             .Buttons(1).Top       = 3
1701:             .Buttons(1).Width     = 34
1702:             .Buttons(1).AutoSize  = .T.
1703:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1704:             .Buttons(2).FontSize  = 8
1705:             .Buttons(2).BackStyle = 0
1706:             .Buttons(2).Left      = 45
1707:             .Buttons(2).Top       = 3
1708:             .Buttons(2).Width     = 37
1709:             .Buttons(2).AutoSize  = .T.
1710:         ENDWITH
1711: 
1712:         *-- Inibir Botao Fechamento (inibfecs)
1713:         par_oPg.AddObject("lbl_4c_InibFecs", "Label")
1714:         WITH par_oPg.lbl_4c_InibFecs
1715:             .FontName  = "Tahoma"
1716:             .FontSize  = 8
1717:             .Caption   = "Inibir Bot" + CHR(227) + "o Fechamento :"
1718:             .Top       = 63
1719:             .Left      = 48
1720:             .Width     = 126
1721:             .Height    = 15
1722:             .ForeColor = RGB(90, 90, 90)
1723:             .BackStyle = 0
1724:             .AutoSize  = .F.
1725:             .Visible   = .T.
1726:         ENDWITH
1727: 
1728:         par_oPg.AddObject("opt_4c_Inibfecs", "OptionGroup")
1729:         WITH par_oPg.opt_4c_Inibfecs
1730:             .ButtonCount = 2
1731:             .AutoSize    = .F.
1732:             .BackStyle   = 0
1733:             .BorderStyle = 0
1734:             .Height      = 20
1735:             .Left        = 173
1736:             .Top         = 59
1737:             .Width       = 86
1738:             .Value       = 2
1739:             .Visible     = .T.
1740:             .Buttons(1).Caption   = "Sim"
1741:             .Buttons(1).FontSize  = 8
1742:             .Buttons(1).BackStyle = 0
1743:             .Buttons(1).Left      = 5
1744:             .Buttons(1).Top       = 3
1745:             .Buttons(1).Width     = 34
1746:             .Buttons(1).AutoSize  = .T.
1747:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1748:             .Buttons(2).FontSize  = 8
1749:             .Buttons(2).BackStyle = 0
1750:             .Buttons(2).Left      = 45
1751:             .Buttons(2).Top       = 3
1752:             .Buttons(2).Width     = 37
1753:             .Buttons(2).AutoSize  = .T.
1754:         ENDWITH
1755: 
1756:         *-- Permitir Alteracao (alterar)
1757:         par_oPg.AddObject("lbl_4c_Alterar", "Label")
1758:         WITH par_oPg.lbl_4c_Alterar
1759:             .FontName  = "Tahoma"
1760:             .FontSize  = 8
1761:             .Caption   = "Permitir Altera" + CHR(231) + CHR(227) + "o :"
1762:             .Top       = 82
1763:             .Left      = 80
1764:             .Width     = 94
1765:             .Height    = 15
1766:             .ForeColor = RGB(90, 90, 90)
1767:             .BackStyle = 0
1768:             .AutoSize  = .F.
1769:             .Visible   = .T.
1770:         ENDWITH
1771: 
1772:         par_oPg.AddObject("opt_4c_Alterar", "OptionGroup")
1773:         WITH par_oPg.opt_4c_Alterar
1774:             .ButtonCount = 2
1775:             .AutoSize    = .F.
1776:             .BackStyle   = 0
1777:             .BorderStyle = 0
1778:             .Height      = 20
1779:             .Left        = 173
1780:             .Top         = 78
1781:             .Width       = 86
1782:             .Value       = 2
1783:             .Visible     = .T.
1784:             .Buttons(1).Caption   = "Sim"
1785:             .Buttons(1).FontSize  = 8
1786:             .Buttons(1).BackStyle = 0
1787:             .Buttons(1).Left      = 5
1788:             .Buttons(1).Top       = 3
1789:             .Buttons(1).Width     = 34
1790:             .Buttons(1).AutoSize  = .T.
1791:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1792:             .Buttons(2).FontSize  = 8
1793:             .Buttons(2).BackStyle = 0
1794:             .Buttons(2).Left      = 45
1795:             .Buttons(2).Top       = 3
1796:             .Buttons(2).Width     = 37
1797:             .Buttons(2).AutoSize  = .T.
1798:         ENDWITH
1799: 
1800:         *-- Utiliza Periodo Configuracao (periodos)
1801:         par_oPg.AddObject("lbl_4c_Periodos", "Label")
1802:         WITH par_oPg.lbl_4c_Periodos
1803:             .FontName  = "Tahoma"
1804:             .FontSize  = 8
1805:             .Caption   = "Utiliza Per" + CHR(237) + "odo Configura" + CHR(231) + CHR(227) + "o :"
1806:             .Top       = 101
1807:             .Left      = 31
1808:             .Width     = 143
1809:             .Height    = 15
1810:             .ForeColor = RGB(90, 90, 90)
1811:             .BackStyle = 0
1812:             .AutoSize  = .F.
1813:             .Visible   = .T.
1814:         ENDWITH
1815: 
1816:         par_oPg.AddObject("opt_4c_Periodos", "OptionGroup")
1817:         WITH par_oPg.opt_4c_Periodos
1818:             .ButtonCount = 2
1819:             .AutoSize    = .F.
1820:             .BackStyle   = 0
1821:             .BorderStyle = 0
1822:             .Height      = 20
1823:             .Left        = 173
1824:             .Top         = 97
1825:             .Width       = 86
1826:             .Value       = 2
1827:             .Visible     = .T.
1828:             .Buttons(1).Caption   = "Sim"
1829:             .Buttons(1).FontSize  = 8
1830:             .Buttons(1).BackStyle = 0
1831:             .Buttons(1).Left      = 5
1832:             .Buttons(1).Top       = 3
1833:             .Buttons(1).Width     = 34
1834:             .Buttons(1).AutoSize  = .T.
1835:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1836:             .Buttons(2).FontSize  = 8
1837:             .Buttons(2).BackStyle = 0
1838:             .Buttons(2).Left      = 45
1839:             .Buttons(2).Top       = 3
1840:             .Buttons(2).Width     = 37
1841:             .Buttons(2).AutoSize  = .T.
1842:         ENDWITH
1843: 
1844:         *-- Utiliza Periodo Entrega (entregas)
1845:         par_oPg.AddObject("lbl_4c_Entregas", "Label")
1846:         WITH par_oPg.lbl_4c_Entregas
1847:             .FontName  = "Tahoma"
1848:             .FontSize  = 8
1849:             .Caption   = "Utiliza Per" + CHR(237) + "odo Entrega :"
1850:             .Top       = 121
1851:             .Left      = 57
1852:             .Width     = 117
1853:             .Height    = 15
1854:             .ForeColor = RGB(90, 90, 90)
1855:             .BackStyle = 0
1856:             .AutoSize  = .F.
1857:             .Visible   = .T.
1858:         ENDWITH
1859: 
1860:         par_oPg.AddObject("opt_4c_Entregas", "OptionGroup")
1861:         WITH par_oPg.opt_4c_Entregas
1862:             .ButtonCount = 2
1863:             .AutoSize    = .F.
1864:             .BackStyle   = 0
1865:             .BorderStyle = 0
1866:             .Height      = 20
1867:             .Left        = 173
1868:             .Top         = 117
1869:             .Width       = 86
1870:             .Value       = 2
1871:             .Visible     = .T.
1872:             .Buttons(1).Caption   = "Sim"
1873:             .Buttons(1).FontSize  = 8
1874:             .Buttons(1).BackStyle = 0
1875:             .Buttons(1).Left      = 5
1876:             .Buttons(1).Top       = 3
1877:             .Buttons(1).Width     = 34
1878:             .Buttons(1).AutoSize  = .T.
1879:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1880:             .Buttons(2).FontSize  = 8
1881:             .Buttons(2).BackStyle = 0
1882:             .Buttons(2).Left      = 45
1883:             .Buttons(2).Top       = 3
1884:             .Buttons(2).Width     = 37
1885:             .Buttons(2).AutoSize  = .T.
1886:         ENDWITH
1887: 
1888:         *-- Utiliza Periodo Operacao (operacoes)
1889:         par_oPg.AddObject("lbl_4c_Operacoes", "Label")
1890:         WITH par_oPg.lbl_4c_Operacoes
1891:             .FontName  = "Tahoma"
1892:             .FontSize  = 8
1893:             .Caption   = "Utiliza Per" + CHR(237) + "odo Opera" + CHR(231) + CHR(227) + "o :"
1894:             .Top       = 140
1895:             .Left      = 48
1896:             .Width     = 126
1897:             .Height    = 15
1898:             .ForeColor = RGB(90, 90, 90)
1899:             .BackStyle = 0
1900:             .AutoSize  = .F.
1901:             .Visible   = .T.
1902:         ENDWITH
1903: 
1904:         par_oPg.AddObject("opt_4c_Operacoes", "OptionGroup")
1905:         WITH par_oPg.opt_4c_Operacoes
1906:             .ButtonCount = 2
1907:             .AutoSize    = .F.
1908:             .BackStyle   = 0
1909:             .BorderStyle = 0
1910:             .Height      = 20
1911:             .Left        = 173
1912:             .Top         = 136
1913:             .Width       = 86
1914:             .Value       = 2
1915:             .Visible     = .T.
1916:             .Buttons(1).Caption   = "Sim"
1917:             .Buttons(1).FontSize  = 8
1918:             .Buttons(1).BackStyle = 0
1919:             .Buttons(1).Left      = 5
1920:             .Buttons(1).Top       = 3
1921:             .Buttons(1).Width     = 34
1922:             .Buttons(1).AutoSize  = .T.
1923:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1924:             .Buttons(2).FontSize  = 8
1925:             .Buttons(2).BackStyle = 0
1926:             .Buttons(2).Left      = 45
1927:             .Buttons(2).Top       = 3
1928:             .Buttons(2).Width     = 37
1929:             .Buttons(2).AutoSize  = .T.
1930:         ENDWITH
1931: 
1932:         *-- Senha por Responsavel (vends)
1933:         par_oPg.AddObject("lbl_4c_Vends", "Label")
1934:         WITH par_oPg.lbl_4c_Vends
1935:             .FontName  = "Tahoma"
1936:             .FontSize  = 8
1937:             .Caption   = "Senha por Respons" + CHR(225) + "vel :"
1938:             .Top       = 159
1939:             .Left      = 52
1940:             .Width     = 122
1941:             .Height    = 15
1942:             .ForeColor = RGB(90, 90, 90)
1943:             .BackStyle = 0
1944:             .AutoSize  = .F.
1945:             .Visible   = .T.
1946:         ENDWITH
1947: 
1948:         par_oPg.AddObject("opt_4c_Vends", "OptionGroup")
1949:         WITH par_oPg.opt_4c_Vends
1950:             .ButtonCount = 2
1951:             .AutoSize    = .F.
1952:             .BackStyle   = 0
1953:             .BorderStyle = 0
1954:             .Height      = 20
1955:             .Left        = 173
1956:             .Top         = 155
1957:             .Width       = 86
1958:             .Value       = 2
1959:             .Visible     = .T.
1960:             .Buttons(1).Caption   = "Sim"
1961:             .Buttons(1).FontSize  = 8
1962:             .Buttons(1).BackStyle = 0
1963:             .Buttons(1).Left      = 5
1964:             .Buttons(1).Top       = 3
1965:             .Buttons(1).Width     = 34
1966:             .Buttons(1).AutoSize  = .T.
1967:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1968:             .Buttons(2).FontSize  = 8
1969:             .Buttons(2).BackStyle = 0
1970:             .Buttons(2).Left      = 45
1971:             .Buttons(2).Top       = 3
1972:             .Buttons(2).Width     = 37
1973:             .Buttons(2).AutoSize  = .T.
1974:         ENDWITH
1975: 
1976:         *-- Checar SAC (sacs)
1977:         par_oPg.AddObject("lbl_4c_Sacs", "Label")
1978:         WITH par_oPg.lbl_4c_Sacs
1979:             .FontName  = "Tahoma"
1980:             .FontSize  = 8
1981:             .Caption   = "Checar SAC :"
1982:             .Top       = 178
1983:             .Left      = 108
1984:             .Width     = 66
1985:             .Height    = 15
1986:             .ForeColor = RGB(90, 90, 90)
1987:             .BackStyle = 0
1988:             .AutoSize  = .F.
1989:             .Visible   = .T.
1990:         ENDWITH
1991: 
1992:         par_oPg.AddObject("opt_4c_Sacs", "OptionGroup")
1993:         WITH par_oPg.opt_4c_Sacs
1994:             .ButtonCount = 2
1995:             .AutoSize    = .F.
1996:             .BackStyle   = 0
1997:             .BorderStyle = 0
1998:             .Height      = 20
1999:             .Left        = 173
2000:             .Top         = 174
2001:             .Width       = 86
2002:             .Value       = 2
2003:             .Visible     = .T.
2004:             .Buttons(1).Caption   = "Sim"
2005:             .Buttons(1).FontSize  = 8
2006:             .Buttons(1).BackStyle = 0
2007:             .Buttons(1).Left      = 5
2008:             .Buttons(1).Top       = 3
2009:             .Buttons(1).Width     = 34
2010:             .Buttons(1).AutoSize  = .T.
2011:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2012:             .Buttons(2).FontSize  = 8
2013:             .Buttons(2).BackStyle = 0
2014:             .Buttons(2).Left      = 45
2015:             .Buttons(2).Top       = 3
2016:             .Buttons(2).Width     = 37
2017:             .Buttons(2).AutoSize  = .T.
2018:         ENDWITH
2019: 
2020:         *-- Utiliza Empresa (empresas)
2021:         par_oPg.AddObject("lbl_4c_Empresas", "Label")
2022:         WITH par_oPg.lbl_4c_Empresas
2023:             .FontName  = "Tahoma"
2024:             .FontSize  = 8
2025:             .Caption   = "Utiliza Empresa :"
2026:             .Top       = 198
2027:             .Left      = 93
2028:             .Width     = 81
2029:             .Height    = 15
2030:             .ForeColor = RGB(90, 90, 90)
2031:             .BackStyle = 0
2032:             .AutoSize  = .F.
2033:             .Visible   = .T.
2034:         ENDWITH
2035: 
2036:         par_oPg.AddObject("opt_4c_Empresas", "OptionGroup")
2037:         WITH par_oPg.opt_4c_Empresas
2038:             .ButtonCount = 2
2039:             .AutoSize    = .F.
2040:             .BackStyle   = 0
2041:             .BorderStyle = 0
2042:             .Height      = 20
2043:             .Left        = 173
2044:             .Top         = 193
2045:             .Width       = 86
2046:             .Value       = 2
2047:             .Visible     = .T.
2048:             .Buttons(1).Caption   = "Sim"
2049:             .Buttons(1).FontSize  = 8
2050:             .Buttons(1).BackStyle = 0
2051:             .Buttons(1).Left      = 5
2052:             .Buttons(1).Top       = 3
2053:             .Buttons(1).Width     = 34
2054:             .Buttons(1).AutoSize  = .T.
2055:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2056:             .Buttons(2).FontSize  = 8
2057:             .Buttons(2).BackStyle = 0
2058:             .Buttons(2).Left      = 45
2059:             .Buttons(2).Top       = 3
2060:             .Buttons(2).Width     = 37
2061:             .Buttons(2).AutoSize  = .T.
2062:         ENDWITH
2063: 
2064:         *-- Controlar Acesso por Usuario (ctacusus)
2065:         par_oPg.AddObject("lbl_4c_Ctacusus", "Label")
2066:         WITH par_oPg.lbl_4c_Ctacusus
2067:             .FontName  = "Tahoma"
2068:             .FontSize  = 8
2069:             .Caption   = "Controlar Acesso por Usu" + CHR(225) + "rio :"
2070:             .Top       = 217
2071:             .Left      = 25
2072:             .Width     = 149
2073:             .Height    = 15
2074:             .ForeColor = RGB(90, 90, 90)
2075:             .BackStyle = 0
2076:             .AutoSize  = .F.
2077:             .Visible   = .T.
2078:         ENDWITH
2079: 
2080:         par_oPg.AddObject("opt_4c_Ctacusus", "OptionGroup")
2081:         WITH par_oPg.opt_4c_Ctacusus
2082:             .ButtonCount = 2
2083:             .AutoSize    = .F.
2084:             .BackStyle   = 0
2085:             .BorderStyle = 0
2086:             .Height      = 20
2087:             .Left        = 173
2088:             .Top         = 214
2089:             .Width       = 86
2090:             .Value       = 2
2091:             .Visible     = .T.
2092:             .Buttons(1).Caption   = "Sim"
2093:             .Buttons(1).FontSize  = 8
2094:             .Buttons(1).BackStyle = 0
2095:             .Buttons(1).Left      = 4
2096:             .Buttons(1).Top       = 2
2097:             .Buttons(1).AutoSize  = .T.
2098:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2099:             .Buttons(2).FontSize  = 8
2100:             .Buttons(2).BackStyle = 0
2101:             .Buttons(2).Left      = 43
2102:             .Buttons(2).Top       = 2
2103:             .Buttons(2).AutoSize  = .T.
2104:         ENDWITH
2105: 
2106:         *-- SECAO "Padrao de Configuracao" - header Bold
2107:         par_oPg.AddObject("lbl_4c_PadrConf", "Label")
2108:         WITH par_oPg.lbl_4c_PadrConf
2109:             .FontName  = "Tahoma"
2110:             .FontSize  = 8
2111:             .FontBold  = .T.
2112:             .Caption   = " Padr" + CHR(227) + "o de Configura" + CHR(231) + CHR(227) + "o "
2113:             .Top       = 247
2114:             .Left      = 7
2115:             .Width     = 142
2116:             .Height    = 15
2117:             .ForeColor = RGB(90, 90, 90)
2118:             .BackStyle = 0
2119:             .AutoSize  = .F.
2120:             .Visible   = .T.
2121:         ENDWITH
2122: 
2123:         *-- OptionGroups para filtro de operacoes (Left=3, Width=216)
2124:         par_oPg.AddObject("opt_4c_Oppends", "OptionGroup")
2125:         WITH par_oPg.opt_4c_Oppends
2126:             .ButtonCount = 3
2127:             .AutoSize    = .F.
2128:             .BackStyle   = 0
2129:             .BorderStyle = 0
2130:             .Height      = 22
2131:             .Left        = 3
2132:             .Top         = 261
2133:             .Width       = 216
2134:             .Value       = 1
2135:             .Visible     = .T.
2136:             .Buttons(1).Caption   = "Todas"
2137:             .Buttons(1).FontSize  = 8
2138:             .Buttons(1).BackStyle = 0
2139:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2140:             .Buttons(1).Left      = 5
2141:             .Buttons(1).Top       = 3
2142:             .Buttons(1).Width     = 47
2143:             .Buttons(1).AutoSize  = .T.
2144:             .Buttons(2).Caption   = "Pendentes"
2145:             .Buttons(2).FontSize  = 8
2146:             .Buttons(2).BackStyle = 0
2147:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2148:             .Buttons(2).Left      = 57
2149:             .Buttons(2).Top       = 3
2150:             .Buttons(2).Width     = 69
2151:             .Buttons(2).AutoSize  = .T.
2152:             .Buttons(3).Caption   = "Baixadas"
2153:             .Buttons(3).FontSize  = 8
2154:             .Buttons(3).BackStyle = 0
2155:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2156:             .Buttons(3).Left      = 140
2157:             .Buttons(3).Top       = 3
2158:             .Buttons(3).Width     = 61
2159:             .Buttons(3).AutoSize  = .T.
2160:         ENDWITH
2161: 
2162:         par_oPg.AddObject("opt_4c_Opagends", "OptionGroup")
2163:         WITH par_oPg.opt_4c_Opagends
2164:             .ButtonCount = 3
2165:             .AutoSize    = .F.
2166:             .BackStyle   = 0
2167:             .BorderStyle = 0
2168:             .Height      = 22
2169:             .Left        = 3
2170:             .Top         = 278
2171:             .Width       = 216
2172:             .Value       = 1
2173:             .Visible     = .T.
2174:             .Buttons(1).Caption   = "Todas"
2175:             .Buttons(1).FontSize  = 8
2176:             .Buttons(1).BackStyle = 0
2177:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2178:             .Buttons(1).Left      = 5
2179:             .Buttons(1).Top       = 3
2180:             .Buttons(1).Width     = 47
2181:             .Buttons(1).AutoSize  = .T.
2182:             .Buttons(2).Caption   = "N" + CHR(227) + "o Agendadas"
2183:             .Buttons(2).FontSize  = 8
2184:             .Buttons(2).BackStyle = 0
2185:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2186:             .Buttons(2).Left      = 57
2187:             .Buttons(2).Top       = 3
2188:             .Buttons(2).Width     = 82
2189:             .Buttons(2).AutoSize  = .T.
2190:             .Buttons(3).Caption   = "Agendadas"
2191:             .Buttons(3).FontSize  = 8
2192:             .Buttons(3).BackStyle = 0
2193:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2194:             .Buttons(3).Left      = 140
2195:             .Buttons(3).Top       = 3
2196:             .Buttons(3).Width     = 72
2197:             .Buttons(3).AutoSize  = .T.
2198:         ENDWITH
2199: 
2200:         par_oPg.AddObject("opt_4c_Oppagas", "OptionGroup")
2201:         WITH par_oPg.opt_4c_Oppagas
2202:             .ButtonCount = 3
2203:             .AutoSize    = .F.
2204:             .BackStyle   = 0
2205:             .BorderStyle = 0
2206:             .Height      = 22
2207:             .Left        = 3
2208:             .Top         = 296
2209:             .Width       = 216
2210:             .Value       = 1
2211:             .Visible     = .T.
2212:             .Buttons(1).Caption   = "Todas"
2213:             .Buttons(1).FontSize  = 8
2214:             .Buttons(1).BackStyle = 0
2215:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2216:             .Buttons(1).Left      = 5
2217:             .Buttons(1).Top       = 3
2218:             .Buttons(1).Width     = 47
2219:             .Buttons(1).AutoSize  = .T.
2220:             .Buttons(2).Caption   = "N" + CHR(227) + "o Pagas"
2221:             .Buttons(2).FontSize  = 8
2222:             .Buttons(2).BackStyle = 0
2223:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2224:             .Buttons(2).Left      = 57
2225:             .Buttons(2).Top       = 3
2226:             .Buttons(2).Width     = 57
2227:             .Buttons(2).AutoSize  = .T.
2228:             .Buttons(3).Caption   = "Pagas"
2229:             .Buttons(3).FontSize  = 8
2230:             .Buttons(3).BackStyle = 0
2231:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2232:             .Buttons(3).Left      = 140
2233:             .Buttons(3).Top       = 3
2234:             .Buttons(3).Width     = 47
2235:             .Buttons(3).AutoSize  = .T.
2236:         ENDWITH
2237: 
2238:         *-- CheckBoxes para travar ordenacao (Fixa*)
2239:         par_oPg.AddObject("chk_4c_Fixaps", "CheckBox")
2240:         WITH par_oPg.chk_4c_Fixaps

*-- Linhas 2452 a 2909:
2452:             .Visible       = .T.
2453:         ENDWITH
2454: 
2455:         *-- COLUNA DIREITA: OptionGroups Sim/Nao (Left=431, Width=86)
2456: 
2457:         *-- Analisar C.Pagto Fx.Cx (anacps)
2458:         par_oPg.AddObject("lbl_4c_Anacps", "Label")
2459:         WITH par_oPg.lbl_4c_Anacps
2460:             .FontName  = "Tahoma"
2461:             .FontSize  = 8
2462:             .Caption   = "Analisar C.Pagto Fx. Cx :"
2463:             .Top       = 7
2464:             .Left      = 310
2465:             .Width     = 124
2466:             .Height    = 15
2467:             .ForeColor = RGB(90, 90, 90)
2468:             .BackStyle = 0
2469:             .AutoSize  = .F.
2470:             .Visible   = .T.
2471:         ENDWITH
2472: 
2473:         par_oPg.AddObject("opt_4c_Anacps", "OptionGroup")
2474:         WITH par_oPg.opt_4c_Anacps
2475:             .ButtonCount = 2
2476:             .AutoSize    = .F.
2477:             .BackStyle   = 0
2478:             .BorderStyle = 0
2479:             .Height      = 20
2480:             .Left        = 431
2481:             .Top         = 3
2482:             .Width       = 86
2483:             .Value       = 2
2484:             .Visible     = .T.
2485:             .Buttons(1).Caption   = "Sim"
2486:             .Buttons(1).FontSize  = 8
2487:             .Buttons(1).BackStyle = 0
2488:             .Buttons(1).Left      = 5
2489:             .Buttons(1).Top       = 3
2490:             .Buttons(1).Width     = 34
2491:             .Buttons(1).AutoSize  = .T.
2492:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2493:             .Buttons(2).FontSize  = 8
2494:             .Buttons(2).BackStyle = 0
2495:             .Buttons(2).Left      = 45
2496:             .Buttons(2).Top       = 3
2497:             .Buttons(2).Width     = 37
2498:             .Buttons(2).AutoSize  = .T.
2499:         ENDWITH
2500: 
2501:         *-- Gera Controle de Volumes / ChkReserva (chkreserva)
2502:         par_oPg.AddObject("lbl_4c_Chkreserva", "Label")
2503:         WITH par_oPg.lbl_4c_Chkreserva
2504:             .FontName  = "Tahoma"
2505:             .FontSize  = 8
2506:             .Caption   = "Gera Controle de Volumes :"
2507:             .Top       = 26
2508:             .Left      = 301
2509:             .Width     = 133
2510:             .Height    = 15
2511:             .ForeColor = RGB(90, 90, 90)
2512:             .BackStyle = 0
2513:             .AutoSize  = .F.
2514:             .Visible   = .T.
2515:         ENDWITH
2516: 
2517:         par_oPg.AddObject("opt_4c_Chkreserva", "OptionGroup")
2518:         WITH par_oPg.opt_4c_Chkreserva
2519:             .ButtonCount = 2
2520:             .AutoSize    = .F.
2521:             .BackStyle   = 0
2522:             .BorderStyle = 0
2523:             .Height      = 20
2524:             .Left        = 431
2525:             .Top         = 22
2526:             .Width       = 86
2527:             .Value       = 2
2528:             .Visible     = .T.
2529:             .Buttons(1).Caption   = "Sim"
2530:             .Buttons(1).FontSize  = 8
2531:             .Buttons(1).BackStyle = 0
2532:             .Buttons(1).Left      = 5
2533:             .Buttons(1).Top       = 3
2534:             .Buttons(1).Width     = 34
2535:             .Buttons(1).AutoSize  = .T.
2536:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2537:             .Buttons(2).FontSize  = 8
2538:             .Buttons(2).BackStyle = 0
2539:             .Buttons(2).Left      = 45
2540:             .Buttons(2).Top       = 3
2541:             .Buttons(2).Width     = 37
2542:             .Buttons(2).AutoSize  = .T.
2543:         ENDWITH
2544: 
2545:         *-- Utiliza Responsavel (resps)
2546:         par_oPg.AddObject("lbl_4c_Resps", "Label")
2547:         WITH par_oPg.lbl_4c_Resps
2548:             .FontName  = "Tahoma"
2549:             .FontSize  = 8
2550:             .Caption   = "Utiliza Respons" + CHR(225) + "vel :"
2551:             .Top       = 45
2552:             .Left      = 333
2553:             .Width     = 101
2554:             .Height    = 15
2555:             .ForeColor = RGB(90, 90, 90)
2556:             .BackStyle = 0
2557:             .AutoSize  = .F.
2558:             .Visible   = .T.
2559:         ENDWITH
2560: 
2561:         par_oPg.AddObject("opt_4c_Resps", "OptionGroup")
2562:         WITH par_oPg.opt_4c_Resps
2563:             .ButtonCount = 2
2564:             .AutoSize    = .F.
2565:             .BackStyle   = 0
2566:             .BorderStyle = 0
2567:             .Height      = 20
2568:             .Left        = 431
2569:             .Top         = 41
2570:             .Width       = 86
2571:             .Value       = 2
2572:             .Visible     = .T.
2573:             .Buttons(1).Caption   = "Sim"
2574:             .Buttons(1).FontSize  = 8
2575:             .Buttons(1).BackStyle = 0
2576:             .Buttons(1).Left      = 5
2577:             .Buttons(1).Top       = 3
2578:             .Buttons(1).Width     = 34
2579:             .Buttons(1).AutoSize  = .T.
2580:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2581:             .Buttons(2).FontSize  = 8
2582:             .Buttons(2).BackStyle = 0
2583:             .Buttons(2).Left      = 45
2584:             .Buttons(2).Top       = 3
2585:             .Buttons(2).Width     = 37
2586:             .Buttons(2).AutoSize  = .T.
2587:         ENDWITH
2588: 
2589:         *-- Estoque Disponivel (estdisps)
2590:         par_oPg.AddObject("lbl_4c_Estdisps", "Label")
2591:         WITH par_oPg.lbl_4c_Estdisps
2592:             .FontName  = "Tahoma"
2593:             .FontSize  = 8
2594:             .Caption   = "Estoque Dispon" + CHR(237) + "vel :"
2595:             .Top       = 64
2596:             .Left      = 335
2597:             .Width     = 99
2598:             .Height    = 15
2599:             .ForeColor = RGB(90, 90, 90)
2600:             .BackStyle = 0
2601:             .AutoSize  = .F.
2602:             .Visible   = .T.
2603:         ENDWITH
2604: 
2605:         par_oPg.AddObject("opt_4c_Estdisps", "OptionGroup")
2606:         WITH par_oPg.opt_4c_Estdisps
2607:             .ButtonCount = 2
2608:             .AutoSize    = .F.
2609:             .BackStyle   = 0
2610:             .BorderStyle = 0
2611:             .Height      = 20
2612:             .Left        = 431
2613:             .Top         = 60
2614:             .Width       = 86
2615:             .Value       = 2
2616:             .Visible     = .T.
2617:             .Buttons(1).Caption   = "Sim"
2618:             .Buttons(1).FontSize  = 8
2619:             .Buttons(1).BackStyle = 0
2620:             .Buttons(1).Left      = 5
2621:             .Buttons(1).Top       = 3
2622:             .Buttons(1).Width     = 34
2623:             .Buttons(1).AutoSize  = .T.
2624:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2625:             .Buttons(2).FontSize  = 8
2626:             .Buttons(2).BackStyle = 0
2627:             .Buttons(2).Left      = 45
2628:             .Buttons(2).Top       = 3
2629:             .Buttons(2).Width     = 37
2630:             .Buttons(2).AutoSize  = .T.
2631:         ENDWITH
2632: 
2633:         *-- Quantidade de Volumes (volumes)
2634:         par_oPg.AddObject("lbl_4c_Volumes", "Label")
2635:         WITH par_oPg.lbl_4c_Volumes
2636:             .FontName  = "Tahoma"
2637:             .FontSize  = 8
2638:             .Caption   = "Quantidade de Volumes :"
2639:             .Top       = 83
2640:             .Left      = 312
2641:             .Width     = 122
2642:             .Height    = 15
2643:             .ForeColor = RGB(90, 90, 90)
2644:             .BackStyle = 0
2645:             .AutoSize  = .F.
2646:             .Visible   = .T.
2647:         ENDWITH
2648: 
2649:         par_oPg.AddObject("opt_4c_Volumes", "OptionGroup")
2650:         WITH par_oPg.opt_4c_Volumes
2651:             .ButtonCount = 2
2652:             .AutoSize    = .F.
2653:             .BackStyle   = 0
2654:             .BorderStyle = 0
2655:             .Height      = 20
2656:             .Left        = 431
2657:             .Top         = 79
2658:             .Width       = 86
2659:             .Value       = 2
2660:             .Visible     = .T.
2661:             .Buttons(1).Caption   = "Sim"
2662:             .Buttons(1).FontSize  = 8
2663:             .Buttons(1).BackStyle = 0
2664:             .Buttons(1).Left      = 5
2665:             .Buttons(1).Top       = 3
2666:             .Buttons(1).Width     = 34
2667:             .Buttons(1).AutoSize  = .T.
2668:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2669:             .Buttons(2).FontSize  = 8
2670:             .Buttons(2).BackStyle = 0
2671:             .Buttons(2).Left      = 45
2672:             .Buttons(2).Top       = 3
2673:             .Buttons(2).Width     = 37
2674:             .Buttons(2).AutoSize  = .T.
2675:         ENDWITH
2676: 
2677:         *-- Checa Acesso Muda Empresa (acmemps)
2678:         par_oPg.AddObject("lbl_4c_Acmemps", "Label")
2679:         WITH par_oPg.lbl_4c_Acmemps
2680:             .FontName  = "Tahoma"
2681:             .FontSize  = 8
2682:             .Caption   = "Checa Acesso Muda Empresa :"
2683:             .Top       = 103
2684:             .Left      = 285
2685:             .Width     = 149
2686:             .Height    = 15
2687:             .ForeColor = RGB(90, 90, 90)
2688:             .BackStyle = 0
2689:             .AutoSize  = .F.
2690:             .Visible   = .T.
2691:         ENDWITH
2692: 
2693:         par_oPg.AddObject("opt_4c_Acmemps", "OptionGroup")
2694:         WITH par_oPg.opt_4c_Acmemps
2695:             .ButtonCount = 2
2696:             .AutoSize    = .F.
2697:             .BackStyle   = 0
2698:             .BorderStyle = 0
2699:             .Height      = 20
2700:             .Left        = 431
2701:             .Top         = 99
2702:             .Width       = 86
2703:             .Value       = 2
2704:             .Visible     = .T.
2705:             .Buttons(1).Caption   = "Sim"
2706:             .Buttons(1).FontSize  = 8
2707:             .Buttons(1).BackStyle = 0
2708:             .Buttons(1).Left      = 5
2709:             .Buttons(1).Top       = 3
2710:             .Buttons(1).Width     = 34
2711:             .Buttons(1).AutoSize  = .T.
2712:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2713:             .Buttons(2).FontSize  = 8
2714:             .Buttons(2).BackStyle = 0
2715:             .Buttons(2).Left      = 45
2716:             .Buttons(2).Top       = 3
2717:             .Buttons(2).Width     = 37
2718:             .Buttons(2).AutoSize  = .T.
2719:         ENDWITH
2720: 
2721:         *-- Solicita Senha Responsavel (senresps)
2722:         par_oPg.AddObject("lbl_4c_Senresps", "Label")
2723:         WITH par_oPg.lbl_4c_Senresps
2724:             .FontName  = "Tahoma"
2725:             .FontSize  = 8
2726:             .Caption   = "Solicita Senha Respons" + CHR(225) + "vel :"
2727:             .Top       = 122
2728:             .Left      = 295
2729:             .Width     = 139
2730:             .Height    = 15
2731:             .ForeColor = RGB(90, 90, 90)
2732:             .BackStyle = 0
2733:             .AutoSize  = .F.
2734:             .Visible   = .T.
2735:         ENDWITH
2736: 
2737:         par_oPg.AddObject("opt_4c_Senresps", "OptionGroup")
2738:         WITH par_oPg.opt_4c_Senresps
2739:             .ButtonCount = 2
2740:             .AutoSize    = .F.
2741:             .BackStyle   = 0
2742:             .BorderStyle = 0
2743:             .Height      = 20
2744:             .Left        = 431
2745:             .Top         = 118
2746:             .Width       = 86
2747:             .Value       = 1
2748:             .Visible     = .T.
2749:             .Buttons(1).Caption   = "Sim"
2750:             .Buttons(1).FontSize  = 8
2751:             .Buttons(1).BackStyle = 0
2752:             .Buttons(1).Left      = 5
2753:             .Buttons(1).Top       = 3
2754:             .Buttons(1).Width     = 34
2755:             .Buttons(1).AutoSize  = .T.
2756:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2757:             .Buttons(2).FontSize  = 8
2758:             .Buttons(2).BackStyle = 0
2759:             .Buttons(2).Left      = 45
2760:             .Buttons(2).Top       = 3
2761:             .Buttons(2).Width     = 37
2762:             .Buttons(2).AutoSize  = .T.
2763:         ENDWITH
2764: 
2765:         *-- Checar Data de Entrega (chdtentrs)
2766:         par_oPg.AddObject("lbl_4c_Chdtentrs", "Label")
2767:         WITH par_oPg.lbl_4c_Chdtentrs
2768:             .FontName  = "Tahoma"
2769:             .FontSize  = 8
2770:             .Caption   = "Checar Data de Entrega :"
2771:             .Top       = 141
2772:             .Left      = 309
2773:             .Width     = 125
2774:             .Height    = 15
2775:             .ForeColor = RGB(90, 90, 90)
2776:             .BackStyle = 0
2777:             .AutoSize  = .F.
2778:             .Visible   = .T.
2779:         ENDWITH
2780: 
2781:         par_oPg.AddObject("opt_4c_Chdtentrs", "OptionGroup")
2782:         WITH par_oPg.opt_4c_Chdtentrs
2783:             .ButtonCount = 2
2784:             .AutoSize    = .F.
2785:             .BackStyle   = 0
2786:             .BorderStyle = 0
2787:             .Height      = 20
2788:             .Left        = 431
2789:             .Top         = 137
2790:             .Width       = 86
2791:             .Value       = 1
2792:             .Visible     = .T.
2793:             .Buttons(1).Caption   = "Sim"
2794:             .Buttons(1).FontSize  = 8
2795:             .Buttons(1).BackStyle = 0
2796:             .Buttons(1).Left      = 5
2797:             .Buttons(1).Top       = 3
2798:             .Buttons(1).Width     = 34
2799:             .Buttons(1).AutoSize  = .T.
2800:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2801:             .Buttons(2).FontSize  = 8
2802:             .Buttons(2).BackStyle = 0
2803:             .Buttons(2).Left      = 45
2804:             .Buttons(2).Top       = 3
2805:             .Buttons(2).Width     = 37
2806:             .Buttons(2).AutoSize  = .T.
2807:         ENDWITH
2808: 
2809:         *-- Imprime Documentos (multiimps)
2810:         par_oPg.AddObject("lbl_4c_Multiimps", "Label")
2811:         WITH par_oPg.lbl_4c_Multiimps
2812:             .FontName  = "Tahoma"
2813:             .FontSize  = 8
2814:             .Caption   = "Imprime Documentos :"
2815:             .Top       = 160
2816:             .Left      = 325
2817:             .Width     = 109
2818:             .Height    = 15
2819:             .ForeColor = RGB(90, 90, 90)
2820:             .BackStyle = 0
2821:             .AutoSize  = .F.
2822:             .Visible   = .T.
2823:         ENDWITH
2824: 
2825:         par_oPg.AddObject("opt_4c_Multiimps", "OptionGroup")
2826:         WITH par_oPg.opt_4c_Multiimps
2827:             .ButtonCount = 2
2828:             .AutoSize    = .F.
2829:             .BackStyle   = 0
2830:             .BorderStyle = 0
2831:             .Height      = 20
2832:             .Left        = 431
2833:             .Top         = 156
2834:             .Width       = 86
2835:             .Value       = 1
2836:             .Visible     = .T.
2837:             .Buttons(1).Caption   = "Sim"
2838:             .Buttons(1).FontSize  = 8
2839:             .Buttons(1).BackStyle = 0
2840:             .Buttons(1).Left      = 5
2841:             .Buttons(1).Top       = 3
2842:             .Buttons(1).Width     = 34
2843:             .Buttons(1).AutoSize  = .T.
2844:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2845:             .Buttons(2).FontSize  = 8
2846:             .Buttons(2).BackStyle = 0
2847:             .Buttons(2).Left      = 45
2848:             .Buttons(2).Top       = 3
2849:             .Buttons(2).Width     = 37
2850:             .Buttons(2).AutoSize  = .T.
2851:         ENDWITH
2852: 
2853:         *-- Utiliza Conta (contas)
2854:         par_oPg.AddObject("lbl_4c_Contas", "Label")
2855:         WITH par_oPg.lbl_4c_Contas
2856:             .FontName  = "Tahoma"
2857:             .FontSize  = 8
2858:             .Caption   = "Utiliza Conta :"
2859:             .Top       = 179
2860:             .Left      = 365
2861:             .Width     = 69
2862:             .Height    = 15
2863:             .ForeColor = RGB(90, 90, 90)
2864:             .BackStyle = 0
2865:             .AutoSize  = .F.
2866:             .Visible   = .T.
2867:         ENDWITH
2868: 
2869:         par_oPg.AddObject("opt_4c_Contas", "OptionGroup")
2870:         WITH par_oPg.opt_4c_Contas
2871:             .ButtonCount = 2
2872:             .AutoSize    = .F.
2873:             .BackStyle   = 0
2874:             .BorderStyle = 0
2875:             .Height      = 20
2876:             .Left        = 431
2877:             .Top         = 175
2878:             .Width       = 86
2879:             .Value       = 2
2880:             .Visible     = .T.
2881:             .Buttons(1).Caption   = "Sim"
2882:             .Buttons(1).FontSize  = 8
2883:             .Buttons(1).BackStyle = 0
2884:             .Buttons(1).Left      = 5
2885:             .Buttons(1).Top       = 3
2886:             .Buttons(1).Width     = 34
2887:             .Buttons(1).AutoSize  = .T.
2888:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2889:             .Buttons(2).FontSize  = 8
2890:             .Buttons(2).BackStyle = 0
2891:             .Buttons(2).Left      = 45
2892:             .Buttons(2).Top       = 3
2893:             .Buttons(2).Width     = 37
2894:             .Buttons(2).AutoSize  = .T.
2895:         ENDWITH
2896: 
2897:         *-- SECAO "Credito / Bonus" (header Bold, Left=524)
2898:         par_oPg.AddObject("lbl_4c_CrBonus", "Label")
2899:         WITH par_oPg.lbl_4c_CrBonus
2900:             .FontName  = "Tahoma"
2901:             .FontSize  = 8
2902:             .FontBold  = .T.
2903:             .Caption   = "Cr" + CHR(233) + "dito / B" + CHR(244) + "nus"
2904:             .Top       = 10
2905:             .Left      = 524
2906:             .Width     = 89
2907:             .Height    = 15
2908:             .ForeColor = RGB(90, 90, 90)
2909:             .BackStyle = 0

*-- Linhas 2927 a 2970:
2927:         ENDWITH
2928: 
2929:         *-- Gera Controle de Subniveis (geracrs)
2930:         par_oPg.AddObject("opt_4c_Geracrs", "OptionGroup")
2931:         WITH par_oPg.opt_4c_Geracrs
2932:             .ButtonCount = 2
2933:             .AutoSize    = .F.
2934:             .BackStyle   = 0
2935:             .BorderStyle = 0
2936:             .Height      = 20
2937:             .Left        = 572
2938:             .Top         = 22
2939:             .Width       = 86
2940:             .Value       = 2
2941:             .Visible     = .T.
2942:             .Buttons(1).Caption   = "Sim"
2943:             .Buttons(1).FontSize  = 8
2944:             .Buttons(1).BackStyle = 0
2945:             .Buttons(1).Left      = 5
2946:             .Buttons(1).Top       = 3
2947:             .Buttons(1).Width     = 34
2948:             .Buttons(1).AutoSize  = .T.
2949:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2950:             .Buttons(2).FontSize  = 8
2951:             .Buttons(2).BackStyle = 0
2952:             .Buttons(2).Left      = 45
2953:             .Buttons(2).Top       = 3
2954:             .Buttons(2).Width     = 37
2955:             .Buttons(2).AutoSize  = .T.
2956:         ENDWITH
2957: 
2958:         par_oPg.AddObject("lbl_4c_Subnivel", "Label")
2959:         WITH par_oPg.lbl_4c_Subnivel
2960:             .FontName  = "Tahoma"
2961:             .FontSize  = 8
2962:             .Caption   = "Subn" + CHR(237) + "vel :"
2963:             .Top       = 47
2964:             .Left      = 530
2965:             .Width     = 49
2966:             .Height    = 15
2967:             .ForeColor = RGB(90, 90, 90)
2968:             .BackStyle = 0
2969:             .AutoSize  = .F.
2970:             .Visible   = .T.

*-- Linhas 3016 a 3059:
3016:         ENDWITH
3017: 
3018:         *-- Tipo de Bloqueio (tpbloqueio) - 3 opcoes verticais
3019:         par_oPg.AddObject("opt_4c_Tpbloqueio", "OptionGroup")
3020:         WITH par_oPg.opt_4c_Tpbloqueio
3021:             .ButtonCount = 3
3022:             .AutoSize    = .F.
3023:             .BackStyle   = 0
3024:             .BorderStyle = 0
3025:             .Height      = 48
3026:             .Left        = 585
3027:             .Top         = 77
3028:             .Width       = 244
3029:             .Value       = 1
3030:             .Visible     = .T.
3031:             .Buttons(1).Caption   = "Per" + CHR(237) + "odo"
3032:             .Buttons(1).FontSize  = 8
3033:             .Buttons(1).BackStyle = 0
3034:             .Buttons(1).Left      = 3
3035:             .Buttons(1).Top       = 1
3036:             .Buttons(1).Width     = 54
3037:             .Buttons(1).AutoSize  = .T.
3038:             .Buttons(2).Caption   = "Limite M" + CHR(237) + "nimo"
3039:             .Buttons(2).FontSize  = 8
3040:             .Buttons(2).BackStyle = 0
3041:             .Buttons(2).Left      = 3
3042:             .Buttons(2).Top       = 15
3043:             .Buttons(2).Width     = 80
3044:             .Buttons(2).AutoSize  = .T.
3045:             .Buttons(3).Caption   = "N" + CHR(227) + "o Bloqueia"
3046:             .Buttons(3).FontSize  = 8
3047:             .Buttons(3).BackStyle = 0
3048:             .Buttons(3).Left      = 3
3049:             .Buttons(3).Top       = 29
3050:             .Buttons(3).Width     = 81
3051:             .Buttons(3).AutoSize  = .T.
3052:         ENDWITH
3053: 
3054:         *-- SECAO "Icone Para Barra de Acesso" (header Bold)
3055:         par_oPg.AddObject("lbl_4c_IcoBarra", "Label")
3056:         WITH par_oPg.lbl_4c_IcoBarra
3057:             .FontName  = "Tahoma"
3058:             .FontSize  = 8
3059:             .FontBold  = .T.

*-- Linhas 3107 a 3245:
3107:     *--------------------------------------------------------------------------
3108:     * CarregarLista - Carrega dados do grid da Page1
3109:     *--------------------------------------------------------------------------
3110:     PROCEDURE CarregarLista()
3111:         LOCAL loc_lResultado, loc_oGrid
3112:         loc_lResultado = .F.
3113: 
3114:         TRY
3115:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3116:                 loc_lResultado = .T.
3117:             ELSE
3118:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
3119: 
3120:                 IF VARTYPE(loc_oGrid) = "O" AND THIS.this_oBusinessObject.Buscar("")
3121:                     loc_oGrid.ColumnCount = 2
3122:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
3123:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dgopes"
3124:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ngopes"
3125: 
3126:                     *-- Reconfigurar headers APOS RecordSource (VFP9 reseta headers)
3127:                     loc_oGrid.Column1.Header1.Caption = "Grupo Operacional"
3128:                     loc_oGrid.Column2.Header1.Caption = "N" + CHR(186)
3129:                     loc_oGrid.Column2.Alignment       = 1
3130: 
3131:                     THIS.FormatarGridLista(loc_oGrid)
3132:                     loc_lResultado = .T.
3133:                 ENDIF
3134:             ENDIF
3135:         CATCH TO loc_oErro
3136:             MsgErro(loc_oErro.Message + CHR(13) + ;
3137:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
3138:             loc_lResultado = .F.
3139:         ENDTRY
3140: 
3141:         RETURN loc_lResultado
3142:     ENDPROC
3143: 
3144:     *--------------------------------------------------------------------------
3145:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
3146:     *--------------------------------------------------------------------------
3147:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
3148:         LOCAL loc_lResultado
3149:         loc_lResultado = .F.
3150: 
3151:         TRY
3152:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
3153:                 loc_lResultado = .F.
3154:             ELSE
3155:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3156:                 IF par_nPagina = 1
3157:                     THIS.CarregarLista()
3158:                 ENDIF
3159:                 loc_lResultado = .T.
3160:             ENDIF
3161:         CATCH TO loc_oErro
3162:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")
3163:             loc_lResultado = .F.
3164:         ENDTRY
3165: 
3166:         RETURN loc_lResultado
3167:     ENDPROC
3168: 
3169:     *--------------------------------------------------------------------------
3170:     * FormParaBO - Transfere valores do Form para o BO
3171:     * Fase 6: campos detalhados
3172:     *--------------------------------------------------------------------------
3173:     PROTECTED PROCEDURE FormParaBO()
3174:         LOCAL loc_lResultado, loc_oPg2, loc_oPg1, loc_oPgC
3175:         loc_lResultado = .F.
3176: 
3177:         TRY
3178:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3179:             loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
3180:             loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2
3181: 
3182:             WITH THIS.this_oBusinessObject
3183:                 *-- Identificacao (Page2 direto)
3184:                 .this_cDgopes = ALLTRIM(loc_oPg2.txt_4c_Dgope.Value)
3185: 
3186:                 *-- pgConfig: OptionGroups e TextBox
3187:                 .this_nNumopers   = loc_oPg1.opt_4c_NumOper.Value
3188:                 .this_nNcontroles = loc_oPg1.opt_4c_Controle.Value
3189:                 .this_nFontnums   = loc_oPg1.opt_4c_FonNum.Value
3190:                 .this_nUtilizas   = loc_oPg1.opt_4c_Utilizas.Value
3191:                 .this_nSubniveis  = loc_oPg1.opt_4c_Subniveis.Value
3192:                 .this_nProds      = loc_oPg1.opt_4c_Prods.Value
3193:                 .this_nDesutils   = loc_oPg1.opt_4c_Desutils.Value
3194:                 .this_nIniagenda  = loc_oPg1.opt_4c_Iniagenda.Value
3195:                 .this_nQualquer   = loc_oPg1.opt_4c_Qualquer.Value
3196:                 .this_nConsulta   = loc_oPg1.opt_4c_Consulta.Value
3197:                 .this_nMontagem   = loc_oPg1.opt_4c_Montagem.Value
3198:                 .this_nChkmercs   = loc_oPg1.opt_4c_Chkmercs.Value
3199:                 .this_nOputiliza  = loc_oPg1.opt_4c_Oputiliza.Value
3200:                 .this_nFilpagas   = loc_oPg1.opt_4c_Filpagas.Value
3201:                 .this_nFilbaixas  = loc_oPg1.opt_4c_Filbaixas.Value
3202:                 .this_nAudits     = loc_oPg1.opt_4c_Audits.Value
3203:                 .this_nLimdia     = INT(VAL(TRANSFORM(loc_oPg1.txt_4c_Limdia.Value)))
3204: 
3205:                 *-- pgCompls: OptionGroups
3206:                 .this_nDtatuals   = loc_oPgC.opt_4c_Dtatuals.Value
3207:                 .this_nBlqadts    = loc_oPgC.opt_4c_Blqadts.Value
3208:                 .this_nInibocors  = loc_oPgC.opt_4c_Inibocors.Value
3209:                 .this_nInibfecs   = loc_oPgC.opt_4c_Inibfecs.Value
3210:                 .this_nAlterar    = loc_oPgC.opt_4c_Alterar.Value
3211:                 .this_nPeriodos   = loc_oPgC.opt_4c_Periodos.Value
3212:                 .this_nEntregas   = loc_oPgC.opt_4c_Entregas.Value
3213:                 .this_nOperacoes  = loc_oPgC.opt_4c_Operacoes.Value
3214:                 .this_nVends      = loc_oPgC.opt_4c_Vends.Value
3215:                 .this_nSacs       = loc_oPgC.opt_4c_Sacs.Value
3216:                 .this_nEmpresas   = loc_oPgC.opt_4c_Empresas.Value
3217:                 .this_nCtacusus   = loc_oPgC.opt_4c_Ctacusus.Value
3218:                 .this_nOppends    = loc_oPgC.opt_4c_Oppends.Value
3219:                 .this_nOpagends   = loc_oPgC.opt_4c_Opagends.Value
3220:                 .this_nOppagas    = loc_oPgC.opt_4c_Oppagas.Value
3221:                 .this_nAnacps     = loc_oPgC.opt_4c_Anacps.Value
3222:                 .this_nChkreserva = loc_oPgC.opt_4c_Chkreserva.Value
3223:                 .this_nResps      = loc_oPgC.opt_4c_Resps.Value
3224:                 .this_nEstdisps   = loc_oPgC.opt_4c_Estdisps.Value
3225:                 .this_nVolumes    = loc_oPgC.opt_4c_Volumes.Value
3226:                 .this_nAcmemps    = loc_oPgC.opt_4c_Acmemps.Value
3227:                 .this_nSenresps   = loc_oPgC.opt_4c_Senresps.Value
3228:                 .this_nChdtentrs  = loc_oPgC.opt_4c_Chdtentrs.Value
3229:                 .this_nMultiimps  = loc_oPgC.opt_4c_Multiimps.Value
3230:                 .this_nContas     = loc_oPgC.opt_4c_Contas.Value
3231:                 .this_nGeracrs    = loc_oPgC.opt_4c_Geracrs.Value
3232:                 .this_nTpbloqueio = loc_oPgC.opt_4c_Tpbloqueio.Value
3233: 
3234:                 *-- pgCompls: CheckBoxes (0/1 numeric)
3235:                 .this_nFixaps  = loc_oPgC.chk_4c_Fixaps.Value
3236:                 .this_nFixaas  = loc_oPgC.chk_4c_Fixaas.Value
3237:                 .this_nFixags  = loc_oPgC.chk_4c_Fixags.Value
3238:                 .this_nFixals  = loc_oPgC.chk_4c_Fixals.Value
3239:                 .this_nFixass  = loc_oPgC.chk_4c_Fixass.Value
3240: 
3241:                 *-- pgCompls: ComboBoxes (ListIndex 1-based = DB value)
3242:                 .this_nOrdems  = IIF(loc_oPgC.cmb_4c_Ordems.ListIndex  >= 1, ;
3243:                                      loc_oPgC.cmb_4c_Ordems.ListIndex,  1)
3244:                 .this_nOrdemns = IIF(loc_oPgC.cmb_4c_Ordemns.ListIndex >= 1, ;
3245:                                      loc_oPgC.cmb_4c_Ordemns.ListIndex, 1)

*-- Linhas 3258 a 3343:
3258:         CATCH TO loc_oErro
3259:             MsgErro(loc_oErro.Message + CHR(13) + ;
3260:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3261:                 "Procedure: " + loc_oErro.Procedure, "Erro FormParaBO")
3262:         ENDTRY
3263: 
3264:         RETURN loc_lResultado
3265:     ENDPROC
3266: 
3267:     *--------------------------------------------------------------------------
3268:     * BOParaForm - Transfere valores do BO para o Form
3269:     *--------------------------------------------------------------------------
3270:     PROTECTED PROCEDURE BOParaForm()
3271:         LOCAL loc_lResultado, loc_oPg2, loc_oPg1, loc_oPgC, loc_oBO
3272:         loc_lResultado = .F.
3273: 
3274:         TRY
3275:             loc_oBO  = THIS.this_oBusinessObject
3276:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3277:             loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
3278:             loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2
3279: 
3280:             *-- Identificacao (Page2 direto)
3281:             loc_oPg2.txt_4c_Dgope.Value = ALLTRIM(loc_oBO.this_cDgopes)
3282:             loc_oPg2.txt_4c_Ngope.Value = loc_oBO.this_nNgopes
3283: 
3284:             *-- pgConfig: OptionGroups (IIF guard: val=0 usa botao 1)
3285:             loc_oPg1.opt_4c_NumOper.Value   = IIF(loc_oBO.this_nNumopers   >= 1, loc_oBO.this_nNumopers,   1)
3286:             loc_oPg1.opt_4c_Controle.Value  = IIF(loc_oBO.this_nNcontroles >= 1, loc_oBO.this_nNcontroles, 1)
3287:             loc_oPg1.opt_4c_FonNum.Value    = IIF(loc_oBO.this_nFontnums   >= 1, loc_oBO.this_nFontnums,   1)
3288:             loc_oPg1.opt_4c_Utilizas.Value  = IIF(loc_oBO.this_nUtilizas   >= 1, loc_oBO.this_nUtilizas,   1)
3289:             loc_oPg1.opt_4c_Subniveis.Value = IIF(loc_oBO.this_nSubniveis  >= 1, loc_oBO.this_nSubniveis,  1)
3290:             loc_oPg1.opt_4c_Prods.Value     = IIF(loc_oBO.this_nProds      >= 1, loc_oBO.this_nProds,      1)
3291:             loc_oPg1.opt_4c_Desutils.Value  = IIF(loc_oBO.this_nDesutils   >= 1, loc_oBO.this_nDesutils,   1)
3292:             loc_oPg1.opt_4c_Iniagenda.Value = IIF(loc_oBO.this_nIniagenda  >= 1, loc_oBO.this_nIniagenda,  1)
3293:             loc_oPg1.opt_4c_Qualquer.Value  = IIF(loc_oBO.this_nQualquer   >= 1, loc_oBO.this_nQualquer,   1)
3294:             loc_oPg1.opt_4c_Consulta.Value  = IIF(loc_oBO.this_nConsulta   >= 1, loc_oBO.this_nConsulta,   1)
3295:             loc_oPg1.opt_4c_Montagem.Value  = IIF(loc_oBO.this_nMontagem   >= 1, loc_oBO.this_nMontagem,   1)
3296:             loc_oPg1.opt_4c_Chkmercs.Value  = IIF(loc_oBO.this_nChkmercs   >= 1, loc_oBO.this_nChkmercs,   1)
3297:             loc_oPg1.opt_4c_Oputiliza.Value = IIF(loc_oBO.this_nOputiliza  >= 1, loc_oBO.this_nOputiliza,  1)
3298:             loc_oPg1.opt_4c_Filpagas.Value  = IIF(loc_oBO.this_nFilpagas   >= 1, loc_oBO.this_nFilpagas,   1)
3299:             loc_oPg1.opt_4c_Filbaixas.Value = IIF(loc_oBO.this_nFilbaixas  >= 1, loc_oBO.this_nFilbaixas,  1)
3300:             loc_oPg1.opt_4c_Audits.Value    = IIF(loc_oBO.this_nAudits     >= 1, loc_oBO.this_nAudits,     1)
3301:             loc_oPg1.txt_4c_Limdia.Value    = loc_oBO.this_nLimdia
3302: 
3303:             *-- pgCompls: OptionGroups
3304:             loc_oPgC.opt_4c_Dtatuals.Value   = IIF(loc_oBO.this_nDtatuals   >= 1, loc_oBO.this_nDtatuals,   1)
3305:             loc_oPgC.opt_4c_Blqadts.Value    = IIF(loc_oBO.this_nBlqadts    >= 1, loc_oBO.this_nBlqadts,    1)
3306:             loc_oPgC.opt_4c_Inibocors.Value  = IIF(loc_oBO.this_nInibocors  >= 1, loc_oBO.this_nInibocors,  1)
3307:             loc_oPgC.opt_4c_Inibfecs.Value   = IIF(loc_oBO.this_nInibfecs   >= 1, loc_oBO.this_nInibfecs,   1)
3308:             loc_oPgC.opt_4c_Alterar.Value    = IIF(loc_oBO.this_nAlterar    >= 1, loc_oBO.this_nAlterar,    1)
3309:             loc_oPgC.opt_4c_Periodos.Value   = IIF(loc_oBO.this_nPeriodos   >= 1, loc_oBO.this_nPeriodos,   1)
3310:             loc_oPgC.opt_4c_Entregas.Value   = IIF(loc_oBO.this_nEntregas   >= 1, loc_oBO.this_nEntregas,   1)
3311:             loc_oPgC.opt_4c_Operacoes.Value  = IIF(loc_oBO.this_nOperacoes  >= 1, loc_oBO.this_nOperacoes,  1)
3312:             loc_oPgC.opt_4c_Vends.Value      = IIF(loc_oBO.this_nVends      >= 1, loc_oBO.this_nVends,      1)
3313:             loc_oPgC.opt_4c_Sacs.Value       = IIF(loc_oBO.this_nSacs       >= 1, loc_oBO.this_nSacs,       1)
3314:             loc_oPgC.opt_4c_Empresas.Value   = IIF(loc_oBO.this_nEmpresas   >= 1, loc_oBO.this_nEmpresas,   1)
3315:             loc_oPgC.opt_4c_Ctacusus.Value   = IIF(loc_oBO.this_nCtacusus   >= 1, loc_oBO.this_nCtacusus,   1)
3316:             loc_oPgC.opt_4c_Oppends.Value    = IIF(loc_oBO.this_nOppends    >= 1, loc_oBO.this_nOppends,    1)
3317:             loc_oPgC.opt_4c_Opagends.Value   = IIF(loc_oBO.this_nOpagends   >= 1, loc_oBO.this_nOpagends,   1)
3318:             loc_oPgC.opt_4c_Oppagas.Value    = IIF(loc_oBO.this_nOppagas    >= 1, loc_oBO.this_nOppagas,    1)
3319:             loc_oPgC.opt_4c_Anacps.Value     = IIF(loc_oBO.this_nAnacps     >= 1, loc_oBO.this_nAnacps,     1)
3320:             loc_oPgC.opt_4c_Chkreserva.Value = IIF(loc_oBO.this_nChkreserva >= 1, loc_oBO.this_nChkreserva, 1)
3321:             loc_oPgC.opt_4c_Resps.Value      = IIF(loc_oBO.this_nResps      >= 1, loc_oBO.this_nResps,      1)
3322:             loc_oPgC.opt_4c_Estdisps.Value   = IIF(loc_oBO.this_nEstdisps   >= 1, loc_oBO.this_nEstdisps,   1)
3323:             loc_oPgC.opt_4c_Volumes.Value    = IIF(loc_oBO.this_nVolumes    >= 1, loc_oBO.this_nVolumes,    1)
3324:             loc_oPgC.opt_4c_Acmemps.Value    = IIF(loc_oBO.this_nAcmemps    >= 1, loc_oBO.this_nAcmemps,    1)
3325:             loc_oPgC.opt_4c_Senresps.Value   = IIF(loc_oBO.this_nSenresps   >= 1, loc_oBO.this_nSenresps,   1)
3326:             loc_oPgC.opt_4c_Chdtentrs.Value  = IIF(loc_oBO.this_nChdtentrs  >= 1, loc_oBO.this_nChdtentrs,  1)
3327:             loc_oPgC.opt_4c_Multiimps.Value  = IIF(loc_oBO.this_nMultiimps  >= 1, loc_oBO.this_nMultiimps,  1)
3328:             loc_oPgC.opt_4c_Contas.Value     = IIF(loc_oBO.this_nContas     >= 1, loc_oBO.this_nContas,     1)
3329:             loc_oPgC.opt_4c_Geracrs.Value    = IIF(loc_oBO.this_nGeracrs    >= 1, loc_oBO.this_nGeracrs,    1)
3330:             loc_oPgC.opt_4c_Tpbloqueio.Value = IIF(loc_oBO.this_nTpbloqueio >= 1, loc_oBO.this_nTpbloqueio, 1)
3331: 
3332:             *-- pgCompls: CheckBoxes (0/1)
3333:             loc_oPgC.chk_4c_Fixaps.Value = loc_oBO.this_nFixaps
3334:             loc_oPgC.chk_4c_Fixaas.Value = loc_oBO.this_nFixaas
3335:             loc_oPgC.chk_4c_Fixags.Value = loc_oBO.this_nFixags
3336:             loc_oPgC.chk_4c_Fixals.Value = loc_oBO.this_nFixals
3337:             loc_oPgC.chk_4c_Fixass.Value = loc_oBO.this_nFixass
3338: 
3339:             *-- pgCompls: ComboBoxes (ListIndex 1-based = DB value)
3340:             loc_oPgC.cmb_4c_Ordems.ListIndex  = IIF(loc_oBO.this_nOrdems  >= 1, loc_oBO.this_nOrdems,  1)
3341:             loc_oPgC.cmb_4c_Ordemns.ListIndex = IIF(loc_oBO.this_nOrdemns >= 1, loc_oBO.this_nOrdemns, 1)
3342:             loc_oPgC.cmb_4c_Ordemas.ListIndex = IIF(loc_oBO.this_nOrdemas >= 1, loc_oBO.this_nOrdemas, 1)
3343: 

*-- Linhas 3354 a 3458:
3354:                 loc_oPgC.img_4c_Icone.Visible = .T.
3355:             ELSE
3356:                 loc_oPgC.img_4c_Icone.Visible = .F.
3357:             ENDIF
3358: 
3359:             *-- Grid de Operacoes: carregar cursor_4c_Operacoes
3360:             IF loc_oBO.BuscarOperacoes(ALLTRIM(loc_oBO.this_cDgopes))
3361:                 loc_oPg1.grd_4c_GradeOpe.ColumnCount = 2
3362:                 loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
3363:                 loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
3364:                 loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
3365:                 loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
3366:                     "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
3367:                 loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
3368:                     "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
3369:                 loc_oPg1.grd_4c_GradeOpe.Refresh()
3370:             ENDIF
3371: 
3372:             loc_lResultado = .T.
3373: 
3374:         CATCH TO loc_oErro
3375:             MsgErro(loc_oErro.Message + CHR(13) + ;
3376:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3377:                 "Procedure: " + loc_oErro.Procedure, "Erro BOParaForm")
3378:         ENDTRY
3379: 
3380:         RETURN loc_lResultado
3381:     ENDPROC
3382: 
3383:     *--------------------------------------------------------------------------
3384:     * HabilitarCampos - Habilita ou desabilita campos editaveis
3385:     *--------------------------------------------------------------------------
3386:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3387:         LOCAL loc_oPg2, loc_oPg1, loc_oPgC, loc_lSoLeitura
3388: 
3389:         TRY
3390:             loc_oPg2       = THIS.pgf_4c_Paginas.Page2
3391:             loc_oPg1       = loc_oPg2.pgf_4c_Dados.Page1
3392:             loc_oPgC       = loc_oPg2.pgf_4c_Dados.Page2
3393:             loc_lSoLeitura = !par_lHabilitar
3394: 
3395:             *-- Codigo do grupo: editavel apenas em INCLUIR (e PK)
3396:             loc_oPg2.txt_4c_Dgope.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
3397: 
3398:             *-- pgConfig: OptionGroups e campos
3399:             loc_oPg1.opt_4c_NumOper.Enabled   = par_lHabilitar
3400:             loc_oPg1.opt_4c_Controle.Enabled  = par_lHabilitar
3401:             loc_oPg1.opt_4c_FonNum.Enabled    = par_lHabilitar
3402:             loc_oPg1.opt_4c_Utilizas.Enabled  = par_lHabilitar
3403:             loc_oPg1.opt_4c_Subniveis.Enabled = par_lHabilitar
3404:             loc_oPg1.opt_4c_Prods.Enabled     = par_lHabilitar
3405:             loc_oPg1.opt_4c_Desutils.Enabled  = par_lHabilitar
3406:             loc_oPg1.opt_4c_Iniagenda.Enabled = par_lHabilitar
3407:             loc_oPg1.opt_4c_Qualquer.Enabled  = par_lHabilitar
3408:             loc_oPg1.opt_4c_Consulta.Enabled  = par_lHabilitar
3409:             loc_oPg1.opt_4c_Montagem.Enabled  = par_lHabilitar
3410:             loc_oPg1.opt_4c_Chkmercs.Enabled  = par_lHabilitar
3411:             loc_oPg1.opt_4c_Oputiliza.Enabled = par_lHabilitar
3412:             loc_oPg1.opt_4c_Filpagas.Enabled  = par_lHabilitar
3413:             loc_oPg1.opt_4c_Filbaixas.Enabled = par_lHabilitar
3414:             loc_oPg1.opt_4c_Audits.Enabled    = par_lHabilitar
3415:             loc_oPg1.txt_4c_Limdia.ReadOnly   = loc_lSoLeitura
3416:             loc_oPg1.grd_4c_GradeOpe.ReadOnly = loc_lSoLeitura
3417: 
3418:             *-- pgCompls: OptionGroups
3419:             loc_oPgC.opt_4c_Dtatuals.Enabled   = par_lHabilitar
3420:             loc_oPgC.opt_4c_Blqadts.Enabled    = par_lHabilitar
3421:             loc_oPgC.opt_4c_Inibocors.Enabled  = par_lHabilitar
3422:             loc_oPgC.opt_4c_Inibfecs.Enabled   = par_lHabilitar
3423:             loc_oPgC.opt_4c_Alterar.Enabled    = par_lHabilitar
3424:             loc_oPgC.opt_4c_Periodos.Enabled   = par_lHabilitar
3425:             loc_oPgC.opt_4c_Entregas.Enabled   = par_lHabilitar
3426:             loc_oPgC.opt_4c_Operacoes.Enabled  = par_lHabilitar
3427:             loc_oPgC.opt_4c_Vends.Enabled      = par_lHabilitar
3428:             loc_oPgC.opt_4c_Sacs.Enabled       = par_lHabilitar
3429:             loc_oPgC.opt_4c_Empresas.Enabled   = par_lHabilitar
3430:             loc_oPgC.opt_4c_Ctacusus.Enabled   = par_lHabilitar
3431:             loc_oPgC.opt_4c_Oppends.Enabled    = par_lHabilitar
3432:             loc_oPgC.opt_4c_Opagends.Enabled   = par_lHabilitar
3433:             loc_oPgC.opt_4c_Oppagas.Enabled    = par_lHabilitar
3434:             loc_oPgC.opt_4c_Anacps.Enabled     = par_lHabilitar
3435:             loc_oPgC.opt_4c_Chkreserva.Enabled = par_lHabilitar
3436:             loc_oPgC.opt_4c_Resps.Enabled      = par_lHabilitar
3437:             loc_oPgC.opt_4c_Estdisps.Enabled   = par_lHabilitar
3438:             loc_oPgC.opt_4c_Volumes.Enabled    = par_lHabilitar
3439:             loc_oPgC.opt_4c_Acmemps.Enabled    = par_lHabilitar
3440:             loc_oPgC.opt_4c_Senresps.Enabled   = par_lHabilitar
3441:             loc_oPgC.opt_4c_Chdtentrs.Enabled  = par_lHabilitar
3442:             loc_oPgC.opt_4c_Multiimps.Enabled  = par_lHabilitar
3443:             loc_oPgC.opt_4c_Contas.Enabled     = par_lHabilitar
3444:             loc_oPgC.opt_4c_Geracrs.Enabled    = par_lHabilitar
3445:             loc_oPgC.opt_4c_Tpbloqueio.Enabled = par_lHabilitar
3446: 
3447:             *-- pgCompls: CheckBoxes
3448:             loc_oPgC.chk_4c_Fixaps.Enabled = par_lHabilitar
3449:             loc_oPgC.chk_4c_Fixaas.Enabled = par_lHabilitar
3450:             loc_oPgC.chk_4c_Fixags.Enabled = par_lHabilitar
3451:             loc_oPgC.chk_4c_Fixals.Enabled = par_lHabilitar
3452:             loc_oPgC.chk_4c_Fixass.Enabled = par_lHabilitar
3453: 
3454:             *-- pgCompls: ComboBoxes
3455:             loc_oPgC.cmb_4c_Ordems.Enabled  = par_lHabilitar
3456:             loc_oPgC.cmb_4c_Ordemns.Enabled = par_lHabilitar
3457:             loc_oPgC.cmb_4c_Ordemas.Enabled = par_lHabilitar
3458: 

*-- Linhas 3466 a 3562:
3466:         CATCH TO loc_oErro
3467:             MsgErro(loc_oErro.Message + CHR(13) + ;
3468:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3469:                 "Procedure: " + loc_oErro.Procedure, "Erro HabilitarCampos")
3470:         ENDTRY
3471:     ENDPROC
3472: 
3473:     *--------------------------------------------------------------------------
3474:     * LimparCampos - Limpa valores dos campos da Page2 (para novo registro)
3475:     *--------------------------------------------------------------------------
3476:     PROTECTED PROCEDURE LimparCampos()
3477:         LOCAL loc_oPg2, loc_oPg1, loc_oPgC
3478: 
3479:         TRY
3480:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3481:             loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
3482:             loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2
3483: 
3484:             *-- Identificacao
3485:             loc_oPg2.txt_4c_Dgope.Value = ""
3486:             loc_oPg2.txt_4c_Ngope.Value = 0
3487: 
3488:             *-- pgConfig: OptionGroups → todos Value=1 (primeiro botao)
3489:             loc_oPg1.opt_4c_NumOper.Value   = 1
3490:             loc_oPg1.opt_4c_Controle.Value  = 1
3491:             loc_oPg1.opt_4c_FonNum.Value    = 1
3492:             loc_oPg1.opt_4c_Utilizas.Value  = 1
3493:             loc_oPg1.opt_4c_Subniveis.Value = 1
3494:             loc_oPg1.opt_4c_Prods.Value     = 1
3495:             loc_oPg1.opt_4c_Desutils.Value  = 1
3496:             loc_oPg1.opt_4c_Iniagenda.Value = 1
3497:             loc_oPg1.opt_4c_Qualquer.Value  = 1
3498:             loc_oPg1.opt_4c_Consulta.Value  = 1
3499:             loc_oPg1.opt_4c_Montagem.Value  = 1
3500:             loc_oPg1.opt_4c_Chkmercs.Value  = 1
3501:             loc_oPg1.opt_4c_Oputiliza.Value = 1
3502:             loc_oPg1.opt_4c_Filpagas.Value  = 1
3503:             loc_oPg1.opt_4c_Filbaixas.Value = 1
3504:             loc_oPg1.opt_4c_Audits.Value    = 1
3505:             loc_oPg1.txt_4c_Limdia.Value    = 0
3506: 
3507:             *-- pgConfig: Grid → cursor vazio editavel
3508:             IF USED("cursor_4c_Operacoes")
3509:                 USE IN cursor_4c_Operacoes
3510:             ENDIF
3511:             CREATE CURSOR cursor_4c_Operacoes (dopers C(20), confops C(20), cidchaves C(20))
3512:             loc_oPg1.grd_4c_GradeOpe.ColumnCount = 2
3513:             loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
3514:             loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
3515:             loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
3516:             loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
3517:                 "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
3518:             loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
3519:                 "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
3520:             loc_oPg1.grd_4c_GradeOpe.Refresh()
3521: 
3522:             *-- pgCompls: OptionGroups → todos Value=1
3523:             loc_oPgC.opt_4c_Dtatuals.Value   = 1
3524:             loc_oPgC.opt_4c_Blqadts.Value    = 1
3525:             loc_oPgC.opt_4c_Inibocors.Value  = 1
3526:             loc_oPgC.opt_4c_Inibfecs.Value   = 1
3527:             loc_oPgC.opt_4c_Alterar.Value    = 1
3528:             loc_oPgC.opt_4c_Periodos.Value   = 1
3529:             loc_oPgC.opt_4c_Entregas.Value   = 1
3530:             loc_oPgC.opt_4c_Operacoes.Value  = 1
3531:             loc_oPgC.opt_4c_Vends.Value      = 1
3532:             loc_oPgC.opt_4c_Sacs.Value       = 1
3533:             loc_oPgC.opt_4c_Empresas.Value   = 1
3534:             loc_oPgC.opt_4c_Ctacusus.Value   = 1
3535:             loc_oPgC.opt_4c_Oppends.Value    = 1
3536:             loc_oPgC.opt_4c_Opagends.Value   = 1
3537:             loc_oPgC.opt_4c_Oppagas.Value    = 1
3538:             loc_oPgC.opt_4c_Anacps.Value     = 1
3539:             loc_oPgC.opt_4c_Chkreserva.Value = 1
3540:             loc_oPgC.opt_4c_Resps.Value      = 1
3541:             loc_oPgC.opt_4c_Estdisps.Value   = 1
3542:             loc_oPgC.opt_4c_Volumes.Value    = 1
3543:             loc_oPgC.opt_4c_Acmemps.Value    = 1
3544:             loc_oPgC.opt_4c_Senresps.Value   = 1
3545:             loc_oPgC.opt_4c_Chdtentrs.Value  = 1
3546:             loc_oPgC.opt_4c_Multiimps.Value  = 1
3547:             loc_oPgC.opt_4c_Contas.Value     = 1
3548:             loc_oPgC.opt_4c_Geracrs.Value    = 1
3549:             loc_oPgC.opt_4c_Tpbloqueio.Value = 1
3550: 
3551:             *-- pgCompls: CheckBoxes
3552:             loc_oPgC.chk_4c_Fixaps.Value = 0
3553:             loc_oPgC.chk_4c_Fixaas.Value = 0
3554:             loc_oPgC.chk_4c_Fixags.Value = 0
3555:             loc_oPgC.chk_4c_Fixals.Value = 0
3556:             loc_oPgC.chk_4c_Fixass.Value = 0
3557: 
3558:             *-- pgCompls: ComboBoxes → primeira opcao
3559:             loc_oPgC.cmb_4c_Ordems.ListIndex  = 1
3560:             loc_oPgC.cmb_4c_Ordemns.ListIndex = 1
3561:             loc_oPgC.cmb_4c_Ordemas.ListIndex = 1
3562: 

*-- Linhas 3570 a 3803:
3570:         CATCH TO loc_oErro
3571:             MsgErro(loc_oErro.Message + CHR(13) + ;
3572:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3573:                 "Procedure: " + loc_oErro.Procedure, "Erro LimparCampos")
3574:         ENDTRY
3575:     ENDPROC
3576: 
3577:     *--------------------------------------------------------------------------
3578:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
3579:     *--------------------------------------------------------------------------
3580:     PROTECTED PROCEDURE AjustarBotoesPorModo()
3581:         LOCAL loc_oBotoes, loc_lTemRegistro
3582: 
3583:         TRY
3584:             loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
3585:             loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
3586:                                !EOF("cursor_4c_Dados") AND ;
3587:                                RECCOUNT("cursor_4c_Dados") > 0
3588: 
3589:             IF VARTYPE(loc_oBotoes) = "O"
3590:                 loc_oBotoes.cmd_4c_Incluir.Enabled    = .T.
3591:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3592:                 loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3593:                 loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3594:                 loc_oBotoes.cmd_4c_Buscar.Enabled     = .T.
3595:             ENDIF
3596:         CATCH TO loc_oErro
3597:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
3598:         ENDTRY
3599:     ENDPROC
3600: 
3601:     *--------------------------------------------------------------------------
3602:     * BtnEncerrarClick - Fecha o formulario
3603:     *--------------------------------------------------------------------------
3604:     PROCEDURE BtnEncerrarClick()
3605:         THIS.Release()
3606:     ENDPROC
3607: 
3608:     *--------------------------------------------------------------------------
3609:     * BtnIncluirClick - Prepara formulario para inclusao de novo registro
3610:     *--------------------------------------------------------------------------
3611:     PROCEDURE BtnIncluirClick()
3612:         THIS.this_oBusinessObject.NovoRegistro()
3613:         THIS.LimparCampos()
3614:         THIS.this_cModoAtual = "INCLUIR"
3615:         THIS.HabilitarCampos(.T.)
3616:         THIS.pgf_4c_Paginas.ActivePage = 2
3617:     ENDPROC
3618: 
3619:     *--------------------------------------------------------------------------
3620:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
3621:     *--------------------------------------------------------------------------
3622:     PROCEDURE BtnVisualizarClick()
3623:         LOCAL loc_cDgopes
3624:         loc_cDgopes = ""
3625: 
3626:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3627:             MsgAviso("Selecione um registro na lista.", "")
3628:             RETURN
3629:         ENDIF
3630: 
3631:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3632: 
3633:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
3634:             THIS.BOParaForm()
3635:             THIS.this_cModoAtual = "VISUALIZAR"
3636:             THIS.HabilitarCampos(.F.)
3637:             THIS.pgf_4c_Paginas.ActivePage = 2
3638:         ENDIF
3639:     ENDPROC
3640: 
3641:     *--------------------------------------------------------------------------
3642:     * BtnAlterarClick - Carrega registro selecionado para edicao
3643:     *--------------------------------------------------------------------------
3644:     PROCEDURE BtnAlterarClick()
3645:         LOCAL loc_cDgopes
3646:         loc_cDgopes = ""
3647: 
3648:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3649:             MsgAviso("Selecione um registro na lista.", "")
3650:             RETURN
3651:         ENDIF
3652: 
3653:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3654: 
3655:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
3656:             THIS.this_oBusinessObject.EditarRegistro()
3657:             THIS.BOParaForm()
3658:             THIS.this_cModoAtual = "ALTERAR"
3659:             THIS.HabilitarCampos(.T.)
3660:             THIS.pgf_4c_Paginas.ActivePage = 2
3661:         ENDIF
3662:     ENDPROC
3663: 
3664:     *--------------------------------------------------------------------------
3665:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
3666:     *--------------------------------------------------------------------------
3667:     PROCEDURE BtnExcluirClick()
3668:         LOCAL loc_cDgopes
3669: 
3670:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3671:             MsgAviso("Selecione um registro na lista.", "")
3672:             RETURN
3673:         ENDIF
3674: 
3675:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3676: 
3677:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo operacional:" + ;
3678:                 CHR(13) + loc_cDgopes + "?", "Excluir")
3679:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
3680:                 IF THIS.this_oBusinessObject.Excluir()
3681:                     MsgInfo("Grupo operacional exclu" + CHR(237) + "do com sucesso!", "")
3682:                     THIS.CarregarLista()
3683:                 ENDIF
3684:             ENDIF
3685:         ENDIF
3686:     ENDPROC
3687: 
3688:     *--------------------------------------------------------------------------
3689:     * BtnBuscarClick - Abre lookup para localizar grupo na lista
3690:     *--------------------------------------------------------------------------
3691:     PROCEDURE BtnBuscarClick()
3692:         LOCAL loc_oBusca, loc_cDgopes
3693: 
3694:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3695:             "SigCdGpe", "cursor_4c_Busca", "dgopes", "", ;
3696:             "Buscar Grupo Operacional")
3697: 
3698:         IF VARTYPE(loc_oBusca) = "O"
3699:             loc_oBusca.mAddColuna("dgopes", "", "Grupo Operacional")
3700:             loc_oBusca.mAddColuna("ngopes", "", "N" + CHR(186))
3701:             loc_oBusca.Show()
3702: 
3703:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3704:                 loc_cDgopes = ALLTRIM(cursor_4c_Busca.dgopes)
3705:                 IF USED("cursor_4c_Dados")
3706:                     SELECT cursor_4c_Dados
3707:                     LOCATE FOR ALLTRIM(dgopes) = loc_cDgopes
3708:                 ENDIF
3709:             ENDIF
3710: 
3711:             loc_oBusca.Release()
3712:         ENDIF
3713: 
3714:         IF USED("cursor_4c_Busca")
3715:             USE IN cursor_4c_Busca
3716:         ENDIF
3717:     ENDPROC
3718: 
3719:     *--------------------------------------------------------------------------
3720:     * BtnConfirmarClick - Salva o registro atual (Inserir ou Atualizar)
3721:     *--------------------------------------------------------------------------
3722:     PROCEDURE BtnConfirmarClick()
3723:         LOCAL loc_lResultado, loc_cDgopes
3724:         loc_lResultado = .F.
3725:         loc_cDgopes    = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dgope.Value)
3726: 
3727:         IF EMPTY(loc_cDgopes)
3728:             MsgAviso("Informe o Grupo Operacional.", "")
3729:             RETURN
3730:         ENDIF
3731: 
3732:         THIS.FormParaBO()
3733: 
3734:         IF THIS.this_oBusinessObject.Salvar()
3735:             THIS.this_oBusinessObject.SalvarOperacoes(;
3736:                 THIS.this_oBusinessObject.this_cDgopes, "cursor_4c_Operacoes")
3737:             MsgInfo("Registro salvo com sucesso!", "")
3738:             THIS.this_cModoAtual = "LISTA"
3739:             THIS.CarregarLista()
3740:             THIS.AlternarPagina(1)
3741:         ENDIF
3742:     ENDPROC
3743: 
3744:     *--------------------------------------------------------------------------
3745:     * BtnCancelarClick - Cancela edicao e volta para lista
3746:     *--------------------------------------------------------------------------
3747:     PROCEDURE BtnCancelarClick()
3748:         THIS.this_cModoAtual = "LISTA"
3749:         THIS.AlternarPagina(1)
3750:     ENDPROC
3751: 
3752:     *--------------------------------------------------------------------------
3753:     * BtnMontaListaClick - Lista operacoes do grupo selecionado (equivalente SigLlOpe)
3754:     *--------------------------------------------------------------------------
3755:     PROCEDURE BtnMontaListaClick()
3756:         LOCAL loc_cDgopes, loc_cTexto, loc_cArqTmp, loc_nCount
3757: 
3758:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
3759:                 RECCOUNT("cursor_4c_Dados") = 0
3760:             MsgAviso("Selecione um grupo operacional na lista.", "")
3761:             RETURN
3762:         ENDIF
3763: 
3764:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3765: 
3766:         TRY
3767:             IF THIS.this_oBusinessObject.BuscarOperacoes(loc_cDgopes)
3768:                 loc_nCount = RECCOUNT("cursor_4c_Operacoes")
3769:                 IF loc_nCount = 0
3770:                     MsgInfo("O grupo [" + loc_cDgopes + ;
3771:                         "] n" + CHR(227) + "o possui opera" + CHR(231) + CHR(245) + ;
3772:                         "es cadastradas.", ;
3773:                         "Listagem de Opera" + CHR(231) + CHR(245) + "es")
3774:                 ELSE
3775:                     loc_cTexto = "LISTAGEM DE OPERA" + CHR(199) + CHR(213) + "ES" + CHR(13) + CHR(10) + ;
3776:                         "Grupo Operacional: " + loc_cDgopes + CHR(13) + CHR(10) + ;
3777:                         "Total: " + TRANSFORM(loc_nCount) + " registro(s)" + CHR(13) + CHR(10) + ;
3778:                         REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
3779:                         PADR("Opera" + CHR(231) + CHR(227) + "o Poss" + CHR(237) + "vel", 22) + ;
3780:                         PADR("Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia", 22) + ;
3781:                         CHR(13) + CHR(10) + REPLICATE("-", 60) + CHR(13) + CHR(10)
3782: 
3783:                     SELECT cursor_4c_Operacoes
3784:                     GO TOP
3785:                     SCAN
3786:                         loc_cTexto = loc_cTexto + ;
3787:                             PADR(ALLTRIM(cursor_4c_Operacoes.dopers),  22) + ;
3788:                             PADR(ALLTRIM(cursor_4c_Operacoes.confops), 22) + ;
3789:                             CHR(13) + CHR(10)
3790:                     ENDSCAN
3791: 
3792:                     loc_cArqTmp = ADDBS(SYS(2023)) + "ListaOps_" + loc_cDgopes + "_" + ;
3793:                         SYS(2015) + ".txt"
3794:                     STRTOFILE(loc_cTexto, loc_cArqTmp)
3795: 
3796:                     IF FILE(loc_cArqTmp)
3797:                         RUN /N NOTEPAD.EXE "&loc_cArqTmp"
3798:                     ELSE
3799:                         MsgErro("Falha ao gerar arquivo de listagem.", "Erro")
3800:                     ENDIF
3801:                 ENDIF
3802:             ENDIF
3803:         CATCH TO loc_oErro

*-- Linhas 3809 a 3852:
3809:     *--------------------------------------------------------------------------
3810:     * BtnImpXMLClick - Importa XML de grupo operacional (equivalente SigOpXml modo I)
3811:     *--------------------------------------------------------------------------
3812:     PROCEDURE BtnImpXMLClick()
3813:         LOCAL loc_cArquivo, loc_cXML, loc_cDgopes, loc_nResultado, loc_cSQL
3814:         LOCAL loc_lProsseguir, loc_lJaExiste
3815: 
3816:         loc_cArquivo = GETFILE("XML", "Selecionar XML para importar", "Abrir")
3817:         IF EMPTY(loc_cArquivo) OR !FILE(loc_cArquivo)
3818:             RETURN
3819:         ENDIF
3820: 
3821:         TRY
3822:             loc_lProsseguir = .T.
3823:             loc_cXML        = FILETOSTR(loc_cArquivo)
3824: 
3825:             IF EMPTY(loc_cXML)
3826:                 MsgErro("Arquivo XML vazio ou ileg" + CHR(237) + "vel.", "Erro")
3827:                 loc_lProsseguir = .F.
3828:             ENDIF
3829: 
3830:             IF loc_lProsseguir
3831:                 IF USED("cursor_4c_XMLImp")
3832:                     USE IN cursor_4c_XMLImp
3833:                 ENDIF
3834:                 XMLTOCURSOR(loc_cXML, "cursor_4c_XMLImp")
3835: 
3836:                 IF !USED("cursor_4c_XMLImp") OR RECCOUNT("cursor_4c_XMLImp") = 0
3837:                     MsgErro("XML inv" + CHR(225) + "lido ou vazio.", "Erro")
3838:                     loc_lProsseguir = .F.
3839:                 ENDIF
3840:             ENDIF
3841: 
3842:             IF loc_lProsseguir
3843:                 SELECT cursor_4c_XMLImp
3844:                 GO TOP
3845: 
3846:                 IF TYPE("cursor_4c_XMLImp.dgopes") = "U"
3847:                     MsgErro("XML n" + CHR(227) + "o possui a coluna 'dgopes'.", "Erro")
3848:                     loc_lProsseguir = .F.
3849:                 ENDIF
3850:             ENDIF
3851: 
3852:             IF loc_lProsseguir

*-- Linhas 3908 a 3962:
3908:     *--------------------------------------------------------------------------
3909:     * BtnExpXMLClick - Exporta grupo selecionado em XML (equivalente SigOpXml modo E)
3910:     *--------------------------------------------------------------------------
3911:     PROCEDURE BtnExpXMLClick()
3912:         LOCAL loc_cDgopes, loc_cArquivo, loc_cXML, loc_cSQL, loc_nResultado
3913:         LOCAL loc_lProsseguir
3914: 
3915:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3916:             MsgAviso("Selecione um registro na lista.", "")
3917:             RETURN
3918:         ENDIF
3919: 
3920:         loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
3921:         IF EMPTY(loc_cDgopes)
3922:             MsgAviso("Grupo operacional inv" + CHR(225) + "lido.", "")
3923:             RETURN
3924:         ENDIF
3925: 
3926:         loc_cArquivo = PUTFILE("Salvar como", ;
3927:             "GrupoOper_" + loc_cDgopes + ".xml", "XML")
3928:         IF EMPTY(loc_cArquivo)
3929:             RETURN
3930:         ENDIF
3931: 
3932:         TRY
3933:             loc_lProsseguir = .T.
3934:             loc_cSQL        = "SELECT * FROM SigCdGpe WHERE dgopes = " + ;
3935:                 EscaparSQL(loc_cDgopes)
3936:             loc_nResultado  = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XMLExp")
3937: 
3938:             IF loc_nResultado < 0 OR !USED("cursor_4c_XMLExp") OR ;
3939:                     RECCOUNT("cursor_4c_XMLExp") = 0
3940:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o grupo:" + ;
3941:                     CHR(13) + CapturarErroSQL(), "Erro")
3942:                 loc_lProsseguir = .F.
3943:             ENDIF
3944: 
3945:             IF loc_lProsseguir
3946:                 loc_cXML = ""
3947:                 CURSORTOXML("cursor_4c_XMLExp", "loc_cXML", 1, 512, 0, "1")
3948: 
3949:                 IF EMPTY(loc_cXML)
3950:                     MsgErro("Falha ao gerar XML.", "Erro")
3951:                     loc_lProsseguir = .F.
3952:                 ENDIF
3953:             ENDIF
3954: 
3955:             IF loc_lProsseguir
3956:                 STRTOFILE(loc_cXML, loc_cArquivo)
3957: 
3958:                 IF FILE(loc_cArquivo)
3959:                     MsgInfo("Grupo [" + loc_cDgopes + ;
3960:                         "] exportado para:" + CHR(13) + loc_cArquivo, ;
3961:                         "Exporta" + CHR(231) + CHR(227) + "o")
3962:                 ELSE

*-- Linhas 3976 a 4242:
3976:     *--------------------------------------------------------------------------
3977:     * BtnIconeClick - Abre seletor de arquivo .ico para o grupo
3978:     *--------------------------------------------------------------------------
3979:     PROCEDURE BtnIconeClick()
3980:         LOCAL loc_cArquivo, loc_txt, loc_img
3981: 
3982:         TRY
3983:             loc_cArquivo = GetFile("ico;bmp;jpg;png", "Selecionar " + CHR(205) + "cone", "Selecionar")
3984:             IF !EMPTY(loc_cArquivo)
3985:                 loc_txt = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Carqicones
3986:                 loc_img = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.img_4c_Icone
3987:                 IF VARTYPE(loc_txt) = "O"
3988:                     loc_txt.Value = loc_cArquivo
3989:                 ENDIF
3990:                 IF VARTYPE(loc_img) = "O"
3991:                     loc_img.Picture = loc_cArquivo
3992:                     loc_img.Visible = .T.
3993:                 ENDIF
3994:             ENDIF
3995:         CATCH TO loc_oErro
3996:             MsgErro(loc_oErro.Message, "Erro BtnIconeClick")
3997:         ENDTRY
3998:     ENDPROC
3999: 
4000:     *--------------------------------------------------------------------------
4001:     * FormatarGridLista - Formata visual do grid da lista
4002:     *--------------------------------------------------------------------------
4003:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
4004:         WITH par_oGrid
4005:             .FontName = "Verdana"
4006:             .FontSize = 8
4007:         ENDWITH
4008:     ENDPROC
4009: 
4010:     *--------------------------------------------------------------------------
4011:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
4012:     *--------------------------------------------------------------------------
4013:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4014:         LOCAL loc_nI, loc_oObjeto, loc_nP
4015: 
4016:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4017:             loc_oObjeto = par_oContainer.Controls(loc_nI)
4018: 
4019:             IF VARTYPE(loc_oObjeto) = "O"
4020:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
4021:                     loc_oObjeto.Visible = .T.
4022:                 ENDIF
4023: 
4024:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
4025:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
4026:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
4027:                     ENDFOR
4028:                 ENDIF
4029: 
4030:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
4031:                     THIS.TornarControlesVisiveis(loc_oObjeto)
4032:                 ENDIF
4033:             ENDIF
4034:         ENDFOR
4035:     ENDPROC
4036: 
4037:     *--------------------------------------------------------------------------
4038:     * Destroy - Limpeza ao fechar o formulario
4039:     *--------------------------------------------------------------------------
4040:     PROCEDURE Destroy()
4041:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
4042:             THIS.this_oBusinessObject = .NULL.
4043:         ENDIF
4044: 
4045:         IF USED("cursor_4c_Dados")
4046:             USE IN cursor_4c_Dados
4047:         ENDIF
4048: 
4049:         IF USED("cursor_4c_Operacoes")
4050:             USE IN cursor_4c_Operacoes
4051:         ENDIF
4052: 
4053:         IF USED("cursor_4c_Busca")
4054:             USE IN cursor_4c_Busca
4055:         ENDIF
4056: 
4057:         IF USED("cursor_4c_BuscaSub")
4058:             USE IN cursor_4c_BuscaSub
4059:         ENDIF
4060: 
4061:         IF USED("cursor_4c_BuscaLcl")
4062:             USE IN cursor_4c_BuscaLcl
4063:         ENDIF
4064: 
4065:         IF USED("cursor_4c_BuscaSct")
4066:             USE IN cursor_4c_BuscaSct
4067:         ENDIF
4068: 
4069:         DODEFAULT()
4070:     ENDPROC
4071: 
4072:     *--------------------------------------------------------------------------
4073:     * TxtSubncrsKeyPress - Enter/Tab/F4 abre lookup SigCdOpe
4074:     *--------------------------------------------------------------------------
4075:     PROCEDURE TxtSubncrsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4076:         IF INLIST(par_nKeyCode, 13, 9, 115)
4077:             THIS.AbrirLookupSubncrs()
4078:         ENDIF
4079:     ENDPROC
4080: 
4081:     *--------------------------------------------------------------------------
4082:     * TxtLocalsKeyPress - Enter/Tab/F4 abre lookup SigPrLcl
4083:     *--------------------------------------------------------------------------
4084:     PROCEDURE TxtLocalsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4085:         IF INLIST(par_nKeyCode, 13, 9, 115)
4086:             THIS.AbrirLookupLocals()
4087:         ENDIF
4088:     ENDPROC
4089: 
4090:     *--------------------------------------------------------------------------
4091:     * TxtCodegsKeyPress - Enter/Tab/F4 abre lookup SigCdSct
4092:     *--------------------------------------------------------------------------
4093:     PROCEDURE TxtCodegsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4094:         IF INLIST(par_nKeyCode, 13, 9, 115)
4095:             THIS.AbrirLookupCodsegs()
4096:         ENDIF
4097:     ENDPROC
4098: 
4099:     *--------------------------------------------------------------------------
4100:     * AbrirLookupSubncrs - FormBuscaAuxiliar em SigCdOpe (campo subncrs)
4101:     *--------------------------------------------------------------------------
4102:     PROCEDURE AbrirLookupSubncrs()
4103:         LOCAL loc_oBusca, loc_cValor, loc_oTxt
4104:         loc_cValor = ""
4105:         loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Subncrs
4106: 
4107:         IF VARTYPE(loc_oTxt) = "O"
4108:             loc_cValor = ALLTRIM(loc_oTxt.Value)
4109:         ENDIF
4110: 
4111:         TRY
4112:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4113:                 "SigCdOpe", "cursor_4c_BuscaSub", "Dopes", loc_cValor, ;
4114:                 "Buscar Subn" + CHR(237) + "vel")
4115: 
4116:             IF VARTYPE(loc_oBusca) = "O"
4117:                 IF !loc_oBusca.this_lAchouRegistro
4118:                     loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
4119:                     loc_oBusca.Show()
4120:                 ENDIF
4121: 
4122:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSub")
4123:                     IF VARTYPE(loc_oTxt) = "O"
4124:                         loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaSub.Dopes)
4125:                     ENDIF
4126:                 ENDIF
4127: 
4128:                 loc_oBusca.Release()
4129:             ENDIF
4130:         CATCH TO loc_oErro
4131:             MsgErro(loc_oErro.Message, "Erro AbrirLookupSubncrs")
4132:         ENDTRY
4133: 
4134:         IF USED("cursor_4c_BuscaSub")
4135:             USE IN cursor_4c_BuscaSub
4136:         ENDIF
4137:     ENDPROC
4138: 
4139:     *--------------------------------------------------------------------------
4140:     * AbrirLookupLocals - FormBuscaAuxiliar em SigPrLcl (campo locals)
4141:     *--------------------------------------------------------------------------
4142:     PROCEDURE AbrirLookupLocals()
4143:         LOCAL loc_oBusca, loc_cValor, loc_oTxt
4144:         loc_cValor = ""
4145:         loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Locals
4146: 
4147:         IF VARTYPE(loc_oTxt) = "O"
4148:             loc_cValor = ALLTRIM(loc_oTxt.Value)
4149:         ENDIF
4150: 
4151:         TRY
4152:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4153:                 "SigPrLcl", "cursor_4c_BuscaLcl", "Codigos", loc_cValor, ;
4154:                 "Buscar Localiza" + CHR(231) + CHR(227) + "o", .F., .T., "Tipos = 2")
4155: 
4156:             IF VARTYPE(loc_oBusca) = "O"
4157:                 IF !loc_oBusca.this_lAchouRegistro
4158:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
4159:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4160:                     loc_oBusca.Show()
4161:                 ENDIF
4162: 
4163:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLcl")
4164:                     IF VARTYPE(loc_oTxt) = "O"
4165:                         loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLcl.Codigos)
4166:                     ENDIF
4167:                 ENDIF
4168: 
4169:                 loc_oBusca.Release()
4170:             ENDIF
4171:         CATCH TO loc_oErro
4172:             MsgErro(loc_oErro.Message, "Erro AbrirLookupLocals")
4173:         ENDTRY
4174: 
4175:         IF USED("cursor_4c_BuscaLcl")
4176:             USE IN cursor_4c_BuscaLcl
4177:         ENDIF
4178:     ENDPROC
4179: 
4180:     *--------------------------------------------------------------------------
4181:     * AbrirLookupCodsegs - FormBuscaAuxiliar em SigCdSct (campo codsegs)
4182:     *--------------------------------------------------------------------------
4183:     PROCEDURE AbrirLookupCodsegs()
4184:         LOCAL loc_oBusca, loc_cValor, loc_oTxt
4185:         loc_cValor = ""
4186:         loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Codsegs
4187: 
4188:         IF VARTYPE(loc_oTxt) = "O"
4189:             loc_cValor = ALLTRIM(loc_oTxt.Value)
4190:         ENDIF
4191: 
4192:         TRY
4193:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4194:                 "SigCdSct", "cursor_4c_BuscaSct", "Codigos", loc_cValor, ;
4195:                 "Buscar Segmento")
4196: 
4197:             IF VARTYPE(loc_oBusca) = "O"
4198:                 IF !loc_oBusca.this_lAchouRegistro
4199:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4200:                     loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
4201:                     loc_oBusca.Show()
4202:                 ENDIF
4203: 
4204:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSct")
4205:                     IF VARTYPE(loc_oTxt) = "O"
4206:                         loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaSct.Codigos)
4207:                     ENDIF
4208:                 ENDIF
4209: 
4210:                 loc_oBusca.Release()
4211:             ENDIF
4212:         CATCH TO loc_oErro
4213:             MsgErro(loc_oErro.Message, "Erro AbrirLookupCodsegs")
4214:         ENDTRY
4215: 
4216:         IF USED("cursor_4c_BuscaSct")
4217:             USE IN cursor_4c_BuscaSct
4218:         ENDIF
4219:     ENDPROC
4220: 
4221:     *--------------------------------------------------------------------------
4222:     * TxtSubncrsDblClick - DblClick abre lookup SigCdOpe
4223:     *--------------------------------------------------------------------------
4224:     PROCEDURE TxtSubncrsDblClick()
4225:         THIS.AbrirLookupSubncrs()
4226:     ENDPROC
4227: 
4228:     *--------------------------------------------------------------------------
4229:     * TxtLocalsDblClick - DblClick abre lookup SigPrLcl
4230:     *--------------------------------------------------------------------------
4231:     PROCEDURE TxtLocalsDblClick()
4232:         THIS.AbrirLookupLocals()
4233:     ENDPROC
4234: 
4235:     *--------------------------------------------------------------------------
4236:     * TxtCodegsDblClick - DblClick abre lookup SigCdSct
4237:     *--------------------------------------------------------------------------
4238:     PROCEDURE TxtCodegsDblClick()
4239:         THIS.AbrirLookupCodsegs()
4240:     ENDPROC
4241: 
4242: ENDDEFINE


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

