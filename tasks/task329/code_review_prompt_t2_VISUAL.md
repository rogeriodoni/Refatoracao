# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [NAVEGACAO-PAGINA] Metodo 'InicializarForm' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSdd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1690 linhas total):

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

*-- Linhas 115 a 124:
115:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
116:         WITH THIS.pgf_4c_Paginas
117:             .PageCount   = 2
118:             .Top         = -29
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = THIS.Height + 29
122:             .Tabs        = .F.
123:             .BorderWidth = 0
124:             .Visible     = .T.

*-- Linhas 133 a 179:
133:         *-- Container Cabecalho (barra escura com titulo) - vazio nesta fase
134:         loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
135:         WITH loc_oPag2.cnt_4c_Cabecalho
136:             .Top         = 29
137:             .Left        = 0
138:             .Width       = THIS.Width
139:             .Height      = 80
140:             .BackStyle   = 1
141:             .BackColor   = RGB(100, 100, 100)
142:             .BorderWidth = 0
143:             .Visible     = .T.
144:         ENDWITH
145: 
146:         *-- Container Botoes CRUD (lado direito do cabecalho) - vazio nesta fase
147:         loc_oPag2.AddObject("cnt_4c_Botoes", "Container")
148:         WITH loc_oPag2.cnt_4c_Botoes
149:             .Top         = 29
150:             .Left        = 542
151:             .Width       = 390
152:             .Height      = 85
153:             .BackStyle   = 0
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         *-- Container Saida/Encerrar (canto direito) - vazio nesta fase
159:         loc_oPag2.AddObject("cnt_4c_Saida", "Container")
160:         WITH loc_oPag2.cnt_4c_Saida
161:             .Top         = 29
162:             .Left        = 917
163:             .Width       = 90
164:             .Height      = 85
165:             .BackStyle   = 0
166:             .BorderWidth = 0
167:             .Visible     = .T.
168:         ENDWITH
169: 
170:         *-- Container Botoes de Acao especificos (Boleto/Gerar Senha) - vazio
171:         loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
172:         WITH loc_oPag2.cnt_4c_BotoesAcao
173:             .Top         = 29
174:             .Left        = 569
175:             .Width       = 240
176:             .Height      = 85
177:             .BackStyle   = 0
178:             .BorderWidth = 0
179:             .Visible     = .T.

*-- Linhas 221 a 293:
221:         *----------------------------------------------------------------------
222:         loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
223:         WITH loc_oPag1.cnt_4c_Cabecalho
224:             .Top         = 29
225:             .Left        = 0
226:             .Width       = THIS.Width
227:             .Height      = 80
228:             .BackStyle   = 1
229:             .BackColor   = RGB(100, 100, 100)
230:             .BorderWidth = 0
231:             .Visible     = .T.
232:         ENDWITH
233:         loc_oCab = loc_oPag1.cnt_4c_Cabecalho
234: 
235:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
236:         WITH loc_oCab.lbl_4c_Sombra
237:             .AutoSize    = .F.
238:             .Width       = THIS.Width
239:             .FontBold    = .T.
240:             .FontName    = "Tahoma"
241:             .FontSize    = 16
242:             .BackStyle   = 0
243:             .Caption     = "Senha do Dia"
244:             .Height      = 40
245:             .Left        = 10
246:             .Top         = 15
247:             .ForeColor   = RGB(0, 0, 0)
248:             .Visible     = .T.
249:         ENDWITH
250: 
251:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
252:         WITH loc_oCab.lbl_4c_Titulo
253:             .AutoSize    = .F.
254:             .Width       = THIS.Width
255:             .FontBold    = .T.
256:             .FontName    = "Tahoma"
257:             .FontSize    = 16
258:             .BackStyle   = 0
259:             .Caption     = "Senha do Dia"
260:             .Height      = 46
261:             .Left        = 10
262:             .Top         = 18
263:             .ForeColor   = RGB(255, 255, 255)
264:             .Visible     = .T.
265:         ENDWITH
266: 
267:         *----------------------------------------------------------------------
268:         * Container de botoes CRUD (lado direito)
269:         *----------------------------------------------------------------------
270:         loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
271:         WITH loc_oPag1.cnt_4c_Botoes
272:             .Top         = 29
273:             .Left        = 542
274:             .Width       = 390
275:             .Height      = 85
276:             .BackStyle   = 0
277:             .BorderWidth = 0
278:             .Visible     = .T.
279:         ENDWITH
280:         loc_oBotoes = loc_oPag1.cnt_4c_Botoes
281: 
282:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
283:         WITH loc_oBotoes.cmd_4c_Incluir
284:             .Left            = 5
285:             .Top             = 5
286:             .Width           = 75
287:             .Height          = 75
288:             .Caption         = "Gerar" + CHR(13) + "Senha"
289:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
290:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
291:             .FontName        = "Tahoma"
292:             .FontBold        = .T.
293:             .FontItalic      = .T.

