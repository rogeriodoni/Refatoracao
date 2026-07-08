# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 263: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 304: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2210 linhas total):

*-- Linhas 7 a 15:
7: *
8: * Fase 3/8: Estrutura base - Init, InicializarForm, Cabecalho, Botoes, Destroy
9: * Fase 4: grdOperacoes + cmdBtnGradeS + CarregarOperacoes
10: * Fases 5-6: controles de filtro (TextBox, OptionGroup, ComboBox, CheckBox)
11: * Fases 7-8: FormParaRelatorio, LimparCampos, eventos de lookup (KeyPress/LostFocus)
12: *==============================================================================
13: 
14: DEFINE CLASS FormSigReEsp AS FormBase
15: 

*-- Linhas 51 a 59:
51:                 gc_4c_CaminhoIcones = ""
52:             ENDIF
53: 
54:             THIS.Caption = "Estat" + CHR(237) + "stica de Pedidos"
55:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
56: 
57:             *-- Instanciar BO do relatorio
58:             THIS.this_oRelatorio = CREATEOBJECT("SigReEspBO")
59:             IF VARTYPE(THIS.this_oRelatorio) != "O"

*-- Linhas 122 a 146:
122:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
123:         loc_oPgf.PageCount = 2
124: 
125:         loc_oPgf.Top    = 80
126:         loc_oPgf.Left   = -1
127:         loc_oPgf.Width  = THIS.Width + 2
128:         loc_oPgf.Height = THIS.Height - 80
129:         loc_oPgf.Tabs   = .F.
130: 
131:         *-- Page1 = "Filtros" (lista de selecao + filtros)
132:         loc_oPgf.Page1.Caption   = "Filtros"
133:         loc_oPgf.Page1.FontName  = "Tahoma"
134:         loc_oPgf.Page1.FontSize  = 8
135:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
136:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
137:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
138: 
139:         *-- Page2 = "Dados" (reservada - frmrelatorio nao usa, mantida para
140:         *--                  compatibilidade com o ciclo padrao do FormBase)
141:         loc_oPgf.Page2.Caption   = "Dados"
142:         loc_oPgf.Page2.FontName  = "Tahoma"
143:         loc_oPgf.Page2.FontSize  = 8
144:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
145:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
146:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

*-- Linhas 170 a 210:
170:     PROTECTED PROCEDURE ConfigurarCabecalho()
171:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
172:         WITH THIS.cnt_4c_Cabecalho
173:             .Top        = 0
174:             .Left       = 0
175:             .Width      = THIS.Width
176:             .Height     = 80
177:             .BackStyle  = 1
178:             .BackColor  = RGB(100, 100, 100)
179:             .BorderWidth = 0
180:             .Visible    = .T.
181: 
182:             *-- Sombra preta (deslocada 3px para efeito de profundidade)
183:             .AddObject("lbl_4c_Sombra", "Label")
184:             WITH .lbl_4c_Sombra
185:                 .Top       = 18
186:                 .Left      = 12
187:                 .Width     = THIS.Width
188:                 .Height    = 46
189:                 .Caption   = THIS.Caption
190:                 .FontName  = "Tahoma"
191:                 .FontSize  = 16
192:                 .FontBold  = .T.
193:                 .ForeColor = RGB(0, 0, 0)
194:                 .BackStyle = 0
195:                 .Visible   = .T.
196:             ENDWITH
197: 
198:             *-- Titulo branco (sobre o fundo cinza escuro)
199:             .AddObject("lbl_4c_Titulo", "Label")
200:             WITH .lbl_4c_Titulo
201:                 .Top       = 15
202:                 .Left      = 10
203:                 .Width     = THIS.Width
204:                 .Height    = 46
205:                 .Caption   = THIS.Caption
206:                 .FontName  = "Tahoma"
207:                 .FontSize  = 16
208:                 .FontBold  = .T.
209:                 .ForeColor = RGB(255, 255, 255)
210:                 .BackStyle = 0

