# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Cheque' (parent: SIGREECH): Top original=83 vs migrado 'cnt_4c_Cheque' Top=3 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cheque' (parent: SIGREECH): Left original=134 vs migrado 'cnt_4c_Cheque' Left=12 (diff=122px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReEch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1562 linhas total):

*-- Linhas 43 a 168:
43:     * par_cOpEscolha: INSERIR ou ALTERAR
44:     * par_cNcheque: numero do cheque para filtro (opcional, "" = sem filtro)
45:     *==========================================================================
46:     PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cOpEscolha, par_cNcheque)
47:         LOCAL loc_lSucesso, loc_oErro
48:         loc_lSucesso = .F.
49: 
50:         TRY
51:             *-- Salva parametros antes de DODEFAULT (InicializarForm precisara deles)
52:             THIS.emps         = NVL(par_cEmps, "")
53:             THIS.dopes        = PADR(NVL(par_cDopes, ""), 20)
54:             THIS.numes        = NVL(par_nNumes, 0)
55:             THIS.op_escolha   = NVL(par_cOpEscolha, "")
56:             THIS.ncheque_param = IIF(VARTYPE(par_cNcheque) = "C", par_cNcheque, "")
57: 
58:             *-- Cria Business Object antes de DODEFAULT
59:             THIS.this_oBusinessObject = CREATEOBJECT("SigReEchBO")
60: 
61:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
62:                 MsgErro("Erro ao criar SigReEchBO." + CHR(13) + ;
63:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
64:             ELSE
65:                 *-- FormBase.Init() chama InicializarForm() internamente
66:                 loc_lSucesso = DODEFAULT()
67:             ENDIF
68: 
69:         CATCH TO loc_oErro
70:             MsgErro("Erro ao inicializar FormSigReEch:" + CHR(13) + ;
71:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
72:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
73:                     "Procedure: " + loc_oErro.Procedure, "Erro")
74:             loc_lSucesso = .F.
75:         ENDTRY
76: 
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * InicializarForm - Cria containers base e carrega dados do cheque
82:     *==========================================================================
83:     PROTECTED PROCEDURE InicializarForm()
84:         LOCAL loc_lSucesso, loc_oErro
85:         loc_lSucesso = .F.
86: 
87:         TRY
88:             THIS.LockScreen = .T.
89: 
90:             *-- Titulo e imagem de fundo (exatos do original)
91:             THIS.this_cTituloForm = "Emiss" + CHR(227) + "o de Cheque"
92:             THIS.Caption          = "Emiss" + CHR(227) + "o de Cheque"
93:             THIS.Picture          = gc_4c_CaminhoIcones + "new_background.jpg"
94: 
95:             *-- Cria container do cabecalho cinza (cntSombra do original)
96:             THIS.ConfigurarPageFrame()
97: 
98:             *-- Cria container de dados do cheque (cnt_4c_Cheque)
99:             THIS.ConfigurarPaginaDados()
100: 
101:             *-- Cria botoes operacionais, OptionGroup e label de estado
102:             THIS.ConfigurarPaginaLista()
103: 
104:             *-- Carrega dados via BO (sem depender de controles visuais)
105:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
106:                 THIS.CarregarDadosCheque()
107:                 THIS.InicializarEstadoBotoes()
108:                 THIS.BOParaForm()
109:             ENDIF
110: 
111:             THIS.LockScreen = .F.
112:             loc_lSucesso = .T.
113: 
114:         CATCH TO loc_oErro
115:             THIS.LockScreen = .F.
116:             MsgErro("Erro ao inicializar o formul" + CHR(225) + "rio:" + CHR(13) + ;
117:                     loc_oErro.Message, "Erro")
118:             loc_lSucesso = .F.
119:         ENDTRY
120: 
121:         RETURN loc_lSucesso
122:     ENDPROC
123: 
124:     *==========================================================================
125:     * ConfigurarPageFrame - Cria container cabecalho cinza (cntSombra)
126:     * Fase 3: cabecalho completo com titulos sombra e branco
127:     *==========================================================================
128:     PROTECTED PROCEDURE ConfigurarPageFrame()
129:         LOCAL loc_oErro
130:         TRY
131:             THIS.AddObject("cnt_4c_Sombra", "Container")
132:             WITH THIS.cnt_4c_Sombra
133:                 .Top         = 0
134:                 .Left        = 0
135:                 .Width       = THIS.Width
136:                 .Height      = 80
137:                 .BorderWidth = 0
138:                 .BackStyle   = 1
139:                 .BackColor   = RGB(100, 100, 100)
140:                 .Visible     = .T.
141: 
142:                 *-- Label sombra (preto, deslocado 1px para efeito 3D)
143:                 .AddObject("lbl_4c_LblSombra", "Label")
144:                 WITH .lbl_4c_LblSombra
145:                     .FontBold      = .T.
146:                     .FontName      = "Tahoma"
147:                     .FontSize      = 18
148:                     .FontUnderline = .F.
149:                     .WordWrap      = .T.
150:                     .Alignment     = 0
151:                     .BackStyle     = 0
152:                     .Caption       = "Emiss" + CHR(227) + "o de Cheque"
153:                     .Height        = 40
154:                     .Left          = 10
155:                     .Top           = 25
156:                     .Width         = THIS.Width
157:                     .ForeColor     = RGB(0, 0, 0)
158:                     .Visible       = .T.
159:                 ENDWITH
160: 
161:                 *-- Label titulo (branco sobre cinza)
162:                 .AddObject("lbl_4c_LblTitulo", "Label")
163:                 WITH .lbl_4c_LblTitulo
164:                     .FontBold  = .T.
165:                     .FontName  = "Tahoma"
166:                     .FontSize  = 18
167:                     .WordWrap  = .T.
168:                     .Alignment = 0

*-- Linhas 182 a 233:
182:         ENDTRY
183:     ENDPROC
184: 
185:     *==========================================================================
186:     * ConfigurarPaginaDados - Cria container e campos de informacoes do cheque
187:     * cnt_4c_Cheque: Bco, Agencia, Conta, Numero, Valor, Vencimento (somente leitura)
188:     * txt_4c_Favorecido: editavel em INSERIR/ALTERAR
189:     * txt_4c_Copia: numero de copias (somente leitura)
190:     * obj_4c_Get_Verso: texto do verso (editavel em INSERIR/ALTERAR quando ImpVersos=0)
191:     * obj_4c_OModem: controle OLE MSComm para porta serial da impressora
192:     *==========================================================================
193:     PROTECTED PROCEDURE ConfigurarPaginaDados()
194:         LOCAL loc_oErro, loc_oErrOle
195:         TRY
196:             *-- Container cheque (Cheque do original: Top=83, Left=134, W=487, H=51)
197:             THIS.AddObject("cnt_4c_Cheque", "Container")
198:             WITH THIS.cnt_4c_Cheque
199:                 .Top           = 83
200:                 .Left          = 134
201:                 .Width         = 487
202:                 .Height        = 51
203:                 .BackStyle     = 0
204:                 .BorderWidth   = 1
205:                 .SpecialEffect = 2
206:                 .BackColor     = RGB(255, 255, 255)
207:                 .Visible       = .T.
208: 
209:                 *-- Labels de cabecalho dos campos do cheque
210:                 .AddObject("lbl_4c_Say2", "Label")
211:                 WITH .lbl_4c_Say2
212:                     .FontName  = "Tahoma"
213:                     .FontSize  = 8
214:                     .BackStyle = 0
215:                     .Caption   = "Bco"
216:                     .Left      = 12
217:                     .Top       = 3
218:                     .ForeColor = RGB(90, 90, 90)
219:                     .Visible   = .T.
220:                 ENDWITH
221: 
222:                 .AddObject("lbl_4c_Say3", "Label")
223:                 WITH .lbl_4c_Say3
224:                     .FontName  = "Tahoma"
225:                     .FontSize  = 8
226:                     .BackStyle = 0
227:                     .Caption   = "Ag" + CHR(234) + "ncia"
228:                     .Left      = 57
229:                     .Top       = 3
230:                     .ForeColor = RGB(90, 90, 90)
231:                     .Visible   = .T.
232:                 ENDWITH
233: 

*-- Linhas 452 a 561:
452:                         loc_oErrOle.Message, "Aviso")
453:             ENDTRY
454: 
455:             BINDEVENT(THIS.txt_4c_Favorecido, "KeyPress", THIS, "FavorecidoLostFocus")
456:             BINDEVENT(THIS.obj_4c_Get_Verso,  "KeyPress", THIS, "VersoLostFocus")
457: 
458:         CATCH TO loc_oErro
459:             MsgErro(loc_oErro.Message, "Erro")
460:         ENDTRY
461:     ENDPROC
462: 
463:     *==========================================================================
464:     * CarregarDadosCheque - Carrega dados do cheque, parcela e empresa via BO
465:     * Chamado durante InicializarForm (antes dos controles visuais existirem)
466:     *==========================================================================
467:     PROTECTED PROCEDURE CarregarDadosCheque()
468:         LOCAL loc_oBO, loc_cEDN, loc_oErro
469:         TRY
470:             loc_oBO  = THIS.this_oBusinessObject
471:             loc_cEDN = THIS.emps + THIS.dopes + STR(THIS.numes, 6)
472: 
473:             *-- Carrega registro de SigCqChi
474:             loc_oBO.CarregarDados(THIS.emps, THIS.dopes, THIS.numes, THIS.ncheque_param)
475: 
476:             *-- Carrega parcela vinculada em SigMvPar
477:             loc_oBO.CarregarParcela(loc_cEDN)
478: 
479:             *-- Carrega dados da empresa em SigCdEmp
480:             loc_oBO.CarregarEmpresa(THIS.emps)
481: 
482:         CATCH TO loc_oErro
483:             MsgErro(loc_oErro.Message, "Erro")
484:         ENDTRY
485:     ENDPROC
486: 
487:     *==========================================================================
488:     * TornarControlesVisiveis - Torna visiveis todos os controles do container
489:     * Itera recursivamente em sub-containers e Pages de PageFrames
490:     *==========================================================================
491:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
492:         LOCAL loc_i, loc_p, loc_oControl
493:         IF VARTYPE(par_oContainer) != "O"
494:             RETURN
495:         ENDIF
496:         FOR loc_i = 1 TO par_oContainer.ControlCount
497:             loc_oControl = par_oContainer.Controls(loc_i)
498:             IF VARTYPE(loc_oControl) = "O"
499:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
500:                     IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_SOMBRA")
501:                         loc_oControl.Visible = .T.
502:                     ENDIF
503:                 ENDIF
504:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
505:                     FOR loc_p = 1 TO loc_oControl.PageCount
506:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
507:                     ENDFOR
508:                 ENDIF
509:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
510:                     THIS.TornarControlesVisiveis(loc_oControl)
511:                 ENDIF
512:             ENDIF
513:         ENDFOR
514:     ENDPROC
515: 
516:     *==========================================================================
517:     * ConfigurarPaginaLista - Cria botoes operacionais, OptionGroup e lbl_4c_LbNimp
518:     * Fase 4: cmd_4c_Visualizar, cmd_4c_Imprimir, cmd_4c_Encerrar,
519:     *          opt_4c_Imprime, lbl_4c_LbNimp
520:     *==========================================================================
521:     PROTECTED PROCEDURE ConfigurarPaginaLista()
522:         LOCAL loc_oErro
523:         TRY
524:             THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
525:             WITH THIS.cmd_4c_Visualizar
526:                 .Top             = 2
527:                 .Left            = 573
528:                 .Height          = 75
529:                 .Width           = 75
530:                 .Caption         = "V" + CHR(237) + "deo"
531:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
532:                 .PicturePosition = 13
533:                 .FontName        = "Tahoma"
534:                 .FontSize        = 8
535:                 .FontBold        = .T.
536:                 .FontItalic      = .T.
537:                 .ForeColor       = RGB(90, 90, 90)
538:                 .BackColor       = RGB(255, 255, 255)
539:                 .Themes          = .F.
540:                 .SpecialEffect   = 0
541:                 .MousePointer    = 15
542:                 .WordWrap        = .T.
543:                 .Visible         = .T.
544:             ENDWITH
545: 
546:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
547:             WITH THIS.cmd_4c_Imprimir
548:                 .Top             = 2
549:                 .Left            = 648
550:                 .Height          = 75
551:                 .Width           = 75
552:                 .Caption         = "Impressora"
553:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
554:                 .PicturePosition = 13
555:                 .FontName        = "Tahoma"
556:                 .FontSize        = 8
557:                 .FontBold        = .T.
558:                 .FontItalic      = .T.
559:                 .ForeColor       = RGB(90, 90, 90)
560:                 .BackColor       = RGB(255, 255, 255)
561:                 .Themes          = .F.

