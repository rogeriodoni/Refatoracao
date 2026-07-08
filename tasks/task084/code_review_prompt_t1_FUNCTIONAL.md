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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReEch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1557 linhas total):

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

*-- Linhas 452 a 559:
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
500:                     loc_oControl.Visible = .T.
501:                 ENDIF
502:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
503:                     FOR loc_p = 1 TO loc_oControl.PageCount
504:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
505:                     ENDFOR
506:                 ENDIF
507:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
508:                     THIS.TornarControlesVisiveis(loc_oControl)
509:                 ENDIF
510:             ENDIF
511:         ENDFOR
512:     ENDPROC
513: 
514:     *==========================================================================
515:     * ConfigurarPaginaLista - Cria botoes operacionais, OptionGroup e lbl_4c_LbNimp
516:     * Fase 4: cmd_4c_Visualizar, cmd_4c_Imprimir, cmd_4c_Encerrar,
517:     *          opt_4c_Imprime, lbl_4c_LbNimp
518:     *==========================================================================
519:     PROTECTED PROCEDURE ConfigurarPaginaLista()
520:         LOCAL loc_oErro
521:         TRY
522:             THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
523:             WITH THIS.cmd_4c_Visualizar
524:                 .Top             = 2
525:                 .Left            = 573
526:                 .Height          = 75
527:                 .Width           = 75
528:                 .Caption         = "V" + CHR(237) + "deo"
529:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
530:                 .PicturePosition = 13
531:                 .FontName        = "Comic Sans MS"
532:                 .FontSize        = 8
533:                 .FontBold        = .T.
534:                 .FontItalic      = .T.
535:                 .ForeColor       = RGB(90, 90, 90)
536:                 .BackColor       = RGB(255, 255, 255)
537:                 .Themes          = .F.
538:                 .SpecialEffect   = 0
539:                 .MousePointer    = 15
540:                 .WordWrap        = .T.
541:                 .Visible         = .T.
542:             ENDWITH
543: 
544:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
545:             WITH THIS.cmd_4c_Imprimir
546:                 .Top             = 2
547:                 .Left            = 648
548:                 .Height          = 75
549:                 .Width           = 75
550:                 .Caption         = "Impressora"
551:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
552:                 .PicturePosition = 13
553:                 .FontName        = "Comic Sans MS"
554:                 .FontSize        = 8
555:                 .FontBold        = .T.
556:                 .FontItalic      = .T.
557:                 .ForeColor       = RGB(90, 90, 90)
558:                 .BackColor       = RGB(255, 255, 255)
559:                 .Themes          = .F.

*-- Linhas 585 a 628:
585:                 .Visible         = .T.
586:             ENDWITH
587: 
588:             THIS.AddObject("opt_4c_Imprime", "OptionGroup")
589:             WITH THIS.opt_4c_Imprime
590:                 .ButtonCount   = 3
591:                 .BackStyle     = 0
592:                 .Value         = 1
593:                 .Height        = 73
594:                 .Left          = 543
595:                 .SpecialEffect = 1
596:                 .Top           = 192
597:                 .Width         = 79
598:                 .BorderColor   = RGB(36, 84, 155)
599:                 .Visible       = .T.
600:                 WITH .Buttons(1)
601:                     .BackStyle = 0
602:                     .Caption   = "Cheque"
603:                     .Value     = 1
604:                     .Height    = 15
605:                     .Left      = 7
606:                     .Top       = 7
607:                     .Width     = 55
608:                     .AutoSize  = .T.
609:                     .ForeColor = RGB(90, 90, 90)
610:                 ENDWITH
611:                 WITH .Buttons(2)
612:                     .FontName  = "Tahoma"
613:                     .FontSize  = 8
614:                     .BackStyle = 0
615:                     .Caption   = "Verso"
616:                     .Height    = 15
617:                     .Left      = 7
618:                     .Top       = 28
619:                     .Width     = 45
620:                     .AutoSize  = .T.
621:                     .ForeColor = RGB(90, 90, 90)
622:                 ENDWITH
623:                 WITH .Buttons(3)
624:                     .FontName  = "Tahoma"
625:                     .FontSize  = 8
626:                     .BackStyle = 0
627:                     .Caption   = "C" + CHR(243) + "pia"
628:                     .Height    = 15

