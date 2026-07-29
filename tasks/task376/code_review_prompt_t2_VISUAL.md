# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Vendedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome Vendedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição Local' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conferido' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcnl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1974 linhas total):

*-- Linhas 65 a 74:
65:                 THIS.ConfigurarPageFrame()
66: 
67:                 *-- Propagar titulo para labels do cabecalho
68:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
69:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
70: 
71:                 *-- Carregar lista inicial (pular se validando UI)
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                     THIS.CarregarLista()
74:                 ENDIF

*-- Linhas 89 a 121:
89: 
90:     *==========================================================================
91:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista + Dados)
92:     * PageFrame.Top = -29 oculta as abas (Tabs=.F.)
93:     * Todos os controles nas Pages precisam compensar +29 no Top
94:     *==========================================================================
95:     PROTECTED PROCEDURE ConfigurarPageFrame()
96:         LOCAL loc_oErro
97: 
98:         TRY
99:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
100: 
101:             WITH THIS.pgf_4c_Paginas
102:                 .Top       = -29
103:                 .Left      = 0
104:                 .Width     = 1000
105:                 .Height    = 629
106:                 .PageCount = 2
107:                 .Tabs      = .F.
108:                 .Visible   = .T.
109: 
110:                 *-- Page1: Lista de contagens
111:                 .Page1.Caption   = "Lista"
112:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:                 .Page1.BackColor = RGB(100, 100, 100)
114: 
115:                 *-- Page2: Dados da contagem (cabecalho + itens)
116:                 .Page2.Caption   = "Dados"
117:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118:                 .Page2.BackColor = RGB(100, 100, 100)
119:             ENDWITH
120: 
121:             *-- Imagens de fundo das paginas

*-- Linhas 135 a 143:
135:     *==========================================================================
136:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD,
137:     *   botoes especiais (Espelho/Fechar/Abrir) e grid de listagem
138:     * TOPS compensados (+29 por PageFrame.Top=-29)
139:     *==========================================================================
140:     PROTECTED PROCEDURE ConfigurarPaginaLista()
141:         LOCAL loc_oPagina, loc_oErro
142:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
143: 

*-- Linhas 151 a 190:
151:             *--------------------------------------------------------------
152:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
153:             WITH loc_oPagina.cnt_4c_Cabecalho
154:                 .Top         = 31
155:                 .Left        = 0
156:                 .Width       = THIS.Width
157:                 .Height      = 80
158:                 .BackColor   = RGB(100, 100, 100)
159:                 .BorderWidth = 0
160:                 .Visible     = .T.
161:             ENDWITH
162: 
163:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
164:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
165:                 .Top       = 15
166:                 .Left      = 10
167:                 .Width     = 769
168:                 .Height    = 40
169:                 .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
170:                 .FontName  = "Tahoma"
171:                 .FontSize  = 16
172:                 .FontBold  = .T.
173:                 .ForeColor = RGB(0, 0, 0)
174:                 .BackStyle = 0
175:                 .AutoSize  = .F.
176:                 .Visible   = .T.
177:             ENDWITH
178: 
179:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
180:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
181:                 .Top       = 18
182:                 .Left      = 10
183:                 .Width     = 769
184:                 .Height    = 46
185:                 .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
186:                 .FontName  = "Tahoma"
187:                 .FontSize  = 16
188:                 .FontBold  = .T.
189:                 .ForeColor = RGB(255, 255, 255)
190:                 .BackStyle = 0

*-- Linhas 198 a 222:
198:             *--------------------------------------------------------------
199:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
200:             WITH loc_oPagina.cnt_4c_Botoes
201:                 .Top         = 29
202:                 .Left        = 542
203:                 .Width       = 390
204:                 .Height      = 85
205:                 .BackStyle = 0
206:                 .BorderWidth = 0
207:                 .Visible     = .T.
208:             ENDWITH
209: 
210:             *-- Incluir
211:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
212:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
213:                 .Caption         = "Incluir"
214:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
215:                 .PicturePosition = 13
216:                 .Top             = 5
217:                 .Left            = 5
218:                 .Width           = 75
219:                 .Height          = 75
220:                 .BackColor       = RGB(255, 255, 255)
221:                 .ForeColor       = RGB(90, 90, 90)
222:                 .FontName        = "Tahoma"

*-- Linhas 230 a 247:
230:                 .AutoSize        = .F.
231:                 .Visible         = .T.
232:             ENDWITH
233:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
234: 
235:             *-- Visualizar
236:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
237:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
238:                 .Caption         = "Visualizar"
239:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
240:                 .PicturePosition = 13
241:                 .Top             = 5
242:                 .Left            = 80
243:                 .Width           = 75
244:                 .Height          = 75
245:                 .BackColor       = RGB(255, 255, 255)
246:                 .ForeColor       = RGB(90, 90, 90)
247:                 .FontName        = "Tahoma"

