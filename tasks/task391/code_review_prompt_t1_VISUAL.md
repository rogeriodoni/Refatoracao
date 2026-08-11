# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (12)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 167: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 239: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 263: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 298: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 389: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 623: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 642: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 734: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 757: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVI.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1950 linhas total):

*-- Linhas 33 a 41:
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             THIS.Caption = "Cadastro de Comiss" + CHR(245) + ;
37:                 "es de Vendedores Individuais"
38: 
39:             THIS.this_oBusinessObject = CREATEOBJECT("CVIBO")
40: 
41:             IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 71 a 80:
71: 
72:         WITH THIS.pgf_4c_Paginas
73:             .PageCount = 2
74:             .Top       = -29
75:             .Left      = 0
76:             .Width     = THIS.Width
77:             .Height    = THIS.Height + 29
78:             .Tabs      = .F.
79:             .Visible   = .T.
80:         ENDWITH

*-- Linhas 98 a 136:
98:         *-- Container Cabecalho (cntSombra no legado)
99:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
100:         WITH loc_oPagina.cnt_4c_Cabecalho
101:             .Top         = 2 + 29
102:             .Left        = 0
103:             .Width       = THIS.Width
104:             .Height      = 80
105:             .BackColor   = RGB(100, 100, 100)
106:             .BorderWidth = 0
107:             .Visible     = .T.
108:         ENDWITH
109: 
110:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
111:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
112:             .AutoSize  = .F.
113:             .Caption   = "Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais"
114:             .Top       = 15
115:             .Left      = 10
116:             .Width     = THIS.Width - 30
117:             .Height    = 40
118:             .FontName  = "Tahoma"
119:             .FontSize  = 16
120:             .FontBold  = .T.
121:             .ForeColor = RGB(0, 0, 0)
122:             .BackStyle = 0
123:             .Visible   = .T.
124:         ENDWITH
125: 
126:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
127:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
128:             .AutoSize  = .F.
129:             .Caption   = "Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais"
130:             .Top       = 18
131:             .Left      = 10
132:             .Width     = THIS.Width - 30
133:             .Height    = 46
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.

*-- Linhas 143 a 304:
143:         *-- Posicao canonica no novo sistema: Left=542
144:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
145:         WITH loc_oPagina.cnt_4c_Botoes
146:             .Top         = 0 + 29
147:             .Left        = 542
148:             .Width       = 390
149:             .Height      = 85
150:             .BackStyle = 0
151:             .BorderWidth = 0
152:             .Visible     = .T.
153:         ENDWITH
154: 
155:         *-- Botao Incluir (inserir.Left=36 no legado -> canonico Left=5)
156:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
157:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
158:             .Caption         = "Incluir"
159:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
160:             .PicturePosition = 13
161:             .Top             = 5
162:             .Left            = 5
163:             .Width           = 75
164:             .Height          = 75
165:             .BackColor       = RGB(255, 255, 255)
166:             .ForeColor       = RGB(90, 90, 90)
167:             .FontName        = "Comic Sans MS"
168:             .FontSize        = 8
169:             .FontBold        = .T.
170:             .FontItalic      = .T.
171:             .Themes          = .F.
172:             .SpecialEffect   = 0
173:             .MousePointer    = 15
174:             .WordWrap        = .T.
175:             .AutoSize        = .F.
176:             .Visible         = .T.
177:         ENDWITH
178: 
179:         *-- Botao Visualizar (consultar.Left=111 -> canonico Left=80)
180:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
181:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
182:             .Caption         = "Visualizar"
183:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
184:             .PicturePosition = 13
185:             .Top             = 5
186:             .Left            = 80
187:             .Width           = 75
188:             .Height          = 75
189:             .BackColor       = RGB(255, 255, 255)
190:             .ForeColor       = RGB(90, 90, 90)
191:             .FontName        = "Comic Sans MS"
192:             .FontSize        = 8
193:             .FontBold        = .T.
194:             .FontItalic      = .T.
195:             .Themes          = .F.
196:             .SpecialEffect   = 0
197:             .MousePointer    = 15
198:             .WordWrap        = .T.
199:             .AutoSize        = .F.
200:             .Visible         = .T.
201:         ENDWITH
202: 
203:         *-- Botao Alterar (alterar.Left=186 -> canonico Left=155)
204:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
205:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
206:             .Caption         = "Alterar"
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
208:             .PicturePosition = 13
209:             .Top             = 5
210:             .Left            = 155
211:             .Width           = 75
212:             .Height          = 75
213:             .BackColor       = RGB(255, 255, 255)
214:             .ForeColor       = RGB(90, 90, 90)
215:             .FontName        = "Comic Sans MS"
216:             .FontSize        = 8
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .Themes          = .F.
220:             .SpecialEffect   = 0
221:             .MousePointer    = 15
222:             .WordWrap        = .T.
223:             .AutoSize        = .F.
224:             .Visible         = .T.
225:         ENDWITH
226: 
227:         *-- Botao Excluir (excluir.Left=261 -> canonico Left=230)
228:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
229:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
230:             .Caption         = "Excluir"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 230
235:             .Width           = 75
236:             .Height          = 75
237:             .BackColor       = RGB(255, 255, 255)
238:             .ForeColor       = RGB(90, 90, 90)
239:             .FontName        = "Comic Sans MS"
240:             .FontSize        = 8
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:             .Visible         = .T.
249:         ENDWITH
250: 
251:         *-- Botao Buscar (procurar.Left=336 -> canonico Left=305)
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
254:             .Caption         = "Buscar"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 305
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
274: 
275:         *-- Container Saida - padrao canonico (grupo_saida.Left=719 no legado)
276:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
277:         WITH loc_oPagina.cnt_4c_Saida
278:             .Top         = 29
279:             .Left        = 917
280:             .Width       = 90
281:             .Height      = 85
282:             .BackStyle   = 0
283:             .BorderWidth = 0
284:             .Visible     = .T.
285:         ENDWITH
286: 
287:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
288:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
289:             .Caption         = "Encerrar"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
291:             .PicturePosition = 13
292:             .Top             = 5
293:             .Left            = 5
294:             .Width           = 75
295:             .Height          = 75
296:             .BackColor       = RGB(255, 255, 255)
297:             .ForeColor       = RGB(90, 90, 90)
298:             .FontName        = "Comic Sans MS"
299:             .FontSize        = 8
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .Themes          = .F.
303:             .SpecialEffect   = 0
304:             .MousePointer    = 15

