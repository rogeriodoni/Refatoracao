# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'GeraSenha' (parent: SIGPRSDD): Left original=649 vs migrado 'cmd_4c_GeraSenha' Left=80 (diff=569px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Saida' (parent: SIGPRSDD): Left original=724 vs migrado 'cnt_4c_Saida' Left=917 (diff=193px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSdd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1686 linhas total):

*-- Linhas 74 a 85:
74:                 THIS.ConfigurarPaginaLista()
75:                 THIS.ConfigurarPaginaDados()
76: 
77:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
78:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
79:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81: 
82:                 THIS.TornarControlesVisiveis(THIS)
83: 
84:                 THIS.CarregarLista()
85:                 THIS.AjustarBotoesPorModo()

*-- Linhas 111 a 120:
111:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
112:         WITH THIS.pgf_4c_Paginas
113:             .PageCount   = 2
114:             .Top         = -29
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = THIS.Height + 29
118:             .Tabs        = .F.
119:             .BorderWidth = 0
120:             .Visible     = .T.

*-- Linhas 129 a 175:
129:         *-- Container Cabecalho (barra escura com titulo) - vazio nesta fase
130:         loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
131:         WITH loc_oPag2.cnt_4c_Cabecalho
132:             .Top         = 29
133:             .Left        = 0
134:             .Width       = THIS.Width
135:             .Height      = 80
136:             .BackStyle   = 1
137:             .BackColor   = RGB(100, 100, 100)
138:             .BorderWidth = 0
139:             .Visible     = .T.
140:         ENDWITH
141: 
142:         *-- Container Botoes CRUD (lado direito do cabecalho) - vazio nesta fase
143:         loc_oPag2.AddObject("cnt_4c_Botoes", "Container")
144:         WITH loc_oPag2.cnt_4c_Botoes
145:             .Top         = 29
146:             .Left        = 542
147:             .Width       = 390
148:             .Height      = 85
149:             .BackStyle   = 0
150:             .BorderWidth = 0
151:             .Visible     = .T.
152:         ENDWITH
153: 
154:         *-- Container Saida/Encerrar (canto direito) - vazio nesta fase
155:         loc_oPag2.AddObject("cnt_4c_Saida", "Container")
156:         WITH loc_oPag2.cnt_4c_Saida
157:             .Top         = 29
158:             .Left        = 917
159:             .Width       = 90
160:             .Height      = 85
161:             .BackStyle   = 0
162:             .BorderWidth = 0
163:             .Visible     = .T.
164:         ENDWITH
165: 
166:         *-- Container Botoes de Acao especificos (Boleto/Gerar Senha) - vazio
167:         loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
168:         WITH loc_oPag2.cnt_4c_BotoesAcao
169:             .Top         = 29
170:             .Left        = 569
171:             .Width       = 240
172:             .Height      = 85
173:             .BackStyle   = 0
174:             .BorderWidth = 0
175:             .Visible     = .T.

*-- Linhas 217 a 289:
217:         *----------------------------------------------------------------------
218:         loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
219:         WITH loc_oPag1.cnt_4c_Cabecalho
220:             .Top         = 29
221:             .Left        = 0
222:             .Width       = THIS.Width
223:             .Height      = 80
224:             .BackStyle   = 1
225:             .BackColor   = RGB(100, 100, 100)
226:             .BorderWidth = 0
227:             .Visible     = .T.
228:         ENDWITH
229:         loc_oCab = loc_oPag1.cnt_4c_Cabecalho
230: 
231:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
232:         WITH loc_oCab.lbl_4c_Sombra
233:             .AutoSize    = .F.
234:             .Width       = THIS.Width
235:             .FontBold    = .T.
236:             .FontName    = "Tahoma"
237:             .FontSize    = 16
238:             .BackStyle   = 0
239:             .Caption     = "Senha do Dia"
240:             .Height      = 40
241:             .Left        = 10
242:             .Top         = 15
243:             .ForeColor   = RGB(0, 0, 0)
244:             .Visible     = .T.
245:         ENDWITH
246: 
247:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
248:         WITH loc_oCab.lbl_4c_Titulo
249:             .AutoSize    = .F.
250:             .Width       = THIS.Width
251:             .FontBold    = .T.
252:             .FontName    = "Tahoma"
253:             .FontSize    = 16
254:             .BackStyle   = 0
255:             .Caption     = "Senha do Dia"
256:             .Height      = 46
257:             .Left        = 10
258:             .Top         = 18
259:             .ForeColor   = RGB(255, 255, 255)
260:             .Visible     = .T.
261:         ENDWITH
262: 
263:         *----------------------------------------------------------------------
264:         * Container de botoes CRUD (lado direito)
265:         *----------------------------------------------------------------------
266:         loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
267:         WITH loc_oPag1.cnt_4c_Botoes
268:             .Top         = 29
269:             .Left        = 542
270:             .Width       = 390
271:             .Height      = 85
272:             .BackStyle   = 0
273:             .BorderWidth = 0
274:             .Visible     = .T.
275:         ENDWITH
276:         loc_oBotoes = loc_oPag1.cnt_4c_Botoes
277: 
278:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
279:         WITH loc_oBotoes.cmd_4c_Incluir
280:             .Left            = 5
281:             .Top             = 5
282:             .Width           = 75
283:             .Height          = 75
284:             .Caption         = "Gerar" + CHR(13) + "Senha"
285:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
286:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
287:             .FontName        = "Tahoma"
288:             .FontBold        = .T.
289:             .FontItalic      = .T.