*-- Linhas 587 a 630:
587:                 .Visible         = .T.
588:             ENDWITH
589: 
590:             THIS.AddObject("opt_4c_Imprime", "OptionGroup")
591:             WITH THIS.opt_4c_Imprime
592:                 .ButtonCount   = 3
593:                 .BackStyle     = 0
594:                 .Value         = 1
595:                 .Height        = 73
596:                 .Left          = 543
597:                 .SpecialEffect = 1
598:                 .Top           = 192
599:                 .Width         = 79
600:                 .BorderColor   = RGB(36, 84, 155)
601:                 .Visible       = .T.
602:                 WITH .Buttons(1)
603:                     .BackStyle = 0
604:                     .Caption   = "Cheque"
605:                     .Value     = 1
606:                     .Height    = 15
607:                     .Left      = 7
608:                     .Top       = 7
609:                     .Width     = 55
610:                     .AutoSize  = .T.
611:                     .ForeColor = RGB(90, 90, 90)
612:                     .Themes    = .F.
613:                 ENDWITH
614:                 WITH .Buttons(2)
615:                     .FontName  = "Tahoma"
616:                     .FontSize  = 8
617:                     .BackStyle = 0
618:                     .Caption   = "Verso"
619:                     .Height    = 15
620:                     .Left      = 7
621:                     .Top       = 28
622:                     .Width     = 45
623:                     .AutoSize  = .T.
624:                     .ForeColor = RGB(90, 90, 90)
625:                     .Themes    = .F.
626:                 ENDWITH
627:                 WITH .Buttons(3)
628:                     .FontName  = "Tahoma"
629:                     .FontSize  = 8
630:                     .BackStyle = 0

