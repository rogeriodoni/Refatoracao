# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (14)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_COPIARACESSO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'ValidCpyCGrus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidCpyCGrus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidCpySGrus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidCpySGrus(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Sub-grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição Sub-grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Característica' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Max' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Min' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Caixa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Subgrupo, Descrição do grupo, Descrição do subgrupo, Grupo Características, Título Características, Ordem, Linhas, Máximo, Mínimo, Digitação, S, T. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFct.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1973 linhas total):

*-- Linhas 23 a 165:
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
61:                 THIS.CarregarLista()
62:                 loc_lResultado = .T.
63:             ENDIF
64:         CATCH TO loc_oErro
65:             MsgErro("Erro em InicializarForm (FormFct):" + CHR(13) + loc_oErro.Message, "Erro")
66:         ENDTRY
67:         RETURN loc_lResultado
68:     ENDPROC
69: 
70:     *--------------------------------------------------------------------------
71:     PROCEDURE Destroy()
72:     *--------------------------------------------------------------------------
73:         LOCAL loc_aCursores, loc_n
74:         TRY
75:             DIMENSION loc_aCursores(5)
76:             loc_aCursores(1) = "cursor_4c_BuscaCCars"
77:             loc_aCursores(2) = "cursor_4c_BuscaCTits"
78:             loc_aCursores(3) = "cursor_4c_BuscaGrp"
79:             loc_aCursores(4) = "cursor_4c_CopiaFtc"
80:             loc_aCursores(5) = "cursor_4c_BuscaSGrp"
81:             FOR loc_n = 1 TO 5
82:                 IF USED(loc_aCursores(loc_n))
83:                     USE IN (loc_aCursores(loc_n))
84:                 ENDIF
85:             ENDFOR
86:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
87:                 THIS.this_oBusinessObject = .NULL.
88:             ENDIF
89:         CATCH TO loc_oErro
90:             MsgErro("Erro ao destruir FormFct:" + CHR(13) + loc_oErro.Message, "Erro")
91:         ENDTRY
92:         DODEFAULT()
93:     ENDPROC
94: 
95:     *--------------------------------------------------------------------------
96:     PROTECTED PROCEDURE ConfigurarPageFrame()
97:     *--------------------------------------------------------------------------
98:         LOCAL loc_lResultado
99:         loc_lResultado = .F.
100:         TRY
101:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
102:             WITH THIS.pgf_4c_Paginas
103:                 .Top       = -29
104:                 .Left      = 0
105:                 .Width     = THIS.Width
106:                 .Height    = THIS.Height + 29
107:                 .Tabs      = .F.
108:                 .PageCount = 2
109:                 .Page1.Caption = "Lista"
110:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:                 .Page2.Caption = "Dados"
112:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:                 .Visible   = .T.
114:             ENDWITH
115:             THIS.ConfigurarPaginaLista()
116:             THIS.ConfigurarPaginaDados()
117:             loc_lResultado = .T.
118:         CATCH TO loc_oErro
119:             MsgErro("Erro em ConfigurarPageFrame:" + CHR(13) + loc_oErro.Message, "Erro")
120:         ENDTRY
121:         RETURN loc_lResultado
122:     ENDPROC
123: 
124:     *--------------------------------------------------------------------------
125:     PROTECTED PROCEDURE ConfigurarPaginaLista()
126:     *--------------------------------------------------------------------------
127:         LOCAL loc_lResultado, loc_oPag
128:         loc_lResultado = .F.
129:         TRY
130:             loc_oPag = THIS.pgf_4c_Paginas.Page1
131: 
132:             loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
133:             WITH loc_oPag.cnt_4c_Cabecalho
134:                 .Top       = 30
135:                 .Left      = 0
136:                 .Width     = THIS.Width
137:                 .Height    = 30
138:                 .BackStyle = 1
139:                 .BackColor = RGB(64, 64, 64)
140:                 .Visible   = .T.
141:                 .AddObject("lbl_4c_Titulo", "Label")
142:                 WITH .lbl_4c_Titulo
143:                     .Top       = 0
144:                     .Left      = 0
145:                     .Width     = THIS.Width
146:                     .Height    = 30
147:                     .AutoSize  = .F.
148:                     .BackStyle = 0
149:                     .ForeColor = RGB(255, 255, 255)
150:                     .FontSize  = 12
151:                     .FontBold  = .T.
152:                     DO CASE
153:                     CASE THIS.this_nTipo = 1
154:                         .Caption = "  Perfis de Contas"
155:                     CASE THIS.this_nTipo = 2
156:                         .Caption = "  Movimenta" + CHR(231) + CHR(227) + "o"
157:                     OTHERWISE
158:                         .Caption = "  Fichas T" + CHR(233) + "cnicas de Produtos"
159:                     ENDCASE
160:                     .Visible   = .T.
161:                 ENDWITH
162:             ENDWITH
163: 
164:             loc_oPag.AddObject("cnt_4c_Botoes", "Container")
165:             WITH loc_oPag.cnt_4c_Botoes

*-- Linhas 396 a 456:
396:             loc_oPag.grd_4c_Lista.SetAll("DynamicBackColor", ;
397:                 "IIF(EMPTY(crDados.TemDados), RGB(255,255,255), RGB(255,255,187))", "Column")
398: 
399:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
400:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
401:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
402:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
403:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
404:             BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
405:             BINDEVENT(loc_oPag.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
406: 
407:             THIS.TornarControlesVisiveis(loc_oPag)
408:             loc_lResultado = .T.
409:         CATCH TO loc_oErro
410:             MsgErro("Erro em ConfigurarPaginaLista:" + CHR(13) + loc_oErro.Message, "Erro")
411:         ENDTRY
412:         RETURN loc_lResultado
413:     ENDPROC
414: 
415:     *--------------------------------------------------------------------------
416:     PROTECTED PROCEDURE ConfigurarPaginaDados()
417:     *--------------------------------------------------------------------------
418:         LOCAL loc_lResultado, loc_oPag
419:         loc_lResultado = .F.
420:         TRY
421:             loc_oPag = THIS.pgf_4c_Paginas.Page2
422: 
423:             loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
424:             WITH loc_oPag.cnt_4c_BotoesAcao
425:                 .Top       = 38
426:                 .Left      = 820
427:                 .Width     = 160
428:                 .Height    = 85
429:                 .BackStyle = 1
430:                 .BackColor = RGB(255, 255, 255)
431:                 .Visible   = .T.
432:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
433:                 WITH .cmd_4c_Confirmar
434:                     .Top             = 5
435:                     .Left            = 5
436:                     .Width           = 70
437:                     .Height          = 75
438:                     .Caption         = "Confirmar"
439:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
440:                     .PicturePosition = 13
441:                     .FontName        = "Comic Sans MS"
442:                     .FontBold        = .T.
443:                     .FontItalic      = .T.
444:                     .FontSize        = 8
445:                     .ForeColor       = RGB(90, 90, 90)
446:                     .BackColor       = RGB(255, 255, 255)
447:                     .SpecialEffect   = 0
448:                     .MousePointer    = 15
449:                     .WordWrap        = .T.
450:                     .AutoSize        = .F.
451:                     .Visible         = .T.
452:                 ENDWITH
453:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
454:                 WITH .cmd_4c_Cancelar
455:                     .Top             = 5
456:                     .Left            = 80

*-- Linhas 490 a 545:
490:             THIS.ConfigurarPgFicha()
491:             THIS.ConfigurarPgCompl()
492: 
493:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
494:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
495: 
496:             THIS.TornarControlesVisiveis(loc_oPag)
497:             loc_lResultado = .T.
498:         CATCH TO loc_oErro
499:             MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message, "Erro")
500:         ENDTRY
501:         RETURN loc_lResultado
502:     ENDPROC
503: 
504:     *--------------------------------------------------------------------------
505:     PROTECTED PROCEDURE ConfigurarPgFicha()
506:     *--------------------------------------------------------------------------
507:         LOCAL loc_lResultado, loc_oPg
508:         loc_lResultado = .F.
509:         TRY
510:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
511: 
512:             loc_oPg.AddObject("lbl_4c_LabelGrupo", "Label")
513:             WITH loc_oPg.lbl_4c_LabelGrupo
514:                 .Top      = 20
515:                 .Left     = 55
516:                 .Width    = 40
517:                 .Height   = 18
518:                 .AutoSize = .F.
519:                 .Caption  = "Grupo :"
520:                 .Visible  = .T.
521:             ENDWITH
522: 
523:             loc_oPg.AddObject("txt_4c_CGrus", "TextBox")
524:             WITH loc_oPg.txt_4c_CGrus
525:                 .Top           = 17
526:                 .Left          = 98
527:                 .Width         = 80
528:                 .Height        = 20
529:                 .Enabled       = .F.
530:                 .ControlSource = "crFichaCab.CGrus"
531:                 .Visible       = .T.
532:             ENDWITH
533: 
534:             loc_oPg.AddObject("txt_4c_DGrus", "TextBox")
535:             WITH loc_oPg.txt_4c_DGrus
536:                 .Top           = 17
537:                 .Left          = 180
538:                 .Width         = 290
539:                 .Height        = 20
540:                 .Enabled       = .F.
541:                 .ControlSource = "crFichaCab.DGrus"
542:                 .Visible       = .T.
543:             ENDWITH
544: 
545:             loc_oPg.AddObject("lbl_4c_LabelSGrus", "Label")