*-- Linhas 310 a 395:
310:         *-- Container Filtro periodo (cntFiltro no legado: Top=120, Left=12)
311:         loc_oPagina.AddObject("cnt_4c_Filtro", "Container")
312:         WITH loc_oPagina.cnt_4c_Filtro
313:             .Top           = 120 + 29
314:             .Left          = 12
315:             .Width         = 162
316:             .Height        = 29
317:             .BackColor     = RGB(255, 255, 255)
318:             .BorderWidth   = 0
319:             .SpecialEffect = 0
320:             .Visible       = .T.
321:         ENDWITH
322: 
323:         loc_oPagina.cnt_4c_Filtro.AddObject("lbl_4c_Periodo", "Label")
324:         WITH loc_oPagina.cnt_4c_Filtro.lbl_4c_Periodo
325:             .AutoSize  = .T.
326:             .Caption   = "\<Per" + CHR(237) + "odo :"
327:             .Left      = 23
328:             .Top       = 7
329:             .FontName  = "Tahoma"
330:             .FontSize  = 8
331:             .ForeColor = RGB(90, 90, 90)
332:             .BackStyle = 0
333:             .Visible   = .T.
334:         ENDWITH
335: 
336:         loc_oPagina.cnt_4c_Filtro.AddObject("txt_4c_Mess", "TextBox")
337:         WITH loc_oPagina.cnt_4c_Filtro.txt_4c_Mess
338:             .Top       = 3
339:             .Left      = 71
340:             .Width     = 24
341:             .Height    = 23
342:             .InputMask = "99"
343:             .MaxLength = 2
344:             .Value     = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 5, 2)), 2, "0")
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .Visible   = .T.
348:         ENDWITH
349: 
350:         loc_oPagina.cnt_4c_Filtro.AddObject("lbl_4c_BarraFiltro", "Label")
351:         WITH loc_oPagina.cnt_4c_Filtro.lbl_4c_BarraFiltro
352:             .AutoSize  = .F.
353:             .Caption   = "/"
354:             .Left      = 100
355:             .Top       = 7
356:             .Width     = 10
357:             .Height    = 15
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .ForeColor = RGB(90, 90, 90)
361:             .BackStyle = 0
362:             .Visible   = .T.
363:         ENDWITH
364: 
365:         loc_oPagina.cnt_4c_Filtro.AddObject("txt_4c_Anos", "TextBox")
366:         WITH loc_oPagina.cnt_4c_Filtro.txt_4c_Anos
367:             .Top       = 3
368:             .Left      = 108
369:             .Width     = 38
370:             .Height    = 23
371:             .InputMask = "9999"
372:             .MaxLength = 4
373:             .Value     = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 1, 4)), 4, "0")
374:             .FontName  = "Tahoma"
375:             .FontSize  = 8
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         *-- Botao Copia de Periodo (cmdCopia: Top=92+29=121, Left=347)
380:         loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
381:         WITH loc_oPagina.cmd_4c_Copia
382:             .Caption         = "\<C" + CHR(243) + "pia"
383:             .Picture         = gc_4c_CaminhoIcones + "geral_copiar_32.jpg"
384:             .PicturePosition = 1
385:             .Top             = 92 + 29
386:             .Left            = 347
387:             .Width           = 105
388:             .Height          = 45
389:             .FontName        = "Comic Sans MS"
390:             .FontSize        = 8
391:             .FontBold        = .T.
392:             .FontItalic      = .T.
393:             .ForeColor       = RGB(90, 90, 90)
394:             .BackColor       = RGB(255, 255, 255)
395:             .Themes          = .F.

