# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=85 vs migrado 'cnt_4c_BotoesAcao' Top=33 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=9 vs migrado 'cnt_4c_BotoesAcao' Left=842 (diff=833px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2466 linhas total):

*-- Linhas 55 a 67:
55:                 THIS.ConfigurarPageFrame()
56: 
57:                 *-- Propagar Caption para labels do cabecalho (Problema 44)
58:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
59:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 ENDIF
61:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
62:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63:                 ENDIF
64: 
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"

*-- Linhas 92 a 111:
92: 
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()

*-- Linhas 126 a 163:
126:         *-- Original: Top=1. Com compensacao +29: Top=31
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = THIS.Caption
141:             .Top       = 15
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = THIS.Caption
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.

*-- Linhas 171 a 195:
171:         *-- Canonico: Left=542, Top=29, Width=390, Height=85
172:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
173:         WITH loc_oPagina.cnt_4c_Botoes
174:             .Top         = 29
175:             .Left        = 542
176:             .Width       = 390
177:             .Height      = 85
178:             .BackStyle   = 0
179:             .BorderWidth = 0
180:             .Visible     = .T.
181:         ENDWITH
182: 
183:         *-- Botao Incluir (Inserir no legado)
184:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
185:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
186:             .Caption         = "Incluir"
187:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
188:             .PicturePosition = 13
189:             .Top             = 5
190:             .Left            = 5
191:             .Width           = 75
192:             .Height          = 75
193:             .FontName        = "Tahoma"
194:             .FontBold        = .T.
195:             .FontItalic      = .T.

*-- Linhas 203 a 220:
203:             .AutoSize        = .F.
204:             .Visible         = .T.
205:         ENDWITH
206:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
207: 
208:         *-- Botao Visualizar (Consultar no legado)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
211:             .Caption         = "Visualizar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .FontName        = "Tahoma"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.

*-- Linhas 228 a 245:
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
232: 
233:         *-- Botao Alterar
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
236:             .Caption         = "Alterar"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .FontName        = "Tahoma"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.

*-- Linhas 253 a 270:
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         *-- Botao Excluir
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
261:             .Caption         = "Excluir"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .FontName        = "Tahoma"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.

*-- Linhas 278 a 295:
278:             .AutoSize        = .F.
279:             .Visible         = .T.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
282: 
283:         *-- Botao Buscar (Procurar no legado)
284:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
286:             .Caption         = "Buscar"
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
288:             .PicturePosition = 13
289:             .Top             = 5
290:             .Left            = 305
291:             .Width           = 75
292:             .Height          = 75
293:             .FontName        = "Tahoma"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.

*-- Linhas 303 a 333:
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
307: 
308:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
309:         *-- Legado: Grupo_Saida.Left=927, Top=-1. Canonico: Left=917, Top=29, Width=90
310:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
311:         WITH loc_oPagina.cnt_4c_Saida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle   = 0
317:             .BorderWidth = 0
318:             .Visible     = .T.
319:         ENDWITH
320: 
321:         *-- Botao Encerrar - PADRAO CANONICO
322:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
323:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
324:             .Caption         = "Encerrar"
325:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
326:             .PicturePosition = 13
327:             .Top             = 5
328:             .Left            = 5
329:             .Width           = 75
330:             .Height          = 75
331:             .FontName        = "Tahoma"
332:             .FontBold        = .T.
333:             .FontItalic      = .T.

