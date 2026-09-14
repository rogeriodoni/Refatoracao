# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH THIS.grd_4c_GradeOpe define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_GradeOpe.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_GradeItens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_GradeItens.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1369 linhas total):

*-- Linhas 87 a 115:
87:     * Activate - Ordena grade e atualiza visual ao ativar o form
88:     *--------------------------------------------------------------------------
89:     PROCEDURE Activate()
90:         THIS.AplicarOrdem("")
91:         IF USED("TmpCabec")
92:             THIS.grd_4c_GradeOpe.Refresh()
93:         ENDIF
94:     ENDPROC
95: 
96:     *--------------------------------------------------------------------------
97:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
98:     *--------------------------------------------------------------------------
99:     PROTECTED PROCEDURE InicializarForm()
100:         LOCAL loc_lSucesso, loc_oErro
101:         loc_lSucesso = .F.
102: 
103:         TRY
104:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGl2BO")
105:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
106:                 MsgErro("Falha ao criar SigPrGl2BO.", "Erro")
107:             ELSE
108:                 THIS.ConfigurarPageFrame()
109:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
110:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
111:                 THIS.MontarLayout()
112:                 THIS.ConfigurarGrades()
113:                 THIS.ConfigurarPaginaDados()
114:                 THIS.RegistrarEventos()
115:                 THIS.AplicarOrdem("")

*-- Linhas 130 a 144:
130:     PROTECTED PROCEDURE MontarLayout()
131: 
132:         *-- Botao Processar (top=3, sobreposicao ao cabecalho cinza)
133:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
134:         WITH THIS.cmd_4c_Processar
135:             .Top             = 3
136:             .Left            = 648
137:             .Width           = 75
138:             .Height          = 75
139:             .Caption         = "\<Processar"
140:             .FontBold        = .T.
141:             .FontItalic      = .T.
142:             .FontName        = "Tahoma"
143:             .FontSize        = 8
144:             .WordWrap        = .T.

*-- Linhas 150 a 164:
150:         ENDWITH
151: 
152:         *-- Botao Cancelar/Encerrar
153:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
154:         WITH THIS.cmd_4c_Cancelar
155:             .Top             = 3
156:             .Left            = 723
157:             .Width           = 75
158:             .Height          = 75
159:             .Caption         = "Encerrar"
160:             .FontBold        = .T.
161:             .FontItalic      = .T.
162:             .FontName        = "Tahoma"
163:             .FontSize        = 8
164:             .WordWrap        = .T.

*-- Linhas 173 a 227:
173:         *-- EditBox: Observacao da Operacao (top=82, editavel)
174:         THIS.AddObject("edt_4c_ObsOpe", "EditBox")
175:         WITH THIS.edt_4c_ObsOpe
176:             .Top         = 82
177:             .Left        = 5
178:             .Width       = 602
179:             .Height      = 70
180:             .NullDisplay = " "
181:             .FontName    = "Tahoma"
182:             .FontSize    = 8
183:         ENDWITH
184: 
185:         *-- Grade de Operacoes (top=155, 10 colunas)
186:         THIS.AddObject("grd_4c_GradeOpe", "Grid")
187:         WITH THIS.grd_4c_GradeOpe
188:             .Top               = 155
189:             .Left              = 5
190:             .Width             = 789
191:             .Height            = 156
192:             .ColumnCount       = 10
193:             .FontSize          = 8
194:             .AllowHeaderSizing = .F.
195:             .AllowRowSizing    = .F.
196:             .DeleteMark        = .F.
197:             .RecordMark        = .F.
198:             .RowHeight         = 17
199:             .ScrollBars        = 2
200:             .GridLineColor     = RGB(238,238,238)
201:             .Panel             = 1
202:         ENDWITH
203: 
204:         *-- Configurar colunas da GradeOpe
205:         WITH THIS.grd_4c_GradeOpe
206: 
207:             *-- Col1: Flag (checkbox de selecao)
208:             WITH .Column1
209:                 .Width     = 17
210:                 .Movable   = .F.
211:                 .Resizable = .F.
212:                 .Sparse    = .F.
213:                 WITH .Header1
214:                     .Caption   = ""
215:                     .Alignment = 2
216:                     .FontName  = "Verdana"
217:                     .FontSize  = 8
218:                     .ForeColor = RGB(36,84,155)
219:                 ENDWITH
220:                 .AddObject("chk_4c_Flag", "CheckBox")
221:                 WITH .chk_4c_Flag
222:                     .Caption   = ""
223:                     .Alignment = 0
224:                     .Height    = 17
225:                     .Width     = 60
226:                 ENDWITH
227:                 .CurrentControl = "chk_4c_Flag"

*-- Linhas 234 a 242:
234:                 .Resizable = .F.
235:                 .ReadOnly  = .T.
236:                 WITH .Header1
237:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
238:                     .Alignment = 2
239:                     .FontName  = "Verdana"
240:                     .FontSize  = 8
241:                     .ForeColor = RGB(36,84,155)
242:                 ENDWITH

*-- Linhas 257 a 265:
257:                 .Resizable = .F.
258:                 .ReadOnly  = .T.
259:                 WITH .Header1
260:                     .Caption   = "N" + CHR(250) + "mero"
261:                     .Alignment = 2
262:                     .FontName  = "Verdana"
263:                     .FontSize  = 8
264:                     .ForeColor = RGB(36,84,155)
265:                 ENDWITH

*-- Linhas 280 a 288:
280:                 .Resizable = .F.
281:                 .ReadOnly  = .T.
282:                 WITH .Header1
283:                     .Caption   = "Emiss" + CHR(227) + "o"
284:                     .Alignment = 2
285:                     .FontName  = "Verdana"
286:                     .FontSize  = 8
287:                     .ForeColor = RGB(36,84,155)
288:                 ENDWITH

*-- Linhas 303 a 311:
303:                 .Resizable = .F.
304:                 .ReadOnly  = .T.
305:                 WITH .Header1
306:                     .Caption   = "Entrega"
307:                     .Alignment = 2
308:                     .FontName  = "Verdana"
309:                     .FontSize  = 8
310:                     .ForeColor = RGB(36,84,155)
311:                 ENDWITH

*-- Linhas 327 a 335:
327:                 .ReadOnly  = .T.
328:                 .InputMask = "999,999.99"
329:                 WITH .Header1
330:                     .Caption   = "Peso"
331:                     .Alignment = 2
332:                     .FontName  = "Verdana"
333:                     .FontSize  = 8
334:                     .ForeColor = RGB(36,84,155)
335:                 ENDWITH

*-- Linhas 350 a 358:
350:                 .Resizable = .F.
351:                 .ReadOnly  = .T.
352:                 WITH .Header1
353:                     .Caption   = "Respons" + CHR(225) + "vel"
354:                     .Alignment = 2
355:                     .FontName  = "Verdana"
356:                     .FontSize  = 8
357:                     .ForeColor = RGB(36,84,155)
358:                 ENDWITH

*-- Linhas 373 a 381:
373:                 .Resizable = .F.
374:                 .ReadOnly  = .T.
375:                 WITH .Header1
376:                     .Caption   = "Cliente"
377:                     .Alignment = 2
378:                     .FontName  = "Verdana"
379:                     .FontSize  = 8
380:                     .ForeColor = RGB(36,84,155)
381:                 ENDWITH

*-- Linhas 396 a 404:
396:                 .Resizable = .F.
397:                 .ReadOnly  = .T.
398:                 WITH .Header1
399:                     .Caption   = "Obs"
400:                     .Alignment = 2
401:                     .FontName  = "Verdana"
402:                     .FontSize  = 8
403:                     .ForeColor = RGB(36,84,155)
404:                 ENDWITH

*-- Linhas 420 a 428:
420:                 .Movable   = .F.
421:                 .Resizable = .F.
422:                 WITH .Header1
423:                     .Caption   = "Doc."
424:                     .Alignment = 2
425:                     .FontName  = "Verdana"
426:                     .FontSize  = 8
427:                     .ForeColor = RGB(36,84,155)
428:                 ENDWITH

