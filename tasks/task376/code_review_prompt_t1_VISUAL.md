# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 268: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 293: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 318: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 356: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 504: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 529: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcnl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1970 linhas total):

*-- Linhas 85 a 117:
85: 
86:     *==========================================================================
87:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista + Dados)
88:     * PageFrame.Top = -29 oculta as abas (Tabs=.F.)
89:     * Todos os controles nas Pages precisam compensar +29 no Top
90:     *==========================================================================
91:     PROTECTED PROCEDURE ConfigurarPageFrame()
92:         LOCAL loc_oErro
93: 
94:         TRY
95:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
96: 
97:             WITH THIS.pgf_4c_Paginas
98:                 .Top       = -29
99:                 .Left      = 0
100:                 .Width     = 1000
101:                 .Height    = 629
102:                 .PageCount = 2
103:                 .Tabs      = .F.
104:                 .Visible   = .T.
105: 
106:                 *-- Page1: Lista de contagens
107:                 .Page1.Caption   = "Lista"
108:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:                 .Page1.BackColor = RGB(100, 100, 100)
110: 
111:                 *-- Page2: Dados da contagem (cabecalho + itens)
112:                 .Page2.Caption   = "Dados"
113:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:                 .Page2.BackColor = RGB(100, 100, 100)
115:             ENDWITH
116: 
117:             *-- Imagens de fundo das paginas

*-- Linhas 131 a 139:
131:     *==========================================================================
132:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD,
133:     *   botoes especiais (Espelho/Fechar/Abrir) e grid de listagem
134:     * TOPS compensados (+29 por PageFrame.Top=-29)
135:     *==========================================================================
136:     PROTECTED PROCEDURE ConfigurarPaginaLista()
137:         LOCAL loc_oPagina, loc_oErro
138:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
139: 

*-- Linhas 147 a 186:
147:             *--------------------------------------------------------------
148:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
149:             WITH loc_oPagina.cnt_4c_Cabecalho
150:                 .Top         = 31
151:                 .Left        = 0
152:                 .Width       = THIS.Width
153:                 .Height      = 80
154:                 .BackColor   = RGB(100, 100, 100)
155:                 .BorderWidth = 0
156:                 .Visible     = .T.
157:             ENDWITH
158: 
159:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
160:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
161:                 .Top       = 15
162:                 .Left      = 10
163:                 .Width     = 769
164:                 .Height    = 40
165:                 .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
166:                 .FontName  = "Tahoma"
167:                 .FontSize  = 16
168:                 .FontBold  = .T.
169:                 .ForeColor = RGB(0, 0, 0)
170:                 .BackStyle = 0
171:                 .AutoSize  = .F.
172:                 .Visible   = .T.
173:             ENDWITH
174: 
175:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
176:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
177:                 .Top       = 18
178:                 .Left      = 10
179:                 .Width     = 769
180:                 .Height    = 46
181:                 .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
182:                 .FontName  = "Tahoma"
183:                 .FontSize  = 16
184:                 .FontBold  = .T.
185:                 .ForeColor = RGB(255, 255, 255)
186:                 .BackStyle = 0

