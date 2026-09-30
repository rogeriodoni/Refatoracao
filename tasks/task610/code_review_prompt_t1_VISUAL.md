# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1912 linhas total):

*-- Linhas 24 a 43:
24: *     - todos Visible=.F. ate o botao Processar rodar, exceto o Resumo,
25: *     que acompanha o Resultado;
26: *   - a barra de acao do topo direito (shp_4c_Shape2/shp_4c_Shape1 +
27: *     cmd_4c_Visualizar/cmd_4c_Imprimir/cmd_4c_Processar/cmd_4c_Sair),
28: *     criada DEPOIS do cabecalho porque fica sobre a faixa cinza;
29: *   - os cursores da area de Resultado (CriarCursoresResultado, equivalente
30: *     ao PROCEDURE Load do legado) e o bind das 5 grades + o espelho dos
31: *     totalizadores (CarregarDados/LigarGradeDetalhe/AtualizarResumo),
32: *     transcritos do trecho final de Processar.Click.
33: *
34: * Fase 5/8 acrescentou a metade dos campos de filtro do topo: a faixa do
35: * Periodo (lbl_4c_Label3 "Periodo :" + txt_4c_Datai + lbl_4c_Label1 "a" +
36: * txt_4c_Dataf), via ConfigurarFiltros().
37: *
38: * Fase 6/8 completa ConfigurarFiltros() com o campo restante - lbl_4c_Label4
39: * ("Tipo Analise :", SIGPRFEM.Say4) + txt_4c_Demonstrativo
40: * (SIGPRFEM.Get_Demonstrativo) - e implementa o lookup completo (PUBLIC,
41: * por causa do BINDEVENT): TeclaDemonstrativo (KeyPress F4/Enter/Tab) +
42: * ValidarDemonstrativo (match exato em SigPrDmo.Nome) + AbrirBuscaDemonstrativo
43: * (FormBuscaAuxiliar, tabela single-column - substitui o fwBuscaExt legado).

*-- Linhas 158 a 179:
158: 
159:                 *-- Compor layout (flat OPERACIONAL, sem PageFrame CRUD)
160:                 THIS.ConfigurarPageFrame()
161: 
162:                 *-- Ecoar Caption nas labels do cabecalho (apos ConfigurarPageFrame)
163:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
164:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
165: 
166:                 *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
167:                 THIS.TornarControlesVisiveis()
168: 
169:                 loc_lSucesso = .T.
170:             ENDIF
171:         CATCH TO loc_oErro
172:             MsgErro(loc_oErro.Message + CHR(13) + ;
173:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
174:                     "Procedure: " + loc_oErro.Procedure, ;
175:                     "Erro em FormSigPrFem.InicializarForm")
176:         ENDTRY
177: 
178:         RETURN loc_lSucesso
179:     ENDPROC

