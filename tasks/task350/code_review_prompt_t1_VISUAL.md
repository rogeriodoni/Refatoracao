# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (11)
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 267: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 288: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 322: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 458: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 479: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1362: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1383: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1404: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2825 linhas total):

*-- Linhas 72 a 81:
72:             ELSE
73:                 THIS.ConfigurarPageFrame()
74: 
75:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
76:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
77: 
78:                 THIS.pgf_4c_Paginas.Visible    = .T.
79:                 THIS.pgf_4c_Paginas.ActivePage = 1
80:                 THIS.this_cModoAtual = "LISTA"
81: 

*-- Linhas 102 a 384:
102: 
103:         WITH loc_oPgf
104:             .PageCount = 3
105:             .Top       = -29
106:             .Left      = 0
107:             .Width     = THIS.Width
108:             .Height    = THIS.Height + 29
109:             .Tabs      = .F.
110:             .Visible   = .T.
111:             .Page1.Caption   = "Lista"
112:             .Page1.BackColor = RGB(100, 100, 100)
113:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:             .Page2.Caption   = "Dados"
115:             .Page2.BackColor = RGB(100, 100, 100)
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page3.Caption   = "Leitura"
118:             .Page3.BackColor = RGB(100, 100, 100)
119:             .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120:         ENDWITH
121: 
122:         THIS.ConfigurarPaginaLista()
123:         THIS.ConfigurarPaginaDados()
124:         THIS.ConfigurarPaginaLeitura()
125:     ENDPROC
126: 
127:     *--------------------------------------------------------------------------
128:     * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + Leitura/Fecha + grid
129:     * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
130:     *--------------------------------------------------------------------------
131:     PROTECTED PROCEDURE ConfigurarPaginaLista()
132:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
133: 
134:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
135: 
136:         *-- Cabecalho cinza
137:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
138:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
139:         WITH loc_oCab
140:             .Top         = 29
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BackColor   = RGB(100, 100, 100)
145:             .BorderWidth = 0
146:             .Visible     = .T.
147:         ENDWITH
148: 
149:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
150:         WITH loc_oCab.lbl_4c_Sombra
151:             .Caption   = THIS.Caption
152:             .AutoSize  = .F.
153:             .Width     = THIS.Width
154:             .Height    = 40
155:             .Top       = 15
156:             .Left      = 10
157:             .FontName  = "Tahoma"
158:             .FontSize  = 16
159:             .FontBold  = .T.
160:             .ForeColor = RGB(0, 0, 0)
161:             .BackStyle = 0
162:             .Visible   = .T.
163:         ENDWITH
164: 
165:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
166:         WITH loc_oCab.lbl_4c_Titulo
167:             .Caption   = THIS.Caption
168:             .AutoSize  = .F.
169:             .Width     = THIS.Width
170:             .Height    = 46
171:             .Top       = 18
172:             .Left      = 10
173:             .FontName  = "Tahoma"
174:             .FontSize  = 16
175:             .FontBold  = .T.
176:             .ForeColor = RGB(255, 255, 255)
177:             .BackStyle = 0
178:             .Visible   = .T.
179:         ENDWITH
180: 
181:         *-- Container botoes CRUD (Left=544, Top=29, Width=385)
182:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
183:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
184:         WITH loc_oBotoes
185:             .Top         = 29
186:             .Left        =  542
187:             .Width       = 385
188:             .Height      = 85
189:             .BackStyle   = 1
190:             .BackColor   = RGB(53, 53, 53)
191:             .BorderWidth = 0
192:             .Visible     = .T.
193:         ENDWITH
194: 
195:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
196:         WITH loc_oBotoes.cmd_4c_Incluir
197:             .Top             = 5
198:             .Left            = 5
199:             .Width           = 75
200:             .Height          = 75
201:             .Caption         = "Incluir"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
203:             .PicturePosition = 13
204:             .FontName        = "Comic Sans MS"
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .FontSize        = 8
208:             .ForeColor       = RGB(90, 90, 90)
209:             .BackColor       = RGB(255, 255, 255)
210:             .Themes          = .F.
211:             .SpecialEffect   = 0
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
215: 
216:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
217:         WITH loc_oBotoes.cmd_4c_Visualizar
218:             .Top             = 5
219:             .Left            = 80
220:             .Width           = 75
221:             .Height          = 75
222:             .Caption         = "Visualizar"
223:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
224:             .PicturePosition = 13
225:             .FontName        = "Comic Sans MS"
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
228:             .FontSize        = 8
229:             .ForeColor       = RGB(90, 90, 90)
230:             .BackColor       = RGB(255, 255, 255)
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
236: 
237:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
238:         WITH loc_oBotoes.cmd_4c_Alterar
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .Caption         = "Alterar"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
245:             .PicturePosition = 13
246:             .FontName        = "Comic Sans MS"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .FontSize        = 8
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
259:         WITH loc_oBotoes.cmd_4c_Excluir
260:             .Top             = 5
261:             .Left            = 230
262:             .Width           = 75
263:             .Height          = 75
264:             .Caption         = "Excluir"
265:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
266:             .PicturePosition = 13
267:             .FontName        = "Comic Sans MS"
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontSize        = 8
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .Visible         = .T.
276:         ENDWITH
277:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
278: 
279:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
280:         WITH loc_oBotoes.cmd_4c_Buscar
281:             .Top             = 5
282:             .Left            = 305
283:             .Width           = 75
284:             .Height          = 75
285:             .Caption         = "Buscar"
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
287:             .PicturePosition = 13
288:             .FontName        = "Comic Sans MS"
289:             .FontBold        = .T.
290:             .FontItalic      = .T.
291:             .FontSize        = 8
292:             .ForeColor       = RGB(90, 90, 90)
293:             .BackColor       = RGB(255, 255, 255)
294:             .Themes          = .F.
295:             .SpecialEffect   = 0
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
299: 
300:         *-- Container Saida canonico (Left=917, Width=90, Top=29)
301:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
302:         loc_oSaida = loc_oPg1.cnt_4c_Saida
303:         WITH loc_oSaida
304:             .Top         = 29
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
314:         WITH loc_oSaida.cmd_4c_Encerrar
315:             .Top             = 5
316:             .Left            = 5
317:             .Width           = 75
318:             .Height          = 75
319:             .Caption         = "Encerrar"
320:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
321:             .PicturePosition = 13
322:             .FontName        = "Comic Sans MS"
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .FontSize        = 8
326:             .ForeColor       = RGB(90, 90, 90)
327:             .BackColor       = RGB(255, 255, 255)
328:             .Themes          = .F.
329:             .SpecialEffect   = 0
330:             .Visible         = .T.
331:         ENDWITH
332:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Botao Leitura (original: top=83+29=112, left=31, width=120, height=40)
335:         *-- Abre pagina de leitura de cheques para o balanco selecionado
336:         loc_oPg1.AddObject("cmd_4c_Leitura", "CommandButton")
337:         WITH loc_oPg1.cmd_4c_Leitura
338:             .Top           = 112
339:             .Left          = 31
340:             .Width         = 120
341:             .Height        = 40
342:             .Caption       = "Leitura"
343:             .FontName      = "Tahoma"
344:             .FontBold      = .F.
345:             .FontSize      = 8
346:             .ForeColor     = RGB(90, 90, 90)
347:             .BackColor     = RGB(255, 255, 255)
348:             .Themes        = .F.
349:             .SpecialEffect = 0
350:             .Visible       = .T.
351:         ENDWITH
352:         BINDEVENT(loc_oPg1.cmd_4c_Leitura, "Click", THIS, "BtnLeituraClick")
353: 
354:         *-- Botao Fecha/Encerrar Balanco (original: top=83+29=112, left=152, width=120, height=40)
355:         loc_oPg1.AddObject("cmd_4c_Fecha", "CommandButton")
356:         WITH loc_oPg1.cmd_4c_Fecha
357:             .Top           = 112
358:             .Left          = 152
359:             .Width         = 120
360:             .Height        = 40
361:             .Caption       = "Encerrar"
362:             .FontName      = "Tahoma"
363:             .FontBold      = .F.
364:             .FontSize      = 8
365:             .ForeColor     = RGB(90, 90, 90)
366:             .BackColor     = RGB(255, 255, 255)
367:             .Themes        = .F.
368:             .SpecialEffect = 0
369:             .Visible       = .T.
370:         ENDWITH
371:         BINDEVENT(loc_oPg1.cmd_4c_Fecha, "Click", THIS, "BtnFechaClick")
372: 
373:         *-- Grid da lista: top=129+29=158, left=33, width=941, height=461
374:         loc_oPg1.AddObject("grd_4c_Dados", "Grid")
375:         loc_oGrid = loc_oPg1.grd_4c_Dados
376:         loc_oGrid.ColumnCount = 6
377:         WITH loc_oGrid
378:             .Top                = 158
379:             .Left               = 33
380:             .Width              = 941
381:             .Height             = 461
382:             .FontName           = "Verdana"
383:             .FontSize           = 8
384:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 397 a 545:
397: 
398:         WITH loc_oGrid.Column1
399:             .Width = 60
400:             .Header1.Caption = "C" + CHR(243) + "digo"
401:         ENDWITH
402:         WITH loc_oGrid.Column2
403:             .Width = 90
404:             .Header1.Caption = "In" + CHR(237) + "cio"
405:         ENDWITH
406:         WITH loc_oGrid.Column3
407:             .Width = 90
408:             .Header1.Caption = "T" + CHR(233) + "rmino"
409:         ENDWITH
410:         WITH loc_oGrid.Column4
411:             .Width = 120
412:             .Header1.Caption = "Tipo"
413:         ENDWITH
414:         WITH loc_oGrid.Column5
415:             .Width = 80
416:             .Header1.Caption = "Grupo"
417:         ENDWITH
418:         WITH loc_oGrid.Column6
419:             .Width = 80
420:             .Header1.Caption = "Conta"
421:         ENDWITH
422: 
423:         THIS.TornarControlesVisiveis(loc_oPg1)
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * ConfigurarPaginaDados - Page2: container salva + todos os campos de edicao
428:     * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
429:     * Lookups/Valid handlers implementados na Fase 6
430:     *--------------------------------------------------------------------------
431:     PROTECTED PROCEDURE ConfigurarPaginaDados()
432:         LOCAL loc_oPg2, loc_oSalva
433: 
434:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
435: 
436:         *-- Container Salva (Confirmar/Cancelar) - Left=842
437:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
438:         loc_oSalva = loc_oPg2.cnt_4c_Salva
439:         WITH loc_oSalva
440:             .Top         = 33
441:             .Left        = 842
442:             .Width       = 160
443:             .Height      = 85
444:             .BackStyle   = 0
445:             .BorderWidth = 0
446:             .Visible     = .T.
447:         ENDWITH
448: 
449:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
450:         WITH loc_oSalva.cmd_4c_Confirmar
451:             .Top             = 5
452:             .Left            = 5
453:             .Width           = 75
454:             .Height          = 75
455:             .Caption         = "Confirmar"
456:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
457:             .PicturePosition = 13
458:             .FontName        = "Comic Sans MS"
459:             .FontBold        = .T.
460:             .FontItalic      = .T.
461:             .FontSize        = 8
462:             .ForeColor       = RGB(90, 90, 90)
463:             .BackColor       = RGB(255, 255, 255)
464:             .Themes          = .F.
465:             .SpecialEffect   = 0
466:             .Visible         = .T.
467:         ENDWITH
468:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
469: 
470:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
471:         WITH loc_oSalva.cmd_4c_Cancelar
472:             .Top             = 5
473:             .Left            = 80
474:             .Width           = 75
475:             .Height          = 75
476:             .Caption         = "Encerrar"
477:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
478:             .PicturePosition = 13
479:             .FontName        = "Comic Sans MS"
480:             .FontBold        = .T.
481:             .FontItalic      = .T.
482:             .FontSize        = 8
483:             .ForeColor       = RGB(90, 90, 90)
484:             .BackColor       = RGB(255, 255, 255)
485:             .Themes          = .F.
486:             .SpecialEffect   = 0
487:             .Visible         = .T.
488:         ENDWITH
489:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
490: 
491:         *-- === Codigo (PK - readonly, top=172+29 original=143) ===
492:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
493:         WITH loc_oPg2.lbl_4c_Codigo
494:             .Top       = 176
495:             .Left      = 283
496:             .Width     = 40
497:             .Height    = 18
498:             .Caption   = "C" + CHR(243) + "digo"
499:             .AutoSize  = .F.
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .ForeColor = RGB(255, 255, 255)
503:             .BackStyle = 0
504:             .Visible   = .T.
505:         ENDWITH
506: 
507:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
508:         WITH loc_oPg2.txt_4c_Codigo
509:             .Top      = 172
510:             .Left     = 327
511:             .Width    = 60
512:             .Height   = 24
513:             .ReadOnly = .T.
514:             .Value    = ""
515:             .FontName = "Tahoma"
516:             .FontSize = 8
517:             .Visible  = .T.
518:         ENDWITH
519: 
520:         *-- === Tipo (ComboBox tipos 1-4, top=199 original=170) ===
521:         loc_oPg2.AddObject("lbl_4c_Tipo", "Label")
522:         WITH loc_oPg2.lbl_4c_Tipo
523:             .Top       = 203
524:             .Left      = 296
525:             .Width     = 28
526:             .Height    = 18
527:             .Caption   = "Tipo"
528:             .AutoSize  = .F.
529:             .FontName  = "Tahoma"
530:             .FontSize  = 8
531:             .ForeColor = RGB(255, 255, 255)
532:             .BackStyle = 0
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         *-- BoundColumn=0 -> Value = ListIndex (1-4) = tipos diretamente
537:         loc_oPg2.AddObject("cbo_4c_Operacao", "ComboBox")
538:         WITH loc_oPg2.cbo_4c_Operacao
539:             .Top           = 199
540:             .Left          = 327
541:             .Width         = 130
542:             .Height        = 24
543:             .RowSourceType = 1
544:             .RowSource     = "1a. Entrada,Pendentes,Devolvidos,Todos"
545:             .BoundColumn   = 0