*-- Linhas 194 a 444:
194:             *--------------------------------------------------------------
195:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
196:             WITH loc_oPagina.cnt_4c_Botoes
197:                 .Top         = 29
198:                 .Left        = 542
199:                 .Width       = 390
200:                 .Height      = 85
201:                 .BackStyle = 0
202:                 .BorderWidth = 0
203:                 .Visible     = .T.
204:             ENDWITH
205: 
206:             *-- Incluir
207:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
208:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
209:                 .Caption         = "Incluir"
210:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
211:                 .PicturePosition = 13
212:                 .Top             = 5
213:                 .Left            = 5
214:                 .Width           = 75
215:                 .Height          = 75
216:                 .BackColor       = RGB(255, 255, 255)
217:                 .ForeColor       = RGB(90, 90, 90)
218:                 .FontName        = "Comic Sans MS"
219:                 .FontBold        = .T.
220:                 .FontItalic      = .T.
221:                 .FontSize        = 8
222:                 .Themes          = .F.
223:                 .SpecialEffect   = 0
224:                 .MousePointer    = 15
225:                 .WordWrap        = .T.
226:                 .AutoSize        = .F.
227:                 .Visible         = .T.
228:             ENDWITH
229:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
230: 
231:             *-- Visualizar
232:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
233:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
234:                 .Caption         = "Visualizar"
235:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
236:                 .PicturePosition = 13
237:                 .Top             = 5
238:                 .Left            = 80
239:                 .Width           = 75
240:                 .Height          = 75
241:                 .BackColor       = RGB(255, 255, 255)
242:                 .ForeColor       = RGB(90, 90, 90)
243:                 .FontName        = "Comic Sans MS"
244:                 .FontBold        = .T.
245:                 .FontItalic      = .T.
246:                 .FontSize        = 8
247:                 .Themes          = .F.
248:                 .SpecialEffect   = 0
249:                 .MousePointer    = 15
250:                 .WordWrap        = .T.
251:                 .AutoSize        = .F.
252:                 .Visible         = .T.
253:             ENDWITH
254:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
255: 
256:             *-- Alterar
257:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
258:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
259:                 .Caption         = "Alterar"
260:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
261:                 .PicturePosition = 13
262:                 .Top             = 5
263:                 .Left            = 155
264:                 .Width           = 75
265:                 .Height          = 75
266:                 .BackColor       = RGB(255, 255, 255)
267:                 .ForeColor       = RGB(90, 90, 90)
268:                 .FontName        = "Comic Sans MS"
269:                 .FontBold        = .T.
270:                 .FontItalic      = .T.
271:                 .FontSize        = 8
272:                 .Themes          = .F.
273:                 .SpecialEffect   = 0
274:                 .MousePointer    = 15
275:                 .WordWrap        = .T.
276:                 .AutoSize        = .F.
277:                 .Visible         = .T.
278:             ENDWITH
279:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
280: 
281:             *-- Excluir
282:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
283:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
284:                 .Caption         = "Excluir"
285:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
286:                 .PicturePosition = 13
287:                 .Top             = 5
288:                 .Left            = 230
289:                 .Width           = 75
290:                 .Height          = 75
291:                 .BackColor       = RGB(255, 255, 255)
292:                 .ForeColor       = RGB(90, 90, 90)
293:                 .FontName        = "Comic Sans MS"
294:                 .FontBold        = .T.
295:                 .FontItalic      = .T.
296:                 .FontSize        = 8
297:                 .Themes          = .F.
298:                 .SpecialEffect   = 0
299:                 .MousePointer    = 15
300:                 .WordWrap        = .T.
301:                 .AutoSize        = .F.
302:                 .Visible         = .T.
303:             ENDWITH
304:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
305: 
306:             *-- Buscar
307:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
308:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
309:                 .Caption         = "Buscar"
310:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
311:                 .PicturePosition = 13
312:                 .Top             = 5
313:                 .Left            = 305
314:                 .Width           = 75
315:                 .Height          = 75
316:                 .BackColor       = RGB(255, 255, 255)
317:                 .ForeColor       = RGB(90, 90, 90)
318:                 .FontName        = "Comic Sans MS"
319:                 .FontBold        = .T.
320:                 .FontItalic      = .T.
321:                 .FontSize        = 8
322:                 .Themes          = .F.
323:                 .SpecialEffect   = 0
324:                 .MousePointer    = 15
325:                 .WordWrap        = .T.
326:                 .AutoSize        = .F.
327:                 .Visible         = .T.
328:             ENDWITH
329:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
330: 
331:             *--------------------------------------------------------------
332:             * Container Saida - padrao canonico (PREVALECE SOBRE PILAR 1)
333:             *--------------------------------------------------------------
334:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
335:             WITH loc_oPagina.cnt_4c_Saida
336:                 .Top         = 29
337:                 .Left        = 917
338:                 .Width       = 90
339:                 .Height      = 85
340:                 .BackStyle   = 0
341:                 .BorderWidth = 0
342:                 .Visible     = .T.
343:             ENDWITH
344: 
345:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
346:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
347:                 .Caption         = "Encerrar"
348:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
349:                 .PicturePosition = 13
350:                 .Top             = 5
351:                 .Left            = 5
352:                 .Width           = 75
353:                 .Height          = 75
354:                 .BackColor       = RGB(255, 255, 255)
355:                 .ForeColor       = RGB(90, 90, 90)
356:                 .FontName        = "Comic Sans MS"
357:                 .FontBold        = .T.
358:                 .FontItalic      = .T.
359:                 .FontSize        = 8
360:                 .Themes          = .F.
361:                 .SpecialEffect   = 0
362:                 .MousePointer    = 15
363:                 .WordWrap        = .T.
364:                 .AutoSize        = .F.
365:                 .Visible         = .T.
366:             ENDWITH
367:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
368: 
369:             *--------------------------------------------------------------
370:             * Botoes especiais do legado: Espelho / Fechar / Abrir
371:             * Original: Top=82 -> Compensado: Top=111
372:             * Posicoes: Left=14, 119, 224 (direto na Page1)
373:             *--------------------------------------------------------------
374:             loc_oPagina.AddObject("cmd_4c_Espelho", "CommandButton")
375:             WITH loc_oPagina.cmd_4c_Espelho
376:                 .Caption       = "Espelho"
377:                 .Top           = 111
378:                 .Left          = 14
379:                 .Width         = 105
380:                 .Height        = 40
381:                 .BackColor     = RGB(200, 200, 200)
382:                 .ForeColor     = RGB(90, 90, 90)
383:                 .FontName      = "Tahoma"
384:                 .FontSize      = 8
385:                 .FontBold      = .F.
386:                 .Themes        = .F.
387:                 .SpecialEffect = 0
388:                 .Visible       = .T.
389:             ENDWITH
390:             BINDEVENT(loc_oPagina.cmd_4c_Espelho, "Click", THIS, "BtnEspelhoClick")
391: 
392:             loc_oPagina.AddObject("cmd_4c_Fechar", "CommandButton")
393:             WITH loc_oPagina.cmd_4c_Fechar
394:                 .Caption       = "Encerrar"
395:                 .Top           = 111
396:                 .Left          = 119
397:                 .Width         = 75
398:                 .Height        = 75
399:                 .BackColor     = RGB(200, 200, 200)
400:                 .ForeColor     = RGB(90, 90, 90)
401:                 .FontName      = "Tahoma"
402:                 .FontSize      = 8
403:                 .FontBold      = .F.
404:                 .Themes        = .F.
405:                 .SpecialEffect = 0
406:                 .Visible       = .T.
407:             ENDWITH
408:             BINDEVENT(loc_oPagina.cmd_4c_Fechar, "Click", THIS, "BtnFecharContagemClick")
409: 
410:             loc_oPagina.AddObject("cmd_4c_Abrir", "CommandButton")
411:             WITH loc_oPagina.cmd_4c_Abrir
412:                 .Caption       = "Abrir"
413:                 .Top           = 111
414:                 .Left          = 224
415:                 .Width         = 105
416:                 .Height        = 40
417:                 .BackColor     = RGB(200, 200, 200)
418:                 .ForeColor     = RGB(90, 90, 90)
419:                 .FontName      = "Tahoma"
420:                 .FontSize      = 8
421:                 .FontBold      = .F.
422:                 .Themes        = .F.
423:                 .SpecialEffect = 0
424:                 .Visible       = .T.
425:             ENDWITH
426:             BINDEVENT(loc_oPagina.cmd_4c_Abrir, "Click", THIS, "BtnAbrirContagemClick")
427: 
428:             *--------------------------------------------------------------
429:             * Grid de listagem de contagens
430:             * Abaixo dos botoes especiais: 111+40+4=155 -> Top=155
431:             * Width=900 para nao sobrepor cnt_4c_Saida (Left=917)
432:             *--------------------------------------------------------------
433:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
434:             loc_oPagina.grd_4c_Dados.RecordSource = ""
435:             loc_oPagina.grd_4c_Dados.ColumnCount  = 7
436: 
437:             WITH loc_oPagina.grd_4c_Dados
438:                 .Top                = 155
439:                 .Left               = 12
440:                 .Width              = 900
441:                 .Height             = 440
442:                 .FontName           = "Verdana"
443:                 .FontSize           = 8
444:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 465 a 473:
465: 
466:     *==========================================================================
467:     * ConfigurarPaginaDados - Configura Page2: botoes, campos cabecalho (Fase 5)
468:     * TOPS compensados (+29 por PageFrame.Top=-29)
469:     *==========================================================================
470:     PROTECTED PROCEDURE ConfigurarPaginaDados()
471:         LOCAL loc_oPagina, loc_oErro
472:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
473: 