*-- Linhas 255 a 272:
255:                 .AutoSize        = .F.
256:                 .Visible         = .T.
257:             ENDWITH
258:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
259: 
260:             *-- Alterar
261:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
262:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
263:                 .Caption         = "Alterar"
264:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
265:                 .PicturePosition = 13
266:                 .Top             = 5
267:                 .Left            = 155
268:                 .Width           = 75
269:                 .Height          = 75
270:                 .BackColor       = RGB(255, 255, 255)
271:                 .ForeColor       = RGB(90, 90, 90)
272:                 .FontName        = "Tahoma"

*-- Linhas 280 a 297:
280:                 .AutoSize        = .F.
281:                 .Visible         = .T.
282:             ENDWITH
283:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
284: 
285:             *-- Excluir
286:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
287:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
288:                 .Caption         = "Excluir"
289:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
290:                 .PicturePosition = 13
291:                 .Top             = 5
292:                 .Left            = 230
293:                 .Width           = 75
294:                 .Height          = 75
295:                 .BackColor       = RGB(255, 255, 255)
296:                 .ForeColor       = RGB(90, 90, 90)
297:                 .FontName        = "Tahoma"

*-- Linhas 305 a 322:
305:                 .AutoSize        = .F.
306:                 .Visible         = .T.
307:             ENDWITH
308:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
309: 
310:             *-- Buscar
311:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
312:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
313:                 .Caption         = "Buscar"
314:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
315:                 .PicturePosition = 13
316:                 .Top             = 5
317:                 .Left            = 305
318:                 .Width           = 75
319:                 .Height          = 75
320:                 .BackColor       = RGB(255, 255, 255)
321:                 .ForeColor       = RGB(90, 90, 90)
322:                 .FontName        = "Tahoma"

*-- Linhas 330 a 360:
330:                 .AutoSize        = .F.
331:                 .Visible         = .T.
332:             ENDWITH
333:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
334: 
335:             *--------------------------------------------------------------
336:             * Container Saida - padrao canonico (PREVALECE SOBRE PILAR 1)
337:             *--------------------------------------------------------------
338:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
339:             WITH loc_oPagina.cnt_4c_Saida
340:                 .Top         = 29
341:                 .Left        = 917
342:                 .Width       = 90
343:                 .Height      = 85
344:                 .BackStyle   = 0
345:                 .BorderWidth = 0
346:                 .Visible     = .T.
347:             ENDWITH
348: 
349:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
350:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
351:                 .Caption         = "Encerrar"
352:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
353:                 .PicturePosition = 13
354:                 .Top             = 5
355:                 .Left            = 5
356:                 .Width           = 75
357:                 .Height          = 75
358:                 .BackColor       = RGB(255, 255, 255)
359:                 .ForeColor       = RGB(90, 90, 90)
360:                 .FontName        = "Tahoma"

*-- Linhas 368 a 448:
368:                 .AutoSize        = .F.
369:                 .Visible         = .T.
370:             ENDWITH
371:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
372: 
373:             *--------------------------------------------------------------
374:             * Botoes especiais do legado: Espelho / Fechar / Abrir
375:             * Original: Top=82 -> Compensado: Top=111
376:             * Posicoes: Left=14, 119, 224 (direto na Page1)
377:             *--------------------------------------------------------------
378:             loc_oPagina.AddObject("cmd_4c_Espelho", "CommandButton")
379:             WITH loc_oPagina.cmd_4c_Espelho
380:                 .Caption       = "Espelho"
381:                 .Top           = 111
382:                 .Left          = 14
383:                 .Width         = 105
384:                 .Height        = 40
385:                 .BackColor     = RGB(200, 200, 200)
386:                 .ForeColor     = RGB(90, 90, 90)
387:                 .FontName      = "Tahoma"
388:                 .FontSize      = 8
389:                 .FontBold      = .F.
390:                 .Themes        = .F.
391:                 .SpecialEffect = 0
392:                 .Visible       = .T.
393:             ENDWITH
394:             BINDEVENT(loc_oPagina.cmd_4c_Espelho, "Click", THIS, "BtnEspelhoClick")
395: 
396:             loc_oPagina.AddObject("cmd_4c_Fechar", "CommandButton")
397:             WITH loc_oPagina.cmd_4c_Fechar
398:                 .Caption       = "Encerrar"
399:                 .Top           = 111
400:                 .Left          = 119
401:                 .Width         = 75
402:                 .Height        = 75
403:                 .BackColor     = RGB(200, 200, 200)
404:                 .ForeColor     = RGB(90, 90, 90)
405:                 .FontName      = "Tahoma"
406:                 .FontSize      = 8
407:                 .FontBold      = .F.
408:                 .Themes        = .F.
409:                 .SpecialEffect = 0
410:                 .Visible       = .T.
411:             ENDWITH
412:             BINDEVENT(loc_oPagina.cmd_4c_Fechar, "Click", THIS, "BtnFecharContagemClick")
413: 
414:             loc_oPagina.AddObject("cmd_4c_Abrir", "CommandButton")
415:             WITH loc_oPagina.cmd_4c_Abrir
416:                 .Caption       = "Abrir"
417:                 .Top           = 111
418:                 .Left          = 224
419:                 .Width         = 105
420:                 .Height        = 40
421:                 .BackColor     = RGB(200, 200, 200)
422:                 .ForeColor     = RGB(90, 90, 90)
423:                 .FontName      = "Tahoma"
424:                 .FontSize      = 8
425:                 .FontBold      = .F.
426:                 .Themes        = .F.
427:                 .SpecialEffect = 0
428:                 .Visible       = .T.
429:             ENDWITH
430:             BINDEVENT(loc_oPagina.cmd_4c_Abrir, "Click", THIS, "BtnAbrirContagemClick")
431: 
432:             *--------------------------------------------------------------
433:             * Grid de listagem de contagens
434:             * Abaixo dos botoes especiais: 111+40+4=155 -> Top=155
435:             * Width=900 para nao sobrepor cnt_4c_Saida (Left=917)
436:             *--------------------------------------------------------------
437:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
438:             loc_oPagina.grd_4c_Dados.RecordSource = ""
439:             loc_oPagina.grd_4c_Dados.ColumnCount  = 7
440: 
441:             WITH loc_oPagina.grd_4c_Dados
442:                 .Top                = 155
443:                 .Left               = 12
444:                 .Width              = 900
445:                 .Height             = 440
446:                 .FontName           = "Verdana"
447:                 .FontSize           = 8
448:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 469 a 477:
469: 
470:     *==========================================================================
471:     * ConfigurarPaginaDados - Configura Page2: botoes, campos cabecalho (Fase 5)
472:     * TOPS compensados (+29 por PageFrame.Top=-29)
473:     *==========================================================================
474:     PROTECTED PROCEDURE ConfigurarPaginaDados()
475:         LOCAL loc_oPagina, loc_oErro
476:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
477: 

