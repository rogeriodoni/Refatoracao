# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVIS.Pagina.Lista): Top original=96 vs migrado 'lbl_4c_Label1' Top=194 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVIS.Pagina.Lista): Left original=39 vs migrado 'lbl_4c_Label1' Left=278 (diff=239px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDVIS.Pagina.Lista): Top original=95 vs migrado 'lbl_4c_Label2' Top=250 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDVIS.Pagina.Lista): Left original=446 vs migrado 'lbl_4c_Label2' Left=278 (diff=168px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDVIS.Pagina.Lista): Top original=114 vs migrado 'lbl_4c_Label3' Top=222 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDVIS.Pagina.Lista): Left original=530 vs migrado 'lbl_4c_Label3' Left=235 (diff=295px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormVis.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1533 linhas total):

*-- Linhas 47 a 58:
47:                     "FormVis.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Visible = .T.
55:                 THIS.pgf_4c_Paginas.ActivePage = 1
56:                 THIS.this_cModoAtual = "LISTA"
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

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

*-- Linhas 116 a 153:
116:         *-- Original: Top=1. Com compensacao +29: Top=31
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .ForeColor = RGB(0, 0, 0)
139:             .BackStyle = 0
140:             .AutoSize  = .F.
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.

*-- Linhas 161 a 185:
161:         *-- Canonico: Left=542, Top=29, Width=390, Height=85
162:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163:         WITH loc_oPagina.cnt_4c_Botoes
164:             .Top         = 29
165:             .Left        = 542
166:             .Width       = 390
167:             .Height      = 85
168:             .BackStyle   = 0
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         *-- Botao Incluir (Left=5)
174:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
175:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
176:             .Caption         = "Incluir"
177:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:             .PicturePosition = 13
179:             .Top             = 5
180:             .Left            = 5
181:             .Width           = 75
182:             .Height          = 75
183:             .FontName        = "Tahoma"
184:             .FontBold        = .T.
185:             .FontItalic      = .T.

*-- Linhas 193 a 210:
193:             .AutoSize        = .F.
194:             .Visible         = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198:         *-- Botao Visualizar (Left=80)
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Tahoma"
209:             .FontBold        = .T.
210:             .FontItalic      = .T.

*-- Linhas 218 a 235:
218:             .AutoSize        = .F.
219:             .Visible         = .T.
220:         ENDWITH
221:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
222: 
223:         *-- Botao Alterar (Left=155)
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .FontName        = "Tahoma"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.

*-- Linhas 243 a 260:
243:             .AutoSize        = .F.
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248:         *-- Botao Excluir (Left=230)
249:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Top             = 5
255:             .Left            = 230
256:             .Width           = 75
257:             .Height          = 75
258:             .FontName        = "Tahoma"
259:             .FontBold        = .T.
260:             .FontItalic      = .T.

*-- Linhas 268 a 285:
268:             .AutoSize        = .F.
269:             .Visible         = .T.
270:         ENDWITH
271:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
272: 
273:         *-- Botao Buscar (Left=305)
274:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
275:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
276:             .Caption         = "Buscar"
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
278:             .PicturePosition = 13
279:             .Top             = 5
280:             .Left            = 305
281:             .Width           = 75
282:             .Height          = 75
283:             .FontName        = "Tahoma"
284:             .FontBold        = .T.
285:             .FontItalic      = .T.

*-- Linhas 293 a 322:
293:             .AutoSize        = .F.
294:             .Visible         = .T.
295:         ENDWITH
296:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado - CLAUDE.md regra #10)
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .FontName        = "Tahoma"
321:             .FontBold        = .T.
322:             .FontItalic      = .T.