*-- Linhas 481 a 585:
481:             *--------------------------------------------------------------
482:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
483:             WITH loc_oPagina.cnt_4c_BotoesAcao
484:                 .Top         = 33
485:                 .Left        = 842
486:                 .Width       = 160
487:                 .Height      = 85
488:                 .BackStyle   = 0
489:                 .Visible     = .T.
490:             ENDWITH
491: 
492:             *-- Confirmar (Salvar)
493:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
494:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
495:                 .Caption         = "Confirmar"
496:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
497:                 .PicturePosition = 13
498:                 .Top             = 5
499:                 .Left            = 5
500:                 .Width           = 75
501:                 .Height          = 75
502:                 .BackColor       = RGB(255, 255, 255)
503:                 .ForeColor       = RGB(90, 90, 90)
504:                 .FontName        = "Comic Sans MS"
505:                 .FontBold        = .T.
506:                 .FontItalic      = .T.
507:                 .FontSize        = 8
508:                 .Themes          = .F.
509:                 .SpecialEffect   = 0
510:                 .MousePointer    = 15
511:                 .WordWrap        = .T.
512:                 .AutoSize        = .F.
513:                 .Visible         = .T.
514:             ENDWITH
515:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
516: 
517:             *-- Cancelar
518:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
519:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
520:                 .Caption         = "Encerrar"
521:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
522:                 .PicturePosition = 13
523:                 .Top             = 5
524:                 .Left            = 80
525:                 .Width           = 75
526:                 .Height          = 75
527:                 .BackColor       = RGB(255, 255, 255)
528:                 .ForeColor       = RGB(90, 90, 90)
529:                 .FontName        = "Comic Sans MS"
530:                 .FontBold        = .T.
531:                 .FontItalic      = .T.
532:                 .FontSize        = 8
533:                 .Themes          = .F.
534:                 .SpecialEffect   = 0
535:                 .MousePointer    = 15
536:                 .WordWrap        = .T.
537:                 .AutoSize        = .F.
538:                 .Visible         = .T.
539:             ENDWITH
540:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
541: 
542:             *--------------------------------------------------------------
543:             * Shape1 - elemento visual decorativo da area de niveis
544:             * Original: Top=169, Left=626 -> Compensado: Top=198
545:             *--------------------------------------------------------------
546:             loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
547:             WITH loc_oPagina.shp_4c_Shape1
548:                 .Top         = 198
549:                 .Left        = 626
550:                 .Width       = 364
551:                 .Height      = 144
552:                 .BackStyle   = 0
553:                 .BorderWidth = 1
554:                 .BorderColor = RGB(128, 128, 128)
555:                 .Visible     = .T.
556:             ENDWITH
557: 
558:             *--------------------------------------------------------------
559:             * Label4 "Codigo :" + txt_4c_Codigo (getCods - somente leitura)
560:             * Original: Label4.Top=99, getCods.Top=94 -> Compensados: +29
561:             *--------------------------------------------------------------
562:             loc_oPagina.AddObject("lbl_4c_Label4", "Label")
563:             WITH loc_oPagina.lbl_4c_Label4
564:                 .Caption   = "C" + CHR(243) + "digo : "
565:                 .Top       = 128
566:                 .Left      = 301
567:                 .Width     = 45
568:                 .Height    = 15
569:                 .FontName  = "Tahoma"
570:                 .FontSize  = 8
571:                 .ForeColor = RGB(90, 90, 90)
572:                 .BackStyle = 0
573:                 .Visible   = .T.
574:             ENDWITH
575: 
576:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
577:             WITH loc_oPagina.txt_4c_Codigo
578:                 .Value         = ""
579:                 .Top           = 123
580:                 .Left          = 349
581:                 .Width         = 80
582:                 .Height        = 24
583:                 .FontName      = "Tahoma"
584:                 .FontSize      = 8
585:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 593 a 623:
593: 
594:             *--------------------------------------------------------------
595:             * Label2 "Vendedor :" + txt_4c_Conta (getConta) + txt_4c_DConta
596:             * Original: Label2.Top=127, getConta.Top=122, getDConta.Top=122 -> +29
597:             * getConta: habilitado apenas em INSERIR (When = INSERIR ou CONSULTAR)
598:             * getDConta: descricao do vendedor - somente leitura
599:             *--------------------------------------------------------------
600:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
601:             WITH loc_oPagina.lbl_4c_Label2
602:                 .Caption   = "Vendedor : "
603:                 .Top       = 156
604:                 .Left      = 288
605:                 .Width     = 58
606:                 .Height    = 15
607:                 .FontName  = "Tahoma"
608:                 .FontSize  = 8
609:                 .ForeColor = RGB(90, 90, 90)
610:                 .BackStyle = 0
611:                 .Visible   = .T.
612:             ENDWITH
613: 
614:             loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
615:             WITH loc_oPagina.txt_4c_Conta
616:                 .Value         = ""
617:                 .Top           = 151
618:                 .Left          = 349
619:                 .Width         = 80
620:                 .Height        = 24
621:                 .FontName      = "Tahoma"
622:                 .FontSize      = 8
623:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 634 a 643:
634:             loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
635:             WITH loc_oPagina.txt_4c_DConta
636:                 .Value         = ""
637:                 .Top           = 151
638:                 .Left          = 431
639:                 .Width         = 290
640:                 .Height        = 24
641:                 .FontName      = "Tahoma"
642:                 .FontSize      = 8
643:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 651 a 728:
651: 
652:             *--------------------------------------------------------------
653:             * Label9 "Ordenacao :" + opt_4c_OptOrdem (4 opcoes)
654:             * Original: Label9.Top=150, OptOrdem.Top=145 -> Compensados: +29
655:             * Opcoes: Local / Nv.2 / Nv.3 / Nv.4  (muda ordem do GrdLoc)
656:             *--------------------------------------------------------------
657:             loc_oPagina.AddObject("lbl_4c_Label9", "Label")
658:             WITH loc_oPagina.lbl_4c_Label9
659:                 .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
660:                 .Top       = 179
661:                 .Left      = 284
662:                 .Width     = 62
663:                 .Height    = 15
664:                 .FontName  = "Tahoma"
665:                 .FontSize  = 8
666:                 .ForeColor = RGB(90, 90, 90)
667:                 .BackStyle = 0
668:                 .Visible   = .T.
669:             ENDWITH
670: 
671:             loc_oPagina.AddObject("opt_4c_OptOrdem", "OptionGroup")
672:             WITH loc_oPagina.opt_4c_OptOrdem
673:                 .ButtonCount = 4
674:                 .Top         = 174
675:                 .Left        = 346
676:                 .Width       = 355
677:                 .Height      = 25
678:                 .BackStyle   = 0
679:                 .BorderStyle = 0
680:                 .Value       = 1
681:                 .Visible     = .T.
682:             ENDWITH
683:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(1)
684:                 .Caption   = "Local"
685:                 .BackStyle = 0
686:                 .Left      = 5
687:                 .Top       = 3
688:                 .Width     = 60
689:                 .AutoSize  = .T.
690:                 .FontName  = "Tahoma"
691:                 .FontSize  = 8
692:                 .ForeColor = RGB(90, 90, 90)
693:                 .Themes    = .F.
694:             ENDWITH
695:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(2)
696:                 .Caption   = "Nv. 2"
697:                 .BackStyle = 0
698:                 .Left      = 90
699:                 .Top       = 3
700:                 .Width     = 60
701:                 .AutoSize  = .T.
702:                 .FontName  = "Tahoma"
703:                 .FontSize  = 8
704:                 .ForeColor = RGB(90, 90, 90)
705:                 .Themes    = .F.
706:             ENDWITH
707:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(3)
708:                 .Caption   = "Nv. 3"
709:                 .BackStyle = 0
710:                 .Left      = 180
711:                 .Top       = 3
712:                 .Width     = 60
713:                 .AutoSize  = .T.
714:                 .FontName  = "Tahoma"
715:                 .FontSize  = 8
716:                 .ForeColor = RGB(90, 90, 90)
717:                 .Themes    = .F.
718:             ENDWITH
719:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(4)
720:                 .Caption   = "Nv. 4"
721:                 .BackStyle = 0
722:                 .Left      = 270
723:                 .Top       = 3
724:                 .Width     = 60
725:                 .AutoSize  = .T.
726:                 .FontName  = "Tahoma"
727:                 .FontSize  = 8
728:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 734 a 746:
734:             * Label1 "Local :" - cabecalho da area do GrdLoc
735:             * Original: Top=172 -> Compensado: Top=201
736:             *--------------------------------------------------------------
737:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
738:             WITH loc_oPagina.lbl_4c_Label1
739:                 .Caption   = "Local : "
740:                 .Top       = 201
741:                 .Left      = 310
742:                 .Width     = 36
743:                 .Height    = 15
744:                 .FontName  = "Tahoma"
745:                 .FontSize  = 8
746:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 758 a 767:
758:             loc_oPagina.grd_4c_GrdLoc.ColumnCount  = 3
759: 
760:             WITH loc_oPagina.grd_4c_GrdLoc
761:                 .Top                = 198
762:                 .Left               = 349
763:                 .Width              = 263
764:                 .Height             = 419
765:                 .FontName           = "Verdana"
766:                 .FontSize           = 8
767:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 780 a 813:
780:             WITH loc_oPagina.grd_4c_GrdLoc.Column1
781:                 .Width    = 80
782:                 .ReadOnly = .T.
783:                 .Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
784:             ENDWITH
785:             WITH loc_oPagina.grd_4c_GrdLoc.Column2
786:                 .Width    = 60
787:                 .ReadOnly = .F.
788:                 .Header1.Caption = "Qtde."
789:             ENDWITH
790:             WITH loc_oPagina.grd_4c_GrdLoc.Column3
791:                 .Width    = 60
792:                 .ReadOnly = .T.
793:                 .Header1.Caption = "Estoque"
794:             ENDWITH
795:             BINDEVENT(loc_oPagina.grd_4c_GrdLoc, "AfterRowColChange", THIS, "GrdLocAfterRowColChange")
796: 
797:             *--------------------------------------------------------------
798:             * Painel direito: codigos e descricoes de cada nivel de localizacao
799:             * Todos dentro da area do Shape1 (Top=198, Left=626, Width=364, Height=144)
800:             * Label7 "Base :" / Label6 "Segundo Nivel :" / Label5 "Terceiro Nivel :" / Label3 "Quarto Nivel :"
801:             *--------------------------------------------------------------
802: 
803:             *-- Label7 "Base :"  Original: Top=192 -> Compensado: Top=221
804:             loc_oPagina.AddObject("lbl_4c_Label7", "Label")
805:             WITH loc_oPagina.lbl_4c_Label7
806:                 .Caption   = "Base :"
807:                 .Top       = 221
808:                 .Left      = 707
809:                 .Width     = 32
810:                 .Height    = 15
811:                 .FontName  = "Tahoma"
812:                 .FontSize  = 8
813:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 819 a 828:
819:             loc_oPagina.AddObject("txt_4c_Base", "TextBox")
820:             WITH loc_oPagina.txt_4c_Base
821:                 .Value         = ""
822:                 .Top           = 216
823:                 .Left          = 743
824:                 .Width         = 54
825:                 .Height        = 24
826:                 .FontName      = "Tahoma"
827:                 .FontSize      = 8
828:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 838 a 847:
838:             loc_oPagina.AddObject("txt_4c_DBase", "TextBox")
839:             WITH loc_oPagina.txt_4c_DBase
840:                 .Value         = ""
841:                 .Top           = 216
842:                 .Left          = 799
843:                 .Width         = 174
844:                 .Height        = 24
845:                 .FontName      = "Tahoma"
846:                 .FontSize      = 8
847:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 854 a 866:
854:             ENDWITH
855: 
856:             *-- Label6 "Segundo Nivel :"  Original: Top=220 -> Compensado: Top=249
857:             loc_oPagina.AddObject("lbl_4c_Label6", "Label")
858:             WITH loc_oPagina.lbl_4c_Label6
859:                 .Caption   = "Segundo N" + CHR(237) + "vel :"
860:                 .Top       = 249
861:                 .Left      = 662
862:                 .Width     = 77
863:                 .Height    = 15
864:                 .FontName  = "Tahoma"
865:                 .FontSize  = 8
866:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 872 a 881:
872:             loc_oPagina.AddObject("txt_4c_Nvl2", "TextBox")
873:             WITH loc_oPagina.txt_4c_Nvl2
874:                 .Value         = ""
875:                 .Top           = 244
876:                 .Left          = 743
877:                 .Width         = 54
878:                 .Height        = 24
879:                 .FontName      = "Tahoma"
880:                 .FontSize      = 8
881:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 891 a 900:
891:             loc_oPagina.AddObject("txt_4c_DNvl2", "TextBox")
892:             WITH loc_oPagina.txt_4c_DNvl2
893:                 .Value         = ""
894:                 .Top           = 244
895:                 .Left          = 799
896:                 .Width         = 174
897:                 .Height        = 24
898:                 .FontName      = "Tahoma"
899:                 .FontSize      = 8
900:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 907 a 919:
907:             ENDWITH
908: 
909:             *-- Label5 "Terceiro Nivel :"  Original: Top=248 -> Compensado: Top=277
910:             loc_oPagina.AddObject("lbl_4c_Label5", "Label")
911:             WITH loc_oPagina.lbl_4c_Label5
912:                 .Caption   = "Terceiro N" + CHR(237) + "vel :"
913:                 .Top       = 277
914:                 .Left      = 665
915:                 .Width     = 74
916:                 .Height    = 15
917:                 .FontName  = "Tahoma"
918:                 .FontSize  = 8
919:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 925 a 934:
925:             loc_oPagina.AddObject("txt_4c_Nvl3", "TextBox")
926:             WITH loc_oPagina.txt_4c_Nvl3
927:                 .Value         = ""
928:                 .Top           = 272
929:                 .Left          = 743
930:                 .Width         = 54
931:                 .Height        = 24
932:                 .FontName      = "Tahoma"
933:                 .FontSize      = 8
934:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 944 a 953:
944:             loc_oPagina.AddObject("txt_4c_DNvl3", "TextBox")
945:             WITH loc_oPagina.txt_4c_DNvl3
946:                 .Value         = ""
947:                 .Top           = 272
948:                 .Left          = 799
949:                 .Width         = 174
950:                 .Height        = 24
951:                 .FontName      = "Tahoma"
952:                 .FontSize      = 8
953:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 960 a 972:
960:             ENDWITH
961: 
962:             *-- Label3 "Quarto Nivel :"  Original: Top=276 -> Compensado: Top=305
963:             loc_oPagina.AddObject("lbl_4c_Label3", "Label")
964:             WITH loc_oPagina.lbl_4c_Label3
965:                 .Caption   = "Quarto N" + CHR(237) + "vel :"
966:                 .Top       = 305
967:                 .Left      = 670
968:                 .Width     = 69
969:                 .Height    = 15
970:                 .FontName  = "Tahoma"
971:                 .FontSize  = 8
972:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 978 a 987:
978:             loc_oPagina.AddObject("txt_4c_Nvl4", "TextBox")
979:             WITH loc_oPagina.txt_4c_Nvl4
980:                 .Value         = ""
981:                 .Top           = 300
982:                 .Left          = 743
983:                 .Width         = 54
984:                 .Height        = 24
985:                 .FontName      = "Tahoma"
986:                 .FontSize      = 8
987:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 997 a 1006:
997:             loc_oPagina.AddObject("txt_4c_DNvl4", "TextBox")
998:             WITH loc_oPagina.txt_4c_DNvl4
999:                 .Value         = ""
1000:                 .Top           = 300
1001:                 .Left          = 799
1002:                 .Width         = 174
1003:                 .Height        = 24
1004:                 .FontName      = "Tahoma"
1005:                 .FontSize      = 8
1006:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1055 a 1069:
1055:                     loc_oGrid.Column6.Width = 200
1056:                     loc_oGrid.Column7.Width = 60
1057: 
1058:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1059:                     loc_oGrid.Column2.Header1.Caption = "Data"
1060:                     loc_oGrid.Column3.Header1.Caption = "Vendedor"
1061:                     loc_oGrid.Column4.Header1.Caption = "Nome Vendedor"
1062:                     loc_oGrid.Column5.Header1.Caption = "Local"
1063:                     loc_oGrid.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Local"
1064:                     loc_oGrid.Column7.Header1.Caption = "Conferido"
1065: 
1066:                     THIS.FormatarGridLista(loc_oGrid)
1067:                     loc_lResultado = .T.
1068:                 ENDIF
1069:             ENDIF