*-- Linhas 297 a 313:
297:             .WordWrap        = .T.
298:             .Visible         = .T.
299:         ENDWITH
300:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
301: 
302:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
303:         WITH loc_oBotoes.cmd_4c_Visualizar
304:             .Left            = 80
305:             .Top             = 5
306:             .Width           = 75
307:             .Height          = 75
308:             .Caption         = "Visualizar"
309:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
310:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
311:             .FontName        = "Tahoma"
312:             .FontBold        = .T.
313:             .FontItalic      = .T.

*-- Linhas 321 a 337:
321:             .WordWrap        = .T.
322:             .Visible         = .T.
323:         ENDWITH
324:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
325: 
326:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
327:         WITH loc_oBotoes.cmd_4c_Alterar
328:             .Left            = 155
329:             .Top             = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .Caption         = "Alterar"
333:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
334:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
335:             .FontName        = "Tahoma"
336:             .FontBold        = .T.
337:             .FontItalic      = .T.

*-- Linhas 345 a 361:
345:             .WordWrap        = .T.
346:             .Visible         = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
349: 
350:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
351:         WITH loc_oBotoes.cmd_4c_Excluir
352:             .Left            = 230
353:             .Top             = 5
354:             .Width           = 75
355:             .Height          = 75
356:             .Caption         = "Excluir"
357:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
358:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
359:             .FontName        = "Tahoma"
360:             .FontBold        = .T.
361:             .FontItalic      = .T.

*-- Linhas 369 a 385:
369:             .WordWrap        = .T.
370:             .Visible         = .T.
371:         ENDWITH
372:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
373: 
374:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
375:         WITH loc_oBotoes.cmd_4c_Buscar
376:             .Left            = 305
377:             .Top             = 5
378:             .Width           = 75
379:             .Height          = 75
380:             .Caption         = "Buscar"
381:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
382:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
383:             .FontName        = "Tahoma"
384:             .FontBold        = .T.
385:             .FontItalic      = .T.

*-- Linhas 393 a 426:
393:             .WordWrap        = .T.
394:             .Visible         = .T.
395:         ENDWITH
396:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
397: 
398:         *----------------------------------------------------------------------
399:         * Container Saida/Encerrar - padrao canonico Left=917 W=90
400:         *----------------------------------------------------------------------
401:         loc_oPag1.AddObject("cnt_4c_Saida", "Container")
402:         WITH loc_oPag1.cnt_4c_Saida
403:             .Top         = 29
404:             .Left        = 917
405:             .Width       = 90
406:             .Height      = 85
407:             .BackStyle   = 0
408:             .BorderWidth = 0
409:             .Visible     = .T.
410:         ENDWITH
411:         loc_oSaida = loc_oPag1.cnt_4c_Saida
412: 
413:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
414:         WITH loc_oSaida.cmd_4c_Encerrar
415:             .Left            = 5
416:             .Top             = 5
417:             .Width           = 75
418:             .Height          = 75
419:             .Caption         = "Encerrar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
421:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
422:             .Cancel          = .T.
423:             .FontName        = "Tahoma"
424:             .FontBold        = .T.
425:             .FontItalic      = .T.
426:             .FontSize        = 8

