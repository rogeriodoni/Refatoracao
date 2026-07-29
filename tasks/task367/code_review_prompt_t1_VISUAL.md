# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 197: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 221: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 269: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 293: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 330: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 502: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 526: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formche.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3329 linhas total):

*-- Linhas 69 a 78:
69:             ELSE
70:                 THIS.ConfigurarPageFrame()
71: 
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 THIS.pgf_4c_Paginas.Visible    = .T.
76:                 THIS.pgf_4c_Paginas.ActivePage = 1
77:                 THIS.this_cModoAtual = "LISTA"
78: 

*-- Linhas 99 a 435:
99: 
100:         WITH loc_oPgf
101:             .PageCount = 2
102:             .Top       = -29
103:             .Left      = 0
104:             .Width     = THIS.Width
105:             .Height    = THIS.Height + 29
106:             .Tabs      = .F.
107:             .Visible   = .T.
108:             .Page1.Caption   = "Lista"
109:             .Page1.BackColor = RGB(100, 100, 100)
110:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.Caption   = "Dados"
112:             .Page2.BackColor = RGB(100, 100, 100)
113:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:         ENDWITH
115: 
116:         THIS.ConfigurarPaginaLista()
117:         THIS.ConfigurarPaginaDados()
118:     ENDPROC
119: 
120:     *--------------------------------------------------------------------------
121:     * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + filtros + grid
122:     * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
123:     *--------------------------------------------------------------------------
124:     PROTECTED PROCEDURE ConfigurarPaginaLista()
125:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oFiltros, loc_oGrid
126: 
127:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
128: 
129:         *-- Cabecalho cinza (Top=2+29=31)
130:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
131:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
132:         WITH loc_oCab
133:             .Top         = 31
134:             .Left        = 0
135:             .Width       = THIS.Width
136:             .Height      = 80
137:             .BackColor   = RGB(100, 100, 100)
138:             .BorderWidth = 0
139:             .Visible     = .T.
140:         ENDWITH
141: 
142:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
143:         WITH loc_oCab.lbl_4c_Sombra
144:             .Caption   = THIS.Caption
145:             .AutoSize  = .F.
146:             .Width     = THIS.Width
147:             .Height    = 40
148:             .Top       = 15
149:             .Left      = 10
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.
153:             .ForeColor = RGB(0, 0, 0)
154:             .BackStyle = 0
155:             .Visible   = .T.
156:         ENDWITH
157: 
158:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
159:         WITH loc_oCab.lbl_4c_Titulo
160:             .Caption   = THIS.Caption
161:             .AutoSize  = .F.
162:             .Width     = THIS.Width
163:             .Height    = 46
164:             .Top       = 18
165:             .Left      = 10
166:             .FontName  = "Tahoma"
167:             .FontSize  = 16
168:             .FontBold  = .T.
169:             .ForeColor = RGB(255, 255, 255)
170:             .BackStyle = 0
171:             .Visible   = .T.
172:         ENDWITH
173: 
174:         *-- Container botoes CRUD (Top=0+29=29, Left=542)
175:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
176:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
177:         WITH loc_oBotoes
178:             .Top         = 29
179:             .Left        = 542
180:             .Width       = 390
181:             .Height      = 85
182:             .BackStyle   = 1
183:             .BackColor   = RGB(53, 53, 53)
184:             .BorderWidth = 0
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
189:         WITH loc_oBotoes.cmd_4c_Incluir
190:             .Top             = 5
191:             .Left            = 5
192:             .Width           = 75
193:             .Height          = 75
194:             .Caption         = "Incluir"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
196:             .PicturePosition = 13
197:             .FontName        = "Comic Sans MS"
198:             .FontBold        = .T.
199:             .FontItalic      = .T.
200:             .FontSize        = 8
201:             .ForeColor       = RGB(90, 90, 90)
202:             .BackColor       = RGB(255, 255, 255)
203:             .Themes          = .F.
204:             .SpecialEffect   = 0
205:             .WordWrap        = .T.
206:             .AutoSize        = .F.
207:             .MousePointer    = 15
208:             .Visible         = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
211: 
212:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
213:         WITH loc_oBotoes.cmd_4c_Visualizar
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .Caption         = "Visualizar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
220:             .PicturePosition = 13
221:             .FontName        = "Comic Sans MS"
222:             .FontBold        = .T.
223:             .FontItalic      = .T.
224:             .FontSize        = 8
225:             .ForeColor       = RGB(90, 90, 90)
226:             .BackColor       = RGB(255, 255, 255)
227:             .Themes          = .F.
228:             .SpecialEffect   = 0
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:             .MousePointer    = 15
232:             .Visible         = .T.
233:         ENDWITH
234:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
235: 
236:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
237:         WITH loc_oBotoes.cmd_4c_Alterar
238:             .Top             = 5
239:             .Left            = 155
240:             .Width           = 75
241:             .Height          = 75
242:             .Caption         = "Alterar"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .FontName        = "Comic Sans MS"
246:             .FontBold        = .T.
247:             .FontItalic      = .T.
248:             .FontSize        = 8
249:             .ForeColor       = RGB(90, 90, 90)
250:             .BackColor       = RGB(255, 255, 255)
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:             .MousePointer    = 15
256:             .Visible         = .T.
257:         ENDWITH
258:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
259: 
260:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
261:         WITH loc_oBotoes.cmd_4c_Excluir
262:             .Top             = 5
263:             .Left            = 230
264:             .Width           = 75
265:             .Height          = 75
266:             .Caption         = "Excluir"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
268:             .PicturePosition = 13
269:             .FontName        = "Comic Sans MS"
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .FontSize        = 8
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:             .MousePointer    = 15
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
283: 
284:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
285:         WITH loc_oBotoes.cmd_4c_Buscar
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .Caption         = "Buscar"
291:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
292:             .PicturePosition = 13
293:             .FontName        = "Comic Sans MS"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .FontSize        = 8
297:             .ForeColor       = RGB(90, 90, 90)
298:             .BackColor       = RGB(255, 255, 255)
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .WordWrap        = .T.
302:             .AutoSize        = .F.
303:             .MousePointer    = 15
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
307: 
308:         *-- Container Saida canonico (Left=917, Width=90, Top=29)
309:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
310:         loc_oSaida = loc_oPg1.cnt_4c_Saida
311:         WITH loc_oSaida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle   = 0
317:             .BorderWidth = 0
318:             .Visible     = .T.
319:         ENDWITH
320: 
321:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
322:         WITH loc_oSaida.cmd_4c_Encerrar
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .Caption         = "Encerrar"
328:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
329:             .PicturePosition = 13
330:             .FontName        = "Comic Sans MS"
331:             .FontBold        = .T.
332:             .FontItalic      = .T.
333:             .FontSize        = 8
334:             .ForeColor       = RGB(90, 90, 90)
335:             .BackColor       = RGB(255, 255, 255)
336:             .Themes          = .F.
337:             .SpecialEffect   = 0
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Container filtros de periodo (original: cntFiltros, top=82+29=111)
343:         loc_oPg1.AddObject("cnt_4c_Filtros", "Container")
344:         loc_oFiltros = loc_oPg1.cnt_4c_Filtros
345:         WITH loc_oFiltros
346:             .Top         = 111
347:             .Left        = 2
348:             .Width       = 420
349:             .Height      = 40
350:             .BackStyle   = 0
351:             .BorderWidth = 0
352:             .Visible     = .T.
353:         ENDWITH
354: 
355:         loc_oFiltros.AddObject("lbl_4c_Periodo", "Label")
356:         WITH loc_oFiltros.lbl_4c_Periodo
357:             .Caption   = "Per" + CHR(237) + "odo : "
358:             .Top       = 10
359:             .Left      = 12
360:             .Width     = 48
361:             .Height    = 15
362:             .FontName  = "Tahoma"
363:             .FontSize  = 8
364:             .ForeColor = RGB(255, 255, 255)
365:             .BackStyle = 0
366:             .Visible   = .T.
367:         ENDWITH
368: 
369:         loc_oFiltros.AddObject("txt_4c_DtInicial", "TextBox")
370:         WITH loc_oFiltros.txt_4c_DtInicial
371:             .Top         = 6
372:             .Left        = 62
373:             .Width       = 80
374:             .Height      = 23
375:             .Value       = {}
376:             .Format      = "D"
377:             .FontName    = "Tahoma"
378:             .FontSize    = 8
379:             .BorderStyle = 1
380:             .Visible     = .T.
381:         ENDWITH
382:         BINDEVENT(loc_oFiltros.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
383: 
384:         loc_oFiltros.AddObject("lbl_4c_Sep", "Label")
385:         WITH loc_oFiltros.lbl_4c_Sep
386:             .Caption   = "a"
387:             .Top       = 10
388:             .Left      = 149
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .ForeColor = RGB(255, 255, 255)
392:             .BackStyle = 0
393:             .Visible   = .T.
394:         ENDWITH
395: 
396:         loc_oFiltros.AddObject("txt_4c_DtFinal", "TextBox")
397:         WITH loc_oFiltros.txt_4c_DtFinal
398:             .Top         = 6
399:             .Left        = 162
400:             .Width       = 80
401:             .Height      = 23
402:             .Value       = {}
403:             .Format      = "D"
404:             .FontName    = "Tahoma"
405:             .FontSize    = 8
406:             .BorderStyle = 1
407:             .Visible     = .T.
408:         ENDWITH
409:         BINDEVENT(loc_oFiltros.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
410: 
411:         *-- Botao LimpaDT: original top=85+29=114, left=290 (Limpar Data Transporte)
412:         loc_oPg1.AddObject("cmd_4c_LimpaDT", "CommandButton")
413:         WITH loc_oPg1.cmd_4c_LimpaDT
414:             .Top         = 114
415:             .Left        = 290
416:             .Width       = 120
417:             .Height      = 40
418:             .Caption     = "Limpar Data"
419:             .FontName    = "Tahoma"
420:             .FontSize    = 8
421:             .Visible     = .T.
422:         ENDWITH
423:         BINDEVENT(loc_oPg1.cmd_4c_LimpaDT, "Click", THIS, "BtnLimpaDTClick")
424: 
425:         *-- Grid lista de lotes (grd_4c_Dados) - RecordSource definido em CarregarLista
426:         *-- ColumnCount e RecordSource FORA do WITH (Problema 36)
427:         loc_oPg1.AddObject("grd_4c_Dados", "Grid")
428:         loc_oGrid             = loc_oPg1.grd_4c_Dados
429:         loc_oGrid.Top         = 156
430:         loc_oGrid.Left        = 2
431:         loc_oGrid.Width       = 910
432:         loc_oGrid.Height      = 385
433:         loc_oGrid.ColumnCount = 6
434: 
435:         WITH loc_oGrid

*-- Linhas 457 a 470:
457:             .Column5.Width      = 100
458:             .Column5.Alignment  = 1
459:             .Column6.Width      = 100
460:             .Column1.Header1.Caption = "Lote"
461:             .Column2.Header1.Caption = "Data"
462:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
463:             .Column4.Header1.Caption = "Total"
464:             .Column5.Header1.Caption = "Juros"
465:             .Column6.Header1.Caption = "Dt. Transporte"
466:         ENDWITH
467: 
468:         THIS.TornarControlesVisiveis(loc_oPg1)
469:     ENDPROC
470: 

*-- Linhas 482 a 989:
482:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
483:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
484:         WITH loc_oBotoesAcao
485:             .Top         = 33
486:             .Left        = 842
487:             .Width       = 160
488:             .Height      = 85
489:             .BackStyle   = 0
490:             .Visible     = .T.
491:         ENDWITH
492: 
493:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
494:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
495:             .Top             = 5
496:             .Left            = 5
497:             .Width           = 75
498:             .Height          = 75
499:             .Caption         = "Confirmar"
500:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
501:             .PicturePosition = 13
502:             .FontName        = "Comic Sans MS"
503:             .FontBold        = .T.
504:             .FontItalic      = .T.
505:             .FontSize        = 8
506:             .ForeColor       = RGB(90, 90, 90)
507:             .BackColor       = RGB(255, 255, 255)
508:             .Themes          = .F.
509:             .SpecialEffect   = 0
510:             .WordWrap        = .T.
511:             .AutoSize        = .F.
512:             .MousePointer    = 15
513:             .Visible         = .T.
514:         ENDWITH
515:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
516: 
517:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
518:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
519:             .Top             = 5
520:             .Left            = 80
521:             .Width           = 75
522:             .Height          = 75
523:             .Caption         = "Encerrar"
524:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
525:             .PicturePosition = 13
526:             .FontName        = "Comic Sans MS"
527:             .FontBold        = .T.
528:             .FontItalic      = .T.
529:             .FontSize        = 8
530:             .ForeColor       = RGB(90, 90, 90)
531:             .BackColor       = RGB(255, 255, 255)
532:             .Themes          = .F.
533:             .SpecialEffect   = 0
534:             .WordWrap        = .T.
535:             .AutoSize        = .F.
536:             .MousePointer    = 15
537:             .Visible         = .T.
538:         ENDWITH
539:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
540: 
541:         *-- Botao Imprime (top=4+29=33, left=696, original: 75x75)
542:         loc_oPg2.AddObject("cmd_4c_Imprime", "CommandButton")
543:         WITH loc_oPg2.cmd_4c_Imprime
544:             .Top           = 33
545:             .Left          = 696
546:             .Width         = 75
547:             .Height        = 75
548:             .Caption       = "\<Relat" + CHR(243) + "rio"
549:             .FontName      = "Tahoma"
550:             .FontBold      = .T.
551:             .FontSize      = 8
552:             .ForeColor     = RGB(90, 90, 90)
553:             .BackColor     = RGB(255, 255, 255)
554:             .Themes        = .F.
555:             .SpecialEffect = 0
556:             .Visible       = .T.
557:         ENDWITH
558:         BINDEVENT(loc_oPg2.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")
559: 
560:         *-- Botao Protocolo (hidden, top=4+29=33, left=771)
561:         loc_oPg2.AddObject("cmd_4c_Protocolos", "CommandButton")
562:         WITH loc_oPg2.cmd_4c_Protocolos
563:             .Top     = 33
564:             .Left    = 771
565:             .Width   = 75
566:             .Height  = 75
567:             .Caption = "\<Protocolo"
568:             .FontName = "Tahoma"
569:             .FontSize = 8
570:             .Visible  = .F.
571:         ENDWITH
572: 
573:         *-- Shapes decorativos (top=8+29=37)
574:         loc_oPg2.AddObject("shp_4c_Shape1", "Shape")
575:         WITH loc_oPg2.shp_4c_Shape1
576:             .Top         = 37
577:             .Left        = 9
578:             .Width       = 620
579:             .Height      = 112
580:             .BackStyle   = 0
581:             .BorderColor = RGB(150, 150, 150)
582:             .Visible     = .T.
583:         ENDWITH
584: 
585:         loc_oPg2.AddObject("shp_4c_Shape2", "Shape")
586:         WITH loc_oPg2.shp_4c_Shape2
587:             .Top         = 37
588:             .Left        = 719
589:             .Width       = 92
590:             .Height      = 53
591:             .BackStyle   = 0
592:             .BorderColor = RGB(150, 150, 150)
593:             .Visible     = .T.
594:         ENDWITH
595: 
596:         *-- Lote (readonly): lbl_4c_Label3 (top=19+29=48), txt_4c_Lote (top=15+29=44)
597:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
598:         WITH loc_oPg2.lbl_4c_Label3
599:             .Caption   = "Lote :"
600:             .Top       = 48
601:             .Left      = 79
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .ForeColor = RGB(255, 255, 255)
605:             .BackStyle = 0
606:             .AutoSize  = .T.
607:             .Visible   = .T.
608:         ENDWITH
609: 
610:         loc_oPg2.AddObject("txt_4c_Lote", "TextBox")
611:         WITH loc_oPg2.txt_4c_Lote
612:             .Top         = 44
613:             .Left        = 111
614:             .Width       = 64
615:             .Height      = 23
616:             .Value       = 0
617:             .ReadOnly    = .T.
618:             .FontName    = "Tahoma"
619:             .FontSize    = 8
620:             .BorderStyle = 1
621:             .Visible     = .T.
622:         ENDWITH
623: 
624:         *-- Data Base: lbl_4c_DataBase (top=19+29=48), txt_4c_Data (top=15+29=44)
625:         loc_oPg2.AddObject("lbl_4c_DataBase", "Label")
626:         WITH loc_oPg2.lbl_4c_DataBase
627:             .Caption   = "Data Base :"
628:             .Top       = 48
629:             .Left      = 191
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .ForeColor = RGB(255, 255, 255)
633:             .BackStyle = 0
634:             .AutoSize  = .T.
635:             .Visible   = .T.
636:         ENDWITH
637: 
638:         loc_oPg2.AddObject("txt_4c_Data", "TextBox")
639:         WITH loc_oPg2.txt_4c_Data
640:             .Top         = 44
641:             .Left        = 251
642:             .Width       = 77
643:             .Height      = 23
644:             .Value       = {}
645:             .Format      = "D"
646:             .FontName    = "Tahoma"
647:             .FontSize    = 8
648:             .BorderStyle = 1
649:             .Visible     = .T.
650:         ENDWITH
651: 
652:         *-- Data do Movimento (readonly): lbl_4c_Label22 (top=19+29=48), txt_4c_DtMovs (top=15+29=44)
653:         loc_oPg2.AddObject("lbl_4c_Label22", "Label")
654:         WITH loc_oPg2.lbl_4c_Label22
655:             .Caption   = "Data do Movimento :"
656:             .Top       = 48
657:             .Left      = 360
658:             .FontName  = "Tahoma"
659:             .FontSize  = 8
660:             .ForeColor = RGB(255, 255, 255)
661:             .BackStyle = 0
662:             .AutoSize  = .T.
663:             .Visible   = .T.
664:         ENDWITH
665: 
666:         loc_oPg2.AddObject("txt_4c_DtMovs", "TextBox")
667:         WITH loc_oPg2.txt_4c_DtMovs
668:             .Top         = 44
669:             .Left        = 464
670:             .Width       = 77
671:             .Height      = 23
672:             .Value       = {}
673:             .Format      = "D"
674:             .ReadOnly    = .T.
675:             .FontName    = "Tahoma"
676:             .FontSize    = 8
677:             .BorderStyle = 1
678:             .Visible     = .T.
679:         ENDWITH
680: 
681:         *-- Movimento (cod. operacao do lote - codigos): lbl_4c_Label19 (top=45+29=74), txt_4c_OperL (top=41+29=70)
682:         loc_oPg2.AddObject("lbl_4c_Label19", "Label")
683:         WITH loc_oPg2.lbl_4c_Label19
684:             .Caption   = "Movimento :"
685:             .Top       = 74
686:             .Left      = 48
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(255, 255, 255)
690:             .BackStyle = 0
691:             .AutoSize  = .T.
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oPg2.AddObject("txt_4c_OperL", "TextBox")
696:         WITH loc_oPg2.txt_4c_OperL
697:             .Top         = 70
698:             .Left        = 111
699:             .Width       = 124
700:             .Height      = 23
701:             .Value       = ""
702:             .FontName    = "Tahoma"
703:             .FontSize    = 8
704:             .BorderStyle = 1
705:             .Visible     = .T.
706:         ENDWITH
707:         BINDEVENT(loc_oPg2.txt_4c_OperL, "KeyPress", THIS, "ValidarOperL")
708: 
709:         *-- Operacao (S/N, readonly): lbl_4c_Label5 (top=45+29=74), txt_4c_Opera (top=41+29=70)
710:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
711:         WITH loc_oPg2.lbl_4c_Label5
712:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
713:             .Top       = 74
714:             .Left      = 253
715:             .FontName  = "Tahoma"
716:             .FontSize  = 8
717:             .ForeColor = RGB(255, 255, 255)
718:             .BackStyle = 0
719:             .AutoSize  = .T.
720:             .Visible   = .T.
721:         ENDWITH
722: 
723:         loc_oPg2.AddObject("txt_4c_Opera", "TextBox")
724:         WITH loc_oPg2.txt_4c_Opera
725:             .Top         = 70
726:             .Left        = 311
727:             .Width       = 17
728:             .Height      = 23
729:             .Value       = ""
730:             .ReadOnly    = .T.
731:             .FontName    = "Tahoma"
732:             .FontSize    = 8
733:             .BorderStyle = 1
734:             .Visible     = .T.
735:         ENDWITH
736: 
737:         *-- Limpar Carteira (hidden): lbl_4c_Label13, txt_4c_LimCart
738:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
739:         WITH loc_oPg2.lbl_4c_Label13
740:             .Caption   = "Limpar Carteira :"
741:             .Top       = 74
742:             .Left      = 380
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(255, 255, 255)
746:             .BackStyle = 0
747:             .AutoSize  = .T.
748:             .Visible   = .F.
749:         ENDWITH
750: 
751:         loc_oPg2.AddObject("txt_4c_LimCart", "TextBox")
752:         WITH loc_oPg2.txt_4c_LimCart
753:             .Top         = 70
754:             .Left        = 464
755:             .Width       = 17
756:             .Height      = 23
757:             .Value       = ""
758:             .FontName    = "Tahoma"
759:             .FontSize    = 8
760:             .BorderStyle = 1
761:             .Visible     = .F.
762:         ENDWITH
763: 
764:         *-- Indicador (S/N) hidden
765:         loc_oPg2.AddObject("lbl_4c_Label14", "Label")
766:         WITH loc_oPg2.lbl_4c_Label14
767:             .Caption   = "(S/N)"
768:             .Top       = 74
769:             .Left      = 489
770:             .FontName  = "Tahoma"
771:             .FontSize  = 8
772:             .ForeColor = RGB(255, 255, 255)
773:             .BackStyle = 0
774:             .Visible   = .F.
775:         ENDWITH
776: 
777:         *-- Grupo Terceiro: lbl_4c_Label21 (top=71+29=100), txt_4c_GrupoT / txt_4c_DGrupoT (top=67+29=96)
778:         loc_oPg2.AddObject("lbl_4c_Label21", "Label")
779:         WITH loc_oPg2.lbl_4c_Label21
780:             .Caption   = "Grupo Terceiro :"
781:             .Top       = 100
782:             .Left      = 29
783:             .FontName  = "Tahoma"
784:             .FontSize  = 8
785:             .ForeColor = RGB(255, 255, 255)
786:             .BackStyle = 0
787:             .AutoSize  = .T.
788:             .Visible   = .T.
789:         ENDWITH
790: 
791:         loc_oPg2.AddObject("txt_4c_GrupoT", "TextBox")
792:         WITH loc_oPg2.txt_4c_GrupoT
793:             .Top         = 96
794:             .Left        = 111
795:             .Width       = 87
796:             .Height      = 23
797:             .Value       = ""
798:             .FontName    = "Tahoma"
799:             .FontSize    = 8
800:             .BorderStyle = 1
801:             .Visible     = .T.
802:         ENDWITH
803:         BINDEVENT(loc_oPg2.txt_4c_GrupoT, "KeyPress", THIS, "ValidarGrupoT")
804: 
805:         loc_oPg2.AddObject("txt_4c_DGrupoT", "TextBox")
806:         WITH loc_oPg2.txt_4c_DGrupoT
807:             .Top         = 96
808:             .Left        = 200
809:             .Width       = 300
810:             .Height      = 23
811:             .Value       = ""
812:             .ReadOnly    = .T.
813:             .FontName    = "Tahoma"
814:             .FontSize    = 8
815:             .BorderStyle = 1
816:             .Visible     = .T.
817:         ENDWITH
818: 
819:         *-- Total Bruto (readonly): lbl_4c_Label8 (top=97+29=126), txt_4c_Valor (top=93+29=122)
820:         loc_oPg2.AddObject("lbl_4c_Label8", "Label")
821:         WITH loc_oPg2.lbl_4c_Label8
822:             .Caption   = "Total Bruto :"
823:             .Top       = 126
824:             .Left      = 47
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .ForeColor = RGB(255, 255, 255)
828:             .BackStyle = 0
829:             .AutoSize  = .T.
830:             .Visible   = .T.
831:         ENDWITH
832: 
833:         loc_oPg2.AddObject("txt_4c_Valor", "TextBox")
834:         WITH loc_oPg2.txt_4c_Valor
835:             .Top         = 122
836:             .Left        = 111
837:             .Width       = 124
838:             .Height      = 23
839:             .Value       = 0
840:             .Format      = "Z"
841:             .InputMask   = "999,999,999.99"
842:             .ReadOnly    = .T.
843:             .FontName    = "Tahoma"
844:             .FontSize    = 8
845:             .BorderStyle = 1
846:             .Visible     = .T.
847:         ENDWITH
848: 
849:         *-- Juros (readonly): lbl_4c_Label17 (top=97+29=126), txt_4c_TJUROS (top=93+29=122)
850:         loc_oPg2.AddObject("lbl_4c_Label17", "Label")
851:         WITH loc_oPg2.lbl_4c_Label17
852:             .Caption   = "Juros :"
853:             .Top       = 126
854:             .Left      = 247
855:             .FontName  = "Tahoma"
856:             .FontSize  = 8
857:             .ForeColor = RGB(255, 255, 255)
858:             .BackStyle = 0
859:             .AutoSize  = .T.
860:             .Visible   = .T.
861:         ENDWITH
862: 
863:         loc_oPg2.AddObject("txt_4c_TJUROS", "TextBox")
864:         WITH loc_oPg2.txt_4c_TJUROS
865:             .Top         = 122
866:             .Left        = 284
867:             .Width       = 113
868:             .Height      = 23
869:             .Value       = 0
870:             .Format      = "Z"
871:             .InputMask   = "999,999,999.99"
872:             .ReadOnly    = .T.
873:             .FontName    = "Tahoma"
874:             .FontSize    = 8
875:             .BorderStyle = 1
876:             .Visible     = .T.
877:         ENDWITH
878: 
879:         *-- Total Liquido (readonly): lbl_4c_Label4 (top=97+29=126), txt_4c_TLiq (top=93+29=122)
880:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
881:         WITH loc_oPg2.lbl_4c_Label4
882:             .Caption   = "Total L" + CHR(237) + "quido :"
883:             .Top       = 126
884:             .Left      = 433
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .ForeColor = RGB(255, 255, 255)
888:             .BackStyle = 0
889:             .AutoSize  = .T.
890:             .Visible   = .T.
891:         ENDWITH
892: 
893:         loc_oPg2.AddObject("txt_4c_TLiq", "TextBox")
894:         WITH loc_oPg2.txt_4c_TLiq
895:             .Top         = 122
896:             .Left        = 504
897:             .Width       = 117
898:             .Height      = 23
899:             .Value       = 0
900:             .Format      = "Z"
901:             .InputMask   = "999,999,999.99"
902:             .ReadOnly    = .T.
903:             .FontName    = "Tahoma"
904:             .FontSize    = 8
905:             .BorderStyle = 1
906:             .Visible     = .T.
907:         ENDWITH
908: 
909:         *-- Moeda: lbl_4c_Label6 (top=406+29=435), txt_4c_Moeda (top=402+29=431)
910:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
911:         WITH loc_oPg2.lbl_4c_Label6
912:             .Caption   = "Moeda :"
913:             .Top       = 435
914:             .Left      = 590
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8
917:             .ForeColor = RGB(255, 255, 255)
918:             .BackStyle = 0
919:             .AutoSize  = .T.
920:             .Visible   = .T.
921:         ENDWITH
922: 
923:         loc_oPg2.AddObject("txt_4c_Moeda", "TextBox")
924:         WITH loc_oPg2.txt_4c_Moeda
925:             .Top         = 431
926:             .Left        = 633
927:             .Width       = 32
928:             .Height      = 23
929:             .Value       = ""
930:             .FontName    = "Tahoma"
931:             .FontSize    = 8
932:             .BorderStyle = 1
933:             .Visible     = .T.
934:         ENDWITH
935:         BINDEVENT(loc_oPg2.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
936: 
937:         *-- Cotacao: lbl_4c_Cotacao (top=431+29=460), txt_4c_Cotacao (top=427+29=456)
938:         loc_oPg2.AddObject("lbl_4c_Cotacao", "Label")
939:         WITH loc_oPg2.lbl_4c_Cotacao
940:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
941:             .Top       = 460
942:             .Left      = 582
943:             .FontName  = "Tahoma"
944:             .FontSize  = 8
945:             .ForeColor = RGB(255, 255, 255)
946:             .BackStyle = 0
947:             .AutoSize  = .T.
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         loc_oPg2.AddObject("txt_4c_Cotacao", "TextBox")
952:         WITH loc_oPg2.txt_4c_Cotacao
953:             .Top         = 456
954:             .Left        = 633
955:             .Width       = 118
956:             .Height      = 23
957:             .Value       = 0
958:             .Format      = "Z"
959:             .InputMask   = "99,999.9999"
960:             .FontName    = "Tahoma"
961:             .FontSize    = 8
962:             .BorderStyle = 1
963:             .Visible     = .T.
964:         ENDWITH
965:         BINDEVENT(loc_oPg2.txt_4c_Cotacao, "KeyPress", THIS, "CotacaoLostFocus")
966: 
967:         *-- Valor Convertido (readonly): lbl_4c_Label20 (top=456+29=485), txt_4c_ValConv (top=452+29=481)
968:         loc_oPg2.AddObject("lbl_4c_Label20", "Label")
969:         WITH loc_oPg2.lbl_4c_Label20
970:             .Caption   = "Valor Conv :"
971:             .Top       = 485
972:             .Left      = 570
973:             .FontName  = "Tahoma"
974:             .FontSize  = 8
975:             .ForeColor = RGB(255, 255, 255)
976:             .BackStyle = 0
977:             .AutoSize  = .T.
978:             .Visible   = .T.
979:         ENDWITH
980: 
981:         loc_oPg2.AddObject("txt_4c_ValConv", "TextBox")
982:         WITH loc_oPg2.txt_4c_ValConv
983:             .Top         = 481
984:             .Left        = 633
985:             .Width       = 118
986:             .Height      = 23
987:             .Value       = 0
988:             .Format      = "Z"
989:             .InputMask   = "999,999,999.99"

*-- Linhas 998 a 1007:
998:         *-- ColumnCount FORA do WITH; ControlSource/RecordSource definidos em CarregarPaginaDados
999:         loc_oPg2.AddObject("grd_4c_GradeCheque", "Grid")
1000:         loc_oGrid             = loc_oPg2.grd_4c_GradeCheque
1001:         loc_oGrid.Top         = 159
1002:         loc_oGrid.Left        = 9
1003:         loc_oGrid.Width       = 985
1004:         loc_oGrid.Height      = 244
1005:         loc_oGrid.ColumnCount = 9
1006: 
1007:         WITH loc_oGrid

*-- Linhas 1028 a 1543:
1028:             .Column7.Width      = 150
1029:             .Column8.Width      = 100
1030:             .Column9.Width      = 150
1031:             .Column1.Header1.Caption = "Bco"
1032:             .Column2.Header1.Caption = "Agenc"
1033:             .Column3.Header1.Caption = "N" + CHR(186) + " Conta"
1034:             .Column4.Header1.Caption = "N" + CHR(186) + " Cheque"
1035:             .Column5.Header1.Caption = "Vencimento"
1036:             .Column6.Header1.Caption = "Valor"
1037:             .Column7.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
1038:             .Column8.Header1.Caption = "CPF/CNPJ"
1039:             .Column9.Header1.Caption = "Nome Terceiro"
1040:         ENDWITH
1041: 
1042:         *-- Botao Excluir Cheque da grade (ExcCheque, top=376+29=405, left=939)
1043:         loc_oPg2.AddObject("cmd_4c_ExcCheque", "CommandButton")
1044:         WITH loc_oPg2.cmd_4c_ExcCheque
1045:             .Top           = 405
1046:             .Left          = 939
1047:             .Width         = 55
1048:             .Height        = 53
1049:             .Caption       = "E\<xcluir"
1050:             .FontName      = "Tahoma"
1051:             .FontSize      = 8
1052:             .ForeColor     = RGB(90, 90, 90)
1053:             .BackColor     = RGB(255, 255, 255)
1054:             .Themes        = .F.
1055:             .SpecialEffect = 0
1056:             .Visible       = .T.
1057:         ENDWITH
1058:         BINDEVENT(loc_oPg2.cmd_4c_ExcCheque, "Click", THIS, "BtnExcChequeClick")
1059: 
1060:         *-- Get_Cheque: campo para leitora magnetica / digitacao (top=393+29=422, left=115)
1061:         loc_oPg2.AddObject("txt_4c_Cheque", "TextBox")
1062:         WITH loc_oPg2.txt_4c_Cheque
1063:             .Top         = 422
1064:             .Left        = 115
1065:             .Width       = 252
1066:             .Height      = 24
1067:             .Value       = ""
1068:             .FontName    = "Tahoma"
1069:             .FontSize    = 8
1070:             .BorderStyle = 1
1071:             .Visible     = .T.
1072:         ENDWITH
1073: 
1074:         *-- Labels AvisoPorta M/T/S (ocultos - visiveis conforme tipo de operacao)
1075:         loc_oPg2.AddObject("lbl_4c_AvisoPortaM", "Label")
1076:         WITH loc_oPg2.lbl_4c_AvisoPortaM
1077:             .Top       = 96
1078:             .Left      = 544
1079:             .Width     = 22
1080:             .Height    = 18
1081:             .Caption   = "M"
1082:             .FontName  = "Tahoma"
1083:             .FontSize  = 8
1084:             .FontBold  = .T.
1085:             .ForeColor = RGB(0, 0, 192)
1086:             .AutoSize  = .F.
1087:             .Visible   = .F.
1088:         ENDWITH
1089: 
1090:         loc_oPg2.AddObject("lbl_4c_AvisoPortaT", "Label")
1091:         WITH loc_oPg2.lbl_4c_AvisoPortaT
1092:             .Top       = 96
1093:             .Left      = 570
1094:             .Width     = 22
1095:             .Height    = 18
1096:             .Caption   = "T"
1097:             .FontName  = "Tahoma"
1098:             .FontSize  = 8
1099:             .FontBold  = .T.
1100:             .ForeColor = RGB(0, 0, 192)
1101:             .AutoSize  = .F.
1102:             .Visible   = .F.
1103:         ENDWITH
1104: 
1105:         loc_oPg2.AddObject("lbl_4c_AvisoPortaS", "Label")
1106:         WITH loc_oPg2.lbl_4c_AvisoPortaS
1107:             .Top       = 96
1108:             .Left      = 596
1109:             .Width     = 22
1110:             .Height    = 18
1111:             .Caption   = "S"
1112:             .FontName  = "Tahoma"
1113:             .FontSize  = 8
1114:             .FontBold  = .T.
1115:             .ForeColor = RGB(0, 0, 192)
1116:             .AutoSize  = .F.
1117:             .Visible   = .F.
1118:         ENDWITH
1119: 
1120:         *-- cmd_4c_Command3 Historico (top=405, left=829)
1121:         loc_oPg2.AddObject("cmd_4c_Command3", "CommandButton")
1122:         WITH loc_oPg2.cmd_4c_Command3
1123:             .Top           = 405
1124:             .Left          = 829
1125:             .Width         = 55
1126:             .Height        = 53
1127:             .Caption       = "Hist" + CHR(243) + "rico"
1128:             .FontName      = "Tahoma"
1129:             .FontSize      = 8
1130:             .ForeColor     = RGB(90, 90, 90)
1131:             .BackColor     = RGB(255, 255, 255)
1132:             .Themes        = .F.
1133:             .SpecialEffect = 0
1134:         ENDWITH
1135:         BINDEVENT(loc_oPg2.cmd_4c_Command3, "Click", THIS, "BtnCommand3Click")
1136: 
1137:         *-- cmd_4c_BotConsulta PGV consulta lote (top=405, left=884)
1138:         loc_oPg2.AddObject("cmd_4c_BotConsulta", "CommandButton")
1139:         WITH loc_oPg2.cmd_4c_BotConsulta
1140:             .Top           = 405
1141:             .Left          = 884
1142:             .Width         = 55
1143:             .Height        = 53
1144:             .Caption       = "PGV"
1145:             .FontName      = "Tahoma"
1146:             .FontSize      = 8
1147:             .ForeColor     = RGB(90, 90, 90)
1148:             .BackColor     = RGB(255, 255, 255)
1149:             .Themes        = .F.
1150:             .SpecialEffect = 0
1151:         ENDWITH
1152:         BINDEVENT(loc_oPg2.cmd_4c_BotConsulta, "Click", THIS, "BtnBotConsultaClick")
1153: 
1154:         *-- Grupo Origem (top=456, left=9/115/197)
1155:         loc_oPg2.AddObject("lbl_4c_LblGrupoOs", "Label")
1156:         WITH loc_oPg2.lbl_4c_LblGrupoOs
1157:             .Top      = 459
1158:             .Left     = 9
1159:             .Width    = 100
1160:             .Height   = 18
1161:             .Caption  = "Grupo Orig.:"
1162:             .FontName = "Tahoma"
1163:             .FontSize = 8
1164:             .AutoSize = .F.
1165:         ENDWITH
1166: 
1167:         loc_oPg2.AddObject("txt_4c_GrupoOs", "TextBox")
1168:         WITH loc_oPg2.txt_4c_GrupoOs
1169:             .Top         = 456
1170:             .Left        = 115
1171:             .Width       = 75
1172:             .Height      = 24
1173:             .Value       = ""
1174:             .FontName    = "Tahoma"
1175:             .FontSize    = 8
1176:             .BorderStyle = 1
1177:         ENDWITH
1178:         BINDEVENT(loc_oPg2.txt_4c_GrupoOs, "KeyPress", THIS, "ValidarGrupoOs")
1179: 
1180:         loc_oPg2.AddObject("txt_4c_DGrupoOs", "TextBox")
1181:         WITH loc_oPg2.txt_4c_DGrupoOs
1182:             .Top         = 456
1183:             .Left        = 197
1184:             .Width       = 298
1185:             .Height      = 24
1186:             .Value       = ""
1187:             .FontName    = "Tahoma"
1188:             .FontSize    = 8
1189:             .BorderStyle = 0
1190:             .ReadOnly    = .T.
1191:         ENDWITH
1192: 
1193:         *-- cmd_4c_Command1 PGV Origem (top=456, left=500, cobre linha Grupo+Conta Orig)
1194:         loc_oPg2.AddObject("cmd_4c_Command1", "CommandButton")
1195:         WITH loc_oPg2.cmd_4c_Command1
1196:             .Top           = 456
1197:             .Left          = 500
1198:             .Width         = 31
1199:             .Height        = 48
1200:             .Caption       = "PGV"
1201:             .FontName      = "Tahoma"
1202:             .FontSize      = 7
1203:             .ForeColor     = RGB(90, 90, 90)
1204:             .BackColor     = RGB(255, 255, 255)
1205:             .Themes        = .F.
1206:             .SpecialEffect = 0
1207:         ENDWITH
1208:         BINDEVENT(loc_oPg2.cmd_4c_Command1, "Click", THIS, "BtnCommand1Click")
1209: 
1210:         *-- Conta Origem (top=481, left=9/115/197)
1211:         loc_oPg2.AddObject("lbl_4c_LblContaOs", "Label")
1212:         WITH loc_oPg2.lbl_4c_LblContaOs
1213:             .Top      = 484
1214:             .Left     = 9
1215:             .Width    = 100
1216:             .Height   = 18
1217:             .Caption  = "Conta Orig.:"
1218:             .FontName = "Tahoma"
1219:             .FontSize = 8
1220:             .AutoSize = .F.
1221:         ENDWITH
1222: 
1223:         loc_oPg2.AddObject("txt_4c_ContaOs", "TextBox")
1224:         WITH loc_oPg2.txt_4c_ContaOs
1225:             .Top         = 481
1226:             .Left        = 115
1227:             .Width       = 75
1228:             .Height      = 24
1229:             .Value       = ""
1230:             .FontName    = "Tahoma"
1231:             .FontSize    = 8
1232:             .BorderStyle = 1
1233:         ENDWITH
1234:         BINDEVENT(loc_oPg2.txt_4c_ContaOs, "KeyPress", THIS, "ValidarContaOs")
1235: 
1236:         loc_oPg2.AddObject("txt_4c_DCONTAOs", "TextBox")
1237:         WITH loc_oPg2.txt_4c_DCONTAOs
1238:             .Top         = 481
1239:             .Left        = 197
1240:             .Width       = 298
1241:             .Height      = 24
1242:             .Value       = ""
1243:             .FontName    = "Tahoma"
1244:             .FontSize    = 8
1245:             .BorderStyle = 0
1246:             .ReadOnly    = .T.
1247:         ENDWITH
1248: 
1249:         *-- Grupo Destino (top=506, left=9/115/197)
1250:         loc_oPg2.AddObject("lbl_4c_LblGrupoDs", "Label")
1251:         WITH loc_oPg2.lbl_4c_LblGrupoDs
1252:             .Top      = 509
1253:             .Left     = 9
1254:             .Width    = 100
1255:             .Height   = 18
1256:             .Caption  = "Grupo Dest.:"
1257:             .FontName = "Tahoma"
1258:             .FontSize = 8
1259:             .AutoSize = .F.
1260:         ENDWITH
1261: 
1262:         loc_oPg2.AddObject("txt_4c_GrupoDs", "TextBox")
1263:         WITH loc_oPg2.txt_4c_GrupoDs
1264:             .Top         = 506
1265:             .Left        = 115
1266:             .Width       = 75
1267:             .Height      = 24
1268:             .Value       = ""
1269:             .FontName    = "Tahoma"
1270:             .FontSize    = 8
1271:             .BorderStyle = 1
1272:         ENDWITH
1273:         BINDEVENT(loc_oPg2.txt_4c_GrupoDs, "KeyPress", THIS, "ValidarGrupoDs")
1274: 
1275:         loc_oPg2.AddObject("txt_4c_DGrupoDs", "TextBox")
1276:         WITH loc_oPg2.txt_4c_DGrupoDs
1277:             .Top         = 506
1278:             .Left        = 197
1279:             .Width       = 298
1280:             .Height      = 24
1281:             .Value       = ""
1282:             .FontName    = "Tahoma"
1283:             .FontSize    = 8
1284:             .BorderStyle = 0
1285:             .ReadOnly    = .T.
1286:         ENDWITH
1287: 
1288:         *-- cmd_4c_Command2 PGV Destino (top=506, left=500, cobre linha Grupo+Conta Dest)
1289:         loc_oPg2.AddObject("cmd_4c_Command2", "CommandButton")
1290:         WITH loc_oPg2.cmd_4c_Command2
1291:             .Top           = 506
1292:             .Left          = 500
1293:             .Width         = 31
1294:             .Height        = 48
1295:             .Caption       = "PGV"
1296:             .FontName      = "Tahoma"
1297:             .FontSize      = 7
1298:             .ForeColor     = RGB(90, 90, 90)
1299:             .BackColor     = RGB(255, 255, 255)
1300:             .Themes        = .F.
1301:             .SpecialEffect = 0
1302:         ENDWITH
1303:         BINDEVENT(loc_oPg2.cmd_4c_Command2, "Click", THIS, "BtnCommand2Click")
1304: 
1305:         *-- Conta Destino (top=531, left=9/115/197)
1306:         loc_oPg2.AddObject("lbl_4c_LblContaDs", "Label")
1307:         WITH loc_oPg2.lbl_4c_LblContaDs
1308:             .Top      = 534
1309:             .Left     = 9
1310:             .Width    = 100
1311:             .Height   = 18
1312:             .Caption  = "Conta Dest.:"
1313:             .FontName = "Tahoma"
1314:             .FontSize = 8
1315:             .AutoSize = .F.
1316:         ENDWITH
1317: 
1318:         loc_oPg2.AddObject("txt_4c_ContaDs", "TextBox")
1319:         WITH loc_oPg2.txt_4c_ContaDs
1320:             .Top         = 531
1321:             .Left        = 115
1322:             .Width       = 75
1323:             .Height      = 24
1324:             .Value       = ""
1325:             .FontName    = "Tahoma"
1326:             .FontSize    = 8
1327:             .BorderStyle = 1
1328:         ENDWITH
1329:         BINDEVENT(loc_oPg2.txt_4c_ContaDs, "KeyPress", THIS, "ValidarContaDs")
1330: 
1331:         loc_oPg2.AddObject("txt_4c_DCONTADs", "TextBox")
1332:         WITH loc_oPg2.txt_4c_DCONTADs
1333:             .Top         = 531
1334:             .Left        = 197
1335:             .Width       = 298
1336:             .Height      = 24
1337:             .Value       = ""
1338:             .FontName    = "Tahoma"
1339:             .FontSize    = 8
1340:             .BorderStyle = 0
1341:             .ReadOnly    = .T.
1342:         ENDWITH
1343: 
1344:         *-- Taxa a.m.% label + textbox (top=506, left=548/633)
1345:         loc_oPg2.AddObject("lbl_4c_LblTaxa", "Label")
1346:         WITH loc_oPg2.lbl_4c_LblTaxa
1347:             .Top      = 509
1348:             .Left     = 548
1349:             .Width    = 80
1350:             .Height   = 18
1351:             .Caption  = "Taxa a.m.%:"
1352:             .FontName = "Tahoma"
1353:             .FontSize = 8
1354:             .AutoSize = .F.
1355:         ENDWITH
1356: 
1357:         loc_oPg2.AddObject("txt_4c_Taxa", "TextBox")
1358:         WITH loc_oPg2.txt_4c_Taxa
1359:             .Top         = 506
1360:             .Left        = 633
1361:             .Width       = 66
1362:             .Height      = 24
1363:             .Value       = 0
1364:             .FontName    = "Tahoma"
1365:             .FontSize    = 8
1366:             .BorderStyle = 1
1367:         ENDWITH
1368:         BINDEVENT(loc_oPg2.txt_4c_Taxa, "KeyPress", THIS, "TaxaLostFocus")
1369: 
1370:         *-- Taxa a.d.% label + textbox (top=531, left=548/633)
1371:         loc_oPg2.AddObject("lbl_4c_LblTaxaDia", "Label")
1372:         WITH loc_oPg2.lbl_4c_LblTaxaDia
1373:             .Top      = 534
1374:             .Left     = 548
1375:             .Width    = 80
1376:             .Height   = 18
1377:             .Caption  = "Taxa a.d.%:"
1378:             .FontName = "Tahoma"
1379:             .FontSize = 8
1380:             .AutoSize = .F.
1381:         ENDWITH
1382: 
1383:         loc_oPg2.AddObject("txt_4c_TaxaDia", "TextBox")
1384:         WITH loc_oPg2.txt_4c_TaxaDia
1385:             .Top         = 531
1386:             .Left        = 633
1387:             .Width       = 66
1388:             .Height      = 24
1389:             .Value       = 0
1390:             .FontName    = "Tahoma"
1391:             .FontSize    = 8
1392:             .BorderStyle = 1
1393:         ENDWITH
1394:         BINDEVENT(loc_oPg2.txt_4c_TaxaDia, "KeyPress", THIS, "TaxaDiaLostFocus")
1395: 
1396:         *-- Indicadores S (Simples) / C (Composto) entre Taxa dia e IOF (top=552, left=717/743)
1397:         loc_oPg2.AddObject("lbl_4c_TpJuroS", "Label")
1398:         WITH loc_oPg2.lbl_4c_TpJuroS
1399:             .Top       = 552
1400:             .Left      = 717
1401:             .Width     = 20
1402:             .Height    = 18
1403:             .Caption   = "S"
1404:             .FontName  = "Tahoma"
1405:             .FontSize  = 8
1406:             .FontBold  = .T.
1407:             .ForeColor = RGB(128, 128, 128)
1408:             .AutoSize  = .F.
1409:         ENDWITH
1410: 
1411:         loc_oPg2.AddObject("lbl_4c_TpJuroC", "Label")
1412:         WITH loc_oPg2.lbl_4c_TpJuroC
1413:             .Top       = 552
1414:             .Left      = 743
1415:             .Width     = 20
1416:             .Height    = 18
1417:             .Caption   = "C"
1418:             .FontName  = "Tahoma"
1419:             .FontSize  = 8
1420:             .FontBold  = .T.
1421:             .ForeColor = RGB(128, 128, 128)
1422:             .AutoSize  = .F.
1423:         ENDWITH
1424: 
1425:         *-- Grupo Juros (top=556, left=9/115/197)
1426:         loc_oPg2.AddObject("lbl_4c_LblGruJuro", "Label")
1427:         WITH loc_oPg2.lbl_4c_LblGruJuro
1428:             .Top      = 559
1429:             .Left     = 9
1430:             .Width    = 100
1431:             .Height   = 18
1432:             .Caption  = "Grupo Juros:"
1433:             .FontName = "Tahoma"
1434:             .FontSize = 8
1435:             .AutoSize = .F.
1436:         ENDWITH
1437: 
1438:         loc_oPg2.AddObject("txt_4c_GruJuro", "TextBox")
1439:         WITH loc_oPg2.txt_4c_GruJuro
1440:             .Top         = 556
1441:             .Left        = 115
1442:             .Width       = 75
1443:             .Height      = 24
1444:             .Value       = ""
1445:             .FontName    = "Tahoma"
1446:             .FontSize    = 8
1447:             .BorderStyle = 1
1448:         ENDWITH
1449:         BINDEVENT(loc_oPg2.txt_4c_GruJuro, "KeyPress", THIS, "ValidarGruJuro")
1450: 
1451:         loc_oPg2.AddObject("txt_4c_DGruJuro", "TextBox")
1452:         WITH loc_oPg2.txt_4c_DGruJuro
1453:             .Top         = 556
1454:             .Left        = 197
1455:             .Width       = 298
1456:             .Height      = 24
1457:             .Value       = ""
1458:             .FontName    = "Tahoma"
1459:             .FontSize    = 8
1460:             .BorderStyle = 0
1461:             .ReadOnly    = .T.
1462:         ENDWITH
1463: 
1464:         *-- IOF a.m.% label + textbox (top=556, left=548/633)
1465:         loc_oPg2.AddObject("lbl_4c_LblTaxaIof", "Label")
1466:         WITH loc_oPg2.lbl_4c_LblTaxaIof
1467:             .Top      = 559
1468:             .Left     = 548
1469:             .Width    = 80
1470:             .Height   = 18
1471:             .Caption  = "IOF a.m.%:"
1472:             .FontName = "Tahoma"
1473:             .FontSize = 8
1474:             .AutoSize = .F.
1475:         ENDWITH
1476: 
1477:         loc_oPg2.AddObject("txt_4c_TaxaIof", "TextBox")
1478:         WITH loc_oPg2.txt_4c_TaxaIof
1479:             .Top         = 556
1480:             .Left        = 633
1481:             .Width       = 66
1482:             .Height      = 24
1483:             .Value       = 0
1484:             .FontName    = "Tahoma"
1485:             .FontSize    = 8
1486:             .BorderStyle = 1
1487:         ENDWITH
1488:         BINDEVENT(loc_oPg2.txt_4c_TaxaIof, "KeyPress", THIS, "TaxaIofLostFocus")
1489: 
1490:         *-- Conta Juros (top=581, left=9/115/197)
1491:         loc_oPg2.AddObject("lbl_4c_LblConJuro", "Label")
1492:         WITH loc_oPg2.lbl_4c_LblConJuro
1493:             .Top      = 584
1494:             .Left     = 9
1495:             .Width    = 100
1496:             .Height   = 18
1497:             .Caption  = "Conta Juros:"
1498:             .FontName = "Tahoma"
1499:             .FontSize = 8
1500:             .AutoSize = .F.
1501:         ENDWITH
1502: 
1503:         loc_oPg2.AddObject("txt_4c_ConJuro", "TextBox")
1504:         WITH loc_oPg2.txt_4c_ConJuro
1505:             .Top         = 581
1506:             .Left        = 115
1507:             .Width       = 75
1508:             .Height      = 24
1509:             .Value       = ""
1510:             .FontName    = "Tahoma"
1511:             .FontSize    = 8
1512:             .BorderStyle = 1
1513:         ENDWITH
1514:         BINDEVENT(loc_oPg2.txt_4c_ConJuro, "KeyPress", THIS, "ValidarConJuro")
1515: 
1516:         loc_oPg2.AddObject("txt_4c_DJuro", "TextBox")
1517:         WITH loc_oPg2.txt_4c_DJuro
1518:             .Top         = 581
1519:             .Left        = 197
1520:             .Width       = 298
1521:             .Height      = 24
1522:             .Value       = ""
1523:             .FontName    = "Tahoma"
1524:             .FontSize    = 8
1525:             .BorderStyle = 0
1526:             .ReadOnly    = .T.
1527:         ENDWITH
1528: 
1529:         THIS.TornarControlesVisiveis(loc_oPg2)
1530: 
1531:         *-- Re-ocultar controles que devem iniciar invisiveis (TornarControlesVisiveis seta Visible=.T. em tudo)
1532:         loc_oPg2.lbl_4c_Label13.Visible    = .F.
1533:         loc_oPg2.txt_4c_LimCart.Visible    = .F.
1534:         loc_oPg2.lbl_4c_Label14.Visible    = .F.
1535:         loc_oPg2.cmd_4c_Protocolos.Visible = .F.
1536:         loc_oPg2.lbl_4c_AvisoPortaM.Visible = .F.
1537:         loc_oPg2.lbl_4c_AvisoPortaT.Visible = .F.
1538:         loc_oPg2.lbl_4c_AvisoPortaS.Visible = .F.
1539:     ENDPROC
1540: 
1541:     *--------------------------------------------------------------------------
1542:     * CarregarLista - Busca lotes no periodo e vincula grid
1543:     *--------------------------------------------------------------------------

*-- Linhas 1578 a 1591:
1578:                     .Column5.ControlSource = "cursor_4c_Dados.valtjuros"
1579:                     .Column6.ControlSource = "cursor_4c_Dados.datatrans"
1580:                     *-- Re-setar headers apos RecordSource (VFP9 reseta captions)
1581:                     .Column1.Header1.Caption = "Lote"
1582:                     .Column2.Header1.Caption = "Data"
1583:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1584:                     .Column4.Header1.Caption = "Total"
1585:                     .Column5.Header1.Caption = "Juros"
1586:                     .Column6.Header1.Caption = "Dt. Transporte"
1587:                 ENDWITH
1588: 
1589:                 THIS.FormatarGridLista(loc_oGrid)
1590:                 loc_lResultado = .T.
1591:             ENDIF

*-- Linhas 1888 a 1910:
1888:                 .txt_4c_Moeda.ReadOnly           = !par_lHabilitar
1889:                 .txt_4c_Cotacao.ReadOnly         = !par_lHabilitar
1890:                 .grd_4c_GradeCheque.ReadOnly     = !par_lHabilitar
1891:                 .cmd_4c_ExcCheque.Enabled        = par_lHabilitar
1892:                 .txt_4c_GrupoOs.ReadOnly         = !par_lHabilitar
1893:                 .txt_4c_ContaOs.ReadOnly         = !par_lHabilitar
1894:                 .txt_4c_GrupoDs.ReadOnly         = !par_lHabilitar
1895:                 .txt_4c_ContaDs.ReadOnly         = !par_lHabilitar
1896:                 .txt_4c_GruJuro.ReadOnly         = !par_lHabilitar
1897:                 .txt_4c_ConJuro.ReadOnly         = !par_lHabilitar
1898:                 .txt_4c_Taxa.ReadOnly            = !par_lHabilitar
1899:                 .txt_4c_TaxaDia.ReadOnly         = !par_lHabilitar
1900:                 .txt_4c_TaxaIof.ReadOnly         = !par_lHabilitar
1901:                 .cmd_4c_BotConsulta.Enabled      = par_lHabilitar
1902:                 .cmd_4c_Command1.Enabled         = par_lHabilitar
1903:                 .cmd_4c_Command2.Enabled         = par_lHabilitar
1904:                 .cmd_4c_Command3.Enabled         = par_lHabilitar
1905:                 .cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1906:             ENDWITH
1907:         CATCH TO loc_oErro
1908:             MsgErro(loc_oErro.Message, "Formche.HabilitarCampos")
1909:         ENDTRY
1910:     ENDPROC

*-- Linhas 2386 a 2402:
2386:                 .Column7.ControlSource   = "TempChq.Obss"
2387:                 .Column8.ControlSource   = "TempChq.cpft"
2388:                 .Column9.ControlSource   = "TempChq.Nomet"
2389:                 .Column1.Header1.Caption = "Bco"
2390:                 .Column2.Header1.Caption = "Agenc"
2391:                 .Column3.Header1.Caption = "N" + CHR(186) + " Conta"
2392:                 .Column4.Header1.Caption = "N" + CHR(186) + " Cheque"
2393:                 .Column5.Header1.Caption = "Vencimento"
2394:                 .Column6.Header1.Caption = "Valor"
2395:                 .Column7.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
2396:                 .Column8.Header1.Caption = "CPF/CNPJ"
2397:                 .Column9.Header1.Caption = "Nome Terceiro"
2398:             ENDWITH
2399: 
2400:             SELECT TempChq
2401:             GO TOP
2402:             loc_oGrid.Refresh()

*-- Linhas 3087 a 3100:
3087:                 ELSE
3088:                     loc_nTaxaDia = 0
3089:                 ENDIF
3090:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(0, 0, 192)
3091:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(128, 128, 128)
3092:             ELSE
3093:                 loc_nTaxaDia = ROUND(loc_nTaxa / 30, 4)
3094:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(0, 0, 192)
3095:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(128, 128, 128)
3096:             ENDIF
3097: 
3098:             loc_oPg2.txt_4c_TaxaDia.Value = loc_nTaxaDia
3099:         CATCH TO loc_oErro
3100:             MsgErro(loc_oErro.Message, "Formche.TaxaLostFocus")

*-- Linhas 3119 a 3132:
3119:                 ELSE
3120:                     loc_nTaxaMes = 0
3121:                 ENDIF
3122:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(0, 0, 192)
3123:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(128, 128, 128)
3124:             ELSE
3125:                 loc_nTaxaMes = ROUND(loc_nTaxaDia * 30, 4)
3126:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(0, 0, 192)
3127:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(128, 128, 128)
3128:             ENDIF
3129: 
3130:             loc_oPg2.txt_4c_Taxa.Value = loc_nTaxaMes
3131:         CATCH TO loc_oErro
3132:             MsgErro(loc_oErro.Message, "Formche.TaxaDiaLostFocus")


### BO (C:\4c\projeto\app\classes\cheBO.prg):
DEFINE CLASS cheBO AS BusinessBase

    *-- SigCqLcm - cabecalho do lote
    this_nNumLote  = 0
    this_cOperL    = ""
    this_dData     = {}
    this_dDtMovs   = {}
    this_cOpera    = ""
    this_cLimCart  = ""

    *-- Moeda / conversao
    this_cMoeda    = ""
    this_nCotacao  = 0
    this_nValConv  = 0

    *-- Totais (Valtots, Valtjuros, calc TLiq)
    this_nValor    = 0
    this_nTJuros   = 0
    this_nTLiq     = 0

    *-- Taxas
    this_nTaxaDia  = 0
    this_nTaxaIof  = 0
    this_nTaxaMes  = 0

    *-- Grupo / Conta Destino
    this_cGrupoDs  = ""
    this_cDGrupoDs = ""
    this_cContaDs  = ""
    this_cDContaDs = ""

    *-- Grupo / Conta Origem
    this_cGrupoOs  = ""
    this_cDGrupoOs = ""
    this_cContaOs  = ""
    this_cDContaOs = ""

    *-- Grupo / Conta Terceiro
    this_cGrupoT   = ""
    this_cDGrupoT  = ""

    *-- Grupo / Conta Juros
    this_cGruJuro  = ""
    this_cDGruJuro = ""
    this_cConJuro  = ""
    this_cDJuro    = ""

    *-- Chave interna (GUID - cidchaves)
    this_cCidChave  = ""

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCqLcm"
        THIS.this_cCampoChave = "NumLotes"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumLote
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de lotes da carteira de cheques
    * par_cFiltro: WHERE adicional (ex: "AND datas BETWEEN '...' AND '...'")
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numlotes"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega lote pelo numlotes
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_nNumLote)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLote)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLote   = TratarNulo(numlotes,  "N")
            THIS.this_cCidChave  = TratarNulo(cidchaves, "C")
            THIS.this_dData      = TratarNulo(datas,     "D")
            THIS.this_dDtMovs    = TratarNulo(dtmovs,    "D")
            THIS.this_cOperL     = TratarNulo(codigos,   "C")
            THIS.this_cOpera     = TratarNulo(operas,    "C")
            THIS.this_cLimCart   = TratarNulo(tipos,     "C")
            THIS.this_cMoeda     = TratarNulo(moeds,     "C")
            THIS.this_nCotacao   = TratarNulo(cotas,     "N")
            THIS.this_nValConv   = TratarNulo(valconvs,  "N")
            THIS.this_nValor     = TratarNulo(valtots,   "N")
            THIS.this_nTJuros    = TratarNulo(valtjuros, "N")
            THIS.this_nTLiq      = THIS.this_nValor - THIS.this_nTJuros
            THIS.this_nTaxaDia   = TratarNulo(taxdias,   "N")
            THIS.this_nTaxaIof   = TratarNulo(taxiofs,   "N")
            THIS.this_nTaxaMes   = TratarNulo(taxcarts,  "N")
            THIS.this_cGrupoDs   = TratarNulo(grupods,   "C")
            THIS.this_cContaDs   = TratarNulo(contads,   "C")
            THIS.this_cGrupoOs   = TratarNulo(grupoos,   "C")
            THIS.this_cContaOs   = TratarNulo(contaos,   "C")
            THIS.this_cGrupoT    = TratarNulo(grupocx,   "C")
            THIS.this_cGruJuro   = TratarNulo(grujuros,  "C")
            THIS.this_cConJuro   = TratarNulo(conjuros,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProximoLote - Retorna proximo numlotes disponivel
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigCqLcm" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo, loc_cCidChave
        loc_lSucesso = .F.

        TRY
            loc_nProximo  = THIS.ObterProximoLote()
            loc_cCidChave = LEFT(go_4c_Sistema.cCodEmpresa + ;
                PADL(TRANSFORM(loc_nProximo), 17, "0"), 20)

            THIS.this_nNumLote  = loc_nProximo
            THIS.this_cCidChave = loc_cCidChave

            loc_cSQL = "INSERT INTO SigCqLcm (" + ;
                " numlotes, cidchaves, datas, dtmovs, codigos, operas, tipos," + ;
                " moeds, cotas, valtots, valtjuros, valconvs," + ;
                " grupoos, contaos, grupods, contads, grupocx, contacx," + ;
                " grujuros, conjuros, taxcarts, taxdias, taxiofs," + ;
                " emps, usuarios, dtsis, autos, locals, ntrans," + ;
                " nalineas, empdopnums, custodia)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLote) + "," + ;
                EscaparSQL(THIS.this_cCidChave) + "," + ;
                FormatarDataSQL(THIS.this_dData) + "," + ;
                FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOperL)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                "''," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                "GETDATE()," + ;
                "0,'',0,0,'','')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqLcm SET" + ;
                " datas = "     + FormatarDataSQL(THIS.this_dData) + "," + ;
                " dtmovs = "    + FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                " operas = "    + EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                " tipos = "     + EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                " valtjuros = " + FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                " grupoos = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                " contaos = "   + EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                " grupods = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                " contads = "   + EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                " grupocx = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                " grujuros = "  + EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                " conjuros = "  + EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                " taxcarts = "  + FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                " taxdias = "   + FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                " taxiofs = "   + FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLote)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCcChm (cheques) e SigCqLcm (lote)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigCcChm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLote)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigCqLcm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLote)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