*-- Linhas 437 a 502:
437:         ENDWITH
438: 
439:         *-- Label "Cliente :"
440:         THIS.AddObject("lbl_4c_Cliente", "Label")
441:         WITH THIS.lbl_4c_Cliente
442:             .Top       = 317
443:             .Left      = 5
444:             .Width     = 42
445:             .Height    = 15
446:             .AutoSize  = .T.
447:             .Caption   = "Cliente :"
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .BackStyle = 0
451:             .ForeColor = RGB(90,90,90)
452:         ENDWITH
453: 
454:         *-- TextBox do Cliente (somente leitura - exibe DConta)
455:         THIS.AddObject("txt_4c_Cliente", "TextBox")
456:         WITH THIS.txt_4c_Cliente
457:             .Top           = 313
458:             .Left          = 59
459:             .Width         = 345
460:             .Height        = 23
461:             .SpecialEffect = 1
462:             .ReadOnly      = .T.
463:             .FontName      = "Tahoma"
464:             .FontSize      = 8
465:         ENDWITH
466: 
467:         *-- Grade de Itens (top=339, 8 colunas)
468:         THIS.AddObject("grd_4c_GradeItens", "Grid")
469:         WITH THIS.grd_4c_GradeItens
470:             .Top               = 339
471:             .Left              = 5
472:             .Width             = 737
473:             .Height            = 191
474:             .ColumnCount       = 8
475:             .FontSize          = 8
476:             .AllowHeaderSizing = .F.
477:             .AllowRowSizing    = .F.
478:             .DeleteMark        = .F.
479:             .RecordMark        = .F.
480:             .RowHeight         = 17
481:             .ScrollBars        = 2
482:             .GridLineColor     = RGB(238,238,238)
483:             .Panel             = 1
484:         ENDWITH
485: 
486:         *-- Configurar colunas da GradeItens
487:         WITH THIS.grd_4c_GradeItens
488: 
489:             *-- Col1: Produto (Cpros) - ColumnOrder=1 (default)
490:             WITH .Column1
491:                 .Width     = 120
492:                 .Movable   = .F.
493:                 .Resizable = .F.
494:                 .ReadOnly  = .T.
495:                 WITH .Header1
496:                     .Caption   = "Produto"
497:                     .Alignment = 2
498:                     .FontName  = "Verdana"
499:                     .FontSize  = 8
500:                     .ForeColor = RGB(36,84,155)
501:                 ENDWITH
502:                 WITH .Text1

*-- Linhas 517 a 525:
517:                 .Resizable   = .F.
518:                 .ReadOnly    = .T.
519:                 WITH .Header1
520:                     .Caption   = "Quantidade"
521:                     .Alignment = 2
522:                     .FontName  = "Verdana"
523:                     .FontSize  = 8
524:                     .ForeColor = RGB(36,84,155)
525:                 ENDWITH

*-- Linhas 541 a 549:
541:                 .Resizable   = .F.
542:                 .ReadOnly    = .T.
543:                 WITH .Header1
544:                     .Caption   = "Saldo"
545:                     .Alignment = 2
546:                     .FontName  = "Verdana"
547:                     .FontSize  = 8
548:                     .ForeColor = RGB(36,84,155)
549:                 ENDWITH

*-- Linhas 565 a 573:
565:                 .Resizable   = .F.
566:                 .ReadOnly    = .T.
567:                 WITH .Header1
568:                     .Caption   = "Peso"
569:                     .Alignment = 2
570:                     .FontName  = "Verdana"
571:                     .FontSize  = 8
572:                     .ForeColor = RGB(36,84,155)
573:                 ENDWITH

*-- Linhas 589 a 597:
589:                 .Resizable   = .F.
590:                 .ReadOnly    = .T.
591:                 WITH .Header1
592:                     .Caption   = "Obs"
593:                     .Alignment = 2
594:                     .FontName  = "Verdana"
595:                     .FontSize  = 8
596:                     .ForeColor = RGB(36,84,155)
597:                 ENDWITH

*-- Linhas 615 a 623:
615:                 .Resizable   = .F.
616:                 .ReadOnly    = .T.
617:                 WITH .Header1
618:                     .Caption   = "Cor"
619:                     .Alignment = 2
620:                     .FontName  = "Verdana"
621:                     .FontSize  = 8
622:                     .ForeColor = RGB(36,84,155)
623:                 ENDWITH

*-- Linhas 639 a 647:
639:                 .Resizable   = .F.
640:                 .ReadOnly    = .T.
641:                 WITH .Header1
642:                     .Caption   = "Tam"
643:                     .Alignment = 2
644:                     .FontName  = "Verdana"
645:                     .FontSize  = 8
646:                     .ForeColor = RGB(36,84,155)
647:                 ENDWITH

*-- Linhas 663 a 671:
663:                 .Resizable   = .F.
664:                 .ReadOnly    = .T.
665:                 WITH .Header1
666:                     .Caption   = "Ref. Fornecedor"
667:                     .Alignment = 2
668:                     .FontName  = "Verdana"
669:                     .FontSize  = 8
670:                     .ForeColor = RGB(36,84,155)
671:                 ENDWITH

*-- Linhas 682 a 757:
682:         ENDWITH
683: 
684:         *-- Botao Desmarca Tudo (top=358, left=748, ao lado da GradeItens)
685:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
686:         WITH THIS.cmd_4c_Apaga
687:             .Top             = 358
688:             .Left            = 748
689:             .Width           = 40
690:             .Height          = 40
691:             .Caption         = ""
692:             .ToolTipText     = "Desmarca Tudo"
693:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
694:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
695:             .FontName        = "Verdana"
696:             .FontSize        = 8
697:             .ForeColor       = RGB(36,84,155)
698:             .BackColor       = RGB(255,255,255)
699:             .Themes          = .T.
700:         ENDWITH
701: 
702:         *-- Botao Seleciona Tudo (top=400, left=748, ao lado da GradeItens)
703:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
704:         WITH THIS.cmd_4c_SelTudo
705:             .Top             = 400
706:             .Left            = 748
707:             .Width           = 40
708:             .Height          = 40
709:             .Caption         = ""
710:             .ToolTipText     = "Seleciona Tudo"
711:             .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
712:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
713:             .FontName        = "Verdana"
714:             .FontSize        = 8
715:             .ForeColor       = RGB(36,84,155)
716:             .BackColor       = RGB(255,255,255)
717:             .Themes          = .T.
718:         ENDWITH
719: 
720:         *-- Label "Observacao do Item :"
721:         THIS.AddObject("lbl_4c_ObsItens", "Label")
722:         WITH THIS.lbl_4c_ObsItens
723:             .Top       = 532
724:             .Left      = 5
725:             .Width     = 146
726:             .Height    = 15
727:             .AutoSize  = .F.
728:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
729:             .FontBold  = .T.
730:             .FontName  = "Verdana"
731:             .FontSize  = 8
732:             .BackStyle = 0
733:             .ForeColor = RGB(90,90,90)
734:         ENDWITH
735: 
736:         *-- EditBox de observacao dos itens (editavel, top=548)
737:         THIS.AddObject("edt_4c_ObsItens", "EditBox")
738:         WITH THIS.edt_4c_ObsItens
739:             .Top         = 548
740:             .Left        = 5
741:             .Width       = 737
742:             .Height      = 47
743:             .NullDisplay = " "
744:             .FontName    = "Tahoma"
745:             .FontSize    = 8
746:         ENDWITH
747: 
748:         *-- Shape decorativo na area dos botoes de acao (topo-direita)
749:         THIS.AddObject("shp_4c_Shape3", "Shape")
750:         WITH THIS.shp_4c_Shape3
751:             .Top         = 7
752:             .Left        = 732
753:             .Width       = 60
754:             .Height      = 29
755:             .BorderStyle = 1
756:             .BorderWidth = 1
757:             .FillStyle   = 1

*-- Linhas 763 a 804:
763:     * ConfigurarGrades - Define RecordSource e ControlSource das grades
764:     *--------------------------------------------------------------------------
765:     PROTECTED PROCEDURE ConfigurarGrades()
766: 
767:         *-- GradeOperacoes vinculada a TmpCabec
768:         WITH THIS.grd_4c_GradeOpe
769:             .RecordSource           = "TmpCabec"
770:             .Column1.ControlSource  = "TmpCabec.Flag"
771:             .Column2.ControlSource  = "TmpCabec.Dopes"
772:             .Column3.ControlSource  = "TmpCabec.Numes"
773:             .Column4.ControlSource  = "TmpCabec.Datas"
774:             .Column5.ControlSource  = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
775:             .Column6.ControlSource  = "TmpCabec.Peso"
776:             .Column7.ControlSource  = "TmpCabec.Contav"
777:             .Column8.ControlSource  = "TmpCabec.Conta"
778:             .Column9.ControlSource  = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
779:             .Column10.ControlSource = "TmpCabec.Notas"
780:         ENDWITH
781: 
782:         *-- Cliente (nome do cliente da operacao atual)
783:         THIS.txt_4c_Cliente.ControlSource = "TmpCabec.DConta"
784: 
785:         *-- Obs da operacao (editavel)
786:         THIS.edt_4c_ObsOpe.ControlSource = "TmpCabec.Obs"
787: 
788:         *-- GradeItens vinculada a TmpItens
789:         WITH THIS.grd_4c_GradeItens
790:             .RecordSource          = "TmpItens"
791:             .Column1.ControlSource = "TmpItens.Cpros"
792:             .Column2.ControlSource = "TmpItens.Qtds"
793:             .Column3.ControlSource = "TmpItens.Saldo"
794:             .Column4.ControlSource = "TmpItens.Peso"
795:             .Column5.ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
796:             .Column6.ControlSource = "TmpItens.CodCors"
797:             .Column7.ControlSource = "TmpItens.CodTams"
798:             .Column8.ControlSource = "TmpItens.Reffs"
799:         ENDWITH
800: 
801:         *-- Obs dos itens (editavel)
802:         THIS.edt_4c_ObsItens.ControlSource = "TmpItens.Obs"
803: 
804:         *-- Posicionar TmpItens filtrado pelo primeiro registro de TmpCabec

