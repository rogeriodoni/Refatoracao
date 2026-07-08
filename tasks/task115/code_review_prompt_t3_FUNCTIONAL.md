# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Op_Emitido' (parent: SIGREHTC): Top original=197 vs migrado 'obj_4c_Op_Emitido' Top=5 (diff=192px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Emitido' (parent: SIGREHTC): Left original=248 vs migrado 'obj_4c_Op_Emitido' Left=5 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDatas' (parent: SIGREHTC): Top original=149 vs migrado 'obj_4c_OptDatas' Top=5 (diff=144px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDatas' (parent: SIGREHTC): Left original=430 vs migrado 'obj_4c_OptDatas' Left=5 (diff=425px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Baixados' (parent: SIGREHTC): Top original=240 vs migrado 'obj_4c_Op_Baixados' Top=5 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Baixados' (parent: SIGREHTC): Left original=248 vs migrado 'obj_4c_Op_Baixados' Left=5 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Cancelado' (parent: SIGREHTC): Top original=219 vs migrado 'obj_4c_Op_Cancelado' Top=5 (diff=214px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Cancelado' (parent: SIGREHTC): Left original=248 vs migrado 'obj_4c_Op_Cancelado' Left=5 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Ordem' (parent: SIGREHTC): Top original=172 vs migrado 'obj_4c_Op_Ordem' Top=5 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Ordem' (parent: SIGREHTC): Left original=248 vs migrado 'obj_4c_Op_Ordem' Left=5 (diff=243px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehtc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1273 linhas total):

*-- Linhas 39 a 142:
39:     *==========================================================================
40:     * INIT
41:     *==========================================================================
42:     PROCEDURE Init()
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *==========================================================================
47:     * INICIALIZARFORM - Cria estrutura do form de relatorio FLAT
48:     *==========================================================================
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lSucesso, loc_oErro
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             THIS.this_oRelatorio = CREATEOBJECT("sigrehtcBO")
55: 
56:             IF VARTYPE(THIS.this_oRelatorio) != "O"
57:                 MsgErro("Erro ao criar BO do relat" + CHR(243) + ;
58:                     "rio de Cheques Emitidos", "InicializarForm")
59:             ELSE
60:                 THIS.this_oRelatorio.BuscarContas()
61:                 THIS.ConfigurarPageFrame()
62:                 THIS.ConfigurarCabecalho()
63:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.ConfigurarPaginaLista()
66:                 THIS.LimparCampos()
67: 
68:                 THIS.Visible = .T.
69:                 loc_lSucesso = .T.
70:             ENDIF
71: 
72:         CATCH TO loc_oErro
73:             MsgErro(loc_oErro.Message, "InicializarForm")
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *==========================================================================
80:     * CONFIGURARPAGEFRAME - Aplica propriedades de janela do form de relatorio
81:     *==========================================================================
82:     PROTECTED PROCEDURE ConfigurarPageFrame()
83:         THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques Emitidos"
84:         THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
85:         THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
86:         THIS.AutoCenter  = .T.
87:         THIS.BorderStyle = 2
88:         THIS.WindowType  = 1
89:         THIS.ControlBox  = .F.
90:         THIS.MaxButton   = .F.
91:         THIS.MinButton   = .F.
92:         THIS.TitleBar    = 0
93:         THIS.Themes      = .F.
94:         THIS.ShowTips    = .T.
95:         THIS.BackColor   = RGB(255, 255, 255)
96:     ENDPROC
97: 
98:     *==========================================================================
99:     * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
100:     * Width = THIS.Width (NUNCA subtrair por causa do Encerrar - nao existe aqui)
101:     *==========================================================================
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH THIS.cnt_4c_Cabecalho
105:             .Top       = 0
106:             .Left      = 0
107:             .Width     = THIS.Width
108:             .Height    = 80
109:             .BackStyle = 1
110:             .BackColor = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible   = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Top       = 15
117:                 .Left      = 12
118:                 .Width     = THIS.Width
119:                 .Height    = 40
120:                 .FontName  = "Tahoma"
121:                 .FontSize  = 16
122:                 .FontBold  = .T.
123:                 .BackStyle = 0
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .Caption   = THIS.Caption
126:                 .Visible   = .T.
127:             ENDWITH
128: 
129:             .AddObject("lbl_4c_Titulo", "Label")
130:             WITH .lbl_4c_Titulo
131:                 .Top       = 18
132:                 .Left      = 10
133:                 .Width     = THIS.Width
134:                 .Height    = 40
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 16
137:                 .FontBold  = .T.
138:                 .BackStyle = 0
139:                 .ForeColor = RGB(255, 255, 255)
140:                 .Caption   = THIS.Caption
141:                 .Visible   = .T.
142:             ENDWITH

*-- Linhas 148 a 206:
148:     * Em REPORT nao ha PageFrame/Grid CRUD; a "pagina lista" e o conjunto
149:     * de filtros + CommandGroup de acoes (Visualizar/Imprimir/Excel/Sair).
150:     * Encaminha para ConfigurarBotoes() (cmg_4c_Botoes) e ConfigurarPaginaDados()
151:     * (17 controles: 6 Labels + 6 TextBoxes + 5 OptionGroups), na ordem em que
152:     * o framework legado renderizava (botoes primeiro, depois filtros).
153:     *==========================================================================
154:     PROTECTED PROCEDURE ConfigurarPaginaLista()
155:         THIS.ConfigurarBotoes()
156:         THIS.ConfigurarPaginaDados()
157:         THIS.this_nPaginaAtual = 1
158:     ENDPROC
159: 
160:     *==========================================================================
161:     * CONFIGURARBOTOES - CommandGroup com 4 botoes (frmrelatorio canonical)
162:     * Left=529 (original btnReport.Left=530), Width=273, Height=80, Top=0
163:     * Geometria canonical: ButtonCount=4, BackStyle=0, BorderStyle=0
164:     * BINDEVENTs adicionados na Fase 7
165:     *==========================================================================
166:     PROTECTED PROCEDURE ConfigurarBotoes()
167:         LOCAL loc_cIcones
168:         loc_cIcones = gc_4c_CaminhoIcones
169: 
170:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
171:         WITH THIS.cmg_4c_Botoes
172:             .Top           = 0
173:             .Left          = 529
174:             .Width         = 273
175:             .Height        = 80
176:             .ButtonCount   = 4
177:             .BackStyle     = 0
178:             .BorderStyle   = 0
179:             .BorderColor   = RGB(136, 189, 188)
180:             .SpecialEffect = 1
181:             .Themes        = .F.
182:             .Visible       = .T.
183: 
184:             WITH .Buttons(1)
185:                 .Top             = 5
186:                 .Left            = 5
187:                 .Width           = 65
188:                 .Height          = 70
189:                 .Caption         = "Visualizar"
190:                 .Picture         = loc_cIcones + "ideo.jpg"
191:                 .FontBold        = .T.
192:                 .FontItalic      = .T.
193:                 .BackColor       = RGB(255, 255, 255)
194:                 .ForeColor       = RGB(90, 90, 90)
195:                 .PicturePosition = 13
196:                 .SpecialEffect   = 0
197:                 .MousePointer    = 15
198:                 .Themes          = .F.
199:                 .WordWrap        = .T.
200:             ENDWITH
201: 
202:             WITH .Buttons(2)
203:                 .Top             = 5
204:                 .Left            = 71
205:                 .Width           = 65
206:                 .Height          = 70

