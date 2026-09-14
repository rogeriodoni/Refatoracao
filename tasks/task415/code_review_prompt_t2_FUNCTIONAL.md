# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_COPIARACESSO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFct.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1983 linhas total):

*-- Linhas 23 a 166:
23:     this_nTipo           = 0
24: 
25:     *--------------------------------------------------------------------------
26:     PROCEDURE Init()
27:     *--------------------------------------------------------------------------
28:     LPARAMETERS pcTipo
29:         LOCAL loc_lResultado
30:         loc_lResultado = .F.
31:         TRY
32:             THIS.this_nTipo = IIF(TYPE("pcTipo") <> "C", 0, IIF(pcTipo == "C", 1, 2))
33:             DO CASE
34:             CASE THIS.this_nTipo = 1
35:                 THIS.Caption = "Cadastro de Perfil de Contas"
36:             CASE THIS.this_nTipo = 2
37:                 THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o"
38:             OTHERWISE
39:                 THIS.Caption = "Cadastro de Ficha T" + CHR(233) + "cnica"
40:             ENDCASE
41:             loc_lResultado = DODEFAULT()
42:         CATCH TO loc_oErro
43:             MsgErro("Erro ao inicializar FormFct:" + CHR(13) + loc_oErro.Message, "Erro")
44:         ENDTRY
45:         RETURN loc_lResultado
46:     ENDPROC
47: 
48:     *--------------------------------------------------------------------------
49:     PROTECTED PROCEDURE InicializarForm()
50:     *--------------------------------------------------------------------------
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53:         TRY
54:             THIS.this_oBusinessObject = CREATEOBJECT("FctBO")
55:             IF VARTYPE(THIS.this_oBusinessObject) <> "O" OR ISNULL(THIS.this_oBusinessObject)
56:                 MsgErro("Erro ao criar FctBO.", "Erro")
57:             ELSE
58:                 THIS.this_oBusinessObject.this_nTipo = THIS.this_nTipo
59:                 THIS.this_oBusinessObject.CriarCursores()
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
62:                 THIS.CarregarLista()
63:                 loc_lResultado = .T.
64:             ENDIF
65:         CATCH TO loc_oErro
66:             MsgErro("Erro em InicializarForm (FormFct):" + CHR(13) + loc_oErro.Message, "Erro")
67:         ENDTRY
68:         RETURN loc_lResultado
69:     ENDPROC
70: 
71:     *--------------------------------------------------------------------------
72:     PROCEDURE Destroy()
73:     *--------------------------------------------------------------------------
74:         LOCAL loc_aCursores, loc_n
75:         TRY
76:             DIMENSION loc_aCursores(5)
77:             loc_aCursores(1) = "cursor_4c_BuscaCCars"
78:             loc_aCursores(2) = "cursor_4c_BuscaCTits"
79:             loc_aCursores(3) = "cursor_4c_BuscaGrp"
80:             loc_aCursores(4) = "cursor_4c_CopiaFtc"
81:             loc_aCursores(5) = "cursor_4c_BuscaSGrp"
82:             FOR loc_n = 1 TO 5
83:                 IF USED(loc_aCursores(loc_n))
84:                     USE IN (loc_aCursores(loc_n))
85:                 ENDIF
86:             ENDFOR
87:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
88:                 THIS.this_oBusinessObject = .NULL.
89:             ENDIF
90:         CATCH TO loc_oErro
91:             MsgErro("Erro ao destruir FormFct:" + CHR(13) + loc_oErro.Message, "Erro")
92:         ENDTRY
93:         DODEFAULT()
94:     ENDPROC
95: 
96:     *--------------------------------------------------------------------------
97:     PROTECTED PROCEDURE ConfigurarPageFrame()
98:     *--------------------------------------------------------------------------
99:         LOCAL loc_lResultado
100:         loc_lResultado = .F.
101:         TRY
102:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
103:             WITH THIS.pgf_4c_Paginas
104:                 .Top       = -29
105:                 .Left      = 0
106:                 .Width     = THIS.Width
107:                 .Height    = THIS.Height + 29
108:                 .Tabs      = .F.
109:                 .PageCount = 2
110:                 .Page1.Caption = "Lista"
111:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:                 .Page2.Caption = "Dados"
113:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:                 .Visible   = .T.
115:             ENDWITH
116:             THIS.ConfigurarPaginaLista()
117:             THIS.ConfigurarPaginaDados()
118:             loc_lResultado = .T.
119:         CATCH TO loc_oErro
120:             MsgErro("Erro em ConfigurarPageFrame:" + CHR(13) + loc_oErro.Message, "Erro")
121:         ENDTRY
122:         RETURN loc_lResultado
123:     ENDPROC
124: 
125:     *--------------------------------------------------------------------------
126:     PROTECTED PROCEDURE ConfigurarPaginaLista()
127:     *--------------------------------------------------------------------------
128:         LOCAL loc_lResultado, loc_oPag
129:         loc_lResultado = .F.
130:         TRY
131:             loc_oPag = THIS.pgf_4c_Paginas.Page1
132: 
133:             loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
134:             WITH loc_oPag.cnt_4c_Cabecalho
135:                 .Top       = 30
136:                 .Left      = 0
137:                 .Width     = THIS.Width
138:                 .Height    = 30
139:                 .BackStyle = 1
140:                 .BackColor = RGB(64, 64, 64)
141:                 .Visible   = .T.
142:                 .AddObject("lbl_4c_Titulo", "Label")
143:                 WITH .lbl_4c_Titulo
144:                     .Top       = 0
145:                     .Left      = 0
146:                     .Width     = THIS.Width
147:                     .Height    = 30
148:                     .AutoSize  = .F.
149:                     .BackStyle = 0
150:                     .ForeColor = RGB(255, 255, 255)
151:                     .FontSize  = 12
152:                     .FontBold  = .T.
153:                     DO CASE
154:                     CASE THIS.this_nTipo = 1
155:                         .Caption = "  Perfis de Contas"
156:                     CASE THIS.this_nTipo = 2
157:                         .Caption = "  Movimenta" + CHR(231) + CHR(227) + "o"
158:                     OTHERWISE
159:                         .Caption = "  Fichas T" + CHR(233) + "cnicas de Produtos"
160:                     ENDCASE
161:                     .Visible   = .T.
162:                 ENDWITH
163:             ENDWITH
164: 
165:             loc_oPag.AddObject("cnt_4c_Botoes", "Container")
166:             WITH loc_oPag.cnt_4c_Botoes

*-- Linhas 397 a 457:
397:             loc_oPag.grd_4c_Lista.SetAll("DynamicBackColor", ;
398:                 "IIF(EMPTY(crDados.TemDados), RGB(255,255,255), RGB(255,255,187))", "Column")
399: 
400:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
401:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
402:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
403:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
404:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
405:             BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
406:             BINDEVENT(loc_oPag.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
407: 
408:             THIS.TornarControlesVisiveis(loc_oPag)
409:             loc_lResultado = .T.
410:         CATCH TO loc_oErro
411:             MsgErro("Erro em ConfigurarPaginaLista:" + CHR(13) + loc_oErro.Message, "Erro")
412:         ENDTRY
413:         RETURN loc_lResultado
414:     ENDPROC
415: 
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE ConfigurarPaginaDados()
418:     *--------------------------------------------------------------------------
419:         LOCAL loc_lResultado, loc_oPag
420:         loc_lResultado = .F.
421:         TRY
422:             loc_oPag = THIS.pgf_4c_Paginas.Page2
423: 
424:             loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
425:             WITH loc_oPag.cnt_4c_BotoesAcao
426:                 .Top       = 38
427:                 .Left      = 820
428:                 .Width     = 160
429:                 .Height    = 85
430:                 .BackStyle = 1
431:                 .BackColor = RGB(255, 255, 255)
432:                 .Visible   = .T.
433:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
434:                 WITH .cmd_4c_Confirmar
435:                     .Top             = 5
436:                     .Left            = 5
437:                     .Width           = 70
438:                     .Height          = 75
439:                     .Caption         = "Confirmar"
440:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
441:                     .PicturePosition = 13
442:                     .FontName        = "Tahoma"
443:                     .FontBold        = .T.
444:                     .FontItalic      = .T.
445:                     .FontSize        = 8
446:                     .ForeColor       = RGB(90, 90, 90)
447:                     .BackColor       = RGB(255, 255, 255)
448:                     .SpecialEffect   = 0
449:                     .MousePointer    = 15
450:                     .WordWrap        = .T.
451:                     .AutoSize        = .F.
452:                     .Visible         = .T.
453:                 ENDWITH
454:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
455:                 WITH .cmd_4c_Cancelar
456:                     .Top             = 5
457:                     .Left            = 80

*-- Linhas 491 a 546:
491:             THIS.ConfigurarPgFicha()
492:             THIS.ConfigurarPgCompl()
493: 
494:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
495:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
496: 
497:             THIS.TornarControlesVisiveis(loc_oPag)
498:             loc_lResultado = .T.
499:         CATCH TO loc_oErro
500:             MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message, "Erro")
501:         ENDTRY
502:         RETURN loc_lResultado
503:     ENDPROC
504: 
505:     *--------------------------------------------------------------------------
506:     PROTECTED PROCEDURE ConfigurarPgFicha()
507:     *--------------------------------------------------------------------------
508:         LOCAL loc_lResultado, loc_oPg
509:         loc_lResultado = .F.
510:         TRY
511:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
512: 
513:             loc_oPg.AddObject("lbl_4c_LabelGrupo", "Label")
514:             WITH loc_oPg.lbl_4c_LabelGrupo
515:                 .Top      = 20
516:                 .Left     = 55
517:                 .Width    = 40
518:                 .Height   = 18
519:                 .AutoSize = .F.
520:                 .Caption  = "Grupo :"
521:                 .Visible  = .T.
522:             ENDWITH
523: 
524:             loc_oPg.AddObject("txt_4c_CGrus", "TextBox")
525:             WITH loc_oPg.txt_4c_CGrus
526:                 .Top           = 17
527:                 .Left          = 98
528:                 .Width         = 80
529:                 .Height        = 20
530:                 .Enabled       = .F.
531:                 .ControlSource = "crFichaCab.CGrus"
532:                 .Visible       = .T.
533:             ENDWITH
534: 
535:             loc_oPg.AddObject("txt_4c_DGrus", "TextBox")
536:             WITH loc_oPg.txt_4c_DGrus
537:                 .Top           = 17
538:                 .Left          = 180
539:                 .Width         = 290
540:                 .Height        = 20
541:                 .Enabled       = .F.
542:                 .ControlSource = "crFichaCab.DGrus"
543:                 .Visible       = .T.
544:             ENDWITH
545: 
546:             loc_oPg.AddObject("lbl_4c_LabelSGrus", "Label")

