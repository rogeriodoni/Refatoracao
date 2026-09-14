# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Grupo, Centro de Custo, Descrição, % Rateio, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Grupo, Centro de Custo, Descrição, % Rateio, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Grupo, Centro de Custo, Descrição, % Rateio, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Grupo, Centro de Custo, Descrição, % Rateio, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Grupo, Centro de Custo, Descrição, % Rateio, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp., Grupo, Centro de Custo, Descrição, % Rateio, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRcc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1457 linhas total):

*-- Linhas 55 a 64:
55:                     "FormRcc.InicializarForm")
56:             ELSE
57:                 THIS.ConfigurarPageFrame()
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Visible = .T.
61:                 THIS.pgf_4c_Paginas.ActivePage = 1
62:                 THIS.this_cModoAtual = "LISTA"
63: 
64:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

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

*-- Linhas 121 a 156:
121:         *-- Top=2 do original + 29 compensacao = 31
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = THIS.Width
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
130:             .Visible     = .T.
131: 
132:             .AddObject("lbl_4c_Sombra", "Label")
133:             WITH .lbl_4c_Sombra
134:                 .Caption   = THIS.Caption
135:                 .Top       = 16
136:                 .Left      = 11
137:                 .Width     = THIS.Width
138:                 .Height    = 46
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 16
141:                 .FontBold  = .T.
142:                 .ForeColor = RGB(0, 0, 0)
143:                 .BackStyle = 0
144:                 .Visible   = .T.
145:             ENDWITH
146: 
147:             .AddObject("lbl_4c_Titulo", "Label")
148:             WITH .lbl_4c_Titulo
149:                 .Caption   = THIS.Caption
150:                 .Top       = 19
151:                 .Left      = 10
152:                 .Width     = THIS.Width
153:                 .Height    = 46
154:                 .FontName  = "Tahoma"
155:                 .FontSize  = 16
156:                 .FontBold  = .T.

*-- Linhas 163 a 185:
163:         *-- Container Botoes CRUD (Grupo_Op no legado) - Top=0+29=29, Left=542
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
165:         WITH loc_oPagina.cnt_4c_Botoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackStyle   = 0
171:             .BorderWidth = 0
172:             .Visible     = .T.
173: 
174:             .AddObject("cmd_4c_Incluir", "CommandButton")
175:             WITH .cmd_4c_Incluir
176:                 .Caption         = "Incluir"
177:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:                 .PicturePosition = 13
179:                 .Top             = 5
180:                 .Left            =  542
181:                 .Width           = 75
182:                 .Height          = 75
183:                 .FontName        = "Tahoma"
184:                 .FontSize        = 8
185:                 .FontBold        = .T.

*-- Linhas 193 a 207:
193:                 .Visible         = .T.
194:             ENDWITH
195: 
196:             .AddObject("cmd_4c_Visualizar", "CommandButton")
197:             WITH .cmd_4c_Visualizar
198:                 .Caption         = "Visualizar"
199:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:                 .PicturePosition = 13
201:                 .Top             = 5
202:                 .Left            =  542
203:                 .Width           = 75
204:                 .Height          = 75
205:                 .FontName        = "Tahoma"
206:                 .FontSize        = 8
207:                 .FontBold        = .T.

*-- Linhas 216 a 230:
216:                 .Visible         = .T.
217:             ENDWITH
218: 
219:             .AddObject("cmd_4c_Alterar", "CommandButton")
220:             WITH .cmd_4c_Alterar
221:                 .Caption         = "Alterar"
222:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:                 .PicturePosition = 13
224:                 .Top             = 5
225:                 .Left            =  542
226:                 .Width           = 75
227:                 .Height          = 75
228:                 .FontName        = "Tahoma"
229:                 .FontSize        = 8
230:                 .FontBold        = .T.

*-- Linhas 239 a 253:
239:                 .Visible         = .T.
240:             ENDWITH
241: 
242:             .AddObject("cmd_4c_Excluir", "CommandButton")
243:             WITH .cmd_4c_Excluir
244:                 .Caption         = "Excluir"
245:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
246:                 .PicturePosition = 13
247:                 .Top             = 5
248:                 .Left            =  542
249:                 .Width           = 75
250:                 .Height          = 75
251:                 .FontName        = "Tahoma"
252:                 .FontSize        = 8
253:                 .FontBold        = .T.