*-- Linhas 401 a 662:
401:         *-- Shape + Label: Individual (branco), Responsavel (azul), Setor (amarelo)
402:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
403:         WITH loc_oPagina.shp_4c_Shape3
404:             .Top           = 102 + 29
405:             .Left          = 532
406:             .Height        = 14
407:             .Width         = 14
408:             .BackStyle     = 1
409:             .SpecialEffect = 0
410:             .BackColor     = RGB(255, 255, 255)
411:             .Visible       = .T.
412:         ENDWITH
413: 
414:         loc_oPagina.AddObject("lbl_4c_LegIndividual", "Label")
415:         WITH loc_oPagina.lbl_4c_LegIndividual
416:             .AutoSize  = .T.
417:             .Caption   = "Individual"
418:             .Left      = 549
419:             .Top       = 101 + 29
420:             .FontName  = "Tahoma"
421:             .FontSize  = 8
422:             .ForeColor = RGB(90, 90, 90)
423:             .BackStyle = 0
424:             .Visible   = .T.
425:         ENDWITH
426: 
427:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
428:         WITH loc_oPagina.shp_4c_Shape1
429:             .Top           = 120 + 29
430:             .Left          = 532
431:             .Height        = 14
432:             .Width         = 14
433:             .BackStyle     = 1
434:             .SpecialEffect = 0
435:             .BackColor     = RGB(184, 213, 241)
436:             .Visible       = .T.
437:         ENDWITH
438: 
439:         loc_oPagina.AddObject("lbl_4c_LegResponsavel", "Label")
440:         WITH loc_oPagina.lbl_4c_LegResponsavel
441:             .AutoSize  = .T.
442:             .Caption   = "Respons" + CHR(225) + "vel"
443:             .Left      = 549
444:             .Top       = 119 + 29
445:             .FontName  = "Tahoma"
446:             .FontSize  = 8
447:             .ForeColor = RGB(90, 90, 90)
448:             .BackStyle = 0
449:             .Visible   = .T.
450:         ENDWITH
451: 
452:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
453:         WITH loc_oPagina.shp_4c_Shape2
454:             .Top           = 138 + 29
455:             .Left          = 532
456:             .Height        = 14
457:             .Width         = 14
458:             .BackStyle     = 1
459:             .SpecialEffect = 0
460:             .BackColor     = RGB(247, 244, 166)
461:             .Visible       = .T.
462:         ENDWITH
463: 
464:         loc_oPagina.AddObject("lbl_4c_LegSetor", "Label")
465:         WITH loc_oPagina.lbl_4c_LegSetor
466:             .AutoSize  = .T.
467:             .Caption   = "Setor"
468:             .Left      = 549
469:             .Top       = 137 + 29
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .ForeColor = RGB(90, 90, 90)
473:             .BackStyle = 0
474:             .Visible   = .T.
475:         ENDWITH
476: 
477:         *-- Container de Copia de Periodo (cntCopia: Top=262+29=291, Visible=.F.)
478:         loc_oPagina.AddObject("cnt_4c_Copia", "Container")
479:         WITH loc_oPagina.cnt_4c_Copia
480:             .Top           = 262 + 29
481:             .Left          = 226
482:             .Width         = 348
483:             .Height        = 87
484:             .BackColor     = RGB(255, 255, 255)
485:             .BorderWidth   = 1
486:             .SpecialEffect = 0
487:             .Visible       = .F.
488:         ENDWITH
489: 
490:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_TituloCopia", "Label")
491:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_TituloCopia
492:             .AutoSize  = .T.
493:             .Caption   = "C" + CHR(243) + "pia de Per" + CHR(237) + "odo"
494:             .Left      = 8
495:             .Top       = 6
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .FontBold  = .T.
499:             .ForeColor = RGB(90, 90, 90)
500:             .BackStyle = 0
501:             .Visible   = .T.
502:         ENDWITH
503: 
504:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_LblOrigem", "Label")
505:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_LblOrigem
506:             .AutoSize  = .F.
507:             .Caption   = "Per" + CHR(237) + "odo de Origem :"
508:             .Left      = 28
509:             .Top       = 32
510:             .Width     = 97
511:             .Height    = 15
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(90, 90, 90)
515:             .BackStyle = 0
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_BarraOrigem", "Label")
520:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_BarraOrigem
521:             .AutoSize  = .T.
522:             .Caption   = "/"
523:             .Left      = 157
524:             .Top       = 32
525:             .Width     = 8
526:             .Height    = 15
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .FontBold  = .T.
530:             .ForeColor = RGB(90, 90, 90)
531:             .BackStyle = 0
532:             .Visible   = .T.
533:         ENDWITH
534: 
535:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_OMess", "TextBox")
536:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_OMess
537:             .Top       = 29
538:             .Left      = 128
539:             .Width     = 24
540:             .InputMask = "99"
541:             .Value     = ""
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .Visible   = .T.
545:         ENDWITH
546: 
547:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_OAnos", "TextBox")
548:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_OAnos
549:             .Top       = 29
550:             .Left      = 166
551:             .Width     = 38
552:             .InputMask = "9999"
553:             .Value     = ""
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8
556:             .Visible   = .T.
557:         ENDWITH
558: 
559:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_LblDestino", "Label")
560:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_LblDestino
561:             .AutoSize  = .F.
562:             .Caption   = "Per" + CHR(237) + "odo de Destino :"
563:             .Left      = 26
564:             .Top       = 57
565:             .Width     = 99
566:             .Height    = 15
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:             .ForeColor = RGB(90, 90, 90)
570:             .BackStyle = 0
571:             .Visible   = .T.
572:         ENDWITH
573: 
574:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_BarraDestino", "Label")
575:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_BarraDestino
576:             .AutoSize  = .T.
577:             .Caption   = "/"
578:             .Left      = 157
579:             .Top       = 56
580:             .Width     = 8
581:             .Height    = 15
582:             .FontName  = "Tahoma"
583:             .FontSize  = 8
584:             .FontBold  = .T.
585:             .ForeColor = RGB(90, 90, 90)
586:             .BackStyle = 0
587:             .Visible   = .T.
588:         ENDWITH
589: 
590:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_DMess", "TextBox")
591:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_DMess
592:             .Top       = 53
593:             .Left      = 128
594:             .Width     = 24
595:             .InputMask = "99"
596:             .Value     = ""
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .Visible   = .T.
600:         ENDWITH
601: 
602:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_DAnos", "TextBox")
603:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_DAnos
604:             .Top       = 53
605:             .Left      = 166
606:             .Width     = 38
607:             .InputMask = "9999"
608:             .Value     = ""
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .Visible   = .T.
612:         ENDWITH
613: 
614:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CopiaOk", "CommandButton")
615:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaOk
616:             .Caption         = "\<Confirmar"
617:             .Picture         = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
618:             .PicturePosition = 1
619:             .Top             = 13
620:             .Left            = 217
621:             .Width           = 64
622:             .Height          = 55
623:             .FontName        = "Comic Sans MS"
624:             .FontSize        = 8
625:             .FontBold        = .T.
626:             .FontItalic      = .T.
627:             .ForeColor       = RGB(90, 90, 90)
628:             .BackColor       = RGB(255, 255, 255)
629:             .Themes          = .F.
630:             .Visible         = .T.
631:         ENDWITH
632: 
633:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CopiaCancel", "CommandButton")
634:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaCancel
635:             .Caption         = "Encerrar"
636:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
637:             .PicturePosition = 1
638:             .Top             = 13
639:             .Left            = 281
640:             .Width           = 64
641:             .Height          = 55
642:             .FontName        = "Comic Sans MS"
643:             .FontSize        = 8
644:             .FontBold        = .T.
645:             .FontItalic      = .T.
646:             .ForeColor       = RGB(90, 90, 90)
647:             .BackColor       = RGB(255, 255, 255)
648:             .Themes          = .F.
649:             .Visible         = .T.
650:         ENDWITH
651: 
652:         *-- Grid da lista (grade no legado: Top=155, Left=12, Height=439)
653:         *-- Compensacao PageFrame: Top = 155 + 29 = 184
654:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
655:         WITH loc_oPagina.grd_4c_Lista
656:             .Top                = 155 + 29
657:             .Left               = 12
658:             .Width              = 910
659:             .Height             = 439
660:             .ColumnCount        = 8
661:             .FontName           = "Tahoma"
662:             .FontSize           = 8

*-- Linhas 675 a 691:
675:         ENDWITH
676: 
677:         *-- BINDEVENTs dos botoes CRUD
678:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
679:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,"Click", THIS, "BtnVisualizarClick")
680:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
681:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
682:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
683:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
684:         BINDEVENT(loc_oPagina.cmd_4c_Copia,                    "Click", THIS, "BtnCopiaClick")
685:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaOk,    "Click", THIS, "BtnCopiaOkClick")
686:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaCancel,"Click", THIS, "BtnCopiaCancelarClick")
687: 
688:         *-- BINDEVENTs dos campos de filtro
689:         BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess, "KeyPress", THIS, "FiltroLostFocus")
690:         BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos, "KeyPress", THIS, "FiltroLostFocus")
691: 