*-- Linhas 223 a 248:
223:     PROTECTED PROCEDURE ConfigurarBotoes()
224:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
225:         WITH THIS.cmg_4c_Botoes
226:             .Top           = 0
227:             .Left          = 529
228:             .Width         = 273
229:             .Height        = 80
230:             .ButtonCount   = 4
231:             .BackStyle     = 0
232:             .BorderStyle   = 0
233:             .BorderColor   = RGB(136, 189, 188)
234:             .SpecialEffect = 1
235:             .Themes        = .F.
236:             .Visible       = .T.
237: 
238:             WITH .Buttons(1)
239:                 .Top             = 5
240:                 .Left            = 5
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .Caption         = "Visualizar"
244:                 .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
245:                 .FontBold        = .T.
246:                 .FontItalic      = .T.
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 254 a 310:
254:             ENDWITH
255: 
256:             WITH .Buttons(2)
257:                 .Top             = 5
258:                 .Left            = 71
259:                 .Width           = 65
260:                 .Height          = 70
261:                 .Caption         = "Imprimir"
262:                 .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
263:                 .FontName        = "Comic Sans MS"
264:                 .FontBold        = .T.
265:                 .FontItalic      = .T.
266:                 .FontSize        = 8
267:                 .ForeColor       = RGB(90, 90, 90)
268:                 .BackColor       = RGB(255, 255, 255)
269:                 .PicturePosition = 13
270:                 .SpecialEffect   = 0
271:                 .MousePointer    = 15
272:                 .Themes          = .F.
273:                 .WordWrap        = .T.
274:             ENDWITH
275: 
276:             WITH .Buttons(3)
277:                 .Top             = 5
278:                 .Left            = 137
279:                 .Width           = 65
280:                 .Height          = 70
281:                 .Caption         = "DocExcel"
282:                 .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
283:                 .FontName        = "Comic Sans MS"
284:                 .FontBold        = .T.
285:                 .FontItalic      = .T.
286:                 .FontSize        = 8
287:                 .ForeColor       = RGB(90, 90, 90)
288:                 .BackColor       = RGB(255, 255, 255)
289:                 .PicturePosition = 13
290:                 .SpecialEffect   = 0
291:                 .MousePointer    = 15
292:                 .Themes          = .F.
293:                 .WordWrap        = .T.
294:             ENDWITH
295: 
296:             WITH .Buttons(4)
297:                 .Top             = 5
298:                 .Left            = 203
299:                 .Width           = 65
300:                 .Height          = 70
301:                 .Caption         = "Sair"
302:                 .Cancel          = .T.
303:                 .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
304:                 .FontName        = "Comic Sans MS"
305:                 .FontBold        = .T.
306:                 .FontItalic      = .T.
307:                 .FontSize        = 8
308:                 .ForeColor       = RGB(90, 90, 90)
309:                 .BackColor       = RGB(255, 255, 255)
310:                 .PicturePosition = 13

*-- Linhas 432 a 441:
432:         loc_oGrid.ColumnCount = 5
433: 
434:         WITH loc_oGrid
435:             .Top                = 210
436:             .Left               = 439
437:             .Width              = 309
438:             .Height             = 115
439:             .DeleteMark         = .F.
440:             .RecordMark         = .F.
441:             .HighlightStyle     = 2

*-- Linhas 448 a 461:
448:             .RowHeight          = 16
449:         ENDWITH
450: 
451:         *-- Coluna 1: CheckBox para SelImp (selecao principal - Header "M")
452:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS
453:         WITH loc_oGrid.Column1
454:             .Width = 22
455:             .AddObject("Check1", "CheckBox")
456:             .Check1.Caption = ""
457:             .Check1.Value   = 0
458:             .CurrentControl = "Check1"
459:             .ControlSource  = "crOperacoes.SelImp"
460:             .Check1.Visible = .T.
461:         ENDWITH

*-- Linhas 474 a 548:
474:             .ReadOnly      = .T.
475:         ENDWITH
476: 
477:         *-- Coluna 4: CheckBox para SelImp2 (Header "E")
478:         WITH loc_oGrid.Column4
479:             .Width = 37
480:             .AddObject("Check1", "CheckBox")
481:             .Check1.Caption = ""
482:             .Check1.Value   = 0
483:             .CurrentControl = "Check1"
484:             .ControlSource  = "crOperacoes.SelImp2"
485:             .Check1.Visible = .T.
486:         ENDWITH
487: 
488:         *-- Coluna 5: CheckBox para SelImp3 (Header "C")
489:         WITH loc_oGrid.Column5
490:             .Width = 35
491:             .AddObject("Check1", "CheckBox")
492:             .Check1.Caption = ""
493:             .Check1.Value   = 0
494:             .CurrentControl = "Check1"
495:             .ControlSource  = "crOperacoes.SelImp3"
496:             .Check1.Visible = .T.
497:         ENDWITH
498: 
499:         *-- RecordSource APOS configurar colunas (RecordSource reseta headers)
500:         loc_oGrid.RecordSource = "crOperacoes"
501: 
502:         *-- Reconfigurar Headers APOS RecordSource (OBRIGATORIO)
503:         loc_oGrid.Column1.Header1.Caption = "M"
504:         loc_oGrid.Column2.Header1.Caption = ""
505:         loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
506:         loc_oGrid.Column4.Header1.Caption = "E"
507:         loc_oGrid.Column5.Header1.Caption = "C"
508: 
509:         loc_oGrid.Visible = .T.
510: 
511:         *-- KeyPress Enter(13)/Espaco(32) em Col1.Check1 -> togla SelImp
512:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "GrdOpeCheck1KeyPress")
513: 
514:         *-- ===================== COMMANDGROUP cmg_4c_GradeS ==========================
515:         *-- Botoes Sel./Des. todos (cmdBtnGradeS do original)
516:         *-- Top original=300 -> Top_Page1=220, Left=746, Width=50, Height=90
517:         loc_oPagina.AddObject("cmg_4c_GradeS", "CommandGroup")
518:         WITH loc_oPagina.cmg_4c_GradeS
519:             .Top         = 220
520:             .Left        = 746
521:             .Width       = 50
522:             .Height      = 90
523:             .ButtonCount = 2
524:             .BackStyle   = 0
525:             .BorderStyle = 0
526:             .Themes      = .F.
527:             .Visible     = .T.
528: 
529:             WITH .Buttons(1)
530:                 .Top      = 0
531:                 .Left     = 0
532:                 .Width    = 50
533:                 .Height   = 45
534:                 .Caption  = "Sel."
535:                 .Themes   = .F.
536:             ENDWITH
537: 
538:             WITH .Buttons(2)
539:                 .Top      = 45
540:                 .Left     = 0
541:                 .Width    = 50
542:                 .Height   = 45
543:                 .Caption  = "Des."
544:                 .FontName = "Tahoma"
545:                 .FontSize = 8
546:                 .Themes   = .F.
547:             ENDWITH
548:         ENDWITH

