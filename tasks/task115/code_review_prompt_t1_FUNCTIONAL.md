# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Resultado' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehtc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1254 linhas total):

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

*-- Linhas 466 a 553:
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
493:                 .Visible   = .T.
494:             ENDWITH
495: 
496:             WITH .Buttons(2)
497:                 .FontName  = "Tahoma"
498:                 .FontSize  = 8
499:                 .BackStyle = 0
500:                 .Caption   = "Vencimento"
501:                 .Height    = 15
502:                 .Left      = 111
503:                 .Style     = 0
504:                 .Top       = 5
505:                 .Width     = 73
506:                 .AutoSize  = .T.
507:                 .ForeColor = RGB(90, 90, 90)
508:                 .Visible   = .T.
509:             ENDWITH
510:         ENDWITH
511: 
512:         *-- OptionGroup: Op_Emitido (Emitido / Nao Emitido / Todos)
513:         THIS.AddObject("obj_4c_Op_Emitido", "OptionGroup")
514:         WITH THIS.obj_4c_Op_Emitido
515:             .Top           = 197
516:             .Left          = 248
517:             .Width         = 262
518:             .Height        = 24
519:             .ButtonCount   = 3
520:             .BackStyle     = 0
521:             .BorderStyle   = 0
522:             .Value         = 1
523:             .SpecialEffect = 0
524:             .AutoSize      = .F.
525:             .Visible       = .T.
526: 
527:             WITH .Buttons(1)
528:                 .BackStyle = 0
529:                 .Caption   = "Emitido"
530:                 .Height    = 15
531:                 .Left      = 5
532:                 .Top       = 5
533:                 .Width     = 52
534:                 .AutoSize  = .T.
535:                 .ForeColor = RGB(90, 90, 90)
536:                 .Visible   = .T.
537:             ENDWITH
538: 
539:             WITH .Buttons(2)
540:                 .FontName  = "Tahoma"
541:                 .FontSize  = 8
542:                 .BackStyle = 0
543:                 .Caption   = "N" + CHR(227) + "o Emitido"
544:                 .Left      = 92
545:                 .Top       = 5
546:                 .AutoSize  = .T.
547:                 .ForeColor = RGB(90, 90, 90)
548:                 .Visible   = .T.
549:             ENDWITH
550: 
551:             WITH .Buttons(3)
552:                 .FontName  = "Tahoma"
553:                 .FontSize  = 8

*-- Linhas 563 a 607:
563:             ENDWITH
564:         ENDWITH
565: 
566:         *-- OptionGroup: Op_Cancelado (Validos / Cancelados / Todos)
567:         THIS.AddObject("obj_4c_Op_Cancelado", "OptionGroup")
568:         WITH THIS.obj_4c_Op_Cancelado
569:             .Top           = 219
570:             .Left          = 248
571:             .Width         = 262
572:             .Height        = 24
573:             .ButtonCount   = 3
574:             .BackStyle     = 0
575:             .BorderStyle   = 0
576:             .Value         = 1
577:             .SpecialEffect = 0
578:             .AutoSize      = .F.
579:             .Visible       = .T.
580: 
581:             WITH .Buttons(1)
582:                 .BackStyle = 0
583:                 .Caption   = "V" + CHR(225) + "lidos"
584:                 .Height    = 15
585:                 .Left      = 5
586:                 .Top       = 5
587:                 .Width     = 51
588:                 .AutoSize  = .T.
589:                 .ForeColor = RGB(90, 90, 90)
590:                 .Visible   = .T.
591:             ENDWITH
592: 
593:             WITH .Buttons(2)
594:                 .FontName  = "Tahoma"
595:                 .FontSize  = 8
596:                 .BackStyle = 0
597:                 .Caption   = "Cancelados"
598:                 .Left      = 92
599:                 .Top       = 5
600:                 .AutoSize  = .T.
601:                 .ForeColor = RGB(90, 90, 90)
602:                 .Visible   = .T.
603:             ENDWITH
604: 
605:             WITH .Buttons(3)
606:                 .FontName  = "Tahoma"
607:                 .FontSize  = 8