*-- Linhas 200 a 262:
200:     ENDPROC
201: 
202:     *==========================================================================
203:     PROTECTED PROCEDURE ConfigurarCabecalho()
204:     *==========================================================================
205:     * Cria cnt_4c_Sombra com lbl_4c_LblSombra (sombra preta) e lbl_4c_LblTitulo
206:     * (texto branco) - replica cntSombra/lblSombra/lblTitulo do legado
207:     * (SIGPRFEM.SCX), com o titulo definido em runtime a partir de THIS.Caption
208:     * (mesmo padrao do legado: ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
209:     *==========================================================================
210:         LOCAL loc_oCab, loc_oErro
211:         TRY
212:             THIS.AddObject("cnt_4c_Sombra", "Container")
213:             loc_oCab = THIS.cnt_4c_Sombra
214:             WITH loc_oCab
215:                 .Top         = 0
216:                 .Left        = 0
217:                 .Width       = THIS.Width
218:                 .Height      = 80
219:                 .BackStyle   = 1
220:                 .BackColor   = RGB(100, 100, 100)
221:                 .BorderWidth = 0
222:                 .Visible     = .T.
223:             ENDWITH
224: 
225:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
226:             WITH loc_oCab.lbl_4c_LblSombra
227:                 .AutoSize  = .F.
228:                 .Top       = 18
229:                 .Left      = 10
230:                 .Width     = loc_oCab.Width - 20
231:                 .Height    = 40
232:                 .FontBold  = .T.
233:                 .FontName  = "Tahoma"
234:                 .FontSize  = 18
235:                 .WordWrap  = .T.
236:                 .Alignment = 0
237:                 .BackStyle = 0
238:                 .ForeColor = RGB(0, 0, 0)
239:                 .Caption   = ""
240:                 .Visible   = .T.
241:             ENDWITH
242: 
243:             loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
244:             WITH loc_oCab.lbl_4c_LblTitulo
245:                 .AutoSize    = .F.
246:                 .Top         = 17
247:                 .Left        = 10
248:                 .Width       = loc_oCab.Width - 20
249:                 .Height      = 46
250:                 .FontBold    = .T.
251:                 .FontName    = "Tahoma"
252:                 .FontSize    = 18
253:                 .WordWrap    = .T.
254:                 .Alignment   = 0
255:                 .BackStyle   = 0
256:                 .ForeColor   = RGB(255, 255, 255)
257:                 .Caption     = ""
258:                 .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
259:                 .Visible     = .T.
260:             ENDWITH
261:         CATCH TO loc_oErro
262:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 291 a 309:
291:         LOCAL loc_oErro
292:         TRY
293:             *-- "Per?odo :" (SIGPRFEM.Label3)
294:             THIS.AddObject("lbl_4c_Label3", "Label")
295:             WITH THIS.lbl_4c_Label3
296:                 .AutoSize  = .F.
297:                 .FontName  = "Tahoma"
298:                 .FontSize  = 8
299:                 .BackStyle = 0
300:                 .Alignment = 0
301:                 .ForeColor = RGB(90, 90, 90)
302:                 .Caption   = "Per" + CHR(237) + "odo :"
303:                 .Left      = 398
304:                 .Top       = 90
305:                 .Width     = 45
306:                 .Height    = 15
307:                 .Visible   = .T.
308:             ENDWITH
309: 

*-- Linhas 320 a 346:
320:                 .SpecialEffect = 1
321:                 .ForeColor     = RGB(0, 0, 0)
322:                 .BorderColor   = RGB(100, 100, 100)
323:                 .Left          = 445
324:                 .Top           = 86
325:                 .Width         = 80
326:                 .Height        = 25
327:                 .Visible       = .T.
328:             ENDWITH
329: 
330:             *-- Separador "a" entre as duas datas (SIGPRFEM.Label1)
331:             THIS.AddObject("lbl_4c_Label1", "Label")
332:             WITH THIS.lbl_4c_Label1
333:                 .AutoSize  = .F.
334:                 .FontName  = "Tahoma"
335:                 .FontSize  = 8
336:                 .BackStyle = 0
337:                 .Alignment = 0
338:                 .ForeColor = RGB(90, 90, 90)
339:                 .Caption   = "a"
340:                 .Left      = 530
341:                 .Top       = 90
342:                 .Width     = 8
343:                 .Height    = 15
344:                 .Visible   = .T.
345:             ENDWITH
346: 

*-- Linhas 357 a 386:
357:                 .SpecialEffect = 1
358:                 .ForeColor     = RGB(0, 0, 0)
359:                 .BorderColor   = RGB(100, 100, 100)
360:                 .Left          = 542
361:                 .Top           = 86
362:                 .Width         = 80
363:                 .Height        = 25
364:                 .Visible       = .T.
365:             ENDWITH
366: 
367:             *-- "Tipo An" + CHR(225) + "lise :" (SIGPRFEM.Say4) - classe say pura
368:             *-- (sem Width/Alignment no dump - regra #23): Width explicita
369:             *-- generosa para nao cortar a legenda; o label eh criado ANTES do
370:             *-- TextBox, entao a sobra transparente (BackStyle=0) fica inofensiva.
371:             THIS.AddObject("lbl_4c_Label4", "Label")
372:             WITH THIS.lbl_4c_Label4
373:                 .AutoSize  = .F.
374:                 .FontName  = "Tahoma"
375:                 .FontSize  = 8
376:                 .BackStyle = 0
377:                 .Alignment = 0
378:                 .ForeColor = RGB(90, 90, 90)
379:                 .Caption   = "Tipo An" + CHR(225) + "lise :"
380:                 .Left      = 377
381:                 .Top       = 118
382:                 .Width     = 70
383:                 .Height    = 15
384:                 .Visible   = .T.
385:             ENDWITH
386: 

*-- Linhas 402 a 411:
402:                 .SpecialEffect = 1
403:                 .ForeColor     = RGB(0, 0, 0)
404:                 .BorderColor   = RGB(100, 100, 100)
405:                 .Left          = 445
406:                 .Top           = 113
407:                 .Width         = 154
408:                 .Height        = 25
409:                 .Visible       = .T.
410:             ENDWITH
411: 

*-- Linhas 546 a 555:
546:         TRY
547:             THIS.AddObject("cnt_4c_Resultado", "Container")
548:             WITH THIS.cnt_4c_Resultado
549:                 .Top       = 144
550:                 .Left      = 9
551:                 .Width     = 981
552:                 .Height    = 453
553:                 .BackStyle = 0
554:                 .Visible   = .F.
555:             ENDWITH

*-- Linhas 578 a 586:
578:     PROTECTED PROCEDURE ConfigurarGradeDetalhe(par_cNome, par_nTop, par_nLeft, par_cTitulo, par_nLarguraTitulo)
579:     *==========================================================================
580:     * Monta um dos 5 sub-containers de detalhe (par_cNome) dentro de
581:     * cnt_4c_Resultado: label lbl_4c_Titulo + grid grd_4c_Dados (3 colunas,
582:     * ReadOnly, sem RecordMark/DeleteMark - regra OPERACIONAL). O
583:     * RecordSource/ControlSource do grid NAO eh definido aqui: o cursor de
584:     * dados ainda nao existe (soh eh criado quando o botao Processar roda,
585:     * nas fases seguintes) - regra #41 (ControlSource antes do cursor
586:     * existir derruba o Init). Quem popular o grid mais adiante DEVE

*-- Linhas 592 a 628:
592:         THIS.cnt_4c_Resultado.AddObject(par_cNome, "Container")
593:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cNome)
594:         WITH loc_oDet
595:             .Top       = par_nTop
596:             .Left      = par_nLeft
597:             .Width     = 294
598:             .Height    = 172
599:             .BackStyle = 0
600:             .Visible   = .F.
601:         ENDWITH
602: 
603:         loc_oDet.AddObject("lbl_4c_Titulo", "Label")
604:         WITH loc_oDet.lbl_4c_Titulo
605:             .AutoSize  = .F.
606:             .FontBold  = .T.
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .BackStyle = 0
610:             .Alignment = 0
611:             .ForeColor = RGB(90, 90, 90)
612:             .Caption   = par_cTitulo
613:             .Left      = 9
614:             .Top       = 4
615:             .Width     = par_nLarguraTitulo
616:             .Height    = 15
617:             .Visible   = .T.
618:         ENDWITH
619: 
620:         loc_oDet.AddObject("grd_4c_Dados", "Grid")
621:         WITH loc_oDet.grd_4c_Dados
622:             .Top               = 24
623:             .Left              = 3
624:             .Width             = 288
625:             .Height            = 139
626:             .ColumnCount       = 3
627:             .FontName          = "Tahoma"
628:             .FontSize          = 8