*-- Linhas 559 a 567:
559:     *   Linha 5: Vendedor (codigo + descricao)
560:     *
561:     *   Todos os controles vao em Page1 (form relatorio = layout flat).
562:     *   Coordenadas: Top_Page1 = Top_original - 80 (PageFrame.Top=80)
563:     *==========================================================================
564:     PROTECTED PROCEDURE ConfigurarPaginaDados()
565:         LOCAL loc_oPagina
566: 
567:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"

*-- Linhas 575 a 588:
575: 
576:         *-- Label "Periodo :" (lbl_periodo - TabIndex=1)
577:         *-- Top original=97 -> Top_Page1=17
578:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
579:         WITH loc_oPagina.lbl_4c_Lbl_periodo
580:             .AutoSize  = .T.
581:             .Caption   = "Per" + CHR(237) + "odo :"
582:             .Left      = 47
583:             .Top       = 17
584:             .Width     = 45
585:             .FontName  = "Tahoma"
586:             .FontSize  = 8
587:             .BackStyle = 0
588:             .Visible   = .T.

*-- Linhas 596 a 620:
596:             .FontSize      = 8
597:             .Format        = "K"
598:             .Height        = 25
599:             .Left          = 94
600:             .SpecialEffect = 1
601:             .Top           = 12
602:             .Width         = 80
603:             .ForeColor     = RGB(0, 0, 0)
604:             .BorderColor   = RGB(100, 100, 100)
605:             .Value         = DATE()
606:             .Visible       = .T.
607:         ENDWITH
608: 
609:         *-- Label "ate" (lbl_periodo_a - TabIndex=3)
610:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo_a", "Label")
611:         WITH loc_oPagina.lbl_4c_Lbl_periodo_a
612:             .AutoSize  = .T.
613:             .Caption   = "at" + CHR(233)
614:             .Left      = 188
615:             .Top       = 17
616:             .Width     = 18
617:             .FontName  = "Tahoma"
618:             .FontSize  = 8
619:             .BackStyle = 0
620:             .Visible   = .T.