*-- Linhas 330 a 348:
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid de listagem de visitas
336:         *-- Original: Grade.Top=145, Left=28, Width=940, Height=447. Compensacao PageFrame +29: Top=174
337:         *-- Width=880 (canonico): nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
338:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
339:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
340:         loc_oPagina.grd_4c_Lista.ColumnCount = 6
341:         WITH loc_oPagina.grd_4c_Lista
342:             .Top                = 174
343:             .Left               = 26
344:             .Width              = 880
345:             .Height             = 447
346:             .FontName           = "Verdana"
347:             .FontSize           = 8
348:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 375 a 412:
375:         *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
376:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
377:         WITH loc_oPagina.cnt_4c_Cabecalho
378:             .Top           = 29
379:             .Left          = 0
380:             .Width         = THIS.Width
381:             .Height        = 80
382:             .BackColor     = RGB(100, 100, 100)
383:             .BorderWidth   = 0
384:             .SpecialEffect = 0
385:             .Visible       = .T.
386: 
387:             .AddObject("lbl_4c_Sombra", "Label")
388:             WITH .lbl_4c_Sombra
389:                 .Caption   = THIS.Caption
390:                 .Top       = 15
391:                 .Left      = 10
392:                 .Width     = THIS.Width
393:                 .Height    = 40
394:                 .FontName  = "Tahoma"
395:                 .FontSize  = 16
396:                 .FontBold  = .T.
397:                 .ForeColor = RGB(0, 0, 0)
398:                 .BackStyle = 0
399:                 .AutoSize  = .F.
400:                 .Visible   = .T.
401:             ENDWITH
402: 
403:             .AddObject("lbl_4c_Titulo", "Label")
404:             WITH .lbl_4c_Titulo
405:                 .Caption   = THIS.Caption
406:                 .Top       = 18
407:                 .Left      = 10
408:                 .Width     = THIS.Width
409:                 .Height    = 46
410:                 .FontName  = "Tahoma"
411:                 .FontSize  = 16
412:                 .FontBold  = .T.

*-- Linhas 418 a 430:
418:         ENDWITH
419: 
420:         *-- Label "Data :" (Label7 legado) - Top original 137 + compensacao PageFrame(+29) = 166
421:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
422:         WITH loc_oPagina.lbl_4c_Label7
423:             .Caption   = "Data :"
424:             .Top       = 166
425:             .Left      = 284
426:             .Width     = 32
427:             .Height    = 15
428:             .FontName  = "Tahoma"
429:             .FontSize  = 8
430:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 437 a 463:
437:         *-- TextBox Data (getData legado) - Top original 133 + 29 = 162
438:         loc_oPagina.AddObject("txt_4c_Data", "TextBox")
439:         WITH loc_oPagina.txt_4c_Data
440:             .Top             = 162
441:             .Left            = 318
442:             .Width           = 80
443:             .Height          = 23
444:             .FontName        = "Tahoma"
445:             .FontSize        = 8
446:             .ForeColor       = RGB(0, 0, 0)
447:             .BorderColor     = RGB(100, 100, 100)
448:             .SpecialEffect   = 1
449:             .Value           = {}
450:             .Visible         = .T.
451:         ENDWITH
452: 
453:         *-- Label "Grupo :" (Label1 legado) - Top original 165 + 29 = 194
454:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
455:         WITH loc_oPagina.lbl_4c_Label1
456:             .Caption   = "Grupo :"
457:             .Top       = 194
458:             .Left      = 278
459:             .Width     = 38
460:             .Height    = 15
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 471 a 480:
471:         *-- Top original 161 + 29 = 190
472:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
473:         WITH loc_oPagina.txt_4c_Grupo
474:             .Top               = 190
475:             .Left              = 318
476:             .Width             = 80
477:             .Height            = 23
478:             .FontName          = "Tahoma"
479:             .FontSize          = 8
480:             .ForeColor         = RGB(0, 0, 0)

