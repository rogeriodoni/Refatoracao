# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 272: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 295: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 336: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 715: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 737: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1973 linhas total):

*-- Linhas 63 a 71:
63:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
64:                     MsgErro("Erro ao criar CVEBO!", "Erro")
65:                 ELSE
66:                     THIS.Caption = "Cadastro de Comiss" + CHR(245) + "es de " + ;
67:                                    "Vendedores por Cargos"
68: 
69:                     THIS.ConfigurarPageFrame()
70:                     THIS.pgf_4c_Paginas.Visible = .T.
71:                     THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 97 a 115:
97: 
98:             WITH THIS.pgf_4c_Paginas
99:                 .PageCount = 2
100:                 .Top       = -29
101:                 .Left      = 0
102:                 .Width     = THIS.Width
103:                 .Height    = THIS.Height + 29
104:                 .Tabs      = .F.
105:                 .FontName  = "Tahoma"
106:                 .FontSize  = 8
107:                 .Page1.Caption   = "Lista"
108:                 .Page1.BackColor = RGB(100, 100, 100)
109:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:                 .Page2.Caption   = "Dados"
111:                 .Page2.BackColor = RGB(100, 100, 100)
112:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:                 .Visible = .T.
114:             ENDWITH
115: 

*-- Linhas 139 a 175:
139:             *-- Cabecalho (Top=2+29=31)
140:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
141:             WITH loc_oPagina.cnt_4c_Cabecalho
142:                 .Top         = 31
143:                 .Left        = 0
144:                 .Width       = THIS.Width
145:                 .Height      = 80
146:                 .BackColor   = RGB(100, 100, 100)
147:                 .BorderWidth = 0
148:                 .Visible     = .T.
149: 
150:                 .AddObject("lbl_4c_Sombra", "Label")
151:                 WITH .lbl_4c_Sombra
152:                     .Caption   = loc_cCaption
153:                     .Top       = 15
154:                     .Left      = 10
155:                     .Width     = THIS.Width
156:                     .Height    = 40
157:                     .FontName  = "Tahoma"
158:                     .FontSize  = 16
159:                     .FontBold  = .T.
160:                     .ForeColor = RGB(0, 0, 0)
161:                     .BackStyle = 0
162:                     .AutoSize  = .F.
163:                     .Visible   = .T.
164:                 ENDWITH
165: 
166:                 .AddObject("lbl_4c_Titulo", "Label")
167:                 WITH .lbl_4c_Titulo
168:                     .Caption   = loc_cCaption
169:                     .Top       = 18
170:                     .Left      = 10
171:                     .Width     = THIS.Width
172:                     .Height    = 46
173:                     .FontName  = "Tahoma"
174:                     .FontSize  = 16
175:                     .FontBold  = .T.

*-- Linhas 183 a 301:
183:             *-- Botoes CRUD (Top=0+29=29, Left=542 - lado direito)
184:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
185:             WITH loc_oPagina.cnt_4c_Botoes
186:                 .Top         = 29
187:                 .Left        = 542
188:                 .Width       = 390
189:                 .Height      = 85
190:                 .BackColor   = RGB(53, 53, 53)
191:                 .BackStyle   = 1
192:                 .BorderWidth = 0
193:                 .Visible     = .T.
194: 
195:                 .AddObject("cmd_4c_Incluir", "CommandButton")
196:                 WITH .cmd_4c_Incluir
197:                     .Caption         = "Incluir"
198:                     .Top             = 5
199:                     .Left            =  542
200:                     .Width           = 75
201:                     .Height          = 75
202:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
203:                     .PicturePosition = 13
204:                     .FontName        = "Comic Sans MS"
205:                     .FontSize        = 8
206:                     .FontBold        = .T.
207:                     .FontItalic      = .T.
208:                     .ForeColor       = RGB(90, 90, 90)
209:                     .BackColor       = RGB(255, 255, 255)
210:                     .SpecialEffect   = 0
211:                     .MousePointer    = 15
212:                     .WordWrap        = .T.
213:                     .AutoSize        = .F.
214:                     .Visible         = .T.
215:                 ENDWITH
216: 
217:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
218:                 WITH .cmd_4c_Visualizar
219:                     .Caption         = "Visualizar"
220:                     .Top             = 5
221:                     .Left            =  542
222:                     .Width           = 75
223:                     .Height          = 75
224:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
225:                     .PicturePosition = 13
226:                     .FontName        = "Comic Sans MS"
227:                     .FontSize        = 8
228:                     .FontBold        = .T.
229:                     .FontItalic      = .T.
230:                     .ForeColor       = RGB(90, 90, 90)
231:                     .BackColor       = RGB(255, 255, 255)
232:                     .Themes          = .F.
233:                     .SpecialEffect   = 0
234:                     .MousePointer    = 15
235:                     .WordWrap        = .T.
236:                     .AutoSize        = .F.
237:                     .Visible         = .T.
238:                 ENDWITH
239: 
240:                 .AddObject("cmd_4c_Alterar", "CommandButton")
241:                 WITH .cmd_4c_Alterar
242:                     .Caption         = "Alterar"
243:                     .Top             = 5
244:                     .Left            =  542
245:                     .Width           = 75
246:                     .Height          = 75
247:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
248:                     .PicturePosition = 13
249:                     .FontName        = "Comic Sans MS"
250:                     .FontSize        = 8
251:                     .FontBold        = .T.
252:                     .FontItalic      = .T.
253:                     .ForeColor       = RGB(90, 90, 90)
254:                     .BackColor       = RGB(255, 255, 255)
255:                     .Themes          = .F.
256:                     .SpecialEffect   = 0
257:                     .MousePointer    = 15
258:                     .WordWrap        = .T.
259:                     .AutoSize        = .F.
260:                     .Visible         = .T.
261:                 ENDWITH
262: 
263:                 .AddObject("cmd_4c_Excluir", "CommandButton")
264:                 WITH .cmd_4c_Excluir
265:                     .Caption         = "Excluir"
266:                     .Top             = 5
267:                     .Left            =  542
268:                     .Width           = 75
269:                     .Height          = 75
270:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
271:                     .PicturePosition = 13
272:                     .FontName        = "Comic Sans MS"
273:                     .FontSize        = 8
274:                     .FontBold        = .T.
275:                     .FontItalic      = .T.
276:                     .ForeColor       = RGB(90, 90, 90)
277:                     .BackColor       = RGB(255, 255, 255)
278:                     .Themes          = .F.
279:                     .SpecialEffect   = 0
280:                     .MousePointer    = 15
281:                     .WordWrap        = .T.
282:                     .AutoSize        = .F.
283:                     .Visible         = .T.
284:                 ENDWITH
285: 
286:                 .AddObject("cmd_4c_Buscar", "CommandButton")
287:                 WITH .cmd_4c_Buscar
288:                     .Caption         = "Buscar"
289:                     .Top             = 5
290:                     .Left            =  542
291:                     .Width           = 75
292:                     .Height          = 75
293:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:                     .PicturePosition = 13
295:                     .FontName        = "Comic Sans MS"
296:                     .FontSize        = 8
297:                     .FontBold        = .T.
298:                     .FontItalic      = .T.
299:                     .ForeColor       = RGB(90, 90, 90)
300:                     .BackColor       = RGB(255, 255, 255)
301:                     .Themes          = .F.