*-- Linhas 711 a 1073:
711:         *-- Container Botoes Acao (Grupo_Salva no legado)
712:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
713:         WITH loc_oPagina.cnt_4c_BotoesAcao
714:             .Top         = 4 + 29
715:             .Left        = 842
716:             .Width       = 160
717:             .Height      = 85
718:             .BackStyle   = 0
719:             .BorderWidth = 0
720:             .Visible     = .T.
721:         ENDWITH
722: 
723:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
724:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
725:             .Caption         = "Confirmar"
726:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
727:             .PicturePosition = 13
728:             .Top             = 5
729:             .Left            = 5
730:             .Width           = 75
731:             .Height          = 75
732:             .BackColor       = RGB(255, 255, 255)
733:             .ForeColor       = RGB(90, 90, 90)
734:             .FontName        = "Comic Sans MS"
735:             .FontSize        = 8
736:             .FontBold        = .T.
737:             .FontItalic      = .T.
738:             .Themes          = .F.
739:             .SpecialEffect   = 0
740:             .MousePointer    = 15
741:             .WordWrap        = .T.
742:             .AutoSize        = .F.
743:             .Visible         = .T.
744:         ENDWITH
745: 
746:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
747:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
748:             .Caption         = "Encerrar"
749:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
750:             .PicturePosition = 13
751:             .Top             = 5
752:             .Left            = 80
753:             .Width           = 75
754:             .Height          = 75
755:             .BackColor       = RGB(255, 255, 255)
756:             .ForeColor       = RGB(90, 90, 90)
757:             .FontName        = "Comic Sans MS"
758:             .FontSize        = 8
759:             .FontBold        = .T.
760:             .FontItalic      = .T.
761:             .Themes          = .F.
762:             .SpecialEffect   = 0
763:             .MousePointer    = 15
764:             .WordWrap        = .T.
765:             .AutoSize        = .F.
766:             .Visible         = .T.
767:         ENDWITH
768: 
769:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
770:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
771: 
772:         *-- CAMPOS PARTE 1/2 (Fase 5): Usuario, Periodo, Tipo, Setor (labels + textboxes)
773:         *-- Compensacao PageFrame: Top = Top_original + 29
774: 
775:         *-- Label: Usuario (Label1 no legado: Left=197, Top=157, ForeColor=36,84,155, Verdana 8)
776:         loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
777:         WITH loc_oPagina.lbl_4c_Usuars
778:             .AutoSize  = .T.
779:             .Caption   = "Usu" + CHR(225) + "rio :"
780:             .Left      = 197
781:             .Top       = 157 + 29
782:             .Width     = 54
783:             .Height    = 15
784:             .FontName  = "Verdana"
785:             .FontSize  = 8
786:             .ForeColor = RGB(36, 84, 155)
787:             .BackStyle = 0
788:             .Visible   = .T.
789:         ENDWITH
790: 
791:         *-- TextBox: getUsuars (Left=251, Top=154, Width=80; lookup SigCdUsu)
792:         loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
793:         WITH loc_oPagina.txt_4c_Usuars
794:             .Left      = 251
795:             .Top       = 154 + 29
796:             .Width     = 80
797:             .Height    = 21
798:             .MaxLength = 10
799:             .Value     = ""
800:             .FontName  = "Tahoma"
801:             .FontSize  = 8
802:             .Visible   = .T.
803:         ENDWITH
804: 
805:         *-- Label: Periodo (Label9 no legado: Left=197, Top=182, Verdana 8, ForeColor=36,84,155)
806:         loc_oPagina.AddObject("lbl_4c_LblPeriodo", "Label")
807:         WITH loc_oPagina.lbl_4c_LblPeriodo
808:             .AutoSize  = .T.
809:             .Caption   = "Per" + CHR(237) + "odo :"
810:             .Left      = 197
811:             .Top       = 182 + 29
812:             .Width     = 54
813:             .Height    = 15
814:             .FontName  = "Verdana"
815:             .FontSize  = 8
816:             .ForeColor = RGB(36, 84, 155)
817:             .BackStyle = 0
818:             .Visible   = .T.
819:         ENDWITH
820: 
821:         *-- TextBox: getMess (Left=251, Top=179, Width=24, InputMask="99")
822:         loc_oPagina.AddObject("txt_4c_Mess", "TextBox")
823:         WITH loc_oPagina.txt_4c_Mess
824:             .Left      = 251
825:             .Top       = 179 + 29
826:             .Width     = 24
827:             .Height    = 21
828:             .InputMask = "99"
829:             .MaxLength = 2
830:             .Value     = ""
831:             .FontName  = "Tahoma"
832:             .FontSize  = 8
833:             .Visible   = .T.
834:         ENDWITH
835: 
836:         *-- Label: barra separadora de periodo (Label10: Left=282, Top=182)
837:         loc_oPagina.AddObject("lbl_4c_BarraPer", "Label")
838:         WITH loc_oPagina.lbl_4c_BarraPer
839:             .AutoSize  = .T.
840:             .Caption   = "/"
841:             .Left      = 282
842:             .Top       = 182 + 29
843:             .Width     = 7
844:             .Height    = 15
845:             .FontName  = "Verdana"
846:             .FontSize  = 8
847:             .ForeColor = RGB(36, 84, 155)
848:             .BackStyle = 0
849:             .Visible   = .T.
850:         ENDWITH
851: 
852:         *-- TextBox: getAnos (Left=293, Top=179, Width=38, InputMask="9999")
853:         loc_oPagina.AddObject("txt_4c_Anos", "TextBox")
854:         WITH loc_oPagina.txt_4c_Anos
855:             .Left      = 293
856:             .Top       = 179 + 29
857:             .Width     = 38
858:             .Height    = 21
859:             .InputMask = "9999"
860:             .MaxLength = 4
861:             .Value     = ""
862:             .FontName  = "Tahoma"
863:             .FontSize  = 8
864:             .Visible   = .T.
865:         ENDWITH
866: 
867:         *-- Label: Tipo (Label2 no legado: Left=216, Top=207, Width=35, Verdana 8)
868:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
869:         WITH loc_oPagina.lbl_4c_Tipo
870:             .AutoSize  = .T.
871:             .Caption   = "Tipo :"
872:             .Left      = 216
873:             .Top       = 207 + 29
874:             .Width     = 35
875:             .Height    = 15
876:             .FontName  = "Verdana"
877:             .FontSize  = 8
878:             .ForeColor = RGB(36, 84, 155)
879:             .BackStyle = 0
880:             .Visible   = .T.
881:         ENDWITH
882: 
883:         *-- TextBox: getIndivs (Left=251, Top=204, Width=17, InputMask="!" -> I/R/S)
884:         loc_oPagina.AddObject("txt_4c_Indivs", "TextBox")
885:         WITH loc_oPagina.txt_4c_Indivs
886:             .Left      = 251
887:             .Top       = 204 + 29
888:             .Width     = 17
889:             .Height    = 21
890:             .InputMask = "!"
891:             .MaxLength = 1
892:             .Value     = ""
893:             .FontName  = "Tahoma"
894:             .FontSize  = 8
895:             .Visible   = .T.
896:         ENDWITH
897: 
898:         *-- Label: ajuda tipo vendedor (Label7: Left=274, Top=207, Width=231)
899:         loc_oPagina.AddObject("lbl_4c_AjudaTipo", "Label")
900:         WITH loc_oPagina.lbl_4c_AjudaTipo
901:             .AutoSize  = .T.
902:             .Caption   = "( I )ndividual, ( R )Respons" + CHR(225) + "vel, ( S )etor"
903:             .Left      = 274
904:             .Top       = 207 + 29
905:             .Width     = 231
906:             .Height    = 15
907:             .FontName  = "Verdana"
908:             .FontSize  = 8
909:             .ForeColor = RGB(36, 84, 155)
910:             .BackStyle = 0
911:             .Visible   = .T.
912:         ENDWITH
913: 
914:         *-- Label: Setor (Label3 no legado: Left=209, Top=232, Width=42, Verdana 8)
915:         loc_oPagina.AddObject("lbl_4c_LblSetor", "Label")
916:         WITH loc_oPagina.lbl_4c_LblSetor
917:             .AutoSize  = .T.
918:             .Caption   = "Setor :"
919:             .Left      = 209
920:             .Top       = 232 + 29
921:             .Width     = 42
922:             .Height    = 15
923:             .FontName  = "Verdana"
924:             .FontSize  = 8
925:             .ForeColor = RGB(36, 84, 155)
926:             .BackStyle = 0
927:             .Visible   = .T.
928:         ENDWITH
929: 
930:         *-- TextBox: getSetors (Left=251, Top=229, Width=80; lookup SigCdSet)
931:         loc_oPagina.AddObject("txt_4c_Setors", "TextBox")
932:         WITH loc_oPagina.txt_4c_Setors
933:             .Left      = 251
934:             .Top       = 229 + 29
935:             .Width     = 80
936:             .Height    = 21
937:             .MaxLength = 10
938:             .Value     = ""
939:             .FontName  = "Tahoma"
940:             .FontSize  = 8
941:             .Visible   = .T.
942:         ENDWITH
943: 
944:         *-- Label: Responsavel (Label4 no legado: Left=168, Top=257, Width=83, Verdana 8)
945:         loc_oPagina.AddObject("lbl_4c_LblResponsavel", "Label")
946:         WITH loc_oPagina.lbl_4c_LblResponsavel
947:             .AutoSize  = .T.
948:             .Caption   = "Respons" + CHR(225) + "vel :"
949:             .Left      = 168
950:             .Top       = 257 + 29
951:             .Width     = 83
952:             .Height    = 15
953:             .FontName  = "Verdana"
954:             .FontSize  = 8
955:             .ForeColor = RGB(36, 84, 155)
956:             .BackStyle = 0
957:             .Visible   = .T.
958:         ENDWITH
959: 
960:         *-- TextBox: getSupervs (Left=251, Top=254, Width=80; lookup responsaveis em SigCcCmV/SigCdUsu)
961:         loc_oPagina.AddObject("txt_4c_Supervs", "TextBox")
962:         WITH loc_oPagina.txt_4c_Supervs
963:             .Left      = 251
964:             .Top       = 254 + 29
965:             .Width     = 80
966:             .Height    = 21
967:             .MaxLength = 10
968:             .Value     = ""
969:             .FontName  = "Tahoma"
970:             .FontSize  = 8
971:             .Visible   = .T.
972:         ENDWITH
973: 
974:         *-- Label: Adicional (Label5 no legado: Left=189, Top=282, Width=62, Verdana 8)
975:         loc_oPagina.AddObject("lbl_4c_LblAdicional", "Label")
976:         WITH loc_oPagina.lbl_4c_LblAdicional
977:             .AutoSize  = .T.
978:             .Caption   = "Adicional :"
979:             .Left      = 189
980:             .Top       = 282 + 29
981:             .Width     = 62
982:             .Height    = 15
983:             .FontName  = "Verdana"
984:             .FontSize  = 8
985:             .ForeColor = RGB(36, 84, 155)
986:             .BackStyle = 0
987:             .Visible   = .T.
988:         ENDWITH
989: 
990:         *-- TextBox: getAdics (Left=251, Top=279, Width=52)
991:         loc_oPagina.AddObject("txt_4c_Adics", "TextBox")
992:         WITH loc_oPagina.txt_4c_Adics
993:             .Left      = 251
994:             .Top       = 279 + 29
995:             .Width     = 52
996:             .Height    = 21
997:             .Value     = ""
998:             .FontName  = "Tahoma"
999:             .FontSize  = 8
1000:             .Visible   = .T.
1001:         ENDWITH
1002: 
1003:         *-- Label: % apos Adicional (Label8 no legado: Left=308, Top=282, Width=14, Verdana 8)
1004:         loc_oPagina.AddObject("lbl_4c_LblPctAdic", "Label")
1005:         WITH loc_oPagina.lbl_4c_LblPctAdic
1006:             .AutoSize  = .T.
1007:             .Caption   = "%"
1008:             .Left      = 308
1009:             .Top       = 282 + 29
1010:             .Width     = 14
1011:             .Height    = 15
1012:             .FontName  = "Verdana"
1013:             .FontSize  = 8
1014:             .ForeColor = RGB(36, 84, 155)
1015:             .BackStyle = 0
1016:             .Visible   = .T.
1017:         ENDWITH
1018: 
1019:         *-- Label: Minimo (Label6 no legado: Left=200, Top=307, Width=51, Verdana 8)
1020:         loc_oPagina.AddObject("lbl_4c_LblMinimo", "Label")
1021:         WITH loc_oPagina.lbl_4c_LblMinimo
1022:             .AutoSize  = .T.
1023:             .Caption   = "M" + CHR(237) + "nimo :"
1024:             .Left      = 200
1025:             .Top       = 307 + 29
1026:             .Width     = 51
1027:             .Height    = 15
1028:             .FontName  = "Verdana"
1029:             .FontSize  = 8
1030:             .ForeColor = RGB(36, 84, 155)
1031:             .BackStyle = 0
1032:             .Visible   = .T.
1033:         ENDWITH
1034: 
1035:         *-- TextBox: getMinimos (Left=251, Top=304, Width=101)
1036:         loc_oPagina.AddObject("txt_4c_Minimos", "TextBox")
1037:         WITH loc_oPagina.txt_4c_Minimos
1038:             .Left      = 251
1039:             .Top       = 304 + 29
1040:             .Width     = 101
1041:             .Height    = 21
1042:             .Value     = ""
1043:             .FontName  = "Tahoma"
1044:             .FontSize  = 8
1045:             .Visible   = .T.
1046:         ENDWITH
1047: 
1048:         *-- Label: Experiencia (Label11 no legado: Left=174, Top=332, Width=77, Verdana 8)
1049:         loc_oPagina.AddObject("lbl_4c_LblExperiencia", "Label")
1050:         WITH loc_oPagina.lbl_4c_LblExperiencia
1051:             .AutoSize  = .T.
1052:             .Caption   = "Experi" + CHR(234) + "ncia :"
1053:             .Left      = 174
1054:             .Top       = 332 + 29
1055:             .Width     = 77
1056:             .Height    = 15
1057:             .FontName  = "Verdana"
1058:             .FontSize  = 8
1059:             .ForeColor = RGB(36, 84, 155)
1060:             .BackStyle = 0
1061:             .Visible   = .T.
1062:         ENDWITH
1063: 
1064:         *-- TextBox: getMinExps (Left=251, Top=329, Width=101)
1065:         loc_oPagina.AddObject("txt_4c_MinExps", "TextBox")
1066:         WITH loc_oPagina.txt_4c_MinExps
1067:             .Left      = 251
1068:             .Top       = 329 + 29
1069:             .Width     = 101
1070:             .Height    = 21
1071:             .Value     = ""
1072:             .FontName  = "Tahoma"
1073:             .FontSize  = 8

