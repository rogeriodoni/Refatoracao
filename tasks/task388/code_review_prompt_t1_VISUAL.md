# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [ALINHAMENTO] Botao 'cmd_4c_Confirmar' tem Top=8 mas grupo usa Top=5 (diferenca de 3px)
- [ALINHAMENTO] Botao 'cmd_4c_Cancelar' tem Top=8 mas grupo usa Top=5 (diferenca de 3px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCTA.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (6072 linhas total):

*-- Linhas 47 a 56:
47:                     "FormCTA.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Visible = .T.
53:                 THIS.pgf_4c_Paginas.ActivePage = 1
54:                 THIS.this_cModoAtual = "LISTA"
55: 
56:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 78 a 97:
78: 
79:         WITH THIS.pgf_4c_Paginas
80:             .PageCount = 2
81:             .Top       = -29
82:             .Left      = 0
83:             .Width     = THIS.Width
84:             .Height    = THIS.Height + 29
85:             .Tabs      = .F.
86:             .Visible   = .T.
87: 
88:             .Page1.Caption   = "Lista"
89:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:             .Page1.BackColor = RGB(255, 255, 255)
91: 
92:             .Page2.Caption   = "Dados"
93:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page2.BackColor = RGB(255, 255, 255)
95:         ENDWITH
96: 
97:         THIS.ConfigurarPaginaLista()

*-- Linhas 109 a 146:
109:         *-- Cabecalho cinza (cntSombra legado Top=1 -> +29 = 30)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 30
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Caption   = THIS.Caption
124:             .Top       = 15
125:             .Left      = 10
126:             .Width     = 769
127:             .Height    = 40
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .AutoSize  = .F.
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Caption   = THIS.Caption
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = 769
143:             .Height    = 46
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.

*-- Linhas 153 a 177:
153:         *-- Botoes CRUD (Grupo_op Top=-1 -> +29 = 28; Left=543 canonico)
154:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:         WITH loc_oPagina.cnt_4c_Botoes
156:             .Top         = 28
157:             .Left        = 542
158:             .Width       = 385
159:             .Height      = 85
160:             .BackStyle   = 0
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         *-- Incluir (Left=5)
166:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
167:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
168:             .Caption         = "Incluir"
169:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
170:             .PicturePosition = 13
171:             .Top             = 5
172:             .Left            = 5
173:             .Width           = 75
174:             .Height          = 75
175:             .FontName        = "Tahoma"
176:             .FontBold        = .T.
177:             .FontItalic      = .T.

*-- Linhas 185 a 202:
185:             .AutoSize        = .F.
186:             .Visible         = .T.
187:         ENDWITH
188:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
189: 
190:         *-- Visualizar (Left=80)
191:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
193:             .Caption         = "Visualizar"
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
195:             .PicturePosition = 13
196:             .Top             = 5
197:             .Left            = 80
198:             .Width           = 75
199:             .Height          = 75
200:             .FontName        = "Tahoma"
201:             .FontBold        = .T.
202:             .FontItalic      = .T.

*-- Linhas 210 a 227:
210:             .AutoSize        = .F.
211:             .Visible         = .T.
212:         ENDWITH
213:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
214: 
215:         *-- Alterar (Left=155)
216:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
217:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
218:             .Caption         = "Alterar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:             .PicturePosition = 13
221:             .Top             = 5
222:             .Left            = 155
223:             .Width           = 75
224:             .Height          = 75
225:             .FontName        = "Tahoma"
226:             .FontBold        = .T.
227:             .FontItalic      = .T.

*-- Linhas 235 a 252:
235:             .AutoSize        = .F.
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         *-- Excluir (Left=230)
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 230
248:             .Width           = 75
249:             .Height          = 75
250:             .FontName        = "Tahoma"
251:             .FontBold        = .T.
252:             .FontItalic      = .T.

*-- Linhas 260 a 277:
260:             .AutoSize        = .F.
261:             .Visible         = .T.
262:         ENDWITH
263:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
264: 
265:         *-- Procurar/Buscar (Left=305)
266:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
267:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
268:             .Caption         = "Procurar"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
270:             .PicturePosition = 13
271:             .Top             = 5
272:             .Left            = 305
273:             .Width           = 75
274:             .Height          = 75
275:             .FontName        = "Tahoma"
276:             .FontBold        = .T.
277:             .FontItalic      = .T.

*-- Linhas 285 a 313:
285:             .AutoSize        = .F.
286:             .Visible         = .T.
287:         ENDWITH
288:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
289: 
290:         *-- Container Saida (canonico: Left=917, Width=90)
291:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
292:         WITH loc_oPagina.cnt_4c_Saida
293:             .Top         = 28
294:             .Left        = 917
295:             .Width       = 90
296:             .Height      = 85
297:             .BackStyle   = 0
298:             .BorderWidth = 0
299:             .Visible     = .T.
300:         ENDWITH
301: 
302:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
303:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
304:             .Caption         = "Encerrar"
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
306:             .PicturePosition = 13
307:             .Top             = 5
308:             .Left            = 5
309:             .Width           = 75
310:             .Height          = 75
311:             .FontName        = "Tahoma"
312:             .FontBold        = .T.
313:             .FontItalic      = .T.

*-- Linhas 321 a 348:
321:             .AutoSize        = .F.
322:             .Visible         = .T.
323:         ENDWITH
324:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
325: 
326:         *-- Container de Filtros (cntFiltros: Top=85+29=114, Left=30, W=599, H=49)
327:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
328:         WITH loc_oPagina.cnt_4c_Filtros
329:             .Top         = 114
330:             .Left        = 30
331:             .Width       = 599
332:             .Height      = 49
333:             .BackStyle   = 0
334:             .BorderWidth = 1
335:             .Visible     = .T.
336:         ENDWITH
337: 
338:         *-- Label Grupo de Contas
339:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label2", "Label")
340:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label2
341:             .Caption   = "\<Grupo de Contas"
342:             .Top       = 4
343:             .Left      = 7
344:             .Width     = 95
345:             .Height    = 15
346:             .FontName  = "Tahoma"
347:             .FontSize  = 8
348:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 354 a 363:
354:         *-- Grupo (codigo) - txt_4c_Grupo: Top=19, Left=7, Width=81
355:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Grupo", "TextBox")
356:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Grupo
357:             .Top           = 19
358:             .Left          = 7
359:             .Width         = 81
360:             .Height        = 25
361:             .FontName      = "Tahoma"
362:             .FontSize      = 8
363:             .SpecialEffect = 1

*-- Linhas 371 a 380:
371:         *-- Descricao Grupo - txt_4c_DGrupo: Top=19, Left=91, Width=290
372:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DGrupo", "TextBox")
373:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DGrupo
374:             .Top           = 19
375:             .Left          = 91
376:             .Width         = 290
377:             .Height        = 25
378:             .FontName      = "Tahoma"
379:             .FontSize      = 8
380:             .SpecialEffect = 1

*-- Linhas 387 a 399:
387:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoFiltroKeyPress")
388: 
389:         *-- Label Alterados entre
390:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label3", "Label")
391:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label3
392:             .Caption   = "Alterados entre"
393:             .Top       = 3
394:             .Left      = 402
395:             .Width     = 91
396:             .Height    = 15
397:             .FontName  = "Tahoma"
398:             .FontSize  = 8
399:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 405 a 414:
405:         *-- DtIni: Top=19, Left=402, Width=80
406:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
407:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
408:             .Top           = 19
409:             .Left          = 402
410:             .Width         = 80
411:             .Height        = 25
412:             .FontName      = "Tahoma"
413:             .FontSize      = 8
414:             .SpecialEffect = 1

*-- Linhas 421 a 433:
421:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni, "KeyPress", THIS, "TxtDtIniKeyPress")
422: 
423:         *-- Label ate
424:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label4", "Label")
425:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label4
426:             .Caption   = "at" + CHR(233)
427:             .Top       = 23
428:             .Left      = 486
429:             .Width     = 21
430:             .Height    = 15
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 439 a 448:
439:         *-- DtFim: Top=19, Left=512, Width=80
440:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFim", "TextBox")
441:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim
442:             .Top           = 19
443:             .Left          = 512
444:             .Width         = 80
445:             .Height        = 25
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8
448:             .SpecialEffect = 1

*-- Linhas 459 a 468:
459:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
460:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
461:         WITH loc_oPagina.grd_4c_Lista
462:             .Top                = 166
463:             .Left               = 30
464:             .Width              = 939
465:             .Height             = 454
466:             .FontName           = "Courier New"
467:             .FontSize           = 9
468:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 483 a 533:
483:             .Column1.Movable    = .F.
484:             .Column1.Resizable  = .F.
485:             .Column1.ReadOnly   = .T.
486:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
487:             .Column1.Header1.FontName  = "Tahoma"
488:             .Column1.Header1.FontSize  = 8
489:             .Column1.Header1.Alignment = 2
490: 
491:             *-- Coluna 2: Nome (Rclis) Width=514
492:             .Column2.Width      = 514
493:             .Column2.ColumnOrder = 2
494:             .Column2.Movable    = .F.
495:             .Column2.Resizable  = .F.
496:             .Column2.ReadOnly   = .T.
497:             .Column2.Header1.Caption   = "Nome"
498:             .Column2.Header1.FontName  = "Tahoma"
499:             .Column2.Header1.FontSize  = 8
500:             .Column2.Header1.Alignment = 2
501: 
502:             *-- Coluna 3: CPF/CNPJ (Cpfs) Width=150
503:             .Column3.Width      = 150
504:             .Column3.ColumnOrder = 3
505:             .Column3.Movable    = .F.
506:             .Column3.Resizable  = .F.
507:             .Column3.ReadOnly   = .T.
508:             .Column3.Header1.Caption   = "CPF / CNPJ"
509:             .Column3.Header1.FontName  = "Tahoma"
510:             .Column3.Header1.FontSize  = 8
511:             .Column3.Header1.Alignment = 2
512: 
513:             *-- Coluna 4: Ult.Compra (Ultcomps) Width=75
514:             .Column4.Width      = 75
515:             .Column4.Movable    = .F.
516:             .Column4.Resizable  = .F.
517:             .Column4.ReadOnly   = .T.
518:             .Column4.Header1.Caption   = CHR(218) + "lt.Compra"
519:             .Column4.Header1.FontName  = "Tahoma"
520:             .Column4.Header1.FontSize  = 8
521:             .Column4.Header1.Alignment = 2
522: 
523:             *-- Coluna 5: Alterado em (DtAlts) Width=75
524:             .Column5.Width      = 75
525:             .Column5.Movable    = .F.
526:             .Column5.Resizable  = .F.
527:             .Column5.ReadOnly   = .T.
528:             .Column5.Header1.Caption   = "Alterado em"
529:             .Column5.Header1.FontName  = "Tahoma"
530:             .Column5.Header1.FontSize  = 8
531:             .Column5.Header1.Alignment = 2
532:         ENDWITH
533:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

*-- Linhas 546 a 749:
546:         *-- Botoes Salvar/Cancelar (Grupo_Salva: Top=-7+29=22, Left=842)
547:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
548:         WITH loc_oPagina.cnt_4c_BotoesAcao
549:             .Top         = 22
550:             .Left        = 842
551:             .Width       = 163
552:             .Height      = 85
553:             .BackStyle = 0
554:             .BackColor   = RGB(255, 255, 255)
555:             .BorderWidth = 0
556:             .Visible     = .T.
557:         ENDWITH
558: 
559:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
560:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
561:             .Caption         = "Confirmar"
562:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
563:             .PicturePosition = 13
564:             .Top             = 8
565:             .Left            = 6
566:             .Width           = 75
567:             .Height          = 75
568:             .FontName        = "Tahoma"
569:             .FontBold        = .T.
570:             .FontItalic      = .T.
571:             .FontSize        = 8
572:             .ForeColor       = RGB(90, 90, 90)
573:             .BackColor       = RGB(255, 255, 255)
574:             .Themes          = .F.
575:             .SpecialEffect   = 0
576:             .MousePointer    = 15
577:             .WordWrap        = .T.
578:             .AutoSize        = .F.
579:             .Visible         = .T.
580:         ENDWITH
581:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
582: 
583:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
584:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
585:             .Caption         = "Encerrar"
586:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
587:             .PicturePosition = 13
588:             .Top             = 8
589:             .Left            = 81
590:             .Width           = 75
591:             .Height          = 75
592:             .FontName        = "Tahoma"
593:             .FontBold        = .T.
594:             .FontItalic      = .T.
595:             .FontSize        = 8
596:             .ForeColor       = RGB(90, 90, 90)
597:             .BackColor       = RGB(255, 255, 255)
598:             .Themes          = .F.
599:             .SpecialEffect   = 0
600:             .MousePointer    = 15
601:             .WordWrap        = .T.
602:             .AutoSize        = .F.
603:             .Visible         = .T.
604:         ENDWITH
605:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
606: 
607:         *-- OptionGroup para navegar entre 12 sub-paginas
608:         *-- (fwSelPagina1 Top=3+29=32, Left=1, Width=817, Height=75)
609:         loc_oPagina.AddObject("obj_4c_NavPaginas", "OptionGroup")
610:         loc_oPagina.obj_4c_NavPaginas.ButtonCount = 12
611:         WITH loc_oPagina.obj_4c_NavPaginas
612:             .Top         = 32
613:             .Left        = 1
614:             .Width       = 817
615:             .Height      = 75
616:             .Value       = 1
617:             .BackStyle   = 0
618:             .BorderStyle = 0
619:             .SpecialEffect = 0
620:             .Visible     = .T.
621: 
622:             WITH .Buttons(1)
623:                 .Caption   = "Principal"
624:                 .Top       = 0
625:                 .Left      = 0
626:                 .Width     = 65
627:                 .Height    = 75
628:                 .BackStyle = 0
629:                 .Value     = 0
630:             ENDWITH
631:             WITH .Buttons(2)
632:                 .Caption   = "Comercial"
633:                 .Top       = 0
634:                 .Left      = 65
635:                 .Width     = 65
636:                 .Height    = 75
637:                 .FontName  = "Tahoma"
638:                 .FontSize  = 7
639:                 .BackStyle = 0
640:                 .Value     = 0
641:             ENDWITH
642:             WITH .Buttons(3)
643:                 .Caption   = "Banc" + CHR(225) + "rios"
644:                 .Top       = 0
645:                 .Left      = 130
646:                 .Width     = 65
647:                 .Height    = 75
648:                 .FontName  = "Tahoma"
649:                 .FontSize  = 7
650:                 .BackStyle = 0
651:                 .Value     = 0
652:             ENDWITH
653:             WITH .Buttons(4)
654:                 .Caption   = "Follow-up"
655:                 .Top       = 0
656:                 .Left      = 195
657:                 .Width     = 65
658:                 .Height    = 75
659:                 .FontName  = "Tahoma"
660:                 .FontSize  = 7
661:                 .BackStyle = 0
662:                 .Value     = 0
663:             ENDWITH
664:             WITH .Buttons(5)
665:                 .Caption   = "Cta Corrente"
666:                 .Top       = 0
667:                 .Left      = 260
668:                 .Width     = 65
669:                 .Height    = 75
670:                 .FontName  = "Tahoma"
671:                 .FontSize  = 7
672:                 .BackStyle = 0
673:                 .Value     = 0
674:             ENDWITH
675:             WITH .Buttons(6)
676:                 .Caption   = "Fiscais"
677:                 .Top       = 0
678:                 .Left      = 325
679:                 .Width     = 65
680:                 .Height    = 75
681:                 .FontName  = "Tahoma"
682:                 .FontSize  = 7
683:                 .BackStyle = 0
684:                 .Value     = 0
685:             ENDWITH
686:             WITH .Buttons(7)
687:                 .Caption   = "Complemento"
688:                 .Top       = 0
689:                 .Left      = 390
690:                 .Width     = 65
691:                 .Height    = 75
692:                 .FontName  = "Tahoma"
693:                 .FontSize  = 7
694:                 .BackStyle = 0
695:                 .Value     = 0
696:             ENDWITH
697:             WITH .Buttons(8)
698:                 .Caption   = "Empresa"
699:                 .Top       = 0
700:                 .Left      = 455
701:                 .Width     = 65
702:                 .Height    = 75
703:                 .FontName  = "Tahoma"
704:                 .FontSize  = 7
705:                 .BackStyle = 0
706:                 .Value     = 0
707:             ENDWITH
708:             WITH .Buttons(9)
709:                 .Caption   = "Cont" + CHR(225) + "beis"
710:                 .Top       = 0
711:                 .Left      = 520
712:                 .Width     = 65
713:                 .Height    = 75
714:                 .FontName  = "Tahoma"
715:                 .FontSize  = 7
716:                 .BackStyle = 0
717:                 .Value     = 0
718:             ENDWITH
719:             WITH .Buttons(10)
720:                 .Caption   = "Cadastrais"
721:                 .Top       = 0
722:                 .Left      = 585
723:                 .Width     = 65
724:                 .Height    = 75
725:                 .FontName  = "Tahoma"
726:                 .FontSize  = 7
727:                 .BackStyle = 0
728:                 .Value     = 0
729:             ENDWITH
730:             WITH .Buttons(11)
731:                 .Caption   = "Caracter" + CHR(237) + "sticas"
732:                 .Top       = 0
733:                 .Left      = 650
734:                 .Width     = 65
735:                 .Height    = 75
736:                 .FontName  = "Tahoma"
737:                 .FontSize  = 7
738:                 .BackStyle = 0
739:                 .Value     = 0
740:             ENDWITH
741:             WITH .Buttons(12)
742:                 .Caption   = "Perfil"
743:                 .Top       = 0
744:                 .Left      = 715
745:                 .Width     = 65
746:                 .Height    = 75
747:                 .FontName  = "Tahoma"
748:                 .FontSize  = 7
749:                 .BackStyle = 0