*-- Linhas 262 a 276:
262:                 .Visible         = .T.
263:             ENDWITH
264: 
265:             .AddObject("cmd_4c_Buscar", "CommandButton")
266:             WITH .cmd_4c_Buscar
267:                 .Caption         = "Buscar"
268:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
269:                 .PicturePosition = 13
270:                 .Top             = 5
271:                 .Left            =  542
272:                 .Width           = 75
273:                 .Height          = 75
274:                 .FontName        = "Tahoma"
275:                 .FontSize        = 8
276:                 .FontBold        = .T.

*-- Linhas 286 a 311:
286:             ENDWITH
287:         ENDWITH
288: 
289:         *-- Container Saida (canonico: Left=917, Width=90, cmd_4c_Encerrar)
290:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
291:         WITH loc_oPagina.cnt_4c_Saida
292:             .Top         = 29
293:             .Left        = 917
294:             .Width       = 90
295:             .Height      = 85
296:             .BackStyle   = 0
297:             .BorderWidth = 0
298:             .Visible     = .T.
299: 
300:             .AddObject("cmd_4c_Encerrar", "CommandButton")
301:             WITH .cmd_4c_Encerrar
302:                 .Caption         = "Encerrar"
303:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
304:                 .PicturePosition = 13
305:                 .Top             = 5
306:                 .Left            = 917
307:                 .Width           = 90
308:                 .Height          = 75
309:                 .FontName        = "Tahoma"
310:                 .FontSize        = 8
311:                 .FontBold        = .T.

*-- Linhas 326 a 335:
326:         loc_oPagina.grd_4c_Lista.RecordSource = ""
327:         loc_oPagina.grd_4c_Lista.ColumnCount  = 3
328:         WITH loc_oPagina.grd_4c_Lista
329:             .Top                = 117
330:             .Left               = 26
331:             .Width              = 890
332:             .Height             = 450
333:             .ReadOnly           = .T.
334:             .DeleteMark         = .F.
335:             .RecordMark         = .F.

*-- Linhas 343 a 365:
343:             .BackColor          = RGB(255, 255, 255)
344:             .ForeColor          = RGB(90, 90, 90)
345:             .Visible            = .T.
346:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
347:             .Column1.Width           = 350
348:             .Column2.Header1.Caption = "Empresa"
349:             .Column2.Width           = 60
350:             .Column3.Header1.Caption = "Nome Empresa"
351:             .Column3.Width           = 430
352:         ENDWITH
353: 
354:         *-- Botao Duplicar (legado: cmdDuplicar top=82 left=604)
355:         *-- Reposicionado para left=2 para nao conflitar com cnt_4c_Botoes
356:         loc_oPagina.AddObject("cmd_4c_Duplicar", "CommandButton")
357:         WITH loc_oPagina.cmd_4c_Duplicar
358:             .Caption       = "Duplicar rateio"
359:             .Top           = 111
360:             .Left          = 2
361:             .Width         = 120
362:             .Height        = 45
363:             .FontName      = "Tahoma"
364:             .FontSize      = 8
365:             .FontBold      = .F.

*-- Linhas 372 a 386:
372:         ENDWITH
373: 
374:         *-- Vincular eventos dos botoes CRUD
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
376:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
377:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
380:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
381:         BINDEVENT(loc_oPagina.cmd_4c_Duplicar,                  "Click", THIS, "BtnDuplicarClick")
382: 
383:         THIS.TornarControlesVisiveis(loc_oPagina)
384:     ENDPROC
385: 
386:     *===========================================================================

*-- Linhas 397 a 419:
397:         *-- Container BotoesAcao (Grupo_Salva no legado: Top=4+29=33, Left=842)
398:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
399:         WITH loc_oPagina.cnt_4c_BotoesAcao
400:             .Top         = 33
401:             .Left        = 842
402:             .Width       = 160
403:             .Height      = 85
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407: 
408:             .AddObject("cmd_4c_Confirmar", "CommandButton")
409:             WITH .cmd_4c_Confirmar
410:                 .Caption         = "Confirmar"
411:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
412:                 .PicturePosition = 13
413:                 .Top             = 5
414:                 .Left            = 5
415:                 .Width           = 75
416:                 .Height          = 75
417:                 .FontName        = "Tahoma"
418:                 .FontSize        = 8
419:                 .FontBold        = .T.

