# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReInv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1639 linhas total):

*-- Linhas 29 a 151:
29:     Themes      = .F.
30:     ShowTips    = .T.
31: 
32:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
33:     this_oRelatorio    = .NULL.
34:     this_cMensagemErro = ""
35: 
36:     *--------------------------------------------------------------------------
37:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
38:     *--------------------------------------------------------------------------
39:     PROCEDURE Init()
40:         RETURN DODEFAULT()
41:     ENDPROC
42: 
43:     *--------------------------------------------------------------------------
44:     * InicializarForm - Monta estrutura visual: cabecalho + botoes + filtros
45:     *--------------------------------------------------------------------------
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso, loc_lContinuar
48:         loc_lSucesso   = .F.
49:         loc_lContinuar = .T.
50:         TRY
51:             THIS.Caption = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
52: 
53:             IF TYPE("gc_4c_CaminhoIcones") = "U"
54:                 gc_4c_CaminhoIcones = ""
55:             ENDIF
56:             IF TYPE("gc_4c_CaminhoReports") = "U"
57:                 gc_4c_CaminhoReports = ""
58:             ENDIF
59:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
60: 
61:             *-- Instanciar BO de relatorio
62:             THIS.this_oRelatorio = CREATEOBJECT("SigReInvBO")
63:             IF VARTYPE(THIS.this_oRelatorio) != "O"
64:                 MsgErro("Erro ao criar SigReInvBO" + CHR(13) + ;
65:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
66:                 loc_lContinuar = .F.
67:             ENDIF
68: 
69:             IF loc_lContinuar
70:                 *-- Carrega cursores base (empresas, moedas, cotacoes etc.)
71:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
72:                     IF !THIS.this_oRelatorio.CarregarDadosIniciais()
73:                         MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
74:                         loc_lContinuar = .F.
75:                     ENDIF
76:                 ENDIF
77:             ENDIF
78: 
79:             IF loc_lContinuar
80:                 THIS.ConfigurarCabecalho()
81:                 THIS.ConfigurarBotoes()
82:                 THIS.ConfigurarFiltros()
83: 
84:                 *-- Vincular eventos dos botoes (BINDEVENT exige metodos PUBLIC)
85:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
86:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
87:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnGerarTxtClick")
88:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
89: 
90:                 THIS.LimparCampos()
91: 
92:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
93:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
94: 
95:                 THIS.Visible = .T.
96:                 loc_lSucesso = .T.
97:             ENDIF
98: 
99:         CATCH TO loc_oErro
100:             THIS.this_cMensagemErro = loc_oErro.Message
101:             MsgErro(loc_oErro.Message + CHR(13) + ;
102:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
103:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
104:         ENDTRY
105:         RETURN loc_lSucesso
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
110:     *--------------------------------------------------------------------------
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH THIS.cnt_4c_Cabecalho
114:             .Top         = 0
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackStyle   = 1
119:             .BackColor   = RGB(100, 100, 100)
120:             .BorderWidth = 0
121:             .Visible     = .T.
122: 
123:             .AddObject("lbl_4c_Sombra", "Label")
124:             WITH .lbl_4c_Sombra
125:                 .Top       = 22
126:                 .Left      = 22
127:                 .Width     = THIS.Width
128:                 .Height    = 30
129:                 .Caption   = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
130:                 .FontName  = "Tahoma"
131:                 .FontSize  = 14
132:                 .FontBold  = .T.
133:                 .ForeColor = RGB(0, 0, 0)
134:                 .BackStyle = 0
135:                 .Visible   = .T.
136:             ENDWITH
137: 
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Top       = 20
141:                 .Left      = 20
142:                 .Width     = THIS.Width
143:                 .Height    = 30
144:                 .Caption   = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 14
147:                 .FontBold  = .T.
148:                 .ForeColor = RGB(255, 255, 255)
149:                 .BackStyle = 0
150:                 .Visible   = .T.
151:             ENDWITH

*-- Linhas 157 a 200:
157:     *   Posicao equivalente ao btnReport do legado: Left=524, Top=7
158:     *   Botao 3 = "Gera TXT" (no lugar do DocExcel do padrao, habilitado aqui)
159:     *--------------------------------------------------------------------------
160:     PROTECTED PROCEDURE ConfigurarBotoes()
161:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
162:         WITH THIS.cmg_4c_Botoes
163:             .Top           = 0
164:             .Left          = 529
165:             .Width         = 273
166:             .Height        = 80
167:             .ButtonCount   = 4
168:             .BackStyle     = 0
169:             .BorderStyle   = 0
170:             .BorderColor   = RGB(136, 189, 188)
171:             .SpecialEffect = 1
172:             .Themes        = .F.
173:             .Visible       = .T.
174: 
175:             WITH .Buttons(1)
176:                 .Top             = 5
177:                 .Left            = 5
178:                 .Width           = 65
179:                 .Height          = 70
180:                 .Caption         = "Visualizar"
181:                 .FontBold        = .T.
182:                 .FontItalic      = .T.
183:                 .BackColor       = RGB(255, 255, 255)
184:                 .ForeColor       = RGB(90, 90, 90)
185:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
186:                 .PicturePosition = 13
187:                 .SpecialEffect   = 0
188:                 .MousePointer    = 15
189:                 .ToolTipText     = "Visualizar Relat" + CHR(243) + "rio"
190:                 .Themes          = .F.
191:                 .Enabled         = .T.
192:                 .Visible         = .T.
193:             ENDWITH
194: 
195:             WITH .Buttons(2)
196:                 .Top             = 5
197:                 .Left            = 71
198:                 .Width           = 65
199:                 .Height          = 70
200:                 .Caption         = "Imprimir"

*-- Linhas 265 a 361:
265:     * ConfigurarFiltros - Cria todos os controles de filtro do form
266:     *   Posicoes e dimensoes extraidas diretamente do SCX legado.
267:     *--------------------------------------------------------------------------
268:     PROTECTED PROCEDURE ConfigurarFiltros()
269:         LOCAL loc_lMedioVisivel, loc_lVendaVisivel
270:         loc_lMedioVisivel = .T.
271:         loc_lVendaVisivel = .T.
272: 
273:         *-- Label Empresa
274:         THIS.AddObject("lbl_4c_Empresa", "Label")
275:         WITH THIS.lbl_4c_Empresa
276:             .AutoSize  = .T.
277:             .FontName  = "Tahoma"
278:             .FontSize  = 8
279:             .Caption   = "Empresa :"
280:             .Left      = 164
281:             .Top       = 160
282:             .ForeColor = RGB(90, 90, 90)
283:             .BackStyle = 0
284:             .Visible   = .T.
285:         ENDWITH
286: 
287:         *-- Codigo da empresa (Get_Cd_Empresa)
288:         THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
289:         WITH THIS.txt_4c_CdEmpresa
290:             .FontName      = "Tahoma"
291:             .BorderStyle   = 1
292:             .Format        = "K!"
293:             .Height        = 25
294:             .InputMask     = "XXX"
295:             .Left          = 219
296:             .MaxLength     = 3
297:             .SpecialEffect = 1
298:             .TabIndex      = 1
299:             .Top           = 156
300:             .Width         = 31
301:             .Visible       = .T.
302:         ENDWITH
303:         BINDEVENT(THIS.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
304:         BINDEVENT(THIS.txt_4c_CdEmpresa, "DblClick", THIS, "EmpresaDblClick")
305: 
306:         *-- Descricao da empresa (Get_Ds_Empresa)
307:         THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
308:         WITH THIS.txt_4c_DsEmpresa
309:             .FontName      = "Tahoma"
310:             .BorderStyle   = 1
311:             .Format        = "K"
312:             .Height        = 25
313:             .Left          = 252
314:             .MaxLength     = 40
315:             .SpecialEffect = 1
316:             .TabIndex      = 2
317:             .Top           = 156
318:             .Width         = 290
319:             .Visible       = .T.
320:         ENDWITH
321:         BINDEVENT(THIS.txt_4c_DsEmpresa, "When", THIS, "WhenDsEmpresa")
322: 
323:         *-- Label Inventario
324:         THIS.AddObject("lbl_4c_Inventario", "Label")
325:         WITH THIS.lbl_4c_Inventario
326:             .AutoSize  = .T.
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .Caption   = "Invent" + CHR(225) + "rio :"
330:             .Left      = 155
331:             .Top       = 185
332:             .ForeColor = RGB(90, 90, 90)
333:             .BackStyle = 0
334:             .Visible   = .T.
335:         ENDWITH
336: 
337:         *-- Shape agrupador de Inventario
338:         THIS.AddObject("shp_4c_Inv", "Shape")
339:         WITH THIS.shp_4c_Inv
340:             .Top           = 185
341:             .Left          = 219
342:             .Height        = 58
343:             .Width         = 243
344:             .BackStyle     = 0
345:             .BorderWidth   = 1
346:             .SpecialEffect = 1
347:             .Visible       = .T.
348:         ENDWITH
349: 
350:         *-- ChkInv1: Proprio (Value=1)
351:         THIS.AddObject("chk_4c_Inv1", "CheckBox")
352:         WITH THIS.chk_4c_Inv1
353:             .AutoSize  = .T.
354:             .FontName  = "Tahoma"
355:             .FontSize  = 8
356:             .Alignment = 0
357:             .BackStyle = 0
358:             .Caption   = "Pr" + CHR(243) + "prio"
359:             .Value     = 1
360:             .Left      = 223
361:             .Top       = 189

*-- Linhas 460 a 654:
460:             .TabIndex  = 7
461:             .Visible   = .T.
462:         ENDWITH
463:         BINDEVENT(THIS.chk_4c_Saldo1, "Valid", THIS, "ValidSaldo1")
464:         BINDEVENT(THIS.chk_4c_Saldo2, "Valid", THIS, "ValidSaldo2")
465: 
466:         *-- Label Valor
467:         THIS.AddObject("lbl_4c_Valor", "Label")
468:         WITH THIS.lbl_4c_Valor
469:             .AutoSize  = .T.
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .Caption   = "Valor :"
473:             .Left      = 181
474:             .Top       = 285
475:             .ForeColor = RGB(90, 90, 90)
476:             .BackStyle = 0
477:             .Visible   = .T.
478:         ENDWITH
479: 
480:         *-- Shape agrupador de Valor
481:         THIS.AddObject("shp_4c_Valor", "Shape")
482:         WITH THIS.shp_4c_Valor
483:             .Top           = 295
484:             .Left          = 219
485:             .Height        = 94
486:             .Width         = 243
487:             .BackStyle     = 0
488:             .BorderWidth   = 1
489:             .SpecialEffect = 1
490:             .Visible       = .T.
491:         ENDWITH
492: 
493:         *-- ChkValor1: UEPS
494:         THIS.AddObject("chk_4c_Valor1", "CheckBox")
495:         WITH THIS.chk_4c_Valor1
496:             .AutoSize  = .T.
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .Alignment = 0
500:             .BackStyle = 0
501:             .Caption   = "UEPS"
502:             .Value     = 0
503:             .Left      = 223
504:             .Top       = 301
505:             .ForeColor = RGB(90, 90, 90)
506:             .TabIndex  = 8
507:             .Visible   = .T.
508:         ENDWITH
509:         BINDEVENT(THIS.chk_4c_Valor1, "Valid", THIS, "ValidValor1")
510: 
511:         *-- ChkValor2: PEPS (Value=1 = default)
512:         THIS.AddObject("chk_4c_Valor2", "CheckBox")
513:         WITH THIS.chk_4c_Valor2
514:             .AutoSize  = .T.
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .Alignment = 0
518:             .BackStyle = 0
519:             .Caption   = "PEPS"
520:             .Value     = 1
521:             .Left      = 223
522:             .Top       = 318
523:             .ForeColor = RGB(90, 90, 90)
524:             .TabIndex  = 9
525:             .Visible   = .T.
526:         ENDWITH
527:         BINDEVENT(THIS.chk_4c_Valor2, "Valid", THIS, "ValidValor2")
528: 
529:         *-- ChkValor3: Custo
530:         THIS.AddObject("chk_4c_Valor3", "CheckBox")
531:         WITH THIS.chk_4c_Valor3
532:             .AutoSize  = .T.
533:             .FontName  = "Tahoma"
534:             .FontSize  = 8
535:             .Alignment = 0
536:             .BackStyle = 0
537:             .Caption   = "Custo"
538:             .Value     = 0
539:             .Left      = 223
540:             .Top       = 335
541:             .ForeColor = RGB(90, 90, 90)
542:             .TabIndex  = 10
543:             .Visible   = .T.
544:         ENDWITH
545:         BINDEVENT(THIS.chk_4c_Valor3, "Valid", THIS, "ValidValor3")
546: 
547:         *-- ChkValor4: Custo Medio (visibilidade por acesso)
548:         THIS.AddObject("chk_4c_Valor4", "CheckBox")
549:         WITH THIS.chk_4c_Valor4
550:             .AutoSize  = .T.
551:             .FontName  = "Tahoma"
552:             .FontSize  = 8
553:             .Alignment = 0
554:             .BackStyle = 0
555:             .Caption   = "Custo M" + CHR(233) + "dio"
556:             .Value     = 0
557:             .Left      = 223
558:             .Top       = 352
559:             .ForeColor = RGB(90, 90, 90)
560:             .TabIndex  = 11
561:             .Visible   = .T.
562:         ENDWITH
563:         BINDEVENT(THIS.chk_4c_Valor4, "Valid", THIS, "ValidValor4")
564: 
565:         *-- ChkValor5: Venda (visibilidade por acesso)
566:         THIS.AddObject("chk_4c_Valor5", "CheckBox")
567:         WITH THIS.chk_4c_Valor5
568:             .AutoSize  = .T.
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .Alignment = 0
572:             .BackStyle = 0
573:             .Caption   = "Venda"
574:             .Value     = 0
575:             .Left      = 223
576:             .Top       = 369
577:             .ForeColor = RGB(90, 90, 90)
578:             .TabIndex  = 12
579:             .Visible   = .T.
580:         ENDWITH
581:         BINDEVENT(THIS.chk_4c_Valor5, "Valid", THIS, "ValidValor5")
582: 
583:         *-- Label Fator (Get_MoeFator)
584:         THIS.AddObject("lbl_4c_Fator", "Label")
585:         WITH THIS.lbl_4c_Fator
586:             .AutoSize  = .T.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .Caption   = "Fator :"
590:             .Left      = 179
591:             .Top       = 396
592:             .ForeColor = RGB(90, 90, 90)
593:             .BackStyle = 0
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         *-- Moeda Fator (Get_MoeFator) - codigo de moeda para fator manual
598:         THIS.AddObject("txt_4c_MoeFator", "TextBox")
599:         WITH THIS.txt_4c_MoeFator
600:             .FontName      = "Tahoma"
601:             .BorderStyle   = 1
602:             .Format        = "K!"
603:             .Height        = 25
604:             .Left          = 219
605:             .MaxLength     = 3
606:             .SpecialEffect = 1
607:             .TabIndex      = 13
608:             .Top           = 392
609:             .Width         = 37
610:             .ForeColor     = RGB(0, 0, 0)
611:             .Visible       = .T.
612:         ENDWITH
613:         BINDEVENT(THIS.txt_4c_MoeFator, "KeyPress", THIS, "TeclaMoeFator")
614:         BINDEVENT(THIS.txt_4c_MoeFator, "DblClick", THIS, "MoeFatorDblClick")
615: 
616:         *-- Valor Fator (Get_ValFator) - somente leitura, calculado
617:         THIS.AddObject("txt_4c_ValFator", "TextBox")
618:         WITH THIS.txt_4c_ValFator
619:             .FontName             = "Tahoma"
620:             .Alignment            = 1
621:             .BorderStyle          = 1
622:             .Value                = 0
623:             .Height               = 25
624:             .InputMask            = "999999.999"
625:             .Left                 = 258
626:             .MaxLength            = 10
627:             .SpecialEffect        = 1
628:             .TabIndex             = 14
629:             .Top                  = 392
630:             .Width                = 95
631:             .ForeColor            = RGB(0, 0, 0)
632:             .DisabledBackColor    = RGB(192, 192, 192)
633:             .DisabledForeColor    = RGB(192, 192, 192)
634:             .Enabled              = .F.
635:             .Visible              = .T.
636:         ENDWITH
637: 
638:         *-- Label Moeda de Conversao
639:         THIS.AddObject("lbl_4c_Moeda", "Label")
640:         WITH THIS.lbl_4c_Moeda
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .Caption   = "Moeda de Convers" + CHR(227) + "o :"
644:             .Height    = 15
645:             .Left      = 103
646:             .Top       = 424
647:             .Width     = 111
648:             .ForeColor = RGB(90, 90, 90)
649:             .BackStyle = 0
650:             .Visible   = .T.
651:         ENDWITH
652: 
653:         *-- Moeda de conversao - codigo (get_moeda)
654:         THIS.AddObject("txt_4c_Moeda", "TextBox")

*-- Linhas 671 a 1639:
671:             .BackColor     = RGB(255, 255, 255)
672:             .Visible       = .T.
673:         ENDWITH
674:         BINDEVENT(THIS.txt_4c_Moeda, "KeyPress", THIS, "TeclaMoeda")
675:         BINDEVENT(THIS.txt_4c_Moeda, "DblClick", THIS, "MoedaDblClick")
676: 
677:         *-- Moeda de conversao - descricao (get_moeda_desc)
678:         THIS.AddObject("txt_4c_MoedaDesc", "TextBox")
679:         WITH THIS.txt_4c_MoedaDesc
680:             .FontName      = "Tahoma"
681:             .FontSize      = 9
682:             .Alignment     = 0
683:             .BackStyle     = 1
684:             .BorderStyle   = 1
685:             .Format        = "!"
686:             .Height        = 25
687:             .Left          = 258
688:             .MaxLength     = 15
689:             .SpecialEffect = 1
690:             .TabIndex      = 16
691:             .Top           = 419
692:             .Width         = 95
693:             .ForeColor     = RGB(0, 0, 0)
694:             .BackColor     = RGB(255, 255, 255)
695:             .Visible       = .T.
696:         ENDWITH
697:         BINDEVENT(THIS.txt_4c_MoedaDesc, "When", THIS, "WhenMoedaDesc")
698:         BINDEVENT(THIS.txt_4c_MoedaDesc, "KeyPress", THIS, "TeclaMoedaDesc")
699:         BINDEVENT(THIS.txt_4c_MoedaDesc, "DblClick", THIS, "MoedaDescDblClick")
700: 
701:         *-- Label Retira ICMS
702:         THIS.AddObject("lbl_4c_ICMS", "Label")
703:         WITH THIS.lbl_4c_ICMS
704:             .AutoSize  = .T.
705:             .FontName  = "Tahoma"
706:             .FontSize  = 8
707:             .BackStyle = 0
708:             .Caption   = "Retira ICMS :"
709:             .Height    = 15
710:             .Left      = 148
711:             .Top       = 452
712:             .ForeColor = RGB(90, 90, 90)
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         *-- OptionGroup ICMS (Opt_ICMS): Value=2=Nao por default
717:         THIS.AddObject("opt_4c_ICMS", "OptionGroup")
718:         WITH THIS.opt_4c_ICMS
719:             .ButtonCount   = 2
720:             .BackStyle     = 0
721:             .BorderStyle   = 0
722:             .Value         = 2
723:             .Height        = 25
724:             .Left          = 216
725:             .SpecialEffect = 0
726:             .Top           = 448
727:             .Width         = 133
728:             .TabIndex      = 17
729:             .Visible       = .T.
730: 
731:             WITH .Buttons(1)
732:                 .BackStyle = 0
733:                 .Caption   = "Sim"
734:                 .Value     = 0
735:                 .Height    = 15
736:                 .Left      = 4
737:                 .Top       = 4
738:                 .Width     = 34
739:                 .AutoSize  = .T.
740:                 .ForeColor = RGB(90, 90, 90)
741:             ENDWITH
742: 
743:             WITH .Buttons(2)
744:                 .FontName  = "Tahoma"
745:                 .FontSize  = 8
746:                 .BackStyle = 0
747:                 .Caption   = "N" + CHR(227) + "o"
748:                 .Value     = 1
749:                 .Height    = 15
750:                 .Left      = 56
751:                 .Top       = 4
752:                 .Width     = 37
753:                 .AutoSize  = .T.
754:                 .ForeColor = RGB(90, 90, 90)
755:             ENDWITH
756:         ENDWITH
757:         BINDEVENT(THIS.opt_4c_ICMS, "InteractiveChange", THIS, "IcmsInteractiveChange")
758: 
759:         *-- Label Posicao
760:         THIS.AddObject("lbl_4c_Posicao", "Label")
761:         WITH THIS.lbl_4c_Posicao
762:             .AutoSize  = .T.
763:             .FontName  = "Tahoma"
764:             .FontSize  = 8
765:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o :"
766:             .Left      = 169
767:             .Top       = 476
768:             .ForeColor = RGB(90, 90, 90)
769:             .BackStyle = 0
770:             .Visible   = .T.
771:         ENDWITH
772: 
773:         *-- OptionGroup Posicao (OptPosicao): 1=Atual 2=Retroativa
774:         THIS.AddObject("opt_4c_Posicao", "OptionGroup")
775:         WITH THIS.opt_4c_Posicao
776:             .AutoSize      = .T.
777:             .ButtonCount   = 2
778:             .BackStyle     = 0
779:             .BorderStyle   = 0
780:             .Height        = 25
781:             .Left          = 216
782:             .SpecialEffect = 0
783:             .Top           = 472
784:             .Width         = 138
785:             .TabIndex      = 18
786:             .Value         = 1
787:             .Visible       = .T.
788: 
789:             WITH .Buttons(1)
790:                 .BackStyle = 0
791:                 .Caption   = "Atual"
792:                 .Left      = 5
793:                 .Top       = 5
794:                 .Width     = 43
795:                 .AutoSize  = .T.
796:                 .ForeColor = RGB(90, 90, 90)
797:             ENDWITH
798: 
799:             WITH .Buttons(2)
800:                 .FontName  = "Tahoma"
801:                 .FontSize  = 8
802:                 .BackStyle = 0
803:                 .Caption   = "Retroativa :"
804:                 .Left      = 57
805:                 .Top       = 5
806:                 .AutoSize  = .T.
807:                 .ForeColor = RGB(90, 90, 90)
808:             ENDWITH
809:         ENDWITH
810:         BINDEVENT(THIS.opt_4c_Posicao, "InteractiveChange", THIS, "PosicaoInteractiveChange")
811: 
812:         *-- Data do saldo retroativo (GetDataSaldo)
813:         THIS.AddObject("txt_4c_DataSaldo", "TextBox")
814:         WITH THIS.txt_4c_DataSaldo
815:             .FontName      = "Tahoma"
816:             .BorderStyle   = 1
817:             .Height        = 23
818:             .Left          = 360
819:             .MaxLength     = 10
820:             .SpecialEffect = 1
821:             .TabIndex      = 19
822:             .Top           = 474
823:             .Width         = 79
824:             .Enabled       = .F.
825:             .Visible       = .T.
826:         ENDWITH
827:     ENDPROC
828: 
829:     *--------------------------------------------------------------------------
830:     * LimparCampos - Inicializa valores dos filtros conforme valores default do legado
831:     *--------------------------------------------------------------------------
832:     PROCEDURE LimparCampos()
833:         LOCAL loc_cRazas, loc_cEmpAtual
834:         TRY
835:             loc_cEmpAtual = go_4c_Sistema.cCodEmpresa
836:             loc_cRazas    = ""
837: 
838:             IF USED("CrSigCdEmp")
839:                 IF SEEK(loc_cEmpAtual, "CrSigCdEmp", "CEmps")
840:                     loc_cRazas = CrSigCdEmp.Razas
841:                 ENDIF
842:             ENDIF
843: 
844:             THIS.txt_4c_CdEmpresa.Value  = loc_cEmpAtual
845:             THIS.txt_4c_DsEmpresa.Value  = loc_cRazas
846:             THIS.txt_4c_MoeFator.Value   = ""
847:             THIS.txt_4c_ValFator.Value   = 0
848:             THIS.txt_4c_Moeda.Value      = ""
849:             THIS.txt_4c_MoedaDesc.Value  = ""
850:             THIS.opt_4c_ICMS.Value       = 2
851:             THIS.opt_4c_Posicao.Value    = 1
852:             THIS.txt_4c_DataSaldo.Value  = DATE()
853:             THIS.txt_4c_DataSaldo.Enabled = .F.
854:             THIS.chk_4c_Inv1.Value       = 1
855:             THIS.chk_4c_Inv2.Value       = 0
856:             THIS.chk_4c_Inv3.Value       = 0
857:             THIS.chk_4c_Saldo1.Value     = 1
858:             THIS.chk_4c_Saldo2.Value     = 0
859:             THIS.chk_4c_Saldo1.Enabled   = .F.
860:             THIS.chk_4c_Saldo2.Enabled   = .F.
861:             THIS.chk_4c_Valor1.Value     = 0
862:             THIS.chk_4c_Valor2.Value     = 1
863:             THIS.chk_4c_Valor3.Value     = 0
864:             THIS.chk_4c_Valor4.Value     = 0
865:             THIS.chk_4c_Valor5.Value     = 0
866: 
867:             THIS.txt_4c_CdEmpresa.SetFocus
868: 
869:         CATCH TO loc_oErro
870:             MsgErro(loc_oErro.Message, "Erro")
871:         ENDTRY
872:     ENDPROC
873: 
874:     *--------------------------------------------------------------------------
875:     * ValidacaoEntrada - Valida campos obrigatorios antes de processar
876:     * Retorna .T. se ok, .F. se ha erro (posiciona foco no campo errado)
877:     *--------------------------------------------------------------------------
878:     PROTECTED PROCEDURE ValidacaoEntrada()
879:         LOCAL loc_lOk
880:         loc_lOk = .T.
881:         TRY
882:             IF EMPTY(THIS.txt_4c_CdEmpresa.Value)
883:                 MsgAviso("Empresa Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
884:                 THIS.txt_4c_CdEmpresa.SetFocus
885:                 loc_lOk = .F.
886:             ENDIF
887: 
888:             IF loc_lOk AND THIS.opt_4c_Posicao.Value = 2 AND EMPTY(THIS.txt_4c_DataSaldo.Value)
889:                 MsgAviso("Data de Refer" + CHR(234) + "ncia de Estoque Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
890:                 THIS.txt_4c_DataSaldo.SetFocus
891:                 loc_lOk = .F.
892:             ENDIF
893: 
894:             IF loc_lOk
895:                 IF THIS.chk_4c_Inv1.Value = 0 AND THIS.chk_4c_Inv2.Value = 0 AND THIS.chk_4c_Inv3.Value = 0
896:                     MsgAviso("Nenhum Tipo de Invent" + CHR(225) + "rio Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
897:                     THIS.chk_4c_Inv1.SetFocus
898:                     loc_lOk = .F.
899:                 ENDIF
900:             ENDIF
901: 
902:             IF loc_lOk
903:                 IF THIS.chk_4c_Valor1.Value = 0 AND THIS.chk_4c_Valor2.Value = 0 AND ;
904:                    THIS.chk_4c_Valor3.Value = 0 AND THIS.chk_4c_Valor4.Value = 0 AND ;
905:                    THIS.chk_4c_Valor5.Value = 0
906:                     MsgAviso("Nenhum Tipo de Valor Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
907:                     THIS.chk_4c_Valor1.SetFocus
908:                     loc_lOk = .F.
909:                 ENDIF
910:             ENDIF
911: 
912:         CATCH TO loc_oErro
913:             MsgErro(loc_oErro.Message, "Erro")
914:             loc_lOk = .F.
915:         ENDTRY
916:         RETURN loc_lOk
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * FormParaRelatorio - Transfere valores do form para as propriedades do BO
921:     *--------------------------------------------------------------------------
922:     PROCEDURE FormParaRelatorio()
923:         TRY
924:             IF VARTYPE(THIS.this_oRelatorio) = "O"
925:                 THIS.this_oRelatorio.this_cCdEmpresa  = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
926:                 THIS.this_oRelatorio.this_cDsEmpresa  = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
927:                 THIS.this_oRelatorio.this_nChkInv1    = THIS.chk_4c_Inv1.Value
928:                 THIS.this_oRelatorio.this_nChkInv2    = THIS.chk_4c_Inv2.Value
929:                 THIS.this_oRelatorio.this_nChkInv3    = THIS.chk_4c_Inv3.Value
930:                 THIS.this_oRelatorio.this_nChkSaldo1  = THIS.chk_4c_Saldo1.Value
931:                 THIS.this_oRelatorio.this_nChkSaldo2  = THIS.chk_4c_Saldo2.Value
932:                 THIS.this_oRelatorio.this_nChkValor1  = THIS.chk_4c_Valor1.Value
933:                 THIS.this_oRelatorio.this_nChkValor2  = THIS.chk_4c_Valor2.Value
934:                 THIS.this_oRelatorio.this_nChkValor3  = THIS.chk_4c_Valor3.Value
935:                 THIS.this_oRelatorio.this_nChkValor4  = THIS.chk_4c_Valor4.Value
936:                 THIS.this_oRelatorio.this_nChkValor5  = THIS.chk_4c_Valor5.Value
937:                 THIS.this_oRelatorio.this_cMoeFator   = ALLTRIM(THIS.txt_4c_MoeFator.Value)
938:                 THIS.this_oRelatorio.this_nValFator   = THIS.txt_4c_ValFator.Value
939:                 THIS.this_oRelatorio.this_cMoeda      = ALLTRIM(THIS.txt_4c_Moeda.Value)
940:                 THIS.this_oRelatorio.this_cMoedaDesc  = ALLTRIM(THIS.txt_4c_MoedaDesc.Value)
941:                 THIS.this_oRelatorio.this_nOptIcms    = THIS.opt_4c_ICMS.Value
942:                 THIS.this_oRelatorio.this_lImpIcms    = (THIS.opt_4c_ICMS.Value = 1)
943:                 THIS.this_oRelatorio.this_nOptPosicao = THIS.opt_4c_Posicao.Value
944:                 THIS.this_oRelatorio.this_dDataSaldo  = THIS.txt_4c_DataSaldo.Value
945:             ENDIF
946:         CATCH TO loc_oErro
947:             MsgErro(loc_oErro.Message, "Erro")
948:         ENDTRY
949:     ENDPROC
950: 
951:     *--------------------------------------------------------------------------
952:     * BtnVisualizarClick - Valida, transfere filtros ao BO e chama Visualizar
953:     *--------------------------------------------------------------------------
954:     PROCEDURE BtnVisualizarClick()
955:         TRY
956:             IF THIS.ValidacaoEntrada()
957:                 THIS.FormParaRelatorio()
958:                 IF !THIS.this_oRelatorio.Visualizar()
959:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
960:                 ENDIF
961:             ENDIF
962:         CATCH TO loc_oErro
963:             MsgErro(loc_oErro.Message + CHR(13) + ;
964:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
965:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
966:         ENDTRY
967:         IF VARTYPE(THIS) = "O"
968:             THIS.Refresh()
969:         ENDIF
970:     ENDPROC
971: 
972:     *--------------------------------------------------------------------------
973:     * BtnImprimirClick - Valida, transfere filtros ao BO e chama Imprimir
974:     *--------------------------------------------------------------------------
975:     PROCEDURE BtnImprimirClick()
976:         TRY
977:             IF THIS.ValidacaoEntrada()
978:                 THIS.FormParaRelatorio()
979:                 IF !THIS.this_oRelatorio.Imprimir()
980:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
981:                 ENDIF
982:             ENDIF
983:         CATCH TO loc_oErro
984:             MsgErro(loc_oErro.Message + CHR(13) + ;
985:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
986:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
987:         ENDTRY
988:         IF VARTYPE(THIS) = "O"
989:             THIS.Refresh()
990:         ENDIF
991:     ENDPROC
992: 
993:     *--------------------------------------------------------------------------
994:     * BtnGerarTxtClick - Valida, transfere filtros ao BO e gera TXT de inventario
995:     *   Equivalente ao Command1.Click do legado
996:     *--------------------------------------------------------------------------
997:     PROCEDURE BtnGerarTxtClick()
998:         TRY
999:             IF THIS.ValidacaoEntrada()
1000:                 THIS.FormParaRelatorio()
1001:                 IF !THIS.this_oRelatorio.GerarArquivoTXT(THIS.txt_4c_DataSaldo.Value)
1002:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1003:                 ENDIF
1004:             ENDIF
1005:         CATCH TO loc_oErro
1006:             MsgErro(loc_oErro.Message + CHR(13) + ;
1007:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1008:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1009:         ENDTRY
1010:         IF VARTYPE(THIS) = "O"
1011:             THIS.Refresh()
1012:         ENDIF
1013:     ENDPROC
1014: 
1015:     *--------------------------------------------------------------------------
1016:     * BtnSairClick - Fecha o formulario
1017:     *--------------------------------------------------------------------------
1018:     PROCEDURE BtnSairClick()
1019:         THIS.Release()
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * EVENTOS DOS CONTROLES
1024:     *==========================================================================
1025: 
1026:     *-- Valid de CdEmpresa: valida empresa digitada e preenche descricao
1027:     PROCEDURE ValidCdEmpresa()
1028:         LOCAL loc_lOk, loc_cCod
1029:         loc_lOk  = .T.
1030:         loc_cCod = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
1031:         TRY
1032:             IF !EMPTY(loc_cCod)
1033:                 IF USED("CrSigCdEmp") AND SEEK(loc_cCod, "CrSigCdEmp", "CEmps")
1034:                     THIS.txt_4c_DsEmpresa.Value = CrSigCdEmp.Razas
1035:                     THIS.txt_4c_DsEmpresa.Refresh()
1036:                 ELSE
1037:                     THIS.txt_4c_DsEmpresa.Value = ""
1038:                     THIS.txt_4c_DsEmpresa.Refresh()
1039:                 ENDIF
1040:             ENDIF
1041:         CATCH TO loc_oErro
1042:             MsgErro(loc_oErro.Message, "Erro")
1043:             loc_lOk = .F.
1044:         ENDTRY
1045:         RETURN loc_lOk
1046:     ENDPROC
1047: 
1048:     *-- When de DsEmpresa: editavel apenas quando CdEmpresa estiver vazio
1049:     PROCEDURE WhenDsEmpresa()
1050:         RETURN EMPTY(THIS.txt_4c_CdEmpresa.Value)
1051:     ENDPROC
1052: 
1053:     *-- Valid de MoeFator: busca cotacao da moeda digitada
1054:     PROCEDURE ValidMoeFator()
1055:         LOCAL loc_lOk, loc_dData, loc_nValFat
1056:         loc_lOk    = .T.
1057:         loc_nValFat = 0
1058:         TRY
1059:             IF EMPTY(THIS.txt_4c_MoeFator.Value)
1060:                 THIS.txt_4c_ValFator.Value = 0
1061:                 THIS.txt_4c_ValFator.Refresh()
1062:             ELSE
1063:                 loc_dData = IIF(THIS.opt_4c_Posicao.Value = 1, DATE(), THIS.txt_4c_DataSaldo.Value)
1064: 
1065:                 IF VARTYPE(THIS.this_oRelatorio) = "O"
1066:                     loc_nValFat = THIS.this_oRelatorio.CarregarCambio(ALLTRIM(THIS.txt_4c_MoeFator.Value), loc_dData)
1067:                 ENDIF
1068: 
1069:                 IF loc_nValFat = 0
1070:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Aviso")
1071:                     THIS.txt_4c_MoeFator.Value = ""
1072:                     THIS.txt_4c_ValFator.Value = 0
1073:                 ELSE
1074:                     THIS.txt_4c_ValFator.Value = loc_nValFat
1075:                 ENDIF
1076:                 THIS.txt_4c_ValFator.Refresh()
1077:             ENDIF
1078:         CATCH TO loc_oErro
1079:             MsgErro(loc_oErro.Message, "Erro")
1080:             loc_lOk = .F.
1081:         ENDTRY
1082:         RETURN loc_lOk
1083:     ENDPROC
1084: 
1085:     *-- Valid de Moeda: busca moeda no TmpMoe (tem CMoes e DMoes indexados) e preenche descricao
1086:     PROCEDURE ValidMoeda()
1087:         LOCAL loc_lOk, loc_cMoe
1088:         loc_lOk  = .T.
1089:         loc_cMoe = ALLTRIM(THIS.txt_4c_Moeda.Value)
1090:         TRY
1091:             IF EMPTY(loc_cMoe)
1092:                 THIS.txt_4c_Moeda.Value     = ""
1093:                 THIS.txt_4c_MoedaDesc.Value = ""
1094:             ELSE
1095:                 IF USED("TmpMoe") AND SEEK(loc_cMoe, "TmpMoe", "CMoes")
1096:                     THIS.txt_4c_Moeda.Value     = TmpMoe.CMoes
1097:                     THIS.txt_4c_MoedaDesc.Value = TmpMoe.DMoes
1098:                 ELSE
1099:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Aviso")
1100:                     THIS.txt_4c_Moeda.Value     = ""
1101:                     THIS.txt_4c_MoedaDesc.Value = ""
1102:                 ENDIF
1103:             ENDIF
1104:             THIS.txt_4c_Moeda.Refresh()
1105:             THIS.txt_4c_MoedaDesc.Refresh()
1106:         CATCH TO loc_oErro
1107:             MsgErro(loc_oErro.Message, "Erro")
1108:             loc_lOk = .F.
1109:         ENDTRY
1110:         RETURN loc_lOk
1111:     ENDPROC
1112: 
1113:     *-- When de MoedaDesc: editavel apenas quando Moeda estiver vazio
1114:     PROCEDURE WhenMoedaDesc()
1115:         RETURN EMPTY(THIS.txt_4c_Moeda.Value)
1116:     ENDPROC
1117: 
1118:     *-- Valid de MoedaDesc: busca moeda pela descricao no TmpMoe (tem index DMoes)
1119:     PROCEDURE ValidMoedaDesc()
1120:         LOCAL loc_lOk, loc_cDesc
1121:         loc_lOk   = .T.
1122:         loc_cDesc = ALLTRIM(THIS.txt_4c_MoedaDesc.Value)
1123:         TRY
1124:             IF EMPTY(loc_cDesc)
1125:                 THIS.txt_4c_Moeda.Value     = ""
1126:                 THIS.txt_4c_MoedaDesc.Value = ""
1127:             ELSE
1128:                 IF USED("TmpMoe") AND SEEK(loc_cDesc, "TmpMoe", "DMoes")
1129:                     THIS.txt_4c_Moeda.Value     = TmpMoe.CMoes
1130:                     THIS.txt_4c_MoedaDesc.Value = TmpMoe.DMoes
1131:                 ELSE
1132:                     MsgAviso("Descri" + CHR(231) + CHR(227) + "o de moeda n" + CHR(227) + "o encontrada.", "Aviso")
1133:                     THIS.txt_4c_Moeda.Value     = ""
1134:                     THIS.txt_4c_MoedaDesc.Value = ""
1135:                 ENDIF
1136:             ENDIF
1137:             THIS.txt_4c_Moeda.Refresh()
1138:             THIS.txt_4c_MoedaDesc.Refresh()
1139:         CATCH TO loc_oErro
1140:             MsgErro(loc_oErro.Message, "Erro")
1141:             loc_lOk = .F.
1142:         ENDTRY
1143:         RETURN loc_lOk
1144:     ENDPROC
1145: 
1146:     *-- InteractiveChange de ICMS: atualiza flag lImpICMS no BO
1147:     PROCEDURE IcmsInteractiveChange()
1148:         TRY
1149:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1150:                 THIS.this_oRelatorio.this_lImpIcms = (THIS.opt_4c_ICMS.Value = 1)
1151:             ENDIF
1152:         CATCH TO loc_oErro
1153:             MsgErro(loc_oErro.Message, "Erro")
1154:         ENDTRY
1155:     ENDPROC
1156: 
1157:     *-- InteractiveChange de OptPosicao: habilita/desabilita campo de data
1158:     PROCEDURE PosicaoInteractiveChange()
1159:         TRY
1160:             IF THIS.opt_4c_Posicao.Value = 1
1161:                 THIS.txt_4c_DataSaldo.Value   = DATE()
1162:                 THIS.txt_4c_DataSaldo.Enabled = .F.
1163:             ELSE
1164:                 IF EMPTY(THIS.txt_4c_DataSaldo.Value)
1165:                     THIS.txt_4c_DataSaldo.Value = DATE()
1166:                 ENDIF
1167:                 THIS.txt_4c_DataSaldo.Enabled = .T.
1168:             ENDIF
1169:             THIS.txt_4c_DataSaldo.Refresh()
1170:             THIS.txt_4c_DataSaldo.SetFocus()
1171:         CATCH TO loc_oErro
1172:             MsgErro(loc_oErro.Message, "Erro")
1173:         ENDTRY
1174:     ENDPROC
1175: 
1176:     *-- Valid ChkSaldo1: mutuamente exclusivo com ChkSaldo2
1177:     PROCEDURE ValidSaldo1()
1178:         TRY
1179:             IF THIS.chk_4c_Saldo1.Value = 1
1180:                 THIS.chk_4c_Saldo2.Value = 0
1181:                 THIS.chk_4c_Saldo2.Refresh()
1182:             ENDIF
1183:         CATCH TO loc_oErro
1184:             MsgErro(loc_oErro.Message, "Erro")
1185:         ENDTRY
1186:         RETURN .T.
1187:     ENDPROC
1188: 
1189:     *-- Valid ChkSaldo2: mutuamente exclusivo com ChkSaldo1
1190:     PROCEDURE ValidSaldo2()
1191:         TRY
1192:             IF THIS.chk_4c_Saldo2.Value = 1
1193:                 THIS.chk_4c_Saldo1.Value = 0
1194:                 THIS.chk_4c_Saldo1.Refresh()
1195:             ENDIF
1196:         CATCH TO loc_oErro
1197:             MsgErro(loc_oErro.Message, "Erro")
1198:         ENDTRY
1199:         RETURN .T.
1200:     ENDPROC
1201: 
1202:     *-- Valid ChkValor1 (UEPS): exclusivo; desabilita opcoes de saldo
1203:     PROCEDURE ValidValor1()
1204:         TRY
1205:             IF THIS.chk_4c_Valor1.Value = 1
1206:                 THIS.chk_4c_Valor2.Value = 0
1207:                 THIS.chk_4c_Valor3.Value = 0
1208:                 THIS.chk_4c_Valor4.Value = 0
1209:                 THIS.chk_4c_Valor5.Value = 0
1210:                 THIS.chk_4c_Valor2.Refresh()
1211:                 THIS.chk_4c_Valor3.Refresh()
1212:                 THIS.chk_4c_Valor4.Refresh()
1213:                 THIS.chk_4c_Valor5.Refresh()
1214:                 THIS.chk_4c_Saldo1.Value   = 1
1215:                 THIS.chk_4c_Saldo2.Value   = 0
1216:                 THIS.chk_4c_Saldo1.Enabled = .F.
1217:                 THIS.chk_4c_Saldo2.Enabled = .F.
1218:                 THIS.chk_4c_Saldo1.Refresh()
1219:                 THIS.chk_4c_Saldo2.Refresh()
1220:             ELSE
1221:                 THIS.chk_4c_Valor1.Value = 1
1222:                 THIS.chk_4c_Valor1.Refresh()
1223:             ENDIF
1224:         CATCH TO loc_oErro
1225:             MsgErro(loc_oErro.Message, "Erro")
1226:         ENDTRY
1227:         RETURN .T.
1228:     ENDPROC
1229: 
1230:     *-- Valid ChkValor2 (PEPS): exclusivo; desabilita opcoes de saldo
1231:     PROCEDURE ValidValor2()
1232:         TRY
1233:             IF THIS.chk_4c_Valor2.Value = 1
1234:                 THIS.chk_4c_Valor1.Value = 0
1235:                 THIS.chk_4c_Valor3.Value = 0
1236:                 THIS.chk_4c_Valor4.Value = 0
1237:                 THIS.chk_4c_Valor5.Value = 0
1238:                 THIS.chk_4c_Valor1.Refresh()
1239:                 THIS.chk_4c_Valor3.Refresh()
1240:                 THIS.chk_4c_Valor4.Refresh()
1241:                 THIS.chk_4c_Valor5.Refresh()
1242:                 THIS.chk_4c_Saldo1.Value   = 1
1243:                 THIS.chk_4c_Saldo2.Value   = 0
1244:                 THIS.chk_4c_Saldo1.Enabled = .F.
1245:                 THIS.chk_4c_Saldo2.Enabled = .F.
1246:                 THIS.chk_4c_Saldo1.Refresh()
1247:                 THIS.chk_4c_Saldo2.Refresh()
1248:             ELSE
1249:                 THIS.chk_4c_Valor2.Value = 1
1250:                 THIS.chk_4c_Valor2.Refresh()
1251:             ENDIF
1252:         CATCH TO loc_oErro
1253:             MsgErro(loc_oErro.Message, "Erro")
1254:         ENDTRY
1255:         RETURN .T.
1256:     ENDPROC
1257: 
1258:     *-- Valid ChkValor3 (Custo): exclusivo; habilita opcoes de saldo
1259:     PROCEDURE ValidValor3()
1260:         TRY
1261:             IF THIS.chk_4c_Valor3.Value = 1
1262:                 THIS.chk_4c_Valor1.Value = 0
1263:                 THIS.chk_4c_Valor2.Value = 0
1264:                 THIS.chk_4c_Valor4.Value = 0
1265:                 THIS.chk_4c_Valor5.Value = 0
1266:                 THIS.chk_4c_Valor1.Refresh()
1267:                 THIS.chk_4c_Valor2.Refresh()
1268:                 THIS.chk_4c_Valor4.Refresh()
1269:                 THIS.chk_4c_Valor5.Refresh()
1270:                 THIS.chk_4c_Saldo1.Enabled = .T.
1271:                 THIS.chk_4c_Saldo2.Enabled = .T.
1272:                 THIS.chk_4c_Saldo1.Refresh()
1273:                 THIS.chk_4c_Saldo2.Refresh()
1274:             ELSE
1275:                 THIS.chk_4c_Valor3.Value = 1
1276:                 THIS.chk_4c_Valor3.Refresh()
1277:             ENDIF
1278:         CATCH TO loc_oErro
1279:             MsgErro(loc_oErro.Message, "Erro")
1280:         ENDTRY
1281:         RETURN .T.
1282:     ENDPROC
1283: 
1284:     *-- Valid ChkValor4 (Custo Medio): exclusivo; habilita opcoes de saldo
1285:     PROCEDURE ValidValor4()
1286:         TRY
1287:             IF THIS.chk_4c_Valor4.Value = 1
1288:                 THIS.chk_4c_Valor1.Value = 0
1289:                 THIS.chk_4c_Valor2.Value = 0
1290:                 THIS.chk_4c_Valor3.Value = 0
1291:                 THIS.chk_4c_Valor5.Value = 0
1292:                 THIS.chk_4c_Valor1.Refresh()
1293:                 THIS.chk_4c_Valor2.Refresh()
1294:                 THIS.chk_4c_Valor3.Refresh()
1295:                 THIS.chk_4c_Valor5.Refresh()
1296:                 THIS.chk_4c_Saldo1.Enabled = .T.
1297:                 THIS.chk_4c_Saldo2.Enabled = .T.
1298:                 THIS.chk_4c_Saldo1.Refresh()
1299:                 THIS.chk_4c_Saldo2.Refresh()
1300:             ELSE
1301:                 THIS.chk_4c_Valor4.Value = 1
1302:                 THIS.chk_4c_Valor4.Refresh()
1303:             ENDIF
1304:         CATCH TO loc_oErro
1305:             MsgErro(loc_oErro.Message, "Erro")
1306:         ENDTRY
1307:         RETURN .T.
1308:     ENDPROC
1309: 
1310:     *-- Valid ChkValor5 (Venda): exclusivo; habilita opcoes de saldo
1311:     PROCEDURE ValidValor5()
1312:         TRY
1313:             IF THIS.chk_4c_Valor5.Value = 1
1314:                 THIS.chk_4c_Valor1.Value = 0
1315:                 THIS.chk_4c_Valor2.Value = 0
1316:                 THIS.chk_4c_Valor3.Value = 0
1317:                 THIS.chk_4c_Valor4.Value = 0
1318:                 THIS.chk_4c_Valor1.Refresh()
1319:                 THIS.chk_4c_Valor2.Refresh()
1320:                 THIS.chk_4c_Valor3.Refresh()
1321:                 THIS.chk_4c_Valor4.Refresh()
1322:                 THIS.chk_4c_Saldo1.Enabled = .T.
1323:                 THIS.chk_4c_Saldo2.Enabled = .T.
1324:                 THIS.chk_4c_Saldo1.Refresh()
1325:                 THIS.chk_4c_Saldo2.Refresh()
1326:             ELSE
1327:                 THIS.chk_4c_Valor5.Value = 1
1328:                 THIS.chk_4c_Valor5.Refresh()
1329:             ENDIF
1330:         CATCH TO loc_oErro
1331:             MsgErro(loc_oErro.Message, "Erro")
1332:         ENDTRY
1333:         RETURN .T.
1334:     ENDPROC
1335: 
1336:     *-- KeyPress de CdEmpresa: F4=abre lookup, ENTER/TAB=valida
1337:     PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1338:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1339:             THIS.AbrirLookupEmpresa()
1340:         ELSE
1341:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1342:             THIS.ValidCdEmpresa()
1343:             ENDIF
1344:         ENDIF
1345:     ENDPROC
1346: 
1347:     *-- KeyPress de MoeFator: F4=abre lookup, ENTER/TAB=valida
1348:     PROCEDURE TeclaMoeFator(par_nKeyCode, par_nShiftAltCtrl)
1349:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1350:             THIS.AbrirLookupMoeFator()
1351:         ELSE
1352:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1353:             THIS.ValidMoeFator()
1354:             ENDIF
1355:         ENDIF
1356:     ENDPROC
1357: 
1358:     *-- KeyPress de Moeda: F4=abre lookup, ENTER/TAB=valida
1359:     PROCEDURE TeclaMoeda(par_nKeyCode, par_nShiftAltCtrl)
1360:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1361:             THIS.AbrirLookupMoeda()
1362:         ELSE
1363:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1364:             THIS.ValidMoeda()
1365:             ENDIF
1366:         ENDIF
1367:     ENDPROC
1368: 
1369:     *-- KeyPress de MoedaDesc: F4=abre lookup, ENTER/TAB=valida
1370:     PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
1371:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1372:             THIS.AbrirLookupMoedaDesc()
1373:         ELSE
1374:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1375:             THIS.ValidMoedaDesc()
1376:             ENDIF
1377:         ENDIF
1378:     ENDPROC
1379: 
1380:     *==========================================================================
1381:     * HANDLERS DblClick - DELEGAM PARA AbrirLookup*
1382:     *==========================================================================
1383: 
1384:     PROCEDURE EmpresaDblClick()
1385:         THIS.AbrirLookupEmpresa()
1386:     ENDPROC
1387: 
1388:     PROCEDURE MoedaDblClick()
1389:         THIS.AbrirLookupMoeda()
1390:     ENDPROC
1391: 
1392:     PROCEDURE MoedaDescDblClick()
1393:         THIS.AbrirLookupMoedaDesc()
1394:     ENDPROC
1395: 
1396:     PROCEDURE MoeFatorDblClick()
1397:         THIS.AbrirLookupMoeFator()
1398:     ENDPROC
1399: 
1400:     *==========================================================================
1401:     * METODOS DE LOOKUP (FormBuscaAuxiliar)
1402:     *==========================================================================
1403: 
1404:     *-- AbrirLookupEmpresa - Abre busca de empresas (SigCdEmp) via FormBuscaAuxiliar
1405:     PROCEDURE AbrirLookupEmpresa()
1406:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1407:         TRY
1408:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1409:                 "SigCdEmp", ;
1410:                 "cursor_4c_BuscaEmpresa", ;
1411:                 "CEmps", ;
1412:                 ALLTRIM(THIS.txt_4c_CdEmpresa.Value), ;
1413:                 "Buscar Empresa")
1414: 
1415:             loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
1416:             loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1417:             loc_oBusca.Show()
1418: 
1419:             IF loc_oBusca.this_lSelecionou
1420:                 IF USED("cursor_4c_BuscaEmpresa")
1421:                     SELECT cursor_4c_BuscaEmpresa
1422:                     loc_cCodigo    = ALLTRIM(CEmps)
1423:                     loc_cDescricao = ALLTRIM(Razas)
1424:                     THIS.txt_4c_CdEmpresa.Value = loc_cCodigo
1425:                     THIS.txt_4c_DsEmpresa.Value = loc_cDescricao
1426:                     THIS.txt_4c_CdEmpresa.Refresh()
1427:                     THIS.txt_4c_DsEmpresa.Refresh()
1428:                 ENDIF
1429:             ENDIF
1430: 
1431:             IF USED("cursor_4c_BuscaEmpresa")
1432:                 USE IN cursor_4c_BuscaEmpresa
1433:             ENDIF
1434:             loc_oBusca.Release()
1435: 
1436:         CATCH TO loc_oErro
1437:             MsgErro(loc_oErro.Message, "Erro")
1438:         ENDTRY
1439:     ENDPROC
1440: 
1441:     *-- AbrirLookupMoeda - Abre busca de moedas por codigo (SigCdMoe)
1442:     PROCEDURE AbrirLookupMoeda()
1443:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1444:         TRY
1445:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1446:                 "SigCdMoe", ;
1447:                 "cursor_4c_BuscaMoeda", ;
1448:                 "CMoes", ;
1449:                 ALLTRIM(THIS.txt_4c_Moeda.Value), ;
1450:                 "Buscar Moeda")
1451: 
1452:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1453:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1454:             loc_oBusca.Show()
1455: 
1456:             IF loc_oBusca.this_lSelecionou
1457:                 IF USED("cursor_4c_BuscaMoeda")
1458:                     SELECT cursor_4c_BuscaMoeda
1459:                     loc_cCodigo    = ALLTRIM(CMoes)
1460:                     loc_cDescricao = ALLTRIM(DMoes)
1461:                     THIS.txt_4c_Moeda.Value     = loc_cCodigo
1462:                     THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
1463:                     THIS.txt_4c_Moeda.Refresh()
1464:                     THIS.txt_4c_MoedaDesc.Refresh()
1465:                 ENDIF
1466:             ENDIF
1467: 
1468:             IF USED("cursor_4c_BuscaMoeda")
1469:                 USE IN cursor_4c_BuscaMoeda
1470:             ENDIF
1471:             loc_oBusca.Release()
1472: 
1473:         CATCH TO loc_oErro
1474:             MsgErro(loc_oErro.Message, "Erro")
1475:         ENDTRY
1476:     ENDPROC
1477: 
1478:     *-- AbrirLookupMoedaDesc - Abre busca de moedas por descricao (SigCdMoe)
1479:     PROCEDURE AbrirLookupMoedaDesc()
1480:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1481:         TRY
1482:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1483:                 "SigCdMoe", ;
1484:                 "cursor_4c_BuscaMoeDesc", ;
1485:                 "DMoes", ;
1486:                 ALLTRIM(THIS.txt_4c_MoedaDesc.Value), ;
1487:                 "Buscar Moeda")
1488: 
1489:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1490:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1491:             loc_oBusca.Show()
1492: 
1493:             IF loc_oBusca.this_lSelecionou
1494:                 IF USED("cursor_4c_BuscaMoeDesc")
1495:                     SELECT cursor_4c_BuscaMoeDesc
1496:                     loc_cCodigo    = ALLTRIM(CMoes)
1497:                     loc_cDescricao = ALLTRIM(DMoes)
1498:                     THIS.txt_4c_Moeda.Value     = loc_cCodigo
1499:                     THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
1500:                     THIS.txt_4c_Moeda.Refresh()
1501:                     THIS.txt_4c_MoedaDesc.Refresh()
1502:                 ENDIF
1503:             ENDIF
1504: 
1505:             IF USED("cursor_4c_BuscaMoeDesc")
1506:                 USE IN cursor_4c_BuscaMoeDesc
1507:             ENDIF
1508:             loc_oBusca.Release()
1509: 
1510:         CATCH TO loc_oErro
1511:             MsgErro(loc_oErro.Message, "Erro")
1512:         ENDTRY
1513:     ENDPROC
1514: 
1515:     *-- AbrirLookupMoeFator - Abre busca de moedas para fator de conversao (SigCdMoe)
1516:     *   Apos selecao, carrega cotacao via CarregarCambio() do BO
1517:     PROCEDURE AbrirLookupMoeFator()
1518:         LOCAL loc_oBusca, loc_cCodigo, loc_nValFat, loc_dData
1519:         TRY
1520:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1521:                 "SigCdMoe", ;
1522:                 "cursor_4c_BuscaMoeFat", ;
1523:                 "CMoes", ;
1524:                 ALLTRIM(THIS.txt_4c_MoeFator.Value), ;
1525:                 "Selecionar Moeda Fator")
1526: 
1527:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1528:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1529:             loc_oBusca.Show()
1530: 
1531:             IF loc_oBusca.this_lSelecionou
1532:                 IF USED("cursor_4c_BuscaMoeFat")
1533:                     SELECT cursor_4c_BuscaMoeFat
1534:                     loc_cCodigo = ALLTRIM(CMoes)
1535:                     THIS.txt_4c_MoeFator.Value = loc_cCodigo
1536:                     THIS.txt_4c_MoeFator.Refresh()
1537: 
1538:                     loc_dData = IIF(THIS.opt_4c_Posicao.Value = 1, DATE(), THIS.txt_4c_DataSaldo.Value)
1539:                     IF VARTYPE(THIS.this_oRelatorio) = "O"
1540:                         loc_nValFat = THIS.this_oRelatorio.CarregarCambio(loc_cCodigo, loc_dData)
1541:                         THIS.txt_4c_ValFator.Value = loc_nValFat
1542:                         THIS.txt_4c_ValFator.Refresh()
1543:                     ENDIF
1544:                 ENDIF
1545:             ENDIF
1546: 
1547:             IF USED("cursor_4c_BuscaMoeFat")
1548:                 USE IN cursor_4c_BuscaMoeFat
1549:             ENDIF
1550:             loc_oBusca.Release()
1551: 
1552:         CATCH TO loc_oErro
1553:             MsgErro(loc_oErro.Message, "Erro")
1554:         ENDTRY
1555:     ENDPROC
1556: 
1557:     *==========================================================================
1558:     * STUBS DE COMPATIBILIDADE COM PIPELINE FORMBASE
1559:     *==========================================================================
1560: 
1561:     PROTECTED PROCEDURE ConfigurarPageFrame()
1562:         RETURN
1563:     ENDPROC
1564: 
1565:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1566:         RETURN
1567:     ENDPROC
1568: 
1569:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1570:         RETURN
1571:     ENDPROC
1572: 
1573:     PROCEDURE AtualizarEstadoControles()
1574:         RETURN
1575:     ENDPROC
1576: 
1577:     PROCEDURE CarregarLista()
1578:         RETURN .T.
1579:     ENDPROC
1580: 
1581:     PROTECTED PROCEDURE FormParaBO()
1582:         RETURN
1583:     ENDPROC
1584: 
1585:     PROTECTED PROCEDURE BOParaForm()
1586:         RETURN
1587:     ENDPROC
1588: 
1589:     PROCEDURE HabilitarCampos(par_lHabilitar)
1590:         RETURN
1591:     ENDPROC
1592: 
1593:     PROCEDURE AlternarPagina(par_nPagina)
1594:         RETURN
1595:     ENDPROC
1596: 
1597:     PROCEDURE BtnIncluirClick()
1598:         RETURN
1599:     ENDPROC
1600: 
1601:     PROCEDURE BtnAlterarClick()
1602:         RETURN
1603:     ENDPROC
1604: 
1605:     PROCEDURE BtnExcluirClick()
1606:         RETURN
1607:     ENDPROC
1608: 
1609:     PROCEDURE BtnBuscarClick()
1610:         RETURN
1611:     ENDPROC
1612: 
1613:     PROCEDURE BtnEncerrarClick()
1614:         THIS.BtnSairClick()
1615:     ENDPROC
1616: 
1617:     PROCEDURE BtnSalvarClick()
1618:         RETURN
1619:     ENDPROC
1620: 
1621:     PROCEDURE BtnCancelarClick()
1622:         THIS.Release()
1623:     ENDPROC
1624: 
1625:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1626:         RETURN
1627:     ENDPROC
1628: 
1629:     *--------------------------------------------------------------------------
1630:     * Destroy - Libera referencia ao BO
1631:     *--------------------------------------------------------------------------
1632:     PROCEDURE Destroy()
1633:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1634:             THIS.this_oRelatorio = .NULL.
1635:         ENDIF
1636:         DODEFAULT()
1637:     ENDPROC
1638: 
1639: ENDDEFINE