*-- Linhas 654 a 904:
654:                 .Visible   = .F.
655:             ENDWITH
656: 
657:             BINDEVENT(THIS.cmd_4c_Visualizar, "Click",             THIS, "BtnVisualizarClick")
658:             BINDEVENT(THIS.cmd_4c_Imprimir,   "Click",             THIS, "BtnImprimirClick")
659:             BINDEVENT(THIS.cmd_4c_Encerrar,   "Click",             THIS, "BtnEncerrarClick")
660:             BINDEVENT(THIS.opt_4c_Imprime,    "InteractiveChange", THIS, "OptImprimicChange")
661: 
662:         CATCH TO loc_oErro
663:             MsgErro(loc_oErro.Message, "Erro")
664:         ENDTRY
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * AlternarPagina - Sincroniza estado do botao Video com a opcao selecionada
669:     *==========================================================================
670:     PROCEDURE AlternarPagina()
671:         IF VARTYPE(THIS.cmd_4c_Visualizar) = "O" AND VARTYPE(THIS.opt_4c_Imprime) = "O"
672:             THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
673:         ENDIF
674:     ENDPROC
675: 
676:     *==========================================================================
677:     * InicializarEstadoBotoes - Define estado inicial dos botoes apos carregar dados
678:     *==========================================================================
679:     PROTECTED PROCEDURE InicializarEstadoBotoes()
680:         LOCAL loc_oBO, loc_oErro
681:         TRY
682:             loc_oBO = THIS.this_oBusinessObject
683:             IF VARTYPE(loc_oBO) = "O"
684:                 THIS.opt_4c_Imprime.Buttons(2).Enabled = loc_oBO.this_lEmitidos
685:                 THIS.opt_4c_Imprime.Buttons(3).Enabled = loc_oBO.this_lEmitidos
686:                 THIS.opt_4c_Imprime.Value = IIF(loc_oBO.this_lEmitidos, 3, 1)
687:                 IF loc_oBO.this_lEmitidos
688:                     THIS.opt_4c_Imprime.Buttons(3).SetFocus
689:                 ENDIF
690:                 THIS.cmd_4c_Visualizar.Enabled  = loc_oBO.this_lEmitidos
691:                 THIS.lbl_4c_LbNimp.Visible      = (loc_oBO.this_nImpVersos = 0)
692:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
693:                     THIS.obj_4c_Get_Verso.ReadOnly = !(INLIST(THIS.op_escolha, "INSERIR", "ALTERAR") AND loc_oBO.this_nImpVersos = 0)
694:                     IF THIS.obj_4c_Get_Verso.ReadOnly
695:                         THIS.obj_4c_Get_Verso.BackColor = RGB(240, 240, 240)
696:                     ENDIF
697:                 ENDIF
698:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
699:                     THIS.txt_4c_Favorecido.ReadOnly = !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
700:                     IF THIS.txt_4c_Favorecido.ReadOnly
701:                         THIS.txt_4c_Favorecido.BackColor = RGB(240, 240, 240)
702:                     ENDIF
703:                 ENDIF
704:             ENDIF
705:         CATCH TO loc_oErro
706:             MsgErro(loc_oErro.Message, "Erro")
707:         ENDTRY
708:     ENDPROC
709: 
710:     *==========================================================================
711:     * OptImprimicChange - Atualiza Visualizar.Enabled conforme opcao selecionada
712:     *==========================================================================
713:     PROCEDURE OptImprimicChange()
714:         THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
715:     ENDPROC
716: 
717:     *==========================================================================
718:     * BtnVisualizarClick - Exibe copia do cheque em preview (Video)
719:     *==========================================================================
720:     PROCEDURE BtnVisualizarClick()
721:         THIS.enviaimp = .F.
722:         THIS.EmiteCopia()
723:     ENDPROC
724: 
725:     *==========================================================================
726:     * BtnIncluirClick - Coloca form em modo INSERIR e dispara emissao do cheque
727:     * Equivalente ao fluxo Op_Escolha="INSERIR" do legado: marca operacao como
728:     * inclusao de novo cheque e executa impressao da frente conforme opcao.
729:     *==========================================================================
730:     PROCEDURE BtnIncluirClick()
731:         LOCAL loc_oBO, loc_oErro
732:         TRY
733:             loc_oBO = THIS.this_oBusinessObject
734:             THIS.op_escolha = "INSERIR"
735: 
736:             IF VARTYPE(loc_oBO) != "O"
737:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
738:             ELSE
739:                 IF loc_oBO.this_lEmitidos
740:                     MsgAviso("Este cheque j" + CHR(225) + " foi emitido." + CHR(13) + ;
741:                              "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel emitir novamente.", ;
742:                              "Aviso")
743:                 ELSE
744:                     DO CASE
745:                     CASE THIS.opt_4c_Imprime.Value = 1
746:                         THIS.EmiteCheque()
747:                     CASE THIS.opt_4c_Imprime.Value = 2
748:                         THIS.EmiteVerso()
749:                     OTHERWISE
750:                         THIS.enviaimp = .T.
751:                         THIS.EmiteCopia()
752:                     ENDCASE
753:                 ENDIF
754:             ENDIF
755:         CATCH TO loc_oErro
756:             MsgErro("Erro ao incluir emiss" + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
757:         ENDTRY
758:     ENDPROC
759: 
760:     *==========================================================================
761:     * BtnAlterarClick - Coloca form em modo ALTERAR e habilita edicao do verso
762:     * Equivalente ao fluxo Op_Escolha="ALTERAR" do legado: permite alterar
763:     * favorecido e verso. Mantem registro existente, nao cria novo.
764:     *==========================================================================
765:     PROCEDURE BtnAlterarClick()
766:         LOCAL loc_oBO, loc_oErro
767:         TRY
768:             loc_oBO = THIS.this_oBusinessObject
769:             THIS.op_escolha = "ALTERAR"
770: 
771:             IF VARTYPE(loc_oBO) != "O"
772:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
773:             ELSE
774:                 *-- Reabilita campos editaveis no modo ALTERAR
775:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
776:                     THIS.txt_4c_Favorecido.Enabled = .T.
777:                 ENDIF
778:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O" AND loc_oBO.this_nImpVersos = 0
779:                     THIS.obj_4c_Get_Verso.Enabled = .T.
780:                     THIS.obj_4c_Get_Verso.SetFocus()
781:                 ENDIF
782:             ENDIF
783:         CATCH TO loc_oErro
784:             MsgErro("Erro ao alterar cheque:" + CHR(13) + loc_oErro.Message, "Erro")
785:         ENDTRY
786:     ENDPROC
787: 
788:     *==========================================================================
789:     * BtnExcluirClick - Cancela emissao do cheque (marca como nao emitido)
790:     * Equivalente ao bloco "If !crSigCqChi.Emitidos" do Sair.Click legado:
791:     * persiste status nao-emitido e libera o cheque para emissao futura.
792:     *==========================================================================
793:     PROCEDURE BtnExcluirClick()
794:         LOCAL loc_oBO, loc_lConfirma, loc_oErro
795:         TRY
796:             loc_oBO = THIS.this_oBusinessObject
797:             IF VARTYPE(loc_oBO) != "O"
798:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
799:             ELSE
800:                 IF loc_oBO.this_lEmitidos
801:                     MsgAviso("Este cheque j" + CHR(225) + " foi emitido e n" + CHR(227) + "o pode ser cancelado.", ;
802:                              "Aviso")
803:                 ELSE
804:                     loc_lConfirma = MsgConfirma("Confirma o cancelamento da emiss" + CHR(227) + "o deste cheque?")
805:                     IF loc_lConfirma
806:                         loc_oBO.this_lEmitidos = .F.
807:                         loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
808:                                                   loc_oBO.this_cFavos, ;
809:                                                   loc_oBO.this_nNEmissoes)
810:                         MsgInfo("Emiss" + CHR(227) + "o cancelada com sucesso.", "Cancelado")
811:                         THIS.Release()
812:                     ENDIF
813:                 ENDIF
814:             ENDIF
815:         CATCH TO loc_oErro
816:             MsgErro("Erro ao cancelar emiss" + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
817:         ENDTRY
818:     ENDPROC
819: 
820:     *==========================================================================
821:     * BtnImprimirClick - Imprime frente, verso ou copia conforme opcao selecionada
822:     *==========================================================================
823:     PROCEDURE BtnImprimirClick()
824:         DO CASE
825:         CASE THIS.opt_4c_Imprime.Value = 1
826:             THIS.EmiteCheque()
827:         CASE THIS.opt_4c_Imprime.Value = 2
828:             THIS.EmiteVerso()
829:         CASE THIS.opt_4c_Imprime.Value = 3 OR THIS.opt_4c_Imprime.Value = 4
830:             THIS.enviaimp = .T.
831:             THIS.EmiteCopia()
832:         ENDCASE
833:     ENDPROC
834: 
835:     *==========================================================================
836:     * BtnEncerrarClick - Encerra form; se nao emitido, salva status e confirma saida
837:     *==========================================================================
838:     PROCEDURE BtnEncerrarClick()
839:         LOCAL loc_oBO, loc_lConfirmado, loc_oErro
840:         TRY
841:             loc_oBO         = THIS.this_oBusinessObject
842:             loc_lConfirmado = .T.
843:             IF VARTYPE(loc_oBO) = "O" AND !loc_oBO.this_lEmitidos
844:                 loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
845:                                           loc_oBO.this_cFavos, ;
846:                                           loc_oBO.this_nNEmissoes)
847:                 loc_lConfirmado = MsgConfirma("ATEN" + CHR(199) + CHR(195) + "O!!!" + CHR(13) + ;
848:                     "Este cheque n" + CHR(227) + "o ser" + CHR(225) + " emitido..." + CHR(13) + ;
849:                     "Confirmando a sua sa" + CHR(237) + "da, este cheque ficar" + CHR(225) + ;
850:                     " pendente at" + CHR(233) + " a sua emiss" + CHR(227) + "o." + CHR(13) + ;
851:                     "Confirma a Sa" + CHR(237) + "da ?")
852:             ENDIF
853:             IF loc_lConfirmado
854:                 THIS.Release()
855:             ENDIF
856:         CATCH TO loc_oErro
857:             MsgErro("Erro ao encerrar:" + CHR(13) + loc_oErro.Message, "Erro")
858:         ENDTRY
859:     ENDPROC
860: 
861:     *==========================================================================
862:     * EmiteCheque - Emite cheque fisico na impressora via porta serial
863:     *==========================================================================
864:     PROCEDURE EmiteCheque()
865:         LOCAL loc_oBO, loc_nImpCheqs, loc_cValor, loc_cData, loc_cSQL, loc_oErro
866:         TRY
867:             loc_oBO       = THIS.this_oBusinessObject
868:             loc_nImpCheqs = 1
869: 
870:             IF !PEMSTATUS(THIS, "obj_4c_OModem", 5)
871:                 MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
872:                         CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
873:             ELSE
874:             loc_cSQL      = "SELECT ImpCheqs FROM SigCdPam"
875: 
876:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
877:                 SELECT cursor_4c_Param
878:                 GO TOP
879:                 loc_nImpCheqs = NVL(ImpCheqs, 1)
880:                 USE IN cursor_4c_Param
881:             ENDIF
882: 
883:             MsgInfo("Posicione o cheque na impressora...", "IMPRIME CHEQUE")
884: 
885:             loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
886:                        "WHERE Tipos = 'Impressora de Cheque'"
887:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
888:                 SELECT cursor_4c_CfCom
889:                 GO TOP
890:                 IF !EOF()
891:                     IF !THIS.obj_4c_OModem.portopen
892:                         THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
893:                         THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
894:                         THIS.obj_4c_OModem.Inputlen = 1
895:                     ENDIF
896:                 ENDIF
897:                 USE IN cursor_4c_CfCom
898:                 THIS.obj_4c_OModem.PortOpen = .T.
899: 
900:                 IF loc_nImpCheqs = 2
901:                     loc_cValor = ALLTRIM(TRANSFORM(loc_oBO.this_nParValos * 100, "@L 99999999999999"))
902:                     loc_cData  = TRANSFORM(DAY(loc_oBO.this_dParVencs),   "@L 99") + ;
903:                                  TRANSFORM(MONTH(loc_oBO.this_dParVencs), "@L 99") + ;
904:                                  RIGHT(STR(YEAR(loc_oBO.this_dParVencs), 4), 2)