*-- Linhas 486 a 498:
486:         ENDWITH
487: 
488:         *-- Label "Representante :" (Label3 legado) - Top original 193 + 29 = 222
489:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
490:         WITH loc_oPagina.lbl_4c_Label3
491:             .Caption   = "Representante :"
492:             .Top       = 222
493:             .Left      = 235
494:             .Width     = 81
495:             .Height    = 15
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 506 a 515:
506:         *-- Top original 189 + 29 = 218
507:         loc_oPagina.AddObject("txt_4c_CodCli", "TextBox")
508:         WITH loc_oPagina.txt_4c_CodCli
509:             .Top                = 218
510:             .Left               = 318
511:             .Width              = 80
512:             .Height             = 23
513:             .FontName           = "Tahoma"
514:             .FontSize           = 8
515:             .ForeColor          = RGB(0, 0, 0)

*-- Linhas 525 a 534:
525:         *-- Top original 189 + 29 = 218
526:         loc_oPagina.AddObject("txt_4c_DesCli", "TextBox")
527:         WITH loc_oPagina.txt_4c_DesCli
528:             .Top                = 218
529:             .Left               = 402
530:             .Width              = 360
531:             .Height             = 23
532:             .FontName           = "Tahoma"
533:             .FontSize           = 8
534:             .ForeColor          = RGB(0, 0, 0)

*-- Linhas 542 a 554:
542:         ENDWITH
543: 
544:         *-- Label "Conta :" (Label2 legado) - Top original 221 + 29 = 250
545:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
546:         WITH loc_oPagina.lbl_4c_Label2
547:             .Caption   = "Conta :"
548:             .Top       = 250
549:             .Left      = 278
550:             .Width     = 38
551:             .Height    = 15
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 561 a 570:
561:         *-- TextBox Codigo Conta (getCodCta legado) - Top original 217 + 29 = 246
562:         loc_oPagina.AddObject("txt_4c_CodCta", "TextBox")
563:         WITH loc_oPagina.txt_4c_CodCta
564:             .Top             = 246
565:             .Left            = 318
566:             .Width           = 80
567:             .Height          = 23
568:             .FontName        = "Tahoma"
569:             .FontSize        = 8
570:             .ForeColor       = RGB(0, 0, 0)

