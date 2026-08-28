# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 200: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 300: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 337: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 427: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 452: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormObs.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1503 linhas total):

*-- Linhas 55 a 63:
55:         loc_lResultado = .F.
56: 
57:         TRY
58:             THIS.Caption = "Cadastro de Observa" + CHR(231) + CHR(245) + "es"
59: 
60:             THIS.this_oBusinessObject = CREATEOBJECT("ObsBO")
61: 
62:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
63:                 MsgErro("Falha ao criar ObsBO", "Erro")

*-- Linhas 71 a 80:
71: 
72:                 THIS.ConfigurarPageFrame()
73: 
74:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
75:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
76: 
77:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
78:                     THIS.CarregarLista()
79:                 ENDIF
80: 

*-- Linhas 100 a 117:
100: 
101:         WITH loc_oPgf
102:             .PageCount = 2
103:             .Top       = -29
104:             .Left      = 0
105:             .Width     = THIS.Width
106:             .Height    = THIS.Height + 29
107:             .Tabs      = .F.
108:             .Visible   = .T.
109:             .Page1.Caption   = "Lista"
110:             .Page1.BackColor = RGB(100, 100, 100)
111:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page2.Caption   = "Dados"
113:             .Page2.BackColor = RGB(100, 100, 100)
114:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115:         ENDWITH
116: 
117:         THIS.ConfigurarPaginaLista()