*-- Linhas 485 a 508:
485:             *--------------------------------------------------------------
486:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
487:             WITH loc_oPagina.cnt_4c_BotoesAcao
488:                 .Top         = 33
489:                 .Left        = 842
490:                 .Width       = 160
491:                 .Height      = 85
492:                 .BackStyle   = 0
493:                 .Visible     = .T.
494:             ENDWITH
495: 
496:             *-- Confirmar (Salvar)
497:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
498:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
499:                 .Caption         = "Confirmar"
500:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
501:                 .PicturePosition = 13
502:                 .Top             = 5
503:                 .Left            = 5
504:                 .Width           = 75
505:                 .Height          = 75
506:                 .BackColor       = RGB(255, 255, 255)
507:                 .ForeColor       = RGB(90, 90, 90)
508:                 .FontName        = "Tahoma"

*-- Linhas 516 a 533:
516:                 .AutoSize        = .F.
517:                 .Visible         = .T.
518:             ENDWITH
519:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
520: 
521:             *-- Cancelar
522:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
523:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
524:                 .Caption         = "Encerrar"
525:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
526:                 .PicturePosition = 13
527:                 .Top             = 5
528:                 .Left            = 80
529:                 .Width           = 75
530:                 .Height          = 75
531:                 .BackColor       = RGB(255, 255, 255)
532:                 .ForeColor       = RGB(90, 90, 90)
533:                 .FontName        = "Tahoma"

