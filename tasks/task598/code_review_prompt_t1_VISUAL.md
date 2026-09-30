# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [ALINHAMENTO] Botao 'cmd_4c_Processar' tem Top=7 mas grupo usa Top=5 (diferenca de 2px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3480 linhas total):

*-- Linhas 52 a 63:
52:                     "FormSigPrCtr.InicializarForm")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Visible = .T.
60:                 THIS.pgf_4c_Paginas.ActivePage = 1
61:                 THIS.this_cModoAtual = "LISTA"
62: 
63:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 86 a 105:
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 29
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()

*-- Linhas 162 a 199:
162:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina (regra #11)
163:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
164:         WITH loc_oPagina.cnt_4c_Cabecalho
165:             .Top         = 31
166:             .Left        = 0
167:             .Width       = THIS.Width
168:             .Height      = 80
169:             .BackColor   = RGB(100, 100, 100)
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
175:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
176:             .Caption   = THIS.Caption
177:             .Top       = 15
178:             .Left      = 10
179:             .Width     = THIS.Width - 20
180:             .Height    = 40
181:             .FontName  = "Tahoma"
182:             .FontSize  = 16
183:             .FontBold  = .T.
184:             .ForeColor = RGB(0, 0, 0)
185:             .BackStyle = 0
186:             .AutoSize  = .F.
187:             .Visible   = .T.
188:         ENDWITH
189: 
190:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
191:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
192:             .Caption   = THIS.Caption
193:             .Top       = 18
194:             .Left      = 10
195:             .Width     = THIS.Width - 20
196:             .Height    = 46
197:             .FontName  = "Tahoma"
198:             .FontSize  = 16
199:             .FontBold  = .T.

*-- Linhas 207 a 232:
207:         *-- Posicionado relativo a THIS.Width (canonico: Left=542 quando Width=1000)
208:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
209:         WITH loc_oPagina.cnt_4c_Botoes
210:             .Top         = 29
211:             .Left        = THIS.Width - 458
212:             .Width       = 390
213:             .Height      = 85
214:             .BackColor   = RGB(53, 53, 53)
215:             .BackStyle   = 1
216:             .BorderWidth = 0
217:             .Visible     = .T.
218:         ENDWITH
219:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
220: 
221:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
222:         WITH loc_oCnt.cmd_4c_Incluir
223:             .Caption         = "Incluir"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 5
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Tahoma"
231:             .FontSize        = 8
232:             .FontBold        = .T.

*-- Linhas 239 a 255:
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:         ENDWITH
242:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
243: 
244:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
245:         WITH loc_oCnt.cmd_4c_Visualizar
246:             .Caption         = "Visualizar"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 80
251:             .Width           = 75
252:             .Height          = 75
253:             .FontName        = "Tahoma"
254:             .FontSize        = 8
255:             .FontBold        = .T.

*-- Linhas 262 a 278:
262:             .WordWrap        = .T.
263:             .AutoSize        = .F.
264:         ENDWITH
265:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
266: 
267:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
268:         WITH loc_oCnt.cmd_4c_Alterar
269:             .Caption         = "Alterar"
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
271:             .PicturePosition = 13
272:             .Top             = 5
273:             .Left            = 155
274:             .Width           = 75
275:             .Height          = 75
276:             .FontName        = "Tahoma"
277:             .FontSize        = 8
278:             .FontBold        = .T.

*-- Linhas 285 a 301:
285:             .WordWrap        = .T.
286:             .AutoSize        = .F.
287:         ENDWITH
288:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
289: 
290:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
291:         WITH loc_oCnt.cmd_4c_Excluir
292:             .Caption         = "Excluir"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 230
297:             .Width           = 75
298:             .Height          = 75
299:             .FontName        = "Tahoma"
300:             .FontSize        = 8
301:             .FontBold        = .T.

*-- Linhas 308 a 324:
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:         ENDWITH
311:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
312: 
313:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
314:         WITH loc_oCnt.cmd_4c_Buscar
315:             .Caption         = "Buscar"
316:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
317:             .PicturePosition = 13
318:             .Top             = 5
319:             .Left            = 305
320:             .Width           = 75
321:             .Height          = 75
322:             .FontName        = "Tahoma"
323:             .FontSize        = 8
324:             .FontBold        = .T.

*-- Linhas 331 a 359:
331:             .WordWrap        = .T.
332:             .AutoSize        = .F.
333:         ENDWITH
334:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
335: 
336:         *-- Container Saida (padrao canonico - regra #10: Width=90, Encerrar 75x75)
337:         *-- Posicionado relativo a THIS.Width (canonico: Left=917 quando Width=1000)
338:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
339:         WITH loc_oPagina.cnt_4c_Saida
340:             .Top         = 29
341:             .Left        = 917
342:             .Width       = 90
343:             .Height      = 85
344:             .BackStyle   = 0
345:             .BorderWidth = 0
346:             .Visible     = .T.
347:         ENDWITH
348:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
349:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
350:             .Caption         = "Encerrar"
351:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
352:             .PicturePosition = 13
353:             .Top             = 5
354:             .Left            = 5
355:             .Width           = 75
356:             .Height          = 75
357:             .FontName        = "Tahoma"
358:             .FontSize        = 8
359:             .FontBold        = .T.

*-- Linhas 366 a 435:
366:             .WordWrap        = .T.
367:             .AutoSize        = .F.
368:         ENDWITH
369:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
370: 
371:         *-- Filtro de Periodo (legado: Pagina.Lista.Label1/Dt_inicial/Dt_final/Say2)
372:         *-- Top compensado: 106+29=135 (Label1/Say2), 102+29=131 (Dt_inicial/Dt_final)
373:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
374:         WITH loc_oPagina.lbl_4c_Label1
375:             .Caption   = "Per" + CHR(237) + "odo :"
376:             .Top       = 135
377:             .Left      = 440
378:             .Width     = 45
379:             .Height    = 15
380:             .FontName  = "Tahoma"
381:             .FontSize  = 8
382:             .ForeColor = RGB(90, 90, 90)
383:             .BackStyle = 0
384:         ENDWITH
385: 
386:         loc_oPagina.AddObject("txt_4c_Dt_inicial", "TextBox")
387:         WITH loc_oPagina.txt_4c_Dt_inicial
388:             .Top      = 131
389:             .Left      = 495
390:             .Width    = 80
391:             .Height   = 21
392:             .Format   = "D"
393:             .Value    = DATE()
394:             .FontName = "Tahoma"
395:             .FontSize = 8
396:         ENDWITH
397:         BINDEVENT(loc_oPagina.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
398: 
399:         loc_oPagina.AddObject("txt_4c_Dt_final", "TextBox")
400:         WITH loc_oPagina.txt_4c_Dt_final
401:             .Top      = 131
402:             .Left     = 598
403:             .Width    = 80
404:             .Height   = 21
405:             .Format   = "D"
406:             .Value    = DATE()
407:             .FontName = "Tahoma"
408:             .FontSize = 8
409:         ENDWITH
410:         BINDEVENT(loc_oPagina.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")
411: 
412:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
413:         WITH loc_oPagina.lbl_4c_Label2
414:             .Caption   = "?"
415:             .Top       = 135
416:             .Left      = 582
417:             .Width     = 15
418:             .Height    = 15
419:             .FontName  = "Tahoma"
420:             .FontSize  = 8
421:             .ForeColor = RGB(90, 90, 90)
422:             .BackStyle = 0
423:         ENDWITH
424: 
425:         *-- Grid de Lista (Grade no legado) - Top compensado: 130+29=159
426:         *-- Alimentada por CarregarLista() com a query lcQueryLista do Init legado
427:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
428:         loc_oGrid = loc_oPagina.grd_4c_Lista
429:         loc_oGrid.Top                = 159
430:         loc_oGrid.Left               = 12
431:         loc_oGrid.Width              = 1138
432:         loc_oGrid.Height             = 470
433:         loc_oGrid.ColumnCount        = 6
434:         loc_oGrid.FontName           = "Tahoma"
435:         loc_oGrid.FontSize           = 8

*-- Linhas 515 a 528:
515:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.Rclis"
516: 
517:                 *-- Reconfigurar cabecalhos e largura APOS RecordSource (obrigatorio - regra #48)
518:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
519:                 loc_oGrid.Column2.Header1.Caption = "Data"
520:                 loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
521:                 loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
522:                 loc_oGrid.Column5.Header1.Caption = "Fornecedor"
523:                 loc_oGrid.Column6.Header1.Caption = "Nome"
524: 
525:                 THIS.FormatarGridLista(loc_oGrid)
526: 
527:                 *-- Column.Width por ULTIMO (regra #35c: RecordSource/ControlSource
528:                 *-- recalculam a largura para o default 90 - so fica se atribuido

*-- Linhas 641 a 678:
641:         *-- Cabecalho cinza (identico ao da pagina Lista - regra #11)
642:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
643:         WITH loc_oPagina.cnt_4c_Cabecalho
644:             .Top           = 29
645:             .Left          = 0
646:             .Width         = THIS.Width
647:             .Height        = 80
648:             .BackColor     = RGB(100, 100, 100)
649:             .BorderWidth   = 0
650:             .SpecialEffect = 0
651:             .Visible       = .T.
652: 
653:             .AddObject("lbl_4c_Sombra", "Label")
654:             WITH .lbl_4c_Sombra
655:                 .Caption   = THIS.Caption
656:                 .Top       = 15
657:                 .Left      = 10
658:                 .Width     = THIS.Width
659:                 .Height    = 40
660:                 .FontName  = "Tahoma"
661:                 .FontSize  = 16
662:                 .FontBold  = .T.
663:                 .ForeColor = RGB(0, 0, 0)
664:                 .BackStyle = 0
665:                 .AutoSize  = .F.
666:                 .Visible   = .T.
667:             ENDWITH
668: 
669:             .AddObject("lbl_4c_Titulo", "Label")
670:             WITH .lbl_4c_Titulo
671:                 .Caption   = THIS.Caption
672:                 .Top       = 18
673:                 .Left      = 10
674:                 .Width     = THIS.Width
675:                 .Height    = 46
676:                 .FontName  = "Tahoma"
677:                 .FontSize  = 16
678:                 .FontBold  = .T.

*-- Linhas 687 a 711:
687:         *-- Posicionado relativo a THIS.Width (canonico: Left=842 quando Width=1000)
688:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
689:         WITH loc_oPagina.cnt_4c_BotoesAcao
690:             .Top         = 33
691:             .Left        = THIS.Width - 158
692:             .Width       = 160
693:             .Height      = 85
694:             .BackStyle = 0
695:             .BackColor   = RGB(255, 255, 255)
696:             .BorderWidth = 0
697:             .Visible     = .T.
698:         ENDWITH
699: 
700:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
701:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
702:             .Caption         = "Confirmar"
703:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
704:             .PicturePosition = 13
705:             .Top             = 5
706:             .Left            = 5
707:             .Width           = 75
708:             .Height          = 75
709:             .FontName        = "Comic Sans MS"
710:             .FontSize        = 8
711:             .FontBold        = .T.

*-- Linhas 719 a 735:
719:             .AutoSize        = .F.
720:             .Enabled         = .F.
721:         ENDWITH
722:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
723: 
724:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
725:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
726:             .Caption         = "Encerrar"
727:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
728:             .PicturePosition = 13
729:             .Top             = 5
730:             .Left            = 80
731:             .Width           = 75
732:             .Height          = 75
733:             .FontName        = "Comic Sans MS"
734:             .FontSize        = 8
735:             .FontBold        = .T.

*-- Linhas 742 a 750:
742:             .WordWrap        = .T.
743:             .AutoSize        = .F.
744:         ENDWITH
745:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
746: 
747:         *-- ===================================================================
748:         *-- PageFrame interno (legado: Pagina.Dados.Pageframe1) - Precificacao
749:         *-- (Page1) e Movimentacoes/Produtos (Page2). Tabs=.T. (abas reais e
750:         *-- visiveis, ao contrario do PageFrame externo pgf_4c_Paginas) - por

*-- Linhas 759 a 788:
759:         loc_oPagina.AddObject("pgf_4c_Detalhes", "PageFrame")
760:         WITH loc_oPagina.pgf_4c_Detalhes
761:             .PageCount = 2
762:             .Top       = 115
763:             .Left      = 5
764:             .Width     = THIS.Width - 10
765:             .Height    = 485
766:             .Tabs      = .T.
767:             .Visible   = .T.
768: 
769:             .Page1.Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
770:             .Page1.BackColor = RGB(255, 255, 255)
771: 
772:             .Page2.Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
773:             .Page2.BackColor = RGB(255, 255, 255)
774:         ENDWITH
775: 
776:         loc_oAba1 = loc_oPagina.pgf_4c_Detalhes.Page1
777: 
778:         *-- Say4 "Fornecedores :"
779:         loc_oAba1.AddObject("lbl_4c_Fornecedores", "Label")
780:         WITH loc_oAba1.lbl_4c_Fornecedores
781:             .Caption   = "Fornecedores :"
782:             .Top       = 69
783:             .Left      = 228
784:             .Width     = 75
785:             .Height    = 15
786:             .Alignment = 0
787:             .AutoSize  = .F.
788:             .BackStyle = 0

*-- Linhas 796 a 805:
796:         *-- SigPrCtr, portanto NAO e mapeado para propriedade do BO)
797:         loc_oAba1.AddObject("txt_4c_Grupo", "TextBox")
798:         WITH loc_oAba1.txt_4c_Grupo
799:             .Top           = 66
800:             .Left          = 307
801:             .Width         = 85
802:             .Height        = 21
803:             .FontName      = "Tahoma"
804:             .FontSize      = 8
805:             .Format        = "K"

*-- Linhas 815 a 824:
815:         *-- Get_Conta -> this_cContas (schema: contas char(10))
816:         loc_oAba1.AddObject("txt_4c_Conta", "TextBox")
817:         WITH loc_oAba1.txt_4c_Conta
818:             .Top           = 66
819:             .Left          = 394
820:             .Width         = 85
821:             .Height        = 21
822:             .FontName      = "Tahoma"
823:             .FontSize      = 8
824:             .Format        = "K"

*-- Linhas 835 a 844:
835:         *-- SigPrCtr nao tem coluna de CPF, campo nao e persistido diretamente)
836:         loc_oAba1.AddObject("txt_4c_Cpf", "TextBox")
837:         WITH loc_oAba1.txt_4c_Cpf
838:             .Top           = 66
839:             .Left          = 481
840:             .Width         = 146
841:             .Height        = 21
842:             .FontName      = "Tahoma"
843:             .FontSize      = 8
844:             .InputMask     = "XXXXXXXXXXXXXXXXXXXX"

*-- Linhas 853 a 862:
853:         *-- validar a Conta - CursorQuery em SigCdCli.Rclis no legado)
854:         loc_oAba1.AddObject("txt_4c_Dconta", "TextBox")
855:         WITH loc_oAba1.txt_4c_Dconta
856:             .Top           = 89
857:             .Left          = 307
858:             .Width         = 357
859:             .Height        = 21
860:             .FontName      = "Tahoma"
861:             .FontSize      = 8
862:             .Format        = "K"

*-- Linhas 868 a 880:
868:         BINDEVENT(loc_oAba1.txt_4c_Dconta, "KeyPress", THIS, "ValidarDescricaoConta")
869: 
870:         *-- Say1 "Precificacao :"
871:         loc_oAba1.AddObject("lbl_4c_Precificacao", "Label")
872:         WITH loc_oAba1.lbl_4c_Precificacao
873:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o :"
874:             .Top       = 114
875:             .Left      = 237
876:             .Width     = 66
877:             .Height    = 15
878:             .Alignment = 0
879:             .AutoSize  = .F.
880:             .BackStyle = 0

*-- Linhas 889 a 935:
889:         loc_oAba1.AddObject("opt_4c_Custo", "OptionGroup")
890:         WITH loc_oAba1.opt_4c_Custo
891:             .ButtonCount = 2
892:             .Top         = 113
893:             .Left        = 303
894:             .Width       = 255
895:             .Height      = 17
896:             .BackStyle   = 0
897:             .BorderStyle = 0
898:             .Value       = 1
899:         ENDWITH
900:         WITH loc_oAba1.opt_4c_Custo.Buttons(1)
901:             .Caption   = "Custo Total"
902:             .Top       = 1
903:             .Left      = 5
904:             .Width     = 73
905:             .Height    = 15
906:             .AutoSize  = .T.
907:             .FontName  = "Tahoma"
908:             .FontSize  = 8
909:             .BackStyle = 0
910:             .ForeColor = RGB(90, 90, 90)
911:         ENDWITH
912:         WITH loc_oAba1.opt_4c_Custo.Buttons(2)
913:             .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
914:             .Top       = 1
915:             .Left      = 98
916:             .Width     = 129
917:             .Height    = 15
918:             .AutoSize  = .T.
919:             .FontName  = "Tahoma"
920:             .FontSize  = 8
921:             .BackStyle = 0
922:             .ForeColor = RGB(90, 90, 90)
923:         ENDWITH
924: 
925:         *-- Say3 "Moeda :"
926:         loc_oAba1.AddObject("lbl_4c_Moeda", "Label")
927:         WITH loc_oAba1.lbl_4c_Moeda
928:             .Caption   = "Moeda :"
929:             .Top       = 137
930:             .Left      = 262
931:             .Width     = 41
932:             .Height    = 15
933:             .Alignment = 0
934:             .AutoSize  = .F.
935:             .BackStyle = 0

*-- Linhas 942 a 951:
942:         *-- conforme SCHEMA, nao os 10 do dump legado - regra #19)
943:         loc_oAba1.AddObject("txt_4c_Moeda", "TextBox")
944:         WITH loc_oAba1.txt_4c_Moeda
945:             .Top           = 134
946:             .Left          = 307
947:             .Width         = 85
948:             .Height        = 21
949:             .FontName      = "Tahoma"
950:             .FontSize      = 8
951:             .Format        = "K"

*-- Linhas 959 a 971:
959:         BINDEVENT(loc_oAba1.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoedaFornecedor")
960: 
961:         *-- Say2 "Diretorio :"
962:         loc_oAba1.AddObject("lbl_4c_Diretorio", "Label")
963:         WITH loc_oAba1.lbl_4c_Diretorio
964:             .Caption   = "Diret" + CHR(243) + "rio :"
965:             .Top       = 160
966:             .Left      = 253
967:             .Width     = 50
968:             .Height    = 15
969:             .Alignment = 0
970:             .AutoSize  = .F.
971:             .BackStyle = 0

*-- Linhas 977 a 986:
977:         *-- Get_Arquivo -> this_cArquivo (schema: arquivo char(200))
978:         loc_oAba1.AddObject("txt_4c_Arquivo", "TextBox")
979:         WITH loc_oAba1.txt_4c_Arquivo
980:             .Top           = 157
981:             .Left          = 307
982:             .Width         = 357
983:             .Height        = 21
984:             .FontName      = "Tahoma"
985:             .FontSize      = 8
986:             .MaxLength     = 200

*-- Linhas 993 a 1070:
993:         loc_oAba1.AddObject("opt_4c_Filtro", "OptionGroup")
994:         WITH loc_oAba1.opt_4c_Filtro
995:             .ButtonCount = 3
996:             .Top         = 179
997:             .Left        = 303
998:             .Width       = 192
999:             .Height      = 24
1000:             .BackStyle   = 0
1001:             .BorderStyle = 0
1002:             .Value       = 1
1003:         ENDWITH
1004:         WITH loc_oAba1.opt_4c_Filtro.Buttons(1)
1005:             .Caption   = "Somente"
1006:             .Top       = 5
1007:             .Left      = 5
1008:             .Width     = 60
1009:             .Height    = 15
1010:             .AutoSize  = .T.
1011:             .FontName  = "Tahoma"
1012:             .FontSize  = 8
1013:             .BackStyle = 0
1014:             .ForeColor = RGB(90, 90, 90)
1015:         ENDWITH
1016:         WITH loc_oAba1.opt_4c_Filtro.Buttons(2)
1017:             .Caption   = "N" + CHR(227) + "o"
1018:             .Top       = 5
1019:             .Left      = 84
1020:             .Width     = 37
1021:             .Height    = 15
1022:             .AutoSize  = .T.
1023:             .FontName  = "Tahoma"
1024:             .FontSize  = 8
1025:             .BackStyle = 0
1026:             .ForeColor = RGB(90, 90, 90)
1027:         ENDWITH
1028:         WITH loc_oAba1.opt_4c_Filtro.Buttons(3)
1029:             .Caption   = "Ambos"
1030:             .Top       = 5
1031:             .Left      = 132
1032:             .Width     = 50
1033:             .Height    = 15
1034:             .AutoSize  = .T.
1035:             .FontName  = "Tahoma"
1036:             .FontSize  = 8
1037:             .BackStyle = 0
1038:             .ForeColor = RGB(90, 90, 90)
1039:         ENDWITH
1040: 
1041:         *-- Label1 "Carregar produtos que constam nos XML's :" (legado declara
1042:         *-- AutoSize=.T. - transcrever Width/Height fixos: regra #23, AutoSize
1043:         *-- e no-op quando o Label e criado via AddObject)
1044:         loc_oAba1.AddObject("lbl_4c_CarregarXml", "Label")
1045:         WITH loc_oAba1.lbl_4c_CarregarXml
1046:             .Caption   = "Carregar produtos que constam nos XML's :"
1047:             .Top       = 184
1048:             .Left      = 55
1049:             .Width     = 246
1050:             .Height    = 15
1051:             .Alignment = 0
1052:             .AutoSize  = .F.
1053:             .BackStyle = 0
1054:             .FontName  = "Tahoma"
1055:             .FontSize  = 8
1056:             .FontBold  = .T.
1057:             .ForeColor = RGB(90, 90, 90)
1058:         ENDWITH
1059: 
1060:         *-- Say5 "Movimentacoes :" (titulo de secao acima da grdEstoque)
1061:         loc_oAba1.AddObject("lbl_4c_Movimentacoes", "Label")
1062:         WITH loc_oAba1.lbl_4c_Movimentacoes
1063:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
1064:             .Top       = 204
1065:             .Left      = 203
1066:             .Width     = 100
1067:             .Height    = 15
1068:             .Alignment = 0
1069:             .AutoSize  = .F.
1070:             .BackStyle = 0

*-- Linhas 1079 a 1088:
1079:         *-- Cpf ao final da validacao, regra "ThisForm.Montagrade(.T.)")
1080:         loc_oAba1.AddObject("grd_4c_Estoque", "Grid")
1081:         loc_oGrid = loc_oAba1.grd_4c_Estoque
1082:         loc_oGrid.Top                = 206
1083:         loc_oGrid.Left               = 307
1084:         loc_oGrid.Width              = 545
1085:         loc_oGrid.Height             = 340
1086:         loc_oGrid.ColumnCount        = 5
1087:         loc_oGrid.FontName           = "Tahoma"
1088:         loc_oGrid.FontSize           = 8

*-- Linhas 1100 a 1136:
1100:         WITH loc_oGrid
1101:             .Column1.Width               = 70
1102:             .Column1.Header1.Alignment   = 2
1103:             .Column1.Header1.Caption     = "Empresa"
1104:             .Column1.Header1.ForeColor   = RGB(90, 90, 90)
1105:             .Column1.Header1.BackColor   = RGB(192, 192, 192)
1106: 
1107:             .Column2.Width               = 200
1108:             .Column2.Header1.Alignment   = 2
1109:             .Column2.Header1.Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"
1110:             .Column2.Header1.ForeColor   = RGB(90, 90, 90)
1111:             .Column2.Header1.BackColor   = RGB(192, 192, 192)
1112: 
1113:             .Column3.Width               = 80
1114:             .Column3.Header1.Alignment   = 2
1115:             .Column3.Header1.Caption     = "Numero"
1116:             .Column3.Header1.ForeColor   = RGB(90, 90, 90)
1117:             .Column3.Header1.BackColor   = RGB(192, 192, 192)
1118: 
1119:             .Column4.Width               = 80
1120:             .Column4.Movable             = .F.
1121:             .Column4.Resizable           = .F.
1122:             .Column4.Header1.Alignment   = 2
1123:             .Column4.Header1.Caption     = "Grupo"
1124:             .Column4.Header1.ForeColor   = RGB(90, 90, 90)
1125:             .Column4.Header1.BackColor   = RGB(192, 192, 192)
1126: 
1127:             .Column5.Width               = 80
1128:             .Column5.Movable             = .F.
1129:             .Column5.Resizable           = .F.
1130:             .Column5.Header1.Alignment   = 2
1131:             .Column5.Header1.Caption     = "Conta"
1132:             .Column5.Header1.ForeColor   = RGB(90, 90, 90)
1133:             .Column5.Header1.BackColor   = RGB(192, 192, 192)
1134:         ENDWITH
1135:         BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "OrdenarEstoquePorEmpresa")
1136:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "OrdenarEstoquePorMovimentacao")

*-- Linhas 1143 a 1266:
1143:         *-- transcrito fielmente mesmo assim (regra: nao inventar, so copiar).
1144:         loc_oAba1.AddObject("shp_4c_Shape1", "Shape")
1145:         WITH loc_oAba1.shp_4c_Shape1
1146:             .Top         = 2
1147:             .Left        = 912
1148:             .Width       = 90
1149:             .Height      = 110
1150:             .BackStyle   = 0
1151:             .BorderStyle = 0
1152:             .BorderColor = RGB(136, 189, 188)
1153:         ENDWITH
1154: 
1155:         *-- processar -> cmd_4c_Processar (legado nao declara Width/Height/
1156:         *-- FontName - herdados de Pageframe1.Page1: FontName="Tahoma",
1157:         *-- FontBold=.T., FontSize=8, ForeColor=RGB(90,90,90),
1158:         *-- BackColor=RGB(255,255,255); 75x75 pelo padrao dos demais botoes
1159:         *-- com icone "_60" deste form (Confirmar/Cancelar/Movimento).
1160:         loc_oAba1.AddObject("cmd_4c_Processar", "CommandButton")
1161:         WITH loc_oAba1.cmd_4c_Processar
1162:             .Caption         = "Processar"
1163:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1164:             .PicturePosition = 13
1165:             .Top             = 7
1166:             .Left            = 962
1167:             .Width           = 75
1168:             .Height          = 75
1169:             .FontName        = "Tahoma"
1170:             .FontSize        = 8
1171:             .FontBold        = .T.
1172:             .ForeColor       = RGB(90, 90, 90)
1173:             .BackColor       = RGB(255, 255, 255)
1174:             .Themes          = .F.
1175:             .SpecialEffect   = 0
1176:             .MousePointer    = 15
1177:             .WordWrap        = .T.
1178:             .AutoSize        = .F.
1179:         ENDWITH
1180:         BINDEVENT(loc_oAba1.cmd_4c_Processar, "Click", THIS, "ProcessarArquivoXmlClick")
1181: 
1182:         *-- btnCadastros -> cmd_4c_BtnCadastros (legado: FontName/ForeColor
1183:         *-- herdados de Pageframe1.Page1 - Tahoma, ForeColor RGB(90,90,90))
1184:         loc_oAba1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
1185:         WITH loc_oAba1.cmd_4c_BtnCadastros
1186:             .Caption       = ""
1187:             .Picture       = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
1188:             .Top           = 70
1189:             .Left          = 708
1190:             .Width         = 40
1191:             .Height        = 40
1192:             .FontName      = "Tahoma"
1193:             .FontSize      = 7
1194:             .ForeColor     = RGB(90, 90, 90)
1195:             .BackColor     = RGB(255, 255, 255)
1196:             .Themes        = .F.
1197:             .SpecialEffect = 0
1198:             .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
1199:         ENDWITH
1200:         BINDEVENT(loc_oAba1.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosContaClick")
1201: 
1202:         *-- Bot_Consulta -> cmd_4c_Bot_Consulta (todas as props explicitas no dump)
1203:         loc_oAba1.AddObject("cmd_4c_Bot_Consulta", "CommandButton")
1204:         WITH loc_oAba1.cmd_4c_Bot_Consulta
1205:             .Caption       = ""
1206:             .Picture       = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
1207:             .Top           = 70
1208:             .Left          = 667
1209:             .Width         = 40
1210:             .Height        = 40
1211:             .FontName      = "Small Fonts"
1212:             .FontSize      = 4
1213:             .ForeColor     = RGB(90, 90, 90)
1214:             .BackColor     = RGB(255, 255, 255)
1215:             .Themes        = .F.
1216:             .SpecialEffect = 0
1217:             .ToolTipText   = "<F5> Faz a Consulta Gen" + CHR(233) + "rica de Vendas desta Conta..."
1218:         ENDWITH
1219:         BINDEVENT(loc_oAba1.cmd_4c_Bot_Consulta, "Click", THIS, "BtnConsultaVendasClick")
1220: 
1221:         *-- Command12 -> cmd_4c_Command12 (botao "..." - abre o seletor de
1222:         *-- arquivo XML; sem Picture no legado, so texto)
1223:         loc_oAba1.AddObject("cmd_4c_Command12", "CommandButton")
1224:         WITH loc_oAba1.cmd_4c_Command12
1225:             .Caption   = "..."
1226:             .Top       = 157
1227:             .Left      = 667
1228:             .Width     = 20
1229:             .Height    = 20
1230:             .FontName  = "Tahoma"
1231:             .FontSize  = 8
1232:             .FontBold  = .T.
1233:             .ForeColor = RGB(90, 90, 90)
1234:             .BackColor = RGB(255, 255, 255)
1235:             .Themes    = .F.
1236:         ENDWITH
1237:         BINDEVENT(loc_oAba1.cmd_4c_Command12, "Click", THIS, "SelecionarArquivoXmlClick")
1238: 
1239:         *-- cmdOperacao -> obj_4c_CmdOperacao (CommandGroup com 1 botao -
1240:         *-- "Movimento"; legado usa PROCEDURE btnOperacao.Valid, mas o unico
1241:         *-- disparo real e o clique - migrado para Click do proprio botao)
1242:         loc_oAba1.AddObject("obj_4c_CmdOperacao", "CommandGroup")
1243:         WITH loc_oAba1.obj_4c_CmdOperacao
1244:             .ButtonCount = 1
1245:             .AutoSize    = .T.
1246:             .Top         = 334
1247:             .Left        = 857
1248:             .Width       = 85
1249:             .Height      = 85
1250:             .BackStyle   = 0
1251:             .BorderStyle = 0
1252:             .Value       = 1
1253:         ENDWITH
1254:         WITH loc_oAba1.obj_4c_CmdOperacao.Buttons(1)
1255:             .Top             = 5
1256:             .Left            = 5
1257:             .Width           = 75
1258:             .Height          = 75
1259:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1260:             .PicturePosition = 13
1261:             .Caption         = "Movimento"
1262:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
1263:             .FontName        = "Comic Sans MS"
1264:             .FontSize        = 8
1265:             .FontBold        = .T.
1266:             .FontItalic      = .T.

*-- Linhas 1280 a 1292:
1280:         loc_oAba2 = loc_oPagina.pgf_4c_Detalhes.Page2
1281: 
1282:         *-- lbl_produto "Procurar Produto :"
1283:         loc_oAba2.AddObject("lbl_4c_ProcurarProduto", "Label")
1284:         WITH loc_oAba2.lbl_4c_ProcurarProduto
1285:             .Caption   = "Procurar Produto :"
1286:             .Top       = 74
1287:             .Left      = 8
1288:             .Width     = 91
1289:             .Height    = 15
1290:             .Alignment = 0
1291:             .AutoSize  = .F.
1292:             .BackStyle = 0

*-- Linhas 1299 a 1308:
1299:         *-- crMovimentos/grd_4c_Disponivel - entra em fase posterior)
1300:         loc_oAba2.AddObject("txt_4c_ProdutoInicial", "TextBox")
1301:         WITH loc_oAba2.txt_4c_ProdutoInicial
1302:             .Top           = 90
1303:             .Left          = 8
1304:             .Width         = 108
1305:             .Height        = 21
1306:             .FontName      = "Tahoma"
1307:             .FontSize      = 8
1308:             .Format        = "K!"

*-- Linhas 1316 a 1325:
1316:         *-- Sistema - barra de titulo acima da grd_4c_Disponivel (fase posterior)
1317:         loc_oAba2.AddObject("txt_4c_Sistema", "TextBox")
1318:         WITH loc_oAba2.txt_4c_Sistema
1319:             .Top       = 113
1320:             .Left      = 8
1321:             .Width     = 684
1322:             .Height    = 20
1323:             .Alignment = 2
1324:             .FontName  = "Tahoma"
1325:             .FontSize  = 8

*-- Linhas 1333 a 1342:
1333:         *-- Arquivo - barra de titulo acima da grd_4c_ItemXml (fase posterior)
1334:         loc_oAba2.AddObject("txt_4c_ArquivoHeader", "TextBox")
1335:         WITH loc_oAba2.txt_4c_ArquivoHeader
1336:             .Top       = 113
1337:             .Left      = 691
1338:             .Width     = 495
1339:             .Height    = 20
1340:             .Alignment = 2
1341:             .FontName  = "Tahoma"
1342:             .FontSize  = 8

*-- Linhas 1348 a 1360:
1348:         ENDWITH
1349: 
1350:         *-- Say3 "Movimentacao :"
1351:         loc_oAba2.AddObject("lbl_4c_MovimentacaoDetalhe", "Label")
1352:         WITH loc_oAba2.lbl_4c_MovimentacaoDetalhe
1353:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
1354:             .Top       = 483
1355:             .Left      = 40
1356:             .Width     = 78
1357:             .Height    = 15
1358:             .Alignment = 0
1359:             .AutoSize  = .F.
1360:             .BackStyle = 0

*-- Linhas 1366 a 1375:
1366:         *-- getEmps -> txt_4c_MovEmps (exibicao - "When: Return .F." no legado)
1367:         loc_oAba2.AddObject("txt_4c_MovEmps", "TextBox")
1368:         WITH loc_oAba2.txt_4c_MovEmps
1369:             .Top           = 480
1370:             .Left          = 122
1371:             .Width         = 65
1372:             .Height        = 21
1373:             .FontName      = "Tahoma"
1374:             .FontSize      = 8
1375:             .Format        = "K!"

*-- Linhas 1384 a 1393:
1384:         *-- getDopes -> txt_4c_MovDopes (exibicao)
1385:         loc_oAba2.AddObject("txt_4c_MovDopes", "TextBox")
1386:         WITH loc_oAba2.txt_4c_MovDopes
1387:             .Top           = 480
1388:             .Left          = 188
1389:             .Width         = 205
1390:             .Height        = 21
1391:             .FontName      = "Tahoma"
1392:             .FontSize      = 8
1393:             .Format        = "K!"

*-- Linhas 1402 a 1411:
1402:         *-- getNumes -> txt_4c_MovNumes (exibicao)
1403:         loc_oAba2.AddObject("txt_4c_MovNumes", "TextBox")
1404:         WITH loc_oAba2.txt_4c_MovNumes
1405:             .Top           = 480
1406:             .Left          = 393
1407:             .Width         = 65
1408:             .Height        = 21
1409:             .FontName      = "Tahoma"
1410:             .FontSize      = 8
1411:             .Format        = "K!"

*-- Linhas 1420 a 1429:
1420:         *-- getcIdChaves -> txt_4c_MovCidChaves (exibicao)
1421:         loc_oAba2.AddObject("txt_4c_MovCidChaves", "TextBox")
1422:         WITH loc_oAba2.txt_4c_MovCidChaves
1423:             .Top           = 480
1424:             .Left          = 459
1425:             .Width         = 173
1426:             .Height        = 21
1427:             .FontName      = "Tahoma"
1428:             .FontSize      = 8
1429:             .Format        = "K!"

*-- Linhas 1436 a 1448:
1436:         ENDWITH
1437: 
1438:         *-- lbl_ref_fornecedor "Ref. Fornecedor :"
1439:         loc_oAba2.AddObject("lbl_4c_RefFornecedor", "Label")
1440:         WITH loc_oAba2.lbl_4c_RefFornecedor
1441:             .Caption   = "Ref. Fornecedor :"
1442:             .Top       = 505
1443:             .Left      = 30
1444:             .Width     = 88
1445:             .Height    = 15
1446:             .Alignment = 0
1447:             .AutoSize  = .F.
1448:             .BackStyle = 0

*-- Linhas 1454 a 1463:
1454:         *-- get_ref_fornecedor -> txt_4c_RefFornecedor (exibicao)
1455:         loc_oAba2.AddObject("txt_4c_RefFornecedor", "TextBox")
1456:         WITH loc_oAba2.txt_4c_RefFornecedor
1457:             .Top           = 502
1458:             .Left          = 122
1459:             .Width         = 190
1460:             .Height        = 21
1461:             .FontName      = "Tahoma"
1462:             .FontSize      = 8
1463:             .Format        = "K!"

*-- Linhas 1472 a 1481:
1472:         *-- get_precoMov -> txt_4c_PrecoMov (exibicao)
1473:         loc_oAba2.AddObject("txt_4c_PrecoMov", "TextBox")
1474:         WITH loc_oAba2.txt_4c_PrecoMov
1475:             .Top           = 524
1476:             .Left          = 122
1477:             .Width         = 108
1478:             .Height        = 21
1479:             .FontName      = "Tahoma"
1480:             .FontSize      = 8
1481:             .InputMask     = "99,999.99999"

*-- Linhas 1489 a 1501:
1489:         ENDWITH
1490: 
1491:         *-- Say5 "Custo :"
1492:         loc_oAba2.AddObject("lbl_4c_Custo", "Label")
1493:         WITH loc_oAba2.lbl_4c_Custo
1494:             .Caption   = "Custo :"
1495:             .Top       = 527
1496:             .Left      = 81
1497:             .Width     = 37
1498:             .Height    = 15
1499:             .Alignment = 0
1500:             .AutoSize  = .F.
1501:             .BackStyle = 0

*-- Linhas 1507 a 1516:
1507:         *-- get_custofs -> txt_4c_CustoFs (exibicao)
1508:         loc_oAba2.AddObject("txt_4c_CustoFs", "TextBox")
1509:         WITH loc_oAba2.txt_4c_CustoFs
1510:             .Top           = 568
1511:             .Left          = 122
1512:             .Width         = 108
1513:             .Height        = 21
1514:             .FontName      = "Tahoma"
1515:             .FontSize      = 8
1516:             .InputMask     = "99,999.99999"

*-- Linhas 1524 a 1536:
1524:         ENDWITH
1525: 
1526:         *-- Say2 "Preco Custo :"
1527:         loc_oAba2.AddObject("lbl_4c_PrecoCusto", "Label")
1528:         WITH loc_oAba2.lbl_4c_PrecoCusto
1529:             .Caption   = "Pre" + CHR(231) + "o Custo :"
1530:             .Top       = 571
1531:             .Left      = 51
1532:             .Width     = 67
1533:             .Height    = 15
1534:             .Alignment = 0
1535:             .AutoSize  = .F.
1536:             .BackStyle = 0

*-- Linhas 1542 a 1551:
1542:         *-- get_moecusfs -> txt_4c_MoeCusFs (exibicao)
1543:         loc_oAba2.AddObject("txt_4c_MoeCusFs", "TextBox")
1544:         WITH loc_oAba2.txt_4c_MoeCusFs
1545:             .Top           = 568
1546:             .Left          = 231
1547:             .Width         = 31
1548:             .Height        = 21
1549:             .FontName      = "Tahoma"
1550:             .FontSize      = 8
1551:             .Format        = "K!"

*-- Linhas 1561 a 1570:
1561:         *-- get_pr_venda -> txt_4c_PrVenda (exibicao)
1562:         loc_oAba2.AddObject("txt_4c_PrVenda", "TextBox")
1563:         WITH loc_oAba2.txt_4c_PrVenda
1564:             .Top           = 546
1565:             .Left          = 122
1566:             .Width         = 108
1567:             .Height        = 21
1568:             .FontName      = "Tahoma"
1569:             .FontSize      = 8
1570:             .InputMask     = "99,999.99999"

*-- Linhas 1578 a 1590:
1578:         ENDWITH
1579: 
1580:         *-- lbl_pr_venda "Preco Venda :"
1581:         loc_oAba2.AddObject("lbl_4c_PrecoVenda", "Label")
1582:         WITH loc_oAba2.lbl_4c_PrecoVenda
1583:             .Caption   = "Pre" + CHR(231) + "o Venda :"
1584:             .Top       = 549
1585:             .Left      = 49
1586:             .Width     = 69
1587:             .Height    = 15
1588:             .Alignment = 0
1589:             .AutoSize  = .F.
1590:             .BackStyle = 0

*-- Linhas 1596 a 1605:
1596:         *-- get_pr_venda_moeda -> txt_4c_PrVendaMoeda (exibicao)
1597:         loc_oAba2.AddObject("txt_4c_PrVendaMoeda", "TextBox")
1598:         WITH loc_oAba2.txt_4c_PrVendaMoeda
1599:             .Top           = 546
1600:             .Left          = 231
1601:             .Width         = 31
1602:             .Height        = 21
1603:             .FontName      = "Tahoma"
1604:             .FontSize      = 8
1605:             .Format        = "K!"

*-- Linhas 1613 a 1625:
1613:         ENDWITH
1614: 
1615:         *-- Say1 "Peso :"
1616:         loc_oAba2.AddObject("lbl_4c_Peso", "Label")
1617:         WITH loc_oAba2.lbl_4c_Peso
1618:             .Caption   = "Peso :"
1619:             .Top       = 550
1620:             .Left      = 348
1621:             .Width     = 32
1622:             .Height    = 15
1623:             .Alignment = 0
1624:             .AutoSize  = .F.
1625:             .BackStyle = 0

*-- Linhas 1631 a 1640:
1631:         *-- get_peso_medio -> txt_4c_PesoMedio (exibicao)
1632:         loc_oAba2.AddObject("txt_4c_PesoMedio", "TextBox")
1633:         WITH loc_oAba2.txt_4c_PesoMedio
1634:             .Top           = 547
1635:             .Left          = 383
1636:             .Width         = 75
1637:             .Height        = 21
1638:             .FontName      = "Tahoma"
1639:             .FontSize      = 8
1640:             .InputMask     = "99,999.999"

*-- Linhas 1670 a 1693:
1670:         *-- Shape5 - moldura ao redor da foto do produto (FigJpg)
1671:         loc_oAba2.AddObject("shp_4c_Shape5", "Shape")
1672:         WITH loc_oAba2.shp_4c_Shape5
1673:             .Top         = 1
1674:             .Left        = 424
1675:             .Width       = 282
1676:             .Height      = 113
1677:             .BackStyle   = 0
1678:             .BorderStyle = 1
1679:             .BorderWidth = 2
1680:             .SpecialEffect = 0
1681:         ENDWITH
1682: 
1683:         *-- grdDisponivel -> grd_4c_Disponivel (movimentos disponiveis para
1684:         *-- distribuicao - crMovimentos, populado em ExecutarProcessamentoXml)
1685:         loc_oAba2.AddObject("grd_4c_Disponivel", "Grid")
1686:         loc_oGrid = loc_oAba2.grd_4c_Disponivel
1687:         loc_oGrid.Top                = 134
1688:         loc_oGrid.Left               = 8
1689:         loc_oGrid.Width              = 684
1690:         loc_oGrid.Height             = 344
1691:         loc_oGrid.ColumnCount        = 7
1692:         loc_oGrid.FontName           = "Tahoma"
1693:         loc_oGrid.FontSize           = 8

*-- Linhas 1708 a 1793:
1708:             .Column1.MousePointer      = 99
1709:             .Column1.MouseIcon         = gc_4c_CaminhoIcones + "H_POINT.CUR"
1710:             .Column1.Header1.Alignment = 2
1711:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
1712:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1713: 
1714:             .Column2.Width             = 235
1715:             .Column2.Movable           = .F.
1716:             .Column2.Resizable         = .F.
1717:             .Column2.ReadOnly          = .T.
1718:             .Column2.BackColor         = RGB(237, 242, 243)
1719:             .Column2.Header1.Alignment = 2
1720:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1721:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1722: 
1723:             .Column3.Width             = 70
1724:             .Column3.Movable           = .F.
1725:             .Column3.Resizable         = .F.
1726:             .Column3.ReadOnly          = .T.
1727:             .Column3.ForeColor         = RGB(0, 0, 0)
1728:             .Column3.BackColor         = RGB(237, 242, 243)
1729:             .Column3.Header1.Alignment = 2
1730:             .Column3.Header1.Caption   = "Valor"
1731:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
1732: 
1733:             .Column4.FontBold          = .T.
1734:             .Column4.Width             = 63
1735:             .Column4.Movable           = .F.
1736:             .Column4.Resizable         = .F.
1737:             .Column4.ReadOnly          = .T.
1738:             .Column4.Format            = "9"
1739:             .Column4.ForeColor         = RGB(0, 0, 0)
1740:             .Column4.BackColor         = RGB(237, 242, 243)
1741:             .Column4.Header1.Alignment = 2
1742:             .Column4.Header1.Caption   = "Quantidade"
1743:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1744: 
1745:             .Column5.FontBold          = .T.
1746:             .Column5.Width             = 63
1747:             .Column5.Movable           = .F.
1748:             .Column5.Resizable         = .F.
1749:             .Column5.ReadOnly          = .T.
1750:             .Column5.Format            = "9"
1751:             .Column5.ForeColor         = RGB(0, 0, 0)
1752:             .Column5.BackColor         = RGB(237, 242, 243)
1753:             .Column5.Header1.Alignment = 2
1754:             .Column5.Header1.Caption   = "Baixado"
1755:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
1756: 
1757:             .Column6.FontBold          = .T.
1758:             .Column6.Width             = 63
1759:             .Column6.Movable           = .F.
1760:             .Column6.Resizable         = .F.
1761:             .Column6.ReadOnly          = .T.
1762:             .Column6.Format            = "9"
1763:             .Column6.ForeColor         = RGB(0, 0, 0)
1764:             .Column6.BackColor         = RGB(237, 242, 243)
1765:             .Column6.Header1.Alignment = 2
1766:             .Column6.Header1.Caption   = "Reservado"
1767:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
1768: 
1769:             .Column7.FontBold          = .T.
1770:             .Column7.Width             = 63
1771:             .Column7.Movable           = .F.
1772:             .Column7.Resizable         = .F.
1773:             .Column7.ReadOnly          = .T.
1774:             .Column7.BackColor         = RGB(237, 242, 243)
1775:             .Column7.Header1.Alignment = 2
1776:             .Column7.Header1.Caption   = "Saldo"
1777:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1778:         ENDWITH
1779:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "AtualizarDetalhesProdutoSelecionado")
1780:         BINDEVENT(loc_oGrid.Column1.Text1, "DblClick", THIS, "AbrirPesquisaGlobalProduto")
1781: 
1782:         *-- grdItemXml -> grd_4c_ItemXml (produtos distribuidos - crDistribui,
1783:         *-- populado em ExecutarProcessamentoXml). Column3 (Quantidade) e a
1784:         *-- UNICA editavel - o legado nao marca ReadOnly/Enabled nela.
1785:         loc_oAba2.AddObject("grd_4c_ItemXml", "Grid")
1786:         loc_oGrid = loc_oAba2.grd_4c_ItemXml
1787:         loc_oGrid.Top           = 134
1788:         loc_oGrid.Left          = 693
1789:         loc_oGrid.Width         = 493
1790:         loc_oGrid.Height        = 344
1791:         loc_oGrid.ColumnCount   = 4
1792:         loc_oGrid.FontName      = "Tahoma"
1793:         loc_oGrid.FontSize      = 8

*-- Linhas 1804 a 1896:
1804:             .Column1.ForeColor         = RGB(0, 0, 0)
1805:             .Column1.BackColor         = RGB(237, 242, 243)
1806:             .Column1.Header1.Alignment = 2
1807:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
1808:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1809: 
1810:             .Column2.Enabled           = .F.
1811:             .Column2.Width             = 235
1812:             .Column2.Movable           = .F.
1813:             .Column2.Resizable         = .F.
1814:             .Column2.ReadOnly          = .T.
1815:             .Column2.ForeColor         = RGB(0, 0, 0)
1816:             .Column2.BackColor         = RGB(237, 242, 243)
1817:             .Column2.Header1.Alignment = 2
1818:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1819:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1820: 
1821:             .Column3.Width             = 63
1822:             .Column3.Movable           = .F.
1823:             .Column3.Resizable         = .F.
1824:             .Column3.InputMask         = "999999"
1825:             .Column3.ForeColor         = RGB(0, 0, 0)
1826:             .Column3.BackColor         = RGB(237, 242, 243)
1827:             .Column3.Header1.Alignment = 2
1828:             .Column3.Header1.Caption   = "Quantidade"
1829:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
1830: 
1831:             .Column4.Enabled           = .F.
1832:             .Column4.Width             = 70
1833:             .Column4.Movable           = .F.
1834:             .Column4.Resizable         = .F.
1835:             .Column4.ReadOnly          = .T.
1836:             .Column4.BackColor         = RGB(237, 242, 243)
1837:             .Column4.Header1.Alignment = 2
1838:             .Column4.Header1.Caption   = "Valor"
1839:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1840:         ENDWITH
1841: 
1842:         *-- FigJpg -> img_4c_FigJpg (foto do produto - atualizada em
1843:         *-- AtualizarDetalhesProdutoSelecionado)
1844:         loc_oAba2.AddObject("img_4c_FigJpg", "Image")
1845:         WITH loc_oAba2.img_4c_FigJpg
1846:             .Top      = 3
1847:             .Left      = 426
1848:             .Width     = 278
1849:             .Height    = 109
1850:             .Stretch   = 1
1851:             .Visible   = .F.
1852:         ENDWITH
1853:         BINDEVENT(loc_oAba2.img_4c_FigJpg, "DblClick", THIS, "FigJpgDblClick")
1854: 
1855:         *-- btnExcluirSis -> cmd_4c_BtnExcluirSis (exclui linha de crMovimentos)
1856:         loc_oAba2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
1857:         WITH loc_oAba2.cmd_4c_BtnExcluirSis
1858:             .Caption     = ""
1859:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1860:             .Top         = 479
1861:             .Left        = 663
1862:             .Width       = 40
1863:             .Height      = 37
1864:             .FontName    = "Arial"
1865:             .FontSize    = 7
1866:             .ForeColor   = RGB(255, 0, 0)
1867:             .BackColor   = RGB(255, 255, 255)
1868:             .Themes      = .F.
1869:             .TabStop     = .F.
1870:             .ToolTipText = "Excluir Linha da Grade Sistema"
1871:         ENDWITH
1872:         BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")
1873: 
1874:         *-- btnExcluirArq -> cmd_4c_BtnExcluirArq (exclui linha de crDistribui)
1875:         loc_oAba2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
1876:         WITH loc_oAba2.cmd_4c_BtnExcluirArq
1877:             .Caption     = ""
1878:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1879:             .Top         = 479
1880:             .Left        = 1146
1881:             .Width       = 40
1882:             .Height      = 37
1883:             .FontName    = "Arial"
1884:             .FontSize    = 7
1885:             .ForeColor   = RGB(255, 0, 0)
1886:             .BackColor   = RGB(255, 255, 255)
1887:             .Themes      = .F.
1888:             .TabStop     = .F.
1889:             .ToolTipText = "Excluir Linha da Grade Arquivo"
1890:         ENDWITH
1891:         BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")
1892:     ENDPROC
1893: 
1894:     *===========================================================================
1895:     * MontaGrade - Popula grd_4c_Estoque com os movimentos distribuiveis
1896:     * (legado: PROCEDURE montagrade). Chamada ao final das validacoes de

*-- Linhas 1930 a 1942:
1930:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Estoque.Grupos"
1931:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Estoque.Contas"
1932: 
1933:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1934:                 loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1935:                 loc_oGrid.Column3.Header1.Caption = "Numero"
1936:                 loc_oGrid.Column4.Header1.Caption = "Grupo"
1937:                 loc_oGrid.Column5.Header1.Caption = "Conta"
1938: 
1939:                 loc_oGrid.Column1.Width = 70
1940:                 loc_oGrid.Column2.Width = 200
1941:                 loc_oGrid.Column3.Width = 80
1942:                 loc_oGrid.Column4.Width = 80

*-- Linhas 2001 a 2009:
2001:     ENDPROC
2002: 
2003:     *===========================================================================
2004:     * SelecionarArquivoXmlClick - Click de cmd_4c_Command12 (legado: Command12.
2005:     * Click) - abre o seletor de arquivo nativo do Windows e grava o caminho
2006:     * escolhido em txt_4c_Arquivo.
2007:     *===========================================================================
2008:     PROCEDURE SelecionarArquivoXmlClick()
2009:         LOCAL loc_oPagina, loc_cArquivo

*-- Linhas 2020 a 2028:
2020:     ENDPROC
2021: 
2022:     *===========================================================================
2023:     * BtnCadastrosContaClick - Click de cmd_4c_BtnCadastros (legado:
2024:     * btnCadastros.Click) - abre o Cadastro de Contas (SIGCDCTA -> FormCTA) da
2025:     * conta digitada. Show() FORA do TRY (CLAUDE.md #29 - FormCTA e modal).
2026:     *===========================================================================
2027:     PROCEDURE BtnCadastrosContaClick()
2028:         LOCAL loc_oPagina, loc_oForm, loc_oErro

*-- Linhas 2050 a 2058:
2050:     ENDPROC
2051: 
2052:     *===========================================================================
2053:     * BtnConsultaVendasClick - Click de cmd_4c_Bot_Consulta (legado:
2054:     * Bot_Consulta.Click) - abriria a Consulta Generica de Vendas (SigOpCgv)
2055:     * da conta digitada. SigOpCgv NAO foi migrada (nao existe FormSigOpCgv no
2056:     * acervo) - degrada graciosamente com aviso, mesmo padrao ja usado em
2057:     * FormSigMvSbn para SigOpZom/SigRePhi. Show() FORA do TRY (CLAUDE.md #29).
2058:     *===========================================================================

*-- Linhas 2440 a 2460:
2440: 
2441:         RETURN .T.
2442:     ENDPROC
2443: 
2444:     *===========================================================================
2445:     * ProcessarArquivoXmlClick - Click de cmd_4c_Processar (legado: processar.
2446:     * Click) - valida Arquivo/Conta/Cpf preenchidos e delega o processamento.
2447:     *===========================================================================
2448:     PROCEDURE ProcessarArquivoXmlClick()
2449:         LOCAL loc_oPagina
2450:         TRY
2451:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2452: 
2453:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Arquivo.Value))
2454:                 MsgAviso("Nenhum Diret" + CHR(243) + "rio Foi Informado.", "Aviso")
2455:             ELSE
2456:                 IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2457:                     MsgAviso("Nenhum Fornecedor Foi Informado.", "Aviso")
2458:                 ELSE
2459:                     IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cpf.Value))
2460:                         MsgAviso("CNPJ/CPF do Fornecedor N" + CHR(227) + "o Informado", "Aviso")