*-- Linhas 307 a 413:
307:                 ENDWITH
308:             ENDWITH
309: 
310:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
311:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
312:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
313:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
314:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
315: 
316:             *-- Encerrar - padrao canonico (CLAUDE.md Regra #10)
317:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
318:             WITH loc_oPagina.cnt_4c_Saida
319:                 .Top         = 29
320:                 .Left        = 917
321:                 .Width       = 90
322:                 .Height      = 85
323:                 .BackStyle   = 0
324:                 .BorderWidth = 0
325:                 .Visible     = .T.
326: 
327:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
328:                 WITH .cmd_4c_Encerrar
329:                     .Caption         = "Encerrar"
330:                     .Top             = 5
331:                     .Left            = 917
332:                     .Width           = 90
333:                     .Height          = 75
334:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
335:                     .PicturePosition = 13
336:                     .FontName        = "Comic Sans MS"
337:                     .FontSize        = 8
338:                     .FontBold        = .T.
339:                     .FontItalic      = .T.
340:                     .ForeColor       = RGB(90, 90, 90)
341:                     .BackColor       = RGB(255, 255, 255)
342:                     .SpecialEffect   = 0
343:                     .MousePointer    = 15
344:                     .WordWrap        = .T.
345:                     .AutoSize        = .F.
346:                     .Visible         = .T.
347:                 ENDWITH
348:             ENDWITH
349: 
350:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:             *-- Filtro Periodo (top=119+29=148)
353:             loc_oPagina.AddObject("cnt_4c_Filtro", "Container")
354:             WITH loc_oPagina.cnt_4c_Filtro
355:                 .Top         = 148
356:                 .Left        = 11
357:                 .Width       = 162
358:                 .Height      = 33
359:                 .BackStyle   = 0
360:                 .BorderWidth = 0
361:                 .Visible     = .T.
362: 
363:                 .AddObject("lbl_4c_Periodo", "Label")
364:                 WITH .lbl_4c_Periodo
365:                     .Caption   = "Per" + CHR(237) + "odo :"
366:                     .Top       = 9
367:                     .Left      = 23
368:                     .Width     = 50
369:                     .Height    = 15
370:                     .FontName  = "Tahoma"
371:                     .FontSize  = 8
372:                     .ForeColor = RGB(255, 255, 255)
373:                     .BackStyle = 0
374:                     .Visible   = .T.
375:                 ENDWITH
376: 
377:                 .AddObject("txt_4c_FiltroMess", "TextBox")
378:                 WITH .txt_4c_FiltroMess
379:                     .Value     = PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")
380:                     .Top       = 6
381:                     .Left      = 71
382:                     .Width     = 24
383:                     .Height    = 23
384:                     .InputMask = "99"
385:                     .FontName  = "Tahoma"
386:                     .FontSize  = 8
387:                     .Visible   = .T.
388:                 ENDWITH
389: 
390:                 .AddObject("lbl_4c_Barra", "Label")
391:                 WITH .lbl_4c_Barra
392:                     .Caption   = "/"
393:                     .Top       = 9
394:                     .Left      = 100
395:                     .Width     = 8
396:                     .Height    = 15
397:                     .FontName  = "Tahoma"
398:                     .FontSize  = 8
399:                     .ForeColor = RGB(255, 255, 255)
400:                     .BackStyle = 0
401:                     .Visible   = .T.
402:                 ENDWITH
403: 
404:                 .AddObject("txt_4c_FiltroAnos", "TextBox")
405:                 WITH .txt_4c_FiltroAnos
406:                     .Value     = PADL(ALLTRIM(STR(YEAR(DATE()))), 4, "0")
407:                     .Top       = 6
408:                     .Left      = 113
409:                     .Width     = 38
410:                     .Height    = 23
411:                     .InputMask = "9999"
412:                     .FontName  = "Tahoma"
413:                     .FontSize  = 8

*-- Linhas 419 a 431:
419:             BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos, "KeyPress", THIS, "FiltroAnosLostFocus")
420: 
421:             *-- Botao Copia de Periodo (top=91+29=120, left=347)
422:             loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
423:             WITH loc_oPagina.cmd_4c_Copia
424:                 .Caption       = "C" + CHR(243) + "pia"
425:                 .Top           = 120
426:                 .Left          = 347
427:                 .Width         = 105
428:                 .Height        = 45
429:                 .FontName      = "Tahoma"
430:                 .FontSize      = 8
431:                 .FontBold      = .T.