*-- Linhas 790 a 1017:
790:         par_oPagina.AddObject("cnt_4c_Pg1", "Container")
791:         loc_oCnt = par_oPagina.cnt_4c_Pg1
792:         WITH loc_oCnt
793:             .Top         = 107
794:             .Left        = 0
795:             .Width       = 1000
796:             .Height      = 493
797:             .BackStyle   = 0
798:             .BorderWidth = 0
799:             .Visible     = .T.
800:         ENDWITH
801: 
802:         *-- Linha 1: Grupo + Codigo + InsMuns + Emissor
803:         loc_oCnt.AddObject("lbl_4c_LblGrupo", "Label")
804:         WITH loc_oCnt.lbl_4c_LblGrupo
805:             .Caption = "Grupo"
806:             .Top = 84
807:             .Left = 16
808:             .Width = 80
809:             .Height = 15
810:             .FontName = "Tahoma"
811:             .FontSize = 8
812:             .ForeColor = RGB(90, 90, 90)
813:             .BackStyle = 0
814:             .Visible = .T.
815:         ENDWITH
816: 
817:         loc_oCnt.AddObject("txt_4c_Grupos", "TextBox")
818:         WITH loc_oCnt.txt_4c_Grupos
819:             .Top = 99
820:             .Left = 16
821:             .Width = 80
822:             .Height = 23
823:             .FontName = "Tahoma"
824:             .FontSize = 8
825:             .SpecialEffect = 1
826:             .ForeColor = RGB(0, 0, 0)
827:             .BorderColor = RGB(100, 100, 100)
828:             .Value = ""
829:             .Visible = .T.
830:         ENDWITH
831:         BINDEVENT(loc_oCnt.txt_4c_Grupos, "KeyPress", THIS, "TxtGruposKeyPress")
832: 
833:         loc_oCnt.AddObject("lbl_4c_LblCodigo", "Label")
834:         WITH loc_oCnt.lbl_4c_LblCodigo
835:             .Caption = "C" + CHR(243) + "digo"
836:             .Top = 84
837:             .Left = 100
838:             .Width = 80
839:             .Height = 15
840:             .FontName = "Tahoma"
841:             .FontSize = 8
842:             .ForeColor = RGB(90, 90, 90)
843:             .BackStyle = 0
844:             .Visible = .T.
845:         ENDWITH
846: 
847:         loc_oCnt.AddObject("txt_4c_IClis", "TextBox")
848:         WITH loc_oCnt.txt_4c_IClis
849:             .Top = 99
850:             .Left = 100
851:             .Width = 80
852:             .Height = 23
853:             .FontName = "Tahoma"
854:             .FontSize = 8
855:             .SpecialEffect = 1
856:             .ForeColor = RGB(0, 0, 0)
857:             .BorderColor = RGB(100, 100, 100)
858:             .Value = ""
859:             .Visible = .T.
860:         ENDWITH
861: 
862:         *-- InsMuns
863:         loc_oCnt.AddObject("lbl_4c_LblInsMuns", "Label")
864:         WITH loc_oCnt.lbl_4c_LblInsMuns
865:             .Caption = "Ins.Municipal"
866:             .Top = 84
867:             .Left = 184
868:             .Width = 100
869:             .Height = 15
870:             .FontName = "Tahoma"
871:             .FontSize = 8
872:             .ForeColor = RGB(90, 90, 90)
873:             .BackStyle = 0
874:             .Visible = .T.
875:         ENDWITH
876:         loc_oCnt.AddObject("txt_4c_Inscmuns", "TextBox")
877:         WITH loc_oCnt.txt_4c_Inscmuns
878:             .Top = 99
879:             .Left = 184
880:             .Width = 140
881:             .Height = 23
882:             .FontName = "Tahoma"
883:             .FontSize = 8
884:             .SpecialEffect = 1
885:             .ForeColor = RGB(0, 0, 0)
886:             .BorderColor = RGB(100, 100, 100)
887:             .Value = ""
888:             .Visible = .T.
889:         ENDWITH
890: 
891:         *-- Situacao
892:         loc_oCnt.AddObject("lbl_4c_LblSituas", "Label")
893:         WITH loc_oCnt.lbl_4c_LblSituas
894:             .Caption = "Situa" + CHR(231) + CHR(227) + "o"
895:             .Top = 84
896:             .Left = 328
897:             .Width = 80
898:             .Height = 15
899:             .FontName = "Tahoma"
900:             .FontSize = 8
901:             .ForeColor = RGB(90, 90, 90)
902:             .BackStyle = 0
903:             .Visible = .T.
904:         ENDWITH
905:         loc_oCnt.AddObject("txt_4c_Situas", "TextBox")
906:         WITH loc_oCnt.txt_4c_Situas
907:             .Top = 99
908:             .Left = 328
909:             .Width = 50
910:             .Height = 23
911:             .FontName = "Tahoma"
912:             .FontSize = 8
913:             .SpecialEffect = 1
914:             .ForeColor = RGB(0, 0, 0)
915:             .BorderColor = RGB(100, 100, 100)
916:             .Value = ""
917:             .Visible = .T.
918:         ENDWITH
919: 
920:         *-- CPF/CNPJ (Cpfs)
921:         loc_oCnt.AddObject("lbl_4c_LblCpfs", "Label")
922:         WITH loc_oCnt.lbl_4c_LblCpfs
923:             .Caption = "CPF/CNPJ"
924:             .Top = 84
925:             .Left = 382
926:             .Width = 80
927:             .Height = 15
928:             .FontName = "Tahoma"
929:             .FontSize = 8
930:             .ForeColor = RGB(90, 90, 90)
931:             .BackStyle = 0
932:             .Visible = .T.
933:         ENDWITH
934:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
935:         WITH loc_oCnt.txt_4c_Cpfs
936:             .Top = 99
937:             .Left = 382
938:             .Width = 145
939:             .Height = 23
940:             .FontName = "Tahoma"
941:             .FontSize = 8
942:             .SpecialEffect = 1
943:             .ForeColor = RGB(0, 0, 0)
944:             .BorderColor = RGB(100, 100, 100)
945:             .Value = ""
946:             .Visible = .T.
947:         ENDWITH
948: 
949:         *-- RG (Rgs)
950:         loc_oCnt.AddObject("lbl_4c_LblRgs", "Label")
951:         WITH loc_oCnt.lbl_4c_LblRgs
952:             .Caption = "RG/IE"
953:             .Top = 84
954:             .Left = 531
955:             .Width = 80
956:             .Height = 15
957:             .FontName = "Tahoma"
958:             .FontSize = 8
959:             .ForeColor = RGB(90, 90, 90)
960:             .BackStyle = 0
961:             .Visible = .T.
962:         ENDWITH
963:         loc_oCnt.AddObject("txt_4c_Rgs", "TextBox")
964:         WITH loc_oCnt.txt_4c_Rgs
965:             .Top = 99
966:             .Left = 531
967:             .Width = 140
968:             .Height = 23
969:             .FontName = "Tahoma"
970:             .FontSize = 8
971:             .SpecialEffect = 1
972:             .ForeColor = RGB(0, 0, 0)
973:             .BorderColor = RGB(100, 100, 100)
974:             .Value = ""
975:             .Visible = .T.
976:         ENDWITH
977: 
978:         *-- Conta Inativa (CHKINATIVA)
979:         loc_oCnt.AddObject("chk_4c_Inativas", "CheckBox")
980:         WITH loc_oCnt.chk_4c_Inativas
981:             .Caption = "Conta Inativa"
982:             .Top = 88
983:             .Left = 795
984:             .Height = 23
985:             .Width = 120
986:             .FontName = "Tahoma"
987:             .FontSize = 8
988:             .ForeColor = RGB(90, 90, 90)
989:             .Alignment = 0
990:             .SpecialEffect = 1
991:             .Value = 0
992:             .Visible = .T.
993:         ENDWITH
994: 
995:         *-- Ultima Compra (GetUltCom Top=109, Left=898, W=88)
996:         loc_oCnt.AddObject("lbl_4c_LblUltcom", "Label")
997:         WITH loc_oCnt.lbl_4c_LblUltcom
998:             .Caption = CHR(218) + "lt.Compra"
999:             .Top = 94
1000:             .Left = 898
1001:             .Width = 88
1002:             .Height = 15
1003:             .FontName = "Tahoma"
1004:             .FontSize = 8
1005:             .ForeColor = RGB(90, 90, 90)
1006:             .BackStyle = 0
1007:             .Visible = .T.
1008:         ENDWITH
1009:         loc_oCnt.AddObject("txt_4c_Ultcomps", "TextBox")
1010:         WITH loc_oCnt.txt_4c_Ultcomps
1011:             .Top = 109
1012:             .Left = 898
1013:             .Width = 88
1014:             .Height = 23
1015:             .FontName = "Tahoma"
1016:             .FontBold = .T.
1017:             .FontSize = 8

*-- Linhas 1026 a 1050:
1026:         ENDWITH
1027: 
1028:         *-- Data Validade (getDtVals Top=136, Left=898)
1029:         loc_oCnt.AddObject("lbl_4c_LblDtvals", "Label")
1030:         WITH loc_oCnt.lbl_4c_LblDtvals
1031:             .Caption = "Dt.Val"
1032:             .Top = 121
1033:             .Left = 898
1034:             .Width = 50
1035:             .Height = 15
1036:             .FontName = "Tahoma"
1037:             .FontSize = 8
1038:             .ForeColor = RGB(90, 90, 90)
1039:             .BackStyle = 0
1040:             .Visible = .T.
1041:         ENDWITH
1042:         loc_oCnt.AddObject("txt_4c_Dtvals", "TextBox")
1043:         WITH loc_oCnt.txt_4c_Dtvals
1044:             .Top = 136
1045:             .Left = 898
1046:             .Width = 88
1047:             .Height = 23
1048:             .FontName = "Tahoma"
1049:             .FontBold = .T.
1050:             .FontSize = 8

*-- Linhas 1056 a 1152:
1056:         ENDWITH
1057: 
1058:         *-- Nome (GetNome Top=138, Left=16, Width=368)
1059:         loc_oCnt.AddObject("lbl_4c_LblNome", "Label")
1060:         WITH loc_oCnt.lbl_4c_LblNome
1061:             .Caption = "Nome / Raz" + CHR(227) + "o Social"
1062:             .Top = 123
1063:             .Left = 16
1064:             .Width = 150
1065:             .Height = 15
1066:             .FontName = "Tahoma"
1067:             .FontSize = 8
1068:             .ForeColor = RGB(90, 90, 90)
1069:             .BackStyle = 0
1070:             .Visible = .T.
1071:         ENDWITH
1072:         loc_oCnt.AddObject("txt_4c_Rclis", "TextBox")
1073:         WITH loc_oCnt.txt_4c_Rclis
1074:             .Top = 138
1075:             .Left = 16
1076:             .Width = 368
1077:             .Height = 23
1078:             .FontName = "Tahoma"
1079:             .FontSize = 8
1080:             .SpecialEffect = 1
1081:             .ForeColor = RGB(0, 0, 0)
1082:             .BorderColor = RGB(100, 100, 100)
1083:             .Value = ""
1084:             .Visible = .T.
1085:         ENDWITH
1086: 
1087:         *-- Razao (GetRazao Top=138, Left=393, Width=368)
1088:         loc_oCnt.AddObject("lbl_4c_LblRazaos", "Label")
1089:         WITH loc_oCnt.lbl_4c_LblRazaos
1090:             .Caption = "Raz" + CHR(227) + "o / Fantasia"
1091:             .Top = 123
1092:             .Left = 393
1093:             .Width = 150
1094:             .Height = 15
1095:             .FontName = "Tahoma"
1096:             .FontSize = 8
1097:             .ForeColor = RGB(90, 90, 90)
1098:             .BackStyle = 0
1099:             .Visible = .T.
1100:         ENDWITH
1101:         loc_oCnt.AddObject("txt_4c_Razaos", "TextBox")
1102:         WITH loc_oCnt.txt_4c_Razaos
1103:             .Top = 138
1104:             .Left = 393
1105:             .Width = 368
1106:             .Height = 23
1107:             .FontName = "Tahoma"
1108:             .FontSize = 8
1109:             .SpecialEffect = 1
1110:             .ForeColor = RGB(0, 0, 0)
1111:             .BorderColor = RGB(100, 100, 100)
1112:             .Value = ""
1113:             .Visible = .T.
1114:         ENDWITH
1115: 
1116:         *-- Fun~ao/Cargo (GetCodFun Top=177, Left=16 / GetDesFun Left=49, Width=229)
1117:         loc_oCnt.AddObject("lbl_4c_LblFuncao", "Label")
1118:         WITH loc_oCnt.lbl_4c_LblFuncao
1119:             .Caption = "Fun" + CHR(231) + CHR(227) + "o"
1120:             .Top = 162
1121:             .Left = 16
1122:             .Width = 60
1123:             .Height = 15
1124:             .FontName = "Tahoma"
1125:             .FontSize = 8
1126:             .ForeColor = RGB(90, 90, 90)
1127:             .BackStyle = 0
1128:             .Visible = .T.
1129:         ENDWITH
1130:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
1131:         WITH loc_oCnt.txt_4c_Codigos
1132:             .Top = 177
1133:             .Left = 16
1134:             .Width = 30
1135:             .Height = 23
1136:             .FontName = "Tahoma"
1137:             .FontSize = 8
1138:             .SpecialEffect = 1
1139:             .ForeColor = RGB(0, 0, 0)
1140:             .BorderColor = RGB(100, 100, 100)
1141:             .Value = ""
1142:             .Visible = .T.
1143:         ENDWITH
1144:         loc_oCnt.AddObject("txt_4c_Fpags", "TextBox")
1145:         WITH loc_oCnt.txt_4c_Fpags
1146:             .Top = 177
1147:             .Left = 49
1148:             .Width = 229
1149:             .Height = 23
1150:             .FontName = "Tahoma"
1151:             .FontSize = 8
1152:             .SpecialEffect = 1

*-- Linhas 1158 a 1182:
1158:         ENDWITH
1159: 
1160:         *-- Grupo Vendedor (Get_grupoven Top=177, Left=287)
1161:         loc_oCnt.AddObject("lbl_4c_LblGrupoven", "Label")
1162:         WITH loc_oCnt.lbl_4c_LblGrupoven
1163:             .Caption = "Gr.Vendedor"
1164:             .Top = 162
1165:             .Left = 287
1166:             .Width = 80
1167:             .Height = 15
1168:             .FontName = "Tahoma"
1169:             .FontSize = 8
1170:             .ForeColor = RGB(90, 90, 90)
1171:             .BackStyle = 0
1172:             .Visible = .T.
1173:         ENDWITH
1174:         loc_oCnt.AddObject("txt_4c_Grupovens", "TextBox")
1175:         WITH loc_oCnt.txt_4c_Grupovens
1176:             .Top = 177
1177:             .Left = 287
1178:             .Width = 80
1179:             .Height = 23
1180:             .FontName = "Tahoma"
1181:             .FontSize = 8
1182:             .SpecialEffect = 1

*-- Linhas 1190 a 1300:
1190:         *-- (shapes nao criados, apenas campos funcionais)
1191: 
1192:         *-- Nascimento/Sexo/Nacionalidade (Top=216 area)
1193:         loc_oCnt.AddObject("lbl_4c_LblNascs", "Label")
1194:         WITH loc_oCnt.lbl_4c_LblNascs
1195:             .Caption = "Nascimento"
1196:             .Top = 201
1197:             .Left = 16
1198:             .Width = 80
1199:             .Height = 15
1200:             .FontName = "Tahoma"
1201:             .FontSize = 8
1202:             .ForeColor = RGB(90, 90, 90)
1203:             .BackStyle = 0
1204:             .Visible = .T.
1205:         ENDWITH
1206:         loc_oCnt.AddObject("txt_4c_Nascs", "TextBox")
1207:         WITH loc_oCnt.txt_4c_Nascs
1208:             .Top = 216
1209:             .Left = 16
1210:             .Width = 80
1211:             .Height = 23
1212:             .FontName = "Tahoma"
1213:             .FontSize = 8
1214:             .SpecialEffect = 1
1215:             .ForeColor = RGB(0, 0, 0)
1216:             .BorderColor = RGB(100, 100, 100)
1217:             .Value = {}
1218:             .Visible = .T.
1219:         ENDWITH
1220: 
1221:         loc_oCnt.AddObject("lbl_4c_LblNacionals", "Label")
1222:         WITH loc_oCnt.lbl_4c_LblNacionals
1223:             .Caption = "Nacionalidade"
1224:             .Top = 201
1225:             .Left = 100
1226:             .Width = 90
1227:             .Height = 15
1228:             .FontName = "Tahoma"
1229:             .FontSize = 8
1230:             .ForeColor = RGB(90, 90, 90)
1231:             .BackStyle = 0
1232:             .Visible = .T.
1233:         ENDWITH
1234:         loc_oCnt.AddObject("txt_4c_Nacionals", "TextBox")
1235:         WITH loc_oCnt.txt_4c_Nacionals
1236:             .Top = 216
1237:             .Left = 100
1238:             .Width = 183
1239:             .Height = 23
1240:             .FontName = "Tahoma"
1241:             .FontSize = 8
1242:             .SpecialEffect = 1
1243:             .ForeColor = RGB(0, 0, 0)
1244:             .BorderColor = RGB(100, 100, 100)
1245:             .Value = ""
1246:             .Visible = .T.
1247:         ENDWITH
1248: 
1249:         *-- Sexo
1250:         loc_oCnt.AddObject("lbl_4c_LblSexos", "Label")
1251:         WITH loc_oCnt.lbl_4c_LblSexos
1252:             .Caption = "Sexo"
1253:             .Top = 201
1254:             .Left = 287
1255:             .Width = 40
1256:             .Height = 15
1257:             .FontName = "Tahoma"
1258:             .FontSize = 8
1259:             .ForeColor = RGB(90, 90, 90)
1260:             .BackStyle = 0
1261:             .Visible = .T.
1262:         ENDWITH
1263:         loc_oCnt.AddObject("txt_4c_Sexos", "TextBox")
1264:         WITH loc_oCnt.txt_4c_Sexos
1265:             .Top = 216
1266:             .Left = 287
1267:             .Width = 40
1268:             .Height = 23
1269:             .FontName = "Tahoma"
1270:             .FontSize = 8
1271:             .SpecialEffect = 1
1272:             .ForeColor = RGB(0, 0, 0)
1273:             .BorderColor = RGB(100, 100, 100)
1274:             .Value = ""
1275:             .Visible = .T.
1276:         ENDWITH
1277: 
1278:         *-- Estado Civil (cmbEstcivils Top=216, Left=413, Width=166)
1279:         loc_oCnt.AddObject("lbl_4c_LblEstcivils", "Label")
1280:         WITH loc_oCnt.lbl_4c_LblEstcivils
1281:             .Caption = "Estado Civil"
1282:             .Top = 201
1283:             .Left = 413
1284:             .Width = 80
1285:             .Height = 15
1286:             .FontName = "Tahoma"
1287:             .FontSize = 8
1288:             .ForeColor = RGB(90, 90, 90)
1289:             .BackStyle = 0
1290:             .Visible = .T.
1291:         ENDWITH
1292:         loc_oCnt.AddObject("cmb_4c_Estcivils", "ComboBox")
1293:         WITH loc_oCnt.cmb_4c_Estcivils
1294:             .Top = 216
1295:             .Left = 413
1296:             .Width = 166
1297:             .Height = 23
1298:             .FontName = "Tahoma"
1299:             .FontSize = 8
1300:             .SpecialEffect = 1

*-- Linhas 1308 a 1332:
1308:         ENDWITH
1309: 
1310:         *-- Conjuge (Top=241)
1311:         loc_oCnt.AddObject("lbl_4c_LblConjuges", "Label")
1312:         WITH loc_oCnt.lbl_4c_LblConjuges
1313:             .Caption = "Nome / C" + CHR(244) + "njuge"
1314:             .Top = 241
1315:             .Left = 16
1316:             .Width = 100
1317:             .Height = 15
1318:             .FontName = "Tahoma"
1319:             .FontSize = 8
1320:             .ForeColor = RGB(90, 90, 90)
1321:             .BackStyle = 0
1322:             .Visible = .T.
1323:         ENDWITH
1324:         loc_oCnt.AddObject("txt_4c_Conjuges", "TextBox")
1325:         WITH loc_oCnt.txt_4c_Conjuges
1326:             .Top = 256
1327:             .Left = 16
1328:             .Width = 393
1329:             .Height = 23
1330:             .FontName = "Tahoma"
1331:             .FontSize = 8
1332:             .SpecialEffect = 1

*-- Linhas 1339 a 1348:
1339:         *-- CPF Conjuge (getCpf2 Top=256, Left=413)
1340:         loc_oCnt.AddObject("txt_4c_Cpfcs", "TextBox")
1341:         WITH loc_oCnt.txt_4c_Cpfcs
1342:             .Top = 256
1343:             .Left = 413
1344:             .Width = 142
1345:             .Height = 23
1346:             .FontName = "Tahoma"
1347:             .FontSize = 8
1348:             .SpecialEffect = 1

*-- Linhas 1355 a 1364:
1355:         *-- RG Conjuge (getRG2 Top=256, Left=563)
1356:         loc_oCnt.AddObject("txt_4c_Rgconjuges", "TextBox")
1357:         WITH loc_oCnt.txt_4c_Rgconjuges
1358:             .Top = 256
1359:             .Left = 563
1360:             .Width = 151
1361:             .Height = 23
1362:             .FontName = "Tahoma"
1363:             .FontSize = 8
1364:             .SpecialEffect = 1

*-- Linhas 1371 a 1380:
1371:         *-- ID conta (Get_Idconta Top=256, Left=723)
1372:         loc_oCnt.AddObject("txt_4c_Idcontas", "TextBox")
1373:         WITH loc_oCnt.txt_4c_Idcontas
1374:             .Top = 256
1375:             .Left = 723
1376:             .Width = 60
1377:             .Height = 23
1378:             .FontName = "Tahoma"
1379:             .FontSize = 8
1380:             .SpecialEffect = 1