*-- Linhas 341 a 359:
341:             .AutoSize        = .F.
342:             .Visible         = .T.
343:         ENDWITH
344:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
345: 
346:         *-- Grid de listagem de produtos
347:         *-- Original: Grade.Top=173, Left=11, Width=972, Height=422, ColumnCount=7
348:         *-- Top nao precisa de compensacao pois grade esta dentro da page (coordenadas relativas)
349:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
350:         *-- ColumnCount FORA do WITH (auto-bind VFP9)
351:         loc_oPagina.grd_4c_Lista.ColumnCount = 7
352:         WITH loc_oPagina.grd_4c_Lista
353:             .Top                = 117
354:             .Left               = 11
355:             .Width              = 972
356:             .Height             = 422
357:             .FontName           = "Tahoma"
358:             .FontSize           = 8
359:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 385 a 477:
385:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
386: 
387:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
388: 
389:         *-- Container BotoesAcao (canonico: Left=842, Top=33, Width=160, Height=85)
390:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
391:         WITH loc_oPagina.cnt_4c_BotoesAcao
392:             .Top         = 33
393:             .Left        = 842
394:             .Width       = 160
395:             .Height      = 85
396:             .BackStyle = 1
397:             .BackColor = RGB(255, 255, 255)
398:             .BorderWidth = 0
399:             .Visible     = .T.
400:         ENDWITH
401: 
402:         *-- Botao Salvar
403:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
404:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
405:             .Caption         = "Salvar"
406:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
407:             .PicturePosition = 13
408:             .Top             = 5
409:             .Left            = 5
410:             .Width           = 70
411:             .Height          = 75
412:             .FontName        = "Tahoma"
413:             .FontBold        = .T.
414:             .FontItalic      = .T.
415:             .FontSize        = 8
416:             .ForeColor       = RGB(90, 90, 90)
417:             .BackColor       = RGB(255, 255, 255)
418:             .Themes          = .F.
419:             .SpecialEffect   = 0
420:             .MousePointer    = 15
421:             .WordWrap        = .T.
422:             .AutoSize        = .F.
423:             .Visible         = .T.
424:         ENDWITH
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
426: 
427:         *-- Botao Cancelar
428:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
429:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
430:             .Caption         = "Encerrar"
431:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
432:             .PicturePosition = 13
433:             .Top             = 5
434:             .Left            = 80
435:             .Width           = 75
436:             .Height          = 75
437:             .FontName        = "Tahoma"
438:             .FontBold        = .T.
439:             .FontItalic      = .T.
440:             .FontSize        = 8
441:             .ForeColor       = RGB(90, 90, 90)
442:             .BackColor       = RGB(255, 255, 255)
443:             .Themes          = .F.
444:             .SpecialEffect   = 0
445:             .MousePointer    = 15
446:             .WordWrap        = .T.
447:             .AutoSize        = .F.
448:             .Visible         = .T.
449:         ENDWITH
450:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
451: 
452:         *-- pgf_4c_Dados: PageFrame interno com 8 abas (original: pgframeDados)
453:         *-- Original: Top=-58(abas ocultas), Width=1009, Height=656
454:         *-- Novo: abas visiveis abaixo dos BotoesAcao
455:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
456:         loc_oPagina.pgf_4c_Dados.PageCount = 8
457:         WITH loc_oPagina.pgf_4c_Dados
458:             .Top     = 120
459:             .Left    = 0
460:             .Width   = THIS.Width
461:             .Height  = 500
462:             .Tabs    = .T.
463:             .Visible = .T.
464: 
465:             .Page1.Caption = "Dados Principais"
466:             .Page2.Caption = "Custos"
467:             .Page3.Caption = "Dados Fiscais"
468:             .Page4.Caption = "Processos"
469:             .Page5.Caption = "Consumo"
470:             .Page6.Caption = "Composi" + CHR(231) + CHR(227) + "o"
471:             .Page7.Caption = "Designer"
472:             .Page8.Caption = "Servi" + CHR(231) + "os"
473:         ENDWITH
474: 
475:         *-- Tab 1: Dados Principais (campos principais de SigCdPro)
476:         THIS.ConfigurarPgDados(loc_oPagina.pgf_4c_Dados.Page1)
477: 

*-- Linhas 509 a 549:
509:         WITH loc_oPg.opt_4c_Situacao
510:             .ButtonCount = 2
511:             .Value       = 1
512:             .Top         = 114
513:             .Left        = 758
514:             .Width       = 156
515:             .Height      = 25
516:             .BackStyle   = 0
517:             .BorderStyle = 0
518:             .Visible     = .T.
519:             .Option1.Caption   = "Ativo"
520:             .Option1.FontName  = "Tahoma"
521:             .Option1.FontSize  = 8
522:             .Option1.BackStyle = 0
523:             .Option1.ForeColor = RGB(90, 90, 90)
524:             .Option1.Top       = 5
525:             .Option1.Left      = 5
526:             .Option1.Height    = 15
527:             .Option1.AutoSize  = .T.
528:             .Option2.Caption   = "Inativo"
529:             .Option2.FontName  = "Tahoma"
530:             .Option2.FontSize  = 8
531:             .Option2.BackStyle = 0
532:             .Option2.ForeColor = RGB(90, 90, 90)
533:             .Option2.Top       = 5
534:             .Option2.Left      = 80
535:             .Option2.Height    = 15
536:             .Option2.AutoSize  = .T.
537:         ENDWITH
538:         BINDEVENT(loc_oPg.opt_4c_Situacao, "InteractiveChange", THIS, "OptSituacaoInteractiveChange")
539: 
540:         *-- Data da Situacao (getDtSituas: Top=115, Left=918, readonly)
541:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
542:         WITH loc_oPg.txt_4c_DtSituas
543:             .Top           = 115
544:             .Left          = 918
545:             .Width         = 80
546:             .Height        = 23
547:             .FontName      = "Tahoma"
548:             .FontSize      = 8
549:             .SpecialEffect = 1

