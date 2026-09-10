# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [GRID-HEADER] Header Caption 'Tipos' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrs' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipos' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrs' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'OptMaius' (parent: SIGCDTPC.pagina.dados): Top original=193 vs migrado 'obj_4c_OptMaius' Top=230 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optUsarPAs' (parent: SIGCDTPC.pagina.dados): Top original=171 vs migrado 'obj_4c_OptUsarPAs' Top=208 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptImp' (parent: SIGCDTPC.pagina.dados): Top original=149 vs migrado 'obj_4c_OptImp' Top=186 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCustos' (parent: SIGCDTPC.pagina.dados): Top original=128 vs migrado 'obj_4c_OptCustos' Top=165 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdExcluir' (parent: SIGCDTPC.pagina.dados): Top original=373 vs migrado 'cmd_4c_CmdExcluir' Top=410 (diff=37px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTpc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1486 linhas total):

*-- Linhas 50 a 59:
50:                     "FormTpc.InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 82 a 101:
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -29
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 29
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()

*-- Linhas 116 a 153:
116:         *-- Original: Top=2. Com compensacao +29: Top=31
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
133:             .Width     = THIS.Width
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
149:             .Width     = THIS.Width
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.

*-- Linhas 161 a 185:
161:         *-- Canonico framework: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
162:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163:         WITH loc_oPagina.cnt_4c_Botoes
164:             .Top         = 29
165:             .Left        = 542
166:             .Width       = 390
167:             .Height      = 85
168:             .BackStyle = 0
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         *-- Botao Incluir (legado: inserir, Left=5)
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
184:             .FontSize        = 8
185:             .FontBold        = .T.

*-- Linhas 192 a 209:
192:             .MousePointer    = 15
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         *-- Botao Visualizar (legado: consultar, Left=80)
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .FontName        = "Tahoma"
208:             .FontSize        = 8
209:             .FontBold        = .T.

*-- Linhas 216 a 233:
216:             .MousePointer    = 15
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         *-- Botao Alterar (legado: alterar, Left=155)
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
232:             .FontSize        = 8
233:             .FontBold        = .T.

*-- Linhas 240 a 257:
240:             .MousePointer    = 15
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:         *-- Botao Excluir (legado: excluir, Left=230)
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .FontName        = "Tahoma"
256:             .FontSize        = 8
257:             .FontBold        = .T.

*-- Linhas 264 a 281:
264:             .MousePointer    = 15
265:             .Visible         = .T.
266:         ENDWITH
267:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
268: 
269:         *-- Botao Buscar (legado: procurar, Left=305)
270:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
271:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
272:             .Caption         = "Buscar"
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
274:             .PicturePosition = 13
275:             .Top             = 5
276:             .Left            = 305
277:             .Width           = 75
278:             .Height          = 75
279:             .FontName        = "Tahoma"
280:             .FontSize        = 8
281:             .FontBold        = .T.