*-- Linhas 955 a 1005:
955:     *==========================================================================
956:     * EmiteVerso - Emite verso do cheque na impressora via porta serial
957:     *==========================================================================
958:     PROCEDURE EmiteVerso()
959:         LOCAL loc_oBO, loc_nImpCheqs, loc_cVerso, loc_nLx, loc_cSQL, loc_oErro
960:         TRY
961:             loc_oBO       = THIS.this_oBusinessObject
962:             loc_nImpCheqs = 1
963: 
964:             IF !loc_oBO.this_lEmitidos
965:                 MsgAviso("Primeiro deve ser impressa a frente do cheque!", ;
966:                          "ERRO DE CONFIGURA" + CHR(199) + CHR(195) + "O!!")
967:             ELSE
968:                 IF !PEMSTATUS(THIS, "obj_4c_OModem", 5)
969:                     MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
970:                             CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
971:                 ELSE
972:                 loc_cSQL = "SELECT ImpCheqs FROM SigCdPam"
973:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
974:                     SELECT cursor_4c_Param
975:                     GO TOP
976:                     loc_nImpCheqs = NVL(ImpCheqs, 1)
977:                     USE IN cursor_4c_Param
978:                 ENDIF
979: 
980:                 MsgInfo("Posicione o cheque na impressora para impress" + CHR(227) + "o do verso...", ;
981:                         "IMPRIME CHEQUE")
982: 
983:                 loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
984:                            "WHERE Tipos = 'Impressora de Cheque'"
985:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
986:                     SELECT cursor_4c_CfCom
987:                     GO TOP
988:                     IF !EOF()
989:                         IF !THIS.obj_4c_OModem.portopen
990:                             THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
991:                             THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
992:                             THIS.obj_4c_OModem.Inputlen = 1
993:                         ENDIF
994:                     ENDIF
995:                     USE IN cursor_4c_CfCom
996:                     THIS.obj_4c_OModem.PortOpen = .T.
997: 
998:                     loc_cVerso = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
999:                                      THIS.obj_4c_Get_Verso.Value, ;
1000:                                      loc_oBO.this_cVersos)
1001: 
1002:                     IF loc_nImpCheqs = 2
1003:                         SET CENTURY OFF
1004:                         SET MEMOWIDTH TO 50
1005:                         FOR loc_nLx = 1 TO MEMLINES(loc_cVerso)