*-- Linhas 437 a 599:
437:                 .Visible       = .T.
438:             ENDWITH
439: 
440:             BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiarClick")
441: 
442:             *-- Container flutuante Copia de Periodo (top=264+29=293, inicia oculto)
443:             loc_oPagina.AddObject("cnt_4c_Copia", "Container")
444:             WITH loc_oPagina.cnt_4c_Copia
445:                 .Top         = 293
446:                 .Left        = 226
447:                 .Width       = 348
448:                 .Height      = 77
449:                 .BackColor   = RGB(240, 240, 240)
450:                 .BackStyle   = 1
451:                 .BorderWidth = 1
452:                 .Visible     = .F.
453: 
454:                 .AddObject("lbl_4c_TituloCopia", "Label")
455:                 WITH .lbl_4c_TituloCopia
456:                     .Caption   = "C" + CHR(243) + "pia de Per" + CHR(237) + "odo"
457:                     .Top       = 5
458:                     .Left      = 8
459:                     .Width     = 150
460:                     .Height    = 15
461:                     .FontName  = "Tahoma"
462:                     .FontSize  = 8
463:                     .FontBold  = .T.
464:                     .ForeColor = RGB(0, 0, 0)
465:                     .BackStyle = 0
466:                     .Visible   = .T.
467:                 ENDWITH
468: 
469:                 .AddObject("lbl_4c_Origem", "Label")
470:                 WITH .lbl_4c_Origem
471:                     .Caption   = "Per" + CHR(237) + "odo de Origem :"
472:                     .Top       = 27
473:                     .Left      = 28
474:                     .Width     = 97
475:                     .Height    = 15
476:                     .FontName  = "Tahoma"
477:                     .FontSize  = 8
478:                     .ForeColor = RGB(0, 0, 0)
479:                     .BackStyle = 0
480:                     .Visible   = .T.
481:                 ENDWITH
482: 
483:                 .AddObject("txt_4c_OMess", "TextBox")
484:                 WITH .txt_4c_OMess
485:                     .Value     = ""
486:                     .Top       = 24
487:                     .Left      = 128
488:                     .Width     = 24
489:                     .InputMask = "99"
490:                     .FontName  = "Tahoma"
491:                     .FontSize  = 8
492:                     .Visible   = .T.
493:                 ENDWITH
494: 
495:                 .AddObject("lbl_4c_BarraO", "Label")
496:                 WITH .lbl_4c_BarraO
497:                     .Caption   = "/"
498:                     .Top       = 27
499:                     .Left      = 157
500:                     .Width     = 8
501:                     .Height    = 15
502:                     .FontName  = "Tahoma"
503:                     .FontSize  = 8
504:                     .ForeColor = RGB(0, 0, 0)
505:                     .BackStyle = 0
506:                     .Visible   = .T.
507:                 ENDWITH
508: 
509:                 .AddObject("txt_4c_OAnos", "TextBox")
510:                 WITH .txt_4c_OAnos
511:                     .Value     = ""
512:                     .Top       = 24
513:                     .Left      = 166
514:                     .Width     = 38
515:                     .InputMask = "9999"
516:                     .FontName  = "Tahoma"
517:                     .FontSize  = 8
518:                     .Visible   = .T.
519:                 ENDWITH
520: 
521:                 .AddObject("lbl_4c_Destino", "Label")
522:                 WITH .lbl_4c_Destino
523:                     .Caption   = "Per" + CHR(237) + "odo de Destino :"
524:                     .Top       = 52
525:                     .Left      = 26
526:                     .Width     = 99
527:                     .Height    = 15
528:                     .FontName  = "Tahoma"
529:                     .FontSize  = 8
530:                     .ForeColor = RGB(0, 0, 0)
531:                     .BackStyle = 0
532:                     .Visible   = .T.
533:                 ENDWITH
534: 
535:                 .AddObject("txt_4c_DMess", "TextBox")
536:                 WITH .txt_4c_DMess
537:                     .Value     = ""
538:                     .Top       = 48
539:                     .Left      = 128
540:                     .Width     = 24
541:                     .InputMask = "99"
542:                     .FontName  = "Tahoma"
543:                     .FontSize  = 8
544:                     .Visible   = .T.
545:                 ENDWITH
546: 
547:                 .AddObject("lbl_4c_BarraD", "Label")
548:                 WITH .lbl_4c_BarraD
549:                     .Caption   = "/"
550:                     .Top       = 51
551:                     .Left      = 157
552:                     .Width     = 8
553:                     .Height    = 15
554:                     .FontName  = "Tahoma"
555:                     .FontSize  = 8
556:                     .ForeColor = RGB(0, 0, 0)
557:                     .BackStyle = 0
558:                     .Visible   = .T.
559:                 ENDWITH
560: 
561:                 .AddObject("txt_4c_DAnos", "TextBox")
562:                 WITH .txt_4c_DAnos
563:                     .Value     = ""
564:                     .Top       = 48
565:                     .Left      = 166
566:                     .Width     = 38
567:                     .InputMask = "9999"
568:                     .FontName  = "Tahoma"
569:                     .FontSize  = 8
570:                     .Visible   = .T.
571:                 ENDWITH
572: 
573:                 .AddObject("cmd_4c_OkCopia", "CommandButton")
574:                 WITH .cmd_4c_OkCopia
575:                     .Caption      = "Confirmar"
576:                     .Top          = 13
577:                     .Left         = 218
578:                     .Width        = 64
579:                     .Height       = 55
580:                     .FontName     = "Tahoma"
581:                     .FontSize     = 8
582:                     .FontBold     = .T.
583:                     .ForeColor    = RGB(90, 90, 90)
584:                     .BackColor    = RGB(255, 255, 255)
585:                     .Themes       = .T.
586:                     .MousePointer = 15
587:                     .Visible      = .T.
588:                 ENDWITH
589: 
590:                 .AddObject("cmd_4c_CancelarCopia", "CommandButton")
591:                 WITH .cmd_4c_CancelarCopia
592:                     .Caption      = "Encerrar"
593:                     .Top          = 13
594:                     .Left         = 282
595:                     .Width        = 64
596:                     .Height       = 55
597:                     .FontName     = "Tahoma"
598:                     .FontSize     = 8
599:                     .FontBold     = .T.