*-- Linhas 555 a 567:
555:         ENDWITH
556: 
557:         *-- Label "Produto:"
558:         loc_oPg.AddObject("lbl_4c_LbCpros", "Label")
559:         WITH loc_oPg.lbl_4c_LbCpros
560:             .Caption   = "Produto :"
561:             .Top       = 121
562:             .Left      = 47
563:             .Width     = 53
564:             .Height    = 15
565:             .FontName  = "Tahoma"
566:             .FontBold  = .T.
567:             .FontSize  = 8

*-- Linhas 574 a 612:
574:         *-- Codigo do Produto (getCpro: Top=117, Left=102, Width=108)
575:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
576:         WITH loc_oPg.txt_4c_Cpros
577:             .Top           = 117
578:             .Left          = 102
579:             .Width         = 108
580:             .Height        = 22
581:             .FontName      = "Tahoma"
582:             .FontSize      = 8
583:             .SpecialEffect = 1
584:             .MaxLength     = 14
585:             .Visible       = .T.
586:         ENDWITH
587: 
588:         *-- Descricao do Produto (getDpro: Top=117, Left=211, Width=290)
589:         loc_oPg.AddObject("txt_4c_Dpros", "TextBox")
590:         WITH loc_oPg.txt_4c_Dpros
591:             .Top           = 117
592:             .Left          = 211
593:             .Width         = 290
594:             .Height        = 22
595:             .FontName      = "Tahoma"
596:             .FontSize      = 8
597:             .SpecialEffect = 1
598:             .MaxLength     = 65
599:             .Visible       = .T.
600:         ENDWITH
601: 
602:         *-- Label "Barra:"
603:         loc_oPg.AddObject("lbl_4c_LbCbars", "Label")
604:         WITH loc_oPg.lbl_4c_LbCbars
605:             .Caption   = "Barra :"
606:             .Top       = 143
607:             .Left      = 595
608:             .Width     = 35
609:             .Height    = 15
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 619 a 642:
619:         loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
620:         WITH loc_oPg.txt_4c_Cbars
621:             .Value         = 0
622:             .Top           = 139
623:             .Left          = 633
624:             .Width         = 108
625:             .Height        = 23
626:             .FontName      = "Tahoma"
627:             .FontSize      = 8
628:             .SpecialEffect = 1
629:             .Visible       = .T.
630:         ENDWITH
631: 
632:         *-- Label "Grupo:"
633:         loc_oPg.AddObject("lbl_4c_LbCgrus", "Label")
634:         WITH loc_oPg.lbl_4c_LbCgrus
635:             .Caption   = "Grupo :"
636:             .Top       = 190
637:             .Left      = 62
638:             .Width     = 38
639:             .Height    = 15
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 648 a 657:
648:         *-- Codigo do Grupo (getCgru: Top=186, Left=102, Width=31, MaxLength=3)
649:         loc_oPg.AddObject("txt_4c_Cgrus", "TextBox")
650:         WITH loc_oPg.txt_4c_Cgrus
651:             .Top           = 186
652:             .Left          = 102
653:             .Width         = 31
654:             .Height        = 22
655:             .FontName      = "Tahoma"
656:             .FontSize      = 8
657:             .SpecialEffect = 1

*-- Linhas 664 a 689:
664:         *-- Descricao do Grupo (getDgru: Top=186, Left=134, Width=171, readonly)
665:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
666:         WITH loc_oPg.txt_4c_Dgrus
667:             .Top           = 186
668:             .Left          = 134
669:             .Width         = 171
670:             .Height        = 22
671:             .FontName      = "Tahoma"
672:             .FontSize      = 8
673:             .SpecialEffect = 1
674:             .ReadOnly      = .T.
675:             .BackColor     = RGB(240, 240, 240)
676:             .Visible       = .T.
677:         ENDWITH
678: 
679:         *-- Label "Subgrupo:"
680:         loc_oPg.AddObject("lbl_4c_LbSGrus", "Label")
681:         WITH loc_oPg.lbl_4c_LbSGrus
682:             .Caption   = "Subgrupo :"
683:             .Top       = 213
684:             .Left      = 45
685:             .Width     = 55
686:             .Height    = 15
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 695 a 704:
695:         *-- Codigo do Sub-grupo (GetCSGru: Top=209, Left=102, Width=52, MaxLength=6)
696:         loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
697:         WITH loc_oPg.txt_4c_SGrus
698:             .Top           = 209
699:             .Left          = 102
700:             .Width         = 52
701:             .Height        = 22
702:             .FontName      = "Tahoma"
703:             .FontSize      = 8
704:             .SpecialEffect = 1