*-- Linhas 2566 a 2577:
2566: 
2567:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2568:                 *-- reaplicar OS DOIS depois do ControlSource
2569:                 loc_oGridItem.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2570:                 loc_oGridItem.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2571:                 loc_oGridItem.Column3.Header1.Caption = "Quantidade"
2572:                 loc_oGridItem.Column4.Header1.Caption = "Valor"
2573:                 loc_oGridItem.Column1.Width = 100
2574:                 loc_oGridItem.Column2.Width = 235
2575:                 loc_oGridItem.Column3.Width = 63
2576:                 loc_oGridItem.Column4.Width = 70
2577: 

*-- Linhas 2602 a 2616:
2602: 
2603:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2604:                 *-- reaplicar OS DOIS depois do ControlSource
2605:                 loc_oGridDisp.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2606:                 loc_oGridDisp.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2607:                 loc_oGridDisp.Column3.Header1.Caption = "Valor"
2608:                 loc_oGridDisp.Column4.Header1.Caption = "Quantidade"
2609:                 loc_oGridDisp.Column5.Header1.Caption = "Baixado"
2610:                 loc_oGridDisp.Column6.Header1.Caption = "Reservado"
2611:                 loc_oGridDisp.Column7.Header1.Caption = "Saldo"
2612:                 loc_oGridDisp.Column1.Width = 100
2613:                 loc_oGridDisp.Column2.Width = 235
2614:                 loc_oGridDisp.Column3.Width = 70
2615:                 loc_oGridDisp.Column4.Width = 63
2616:                 loc_oGridDisp.Column5.Width = 63