*-- Linhas 261 a 317:
261:             ENDWITH
262:         ENDWITH
263: 
264:         *-- BINDEVENTs para os 4 botoes da CommandGroup
265:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
266:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
267:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
268:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
269:     ENDPROC
270: 
271:     *==========================================================================
272:     * CONFIGURARPAGINADADOS - Cria todos os controles de filtro do relatorio
273:     * Posicoes EXATAS do original (Width=800, Height=300)
274:     * Em REPORT FLAT, a "pagina dados" e a area de filtros sobre o form (sem
275:     * PageFrame CRUD): 6 Labels + 6 TextBoxes + 5 OptionGroups = 17 controles.
276:     *==========================================================================
277:     PROTECTED PROCEDURE ConfigurarPaginaDados()
278: 
279:         *-- Label: Grupo
280:         THIS.AddObject("lbl_4c_Label3", "Label")
281:         WITH THIS.lbl_4c_Label3
282:             .AutoSize  = .T.
283:             .FontName  = "Tahoma"
284:             .FontSize  = 8
285:             .Caption   = "Grupo :"
286:             .Left      = 211
287:             .Top       = 101
288:             .Width     = 38
289:             .ForeColor = RGB(90, 90, 90)
290:             .BackStyle = 0
291:             .Visible   = .T.
292:         ENDWITH
293: 
294:         *-- Label: Conta
295:         THIS.AddObject("lbl_4c_Label4", "Label")
296:         WITH THIS.lbl_4c_Label4
297:             .AutoSize  = .T.
298:             .FontName  = "Tahoma"
299:             .FontSize  = 8
300:             .Caption   = "Conta :"
301:             .Left      = 211
302:             .Top       = 128
303:             .Width     = 38
304:             .ForeColor = RGB(90, 90, 90)
305:             .BackStyle = 0
306:             .Visible   = .T.
307:         ENDWITH
308: 
309:         *-- Label: Periodo
310:         THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
311:         WITH THIS.lbl_4c_Lbl_periodo
312:             .AutoSize  = .T.
313:             .FontName  = "Tahoma"
314:             .FontSize  = 8
315:             .Caption   = "Per" + CHR(237) + "odo  :"
316:             .Left      = 201
317:             .Top       = 154

*-- Linhas 466 a 555:
466:             .Visible       = .T.
467:         ENDWITH
468: 
469:         *-- OptionGroup: Tipo de data (Movimentacao / Vencimento)
470:         THIS.AddObject("obj_4c_OptDatas", "OptionGroup")
471:         WITH THIS.obj_4c_OptDatas
472:             .Top           = 149
473:             .Left          = 430
474:             .Width         = 189
475:             .Height        = 25
476:             .ButtonCount   = 2
477:             .BackStyle     = 0
478:             .BorderStyle   = 0
479:             .Value         = 1
480:             .SpecialEffect = 0
481:             .Visible       = .T.
482: 
483:             WITH .Buttons(1)
484:                 .BackStyle = 0
485:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
486:                 .Height    = 15
487:                 .Left      = 5
488:                 .Style     = 0
489:                 .Top       = 5
490:                 .Width     = 87
491:                 .AutoSize  = .T.
492:                 .ForeColor = RGB(90, 90, 90)
493:                 .Themes    = .F.
494:                 .Visible   = .T.
495:             ENDWITH
496: 
497:             WITH .Buttons(2)
498:                 .FontName  = "Tahoma"
499:                 .FontSize  = 8
500:                 .BackStyle = 0
501:                 .Caption   = "Vencimento"
502:                 .Height    = 15
503:                 .Left      = 111
504:                 .Style     = 0
505:                 .Top       = 5
506:                 .Width     = 73
507:                 .AutoSize  = .T.
508:                 .ForeColor = RGB(90, 90, 90)
509:                 .Themes    = .F.
510:                 .Visible   = .T.
511:             ENDWITH
512:         ENDWITH
513: 
514:         *-- OptionGroup: Op_Emitido (Emitido / Nao Emitido / Todos)
515:         THIS.AddObject("obj_4c_Op_Emitido", "OptionGroup")
516:         WITH THIS.obj_4c_Op_Emitido
517:             .Top           = 197
518:             .Left          = 248
519:             .Width         = 262
520:             .Height        = 24
521:             .ButtonCount   = 3
522:             .BackStyle     = 0
523:             .BorderStyle   = 0
524:             .Value         = 1
525:             .SpecialEffect = 0
526:             .AutoSize      = .F.
527:             .Visible       = .T.
528: 
529:             WITH .Buttons(1)
530:                 .BackStyle = 0
531:                 .Caption   = "Emitido"
532:                 .Height    = 15
533:                 .Left      = 5
534:                 .Top       = 5
535:                 .Width     = 52
536:                 .AutoSize  = .T.
537:                 .ForeColor = RGB(90, 90, 90)
538:                 .Themes    = .F.
539:                 .Visible   = .T.
540:             ENDWITH
541: 
542:             WITH .Buttons(2)
543:                 .FontName  = "Tahoma"
544:                 .FontSize  = 8
545:                 .BackStyle = 0
546:                 .Caption   = "N" + CHR(227) + "o Emitido"
547:                 .Height    = 15
548:                 .Left      = 92
549:                 .Style     = 0
550:                 .Top       = 5
551:                 .Width     = 85
552:                 .AutoSize  = .T.
553:                 .ForeColor = RGB(90, 90, 90)
554:                 .Themes    = .F.
555:                 .Visible   = .T.

*-- Linhas 571 a 615:
571:             ENDWITH
572:         ENDWITH
573: 
574:         *-- OptionGroup: Op_Cancelado (Validos / Cancelados / Todos)
575:         THIS.AddObject("obj_4c_Op_Cancelado", "OptionGroup")
576:         WITH THIS.obj_4c_Op_Cancelado
577:             .Top           = 219
578:             .Left          = 248
579:             .Width         = 262
580:             .Height        = 24
581:             .ButtonCount   = 3
582:             .BackStyle     = 0
583:             .BorderStyle   = 0
584:             .Value         = 1
585:             .SpecialEffect = 0
586:             .AutoSize      = .F.
587:             .Visible       = .T.
588: 
589:             WITH .Buttons(1)
590:                 .BackStyle = 0
591:                 .Caption   = "V" + CHR(225) + "lidos"
592:                 .Height    = 15
593:                 .Left      = 5
594:                 .Top       = 5
595:                 .Width     = 51
596:                 .AutoSize  = .T.
597:                 .ForeColor = RGB(90, 90, 90)
598:                 .Themes    = .F.
599:                 .Visible   = .T.
600:             ENDWITH
601: 
602:             WITH .Buttons(2)
603:                 .FontName  = "Tahoma"
604:                 .FontSize  = 8
605:                 .BackStyle = 0
606:                 .Caption   = "Cancelados"
607:                 .Height    = 15
608:                 .Left      = 92
609:                 .Style     = 0
610:                 .Top       = 5
611:                 .Width     = 78
612:                 .AutoSize  = .T.
613:                 .ForeColor = RGB(90, 90, 90)
614:                 .Themes    = .F.
615:                 .Visible   = .T.