*-- Linhas 647 a 655:
647:             .Header1.FontName  = "Tahoma"
648:             .Header1.FontSize  = 8
649:             .Header1.Alignment = 2
650:             .Header1.Caption   = "Header1"
651:             .Text1.FontName    = "Tahoma"
652:             .Text1.FontSize    = 8
653:             .Text1.BorderStyle = 0
654:             .Text1.Margin      = 0
655:             .Text1.ReadOnly    = .T.

*-- Linhas 667 a 675:
667:             .Header1.FontName  = "Tahoma"
668:             .Header1.FontSize  = 8
669:             .Header1.Alignment = 2
670:             .Header1.Caption   = "Header1"
671:             .Text1.FontName    = "Tahoma"
672:             .Text1.FontSize    = 8
673:             .Text1.BorderStyle = 0
674:             .Text1.Margin      = 0
675:             .Text1.ReadOnly    = .T.

*-- Linhas 687 a 695:
687:             .Header1.FontName  = "Tahoma"
688:             .Header1.FontSize  = 8
689:             .Header1.Alignment = 2
690:             .Header1.Caption   = "Emp"
691:             .Text1.FontName    = "Tahoma"
692:             .Text1.FontSize    = 8
693:             .Text1.BorderStyle = 0
694:             .Text1.Margin      = 0
695:             .Text1.ReadOnly    = .T.