*-- Linhas 605 a 624:
605:                 ENDWITH
606:             ENDWITH
607: 
608:             BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_OkCopia,       "Click", THIS, "BtnOkCopiaClick")
609:             BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiaClick")
610: 
611:             *-- Grid (top=185, left=11)
612:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
613: 
614:             loc_oGrid             = loc_oPagina.grd_4c_Lista
615:             loc_oGrid.ColumnCount = 8
616: 
617:             WITH loc_oGrid
618:                 .Top                = 185
619:                 .Left               = 11
620:                 .Width              = 895
621:                 .Height             = 390
622:                 .FontName           = "Tahoma"
623:                 .FontSize           = 8
624:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 636 a 675:
636: 
637:                 WITH .Column1
638:                     .Width           = 110
639:                     .Header1.Caption = "Usu" + CHR(225) + "rio"
640:                 ENDWITH
641:                 WITH .Column2
642:                     .Width           = 35
643:                     .Header1.Caption = "M" + CHR(234) + "s"
644:                 ENDWITH
645:                 WITH .Column3
646:                     .Width           = 45
647:                     .Header1.Caption = "Ano"
648:                 ENDWITH
649:                 WITH .Column4
650:                     .Width           = 20
651:                     .Header1.Caption = "V"
652:                 ENDWITH
653:                 WITH .Column5
654:                     .Width           = 160
655:                     .Header1.Caption = "Cargo"
656:                 ENDWITH
657:                 WITH .Column6
658:                     .Width           = 70
659:                     .Alignment       = 2
660:                     .Header1.Caption = "Adicional"
661:                 ENDWITH
662:                 WITH .Column7
663:                     .Width           = 100
664:                     .Alignment       = 2
665:                     .Header1.Caption = "M" + CHR(237) + "nimo"
666:                 ENDWITH
667:                 WITH .Column8
668:                     .Width           = 100
669:                     .Alignment       = 2
670:                     .Header1.Caption = "Experi" + CHR(234) + "ncia"
671:                 ENDWITH
672:             ENDWITH
673: 
674:             THIS.TornarControlesVisiveis(loc_oPagina)
675: 

*-- Linhas 695 a 743:
695:             *-- Botoes Acao: Confirmar e Cancelar
696:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
697:             WITH loc_oPagina.cnt_4c_BotoesAcao
698:                 .Top         = 33
699:                 .Left        = 842
700:                 .Width       = 160
701:                 .Height      = 85
702:                 .BackStyle   = 0
703:                 .BorderWidth = 0
704:                 .Visible     = .T.
705: 
706:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
707:                 WITH .cmd_4c_Confirmar
708:                     .Caption         = "Confirmar"
709:                     .Top             = 5
710:                     .Left            = 5
711:                     .Width           = 75
712:                     .Height          = 75
713:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
714:                     .PicturePosition = 13
715:                     .FontName        = "Comic Sans MS"
716:                     .FontSize        = 8
717:                     .FontBold        = .T.
718:                     .FontItalic      = .T.
719:                     .ForeColor       = RGB(90, 90, 90)
720:                     .BackColor       = RGB(255, 255, 255)
721:                     .SpecialEffect   = 0
722:                     .MousePointer    = 15
723:                     .WordWrap        = .T.
724:                     .AutoSize        = .F.
725:                     .Visible         = .T.
726:                 ENDWITH
727: 
728:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
729:                 WITH .cmd_4c_Cancelar
730:                     .Caption         = "Encerrar"
731:                     .Top             = 5
732:                     .Left            = 80
733:                     .Width           = 75
734:                     .Height          = 75
735:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
736:                     .PicturePosition = 13
737:                     .FontName        = "Comic Sans MS"
738:                     .FontSize        = 8
739:                     .FontBold        = .T.
740:                     .FontItalic      = .T.
741:                     .ForeColor       = RGB(90, 90, 90)
742:                     .BackColor       = RGB(255, 255, 255)
743:                     .Themes          = .F.

*-- Linhas 749 a 765:
749:                 ENDWITH
750:             ENDWITH
751: 
752:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
753:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
754: 
755:             *-- Label: Usu?rio (layout top=179 +29=208)
756:             loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
757:             WITH loc_oPagina.lbl_4c_Usuars
758:                 .Caption   = "Usu" + CHR(225) + "rio :"
759:                 .Top       = 208
760:                 .Left      = 248
761:                 .Width     = 54
762:                 .Height    = 15
763:                 .FontName  = "Tahoma"
764:                 .FontSize  = 8
765:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 772 a 781:
772:             loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
773:             WITH loc_oPagina.txt_4c_Usuars
774:                 .Value     = ""
775:                 .Top       = 205
776:                 .Left      = 311
777:                 .Width     = 80
778:                 .Height    = 23
779:                 .MaxLength = 10
780:                 .FontName  = "Tahoma"
781:                 .FontSize  = 8

