# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 170: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 193: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 239: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 262: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 297: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 368: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 391: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1721 linhas total):

*-- Linhas 69 a 85:
69:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
70:         THIS.pgf_4c_Paginas.PageCount = 2
71:         WITH THIS.pgf_4c_Paginas
72:             .Top        = -29
73:             .Left       = 0
74:             .Width      = THIS.Width
75:             .Height     = THIS.Height + 29
76:             .Tabs       = .F.
77:             .TabStretch = 1
78:             .Visible    = .T.
79:             .Page1.Caption   = "Lista"
80:             .Page2.Caption   = "Dados"
81:             .Page1.BackColor = RGB(100, 100, 100)
82:             .Page2.BackColor = RGB(100, 100, 100)
83:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
84:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85:         ENDWITH

*-- Linhas 100 a 137:
100:         *-- Container cabecalho cinza escuro
101:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
102:         WITH loc_oPagina.cnt_4c_Cabecalho
103:             .Top         = 31
104:             .Left        = 0
105:             .Width       = THIS.Width
106:             .Height      = 80
107:             .BackColor   = RGB(100, 100, 100)
108:             .BorderWidth = 0
109:             .Visible     = .T.
110:         ENDWITH
111: 
112:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
113:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
114:             .Caption   = THIS.Caption
115:             .Top       = 15
116:             .Left      = 10
117:             .Width     = 769
118:             .Height    = 40
119:             .FontName  = "Tahoma"
120:             .FontSize  = 16
121:             .FontBold  = .T.
122:             .ForeColor = RGB(0, 0, 0)
123:             .BackStyle = 0
124:             .AutoSize  = .F.
125:             .Visible   = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
130:             .Caption   = THIS.Caption
131:             .Top       = 18
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 46
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.

