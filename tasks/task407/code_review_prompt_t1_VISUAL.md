# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 179: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 203: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 251: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 312: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 420: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 444: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 481: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formepd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2274 linhas total):

*-- Linhas 81 a 97:
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount  = 2
84:             .Left       = 0
85:             .Top        = -29
86:             .Width      = THIS.Width
87:             .Height     = THIS.Height + 29
88:             .Tabs       = .F.
89:             .Visible    = .T.
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page2.Caption   = "Dados"
93:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(236, 233, 216)
95:             .Page2.BackColor = RGB(236, 233, 216)
96:         ENDWITH
97:     ENDPROC

*-- Linhas 109 a 334:
109:         *-- Container cabe?alho escuro com t?tulo (cntSombra no legado)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 2
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
123:             .Top       = 15
124:             .Left      = 10
125:             .Width     = THIS.Width - 12
126:             .Height    = 40
127:             .FontName  = "Tahoma"
128:             .FontSize  = 16
129:             .FontBold  = .T.
130:             .ForeColor = RGB(0, 0, 0)
131:             .BackStyle = 0
132:             .AutoSize  = .F.
133:             .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Top       = 18
140:             .Left      = 10
141:             .Width     = THIS.Width - 12
142:             .Height    = 46
143:             .FontName  = "Tahoma"
144:             .FontSize  = 16
145:             .FontBold  = .T.
146:             .ForeColor = RGB(255, 255, 255)
147:             .BackStyle = 0
148:             .AutoSize  = .F.
149:             .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         *-- Container bot?es CRUD lado direito (Grupo_Op no legado)
154:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:         WITH loc_oPagina.cnt_4c_Botoes
156:             .Top         = 0
157:             .Left        = 542
158:             .Width       = 390
159:             .Height      = 85
160:             .BackStyle   = 1
161:             .BackColor   = RGB(53, 53, 53)
162:             .BorderWidth = 0
163:             .Visible     = .T.
164:         ENDWITH
165: 
166:         loc_oBotoes = loc_oPagina.cnt_4c_Botoes
167: 
168:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
169:         WITH loc_oBotoes.cmd_4c_Incluir
170:             .Caption         = "Incluir"
171:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
172:             .PicturePosition = 13
173:             .Top             = 5
174:             .Left            = 5
175:             .Width           = 75
176:             .Height          = 75
177:             .BackColor       = RGB(255, 255, 255)
178:             .ForeColor       = RGB(90, 90, 90)
179:             .FontName        = "Comic Sans MS"
180:             .FontSize        = 8
181:             .FontBold        = .T.
182:             .FontItalic      = .T.
183:             .Themes          = .F.
184:             .SpecialEffect   = 0
185:             .MousePointer    = 15
186:             .WordWrap        = .T.
187:             .AutoSize        = .F.
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
193:         WITH loc_oBotoes.cmd_4c_Visualizar
194:             .Caption         = "Visualizar"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
196:             .PicturePosition = 13
197:             .Top             = 5
198:             .Left            = 80
199:             .Width           = 75
200:             .Height          = 75
201:             .BackColor       = RGB(255, 255, 255)
202:             .ForeColor       = RGB(90, 90, 90)
203:             .FontName        = "Comic Sans MS"
204:             .FontSize        = 8
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .Themes          = .F.
208:             .SpecialEffect   = 0
209:             .MousePointer    = 15
210:             .WordWrap        = .T.
211:             .AutoSize        = .F.
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
215: 
216:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
217:         WITH loc_oBotoes.cmd_4c_Alterar
218:             .Caption         = "Alterar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:             .PicturePosition = 13
221:             .Top             = 5
222:             .Left            = 155
223:             .Width           = 75
224:             .Height          = 75
225:             .BackColor       = RGB(255, 255, 255)
226:             .ForeColor       = RGB(90, 90, 90)
227:             .FontName        = "Comic Sans MS"
228:             .FontSize        = 8
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .MousePointer    = 15
234:             .WordWrap        = .T.
235:             .AutoSize        = .F.
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
241:         WITH loc_oBotoes.cmd_4c_Excluir
242:             .Caption         = "Excluir"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 230
247:             .Width           = 75
248:             .Height          = 75
249:             .BackColor       = RGB(255, 255, 255)
250:             .ForeColor       = RGB(90, 90, 90)
251:             .FontName        = "Comic Sans MS"
252:             .FontSize        = 8
253:             .FontBold        = .T.
254:             .FontItalic      = .T.
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
263: 
264:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
265:         WITH loc_oBotoes.cmd_4c_Buscar
266:             .Caption         = "Buscar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 305
271:             .Width           = 75
272:             .Height          = 75
273:             .BackColor       = RGB(255, 255, 255)
274:             .ForeColor       = RGB(90, 90, 90)
275:             .FontName        = "Comic Sans MS"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
287: 
288:         *-- Container Encerrar - padr?o can?nico (Left=917, Width=90, cmd Width=75)
289:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
290:         WITH loc_oPagina.cnt_4c_Saida
291:             .Top         = 29
292:             .Left        = 917
293:             .Width       = 90
294:             .Height      = 85
295:             .BackStyle   = 0
296:             .BorderWidth = 0
297:             .Visible     = .T.
298:         ENDWITH
299: 
300:         loc_oSaida = loc_oPagina.cnt_4c_Saida
301:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
302:         WITH loc_oSaida.cmd_4c_Encerrar
303:             .Caption         = "Encerrar"
304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
305:             .PicturePosition = 13
306:             .Top             = 5
307:             .Left            = 5
308:             .Width           = 75
309:             .Height          = 75
310:             .BackColor       = RGB(255, 255, 255)
311:             .ForeColor       = RGB(90, 90, 90)
312:             .FontName        = "Comic Sans MS"
313:             .FontSize        = 8
314:             .FontBold        = .T.
315:             .FontItalic      = .T.
316:             .Themes          = .F.
317:             .SpecialEffect   = 0
318:             .MousePointer    = 15
319:             .WordWrap        = .T.
320:             .AutoSize        = .F.
321:             .Visible         = .T.
322:         ENDWITH
323:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
324: 
325:         *-- Grid principal (grd_4c_Lista) - registros de SigCdNec
326:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
327:         loc_oGrid = loc_oPagina.grd_4c_Lista
328:         loc_oGrid.Top         = 88
329:         loc_oGrid.Left        = 5
330:         loc_oGrid.Width       = 905
331:         loc_oGrid.Height      = 490
332:         loc_oGrid.ColumnCount = 7
333: 
334:         WITH loc_oGrid