*-- Linhas 649 a 899:
649:                 .Visible   = .F.
650:             ENDWITH
651: 
652:             BINDEVENT(THIS.cmd_4c_Visualizar, "Click",             THIS, "BtnVisualizarClick")
653:             BINDEVENT(THIS.cmd_4c_Imprimir,   "Click",             THIS, "BtnImprimirClick")
654:             BINDEVENT(THIS.cmd_4c_Encerrar,   "Click",             THIS, "BtnEncerrarClick")
655:             BINDEVENT(THIS.opt_4c_Imprime,    "InteractiveChange", THIS, "OptImprimicChange")
656: 
657:         CATCH TO loc_oErro
658:             MsgErro(loc_oErro.Message, "Erro")
659:         ENDTRY
660:     ENDPROC
661: 
662:     *==========================================================================
663:     * AlternarPagina - Sincroniza estado do botao Video com a opcao selecionada
664:     *==========================================================================
665:     PROCEDURE AlternarPagina()
666:         IF VARTYPE(THIS.cmd_4c_Visualizar) = "O" AND VARTYPE(THIS.opt_4c_Imprime) = "O"
667:             THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
668:         ENDIF
669:     ENDPROC
670: 
671:     *==========================================================================
672:     * InicializarEstadoBotoes - Define estado inicial dos botoes apos carregar dados
673:     *==========================================================================
674:     PROTECTED PROCEDURE InicializarEstadoBotoes()
675:         LOCAL loc_oBO, loc_oErro
676:         TRY
677:             loc_oBO = THIS.this_oBusinessObject
678:             IF VARTYPE(loc_oBO) = "O"
679:                 THIS.opt_4c_Imprime.Buttons(2).Enabled = loc_oBO.this_lEmitidos
680:                 THIS.opt_4c_Imprime.Buttons(3).Enabled = loc_oBO.this_lEmitidos
681:                 THIS.opt_4c_Imprime.Value = IIF(loc_oBO.this_lEmitidos, 3, 1)
682:                 IF loc_oBO.this_lEmitidos
683:                     THIS.opt_4c_Imprime.Buttons(3).SetFocus
684:                 ENDIF
685:                 THIS.cmd_4c_Visualizar.Enabled  = loc_oBO.this_lEmitidos
686:                 THIS.lbl_4c_LbNimp.Visible      = (loc_oBO.this_nImpVersos = 0)
687:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
688:                     THIS.obj_4c_Get_Verso.ReadOnly = !(INLIST(THIS.op_escolha, "INSERIR", "ALTERAR") AND loc_oBO.this_nImpVersos = 0)
689:                     IF THIS.obj_4c_Get_Verso.ReadOnly
690:                         THIS.obj_4c_Get_Verso.BackColor = RGB(240, 240, 240)
691:                     ENDIF
692:                 ENDIF
693:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
694:                     THIS.txt_4c_Favorecido.ReadOnly = !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
695:                     IF THIS.txt_4c_Favorecido.ReadOnly
696:                         THIS.txt_4c_Favorecido.BackColor = RGB(240, 240, 240)
697:                     ENDIF
698:                 ENDIF
699:             ENDIF
700:         CATCH TO loc_oErro
701:             MsgErro(loc_oErro.Message, "Erro")
702:         ENDTRY
703:     ENDPROC
704: 
705:     *==========================================================================
706:     * OptImprimicChange - Atualiza Visualizar.Enabled conforme opcao selecionada
707:     *==========================================================================
708:     PROCEDURE OptImprimicChange()
709:         THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
710:     ENDPROC
711: 
712:     *==========================================================================
713:     * BtnVisualizarClick - Exibe copia do cheque em preview (Video)
714:     *==========================================================================
715:     PROCEDURE BtnVisualizarClick()
716:         THIS.enviaimp = .F.
717:         THIS.EmiteCopia()
718:     ENDPROC
719: 
720:     *==========================================================================
721:     * BtnIncluirClick - Coloca form em modo INSERIR e dispara emissao do cheque
722:     * Equivalente ao fluxo Op_Escolha="INSERIR" do legado: marca operacao como
723:     * inclusao de novo cheque e executa impressao da frente conforme opcao.
724:     *==========================================================================
725:     PROCEDURE BtnIncluirClick()
726:         LOCAL loc_oBO, loc_oErro
727:         TRY
728:             loc_oBO = THIS.this_oBusinessObject
729:             THIS.op_escolha = "INSERIR"
730: 
731:             IF VARTYPE(loc_oBO) != "O"
732:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
733:             ELSE
734:                 IF loc_oBO.this_lEmitidos
735:                     MsgAviso("Este cheque j" + CHR(225) + " foi emitido." + CHR(13) + ;
736:                              "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel emitir novamente.", ;
737:                              "Aviso")
738:                 ELSE
739:                     DO CASE
740:                     CASE THIS.opt_4c_Imprime.Value = 1
741:                         THIS.EmiteCheque()
742:                     CASE THIS.opt_4c_Imprime.Value = 2
743:                         THIS.EmiteVerso()
744:                     OTHERWISE
745:                         THIS.enviaimp = .T.
746:                         THIS.EmiteCopia()
747:                     ENDCASE
748:                 ENDIF
749:             ENDIF
750:         CATCH TO loc_oErro
751:             MsgErro("Erro ao incluir emiss" + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
752:         ENDTRY
753:     ENDPROC
754: 
755:     *==========================================================================
756:     * BtnAlterarClick - Coloca form em modo ALTERAR e habilita edicao do verso
757:     * Equivalente ao fluxo Op_Escolha="ALTERAR" do legado: permite alterar
758:     * favorecido e verso. Mantem registro existente, nao cria novo.
759:     *==========================================================================
760:     PROCEDURE BtnAlterarClick()
761:         LOCAL loc_oBO, loc_oErro
762:         TRY
763:             loc_oBO = THIS.this_oBusinessObject
764:             THIS.op_escolha = "ALTERAR"
765: 
766:             IF VARTYPE(loc_oBO) != "O"
767:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
768:             ELSE
769:                 *-- Reabilita campos editaveis no modo ALTERAR
770:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
771:                     THIS.txt_4c_Favorecido.Enabled = .T.
772:                 ENDIF
773:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O" AND loc_oBO.this_nImpVersos = 0
774:                     THIS.obj_4c_Get_Verso.Enabled = .T.
775:                     THIS.obj_4c_Get_Verso.SetFocus()
776:                 ENDIF
777:             ENDIF
778:         CATCH TO loc_oErro
779:             MsgErro("Erro ao alterar cheque:" + CHR(13) + loc_oErro.Message, "Erro")
780:         ENDTRY
781:     ENDPROC
782: 
783:     *==========================================================================
784:     * BtnExcluirClick - Cancela emissao do cheque (marca como nao emitido)
785:     * Equivalente ao bloco "If !crSigCqChi.Emitidos" do Sair.Click legado:
786:     * persiste status nao-emitido e libera o cheque para emissao futura.
787:     *==========================================================================
788:     PROCEDURE BtnExcluirClick()
789:         LOCAL loc_oBO, loc_lConfirma, loc_oErro
790:         TRY
791:             loc_oBO = THIS.this_oBusinessObject
792:             IF VARTYPE(loc_oBO) != "O"
793:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
794:             ELSE
795:                 IF loc_oBO.this_lEmitidos
796:                     MsgAviso("Este cheque j" + CHR(225) + " foi emitido e n" + CHR(227) + "o pode ser cancelado.", ;
797:                              "Aviso")
798:                 ELSE
799:                     loc_lConfirma = MsgConfirma("Confirma o cancelamento da emiss" + CHR(227) + "o deste cheque?")
800:                     IF loc_lConfirma
801:                         loc_oBO.this_lEmitidos = .F.
802:                         loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
803:                                                   loc_oBO.this_cFavos, ;
804:                                                   loc_oBO.this_nNEmissoes)
805:                         MsgInfo("Emiss" + CHR(227) + "o cancelada com sucesso.", "Cancelado")
806:                         THIS.Release()
807:                     ENDIF
808:                 ENDIF
809:             ENDIF
810:         CATCH TO loc_oErro
811:             MsgErro("Erro ao cancelar emiss" + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
812:         ENDTRY
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * BtnImprimirClick - Imprime frente, verso ou copia conforme opcao selecionada
817:     *==========================================================================
818:     PROCEDURE BtnImprimirClick()
819:         DO CASE
820:         CASE THIS.opt_4c_Imprime.Value = 1
821:             THIS.EmiteCheque()
822:         CASE THIS.opt_4c_Imprime.Value = 2
823:             THIS.EmiteVerso()
824:         CASE THIS.opt_4c_Imprime.Value = 3 OR THIS.opt_4c_Imprime.Value = 4
825:             THIS.enviaimp = .T.
826:             THIS.EmiteCopia()
827:         ENDCASE
828:     ENDPROC
829: 
830:     *==========================================================================
831:     * BtnEncerrarClick - Encerra form; se nao emitido, salva status e confirma saida
832:     *==========================================================================
833:     PROCEDURE BtnEncerrarClick()
834:         LOCAL loc_oBO, loc_lConfirmado, loc_oErro
835:         TRY
836:             loc_oBO         = THIS.this_oBusinessObject
837:             loc_lConfirmado = .T.
838:             IF VARTYPE(loc_oBO) = "O" AND !loc_oBO.this_lEmitidos
839:                 loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
840:                                           loc_oBO.this_cFavos, ;
841:                                           loc_oBO.this_nNEmissoes)
842:                 loc_lConfirmado = MsgConfirma("ATEN" + CHR(199) + CHR(195) + "O!!!" + CHR(13) + ;
843:                     "Este cheque n" + CHR(227) + "o ser" + CHR(225) + " emitido..." + CHR(13) + ;
844:                     "Confirmando a sua sa" + CHR(237) + "da, este cheque ficar" + CHR(225) + ;
845:                     " pendente at" + CHR(233) + " a sua emiss" + CHR(227) + "o." + CHR(13) + ;
846:                     "Confirma a Sa" + CHR(237) + "da ?")
847:             ENDIF
848:             IF loc_lConfirmado
849:                 THIS.Release()
850:             ENDIF
851:         CATCH TO loc_oErro
852:             MsgErro("Erro ao encerrar:" + CHR(13) + loc_oErro.Message, "Erro")
853:         ENDTRY
854:     ENDPROC
855: 
856:     *==========================================================================
857:     * EmiteCheque - Emite cheque fisico na impressora via porta serial
858:     *==========================================================================
859:     PROCEDURE EmiteCheque()
860:         LOCAL loc_oBO, loc_nImpCheqs, loc_cValor, loc_cData, loc_cSQL, loc_oErro
861:         TRY
862:             loc_oBO       = THIS.this_oBusinessObject
863:             loc_nImpCheqs = 1
864: 
865:             IF !PEMSTATUS(THIS, "obj_4c_OModem", 5)
866:                 MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
867:                         CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
868:             ELSE
869:             loc_cSQL      = "SELECT ImpCheqs FROM SigCdPam"
870: 
871:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
872:                 SELECT cursor_4c_Param
873:                 GO TOP
874:                 loc_nImpCheqs = NVL(ImpCheqs, 1)
875:                 USE IN cursor_4c_Param
876:             ENDIF
877: 
878:             MsgInfo("Posicione o cheque na impressora...", "IMPRIME CHEQUE")
879: 
880:             loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
881:                        "WHERE Tipos = 'Impressora de Cheque'"
882:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
883:                 SELECT cursor_4c_CfCom
884:                 GO TOP
885:                 IF !EOF()
886:                     IF !THIS.obj_4c_OModem.portopen
887:                         THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
888:                         THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
889:                         THIS.obj_4c_OModem.Inputlen = 1
890:                     ENDIF
891:                 ENDIF
892:                 USE IN cursor_4c_CfCom
893:                 THIS.obj_4c_OModem.PortOpen = .T.
894: 
895:                 IF loc_nImpCheqs = 2
896:                     loc_cValor = ALLTRIM(TRANSFORM(loc_oBO.this_nParValos * 100, "@L 99999999999999"))
897:                     loc_cData  = TRANSFORM(DAY(loc_oBO.this_dParVencs),   "@L 99") + ;
898:                                  TRANSFORM(MONTH(loc_oBO.this_dParVencs), "@L 99") + ;
899:                                  RIGHT(STR(YEAR(loc_oBO.this_dParVencs), 4), 2)