*-- Linhas 1145 a 1160:
1145:                     loc_oGrid.Column8.Width = 100
1146: 
1147:                     *-- Headers (obrigatorio reconfigurar apos RecordSource)
1148:                     loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1149:                     loc_oGrid.Column2.Header1.Caption = "Ms"
1150:                     loc_oGrid.Column3.Header1.Caption = "Ano"
1151:                     loc_oGrid.Column4.Header1.Caption = "Tipo"
1152:                     loc_oGrid.Column5.Header1.Caption = "Setor"
1153:                     loc_oGrid.Column6.Header1.Caption = "Respons" + CHR(225) + "vel"
1154:                     loc_oGrid.Column7.Header1.Caption = "Adicional"
1155:                     loc_oGrid.Column8.Header1.Caption = "M" + CHR(237) + "nimo"
1156: 
1157:                     *-- Alinhamentos
1158:                     loc_oGrid.Column1.Alignment = 0
1159:                     loc_oGrid.Column2.Alignment = 2
1160:                     loc_oGrid.Column3.Alignment = 2

*-- Linhas 1210 a 1218:
1210:         THIS.HabilitarCampos(.T.)
1211:         THIS.AjustarBotoesPorModo()
1212:         THIS.AlternarPagina(2)
1213:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1214:     ENDPROC
1215: 
1216:     *--------------------------------------------------------------------------
1217:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
1218:     *--------------------------------------------------------------------------