*-- Linhas 301 a 317:
301:             .WordWrap        = .T.
302:             .Visible         = .T.
303:         ENDWITH
304:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
305: 
306:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
307:         WITH loc_oBotoes.cmd_4c_Visualizar
308:             .Left            = 80
309:             .Top             = 5
310:             .Width           = 75
311:             .Height          = 75
312:             .Caption         = "Visualizar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
314:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
315:             .FontName        = "Tahoma"
316:             .FontBold        = .T.
317:             .FontItalic      = .T.

*-- Linhas 325 a 341:
325:             .WordWrap        = .T.
326:             .Visible         = .T.
327:         ENDWITH
328:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
329: 
330:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
331:         WITH loc_oBotoes.cmd_4c_Alterar
332:             .Left            = 155
333:             .Top             = 5
334:             .Width           = 75
335:             .Height          = 75
336:             .Caption         = "Alterar"
337:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
338:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
339:             .FontName        = "Tahoma"
340:             .FontBold        = .T.
341:             .FontItalic      = .T.

*-- Linhas 349 a 365:
349:             .WordWrap        = .T.
350:             .Visible         = .T.
351:         ENDWITH
352:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
353: 
354:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
355:         WITH loc_oBotoes.cmd_4c_Excluir
356:             .Left            = 230
357:             .Top             = 5
358:             .Width           = 75
359:             .Height          = 75
360:             .Caption         = "Excluir"
361:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
362:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
363:             .FontName        = "Tahoma"
364:             .FontBold        = .T.
365:             .FontItalic      = .T.

*-- Linhas 373 a 389:
373:             .WordWrap        = .T.
374:             .Visible         = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
377: 
378:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
379:         WITH loc_oBotoes.cmd_4c_Buscar
380:             .Left            = 305
381:             .Top             = 5
382:             .Width           = 75
383:             .Height          = 75
384:             .Caption         = "Buscar"
385:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
386:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
387:             .FontName        = "Tahoma"
388:             .FontBold        = .T.
389:             .FontItalic      = .T.

*-- Linhas 397 a 430:
397:             .WordWrap        = .T.
398:             .Visible         = .T.
399:         ENDWITH
400:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
401: 
402:         *----------------------------------------------------------------------
403:         * Container Saida/Encerrar - padrao canonico Left=917 W=90
404:         *----------------------------------------------------------------------
405:         loc_oPag1.AddObject("cnt_4c_Saida", "Container")
406:         WITH loc_oPag1.cnt_4c_Saida
407:             .Top         = 29
408:             .Left        = 917
409:             .Width       = 90
410:             .Height      = 85
411:             .BackStyle   = 0
412:             .BorderWidth = 0
413:             .Visible     = .T.
414:         ENDWITH
415:         loc_oSaida = loc_oPag1.cnt_4c_Saida
416: 
417:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
418:         WITH loc_oSaida.cmd_4c_Encerrar
419:             .Left            = 5
420:             .Top             = 5
421:             .Width           = 75
422:             .Height          = 75
423:             .Caption         = "Encerrar"
424:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
425:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
426:             .Cancel          = .T.
427:             .FontName        = "Tahoma"
428:             .FontBold        = .T.
429:             .FontItalic      = .T.
430:             .FontSize        = 8