*-- Linhas 710 a 735:
710:         *-- Descricao do Sub-grupo (GetDsGru: Top=209, Left=155, Width=150, readonly)
711:         loc_oPg.AddObject("txt_4c_DsGrus", "TextBox")
712:         WITH loc_oPg.txt_4c_DsGrus
713:             .Top           = 209
714:             .Left          = 155
715:             .Width         = 150
716:             .Height        = 22
717:             .FontName      = "Tahoma"
718:             .FontSize      = 8
719:             .SpecialEffect = 1
720:             .ReadOnly      = .T.
721:             .BackColor     = RGB(240, 240, 240)
722:             .Visible       = .T.
723:         ENDWITH
724: 
725:         *-- Label "Linha:"
726:         loc_oPg.AddObject("lbl_4c_LbLinhas", "Label")
727:         WITH loc_oPg.lbl_4c_LbLinhas
728:             .Caption   = "Linha :"
729:             .Top       = 236
730:             .Left      = 66
731:             .Width     = 34
732:             .Height    = 15
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 741 a 750:
741:         *-- Codigo da Linha (GetLin: Top=232, Left=102, Width=80)
742:         loc_oPg.AddObject("txt_4c_Linhas", "TextBox")
743:         WITH loc_oPg.txt_4c_Linhas
744:             .Top           = 232
745:             .Left          = 102
746:             .Width         = 80
747:             .Height        = 22
748:             .FontName      = "Tahoma"
749:             .FontSize      = 8
750:             .SpecialEffect = 1

*-- Linhas 756 a 781:
756:         *-- Descricao da Linha (GetDLin: Top=232, Left=183, Width=196, readonly)
757:         loc_oPg.AddObject("txt_4c_DLinhas", "TextBox")
758:         WITH loc_oPg.txt_4c_DLinhas
759:             .Top           = 232
760:             .Left          = 183
761:             .Width         = 196
762:             .Height        = 22
763:             .FontName      = "Tahoma"
764:             .FontSize      = 8
765:             .SpecialEffect = 1
766:             .ReadOnly      = .T.
767:             .BackColor     = RGB(240, 240, 240)
768:             .Visible       = .T.
769:         ENDWITH
770: 
771:         *-- Label "Obs Pessoal:" (right column)
772:         loc_oPg.AddObject("lbl_4c_LbObspes", "Label")
773:         WITH loc_oPg.lbl_4c_LbObspes
774:             .Caption   = "Obs Pessoal :"
775:             .Top       = 239
776:             .Left      = 563
777:             .Width     = 67
778:             .Height    = 15
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 787 a 811:
787:         *-- Obs Pessoal (getObs1: Top=235, Left=633, Width=159, MaxLength=30)
788:         loc_oPg.AddObject("txt_4c_Obspes", "TextBox")
789:         WITH loc_oPg.txt_4c_Obspes
790:             .Top           = 235
791:             .Left          = 633
792:             .Width         = 159
793:             .Height        = 23
794:             .FontName      = "Tahoma"
795:             .FontSize      = 8
796:             .SpecialEffect = 1
797:             .MaxLength     = 30
798:             .Visible       = .T.
799:         ENDWITH
800: 
801:         *-- Label "Obs Pedidos:" (right column)
802:         loc_oPg.AddObject("lbl_4c_LbObspeds", "Label")
803:         WITH loc_oPg.lbl_4c_LbObspeds
804:             .Caption   = "Obs Pedidos :"
805:             .Top       = 263
806:             .Left      = 563
807:             .Width     = 67
808:             .Height    = 15
809:             .FontName  = "Tahoma"
810:             .FontSize  = 8
811:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 817 a 841:
817:         *-- Obs Pedidos (getObs2: Top=259, Left=633, Width=159, MaxLength=30)
818:         loc_oPg.AddObject("txt_4c_Obspeds", "TextBox")
819:         WITH loc_oPg.txt_4c_Obspeds
820:             .Top           = 259
821:             .Left          = 633
822:             .Width         = 159
823:             .Height        = 23
824:             .FontName      = "Tahoma"
825:             .FontSize      = 8
826:             .SpecialEffect = 1
827:             .MaxLength     = 30
828:             .Visible       = .T.
829:         ENDWITH
830: 
831:         *-- Label "Grupo de Venda:"
832:         loc_oPg.AddObject("lbl_4c_LbColecoes", "Label")
833:         WITH loc_oPg.lbl_4c_LbColecoes
834:             .Caption   = "Grupo de Venda :"
835:             .Top       = 258
836:             .Left      = 14
837:             .Width     = 86
838:             .Height    = 15
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 847 a 856:
847:         *-- Codigo Grupo de Venda/Colecao (GetCol: Top=255, Left=102, Width=80)
848:         loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
849:         WITH loc_oPg.txt_4c_Colecoes
850:             .Top           = 255
851:             .Left          = 102
852:             .Width         = 80
853:             .Height        = 22
854:             .FontName      = "Tahoma"
855:             .FontSize      = 8
856:             .SpecialEffect = 1