*-- Linhas 950 a 1000:
950:     *==========================================================================
951:     * EmiteVerso - Emite verso do cheque na impressora via porta serial
952:     *==========================================================================
953:     PROCEDURE EmiteVerso()
954:         LOCAL loc_oBO, loc_nImpCheqs, loc_cVerso, loc_nLx, loc_cSQL, loc_oErro
955:         TRY
956:             loc_oBO       = THIS.this_oBusinessObject
957:             loc_nImpCheqs = 1
958: 
959:             IF !loc_oBO.this_lEmitidos
960:                 MsgAviso("Primeiro deve ser impressa a frente do cheque!", ;
961:                          "ERRO DE CONFIGURA" + CHR(199) + CHR(195) + "O!!")
962:             ELSE
963:                 IF !PEMSTATUS(THIS, "obj_4c_OModem", 5)
964:                     MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
965:                             CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
966:                 ELSE
967:                 loc_cSQL = "SELECT ImpCheqs FROM SigCdPam"
968:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
969:                     SELECT cursor_4c_Param
970:                     GO TOP
971:                     loc_nImpCheqs = NVL(ImpCheqs, 1)
972:                     USE IN cursor_4c_Param
973:                 ENDIF
974: 
975:                 MsgInfo("Posicione o cheque na impressora para impress" + CHR(227) + "o do verso...", ;
976:                         "IMPRIME CHEQUE")
977: 
978:                 loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
979:                            "WHERE Tipos = 'Impressora de Cheque'"
980:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
981:                     SELECT cursor_4c_CfCom
982:                     GO TOP
983:                     IF !EOF()
984:                         IF !THIS.obj_4c_OModem.portopen
985:                             THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
986:                             THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
987:                             THIS.obj_4c_OModem.Inputlen = 1
988:                         ENDIF
989:                     ENDIF
990:                     USE IN cursor_4c_CfCom
991:                     THIS.obj_4c_OModem.PortOpen = .T.
992: 
993:                     loc_cVerso = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
994:                                      THIS.obj_4c_Get_Verso.Value, ;
995:                                      loc_oBO.this_cVersos)
996: 
997:                     IF loc_nImpCheqs = 2
998:                         SET CENTURY OFF
999:                         SET MEMOWIDTH TO 50
1000:                         FOR loc_nLx = 1 TO MEMLINES(loc_cVerso)