*-- Linhas 352 a 384:
352:         WITH loc_oGrid.Column1
353:             .Width           = 75
354:             .Alignment       = 2
355:             .Header1.Caption = "C" + CHR(243) + "digo"
356:         ENDWITH
357:         WITH loc_oGrid.Column2
358:             .Width           = 80
359:             .Header1.Caption = "Data"
360:         ENDWITH
361:         WITH loc_oGrid.Column3
362:             .Width           = 90
363:             .Header1.Caption = "Gr. Origem"
364:         ENDWITH
365:         WITH loc_oGrid.Column4
366:             .Width           = 130
367:             .Header1.Caption = "Ct. Origem"
368:         ENDWITH
369:         WITH loc_oGrid.Column5
370:             .Width           = 90
371:             .Header1.Caption = "Gr. Destino"
372:         ENDWITH
373:         WITH loc_oGrid.Column6
374:             .Width           = 130
375:             .Header1.Caption = "Ct. Destino"
376:         ENDWITH
377:         WITH loc_oGrid.Column7
378:             .Width           = 100
379:             .Header1.Caption = "Usu" + CHR(225) + "rio"
380:         ENDWITH
381: 
382:         THIS.TornarControlesVisiveis(loc_oPagina)
383:     ENDPROC
384: 

*-- Linhas 395 a 749:
395:         *-- Container bot" + CHR(245) + "es Confirmar/Cancelar (Grupo_Salva no legado)
396:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao
398:             .Top         = 33
399:             .Left        = 842
400:             .Width       = 160
401:             .Height      = 85
402:             .BackStyle   = 0
403:             .BorderWidth = 0
404:             .Visible     = .T.
405:         ENDWITH
406: 
407:         loc_oSalva = loc_oPagina.cnt_4c_BotoesAcao
408: 
409:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oSalva.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Comic Sans MS"
421:             .FontSize        = 8
422:             .FontBold        = .T.
423:             .FontItalic      = .T.
424:             .Themes          = .F.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .AutoSize        = .F.
429:             .Visible         = .T.
430:         ENDWITH
431:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
432: 
433:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
434:         WITH loc_oSalva.cmd_4c_Cancelar
435:             .Caption         = "Encerrar"
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
437:             .PicturePosition = 13
438:             .Top             = 5
439:             .Left            = 80
440:             .Width           = 75
441:             .Height          = 75
442:             .BackColor       = RGB(255, 255, 255)
443:             .ForeColor       = RGB(90, 90, 90)
444:             .FontName        = "Comic Sans MS"
445:             .FontSize        = 8
446:             .FontBold        = .T.
447:             .FontItalic      = .T.
448:             .Themes          = .F.
449:             .SpecialEffect   = 0
450:             .MousePointer    = 15
451:             .WordWrap        = .T.
452:             .AutoSize        = .F.
453:             .Visible         = .T.
454:         ENDWITH
455:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
456: 
457:         *-- Container Encerrar - padr" + CHR(227) + "o can" + CHR(244) + "nico
458:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
459:         WITH loc_oPagina.cnt_4c_Saida
460:             .Top         = 29
461:             .Left        = 917
462:             .Width       = 90
463:             .Height      = 85
464:             .BackStyle   = 0
465:             .BorderWidth = 0
466:             .Visible     = .T.
467:         ENDWITH
468: 
469:         loc_oSaida = loc_oPagina.cnt_4c_Saida
470:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
471:         WITH loc_oSaida.cmd_4c_Encerrar
472:             .Caption         = "Encerrar"
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
474:             .PicturePosition = 13
475:             .Top             = 5
476:             .Left            = 5
477:             .Width           = 75
478:             .Height          = 75
479:             .BackColor       = RGB(255, 255, 255)
480:             .ForeColor       = RGB(90, 90, 90)
481:             .FontName        = "Comic Sans MS"
482:             .FontSize        = 8
483:             .FontBold        = .T.
484:             .FontItalic      = .T.
485:             .Themes          = .F.
486:             .SpecialEffect   = 0
487:             .MousePointer    = 15
488:             .WordWrap        = .T.
489:             .AutoSize        = .F.
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
493: 
494:         *-- Bot" + CHR(245) + "es de a" + CHR(231) + CHR(227) + "o no topo da Page2 (top=6+29=35)
495:         loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
496:         WITH loc_oPagina.cmd_4c_Operacao
497:             .Caption       = "\<Movimento"
498:             .Top           = 35
499:             .Left          = 616
500:             .Width         = 70
501:             .Height        = 25
502:             .BackColor     = RGB(255, 255, 255)
503:             .ForeColor     = RGB(90, 90, 90)
504:             .FontName      = "Tahoma"
505:             .FontSize      = 8
506:             .Themes        = .F.
507:             .SpecialEffect = 0
508:             .Visible       = .T.
509:         ENDWITH
510:         BINDEVENT(loc_oPagina.cmd_4c_Operacao, "Click", THIS, "BtnOperacaoClick")
511: 
512:         loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
513:         WITH loc_oPagina.cmd_4c_Boleto
514:             .Caption       = "\<Boleto"
515:             .Top           = 35
516:             .Left          = 692
517:             .Width         = 70
518:             .Height        = 25
519:             .BackColor     = RGB(255, 255, 255)
520:             .ForeColor     = RGB(90, 90, 90)
521:             .FontName      = "Tahoma"
522:             .FontSize      = 8
523:             .Themes        = .F.
524:             .SpecialEffect = 0
525:             .Visible       = .T.
526:         ENDWITH
527:         BINDEVENT(loc_oPagina.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")
528: 
529:         loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
530:         WITH loc_oPagina.cmd_4c_Documento
531:             .Caption       = "\<Documento"
532:             .Top           = 35
533:             .Left          = 768
534:             .Width         = 70
535:             .Height        = 25
536:             .BackColor     = RGB(255, 255, 255)
537:             .ForeColor     = RGB(90, 90, 90)
538:             .FontName      = "Tahoma"
539:             .FontSize      = 8
540:             .Themes        = .F.
541:             .SpecialEffect = 0
542:             .Visible       = .T.
543:         ENDWITH
544:         BINDEVENT(loc_oPagina.cmd_4c_Documento, "Click", THIS, "BtnDocumentoClick")
545: 
546:         *-- Separador visual (shpBtnGs no legado, top=143+29=172)
547:         loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
548:         WITH loc_oPagina.shp_4c_ShpBtnGs
549:             .Top     = 172
550:             .Left    = 635
551:             .Width   = 18
552:             .Height  = 50
553:             .Visible = .T.
554:         ENDWITH
555: 
556:         *-- Container1: C" + CHR(243) + "digo e Data (top=268+29=297)
557:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
558:         WITH loc_oPagina.cnt_4c_Container1
559:             .Top         = 297
560:             .Left        = 214
561:             .Width       = 571
562:             .Height      = 75
563:             .BackStyle   = 1
564:             .BackColor   = RGB(236, 233, 216)
565:             .BorderWidth = 0
566:             .Visible     = .T.
567:         ENDWITH
568: 
569:         loc_oCnt = loc_oPagina.cnt_4c_Container1
570: 
571:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
572:         WITH loc_oCnt.lbl_4c_Label1
573:             .Caption   = "C" + CHR(243) + "digo"
574:             .Top       = 8
575:             .Left      = 11
576:             .Width     = 80
577:             .Height    = 17
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .ForeColor = RGB(90, 90, 90)
581:             .BackStyle = 0
582:             .Visible   = .T.
583:         ENDWITH
584: 
585:         loc_oCnt.AddObject("txt_4c_Numps", "TextBox")
586:         WITH loc_oCnt.txt_4c_Numps
587:             .Top      = 28
588:             .Left     = 11
589:             .Width    = 81
590:             .Height   = 22
591:             .FontName = "Tahoma"
592:             .FontSize = 8
593:             .Value    = 0
594:             .Visible  = .T.
595:         ENDWITH
596: 
597:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
598:         WITH loc_oCnt.lbl_4c_Label2
599:             .Caption   = "Data"
600:             .Top       = 8
601:             .Left      = 109
602:             .Width     = 60
603:             .Height    = 17
604:             .FontName  = "Tahoma"
605:             .FontSize  = 8
606:             .ForeColor = RGB(90, 90, 90)
607:             .BackStyle = 0
608:             .Visible   = .T.
609:         ENDWITH
610: 
611:         loc_oCnt.AddObject("txt_4c_Datas", "TextBox")
612:         WITH loc_oCnt.txt_4c_Datas
613:             .Top      = 28
614:             .Left     = 109
615:             .Width    = 80
616:             .Height   = 22
617:             .FontName = "Tahoma"
618:             .FontSize = 8
619:             .Value    = {}
620:             .Visible  = .T.
621:         ENDWITH
622: 
623:         loc_oCnt.AddObject("lin_4c_Line1", "Line")
624:         WITH loc_oCnt.lin_4c_Line1
625:             .Top     = 24
626:             .Left    = 11
627:             .Width   = 340
628:             .Height  = 0
629:             .Visible = .T.
630:         ENDWITH
631: 
632:         *-- Container Origem: Grupo/Conta/Nome de Origem (top=349+29=378)
633:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
634:         WITH loc_oPagina.cnt_4c_Origem
635:             .Top         = 378
636:             .Left        = 214
637:             .Width       = 571
638:             .Height      = 75
639:             .BackStyle   = 1
640:             .BackColor   = RGB(236, 233, 216)
641:             .BorderWidth = 0
642:             .Visible     = .T.
643:         ENDWITH
644: 
645:         loc_oCnt = loc_oPagina.cnt_4c_Origem
646: 
647:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
648:         WITH loc_oCnt.lbl_4c_Label4
649:             .Caption   = "Origem"
650:             .Top       = 6
651:             .Left      = 11
652:             .Width     = 80
653:             .Height    = 17
654:             .FontName  = "Tahoma"
655:             .FontSize  = 8
656:             .FontBold  = .T.
657:             .ForeColor = RGB(90, 90, 90)
658:             .BackStyle = 0
659:             .Visible   = .T.
660:         ENDWITH
661: 
662:         loc_oCnt.AddObject("lin_4c_line12", "Line")
663:         WITH loc_oCnt.lin_4c_line12
664:             .Top     = 22
665:             .Left    = 12
666:             .Width   = 340
667:             .Height  = 0
668:             .Visible = .T.
669:         ENDWITH
670: 
671:         loc_oCnt.AddObject("lbl_4c_label12", "Label")
672:         WITH loc_oCnt.lbl_4c_label12
673:             .Caption   = "Grupo"
674:             .Top       = 27
675:             .Left      = 11
676:             .Width     = 60
677:             .Height    = 17
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .ForeColor = RGB(90, 90, 90)
681:             .BackStyle = 0
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         loc_oCnt.AddObject("lbl_4c_label22", "Label")
686:         WITH loc_oCnt.lbl_4c_label22
687:             .Caption   = "Conta"
688:             .Top       = 27
689:             .Left      = 96
690:             .Width     = 60
691:             .Height    = 17
692:             .FontName  = "Tahoma"
693:             .FontSize  = 8
694:             .ForeColor = RGB(90, 90, 90)
695:             .BackStyle = 0
696:             .Visible   = .T.
697:         ENDWITH
698: 
699:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
700:         WITH loc_oCnt.lbl_4c_Label3
701:             .Caption   = "Nome"
702:             .Top       = 27
703:             .Left      = 180
704:             .Width     = 60
705:             .Height    = 17
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .ForeColor = RGB(90, 90, 90)
709:             .BackStyle = 0
710:             .Visible   = .T.
711:         ENDWITH
712: 
713:         loc_oCnt.AddObject("txt_4c_GrupoOs", "TextBox")
714:         WITH loc_oCnt.txt_4c_GrupoOs
715:             .Top      = 42
716:             .Left     = 11
717:             .Width    = 80
718:             .Height   = 22
719:             .FontName = "Tahoma"
720:             .FontSize = 8
721:             .Value    = ""
722:             .Visible  = .T.
723:         ENDWITH
724:         BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsKeyPress")
725:         BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsLostFocus")
726: 
727:         loc_oCnt.AddObject("txt_4c_ContaOs", "TextBox")
728:         WITH loc_oCnt.txt_4c_ContaOs
729:             .Top      = 42
730:             .Left     = 96
731:             .Width    = 80
732:             .Height   = 22
733:             .FontName = "Tahoma"
734:             .FontSize = 8
735:             .Value    = ""
736:             .Visible  = .T.
737:         ENDWITH
738:         BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsKeyPress")
739:         BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsLostFocus")
740: 
741:         loc_oCnt.AddObject("txt_4c_NomeContaOs", "TextBox")
742:         WITH loc_oCnt.txt_4c_NomeContaOs
743:             .Top      = 42
744:             .Left     = 180
745:             .Width    = 360
746:             .Height   = 22
747:             .FontName = "Tahoma"
748:             .FontSize = 8
749:             .Value    = ""

*-- Linhas 755 a 872:
755:         *-- Container Destino: Grupo/Conta/Nome de Destino (top=429+29=458)
756:         loc_oPagina.AddObject("cnt_4c_Destino", "Container")
757:         WITH loc_oPagina.cnt_4c_Destino
758:             .Top         = 458
759:             .Left        = 214
760:             .Width       = 571
761:             .Height      = 75
762:             .BackStyle   = 1
763:             .BackColor   = RGB(236, 233, 216)
764:             .BorderWidth = 0
765:             .Visible     = .T.
766:         ENDWITH
767: 
768:         loc_oCnt = loc_oPagina.cnt_4c_Destino
769: 
770:         loc_oCnt.AddObject("lbl_4c_label42", "Label")
771:         WITH loc_oCnt.lbl_4c_label42
772:             .Caption   = "Destino"
773:             .Top       = 6
774:             .Left      = 11
775:             .Width     = 80
776:             .Height    = 17
777:             .FontName  = "Tahoma"
778:             .FontSize  = 8
779:             .FontBold  = .T.
780:             .ForeColor = RGB(90, 90, 90)
781:             .BackStyle = 0
782:             .Visible   = .T.
783:         ENDWITH
784: 
785:         loc_oCnt.AddObject("lin_4c_line13", "Line")
786:         WITH loc_oCnt.lin_4c_line13
787:             .Top     = 22
788:             .Left    = 12
789:             .Width   = 340
790:             .Height  = 0
791:             .Visible = .T.
792:         ENDWITH
793: 
794:         loc_oCnt.AddObject("lbl_4c_label13", "Label")
795:         WITH loc_oCnt.lbl_4c_label13
796:             .Caption   = "Grupo"
797:             .Top       = 27
798:             .Left      = 11
799:             .Width     = 60
800:             .Height    = 17
801:             .FontName  = "Tahoma"
802:             .FontSize  = 8
803:             .ForeColor = RGB(90, 90, 90)
804:             .BackStyle = 0
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         loc_oCnt.AddObject("lbl_4c_label23", "Label")
809:         WITH loc_oCnt.lbl_4c_label23
810:             .Caption   = "Conta"
811:             .Top       = 27
812:             .Left      = 96
813:             .Width     = 60
814:             .Height    = 17
815:             .FontName  = "Tahoma"
816:             .FontSize  = 8
817:             .ForeColor = RGB(90, 90, 90)
818:             .BackStyle = 0
819:             .Visible   = .T.
820:         ENDWITH
821: 
822:         loc_oCnt.AddObject("lbl_4c_label32", "Label")
823:         WITH loc_oCnt.lbl_4c_label32
824:             .Caption   = "Nome"
825:             .Top       = 27
826:             .Left      = 180
827:             .Width     = 60
828:             .Height    = 17
829:             .FontName  = "Tahoma"
830:             .FontSize  = 8
831:             .ForeColor = RGB(90, 90, 90)
832:             .BackStyle = 0
833:             .Visible   = .T.
834:         ENDWITH
835: 
836:         loc_oCnt.AddObject("txt_4c_GrupoDs", "TextBox")
837:         WITH loc_oCnt.txt_4c_GrupoDs
838:             .Top      = 42
839:             .Left     = 11
840:             .Width    = 80
841:             .Height   = 22
842:             .FontName = "Tahoma"
843:             .FontSize = 8
844:             .Value    = ""
845:             .Visible  = .T.
846:         ENDWITH
847:         BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsKeyPress")
848:         BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsLostFocus")
849: 
850:         loc_oCnt.AddObject("txt_4c_ContaDs", "TextBox")
851:         WITH loc_oCnt.txt_4c_ContaDs
852:             .Top      = 42
853:             .Left     = 96
854:             .Width    = 80
855:             .Height   = 22
856:             .FontName = "Tahoma"
857:             .FontSize = 8
858:             .Value    = ""
859:             .Visible  = .T.
860:         ENDWITH
861:         BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsKeyPress")
862:         BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsLostFocus")
863: 
864:         loc_oCnt.AddObject("txt_4c_NomeContaDs", "TextBox")
865:         WITH loc_oCnt.txt_4c_NomeContaDs
866:             .Top      = 42
867:             .Left     = 180
868:             .Width    = 360
869:             .Height   = 22
870:             .FontName = "Tahoma"
871:             .FontSize = 8
872:             .Value    = ""

*-- Linhas 878 a 995:
878:         *-- Container Responsavel: Grupo/Conta/Nome do Responsavel (top=508+29=537)
879:         loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
880:         WITH loc_oPagina.cnt_4c_Responsavel
881:             .Top         = 537
882:             .Left        = 214
883:             .Width       = 571
884:             .Height      = 75
885:             .BackStyle   = 1
886:             .BackColor   = RGB(236, 233, 216)
887:             .BorderWidth = 0
888:             .Visible     = .T.
889:         ENDWITH
890: 
891:         loc_oCnt = loc_oPagina.cnt_4c_Responsavel
892: 
893:         loc_oCnt.AddObject("lbl_4c_label43", "Label")
894:         WITH loc_oCnt.lbl_4c_label43
895:             .Caption   = "Respons" + CHR(225) + "vel"
896:             .Top       = 6
897:             .Left      = 11
898:             .Width     = 80
899:             .Height    = 17
900:             .FontName  = "Tahoma"
901:             .FontSize  = 8
902:             .FontBold  = .T.
903:             .ForeColor = RGB(90, 90, 90)
904:             .BackStyle = 0
905:             .Visible   = .T.
906:         ENDWITH
907: 
908:         loc_oCnt.AddObject("lin_4c_line14", "Line")
909:         WITH loc_oCnt.lin_4c_line14
910:             .Top     = 22
911:             .Left    = 12
912:             .Width   = 340
913:             .Height  = 0
914:             .Visible = .T.
915:         ENDWITH
916: 
917:         loc_oCnt.AddObject("lbl_4c_label14", "Label")
918:         WITH loc_oCnt.lbl_4c_label14
919:             .Caption   = "Grupo"
920:             .Top       = 27
921:             .Left      = 11
922:             .Width     = 60
923:             .Height    = 17
924:             .FontName  = "Tahoma"
925:             .FontSize  = 8
926:             .ForeColor = RGB(90, 90, 90)
927:             .BackStyle = 0
928:             .Visible   = .T.
929:         ENDWITH
930: 
931:         loc_oCnt.AddObject("lbl_4c_label24", "Label")
932:         WITH loc_oCnt.lbl_4c_label24
933:             .Caption   = "Conta"
934:             .Top       = 27
935:             .Left      = 96
936:             .Width     = 60
937:             .Height    = 17
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .ForeColor = RGB(90, 90, 90)
941:             .BackStyle = 0
942:             .Visible   = .T.
943:         ENDWITH
944: 
945:         loc_oCnt.AddObject("lbl_4c_label33", "Label")
946:         WITH loc_oCnt.lbl_4c_label33
947:             .Caption   = "Nome"
948:             .Top       = 27
949:             .Left      = 180
950:             .Width     = 60
951:             .Height    = 17
952:             .FontName  = "Tahoma"
953:             .FontSize  = 8
954:             .ForeColor = RGB(90, 90, 90)
955:             .BackStyle = 0
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         loc_oCnt.AddObject("txt_4c_GrVends", "TextBox")
960:         WITH loc_oCnt.txt_4c_GrVends
961:             .Top      = 42
962:             .Left     = 11
963:             .Width    = 80
964:             .Height   = 22
965:             .FontName = "Tahoma"
966:             .FontSize = 8
967:             .Value    = ""
968:             .Visible  = .T.
969:         ENDWITH
970:         BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsKeyPress")
971:         BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsLostFocus")
972: 
973:         loc_oCnt.AddObject("txt_4c_Vends", "TextBox")
974:         WITH loc_oCnt.txt_4c_Vends
975:             .Top      = 42
976:             .Left     = 96
977:             .Width    = 80
978:             .Height   = 22
979:             .FontName = "Tahoma"
980:             .FontSize = 8
981:             .Value    = ""
982:             .Visible  = .T.
983:         ENDWITH
984:         BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsKeyPress")
985:         BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsLostFocus")
986: 
987:         loc_oCnt.AddObject("txt_4c_NomeVends", "TextBox")
988:         WITH loc_oCnt.txt_4c_NomeVends
989:             .Top      = 42
990:             .Left     = 180
991:             .Width    = 360
992:             .Height   = 22
993:             .FontName = "Tahoma"
994:             .FontSize = 8
995:             .Value    = ""

*-- Linhas 1001 a 1010:
1001:         *-- Grade de Operacao (top=68+29=97, Visible=.F. por padrao)
1002:         loc_oPagina.AddObject("grd_4c_GradeOperacao", "Grid")
1003:         WITH loc_oPagina.grd_4c_GradeOperacao
1004:             .Top         = 97
1005:             .Left        = 266
1006:             .Width       = 171
1007:             .Height      = 182
1008:             .ColumnCount = 1
1009:             .FontName    = "Tahoma"
1010:             .FontSize    = 8

*-- Linhas 1021 a 1048:
1021: 
1022:         WITH loc_oPagina.grd_4c_GradeOperacao.Column1
1023:             .Width           = 165
1024:             .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
1025:         ENDWITH
1026: 
1027:         *-- Botao de Ordens ao lado da grade (top=69+29=98)
1028:         loc_oPagina.AddObject("cmd_4c_BotOrdens", "CommandButton")
1029:         WITH loc_oPagina.cmd_4c_BotOrdens
1030:             .Caption       = "..."
1031:             .Top           = 98
1032:             .Left          = 440
1033:             .Width         = 40
1034:             .Height        = 40
1035:             .BackColor     = RGB(255, 255, 255)
1036:             .ForeColor     = RGB(90, 90, 90)
1037:             .FontName      = "Tahoma"
1038:             .FontSize      = 8
1039:             .Themes        = .F.
1040:             .SpecialEffect = 0
1041:             .Visible       = .T.
1042:         ENDWITH
1043:         BINDEVENT(loc_oPagina.cmd_4c_BotOrdens, "Click", THIS, "BtnBotOrdensClick")
1044: 
1045:         THIS.TornarControlesVisiveis(loc_oPagina)
1046:     ENDPROC
1047: 
1048:     *==========================================================================

*-- Linhas 1076 a 1090:
1076:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usuars"
1077: 
1078:                     *-- Reconfigurar headers ap?s RecordSource (VFP reseta ao mudar RecordSource)
1079:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1080:                     loc_oGrid.Column2.Header1.Caption = "Data"
1081:                     loc_oGrid.Column3.Header1.Caption = "Gr. Origem"
1082:                     loc_oGrid.Column4.Header1.Caption = "Ct. Origem"
1083:                     loc_oGrid.Column5.Header1.Caption = "Gr. Destino"
1084:                     loc_oGrid.Column6.Header1.Caption = "Ct. Destino"
1085:                     loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
1086: 
1087:                     THIS.FormatarGridLista(loc_oGrid)
1088:                     loc_lResultado = .T.
1089:                 ENDIF
1090:             ENDIF

*-- Linhas 2086 a 2094:
2086:                         loc_oGrade.ColumnCount = 1
2087:                         loc_oGrade.RecordSource          = "cursor_4c_Operacoes"
2088:                         loc_oGrade.Column1.ControlSource = "cursor_4c_Operacoes.nops"
2089:                         loc_oGrade.Column1.Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
2090:                         loc_oGrade.Visible = .T.
2091:                         loc_lResultado     = .T.
2092:                     ENDIF
2093:                 ELSE
2094:                     loc_oGrade.Visible = .T.

*-- Linhas 2219 a 2229:
2219:         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Enabled  = par_lHabilitar
2220:         loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Enabled    = par_lHabilitar
2221:         loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.ReadOnly = .T.
2222:         loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
2223:         loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
2224:         loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
2225:     ENDPROC
2226: 
2227:     *--------------------------------------------------------------------------
2228:     * LimparCampos - Limpa valores dos campos na Page2
2229:     *--------------------------------------------------------------------------

*-- Linhas 2253 a 2265:
2253:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
2254:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2255: 
2256:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
2257:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2258:         loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
2259:         loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
2260:         loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
2261:     ENDPROC
2262: 
2263:     *==========================================================================
2264:     * DESTRUI" + CHR(199) + CHR(195) + "O
2265:     *==========================================================================


### BO (C:\4c\projeto\app\classes\epdBO.prg):
*******************************************************************************
* epdBO.prg - Business Object para Finalizacao Antecipada
* Tabela principal: SigCdNec
* Chave: EmpDNps (Emps C3 + Dopps C20 + Str(Numps,10))
*******************************************************************************

DEFINE CLASS epdBO AS BusinessBase

    *-- Chave primaria composta
    this_cEmpDNps    = ""    && C(33) Chave: Emps+Dopps+Str(Numps,10)
    this_cEmpDNpsC   = ""    && C(29) Chave curta: Emps+Dopps+Str(Numps,6)

    *-- Campos de SigCdNec (confirmados por ControlSource)
    this_cEmps       = ""    && C(3)  Empresa
    this_cDopps      = ""    && C(20) Tipo de Operacao (fixo: ENCERRAMENTO DIRETO)
    this_nNumps      = 0     && N(10) Numero do necessario (codigo)
    this_dDatas      = {}    && D     Data de finalizacao

    *-- Origem (ControlSource: tmpnens.grupoos, tmpnens.contaos)
    this_cGrupoOs    = ""    && C     Grupo de origem
    this_cContaOs    = ""    && C     Conta de origem (IClis)

    *-- Destino (ControlSource: tmpnens.grupods, tmpnens.contads)
    this_cGrupoDs    = ""    && C     Grupo de destino
    this_cContaDs    = ""    && C     Conta de destino (IClis)

    *-- Responsavel (ControlSource: tmpnens.grvends, tmpnens.vends)
    this_cGrVends    = ""    && C     Grupo do responsavel
    this_cVends      = ""    && C     Conta do responsavel (IClis)

    *-- Controles operacionais (propriedades do form original)
    this_cDopp       = ""    && C(20) Operacao fixa ENCERRAMENTO DIRETO
    this_lAutomatico = .F.   && L     Modo automatico (parametro)
    this_lEditaOrig  = .T.   && L     Permite editar origem (editaorigem)
    this_nNops       = 0     && N     Numero da ordem de producao

    *====================================================================
    PROCEDURE Init()
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "EmpDNps"
            THIS.this_cDopp       = PADR("ENCERRAMENTO DIRETO", 20)
            loc_lResultado        = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *====================================================================
        RETURN THIS.this_cEmpDNps
    ENDPROC

    *====================================================================
    FUNCTION Buscar(par_cFiltro)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cOpI, loc_cOpF
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cOpI     = loc_cEmpresa + THIS.this_cDopp + STR(0,          10)
            loc_cOpF     = loc_cEmpresa + THIS.this_cDopp + STR(9999999999, 10)

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps BETWEEN " + EscaparSQL(loc_cOpI) + " AND " + EscaparSQL(loc_cOpF)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numps"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    FUNCTION CarregarPorCodigo(par_cChave)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps = " + EscaparSQL(par_cChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado       = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps     = TratarNulo(emps,    "C")
                THIS.this_cDopps    = TratarNulo(dopps,   "C")
                THIS.this_nNumps    = TratarNulo(numps,   "N")
                THIS.this_dDatas    = TratarNulo(datas,   "D")
                THIS.this_cGrupoOs  = TratarNulo(grupoos, "C")
                THIS.this_cContaOs  = TratarNulo(contaos, "C")
                THIS.this_cGrupoDs  = TratarNulo(grupods, "C")
                THIS.this_cContaDs  = TratarNulo(contads, "C")
                THIS.this_cGrVends  = TratarNulo(grvends, "C")
                THIS.this_cVends    = TratarNulo(vends,   "C")
                THIS.this_cEmpDNps  = TratarNulo(empdnps, "C")
                THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                      STR(THIS.this_nNumps, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Inserir()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCidChave
        loc_lResultado = .F.

        TRY
            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_cDopps = THIS.this_cDopp

            THIS.this_cEmpDNps  = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 10)
            THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 6)

            loc_cCidChave = SUBSTR(THIS.this_cEmpDNps, 14, 20)

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (emps, dopps, numps, datas," + ;
                       "  grupoos, contaos, grupods, contads," + ;
                       "  grvends, vends, empdnps, cidchaves, usuars," + ;
                       "  chksubn, totpesos, imprs, lccs, procbals, procdbal," + ;
                       "  docus, locals, ntrans, nops, naceites, entrabs," + ;
                       "  autos, libprods, codnconfs, numbalds, numbals, codobs," + ;
                       "  empds, nconforms, nlotes, jobs, pesolancs, usulins," + ;
                       "  chkbaixa, usuconfs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps)    + "," + ;
                       EscaparSQL(THIS.this_cDopps)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas)   + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       EscaparSQL(THIS.this_cEmpDNps)  + "," + ;
                       EscaparSQL(loc_cCidChave)       + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + "," + ;
                       "0,0,0,0,0,0," + ;
                       "'          ','          ',0,0,0,0," + ;
                       "0,'          ','          ',0,0,0," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ",0,0,'          ',0," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ",0,'          ')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Atualizar()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       "  grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       "  contaos = " + EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       "  grupods = " + EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       "  contads = " + EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       "  grvends = " + EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       "  vends   = " + EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       "  usuars  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ;
                       " WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDNps)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Excluir itens de SigCdNei primeiro (integridade referencial)
            loc_cSQL    = "DELETE FROM SigCdNei WHERE empdnps = " + ;
                          EscaparSQL(THIS.this_cEmpDNps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens (SigCdNei):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal de SigCdNec
                loc_cSQL    = "DELETE FROM SigCdNec WHERE empdnps = " + ;
                              EscaparSQL(THIS.this_cEmpDNps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