*-- Linhas 551 a 721:
551:         ENDWITH
552: 
553:         *-- === Operacao (char 15, lookup SigCdOpe, top=226 original=197) ===
554:         loc_oPg2.AddObject("lbl_4c_Oper", "Label")
555:         WITH loc_oPg2.lbl_4c_Oper
556:             .Top       = 230
557:             .Left      = 269
558:             .Width     = 55
559:             .Height    = 18
560:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
561:             .AutoSize  = .F.
562:             .FontName  = "Tahoma"
563:             .FontSize  = 8
564:             .ForeColor = RGB(255, 255, 255)
565:             .BackStyle = 0
566:             .Visible   = .T.
567:         ENDWITH
568: 
569:         loc_oPg2.AddObject("txt_4c_Oper", "TextBox")
570:         WITH loc_oPg2.txt_4c_Oper
571:             .Top       = 226
572:             .Left      = 327
573:             .Width     = 130
574:             .Height    = 24
575:             .MaxLength = 15
576:             .Value     = ""
577:             .FontName  = "Tahoma"
578:             .FontSize  = 8
579:             .Visible   = .T.
580:         ENDWITH
581: 
582:         *-- === Data Inicial (top=253 original=224) ===
583:         loc_oPg2.AddObject("lbl_4c_DataIni", "Label")
584:         WITH loc_oPg2.lbl_4c_DataIni
585:             .Top       = 257
586:             .Left      = 291
587:             .Width     = 34
588:             .Height    = 18
589:             .Caption   = "In" + CHR(237) + "cio"
590:             .AutoSize  = .F.
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .ForeColor = RGB(255, 255, 255)
594:             .BackStyle = 0
595:             .Visible   = .T.
596:         ENDWITH
597: 
598:         *-- InputMask @D usa SET DATE BRITISH (DD/MM/YYYY) definido em FormBase.Init
599:         loc_oPg2.AddObject("txt_4c_DataInicial", "TextBox")
600:         WITH loc_oPg2.txt_4c_DataInicial
601:             .Top       = 253
602:             .Left      = 327
603:             .Width     = 80
604:             .Height    = 24
605:             .Value     = {}
606:             .InputMask = "@D"
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .Visible   = .T.
610:         ENDWITH
611: 
612:         *-- === Data Final (top=280 original=251) ===
613:         loc_oPg2.AddObject("lbl_4c_DataFim", "Label")
614:         WITH loc_oPg2.lbl_4c_DataFim
615:             .Top       = 284
616:             .Left      = 278
617:             .Width     = 46
618:             .Height    = 18
619:             .Caption   = "T" + CHR(233) + "rmino"
620:             .AutoSize  = .F.
621:             .FontName  = "Tahoma"
622:             .FontSize  = 8
623:             .ForeColor = RGB(255, 255, 255)
624:             .BackStyle = 0
625:             .Visible   = .T.
626:         ENDWITH
627: 
628:         loc_oPg2.AddObject("txt_4c_DataFinal", "TextBox")
629:         WITH loc_oPg2.txt_4c_DataFinal
630:             .Top       = 280
631:             .Left      = 327
632:             .Width     = 80
633:             .Height    = 24
634:             .Value     = {}
635:             .InputMask = "@D"
636:             .FontName  = "Tahoma"
637:             .FontSize  = 8
638:             .Visible   = .T.
639:         ENDWITH
640: 
641:         *-- === Grupo (char 10, lookup contab, top=307 original=278) ===
642:         loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
643:         WITH loc_oPg2.lbl_4c_Grupo
644:             .Top       = 311
645:             .Left      = 287
646:             .Width     = 36
647:             .Height    = 18
648:             .Caption   = "Grupo"
649:             .AutoSize  = .F.
650:             .FontName  = "Tahoma"
651:             .FontSize  = 8
652:             .ForeColor = RGB(255, 255, 255)
653:             .BackStyle = 0
654:             .Visible   = .T.
655:         ENDWITH
656: 
657:         loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
658:         WITH loc_oPg2.txt_4c_Grupo
659:             .Top       = 307
660:             .Left      = 327
661:             .Width     = 80
662:             .Height    = 24
663:             .MaxLength = 10
664:             .Value     = ""
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .Visible   = .T.
668:         ENDWITH
669: 
670:         *-- Descricao do Grupo (editavel para busca reversa por descricao em modo INCLUIR)
671:         loc_oPg2.AddObject("txt_4c_DGrupo", "TextBox")
672:         WITH loc_oPg2.txt_4c_DGrupo
673:             .Top      = 307
674:             .Left     = 409
675:             .Width    = 320
676:             .Height   = 24
677:             .Value    = ""
678:             .FontName = "Tahoma"
679:             .FontSize = 8
680:             .Visible  = .T.
681:         ENDWITH
682: 
683:         *-- === Conta (char 10, lookup contas, top=334 original=305) ===
684:         loc_oPg2.AddObject("lbl_4c_Conta", "Label")
685:         WITH loc_oPg2.lbl_4c_Conta
686:             .Top       = 338
687:             .Left      = 287
688:             .Width     = 36
689:             .Height    = 18
690:             .Caption   = "Conta"
691:             .AutoSize  = .F.
692:             .FontName  = "Tahoma"
693:             .FontSize  = 8
694:             .ForeColor = RGB(255, 255, 255)
695:             .BackStyle = 0
696:             .Visible   = .T.
697:         ENDWITH
698: 
699:         loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
700:         WITH loc_oPg2.txt_4c_Conta
701:             .Top       = 334
702:             .Left      = 327
703:             .Width     = 80
704:             .Height    = 24
705:             .MaxLength = 10
706:             .Value     = ""
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .Visible   = .T.
710:         ENDWITH
711: 
712:         *-- Descricao da Conta (editavel para busca reversa por nome em modo INCLUIR)
713:         loc_oPg2.AddObject("txt_4c_DConta", "TextBox")
714:         WITH loc_oPg2.txt_4c_DConta
715:             .Top      = 334
716:             .Left     = 409
717:             .Width    = 320
718:             .Height   = 24
719:             .Value    = ""
720:             .FontName = "Tahoma"
721:             .FontSize = 8