*-- Linhas 427 a 441:
427:                 .Visible         = .T.
428:             ENDWITH
429: 
430:             .AddObject("cmd_4c_Cancelar", "CommandButton")
431:             WITH .cmd_4c_Cancelar
432:                 .Caption         = "Encerrar"
433:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
434:                 .PicturePosition = 13
435:                 .Top             = 5
436:                 .Left            = 80
437:                 .Width           = 75
438:                 .Height          = 75
439:                 .FontName        = "Tahoma"
440:                 .FontSize        = 8
441:                 .FontBold        = .T.

*-- Linhas 451 a 467:
451:             ENDWITH
452:         ENDWITH
453: 
454:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
455:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
456: 
457:         *-- Label "Descricao :" (lbl_grupo no legado: top=111+29=140, left=86)
458:         loc_oPagina.AddObject("lbl_4c_LblDesc", "Label")
459:         WITH loc_oPagina.lbl_4c_LblDesc
460:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
461:             .Top       = 140
462:             .Left      = 86
463:             .Width     = 55
464:             .Height    = 17
465:             .FontName  = "Tahoma"
466:             .FontSize  = 8
467:             .FontBold  = .F.

*-- Linhas 475 a 499:
475:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
476:         WITH loc_oPagina.txt_4c_Desc
477:             .Value         = ""
478:             .Top           = 136
479:             .Left          = 146
480:             .Width         = 150
481:             .Height        = 23
482:             .FontName      = "Tahoma"
483:             .FontSize      = 8
484:             .SpecialEffect = 1
485:             .MaxLength     = 20
486:             .Visible       = .T.
487:         ENDWITH
488: 
489:         *-- Label "Empresa :" (Say6 no legado: top=137+29=166, left=91)
490:         loc_oPagina.AddObject("lbl_4c_Say6", "Label")
491:         WITH loc_oPagina.lbl_4c_Say6
492:             .Caption   = "Empresa :"
493:             .Top       = 166
494:             .Left      = 91
495:             .Width     = 55
496:             .Height    = 17
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .FontBold  = .F.

*-- Linhas 507 a 516:
507:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
508:         WITH loc_oPagina.txt_4c_Empresa
509:             .Value         = ""
510:             .Top           = 163
511:             .Left          = 146
512:             .Width         = 31
513:             .Height        = 21
514:             .FontName      = "Tahoma"
515:             .FontSize      = 8
516:             .SpecialEffect = 1

*-- Linhas 523 a 532:
523:         loc_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
524:         WITH loc_oPagina.txt_4c_DEmpresa
525:             .Value         = ""
526:             .Top           = 163
527:             .Left          = 179
528:             .Width         = 351
529:             .Height        = 21
530:             .FontName      = "Tahoma"
531:             .FontSize      = 8
532:             .SpecialEffect = 1

*-- Linhas 541 a 550:
541:         loc_oPagina.AddObject("txt_4c_PTotal", "TextBox")
542:         WITH loc_oPagina.txt_4c_PTotal
543:             .Value         = 0
544:             .Top           = 575
545:             .Left          = 499
546:             .Width         = 80
547:             .Height        = 21
548:             .FontName      = "Courier New"
549:             .FontSize      = 8
550:             .Alignment     = 3

*-- Linhas 560 a 569:
560:         loc_oPagina.grd_4c_Dados.ColumnCount  = 6
561: 
562:         WITH loc_oPagina.grd_4c_Dados
563:             .Top                = 188
564:             .Left               = 128
565:             .Width              = 471
566:             .Height             = 387
567:             .FontName           = "Tahoma"
568:             .FontSize           = 8
569:             .DeleteMark         = .F.