*-- Linhas 433 a 449:
433:             .WordWrap        = .T.
434:             .Visible         = .T.
435:         ENDWITH
436:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
437: 
438:         *----------------------------------------------------------------------
439:         * Grid de lista de senhas geradas (SigPrSnd)
440:         *----------------------------------------------------------------------
441:         loc_oPag1.AddObject("grd_4c_Lista", "Grid")
442:         WITH loc_oPag1.grd_4c_Lista
443:             .Top                = 117
444:             .Left               = 5
445:             .Width              = 990
446:             .Height             = 450
447:             .FontName           = "Verdana"
448:             .FontSize           = 8
449:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 515 a 530:
515:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Lista.senhads"
516:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Lista.tipos"
517: 
518:                 loc_oGrid.Column1.Header1.Caption = "Data/Hora"
519:                 loc_oGrid.Column2.Header1.Caption = "Solicitante"
520:                 loc_oGrid.Column3.Header1.Caption = "Empresa"
521:                 loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
522:                 loc_oGrid.Column5.Header1.Caption = "Documento"
523:                 loc_oGrid.Column6.Header1.Caption = "Valor"
524:                 loc_oGrid.Column7.Header1.Caption = "Senha"
525:                 loc_oGrid.Column8.Header1.Caption = "Tipo"
526: 
527:                 loc_oGrid.Column1.Width = 120
528:                 loc_oGrid.Column2.Width = 90
529:                 loc_oGrid.Column3.Width = 50
530:                 loc_oGrid.Column4.Width = 170

*-- Linhas 663 a 714:
663:         *----------------------------------------------------------------------
664:         loc_oCab = loc_oPag2.cnt_4c_Cabecalho
665: 
666:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
667:         WITH loc_oCab.lbl_4c_Sombra
668:             .AutoSize  = .F.
669:             .Width     = THIS.Width
670:             .FontBold  = .T.
671:             .FontName  = "Tahoma"
672:             .FontSize  = 18
673:             .BackStyle = 0
674:             .Caption   = "Senha do Dia"
675:             .Height    = 40
676:             .Left      = 10
677:             .Top       = 18
678:             .ForeColor = RGB(0, 0, 0)
679:             .Visible   = .T.
680:         ENDWITH
681: 
682:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
683:         WITH loc_oCab.lbl_4c_Titulo
684:             .AutoSize  = .F.
685:             .Width     = THIS.Width
686:             .FontBold  = .T.
687:             .FontName  = "Tahoma"
688:             .FontSize  = 18
689:             .BackStyle = 0
690:             .Caption   = "Senha do Dia"
691:             .Height    = 46
692:             .Left      = 10
693:             .Top       = 17
694:             .ForeColor = RGB(255, 255, 255)
695:             .Visible   = .T.
696:         ENDWITH
697: 
698:         *----------------------------------------------------------------------
699:         * Botoes de acao: Boleto e Gerar Senha (container criado em ConfigurarPageFrame)
700:         *----------------------------------------------------------------------
701:         loc_oBotoesAcao = loc_oPag2.cnt_4c_BotoesAcao
702: 
703:         loc_oBotoesAcao.AddObject("cmd_4c_Boleto", "CommandButton")
704:         WITH loc_oBotoesAcao.cmd_4c_Boleto
705:             .Left            = 5
706:             .Top             = 5
707:             .Width           = 75
708:             .Height          = 75
709:             .Caption         = "Boleto"
710:             .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
711:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
712:             .FontName        = "Tahoma"
713:             .FontBold        = .T.
714:             .FontItalic      = .T.

*-- Linhas 722 a 769:
722:             .WordWrap        = .T.
723:             .Visible         = .T.
724:         ENDWITH
725:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")
726: 
727:         loc_oBotoesAcao.AddObject("cmd_4c_GeraSenha", "CommandButton")
728:         WITH loc_oBotoesAcao.cmd_4c_GeraSenha
729:             .Left            = 80
730:             .Top             = 5
731:             .Width           = 75
732:             .Height          = 75
733:             .Caption         = "Gerar" + CHR(13) + "Senha"
734:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
735:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
736:             .FontName        = "Tahoma"
737:             .FontBold        = .T.
738:             .FontItalic      = .T.
739:             .FontSize        = 8
740:             .ForeColor       = RGB(90, 90, 90)
741:             .BackColor       = RGB(255, 255, 255)
742:             .Themes          = .F.
743:             .SpecialEffect   = 0
744:             .PicturePosition = 13
745:             .MousePointer    = 15
746:             .WordWrap        = .T.
747:             .Visible         = .T.
748:         ENDWITH
749:         BINDEVENT(loc_oBotoesAcao.cmd_4c_GeraSenha, "Click", THIS, "BtnGeraSenhaClick")
750: 
751:         *----------------------------------------------------------------------
752:         * Botao Encerrar (container cnt_4c_Saida criado em ConfigurarPageFrame)
753:         *----------------------------------------------------------------------
754:         loc_oSaida = loc_oPag2.cnt_4c_Saida
755: 
756:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
757:         WITH loc_oSaida.cmd_4c_Encerrar
758:             .Left            = 5
759:             .Top             = 5
760:             .Width           = 75
761:             .Height          = 75
762:             .Caption         = "Encerrar"
763:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
764:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
765:             .Cancel          = .T.
766:             .FontName        = "Tahoma"
767:             .FontBold        = .T.
768:             .FontItalic      = .T.
769:             .FontSize        = 8