*-- Linhas 541 a 589:
541:                 .AutoSize        = .F.
542:                 .Visible         = .T.
543:             ENDWITH
544:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
545: 
546:             *--------------------------------------------------------------
547:             * Shape1 - elemento visual decorativo da area de niveis
548:             * Original: Top=169, Left=626 -> Compensado: Top=198
549:             *--------------------------------------------------------------
550:             loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
551:             WITH loc_oPagina.shp_4c_Shape1
552:                 .Top         = 198
553:                 .Left        = 626
554:                 .Width       = 364
555:                 .Height      = 144
556:                 .BackStyle   = 0
557:                 .BorderWidth = 1
558:                 .BorderColor = RGB(128, 128, 128)
559:                 .Visible     = .T.
560:             ENDWITH
561: 
562:             *--------------------------------------------------------------
563:             * Label4 "Codigo :" + txt_4c_Codigo (getCods - somente leitura)
564:             * Original: Label4.Top=99, getCods.Top=94 -> Compensados: +29
565:             *--------------------------------------------------------------
566:             loc_oPagina.AddObject("lbl_4c_Label4", "Label")
567:             WITH loc_oPagina.lbl_4c_Label4
568:                 .Caption   = "C" + CHR(243) + "digo : "
569:                 .Top       = 128
570:                 .Left      = 301
571:                 .Width     = 45
572:                 .Height    = 15
573:                 .FontName  = "Tahoma"
574:                 .FontSize  = 8
575:                 .ForeColor = RGB(90, 90, 90)
576:                 .BackStyle = 0
577:                 .Visible   = .T.
578:             ENDWITH
579: 
580:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
581:             WITH loc_oPagina.txt_4c_Codigo
582:                 .Value         = ""
583:                 .Top           = 123
584:                 .Left          = 349
585:                 .Width         = 80
586:                 .Height        = 24
587:                 .FontName      = "Tahoma"
588:                 .FontSize      = 8
589:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 597 a 627:
597: 
598:             *--------------------------------------------------------------
599:             * Label2 "Vendedor :" + txt_4c_Conta (getConta) + txt_4c_DConta
600:             * Original: Label2.Top=127, getConta.Top=122, getDConta.Top=122 -> +29
601:             * getConta: habilitado apenas em INSERIR (When = INSERIR ou CONSULTAR)
602:             * getDConta: descricao do vendedor - somente leitura
603:             *--------------------------------------------------------------
604:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
605:             WITH loc_oPagina.lbl_4c_Label2
606:                 .Caption   = "Vendedor : "
607:                 .Top       = 156
608:                 .Left      = 288
609:                 .Width     = 58
610:                 .Height    = 15
611:                 .FontName  = "Tahoma"
612:                 .FontSize  = 8
613:                 .ForeColor = RGB(90, 90, 90)
614:                 .BackStyle = 0
615:                 .Visible   = .T.
616:             ENDWITH
617: 
618:             loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
619:             WITH loc_oPagina.txt_4c_Conta
620:                 .Value         = ""
621:                 .Top           = 151
622:                 .Left          = 349
623:                 .Width         = 80
624:                 .Height        = 24
625:                 .FontName      = "Tahoma"
626:                 .FontSize      = 8
627:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 638 a 647:
638:             loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
639:             WITH loc_oPagina.txt_4c_DConta
640:                 .Value         = ""
641:                 .Top           = 151
642:                 .Left          = 431
643:                 .Width         = 290
644:                 .Height        = 24
645:                 .FontName      = "Tahoma"
646:                 .FontSize      = 8
647:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 655 a 732:
655: 
656:             *--------------------------------------------------------------
657:             * Label9 "Ordenacao :" + opt_4c_OptOrdem (4 opcoes)
658:             * Original: Label9.Top=150, OptOrdem.Top=145 -> Compensados: +29
659:             * Opcoes: Local / Nv.2 / Nv.3 / Nv.4  (muda ordem do GrdLoc)
660:             *--------------------------------------------------------------
661:             loc_oPagina.AddObject("lbl_4c_Label9", "Label")
662:             WITH loc_oPagina.lbl_4c_Label9
663:                 .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
664:                 .Top       = 179
665:                 .Left      = 284
666:                 .Width     = 62
667:                 .Height    = 15
668:                 .FontName  = "Tahoma"
669:                 .FontSize  = 8
670:                 .ForeColor = RGB(90, 90, 90)
671:                 .BackStyle = 0
672:                 .Visible   = .T.
673:             ENDWITH
674: 
675:             loc_oPagina.AddObject("opt_4c_OptOrdem", "OptionGroup")
676:             WITH loc_oPagina.opt_4c_OptOrdem
677:                 .ButtonCount = 4
678:                 .Top         = 174
679:                 .Left        = 346
680:                 .Width       = 355
681:                 .Height      = 25
682:                 .BackStyle   = 0
683:                 .BorderStyle = 0
684:                 .Value       = 1
685:                 .Visible     = .T.
686:             ENDWITH
687:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(1)
688:                 .Caption   = "Local"
689:                 .BackStyle = 0
690:                 .Left      = 5
691:                 .Top       = 3
692:                 .Width     = 60
693:                 .AutoSize  = .T.
694:                 .FontName  = "Tahoma"
695:                 .FontSize  = 8
696:                 .ForeColor = RGB(90, 90, 90)
697:                 .Themes    = .F.
698:             ENDWITH
699:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(2)
700:                 .Caption   = "Nv. 2"
701:                 .BackStyle = 0
702:                 .Left      = 90
703:                 .Top       = 3
704:                 .Width     = 60
705:                 .AutoSize  = .T.
706:                 .FontName  = "Tahoma"
707:                 .FontSize  = 8
708:                 .ForeColor = RGB(90, 90, 90)
709:                 .Themes    = .F.
710:             ENDWITH
711:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(3)
712:                 .Caption   = "Nv. 3"
713:                 .BackStyle = 0
714:                 .Left      = 180
715:                 .Top       = 3
716:                 .Width     = 60
717:                 .AutoSize  = .T.
718:                 .FontName  = "Tahoma"
719:                 .FontSize  = 8
720:                 .ForeColor = RGB(90, 90, 90)
721:                 .Themes    = .F.
722:             ENDWITH
723:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(4)
724:                 .Caption   = "Nv. 4"
725:                 .BackStyle = 0
726:                 .Left      = 270
727:                 .Top       = 3
728:                 .Width     = 60
729:                 .AutoSize  = .T.
730:                 .FontName  = "Tahoma"
731:                 .FontSize  = 8
732:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 738 a 750:
738:             * Label1 "Local :" - cabecalho da area do GrdLoc
739:             * Original: Top=172 -> Compensado: Top=201
740:             *--------------------------------------------------------------
741:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
742:             WITH loc_oPagina.lbl_4c_Label1
743:                 .Caption   = "Local : "
744:                 .Top       = 201
745:                 .Left      = 310
746:                 .Width     = 36
747:                 .Height    = 15
748:                 .FontName  = "Tahoma"
749:                 .FontSize  = 8
750:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 762 a 771:
762:             loc_oPagina.grd_4c_GrdLoc.ColumnCount  = 3
763: 
764:             WITH loc_oPagina.grd_4c_GrdLoc
765:                 .Top                = 198
766:                 .Left               = 349
767:                 .Width              = 263
768:                 .Height             = 419
769:                 .FontName           = "Verdana"
770:                 .FontSize           = 8
771:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 784 a 817:
784:             WITH loc_oPagina.grd_4c_GrdLoc.Column1
785:                 .Width    = 80
786:                 .ReadOnly = .T.
787:                 .Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
788:             ENDWITH
789:             WITH loc_oPagina.grd_4c_GrdLoc.Column2
790:                 .Width    = 60
791:                 .ReadOnly = .F.
792:                 .Header1.Caption = "Qtde."
793:             ENDWITH
794:             WITH loc_oPagina.grd_4c_GrdLoc.Column3
795:                 .Width    = 60
796:                 .ReadOnly = .T.
797:                 .Header1.Caption = "Estoque"
798:             ENDWITH
799:             BINDEVENT(loc_oPagina.grd_4c_GrdLoc, "AfterRowColChange", THIS, "GrdLocAfterRowColChange")
800: 
801:             *--------------------------------------------------------------
802:             * Painel direito: codigos e descricoes de cada nivel de localizacao
803:             * Todos dentro da area do Shape1 (Top=198, Left=626, Width=364, Height=144)
804:             * Label7 "Base :" / Label6 "Segundo Nivel :" / Label5 "Terceiro Nivel :" / Label3 "Quarto Nivel :"
805:             *--------------------------------------------------------------
806: 
807:             *-- Label7 "Base :"  Original: Top=192 -> Compensado: Top=221
808:             loc_oPagina.AddObject("lbl_4c_Label7", "Label")
809:             WITH loc_oPagina.lbl_4c_Label7
810:                 .Caption   = "Base :"
811:                 .Top       = 221
812:                 .Left      = 707
813:                 .Width     = 32
814:                 .Height    = 15
815:                 .FontName  = "Tahoma"
816:                 .FontSize  = 8
817:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 823 a 832:
823:             loc_oPagina.AddObject("txt_4c_Base", "TextBox")
824:             WITH loc_oPagina.txt_4c_Base
825:                 .Value         = ""
826:                 .Top           = 216
827:                 .Left          = 743
828:                 .Width         = 54
829:                 .Height        = 24
830:                 .FontName      = "Tahoma"
831:                 .FontSize      = 8
832:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 842 a 851:
842:             loc_oPagina.AddObject("txt_4c_DBase", "TextBox")
843:             WITH loc_oPagina.txt_4c_DBase
844:                 .Value         = ""
845:                 .Top           = 216
846:                 .Left          = 799
847:                 .Width         = 174
848:                 .Height        = 24
849:                 .FontName      = "Tahoma"
850:                 .FontSize      = 8
851:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 858 a 870:
858:             ENDWITH
859: 
860:             *-- Label6 "Segundo Nivel :"  Original: Top=220 -> Compensado: Top=249
861:             loc_oPagina.AddObject("lbl_4c_Label6", "Label")
862:             WITH loc_oPagina.lbl_4c_Label6
863:                 .Caption   = "Segundo N" + CHR(237) + "vel :"
864:                 .Top       = 249
865:                 .Left      = 662
866:                 .Width     = 77
867:                 .Height    = 15
868:                 .FontName  = "Tahoma"
869:                 .FontSize  = 8
870:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 876 a 885:
876:             loc_oPagina.AddObject("txt_4c_Nvl2", "TextBox")
877:             WITH loc_oPagina.txt_4c_Nvl2
878:                 .Value         = ""
879:                 .Top           = 244
880:                 .Left          = 743
881:                 .Width         = 54
882:                 .Height        = 24
883:                 .FontName      = "Tahoma"
884:                 .FontSize      = 8
885:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 895 a 904:
895:             loc_oPagina.AddObject("txt_4c_DNvl2", "TextBox")
896:             WITH loc_oPagina.txt_4c_DNvl2
897:                 .Value         = ""
898:                 .Top           = 244
899:                 .Left          = 799
900:                 .Width         = 174
901:                 .Height        = 24
902:                 .FontName      = "Tahoma"
903:                 .FontSize      = 8
904:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 911 a 923:
911:             ENDWITH
912: 
913:             *-- Label5 "Terceiro Nivel :"  Original: Top=248 -> Compensado: Top=277
914:             loc_oPagina.AddObject("lbl_4c_Label5", "Label")
915:             WITH loc_oPagina.lbl_4c_Label5
916:                 .Caption   = "Terceiro N" + CHR(237) + "vel :"
917:                 .Top       = 277
918:                 .Left      = 665
919:                 .Width     = 74
920:                 .Height    = 15
921:                 .FontName  = "Tahoma"
922:                 .FontSize  = 8
923:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 929 a 938:
929:             loc_oPagina.AddObject("txt_4c_Nvl3", "TextBox")
930:             WITH loc_oPagina.txt_4c_Nvl3
931:                 .Value         = ""
932:                 .Top           = 272
933:                 .Left          = 743
934:                 .Width         = 54
935:                 .Height        = 24
936:                 .FontName      = "Tahoma"
937:                 .FontSize      = 8
938:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 948 a 957:
948:             loc_oPagina.AddObject("txt_4c_DNvl3", "TextBox")
949:             WITH loc_oPagina.txt_4c_DNvl3
950:                 .Value         = ""
951:                 .Top           = 272
952:                 .Left          = 799
953:                 .Width         = 174
954:                 .Height        = 24
955:                 .FontName      = "Tahoma"
956:                 .FontSize      = 8
957:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 964 a 976:
964:             ENDWITH
965: 
966:             *-- Label3 "Quarto Nivel :"  Original: Top=276 -> Compensado: Top=305
967:             loc_oPagina.AddObject("lbl_4c_Label3", "Label")
968:             WITH loc_oPagina.lbl_4c_Label3
969:                 .Caption   = "Quarto N" + CHR(237) + "vel :"
970:                 .Top       = 305
971:                 .Left      = 670
972:                 .Width     = 69
973:                 .Height    = 15
974:                 .FontName  = "Tahoma"
975:                 .FontSize  = 8
976:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 982 a 991:
982:             loc_oPagina.AddObject("txt_4c_Nvl4", "TextBox")
983:             WITH loc_oPagina.txt_4c_Nvl4
984:                 .Value         = ""
985:                 .Top           = 300
986:                 .Left          = 743
987:                 .Width         = 54
988:                 .Height        = 24
989:                 .FontName      = "Tahoma"
990:                 .FontSize      = 8
991:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1001 a 1010:
1001:             loc_oPagina.AddObject("txt_4c_DNvl4", "TextBox")
1002:             WITH loc_oPagina.txt_4c_DNvl4
1003:                 .Value         = ""
1004:                 .Top           = 300
1005:                 .Left          = 799
1006:                 .Width         = 174
1007:                 .Height        = 24
1008:                 .FontName      = "Tahoma"
1009:                 .FontSize      = 8
1010:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1059 a 1073:
1059:                     loc_oGrid.Column6.Width = 200
1060:                     loc_oGrid.Column7.Width = 60
1061: 
1062:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1063:                     loc_oGrid.Column2.Header1.Caption = "Data"
1064:                     loc_oGrid.Column3.Header1.Caption = "Vendedor"
1065:                     loc_oGrid.Column4.Header1.Caption = "Nome Vendedor"
1066:                     loc_oGrid.Column5.Header1.Caption = "Local"
1067:                     loc_oGrid.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Local"
1068:                     loc_oGrid.Column7.Header1.Caption = "Conferido"
1069: 
1070:                     THIS.FormatarGridLista(loc_oGrid)
1071:                     loc_lResultado = .T.
1072:                 ENDIF
1073:             ENDIF