*-- Linhas 628 a 724:
628:             .FontSize      = 8
629:             .Format        = "K"
630:             .Height        = 25
631:             .Left          = 221
632:             .SpecialEffect = 1
633:             .Top           = 12
634:             .Width         = 80
635:             .ForeColor     = RGB(0, 0, 0)
636:             .BorderColor   = RGB(100, 100, 100)
637:             .Value         = DATE()
638:             .Visible       = .T.
639:         ENDWITH
640: 
641:         *-- OptionGroup tipo de periodo (Opt_nr_periodo - TabIndex=5)
642:         *-- Top original=83 -> Top_Page1=3
643:         *-- ButtonCount=4: Lancamento / Prazo Entrega / Ult. Alteracao / Fechamento
644:         loc_oPagina.AddObject("obj_4c_OptNrPeriodo", "OptionGroup")
645:         WITH loc_oPagina.obj_4c_OptNrPeriodo
646:             .Top           = 3
647:             .Left          = 306
648:             .Width         = 200
649:             .Height        = 41
650:             .ButtonCount   = 4
651:             .BackStyle     = 0
652:             .BorderStyle   = 0
653:             .Value         = 1
654:             .SpecialEffect = 0
655:             .Themes        = .F.
656:             .Visible       = .T.
657: 
658:             WITH .Buttons(1)
659:                 .BackStyle = 0
660:                 .Caption   = "Lan" + CHR(231) + "amento"
661:                 .Value     = 1
662:                 .Height    = 15
663:                 .Left      = 5
664:                 .Top       = 5
665:                 .Width     = 76
666:                 .AutoSize  = .T.
667:                 .ForeColor = RGB(90, 90, 90)
668:             ENDWITH
669: 
670:             WITH .Buttons(2)
671:                 .FontName  = "Tahoma"
672:                 .FontSize  = 8
673:                 .BackStyle = 0
674:                 .Caption   = "Prazo Entrega"
675:                 .Value     = 0
676:                 .Left      = 100
677:                 .Top       = 5
678:                 .AutoSize  = .T.
679:                 .ForeColor = RGB(90, 90, 90)
680:             ENDWITH
681: 
682:             WITH .Buttons(3)
683:                 .FontName  = "Tahoma"
684:                 .FontSize  = 8
685:                 .BackStyle = 0
686:                 .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o"
687:                 .Height    = 15
688:                 .Left      = 5
689:                 .Top       = 20
690:                 .Width     = 84
691:                 .AutoSize  = .T.
692:                 .ForeColor = RGB(90, 90, 90)
693:             ENDWITH
694: 
695:             WITH .Buttons(4)
696:                 .FontName  = "Tahoma"
697:                 .FontSize  = 8
698:                 .BackStyle = 0
699:                 .Caption   = "Fechamento"
700:                 .Height    = 15
701:                 .Left      = 100
702:                 .Top       = 20
703:                 .Width     = 88
704:                 .ForeColor = RGB(90, 90, 90)
705:             ENDWITH
706:         ENDWITH
707: 
708:         *-- ===========================================================
709:         *-- LINHA 2: Movimentacao (cod. operacao + numero do pedido)
710:         *-- ===========================================================
711: 
712:         *-- Label "Movimentacao :" (lbl_dopes - TabIndex=6)
713:         *-- Top original=124 -> Top_Page1=44
714:         loc_oPagina.AddObject("lbl_4c_Lbl_dopes", "Label")
715:         WITH loc_oPagina.lbl_4c_Lbl_dopes
716:             .AutoSize  = .T.
717:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
718:             .Left      = 14
719:             .Top       = 44
720:             .Width     = 78
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .BackStyle = 0
724:             .Visible   = .T.

*-- Linhas 733 a 744:
733:             .Alignment     = 0
734:             .Format        = "K!"
735:             .Height        = 25
736:             .Left          = 94
737:             .MaxLength     = 20
738:             .SpecialEffect = 1
739:             .Top           = 39
740:             .Width         = 150
741:             .ForeColor     = RGB(0, 0, 0)
742:             .BorderColor   = RGB(100, 100, 100)
743:             .Value         = SPACE(20)
744:             .Visible       = .T.

*-- Linhas 753 a 763:
753:             .Format        = "K"
754:             .Height        = 25
755:             .InputMask     = "999999"
756:             .Left          = 246
757:             .SpecialEffect = 1
758:             .Top           = 39
759:             .Width         = 55
760:             .ForeColor     = RGB(0, 0, 0)
761:             .BorderColor   = RGB(100, 100, 100)
762:             .Value         = 0
763:             .Visible       = .T.

*-- Linhas 769 a 783:
769: 
770:         *-- Label "Tipo :" (Say6 - TabIndex=9)
771:         *-- Top original=151 -> Top_Page1=71
772:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
773:         WITH loc_oPagina.lbl_4c_Label6
774:             .AutoSize  = .T.
775:             .Caption   = "Tipo :"
776:             .Height    = 15
777:             .Left      = 63
778:             .Top       = 71
779:             .Width     = 29
780:             .FontName  = "Tahoma"
781:             .FontSize  = 8
782:             .BackStyle = 0
783:             .Visible   = .T.

*-- Linhas 792 a 803:
792:             .Format        = "K"
793:             .Height        = 25
794:             .InputMask     = "99"
795:             .Left          = 94
796:             .MaxLength     = 2
797:             .SpecialEffect = 1
798:             .Top           = 66
799:             .Width         = 24
800:             .ForeColor     = RGB(0, 0, 0)
801:             .BorderColor   = RGB(100, 100, 100)
802:             .Value         = 0
803:             .Visible       = .T.

*-- Linhas 810 a 821:
810:             .FontSize      = 8
811:             .Format        = "K"
812:             .Height        = 25
813:             .Left          = 120
814:             .MaxLength     = 30
815:             .SpecialEffect = 1
816:             .Top           = 66
817:             .Width         = 181
818:             .ForeColor     = RGB(0, 0, 0)
819:             .BorderColor   = RGB(100, 100, 100)
820:             .Value         = "TODOS"
821:             .Visible       = .T.

*-- Linhas 827 a 840:
827: 
828:         *-- Label "Conta :" (lbl_estoque - TabIndex=12)
829:         *-- Top original=178 -> Top_Page1=98
830:         loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
831:         WITH loc_oPagina.lbl_4c_Lbl_estoque
832:             .AutoSize  = .T.
833:             .Caption   = "Conta :"
834:             .Left      = 54
835:             .Top       = 98
836:             .Width     = 38
837:             .FontName  = "Tahoma"
838:             .FontSize  = 8
839:             .BackStyle = 0
840:             .Visible   = .T.

