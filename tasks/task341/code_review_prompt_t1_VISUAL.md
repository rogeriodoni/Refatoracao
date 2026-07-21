# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 188: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 238: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 263: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 288: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 325: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 441: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 465: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormACE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1300 linhas total):

*-- Linhas 89 a 106:
89: 
90:         WITH loc_oPgf
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()

*-- Linhas 118 a 156:
118:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oCab.lbl_4c_Sombra
132:             .AutoSize  = .F.
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .AutoSize  = .F.
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 163 a 350:
163:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
164:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
165:         WITH loc_oBotoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackColor   = RGB(53, 53, 53)
171:             .BackStyle   = 1
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         *-- Botao Incluir
177:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
178:         WITH loc_oBotoes.cmd_4c_Incluir
179:             .Caption         = "Incluir"
180:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
181:             .PicturePosition = 13
182:             .Top             = 5
183:             .Left            = 5
184:             .Width           = 75
185:             .Height          = 75
186:             .BackColor       = RGB(255, 255, 255)
187:             .ForeColor       = RGB(90, 90, 90)
188:             .FontName        = "Comic Sans MS"
189:             .FontSize        = 8
190:             .FontBold        = .T.
191:             .FontItalic      = .T.
192:             .Themes          = .F.
193:             .SpecialEffect   = 0
194:             .MousePointer    = 15
195:             .WordWrap        = .T.
196:             .AutoSize        = .F.
197:             .Visible         = .T.
198:         ENDWITH
199:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
200: 
201:         *-- Botao Visualizar
202:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
203:         WITH loc_oBotoes.cmd_4c_Visualizar
204:             .Caption         = "Visualizar"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
206:             .PicturePosition = 13
207:             .Top             = 5
208:             .Left            = 80
209:             .Width           = 75
210:             .Height          = 75
211:             .BackColor       = RGB(255, 255, 255)
212:             .ForeColor       = RGB(90, 90, 90)
213:             .FontName        = "Comic Sans MS"
214:             .FontSize        = 8
215:             .FontBold        = .T.
216:             .FontItalic      = .T.
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .MousePointer    = 15
220:             .WordWrap        = .T.
221:             .AutoSize        = .F.
222:             .Visible         = .T.
223:         ENDWITH
224:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
225: 
226:         *-- Botao Alterar
227:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH loc_oBotoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
231:             .PicturePosition = 13
232:             .Top             = 5
233:             .Left            = 155
234:             .Width           = 75
235:             .Height          = 75
236:             .BackColor       = RGB(255, 255, 255)
237:             .ForeColor       = RGB(90, 90, 90)
238:             .FontName        = "Comic Sans MS"
239:             .FontSize        = 8
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .MousePointer    = 15
245:             .WordWrap        = .T.
246:             .AutoSize        = .F.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
250: 
251:         *-- Botao Excluir
252:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
253:         WITH loc_oBotoes.cmd_4c_Excluir
254:             .Caption         = "Excluir"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 230
259:             .Width           = 75
260:             .Height          = 75
261:             .BackColor       = RGB(255, 255, 255)
262:             .ForeColor       = RGB(90, 90, 90)
263:             .FontName        = "Comic Sans MS"
264:             .FontSize        = 8
265:             .FontBold        = .T.
266:             .FontItalic      = .T.
267:             .Themes          = .F.
268:             .SpecialEffect   = 0
269:             .MousePointer    = 15
270:             .WordWrap        = .T.
271:             .AutoSize        = .F.
272:             .Visible         = .T.
273:         ENDWITH
274:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
275: 
276:         *-- Botao Buscar
277:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
278:         WITH loc_oBotoes.cmd_4c_Buscar
279:             .Caption         = "Buscar"
280:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
281:             .PicturePosition = 13
282:             .Top             = 5
283:             .Left            = 305
284:             .Width           = 75
285:             .Height          = 75
286:             .BackColor       = RGB(255, 255, 255)
287:             .ForeColor       = RGB(90, 90, 90)
288:             .FontName        = "Comic Sans MS"
289:             .FontSize        = 8
290:             .FontBold        = .T.
291:             .FontItalic      = .T.
292:             .Themes          = .F.
293:             .SpecialEffect   = 0
294:             .MousePointer    = 15
295:             .WordWrap        = .T.
296:             .AutoSize        = .F.
297:             .Visible         = .T.
298:         ENDWITH
299:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
300: 
301:         *-- Container Encerrar (canonico: Left=917, Width=90)
302:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
303:         loc_oSaida = loc_oPg1.cnt_4c_Saida
304:         WITH loc_oSaida
305:             .Top         = 29
306:             .Left        = 917
307:             .Width       = 90
308:             .Height      = 85
309:             .BackStyle   = 0
310:             .BorderWidth = 0
311:             .Visible     = .T.
312:         ENDWITH
313: 
314:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
315:         WITH loc_oSaida.cmd_4c_Encerrar
316:             .Caption         = "Encerrar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 5
321:             .Width           = 75
322:             .Height          = 75
323:             .BackColor       = RGB(255, 255, 255)
324:             .ForeColor       = RGB(90, 90, 90)
325:             .FontName        = "Comic Sans MS"
326:             .FontSize        = 8
327:             .FontBold        = .T.
328:             .FontItalic      = .T.
329:             .Themes          = .F.
330:             .SpecialEffect   = 0
331:             .MousePointer    = 15
332:             .WordWrap        = .T.
333:             .AutoSize        = .F.
334:             .Visible         = .T.
335:         ENDWITH
336:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid de lista de empresas (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
339:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
340:         loc_oGrid = loc_oPg1.grd_4c_Lista
341:         loc_oGrid.RecordSource = ""
342:         loc_oGrid.ColumnCount  = 2
343:         WITH loc_oGrid
344:             .Top                = 117
345:             .Left               = 26
346:             .Width              = 880
347:             .Height             = 498
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .GridLines          = 3

*-- Linhas 373 a 411:
373:         loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
374:         loc_oCab = loc_oPg2.cnt_4c_Cabecalho
375:         WITH loc_oCab
376:             .Top         = 31
377:             .Left        = 0
378:             .Width       = THIS.Width
379:             .Height      = 80
380:             .BackColor   = RGB(100, 100, 100)
381:             .BorderWidth = 0
382:             .Visible     = .T.
383:         ENDWITH
384: 
385:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
386:         WITH loc_oCab.lbl_4c_Sombra
387:             .AutoSize  = .F.
388:             .Caption   = THIS.Caption
389:             .Top       = 15
390:             .Left      = 10
391:             .Width     = THIS.Width
392:             .Height    = 40
393:             .FontName  = "Tahoma"
394:             .FontSize  = 16
395:             .FontBold  = .T.
396:             .ForeColor = RGB(0, 0, 0)
397:             .BackStyle = 0
398:             .Visible   = .T.
399:         ENDWITH
400: 
401:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
402:         WITH loc_oCab.lbl_4c_Titulo
403:             .AutoSize  = .F.
404:             .Caption   = THIS.Caption
405:             .Top       = 18
406:             .Left      = 10
407:             .Width     = THIS.Width
408:             .Height    = 46
409:             .FontName  = "Tahoma"
410:             .FontSize  = 16
411:             .FontBold  = .T.

*-- Linhas 418 a 489:
418:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
419:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
420:         WITH loc_oBotoesAcao
421:             .Top         = 33
422:             .Left        = 842
423:             .Width       = 160
424:             .Height      = 85
425:             .BackStyle   = 0
426:             .BorderWidth = 0
427:             .Visible     = .T.
428:         ENDWITH
429: 
430:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
431:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
432:             .Caption         = "Confirmar"
433:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
434:             .PicturePosition = 13
435:             .Top             = 5
436:             .Left            = 5
437:             .Width           = 75
438:             .Height          = 75
439:             .BackColor       = RGB(255, 255, 255)
440:             .ForeColor       = RGB(90, 90, 90)
441:             .FontName        = "Comic Sans MS"
442:             .FontSize        = 8
443:             .FontBold        = .T.
444:             .FontItalic      = .T.
445:             .Themes          = .F.
446:             .SpecialEffect   = 0
447:             .MousePointer    = 15
448:             .WordWrap        = .T.
449:             .AutoSize        = .F.
450:             .Visible         = .T.
451:         ENDWITH
452:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
453: 
454:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
455:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
456:             .Caption         = "Encerrar"
457:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
458:             .PicturePosition = 13
459:             .Top             = 5
460:             .Left            = 80
461:             .Width           = 75
462:             .Height          = 75
463:             .BackColor       = RGB(255, 255, 255)
464:             .ForeColor       = RGB(90, 90, 90)
465:             .FontName        = "Comic Sans MS"
466:             .FontSize        = 8
467:             .FontBold        = .T.
468:             .FontItalic      = .T.
469:             .Themes          = .F.
470:             .SpecialEffect   = 0
471:             .MousePointer    = 15
472:             .WordWrap        = .T.
473:             .AutoSize        = .F.
474:             .Visible         = .T.
475:         ENDWITH
476:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
477: 
478:         *-- Label "Empresa" (Say22 original: top=30, left=231 -> compensacao +29 = top=59)
479:         loc_oPg2.AddObject("lbl_4c_Empresa", "Label")
480:         WITH loc_oPg2.lbl_4c_Empresa
481:             .AutoSize  = .F.
482:             .Caption   = "Empresa"
483:             .Top       = 59
484:             .Left      = 231
485:             .Width     = 60
486:             .Height    = 17
487:             .FontName  = "Tahoma"
488:             .FontSize  = 8
489:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 495 a 504:
495:         loc_oPg2.AddObject("txt_4c_Empresa", "TextBox")
496:         WITH loc_oPg2.txt_4c_Empresa
497:             .Value     = ""
498:             .Top       = 78
499:             .Left      = 231
500:             .Width     = 31
501:             .Height    = 23
502:             .MaxLength = 3
503:             .FontName  = "Tahoma"
504:             .FontSize  = 8

*-- Linhas 513 a 522:
513:         loc_oPg2.AddObject("txt_4c_DEmpresa", "TextBox")
514:         WITH loc_oPg2.txt_4c_DEmpresa
515:             .Value     = ""
516:             .Top       = 78
517:             .Left      = 264
518:             .Width     = 290
519:             .Height    = 23
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .BackColor = RGB(240, 240, 240)

*-- Linhas 528 a 568:
528:         *-- ListBox usuarios disponiveis (Usuario original: top=96, left=231, width=135, height=429 -> top=125)
529:         loc_oPg2.AddObject("lst_4c_Usuario", "ListBox")
530:         WITH loc_oPg2.lst_4c_Usuario
531:             .Top         = 125
532:             .Left        = 231
533:             .Width       = 135
534:             .Height      = 429
535:             .FontName    = "Courier New"
536:             .FontSize    = 9
537:             .MultiSelect = .T.
538:             .Visible     = .T.
539:         ENDWITH
540:         BINDEVENT(loc_oPg2.lst_4c_Usuario, "DblClick", THIS, "UsuarioDblClick")
541: 
542:         *-- ListBox usuarios com acesso (Usuemp original: top=96, left=418, width=135, height=429 -> top=125)
543:         loc_oPg2.AddObject("lst_4c_Usuemp", "ListBox")
544:         WITH loc_oPg2.lst_4c_Usuemp
545:             .Top         = 125
546:             .Left        = 418
547:             .Width       = 135
548:             .Height      = 429
549:             .FontName    = "Courier New"
550:             .FontSize    = 9
551:             .MultiSelect = .T.
552:             .Visible     = .T.
553:         ENDWITH
554:         BINDEVENT(loc_oPg2.lst_4c_Usuemp, "DblClick", THIS, "UsueEmpDblClick")
555: 
556:         *-- Botao Add um item (cmdAdd original: top=203, left=370, 45x45 -> top=232)
557:         loc_oPg2.AddObject("cmd_4c_CmdAdd", "CommandButton")
558:         WITH loc_oPg2.cmd_4c_CmdAdd
559:             .Caption         = ""
560:             .Picture         = gc_4c_CaminhoIcones + "Cadastro_Seta_Direita_20.jpg"
561:             .PicturePosition = 13
562:             .Top             = 232
563:             .Left            = 370
564:             .Width           = 45
565:             .Height          = 45
566:             .BackColor       = RGB(255, 255, 255)
567:             .ForeColor       = RGB(0, 0, 128)
568:             .FontBold        = .T.

*-- Linhas 576 a 593:
576:             .ToolTipText     = "Selecionar Um Item"
577:             .Visible         = .T.
578:         ENDWITH
579:         BINDEVENT(loc_oPg2.cmd_4c_CmdAdd, "Click", THIS, "CmdAddClick")
580: 
581:         *-- Botao Add todos (cmdAddAll original: top=293, left=370, 45x45 -> top=322)
582:         loc_oPg2.AddObject("cmd_4c_CmdAddAll", "CommandButton")
583:         WITH loc_oPg2.cmd_4c_CmdAddAll
584:             .Caption         = ""
585:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_dir_60.jpg"
586:             .PicturePosition = 13
587:             .Top             = 322
588:             .Left            = 370
589:             .Width           = 45
590:             .Height          = 45
591:             .BackColor       = RGB(255, 255, 255)
592:             .ForeColor       = RGB(0, 0, 128)
593:             .FontBold        = .T.

*-- Linhas 601 a 618:
601:             .ToolTipText     = "Selecionar Todos os Itens"
602:             .Visible         = .T.
603:         ENDWITH
604:         BINDEVENT(loc_oPg2.cmd_4c_CmdAddAll, "Click", THIS, "CmdAddAllClick")
605: 
606:         *-- Botao Remove um item (cmdRemove original: top=248, left=370, 45x45 -> top=277)
607:         loc_oPg2.AddObject("cmd_4c_CmdRemove", "CommandButton")
608:         WITH loc_oPg2.cmd_4c_CmdRemove
609:             .Caption         = ""
610:             .Picture         = gc_4c_CaminhoIcones + "Cadastro_Seta_Esquerda_20.jpg"
611:             .PicturePosition = 13
612:             .Top             = 277
613:             .Left            = 370
614:             .Width           = 45
615:             .Height          = 45
616:             .BackColor       = RGB(255, 255, 255)
617:             .ForeColor       = RGB(0, 0, 128)
618:             .FontBold        = .T.

*-- Linhas 626 a 643:
626:             .ToolTipText     = "Remover um Item"
627:             .Visible         = .T.
628:         ENDWITH
629:         BINDEVENT(loc_oPg2.cmd_4c_CmdRemove, "Click", THIS, "CmdRemoveClick")
630: 
631:         *-- Botao Remove todos (cmdRemoveAll original: top=338, left=370, 45x45 -> top=367)
632:         loc_oPg2.AddObject("cmd_4c_CmdRemoveAll", "CommandButton")
633:         WITH loc_oPg2.cmd_4c_CmdRemoveAll
634:             .Caption         = ""
635:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
636:             .PicturePosition = 13
637:             .Top             = 367
638:             .Left            = 370
639:             .Width           = 45
640:             .Height          = 45
641:             .BackColor       = RGB(255, 255, 255)
642:             .ForeColor       = RGB(0, 0, 128)
643:             .FontBold        = .T.

*-- Linhas 651 a 659:
651:             .ToolTipText     = "Remover todos os Itens"
652:             .Visible         = .T.
653:         ENDWITH
654:         BINDEVENT(loc_oPg2.cmd_4c_CmdRemoveAll, "Click", THIS, "CmdRemoveAllClick")
655: 
656:         THIS.TornarControlesVisiveis(loc_oPg2)
657:     ENDPROC
658: 
659:     *--------------------------------------------------------------------------

*-- Linhas 681 a 690:
681:                     loc_oGrid.Column1.ReadOnly      = .T.
682:                     loc_oGrid.Column2.ReadOnly      = .T.
683: 
684:                     loc_oGrid.Column1.Header1.Caption = "Empresa"
685:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
686: 
687:                     THIS.FormatarGridLista(loc_oGrid)
688:                     loc_lResultado = .T.
689:                 ENDIF
690:             ENDIF

*-- Linhas 1050 a 1058:
1050:             loc_oPg2.txt_4c_Empresa.ReadOnly  = !loc_lModoConsulta
1051:             loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.
1052: 
1053:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1054:             *-- Botoes de transferencia sao icone-only: nao desabilitar (ficam retangulo vazio)
1055:             *-- O modo e verificado diretamente nos handlers CmdAddClick etc.
1056:         CATCH TO loc_oErro
1057:             MsgErro(loc_oErro.Message, "FormACE.HabilitarCampos")
1058:         ENDTRY

*-- Linhas 1271 a 1283:
1271: 
1272:         TRY
1273:             WITH loc_oBotoes
1274:                 .cmd_4c_Incluir.Enabled    = .T.
1275:                 .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
1276:                 .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
1277:                 .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
1278:                 .cmd_4c_Buscar.Enabled     = .T.
1279:             ENDWITH
1280:         CATCH TO loc_oErro
1281:             MsgErro(loc_oErro.Message, "FormACE.AjustarBotoesPorModo")
1282:         ENDTRY
1283:     ENDPROC


### BO (C:\4c\projeto\app\classes\ACEBO.prg):
*==============================================================================
* ACEBO.PRG
* Business Object para Acesso de Empresas (SIGCDACE)
*
* Tabela Principal : SigCdEmp  - Lista de empresas (Cemps, Razas)
* Tabela de Acesso : SigCdAcE  - Mapeamento empresa-usuario
*                                (emps char(3), usuarios char(10), pkchaves char(13))
* Tabela de Usuarios: SigCdUsu - Cadastro de usuarios (usuarios char(10))
*
* Logica: Gerencia quais usuarios tem acesso a cada empresa.
*         Inserir/Atualizar = DELETE + re-INSERT em SigCdAcE por empresa.
*         Excluir           = DELETE todos os acessos da empresa em SigCdAcE.
*         Buscar            = SELECT de empresas em SigCdEmp (exibicao no grid).
*==============================================================================

DEFINE CLASS ACEBO AS BusinessBase

    *-- Propriedades da empresa (SigCdEmp)
    this_cEmpresa            = ""   && Cemps/emps CHAR(3)  - Codigo da empresa (PK)
    this_cDescricaoEmpresa   = ""   && Razas       CHAR(40) - Descricao da empresa

    *-- Nome do cursor que o Form preenche com os usuarios com acesso antes de Salvar()
    this_cCursorUsuariosAcesso = "cursor_4c_UsuariosAcesso"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmp"
        THIS.this_cCampoChave = "Cemps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpresa
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da empresa de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpresa          = TratarNulo(Cemps, "C")
                THIS.this_cDescricaoEmpresa = TratarNulo(Razas, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cEmpresa          = ""
        THIS.this_cDescricaoEmpresa = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa obrigat" + CHR(243) + "rio"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista empresas no grid (SELECT de SigCdEmp)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                           " WHERE Cemps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de uma empresa pelo codigo Cemps
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cEmpresa) != "C" OR EMPTY(ALLTRIM(par_cEmpresa))
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cEmpresa)
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosDisponiveis - Usuarios sem acesso a esta empresa
    * Retorna cursor_4c_UsuariosDispon (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosDisponiveis(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosDispon")
                USE IN cursor_4c_UsuariosDispon
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdUsu" + ;
                       " WHERE NOT cativos = 'N'" + ;
                       " AND Usuarios NOT IN" + ;
                       " (SELECT Usuarios FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa)) + ")" + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosDispon")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosComAcesso - Usuarios com acesso a esta empresa
    * Retorna cursor_4c_UsuariosAcesso (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosComAcesso(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdAcE" + ;
                       " WHERE emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosAcesso")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursorAcesso - Cria cursor vazio para o Form preencher com usuarios
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursorAcesso()
        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_UsuariosAcesso (Usuarios C(10))
            SET NULL OFF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT: DELETE acessos antigos + INSERT novos (PROTECTED)
    * O Form preenche cursor_4c_UsuariosAcesso antes de chamar Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE: mesma logica do Inserir (DELETE + re-INSERT) (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove todos os acessos da empresa (PROTECTED)
    * Nao deleta a empresa em si (SigCdEmp), apenas os registros em SigCdAcE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                MsgErro("Empresa n" + CHR(227) + "o selecionada para exclus" + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelExcl")
                IF USED("cursor_4c_DelExcl")
                    USE IN cursor_4c_DelExcl
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