*-- Linhas 126 a 360:
126:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
127:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
128: 
129:         *-- Container cabecalho (cntSombra.Top=1 no original + 29 compensacao = 30)
130:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
131:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
132:         WITH loc_oCab
133:             .Top         = 30
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
144:             .AutoSize  = .F.
145:             .Caption   = THIS.Caption
146:             .Top       = 15
147:             .Left      = 10
148:             .Width     = THIS.Width
149:             .Height    = 40
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
160:             .AutoSize  = .F.
161:             .Caption   = THIS.Caption
162:             .Top       = 18
163:             .Left      = 10
164:             .Width     = THIS.Width
165:             .Height    = 46
166:             .FontName  = "Tahoma"
167:             .FontSize  = 16
168:             .FontBold  = .T.
169:             .ForeColor = RGB(255, 255, 255)
170:             .BackStyle = 0
171:             .Visible   = .T.
172:         ENDWITH
173: 
174:         *-- Container botoes CRUD (Grupo_op.Left=543, Top=0+29=29)
175:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
176:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
177:         WITH loc_oBotoes
178:             .Top         = 29
179:             .Left        = 542
180:             .Width       = 390
181:             .Height      = 85
182:             .BackColor   = RGB(53, 53, 53)
183:             .BackStyle   = 1
184:             .BorderWidth = 0
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         *-- Botao Incluir
189:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
190:         WITH loc_oBotoes.cmd_4c_Incluir
191:             .Caption         = "Incluir"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
193:             .PicturePosition = 13
194:             .Top             = 5
195:             .Left            = 5
196:             .Width           = 75
197:             .Height          = 75
198:             .BackColor       = RGB(255, 255, 255)
199:             .ForeColor       = RGB(90, 90, 90)
200:             .FontName        = "Comic Sans MS"
201:             .FontSize        = 8
202:             .FontBold        = .T.
203:             .FontItalic      = .T.
204:             .Themes          = .F.
205:             .SpecialEffect   = 0
206:             .MousePointer    = 15
207:             .WordWrap        = .T.
208:             .AutoSize        = .F.
209:             .Visible         = .T.
210:         ENDWITH
211:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
212: 
213:         *-- Botao Visualizar
214:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
215:         WITH loc_oBotoes.cmd_4c_Visualizar
216:             .Caption         = "Visualizar"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 80
221:             .Width           = 75
222:             .Height          = 75
223:             .BackColor       = RGB(255, 255, 255)
224:             .ForeColor       = RGB(90, 90, 90)
225:             .FontName        = "Comic Sans MS"
226:             .FontSize        = 8
227:             .FontBold        = .T.
228:             .FontItalic      = .T.
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:             .WordWrap        = .T.
233:             .AutoSize        = .F.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
237: 
238:         *-- Botao Alterar
239:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
240:         WITH loc_oBotoes.cmd_4c_Alterar
241:             .Caption         = "Alterar"
242:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
243:             .PicturePosition = 13
244:             .Top             = 5
245:             .Left            = 155
246:             .Width           = 75
247:             .Height          = 75
248:             .BackColor       = RGB(255, 255, 255)
249:             .ForeColor       = RGB(90, 90, 90)
250:             .FontName        = "Comic Sans MS"
251:             .FontSize        = 8
252:             .FontBold        = .T.
253:             .FontItalic      = .T.
254:             .Themes          = .F.
255:             .SpecialEffect   = 0
256:             .MousePointer    = 15
257:             .WordWrap        = .T.
258:             .AutoSize        = .F.
259:             .Visible         = .T.
260:         ENDWITH
261:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
262: 
263:         *-- Botao Excluir
264:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
265:         WITH loc_oBotoes.cmd_4c_Excluir
266:             .Caption         = "Excluir"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 230
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
286:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
287: 
288:         *-- Botao Buscar
289:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
290:         WITH loc_oBotoes.cmd_4c_Buscar
291:             .Caption         = "Buscar"
292:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
293:             .PicturePosition = 13
294:             .Top             = 5
295:             .Left            = 305
296:             .Width           = 75
297:             .Height          = 75
298:             .BackColor       = RGB(255, 255, 255)
299:             .ForeColor       = RGB(90, 90, 90)
300:             .FontName        = "Comic Sans MS"
301:             .FontSize        = 8
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .Themes          = .F.
305:             .SpecialEffect   = 0
306:             .MousePointer    = 15
307:             .WordWrap        = .T.
308:             .AutoSize        = .F.
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
312: 
313:         *-- Container Encerrar - padrao canonico (CLAUDE.md regra #10)
314:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
315:         loc_oSaida = loc_oPg1.cnt_4c_Saida
316:         WITH loc_oSaida
317:             .Top         = 29
318:             .Left        = 917
319:             .Width       = 90
320:             .Height      = 85
321:             .BackStyle   = 0
322:             .BorderWidth = 0
323:             .Visible     = .T.
324:         ENDWITH
325: 
326:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
327:         WITH loc_oSaida.cmd_4c_Encerrar
328:             .Caption         = "Encerrar"
329:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:             .PicturePosition = 13
331:             .Top             = 5
332:             .Left            = 5
333:             .Width           = 75
334:             .Height          = 75
335:             .BackColor       = RGB(255, 255, 255)
336:             .ForeColor       = RGB(90, 90, 90)
337:             .FontName        = "Comic Sans MS"
338:             .FontSize        = 8
339:             .FontBold        = .T.
340:             .FontItalic      = .T.
341:             .Themes          = .F.
342:             .SpecialEffect   = 0
343:             .MousePointer    = 15
344:             .WordWrap        = .T.
345:             .AutoSize        = .F.
346:             .Visible         = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
349: 
350:         *-- Grid de listagem (Top=117: 88+29 compensacao, Left=12 do original)
351:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
352:         loc_oGrid = loc_oPg1.grd_4c_Lista
353:         WITH loc_oGrid
354:             .Top                = 117
355:             .Left               = 12
356:             .Width              = 894
357:             .Height             = 455
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16

*-- Linhas 376 a 393:
376:         WITH loc_oGrid
377:             .Column1.Width           = 50
378:             .Column1.Alignment       = 2
379:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
380:             .Column2.Width           = 450
381:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
382:             .Column3.Width           = 90
383:             .Column3.Alignment       = 2
384:             .Column3.Header1.Caption = "Pg.Comiss" + CHR(227) + "o"
385:             .Column4.Width           = 80
386:             .Column4.Header1.Caption = "Grupo"
387:             .Column5.Width           = 80
388:             .Column5.Header1.Caption = "Agrupam."
389:         ENDWITH
390: 
391:         THIS.TornarControlesVisiveis(loc_oPg1)
392:     ENDPROC
393: 

*-- Linhas 399 a 478:
399:         LOCAL loc_oPg2, loc_oBotoesAcao
400:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
401: 
402:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva.Left=819, Top=7+29=36)
403:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
404:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
405:         WITH loc_oBotoesAcao
406:             .Top         = 36
407:             .Left        = 819
408:             .Width       = 165
409:             .Height      = 85
410:             .BackStyle   = 0
411:             .BorderWidth = 0
412:             .Visible     = .T.
413:         ENDWITH
414: 
415:         *-- Botao Confirmar (salva.Left=5, Top=5)
416:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
417:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
418:             .Caption         = "Confirmar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 5
423:             .Width           = 75
424:             .Height          = 75
425:             .BackColor       = RGB(255, 255, 255)
426:             .ForeColor       = RGB(90, 90, 90)
427:             .FontName        = "Comic Sans MS"
428:             .FontSize        = 8
429:             .FontBold        = .T.
430:             .FontItalic      = .T.
431:             .Themes          = .F.
432:             .SpecialEffect   = 0
433:             .MousePointer    = 15
434:             .WordWrap        = .T.
435:             .AutoSize        = .F.
436:             .Visible         = .T.
437:         ENDWITH
438:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
439: 
440:         *-- Botao Cancelar (cancelar.Left=81, Top=5)
441:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
442:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
443:             .Caption         = "Encerrar"
444:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
445:             .PicturePosition = 13
446:             .Top             = 5
447:             .Left            = 81
448:             .Width           = 75
449:             .Height          = 75
450:             .BackColor       = RGB(255, 255, 255)
451:             .ForeColor       = RGB(90, 90, 90)
452:             .FontName        = "Comic Sans MS"
453:             .FontSize        = 8
454:             .FontBold        = .T.
455:             .FontItalic      = .T.
456:             .Themes          = .F.
457:             .SpecialEffect   = 0
458:             .MousePointer    = 15
459:             .WordWrap        = .T.
460:             .AutoSize        = .F.
461:             .Visible         = .T.
462:         ENDWITH
463:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
464: 
465:         *-- ===== ROW 1: Codigo | Grupo | Agrupamento | Movimentacao Automatica =====
466:         *-- Compensacao PageFrame.Top=-29: Tops originais + 29
467: 
468:         *-- Label Codigo (Say1: Left=55, Top=31 -> 60)
469:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
470:         WITH loc_oPg2.lbl_4c_Codigo
471:             .Caption   = "C" + CHR(243) + "digo :"
472:             .Left      = 55
473:             .Top       = 60
474:             .Width     = 40
475:             .Height    = 17
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 486 a 510:
486:             .Value         = 0
487:             .InputMask     = "999"
488:             .Alignment     = 3
489:             .Left          = 100
490:             .Top           = 57
491:             .Width         = 37
492:             .Height        = 23
493:             .FontName      = "Tahoma"
494:             .FontSize      = 8
495:             .ForeColor     = RGB(90, 90, 90)
496:             .SpecialEffect = 1
497:             .Visible       = .T.
498:         ENDWITH
499: 
500:         *-- Label Grupo (Say7: Left=154, Top=31 -> 60)
501:         loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
502:         WITH loc_oPg2.lbl_4c_Grupo
503:             .Caption   = "Grupo :"
504:             .Left      = 154
505:             .Top       = 60
506:             .Width     = 37
507:             .Height    = 17
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 516 a 540:
516:         loc_oPg2.AddObject("txt_4c_Grupos", "TextBox")
517:         WITH loc_oPg2.txt_4c_Grupos
518:             .Value         = ""
519:             .Left          = 194
520:             .Top           = 57
521:             .Width         = 80
522:             .Height        = 23
523:             .FontName      = "Tahoma"
524:             .FontSize      = 8
525:             .ForeColor     = RGB(90, 90, 90)
526:             .SpecialEffect = 1
527:             .Visible       = .T.
528:         ENDWITH
529: 
530:         *-- Label Agrupamento (Say8: Left=293, Top=32 -> 61)
531:         loc_oPg2.AddObject("lbl_4c_Agrupamento", "Label")
532:         WITH loc_oPg2.lbl_4c_Agrupamento
533:             .Caption   = "Agrupamento :"
534:             .Left      = 293
535:             .Top       = 61
536:             .Width     = 77
537:             .Height    = 17
538:             .FontName  = "Tahoma"
539:             .FontSize  = 8
540:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 547 a 571:
547:         WITH loc_oPg2.txt_4c_Agrupas
548:             .Value         = ""
549:             .InputMask     = "!!!!!!!!!!"
550:             .Left          = 373
551:             .Top           = 57
552:             .Width         = 80
553:             .Height        = 23
554:             .FontName      = "Tahoma"
555:             .FontSize      = 8
556:             .ForeColor     = RGB(90, 90, 90)
557:             .SpecialEffect = 1
558:             .Visible       = .T.
559:         ENDWITH
560: 
561:         *-- Label Movimentacao Automatica (Say3: Left=481, Top=32 -> 61)
562:         loc_oPg2.AddObject("lbl_4c_MovAut", "Label")
563:         WITH loc_oPg2.lbl_4c_MovAut
564:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Automatica :"
565:             .Left      = 481
566:             .Top       = 61
567:             .Width     = 133
568:             .Height    = 17
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 578 a 587:
578:         loc_oPg2.AddObject("txt_4c_MovAutDop", "TextBox")
579:         WITH loc_oPg2.txt_4c_MovAutDop
580:             .Value         = ""
581:             .Left          = 621
582:             .Top           = 57
583:             .Width         = 192
584:             .Height        = 23
585:             .FontName      = "Tahoma"
586:             .FontSize      = 8
587:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 593 a 605:
593:         *-- ===== ROW 2: Observacao (EditBox/memo) =====
594: 
595:         *-- Label Observacao (Say2: Left=30, Top=56 -> 85)
596:         loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
597:         WITH loc_oPg2.lbl_4c_Observacao
598:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
599:             .Left      = 30
600:             .Top       = 85
601:             .Width     = 65
602:             .Height    = 17
603:             .FontName  = "Tahoma"
604:             .FontSize  = 8
605:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 611 a 637:
611:         loc_oPg2.AddObject("edt_4c_Observas", "EditBox")
612:         WITH loc_oPg2.edt_4c_Observas
613:             .Value         = ""
614:             .Left          = 100
615:             .Top           = 85
616:             .Width         = 713
617:             .Height        = 179
618:             .FontName      = "Tahoma"
619:             .FontSize      = 8
620:             .ForeColor     = RGB(90, 90, 90)
621:             .SpecialEffect = 1
622:             .Visible       = .T.
623:         ENDWITH
624: 
625:         *-- ===== ROW 3: Descricao =====
626: 
627:         *-- Label Descricao (Say5: Left=42, Top=241 -> 270)
628:         loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
629:         WITH loc_oPg2.lbl_4c_Descricao
630:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
631:             .Left      = 42
632:             .Top       = 270
633:             .Width     = 55
634:             .Height    = 17
635:             .FontName  = "Tahoma"
636:             .FontSize  = 8
637:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 643 a 669:
643:         loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
644:         WITH loc_oPg2.txt_4c_Descrs
645:             .Value         = ""
646:             .Left          = 100
647:             .Top           = 267
648:             .Width         = 713
649:             .Height        = 23
650:             .FontName      = "Tahoma"
651:             .FontSize      = 8
652:             .ForeColor     = RGB(90, 90, 90)
653:             .SpecialEffect = 1
654:             .Visible       = .T.
655:         ENDWITH
656: 
657:         *-- ===== ROW 4: Paga Comissao + Classificacao =====
658: 
659:         *-- Label Paga Comissao (Say4: Left=119, Top=272 -> 301)
660:         loc_oPg2.AddObject("lbl_4c_PagaComissao", "Label")
661:         WITH loc_oPg2.lbl_4c_PagaComissao
662:             .Caption   = "Paga Comiss" + CHR(227) + "o :"
663:             .Left      = 119
664:             .Top       = 301
665:             .Width     = 78
666:             .Height    = 17
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 678 a 722:
678:             .BackStyle   = 0
679:             .BorderStyle = 0
680:             .Height      = 27
681:             .Left        = 200
682:             .Top         = 296
683:             .Width       = 101
684:             .Value       = 1
685:             .Visible     = .T.
686:         ENDWITH
687:         WITH loc_oPg2.opt_4c_PagaComiss.Buttons(1)
688:             .Caption   = "Sim"
689:             .Height    = 17
690:             .Left      = 5
691:             .Top       = 5
692:             .Width     = 40
693:             .AutoSize  = .F.
694:             .FontName  = "Tahoma"
695:             .FontSize  = 8
696:             .ForeColor = RGB(90, 90, 90)
697:             .BackStyle = 0
698:         ENDWITH
699:         WITH loc_oPg2.opt_4c_PagaComiss.Buttons(2)
700:             .Caption   = "N" + CHR(227) + "o"
701:             .Height    = 17
702:             .Left      = 51
703:             .Top       = 5
704:             .Width     = 40
705:             .AutoSize  = .F.
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .ForeColor = RGB(90, 90, 90)
709:             .BackStyle = 0
710:         ENDWITH
711: 
712:         *-- Label Classificacao (Say6: Left=391, Top=272 -> 301)
713:         loc_oPg2.AddObject("lbl_4c_Classificacao", "Label")
714:         WITH loc_oPg2.lbl_4c_Classificacao
715:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o : "
716:             .Left      = 391
717:             .Top       = 301
718:             .Width     = 72
719:             .Height    = 17
720:             .FontName  = "Tahoma"
721:             .FontSize  = 8
722:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 733 a 984:
733:             .BackStyle   = 0
734:             .BorderStyle = 0
735:             .Height      = 27
736:             .Left        = 465
737:             .Top         = 296
738:             .Width       = 205
739:             .Value       = 1
740:             .Visible     = .T.
741:         ENDWITH
742:         WITH loc_oPg2.opt_4c_Classif.Buttons(1)
743:             .Caption   = "Grave"
744:             .Height    = 15
745:             .Left      = 5
746:             .Top       = 5
747:             .Width     = 47
748:             .AutoSize  = .T.
749:             .FontName  = "Tahoma"
750:             .FontSize  = 8
751:             .ForeColor = RGB(90, 90, 90)
752:             .BackStyle = 0
753:         ENDWITH
754:         WITH loc_oPg2.opt_4c_Classif.Buttons(2)
755:             .Caption   = "Leve"
756:             .Height    = 15
757:             .Left      = 75
758:             .Top       = 5
759:             .Width     = 41
760:             .AutoSize  = .T.
761:             .FontName  = "Tahoma"
762:             .FontSize  = 8
763:             .ForeColor = RGB(90, 90, 90)
764:             .BackStyle = 0
765:         ENDWITH
766:         WITH loc_oPg2.opt_4c_Classif.Buttons(3)
767:             .Caption   = "Interno"
768:             .Height    = 17
769:             .Left      = 134
770:             .Top       = 5
771:             .Width     = 61
772:             .AutoSize  = .F.
773:             .FontName  = "Tahoma"
774:             .FontSize  = 8
775:             .ForeColor = RGB(90, 90, 90)
776:             .BackStyle = 0
777:         ENDWITH
778: 
779:         *-- ===== CONTAINER COMANDOS ESPECIAIS =====
780:         *-- Container1: Left=121, Top=311->340, Width=671, Height=276, BackColor amarelo
781:         loc_oPg2.AddObject("cnt_4c_Container1", "Container")
782:         WITH loc_oPg2.cnt_4c_Container1
783:             .Top         = 340
784:             .Left        = 121
785:             .Width       = 671
786:             .Height      = 276
787:             .BackColor   = RGB(255, 253, 179)
788:             .BorderWidth = 0
789:             .Visible     = .T.
790:         ENDWITH
791: 
792:         *-- Say15: "Comandos Especiais:" (Bold, Left=13, Top=9)
793:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdEsp", "Label")
794:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdEsp
795:             .Caption   = "Comandos Especiais:"
796:             .Left      = 13
797:             .Top       = 9
798:             .Width     = 150
799:             .Height    = 17
800:             .FontName  = "Tahoma"
801:             .FontSize  = 9
802:             .FontBold  = .T.
803:             .ForeColor = RGB(90, 90, 90)
804:             .BackStyle = 0
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         *-- Say17: instrucao geral (Bold, Left=13, Top=29)
809:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdInserir", "Label")
810:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdInserir
811:             .Caption   = "Para inserir automaticamente em uma observa" + CHR(231) + CHR(227) + "o..."
812:             .Left      = 13
813:             .Top       = 29
814:             .Width     = 450
815:             .Height    = 17
816:             .FontName  = "Tahoma"
817:             .FontSize  = 9
818:             .FontBold  = .T.
819:             .ForeColor = RGB(90, 90, 90)
820:             .BackStyle = 0
821:             .Visible   = .T.
822:         ENDWITH
823: 
824:         *-- Say3: simbolo # (Left=50, Top=52)
825:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdNumDoc", "Label")
826:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdNumDoc
827:             .Caption   = "...o n" + CHR(250) + "mero do documento da opera" + CHR(231) + CHR(227) + "o utilizada indicar com o simbolo # "
828:             .Left      = 50
829:             .Top       = 52
830:             .Width     = 590
831:             .Height    = 17
832:             .FontName  = "Tahoma"
833:             .FontSize  = 9
834:             .ForeColor = RGB(90, 90, 90)
835:             .BackStyle = 0
836:             .Visible   = .T.
837:         ENDWITH
838: 
839:         *-- Say9: simbolo $ (Left=50, Top=72)
840:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdSerieNota", "Label")
841:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdSerieNota
842:             .Caption   = "...serie + Nota utilizada indicar com o simbolo $ "
843:             .Left      = 50
844:             .Top       = 72
845:             .Width     = 450
846:             .Height    = 17
847:             .FontName  = "Tahoma"
848:             .FontSize  = 9
849:             .ForeColor = RGB(90, 90, 90)
850:             .BackStyle = 0
851:             .Visible   = .T.
852:         ENDWITH
853: 
854:         *-- Say10: simbolo ^% (Left=50, Top=92)
855:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdNota", "Label")
856:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdNota
857:             .Caption   = "...dados da Nota do SubN" + CHR(237) + "vel indicar com o simbolo ^%"
858:             .Left      = 50
859:             .Top       = 92
860:             .Width     = 450
861:             .Height    = 17
862:             .FontName  = "Tahoma"
863:             .FontSize  = 9
864:             .ForeColor = RGB(90, 90, 90)
865:             .BackStyle = 0
866:             .Visible   = .T.
867:         ENDWITH
868: 
869:         *-- Say11: simbolo ^! (Left=50, Top=112)
870:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdSubNivel", "Label")
871:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdSubNivel
872:             .Caption   = "...a relacao dos SubN" + CHR(237) + "veis Utilizados indicar com o simbolo ^!"
873:             .Left      = 50
874:             .Top       = 112
875:             .Width     = 490
876:             .Height    = 17
877:             .FontName  = "Tahoma"
878:             .FontSize  = 9
879:             .ForeColor = RGB(90, 90, 90)
880:             .BackStyle = 0
881:             .Visible   = .T.
882:         ENDWITH
883: 
884:         *-- Say4: simbolo ^N! (Left=50, Top=131)
885:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdSubNivelN", "Label")
886:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdSubNivelN
887:             .Caption   = "...a relacao do SubN" + CHR(237) + "vel do SubN" + CHR(237) + "vel Utilizados indicar com o simbolo ^N!"
888:             .Left      = 50
889:             .Top       = 131
890:             .Width     = 560
891:             .Height    = 17
892:             .FontName  = "Tahoma"
893:             .FontSize  = 9
894:             .ForeColor = RGB(90, 90, 90)
895:             .BackStyle = 0
896:             .Visible   = .T.
897:         ENDWITH
898: 
899:         *-- Say12: simbolo @ (Left=50, Top=150)
900:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdEnderecos", "Label")
901:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdEnderecos
902:             .Caption   = "...dados de endere" + CHR(231) + "os, use o s" + CHR(237) + "mbolo @"
903:             .Left      = 50
904:             .Top       = 150
905:             .Width     = 400
906:             .Height    = 17
907:             .FontName  = "Tahoma"
908:             .FontSize  = 9
909:             .ForeColor = RGB(90, 90, 90)
910:             .BackStyle = 0
911:             .Visible   = .T.
912:         ENDWITH
913: 
914:         *-- Say13: simbolo ^V (Left=50, Top=170)
915:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdVendedor", "Label")
916:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdVendedor
917:             .Caption   = "...dados do vendedor, use o s" + CHR(237) + "mbolo ^V"
918:             .Left      = 50
919:             .Top       = 170
920:             .Width     = 400
921:             .Height    = 17
922:             .FontName  = "Tahoma"
923:             .FontSize  = 9
924:             .ForeColor = RGB(90, 90, 90)
925:             .BackStyle = 0
926:             .Visible   = .T.
927:         ENDWITH
928: 
929:         *-- Say14: simbolo ^$ (Left=50, Top=190)
930:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdAlqRed", "Label")
931:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdAlqRed
932:             .Caption   = "...mensagem para Al" + CHR(237) + "quota reduzida de ICMS, use o s" + CHR(237) + "mbolo ^$"
933:             .Left      = 50
934:             .Top       = 190
935:             .Width     = 500
936:             .Height    = 17
937:             .FontName  = "Tahoma"
938:             .FontSize  = 9
939:             .ForeColor = RGB(90, 90, 90)
940:             .BackStyle = 0
941:             .Visible   = .T.
942:         ENDWITH
943: 
944:         *-- Say16: simbolo ^D (Left=50, Top=210)
945:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdDtVenc", "Label")
946:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdDtVenc
947:             .Caption   = "...observa" + CHR(231) + CHR(227) + "o mensagem para Datas de Vencimento, use o s" + CHR(237) + "mbolo ^D"
948:             .Left      = 50
949:             .Top       = 210
950:             .Width     = 560
951:             .Height    = 17
952:             .FontName  = "Tahoma"
953:             .FontSize  = 9
954:             .ForeColor = RGB(90, 90, 90)
955:             .BackStyle = 0
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         *-- Say1: simbolo ^> (Left=50, Top=229)
960:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdIcmsVal", "Label")
961:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdIcmsVal
962:             .Caption   = "...valor do ICMS a recuperar para n" + CHR(227) + "o inscritos no Simples Nacional use o s" + CHR(237) + "mbolo ^>"
963:             .Left      = 50
964:             .Top       = 229
965:             .Width     = 600
966:             .Height    = 17
967:             .FontName  = "Tahoma"
968:             .FontSize  = 9
969:             .ForeColor = RGB(90, 90, 90)
970:             .BackStyle = 0
971:             .Visible   = .T.
972:         ENDWITH
973: 
974:         *-- Say2: simbolo ^< (Left=50, Top=249)
975:         loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdIcmsAlq", "Label")
976:         WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdIcmsAlq
977:             .Caption   = "...Al" + CHR(237) + "quota do ICMS a recuperar para n" + CHR(227) + "o inscritos no Simples Nacional use o s" + CHR(237) + "mbolo ^<"
978:             .Left      = 50
979:             .Top       = 249
980:             .Width     = 610
981:             .Height    = 17
982:             .FontName  = "Tahoma"
983:             .FontSize  = 9
984:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1077 a 1094:
1077:                     *-- Larguras e Headers APOS RecordSource (Problema 32)
1078:                     loc_oGrid.Column1.Width           = 50
1079:                     loc_oGrid.Column1.Alignment       = 2
1080:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1081:                     loc_oGrid.Column2.Width           = 450
1082:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
1083:                     loc_oGrid.Column3.Width           = 90
1084:                     loc_oGrid.Column3.Alignment       = 2
1085:                     loc_oGrid.Column3.Header1.Caption = "Pg.Comiss" + CHR(227) + "o"
1086:                     loc_oGrid.Column4.Width           = 80
1087:                     loc_oGrid.Column4.Header1.Caption = "Grupo"
1088:                     loc_oGrid.Column5.Width           = 80
1089:                     loc_oGrid.Column5.Header1.Caption = "Agrupam."
1090: 
1091:                     THIS.FormatarGridLista(loc_oGrid)
1092:                     loc_lResultado = .T.
1093:                 ENDIF
1094:             ENDIF