*-- Linhas 849 a 860:
849:             .Alignment     = 0
850:             .Format        = "K"
851:             .Height        = 25
852:             .Left          = 94
853:             .MaxLength     = 10
854:             .SpecialEffect = 1
855:             .Top           = 93
856:             .Width         = 79
857:             .ForeColor     = RGB(0, 0, 0)
858:             .BorderColor   = RGB(100, 100, 100)
859:             .Value         = SPACE(10)
860:             .Visible       = .T.

*-- Linhas 867 a 896:
867:             .FontSize      = 8
868:             .Format        = "K"
869:             .Height        = 25
870:             .Left          = 175
871:             .MaxLength     = 40
872:             .SpecialEffect = 1
873:             .Top           = 93
874:             .Width         = 300
875:             .BorderColor   = RGB(100, 100, 100)
876:             .Value         = SPACE(40)
877:             .Visible       = .T.
878:         ENDWITH
879: 
880:         *-- ===========================================================
881:         *-- LINHA 5: Vendedor (codigo + descricao)
882:         *-- ===========================================================
883: 
884:         *-- Label "Vendedor :" (Say4 - TabIndex=15)
885:         *-- Top original=205 -> Top_Page1=125
886:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
887:         WITH loc_oPagina.lbl_4c_Label4
888:             .AutoSize  = .T.
889:             .Caption   = "Vendedor :"
890:             .Left      = 37
891:             .Top       = 125
892:             .Width     = 55
893:             .FontName  = "Tahoma"
894:             .FontSize  = 8
895:             .BackStyle = 0
896:             .Visible   = .T.

*-- Linhas 905 a 916:
905:             .Alignment     = 0
906:             .Format        = "K"
907:             .Height        = 25
908:             .Left          = 94
909:             .MaxLength     = 10
910:             .SpecialEffect = 1
911:             .Top           = 120
912:             .Width         = 79
913:             .ForeColor     = RGB(0, 0, 0)
914:             .BorderColor   = RGB(100, 100, 100)
915:             .Value         = SPACE(10)
916:             .Visible       = .T.

*-- Linhas 923 a 951:
923:             .FontSize      = 8
924:             .Format        = "K"
925:             .Height        = 25
926:             .Left          = 175
927:             .MaxLength     = 40
928:             .SpecialEffect = 1
929:             .Top           = 120
930:             .Width         = 300
931:             .BorderColor   = RGB(100, 100, 100)
932:             .Value         = SPACE(40)
933:             .Visible       = .T.
934:         ENDWITH
935: 
936:         *-- ===========================================================
937:         *-- LINHA 6: Cidade / UF (Estado)
938:         *-- ===========================================================
939: 
940:         *-- Label "Cidade :" (Say2 - Top original=232 -> Top_Page1=152)
941:         loc_oPagina.AddObject("lbl_4c_Say2", "Label")
942:         WITH loc_oPagina.lbl_4c_Say2
943:             .AutoSize  = .T.
944:             .Caption   = "Cidade :"
945:             .Left      = 50
946:             .Top       = 152
947:             .FontName  = "Tahoma"
948:             .FontSize  = 8
949:             .BackStyle = 0
950:             .Visible   = .T.
951:         ENDWITH

*-- Linhas 957 a 982:
957:             .FontSize      = 8
958:             .Format        = "K"
959:             .Height        = 25
960:             .Left          = 94
961:             .MaxLength     = 30
962:             .SpecialEffect = 1
963:             .Top           = 147
964:             .Width         = 207
965:             .ForeColor     = RGB(0, 0, 0)
966:             .BorderColor   = RGB(100, 100, 100)
967:             .Value         = SPACE(30)
968:             .Visible       = .T.
969:         ENDWITH
970: 
971:         *-- Label "UF :" (Say3 - Top original=232 -> Top_Page1=152)
972:         loc_oPagina.AddObject("lbl_4c_Say3", "Label")
973:         WITH loc_oPagina.lbl_4c_Say3
974:             .AutoSize  = .T.
975:             .Caption   = "UF :"
976:             .Left      = 335
977:             .Top       = 152
978:             .FontName  = "Tahoma"
979:             .FontSize  = 8
980:             .BackStyle = 0
981:             .Visible   = .T.
982:         ENDWITH