*-- Linhas 862 a 887:
862:         *-- Descricao Colecao (GetDCol: Top=255, Left=183, Width=318, readonly)
863:         loc_oPg.AddObject("txt_4c_DColecoes", "TextBox")
864:         WITH loc_oPg.txt_4c_DColecoes
865:             .Top           = 255
866:             .Left          = 183
867:             .Width         = 318
868:             .Height        = 22
869:             .FontName      = "Tahoma"
870:             .FontSize      = 8
871:             .SpecialEffect = 1
872:             .ReadOnly      = .T.
873:             .BackColor     = RGB(240, 240, 240)
874:             .Visible       = .T.
875:         ENDWITH
876: 
877:         *-- Label "Fornecedor:"
878:         loc_oPg.AddObject("lbl_4c_LbIfors", "Label")
879:         WITH loc_oPg.lbl_4c_LbIfors
880:             .Caption   = "Fornecedor :"
881:             .Top       = 305
882:             .Left      = 36
883:             .Width     = 64
884:             .Height    = 15
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 893 a 902:
893:         *-- Codigo Fornecedor (getIfor: Top=301, Left=102, Width=80, MaxLength=10)
894:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
895:         WITH loc_oPg.txt_4c_Ifors
896:             .Top           = 301
897:             .Left          = 102
898:             .Width         = 80
899:             .Height        = 22
900:             .FontName      = "Tahoma"
901:             .FontSize      = 8
902:             .SpecialEffect = 1