*-- Linhas 586 a 697:
586:                 .Visible  = (THIS.this_nTipo = 0)
587:             ENDWITH
588: 
589:             loc_oPg.AddObject("opt_4c_NChkDims", "OptionGroup")
590:             WITH loc_oPg.opt_4c_NChkDims
591:                 .Top           = 10
592:                 .Left          = 729
593:                 .Width         = 180
594:                 .Height        = 16
595:                 .ButtonCount   = 2
596:                 .Value         = 1
597:                 .ControlSource = "crFichaCab.nChkDims"
598:                 .Visible       = (THIS.this_nTipo = 0)
599:                 WITH .Buttons(1)
600:                     .Caption   = "Sim"
601:                     .Width     = 50
602:                     .BackStyle = 0
603:                 ENDWITH
604:                 WITH .Buttons(2)
605:                     .Caption   = "N" + CHR(227) + "o"
606:                     .Left      = 55
607:                     .Width     = 60
608:                     .BackStyle = 0
609:                 ENDWITH
610:             ENDWITH
611: 
612:             loc_oPg.AddObject("lbl_4c_LabelChkTems", "Label")
613:             WITH loc_oPg.lbl_4c_LabelChkTems
614:                 .Top      = 29
615:                 .Left     = 620
616:                 .Width    = 105
617:                 .Height   = 18
618:                 .AutoSize = .F.
619:                 .Caption  = "Tempos :"
620:                 .Visible  = (THIS.this_nTipo = 0)
621:             ENDWITH
622: 
623:             loc_oPg.AddObject("opt_4c_NChkTems", "OptionGroup")
624:             WITH loc_oPg.opt_4c_NChkTems
625:                 .Top           = 29
626:                 .Left          = 729
627:                 .Width         = 180
628:                 .Height        = 16
629:                 .ButtonCount   = 2
630:                 .Value         = 1
631:                 .ControlSource = "crFichaCab.nChkTems"
632:                 .Visible       = (THIS.this_nTipo = 0)
633:                 WITH .Buttons(1)
634:                     .Caption   = "Sim"
635:                     .Width     = 50
636:                     .BackStyle = 0
637:                 ENDWITH
638:                 WITH .Buttons(2)
639:                     .Caption   = "N" + CHR(227) + "o"
640:                     .Left      = 55
641:                     .Width     = 60
642:                     .BackStyle = 0
643:                 ENDWITH
644:             ENDWITH
645: 
646:             loc_oPg.AddObject("lbl_4c_LabelChkPess", "Label")
647:             WITH loc_oPg.lbl_4c_LabelChkPess
648:                 .Top      = 49
649:                 .Left     = 620
650:                 .Width    = 105
651:                 .Height   = 18
652:                 .AutoSize = .F.
653:                 .Caption  = "Pessoas :"
654:                 .Visible  = (THIS.this_nTipo = 0)
655:             ENDWITH
656: 
657:             loc_oPg.AddObject("opt_4c_NChkPess", "OptionGroup")
658:             WITH loc_oPg.opt_4c_NChkPess
659:                 .Top           = 49
660:                 .Left          = 729
661:                 .Width         = 180
662:                 .Height        = 16
663:                 .ButtonCount   = 2
664:                 .Value         = 1
665:                 .ControlSource = "crFichaCab.nChkPess"
666:                 .Visible       = (THIS.this_nTipo = 0)
667:                 WITH .Buttons(1)
668:                     .Caption   = "Sim"
669:                     .Width     = 50
670:                     .BackStyle = 0
671:                 ENDWITH
672:                 WITH .Buttons(2)
673:                     .Caption   = "N" + CHR(227) + "o"
674:                     .Left      = 55
675:                     .Width     = 60
676:                     .BackStyle = 0
677:                 ENDWITH
678:             ENDWITH
679: 
680:             loc_oPg.AddObject("grd_4c_Fichas", "Grid")
681:             loc_oPg.grd_4c_Fichas.ColumnCount = 9
682:             WITH loc_oPg.grd_4c_Fichas
683:                 .Top          = 75
684:                 .Left         = 12
685:                 .Width        = 933
686:                 .Height       = 309
687:                 .HeaderHeight = 18
688:                 .RecordSource = "crFichaTec"
689:                 .ReadOnly     = .F.
690:                 .GridLines    = 1
691:                 .DeleteMark   = .F.
692:                 .RecordMark   = .F.
693:                 .Visible      = .T.
694:                 WITH .Column1
695:                     .Width           = 200
696:                     .ControlSource   = "crFichaTec.CCars"
697:                     .Header1.Caption = "Caracter" + CHR(237) + "stica"

*-- Linhas 729 a 772:
729:                     .Header1.Caption = "Caixa"
730:                     .Sparse         = .F.
731:                     .CurrentControl = "opt_4c_NChkCxas"
732:                     .AddObject("opt_4c_NChkCxas", "OptionGroup")
733:                     WITH .opt_4c_NChkCxas
734:                         .ButtonCount = 3
735:                         .Value       = 1
736:                         .Height      = 16
737:                         .Width       = 241
738:                         WITH .Buttons(1)
739:                             .Caption   = "Maiusculo"
740:                             .Width     = 74
741:                             .BackStyle = 0
742:                         ENDWITH
743:                         WITH .Buttons(2)
744:                             .Caption   = "Minusculo"
745:                             .Left      = 80
746:                             .Width     = 74
747:                             .BackStyle = 0
748:                         ENDWITH
749:                         WITH .Buttons(3)
750:                             .Caption   = "Livre"
751:                             .Left      = 160
752:                             .BackStyle = 0
753:                         ENDWITH
754:                     ENDWITH
755:                 ENDWITH
756:                 WITH .Column8
757:                     .Width           = 25
758:                     .ControlSource   = "crFichaTec.cSelecaos"
759:                     .Header1.Caption = "S"
760:                 ENDWITH
761:                 WITH .Column9
762:                     .Width           = 25
763:                     .ControlSource   = "crFichaTec.cTpDados"
764:                     .Header1.Caption = "T"
765:                 ENDWITH
766:             ENDWITH
767: 
768:             loc_oPg.AddObject("cmd_4c_ApagarLinha", "CommandButton")
769:             WITH loc_oPg.cmd_4c_ApagarLinha
770:                 .Top     = 235
771:                 .Left    = 949
772:                 .Width   = 40

