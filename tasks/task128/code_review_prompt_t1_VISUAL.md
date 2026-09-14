# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 247: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2464 linhas total):

*-- Linhas 61 a 69:
61:         loc_lSucesso   = .F.
62:         loc_lContinuar = .T.
63:         TRY
64:             THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas"
65: 
66:             IF TYPE("gc_4c_CaminhoIcones") = "U"
67:                 gc_4c_CaminhoIcones = ""
68:             ENDIF
69:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 107 a 116:
107:                 THIS.ConfigurarPaginaDados2()
108:                 THIS.CarregarImpressoras()
109: 
110:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112: 
113:                 THIS.LimparCampos()
114:                 THIS.Visible = .T.
115:                 loc_lSucesso = .T.
116:             ENDIF

*-- Linhas 131 a 171:
131:     PROTECTED PROCEDURE ConfigurarCabecalho()
132:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH THIS.cnt_4c_Cabecalho
134:             .Top         = 0
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackStyle   = 1
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142: 
143:             *-- Sombra deslocada 2px (efeito 3D para o titulo branco)
144:             .AddObject("lbl_4c_Sombra", "Label")
145:             WITH .lbl_4c_Sombra
146:                 .Top       = 22
147:                 .Left      = 22
148:                 .Width     = THIS.Width
149:                 .Height    = 30
150:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
151:                 .FontName  = "Tahoma"
152:                 .FontSize  = 14
153:                 .FontBold  = .T.
154:                 .ForeColor = RGB(0, 0, 0)
155:                 .BackStyle = 0
156:                 .Visible   = .T.
157:             ENDWITH
158: 
159:             *-- Titulo em branco sobre a sombra
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .Top       = 20
163:                 .Left      = 20
164:                 .Width     = THIS.Width
165:                 .Height    = 30
166:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 14
169:                 .FontBold  = .T.
170:                 .ForeColor = RGB(255, 255, 255)
171:                 .BackStyle = 0

*-- Linhas 183 a 209:
183:     PROTECTED PROCEDURE ConfigurarBotoes()
184:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
185:         WITH THIS.cmg_4c_Botoes
186:             .Top           = 0
187:             .Left          = 509
188:             .Width         = 308
189:             .Height        = 80
190:             .ButtonCount   = 4
191:             .BackStyle     = 0
192:             .BorderStyle   = 0
193:             .BorderColor   = RGB(136, 189, 188)
194:             .SpecialEffect = 1
195:             .Themes        = .F.
196:             .Visible       = .T.
197: 
198:             *-- Visualizar - preview em tela (original: visualizacao())
199:             WITH .Buttons(1)
200:                 .Top             = 5
201:                 .Left            = 5
202:                 .Width           = 70
203:                 .Height          = 70
204:                 .Caption         = "Visualizar"
205:                 .FontBold        = .T.
206:                 .FontItalic      = .T.
207:                 .BackColor       = RGB(255, 255, 255)
208:                 .ForeColor       = RGB(90, 90, 90)
209:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 217 a 231:
217: 
218:             *-- Imprimir - impressora com dialogo (original: impressao())
219:             WITH .Buttons(2)
220:                 .Top             = 5
221:                 .Left            = 79
222:                 .Width           = 70
223:                 .Height          = 70
224:                 .Caption         = "Imprimir"
225:                 .FontName        = "Comic Sans MS"
226:                 .FontBold        = .T.
227:                 .FontItalic      = .T.
228:                 .FontSize        = 8
229:                 .BackColor       = RGB(255, 255, 255)
230:                 .ForeColor       = RGB(90, 90, 90)
231:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 239 a 253:
239: 
240:             *-- Imprimir Direto - sem dialogo (original: documento())
241:             WITH .Buttons(3)
242:                 .Top             = 5
243:                 .Left            = 153
244:                 .Width           = 70
245:                 .Height          = 70
246:                 .Caption         = "Impr. Direto"
247:                 .FontName        = "Comic Sans MS"
248:                 .FontBold        = .T.
249:                 .FontItalic      = .T.
250:                 .FontSize        = 8
251:                 .BackColor       = RGB(255, 255, 255)
252:                 .ForeColor       = RGB(90, 90, 90)
253:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 261 a 276:
261: 
262:             *-- Encerrar - fechar formulario (original: Sair)
263:             WITH .Buttons(4)
264:                 .Top             = 5
265:                 .Left            = 227
266:                 .Width           = 70
267:                 .Height          = 70
268:                 .Caption         = "Encerrar"
269:                 .Cancel          = .T.
270:                 .FontName        = "Comic Sans MS"
271:                 .FontBold        = .T.
272:                 .FontItalic      = .T.
273:                 .FontSize        = 8
274:                 .BackColor       = RGB(255, 255, 255)
275:                 .ForeColor       = RGB(90, 90, 90)
276:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 303 a 317:
303: 
304:         loc_oPgf.PageCount = 1
305: 
306:         loc_oPgf.Top    = 82
307:         loc_oPgf.Left   = -1
308:         loc_oPgf.Width  = THIS.Width + 2
309:         loc_oPgf.Height = THIS.Height - 82
310:         loc_oPgf.Tabs   = .F.
311: 
312:         loc_oPgf.Page1.Caption   = "Filtros"
313:         loc_oPgf.Page1.FontName  = "Tahoma"
314:         loc_oPgf.Page1.FontSize  = 8
315:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
316:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
317:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 396 a 404:
396:     *   Original grdOper: top=207, left=17, width=727, height=148, 6 colunas
397:     *   Original SelTudo: top=220, left=756, w=45, h=45
398:     *   Original apaga:   top=264, left=756, w=45, h=45
399:     *   Na Page1 (PageFrame.Top=82): top ajustado 207-82=125, 220-82=138, 264-82=182
400:     *--------------------------------------------------------------------------
401:     PROTECTED PROCEDURE ConfigurarPaginaLista()
402:         LOCAL loc_oPagina
403:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
404: 

*-- Linhas 424 a 442:
424: 
425:     *--------------------------------------------------------------------------
426:     * ConfigurarGridOperacoes - Grid com 6 colunas para selecao de operacoes
427:     *   CheckBox em Column1: AddObject -> Caption/Value -> CurrentControl -> ControlSource
428:     *--------------------------------------------------------------------------
429:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPage)
430:         LOCAL loc_oGrid
431: 
432:         par_oPage.AddObject("grd_4c_GrdOper", "Grid")
433:         loc_oGrid = par_oPage.grd_4c_GrdOper
434: 
435:         WITH loc_oGrid
436:             .Top                = 125
437:             .Left               = 17
438:             .Width              = 727
439:             .Height             = 148
440:             .ColumnCount        = 6
441:             .RecordSource       = "cursor_4c_Operacoes"
442:             .RecordMark         = .F.