*-- Linhas 1048 a 1091:
1048:     *==========================================================================
1049:     * EmiteCopia - Gera relatorio de copia do cheque (preview ou impressao fisica)
1050:     *==========================================================================
1051:     PROCEDURE EmiteCopia()
1052:         LOCAL loc_oBO, loc_cSQL, loc_cGrupoRecs, loc_cContaRecs, loc_cPagDesc
1053:         LOCAL loc_lcChv, loc_lcFornece, loc_lcCliente, loc_lcCodSeg, loc_lcPagto
1054:         LOCAL loc_lcEDNI, loc_lnCnt, loc_cHist, loc_cHist2, loc_oErro
1055:         TRY
1056:             loc_oBO        = THIS.this_oBusinessObject
1057:             loc_cGrupoRecs = ""
1058:             loc_cContaRecs = ""
1059: 
1060:             PUBLIC _Extenso, _Mes, _ObsPg, _Largo
1061:             _Extenso = ""
1062:             _Mes     = " "
1063:             _ObsPg   = " "
1064:             _Largo   = 2
1065:             IF TYPE("fValorExtenso") = "FN"
1066:                 _Extenso = fValorExtenso(loc_oBO.this_nParValos)
1067:             ENDIF
1068:             IF TYPE("fMesExtenso") = "FN"
1069:                 _Mes = fMesExtenso(loc_oBO.this_dParVencs)
1070:             ENDIF
1071: 
1072:             loc_cSQL = "SELECT GrupoRecs, ContaRecs FROM SigCdPam"
1073:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
1074:                 SELECT cursor_4c_Pam
1075:                 GO TOP
1076:                 loc_cGrupoRecs = NVL(ALLTRIM(GrupoRecs), "")
1077:                 loc_cContaRecs = NVL(ALLTRIM(ContaRecs), "")
1078:                 USE IN cursor_4c_Pam
1079:             ENDIF
1080: 
1081:             loc_cPagDesc = ""
1082:             IF !EMPTY(ALLTRIM(loc_oBO.this_cParFPags))
1083:                 loc_cSQL = "SELECT Descrs FROM SigOpFpp " + ;
1084:                            "WHERE FPags = " + EscaparSQL(loc_oBO.this_cParFPags) + ;
1085:                            " AND ImpCpChqs = 2"
1086:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPag") > 0
1087:                     SELECT cursor_4c_FPag
1088:                     GO TOP
1089:                     IF !EOF()
1090:                         loc_cPagDesc = NVL(ALLTRIM(Descrs), "")
1091:                     ENDIF