*-- Linhas 988 a 1017:
988:             .FontSize      = 8
989:             .Format        = "K!"
990:             .Height        = 25
991:             .Left          = 359
992:             .MaxLength     = 2
993:             .SpecialEffect = 1
994:             .Top           = 147
995:             .Width         = 24
996:             .ForeColor     = RGB(0, 0, 0)
997:             .BorderColor   = RGB(100, 100, 100)
998:             .Value         = SPACE(2)
999:             .Visible       = .T.
1000:         ENDWITH
1001: 
1002:         *-- ===========================================================
1003:         *-- LINHA 7: Ordem / Moeda
1004:         *-- ===========================================================
1005: 
1006:         *-- Label "Ordem :" (Say1 - Top original=259 -> Top_Page1=179)
1007:         loc_oPagina.AddObject("lbl_4c_Say1", "Label")
1008:         WITH loc_oPagina.lbl_4c_Say1
1009:             .AutoSize  = .T.
1010:             .Caption   = "Ordem :"
1011:             .Left      = 51
1012:             .Top       = 179
1013:             .FontName  = "Tahoma"
1014:             .FontSize  = 8
1015:             .BackStyle = 0
1016:             .Visible   = .T.
1017:         ENDWITH

*-- Linhas 1023 a 1047:
1023:             .FontName      = "Tahoma"
1024:             .FontSize      = 8
1025:             .Height        = 25
1026:             .Left          = 94
1027:             .Top           = 174
1028:             .Width         = 207
1029:             .Style         = 2
1030:             .RowSourceType = 1
1031:             .RowSource     = "Cliente,Digita" + CHR(231) + CHR(227) + "o,Entrega,Vendedor+Digita" + CHR(231) + CHR(227) + "o,Vendedor+Entrega,Vendedor+Cliente"
1032:             .Value         = "Cliente"
1033:             .Visible       = .T.
1034:         ENDWITH
1035: 
1036:         *-- Label "Moeda :" (lbl_moeda - Top original=259 -> Top_Page1=179)
1037:         loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
1038:         WITH loc_oPagina.lbl_4c_LblMoeda
1039:             .AutoSize  = .T.
1040:             .Caption   = "Moeda :"
1041:             .Left      = 316
1042:             .Top       = 179
1043:             .FontName  = "Tahoma"
1044:             .FontSize  = 8
1045:             .BackStyle = 0
1046:             .Visible   = .T.
1047:         ENDWITH

*-- Linhas 1054 a 1065:
1054:             .Alignment     = 0
1055:             .Format        = "K!"
1056:             .Height        = 25
1057:             .Left          = 359
1058:             .MaxLength     = 3
1059:             .SpecialEffect = 1
1060:             .Top           = 174
1061:             .Width         = 31
1062:             .ForeColor     = RGB(0, 0, 0)
1063:             .BorderColor   = RGB(100, 100, 100)
1064:             .Value         = SPACE(3)
1065:             .Visible       = .T.

