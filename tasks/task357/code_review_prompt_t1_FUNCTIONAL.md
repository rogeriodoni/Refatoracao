# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (23)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarEmps' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Prior.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa De' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa Até' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Selecio.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Prior.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa De' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa Até' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Selecio.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Prior.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa De' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa Até' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Selecio.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCco.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1646 linhas total):

*-- Linhas 29 a 163:
29:     *==========================================================================
30:     * Init - Corrige Caption com acentos e delega ao FormBase
31:     *==========================================================================
32:     PROCEDURE Init()
33:         THIS.Caption = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *==========================================================================
38:     * InicializarForm - Configura estrutura completa
39:     * Chamado automaticamente pelo FormBase.Init()
40:     *==========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             *-- Criar BO
47:             THIS.this_oBusinessObject = CREATEOBJECT("CcoBO")
48: 
49:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
50:                 MsgErro("Erro ao criar CcoBO", "FormCco.InicializarForm")
51:                 loc_lSucesso = .F.
52:             ENDIF
53: 
54:             *-- Montar estrutura visual
55:             THIS.ConfigurarPageFrame()
56: 
57:             *-- Cursor crMotivos para grid de motivos (SigCdCmt via SigCdFs)
58:             IF USED("crMotivos")
59:                 USE IN crMotivos
60:             ENDIF
61:             SET NULL ON
62:             CREATE CURSOR crMotivos (Codigos C(10), Descrs C(40), Tipos N(1))
63:             INDEX ON Codigos TAG Codigos
64:             SET NULL OFF
65: 
66:             *-- Carregar dados iniciais (pula em modo ValidandoUI)
67:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
68:                 THIS.this_oBusinessObject.BuscarParametros()
69:                 THIS.CarregarLista()
70:             ENDIF
71: 
72:             *-- Iniciar na pagina de Lista
73:             THIS.pgf_4c_Paginas.Visible = .T.
74:             THIS.pgf_4c_Paginas.ActivePage = 1
75:             THIS.this_cModoAtual = "LISTA"
76: 
77:             loc_lSucesso = .T.
78:         CATCH TO loException
79:             MsgErro("Erro em FormCco.InicializarForm: " + loException.Message, "Erro")
80:         ENDTRY
81: 
82:         RETURN loc_lSucesso
83:     ENDPROC
84: 
85:     *==========================================================================
86:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
87:     * Legado: Pagina.Top=-28 -> compensacao +28 em todos os controles
88:     *==========================================================================
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         LOCAL loc_oPg1, loc_oPg2
91: 
92:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -28
96:             .Left      = -1
97:             .Width     = THIS.Width + 2
98:             .Height    = THIS.Height + 30
99:             .Tabs      = .F.
100:             .Visible   = .T.
101:             .Page1.Caption   = "Lista"
102:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.Caption   = "Dados"
104:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:             .Page1.BackColor = RGB(100, 100, 100)
106:             .Page2.BackColor = RGB(100, 100, 100)
107:         ENDWITH
108: 
109:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
110:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
111: 
112:         loc_oPg1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:         loc_oPg2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114: 
115:         THIS.ConfigurarPaginaLista(loc_oPg1)
116:         THIS.ConfigurarPaginaDados(loc_oPg2)
117:     ENDPROC
118: 
119:     *==========================================================================
120:     * ConfigurarPaginaLista - Configura Page1 (Lista)
121:     * Fase 4: Grid + Botoes CRUD completos
122:     *==========================================================================
123:     PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)
124: 
125:         *-- Cabecalho cinza (cntSombra do legado, Top=0 -> +28 = 28)
126:         par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH par_oPagina.cnt_4c_Cabecalho
128:             .Top         = 28
129:             .Left        = 0
130:             .Width       = THIS.Width
131:             .Height      = 80
132:             .BackColor   = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible     = .T.
135:         ENDWITH
136: 
137:         par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
138:         WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
139:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
140:             .Top       = 15
141:             .Left      = 10
142:             .Width     = THIS.Width - 20
143:             .Height    = 40
144:             .AutoSize  = .F.
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
154:         WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
155:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
156:             .Top       = 18
157:             .Left      = 10
158:             .Width     = THIS.Width - 20
159:             .Height    = 46
160:             .AutoSize  = .F.
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.

*-- Linhas 387 a 446:
387:             .Alignment       = 0
388:         ENDWITH
389: 
390:         *-- BINDEVENTs dos botoes CRUD (metodos PUBLIC - sem PROTECTED)
391:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
392:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
393:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
394:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
395:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
396:         BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
397: 
398:         THIS.TornarControlesVisiveis(par_oPagina)
399:     ENDPROC
400: 
401:     *==========================================================================
402:     * ConfigurarPaginaDados - Configura Page2 (Dados)
403:     * Fase 5: Container Salvar/Cancelar + primeiros 50% dos campos
404:     *         (Codigo, Descricao, ClcStatus, Grupo, Priori)
405:     *==========================================================================
406:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)
407: 
408:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Left=841, Top=-3 -> +28=25)
409:         par_oPagina.AddObject("cnt_4c_Salva", "Container")
410:         WITH par_oPagina.cnt_4c_Salva
411:             .Top         = 25
412:             .Left        = 841
413:             .Width       = 165
414:             .Height      = 85
415:             .BackStyle   = 0
416:             .Visible     = .T.
417:         ENDWITH
418: 
419:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
420:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Salvar
421:             .Caption         = "Confirmar"
422:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
423:             .PicturePosition = 13
424:             .Top             = 5
425:             .Left            = 5
426:             .Width           = 75
427:             .Height          = 75
428:             .BackColor       = RGB(255, 255, 255)
429:             .ForeColor       = RGB(90, 90, 90)
430:             .FontName        = "Comic Sans MS"
431:             .FontBold        = .T.
432:             .FontItalic      = .T.
433:             .FontSize        = 8
434:             .Themes          = .F.
435:             .SpecialEffect   = 0
436:             .MousePointer    = 15
437:             .WordWrap        = .T.
438:             .Visible         = .T.
439:         ENDWITH
440: 
441:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
442:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
443:             .Caption         = "Encerrar"
444:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
445:             .PicturePosition = 13
446:             .Top             = 5

