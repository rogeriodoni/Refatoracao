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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReInv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1643 linhas total):

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

*-- Linhas 671 a 1643:
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
741:                 .Themes    = .F.
742:             ENDWITH
743: 
744:             WITH .Buttons(2)
745:                 .FontName  = "Tahoma"
746:                 .FontSize  = 8
747:                 .BackStyle = 0
748:                 .Caption   = "N" + CHR(227) + "o"
749:                 .Value     = 1
750:                 .Height    = 15
751:                 .Left      = 56
752:                 .Top       = 4
753:                 .Width     = 37
754:                 .AutoSize  = .T.
755:                 .ForeColor = RGB(90, 90, 90)
756:                 .Themes    = .F.
757:             ENDWITH
758:         ENDWITH
759:         BINDEVENT(THIS.opt_4c_ICMS, "InteractiveChange", THIS, "IcmsInteractiveChange")
760: 
761:         *-- Label Posicao
762:         THIS.AddObject("lbl_4c_Posicao", "Label")
763:         WITH THIS.lbl_4c_Posicao
764:             .AutoSize  = .T.
765:             .FontName  = "Tahoma"
766:             .FontSize  = 8
767:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o :"
768:             .Left      = 169
769:             .Top       = 476
770:             .ForeColor = RGB(90, 90, 90)
771:             .BackStyle = 0
772:             .Visible   = .T.
773:         ENDWITH
774: 
775:         *-- OptionGroup Posicao (OptPosicao): 1=Atual 2=Retroativa
776:         THIS.AddObject("opt_4c_Posicao", "OptionGroup")
777:         WITH THIS.opt_4c_Posicao
778:             .AutoSize      = .T.
779:             .ButtonCount   = 2
780:             .BackStyle     = 0
781:             .BorderStyle   = 0
782:             .Height        = 25
783:             .Left          = 216
784:             .SpecialEffect = 0
785:             .Top           = 472
786:             .Width         = 138
787:             .TabIndex      = 18
788:             .Value         = 1
789:             .Visible       = .T.
790: 
791:             WITH .Buttons(1)
792:                 .BackStyle = 0
793:                 .Caption   = "Atual"
794:                 .Left      = 5
795:                 .Top       = 5
796:                 .Width     = 43
797:                 .AutoSize  = .T.
798:                 .ForeColor = RGB(90, 90, 90)
799:                 .Themes    = .F.
800:             ENDWITH
801: 
802:             WITH .Buttons(2)
803:                 .FontName  = "Tahoma"
804:                 .FontSize  = 8
805:                 .BackStyle = 0
806:                 .Caption   = "Retroativa :"
807:                 .Left      = 57
808:                 .Top       = 5
809:                 .AutoSize  = .T.
810:                 .ForeColor = RGB(90, 90, 90)
811:                 .Themes    = .F.
812:             ENDWITH
813:         ENDWITH
814:         BINDEVENT(THIS.opt_4c_Posicao, "InteractiveChange", THIS, "PosicaoInteractiveChange")
815: 
816:         *-- Data do saldo retroativo (GetDataSaldo)
817:         THIS.AddObject("txt_4c_DataSaldo", "TextBox")
818:         WITH THIS.txt_4c_DataSaldo
819:             .FontName      = "Tahoma"
820:             .BorderStyle   = 1
821:             .Height        = 23
822:             .Left          = 360
823:             .MaxLength     = 10
824:             .SpecialEffect = 1
825:             .TabIndex      = 19
826:             .Top           = 474
827:             .Width         = 79
828:             .Enabled       = .F.
829:             .Visible       = .T.
830:         ENDWITH
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * LimparCampos - Inicializa valores dos filtros conforme valores default do legado
835:     *--------------------------------------------------------------------------
836:     PROCEDURE LimparCampos()
837:         LOCAL loc_cRazas, loc_cEmpAtual
838:         TRY
839:             loc_cEmpAtual = go_4c_Sistema.cCodEmpresa
840:             loc_cRazas    = ""
841: 
842:             IF USED("CrSigCdEmp")
843:                 IF SEEK(loc_cEmpAtual, "CrSigCdEmp", "CEmps")
844:                     loc_cRazas = CrSigCdEmp.Razas
845:                 ENDIF
846:             ENDIF
847: 
848:             THIS.txt_4c_CdEmpresa.Value  = loc_cEmpAtual
849:             THIS.txt_4c_DsEmpresa.Value  = loc_cRazas
850:             THIS.txt_4c_MoeFator.Value   = ""
851:             THIS.txt_4c_ValFator.Value   = 0
852:             THIS.txt_4c_Moeda.Value      = ""
853:             THIS.txt_4c_MoedaDesc.Value  = ""
854:             THIS.opt_4c_ICMS.Value       = 2
855:             THIS.opt_4c_Posicao.Value    = 1
856:             THIS.txt_4c_DataSaldo.Value  = DATE()
857:             THIS.txt_4c_DataSaldo.Enabled = .F.
858:             THIS.chk_4c_Inv1.Value       = 1
859:             THIS.chk_4c_Inv2.Value       = 0
860:             THIS.chk_4c_Inv3.Value       = 0
861:             THIS.chk_4c_Saldo1.Value     = 1
862:             THIS.chk_4c_Saldo2.Value     = 0
863:             THIS.chk_4c_Saldo1.Enabled   = .F.
864:             THIS.chk_4c_Saldo2.Enabled   = .F.
865:             THIS.chk_4c_Valor1.Value     = 0
866:             THIS.chk_4c_Valor2.Value     = 1
867:             THIS.chk_4c_Valor3.Value     = 0
868:             THIS.chk_4c_Valor4.Value     = 0
869:             THIS.chk_4c_Valor5.Value     = 0
870: 
871:             THIS.txt_4c_CdEmpresa.SetFocus
872: 
873:         CATCH TO loc_oErro
874:             MsgErro(loc_oErro.Message, "Erro")
875:         ENDTRY
876:     ENDPROC
877: 
878:     *--------------------------------------------------------------------------
879:     * ValidacaoEntrada - Valida campos obrigatorios antes de processar
880:     * Retorna .T. se ok, .F. se ha erro (posiciona foco no campo errado)
881:     *--------------------------------------------------------------------------
882:     PROTECTED PROCEDURE ValidacaoEntrada()
883:         LOCAL loc_lOk
884:         loc_lOk = .T.
885:         TRY
886:             IF EMPTY(THIS.txt_4c_CdEmpresa.Value)
887:                 MsgAviso("Empresa Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
888:                 THIS.txt_4c_CdEmpresa.SetFocus
889:                 loc_lOk = .F.
890:             ENDIF
891: 
892:             IF loc_lOk AND THIS.opt_4c_Posicao.Value = 2 AND EMPTY(THIS.txt_4c_DataSaldo.Value)
893:                 MsgAviso("Data de Refer" + CHR(234) + "ncia de Estoque Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
894:                 THIS.txt_4c_DataSaldo.SetFocus
895:                 loc_lOk = .F.
896:             ENDIF
897: 
898:             IF loc_lOk
899:                 IF THIS.chk_4c_Inv1.Value = 0 AND THIS.chk_4c_Inv2.Value = 0 AND THIS.chk_4c_Inv3.Value = 0
900:                     MsgAviso("Nenhum Tipo de Invent" + CHR(225) + "rio Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
901:                     THIS.chk_4c_Inv1.SetFocus
902:                     loc_lOk = .F.
903:                 ENDIF
904:             ENDIF
905: 
906:             IF loc_lOk
907:                 IF THIS.chk_4c_Valor1.Value = 0 AND THIS.chk_4c_Valor2.Value = 0 AND ;
908:                    THIS.chk_4c_Valor3.Value = 0 AND THIS.chk_4c_Valor4.Value = 0 AND ;
909:                    THIS.chk_4c_Valor5.Value = 0
910:                     MsgAviso("Nenhum Tipo de Valor Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
911:                     THIS.chk_4c_Valor1.SetFocus
912:                     loc_lOk = .F.
913:                 ENDIF
914:             ENDIF
915: 
916:         CATCH TO loc_oErro
917:             MsgErro(loc_oErro.Message, "Erro")
918:             loc_lOk = .F.
919:         ENDTRY
920:         RETURN loc_lOk
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * FormParaRelatorio - Transfere valores do form para as propriedades do BO
925:     *--------------------------------------------------------------------------
926:     PROCEDURE FormParaRelatorio()
927:         TRY
928:             IF VARTYPE(THIS.this_oRelatorio) = "O"
929:                 THIS.this_oRelatorio.this_cCdEmpresa  = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
930:                 THIS.this_oRelatorio.this_cDsEmpresa  = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
931:                 THIS.this_oRelatorio.this_nChkInv1    = THIS.chk_4c_Inv1.Value
932:                 THIS.this_oRelatorio.this_nChkInv2    = THIS.chk_4c_Inv2.Value
933:                 THIS.this_oRelatorio.this_nChkInv3    = THIS.chk_4c_Inv3.Value
934:                 THIS.this_oRelatorio.this_nChkSaldo1  = THIS.chk_4c_Saldo1.Value
935:                 THIS.this_oRelatorio.this_nChkSaldo2  = THIS.chk_4c_Saldo2.Value
936:                 THIS.this_oRelatorio.this_nChkValor1  = THIS.chk_4c_Valor1.Value
937:                 THIS.this_oRelatorio.this_nChkValor2  = THIS.chk_4c_Valor2.Value
938:                 THIS.this_oRelatorio.this_nChkValor3  = THIS.chk_4c_Valor3.Value
939:                 THIS.this_oRelatorio.this_nChkValor4  = THIS.chk_4c_Valor4.Value
940:                 THIS.this_oRelatorio.this_nChkValor5  = THIS.chk_4c_Valor5.Value
941:                 THIS.this_oRelatorio.this_cMoeFator   = ALLTRIM(THIS.txt_4c_MoeFator.Value)
942:                 THIS.this_oRelatorio.this_nValFator   = THIS.txt_4c_ValFator.Value
943:                 THIS.this_oRelatorio.this_cMoeda      = ALLTRIM(THIS.txt_4c_Moeda.Value)
944:                 THIS.this_oRelatorio.this_cMoedaDesc  = ALLTRIM(THIS.txt_4c_MoedaDesc.Value)
945:                 THIS.this_oRelatorio.this_nOptIcms    = THIS.opt_4c_ICMS.Value
946:                 THIS.this_oRelatorio.this_lImpIcms    = (THIS.opt_4c_ICMS.Value = 1)
947:                 THIS.this_oRelatorio.this_nOptPosicao = THIS.opt_4c_Posicao.Value
948:                 THIS.this_oRelatorio.this_dDataSaldo  = THIS.txt_4c_DataSaldo.Value
949:             ENDIF
950:         CATCH TO loc_oErro
951:             MsgErro(loc_oErro.Message, "Erro")
952:         ENDTRY
953:     ENDPROC
954: 
955:     *--------------------------------------------------------------------------
956:     * BtnVisualizarClick - Valida, transfere filtros ao BO e chama Visualizar
957:     *--------------------------------------------------------------------------
958:     PROCEDURE BtnVisualizarClick()
959:         TRY
960:             IF THIS.ValidacaoEntrada()
961:                 THIS.FormParaRelatorio()
962:                 IF !THIS.this_oRelatorio.Visualizar()
963:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
964:                 ENDIF
965:             ENDIF
966:         CATCH TO loc_oErro
967:             MsgErro(loc_oErro.Message + CHR(13) + ;
968:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
969:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
970:         ENDTRY
971:         IF VARTYPE(THIS) = "O"
972:             THIS.Refresh()
973:         ENDIF
974:     ENDPROC
975: 
976:     *--------------------------------------------------------------------------
977:     * BtnImprimirClick - Valida, transfere filtros ao BO e chama Imprimir
978:     *--------------------------------------------------------------------------
979:     PROCEDURE BtnImprimirClick()
980:         TRY
981:             IF THIS.ValidacaoEntrada()
982:                 THIS.FormParaRelatorio()
983:                 IF !THIS.this_oRelatorio.Imprimir()
984:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
985:                 ENDIF
986:             ENDIF
987:         CATCH TO loc_oErro
988:             MsgErro(loc_oErro.Message + CHR(13) + ;
989:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
990:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
991:         ENDTRY
992:         IF VARTYPE(THIS) = "O"
993:             THIS.Refresh()
994:         ENDIF
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     * BtnGerarTxtClick - Valida, transfere filtros ao BO e gera TXT de inventario
999:     *   Equivalente ao Command1.Click do legado
1000:     *--------------------------------------------------------------------------
1001:     PROCEDURE BtnGerarTxtClick()
1002:         TRY
1003:             IF THIS.ValidacaoEntrada()
1004:                 THIS.FormParaRelatorio()
1005:                 IF !THIS.this_oRelatorio.GerarArquivoTXT(THIS.txt_4c_DataSaldo.Value)
1006:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
1007:                 ENDIF
1008:             ENDIF
1009:         CATCH TO loc_oErro
1010:             MsgErro(loc_oErro.Message + CHR(13) + ;
1011:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1012:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
1013:         ENDTRY
1014:         IF VARTYPE(THIS) = "O"
1015:             THIS.Refresh()
1016:         ENDIF
1017:     ENDPROC
1018: 
1019:     *--------------------------------------------------------------------------
1020:     * BtnSairClick - Fecha o formulario
1021:     *--------------------------------------------------------------------------
1022:     PROCEDURE BtnSairClick()
1023:         THIS.Release()
1024:     ENDPROC
1025: 
1026:     *==========================================================================
1027:     * EVENTOS DOS CONTROLES
1028:     *==========================================================================
1029: 
1030:     *-- Valid de CdEmpresa: valida empresa digitada e preenche descricao
1031:     PROCEDURE ValidCdEmpresa()
1032:         LOCAL loc_lOk, loc_cCod
1033:         loc_lOk  = .T.
1034:         loc_cCod = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
1035:         TRY
1036:             IF !EMPTY(loc_cCod)
1037:                 IF USED("CrSigCdEmp") AND SEEK(loc_cCod, "CrSigCdEmp", "CEmps")
1038:                     THIS.txt_4c_DsEmpresa.Value = CrSigCdEmp.Razas
1039:                     THIS.txt_4c_DsEmpresa.Refresh()
1040:                 ELSE
1041:                     THIS.txt_4c_DsEmpresa.Value = ""
1042:                     THIS.txt_4c_DsEmpresa.Refresh()
1043:                 ENDIF
1044:             ENDIF
1045:         CATCH TO loc_oErro
1046:             MsgErro(loc_oErro.Message, "Erro")
1047:             loc_lOk = .F.
1048:         ENDTRY
1049:         RETURN loc_lOk
1050:     ENDPROC
1051: 
1052:     *-- When de DsEmpresa: editavel apenas quando CdEmpresa estiver vazio
1053:     PROCEDURE WhenDsEmpresa()
1054:         RETURN EMPTY(THIS.txt_4c_CdEmpresa.Value)
1055:     ENDPROC
1056: 
1057:     *-- Valid de MoeFator: busca cotacao da moeda digitada
1058:     PROCEDURE ValidMoeFator()
1059:         LOCAL loc_lOk, loc_dData, loc_nValFat
1060:         loc_lOk    = .T.
1061:         loc_nValFat = 0
1062:         TRY
1063:             IF EMPTY(THIS.txt_4c_MoeFator.Value)
1064:                 THIS.txt_4c_ValFator.Value = 0
1065:                 THIS.txt_4c_ValFator.Refresh()
1066:             ELSE
1067:                 loc_dData = IIF(THIS.opt_4c_Posicao.Value = 1, DATE(), THIS.txt_4c_DataSaldo.Value)
1068: 
1069:                 IF VARTYPE(THIS.this_oRelatorio) = "O"
1070:                     loc_nValFat = THIS.this_oRelatorio.CarregarCambio(ALLTRIM(THIS.txt_4c_MoeFator.Value), loc_dData)
1071:                 ENDIF
1072: 
1073:                 IF loc_nValFat = 0
1074:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Aviso")
1075:                     THIS.txt_4c_MoeFator.Value = ""
1076:                     THIS.txt_4c_ValFator.Value = 0
1077:                 ELSE
1078:                     THIS.txt_4c_ValFator.Value = loc_nValFat
1079:                 ENDIF
1080:                 THIS.txt_4c_ValFator.Refresh()
1081:             ENDIF
1082:         CATCH TO loc_oErro
1083:             MsgErro(loc_oErro.Message, "Erro")
1084:             loc_lOk = .F.
1085:         ENDTRY
1086:         RETURN loc_lOk
1087:     ENDPROC
1088: 
1089:     *-- Valid de Moeda: busca moeda no TmpMoe (tem CMoes e DMoes indexados) e preenche descricao
1090:     PROCEDURE ValidMoeda()
1091:         LOCAL loc_lOk, loc_cMoe
1092:         loc_lOk  = .T.
1093:         loc_cMoe = ALLTRIM(THIS.txt_4c_Moeda.Value)
1094:         TRY
1095:             IF EMPTY(loc_cMoe)
1096:                 THIS.txt_4c_Moeda.Value     = ""
1097:                 THIS.txt_4c_MoedaDesc.Value = ""
1098:             ELSE
1099:                 IF USED("TmpMoe") AND SEEK(loc_cMoe, "TmpMoe", "CMoes")
1100:                     THIS.txt_4c_Moeda.Value     = TmpMoe.CMoes
1101:                     THIS.txt_4c_MoedaDesc.Value = TmpMoe.DMoes
1102:                 ELSE
1103:                     MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Aviso")
1104:                     THIS.txt_4c_Moeda.Value     = ""
1105:                     THIS.txt_4c_MoedaDesc.Value = ""
1106:                 ENDIF
1107:             ENDIF
1108:             THIS.txt_4c_Moeda.Refresh()
1109:             THIS.txt_4c_MoedaDesc.Refresh()
1110:         CATCH TO loc_oErro
1111:             MsgErro(loc_oErro.Message, "Erro")
1112:             loc_lOk = .F.
1113:         ENDTRY
1114:         RETURN loc_lOk
1115:     ENDPROC
1116: 
1117:     *-- When de MoedaDesc: editavel apenas quando Moeda estiver vazio
1118:     PROCEDURE WhenMoedaDesc()
1119:         RETURN EMPTY(THIS.txt_4c_Moeda.Value)
1120:     ENDPROC
1121: 
1122:     *-- Valid de MoedaDesc: busca moeda pela descricao no TmpMoe (tem index DMoes)
1123:     PROCEDURE ValidMoedaDesc()
1124:         LOCAL loc_lOk, loc_cDesc
1125:         loc_lOk   = .T.
1126:         loc_cDesc = ALLTRIM(THIS.txt_4c_MoedaDesc.Value)
1127:         TRY
1128:             IF EMPTY(loc_cDesc)
1129:                 THIS.txt_4c_Moeda.Value     = ""
1130:                 THIS.txt_4c_MoedaDesc.Value = ""
1131:             ELSE
1132:                 IF USED("TmpMoe") AND SEEK(loc_cDesc, "TmpMoe", "DMoes")
1133:                     THIS.txt_4c_Moeda.Value     = TmpMoe.CMoes
1134:                     THIS.txt_4c_MoedaDesc.Value = TmpMoe.DMoes
1135:                 ELSE
1136:                     MsgAviso("Descri" + CHR(231) + CHR(227) + "o de moeda n" + CHR(227) + "o encontrada.", "Aviso")
1137:                     THIS.txt_4c_Moeda.Value     = ""
1138:                     THIS.txt_4c_MoedaDesc.Value = ""
1139:                 ENDIF
1140:             ENDIF
1141:             THIS.txt_4c_Moeda.Refresh()
1142:             THIS.txt_4c_MoedaDesc.Refresh()
1143:         CATCH TO loc_oErro
1144:             MsgErro(loc_oErro.Message, "Erro")
1145:             loc_lOk = .F.
1146:         ENDTRY
1147:         RETURN loc_lOk
1148:     ENDPROC
1149: 
1150:     *-- InteractiveChange de ICMS: atualiza flag lImpICMS no BO
1151:     PROCEDURE IcmsInteractiveChange()
1152:         TRY
1153:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1154:                 THIS.this_oRelatorio.this_lImpIcms = (THIS.opt_4c_ICMS.Value = 1)
1155:             ENDIF
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message, "Erro")
1158:         ENDTRY
1159:     ENDPROC
1160: 
1161:     *-- InteractiveChange de OptPosicao: habilita/desabilita campo de data
1162:     PROCEDURE PosicaoInteractiveChange()
1163:         TRY
1164:             IF THIS.opt_4c_Posicao.Value = 1
1165:                 THIS.txt_4c_DataSaldo.Value   = DATE()
1166:                 THIS.txt_4c_DataSaldo.Enabled = .F.
1167:             ELSE
1168:                 IF EMPTY(THIS.txt_4c_DataSaldo.Value)
1169:                     THIS.txt_4c_DataSaldo.Value = DATE()
1170:                 ENDIF
1171:                 THIS.txt_4c_DataSaldo.Enabled = .T.
1172:             ENDIF
1173:             THIS.txt_4c_DataSaldo.Refresh()
1174:             THIS.txt_4c_DataSaldo.SetFocus()
1175:         CATCH TO loc_oErro
1176:             MsgErro(loc_oErro.Message, "Erro")
1177:         ENDTRY
1178:     ENDPROC
1179: 
1180:     *-- Valid ChkSaldo1: mutuamente exclusivo com ChkSaldo2
1181:     PROCEDURE ValidSaldo1()
1182:         TRY
1183:             IF THIS.chk_4c_Saldo1.Value = 1
1184:                 THIS.chk_4c_Saldo2.Value = 0
1185:                 THIS.chk_4c_Saldo2.Refresh()
1186:             ENDIF
1187:         CATCH TO loc_oErro
1188:             MsgErro(loc_oErro.Message, "Erro")
1189:         ENDTRY
1190:         RETURN .T.
1191:     ENDPROC
1192: 
1193:     *-- Valid ChkSaldo2: mutuamente exclusivo com ChkSaldo1
1194:     PROCEDURE ValidSaldo2()
1195:         TRY
1196:             IF THIS.chk_4c_Saldo2.Value = 1
1197:                 THIS.chk_4c_Saldo1.Value = 0
1198:                 THIS.chk_4c_Saldo1.Refresh()
1199:             ENDIF
1200:         CATCH TO loc_oErro
1201:             MsgErro(loc_oErro.Message, "Erro")
1202:         ENDTRY
1203:         RETURN .T.
1204:     ENDPROC
1205: 
1206:     *-- Valid ChkValor1 (UEPS): exclusivo; desabilita opcoes de saldo
1207:     PROCEDURE ValidValor1()
1208:         TRY
1209:             IF THIS.chk_4c_Valor1.Value = 1
1210:                 THIS.chk_4c_Valor2.Value = 0
1211:                 THIS.chk_4c_Valor3.Value = 0
1212:                 THIS.chk_4c_Valor4.Value = 0
1213:                 THIS.chk_4c_Valor5.Value = 0
1214:                 THIS.chk_4c_Valor2.Refresh()
1215:                 THIS.chk_4c_Valor3.Refresh()
1216:                 THIS.chk_4c_Valor4.Refresh()
1217:                 THIS.chk_4c_Valor5.Refresh()
1218:                 THIS.chk_4c_Saldo1.Value   = 1
1219:                 THIS.chk_4c_Saldo2.Value   = 0
1220:                 THIS.chk_4c_Saldo1.Enabled = .F.
1221:                 THIS.chk_4c_Saldo2.Enabled = .F.
1222:                 THIS.chk_4c_Saldo1.Refresh()
1223:                 THIS.chk_4c_Saldo2.Refresh()
1224:             ELSE
1225:                 THIS.chk_4c_Valor1.Value = 1
1226:                 THIS.chk_4c_Valor1.Refresh()
1227:             ENDIF
1228:         CATCH TO loc_oErro
1229:             MsgErro(loc_oErro.Message, "Erro")
1230:         ENDTRY
1231:         RETURN .T.
1232:     ENDPROC
1233: 
1234:     *-- Valid ChkValor2 (PEPS): exclusivo; desabilita opcoes de saldo
1235:     PROCEDURE ValidValor2()
1236:         TRY
1237:             IF THIS.chk_4c_Valor2.Value = 1
1238:                 THIS.chk_4c_Valor1.Value = 0
1239:                 THIS.chk_4c_Valor3.Value = 0
1240:                 THIS.chk_4c_Valor4.Value = 0
1241:                 THIS.chk_4c_Valor5.Value = 0
1242:                 THIS.chk_4c_Valor1.Refresh()
1243:                 THIS.chk_4c_Valor3.Refresh()
1244:                 THIS.chk_4c_Valor4.Refresh()
1245:                 THIS.chk_4c_Valor5.Refresh()
1246:                 THIS.chk_4c_Saldo1.Value   = 1
1247:                 THIS.chk_4c_Saldo2.Value   = 0
1248:                 THIS.chk_4c_Saldo1.Enabled = .F.
1249:                 THIS.chk_4c_Saldo2.Enabled = .F.
1250:                 THIS.chk_4c_Saldo1.Refresh()
1251:                 THIS.chk_4c_Saldo2.Refresh()
1252:             ELSE
1253:                 THIS.chk_4c_Valor2.Value = 1
1254:                 THIS.chk_4c_Valor2.Refresh()
1255:             ENDIF
1256:         CATCH TO loc_oErro
1257:             MsgErro(loc_oErro.Message, "Erro")
1258:         ENDTRY
1259:         RETURN .T.
1260:     ENDPROC
1261: 
1262:     *-- Valid ChkValor3 (Custo): exclusivo; habilita opcoes de saldo
1263:     PROCEDURE ValidValor3()
1264:         TRY
1265:             IF THIS.chk_4c_Valor3.Value = 1
1266:                 THIS.chk_4c_Valor1.Value = 0
1267:                 THIS.chk_4c_Valor2.Value = 0
1268:                 THIS.chk_4c_Valor4.Value = 0
1269:                 THIS.chk_4c_Valor5.Value = 0
1270:                 THIS.chk_4c_Valor1.Refresh()
1271:                 THIS.chk_4c_Valor2.Refresh()
1272:                 THIS.chk_4c_Valor4.Refresh()
1273:                 THIS.chk_4c_Valor5.Refresh()
1274:                 THIS.chk_4c_Saldo1.Enabled = .T.
1275:                 THIS.chk_4c_Saldo2.Enabled = .T.
1276:                 THIS.chk_4c_Saldo1.Refresh()
1277:                 THIS.chk_4c_Saldo2.Refresh()
1278:             ELSE
1279:                 THIS.chk_4c_Valor3.Value = 1
1280:                 THIS.chk_4c_Valor3.Refresh()
1281:             ENDIF
1282:         CATCH TO loc_oErro
1283:             MsgErro(loc_oErro.Message, "Erro")
1284:         ENDTRY
1285:         RETURN .T.
1286:     ENDPROC
1287: 
1288:     *-- Valid ChkValor4 (Custo Medio): exclusivo; habilita opcoes de saldo
1289:     PROCEDURE ValidValor4()
1290:         TRY
1291:             IF THIS.chk_4c_Valor4.Value = 1
1292:                 THIS.chk_4c_Valor1.Value = 0
1293:                 THIS.chk_4c_Valor2.Value = 0
1294:                 THIS.chk_4c_Valor3.Value = 0
1295:                 THIS.chk_4c_Valor5.Value = 0
1296:                 THIS.chk_4c_Valor1.Refresh()
1297:                 THIS.chk_4c_Valor2.Refresh()
1298:                 THIS.chk_4c_Valor3.Refresh()
1299:                 THIS.chk_4c_Valor5.Refresh()
1300:                 THIS.chk_4c_Saldo1.Enabled = .T.
1301:                 THIS.chk_4c_Saldo2.Enabled = .T.
1302:                 THIS.chk_4c_Saldo1.Refresh()
1303:                 THIS.chk_4c_Saldo2.Refresh()
1304:             ELSE
1305:                 THIS.chk_4c_Valor4.Value = 1
1306:                 THIS.chk_4c_Valor4.Refresh()
1307:             ENDIF
1308:         CATCH TO loc_oErro
1309:             MsgErro(loc_oErro.Message, "Erro")
1310:         ENDTRY
1311:         RETURN .T.
1312:     ENDPROC
1313: 
1314:     *-- Valid ChkValor5 (Venda): exclusivo; habilita opcoes de saldo
1315:     PROCEDURE ValidValor5()
1316:         TRY
1317:             IF THIS.chk_4c_Valor5.Value = 1
1318:                 THIS.chk_4c_Valor1.Value = 0
1319:                 THIS.chk_4c_Valor2.Value = 0
1320:                 THIS.chk_4c_Valor3.Value = 0
1321:                 THIS.chk_4c_Valor4.Value = 0
1322:                 THIS.chk_4c_Valor1.Refresh()
1323:                 THIS.chk_4c_Valor2.Refresh()
1324:                 THIS.chk_4c_Valor3.Refresh()
1325:                 THIS.chk_4c_Valor4.Refresh()
1326:                 THIS.chk_4c_Saldo1.Enabled = .T.
1327:                 THIS.chk_4c_Saldo2.Enabled = .T.
1328:                 THIS.chk_4c_Saldo1.Refresh()
1329:                 THIS.chk_4c_Saldo2.Refresh()
1330:             ELSE
1331:                 THIS.chk_4c_Valor5.Value = 1
1332:                 THIS.chk_4c_Valor5.Refresh()
1333:             ENDIF
1334:         CATCH TO loc_oErro
1335:             MsgErro(loc_oErro.Message, "Erro")
1336:         ENDTRY
1337:         RETURN .T.
1338:     ENDPROC
1339: 
1340:     *-- KeyPress de CdEmpresa: F4=abre lookup, ENTER/TAB=valida
1341:     PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1342:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1343:             THIS.AbrirLookupEmpresa()
1344:         ELSE
1345:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1346:             THIS.ValidCdEmpresa()
1347:             ENDIF
1348:         ENDIF
1349:     ENDPROC
1350: 
1351:     *-- KeyPress de MoeFator: F4=abre lookup, ENTER/TAB=valida
1352:     PROCEDURE TeclaMoeFator(par_nKeyCode, par_nShiftAltCtrl)
1353:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1354:             THIS.AbrirLookupMoeFator()
1355:         ELSE
1356:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1357:             THIS.ValidMoeFator()
1358:             ENDIF
1359:         ENDIF
1360:     ENDPROC
1361: 
1362:     *-- KeyPress de Moeda: F4=abre lookup, ENTER/TAB=valida
1363:     PROCEDURE TeclaMoeda(par_nKeyCode, par_nShiftAltCtrl)
1364:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1365:             THIS.AbrirLookupMoeda()
1366:         ELSE
1367:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1368:             THIS.ValidMoeda()
1369:             ENDIF
1370:         ENDIF
1371:     ENDPROC
1372: 
1373:     *-- KeyPress de MoedaDesc: F4=abre lookup, ENTER/TAB=valida
1374:     PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
1375:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1376:             THIS.AbrirLookupMoedaDesc()
1377:         ELSE
1378:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1379:             THIS.ValidMoedaDesc()
1380:             ENDIF
1381:         ENDIF
1382:     ENDPROC
1383: 
1384:     *==========================================================================
1385:     * HANDLERS DblClick - DELEGAM PARA AbrirLookup*
1386:     *==========================================================================
1387: 
1388:     PROCEDURE EmpresaDblClick()
1389:         THIS.AbrirLookupEmpresa()
1390:     ENDPROC
1391: 
1392:     PROCEDURE MoedaDblClick()
1393:         THIS.AbrirLookupMoeda()
1394:     ENDPROC
1395: 
1396:     PROCEDURE MoedaDescDblClick()
1397:         THIS.AbrirLookupMoedaDesc()
1398:     ENDPROC
1399: 
1400:     PROCEDURE MoeFatorDblClick()
1401:         THIS.AbrirLookupMoeFator()
1402:     ENDPROC
1403: 
1404:     *==========================================================================
1405:     * METODOS DE LOOKUP (FormBuscaAuxiliar)
1406:     *==========================================================================
1407: 
1408:     *-- AbrirLookupEmpresa - Abre busca de empresas (SigCdEmp) via FormBuscaAuxiliar
1409:     PROCEDURE AbrirLookupEmpresa()
1410:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1411:         TRY
1412:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1413:                 "SigCdEmp", ;
1414:                 "cursor_4c_BuscaEmpresa", ;
1415:                 "CEmps", ;
1416:                 ALLTRIM(THIS.txt_4c_CdEmpresa.Value), ;
1417:                 "Buscar Empresa")
1418: 
1419:             loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
1420:             loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1421:             loc_oBusca.Show()
1422: 
1423:             IF loc_oBusca.this_lSelecionou
1424:                 IF USED("cursor_4c_BuscaEmpresa")
1425:                     SELECT cursor_4c_BuscaEmpresa
1426:                     loc_cCodigo    = ALLTRIM(CEmps)
1427:                     loc_cDescricao = ALLTRIM(Razas)
1428:                     THIS.txt_4c_CdEmpresa.Value = loc_cCodigo
1429:                     THIS.txt_4c_DsEmpresa.Value = loc_cDescricao
1430:                     THIS.txt_4c_CdEmpresa.Refresh()
1431:                     THIS.txt_4c_DsEmpresa.Refresh()
1432:                 ENDIF
1433:             ENDIF
1434: 
1435:             IF USED("cursor_4c_BuscaEmpresa")
1436:                 USE IN cursor_4c_BuscaEmpresa
1437:             ENDIF
1438:             loc_oBusca.Release()
1439: 
1440:         CATCH TO loc_oErro
1441:             MsgErro(loc_oErro.Message, "Erro")
1442:         ENDTRY
1443:     ENDPROC
1444: 
1445:     *-- AbrirLookupMoeda - Abre busca de moedas por codigo (SigCdMoe)
1446:     PROCEDURE AbrirLookupMoeda()
1447:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1448:         TRY
1449:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1450:                 "SigCdMoe", ;
1451:                 "cursor_4c_BuscaMoeda", ;
1452:                 "CMoes", ;
1453:                 ALLTRIM(THIS.txt_4c_Moeda.Value), ;
1454:                 "Buscar Moeda")
1455: 
1456:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1457:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1458:             loc_oBusca.Show()
1459: 
1460:             IF loc_oBusca.this_lSelecionou
1461:                 IF USED("cursor_4c_BuscaMoeda")
1462:                     SELECT cursor_4c_BuscaMoeda
1463:                     loc_cCodigo    = ALLTRIM(CMoes)
1464:                     loc_cDescricao = ALLTRIM(DMoes)
1465:                     THIS.txt_4c_Moeda.Value     = loc_cCodigo
1466:                     THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
1467:                     THIS.txt_4c_Moeda.Refresh()
1468:                     THIS.txt_4c_MoedaDesc.Refresh()
1469:                 ENDIF
1470:             ENDIF
1471: 
1472:             IF USED("cursor_4c_BuscaMoeda")
1473:                 USE IN cursor_4c_BuscaMoeda
1474:             ENDIF
1475:             loc_oBusca.Release()
1476: 
1477:         CATCH TO loc_oErro
1478:             MsgErro(loc_oErro.Message, "Erro")
1479:         ENDTRY
1480:     ENDPROC
1481: 
1482:     *-- AbrirLookupMoedaDesc - Abre busca de moedas por descricao (SigCdMoe)
1483:     PROCEDURE AbrirLookupMoedaDesc()
1484:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1485:         TRY
1486:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1487:                 "SigCdMoe", ;
1488:                 "cursor_4c_BuscaMoeDesc", ;
1489:                 "DMoes", ;
1490:                 ALLTRIM(THIS.txt_4c_MoedaDesc.Value), ;
1491:                 "Buscar Moeda")
1492: 
1493:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1494:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1495:             loc_oBusca.Show()
1496: 
1497:             IF loc_oBusca.this_lSelecionou
1498:                 IF USED("cursor_4c_BuscaMoeDesc")
1499:                     SELECT cursor_4c_BuscaMoeDesc
1500:                     loc_cCodigo    = ALLTRIM(CMoes)
1501:                     loc_cDescricao = ALLTRIM(DMoes)
1502:                     THIS.txt_4c_Moeda.Value     = loc_cCodigo
1503:                     THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
1504:                     THIS.txt_4c_Moeda.Refresh()
1505:                     THIS.txt_4c_MoedaDesc.Refresh()
1506:                 ENDIF
1507:             ENDIF
1508: 
1509:             IF USED("cursor_4c_BuscaMoeDesc")
1510:                 USE IN cursor_4c_BuscaMoeDesc
1511:             ENDIF
1512:             loc_oBusca.Release()
1513: 
1514:         CATCH TO loc_oErro
1515:             MsgErro(loc_oErro.Message, "Erro")
1516:         ENDTRY
1517:     ENDPROC
1518: 
1519:     *-- AbrirLookupMoeFator - Abre busca de moedas para fator de conversao (SigCdMoe)
1520:     *   Apos selecao, carrega cotacao via CarregarCambio() do BO
1521:     PROCEDURE AbrirLookupMoeFator()
1522:         LOCAL loc_oBusca, loc_cCodigo, loc_nValFat, loc_dData
1523:         TRY
1524:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1525:                 "SigCdMoe", ;
1526:                 "cursor_4c_BuscaMoeFat", ;
1527:                 "CMoes", ;
1528:                 ALLTRIM(THIS.txt_4c_MoeFator.Value), ;
1529:                 "Selecionar Moeda Fator")
1530: 
1531:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1532:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1533:             loc_oBusca.Show()
1534: 
1535:             IF loc_oBusca.this_lSelecionou
1536:                 IF USED("cursor_4c_BuscaMoeFat")
1537:                     SELECT cursor_4c_BuscaMoeFat
1538:                     loc_cCodigo = ALLTRIM(CMoes)
1539:                     THIS.txt_4c_MoeFator.Value = loc_cCodigo
1540:                     THIS.txt_4c_MoeFator.Refresh()
1541: 
1542:                     loc_dData = IIF(THIS.opt_4c_Posicao.Value = 1, DATE(), THIS.txt_4c_DataSaldo.Value)
1543:                     IF VARTYPE(THIS.this_oRelatorio) = "O"
1544:                         loc_nValFat = THIS.this_oRelatorio.CarregarCambio(loc_cCodigo, loc_dData)
1545:                         THIS.txt_4c_ValFator.Value = loc_nValFat
1546:                         THIS.txt_4c_ValFator.Refresh()
1547:                     ENDIF
1548:                 ENDIF
1549:             ENDIF
1550: 
1551:             IF USED("cursor_4c_BuscaMoeFat")
1552:                 USE IN cursor_4c_BuscaMoeFat
1553:             ENDIF
1554:             loc_oBusca.Release()
1555: 
1556:         CATCH TO loc_oErro
1557:             MsgErro(loc_oErro.Message, "Erro")
1558:         ENDTRY
1559:     ENDPROC
1560: 
1561:     *==========================================================================
1562:     * STUBS DE COMPATIBILIDADE COM PIPELINE FORMBASE
1563:     *==========================================================================
1564: 
1565:     PROTECTED PROCEDURE ConfigurarPageFrame()
1566:         RETURN
1567:     ENDPROC
1568: 
1569:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1570:         RETURN
1571:     ENDPROC
1572: 
1573:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1574:         RETURN
1575:     ENDPROC
1576: 
1577:     PROCEDURE AtualizarEstadoControles()
1578:         RETURN
1579:     ENDPROC
1580: 
1581:     PROCEDURE CarregarLista()
1582:         RETURN .T.
1583:     ENDPROC
1584: 
1585:     PROTECTED PROCEDURE FormParaBO()
1586:         RETURN
1587:     ENDPROC
1588: 
1589:     PROTECTED PROCEDURE BOParaForm()
1590:         RETURN
1591:     ENDPROC
1592: 
1593:     PROCEDURE HabilitarCampos(par_lHabilitar)
1594:         RETURN
1595:     ENDPROC
1596: 
1597:     PROCEDURE AlternarPagina(par_nPagina)
1598:         RETURN
1599:     ENDPROC
1600: 
1601:     PROCEDURE BtnIncluirClick()
1602:         RETURN
1603:     ENDPROC
1604: 
1605:     PROCEDURE BtnAlterarClick()
1606:         RETURN
1607:     ENDPROC
1608: 
1609:     PROCEDURE BtnExcluirClick()
1610:         RETURN
1611:     ENDPROC
1612: 
1613:     PROCEDURE BtnBuscarClick()
1614:         RETURN
1615:     ENDPROC
1616: 
1617:     PROCEDURE BtnEncerrarClick()
1618:         THIS.BtnSairClick()
1619:     ENDPROC
1620: 
1621:     PROCEDURE BtnSalvarClick()
1622:         RETURN
1623:     ENDPROC
1624: 
1625:     PROCEDURE BtnCancelarClick()
1626:         THIS.Release()
1627:     ENDPROC
1628: 
1629:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1630:         RETURN
1631:     ENDPROC
1632: 
1633:     *--------------------------------------------------------------------------
1634:     * Destroy - Libera referencia ao BO
1635:     *--------------------------------------------------------------------------
1636:     PROCEDURE Destroy()
1637:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1638:             THIS.this_oRelatorio = .NULL.
1639:         ENDIF
1640:         DODEFAULT()
1641:     ENDPROC
1642: 
1643: ENDDEFINE