*-- Linhas 437 a 453:
437:             .WordWrap        = .T.
438:             .Visible         = .T.
439:         ENDWITH
440:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
441: 
442:         *----------------------------------------------------------------------
443:         * Grid de lista de senhas geradas (SigPrSnd)
444:         *----------------------------------------------------------------------
445:         loc_oPag1.AddObject("grd_4c_Lista", "Grid")
446:         WITH loc_oPag1.grd_4c_Lista
447:             .Top                = 117
448:             .Left               = 5
449:             .Width              = 990
450:             .Height             = 450
451:             .FontName           = "Verdana"
452:             .FontSize           = 8
453:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 519 a 534:
519:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Lista.senhads"
520:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Lista.tipos"
521: 
522:                 loc_oGrid.Column1.Header1.Caption = "Data/Hora"
523:                 loc_oGrid.Column2.Header1.Caption = "Solicitante"
524:                 loc_oGrid.Column3.Header1.Caption = "Empresa"
525:                 loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
526:                 loc_oGrid.Column5.Header1.Caption = "Documento"
527:                 loc_oGrid.Column6.Header1.Caption = "Valor"
528:                 loc_oGrid.Column7.Header1.Caption = "Senha"
529:                 loc_oGrid.Column8.Header1.Caption = "Tipo"
530: 
531:                 loc_oGrid.Column1.Width = 120
532:                 loc_oGrid.Column2.Width = 90
533:                 loc_oGrid.Column3.Width = 50
534:                 loc_oGrid.Column4.Width = 170

*-- Linhas 667 a 718:
667:         *----------------------------------------------------------------------
668:         loc_oCab = loc_oPag2.cnt_4c_Cabecalho
669: 
670:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
671:         WITH loc_oCab.lbl_4c_Sombra
672:             .AutoSize  = .F.
673:             .Width     = THIS.Width
674:             .FontBold  = .T.
675:             .FontName  = "Tahoma"
676:             .FontSize  = 18
677:             .BackStyle = 0
678:             .Caption   = "Senha do Dia"
679:             .Height    = 40
680:             .Left      = 10
681:             .Top       = 18
682:             .ForeColor = RGB(0, 0, 0)
683:             .Visible   = .T.
684:         ENDWITH
685: 
686:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
687:         WITH loc_oCab.lbl_4c_Titulo
688:             .AutoSize  = .F.
689:             .Width     = THIS.Width
690:             .FontBold  = .T.
691:             .FontName  = "Tahoma"
692:             .FontSize  = 18
693:             .BackStyle = 0
694:             .Caption   = "Senha do Dia"
695:             .Height    = 46
696:             .Left      = 10
697:             .Top       = 17
698:             .ForeColor = RGB(255, 255, 255)
699:             .Visible   = .T.
700:         ENDWITH
701: 
702:         *----------------------------------------------------------------------
703:         * Botoes de acao: Boleto e Gerar Senha (container criado em ConfigurarPageFrame)
704:         *----------------------------------------------------------------------
705:         loc_oBotoesAcao = loc_oPag2.cnt_4c_BotoesAcao
706: 
707:         loc_oBotoesAcao.AddObject("cmd_4c_Boleto", "CommandButton")
708:         WITH loc_oBotoesAcao.cmd_4c_Boleto
709:             .Left            = 5
710:             .Top             = 5
711:             .Width           = 75
712:             .Height          = 75
713:             .Caption         = "Boleto"
714:             .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
715:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
716:             .FontName        = "Tahoma"
717:             .FontBold        = .T.
718:             .FontItalic      = .T.

*-- Linhas 726 a 773:
726:             .WordWrap        = .T.
727:             .Visible         = .T.
728:         ENDWITH
729:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")
730: 
731:         loc_oBotoesAcao.AddObject("cmd_4c_GeraSenha", "CommandButton")
732:         WITH loc_oBotoesAcao.cmd_4c_GeraSenha
733:             .Left            = 80
734:             .Top             = 5
735:             .Width           = 75
736:             .Height          = 75
737:             .Caption         = "Gerar" + CHR(13) + "Senha"
738:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
739:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
740:             .FontName        = "Tahoma"
741:             .FontBold        = .T.
742:             .FontItalic      = .T.
743:             .FontSize        = 8
744:             .ForeColor       = RGB(90, 90, 90)
745:             .BackColor       = RGB(255, 255, 255)
746:             .Themes          = .F.
747:             .SpecialEffect   = 0
748:             .PicturePosition = 13
749:             .MousePointer    = 15
750:             .WordWrap        = .T.
751:             .Visible         = .T.
752:         ENDWITH
753:         BINDEVENT(loc_oBotoesAcao.cmd_4c_GeraSenha, "Click", THIS, "BtnGeraSenhaClick")
754: 
755:         *----------------------------------------------------------------------
756:         * Botao Encerrar (container cnt_4c_Saida criado em ConfigurarPageFrame)
757:         *----------------------------------------------------------------------
758:         loc_oSaida = loc_oPag2.cnt_4c_Saida
759: 
760:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
761:         WITH loc_oSaida.cmd_4c_Encerrar
762:             .Left            = 5
763:             .Top             = 5
764:             .Width           = 75
765:             .Height          = 75
766:             .Caption         = "Encerrar"
767:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
768:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
769:             .Cancel          = .T.
770:             .FontName        = "Tahoma"
771:             .FontBold        = .T.
772:             .FontItalic      = .T.
773:             .FontSize        = 8