*-- Linhas 714 a 764:
714:         THIS.cnt_4c_Resultado.AddObject("cnt_4c_Resumo", "Container")
715:         loc_oRes = THIS.cnt_4c_Resultado.cnt_4c_Resumo
716:         WITH loc_oRes
717:             .Top       = 184
718:             .Left      = 659
719:             .Width     = 294
720:             .Height    = 264
721:             .BackStyle = 0
722:             .Visible   = .T.
723:         ENDWITH
724: 
725:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label13", "Totalizadores", 7, 4, 79, .T.)
726: 
727:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label5", "Saldo Inicial :", 136, 27, 65, .F.)
728:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Saldoi", 203, 25, .F.)
729: 
730:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label4", ;
731:             "Saldo funcion" + CHR(225) + "rios ant./ per" + CHR(237) + "odo :", 39, 50, 162, .F.)
732:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_SaldoAnt", 203, 48, .F.)
733: 
734:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label6", ;
735:             "Entradas no per" + CHR(237) + "odo :", 95, 73, 106, .F.)
736:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Entradas", 203, 71, .F.)
737: 
738:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label7", "Sub-Total entradas :", 100, 96, 101, .F.)
739:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_TEntradas", 203, 94, .F.)
740: 
741:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label8", ;
742:             "Sa" + CHR(237) + "das no per" + CHR(237) + "odo :", 107, 119, 94, .F.)
743:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Saidas", 203, 117, .F.)
744: 
745:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label1", "Saldo :", 162, 142, 39, .T.)
746:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Saldo", 203, 140, .T.)
747: 
748:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label2", ;
749:             "Saldo final com funcion" + CHR(225) + "rios :", 60, 165, 141, .F.)
750:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_SaldoFunc", 203, 163, .F.)
751: 
752:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label9", ;
753:             "Pesagem f" + CHR(237) + "sica :", 122, 188, 79, .F.)
754:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Pesagem", 203, 186, .F.)
755: 
756:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label3", "Total :", 164, 211, 37, .T.)
757:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_SaldoT", 203, 209, .T.)
758: 
759:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label12", ;
760:             "Falha funcion" + CHR(225) + "rios no per" + CHR(237) + "odo :", 51, 234, 150, .F.)
761:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_FalhaFunc", 203, 232, .F.)
762:     ENDPROC
763: 
764:     *==========================================================================

*-- Linhas 777 a 787:
777:             .BackStyle = 0
778:             .Alignment = 0
779:             .ForeColor = RGB(90, 90, 90)
780:             .Caption   = par_cCaption
781:             .Left      = par_nLeft
782:             .Top       = par_nTop
783:             .Width     = par_nWidth
784:             .Height    = 15
785:             .Visible   = .T.
786:         ENDWITH
787:     ENDPROC