*-- Linhas 631 a 675:
631:             ENDWITH
632:         ENDWITH
633: 
634:         *-- OptionGroup: Op_Ordem (por Copia / por Data / por Conta)
635:         THIS.AddObject("obj_4c_Op_Ordem", "OptionGroup")
636:         WITH THIS.obj_4c_Op_Ordem
637:             .Top           = 172
638:             .Left          = 248
639:             .Width         = 280
640:             .Height        = 27
641:             .ButtonCount   = 3
642:             .BackStyle     = 0
643:             .BorderStyle   = 0
644:             .Value         = 1
645:             .SpecialEffect = 0
646:             .Visible       = .T.
647: 
648:             WITH .Buttons(1)
649:                 .BackStyle = 0
650:                 .Caption   = "por C" + CHR(243) + "pia"
651:                 .Height    = 17
652:                 .Left      = 5
653:                 .Style     = 0
654:                 .Top       = 5
655:                 .Width     = 72
656:                 .AutoSize  = .F.
657:                 .ForeColor = RGB(90, 90, 90)
658:                 .Themes    = .F.
659:                 .Visible   = .T.
660:             ENDWITH
661: 
662:             WITH .Buttons(2)
663:                 .FontName  = "Tahoma"
664:                 .FontSize  = 8
665:                 .BackStyle = 0
666:                 .Caption   = "por Data"
667:                 .Height    = 17
668:                 .Left      = 92
669:                 .Style     = 0
670:                 .Top       = 5
671:                 .Width     = 72
672:                 .AutoSize  = .F.
673:                 .ForeColor = RGB(90, 90, 90)
674:                 .Themes    = .F.
675:                 .Visible   = .T.