*-- Linhas 1239 a 1247:
1239:             THIS.HabilitarCampos(.F.)
1240:             THIS.AjustarBotoesPorModo()
1241:             THIS.AlternarPagina(2)
1242:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
1243:         ENDIF
1244:     ENDPROC
1245: 
1246:     *--------------------------------------------------------------------------
1247:     * BtnAlterarClick - Alterar registro selecionado

*-- Linhas 1270 a 1278:
1270:             THIS.HabilitarCampos(.T.)
1271:             THIS.AjustarBotoesPorModo()
1272:             THIS.AlternarPagina(2)
1273:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1274:         ENDIF
1275:     ENDPROC
1276: 
1277:     *--------------------------------------------------------------------------
1278:     * BtnExcluirClick - Excluir registro selecionado

*-- Linhas 1376 a 1384:
1376:         loc_oPagina.grd_4c_Lista.Enabled         = .F.
1377:         loc_oPagina.cnt_4c_Saida.Enabled         = .F.
1378:         loc_oPagina.cnt_4c_Botoes.Enabled        = .F.
1379:         loc_oPagina.cmd_4c_Copia.Enabled         = .F.
1380:         THIS.pgf_4c_Paginas.Page2.Enabled        = .F.
1381: 
1382:         *-- Prefill com o periodo do filtro atual
1383:         WITH loc_oCopia
1384:             .txt_4c_OMess.Value = loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value

*-- Linhas 1402 a 1410:
1402:         loc_oPagina.grd_4c_Lista.Enabled         = .T.
1403:         loc_oPagina.cnt_4c_Saida.Enabled         = .T.
1404:         loc_oPagina.cnt_4c_Botoes.Enabled        = .T.
1405:         loc_oPagina.cmd_4c_Copia.Enabled         = .T.
1406:         THIS.pgf_4c_Paginas.Page2.Enabled        = .T.
1407: 
1408:         THIS.Refresh()
1409:         loc_oPagina.grd_4c_Lista.SetFocus
1410:     ENDPROC

*-- Linhas 1604 a 1612:
1604:             loc_oPg2.txt_4c_Minimos.ReadOnly = !loc_lHab
1605:             loc_oPg2.txt_4c_MinExps.ReadOnly = !loc_lHab
1606: 
1607:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
1608:         CATCH TO loc_oErro
1609:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1610:         ENDTRY
1611:     ENDPROC
1612: 

*-- Linhas 1620 a 1629:
1620:             loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1621:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1622: 
1623:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1624:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1625:         CATCH TO loc_oErro
1626:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1627:         ENDTRY
1628:     ENDPROC
1629: 