*-- Linhas 578 a 604:
578:         *-- Top original 217 + 29 = 246
579:         loc_oPagina.AddObject("txt_4c_DesCta", "TextBox")
580:         WITH loc_oPagina.txt_4c_DesCta
581:             .Top             = 246
582:             .Left            = 402
583:             .Width           = 360
584:             .Height          = 23
585:             .FontName        = "Tahoma"
586:             .FontSize        = 8
587:             .ForeColor       = RGB(0, 0, 0)
588:             .BorderColor     = RGB(100, 100, 100)
589:             .SpecialEffect   = 1
590:             .Value           = ""
591:             .Visible         = .T.
592:         ENDWITH
593: 
594:         *-- Label "Vendas :" (Label4 legado) - Top original 249 + 29 = 278
595:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
596:         WITH loc_oPagina.lbl_4c_Label4
597:             .Caption   = "Vendas :"
598:             .Top       = 278
599:             .Left      = 272
600:             .Width     = 44
601:             .Height    = 15
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 613 a 658:
613:         loc_oPagina.AddObject("opt_4c_Vendas", "OptionGroup")
614:         WITH loc_oPagina.opt_4c_Vendas
615:             .ButtonCount = 2
616:             .Top         = 272
617:             .Left        = 314
618:             .Width       = 92
619:             .Height      = 27
620:             .BackStyle   = 0
621:             .BorderStyle = 0
622:             .Value       = 2
623:             .Visible     = .T.
624:             WITH .Buttons(1)
625:                 .Caption   = "Sim"
626:                 .Left      = 5
627:                 .Top       = 5
628:                 .Width     = 40
629:                 .Height    = 17
630:                 .AutoSize  = .F.
631:                 .BackStyle = 0
632:                 .ForeColor = RGB(90, 90, 90)
633:             ENDWITH
634:             WITH .Buttons(2)
635:                 .Caption   = "N" + CHR(227) + "o"
636:                 .Left      = 47
637:                 .Top       = 5
638:                 .Width     = 40
639:                 .Height    = 17
640:                 .AutoSize  = .F.
641:                 .FontName  = "Tahoma"
642:                 .FontSize  = 8
643:                 .BackStyle = 0
644:                 .ForeColor = RGB(90, 90, 90)
645:             ENDWITH
646:         ENDWITH
647: 
648:         *-- Label "Pedidos :" (Label5 legado) - Top original 275 + 29 = 304
649:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
650:         WITH loc_oPagina.lbl_4c_Label5
651:             .Caption   = "Pedidos :"
652:             .Top       = 304
653:             .Left      = 270
654:             .Width     = 46
655:             .Height    = 15
656:             .FontName  = "Tahoma"
657:             .FontSize  = 8
658:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 667 a 712:
667:         loc_oPagina.AddObject("opt_4c_Pedidos", "OptionGroup")
668:         WITH loc_oPagina.opt_4c_Pedidos
669:             .ButtonCount = 2
670:             .Top         = 298
671:             .Left        = 314
672:             .Width       = 92
673:             .Height      = 27
674:             .BackStyle   = 0
675:             .BorderStyle = 0
676:             .Value       = 2
677:             .Visible     = .T.
678:             WITH .Buttons(1)
679:                 .Caption   = "Sim"
680:                 .Left      = 5
681:                 .Top       = 5
682:                 .Width     = 40
683:                 .Height    = 17
684:                 .AutoSize  = .F.
685:                 .BackStyle = 0
686:                 .ForeColor = RGB(90, 90, 90)
687:             ENDWITH
688:             WITH .Buttons(2)
689:                 .Caption   = "N" + CHR(227) + "o"
690:                 .Left      = 47
691:                 .Top       = 5
692:                 .Width     = 40
693:                 .Height    = 17
694:                 .AutoSize  = .F.
695:                 .FontName  = "Tahoma"
696:                 .FontSize  = 8
697:                 .BackStyle = 0
698:                 .ForeColor = RGB(90, 90, 90)
699:             ENDWITH
700:         ENDWITH
701: 
702:         *-- Label "Observacao :" (Label6 legado) - Top original 302 + 29 = 331
703:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
704:         WITH loc_oPagina.lbl_4c_Label6
705:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
706:             .Top       = 331
707:             .Left      = 249
708:             .Width     = 67
709:             .Height    = 15
710:             .FontName  = "Tahoma"
711:             .FontSize  = 8
712:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 719 a 728:
719:         *-- EditBox Observacao (edtObs legado) - Top original 302 + 29 = 331
720:         loc_oPagina.AddObject("edt_4c_Obs", "EditBox")
721:         WITH loc_oPagina.edt_4c_Obs
722:             .Top           = 331
723:             .Left          = 317
724:             .Width         = 446
725:             .Height        = 109
726:             .FontName      = "Tahoma"
727:             .FontSize      = 8
728:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 736 a 761:
736:         *-- Canonico: Top=33, Left=842, Width=160, Height=85
737:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
738:         WITH loc_oPagina.cnt_4c_BotoesAcao
739:             .Top         = 33
740:             .Left        = 842
741:             .Width       = 160
742:             .Height      = 85
743:             .BackStyle = 0
744:             .BackColor   = RGB(255, 255, 255)
745:             .BorderWidth = 0
746:             .Visible     = .T.
747:         ENDWITH
748: 
749:         *-- Botao Confirmar (Salva legado)
750:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
751:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
752:             .Caption         = "Confirmar"
753:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
754:             .PicturePosition = 13
755:             .Top             = 5
756:             .Left            = 5
757:             .Width           = 75
758:             .Height          = 75
759:             .FontName        = "Tahoma"
760:             .FontBold        = .T.
761:             .FontItalic      = .T.