*-- Linhas 543 a 586:
543: 
544:         *-- opt_4c_ClcStatus (Fwoption1: Left=711, Top=47 -> +28=75)
545:         *-- Value=1 (Sim, ClcStatus=1) / Value=2 (Nao, ClcStatus=2)
546:         par_oPagina.AddObject("opt_4c_ClcStatus", "OptionGroup")
547:         WITH par_oPagina.opt_4c_ClcStatus
548:             .ButtonCount = 2
549:             .Left        = 711
550:             .Top         = 75
551:             .Width       = 105
552:             .Height      = 26
553:             .BackStyle   = 0
554:             .BorderStyle = 0
555:             .Value       = 1
556:             .Visible     = .T.
557:         ENDWITH
558:         WITH par_oPagina.opt_4c_ClcStatus.Buttons(1)
559:             .Caption   = "Sim"
560:             .BackStyle = 0
561:             .Left      = 5
562:             .Top       = 5
563:             .Width     = 40
564:             .AutoSize  = .T.
565:             .ForeColor = RGB(90, 90, 90)
566:             .Themes    = .F.
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:         ENDWITH
570:         WITH par_oPagina.opt_4c_ClcStatus.Buttons(2)
571:             .Caption   = "N" + CHR(227) + "o"
572:             .BackStyle = 0
573:             .Left      = 51
574:             .Top       = 5
575:             .Width     = 44
576:             .AutoSize  = .T.
577:             .ForeColor = RGB(90, 90, 90)
578:             .Themes    = .F.
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:         ENDWITH
582: 
583:         *----------------------------------------------------------------------
584:         *-- Linha 2: Grupo + Prioridade
585:         *-- Top original 74-78 -> +28 = 102-106
586:         *----------------------------------------------------------------------

*-- Linhas 616 a 660:
616:             .MaxLength     = 10
617:             .Visible       = .T.
618:         ENDWITH
619:         BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "TxtGrupoKeyPress")
620:         BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
621: 
622:         *-- lbl_4c_Priori (Say7: Left=268, Top=78 -> +28=106)
623:         par_oPagina.AddObject("lbl_4c_Priori", "Label")
624:         WITH par_oPagina.lbl_4c_Priori
625:             .Caption   = "Prioridade :"
626:             .Left      = 268
627:             .Top       = 106
628:             .FontName  = "Tahoma"
629:             .FontSize  = 8
630:             .FontBold  = .F.
631:             .ForeColor = RGB(90, 90, 90)
632:             .BackStyle = 0
633:             .Visible   = .T.
634:         ENDWITH
635: 
636:         *-- txt_4c_Priori (GetPriori: Left=327, Top=74 -> +28=102, Width=26, InputMask="99")
637:         par_oPagina.AddObject("txt_4c_Priori", "TextBox")
638:         WITH par_oPagina.txt_4c_Priori
639:             .Value         = 0
640:             .Left          = 327
641:             .Top           = 102
642:             .Width         = 26
643:             .Height        = 23
644:             .SpecialEffect = 1
645:             .FontName      = "Tahoma"
646:             .FontSize      = 8
647:             .ForeColor     = RGB(0, 0, 0)
648:             .BorderColor   = RGB(100, 100, 100)
649:             .InputMask     = "99"
650:             .MaxLength     = 2
651:             .Visible       = .T.
652:         ENDWITH
653: 
654:         *----------------------------------------------------------------------
655:         *-- Linha 3: Empresa + Faixa de + Faixa Ate
656:         *-- Top original 99-103 -> +28 = 127-131
657:         *----------------------------------------------------------------------
658: 
659:         *-- lbl_4c_Empresa (Say6: Left=87, Top=103 -> +28=131)
660:         par_oPagina.AddObject("lbl_4c_Empresa", "Label")

*-- Linhas 686 a 730:
686:             .MaxLength     = 3
687:             .Visible       = .T.
688:         ENDWITH
689:         BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress",  THIS, "TxtEmpsKeyPress")
690:         BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")
691: 
692:         *-- lbl_4c_FaixaDe (Say4: Left=275, Top=103 -> +28=131)
693:         par_oPagina.AddObject("lbl_4c_FaixaDe", "Label")
694:         WITH par_oPagina.lbl_4c_FaixaDe
695:             .Caption   = "Faixa de :"
696:             .Left      = 275
697:             .Top       = 131
698:             .FontName  = "Tahoma"
699:             .FontSize  = 8
700:             .FontBold  = .F.
701:             .ForeColor = RGB(90, 90, 90)
702:             .BackStyle = 0
703:             .Visible   = .T.
704:         ENDWITH
705: 
706:         *-- txt_4c_FaixaI (Get_faixai: Left=327, Top=99 -> +28=127, Width=108, H=23)
707:         par_oPagina.AddObject("txt_4c_FaixaI", "TextBox")
708:         WITH par_oPagina.txt_4c_FaixaI
709:             .Value         = 0
710:             .Left          = 327
711:             .Top           = 127
712:             .Width         = 108
713:             .Height        = 23
714:             .SpecialEffect = 1
715:             .FontName      = "Tahoma"
716:             .FontSize      = 8
717:             .ForeColor     = RGB(0, 0, 0)
718:             .BorderColor   = RGB(100, 100, 100)
719:             .InputMask     = "9999999999.99"
720:             .Visible       = .T.
721:         ENDWITH
722: 
723:         *-- lbl_4c_FaixaAte (Say5: Left=439, Top=103 -> +28=131)
724:         par_oPagina.AddObject("lbl_4c_FaixaAte", "Label")
725:         WITH par_oPagina.lbl_4c_FaixaAte
726:             .Caption   = "at" + CHR(233) + " :"
727:             .Left      = 439
728:             .Top       = 131
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8