*-- Linhas 617 a 661:
617:             ENDWITH
618:         ENDWITH
619: 
620:         *-- OptionGroup: Op_Ordem (por Copia / por Data / por Conta)
621:         THIS.AddObject("obj_4c_Op_Ordem", "OptionGroup")
622:         WITH THIS.obj_4c_Op_Ordem
623:             .Top           = 172
624:             .Left          = 248
625:             .Width         = 280
626:             .Height        = 27
627:             .ButtonCount   = 3
628:             .BackStyle     = 0
629:             .BorderStyle   = 0
630:             .Value         = 1
631:             .SpecialEffect = 0
632:             .Visible       = .T.
633: 
634:             WITH .Buttons(1)
635:                 .BackStyle = 0
636:                 .Caption   = "por C" + CHR(243) + "pia"
637:                 .Height    = 17
638:                 .Left      = 5
639:                 .Style     = 0
640:                 .Top       = 5
641:                 .Width     = 72
642:                 .AutoSize  = .F.
643:                 .ForeColor = RGB(90, 90, 90)
644:                 .Visible   = .T.
645:             ENDWITH
646: 
647:             WITH .Buttons(2)
648:                 .FontName  = "Tahoma"
649:                 .FontSize  = 8
650:                 .BackStyle = 0
651:                 .Caption   = "por Data"
652:                 .Height    = 17
653:                 .Left      = 92
654:                 .Style     = 0
655:                 .Top       = 5
656:                 .Width     = 72
657:                 .AutoSize  = .F.
658:                 .ForeColor = RGB(90, 90, 90)
659:                 .Visible   = .T.
660:             ENDWITH
661: 

