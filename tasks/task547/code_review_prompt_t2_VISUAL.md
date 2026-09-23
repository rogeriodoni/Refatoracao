# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Valor, Peso Mínimo, Peso Máximo, Município. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Razão Social' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Valor, Peso Mínimo, Peso Máximo, Município. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Telefone' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Valor, Peso Mínimo, Peso Máximo, Município. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGCDTRA.Pagina.Dados): Top original=545 vs migrado 'cmd_4c_ExcluirEstado' Top=633 (diff=88px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formtra.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2410 linhas total):

*-- Linhas 81 a 100:
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount = 2
84:             .Top       = -29
85:             .Left      = 0
86:             .Width     = THIS.Width
87:             .Height    = THIS.Height + 29
88:             .Tabs      = .F.
89:             .Visible   = .T.
90: 
91:             .Page1.Caption   = "Lista"
92:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page1.BackColor = RGB(255, 255, 255)
94: 
95:             .Page2.Caption   = "Dados"
96:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page2.BackColor = RGB(255, 255, 255)
98:         ENDWITH
99: 
100:         THIS.ConfigurarPaginaLista()

*-- Linhas 115 a 152:
115:         *-- Cabecalho (faixa cinza) - PRIMEIRO AddObject da pagina (CLAUDE.md regra #11)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 29
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 46
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.

*-- Linhas 159 a 183:
159:         *-- Container de botoes CRUD (Grupo_op no legado)
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        = 542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackStyle   = 0
167:             .BorderWidth = 0
168:             .Visible     = .T.
169:         ENDWITH
170: 
171:         *-- Botao Incluir (Left=5)
172:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
173:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
174:             .Caption         = "Incluir"
175:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
176:             .PicturePosition = 13
177:             .Top             = 5
178:             .Left            = 5
179:             .Width           = 75
180:             .Height          = 75
181:             .FontName        = "Tahoma"
182:             .FontBold        = .T.
183:             .FontItalic      = .T.

*-- Linhas 191 a 208:
191:             .AutoSize        = .F.
192:             .Visible         = .T.
193:         ENDWITH
194:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
195: 
196:         *-- Botao Visualizar (Left=80)
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .FontName        = "Tahoma"
207:             .FontBold        = .T.
208:             .FontItalic      = .T.

*-- Linhas 216 a 233:
216:             .AutoSize        = .F.
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         *-- Botao Alterar (Left=155)
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .FontName        = "Tahoma"
232:             .FontBold        = .T.
233:             .FontItalic      = .T.

*-- Linhas 241 a 258:
241:             .AutoSize        = .F.
242:             .Visible         = .T.
243:         ENDWITH
244:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
245: 
246:         *-- Botao Excluir (Left=230)
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .FontName        = "Tahoma"
257:             .FontBold        = .T.
258:             .FontItalic      = .T.

*-- Linhas 266 a 283:
266:             .AutoSize        = .F.
267:             .Visible         = .T.
268:         ENDWITH
269:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
270: 
271:         *-- Botao Buscar (Left=305)
272:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
273:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
274:             .Caption         = "Buscar"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
276:             .PicturePosition = 13
277:             .Top             = 5
278:             .Left            = 305
279:             .Width           = 75
280:             .Height          = 75
281:             .FontName        = "Tahoma"
282:             .FontBold        = .T.
283:             .FontItalic      = .T.

*-- Linhas 291 a 320:
291:             .AutoSize        = .F.
292:             .Visible         = .T.
293:         ENDWITH
294:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
297:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
298:         WITH loc_oPagina.cnt_4c_Saida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .FontName        = "Tahoma"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.

*-- Linhas 328 a 347:
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de listagem de transportadoras
334:         *-- Colunas: itras (Codigo), razaos (Razao Social), tel1s (Telefone) - fiel ao
335:         *-- legado (SIGCDTRA.Init: AddCursor+pColuna em Pagina.Lista.Grade)
336:         *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
339:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
340:         WITH loc_oPagina.grd_4c_Lista
341:             .Top                = 117
342:             .Left               = 26
343:             .Width              = 880
344:             .Height             = 498
345:             .FontName           = "Verdana"
346:             .FontSize           = 8
347:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 392 a 402:
392:                 loc_oGrid.Column3.Width = 200
393: 
394:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
395:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
396:                 loc_oGrid.Column2.Header1.Caption = "Raz" + CHR(227) + "o Social"
397:                 loc_oGrid.Column3.Header1.Caption = "Telefone"
398: 
399:                 THIS.FormatarGridLista(loc_oGrid)
400:                 loc_lResultado = .T.
401:             ENDIF
402: 

*-- Linhas 465 a 502:
465:         *-- Cabecalho (faixa cinza) tambem na pagina Dados - CLAUDE.md regra #11
466:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
467:         WITH loc_oPagina.cnt_4c_Cabecalho
468:             .Top         = 29
469:             .Left        = 0
470:             .Width       = THIS.Width
471:             .Height      = 80
472:             .BackColor   = RGB(100, 100, 100)
473:             .BorderWidth = 0
474:             .Visible     = .T.
475:         ENDWITH
476: 
477:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
478:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
479:             .Caption   = THIS.Caption
480:             .Top       = 15
481:             .Left      = 10
482:             .Width     = 769
483:             .Height    = 40
484:             .FontName  = "Tahoma"
485:             .FontSize  = 16
486:             .FontBold  = .T.
487:             .ForeColor = RGB(0, 0, 0)
488:             .BackStyle = 0
489:             .AutoSize  = .F.
490:             .Visible   = .T.
491:         ENDWITH
492: 
493:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
494:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
495:             .Caption   = THIS.Caption
496:             .Top       = 18
497:             .Left      = 10
498:             .Width     = 769
499:             .Height    = 46
500:             .FontName  = "Tahoma"
501:             .FontSize  = 16
502:             .FontBold  = .T.

*-- Linhas 509 a 518:
509:         *-- Container de botoes de acao (Grupo_Salva no legado) - populado na Fase 6
510:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
511:         WITH loc_oPagina.cnt_4c_BotoesAcao
512:             .Top         = 33
513:             .Left        = 842
514:             .Width       = 160
515:             .Height      = 85
516:             .BackStyle = 1
517:             .BackColor = RGB(255, 255, 255)
518:             .BorderWidth = 0

*-- Linhas 527 a 539:
527:         *======================================================================
528: 
529:         *-- Codigo (itras)
530:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
531:         WITH loc_oPagina.lbl_4c_Label1
532:             .Caption   = "C" + CHR(243) + "digo :"
533:             .Top       = 118
534:             .Left      = 76
535:             .Width     = 42
536:             .Height    = 15
537:             .AutoSize  = .F.
538:             .Alignment = 0
539:             .FontName  = "Tahoma"

*-- Linhas 546 a 555:
546:         loc_oPagina.AddObject("txt_4c_Itra", "TextBox")
547:         WITH loc_oPagina.txt_4c_Itra
548:             .Value         = ""
549:             .Top           = 115
550:             .Left          = 123
551:             .Width         = 80
552:             .Height        = 25
553:             .MaxLength     = 10
554:             .Format        = "!"
555:             .InputMask     = "A999999999"

*-- Linhas 563 a 575:
563:         ENDWITH
564: 
565:         *-- ID E-Commerce (idtransp)
566:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
567:         WITH loc_oPagina.lbl_4c_Label25
568:             .Caption   = "ID E-Commerce :"
569:             .Top       = 119
570:             .Left      = 246
571:             .Width     = 83
572:             .Height    = 15
573:             .AutoSize  = .F.
574:             .Alignment = 0
575:             .FontName  = "Tahoma"

*-- Linhas 582 a 591:
582:         loc_oPagina.AddObject("txt_4c_Idtransp", "TextBox")
583:         WITH loc_oPagina.txt_4c_Idtransp
584:             .Value         = ""
585:             .Top           = 115
586:             .Left          = 333
587:             .Width         = 80
588:             .Height        = 25
589:             .MaxLength     = 15
590:             .Format        = "!"
591:             .Alignment     = 3

*-- Linhas 598 a 610:
598:         ENDWITH
599: 
600:         *-- Razao Social
601:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
602:         WITH loc_oPagina.lbl_4c_Label2
603:             .Caption   = "Razao Social :"
604:             .Top       = 148
605:             .Left      = 49
606:             .Width     = 69
607:             .Height    = 15
608:             .AutoSize  = .F.
609:             .Alignment = 0
610:             .FontName  = "Tahoma"

*-- Linhas 617 a 626:
617:         loc_oPagina.AddObject("txt_4c_Razao", "TextBox")
618:         WITH loc_oPagina.txt_4c_Razao
619:             .Value         = ""
620:             .Top           = 143
621:             .Left          = 123
622:             .Width         = 290
623:             .Height        = 25
624:             .MaxLength     = 40
625:             .Format        = "!"
626:             .Alignment     = 3

*-- Linhas 633 a 645:
633:         ENDWITH
634: 
635:         *-- Endereco
636:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
637:         WITH loc_oPagina.lbl_4c_Label3
638:             .Caption   = "Endere" + CHR(231) + "o :"
639:             .Top       = 176
640:             .Left      = 64
641:             .Width     = 54
642:             .Height    = 15
643:             .AutoSize  = .F.
644:             .Alignment = 0
645:             .FontName  = "Tahoma"

*-- Linhas 652 a 678:
652:         loc_oPagina.AddObject("txt_4c_Endereco", "TextBox")
653:         WITH loc_oPagina.txt_4c_Endereco
654:             .Value         = ""
655:             .Top           = 171
656:             .Left          = 123
657:             .Width         = 290
658:             .Height        = 25
659:             .MaxLength     = 40
660:             .FontName      = "Tahoma"
661:             .FontSize      = 8
662:             .ForeColor     = RGB(0, 0, 0)
663:             .BackColor     = RGB(255, 255, 255)
664:             .SpecialEffect = 1
665:             .Visible       = .T.
666:         ENDWITH
667: 
668:         *-- Bairro
669:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
670:         WITH loc_oPagina.lbl_4c_Label4
671:             .Caption   = "Bairro :"
672:             .Top       = 204
673:             .Left      = 81
674:             .Width     = 37
675:             .Height    = 15
676:             .AutoSize  = .F.
677:             .Alignment = 0
678:             .FontName  = "Tahoma"

*-- Linhas 685 a 711:
685:         loc_oPagina.AddObject("txt_4c_Bairro", "TextBox")
686:         WITH loc_oPagina.txt_4c_Bairro
687:             .Value         = ""
688:             .Top           = 199
689:             .Left          = 123
690:             .Width         = 150
691:             .Height        = 25
692:             .MaxLength     = 20
693:             .FontName      = "Tahoma"
694:             .FontSize      = 8
695:             .ForeColor     = RGB(0, 0, 0)
696:             .BackColor     = RGB(255, 255, 255)
697:             .SpecialEffect = 1
698:             .Visible       = .T.
699:         ENDWITH
700: 
701:         *-- CEP
702:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
703:         WITH loc_oPagina.lbl_4c_Label9
704:             .Caption   = "CEP :"
705:             .Top       = 232
706:             .Left      = 90
707:             .Width     = 28
708:             .Height    = 15
709:             .AutoSize  = .F.
710:             .Alignment = 0
711:             .FontName  = "Tahoma"

*-- Linhas 718 a 727:
718:         loc_oPagina.AddObject("txt_4c_Cep", "TextBox")
719:         WITH loc_oPagina.txt_4c_Cep
720:             .Value         = ""
721:             .Top           = 227
722:             .Left          = 123
723:             .Width         = 73
724:             .Height        = 25
725:             .MaxLength     = 9
726:             .Format        = "R"
727:             .InputMask     = "99999-999"

*-- Linhas 734 a 746:
734:         ENDWITH
735: 
736:         *-- Cidade
737:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
738:         WITH loc_oPagina.lbl_4c_Label5
739:             .Caption   = "Cidade :"
740:             .Top       = 259
741:             .Left      = 76
742:             .Width     = 42
743:             .Height    = 15
744:             .AutoSize  = .F.
745:             .Alignment = 0
746:             .FontName  = "Tahoma"

*-- Linhas 753 a 778:
753:         loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
754:         WITH loc_oPagina.txt_4c_Cidade
755:             .Value         = ""
756:             .Top           = 254
757:             .Left          = 123
758:             .Width         = 220
759:             .Height        = 25
760:             .FontName      = "Tahoma"
761:             .FontSize      = 8
762:             .ForeColor     = RGB(0, 0, 0)
763:             .BackColor     = RGB(255, 255, 255)
764:             .SpecialEffect = 1
765:             .Visible       = .T.
766:         ENDWITH
767: 
768:         *-- U.F.
769:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
770:         WITH loc_oPagina.lbl_4c_Label10
771:             .Caption   = "U.F. :"
772:             .Top       = 286
773:             .Left      = 299
774:             .Width     = 30
775:             .Height    = 15
776:             .AutoSize  = .F.
777:             .Alignment = 0
778:             .FontName  = "Tahoma"

*-- Linhas 785 a 794:
785:         loc_oPagina.AddObject("txt_4c_Uf", "TextBox")
786:         WITH loc_oPagina.txt_4c_Uf
787:             .Value         = ""
788:             .Top           = 282
789:             .Left          = 332
790:             .Width         = 24
791:             .Height        = 25
792:             .MaxLength     = 2
793:             .Format        = "A"
794:             .InputMask     = "!!"

*-- Linhas 801 a 813:
801:         ENDWITH
802: 
803:         *-- Telefone (1)
804:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
805:         WITH loc_oPagina.lbl_4c_Label6
806:             .Caption   = "Telefone (1) :"
807:             .Top       = 287
808:             .Left      = 50
809:             .Width     = 68
810:             .Height    = 15
811:             .AutoSize  = .F.
812:             .Alignment = 0
813:             .FontName  = "Tahoma"

*-- Linhas 820 a 846:
820:         loc_oPagina.AddObject("txt_4c_Tel1", "TextBox")
821:         WITH loc_oPagina.txt_4c_Tel1
822:             .Value         = ""
823:             .Top           = 282
824:             .Left          = 123
825:             .Width         = 150
826:             .Height        = 25
827:             .MaxLength     = 20
828:             .FontName      = "Tahoma"
829:             .FontSize      = 8
830:             .ForeColor     = RGB(0, 0, 0)
831:             .BackColor     = RGB(255, 255, 255)
832:             .SpecialEffect = 1
833:             .Visible       = .T.
834:         ENDWITH
835: 
836:         *-- Telefone (2)
837:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
838:         WITH loc_oPagina.lbl_4c_Label7
839:             .Caption   = "Telefone (2) :"
840:             .Top       = 315
841:             .Left      = 50
842:             .Width     = 68
843:             .Height    = 15
844:             .AutoSize  = .F.
845:             .Alignment = 0
846:             .FontName  = "Tahoma"

*-- Linhas 853 a 879:
853:         loc_oPagina.AddObject("txt_4c_Tel2", "TextBox")
854:         WITH loc_oPagina.txt_4c_Tel2
855:             .Value         = ""
856:             .Top           = 310
857:             .Left          = 123
858:             .Width         = 150
859:             .Height        = 25
860:             .MaxLength     = 20
861:             .FontName      = "Tahoma"
862:             .FontSize      = 8
863:             .ForeColor     = RGB(0, 0, 0)
864:             .BackColor     = RGB(255, 255, 255)
865:             .SpecialEffect = 1
866:             .Visible       = .T.
867:         ENDWITH
868: 
869:         *-- C.G.C.
870:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
871:         WITH loc_oPagina.lbl_4c_Label11
872:             .Caption   = "C.G.C. :"
873:             .Top       = 314
874:             .Left      = 287
875:             .Width     = 42
876:             .Height    = 15
877:             .AutoSize  = .F.
878:             .Alignment = 0
879:             .FontName  = "Tahoma"

*-- Linhas 886 a 895:
886:         loc_oPagina.AddObject("txt_4c_Cgc", "TextBox")
887:         WITH loc_oPagina.txt_4c_Cgc
888:             .Value         = ""
889:             .Top           = 310
890:             .Left          = 332
891:             .Width         = 136
892:             .Height        = 25
893:             .MaxLength     = 18
894:             .InputMask     = "99.999.999/9999-99"
895:             .FontName      = "Tahoma"

*-- Linhas 901 a 913:
901:         ENDWITH
902: 
903:         *-- I.E.
904:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
905:         WITH loc_oPagina.lbl_4c_Label12
906:             .Caption   = "I.E. :"
907:             .Top       = 342
908:             .Left      = 302
909:             .Width     = 27
910:             .Height    = 15
911:             .AutoSize  = .F.
912:             .Alignment = 0
913:             .FontName  = "Tahoma"

*-- Linhas 920 a 929:
920:         loc_oPagina.AddObject("txt_4c_Ies", "TextBox")
921:         WITH loc_oPagina.txt_4c_Ies
922:             .Value         = ""
923:             .Top           = 338
924:             .Left          = 332
925:             .Width         = 150
926:             .Height        = 25
927:             .MaxLength     = 20
928:             .Format        = "!"
929:             .FontName      = "Tahoma"

*-- Linhas 940 a 953:
940:         *======================================================================
941: 
942:         *-- Fax (getFax) - sem Say proprio no legado; pareia com Say8 "Servico :"
943:         *-- (alinhamento vertical Top+5 confirmado: getFax.Top=447 -> Say8.Top=452)
944:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
945:         WITH loc_oPagina.lbl_4c_Label8
946:             .Caption   = "Servi" + CHR(231) + "o :"
947:             .Top       = 540
948:             .Left      = 347
949:             .Width     = 44
950:             .Height    = 15
951:             .AutoSize  = .F.
952:             .Alignment = 0
953:             .FontName  = "Tahoma"

*-- Linhas 960 a 986:
960:         loc_oPagina.AddObject("txt_4c_Fax", "TextBox")
961:         WITH loc_oPagina.txt_4c_Fax
962:             .Value         = ""
963:             .Top           = 535
964:             .Left          = 395
965:             .Width         = 87
966:             .Height        = 25
967:             .MaxLength     = 20
968:             .FontName      = "Tahoma"
969:             .FontSize      = 8
970:             .ForeColor     = RGB(0, 0, 0)
971:             .BackColor     = RGB(255, 255, 255)
972:             .SpecialEffect = 1
973:             .Visible       = .T.
974:         ENDWITH
975: 
976:         *-- Titulo de secao "Configuracao da Area do FTP" (Say14)
977:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
978:         WITH loc_oPagina.lbl_4c_Label14
979:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(193) + "rea do FTP "
980:             .Top       = 368
981:             .Left      = 8
982:             .Width     = 194
983:             .Height    = 18
984:             .AutoSize  = .F.
985:             .Alignment = 0
986:             .FontName  = "Tahoma"

*-- Linhas 992 a 1004:
992:         ENDWITH
993: 
994:         *-- Geracao (Get_drivets)
995:         loc_oPagina.AddObject("lbl_4c_Label17", "Label")
996:         WITH loc_oPagina.lbl_4c_Label17
997:             .Caption   = "Gera" + CHR(231) + CHR(227) + "o :"
998:             .Top       = 389
999:             .Left      = 69
1000:             .Width     = 49
1001:             .Height    = 15
1002:             .AutoSize  = .F.
1003:             .Alignment = 0
1004:             .FontName  = "Tahoma"

*-- Linhas 1011 a 1037:
1011:         loc_oPagina.AddObject("txt_4c_DriveGeracao", "TextBox")
1012:         WITH loc_oPagina.txt_4c_DriveGeracao
1013:             .Value         = ""
1014:             .Top           = 385
1015:             .Left          = 123
1016:             .Width         = 359
1017:             .Height        = 23
1018:             .MaxLength     = 60
1019:             .FontName      = "Tahoma"
1020:             .FontSize      = 8
1021:             .ForeColor     = RGB(0, 0, 0)
1022:             .BackColor     = RGB(255, 255, 255)
1023:             .SpecialEffect = 1
1024:             .Visible       = .T.
1025:         ENDWITH
1026: 
1027:         *-- Leitura (Get_drivels)
1028:         loc_oPagina.AddObject("lbl_4c_Label21", "Label")
1029:         WITH loc_oPagina.lbl_4c_Label21
1030:             .Caption   = "Leitura :"
1031:             .Top       = 414
1032:             .Left      = 76
1033:             .Width     = 42
1034:             .Height    = 15
1035:             .AutoSize  = .F.
1036:             .Alignment = 0
1037:             .FontName  = "Tahoma"

*-- Linhas 1044 a 1070:
1044:         loc_oPagina.AddObject("txt_4c_DriveLeitura", "TextBox")
1045:         WITH loc_oPagina.txt_4c_DriveLeitura
1046:             .Value         = ""
1047:             .Top           = 410
1048:             .Left          = 123
1049:             .Width         = 359
1050:             .Height        = 23
1051:             .MaxLength     = 60
1052:             .FontName      = "Tahoma"
1053:             .FontSize      = 8
1054:             .ForeColor     = RGB(0, 0, 0)
1055:             .BackColor     = RGB(255, 255, 255)
1056:             .SpecialEffect = 1
1057:             .Visible       = .T.
1058:         ENDWITH
1059: 
1060:         *-- Tipo de Conexao (Get_tpconexao) - D/B
1061:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
1062:         WITH loc_oPagina.lbl_4c_Label15
1063:             .Caption   = "Tipo de Conex" + CHR(227) + "o :"
1064:             .Top       = 439
1065:             .Left      = 28
1066:             .Width     = 90
1067:             .Height    = 15
1068:             .AutoSize  = .F.
1069:             .Alignment = 0
1070:             .FontName  = "Tahoma"

*-- Linhas 1077 a 1102:
1077:         loc_oPagina.AddObject("txt_4c_TpConexao", "TextBox")
1078:         WITH loc_oPagina.txt_4c_TpConexao
1079:             .Value         = ""
1080:             .Top           = 435
1081:             .Left          = 123
1082:             .Width         = 28
1083:             .Height        = 23
1084:             .MaxLength     = 1
1085:             .FontName      = "Tahoma"
1086:             .FontSize      = 8
1087:             .ForeColor     = RGB(0, 0, 0)
1088:             .BackColor     = RGB(255, 255, 255)
1089:             .SpecialEffect = 1
1090:             .Visible       = .T.
1091:         ENDWITH
1092: 
1093:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
1094:         WITH loc_oPagina.lbl_4c_Label19
1095:             .Caption   = "(D/B) Dial-Up / Banda Larga"
1096:             .Top       = 439
1097:             .Left      = 156
1098:             .Width     = 159
1099:             .Height    = 15
1100:             .AutoSize  = .F.
1101:             .Alignment = 0
1102:             .FontName  = "Tahoma"

*-- Linhas 1108 a 1120:
1108:         ENDWITH
1109: 
1110:         *-- Endereco FTP (Get_ftpend)
1111:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
1112:         WITH loc_oPagina.lbl_4c_Label16
1113:             .Caption   = "Endere" + CHR(231) + "o FTP :"
1114:             .Top       = 464
1115:             .Left      = 43
1116:             .Width     = 75
1117:             .Height    = 15
1118:             .AutoSize  = .F.
1119:             .Alignment = 0
1120:             .FontName  = "Tahoma"

*-- Linhas 1127 a 1153:
1127:         loc_oPagina.AddObject("txt_4c_FtpEndereco", "TextBox")
1128:         WITH loc_oPagina.txt_4c_FtpEndereco
1129:             .Value         = ""
1130:             .Top           = 460
1131:             .Left          = 123
1132:             .Width         = 359
1133:             .Height        = 23
1134:             .MaxLength     = 50
1135:             .FontName      = "Tahoma"
1136:             .FontSize      = 8
1137:             .ForeColor     = RGB(0, 0, 0)
1138:             .BackColor     = RGB(255, 255, 255)
1139:             .SpecialEffect = 1
1140:             .Visible       = .T.
1141:         ENDWITH
1142: 
1143:         *-- Pasta p/ Envio (Get_dirftpts)
1144:         loc_oPagina.AddObject("lbl_4c_Label18", "Label")
1145:         WITH loc_oPagina.lbl_4c_Label18
1146:             .Caption   = "Pasta p/ Envio :"
1147:             .Top       = 489
1148:             .Left      = 40
1149:             .Width     = 78
1150:             .Height    = 15
1151:             .AutoSize  = .F.
1152:             .Alignment = 0
1153:             .FontName  = "Tahoma"

*-- Linhas 1160 a 1186:
1160:         loc_oPagina.AddObject("txt_4c_DirFtpEnvio", "TextBox")
1161:         WITH loc_oPagina.txt_4c_DirFtpEnvio
1162:             .Value         = ""
1163:             .Top           = 485
1164:             .Left          = 123
1165:             .Width         = 359
1166:             .Height        = 23
1167:             .MaxLength     = 60
1168:             .FontName      = "Tahoma"
1169:             .FontSize      = 8
1170:             .ForeColor     = RGB(0, 0, 0)
1171:             .BackColor     = RGB(255, 255, 255)
1172:             .SpecialEffect = 1
1173:             .Visible       = .T.
1174:         ENDWITH
1175: 
1176:         *-- Pasta p/Recepcao (Get_dirftpls)
1177:         loc_oPagina.AddObject("lbl_4c_Label20", "Label")
1178:         WITH loc_oPagina.lbl_4c_Label20
1179:             .Caption   = "Pasta p/Recep" + CHR(231) + CHR(227) + "o :"
1180:             .Top       = 514
1181:             .Left      = 22
1182:             .Width     = 96
1183:             .Height    = 15
1184:             .AutoSize  = .F.
1185:             .Alignment = 0
1186:             .FontName  = "Tahoma"

*-- Linhas 1193 a 1219:
1193:         loc_oPagina.AddObject("txt_4c_DirFtpRecepcao", "TextBox")
1194:         WITH loc_oPagina.txt_4c_DirFtpRecepcao
1195:             .Value         = ""
1196:             .Top           = 510
1197:             .Left          = 123
1198:             .Width         = 359
1199:             .Height        = 23
1200:             .MaxLength     = 60
1201:             .FontName      = "Tahoma"
1202:             .FontSize      = 8
1203:             .ForeColor     = RGB(0, 0, 0)
1204:             .BackColor     = RGB(255, 255, 255)
1205:             .SpecialEffect = 1
1206:             .Visible       = .T.
1207:         ENDWITH
1208: 
1209:         *-- Usuario FTP (Get_ftpusuario)
1210:         loc_oPagina.AddObject("lbl_4c_Label23", "Label")
1211:         WITH loc_oPagina.lbl_4c_Label23
1212:             .Caption   = "Usu" + CHR(225) + "rio :"
1213:             .Top       = 539
1214:             .Left      = 73
1215:             .Width     = 45
1216:             .Height    = 15
1217:             .AutoSize  = .F.
1218:             .Alignment = 0
1219:             .FontName  = "Tahoma"

*-- Linhas 1226 a 1252:
1226:         loc_oPagina.AddObject("txt_4c_FtpUsuario", "TextBox")
1227:         WITH loc_oPagina.txt_4c_FtpUsuario
1228:             .Value         = ""
1229:             .Top           = 535
1230:             .Left          = 123
1231:             .Width         = 160
1232:             .Height        = 25
1233:             .MaxLength     = 50
1234:             .FontName      = "Tahoma"
1235:             .FontSize      = 8
1236:             .ForeColor     = RGB(0, 0, 0)
1237:             .BackColor     = RGB(255, 255, 255)
1238:             .SpecialEffect = 1
1239:             .Visible       = .T.
1240:         ENDWITH
1241: 
1242:         *-- Modelo (Say27) / OptionGroup Tipo de Transporte (Optiongroup1)
1243:         loc_oPagina.AddObject("lbl_4c_Label27", "Label")
1244:         WITH loc_oPagina.lbl_4c_Label27
1245:             .Caption   = "Modelo :"
1246:             .Top       = 561
1247:             .Left      = 347
1248:             .Width     = 43
1249:             .Height    = 15
1250:             .AutoSize  = .F.
1251:             .Alignment = 0
1252:             .FontName  = "Tahoma"

*-- Linhas 1258 a 1338:
1258: 
1259:         loc_oPagina.AddObject("opt_4c_TipoTransporte", "OptionGroup")
1260:         WITH loc_oPagina.opt_4c_TipoTransporte
1261:             .Top         = 558
1262:             .Left        = 390
1263:             .Width       = 137
1264:             .Height      = 53
1265:             .ButtonCount = 4
1266:             .BackStyle   = 0
1267:             .BorderStyle = 0
1268:             .Value       = 1
1269:             .Visible     = .T.
1270:         ENDWITH
1271: 
1272:         WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(1)
1273:             .Caption   = "Comum"
1274:             .Left      = 5
1275:             .Top       = 5
1276:             .Width     = 61
1277:             .Height    = 17
1278:             .AutoSize  = .F.
1279:             .FontName  = "Tahoma"
1280:             .FontSize  = 8
1281:             .BackStyle = 0
1282:             .ForeColor = RGB(90, 90, 90)
1283:             .Themes    = .F.
1284:         ENDWITH
1285: 
1286:         WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(2)
1287:             .Caption   = "Sedex"
1288:             .Left      = 63
1289:             .Top       = 5
1290:             .Width     = 61
1291:             .Height    = 17
1292:             .AutoSize  = .F.
1293:             .FontName  = "Tahoma"
1294:             .FontSize  = 8
1295:             .BackStyle = 0
1296:             .ForeColor = RGB(90, 90, 90)
1297:             .Themes    = .F.
1298:         ENDWITH
1299: 
1300:         WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(3)
1301:             .Caption   = "PAC"
1302:             .Left      = 5
1303:             .Top       = 19
1304:             .Width     = 61
1305:             .Height    = 17
1306:             .AutoSize  = .F.
1307:             .FontName  = "Tahoma"
1308:             .FontSize  = 8
1309:             .BackStyle = 0
1310:             .ForeColor = RGB(90, 90, 90)
1311:             .Themes    = .F.
1312:         ENDWITH
1313: 
1314:         WITH loc_oPagina.opt_4c_TipoTransporte.Buttons(4)
1315:             .Caption   = "Sedex Hoje"
1316:             .Left      = 5
1317:             .Top       = 34
1318:             .Width     = 73
1319:             .Height    = 15
1320:             .AutoSize  = .T.
1321:             .FontName  = "Tahoma"
1322:             .FontSize  = 8
1323:             .BackStyle = 0
1324:             .ForeColor = RGB(90, 90, 90)
1325:             .Themes    = .F.
1326:         ENDWITH
1327: 
1328:         *-- Senha FTP (Get_ftpsenha) - Valid comentado no legado (TrocaSenha desativado)
1329:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
1330:         WITH loc_oPagina.lbl_4c_Label24
1331:             .Caption   = "Senha :"
1332:             .Top       = 566
1333:             .Left      = 79
1334:             .Width     = 39
1335:             .Height    = 15
1336:             .AutoSize  = .F.
1337:             .Alignment = 0
1338:             .FontName  = "Tahoma"

*-- Linhas 1345 a 1354:
1345:         loc_oPagina.AddObject("txt_4c_FtpSenha", "TextBox")
1346:         WITH loc_oPagina.txt_4c_FtpSenha
1347:             .Value         = ""
1348:             .Top           = 562
1349:             .Left          = 123
1350:             .Width         = 130
1351:             .Height        = 23
1352:             .PasswordChar  = "*"
1353:             .FontName      = "Tahoma"
1354:             .FontSize      = 8

*-- Linhas 1360 a 1372:
1360: 
1361:         *-- Redigita Senha (Get_senha2) - apenas conferencia visual, Valid comentado
1362:         *-- no legado (nao persiste, nao mapeado no FormParaBO/BOParaForm)
1363:         loc_oPagina.AddObject("lbl_4c_Label22", "Label")
1364:         WITH loc_oPagina.lbl_4c_Label22
1365:             .Caption   = "Redigita :"
1366:             .Top       = 591
1367:             .Left      = 70
1368:             .Width     = 48
1369:             .Height    = 15
1370:             .AutoSize  = .F.
1371:             .Alignment = 0
1372:             .FontName  = "Tahoma"

*-- Linhas 1379 a 1438:
1379:         loc_oPagina.AddObject("txt_4c_Senha2", "TextBox")
1380:         WITH loc_oPagina.txt_4c_Senha2
1381:             .Value         = ""
1382:             .Top           = 587
1383:             .Left          = 123
1384:             .Width         = 130
1385:             .Height        = 23
1386:             .PasswordChar  = "*"
1387:             .FontName      = "Tahoma"
1388:             .FontSize      = 8
1389:             .ForeColor     = RGB(0, 0, 0)
1390:             .BackColor     = RGB(255, 255, 255)
1391:             .SpecialEffect = 1
1392:             .Visible       = .T.
1393:         ENDWITH
1394: 
1395:         *-- Checkboxes de limpeza de diretorio (chkftpdel / chklocdel)
1396:         loc_oPagina.AddObject("chk_4c_LimpaDiretorioFtp", "CheckBox")
1397:         WITH loc_oPagina.chk_4c_LimpaDiretorioFtp
1398:             .Caption   = "Limpa diret" + CHR(243) + "rio do FTP"
1399:             .Top       = 611
1400:             .Left      = 123
1401:             .Width     = 160
1402:             .Height    = 17
1403:             .Value     = 0
1404:             .Alignment = 0
1405:             .BackStyle = 0
1406:             .FontName  = "Tahoma"
1407:             .FontSize  = 8
1408:             .ForeColor = RGB(90, 90, 90)
1409:             .Visible   = .T.
1410:         ENDWITH
1411: 
1412:         loc_oPagina.AddObject("chk_4c_LimpaDiretorioLocal", "CheckBox")
1413:         WITH loc_oPagina.chk_4c_LimpaDiretorioLocal
1414:             .Caption   = "Limpa diret" + CHR(243) + "rio de envio"
1415:             .Top       = 611
1416:             .Left      = 279
1417:             .Width     = 160
1418:             .Height    = 17
1419:             .Value     = 0
1420:             .Alignment = 0
1421:             .BackStyle = 0
1422:             .FontName  = "Tahoma"
1423:             .FontSize  = 8
1424:             .ForeColor = RGB(90, 90, 90)
1425:             .Visible   = .T.
1426:         ENDWITH
1427: 
1428:         *-- Url Tracking (getUrlTransp - editbox)
1429:         loc_oPagina.AddObject("lbl_4c_Label26", "Label")
1430:         WITH loc_oPagina.lbl_4c_Label26
1431:             .Caption   = "Url Tracking :"
1432:             .Top       = 628
1433:             .Left      = 53
1434:             .Width     = 65
1435:             .Height    = 15
1436:             .AutoSize  = .F.
1437:             .Alignment = 0
1438:             .FontName  = "Tahoma"

*-- Linhas 1445 a 1454:
1445:         loc_oPagina.AddObject("txt_4c_UrlTransp", "EditBox")
1446:         WITH loc_oPagina.txt_4c_UrlTransp
1447:             .Value         = ""
1448:             .Top           = 628
1449:             .Left          = 122
1450:             .Width         = 359
1451:             .Height        = 53
1452:             .SpecialEffect = 2
1453:             .FontName      = "Tahoma"
1454:             .FontSize      = 8

*-- Linhas 1460 a 1472:
1460:         *======================================================================
1461: 
1462:         *-- Titulo da grade (Say13)
1463:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1464:         WITH loc_oPagina.lbl_4c_Label13
1465:             .Caption   = "Valor por estado e varia" + CHR(231) + CHR(227) + "o de peso (Gr) :"
1466:             .Top       = 194
1467:             .Left      = 503
1468:             .Width     = 204
1469:             .Height    = 15
1470:             .AutoSize  = .F.
1471:             .Alignment = 0
1472:             .FontName  = "Tahoma"

*-- Linhas 1482 a 1491:
1482:         loc_oPagina.AddObject("grd_4c_Estados", "Grid")
1483:         loc_oPagina.grd_4c_Estados.ColumnCount = 5
1484:         WITH loc_oPagina.grd_4c_Estados
1485:             .Top           = 211
1486:             .Left          = 500
1487:             .Width         = 490
1488:             .Height        = 419
1489:             .FontName      = "Tahoma"
1490:             .FontSize      = 8
1491:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1540 a 1601:
1540:         loc_oPagina.grd_4c_Estados.Column5.ReadOnly = .F.
1541: 
1542:         *-- Botao Incluir linha de estado (inserir no legado)
1543:         loc_oPagina.AddObject("cmd_4c_IncluirEstado", "CommandButton")
1544:         WITH loc_oPagina.cmd_4c_IncluirEstado
1545:             .Top           = 633
1546:             .Left          = 502
1547:             .Width         = 45
1548:             .Height        = 45
1549:             .Caption       = ""
1550:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1551:             .ToolTipText   = "Inserir"
1552:             .FontBold      = .T.
1553:             .FontName      = "Verdana"
1554:             .FontSize      = 8
1555:             .ForeColor     = RGB(36, 84, 155)
1556:             .BackColor     = RGB(255, 255, 255)
1557:             .Themes        = .F.
1558:             .SpecialEffect = 0
1559:             .Visible       = .T.
1560:         ENDWITH
1561:         BINDEVENT(loc_oPagina.cmd_4c_IncluirEstado, "Click", THIS, "BtnIncluirEstadoClick")
1562: 
1563:         *-- Botao Excluir linha de estado (excluir no legado)
1564:         loc_oPagina.AddObject("cmd_4c_ExcluirEstado", "CommandButton")
1565:         WITH loc_oPagina.cmd_4c_ExcluirEstado
1566:             .Top           = 633
1567:             .Left          = 548
1568:             .Width         = 45
1569:             .Height        = 45
1570:             .Caption       = ""
1571:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1572:             .ToolTipText   = "Excluir"
1573:             .FontBold      = .T.
1574:             .FontName      = "Verdana"
1575:             .FontSize      = 8
1576:             .ForeColor     = RGB(36, 84, 155)
1577:             .BackColor     = RGB(255, 255, 255)
1578:             .Themes        = .F.
1579:             .SpecialEffect = 0
1580:             .Visible       = .T.
1581:         ENDWITH
1582:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirEstado, "Click", THIS, "BtnExcluirEstadoClick")
1583: 
1584:         *-- Inicializa a estrutura do cursor da grade (RecordSource/Headers definidos aqui)
1585:         THIS.CarregarGradeEstados("")
1586: 
1587:         *======================================================================
1588:         * Botoes de acao da Pagina Dados (Grupo_Salva no legado)
1589:         *======================================================================
1590:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
1591:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
1592:             .Caption         = "Confirmar"
1593:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1594:             .PicturePosition = 13
1595:             .Top             = 5
1596:             .Left            = 5
1597:             .Width           = 75
1598:             .Height          = 75
1599:             .FontName        = "Tahoma"
1600:             .FontBold        = .T.
1601:             .FontItalic      = .T.