*-- Linhas 1273 a 1281:
1273:         loc_oPg2.opt_4c_Classif.Enabled    = par_lHabilitar
1274: 
1275:         *-- Confirmar: disponivel apenas em INCLUIR/ALTERAR
1276:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1277:     ENDPROC
1278: 
1279:     *--------------------------------------------------------------------------
1280:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD da Page1
1281:     *--------------------------------------------------------------------------

*-- Linhas 1287 a 1299:
1287:                            RECCOUNT("cursor_4c_Dados") > 0 AND ;
1288:                            !EOF("cursor_4c_Dados")
1289: 
1290:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
1291:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1292:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1293:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1294:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
1295:     ENDPROC
1296: 
1297:     *--------------------------------------------------------------------------
1298:     * BtnIncluirClick - Inicia inclusao de novo registro
1299:     * Handler PUBLIC para BINDEVENT (Problema 17)

*-- Linhas 1372 a 1380:
1372:         THIS.AlternarPagina(2)
1373: 
1374:         TRY
1375:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
1376:         CATCH
1377:         ENDTRY
1378:     ENDPROC
1379: 
1380:     *--------------------------------------------------------------------------

*-- Linhas 1430 a 1438:
1430:         loc_oPg2.txt_4c_MovAutDop.ReadOnly         = .T.
1431:         loc_oPg2.opt_4c_PagaComiss.Enabled         = .F.
1432:         loc_oPg2.opt_4c_Classif.Enabled            = .F.
1433:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1434: 
1435:         THIS.AlternarPagina(2)
1436: 
1437:         TRY
1438:             loc_oPg2.txt_4c_Codigos.SetFocus()