*-- Linhas 748 a 833:
748:         *-- Shape1: fundo area botoes topo (top=36 = legado 7 + 29 PageFrame)
749:         loc_oPg3.AddObject("shp_4c_BotoesBg", "Shape")
750:         WITH loc_oPg3.shp_4c_BotoesBg
751:             .Top           = 36
752:             .Left          = 537
753:             .Width         = 251
754:             .Height        = 110
755:             .SpecialEffect = 1
756:             .BackColor     = RGB(236, 233, 216)
757:             .BorderColor   = RGB(160, 160, 160)
758:             .Visible       = .T.
759:         ENDWITH
760: 
761:         *-- Shape2: fundo dados do balanco corrente
762:         loc_oPg3.AddObject("shp_4c_DadosBal", "Shape")
763:         WITH loc_oPg3.shp_4c_DadosBal
764:             .Top           = 193
765:             .Left          = 167
766:             .Width         = 509
767:             .Height        = 154
768:             .SpecialEffect = 1
769:             .BackColor     = RGB(236, 233, 216)
770:             .BorderColor   = RGB(160, 160, 160)
771:             .Visible       = .T.
772:         ENDWITH
773: 
774:         *-- Shape4: fundo area tipo de leitura
775:         loc_oPg3.AddObject("shp_4c_TipoLeitBg", "Shape")
776:         WITH loc_oPg3.shp_4c_TipoLeitBg
777:             .Top           = 193
778:             .Left          = 674
779:             .Width         = 158
780:             .Height        = 154
781:             .SpecialEffect = 1
782:             .BackColor     = RGB(236, 233, 216)
783:             .BorderColor   = RGB(160, 160, 160)
784:             .Visible       = .T.
785:         ENDWITH
786: 
787:         *======================================================
788:         * 2. Labels de cabecalho para area dados balanco
789:         *======================================================
790:         loc_oPg3.AddObject("lbl_4c_CabDados", "Label")
791:         WITH loc_oPg3.lbl_4c_CabDados
792:             .Top       = 196
793:             .Left      = 175
794:             .Width     = 490
795:             .Height    = 16
796:             .Caption   = "C" + CHR(243) + "d.    Opera" + CHR(231) + CHR(227) + "o          Oper.Aberta          Dt.Inicial    Dt.Final"
797:             .FontName  = "Arial"
798:             .FontSize  = 8
799:             .FontBold  = .T.
800:             .ForeColor = RGB(0, 0, 128)
801:             .BackStyle = 0
802:             .AutoSize  = .F.
803:             .Visible   = .T.
804:         ENDWITH
805: 
806:         loc_oPg3.AddObject("lbl_4c_CabDados2", "Label")
807:         WITH loc_oPg3.lbl_4c_CabDados2
808:             .Top       = 246
809:             .Left      = 175
810:             .Width     = 490
811:             .Height    = 16
812:             .Caption   = "Grupo                   Descri" + CHR(231) + CHR(227) + "o do Grupo"
813:             .FontName  = "Arial"
814:             .FontSize  = 8
815:             .FontBold  = .T.
816:             .ForeColor = RGB(0, 0, 128)
817:             .BackStyle = 0
818:             .AutoSize  = .F.
819:             .Visible   = .T.
820:         ENDWITH
821: 
822:         loc_oPg3.AddObject("lbl_4c_CabDados3", "Label")
823:         WITH loc_oPg3.lbl_4c_CabDados3
824:             .Top       = 296
825:             .Left      = 175
826:             .Width     = 490
827:             .Height    = 16
828:             .Caption   = "Conta                   Descri" + CHR(231) + CHR(227) + "o da Conta"
829:             .FontName  = "Arial"
830:             .FontSize  = 8
831:             .FontBold  = .T.
832:             .ForeColor = RGB(0, 0, 128)
833:             .BackStyle = 0