*-- Linhas 769 a 786:
769:             .AutoSize        = .F.
770:             .Visible         = .T.
771:         ENDWITH
772:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
773: 
774:         *-- Botao Cancelar
775:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
776:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
777:             .Caption         = "Encerrar"
778:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
779:             .PicturePosition = 13
780:             .Top             = 5
781:             .Left            = 80
782:             .Width           = 75
783:             .Height          = 75
784:             .FontName        = "Tahoma"
785:             .FontBold        = .T.
786:             .FontItalic      = .T.

*-- Linhas 794 a 802:
794:             .AutoSize        = .F.
795:             .Visible         = .T.
796:         ENDWITH
797:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
798: 
799:         *-- Lookups (F4/DblClick) - Representante (Codigo/Nome) e Conta (Codigo/Nome)
800:         *-- Original: getCodCli.Valid / getDesCli.Valid / getCodCta.Valid / getDesCta.Valid (fwBuscaExt em SigCdCli)
801:         BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress", THIS, "CodCliKeyPress")
802:         BINDEVENT(loc_oPagina.txt_4c_CodCli, "DblClick", THIS, "CodCliDblClick")

*-- Linhas 846 a 859:
846:                 loc_oGrid.Column6.Width = 31
847: 
848:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
849:                 loc_oGrid.Column1.Header1.Caption = "Data"
850:                 loc_oGrid.Column2.Header1.Caption = "Representante"
851:                 loc_oGrid.Column3.Header1.Caption = "Conta"
852:                 loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                 loc_oGrid.Column5.Header1.Caption = "Venda"
854:                 loc_oGrid.Column6.Header1.Caption = "Pedido"
855: 
856:                 *-- Problema (a): popular cursor NAO repinta a grade sozinho
857:                 IF USED("cursor_4c_Dados")
858:                     GO TOP IN cursor_4c_Dados
859:                 ENDIF

*-- Linhas 1079 a 1093:
1079:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1080: 
1081:         WITH THIS.this_oBusinessObject
1082:             loc_oPagina.txt_4c_Data.Value    = .this_dData
1083:             loc_oPagina.txt_4c_Grupo.Value   = .this_cGrupo
1084:             loc_oPagina.txt_4c_CodCli.Value  = .this_cContas
1085:             loc_oPagina.txt_4c_CodCta.Value  = .this_cConta
1086:             loc_oPagina.opt_4c_Vendas.Value  = IIF(.this_nVendas = 1, 1, 2)
1087:             loc_oPagina.opt_4c_Pedidos.Value = IIF(.this_nPedidos = 1, 1, 2)
1088:             loc_oPagina.edt_4c_Obs.Value     = .this_cObservacao
1089:         ENDWITH
1090: 
1091:         *-- Descricoes (Nome do Representante/Conta) nao vem do BO (SELECT so em SigCdVis)
1092:         *-- Recarrega via lookup exato pelo codigo, espelhando SIGCDVIS.Pagina.Lista.Grupo_Op.Click
1093:         THIS.AtualizarDescricaoRepresentante()

*-- Linhas 1468 a 1477:
1468:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1469:         loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1470: 
1471:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
1472:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1473:     ENDPROC
1474: 
1475:     *===========================================================================
1476:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1477:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)