*-- Linhas 288 a 316:
288:             .MousePointer    = 15
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container de saida (padrao canonico - CLAUDE.md regra #10, PREVALECE sobre PILAR 1)
294:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
295:         WITH loc_oPagina.cnt_4c_Saida
296:             .Top         = 29
297:             .Left        = 917
298:             .Width       = 90
299:             .Height      = 85
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
306:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
307:             .Caption         = "Encerrar"
308:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:             .PicturePosition = 13
310:             .Top             = 5
311:             .Left            = 5
312:             .Width           = 75
313:             .Height          = 75
314:             .FontName        = "Tahoma"
315:             .FontSize        = 8
316:             .FontBold        = .T.

*-- Linhas 323 a 339:
323:             .MousePointer    = 15
324:             .Visible         = .T.
325:         ENDWITH
326:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
327: 
328:         *-- Grid de listagem (legado: pagina.lista.grade - Top=100, Left=29, Width=941, Height=484)
329:         *-- Compensacao PageFrame: Top = 100 + 29 = 129... porem framework canonico usa Top=117 (88+29)
330:         *-- Colunas do legado (comportamento.json AddCursor): Tipos (150), Descrs (290)
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         WITH loc_oPagina.grd_4c_Lista
333:             .Top                = 117
334:             .Left               = 26
335:             .Width              = 890
336:             .Height             = 498
337:             .ColumnCount        = 2
338:             .FontName           = "Verdana"
339:             .FontSize           = 8

*-- Linhas 351 a 361:
351:             .ReadOnly           = .T.
352:             .Visible            = .T.
353:             .Column1.Width              = 150
354:             .Column1.Header1.Caption    = "Tipos"
355:             .Column2.Width              = 290
356:             .Column2.Header1.Caption    = "Descrs"
357:         ENDWITH
358:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GridDblClick")
359: 
360:         THIS.TornarControlesVisiveis(loc_oPagina)
361:     ENDPROC

*-- Linhas 367 a 375:
367:     * FASE 6/8: completa com os campos restantes (Imprimir, Utiliza Produto Acabado,
368:     *           Maiusculos), grid de Grupos vinculados e lookups
369:     *
370:     * Compensacao de Top nos controles de dados: +29 (PageFrame.Top=-29) + 8 (re-layout
371:     * obrigatorio pela faixa do cabecalho, que ocupa Top=29..109 - CLAUDE.md regra #11,
372:     * "nenhum controle de dados pode ter Top < 109"; usamos >=115 como piso seguro)
373:     *===========================================================================
374:     PROTECTED PROCEDURE ConfigurarPaginaDados()
375:         LOCAL loc_oPagina

*-- Linhas 382 a 419:
382:         *-- DENTRO da area da faixa (29..109) e precisam ser criados DEPOIS para desenhar por cima.
383:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
384:         WITH loc_oPagina.cnt_4c_Cabecalho
385:             .Top         = 29
386:             .Left        = 0
387:             .Width       = THIS.Width
388:             .Height      = 80
389:             .BackColor   = RGB(100, 100, 100)
390:             .BorderWidth = 0
391:             .Visible     = .T.
392:         ENDWITH
393: 
394:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
395:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
396:             .Caption   = THIS.Caption
397:             .Top       = 15
398:             .Left      = 10
399:             .Width     = THIS.Width
400:             .Height    = 40
401:             .FontName  = "Tahoma"
402:             .FontSize  = 16
403:             .FontBold  = .T.
404:             .ForeColor = RGB(0, 0, 0)
405:             .BackStyle = 0
406:             .AutoSize  = .F.
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
411:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
412:             .Caption   = THIS.Caption
413:             .Top       = 18
414:             .Left      = 10
415:             .Width     = THIS.Width
416:             .Height    = 46
417:             .FontName  = "Tahoma"
418:             .FontSize  = 16
419:             .FontBold  = .T.

*-- Linhas 428 a 454:
428:         *-- Criado DEPOIS do cabecalho para ficar POR CIMA da faixa (Top=33 esta dentro de 29..109)
429:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
430:         WITH loc_oPagina.cnt_4c_BotoesAcao
431:             .Top         = 33
432:             .Left        = 842
433:             .Width       = 160
434:             .Height      = 85
435:             .BackStyle = 1
436:             .BackColor   = RGB(255, 255, 255)
437:             .BorderWidth = 0
438:             .Visible     = .T.
439:         ENDWITH
440:         loc_oPagina.cnt_4c_BotoesAcao.ZOrder(0)
441: 
442:         *-- Botao Confirmar (legado: grupo_salva.salva, Left=5)
443:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
444:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
445:             .Caption         = "Confirmar"
446:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
447:             .PicturePosition = 13
448:             .Top             = 5
449:             .Left            = 5
450:             .Width           = 75
451:             .Height          = 75
452:             .FontName        = "Tahoma"
453:             .FontSize        = 8
454:             .FontBold        = .T.

*-- Linhas 461 a 478:
461:             .MousePointer    = 15
462:             .Visible         = .T.
463:         ENDWITH
464:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
465: 
466:         *-- Botao Cancelar (legado: grupo_salva.cancelar, Left=80)
467:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
468:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
469:             .Caption         = "Encerrar"
470:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
471:             .PicturePosition = 13
472:             .Top             = 5
473:             .Left            = 80
474:             .Width           = 75
475:             .Height          = 75
476:             .FontName        = "Tahoma"
477:             .FontSize        = 8
478:             .FontBold        = .T.

*-- Linhas 485 a 503:
485:             .MousePointer    = 15
486:             .Visible         = .T.
487:         ENDWITH
488:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
489: 
490:         *-- ===================================================================
491:         *-- Campo: Tipo (getTipos -> txt_4c_Tipos) - PK, maiusculas (Format K!)
492:         *-- Original: Top=79, Left=398, Width=150. Compensado: 79+29+8=116
493:         *-- ===================================================================
494:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
495:         WITH loc_oPagina.lbl_4c_Tipo
496:             .Caption   = "Tipo :"
497:             .Top       = 120
498:             .Left      = 367
499:             .Width     = 29
500:             .Height    = 15
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8
503:             .FontBold  = .F.

*-- Linhas 509 a 518:
509: 
510:         loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
511:         WITH loc_oPagina.txt_4c_Tipos
512:             .Top           = 116
513:             .Left          = 398
514:             .Width         = 150
515:             .Height        = 23
516:             .MaxLength     = 20
517:             .Format        = "K!"
518:             .FontName      = "Tahoma"

*-- Linhas 528 a 540:
528:         *-- Campo: Ordem de Impressao (GetnOrdems -> txt_4c_NOrdems) - numerico 2 digitos
529:         *-- Original: Top=79, Left=697, Width=32. Compensado: 79+29+8=116
530:         *-- ===================================================================
531:         loc_oPagina.AddObject("lbl_4c_OrdemImpressao", "Label")
532:         WITH loc_oPagina.lbl_4c_OrdemImpressao
533:             .Caption   = "Ordem de Impress" + CHR(227) + "o :"
534:             .Top       = 120
535:             .Left      = 586
536:             .Width     = 109
537:             .Height    = 15
538:             .FontName  = "Tahoma"
539:             .FontSize  = 8
540:             .FontBold  = .F.

*-- Linhas 546 a 555:
546: 
547:         loc_oPagina.AddObject("txt_4c_NOrdems", "TextBox")
548:         WITH loc_oPagina.txt_4c_NOrdems
549:             .Top           = 116
550:             .Left          = 697
551:             .Width         = 32
552:             .Height        = 23
553:             .InputMask     = "99"
554:             .MaxLength     = 2
555:             .FontName      = "Tahoma"

*-- Linhas 565 a 577:
565:         *-- Campo: Descricao (getDescrs -> txt_4c_Descrs)
566:         *-- Original: Top=105, Left=398, Width=331. Compensado: 105+29+8=142
567:         *-- ===================================================================
568:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
569:         WITH loc_oPagina.lbl_4c_Descricao
570:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
571:             .Top       = 145
572:             .Left      = 341
573:             .Width     = 55
574:             .Height    = 15
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .FontBold  = .F.

*-- Linhas 583 a 592:
583: 
584:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
585:         WITH loc_oPagina.txt_4c_Descrs
586:             .Top           = 142
587:             .Left          = 398
588:             .Width         = 331
589:             .Height        = 23
590:             .MaxLength     = 40
591:             .Format        = "!K"
592:             .FontName      = "Tahoma"

*-- Linhas 602 a 614:
602:         *-- Campo: Calcula Custos (optCustos -> obj_4c_OptCustos) - OptionGroup Sim/Nao
603:         *-- Original: Top=128, Left=393, Width=93. Compensado: 128+29+8=165
604:         *-- ===================================================================
605:         loc_oPagina.AddObject("lbl_4c_CalculaCustos", "Label")
606:         WITH loc_oPagina.lbl_4c_CalculaCustos
607:             .Caption   = "Calcula Custos :"
608:             .Top       = 170
609:             .Left      = 317
610:             .Width     = 79
611:             .Height    = 15
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .FontBold  = .F.

*-- Linhas 620 a 670:
620: 
621:         loc_oPagina.AddObject("obj_4c_OptCustos", "OptionGroup")
622:         WITH loc_oPagina.obj_4c_OptCustos
623:             .Top         = 165
624:             .Left        = 393
625:             .Width       = 98
626:             .Height      = 25
627:             .ButtonCount = 2
628:             .BackStyle   = 0
629:             .BorderStyle = 0
630:             .Value       = 1
631:             .Visible     = .T.
632:         ENDWITH
633:         WITH loc_oPagina.obj_4c_OptCustos.Buttons(1)
634:             .Caption   = "Sim"
635:             .Left      = 5
636:             .Top       = 5
637:             .Width     = 34
638:             .AutoSize  = .T.
639:             .Alignment = 0
640:             .BackStyle = 0
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .ForeColor = RGB(90, 90, 90)
644:         ENDWITH
645:         WITH loc_oPagina.obj_4c_OptCustos.Buttons(2)
646:             .Caption   = "N" + CHR(227) + "o"
647:             .Left      = 51
648:             .Top       = 5
649:             .Width     = 37
650:             .AutoSize  = .T.
651:             .BackStyle = 0
652:             .FontName  = "Tahoma"
653:             .FontSize  = 8
654:             .ForeColor = RGB(90, 90, 90)
655:         ENDWITH
656: 
657:         *-- ===================================================================
658:         *-- Campo: Imprimir (OptImp -> obj_4c_OptImp) - OptionGroup Sim/Nao
659:         *-- Original: Top=149, Left=393, Width=93. Compensado: 149+29+8=186
660:         *-- ===================================================================
661:         loc_oPagina.AddObject("lbl_4c_Imprimir", "Label")
662:         WITH loc_oPagina.lbl_4c_Imprimir
663:             .Caption   = "Imprimir :"
664:             .Top       = 191
665:             .Left      = 349
666:             .Width     = 47
667:             .Height    = 15
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8
670:             .FontBold  = .F.

*-- Linhas 676 a 726:
676: 
677:         loc_oPagina.AddObject("obj_4c_OptImp", "OptionGroup")
678:         WITH loc_oPagina.obj_4c_OptImp
679:             .Top         = 186
680:             .Left        = 393
681:             .Width       = 98
682:             .Height      = 25
683:             .ButtonCount = 2
684:             .BackStyle   = 0
685:             .BorderStyle = 0
686:             .Value       = 1
687:             .Visible     = .T.
688:         ENDWITH
689:         WITH loc_oPagina.obj_4c_OptImp.Buttons(1)
690:             .Caption   = "Sim"
691:             .Left      = 5
692:             .Top       = 5
693:             .Width     = 34
694:             .AutoSize  = .T.
695:             .Alignment = 0
696:             .BackStyle = 0
697:             .FontName  = "Tahoma"
698:             .FontSize  = 8
699:             .ForeColor = RGB(90, 90, 90)
700:         ENDWITH
701:         WITH loc_oPagina.obj_4c_OptImp.Buttons(2)
702:             .Caption   = "N" + CHR(227) + "o"
703:             .Left      = 51
704:             .Top       = 5
705:             .Width     = 37
706:             .AutoSize  = .T.
707:             .BackStyle = 0
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .ForeColor = RGB(90, 90, 90)
711:         ENDWITH
712: 
713:         *-- ===================================================================
714:         *-- Campo: Utilizar Produto Acabado (optUsarPAs -> obj_4c_OptUsarPAs)
715:         *-- Original: Top=171, Left=393, Width=93. Compensado: 171+29+8=208
716:         *-- ===================================================================
717:         loc_oPagina.AddObject("lbl_4c_UtilizaProdutoAcabado", "Label")
718:         WITH loc_oPagina.lbl_4c_UtilizaProdutoAcabado
719:             .Caption   = "Utilizar Produto Acabado :"
720:             .Top       = 213
721:             .Left      = 269
722:             .Width     = 127
723:             .Height    = 15
724:             .FontName  = "Tahoma"
725:             .FontSize  = 8
726:             .FontBold  = .F.

*-- Linhas 732 a 782:
732: 
733:         loc_oPagina.AddObject("obj_4c_OptUsarPAs", "OptionGroup")
734:         WITH loc_oPagina.obj_4c_OptUsarPAs
735:             .Top         = 208
736:             .Left        = 393
737:             .Width       = 98
738:             .Height      = 25
739:             .ButtonCount = 2
740:             .BackStyle   = 0
741:             .BorderStyle = 0
742:             .Value       = 1
743:             .Visible     = .T.
744:         ENDWITH
745:         WITH loc_oPagina.obj_4c_OptUsarPAs.Buttons(1)
746:             .Caption   = "Sim"
747:             .Left      = 5
748:             .Top       = 5
749:             .Width     = 34
750:             .AutoSize  = .T.
751:             .Alignment = 0
752:             .BackStyle = 0
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .ForeColor = RGB(90, 90, 90)
756:         ENDWITH
757:         WITH loc_oPagina.obj_4c_OptUsarPAs.Buttons(2)
758:             .Caption   = "N" + CHR(227) + "o"
759:             .Left      = 51
760:             .Top       = 5
761:             .Width     = 37
762:             .AutoSize  = .T.
763:             .BackStyle = 0
764:             .FontName  = "Tahoma"
765:             .FontSize  = 8
766:             .ForeColor = RGB(90, 90, 90)
767:         ENDWITH
768: 
769:         *-- ===================================================================
770:         *-- Campo: Maiusculos (OptMaius -> obj_4c_OptMaius) - OptionGroup Sim/Nao
771:         *-- Original: Top=193, Left=393, Width=93. Compensado: 193+29+8=230
772:         *-- ===================================================================
773:         loc_oPagina.AddObject("lbl_4c_Maiusculos", "Label")
774:         WITH loc_oPagina.lbl_4c_Maiusculos
775:             .Caption   = "Mai" + CHR(250) + "sculos :"
776:             .Top       = 235
777:             .Left      = 336
778:             .Width     = 60
779:             .Height    = 15
780:             .FontName  = "Tahoma"
781:             .FontSize  = 8
782:             .FontBold  = .F.

*-- Linhas 788 a 821:
788: 
789:         loc_oPagina.AddObject("obj_4c_OptMaius", "OptionGroup")
790:         WITH loc_oPagina.obj_4c_OptMaius
791:             .Top         = 230
792:             .Left        = 393
793:             .Width       = 98
794:             .Height      = 25
795:             .ButtonCount = 2
796:             .BackStyle   = 0
797:             .BorderStyle = 0
798:             .Value       = 1
799:             .Visible     = .T.
800:         ENDWITH
801:         WITH loc_oPagina.obj_4c_OptMaius.Buttons(1)
802:             .Caption   = "Sim"
803:             .Left      = 5
804:             .Top       = 5
805:             .Width     = 34
806:             .AutoSize  = .T.
807:             .Alignment = 0
808:             .BackStyle = 0
809:             .FontName  = "Tahoma"
810:             .FontSize  = 8
811:             .ForeColor = RGB(90, 90, 90)
812:         ENDWITH
813:         WITH loc_oPagina.obj_4c_OptMaius.Buttons(2)
814:             .Caption   = "N" + CHR(227) + "o"
815:             .Left      = 51
816:             .Top       = 5
817:             .Width     = 37
818:             .AutoSize  = .T.
819:             .BackStyle = 0
820:             .FontName  = "Tahoma"
821:             .FontSize  = 8

*-- Linhas 832 a 841:
832:         *-- ===================================================================
833:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
834:         WITH loc_oPagina.grd_4c_Dados
835:             .Top                = 258
836:             .Left               = 400
837:             .Width              = 223
838:             .Height             = 350
839:             .ColumnCount        = 2
840:             .FontName           = "Verdana"
841:             .FontSize           = 8

*-- Linhas 854 a 913:
854:             .Column1.Resizable          = .F.
855:             .Column1.FontName           = "Verdana"
856:             .Column1.FontSize           = 8
857:             .Column1.Header1.Caption    = "Grupo"
858:             .Column1.Header1.Alignment  = 2
859:             .Column2.Width              = 150
860:             .Column2.Movable            = .F.
861:             .Column2.Resizable          = .F.
862:             .Column2.FontName           = "Verdana"
863:             .Column2.FontSize           = 8
864:             .Column2.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
865:             .Column2.Header1.Alignment  = 2
866:         ENDWITH
867: 
868:         *-- Lookup na coluna Grupo (F4/DblClick abrem FormBuscaAuxiliar em SigCdGrp)
869:         BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GridGruposColumn1KeyPress")
870:         BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "DblClick", THIS, "GridGruposColumn1DblClick")
871: 
872:         *-- Lookup na coluna Descricao (mesmo comportamento do legado - fwBuscaExt tambem
873:         *-- disparado a partir da coluna de descricao)
874:         BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GridGruposColumn2KeyPress")
875:         BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Text1, "DblClick", THIS, "GridGruposColumn2DblClick")
876: 
877:         *-- ===================================================================
878:         *-- Botao Excluir linha da grade (cmdExcluir -> cmd_4c_CmdExcluir)
879:         *-- Original: Top=373, Left=626, Width=45, Height=46. Compensado: 373+29+8=410
880:         *-- ===================================================================
881:         loc_oPagina.AddObject("cmd_4c_CmdExcluir", "CommandButton")
882:         WITH loc_oPagina.cmd_4c_CmdExcluir
883:             .Top           = 410
884:             .Left          = 626
885:             .Width         = 45
886:             .Height        = 46
887:             .Caption       = ""
888:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
889:             .FontName      = "Arial"
890:             .FontSize      = 7
891:             .FontBold      = .F.
892:             .FontItalic    = .F.
893:             .BackColor     = RGB(255, 255, 255)
894:             .ToolTipText   = "Excluir Item da Grade"
895:             .Themes        = .F.
896:             .Visible       = .T.
897:         ENDWITH
898:         BINDEVENT(loc_oPagina.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirLinhaGrupoClick")
899: 
900:         THIS.TornarControlesVisiveis(loc_oPagina)
901:     ENDPROC
902: 
903:     *===========================================================================
904:     * CarregarGridGrupos - Vincula o grid de Grupos (Page2) ao cursor local do BO
905:     * (this_oBusinessObject.this_cCursorGrupos). Deve ser chamado sempre que o
906:     * cursor for (re)criado: apos CarregarGrupos() [ALTERAR/VISUALIZAR] ou
907:     * InicializarCursoresGrid() [INCLUIR].
908:     * RecordSource/ControlSource sao definidos aqui (nao na criacao do Grid) para
909:     * nao serem resetados por sucessivas trocas de cursor (Problema 48).
910:     *===========================================================================
911:     PROTECTED PROCEDURE CarregarGridGrupos()
912:         LOCAL loc_oGrid, loc_cCursor
913:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrupos

*-- Linhas 925 a 938:
925:         loc_oGrid.Column1.ControlSource   = loc_cCursor + ".cgrus"
926:         loc_oGrid.Column1.CurrentControl  = "Text1"
927:         loc_oGrid.Column1.Width           = 40
928:         loc_oGrid.Column1.Header1.Caption = "Grupo"
929: 
930:         loc_oGrid.Column2.ControlSource   = loc_cCursor + ".dgrus"
931:         loc_oGrid.Column2.CurrentControl  = "Text1"
932:         loc_oGrid.Column2.Width           = 150
933:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
934: 
935:         loc_oGrid.Refresh()
936: 
937:         RETURN .T.
938:     ENDPROC

*-- Linhas 1090 a 1099:
1090:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1091:                         loc_oGrid.Column1.Width = 150
1092:                         loc_oGrid.Column2.Width = 290
1093:                         loc_oGrid.Column1.Header1.Caption = "Tipos"
1094:                         loc_oGrid.Column2.Header1.Caption = "Descrs"
1095:                         THIS.FormatarGridLista(loc_oGrid)
1096:                     ENDIF
1097:                     loc_lResultado = .T.
1098:                 ENDIF
1099:             ENDIF

*-- Linhas 1149 a 1159:
1149:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1150: 
1151:         WITH THIS.this_oBusinessObject
1152:             loc_oPg2.txt_4c_Tipos.Value      = .this_cTipo
1153:             loc_oPg2.txt_4c_Descrs.Value     = .this_cDescricao
1154:             loc_oPg2.txt_4c_NOrdems.Value    = .this_nOrdemImpressao
1155:             loc_oPg2.obj_4c_OptCustos.Value  = IIF(.this_nCalculaCustos = 0, 1, .this_nCalculaCustos)
1156:             loc_oPg2.obj_4c_OptImp.Value     = IIF(.this_nImprimir = 0, 1, .this_nImprimir)
1157:             loc_oPg2.obj_4c_OptUsarPAs.Value = IIF(.this_nUtilizaProdutoAcabado = 0, 1, .this_nUtilizaProdutoAcabado)
1158:             loc_oPg2.obj_4c_OptMaius.Value   = IIF(.this_nMaiusculos = 0, 1, .this_nMaiusculos)
1159:         ENDWITH

*-- Linhas 1197 a 1213:
1197: 
1198:     *===========================================================================
1199:     * AjustarBotoesPorModo - Ajusta botoes de acao da Page2 conforme o modo
1200:     * cmd_4c_Confirmar fica desabilitado em modo VISUALIZAR (CLAUDE.md #10/#20)
1201:     *===========================================================================
1202:     PROCEDURE AjustarBotoesPorModo()
1203:         LOCAL loc_oPg2, loc_lSoConsulta
1204:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
1205:         loc_lSoConsulta = (THIS.this_cModoAtual == "VISUALIZAR")
1206: 
1207:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lSoConsulta
1208:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1209:     ENDPROC
1210: 
1211:     *===========================================================================
1212:     * BtnIncluirClick - Inicia a inclusao de um novo Tipo de Composicao
1213:     * PUBLIC (metodos chamados via BINDEVENT nao podem ser PROTECTED - regra #3)

*-- Linhas 1423 a 1431:
1423:     ENDPROC
1424: 
1425:     *===========================================================================
1426:     * BtnEncerrarClick - Fecha o formulario (cnt_4c_Saida.cmd_4c_Encerrar)
1427:     *===========================================================================
1428:     PROCEDURE BtnEncerrarClick()
1429:         THIS.Release()
1430:     ENDPROC
1431: 


### BO (C:\4c\projeto\app\classes\TpcBO.prg):
*====================================================================
* TpcBO.prg
*
* Business Object para Cadastro de Tipos de Composicao
* Tabela principal : SigCdTpc  (tipos, descrs, custos, nchkimps, nchkmais, nordems, usarpas)
* Tabela de detalhe: SigCdCom  (cidchaves PK, tipos FK, cgrus) - grupos vinculados ao tipo
*   A descricao do grupo (dgrus) vem de SigCdGrp via JOIN - SigCdCom nao tem coluna de descricao.
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TpcBO AS BusinessBase

    *-- Propriedades da entidade principal (mapeamento para tabela SigCdTpc)
    this_cTipo                   = ""    && tipos    char(20) - PK
    this_cDescricao               = ""    && descrs   char(40)
    this_nCalculaCustos           = 0     && custos   numeric(1,0) - OptionGroup (1=Sim/2=Nao)
    this_nImprimir                = 0     && nchkimps numeric(1,0) - OptionGroup (1=Sim/2=Nao)
    this_nMaiusculos               = 0     && nchkmais numeric(1,0) - OptionGroup (1=Sim/2=Nao)
    this_nOrdemImpressao           = 0     && nordems  numeric(2,0)
    this_nUtilizaProdutoAcabado    = 0     && usarpas  numeric(1,0) - OptionGroup (1=Sim/2=Nao)

    *-- Propriedade auxiliar do detalhe (grade de Grupos vinculados - tabela SigCdCom)
    *-- Cursor local usado pelo Grid da Page2: colunas CGrus (grupo) + DGrus (descricao via JOIN SigCdGrp)
    this_cCursorGrupos             = "cursor_4c_Grupos"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdTpc"
            THIS.this_cCampoChave = "tipos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TpcBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipo)
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de tipos de composicao no cursor_4c_Dados
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT tipos, descrs FROM SigCdTpc ORDER BY tipos"
            ELSE
                loc_cSQL = "SELECT tipos, descrs FROM SigCdTpc" + ;
                           " WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                           " ORDER BY tipos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tipos de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tipos de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK = tipos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cTipo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT custos, descrs, tipos, nchkimps, nchkmais," + ;
                       " nordems, usarpas" + ;
                       " FROM SigCdTpc" + ;
                       " WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(par_cTipo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
                IF loc_lSucesso
                    THIS.CarregarGrupos(par_cTipo)
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cTipo                  = TratarNulo(tipos, "C")
            THIS.this_cDescricao             = TratarNulo(descrs, "C")
            THIS.this_nCalculaCustos         = TratarNulo(custos, "N")
            THIS.this_nImprimir              = TratarNulo(nchkimps, "N")
            THIS.this_nMaiusculos            = TratarNulo(nchkmais, "N")
            THIS.this_nOrdemImpressao        = TratarNulo(nordems, "N")
            THIS.this_nUtilizaProdutoAcabado = TratarNulo(usarpas, "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarGrupos - Carrega grade de Grupos vinculados ao Tipo
    * (SigCdCom.cgrus + descricao via JOIN SigCdGrp.dgrus) em cursor_4c_Grupos
    *====================================================================
    PROCEDURE CarregarGrupos(par_cTipo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            loc_cSQL = "SELECT a.cgrus, ISNULL(b.dgrus, '') AS dgrus" + ;
                       " FROM SigCdCom a" + ;
                       " LEFT JOIN SigCdGrp b ON RTRIM(b.cgrus) = RTRIM(a.cgrus)" + ;
                       " WHERE RTRIM(a.tipos) = " + EscaparSQL(ALLTRIM(par_cTipo)) + ;
                       " ORDER BY a.cgrus"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupos do tipo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarCursoresGrid - Cria cursor vazio de Grupos para INCLUIR
    *====================================================================
    PROCEDURE InicializarCursoresGrid()
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Grupos (cgrus C(3), dgrus C(20))
        SET NULL OFF
    ENDPROC

    *====================================================================
    * SalvarGrupos - Regrava vinculos de Grupos do Tipo (SigCdCom)
    * Espelha o legado: apaga tudo do Tipo e reinsere os CGrus distintos
    * e nao vazios presentes em cursor_4c_Grupos
    *====================================================================
    PROTECTED PROCEDURE SalvarGrupos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
        loc_lSucesso = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_cSQL = "DELETE FROM SigCdCom WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
                IF USED("cursor_4c_Grupos") AND RECCOUNT("cursor_4c_Grupos") > 0
                    IF USED("cursor_4c_GruposGravar")
                        USE IN cursor_4c_GruposGravar
                    ENDIF

                    SELECT DISTINCT cgrus ;
                        FROM cursor_4c_Grupos ;
                       WHERE !EMPTY(ALLTRIM(cgrus)) ;
                       ORDER BY cgrus ;
                        INTO CURSOR cursor_4c_GruposGravar

                    SELECT cursor_4c_GruposGravar
                    SCAN
                        loc_cCidchaves = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigCdCom (tipos, cgrus, cidchaves)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cTipo) + "," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_GruposGravar.cgrus)) + "," + ;
                                   EscaparSQL(loc_cCidchaves) + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            loc_lSucesso = .F.
                            MsgErro("Erro ao inserir grupo do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_GruposGravar")
                        USE IN cursor_4c_GruposGravar
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MsgErro("Erro ao salvar grupos do tipo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdTpc + grade de grupos (SigCdCom)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdTpc" + ;
                       " (custos, descrs, tipos, nchkimps, nchkmais, nordems, usarpas)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCalculaCustos) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       EscaparSQL(THIS.this_cTipo) + "," + ;
                       FormatarNumeroSQL(THIS.this_nImprimir) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaiusculos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOrdemImpressao) + "," + ;
                       FormatarNumeroSQL(THIS.this_nUtilizaProdutoAcabado) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                THIS.SalvarGrupos()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tipo de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdTpc + grade de grupos (SigCdCom)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdTpc SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " custos = " + FormatarNumeroSQL(THIS.this_nCalculaCustos) + "," + ;
                       " nchkimps = " + FormatarNumeroSQL(THIS.this_nImprimir) + "," + ;
                       " nchkmais = " + FormatarNumeroSQL(THIS.this_nMaiusculos) + "," + ;
                       " nordems = " + FormatarNumeroSQL(THIS.this_nOrdemImpressao) + "," + ;
                       " usarpas = " + FormatarNumeroSQL(THIS.this_nUtilizaProdutoAcabado) + ;
                       " WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.SalvarGrupos()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tipo de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE SigCdCom (grupos) + SigCdTpc (registro principal)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Excluir grupos vinculados (SigCdCom)
            loc_cSQL = "DELETE FROM SigCdCom WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- 2. Excluir registro principal (SigCdTpc)
                loc_cSQL = "DELETE FROM SigCdTpc WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir tipo de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