### BO (C:\4c\projeto\app\classes\CVIBO.prg):
*====================================================================
* CVIBO.prg
*
* Business Object para Comissoes de Vendedores Individuais
* Tabela principal: SigCcCmV (cIdChaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CVIBO AS BusinessBase

	*-- Propriedades da entidade (SigCcCmV)
	this_cCidChaves  = ""    && cIdChaves char(20)    - PK (UUID via fUniqueIds)
	this_cUsuars     = ""    && Usuars char(10)        - usuario (FK SigCdUsu.Usuarios)
	this_cMess       = ""    && Mess char(2)           - mes de referencia (MM)
	this_cAnos       = ""    && Anos char(4)           - ano de referencia (YYYY)
	this_cIndivs     = ""    && Indivs char(1)         - tipo: I=Individual R=Responsavel S=Setor
	this_cSetors     = ""    && Setors char(10)        - setor (FK SigCdSet.Setores)
	this_cSupervs    = ""    && Supervs char(10)       - responsavel (FK SigCcCmV.Usuars onde Indivs=R)
	this_nAdics      = 0     && Adics numeric(5,2)     - percentual adicional
	this_nMinimos    = 0     && Minimos numeric(11,2)  - valor minimo
	this_nMinExps    = 0     && MinExps numeric(11,2)  - experiencia minima

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmV"
		THIS.this_cCampoChave = "cIdChaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna PK para auditoria
	*====================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidChaves
	ENDPROC

	*====================================================================
	* Buscar - SELECT com filtro WHERE opcional
	* par_cFiltro: clausula WHERE sem a palavra WHERE (ex: "Mess='01' AND Anos='2026'")
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV"
			IF TYPE("par_cFiltro") = "C" AND !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF
			loc_cSQL = loc_cSQL + " ORDER BY Anos, Mess, Usuars"

			IF USED("crSigCcCmV")
				USE IN crSigCcCmV
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmV")
			IF loc_nResult > 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega BO pelo cIdChaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV WHERE cIdChaves = " + EscaparSQL(par_cChave)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Popula propriedades do BO a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAlias)
		LOCAL loc_lResultado
		loc_lResultado = .F.
		IF USED(par_cAlias)
			SELECT (par_cAlias)
			THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
			THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
			THIS.this_cMess      = TratarNulo(Mess,      "C")
			THIS.this_cAnos      = TratarNulo(Anos,      "C")
			THIS.this_cIndivs    = TratarNulo(Indivs,    "C")
			THIS.this_cSetors    = TratarNulo(Setors,    "C")
			THIS.this_cSupervs   = TratarNulo(Supervs,   "C")
			THIS.this_nAdics     = TratarNulo(Adics,     "N")
			THIS.this_nMinimos   = TratarNulo(Minimos,   "N")
			THIS.this_nMinExps   = TratarNulo(MinExps,   "N")
			loc_lResultado = .T.
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ValidarDados - Valida campos obrigatorios e regras de negocio
	*====================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido, loc_cSQLComI, loc_nResComI
		LOCAL loc_cSQLSupv, loc_nResSupv
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cUsuars))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Usu" + CHR(225) + "rio!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cMess))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o M" + CHR(234) + "s de Refer" + ;
				CHR(234) + "ncia!!!", "Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !(INT(VAL(THIS.this_cMess)) > 0)
			MsgAviso("M" + CHR(234) + "s de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cAnos))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Ano de Refer" + CHR(234) + "ncia!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !BETWEEN(INT(VAL(THIS.this_cAnos)), 1, 9999)
			MsgAviso("Ano de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIndivs))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Status de Tipo de Vendedor!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !INLIST(ALLTRIM(THIS.this_cIndivs), "I", "R", "S")
			MsgAviso("Observe a Informa" + CHR(231) + CHR(227) + "o na Tela ao Lado do Tipo de Vendedor!!!" + CHR(13) + ;
				"Voc" + CHR(234) + " Est" + CHR(225) + " Tentando Usar Um Tipo de Vendedor Que N" + CHR(227) + "o Existe!!!", ;
				"Aten" + CHR(231) + CHR(227) + "o!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_nMinimos = 0
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Valor M" + CHR(237) + "nimo!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "I" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser Individual e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "S" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser de Setor e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND !EMPTY(ALLTRIM(THIS.this_cSupervs))
			MsgAviso("O Respons" + CHR(225) + "vel N" + CHR(227) + "o Pode Ter Um Respons" + CHR(225) + "vel Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND ;
			EMPTY(ALLTRIM(THIS.this_cSetors)) AND THIS.this_nAdics = 0
			MsgAviso("O Vendedor Respons" + CHR(225) + "vel Tem Que Ter Um Adicional Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		*-- Verificar se usuario ja cadastrado no periodo em SigCcCmI (Vendedor por Cargo)
		IF loc_lValido
			loc_cSQLComI = "SELECT Usuars, Mess, Anos, cIdChaves FROM SigCcCmI" + ;
				" WHERE Usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars))

			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF

			loc_nResComI = SQLEXEC(gnConnHandle, loc_cSQLComI, "cursor_4c_ComI")
			IF loc_nResComI > 0
				SELECT cursor_4c_ComI
				SCAN
					IF ALLTRIM(cursor_4c_ComI.Mess) = ALLTRIM(THIS.this_cMess) AND ;
					   ALLTRIM(cursor_4c_ComI.Anos) = ALLTRIM(THIS.this_cAnos)
						MsgAviso("Usu" + CHR(225) + "rio J" + CHR(225) + " Cadastrado No Per" + ;
							CHR(237) + "odo Como Vendedor Por Cargo!!!", ;
							"Valida" + CHR(231) + CHR(227) + "o")
						loc_lValido = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF
			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF
		ENDIF

		*-- Verificar se supervisor ja tem vinculo no mesmo periodo (se tem setor definido)
		IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cSetors))
			loc_cSQLSupv = "SELECT Usuars FROM SigCcCmV" + ;
				" WHERE Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ;
				" AND Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + ;
				" AND Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ;
				" AND cIdChaves <> " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF

			loc_nResSupv = SQLEXEC(gnConnHandle, loc_cSQLSupv, "cursor_4c_Supv")
			IF loc_nResSupv > 0 AND RECCOUNT("cursor_4c_Supv") > 0
				SELECT cursor_4c_Supv
				GO TOP
				IF !EOF("cursor_4c_Supv")
					MsgAviso("Usu" + CHR(225) + "rio Cadastrado Como Vendedor Respons" + CHR(225) + "vel!!!", ;
						"Valida" + CHR(231) + CHR(227) + "o")
					loc_lValido = .F.
				ENDIF
			ENDIF
			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
				THIS.this_cCidChaves = fUniqueIds()
			ENDIF

			loc_cSQL = "INSERT INTO SigCcCmV" + ;
				" (cIdChaves, Usuars, Mess, Anos, Indivs, Setors, Supervs, Adics, Minimos, MinExps)" + ;
				" VALUES (" + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cMess)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + ", " + ;
				FormatarNumeroSQL(THIS.this_nAdics) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinExps) + ")"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "UPDATE SigCcCmV SET" + ;
				" Usuars = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + "," + ;
				" Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + "," + ;
				" Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + "," + ;
				" Indivs = " + EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + "," + ;
				" Setors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + "," + ;
				" Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + "," + ;
				" Adics = " + FormatarNumeroSQL(THIS.this_nAdics) + "," + ;
				" Minimos = " + FormatarNumeroSQL(THIS.this_nMinimos) + "," + ;
				" MinExps = " + FormatarNumeroSQL(THIS.this_nMinExps) + ;
				" WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "DELETE FROM SigCcCmV WHERE cIdChaves = " + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CopiarPeriodo - Copia comissoes de um periodo de origem para destino
	* par_cOMess/par_cOAnos: periodo de origem (MM/YYYY)
	* par_cDMess/par_cDAnos: periodo de destino (MM/YYYY)
	* Retorna .T. se ao menos um registro foi gerado com sucesso
	*====================================================================
	PROCEDURE CopiarPeriodo(par_cOMess, par_cOAnos, par_cDMess, par_cDAnos)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_llIns, loc_llOks, loc_lcMsg, loc_llPular
		LOCAL loc_nConnFP2, loc_oProg
		LOCAL loc_cSQLFop, loc_nResFop
		LOCAL loc_cSQLBusca, loc_nResBusca
		LOCAL loc_cNovaChave, loc_cSQLIns, loc_nResIns
		LOCAL loc_cUsar, loc_cIndv, loc_cSet, loc_cSup
		LOCAL loc_nAdi, loc_nMin, loc_nMinEx

		loc_lResultado = .F.
		loc_llIns      = .F.
		loc_llOks      = .T.
		loc_lcMsg      = ""
		loc_llPular    = .F.
		loc_nConnFP2   = 0
		loc_oProg      = .NULL.

		TRY
			*-- Buscar todos os registros do periodo de origem
			loc_cSQL = "SELECT * FROM SigCcCmV" + ;
				" WHERE Mess = " + EscaparSQL(par_cOMess) + ;
				" AND Anos = " + EscaparSQL(par_cOAnos) + ;
				" ORDER BY Usuars"

			IF USED("crOrigem")
				USE IN crOrigem
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crOrigem")
			IF loc_nResult < 1
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem:" + CHR(13) + ;
					CapturarErroSQL(), "Erro SQL")
			ELSE
				SELECT crOrigem
				GO TOP
				IF EOF("crOrigem")
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + CHR(237) + ;
						"odo de Origem Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
				ELSE
					*-- Tentar conexao secundaria para folha de pagamento
					loc_nConnFP2 = SQLCONNECT("SigCcCMV_FOPAGV")

					*-- Criar barra de progresso
					loc_oProg = CREATEOBJECT("fwprogressbar", ;
						"Processando Vendedores...", RECCOUNT("crOrigem") + 1)
					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Show()
					ENDIF

					SELECT crOrigem
					SCAN
						*-- Capturar valores do registro atual antes de mudar area de trabalho
						loc_cUsar  = ALLTRIM(crOrigem.Usuars)
						loc_cIndv  = ALLTRIM(crOrigem.Indivs)
						loc_cSet   = ALLTRIM(crOrigem.Setors)
						loc_cSup   = ALLTRIM(crOrigem.Supervs)
						loc_nAdi   = crOrigem.Adics
						loc_nMin   = crOrigem.Minimos
						loc_nMinEx = crOrigem.MinExps
						loc_llPular = .F.

						IF VARTYPE(loc_oProg) = "O"
							loc_oProg.Update(.T.)
							IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
								loc_oProg.SubTitulo.Caption = "Processando o Vendedor : " + loc_cUsar
							ENDIF
						ENDIF

						*-- Verificar atividade na folha de pagamento (se conexao disponivel)
						IF loc_nConnFP2 > 0
							loc_cSQLFop = "SELECT Funcs, Conds FROM FopCff" + ;
								" WHERE Funcs = " + EscaparSQL(loc_cUsar) + ;
								" ORDER BY Funcs"

							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF

							loc_nResFop = SQLEXEC(loc_nConnFP2, loc_cSQLFop, "crFopCff")
							IF loc_nResFop > 0
								SELECT crFopCff
								GO TOP
								IF EOF("crFopCff") OR INLIST(ALLTRIM(crFopCff.Conds), "D", "Q")
									loc_lcMsg = loc_lcMsg + loc_cUsar + ;
										IIF(!EOF("crFopCff"), "(" + ALLTRIM(crFopCff.Conds) + "); ", "; ")
									loc_llPular = .T.
								ENDIF
							ENDIF
							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF
						ENDIF

						IF !loc_llPular
							*-- Verificar se ja existe no periodo de destino
							loc_cSQLBusca = "SELECT cIdChaves FROM SigCcCmV" + ;
								" WHERE Usuars = " + EscaparSQL(loc_cUsar) + ;
								" AND Indivs = " + EscaparSQL(loc_cIndv) + ;
								" AND Setors = " + EscaparSQL(loc_cSet) + ;
								" AND Mess = " + EscaparSQL(par_cDMess) + ;
								" AND Anos = " + EscaparSQL(par_cDAnos)

							IF USED("crBusca")
								USE IN crBusca
							ENDIF

							loc_nResBusca = SQLEXEC(gnConnHandle, loc_cSQLBusca, "crBusca")
							IF loc_nResBusca > 0
								SELECT crBusca
								GO TOP
								IF EOF("crBusca")
									*-- Inserir novo registro no periodo de destino
									loc_cNovaChave = fUniqueIds()
									loc_cSQLIns = "INSERT INTO SigCcCmV" + ;
										" (cIdChaves, Usuars, Mess, Anos, Indivs," + ;
										" Setors, Supervs, Adics, Minimos, MinExps)" + ;
										" VALUES (" + ;
										EscaparSQL(loc_cNovaChave) + ", " + ;
										EscaparSQL(loc_cUsar) + ", " + ;
										EscaparSQL(par_cDMess) + ", " + ;
										EscaparSQL(par_cDAnos) + ", " + ;
										EscaparSQL(loc_cIndv) + ", " + ;
										EscaparSQL(loc_cSet) + ", " + ;
										EscaparSQL(loc_cSup) + ", " + ;
										FormatarNumeroSQL(loc_nAdi) + ", " + ;
										FormatarNumeroSQL(loc_nMin) + ", " + ;
										FormatarNumeroSQL(loc_nMinEx) + ")"

									loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)
									IF loc_nResIns > 0
										loc_llIns = .T.
									ELSE
										MsgErro("Falha ao inserir vendedor " + loc_cUsar + ":" + ;
											CHR(13) + CapturarErroSQL(), "Erro SQL")
										loc_llOks = .F.
									ENDIF
								ENDIF
							ENDIF
							IF USED("crBusca")
								USE IN crBusca
							ENDIF
						ENDIF

						IF !loc_llOks
							EXIT
						ENDIF
					ENDSCAN

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Update(.T.)
						IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
							loc_oProg.SubTitulo.Caption = "Atualizando Os Registros"
						ENDIF
					ENDIF

					IF loc_llIns
						IF loc_llOks
							IF !EMPTY(loc_lcMsg)
								MsgAviso("N" + CHR(227) + "o Gerados: " + loc_lcMsg, ;
									"C" + CHR(243) + "pia Parcialmente Conclu" + CHR(237) + "da")
							ELSE
								MsgInfo("Os Registros Foram Gerados Com Sucesso!!!", ;
									"C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
							ENDIF
							loc_lResultado = .T.
						ELSE
							MsgErro("Houve Uma Falha na Grava" + CHR(231) + CHR(227) + ;
								"o e Os Registros N" + CHR(195) + "O Foram Gerados!!!", "Erro!!!")
						ENDIF
					ELSE
						MsgAviso("Nenhum Registro Foi Gerado!!!", ;
							"C" + CHR(243) + "pia Conclu" + CHR(237) + "da Sem Sucesso")
					ENDIF

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Complete()
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CopiarPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		*-- Limpeza de cursores e conexao secundaria (FORA do TRY)
		IF USED("crOrigem")
			USE IN crOrigem
		ENDIF
		IF USED("crFopCff")
			USE IN crFopCff
		ENDIF
		IF USED("crBusca")
			USE IN crBusca
		ENDIF
		IF loc_nConnFP2 > 0
			SQLDISCONNECT(loc_nConnFP2)
		ENDIF

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