*-- Linhas 692 a 1273:
692:             ENDWITH
693:         ENDWITH
694: 
695:         *-- OptionGroup: Op_Baixados (Sim / Nao)
696:         THIS.AddObject("obj_4c_Op_Baixados", "OptionGroup")
697:         WITH THIS.obj_4c_Op_Baixados
698:             .Top           = 240
699:             .Left          = 248
700:             .Width         = 144
701:             .Height        = 27
702:             .ButtonCount   = 2
703:             .BackStyle     = 0
704:             .BorderStyle   = 0
705:             .Value         = 1
706:             .SpecialEffect = 0
707:             .Visible       = .T.
708: 
709:             WITH .Buttons(1)
710:                 .BackStyle = 0
711:                 .Caption   = "Sim"
712:                 .Height    = 17
713:                 .Left      = 5
714:                 .Style     = 0
715:                 .Top       = 5
716:                 .Width     = 40
717:                 .AutoSize  = .F.
718:                 .ForeColor = RGB(90, 90, 90)
719:                 .Themes    = .F.
720:                 .Visible   = .T.
721:             ENDWITH
722: 
723:             WITH .Buttons(2)
724:                 .FontName  = "Tahoma"
725:                 .FontSize  = 8
726:                 .BackStyle = 0
727:                 .Caption   = "N" + CHR(227) + "o"
728:                 .Height    = 17
729:                 .Left      = 92
730:                 .Style     = 0
731:                 .Top       = 5
732:                 .Width     = 40
733:                 .AutoSize  = .F.
734:                 .ForeColor = RGB(90, 90, 90)
735:                 .Themes    = .F.
736:                 .Visible   = .T.
737:             ENDWITH
738:         ENDWITH
739: 
740:         *-- BINDEVENTs: Grupo de Estoque - valida ao pressionar ENTER/TAB/F4
741:         BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
742:         BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
743: 
744:         *-- BINDEVENTs: Conta - valida ao pressionar ENTER/TAB/F4
745:         BINDEVENT(THIS.txt_4c_CdContas, "KeyPress", THIS, "TeclaCdContas")
746:         BINDEVENT(THIS.txt_4c_DsContas, "KeyPress", THIS, "TeclaDsContas")
747:     ENDPROC
748: 
749:     *==========================================================================
750:     * LIMPARCAMPOS - Reseta todos os campos de filtro para valores padrao
751:     *==========================================================================
752:     PROCEDURE LimparCampos()
753:         THIS.txt_4c_CdGrEstoque.Value    = ""
754:         THIS.txt_4c_DsGrEstoque.Value    = ""
755:         THIS.txt_4c_DsGrEstoque.Enabled  = .T.
756:         THIS.txt_4c_CdContas.Value       = ""
757:         THIS.txt_4c_DsContas.Value       = ""
758:         THIS.txt_4c_DsContas.Enabled     = .T.
759:         THIS.txt_4c__dt_inicial.Value    = {}
760:         THIS.txt_4c__dt_final.Value      = {}
761:         THIS.obj_4c_OptDatas.Value       = 1
762:         THIS.obj_4c_Op_Emitido.Value     = 1
763:         THIS.obj_4c_Op_Cancelado.Value   = 1
764:         THIS.obj_4c_Op_Ordem.Value       = 1
765:         THIS.obj_4c_Op_Baixados.Value    = 1
766:     ENDPROC
767: 
768:     *==========================================================================
769:     * ATUALIZARESTADOCONTROLES - Override: REPORT nao usa modo CRUD
770:     *==========================================================================
771:     PROCEDURE AtualizarEstadoControles()
772:         RETURN
773:     ENDPROC
774: 
775:     *==========================================================================
776:     * ALTERNARPAGINA - REPORT eh FLAT (1 pagina logica permanente)
777:     *==========================================================================
778:     PROCEDURE AlternarPagina(par_nPagina)
779:         LOCAL loc_nPagina
780:         loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
781:         IF loc_nPagina < 1
782:             loc_nPagina = 1
783:         ENDIF
784:         THIS.this_nPaginaAtual = loc_nPagina
785:     ENDPROC
786: 
787:     *==========================================================================
788:     * FORMPARARELATORIO - Transfere valores do form para o BO
789:     *==========================================================================
790:     PROTECTED PROCEDURE FormParaRelatorio()
791:         WITH THIS.this_oRelatorio
792:             .this_dDtInicial = THIS.txt_4c__dt_inicial.Value
793:             .this_dDtFinal   = THIS.txt_4c__dt_final.Value
794:             .this_nTpDat     = THIS.obj_4c_OptDatas.Value
795:             .this_cGrupo     = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
796:             .this_cDsGrupo   = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
797:             .this_cIclis     = ALLTRIM(THIS.txt_4c_CdContas.Value)
798:             .this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
799:             .this_nOpEmitido = THIS.obj_4c_Op_Emitido.Value
800:             .this_nOpCancela = THIS.obj_4c_Op_Cancelado.Value
801:             .this_nOpOrdem   = THIS.obj_4c_Op_Ordem.Value
802:             .this_nOpBaixas  = THIS.obj_4c_Op_Baixados.Value
803:         ENDWITH
804:     ENDPROC
805: 
806:     *==========================================================================
807:     * VALIDARCDGRESTOQUE - Valida codigo do grupo contra SigCdGrp
808:     * cgrus=code(3), dgrus=desc(20)
809:     *==========================================================================
810:     PROCEDURE ValidarCdGrEstoque()
811:         LOCAL loc_cCodigo, loc_cSQL, loc_nResult
812:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
813: 
814:         IF EMPTY(loc_cCodigo)
815:             THIS.txt_4c_DsGrEstoque.Value   = ""
816:             THIS.txt_4c_DsGrEstoque.Enabled = .T.
817:             RETURN
818:         ENDIF
819: 
820:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp"
821: 
822:         IF USED("cursor_4c_GrpVal")
823:             USE IN cursor_4c_GrpVal
824:         ENDIF
825: 
826:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
827: 
828:         IF loc_nResult > 0
829:             SELECT cursor_4c_GrpVal
830:             LOCATE FOR ALLTRIM(cgrus) = ALLTRIM(loc_cCodigo)
831:             IF FOUND()
832:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
833:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
834:                 USE IN cursor_4c_GrpVal
835:                 RETURN
836:             ENDIF
837:             USE IN cursor_4c_GrpVal
838:         ENDIF
839: 
840:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado: " + loc_cCodigo, "Aviso")
841:         THIS.txt_4c_CdGrEstoque.Value   = ""
842:         THIS.txt_4c_DsGrEstoque.Value   = ""
843:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
844:         THIS.txt_4c_CdGrEstoque.SetFocus()
845:     ENDPROC
846: 
847:     *==========================================================================
848:     * VALIDARDSGRESTOQUE - Valida descricao do grupo contra SigCdGrp
849:     * Ativo somente quando txt_4c_CdGrEstoque estiver vazio (When original)
850:     *==========================================================================
851:     PROCEDURE ValidarDsGrEstoque()
852:         LOCAL loc_cDesc, loc_cSQL, loc_nResult
853:         loc_cDesc = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
854: 
855:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value))
856:             RETURN
857:         ENDIF
858: 
859:         IF EMPTY(loc_cDesc)
860:             THIS.txt_4c_CdGrEstoque.Value = ""
861:             RETURN
862:         ENDIF
863: 
864:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp"
865: 
866:         IF USED("cursor_4c_GrpDsVal")
867:             USE IN cursor_4c_GrpDsVal
868:         ENDIF
869: 
870:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDsVal")
871: 
872:         IF loc_nResult > 0
873:             SELECT cursor_4c_GrpDsVal
874:             LOCATE FOR UPPER(ALLTRIM(dgrus)) = UPPER(loc_cDesc)
875:             IF FOUND()
876:                 THIS.txt_4c_CdGrEstoque.Value   = ALLTRIM(cgrus)
877:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
878:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
879:                 USE IN cursor_4c_GrpDsVal
880:                 RETURN
881:             ENDIF
882:             USE IN cursor_4c_GrpDsVal
883:         ENDIF
884: 
885:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
886:         THIS.txt_4c_CdGrEstoque.Value   = ""
887:         THIS.txt_4c_DsGrEstoque.Value   = ""
888:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
889:         THIS.txt_4c_DsGrEstoque.SetFocus()
890:     ENDPROC
891: 
892:     *==========================================================================
893:     * TECLACDGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida codigo do grupo
894:     *==========================================================================
895:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShift)
896:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
897:             THIS.AbrirLookupGrEstoque()
898:         ELSE
899:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
900:             THIS.ValidarCdGrEstoque()
901:             ENDIF
902:         ENDIF
903:     ENDPROC
904: 
905:     *==========================================================================
906:     * TECLADSGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida descricao do grupo
907:     *                              F4(115) abre lookup direto
908:     *==========================================================================
909:     PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShift)
910:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
911:             THIS.AbrirLookupGrEstoque()
912:         ELSE
913:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
914:             THIS.ValidarDsGrEstoque()
915:             ENDIF
916:         ENDIF
917:     ENDPROC
918: 
919:     *==========================================================================
920:     * ABRIRLOOKUPGRESTOQUE - Abre FormBuscaAuxiliar para grupo de estoque
921:     * Tabela: SigCdGrp | cgrus (cod) | dgrus (desc)
922:     *==========================================================================
923:     PROCEDURE AbrirLookupGrEstoque()
924:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
925: 
926:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
927:             "SigCdGrp", ;
928:             "cursor_4c_BuscaGrp", ;
929:             "cgrus", ;
930:             ALLTRIM(THIS.txt_4c_CdGrEstoque.Value), ;
931:             "Buscar Grupo de Estoque")
932: 
933:         loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
934:         loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
935:         loc_oBusca.Show()
936: 
937:         IF loc_oBusca.this_lSelecionou
938:             IF USED("cursor_4c_BuscaGrp")
939:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
940:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
941:                 THIS.txt_4c_CdGrEstoque.Value   = loc_cCodigo
942:                 THIS.txt_4c_DsGrEstoque.Value   = loc_cDescricao
943:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
944:             ENDIF
945:         ENDIF
946: 
947:         IF USED("cursor_4c_BuscaGrp")
948:             USE IN cursor_4c_BuscaGrp
949:         ENDIF
950:         loc_oBusca.Release()
951:     ENDPROC
952: 
953:     *==========================================================================
954:     * TECLACDCONTAS - KeyPress: ENTER(13)/TAB(9) valida codigo da conta
955:     *                           F4(115) abre lookup direto
956:     *==========================================================================
957:     PROCEDURE TeclaCdContas(par_nKeyCode, par_nShift)
958:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
959:             THIS.AbrirLookupContas()
960:         ELSE
961:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
962:             THIS.ValidarCdContas()
963:             ENDIF
964:         ENDIF
965:     ENDPROC
966: 
967:     *==========================================================================
968:     * TECLADSCONTAS - KeyPress: ENTER(13)/TAB(9) valida descricao da conta
969:     *                           F4(115) abre lookup direto
970:     * Somente ativo quando CdContas estiver vazio (comportamento When original)
971:     *==========================================================================
972:     PROCEDURE TeclaDsContas(par_nKeyCode, par_nShift)
973:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
974:             THIS.AbrirLookupContas()
975:         ELSE
976:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
977:             THIS.ValidarDsContas()
978:             ENDIF
979:         ENDIF
980:     ENDPROC
981: 
982:     *==========================================================================
983:     * VALIDARCDCONTAS - Valida codigo da conta contra cursor_4c_Contas
984:     * Iclis=codigo, Rclis=nome/razao social
985:     * Se nao encontrado, abre lookup FormBuscaAuxiliar
986:     *==========================================================================
987:     PROCEDURE ValidarCdContas()
988:         LOCAL loc_cCodigo, loc_nArea
989:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdContas.Value)
990: 
991:         IF EMPTY(loc_cCodigo)
992:             THIS.txt_4c_DsContas.Value   = ""
993:             THIS.txt_4c_DsContas.Enabled = .T.
994:             RETURN
995:         ENDIF
996: 
997:         IF USED("cursor_4c_Contas")
998:             loc_nArea = SELECT()
999:             SELECT cursor_4c_Contas
1000:             LOCATE FOR ALLTRIM(Iclis) = loc_cCodigo
1001:             IF FOUND()
1002:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
1003:                 THIS.txt_4c_DsContas.Enabled = .F.
1004:                 SELECT (loc_nArea)
1005:                 RETURN
1006:             ENDIF
1007:             SELECT (loc_nArea)
1008:         ENDIF
1009: 
1010:         THIS.AbrirLookupContas()
1011:     ENDPROC
1012: 
1013:     *==========================================================================
1014:     * VALIDARDSCONTAS - Valida descricao da conta (busca reversa por nome)
1015:     * Somente ativo quando CdContas estiver vazio (comportamento When original)
1016:     * Se nao encontrado, abre lookup FormBuscaAuxiliar
1017:     *==========================================================================
1018:     PROCEDURE ValidarDsContas()
1019:         LOCAL loc_cDesc, loc_nArea
1020: 
1021:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1022:             RETURN
1023:         ENDIF
1024: 
1025:         loc_cDesc = ALLTRIM(THIS.txt_4c_DsContas.Value)
1026: 
1027:         IF EMPTY(loc_cDesc)
1028:             THIS.txt_4c_CdContas.Value = ""
1029:             RETURN
1030:         ENDIF
1031: 
1032:         IF USED("cursor_4c_Contas")
1033:             loc_nArea = SELECT()
1034:             SELECT cursor_4c_Contas
1035:             LOCATE FOR UPPER(ALLTRIM(Rclis)) = UPPER(loc_cDesc)
1036:             IF FOUND()
1037:                 THIS.txt_4c_CdContas.Value   = ALLTRIM(Iclis)
1038:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
1039:                 THIS.txt_4c_DsContas.Enabled = .F.
1040:                 SELECT (loc_nArea)
1041:                 RETURN
1042:             ENDIF
1043:             SELECT (loc_nArea)
1044:         ENDIF
1045: 
1046:         THIS.AbrirLookupContas()
1047:     ENDPROC
1048: 
1049:     *==========================================================================
1050:     * ABRIRLOOKUPCONTAS - Abre FormBuscaAuxiliar para conta corrente
1051:     * Tabela: SigCdCli | Iclis (cod) | Rclis (nome/razao social)
1052:     *==========================================================================
1053:     PROCEDURE AbrirLookupContas()
1054:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1055: 
1056:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1057:             "SigCdCli", ;
1058:             "cursor_4c_BuscaContas", ;
1059:             "Iclis", ;
1060:             ALLTRIM(THIS.txt_4c_CdContas.Value), ;
1061:             "Buscar Conta Corrente")
1062: 
1063:         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1064:         loc_oBusca.mAddColuna("Rclis", "", "Nome / Raz" + CHR(227) + "o Social")
1065:         loc_oBusca.Show()
1066: 
1067:         IF loc_oBusca.this_lSelecionou
1068:             IF USED("cursor_4c_BuscaContas")
1069:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaContas.Iclis)
1070:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaContas.Rclis)
1071:                 THIS.txt_4c_CdContas.Value   = loc_cCodigo
1072:                 THIS.txt_4c_DsContas.Value   = loc_cDescricao
1073:                 THIS.txt_4c_DsContas.Enabled = .F.
1074:             ENDIF
1075:         ENDIF
1076: 
1077:         IF USED("cursor_4c_BuscaContas")
1078:             USE IN cursor_4c_BuscaContas
1079:         ENDIF
1080:         loc_oBusca.Release()
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * BTNVISUALIZARCLICK - Buttons(1): Preview do relatorio na tela
1085:     *==========================================================================
1086:     PROCEDURE BtnVisualizarClick()
1087:         THIS.FormParaRelatorio()
1088:         IF !THIS.this_oRelatorio.Visualizar()
1089:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
1090:         ENDIF
1091:     ENDPROC
1092: 
1093:     *==========================================================================
1094:     * BTNIMPRIMIRCLICK - Buttons(2): Imprime relatorio na impressora
1095:     *==========================================================================
1096:     PROCEDURE BtnImprimirClick()
1097:         THIS.FormParaRelatorio()
1098:         IF !THIS.this_oRelatorio.Imprimir()
1099:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1100:         ENDIF
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     * BTNEXCELCLICK - Buttons(3): Exporta dados do relatorio para arquivo Excel
1105:     *==========================================================================
1106:     PROCEDURE BtnExcelClick()
1107:         LOCAL loc_cArquivo
1108:         loc_cArquivo = PUTFILE("Salvar como Excel", ;
1109:             "SigReHtc_" + STRTRAN(DTOC(DATE()), "/", ""), ;
1110:             "XLS")
1111: 
1112:         IF EMPTY(loc_cArquivo)
1113:             RETURN
1114:         ENDIF
1115: 
1116:         THIS.FormParaRelatorio()
1117: 
1118:         IF THIS.this_oRelatorio.ExportarExcel(loc_cArquivo)
1119:             MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, ;
1120:                 "Exporta" + CHR(231) + CHR(227) + "o Excel")
1121:         ELSE
1122:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Exportar Excel")
1123:         ENDIF
1124:     ENDPROC
1125: 
1126:     *==========================================================================
1127:     * BTNSAIRCLICK - Buttons(4): Fecha o formulario
1128:     *==========================================================================
1129:     PROCEDURE BtnSairClick()
1130:         THIS.Release()
1131:     ENDPROC
1132: 
1133:     *==========================================================================
1134:     * BTNINCLUIRCLICK - Alias CRUD: nova consulta (limpa filtros e foca o
1135:     * primeiro campo). Em REPORT nao ha registro a incluir; "Incluir" mapeia
1136:     * para iniciar uma nova consulta com filtros vazios.
1137:     *==========================================================================
1138:     PROCEDURE BtnIncluirClick()
1139:         THIS.LimparCampos()
1140:         THIS.txt_4c_CdGrEstoque.SetFocus()
1141:     ENDPROC
1142: 
1143:     *==========================================================================
1144:     * BTNALTERARCLICK - Alias CRUD: modificar saida (imprime na impressora).
1145:     * Em REPORT "Alterar" mapeia para alterar o destino da saida do relatorio
1146:     * preparado (visualizacao na tela -> impressao em papel).
1147:     *==========================================================================
1148:     PROCEDURE BtnAlterarClick()
1149:         THIS.FormParaRelatorio()
1150:         IF !THIS.this_oRelatorio.Imprimir()
1151:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1152:         ENDIF
1153:     ENDPROC
1154: 
1155:     *==========================================================================
1156:     * BTNEXCLUIRCLICK - Alias CRUD: descartar resultado e fechar formulario.
1157:     * Em REPORT "Excluir" mapeia para abandonar a consulta atual (sair do form),
1158:     * sem efetuar qualquer operacao em banco de dados.
1159:     *==========================================================================
1160:     PROCEDURE BtnExcluirClick()
1161:         THIS.LimparCampos()
1162:         THIS.Release()
1163:     ENDPROC
1164: 
1165:     *==========================================================================
1166:     * BTNBUSCARCLICK - Preview do relatorio na tela (alias CRUD para Visualizar)
1167:     *==========================================================================
1168:     PROCEDURE BtnBuscarClick()
1169:         THIS.FormParaRelatorio()
1170:         IF !THIS.this_oRelatorio.Visualizar()
1171:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
1172:         ENDIF
1173:     ENDPROC
1174: 
1175:     *==========================================================================
1176:     * BTNENCERRARCLICK - Fecha o formulario (alias de BtnSairClick)
1177:     *==========================================================================
1178:     PROCEDURE BtnEncerrarClick()
1179:         THIS.Release()
1180:     ENDPROC
1181: 
1182:     *==========================================================================
1183:     * BTNSALVARCLICK - Alias CRUD: envia relatorio para a impressora
1184:     *==========================================================================
1185:     PROCEDURE BtnSalvarClick()
1186:         THIS.FormParaRelatorio()
1187:         IF !THIS.this_oRelatorio.Imprimir()
1188:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1189:         ENDIF
1190:     ENDPROC
1191: 
1192:     *==========================================================================
1193:     * BTNCANCELARCLICK - Alias CRUD: limpa filtros e foca primeiro campo
1194:     *==========================================================================
1195:     PROCEDURE BtnCancelarClick()
1196:         THIS.LimparCampos()
1197:         THIS.txt_4c_CdGrEstoque.SetFocus()
1198:     ENDPROC
1199: 
1200:     *==========================================================================
1201:     * FORMPARABO - Transfere valores do form para o BO (alias de FormParaRelatorio)
1202:     *==========================================================================
1203:     PROCEDURE FormParaBO()
1204:         THIS.FormParaRelatorio()
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * BOPARAFORM - Restaura campos do form a partir do estado do BO
1209:     *==========================================================================
1210:     PROCEDURE BOParaForm()
1211:         WITH THIS.this_oRelatorio
1212:             THIS.txt_4c__dt_inicial.Value     = .this_dDtInicial
1213:             THIS.txt_4c__dt_final.Value       = .this_dDtFinal
1214:             THIS.obj_4c_OptDatas.Value        = .this_nTpDat
1215:             THIS.txt_4c_CdGrEstoque.Value     = .this_cGrupo
1216:             THIS.txt_4c_DsGrEstoque.Value     = .this_cDsGrupo
1217:             THIS.txt_4c_CdContas.Value        = .this_cIclis
1218:             THIS.txt_4c_DsContas.Value        = .this_cDsContas
1219:             THIS.obj_4c_Op_Emitido.Value      = .this_nOpEmitido
1220:             THIS.obj_4c_Op_Cancelado.Value    = .this_nOpCancela
1221:             THIS.obj_4c_Op_Ordem.Value        = .this_nOpOrdem
1222:             THIS.obj_4c_Op_Baixados.Value     = .this_nOpBaixas
1223:         ENDWITH
1224:     ENDPROC
1225: 
1226:     *==========================================================================
1227:     * HABILITARCAMPOS - Habilita/desabilita todos os campos de filtro
1228:     * Em REPORT todos os campos de filtro sao sempre editaveis (par omitido = .T.)
1229:     *==========================================================================
1230:     PROCEDURE HabilitarCampos(par_lHabilitar)
1231:         LOCAL loc_lHab
1232:         loc_lHab = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", .T., par_lHabilitar)
1233: 
1234:         THIS.txt_4c_CdGrEstoque.Enabled  = loc_lHab
1235:         THIS.txt_4c_DsGrEstoque.Enabled  = loc_lHab
1236:         THIS.txt_4c_CdContas.Enabled     = loc_lHab
1237:         THIS.txt_4c_DsContas.Enabled     = loc_lHab
1238:         THIS.txt_4c__dt_inicial.Enabled  = loc_lHab
1239:         THIS.txt_4c__dt_final.Enabled    = loc_lHab
1240:         THIS.obj_4c_OptDatas.Enabled     = loc_lHab
1241:         THIS.obj_4c_Op_Emitido.Enabled   = loc_lHab
1242:         THIS.obj_4c_Op_Cancelado.Enabled = loc_lHab
1243:         THIS.obj_4c_Op_Ordem.Enabled     = loc_lHab
1244:         THIS.obj_4c_Op_Baixados.Enabled  = loc_lHab
1245:     ENDPROC
1246: 
1247:     *==========================================================================
1248:     * CARREGARLISTA - REPORT nao tem lista CRUD; retorna .T. sempre
1249:     *==========================================================================
1250:     PROCEDURE CarregarLista()
1251:         RETURN .T.
1252:     ENDPROC
1253: 
1254:     *==========================================================================
1255:     * AJUSTARBOTOESPORMODO - REPORT nao tem modos CRUD; botoes sempre ativos
1256:     *==========================================================================
1257:     PROCEDURE AjustarBotoesPorModo()
1258:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1259:             THIS.cmg_4c_Botoes.Enabled = .T.
1260:         ENDIF
1261:     ENDPROC
1262: 
1263:     *==========================================================================
1264:     * DESTROY - Libera recursos
1265:     *==========================================================================
1266:     PROCEDURE Destroy()
1267:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1268:             THIS.this_oRelatorio = .NULL.
1269:         ENDIF
1270:         DODEFAULT()
1271:     ENDPROC
1272: 
1273: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrehtcBO.prg):
*==============================================================================
* SIGREHTCBO.PRG
* Business Object para Relatorio de Cheques Emitidos (SIGREHTC)
* Herda de: RelatorioBase
*
* Filtros disponiveis (mapeados do codigo legado):
*   - Periodo (data inicial / data final) + tipo (Movimentacao ou Vencimento)
*   - Grupo de estoque/contabil (codigo + descricao)
*   - Conta (codigo Iclis + descricao)
*   - Opcoes de selecao: Emitido, Cancelado, Ordem, Baixados
*
* Tabela principal: SigCqChi
* Tabelas auxiliares: SigCdCli, SigOpFp, SigCdPit, SigMvPar, SigMvCcr
*==============================================================================