*-- Linhas 144 a 318:
144:         *-- Container botoes CRUD (lado direito - canonico Left=542)
145:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
146:         WITH loc_oPagina.cnt_4c_Botoes
147:             .Top         = 29
148:             .Left        = 542
149:             .Width       = 390
150:             .Height      = 85
151:             .BackStyle   = 1
152:             .BackColor   = RGB(53, 53, 53)
153:             .BorderWidth = 0
154:             .Visible     = .T.
155:         ENDWITH
156: 
157:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
158: 
159:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
160:         WITH loc_oCnt.cmd_4c_Incluir
161:             .Caption         = "Incluir"
162:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
163:             .PicturePosition = 13
164:             .Top             = 5
165:             .Left            = 5
166:             .Width           = 75
167:             .Height          = 75
168:             .BackColor       = RGB(255, 255, 255)
169:             .ForeColor       = RGB(90, 90, 90)
170:             .FontName        = "Comic Sans MS"
171:             .FontBold        = .T.
172:             .FontItalic      = .T.
173:             .FontSize        = 8
174:             .Themes          = .F.
175:             .SpecialEffect   = 0
176:             .WordWrap        = .T.
177:             .MousePointer    = 15
178:             .Visible         = .T.
179:         ENDWITH
180:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
181: 
182:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
183:         WITH loc_oCnt.cmd_4c_Visualizar
184:             .Caption         = "Visualizar"
185:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
186:             .PicturePosition = 13
187:             .Top             = 5
188:             .Left            = 80
189:             .Width           = 75
190:             .Height          = 75
191:             .BackColor       = RGB(255, 255, 255)
192:             .ForeColor       = RGB(90, 90, 90)
193:             .FontName        = "Comic Sans MS"
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .FontSize        = 8
197:             .Themes          = .F.
198:             .SpecialEffect   = 0
199:             .WordWrap        = .T.
200:             .MousePointer    = 15
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
204: 
205:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
206:         WITH loc_oCnt.cmd_4c_Alterar
207:             .Caption         = "Alterar"
208:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
209:             .PicturePosition = 13
210:             .Top             = 5
211:             .Left            = 155
212:             .Width           = 75
213:             .Height          = 75
214:             .BackColor       = RGB(255, 255, 255)
215:             .ForeColor       = RGB(90, 90, 90)
216:             .FontName        = "Comic Sans MS"
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .FontSize        = 8
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .WordWrap        = .T.
223:             .MousePointer    = 15
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
227: 
228:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
229:         WITH loc_oCnt.cmd_4c_Excluir
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
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .FontSize        = 8
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .WordWrap        = .T.
246:             .MousePointer    = 15
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
250: 
251:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
252:         WITH loc_oCnt.cmd_4c_Buscar
253:             .Caption         = "Buscar"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 305
258:             .Width           = 75
259:             .Height          = 75
260:             .BackColor       = RGB(255, 255, 255)
261:             .ForeColor       = RGB(90, 90, 90)
262:             .FontName        = "Comic Sans MS"
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .FontSize        = 8
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .WordWrap        = .T.
269:             .MousePointer    = 15
270:             .Visible         = .T.
271:         ENDWITH
272:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
273: 
274:         *-- Container Encerrar canonico (Left=917, Width=90, Height=85)
275:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
276:         WITH loc_oPagina.cnt_4c_Saida
277:             .Top         = 29
278:             .Left        = 917
279:             .Width       = 90
280:             .Height      = 85
281:             .BackStyle   = 0
282:             .BorderWidth = 0
283:             .Visible     = .T.
284:         ENDWITH
285: 
286:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
287:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
288:             .Caption         = "Encerrar"
289:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
290:             .PicturePosition = 13
291:             .Top             = 5
292:             .Left            = 5
293:             .Width           = 75
294:             .Height          = 75
295:             .BackColor       = RGB(255, 255, 255)
296:             .ForeColor       = RGB(90, 90, 90)
297:             .FontName        = "Comic Sans MS"
298:             .FontBold        = .T.
299:             .FontItalic      = .T.
300:             .FontSize        = 8
301:             .Themes          = .F.
302:             .SpecialEffect   = 0
303:             .WordWrap        = .T.
304:             .MousePointer    = 15
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
308: 
309:         *-- Grid de lista (5 colunas: grupos, ests, icms, tpicms, tptribs)
310:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
311:         WITH loc_oPagina.grd_4c_Lista
312:             .Top                = 117
313:             .Left               = 26
314:             .Width              = 890
315:             .Height             = 498
316:             .ColumnCount        = 5
317:             .DeleteMark         = .F.
318:             .RecordMark         = .F.