*-- Linhas 909 a 934:
909:         *-- Descricao Fornecedor (getDfor: Top=301, Left=183, Width=318, readonly)
910:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
911:         WITH loc_oPg.txt_4c_Dfors
912:             .Top           = 301
913:             .Left          = 183
914:             .Width         = 318
915:             .Height        = 22
916:             .FontName      = "Tahoma"
917:             .FontSize      = 8
918:             .SpecialEffect = 1
919:             .ReadOnly      = .T.
920:             .BackColor     = RGB(240, 240, 240)
921:             .Visible       = .T.
922:         ENDWITH
923: 
924:         *-- Label "Cor:"
925:         loc_oPg.AddObject("lbl_4c_LbCodCors", "Label")
926:         WITH loc_oPg.lbl_4c_LbCodCors
927:             .Caption   = "Cor :"
928:             .Top       = 328
929:             .Left      = 361
930:             .Width     = 25
931:             .Height    = 15
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8
934:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 940 a 965:
940:         *-- Codigo Cor (getCor: Top=324, Left=390, Width=38)
941:         loc_oPg.AddObject("txt_4c_CodCors", "TextBox")
942:         WITH loc_oPg.txt_4c_CodCors
943:             .Top           = 324
944:             .Left          = 390
945:             .Width         = 38
946:             .Height        = 22
947:             .FontName      = "Tahoma"
948:             .FontSize      = 8
949:             .SpecialEffect = 1
950:             .MaxLength     = 4
951:             .Visible       = .T.
952:         ENDWITH
953:         BINDEVENT(loc_oPg.txt_4c_CodCors, "KeyPress", THIS, "ValidarCodCors")
954: 
955:         *-- Label "Tam:"
956:         loc_oPg.AddObject("lbl_4c_LbCodTams", "Label")
957:         WITH loc_oPg.lbl_4c_LbCodTams
958:             .Caption   = "Tam:"
959:             .Top       = 328
960:             .Left      = 431
961:             .Width     = 30
962:             .Height    = 15
963:             .FontName  = "Tahoma"
964:             .FontSize  = 8
965:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 971 a 996:
971:         *-- Codigo Tamanho (getTam: Top=324, Left=463, Width=38)
972:         loc_oPg.AddObject("txt_4c_CodTams", "TextBox")
973:         WITH loc_oPg.txt_4c_CodTams
974:             .Top           = 324
975:             .Left          = 463
976:             .Width         = 38
977:             .Height        = 22
978:             .FontName      = "Tahoma"
979:             .FontSize      = 8
980:             .SpecialEffect = 1
981:             .MaxLength     = 4
982:             .Visible       = .T.
983:         ENDWITH
984:         BINDEVENT(loc_oPg.txt_4c_CodTams, "KeyPress", THIS, "ValidarCodTams")
985: 
986:         *-- Label "Ref. Fornecedor:"
987:         loc_oPg.AddObject("lbl_4c_LbReffs", "Label")
988:         WITH loc_oPg.lbl_4c_LbReffs
989:             .Caption   = "Ref. Fornecedor :"
990:             .Top       = 327
991:             .Left      = 12
992:             .Width     = 88
993:             .Height    = 15
994:             .FontName  = "Tahoma"
995:             .FontSize  = 8
996:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1002 a 1026:
1002:         *-- Ref. Fornecedor (getRefs: Top=324, Left=102, Width=221, MaxLength=40)
1003:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
1004:         WITH loc_oPg.txt_4c_Reffs
1005:             .Top           = 324
1006:             .Left          = 102
1007:             .Width         = 221
1008:             .Height        = 22
1009:             .FontName      = "Tahoma"
1010:             .FontSize      = 8
1011:             .SpecialEffect = 1
1012:             .MaxLength     = 40
1013:             .Visible       = .T.
1014:         ENDWITH
1015: 
1016:         *-- Label "Valor de Custo:"
1017:         loc_oPg.AddObject("lbl_4c_LbCustofs", "Label")
1018:         WITH loc_oPg.lbl_4c_LbCustofs
1019:             .Caption   = "Valor de Custo :"
1020:             .Top       = 311
1021:             .Left      = 551
1022:             .Width     = 79
1023:             .Height    = 15
1024:             .FontName  = "Tahoma"
1025:             .FontSize  = 8
1026:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1033 a 1073:
1033:         loc_oPg.AddObject("txt_4c_Custofs", "TextBox")
1034:         WITH loc_oPg.txt_4c_Custofs
1035:             .Value         = 0
1036:             .Top           = 307
1037:             .Left          = 633
1038:             .Width         = 127
1039:             .Height        = 23
1040:             .FontName      = "Tahoma"
1041:             .FontSize      = 8
1042:             .SpecialEffect = 1
1043:             .BackColor     = RGB(240, 240, 240)
1044:             .Visible       = .T.
1045:         ENDWITH
1046: 
1047:         *-- Moeda do Custo (getMctotal: Top=307, Left=761, Width=31, MaxLength=3)
1048:         loc_oPg.AddObject("txt_4c_MoeCusfs", "TextBox")
1049:         WITH loc_oPg.txt_4c_MoeCusfs
1050:             .Top           = 307
1051:             .Left          = 761
1052:             .Width         = 31
1053:             .Height        = 23
1054:             .FontName      = "Tahoma"
1055:             .FontSize      = 8
1056:             .SpecialEffect = 1
1057:             .MaxLength     = 3
1058:             .BackColor     = RGB(240, 240, 240)
1059:             .ReadOnly      = .T.
1060:             .Visible       = .T.
1061:         ENDWITH
1062: 
1063:         *-- Label "Valor de Venda:"
1064:         loc_oPg.AddObject("lbl_4c_LbPvens", "Label")
1065:         WITH loc_oPg.lbl_4c_LbPvens
1066:             .Caption   = "Valor de Venda :"
1067:             .Top       = 335
1068:             .Left      = 510
1069:             .Width     = 120
1070:             .Height    = 15
1071:             .FontName  = "Tahoma"
1072:             .FontSize  = 8
1073:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1081 a 1121:
1081:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
1082:         WITH loc_oPg.txt_4c_Pvens
1083:             .Value         = 0
1084:             .Top           = 331
1085:             .Left          = 633
1086:             .Width         = 127
1087:             .Height        = 23
1088:             .FontName      = "Tahoma"
1089:             .FontSize      = 8
1090:             .SpecialEffect = 1
1091:             .BackColor     = RGB(240, 240, 240)
1092:             .Visible       = .T.
1093:         ENDWITH
1094: 
1095:         *-- Moeda de Venda (getMpvenda: Top=331, Left=761, Width=31, MaxLength=3)
1096:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
1097:         WITH loc_oPg.txt_4c_Moevs
1098:             .Top           = 331
1099:             .Left          = 761
1100:             .Width         = 31
1101:             .Height        = 23
1102:             .FontName      = "Tahoma"
1103:             .FontSize      = 8
1104:             .SpecialEffect = 1
1105:             .MaxLength     = 3
1106:             .BackColor     = RGB(240, 240, 240)
1107:             .ReadOnly      = .T.
1108:             .Visible       = .T.
1109:         ENDWITH
1110: 
1111:         *-- Label "Fator de Venda:"
1112:         loc_oPg.AddObject("lbl_4c_LbFvendas", "Label")
1113:         WITH loc_oPg.lbl_4c_LbFvendas
1114:             .Caption   = "Fator de Venda :"
1115:             .Top       = 359
1116:             .Left      = 544
1117:             .Width     = 86
1118:             .Height    = 15
1119:             .FontName  = "Tahoma"
1120:             .FontSize  = 8
1121:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1128 a 1168:
1128:         loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
1129:         WITH loc_oPg.txt_4c_Fvendas
1130:             .Value         = 0
1131:             .Top           = 355
1132:             .Left          = 633
1133:             .Width         = 127
1134:             .Height        = 23
1135:             .FontName      = "Tahoma"
1136:             .FontSize      = 8
1137:             .SpecialEffect = 1
1138:             .BackColor     = RGB(240, 240, 240)
1139:             .Visible       = .T.
1140:         ENDWITH
1141: 
1142:         *-- Moeda do Fator (getMfvenda: Top=355, Left=761, Width=31, MaxLength=3)
1143:         loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
1144:         WITH loc_oPg.txt_4c_Moepvs
1145:             .Top           = 355
1146:             .Left          = 761
1147:             .Width         = 31
1148:             .Height        = 23
1149:             .FontName      = "Tahoma"
1150:             .FontSize      = 8
1151:             .SpecialEffect = 1
1152:             .MaxLength     = 3
1153:             .BackColor     = RGB(240, 240, 240)
1154:             .ReadOnly      = .T.
1155:             .Visible       = .T.
1156:         ENDWITH
1157: 
1158:         *-- Label "Acabamento:"
1159:         loc_oPg.AddObject("lbl_4c_LbCodAcbs", "Label")
1160:         WITH loc_oPg.lbl_4c_LbCodAcbs
1161:             .Caption   = "Acabamento :"
1162:             .Top       = 374
1163:             .Left      = 42
1164:             .Width     = 58
1165:             .Height    = 15
1166:             .FontName  = "Tahoma"
1167:             .FontSize  = 8
1168:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1174 a 1183:
1174:         *-- Codigo do Acabamento (get_codacb: Top=370, Left=102, Width=31)
1175:         loc_oPg.AddObject("txt_4c_CodAcbs", "TextBox")
1176:         WITH loc_oPg.txt_4c_CodAcbs
1177:             .Top           = 370
1178:             .Left          = 102
1179:             .Width         = 31
1180:             .Height        = 22
1181:             .FontName      = "Tahoma"
1182:             .FontSize      = 8
1183:             .SpecialEffect = 1