*-- Linhas 887 a 970:
887:                 ENDWITH
888:             ENDWITH
889: 
890:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column1.Text1, "Valid",    THIS, "ValidCCarsGrid")
891:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column2.Text1, "Valid",    THIS, "ValidCTitsGrid")
892:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "KeyPress", THIS, "KeyPressCTpDados")
893:             BINDEVENT(loc_oPg.cmd_4c_ApagarLinha,  "Click", THIS, "BtnApagarLinhaClick")
894:             BINDEVENT(loc_oPg.cmd_4c_Respostas,    "Click", THIS, "BtnRespostasClick")
895:             BINDEVENT(loc_oPg.cmd_4c_CopiaFicha,   "Click", THIS, "BtnCopiaFichaClick")
896:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus,      "KeyPress", THIS, "ValidCpyCGrus")
897:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_ConfirmarCopia, "Click", THIS, "BtnConfirmarCopiaClick")
898:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_CancelarCopia,  "Click", THIS, "BtnCancelarCopiaClick")
899:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus,      "KeyPress", THIS, "ValidCpySGrus")
900:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column8.Text1, "Valid", THIS, "ValidCSelecaos")
901:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "Valid", THIS, "ValidCTpDados")
902: 
903:             THIS.TornarControlesVisiveis(loc_oPg)
904:             loc_lResultado = .T.
905:         CATCH TO loc_oErro
906:             MsgErro("Erro em ConfigurarPgFicha:" + CHR(13) + loc_oErro.Message, "Erro")
907:         ENDTRY
908:         RETURN loc_lResultado
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     PROTECTED PROCEDURE ConfigurarPgCompl()
913:     *--------------------------------------------------------------------------
914:         LOCAL loc_lResultado, loc_oPg
915:         loc_lResultado = .F.
916:         TRY
917:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
918: 
919:             loc_oPg.AddObject("lbl_4c_LabelImagem", "Label")
920:             WITH loc_oPg.lbl_4c_LabelImagem
921:                 .Top      = 63
922:                 .Left     = 328
923:                 .Width    = 200
924:                 .Height   = 18
925:                 .AutoSize = .F.
926:                 .Caption  = "Imagem da Impress" + CHR(227) + "o :"
927:                 .Visible  = (THIS.this_nTipo = 0)
928:             ENDWITH
929: 
930:             loc_oPg.AddObject("opt_4c_NChkImps", "OptionGroup")
931:             WITH loc_oPg.opt_4c_NChkImps
932:                 .Top           = 58
933:                 .Left          = 442
934:                 .Width         = 165
935:                 .Height        = 16
936:                 .ButtonCount   = 2
937:                 .Value         = 1
938:                 .ControlSource = "crFichaCab.nChkImps"
939:                 .Visible       = (THIS.this_nTipo = 0)
940:                 WITH .Buttons(1)
941:                     .Caption   = "Produtos"
942:                     .Width     = 70
943:                     .BackStyle = 0
944:                 ENDWITH
945:                 WITH .Buttons(2)
946:                     .Caption   = "Ficha T" + CHR(233) + "cnica"
947:                     .Left      = 75
948:                     .Width     = 90
949:                     .BackStyle = 0
950:                 ENDWITH
951:             ENDWITH
952: 
953:             loc_oPg.AddObject("chk_4c_NFixFigs", "CheckBox")
954:             WITH loc_oPg.chk_4c_NFixFigs
955:                 .Top           = 50
956:                 .Left          = 617
957:                 .Width         = 40
958:                 .Height        = 40
959:                 .Style         = 1
960:                 .Caption       = ""
961:                 .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
962:                 .ControlSource = "crFichaCab.nFixFigs"
963:                 .Themes        = .T.
964:                 .Visible       = (THIS.this_nTipo = 0)
965:             ENDWITH
966: 
967:             loc_oPg.AddObject("img_4c_FigTec", "Image")
968:             WITH loc_oPg.img_4c_FigTec
969:                 .Top     = 94
970:                 .Left    = 301

*-- Linhas 998 a 1114:
998:                 .Visible = .T.
999:             ENDWITH
1000: 
1001:             BINDEVENT(loc_oPg.cmd_4c_Figura,      "Click", THIS, "BtnFiguraClick")
1002:             BINDEVENT(loc_oPg.cmd_4c_VoltarFicha, "Click", THIS, "BtnVoltarFichaClick")
1003: 
1004:             THIS.TornarControlesVisiveis(loc_oPg)
1005:             loc_lResultado = .T.
1006:         CATCH TO loc_oErro
1007:             MsgErro("Erro em ConfigurarPgCompl:" + CHR(13) + loc_oErro.Message, "Erro")
1008:         ENDTRY
1009:         RETURN loc_lResultado
1010:     ENDPROC
1011: 
1012:     *--------------------------------------------------------------------------
1013:     PROCEDURE CarregarLista()
1014:     *--------------------------------------------------------------------------
1015:         LOCAL loc_lResultado
1016:         loc_lResultado = .F.
1017:         TRY
1018:             THIS.this_oBusinessObject.Buscar("")
1019:             IF USED("crDados")
1020:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1021:             ENDIF
1022:             loc_lResultado = .T.
1023:         CATCH TO loc_oErro
1024:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
1025:         ENDTRY
1026:         RETURN loc_lResultado
1027:     ENDPROC
1028: 
1029:     *--------------------------------------------------------------------------
1030:     PROTECTED PROCEDURE IrParaLista()
1031:     *--------------------------------------------------------------------------
1032:         THIS.this_cModoAtual = "LISTA"
1033:         THIS.pgf_4c_Paginas.Visible = .T.
1034:         THIS.pgf_4c_Paginas.ActivePage = 1
1035:         IF USED("crDados")
1036:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1037:         ENDIF
1038:     ENDPROC
1039: 
1040:     *--------------------------------------------------------------------------
1041:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1042:     *--------------------------------------------------------------------------
1043:         LOCAL loc_lResultado
1044:         loc_lResultado = .F.
1045:         TRY
1046:             IF par_nPagina = 1
1047:                 THIS.IrParaLista()
1048:                 loc_lResultado = .T.
1049:             ELSE
1050:                 IF par_nPagina = 2
1051:                 THIS.pgf_4c_Paginas.ActivePage = 2
1052:                 loc_lResultado = .T.
1053:                 ENDIF
1054:             ENDIF
1055:         CATCH TO loc_oErro
1056:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
1057:         ENDTRY
1058:         RETURN loc_lResultado
1059:     ENDPROC
1060: 
1061:     *--------------------------------------------------------------------------
1062:     PROTECTED PROCEDURE CarregarDados()
1063:     *--------------------------------------------------------------------------
1064:     LPARAMETERS par_cModo
1065:         LOCAL loc_lResultado, loc_cCGrus, loc_cSGrus, loc_cDGrus, loc_cDSGru
1066:         LOCAL loc_lReadOnly, loc_oPg, loc_oPg2, loc_cArqTemp, loc_cExt
1067:         loc_lResultado = .F.
1068:         TRY
1069:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1070:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1071:             ELSE
1072:                 SELECT crDados
1073:                 IF EOF()
1074:                     MsgAviso("Selecione um registro na lista.", "Aviso")
1075:                 ELSE
1076:                     loc_cCGrus = ALLTRIM(crDados.CGrus)
1077:                     loc_cSGrus = ALLTRIM(crDados.SGrus)
1078:                     loc_cDGrus = ALLTRIM(crDados.DGrus)
1079:                     loc_cDSGru = ALLTRIM(crDados.DSGru)
1080: 
1081:             THIS.this_cModoAtual = par_cModo
1082:             THIS.this_oBusinessObject.CarregarFicha(loc_cCGrus, loc_cSGrus, ;
1083:                 loc_cDGrus, loc_cDSGru, par_cModo)
1084: 
1085:             IF par_cModo = "ALTERAR"
1086:                 THIS.this_oBusinessObject.CarregarFiltroGrupos()
1087:             ENDIF
1088: 
1089:             loc_lReadOnly = (par_cModo = "VISUALIZAR" OR par_cModo = "EXCLUIR")
1090:             THIS.HabilitarCampos(!loc_lReadOnly)
1091:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1092:             loc_oPg.grd_4c_Fichas.ReadOnly     = loc_lReadOnly
1093:             loc_oPg.cmd_4c_ApagarLinha.Visible  = (par_cModo = "ALTERAR")
1094:             loc_oPg.cmd_4c_CopiaFicha.Visible   = (par_cModo = "ALTERAR")
1095:             loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1096: 
1097:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1098:             loc_oPg2.cmd_4c_Figura.Visible = (par_cModo = "ALTERAR")
1099: 
1100:             IF USED("crFichaCab") AND !EOF("crFichaCab")
1101:                 IF !EMPTY(crFichaCab.mFicTecs)
1102:                     loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + ".jpg"
1103:                     STRTOFILE(crFichaCab.mFicTecs, loc_cArqTemp)
1104:                     IF FILE(loc_cArqTemp)
1105:                         loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
1106:                         loc_oPg2.img_4c_FigTec.Visible = .T.
1107:                     ELSE
1108:                         loc_oPg2.img_4c_FigTec.Visible = .F.
1109:                     ENDIF
1110:                 ELSE
1111:                     loc_oPg2.img_4c_FigTec.Picture = ""
1112:                     loc_oPg2.img_4c_FigTec.Visible = .F.
1113:                 ENDIF
1114:             ENDIF