*-- Linhas 1386 a 1636:
1386:         ENDWITH
1387: 
1388:         *-- CEP + Pais + Regiao (Top=302)
1389:         loc_oCnt.AddObject("lbl_4c_LblCeps", "Label")
1390:         WITH loc_oCnt.lbl_4c_LblCeps
1391:             .Caption = "CEP"
1392:             .Top = 287
1393:             .Left = 16
1394:             .Width = 40
1395:             .Height = 15
1396:             .FontName = "Tahoma"
1397:             .FontSize = 8
1398:             .ForeColor = RGB(90, 90, 90)
1399:             .BackStyle = 0
1400:             .Visible = .T.
1401:         ENDWITH
1402:         loc_oCnt.AddObject("txt_4c_Ceps", "TextBox")
1403:         WITH loc_oCnt.txt_4c_Ceps
1404:             .Top = 302
1405:             .Left = 16
1406:             .Width = 85
1407:             .Height = 23
1408:             .FontName = "Tahoma"
1409:             .FontSize = 8
1410:             .SpecialEffect = 1
1411:             .ForeColor = RGB(0, 0, 0)
1412:             .BorderColor = RGB(100, 100, 100)
1413:             .Value = ""
1414:             .Visible = .T.
1415:         ENDWITH
1416: 
1417:         loc_oCnt.AddObject("lbl_4c_LblPaises", "Label")
1418:         WITH loc_oCnt.lbl_4c_LblPaises
1419:             .Caption = "Pa" + CHR(237) + "s"
1420:             .Top = 287
1421:             .Left = 105
1422:             .Width = 40
1423:             .Height = 15
1424:             .FontName = "Tahoma"
1425:             .FontSize = 8
1426:             .ForeColor = RGB(90, 90, 90)
1427:             .BackStyle = 0
1428:             .Visible = .T.
1429:         ENDWITH
1430:         loc_oCnt.AddObject("txt_4c_Paises", "TextBox")
1431:         WITH loc_oCnt.txt_4c_Paises
1432:             .Top = 302
1433:             .Left = 105
1434:             .Width = 186
1435:             .Height = 23
1436:             .FontName = "Tahoma"
1437:             .FontSize = 8
1438:             .SpecialEffect = 1
1439:             .ForeColor = RGB(0, 0, 0)
1440:             .BorderColor = RGB(100, 100, 100)
1441:             .Value = ""
1442:             .Visible = .T.
1443:         ENDWITH
1444: 
1445:         loc_oCnt.AddObject("lbl_4c_LblRegiaos", "Label")
1446:         WITH loc_oCnt.lbl_4c_LblRegiaos
1447:             .Caption = "Regi" + CHR(227) + "o"
1448:             .Top = 287
1449:             .Left = 299
1450:             .Width = 50
1451:             .Height = 15
1452:             .FontName = "Tahoma"
1453:             .FontSize = 8
1454:             .ForeColor = RGB(90, 90, 90)
1455:             .BackStyle = 0
1456:             .Visible = .T.
1457:         ENDWITH
1458:         loc_oCnt.AddObject("txt_4c_Regiaos", "TextBox")
1459:         WITH loc_oCnt.txt_4c_Regiaos
1460:             .Top = 302
1461:             .Left = 299
1462:             .Width = 85
1463:             .Height = 23
1464:             .FontName = "Tahoma"
1465:             .FontSize = 8
1466:             .SpecialEffect = 1
1467:             .ForeColor = RGB(0, 0, 0)
1468:             .BorderColor = RGB(100, 100, 100)
1469:             .Value = ""
1470:             .Visible = .T.
1471:         ENDWITH
1472: 
1473:         *-- Endereco (Top=341)
1474:         loc_oCnt.AddObject("lbl_4c_LblEndes", "Label")
1475:         WITH loc_oCnt.lbl_4c_LblEndes
1476:             .Caption = "Endere" + CHR(231) + "o"
1477:             .Top = 326
1478:             .Left = 16
1479:             .Width = 60
1480:             .Height = 15
1481:             .FontName = "Tahoma"
1482:             .FontSize = 8
1483:             .ForeColor = RGB(90, 90, 90)
1484:             .BackStyle = 0
1485:             .Visible = .T.
1486:         ENDWITH
1487:         loc_oCnt.AddObject("txt_4c_Endes", "TextBox")
1488:         WITH loc_oCnt.txt_4c_Endes
1489:             .Top = 341
1490:             .Left = 16
1491:             .Width = 368
1492:             .Height = 23
1493:             .FontName = "Tahoma"
1494:             .FontSize = 8
1495:             .SpecialEffect = 1
1496:             .ForeColor = RGB(0, 0, 0)
1497:             .BorderColor = RGB(100, 100, 100)
1498:             .Value = ""
1499:             .Visible = .T.
1500:         ENDWITH
1501: 
1502:         loc_oCnt.AddObject("lbl_4c_LblNums", "Label")
1503:         WITH loc_oCnt.lbl_4c_LblNums
1504:             .Caption = "Num"
1505:             .Top = 326
1506:             .Left = 387
1507:             .Width = 30
1508:             .Height = 15
1509:             .FontName = "Tahoma"
1510:             .FontSize = 8
1511:             .ForeColor = RGB(90, 90, 90)
1512:             .BackStyle = 0
1513:             .Visible = .T.
1514:         ENDWITH
1515:         loc_oCnt.AddObject("txt_4c_Nums", "TextBox")
1516:         WITH loc_oCnt.txt_4c_Nums
1517:             .Top = 341
1518:             .Left = 387
1519:             .Width = 80
1520:             .Height = 23
1521:             .FontName = "Tahoma"
1522:             .FontSize = 8
1523:             .SpecialEffect = 1
1524:             .ForeColor = RGB(0, 0, 0)
1525:             .BorderColor = RGB(100, 100, 100)
1526:             .Value = ""
1527:             .Visible = .T.
1528:         ENDWITH
1529: 
1530:         loc_oCnt.AddObject("lbl_4c_LblCompls", "Label")
1531:         WITH loc_oCnt.lbl_4c_LblCompls
1532:             .Caption = "Complemento"
1533:             .Top = 326
1534:             .Left = 470
1535:             .Width = 90
1536:             .Height = 15
1537:             .FontName = "Tahoma"
1538:             .FontSize = 8
1539:             .ForeColor = RGB(90, 90, 90)
1540:             .BackStyle = 0
1541:             .Visible = .T.
1542:         ENDWITH
1543:         loc_oCnt.AddObject("txt_4c_Compls", "TextBox")
1544:         WITH loc_oCnt.txt_4c_Compls
1545:             .Top = 341
1546:             .Left = 470
1547:             .Width = 200
1548:             .Height = 23
1549:             .FontName = "Tahoma"
1550:             .FontSize = 8
1551:             .SpecialEffect = 1
1552:             .ForeColor = RGB(0, 0, 0)
1553:             .BorderColor = RGB(100, 100, 100)
1554:             .Value = ""
1555:             .Visible = .T.
1556:         ENDWITH
1557: 
1558:         *-- Bairro / Cidade / Estado (Top=380)
1559:         loc_oCnt.AddObject("lbl_4c_LblBairs", "Label")
1560:         WITH loc_oCnt.lbl_4c_LblBairs
1561:             .Caption = "Bairro"
1562:             .Top = 365
1563:             .Left = 16
1564:             .Width = 50
1565:             .Height = 15
1566:             .FontName = "Tahoma"
1567:             .FontSize = 8
1568:             .ForeColor = RGB(90, 90, 90)
1569:             .BackStyle = 0
1570:             .Visible = .T.
1571:         ENDWITH
1572:         loc_oCnt.AddObject("txt_4c_Bairs", "TextBox")
1573:         WITH loc_oCnt.txt_4c_Bairs
1574:             .Top = 380
1575:             .Left = 16
1576:             .Width = 276
1577:             .Height = 23
1578:             .FontName = "Tahoma"
1579:             .FontSize = 8
1580:             .SpecialEffect = 1
1581:             .ForeColor = RGB(0, 0, 0)
1582:             .BorderColor = RGB(100, 100, 100)
1583:             .Value = ""
1584:             .Visible = .T.
1585:         ENDWITH
1586: 
1587:         loc_oCnt.AddObject("lbl_4c_LblCidas", "Label")
1588:         WITH loc_oCnt.lbl_4c_LblCidas
1589:             .Caption = "Cidade"
1590:             .Top = 365
1591:             .Left = 299
1592:             .Width = 50
1593:             .Height = 15
1594:             .FontName = "Tahoma"
1595:             .FontSize = 8
1596:             .ForeColor = RGB(90, 90, 90)
1597:             .BackStyle = 0
1598:             .Visible = .T.
1599:         ENDWITH
1600:         loc_oCnt.AddObject("txt_4c_Cidas", "TextBox")
1601:         WITH loc_oCnt.txt_4c_Cidas
1602:             .Top = 380
1603:             .Left = 299
1604:             .Width = 306
1605:             .Height = 23
1606:             .FontName = "Tahoma"
1607:             .FontSize = 8
1608:             .SpecialEffect = 1
1609:             .ForeColor = RGB(0, 0, 0)
1610:             .BorderColor = RGB(100, 100, 100)
1611:             .Value = ""
1612:             .Visible = .T.
1613:         ENDWITH
1614: 
1615:         loc_oCnt.AddObject("lbl_4c_LblEstas", "Label")
1616:         WITH loc_oCnt.lbl_4c_LblEstas
1617:             .Caption = "UF"
1618:             .Top = 365
1619:             .Left = 675
1620:             .Width = 30
1621:             .Height = 15
1622:             .FontName = "Tahoma"
1623:             .FontSize = 8
1624:             .ForeColor = RGB(90, 90, 90)
1625:             .BackStyle = 0
1626:             .Visible = .T.
1627:         ENDWITH
1628:         loc_oCnt.AddObject("txt_4c_Estas", "TextBox")
1629:         WITH loc_oCnt.txt_4c_Estas
1630:             .Top = 380
1631:             .Left = 675
1632:             .Width = 25
1633:             .Height = 23
1634:             .FontName = "Tahoma"
1635:             .FontSize = 8
1636:             .SpecialEffect = 1

*-- Linhas 1642 a 1853:
1642:         ENDWITH
1643: 
1644:         *-- Telefones (getDdds, GetTel1, GetTel2, GetFax Top=419)
1645:         loc_oCnt.AddObject("lbl_4c_LblTel", "Label")
1646:         WITH loc_oCnt.lbl_4c_LblTel
1647:             .Caption = "Tel/Fone"
1648:             .Top = 404
1649:             .Left = 16
1650:             .Width = 60
1651:             .Height = 15
1652:             .FontName = "Tahoma"
1653:             .FontSize = 8
1654:             .ForeColor = RGB(90, 90, 90)
1655:             .BackStyle = 0
1656:             .Visible = .T.
1657:         ENDWITH
1658:         loc_oCnt.AddObject("txt_4c_Ddds", "TextBox")
1659:         WITH loc_oCnt.txt_4c_Ddds
1660:             .Top = 419
1661:             .Left = 16
1662:             .Width = 35
1663:             .Height = 23
1664:             .FontName = "Tahoma"
1665:             .FontSize = 8
1666:             .SpecialEffect = 1
1667:             .ForeColor = RGB(0, 0, 0)
1668:             .BorderColor = RGB(100, 100, 100)
1669:             .Value = ""
1670:             .Visible = .T.
1671:         ENDWITH
1672:         loc_oCnt.AddObject("txt_4c_Tel1s", "TextBox")
1673:         WITH loc_oCnt.txt_4c_Tel1s
1674:             .Top = 419
1675:             .Left = 55
1676:             .Width = 139
1677:             .Height = 23
1678:             .FontName = "Tahoma"
1679:             .FontSize = 8
1680:             .SpecialEffect = 1
1681:             .ForeColor = RGB(0, 0, 0)
1682:             .BorderColor = RGB(100, 100, 100)
1683:             .Value = ""
1684:             .Visible = .T.
1685:         ENDWITH
1686:         loc_oCnt.AddObject("txt_4c_Tel2s", "TextBox")
1687:         WITH loc_oCnt.txt_4c_Tel2s
1688:             .Top = 419
1689:             .Left = 270
1690:             .Width = 138
1691:             .Height = 23
1692:             .FontName = "Tahoma"
1693:             .FontSize = 8
1694:             .SpecialEffect = 1
1695:             .ForeColor = RGB(0, 0, 0)
1696:             .BorderColor = RGB(100, 100, 100)
1697:             .Value = ""
1698:             .Visible = .T.
1699:         ENDWITH
1700:         loc_oCnt.AddObject("txt_4c_Faxs", "TextBox")
1701:         WITH loc_oCnt.txt_4c_Faxs
1702:             .Top = 419
1703:             .Left = 409
1704:             .Width = 102
1705:             .Height = 23
1706:             .FontName = "Tahoma"
1707:             .FontSize = 8
1708:             .SpecialEffect = 1
1709:             .ForeColor = RGB(0, 0, 0)
1710:             .BorderColor = RGB(100, 100, 100)
1711:             .Value = ""
1712:             .Visible = .T.
1713:         ENDWITH
1714: 
1715:         *-- Segmento / Profissao (Top=419)
1716:         loc_oCnt.AddObject("lbl_4c_LblProfiss", "Label")
1717:         WITH loc_oCnt.lbl_4c_LblProfiss
1718:             .Caption = "Profiss" + CHR(227) + "o"
1719:             .Top = 404
1720:             .Left = 513
1721:             .Width = 80
1722:             .Height = 15
1723:             .FontName = "Tahoma"
1724:             .FontSize = 8
1725:             .ForeColor = RGB(90, 90, 90)
1726:             .BackStyle = 0
1727:             .Visible = .T.
1728:         ENDWITH
1729:         loc_oCnt.AddObject("txt_4c_Profiss", "TextBox")
1730:         WITH loc_oCnt.txt_4c_Profiss
1731:             .Top = 419
1732:             .Left = 513
1733:             .Width = 100
1734:             .Height = 23
1735:             .FontName = "Tahoma"
1736:             .FontSize = 8
1737:             .SpecialEffect = 1
1738:             .ForeColor = RGB(0, 0, 0)
1739:             .BorderColor = RGB(100, 100, 100)
1740:             .Value = ""
1741:             .Visible = .T.
1742:         ENDWITH
1743: 
1744:         *-- Email (Top=460)
1745:         loc_oCnt.AddObject("lbl_4c_LblEmails", "Label")
1746:         WITH loc_oCnt.lbl_4c_LblEmails
1747:             .Caption = "E-mail"
1748:             .Top = 445
1749:             .Left = 16
1750:             .Width = 50
1751:             .Height = 15
1752:             .FontName = "Tahoma"
1753:             .FontSize = 8
1754:             .ForeColor = RGB(90, 90, 90)
1755:             .BackStyle = 0
1756:             .Visible = .T.
1757:         ENDWITH
1758:         loc_oCnt.AddObject("txt_4c_Emails", "TextBox")
1759:         WITH loc_oCnt.txt_4c_Emails
1760:             .Top = 460
1761:             .Left = 16
1762:             .Width = 368
1763:             .Height = 23
1764:             .FontName = "Tahoma"
1765:             .FontSize = 8
1766:             .SpecialEffect = 1
1767:             .ForeColor = RGB(0, 0, 0)
1768:             .BorderColor = RGB(100, 100, 100)
1769:             .Value = ""
1770:             .Visible = .T.
1771:         ENDWITH
1772: 
1773:         *-- Contato (Get_Contato Top=460, Left=471)
1774:         loc_oCnt.AddObject("lbl_4c_LblContato", "Label")
1775:         WITH loc_oCnt.lbl_4c_LblContato
1776:             .Caption = "Contato"
1777:             .Top = 445
1778:             .Left = 471
1779:             .Width = 60
1780:             .Height = 15
1781:             .FontName = "Tahoma"
1782:             .FontSize = 8
1783:             .ForeColor = RGB(90, 90, 90)
1784:             .BackStyle = 0
1785:             .Visible = .T.
1786:         ENDWITH
1787:         loc_oCnt.AddObject("txt_4c_Contato", "TextBox")
1788:         WITH loc_oCnt.txt_4c_Contato
1789:             .Top = 460
1790:             .Left = 471
1791:             .Width = 290
1792:             .Height = 23
1793:             .FontName = "Tahoma"
1794:             .FontSize = 8
1795:             .SpecialEffect = 1
1796:             .ForeColor = RGB(0, 0, 0)
1797:             .BorderColor = RGB(100, 100, 100)
1798:             .Value = ""
1799:             .Visible = .T.
1800:         ENDWITH
1801: 
1802:         *-- Memo Obs (MemoFun Top=487, Left=16, Width=745, Height=71)
1803:         loc_oCnt.AddObject("lbl_4c_LblObs", "Label")
1804:         WITH loc_oCnt.lbl_4c_LblObs
1805:             .Caption = "Observa" + CHR(231) + CHR(245) + "es"
1806:             .Top = 472
1807:             .Left = 16
1808:             .Width = 90
1809:             .Height = 15
1810:             .FontName = "Tahoma"
1811:             .FontSize = 8
1812:             .ForeColor = RGB(90, 90, 90)
1813:             .BackStyle = 0
1814:             .Visible = .T.
1815:         ENDWITH
1816:         loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
1817:         WITH loc_oCnt.edt_4c_Obs
1818:             .Top = 487
1819:             .Left = 16
1820:             .Width = 745
1821:             .Height = 71
1822:             .FontName = "Tahoma"
1823:             .FontSize = 8
1824:             .SpecialEffect = 1
1825:             .ForeColor = RGB(0, 0, 0)
1826:             .BorderColor = RGB(100, 100, 100)
1827:             .Value = ""
1828:             .Visible = .T.
1829:         ENDWITH
1830: 
1831:         *-- Datas (data_ent Top=527, Data_alt Top=567)
1832:         loc_oCnt.AddObject("lbl_4c_LblDataincs", "Label")
1833:         WITH loc_oCnt.lbl_4c_LblDataincs
1834:             .Caption = "Inclus" + CHR(227) + "o"
1835:             .Top = 512
1836:             .Left = 898
1837:             .Width = 88
1838:             .Height = 15
1839:             .FontName = "Tahoma"
1840:             .FontSize = 8
1841:             .ForeColor = RGB(90, 90, 90)
1842:             .BackStyle = 0
1843:             .Visible = .T.
1844:         ENDWITH
1845:         loc_oCnt.AddObject("txt_4c_Dataincs", "TextBox")
1846:         WITH loc_oCnt.txt_4c_Dataincs
1847:             .Top = 527
1848:             .Left = 897
1849:             .Width = 70
1850:             .Height = 20
1851:             .FontName = "Tahoma"
1852:             .FontBold = .T.
1853:             .FontSize = 8

*-- Linhas 1862 a 1886:
1862:             .Visible = .T.
1863:         ENDWITH
1864: 
1865:         loc_oCnt.AddObject("lbl_4c_LblDtalts", "Label")
1866:         WITH loc_oCnt.lbl_4c_LblDtalts
1867:             .Caption = "Altera" + CHR(231) + CHR(227) + "o"
1868:             .Top = 552
1869:             .Left = 898
1870:             .Width = 88
1871:             .Height = 15
1872:             .FontName = "Tahoma"
1873:             .FontSize = 8
1874:             .ForeColor = RGB(90, 90, 90)
1875:             .BackStyle = 0
1876:             .Visible = .T.
1877:         ENDWITH
1878:         loc_oCnt.AddObject("txt_4c_Dtalts", "TextBox")
1879:         WITH loc_oCnt.txt_4c_Dtalts
1880:             .Top = 567
1881:             .Left = 897
1882:             .Width = 70
1883:             .Height = 20
1884:             .FontName = "Tahoma"
1885:             .FontBold = .T.
1886:             .FontSize = 8

*-- Linhas 1904 a 2170:
1904:         par_oPagina.AddObject("cnt_4c_Pg2", "Container")
1905:         loc_oCnt = par_oPagina.cnt_4c_Pg2
1906:         WITH loc_oCnt
1907:             .Top = 107
1908:             .Left = 0
1909:             .Width = 1000
1910:             .Height = 493
1911:             .BackStyle = 0
1912:             .BorderWidth = 0
1913:             .Visible = .F.
1914:         ENDWITH
1915: 
1916:         *-- Tipo Cadastro
1917:         loc_oCnt.AddObject("lbl_4c_LblTpcads", "Label")
1918:         WITH loc_oCnt.lbl_4c_LblTpcads
1919:             .Caption = "Tipo Cadastro"
1920:             .Top = 30
1921:             .Left = 16
1922:             .Width = 100
1923:             .Height = 15
1924:             .FontName = "Tahoma"
1925:             .FontSize = 8
1926:             .ForeColor = RGB(90, 90, 90)
1927:             .BackStyle = 0
1928:             .Visible = .T.
1929:         ENDWITH
1930:         loc_oCnt.AddObject("txt_4c_Tpcads", "TextBox")
1931:         WITH loc_oCnt.txt_4c_Tpcads
1932:             .Top = 45
1933:             .Left = 16
1934:             .Width = 30
1935:             .Height = 23
1936:             .FontName = "Tahoma"
1937:             .FontSize = 8
1938:             .SpecialEffect = 1
1939:             .ForeColor = RGB(0, 0, 0)
1940:             .BorderColor = RGB(100, 100, 100)
1941:             .Value = 0
1942:             .Visible = .T.
1943:         ENDWITH
1944: 
1945:         *-- Tipo Cliente
1946:         loc_oCnt.AddObject("lbl_4c_LblTpclis", "Label")
1947:         WITH loc_oCnt.lbl_4c_LblTpclis
1948:             .Caption = "Tipo Cliente"
1949:             .Top = 30
1950:             .Left = 50
1951:             .Width = 80
1952:             .Height = 15
1953:             .FontName = "Tahoma"
1954:             .FontSize = 8
1955:             .ForeColor = RGB(90, 90, 90)
1956:             .BackStyle = 0
1957:             .Visible = .T.
1958:         ENDWITH
1959:         loc_oCnt.AddObject("txt_4c_Tpclis", "TextBox")
1960:         WITH loc_oCnt.txt_4c_Tpclis
1961:             .Top = 45
1962:             .Left = 50
1963:             .Width = 30
1964:             .Height = 23
1965:             .FontName = "Tahoma"
1966:             .FontSize = 8
1967:             .SpecialEffect = 1
1968:             .ForeColor = RGB(0, 0, 0)
1969:             .BorderColor = RGB(100, 100, 100)
1970:             .Value = 0
1971:             .Visible = .T.
1972:         ENDWITH
1973: 
1974:         *-- Tabela de Preco (Tabds)
1975:         loc_oCnt.AddObject("lbl_4c_LblTabds", "Label")
1976:         WITH loc_oCnt.lbl_4c_LblTabds
1977:             .Caption = "Tabela Pre" + CHR(231) + "o"
1978:             .Top = 30
1979:             .Left = 100
1980:             .Width = 100
1981:             .Height = 15
1982:             .FontName = "Tahoma"
1983:             .FontSize = 8
1984:             .ForeColor = RGB(90, 90, 90)
1985:             .BackStyle = 0
1986:             .Visible = .T.
1987:         ENDWITH
1988:         loc_oCnt.AddObject("txt_4c_Tabds", "TextBox")
1989:         WITH loc_oCnt.txt_4c_Tabds
1990:             .Top = 45
1991:             .Left = 100
1992:             .Width = 80
1993:             .Height = 23
1994:             .FontName = "Tahoma"
1995:             .FontSize = 8
1996:             .SpecialEffect = 1
1997:             .ForeColor = RGB(0, 0, 0)
1998:             .BorderColor = RGB(100, 100, 100)
1999:             .Value = ""
2000:             .Visible = .T.
2001:         ENDWITH
2002: 
2003:         *-- Tabela Alternativa (Tabd2s)
2004:         loc_oCnt.AddObject("lbl_4c_LblTabd2s", "Label")
2005:         WITH loc_oCnt.lbl_4c_LblTabd2s
2006:             .Caption = "Tab.Alternativa"
2007:             .Top = 30
2008:             .Left = 185
2009:             .Width = 100
2010:             .Height = 15
2011:             .FontName = "Tahoma"
2012:             .FontSize = 8
2013:             .ForeColor = RGB(90, 90, 90)
2014:             .BackStyle = 0
2015:             .Visible = .T.
2016:         ENDWITH
2017:         loc_oCnt.AddObject("txt_4c_Tabd2s", "TextBox")
2018:         WITH loc_oCnt.txt_4c_Tabd2s
2019:             .Top = 45
2020:             .Left = 185
2021:             .Width = 80
2022:             .Height = 23
2023:             .FontName = "Tahoma"
2024:             .FontSize = 8
2025:             .SpecialEffect = 1
2026:             .ForeColor = RGB(0, 0, 0)
2027:             .BorderColor = RGB(100, 100, 100)
2028:             .Value = ""
2029:             .Visible = .T.
2030:         ENDWITH
2031: 
2032:         *-- Lista Preco (Lprecos)
2033:         loc_oCnt.AddObject("lbl_4c_LblLprecos", "Label")
2034:         WITH loc_oCnt.lbl_4c_LblLprecos
2035:             .Caption = "Lista Pre" + CHR(231) + "o"
2036:             .Top = 30
2037:             .Left = 270
2038:             .Width = 80
2039:             .Height = 15
2040:             .FontName = "Tahoma"
2041:             .FontSize = 8
2042:             .ForeColor = RGB(90, 90, 90)
2043:             .BackStyle = 0
2044:             .Visible = .T.
2045:         ENDWITH
2046:         loc_oCnt.AddObject("txt_4c_Lprecos", "TextBox")
2047:         WITH loc_oCnt.txt_4c_Lprecos
2048:             .Top = 45
2049:             .Left = 270
2050:             .Width = 80
2051:             .Height = 23
2052:             .FontName = "Tahoma"
2053:             .FontSize = 8
2054:             .SpecialEffect = 1
2055:             .ForeColor = RGB(0, 0, 0)
2056:             .BorderColor = RGB(100, 100, 100)
2057:             .Value = ""
2058:             .Visible = .T.
2059:         ENDWITH
2060: 
2061:         *-- Forma Pgto (Fpags)
2062:         loc_oCnt.AddObject("lbl_4c_LblFpags", "Label")
2063:         WITH loc_oCnt.lbl_4c_LblFpags
2064:             .Caption = "Forma Pgto"
2065:             .Top = 30
2066:             .Left = 355
2067:             .Width = 80
2068:             .Height = 15
2069:             .FontName = "Tahoma"
2070:             .FontSize = 8
2071:             .ForeColor = RGB(90, 90, 90)
2072:             .BackStyle = 0
2073:             .Visible = .T.
2074:         ENDWITH
2075:         loc_oCnt.AddObject("txt_4c_Fpags2", "TextBox")
2076:         WITH loc_oCnt.txt_4c_Fpags2
2077:             .Top = 45
2078:             .Left = 355
2079:             .Width = 80
2080:             .Height = 23
2081:             .FontName = "Tahoma"
2082:             .FontSize = 8
2083:             .SpecialEffect = 1
2084:             .ForeColor = RGB(0, 0, 0)
2085:             .BorderColor = RGB(100, 100, 100)
2086:             .Value = ""
2087:             .Visible = .T.
2088:         ENDWITH
2089: 
2090:         *-- Prazo Entrega
2091:         loc_oCnt.AddObject("lbl_4c_LblPrazoents", "Label")
2092:         WITH loc_oCnt.lbl_4c_LblPrazoents
2093:             .Caption = "Prazo Entrega"
2094:             .Top = 30
2095:             .Left = 440
2096:             .Width = 90
2097:             .Height = 15
2098:             .FontName = "Tahoma"
2099:             .FontSize = 8
2100:             .ForeColor = RGB(90, 90, 90)
2101:             .BackStyle = 0
2102:             .Visible = .T.
2103:         ENDWITH
2104:         loc_oCnt.AddObject("txt_4c_Prazoents", "TextBox")
2105:         WITH loc_oCnt.txt_4c_Prazoents
2106:             .Top = 45
2107:             .Left = 440
2108:             .Width = 50
2109:             .Height = 23
2110:             .FontName = "Tahoma"
2111:             .FontSize = 8
2112:             .SpecialEffect = 1
2113:             .ForeColor = RGB(0, 0, 0)
2114:             .BorderColor = RGB(100, 100, 100)
2115:             .Value = 0
2116:             .Visible = .T.
2117:         ENDWITH
2118: 
2119:         *-- Codsegs
2120:         loc_oCnt.AddObject("lbl_4c_LblCodsegs", "Label")
2121:         WITH loc_oCnt.lbl_4c_LblCodsegs
2122:             .Caption = "Cod.Seguro"
2123:             .Top = 30
2124:             .Left = 495
2125:             .Width = 80
2126:             .Height = 15
2127:             .FontName = "Tahoma"
2128:             .FontSize = 8
2129:             .ForeColor = RGB(90, 90, 90)
2130:             .BackStyle = 0
2131:             .Visible = .T.
2132:         ENDWITH
2133:         loc_oCnt.AddObject("txt_4c_Codsegs", "TextBox")
2134:         WITH loc_oCnt.txt_4c_Codsegs
2135:             .Top = 45
2136:             .Left = 495
2137:             .Width = 80
2138:             .Height = 23
2139:             .FontName = "Tahoma"
2140:             .FontSize = 8
2141:             .SpecialEffect = 1
2142:             .ForeColor = RGB(0, 0, 0)
2143:             .BorderColor = RGB(100, 100, 100)
2144:             .Value = ""
2145:             .Visible = .T.
2146:         ENDWITH
2147: 
2148:         *-- Limite Credito
2149:         loc_oCnt.AddObject("lbl_4c_LblLimcres", "Label")
2150:         WITH loc_oCnt.lbl_4c_LblLimcres
2151:             .Caption = "Limite Cr" + CHR(233) + "dito"
2152:             .Top = 80
2153:             .Left = 16
2154:             .Width = 90
2155:             .Height = 15
2156:             .FontName = "Tahoma"
2157:             .FontSize = 8
2158:             .ForeColor = RGB(90, 90, 90)
2159:             .BackStyle = 0
2160:             .Visible = .T.
2161:         ENDWITH
2162:         loc_oCnt.AddObject("txt_4c_Limcres", "TextBox")
2163:         WITH loc_oCnt.txt_4c_Limcres
2164:             .Top = 95
2165:             .Left = 16
2166:             .Width = 100
2167:             .Height = 23
2168:             .FontName = "Tahoma"
2169:             .FontSize = 8
2170:             .SpecialEffect = 1