*-- Linhas 345 a 660:
345:         *-- Container botoes Confirmar/Cancelar
346:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
347:         WITH loc_oPagina.cnt_4c_BotoesAcao
348:             .Top         = 33
349:             .Left        = 842
350:             .Width       = 160
351:             .Height      = 85
352:             .BackStyle   = 0
353:             .Visible     = .T.
354:         ENDWITH
355:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
356: 
357:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
358:         WITH loc_oCnt.cmd_4c_Confirmar
359:             .Caption         = "Confirmar"
360:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
361:             .PicturePosition = 13
362:             .Top             = 5
363:             .Left            = 5
364:             .Width           = 75
365:             .Height          = 75
366:             .BackColor       = RGB(255, 255, 255)
367:             .ForeColor       = RGB(90, 90, 90)
368:             .FontName        = "Comic Sans MS"
369:             .FontBold        = .T.
370:             .FontItalic      = .T.
371:             .FontSize        = 8
372:             .Themes          = .F.
373:             .SpecialEffect   = 0
374:             .WordWrap        = .T.
375:             .MousePointer    = 15
376:             .Visible         = .T.
377:         ENDWITH
378:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
379: 
380:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
381:         WITH loc_oCnt.cmd_4c_Cancelar
382:             .Caption         = "Encerrar"
383:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
384:             .PicturePosition = 13
385:             .Top             = 5
386:             .Left            = 80
387:             .Width           = 75
388:             .Height          = 75
389:             .BackColor       = RGB(255, 255, 255)
390:             .ForeColor       = RGB(90, 90, 90)
391:             .FontName        = "Comic Sans MS"
392:             .FontBold        = .T.
393:             .FontItalic      = .T.
394:             .FontSize        = 8
395:             .Themes          = .F.
396:             .SpecialEffect   = 0
397:             .WordWrap        = .T.
398:             .MousePointer    = 15
399:             .Visible         = .T.
400:         ENDWITH
401:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
402: 
403:         *-- Linha 1: Grupo (Say8 + txt_4c_Cgru + txt_4c_Dgru)
404:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
405:         WITH loc_oPagina.lbl_4c_Label8
406:             .Caption   = "Grupo : "
407:             .Top       = 173
408:             .Left      = 262
409:             .Width     = 50
410:             .Height    = 15
411:             .FontName  = "Verdana"
412:             .FontSize  = 8
413:             .ForeColor = RGB(36, 84, 155)
414:             .BackStyle = 0
415:             .Visible   = .T.
416:         ENDWITH
417: 
418:         loc_oPagina.AddObject("txt_4c_Cgru", "TextBox")
419:         WITH loc_oPagina.txt_4c_Cgru
420:             .Top       = 170
421:             .Left      = 311
422:             .Width     = 31
423:             .Height    = 23
424:             .MaxLength = 3
425:             .FontName  = "Verdana"
426:             .FontSize  = 8
427:             .Value     = ""
428:             .Visible   = .T.
429:         ENDWITH
430:         BINDEVENT(loc_oPagina.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupo")
431: 
432:         loc_oPagina.AddObject("txt_4c_Dgru", "TextBox")
433:         WITH loc_oPagina.txt_4c_Dgru
434:             .Top       = 170
435:             .Left      = 344
436:             .Width     = 150
437:             .Height    = 23
438:             .MaxLength = 20
439:             .FontName  = "Verdana"
440:             .FontSize  = 8
441:             .Value     = ""
442:             .Visible   = .T.
443:         ENDWITH
444:         BINDEVENT(loc_oPagina.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoDesc")
445: 
446:         *-- Linha 2: Estado (Say3 + txt_4c_Estado)
447:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
448:         WITH loc_oPagina.lbl_4c_Label3
449:             .Caption   = "Estado : "
450:             .Top       = 198
451:             .Left      = 259
452:             .FontName  = "Verdana"
453:             .FontSize  = 8
454:             .ForeColor = RGB(36, 84, 155)
455:             .BackStyle = 0
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
460:         WITH loc_oPagina.txt_4c_Estado
461:             .Top       = 195
462:             .Left      = 311
463:             .Width     = 24
464:             .Height    = 23
465:             .MaxLength = 2
466:             .Format    = "K!"
467:             .FontName  = "Verdana"
468:             .FontSize  = 8
469:             .Value     = ""
470:             .Visible   = .T.
471:         ENDWITH
472:         BINDEVENT(loc_oPagina.txt_4c_Estado, "KeyPress", THIS, "ValidarEstado")
473: 
474:         *-- Linha 3: Aliq. ICMS (Say2 + txt_4c_Icm)
475:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
476:         WITH loc_oPagina.lbl_4c_Label2
477:             .Caption   = "Aliq. (%) : "
478:             .Top       = 223
479:             .Left      = 246
480:             .Width     = 66
481:             .Height    = 15
482:             .FontName  = "Verdana"
483:             .FontSize  = 8
484:             .ForeColor = RGB(36, 84, 155)
485:             .BackStyle = 0
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         loc_oPagina.AddObject("txt_4c_Icm", "TextBox")
490:         WITH loc_oPagina.txt_4c_Icm
491:             .Top       = 220
492:             .Left      = 311
493:             .Width     = 52
494:             .Height    = 23
495:             .InputMask = "999.99"
496:             .FontName  = "Verdana"
497:             .FontSize  = 8
498:             .Value     = 0
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         *-- Linha 4: Tipo ICMS (txt_4c_Tpicm + Say1 + Say4)
503:         loc_oPagina.AddObject("txt_4c_Tpicm", "TextBox")
504:         WITH loc_oPagina.txt_4c_Tpicm
505:             .Top       = 245
506:             .Left      = 311
507:             .Width     = 17
508:             .Height    = 23
509:             .MaxLength = 1
510:             .Format    = "K!"
511:             .FontName  = "Verdana"
512:             .FontSize  = 8
513:             .Value     = ""
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
518:         WITH loc_oPagina.lbl_4c_Label1
519:             .Caption   = "Tipo : "
520:             .Top       = 248
521:             .Left      = 273
522:             .FontName  = "Verdana"
523:             .FontSize  = 8
524:             .ForeColor = RGB(36, 84, 155)
525:             .BackStyle = 0
526:             .Visible   = .T.
527:         ENDWITH
528: 
529:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
530:         WITH loc_oPagina.lbl_4c_Label4
531:             .Caption   = "(T / S / I / N / F)"
532:             .Top       = 248
533:             .Left      = 333
534:             .FontName  = "Verdana"
535:             .FontSize  = 8
536:             .ForeColor = RGB(36, 84, 155)
537:             .BackStyle = 0
538:             .Visible   = .T.
539:         ENDWITH
540: 
541:         *-- Linha 5: Tipo de Tributacao do ICMS (Say5 + txt_4c_TpTrib)
542:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
543:         WITH loc_oPagina.lbl_4c_Label5
544:             .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS : "
545:             .Top       = 275
546:             .Left      = 138
547:             .Width     = 174
548:             .FontName  = "Verdana"
549:             .FontSize  = 8
550:             .ForeColor = RGB(36, 84, 155)
551:             .BackStyle = 0
552:             .Visible   = .T.
553:         ENDWITH
554: 
555:         loc_oPagina.AddObject("txt_4c_TpTrib", "TextBox")
556:         WITH loc_oPagina.txt_4c_TpTrib
557:             .Top       = 270
558:             .Left      = 311
559:             .Width     = 38
560:             .Height    = 23
561:             .MaxLength = 4
562:             .FontName  = "Verdana"
563:             .FontSize  = 8
564:             .Value     = ""
565:             .Visible   = .T.
566:         ENDWITH
567:         BINDEVENT(loc_oPagina.txt_4c_TpTrib, "KeyPress", THIS, "ValidarTpTrib")
568: 
569:         *-- Linha 6: Situacao Tributaria ICMS (Say6 + txt_4c_Sittricm + txt_4c_Dsittricm)
570:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
571:         WITH loc_oPagina.lbl_4c_Label6
572:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
573:             .Top       = 300
574:             .Left      = 154
575:             .Width     = 154
576:             .FontName  = "Verdana"
577:             .FontSize  = 8
578:             .ForeColor = RGB(36, 84, 155)
579:             .BackStyle = 0
580:             .Visible   = .T.
581:         ENDWITH
582: 
583:         loc_oPagina.AddObject("txt_4c_Sittricm", "TextBox")
584:         WITH loc_oPagina.txt_4c_Sittricm
585:             .Top       = 295
586:             .Left      = 311
587:             .Width     = 31
588:             .Height    = 23
589:             .MaxLength = 3
590:             .FontName  = "Verdana"
591:             .FontSize  = 8
592:             .Value     = ""
593:             .Visible   = .T.
594:         ENDWITH
595:         BINDEVENT(loc_oPagina.txt_4c_Sittricm, "KeyPress", THIS, "ValidarSittricm")
596: 
597:         loc_oPagina.AddObject("txt_4c_Dsittricm", "TextBox")
598:         WITH loc_oPagina.txt_4c_Dsittricm
599:             .Top       = 295
600:             .Left      = 344
601:             .Width     = 290
602:             .Height    = 23
603:             .MaxLength = 40
604:             .Format    = "!"
605:             .FontName  = "Verdana"
606:             .FontSize  = 8
607:             .Value     = ""
608:             .Visible   = .T.
609:         ENDWITH
610:         BINDEVENT(loc_oPagina.txt_4c_Dsittricm, "KeyPress", THIS, "ValidarDsittricm")
611: 
612:         *-- Linha 7: CFOP (Say7 + txt_4c_Cfop) + Classificacao Fiscal (Say14 + txt_4c_Clfiscals)
613:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
614:         WITH loc_oPagina.lbl_4c_Label7
615:             .Caption   = "Cfop : "
616:             .Top       = 324
617:             .Left      = 269
618:             .FontName  = "Verdana"
619:             .FontSize  = 8
620:             .ForeColor = RGB(36, 84, 155)
621:             .BackStyle = 0
622:             .Visible   = .T.
623:         ENDWITH
624: 
625:         loc_oPagina.AddObject("txt_4c_Cfop", "TextBox")
626:         WITH loc_oPagina.txt_4c_Cfop
627:             .Top       = 321
628:             .Left      = 311
629:             .Width     = 47
630:             .Height    = 23
631:             .MaxLength = 10
632:             .Format    = "K!"
633:             .FontName  = "Verdana"
634:             .FontSize  = 8
635:             .Value     = ""
636:             .Visible   = .T.
637:         ENDWITH
638:         BINDEVENT(loc_oPagina.txt_4c_Cfop, "KeyPress", THIS, "ValidarCfop")
639: 
640:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
641:         WITH loc_oPagina.lbl_4c_Label14
642:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal : "
643:             .Top       = 324
644:             .Left      = 398
645:             .FontName  = "Verdana"
646:             .FontSize  = 8
647:             .ForeColor = RGB(36, 84, 155)
648:             .BackStyle = 0
649:             .Visible   = .T.
650:         ENDWITH
651: 
652:         loc_oPagina.AddObject("txt_4c_Clfiscals", "TextBox")
653:         WITH loc_oPagina.txt_4c_Clfiscals
654:             .Top       = 321
655:             .Left      = 521
656:             .Width     = 111
657:             .Height    = 23
658:             .MaxLength = 10
659:             .Format    = "K!"
660:             .FontName  = "Verdana"

*-- Linhas 667 a 800:
667:         *-- Shape decorativo da secao SAT
668:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
669:         WITH loc_oPagina.shp_4c_Shape1
670:             .Top         = 389
671:             .Left        = 131
672:             .Width       = 505
673:             .Height      = 112
674:             .BackStyle   = 1
675:             .BorderColor = RGB(255, 255, 255)
676:             .Visible     = .T.
677:         ENDWITH
678: 
679:         *-- Label secao Informacoes SAT (Say13)
680:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
681:         WITH loc_oPagina.lbl_4c_Label13
682:             .Caption   = "Informa" + CHR(231) + CHR(245) + "es especificas de Servi" + CHR(231) + "o (SAT)"
683:             .Top       = 374
684:             .Left      = 132
685:             .Width     = 242
686:             .Height    = 15
687:             .FontName  = "Verdana"
688:             .FontSize  = 8
689:             .ForeColor = RGB(36, 84, 155)
690:             .BackStyle = 0
691:             .Visible   = .T.
692:         ENDWITH
693: 
694:         *-- Linha 8: Aliq. ISSQN (Say11 + txt_4c_Issqn)
695:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
696:         WITH loc_oPagina.lbl_4c_Label11
697:             .Caption   = "Aliq. ISSQN (%) : "
698:             .Top       = 399
699:             .Left      = 201
700:             .Width     = 108
701:             .Height    = 15
702:             .FontName  = "Verdana"
703:             .FontSize  = 8
704:             .ForeColor = RGB(36, 84, 155)
705:             .BackStyle = 0
706:             .Visible   = .T.
707:         ENDWITH
708: 
709:         loc_oPagina.AddObject("txt_4c_Issqn", "TextBox")
710:         WITH loc_oPagina.txt_4c_Issqn
711:             .Top       = 396
712:             .Left      = 311
713:             .Width     = 57
714:             .Height    = 23
715:             .InputMask = "999.99"
716:             .FontName  = "Verdana"
717:             .FontSize  = 8
718:             .Value     = 0
719:             .Visible   = .T.
720:         ENDWITH
721: 
722:         *-- Linha 9: Item da Lista de Servicos (Say9 + txt_4c_Itemls)
723:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
724:         WITH loc_oPagina.lbl_4c_Label9
725:             .Caption   = "Item da Lista de Servi" + CHR(231) + "os : "
726:             .Top       = 426
727:             .Left      = 148
728:             .Width     = 161
729:             .Height    = 15
730:             .FontName  = "Verdana"
731:             .FontSize  = 8
732:             .ForeColor = RGB(36, 84, 155)
733:             .BackStyle = 0
734:             .Visible   = .T.
735:         ENDWITH
736: 
737:         loc_oPagina.AddObject("txt_4c_Itemls", "TextBox")
738:         WITH loc_oPagina.txt_4c_Itemls
739:             .Top       = 421
740:             .Left      = 311
741:             .Width     = 57
742:             .Height    = 23
743:             .MaxLength = 5
744:             .FontName  = "Verdana"
745:             .FontSize  = 8
746:             .Value     = ""
747:             .Visible   = .T.
748:         ENDWITH
749: 
750:         *-- Linha 10: Codigo Tributacao (Say10 + txt_4c_CodTrib)
751:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
752:         WITH loc_oPagina.lbl_4c_Label10
753:             .Caption   = "Codigo Tributa" + CHR(231) + CHR(227) + "o : "
754:             .Top       = 451
755:             .Left      = 190
756:             .Width     = 119
757:             .Height    = 15
758:             .FontName  = "Verdana"
759:             .FontSize  = 8
760:             .ForeColor = RGB(36, 84, 155)
761:             .BackStyle = 0
762:             .Visible   = .T.
763:         ENDWITH
764: 
765:         loc_oPagina.AddObject("txt_4c_CodTrib", "TextBox")
766:         WITH loc_oPagina.txt_4c_CodTrib
767:             .Top       = 446
768:             .Left      = 311
769:             .Width     = 179
770:             .Height    = 23
771:             .MaxLength = 20
772:             .FontName  = "Verdana"
773:             .FontSize  = 8
774:             .Value     = ""
775:             .Visible   = .T.
776:         ENDWITH
777: 
778:         *-- Linha 11: Natureza da Operacao (Say12 + txt_4c_NatOpe)
779:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
780:         WITH loc_oPagina.lbl_4c_Label12
781:             .Caption   = "Natureza da Opera" + CHR(231) + CHR(227) + "o : "
782:             .Top       = 475
783:             .Left      = 166
784:             .Width     = 143
785:             .FontName  = "Verdana"
786:             .FontSize  = 8
787:             .ForeColor = RGB(36, 84, 155)
788:             .BackStyle = 0
789:             .Visible   = .T.
790:         ENDWITH
791: 
792:         loc_oPagina.AddObject("txt_4c_NatOpe", "TextBox")
793:         WITH loc_oPagina.txt_4c_NatOpe
794:             .Top       = 471
795:             .Left      = 311
796:             .Width     = 38
797:             .Height    = 23
798:             .MaxLength = 4
799:             .FontName  = "Verdana"
800:             .FontSize  = 8

*-- Linhas 848 a 865:
848:                     .Column9.Width  = 130
849:                     .Column10.Width = 40
850:                     *-- Headers APOS RecordSource (obrigatorio)
851:                     .Column1.Header1.Caption  = "Grupo"
852:                     .Column2.Header1.Caption  = "Estado"
853:                     .Column3.Header1.Caption  = "Aliq. (%)"
854:                     .Column4.Header1.Caption  = "Tipo"
855:                     .Column5.Header1.Caption  = "Tipo Trib."
856:                     .Column6.Header1.Caption  = "CFOP"
857:                     .Column7.Header1.Caption  = "Aliq Iss"
858:                     .Column8.Header1.Caption  = "Item Lista Serv"
859:                     .Column9.Header1.Caption  = "Cod Tributa" + CHR(231) + CHR(227) + "o"
860:                     .Column10.Header1.Caption = "Nat Oper"
861:                 ENDWITH
862: 
863:                 THIS.FormatarGridLista(loc_oGrid)
864:                 loc_lResultado = .T.
865:             ENDIF

*-- Linhas 1534 a 1544:
1534:         loc_oPagina.txt_4c_NatOpe.Enabled    = par_lHabilitar
1535: 
1536:         *-- Botao Confirmar: ativo apenas em INCLUIR/ALTERAR
1537:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1538:             par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1539:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = par_lHabilitar
1540:     ENDPROC
1541: 
1542:     *--------------------------------------------------------------------------
1543:     * BtnIncluirClick - Prepara form para novo registro
1544:     *--------------------------------------------------------------------------

*-- Linhas 1659 a 1671:
1659:                            RECCOUNT("cursor_4c_Dados") > 0
1660: 
1661:         WITH loc_oPg1.cnt_4c_Botoes
1662:             .cmd_4c_Incluir.Enabled    = .T.
1663:             .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1664:             .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1665:             .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1666:             .cmd_4c_Buscar.Enabled     = .T.
1667:             .Visible     = .T.
1668:         ENDWITH
1669:     ENDPROC
1670: 
1671:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\cfiBO.prg):
*==============================================================================
* cfiBO.prg - Business Object para ICMS Cupom Fiscal (SIGCDCFI)
*==============================================================================
* Tabela : SIGCDCFI
* PK     : cidchaves char(20) - gerado via SYS(2015)
* Regra  : unicidade por grupos + ests + clfiscals (ChkRegister original)
*==============================================================================

DEFINE CLASS cfiBO AS BusinessBase

    *-- Chave primaria
    this_cCidchaves  = ""

    *-- Campos da tabela SIGCDCFI
    this_cEsts       = ""   && char(2)  - Estado (FK SigCdUfs.Estados)
    this_cGrupos     = ""   && char(3)  - Grupo (FK SigCdGrp.Cgrus)
    this_nIcms       = 0    && numeric(5,2) - Aliquota ICMS
    this_cTpicms     = ""   && char(1)  - Tipo ICMS: T/S/I/N/F
    this_cTptribs    = ""   && char(4)  - Tipo Tributacao (FK SigPrTri.Tipos)
    this_nOrdicms    = 0    && numeric(2,0) - Ordem ICMS
    this_cSittricms  = ""   && char(3)  - Situacao Tributaria ICMS (FK SigCdIcm.Codigos)
    this_cCfops      = ""   && char(10) - CFOP (FK SigCdCfo.codigos)
    this_cCodtrib    = ""   && char(20) - Codigo Tributacao
    this_nIssqn      = 0    && numeric(5,2) - Aliquota ISSQN
    this_cItemls     = ""   && char(5)  - Item da Lista de Servicos
    this_cNatope     = ""   && char(2)  - Natureza da Operacao
    this_cClfiscals  = ""   && char(10) - Classificacao Fiscal (FK SigCdClf.Codigos)

    *-- Campos de exibicao (lookup - nao armazenados em SIGCDCFI)
    this_cDgrus      = ""   && Descricao do Grupo (SigCdGrp.Dgrus)
    this_cDsittricms = ""   && Descricao Sit. Tributaria (SigCdIcm.Descricaos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SIGCDCFI"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cEsts       = TratarNulo(ests,       "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_nIcms       = TratarNulo(icms,       "N")
            THIS.this_cTpicms     = TratarNulo(tpicms,     "C")
            THIS.this_cTptribs    = TratarNulo(tptribs,    "C")
            THIS.this_nOrdicms    = TratarNulo(ordicms,    "N")
            THIS.this_cSittricms  = TratarNulo(sittricms,  "C")
            THIS.this_cCfops      = TratarNulo(cfops,      "C")
            THIS.this_cCodtrib    = TratarNulo(codtrib,    "C")
            THIS.this_nIssqn      = TratarNulo(issqn,      "N")
            THIS.this_cItemls     = TratarNulo(itemls,     "C")
            THIS.this_cNatope     = TratarNulo(natope,     "C")
            THIS.this_cClfiscals  = TratarNulo(clfiscals,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com filtro opcional
    * par_cFiltro: string WHERE extra (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.ests, a.tpicms"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros de ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela PK (cidchaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidchaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Valida unicidade por grupos+ests+clfiscals
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
    *--------------------------------------------------------------------------
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SIGCDCFI" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos) + ;
                       " AND ests = " + EscaparSQL(THIS.this_cEsts) + ;
                       " AND clfiscals = " + EscaparSQL(THIS.this_cClfiscals)

            IF THIS.this_lNovoRegistro = .F.
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResult >= 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidchaves = LEFT(SYS(2015), 20)

            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCFI" + ;
                           " (cidchaves, ests, grupos, icms, tpicms, tptribs," + ;
                           "  ordicms, sittricms, cfops, codtrib, issqn," + ;
                           "  itemls, natope, clfiscals)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                           EscaparSQL(THIS.this_cEsts)      + ", " + ;
                           EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIcms)   + ", " + ;
                           EscaparSQL(THIS.this_cTpicms)    + ", " + ;
                           EscaparSQL(THIS.this_cTptribs)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdicms) + ", " + ;
                           EscaparSQL(THIS.this_cSittricms) + ", " + ;
                           EscaparSQL(THIS.this_cCfops)     + ", " + ;
                           EscaparSQL(THIS.this_cCodtrib)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIssqn)  + ", " + ;
                           EscaparSQL(THIS.this_cItemls)    + ", " + ;
                           EscaparSQL(THIS.this_cNatope)    + ", " + ;
                           EscaparSQL(THIS.this_cClfiscals) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao incluir ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SIGCDCFI SET" + ;
                           " ests      = " + EscaparSQL(THIS.this_cEsts)      + "," + ;
                           " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + "," + ;
                           " icms      = " + FormatarNumeroSQL(THIS.this_nIcms)   + "," + ;
                           " tpicms    = " + EscaparSQL(THIS.this_cTpicms)    + "," + ;
                           " tptribs   = " + EscaparSQL(THIS.this_cTptribs)   + "," + ;
                           " ordicms   = " + FormatarNumeroSQL(THIS.this_nOrdicms) + "," + ;
                           " sittricms = " + EscaparSQL(THIS.this_cSittricms) + "," + ;
                           " cfops     = " + EscaparSQL(THIS.this_cCfops)     + "," + ;
                           " codtrib   = " + EscaparSQL(THIS.this_cCodtrib)   + "," + ;
                           " issqn     = " + FormatarNumeroSQL(THIS.this_nIssqn)  + "," + ;
                           " itemls    = " + EscaparSQL(THIS.this_cItemls)    + "," + ;
                           " natope    = " + EscaparSQL(THIS.this_cNatope)    + "," + ;
                           " clfiscals = " + EscaparSQL(THIS.this_cClfiscals) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCFI" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