### BO (C:\4c\projeto\app\classes\VisBO.prg):
*====================================================================
* VisBO.prg
*
* Business Object para Cadastro de Visitas de Representantes
* Tabela: SigCdVis
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS VisBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdVis)
    this_cChave          = ""    && pkidchave char(20) - PK
    this_dData           = {}    && datas datetime
    this_cGrupo          = ""    && grupos char(10)
    this_cContas         = ""    && contas char(10) - codigo do representante
    this_cConta          = ""    && iclis char(10) - codigo da conta
    this_nVendas         = 0     && vendas numeric(1,0)
    this_nPedidos        = 0     && pedidos numeric(1,0)
    this_cObservacao     = ""    && obss text
    this_dDataAlteracao  = {}    && dtalts datetime

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdVis"
            THIS.this_cCampoChave = "pkidchave"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "VisBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave)
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
                THIS.this_cChave         = TratarNulo(pkidchave, "C")
                THIS.this_dData          = TratarNulo(datas,     "D")
                THIS.this_cGrupo         = TratarNulo(grupos,    "C")
                THIS.this_cContas        = TratarNulo(contas,    "C")
                THIS.this_cConta         = TratarNulo(iclis,     "C")
                THIS.this_nVendas        = TratarNulo(vendas,    "N")
                THIS.this_nPedidos       = TratarNulo(pedidos,   "N")
                THIS.this_cObservacao    = TratarNulo(obss,      "C")
                THIS.this_dDataAlteracao = TratarNulo(dtalts,    "D")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "VisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdVis
    * pkidchave (PK) eh gerada via fUniqueIds() - o legado faz
    * "replace pkidchave with fUniqueIds() ... in crSigCdVis" no INSERIR
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cChave))
                THIS.this_cChave = fUniqueIds()
            ENDIF

            THIS.this_dDataAlteracao = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdVis (pkidchave, datas, grupos, contas, iclis, vendas, pedidos, obss, dtalts)
                VALUES (
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<EscaparSQL(THIS.this_cConta)>>,
                    <<FormatarNumeroSQL(THIS.this_nVendas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPedidos, 0)>>,
                    <<EscaparSQL(THIS.this_cObservacao)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "VisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdVis
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDataAlteracao = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdVis
                SET datas    = <<FormatarDataSQL(THIS.this_dData)>>,
                    grupos   = <<EscaparSQL(THIS.this_cGrupo)>>,
                    contas   = <<EscaparSQL(THIS.this_cContas)>>,
                    iclis    = <<EscaparSQL(THIS.this_cConta)>>,
                    vendas   = <<FormatarNumeroSQL(THIS.this_nVendas, 0)>>,
                    pedidos  = <<FormatarNumeroSQL(THIS.this_nPedidos, 0)>>,
                    obss     = <<EscaparSQL(THIS.this_cObservacao)>>,
                    dtalts   = <<FormatarDataSQL(THIS.this_dDataAlteracao)>>
                WHERE pkidchave = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "VisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdVis
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdVis WHERE pkidchave = " + EscaparSQL(THIS.this_cChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "VisBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros para o Grid da Lista
    * Retorna cursor_4c_Dados com a.* (SigCdVis) + Descri (conta), Repr (representante),
    * DescVendas/DescPedidos (Sim/Nao) - espelha EXATAMENTE o AddCursor/pColuna do legado
    * (SigCdVis.Init, query lcQryVis)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkidchave C(20), Datas T, Grupos C(10), ;
                        Contas C(10), Iclis C(10), Vendas N(1,0), Pedidos N(1,0), Obss M, ;
                        Dtalts T, Descri C(40), Repr C(40), DescVendas C(3), DescPedidos C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.*, b.rclis AS Descri, c.rclis AS Repr," + ;
                    " CASE WHEN a.vendas = 1 THEN 'Sim' ELSE 'N" + CHR(227) + "o' END AS DescVendas," + ;
                    " CASE WHEN a.pedidos = 1 THEN 'Sim' ELSE 'N" + CHR(227) + "o' END AS DescPedidos" + ;
                    " FROM SigCdVis a" + ;
                    " INNER JOIN SigCdCli b ON a.iclis = b.iclis" + ;
                    " INNER JOIN SigCdCli c ON a.Contas = c.iclis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.pkidchave"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar visitas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "VisBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (pkidchave)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkidchave, datas, grupos, contas, iclis, vendas, pedidos, obss, dtalts" + ;
                " FROM SigCdVis WHERE pkidchave = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Visita n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "VisBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