*-- Linhas 2176 a 2200:
2176:         ENDWITH
2177: 
2178:         *-- Juros
2179:         loc_oCnt.AddObject("lbl_4c_LblJuros", "Label")
2180:         WITH loc_oCnt.lbl_4c_LblJuros
2181:             .Caption = "Juros %"
2182:             .Top = 80
2183:             .Left = 125
2184:             .Width = 60
2185:             .Height = 15
2186:             .FontName = "Tahoma"
2187:             .FontSize = 8
2188:             .ForeColor = RGB(90, 90, 90)
2189:             .BackStyle = 0
2190:             .Visible = .T.
2191:         ENDWITH
2192:         loc_oCnt.AddObject("txt_4c_Juros", "TextBox")
2193:         WITH loc_oCnt.txt_4c_Juros
2194:             .Top = 95
2195:             .Left = 125
2196:             .Width = 60
2197:             .Height = 23
2198:             .FontName = "Tahoma"
2199:             .FontSize = 8
2200:             .SpecialEffect = 1

*-- Linhas 2206 a 2230:
2206:         ENDWITH
2207: 
2208:         *-- Desconto
2209:         loc_oCnt.AddObject("lbl_4c_LblPercdescli", "Label")
2210:         WITH loc_oCnt.lbl_4c_LblPercdescli
2211:             .Caption = "Desc %"
2212:             .Top = 80
2213:             .Left = 190
2214:             .Width = 60
2215:             .Height = 15
2216:             .FontName = "Tahoma"
2217:             .FontSize = 8
2218:             .ForeColor = RGB(90, 90, 90)
2219:             .BackStyle = 0
2220:             .Visible = .T.
2221:         ENDWITH
2222:         loc_oCnt.AddObject("txt_4c_Percdescli", "TextBox")
2223:         WITH loc_oCnt.txt_4c_Percdescli
2224:             .Top = 95
2225:             .Left = 190
2226:             .Width = 60
2227:             .Height = 23
2228:             .FontName = "Tahoma"
2229:             .FontSize = 8
2230:             .SpecialEffect = 1

*-- Linhas 2236 a 2260:
2236:         ENDWITH
2237: 
2238:         *-- Comissao
2239:         loc_oCnt.AddObject("lbl_4c_LblComis", "Label")
2240:         WITH loc_oCnt.lbl_4c_LblComis
2241:             .Caption = "Comiss" + CHR(227) + "o %"
2242:             .Top = 80
2243:             .Left = 255
2244:             .Width = 80
2245:             .Height = 15
2246:             .FontName = "Tahoma"
2247:             .FontSize = 8
2248:             .ForeColor = RGB(90, 90, 90)
2249:             .BackStyle = 0
2250:             .Visible = .T.
2251:         ENDWITH
2252:         loc_oCnt.AddObject("txt_4c_Comis", "TextBox")
2253:         WITH loc_oCnt.txt_4c_Comis
2254:             .Top = 95
2255:             .Left = 255
2256:             .Width = 60
2257:             .Height = 23
2258:             .FontName = "Tahoma"
2259:             .FontSize = 8
2260:             .SpecialEffect = 1

*-- Linhas 2266 a 2403:
2266:         ENDWITH
2267: 
2268:         *-- Grupos de conta
2269:         loc_oCnt.AddObject("lbl_4c_LblGrupocobs", "Label")
2270:         WITH loc_oCnt.lbl_4c_LblGrupocobs
2271:             .Caption = "Gr.Cobran" + CHR(231) + "a"
2272:             .Top = 140
2273:             .Left = 16
2274:             .Width = 90
2275:             .Height = 15
2276:             .FontName = "Tahoma"
2277:             .FontSize = 8
2278:             .ForeColor = RGB(90, 90, 90)
2279:             .BackStyle = 0
2280:             .Visible = .T.
2281:         ENDWITH
2282:         loc_oCnt.AddObject("txt_4c_Grupocobs", "TextBox")
2283:         WITH loc_oCnt.txt_4c_Grupocobs
2284:             .Top = 155
2285:             .Left = 16
2286:             .Width = 80
2287:             .Height = 23
2288:             .FontName = "Tahoma"
2289:             .FontSize = 8
2290:             .SpecialEffect = 1
2291:             .ForeColor = RGB(0, 0, 0)
2292:             .BorderColor = RGB(100, 100, 100)
2293:             .Value = ""
2294:             .Visible = .T.
2295:         ENDWITH
2296: 
2297:         loc_oCnt.AddObject("lbl_4c_LblGruprods", "Label")
2298:         WITH loc_oCnt.lbl_4c_LblGruprods
2299:             .Caption = "Gr.Produto"
2300:             .Top = 140
2301:             .Left = 100
2302:             .Width = 80
2303:             .Height = 15
2304:             .FontName = "Tahoma"
2305:             .FontSize = 8
2306:             .ForeColor = RGB(90, 90, 90)
2307:             .BackStyle = 0
2308:             .Visible = .T.
2309:         ENDWITH
2310:         loc_oCnt.AddObject("txt_4c_Gruprods", "TextBox")
2311:         WITH loc_oCnt.txt_4c_Gruprods
2312:             .Top = 155
2313:             .Left = 100
2314:             .Width = 80
2315:             .Height = 23
2316:             .FontName = "Tahoma"
2317:             .FontSize = 8
2318:             .SpecialEffect = 1
2319:             .ForeColor = RGB(0, 0, 0)
2320:             .BorderColor = RGB(100, 100, 100)
2321:             .Value = ""
2322:             .Visible = .T.
2323:         ENDWITH
2324: 
2325:         loc_oCnt.AddObject("lbl_4c_LblGrupocents", "Label")
2326:         WITH loc_oCnt.lbl_4c_LblGrupocents
2327:             .Caption = "Gr.Custo"
2328:             .Top = 140
2329:             .Left = 185
2330:             .Width = 80
2331:             .Height = 15
2332:             .FontName = "Tahoma"
2333:             .FontSize = 8
2334:             .ForeColor = RGB(90, 90, 90)
2335:             .BackStyle = 0
2336:             .Visible = .T.
2337:         ENDWITH
2338:         loc_oCnt.AddObject("txt_4c_Grupocents", "TextBox")
2339:         WITH loc_oCnt.txt_4c_Grupocents
2340:             .Top = 155
2341:             .Left = 185
2342:             .Width = 80
2343:             .Height = 23
2344:             .FontName = "Tahoma"
2345:             .FontSize = 8
2346:             .SpecialEffect = 1
2347:             .ForeColor = RGB(0, 0, 0)
2348:             .BorderColor = RGB(100, 100, 100)
2349:             .Value = ""
2350:             .Visible = .T.
2351:         ENDWITH
2352: 
2353:         loc_oCnt.AddObject("lbl_4c_LblGrupomats", "Label")
2354:         WITH loc_oCnt.lbl_4c_LblGrupomats
2355:             .Caption = "Gr.Material"
2356:             .Top = 140
2357:             .Left = 270
2358:             .Width = 80
2359:             .Height = 15
2360:             .FontName = "Tahoma"
2361:             .FontSize = 8
2362:             .ForeColor = RGB(90, 90, 90)
2363:             .BackStyle = 0
2364:             .Visible = .T.
2365:         ENDWITH
2366:         loc_oCnt.AddObject("txt_4c_Grupomats", "TextBox")
2367:         WITH loc_oCnt.txt_4c_Grupomats
2368:             .Top = 155
2369:             .Left = 270
2370:             .Width = 80
2371:             .Height = 23
2372:             .FontName = "Tahoma"
2373:             .FontSize = 8
2374:             .SpecialEffect = 1
2375:             .ForeColor = RGB(0, 0, 0)
2376:             .BorderColor = RGB(100, 100, 100)
2377:             .Value = ""
2378:             .Visible = .T.
2379:         ENDWITH
2380: 
2381:         *-- Contas contabeis (Contacobs, Contamats, Contavens, Contaven2s, Contacents, Conprods)
2382:         loc_oCnt.AddObject("lbl_4c_LblContacobs", "Label")
2383:         WITH loc_oCnt.lbl_4c_LblContacobs
2384:             .Caption = "Cta.Cobran" + CHR(231) + "a"
2385:             .Top = 200
2386:             .Left = 16
2387:             .Width = 90
2388:             .Height = 15
2389:             .FontName = "Tahoma"
2390:             .FontSize = 8
2391:             .ForeColor = RGB(90, 90, 90)
2392:             .BackStyle = 0
2393:             .Visible = .T.
2394:         ENDWITH
2395:         loc_oCnt.AddObject("txt_4c_Contacobs", "TextBox")
2396:         WITH loc_oCnt.txt_4c_Contacobs
2397:             .Top = 215
2398:             .Left = 16
2399:             .Width = 100
2400:             .Height = 23
2401:             .FontName = "Tahoma"
2402:             .FontSize = 8
2403:             .SpecialEffect = 1

*-- Linhas 2409 a 2418:
2409: 
2410:         loc_oCnt.AddObject("txt_4c_Contamats", "TextBox")
2411:         WITH loc_oCnt.txt_4c_Contamats
2412:             .Top = 215
2413:             .Left = 120
2414:             .Width = 100
2415:             .Height = 23
2416:             .FontName = "Tahoma"
2417:             .FontSize = 8
2418:             .SpecialEffect = 1

*-- Linhas 2424 a 2433:
2424: 
2425:         loc_oCnt.AddObject("txt_4c_Contavens", "TextBox")
2426:         WITH loc_oCnt.txt_4c_Contavens
2427:             .Top = 215
2428:             .Left = 224
2429:             .Width = 100
2430:             .Height = 23
2431:             .FontName = "Tahoma"
2432:             .FontSize = 8
2433:             .SpecialEffect = 1

*-- Linhas 2439 a 2448:
2439: 
2440:         loc_oCnt.AddObject("txt_4c_Contaven2s", "TextBox")
2441:         WITH loc_oCnt.txt_4c_Contaven2s
2442:             .Top = 215
2443:             .Left = 328
2444:             .Width = 100
2445:             .Height = 23
2446:             .FontName = "Tahoma"
2447:             .FontSize = 8
2448:             .SpecialEffect = 1

*-- Linhas 2454 a 2463:
2454: 
2455:         loc_oCnt.AddObject("txt_4c_Contacents", "TextBox")
2456:         WITH loc_oCnt.txt_4c_Contacents
2457:             .Top = 215
2458:             .Left = 432
2459:             .Width = 100
2460:             .Height = 23
2461:             .FontName = "Tahoma"
2462:             .FontSize = 8
2463:             .SpecialEffect = 1

*-- Linhas 2469 a 2507:
2469: 
2470:         loc_oCnt.AddObject("txt_4c_Conprods", "TextBox")
2471:         WITH loc_oCnt.txt_4c_Conprods
2472:             .Top = 215
2473:             .Left = 536
2474:             .Width = 100
2475:             .Height = 23
2476:             .FontName = "Tahoma"
2477:             .FontSize = 8
2478:             .SpecialEffect = 1
2479:             .ForeColor = RGB(0, 0, 0)
2480:             .BorderColor = RGB(100, 100, 100)
2481:             .Value = ""
2482:             .Visible = .T.
2483:         ENDWITH
2484: 
2485:         *-- Contab conta
2486:         loc_oCnt.AddObject("lbl_4c_LblCcontabs", "Label")
2487:         WITH loc_oCnt.lbl_4c_LblCcontabs
2488:             .Caption = "Cta.Contabil"
2489:             .Top = 260
2490:             .Left = 16
2491:             .Width = 90
2492:             .Height = 15
2493:             .FontName = "Tahoma"
2494:             .FontSize = 8
2495:             .ForeColor = RGB(90, 90, 90)
2496:             .BackStyle = 0
2497:             .Visible = .T.
2498:         ENDWITH
2499:         loc_oCnt.AddObject("txt_4c_Ccontabs", "TextBox")
2500:         WITH loc_oCnt.txt_4c_Ccontabs
2501:             .Top = 275
2502:             .Left = 16
2503:             .Width = 100
2504:             .Height = 23
2505:             .FontName = "Tahoma"
2506:             .FontSize = 8
2507:             .SpecialEffect = 1

*-- Linhas 2520 a 2638:
2520:         par_oPagina.AddObject("cnt_4c_Pg3", "Container")
2521:         loc_oCnt = par_oPagina.cnt_4c_Pg3
2522:         WITH loc_oCnt
2523:             .Top = 107
2524:             .Left = 0
2525:             .Width = 1000
2526:             .Height = 493
2527:             .BackStyle = 0
2528:             .BorderWidth = 0
2529:             .Visible = .F.
2530:         ENDWITH
2531:         *-- Dados Bancarios
2532:         loc_oCnt.AddObject("lbl_4c_TituloP3", "Label")
2533:         WITH loc_oCnt.lbl_4c_TituloP3
2534:             .Caption = "Dados Banc" + CHR(225) + "rios"
2535:             .Top = 80
2536:             .Left = 40
2537:             .Width = 120
2538:             .Height = 15
2539:             .FontName = "Tahoma"
2540:             .FontSize = 10
2541:             .FontBold = .T.
2542:             .ForeColor = RGB(90, 90, 90)
2543:             .BackStyle = 0
2544:             .Visible = .T.
2545:         ENDWITH
2546:         *-- Campos de Endcob (usado em alguns formularios de banco)
2547:         loc_oCnt.AddObject("lbl_4c_LblEndcobs", "Label")
2548:         WITH loc_oCnt.lbl_4c_LblEndcobs
2549:             .Caption = "End.Cobran" + CHR(231) + "a"
2550:             .Top = 110
2551:             .Left = 16
2552:             .Width = 100
2553:             .Height = 15
2554:             .FontName = "Tahoma"
2555:             .FontSize = 8
2556:             .ForeColor = RGB(90, 90, 90)
2557:             .BackStyle = 0
2558:             .Visible = .T.
2559:         ENDWITH
2560:         loc_oCnt.AddObject("txt_4c_Endcobs", "TextBox")
2561:         WITH loc_oCnt.txt_4c_Endcobs
2562:             .Top = 125
2563:             .Left = 16
2564:             .Width = 300
2565:             .Height = 23
2566:             .FontName = "Tahoma"
2567:             .FontSize = 8
2568:             .SpecialEffect = 1
2569:             .ForeColor = RGB(0, 0, 0)
2570:             .BorderColor = RGB(100, 100, 100)
2571:             .Value = ""
2572:             .Visible = .T.
2573:         ENDWITH
2574:         loc_oCnt.AddObject("txt_4c_Cepcobs", "TextBox")
2575:         WITH loc_oCnt.txt_4c_Cepcobs
2576:             .Top = 125
2577:             .Left = 320
2578:             .Width = 80
2579:             .Height = 23
2580:             .FontName = "Tahoma"
2581:             .FontSize = 8
2582:             .SpecialEffect = 1
2583:             .ForeColor = RGB(0, 0, 0)
2584:             .BorderColor = RGB(100, 100, 100)
2585:             .Value = ""
2586:             .Visible = .T.
2587:         ENDWITH
2588:         loc_oCnt.AddObject("txt_4c_Cidcobs", "TextBox")
2589:         WITH loc_oCnt.txt_4c_Cidcobs
2590:             .Top = 125
2591:             .Left = 405
2592:             .Width = 200
2593:             .Height = 23
2594:             .FontName = "Tahoma"
2595:             .FontSize = 8
2596:             .SpecialEffect = 1
2597:             .ForeColor = RGB(0, 0, 0)
2598:             .BorderColor = RGB(100, 100, 100)
2599:             .Value = ""
2600:             .Visible = .T.
2601:         ENDWITH
2602:         loc_oCnt.AddObject("txt_4c_Estcobs", "TextBox")
2603:         WITH loc_oCnt.txt_4c_Estcobs
2604:             .Top = 125
2605:             .Left = 609
2606:             .Width = 25
2607:             .Height = 23
2608:             .FontName = "Tahoma"
2609:             .FontSize = 8
2610:             .SpecialEffect = 1
2611:             .ForeColor = RGB(0, 0, 0)
2612:             .BorderColor = RGB(100, 100, 100)
2613:             .Value = ""
2614:             .Visible = .T.
2615:         ENDWITH
2616:         loc_oCnt.AddObject("txt_4c_Baicobs", "TextBox")
2617:         WITH loc_oCnt.txt_4c_Baicobs
2618:             .Top = 125
2619:             .Left = 638
2620:             .Width = 200
2621:             .Height = 23
2622:             .FontName = "Tahoma"
2623:             .FontSize = 8
2624:             .SpecialEffect = 1
2625:             .ForeColor = RGB(0, 0, 0)
2626:             .BorderColor = RGB(100, 100, 100)
2627:             .Value = ""
2628:             .Visible = .T.
2629:         ENDWITH
2630:         loc_oCnt.AddObject("txt_4c_Paicobs", "TextBox")
2631:         WITH loc_oCnt.txt_4c_Paicobs
2632:             .Top = 165
2633:             .Left = 16
2634:             .Width = 100
2635:             .Height = 23
2636:             .FontName = "Tahoma"
2637:             .FontSize = 8
2638:             .SpecialEffect = 1