*-- Linhas 587 a 698:
587:                 .Visible  = (THIS.this_nTipo = 0)
588:             ENDWITH
589: 
590:             loc_oPg.AddObject("opt_4c_NChkDims", "OptionGroup")
591:             WITH loc_oPg.opt_4c_NChkDims
592:                 .Top           = 10
593:                 .Left          = 729
594:                 .Width         = 180
595:                 .Height        = 16
596:                 .ButtonCount   = 2
597:                 .Value         = 1
598:                 .ControlSource = "crFichaCab.nChkDims"
599:                 .Visible       = (THIS.this_nTipo = 0)
600:                 WITH .Buttons(1)
601:                     .Caption   = "Sim"
602:                     .Width     = 50
603:                     .BackStyle = 0
604:                 ENDWITH
605:                 WITH .Buttons(2)
606:                     .Caption   = "N" + CHR(227) + "o"
607:                     .Left      = 55
608:                     .Width     = 60
609:                     .BackStyle = 0
610:                 ENDWITH
611:             ENDWITH
612: 
613:             loc_oPg.AddObject("lbl_4c_LabelChkTems", "Label")
614:             WITH loc_oPg.lbl_4c_LabelChkTems
615:                 .Top      = 29
616:                 .Left     = 620
617:                 .Width    = 105
618:                 .Height   = 18
619:                 .AutoSize = .F.
620:                 .Caption  = "Tempos :"
621:                 .Visible  = (THIS.this_nTipo = 0)
622:             ENDWITH
623: 
624:             loc_oPg.AddObject("opt_4c_NChkTems", "OptionGroup")
625:             WITH loc_oPg.opt_4c_NChkTems
626:                 .Top           = 29
627:                 .Left          = 729
628:                 .Width         = 180
629:                 .Height        = 16
630:                 .ButtonCount   = 2
631:                 .Value         = 1
632:                 .ControlSource = "crFichaCab.nChkTems"
633:                 .Visible       = (THIS.this_nTipo = 0)
634:                 WITH .Buttons(1)
635:                     .Caption   = "Sim"
636:                     .Width     = 50
637:                     .BackStyle = 0
638:                 ENDWITH
639:                 WITH .Buttons(2)
640:                     .Caption   = "N" + CHR(227) + "o"
641:                     .Left      = 55
642:                     .Width     = 60
643:                     .BackStyle = 0
644:                 ENDWITH
645:             ENDWITH
646: 
647:             loc_oPg.AddObject("lbl_4c_LabelChkPess", "Label")
648:             WITH loc_oPg.lbl_4c_LabelChkPess
649:                 .Top      = 49
650:                 .Left     = 620
651:                 .Width    = 105
652:                 .Height   = 18
653:                 .AutoSize = .F.
654:                 .Caption  = "Pessoas :"
655:                 .Visible  = (THIS.this_nTipo = 0)
656:             ENDWITH
657: 
658:             loc_oPg.AddObject("opt_4c_NChkPess", "OptionGroup")
659:             WITH loc_oPg.opt_4c_NChkPess
660:                 .Top           = 49
661:                 .Left          = 729
662:                 .Width         = 180
663:                 .Height        = 16
664:                 .ButtonCount   = 2
665:                 .Value         = 1
666:                 .ControlSource = "crFichaCab.nChkPess"
667:                 .Visible       = (THIS.this_nTipo = 0)
668:                 WITH .Buttons(1)
669:                     .Caption   = "Sim"
670:                     .Width     = 50
671:                     .BackStyle = 0
672:                 ENDWITH
673:                 WITH .Buttons(2)
674:                     .Caption   = "N" + CHR(227) + "o"
675:                     .Left      = 55
676:                     .Width     = 60
677:                     .BackStyle = 0
678:                 ENDWITH
679:             ENDWITH
680: 
681:             loc_oPg.AddObject("grd_4c_Fichas", "Grid")
682:             loc_oPg.grd_4c_Fichas.ColumnCount = 9
683:             WITH loc_oPg.grd_4c_Fichas
684:                 .Top          = 75
685:                 .Left         = 12
686:                 .Width        = 933
687:                 .Height       = 309
688:                 .HeaderHeight = 18
689:                 .RecordSource = "crFichaTec"
690:                 .ReadOnly     = .F.
691:                 .GridLines    = 1
692:                 .DeleteMark   = .F.
693:                 .RecordMark   = .F.
694:                 .Visible      = .T.
695:                 WITH .Column1
696:                     .Width           = 200
697:                     .ControlSource   = "crFichaTec.CCars"
698:                     .Header1.Caption = "Grupo Caracter" + CHR(237) + "sticas"

*-- Linhas 730 a 773:
730:                     .Header1.Caption = "Digita" + CHR(231) + CHR(227) + "o"
731:                     .Sparse         = .F.
732:                     .CurrentControl = "opt_4c_NChkCxas"
733:                     .AddObject("opt_4c_NChkCxas", "OptionGroup")
734:                     WITH .opt_4c_NChkCxas
735:                         .ButtonCount = 3
736:                         .Value       = 1
737:                         .Height      = 16
738:                         .Width       = 241
739:                         WITH .Buttons(1)
740:                             .Caption   = "Maiusculo"
741:                             .Width     = 74
742:                             .BackStyle = 0
743:                         ENDWITH
744:                         WITH .Buttons(2)
745:                             .Caption   = "Minusculo"
746:                             .Left      = 80
747:                             .Width     = 74
748:                             .BackStyle = 0
749:                         ENDWITH
750:                         WITH .Buttons(3)
751:                             .Caption   = "Livre"
752:                             .Left      = 160
753:                             .BackStyle = 0
754:                         ENDWITH
755:                     ENDWITH
756:                 ENDWITH
757:                 WITH .Column8
758:                     .Width           = 25
759:                     .ControlSource   = "crFichaTec.cSelecaos"
760:                     .Header1.Caption = "S"
761:                 ENDWITH
762:                 WITH .Column9
763:                     .Width           = 25
764:                     .ControlSource   = "crFichaTec.cTpDados"
765:                     .Header1.Caption = "T"
766:                 ENDWITH
767:             ENDWITH
768: 
769:             loc_oPg.AddObject("cmd_4c_ApagarLinha", "CommandButton")
770:             WITH loc_oPg.cmd_4c_ApagarLinha
771:                 .Top     = 235
772:                 .Left    = 949
773:                 .Width   = 40

*-- Linhas 888 a 971:
888:                 ENDWITH
889:             ENDWITH
890: 
891:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column1.Text1, "Valid",    THIS, "ValidCCarsGrid")
892:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column2.Text1, "Valid",    THIS, "ValidCTitsGrid")
893:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "KeyPress", THIS, "KeyPressCTpDados")
894:             BINDEVENT(loc_oPg.cmd_4c_ApagarLinha,  "Click", THIS, "BtnApagarLinhaClick")
895:             BINDEVENT(loc_oPg.cmd_4c_Respostas,    "Click", THIS, "BtnRespostasClick")
896:             BINDEVENT(loc_oPg.cmd_4c_CopiaFicha,   "Click", THIS, "BtnCopiaFichaClick")
897:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus,      "KeyPress", THIS, "ValidCpyCGrus")
898:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_ConfirmarCopia, "Click", THIS, "BtnConfirmarCopiaClick")
899:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_CancelarCopia,  "Click", THIS, "BtnCancelarCopiaClick")
900:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus,      "KeyPress", THIS, "ValidCpySGrus")
901:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column8.Text1, "Valid", THIS, "ValidCSelecaos")
902:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "Valid", THIS, "ValidCTpDados")
903: 
904:             THIS.TornarControlesVisiveis(loc_oPg)
905:             loc_lResultado = .T.
906:         CATCH TO loc_oErro
907:             MsgErro("Erro em ConfigurarPgFicha:" + CHR(13) + loc_oErro.Message, "Erro")
908:         ENDTRY
909:         RETURN loc_lResultado
910:     ENDPROC
911: 
912:     *--------------------------------------------------------------------------
913:     PROTECTED PROCEDURE ConfigurarPgCompl()
914:     *--------------------------------------------------------------------------
915:         LOCAL loc_lResultado, loc_oPg
916:         loc_lResultado = .F.
917:         TRY
918:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
919: 
920:             loc_oPg.AddObject("lbl_4c_LabelImagem", "Label")
921:             WITH loc_oPg.lbl_4c_LabelImagem
922:                 .Top      = 63
923:                 .Left     = 328
924:                 .Width    = 200
925:                 .Height   = 18
926:                 .AutoSize = .F.
927:                 .Caption  = "Imagem da Impress" + CHR(227) + "o :"
928:                 .Visible  = (THIS.this_nTipo = 0)
929:             ENDWITH
930: 
931:             loc_oPg.AddObject("opt_4c_NChkImps", "OptionGroup")
932:             WITH loc_oPg.opt_4c_NChkImps
933:                 .Top           = 58
934:                 .Left          = 442
935:                 .Width         = 165
936:                 .Height        = 16
937:                 .ButtonCount   = 2
938:                 .Value         = 1
939:                 .ControlSource = "crFichaCab.nChkImps"
940:                 .Visible       = (THIS.this_nTipo = 0)
941:                 WITH .Buttons(1)
942:                     .Caption   = "Produtos"
943:                     .Width     = 70
944:                     .BackStyle = 0
945:                 ENDWITH
946:                 WITH .Buttons(2)
947:                     .Caption   = "Ficha T" + CHR(233) + "cnica"
948:                     .Left      = 75
949:                     .Width     = 90
950:                     .BackStyle = 0
951:                 ENDWITH
952:             ENDWITH
953: 
954:             loc_oPg.AddObject("chk_4c_NFixFigs", "CheckBox")
955:             WITH loc_oPg.chk_4c_NFixFigs
956:                 .Top           = 50
957:                 .Left          = 617
958:                 .Width         = 40
959:                 .Height        = 40
960:                 .Style         = 1
961:                 .Caption       = ""
962:                 .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
963:                 .ControlSource = "crFichaCab.nFixFigs"
964:                 .Themes        = .T.
965:                 .Visible       = (THIS.this_nTipo = 0)
966:             ENDWITH
967: 
968:             loc_oPg.AddObject("img_4c_FigTec", "Image")
969:             WITH loc_oPg.img_4c_FigTec
970:                 .Top     = 94
971:                 .Left    = 301