*-- Linhas 1280 a 1562:
1280:     *==========================================================================
1281:     * BOParaForm - Popula controles visuais com dados do BO
1282:     *==========================================================================
1283:     PROCEDURE BOParaForm()
1284:         LOCAL loc_oBO, loc_oErro
1285:         TRY
1286:             loc_oBO = THIS.this_oBusinessObject
1287:             IF VARTYPE(loc_oBO) = "O"
1288:                 IF VARTYPE(THIS.cnt_4c_Cheque) = "O"
1289:                     WITH THIS.cnt_4c_Cheque
1290:                         IF VARTYPE(.txt_4c_Bco) = "O"
1291:                             .txt_4c_Bco.Value = loc_oBO.this_cParBancos
1292:                         ENDIF
1293:                         IF VARTYPE(.txt_4c_Age) = "O"
1294:                             .txt_4c_Age.Value = loc_oBO.this_cParAgencias
1295:                         ENDIF
1296:                         IF VARTYPE(.txt_4c_Conta) = "O"
1297:                             .txt_4c_Conta.Value = loc_oBO.this_cParContas
1298:                         ENDIF
1299:                         IF VARTYPE(.txt_4c_Num) = "O"
1300:                             .txt_4c_Num.Value = loc_oBO.this_cParNumeros
1301:                         ENDIF
1302:                         IF VARTYPE(.txt_4c_Valor) = "O"
1303:                             .txt_4c_Valor.Value = loc_oBO.this_nParValos
1304:                         ENDIF
1305:                         IF VARTYPE(.txt_4c_Vencimento) = "O"
1306:                             .txt_4c_Vencimento.Value = loc_oBO.this_dParVencs
1307:                         ENDIF
1308:                         .Visible     = .T.
1309:                     ENDWITH
1310:                 ENDIF
1311:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1312:                     THIS.txt_4c_Favorecido.Value = loc_oBO.this_cFavos
1313:                 ENDIF
1314:                 IF VARTYPE(THIS.txt_4c_Copia) = "O"
1315:                     THIS.txt_4c_Copia.Value = TRANSFORM(loc_oBO.this_nNCopias)
1316:                 ENDIF
1317:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1318:                     THIS.obj_4c_Get_Verso.Value = loc_oBO.this_cVersos
1319:                     THIS.peantvalue = loc_oBO.this_cVersos
1320:                 ENDIF
1321:             ENDIF
1322:         CATCH TO loc_oErro
1323:             MsgErro(loc_oErro.Message, "Erro")
1324:         ENDTRY
1325:     ENDPROC
1326: 
1327:     *==========================================================================
1328:     * VersoLostFocus - Salva verso se o conteudo foi alterado
1329:     *==========================================================================
1330:     PROCEDURE VersoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1331:         LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
1332:         TRY
1333:             loc_oBO = THIS.this_oBusinessObject
1334:             IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1335:                 loc_cVersoAtual = THIS.obj_4c_Get_Verso.Value
1336:                 IF !(ALLTRIM(loc_cVersoAtual) == ALLTRIM(THIS.peantvalue))
1337:                     loc_oBO.AtualizarVerso(loc_oBO.this_cCidChaves, loc_cVersoAtual)
1338:                     THIS.peantvalue = loc_cVersoAtual
1339:                 ENDIF
1340:             ENDIF
1341:         CATCH TO loc_oErro
1342:             MsgErro(loc_oErro.Message, "Erro")
1343:         ENDTRY
1344:     ENDPROC
1345: 
1346:     *==========================================================================
1347:     * FavorecidoLostFocus - Sincroniza BO com valor editado do campo favorecido
1348:     *==========================================================================
1349:     PROCEDURE FavorecidoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1350:         LOCAL loc_oBO, loc_oErro
1351:         TRY
1352:             loc_oBO = THIS.this_oBusinessObject
1353:             IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.txt_4c_Favorecido) = "O"
1354:                 loc_oBO.this_cFavos = ALLTRIM(THIS.txt_4c_Favorecido.Value)
1355:             ENDIF
1356:         CATCH TO loc_oErro
1357:             MsgErro(loc_oErro.Message, "Erro")
1358:         ENDTRY
1359:     ENDPROC
1360: 
1361:     *==========================================================================
1362:     * FormParaBO - Popula BO com dados editaveis do formulario
1363:     * Campos editaveis: favorecido e verso (restantes sao somente leitura)
1364:     *==========================================================================
1365:     PROCEDURE FormParaBO()
1366:         LOCAL loc_oBO, loc_oErro
1367:         TRY
1368:             loc_oBO = THIS.this_oBusinessObject
1369:             IF VARTYPE(loc_oBO) = "O"
1370:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1371:                     loc_oBO.this_cFavos = ALLTRIM(THIS.txt_4c_Favorecido.Value)
1372:                 ENDIF
1373:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1374:                     loc_oBO.this_cVersos = THIS.obj_4c_Get_Verso.Value
1375:                 ENDIF
1376:             ENDIF
1377:         CATCH TO loc_oErro
1378:             MsgErro(loc_oErro.Message, "Erro")
1379:         ENDTRY
1380:     ENDPROC
1381: 
1382:     *==========================================================================
1383:     * HabilitarCampos - Controla editabilidade dos campos conforme modo
1384:     * par_cModo: "INSERIR", "ALTERAR" (editavel) ou outro (somente leitura)
1385:     *==========================================================================
1386:     PROTECTED PROCEDURE HabilitarCampos(par_cModo)
1387:         LOCAL loc_lEditavel, loc_lVersoEditavel, loc_oBO, loc_oErro
1388:         TRY
1389:             loc_oBO       = THIS.this_oBusinessObject
1390:             loc_lEditavel = INLIST(par_cModo, "INSERIR", "ALTERAR")
1391: 
1392:             IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1393:                 THIS.txt_4c_Favorecido.ReadOnly  = !loc_lEditavel
1394:                 THIS.txt_4c_Favorecido.BackColor = IIF(loc_lEditavel, RGB(255,255,255), RGB(240,240,240))
1395:             ENDIF
1396: 
1397:             IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1398:                 loc_lVersoEditavel = loc_lEditavel AND ;
1399:                                      VARTYPE(loc_oBO) = "O" AND ;
1400:                                      loc_oBO.this_nImpVersos = 0
1401:                 THIS.obj_4c_Get_Verso.ReadOnly  = !loc_lVersoEditavel
1402:                 THIS.obj_4c_Get_Verso.BackColor = IIF(loc_lVersoEditavel, RGB(255,255,255), RGB(240,240,240))
1403:             ENDIF
1404:         CATCH TO loc_oErro
1405:             MsgErro(loc_oErro.Message, "Erro")
1406:         ENDTRY
1407:     ENDPROC
1408: 
1409:     *==========================================================================
1410:     * LimparCampos - Reseta campos editaveis e estado de comparacao do verso
1411:     *==========================================================================
1412:     PROTECTED PROCEDURE LimparCampos()
1413:         IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1414:             THIS.txt_4c_Favorecido.Value = ""
1415:         ENDIF
1416:         IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1417:             THIS.obj_4c_Get_Verso.Value = ""
1418:         ENDIF
1419:         THIS.peantvalue = ""
1420:     ENDPROC
1421: 
1422:     *==========================================================================
1423:     * CarregarLista - Recarrega dados do cheque do banco de dados e atualiza UI
1424:     *==========================================================================
1425:     PROCEDURE CarregarLista()
1426:         LOCAL loc_oErro
1427:         TRY
1428:             THIS.CarregarDadosCheque()
1429:             THIS.BOParaForm()
1430:             THIS.AjustarBotoesPorModo()
1431:         CATCH TO loc_oErro
1432:             MsgErro(loc_oErro.Message, "Erro")
1433:         ENDTRY
1434:     ENDPROC
1435: 
1436:     *==========================================================================
1437:     * AjustarBotoesPorModo - Centraliza ajuste de estado dos botoes e controles
1438:     * Baseado em: lEmitidos, nImpVersos e op_escolha atual
1439:     *==========================================================================
1440:     PROCEDURE AjustarBotoesPorModo()
1441:         LOCAL loc_oBO, loc_oErro
1442:         TRY
1443:             loc_oBO = THIS.this_oBusinessObject
1444:             IF VARTYPE(loc_oBO) = "O"
1445:                 IF VARTYPE(THIS.opt_4c_Imprime) = "O"
1446:                     THIS.opt_4c_Imprime.Buttons(2).Enabled = loc_oBO.this_lEmitidos
1447:                     THIS.opt_4c_Imprime.Buttons(3).Enabled = loc_oBO.this_lEmitidos
1448:                 ENDIF
1449:                 IF VARTYPE(THIS.cmd_4c_Visualizar) = "O"
1450:                     THIS.cmd_4c_Visualizar.Enabled = VARTYPE(THIS.opt_4c_Imprime) = "O" AND ;
1451:                                                      INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
1452:                 ENDIF
1453:                 IF VARTYPE(THIS.lbl_4c_LbNimp) = "O"
1454:                     THIS.lbl_4c_LbNimp.Visible = (loc_oBO.this_nImpVersos = 0)
1455:                 ENDIF
1456:                 THIS.HabilitarCampos(THIS.op_escolha)
1457:             ENDIF
1458:         CATCH TO loc_oErro
1459:             MsgErro(loc_oErro.Message, "Erro")
1460:         ENDTRY
1461:     ENDPROC
1462: 
1463:     *==========================================================================
1464:     * BtnBuscarClick - Recarrega dados do cheque a partir do banco
1465:     * Util para refletir mudancas externas no registro (ex: marca de emissao
1466:     * alterada em outra sessao) sem precisar fechar e reabrir o form.
1467:     *==========================================================================
1468:     PROCEDURE BtnBuscarClick()
1469:         LOCAL loc_oErro
1470:         TRY
1471:             THIS.CarregarLista()
1472:             THIS.InicializarEstadoBotoes()
1473:             MsgInfo("Dados do cheque atualizados.", "Buscar")
1474:         CATCH TO loc_oErro
1475:             MsgErro("Erro ao recarregar dados:" + CHR(13) + loc_oErro.Message, "Erro")
1476:         ENDTRY
1477:     ENDPROC
1478: 
1479:     *==========================================================================
1480:     * BtnSalvarClick - Grava favorecido e verso no banco (SigCqChi)
1481:     * Sincroniza form->BO e executa UPDATE via SalvarStatusSaida + AtualizarVerso.
1482:     *==========================================================================
1483:     PROCEDURE BtnSalvarClick()
1484:         LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
1485:         TRY
1486:             loc_oBO = THIS.this_oBusinessObject
1487:             IF VARTYPE(loc_oBO) != "O"
1488:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
1489:             ELSE
1490:                 IF !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
1491:                     MsgAviso("Cheque em modo somente leitura. " + ;
1492:                              "Acione Alterar antes de salvar.", "Aviso")
1493:                 ELSE
1494:                     *-- Form -> BO (favorecido e verso)
1495:                     THIS.FormParaBO()
1496: 
1497:                     *-- Persiste favorecido + status atual
1498:                     loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
1499:                                               loc_oBO.this_cFavos, ;
1500:                                               loc_oBO.this_nNEmissoes)
1501: 
1502:                     *-- Persiste verso somente se houve mudanca real
1503:                     loc_cVersoAtual = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
1504:                                           THIS.obj_4c_Get_Verso.Value, ;
1505:                                           loc_oBO.this_cVersos)
1506:                     IF !(ALLTRIM(loc_cVersoAtual) == ALLTRIM(THIS.peantvalue))
1507:                         loc_oBO.AtualizarVerso(loc_oBO.this_cCidChaves, loc_cVersoAtual)
1508:                         THIS.peantvalue = loc_cVersoAtual
1509:                     ENDIF
1510: 
1511:                     MsgInfo("Altera" + CHR(231) + CHR(245) + "es salvas com sucesso.", "Salvo")
1512:                 ENDIF
1513:             ENDIF
1514:         CATCH TO loc_oErro
1515:             MsgErro("Erro ao salvar altera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1516:                     loc_oErro.Message, "Erro")
1517:         ENDTRY
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * BtnCancelarClick - Reverte favorecido e verso para o ultimo estado gravado
1522:     * Recarrega dados do banco sem fechar o form; exige confirmacao do usuario.
1523:     *==========================================================================
1524:     PROCEDURE BtnCancelarClick()
1525:         LOCAL loc_oBO, loc_lConfirma, loc_oErro
1526:         TRY
1527:             loc_oBO = THIS.this_oBusinessObject
1528:             IF VARTYPE(loc_oBO) != "O"
1529:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
1530:             ELSE
1531:                 loc_lConfirma = MsgConfirma("Descartar altera" + CHR(231) + CHR(245) + ;
1532:                                             "es n" + CHR(227) + "o salvas e recarregar dados?")
1533:                 IF loc_lConfirma
1534:                     *-- Recarrega do banco e reflete no form, mantendo o modo atual
1535:                     THIS.CarregarDadosCheque()
1536:                     THIS.BOParaForm()
1537:                     THIS.AjustarBotoesPorModo()
1538:                 ENDIF
1539:             ENDIF
1540:         CATCH TO loc_oErro
1541:             MsgErro("Erro ao cancelar altera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1542:                     loc_oErro.Message, "Erro")
1543:         ENDTRY
1544:     ENDPROC
1545: 
1546:     *==========================================================================
1547:     * Destroy - Libera cursores temporarios e chama DODEFAULT
1548:     *==========================================================================
1549:     PROCEDURE Destroy()
1550:         IF USED("cursor_4c_ChiDados")
1551:             USE IN cursor_4c_ChiDados
1552:         ENDIF
1553:         IF USED("cursor_4c_Par")
1554:             USE IN cursor_4c_Par
1555:         ENDIF
1556:         IF USED("cursor_4c_Emp")
1557:             USE IN cursor_4c_Emp
1558:         ENDIF
1559:         DODEFAULT()
1560:     ENDPROC
1561: 
1562: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReEchBO.prg):
*------------------------------------------------------------------------------
* SigReEchBO.prg - Business Object para Emissao de Cheque
* Tabela principal: SIGCQCHI
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS SigReEchBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela      = "SigCqChi"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    *-- Propriedades de SIGCQCHI (cheque)
    *--------------------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves  char(20) - chave primaria
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave composta emps+dopes+numes
    this_cEmps        = ""    && emps       char(3)  - empresa
    this_cDopes       = ""    && dopes      char(20) - documento operacao
    this_nNumes       = 0     && numes      numeric(6,0)
    this_cBancos      = ""    && bancos     char(3)
    this_cAgencias    = ""    && agencias   char(4)
    this_cContas      = ""    && contas     char(10)
    this_cNContas     = ""    && ncontas    char(10) - numero da conta
    this_cNCheques    = ""    && ncheques   char(6)  - numero do cheque
    this_cFavos       = ""    && favos      char(40) - favorecido
    this_nValors      = 0     && valors     numeric(11,2)
    this_dVencs       = {}    && vencs      datetime - vencimento
    this_cVersos      = ""    && versos     text     - verso do cheque
    this_lEmitidos    = .F.   && emitidos   bit      - se ja foi emitido
    this_nNEmissoes   = 0     && nemissoes  numeric(2,0) - numero de emissoes
    this_nNCopias     = 0     && ncopias    numeric(6,0) - numero de copias
    this_nImpVersos   = 0     && impversos  numeric(1,0) - se verso foi impresso
    this_lCancelas    = .F.   && cancelas   bit      - se cancelado
    this_cGrupos      = ""    && grupos     char(10)
    this_dDatas       = {}    && datas      datetime
    this_cJustCanc    = ""    && justcanc   text     - justificativa cancelamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigMvPar (parcela vinculada ao cheque - cursor CrPar)
    *--------------------------------------------------------------------------
    this_cParBancos   = ""    && bancos    char(3)
    this_cParAgencias = ""    && agencias  char(4)
    this_cParContas   = ""    && contas    char(10)
    this_cParNumeros  = ""    && numeros   char(6)
    this_nParValos    = 0     && valos     numeric(11,2) - valor da parcela
    this_dParVencs    = {}    && vencs     datetime      - vencimento da parcela
    this_cParFPags    = ""    && fpags     char(12)      - forma de pagamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigCdEmp (empresa - cursor CrSigCdEmp)
    *--------------------------------------------------------------------------
    this_cCidEmps     = ""    && cidas char(30) - cidade da empresa

    *--------------------------------------------------------------------------
    *-- Parametros e estado de execucao do formulario
    *--------------------------------------------------------------------------
    this_cOpEscolha    = ""   && INSERIR, ALTERAR - modo do form ao abrir
    this_cNchequeParam = ""   && _ncheque filtro inicial (opcional)
    this_lEnviaImp     = .F.  && .T.=imprimir fisicamente, .F.=preview em video
    this_cPeAntValue   = ""   && valor anterior do campo verso (para detectar mudanca)

    *--------------------------------------------------------------------------
    PROCEDURE Init
        THIS.this_cTabela     = "SigCqChi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigCqChi para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
            THIS.this_cEmpDopNums = NVL(ALLTRIM(empdopnums), "")
            THIS.this_cEmps       = NVL(ALLTRIM(emps), "")
            THIS.this_cDopes      = NVL(ALLTRIM(dopes), "")
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_cBancos     = NVL(ALLTRIM(bancos), "")
            THIS.this_cAgencias   = NVL(ALLTRIM(agencias), "")
            THIS.this_cContas     = NVL(ALLTRIM(contas), "")
            THIS.this_cNContas    = NVL(ALLTRIM(ncontas), "")
            THIS.this_cNCheques   = NVL(ALLTRIM(ncheques), "")
            THIS.this_cFavos      = NVL(ALLTRIM(favos), "")
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = NVL(vencs, {})
            THIS.this_cVersos     = NVL(versos, "")
            IF VARTYPE(emitidos) = "L"
                THIS.this_lEmitidos = emitidos
            ELSE
                THIS.this_lEmitidos = IIF(NVL(emitidos, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_nNEmissoes  = NVL(nemissoes, 0)
            THIS.this_nNCopias    = NVL(ncopias, 0)
            THIS.this_nImpVersos  = NVL(impversos, 0)
            IF VARTYPE(cancelas) = "L"
                THIS.this_lCancelas = cancelas
            ELSE
                THIS.this_lCancelas = IIF(NVL(cancelas, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_cGrupos     = NVL(ALLTRIM(grupos), "")
            THIS.this_dDatas      = NVL(datas, {})
            THIS.this_cJustCanc   = NVL(justcanc, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega cheque de SigCqChi por emps+dopes+numes
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_cEmps, par_cDopes, par_nNumes, par_cNcheque)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEDN, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cEDN = par_cEmps + PADR(par_cDopes, 20) + STR(par_nNumes, 6)
            loc_cSQL = "SELECT agencias, bancos, cancelas, contas, datas, " + ;
                       "dopes, emitidos, emps, favos, grupos, ncheques, " + ;
                       "ncontas, ncopias, nemissoes, numes, valors, vencs, " + ;
                       "versos, cidchaves, empdopnums, justcanc, impversos " + ;
                       "FROM SigCqChi " + ;
                       "WHERE empdopnums = " + EscaparSQL(loc_cEDN)
            IF !EMPTY(ALLTRIM(par_cNcheque))
                loc_cSQL = loc_cSQL + " AND ncheques = " + EscaparSQL(par_cNcheque)
            ENDIF

            IF USED("cursor_4c_ChiDados")
                TABLEREVERT(.T., "cursor_4c_ChiDados")
                USE IN cursor_4c_ChiDados
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChiDados") > 0
                SELECT cursor_4c_ChiDados
                GO TOP
                IF !EOF()
                    THIS.CarregarDoCursor("cursor_4c_ChiDados")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParcela - Carrega parcela vinculada ao cheque (SigMvPar)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParcela(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT bancos, agencias, contas, numeros, valos, vencs, fpags " + ;
                       "FROM SigMvPar " + ;
                       "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)

            IF USED("cursor_4c_Par")
                TABLEREVERT(.T., "cursor_4c_Par")
                USE IN cursor_4c_Par
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Par") > 0
                SELECT cursor_4c_Par
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Par
                    THIS.this_cParBancos   = NVL(ALLTRIM(bancos), "")
                    THIS.this_cParAgencias = NVL(ALLTRIM(agencias), "")
                    THIS.this_cParContas   = NVL(ALLTRIM(contas), "")
                    THIS.this_cParNumeros  = NVL(ALLTRIM(numeros), "")
                    THIS.this_nParValos    = NVL(valos, 0)
                    THIS.this_dParVencs    = NVL(vencs, {})
                    THIS.this_cParFPags    = NVL(ALLTRIM(fpags), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega dados da empresa (SigCdEmp)
    *--------------------------------------------------------------------------
    FUNCTION CarregarEmpresa(par_cEmps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cemps, cidas FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(par_cEmps)

            IF USED("cursor_4c_Emp")
                TABLEREVERT(.T., "cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Emp
                    THIS.this_cCidEmps = NVL(ALLTRIM(cidas), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves  = LEFT(THIS.this_cEmps + SYS(2015) + PADR(SYS(1), 7, "0"), 20)
            THIS.this_cEmpDopNums = THIS.this_cEmps + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigCqChi " + ;
                       "(cidchaves, empdopnums, emps, dopes, numes, " + ;
                       "agencias, bancos, contas, ncontas, ncheques, " + ;
                       "favos, valors, vencs, versos, emitidos, " + ;
                       "nemissoes, ncopias, impversos, cancelas, " + ;
                       "grupos, datas, justcanc) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       EscaparSQL(THIS.this_cVersos) + ", " + ;
                       IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(THIS.this_cJustCanc) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi SET " + ;
                       "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       "numes = " + FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       "agencias = " + EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       "bancos = " + EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       "contas = " + EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       "ncontas = " + EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       "ncheques = " + EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       "favos = " + EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       "valors = " + FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       "vencs = " + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       "versos = " + EscaparSQL(THIS.this_cVersos) + ", " + ;
                       "emitidos = " + IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       "ncopias = " + FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       "impversos = " + FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       "cancelas = " + IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       "grupos = " + EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       "datas = " + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "justcanc = " + EscaparSQL(THIS.this_cJustCanc) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarEmitido - Marca cheque como emitido e incrementa emissoes
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmitido(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 1, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarVersoImpresso - Marca verso do cheque como impresso (impversos=1)
    *--------------------------------------------------------------------------
    FUNCTION MarcarVersoImpresso(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET impversos = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarVerso - Atualiza texto do verso do cheque
    *--------------------------------------------------------------------------
    FUNCTION AtualizarVerso(par_cCidChaves, par_cVerso)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET versos = " + EscaparSQL(par_cVerso) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarStatusSaida - Salva status ao sair sem emitir (emitidos=0)
    *--------------------------------------------------------------------------
    FUNCTION SalvarStatusSaida(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 0, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