*-- Linhas 1043 a 1086:
1043:     *==========================================================================
1044:     * EmiteCopia - Gera relatorio de copia do cheque (preview ou impressao fisica)
1045:     *==========================================================================
1046:     PROCEDURE EmiteCopia()
1047:         LOCAL loc_oBO, loc_cSQL, loc_cGrupoRecs, loc_cContaRecs, loc_cPagDesc
1048:         LOCAL loc_lcChv, loc_lcFornece, loc_lcCliente, loc_lcCodSeg, loc_lcPagto
1049:         LOCAL loc_lcEDNI, loc_lnCnt, loc_cHist, loc_cHist2, loc_oErro
1050:         TRY
1051:             loc_oBO        = THIS.this_oBusinessObject
1052:             loc_cGrupoRecs = ""
1053:             loc_cContaRecs = ""
1054: 
1055:             PUBLIC _Extenso, _Mes, _ObsPg, _Largo
1056:             _Extenso = ""
1057:             _Mes     = " "
1058:             _ObsPg   = " "
1059:             _Largo   = 2
1060:             IF TYPE("fValorExtenso") = "FN"
1061:                 _Extenso = fValorExtenso(loc_oBO.this_nParValos)
1062:             ENDIF
1063:             IF TYPE("fMesExtenso") = "FN"
1064:                 _Mes = fMesExtenso(loc_oBO.this_dParVencs)
1065:             ENDIF
1066: 
1067:             loc_cSQL = "SELECT GrupoRecs, ContaRecs FROM SigCdPam"
1068:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
1069:                 SELECT cursor_4c_Pam
1070:                 GO TOP
1071:                 loc_cGrupoRecs = NVL(ALLTRIM(GrupoRecs), "")
1072:                 loc_cContaRecs = NVL(ALLTRIM(ContaRecs), "")
1073:                 USE IN cursor_4c_Pam
1074:             ENDIF
1075: 
1076:             loc_cPagDesc = ""
1077:             IF !EMPTY(ALLTRIM(loc_oBO.this_cParFPags))
1078:                 loc_cSQL = "SELECT Descrs FROM SigOpFpp " + ;
1079:                            "WHERE FPags = " + EscaparSQL(loc_oBO.this_cParFPags) + ;
1080:                            " AND ImpCpChqs = 2"
1081:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPag") > 0
1082:                     SELECT cursor_4c_FPag
1083:                     GO TOP
1084:                     IF !EOF()
1085:                         loc_cPagDesc = NVL(ALLTRIM(Descrs), "")
1086:                     ENDIF