*-- Linhas 776 a 812:
776:             .WordWrap        = .T.
777:             .Visible         = .T.
778:         ENDWITH
779:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
780: 
781:         *----------------------------------------------------------------------
782:         * Solicitante (TabIndex=1) - Top original 83 + 29 = 112
783:         * Label original Top=86 + 29 = 115
784:         *----------------------------------------------------------------------
785:         loc_oPag2.AddObject("lbl_4c_Solicitante", "Label")
786:         WITH loc_oPag2.lbl_4c_Solicitante
787:             .AutoSize  = .T.
788:             .FontName  = "Tahoma"
789:             .FontSize  = 8
790:             .BackStyle = 0
791:             .Caption   = "Solicitante : "
792:             .Height    = 15
793:             .Left      = 81
794:             .Top       = 115
795:             .ForeColor = RGB(90, 90, 90)
796:             .Visible   = .T.
797:         ENDWITH
798: 
799:         loc_oPag2.AddObject("txt_4c_Solic", "TextBox")
800:         WITH loc_oPag2.txt_4c_Solic
801:             .FontName      = "Tahoma"
802:             .FontSize      = 8
803:             .Value         = ""
804:             .MaxLength     = 10
805:             .Height        = 23
806:             .Left          = 144
807:             .Top           = 112
808:             .Width         = 80
809:             .Format        = "K!"
810:             .SpecialEffect = 1
811:             .ForeColor     = RGB(90, 90, 90)
812:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 818 a 848:
818:         * Empresa - Codigo (TabIndex=2) e Nome (TabIndex=3)
819:         * Top original 108 + 29 = 137; label original Top=112 + 29 = 141
820:         *----------------------------------------------------------------------
821:         loc_oPag2.AddObject("lbl_4c_Empresa", "Label")
822:         WITH loc_oPag2.lbl_4c_Empresa
823:             .AutoSize  = .T.
824:             .FontName  = "Tahoma"
825:             .FontSize  = 8
826:             .BackStyle = 0
827:             .Caption   = "Empresa : "
828:             .Height    = 15
829:             .Left      = 89
830:             .Top       = 141
831:             .ForeColor = RGB(90, 90, 90)
832:             .Visible   = .T.
833:         ENDWITH
834: 
835:         loc_oPag2.AddObject("txt_4c_Cd_Empresa", "TextBox")
836:         WITH loc_oPag2.txt_4c_Cd_Empresa
837:             .FontName      = "Tahoma"
838:             .FontSize      = 8
839:             .Value         = ""
840:             .MaxLength     = 3
841:             .Height        = 25
842:             .Left          = 144
843:             .Top           = 137
844:             .Width         = 32
845:             .Format        = "K"
846:             .SpecialEffect = 1
847:             .ForeColor     = RGB(90, 90, 90)
848:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 857 a 866:
857:             .Value         = ""
858:             .MaxLength     = 40
859:             .Height        = 25
860:             .Left          = 178
861:             .Top           = 137
862:             .Width         = 290
863:             .Format        = "K"
864:             .SpecialEffect = 1
865:             .ForeColor     = RGB(90, 90, 90)
866:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 872 a 902:
872:         * Operacao (TabIndex=4) - Top original 135 + 29 = 164
873:         * Label original Top=140 + 29 = 169
874:         *----------------------------------------------------------------------
875:         loc_oPag2.AddObject("lbl_4c_Operacao", "Label")
876:         WITH loc_oPag2.lbl_4c_Operacao
877:             .AutoSize  = .T.
878:             .FontName  = "Tahoma"
879:             .FontSize  = 8
880:             .BackStyle = 0
881:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
882:             .Height    = 15
883:             .Left      = 83
884:             .Top       = 169
885:             .ForeColor = RGB(90, 90, 90)
886:             .Visible   = .T.
887:         ENDWITH
888: 
889:         loc_oPag2.AddObject("txt_4c_Operacao", "TextBox")
890:         WITH loc_oPag2.txt_4c_Operacao
891:             .FontName      = "Tahoma"
892:             .FontSize      = 8
893:             .Value         = ""
894:             .MaxLength     = 20
895:             .Height        = 25
896:             .Left          = 144
897:             .Top           = 164
898:             .Width         = 150
899:             .Format        = "K"
900:             .SpecialEffect = 1
901:             .ForeColor     = RGB(90, 90, 90)
902:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 908 a 938:
908:         * Documento (TabIndex=5) - Top original 162 + 29 = 191
909:         * Label original Top=165 + 29 = 194
910:         *----------------------------------------------------------------------
911:         loc_oPag2.AddObject("lbl_4c_Documento", "Label")
912:         WITH loc_oPag2.lbl_4c_Documento
913:             .AutoSize  = .T.
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .BackStyle = 0
917:             .Caption   = "Documento : "
918:             .Height    = 15
919:             .Left      = 76
920:             .Top       = 194
921:             .ForeColor = RGB(90, 90, 90)
922:             .Visible   = .T.
923:         ENDWITH
924: 
925:         loc_oPag2.AddObject("txt_4c_Doc", "TextBox")
926:         WITH loc_oPag2.txt_4c_Doc
927:             .FontName      = "Tahoma"
928:             .FontSize      = 8
929:             .Value         = 0
930:             .InputMask     = "9999999999"
931:             .Height        = 23
932:             .Left          = 144
933:             .Top           = 191
934:             .Width         = 80
935:             .Format        = "K"
936:             .SpecialEffect = 1
937:             .ForeColor     = RGB(90, 90, 90)
938:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 944 a 974:
944:         * Cond. Pagto / Forma Pagamento (TabIndex=6) - Top original 187 + 29 = 216
945:         * Label original Top=192 + 29 = 221
946:         *----------------------------------------------------------------------
947:         loc_oPag2.AddObject("lbl_4c_CondPagto", "Label")
948:         WITH loc_oPag2.lbl_4c_CondPagto
949:             .AutoSize  = .T.
950:             .FontName  = "Tahoma"
951:             .FontSize  = 8
952:             .BackStyle = 0
953:             .Caption   = "Cond. Pagto : "
954:             .Height    = 15
955:             .Left      = 70
956:             .Top       = 221
957:             .ForeColor = RGB(90, 90, 90)
958:             .Visible   = .T.
959:         ENDWITH
960: 
961:         loc_oPag2.AddObject("txt_4c_Fpg", "TextBox")
962:         WITH loc_oPag2.txt_4c_Fpg
963:             .FontName      = "Tahoma"
964:             .FontSize      = 8
965:             .Value         = ""
966:             .MaxLength     = 12
967:             .Height        = 23
968:             .Left          = 144
969:             .Top           = 216
970:             .Width         = 94
971:             .Format        = "K"
972:             .SpecialEffect = 1
973:             .ForeColor     = RGB(90, 90, 90)
974:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 982 a 1012:
982:         * ReadOnly: When original retorna .F. (campo sempre bloqueado)
983:         * Label original Top=215 + 29 = 244
984:         *----------------------------------------------------------------------
985:         loc_oPag2.AddObject("lbl_4c_Data", "Label")
986:         WITH loc_oPag2.lbl_4c_Data
987:             .AutoSize  = .T.
988:             .FontName  = "Tahoma"
989:             .FontSize  = 8
990:             .BackStyle = 0
991:             .Caption   = "Data : "
992:             .Height    = 15
993:             .Left      = 107
994:             .Top       = 244
995:             .ForeColor = RGB(90, 90, 90)
996:             .Visible   = .T.
997:         ENDWITH
998: 
999:         loc_oPag2.AddObject("txt_4c_Data", "TextBox")
1000:         WITH loc_oPag2.txt_4c_Data
1001:             .FontName      = "Tahoma"
1002:             .FontSize      = 8
1003:             .Value         = DATETIME()
1004:             .ReadOnly      = .T.
1005:             .Height        = 23
1006:             .Left          = 144
1007:             .Top           = 241
1008:             .Width         = 75
1009:             .Format        = "K"
1010:             .SpecialEffect = 1
1011:             .ForeColor     = RGB(90, 90, 90)
1012:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1019 a 1049:
1019:         * Habilitado apenas em modo !Producao (When = Not Thisform.Producao)
1020:         * Label original Top=240 + 29 = 269
1021:         *----------------------------------------------------------------------
1022:         loc_oPag2.AddObject("lbl_4c_Valor", "Label")
1023:         WITH loc_oPag2.lbl_4c_Valor
1024:             .AutoSize  = .T.
1025:             .FontName  = "Tahoma"
1026:             .FontSize  = 8
1027:             .BackStyle = 0
1028:             .Caption   = "Valor : "
1029:             .Height    = 15
1030:             .Left      = 106
1031:             .Top       = 269
1032:             .ForeColor = RGB(90, 90, 90)
1033:             .Visible   = .T.
1034:         ENDWITH
1035: 
1036:         loc_oPag2.AddObject("txt_4c_Valor", "TextBox")
1037:         WITH loc_oPag2.txt_4c_Valor
1038:             .FontName      = "Tahoma"
1039:             .FontSize      = 8
1040:             .Value         = 0
1041:             .InputMask     = "999,999,999.99"
1042:             .Height        = 23
1043:             .Left          = 144
1044:             .Top           = 266
1045:             .Width         = 100
1046:             .Format        = "K"
1047:             .SpecialEffect = 1
1048:             .ForeColor     = RGB(90, 90, 90)
1049:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1056 a 1086:
1056:         * Motivo (TabIndex=9) - Top original 262 + 29 = 291
1057:         * Label original Top=265 + 29 = 294
1058:         *----------------------------------------------------------------------
1059:         loc_oPag2.AddObject("lbl_4c_Motivo", "Label")
1060:         WITH loc_oPag2.lbl_4c_Motivo
1061:             .AutoSize  = .T.
1062:             .FontName  = "Tahoma"
1063:             .FontSize  = 8
1064:             .BackStyle = 0
1065:             .Caption   = "Motivo : "
1066:             .Height    = 15
1067:             .Left      = 98
1068:             .Top       = 294
1069:             .ForeColor = RGB(90, 90, 90)
1070:             .Visible   = .T.
1071:         ENDWITH
1072: 
1073:         loc_oPag2.AddObject("txt_4c_Motivo", "TextBox")
1074:         WITH loc_oPag2.txt_4c_Motivo
1075:             .FontName      = "Tahoma"
1076:             .FontSize      = 8
1077:             .Value         = ""
1078:             .MaxLength     = 40
1079:             .Height        = 23
1080:             .Left          = 144
1081:             .Top           = 291
1082:             .Width         = 360
1083:             .Format        = "K!"
1084:             .SpecialEffect = 1
1085:             .ForeColor     = RGB(90, 90, 90)
1086:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1663 a 1684:
1663: 
1664:         IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
1665:             WITH loc_oPag1.cnt_4c_Botoes
1666:                 IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1667:                     .cmd_4c_Incluir.Enabled    = .T.
1668:                 ENDIF
1669:                 IF PEMSTATUS(.cmd_4c_Visualizar, "Enabled", 5)
1670:                     .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1671:                 ENDIF
1672:                 IF PEMSTATUS(.cmd_4c_Alterar, "Enabled", 5)
1673:                     .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1674:                 ENDIF
1675:                 IF PEMSTATUS(.cmd_4c_Excluir, "Enabled", 5)
1676:                     .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1677:                 ENDIF
1678:                 IF PEMSTATUS(.cmd_4c_Buscar, "Enabled", 5)
1679:                     .cmd_4c_Buscar.Enabled     = .T.
1680:                 ENDIF
1681:                 .Visible     = .T.
1682:             ENDWITH
1683:         ENDIF
1684:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrSddBO.prg):
*==============================================================================
* SigPrSddBO.prg - Business Object para Senha do Dia
* Herda de BusinessBase
* Tabela principal: SigPrSnd
* Fase 1/8: Propriedades e Init
*==============================================================================