*-- Linhas 999 a 1115:
999:                 .Visible = .T.
1000:             ENDWITH
1001: 
1002:             BINDEVENT(loc_oPg.cmd_4c_Figura,      "Click", THIS, "BtnFiguraClick")
1003:             BINDEVENT(loc_oPg.cmd_4c_VoltarFicha, "Click", THIS, "BtnVoltarFichaClick")
1004: 
1005:             THIS.TornarControlesVisiveis(loc_oPg)
1006:             loc_lResultado = .T.
1007:         CATCH TO loc_oErro
1008:             MsgErro("Erro em ConfigurarPgCompl:" + CHR(13) + loc_oErro.Message, "Erro")
1009:         ENDTRY
1010:         RETURN loc_lResultado
1011:     ENDPROC
1012: 
1013:     *--------------------------------------------------------------------------
1014:     PROCEDURE CarregarLista()
1015:     *--------------------------------------------------------------------------
1016:         LOCAL loc_lResultado
1017:         loc_lResultado = .F.
1018:         TRY
1019:             THIS.this_oBusinessObject.Buscar("")
1020:             IF USED("crDados")
1021:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1022:             ENDIF
1023:             loc_lResultado = .T.
1024:         CATCH TO loc_oErro
1025:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
1026:         ENDTRY
1027:         RETURN loc_lResultado
1028:     ENDPROC
1029: 
1030:     *--------------------------------------------------------------------------
1031:     PROTECTED PROCEDURE IrParaLista()
1032:     *--------------------------------------------------------------------------
1033:         THIS.this_cModoAtual = "LISTA"
1034:         THIS.pgf_4c_Paginas.Visible = .T.
1035:         THIS.pgf_4c_Paginas.ActivePage = 1
1036:         IF USED("crDados")
1037:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1038:         ENDIF
1039:     ENDPROC
1040: 
1041:     *--------------------------------------------------------------------------
1042:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1043:     *--------------------------------------------------------------------------
1044:         LOCAL loc_lResultado
1045:         loc_lResultado = .F.
1046:         TRY
1047:             IF par_nPagina = 1
1048:                 THIS.IrParaLista()
1049:                 loc_lResultado = .T.
1050:             ELSE
1051:                 IF par_nPagina = 2
1052:                 THIS.pgf_4c_Paginas.ActivePage = 2
1053:                 loc_lResultado = .T.
1054:                 ENDIF
1055:             ENDIF
1056:         CATCH TO loc_oErro
1057:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
1058:         ENDTRY
1059:         RETURN loc_lResultado
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     PROTECTED PROCEDURE CarregarDados()
1064:     *--------------------------------------------------------------------------
1065:     LPARAMETERS par_cModo
1066:         LOCAL loc_lResultado, loc_cCGrus, loc_cSGrus, loc_cDGrus, loc_cDSGru
1067:         LOCAL loc_lReadOnly, loc_oPg, loc_oPg2, loc_cArqTemp, loc_cExt
1068:         loc_lResultado = .F.
1069:         TRY
1070:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1071:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1072:             ELSE
1073:                 SELECT crDados
1074:                 IF EOF()
1075:                     MsgAviso("Selecione um registro na lista.", "Aviso")
1076:                 ELSE
1077:                     loc_cCGrus = ALLTRIM(crDados.CGrus)
1078:                     loc_cSGrus = ALLTRIM(crDados.SGrus)
1079:                     loc_cDGrus = ALLTRIM(crDados.DGrus)
1080:                     loc_cDSGru = ALLTRIM(crDados.DSGru)
1081: 
1082:             THIS.this_cModoAtual = par_cModo
1083:             THIS.this_oBusinessObject.CarregarFicha(loc_cCGrus, loc_cSGrus, ;
1084:                 loc_cDGrus, loc_cDSGru, par_cModo)
1085: 
1086:             IF par_cModo = "ALTERAR"
1087:                 THIS.this_oBusinessObject.CarregarFiltroGrupos()
1088:             ENDIF
1089: 
1090:             loc_lReadOnly = (par_cModo = "VISUALIZAR" OR par_cModo = "EXCLUIR")
1091:             THIS.HabilitarCampos(!loc_lReadOnly)
1092:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1093:             loc_oPg.grd_4c_Fichas.ReadOnly     = loc_lReadOnly
1094:             loc_oPg.cmd_4c_ApagarLinha.Visible  = (par_cModo = "ALTERAR")
1095:             loc_oPg.cmd_4c_CopiaFicha.Visible   = (par_cModo = "ALTERAR")
1096:             loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1097: 
1098:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1099:             loc_oPg2.cmd_4c_Figura.Visible = (par_cModo = "ALTERAR")
1100: 
1101:             IF USED("crFichaCab") AND !EOF("crFichaCab")
1102:                 IF !EMPTY(crFichaCab.mFicTecs)
1103:                     loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + ".jpg"
1104:                     STRTOFILE(crFichaCab.mFicTecs, loc_cArqTemp)
1105:                     IF FILE(loc_cArqTemp)
1106:                         loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
1107:                         loc_oPg2.img_4c_FigTec.Visible = .T.
1108:                     ELSE
1109:                         loc_oPg2.img_4c_FigTec.Visible = .F.
1110:                     ENDIF
1111:                 ELSE
1112:                     loc_oPg2.img_4c_FigTec.Picture = ""
1113:                     loc_oPg2.img_4c_FigTec.Visible = .F.
1114:                 ENDIF
1115:             ENDIF