*-- Linhas 1609 a 1625:
1609:             .AutoSize        = .F.
1610:             .Visible         = .T.
1611:         ENDWITH
1612:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1613: 
1614:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1615:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1616:             .Caption         = "Encerrar"
1617:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1618:             .PicturePosition = 13
1619:             .Top             = 5
1620:             .Left            = 80
1621:             .Width           = 75
1622:             .Height          = 75
1623:             .FontName        = "Tahoma"
1624:             .FontBold        = .T.
1625:             .FontItalic      = .T.

*-- Linhas 1633 a 1641:
1633:             .AutoSize        = .F.
1634:             .Visible         = .T.
1635:         ENDWITH
1636:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1637: 
1638:         THIS.TornarControlesVisiveis(loc_oPagina)
1639:     ENDPROC
1640: 
1641:     *===========================================================================

*-- Linhas 1718 a 1730:
1718:                 loc_oGrid.Column3.Text1.Alignment = 3
1719:                 loc_oGrid.Column4.Text1.Alignment = 3
1720: 
1721:                 loc_oGrid.Column1.Header1.Caption = "UF"
1722:                 loc_oGrid.Column2.Header1.Caption = "Valor"
1723:                 loc_oGrid.Column3.Header1.Caption = "Peso M" + CHR(237) + "nimo"
1724:                 loc_oGrid.Column4.Header1.Caption = "Peso M" + CHR(225) + "ximo"
1725:                 loc_oGrid.Column5.Header1.Caption = "Munic" + CHR(237) + "pio"
1726:             ENDIF
1727: 
1728:             loc_oGrid.Refresh()
1729:             loc_lResultado = .T.
1730: 