*-- Linhas 2648 a 2835:
2648:         par_oPagina.AddObject("cnt_4c_Pg4", "Container")
2649:         loc_oCnt = par_oPagina.cnt_4c_Pg4
2650:         WITH loc_oCnt
2651:             .Top = 107
2652:             .Left = 0
2653:             .Width = 1000
2654:             .Height = 493
2655:             .BackStyle = 0
2656:             .BorderWidth = 0
2657:             .Visible = .F.
2658:         ENDWITH
2659:         loc_oCnt.AddObject("lbl_4c_TituloP4", "Label")
2660:         WITH loc_oCnt.lbl_4c_TituloP4
2661:             .Caption = "Follow-up"
2662:             .Top = 80
2663:             .Left = 40
2664:             .Width = 100
2665:             .Height = 15
2666:             .FontName = "Tahoma"
2667:             .FontSize = 10
2668:             .FontBold = .T.
2669:             .ForeColor = RGB(90, 90, 90)
2670:             .BackStyle = 0
2671:             .Visible = .T.
2672:         ENDWITH
2673:         *-- Endereco trabalho
2674:         loc_oCnt.AddObject("lbl_4c_LblEndtrabs", "Label")
2675:         WITH loc_oCnt.lbl_4c_LblEndtrabs
2676:             .Caption = "End. Trabalho"
2677:             .Top = 110
2678:             .Left = 16
2679:             .Width = 100
2680:             .Height = 15
2681:             .FontName = "Tahoma"
2682:             .FontSize = 8
2683:             .ForeColor = RGB(90, 90, 90)
2684:             .BackStyle = 0
2685:             .Visible = .T.
2686:         ENDWITH
2687:         loc_oCnt.AddObject("txt_4c_Endtrabs", "TextBox")
2688:         WITH loc_oCnt.txt_4c_Endtrabs
2689:             .Top = 125
2690:             .Left = 16
2691:             .Width = 300
2692:             .Height = 23
2693:             .FontName = "Tahoma"
2694:             .FontSize = 8
2695:             .SpecialEffect = 1
2696:             .ForeColor = RGB(0, 0, 0)
2697:             .BorderColor = RGB(100, 100, 100)
2698:             .Value = ""
2699:             .Visible = .T.
2700:         ENDWITH
2701:         loc_oCnt.AddObject("txt_4c_Ceptrabs", "TextBox")
2702:         WITH loc_oCnt.txt_4c_Ceptrabs
2703:             .Top = 125
2704:             .Left = 320
2705:             .Width = 80
2706:             .Height = 23
2707:             .FontName = "Tahoma"
2708:             .FontSize = 8
2709:             .SpecialEffect = 1
2710:             .ForeColor = RGB(0, 0, 0)
2711:             .BorderColor = RGB(100, 100, 100)
2712:             .Value = ""
2713:             .Visible = .T.
2714:         ENDWITH
2715:         loc_oCnt.AddObject("txt_4c_Cidtrabs", "TextBox")
2716:         WITH loc_oCnt.txt_4c_Cidtrabs
2717:             .Top = 125
2718:             .Left = 405
2719:             .Width = 200
2720:             .Height = 23
2721:             .FontName = "Tahoma"
2722:             .FontSize = 8
2723:             .SpecialEffect = 1
2724:             .ForeColor = RGB(0, 0, 0)
2725:             .BorderColor = RGB(100, 100, 100)
2726:             .Value = ""
2727:             .Visible = .T.
2728:         ENDWITH
2729:         loc_oCnt.AddObject("txt_4c_Esttrabs", "TextBox")
2730:         WITH loc_oCnt.txt_4c_Esttrabs
2731:             .Top = 125
2732:             .Left = 609
2733:             .Width = 25
2734:             .Height = 23
2735:             .FontName = "Tahoma"
2736:             .FontSize = 8
2737:             .SpecialEffect = 1
2738:             .ForeColor = RGB(0, 0, 0)
2739:             .BorderColor = RGB(100, 100, 100)
2740:             .Value = ""
2741:             .Visible = .T.
2742:         ENDWITH
2743:         loc_oCnt.AddObject("txt_4c_Bairtrabs", "TextBox")
2744:         WITH loc_oCnt.txt_4c_Bairtrabs
2745:             .Top = 125
2746:             .Left = 638
2747:             .Width = 200
2748:             .Height = 23
2749:             .FontName = "Tahoma"
2750:             .FontSize = 8
2751:             .SpecialEffect = 1
2752:             .ForeColor = RGB(0, 0, 0)
2753:             .BorderColor = RGB(100, 100, 100)
2754:             .Value = ""
2755:             .Visible = .T.
2756:         ENDWITH
2757:         loc_oCnt.AddObject("txt_4c_Numtrabs", "TextBox")
2758:         WITH loc_oCnt.txt_4c_Numtrabs
2759:             .Top = 165
2760:             .Left = 16
2761:             .Width = 80
2762:             .Height = 23
2763:             .FontName = "Tahoma"
2764:             .FontSize = 8
2765:             .SpecialEffect = 1
2766:             .ForeColor = RGB(0, 0, 0)
2767:             .BorderColor = RGB(100, 100, 100)
2768:             .Value = ""
2769:             .Visible = .T.
2770:         ENDWITH
2771:         loc_oCnt.AddObject("txt_4c_Compltrabs", "TextBox")
2772:         WITH loc_oCnt.txt_4c_Compltrabs
2773:             .Top = 165
2774:             .Left = 100
2775:             .Width = 200
2776:             .Height = 23
2777:             .FontName = "Tahoma"
2778:             .FontSize = 8
2779:             .SpecialEffect = 1
2780:             .ForeColor = RGB(0, 0, 0)
2781:             .BorderColor = RGB(100, 100, 100)
2782:             .Value = ""
2783:             .Visible = .T.
2784:         ENDWITH
2785:         loc_oCnt.AddObject("txt_4c_Emptrabs", "TextBox")
2786:         WITH loc_oCnt.txt_4c_Emptrabs
2787:             .Top = 205
2788:             .Left = 16
2789:             .Width = 200
2790:             .Height = 23
2791:             .FontName = "Tahoma"
2792:             .FontSize = 8
2793:             .SpecialEffect = 1
2794:             .ForeColor = RGB(0, 0, 0)
2795:             .BorderColor = RGB(100, 100, 100)
2796:             .Value = ""
2797:             .Visible = .T.
2798:         ENDWITH
2799:         loc_oCnt.AddObject("txt_4c_Cnpjtrabs", "TextBox")
2800:         WITH loc_oCnt.txt_4c_Cnpjtrabs
2801:             .Top = 205
2802:             .Left = 220
2803:             .Width = 150
2804:             .Height = 23
2805:             .FontName = "Tahoma"
2806:             .FontSize = 8
2807:             .SpecialEffect = 1
2808:             .ForeColor = RGB(0, 0, 0)
2809:             .BorderColor = RGB(100, 100, 100)
2810:             .Value = ""
2811:             .Visible = .T.
2812:         ENDWITH
2813:         loc_oCnt.AddObject("txt_4c_Teltrabs", "TextBox")
2814:         WITH loc_oCnt.txt_4c_Teltrabs
2815:             .Top = 205
2816:             .Left = 374
2817:             .Width = 120
2818:             .Height = 23
2819:             .FontName = "Tahoma"
2820:             .FontSize = 8
2821:             .SpecialEffect = 1
2822:             .ForeColor = RGB(0, 0, 0)
2823:             .BorderColor = RGB(100, 100, 100)
2824:             .Value = ""
2825:             .Visible = .T.
2826:         ENDWITH
2827:         loc_oCnt.AddObject("txt_4c_Paitrabs", "TextBox")
2828:         WITH loc_oCnt.txt_4c_Paitrabs
2829:             .Top = 205
2830:             .Left = 498
2831:             .Width = 100
2832:             .Height = 23
2833:             .FontName = "Tahoma"
2834:             .FontSize = 8
2835:             .SpecialEffect = 1

*-- Linhas 2845 a 3004:
2845:         par_oPagina.AddObject("cnt_4c_Pg5", "Container")
2846:         loc_oCnt = par_oPagina.cnt_4c_Pg5
2847:         WITH loc_oCnt
2848:             .Top = 107
2849:             .Left = 0
2850:             .Width = 1000
2851:             .Height = 493
2852:             .BackStyle = 0
2853:             .BorderWidth = 0
2854:             .Visible = .F.
2855:         ENDWITH
2856:         loc_oCnt.AddObject("lbl_4c_TituloP5", "Label")
2857:         WITH loc_oCnt.lbl_4c_TituloP5
2858:             .Caption = "Conta Corrente"
2859:             .Top = 80
2860:             .Left = 40
2861:             .Width = 130
2862:             .Height = 15
2863:             .FontName = "Tahoma"
2864:             .FontSize = 10
2865:             .FontBold = .T.
2866:             .ForeColor = RGB(90, 90, 90)
2867:             .BackStyle = 0
2868:             .Visible = .T.
2869:         ENDWITH
2870:         *-- Endereco entrega (cos)
2871:         loc_oCnt.AddObject("lbl_4c_LblEndcos", "Label")
2872:         WITH loc_oCnt.lbl_4c_LblEndcos
2873:             .Caption = "End. Entrega"
2874:             .Top = 110
2875:             .Left = 16
2876:             .Width = 100
2877:             .Height = 15
2878:             .FontName = "Tahoma"
2879:             .FontSize = 8
2880:             .ForeColor = RGB(90, 90, 90)
2881:             .BackStyle = 0
2882:             .Visible = .T.
2883:         ENDWITH
2884:         loc_oCnt.AddObject("txt_4c_Endcos", "TextBox")
2885:         WITH loc_oCnt.txt_4c_Endcos
2886:             .Top = 125
2887:             .Left = 16
2888:             .Width = 300
2889:             .Height = 23
2890:             .FontName = "Tahoma"
2891:             .FontSize = 8
2892:             .SpecialEffect = 1
2893:             .ForeColor = RGB(0, 0, 0)
2894:             .BorderColor = RGB(100, 100, 100)
2895:             .Value = ""
2896:             .Visible = .T.
2897:         ENDWITH
2898:         loc_oCnt.AddObject("txt_4c_Cepcos", "TextBox")
2899:         WITH loc_oCnt.txt_4c_Cepcos
2900:             .Top = 125
2901:             .Left = 320
2902:             .Width = 80
2903:             .Height = 23
2904:             .FontName = "Tahoma"
2905:             .FontSize = 8
2906:             .SpecialEffect = 1
2907:             .ForeColor = RGB(0, 0, 0)
2908:             .BorderColor = RGB(100, 100, 100)
2909:             .Value = ""
2910:             .Visible = .T.
2911:         ENDWITH
2912:         loc_oCnt.AddObject("txt_4c_Cidcos", "TextBox")
2913:         WITH loc_oCnt.txt_4c_Cidcos
2914:             .Top = 125
2915:             .Left = 405
2916:             .Width = 200
2917:             .Height = 23
2918:             .FontName = "Tahoma"
2919:             .FontSize = 8
2920:             .SpecialEffect = 1
2921:             .ForeColor = RGB(0, 0, 0)
2922:             .BorderColor = RGB(100, 100, 100)
2923:             .Value = ""
2924:             .Visible = .T.
2925:         ENDWITH
2926:         loc_oCnt.AddObject("txt_4c_Estcos", "TextBox")
2927:         WITH loc_oCnt.txt_4c_Estcos
2928:             .Top = 125
2929:             .Left = 609
2930:             .Width = 25
2931:             .Height = 23
2932:             .FontName = "Tahoma"
2933:             .FontSize = 8
2934:             .SpecialEffect = 1
2935:             .ForeColor = RGB(0, 0, 0)
2936:             .BorderColor = RGB(100, 100, 100)
2937:             .Value = ""
2938:             .Visible = .T.
2939:         ENDWITH
2940:         loc_oCnt.AddObject("txt_4c_Baicos", "TextBox")
2941:         WITH loc_oCnt.txt_4c_Baicos
2942:             .Top = 125
2943:             .Left = 638
2944:             .Width = 200
2945:             .Height = 23
2946:             .FontName = "Tahoma"
2947:             .FontSize = 8
2948:             .SpecialEffect = 1
2949:             .ForeColor = RGB(0, 0, 0)
2950:             .BorderColor = RGB(100, 100, 100)
2951:             .Value = ""
2952:             .Visible = .T.
2953:         ENDWITH
2954:         loc_oCnt.AddObject("txt_4c_Nomecos", "TextBox")
2955:         WITH loc_oCnt.txt_4c_Nomecos
2956:             .Top = 165
2957:             .Left = 16
2958:             .Width = 200
2959:             .Height = 23
2960:             .FontName = "Tahoma"
2961:             .FontSize = 8
2962:             .SpecialEffect = 1
2963:             .ForeColor = RGB(0, 0, 0)
2964:             .BorderColor = RGB(100, 100, 100)
2965:             .Value = ""
2966:             .Visible = .T.
2967:         ENDWITH
2968:         loc_oCnt.AddObject("txt_4c_Complcos", "TextBox")
2969:         WITH loc_oCnt.txt_4c_Complcos
2970:             .Top = 165
2971:             .Left = 220
2972:             .Width = 200
2973:             .Height = 23
2974:             .FontName = "Tahoma"
2975:             .FontSize = 8
2976:             .SpecialEffect = 1
2977:             .ForeColor = RGB(0, 0, 0)
2978:             .BorderColor = RGB(100, 100, 100)
2979:             .Value = ""
2980:             .Visible = .T.
2981:         ENDWITH
2982:         loc_oCnt.AddObject("txt_4c_Numcos", "TextBox")
2983:         WITH loc_oCnt.txt_4c_Numcos
2984:             .Top = 165
2985:             .Left = 424
2986:             .Width = 60
2987:             .Height = 23
2988:             .FontName = "Tahoma"
2989:             .FontSize = 8
2990:             .SpecialEffect = 1
2991:             .ForeColor = RGB(0, 0, 0)
2992:             .BorderColor = RGB(100, 100, 100)
2993:             .Value = 0
2994:             .Visible = .T.
2995:         ENDWITH
2996:         loc_oCnt.AddObject("txt_4c_Paicobs2", "TextBox")
2997:         WITH loc_oCnt.txt_4c_Paicobs2
2998:             .Top = 165
2999:             .Left = 488
3000:             .Width = 100
3001:             .Height = 23
3002:             .FontName = "Tahoma"
3003:             .FontSize = 8
3004:             .SpecialEffect = 1

*-- Linhas 3014 a 3161:
3014:         par_oPagina.AddObject("cnt_4c_Pg6", "Container")
3015:         loc_oCnt = par_oPagina.cnt_4c_Pg6
3016:         WITH loc_oCnt
3017:             .Top = 107
3018:             .Left = 0
3019:             .Width = 1000
3020:             .Height = 493
3021:             .BackStyle = 0
3022:             .BorderWidth = 0
3023:             .Visible = .F.
3024:         ENDWITH
3025:         loc_oCnt.AddObject("lbl_4c_TituloP6", "Label")
3026:         WITH loc_oCnt.lbl_4c_TituloP6
3027:             .Caption = "Dados Fiscais"
3028:             .Top = 80
3029:             .Left = 40
3030:             .Width = 120
3031:             .Height = 15
3032:             .FontName = "Tahoma"
3033:             .FontSize = 10
3034:             .FontBold = .T.
3035:             .ForeColor = RGB(90, 90, 90)
3036:             .BackStyle = 0
3037:             .Visible = .T.
3038:         ENDWITH
3039:         *-- Dados fiscais: Fpubls, Cfos, Codtifs, Tpcps, Rgcs, Pis, Microemps, Optsimples
3040:         loc_oCnt.AddObject("lbl_4c_LblFpubls", "Label")
3041:         WITH loc_oCnt.lbl_4c_LblFpubls
3042:             .Caption = "Finalidade"
3043:             .Top = 110
3044:             .Left = 16
3045:             .Width = 80
3046:             .Height = 15
3047:             .FontName = "Tahoma"
3048:             .FontSize = 8
3049:             .ForeColor = RGB(90, 90, 90)
3050:             .BackStyle = 0
3051:             .Visible = .T.
3052:         ENDWITH
3053:         loc_oCnt.AddObject("txt_4c_Fpubls", "TextBox")
3054:         WITH loc_oCnt.txt_4c_Fpubls
3055:             .Top = 125
3056:             .Left = 16
3057:             .Width = 60
3058:             .Height = 23
3059:             .FontName = "Tahoma"
3060:             .FontSize = 8
3061:             .SpecialEffect = 1
3062:             .ForeColor = RGB(0, 0, 0)
3063:             .BorderColor = RGB(100, 100, 100)
3064:             .Value = ""
3065:             .Visible = .T.
3066:         ENDWITH
3067:         loc_oCnt.AddObject("txt_4c_Cfos", "TextBox")
3068:         WITH loc_oCnt.txt_4c_Cfos
3069:             .Top = 125
3070:             .Left = 80
3071:             .Width = 60
3072:             .Height = 23
3073:             .FontName = "Tahoma"
3074:             .FontSize = 8
3075:             .SpecialEffect = 1
3076:             .ForeColor = RGB(0, 0, 0)
3077:             .BorderColor = RGB(100, 100, 100)
3078:             .Value = ""
3079:             .Visible = .T.
3080:         ENDWITH
3081:         loc_oCnt.AddObject("txt_4c_Codtifs", "TextBox")
3082:         WITH loc_oCnt.txt_4c_Codtifs
3083:             .Top = 125
3084:             .Left = 144
3085:             .Width = 60
3086:             .Height = 23
3087:             .FontName = "Tahoma"
3088:             .FontSize = 8
3089:             .SpecialEffect = 1
3090:             .ForeColor = RGB(0, 0, 0)
3091:             .BorderColor = RGB(100, 100, 100)
3092:             .Value = ""
3093:             .Visible = .T.
3094:         ENDWITH
3095:         loc_oCnt.AddObject("txt_4c_Tpcps", "TextBox")
3096:         WITH loc_oCnt.txt_4c_Tpcps
3097:             .Top = 125
3098:             .Left = 208
3099:             .Width = 60
3100:             .Height = 23
3101:             .FontName = "Tahoma"
3102:             .FontSize = 8
3103:             .SpecialEffect = 1
3104:             .ForeColor = RGB(0, 0, 0)
3105:             .BorderColor = RGB(100, 100, 100)
3106:             .Value = ""
3107:             .Visible = .T.
3108:         ENDWITH
3109:         loc_oCnt.AddObject("txt_4c_Rgcs", "TextBox")
3110:         WITH loc_oCnt.txt_4c_Rgcs
3111:             .Top = 125
3112:             .Left = 272
3113:             .Width = 100
3114:             .Height = 23
3115:             .FontName = "Tahoma"
3116:             .FontSize = 8
3117:             .SpecialEffect = 1
3118:             .ForeColor = RGB(0, 0, 0)
3119:             .BorderColor = RGB(100, 100, 100)
3120:             .Value = ""
3121:             .Visible = .T.
3122:         ENDWITH
3123:         loc_oCnt.AddObject("txt_4c_Pis", "TextBox")
3124:         WITH loc_oCnt.txt_4c_Pis
3125:             .Top = 125
3126:             .Left = 376
3127:             .Width = 100
3128:             .Height = 23
3129:             .FontName = "Tahoma"
3130:             .FontSize = 8
3131:             .SpecialEffect = 1
3132:             .ForeColor = RGB(0, 0, 0)
3133:             .BorderColor = RGB(100, 100, 100)
3134:             .Value = ""
3135:             .Visible = .T.
3136:         ENDWITH
3137:         loc_oCnt.AddObject("chk_4c_Microemps", "CheckBox")
3138:         WITH loc_oCnt.chk_4c_Microemps
3139:             .Caption = "Microempresa"
3140:             .Top = 155
3141:             .Left = 16
3142:             .Width = 100
3143:             .Height = 23
3144:             .FontName = "Tahoma"
3145:             .FontSize = 8
3146:             .ForeColor = RGB(90, 90, 90)
3147:             .Alignment = 0
3148:             .SpecialEffect = 1
3149:             .Value = 0
3150:             .Visible = .T.
3151:         ENDWITH
3152:         loc_oCnt.AddObject("chk_4c_Optsimples", "CheckBox")
3153:         WITH loc_oCnt.chk_4c_Optsimples
3154:             .Caption = "Opt.Simples"
3155:             .Top = 155
3156:             .Left = 120
3157:             .Width = 100
3158:             .Height = 23
3159:             .FontName = "Tahoma"
3160:             .FontSize = 8
3161:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 3167 a 3176:
3167:         *-- Inscricao Municipal
3168:         loc_oCnt.AddObject("txt_4c_Suframas", "TextBox")
3169:         WITH loc_oCnt.txt_4c_Suframas
3170:             .Top = 190
3171:             .Left = 16
3172:             .Width = 150
3173:             .Height = 23
3174:             .FontName = "Tahoma"
3175:             .FontSize = 8
3176:             .SpecialEffect = 1