*-- Linhas 1275 a 1557:
1275:     *==========================================================================
1276:     * BOParaForm - Popula controles visuais com dados do BO
1277:     *==========================================================================
1278:     PROCEDURE BOParaForm()
1279:         LOCAL loc_oBO, loc_oErro
1280:         TRY
1281:             loc_oBO = THIS.this_oBusinessObject
1282:             IF VARTYPE(loc_oBO) = "O"
1283:                 IF VARTYPE(THIS.cnt_4c_Cheque) = "O"
1284:                     WITH THIS.cnt_4c_Cheque
1285:                         IF VARTYPE(.txt_4c_Bco) = "O"
1286:                             .txt_4c_Bco.Value = loc_oBO.this_cParBancos
1287:                         ENDIF
1288:                         IF VARTYPE(.txt_4c_Age) = "O"
1289:                             .txt_4c_Age.Value = loc_oBO.this_cParAgencias
1290:                         ENDIF
1291:                         IF VARTYPE(.txt_4c_Conta) = "O"
1292:                             .txt_4c_Conta.Value = loc_oBO.this_cParContas
1293:                         ENDIF
1294:                         IF VARTYPE(.txt_4c_Num) = "O"
1295:                             .txt_4c_Num.Value = loc_oBO.this_cParNumeros
1296:                         ENDIF
1297:                         IF VARTYPE(.txt_4c_Valor) = "O"
1298:                             .txt_4c_Valor.Value = loc_oBO.this_nParValos
1299:                         ENDIF
1300:                         IF VARTYPE(.txt_4c_Vencimento) = "O"
1301:                             .txt_4c_Vencimento.Value = loc_oBO.this_dParVencs
1302:                         ENDIF
1303:                         .Visible     = .T.
1304:                     ENDWITH
1305:                 ENDIF
1306:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1307:                     THIS.txt_4c_Favorecido.Value = loc_oBO.this_cFavos
1308:                 ENDIF
1309:                 IF VARTYPE(THIS.txt_4c_Copia) = "O"
1310:                     THIS.txt_4c_Copia.Value = TRANSFORM(loc_oBO.this_nNCopias)
1311:                 ENDIF
1312:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1313:                     THIS.obj_4c_Get_Verso.Value = loc_oBO.this_cVersos
1314:                     THIS.peantvalue = loc_oBO.this_cVersos
1315:                 ENDIF
1316:             ENDIF
1317:         CATCH TO loc_oErro
1318:             MsgErro(loc_oErro.Message, "Erro")
1319:         ENDTRY
1320:     ENDPROC
1321: 
1322:     *==========================================================================
1323:     * VersoLostFocus - Salva verso se o conteudo foi alterado
1324:     *==========================================================================
1325:     PROCEDURE VersoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1326:         LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
1327:         TRY
1328:             loc_oBO = THIS.this_oBusinessObject
1329:             IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1330:                 loc_cVersoAtual = THIS.obj_4c_Get_Verso.Value
1331:                 IF !(ALLTRIM(loc_cVersoAtual) == ALLTRIM(THIS.peantvalue))
1332:                     loc_oBO.AtualizarVerso(loc_oBO.this_cCidChaves, loc_cVersoAtual)
1333:                     THIS.peantvalue = loc_cVersoAtual
1334:                 ENDIF
1335:             ENDIF
1336:         CATCH TO loc_oErro
1337:             MsgErro(loc_oErro.Message, "Erro")
1338:         ENDTRY
1339:     ENDPROC
1340: 
1341:     *==========================================================================
1342:     * FavorecidoLostFocus - Sincroniza BO com valor editado do campo favorecido
1343:     *==========================================================================
1344:     PROCEDURE FavorecidoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1345:         LOCAL loc_oBO, loc_oErro
1346:         TRY
1347:             loc_oBO = THIS.this_oBusinessObject
1348:             IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.txt_4c_Favorecido) = "O"
1349:                 loc_oBO.this_cFavos = ALLTRIM(THIS.txt_4c_Favorecido.Value)
1350:             ENDIF
1351:         CATCH TO loc_oErro
1352:             MsgErro(loc_oErro.Message, "Erro")
1353:         ENDTRY
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     * FormParaBO - Popula BO com dados editaveis do formulario
1358:     * Campos editaveis: favorecido e verso (restantes sao somente leitura)
1359:     *==========================================================================
1360:     PROCEDURE FormParaBO()
1361:         LOCAL loc_oBO, loc_oErro
1362:         TRY
1363:             loc_oBO = THIS.this_oBusinessObject
1364:             IF VARTYPE(loc_oBO) = "O"
1365:                 IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1366:                     loc_oBO.this_cFavos = ALLTRIM(THIS.txt_4c_Favorecido.Value)
1367:                 ENDIF
1368:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1369:                     loc_oBO.this_cVersos = THIS.obj_4c_Get_Verso.Value
1370:                 ENDIF
1371:             ENDIF
1372:         CATCH TO loc_oErro
1373:             MsgErro(loc_oErro.Message, "Erro")
1374:         ENDTRY
1375:     ENDPROC
1376: 
1377:     *==========================================================================
1378:     * HabilitarCampos - Controla editabilidade dos campos conforme modo
1379:     * par_cModo: "INSERIR", "ALTERAR" (editavel) ou outro (somente leitura)
1380:     *==========================================================================
1381:     PROTECTED PROCEDURE HabilitarCampos(par_cModo)
1382:         LOCAL loc_lEditavel, loc_lVersoEditavel, loc_oBO, loc_oErro
1383:         TRY
1384:             loc_oBO       = THIS.this_oBusinessObject
1385:             loc_lEditavel = INLIST(par_cModo, "INSERIR", "ALTERAR")
1386: 
1387:             IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1388:                 THIS.txt_4c_Favorecido.ReadOnly  = !loc_lEditavel
1389:                 THIS.txt_4c_Favorecido.BackColor = IIF(loc_lEditavel, RGB(255,255,255), RGB(240,240,240))
1390:             ENDIF
1391: 
1392:             IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1393:                 loc_lVersoEditavel = loc_lEditavel AND ;
1394:                                      VARTYPE(loc_oBO) = "O" AND ;
1395:                                      loc_oBO.this_nImpVersos = 0
1396:                 THIS.obj_4c_Get_Verso.ReadOnly  = !loc_lVersoEditavel
1397:                 THIS.obj_4c_Get_Verso.BackColor = IIF(loc_lVersoEditavel, RGB(255,255,255), RGB(240,240,240))
1398:             ENDIF
1399:         CATCH TO loc_oErro
1400:             MsgErro(loc_oErro.Message, "Erro")
1401:         ENDTRY
1402:     ENDPROC
1403: 
1404:     *==========================================================================
1405:     * LimparCampos - Reseta campos editaveis e estado de comparacao do verso
1406:     *==========================================================================
1407:     PROTECTED PROCEDURE LimparCampos()
1408:         IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1409:             THIS.txt_4c_Favorecido.Value = ""
1410:         ENDIF
1411:         IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
1412:             THIS.obj_4c_Get_Verso.Value = ""
1413:         ENDIF
1414:         THIS.peantvalue = ""
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * CarregarLista - Recarrega dados do cheque do banco de dados e atualiza UI
1419:     *==========================================================================
1420:     PROCEDURE CarregarLista()
1421:         LOCAL loc_oErro
1422:         TRY
1423:             THIS.CarregarDadosCheque()
1424:             THIS.BOParaForm()
1425:             THIS.AjustarBotoesPorModo()
1426:         CATCH TO loc_oErro
1427:             MsgErro(loc_oErro.Message, "Erro")
1428:         ENDTRY
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * AjustarBotoesPorModo - Centraliza ajuste de estado dos botoes e controles
1433:     * Baseado em: lEmitidos, nImpVersos e op_escolha atual
1434:     *==========================================================================
1435:     PROCEDURE AjustarBotoesPorModo()
1436:         LOCAL loc_oBO, loc_oErro
1437:         TRY
1438:             loc_oBO = THIS.this_oBusinessObject
1439:             IF VARTYPE(loc_oBO) = "O"
1440:                 IF VARTYPE(THIS.opt_4c_Imprime) = "O"
1441:                     THIS.opt_4c_Imprime.Buttons(2).Enabled = loc_oBO.this_lEmitidos
1442:                     THIS.opt_4c_Imprime.Buttons(3).Enabled = loc_oBO.this_lEmitidos
1443:                 ENDIF
1444:                 IF VARTYPE(THIS.cmd_4c_Visualizar) = "O"
1445:                     THIS.cmd_4c_Visualizar.Enabled = VARTYPE(THIS.opt_4c_Imprime) = "O" AND ;
1446:                                                      INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
1447:                 ENDIF
1448:                 IF VARTYPE(THIS.lbl_4c_LbNimp) = "O"
1449:                     THIS.lbl_4c_LbNimp.Visible = (loc_oBO.this_nImpVersos = 0)
1450:                 ENDIF
1451:                 THIS.HabilitarCampos(THIS.op_escolha)
1452:             ENDIF
1453:         CATCH TO loc_oErro
1454:             MsgErro(loc_oErro.Message, "Erro")
1455:         ENDTRY
1456:     ENDPROC
1457: 
1458:     *==========================================================================
1459:     * BtnBuscarClick - Recarrega dados do cheque a partir do banco
1460:     * Util para refletir mudancas externas no registro (ex: marca de emissao
1461:     * alterada em outra sessao) sem precisar fechar e reabrir o form.
1462:     *==========================================================================
1463:     PROCEDURE BtnBuscarClick()
1464:         LOCAL loc_oErro
1465:         TRY
1466:             THIS.CarregarLista()
1467:             THIS.InicializarEstadoBotoes()
1468:             MsgInfo("Dados do cheque atualizados.", "Buscar")
1469:         CATCH TO loc_oErro
1470:             MsgErro("Erro ao recarregar dados:" + CHR(13) + loc_oErro.Message, "Erro")
1471:         ENDTRY
1472:     ENDPROC
1473: 
1474:     *==========================================================================
1475:     * BtnSalvarClick - Grava favorecido e verso no banco (SigCqChi)
1476:     * Sincroniza form->BO e executa UPDATE via SalvarStatusSaida + AtualizarVerso.
1477:     *==========================================================================
1478:     PROCEDURE BtnSalvarClick()
1479:         LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
1480:         TRY
1481:             loc_oBO = THIS.this_oBusinessObject
1482:             IF VARTYPE(loc_oBO) != "O"
1483:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
1484:             ELSE
1485:                 IF !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
1486:                     MsgAviso("Cheque em modo somente leitura. " + ;
1487:                              "Acione Alterar antes de salvar.", "Aviso")
1488:                 ELSE
1489:                     *-- Form -> BO (favorecido e verso)
1490:                     THIS.FormParaBO()
1491: 
1492:                     *-- Persiste favorecido + status atual
1493:                     loc_oBO.SalvarStatusSaida(loc_oBO.this_cCidChaves, ;
1494:                                               loc_oBO.this_cFavos, ;
1495:                                               loc_oBO.this_nNEmissoes)
1496: 
1497:                     *-- Persiste verso somente se houve mudanca real
1498:                     loc_cVersoAtual = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
1499:                                           THIS.obj_4c_Get_Verso.Value, ;
1500:                                           loc_oBO.this_cVersos)
1501:                     IF !(ALLTRIM(loc_cVersoAtual) == ALLTRIM(THIS.peantvalue))
1502:                         loc_oBO.AtualizarVerso(loc_oBO.this_cCidChaves, loc_cVersoAtual)
1503:                         THIS.peantvalue = loc_cVersoAtual
1504:                     ENDIF
1505: 
1506:                     MsgInfo("Altera" + CHR(231) + CHR(245) + "es salvas com sucesso.", "Salvo")
1507:                 ENDIF
1508:             ENDIF
1509:         CATCH TO loc_oErro
1510:             MsgErro("Erro ao salvar altera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1511:                     loc_oErro.Message, "Erro")
1512:         ENDTRY
1513:     ENDPROC
1514: 
1515:     *==========================================================================
1516:     * BtnCancelarClick - Reverte favorecido e verso para o ultimo estado gravado
1517:     * Recarrega dados do banco sem fechar o form; exige confirmacao do usuario.
1518:     *==========================================================================
1519:     PROCEDURE BtnCancelarClick()
1520:         LOCAL loc_oBO, loc_lConfirma, loc_oErro
1521:         TRY
1522:             loc_oBO = THIS.this_oBusinessObject
1523:             IF VARTYPE(loc_oBO) != "O"
1524:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
1525:             ELSE
1526:                 loc_lConfirma = MsgConfirma("Descartar altera" + CHR(231) + CHR(245) + ;
1527:                                             "es n" + CHR(227) + "o salvas e recarregar dados?")
1528:                 IF loc_lConfirma
1529:                     *-- Recarrega do banco e reflete no form, mantendo o modo atual
1530:                     THIS.CarregarDadosCheque()
1531:                     THIS.BOParaForm()
1532:                     THIS.AjustarBotoesPorModo()
1533:                 ENDIF
1534:             ENDIF
1535:         CATCH TO loc_oErro
1536:             MsgErro("Erro ao cancelar altera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1537:                     loc_oErro.Message, "Erro")
1538:         ENDTRY
1539:     ENDPROC
1540: 
1541:     *==========================================================================
1542:     * Destroy - Libera cursores temporarios e chama DODEFAULT
1543:     *==========================================================================
1544:     PROCEDURE Destroy()
1545:         IF USED("cursor_4c_ChiDados")
1546:             USE IN cursor_4c_ChiDados
1547:         ENDIF
1548:         IF USED("cursor_4c_Par")
1549:             USE IN cursor_4c_Par
1550:         ENDIF
1551:         IF USED("cursor_4c_Emp")
1552:             USE IN cursor_4c_Emp
1553:         ENDIF
1554:         DODEFAULT()
1555:     ENDPROC
1556: 
1557: ENDDEFINE


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

