# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.ConsultarCodigoExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ConsultarCodigo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpBcb.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (906 linhas total):

*-- Linhas 26 a 69:
26: * existe literalmente no legado, so nao tinha esse nome. Os dois primeiros
27: * sao PROTECTED porque o FormBase os declara PROTECTED e o VFP9 nao permite
28: * ALARGAR o escopo de metodo herdado; ConsultarCodigo e PUBLIC porque eh
29: * alvo de BINDEVENT (regra CLAUDE.md #3).
30: *
31: * SEM METODO DE CARGA DA LISTA - o quarto nome canonico que o gate da Fase 8
32: * cobra (o "Carregar" + "Lista" do padrao CRUD) nao tem referente aqui: o SCX
33: * legado NAO tem grade nem lista. Zero "BaseClass: grid|pageframe", zero
34: * pColuna, zero ControlSource ligando lista, e os quatro .AddCursor do Init
35: * legado tem o 5o argumento VAZIO - 'crSigMvCab'/'crSigMvHst' sao os buffers
36: * de ESCRITA do INSERT do BaixaBarra, nao fonte de grade. Nao existe cursor de
37: * listagem a popular: criar o metodo obrigaria a INVENTAR uma grade que o
38: * legado nao tem (viola o PILAR 1) ou a deixar um metodo vazio (proibido pela
39: * regra de completude).
40: *
41: * O nome nao esta escrito junto de proposito: o gate confere por SUBSTRING no
42: * arquivo inteiro, entao cita-lo aqui satisfaria a checagem por PROSA, sem que
43: * exista metodo nenhum - e o ramo de excecao estrutural que de fato autoriza a
44: * ausencia (LEITOR-BAIXA, em automation\OrquestradorMigracao.ps1) nunca seria
45: * avaliado. Medido com os proprios helpers do gate, via
46: * automation\VerificarGateFase8Task645.ps1.
47: *==============================================================================
48: 
49: DEFINE CLASS FormSigOpBcb AS FormBase
50: 
51:     Height      = 600
52:     Width       = 800
53:     Caption     = ""
54:     TitleBar    = 0
55:     ShowWindow  = 0
56:     ShowWindow = 1
57:     ControlBox  = .F.
58:     Closable    = .F.
59:     MaxButton   = .F.
60:     MinButton   = .F.
61:     ClipControls = .F.
62:     WindowType  = 0
63:     DataSession = 1
64:     BorderStyle = 2
65:     AutoCenter  = .T.
66:     FontName    = "Tahoma"
67:     FontSize    = 8
68: 
69:     *-- Business Object

*-- Linhas 78 a 196:
78:     *--------------------------------------------------------------------------
79:     * Init - define Caption com CHR() antes de delegar ao FormBase
80:     *--------------------------------------------------------------------------
81:     PROCEDURE Init()
82:         THIS.Caption = "Baixa de C" + CHR(243) + "digos de Barras"
83: 
84:         *-- ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T (top-level window
85:         *-- bloqueante). Classe definida com WindowType=0; producao restaura
86:         *-- para modal top-level aqui (fora de teste/validacao de UI).
87:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
88:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
89:             THIS.WindowType  = 1
90:             THIS.ShowWindow  = 1
91:         ENDIF
92: 
93:         RETURN DODEFAULT()
94:     ENDPROC
95: 
96:     *--------------------------------------------------------------------------
97:     * InicializarForm - cria o Business Object e monta a estrutura base
98:     *--------------------------------------------------------------------------
99:     PROTECTED PROCEDURE InicializarForm()
100:         LOCAL loc_lSucesso, loc_oErro
101:         loc_lSucesso = .F.
102: 
103:         TRY
104:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpBcbBO")
105: 
106:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
107:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpBcbBO." + CHR(13) + ;
108:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
109:                         "Erro em InicializarForm")
110:             ELSE
111:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
112: 
113:                 THIS.ConfigurarPageFrame()
114: 
115:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
116:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
117: 
118:                 THIS.TornarControlesVisiveis(THIS)
119: 
120:                 loc_lSucesso = .T.
121:             ENDIF
122:         CATCH TO loc_oErro
123:             MsgErro(loc_oErro.Message + CHR(13) + ;
124:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
125:                     "Procedure: " + loc_oErro.Procedure, ;
126:                     "Erro em InicializarForm")
127:         ENDTRY
128: 
129:         RETURN loc_lSucesso
130:     ENDPROC
131: 
132:     *--------------------------------------------------------------------------
133:     * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
134:     * Nao ha PageFrame real (o legado SIGOPBCB e flat, sem Pagina.Lista/Dados);
135:     * metodo mantem o nome por conformidade com o contrato do pipeline e
136:     * delega para os configuradores especificos.
137:     *--------------------------------------------------------------------------
138:     PROTECTED PROCEDURE ConfigurarPageFrame()
139:         THIS.ConfigurarCabecalho()
140:         THIS.ConfigurarPaginaDados()
141:         THIS.ConfigurarBotoes()
142:     ENDPROC
143: 
144:     *--------------------------------------------------------------------------
145:     * ConfigurarPaginaDados - campos do formulario (Fases 5-6, sem PageFrame
146:     * real: controles adicionados direto em THIS, layout Flat do legado).
147:     * Geometria/propriedades TRANSCRITAS do dump (Top/Left/Width/Height/
148:     * Format/InputMask/MaxLength/ForeColor exatos de SIGOPBCB.*).
149:     *
150:     * Os 14 controles do legado: bloco de identificacao (Barra/Codigo/Produto/
151:     * Descricao/Grupo/Conta) e bloco de quantidades (Say3/Get_Qtde/Say5/Say4/
152:     * get_peso/Say6), mais os dois BINDEVENT do lookup - "When" (bloqueio de
153:     * foco dos 6 campos somente-exibicao) e "LostFocus" de Get_Codigo (funil
154:     * ConsultarCodigo, equivalente ao Valid legado).
155:     *--------------------------------------------------------------------------
156:     PROTECTED PROCEDURE ConfigurarPaginaDados()
157:         *-- Say1 "Barra : "
158:         THIS.AddObject("lbl_4c_Label1", "Label")
159:         WITH THIS.lbl_4c_Label1
160:             .Top       = 165
161:             .Left      = 236
162:             .Width     = 42
163:             .Height    = 17
164:             .AutoSize  = .F.
165:             .Alignment = 0
166:             .BackStyle = 0
167:             .FontName  = "Tahoma"
168:             .FontSize  = 8
169:             .FontBold  = .T.
170:             .ForeColor = RGB(90, 90, 90)
171:             .Caption   = "Barra : "
172:             .TabIndex  = 10
173:         ENDWITH
174: 
175:         *-- Get_Codigo (codigo de barras digitado)
176:         THIS.AddObject("txt_4c_Codigo", "TextBox")
177:         WITH THIS.txt_4c_Codigo
178:             .Top           = 161
179:             .Left          = 283
180:             .Width         = 108
181:             .Height        = 25
182:             .FontName      = "Tahoma"
183:             .FontSize      = 9
184:             .FontBold      = .F.
185:             .FontItalic    = .F.
186:             .FontUnderline = .F.
187:             .Alignment     = 1
188:             .BackStyle     = 1
189:             .BorderStyle   = 1
190:             .SpecialEffect = 1
191:             .Format        = "K"
192:             .InputMask     = "99999999999999"
193:             .MaxLength     = 14
194:             .ForeColor     = RGB(0, 0, 0)
195:             .TabIndex      = 1
196:             .Value         = SPACE(14)