*-- Linhas 1180 a 1190:
1180:                 loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1181:                 loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1182:                 loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1183:                 loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1184:                 loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1185:                 loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1186:                 loc_oPg2.grd_4c_GrdLoc.Refresh()
1187:             ENDIF
1188: 
1189:             THIS.HabilitarCampos(.T.)
1190:             THIS.AlternarPagina(2)

*-- Linhas 1510 a 1520:
1510:                         loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1511:                         loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1512:                         loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1513:                         loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1514:                         loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1515:                         loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1516:                         loc_oPg2.grd_4c_GrdLoc.Refresh()
1517:                     ENDIF
1518:                 ENDIF
1519:             ENDIF
1520: 

*-- Linhas 1915 a 1947:
1915:             loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
1916: 
1917:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1918:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1919:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = loc_lEmLista
1920:                 ENDIF
1921:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1922:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1923:                 ENDIF
1924:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1925:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = loc_lEmLista
1926:                 ENDIF
1927:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1928:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = loc_lEmLista
1929:                 ENDIF
1930:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1931:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = loc_lEmLista
1932:                 ENDIF
1933:             ENDIF
1934: 
1935:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Espelho", 5)
1936:                 loc_oPg1.cmd_4c_Espelho.Enabled = loc_lEmLista
1937:             ENDIF
1938:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Fechar", 5)
1939:                 loc_oPg1.cmd_4c_Fechar.Enabled  = loc_lEmLista
1940:             ENDIF
1941:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Abrir", 5)
1942:                 loc_oPg1.cmd_4c_Abrir.Enabled   = loc_lEmLista
1943:             ENDIF
1944: 
1945:         CATCH TO loc_oErro
1946:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1947:         ENDTRY