*-- Linhas 675 a 1254:
675:             ENDWITH
676:         ENDWITH
677: 
678:         *-- OptionGroup: Op_Baixados (Sim / Nao)
679:         THIS.AddObject("obj_4c_Op_Baixados", "OptionGroup")
680:         WITH THIS.obj_4c_Op_Baixados
681:             .Top           = 240
682:             .Left          = 248
683:             .Width         = 144
684:             .Height        = 27
685:             .ButtonCount   = 2
686:             .BackStyle     = 0
687:             .BorderStyle   = 0
688:             .Value         = 1
689:             .SpecialEffect = 0
690:             .Visible       = .T.
691: 
692:             WITH .Buttons(1)
693:                 .BackStyle = 0
694:                 .Caption   = "Sim"
695:                 .Height    = 17
696:                 .Left      = 5
697:                 .Style     = 0
698:                 .Top       = 5
699:                 .Width     = 40
700:                 .AutoSize  = .F.
701:                 .ForeColor = RGB(90, 90, 90)
702:                 .Visible   = .T.
703:             ENDWITH
704: 
705:             WITH .Buttons(2)
706:                 .FontName  = "Tahoma"
707:                 .FontSize  = 8
708:                 .BackStyle = 0
709:                 .Caption   = "N" + CHR(227) + "o"
710:                 .Height    = 17
711:                 .Left      = 92
712:                 .Style     = 0
713:                 .Top       = 5
714:                 .Width     = 40
715:                 .AutoSize  = .F.
716:                 .ForeColor = RGB(90, 90, 90)
717:                 .Visible   = .T.
718:             ENDWITH
719:         ENDWITH
720: 
721:         *-- BINDEVENTs: Grupo de Estoque - valida ao pressionar ENTER/TAB/F4
722:         BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
723:         BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
724: 
725:         *-- BINDEVENTs: Conta - valida ao pressionar ENTER/TAB/F4
726:         BINDEVENT(THIS.txt_4c_CdContas, "KeyPress", THIS, "TeclaCdContas")
727:         BINDEVENT(THIS.txt_4c_DsContas, "KeyPress", THIS, "TeclaDsContas")
728:     ENDPROC
729: 
730:     *==========================================================================
731:     * LIMPARCAMPOS - Reseta todos os campos de filtro para valores padrao
732:     *==========================================================================
733:     PROCEDURE LimparCampos()
734:         THIS.txt_4c_CdGrEstoque.Value    = ""
735:         THIS.txt_4c_DsGrEstoque.Value    = ""
736:         THIS.txt_4c_DsGrEstoque.Enabled  = .T.
737:         THIS.txt_4c_CdContas.Value       = ""
738:         THIS.txt_4c_DsContas.Value       = ""
739:         THIS.txt_4c_DsContas.Enabled     = .T.
740:         THIS.txt_4c__dt_inicial.Value    = {}
741:         THIS.txt_4c__dt_final.Value      = {}
742:         THIS.obj_4c_OptDatas.Value       = 1
743:         THIS.obj_4c_Op_Emitido.Value     = 1
744:         THIS.obj_4c_Op_Cancelado.Value   = 1
745:         THIS.obj_4c_Op_Ordem.Value       = 1
746:         THIS.obj_4c_Op_Baixados.Value    = 1
747:     ENDPROC
748: 
749:     *==========================================================================
750:     * ATUALIZARESTADOCONTROLES - Override: REPORT nao usa modo CRUD
751:     *==========================================================================
752:     PROCEDURE AtualizarEstadoControles()
753:         RETURN
754:     ENDPROC
755: 
756:     *==========================================================================
757:     * ALTERNARPAGINA - REPORT eh FLAT (1 pagina logica permanente)
758:     *==========================================================================
759:     PROCEDURE AlternarPagina(par_nPagina)
760:         LOCAL loc_nPagina
761:         loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
762:         IF loc_nPagina < 1
763:             loc_nPagina = 1
764:         ENDIF
765:         THIS.this_nPaginaAtual = loc_nPagina
766:     ENDPROC
767: 
768:     *==========================================================================
769:     * FORMPARARELATORIO - Transfere valores do form para o BO
770:     *==========================================================================
771:     PROTECTED PROCEDURE FormParaRelatorio()
772:         WITH THIS.this_oRelatorio
773:             .this_dDtInicial = THIS.txt_4c__dt_inicial.Value
774:             .this_dDtFinal   = THIS.txt_4c__dt_final.Value
775:             .this_nTpDat     = THIS.obj_4c_OptDatas.Value
776:             .this_cGrupo     = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
777:             .this_cDsGrupo   = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
778:             .this_cIclis     = ALLTRIM(THIS.txt_4c_CdContas.Value)
779:             .this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
780:             .this_nOpEmitido = THIS.obj_4c_Op_Emitido.Value
781:             .this_nOpCancela = THIS.obj_4c_Op_Cancelado.Value
782:             .this_nOpOrdem   = THIS.obj_4c_Op_Ordem.Value
783:             .this_nOpBaixas  = THIS.obj_4c_Op_Baixados.Value
784:         ENDWITH
785:     ENDPROC
786: 
787:     *==========================================================================
788:     * VALIDARCDGRESTOQUE - Valida codigo do grupo contra SigCdGrp
789:     * cgrus=code(3), dgrus=desc(20)
790:     *==========================================================================
791:     PROCEDURE ValidarCdGrEstoque()
792:         LOCAL loc_cCodigo, loc_cSQL, loc_nResult
793:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
794: 
795:         IF EMPTY(loc_cCodigo)
796:             THIS.txt_4c_DsGrEstoque.Value   = ""
797:             THIS.txt_4c_DsGrEstoque.Enabled = .T.
798:             RETURN
799:         ENDIF
800: 
801:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp" + ;
802:             " WHERE cgrus = " + EscaparSQL(loc_cCodigo)
803: 
804:         IF USED("cursor_4c_GrpVal")
805:             USE IN cursor_4c_GrpVal
806:         ENDIF
807: 
808:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
809: 
810:         IF loc_nResult > 0
811:             SELECT cursor_4c_GrpVal
812:             IF !EOF()
813:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
814:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
815:                 USE IN cursor_4c_GrpVal
816:                 RETURN
817:             ENDIF
818:             USE IN cursor_4c_GrpVal
819:         ENDIF
820: 
821:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado: " + loc_cCodigo, "Aviso")
822:         THIS.txt_4c_CdGrEstoque.Value   = ""
823:         THIS.txt_4c_DsGrEstoque.Value   = ""
824:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
825:         THIS.txt_4c_CdGrEstoque.SetFocus()
826:     ENDPROC
827: 
828:     *==========================================================================
829:     * VALIDARDSGRESTOQUE - Valida descricao do grupo contra SigCdGrp
830:     * Ativo somente quando txt_4c_CdGrEstoque estiver vazio (When original)
831:     *==========================================================================
832:     PROCEDURE ValidarDsGrEstoque()
833:         LOCAL loc_cDesc, loc_cSQL, loc_nResult
834:         loc_cDesc = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
835: 
836:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value))
837:             RETURN
838:         ENDIF
839: 
840:         IF EMPTY(loc_cDesc)
841:             THIS.txt_4c_CdGrEstoque.Value = ""
842:             RETURN
843:         ENDIF
844: 
845:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp" + ;
846:             " WHERE dgrus = " + EscaparSQL(loc_cDesc)
847: 
848:         IF USED("cursor_4c_GrpDsVal")
849:             USE IN cursor_4c_GrpDsVal
850:         ENDIF
851: 
852:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDsVal")
853: 
854:         IF loc_nResult > 0
855:             SELECT cursor_4c_GrpDsVal
856:             IF !EOF()
857:                 THIS.txt_4c_CdGrEstoque.Value   = ALLTRIM(cgrus)
858:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
859:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
860:                 USE IN cursor_4c_GrpDsVal
861:                 RETURN
862:             ENDIF
863:             USE IN cursor_4c_GrpDsVal
864:         ENDIF
865: 
866:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
867:         THIS.txt_4c_CdGrEstoque.Value   = ""
868:         THIS.txt_4c_DsGrEstoque.Value   = ""
869:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
870:         THIS.txt_4c_DsGrEstoque.SetFocus()
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * TECLACDGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida codigo do grupo
875:     *==========================================================================
876:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShift)
877:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
878:             THIS.AbrirLookupGrEstoque()
879:         ELSE
880:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
881:             THIS.ValidarCdGrEstoque()
882:             ENDIF
883:         ENDIF
884:     ENDPROC
885: 
886:     *==========================================================================
887:     * TECLADSGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida descricao do grupo
888:     *                              F4(115) abre lookup direto
889:     *==========================================================================
890:     PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShift)
891:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
892:             THIS.AbrirLookupGrEstoque()
893:         ELSE
894:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
895:             THIS.ValidarDsGrEstoque()
896:             ENDIF
897:         ENDIF
898:     ENDPROC
899: 
900:     *==========================================================================
901:     * ABRIRLOOKUPGRESTOQUE - Abre FormBuscaAuxiliar para grupo de estoque
902:     * Tabela: SigCdGrp | cgrus (cod) | dgrus (desc)
903:     *==========================================================================
904:     PROCEDURE AbrirLookupGrEstoque()
905:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
906: 
907:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
908:             "SigCdGrp", ;
909:             "cursor_4c_BuscaGrp", ;
910:             "cgrus", ;
911:             ALLTRIM(THIS.txt_4c_CdGrEstoque.Value), ;
912:             "Buscar Grupo de Estoque")
913: 
914:         loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
915:         loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
916:         loc_oBusca.Show()
917: 
918:         IF loc_oBusca.this_lSelecionou
919:             IF USED("cursor_4c_BuscaGrp")
920:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
921:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
922:                 THIS.txt_4c_CdGrEstoque.Value   = loc_cCodigo
923:                 THIS.txt_4c_DsGrEstoque.Value   = loc_cDescricao
924:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
925:             ENDIF
926:         ENDIF
927: 
928:         IF USED("cursor_4c_BuscaGrp")
929:             USE IN cursor_4c_BuscaGrp
930:         ENDIF
931:         loc_oBusca.Release()
932:     ENDPROC
933: 
934:     *==========================================================================
935:     * TECLACDCONTAS - KeyPress: ENTER(13)/TAB(9) valida codigo da conta
936:     *                           F4(115) abre lookup direto
937:     *==========================================================================
938:     PROCEDURE TeclaCdContas(par_nKeyCode, par_nShift)
939:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
940:             THIS.AbrirLookupContas()
941:         ELSE
942:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
943:             THIS.ValidarCdContas()
944:             ENDIF
945:         ENDIF
946:     ENDPROC
947: 
948:     *==========================================================================
949:     * TECLADSCONTAS - KeyPress: ENTER(13)/TAB(9) valida descricao da conta
950:     *                           F4(115) abre lookup direto
951:     * Somente ativo quando CdContas estiver vazio (comportamento When original)
952:     *==========================================================================
953:     PROCEDURE TeclaDsContas(par_nKeyCode, par_nShift)
954:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
955:             THIS.AbrirLookupContas()
956:         ELSE
957:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
958:             THIS.ValidarDsContas()
959:             ENDIF
960:         ENDIF
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * VALIDARCDCONTAS - Valida codigo da conta contra cursor_4c_Contas
965:     * Iclis=codigo, Rclis=nome/razao social
966:     * Se nao encontrado, abre lookup FormBuscaAuxiliar
967:     *==========================================================================
968:     PROCEDURE ValidarCdContas()
969:         LOCAL loc_cCodigo, loc_nArea
970:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdContas.Value)
971: 
972:         IF EMPTY(loc_cCodigo)
973:             THIS.txt_4c_DsContas.Value   = ""
974:             THIS.txt_4c_DsContas.Enabled = .T.
975:             RETURN
976:         ENDIF
977: 
978:         IF USED("cursor_4c_Contas")
979:             loc_nArea = SELECT()
980:             SELECT cursor_4c_Contas
981:             LOCATE FOR ALLTRIM(Iclis) = loc_cCodigo
982:             IF FOUND()
983:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
984:                 THIS.txt_4c_DsContas.Enabled = .F.
985:                 SELECT (loc_nArea)
986:                 RETURN
987:             ENDIF
988:             SELECT (loc_nArea)
989:         ENDIF
990: 
991:         THIS.AbrirLookupContas()
992:     ENDPROC
993: 
994:     *==========================================================================
995:     * VALIDARDSCONTAS - Valida descricao da conta (busca reversa por nome)
996:     * Somente ativo quando CdContas estiver vazio (comportamento When original)
997:     * Se nao encontrado, abre lookup FormBuscaAuxiliar
998:     *==========================================================================
999:     PROCEDURE ValidarDsContas()
1000:         LOCAL loc_cDesc, loc_nArea
1001: 
1002:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1003:             RETURN
1004:         ENDIF
1005: 
1006:         loc_cDesc = ALLTRIM(THIS.txt_4c_DsContas.Value)
1007: 
1008:         IF EMPTY(loc_cDesc)
1009:             THIS.txt_4c_CdContas.Value = ""
1010:             RETURN
1011:         ENDIF
1012: 
1013:         IF USED("cursor_4c_Contas")
1014:             loc_nArea = SELECT()
1015:             SELECT cursor_4c_Contas
1016:             LOCATE FOR UPPER(ALLTRIM(Rclis)) = UPPER(loc_cDesc)
1017:             IF FOUND()
1018:                 THIS.txt_4c_CdContas.Value   = ALLTRIM(Iclis)
1019:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
1020:                 THIS.txt_4c_DsContas.Enabled = .F.
1021:                 SELECT (loc_nArea)
1022:                 RETURN
1023:             ENDIF
1024:             SELECT (loc_nArea)
1025:         ENDIF
1026: 
1027:         THIS.AbrirLookupContas()
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * ABRIRLOOKUPCONTAS - Abre FormBuscaAuxiliar para conta corrente
1032:     * Tabela: SigCdCli | Iclis (cod) | Rclis (nome/razao social)
1033:     *==========================================================================
1034:     PROCEDURE AbrirLookupContas()
1035:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1036: 
1037:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1038:             "SigCdCli", ;
1039:             "cursor_4c_BuscaContas", ;
1040:             "Iclis", ;
1041:             ALLTRIM(THIS.txt_4c_CdContas.Value), ;
1042:             "Buscar Conta Corrente")
1043: 
1044:         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1045:         loc_oBusca.mAddColuna("Rclis", "", "Nome / Raz" + CHR(227) + "o Social")
1046:         loc_oBusca.Show()
1047: 
1048:         IF loc_oBusca.this_lSelecionou
1049:             IF USED("cursor_4c_BuscaContas")
1050:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaContas.Iclis)
1051:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaContas.Rclis)
1052:                 THIS.txt_4c_CdContas.Value   = loc_cCodigo
1053:                 THIS.txt_4c_DsContas.Value   = loc_cDescricao
1054:                 THIS.txt_4c_DsContas.Enabled = .F.
1055:             ENDIF
1056:         ENDIF
1057: 
1058:         IF USED("cursor_4c_BuscaContas")
1059:             USE IN cursor_4c_BuscaContas
1060:         ENDIF
1061:         loc_oBusca.Release()
1062:     ENDPROC
1063: 
1064:     *==========================================================================
1065:     * BTNVISUALIZARCLICK - Buttons(1): Preview do relatorio na tela
1066:     *==========================================================================
1067:     PROCEDURE BtnVisualizarClick()
1068:         THIS.FormParaRelatorio()
1069:         IF !THIS.this_oRelatorio.Visualizar()
1070:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
1071:         ENDIF
1072:     ENDPROC
1073: 
1074:     *==========================================================================
1075:     * BTNIMPRIMIRCLICK - Buttons(2): Imprime relatorio na impressora
1076:     *==========================================================================
1077:     PROCEDURE BtnImprimirClick()
1078:         THIS.FormParaRelatorio()
1079:         IF !THIS.this_oRelatorio.Imprimir()
1080:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1081:         ENDIF
1082:     ENDPROC
1083: 
1084:     *==========================================================================
1085:     * BTNEXCELCLICK - Buttons(3): Exporta dados do relatorio para arquivo Excel
1086:     *==========================================================================
1087:     PROCEDURE BtnExcelClick()
1088:         LOCAL loc_cArquivo
1089:         loc_cArquivo = PUTFILE("Salvar como Excel", ;
1090:             "SigReHtc_" + STRTRAN(DTOC(DATE()), "/", ""), ;
1091:             "XLS")
1092: 
1093:         IF EMPTY(loc_cArquivo)
1094:             RETURN
1095:         ENDIF
1096: 
1097:         THIS.FormParaRelatorio()
1098: 
1099:         IF THIS.this_oRelatorio.ExportarExcel(loc_cArquivo)
1100:             MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, ;
1101:                 "Exporta" + CHR(231) + CHR(227) + "o Excel")
1102:         ELSE
1103:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Exportar Excel")
1104:         ENDIF
1105:     ENDPROC
1106: 
1107:     *==========================================================================
1108:     * BTNSAIRCLICK - Buttons(4): Fecha o formulario
1109:     *==========================================================================
1110:     PROCEDURE BtnSairClick()
1111:         THIS.Release()
1112:     ENDPROC
1113: 
1114:     *==========================================================================
1115:     * BTNINCLUIRCLICK - Alias CRUD: nova consulta (limpa filtros e foca o
1116:     * primeiro campo). Em REPORT nao ha registro a incluir; "Incluir" mapeia
1117:     * para iniciar uma nova consulta com filtros vazios.
1118:     *==========================================================================
1119:     PROCEDURE BtnIncluirClick()
1120:         THIS.LimparCampos()
1121:         THIS.txt_4c_CdGrEstoque.SetFocus()
1122:     ENDPROC
1123: 
1124:     *==========================================================================
1125:     * BTNALTERARCLICK - Alias CRUD: modificar saida (imprime na impressora).
1126:     * Em REPORT "Alterar" mapeia para alterar o destino da saida do relatorio
1127:     * preparado (visualizacao na tela -> impressao em papel).
1128:     *==========================================================================
1129:     PROCEDURE BtnAlterarClick()
1130:         THIS.FormParaRelatorio()
1131:         IF !THIS.this_oRelatorio.Imprimir()
1132:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1133:         ENDIF
1134:     ENDPROC
1135: 
1136:     *==========================================================================
1137:     * BTNEXCLUIRCLICK - Alias CRUD: descartar resultado e fechar formulario.
1138:     * Em REPORT "Excluir" mapeia para abandonar a consulta atual (sair do form),
1139:     * sem efetuar qualquer operacao em banco de dados.
1140:     *==========================================================================
1141:     PROCEDURE BtnExcluirClick()
1142:         THIS.LimparCampos()
1143:         THIS.Release()
1144:     ENDPROC
1145: 
1146:     *==========================================================================
1147:     * BTNBUSCARCLICK - Preview do relatorio na tela (alias CRUD para Visualizar)
1148:     *==========================================================================
1149:     PROCEDURE BtnBuscarClick()
1150:         THIS.FormParaRelatorio()
1151:         IF !THIS.this_oRelatorio.Visualizar()
1152:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
1153:         ENDIF
1154:     ENDPROC
1155: 
1156:     *==========================================================================
1157:     * BTNENCERRARCLICK - Fecha o formulario (alias de BtnSairClick)
1158:     *==========================================================================
1159:     PROCEDURE BtnEncerrarClick()
1160:         THIS.Release()
1161:     ENDPROC
1162: 
1163:     *==========================================================================
1164:     * BTNSALVARCLICK - Alias CRUD: envia relatorio para a impressora
1165:     *==========================================================================
1166:     PROCEDURE BtnSalvarClick()
1167:         THIS.FormParaRelatorio()
1168:         IF !THIS.this_oRelatorio.Imprimir()
1169:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1170:         ENDIF
1171:     ENDPROC
1172: 
1173:     *==========================================================================
1174:     * BTNCANCELARCLICK - Alias CRUD: limpa filtros e foca primeiro campo
1175:     *==========================================================================
1176:     PROCEDURE BtnCancelarClick()
1177:         THIS.LimparCampos()
1178:         THIS.txt_4c_CdGrEstoque.SetFocus()
1179:     ENDPROC
1180: 
1181:     *==========================================================================
1182:     * FORMPARABO - Transfere valores do form para o BO (alias de FormParaRelatorio)
1183:     *==========================================================================
1184:     PROCEDURE FormParaBO()
1185:         THIS.FormParaRelatorio()
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * BOPARAFORM - Restaura campos do form a partir do estado do BO
1190:     *==========================================================================
1191:     PROCEDURE BOParaForm()
1192:         WITH THIS.this_oRelatorio
1193:             THIS.txt_4c__dt_inicial.Value     = .this_dDtInicial
1194:             THIS.txt_4c__dt_final.Value       = .this_dDtFinal
1195:             THIS.obj_4c_OptDatas.Value        = .this_nTpDat
1196:             THIS.txt_4c_CdGrEstoque.Value     = .this_cGrupo
1197:             THIS.txt_4c_DsGrEstoque.Value     = .this_cDsGrupo
1198:             THIS.txt_4c_CdContas.Value        = .this_cIclis
1199:             THIS.txt_4c_DsContas.Value        = .this_cDsContas
1200:             THIS.obj_4c_Op_Emitido.Value      = .this_nOpEmitido
1201:             THIS.obj_4c_Op_Cancelado.Value    = .this_nOpCancela
1202:             THIS.obj_4c_Op_Ordem.Value        = .this_nOpOrdem
1203:             THIS.obj_4c_Op_Baixados.Value     = .this_nOpBaixas
1204:         ENDWITH
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * HABILITARCAMPOS - Habilita/desabilita todos os campos de filtro
1209:     * Em REPORT todos os campos de filtro sao sempre editaveis (par omitido = .T.)
1210:     *==========================================================================
1211:     PROCEDURE HabilitarCampos(par_lHabilitar)
1212:         LOCAL loc_lHab
1213:         loc_lHab = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", .T., par_lHabilitar)
1214: 
1215:         THIS.txt_4c_CdGrEstoque.Enabled  = loc_lHab
1216:         THIS.txt_4c_DsGrEstoque.Enabled  = loc_lHab
1217:         THIS.txt_4c_CdContas.Enabled     = loc_lHab
1218:         THIS.txt_4c_DsContas.Enabled     = loc_lHab
1219:         THIS.txt_4c__dt_inicial.Enabled  = loc_lHab
1220:         THIS.txt_4c__dt_final.Enabled    = loc_lHab
1221:         THIS.obj_4c_OptDatas.Enabled     = loc_lHab
1222:         THIS.obj_4c_Op_Emitido.Enabled   = loc_lHab
1223:         THIS.obj_4c_Op_Cancelado.Enabled = loc_lHab
1224:         THIS.obj_4c_Op_Ordem.Enabled     = loc_lHab
1225:         THIS.obj_4c_Op_Baixados.Enabled  = loc_lHab
1226:     ENDPROC
1227: 
1228:     *==========================================================================
1229:     * CARREGARLISTA - REPORT nao tem lista CRUD; retorna .T. sempre
1230:     *==========================================================================
1231:     PROCEDURE CarregarLista()
1232:         RETURN .T.
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * AJUSTARBOTOESPORMODO - REPORT nao tem modos CRUD; botoes sempre ativos
1237:     *==========================================================================
1238:     PROCEDURE AjustarBotoesPorModo()
1239:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1240:             THIS.cmg_4c_Botoes.Enabled = .T.
1241:         ENDIF
1242:     ENDPROC
1243: 
1244:     *==========================================================================
1245:     * DESTROY - Libera recursos
1246:     *==========================================================================
1247:     PROCEDURE Destroy()
1248:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1249:             THIS.this_oRelatorio = .NULL.
1250:         ENDIF
1251:         DODEFAULT()
1252:     ENDPROC
1253: 
1254: ENDDEFINE


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