*-- Linhas 2622 a 2630:
2622: 
2623:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.Enabled = .F.
2624:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2.Enabled = .T.
2625:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
2626:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.ActivePage = 2
2627:             ENDIF
2628:         CATCH TO loException
2629:             MostrarErro(loException, "FormSigPrCtr.ExecutarProcessamentoXml")
2630:         ENDTRY

*-- Linhas 3080 a 3088:
3080:     ENDPROC
3081: 
3082:     *===========================================================================
3083:     * BtnExcluirSisClick - Click de cmd_4c_BtnExcluirSis (legado:
3084:     * btnExcluirSis.Click) - exclui a linha atual de crMovimentos
3085:     * (grd_4c_Disponivel).
3086:     *===========================================================================
3087:     PROCEDURE BtnExcluirSisClick()
3088:         LOCAL loc_oAba2

*-- Linhas 3108 a 3116:
3108:     ENDPROC
3109: 
3110:     *===========================================================================
3111:     * BtnExcluirArqClick - Click de cmd_4c_BtnExcluirArq (legado:
3112:     * btnExcluirArq.Click) - exclui a linha atual de crDistribui
3113:     * (grd_4c_ItemXml).
3114:     *===========================================================================
3115:     PROCEDURE BtnExcluirArqClick()
3116:         LOCAL loc_oAba2