*-- Linhas 787 a 799:
787:             BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")
788: 
789:             *-- Label: Per?odo (layout top=204 +29=233)
790:             loc_oPagina.AddObject("lbl_4c_Periodo2", "Label")
791:             WITH loc_oPagina.lbl_4c_Periodo2
792:                 .Caption   = "Per" + CHR(237) + "odo :"
793:                 .Top       = 233
794:                 .Left      = 248
795:                 .Width     = 54
796:                 .Height    = 15
797:                 .FontName  = "Tahoma"
798:                 .FontSize  = 8
799:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 806 a 830:
806:             loc_oPagina.AddObject("txt_4c_Mess", "TextBox")
807:             WITH loc_oPagina.txt_4c_Mess
808:                 .Value     = ""
809:                 .Top       = 230
810:                 .Left      = 311
811:                 .Width     = 24
812:                 .Height    = 23
813:                 .InputMask = "99"
814:                 .MaxLength = 2
815:                 .FontName  = "Tahoma"
816:                 .FontSize  = 8
817:                 .Visible   = .T.
818:             ENDWITH
819: 
820:             *-- Separador "/" entre M?s e Ano (layout top=202 +29=231)
821:             loc_oPagina.AddObject("lbl_4c_BarraMesAno", "Label")
822:             WITH loc_oPagina.lbl_4c_BarraMesAno
823:                 .Caption   = "/"
824:                 .Top       = 231
825:                 .Left      = 340
826:                 .Width     = 8
827:                 .Height    = 15
828:                 .FontName  = "Tahoma"
829:                 .FontSize  = 8
830:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 836 a 860:
836:             loc_oPagina.AddObject("txt_4c_Anos", "TextBox")
837:             WITH loc_oPagina.txt_4c_Anos
838:                 .Value     = ""
839:                 .Top       = 230
840:                 .Left      = 353
841:                 .Width     = 38
842:                 .Height    = 23
843:                 .InputMask = "9999"
844:                 .MaxLength = 4
845:                 .FontName  = "Tahoma"
846:                 .FontSize  = 8
847:                 .Visible   = .T.
848:             ENDWITH
849: 
850:             *-- Label: Vendedor (layout top=229 +29=258)
851:             loc_oPagina.AddObject("lbl_4c_Vendedor", "Label")
852:             WITH loc_oPagina.lbl_4c_Vendedor
853:                 .Caption   = "Vendedor :"
854:                 .Top       = 258
855:                 .Left      = 236
856:                 .Width     = 66
857:                 .Height    = 15
858:                 .FontName  = "Tahoma"
859:                 .FontSize  = 8
860:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 867 a 906:
867:             loc_oPagina.AddObject("txt_4c_Indivs", "TextBox")
868:             WITH loc_oPagina.txt_4c_Indivs
869:                 .Value     = "N"
870:                 .Top       = 255
871:                 .Left      = 311
872:                 .Width     = 17
873:                 .Height    = 23
874:                 .InputMask = "!"
875:                 .MaxLength = 1
876:                 .FontName  = "Tahoma"
877:                 .FontSize  = 8
878:                 .Visible   = .T.
879:             ENDWITH
880: 
881:             *-- Label: (S/N) (layout top=229 +29=258)
882:             loc_oPagina.AddObject("lbl_4c_IndivsSN", "Label")
883:             WITH loc_oPagina.lbl_4c_IndivsSN
884:                 .Caption   = "(S/N)"
885:                 .Top       = 258
886:                 .Left      = 331
887:                 .Width     = 33
888:                 .Height    = 15
889:                 .FontName  = "Tahoma"
890:                 .FontSize  = 8
891:                 .ForeColor = RGB(255, 255, 255)
892:                 .BackStyle = 0
893:                 .Visible   = .T.
894:             ENDWITH
895: 
896:             *-- Label: Cargo (layout top=254 +29=283)
897:             loc_oPagina.AddObject("lbl_4c_Setors", "Label")
898:             WITH loc_oPagina.lbl_4c_Setors
899:                 .Caption   = "Cargo :"
900:                 .Top       = 283
901:                 .Left      = 256
902:                 .Width     = 46
903:                 .Height    = 15
904:                 .FontName  = "Tahoma"
905:                 .FontSize  = 8
906:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 913 a 922:
913:             loc_oPagina.AddObject("txt_4c_Setors", "TextBox")
914:             WITH loc_oPagina.txt_4c_Setors
915:                 .Value     = ""
916:                 .Top       = 280
917:                 .Left      = 311
918:                 .Width     = 80
919:                 .Height    = 23
920:                 .MaxLength = 10
921:                 .FontName  = "Tahoma"
922:                 .FontSize  = 8