*-- Linhas 3186 a 3360:
3186:         par_oPagina.AddObject("cnt_4c_Pg7", "Container")
3187:         loc_oCnt = par_oPagina.cnt_4c_Pg7
3188:         WITH loc_oCnt
3189:             .Top = 107
3190:             .Left = 0
3191:             .Width = 1000
3192:             .Height = 493
3193:             .BackStyle = 0
3194:             .BorderWidth = 0
3195:             .Visible = .F.
3196:         ENDWITH
3197:         loc_oCnt.AddObject("lbl_4c_TituloP7", "Label")
3198:         WITH loc_oCnt.lbl_4c_TituloP7
3199:             .Caption = "Complemento"
3200:             .Top = 80
3201:             .Left = 40
3202:             .Width = 120
3203:             .Height = 15
3204:             .FontName = "Tahoma"
3205:             .FontSize = 10
3206:             .FontBold = .T.
3207:             .ForeColor = RGB(90, 90, 90)
3208:             .BackStyle = 0
3209:             .Visible = .T.
3210:         ENDWITH
3211:         *-- Campos misc: Contats, Ctelems, Rg2 (Cpfcs), Emissors, Nomearts
3212:         loc_oCnt.AddObject("lbl_4c_LblContats", "Label")
3213:         WITH loc_oCnt.lbl_4c_LblContats
3214:             .Caption = "Contatos adicionais"
3215:             .Top = 110
3216:             .Left = 16
3217:             .Width = 130
3218:             .Height = 15
3219:             .FontName = "Tahoma"
3220:             .FontSize = 8
3221:             .ForeColor = RGB(90, 90, 90)
3222:             .BackStyle = 0
3223:             .Visible = .T.
3224:         ENDWITH
3225:         loc_oCnt.AddObject("txt_4c_Contats", "TextBox")
3226:         WITH loc_oCnt.txt_4c_Contats
3227:             .Top = 125
3228:             .Left = 16
3229:             .Width = 250
3230:             .Height = 23
3231:             .FontName = "Tahoma"
3232:             .FontSize = 8
3233:             .SpecialEffect = 1
3234:             .ForeColor = RGB(0, 0, 0)
3235:             .BorderColor = RGB(100, 100, 100)
3236:             .Value = ""
3237:             .Visible = .T.
3238:         ENDWITH
3239:         loc_oCnt.AddObject("txt_4c_Ctelems", "TextBox")
3240:         WITH loc_oCnt.txt_4c_Ctelems
3241:             .Top = 125
3242:             .Left = 270
3243:             .Width = 120
3244:             .Height = 23
3245:             .FontName = "Tahoma"
3246:             .FontSize = 8
3247:             .SpecialEffect = 1
3248:             .ForeColor = RGB(0, 0, 0)
3249:             .BorderColor = RGB(100, 100, 100)
3250:             .Value = ""
3251:             .Visible = .T.
3252:         ENDWITH
3253:         loc_oCnt.AddObject("txt_4c_Nomearts", "TextBox")
3254:         WITH loc_oCnt.txt_4c_Nomearts
3255:             .Top = 125
3256:             .Left = 394
3257:             .Width = 250
3258:             .Height = 23
3259:             .FontName = "Tahoma"
3260:             .FontSize = 8
3261:             .SpecialEffect = 1
3262:             .ForeColor = RGB(0, 0, 0)
3263:             .BorderColor = RGB(100, 100, 100)
3264:             .Value = ""
3265:             .Visible = .T.
3266:         ENDWITH
3267:         loc_oCnt.AddObject("txt_4c_Emissors", "TextBox")
3268:         WITH loc_oCnt.txt_4c_Emissors
3269:             .Top = 165
3270:             .Left = 16
3271:             .Width = 100
3272:             .Height = 23
3273:             .FontName = "Tahoma"
3274:             .FontSize = 8
3275:             .SpecialEffect = 1
3276:             .ForeColor = RGB(0, 0, 0)
3277:             .BorderColor = RGB(100, 100, 100)
3278:             .Value = ""
3279:             .Visible = .T.
3280:         ENDWITH
3281:         loc_oCnt.AddObject("txt_4c_Senhas", "TextBox")
3282:         WITH loc_oCnt.txt_4c_Senhas
3283:             .Top = 165
3284:             .Left = 120
3285:             .Width = 100
3286:             .Height = 23
3287:             .FontName = "Tahoma"
3288:             .FontSize = 8
3289:             .SpecialEffect = 1
3290:             .ForeColor = RGB(0, 0, 0)
3291:             .BorderColor = RGB(100, 100, 100)
3292:             .Value = ""
3293:             .PasswordChar = "*"
3294:             .Visible = .T.
3295:         ENDWITH
3296:         *-- Coletores/Consig
3297:         loc_oCnt.AddObject("lbl_4c_LblColetors", "Label")
3298:         WITH loc_oCnt.lbl_4c_LblColetors
3299:             .Caption = "Coletor"
3300:             .Top = 200
3301:             .Left = 16
3302:             .Width = 60
3303:             .Height = 15
3304:             .FontName = "Tahoma"
3305:             .FontSize = 8
3306:             .ForeColor = RGB(90, 90, 90)
3307:             .BackStyle = 0
3308:             .Visible = .T.
3309:         ENDWITH
3310:         loc_oCnt.AddObject("txt_4c_Coletors", "TextBox")
3311:         WITH loc_oCnt.txt_4c_Coletors
3312:             .Top = 215
3313:             .Left = 16
3314:             .Width = 60
3315:             .Height = 23
3316:             .FontName = "Tahoma"
3317:             .FontSize = 8
3318:             .SpecialEffect = 1
3319:             .ForeColor = RGB(0, 0, 0)
3320:             .BorderColor = RGB(100, 100, 100)
3321:             .Value = 0
3322:             .Visible = .T.
3323:         ENDWITH
3324:         loc_oCnt.AddObject("txt_4c_Consignas", "TextBox")
3325:         WITH loc_oCnt.txt_4c_Consignas
3326:             .Top = 215
3327:             .Left = 80
3328:             .Width = 60
3329:             .Height = 23
3330:             .FontName = "Tahoma"
3331:             .FontSize = 8
3332:             .SpecialEffect = 1
3333:             .ForeColor = RGB(0, 0, 0)
3334:             .BorderColor = RGB(100, 100, 100)
3335:             .Value = 0
3336:             .Visible = .T.
3337:         ENDWITH
3338:         loc_oCnt.AddObject("txt_4c_Masters", "TextBox")
3339:         WITH loc_oCnt.txt_4c_Masters
3340:             .Top = 215
3341:             .Left = 144
3342:             .Width = 60
3343:             .Height = 23
3344:             .FontName = "Tahoma"
3345:             .FontSize = 8
3346:             .SpecialEffect = 1
3347:             .ForeColor = RGB(0, 0, 0)
3348:             .BorderColor = RGB(100, 100, 100)
3349:             .Value = 0
3350:             .Visible = .T.
3351:         ENDWITH
3352:         loc_oCnt.AddObject("txt_4c_Intconts", "TextBox")
3353:         WITH loc_oCnt.txt_4c_Intconts
3354:             .Top = 215
3355:             .Left = 208
3356:             .Width = 60
3357:             .Height = 23
3358:             .FontName = "Tahoma"
3359:             .FontSize = 8
3360:             .SpecialEffect = 1

*-- Linhas 3366 a 3389:
3366:         *-- Obs pagamento e Praca
3367:         loc_oCnt.AddObject("txt_4c_Obspagto", "TextBox")
3368:         WITH loc_oCnt.txt_4c_Obspagto
3369:             .Top = 260
3370:             .Left = 16
3371:             .Width = 400
3372:             .Height = 23
3373:             .FontName = "Tahoma"
3374:             .FontSize = 8
3375:             .SpecialEffect = 1
3376:             .ForeColor = RGB(0, 0, 0)
3377:             .BorderColor = RGB(100, 100, 100)
3378:             .Value = ""
3379:             .Visible = .T.
3380:         ENDWITH
3381:         loc_oCnt.AddObject("txt_4c_Pracas", "TextBox")
3382:         WITH loc_oCnt.txt_4c_Pracas
3383:             .Top = 260
3384:             .Left = 420
3385:             .Width = 100
3386:             .Height = 23
3387:             .FontName = "Tahoma"
3388:             .FontSize = 8
3389:             .SpecialEffect = 1

*-- Linhas 3399 a 3446:
3399:         par_oPagina.AddObject("cnt_4c_Pg8", "Container")
3400:         loc_oCnt = par_oPagina.cnt_4c_Pg8
3401:         WITH loc_oCnt
3402:             .Top = 107
3403:             .Left = 0
3404:             .Width = 1000
3405:             .Height = 493
3406:             .BackStyle = 0
3407:             .BorderWidth = 0
3408:             .Visible = .F.
3409:         ENDWITH
3410:         loc_oCnt.AddObject("lbl_4c_TituloP8", "Label")
3411:         WITH loc_oCnt.lbl_4c_TituloP8
3412:             .Caption = "Empresa"
3413:             .Top = 80
3414:             .Left = 40
3415:             .Width = 80
3416:             .Height = 15
3417:             .FontName = "Tahoma"
3418:             .FontSize = 10
3419:             .FontBold = .T.
3420:             .ForeColor = RGB(90, 90, 90)
3421:             .BackStyle = 0
3422:             .Visible = .T.
3423:         ENDWITH
3424:         *-- Empresa / usuario
3425:         loc_oCnt.AddObject("lbl_4c_LblEmps", "Label")
3426:         WITH loc_oCnt.lbl_4c_LblEmps
3427:             .Caption = "Empresa"
3428:             .Top = 110
3429:             .Left = 16
3430:             .Width = 80
3431:             .Height = 15
3432:             .FontName = "Tahoma"
3433:             .FontSize = 8
3434:             .ForeColor = RGB(90, 90, 90)
3435:             .BackStyle = 0
3436:             .Visible = .T.
3437:         ENDWITH
3438:         loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
3439:         WITH loc_oCnt.txt_4c_Emps
3440:             .Top = 125
3441:             .Left = 16
3442:             .Width = 33
3443:             .Height = 23
3444:             .FontName = "Tahoma"
3445:             .FontSize = 8
3446:             .SpecialEffect = 1

*-- Linhas 3452 a 3461:
3452:         ENDWITH
3453:         loc_oCnt.AddObject("txt_4c_Usualts", "TextBox")
3454:         WITH loc_oCnt.txt_4c_Usualts
3455:             .Top = 125
3456:             .Left = 53
3457:             .Width = 100
3458:             .Height = 23
3459:             .FontName = "Tahoma"
3460:             .FontSize = 8
3461:             .SpecialEffect = 1

*-- Linhas 3467 a 3476:
3467:         ENDWITH
3468:         loc_oCnt.AddObject("txt_4c_Usuars", "TextBox")
3469:         WITH loc_oCnt.txt_4c_Usuars
3470:             .Top = 125
3471:             .Left = 157
3472:             .Width = 100
3473:             .Height = 23
3474:             .FontName = "Tahoma"
3475:             .FontSize = 8
3476:             .SpecialEffect = 1

*-- Linhas 3483 a 3506:
3483:         *-- Gr.Produtos/Mats/Vends
3484:         loc_oCnt.AddObject("txt_4c_Gruprods2", "TextBox")
3485:         WITH loc_oCnt.txt_4c_Gruprods2
3486:             .Top = 165
3487:             .Left = 16
3488:             .Width = 80
3489:             .Height = 23
3490:             .FontName = "Tahoma"
3491:             .FontSize = 8
3492:             .SpecialEffect = 1
3493:             .ForeColor = RGB(0, 0, 0)
3494:             .BorderColor = RGB(100, 100, 100)
3495:             .Value = ""
3496:             .Visible = .T.
3497:         ENDWITH
3498:         loc_oCnt.AddObject("txt_4c_Grupovens2", "TextBox")
3499:         WITH loc_oCnt.txt_4c_Grupovens2
3500:             .Top = 165
3501:             .Left = 100
3502:             .Width = 80
3503:             .Height = 23
3504:             .FontName = "Tahoma"
3505:             .FontSize = 8
3506:             .SpecialEffect = 1

*-- Linhas 3516 a 3537:
3516:         par_oPagina.AddObject("cnt_4c_Pg9", "Container")
3517:         loc_oCnt = par_oPagina.cnt_4c_Pg9
3518:         WITH loc_oCnt
3519:             .Top = 107
3520:             .Left = 0
3521:             .Width = 1000
3522:             .Height = 493
3523:             .BackStyle = 0
3524:             .BorderWidth = 0
3525:             .Visible = .F.
3526:         ENDWITH
3527: 
3528:         loc_oCnt.AddObject("lbl_4c_TituloP9", "Label")
3529:         WITH loc_oCnt.lbl_4c_TituloP9
3530:             .Caption = "Dados Cont" + CHR(225) + "beis"
3531:             .Top = 5
3532:             .Left = 16
3533:             .Width = 200
3534:             .Height = 15
3535:             .FontName = "Tahoma"
3536:             .FontSize = 10
3537:             .FontBold = .T.

*-- Linhas 3559 a 3571:
3559: 
3560:         LOCAL loc_i
3561:         FOR loc_i = 1 TO 7
3562:             loc_oCnt.AddObject("lbl_4c_Hdr" + ALLTRIM(STR(loc_i)), "Label")
3563:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3564:                 .Caption   = loc_aHdr[loc_i,1]
3565:                 .Top       = 22
3566:                 .Left      = loc_aHdr[loc_i,2]
3567:                 .Width     = 80
3568:                 .Height    = 14
3569:                 .FontName  = "Tahoma"
3570:                 .FontSize  = 7
3571:                 .FontBold  = .T.

*-- Linhas 3606 a 3618:
3606:             loc_cSfx  = loc_aTax[loc_nTax, 2]
3607: 
3608:             *-- Label tributo
3609:             loc_oCnt.AddObject("lbl_4c_Tax" + loc_cSfx, "Label")
3610:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3611:                 .Caption   = loc_cNome
3612:                 .Top       = loc_nTop + 4
3613:                 .Left      = 16
3614:                 .Width     = 46
3615:                 .Height    = 14
3616:                 .FontName  = "Tahoma"
3617:                 .FontSize  = 8
3618:                 .FontBold  = .T.

*-- Linhas 3624 a 3633:
3624:             *-- getCdGrupos: grupo contabil (F4=lookup SigCdGcr)
3625:             loc_oCnt.AddObject("txt_4c_Gru" + loc_cSfx, "TextBox")
3626:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3627:                 .Top           = loc_nTop
3628:                 .Left          = 65
3629:                 .Width         = 80
3630:                 .Height        = 20
3631:                 .FontName      = "Tahoma"
3632:                 .FontSize      = 8
3633:                 .SpecialEffect = 1

*-- Linhas 3641 a 3650:
3641:             *-- getCdContas: codigo conta (F4=lookup SigCdCli filtrado por grupo)
3642:             loc_oCnt.AddObject("txt_4c_Cd" + loc_cSfx, "TextBox")
3643:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3644:                 .Top           = loc_nTop
3645:                 .Left          = 150
3646:                 .Width         = 80
3647:                 .Height        = 20
3648:                 .FontName      = "Tahoma"
3649:                 .FontSize      = 8
3650:                 .SpecialEffect = 1

*-- Linhas 3658 a 3667:
3658:             *-- getDsContas: descricao conta (ReadOnly, preenchido pelo lookup de conta)
3659:             loc_oCnt.AddObject("txt_4c_Ds" + loc_cSfx, "TextBox")
3660:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3661:                 .Top              = loc_nTop
3662:                 .Left             = 235
3663:                 .Width            = 200
3664:                 .Height           = 20
3665:                 .FontName         = "Tahoma"
3666:                 .FontSize         = 8
3667:                 .SpecialEffect    = 1

*-- Linhas 3676 a 3685:
3676:             *-- getPctAliqs: aliquota %
3677:             loc_oCnt.AddObject("txt_4c_Pct" + loc_cSfx, "TextBox")
3678:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3679:                 .Top           = loc_nTop
3680:                 .Left          = 438
3681:                 .Width         = 58
3682:                 .Height        = 20
3683:                 .FontName      = "Tahoma"
3684:                 .FontSize      = 8
3685:                 .SpecialEffect = 1

*-- Linhas 3693 a 3702:
3693:             *-- getReceitas: codigo de receita (1 char)
3694:             loc_oCnt.AddObject("txt_4c_Rec" + loc_cSfx, "TextBox")
3695:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3696:                 .Top           = loc_nTop
3697:                 .Left          = 500
3698:                 .Width         = 48
3699:                 .Height        = 20
3700:                 .FontName      = "Tahoma"
3701:                 .FontSize      = 8
3702:                 .SpecialEffect = 1

*-- Linhas 3708 a 3737:
3708:             ENDWITH
3709: 
3710:             *-- optSelTipos: Normal (0) / Reduzido (1)
3711:             loc_oCnt.AddObject("chk_4c_Tip" + loc_cSfx, "CheckBox")
3712:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3713:                 .Caption       = "Reduzido"
3714:                 .Top           = loc_nTop + 1
3715:                 .Left          = 552
3716:                 .Width         = 62
3717:                 .Height        = 18
3718:                 .FontName      = "Tahoma"
3719:                 .FontSize      = 7
3720:                 .Alignment     = 0
3721:                 .SpecialEffect = 1
3722:                 .Value         = 0
3723:                 .ForeColor     = RGB(60, 60, 60)
3724:                 .Visible       = .T.
3725:             ENDWITH
3726: 
3727:             *-- OptSelFI: flag nota fiscal
3728:             loc_oCnt.AddObject("chk_4c_Fin" + loc_cSfx, "CheckBox")
3729:             WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
3730:                 .Caption       = "NF"
3731:                 .Top           = loc_nTop + 1
3732:                 .Left          = 618
3733:                 .Width         = 40
3734:                 .Height        = 18
3735:                 .FontName      = "Tahoma"
3736:                 .FontSize      = 7
3737:                 .Alignment     = 0

*-- Linhas 3765 a 3888:
3765:         par_oPagina.AddObject("cnt_4c_Pg10", "Container")
3766:         loc_oCnt = par_oPagina.cnt_4c_Pg10
3767:         WITH loc_oCnt
3768:             .Top = 107
3769:             .Left = 0
3770:             .Width = 1000
3771:             .Height = 493
3772:             .BackStyle = 0
3773:             .BorderWidth = 0
3774:             .Visible = .F.
3775:         ENDWITH
3776:         loc_oCnt.AddObject("lbl_4c_TituloP10", "Label")
3777:         WITH loc_oCnt.lbl_4c_TituloP10
3778:             .Caption = "Informa" + CHR(231) + CHR(245) + "es Cadastrais"
3779:             .Top = 80
3780:             .Left = 40
3781:             .Width = 170
3782:             .Height = 15
3783:             .FontName = "Tahoma"
3784:             .FontSize = 10
3785:             .FontBold = .T.
3786:             .ForeColor = RGB(90, 90, 90)
3787:             .BackStyle = 0
3788:             .Visible = .T.
3789:         ENDWITH
3790:         *-- LGPD / Consentimentos
3791:         loc_oCnt.AddObject("chk_4c_Autdados", "CheckBox")
3792:         WITH loc_oCnt.chk_4c_Autdados
3793:             .Caption = "Autoriza dados"
3794:             .Top = 110
3795:             .Left = 16
3796:             .Width = 120
3797:             .Height = 23
3798:             .FontName = "Tahoma"
3799:             .FontSize = 8
3800:             .ForeColor = RGB(90, 90, 90)
3801:             .Alignment = 0
3802:             .SpecialEffect = 1
3803:             .Value = 0
3804:             .Visible = .T.
3805:         ENDWITH
3806:         loc_oCnt.AddObject("chk_4c_Autemail", "CheckBox")
3807:         WITH loc_oCnt.chk_4c_Autemail
3808:             .Caption = "Autoriza e-mail"
3809:             .Top = 110
3810:             .Left = 140
3811:             .Width = 120
3812:             .Height = 23
3813:             .FontName = "Tahoma"
3814:             .FontSize = 8
3815:             .ForeColor = RGB(90, 90, 90)
3816:             .Alignment = 0
3817:             .SpecialEffect = 1
3818:             .Value = 0
3819:             .Visible = .T.
3820:         ENDWITH
3821:         loc_oCnt.AddObject("chk_4c_Autsms", "CheckBox")
3822:         WITH loc_oCnt.chk_4c_Autsms
3823:             .Caption = "Autoriza SMS"
3824:             .Top = 110
3825:             .Left = 264
3826:             .Width = 110
3827:             .Height = 23
3828:             .FontName = "Tahoma"
3829:             .FontSize = 8
3830:             .ForeColor = RGB(90, 90, 90)
3831:             .Alignment = 0
3832:             .SpecialEffect = 1
3833:             .Value = 0
3834:             .Visible = .T.
3835:         ENDWITH
3836:         loc_oCnt.AddObject("chk_4c_Autwhats", "CheckBox")
3837:         WITH loc_oCnt.chk_4c_Autwhats
3838:             .Caption = "Autoriza Whats"
3839:             .Top = 110
3840:             .Left = 378
3841:             .Width = 120
3842:             .Height = 23
3843:             .FontName = "Tahoma"
3844:             .FontSize = 8
3845:             .ForeColor = RGB(90, 90, 90)
3846:             .Alignment = 0
3847:             .SpecialEffect = 1
3848:             .Value = 0
3849:             .Visible = .T.
3850:         ENDWITH
3851:         loc_oCnt.AddObject("chk_4c_Autteleg", "CheckBox")
3852:         WITH loc_oCnt.chk_4c_Autteleg
3853:             .Caption = "Autoriza Telegram"
3854:             .Top = 110
3855:             .Left = 502
3856:             .Width = 130
3857:             .Height = 23
3858:             .FontName = "Tahoma"
3859:             .FontSize = 8
3860:             .ForeColor = RGB(90, 90, 90)
3861:             .Alignment = 0
3862:             .SpecialEffect = 1
3863:             .Value = 0
3864:             .Visible = .T.
3865:         ENDWITH
3866:         *-- Obs e Cobs
3867:         loc_oCnt.AddObject("lbl_4c_LblCobs", "Label")
3868:         WITH loc_oCnt.lbl_4c_LblCobs
3869:             .Caption = "Observa" + CHR(231) + CHR(245) + "es Cobran" + CHR(231) + "a"
3870:             .Top = 150
3871:             .Left = 16
3872:             .Width = 170
3873:             .Height = 15
3874:             .FontName = "Tahoma"
3875:             .FontSize = 8
3876:             .ForeColor = RGB(90, 90, 90)
3877:             .BackStyle = 0
3878:             .Visible = .T.
3879:         ENDWITH
3880:         loc_oCnt.AddObject("txt_4c_Cobs", "TextBox")
3881:         WITH loc_oCnt.txt_4c_Cobs
3882:             .Top = 165
3883:             .Left = 16
3884:             .Width = 600
3885:             .Height = 23
3886:             .FontName = "Tahoma"
3887:             .FontSize = 8
3888:             .SpecialEffect = 1