*-- Linhas 816 a 913:
816:             .SpecialEffect     = 1
817:             .DisabledBackColor = RGB(255, 255, 255)
818:             .BorderColor       = RGB(100, 100, 100)
819:             .Left              = par_nLeft
820:             .Top               = par_nTop
821:             .Width             = 86
822:             .Height            = 21
823:             .Visible           = .T.
824:         ENDWITH
825:     ENDPROC
826: 
827:     *==========================================================================
828:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
829:     *==========================================================================
830:     * Barra de acao do topo direito - transcrita do dump do legado
831:     * (SIGPRFEM.Shape2 / Shape1 / Visualizar / Imprimir / Processar / Sair).
832:     *
833:     * A ORDEM DE CRIACAO IMPORTA por dois motivos:
834:     *   1) os botoes ficam em Top = 3, DENTRO da area da faixa cinza do
835:     *      cabecalho (cnt_4c_Sombra: Top 0, Height 80) - por isso este metodo
836:     *      roda DEPOIS de ConfigurarCabecalho, senao a faixa cobre os botoes;
837:     *   2) os dois Shapes sao as molduras que ficam ATRAS dos botoes
838:     *      (Shape2 emoldura Video/Impressora, Shape1 emoldura Processar/
839:     *      Encerrar) - criados antes, os CommandButton desenham por cima.
840:     * AddObject empilha no z-order: o ultimo objeto criado fica na frente.
841:     *
842:     * O ZOrderSet do dump NAO eh transcrito - eh bookkeeping do Form Designer
843:     * e nao existe como propriedade em runtime (regra #33); o equivalente eh
844:     * exatamente esta ordem de criacao.
845:     *
846:     * Os CommandButton sao STANDALONE (nao estao em CommandGroup) e tem
847:     * .Picture, entao levam .Themes = .T. + .DisabledPicture com a MESMA
848:     * imagem: com Themes = .F. o icone deixa de renderizar quando o botao
849:     * fica Enabled = .F. (o dump legado traz Themes = .F. - aqui eh desvio
850:     * deliberado, para o icone nao desaparecer).
851:     *==========================================================================
852:         LOCAL loc_oErro
853:         TRY
854:             *-- Moldura de Video/Impressora (SIGPRFEM.Shape2)
855:             THIS.AddObject("shp_4c_Shape2", "Shape")
856:             WITH THIS.shp_4c_Shape2
857:                 .Top           = 7
858:                 .Left          = 667
859:                 .Width         = 146
860:                 .Height        = 75
861:                 .BackStyle     = 0
862:                 .BorderStyle   = 0
863:                 .SpecialEffect = 1
864:                 .BorderColor   = RGB(136, 189, 188)
865:                 .Visible       = .T.
866:             ENDWITH
867: 
868:             *-- Moldura de Processar/Encerrar (SIGPRFEM.Shape1)
869:             THIS.AddObject("shp_4c_Shape1", "Shape")
870:             WITH THIS.shp_4c_Shape1
871:                 .Top         = 8
872:                 .Left        = 816
873:                 .Width       = 173
874:                 .Height      = 110
875:                 .BackStyle   = 0
876:                 .BorderStyle = 0
877:                 .BorderColor = RGB(136, 189, 188)
878:                 .Visible     = .T.
879:             ENDWITH
880: 
881:             *-- Visualizar em tela (SIGPRFEM.Visualizar)
882:             THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
883:             THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Visualizar, 700, ;
884:                 "   \<V" + CHR(237) + "deo            ", ;
885:                 "relatorio_video_26.jpg", "Visualizar", .F.)
886: 
887:             *-- Imprimir (SIGPRFEM.Imprimir)
888:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
889:             THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Imprimir, 775, ;
890:                 " \<Impressora    ", ;
891:                 "relatorio_impressora_26.jpg", "Imprimir", .F.)
892: 
893:             *-- Processar a analise (SIGPRFEM.Processar)
894:             THIS.AddObject("cmd_4c_Processar", "CommandButton")
895:             THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Processar, 850, ;
896:                 "Processar", "geral_processar_60.jpg", "", .F.)
897: 
898:             *-- Encerrar (SIGPRFEM.Sair - Cancel = .T. no dump: responde ao ESC)
899:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
900:             THIS.ConfigurarBotaoAcao(THIS.cmd_4c_Sair, 925, ;
901:                 "Encerrar", "cadastro_sair_60.jpg", "", .T.)
902: 
903:             *-- Eventos dos 4 botoes (Fase 7). Os handlers sao PUBLIC de
904:             *-- proposito: BINDEVENT falha EM SILENCIO com metodo PROTECTED.
905:             BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
906:             BINDEVENT(THIS.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
907:             BINDEVENT(THIS.cmd_4c_Processar,  "Click", THIS, "BtnProcessarClick")
908:             BINDEVENT(THIS.cmd_4c_Sair,       "Click", THIS, "BtnSairClick")
909:         CATCH TO loc_oErro
910:             MsgErro(loc_oErro.Message + CHR(13) + ;
911:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
912:                     "Procedure: " + loc_oErro.Procedure, ;
913:                     "Erro em FormSigPrFem.ConfigurarBotoesAcao")

*-- Linhas 928 a 946:
928:     * parametro) para quem le o form e para as auditorias do pipeline.
929:     *==========================================================================
930:         WITH par_oBotao
931:             .Top               = 3
932:             .Left              = par_nLeft
933:             .Width             = 75
934:             .Height            = 75
935:             .FontBold          = .T.
936:             .FontItalic        = .T.
937:             .FontName          = "Comic Sans MS"
938:             .FontSize          = 8
939:             .WordWrap          = .T.
940:             .AutoSize          = .F.
941:             .Caption           = par_cCaption
942:             .Picture           = gc_4c_CaminhoIcones + par_cIcone
943:             .DisabledPicture   = gc_4c_CaminhoIcones + par_cIcone
944:             .PicturePosition   = 13
945:             .ToolTipText       = par_cToolTip
946:             .Cancel            = par_lCancel