*-- Linhas 816 a 906:
816:     *--------------------------------------------------------------------------
817:     * RegistrarEventos - BINDEVENT para todos os eventos interativos
818:     *--------------------------------------------------------------------------
819:     PROTECTED PROCEDURE RegistrarEventos()
820: 
821:         BINDEVENT(THIS.grd_4c_GradeOpe, "AfterRowColChange", THIS, "AoMudarLinhaOpe")
822:         BINDEVENT(THIS.grd_4c_GradeOpe.Column2.Header1, "Click", THIS, "AoClicarCabMovi")
823:         BINDEVENT(THIS.grd_4c_GradeOpe.Column5.Header1, "Click", THIS, "AoClicarCabEntrega")
824:         BINDEVENT(THIS.grd_4c_GradeItens, "AfterRowColChange", THIS, "AoMudarLinhaItens")
825:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "AoProcessar")
826:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "AoCancelar")
827:         BINDEVENT(THIS.cmd_4c_Apaga,     "Click", THIS, "AoApagar")
828:         BINDEVENT(THIS.cmd_4c_SelTudo,   "Click", THIS, "AoSelTudo")
829: 
830:     ENDPROC
831: 
832:     *--------------------------------------------------------------------------
833:     * AplicarOrdem - Ordena TmpCabec e atualiza cores dos cabecalhos das colunas
834:     * par_cOrdem: "EMPDOPNUM" | "ENTREGA" | "" (usa ordem atual do BO)
835:     *--------------------------------------------------------------------------
836:     PROTECTED PROCEDURE AplicarOrdem(par_cOrdem)
837:         LOCAL loc_cOrdAtual
838: 
839:         THIS.this_oBusinessObject.OrdenarOperacoes(par_cOrdem)
840:         loc_cOrdAtual = UPPER(THIS.this_oBusinessObject.this_cOrdConta)
841: 
842:         WITH THIS.grd_4c_GradeOpe
843:             .Column2.Header1.BackColor = IIF(loc_cOrdAtual = "EMPDOPNUM", RGB(220,255,220), RGB(192,192,192))
844:             .Column5.Header1.BackColor = IIF(loc_cOrdAtual = "ENTREGA",   RGB(220,255,220), RGB(192,192,192))
845:         ENDWITH
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * HANDLERS DE EVENTOS (PUBLIC - exigido por BINDEVENT)
850:     *==========================================================================
851: 
852:     *--------------------------------------------------------------------------
853:     * AoMudarLinhaOpe - AfterRowColChange da GradeOpe
854:     * Filtra TmpItens para exibir itens da operacao selecionada
855:     *--------------------------------------------------------------------------
856:     PROCEDURE AoMudarLinhaOpe(par_nColIndex)
857:         IF USED("TmpItens") AND USED("TmpCabec")
858:             SELECT TmpItens
859:             SET ORDER TO EmpDopNum
860:             SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
861:             GO TOP
862:             THIS.txt_4c_Cliente.Refresh()
863:             THIS.edt_4c_ObsOpe.Refresh()
864:             THIS.grd_4c_GradeItens.Refresh()
865:             THIS.edt_4c_ObsItens.Refresh()
866:         ENDIF
867:     ENDPROC
868: 
869:     *--------------------------------------------------------------------------
870:     * AoClicarCabMovi - Click no Header da Coluna 2 (Movimentacao)
871:     * Ordena TmpCabec por EmpDopNum
872:     *--------------------------------------------------------------------------
873:     PROCEDURE AoClicarCabMovi()
874:         IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "EMPDOPNUM"
875:             THIS.AplicarOrdem("EMPDOPNUM")
876:             SELECT TmpCabec
877:             GO TOP
878:             THIS.grd_4c_GradeOpe.Refresh()
879:         ENDIF
880:     ENDPROC
881: 
882:     *--------------------------------------------------------------------------
883:     * AoClicarCabEntrega - Click no Header da Coluna 5 (Entrega)
884:     * Ordena TmpCabec por data de entrega
885:     *--------------------------------------------------------------------------
886:     PROCEDURE AoClicarCabEntrega()
887:         IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "ENTREGA"
888:             THIS.AplicarOrdem("ENTREGA")
889:             SELECT TmpCabec
890:             GO TOP
891:             THIS.grd_4c_GradeOpe.Refresh()
892:         ENDIF
893:     ENDPROC
894: 
895:     *--------------------------------------------------------------------------
896:     * AoMudarLinhaItens - AfterRowColChange da GradeItens
897:     * Atualiza editbox de observacao do item
898:     *--------------------------------------------------------------------------
899:     PROCEDURE AoMudarLinhaItens(par_nColIndex)
900:         THIS.edt_4c_ObsItens.Refresh()
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------
904:     * AoProcessar - Click do botao Processar
905:     * Chama BO.ProcessarOperacoes() e navega para o form seguinte
906:     *--------------------------------------------------------------------------

*-- Linhas 924 a 932:
924:         IF loc_lSucesso
925:             THIS.Enabled = .F.
926:             IF THIS.this_lReservaAuto
927:                 THIS.cmd_4c_Processar.Enabled = .F.
928:             ENDIF
929: 
930:             *-- Abrir form seguinte conforme flag do BO
931:             IF THIS.this_oBusinessObject.this_lTemEstimado
932:                 *-- Ha estoque estimado: abre SigPrGlx (grade com estimados)