*-- Linhas 840 a 961:
840:         *======================================================
841:         loc_oPg3.AddObject("txt_4c_CodDisp", "TextBox")
842:         WITH loc_oPg3.txt_4c_CodDisp
843:             .Top         = 213
844:             .Left        = 175
845:             .Width       = 60
846:             .Height      = 22
847:             .ReadOnly    = .T.
848:             .BackColor   = RGB(220, 220, 220)
849:             .BorderStyle = 1
850:             .FontName    = "Arial"
851:             .FontSize    = 9
852:             .Visible     = .T.
853:         ENDWITH
854: 
855:         loc_oPg3.AddObject("txt_4c_OperDisp", "TextBox")
856:         WITH loc_oPg3.txt_4c_OperDisp
857:             .Top         = 213
858:             .Left        = 246
859:             .Width       = 100
860:             .Height      = 22
861:             .ReadOnly    = .T.
862:             .BackColor   = RGB(220, 220, 220)
863:             .BorderStyle = 1
864:             .FontName    = "Arial"
865:             .FontSize    = 9
866:             .Visible     = .T.
867:         ENDWITH
868: 
869:         loc_oPg3.AddObject("txt_4c_OperAbDisp", "TextBox")
870:         WITH loc_oPg3.txt_4c_OperAbDisp
871:             .Top         = 213
872:             .Left        = 356
873:             .Width       = 130
874:             .Height      = 22
875:             .ReadOnly    = .T.
876:             .BackColor   = RGB(220, 220, 220)
877:             .BorderStyle = 1
878:             .FontName    = "Arial"
879:             .FontSize    = 9
880:             .Visible     = .T.
881:         ENDWITH
882: 
883:         loc_oPg3.AddObject("txt_4c_DataIniDisp", "TextBox")
884:         WITH loc_oPg3.txt_4c_DataIniDisp
885:             .Top         = 213
886:             .Left        = 497
887:             .Width       = 80
888:             .Height      = 22
889:             .ReadOnly    = .T.
890:             .BackColor   = RGB(220, 220, 220)
891:             .BorderStyle = 1
892:             .FontName    = "Arial"
893:             .FontSize    = 9
894:             .Visible     = .T.
895:         ENDWITH
896: 
897:         loc_oPg3.AddObject("txt_4c_DataFimDisp", "TextBox")
898:         WITH loc_oPg3.txt_4c_DataFimDisp
899:             .Top         = 213
900:             .Left        = 587
901:             .Width       = 80
902:             .Height      = 22
903:             .ReadOnly    = .T.
904:             .BackColor   = RGB(220, 220, 220)
905:             .BorderStyle = 1
906:             .FontName    = "Arial"
907:             .FontSize    = 9
908:             .Visible     = .T.
909:         ENDWITH
910: 
911:         loc_oPg3.AddObject("txt_4c_GrupoDisp", "TextBox")
912:         WITH loc_oPg3.txt_4c_GrupoDisp
913:             .Top         = 263
914:             .Left        = 175
915:             .Width       = 80
916:             .Height      = 22
917:             .ReadOnly    = .T.
918:             .BackColor   = RGB(220, 220, 220)
919:             .BorderStyle = 1
920:             .FontName    = "Arial"
921:             .FontSize    = 9
922:             .Visible     = .T.
923:         ENDWITH
924: 
925:         loc_oPg3.AddObject("txt_4c_DGrupoDisp", "TextBox")
926:         WITH loc_oPg3.txt_4c_DGrupoDisp
927:             .Top         = 263
928:             .Left        = 256
929:             .Width       = 160
930:             .Height      = 22
931:             .ReadOnly    = .T.
932:             .BackColor   = RGB(220, 220, 220)
933:             .BorderStyle = 1
934:             .FontName    = "Arial"
935:             .FontSize    = 9
936:             .Visible     = .T.
937:         ENDWITH
938: 
939:         loc_oPg3.AddObject("txt_4c_ContaDisp", "TextBox")
940:         WITH loc_oPg3.txt_4c_ContaDisp
941:             .Top         = 313
942:             .Left        = 175
943:             .Width       = 80
944:             .Height      = 22
945:             .ReadOnly    = .T.
946:             .BackColor   = RGB(220, 220, 220)
947:             .BorderStyle = 1
948:             .FontName    = "Arial"
949:             .FontSize    = 9
950:             .Visible     = .T.
951:         ENDWITH
952: 
953:         loc_oPg3.AddObject("txt_4c_DContaDisp", "TextBox")
954:         WITH loc_oPg3.txt_4c_DContaDisp
955:             .Top         = 313
956:             .Left        = 256
957:             .Width       = 240
958:             .Height      = 22
959:             .ReadOnly    = .T.
960:             .BackColor   = RGB(220, 220, 220)
961:             .BorderStyle = 1