*-- Linhas 453 a 561:
453:             .ScrollBars         = 2
454:             .RowHeight          = 16
455: 
456:             *-- Column1: Marcas (CheckBox) - ordem critica obrigatoria
457:             WITH .Column1
458:                 .Width     = 30
459:                 .Alignment = 2
460:                 .Sparse    = .F.
461:                 .AddObject("Check1", "CheckBox")
462:                 .Check1.Caption = ""
463:                 .Check1.Value   = 0
464:                 .Check1.Width   = 25
465:                 .Check1.Height  = 14
466:                 .CurrentControl  = "Check1"
467:                 .ControlSource   = "cursor_4c_Operacoes.Marcas"
468:                 .Header1.Caption = ""
469:             ENDWITH
470: 
471:             *-- Column2: Emps
472:             WITH .Column2
473:                 .Width           = 40
474:                 .ControlSource   = "cursor_4c_Operacoes.Emps"
475:                 .Header1.Caption = "Emp"
476:             ENDWITH
477: 
478:             *-- Column3: Dopes (Operacao)
479:             WITH .Column3
480:                 .Width           = 80
481:                 .ControlSource   = "cursor_4c_Operacoes.Dopes"
482:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
483:             ENDWITH
484: 
485:             *-- Column4: Numes (Codigo)
486:             WITH .Column4
487:                 .Width           = 70
488:                 .ControlSource   = "cursor_4c_Operacoes.Numes"
489:                 .Header1.Caption = CHR(67) + CHR(243) + "digo"
490:             ENDWITH
491: 
492:             *-- Column5: DescOrigs (Conta Origem)
493:             WITH .Column5
494:                 .Width           = 255
495:                 .ControlSource   = "cursor_4c_Operacoes.DescOrigs"
496:                 .Header1.Caption = "Origem"
497:             ENDWITH
498: 
499:             *-- Column6: DescDests (Conta Destino) - 30+40+80+70+255+252=727
500:             WITH .Column6
501:                 .Width           = 252
502:                 .ControlSource   = "cursor_4c_Operacoes.DescDests"
503:                 .Header1.Caption = "Destino"
504:             ENDWITH
505: 
506:             .Visible = .T.
507:         ENDWITH
508:     ENDPROC
509: 
510:     *--------------------------------------------------------------------------
511:     * ConfigurarBotoesSelecao - Botoes SelTudo e Apaga ao lado direito do grid
512:     *--------------------------------------------------------------------------
513:     PROTECTED PROCEDURE ConfigurarBotoesSelecao(par_oPage)
514:         *-- SelTudo: selecionar todos (original top=220, left=756, w=45, h=45 -> Page1: top=138)
515:         par_oPage.AddObject("cmd_4c_SelTudo", "CommandButton")
516:         WITH par_oPage.cmd_4c_SelTudo
517:             .Top           = 138
518:             .Left          = 756
519:             .Width         = 45
520:             .Height        = 45
521:             .Caption       = "Todos"
522:             .FontName      = "Tahoma"
523:             .FontBold      = .T.
524:             .FontSize      = 7
525:             .BackColor     = RGB(255, 255, 255)
526:             .ForeColor     = RGB(90, 90, 90)
527:             .SpecialEffect = 0
528:             .Themes        = .F.
529:             .MousePointer  = 15
530:             .WordWrap      = .T.
531:             .ToolTipText   = "Selecionar todos os registros"
532:             .Visible       = .T.
533:         ENDWITH
534:         BINDEVENT(par_oPage.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
535: 
536:         *-- Apaga: desmarcar todos (original top=264, left=756, w=45, h=45 -> Page1: top=182)
537:         par_oPage.AddObject("cmd_4c_Apaga", "CommandButton")
538:         WITH par_oPage.cmd_4c_Apaga
539:             .Top           = 182
540:             .Left          = 756
541:             .Width         = 45
542:             .Height        = 45
543:             .Caption       = "Nenhum"
544:             .FontName      = "Tahoma"
545:             .FontBold      = .T.
546:             .FontSize      = 7
547:             .BackColor     = RGB(255, 255, 255)
548:             .ForeColor     = RGB(90, 90, 90)
549:             .SpecialEffect = 0
550:             .Themes        = .F.
551:             .MousePointer  = 15
552:             .WordWrap      = .T.
553:             .ToolTipText   = "Desmarcar todos os registros"
554:             .Visible       = .T.
555:         ENDWITH
556:         BINDEVENT(par_oPage.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
557:     ENDPROC
558: 
559:     *--------------------------------------------------------------------------
560:     * CmdSelTudoClick - Marca todos os registros do grid (Marcas=1)
561:     *   Replica: Select tmpOper + Replace All tmpOper.marcas with 1

*-- Linhas 597 a 629:
597:     *   Controles: Say1, Get_codigo, Get_desc, lbl_dopes, get_nm_operacao,
598:     *              lbl_periodo, get_dt_inicial, lbl_periodo_a, get_dt_final,
599:     *              Say8, spn_qtdetiq, Say5, opt_conta
600:     *   Top ajustado: top_original - 82 (compensa PageFrame.Top=82)
601:     *--------------------------------------------------------------------------
602:     PROTECTED PROCEDURE ConfigurarPaginaDados()
603:         LOCAL loc_oPagina
604:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
605: 
606:         *-- Rotulo "Selecao :" (Say1: top=104, left=46)
607:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
608:         WITH loc_oPagina.lbl_4c_Label1
609:             .Top       = 22
610:             .Left      = 46
611:             .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .ForeColor = RGB(90, 90, 90)
615:             .BackStyle = 0
616:             .AutoSize  = .T.
617:             .Visible   = .T.
618:         ENDWITH
619: 
620:         *-- Campo Codigo (Get_codigo: top=100, left=97, width=66, maxlength=8)
621:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
622:         WITH loc_oPagina.txt_4c_Codigo
623:             .Top           = 18
624:             .Left          = 97
625:             .Width         = 66
626:             .Height        = 21
627:             .MaxLength     = 8
628:             .SpecialEffect = 1
629:             .FontName      = "Tahoma"

*-- Linhas 637 a 646:
637:         *-- Campo Descricao (Get_desc: top=100, left=165, width=220, maxlength=30)
638:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
639:         WITH loc_oPagina.txt_4c_Desc
640:             .Top           = 18
641:             .Left          = 165
642:             .Width         = 220
643:             .Height        = 21
644:             .MaxLength     = 30
645:             .SpecialEffect = 1
646:             .FontName      = "Tahoma"

*-- Linhas 652 a 679:
652:         BINDEVENT(loc_oPagina.txt_4c_Desc, "DblClick", THIS, "AbrirBuscaDesc")
653: 
654:         *-- Rotulo "Operacao :" (lbl_dopes: top=128, left=36)
655:         loc_oPagina.AddObject("lbl_4c_Lbl_dopes", "Label")
656:         WITH loc_oPagina.lbl_4c_Lbl_dopes
657:             .Top       = 46
658:             .Left      = 36
659:             .Width     = 56
660:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
661:             .FontName  = "Tahoma"
662:             .FontSize  = 8
663:             .ForeColor = RGB(90, 90, 90)
664:             .BackStyle = 0
665:             .AutoSize  = .T.
666:             .Visible   = .T.
667:         ENDWITH
668: 
669:         *-- Campo Operacao (get_nm_operacao: top=125, left=97, width=150)
670:         *   FontName=Courier New, FontSize=9, Format=K! (uppercase automatico)
671:         loc_oPagina.AddObject("txt_4c__nm_operacao", "TextBox")
672:         WITH loc_oPagina.txt_4c__nm_operacao
673:             .Top           = 43
674:             .Left          = 97
675:             .Width         = 150
676:             .Height        = 21
677:             .MaxLength     = 20
678:             .SpecialEffect = 1
679:             .FontName      = "Courier New"

*-- Linhas 687 a 745:
687:         BINDEVENT(loc_oPagina.txt_4c__nm_operacao, "KeyPress", THIS, "TxtNmOperacaoLostFocus")
688: 
689:         *-- Rotulo "Periodo :" (lbl_periodo: top=151, left=47)
690:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
691:         WITH loc_oPagina.lbl_4c_Lbl_periodo
692:             .Top       = 69
693:             .Left      = 47
694:             .Caption   = "Per" + CHR(237) + "odo :"
695:             .FontName  = "Tahoma"
696:             .FontSize  = 8
697:             .ForeColor = RGB(90, 90, 90)
698:             .BackStyle = 0
699:             .AutoSize  = .T.
700:             .Visible   = .T.
701:         ENDWITH
702: 
703:         *-- Data inicial (get_dt_inicial: top=148, left=97, width=80)
704:         *   Desabilitado ate que Operacao seja preenchida (When original)
705:         loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
706:         WITH loc_oPagina.txt_4c__dt_inicial
707:             .Top           = 66
708:             .Left          = 97
709:             .Width         = 80
710:             .Height        = 21
711:             .SpecialEffect = 1
712:             .FontName      = "Tahoma"
713:             .FontSize      = 8
714:             .Format        = "K"
715:             .Value         = {}
716:             .Enabled       = .F.
717:             .Visible       = .T.
718:         ENDWITH
719: 
720:         *-- Rotulo separador "a" (lbl_periodo_a: top=151, left=182)
721:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo_a", "Label")
722:         WITH loc_oPagina.lbl_4c_Lbl_periodo_a
723:             .Top       = 69
724:             .Left      = 182
725:             .Width     = 8
726:             .Caption   = CHR(224)
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .ForeColor = RGB(90, 90, 90)
730:             .BackStyle = 0
731:             .AutoSize  = .T.
732:             .Visible   = .T.
733:         ENDWITH
734: 
735:         *-- Data final (get_dt_final: top=148, left=194, width=80)
736:         *   Ao sair (ENTER/TAB): executa ValidarDtFinal que popula o grid
737:         loc_oPagina.AddObject("txt_4c__dt_final", "TextBox")
738:         WITH loc_oPagina.txt_4c__dt_final
739:             .Top           = 66
740:             .Left          = 194
741:             .Width         = 80
742:             .Height        = 21
743:             .SpecialEffect = 1
744:             .FontName      = "Tahoma"
745:             .FontSize      = 8

*-- Linhas 751 a 776:
751:         BINDEVENT(loc_oPagina.txt_4c__dt_final, "KeyPress", THIS, "TxtDtFinalKeyPress")
752: 
753:         *-- Rotulo "Qtd. copias :" (Say8: top=151, left=281, FontName=Verdana)
754:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
755:         WITH loc_oPagina.lbl_4c_Label8
756:             .Top       = 69
757:             .Left      = 281
758:             .Width     = 75
759:             .Caption   = "Qtd. c" + CHR(243) + "pias :"
760:             .FontName  = "Verdana"
761:             .FontSize  = 8
762:             .ForeColor = RGB(90, 90, 90)
763:             .BackStyle = 0
764:             .Visible   = .T.
765:         ENDWITH
766: 
767:         *-- Spinner quantidade de etiquetas (spn_qtdetiq: top=148, left=360, range 1..10)
768:         loc_oPagina.AddObject("obj_4c_Spn_qtdetiq", "Spinner")
769:         WITH loc_oPagina.obj_4c_Spn_qtdetiq
770:             .Top               = 66
771:             .Left              = 360
772:             .Width             = 53
773:             .Height            = 21
774:             .SpecialEffect     = 1
775:             .SpinnerHighValue  = 10
776:             .SpinnerLowValue   = 1

*-- Linhas 782 a 841:
782:         ENDWITH
783: 
784:         *-- Rotulo "Conta :" (Say5: top=176, left=54)
785:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
786:         WITH loc_oPagina.lbl_4c_Label5
787:             .Top       = 94
788:             .Left      = 54
789:             .Width     = 38
790:             .Caption   = "Conta :"
791:             .FontName  = "Tahoma"
792:             .FontSize  = 8
793:             .ForeColor = RGB(90, 90, 90)
794:             .BackStyle = 0
795:             .AutoSize  = .T.
796:             .Visible   = .T.
797:         ENDWITH
798: 
799:         *-- OptionGroup Conta (opt_conta: top=172, left=91, width=135, Value=2=Destino)
800:         *   Option1="Origem" (Value=0), Option2="Destino" (Value=1), grupo Value=2
801:         loc_oPagina.AddObject("obj_4c_Opt_conta", "OptionGroup")
802:         WITH loc_oPagina.obj_4c_Opt_conta
803:             .Top           = 90
804:             .Left          = 91
805:             .Width         = 135
806:             .Height        = 25
807:             .ButtonCount   = 2
808:             .BackStyle     = 0
809:             .BorderStyle   = 0
810:             .SpecialEffect = 1
811:             .Value         = 2
812:             .Enabled       = .F.
813: 
814:             WITH .Buttons(1)
815:                 .Caption   = "Origem"
816:                 .Value     = 0
817:                 .BackStyle = 0
818:                 .ForeColor = RGB(90, 90, 90)
819:                 .Height    = 15
820:                 .Left      = 5
821:                 .Top       = 5
822:                 .Width     = 52
823:                 .AutoSize  = .T.
824:                 .Themes    = .F.
825:             ENDWITH
826: 
827:             WITH .Buttons(2)
828:                 .Caption   = "Destino"
829:                 .Value     = 1
830:                 .FontName  = "Tahoma"
831:                 .FontSize  = 8
832:                 .BackStyle = 0
833:                 .ForeColor = RGB(90, 90, 90)
834:                 .Height    = 15
835:                 .Left      = 68
836:                 .Top       = 5
837:                 .Width     = 54
838:                 .AutoSize  = .T.
839:                 .Themes    = .F.
840:             ENDWITH
841: 

*-- Linhas 1180 a 1188:
1180:     * ValidarDtFinal - Executa SQL e popula grid com operacoes do periodo
1181:     *   Replica: get_dt_final.Valid do original
1182:     *   SQL: SigMvCab JOIN SigCdCli (b=ContaOs, c=ContaDs) com todos os campos
1183:     *   Cursor READWRITE (para marcacao via CheckBox no grid)
1184:     *   lnConta=1 -> usar dados de SigCdCli da Conta Origem (b.*)
1185:     *   lnConta=2 -> usar dados de SigCdCli da Conta Destino (c.*)
1186:     *--------------------------------------------------------------------------
1187:     PROCEDURE ValidarDtFinal()
1188:         LOCAL loc_oPg1, loc_cDopes, loc_dDataIni, loc_dDataFin

*-- Linhas 1276 a 1553:
1276:     *   Controles: Say2/Option/OpOrdem (ordenacao), OpColunas (modelo etiqueta),
1277:     *              Label3/Opt_Impressora (termica), Say4/OptPais, Say6/OptCodigo,
1278:     *              Say7/OptProper, Say9/OptContatos
1279:     *   Top ajustado: top_original - 82 (PageFrame.Top=82)
1280:     *--------------------------------------------------------------------------
1281:     PROTECTED PROCEDURE ConfigurarPaginaDados2()
1282:         LOCAL loc_oPagina
1283:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1284: 
1285:         *-- Rotulo "Ordenacao :" (Say2: top=363, left=18)
1286:         loc_oPagina.AddObject("lbl_4c_Say2", "Label")
1287:         WITH loc_oPagina.lbl_4c_Say2
1288:             .Top       = 281
1289:             .Left      = 18
1290:             .Width     = 76
1291:             .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
1292:             .FontName  = "Tahoma"
1293:             .FontSize  = 8
1294:             .ForeColor = RGB(90, 90, 90)
1295:             .BackStyle = 0
1296:             .AutoSize  = .T.
1297:             .Visible   = .T.
1298:         ENDWITH
1299: 
1300:         *-- OptionGroup tipo de ordenacao (Option: top=378, left=18, Value=2=CEP)
1301:         loc_oPagina.AddObject("obj_4c_Option", "OptionGroup")
1302:         WITH loc_oPagina.obj_4c_Option
1303:             .Top           = 296
1304:             .Left          = 18
1305:             .Width         = 102
1306:             .Height        = 64
1307:             .ButtonCount   = 3
1308:             .BackStyle     = 0
1309:             .SpecialEffect = 1
1310:             .BorderColor   = RGB(90, 90, 90)
1311:             .Value         = 2
1312: 
1313:             WITH .Buttons(1)
1314:                 .Caption   = "Alfab" + CHR(233) + "tica"
1315:                 .BackStyle = 0
1316:                 .ForeColor = RGB(90, 90, 90)
1317:                 .Height    = 15
1318:                 .Left      = 5
1319:                 .Top       = 23
1320:                 .Width     = 66
1321:                 .AutoSize  = .T.
1322:                 .Themes    = .F.
1323:             ENDWITH
1324: 
1325:             WITH .Buttons(2)
1326:                 .Caption   = "CEP"
1327:                 .Value     = 1
1328:                 .FontName  = "Tahoma"
1329:                 .FontSize  = 8
1330:                 .BackStyle = 0
1331:                 .ForeColor = RGB(90, 90, 90)
1332:                 .Height    = 15
1333:                 .Left      = 5
1334:                 .Top       = 6
1335:                 .Width     = 37
1336:                 .AutoSize  = .T.
1337:                 .Themes    = .F.
1338:             ENDWITH
1339: 
1340:             WITH .Buttons(3)
1341:                 .Caption   = "Data Nasc."
1342:                 .FontName  = "Tahoma"
1343:                 .FontSize  = 8
1344:                 .BackStyle = 0
1345:                 .ForeColor = RGB(90, 90, 90)
1346:                 .Height    = 15
1347:                 .Left      = 5
1348:                 .Top       = 42
1349:                 .Width     = 71
1350:                 .AutoSize  = .T.
1351:                 .Themes    = .F.
1352:             ENDWITH
1353: 
1354:             .Visible = .T.
1355:         ENDWITH
1356: 
1357:         *-- OptionGroup direcao de ordenacao (OpOrdem: top=451, left=18, Value=2=Descendente)
1358:         loc_oPagina.AddObject("obj_4c_OpOrdem", "OptionGroup")
1359:         WITH loc_oPagina.obj_4c_OpOrdem
1360:             .Top           = 369
1361:             .Left          = 18
1362:             .Width         = 102
1363:             .Height        = 83
1364:             .ButtonCount   = 2
1365:             .BackStyle     = 0
1366:             .SpecialEffect = 1
1367:             .BorderColor   = RGB(90, 90, 90)
1368:             .Value         = 2
1369: 
1370:             WITH .Buttons(1)
1371:                 .Caption   = "Ascendente"
1372:                 .BackStyle = 0
1373:                 .ForeColor = RGB(90, 90, 90)
1374:                 .Height    = 15
1375:                 .Left      = 5
1376:                 .Top       = 23
1377:                 .Width     = 75
1378:                 .AutoSize  = .T.
1379:                 .Themes    = .F.
1380:             ENDWITH
1381: 
1382:             WITH .Buttons(2)
1383:                 .Caption   = "Descendente"
1384:                 .Value     = 1
1385:                 .FontName  = "Tahoma"
1386:                 .FontSize  = 8
1387:                 .BackStyle = 0
1388:                 .ForeColor = RGB(90, 90, 90)
1389:                 .Height    = 15
1390:                 .Left      = 5
1391:                 .Top       = 6
1392:                 .Width     = 81
1393:                 .AutoSize  = .T.
1394:                 .Themes    = .F.
1395:             ENDWITH
1396: 
1397:             .Visible = .T.
1398:         ENDWITH
1399: 
1400:         *-- OptionGroup modelo de etiqueta (OpColunas: top=378, left=125, Value=2=2Colunas)
1401:         *   Valores: 1=3col-DN, 2=2col, 3=9lin, 4=9x3, 5=A4355, 6=2ColMarg, 7=Termica, 8=Pimaco6181, 9=TermicaZ
1402:         loc_oPagina.AddObject("obj_4c_OpColunas", "OptionGroup")
1403:         WITH loc_oPagina.obj_4c_OpColunas
1404:             .Top           = 296
1405:             .Left          = 125
1406:             .Width         = 100
1407:             .Height        = 156
1408:             .ButtonCount   = 9
1409:             .BackStyle     = 0
1410:             .SpecialEffect = 1
1411:             .BorderColor   = RGB(90, 90, 90)
1412:             .Value         = 2
1413: 
1414:             WITH .Buttons(1)
1415:                 .Caption   = "3 Colunas"
1416:                 .BackStyle = 0
1417:                 .ForeColor = RGB(90, 90, 90)
1418:                 .Height    = 15
1419:                 .Left      = 5
1420:                 .Top       = 22
1421:                 .Width     = 65
1422:                 .AutoSize  = .T.
1423:                 .Themes    = .F.
1424:             ENDWITH
1425: 
1426:             WITH .Buttons(2)
1427:                 .Caption   = "2 Colunas"
1428:                 .Value     = 1
1429:                 .FontName  = "Tahoma"
1430:                 .FontSize  = 8
1431:                 .BackStyle = 0
1432:                 .ForeColor = RGB(90, 90, 90)
1433:                 .Height    = 15
1434:                 .Left      = 5
1435:                 .Top       = 6
1436:                 .Width     = 65
1437:                 .AutoSize  = .T.
1438:                 .Themes    = .F.
1439:             ENDWITH
1440: 
1441:             WITH .Buttons(3)
1442:                 .Caption   = "9 Linhas"
1443:                 .FontName  = "Tahoma"
1444:                 .FontSize  = 8
1445:                 .BackStyle = 0
1446:                 .ForeColor = RGB(90, 90, 90)
1447:                 .Height    = 15
1448:                 .Left      = 5
1449:                 .Top       = 38
1450:                 .Width     = 57
1451:                 .AutoSize  = .T.
1452:                 .Themes    = .F.
1453:             ENDWITH
1454: 
1455:             WITH .Buttons(4)
1456:                 .Caption   = "9 x 3 "
1457:                 .FontName  = "Tahoma"
1458:                 .FontSize  = 8
1459:                 .BackStyle = 0
1460:                 .ForeColor = RGB(90, 90, 90)
1461:                 .Height    = 15
1462:                 .Left      = 5
1463:                 .Top       = 54
1464:                 .Width     = 45
1465:                 .AutoSize  = .T.
1466:                 .Themes    = .F.
1467:             ENDWITH
1468: 
1469:             WITH .Buttons(5)
1470:                 .Caption     = "A4355"
1471:                 .ToolTipText = "Etiqueta Pimaco A4355"
1472:                 .FontName    = "Tahoma"
1473:                 .FontSize    = 8
1474:                 .BackStyle   = 0
1475:                 .ForeColor   = RGB(90, 90, 90)
1476:                 .Height      = 15
1477:                 .Left        = 5
1478:                 .Top         = 70
1479:                 .Width       = 49
1480:                 .AutoSize    = .T.
1481:                 .Themes      = .F.
1482:             ENDWITH
1483: 
1484:             WITH .Buttons(6)
1485:                 .Caption   = "2 Cols-Marg "
1486:                 .FontName  = "Tahoma"
1487:                 .FontSize  = 8
1488:                 .BackStyle = 0
1489:                 .ForeColor = RGB(90, 90, 90)
1490:                 .Height    = 17
1491:                 .Left      = 5
1492:                 .Top       = 86
1493:                 .Width     = 89
1494:                 .AutoSize  = .T.
1495:                 .Themes    = .F.
1496:             ENDWITH
1497: 
1498:             WITH .Buttons(7)
1499:                 .Caption   = "T" + CHR(233) + "rmica"
1500:                 .FontName  = "Tahoma"
1501:                 .FontSize  = 8
1502:                 .BackStyle = 0
1503:                 .ForeColor = RGB(90, 90, 90)
1504:                 .Height    = 15
1505:                 .Left      = 5
1506:                 .Top       = 103
1507:                 .Width     = 55
1508:                 .AutoSize  = .T.
1509:                 .Themes    = .F.
1510:             ENDWITH
1511: 
1512:             WITH .Buttons(8)
1513:                 .Caption   = "Pimaco 6181"
1514:                 .FontName  = "Tahoma"
1515:                 .FontSize  = 8
1516:                 .BackStyle = 0
1517:                 .ForeColor = RGB(90, 90, 90)
1518:                 .Height    = 17
1519:                 .Left      = 5
1520:                 .Top       = 120
1521:                 .Width     = 90
1522:                 .AutoSize  = .T.
1523:                 .Themes    = .F.
1524:             ENDWITH
1525: 
1526:             WITH .Buttons(9)
1527:                 .Caption   = "T" + CHR(233) + "rmica Z"
1528:                 .FontName  = "Tahoma"
1529:                 .FontSize  = 8
1530:                 .BackStyle = 0
1531:                 .ForeColor = RGB(90, 90, 90)
1532:                 .Height    = 17
1533:                 .Left      = 5
1534:                 .Top       = 137
1535:                 .Width     = 85
1536:                 .AutoSize  = .T.
1537:                 .Themes    = .F.
1538:             ENDWITH
1539: 
1540:             .Visible = .T.
1541:         ENDWITH
1542: 
1543:         *-- Rotulo "Impressora" (Label3: top=364, left=228, FontBold)
1544:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
1545:         WITH loc_oPagina.lbl_4c_Label3
1546:             .Top       = 282
1547:             .Left      = 228
1548:             .Caption   = " Impressora "
1549:             .FontName  = "Tahoma"
1550:             .FontSize  = 8
1551:             .FontBold  = .T.
1552:             .ForeColor = RGB(90, 90, 90)
1553:             .BackStyle = 0

*-- Linhas 1559 a 1816:
1559:         *   ButtonCount=1 inicial; CarregarImpressoras expande dinamicamente
1560:         loc_oPagina.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1561:         WITH loc_oPagina.obj_4c_Opt_Impressora
1562:             .Top           = 296
1563:             .Left          = 230
1564:             .Width         = 215
1565:             .Height        = 156
1566:             .ButtonCount   = 1
1567:             .BackStyle     = 0
1568:             .SpecialEffect = 1
1569:             .BorderColor   = RGB(90, 90, 90)
1570:             .Value         = 1
1571: 
1572:             WITH .Buttons(1)
1573:                 .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1574:                 .Value     = 1
1575:                 .BackStyle = 0
1576:                 .ForeColor = RGB(90, 90, 90)
1577:                 .Height    = 16
1578:                 .Left      = 9
1579:                 .Top       = 10
1580:                 .Width     = 210
1581:                 .AutoSize  = .F.
1582:                 .Themes    = .F.
1583:             ENDWITH
1584: 
1585:             .Visible = .T.
1586:         ENDWITH
1587: 
1588:         *-- Rotulo "Imprimir Pais :" (Say4: top=424, left=595)
1589:         loc_oPagina.AddObject("lbl_4c_Say4", "Label")
1590:         WITH loc_oPagina.lbl_4c_Say4
1591:             .Top       = 342
1592:             .Left      = 595
1593:             .Width     = 69
1594:             .Caption   = "Imprimir Pa" + CHR(237) + "s :"
1595:             .FontName  = "Tahoma"
1596:             .FontSize  = 8
1597:             .ForeColor = RGB(90, 90, 90)
1598:             .BackStyle = 0
1599:             .AutoSize  = .T.
1600:             .Visible   = .T.
1601:         ENDWITH
1602: 
1603:         *-- OptionGroup Imprimir Pais (OptPais: top=419, left=669, Value=2=Nao)
1604:         loc_oPagina.AddObject("obj_4c_OptPais", "OptionGroup")
1605:         WITH loc_oPagina.obj_4c_OptPais
1606:             .Top           = 337
1607:             .Left          = 669
1608:             .Width         = 104
1609:             .Height        = 26
1610:             .ButtonCount   = 2
1611:             .BackStyle     = 0
1612:             .BorderStyle   = 0
1613:             .SpecialEffect = 0
1614:             .Value         = 2
1615: 
1616:             WITH .Buttons(1)
1617:                 .Caption   = "Sim"
1618:                 .BackStyle = 0
1619:                 .ForeColor = RGB(90, 90, 90)
1620:                 .Height    = 15
1621:                 .Left      = 5
1622:                 .Top       = 5
1623:                 .Width     = 34
1624:                 .AutoSize  = .T.
1625:                 .Themes    = .F.
1626:             ENDWITH
1627: 
1628:             WITH .Buttons(2)
1629:                 .Caption   = "N" + CHR(227) + "o"
1630:                 .Value     = 1
1631:                 .FontName  = "Tahoma"
1632:                 .FontSize  = 8
1633:                 .BackStyle = 0
1634:                 .ForeColor = RGB(90, 90, 90)
1635:                 .Height    = 15
1636:                 .Left      = 56
1637:                 .Top       = 5
1638:                 .Width     = 37
1639:                 .AutoSize  = .T.
1640:                 .Themes    = .F.
1641:             ENDWITH
1642: 
1643:             .Visible = .T.
1644:         ENDWITH
1645: 
1646:         *-- Rotulo "Imprimir Codigo :" (Say6: top=440, left=581)
1647:         loc_oPagina.AddObject("lbl_4c_Say6", "Label")
1648:         WITH loc_oPagina.lbl_4c_Say6
1649:             .Top       = 358
1650:             .Left      = 581
1651:             .Width     = 83
1652:             .Caption   = "Imprimir C" + CHR(243) + "digo :"
1653:             .FontName  = "Tahoma"
1654:             .FontSize  = 8
1655:             .ForeColor = RGB(90, 90, 90)
1656:             .BackStyle = 0
1657:             .AutoSize  = .T.
1658:             .Visible   = .T.
1659:         ENDWITH
1660: 
1661:         *-- OptionGroup Imprimir Codigo (OptCodigo: top=436, left=669, Value=1=Sim)
1662:         loc_oPagina.AddObject("obj_4c_OptCodigo", "OptionGroup")
1663:         WITH loc_oPagina.obj_4c_OptCodigo
1664:             .Top           = 354
1665:             .Left          = 669
1666:             .Width         = 104
1667:             .Height        = 26
1668:             .ButtonCount   = 2
1669:             .BackStyle     = 0
1670:             .BorderStyle   = 0
1671:             .SpecialEffect = 0
1672:             .Value         = 1
1673: 
1674:             WITH .Buttons(1)
1675:                 .Caption   = "Sim"
1676:                 .Value     = 1
1677:                 .BackStyle = 0
1678:                 .ForeColor = RGB(90, 90, 90)
1679:                 .Height    = 15
1680:                 .Left      = 5
1681:                 .Top       = 5
1682:                 .Width     = 34
1683:                 .AutoSize  = .T.
1684:                 .Themes    = .F.
1685:             ENDWITH
1686: 
1687:             WITH .Buttons(2)
1688:                 .Caption   = "N" + CHR(227) + "o"
1689:                 .FontName  = "Tahoma"
1690:                 .FontSize  = 8
1691:                 .BackStyle = 0
1692:                 .ForeColor = RGB(90, 90, 90)
1693:                 .Height    = 15
1694:                 .Left      = 56
1695:                 .Top       = 5
1696:                 .Width     = 37
1697:                 .AutoSize  = .T.
1698:                 .Themes    = .F.
1699:             ENDWITH
1700: 
1701:             .Visible = .T.
1702:         ENDWITH
1703: 
1704:         *-- Rotulo "Imprime Iniciais em Maiusculo :" (Say7: top=457, left=516)
1705:         loc_oPagina.AddObject("lbl_4c_Say7", "Label")
1706:         WITH loc_oPagina.lbl_4c_Say7
1707:             .Top       = 375
1708:             .Left      = 516
1709:             .Width     = 148
1710:             .Caption   = "Imprime Iniciais em Mai" + CHR(250) + "sculo :"
1711:             .FontName  = "Tahoma"
1712:             .FontSize  = 8
1713:             .ForeColor = RGB(90, 90, 90)
1714:             .BackStyle = 0
1715:             .AutoSize  = .T.
1716:             .Visible   = .T.
1717:         ENDWITH
1718: 
1719:         *-- OptionGroup Maiusculo/Proper (OptProper: top=452, left=669, Value=2=Nao)
1720:         loc_oPagina.AddObject("obj_4c_OptProper", "OptionGroup")
1721:         WITH loc_oPagina.obj_4c_OptProper
1722:             .Top           = 370
1723:             .Left          = 669
1724:             .Width         = 104
1725:             .Height        = 26
1726:             .ButtonCount   = 2
1727:             .BackStyle     = 0
1728:             .BorderStyle   = 0
1729:             .SpecialEffect = 0
1730:             .Value         = 2
1731: 
1732:             WITH .Buttons(1)
1733:                 .Caption   = "Sim"
1734:                 .BackStyle = 0
1735:                 .ForeColor = RGB(90, 90, 90)
1736:                 .Height    = 15
1737:                 .Left      = 5
1738:                 .Top       = 5
1739:                 .Width     = 34
1740:                 .AutoSize  = .T.
1741:                 .Themes    = .F.
1742:             ENDWITH
1743: 
1744:             WITH .Buttons(2)
1745:                 .Caption   = "N" + CHR(227) + "o"
1746:                 .Value     = 1
1747:                 .FontName  = "Tahoma"
1748:                 .FontSize  = 8
1749:                 .BackStyle = 0
1750:                 .ForeColor = RGB(90, 90, 90)
1751:                 .Height    = 15
1752:                 .Left      = 56
1753:                 .Top       = 5
1754:                 .Width     = 37
1755:                 .AutoSize  = .T.
1756:                 .Themes    = .F.
1757:             ENDWITH
1758: 
1759:             .Visible = .T.
1760:         ENDWITH
1761: 
1762:         *-- Rotulo "Usar Nome de Contato se Preenchido :" (Say9: top=476, left=476)
1763:         loc_oPagina.AddObject("lbl_4c_Say9", "Label")
1764:         WITH loc_oPagina.lbl_4c_Say9
1765:             .Top       = 394
1766:             .Left      = 476
1767:             .Width     = 188
1768:             .Caption   = "Usar Nome de Contato se Preenchido :"
1769:             .FontName  = "Tahoma"
1770:             .FontSize  = 8
1771:             .ForeColor = RGB(90, 90, 90)
1772:             .BackStyle = 0
1773:             .AutoSize  = .T.
1774:             .Visible   = .T.
1775:         ENDWITH
1776: 
1777:         *-- OptionGroup Usar Contato (OptContatos: top=471, left=669, Value=2=Nao)
1778:         loc_oPagina.AddObject("obj_4c_OptContatos", "OptionGroup")
1779:         WITH loc_oPagina.obj_4c_OptContatos
1780:             .Top           = 389
1781:             .Left          = 669
1782:             .Width         = 104
1783:             .Height        = 26
1784:             .ButtonCount   = 2
1785:             .BackStyle     = 0
1786:             .BorderStyle   = 0
1787:             .SpecialEffect = 0
1788:             .Value         = 2
1789: 
1790:             WITH .Buttons(1)
1791:                 .Caption   = "Sim"
1792:                 .BackStyle = 0
1793:                 .ForeColor = RGB(90, 90, 90)
1794:                 .Height    = 15
1795:                 .Left      = 5
1796:                 .Top       = 5
1797:                 .Width     = 34
1798:                 .AutoSize  = .T.
1799:                 .Themes    = .F.
1800:             ENDWITH
1801: 
1802:             WITH .Buttons(2)
1803:                 .Caption   = "N" + CHR(227) + "o"
1804:                 .Value     = 1
1805:                 .FontName  = "Tahoma"
1806:                 .FontSize  = 8
1807:                 .BackStyle = 0
1808:                 .ForeColor = RGB(90, 90, 90)
1809:                 .Height    = 15
1810:                 .Left      = 56
1811:                 .Top       = 5
1812:                 .Width     = 37
1813:                 .AutoSize  = .T.
1814:                 .Themes    = .F.
1815:             ENDWITH
1816: 

*-- Linhas 1932 a 1956:
1932:                     loc_lcI = ALLTRIM(STR(loc_nI))
1933:                     WITH loc_oOptImp.Buttons(loc_nI)
1934:                         .AutoSize  = .F.
1935:                         .Caption   = " \<" + loc_lcI + ". " + loc_laImpOk(loc_nI)
1936:                         .FontSize  = 8
1937:                         .ForeColor = RGB(36, 84, 155)
1938:                         .Tag       = UPPER(loc_laImpOk(loc_nI))
1939:                         .Top       = loc_nTop
1940:                         .Width     = 210
1941:                         .BackStyle = 0
1942:                     ENDWITH
1943:                     loc_nTop    = loc_nTop + 20
1944:                     loc_nHeight = loc_nHeight + 20
1945:                 ENDFOR
1946:             ELSE
1947:                 loc_oOptImp.ButtonCount = 1
1948:                 loc_nOk = ASCAN(loc_laPrinters, "GEN" + CHR(233) + "RICO/SOMENTE TEXTO")
1949:                 WITH loc_oOptImp.Buttons(1)
1950:                     .AutoSize  = .F.
1951:                     .Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
1952:                     .Enabled   = (loc_nOk <> 0)
1953:                     .FontSize  = 8
1954:                     .ForeColor = RGB(36, 84, 155)
1955:                     .Tag       = "GEN" + CHR(233) + "RICO/SOMENTE TEXTO"
1956:                     .Width     = 210


### BO (C:\4c\projeto\app\classes\sigreipeBO.prg):
*==============================================================================
* SIGREIPEBO.PRG
* Business Object para Impressao de Etiquetas
* Tabela principal: SigMlCab (mala direta) / SigMvCab (operacoes)
*
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigreipeBO AS RelatorioBase

    *-- Propriedades padrao
    this_cTabela         = "SigMlCab"
    this_cCampoChave     = "cIdChaves"
    this_cCursorDados    = "Relacao"
    this_cMensagemErro   = ""

    *-- Filtro: selecao por codigo/descricao (tabela SigMlItn)
    this_cCodigos        = ""
    this_cDescs          = ""

    *-- Filtro: selecao por operacao de movimento
    this_cNmOperacao     = ""
    this_dDtInicial      = {}
    this_dDtFinal        = {}
    this_nConta          = 2

    *-- Configuracao do modelo de etiqueta
    *-- 1=3col DN, 2=2col, 3=9lin, 4=9x3, 5=A4355, 6=2ColMarg, 7=Termica, 8=Pimaco6181, 9=TermicaZ
    this_nColunas        = 2
    this_nQtdEtiq        = 1

    *-- Configuracao da ordenacao
    *-- this_nOrdem: 1=Alfabetica, 2=CEP, 3=Data Nasc.
    *-- this_nOrdemDir: 1=Ascendente, 2=Descendente
    this_nOrdem          = 2
    this_nOrdemDir       = 2

    *-- Opcoes de conteudo das etiquetas
    *-- 1=Sim, 2=Nao em todos os grupos abaixo
    this_nImpPais        = 2
    this_nImpCodigo      = 1
    this_nImpMaius       = 2
    this_nImpContatos    = 2

    *-- Impressora selecionada (carregada no Form a partir de SigCdmp/SigSyImp)
    this_nImpressora     = 1
    this_cNomeImpressora = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigMlCab"
        THIS.this_cCampoChave  = "cIdChaves"
        THIS.this_cCursorDados = "Relacao"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Despacha para modo mala direta ou modo operacao
    * Modo mala direta: this_cCodigos preenchido -> SigMlCab+SigCdCli
    * Modo operacao:    this_cNmOperacao preenchido -> TmpOper via SigMvCab
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !EMPTY(THIS.this_cNmOperacao)
                loc_lSucesso = THIS.PrepararDadosOperacao()
            ELSE
                loc_lSucesso = THIS.PrepararDadosMalaDireta()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosMalaDireta - Busca registros de SigMlCab filtrando por
    * codigo de itinerario (this_cCodigos) ou descricao (this_cDescs)
    * Replica logica do Init original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosMalaDireta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cOrder, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cWhere = "a.Iclis = b.Iclis"
            IF !EMPTY(THIS.this_cCodigos)
                loc_cWhere = loc_cWhere + " AND a.Codigos = " + EscaparSQL(THIS.this_cCodigos)
            ENDIF

            loc_cOrder = "a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                         " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                         " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                         " a.cIdChaves, a.Codigos, b.Contato"

            loc_cSQL = "SELECT a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                       " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                       " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                       " a.cIdChaves, a.Codigos, b.paises, b.Contato" + ;
                       " FROM SigMlCab a, SigCdCli b" + ;
                       " WHERE " + loc_cWhere + ;
                       " ORDER BY " + loc_cOrder

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados da mala direta"
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosMalaDireta")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosOperacao - Busca movimentos de SigMvCab filtrados por
    * operacao e periodo, populando cursor TmpOper com campos para etiqueta.
    * Replica logica do get_dt_final.Valid original.
    * this_nConta = 1 -> usa dados do cliente ORIGEM (ContaOs)
    * this_nConta = 2 -> usa dados do cliente DESTINO (ContaDs)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cWhere = "a.Dopes = " + EscaparSQL(THIS.this_cNmOperacao)
            IF !EMPTY(THIS.this_dDtInicial)
                loc_cWhere = loc_cWhere + " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF
            IF !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + " AND a.Datas <= " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            IF THIS.this_nConta = 1
                *-- Origem: usa dados de b (SigCdCli ContaOs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " b.IClis, b.RClis, b.Endes, b.Nums, b.Compls," + ;
                           " b.Bairs, b.Cidas, b.Ceps, b.Estas," + ;
                           " b.Tel1s, b.Tel2s, b.Faxs, b.Nascs," + ;
                           " b.cIdChaves, b.Codigos, b.paises, b.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ELSE
                *-- Destino: usa dados de c (SigCdCli ContaDs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " c.IClis, c.RClis, c.Endes, c.Nums, c.Compls," + ;
                           " c.Bairs, c.Cidas, c.Ceps, c.Estas," + ;
                           " c.Tel1s, c.Tel2s, c.Faxs, c.Nascs," + ;
                           " c.cIdChaves, c.Codigos, c.paises, c.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar operacoes"
                loc_lSucesso = .F.
            ENDIF

            *-- Replica cursor TmpOper para Relacao (formato unificado para impressao)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT TmpOper
            IF !EOF()
                SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, ;
                       Tel1s, Tel2s, Faxs, Nascs, cIdChaves, Codigos, paises, Contato ;
                       FROM TmpOper WHERE Marcas = 1 ;
                       INTO CURSOR (THIS.this_cCursorDados) READWRITE
            ELSE
                *-- Cursor vazio com estrutura correta
                CREATE CURSOR (THIS.this_cCursorDados) ;
                    (IClis C(15), RClis C(60), Endes C(60), Nums C(10), Compls C(20), ;
                     Bairs C(40), Cidas C(40), Ceps C(9), Estas C(2), ;
                     Tel1s C(20), Tel2s C(20), Faxs C(20), Nascs D, ;
                     cIdChaves C(36), Codigos C(10), paises C(20), Contato C(40))
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosOperacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressao - Transforma cursor Relacao em DbImpressao pronto
    * para LABEL FORM, adicionando colunas cpros/qtds/cbars e copiando Obs
    * Replica logica do metodo "processamento" original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDbImpressao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0
                THIS.this_cMensagemErro = "Nenhum registro para imprimir"
                loc_lSucesso = .F.
            ENDIF

            IF USED("DbImpressao")
                USE IN DbImpressao
            ENDIF

            SELECT *, '1' AS cpros, 1 AS qtds, 0 AS cbars, ;
                   SPACE(60) AS Obs ;
                   FROM (THIS.this_cCursorDados) ;
                   INTO CURSOR DbImpressao READWRITE

            SELECT DbImpressao
            GO TOP
            REPLACE ALL Obs WITH IClis

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDbImpressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (cIdChaves) do cursor atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorDados) AND !EOF(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                loc_cChave = ALLTRIM(NVL(cIdChaves, ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cChave = ""
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("TmpOper")
            USE IN TmpOper
        ENDIF
        IF USED("DbImpressao")
            USE IN DbImpressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