DEFINE CLASS sigrehtcBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Tipo de data: 1=Movimentacao, 2=Vencimento (optDatas)
    this_nTpDat         = 1

    *-- Grupo de estoque / contabil (getCdGrEstoque / getDsGrEstoque)
    this_cGrupo         = ""
    this_cDsGrupo       = ""

    *-- Conta corrente (getCdContas / getDsContas) - Iclis no banco
    this_cIclis         = ""
    this_cDsContas      = ""

    *-- Op_Emitido: 1=Emitido, 2=Nao Emitido, 3=Todos
    this_nOpEmitido     = 1

    *-- Op_Cancelado: 1=Validos, 2=Cancelados, 3=Todos
    this_nOpCancela     = 1

    *-- Op_Ordem: 1=por Copia, 2=por Data, 3=por Conta
    this_nOpOrdem       = 1

    *-- Op_Baixados: 1=Sim, 2=Nao
    this_nOpBaixas      = 1

    *-- Nome do cursor de resultado gerado por PrepararDados()
    this_cCursorDados   = "cursor_4c_Resultado"

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCqChi"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor para o relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_cOrdem
        LOCAL loc_cDtInicial, loc_cDtFinal
        LOCAL loc_cGrupos, loc_cContas
        LOCAL loc_cTitulo1, loc_cPeriodo, loc_cOrdemDesc, loc_cEmp
        LOCAL loc_nResult
        LOCAL loc_cFavor, loc_cHists, loc_cMoedas
        LOCAL loc_nCopia

        loc_lSucesso = .F.

        TRY
            loc_cEmp = go_4c_Sistema.cEmpresa

            *-- Titulo principal do relatorio
            loc_cTitulo1 = "Relat" + CHR(243) + "rio de Cheques Emitidos de " + ;
                DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                DTOC(THIS.this_dDtFinal) + " - " + ;
                IIF(THIS.this_nTpDat = 1, ;
                    "Movimenta" + CHR(231) + CHR(227) + "o", ;
                    "Vencimento")

            *-- Linha descritiva de grupo/conta para o relatorio
            IF !EMPTY(THIS.this_cGrupo)
                loc_cPeriodo = "Grupo : " + ALLTRIM(THIS.this_cGrupo) + ;
                    " - " + ALLTRIM(THIS.this_cDsGrupo) + " - "
            ELSE
                loc_cPeriodo = "Grupo : Todos - "
            ENDIF

            IF !EMPTY(THIS.this_cIclis)
                loc_cPeriodo = loc_cPeriodo + "Conta : " + ;
                    ALLTRIM(THIS.this_cIclis) + " - " + ALLTRIM(THIS.this_cDsContas)
            ELSE
                loc_cPeriodo = loc_cPeriodo + "Conta : Todas"
            ENDIF

            *-- Descricao da ordem de impressao
            loc_cOrdemDesc = "Emiss" + CHR(227) + "o em Ordem de " + ;
                IIF(THIS.this_nOpOrdem = 1, ;
                    "N" + CHR(250) + "mero de C" + CHR(243) + "pia", ;
                    IIF(THIS.this_nOpOrdem = 2, "Data", "Conta"))

            *-- Datas formatadas para SQL
            loc_cDtInicial = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinal   = "'" + ;
                PADL(ALLTRIM(STR(YEAR(THIS.this_dDtFinal),  4, 0)), 4, "0") + "-" + ;
                PADL(ALLTRIM(STR(MONTH(THIS.this_dDtFinal), 2, 0)), 2, "0") + "-" + ;
                PADL(ALLTRIM(STR(DAY(THIS.this_dDtFinal),   2, 0)), 2, "0") + ;
                " 23:59:59'"

            *-- Campo de data e clausulas opcionais
            loc_cOrdem  = IIF(THIS.this_nTpDat = 1, "Datas", "Vencs")
            loc_cContas = IIF(EMPTY(THIS.this_cIclis), "", ;
                " AND Contas = " + EscaparSQL(THIS.this_cIclis))
            loc_cGrupos = IIF(EMPTY(THIS.this_cGrupo), "", ;
                " AND Grupos = " + EscaparSQL(THIS.this_cGrupo))

            *-- Query principal em SigCqChi
            loc_cSQL = "SELECT * FROM SigCqChi" + ;
                " WHERE " + loc_cOrdem + ;
                " BETWEEN " + loc_cDtInicial + " AND " + loc_cDtFinal + ;
                loc_cGrupos + loc_cContas + ;
                " ORDER BY " + loc_cOrdem

            IF USED("cursor_4c_SigCqChi")
                USE IN cursor_4c_SigCqChi
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCqChi")

            IF loc_nResult >= 0
                *-- Recria cursor de resultado com estrutura identica ao original
                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Resultado ( ;
                    NCopias   N(6,0),  ;
                    Favos     C(40),   ;
                    Valors    N(12,2), ;
                    Vencs     D,       ;
                    Datas     D,       ;
                    Hists     C(60),   ;
                    Valos     N(12,2), ;
                    Emps      C(3),    ;
                    Dopes     C(20),   ;
                    MascNum   C(6),    ;
                    Cheques   C(26),   ;
                    Cancelas  L,       ;
                    Moedas    C(3),    ;
                    Periodos  C(254),  ;
                    cEmpresas C(50),   ;
                    Grupos    C(10),   ;
                    Contas    C(10),   ;
                    Titulo1s  C(254),  ;
                    Ordem     C(254),  ;
                    Saltar    C(20),   ;
                    Total     L,       ;
                    Baixas    N(1,0),  ;
                    TotCon    N(12,4)  ;
                )
                SET NULL OFF

                *-- Indice conforme ordem selecionada
                DO CASE
                    CASE THIS.this_nOpOrdem = 1
                        INDEX ON STR(NCopias, 6) TAG Ncopias
                    CASE THIS.this_nOpOrdem = 2
                        IF THIS.this_nTpDat = 1
                            INDEX ON DTOS(Datas) + STR(NCopias, 6) TAG DataNCop
                        ELSE
                            INDEX ON DTOS(Vencs) + STR(NCopias, 6) TAG DataNCop
                        ENDIF
                    CASE THIS.this_nOpOrdem = 3
                        IF THIS.this_nTpDat = 1
                            INDEX ON Grupos + Contas + Cheques + ;
                                DTOS(Datas) + STR(NCopias, 6) TAG GruConDat
                        ELSE
                            INDEX ON Grupos + Contas + Cheques + ;
                                DTOS(Vencs) + STR(NCopias, 6) TAG GruConDat
                        ENDIF
                ENDCASE

                *-- Percorre SigCqChi e popula cursor de resultado
                SELECT cursor_4c_SigCqChi
                SCAN
                    *-- Filtro cancelamento/emissao
                    IF (THIS.this_nOpCancela = 1 .AND. ;
                            (cursor_4c_SigCqChi.Cancelas .OR. !cursor_4c_SigCqChi.Emitidos)) .OR. ;
                       (THIS.this_nOpCancela = 2 .AND. ;
                            (cursor_4c_SigCqChi.Emitidos .OR. !cursor_4c_SigCqChi.Cancelas))
                        LOOP
                    ENDIF

                    IF cursor_4c_SigCqChi.Cancelas
                        *-- Cancelado: insere sem busca de historico
                        INSERT INTO cursor_4c_Resultado ;
                            (NCopias, Favos, Valors, Vencs, Datas, ;
                             Emps, Dopes, MascNum, Cheques, Cancelas, ;
                             Periodos, cEmpresas, Grupos, Contas, ;
                             Titulo1s, Ordem, Saltar, Total, Baixas) ;
                        VALUES ;
                            (cursor_4c_SigCqChi.NCopias, ;
                             cursor_4c_SigCqChi.Favos, ;
                             cursor_4c_SigCqChi.Valors, ;
                             IIF(ISNULL(cursor_4c_SigCqChi.Vencs), {}, TTOD(cursor_4c_SigCqChi.Vencs)), ;
                             IIF(ISNULL(cursor_4c_SigCqChi.Datas), {}, TTOD(cursor_4c_SigCqChi.Datas)), ;
                             cursor_4c_SigCqChi.Emps, ;
                             cursor_4c_SigCqChi.Dopes, ;
                             PADL(ALLTRIM(STR(cursor_4c_SigCqChi.Numes, 6, 0)), 6, "0"), ;
                             cursor_4c_SigCqChi.Bancos + "-" + cursor_4c_SigCqChi.Agencias + ;
                                 "-" + cursor_4c_SigCqChi.Ncontas + ;
                                 "-" + cursor_4c_SigCqChi.NCheques, ;
                             cursor_4c_SigCqChi.Cancelas, ;
                             loc_cPeriodo, ;
                             loc_cEmp, ;
                             cursor_4c_SigCqChi.Grupos, ;
                             cursor_4c_SigCqChi.Contas, ;
                             loc_cTitulo1, ;
                             loc_cOrdemDesc, ;
                             IIF(THIS.this_nOpOrdem = 3, ;
                                 cursor_4c_SigCqChi.Grupos + cursor_4c_SigCqChi.Contas, ;
                                 ""), ;
                             (THIS.this_nOpOrdem = 3), ;
                             THIS.this_nOpBaixas)
                    ELSE
                        *-- Nao cancelado: busca historico em SigCdPit
                        loc_cFavor = cursor_4c_SigCqChi.Favos

                        loc_cSQL = "SELECT * FROM SigCdPit" + ;
                            " WHERE Emps = " + EscaparSQL(cursor_4c_SigCqChi.Emps) + ;
                            " AND Dopes = " + EscaparSQL(cursor_4c_SigCqChi.Dopes) + ;
                            " AND Numes = " + FormatarNumeroSQL(cursor_4c_SigCqChi.Numes)

                        IF USED("cursor_4c_SigCdPit")
                            USE IN cursor_4c_SigCdPit
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPit")

                        IF loc_nResult > 0
                            SELECT cursor_4c_SigCdPit
                            SCAN
                                IF cursor_4c_SigCdPit.Tipos = "P"
                                    loc_cSQL = "SELECT * FROM SigMvPar" + ;
                                        " WHERE Emps = " + EscaparSQL(cursor_4c_SigCdPit.Empos) + ;
                                        " AND Nopers = " + FormatarNumeroSQL(cursor_4c_SigCdPit.Nopers)

                                    IF USED("cursor_4c_SigMvPar")
                                        USE IN cursor_4c_SigMvPar
                                    ENDIF

                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvPar")

                                    IF loc_nResult > 0
                                        SELECT cursor_4c_SigMvPar
                                        loc_cHists  = LEFT( ;
                                            cursor_4c_SigMvPar.Emps + ;
                                            ALLTRIM(cursor_4c_SigMvPar.Dopes) + " " + ;
                                            ALLTRIM(PADL(ALLTRIM(STR(cursor_4c_SigMvPar.Numes, 6, 0)), 6, "0")) + ;
                                            " ( " + ALLTRIM(cursor_4c_SigMvPar.Fpags) + " ) ", 60)
                                        loc_cMoedas = cursor_4c_SigMvPar.Moefpgs
                                    ELSE
                                        loc_cHists  = ""
                                        loc_cMoedas = ""
                                    ENDIF
                                ELSE
                                    loc_cSQL = "SELECT * FROM SigMvCcr" + ;
                                        " WHERE Emps = " + EscaparSQL(cursor_4c_SigCdPit.Empos) + ;
                                        " AND Nopers = " + FormatarNumeroSQL(cursor_4c_SigCdPit.Nopers)

                                    IF USED("cursor_4c_SigMvCcr")
                                        USE IN cursor_4c_SigMvCcr
                                    ENDIF

                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCcr")

                                    IF loc_nResult > 0
                                        SELECT cursor_4c_SigMvCcr
                                        loc_cHists  = NVL(cursor_4c_SigMvCcr.Hists, "")
                                        loc_cMoedas = cursor_4c_SigMvCcr.Moedas
                                    ELSE
                                        loc_cHists  = ""
                                        loc_cMoedas = ""
                                    ENDIF
                                ENDIF

                                INSERT INTO cursor_4c_Resultado ;
                                    (NCopias, Favos, Valors, Vencs, Datas, ;
                                     Hists, Moedas, Emps, Dopes, MascNum, ;
                                     Cheques, Valos, Cancelas, Periodos, ;
                                     cEmpresas, Grupos, Contas, Titulo1s, ;
                                     Ordem, Saltar, Total, Baixas) ;
                                VALUES ;
                                    (cursor_4c_SigCqChi.NCopias, ;
                                     loc_cFavor, ;
                                     cursor_4c_SigCqChi.Valors, ;
                                     IIF(ISNULL(cursor_4c_SigCqChi.Vencs), {}, ;
                                         TTOD(cursor_4c_SigCqChi.Vencs)), ;
                                     IIF(ISNULL(cursor_4c_SigCqChi.Datas), {}, ;
                                         TTOD(cursor_4c_SigCqChi.Datas)), ;
                                     loc_cHists, ;
                                     loc_cMoedas, ;
                                     cursor_4c_SigCqChi.Emps, ;
                                     cursor_4c_SigCqChi.Dopes, ;
                                     PADL(ALLTRIM(STR(cursor_4c_SigCqChi.Numes, 6, 0)), 6, "0"), ;
                                     cursor_4c_SigCqChi.Bancos + "-" + ;
                                         cursor_4c_SigCqChi.Agencias + "-" + ;
                                         cursor_4c_SigCqChi.Ncontas + "-" + ;
                                         cursor_4c_SigCqChi.NCheques, ;
                                     cursor_4c_SigCdPit.Acertos, ;
                                     cursor_4c_SigCqChi.Cancelas, ;
                                     loc_cPeriodo, ;
                                     loc_cEmp, ;
                                     cursor_4c_SigCqChi.Grupos, ;
                                     cursor_4c_SigCqChi.Contas, ;
                                     loc_cTitulo1, ;
                                     loc_cOrdemDesc, ;
                                     IIF(THIS.this_nOpOrdem = 3, ;
                                         cursor_4c_SigCqChi.Grupos + cursor_4c_SigCqChi.Contas, ;
                                         ""), ;
                                     (THIS.this_nOpOrdem = 3), ;
                                     THIS.this_nOpBaixas)

                                loc_cFavor = ""
                                SELECT cursor_4c_SigCdPit
                            ENDSCAN
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigCqChi
                ENDSCAN

                *-- Calculo TotCon para ordem por Conta
                SELECT cursor_4c_Resultado
                GO TOP

                IF THIS.this_nOpOrdem = 3
                    loc_nCopia = 0
                    DO WHILE !EOF()
                        IF loc_nCopia != NCopias
                            loc_nCopia = NCopias
                            REPLACE TotCon WITH Valors
                        ENDIF
                        SKIP
                    ENDDO
                    GO TOP
                ENDIF

                *-- Limpa cursores auxiliares
                IF USED("cursor_4c_SigCqChi")
                    USE IN cursor_4c_SigCqChi
                ENDIF
                IF USED("cursor_4c_SigCdPit")
                    USE IN cursor_4c_SigCdPit
                ENDIF
                IF USED("cursor_4c_SigMvPar")
                    USE IN cursor_4c_SigMvPar
                ENDIF
                IF USED("cursor_4c_SigMvCcr")
                    USE IN cursor_4c_SigMvCcr
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar cheques de SigCqChi"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)

                IF !EOF()
                    loc_cFrx = gc_4c_CaminhoBase + "reports\SigReHtc.frx"

                    IF !FILE(loc_cFrx)
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                            "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                        MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    ELSE
                        REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)

                IF !EOF()
                    loc_cFrx = gc_4c_CaminhoBase + "reports\SigReHtc.frx"

                    IF !FILE(loc_cFrx)
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                            "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                        MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    ELSE
                        REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContas - Popula cursor de contas para lookup no form
    * Substitui o crContas do Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContas()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT b.iclis, b.rclis" + ;
                " FROM SigOpFp a, SigCdCli b" + ;
                " WHERE a.emichqs = 1 AND b.iclis = a.contads" + ;
                " ORDER BY b.iclis"

            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contas")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar lista de contas"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "BuscarContas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel(par_cArquivo)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                IF !EOF()
                    COPY TO (par_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhum dado encontrado para exportar.", ;
                        "Exportar Excel")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao preparar dados para exporta" + ;
                    CHR(231) + CHR(227) + "o"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Resultado")
            USE IN cursor_4c_Resultado
        ENDIF
        IF USED("cursor_4c_SigCqChi")
            USE IN cursor_4c_SigCqChi
        ENDIF
        IF USED("cursor_4c_SigCdPit")
            USE IN cursor_4c_SigCdPit
        ENDIF
        IF USED("cursor_4c_SigMvPar")
            USE IN cursor_4c_SigMvPar
        ENDIF
        IF USED("cursor_4c_SigMvCcr")
            USE IN cursor_4c_SigMvCcr
        ENDIF
        IF USED("cursor_4c_Contas")
            USE IN cursor_4c_Contas
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