DEFINE CLASS SigPrSddBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigPrSnd"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - SigPrSnd (todas as colunas)
    *--------------------------------------------------------------------------
    this_cIdChaves   = ""  && cidchaves  char(20)  PK
    this_dDatas      = {}  && datas      datetime  NULL
    this_nDocs       = 0   && docs       numeric(10,0)
    this_cHoras      = ""  && horas      char(8)
    this_cMotivos    = ""  && motivos    char(40)
    this_cOperas     = ""  && operas     char(20)
    this_cSenhads    = ""  && senhads    char(6)
    this_cSolicits   = ""  && solicits   char(10)
    this_cUsuars     = ""  && usuars     char(10)
    this_nValors     = 0   && valors     numeric(11,2)
    this_nTipos      = 0   && tipos      numeric(1,0)
    this_cEmps       = ""  && emps       char(3)
    this_cFpags      = ""  && fpags      char(12)
    this_cEmpdopnums = ""  && empdopnums char(29)
    this_nPerlimite  = 0   && perlimite  numeric(5,2)

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (nao persistidas em SigPrSnd)
    *--------------------------------------------------------------------------
    this_lProducao   = .F. && modo producao (parametro recebido pelo form)
    this_lSenhDEmps  = .F. && flag SigCdPac.senhdemps (bit -> logical)
    this_cDsEmpresa  = ""  && descricao empresa (SigCdEmp.Razas, exibida em Get_Ds_Empresa)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigPrSnd"
            THIS.this_cCampoChave = "cIdChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrSddBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves como chave primaria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN RTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: alias do cursor com dados de SigPrSnd
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cIdChaves   = TratarNulo(cidchaves,   "C")
                THIS.this_dDatas      = IIF(VARTYPE(datas) = "T", datas, IIF(VARTYPE(datas) = "D", DATETIME(YEAR(datas), MONTH(datas), DAY(datas)), DATETIME()))
                THIS.this_nDocs       = TratarNulo(docs,        "N")
                THIS.this_cHoras      = TratarNulo(horas,       "C")
                THIS.this_cMotivos    = TratarNulo(motivos,     "C")
                THIS.this_cOperas     = TratarNulo(operas,      "C")
                THIS.this_cSenhads    = TratarNulo(senhads,     "C")
                THIS.this_cSolicits   = TratarNulo(solicits,    "C")
                THIS.this_cUsuars     = TratarNulo(usuars,      "C")
                THIS.this_nValors     = TratarNulo(valors,      "N")
                THIS.this_nTipos      = TratarNulo(tipos,       "N")
                THIS.this_cEmps       = TratarNulo(emps,        "C")
                THIS.this_cFpags      = TratarNulo(fpags,       "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums,  "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,   "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_cMensagem

        loc_cMensagem = ""

        IF EMPTY(ALLTRIM(THIS.this_cSolicits))
            loc_cMensagem = "Informe o Nome do Solicitante."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cEmps))
            loc_cMensagem = "Informe a Empresa."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cOperas))
            loc_cMensagem = "Informe a Opera" + CHR(231) + CHR(227) + "o."
        ENDIF
        IF EMPTY(loc_cMensagem) AND THIS.this_nDocs = 0
            loc_cMensagem = "Informe o N" + CHR(250) + "mero do Documento."
        ENDIF
        IF EMPTY(loc_cMensagem) AND !THIS.this_lProducao AND THIS.this_nValors = 0
            loc_cMensagem = "Informe o Valor."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cMotivos))
            loc_cMensagem = "Informe o Motivo."
        ENDIF

        THIS.this_cMensagemErro = loc_cMensagem
        RETURN EMPTY(loc_cMensagem)
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigPrSnd
    * Chamado apos GeraSenha preencher cIdChaves, Senhads e Horas
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                       "(cidchaves, datas, docs, horas, motivos, operas, senhads, " + ;
                       " solicits, usuars, valors, tipos, emps, fpags, empdopnums, perlimite) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves,   20)) + ", " + ;
                       "GETDATE(), " + ;
                       FormatarNumeroSQL(THIS.this_nDocs,     0)   + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inserir Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigPrSnd por cIdChaves
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                       "datas        = GETDATE(), " + ;
                       "docs         = " + FormatarNumeroSQL(THIS.this_nDocs,     0) + ", " + ;
                       "horas        = " + EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       "motivos      = " + EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       "operas       = " + EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       "senhads      = " + EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       "solicits     = " + EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       "usuars       = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       "valors       = " + FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       "tipos        = " + FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       "emps         = " + EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       "fpags        = " + EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       "empdopnums   = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       "perlimite    = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cIdChaves, 20))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Atualizar Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao na LogAuditoria
    * par_cOperacao: "I" inserir, "A" alterar, "E" excluir
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nRet

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigPrSnd")                           + ", " + ;
                       EscaparSQL(par_cOperacao)                        + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves, 20))        + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 50))        + ", " + ;
                       "GETDATE()" + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            && auditoria nao pode bloquear operacao principal
        ENDTRY
    ENDPROC

    *==========================================================================
    * GeraSenha - Gera senha diaria e persiste em SigPrSnd
    * Retorna a senha gerada ou "" em caso de erro
    * Deve ser chamado apos ValidarDados() retornar .T.
    *==========================================================================
    FUNCTION GeraSenha()
        LOCAL loc_lSucesso, loc_lSenhDEmps, loc_nNum, loc_cSenha, loc_lValido

        loc_lSucesso   = .F.
        loc_lSenhDEmps = .F.
        loc_lValido    = .F.
        loc_nNum       = 0
        loc_cSenha     = ""

        TRY
            loc_lValido = THIS.ValidarDados()

            IF loc_lValido
                loc_lSenhDEmps = THIS.BuscarSenhDEmps()

                IF loc_lSenhDEmps
                    loc_nNum = THIS.BuscarNumeroEmpresa()
                    loc_nNum = loc_nNum + THIS.BuscarNumeroFpag()
                    loc_nNum = loc_nNum + (THIS.this_nValors * 100)
                ENDIF

                *-- Gerar senha pelo algoritmo legado
                loc_cSenha = fGerPswDiario(THIS.this_nDocs, THIS.this_dDatas, loc_nNum)

                *-- Preencher campos gerados antes de inserir
                THIS.this_cSenhads    = LEFT(loc_cSenha, 6)
                THIS.this_cHoras      = LEFT(TIME(), 8)
                THIS.this_cIdChaves   = fUniqueIds()
                THIS.this_nTipos      = IIF(THIS.this_lProducao, 1, 0)
                THIS.this_cEmpdopnums = SPACE(29)
                THIS.this_nPerlimite  = 0
                THIS.this_cUsuars     = LEFT(gc_4c_UsuarioLogado, 10)

                IF THIS.Inserir()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GeraSenha")
            loc_cSenha = ""
        ENDTRY

        RETURN IIF(loc_lSucesso, loc_cSenha, "")
    ENDFUNC

    *==========================================================================
    * BuscarSenhDEmps - Consulta flag SigCdPac.senhdemps
    * Retorna .T. se a senha depende de empresa+pagamento
    *==========================================================================
    PROTECTED FUNCTION BuscarSenhDEmps()
        LOCAL loc_lSenhDEmps, loc_nRet

        loc_lSenhDEmps = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", "cursor_4c_Pac")
            IF loc_nRet > 0 AND USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                SELECT cursor_4c_Pac
                loc_lSenhDEmps = cursor_4c_Pac.senhdemps
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarSenhDEmps")
        ENDTRY

        RETURN loc_lSenhDEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroEmpresa - Busca SigCdEmp.nemps pelo codigo da empresa
    * Retorna valor numerico de nemps (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroEmpresa()
        LOCAL loc_nEmps, loc_nRet, loc_cSQL

        loc_nEmps = 0

        TRY
            loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nRet > 0 AND USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                SELECT cursor_4c_Emp
                loc_nEmps = NVL(cursor_4c_Emp.nemps, 0)
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroEmpresa")
        ENDTRY

        RETURN loc_nEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroFpag - Busca SigOpFp.nfpags pelo codigo de pagamento
    * Retorna valor numerico de nfpags (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroFpag()
        LOCAL loc_nFpags, loc_nRet, loc_cSQL

        loc_nFpags = 0

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cFpags))
                loc_cSQL = "SELECT nfpags FROM SigOpFp WHERE Fpags = " + ;
                           EscaparSQL(LEFT(THIS.this_cFpags, 12))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fpag")
                IF loc_nRet > 0 AND USED("cursor_4c_Fpag") AND !EOF("cursor_4c_Fpag")
                    SELECT cursor_4c_Fpag
                    loc_nFpags = NVL(cursor_4c_Fpag.nfpags, 0)
                ENDIF
                IF USED("cursor_4c_Fpag")
                    USE IN cursor_4c_Fpag
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroFpag")
        ENDTRY

        RETURN loc_nFpags
    ENDFUNC

ENDDEFINE