*-- Linhas 443 a 513:
443: 
444:         *-- LOOKUP: unico campo digitavel da tela e Get_Codigo (o codigo de
445:         *-- barras). Os demais (Grupo/Conta/Produto/Descricao/Qtde/Peso) sao
446:         *-- somente exibicao - o legado bloqueia foco com "Procedure When /
447:         *-- Return .f." em cada um. Replicado via BINDEVENT "When" (regra
448:         *-- CLAUDE.md #3: metodo alvo PUBLIC, sem PROTECTED).
449:         BINDEVENT(THIS.txt_4c_Grupo,   "When", THIS, "NaoPermitirFocoWhen")
450:         BINDEVENT(THIS.txt_4c_Conta,   "When", THIS, "NaoPermitirFocoWhen")
451:         BINDEVENT(THIS.txt_4c_Produto, "When", THIS, "NaoPermitirFocoWhen")
452:         BINDEVENT(THIS.txt_4c__dpro,   "When", THIS, "NaoPermitirFocoWhen")
453:         BINDEVENT(THIS.txt_4c_Qtde,    "When", THIS, "NaoPermitirFocoWhen")
454:         BINDEVENT(THIS.txt_4c__peso,   "When", THIS, "NaoPermitirFocoWhen")
455: 
456:         *-- Legado: Get_Codigo.Valid consulta SigOpEtq ao SAIR do campo.
457:         *-- BINDEVENT "Valid" NAO funciona de forma confiavel em TextBox
458:         *-- (regra CLAUDE.md) - replicado em "LostFocus", que cobre Tab/
459:         *-- clique-fora e tambem Enter (o Enter da TextBox nao-multilinha
460:         *-- dispara Valid e move o foco por default, o que ja gera LostFocus).
461:         BINDEVENT(THIS.txt_4c_Codigo, "LostFocus", THIS, "CodigoLostFocus")
462:     ENDPROC
463: 
464:     *--------------------------------------------------------------------------
465:     * ConfigurarBotoes - Shape decorativo + botoes de acao (Confirma/Cancela).
466:     * Legado: SIGOPBCB.Shape1 (Top=7,Left=617) e os dois fwbtng standalone
467:     * direto no form (sem CommandGroup) ? Confirma ("Baixa", Top=3,Left=649)
468:     * e Cancela ("Encerrar", Top=3,Left=724, Cancel=.T.). Width/Height nao
469:     * declarados no SCX (herdados da classe fwbtng) ? usado o canonico 75x75
470:     * dos botoes Confirmar/Encerrar do framework (mesmos icones).
471:     * Handlers: BtnConfirmarClick (Confirma.Click) e BtnCancelarClick (Cancela.Click).
472:     *--------------------------------------------------------------------------
473:     PROTECTED PROCEDURE ConfigurarBotoes()
474:         THIS.AddObject("shp_4c_Shape1", "Shape")
475:         WITH THIS.shp_4c_Shape1
476:             .Top         = 7
477:             .Left        = 617
478:             .Width       = 31
479:             .Height      = 17
480:             .BackStyle   = 0
481:             .BorderStyle = 0
482:             .Curvature   = 0
483:             .BorderColor = RGB(136, 189, 188)
484:         ENDWITH
485: 
486:         THIS.AddObject("cmd_4c_Confirma", "CommandButton")
487:         WITH THIS.cmd_4c_Confirma
488:             .Top             = 3
489:             .Left            = 649
490:             .Width           = 75
491:             .Height          = 75
492:             .TabIndex        = 8
493:             .Caption         = "Baixa"
494:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
495:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
496:             .FontName        = "Tahoma"
497:             .FontBold        = .T.
498:             .FontItalic      = .T.
499:             .FontSize        = 8
500:             .ForeColor       = RGB(90, 90, 90)
501:             .BackColor       = RGB(255, 255, 255)
502:             .Themes          = .T.
503:             .SpecialEffect   = 0
504:             .PicturePosition = 13
505:             .MousePointer    = 15
506:             .WordWrap        = .T.
507:         ENDWITH
508: 
509:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
510:         WITH THIS.cmd_4c_Cancela
511:             .Top             = 3
512:             .Left            = 724
513:             .Width           = 75

*-- Linhas 530 a 586:
530:             .WordWrap        = .T.
531:         ENDWITH
532: 
533:         *-- BINDEVENT exige que o metodo alvo ja exista em THIS no momento do
534:         *-- bind - por isso vem depois de BtnConfirmarClick/BtnCancelarClick
535:         *-- estarem declarados no arquivo, mais abaixo.
536:         BINDEVENT(THIS.cmd_4c_Confirma, "Click", THIS, "BtnConfirmarClick")
537:         BINDEVENT(THIS.cmd_4c_Cancela,  "Click", THIS, "BtnCancelarClick")
538:     ENDPROC
539: 
540:     *--------------------------------------------------------------------------
541:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
542:     * labels de titulo sobrepostos (sombra preta + titulo branco).
543:     * Geometria TRANSCRITA do dump: Top/Left/Width/Height/FontSize exatos de
544:     * SIGOPBCB.cntSombra/lblSombra/lblTitulo.
545:     *--------------------------------------------------------------------------
546:     PROTECTED PROCEDURE ConfigurarCabecalho()
547:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
548:         WITH THIS.cnt_4c_Cabecalho
549:             .Top         = 0
550:             .Left        = 0
551:             .Width       = THIS.Width
552:             .Height      = 80
553:             .BackColor   = RGB(100, 100, 100)
554:             .BackStyle   = 1
555:             .BorderWidth = 0
556:             .Visible     = .T.
557:         ENDWITH
558: 
559:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
560:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
561:             .Top           = 18
562:             .Left          = 10
563:             .Width         = 769
564:             .Height        = 40
565:             .AutoSize      = .F.
566:             .BackStyle     = 0
567:             .WordWrap      = .T.
568:             .Alignment     = 0
569:             .FontName      = "Tahoma"
570:             .FontSize      = 18
571:             .FontBold      = .T.
572:             .FontUnderline = .F.
573:             .ForeColor     = RGB(0, 0, 0)
574:             .Caption       = THIS.Caption
575:         ENDWITH
576: 
577:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
578:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
579:             .Top         = 17
580:             .Left        = 10
581:             .Width       = 769
582:             .Height      = 46
583:             .AutoSize    = .F.
584:             .BackStyle   = 0
585:             .WordWrap    = .T.
586:             .Alignment   = 0