*-- Linhas 579 a 702:
579:             .Visible            = .T.
580: 
581:             *-- Column1: Emp. (ColumnOrder=2, width=31) - editavel quando Marcas=1
582:             .Column1.Header1.Caption     = "Emp."
583:             .Column1.Header1.Alignment   = 2
584:             .Column1.Width               = 31
585:             .Column1.ColumnOrder         = 2
586:             .Column1.Movable             = .F.
587:             .Column1.Resizable           = .F.
588:             .Column1.DynamicReadOnly     = "IIF(USED('cursor_4c_RateioEdit'),cursor_4c_RateioEdit.Marcas=0,.T.)"
589:             .Column1.Text1.BorderStyle   = 0
590:             .Column1.Text1.Margin        = 0
591:             .Column1.Text1.ForeColor     = RGB(0, 0, 0)
592:             .Column1.Text1.BackColor     = RGB(255, 255, 255)
593: 
594:             *-- Column2: Grupo (ColumnOrder=3, width=80, ReadOnly)
595:             .Column2.Header1.Caption     = "Grupo"
596:             .Column2.Header1.Alignment   = 2
597:             .Column2.Width               = 80
598:             .Column2.ColumnOrder         = 3
599:             .Column2.ReadOnly            = .T.
600:             .Column2.Movable             = .F.
601:             .Column2.Resizable           = .F.
602:             .Column2.Text1.BorderStyle   = 0
603:             .Column2.Text1.Margin        = 0
604:             .Column2.Text1.ForeColor     = RGB(0, 0, 0)
605:             .Column2.Text1.BackColor     = RGB(255, 255, 255)
606: 
607:             *-- Column3: Centro de Custo (ColumnOrder=4, width=95, ReadOnly)
608:             .Column3.Header1.Caption     = "Centro de Custo"
609:             .Column3.Header1.Alignment   = 2
610:             .Column3.Width               = 95
611:             .Column3.ColumnOrder         = 4
612:             .Column3.ReadOnly            = .T.
613:             .Column3.Movable             = .F.
614:             .Column3.Resizable           = .F.
615:             .Column3.Text1.BorderStyle   = 0
616:             .Column3.Text1.Margin        = 0
617:             .Column3.Text1.ForeColor     = RGB(0, 0, 0)
618:             .Column3.Text1.BackColor     = RGB(255, 255, 255)
619: 
620:             *-- Column4: Descricao (ColumnOrder=5, width=141, ReadOnly)
621:             .Column4.Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
622:             .Column4.Header1.Alignment   = 2
623:             .Column4.Width               = 141
624:             .Column4.ColumnOrder         = 5
625:             .Column4.ReadOnly            = .T.
626:             .Column4.Movable             = .F.
627:             .Column4.Resizable           = .F.
628:             .Column4.Text1.BorderStyle   = 0
629:             .Column4.Text1.Margin        = 0
630:             .Column4.Text1.ForeColor     = RGB(0, 0, 0)
631:             .Column4.Text1.BackColor     = RGB(255, 255, 255)
632: 
633:             *-- Column5: % Rateio (ColumnOrder=6, width=80) - editavel quando Marcas=1
634:             .Column5.Header1.Caption     = "% Rateio"
635:             .Column5.Header1.Alignment   = 2
636:             .Column5.Width               = 80
637:             .Column5.ColumnOrder         = 6
638:             .Column5.Movable             = .F.
639:             .Column5.Resizable           = .F.
640:             .Column5.DynamicReadOnly     = "IIF(USED('cursor_4c_RateioEdit'),cursor_4c_RateioEdit.Marcas=0,.T.)"
641:             .Column5.Text1.InputMask     = "999.99"
642:             .Column5.Text1.BorderStyle   = 0
643:             .Column5.Text1.Margin        = 0
644:             .Column5.Text1.ForeColor     = RGB(0, 0, 0)
645:             .Column5.Text1.BackColor     = RGB(255, 255, 255)
646: 
647:             *-- Column6: Marcas checkbox (ColumnOrder=1 = primeira coluna visual, width=17)
648:             .Column6.Header1.Caption = ""
649:             .Column6.Width           = 17
650:             .Column6.ColumnOrder     = 1
651:             .Column6.Sparse          = .F.
652:             .Column6.Movable         = .F.
653:             .Column6.Resizable       = .F.
654:         ENDWITH
655: 
656:         *-- CheckBox na coluna 6 (Problema 146: 7 props obrigatorias alem de Sparse=.F.)
657:         loc_oPagina.grd_4c_Dados.Column6.AddObject("Check1", "CheckBox")
658:         WITH loc_oPagina.grd_4c_Dados.Column6.Check1
659:             .Alignment = 0
660:             .Caption   = ""
661:             .ReadOnly  = .F.
662:             .Visible   = .T.
663:             .Top       = 9
664:             .Left      = 2
665:             .Height    = 17
666:             .Width     = 22
667:         ENDWITH
668: 
669:         *-- cmd_4c_SelTudo (SelTudo no legado: top=305+29=334, left=599, width=45, height=40)
670:         loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
671:         WITH loc_oPagina.cmd_4c_SelTudo
672:             .Caption         = ""
673:             .ToolTipText     = "Selecionar"
674:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
675:             .PicturePosition = 4
676:             .Top             = 334
677:             .Left            = 599
678:             .Width           = 45
679:             .Height          = 40
680:             .FontName        = "Verdana"
681:             .FontSize        = 8
682:             .ForeColor       = RGB(36, 84, 155)
683:             .BackColor       = RGB(255, 255, 255)
684:             .Themes          = .F.
685:             .SpecialEffect   = 0
686:             .Visible         = .T.
687:         ENDWITH
688: 
689:         *-- cmd_4c_Apaga (apaga no legado: top=346+29=375, left=599, width=45, height=40)
690:         loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
691:         WITH loc_oPagina.cmd_4c_Apaga
692:             .Caption         = ""
693:             .ToolTipText     = "Desmarcar"
694:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
695:             .PicturePosition = 4
696:             .Top             = 375
697:             .Left            = 599
698:             .Width           = 45
699:             .Height          = 40
700:             .FontName        = "Verdana"
701:             .FontSize        = 8
702:             .ForeColor       = RGB(36, 84, 155)