*-- Linhas 832 a 950:
832:                 ENDWITH
833:             ENDWITH
834: 
835:             *-- Coluna 3: Tipos (OptionGroup: Inserir/Excluir/Nenhum)
836:             *-- Sparse=.F.: OptionGroup sempre visivel em todas as linhas
837:             WITH .Column3
838:                 .ControlSource = "crMotivos.Tipos"
839:                 .Width         = 210
840:                 .Movable       = .F.
841:                 .Resizable     = .F.
842:                 .ReadOnly      = .F.
843:                 .Sparse        = .F.
844:                 .FontName      = "Tahoma"
845:                 .FontSize      = 8
846:                 WITH .Header1
847:                     .Caption   = "Tipo"
848:                     .FontName  = "Tahoma"
849:                     .FontSize  = 8
850:                     .Alignment = 2
851:                 ENDWITH
852:             ENDWITH
853:         ENDWITH
854: 
855:         *-- OptionGroup da coluna 3 adicionado fora do WITH (Pattern: AddObject filho via path explicito)
856:         par_oPagina.grd_4c_Motivos.Column3.AddObject("opt_4c_Tipos", "OptionGroup")
857:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos
858:             .ButtonCount = 3
859:             .BorderStyle = 0
860:             .AutoSize    = .F.
861:             .Value       = 1
862:             .Left        = 2
863:             .Top         = 2
864:             .Width       = 191
865:             .Height      = 16
866:             .BackStyle   = 0
867:         ENDWITH
868:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(1)
869:             .Caption  = "Inserir"
870:             .BackStyle = 0
871:             .Value    = 1
872:             .Left     = 5
873:             .Top      = 2
874:             .Width    = 48
875:             .Height   = 14
876:             .AutoSize = .T.
877:             .FontSize = 8
878:         ENDWITH
879:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(2)
880:             .Caption  = "Excluir"
881:             .BackStyle = 0
882:             .Left     = 60
883:             .Top      = 2
884:             .Width    = 50
885:             .Height   = 14
886:             .AutoSize = .T.
887:             .FontSize = 8
888:         ENDWITH
889:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(3)
890:             .Caption  = "Nenhum"
891:             .BackStyle = 0
892:             .Left     = 120
893:             .Top      = 2
894:             .Width    = 61
895:             .Height   = 15
896:             .FontSize = 8
897:         ENDWITH
898: 
899:         *-- BINDEVENTs dos botoes Confirmar/Cancelar
900:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
901:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
902: 
903:         THIS.TornarControlesVisiveis(par_oPagina)
904:     ENDPROC
905: 
906:     *==========================================================================
907:     * CarregarLista - Carrega dados no Grid da Page1
908:     * Vincula cursor_4c_Dados ao grd_4c_Lista apos chamar Buscar no BO
909:     *==========================================================================
910:     PROCEDURE CarregarLista()
911:         LOCAL loc_lResultado, loc_oGrid
912:         loc_lResultado = .F.
913: 
914:         TRY
915:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
916:                 loc_lResultado = .T.
917:             ELSE
918:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
919:                     loc_lResultado = THIS.this_oBusinessObject.Buscar("")
920:                 ENDIF
921: 
922:                 IF loc_lResultado AND USED("cursor_4c_Dados")
923:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
924:                     IF VARTYPE(loc_oGrid) = "O"
925:                         loc_oGrid.ColumnCount = 8
926:                         loc_oGrid.RecordSource              = "cursor_4c_Dados"
927:                         loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
928:                         loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
929:                         loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
930:                         loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
931:                         loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
932:                         loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
933:                         loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
934:                         loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
935:                         *-- Redefinir headers apos RecordSource (VFP reseta automaticamente)
936:                         loc_oGrid.Column1.Header1.Caption   = "Empresa"
937:                         loc_oGrid.Column2.Header1.Caption   = "Grupo"
938:                         loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
939:                         loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
940:                         loc_oGrid.Column5.Header1.Caption   = "Prior."
941:                         loc_oGrid.Column6.Header1.Caption   = "Faixa De"
942:                         loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
943:                         loc_oGrid.Column8.Header1.Caption   = "Selecio."
944:                         THIS.FormatarGridLista(loc_oGrid)
945:                     ENDIF
946:                 ENDIF
947:             ENDIF
948:         CATCH TO loException
949:             MsgErro("Erro em FormCco.CarregarLista: " + loException.Message, "Erro")
950:             loc_lResultado = .F.