*-- Linhas 1190 a 1215:
1190:         *-- Descricao do Acabamento (get_Dacb: Top=370, Left=134, Width=150, readonly)
1191:         loc_oPg.AddObject("txt_4c_DAcbs", "TextBox")
1192:         WITH loc_oPg.txt_4c_DAcbs
1193:             .Top           = 370
1194:             .Left          = 134
1195:             .Width         = 150
1196:             .Height        = 22
1197:             .FontName      = "Tahoma"
1198:             .FontSize      = 8
1199:             .SpecialEffect = 1
1200:             .ReadOnly      = .T.
1201:             .BackColor     = RGB(240, 240, 240)
1202:             .Visible       = .T.
1203:         ENDWITH
1204: 
1205:         *-- Label "Unidades (1):"
1206:         loc_oPg.AddObject("lbl_4c_LbCunis", "Label")
1207:         WITH loc_oPg.lbl_4c_LbCunis
1208:             .Caption   = "Unidades (1) :"
1209:             .Top       = 420
1210:             .Left      = 30
1211:             .Width     = 70
1212:             .Height    = 15
1213:             .FontName  = "Tahoma"
1214:             .FontSize  = 8
1215:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1221 a 1230:
1221:         *-- Unidade de Medida (Get_Cuni: Top=416, Left=102, Width=31, MaxLength=3)
1222:         loc_oPg.AddObject("txt_4c_Cunis", "TextBox")
1223:         WITH loc_oPg.txt_4c_Cunis
1224:             .Top           = 416
1225:             .Left          = 102
1226:             .Width         = 31
1227:             .Height        = 22
1228:             .FontName      = "Tahoma"
1229:             .FontSize      = 8
1230:             .SpecialEffect = 1