*-- Linhas 928 a 940:
928:             BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress", THIS, "ValidarSetors")
929: 
930:             *-- Label: Adicional (layout top=278 +29=307)
931:             loc_oPagina.AddObject("lbl_4c_Adics", "Label")
932:             WITH loc_oPagina.lbl_4c_Adics
933:                 .Caption   = "Adicional :"
934:                 .Top       = 307
935:                 .Left      = 240
936:                 .Width     = 62
937:                 .Height    = 15
938:                 .FontName  = "Tahoma"
939:                 .FontSize  = 8
940:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 947 a 984:
947:             loc_oPagina.AddObject("txt_4c_Adics", "TextBox")
948:             WITH loc_oPagina.txt_4c_Adics
949:                 .Value    = 0.00
950:                 .Top      = 304
951:                 .Left     = 311
952:                 .Width    = 52
953:                 .Height   = 23
954:                 .FontName = "Tahoma"
955:                 .FontSize = 8
956:                 .Visible  = .T.
957:             ENDWITH
958: 
959:             *-- Label: % (layout top=280 +29=309)
960:             loc_oPagina.AddObject("lbl_4c_PctAdics", "Label")
961:             WITH loc_oPagina.lbl_4c_PctAdics
962:                 .Caption   = "%"
963:                 .Top       = 309
964:                 .Left      = 368
965:                 .Width     = 14
966:                 .Height    = 15
967:                 .FontName  = "Tahoma"
968:                 .FontSize  = 8
969:                 .ForeColor = RGB(255, 255, 255)
970:                 .BackStyle = 0
971:                 .Visible   = .T.
972:             ENDWITH
973: 
974:             *-- Label: M?nimo (layout top=303 +29=332)
975:             loc_oPagina.AddObject("lbl_4c_Minimos", "Label")
976:             WITH loc_oPagina.lbl_4c_Minimos
977:                 .Caption   = "M" + CHR(237) + "nimo :"
978:                 .Top       = 332
979:                 .Left      = 251
980:                 .Width     = 51
981:                 .Height    = 15
982:                 .FontName  = "Tahoma"
983:                 .FontSize  = 8
984:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 991 a 1013:
991:             loc_oPagina.AddObject("txt_4c_Minimos", "TextBox")
992:             WITH loc_oPagina.txt_4c_Minimos
993:                 .Value    = 0.00
994:                 .Top      = 329
995:                 .Left     = 311
996:                 .Width    = 101
997:                 .Height   = 23
998:                 .FontName = "Tahoma"
999:                 .FontSize = 8
1000:                 .Visible  = .T.
1001:             ENDWITH
1002: 
1003:             *-- Label: Experi?ncia (layout top=328 +29=357)
1004:             loc_oPagina.AddObject("lbl_4c_MinExps", "Label")
1005:             WITH loc_oPagina.lbl_4c_MinExps
1006:                 .Caption   = "Experi" + CHR(234) + "ncia :"
1007:                 .Top       = 357
1008:                 .Left      = 225
1009:                 .Width     = 77
1010:                 .Height    = 15
1011:                 .FontName  = "Tahoma"
1012:                 .FontSize  = 8
1013:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 1020 a 1029:
1020:             loc_oPagina.AddObject("txt_4c_MinExps", "TextBox")
1021:             WITH loc_oPagina.txt_4c_MinExps
1022:                 .Value    = 0.00
1023:                 .Top      = 354
1024:                 .Left     = 311
1025:                 .Width    = 101
1026:                 .Height   = 23
1027:                 .FontName = "Tahoma"
1028:                 .FontSize = 8
1029:                 .Visible  = .T.

*-- Linhas 1171 a 1186:
1171:                     loc_oGrid.Column7.Width           = 100
1172:                     loc_oGrid.Column8.Width           = 100
1173: 
1174:                     loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1175:                     loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
1176:                     loc_oGrid.Column3.Header1.Caption = "Ano"
1177:                     loc_oGrid.Column4.Header1.Caption = "V"
1178:                     loc_oGrid.Column5.Header1.Caption = "Cargo"
1179:                     loc_oGrid.Column6.Header1.Caption = "Adicional"
1180:                     loc_oGrid.Column7.Header1.Caption = "M" + CHR(237) + "nimo"
1181:                     loc_oGrid.Column8.Header1.Caption = "Experi" + CHR(234) + "ncia"
1182: 
1183:                     loc_oGrid.Column6.Alignment = 2
1184:                     loc_oGrid.Column7.Alignment = 2
1185:                     loc_oGrid.Column8.Alignment = 2
1186: 

*-- Linhas 1404 a 1412:
1404:             loc_oPagina.grd_4c_Lista.Enabled  = .F.
1405:             loc_oPagina.cnt_4c_Botoes.Enabled = .F.
1406:             loc_oPagina.cnt_4c_Saida.Enabled  = .F.
1407:             loc_oPagina.cmd_4c_Copia.Enabled  = .F.
1408: 
1409:             WITH loc_oPagina.cnt_4c_Copia
1410:                 .txt_4c_OMess.Value = ""
1411:                 .txt_4c_OAnos.Value = ""
1412:                 .txt_4c_DMess.Value = ""

*-- Linhas 1534 a 1542:
1534:             loc_oPagina.grd_4c_Lista.Enabled  = .T.
1535:             loc_oPagina.cnt_4c_Botoes.Enabled = .T.
1536:             loc_oPagina.cnt_4c_Saida.Enabled  = .T.
1537:             loc_oPagina.cmd_4c_Copia.Enabled  = .T.
1538: 
1539:             IF USED("crSigCcCmI")
1540:                 loc_oPagina.grd_4c_Lista.SetFocus
1541:             ENDIF
1542:         CATCH TO loc_oErro

*-- Linhas 1581 a 1589:
1581:             loc_oPagina.txt_4c_Minimos.Enabled = par_lHabilitar
1582:             loc_oPagina.txt_4c_MinExps.Enabled = par_lHabilitar
1583:             WITH loc_oPagina.cnt_4c_BotoesAcao
1584:                 .cmd_4c_Confirmar.Enabled = par_lHabilitar
1585:                 .Visible     = .T.
1586:             ENDWITH
1587:         CATCH TO loc_oErro
1588:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1589:         ENDTRY

*-- Linhas 1599 a 1608:
1599:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1600: 
1601:             WITH loc_oPagina.cnt_4c_BotoesAcao
1602:                 .cmd_4c_Confirmar.Enabled = loc_lEditar
1603:                 .cmd_4c_Cancelar.Enabled  = .T.
1604:                 .Visible     = .T.
1605:             ENDWITH
1606:         CATCH TO loc_oErro
1607:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1608:         ENDTRY