*-- Linhas 3244 a 3260:
3244:             loc_oCntBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
3245:             loc_lEmEdicao  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
3246: 
3247:             loc_oCntBotoes.cmd_4c_Incluir.Enabled    = !loc_lEmEdicao
3248:             loc_oCntBotoes.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
3249:             loc_oCntBotoes.cmd_4c_Alterar.Enabled    = !loc_lEmEdicao
3250:             loc_oCntBotoes.cmd_4c_Excluir.Enabled    = !loc_lEmEdicao
3251:             loc_oCntBotoes.cmd_4c_Buscar.Enabled     = !loc_lEmEdicao
3252: 
3253:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
3254:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3255:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = loc_lEmEdicao
3256:         CATCH TO loException
3257:             MostrarErro(loException, "FormSigPrCtr.AjustarBotoesPorModo")
3258:         ENDTRY
3259:     ENDPROC
3260: 


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*====================================================================
* SigPrCtrBO.prg
*
* Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCtr)
    this_cPkChave     = ""    && pkchave    char(20)  - PK
    this_cCodCors     = ""    && codcors    char(4)
    this_cCodigos     = ""    && codigos    char(10)
    this_cCodTams     = ""    && codtams    char(4)
    this_cCpros       = ""    && cpros      char(14)
    this_dDatas       = {}    && datas      datetime  NULL
    this_dDtAlts      = {}    && dtalts     datetime  NULL
    this_nQtdos       = 0     && qtdos      numeric(10,2)
    this_nQtds        = 0     && qtds       numeric(10,2)
    this_cUsuAlts     = ""    && usualts    char(10)
    this_cUsuars      = ""    && usuars     char(10)
    this_cOriDopNums  = ""    && oridopnums char(29)
    this_cContas      = ""    && contas     char(10)
    this_nPrecific    = 0     && precific   numeric(1,0)
    this_cMoedas      = ""    && moedas     char(3)
    this_cArquivo     = ""    && arquivo    char(200)
    this_cFkChaves    = ""    && fkchaves   char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCtr"
            THIS.this_cCampoChave = "pkchave"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCtrBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria do registro atual (RegistrarAuditoria)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChave)
    ENDFUNC

    *====================================================================
    * CarregarCambio - fCarregarCambio (SIGFUNCS.PRG) do legado NAO foi
    * portada para utils/functions.prg (memoria: fCarregarCambio_nao_portada).
    * Usa os cursores crSigCdCot/crSigCdMoe (carregados pelo Form no Init,
    * mesma sessao - FormSigPrCtr nao declara DataSession proprio). PUBLIC
    * (nao PROTECTED) - chamada pelo Form em ExecutarProcessamentoXml.
    *====================================================================
    FUNCTION CarregarCambio(par_cMoeda, par_xData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(par_cMoeda)

        DO CASE
            CASE VARTYPE(par_xData) == "T"
                loc_dData = ConverterParaData(par_xData)
            CASE VARTYPE(par_xData) == "D"
                loc_dData = par_xData
            OTHERWISE
                loc_dData = DATE()
        ENDCASE

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        TRY
            IF USED("crSigCdMoe")
                SELECT crSigCdMoe
                SET ORDER TO CMoes
                IF SEEK(loc_cMoeda) AND crSigCdMoe.Cotas <> 0
                    IF USED("crSigCdCot")
                        SELECT crSigCdCot
                        SET ORDER TO CMoeData DESCENDING
                        SET NEAR ON
                        SEEK loc_cMoeda + DTOS(loc_dData)
                        SET NEAR OFF
                        IF !EOF() AND ALLTRIM(crSigCdCot.CMoes) = loc_cMoeda
                            loc_nCotacao = crSigCdCot.Valos
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
        ENDTRY

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *====================================================================
    * ValidarDados - Validacao chamada pelo BusinessBase.Salvar() antes de
    * Inserir/Atualizar (legado: "Favor Informar uma Conta." - guard no
    * inicio do Lerxml/processar do Pageframe1.Page1 - comportamento.json).
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cContas))
            THIS.this_cMensagemErro = "Favor Informar uma Conta."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de uma linha do
    * cursor (estrutura de dbo.SigPrCtr - docs/schema.sql).
    * REGRA: OriDopNums eh chave POSICIONAL (Emps char(3)+Dopes char(20)+
    * Str(Numes,6) = 29) - NUNCA aplicar ALLTRIM nela, o padding faz parte
    * da chave usada para casar com SigMvCab.EmpDopNums.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cPkChave    = ALLTRIM(TratarNulo(pkchave, ""))
            THIS.this_cCodCors    = ALLTRIM(TratarNulo(codcors, ""))
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos, ""))
            THIS.this_cCodTams    = ALLTRIM(TratarNulo(codtams, ""))
            THIS.this_cCpros      = ALLTRIM(TratarNulo(cpros, ""))
            THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
            THIS.this_dDtAlts     = ConverterParaData(TratarNulo(dtalts, {}))
            THIS.this_nQtdos      = TratarNulo(qtdos, 0)
            THIS.this_nQtds       = TratarNulo(qtds, 0)
            THIS.this_cUsuAlts    = ALLTRIM(TratarNulo(usualts, ""))
            THIS.this_cUsuars     = ALLTRIM(TratarNulo(usuars, ""))
            THIS.this_cOriDopNums = TratarNulo(oridopnums, "")
            THIS.this_cContas     = ALLTRIM(TratarNulo(contas, ""))
            THIS.this_nPrecific   = TratarNulo(precific, 0)
            THIS.this_cMoedas     = ALLTRIM(TratarNulo(moedas, ""))
            THIS.this_cArquivo    = ALLTRIM(TratarNulo(arquivo, ""))
            THIS.this_cFkChaves   = ALLTRIM(TratarNulo(fkchaves, ""))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrCtr
    * Espelha o "Insert Into crSigPrCtr (...)" + "Replace PkChave With
    * fUniqueIds()" do Grupo_Salva.Salva.Click legado (modo INSERIR):
    * a chave primaria (pkchave) e o codigo de agrupamento (codigos) sao
    * gerados aqui quando ainda nao foram atribuidos pelo chamador.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigos = fGerMascara(fGerUniqueKey("SigPrCtr"))
            ENDIF

            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            THIS.this_cUsuars = IIF(!EMPTY(ALLTRIM(THIS.this_cUsuars)), THIS.this_cUsuars, ;
                IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""))

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCtr (pkchave, codcors, codigos, codtams, cpros,
                    datas, dtalts, qtdos, qtds, usualts, usuars, oridopnums,
                    contas, precific, moedas, arquivo, fkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChave)>>,
                    <<EscaparSQL(THIS.this_cCodCors)>>,
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    <<EscaparSQL(THIS.this_cMoedas)>>,
                    <<EscaparSQL(THIS.this_cArquivo)>>,
                    <<EscaparSQL(THIS.this_cFkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrCtr (WHERE pkchave)
    * Espelha "Replace DtAlts With Datetime() / UsuAlts With m.usuar" do
    * Grupo_Salva.Salva.Click legado (modo ALTERAR).
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDtAlts  = DATETIME()
            THIS.this_cUsuAlts = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, THIS.this_cUsuAlts)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCtr
                SET codcors    = <<EscaparSQL(THIS.this_cCodCors)>>,
                    codigos    = <<EscaparSQL(THIS.this_cCodigos)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTams)>>,
                    cpros      = <<EscaparSQL(THIS.this_cCpros)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    dtalts     = <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    qtdos      = <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    usualts    = <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    oridopnums = <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    precific   = <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoedas)>>,
                    arquivo    = <<EscaparSQL(THIS.this_cArquivo)>>,
                    fkchaves   = <<EscaparSQL(THIS.this_cFkChaves)>>
                WHERE pkchave = <<EscaparSQL(THIS.this_cPkChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega a linha mais representativa do agrupamento
    * "Codigos" (legado: crSigPrCtr requerido pela Grade da Lista, que
    * agrupa por Codigos - regra #42/comportamento.json). Usada por
    * Alterar/Visualizar/Excluir para trazer Conta/Moeda/Arquivo/Precific
    * do "cabecalho" do lote antes de reconstruir as linhas em Confirmar.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrCtr WHERE codigos = " + ;
                EscaparSQL(par_cCodigo) + " ORDER BY pkchave"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaCtr")

            IF loc_nResultado >= 0 AND USED("cursor_4c_CarregaCtr") AND RECCOUNT("cursor_4c_CarregaCtr") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_CarregaCtr")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui TODAS as linhas do lote "Codigos" (transcrito
    * literalmente do legado: "Delete From SigPrCtr Where Codigos = ?_Codigo",
    * msv_Alterar - comportamento.json). A Lista agrupa por Codigos (regra
    * #42), entao excluir eh excluir o lote inteiro, nao so a linha this_cPkChave.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