*-- Linhas 3894 a 3917:
3894:         *-- Datas especiais
3895:         loc_oCnt.AddObject("txt_4c_Dtcasas", "TextBox")
3896:         WITH loc_oCnt.txt_4c_Dtcasas
3897:             .Top = 210
3898:             .Left = 16
3899:             .Width = 80
3900:             .Height = 23
3901:             .FontName = "Tahoma"
3902:             .FontSize = 8
3903:             .SpecialEffect = 1
3904:             .ForeColor = RGB(0, 0, 0)
3905:             .BorderColor = RGB(100, 100, 100)
3906:             .Value = {}
3907:             .Visible = .T.
3908:         ENDWITH
3909:         loc_oCnt.AddObject("txt_4c_Dtncons", "TextBox")
3910:         WITH loc_oCnt.txt_4c_Dtncons
3911:             .Top = 210
3912:             .Left = 100
3913:             .Width = 80
3914:             .Height = 23
3915:             .FontName = "Tahoma"
3916:             .FontSize = 8
3917:             .SpecialEffect = 1

*-- Linhas 3923 a 3960:
3923:         *-- Maes/Pais/GrauParentesco
3924:         loc_oCnt.AddObject("txt_4c_Maes", "TextBox")
3925:         WITH loc_oCnt.txt_4c_Maes
3926:             .Top = 250
3927:             .Left = 16
3928:             .Width = 200
3929:             .Height = 23
3930:             .FontName = "Tahoma"
3931:             .FontSize = 8
3932:             .SpecialEffect = 1
3933:             .ForeColor = RGB(0, 0, 0)
3934:             .BorderColor = RGB(100, 100, 100)
3935:             .Value = ""
3936:             .Visible = .T.
3937:         ENDWITH
3938:         loc_oCnt.AddObject("txt_4c_Pais2", "TextBox")
3939:         WITH loc_oCnt.txt_4c_Pais2
3940:             .Top = 250
3941:             .Left = 220
3942:             .Width = 200
3943:             .Height = 23
3944:             .FontName = "Tahoma"
3945:             .FontSize = 8
3946:             .SpecialEffect = 1
3947:             .ForeColor = RGB(0, 0, 0)
3948:             .BorderColor = RGB(100, 100, 100)
3949:             .Value = ""
3950:             .Visible = .T.
3951:         ENDWITH
3952:         loc_oCnt.AddObject("txt_4c_Graupares", "TextBox")
3953:         WITH loc_oCnt.txt_4c_Graupares
3954:             .Top = 250
3955:             .Left = 424
3956:             .Width = 80
3957:             .Height = 23
3958:             .FontName = "Tahoma"
3959:             .FontSize = 8
3960:             .SpecialEffect = 1

*-- Linhas 3970 a 4167:
3970:         par_oPagina.AddObject("cnt_4c_Pg11", "Container")
3971:         loc_oCnt = par_oPagina.cnt_4c_Pg11
3972:         WITH loc_oCnt
3973:             .Top = 107
3974:             .Left = 0
3975:             .Width = 1000
3976:             .Height = 493
3977:             .BackStyle = 0
3978:             .BorderWidth = 0
3979:             .Visible = .F.
3980:         ENDWITH
3981:         loc_oCnt.AddObject("lbl_4c_TituloP11", "Label")
3982:         WITH loc_oCnt.lbl_4c_TituloP11
3983:             .Caption = "Caracter" + CHR(237) + "sticas"
3984:             .Top = 80
3985:             .Left = 40
3986:             .Width = 120
3987:             .Height = 15
3988:             .FontName = "Tahoma"
3989:             .FontSize = 10
3990:             .FontBold = .T.
3991:             .ForeColor = RGB(90, 90, 90)
3992:             .BackStyle = 0
3993:             .Visible = .T.
3994:         ENDWITH
3995:         *-- Flags numericos
3996:         loc_oCnt.AddObject("chk_4c_Gerbals", "CheckBox")
3997:         WITH loc_oCnt.chk_4c_Gerbals
3998:             .Caption = "Geracao Boleto"
3999:             .Top = 110
4000:             .Left = 16
4001:             .Width = 120
4002:             .Height = 23
4003:             .FontName = "Tahoma"
4004:             .FontSize = 8
4005:             .ForeColor = RGB(90, 90, 90)
4006:             .Alignment = 0
4007:             .SpecialEffect = 1
4008:             .Value = 0
4009:             .Visible = .T.
4010:         ENDWITH
4011:         loc_oCnt.AddObject("chk_4c_Pagfals", "CheckBox")
4012:         WITH loc_oCnt.chk_4c_Pagfals
4013:             .Caption = "Pag.Falso"
4014:             .Top = 110
4015:             .Left = 140
4016:             .Width = 90
4017:             .Height = 23
4018:             .FontName = "Tahoma"
4019:             .FontSize = 8
4020:             .ForeColor = RGB(90, 90, 90)
4021:             .Alignment = 0
4022:             .SpecialEffect = 1
4023:             .Value = 0
4024:             .Visible = .T.
4025:         ENDWITH
4026:         loc_oCnt.AddObject("chk_4c_Recfals", "CheckBox")
4027:         WITH loc_oCnt.chk_4c_Recfals
4028:             .Caption = "Rec.Falso"
4029:             .Top = 110
4030:             .Left = 234
4031:             .Width = 90
4032:             .Height = 23
4033:             .FontName = "Tahoma"
4034:             .FontSize = 8
4035:             .ForeColor = RGB(90, 90, 90)
4036:             .Alignment = 0
4037:             .SpecialEffect = 1
4038:             .Value = 0
4039:             .Visible = .T.
4040:         ENDWITH
4041:         loc_oCnt.AddObject("chk_4c_Valemail", "CheckBox")
4042:         WITH loc_oCnt.chk_4c_Valemail
4043:             .Caption = "Valida Email"
4044:             .Top = 140
4045:             .Left = 16
4046:             .Width = 100
4047:             .Height = 23
4048:             .FontName = "Tahoma"
4049:             .FontSize = 8
4050:             .ForeColor = RGB(90, 90, 90)
4051:             .Alignment = 0
4052:             .SpecialEffect = 1
4053:             .Value = 0
4054:             .Visible = .T.
4055:         ENDWITH
4056:         loc_oCnt.AddObject("chk_4c_Invisivel", "CheckBox")
4057:         WITH loc_oCnt.chk_4c_Invisivel
4058:             .Caption = "Invisivel"
4059:             .Top = 140
4060:             .Left = 120
4061:             .Width = 80
4062:             .Height = 23
4063:             .FontName = "Tahoma"
4064:             .FontSize = 8
4065:             .ForeColor = RGB(90, 90, 90)
4066:             .Alignment = 0
4067:             .SpecialEffect = 1
4068:             .Value = 0
4069:             .Visible = .T.
4070:         ENDWITH
4071:         loc_oCnt.AddObject("chk_4c_Aptos", "CheckBox")
4072:         WITH loc_oCnt.chk_4c_Aptos
4073:             .Caption = "Apto"
4074:             .Top = 140
4075:             .Left = 204
4076:             .Width = 60
4077:             .Height = 23
4078:             .FontName = "Tahoma"
4079:             .FontSize = 8
4080:             .ForeColor = RGB(90, 90, 90)
4081:             .Alignment = 0
4082:             .SpecialEffect = 1
4083:             .Value = 0
4084:             .Visible = .T.
4085:         ENDWITH
4086:         loc_oCnt.AddObject("chk_4c_Patrietqs", "CheckBox")
4087:         WITH loc_oCnt.chk_4c_Patrietqs
4088:             .Caption = "Patrim.Eq"
4089:             .Top = 170
4090:             .Left = 16
4091:             .Width = 90
4092:             .Height = 23
4093:             .FontName = "Tahoma"
4094:             .FontSize = 8
4095:             .ForeColor = RGB(90, 90, 90)
4096:             .Alignment = 0
4097:             .SpecialEffect = 1
4098:             .Value = 0
4099:             .Visible = .T.
4100:         ENDWITH
4101:         loc_oCnt.AddObject("chk_4c_Restfors", "CheckBox")
4102:         WITH loc_oCnt.chk_4c_Restfors
4103:             .Caption = "Rest.Formas"
4104:             .Top = 170
4105:             .Left = 110
4106:             .Width = 100
4107:             .Height = 23
4108:             .FontName = "Tahoma"
4109:             .FontSize = 8
4110:             .ForeColor = RGB(90, 90, 90)
4111:             .Alignment = 0
4112:             .SpecialEffect = 1
4113:             .Value = 0
4114:             .Visible = .T.
4115:         ENDWITH
4116:         loc_oCnt.AddObject("chk_4c_Consigs", "CheckBox")
4117:         WITH loc_oCnt.chk_4c_Consigs
4118:             .Caption = "Consigna" + CHR(231) + CHR(227) + "o"
4119:             .Top = 170
4120:             .Left = 214
4121:             .Width = 110
4122:             .Height = 23
4123:             .FontName = "Tahoma"
4124:             .FontSize = 8
4125:             .ForeColor = RGB(90, 90, 90)
4126:             .Alignment = 0
4127:             .SpecialEffect = 1
4128:             .Value = 0
4129:             .Visible = .T.
4130:         ENDWITH
4131:         *-- EAN
4132:         loc_oCnt.AddObject("lbl_4c_LblEan13ents", "Label")
4133:         WITH loc_oCnt.lbl_4c_LblEan13ents
4134:             .Caption = "EAN13 Entrada"
4135:             .Top = 210
4136:             .Left = 16
4137:             .Width = 100
4138:             .Height = 15
4139:             .FontName = "Tahoma"
4140:             .FontSize = 8
4141:             .ForeColor = RGB(90, 90, 90)
4142:             .BackStyle = 0
4143:             .Visible = .T.
4144:         ENDWITH
4145:         loc_oCnt.AddObject("txt_4c_Ean13ents", "TextBox")
4146:         WITH loc_oCnt.txt_4c_Ean13ents
4147:             .Top = 225
4148:             .Left = 16
4149:             .Width = 80
4150:             .Height = 23
4151:             .FontName = "Tahoma"
4152:             .FontSize = 8
4153:             .SpecialEffect = 1
4154:             .ForeColor = RGB(0, 0, 0)
4155:             .BorderColor = RGB(100, 100, 100)
4156:             .Value = 0
4157:             .Visible = .T.
4158:         ENDWITH
4159:         loc_oCnt.AddObject("txt_4c_Ean13cobs", "TextBox")
4160:         WITH loc_oCnt.txt_4c_Ean13cobs
4161:             .Top = 225
4162:             .Left = 100
4163:             .Width = 80
4164:             .Height = 23
4165:             .FontName = "Tahoma"
4166:             .FontSize = 8
4167:             .SpecialEffect = 1

*-- Linhas 4177 a 4252:
4177:         par_oPagina.AddObject("cnt_4c_Pg12", "Container")
4178:         loc_oCnt = par_oPagina.cnt_4c_Pg12
4179:         WITH loc_oCnt
4180:             .Top = 107
4181:             .Left = 0
4182:             .Width = 1000
4183:             .Height = 493
4184:             .BackStyle = 0
4185:             .BorderWidth = 0
4186:             .Visible = .F.
4187:         ENDWITH
4188:         loc_oCnt.AddObject("lbl_4c_TituloP12", "Label")
4189:         WITH loc_oCnt.lbl_4c_TituloP12
4190:             .Caption = "Perfil"
4191:             .Top = 80
4192:             .Left = 40
4193:             .Width = 80
4194:             .Height = 15
4195:             .FontName = "Tahoma"
4196:             .FontSize = 10
4197:             .FontBold = .T.
4198:             .ForeColor = RGB(90, 90, 90)
4199:             .BackStyle = 0
4200:             .Visible = .T.
4201:         ENDWITH
4202:         *-- Perfil (memo)
4203:         loc_oCnt.AddObject("lbl_4c_LblPerfil", "Label")
4204:         WITH loc_oCnt.lbl_4c_LblPerfil
4205:             .Caption = "Perfil do Cliente"
4206:             .Top = 110
4207:             .Left = 16
4208:             .Width = 120
4209:             .Height = 15
4210:             .FontName = "Tahoma"
4211:             .FontSize = 8
4212:             .ForeColor = RGB(90, 90, 90)
4213:             .BackStyle = 0
4214:             .Visible = .T.
4215:         ENDWITH
4216:         loc_oCnt.AddObject("edt_4c_Perfils", "EditBox")
4217:         WITH loc_oCnt.edt_4c_Perfils
4218:             .Top = 125
4219:             .Left = 16
4220:             .Width = 745
4221:             .Height = 300
4222:             .FontName = "Tahoma"
4223:             .FontSize = 8
4224:             .SpecialEffect = 1
4225:             .ForeColor = RGB(0, 0, 0)
4226:             .BorderColor = RGB(100, 100, 100)
4227:             .Value = ""
4228:             .Visible = .T.
4229:         ENDWITH
4230:         *-- Pastas
4231:         loc_oCnt.AddObject("lbl_4c_LblPastas", "Label")
4232:         WITH loc_oCnt.lbl_4c_LblPastas
4233:             .Caption = "Pastas"
4234:             .Top = 435
4235:             .Left = 16
4236:             .Width = 60
4237:             .Height = 15
4238:             .FontName = "Tahoma"
4239:             .FontSize = 8
4240:             .ForeColor = RGB(90, 90, 90)
4241:             .BackStyle = 0
4242:             .Visible = .T.
4243:         ENDWITH
4244:         loc_oCnt.AddObject("txt_4c_Pastas", "TextBox")
4245:         WITH loc_oCnt.txt_4c_Pastas
4246:             .Top = 450
4247:             .Left = 16
4248:             .Width = 300
4249:             .Height = 23
4250:             .FontName = "Tahoma"
4251:             .FontSize = 8
4252:             .SpecialEffect = 1

*-- Linhas 4348 a 4360:
4348:                     .Column3.ControlSource   = "cursor_4c_Dados.Cpfs"
4349:                     .Column4.ControlSource   = "cursor_4c_Dados.Ultcomps"
4350:                     .Column5.ControlSource   = "cursor_4c_Dados.DtAlts"
4351:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
4352:                     .Column2.Header1.Caption = "Nome"
4353:                     .Column3.Header1.Caption = "CPF / CNPJ"
4354:                     .Column4.Header1.Caption = CHR(218) + "lt.Compra"
4355:                     .Column5.Header1.Caption = "Alterado em"
4356:                     .Refresh()
4357:                 ENDWITH
4358:             ENDIF
4359: 
4360:         CATCH TO loException

*-- Linhas 4386 a 4401:
4386:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
4387:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
4388: 
4389:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
4390:             loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
4391:         ENDIF
4392:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
4393:             loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
4394:         ENDIF
4395:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
4396:             loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
4397:         ENDIF
4398:     ENDPROC
4399: 
4400:     *===========================================================================
4401:     * FormParaBO - Transfere dados dos controles para o BO