*-- Linhas 1155 a 1167:
1155: 
1156:         WITH loc_oGrid
1157:             .Column1.ControlSource   = par_cCursor + "." + par_cCampo1
1158:             .Column1.Header1.Caption = par_cCaption1
1159:             .Column2.ControlSource   = par_cCursor + "." + par_cCampo2
1160:             .Column2.Header1.Caption = par_cCaption2
1161:             .Column3.ControlSource   = par_cCursor + ".Emps"
1162:             .Column3.Header1.Caption = "Emp"
1163: 
1164:             *-- Larguras do dump, reaplicadas DEPOIS do RecordSource
1165:             .Column1.Width = 110
1166:             .Column2.Width = 80
1167:             .Column3.Width = 40

*-- Linhas 1277 a 1285:
1277:     * o botao Processar fica Enabled = .F. e nem chega a disparar o Click, em
1278:     * vez de depender so da flag para recusar a reentrada.
1279:     *
1280:     * Desligar tambem cmd_4c_Sair eh proposital: ele tem Cancel = .T. (responde
1281:     * ao ESC), e fechar a tela no meio do processamento destruiria os cursores
1282:     * que o BO ainda esta percorrendo.
1283:     *
1284:     * Os quatro botoes sobrevivem ao Enabled = .F. sem perder o icone porque
1285:     * ConfigurarBotaoAcao ja os cria com .Themes = .T. + .DisabledPicture

*-- Linhas 1303 a 1314:
1303:         THIS.txt_4c_Dataf.Enabled         = loc_lLiga
1304:         THIS.txt_4c_Demonstrativo.Enabled = loc_lLiga
1305: 
1306:         THIS.cmd_4c_Processar.Enabled  = loc_lLiga
1307:         THIS.cmd_4c_Visualizar.Enabled = loc_lLiga
1308:         THIS.cmd_4c_Imprimir.Enabled   = loc_lLiga
1309:         THIS.cmd_4c_Sair.Enabled       = loc_lLiga
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1314:     *==========================================================================