*-- Linhas 709 a 718:
709:         *-- BINDEVENTs para grid e botoes de selecao
710:         BINDEVENT(loc_oPagina.grd_4c_Dados.Column6.Check1, "Click",             THIS, "GridCheckClick")
711:         BINDEVENT(loc_oPagina.grd_4c_Dados,                "AfterRowColChange", THIS, "GridRateioAfterRowColChange")
712:         BINDEVENT(loc_oPagina.cmd_4c_SelTudo,               "Click",            THIS, "BtnSelTudoClick")
713:         BINDEVENT(loc_oPagina.cmd_4c_Apaga,                 "Click",            THIS, "BtnApagaClick")
714: 
715:         THIS.TornarControlesVisiveis(loc_oPagina)
716:     ENDPROC
717: 
718:     *===========================================================================

*-- Linhas 740 a 750:
740:                     loc_oGrid.Column2.Width = 60
741:                     loc_oGrid.Column3.Width = 430
742: 
743:                     loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
744:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
745:                     loc_oGrid.Column3.Header1.Caption = "Nome Empresa"
746: 
747:                     THIS.FormatarGridLista(loc_oGrid)
748:                     loc_lSucesso = .T.
749:                 ELSE
750:                     MsgErro("Erro ao carregar lista de rateios.", "Erro")

*-- Linhas 959 a 969:
959:                 loc_oGrid.Column1.Width             = 350
960:                 loc_oGrid.Column2.Width             = 60
961:                 loc_oGrid.Column3.Width             = 430
962:                 loc_oGrid.Column1.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
963:                 loc_oGrid.Column2.Header1.Caption   = "Empresa"
964:                 loc_oGrid.Column3.Header1.Caption   = "Nome Empresa"
965:                 THIS.FormatarGridLista(loc_oGrid)
966:             ELSE
967:                 MsgErro("Erro na busca de rateios.", "Erro")
968:             ENDIF
969:         CATCH TO loException

*-- Linhas 1217 a 1227:
1217:         IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1218:             loc_oPg2.grd_4c_Dados.ReadOnly = !par_lHabilitar
1219:         ENDIF
1220:         IF PEMSTATUS(loc_oPg2, "cmd_4c_Apaga", 5)
1221:         ENDIF
1222:         IF PEMSTATUS(loc_oPg2, "cmd_4c_SelTudo", 5)
1223:         ENDIF
1224:     ENDPROC
1225: 
1226:     *===========================================================================
1227:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo

*-- Linhas 1235 a 1247:
1235:         ENDIF
1236: 
1237:         WITH loc_oPg2.cnt_4c_BotoesAcao
1238:             IF PEMSTATUS(.cmd_4c_Confirmar, "Enabled", 5)
1239:                 .cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual $ "INCLUIR,ALTERAR")
1240:             ENDIF
1241:             IF PEMSTATUS(.cmd_4c_Cancelar, "Enabled", 5)
1242:                 .cmd_4c_Cancelar.Enabled = .T.
1243:             ENDIF
1244:             .Visible     = .T.
1245:         ENDWITH
1246:     ENDPROC
1247: 

*-- Linhas 1329 a 1342:
1329:                 .Column6.ControlSource = par_cCursor + ".Marcas"
1330: 
1331:                 *-- Reconfigurar Headers apos RecordSource (Problema 32)
1332:                 .Column1.Header1.Caption = "Emp."
1333:                 .Column2.Header1.Caption = "Grupo"
1334:                 .Column3.Header1.Caption = "Centro de Custo"
1335:                 .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1336:                 .Column5.Header1.Caption = "% Rateio"
1337:                 .Column6.Header1.Caption = ""
1338: 
1339:                 .Refresh()
1340:             ENDWITH
1341: 
1342:             THIS.AtualizarPTotal()

*-- Linhas 1365 a 1373:
1365:     ENDPROC
1366: 
1367:     *===========================================================================
1368:     * GridCheckClick - Processa click no CheckBox da coluna Marcas do grid
1369:     * Quando Marcas vira 0, zera PercRats; depois recalcula rateio automatico
1370:     *===========================================================================
1371:     PROCEDURE GridCheckClick()
1372:         IF !USED("cursor_4c_RateioEdit")
1373:             RETURN


### BO (C:\4c\projeto\app\classes\RccBO.prg):
*==============================================================================
* RccBO.prg - Business Object para Rateio de Centros de Custo
* Tabelas: SigCdRcc (cabecalho) + SigCdRci (itens)
* Migrado de: SIGCDRCC.SCX
*==============================================================================