*-- Linhas 1236 a 1261:
1236:         *-- Descricao da Unidade (Get_Duni: Top=416, Left=134, Width=150, readonly)
1237:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1238:         WITH loc_oPg.txt_4c_Dunis
1239:             .Top           = 416
1240:             .Left          = 134
1241:             .Width         = 150
1242:             .Height        = 22
1243:             .FontName      = "Tahoma"
1244:             .FontSize      = 8
1245:             .SpecialEffect = 1
1246:             .ReadOnly      = .T.
1247:             .BackColor     = RGB(240, 240, 240)
1248:             .Visible       = .T.
1249:         ENDWITH
1250: 
1251:         *-- Label "Data / Usuario"
1252:         loc_oPg.AddObject("lbl_4c_LbDtIncs", "Label")
1253:         WITH loc_oPg.lbl_4c_LbDtIncs
1254:             .Caption   = "Data / Usu" + CHR(225) + "rio"
1255:             .Top       = 420
1256:             .Left      = 827
1257:             .Width     = 84
1258:             .Height    = 15
1259:             .FontName  = "Tahoma"
1260:             .FontBold  = .T.
1261:             .FontSize  = 8

*-- Linhas 1269 a 1278:
1269:         loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
1270:         WITH loc_oPg.txt_4c_DtIncs
1271:             .Value         = {}
1272:             .Top           = 437
1273:             .Left          = 827
1274:             .Width         = 79
1275:             .Height        = 23
1276:             .FontName      = "Tahoma"
1277:             .FontSize      = 8
1278:             .SpecialEffect = 1

*-- Linhas 1286 a 1295:
1286:         loc_oPg.AddObject("txt_4c_DtAlts", "TextBox")
1287:         WITH loc_oPg.txt_4c_DtAlts
1288:             .Value         = {}
1289:             .Top           = 437
1290:             .Left          = 907
1291:             .Width         = 79
1292:             .Height        = 23
1293:             .FontName      = "Tahoma"
1294:             .FontSize      = 8
1295:             .SpecialEffect = 1

*-- Linhas 1304 a 1316:
1304:     * ConfigurarPgDadosInfo - Configura label descritivo em aba do pgf_4c_Dados
1305:     *===========================================================================
1306:     PROTECTED PROCEDURE ConfigurarPgDadosInfo(par_oPg, par_cConteudo)
1307:         par_oPg.AddObject("lbl_4c_StubInfo", "Label")
1308:         WITH par_oPg.lbl_4c_StubInfo
1309:             .Caption   = par_cConteudo
1310:             .Top       = 50
1311:             .Left      = 30
1312:             .Width     = 600
1313:             .Height    = 30
1314:             .FontName  = "Tahoma"
1315:             .FontSize  = 10
1316:             .FontBold  = .F.

*-- Linhas 1390 a 1404:
1390:                 loc_oGrid.Column7.Width = 40
1391: 
1392:                 *-- Headers APOS RecordSource (RecordSource reseta captions)
1393:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1394:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1395:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1396:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."
1397:                 loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
1398:                 loc_oGrid.Column6.Header1.Caption = "Grp"
1399:                 loc_oGrid.Column7.Header1.Caption = "I"
1400: 
1401:                 *-- ReadOnly em todas as colunas (grade de consulta)
1402:                 loc_oGrid.Column1.ReadOnly = .T.
1403:                 loc_oGrid.Column2.ReadOnly = .T.
1404:                 loc_oGrid.Column3.ReadOnly = .T.

*-- Linhas 1701 a 1739:
1701:                 .txt_4c_CodTams.Enabled  = par_lHabilitar
1702:                 .txt_4c_CodAcbs.Enabled  = par_lHabilitar
1703:                 .txt_4c_Cunis.Enabled    = par_lHabilitar
1704:             ENDWITH
1705: 
1706:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
1707:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1708:                     .cmd_4c_Salvar.Enabled = par_lHabilitar
1709:                     .Visible     = .T.
1710:                 ENDWITH
1711:             ENDIF
1712: 
1713:         CATCH TO loException
1714:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
1715:                 "FormProduto.HabilitarCampos")
1716:         ENDTRY
1717:     ENDPROC
1718: 
1719:     *===========================================================================
1720:     * AjustarBotoesPorModo - Ajusta botoes por modo atual
1721:     *===========================================================================
1722:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1723:         LOCAL loc_lEhLista
1724:         loc_lEhLista = (THIS.this_cModoAtual == "LISTA")
1725: 
1726:         TRY
1727:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1728:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1729:                     IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1730:                         .cmd_4c_Incluir.Enabled   = loc_lEhLista
1731:                         .cmd_4c_Alterar.Enabled   = loc_lEhLista
1732:                         .cmd_4c_Excluir.Enabled   = loc_lEhLista
1733:                         .cmd_4c_Visualizar.Enabled = loc_lEhLista
1734:                         .cmd_4c_Buscar.Enabled    = loc_lEhLista
1735:                     ENDIF
1736:                     .Visible     = .T.
1737:                 ENDWITH
1738:             ENDIF
1739:         CATCH TO loException