### BO (C:\4c\projeto\app\classes\ObsBO.prg):
*====================================================================
* ObsBO.prg
*
* Business Object para Cadastro de Observacoes
* Tabela: SigCdObs
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ObsBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdObs)
    this_nCodigos    = 0     && Codigos numeric(3,0) - PK
    this_cDescrs     = ""    && descrs  char
    this_cObservas   = ""    && Observas memo
    this_cGrupos     = ""    && grupos  char
    this_cAgrupas    = ""    && agrupas char
    this_nComiss     = 0     && Comiss  numeric (1=Sim, 2=Nao)
    this_nClassifs   = 0     && Classifs numeric (1=Grave, 2=Leve, 3=Interno)
    this_cMovAutDop  = ""    && MovAutDop char (lookup SigCdOpe.Dopes)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdObs"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria (PUBLIC)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * Buscar - Carrega lista de registros no cursor_4c_Dados (PUBLIC)
    * par_cFiltro: condicao WHERE sem "WHERE" (pode ser "")
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs," + ;
                       " CASE WHEN Comiss = 2 THEN 'NAO' ELSE 'SIM' END AS PgComissao," + ;
                       " Grupos, Agrupas" + ;
                       " FROM SigCdObs" + ;
                       loc_cWhere + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       " Grupos, Agrupas, MovAutDop" + ;
                       " FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos   = TratarNulo(codigos,   "N")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cObservas  = TratarNulo(observas,  "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,   "C")
                THIS.this_nComiss    = TratarNulo(comiss,    "N")
                THIS.this_nClassifs  = TratarNulo(classifs,  "N")
                THIS.this_cMovAutDop = TratarNulo(movautdop, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.T.
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdObs" + ;
                       " (Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       "  Grupos, Agrupas, MovAutDop)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cObservas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClassifs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cAgrupas) + ", " + ;
                       EscaparSQL(THIS.this_cMovAutDop) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.F.
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdObs SET" + ;
                       " Descrs    = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " Observas  = " + EscaparSQL(THIS.this_cObservas) + "," + ;
                       " Comiss    = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Classifs  = " + FormatarNumeroSQL(THIS.this_nClassifs) + "," + ;
                       " Grupos    = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Agrupas   = " + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " MovAutDop = " + EscaparSQL(THIS.this_cMovAutDop) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Remove registro da tabela (PROTECTED)
    * Chamado internamente por BusinessBase.Excluir()
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarOperacoesNivel - Carrega cursor para lookup de MovAutDop (PUBLIC)
    * Equivalente ao: Select Dopes,Cmoes,nFiscals,Abrevs From SigCdOpe
    * Usado pelo Form para popular o lookup de Movimentacao Automatica
    *====================================================================
    FUNCTION BuscarOperacoesNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Nivel")
                USE IN cursor_4c_Nivel
            ENDIF

            loc_cSQL = "SELECT Dopes, Cmoes, NFiscals, Abrevs" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE LTRIM(RTRIM(Abrevs)) <> ''" + ;
                       " ORDER BY Dopes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.BuscarOperacoesNivel")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