*-- Linhas 1072 a 1201:
1072:             .FontSize      = 8
1073:             .Format        = "K"
1074:             .Height        = 25
1075:             .Left          = 392
1076:             .MaxLength     = 15
1077:             .SpecialEffect = 1
1078:             .Top           = 174
1079:             .Width         = 115
1080:             .ForeColor     = RGB(0, 0, 0)
1081:             .BorderColor   = RGB(100, 100, 100)
1082:             .Value         = SPACE(15)
1083:             .Visible       = .T.
1084:         ENDWITH
1085: 
1086:         *-- ===========================================================
1087:         *-- LINHA 8: Situacao (opt_filtro)
1088:         *-- ===========================================================
1089: 
1090:         *-- Label "Situacao :" (lbl_custo - Top original=285 -> Top_Page1=205)
1091:         loc_oPagina.AddObject("lbl_4c_LblCusto", "Label")
1092:         WITH loc_oPagina.lbl_4c_LblCusto
1093:             .AutoSize  = .T.
1094:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
1095:             .Left      = 42
1096:             .Top       = 205
1097:             .FontName  = "Tahoma"
1098:             .FontSize  = 8
1099:             .BackStyle = 0
1100:             .Visible   = .T.
1101:         ENDWITH
1102: 
1103:         *-- OptionGroup situacao filtro (opt_filtro - Top original=281 -> Top_Page1=201)
1104:         *-- ButtonCount=3: Encerrados/Abertos/Ambos, Value=3 (Ambos)
1105:         loc_oPagina.AddObject("obj_4c_OptFiltro", "OptionGroup")
1106:         WITH loc_oPagina.obj_4c_OptFiltro
1107:             .Top           = 201
1108:             .Left          = 89
1109:             .Width         = 235
1110:             .Height        = 20
1111:             .ButtonCount   = 3
1112:             .BackStyle     = 0
1113:             .BorderStyle   = 0
1114:             .Value         = 3
1115:             .SpecialEffect = 0
1116:             .Themes        = .F.
1117:             .Visible       = .T.
1118: 
1119:             WITH .Buttons(1)
1120:                 .BackStyle = 0
1121:                 .Caption   = "Encerrados"
1122:                 .Height    = 15
1123:                 .Left      = 5
1124:                 .Top       = 3
1125:                 .AutoSize  = .T.
1126:                 .ForeColor = RGB(90, 90, 90)
1127:             ENDWITH
1128: 
1129:             WITH .Buttons(2)
1130:                 .FontName  = "Tahoma"
1131:                 .FontSize  = 8
1132:                 .BackStyle = 0
1133:                 .Caption   = "Abertos"
1134:                 .Height    = 15
1135:                 .Left      = 95
1136:                 .Top       = 3
1137:                 .AutoSize  = .T.
1138:                 .ForeColor = RGB(90, 90, 90)
1139:             ENDWITH
1140: 
1141:             WITH .Buttons(3)
1142:                 .FontName  = "Tahoma"
1143:                 .FontSize  = 8
1144:                 .BackStyle = 0
1145:                 .Caption   = "Ambos"
1146:                 .Height    = 15
1147:                 .Left      = 170
1148:                 .Top       = 3
1149:                 .AutoSize  = .T.
1150:                 .ForeColor = RGB(90, 90, 90)
1151:             ENDWITH
1152:         ENDWITH
1153: 
1154:         *-- ===========================================================
1155:         *-- LINHA 9: chkItens
1156:         *-- ===========================================================
1157: 
1158:         *-- CheckBox ignorar itens encerrados (chkItens - Top original=304 -> Top_Page1=224)
1159:         loc_oPagina.AddObject("chk_4c_ChkItens", "CheckBox")
1160:         WITH loc_oPagina.chk_4c_ChkItens
1161:             .FontName  = "Tahoma"
1162:             .FontSize  = 8
1163:             .Caption   = "Ignorar itens encerrados"
1164:             .Height    = 20
1165:             .Left      = 112
1166:             .Top       = 224
1167:             .Width     = 200
1168:             .BackStyle = 0
1169:             .Value     = 0
1170:             .Visible   = .T.
1171:         ENDWITH
1172: 
1173:         *-- ===========================================================
1174:         *-- LINHA 10: Imprimir (Opc_Imp)
1175:         *-- ===========================================================
1176: 
1177:         *-- Label "Imprimir :" (Say5 - Top original=325 -> Top_Page1=245)
1178:         loc_oPagina.AddObject("lbl_4c_Say5", "Label")
1179:         WITH loc_oPagina.lbl_4c_Say5
1180:             .AutoSize  = .T.
1181:             .Caption   = "Imprimir :"
1182:             .Left      = 45
1183:             .Top       = 245
1184:             .FontName  = "Tahoma"
1185:             .FontSize  = 8
1186:             .BackStyle = 0
1187:             .Visible   = .T.
1188:         ENDWITH
1189: 
1190:         *-- OptionGroup imprimir por (Opc_Imp - Top original=321 -> Top_Page1=241)
1191:         *-- ButtonCount=3: Vendedor/Cidade/Data Encerramento, Value=1
1192:         *-- Enabled=.F.: habilitado somente quando opt_filtro.Value=1 (Encerrados)
1193:         loc_oPagina.AddObject("obj_4c_OpcImp", "OptionGroup")
1194:         WITH loc_oPagina.obj_4c_OpcImp
1195:             .Top           = 241
1196:             .Left          = 89
1197:             .Width         = 288
1198:             .Height        = 25
1199:             .ButtonCount   = 3
1200:             .BackStyle     = 0
1201:             .BorderStyle   = 0

