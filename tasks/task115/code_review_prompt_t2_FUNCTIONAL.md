# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehtc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1267 linhas total):

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
547:                 .Left      = 92
548:                 .Top       = 5
549:                 .AutoSize  = .T.
550:                 .ForeColor = RGB(90, 90, 90)
551:                 .Themes    = .F.
552:                 .Visible   = .T.
553:             ENDWITH
554: 
555:             WITH .Buttons(3)

*-- Linhas 568 a 612:
568:             ENDWITH
569:         ENDWITH
570: 
571:         *-- OptionGroup: Op_Cancelado (Validos / Cancelados / Todos)
572:         THIS.AddObject("obj_4c_Op_Cancelado", "OptionGroup")
573:         WITH THIS.obj_4c_Op_Cancelado
574:             .Top           = 219
575:             .Left          = 248
576:             .Width         = 262
577:             .Height        = 24
578:             .ButtonCount   = 3
579:             .BackStyle     = 0
580:             .BorderStyle   = 0
581:             .Value         = 1
582:             .SpecialEffect = 0
583:             .AutoSize      = .F.
584:             .Visible       = .T.
585: 
586:             WITH .Buttons(1)
587:                 .BackStyle = 0
588:                 .Caption   = "V" + CHR(225) + "lidos"
589:                 .Height    = 15
590:                 .Left      = 5
591:                 .Top       = 5
592:                 .Width     = 51
593:                 .AutoSize  = .T.
594:                 .ForeColor = RGB(90, 90, 90)
595:                 .Themes    = .F.
596:                 .Visible   = .T.
597:             ENDWITH
598: 
599:             WITH .Buttons(2)
600:                 .FontName  = "Tahoma"
601:                 .FontSize  = 8
602:                 .BackStyle = 0
603:                 .Caption   = "Cancelados"
604:                 .Left      = 92
605:                 .Top       = 5
606:                 .AutoSize  = .T.
607:                 .ForeColor = RGB(90, 90, 90)
608:                 .Themes    = .F.
609:                 .Visible   = .T.
610:             ENDWITH
611: 
612:             WITH .Buttons(3)

*-- Linhas 625 a 669:
625:             ENDWITH
626:         ENDWITH
627: 
628:         *-- OptionGroup: Op_Ordem (por Copia / por Data / por Conta)
629:         THIS.AddObject("obj_4c_Op_Ordem", "OptionGroup")
630:         WITH THIS.obj_4c_Op_Ordem
631:             .Top           = 172
632:             .Left          = 248
633:             .Width         = 280
634:             .Height        = 27
635:             .ButtonCount   = 3
636:             .BackStyle     = 0
637:             .BorderStyle   = 0
638:             .Value         = 1
639:             .SpecialEffect = 0
640:             .Visible       = .T.
641: 
642:             WITH .Buttons(1)
643:                 .BackStyle = 0
644:                 .Caption   = "por C" + CHR(243) + "pia"
645:                 .Height    = 17
646:                 .Left      = 5
647:                 .Style     = 0
648:                 .Top       = 5
649:                 .Width     = 72
650:                 .AutoSize  = .F.
651:                 .ForeColor = RGB(90, 90, 90)
652:                 .Themes    = .F.
653:                 .Visible   = .T.
654:             ENDWITH
655: 
656:             WITH .Buttons(2)
657:                 .FontName  = "Tahoma"
658:                 .FontSize  = 8
659:                 .BackStyle = 0
660:                 .Caption   = "por Data"
661:                 .Height    = 17
662:                 .Left      = 92
663:                 .Style     = 0
664:                 .Top       = 5
665:                 .Width     = 72
666:                 .AutoSize  = .F.
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .Themes    = .F.
669:                 .Visible   = .T.