*-- Linhas 1126 a 1973:
1126:     ENDPROC
1127: 
1128:     *--------------------------------------------------------------------------
1129:     PROCEDURE BtnIncluirClick()
1130:     *--------------------------------------------------------------------------
1131:         LOCAL loc_lResultado
1132:         loc_lResultado = .F.
1133:         TRY
1134:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1135:                 MsgAviso("Selecione um grupo na lista.", "Aviso")
1136:             ELSE
1137:                 SELECT crDados
1138:                 IF EOF()
1139:                     MsgAviso("Selecione um grupo na lista.", "Aviso")
1140:                 ELSE
1141:                     IF !EMPTY(ALLTRIM(crDados.TemDados))
1142:                     MsgAviso("Este grupo j" + CHR(225) + " possui ficha t" + CHR(233) + ;
1143:                         "cnica. Use Alterar para modificar.", "Aviso")
1144:                 ELSE
1145:                     loc_lResultado = THIS.CarregarDados("ALTERAR")
1146:                     ENDIF
1147:                 ENDIF
1148:             ENDIF
1149:         CATCH TO loc_oErro
1150:             MsgErro("Erro ao incluir ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1151:         ENDTRY
1152:         RETURN loc_lResultado
1153:     ENDPROC
1154: 
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE BtnVisualizarClick()
1157:     *--------------------------------------------------------------------------
1158:         THIS.CarregarDados("VISUALIZAR")
1159:     ENDPROC
1160: 
1161:     *--------------------------------------------------------------------------
1162:     PROCEDURE BtnAlterarClick()
1163:     *--------------------------------------------------------------------------
1164:         THIS.CarregarDados("ALTERAR")
1165:     ENDPROC
1166: 
1167:     *--------------------------------------------------------------------------
1168:     PROCEDURE BtnExcluirClick()
1169:     *--------------------------------------------------------------------------
1170:         THIS.CarregarDados("EXCLUIR")
1171:     ENDPROC
1172: 
1173:     *--------------------------------------------------------------------------
1174:     PROCEDURE BtnBuscarClick()
1175:     *--------------------------------------------------------------------------
1176:         LOCAL loc_lResultado, loc_cBusca
1177:         loc_lResultado = .F.
1178:         TRY
1179:             loc_cBusca = INPUTBOX("Descri" + CHR(231) + CHR(227) + "o:", "Buscar", "")
1180:             THIS.this_oBusinessObject.Buscar(loc_cBusca)
1181:             IF USED("crDados")
1182:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1183:             ENDIF
1184:             loc_lResultado = .T.
1185:         CATCH TO loc_oErro
1186:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
1187:         ENDTRY
1188:         RETURN loc_lResultado
1189:     ENDPROC
1190: 
1191:     *--------------------------------------------------------------------------
1192:     PROCEDURE BtnEncerrarClick()
1193:     *--------------------------------------------------------------------------
1194:         THIS.Release()
1195:     ENDPROC
1196: 
1197:     *--------------------------------------------------------------------------
1198:     PROCEDURE BtnConfirmarClick()
1199:     *--------------------------------------------------------------------------
1200:         LOCAL loc_lResultado
1201:         loc_lResultado = .F.
1202:         TRY
1203:             DO CASE
1204:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1205:                 THIS.IrParaLista()
1206:                 loc_lResultado = .T.
1207: 
1208:             CASE THIS.this_cModoAtual = "ALTERAR"
1209:                 IF THIS.this_oBusinessObject.ValidarFichaTec()
1210:                     IF THIS.this_oBusinessObject.AtualizarGrupoFicha("ALTERAR")
1211:                         THIS.CarregarLista()
1212:                         THIS.IrParaLista()
1213:                         loc_lResultado = .T.
1214:                     ENDIF
1215:                 ENDIF
1216: 
1217:             CASE THIS.this_cModoAtual = "EXCLUIR"
1218:                 IF THIS.this_oBusinessObject.VerificarExcluirFicha()
1219:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da ficha t" + ;
1220:                             CHR(233) + "cnica?", "Confirmar")
1221:                         IF THIS.this_oBusinessObject.AtualizarGrupoFicha("EXCLUIR")
1222:                             THIS.CarregarLista()
1223:                             THIS.IrParaLista()
1224:                             loc_lResultado = .T.
1225:                         ENDIF
1226:                     ENDIF
1227:                 ENDIF
1228:             ENDCASE
1229:         CATCH TO loc_oErro
1230:             MsgErro("Erro ao confirmar:" + CHR(13) + loc_oErro.Message, "Erro")
1231:         ENDTRY
1232:         RETURN loc_lResultado
1233:     ENDPROC
1234: 
1235:     *--------------------------------------------------------------------------
1236:     PROCEDURE BtnCancelarClick()
1237:     *--------------------------------------------------------------------------
1238:         THIS.IrParaLista()
1239:     ENDPROC
1240: 
1241:     *--------------------------------------------------------------------------
1242:     PROCEDURE BtnApagarLinhaClick()
1243:     *--------------------------------------------------------------------------
1244:         LOCAL loc_lResultado
1245:         loc_lResultado = .F.
1246:         TRY
1247:             IF USED("crFichaTec")
1248:                 SELECT crFichaTec
1249:                 IF !EOF() AND RECCOUNT() > 0
1250:                     IF MsgConfirma("Apagar esta linha da ficha t" + CHR(233) + "cnica?", "Confirmar")
1251:                         DELETE
1252:                         PACK
1253:                         SELECT crFichaTec
1254:                         GO TOP
1255:                         IF EOF()
1256:                             THIS.this_oBusinessObject.AdicionarLinhaFicha()
1257:                             SELECT crFichaTec
1258:                             GO TOP
1259:                         ENDIF
1260:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1261:                         loc_lResultado = .T.
1262:                     ENDIF
1263:                 ENDIF
1264:             ENDIF
1265:         CATCH TO loc_oErro
1266:             MsgErro("Erro ao apagar linha:" + CHR(13) + loc_oErro.Message, "Erro")
1267:         ENDTRY
1268:         RETURN loc_lResultado
1269:     ENDPROC
1270: 
1271:     *--------------------------------------------------------------------------
1272:     PROCEDURE BtnRespostasClick()
1273:     *--------------------------------------------------------------------------
1274:         LOCAL loc_lResultado, loc_cFormFte, loc_cCCars, loc_cCTits, loc_cCGrus, loc_cSGrus
1275:         loc_lResultado = .F.
1276:         TRY
1277:             loc_cFormFte = gc_4c_CaminhoForms + "cadastros\FormFte.prg"
1278:             IF !FILE(loc_cFormFte)
1279:                 MsgAviso("Formul" + CHR(225) + "rio de respostas n" + CHR(227) + ;
1280:                     "o dispon" + CHR(237) + "vel.", "Aviso")
1281:             ELSE
1282:                 IF USED("crFichaTec")
1283:                     SELECT crFichaTec
1284:                     IF !EOF()
1285:                         loc_cCCars = ALLTRIM(crFichaTec.CCars)
1286:                         loc_cCTits = ALLTRIM(crFichaTec.CTits)
1287:                         IF EMPTY(loc_cCCars)
1288:                             MsgAviso("Selecione uma caracter" + CHR(237) + "stica na grade.", "Aviso")
1289:                         ELSE
1290:                             SELECT crFichaCab
1291:                             loc_cCGrus = ALLTRIM(crFichaCab.CGrus)
1292:                             loc_cSGrus = ALLTRIM(crFichaCab.SGrus)
1293:                             DO FORM (gc_4c_CaminhoForms + "cadastros\FormFte") ;
1294:                                 WITH loc_cCGrus, loc_cSGrus, loc_cCCars, loc_cCTits
1295:                             loc_lResultado = .T.
1296:                         ENDIF
1297:                     ENDIF
1298:                 ENDIF
1299:             ENDIF
1300:         CATCH TO loc_oErro
1301:             MsgErro("Erro ao abrir respostas:" + CHR(13) + loc_oErro.Message, "Erro")
1302:         ENDTRY
1303:         RETURN loc_lResultado
1304:     ENDPROC
1305: 
1306:     *--------------------------------------------------------------------------
1307:     PROCEDURE BtnCopiaFichaClick()
1308:     *--------------------------------------------------------------------------
1309:         LOCAL loc_lResultado, loc_oPg
1310:         loc_lResultado = .F.
1311:         TRY
1312:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1313:             IF loc_oPg.cnt_4c_CopiarAcesso.Visible
1314:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1315:             ELSE
1316:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1317:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1318:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1319:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1320:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .T.
1321:             ENDIF
1322:             loc_lResultado = .T.
1323:         CATCH TO loc_oErro
1324:             MsgErro("Erro ao alternar c" + CHR(243) + "pia:" + CHR(13) + loc_oErro.Message, "Erro")
1325:         ENDTRY
1326:         RETURN loc_lResultado
1327:     ENDPROC
1328: 
1329:     *--------------------------------------------------------------------------
1330:     PROCEDURE BtnConfirmarCopiaClick()
1331:     *--------------------------------------------------------------------------
1332:         LOCAL loc_lResultado, loc_oPg, loc_cCGrusSrc, loc_cSGrusSrc
1333:         LOCAL loc_cSql, loc_nSql
1334:         loc_lResultado = .F.
1335:         TRY
1336:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1337:             loc_cCGrusSrc = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
1338:             loc_cSGrusSrc = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value)
1339:             IF EMPTY(loc_cCGrusSrc)
1340:                 MsgAviso("Informe o grupo de origem.", "Aviso")
1341:             ELSE
1342:                 loc_cSql = "SELECT CCars, CTits, COrds, CLins, Maxs, Mins, " + ;
1343:                            "nChkCxas, cSelecaos, cTpDados " + ;
1344:                            "FROM SigCdFtc WHERE CGrus = " + EscaparSQL(loc_cCGrusSrc)
1345:                 IF THIS.this_nTipo = 0 AND !EMPTY(loc_cSGrusSrc)
1346:                     loc_cSql = loc_cSql + " AND SGrus = " + EscaparSQL(loc_cSGrusSrc)
1347:                 ENDIF
1348:                 loc_cSql = loc_cSql + " ORDER BY COrds"
1349: 
1350:                 IF USED("cursor_4c_CopiaFtc")
1351:                     USE IN cursor_4c_CopiaFtc
1352:                 ENDIF
1353:                 loc_nSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CopiaFtc")
1354:                 IF loc_nSql <= 0
1355:                     MsgErro("Erro ao buscar ficha de origem.", "Erro")
1356:                 ELSE
1357:                     IF RECCOUNT("cursor_4c_CopiaFtc") = 0
1358:                         USE IN cursor_4c_CopiaFtc
1359:                         MsgAviso("Grupo de origem n" + CHR(227) + "o possui ficha t" + ;
1360:                             CHR(233) + "cnica.", "Aviso")
1361:                     ELSE
1362:                         SELECT crFichaTec
1363:                         ZAP
1364:                         SELECT cursor_4c_CopiaFtc
1365:                         SCAN
1366:                             SELECT crFichaTec
1367:                             APPEND BLANK
1368:                             REPLACE crFichaTec.CCars     WITH ALLTRIM(cursor_4c_CopiaFtc.CCars)
1369:                             REPLACE crFichaTec.CTits     WITH ALLTRIM(cursor_4c_CopiaFtc.CTits)
1370:                             REPLACE crFichaTec.COrds     WITH cursor_4c_CopiaFtc.COrds
1371:                             REPLACE crFichaTec.CLins     WITH cursor_4c_CopiaFtc.CLins
1372:                             REPLACE crFichaTec.Maxs      WITH cursor_4c_CopiaFtc.Maxs
1373:                             REPLACE crFichaTec.Mins      WITH cursor_4c_CopiaFtc.Mins
1374:                             REPLACE crFichaTec.nChkCxas  WITH cursor_4c_CopiaFtc.nChkCxas
1375:                             REPLACE crFichaTec.cSelecaos WITH cursor_4c_CopiaFtc.cSelecaos
1376:                             REPLACE crFichaTec.cTpDados  WITH cursor_4c_CopiaFtc.cTpDados
1377:                             SELECT cursor_4c_CopiaFtc
1378:                         ENDSCAN
1379:                         USE IN cursor_4c_CopiaFtc
1380: 
1381:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1382:                         loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1383:                         loc_oPg.grd_4c_Fichas.Refresh()
1384:                         loc_lResultado = .T.
1385:                     ENDIF
1386:                 ENDIF
1387:             ENDIF
1388:         CATCH TO loc_oErro
1389:             MsgErro("Erro ao copiar ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1390:         ENDTRY
1391:         RETURN loc_lResultado
1392:     ENDPROC
1393: 
1394:     *--------------------------------------------------------------------------
1395:     PROCEDURE BtnCancelarCopiaClick()
1396:     *--------------------------------------------------------------------------
1397:         LOCAL loc_oPg
1398:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1399:         loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1400:     ENDPROC
1401: 
1402:     *--------------------------------------------------------------------------
1403:     PROCEDURE BtnFiguraClick()
1404:     *--------------------------------------------------------------------------
1405:         LOCAL loc_lResultado, loc_cArqFig, loc_cConteudo, loc_cArqTemp, loc_cExt, loc_oPg2
1406:         loc_lResultado = .F.
1407:         TRY
1408:             loc_cArqFig = GETPICT("jpg,bmp", "Selecione a imagem da ficha t" + CHR(233) + "cnica")
1409:             IF !EMPTY(loc_cArqFig) AND FILE(loc_cArqFig)
1410:                 loc_cConteudo = FILETOSTR(loc_cArqFig)
1411:                 IF USED("crFichaCab")
1412:                     SELECT crFichaCab
1413:                     REPLACE crFichaCab.mFicTecs WITH loc_cConteudo
1414:                 ENDIF
1415:                 loc_cExt     = LOWER(JUSTEXT(loc_cArqFig))
1416:                 loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + "." + loc_cExt
1417:                 STRTOFILE(loc_cConteudo, loc_cArqTemp)
1418:                 IF FILE(loc_cArqTemp)
1419:                     loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1420:                     loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
1421:                     loc_oPg2.img_4c_FigTec.Visible = .T.
1422:                 ENDIF
1423:                 loc_lResultado = .T.
1424:             ENDIF
1425:         CATCH TO loc_oErro
1426:             MsgErro("Erro ao carregar figura:" + CHR(13) + loc_oErro.Message, "Erro")
1427:         ENDTRY
1428:         RETURN loc_lResultado
1429:     ENDPROC
1430: 
1431:     *--------------------------------------------------------------------------
1432:     PROCEDURE BtnVoltarFichaClick()
1433:     *--------------------------------------------------------------------------
1434:         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.ActivePage = 1
1435:     ENDPROC
1436: 
1437:     *--------------------------------------------------------------------------
1438:     PROCEDURE ValidCCarsGrid()
1439:     *--------------------------------------------------------------------------
1440:         LOCAL loc_lResultado, loc_cCCars, loc_nSql, loc_oForm
1441:         loc_lResultado = .T.
1442:         TRY
1443:             IF USED("crFichaTec")
1444:                 SELECT crFichaTec
1445:                 IF !EOF()
1446:                     loc_cCCars = ALLTRIM(crFichaTec.CCars)
1447:                     IF !EMPTY(loc_cCCars)
1448:                         IF USED("cursor_4c_BuscaCCars")
1449:                             USE IN cursor_4c_BuscaCCars
1450:                         ENDIF
1451:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1452:                             "SELECT CCars, DCars FROM SigCrRaP WHERE CCars = " + EscaparSQL(loc_cCCars), ;
1453:                             "cursor_4c_BuscaCCars")
1454:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCCars") > 0
1455:                             USE IN cursor_4c_BuscaCCars
1456:                         ELSE
1457:                             IF USED("cursor_4c_BuscaCCars")
1458:                                 USE IN cursor_4c_BuscaCCars
1459:                             ENDIF
1460:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1461:                                 "SigCrRaP", "cursor_4c_BuscaCCars", "CCars", loc_cCCars, ;
1462:                                 "Caracter" + CHR(237) + "sticas")
1463:                             IF !ISNULL(loc_oForm)
1464:                                 IF !loc_oForm.this_lAchouRegistro
1465:                                     loc_oForm.mAddColuna("CCars", "", "C" + CHR(243) + "digo")
1466:                                     loc_oForm.mAddColuna("DCars", "", "Descri" + CHR(231) + CHR(227) + "o")
1467:                                     loc_oForm.Show()
1468:                                 ENDIF
1469:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCCars")
1470:                                     SELECT crFichaTec
1471:                                     REPLACE crFichaTec.CCars WITH ALLTRIM(cursor_4c_BuscaCCars.CCars)
1472:                                     USE IN cursor_4c_BuscaCCars
1473:                                 ELSE
1474:                                     SELECT crFichaTec
1475:                                     REPLACE crFichaTec.CCars WITH ""
1476:                                     IF USED("cursor_4c_BuscaCCars")
1477:                                         USE IN cursor_4c_BuscaCCars
1478:                                     ENDIF
1479:                                 ENDIF
1480:                                 loc_oForm.Release()
1481:                             ENDIF
1482:                         ENDIF
1483:                     ENDIF
1484:                 ENDIF
1485:             ENDIF
1486:         CATCH TO loc_oErro
1487:             MsgErro("Erro em ValidCCarsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1488:         ENDTRY
1489:         RETURN loc_lResultado
1490:     ENDPROC
1491: 
1492:     *--------------------------------------------------------------------------
1493:     PROCEDURE ValidCTitsGrid()
1494:     *--------------------------------------------------------------------------
1495:         LOCAL loc_lResultado, loc_cCTits, loc_nSql, loc_oForm
1496:         loc_lResultado = .T.
1497:         TRY
1498:             IF USED("crFichaTec")
1499:                 SELECT crFichaTec
1500:                 IF !EOF()
1501:                     loc_cCTits = ALLTRIM(crFichaTec.CTits)
1502:                     IF !EMPTY(loc_cCTits)
1503:                         IF USED("cursor_4c_BuscaCTits")
1504:                             USE IN cursor_4c_BuscaCTits
1505:                         ENDIF
1506:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1507:                             "SELECT CTits, DTits FROM SigPrCpP WHERE CTits = " + EscaparSQL(loc_cCTits), ;
1508:                             "cursor_4c_BuscaCTits")
1509:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCTits") > 0
1510:                             USE IN cursor_4c_BuscaCTits
1511:                         ELSE
1512:                             IF USED("cursor_4c_BuscaCTits")
1513:                                 USE IN cursor_4c_BuscaCTits
1514:                             ENDIF
1515:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1516:                                 "SigPrCpP", "cursor_4c_BuscaCTits", "CTits", loc_cCTits, ;
1517:                                 "T" + CHR(237) + "tulos")
1518:                             IF !ISNULL(loc_oForm)
1519:                                 IF !loc_oForm.this_lAchouRegistro
1520:                                     loc_oForm.mAddColuna("CTits", "", "C" + CHR(243) + "digo")
1521:                                     loc_oForm.mAddColuna("DTits", "", "Descri" + CHR(231) + CHR(227) + "o")
1522:                                     loc_oForm.Show()
1523:                                 ENDIF
1524:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCTits")
1525:                                     SELECT crFichaTec
1526:                                     REPLACE crFichaTec.CTits WITH ALLTRIM(cursor_4c_BuscaCTits.CTits)
1527:                                     USE IN cursor_4c_BuscaCTits
1528:                                 ELSE
1529:                                     SELECT crFichaTec
1530:                                     REPLACE crFichaTec.CTits WITH ""
1531:                                     IF USED("cursor_4c_BuscaCTits")
1532:                                         USE IN cursor_4c_BuscaCTits
1533:                                     ENDIF
1534:                                 ENDIF
1535:                                 loc_oForm.Release()
1536:                             ENDIF
1537:                         ENDIF
1538:                     ENDIF
1539:                 ENDIF
1540:             ENDIF
1541:         CATCH TO loc_oErro
1542:             MsgErro("Erro em ValidCTitsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1543:         ENDTRY
1544:         RETURN loc_lResultado
1545:     ENDPROC
1546: 
1547:     *--------------------------------------------------------------------------
1548:     PROCEDURE KeyPressCTpDados(par_nKeyCode, par_nShiftAltCtrl)
1549:     *--------------------------------------------------------------------------
1550:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1551:         LOCAL loc_lResultado
1552:         loc_lResultado = .F.
1553:         TRY
1554:             IF par_nKeyCode = 13 AND THIS.this_cModoAtual = "ALTERAR"
1555:                 IF USED("crFichaTec")
1556:                     SELECT crFichaTec
1557:                     IF !EOF() AND RECNO() = RECCOUNT()
1558:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1559:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1560:                     ENDIF
1561:                 ENDIF
1562:             ENDIF
1563:             loc_lResultado = .T.
1564:         CATCH TO loc_oErro
1565:             MsgErro("Erro em KeyPressCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1566:         ENDTRY
1567:         RETURN loc_lResultado
1568:     ENDPROC
1569: 
1570:     *--------------------------------------------------------------------------
1571:     PROCEDURE ValidCpyCGrus(par_nKeyCode, par_nShiftAltCtrl)
1572:     *--------------------------------------------------------------------------
1573:         LOCAL loc_lResultado, loc_oPg, loc_cCGrus, loc_cTabela, loc_oForm, loc_lEncontrado
1574:         loc_lResultado  = .T.
1575:         loc_lEncontrado = .F.
1576:         TRY
1577:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1578:             loc_cCGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
1579:             IF EMPTY(loc_cCGrus)
1580:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1581:                 loc_lEncontrado = .T.
1582:             ELSE
1583:                 IF USED("crSigCdGrpFilter")
1584:                     SELECT crSigCdGrpFilter
1585:                     LOCATE FOR ALLTRIM(crSigCdGrpFilter.CGrus) = loc_cCGrus
1586:                     IF !EOF()
1587:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(crSigCdGrpFilter.DGrus)
1588:                         loc_lEncontrado = .T.
1589:                     ENDIF
1590:                 ENDIF
1591:             ENDIF
1592:             IF !loc_lEncontrado
1593:                 DO CASE
1594:                 CASE THIS.this_nTipo = 1
1595:                     loc_cTabela = "SigCdGcr"
1596:                 CASE THIS.this_nTipo = 2
1597:                     loc_cTabela = "SigCdOpe"
1598:                 OTHERWISE
1599:                     loc_cTabela = "SigCdGrp"
1600:                 ENDCASE
1601: 
1602:                 IF USED("cursor_4c_BuscaGrp")
1603:                     USE IN cursor_4c_BuscaGrp
1604:                 ENDIF
1605:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1606:                     loc_cTabela, "cursor_4c_BuscaGrp", "CGrus", loc_cCGrus, "Grupos")
1607:                 IF !ISNULL(loc_oForm)
1608:                     IF !loc_oForm.this_lAchouRegistro
1609:                         loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1610:                         loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1611:                         loc_oForm.Show()
1612:                     ENDIF
1613:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1614:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1615:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1616:                         USE IN cursor_4c_BuscaGrp
1617:                     ELSE
1618:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1619:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1620:                         IF USED("cursor_4c_BuscaGrp")
1621:                             USE IN cursor_4c_BuscaGrp
1622:                         ENDIF
1623:                     ENDIF
1624:                     loc_oForm.Release()
1625:                 ENDIF
1626:             ENDIF
1627:         CATCH TO loc_oErro
1628:             MsgErro("Erro em ValidCpyCGrus:" + CHR(13) + loc_oErro.Message, "Erro")
1629:         ENDTRY
1630:         RETURN loc_lResultado
1631:     ENDPROC
1632: 
1633:     *--------------------------------------------------------------------------
1634:     PROCEDURE ValidCpySGrus(par_nKeyCode, par_nShiftAltCtrl)
1635:     *--------------------------------------------------------------------------
1636:         LOCAL loc_lResultado, loc_oPg, loc_cSGrus, loc_cCGrus, loc_oForm, loc_nSql
1637:         loc_lResultado = .T.
1638:         TRY
1639:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1640:             loc_cCGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
1641:             loc_cSGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value)
1642:             IF EMPTY(loc_cSGrus)
1643:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1644:             ELSE
1645:                 IF USED("cursor_4c_BuscaSGrp")
1646:                     USE IN cursor_4c_BuscaSGrp
1647:                 ENDIF
1648:                 loc_nSql = SQLEXEC(gnConnHandle, ;
1649:                     "SELECT Codigos, Descricaos FROM SigCdPsg" + ;
1650:                     " WHERE CGrus = " + EscaparSQL(loc_cCGrus) + ;
1651:                     " AND Codigos = " + EscaparSQL(loc_cSGrus), ;
1652:                     "cursor_4c_BuscaSGrp")
1653:                 IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaSGrp") > 0
1654:                     SELECT cursor_4c_BuscaSGrp
1655:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1656:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1657:                     USE IN cursor_4c_BuscaSGrp
1658:                 ELSE
1659:                     IF USED("cursor_4c_BuscaSGrp")
1660:                         USE IN cursor_4c_BuscaSGrp
1661:                     ENDIF
1662:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1663:                         "SigCdPsg", "cursor_4c_BuscaSGrp", "Codigos", loc_cSGrus, ;
1664:                         "Sub-grupos")
1665:                     IF VARTYPE(loc_oForm) = "O"
1666:                         IF !loc_oForm.this_lAchouRegistro
1667:                             loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1668:                             loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1669:                             loc_oForm.Show()
1670:                         ENDIF
1671:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSGrp")
1672:                             SELECT cursor_4c_BuscaSGrp
1673:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1674:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1675:                             USE IN cursor_4c_BuscaSGrp
1676:                         ELSE
1677:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1678:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1679:                             IF USED("cursor_4c_BuscaSGrp")
1680:                                 USE IN cursor_4c_BuscaSGrp
1681:                             ENDIF
1682:                         ENDIF
1683:                         loc_oForm.Release()
1684:                     ENDIF
1685:                 ENDIF
1686:             ENDIF
1687:         CATCH TO loc_oErro
1688:             MsgErro("Erro em ValidCpySGrus:" + CHR(13) + loc_oErro.Message, "Erro")
1689:         ENDTRY
1690:         RETURN loc_lResultado
1691:     ENDPROC
1692: 
1693:     *--------------------------------------------------------------------------
1694:     PROCEDURE ValidCSelecaos()
1695:     *--------------------------------------------------------------------------
1696:         LOCAL loc_lResultado, loc_cValor
1697:         loc_lResultado = .T.
1698:         TRY
1699:             IF USED("crFichaTec")
1700:                 SELECT crFichaTec
1701:                 IF !EOF()
1702:                     loc_cValor = ALLTRIM(crFichaTec.cSelecaos)
1703:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1704:                         MsgAviso("Tipos de Sele" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
1705:                             "lidos: S ou N !", "Aten" + CHR(231) + CHR(227) + "o")
1706:                         REPLACE crFichaTec.cSelecaos WITH " "
1707:                     ENDIF
1708:                 ENDIF
1709:             ENDIF
1710:         CATCH TO loc_oErro
1711:             MsgErro("Erro em ValidCSelecaos:" + CHR(13) + loc_oErro.Message, "Erro")
1712:         ENDTRY
1713:         RETURN loc_lResultado
1714:     ENDPROC
1715: 
1716:     *--------------------------------------------------------------------------
1717:     PROCEDURE ValidCTpDados()
1718:     *--------------------------------------------------------------------------
1719:         LOCAL loc_lResultado, loc_cValor
1720:         loc_lResultado = .T.
1721:         TRY
1722:             IF USED("crFichaTec")
1723:                 SELECT crFichaTec
1724:                 IF !EOF()
1725:                     loc_cValor = ALLTRIM(crFichaTec.cTpDados)
1726:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "C", "D", "N")
1727:                         MsgAviso("Tipo de dado inv" + CHR(225) + "lido." + CHR(13) + ;
1728:                             "Usar: C - Caracter, D - Data, N - Num" + CHR(233) + "rico !", ;
1729:                             "Aten" + CHR(231) + CHR(227) + "o")
1730:                         REPLACE crFichaTec.cTpDados WITH " "
1731:                     ENDIF
1732:                 ENDIF
1733:             ENDIF
1734:         CATCH TO loc_oErro
1735:             MsgErro("Erro em ValidCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1736:         ENDTRY
1737:         RETURN loc_lResultado
1738:     ENDPROC
1739: 
1740:     *--------------------------------------------------------------------------
1741:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1742:     *--------------------------------------------------------------------------
1743:         LOCAL loc_oPg, loc_oPg2
1744:         TRY
1745:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1746:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1747:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5) AND THIS.this_nTipo = 0
1748:                 loc_oPg.opt_4c_NChkDims.Enabled = par_lHabilitar
1749:             ENDIF
1750:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5) AND THIS.this_nTipo = 0
1751:                 loc_oPg.opt_4c_NChkTems.Enabled = par_lHabilitar
1752:             ENDIF
1753:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5) AND THIS.this_nTipo = 0
1754:                 loc_oPg.opt_4c_NChkPess.Enabled = par_lHabilitar
1755:             ENDIF
1756:             IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5) AND THIS.this_nTipo = 0
1757:                 loc_oPg2.opt_4c_NChkImps.Enabled = par_lHabilitar
1758:             ENDIF
1759:             IF PEMSTATUS(loc_oPg2, "chk_4c_NFixFigs", 5) AND THIS.this_nTipo = 0
1760:                 loc_oPg2.chk_4c_NFixFigs.Enabled = par_lHabilitar
1761:             ENDIF
1762:         CATCH TO loc_oErro
1763:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1764:         ENDTRY
1765:     ENDPROC
1766: 
1767:     *--------------------------------------------------------------------------
1768:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1769:     *--------------------------------------------------------------------------
1770:         LOCAL loc_nI, loc_oCtrl, loc_cNome, loc_nP
1771:         IF ISNULL(par_oContainer) OR !ISOBJECT(par_oContainer)
1772:             RETURN
1773:         ENDIF
1774:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1775:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1776:             loc_cNome = UPPER(ALLTRIM(loc_oCtrl.Name))
1777:             *-- Paineis flutuantes: preservar Visible=.F. mas processar filhos internos
1778:             IF INLIST(loc_cNome, "CNT_4C_COPIARACESSO", "CMD_4C_APAGARLINHA", ;
1779:                     "CMD_4C_COPIAFICHA", "IMG_4C_FIGTEC", "CMD_4C_FIGURA")
1780:                 IF PEMSTATUS(loc_oCtrl, "PageCount", 5)
1781:                     FOR loc_nP = 1 TO loc_oCtrl.PageCount
1782:                         THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
1783:                     ENDFOR
1784:                 ELSE
1785:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1786:                         THIS.TornarControlesVisiveis(loc_oCtrl)
1787:                     ENDIF
1788:                 ENDIF
1789:                 LOOP
1790:             ENDIF
1791:             loc_oCtrl.Visible = .T.
1792:             IF PEMSTATUS(loc_oCtrl, "PageCount", 5)
1793:                 FOR loc_nP = 1 TO loc_oCtrl.PageCount
1794:                     THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
1795:                 ENDFOR
1796:             ELSE
1797:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1798:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1799:                 ENDIF
1800:             ENDIF
1801:         ENDFOR
1802:     ENDPROC
1803: 
1804:     *--------------------------------------------------------------------------
1805:     * FormParaBO - Consolida dados dos controles bound ao BO/cursor
1806:     *   Os TextBox/OptionGroup/CheckBox estao com ControlSource direto para
1807:     *   crFichaCab/crFichaTec (padrao SCX legado). Este metodo garante que
1808:     *   o registro corrente esteja gravado no cursor antes de operacoes.
1809:     *--------------------------------------------------------------------------
1810:     PROTECTED PROCEDURE FormParaBO()
1811:         LOCAL loc_lResultado
1812:         loc_lResultado = .F.
1813:         TRY
1814:             *-- ControlSource faz binding bidirecional automatico: qualquer
1815:             *-- alteracao na tela ja esta gravada no cursor. Aqui garantimos
1816:             *-- apenas que os cursores estao posicionados corretamente para
1817:             *-- que o BO acesse o registro correto no Salvar/Excluir.
1818:             IF USED("crFichaCab")
1819:                 SELECT crFichaCab
1820:                 IF !EOF() AND !BOF()
1821:                     GO RECNO()
1822:                 ENDIF
1823:             ENDIF
1824:             IF USED("crFichaTec")
1825:                 SELECT crFichaTec
1826:                 IF !EOF() AND !BOF()
1827:                     GO RECNO()
1828:                 ENDIF
1829:             ENDIF
1830:             loc_lResultado = .T.
1831:         CATCH TO loc_oErro
1832:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1833:         ENDTRY
1834:         RETURN loc_lResultado
1835:     ENDPROC
1836: 
1837:     *--------------------------------------------------------------------------
1838:     * BOParaForm - Atualiza controles da tela com dados dos cursores do BO
1839:     *   Refresh dos containers/grids que exibem crFichaCab e crFichaTec.
1840:     *--------------------------------------------------------------------------
1841:     PROTECTED PROCEDURE BOParaForm()
1842:         LOCAL loc_lResultado, loc_oPg, loc_oPg2
1843:         loc_lResultado = .F.
1844:         TRY
1845:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1846:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1847: 
1848:             IF USED("crFichaTec")
1849:                 SELECT crFichaTec
1850:                 GO TOP
1851:                 loc_oPg.grd_4c_Fichas.Refresh()
1852:             ENDIF
1853: 
1854:             *-- Refresh dos OptionGroups bound (nChkDims/nChkTems/nChkPess/nChkImps)
1855:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5)
1856:                 loc_oPg.opt_4c_NChkDims.Refresh()
1857:             ENDIF
1858:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5)
1859:                 loc_oPg.opt_4c_NChkTems.Refresh()
1860:             ENDIF
1861:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5)
1862:                 loc_oPg.opt_4c_NChkPess.Refresh()
1863:             ENDIF
1864:             IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5)
1865:                 loc_oPg2.opt_4c_NChkImps.Refresh()
1866:             ENDIF
1867:             IF PEMSTATUS(loc_oPg2, "chk_4c_NFixFigs", 5)
1868:                 loc_oPg2.chk_4c_NFixFigs.Refresh()
1869:             ENDIF
1870: 
1871:             loc_lResultado = .T.
1872:         CATCH TO loc_oErro
1873:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
1874:         ENDTRY
1875:         RETURN loc_lResultado
1876:     ENDPROC
1877: 
1878:     *--------------------------------------------------------------------------
1879:     * LimparCampos - Zera os cursores crFichaCab / crFichaTec e reseta a UI
1880:     *   Chamado quando cancela uma operacao ou volta para lista.
1881:     *--------------------------------------------------------------------------
1882:     PROTECTED PROCEDURE LimparCampos()
1883:         LOCAL loc_lResultado, loc_oPg, loc_oPg2
1884:         loc_lResultado = .F.
1885:         TRY
1886:             IF USED("crFichaCab")
1887:                 SELECT crFichaCab
1888:                 ZAP
1889:             ENDIF
1890:             IF USED("crFichaTec")
1891:                 SELECT crFichaTec
1892:                 ZAP
1893:             ENDIF
1894: 
1895:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1896:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1897: 
1898:             *-- Fecha painel de copia se estiver aberto
1899:             IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
1900:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1901:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1902:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1903:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1904:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1905:             ENDIF
1906: 
1907:             *-- Limpa a imagem da ficha tecnica
1908:             IF PEMSTATUS(loc_oPg2, "img_4c_FigTec", 5)
1909:                 loc_oPg2.img_4c_FigTec.Picture = ""
1910:                 loc_oPg2.img_4c_FigTec.Visible = .F.
1911:             ENDIF
1912: 
1913:             *-- Refresh dos grids/controles bound
1914:             loc_oPg.grd_4c_Fichas.Refresh()
1915: 
1916:             loc_lResultado = .T.
1917:         CATCH TO loc_oErro
1918:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1919:         ENDTRY
1920:         RETURN loc_lResultado
1921:     ENDPROC
1922: 
1923:     *--------------------------------------------------------------------------
1924:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes conforme
1925:     *   o modo atual (LISTA/VISUALIZAR/ALTERAR/EXCLUIR).
1926:     *--------------------------------------------------------------------------
1927:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
1928:         LOCAL loc_lResultado, loc_oPg, loc_oPg2, loc_lAlterar, loc_lLeitura
1929:         loc_lResultado = .F.
1930:         TRY
1931:             IF VARTYPE(par_cModo) <> "C"
1932:                 par_cModo = THIS.this_cModoAtual
1933:             ENDIF
1934:             loc_lAlterar = (par_cModo == "ALTERAR")
1935:             loc_lLeitura = (par_cModo == "VISUALIZAR" OR par_cModo == "EXCLUIR")
1936: 
1937:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1938:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1939: 
1940:             *-- Botoes de manipulacao da grade so aparecem em ALTERAR
1941:             IF PEMSTATUS(loc_oPg, "cmd_4c_ApagarLinha", 5)
1942:                 loc_oPg.cmd_4c_ApagarLinha.Visible = loc_lAlterar
1943:             ENDIF
1944:             IF PEMSTATUS(loc_oPg, "cmd_4c_CopiaFicha", 5)
1945:                 loc_oPg.cmd_4c_CopiaFicha.Visible = loc_lAlterar
1946:             ENDIF
1947: 
1948:             *-- Botao de figura na pagina complementar
1949:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Figura", 5)
1950:                 loc_oPg2.cmd_4c_Figura.Visible = loc_lAlterar
1951:             ENDIF
1952: 
1953:             *-- Grade em modo leitura quando visualiza/exclui
1954:             IF PEMSTATUS(loc_oPg, "grd_4c_Fichas", 5)
1955:                 loc_oPg.grd_4c_Fichas.ReadOnly = loc_lLeitura OR !loc_lAlterar
1956:             ENDIF
1957: 
1958:             *-- Fecha painel de copia
1959:             IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
1960:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1961:             ENDIF
1962: 
1963:             *-- Habilita/desabilita campos de configuracao (OptionGroups + CheckBox)
1964:             THIS.HabilitarCampos(loc_lAlterar)
1965: 
1966:             loc_lResultado = .T.
1967:         CATCH TO loc_oErro
1968:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1969:         ENDTRY
1970:         RETURN loc_lResultado
1971:     ENDPROC
1972: 
1973: ENDDEFINE


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