*-- Linhas 4623 a 4980:
4623:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg1", 5)
4624:                 loc_oP = loc_oPg2.cnt_4c_Pg1
4625:                 IF PEMSTATUS(loc_oP,"txt_4c_Grupos",5)
4626:                     loc_oP.txt_4c_Grupos.Value = .this_cGrupos
4627:                 ENDIF
4628:                 IF PEMSTATUS(loc_oP,"txt_4c_IClis",5)
4629:                     loc_oP.txt_4c_IClis.Value = .this_cIClis
4630:                 ENDIF
4631:                 IF PEMSTATUS(loc_oP,"txt_4c_Rclis",5)
4632:                     loc_oP.txt_4c_Rclis.Value = .this_cRclis
4633:                 ENDIF
4634:                 IF PEMSTATUS(loc_oP,"txt_4c_Razaos",5)
4635:                     loc_oP.txt_4c_Razaos.Value = .this_cRazaos
4636:                 ENDIF
4637:                 IF PEMSTATUS(loc_oP,"txt_4c_Cpfs",5)
4638:                     loc_oP.txt_4c_Cpfs.Value = .this_cCpfs
4639:                 ENDIF
4640:                 IF PEMSTATUS(loc_oP,"txt_4c_Rgs",5)
4641:                     loc_oP.txt_4c_Rgs.Value = .this_cRgs
4642:                 ENDIF
4643:                 IF PEMSTATUS(loc_oP,"txt_4c_Situas",5)
4644:                     loc_oP.txt_4c_Situas.Value = .this_cSituas
4645:                 ENDIF
4646:                 IF PEMSTATUS(loc_oP,"txt_4c_Inscmuns",5)
4647:                     loc_oP.txt_4c_Inscmuns.Value = .this_cInscmuns
4648:                 ENDIF
4649:                 IF PEMSTATUS(loc_oP,"chk_4c_Inativas",5)
4650:                     loc_oP.chk_4c_Inativas.Value = IIF(.this_nInativas=1,1,0)
4651:                 ENDIF
4652:                 IF PEMSTATUS(loc_oP,"txt_4c_Codigos",5)
4653:                     loc_oP.txt_4c_Codigos.Value = .this_cCodigos
4654:                 ENDIF
4655:                 IF PEMSTATUS(loc_oP,"txt_4c_Grupovens",5)
4656:                     loc_oP.txt_4c_Grupovens.Value = .this_cGrupovens
4657:                 ENDIF
4658:                 IF PEMSTATUS(loc_oP,"txt_4c_Nascs",5)
4659:                     loc_oP.txt_4c_Nascs.Value = .this_dNascs
4660:                 ENDIF
4661:                 IF PEMSTATUS(loc_oP,"txt_4c_Nacionals",5)
4662:                     loc_oP.txt_4c_Nacionals.Value = .this_cNacionals
4663:                 ENDIF
4664:                 IF PEMSTATUS(loc_oP,"txt_4c_Sexos",5)
4665:                     loc_oP.txt_4c_Sexos.Value = .this_cSexos
4666:                 ENDIF
4667:                 IF PEMSTATUS(loc_oP,"cmb_4c_Estcivils",5)
4668:                     loc_oP.cmb_4c_Estcivils.Value = .this_cEstcivils
4669:                 ENDIF
4670:                 IF PEMSTATUS(loc_oP,"txt_4c_Conjuges",5)
4671:                     loc_oP.txt_4c_Conjuges.Value = .this_cConjuges
4672:                 ENDIF
4673:                 IF PEMSTATUS(loc_oP,"txt_4c_Cpfcs",5)
4674:                     loc_oP.txt_4c_Cpfcs.Value = .this_cCpfcs
4675:                 ENDIF
4676:                 IF PEMSTATUS(loc_oP,"txt_4c_Rgconjuges",5)
4677:                     loc_oP.txt_4c_Rgconjuges.Value = .this_cRgconjuges
4678:                 ENDIF
4679:                 IF PEMSTATUS(loc_oP,"txt_4c_Idcontas",5)
4680:                     loc_oP.txt_4c_Idcontas.Value = .this_nIdcontas
4681:                 ENDIF
4682:                 IF PEMSTATUS(loc_oP,"txt_4c_Ceps",5)
4683:                     loc_oP.txt_4c_Ceps.Value = .this_cCeps
4684:                 ENDIF
4685:                 IF PEMSTATUS(loc_oP,"txt_4c_Paises",5)
4686:                     loc_oP.txt_4c_Paises.Value = .this_cPaises
4687:                 ENDIF
4688:                 IF PEMSTATUS(loc_oP,"txt_4c_Regiaos",5)
4689:                     loc_oP.txt_4c_Regiaos.Value = .this_cRegiaos
4690:                 ENDIF
4691:                 IF PEMSTATUS(loc_oP,"txt_4c_Endes",5)
4692:                     loc_oP.txt_4c_Endes.Value = .this_cEndes
4693:                 ENDIF
4694:                 IF PEMSTATUS(loc_oP,"txt_4c_Nums",5)
4695:                     loc_oP.txt_4c_Nums.Value = .this_cNums
4696:                 ENDIF
4697:                 IF PEMSTATUS(loc_oP,"txt_4c_Compls",5)
4698:                     loc_oP.txt_4c_Compls.Value = .this_cCompls
4699:                 ENDIF
4700:                 IF PEMSTATUS(loc_oP,"txt_4c_Bairs",5)
4701:                     loc_oP.txt_4c_Bairs.Value = .this_cBairs
4702:                 ENDIF
4703:                 IF PEMSTATUS(loc_oP,"txt_4c_Cidas",5)
4704:                     loc_oP.txt_4c_Cidas.Value = .this_cCidas
4705:                 ENDIF
4706:                 IF PEMSTATUS(loc_oP,"txt_4c_Estas",5)
4707:                     loc_oP.txt_4c_Estas.Value = .this_cEstas
4708:                 ENDIF
4709:                 IF PEMSTATUS(loc_oP,"txt_4c_Ddds",5)
4710:                     loc_oP.txt_4c_Ddds.Value = .this_cDdds
4711:                 ENDIF
4712:                 IF PEMSTATUS(loc_oP,"txt_4c_Tel1s",5)
4713:                     loc_oP.txt_4c_Tel1s.Value = .this_cTel1s
4714:                 ENDIF
4715:                 IF PEMSTATUS(loc_oP,"txt_4c_Tel2s",5)
4716:                     loc_oP.txt_4c_Tel2s.Value = .this_cTel2s
4717:                 ENDIF
4718:                 IF PEMSTATUS(loc_oP,"txt_4c_Faxs",5)
4719:                     loc_oP.txt_4c_Faxs.Value = .this_cFaxs
4720:                 ENDIF
4721:                 IF PEMSTATUS(loc_oP,"txt_4c_Profiss",5)
4722:                     loc_oP.txt_4c_Profiss.Value = .this_cProfiss
4723:                 ENDIF
4724:                 IF PEMSTATUS(loc_oP,"txt_4c_Emails",5)
4725:                     loc_oP.txt_4c_Emails.Value = .this_cEmails
4726:                 ENDIF
4727:                 IF PEMSTATUS(loc_oP,"txt_4c_Contato",5)
4728:                     loc_oP.txt_4c_Contato.Value = .this_cContato
4729:                 ENDIF
4730:                 IF PEMSTATUS(loc_oP,"edt_4c_Obs",5)
4731:                     loc_oP.edt_4c_Obs.Value = .this_mObs
4732:                 ENDIF
4733:                 IF PEMSTATUS(loc_oP,"txt_4c_Ultcomps",5)
4734:                     loc_oP.txt_4c_Ultcomps.Value = .this_dUltcomps
4735:                 ENDIF
4736:                 IF PEMSTATUS(loc_oP,"txt_4c_Dtvals",5)
4737:                     loc_oP.txt_4c_Dtvals.Value = .this_dDtvals
4738:                 ENDIF
4739:                 IF PEMSTATUS(loc_oP,"txt_4c_Dataincs",5)
4740:                     loc_oP.txt_4c_Dataincs.Value = .this_dDataincs
4741:                 ENDIF
4742:                 IF PEMSTATUS(loc_oP,"txt_4c_Dtalts",5)
4743:                     loc_oP.txt_4c_Dtalts.Value = .this_dDtalts
4744:                 ENDIF
4745:             ENDIF
4746: 
4747:             *-- Sub-pagina 2
4748:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg2", 5)
4749:                 loc_oP = loc_oPg2.cnt_4c_Pg2
4750:                 IF PEMSTATUS(loc_oP,"txt_4c_Tpcads",5)
4751:                     loc_oP.txt_4c_Tpcads.Value = .this_nTpcads
4752:                 ENDIF
4753:                 IF PEMSTATUS(loc_oP,"txt_4c_Tpclis",5)
4754:                     loc_oP.txt_4c_Tpclis.Value = .this_nTpclis
4755:                 ENDIF
4756:                 IF PEMSTATUS(loc_oP,"txt_4c_Tabds",5)
4757:                     loc_oP.txt_4c_Tabds.Value = .this_cTabds
4758:                 ENDIF
4759:                 IF PEMSTATUS(loc_oP,"txt_4c_Tabd2s",5)
4760:                     loc_oP.txt_4c_Tabd2s.Value = .this_cTabd2s
4761:                 ENDIF
4762:                 IF PEMSTATUS(loc_oP,"txt_4c_Lprecos",5)
4763:                     loc_oP.txt_4c_Lprecos.Value = .this_cLprecos
4764:                 ENDIF
4765:                 IF PEMSTATUS(loc_oP,"txt_4c_Prazoents",5)
4766:                     loc_oP.txt_4c_Prazoents.Value = .this_nPrazoents
4767:                 ENDIF
4768:                 IF PEMSTATUS(loc_oP,"txt_4c_Codsegs",5)
4769:                     loc_oP.txt_4c_Codsegs.Value = .this_cCodsegs
4770:                 ENDIF
4771:                 IF PEMSTATUS(loc_oP,"txt_4c_Limcres",5)
4772:                     loc_oP.txt_4c_Limcres.Value = .this_nLimcres
4773:                 ENDIF
4774:                 IF PEMSTATUS(loc_oP,"txt_4c_Juros",5)
4775:                     loc_oP.txt_4c_Juros.Value = .this_nJuros
4776:                 ENDIF
4777:                 IF PEMSTATUS(loc_oP,"txt_4c_Percdescli",5)
4778:                     loc_oP.txt_4c_Percdescli.Value = .this_nPercdescli
4779:                 ENDIF
4780:                 IF PEMSTATUS(loc_oP,"txt_4c_Comis",5)
4781:                     loc_oP.txt_4c_Comis.Value = .this_nComis
4782:                 ENDIF
4783:                 IF PEMSTATUS(loc_oP,"txt_4c_Grupocobs",5)
4784:                     loc_oP.txt_4c_Grupocobs.Value = .this_cGrupocobs
4785:                 ENDIF
4786:                 IF PEMSTATUS(loc_oP,"txt_4c_Gruprods",5)
4787:                     loc_oP.txt_4c_Gruprods.Value = .this_cGruprods
4788:                 ENDIF
4789:                 IF PEMSTATUS(loc_oP,"txt_4c_Grupocents",5)
4790:                     loc_oP.txt_4c_Grupocents.Value = .this_cGrupocents
4791:                 ENDIF
4792:                 IF PEMSTATUS(loc_oP,"txt_4c_Grupomats",5)
4793:                     loc_oP.txt_4c_Grupomats.Value = .this_cGrupomats
4794:                 ENDIF
4795:                 IF PEMSTATUS(loc_oP,"txt_4c_Contacobs",5)
4796:                     loc_oP.txt_4c_Contacobs.Value = .this_cContacobs
4797:                 ENDIF
4798:                 IF PEMSTATUS(loc_oP,"txt_4c_Contamats",5)
4799:                     loc_oP.txt_4c_Contamats.Value = .this_cContamats
4800:                 ENDIF
4801:                 IF PEMSTATUS(loc_oP,"txt_4c_Contavens",5)
4802:                     loc_oP.txt_4c_Contavens.Value = .this_cContavens
4803:                 ENDIF
4804:                 IF PEMSTATUS(loc_oP,"txt_4c_Contaven2s",5)
4805:                     loc_oP.txt_4c_Contaven2s.Value = .this_cContaven2s
4806:                 ENDIF
4807:                 IF PEMSTATUS(loc_oP,"txt_4c_Contacents",5)
4808:                     loc_oP.txt_4c_Contacents.Value = .this_cContacents
4809:                 ENDIF
4810:                 IF PEMSTATUS(loc_oP,"txt_4c_Conprods",5)
4811:                     loc_oP.txt_4c_Conprods.Value = .this_cConprods
4812:                 ENDIF
4813:                 IF PEMSTATUS(loc_oP,"txt_4c_Ccontabs",5)
4814:                     loc_oP.txt_4c_Ccontabs.Value = .this_cCcontabs
4815:                 ENDIF
4816:             ENDIF
4817: 
4818:             *-- Sub-paginas 3-12 (mapeamento simplificado)
4819:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg3",5)
4820:                 loc_oP = loc_oPg2.cnt_4c_Pg3
4821:                 IF PEMSTATUS(loc_oP,"txt_4c_Endcobs",5)
4822:                     loc_oP.txt_4c_Endcobs.Value = .this_cEndcobs
4823:                 ENDIF
4824:                 IF PEMSTATUS(loc_oP,"txt_4c_Cepcobs",5)
4825:                     loc_oP.txt_4c_Cepcobs.Value = .this_cCepcobs
4826:                 ENDIF
4827:                 IF PEMSTATUS(loc_oP,"txt_4c_Cidcobs",5)
4828:                     loc_oP.txt_4c_Cidcobs.Value = .this_cCidcobs
4829:                 ENDIF
4830:                 IF PEMSTATUS(loc_oP,"txt_4c_Estcobs",5)
4831:                     loc_oP.txt_4c_Estcobs.Value = .this_cEstcobs
4832:                 ENDIF
4833:                 IF PEMSTATUS(loc_oP,"txt_4c_Baicobs",5)
4834:                     loc_oP.txt_4c_Baicobs.Value = .this_cBaicobs
4835:                 ENDIF
4836:                 IF PEMSTATUS(loc_oP,"txt_4c_Paicobs",5)
4837:                     loc_oP.txt_4c_Paicobs.Value = .this_cPaicobs
4838:                 ENDIF
4839:             ENDIF
4840:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg4",5)
4841:                 loc_oP = loc_oPg2.cnt_4c_Pg4
4842:                 IF PEMSTATUS(loc_oP,"txt_4c_Endtrabs",5)
4843:                     loc_oP.txt_4c_Endtrabs.Value = .this_cEndtrabs
4844:                 ENDIF
4845:                 IF PEMSTATUS(loc_oP,"txt_4c_Ceptrabs",5)
4846:                     loc_oP.txt_4c_Ceptrabs.Value = .this_cCeptrabs
4847:                 ENDIF
4848:                 IF PEMSTATUS(loc_oP,"txt_4c_Cidtrabs",5)
4849:                     loc_oP.txt_4c_Cidtrabs.Value = .this_cCidtrabs
4850:                 ENDIF
4851:                 IF PEMSTATUS(loc_oP,"txt_4c_Esttrabs",5)
4852:                     loc_oP.txt_4c_Esttrabs.Value = .this_cEsttrabs
4853:                 ENDIF
4854:                 IF PEMSTATUS(loc_oP,"txt_4c_Bairtrabs",5)
4855:                     loc_oP.txt_4c_Bairtrabs.Value = .this_cBairtrabs
4856:                 ENDIF
4857:                 IF PEMSTATUS(loc_oP,"txt_4c_Numtrabs",5)
4858:                     loc_oP.txt_4c_Numtrabs.Value = .this_cNumtrabs
4859:                 ENDIF
4860:                 IF PEMSTATUS(loc_oP,"txt_4c_Compltrabs",5)
4861:                     loc_oP.txt_4c_Compltrabs.Value = .this_cCompltrabs
4862:                 ENDIF
4863:                 IF PEMSTATUS(loc_oP,"txt_4c_Emptrabs",5)
4864:                     loc_oP.txt_4c_Emptrabs.Value = .this_cEmptrabs
4865:                 ENDIF
4866:                 IF PEMSTATUS(loc_oP,"txt_4c_Cnpjtrabs",5)
4867:                     loc_oP.txt_4c_Cnpjtrabs.Value = .this_cCnpjtrabs
4868:                 ENDIF
4869:                 IF PEMSTATUS(loc_oP,"txt_4c_Teltrabs",5)
4870:                     loc_oP.txt_4c_Teltrabs.Value = .this_cTeltrabs
4871:                 ENDIF
4872:                 IF PEMSTATUS(loc_oP,"txt_4c_Paitrabs",5)
4873:                     loc_oP.txt_4c_Paitrabs.Value = .this_cPaitrabs
4874:                 ENDIF
4875:             ENDIF
4876:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg5",5)
4877:                 loc_oP = loc_oPg2.cnt_4c_Pg5
4878:                 IF PEMSTATUS(loc_oP,"txt_4c_Endcos",5)
4879:                     loc_oP.txt_4c_Endcos.Value = .this_cEndcos
4880:                 ENDIF
4881:                 IF PEMSTATUS(loc_oP,"txt_4c_Cepcos",5)
4882:                     loc_oP.txt_4c_Cepcos.Value = .this_cCepcos
4883:                 ENDIF
4884:                 IF PEMSTATUS(loc_oP,"txt_4c_Cidcos",5)
4885:                     loc_oP.txt_4c_Cidcos.Value = .this_cCidcos
4886:                 ENDIF
4887:                 IF PEMSTATUS(loc_oP,"txt_4c_Estcos",5)
4888:                     loc_oP.txt_4c_Estcos.Value = .this_cEstcos
4889:                 ENDIF
4890:                 IF PEMSTATUS(loc_oP,"txt_4c_Baicos",5)
4891:                     loc_oP.txt_4c_Baicos.Value = .this_cBaicos
4892:                 ENDIF
4893:                 IF PEMSTATUS(loc_oP,"txt_4c_Nomecos",5)
4894:                     loc_oP.txt_4c_Nomecos.Value = .this_cNomecos
4895:                 ENDIF
4896:                 IF PEMSTATUS(loc_oP,"txt_4c_Complcos",5)
4897:                     loc_oP.txt_4c_Complcos.Value = .this_cComplcos
4898:                 ENDIF
4899:                 IF PEMSTATUS(loc_oP,"txt_4c_Numcos",5)
4900:                     loc_oP.txt_4c_Numcos.Value = .this_nNumcos
4901:                 ENDIF
4902:             ENDIF
4903:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg6",5)
4904:                 loc_oP = loc_oPg2.cnt_4c_Pg6
4905:                 IF PEMSTATUS(loc_oP,"txt_4c_Fpubls",5)
4906:                     loc_oP.txt_4c_Fpubls.Value = .this_cFpubls
4907:                 ENDIF
4908:                 IF PEMSTATUS(loc_oP,"txt_4c_Cfos",5)
4909:                     loc_oP.txt_4c_Cfos.Value = .this_cCfos
4910:                 ENDIF
4911:                 IF PEMSTATUS(loc_oP,"txt_4c_Codtifs",5)
4912:                     loc_oP.txt_4c_Codtifs.Value = .this_cCodtifs
4913:                 ENDIF
4914:                 IF PEMSTATUS(loc_oP,"txt_4c_Tpcps",5)
4915:                     loc_oP.txt_4c_Tpcps.Value = .this_cTpcps
4916:                 ENDIF
4917:                 IF PEMSTATUS(loc_oP,"txt_4c_Rgcs",5)
4918:                     loc_oP.txt_4c_Rgcs.Value = .this_cRgcs
4919:                 ENDIF
4920:                 IF PEMSTATUS(loc_oP,"txt_4c_Pis",5)
4921:                     loc_oP.txt_4c_Pis.Value = .this_cPis
4922:                 ENDIF
4923:                 IF PEMSTATUS(loc_oP,"chk_4c_Microemps",5)
4924:                     loc_oP.chk_4c_Microemps.Value = IIF(ALLTRIM(.this_cMicroemps)="S",1,0)
4925:                 ENDIF
4926:                 IF PEMSTATUS(loc_oP,"chk_4c_Optsimples",5)
4927:                     loc_oP.chk_4c_Optsimples.Value = IIF(ALLTRIM(.this_cOptsimples)="S",1,0)
4928:                 ENDIF
4929:                 IF PEMSTATUS(loc_oP,"txt_4c_Suframas",5)
4930:                     loc_oP.txt_4c_Suframas.Value = .this_cSuframas
4931:                 ENDIF
4932:             ENDIF
4933:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg7",5)
4934:                 loc_oP = loc_oPg2.cnt_4c_Pg7
4935:                 IF PEMSTATUS(loc_oP,"txt_4c_Contats",5)
4936:                     loc_oP.txt_4c_Contats.Value = .this_cContats
4937:                 ENDIF
4938:                 IF PEMSTATUS(loc_oP,"txt_4c_Ctelems",5)
4939:                     loc_oP.txt_4c_Ctelems.Value = .this_cCtelems
4940:                 ENDIF
4941:                 IF PEMSTATUS(loc_oP,"txt_4c_Nomearts",5)
4942:                     loc_oP.txt_4c_Nomearts.Value = .this_cNomearts
4943:                 ENDIF
4944:                 IF PEMSTATUS(loc_oP,"txt_4c_Emissors",5)
4945:                     loc_oP.txt_4c_Emissors.Value = .this_cEmissors
4946:                 ENDIF
4947:                 IF PEMSTATUS(loc_oP,"txt_4c_Coletors",5)
4948:                     loc_oP.txt_4c_Coletors.Value = .this_nColetors
4949:                 ENDIF
4950:                 IF PEMSTATUS(loc_oP,"txt_4c_Consignas",5)
4951:                     loc_oP.txt_4c_Consignas.Value = .this_nConsignas
4952:                 ENDIF
4953:                 IF PEMSTATUS(loc_oP,"txt_4c_Masters",5)
4954:                     loc_oP.txt_4c_Masters.Value = .this_nMasters
4955:                 ENDIF
4956:                 IF PEMSTATUS(loc_oP,"txt_4c_Intconts",5)
4957:                     loc_oP.txt_4c_Intconts.Value = .this_nIntconts
4958:                 ENDIF
4959:                 IF PEMSTATUS(loc_oP,"txt_4c_Obspagto",5)
4960:                     loc_oP.txt_4c_Obspagto.Value = .this_cObspagto
4961:                 ENDIF
4962:                 IF PEMSTATUS(loc_oP,"txt_4c_Pracas",5)
4963:                     loc_oP.txt_4c_Pracas.Value = .this_cPracas
4964:                 ENDIF
4965:             ENDIF
4966:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg8",5)
4967:                 loc_oP = loc_oPg2.cnt_4c_Pg8
4968:                 IF PEMSTATUS(loc_oP,"txt_4c_Emps",5)
4969:                     loc_oP.txt_4c_Emps.Value = .this_cEmps
4970:                 ENDIF
4971:                 IF PEMSTATUS(loc_oP,"txt_4c_Usualts",5)
4972:                     loc_oP.txt_4c_Usualts.Value = .this_cUsualts
4973:                 ENDIF
4974:                 IF PEMSTATUS(loc_oP,"txt_4c_Usuars",5)
4975:                     loc_oP.txt_4c_Usuars.Value = .this_cUsuars
4976:                 ENDIF
4977:             ENDIF
4978:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg9",5)
4979:                 loc_oP = loc_oPg2.cnt_4c_Pg9
4980:                 THIS.ParsearCfgFis(loc_oP, "IC", .this_cCfgFisICs)

*-- Linhas 5005 a 5028:
5005:                     loc_oP.chk_4c_Autteleg.Value = IIF(.this_nAutteleg=1,1,0)
5006:                 ENDIF
5007:                 IF PEMSTATUS(loc_oP,"txt_4c_Cobs",5)
5008:                     loc_oP.txt_4c_Cobs.Value = .this_cCobs
5009:                 ENDIF
5010:                 IF PEMSTATUS(loc_oP,"txt_4c_Dtcasas",5)
5011:                     loc_oP.txt_4c_Dtcasas.Value = .this_dDtcasas
5012:                 ENDIF
5013:                 IF PEMSTATUS(loc_oP,"txt_4c_Dtncons",5)
5014:                     loc_oP.txt_4c_Dtncons.Value = .this_dDtncons
5015:                 ENDIF
5016:                 IF PEMSTATUS(loc_oP,"txt_4c_Maes",5)
5017:                     loc_oP.txt_4c_Maes.Value = .this_cMaes
5018:                 ENDIF
5019:                 IF PEMSTATUS(loc_oP,"txt_4c_Pais2",5)
5020:                     loc_oP.txt_4c_Pais2.Value = .this_cPais
5021:                 ENDIF
5022:                 IF PEMSTATUS(loc_oP,"txt_4c_Graupares",5)
5023:                     loc_oP.txt_4c_Graupares.Value = .this_cGraupares
5024:                 ENDIF
5025:             ENDIF
5026:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg11",5)
5027:                 loc_oP = loc_oPg2.cnt_4c_Pg11
5028:                 IF PEMSTATUS(loc_oP,"chk_4c_Gerbals",5)

*-- Linhas 5053 a 5073:
5053:                     loc_oP.chk_4c_Consigs.Value = IIF(.this_nConsigs=1,1,0)
5054:                 ENDIF
5055:                 IF PEMSTATUS(loc_oP,"txt_4c_Ean13ents",5)
5056:                     loc_oP.txt_4c_Ean13ents.Value = .this_nEan13ents
5057:                 ENDIF
5058:                 IF PEMSTATUS(loc_oP,"txt_4c_Ean13cobs",5)
5059:                     loc_oP.txt_4c_Ean13cobs.Value = .this_nEan13cobs
5060:                 ENDIF
5061:             ENDIF
5062:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg12",5)
5063:                 loc_oP = loc_oPg2.cnt_4c_Pg12
5064:                 IF PEMSTATUS(loc_oP,"edt_4c_Perfils",5)
5065:                     loc_oP.edt_4c_Perfils.Value = .this_mPerfils
5066:                 ENDIF
5067:                 IF PEMSTATUS(loc_oP,"txt_4c_Pastas",5)
5068:                     loc_oP.txt_4c_Pastas.Value = .this_mPastas
5069:                 ENDIF
5070:             ENDIF
5071:         ENDWITH
5072:     ENDPROC
5073: 

*-- Linhas 5222 a 5246:
5222:         ENDFOR
5223: 
5224:         *-- Botoes Salvar/Cancelar sempre habilitados em modo dados
5225:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
5226:             WITH loc_oPg2.cnt_4c_BotoesAcao
5227:                 IF PEMSTATUS(.cmd_4c_Confirmar, "Enabled", 5)
5228:                     .cmd_4c_Confirmar.Enabled = .T.
5229:                 ENDIF
5230:                 IF PEMSTATUS(.cmd_4c_Cancelar, "Enabled", 5)
5231:                     .cmd_4c_Cancelar.Enabled = .T.
5232:                 ENDIF
5233:                 .Visible     = .T.
5234:             ENDWITH
5235:         ENDIF
5236:     ENDPROC
5237: 
5238:     *===========================================================================
5239:     * Eventos CRUD - Page 1
5240:     *===========================================================================
5241:     PROCEDURE BtnIncluirClick()
5242:         THIS.this_oBusinessObject.NovoRegistro()
5243:         THIS.LimparCampos()
5244:         THIS.HabilitarCampos(.T.)
5245:         THIS.AlternarPagina("DADOS")
5246:         THIS.MostrarSubPagina(1)