*-- Linhas 1127 a 1983:
1127:     ENDPROC
1128: 
1129:     *--------------------------------------------------------------------------
1130:     PROCEDURE BtnIncluirClick()
1131:     *--------------------------------------------------------------------------
1132:         LOCAL loc_lResultado
1133:         loc_lResultado = .F.
1134:         TRY
1135:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1136:                 MsgAviso("Selecione um grupo na lista.", "Aviso")
1137:             ELSE
1138:                 SELECT crDados
1139:                 IF EOF()
1140:                     MsgAviso("Selecione um grupo na lista.", "Aviso")
1141:                 ELSE
1142:                     IF !EMPTY(ALLTRIM(crDados.TemDados))
1143:                     MsgAviso("Este grupo j" + CHR(225) + " possui ficha t" + CHR(233) + ;
1144:                         "cnica. Use Alterar para modificar.", "Aviso")
1145:                 ELSE
1146:                     loc_lResultado = THIS.CarregarDados("ALTERAR")
1147:                     ENDIF
1148:                 ENDIF
1149:             ENDIF
1150:         CATCH TO loc_oErro
1151:             MsgErro("Erro ao incluir ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1152:         ENDTRY
1153:         RETURN loc_lResultado
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     PROCEDURE BtnVisualizarClick()
1158:     *--------------------------------------------------------------------------
1159:         THIS.CarregarDados("VISUALIZAR")
1160:     ENDPROC
1161: 
1162:     *--------------------------------------------------------------------------
1163:     PROCEDURE BtnAlterarClick()
1164:     *--------------------------------------------------------------------------
1165:         THIS.CarregarDados("ALTERAR")
1166:     ENDPROC
1167: 
1168:     *--------------------------------------------------------------------------
1169:     PROCEDURE BtnExcluirClick()
1170:     *--------------------------------------------------------------------------
1171:         THIS.CarregarDados("EXCLUIR")
1172:     ENDPROC
1173: 
1174:     *--------------------------------------------------------------------------
1175:     PROCEDURE BtnBuscarClick()
1176:     *--------------------------------------------------------------------------
1177:         LOCAL loc_lResultado, loc_cBusca
1178:         loc_lResultado = .F.
1179:         TRY
1180:             loc_cBusca = INPUTBOX("Descri" + CHR(231) + CHR(227) + "o:", "Buscar", "")
1181:             THIS.this_oBusinessObject.Buscar(loc_cBusca)
1182:             IF USED("crDados")
1183:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1184:             ENDIF
1185:             loc_lResultado = .T.
1186:         CATCH TO loc_oErro
1187:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
1188:         ENDTRY
1189:         RETURN loc_lResultado
1190:     ENDPROC
1191: 
1192:     *--------------------------------------------------------------------------
1193:     PROCEDURE BtnEncerrarClick()
1194:     *--------------------------------------------------------------------------
1195:         THIS.Release()
1196:     ENDPROC
1197: 
1198:     *--------------------------------------------------------------------------
1199:     PROCEDURE BtnConfirmarClick()
1200:     *--------------------------------------------------------------------------
1201:         LOCAL loc_lResultado
1202:         loc_lResultado = .F.
1203:         TRY
1204:             DO CASE
1205:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1206:                 THIS.IrParaLista()
1207:                 loc_lResultado = .T.
1208: 
1209:             CASE THIS.this_cModoAtual = "ALTERAR"
1210:                 IF THIS.this_oBusinessObject.ValidarFichaTec()
1211:                     IF THIS.this_oBusinessObject.AtualizarGrupoFicha("ALTERAR")
1212:                         THIS.CarregarLista()
1213:                         THIS.IrParaLista()
1214:                         loc_lResultado = .T.
1215:                     ENDIF
1216:                 ENDIF
1217: 
1218:             CASE THIS.this_cModoAtual = "EXCLUIR"
1219:                 IF THIS.this_oBusinessObject.VerificarExcluirFicha()
1220:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da ficha t" + ;
1221:                             CHR(233) + "cnica?", "Confirmar")
1222:                         IF THIS.this_oBusinessObject.AtualizarGrupoFicha("EXCLUIR")
1223:                             THIS.CarregarLista()
1224:                             THIS.IrParaLista()
1225:                             loc_lResultado = .T.
1226:                         ENDIF
1227:                     ENDIF
1228:                 ENDIF
1229:             ENDCASE
1230:         CATCH TO loc_oErro
1231:             MsgErro("Erro ao confirmar:" + CHR(13) + loc_oErro.Message, "Erro")
1232:         ENDTRY
1233:         RETURN loc_lResultado
1234:     ENDPROC
1235: 
1236:     *--------------------------------------------------------------------------
1237:     PROCEDURE BtnCancelarClick()
1238:     *--------------------------------------------------------------------------
1239:         THIS.IrParaLista()
1240:     ENDPROC
1241: 
1242:     *--------------------------------------------------------------------------
1243:     PROCEDURE BtnApagarLinhaClick()
1244:     *--------------------------------------------------------------------------
1245:         LOCAL loc_lResultado
1246:         loc_lResultado = .F.
1247:         TRY
1248:             IF USED("crFichaTec")
1249:                 SELECT crFichaTec
1250:                 IF !EOF() AND RECCOUNT() > 0
1251:                     IF MsgConfirma("Apagar esta linha da ficha t" + CHR(233) + "cnica?", "Confirmar")
1252:                         DELETE
1253:                         PACK
1254:                         SELECT crFichaTec
1255:                         GO TOP
1256:                         IF EOF()
1257:                             THIS.this_oBusinessObject.AdicionarLinhaFicha()
1258:                             SELECT crFichaTec
1259:                             GO TOP
1260:                         ENDIF
1261:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1262:                         loc_lResultado = .T.
1263:                     ENDIF
1264:                 ENDIF
1265:             ENDIF
1266:         CATCH TO loc_oErro
1267:             MsgErro("Erro ao apagar linha:" + CHR(13) + loc_oErro.Message, "Erro")
1268:         ENDTRY
1269:         RETURN loc_lResultado
1270:     ENDPROC
1271: 
1272:     *--------------------------------------------------------------------------
1273:     PROCEDURE BtnRespostasClick()
1274:     *--------------------------------------------------------------------------
1275:         LOCAL loc_lResultado, loc_cFormFte, loc_cCCars, loc_cCTits, loc_cCGrus, loc_cSGrus
1276:         loc_lResultado = .F.
1277:         TRY
1278:             loc_cFormFte = gc_4c_CaminhoForms + "cadastros\FormFte.prg"
1279:             IF !FILE(loc_cFormFte)
1280:                 MsgAviso("Formul" + CHR(225) + "rio de respostas n" + CHR(227) + ;
1281:                     "o dispon" + CHR(237) + "vel.", "Aviso")
1282:             ELSE
1283:                 IF USED("crFichaTec")
1284:                     SELECT crFichaTec
1285:                     IF !EOF()
1286:                         loc_cCCars = ALLTRIM(crFichaTec.CCars)
1287:                         loc_cCTits = ALLTRIM(crFichaTec.CTits)
1288:                         IF EMPTY(loc_cCCars)
1289:                             MsgAviso("Selecione uma caracter" + CHR(237) + "stica na grade.", "Aviso")
1290:                         ELSE
1291:                             SELECT crFichaCab
1292:                             loc_cCGrus = ALLTRIM(crFichaCab.CGrus)
1293:                             loc_cSGrus = ALLTRIM(crFichaCab.SGrus)
1294:                             DO FORM (gc_4c_CaminhoForms + "cadastros\FormFte") ;
1295:                                 WITH loc_cCGrus, loc_cSGrus, loc_cCCars, loc_cCTits
1296:                             loc_lResultado = .T.
1297:                         ENDIF
1298:                     ENDIF
1299:                 ENDIF
1300:             ENDIF
1301:         CATCH TO loc_oErro
1302:             MsgErro("Erro ao abrir respostas:" + CHR(13) + loc_oErro.Message, "Erro")
1303:         ENDTRY
1304:         RETURN loc_lResultado
1305:     ENDPROC
1306: 
1307:     *--------------------------------------------------------------------------
1308:     PROCEDURE BtnCopiaFichaClick()
1309:     *--------------------------------------------------------------------------
1310:         LOCAL loc_lResultado, loc_oPg
1311:         loc_lResultado = .F.
1312:         TRY
1313:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1314:             IF loc_oPg.cnt_4c_CopiarAcesso.Visible
1315:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1316:             ELSE
1317:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1318:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1319:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1320:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1321:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .T.
1322:             ENDIF
1323:             loc_lResultado = .T.
1324:         CATCH TO loc_oErro
1325:             MsgErro("Erro ao alternar c" + CHR(243) + "pia:" + CHR(13) + loc_oErro.Message, "Erro")
1326:         ENDTRY
1327:         RETURN loc_lResultado
1328:     ENDPROC
1329: 
1330:     *--------------------------------------------------------------------------
1331:     PROCEDURE BtnConfirmarCopiaClick()
1332:     *--------------------------------------------------------------------------
1333:         LOCAL loc_lResultado, loc_oPg, loc_cCGrusSrc, loc_cSGrusSrc
1334:         LOCAL loc_cSql, loc_nSql
1335:         loc_lResultado = .F.
1336:         TRY
1337:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1338:             loc_cCGrusSrc = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
1339:             loc_cSGrusSrc = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value)
1340:             IF EMPTY(loc_cCGrusSrc)
1341:                 MsgAviso("Informe o grupo de origem.", "Aviso")
1342:             ELSE
1343:                 loc_cSql = "SELECT CCars, CTits, COrds, CLins, Maxs, Mins, " + ;
1344:                            "nChkCxas, cSelecaos, cTpDados " + ;
1345:                            "FROM SigCdFtc WHERE CGrus = " + EscaparSQL(loc_cCGrusSrc)
1346:                 IF THIS.this_nTipo = 0 AND !EMPTY(loc_cSGrusSrc)
1347:                     loc_cSql = loc_cSql + " AND SGrus = " + EscaparSQL(loc_cSGrusSrc)
1348:                 ENDIF
1349:                 loc_cSql = loc_cSql + " ORDER BY COrds"
1350: 
1351:                 IF USED("cursor_4c_CopiaFtc")
1352:                     USE IN cursor_4c_CopiaFtc
1353:                 ENDIF
1354:                 loc_nSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CopiaFtc")
1355:                 IF loc_nSql <= 0
1356:                     MsgErro("Erro ao buscar ficha de origem.", "Erro")
1357:                 ELSE
1358:                     IF RECCOUNT("cursor_4c_CopiaFtc") = 0
1359:                         USE IN cursor_4c_CopiaFtc
1360:                         MsgAviso("Grupo de origem n" + CHR(227) + "o possui ficha t" + ;
1361:                             CHR(233) + "cnica.", "Aviso")
1362:                     ELSE
1363:                         SELECT crFichaTec
1364:                         ZAP
1365:                         SELECT cursor_4c_CopiaFtc
1366:                         SCAN
1367:                             SELECT crFichaTec
1368:                             APPEND BLANK
1369:                             REPLACE crFichaTec.CCars     WITH ALLTRIM(cursor_4c_CopiaFtc.CCars)
1370:                             REPLACE crFichaTec.CTits     WITH ALLTRIM(cursor_4c_CopiaFtc.CTits)
1371:                             REPLACE crFichaTec.COrds     WITH cursor_4c_CopiaFtc.COrds
1372:                             REPLACE crFichaTec.CLins     WITH cursor_4c_CopiaFtc.CLins
1373:                             REPLACE crFichaTec.Maxs      WITH cursor_4c_CopiaFtc.Maxs
1374:                             REPLACE crFichaTec.Mins      WITH cursor_4c_CopiaFtc.Mins
1375:                             REPLACE crFichaTec.nChkCxas  WITH cursor_4c_CopiaFtc.nChkCxas
1376:                             REPLACE crFichaTec.cSelecaos WITH cursor_4c_CopiaFtc.cSelecaos
1377:                             REPLACE crFichaTec.cTpDados  WITH cursor_4c_CopiaFtc.cTpDados
1378:                             SELECT cursor_4c_CopiaFtc
1379:                         ENDSCAN
1380:                         USE IN cursor_4c_CopiaFtc
1381: 
1382:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1383:                         loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1384:                         loc_oPg.grd_4c_Fichas.Refresh()
1385:                         loc_lResultado = .T.
1386:                     ENDIF
1387:                 ENDIF
1388:             ENDIF
1389:         CATCH TO loc_oErro
1390:             MsgErro("Erro ao copiar ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1391:         ENDTRY
1392:         RETURN loc_lResultado
1393:     ENDPROC
1394: 
1395:     *--------------------------------------------------------------------------
1396:     PROCEDURE BtnCancelarCopiaClick()
1397:     *--------------------------------------------------------------------------
1398:         LOCAL loc_oPg
1399:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1400:         loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1401:     ENDPROC
1402: 
1403:     *--------------------------------------------------------------------------
1404:     PROCEDURE BtnFiguraClick()
1405:     *--------------------------------------------------------------------------
1406:         LOCAL loc_lResultado, loc_cArqFig, loc_cConteudo, loc_cArqTemp, loc_cExt, loc_oPg2
1407:         loc_lResultado = .F.
1408:         TRY
1409:             loc_cArqFig = GETPICT("jpg,bmp", "Selecione a imagem da ficha t" + CHR(233) + "cnica")
1410:             IF !EMPTY(loc_cArqFig) AND FILE(loc_cArqFig)
1411:                 loc_cConteudo = FILETOSTR(loc_cArqFig)
1412:                 IF USED("crFichaCab")
1413:                     SELECT crFichaCab
1414:                     REPLACE crFichaCab.mFicTecs WITH loc_cConteudo
1415:                 ENDIF
1416:                 loc_cExt     = LOWER(JUSTEXT(loc_cArqFig))
1417:                 loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + "." + loc_cExt
1418:                 STRTOFILE(loc_cConteudo, loc_cArqTemp)
1419:                 IF FILE(loc_cArqTemp)
1420:                     loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1421:                     loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
1422:                     loc_oPg2.img_4c_FigTec.Visible = .T.
1423:                 ENDIF
1424:                 loc_lResultado = .T.
1425:             ENDIF
1426:         CATCH TO loc_oErro
1427:             MsgErro("Erro ao carregar figura:" + CHR(13) + loc_oErro.Message, "Erro")
1428:         ENDTRY
1429:         RETURN loc_lResultado
1430:     ENDPROC
1431: 
1432:     *--------------------------------------------------------------------------
1433:     PROCEDURE BtnVoltarFichaClick()
1434:     *--------------------------------------------------------------------------
1435:         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.ActivePage = 1
1436:     ENDPROC
1437: 
1438:     *--------------------------------------------------------------------------
1439:     PROCEDURE ValidCCarsGrid()
1440:     *--------------------------------------------------------------------------
1441:         LOCAL loc_lResultado, loc_cCCars, loc_nSql, loc_oForm
1442:         loc_lResultado = .T.
1443:         TRY
1444:             IF USED("crFichaTec")
1445:                 SELECT crFichaTec
1446:                 IF !EOF()
1447:                     loc_cCCars = ALLTRIM(crFichaTec.CCars)
1448:                     IF !EMPTY(loc_cCCars)
1449:                         IF USED("cursor_4c_BuscaCCars")
1450:                             USE IN cursor_4c_BuscaCCars
1451:                         ENDIF
1452:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1453:                             "SELECT CCars, DCars FROM SigCrRaP WHERE CCars = " + EscaparSQL(loc_cCCars), ;
1454:                             "cursor_4c_BuscaCCars")
1455:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCCars") > 0
1456:                             USE IN cursor_4c_BuscaCCars
1457:                         ELSE
1458:                             IF USED("cursor_4c_BuscaCCars")
1459:                                 USE IN cursor_4c_BuscaCCars
1460:                             ENDIF
1461:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1462:                                 "SigCrRaP", "cursor_4c_BuscaCCars", "CCars", loc_cCCars, ;
1463:                                 "Caracter" + CHR(237) + "sticas")
1464:                             IF !ISNULL(loc_oForm)
1465:                                 IF !loc_oForm.this_lAchouRegistro
1466:                                     loc_oForm.mAddColuna("CCars", "", "C" + CHR(243) + "digo")
1467:                                     loc_oForm.mAddColuna("DCars", "", "Descri" + CHR(231) + CHR(227) + "o")
1468:                                     loc_oForm.Show()
1469:                                 ENDIF
1470:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCCars")
1471:                                     SELECT crFichaTec
1472:                                     REPLACE crFichaTec.CCars WITH ALLTRIM(cursor_4c_BuscaCCars.CCars)
1473:                                     USE IN cursor_4c_BuscaCCars
1474:                                 ELSE
1475:                                     SELECT crFichaTec
1476:                                     REPLACE crFichaTec.CCars WITH ""
1477:                                     IF USED("cursor_4c_BuscaCCars")
1478:                                         USE IN cursor_4c_BuscaCCars
1479:                                     ENDIF
1480:                                 ENDIF
1481:                                 loc_oForm.Release()
1482:                             ENDIF
1483:                         ENDIF
1484:                     ENDIF
1485:                 ENDIF
1486:             ENDIF
1487:         CATCH TO loc_oErro
1488:             MsgErro("Erro em ValidCCarsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1489:         ENDTRY
1490:         RETURN loc_lResultado
1491:     ENDPROC
1492: 
1493:     *--------------------------------------------------------------------------
1494:     PROCEDURE ValidCTitsGrid()
1495:     *--------------------------------------------------------------------------
1496:         LOCAL loc_lResultado, loc_cCTits, loc_nSql, loc_oForm
1497:         loc_lResultado = .T.
1498:         TRY
1499:             IF USED("crFichaTec")
1500:                 SELECT crFichaTec
1501:                 IF !EOF()
1502:                     loc_cCTits = ALLTRIM(crFichaTec.CTits)
1503:                     IF !EMPTY(loc_cCTits)
1504:                         IF USED("cursor_4c_BuscaCTits")
1505:                             USE IN cursor_4c_BuscaCTits
1506:                         ENDIF
1507:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1508:                             "SELECT CTits, DTits FROM SigPrCpP WHERE CTits = " + EscaparSQL(loc_cCTits), ;
1509:                             "cursor_4c_BuscaCTits")
1510:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCTits") > 0
1511:                             USE IN cursor_4c_BuscaCTits
1512:                         ELSE
1513:                             IF USED("cursor_4c_BuscaCTits")
1514:                                 USE IN cursor_4c_BuscaCTits
1515:                             ENDIF
1516:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1517:                                 "SigPrCpP", "cursor_4c_BuscaCTits", "CTits", loc_cCTits, ;
1518:                                 "T" + CHR(237) + "tulos")
1519:                             IF !ISNULL(loc_oForm)
1520:                                 IF !loc_oForm.this_lAchouRegistro
1521:                                     loc_oForm.mAddColuna("CTits", "", "C" + CHR(243) + "digo")
1522:                                     loc_oForm.mAddColuna("DTits", "", "Descri" + CHR(231) + CHR(227) + "o")
1523:                                     loc_oForm.Show()
1524:                                 ENDIF
1525:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCTits")
1526:                                     SELECT crFichaTec
1527:                                     REPLACE crFichaTec.CTits WITH ALLTRIM(cursor_4c_BuscaCTits.CTits)
1528:                                     USE IN cursor_4c_BuscaCTits
1529:                                 ELSE
1530:                                     SELECT crFichaTec
1531:                                     REPLACE crFichaTec.CTits WITH ""
1532:                                     IF USED("cursor_4c_BuscaCTits")
1533:                                         USE IN cursor_4c_BuscaCTits
1534:                                     ENDIF
1535:                                 ENDIF
1536:                                 loc_oForm.Release()
1537:                             ENDIF
1538:                         ENDIF
1539:                     ENDIF
1540:                 ENDIF
1541:             ENDIF
1542:         CATCH TO loc_oErro
1543:             MsgErro("Erro em ValidCTitsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1544:         ENDTRY
1545:         RETURN loc_lResultado
1546:     ENDPROC
1547: 
1548:     *--------------------------------------------------------------------------
1549:     PROCEDURE KeyPressCTpDados(par_nKeyCode, par_nShiftAltCtrl)
1550:     *--------------------------------------------------------------------------
1551:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1552:         LOCAL loc_lResultado
1553:         loc_lResultado = .F.
1554:         TRY
1555:             IF par_nKeyCode = 13 AND THIS.this_cModoAtual = "ALTERAR"
1556:                 IF USED("crFichaTec")
1557:                     SELECT crFichaTec
1558:                     IF !EOF() AND RECNO() = RECCOUNT()
1559:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1560:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1561:                     ENDIF
1562:                 ENDIF
1563:             ENDIF
1564:             loc_lResultado = .T.
1565:         CATCH TO loc_oErro
1566:             MsgErro("Erro em KeyPressCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1567:         ENDTRY
1568:         RETURN loc_lResultado
1569:     ENDPROC
1570: 
1571:     *--------------------------------------------------------------------------
1572:     PROCEDURE ValidCpyCGrus(par_nKeyCode, par_nShiftAltCtrl)
1573:     *--------------------------------------------------------------------------
1574:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1575:     IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1576:         RETURN
1577:     ENDIF
1578:         LOCAL loc_lResultado, loc_oPg, loc_cCGrus, loc_cTabela, loc_oForm, loc_lEncontrado
1579:         loc_lResultado  = .T.
1580:         loc_lEncontrado = .F.
1581:         TRY
1582:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1583:             loc_cCGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
1584:             IF EMPTY(loc_cCGrus)
1585:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1586:                 loc_lEncontrado = .T.
1587:             ELSE
1588:                 IF USED("crSigCdGrpFilter")
1589:                     SELECT crSigCdGrpFilter
1590:                     LOCATE FOR ALLTRIM(crSigCdGrpFilter.CGrus) = loc_cCGrus
1591:                     IF !EOF()
1592:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(crSigCdGrpFilter.DGrus)
1593:                         loc_lEncontrado = .T.
1594:                     ENDIF
1595:                 ENDIF
1596:             ENDIF
1597:             IF !loc_lEncontrado
1598:                 DO CASE
1599:                 CASE THIS.this_nTipo = 1
1600:                     loc_cTabela = "SigCdGcr"
1601:                 CASE THIS.this_nTipo = 2
1602:                     loc_cTabela = "SigCdOpe"
1603:                 OTHERWISE
1604:                     loc_cTabela = "SigCdGrp"
1605:                 ENDCASE
1606: 
1607:                 IF USED("cursor_4c_BuscaGrp")
1608:                     USE IN cursor_4c_BuscaGrp
1609:                 ENDIF
1610:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1611:                     loc_cTabela, "cursor_4c_BuscaGrp", "CGrus", loc_cCGrus, "Grupos")
1612:                 IF !ISNULL(loc_oForm)
1613:                     IF !loc_oForm.this_lAchouRegistro
1614:                         loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1615:                         loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1616:                         loc_oForm.Show()
1617:                     ENDIF
1618:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1619:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1620:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1621:                         USE IN cursor_4c_BuscaGrp
1622:                     ELSE
1623:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1624:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1625:                         IF USED("cursor_4c_BuscaGrp")
1626:                             USE IN cursor_4c_BuscaGrp
1627:                         ENDIF
1628:                     ENDIF
1629:                     loc_oForm.Release()
1630:                 ENDIF
1631:             ENDIF
1632:         CATCH TO loc_oErro
1633:             MsgErro("Erro em ValidCpyCGrus:" + CHR(13) + loc_oErro.Message, "Erro")
1634:         ENDTRY
1635:         RETURN loc_lResultado
1636:     ENDPROC
1637: 
1638:     *--------------------------------------------------------------------------
1639:     PROCEDURE ValidCpySGrus(par_nKeyCode, par_nShiftAltCtrl)
1640:     *--------------------------------------------------------------------------
1641:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1642:     IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1643:         RETURN
1644:     ENDIF
1645:         LOCAL loc_lResultado, loc_oPg, loc_cSGrus, loc_cCGrus, loc_oForm, loc_nSql
1646:         loc_lResultado = .T.
1647:         TRY
1648:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1649:             loc_cCGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
1650:             loc_cSGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value)
1651:             IF EMPTY(loc_cSGrus)
1652:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1653:             ELSE
1654:                 IF USED("cursor_4c_BuscaSGrp")
1655:                     USE IN cursor_4c_BuscaSGrp
1656:                 ENDIF
1657:                 loc_nSql = SQLEXEC(gnConnHandle, ;
1658:                     "SELECT Codigos, Descricaos FROM SigCdPsg" + ;
1659:                     " WHERE CGrus = " + EscaparSQL(loc_cCGrus) + ;
1660:                     " AND Codigos = " + EscaparSQL(loc_cSGrus), ;
1661:                     "cursor_4c_BuscaSGrp")
1662:                 IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaSGrp") > 0
1663:                     SELECT cursor_4c_BuscaSGrp
1664:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1665:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1666:                     USE IN cursor_4c_BuscaSGrp
1667:                 ELSE
1668:                     IF USED("cursor_4c_BuscaSGrp")
1669:                         USE IN cursor_4c_BuscaSGrp
1670:                     ENDIF
1671:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1672:                         "SigCdPsg", "cursor_4c_BuscaSGrp", "Codigos", loc_cSGrus, ;
1673:                         "Sub-grupos")
1674:                     IF VARTYPE(loc_oForm) = "O"
1675:                         IF !loc_oForm.this_lAchouRegistro
1676:                             loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1677:                             loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1678:                             loc_oForm.Show()
1679:                         ENDIF
1680:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSGrp")
1681:                             SELECT cursor_4c_BuscaSGrp
1682:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1683:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1684:                             USE IN cursor_4c_BuscaSGrp
1685:                         ELSE
1686:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1687:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1688:                             IF USED("cursor_4c_BuscaSGrp")
1689:                                 USE IN cursor_4c_BuscaSGrp
1690:                             ENDIF
1691:                         ENDIF
1692:                         loc_oForm.Release()
1693:                     ENDIF
1694:                 ENDIF
1695:             ENDIF
1696:         CATCH TO loc_oErro
1697:             MsgErro("Erro em ValidCpySGrus:" + CHR(13) + loc_oErro.Message, "Erro")
1698:         ENDTRY
1699:         RETURN loc_lResultado
1700:     ENDPROC
1701: 
1702:     *--------------------------------------------------------------------------
1703:     PROCEDURE ValidCSelecaos()
1704:     *--------------------------------------------------------------------------
1705:         LOCAL loc_lResultado, loc_cValor
1706:         loc_lResultado = .T.
1707:         TRY
1708:             IF USED("crFichaTec")
1709:                 SELECT crFichaTec
1710:                 IF !EOF()
1711:                     loc_cValor = ALLTRIM(crFichaTec.cSelecaos)
1712:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1713:                         MsgAviso("Tipos de Sele" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
1714:                             "lidos: S ou N !", "Aten" + CHR(231) + CHR(227) + "o")
1715:                         REPLACE crFichaTec.cSelecaos WITH " "
1716:                     ENDIF
1717:                 ENDIF
1718:             ENDIF
1719:         CATCH TO loc_oErro
1720:             MsgErro("Erro em ValidCSelecaos:" + CHR(13) + loc_oErro.Message, "Erro")
1721:         ENDTRY
1722:         RETURN loc_lResultado
1723:     ENDPROC
1724: 
1725:     *--------------------------------------------------------------------------
1726:     PROCEDURE ValidCTpDados()
1727:     *--------------------------------------------------------------------------
1728:         LOCAL loc_lResultado, loc_cValor
1729:         loc_lResultado = .T.
1730:         TRY
1731:             IF USED("crFichaTec")
1732:                 SELECT crFichaTec
1733:                 IF !EOF()
1734:                     loc_cValor = ALLTRIM(crFichaTec.cTpDados)
1735:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "C", "D", "N")
1736:                         MsgAviso("Tipo de dado inv" + CHR(225) + "lido." + CHR(13) + ;
1737:                             "Usar: C - Caracter, D - Data, N - Num" + CHR(233) + "rico !", ;
1738:                             "Aten" + CHR(231) + CHR(227) + "o")
1739:                         REPLACE crFichaTec.cTpDados WITH " "
1740:                     ENDIF
1741:                 ENDIF
1742:             ENDIF
1743:         CATCH TO loc_oErro
1744:             MsgErro("Erro em ValidCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1745:         ENDTRY
1746:         RETURN loc_lResultado
1747:     ENDPROC
1748: 
1749:     *--------------------------------------------------------------------------
1750:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1751:     *--------------------------------------------------------------------------
1752:         LOCAL loc_oPg, loc_oPg2
1753:         TRY
1754:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1755:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1756:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5) AND THIS.this_nTipo = 0
1757:                 loc_oPg.opt_4c_NChkDims.Enabled = par_lHabilitar
1758:             ENDIF
1759:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5) AND THIS.this_nTipo = 0
1760:                 loc_oPg.opt_4c_NChkTems.Enabled = par_lHabilitar
1761:             ENDIF
1762:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5) AND THIS.this_nTipo = 0
1763:                 loc_oPg.opt_4c_NChkPess.Enabled = par_lHabilitar
1764:             ENDIF
1765:             IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5) AND THIS.this_nTipo = 0
1766:                 loc_oPg2.opt_4c_NChkImps.Enabled = par_lHabilitar
1767:             ENDIF
1768:             IF PEMSTATUS(loc_oPg2, "chk_4c_NFixFigs", 5) AND THIS.this_nTipo = 0
1769:                 loc_oPg2.chk_4c_NFixFigs.Enabled = par_lHabilitar
1770:             ENDIF
1771:         CATCH TO loc_oErro
1772:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1773:         ENDTRY
1774:     ENDPROC
1775: 
1776:     *--------------------------------------------------------------------------
1777:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1778:     *--------------------------------------------------------------------------
1779:         LOCAL loc_nI, loc_oCtrl, loc_cNome, loc_nP
1780:         IF ISNULL(par_oContainer) OR !ISOBJECT(par_oContainer)
1781:             RETURN
1782:         ENDIF
1783:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1784:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1785:             loc_cNome = UPPER(ALLTRIM(loc_oCtrl.Name))
1786:             *-- Paineis flutuantes: preservar Visible=.F. mas processar filhos internos
1787:             IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_COPIARACESSO", ;
1788:                     "CMD_4C_APAGARLINHA", "CMD_4C_COPIAFICHA", ;
1789:                     "IMG_4C_FIGTEC", "CMD_4C_FIGURA")
1790:                 IF PEMSTATUS(loc_oCtrl, "PageCount", 5)
1791:                     FOR loc_nP = 1 TO loc_oCtrl.PageCount
1792:                         THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
1793:                     ENDFOR
1794:                 ELSE
1795:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1796:                         THIS.TornarControlesVisiveis(loc_oCtrl)
1797:                     ENDIF
1798:                 ENDIF
1799:                 LOOP
1800:             ENDIF
1801:             loc_oCtrl.Visible = .T.
1802:             IF PEMSTATUS(loc_oCtrl, "PageCount", 5)
1803:                 FOR loc_nP = 1 TO loc_oCtrl.PageCount
1804:                     THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
1805:                 ENDFOR
1806:             ELSE
1807:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1808:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1809:                 ENDIF
1810:             ENDIF
1811:         ENDFOR
1812:     ENDPROC
1813: 
1814:     *--------------------------------------------------------------------------
1815:     * FormParaBO - Consolida dados dos controles bound ao BO/cursor
1816:     *   Os TextBox/OptionGroup/CheckBox estao com ControlSource direto para
1817:     *   crFichaCab/crFichaTec (padrao SCX legado). Este metodo garante que
1818:     *   o registro corrente esteja gravado no cursor antes de operacoes.
1819:     *--------------------------------------------------------------------------
1820:     PROTECTED PROCEDURE FormParaBO()
1821:         LOCAL loc_lResultado
1822:         loc_lResultado = .F.
1823:         TRY
1824:             *-- ControlSource faz binding bidirecional automatico: qualquer
1825:             *-- alteracao na tela ja esta gravada no cursor. Aqui garantimos
1826:             *-- apenas que os cursores estao posicionados corretamente para
1827:             *-- que o BO acesse o registro correto no Salvar/Excluir.
1828:             IF USED("crFichaCab")
1829:                 SELECT crFichaCab
1830:                 IF !EOF() AND !BOF()
1831:                     GO RECNO()
1832:                 ENDIF
1833:             ENDIF
1834:             IF USED("crFichaTec")
1835:                 SELECT crFichaTec
1836:                 IF !EOF() AND !BOF()
1837:                     GO RECNO()
1838:                 ENDIF
1839:             ENDIF
1840:             loc_lResultado = .T.
1841:         CATCH TO loc_oErro
1842:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1843:         ENDTRY
1844:         RETURN loc_lResultado
1845:     ENDPROC
1846: 
1847:     *--------------------------------------------------------------------------
1848:     * BOParaForm - Atualiza controles da tela com dados dos cursores do BO
1849:     *   Refresh dos containers/grids que exibem crFichaCab e crFichaTec.
1850:     *--------------------------------------------------------------------------
1851:     PROTECTED PROCEDURE BOParaForm()
1852:         LOCAL loc_lResultado, loc_oPg, loc_oPg2
1853:         loc_lResultado = .F.
1854:         TRY
1855:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1856:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1857: 
1858:             IF USED("crFichaTec")
1859:                 SELECT crFichaTec
1860:                 GO TOP
1861:                 loc_oPg.grd_4c_Fichas.Refresh()
1862:             ENDIF
1863: 
1864:             *-- Refresh dos OptionGroups bound (nChkDims/nChkTems/nChkPess/nChkImps)
1865:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5)
1866:                 loc_oPg.opt_4c_NChkDims.Refresh()
1867:             ENDIF
1868:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5)
1869:                 loc_oPg.opt_4c_NChkTems.Refresh()
1870:             ENDIF
1871:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5)
1872:                 loc_oPg.opt_4c_NChkPess.Refresh()
1873:             ENDIF
1874:             IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5)
1875:                 loc_oPg2.opt_4c_NChkImps.Refresh()
1876:             ENDIF
1877:             IF PEMSTATUS(loc_oPg2, "chk_4c_NFixFigs", 5)
1878:                 loc_oPg2.chk_4c_NFixFigs.Refresh()
1879:             ENDIF
1880: 
1881:             loc_lResultado = .T.
1882:         CATCH TO loc_oErro
1883:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
1884:         ENDTRY
1885:         RETURN loc_lResultado
1886:     ENDPROC
1887: 
1888:     *--------------------------------------------------------------------------
1889:     * LimparCampos - Zera os cursores crFichaCab / crFichaTec e reseta a UI
1890:     *   Chamado quando cancela uma operacao ou volta para lista.
1891:     *--------------------------------------------------------------------------
1892:     PROTECTED PROCEDURE LimparCampos()
1893:         LOCAL loc_lResultado, loc_oPg, loc_oPg2
1894:         loc_lResultado = .F.
1895:         TRY
1896:             IF USED("crFichaCab")
1897:                 SELECT crFichaCab
1898:                 ZAP
1899:             ENDIF
1900:             IF USED("crFichaTec")
1901:                 SELECT crFichaTec
1902:                 ZAP
1903:             ENDIF
1904: 
1905:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1906:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1907: 
1908:             *-- Fecha painel de copia se estiver aberto
1909:             IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
1910:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1911:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1912:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1913:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1914:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1915:             ENDIF
1916: 
1917:             *-- Limpa a imagem da ficha tecnica
1918:             IF PEMSTATUS(loc_oPg2, "img_4c_FigTec", 5)
1919:                 loc_oPg2.img_4c_FigTec.Picture = ""
1920:                 loc_oPg2.img_4c_FigTec.Visible = .F.
1921:             ENDIF
1922: 
1923:             *-- Refresh dos grids/controles bound
1924:             loc_oPg.grd_4c_Fichas.Refresh()
1925: 
1926:             loc_lResultado = .T.
1927:         CATCH TO loc_oErro
1928:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1929:         ENDTRY
1930:         RETURN loc_lResultado
1931:     ENDPROC
1932: 
1933:     *--------------------------------------------------------------------------
1934:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes conforme
1935:     *   o modo atual (LISTA/VISUALIZAR/ALTERAR/EXCLUIR).
1936:     *--------------------------------------------------------------------------
1937:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
1938:         LOCAL loc_lResultado, loc_oPg, loc_oPg2, loc_lAlterar, loc_lLeitura
1939:         loc_lResultado = .F.
1940:         TRY
1941:             IF VARTYPE(par_cModo) <> "C"
1942:                 par_cModo = THIS.this_cModoAtual
1943:             ENDIF
1944:             loc_lAlterar = (par_cModo == "ALTERAR")
1945:             loc_lLeitura = (par_cModo == "VISUALIZAR" OR par_cModo == "EXCLUIR")
1946: 
1947:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1948:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1949: 
1950:             *-- Botoes de manipulacao da grade so aparecem em ALTERAR
1951:             IF PEMSTATUS(loc_oPg, "cmd_4c_ApagarLinha", 5)
1952:                 loc_oPg.cmd_4c_ApagarLinha.Visible = loc_lAlterar
1953:             ENDIF
1954:             IF PEMSTATUS(loc_oPg, "cmd_4c_CopiaFicha", 5)
1955:                 loc_oPg.cmd_4c_CopiaFicha.Visible = loc_lAlterar
1956:             ENDIF
1957: 
1958:             *-- Botao de figura na pagina complementar
1959:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Figura", 5)
1960:                 loc_oPg2.cmd_4c_Figura.Visible = loc_lAlterar
1961:             ENDIF
1962: 
1963:             *-- Grade em modo leitura quando visualiza/exclui
1964:             IF PEMSTATUS(loc_oPg, "grd_4c_Fichas", 5)
1965:                 loc_oPg.grd_4c_Fichas.ReadOnly = loc_lLeitura OR !loc_lAlterar
1966:             ENDIF
1967: 
1968:             *-- Fecha painel de copia
1969:             IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
1970:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1971:             ENDIF
1972: 
1973:             *-- Habilita/desabilita campos de configuracao (OptionGroups + CheckBox)
1974:             THIS.HabilitarCampos(loc_lAlterar)
1975: 
1976:             loc_lResultado = .T.
1977:         CATCH TO loc_oErro
1978:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1979:         ENDTRY
1980:         RETURN loc_lResultado
1981:     ENDPROC
1982: 
1983: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FctBO.prg):
*==============================================================================
* FctBO.prg - Business Object para Cadastro de Ficha Tecnica / Perfis
* Tabela principal: SigCdFtc (linhas de ficha tecnica por CGrus+SGrus)
* Cabecalho do grupo: SigCdGrp (pnTipo=0), SigCdGcr (pnTipo=1), SigCdOpe (pnTipo=2)
*==============================================================================
DEFINE CLASS FctBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao do grupo selecionado (cabecalho da ficha tecnica)
    *--------------------------------------------------------------------------
    this_cCGrus    = ""   && Codigo do grupo (chave 1)
    this_cDGrus    = ""   && Descricao do grupo
    this_cSGrus    = ""   && Codigo do subgrupo (chave 2)
    this_cDSGru    = ""   && Descricao do subgrupo

    *--------------------------------------------------------------------------
    * Flags do cabecalho (vem de SigCdGrp quando pnTipo=0)
    * nChkDims: Dimensoes Obrigatorias (1=Sim, 2=Nao)
    * nChkPess: Peso Obrigatorio        (1=Sim, 2=Nao)
    * nChkTems: Tempo Instal Obrigatorio (1=Sim, 2=Nao)
    * nChkImps: Impressao (1=Produtos, 2=Ficha Tecnica)
    * nFixFigs: Figuras Fixas (0/1)
    *--------------------------------------------------------------------------
    this_nChkDims  = 1    && Dimensoes Obrigatorias
    this_nChkPess  = 1    && Peso Obrigatorio
    this_nChkTems  = 1    && Tempo de Instalacao Obrigatorio
    this_nChkImps  = 1    && Tipo de impressao
    this_nFixFigs  = 0    && Figuras fixas (checkbox)
    this_mFicTecs  = ""   && Imagem tecnica (memo/binario)

    *--------------------------------------------------------------------------
    * Tipo de formulario
    * 0 = Ficha Tecnica de Produtos (SigCdGrp/SigCdPsg)
    * 1 = Perfil de Contas           (SigCdGcr)
    * 2 = Configuracao de Movimentacao (SigCdOpe)
    *--------------------------------------------------------------------------
    this_nTipo     = 0    && Tipo (0=Produtos, 1=Contas, 2=Movimentacoes)

    *--------------------------------------------------------------------------
    * Controle de cursor principal do grid (SigCdFtc)
    *--------------------------------------------------------------------------
    this_cCursorDados = "crFichaTec"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigCdFtc"
                THIS.this_cCampoChave = "cIdChaves"
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inicializar FctBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao destruir FctBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CriarCursores - Cria os cursores de trabalho necessarios
    *==========================================================================
    PROCEDURE CriarCursores()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            SET NULL ON
            CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
            INDEX ON CGrus + SGrus TAG Col1
            INDEX ON SGrus + CGrus TAG Col2
            INDEX ON DGrus + CGrus TAG Col3
            INDEX ON DSGru + SGrus TAG Col4
            SET ORDER TO Col1 IN crDados

            CREATE CURSOR crFichaCab (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), ;
                nChkDims N(1), nChkPess N(1), nChkTems N(1), nChkImps N(1), ;
                nFixFigs N(1), mFicTecs M NULL)

            CREATE CURSOR crFichaTec (CGrus C(20), SGrus C(6), CCars C(20), CTits C(20), ;
                COrds N(3), CLins N(2), Maxs N(3), Mins N(3), ;
                nChkCxas N(1), cSelecaos C(1), cTpDados C(1))

            CREATE CURSOR crSigCdGrp (CGrus C(20), DGrus C(30), Mercs C(3), ;
                Margems N(9,6), Apagar C(1))
            SET NULL OFF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao criar cursores:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a lista de grupos/contas/movimentacoes na grade principal
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("crDados")
                    SET NULL ON
                    CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("crDados")
                ZAP IN crDados
            ELSE
                THIS.CriarCursores()
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, FTecSubs" + ;
                    " FROM SigCdGrp" + ;
                    " ORDER BY CGrus, DGrus"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos, Descrs, 0 AS FTecSubs" + ;
                    " FROM SigCdGcr WHERE FichaTecs = 1" + ;
                    " ORDER BY Codigos, Descrs"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes, a.TitOpes, 0 AS FTecSubs" + ;
                    " FROM SigCdOpe a" + ;
                    " LEFT JOIN SigOpCdc b ON a.Dopes = b.Dopes" + ;
                    " WHERE b.OpeInatvs IN (0,2)" + ;
                    " ORDER BY a.Dopes, a.TitOpes"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGru")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crLocalGru
                SCAN
                    LOCAL loc_cGrupo, loc_cDescGrupo, loc_nFTecSubs
                    loc_cGrupo    = ALLTRIM(crLocalGru.CGrus)
                    loc_cDescGrupo = ""
                    loc_nFTecSubs  = 0

                    DO CASE
                    CASE THIS.this_nTipo = 0
                        loc_cDescGrupo = ALLTRIM(crLocalGru.DGrus)
                        loc_nFTecSubs  = NVL(crLocalGru.FTecSubs, 0)
                    CASE THIS.this_nTipo = 1
                        loc_cGrupo     = ALLTRIM(crLocalGru.Codigos)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.Descrs)
                    CASE THIS.this_nTipo = 2
                        loc_cGrupo     = ALLTRIM(crLocalGru.Dopes)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.TitOpes)
                    ENDCASE

                    INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                        VALUES (loc_cGrupo, loc_cDescGrupo, "", "", "")

                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT DISTINCT CGrus FROM SigCdFtc" + ;
                        " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                        " AND SGrus = SPACE(6) AND nTipos = " + ;
                        FormatarNumeroSQL(THIS.this_nTipo), "crTmpFtc")
                    IF loc_nResult >= 1
                        GO TOP IN crTmpFtc
                        IF !EOF("crTmpFtc")
                            SELECT crDados
                            GO BOTTOM IN crDados
                            REPLACE TemDados WITH loc_cGrupo IN crDados
                        ENDIF
                        IF USED("crTmpFtc")
                            USE IN crTmpFtc
                        ENDIF
                    ENDIF

                    IF THIS.this_nTipo = 0 AND loc_nFTecSubs = 1
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT CGrus, Codigos, Descricaos FROM SigCdPsg" + ;
                            " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                            " ORDER BY CGrus, Codigos, Descricaos", "crLocalSGru")
                        IF loc_nResult >= 1
                            SELECT crLocalSGru
                            SCAN
                                INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                                    VALUES (loc_cGrupo, loc_cDescGrupo, ;
                                        ALLTRIM(crLocalSGru.Codigos), ;
                                        ALLTRIM(crLocalSGru.Descricaos), "")

                                loc_nResult = SQLEXEC(gnConnHandle, ;
                                    "SELECT DISTINCT CGrus, SGrus FROM SigCdFtc" + ;
                                    " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                                    " AND SGrus = " + EscaparSQL(ALLTRIM(crLocalSGru.Codigos)) + ;
                                    " AND nTipos = 0", "crTmpSGru")
                                IF loc_nResult >= 1
                                    GO TOP IN crTmpSGru
                                    IF !EOF("crTmpSGru")
                                        SELECT crDados
                                        GO BOTTOM IN crDados
                                        REPLACE TemDados WITH ;
                                            loc_cGrupo + ALLTRIM(crLocalSGru.Codigos) IN crDados
                                    ENDIF
                                    IF USED("crTmpSGru")
                                        USE IN crTmpSGru
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            IF USED("crLocalSGru")
                                USE IN crLocalSGru
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT crLocalGru
                ENDSCAN

                IF USED("crLocalGru")
                    USE IN crLocalGru
                ENDIF

                GO TOP IN crDados
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFicha - Carrega crFichaCab e crFichaTec para um grupo/subgrupo
    * par_cCGrus  - Codigo do grupo
    * par_cSGrus  - Codigo do subgrupo (vazio para grupo raiz)
    * par_cDGrus  - Descricao do grupo
    * par_cDSGru  - Descricao do subgrupo
    * par_cModo   - "ALTERAR" / "VISUALIZAR" / "EXCLUIR"
    *==========================================================================
    FUNCTION CarregarFicha(par_cCGrus, par_cSGrus, par_cDGrus, par_cDSGru, par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nOrd
        loc_lResultado = .F.

        TRY
            IF USED("crFichaCab")
                ZAP IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                ZAP IN crFichaTec
            ENDIF

            THIS.this_cCGrus = ALLTRIM(par_cCGrus)
            THIS.this_cSGrus = ALLTRIM(par_cSGrus)
            THIS.this_cDGrus = ALLTRIM(par_cDGrus)
            THIS.this_cDSGru = ALLTRIM(par_cDSGru)

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT a.CGrus, a.nChkDims, a.nChkPess, a.nChkTems," + ;
                    " a.nChkImps, a.nFixFigs, a.mFicTecs" + ;
                    " FROM SigCdGrp a" + ;
                    " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT a.Codigos AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdGcr a" + ;
                    " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdOpe a" + ;
                    " WHERE a.Dopes = " + EscaparSQL(THIS.this_cCGrus)
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGruFicha")
            IF loc_nResult < 1
                MsgErro("Erro ao acessar cadastro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN crLocalGruFicha
                IF EOF("crLocalGruFicha")
                    MsgAviso("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " n" + CHR(227) + "o foi encontrado!" + CHR(13) + ;
                        "O grupo pode ter sido exclu" + CHR(237) + "do. Reinicie a opera" + ;
                        CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    INSERT INTO crFichaCab (CGrus, DGrus, SGrus, DSGru, nChkDims, ;
                        nChkPess, nChkTems, nChkImps, nFixFigs, mFicTecs) ;
                        VALUES (THIS.this_cCGrus, THIS.this_cDGrus, THIS.this_cSGrus, ;
                        THIS.this_cDSGru, NVL(crLocalGruFicha.nChkDims, 1), ;
                        NVL(crLocalGruFicha.nChkPess, 1), ;
                        NVL(crLocalGruFicha.nChkTems, 1), ;
                        NVL(crLocalGruFicha.nChkImps, 1), ;
                        NVL(crLocalGruFicha.nFixFigs, 0), ;
                        NVL(crLocalGruFicha.mFicTecs, ""))

                    THIS.this_nChkDims = NVL(crLocalGruFicha.nChkDims, 1)
                    THIS.this_nChkPess = NVL(crLocalGruFicha.nChkPess, 1)
                    THIS.this_nChkTems = NVL(crLocalGruFicha.nChkTems, 1)
                    THIS.this_nChkImps = NVL(crLocalGruFicha.nChkImps, 1)
                    THIS.this_nFixFigs = NVL(crLocalGruFicha.nFixFigs, 0)
                    THIS.this_mFicTecs = NVL(crLocalGruFicha.mFicTecs, "")

                    loc_cSQL = "SELECT a.*" + ;
                        " FROM SigCdFtc a" + ;
                        " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                        " AND a.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                        " ORDER BY a.COrds"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalCFTec")
                    IF loc_nResult < 1
                        MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        loc_nOrd = 1
                        SELECT crLocalCFTec
                        SCAN
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus, CCars, CTits, ;
                                CLins, Maxs, Mins, nChkCxas, cSelecaos, cTpDados) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus, ;
                                NVL(crLocalCFTec.CCars, ""), NVL(crLocalCFTec.CTits, ""), ;
                                NVL(crLocalCFTec.CLins, 0), NVL(crLocalCFTec.Maxs, 0), ;
                                NVL(crLocalCFTec.Mins, 0), NVL(crLocalCFTec.nChkCxas, 0), ;
                                NVL(crLocalCFTec.cSelecaos, " "), ;
                                NVL(crLocalCFTec.cTpDados, " "))
                            loc_nOrd = loc_nOrd + 1
                        ENDSCAN

                        IF USED("crLocalCFTec")
                            USE IN crLocalCFTec
                        ENDIF

                        IF ALLTRIM(par_cModo) == "ALTERAR"
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus)
                        ENDIF

                        GO TOP IN crFichaCab
                        GO TOP IN crFichaTec
                        GO BOTTOM IN crFichaTec

                        loc_lResultado = .T.
                    ENDIF
                ENDIF

                IF USED("crLocalGruFicha")
                    USE IN crLocalGruFicha
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFiltroGrupos - Carrega crSigCdGrpFilter para lookup no container de copia
    *==========================================================================
    FUNCTION CarregarFiltroGrupos()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, Mercs, Margems, 'S' AS Apagar" + ;
                    " FROM SigCdGrp"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos AS CGrus, Descrs AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdGcr"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT Dopes AS CGrus, TitOpes AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdOpe"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrpFilter")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crSigCdGrpFilter
                IF RECCOUNT("crSigCdGrpFilter") > 0
                    INDEX ON CGrus TAG CGrus
                    INDEX ON DGrus TAG DGrus
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AdicionarLinhaFicha - Adiciona linha em branco no final do crFichaTec
    *==========================================================================
    FUNCTION AdicionarLinhaFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nProxOrd
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec") OR !USED("crFichaCab")
                loc_lResultado = .F.
            ENDIF

            loc_nProxOrd = RECCOUNT("crFichaTec") + 1

            SELECT crFichaTec
            GO BOTTOM IN crFichaTec
            IF !EOF("crFichaTec")
                loc_nProxOrd = NVL(crFichaTec.COrds, 0) + 1
            ENDIF

            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                VALUES (loc_nProxOrd, THIS.this_cCGrus, THIS.this_cSGrus)

            GO BOTTOM IN crFichaTec
            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao adicionar linha:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFichaTec - Valida o conteudo da grade antes de gravar
    *==========================================================================
    FUNCTION ValidarFichaTec()
    *==========================================================================
        LOCAL loc_lResultado, loc_cMensagem
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec")
                MsgErro("Cursor de ficha t" + CHR(233) + "cnica n" + CHR(227) + ;
                    "o encontrado!", "Erro")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc")
                ZAP IN crSigCdFtc
            ELSE
                SET NULL ON
                CREATE CURSOR crSigCdFtc (COrds N(3), CGrus C(20), SGrus C(6), ;
                    CCars C(20), CTits C(20), CLins N(2), Maxs N(3), Mins N(3), ;
                    nChkCxas N(1), cSelecaos C(1), cIdChaves C(50), ;
                    nTipos N(1), cTpDados C(1))
                SET NULL OFF
            ENDIF

            SELECT crFichaTec
            SCAN
                IF !EMPTY(ALLTRIM(crFichaTec.CCars)) AND ;
                   !EMPTY(ALLTRIM(crFichaTec.CTits)) AND ;
                   crFichaTec.CLins >= 1
                    INSERT INTO crSigCdFtc (COrds, CGrus, SGrus, CCars, CTits, ;
                        CLins, Maxs, Mins, nChkCxas, cSelecaos, cIdChaves, ;
                        nTipos, cTpDados) ;
                        VALUES (crFichaTec.COrds, crFichaTec.CGrus, crFichaTec.SGrus, ;
                        crFichaTec.CCars, crFichaTec.CTits, crFichaTec.CLins, ;
                        crFichaTec.Maxs, crFichaTec.Mins, crFichaTec.nChkCxas, ;
                        NVL(crFichaTec.cSelecaos, " "), ;
                        LEFT(SYS(2015) + SYS(2015) + PADL(TRANSFORM(crFichaTec.COrds),5,"0"), 50), ;
                        THIS.this_nTipo, ;
                        NVL(crFichaTec.cTpDados, " "))
                ENDIF
            ENDSCAN

            IF RECCOUNT("crSigCdFtc") < 1
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                    " nenhum registro v" + CHR(225) + "lido na grade de ficha t" + ;
                    CHR(233) + "cnica!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            SELECT CCars, CTits, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY CCars, CTits ;
                INTO CURSOR csItensCheck

            SELECT csItensCheck
            SCAN
                IF csItensCheck.Totas > 1
                    MsgAviso("O Grupo e o T" + CHR(237) + "tulo " + CHR(34) + ;
                        ALLTRIM(csItensCheck.CCars) + " / " + ;
                        ALLTRIM(csItensCheck.CTits) + CHR(34) + ;
                        " est" + CHR(225) + " duplicado!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csItensCheck")
                        USE IN csItensCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csItensCheck")
                USE IN csItensCheck
            ENDIF

            SELECT COrds, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY COrds ;
                INTO CURSOR csOrdsCheck

            SELECT csOrdsCheck
            SCAN
                IF csOrdsCheck.Totas > 1
                    MsgAviso("A ordem de apresenta" + CHR(231) + CHR(227) + "o " + ;
                        CHR(34) + ALLTRIM(STR(csOrdsCheck.COrds)) + CHR(34) + ;
                        " est" + CHR(225) + " duplicada!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csOrdsCheck")
                        USE IN csOrdsCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csOrdsCheck")
                USE IN csOrdsCheck
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao validar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarExcluirFicha - Verifica se e possivel excluir a ficha tecnica
    *==========================================================================
    FUNCTION VerificarExcluirFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF !USED("crSigCdFtc") OR RECCOUNT("crSigCdFtc") < 1
                loc_lResultado = .T.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus), "crVerFtc")

            IF loc_nResult >= 1
                SELECT crVerFtc
                SCAN
                    LOCAL loc_cCCars, loc_cCTits, loc_cMsgProd
                    loc_cCCars = ALLTRIM(crVerFtc.CCars)
                    loc_cCTits = ALLTRIM(crVerFtc.CTits)

                    IF !EMPTY(loc_cCCars) AND !EMPTY(loc_cCTits)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT DISTINCT a.CPros FROM SigCdPft a, SigCdPro b" + ;
                            " WHERE a.CCars = " + EscaparSQL(loc_cCCars) + ;
                            " AND a.CTits = " + EscaparSQL(loc_cCTits) + ;
                            " AND a.CPros = b.CPros" + ;
                            " AND b.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                            " AND b.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                            " ORDER BY a.CPros", "crVerProd")
                        IF loc_nResult >= 1 AND RECCOUNT("crVerProd") > 0
                            GO TOP IN crVerProd
                            IF RECCOUNT("crVerProd") = 1
                                loc_cMsgProd = "O produto " + CHR(34) + ;
                                    ALLTRIM(crVerProd.CPros) + CHR(34) + " est" + CHR(225) + " "
                            ELSE
                                loc_cMsgProd = "Existem produtos que est" + CHR(227) + "o "
                            ENDIF
                            loc_cMsgProd = loc_cMsgProd + "utilizando o" + CHR(13) + ;
                                "Grupo de Caracter" + CHR(237) + "sticas: " + loc_cCCars + ;
                                " e o T" + CHR(237) + "tulo: " + loc_cCTits + "."
                            MsgErro(loc_cMsgProd, "Imposs" + CHR(237) + "vel Excluir")
                            IF USED("crVerProd")
                                USE IN crVerProd
                            ENDIF
                            loc_lResultado = .F.
                        ENDIF
                        IF USED("crVerProd")
                            USE IN crVerProd
                        ENDIF

                        IF loc_lResultado
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT DISTINCT GruCarTits FROM SigCdFtr" + ;
                                " WHERE GruCarTits = " + ;
                                EscaparSQL(THIS.this_cCGrus + THIS.this_cSGrus + loc_cCCars + loc_cCTits), ;
                                "crVerResp")
                            IF loc_nResult >= 1 AND RECCOUNT("crVerResp") > 0
                                MsgErro("A Caracter" + CHR(237) + "stica " + CHR(34) + ;
                                    loc_cCCars + CHR(34) + " com o T" + CHR(237) + ;
                                    "tulo " + CHR(34) + loc_cCTits + CHR(34) + CHR(13) + ;
                                    "possui respostas cadastradas! Exclua as respostas primeiro!", ;
                                    "Imposs" + CHR(237) + "vel Excluir")
                                IF USED("crVerResp")
                                    USE IN crVerResp
                                ENDIF
                                loc_lResultado = .F.
                            ENDIF
                            IF USED("crVerResp")
                                USE IN crVerResp
                            ENDIF
                        ENDIF
                    ENDIF

                    IF !loc_lResultado
                        GO BOTTOM IN crVerFtc
                    ENDIF
                ENDSCAN
                IF USED("crVerFtc")
                    USE IN crVerFtc
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarGrupoFicha - Atualiza flags do grupo e salva ficha tecnica
    * par_cModo - "ALTERAR" ou "EXCLUIR"
    *==========================================================================
    FUNCTION AtualizarGrupoFicha(par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        IF !INLIST(ALLTRIM(par_cModo), "ALTERAR", "EXCLUIR")
            MsgErro("Modo inv" + CHR(225) + "lido: " + ALLTRIM(par_cModo), "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF ALLTRIM(par_cModo) == "ALTERAR"
                loc_lResultado = THIS.Atualizar()
            ELSE
                loc_lResultado = THIS.ExecutarExclusao()
            ENDIF

            IF loc_lResultado
                IF USED("crDados")
                    SELECT crDados
                    IF ALLTRIM(par_cModo) == "ALTERAR"
                        REPLACE TemDados WITH THIS.this_cCGrus + THIS.this_cSGrus IN crDados
                    ELSE
                        REPLACE TemDados WITH "" IN crDados
                    ENDIF
                ENDIF
                THIS.RegistrarAuditoria(par_cModo)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(THIS.this_cCGrus) + "/" + ALLTRIM(THIS.this_cSGrus)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCGrus   = ALLTRIM(TratarNulo(CGrus, "C"))
                THIS.this_cDGrus   = ALLTRIM(TratarNulo(DGrus, "C"))
                THIS.this_cSGrus   = ALLTRIM(TratarNulo(SGrus, "C"))
                THIS.this_cDSGru   = ALLTRIM(TratarNulo(DSGru, "C"))
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Salva a ficha tecnica no banco:
    *   1. DELETE registros antigos de SigCdFtc
    *   2. Se pnTipo=0: UPDATE flags em SigCdGrp
    *   3. INSERT novos registros de crSigCdFtc em SigCdFtc
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF THIS.this_nTipo = 0
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdGrp WHERE CGrus = " + ;
                    EscaparSQL(THIS.this_cCGrus), "crLocalGruUpd")
                IF loc_nResult < 1 OR EOF("crLocalGruUpd")
                    MsgErro("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " foi exclu" + CHR(237) + "do durante o processo. Reinicie!", "Erro")
                    IF USED("crLocalGruUpd")
                        USE IN crLocalGruUpd
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
                IF USED("crLocalGruUpd")
                    USE IN crLocalGruUpd
                ENDIF

                IF !USED("crFichaCab")
                    MsgErro("Cursor de cabe" + CHR(231) + "alho n" + CHR(227) + "o encontrado!", "Erro")
                    loc_lResultado = .F.
                ENDIF

                GO TOP IN crFichaCab
                loc_cSQL = "UPDATE SigCdGrp SET" + ;
                    " nChkDims = " + FormatarNumeroSQL(crFichaCab.nChkDims) + "," + ;
                    " nChkPess = " + FormatarNumeroSQL(crFichaCab.nChkPess) + "," + ;
                    " nChkTems = " + FormatarNumeroSQL(crFichaCab.nChkTems) + "," + ;
                    " nChkImps = " + FormatarNumeroSQL(crFichaCab.nChkImps) + "," + ;
                    " nFixFigs = " + FormatarNumeroSQL(crFichaCab.nFixFigs) + "," + ;
                    " mFicTecs = " + IIF(EMPTY(crFichaCab.mFicTecs), "NULL", ;
                        EscaparSQL(crFichaCab.mFicTecs)) + ;
                    " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 1
                    MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha anterior:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc") AND RECCOUNT("crSigCdFtc") > 0
                SELECT crSigCdFtc
                SCAN
                    loc_cSQL = "INSERT INTO SigCdFtc" + ;
                        " (COrds, CGrus, SGrus, CCars, CTits, CLins, Maxs, Mins," + ;
                        " nChkCxas, cSelecaos, cIdChaves, nTipos, cTpDados) VALUES (" + ;
                        FormatarNumeroSQL(crSigCdFtc.COrds) + ", " + ;
                        EscaparSQL(crSigCdFtc.CGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.SGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.CCars) + ", " + ;
                        EscaparSQL(crSigCdFtc.CTits) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.CLins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Maxs) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Mins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.nChkCxas) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cSelecaos, " ")) + ", " + ;
                        "CONVERT(VARCHAR(50), NEWID()), " + ;
                        FormatarNumeroSQL(crSigCdFtc.nTipos) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cTpDados, " ")) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 1
                        MsgErro("Erro ao inserir linha da ficha:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao salvar ficha t" + CHR(233) + "cnica:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