*-- Linhas 969 a 1259:
969:         *    Button1=Teclado (manual), Button2=Porta (serial - desabilitado)
970:         *======================================================
971:         loc_oPg3.AddObject("opt_4c_TipoLeitura", "OptionGroup")
972:         loc_oPg3.opt_4c_TipoLeitura.Top         = 199
973:         loc_oPg3.opt_4c_TipoLeitura.Left        = 709
974:         loc_oPg3.opt_4c_TipoLeitura.Width       = 78
975:         loc_oPg3.opt_4c_TipoLeitura.Height      = 41
976:         loc_oPg3.opt_4c_TipoLeitura.ButtonCount = 2
977:         loc_oPg3.opt_4c_TipoLeitura.Value       = 1
978:         loc_oPg3.opt_4c_TipoLeitura.BackStyle   = 0
979:         loc_oPg3.opt_4c_TipoLeitura.BorderStyle = 0
980:         loc_oPg3.opt_4c_TipoLeitura.Visible     = .T.
981:         WITH loc_oPg3.opt_4c_TipoLeitura
982:             WITH .Buttons(1)
983:                 .Top     = 3
984:                 .Left    = 3
985:                 .Width   = 70
986:                 .Height  = 17
987:                 .Caption = "Teclado"
988:                 .Value   = 1
989:             ENDWITH
990:             WITH .Buttons(2)
991:                 .Top     = 22
992:                 .Left    = 3
993:                 .Width   = 70
994:                 .Height  = 17
995:                 .Caption = "Porta"
996:                 .Value   = 0
997:                 .Enabled = .F.
998:             ENDWITH
999:         ENDWITH
1000: 
1001:         *-- Shape3: destaque info modo teclado
1002:         loc_oPg3.AddObject("shp_4c_LeitorInfo", "Shape")
1003:         WITH loc_oPg3.shp_4c_LeitorInfo
1004:             .Top           = 245
1005:             .Left          = 705
1006:             .Width         = 95
1007:             .Height        = 36
1008:             .SpecialEffect = 1
1009:             .BackColor     = RGB(255, 255, 200)
1010:             .BorderColor   = RGB(160, 160, 160)
1011:             .Visible       = .T.
1012:         ENDWITH
1013: 
1014:         loc_oPg3.AddObject("lbl_4c_ModoLeitura", "Label")
1015:         WITH loc_oPg3.lbl_4c_ModoLeitura
1016:             .Top       = 250
1017:             .Left      = 710
1018:             .Width     = 85
1019:             .Height    = 28
1020:             .Caption   = "Leitura" + CHR(13) + "pelo Teclado"
1021:             .FontName  = "Arial"
1022:             .FontSize  = 8
1023:             .FontBold  = .T.
1024:             .ForeColor = RGB(0, 0, 128)
1025:             .BackStyle = 0
1026:             .AutoSize  = .F.
1027:             .Visible   = .T.
1028:         ENDWITH
1029: 
1030:         *-- ShpComm: area porta serial (hardware nao portado - apenas visual)
1031:         loc_oPg3.AddObject("shp_4c_PortaComm", "Shape")
1032:         WITH loc_oPg3.shp_4c_PortaComm
1033:             .Top           = 285
1034:             .Left          = 684
1035:             .Width         = 138
1036:             .Height        = 55
1037:             .SpecialEffect = 1
1038:             .BackColor     = RGB(200, 200, 200)
1039:             .BorderColor   = RGB(128, 128, 128)
1040:             .Visible       = .T.
1041:         ENDWITH
1042: 
1043:         *-- Comm_Ini / Comm_Fim: invisiveis (serial port nao portado)
1044:         loc_oPg3.AddObject("img_4c_CommIni", "Image")
1045:         WITH loc_oPg3.img_4c_CommIni
1046:             .Top     = 290
1047:             .Left    = 689
1048:             .Width   = 60
1049:             .Height  = 45
1050:             .Visible = .F.
1051:         ENDWITH
1052: 
1053:         loc_oPg3.AddObject("img_4c_CommFim", "Image")
1054:         WITH loc_oPg3.img_4c_CommFim
1055:             .Top     = 290
1056:             .Left    = 753
1057:             .Width   = 60
1058:             .Height  = 45
1059:             .Visible = .F.
1060:         ENDWITH
1061: 
1062:         *======================================================
1063:         * 5. Area de entrada manual de cheques (ShpLeitura)
1064:         *======================================================
1065:         loc_oPg3.AddObject("shp_4c_EntradaManual", "Shape")
1066:         WITH loc_oPg3.shp_4c_EntradaManual
1067:             .Top           = 345
1068:             .Left          = 167
1069:             .Width         = 192
1070:             .Height        = 192
1071:             .SpecialEffect = 1
1072:             .BackColor     = RGB(236, 233, 216)
1073:             .BorderColor   = RGB(160, 160, 160)
1074:             .Visible       = .T.
1075:         ENDWITH
1076: 
1077:         *-- Say13: titulo da area de entrada
1078:         loc_oPg3.AddObject("lbl_4c_Cheque", "Label")
1079:         WITH loc_oPg3.lbl_4c_Cheque
1080:             .Top       = 351
1081:             .Left      = 175
1082:             .Width     = 170
1083:             .Height    = 16
1084:             .Caption   = "Informa" + CHR(231) + CHR(227) + "o do Cheque"
1085:             .FontName  = "Arial"
1086:             .FontSize  = 8
1087:             .FontBold  = .T.
1088:             .ForeColor = RGB(0, 0, 128)
1089:             .BackStyle = 0
1090:             .AutoSize  = .F.
1091:             .Visible   = .T.
1092:         ENDWITH
1093: 
1094:         *-- Banco
1095:         loc_oPg3.AddObject("lbl_4c_LBco", "Label")
1096:         WITH loc_oPg3.lbl_4c_LBco
1097:             .Top       = 376
1098:             .Left      = 175
1099:             .Width     = 75
1100:             .Height    = 16
1101:             .Caption   = "Banco:"
1102:             .FontName  = "Arial"
1103:             .FontSize  = 8
1104:             .BackStyle = 0
1105:             .AutoSize  = .F.
1106:             .Visible   = .T.
1107:         ENDWITH
1108: 
1109:         loc_oPg3.AddObject("txt_4c_Bco", "TextBox")
1110:         WITH loc_oPg3.txt_4c_Bco
1111:             .Top         = 373
1112:             .Left        = 253
1113:             .Width       = 35
1114:             .Height      = 22
1115:             .MaxLength   = 10
1116:             .BorderStyle = 1
1117:             .FontName    = "Arial"
1118:             .FontSize    = 9
1119:             .Visible     = .T.
1120:         ENDWITH
1121: 
1122:         *-- Agencia
1123:         loc_oPg3.AddObject("lbl_4c_LAge", "Label")
1124:         WITH loc_oPg3.lbl_4c_LAge
1125:             .Top       = 402
1126:             .Left      = 175
1127:             .Width     = 75
1128:             .Height    = 16
1129:             .Caption   = "Ag" + CHR(234) + "ncia:"
1130:             .FontName  = "Arial"
1131:             .FontSize  = 8
1132:             .BackStyle = 0
1133:             .AutoSize  = .F.
1134:             .Visible   = .T.
1135:         ENDWITH
1136: 
1137:         loc_oPg3.AddObject("txt_4c_Age", "TextBox")
1138:         WITH loc_oPg3.txt_4c_Age
1139:             .Top         = 399
1140:             .Left        = 253
1141:             .Width       = 45
1142:             .Height      = 22
1143:             .MaxLength   = 10
1144:             .BorderStyle = 1
1145:             .FontName    = "Arial"
1146:             .FontSize    = 9
1147:             .Visible     = .T.
1148:         ENDWITH
1149: 
1150:         *-- Conta
1151:         loc_oPg3.AddObject("lbl_4c_LContaLei", "Label")
1152:         WITH loc_oPg3.lbl_4c_LContaLei
1153:             .Top       = 428
1154:             .Left      = 175
1155:             .Width     = 75
1156:             .Height    = 16
1157:             .Caption   = "Conta:"
1158:             .FontName  = "Arial"
1159:             .FontSize  = 8
1160:             .BackStyle = 0
1161:             .AutoSize  = .F.
1162:             .Visible   = .T.
1163:         ENDWITH
1164: 
1165:         loc_oPg3.AddObject("txt_4c_ContaLei", "TextBox")
1166:         WITH loc_oPg3.txt_4c_ContaLei
1167:             .Top         = 425
1168:             .Left        = 253
1169:             .Width       = 80
1170:             .Height      = 22
1171:             .MaxLength   = 10
1172:             .BorderStyle = 1
1173:             .FontName    = "Arial"
1174:             .FontSize    = 9
1175:             .Visible     = .T.
1176:         ENDWITH
1177: 
1178:         *-- Numero do cheque (LostFocus dispara validacao e insercao)
1179:         loc_oPg3.AddObject("lbl_4c_LNum", "Label")
1180:         WITH loc_oPg3.lbl_4c_LNum
1181:             .Top       = 454
1182:             .Left      = 175
1183:             .Width     = 75
1184:             .Height    = 16
1185:             .Caption   = "N" + CHR(250) + "mero:"
1186:             .FontName  = "Arial"
1187:             .FontSize  = 8
1188:             .BackStyle = 0
1189:             .AutoSize  = .F.
1190:             .Visible   = .T.
1191:         ENDWITH
1192: 
1193:         loc_oPg3.AddObject("txt_4c_Num", "TextBox")
1194:         WITH loc_oPg3.txt_4c_Num
1195:             .Top         = 451
1196:             .Left        = 253
1197:             .Width       = 50
1198:             .Height      = 22
1199:             .MaxLength   = 10
1200:             .BorderStyle = 1
1201:             .FontName    = "Arial"
1202:             .FontSize    = 9
1203:             .Visible     = .T.
1204:         ENDWITH
1205:         BINDEVENT(loc_oPg3.txt_4c_Num, "KeyPress", THIS, "NumGetLostFocus")
1206: 
1207:         *-- Valor (readonly - preenchido pela validacao)
1208:         loc_oPg3.AddObject("lbl_4c_LValor", "Label")
1209:         WITH loc_oPg3.lbl_4c_LValor
1210:             .Top       = 480
1211:             .Left      = 175
1212:             .Width     = 75
1213:             .Height    = 16
1214:             .Caption   = "Valor:"
1215:             .FontName  = "Arial"
1216:             .FontSize  = 8
1217:             .BackStyle = 0
1218:             .AutoSize  = .F.
1219:             .Visible   = .T.
1220:         ENDWITH
1221: 
1222:         loc_oPg3.AddObject("txt_4c_Valor", "TextBox")
1223:         WITH loc_oPg3.txt_4c_Valor
1224:             .Top         = 477
1225:             .Left        = 253
1226:             .Width       = 70
1227:             .Height      = 22
1228:             .ReadOnly    = .T.
1229:             .BackColor   = RGB(220, 220, 220)
1230:             .BorderStyle = 1
1231:             .FontName    = "Arial"
1232:             .FontSize    = 9
1233:             .Visible     = .T.
1234:         ENDWITH
1235: 
1236:         *-- Vencimento (readonly - preenchido pela validacao)
1237:         loc_oPg3.AddObject("lbl_4c_LVecto", "Label")
1238:         WITH loc_oPg3.lbl_4c_LVecto
1239:             .Top       = 506
1240:             .Left      = 175
1241:             .Width     = 75
1242:             .Height    = 16
1243:             .Caption   = "Vencto:"
1244:             .FontName  = "Arial"
1245:             .FontSize  = 8
1246:             .BackStyle = 0
1247:             .AutoSize  = .F.
1248:             .Visible   = .T.
1249:         ENDWITH
1250: 
1251:         loc_oPg3.AddObject("txt_4c_Vecto", "TextBox")
1252:         WITH loc_oPg3.txt_4c_Vecto
1253:             .Top         = 503
1254:             .Left        = 253
1255:             .Width       = 70
1256:             .Height      = 22
1257:             .ReadOnly    = .T.
1258:             .BackColor   = RGB(220, 220, 220)
1259:             .BorderStyle = 1