*-- Linhas 956 a 1190:
956:     *==========================================================================
957:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
958:     *==========================================================================
959:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
960:         LOCAL loc_lSucesso
961:         loc_lSucesso = .F.
962: 
963:         TRY
964:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
965:                 loc_lSucesso = .F.
966:             ELSE
967:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
968: 
969:                 IF par_nPagina = 1
970:                     THIS.this_cModoAtual = "LISTA"
971:                     THIS.CarregarLista()
972:                 ENDIF
973: 
974:                 loc_lSucesso = .T.
975:             ENDIF
976:         CATCH TO loException
977:             MsgErro("Erro em FormCco.AlternarPagina: " + loException.Message, "Erro")
978:         ENDTRY
979: 
980:         RETURN loc_lSucesso
981:     ENDPROC
982: 
983:     *==========================================================================
984:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
985:     *==========================================================================
986:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
987:         LOCAL loc_nI, loc_oObjeto, loc_nP
988: 
989:         FOR loc_nI = 1 TO par_oContainer.ControlCount
990:             loc_oObjeto = par_oContainer.Controls(loc_nI)
991: 
992:             IF VARTYPE(loc_oObjeto) = "O"
993:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
994:                     loc_oObjeto.Visible = .T.
995:                 ENDIF
996: 
997:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
998:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
999:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1000:                     ENDFOR
1001:                 ENDIF
1002: 
1003:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1004:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1005:                 ENDIF
1006:             ENDIF
1007:         ENDFOR
1008:     ENDPROC
1009: 
1010:     *==========================================================================
1011:     * FormatarGridLista - Formata visual do grid da lista
1012:     *==========================================================================
1013:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1014:         WITH par_oGrid
1015:             .FontName = "Verdana"
1016:             .FontSize = 8
1017:         ENDWITH
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * BtnIncluirClick - Incluir novo registro
1022:     *==========================================================================
1023:     PROCEDURE BtnIncluirClick()
1024:         THIS.this_oBusinessObject.NovoRegistro()
1025:         THIS.LimparCampos()
1026:         THIS.this_cModoAtual = "INCLUIR"
1027:         THIS.HabilitarCampos(.T.)
1028:         THIS.AjustarBotoesPorModo()
1029: 
1030:         *-- Popular crMotivos com todos os motivos de SigCdFs (Tipos=3/Nenhum por default)
1031:         IF USED("crMotivos")
1032:             ZAP IN crMotivos
1033:             THIS.this_oBusinessObject.CompletarMotivosFS()
1034:         ENDIF
1035: 
1036:         THIS.AlternarPagina(2)
1037:     ENDPROC
1038: 
1039:     *==========================================================================
1040:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
1041:     *==========================================================================
1042:     PROCEDURE BtnVisualizarClick()
1043:         LOCAL loc_cIdChaves
1044:         loc_cIdChaves = ""
1045: 
1046:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1047:             SELECT cursor_4c_Dados
1048:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
1049:         ENDIF
1050: 
1051:         IF EMPTY(loc_cIdChaves)
1052:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1053:             RETURN
1054:         ENDIF
1055: 
1056:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1057:             THIS.this_cModoAtual = "VISUALIZAR"
1058:             THIS.BOParaForm()
1059:             THIS.HabilitarCampos(.F.)
1060:             THIS.AjustarBotoesPorModo()
1061: 
1062:             *-- Carregar motivos para grd_4c_Motivos (fase 6)
1063:             IF USED("crMotivos")
1064:                 ZAP IN crMotivos
1065:                 THIS.this_oBusinessObject.CarregarMotivosClassif(loc_cIdChaves)
1066:             ENDIF
1067: 
1068:             THIS.AlternarPagina(2)
1069:         ENDIF
1070:     ENDPROC
1071: 
1072:     *==========================================================================
1073:     * BtnAlterarClick - Alterar registro selecionado
1074:     *==========================================================================
1075:     PROCEDURE BtnAlterarClick()
1076:         LOCAL loc_cIdChaves
1077:         loc_cIdChaves = ""
1078: 
1079:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1080:             SELECT cursor_4c_Dados
1081:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
1082:         ENDIF
1083: 
1084:         IF EMPTY(loc_cIdChaves)
1085:             MsgAviso("Selecione um registro na lista.", "Alterar")
1086:             RETURN
1087:         ENDIF
1088: 
1089:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1090:             THIS.this_oBusinessObject.EditarRegistro()
1091:             THIS.this_cModoAtual = "ALTERAR"
1092:             THIS.BOParaForm()
1093:             THIS.HabilitarCampos(.T.)
1094:             THIS.AjustarBotoesPorModo()
1095: 
1096:             *-- Carregar motivos e completar com SigCdFs ausentes (fase 6)
1097:             IF USED("crMotivos")
1098:                 ZAP IN crMotivos
1099:                 THIS.this_oBusinessObject.CarregarMotivosClassif(loc_cIdChaves)
1100:                 THIS.this_oBusinessObject.CompletarMotivosFS()
1101:             ENDIF
1102: 
1103:             THIS.AlternarPagina(2)
1104:         ENDIF
1105:     ENDPROC
1106: 
1107:     *==========================================================================
1108:     * BtnExcluirClick - Excluir registro selecionado
1109:     *==========================================================================
1110:     PROCEDURE BtnExcluirClick()
1111:         LOCAL loc_cIdChaves, loc_cDescricao
1112:         loc_cIdChaves  = ""
1113:         loc_cDescricao = ""
1114: 
1115:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1116:             SELECT cursor_4c_Dados
1117:             loc_cIdChaves  = ALLTRIM(cursor_4c_Dados.cIdChaves)
1118:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descs)
1119:         ENDIF
1120: 
1121:         IF EMPTY(loc_cIdChaves)
1122:             MsgAviso("Selecione um registro na lista.", "Excluir")
1123:             RETURN
1124:         ENDIF
1125: 
1126:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1127:             RETURN
1128:         ENDIF
1129: 
1130:         IF THIS.this_oBusinessObject.VerificarVinculoCli( ;
1131:                 THIS.this_oBusinessObject.this_cGrupos, ;
1132:                 THIS.this_oBusinessObject.this_cCodigos)
1133:             MsgAviso("Classifica" + CHR(231) + CHR(227) + "o em uso por clientes." + ;
1134:                 CHR(13) + "N" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!", "Excluir")
1135:             RETURN
1136:         ENDIF
1137: 
1138:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o de:" + CHR(13) + ;
1139:                 loc_cDescricao + "?", "Excluir")
1140:             IF THIS.this_oBusinessObject.Excluir()
1141:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
1142:                 THIS.CarregarLista()
1143:             ENDIF
1144:         ENDIF
1145:     ENDPROC
1146: 
1147:     *==========================================================================
1148:     * BtnBuscarClick - Buscar/filtrar registros por codigo ou descricao
1149:     *==========================================================================
1150:     PROCEDURE BtnBuscarClick()
1151:         LOCAL loc_cBusca, loc_cFiltro, loc_lSucesso, loc_oGrid
1152:         loc_cBusca = INPUTBOX("Buscar por c" + CHR(243) + "digo ou descri" + ;
1153:                               CHR(231) + CHR(227) + "o:", ;
1154:                               "Buscar Classifica" + CHR(231) + CHR(227) + "o", "")
1155: 
1156:         IF LASTKEY() = 27
1157:             RETURN
1158:         ENDIF
1159: 
1160:         IF EMPTY(ALLTRIM(loc_cBusca))
1161:             THIS.CarregarLista()
1162:             RETURN
1163:         ENDIF
1164: 
1165:         loc_cFiltro = "codigos LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%")
1166: 
1167:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1168:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1169:             IF loc_lSucesso AND USED("cursor_4c_Dados")
1170:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1171:                 IF VARTYPE(loc_oGrid) = "O"
1172:                     loc_oGrid.ColumnCount = 8
1173:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1174:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
1175:                     loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
1176:                     loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
1177:                     loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
1178:                     loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
1179:                     loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
1180:                     loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
1181:                     loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
1182:                     loc_oGrid.Column1.Header1.Caption   = "Empresa"
1183:                     loc_oGrid.Column2.Header1.Caption   = "Grupo"
1184:                     loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1185:                     loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1186:                     loc_oGrid.Column5.Header1.Caption   = "Prior."
1187:                     loc_oGrid.Column6.Header1.Caption   = "Faixa De"
1188:                     loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
1189:                     loc_oGrid.Column8.Header1.Caption   = "Selecio."
1190:                     THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 1196 a 1458:
1196:     *==========================================================================
1197:     * BtnEncerrarClick - Fechar o formulario
1198:     *==========================================================================
1199:     PROCEDURE BtnEncerrarClick()
1200:         THIS.Release()
1201:     ENDPROC
1202: 
1203:     *==========================================================================
1204:     * BtnSalvarClick - Confirmar: valida, transfere form->BO e chama BO.Salvar
1205:     *==========================================================================
1206:     PROCEDURE BtnSalvarClick()
1207:         LOCAL loc_oPg2, loc_cEmps, loc_cGrupos, loc_cCodigos, loc_cFaixaMsg
1208:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1209: 
1210:         *-- Validacoes FORA do TRY (critico: RETURN dentro de TRY nao funciona)
1211:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
1212:             MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
1213:             loc_oPg2.txt_4c_Grupo.SetFocus
1214:             RETURN
1215:         ENDIF
1216: 
1217:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1218:             MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
1219:             loc_oPg2.txt_4c_Codigo.SetFocus
1220:             RETURN
1221:         ENDIF
1222: 
1223:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
1224:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
1225:                 "o pode ficar em branco!", "Confirmar")
1226:             loc_oPg2.txt_4c_Descricao.SetFocus
1227:             RETURN
1228:         ENDIF
1229: 
1230:         IF !THIS.FormParaBO()
1231:             RETURN
1232:         ENDIF
1233: 
1234:         *-- Verificar duplicidade e sobreposicao de faixa apenas no INCLUIR
1235:         IF THIS.this_cModoAtual = "INCLUIR"
1236:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
1237:             loc_cGrupos  = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1238:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
1239: 
1240:             IF THIS.this_oBusinessObject.VerificarDuplicidade( ;
1241:                     loc_cEmps, loc_cGrupos, loc_cCodigos, "")
1242:                 MsgAviso("J" + CHR(225) + " existe um registro com este c" + CHR(243) + ;
1243:                     "digo neste grupo!", "Confirmar")
1244:                 loc_oPg2.txt_4c_Codigo.SetFocus
1245:                 RETURN
1246:             ENDIF
1247: 
1248:             loc_cFaixaMsg = THIS.this_oBusinessObject.VerificarFaixaSobreposta( ;
1249:                 loc_cEmps, loc_cGrupos, ;
1250:                 THIS.this_oBusinessObject.this_nFaixaIs, ;
1251:                 THIS.this_oBusinessObject.this_nFaixaFs, "")
1252:             IF !EMPTY(loc_cFaixaMsg)
1253:                 MsgAviso(loc_cFaixaMsg, "Confirmar")
1254:                 RETURN
1255:             ENDIF
1256:         ENDIF
1257: 
1258:         IF THIS.this_oBusinessObject.Salvar()
1259:             *-- Salvar motivos se cursor disponivel (grd_4c_Motivos - fase 6)
1260:             IF USED("crMotivos")
1261:                 THIS.this_oBusinessObject.SalvarMotivos( ;
1262:                     THIS.this_oBusinessObject.this_cIdChaves, "crMotivos")
1263:             ENDIF
1264:             MsgInfo("Registro salvo com sucesso!", "Confirmar")
1265:             THIS.AlternarPagina(1)
1266:         ENDIF
1267:     ENDPROC
1268: 
1269:     *==========================================================================
1270:     * BtnCancelarClick - Cancelar edicao e retornar a lista
1271:     *==========================================================================
1272:     PROCEDURE BtnCancelarClick()
1273:         THIS.this_cModoAtual = "LISTA"
1274:         THIS.AlternarPagina(1)
1275:     ENDPROC
1276: 
1277:     *==========================================================================
1278:     * TxtGrupoKeyPress - Abre lookup de grupo via F3
1279:     *==========================================================================
1280:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1281:         IF par_nKeyCode = 114
1282:             THIS.AbrirBuscaGrupo()
1283:         ENDIF
1284:     ENDPROC
1285: 
1286:     *==========================================================================
1287:     * ValidarGrupo - Verifica grupo ao sair do campo (LostFocus)
1288:     *==========================================================================
1289:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
1290:         LOCAL loc_cGrupo, loc_oPg2
1291:         loc_cGrupo = ""
1292: 
1293:         TRY
1294:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1295:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1296: 
1297:             IF EMPTY(loc_cGrupo)
1298:                 RETURN
1299:             ENDIF
1300: 
1301:             THIS.AbrirBuscaGrupo()
1302:         CATCH TO loException
1303:             MsgErro("Erro em FormCco.ValidarGrupo: " + loException.Message, "Erro")
1304:         ENDTRY
1305:     ENDPROC
1306: 
1307:     *==========================================================================
1308:     * AbrirBuscaGrupo - Lookup em SigCdGcr (Codigos/Descrs)
1309:     *==========================================================================
1310:     PROTECTED PROCEDURE AbrirBuscaGrupo()
1311:         LOCAL loc_oBusca, loc_cGrupo, loc_oPg2
1312:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1313:         loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1314: 
1315:         TRY
1316:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1317:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1318:                 "Grupos de Classifica" + CHR(231) + CHR(227) + "o")
1319: 
1320:             IF VARTYPE(loc_oBusca) = "O"
1321:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1322:                     IF USED("cursor_4c_BuscaGrupo")
1323:                         loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1324:                     ENDIF
1325:                 ELSE
1326:                     IF !loc_oBusca.this_lAchouRegistro
1327:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1328:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1329:                     loc_oBusca.Show()
1330:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1331:                         loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1332:                     ENDIF
1333:                     ENDIF
1334:                 ENDIF
1335:                 loc_oBusca.Release()
1336:             ENDIF
1337:         CATCH TO loException
1338:             MsgErro("Erro em FormCco.AbrirBuscaGrupo: " + loException.Message, "Erro")
1339:         ENDTRY
1340: 
1341:         IF USED("cursor_4c_BuscaGrupo")
1342:             USE IN cursor_4c_BuscaGrupo
1343:         ENDIF
1344:     ENDPROC
1345: 
1346:     *==========================================================================
1347:     * TxtEmpsKeyPress - Abre lookup de empresa via F3
1348:     *==========================================================================
1349:     PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1350:         IF par_nKeyCode = 114
1351:             THIS.AbrirBuscaEmps()
1352:         ENDIF
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     * ValidarEmps - Verifica empresa ao sair do campo (LostFocus)
1357:     *==========================================================================
1358:     PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
1359:         LOCAL loc_cEmps, loc_oPg2
1360:         loc_cEmps = ""
1361: 
1362:         TRY
1363:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1364:             loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1365: 
1366:             IF EMPTY(loc_cEmps)
1367:                 RETURN
1368:             ENDIF
1369: 
1370:             THIS.AbrirBuscaEmps()
1371:         CATCH TO loException
1372:             MsgErro("Erro em FormCco.ValidarEmps: " + loException.Message, "Erro")
1373:         ENDTRY
1374:     ENDPROC
1375: 
1376:     *==========================================================================
1377:     * AbrirBuscaEmps - Lookup em SigCdEmp (Cemps/Razas)
1378:     *==========================================================================
1379:     PROTECTED PROCEDURE AbrirBuscaEmps()
1380:         LOCAL loc_oBusca, loc_cEmps, loc_oPg2
1381:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1382:         loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1383: 
1384:         TRY
1385:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1386:                 "SigCdEmp", "cursor_4c_BuscaEmps", "Cemps", loc_cEmps, ;
1387:                 "Empresa")
1388: 
1389:             IF VARTYPE(loc_oBusca) = "O"
1390:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1391:                     IF USED("cursor_4c_BuscaEmps")
1392:                         loc_oPg2.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmps.Cemps)
1393:                     ENDIF
1394:                 ELSE
1395:                     IF !loc_oBusca.this_lAchouRegistro
1396:                     loc_oBusca.mAddColuna("Cemps", "@!", "C" + CHR(243) + "digo")
1397:                     loc_oBusca.mAddColuna("Razas", "!",  "Nome")
1398:                     loc_oBusca.Show()
1399:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmps")
1400:                         loc_oPg2.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmps.Cemps)
1401:                     ENDIF
1402:                     ENDIF
1403:                 ENDIF
1404:                 loc_oBusca.Release()
1405:             ENDIF
1406:         CATCH TO loException
1407:             MsgErro("Erro em FormCco.AbrirBuscaEmps: " + loException.Message, "Erro")
1408:         ENDTRY
1409: 
1410:         IF USED("cursor_4c_BuscaEmps")
1411:             USE IN cursor_4c_BuscaEmps
1412:         ENDIF
1413:     ENDPROC
1414: 
1415:     *==========================================================================
1416:     * LimparCampos - Limpa propriedades do BO (campos de Page2 na Fase 5)
1417:     *==========================================================================
1418:     PROTECTED PROCEDURE LimparCampos()
1419:         LOCAL loc_oPg2, loc_lSucesso
1420:         loc_lSucesso = .F.
1421: 
1422:         TRY
1423:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1424:                 THIS.this_oBusinessObject.this_cIdChaves    = ""
1425:                 THIS.this_oBusinessObject.this_cEmps        = ""
1426:                 THIS.this_oBusinessObject.this_cGrupos      = ""
1427:                 THIS.this_oBusinessObject.this_cCodigos     = ""
1428:                 THIS.this_oBusinessObject.this_cDescs       = ""
1429:                 THIS.this_oBusinessObject.this_nPrioridades = 0
1430:                 THIS.this_oBusinessObject.this_nFaixaIs     = 0
1431:                 THIS.this_oBusinessObject.this_nFaixaFs     = 0
1432:                 THIS.this_oBusinessObject.this_nClcStatus   = 1
1433:             ENDIF
1434: 
1435:             *-- Limpar campos da Page2 (Fase 5)
1436:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1437:             IF VARTYPE(loc_oPg2) = "O"
1438:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1439:                     loc_oPg2.txt_4c_Codigo.Value    = ""
1440:                 ENDIF
1441:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
1442:                     loc_oPg2.txt_4c_Descricao.Value = ""
1443:                 ENDIF
1444:                 IF PEMSTATUS(loc_oPg2, "opt_4c_ClcStatus", 5)
1445:                     loc_oPg2.opt_4c_ClcStatus.Value = 1
1446:                 ENDIF
1447:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1448:                     loc_oPg2.txt_4c_Grupo.Value     = ""
1449:                 ENDIF
1450:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Priori", 5)
1451:                     loc_oPg2.txt_4c_Priori.Value    = 0
1452:                 ENDIF
1453:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1454:                     loc_oPg2.txt_4c_Emps.Value      = ""
1455:                 ENDIF
1456:                 IF PEMSTATUS(loc_oPg2, "txt_4c_FaixaI", 5)
1457:                     loc_oPg2.txt_4c_FaixaI.Value    = 0
1458:                 ENDIF