### BO (C:\4c\projeto\app\classes\CVEBO.prg):
*==============================================================================
* CVEBO.prg - Business Object para Comissoes de Vendedores por Cargos
* Tabela: SigCcCmI (Comissoes por Cargo - Inidividual)
* Chave:  cidchaves CHAR(20) - PK unica gerada por fUniqueIds()
*==============================================================================

DEFINE CLASS CVEBO AS BusinessBase

	*--------------------------------------------------------------------------
	* Propriedades da entidade (SigCcCmI)
	*--------------------------------------------------------------------------

	*-- PK
	this_cCidchaves  = ""  && cidchaves char(20) - chave prim" + CHR(225) + "ria UUID

	*-- Identificacao do usuario e periodo
	this_cUsuars     = ""  && usuars   char(10) - usu" + CHR(225) + "rio
	this_cMess       = ""  && mess     char(2)  - m" + CHR(234) + "s de refer" + CHR(234) + "ncia (01-12)
	this_cAnos       = ""  && anos     char(4)  - ano de refer" + CHR(234) + "ncia (0001-9999)
	this_cIndivs     = ""  && indivs   char(1)  - vendedor individual (S/N)

	*-- Cargo e supervisor
	this_cSetors     = ""  && setors   char(10) - c" + CHR(243) + "digo do cargo (FK SigCdCrg.CCargs)
	this_cSupervs    = ""  && supervs  char(10) - supervisor do setor

	*-- Valores de comiss" + CHR(227) + "o
	this_nAdics      = 0   && adics    numeric(5,2)  - adicional (%)
	this_nMinimos    = 0   && minimos  numeric(11,2) - valor m" + CHR(237) + "nimo
	this_nMinExps    = 0   && minexps  numeric(11,2) - experi" + CHR(234) + "ncia m" + CHR(237) + "nima

	*==========================================================================
	* Init - Configura tabela e campo-chave
	*==========================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmI"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*==========================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Carrega propriedades a partir de um cursor
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cUsuars    = TratarNulo(usuars,    "C")
				THIS.this_cMess      = TratarNulo(mess,      "C")
				THIS.this_cAnos      = TratarNulo(anos,      "C")
				THIS.this_cIndivs    = TratarNulo(indivs,    "C")
				THIS.this_cSetors    = TratarNulo(setors,    "C")
				THIS.this_cSupervs   = TratarNulo(supervs,   "C")
				THIS.this_nAdics     = TratarNulo(adics,     "N")
				THIS.this_nMinimos   = TratarNulo(minimos,   "N")
				THIS.this_nMinExps   = TratarNulo(minexps,   "N")
				loc_lResultado = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarDoCursor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*==========================================================================
	* Buscar - Retorna registros de SigCcCmI filtrados por periodo
	* par_cFiltro: "MM/AAAA" ou "MM/MMFINAL-AAAA/AAAFINAL" ou "" (todos)
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		LOCAL loc_cMesIni, loc_cMesFin, loc_cAnoIni, loc_cAnoFin
		loc_lSucesso = .F.

		TRY
			*-- Por default filtra pelo mes/ano atual
			loc_cMesIni = SUBSTR(DTOS(DATE()), 5, 2)
			loc_cMesFin = loc_cMesIni
			loc_cAnoIni = SUBSTR(DTOS(DATE()), 1, 4)
			loc_cAnoFin = loc_cAnoIni

			IF !EMPTY(par_cFiltro)
				*-- Aceita filtro no formato "MM/AAAA"
				IF LEN(ALLTRIM(par_cFiltro)) >= 7
					loc_cMesIni = LEFT(ALLTRIM(par_cFiltro), 2)
					loc_cMesFin = loc_cMesIni
					loc_cAnoIni = RIGHT(ALLTRIM(par_cFiltro), 4)
					loc_cAnoFin = loc_cAnoIni
				ENDIF
			ELSE
				*-- Sem filtro: trazer todos
				loc_cMesIni = "01"
				loc_cMesFin = "12"
				loc_cAnoIni = "0001"
				loc_cAnoFin = "9999"
			ENDIF

			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(loc_cMesIni) + ;
			           " AND " + EscaparSQL(loc_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(loc_cAnoIni) + ;
			           " AND " + EscaparSQL(loc_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* BuscarComFiltroPeriodo - Busca com mes/ano de filtro explicitoS
	*==========================================================================
	PROCEDURE BuscarComFiltroPeriodo(par_cMesIni, par_cMesFin, par_cAnoIni, par_cAnoFin)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(par_cMesIni) + ;
			           " AND " + EscaparSQL(par_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(par_cAnoIni) + ;
			           " AND " + EscaparSQL(par_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarComFiltroPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega comissao pela chave primaria (cidchaves)
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ENDIF
				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MsgErro("Erro ao carregar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - Insere novo registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar UUID via SQL Server (fUniqueIds nao portada)
			IF EMPTY(THIS.this_cCidchaves)
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT NEWID() AS NovaChave", ;
				                         "cursor_4c_NovaChave")
				IF loc_nResultado >= 0 AND USED("cursor_4c_NovaChave") AND ;
				   RECCOUNT("cursor_4c_NovaChave") > 0
					THIS.this_cCidchaves = ALLTRIM(cursor_4c_NovaChave.NovaChave)
				ENDIF
				IF USED("cursor_4c_NovaChave")
					USE IN cursor_4c_NovaChave
				ENDIF
				IF EMPTY(THIS.this_cCidchaves)
					MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria!", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCcCmI" + ;
					           " (cidchaves, usuars, mess, anos, indivs," + ;
					           "  setors, supervs, adics, minimos, minexps)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
					           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
					           EscaparSQL(THIS.this_cMess)      + ", " + ;
					           EscaparSQL(THIS.this_cAnos)      + ", " + ;
					           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
					           EscaparSQL(THIS.this_cSetors)    + ", " + ;
					           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ELSE
				loc_cSQL = "INSERT INTO SigCcCmI" + ;
				           " (cidchaves, usuars, mess, anos, indivs," + ;
				           "  setors, supervs, adics, minimos, minexps)" + ;
				           " VALUES (" + ;
				           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
				           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
				           EscaparSQL(THIS.this_cMess)      + ", " + ;
				           EscaparSQL(THIS.this_cAnos)      + ", " + ;
				           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
				           EscaparSQL(THIS.this_cSetors)    + ", " + ;
				           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir: " + loException.Message, "Erro")
			IF USED("cursor_4c_NovaChave")
				USE IN cursor_4c_NovaChave
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - Atualiza registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCcCmI SET" + ;
			           "  usuars  = " + EscaparSQL(THIS.this_cUsuars)            + ", " + ;
			           "  mess    = " + EscaparSQL(THIS.this_cMess)              + ", " + ;
			           "  anos    = " + EscaparSQL(THIS.this_cAnos)              + ", " + ;
			           "  indivs  = " + EscaparSQL(THIS.this_cIndivs)            + ", " + ;
			           "  setors  = " + EscaparSQL(THIS.this_cSetors)            + ", " + ;
			           "  supervs = " + EscaparSQL(THIS.this_cSupervs)           + ", " + ;
			           "  adics   = " + FormatarNumeroSQL(THIS.this_nAdics)      + ", " + ;
			           "  minimos = " + FormatarNumeroSQL(THIS.this_nMinimos)    + ", " + ;
			           "  minexps = " + FormatarNumeroSQL(THIS.this_nMinExps)    + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - Exclui registro de SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmI - Verifica se usuario ja existe no periodo
	* Retorna "" se ok, mensagem de erro se duplicado
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmI()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos) + ;
			           " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupI")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupI") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo!!!"
				ENDIF
				IF USED("cursor_4c_DupI")
					USE IN cursor_4c_DupI
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmI: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmV - Verifica se usuario ja existe em SigCcCmV
	* (tabela de vendedores individuais) para o mesmo periodo
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmV()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmV" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupV")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupV") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo Como Vendedor Individual!!!"
				ENDIF
				IF USED("cursor_4c_DupV")
					USE IN cursor_4c_DupV
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmV: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* CarregarUltimoPeriodoUsuario - Carrega o ultimo periodo cadastrado para
	* o usuario (usado para auto-preencher o periodo seguinte em novos registros)
	*==========================================================================
	PROCEDURE CarregarUltimoPeriodoUsuario(par_cUsuars)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT TOP 1 cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(ALLTRIM(par_cUsuars)) + ;
			           " ORDER BY anos DESC, mess DESC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltPer")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_UltPer") > 0
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarUltimoPeriodoUsuario: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CopiarPeriodo - Copia registros de um periodo para outro
	* par_cMesOri/par_cAnoOri: periodo de origem
	* par_cMesDes/par_cAnoDes: periodo de destino
	* Retorna .T. se copiou registros, .F. caso contrario
	*==========================================================================
	PROCEDURE CopiarPeriodo(par_cMesOri, par_cAnoOri, par_cMesDes, par_cAnoDes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lInseriu, loc_lOk
		LOCAL loc_cNovaChave, loc_cErroCopia
		loc_lSucesso = .F.
		loc_lInseriu = .F.
		loc_lOk      = .T.

		TRY
			*-- Busca registros do periodo de origem
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess = " + EscaparSQL(par_cMesOri) + ;
			           " AND anos = " + EscaparSQL(par_cAnoOri) + ;
			           " ORDER BY usuars"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Origem")
			IF loc_nResultado < 0
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem: " + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF RECCOUNT("cursor_4c_Origem") = 0
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + ;
					        CHR(237) + "odo de Origem Informado!!!", "")
				ELSE
					SELECT cursor_4c_Origem
					GO TOP
					SCAN
						*-- Verifica se vendedor ja existe no periodo destino
						loc_cSQL = "SELECT cidchaves FROM SigCcCmI" + ;
						           " WHERE usuars = " + EscaparSQL(cursor_4c_Origem.usuars) + ;
						           " AND mess = " + EscaparSQL(par_cMesDes) + ;
						           " AND anos = " + EscaparSQL(par_cAnoDes)

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca")
						IF loc_nResultado >= 0
							IF RECCOUNT("cursor_4c_Busca") = 0
								*-- Insere novo registro no periodo destino
								loc_cNovaChave = fUniqueIds()
								loc_cSQL = "INSERT INTO SigCcCmI" + ;
								           " (cidchaves, usuars, mess, anos, indivs," + ;
								           "  setors, supervs, adics, minimos, minexps)" + ;
								           " VALUES (" + ;
								           EscaparSQL(loc_cNovaChave)                    + ", " + ;
								           EscaparSQL(cursor_4c_Origem.usuars)           + ", " + ;
								           EscaparSQL(par_cMesDes)                       + ", " + ;
								           EscaparSQL(par_cAnoDes)                       + ", " + ;
								           EscaparSQL(cursor_4c_Origem.indivs)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.setors)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.supervs)          + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.adics)     + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minimos)   + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minexps)   + ")"

								loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
								IF loc_nResultado >= 0
									loc_lInseriu = .T.
								ELSE
									loc_lOk = .F.
								ENDIF
							ENDIF
							IF USED("cursor_4c_Busca")
								USE IN cursor_4c_Busca
							ENDIF
						ELSE
							loc_lOk = .F.
						ENDIF
					ENDSCAN

					loc_lSucesso = loc_lInseriu AND loc_lOk
				ENDIF
			ENDIF

			IF USED("cursor_4c_Origem")
				USE IN cursor_4c_Origem
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CopiarPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