### BO (C:\4c\projeto\app\classes\cnlBO.prg):
*===========================================================================
* cnlBO.prg - Business Object para Contagem de Produtos por Localizacao
* Tabela principal: SigCdCnL (cabecalho da contagem)
* Tabela detalhe  : SigCdCnI (itens / localizacoes)
* Criado em: 2026-07-29
*===========================================================================

DEFINE CLASS cnlBO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela     = "SigCdCnL"
    this_cCampoChave = "Cods"

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCnL (schema: sigcdcnl)
    *--------------------------------------------------------------------------

    *-- Chave de negocio (cods char 10) - usada em WHERE das operacoes
    this_cCodigo     = ""

    *-- Chave tecnica interna (cidchaves char 20) - PK fisica
    this_cCidChaves  = ""

    *-- Empresa (emps char 3)
    this_cEmps       = ""

    *-- Vendedor responsavel (vends char 10 - FK SigCdCli.Iclis)
    this_cVends      = ""

    *-- Localizacao principal (locals char 10 - FK SigPrLcl.codigos)
    this_cLocals     = ""

    *-- Data da contagem (datas datetime)
    this_dDatas      = {}

    *-- Ordenacao do grid (qtds numeric 5,0): 0/1=Base, 2=Nvl2, 3=Nvl3, 4=Nvl4
    this_nQtds       = 0

    *-- Status (conferido numeric 1,0): 0=aberta, 1=encerrada
    this_nConferido  = 0

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (resultado de JOINs na query Buscar)
    *--------------------------------------------------------------------------

    *-- Descricao do vendedor (alias desvends = SigCdCli.Rclis)
    this_cDesVends   = ""

    *-- Descricao da localizacao (alias dlocals = SigPrLcl.descricaos)
    this_cDLocals    = ""

    *--------------------------------------------------------------------------
    * Nomes dos cursores de trabalho
    *--------------------------------------------------------------------------

    *-- Cursor de itens criado pelo form (csSigCdCnI)
    this_cCursorItens = "csSigCdCnI"

    *-- Cursor principal da lista (Buscar)
    this_cCursorDados = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnL"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega lista de contagens com JOINs
    * par_cFiltro: condicao SQL adicional (opcional)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.datas DESC, a.cods"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de contagens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro de SigCdCnL pelo Cods
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND a.emps = " + EscaparSQL(loc_cEmpresa)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor posicionado
    * REGRA: SEMPRE SELECT (alias) antes de acessar campos
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(cods,       "C")
            THIS.this_nConferido  = TratarNulo(conferido,  "N")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cLocals     = TratarNulo(locals,     "C")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")
            THIS.this_cVends      = TratarNulo(vends,      "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cDesVends   = TratarNulo(desvends,   "C")
            THIS.this_cDLocals    = TratarNulo(dlocals,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigCdCnL (chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_cCodigo
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = THIS.ObterNovoCidChaves()
            IF !EMPTY(loc_cCidChaves)
                loc_cCodigo = THIS.ObterProximoCodigo()
                IF !EMPTY(loc_cCodigo)
                    THIS.this_cCidChaves = loc_cCidChaves
                    THIS.this_cCodigo    = loc_cCodigo
                    THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                    THIS.this_nConferido = 0

                    loc_cSQL = "INSERT INTO sigcdcnl" + ;
                               " (cidchaves, cods, conferido, datas, locals, qtds, vends, emps)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                               FormatarNumeroSQL(THIS.this_nConferido) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(THIS.this_cLocals) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                               EscaparSQL(THIS.this_cVends) + ", " + ;
                               EscaparSQL(THIS.this_cEmps)  + ;
                               ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir contagem: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar chave interna da contagem.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCdCnL (vends, locals, qtds)
    * O legado fazia delete+reinsert via cursor; aqui usamos UPDATE direto.
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET" + ;
                       " vends  = " + EscaparSQL(THIS.this_cVends)  + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " qtds   = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " datas  = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de SigCdCnI (itens) + SigCdCnL (cabecalho)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM sigcdcnl" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                           " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir contagem: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * SalvarItens - Salva itens do cursor csSigCdCnI em SigCdCnI
    * par_cCursorItens: nome do cursor com colunas Locals, QtdCtg, Qtde
    * par_cCodigo: Cods do cabecalho (SigCdCnL.cods)
    * Mapeamento: sigcdcni.qtds <- csSigCdCnI.QtdCtg (contagem)
    *             sigcdcni.estoque <- csSigCdCnI.Qtde (estoque)
    *==========================================================================
    FUNCTION SalvarItens(par_cCursorItens, par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_nResultado
        LOCAL loc_cLocals, loc_nQtdCtg, loc_nQtde
        loc_lSucesso = .F.

        IF !USED(par_cCursorItens)
            MsgErro("Cursor de itens n" + CHR(227) + "o encontrado: " + par_cCursorItens, "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Limpar itens existentes para este codigo
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- Inserir itens do cursor
                SELECT (par_cCursorItens)
                GO TOP
                loc_lSucesso = .T.

                SCAN WHILE loc_lSucesso
                    *-- Capturar campos ANTES de chamar ObterNovoCidChaves (muda SELECT)
                    loc_cLocals  = ALLTRIM(locals)
                    loc_nQtdCtg  = qtdctg
                    loc_nQtde    = qtde

                    loc_cCidChaves = THIS.ObterNovoCidChaves()
                    IF EMPTY(loc_cCidChaves)
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO sigcdcni" + ;
                                   " (cidchaves, cods, locals, qtds, estoque, mercs)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCodigo)    + ", " + ;
                                   EscaparSQL(loc_cLocals)    + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdCtg) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtde)   + ", " + ;
                                   EscaparSQL("") + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir item [" + loc_cLocals + "]: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF

                    *-- Restaurar selecao para proxima iteracao do SCAN
                    SELECT (par_cCursorItens)
                ENDSCAN
            ELSE
                MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SalvarItens: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega itens de SigCdCnI para um cursor
    * par_cCodigo: Cods do cabecalho
    * par_cCursorDestino: nome do cursor destino (default: crSigCdCnI)
    *==========================================================================
    FUNCTION CarregarItens(par_cCodigo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "crSigCdCnI", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cods, locals, qtds, estoque, mercs" + ;
                       " FROM sigcdcni" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY locals"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FecharContagem - Define Conferido=1 (encerra a contagem)
    *==========================================================================
    FUNCTION FecharContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 1" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao fechar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FecharContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ReobrirContagem - Define Conferido=0 (reabre a contagem encerrada)
    *==========================================================================
    FUNCTION ReobrirContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 0" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao reabrir contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ReobrirContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametrosVendedor - Carrega SigCdPam para obter GrPadVens
    * Replica CursorQuery([SigCdPam], [LocalPam], ...)
    * par_cCursorDestino: nome do cursor destino (default: cursor_4c_LocalPam)
    *==========================================================================
    FUNCTION CarregarParametrosVendedor(par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_LocalPam", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                IF !EOF()
                    loc_lSucesso = !EMPTY(ALLTRIM(GrPadVens))
                ENDIF
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros de vendedor: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarParametrosVendedor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarVendedores - Carrega vendedores validos para lookup
    * Replica a query dos eventos Valid de getConta/getDConta
    * par_cFiltro    : usuario logado ou valor digitado no campo
    * par_cGrPadVens : grupo padrao de vendedores (de SigCdPam)
    * par_cCursorDestino: cursor de resultado (default: cursor_4c_Vendedores)
    *==========================================================================
    FUNCTION BuscarVendedores(par_cFiltro, par_cGrPadVens, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Vendedores", par_cCursorDestino)
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs," + ;
                       " a.inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
                       " AND a.IClis NOT IN" + ;
                       " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
                       " WHERE c.Jobs NOT IN" + ;
                       " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
                       " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                       " ORDER BY a.iclis"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar vendedores: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarVendedores: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoesNivel - Carrega SigLcNv1/2/3/4 para cursor local
    * par_nNivel: 1, 2, 3 ou 4
    * par_cCursorDestino: cursor destino (ex: "csNivel1")
    *==========================================================================
    FUNCTION CarregarLocalizacoesNivel(par_nNivel, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cTabela, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "csNivel" + LTRIM(STR(par_nNivel)), par_cCursorDestino)

        TRY
            DO CASE
            CASE par_nNivel = 1
                loc_cTabela = "SigLcNv1"
            CASE par_nNivel = 2
                loc_cTabela = "SigLcNv2"
            CASE par_nNivel = 3
                loc_cTabela = "SigLcNv3"
            CASE par_nNivel = 4
                loc_cTabela = "SigLcNv4"
            OTHERWISE
                MsgErro("N" + CHR(237) + "vel inv" + CHR(225) + "lido: " + ;
                        LTRIM(STR(par_nNivel)), "Erro")
                loc_lSucesso = .F.
            ENDCASE

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT * FROM " + loc_cTabela

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar " + loc_cTabela + ": " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLocalizacoesNivel: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterNovoCidChaves - Gera novo cidchaves unico (char 20) via NEWID()
    *==========================================================================
    PROTECTED FUNCTION ObterNovoCidChaves()
        LOCAL loc_cChave, loc_lSucesso
        loc_cChave   = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36), NEWID()),'-',''), 20) AS nova_chave", ;
                "cursor_4c_NovaChave") > 0
            IF loc_lSucesso
                SELECT cursor_4c_NovaChave
                loc_cChave = ALLTRIM(nova_chave)
            ELSE
                MsgErro("Erro ao gerar chave interna: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterNovoCidChaves: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_NovaChave")
            USE IN cursor_4c_NovaChave
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * ObterProximoCodigo - Gera proximo Cods numerico disponivel em SigCdCnL
    *==========================================================================
    PROTECTED FUNCTION ObterProximoCodigo()
        LOCAL loc_cCodigo, loc_lSucesso
        loc_cCodigo  = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(CAST(cods AS bigint)), 0) + 1 AS proximo FROM sigcdcnl", ;
                "cursor_4c_ProxCod") > 0
            IF loc_lSucesso
                SELECT cursor_4c_ProxCod
                loc_cCodigo = ALLTRIM(STR(cursor_4c_ProxCod.proximo, 10))
            ELSE
                MsgErro("Erro ao obter pr" + CHR(243) + "ximo c" + CHR(243) + "digo: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterProximoCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_cCodigo
    ENDFUNC

ENDDEFINE