*-- Linhas 780 a 816:
780:             .WordWrap        = .T.
781:             .Visible         = .T.
782:         ENDWITH
783:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
784: 
785:         *----------------------------------------------------------------------
786:         * Solicitante (TabIndex=1) - Top original 83 + 29 = 112
787:         * Label original Top=86 + 29 = 115
788:         *----------------------------------------------------------------------
789:         loc_oPag2.AddObject("lbl_4c_Solicitante", "Label")
790:         WITH loc_oPag2.lbl_4c_Solicitante
791:             .AutoSize  = .T.
792:             .FontName  = "Tahoma"
793:             .FontSize  = 8
794:             .BackStyle = 0
795:             .Caption   = "Solicitante : "
796:             .Height    = 15
797:             .Left      = 81
798:             .Top       = 115
799:             .ForeColor = RGB(90, 90, 90)
800:             .Visible   = .T.
801:         ENDWITH
802: 
803:         loc_oPag2.AddObject("txt_4c_Solic", "TextBox")
804:         WITH loc_oPag2.txt_4c_Solic
805:             .FontName      = "Tahoma"
806:             .FontSize      = 8
807:             .Value         = ""
808:             .MaxLength     = 10
809:             .Height        = 23
810:             .Left          = 144
811:             .Top           = 112
812:             .Width         = 80
813:             .Format        = "K!"
814:             .SpecialEffect = 1
815:             .ForeColor     = RGB(90, 90, 90)
816:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 822 a 852:
822:         * Empresa - Codigo (TabIndex=2) e Nome (TabIndex=3)
823:         * Top original 108 + 29 = 137; label original Top=112 + 29 = 141
824:         *----------------------------------------------------------------------
825:         loc_oPag2.AddObject("lbl_4c_Empresa", "Label")
826:         WITH loc_oPag2.lbl_4c_Empresa
827:             .AutoSize  = .T.
828:             .FontName  = "Tahoma"
829:             .FontSize  = 8
830:             .BackStyle = 0
831:             .Caption   = "Empresa : "
832:             .Height    = 15
833:             .Left      = 89
834:             .Top       = 141
835:             .ForeColor = RGB(90, 90, 90)
836:             .Visible   = .T.
837:         ENDWITH
838: 
839:         loc_oPag2.AddObject("txt_4c_Cd_Empresa", "TextBox")
840:         WITH loc_oPag2.txt_4c_Cd_Empresa
841:             .FontName      = "Tahoma"
842:             .FontSize      = 8
843:             .Value         = ""
844:             .MaxLength     = 3
845:             .Height        = 25
846:             .Left          = 144
847:             .Top           = 137
848:             .Width         = 32
849:             .Format        = "K"
850:             .SpecialEffect = 1
851:             .ForeColor     = RGB(90, 90, 90)
852:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 861 a 870:
861:             .Value         = ""
862:             .MaxLength     = 40
863:             .Height        = 25
864:             .Left          = 178
865:             .Top           = 137
866:             .Width         = 290
867:             .Format        = "K"
868:             .SpecialEffect = 1
869:             .ForeColor     = RGB(90, 90, 90)
870:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 876 a 906:
876:         * Operacao (TabIndex=4) - Top original 135 + 29 = 164
877:         * Label original Top=140 + 29 = 169
878:         *----------------------------------------------------------------------
879:         loc_oPag2.AddObject("lbl_4c_Operacao", "Label")
880:         WITH loc_oPag2.lbl_4c_Operacao
881:             .AutoSize  = .T.
882:             .FontName  = "Tahoma"
883:             .FontSize  = 8
884:             .BackStyle = 0
885:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
886:             .Height    = 15
887:             .Left      = 83
888:             .Top       = 169
889:             .ForeColor = RGB(90, 90, 90)
890:             .Visible   = .T.
891:         ENDWITH
892: 
893:         loc_oPag2.AddObject("txt_4c_Operacao", "TextBox")
894:         WITH loc_oPag2.txt_4c_Operacao
895:             .FontName      = "Tahoma"
896:             .FontSize      = 8
897:             .Value         = ""
898:             .MaxLength     = 20
899:             .Height        = 25
900:             .Left          = 144
901:             .Top           = 164
902:             .Width         = 150
903:             .Format        = "K"
904:             .SpecialEffect = 1
905:             .ForeColor     = RGB(90, 90, 90)
906:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 912 a 942:
912:         * Documento (TabIndex=5) - Top original 162 + 29 = 191
913:         * Label original Top=165 + 29 = 194
914:         *----------------------------------------------------------------------
915:         loc_oPag2.AddObject("lbl_4c_Documento", "Label")
916:         WITH loc_oPag2.lbl_4c_Documento
917:             .AutoSize  = .T.
918:             .FontName  = "Tahoma"
919:             .FontSize  = 8
920:             .BackStyle = 0
921:             .Caption   = "Documento : "
922:             .Height    = 15
923:             .Left      = 76
924:             .Top       = 194
925:             .ForeColor = RGB(90, 90, 90)
926:             .Visible   = .T.
927:         ENDWITH
928: 
929:         loc_oPag2.AddObject("txt_4c_Doc", "TextBox")
930:         WITH loc_oPag2.txt_4c_Doc
931:             .FontName      = "Tahoma"
932:             .FontSize      = 8
933:             .Value         = 0
934:             .InputMask     = "9999999999"
935:             .Height        = 23
936:             .Left          = 144
937:             .Top           = 191
938:             .Width         = 80
939:             .Format        = "K"
940:             .SpecialEffect = 1
941:             .ForeColor     = RGB(90, 90, 90)
942:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 948 a 978:
948:         * Cond. Pagto / Forma Pagamento (TabIndex=6) - Top original 187 + 29 = 216
949:         * Label original Top=192 + 29 = 221
950:         *----------------------------------------------------------------------
951:         loc_oPag2.AddObject("lbl_4c_CondPagto", "Label")
952:         WITH loc_oPag2.lbl_4c_CondPagto
953:             .AutoSize  = .T.
954:             .FontName  = "Tahoma"
955:             .FontSize  = 8
956:             .BackStyle = 0
957:             .Caption   = "Cond. Pagto : "
958:             .Height    = 15
959:             .Left      = 70
960:             .Top       = 221
961:             .ForeColor = RGB(90, 90, 90)
962:             .Visible   = .T.
963:         ENDWITH
964: 
965:         loc_oPag2.AddObject("txt_4c_Fpg", "TextBox")
966:         WITH loc_oPag2.txt_4c_Fpg
967:             .FontName      = "Tahoma"
968:             .FontSize      = 8
969:             .Value         = ""
970:             .MaxLength     = 12
971:             .Height        = 23
972:             .Left          = 144
973:             .Top           = 216
974:             .Width         = 94
975:             .Format        = "K"
976:             .SpecialEffect = 1
977:             .ForeColor     = RGB(90, 90, 90)
978:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 986 a 1016:
986:         * ReadOnly: When original retorna .F. (campo sempre bloqueado)
987:         * Label original Top=215 + 29 = 244
988:         *----------------------------------------------------------------------
989:         loc_oPag2.AddObject("lbl_4c_Data", "Label")
990:         WITH loc_oPag2.lbl_4c_Data
991:             .AutoSize  = .T.
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:             .BackStyle = 0
995:             .Caption   = "Data : "
996:             .Height    = 15
997:             .Left      = 107
998:             .Top       = 244
999:             .ForeColor = RGB(90, 90, 90)
1000:             .Visible   = .T.
1001:         ENDWITH
1002: 
1003:         loc_oPag2.AddObject("txt_4c_Data", "TextBox")
1004:         WITH loc_oPag2.txt_4c_Data
1005:             .FontName      = "Tahoma"
1006:             .FontSize      = 8
1007:             .Value         = DATETIME()
1008:             .ReadOnly      = .T.
1009:             .Height        = 23
1010:             .Left          = 144
1011:             .Top           = 241
1012:             .Width         = 75
1013:             .Format        = "K"
1014:             .SpecialEffect = 1
1015:             .ForeColor     = RGB(90, 90, 90)
1016:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1023 a 1053:
1023:         * Habilitado apenas em modo !Producao (When = Not Thisform.Producao)
1024:         * Label original Top=240 + 29 = 269
1025:         *----------------------------------------------------------------------
1026:         loc_oPag2.AddObject("lbl_4c_Valor", "Label")
1027:         WITH loc_oPag2.lbl_4c_Valor
1028:             .AutoSize  = .T.
1029:             .FontName  = "Tahoma"
1030:             .FontSize  = 8
1031:             .BackStyle = 0
1032:             .Caption   = "Valor : "
1033:             .Height    = 15
1034:             .Left      = 106
1035:             .Top       = 269
1036:             .ForeColor = RGB(90, 90, 90)
1037:             .Visible   = .T.
1038:         ENDWITH
1039: 
1040:         loc_oPag2.AddObject("txt_4c_Valor", "TextBox")
1041:         WITH loc_oPag2.txt_4c_Valor
1042:             .FontName      = "Tahoma"
1043:             .FontSize      = 8
1044:             .Value         = 0
1045:             .InputMask     = "999,999,999.99"
1046:             .Height        = 23
1047:             .Left          = 144
1048:             .Top           = 266
1049:             .Width         = 100
1050:             .Format        = "K"
1051:             .SpecialEffect = 1
1052:             .ForeColor     = RGB(90, 90, 90)
1053:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1060 a 1090:
1060:         * Motivo (TabIndex=9) - Top original 262 + 29 = 291
1061:         * Label original Top=265 + 29 = 294
1062:         *----------------------------------------------------------------------
1063:         loc_oPag2.AddObject("lbl_4c_Motivo", "Label")
1064:         WITH loc_oPag2.lbl_4c_Motivo
1065:             .AutoSize  = .T.
1066:             .FontName  = "Tahoma"
1067:             .FontSize  = 8
1068:             .BackStyle = 0
1069:             .Caption   = "Motivo : "
1070:             .Height    = 15
1071:             .Left      = 98
1072:             .Top       = 294
1073:             .ForeColor = RGB(90, 90, 90)
1074:             .Visible   = .T.
1075:         ENDWITH
1076: 
1077:         loc_oPag2.AddObject("txt_4c_Motivo", "TextBox")
1078:         WITH loc_oPag2.txt_4c_Motivo
1079:             .FontName      = "Tahoma"
1080:             .FontSize      = 8
1081:             .Value         = ""
1082:             .MaxLength     = 40
1083:             .Height        = 23
1084:             .Left          = 144
1085:             .Top           = 291
1086:             .Width         = 360
1087:             .Format        = "K!"
1088:             .SpecialEffect = 1
1089:             .ForeColor     = RGB(90, 90, 90)
1090:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1667 a 1688:
1667: 
1668:         IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
1669:             WITH loc_oPag1.cnt_4c_Botoes
1670:                 IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1671:                     .cmd_4c_Incluir.Enabled    = .T.
1672:                 ENDIF
1673:                 IF PEMSTATUS(.cmd_4c_Visualizar, "Enabled", 5)
1674:                     .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1675:                 ENDIF
1676:                 IF PEMSTATUS(.cmd_4c_Alterar, "Enabled", 5)
1677:                     .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1678:                 ENDIF
1679:                 IF PEMSTATUS(.cmd_4c_Excluir, "Enabled", 5)
1680:                     .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1681:                 ENDIF
1682:                 IF PEMSTATUS(.cmd_4c_Buscar, "Enabled", 5)
1683:                     .cmd_4c_Buscar.Enabled     = .T.
1684:                 ENDIF
1685:                 .Visible     = .T.
1686:             ENDWITH
1687:         ENDIF
1688:     ENDPROC


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