*-- Linhas 962 a 1093:
962:     * AoApagar - Click do botao Desmarca Tudo
963:     *--------------------------------------------------------------------------
964:     PROCEDURE AoApagar()
965:         IF USED("TmpCabec")
966:             REPLACE ALL Flag WITH .F. IN TmpCabec
967:             THIS.grd_4c_GradeOpe.Refresh()
968:         ENDIF
969:     ENDPROC
970: 
971:     *--------------------------------------------------------------------------
972:     * AoSelTudo - Click do botao Seleciona Tudo
973:     *--------------------------------------------------------------------------
974:     PROCEDURE AoSelTudo()
975:         IF USED("TmpCabec")
976:             REPLACE ALL Flag WITH .T. IN TmpCabec
977:             THIS.grd_4c_GradeOpe.Refresh()
978:         ENDIF
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     * ConfigurarPageFrame - Constroi o "frame" visual do form OPERACIONAL:
983:     * cnt_4c_Cabecalho (cabecalho cinza) com labels de titulo.
984:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
985:     * estrutura fixa do topo, mantendo o nome padrao do pipeline multi-fase.
986:     *--------------------------------------------------------------------------
987:     PROTECTED PROCEDURE ConfigurarPageFrame()
988:         LOCAL loc_oCab
989:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
990:         loc_oCab = THIS.cnt_4c_Cabecalho
991:         WITH loc_oCab
992:             .Top         = 0
993:             .Left        = 0
994:             .Width       = THIS.Width
995:             .Height      = 80
996:             .BackColor   = RGB(100, 100, 100)
997:             .BackStyle   = 1
998:             .BorderWidth = 0
999:             .Visible     = .T.
1000:         ENDWITH
1001: 
1002:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
1003:         WITH loc_oCab.lbl_4c_Sombra
1004:             .FontBold   = .T.
1005:             .FontName   = "Tahoma"
1006:             .FontSize   = 18
1007:             .AutoSize   = .F.
1008:             .WordWrap   = .T.
1009:             .Alignment  = 0
1010:             .BackStyle  = 0
1011:             .Caption    = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"
1012:             .Height     = 40
1013:             .Left       = 10
1014:             .Top        = 18
1015:             .Width      = THIS.Width - 20
1016:             .ForeColor  = RGB(0, 0, 0)
1017:             .Visible    = .T.
1018:         ENDWITH
1019: 
1020:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
1021:         WITH loc_oCab.lbl_4c_Titulo
1022:             .FontBold    = .T.
1023:             .FontName    = "Tahoma"
1024:             .FontSize    = 18
1025:             .AutoSize    = .F.
1026:             .WordWrap    = .T.
1027:             .Alignment   = 0
1028:             .BackStyle   = 0
1029:             .Caption     = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"
1030:             .Height      = 46
1031:             .Left        = 10
1032:             .Top         = 17
1033:             .Width       = THIS.Width - 20
1034:             .ForeColor   = RGB(255, 255, 255)
1035:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
1036:             .Visible     = .T.
1037:         ENDWITH
1038:     ENDPROC
1039: 
1040:     *--------------------------------------------------------------------------
1041:     * ConfigurarPaginaLista - Configura a area de lista (equivalente a Page1
1042:     * em forms CRUD). Para este form OPERACIONAL, o layout completo e montado
1043:     * em MontarLayout/ConfigurarGrades; este metodo e o ponto de entrada
1044:     * nomeado para compatibilidade com o pipeline multi-fase.
1045:     *--------------------------------------------------------------------------
1046:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1047:         IF VARTYPE(THIS.grd_4c_GradeOpe) = "O" AND !ISNULL(THIS.grd_4c_GradeOpe)
1048:             THIS.ConfigurarGrades()
1049:         ENDIF
1050:     ENDPROC
1051:     *--------------------------------------------------------------------------
1052:     * ConfigurarPaginaDados - Propriedades visuais dos controles interativos:
1053:     *   - grd_4c_GradeOpe:    highlight e fonte
1054:     *   - edt_4c_ObsOpe:      aparencia e scrollbar
1055:     *   - grd_4c_GradeItens:  highlight e fonte
1056:     *   - edt_4c_ObsItens:    aparencia e scrollbar
1057:     *   - txt_4c_Cliente:     aparencia somente-leitura
1058:     *--------------------------------------------------------------------------
1059:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1060: 
1061:         *-- GradeOperacoes: highlight de linha selecionada e fonte
1062:         WITH THIS.grd_4c_GradeOpe
1063:             .HighlightBackColor = RGB(255, 255, 255)
1064:             .HighlightForeColor = RGB(15, 41, 104)
1065:             .HighlightStyle     = 2
1066:             .FontName = "Verdana"
1067:             .FontSize = 8
1068:         ENDWITH
1069: 
1070:         *-- EditBox de Observacao da Operacao
1071:         WITH THIS.edt_4c_ObsOpe
1072:             .BackColor  = RGB(255, 255, 255)
1073:             .ForeColor  = RGB(90, 90, 90)
1074:             .ScrollBars = 3
1075:         ENDWITH
1076: 
1077:         *-- GradeItens: highlight de linha selecionada e fonte
1078:         WITH THIS.grd_4c_GradeItens
1079:             .HighlightBackColor = RGB(255, 255, 255)
1080:             .HighlightForeColor = RGB(15, 41, 104)
1081:             .HighlightStyle     = 2
1082:             .FontName = "Verdana"
1083:             .FontSize = 8
1084:         ENDWITH
1085: 
1086:         *-- EditBox de Observacao dos Itens
1087:         WITH THIS.edt_4c_ObsItens
1088:             .BackColor  = RGB(255, 255, 255)
1089:             .ForeColor  = RGB(90, 90, 90)
1090:             .ScrollBars = 3
1091:         ENDWITH
1092: 
1093:         *-- TextBox Cliente: fundo levemente cinza para indicar somente-leitura

*-- Linhas 1193 a 1213:
1193:         TRY
1194:             IF USED("TmpCabec") AND USED("TmpItens")
1195:                 THIS.AplicarOrdem("")
1196:                 SELECT TmpCabec
1197:                 GO TOP
1198:                 THIS.grd_4c_GradeOpe.Refresh()
1199:                 THIS.AoMudarLinhaOpe(0)
1200:                 THIS.HabilitarCampos()
1201:                 loc_lSucesso = .T.
1202:             ELSE
1203:                 MsgAviso("Cursores TmpCabec/TmpItens n" + CHR(227) + "o disponibilizados pelo form pai.", ;
1204:                          "Aviso")
1205:             ENDIF
1206:         CATCH TO loc_oErro
1207:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
1208:         ENDTRY
1209: 
1210:         RETURN loc_lSucesso
1211:     ENDPROC
1212: 
1213:     *--------------------------------------------------------------------------

*-- Linhas 1239 a 1264:
1239:     PROTECTED PROCEDURE BOParaForm()
1240:         LOCAL loc_oErro
1241: 
1242:         TRY
1243:             IF USED("TmpCabec")
1244:                 THIS.grd_4c_GradeOpe.Refresh()
1245:                 THIS.txt_4c_Cliente.Refresh()
1246:                 THIS.edt_4c_ObsOpe.Refresh()
1247:             ENDIF
1248:             IF USED("TmpItens")
1249:                 THIS.grd_4c_GradeItens.Refresh()
1250:                 THIS.edt_4c_ObsItens.Refresh()
1251:             ENDIF
1252:         CATCH TO loc_oErro
1253:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
1254:         ENDTRY
1255:     ENDPROC
1256: 
1257:     *--------------------------------------------------------------------------
1258:     * HabilitarCampos - Gerencia estado do botao Processar: habilitado apenas
1259:     * quando ha ao menos uma operacao marcada (Flag=.T.) em TmpCabec.
1260:     *--------------------------------------------------------------------------
1261:     PROCEDURE HabilitarCampos()
1262:         LOCAL loc_lTemSelecionado, loc_nI, loc_oErro
1263:         loc_lTemSelecionado = .F.
1264: 

*-- Linhas 1272 a 1281:
1272:                 ENDSCAN
1273:             ENDIF
1274: 
1275:             IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1276:                 THIS.cmd_4c_Processar.Enabled = loc_lTemSelecionado
1277:             ENDIF
1278: 
1279:         CATCH TO loc_oErro
1280:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
1281:         ENDTRY