*-- Linhas 686 a 1267:
686:             ENDWITH
687:         ENDWITH
688: 
689:         *-- OptionGroup: Op_Baixados (Sim / Nao)
690:         THIS.AddObject("obj_4c_Op_Baixados", "OptionGroup")
691:         WITH THIS.obj_4c_Op_Baixados
692:             .Top           = 240
693:             .Left          = 248
694:             .Width         = 144
695:             .Height        = 27
696:             .ButtonCount   = 2
697:             .BackStyle     = 0
698:             .BorderStyle   = 0
699:             .Value         = 1
700:             .SpecialEffect = 0
701:             .Visible       = .T.
702: 
703:             WITH .Buttons(1)
704:                 .BackStyle = 0
705:                 .Caption   = "Sim"
706:                 .Height    = 17
707:                 .Left      = 5
708:                 .Style     = 0
709:                 .Top       = 5
710:                 .Width     = 40
711:                 .AutoSize  = .F.
712:                 .ForeColor = RGB(90, 90, 90)
713:                 .Themes    = .F.
714:                 .Visible   = .T.
715:             ENDWITH
716: 
717:             WITH .Buttons(2)
718:                 .FontName  = "Tahoma"
719:                 .FontSize  = 8
720:                 .BackStyle = 0
721:                 .Caption   = "N" + CHR(227) + "o"
722:                 .Height    = 17
723:                 .Left      = 92
724:                 .Style     = 0
725:                 .Top       = 5
726:                 .Width     = 40
727:                 .AutoSize  = .F.
728:                 .ForeColor = RGB(90, 90, 90)
729:                 .Themes    = .F.
730:                 .Visible   = .T.
731:             ENDWITH
732:         ENDWITH
733: 
734:         *-- BINDEVENTs: Grupo de Estoque - valida ao pressionar ENTER/TAB/F4
735:         BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
736:         BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
737: 
738:         *-- BINDEVENTs: Conta - valida ao pressionar ENTER/TAB/F4
739:         BINDEVENT(THIS.txt_4c_CdContas, "KeyPress", THIS, "TeclaCdContas")
740:         BINDEVENT(THIS.txt_4c_DsContas, "KeyPress", THIS, "TeclaDsContas")
741:     ENDPROC
742: 
743:     *==========================================================================
744:     * LIMPARCAMPOS - Reseta todos os campos de filtro para valores padrao
745:     *==========================================================================
746:     PROCEDURE LimparCampos()
747:         THIS.txt_4c_CdGrEstoque.Value    = ""
748:         THIS.txt_4c_DsGrEstoque.Value    = ""
749:         THIS.txt_4c_DsGrEstoque.Enabled  = .T.
750:         THIS.txt_4c_CdContas.Value       = ""
751:         THIS.txt_4c_DsContas.Value       = ""
752:         THIS.txt_4c_DsContas.Enabled     = .T.
753:         THIS.txt_4c__dt_inicial.Value    = {}
754:         THIS.txt_4c__dt_final.Value      = {}
755:         THIS.obj_4c_OptDatas.Value       = 1
756:         THIS.obj_4c_Op_Emitido.Value     = 1
757:         THIS.obj_4c_Op_Cancelado.Value   = 1
758:         THIS.obj_4c_Op_Ordem.Value       = 1
759:         THIS.obj_4c_Op_Baixados.Value    = 1
760:     ENDPROC
761: 
762:     *==========================================================================
763:     * ATUALIZARESTADOCONTROLES - Override: REPORT nao usa modo CRUD
764:     *==========================================================================
765:     PROCEDURE AtualizarEstadoControles()
766:         RETURN
767:     ENDPROC
768: 
769:     *==========================================================================
770:     * ALTERNARPAGINA - REPORT eh FLAT (1 pagina logica permanente)
771:     *==========================================================================
772:     PROCEDURE AlternarPagina(par_nPagina)
773:         LOCAL loc_nPagina
774:         loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
775:         IF loc_nPagina < 1
776:             loc_nPagina = 1
777:         ENDIF
778:         THIS.this_nPaginaAtual = loc_nPagina
779:     ENDPROC
780: 
781:     *==========================================================================
782:     * FORMPARARELATORIO - Transfere valores do form para o BO
783:     *==========================================================================
784:     PROTECTED PROCEDURE FormParaRelatorio()
785:         WITH THIS.this_oRelatorio
786:             .this_dDtInicial = THIS.txt_4c__dt_inicial.Value
787:             .this_dDtFinal   = THIS.txt_4c__dt_final.Value
788:             .this_nTpDat     = THIS.obj_4c_OptDatas.Value
789:             .this_cGrupo     = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
790:             .this_cDsGrupo   = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
791:             .this_cIclis     = ALLTRIM(THIS.txt_4c_CdContas.Value)
792:             .this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
793:             .this_nOpEmitido = THIS.obj_4c_Op_Emitido.Value
794:             .this_nOpCancela = THIS.obj_4c_Op_Cancelado.Value
795:             .this_nOpOrdem   = THIS.obj_4c_Op_Ordem.Value
796:             .this_nOpBaixas  = THIS.obj_4c_Op_Baixados.Value
797:         ENDWITH
798:     ENDPROC
799: 
800:     *==========================================================================
801:     * VALIDARCDGRESTOQUE - Valida codigo do grupo contra SigCdGrp
802:     * cgrus=code(3), dgrus=desc(20)
803:     *==========================================================================
804:     PROCEDURE ValidarCdGrEstoque()
805:         LOCAL loc_cCodigo, loc_cSQL, loc_nResult
806:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
807: 
808:         IF EMPTY(loc_cCodigo)
809:             THIS.txt_4c_DsGrEstoque.Value   = ""
810:             THIS.txt_4c_DsGrEstoque.Enabled = .T.
811:             RETURN
812:         ENDIF
813: 
814:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp"
815: 
816:         IF USED("cursor_4c_GrpVal")
817:             USE IN cursor_4c_GrpVal
818:         ENDIF
819: 
820:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
821: 
822:         IF loc_nResult > 0
823:             SELECT cursor_4c_GrpVal
824:             LOCATE FOR ALLTRIM(cgrus) = ALLTRIM(loc_cCodigo)
825:             IF FOUND()
826:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
827:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
828:                 USE IN cursor_4c_GrpVal
829:                 RETURN
830:             ENDIF
831:             USE IN cursor_4c_GrpVal
832:         ENDIF
833: 
834:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado: " + loc_cCodigo, "Aviso")
835:         THIS.txt_4c_CdGrEstoque.Value   = ""
836:         THIS.txt_4c_DsGrEstoque.Value   = ""
837:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
838:         THIS.txt_4c_CdGrEstoque.SetFocus()
839:     ENDPROC
840: 
841:     *==========================================================================
842:     * VALIDARDSGRESTOQUE - Valida descricao do grupo contra SigCdGrp
843:     * Ativo somente quando txt_4c_CdGrEstoque estiver vazio (When original)
844:     *==========================================================================
845:     PROCEDURE ValidarDsGrEstoque()
846:         LOCAL loc_cDesc, loc_cSQL, loc_nResult
847:         loc_cDesc = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
848: 
849:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value))
850:             RETURN
851:         ENDIF
852: 
853:         IF EMPTY(loc_cDesc)
854:             THIS.txt_4c_CdGrEstoque.Value = ""
855:             RETURN
856:         ENDIF
857: 
858:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp"
859: 
860:         IF USED("cursor_4c_GrpDsVal")
861:             USE IN cursor_4c_GrpDsVal
862:         ENDIF
863: 
864:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDsVal")
865: 
866:         IF loc_nResult > 0
867:             SELECT cursor_4c_GrpDsVal
868:             LOCATE FOR UPPER(ALLTRIM(dgrus)) = UPPER(loc_cDesc)
869:             IF FOUND()
870:                 THIS.txt_4c_CdGrEstoque.Value   = ALLTRIM(cgrus)
871:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
872:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
873:                 USE IN cursor_4c_GrpDsVal
874:                 RETURN
875:             ENDIF
876:             USE IN cursor_4c_GrpDsVal
877:         ENDIF
878: 
879:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
880:         THIS.txt_4c_CdGrEstoque.Value   = ""
881:         THIS.txt_4c_DsGrEstoque.Value   = ""
882:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
883:         THIS.txt_4c_DsGrEstoque.SetFocus()
884:     ENDPROC
885: 
886:     *==========================================================================
887:     * TECLACDGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida codigo do grupo
888:     *==========================================================================
889:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShift)
890:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
891:             THIS.AbrirLookupGrEstoque()
892:         ELSE
893:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
894:             THIS.ValidarCdGrEstoque()
895:             ENDIF
896:         ENDIF
897:     ENDPROC
898: 
899:     *==========================================================================
900:     * TECLADSGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida descricao do grupo
901:     *                              F4(115) abre lookup direto
902:     *==========================================================================
903:     PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShift)
904:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
905:             THIS.AbrirLookupGrEstoque()
906:         ELSE
907:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
908:             THIS.ValidarDsGrEstoque()
909:             ENDIF
910:         ENDIF
911:     ENDPROC
912: 
913:     *==========================================================================
914:     * ABRIRLOOKUPGRESTOQUE - Abre FormBuscaAuxiliar para grupo de estoque
915:     * Tabela: SigCdGrp | cgrus (cod) | dgrus (desc)
916:     *==========================================================================
917:     PROCEDURE AbrirLookupGrEstoque()
918:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
919: 
920:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
921:             "SigCdGrp", ;
922:             "cursor_4c_BuscaGrp", ;
923:             "cgrus", ;
924:             ALLTRIM(THIS.txt_4c_CdGrEstoque.Value), ;
925:             "Buscar Grupo de Estoque")
926: 
927:         loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
928:         loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
929:         loc_oBusca.Show()
930: 
931:         IF loc_oBusca.this_lSelecionou
932:             IF USED("cursor_4c_BuscaGrp")
933:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
934:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
935:                 THIS.txt_4c_CdGrEstoque.Value   = loc_cCodigo
936:                 THIS.txt_4c_DsGrEstoque.Value   = loc_cDescricao
937:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
938:             ENDIF
939:         ENDIF
940: 
941:         IF USED("cursor_4c_BuscaGrp")
942:             USE IN cursor_4c_BuscaGrp
943:         ENDIF
944:         loc_oBusca.Release()
945:     ENDPROC
946: 
947:     *==========================================================================
948:     * TECLACDCONTAS - KeyPress: ENTER(13)/TAB(9) valida codigo da conta
949:     *                           F4(115) abre lookup direto
950:     *==========================================================================
951:     PROCEDURE TeclaCdContas(par_nKeyCode, par_nShift)
952:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
953:             THIS.AbrirLookupContas()
954:         ELSE
955:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
956:             THIS.ValidarCdContas()
957:             ENDIF
958:         ENDIF
959:     ENDPROC
960: 
961:     *==========================================================================
962:     * TECLADSCONTAS - KeyPress: ENTER(13)/TAB(9) valida descricao da conta
963:     *                           F4(115) abre lookup direto
964:     * Somente ativo quando CdContas estiver vazio (comportamento When original)
965:     *==========================================================================
966:     PROCEDURE TeclaDsContas(par_nKeyCode, par_nShift)
967:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
968:             THIS.AbrirLookupContas()
969:         ELSE
970:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
971:             THIS.ValidarDsContas()
972:             ENDIF
973:         ENDIF
974:     ENDPROC
975: 
976:     *==========================================================================
977:     * VALIDARCDCONTAS - Valida codigo da conta contra cursor_4c_Contas
978:     * Iclis=codigo, Rclis=nome/razao social
979:     * Se nao encontrado, abre lookup FormBuscaAuxiliar
980:     *==========================================================================
981:     PROCEDURE ValidarCdContas()
982:         LOCAL loc_cCodigo, loc_nArea
983:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdContas.Value)
984: 
985:         IF EMPTY(loc_cCodigo)
986:             THIS.txt_4c_DsContas.Value   = ""
987:             THIS.txt_4c_DsContas.Enabled = .T.
988:             RETURN
989:         ENDIF
990: 
991:         IF USED("cursor_4c_Contas")
992:             loc_nArea = SELECT()
993:             SELECT cursor_4c_Contas
994:             LOCATE FOR ALLTRIM(Iclis) = loc_cCodigo
995:             IF FOUND()
996:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
997:                 THIS.txt_4c_DsContas.Enabled = .F.
998:                 SELECT (loc_nArea)
999:                 RETURN
1000:             ENDIF
1001:             SELECT (loc_nArea)
1002:         ENDIF
1003: 
1004:         THIS.AbrirLookupContas()
1005:     ENDPROC
1006: 
1007:     *==========================================================================
1008:     * VALIDARDSCONTAS - Valida descricao da conta (busca reversa por nome)
1009:     * Somente ativo quando CdContas estiver vazio (comportamento When original)
1010:     * Se nao encontrado, abre lookup FormBuscaAuxiliar
1011:     *==========================================================================
1012:     PROCEDURE ValidarDsContas()
1013:         LOCAL loc_cDesc, loc_nArea
1014: 
1015:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1016:             RETURN
1017:         ENDIF
1018: 
1019:         loc_cDesc = ALLTRIM(THIS.txt_4c_DsContas.Value)
1020: 
1021:         IF EMPTY(loc_cDesc)
1022:             THIS.txt_4c_CdContas.Value = ""
1023:             RETURN
1024:         ENDIF
1025: 
1026:         IF USED("cursor_4c_Contas")
1027:             loc_nArea = SELECT()
1028:             SELECT cursor_4c_Contas
1029:             LOCATE FOR UPPER(ALLTRIM(Rclis)) = UPPER(loc_cDesc)
1030:             IF FOUND()
1031:                 THIS.txt_4c_CdContas.Value   = ALLTRIM(Iclis)
1032:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
1033:                 THIS.txt_4c_DsContas.Enabled = .F.
1034:                 SELECT (loc_nArea)
1035:                 RETURN
1036:             ENDIF
1037:             SELECT (loc_nArea)
1038:         ENDIF
1039: 
1040:         THIS.AbrirLookupContas()
1041:     ENDPROC
1042: 
1043:     *==========================================================================
1044:     * ABRIRLOOKUPCONTAS - Abre FormBuscaAuxiliar para conta corrente
1045:     * Tabela: SigCdCli | Iclis (cod) | Rclis (nome/razao social)
1046:     *==========================================================================
1047:     PROCEDURE AbrirLookupContas()
1048:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1049: 
1050:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1051:             "SigCdCli", ;
1052:             "cursor_4c_BuscaContas", ;
1053:             "Iclis", ;
1054:             ALLTRIM(THIS.txt_4c_CdContas.Value), ;
1055:             "Buscar Conta Corrente")
1056: 
1057:         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1058:         loc_oBusca.mAddColuna("Rclis", "", "Nome / Raz" + CHR(227) + "o Social")
1059:         loc_oBusca.Show()
1060: 
1061:         IF loc_oBusca.this_lSelecionou
1062:             IF USED("cursor_4c_BuscaContas")
1063:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaContas.Iclis)
1064:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaContas.Rclis)
1065:                 THIS.txt_4c_CdContas.Value   = loc_cCodigo
1066:                 THIS.txt_4c_DsContas.Value   = loc_cDescricao
1067:                 THIS.txt_4c_DsContas.Enabled = .F.
1068:             ENDIF
1069:         ENDIF
1070: 
1071:         IF USED("cursor_4c_BuscaContas")
1072:             USE IN cursor_4c_BuscaContas
1073:         ENDIF
1074:         loc_oBusca.Release()
1075:     ENDPROC
1076: 
1077:     *==========================================================================
1078:     * BTNVISUALIZARCLICK - Buttons(1): Preview do relatorio na tela
1079:     *==========================================================================
1080:     PROCEDURE BtnVisualizarClick()
1081:         THIS.FormParaRelatorio()
1082:         IF !THIS.this_oRelatorio.Visualizar()
1083:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
1084:         ENDIF
1085:     ENDPROC
1086: 
1087:     *==========================================================================
1088:     * BTNIMPRIMIRCLICK - Buttons(2): Imprime relatorio na impressora
1089:     *==========================================================================
1090:     PROCEDURE BtnImprimirClick()
1091:         THIS.FormParaRelatorio()
1092:         IF !THIS.this_oRelatorio.Imprimir()
1093:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1094:         ENDIF
1095:     ENDPROC
1096: 
1097:     *==========================================================================
1098:     * BTNEXCELCLICK - Buttons(3): Exporta dados do relatorio para arquivo Excel
1099:     *==========================================================================
1100:     PROCEDURE BtnExcelClick()
1101:         LOCAL loc_cArquivo
1102:         loc_cArquivo = PUTFILE("Salvar como Excel", ;
1103:             "SigReHtc_" + STRTRAN(DTOC(DATE()), "/", ""), ;
1104:             "XLS")
1105: 
1106:         IF EMPTY(loc_cArquivo)
1107:             RETURN
1108:         ENDIF
1109: 
1110:         THIS.FormParaRelatorio()
1111: 
1112:         IF THIS.this_oRelatorio.ExportarExcel(loc_cArquivo)
1113:             MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, ;
1114:                 "Exporta" + CHR(231) + CHR(227) + "o Excel")
1115:         ELSE
1116:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Exportar Excel")
1117:         ENDIF
1118:     ENDPROC
1119: 
1120:     *==========================================================================
1121:     * BTNSAIRCLICK - Buttons(4): Fecha o formulario
1122:     *==========================================================================
1123:     PROCEDURE BtnSairClick()
1124:         THIS.Release()
1125:     ENDPROC
1126: 
1127:     *==========================================================================
1128:     * BTNINCLUIRCLICK - Alias CRUD: nova consulta (limpa filtros e foca o
1129:     * primeiro campo). Em REPORT nao ha registro a incluir; "Incluir" mapeia
1130:     * para iniciar uma nova consulta com filtros vazios.
1131:     *==========================================================================
1132:     PROCEDURE BtnIncluirClick()
1133:         THIS.LimparCampos()
1134:         THIS.txt_4c_CdGrEstoque.SetFocus()
1135:     ENDPROC
1136: 
1137:     *==========================================================================
1138:     * BTNALTERARCLICK - Alias CRUD: modificar saida (imprime na impressora).
1139:     * Em REPORT "Alterar" mapeia para alterar o destino da saida do relatorio
1140:     * preparado (visualizacao na tela -> impressao em papel).
1141:     *==========================================================================
1142:     PROCEDURE BtnAlterarClick()
1143:         THIS.FormParaRelatorio()
1144:         IF !THIS.this_oRelatorio.Imprimir()
1145:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1146:         ENDIF
1147:     ENDPROC
1148: 
1149:     *==========================================================================
1150:     * BTNEXCLUIRCLICK - Alias CRUD: descartar resultado e fechar formulario.
1151:     * Em REPORT "Excluir" mapeia para abandonar a consulta atual (sair do form),
1152:     * sem efetuar qualquer operacao em banco de dados.
1153:     *==========================================================================
1154:     PROCEDURE BtnExcluirClick()
1155:         THIS.LimparCampos()
1156:         THIS.Release()
1157:     ENDPROC
1158: 
1159:     *==========================================================================
1160:     * BTNBUSCARCLICK - Preview do relatorio na tela (alias CRUD para Visualizar)
1161:     *==========================================================================
1162:     PROCEDURE BtnBuscarClick()
1163:         THIS.FormParaRelatorio()
1164:         IF !THIS.this_oRelatorio.Visualizar()
1165:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
1166:         ENDIF
1167:     ENDPROC
1168: 
1169:     *==========================================================================
1170:     * BTNENCERRARCLICK - Fecha o formulario (alias de BtnSairClick)
1171:     *==========================================================================
1172:     PROCEDURE BtnEncerrarClick()
1173:         THIS.Release()
1174:     ENDPROC
1175: 
1176:     *==========================================================================
1177:     * BTNSALVARCLICK - Alias CRUD: envia relatorio para a impressora
1178:     *==========================================================================
1179:     PROCEDURE BtnSalvarClick()
1180:         THIS.FormParaRelatorio()
1181:         IF !THIS.this_oRelatorio.Imprimir()
1182:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1183:         ENDIF
1184:     ENDPROC
1185: 
1186:     *==========================================================================
1187:     * BTNCANCELARCLICK - Alias CRUD: limpa filtros e foca primeiro campo
1188:     *==========================================================================
1189:     PROCEDURE BtnCancelarClick()
1190:         THIS.LimparCampos()
1191:         THIS.txt_4c_CdGrEstoque.SetFocus()
1192:     ENDPROC
1193: 
1194:     *==========================================================================
1195:     * FORMPARABO - Transfere valores do form para o BO (alias de FormParaRelatorio)
1196:     *==========================================================================
1197:     PROCEDURE FormParaBO()
1198:         THIS.FormParaRelatorio()
1199:     ENDPROC
1200: 
1201:     *==========================================================================
1202:     * BOPARAFORM - Restaura campos do form a partir do estado do BO
1203:     *==========================================================================
1204:     PROCEDURE BOParaForm()
1205:         WITH THIS.this_oRelatorio
1206:             THIS.txt_4c__dt_inicial.Value     = .this_dDtInicial
1207:             THIS.txt_4c__dt_final.Value       = .this_dDtFinal
1208:             THIS.obj_4c_OptDatas.Value        = .this_nTpDat
1209:             THIS.txt_4c_CdGrEstoque.Value     = .this_cGrupo
1210:             THIS.txt_4c_DsGrEstoque.Value     = .this_cDsGrupo
1211:             THIS.txt_4c_CdContas.Value        = .this_cIclis
1212:             THIS.txt_4c_DsContas.Value        = .this_cDsContas
1213:             THIS.obj_4c_Op_Emitido.Value      = .this_nOpEmitido
1214:             THIS.obj_4c_Op_Cancelado.Value    = .this_nOpCancela
1215:             THIS.obj_4c_Op_Ordem.Value        = .this_nOpOrdem
1216:             THIS.obj_4c_Op_Baixados.Value     = .this_nOpBaixas
1217:         ENDWITH
1218:     ENDPROC
1219: 
1220:     *==========================================================================
1221:     * HABILITARCAMPOS - Habilita/desabilita todos os campos de filtro
1222:     * Em REPORT todos os campos de filtro sao sempre editaveis (par omitido = .T.)
1223:     *==========================================================================
1224:     PROCEDURE HabilitarCampos(par_lHabilitar)
1225:         LOCAL loc_lHab
1226:         loc_lHab = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", .T., par_lHabilitar)
1227: 
1228:         THIS.txt_4c_CdGrEstoque.Enabled  = loc_lHab
1229:         THIS.txt_4c_DsGrEstoque.Enabled  = loc_lHab
1230:         THIS.txt_4c_CdContas.Enabled     = loc_lHab
1231:         THIS.txt_4c_DsContas.Enabled     = loc_lHab
1232:         THIS.txt_4c__dt_inicial.Enabled  = loc_lHab
1233:         THIS.txt_4c__dt_final.Enabled    = loc_lHab
1234:         THIS.obj_4c_OptDatas.Enabled     = loc_lHab
1235:         THIS.obj_4c_Op_Emitido.Enabled   = loc_lHab
1236:         THIS.obj_4c_Op_Cancelado.Enabled = loc_lHab
1237:         THIS.obj_4c_Op_Ordem.Enabled     = loc_lHab
1238:         THIS.obj_4c_Op_Baixados.Enabled  = loc_lHab
1239:     ENDPROC
1240: 
1241:     *==========================================================================
1242:     * CARREGARLISTA - REPORT nao tem lista CRUD; retorna .T. sempre
1243:     *==========================================================================
1244:     PROCEDURE CarregarLista()
1245:         RETURN .T.
1246:     ENDPROC
1247: 
1248:     *==========================================================================
1249:     * AJUSTARBOTOESPORMODO - REPORT nao tem modos CRUD; botoes sempre ativos
1250:     *==========================================================================
1251:     PROCEDURE AjustarBotoesPorModo()
1252:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1253:             THIS.cmg_4c_Botoes.Enabled = .T.
1254:         ENDIF
1255:     ENDPROC
1256: 
1257:     *==========================================================================
1258:     * DESTROY - Libera recursos
1259:     *==========================================================================
1260:     PROCEDURE Destroy()
1261:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1262:             THIS.this_oRelatorio = .NULL.
1263:         ENDIF
1264:         DODEFAULT()
1265:     ENDPROC
1266: 
1267: ENDDEFINE


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