*-- Linhas 2336 a 2345:
2336:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
2337:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2338: 
2339:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
2340:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2341:     ENDPROC
2342: 
2343:     *===========================================================================
2344:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2345:     * REGRA: Deve iterar Pages E Controls para PageFrames aninhados


### BO (C:\4c\projeto\app\classes\traBO.prg):
*====================================================================
* traBO.prg
*
* Business Object para Cadastro de Transportadoras
* Tabela: SigPrTrp (cabecalho) / SigPrTrv (fretes por estado - detalhe)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS traBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTrp)
    this_cCodigo             = ""    && itras char(10) - PK
    this_nCodigoSequencial   = 0     && codigos numeric(6,0) - sequencial usado para gerar o itras
    this_cRazaoSocial        = ""    && razaos char(40)
    this_cEndereco           = ""    && endes char(40)
    this_cBairro             = ""    && bairs char(20)
    this_cCidade             = ""    && cidas char(30)
    this_cCep                = ""    && ceps char(9)
    this_cUf                 = ""    && estas char(2)
    this_cTelefone1          = ""    && tel1s char(20)
    this_cTelefone2          = ""    && tel2s char(20)
    this_cFax                = ""    && faxs char(20)
    this_cCgc                = ""    && cgcs char(20)
    this_cInscricaoEstadual  = ""    && inscs char(20)
    this_cApelido            = ""    && apelidos char(30) NULL
    this_cIdTransportadora   = ""    && idtransp char(50) - rotulado "ID E-Commerce" no legado
    this_cTipoConexao        = ""    && tpconexao char(1) - D/B (Dial-Up / Banda Larga)
    this_cFtpEndereco        = ""    && ftpend char(50)
    this_cFtpUsuario         = ""    && ftpusuario char(50)
    this_cFtpSenha           = ""    && ftpsenha char(20)
    this_cDirFtpEnvio        = ""    && dirftpts char(60) - "Pasta p/ Envio"
    this_cDirFtpRecepcao     = ""    && dirftpls char(60) - "Pasta p/ Recepcao"
    this_cDriveGeracao       = ""    && drivets char(60) - "Geracao"
    this_cDriveLeitura       = ""    && drivels char(60) - "Leitura"
    this_lLimpaDiretorioFtp  = .F.   && ftpdel bit NULL
    this_lLimpaDiretorioLocal = .F.  && locdel bit NULL
    this_cUrlTransp          = ""    && urltransp char(200)
    this_nTipoTransporte     = 0     && tipotrans numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTrp"
            THIS.this_cCampoChave = "itras"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "traBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo             = TratarNulo(itras,      "C")
                THIS.this_cRazaoSocial        = TratarNulo(razaos,     "C")
                THIS.this_nCodigoSequencial   = TratarNulo(codigos,    "N")
                THIS.this_cEndereco           = TratarNulo(endes,      "C")
                THIS.this_cBairro             = TratarNulo(bairs,      "C")
                THIS.this_cCidade             = TratarNulo(cidas,      "C")
                THIS.this_cCep                = TratarNulo(ceps,       "C")
                THIS.this_cUf                 = TratarNulo(estas,      "C")
                THIS.this_cTelefone1          = TratarNulo(tel1s,      "C")
                THIS.this_cTelefone2          = TratarNulo(tel2s,      "C")
                THIS.this_cFax                = TratarNulo(faxs,       "C")
                THIS.this_cCgc                = TratarNulo(cgcs,       "C")
                THIS.this_cInscricaoEstadual  = TratarNulo(inscs,      "C")
                THIS.this_cApelido            = TratarNulo(apelidos,   "C")
                THIS.this_cIdTransportadora   = TratarNulo(idtransp,   "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_cDriveGeracao       = TratarNulo(drivets,    "C")
                THIS.this_cDriveLeitura       = TratarNulo(drivels,    "C")
                THIS.this_lLimpaDiretorioFtp  = ConverterParaLogico(ftpdel)
                THIS.this_lLimpaDiretorioLocal = ConverterParaLogico(locdel)
                THIS.this_cUrlTransp          = TratarNulo(urltransp,  "C")
                THIS.this_nTipoTransporte     = TratarNulo(tipotrans,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "traBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Gera codigo (itras) para novo registro
    * Legado: m.Codigos = fGerUniqueKey('SigPrTrp' + _Empr)
    *         m.Itras   = 'T' + _Empr + Padl(m.codigos, 6, '0')
    * Aqui o sequencial vem do MAX(codigos) da propria tabela (seguro entre
    * sessoes), e _Empr (legado) -> go_4c_Sistema.cCodEmpresa
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        LOCAL loc_cSQL, loc_nResultado, loc_nSeq, loc_cEmpresa
        loc_nSeq = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos),0) AS maxval FROM SigPrTrp"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_SeqTra")
                SELECT cursor_4c_SeqTra
                loc_nSeq = NVL(cursor_4c_SeqTra.maxval, 0) + 1
                USE IN cursor_4c_SeqTra
            ENDIF
        CATCH TO loException
            loc_nSeq = 1
        ENDTRY

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
            ALLTRIM(go_4c_Sistema.cCodEmpresa), "")

        THIS.this_nCodigoSequencial = loc_nSeq
        THIS.this_cCodigo           = "T" + loc_cEmpresa + PADL(TRANSFORM(loc_nSeq), 6, "0")
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo Inv" + CHR(225) + "lido."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado."
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cRazaoSocial))
            THIS.this_cMensagemErro = "Raz" + CHR(227) + "o Social " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se itras ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTrp" + ;
                " WHERE itras = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTra")
                SELECT cursor_4c_ChkTra
                loc_lExiste = (cursor_4c_ChkTra.qtd > 0)
                USE IN cursor_4c_ChkTra
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "traBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTrp (itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls, dirftpts,
                    drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario, locdel, tpconexao,
                    urltransp, tipotrans)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodigoSequencial, 0)>>,
                    <<EscaparSQL(THIS.this_cEndereco)>>,
                    <<EscaparSQL(THIS.this_cBairro)>>,
                    <<EscaparSQL(THIS.this_cCidade)>>,
                    <<EscaparSQL(THIS.this_cCep)>>,
                    <<EscaparSQL(THIS.this_cUf)>>,
                    <<EscaparSQL(THIS.this_cTelefone1)>>,
                    <<EscaparSQL(THIS.this_cTelefone2)>>,
                    <<EscaparSQL(THIS.this_cFax)>>,
                    <<EscaparSQL(THIS.this_cCgc)>>,
                    <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    <<EscaparSQL(THIS.this_cApelido)>>,
                    <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "traBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTrp
                SET razaos      = <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    endes       = <<EscaparSQL(THIS.this_cEndereco)>>,
                    bairs       = <<EscaparSQL(THIS.this_cBairro)>>,
                    cidas       = <<EscaparSQL(THIS.this_cCidade)>>,
                    ceps        = <<EscaparSQL(THIS.this_cCep)>>,
                    estas       = <<EscaparSQL(THIS.this_cUf)>>,
                    tel1s       = <<EscaparSQL(THIS.this_cTelefone1)>>,
                    tel2s       = <<EscaparSQL(THIS.this_cTelefone2)>>,
                    faxs        = <<EscaparSQL(THIS.this_cFax)>>,
                    cgcs        = <<EscaparSQL(THIS.this_cCgc)>>,
                    inscs       = <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    apelidos    = <<EscaparSQL(THIS.this_cApelido)>>,
                    idtransp    = <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    dirftpls    = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    dirftpts    = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    drivels     = <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    drivets     = <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    ftpdel      = <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    ftpend      = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpsenha    = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    ftpusuario  = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    locdel      = <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    tpconexao   = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    urltransp   = <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    tipotrans   = <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                WHERE itras = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "traBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTrp e os fretes
    * por estado associados (SigPrTrv), espelhando o legado
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir fretes da transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrTrp WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "traBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com itras, razaos, tel1s
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (itras C(10), razaos C(40), tel1s C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT itras, razaos, tel1s FROM SigPrTrp"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY razaos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "traBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (itras)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls,
                    dirftpts, drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario,
                    locdel, tpconexao, urltransp, tipotrans
                FROM SigPrTrp
                WHERE itras = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Transportadora n" + CHR(227) + "o encontrada!"
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "traBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