*-- Linhas 1289 a 1309:
1289:         LOCAL loc_oErro
1290: 
1291:         TRY
1292:             IF USED("TmpCabec")
1293:                 REPLACE ALL Flag WITH .F. IN TmpCabec
1294:                 THIS.grd_4c_GradeOpe.Refresh()
1295:             ENDIF
1296: 
1297:             IF VARTYPE(THIS.edt_4c_ObsOpe) = "O"
1298:                 THIS.edt_4c_ObsOpe.Refresh()
1299:             ENDIF
1300:             IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
1301:                 THIS.edt_4c_ObsItens.Refresh()
1302:             ENDIF
1303:             IF VARTYPE(THIS.txt_4c_Cliente) = "O"
1304:                 THIS.txt_4c_Cliente.Refresh()
1305:             ENDIF
1306: 
1307:         CATCH TO loc_oErro
1308:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
1309:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):
*==============================================================================
* SigPrGl2BO.prg - Business Object: Geracao de Ordens de Producao
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sem CRUD direto - processamento de OPs)
* Tabelas usadas: SigCdCeg, SigMvEst, SigTempd, SigMvCab, SigMvItn,
*                 SigMvIts, SigCdOpe, SigCdPro, SigOpPic, SigCdNec,
*                 SigPdMvf, CrSigTempd (cursor do framework)
* Cursores de entrada (recebidos do form pai):
*   TmpCabec - Cabecalho das operacoes selecionadas
*   TmpItens - Itens das operacoes selecionadas
*   TmpOper  - Tabela de operacoes (tipos de movimentacao)
*   CrSigCdPam, CrSigCdPac - Parametros do sistema
*   CrSigTempd - Cursor temporario de estoques (do framework)
*==============================================================================
DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Entidade persistida: SigTempd (tabela de trabalho de sessoes de geracao de OPs)
    this_cTabela     = "SigTempd"
    this_cCampoChave = "CidChaves"

    *-- Estado da sessao de processamento (recebidos do form pai via Init)
    this_lReserva    = .F.    && Flag: reserva automatica de estoque
    this_lAutomatico = .F.    && Flag: processamento automatico (sem confirmacao)
    this_nEmphPdr    = 0      && Empresa padrao para geracao de OPs
    this_nNumeroDaOP = 0      && Numero da OP destino (passado do form pai)
    this_cPorDestino = ""     && Codigo de destino (PorDestino do form pai)
    this_cOrdConta   = ""     && Ordenacao atual do grid de operacoes

    *-- Propriedades da entidade SigTempd (registro de trabalho da sessao)
    this_cCidChaves  = ""     && char(64) PK do registro SigTempd
    this_cCidQuerys  = ""     && char(20) ID de sessao (agrupa varios cidchaves)
    this_cGrupos     = ""     && char(10) Grupo de estoque
    this_cContas     = ""     && char(10) Conta de estoque
    this_cEmps       = ""     && char(3)  Empresa
    this_nCodObs     = 0      && numeric(3,0) Prioridade do centro de estoque

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela     = "SigTempd"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- Flag: .T. se processamento deve abrir SigPrGlx (com estimados), .F. para SigPrGlp
    this_lTemEstimado = .F.

    *--------------------------------------------------------------------------
    * ProcessarOperacoes - Processa operacoes selecionadas e prepara cursores
    * para o proximo sub-form (SigPrGlx ou SigPrGlp).
    * Parametros: par_lReserva     - flag reserva automatica
    *             par_lAutomatico  - flag processamento automatico
    *             par_nEmphPdr     - empresa padrao
    *             par_nNumeroDaOP  - numero da OP destino
    *             par_cPorDestino  - codigo de destino
    * Retorno: .T. se ok, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOperacoes(par_lReserva, par_lAutomatico, par_nEmphPdr, par_nNumeroDaOP, par_cPorDestino)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cEmpresa, loc_cCidQuerys
        LOCAL loc_nContador, loc_lcJob
        LOCAL loc_cSQL
        LOCAL loc_xBaixa, loc_nEstoque, loc_nProduzir, loc_nSaldo
        LOCAL loc_lcEdn, loc_nItn
        LOCAL loc_cPEdI, loc_cPEdF
        LOCAL loc_lProduzirTudo, loc_llData
        LOCAL loc_llFalse

        loc_lResultado = .T.
        loc_cEmpresa   = go_4c_Sistema.cCodEmpresa

        TRY
            *-- PASSO 1: Validar selecao e verificar Jobs iguais
            SELECT TmpCabec
            SET ORDER TO EmpDopNum

            loc_nContador = 0
            GO TOP
            loc_lcJob = ALLTRIM(NVL(TmpCabec.Jobs, ""))

            SCAN FOR Flag
                loc_nContador = loc_nContador + 1
                IF ALLTRIM(NVL(TmpCabec.Jobs,"")) <> loc_lcJob
                    MsgAviso("N" + CHR(227) + "o " + CHR(233) + " permitido gerar OPs de opera" + ;
                             CHR(231) + CHR(245) + "es com Jobs diferentes.", "Aviso")
                    loc_lResultado = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lResultado AND loc_nContador = 0
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!", "Aviso")
                loc_lResultado = .F.
            ENDIF

            *-- PASSO 2: Preparar chave de sessao e buscar centros de estoque
            IF loc_lResultado
                loc_cCidQuerys = fUniqueIds()

                loc_cSQL = "SELECT * FROM SigCdCeg WHERE TpCads <> 1"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpCeg") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpCeg). Favor reinicializar o processo.", "Erro")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- PASSO 3: Popular SigTempd com prioridades de estoque
            IF loc_lResultado
                loc_cSQL = "DELETE FROM SigTempd WHERE CidQuerys = '" + ALLTRIM(loc_cCidQuerys) + "'"
                SQLEXEC(gnConnHandle, loc_cSQL)

                SELECT TmpCeg
                IF RECCOUNT("TmpCeg") > 0
                    SCAN
                        IF loc_lResultado
                            loc_cSQL = "INSERT INTO SigTempd " + ;
                                "(Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Grupos,""))) + ", " + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Contas,""))) + ", " + ;
                                FormatarNumeroSQL(NVL(TmpCeg.Priors, 0), 0) + ", " + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Emps,""))) + ", " + ;
                                EscaparSQL(fUniqueIds()) + ", " + ;
                                EscaparSQL(loc_cCidQuerys) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ELSE
                    IF USED("crSigCdPam")
                        loc_cSQL = "INSERT INTO SigTempd " + ;
                            "(Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                            EscaparSQL(ALLTRIM(NVL(crSigCdPam.GrupoEsts,""))) + ", " + ;
                            EscaparSQL(ALLTRIM(NVL(crSigCdPam.ContaEsts,""))) + ", " + ;
                            "1, " + ;
                            EscaparSQL(ALLTRIM(loc_cEmpresa)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", " + ;
                            EscaparSQL(loc_cCidQuerys) + ")"
                        loc_lResultado = SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                    ENDIF
                ENDIF

                IF !loc_lResultado
                    MsgErro("Falha ao gravar em SigTempd. Favor reinicializar o processo.", "Erro")
                ENDIF
            ENDIF

            *-- PASSO 4: Buscar estoque disponivel via SigMvEst x SigTempd
            IF loc_lResultado
                loc_cSQL = "SELECT a.CPros, a.CodCors, a.CodTams, a.Grupos, a.Estos, " + ;
                    "a.SQtds, a.Emps, b.CodObs AS Priors " + ;
                    "FROM SigMvEst a, SigTempd b " + ;
                    "WHERE a.Grupos = b.Grupos AND a.Estos = b.Contas " + ;
                    "AND a.Emps = b.Emps AND a.Sqtds > 0 " + ;
                    "UNION " + ;
                    "SELECT a.CPros, a.CodCors, a.CodTams, a.Grupos, a.Estos, " + ;
                    "a.SQtds, a.Emps, b.CodObs AS Priors " + ;
                    "FROM SigMvEst a, SigTempd b " + ;
                    "WHERE a.Grupos = b.Grupos AND b.Contas = '' " + ;
                    "AND a.Emps = b.Emps AND a.Sqtds > 0"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpEstoque") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpEstoque). Favor reinicializar.", "Erro")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- PASSO 5: Limpar SigTempd desta sessao
            IF loc_lResultado
                loc_cSQL = "DELETE FROM SigTempd WHERE CidQuerys = '" + ALLTRIM(loc_cCidQuerys) + "'"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            *-- PASSO 6: Criar cursores de saldo TmpSaldo e TmpSaldg
            IF loc_lResultado
                SET NULL ON
                CREATE CURSOR TmpSaldo (CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Saldo N(12,3) NULL, Disps N(12,3) NULL, Fabrs N(12,3) NULL, DispFs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams TAG CPros

                CREATE CURSOR TmpSaldg (Emps C(3) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
                    CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Saldo N(12,3) NULL, Disps N(12,3) NULL, Priors N(2,0) NULL, Reservs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams + STR(NVL(Priors,0),2) + Grupos + Estos + Emps TAG CPros
                INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
                SET NULL OFF

                SELECT TmpEstoque
                SCAN
                    SELECT TmpSaldo
                    IF NOT SEEK(ALLTRIM(NVL(TmpEstoque.CPros,"")) + ;
                                ALLTRIM(NVL(TmpEstoque.CodCors,"")) + ;
                                ALLTRIM(NVL(TmpEstoque.CodTams,"")))
                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                            VALUES (NVL(TmpEstoque.CPros,""), NVL(TmpEstoque.CodCors,""), ;
                                    NVL(TmpEstoque.CodTams,""), 0, 0)
                    ENDIF
                    REPLACE Saldo WITH NVL(Saldo,0) + NVL(TmpEstoque.SQtds,0), ;
                            Disps WITH NVL(Disps,0) + NVL(TmpEstoque.SQtds,0)

                    INSERT INTO TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, ;
                        Saldo, Disps, Priors, Emps) ;
                        VALUES (NVL(TmpEstoque.Grupos,""), NVL(TmpEstoque.Estos,""), ;
                                NVL(TmpEstoque.CPros,""), NVL(TmpEstoque.CodCors,""), ;
                                NVL(TmpEstoque.CodTams,""), NVL(TmpEstoque.SQtds,0), ;
                                NVL(TmpEstoque.SQtds,0), NVL(TmpEstoque.Priors,0), ;
                                NVL(TmpEstoque.Emps,""))
                ENDSCAN
            ENDIF

            *-- PASSO 7: Carregar operacao de transferencia e ajustar saldos por reservas
            IF loc_lResultado AND USED("crSigCdPam") AND !EMPTY(ALLTRIM(crSigCdPam.TransfRes))
                SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdOpe WHERE Dopes = '" + ALLTRIM(crSigCdPam.TransfRes) + "'", ;
                    "crSigCdOpe")

                IF USED("crSigCdOpe") AND !EOF("crSigCdOpe") AND NVL(crSigCdOpe.Estoqs, 0) <> 1
                    loc_cPEdI = ALLTRIM(loc_cEmpresa) + ALLTRIM(crSigCdPam.TransfRes) + STR(0, 6)
                    loc_cPEdF = ALLTRIM(loc_cEmpresa) + ALLTRIM(crSigCdPam.TransfRes) + STR(999999, 6)

                    loc_cSQL = "SELECT EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes " + ;
                        "FROM SigMvCab " + ;
                        "WHERE EmpDopNums BETWEEN '" + ALLTRIM(loc_cPEdI) + "' AND '" + ;
                        ALLTRIM(loc_cPEdF) + "' ORDER BY EmpDopNums"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEest") < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (TempEest). Favor reinicializar.", "Erro")
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- PASSO 7b: Ajustar saldos removendo qtds de reservas em transferencia
            IF loc_lResultado AND USED("TempEest") AND RECCOUNT("TempEest") > 0
                SELECT TempEest
                GO TOP
                SCAN
                    IF loc_lResultado
                        loc_lcEdn = ALLTRIM(NVL(TempEest.EmpDopNums,""))

                        IF SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn), ;
                            "TempEestI") < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (TempEestI).", "Erro")
                            loc_lResultado = .F.
                        ENDIF

                        IF loc_lResultado AND USED("TempEestI") AND RECCOUNT("TempEestI") > 0
                            SELECT TempEestI
                            SCAN
                                IF loc_lResultado AND ;
                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)) > 0

                                    loc_nItn = NVL(TempEestI.CItens, 0)
                                    loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                        "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn) + " " + ;
                                        "AND CItens = " + FormatarNumeroSQL(loc_nItn, 0)

                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                                        MsgErro("Falha na conex" + CHR(227) + "o (TempEsti2). " + ;
                                                "Favor reinicializar.", "Erro")
                                        loc_lResultado = .F.
                                    ENDIF

                                    IF loc_lResultado
                                        SELECT TempEsti2
                                        GO TOP
                                        IF EOF("TempEsti2")
                                            SELECT TmpSaldo
                                            SET ORDER TO CPros
                                            IF NOT SEEK(ALLTRIM(NVL(TempEestI.CPros,"")))
                                                INSERT INTO TmpSaldo (CPros) ;
                                                    VALUES (NVL(TempEestI.CPros,""))
                                            ENDIF
                                            REPLACE Saldo WITH NVL(Saldo,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)), ;
                                                    Disps WITH NVL(Disps,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0))

                                            SELECT TmpSaldg
                                            SET ORDER TO GruEstPro
                                            IF !SEEK(ALLTRIM(NVL(TempEest.Emps,"")) + ;
                                                     ALLTRIM(NVL(TempEest.GrupoOs,"")) + ;
                                                     ALLTRIM(NVL(TempEest.ContaOs,"")) + ;
                                                     ALLTRIM(NVL(TempEestI.CPros,"")))
                                                INSERT INTO TmpSaldg (Emps, Grupos, Estos, CPros, Priors) ;
                                                    VALUES (NVL(TempEest.Emps,""), NVL(TempEest.GrupoOs,""), ;
                                                            NVL(TempEest.ContaOs,""), NVL(TempEestI.CPros,""), 99)
                                            ENDIF
                                            REPLACE Saldo WITH NVL(Saldo,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)), ;
                                                    Disps WITH NVL(Disps,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0))
                                        ELSE
                                            SELECT TempEsti2
                                            SCAN
                                                IF loc_lResultado
                                                    loc_nSaldo = NVL(TempEsti2.Qtds,0) - NVL(TempEsti2.QtBaixas,0)
                                                    SELECT TmpSaldo
                                                    IF NOT SEEK(ALLTRIM(NVL(TempEsti2.CPros,"")) + ;
                                                                ALLTRIM(NVL(TempEsti2.CodCors,"")) + ;
                                                                ALLTRIM(NVL(TempEsti2.CodTams,"")))
                                                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                                            VALUES (NVL(TempEsti2.CPros,""), ;
                                                                    NVL(TempEsti2.CodCors,""), ;
                                                                    NVL(TempEsti2.CodTams,""))
                                                    ENDIF
                                                    REPLACE Saldo WITH NVL(Saldo,0) - loc_nSaldo, ;
                                                            Disps WITH NVL(Disps,0) - loc_nSaldo

                                                    SELECT TmpSaldg
                                                    SET ORDER TO GruEstPro
                                                    IF !SEEK(ALLTRIM(NVL(TempEest.Emps,"")) + ;
                                                             ALLTRIM(NVL(TempEest.GrupoOs,"")) + ;
                                                             ALLTRIM(NVL(TempEest.ContaOs,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CPros,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CodCors,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CodTams,"")))
                                                        INSERT INTO TmpSaldg ;
                                                            (Emps, Grupos, Estos, CPros, CodCors, CodTams, Priors) ;
                                                            VALUES (NVL(TempEest.Emps,""), ;
                                                                    NVL(TempEest.GrupoOs,""), ;
                                                                    NVL(TempEest.ContaOs,""), ;
                                                                    NVL(TempEsti2.CPros,""), ;
                                                                    NVL(TempEsti2.CodCors,""), ;
                                                                    NVL(TempEsti2.CodTams,""), 99)
                                                    ENDIF
                                                    REPLACE Saldo WITH NVL(Saldo,0) - loc_nSaldo, ;
                                                            Disps WITH NVL(Disps,0) - loc_nSaldo
                                                ENDIF
                                            ENDSCAN
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 8: Pre-carregar operacoes para lookup no scan principal
            IF loc_lResultado
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe", "cursor_4c_TmpOpe") >= 1
                    SELECT cursor_4c_TmpOpe
                    INDEX ON Dopes TAG Dopes
                ENDIF
            ENDIF

            *-- PASSO 9: Criar TmpFinal e calcular o que produzir por item
            IF loc_lResultado
                SET NULL ON
                CREATE CURSOR TmpFinal (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                    CPros C(14) NULL, Qtds N(10,3) NULL, Peso N(9,3) NULL, ;
                    Saldo N(10,3) NULL, Estoque N(10,3) NULL, Produzir N(10,3) NULL, ;
                    Obs M NULL, Obsps M NULL, Datas D NULL, Entregas D NULL, ;
                    CodCors C(4) NULL, CodTams C(4) NULL, Linhas C(10) NULL, ;
                    Citens N(10,0) NULL, Reffs C(40) NULL, Notas C(6) NULL, ;
                    Dpros C(40) NULL, GrupoDs C(10) NULL, ContaDs C(10) NULL, ;
                    KeySelM L NULL, Fabrs N(10,3) NULL, KeyPdes L NULL, Jobs C(10) NULL)
                INDEX ON CPros + CodCors + CodTams TAG CPros
                SET NULL OFF

                SELECT TmpItens
                SET KEY TO
                SET ORDER TO CPros

                SCAN
                    IF loc_lResultado
                        SELECT TmpCabec
                        SET ORDER TO EmpDopNum
                        SEEK ALLTRIM(NVL(TmpItens.Emps,"")) + ;
                             ALLTRIM(NVL(TmpItens.Dopes,"")) + ;
                             STR(NVL(TmpItens.Numes,0), 6)

                        IF !Flag
                            LOOP
                        ENDIF

                        IF NVL(TmpItens.Saldo,0) > 0
                            loc_nEstoque  = 0
                            loc_nProduzir = 0
                            loc_lProduzirTudo = .F.

                            *-- Verificar condicoes para usar estoque ou produzir tudo
                            IF USED("crSigCdPam") AND EMPTY(ALLTRIM(crSigCdPam.TransfRes))
                                loc_lProduzirTudo = .T.
                            ENDIF

                            IF !loc_lProduzirTudo AND USED("cursor_4c_TmpOpe")
                                SELECT cursor_4c_TmpOpe
                                SET ORDER TO Dopes
                                IF SEEK(ALLTRIM(NVL(TmpItens.Dopes,"")))
                                    IF NVL(cursor_4c_TmpOpe.ChkObs,0) <> 1 AND ;
                                        !EMPTY(ALLTRIM(NVL(TmpItens.Obs,"")))
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                    IF !loc_lProduzirTudo AND ;
                                        NVL(cursor_4c_TmpOpe.Reservas,0) = 2 AND !par_lReserva
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF !loc_lProduzirTudo
                                SELECT TmpSaldo
                                SET ORDER TO CPros
                                IF !SEEK(ALLTRIM(NVL(TmpItens.CPros,"")) + ;
                                         ALLTRIM(NVL(TmpItens.CodCors,"")) + ;
                                         ALLTRIM(NVL(TmpItens.CodTams,"")))
                                    loc_lProduzirTudo = .T.
                                ELSE
                                    IF NVL(TmpSaldo.Disps,0) < 0
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF loc_lProduzirTudo
                                loc_nProduzir = NVL(TmpItens.Saldo,0)
                            ELSE
                                *-- Ja posicionado em TmpSaldo pelo SEEK acima
                                loc_nEstoque = NVL(TmpSaldo.Disps,0)
                                IF NVL(TmpSaldo.Disps,0) >= NVL(TmpItens.Saldo,0)
                                    REPLACE TmpSaldo.Disps WITH ;
                                            NVL(TmpSaldo.Disps,0) - NVL(TmpItens.Saldo,0)
                                ELSE
                                    loc_nProduzir = NVL(TmpItens.Saldo,0) - NVL(TmpSaldo.Disps,0)
                                    REPLACE TmpSaldo.Disps WITH 0
                                ENDIF
                            ENDIF

                            IF SQLEXEC(gnConnHandle, ;
                                "SELECT * FROM SigCdPro WHERE CPros = '" + ;
                                ALLTRIM(NVL(TmpItens.CPros,"")) + "'", "crSigCdPro") < 1
                                MsgErro("Falha ao buscar SigCdPro.", "Erro")
                                loc_lResultado = .F.
                            ENDIF

                            IF loc_lResultado
                                INSERT INTO TmpFinal ;
                                    (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, ;
                                     Estoque, Produzir, Obsps, Obs, Datas, Entregas, ;
                                     CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                     Dpros, GrupoDs, ContaDs, Jobs) ;
                                    VALUES ;
                                    (NVL(TmpItens.Emps,""), NVL(TmpItens.Dopes,""), ;
                                     NVL(TmpItens.Numes,0), NVL(TmpItens.CPros,""), ;
                                     NVL(TmpItens.Qtds,0), NVL(TmpItens.Peso,0), ;
                                     NVL(TmpItens.Saldo,0), ;
                                     NVL(TmpItens.Saldo,0) - loc_nProduzir, ;
                                     loc_nProduzir, ;
                                     NVL(TmpItens.Obs,""), NVL(TmpCabec.Obs,""), ;
                                     NVL(TmpCabec.Datas,{}), NVL(TmpCabec.Entregas,{}), ;
                                     NVL(TmpItens.CodCors,""), NVL(TmpItens.CodTams,""), ;
                                     NVL(TmpItens.Linhas,""), NVL(TmpItens.CItens,0), ;
                                     NVL(crSigCdPro.Reffs,""), NVL(TmpItens.Notas,""), ;
                                     NVL(TmpItens.Dpros,""), NVL(TmpCabec.Grupods,""), ;
                                     NVL(TmpCabec.Contads,""), NVL(TmpCabec.Jobs,""))
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 10: Redistribuir diferenca de saldo entre grupos/estoques
            IF loc_lResultado
                SELECT TmpSaldo
                SCAN
                    IF NVL(TmpSaldo.Saldo,0) <> NVL(TmpSaldo.Disps,0)
                        loc_xBaixa = NVL(TmpSaldo.Saldo,0) - NVL(TmpSaldo.Disps,0)
                        SELECT TmpSaldg
                        SET ORDER TO CPros
                        =SEEK(ALLTRIM(NVL(TmpSaldo.CPros,"")) + ;
                              ALLTRIM(NVL(TmpSaldo.CodCors,"")) + ;
                              ALLTRIM(NVL(TmpSaldo.CodTams,"")))
                        SCAN WHILE ALLTRIM(NVL(CPros,"")) = ALLTRIM(NVL(TmpSaldo.CPros,"")) AND ;
                                    ALLTRIM(NVL(CodCors,"")) = ALLTRIM(NVL(TmpSaldo.CodCors,"")) AND ;
                                    ALLTRIM(NVL(CodTams,"")) = ALLTRIM(NVL(TmpSaldo.CodTams,"")) AND ;
                                    loc_xBaixa > 0
                            IF NVL(TmpSaldg.Disps,0) >= loc_xBaixa
                                REPLACE TmpSaldg.Disps WITH NVL(TmpSaldg.Disps,0) - loc_xBaixa
                                loc_xBaixa = 0
                            ELSE
                                loc_xBaixa = loc_xBaixa - NVL(TmpSaldg.Disps,0)
                                REPLACE TmpSaldg.Disps WITH 0
                            ENDIF
                        ENDSCAN
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 11: Se ha fabricacao estimada (DopEsts), calcular TmpFinalG
            IF loc_lResultado AND USED("crSigCdPac") AND !EMPTY(ALLTRIM(crSigCdPac.DopEsts))
                THIS.this_lTemEstimado = .T.
                loc_llFalse = .F.

                SET NULL ON
                CREATE CURSOR TmpFabr (Priors N(2,0) NULL, Nops N(10,0) NULL, Fases C(10) NULL, ;
                    CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Qtds N(10,3) NULL, Disps N(12,3) NULL, Reservs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams + STR(NVL(Priors,0),2) + STR(NVL(Nops,0),10) TAG CPros
                SET NULL OFF

                loc_cSQL = "SELECT a.Nops, a.CPros, a.CodCors, a.CodTams, SUM(a.Qtds) AS Qtds " + ;
                    "FROM SigOpPic a, SigCdNec b " + ;
                    "WHERE a.Dopes = '" + ALLTRIM(crSigCdPac.DopEsts) + "' " + ;
                    "AND a.EmpDopNops = b.EmpDnps " + ;
                    "AND b.Chksubn = " + IIF(loc_llFalse, "1", "0") + " " + ;
                    "AND a.Emps = '" + ALLTRIM(loc_cEmpresa) + "' " + ;
                    "GROUP BY a.Nops, a.CPros, a.CodCors, a.CodTams"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") >= 1 AND ;
                    USED("TmpOpi") AND RECCOUNT("TmpOpi") > 0

                    SELECT TmpOpi
                    SCAN
                        IF loc_lResultado
                            SELECT TmpSaldo
                            SET ORDER TO CPros
                            IF NOT SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodTams,"")))
                                INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                    VALUES (NVL(TmpOpi.CPros,""), NVL(TmpOpi.CodCors,""), ;
                                            NVL(TmpOpi.CodTams,""))
                            ENDIF
                            REPLACE Fabrs WITH NVL(Fabrs,0) + NVL(TmpOpi.Qtds,0), ;
                                    DispFs WITH NVL(DispFs,0) + NVL(TmpOpi.Qtds,0)

                            INSERT INTO TmpFabr (Nops, CPros, CodCors, CodTams, Qtds, Priors) ;
                                VALUES (NVL(TmpOpi.Nops,0), NVL(TmpOpi.CPros,""), ;
                                        NVL(TmpOpi.CodCors,""), NVL(TmpOpi.CodTams,""), ;
                                        NVL(TmpOpi.Qtds,0), 0)

                            loc_cSQL = "SELECT GrupoDs FROM SigPdMvf " + ;
                                "WHERE Nops = " + FormatarNumeroSQL(NVL(TmpOpi.Nops,0), 0) + ;
                                " ORDER BY CidChaves DESC"
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpMfas") >= 1 AND ;
                                USED("TmpMfas") AND RECCOUNT("TmpMfas") > 0
                                SELECT TmpMfas
                                GO TOP
                                REPLACE Fases WITH ALLTRIM(NVL(TmpMfas.GrupoDs,"")) IN TmpFabr
                            ENDIF

                            loc_nEstoque  = 0
                            loc_nProduzir = 0

                            SELECT TmpSaldo
                            IF SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                    ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                    ALLTRIM(NVL(TmpOpi.CodTams,"")))

                                SELECT TmpFinal
                                IF SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodTams,"")), "TmpFinal", "CPros")

                                    IF NVL(TmpSaldo.Fabrs,0) >= NVL(TmpFinal.Produzir,0)
                                        loc_nEstoque  = NVL(TmpFinal.Produzir,0)
                                        loc_nProduzir = 0
                                        SELECT TmpSaldo
                                        REPLACE DispFs WITH NVL(DispFs,0) - NVL(TmpFinal.Produzir,0)
                                    ELSE
                                        loc_nEstoque  = NVL(TmpSaldo.Fabrs,0)
                                        loc_nProduzir = NVL(TmpFinal.Produzir,0) - NVL(TmpSaldo.Fabrs,0)
                                        SELECT TmpSaldo
                                        REPLACE DispFs WITH 0
                                    ENDIF

                                    REPLACE Produzir WITH loc_nProduzir, ;
                                            Fabrs WITH loc_nEstoque IN TmpFinal
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN

                    *-- Redistribuir diferenca de fabricacao
                    SELECT TmpSaldo
                    SCAN
                        IF NVL(TmpSaldo.Fabrs,0) <> NVL(TmpSaldo.DispFs,0)
                            loc_xBaixa = NVL(TmpSaldo.Fabrs,0) - NVL(TmpSaldo.DispFs,0)
                            SELECT TmpFabr
                            SET ORDER TO CPros
                            =SEEK(ALLTRIM(NVL(TmpSaldo.CPros,"")) + ;
                                  ALLTRIM(NVL(TmpSaldo.CodCors,"")) + ;
                                  ALLTRIM(NVL(TmpSaldo.CodTams,"")))
                            SCAN WHILE ALLTRIM(NVL(CPros,"")) = ALLTRIM(NVL(TmpSaldo.CPros,"")) AND ;
                                        ALLTRIM(NVL(CodCors,"")) = ALLTRIM(NVL(TmpSaldo.CodCors,"")) AND ;
                                        ALLTRIM(NVL(CodTams,"")) = ALLTRIM(NVL(TmpSaldo.CodTams,"")) AND ;
                                        loc_xBaixa > 0
                                IF (NVL(TmpFabr.Qtds,0) - NVL(TmpFabr.Disps,0)) >= loc_xBaixa
                                    REPLACE TmpFabr.Disps WITH NVL(TmpFabr.Disps,0) + loc_xBaixa
                                    loc_xBaixa = 0
                                ELSE
                                    loc_xBaixa = loc_xBaixa - (NVL(TmpFabr.Qtds,0) - NVL(TmpFabr.Disps,0))
                                    REPLACE TmpFabr.Disps WITH NVL(TmpFabr.Qtds,0)
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDSCAN

                    *-- Criar TmpFinalG com agrupamentos
                    SET NULL ON
                    CREATE CURSOR TmpFinalG (Flag C(1) NULL, CPros C(14) NULL, ;
                        CodCors C(4) NULL, CodTams C(4) NULL, Linhas C(10) NULL, ;
                        Qtds N(10,3) NULL, Saldo N(10,3) NULL, Estoque N(10,3) NULL, ;
                        Produzir N(10,3) NULL, Fabrs N(10,3) NULL, Produzir2 N(10,3) NULL, ;
                        TotVenda N(10,3) NULL, QtdMins N(10,3) NULL, ;
                        KeySelM L NULL, KeySelMP L NULL, UsuLibs C(10) NULL)
                    INDEX ON CPros + CodCors + CodTams TAG CPros
                    SET NULL OFF

                    *-- Calcular vendas recentes se configurado
                    IF NVL(crSigCdPac.nMeses, 0) > 0
                        loc_llData = GOMONTH(DATE(), -INT(crSigCdPac.nMeses))
                        loc_cSQL = "SELECT a.CPros, a.Qtds, b.Caixas, b.Copers, b.Opers, a.Opers " + ;
                            "FROM SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                            "WHERE a.EmpDopNums = c.EmpDopNums " + ;
                            "AND a.Emps = '" + ALLTRIM(loc_cEmpresa) + "' " + ;
                            "AND c.Datas >= ?loc_llData " + ;
                            "AND a.Dopes = b.Dopes AND b.TipoOps IN (4,5)"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalEest") >= 1
                            SELECT CPros, ;
                                SUM(Qtds * IIF((NVL(Caixas,0)=1 AND NVL(Copers,0)=1) OR ;
                                    (NVL(Caixas,0)<>1 AND NVL(Opers,0)=1) OR ;
                                    (NVL(Caixas,0)<>1 AND NVL(Opers,0)=3), 1, -1)) AS Qtds ;
                                FROM LocalEest ;
                                GROUP BY CPros ;
                                INTO CURSOR Vendas READWRITE
                            SELECT Vendas
                            INDEX ON CPros TAG CPros
                        ENDIF
                    ENDIF

                    *-- Popular TmpFinalG com agrupamentos
                    SELECT CPros, CodCors, CodTams, Linhas, ;
                        SUM(NVL(Qtds,0)) AS Qtds, SUM(NVL(Saldo,0)) AS Saldo, ;
                        SUM(NVL(Estoque,0)) AS Estoque, SUM(NVL(Produzir,0)) AS Produzir, ;
                        SUM(NVL(Fabrs,0)) AS Fabrs ;
                        FROM TmpFinal ;
                        INTO CURSOR Selecao ;
                        GROUP BY CPros, CodCors, CodTams, Linhas

                    SELECT Selecao
                    SCAN
                        IF loc_lResultado
                            SCATTER MEMVAR
                            m.Flag = "+"

                            IF SQLEXEC(gnConnHandle, ;
                                "SELECT QtMinFabs FROM SigCdPro WHERE CPros = '" + ;
                                ALLTRIM(NVL(m.CPros,"")) + "'", "CrSigCdPro") < 1
                                MsgErro("Falha ao buscar QtMinFabs de SigCdPro.", "Erro")
                                loc_lResultado = .F.
                            ENDIF

                            IF loc_lResultado
                                m.QtdMins = 0
                                IF (NVL(crSigCdPac.GerPcps,0) = 2 AND !par_lReserva) OR ;
                                    (NVL(crSigCdPac.GerPcps,0) <> 2 AND par_lReserva)
                                    m.QtdMins = NVL(CrSigCdPro.QtMinFabs, 0)
                                ENDIF

                                m.TotVenda = 0
                                IF USED("Vendas") AND ;
                                    SEEK(ALLTRIM(NVL(m.CPros,"")), "Vendas", "CPros")
                                    m.TotVenda = NVL(Vendas.Qtds, 0)
                                ENDIF

                                m.Produzir2 = IIF(m.QtdMins > 0 AND m.Produzir > 0 AND ;
                                    m.Produzir < m.QtdMins, m.QtdMins - m.Produzir, 0)

                                SELECT TmpFinalG
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDIF
            ELSE
                THIS.this_lTemEstimado = .F.
            ENDIF

            *-- Restaurar ordem de TmpItens para o form
            IF loc_lResultado AND USED("TmpItens") AND USED("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO ALLTRIM(NVL(TmpCabec.Emps,"")) + ;
                           ALLTRIM(NVL(TmpCabec.Dopes,"")) + ;
                           STR(NVL(TmpCabec.Numes,0), 6)
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ProcessarOperacoes")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarOperacoes - Aplica ordenacao no cursor TmpCabec e atualiza
    * this_cOrdConta. O form usa this_cOrdConta para atualizar cores dos headers.
    * Parametros: par_cOrdem - "EMPDOPNUM" ou "ENTREGA" (ou vazio para padrao)
    * Retorno: .T. se ok
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarOperacoes(par_cOrdem)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cOrdem

        loc_lResultado = .T.

        TRY
            loc_cOrdem = UPPER(IIF(VARTYPE(par_cOrdem) = "C" AND !EMPTY(par_cOrdem), ;
                                   par_cOrdem, THIS.this_cOrdConta))

            IF USED("TmpCabec")
                SELECT TmpCabec
                IF !EMPTY(loc_cOrdem) AND INLIST(loc_cOrdem, "ENTREGA", "EMPDOPNUM")
                    SET ORDER TO &loc_cOrdem.
                ELSE
                    SET ORDER TO EmpDopNum
                ENDIF
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro OrdenarOperacoes")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega registro SigTempd do cursor para propriedades
    * Usado para reidratar sessao ativa da tabela de trabalho SigTempd.
    * Parametro: par_cAliasCursor - alias do cursor contendo colunas de SigTempd
    * Retorno: .T. se carregou registro valido, .F. se cursor vazio/inexistente
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_oErro

        loc_lResultado = .F.
        loc_cAlias     = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                             par_cAliasCursor, "cursor_4c_SigTempd")

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF !EOF() AND !BOF()
                    THIS.this_cCidChaves = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CidChaves"), ""))
                    THIS.this_cCidQuerys = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CidQuerys"), ""))
                    THIS.this_cGrupos    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Grupos"), ""))
                    THIS.this_cContas    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Contas"), ""))
                    THIS.this_cEmps      = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Emps"), ""))
                    THIS.this_nCodObs    = NVL(EVALUATE(loc_cAlias + ".CodObs"), 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarDoCursor")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o CidChaves atual (PK da entidade SigTempd)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigTempd para registrar entrada de sessao de OPs.
    * Gera CidChaves/CidQuerys via fUniqueIds() se estiverem vazios.
    * Utilizado no fluxo de geracao para persistir prioridades de estoque
    * que serao consumidas no join com SigMvEst durante ProcessarOperacoes.
    * Retorno: .T. sucesso, .F. erro (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            *-- Gerar identificadores se ainda nao definidos
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCidQuerys))
                THIS.this_cCidQuerys = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            loc_cSQL = "INSERT INTO SigTempd " + ;
                "(CidChaves, CidQuerys, Grupos, Contas, CodObs, Emps, Dpros) VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCidQuerys)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                EscaparSQL("") + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                *-- Registra auditoria de insercao (herdado de BusinessBase)
                THIS.RegistrarAuditoria("I")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigTempd. " + ;
                    "Favor reinicializar o processo."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Inserir SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigTempd para alterar registro de sessao ativa.
    * Localiza pelo CidChaves atual e sobrescreve Grupos/Contas/CodObs/Emps.
    * Retorno: .T. sucesso, .F. erro (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia. " + ;
                    "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                    "vel atualizar SigTempd."
            ELSE
                loc_cSQL = "UPDATE SigTempd SET " + ;
                    "Grupos    = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                    "Contas    = " + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                    "CodObs    = " + FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                    "Emps      = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                    "CidQuerys = " + EscaparSQL(ALLTRIM(THIS.this_cCidQuerys)) + " " + ;
                    "WHERE CidChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                    *-- Registra auditoria de alteracao (herdado de BusinessBase)
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar registro em SigTempd " + ;
                        "(CidChaves=" + ALLTRIM(THIS.this_cCidChaves) + ")."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Atualizar SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigTempd pelo CidChaves atual.
    * Usado para limpar registros de sessao apos processamento concluido.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia."
            ELSE
                loc_cSQL = "DELETE FROM SigTempd WHERE CidChaves = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("E")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir SigTempd."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ExecutarExclusao SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