*-- Linhas 1176 a 1186:
1176:                 loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1177:                 loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1178:                 loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1179:                 loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1180:                 loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1181:                 loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1182:                 loc_oPg2.grd_4c_GrdLoc.Refresh()
1183:             ENDIF
1184: 
1185:             THIS.HabilitarCampos(.T.)
1186:             THIS.AlternarPagina(2)

*-- Linhas 1506 a 1516:
1506:                         loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1507:                         loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1508:                         loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1509:                         loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1510:                         loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1511:                         loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1512:                         loc_oPg2.grd_4c_GrdLoc.Refresh()
1513:                     ENDIF
1514:                 ENDIF
1515:             ENDIF
1516: 

*-- Linhas 1911 a 1943:
1911:             loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
1912: 
1913:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1914:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1915:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = loc_lEmLista
1916:                 ENDIF
1917:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1918:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1919:                 ENDIF
1920:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1921:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = loc_lEmLista
1922:                 ENDIF
1923:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1924:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = loc_lEmLista
1925:                 ENDIF
1926:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1927:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = loc_lEmLista
1928:                 ENDIF
1929:             ENDIF
1930: 
1931:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Espelho", 5)
1932:                 loc_oPg1.cmd_4c_Espelho.Enabled = loc_lEmLista
1933:             ENDIF
1934:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Fechar", 5)
1935:                 loc_oPg1.cmd_4c_Fechar.Enabled  = loc_lEmLista
1936:             ENDIF
1937:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Abrir", 5)
1938:                 loc_oPg1.cmd_4c_Abrir.Enabled   = loc_lEmLista
1939:             ENDIF
1940: 
1941:         CATCH TO loc_oErro
1942:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1943:         ENDTRY


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