*-- Linhas 1469 a 1512:
1469:     * HabilitarCampos - Habilita ou desabilita campos de edicao
1470:     * Campos de Page2 serao adicionados na Fase 5
1471:     *==========================================================================
1472:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1473:         LOCAL loc_lHabilitar, loc_oPg2
1474:         loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
1475: 
1476:         TRY
1477:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1478:             IF VARTYPE(loc_oPg2) != "O"
1479:                 RETURN
1480:             ENDIF
1481: 
1482:             *-- Codigo: apenas editavel no modo INCLUIR (Get_codigo.When = pcEscolha=INSERIR)
1483:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1484:                 loc_oPg2.txt_4c_Codigo.Enabled = (loc_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1485:             ENDIF
1486: 
1487:             *-- Descricao: editavel em INCLUIR e ALTERAR
1488:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
1489:                 loc_oPg2.txt_4c_Descricao.Enabled = loc_lHabilitar
1490:             ENDIF
1491: 
1492:             *-- ClcStatus: editavel em INCLUIR e ALTERAR
1493:             IF PEMSTATUS(loc_oPg2, "opt_4c_ClcStatus", 5)
1494:                 loc_oPg2.opt_4c_ClcStatus.Enabled = loc_lHabilitar
1495:             ENDIF
1496: 
1497:             *-- Grupo: editavel somente em INCLUIR (e quando nao filtrado por Clientes)
1498:             *-- Get_Grupo.When = InList(pcEscolha, INSERIR, PROCURAR) AND NOT Clientes
1499:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1500:                 loc_oPg2.txt_4c_Grupo.Enabled = (loc_lHabilitar AND ;
1501:                     THIS.this_cModoAtual = "INCLUIR" AND ;
1502:                     !THIS.this_lClientesFiltro)
1503:             ENDIF
1504: 
1505:             *-- Priori: editavel em INCLUIR e ALTERAR (GetPriori.When = InList(INSERIR, ALTERAR))
1506:             IF PEMSTATUS(loc_oPg2, "txt_4c_Priori", 5)
1507:                 loc_oPg2.txt_4c_Priori.Enabled = loc_lHabilitar
1508:             ENDIF
1509: 
1510:             *-- Emps: editavel apenas em INCLUIR (faz parte da chave composta)
1511:             IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1512:                 loc_oPg2.txt_4c_Emps.Enabled = (loc_lHabilitar AND ;

*-- Linhas 1528 a 1646:
1528:     *==========================================================================
1529:     * BOParaForm - Transfere dados do BO para campos do form (Page2 na Fase 5)
1530:     *==========================================================================
1531:     PROTECTED PROCEDURE BOParaForm()
1532:         LOCAL loc_lSucesso, loc_oPg2
1533:         loc_lSucesso = .F.
1534: 
1535:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1536:             RETURN .F.
1537:         ENDIF
1538: 
1539:         TRY
1540:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1541: 
1542:             *-- Fase 5: Codigo, Descricao, ClcStatus, Grupo, Priori
1543:             loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
1544:             loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
1545:             loc_oPg2.opt_4c_ClcStatus.Value = IIF(THIS.this_oBusinessObject.this_nClcStatus = 2, 2, 1)
1546:             loc_oPg2.txt_4c_Grupo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1547:             loc_oPg2.txt_4c_Priori.Value    = THIS.this_oBusinessObject.this_nPrioridades
1548:             loc_oPg2.txt_4c_Emps.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
1549:             loc_oPg2.txt_4c_FaixaI.Value    = THIS.this_oBusinessObject.this_nFaixaIs
1550:             loc_oPg2.txt_4c_FaixaF.Value    = THIS.this_oBusinessObject.this_nFaixaFs
1551: 
1552:             *-- Grupo fixo se this_lClientesFiltro = .T. (legado: Enabled=.F. no Alterar)
1553:             IF THIS.this_lClientesFiltro AND !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
1554:                 loc_oPg2.txt_4c_Grupo.Enabled = .F.
1555:             ENDIF
1556: 
1557:             loc_lSucesso = .T.
1558:         CATCH TO loException
1559:             MsgErro("Erro em FormCco.BOParaForm: " + loException.Message, "Erro")
1560:         ENDTRY
1561: 
1562:         RETURN loc_lSucesso
1563:     ENDPROC
1564: 
1565:     *==========================================================================
1566:     * FormParaBO - Transfere dados dos campos do form para o BO (Page2 na Fase 5)
1567:     *==========================================================================
1568:     PROTECTED PROCEDURE FormParaBO()
1569:         LOCAL loc_lSucesso, loc_oPg2
1570:         loc_lSucesso = .F.
1571: 
1572:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1573:             RETURN .F.
1574:         ENDIF
1575: 
1576:         TRY
1577:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1578: 
1579:             *-- Fase 5: Codigo, Descricao, ClcStatus, Grupo, Priori
1580:             THIS.this_oBusinessObject.this_cCodigos     = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1581:             THIS.this_oBusinessObject.this_cDescs       = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1582:             THIS.this_oBusinessObject.this_nClcStatus   = loc_oPg2.opt_4c_ClcStatus.Value
1583:             THIS.this_oBusinessObject.this_cGrupos      = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1584:             THIS.this_oBusinessObject.this_nPrioridades = loc_oPg2.txt_4c_Priori.Value
1585:             THIS.this_oBusinessObject.this_cEmps        = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1586:             THIS.this_oBusinessObject.this_nFaixaIs     = loc_oPg2.txt_4c_FaixaI.Value
1587:             THIS.this_oBusinessObject.this_nFaixaFs     = loc_oPg2.txt_4c_FaixaF.Value
1588: 
1589:             loc_lSucesso = .T.
1590:         CATCH TO loException
1591:             MsgErro("Erro em FormCco.FormParaBO: " + loException.Message, "Erro")
1592:         ENDTRY
1593: 
1594:         RETURN loc_lSucesso
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * AjustarBotoesPorModo - Ajusta estado dos botoes Confirmar/Cancelar
1599:     * Confirmar: desabilitado em VISUALIZAR, habilitado em INCLUIR/ALTERAR
1600:     * Cancelar: sempre habilitado em Page2
1601:     *==========================================================================
1602:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1603:         LOCAL loc_oPg2, loc_lConfirmar
1604:         loc_lConfirmar = !INLIST(THIS.this_cModoAtual, "VISUALIZAR", "LISTA")
1605: 
1606:         TRY
1607:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1608:             IF VARTYPE(loc_oPg2) = "O"
1609:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1610:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Salvar", 5)
1611:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Salvar.Enabled  = loc_lConfirmar
1612:                     ENDIF
1613:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1614:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1615:                     ENDIF
1616:                 ENDIF
1617:             ENDIF
1618:         CATCH TO loException
1619:             MsgErro("Erro em FormCco.AjustarBotoesPorModo: " + loException.Message, "Erro")
1620:         ENDTRY
1621:     ENDPROC
1622: 
1623:     *==========================================================================
1624:     * Destroy - Libera recursos ao fechar o formulario
1625:     *==========================================================================
1626:     PROCEDURE Destroy()
1627:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1628:             THIS.this_oBusinessObject = .NULL.
1629:         ENDIF
1630: 
1631:         IF USED("cursor_4c_Dados")
1632:             USE IN cursor_4c_Dados
1633:         ENDIF
1634: 
1635:         IF USED("crMotivos")
1636:             USE IN crMotivos
1637:         ENDIF
1638: 
1639:         IF USED("crSigCdGcr")
1640:             USE IN crSigCdGcr
1641:         ENDIF
1642: 
1643:         DODEFAULT()
1644:     ENDPROC
1645: 
1646: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CcoBO.prg):
*==============================================================================
* CcoBO.prg - Business Object para Classificacao de Contas (SigCdClc)
* Tabela principal : SigCdClc
* Tabela detalhe  : SigCdCmt (motivos/tipos da classificacao)
* Chave primaria  : cIdChaves (UUID gerado por fUniqueIds)
*==============================================================================
DEFINE CLASS CcoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdClc
    *--------------------------------------------------------------------------
    this_cIdChaves      = ""    && cIdChaves   C     - chave primaria (UUID)
    this_cEmps          = ""    && Emps        C(3)  - empresa
    this_cGrupos        = ""    && grupos      C(10) - grupo de conta corrente (FK SigCdGcr)
    this_cCodigos       = ""    && codigos     C(80) - codigo da classificacao
    this_cDescs         = ""    && descs       C(220)- descricao
    this_nPrioridades   = 0     && Prioridades N(2)  - prioridade
    this_nFaixaIs       = 0     && faixais     N(12,2) - faixa inicial
    this_nFaixaFs       = 0     && faixafs     N(12,2) - faixa final
    this_nClcStatus     = 1     && ClcStatus   N(1)  - 1=Sim (selecionavel), 2=Nao

    *--------------------------------------------------------------------------
    * Nomes dos cursores auxiliares
    *--------------------------------------------------------------------------
    this_cCursorMotivos = "crMotivos"    && cursor local de motivos (SigCdCmt + SigCdFs)
    this_cCursorGrupos  = "crSigCdGcr"  && cursor de grupos (SigCdGcr)

    *--------------------------------------------------------------------------
    * Contexto de filtragem (definido pelo Form conforme parametro pCli do legado)
    *--------------------------------------------------------------------------
    this_cGruposFiltro   = ""    && grupo padrao (de SigCdPam.GrPadClis)
    this_lClientesFiltro = .F.   && .T. = filtrar pelo grupo, .F. = excluir o grupo

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdClc"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro(loException.Message, "CcoBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves    = TratarNulo(cIdChaves,   "C")
                THIS.this_cEmps        = TratarNulo(Emps,        "C")
                THIS.this_cGrupos      = TratarNulo(grupos,      "C")
                THIS.this_cCodigos     = TratarNulo(codigos,     "C")
                THIS.this_cDescs       = TratarNulo(descs,       "C")
                THIS.this_nPrioridades = TratarNulo(Prioridades, "N")
                THIS.this_nFaixaIs     = TratarNulo(faixais,     "N")
                THIS.this_nFaixaFs     = TratarNulo(faixafs,     "N")
                THIS.this_nClcStatus   = TratarNulo(ClcStatus,   "N")
                IF THIS.this_nClcStatus = 0
                    THIS.this_nClcStatus = 1
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT de SigCdClc para o grid (cursor_4c_Dados)
    * Aplica filtro de grupo conforme this_cGruposFiltro / this_lClientesFiltro
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cGruposFiltro))
                IF THIS.this_lClientesFiltro
                    loc_cWhere = " WHERE grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ELSE
                    loc_cWhere = " WHERE NOT grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ENDIF
            ENDIF

            IF !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = " WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + loc_cWhere + ;
                       " ORDER BY grupos, codigos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(245) + "es: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cIdChaves)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarParametros - Carrega GrPadClis de SigCdPam
    * Popula this_cGruposFiltro
    *==========================================================================
    FUNCTION BuscarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadClis FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                THIS.this_cGruposFiltro = PADR(TratarNulo(GrPadClis, "C"), 10)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cGruposFiltro = ""
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarParametros: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarGrupos - Carrega SigCdGcr para lookup (cursor crSigCdGcr)
    *==========================================================================
    FUNCTION BuscarGrupos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"

            IF USED("crSigCdGcr")
                USE IN crSigCdGcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGcr")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarGrupos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarMotivosClassif - Carrega motivos de uma classificacao (SigCdCmt + SigCdFs)
    * Popula cursor crMotivos (Codigos C10, Descrs C40, Tipos N1)
    * par_cIdChaves: cIdChaves da classificacao
    *==========================================================================
    FUNCTION CarregarMotivosClassif(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF

            loc_cSQL = "SELECT a.Codigos, b.Descrs, a.Tipos" + ;
                       " FROM SigCdCmt a, SigCdFs b" + ;
                       " WHERE a.fkChaves = " + EscaparSQL(par_cIdChaves) + ;
                       " AND a.Codigos = b.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClaMt")
            IF loc_nResultado >= 0
                SELECT crMotivos
                ZAP IN crMotivos
                SELECT cursor_4c_ClaMt
                SCAN
                    INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                        VALUES (cursor_4c_ClaMt.Codigos, cursor_4c_ClaMt.Descrs, cursor_4c_ClaMt.Tipos)
                ENDSCAN
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                MsgErro("Erro ao carregar motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF
            MsgErro("Erro em CcoBO.CarregarMotivosClassif: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CompletarMotivosFS - Adiciona ao cursor crMotivos os motivos de SigCdFs
    * ausentes (com Tipos=3, Nenhum). Usado em modo INSERIR/ALTERAR.
    *==========================================================================
    FUNCTION CompletarMotivosFS()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigos
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF

            loc_cSQL = "SELECT codigos, descrs FROM SigCdFs ORDER BY codigos"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MdSc")

            IF loc_nResultado >= 0
                SELECT cursor_4c_MdSc
                SCAN
                    loc_cCodigos = ALLTRIM(cursor_4c_MdSc.codigos)
                    IF !USED("crMotivos") OR EOF("crMotivos")
                        INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                            VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                    ELSE
                        SELECT crMotivos
                        GO TOP IN crMotivos
                        LOCATE FOR ALLTRIM(crMotivos.Codigos) = loc_cCodigos
                        IF EOF("crMotivos")
                            INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                                VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                        ENDIF
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                MsgErro("Erro ao carregar motivos FS: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF
            MsgErro("Erro em CcoBO.CompletarMotivosFS: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarDuplicidade - Verifica se grupo+codigos+emps ja existe em SigCdClc
    * Retorna .T. se JA EXISTE (duplicado), .F. se pode inserir
    *==========================================================================
    FUNCTION VerificarDuplicidade(par_cEmps, par_cGrupos, par_cCodigos, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF !EMPTY(ALLTRIM(par_cIdChavesExcluir))
                loc_cSQL = loc_cSQL + " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
            MsgErro("Erro em CcoBO.VerificarDuplicidade: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * VerificarFaixaSobreposta - Verifica se faixa sobrepe outra existente
    * Retorna "" se OK, ou mensagem descricao do conflito
    *==========================================================================
    FUNCTION VerificarFaixaSobreposta(par_cEmps, par_cGrupos, par_nFaixaI, par_nFaixaF, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_cMensagem
        loc_cMensagem = ""

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT descs, faixais, faixafs FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir) + ;
                       " AND (" + ;
                       "   (" + FormatarNumeroSQL(par_nFaixaI) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (" + FormatarNumeroSQL(par_nFaixaF) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (faixais BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       "   OR (faixafs BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       ")"

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Faixa")
            IF loc_nResultado >= 0 AND !EOF("cursor_4c_Faixa")
                SELECT cursor_4c_Faixa
                loc_cMensagem = "Faixa Cadastrada no C" + CHR(243) + "digo " + ;
                    ALLTRIM(cursor_4c_Faixa.descs) + CHR(13) + ;
                    "Valor : " + ALLTRIM(STR(cursor_4c_Faixa.faixais, 12, 2)) + ;
                    " " + CHR(224) + " " + ALLTRIM(STR(cursor_4c_Faixa.faixafs, 12, 2))
            ENDIF

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
            MsgErro("Erro em CcoBO.VerificarFaixaSobreposta: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *==========================================================================
    * VerificarVinculoCli - Verifica se classificacao tem conta vinculada em SigCdCli
    * Retorna .T. se existir vinculo (bloqueio de exclusao)
    *==========================================================================
    FUNCTION VerificarVinculoCli(par_cGrupos, par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lTemVinculo
        loc_lTemVinculo = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCli" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VinCli")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VinCli") > 0
                SELECT cursor_4c_VinCli
                loc_lTemVinculo = (cursor_4c_VinCli.qtd > 0)
            ENDIF

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
            MsgErro("Erro em CcoBO.VerificarVinculoCli: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lTemVinculo
    ENDFUNC

    *==========================================================================
    * SalvarMotivos - Delete + Insert de SigCdCmt para a classificacao atual
    * par_cIdChaves: cIdChaves da classificacao
    * par_cCursorMotivos: nome do cursor com os motivos a salvar
    *   (colunas: Codigos C10, Descrs C40, Tipos N1 - tipos 1 e 2 sao salvos)
    *==========================================================================
    FUNCTION SalvarMotivos(par_cIdChaves, par_cCursorMotivos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdMot
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos antigos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorMotivos)
                    SELECT (par_cCursorMotivos)
                    GO TOP
                    SCAN
                        IF INLIST(Tipos, 1, 2)
                            loc_cIdMot = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdCmt (fkChaves, cIdChaves, Codigos, Tipos)" + ;
                                       " VALUES (" + EscaparSQL(par_cIdChaves) + ;
                                       ", " + EscaparSQL(loc_cIdMot) + ;
                                       ", " + EscaparSQL(ALLTRIM(Codigos)) + ;
                                       ", " + FormatarNumeroSQL(Tipos) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao gravar motivo: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                                EXIT
                            ENDIF
                        ENDIF
                    ENDSCAN
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.SalvarMotivos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdClc" + ;
                       " (cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nClcStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdClc SET" + ;
                       " Emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", codigos = " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", descs = " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", Prioridades = " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", faixais = " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", faixafs = " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", ClcStatus = " + FormatarNumeroSQL(THIS.this_nClcStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE SigCdClc + cascade SigCdCmt
    * (chamado pelo BusinessBase.Excluir via PublicExcluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(THIS.this_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigCdClc WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