*-- Linhas 1207 a 1354:
1207: 
1208:             WITH .Buttons(1)
1209:                 .BackStyle = 0
1210:                 .Caption   = "Vendedor"
1211:                 .Height    = 15
1212:                 .Left      = 5
1213:                 .Top       = 5
1214:                 .AutoSize  = .T.
1215:                 .ForeColor = RGB(90, 90, 90)
1216:             ENDWITH
1217: 
1218:             WITH .Buttons(2)
1219:                 .FontName  = "Tahoma"
1220:                 .FontSize  = 8
1221:                 .BackStyle = 0
1222:                 .Caption   = "Cidade"
1223:                 .Height    = 15
1224:                 .Left      = 90
1225:                 .Top       = 5
1226:                 .AutoSize  = .T.
1227:                 .ForeColor = RGB(90, 90, 90)
1228:             ENDWITH
1229: 
1230:             WITH .Buttons(3)
1231:                 .FontName  = "Tahoma"
1232:                 .FontSize  = 8
1233:                 .BackStyle = 0
1234:                 .Caption   = "Data Encerramento"
1235:                 .Height    = 15
1236:                 .Left      = 155
1237:                 .Top       = 5
1238:                 .AutoSize  = .T.
1239:                 .ForeColor = RGB(90, 90, 90)
1240:             ENDWITH
1241:         ENDWITH
1242: 
1243:         *-- ===========================================================
1244:         *-- LINHA 11: Visualizar (optAnaSin)
1245:         *-- ===========================================================
1246: 
1247:         *-- Label "Visualizar :" (Say7 - Top original=352 -> Top_Page1=272)
1248:         loc_oPagina.AddObject("lbl_4c_Say7", "Label")
1249:         WITH loc_oPagina.lbl_4c_Say7
1250:             .AutoSize  = .T.
1251:             .Caption   = "Visualizar :"
1252:             .Left      = 39
1253:             .Top       = 272
1254:             .FontName  = "Tahoma"
1255:             .FontSize  = 8
1256:             .BackStyle = 0
1257:             .Visible   = .T.
1258:         ENDWITH
1259: 
1260:         *-- OptionGroup analitico/sintetico (optAnaSin - Top original=347 -> Top_Page1=267)
1261:         *-- ButtonCount=2: Analitico/Sintetico, Value=2 (Sintetico)
1262:         loc_oPagina.AddObject("obj_4c_OptAnaSin", "OptionGroup")
1263:         WITH loc_oPagina.obj_4c_OptAnaSin
1264:             .Top           = 267
1265:             .Left          = 89
1266:             .Width         = 158
1267:             .Height        = 25
1268:             .ButtonCount   = 2
1269:             .BackStyle     = 0
1270:             .BorderStyle   = 0
1271:             .Value         = 2
1272:             .SpecialEffect = 0
1273:             .Themes        = .F.
1274:             .Visible       = .T.
1275: 
1276:             WITH .Buttons(1)
1277:                 .BackStyle = 0
1278:                 .Caption   = "Anal" + CHR(237) + "tico"
1279:                 .Height    = 15
1280:                 .Left      = 5
1281:                 .Top       = 5
1282:                 .AutoSize  = .T.
1283:                 .ForeColor = RGB(90, 90, 90)
1284:                 .Themes    = .F.
1285:             ENDWITH
1286: 
1287:             WITH .Buttons(2)
1288:                 .FontName  = "Tahoma"
1289:                 .FontSize  = 8
1290:                 .BackStyle = 0
1291:                 .Caption   = "Sint" + CHR(233) + "tico"
1292:                 .Height    = 15
1293:                 .Left      = 80
1294:                 .Top       = 5
1295:                 .AutoSize  = .T.
1296:                 .ForeColor = RGB(90, 90, 90)
1297:                 .Themes    = .F.
1298:             ENDWITH
1299:         ENDWITH
1300: 
1301:         *-- ===========================================================
1302:         *-- LINHA 12: chkTpope / chkSemVals
1303:         *-- ===========================================================
1304: 
1305:         *-- CheckBox analisar por tipo de movimentacao (chkTpope - Top original=369 -> Top_Page1=289)
1306:         loc_oPagina.AddObject("chk_4c_ChkTpope", "CheckBox")
1307:         WITH loc_oPagina.chk_4c_ChkTpope
1308:             .FontName  = "Tahoma"
1309:             .FontSize  = 8
1310:             .Caption   = "Analisar por Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
1311:             .Height    = 20
1312:             .Left      = 112
1313:             .Top       = 289
1314:             .Width     = 220
1315:             .BackStyle = 0
1316:             .Value     = 0
1317:             .Visible   = .T.
1318:         ENDWITH
1319: 
1320:         *-- CheckBox sem valores (chkSemVals - Top original=369 -> Top_Page1=289)
1321:         *-- Enabled=.F.: habilitado somente quando chkTpope.Value=1
1322:         loc_oPagina.AddObject("chk_4c_ChkSemVals", "CheckBox")
1323:         WITH loc_oPagina.chk_4c_ChkSemVals
1324:             .FontName  = "Tahoma"
1325:             .FontSize  = 8
1326:             .Caption   = "Sem Valores"
1327:             .Height    = 20
1328:             .Left      = 337
1329:             .Top       = 289
1330:             .Width     = 100
1331:             .BackStyle = 0
1332:             .Value     = 0
1333:             .Enabled   = .F.
1334:             .Visible   = .T.
1335:         ENDWITH
1336: 
1337:         *-- ===========================================================
1338:         *-- LINHA 13: chkIndus
1339:         *-- ===========================================================
1340: 
1341:         *-- CheckBox ignorar nao industrializadas (chkIndus - Top original=387 -> Top_Page1=307)
1342:         loc_oPagina.AddObject("chk_4c_ChkIndus", "CheckBox")
1343:         WITH loc_oPagina.chk_4c_ChkIndus
1344:             .FontName  = "Tahoma"
1345:             .FontSize  = 8
1346:             .Caption   = "Ignorar n" + CHR(227) + "o Industrializadas"
1347:             .Height    = 20
1348:             .Left      = 112
1349:             .Top       = 307
1350:             .Width     = 200
1351:             .BackStyle = 0
1352:             .Value     = 0
1353:             .Visible   = .T.
1354:         ENDWITH