*-- Linhas 1269 a 1278:
1269:         loc_oPg3.AddObject("grd_4c_Leitura", "GridBase")
1270:         loc_oGrid = loc_oPg3.grd_4c_Leitura
1271:         WITH loc_oGrid
1272:             .Top           = 345
1273:             .Left          = 357
1274:             .Width         = 475
1275:             .Height        = 192
1276:             .ReadOnly      = .T.
1277:             .RecordMark    = .F.
1278:             .DeleteMark    = .F.

*-- Linhas 1300 a 1410:
1300:             .ReadOnly      = .T.
1301:             .Resizable     = .T.
1302:         ENDWITH
1303:         loc_oGrid.Column1.Header1.Caption = "Banco"
1304: 
1305:         WITH loc_oGrid.Column2
1306:             .Width         = 55
1307:             .ReadOnly      = .T.
1308:             .Resizable     = .T.
1309:         ENDWITH
1310:         loc_oGrid.Column2.Header1.Caption = "Ag" + CHR(234) + "ncia"
1311: 
1312:         WITH loc_oGrid.Column3
1313:             .Width         = 70
1314:             .ReadOnly      = .T.
1315:             .Resizable     = .T.
1316:         ENDWITH
1317:         loc_oGrid.Column3.Header1.Caption = "N" + CHR(186) + " Conta"
1318: 
1319:         WITH loc_oGrid.Column4
1320:             .Width         = 70
1321:             .ReadOnly      = .T.
1322:             .Resizable     = .T.
1323:         ENDWITH
1324:         loc_oGrid.Column4.Header1.Caption = "N" + CHR(186) + " Cheque"
1325: 
1326:         WITH loc_oGrid.Column5
1327:             .Width         = 75
1328:             .ReadOnly      = .T.
1329:             .Resizable     = .T.
1330:         ENDWITH
1331:         loc_oGrid.Column5.Header1.Caption = "Vencimento"
1332: 
1333:         WITH loc_oGrid.Column6
1334:             .Width         = 80
1335:             .ReadOnly      = .T.
1336:             .Resizable     = .T.
1337:         ENDWITH
1338:         loc_oGrid.Column6.Header1.Caption = "Valor"
1339: 
1340:         *======================================================
1341:         * 7. Botoes de acao da leitura (posicionados diretamente em Page3)
1342:         *    Left absoluto: Excluir=773, Gravar=848, Encerrar=923
1343:         *======================================================
1344:         loc_oPg3.AddObject("cmd_4c_Excluir", "CommandButton")
1345:         WITH loc_oPg3.cmd_4c_Excluir
1346:             .Top             = 36
1347:             .Left            = 773
1348:             .Width           = 75
1349:             .Height          = 75
1350:             .Caption         = "Excluir"
1351:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1352:             .PicturePosition = 13
1353:             .FontName        = "Comic Sans MS"
1354:             .FontBold        = .T.
1355:             .FontItalic      = .T.
1356:             .FontSize        = 8
1357:             .ForeColor       = RGB(90, 90, 90)
1358:             .BackColor       = RGB(255, 255, 255)
1359:             .Themes          = .F.
1360:             .SpecialEffect   = 0
1361:             .Visible         = .T.
1362:         ENDWITH
1363:         BINDEVENT(loc_oPg3.cmd_4c_Excluir, "Click", THIS, "BtnExcluirHistoricoClick")
1364: 
1365:         loc_oPg3.AddObject("cmd_4c_Confirmar", "CommandButton")
1366:         WITH loc_oPg3.cmd_4c_Confirmar
1367:             .Top             = 36
1368:             .Left            = 848
1369:             .Width           = 75
1370:             .Height          = 75
1371:             .Caption         = "Gravar"
1372:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1373:             .PicturePosition = 13
1374:             .FontName        = "Comic Sans MS"
1375:             .FontBold        = .T.
1376:             .FontItalic      = .T.
1377:             .FontSize        = 8
1378:             .ForeColor       = RGB(90, 90, 90)
1379:             .BackColor       = RGB(255, 255, 255)
1380:             .Themes          = .F.
1381:             .SpecialEffect   = 0
1382:             .Visible         = .T.
1383:         ENDWITH
1384:         BINDEVENT(loc_oPg3.cmd_4c_Confirmar, "Click", THIS, "BtnGravarLeituraClick")
1385: 
1386:         loc_oPg3.AddObject("cmd_4c_Cancelar", "CommandButton")
1387:         WITH loc_oPg3.cmd_4c_Cancelar
1388:             .Top             = 36
1389:             .Left            = 923
1390:             .Width           = 75
1391:             .Height          = 75
1392:             .Caption         = "Encerrar"
1393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1394:             .PicturePosition = 13
1395:             .FontName        = "Comic Sans MS"
1396:             .FontBold        = .T.
1397:             .FontItalic      = .T.
1398:             .FontSize        = 8
1399:             .ForeColor       = RGB(90, 90, 90)
1400:             .BackColor       = RGB(255, 255, 255)
1401:             .Themes          = .F.
1402:             .SpecialEffect   = 0
1403:             .Visible         = .T.
1404:         ENDWITH
1405:         BINDEVENT(loc_oPg3.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarLeituraClick")
1406: 
1407:         THIS.TornarControlesVisiveis(loc_oPg3)
1408:     ENDPROC
1409: 
1410:     *--------------------------------------------------------------------------

*-- Linhas 1439 a 1452:
1439:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1440: 
1441:                         *-- Reconfigurar headers (RecordSource reseta captions)
1442:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1443:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1444:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1445:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1446:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1447:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1448: 
1449:                         THIS.FormatarGridLista(loc_oGrid)
1450:                     ENDIF
1451:                     loc_lResultado = .T.
1452:                 ENDIF

*-- Linhas 1643 a 1651:
1643:     ENDPROC
1644: 
1645:     *--------------------------------------------------------------------------
1646:     * BtnSalvarClick - Salva registro (cmd_4c_Confirmar em Page2)
1647:     *--------------------------------------------------------------------------
1648:     PROCEDURE BtnSalvarClick()
1649:         LOCAL loc_oPg2
1650:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1651: 

*-- Linhas 1903 a 1912:
1903:         ENDIF
1904: 
1905:         IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
1906:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
1907:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
1908:             ENDIF
1909:         ENDIF
1910:     ENDPROC
1911: 
1912:     *--------------------------------------------------------------------------

*-- Linhas 1956 a 1983:
1956:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1957: 
1958:         IF VARTYPE(loc_oBotoes) = "O"
1959:             IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"
1960:                 loc_oBotoes.cmd_4c_Incluir.Enabled = .T.
1961:             ENDIF
1962:             IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O"
1963:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
1964:             ENDIF
1965:             IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"
1966:                 loc_oBotoes.cmd_4c_Alterar.Enabled = .T.
1967:             ENDIF
1968:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
1969:                 loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
1970:             ENDIF
1971:             IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"
1972:                 loc_oBotoes.cmd_4c_Buscar.Enabled = .T.
1973:             ENDIF
1974:         ENDIF
1975: 
1976:         IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
1977:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
1978:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
1979:             ENDIF
1980:         ENDIF
1981:     ENDPROC
1982: 
1983:     *--------------------------------------------------------------------------

*-- Linhas 2024 a 2041:
2024:                 loc_oPg2.txt_4c_Codigo.Value      = TRANSFORM(.this_nCodigos)
2025:             ENDIF
2026:             IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2027:                 loc_oPg2.cbo_4c_Operacao.Value    = .this_nTipos
2028:             ENDIF
2029:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2030:                 loc_oPg2.txt_4c_Oper.Value        = ALLTRIM(.this_cOperacaos)
2031:             ENDIF
2032:             IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2033:                 loc_oPg2.txt_4c_DataInicial.Value = .this_dDataInis
2034:             ENDIF
2035:             IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2036:                 loc_oPg2.txt_4c_DataFinal.Value   = .this_dDataFims
2037:             ENDIF
2038:             IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2039:                 loc_oPg2.txt_4c_Grupo.Value       = ALLTRIM(.this_cGrupos)
2040:             ENDIF
2041:             IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"

*-- Linhas 2501 a 2512:
2501:                 loc_oPg3.txt_4c_OperDisp.Value   = ALLTRIM(.this_cOperacaos)
2502:             ENDIF
2503:             IF VARTYPE(loc_oPg3.txt_4c_DataIniDisp) = "O"
2504:                 loc_oPg3.txt_4c_DataIniDisp.Value = .this_dDataInis
2505:             ENDIF
2506:             IF VARTYPE(loc_oPg3.txt_4c_DataFimDisp) = "O"
2507:                 loc_oPg3.txt_4c_DataFimDisp.Value = .this_dDataFims
2508:             ENDIF
2509:             IF VARTYPE(loc_oPg3.txt_4c_GrupoDisp) = "O"
2510:                 loc_oPg3.txt_4c_GrupoDisp.Value  = ALLTRIM(.this_cGrupos)
2511:             ENDIF
2512:             IF VARTYPE(loc_oPg3.txt_4c_ContaDisp) = "O"


### BO (C:\4c\projeto\app\classes\BchBO.prg):
*====================================================================
* BchBO.prg
*
* Business Object para Balanco de Cheques
* Tabela: SigCdBch
* PK: Codigos (numeric 6,0)
*
* Colunas (schema.sql):
*   operacaos  char(15)      NOT NULL
*   codigos    numeric(6,0)  NOT NULL  <- PK
*   datafims   datetime      NULL
*   datainis   datetime      NULL
*   encerras   bit           NOT NULL
*   tipos      numeric(1,0)  NOT NULL
*   grupos     char(10)      NOT NULL
*   contas     char(10)      NOT NULL
*   grvs       bit           NOT NULL
*====================================================================

DEFINE CLASS BchBO AS BusinessBase

	*-- Propriedades da tabela SigCdBch
	this_nCodigos  = 0
	this_cOperacaos = ""
	this_dDataInis = {}
	this_dDataFims = {}
	this_lEncerras = .F.
	this_nTipos    = 0
	this_cGrupos   = ""
	this_cContas   = ""
	this_lGrvs     = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdBch"
			THIS.this_cCampoChave = "Codigos"
			loc_lResultado = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Busca registros de SigCdBch
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cWhere = " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch" + loc_cWhere + " ORDER BY codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros de Balan" + CHR(231) + "o de Cheques: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_nCodigos   = TratarNulo(codigos,   "N")
				THIS.this_cOperacaos = TratarNulo(operacaos, "C")
				THIS.this_dDataInis  = TratarNulo(datainis,  "D")
				THIS.this_dDataFims  = TratarNulo(datafims,  "D")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				THIS.this_cGrupos    = TratarNulo(grupos,    "C")
				THIS.this_cContas    = TratarNulo(contas,    "C")
				THIS.this_lEncerras  = ConverterParaLogico(encerras)
				THIS.this_lGrvs      = ConverterParaLogico(grvs)
				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nNovoCodigo
		loc_lResultado = .F.

		TRY
			*-- Gerar novo codigo (PK)
			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT ISNULL(MAX(codigos),0)+1 AS proximo FROM SigCdBch", ;
				"cursor_4c_ProxCod")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nNovoCodigo = proximo
			ELSE
				loc_nNovoCodigo = 1
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF

			THIS.this_nCodigos = loc_nNovoCodigo

			loc_cSQL = "INSERT INTO SigCdBch" + ;
					   " (codigos, operacaos, datainis, datafims, tipos," + ;
					   "  grupos, contas, encerras, grvs)" + ;
					   " VALUES (" + ;
					   FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   IIF(THIS.this_lGrvs, "1", "0") + ;
					   ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET" + ;
					   " operacaos = " + EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   " datainis  = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   " datafims  = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   " tipos     = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   " grupos    = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   " contas    = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   " encerras  = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   " grvs      = " + IIF(THIS.this_lGrvs, "1", "0") + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdBch
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
					"vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			THIS.RegistrarAuditoria("DELETE")

			loc_cSQL = "DELETE FROM SigCdBch WHERE codigos = " + ;
					   FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* EncerrarBalanco - Encerra o balanco de cheques (DataFims + Encerras=.T.)
	*====================================================================
	PROCEDURE EncerrarBalanco()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("Balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "UPDATE SigCdBch SET datafims = GETDATE(), encerras = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lEncerras = .T.
				THIS.this_dDataFims = DATE()
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao encerrar balan" + CHR(231) + "o: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* MarcarGravado - Define Grvs=1 em SigCdBch apos gravar leitura
	*====================================================================
	PROCEDURE MarcarGravado()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET grvs = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lGrvs = .T.
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao marcar gravado: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