DEFINE CLASS RccBO AS BusinessBase

    *-- Propriedades do cabecalho (SigCdRcc)
    this_cDescRats  = ""    && Descricao do rateio (PK)
    this_cEmpOs     = ""    && Codigo da empresa
    this_cCidChaves = ""    && Chave unica do registro
    this_dDatas     = {}    && Data de criacao
    this_dDtAlts    = {}    && Data de alteracao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRcc"
        THIS.this_cCampoChave = "DescRats"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDescRats
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdRcc
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.DescRats, a.EmpOs, b.Razas AS DEmpresa" + ;
                       " FROM SigCdRcc a" + ;
                       " LEFT JOIN SigCdEmp b ON b.CEmps = a.EmpOs" + ;
                       " ORDER BY a.DescRats"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = STRTRAN(loc_cSQL, " ORDER BY", ;
                    " WHERE a.DescRats LIKE " + EscaparSQL(par_cFiltro + "%") + " ORDER BY")
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar rateios: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo DescRats (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DescRats, EmpOs, CidChaves, Datas, DtAlts" + ;
                       " FROM SigCdRcc" + ;
                       " WHERE DescRats = " + EscaparSQL(par_cDescRats)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarPorCodigo: " + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Preenche propriedades a partir do cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDescRats  = TratarNulo(DescRats, "C")
            THIS.this_cEmpOs     = TratarNulo(EmpOs, "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_dDatas     = TratarNulo(Datas, "D")
            THIS.this_dDtAlts    = TratarNulo(DtAlts, "D")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensPorRateio - Carrega itens de SigCdRci para o grid (modo VISUALIZAR)
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensPorRateio(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.DescRats, a.Emps, a.Grupos, a.Contas," + ;
                       " a.PercRats, a.Marcas, a.CidChaves, c.rclis AS Descs" + ;
                       " FROM SigCdRci a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis = a.Contas" + ;
                       " WHERE a.DescRats = " + EscaparSQL(par_cDescRats) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Itens")
                TABLEREVERT(.T., "cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarItensPorRateio: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarClientesPorGrupoColetora - Popula cursor_4c_RateioEdit para edicao
    * Carrega todos os clientes do grupo coletora 9, marcando os ja salvos
    *--------------------------------------------------------------------------
    FUNCTION CarregarClientesPorGrupoColetora(par_cDescRatsExistente)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_RateioEdit")
                USE IN cursor_4c_RateioEdit
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_RateioEdit ( ;
                Marcas    I, ;
                Emps      C(3), ;
                Grupos    C(20), ;
                Contas    C(20), ;
                Descs     C(60), ;
                PercRats  N(5,2), ;
                Manual    I ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT 0 AS Marcas, SPACE(3) AS Emps, a.grupos," + ;
                       " a.iclis AS Contas, a.rclis AS Descs," + ;
                       " CAST(0.00 AS NUMERIC(5,2)) AS PercRats, 0 AS Manual" + ;
                       " FROM SigCdCli a" + ;
                       " JOIN SigCdGcr b ON a.grupos = b.codigos" + ;
                       " WHERE b.coletors = 9" + ;
                       " ORDER BY a.grupos, a.rclis"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_RateioEditTemp")
                TABLEREVERT(.T., "cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RateioEditTemp")
            IF loc_nResultado >= 0
                SELECT cursor_4c_RateioEdit
                APPEND FROM DBF("cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp

                IF !EMPTY(par_cDescRatsExistente)
                    THIS.MarcarItensExistentes(par_cDescRatsExistente)
                ENDIF

                GO TOP IN cursor_4c_RateioEdit
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar clientes: " + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_RateioEditTemp")
                    USE IN cursor_4c_RateioEditTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarClientesPorGrupoColetora: " + loException.Message, "Erro")
            IF USED("cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarItensExistentes - Marca no cursor_4c_RateioEdit os itens ja salvos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MarcarItensExistentes(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cGrupos, loc_cContas, loc_nPerc

        TRY
            loc_cSQL = "SELECT Grupos, Contas, PercRats FROM SigCdRci" + ;
                       " WHERE DescRats = " + EscaparSQL(par_cDescRats)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_RciExist")
                TABLEREVERT(.T., "cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RciExist")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_RciExist") > 0
                SELECT cursor_4c_RateioEdit
                INDEX ON Grupos + Contas TAG GruConta ADDITIVE

                SELECT cursor_4c_RciExist
                GO TOP
                DO WHILE !EOF("cursor_4c_RciExist")
                    loc_cGrupos = ALLTRIM(cursor_4c_RciExist.Grupos)
                    loc_cContas = ALLTRIM(cursor_4c_RciExist.Contas)
                    loc_nPerc   = cursor_4c_RciExist.PercRats

                    IF SEEK(loc_cGrupos + loc_cContas, "cursor_4c_RateioEdit", "GruConta")
                        REPLACE Marcas WITH 1, PercRats WITH loc_nPerc IN cursor_4c_RateioEdit
                    ENDIF

                    SKIP IN cursor_4c_RciExist
                ENDDO
            ENDIF

            IF USED("cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF

            SELECT cursor_4c_RateioEdit
            SET ORDER TO
            GO TOP
        CATCH TO loException
            MsgErro("Erro em MarcarItensExistentes: " + loException.Message, "Erro")
            IF USED("cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularRateioAuto - Distribui % automaticamente entre itens marcados
    *--------------------------------------------------------------------------
    PROCEDURE CalcularRateioAuto()
        LOCAL loc_nQtde, loc_nRat, loc_nPTotal

        IF !USED("cursor_4c_RateioEdit")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            loc_nQtde = 0
            GO TOP
            COUNT FOR Marcas = 1 TO loc_nQtde

            IF loc_nQtde > 0
                loc_nRat = ROUND(100 / loc_nQtde, 2)
                SCAN FOR Marcas = 1
                    REPLACE PercRats WITH loc_nRat IN cursor_4c_RateioEdit
                ENDSCAN
            ENDIF

            SELECT cursor_4c_RateioEdit
            loc_nPTotal = 0
            SUM PercRats TO loc_nPTotal

            IF loc_nPTotal > 100
                GO TOP
                LOCATE FOR Marcas = 1
                IF FOUND()
                    REPLACE PercRats WITH PercRats - (loc_nPTotal - 100) IN cursor_4c_RateioEdit
                ENDIF
                loc_nPTotal = 0
                SUM PercRats TO loc_nPTotal
            ENDIF

            IF !EMPTY(loc_nPTotal) AND loc_nPTotal < 100
                GO TOP
                LOCATE FOR Marcas = 1
                IF FOUND()
                    REPLACE PercRats WITH PercRats + ((loc_nPTotal - 100) * -1) IN cursor_4c_RateioEdit
                ENDIF
            ENDIF

            GO TOP
        CATCH TO loException
            MsgErro("Erro em RccBO.CalcularRateioAuto: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTotalRateio - Verifica se soma dos itens marcados = 100%
    *--------------------------------------------------------------------------
    FUNCTION ValidarTotalRateio()
        LOCAL loc_nTotal, loc_lValido
        loc_lValido = .F.

        IF !USED("cursor_4c_RateioEdit")
            MsgAviso("Nenhum item de rateio carregado.", "Aviso")
            RETURN loc_lValido
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            loc_nTotal = 0
            SUM PercRats FOR Marcas = 1 TO loc_nTotal

            IF loc_nTotal <> 100
                MsgAviso("Total de rateio diferente de 100%. " + ;
                    "Total atual: " + TRANSFORM(loc_nTotal) + "%", ;
                    "Lan" + CHR(231) + "amento incorreto")
            ELSE
                loc_lValido = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarTotalRateio: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDescricaoExistente - Checa duplicidade em INSERIR
    *--------------------------------------------------------------------------
    FUNCTION VerificarDescricaoExistente(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdRcc WHERE DescRats = " + ;
                       EscaparSQL(par_cDescRats)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkExist")
                TABLEREVERT(.T., "cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExist")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkExist") > 0
                SELECT cursor_4c_ChkExist
                loc_lExiste = (cursor_4c_ChkExist.Total > 0)
            ENDIF
            IF USED("cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF
        CATCH TO loException
            MsgErro("Erro em VerificarDescricaoExistente: " + loException.Message, "Erro")
            IF USED("cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRcc + SigCdRci (atomico)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            loc_cSQL = "INSERT INTO SigCdRcc (CidChaves, DescRats, EmpOs, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(SYS(2015)) + ", " + ;
                       EscaparSQL(THIS.this_cDescRats) + ", " + ;
                       EscaparSQL(THIS.this_cEmpOs) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                IF THIS.SalvarItensRateio()
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransAberta = .F.
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao salvar itens de rateio.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Recria SigCdRcc + SigCdRci atomicamente (delete+insert)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta, loc_lEtapaOk
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.
        loc_lEtapaOk     = .T.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRci WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao remover itens antigos: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRcc WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao remover cabe" + CHR(231) + "alho antigo: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "INSERT INTO SigCdRcc (CidChaves, DescRats, EmpOs, Datas, DtAlts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           EscaparSQL(THIS.this_cDescRats) + ", " + ;
                           EscaparSQL(THIS.this_cEmpOs) + ", " + ;
                           FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "GETDATE())"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao reinserir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                IF THIS.SalvarItensRateio()
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransAberta = .F.
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao salvar itens de rateio.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarItensRateio - INSERT em SigCdRci para cada item marcado no cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SalvarItensRateio()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .T.

        IF !USED("cursor_4c_RateioEdit")
            RETURN .T.
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            GO TOP
            SCAN FOR Marcas = 1
                IF EMPTY(Grupos) AND EMPTY(Contas)
                    LOOP
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRci" + ;
                           " (CidChaves, DescRats, Emps, Grupos, Contas, PercRats, Marcas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(SYS(2015)) + ", " + ;
                           EscaparSQL(THIS.this_cDescRats) + ", " + ;
                           EscaparSQL(Emps) + ", " + ;
                           EscaparSQL(Grupos) + ", " + ;
                           EscaparSQL(Contas) + ", " + ;
                           FormatarNumeroSQL(PercRats) + ", " + ;
                           TRANSFORM(Marcas) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir item de rateio: " + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loException
            MsgErro("Erro em SalvarItensRateio: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdRci e SigCdRcc (atomico)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta, loc_lEtapaOk
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.
        loc_lEtapaOk     = .T.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRci WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRcc WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                loc_lTransAberta = .F.
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_RateioEdit")
            USE IN cursor_4c_RateioEdit
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