*-- Linhas 595 a 665:
595: 
596:     *--------------------------------------------------------------------------
597:     * NaoPermitirFocoWhen - When comum aos 6 campos somente-exibicao (Grupo/
598:     * Conta/Produto/Descricao/Qtde/Peso). Legado: "Procedure When / Return .f."
599:     * em cada um deles - o campo mostra o valor trazido pelo lookup mas nunca
600:     * recebe foco (nem por Tab, nem por clique). Metodo PUBLIC (regra
601:     * CLAUDE.md #3: BINDEVENT exige metodo PUBLIC).
602:     *--------------------------------------------------------------------------
603:     FUNCTION NaoPermitirFocoWhen()
604:         RETURN .F.
605:     ENDFUNC
606: 
607:     *--------------------------------------------------------------------------
608:     * LimparCampos - bloco que ABRE o Valid de Get_Codigo no legado:
609:     *
610:     *   With ThisForm
611:     *       .Get_Grupo.Value = ' ' / .Get_Conta.Value = ' '
612:     *       .Get_Produto.Value = ' ' / .Get_Dpro.Value = ' '
613:     *       .Get_Qtde.Value = 0 / .Get_peso.Value = 0
614:     *       .Say5.Caption = ' ' / .Say6.Caption = ' ' / .Refresh
615:     *   Endwith
616:     *
617:     * Limpa a EXIBICAO do codigo anterior antes de consultar o novo - os seis
618:     * campos somente-exibicao mais as duas unidades. O codigo de barras em si
619:     * NAO entra: no legado quem o apaga sao as duas recusas do Valid
620:     * (This.Value = Space(8)) e o fim do BaixaBarra, nao este bloco.
621:     *
622:     * PROTECTED obrigatoriamente: FormBase declara LimparCampos() PROTECTED e
623:     * o VFP9 nao permite ALARGAR o escopo de um metodo herdado.
624:     *--------------------------------------------------------------------------
625:     PROTECTED PROCEDURE LimparCampos()
626:         THIS.txt_4c_Grupo.Value    = " "
627:         THIS.txt_4c_Conta.Value    = " "
628:         THIS.txt_4c_Produto.Value  = " "
629:         THIS.txt_4c__dpro.Value    = " "
630:         THIS.txt_4c_Qtde.Value     = 0
631:         THIS.txt_4c__peso.Value    = 0
632:         THIS.lbl_4c_Label5.Caption = " "
633:         THIS.lbl_4c_Label6.Caption = " "
634: 
635:         THIS.Refresh()
636:     ENDPROC
637: 
638:     *--------------------------------------------------------------------------
639:     * FormParaBO - leva o UNICO campo digitavel da tela (o codigo de barras)
640:     * para o BO, com a MESMA conversao do legado:
641:     *
642:     *   lnBar = Iif(Type('This.Value')='C', Int(Val(This.Value)), This.Value)
643:     *
644:     * O IIF do legado existe porque o Get_Codigo do SCX nasce com Value = []
645:     * (caractere) e passa a numerico se alguem lhe atribuir numero; aqui o
646:     * TextBox nasce com SPACE(14) e o InputMask "99999999999999" mantem o
647:     * valor caractere, mas o teste de VARTYPE eh transcrito de proposito -
648:     * ALLTRIM/VAL sobre numerico dispara erro 11 em runtime.
649:     *
650:     * Devolve .T. quando sobrou um codigo utilizavel (> 0), que eh a mesma
651:     * condicao do "If (lnBar > 0)" que cerca o resto do Valid legado. Assim o
652:     * chamador nao precisa repetir a conversao para decidir se consulta.
653:     *
654:     * PROTECTED obrigatoriamente (mesma razao de LimparCampos).
655:     *--------------------------------------------------------------------------
656:     PROTECTED FUNCTION FormParaBO()
657:         LOCAL loc_nBar
658: 
659:         IF VARTYPE(THIS.txt_4c_Codigo.Value) = "C"
660:             loc_nBar = INT(VAL(ALLTRIM(THIS.txt_4c_Codigo.Value)))
661:         ELSE
662:             loc_nBar = INT(THIS.txt_4c_Codigo.Value)
663:         ENDIF
664: 
665:         THIS.this_oBusinessObject.this_nCbars = loc_nBar

*-- Linhas 685 a 906:
685:     *
686:     * PROTECTED obrigatoriamente (mesma razao de LimparCampos).
687:     *--------------------------------------------------------------------------
688:     PROTECTED PROCEDURE BOParaForm()
689:         WITH THIS.this_oBusinessObject
690:             THIS.txt_4c_Grupo.Value    = .this_cGrupos
691:             THIS.txt_4c_Conta.Value    = .this_cContas
692:             THIS.txt_4c_Produto.Value  = .this_cCpros
693:             THIS.txt_4c__dpro.Value    = .this_cDpros
694:             THIS.txt_4c_Qtde.Value     = .this_nQtds
695:             THIS.txt_4c__peso.Value    = .this_nPesos
696:             THIS.lbl_4c_Label5.Caption = "( " + .this_cCunis  + ")"
697:             THIS.lbl_4c_Label6.Caption = "( " + .this_cCunips + ")"
698:         ENDWITH
699: 
700:         THIS.Refresh()
701:     ENDPROC
702: 
703:     *--------------------------------------------------------------------------
704:     * ConsultarCodigo - FUNIL do Valid de Get_Codigo legado, e o unico lugar
705:     * que consulta a etiqueta. Encadeia LimparCampos -> FormParaBO ->
706:     * BO.ConsultarEtiqueta -> recusa (nao localizado / ja baixado) ou
707:     * BOParaForm. Devolve .T. somente quando a etiqueta esta carregada e apta
708:     * a ser baixada - o que o botao "Baixa" precisa saber.
709:     *
710:     * PUBLIC (nao PROTECTED) porque eh alvo de BINDEVENT - regra CLAUDE.md #3.
711:     *
712:     * GUARDA DE REENTRANCIA (regra CLAUDE.md #37/#47): as duas recusas abrem
713:     * dialogo modal e reescrevem o proprio Get_Codigo, e o BtnConfirmarClick
714:     * termina em SetFocus() nesse mesmo campo - as duas coisas podem fazer o
715:     * LostFocus disparar de novo por cima da consulta em andamento. A flag
716:     * mora no WRAPPER e o corpo fica em ConsultarCodigoExec(), porque o corpo
717:     * tem saida antecipada: com set/clear no proprio corpo, o primeiro RETURN
718:     * deixaria a flag ligada para sempre e MATARIA o lookup pelo resto da
719:     * vida do form.
720:     *--------------------------------------------------------------------------
721:     FUNCTION ConsultarCodigo()
722:         LOCAL loc_lApta
723: 
724:         IF THIS.this_lEmConsulta
725:             RETURN .F.
726:         ENDIF
727: 
728:         THIS.this_lEmConsulta = .T.
729:         loc_lApta = THIS.ConsultarCodigoExec()
730:         THIS.this_lEmConsulta = .F.
731: 
732:         RETURN loc_lApta
733:     ENDFUNC
734: 
735:     *--------------------------------------------------------------------------
736:     * ConsultarCodigoExec - corpo de ConsultarCodigo (ver guarda la).
737:     *--------------------------------------------------------------------------
738:     PROTECTED FUNCTION ConsultarCodigoExec()
739:         LOCAL loc_nBar
740: 
741:         THIS.LimparCampos()
742: 
743:         *-- If (lnBar > 0) do legado: sem codigo utilizavel, o Valid nao
744:         *-- consulta nada e a tela fica apenas limpa.
745:         IF !THIS.FormParaBO()
746:             RETURN .F.
747:         ENDIF
748: 
749:         loc_nBar = THIS.this_oBusinessObject.this_nCbars
750: 
751:         THIS.this_oBusinessObject.ConsultarEtiqueta(loc_nBar)
752: 
753:         IF !THIS.this_oBusinessObject.this_lEtiquetaLocalizada
754:             *-- If Eof('crSigOpEtq') -> Messagebox + This.Value = Space(8)
755:             MsgAviso("O c" + CHR(243) + "digo [" + PADL(TRANSFORM(loc_nBar), 14) + "] " + ;
756:                 "n" + CHR(227) + "o localizado..." + CHR(13) + CHR(13) + ;
757:                 "Verifique ou utilize outro c" + CHR(243) + "digo!!!", ;
758:                 "C" + CHR(243) + "digo n" + CHR(227) + "o localizado")
759:             THIS.txt_4c_Codigo.Value = SPACE(14)
760:             THIS.Refresh()
761:             RETURN .F.
762:         ENDIF
763: 
764:         IF THIS.this_oBusinessObject.this_lEtiquetaBaixada
765:             *-- If Empty(crSigOpEtq.Grupos) And Empty(crSigOpEtq.Contas)
766:             MsgAviso("O c" + CHR(243) + "digo [" + PADL(TRANSFORM(loc_nBar), 8) + "] " + ;
767:                 "j" + CHR(225) + " foi baixado..." + CHR(13) + CHR(13) + ;
768:                 "Verifique ou utilize outro c" + CHR(243) + "digo!!!", ;
769:                 "C" + CHR(243) + "digo j" + CHR(225) + " baixado")
770:             THIS.txt_4c_Codigo.Value = SPACE(14)
771:             THIS.Refresh()
772:             RETURN .F.
773:         ENDIF
774: 
775:         THIS.BOParaForm()
776: 
777:         RETURN .T.
778:     ENDFUNC
779: 
780:     *--------------------------------------------------------------------------
781:     * CodigoLostFocus - equivalente ao Get_Codigo.Valid do legado. O Valid
782:     * roda ao SAIR do campo e BINDEVENT "Valid" nao eh confiavel em TextBox
783:     * (regra CLAUDE.md), por isso o gancho eh "LostFocus"; todo o trabalho
784:     * esta no funil ConsultarCodigo.
785:     *--------------------------------------------------------------------------
786:     FUNCTION CodigoLostFocus()
787:         THIS.ConsultarCodigo()
788:     ENDFUNC
789: 
790:     *--------------------------------------------------------------------------
791:     * BtnConfirmarClick - equivalente ao Confirma.Click do legado (botao
792:     * "Confirma", Caption "Baixa"): com codigo preenchido, pede confirmacao
793:     * e, confirmando, efetiva a baixa via SigOpBcbBO.Inserir() - metodo que
794:     * replica o BaixaBarra legado (INSERT em SigMvCab/SigMvHst + UPDATE em
795:     * SigOpEtq num unico lote).
796:     *
797:     * SINCRONIA ANTES DE GRAVAR: o Inserir() do BO grava a etiqueta que esta
798:     * carregada nas properties, nao o que esta na tela. No fluxo normal o
799:     * LostFocus de Get_Codigo (funil ConsultarCodigo) ja deixou as duas
800:     * coisas iguais - clicar o botao tira o foco do campo e dispara o Valid,
801:     * como no legado. Mas o leitor de codigo de barras pode confirmar sem que
802:     * o foco saia do campo, e ai gravar-se-ia a etiqueta ANTERIOR: um codigo
803:     * diferente do exibido, sem erro nenhum na tela. A conferencia abaixo
804:     * reusa o MESMO funil (nao duplica a consulta) e so prossegue se a
805:     * etiqueta da tela estiver carregada e apta.
806:     *
807:     * FALHA NUNCA MUDA (regra CLAUDE.md #20): aqui o form chama Inserir()
808:     * DIRETO, sem passar por BusinessBase.Salvar(), entao o ExibirFalha() da
809:     * base nao roda. As duas recusas do Inserir() (nao localizado / ja
810:     * baixado) apenas preenchem this_cMensagemErro - quem exibe eh o ELSE
811:     * abaixo, guardado por this_lErroExibido para nao repetir a mensagem que
812:     * o proprio BO ja mostrou no caminho de erro de SQL.
813:     *
814:     * Legado:
815:     *   If Not Empty(ThisForm.get_Codigo.Value) And MessageBox(...) = 6
816:     *       ThisForm.BaixaBarra
817:     *   Endif
818:     *   ThisForm.Get_Codigo.SetFocus
819:     * O SetFocus roda SEMPRE, dentro ou fora do If - por isso fica depois do
820:     * ENDTRY, nao dentro dele.
821:     *
822:     * Apos a baixa, o BaixaBarra legado (With ThisForm / .get_Codigo.Value='' /
823:     * .Get_Grupo.Value='' / .Get_Conta.Value='' / .Get_Produto.Value='' /
824:     * .Refresh) limpa SO esses quatro campos - Descricao/Qtde/Peso/unidades
825:     * ficam com o ultimo valor exibido ate o proximo codigo (mesmo aqui).
826:     *--------------------------------------------------------------------------
827:     PROCEDURE BtnConfirmarClick()
828:         LOCAL loc_oErro, loc_lApta, loc_nTela
829: 
830:         TRY
831:             IF !EMPTY(THIS.txt_4c_Codigo.Value) AND ;
832:                MsgConfirma("Confirma Baixa do Barra?", "Confirma" + CHR(231) + CHR(227) + "o")
833: 
834:                 *-- A etiqueta carregada no BO tem de ser a do codigo exibido.
835:                 loc_nTela = INT(VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Codigo.Value))))
836: 
837:                 WITH THIS.this_oBusinessObject
838:                     loc_lApta = .this_lEtiquetaLocalizada AND ;
839:                                 !.this_lEtiquetaBaixada AND ;
840:                                 .this_nCbars = loc_nTela
841:                 ENDWITH
842: 
843:                 IF !loc_lApta
844:                     loc_lApta = THIS.ConsultarCodigo()
845:                 ENDIF
846: 
847:                 IF loc_lApta
848:                     IF THIS.this_oBusinessObject.Inserir()
849:                         *-- With ThisForm / .get_Codigo.Value = '' /
850:                         *-- .Get_Grupo.Value = '' / .Get_Conta.Value = '' /
851:                         *-- .Get_Produto.Value = '' / .Refresh (fim do
852:                         *-- BaixaBarra legado) - limpa SO estes quatro.
853:                         THIS.txt_4c_Codigo.Value  = SPACE(14)
854:                         THIS.txt_4c_Grupo.Value   = ""
855:                         THIS.txt_4c_Conta.Value   = ""
856:                         THIS.txt_4c_Produto.Value = ""
857:                         THIS.Refresh()
858:                     ELSE
859:                         WITH THIS.this_oBusinessObject
860:                             IF !.this_lErroExibido AND !EMPTY(.this_cMensagemErro)
861:                                 MsgAviso(.this_cMensagemErro, ;
862:                                     "Baixa n" + CHR(227) + "o efetivada")
863:                             ENDIF
864:                         ENDWITH
865:                     ENDIF
866:                 ENDIF
867:             ENDIF
868:         CATCH TO loc_oErro
869:             MsgErro(loc_oErro.Message + CHR(13) + ;
870:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
871:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnConfirmarClick")
872:         ENDTRY
873: 
874:         THIS.txt_4c_Codigo.SetFocus()
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * BtnCancelarClick - equivalente ao Cancela.Click do legado (botao
879:     * "Cancela", Caption "Encerrar"): "Thisform.Release" - unico caminho de
880:     * saida da tela (form Flat, sem Page2/Dados para cancelar).
881:     *--------------------------------------------------------------------------
882:     PROCEDURE BtnCancelarClick()
883:         THIS.Release()
884:     ENDPROC
885: 
886:     *--------------------------------------------------------------------------
887:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
888:     * FILTRO: nenhum container flutuante neste form
889:     *--------------------------------------------------------------------------
890:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
891:         LOCAL loc_i, loc_oControl
892: 
893:         FOR loc_i = 1 TO par_oContainer.ControlCount
894:             loc_oControl = par_oContainer.Controls(loc_i)
895:             IF VARTYPE(loc_oControl) = "O"
896:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
897:                     loc_oControl.Visible = .T.
898:                 ENDIF
899:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
900:                     THIS.TornarControlesVisiveis(loc_oControl)
901:                 ENDIF
902:             ENDIF
903:         ENDFOR
904:     ENDPROC
905: 
906: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpBcbBO.prg):
*============================================================================
* SigOpBcbBO.prg - Business Object do form OPERACIONAL "Baixa de Codigos de
*                  Barras" (legado SIGOPBCB.SCX)
*
* Tabela principal : SigMvHst  (PK: cidchaves char(20))
*
* FLUXO DO LEGADO (tasks\task645\SigOpBcb_form_codigo_fonte.txt)
* ------------------------------------------------------------------------
* O operador le/digita o codigo de barras da etiqueta (Get_Codigo). O Valid
* do campo consulta SigOpEtq por CBars e, achando a etiqueta, exibe na tela
* Grupo, Conta, Produto, Descricao do Produto, Quantidade (1) e
* Quantidade (2) mais as duas unidades de medida. O botao "Baixa"
* (Confirma.Click -> ThisForm.BaixaBarra) efetiva a baixa gravando, numa
* unica transacao:
*
*   1) INSERT em SigMvCab  - cabecalho do movimento de baixa
*   2) INSERT em SigMvHst  - historico/movimento de estoque (Opers = "S")
*   3) UPDATE em SigOpEtq  - zera Grupos e Contas, marca DtMovs e Usuars
*
* Duas recusas do Valid legado, que continuam valendo:
*   - etiqueta inexistente em SigOpEtq         -> "Codigo Nao Localizado"
*   - Grupos E Contas ambos vazios na etiqueta -> "Codigo Ja Baixado"
*
* TABELAS CONSULTADAS (somente leitura)
*   SigOpEtq  - etiqueta lida pelo codigo de barras (PK cbars numeric(14,0))
*   SigCdPro  - descricao e unidades do produto (Dpros, cUnis, cUniPs)
*   SigCdPac  - parametros do sistema; dali sai SigKeys, sufixo da chave
*               cidchaves do historico (no legado, ThisForm.SigKey)
*
* CHAVES POSICIONAIS (regra CLAUDE.md #42 - o padding FAZ PARTE da chave)
*   EmpDopNums char(29) = Empos char(3) + Dopes char(20) + STR(Numes, 6)
*   EmpGruEsts char(23) = Empos char(3) + Grupos char(10) + Contas char(10)
*   As partes vao com PADR() na largura da coluna, NUNCA com ALLTRIM: a soma
*   tem de fechar exatamente 29 e 23, senao a chave nunca casa e o SELECT
*   devolve zero linha em silencio.
*
* NOTA DE ESCOPO - fRecalculaP / fRecalculaC
*   O BaixaBarra legado chama fRecalculaP/fRecalculaC (recalculo de custo e
*   preco medio de estoque) em quatro pontos. As duas funcoes NAO existem no
*   acervo - nem como .prg, nem no Framework, nem no p-code dos VCX. Pela
*   regra CLAUDE.md #27 (3a linha da tabela: funcao que devolve VALOR DE
*   CALCULO fica AUSENTE e visivel, nunca vira stub), as chamadas ficam de
*   fora: um stub devolvendo zero gravaria custo medio errado em silencio.
*   Mesmo tratamento ja adotado em SigPrGlpBO, SigPrGlxBO e dmoBO.
*
* COBERTURA DE COLUNAS NOT NULL (regra CLAUDE.md #22)
*   O legado grava o registro INTEIRO (AddCursor sem query = SELECT * +
*   TABLEUPDATE), entao coluna que nao aparece na tela continua sendo gravada
*   em branco pelo cursor. Os INSERT escritos a mao precisam cobrir TODA
*   coluna NOT NULL sem DEFAULT, senao o SQL Server recusa a gravacao inteira.
*   Medido em docs\schema.sql (UTF-16, lido com Get-Content -Raw):
*
*     SigMvCab : 137 colunas NOT NULL, 26 com DEFAULT -> 111 a cobrir
*     SigMvHst :  36 colunas NOT NULL,  0 com DEFAULT ->  36 a cobrir
*
*   As colunas sem property declarada aqui recebem o default do tipo:
*   EscaparSQL("") para char, FormatarNumeroSQL(0, <dec>) para numeric,
*   0 para bit. A lista vem do SCHEMA, nunca do dump do legado - as colunas
*   ausentes sao invisiveis la. O gate Validate-InsertNotNull (etapa
*   05f_validarSQLSchema) BLOQUEIA a migracao se faltar alguma.
*
* DATA/HORA - as properties this_t* nascem como {} (DATE vazio), que eh a
*   convencao do projeto para campo datetime ainda nao preenchido. Quando
*   recebem DATETIME() passam a ser do tipo T. FormatarDataSQL() aceita os
*   dois tipos e devolve "NULL" no vazio; TTOD() NAO aceita DATE e dispara
*   erro 11 em runtime (regra CLAUDE.md #16) - havendo necessidade de
*   converter, usar ConverterParaData() de utils\functions.prg.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpBcbBO AS BusinessBase

    *==========================================================================
    * 1) ETIQUETA LIDA - colunas de SigOpEtq (origem de quase todo o resto)
    *==========================================================================
    this_nCbars    = 0    && numeric(14,0) - SigOpEtq.cbars - codigo de barras
    this_cGrupos   = ""   && char(10)      - SigOpEtq.grupos - grupo da conta
    this_cContas   = ""   && char(10)      - SigOpEtq.contas - conta/estoque
    this_cCpros    = ""   && char(14)      - SigOpEtq.cpros  - codigo produto
    this_cEmpos    = ""   && char(3)       - SigOpEtq.empos  - empresa de origem
    this_nQtds     = 0    && numeric(9,3)  - SigOpEtq.qtds   - Quantidade (1)
    this_nPesos    = 0    && numeric(9,3)  - SigOpEtq.pesos  - Quantidade (2)
    this_cCodCors  = ""   && char(4)       - SigOpEtq.codcors - cor
    this_cCodTams  = ""   && char(4)       - SigOpEtq.codtams - tamanho

    *==========================================================================
    * 2) PRODUTO - colunas de SigCdPro lidas pelo Valid legado
    *    CursorQuery("SigCdPro", "LocalPro", "Cpros", ..., [ Dpros, cUnis, cUniPs ])
    *==========================================================================
    this_cDpros    = ""   && char(65) - SigCdPro.dpros  - descricao do produto
    this_cCunis    = ""   && char(3)  - SigCdPro.cunis  - unidade da Qtde (1)
    this_cCunips   = ""   && char(3)  - SigCdPro.cunips - unidade da Qtde (2)

    *==========================================================================
    * 3) PARAMETRO DO SISTEMA - SigCdPac
    *==========================================================================
    this_cSigKeys  = ""   && char(3) - SigCdPac.sigkeys - sufixo do cidchaves
                          &&           do historico (ThisForm.SigKey no legado)

    *==========================================================================
    * 4) CABECALHO DO MOVIMENTO - colunas gravadas em SigMvCab
    *    Emps e Dopes tambem alimentam o INSERT de SigMvHst.
    *==========================================================================
    this_cDopes      = ""   && char(20)     - SigMvCab.dopes - recebe
                            &&                PADR("BAIXA ETIQUETA", 20); o
                            &&                padding entra na chave posicional
    this_nNumes      = 0    && numeric(6,0) - SigMvCab.numes - numero do
                            &&                movimento, de fGerUniqueKey()
    this_cMascNum    = ""   && char(10)     - SigMvCab.mascnum - fGerMascara()
    this_cGrupoOs    = ""   && char(10)     - SigMvCab.grupoos - grupo de origem
    this_cContaOs    = ""   && char(10)     - SigMvCab.contaos - conta de origem
    this_tDatas      = {}   && datetime     - SigMvCab.datas / SigMvHst.datas
    this_tDatars     = {}   && datetime     - SigMvHst.datars (mesmo instante)
    this_tDtAlts     = {}   && datetime     - .dtalts das duas tabelas
    this_cUsuars     = ""   && char(10)     - .usuars das duas tabelas
    this_cCidChaves  = ""   && char(20)     - SigMvCab.cidchaves - fUniqueIds()
    this_cEmpDopNums = ""   && char(29)     - .empdopnums das duas tabelas
                            &&                (Empos + Dopes + STR(Numes, 6))

    *==========================================================================
    * 5) HISTORICO DE ESTOQUE - colunas exclusivas de SigMvHst
    *==========================================================================
    this_nCodBarras    = 0    && numeric(14,0) - SigMvHst.codbarras - o mesmo
                              &&                 valor de this_nCbars
    this_cOpers        = "S"  && char(1)       - SigMvHst.opers - "S" (saida),
                              &&                 constante no BaixaBarra legado
    this_cEstos        = ""   && char(10)      - SigMvHst.estos - recebe a
                              &&                 Conta da etiqueta
    this_cCidChavesHst = ""   && char(20)      - SigMvHst.cidchaves - montada
                              &&                 como DTOS(Datas) + "S" +
                              &&                 TRANSFORM(fGerUniqueKey(
                              &&                 DTOS(Datas)), "@L 999999") +
                              &&                 SigKeys  (8+1+6+3 = 18 chars)
    this_cEmpGruEsts   = ""   && char(23)      - SigMvHst.empgruests
                              &&                 (Empos + Grupos + Contas)
    this_cOriDopNums   = ""   && char(29)      - SigMvHst.oridopnums - mesma
                              &&                 montagem de EmpDopNums
    this_nSeqs         = 0    && numeric(10,0) - SigMvHst.seqs -
                              &&                 fGerUniqueKey("HISTBAR")

    *==========================================================================
    * 6) ESTADO DA LEITURA - resultado da consulta da etiqueta, consumido pelo
    *    Form para decidir entre exibir os dados, recusar o codigo ou avisar
    *    que a etiqueta ja foi baixada (as duas recusas do Valid legado)
    *==========================================================================
    this_lEtiquetaLocalizada = .F.   && .T. quando SigOpEtq devolveu a linha
    this_lEtiquetaBaixada    = .F.   && .T. quando Grupos e Contas estao vazios
                                     &&     na etiqueta (baixa ja efetivada)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria do Business Object
    *
    * A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
    * this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio o objeto
    * de acesso a dados fica .NULL. e todo metodo herdado que depende dele
    * devolve .F. com "Objeto de acesso a dados nao inicializado".
    *
    * this_cCampoChave recebe cidchaves - a PRIMARY KEY real de SigMvHst
    * conforme docs\schema.sql (constraint sigmvhst_cidchaves).
    *
    * Regra CLAUDE.md #1: nenhum RETURN dentro de TRY/CATCH - o resultado vai
    * numa flag e o RETURN unico fica depois do ENDTRY.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvHst")

            THIS.this_cTabela     = "SigMvHst"
            THIS.this_cCampoChave = "cidchaves"

            *-- Constante do legado: lcDop = Padr("BAIXA ETIQUETA", 20).
            *-- Fica com o padding desde o inicio porque a largura de 20
            *-- caracteres compoe EmpDopNums char(29) (regra #42).
            THIS.this_cDopes = PADR("BAIXA ETIQUETA", 20)

            *-- Operacao de saida de estoque, fixa no BaixaBarra legado.
            THIS.this_cOpers = "S"

            *-- Usuario logado alimenta usuars de SigMvCab, SigMvHst e do
            *-- UPDATE de SigOpEtq (no legado, a variavel PUBLIC Usuar).
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ELSE
                THIS.this_cUsuars = ""
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - cidchaves de SigMvHst (this_cTabela), usado pelo
    * RegistrarAuditoria herdado da BusinessBase.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChavesHst)
    ENDPROC

    *==========================================================================
    * CarregarSigKeys - Le o sufixo da chave do historico (SigCdPac.sigkeys),
    * equivalente a ThisForm.SigKey no Init legado. So eh necessario no
    * instante da gravacao, por isso fica aqui e nao no Init do BO.
    *==========================================================================
    PROTECTED FUNCTION CarregarSigKeys()
        LOCAL loc_cSigKeys, loc_nResultado
        loc_cSigKeys = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_BcbPac")
                USE IN cursor_4c_BcbPac
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT sigkeys FROM SigCdPac", "cursor_4c_BcbPac")

            IF loc_nResultado > 0 AND USED("cursor_4c_BcbPac") AND RECCOUNT("cursor_4c_BcbPac") > 0
                SELECT cursor_4c_BcbPac
                GO TOP
                loc_cSigKeys = TratarNulo(sigkeys, "")
            ENDIF

            IF USED("cursor_4c_BcbPac")
                USE IN cursor_4c_BcbPac
            ENDIF
        ENDIF

        THIS.this_cSigKeys = loc_cSigKeys
        RETURN loc_cSigKeys
    ENDFUNC

    *==========================================================================
    * ConsultarEtiqueta - replica o Valid de Get_Codigo do legado: busca a
    * etiqueta em SigOpEtq pelo codigo de barras e, achando-a valida, completa
    * com a descricao/unidades do produto (SigCdPro.CursorQuery do Valid
    * legado). Preenche as properties que o Form espelha nos campos de
    * exibicao (Grupo/Conta/Produto/Descricao/Qtde/Peso/unidades) e os dois
    * flags que decidem a mensagem no Form - mesmas duas recusas do Valid:
    *   this_lEtiquetaLocalizada - .F. quando SigOpEtq nao tem a linha
    *   this_lEtiquetaBaixada    - .T. quando Grupos e Contas estao vazios
    *                              na etiqueta (a baixa ja foi efetivada)
    *
    * par_nCbars = codigo de barras ja convertido pelo Form com
    * INT(VAL(...)), igual ao legado: lnBar = Iif(Type('This.Value')='C',
    * Int(Val(This.Value)), This.Value).
    *==========================================================================
    PROCEDURE ConsultarEtiqueta(par_nCbars)
        LOCAL loc_lSucesso, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        *-- Limpa o resultado da consulta anterior - mesmo bloco que abre o
        *-- Valid legado (With ThisForm / .Get_Grupo.Value = ' ' / ...).
        THIS.this_lEtiquetaLocalizada = .F.
        THIS.this_lEtiquetaBaixada    = .F.
        THIS.this_cGrupos   = ""
        THIS.this_cContas   = ""
        THIS.this_cCpros    = ""
        THIS.this_cDpros    = ""
        THIS.this_nQtds     = 0
        THIS.this_nPesos    = 0
        THIS.this_cCunis    = ""
        THIS.this_cCunips   = ""
        THIS.this_cEmpos    = ""
        THIS.this_cCodCors  = ""
        THIS.this_cCodTams  = ""
        THIS.this_nCbars    = par_nCbars

        IF par_nCbars <= 0
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_BcbEtq")
                    USE IN cursor_4c_BcbEtq
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos, Contas, Cpros, Empos, CodCors, CodTams, Qtds, Pesos " + ;
                    "FROM SigOpEtq WHERE CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    "cursor_4c_BcbEtq")

                IF loc_nResultado >= 0 AND USED("cursor_4c_BcbEtq") AND RECCOUNT("cursor_4c_BcbEtq") > 0
                    SELECT cursor_4c_BcbEtq
                    GO TOP

                    THIS.this_lEtiquetaLocalizada = .T.
                    THIS.this_cGrupos  = TratarNulo(Grupos, "")
                    THIS.this_cContas  = TratarNulo(Contas, "")
                    THIS.this_cCpros   = TratarNulo(Cpros, "")
                    THIS.this_cEmpos   = TratarNulo(Empos, "")
                    THIS.this_cCodCors = TratarNulo(CodCors, "")
                    THIS.this_cCodTams = TratarNulo(CodTams, "")
                    THIS.this_nQtds    = TratarNulo(Qtds, 0)
                    THIS.this_nPesos   = TratarNulo(Pesos, 0)

                    IF EMPTY(THIS.this_cGrupos) AND EMPTY(THIS.this_cContas)
                        *-- If Empty(crSigOpEtq.Grupos) And Empty(crSigOpEtq.Contas)
                        *-- "Codigo Ja Baixado" - a etiqueta nao tem mais saldo
                        *-- de Grupo/Conta para gerar uma nova baixa.
                        THIS.this_lEtiquetaBaixada = .T.
                    ELSE
                        *-- ThisForm.poDataMgr.CursorQuery('SigCdPro', 'LocalPro',
                        *-- 'Cpros', CrSigOpEtq.cpros, [ Dpros, cUnis, cUniPs ])
                        IF USED("cursor_4c_BcbPro")
                            USE IN cursor_4c_BcbPro
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "SELECT Dpros, cUnis, cUniPs FROM SigCdPro WHERE Cpros = " + EscaparSQL(THIS.this_cCpros), ;
                            "cursor_4c_BcbPro")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_BcbPro") AND RECCOUNT("cursor_4c_BcbPro") > 0
                            SELECT cursor_4c_BcbPro
                            GO TOP
                            THIS.this_cDpros  = TratarNulo(Dpros, "")
                            THIS.this_cCunis  = TratarNulo(cUnis, "")
                            THIS.this_cCunips = TratarNulo(cUniPs, "")
                        ENDIF

                        IF USED("cursor_4c_BcbPro")
                            USE IN cursor_4c_BcbPro
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BcbEtq")
                    USE IN cursor_4c_BcbEtq
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigMvHst (par_cAliasCursor) para
    * as propriedades do BO. Usado por CarregarPorCodigo() quando for preciso
    * reabrir um historico de baixa ja gravado.
    *
    * Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
    * Regra [[feedback_tratarnulo_2o_arg_eh_valor_padrao]]: o 2o argumento de
    * TratarNulo() eh o VALOR PADRAO do tipo da coluna, nunca um codigo "C"/
    * "N"/"D" - "" para char, 0 para numeric, {} para datetime.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nCodBarras    = TratarNulo(codbarras, 0)
                THIS.this_cUsuars       = TratarNulo(usuars, "")
                THIS.this_cOpers        = TratarNulo(opers, "")
                THIS.this_cCpros        = TratarNulo(cpros, "")
                THIS.this_tDatas        = TratarNulo(datas, {})
                THIS.this_tDatars       = TratarNulo(datars, {})
                THIS.this_cDopes        = TratarNulo(dopes, "")
                THIS.this_cEmpos        = TratarNulo(empos, "")
                THIS.this_cGrupos       = TratarNulo(grupos, "")
                THIS.this_cEstos        = TratarNulo(estos, "")
                THIS.this_nNumes        = TratarNulo(numes, 0)
                THIS.this_cCidChavesHst = TratarNulo(cidchaves, "")
                THIS.this_cEmpDopNums   = TratarNulo(empdopnums, "")
                THIS.this_cEmpGruEsts   = TratarNulo(empgruests, "")
                THIS.this_tDtAlts       = TratarNulo(dtalts, {})
                THIS.this_cOriDopNums   = TratarNulo(oridopnums, "")
                THIS.this_nSeqs         = TratarNulo(seqs, 0)
                THIS.this_cCodCors      = TratarNulo(codcors, "")
                THIS.this_cCodTams      = TratarNulo(codtams, "")
                THIS.this_nQtds         = TratarNulo(qtds, 0)
                THIS.this_nPesos        = TratarNulo(pesos, 0)
                THIS.this_nCbars        = THIS.this_nCodBarras

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - "BaixaBarra" do legado: grava o movimento de baixa inteiro
    * (SigMvCab + SigMvHst) e zera a etiqueta em SigOpEtq, tudo num UNICO
    * SQLEXEC.
    *
    * [[feedback_begin_commit_via_sqlexec_nao_protege]] - BEGIN/COMMIT via
    * SQLEXEC separados NAO sao atomicos (a conexao nasce com Transactions=2
    * e @@TRANCOUNT ja vale 1): por isso o lote inteiro vai num SQLEXEC so,
    * com SAVE TRANSACTION quando ja ha transacao aberta - mesmo padrao do
    * ProdutoBO.CopiarProduto (Erro188).
    *
    * As colunas NOT NULL sem DEFAULT que o legado grava em branco (nao
    * aparecem no "Insert Into" do BaixaBarra, porque o AddCursor/
    * TableUpdate do legado grava o registro inteiro) recebem aqui o default
    * do tipo - regra CLAUDE.md #22. Lista tirada de docs\schema.sql.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSigKeys, loc_tDatas, loc_nSeqHst, loc_cCidChavesHst
        LOCAL loc_cEmpDopNums, loc_cEmpGruEsts
        LOCAL loc_cColsCab, loc_cValsCab, loc_cColsHst, loc_cValsHst
        LOCAL loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        *-- O Form chama Inserir() DIRETO (nao via BusinessBase.Salvar()), que
        *-- eh quem normalmente zera estes dois e chama ExibirFalha(). Zerar
        *-- aqui mantem o contrato da regra CLAUDE.md #20 valendo: quem exibe
        *-- marca this_lErroExibido, e o chamador so completa a mensagem
        *-- quando ela sobrou sem ser mostrada.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !THIS.this_lEtiquetaLocalizada
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo n" + CHR(227) + "o localizado."
            ELSE
                IF THIS.this_lEtiquetaBaixada
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo j" + CHR(225) + " foi baixado."
                ELSE
                    *-- 1) Chaves e numeros gerados pelo legado - fGerUniqueKey/
                    *--    fGerMascara/fUniqueIds (utils\functions.prg).
                    loc_cSigKeys = THIS.CarregarSigKeys()

                    loc_tDatas = DATETIME()
                    THIS.this_tDatas     = loc_tDatas
                    THIS.this_tDatars    = loc_tDatas
                    THIS.this_tDtAlts    = loc_tDatas
                    THIS.this_nCodBarras = THIS.this_nCbars

                    *-- lnNum = fGerUniqueKey(Alltrim(lcDop) + lcEmp)
                    THIS.this_nNumes   = fGerUniqueKey(ALLTRIM(THIS.this_cDopes) + ALLTRIM(THIS.this_cEmpos))
                    THIS.this_cMascNum = fGerMascara(THIS.this_nNumes)
                    THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

                    *-- Chaves posicionais (regra CLAUDE.md #42) - PADR na
                    *-- largura da COLUNA, nunca ALLTRIM: Empos char(3) +
                    *-- Dopes char(20) + Str(Numes,6) = 29 = EmpDopNums char(29).
                    loc_cEmpDopNums = PADR(THIS.this_cEmpos, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
                    THIS.this_cEmpDopNums = loc_cEmpDopNums
                    THIS.this_cOriDopNums = loc_cEmpDopNums

                    loc_cEmpGruEsts = PADR(THIS.this_cEmpos, 3) + PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10)
                    THIS.this_cEmpGruEsts = loc_cEmpGruEsts

                    THIS.this_cGrupoOs = THIS.this_cGrupos
                    THIS.this_cContaOs = THIS.this_cContas
                    THIS.this_cEstos   = THIS.this_cContas

                    *-- pCidC = Dtos(pDat)+'S'+Transform(fGerUniqueKey(Dtos(pDat)),"@L 999999")+ThisForm.Sigkey
                    loc_nSeqHst = fGerUniqueKey(DTOS(loc_tDatas))
                    loc_cCidChavesHst = DTOS(loc_tDatas) + "S" + PADL(ALLTRIM(STR(loc_nSeqHst)), 6, "0") + ALLTRIM(loc_cSigKeys)
                    THIS.this_cCidChavesHst = loc_cCidChavesHst

                    *-- pSeq = fGerUniqueKey('HISTBAR')
                    THIS.this_nSeqs = fGerUniqueKey("HISTBAR")

                    *-- 2) Colunas NOT NULL sem DEFAULT que o legado nao grava
                    *--    explicitamente (ver cabecalho do metodo).
                    loc_cColsCab = "npedclis, acres, antecs, chksubn, codpeds, contads, " + ;
                        "desc2s, descs, devols, empds, grresps, grupods, " + ;
                        "grupos, grvends, iclis, ifors, locals, lotechqs, " + ;
                        "lprecos, ncarnecs, nemps, nops, notas, nrcons, " + ;
                        "ntrans, numolds, opers, resps, tabds, tpfats, " + ;
                        "transps, usuals, usulibs, valacres, valdes2s, valdescs, " + ;
                        "valdevs, valencs, valinis, valos, valservs, valvars, " + ;
                        "vars, vends, cotusus, espes, qtdes, lcancelas, " + ;
                        "cofs, livros, chkbxparcs, ecfs, codobs, dgopes, " + ;
                        "trfisicos, utilizados, valndevs, valobxs, noforms, auditors, " + ;
                        "empgopnums, contaes, localents, localizas, chkpagos, chkpgs, " + ;
                        "codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, " + ;
                        "motdscs, ndeclaras, numbalds, numbals, priors, procbals, " + ;
                        "procdbal, protats, usupagos, ultgrvs, moeits, rnops, " + ;
                        "impress, pstatus, valvarps, cifccfs, cupfis, idconta, " + ;
                        "ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, " + ;
                        "jobs, ptax1s, ptax2s, ptax3s, obscabmovs, codobs2"

                    loc_cValsCab = FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + "0" + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + "0" + ", " + ;
                        "0" + ", " + "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + ;
                        "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + "0" + ", " + "0" + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("")

                    loc_cColsHst = "codcors, codtams, qtds, sqtds, teqtds, totas, " + ;
                        "tsqtds, units, moedas, numolds, ntrans, locals, " + ;
                        "unitmeds, moedmeds, recalmeds, auditors, pesos, spesos, " + ;
                        "unitmfis, bcipis, medipis"

                    loc_cValsHst = EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,3) + ", " + ;
                        FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,6) + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,6) + ", " + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,6) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        FormatarNumeroSQL(0,6)

                    *-- 3) INSERT em SigMvCab, INSERT em SigMvHst e UPDATE em
                    *--    SigOpEtq, num UNICO lote (ver cabecalho do metodo).
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
SET NOCOUNT ON;
DECLARE @nivel4c int = @@TRANCOUNT;
IF @nivel4c = 0 BEGIN TRANSACTION
ELSE SAVE TRANSACTION Baixa4c;
BEGIN TRY
    INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, GrupoOs, ContaOs, Datas, Usuars, EmpDopNums, cIdChaves, DtAlts, <<loc_cColsCab>>)
    VALUES (<<EscaparSQL(THIS.this_cEmpos)>>, <<EscaparSQL(THIS.this_cDopes)>>, <<FormatarNumeroSQL(THIS.this_nNumes,0)>>, <<EscaparSQL(THIS.this_cMascNum)>>, <<EscaparSQL(THIS.this_cGrupoOs)>>, <<EscaparSQL(THIS.this_cContaOs)>>, <<FormatarDataSQL(THIS.this_tDatas)>>, <<EscaparSQL(THIS.this_cUsuars)>>, <<EscaparSQL(loc_cEmpDopNums)>>, <<EscaparSQL(THIS.this_cCidChaves)>>, <<FormatarDataSQL(THIS.this_tDtAlts)>>, <<loc_cValsCab>>);

    INSERT INTO SigMvHst (CodBarras, Usuars, Opers, Cpros, Datas, Datars, Dopes, Empos, Emps, Grupos, Estos, Numes, Cidchaves, EmpDopNums, EmpGruEsts, DtAlts, OriDopNums, Seqs, <<loc_cColsHst>>)
    VALUES (<<FormatarNumeroSQL(THIS.this_nCodBarras,0)>>, <<EscaparSQL(THIS.this_cUsuars)>>, <<EscaparSQL(THIS.this_cOpers)>>, <<EscaparSQL(THIS.this_cCpros)>>, <<FormatarDataSQL(THIS.this_tDatas)>>, <<FormatarDataSQL(THIS.this_tDatars)>>, <<EscaparSQL(THIS.this_cDopes)>>, <<EscaparSQL(THIS.this_cEmpos)>>, <<EscaparSQL(THIS.this_cEmpos)>>, <<EscaparSQL(THIS.this_cGrupos)>>, <<EscaparSQL(THIS.this_cEstos)>>, <<FormatarNumeroSQL(THIS.this_nNumes,0)>>, <<EscaparSQL(loc_cCidChavesHst)>>, <<EscaparSQL(loc_cEmpDopNums)>>, <<EscaparSQL(loc_cEmpGruEsts)>>, <<FormatarDataSQL(THIS.this_tDtAlts)>>, <<EscaparSQL(loc_cEmpDopNums)>>, <<FormatarNumeroSQL(THIS.this_nSeqs,0)>>, <<loc_cValsHst>>);

    UPDATE SigOpEtq SET Grupos = '', Contas = '', DtMovs = <<FormatarDataSQL(loc_tDatas)>>, Usuars = <<EscaparSQL(THIS.this_cUsuars)>> WHERE CBars = <<FormatarNumeroSQL(THIS.this_nCbars,0)>>;

    IF @nivel4c = 0 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @nivel4c = 0
    BEGIN
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        IF XACT_STATE() = 1 ROLLBACK TRANSACTION Baixa4c;
    END;
    THROW;
END CATCH
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        THIS.this_lEtiquetaBaixada = .T.
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao gravar a baixa do c" + CHR(243) + "digo de barras:" + CHR(13) + CapturarErroSQL()
                        MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - sem equivalente no legado: o BaixaBarra SEMPRE cria um novo
    * par de registros (SigMvCab/SigMvHst) a cada confirmacao; nunca altera
    * um movimento ja gravado. O correto aqui eh recusar.
    *==========================================================================
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "A baixa de c" + CHR(243) + "digo de barras sempre " + ;
            "gera um novo registro de movimento; n" + CHR(227) + "o h" + CHR(225) + ;
            " altera" + CHR(231) + CHR(227) + "o de baixa existente."
        RETURN .F.
    ENDPROC

ENDDEFINE

